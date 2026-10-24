Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8E1606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 00:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0Rpwh/Ji;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=MpE3cFb9
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C231940ACF;
	Sat, 24 Oct 2026 00:10:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RH6MKKzZPHtf; Sat, 24 Oct 2026 00:10:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 06D2D40AC6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792800614;
	b=J9M+mMgaGp7vM9/vzTR2vmzv45h2DVQPnzC+Q7jDJ9dTaSyG4mKq2pZ3+CSow+/gW7yi
	 OyeWa48MPmwMxqudrhNfbi+Rl5xX2OO9YpSx+Hae126u2hLFnFNdB69FULWYNsnR3AMec
	 0gOMZjARP01ctkNyScn3CeFmhnJ1GosK/o3OlVREdaRJEsAm5za0mkMWRL1t6VnV2OwOU
	 R0p6te+NGTDJ31zlGyUCkBj4NOANmwnYOJCl1WbuLuT9B+EKw85zPm4NzE8VgAJreQEJG
	 X3yvWb3YWppr9EInZ0k2CD1WfUHTkFMStgOuAF82003xAo9Pj7FpP7TnBkOzlbOCqgg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792800614;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UShoyvsOnRfOmMSt/62ljAkKeNZ6wQgbhqud15MBDIg=;
	b=kxCGl0FJYhns7/yIxUq9edGiHKGb89dzW2DUyuX1v3NXCFaMBiHSlDz7hFNipyM9MjPj
	 o4pyVSKqVZZ24wuGbvTjXP8eIgELAEsmyroLayGxEmsP+FT01Yc5P7gEWiH0wcbAJLXu8
	 G+wGg56sQ/OELdKYY76+K73eOTiEHBIt8qm8ECGybXyPkuTFC0KAwRDouiTDRaqRFVi9U
	 3xG4WC8Xiamp+p9OfasxMvxZHHi8zD4Zr3MoEW1td72NPC57KyLK031Y7u7cnJQVQeYvI
	 oYGDr4Y4DPC75nIU6n0t8wRxqa9/TRWRejyS01aEs7nVYo9QIuxyLFX0c7wHXhGdmDQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792800614;
	bh=UShoyvsOnRfOmMSt/62ljAkKeNZ6wQgbhqud15MBDIg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0Rpwh/JinKkYatQV3B2xeS7nMRs8wI6bcavQnpK8DkDPHyfIVqTWwvB6ebdzDvwRx
	 1GiUo/JMjI5bgq1q9v2mjACWvfcXmhpykNMcShY19OKm3/Nkykvi2dRPMX1vByZvfh
	 EyCJXPtQd0284rjmecVrrgv7AnxwuurQHY7NUVQ7APIK1Wycn+4OXBsoNCaNu1V32G
	 +1vvPpKPFn5Ll4/GzQcGKo1sX14zVDY1lXLzzWR6nCBKwEOY7V2Wtbh+Hp3ee4I4uN
	 h0ENo/9NS3vCJCJxI3DW6YTi6IIi1m3YcT8zrwn1V6iPe0Uv0wmADE89oXGZA5oP0y
	 6+3+TitG4UziA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 06D2D40AC6;
	Sat, 24 Oct 2026 00:10:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EA5C6235
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 00:10:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DBB4C80C79
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 00:10:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wQ5KikPvPrwo for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 00:10:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6B5B68165C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::233"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792800612;
 b=HiC+YenJ1pP4XLt63qxAQ601h3J9fOGIcNwudcT2vlZRuG0+TWHDC8l87N0IVMeGSUS1
 7zo4C5ENaPHSoGRvpyKEoAOs3+6pE7k+ToeW2OUpAcIt/qGj/hMmA5xPtNulZMzZy63AK
 vJXq6xNRSaXI+m0OmVlpGZu2TCuPd45yWB+OkdBSn+1/SmTMWbThF3CL9thu10lQaVKQ1
 5S8gDNjkFCJNVviFVZuniYyPRaE9wI1YvoClU2LJU5exFhyunIrNXpXAVeZnL15VE4iVX
 o8EFXrO0S+tYmfi6G1LffUnFuHjhkZZsLtotrvjKlpA2wuUjfc9hixNUOG6D6Lz9snw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792800612;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=UShoyvsOnRfOmMSt/62ljAkKeNZ6wQgbhqud15MBDIg=;
 b=L+y1BJNscLcLbmNQtuksb0x1M3ZoWjjpOI9Fov0Ld++VPON9wyxOqhk8aa0+x7s1MGS2
 xvDNvklWpMU19483eAYmIRP9+3pqNg9G8QXmIH2uHYYQYLsO/nCXkJSw7beORdiCBnGz0
 qic3Qx8Je16xkyR51VcC75G1vIyBYGs6MmPb/k5uCIO2lCDoxepcCUx8p4S8QteBqC+cM
 OYuTCHtDbXjS/36Xz7WBDGcBA1618vfMDKxD0oTg4zFrVzSpo9V+Q7dUiEe7SZy/+GN0/
 LxHZ77YO1ooZhyWe/W8tOKuuTBqvchI4QZfxEgzRMFTXxSFKYD4F6RpdclsJqpJ2OKA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=MpE3cFb9; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::233"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::233; helo=mail-oi1-x233.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=MpE3cFb9
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6B5B68165C
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 00:10:10 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-4af81963f35so987122b6e.0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792800609; x=1793405409;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UShoyvsOnRfOmMSt/62ljAkKeNZ6wQgbhqud15MBDIg=;
 b=MpE3cFb9/qBXQUmHToRm4rYGbzAtK5Kz9O7951ZLIx88Y6hfqEQvig34H1m+2BqXmV
 BlysZxnytuJaps/dgb1ytU3cLRbhe0zIkoQDnhHhk085yUHJJUTlXWaLR6tqQXSNuKtL
 vcf0bF7Cc9DIE4aRxo3aOP4sFfKj/Vdy/FAoQ1PzpdTbl1Y1pVzftodbj23kxlNUVdSR
 8fNiSySnbt88BG/d8MsNzA9miFXnsby9+rsi7U4GP6OXumzm7i/Qw/bWpEca+0hh9Xe/
 APTHb73bTWi36CXV/Cc7vKYeGgr2OZHrilrNvUmMRickM0pERPBrAbRvnR9cKrlTXkYs
 ty7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792800609; x=1793405409;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UShoyvsOnRfOmMSt/62ljAkKeNZ6wQgbhqud15MBDIg=;
 b=DHgnk/9V3dWhE8WXFnrg7wjHQAz2Nu729S+a/R3AiFIDUnWQW+lO6FOL5GhOxGpt9F
 CHv9mkTFLw1Btl401vbWr3cccNDmPhrZK7dshW9amDqco2tZ9tagt4LKOI3zs1ioCizi
 NuGB498NZx+jiI1fypnUne4A60p3AqbgiZNpFIxelXEeUp7JiZaXQA+vD30JeHdsGLFE
 ITNTSs+lHRNM3+bdxMcSWeXzOfHUWtsAg8XkkszBNvK1wEmPHreUmquy2HuSkIqbYSCZ
 WZsHmxpNQb7KhJZmHPNvzkxfBTxMk6S44gG0mN+cdHp7Io+QAegvTC2BBO0MpbciDLlN
 /L+A==
