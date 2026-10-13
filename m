Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C97CC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 08:02:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8027D60769;
	Tue, 13 Oct 2026 08:02:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PsYJxm-09CTA; Tue, 13 Oct 2026 08:02:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D75186075F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791878561;
	b=pIwTiZswIn40zexMDknPKEuTuieCGOL+AGdGT7Y0TtGfAiJALsGrOx3wRawFX3VVVNLj
	 A1CUE1zhL87oh2H0bkb6IzazmjPo4+wyIo8g6SF2IN9OGsdNecS2lPCzwX5JxosZzq28G
	 XobjAVVOU4ApNToh3wSADjzJBE7jjobh/b8MQzA7IsBlotdlarTsJGHXCXXc4oQZlmKlJ
	 PyVny4CjwQPCYyp8cjMV6slttqHDbjSbBK6dsJ2rVNNdosNuHCEl+Hs0APIzpUzrkEOz8
	 b8MwIAdqFswroc+IMK+H+ukz8BhKjmROZirwx1dBArmvNXlDWFLqAKUeAHITEnNE+tQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791878561;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jM5YgXQqH0uKOX3kj0mcl0U8NNqyMVM94qLIcGycUp8=;
	b=mg+3fjoEMRSYnfJU35IGIVieKG63/r0PtdfiVjpxdYG+6fckQlpXhSoVW3C/4m9zVB55
	 F2cXeLMUcVOMuJyYld+kMgdg+WoqQeq4v0ADJDC8ZPf5lUCHWrI6QBA3d6+PibIOEuOnP
	 equDS+R1wOCNZN14dZTQHjH9M/DGydLNdEBvX30ivtC4ba+3jmSLCICxUfQgwqfE2UAne
	 HWsqmZFTnL4w8S/eZ7mmJDIik1c1FJq2AGzRHd/qOxpNx1Y5CNlkzP9QKWpvUkxuEm9QL
	 bPLltDOzlI5BqlSTbrk+Km0FCJavMDrgiZGiquLFkTgLYON2R3L+Zm47JA/rz69jlMQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791878561;
	bh=jM5YgXQqH0uKOX3kj0mcl0U8NNqyMVM94qLIcGycUp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rtAdYecQA0oo7VRpl4v8nD25HC+SAuUOfG6zj+7D7q5EEK0Wolo7euLb4Hbp3/1DQ
	 aT+YSEw3qktM6Gxbt3T39CmB/OKX5f189o9Am7npxBufwAvvFGHkm6RnI1bne/uKL+
	 LZYpYM/Ib9YPg6uX1/ZB5bpFWEw9K8URJSQ4TpLc9sVHKdJJDbpZmureFwUhnDG7AB
	 xln4zX0yI+dFgzWko23y6S2li6I7rHSaxx6Z5MF9hB3XG+r6eH0Q+nP0/FAjTiX5TY
	 FMJceE7hlLMaDxaieXfB4YaQzMfHJfIm69dTB2+vn6go8VkWmBoYS/MHaq1jg9w1kv
	 wcdVOVHAuNy1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D75186075F;
	Tue, 13 Oct 2026 08:02:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 849D8DE0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:02:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6A98240068
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:02:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ExoEUEg1IrI3 for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 08:02:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CF1304005F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791878558;
 b=bUKU7xdfn9sDv8NxEQxqS+88IGY/bOMToHJ4XrLEhkTAX6XmjvjRAqH7TSmBCdNu2Zcd
 Zznm3+EGiq6SrhjUMiVp6Ug576kVEtVa9Ho7iWFcwieUTPYQASIYDyamVfk+5HXFn1asQ
 RN5szi1I3LEXOu9QUYKYJN51i73RXQqmv6hR93n4l+rVoHRPXzBOnkHEq3ydCd7dIkIfk
 1a2cKP+VkBjaO/qq0JN5WU6oZEoAQ0U5jEWvbBNzCKQSfra8DyVYEIwghj3l8mNgsSdqi
 iman5G22W7ppDsS8iREkRMNT8tJCB3UTTfmysrNh7elF8sBXFv6QyR0lBbIHsPjN/8g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791878558;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=jM5YgXQqH0uKOX3kj0mcl0U8NNqyMVM94qLIcGycUp8=;
 b=WklYKliF/Bnucvys1OU4/EOBMitXeL1zxymP2nik0RXhsJeh7qHWopxPFgmLTGHa7QVQ
 x4leEl5SD+IGXyX4il9+5iWu5bXYkk63RV09bvzQF+tw6zltZbff6XOiawnYKouq2lqP2
 2Tpw7r0H82o+X97A4mKlHOJM0FmcIMXWmwvepd/DCEPz3EvZvl4ke5SSaMlnhVoJ8ZMMI
 CBKVHiaMsY4nTKqF9KPFVqpyRPZchbWVKh8oA+pu2yu4qa/eviX/r2ksBcYoCfSFl6iCS
 uyc67bjwLDYNTarXFiSuQK1z6++e+7ADV77IT0tIXovB2afwHncPEpzxxgKbIsY069A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=XdCd2lrk; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com;
 envelope-from=jim.t90615@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=XdCd2lrk
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CF1304005F
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:02:38 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3ab9268d90eso1151110a91.3
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791878557; x=1792483357;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jM5YgXQqH0uKOX3kj0mcl0U8NNqyMVM94qLIcGycUp8=;
 b=XdCd2lrkrGHetvV2j8UwsyxCnZeO3dDdn3wuh/q+E2zx9oQuvyFxMi+TfnNZHRBQyE
 xaJ5BS+++6BCiwS5boR3qUWwSfqKUZJ6TMzgDuaA0XyyLvT9E+RIx4aVmQF8vueSxHEf
 UpsNvZY3SWSQQhr3qYOz8WTlOQqM5K0336cI47KEYF8uR/qjJUBNiNdJBCTL4gQ+cZfd
 yPPtu42YxmFA+USAbkTNI0hXIfFWoXD/03m8uMboDf12s8+a2mnmPa4sToHIykiwg5eH
 ejFybekChhgnJLhaZrx7b9aEelo9ydPoveXmt8khCYIikU3s13WxCbnVR8pc7o/XrvBr
 GNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791878557; x=1792483357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jM5YgXQqH0uKOX3kj0mcl0U8NNqyMVM94qLIcGycUp8=;
 b=KGHsqhNBPwz1B4COFgTePHkLobmpKxSpRQb+xhnhiyba9klCaXeOQwbCGF1UC33DzO
 9c9ofHpoz9obwpAhqdnrPLYXXcVyHzhzZB3yQtkOjdH+vqecTgtE6k2rqetv/f1BmYKl
 ZH5z89loQSC6zqaxoB32e0/RQUtQteeM7GVfd0UW6l5WFzfohYklEL4mF2GsjVmWRRn3
 aCKhqaSoMosl7ZtFIHriX+MSkarrEU7dnpBDNcg1I9P1n6ZEiSOIGDW17UGfP3ecgtQD
 QREQSLJRpaQ1XBSuwQmpAXwt2za/JdeCnAs43V+xG46vca0y49c0Wc08Bd8qUxTqE7b+
 4rVw==
