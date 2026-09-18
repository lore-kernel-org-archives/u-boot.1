Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA794C982D2
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 03:16:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6BBC960BAF;
	Fri, 18 Sep 2026 03:16:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cBr4nYq-y7HV; Fri, 18 Sep 2026 03:16:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A5FA260BC6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789701392;
	b=flR8w7J7J+0KPmDXv+2+Bkc8o44oxJtGz+bOSrLW40aKQGMPCq2zJeDXZwa4EwF+habA
	 B/fLlUPr+ijEbfsQmDsQXqUf6E/ApKqWrvAL4Jw34jf96Dt/Saf2f3X/KCgZ3XTfVyrJu
	 EHNR6UpA/l7r4WWUrohcA6c0O6QFXt8jFuRJA1YPvyMb7fDQ4tPhnkvpZ9F2aIN0JPQ8L
	 NBIx529PF4+0uJaqd8DsdMdhm3PcvVrKRXAkc0WHHvTPwhzMeNmcjSg+dri+/qzTBg+1f
	 mHkEFiPrvbF8OFmX6HYSUoP/vkwLy141mZHABnXaAD8RXyyZazaUl3JkijquK3vM3Vw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789701392;
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
	b=Y33iSRvY7km6zonWhif6NmRIof5SnmSS/wd21JtXXdJPEZg9daiyQjjUl5pwYgfyan1M
	 zvSjDeFm4865DI6GSz/SoS86iGjw93dN3zUuXW4ESrFl4CWLPWnfTGGmEq0v7rCc0D3T4
	 9e4h6a0GXxcdsipdi2Blx2lvEZCYnOawBPvwEBcF02dkqK0aQ2QAJJmxOGegZ4dEBFDdK
	 rTLqqSB14uQbvCOA7CB4VxO1TwtGYzi1M6QrrmcaIHMbUmKiT7rbvkNvsyqgcOMML9hXg
	 EQrjSGm17nVRN+TPhYdKpeJ9FP39ErIra0wCND54GsHDANBzhREf+AwiVFLciB0urrQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789701392;
	bh=jM5YgXQqH0uKOX3kj0mcl0U8NNqyMVM94qLIcGycUp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sPz7jgqir2wAZFyV2jm+ogs/2SOYTvzg1dyvcIr2gTx9pqd91bs3S5XXiFDK2LJv/
	 Ty1tOEOGFpwwS8MtewOkKWJBo6QPY7HjP8vj+NffDJ9WLkPctuzZ1PdCXv1qbrBTzf
	 4Chjtgl0htl0OmKsewqM/yFEErP3wcvnSAkHCUx+QePpu+lVltZOZ2uMeusq2U8N4Y
	 C/l/RYE9hB94iQdzi1SpH7yq4TUXSylEk46F+VXTagAj4nszdgH1UlNfvKcDSjfXAt
	 BYRkRn3HfuLRlDaHBagCc0UYx++FLYy67pcPbW6TA98Zi8MQby0wu0g/LGOomA+U8p
	 9j1BkjCOFggLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A5FA260BC6;
	Fri, 18 Sep 2026 03:16:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4822F29B
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 03:16:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3A4904008E
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 03:16:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 52yYLFZUzfTK for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 03:16:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 7DB7140492
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789701389;
 b=baep8m3fQ7YDRaMRKUTvAIB7e7Bdp5qG2Zxu7IU+w7ial8JamKDKiMC1Kl8jOPIhpzoT
 h+r3giC5msq1Z0NTISokPuRfyvbFlieZJRqGZbNwfWSdonl/F/Iczld6XrMLnTKsiHjSk
 +NZOtKo28uaa8Rdyr4PzYKqziAbR6uEpzZXw3F3wVaLFxaZbQVAi0gTWuZv8LBAk0WoXn
 2D+/UT4Es60bkNbruTmprw/TdFWWc0gqjdGcPGr9uK1LQ7/3bjgfa7ivFPSrT6fozW50u
 Zg/zfhx5BRfoPI/b8I8M5lh28drPNWUoWK6RAnuXb1Qn5CgiUmjtRGo+5b3H8VEZVJA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789701389;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=jM5YgXQqH0uKOX3kj0mcl0U8NNqyMVM94qLIcGycUp8=;
 b=MHeQ9MGSc+Az87B8Yd4fizdWichYv1nYnWMX4WgbhqXSHnxNGFldhLgDuT4eZebxK1HY
 +IZ65li1YFroT4cxgWkq4zS/ku7p6kVzgTdpEpCxvuJdalaj3aWknyh8PE7HztE6gsSVl
 mpnSHu/67ZSj1GOm5pGG1wNb/bfxOnZm7LkS3XBIkODIjt2ayEmXcagxi7tAeqKANPwQQ
 C84MtQO4oP1jrNyk/1uG+yumu0839RlkyR+5QId1nyiAC9LskQFGlfOsa0bgKpJrE4Ulo
 LN3qbBDd8XapaZJOlOGYjM6cujsbBDegLdhT/hvkg1r/Yxp2Xh+2y/s+IMwhWjDdKQw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=cAUa1w5j; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com;
 envelope-from=jim.t90615@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=cAUa1w5j
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com
 [IPv6:2607:f8b0:4864:39::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7DB7140492
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 03:16:28 +0000 (UTC)
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d747ed6d6eso2452525ad.2
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 20:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789701388; x=1790306188;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jM5YgXQqH0uKOX3kj0mcl0U8NNqyMVM94qLIcGycUp8=;
 b=cAUa1w5j4JZyrbDCDKusnKmytXYRlWZOjdP69bW9LKGhufG5WdDAZmT2o/6UWxwCU7
 vl7o35FfFqHJvM2XzfrBt289i7AGLd7xKv+fj+hiU68LympFXi2YcGyD6TJBR9rT9o4J
 NUCue1azYOv2WJrLW9164RUYZ5uRWwsB2QQUherbh6f/oM73GQ0PlNUvZ8hXnr/0gzjf
 NqZ0FeL04k2S6Mc8aruK6qMjDBDxaYiMpcX0bxLck8zHUBlpaV0O300GZiJZ3/8/DXdl
 0UedM+lKYIR9UvCLbn3qtKKKW4jvW1QR9gvRLD7RojAGaErxue68XQCa5nDHU+/hmILS
 KpWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789701388; x=1790306188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jM5YgXQqH0uKOX3kj0mcl0U8NNqyMVM94qLIcGycUp8=;
 b=Kn0UgI7dZIEtQCUDgTF3lGwQlaFc0ieoPXsFWz2XfiEY4euMwD+Jzk0pZqtzGhq8aj
 A73IdH5jtZoVGFYfSFpCSRRq9iDVCYGsNT+XrU+z+qiJKO15IKkMWvy9AenGzmMy7bKl
 p8j3KvB5B57/9+uZwjftHr3Mk9EEVZrvp0SfL2GamQm+4j2qoBNSmXXhtXjQpM3X0jiZ
 Ot4Kae0Sw+6oK5Q30YWssX1l+xQTN70cDIGsBp71dpIxbKhlA2LQwWM2XD6VxejKO80X
 02+dyT5tdDeAx+7yAcqsHtm815JAWRueTyq9tqsrck2Vh5idLBANt1NDbcuLm5kZExWW
 FaAQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzQ0UpsG8hv5QpmQN8IzWwzwhy/CZHuBq80mvSP4VtHkxusJf7F6FmgUdLmdLA7kA6CqZjvrLQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mmM+xRDkgq5/vMS2J0IwEpd9Rk053q5UdF8bgv7wQ0BJygyqCX
 OoM6BTRJhfePV/CKBskxoH1dQwFMUIwKVfEHX3rE2G2SVgc/ba7lY5KF
X-Gm-Gg: AYBFou0SFH+avb+NVCk5qZhjK1WqEy4Zn0dcRQgFIE6nu7ZTR62lKYACmBm3vDqRGub
 gK3eT7zaf8WjiqfxxHm2abgw7yNsLVar83pWPT7pzIYje3X3KIz9LzxcGLALqooz2zWvUsvjBJG
 gnMgw07hrlIyJFWEZqEJp6dc3RdydpXZhc6TCKqzDiAHsQ6t+GhA4ZDxEA2fmRaRkHSfjmbtRR7
 dYQKNdJ801Ncn/XJhxhlqds1TTCwjwCCKN8Lg0CZRK/HHMy4wyw3F0hioDuU9GsulbwisS7eDF4
 fNLI2m7s/5bN9PO3kK2jXzvB+jsDNAIu5KQ8Rf0KmBU8ifzVqpGe3x/nRupVJvax3WmqCZI/uOS
 JwQc0Y40UQgpc8kuEJZfLpNd+cfqRyzWwpRtIxMa28JRGarOe2Ev1zujTmnqHMN36O74s9ftuTV
 k0lUa6ZRpQ0WtlcpochqTS2DFrXULOs8hPfX4Kcu1fYdJjFW5YqKQzcSb7TMUtRa57FTe20f/2x
 v/YdHT2
X-Received: by 2002:a17:902:fda7:b0:2d8:d4d3:3fbd with SMTP id
 d9443c01a7336-2ddb1b79273mr25168575ad.17.1789701388021; 
 Thu, 17 Sep 2026 20:16:28 -0700 (PDT)
Received: from cs20-buildserver.. ([2402:7500:500:6259:4c39:1ad1:29eb:e47f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ddb75b53fesm874505ad.59.2026.09.17.20.16.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 20:16:27 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, jim.t90615@gmail.com, trini@konsulko.com,
 dhphadke@microsoft.com
Cc: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 Stanley Chu <yschu@nuvoton.com>
Subject: [PATCH v1 2/6] npcm8xx: remove system timer configuration
Date: Fri, 18 Sep 2026 11:15:50 +0800
Message-Id: <20260918031554.1855939-3-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918031554.1855939-1-JJLIU0@nuvoton.com>
References: <20260918031554.1855939-1-JJLIU0@nuvoton.com>
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