X-Gm-Message-State: AFq9FYIQo5vYyCcsFDFLW2ErmdI7gpTRTeDjJfbXsPu2mcoKEuPlIPmI
 7rEHvLthUEx1s1eEMYSxAncdEEB8hcovemRJHD7qZkf1FoW2CY5Zr1PejqDTTQjb0g8=
X-Gm-Gg: AYBFou2+Jg8Gh84J85XtA/KAFFuYZdXWnRWmH3W3bPUwKynvLKrr5HCikSErnwYMJTW
 jFMyb52PLSJ18d3ZlqnpB/F+FszWzaKr47RnXerxUtGFk7IGhytG37aFvrWiqH5PbLPBRHcuf3B
 DJdHOoQEmn+pWacTCxXBN8feuL7SiqLeX+PWl8inJB0NCT9IhEIBQHhXPnrfl7qenaBs4IfOvCT
 ZGvUJu2sWugd8Fdvgm5O+lQhCwX+abOk6duKAnnpuRkME4X7tZdFouoFpJDGahKGtNdyDlklEkn
 Dx+a4xkYwuVbV1fyFSo4TDxA3hGtyMYiUyU5xiwAInAZ61zHBdHcEZkRdOdxYtP9gb0c7Bh3/M8
 Oq92iB0AI26qLB9H+NRZSNZQ6zOnxWGGGurV7tsBrxjEHxJ0pK/on6U6q8zb4h+CvNUKpvq6H/M
 z637xekSLTgOaCMGlPeBOT2ONcXTGMFBEiSuXWjeIizS3fUQDw2ie9HZ0D3wLw4EoMZhl1Ffgl1
 ilWOMWBTLzUZxDtwiDapf2TZMbHijPxitxL4OpMFZcnfohLiOLQz5NtzUuf