X-Forwarded-Encrypted: i=1;
 AKwUvByGiOpN2dgzKAl1lYd0LChDJkIYkotZGZgCQj9imCt4MZ1s59j2gdT6/rYvCLYfvbVTES4HAz4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKMDlT/tOImPrxCbxt4u4IwBAj4PX2S9F96d60XDbbfZp8GuQ3h
 oQ8mwZ+htkZr7JsK4asd3IBwnyrRM2y3+dHUsMpsOL8WxYNqEX3PLNNu
X-Gm-Gg: AYBFou2Q+InVKdSCs2uMwtGZ7mxknxkZcsqvSiPkvTGCmFVGNyvgiCtEnZu1laXpdq2
 eWf/Br7GDj3dWYSjyDywSz/7Z401t1AZVBPW/3rX7gETnhjpR+OWizBdUVYF8YbaFqY0d4IrlZh
 wnlteOWGmDJsA7s6PPArAHpNcbeycuho4XK/xzKwApq8tbaB47ReVVClFF1YgABNBqgrnhek1F7
 q88vgPWhtwP3ZpXxOmkGJOvB8kla594H6YiakeuMPTbGkYh5bzXQt4Wl3O0JIKHTVdNc0bB/ofI
 wgt4ovCmqdI4FLw/KeN1k12LIq2A7AbdgeRsMccDNiCQeb6rb4qNvHq7NYDhLz0Xv+RT1Xyf8Rl
 sRe/rhjgOBRdbTyFR2GckkjQjCT4CZqOCaDrELKFQOfBkBDBObi60A+nBkLfa92ITlweGZx5O9t
 7CGnbzSVylwZ9vrUWhWzie4GL44WK/z65lItmCdItk6pjtWbOPbI7XOKi5Ka6U4w9pOSKW0LI/U
 szdLcsO
X-Received: by 2002:a17:90b:3b90:b0:3a4:6e84:e7f1 with SMTP id
 98e67ed59e1d1-3ab3a36553bmr9701311a91.7.1791878557564; 
 Tue, 13 Oct 2026 01:02:37 -0700 (PDT)
Received: from cs20-buildserver.. ([2402:7500:502:876d:a213:c5a0:c1ea:6547])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab3962f771sm9175090a91.2.2026.10.13.01.02.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:02:37 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com,
	jim.t90615@gmail.com,
	trini@konsulko.com
Cc: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 Stanley Chu <yschu@nuvoton.com>
Subject: [PATCH v3 2/6] npcm8xx: remove system timer configuration
Date: Tue, 13 Oct 2026 16:01:50 +0800
Message-Id: <20261013080154.1942483-3-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013080154.1942483-1-JJLIU0@nuvoton.com>
References: <20261013080154.1942483-1-JJLIU0@nuvoton.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The system timer register might be secure and not allow
uboot to access.
BL31 is responsible for the configuration.

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 arch/arm/mach-npcm/npcm8xx/cpu.c | 40 --------------------------------
 1 file changed, 40 deletions(-)

diff --git a/arch/arm/mach-npcm/npcm8xx/cpu.c b/arch/arm/mach-npcm/npcm8xx/cpu.c
index a1fb400b264..4deffb7b845 100644
--- a/arch/arm/mach-npcm/npcm8xx/cpu.c
+++ b/arch/arm/mach-npcm/npcm8xx/cpu.c
@@ -4,34 +4,11 @@
  */
 
 #include <dm.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/arch/gcr.h>
 #include <asm/armv8/mmu.h>
 
-#define SYSCNT_CTRL_BASE_ADDR   0xF07FC000
-#define SC_CNTCR_ENABLE		BIT(0)
-#define SC_CNTCR_HDBG		BIT(1)
-#define SC_CNTCR_FREQ0		BIT(8)
-#define SC_CNTCR_FREQ1		BIT(9)
-
-/* System Counter register map */
-struct sctr_regs {
-	u32 cntcr;
-	u32 cntsr;
-	u32 cntcv1;
-	u32 cntcv2;
-	u32 resv1[4];
-	u32 cntfid0;
-	u32 cntfid1;
-	u32 cntfid2;
-	u32 resv2[1001];
-	u32 counterid[1];
-};
-
-DECLARE_GLOBAL_DATA_PTR;
-
 int print_cpuinfo(void)
 {
 	struct npcm_gcr *gcr = (struct npcm_gcr *)NPCM_GCR_BA;
@@ -125,20 +102,3 @@ static struct mm_region npcm_mem_map[] = {
 };
 
 struct mm_region *mem_map = npcm_mem_map;
-
-int timer_init(void)
-{
-	struct sctr_regs *sctr = (struct sctr_regs *)SYSCNT_CTRL_BASE_ADDR;
-	u32 cntfrq_el0;
-
-	/* Enable system counter */
-	__asm__ __volatile__("mrs %0, CNTFRQ_EL0\n\t" : "=r" (cntfrq_el0) : : "memory");
-	writel(cntfrq_el0, &sctr->cntfid0);
-	clrsetbits_le32(&sctr->cntcr, SC_CNTCR_FREQ0 | SC_CNTCR_FREQ1,
-			SC_CNTCR_ENABLE | SC_CNTCR_HDBG);
-
-	gd->arch.tbl = 0;
-	gd->arch.tbu = 0;
-
-	return 0;
-}
-- 
2.34.1