X-Received: by 2002:a05:6808:4fe6:b0:4d7:17d5:6c9b with SMTP id
 5614622812f47-55bfffc77d7mr722543b6e.9.1792800609043; 
 Fri, 23 Oct 2026 17:10:09 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d2b5:d533:1cac:8248])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-55c04248804sm328636b6e.3.2026.10.23.17.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 17:10:07 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 23 Oct 2026 19:09:07 -0500
Subject: [PATCH 1/7] arm: mediatek: mt8189: fix the reset_cpu() prototype
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-mtk-genio-720-spl-v1-1-f2c0ee094fd0@baylibre.com>
References: <20261023-mtk-genio-720-spl-v1-0-f2c0ee094fd0@baylibre.com>
In-Reply-To: <20261023-mtk-genio-720-spl-v1-0-f2c0ee094fd0@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>
Cc: u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=986; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Q1KiaXEaXyKzaCl9RMFrJq50PlyUGKdmgh3H1J+77no=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq2/cubAbcAdNkIGxwSplsFXyZDba1Y7enxhM7w
 vWLtTdbMv2JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCatv3LhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A2EUH/j1qhThyEvw03v8hRG4xkqPy6JKUx/piO4jTW+r
 /8NNrEsMYn/YfeiQobKsxvK1wH9H1PBBC+bjr5PinyBJVVBlqhC43Pfz3D4D+ahXM6VOqV2/jN/
 tv6nDNiVzU6Evay+xXzpk4RAmPtXCdazARqwKibIe+GEk3Ka8CVutr3bwNn0SsPCGyat4174hTB
 ZgNKPaFlzvL/5phjfoIMoDLxGLl206DBnkCzZK9uomCiFyW2Uj022hxOeNh0KnGemLdSH65u235
 vf6pvvkHqQysuVTMjklhj3rqbskFN+R8tS2nH9lFRpF1AdAZzQ8oUvJs48H37cP35839AXhqyna
 pzng=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Make reset_cpu() take no argument, to match its declaration in
cpu_func.h, and include that header.

Fixes: a7c682565b4b ("arm: mediatek: add support of MT8189 SoC family")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/mt8189/init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mediatek/mt8189/init.c b/arch/arm/mach-mediatek/mt8189/init.c
index 4435c75a656..c0b7050c6a3 100644
--- a/arch/arm/mach-mediatek/mt8189/init.c
+++ b/arch/arm/mach-mediatek/mt8189/init.c
@@ -4,6 +4,7 @@
  * Author: Chris-QJ Chen <chris-qj.chen@mediatek.com>
  */
 
+#include <cpu_func.h>
 #include <fdtdec.h>
 #include <stdio.h>
 #include <asm/global_data.h>
@@ -29,7 +30,7 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 	return min(gd->ram_top, SZ_4G);
 }
 
-void reset_cpu(ulong addr)
+void reset_cpu(void)
 {
 	if (!CONFIG_IS_ENABLED(SYSRESET))
 		psci_system_reset();

-- 
2.53.0

