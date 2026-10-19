Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3965DCCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 10:34:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0063B6073D;
	Mon, 19 Oct 2026 10:34:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RZUY15DYtYKY; Mon, 19 Oct 2026 10:34:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3EB7B606CF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792406073;
	b=TGFbgWThH63JEAcsxElo1ude71uneA2w983DBElLfkUsTlSpoEu1FaOkJu2rrnbdvZzp
	 AzhvN3kjjqRFIqcQUDRUaHCltBEk+tg1bIX0agxvuqDLFKfIkzY9Urb/F3EOvIV7hAbdi
	 ZseaiUYjJMMYr9LFfIDoGrT71qql3r0LQ8gkNpR5h24YENwCE/UOxvstbYPbuvBTCXNP7
	 O3hNaXaXlcc0c9A5VSkZQ7uvOSc+NBjyL4IxdDZzqI0QeCIWM7fO2lkj4lO73mcDPj9e+
	 oC1FBz8r+w/gtYcFskMRZv/iaP4HEuJQsLjEf4EGDscEi4u/ZPzU81YA6fJwiXOAplg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792406073;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:From:
	 DKIM-Signature:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1rcfrYyvnTHMCBVMw9foKXynGAE82XJigcwAa+Kif3s=;
	b=jkvxXo4+LsNBrKp9Sgmv9ffEI/t73pukd+9yFtjRQLqXZ6p9tmGTfughDZpcXZCobLP+
	 BkJcuFj21cHVk7JeQkF7D12EiMSkey91ROGBXaUb5Xf0mqnnrM1CFjiRRqZRcDqDk79h6
	 lX9zPk9f40KldJEr9XrO7xkaYu5nAaBZ4kDCuM0sy8oRCp7Wg7dpSm6iOxYsrqpfg14PK
	 H4NrynVS0gGiCfWnqiTLJ21PB58teHVs+IbZgD982nuKtR9dHAGGVJ0aWjM4LID2vFPqh
	 fSaohBovoPJ0iWJHXqqJ7dA/dK5zh+sdePRMYbfQSgLuYPOKg7N0Bs7/fJq5SBWKiDw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=fris.de;
	dkim=pass header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail header.b=F1QkYcIN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792406073;
	bh=1rcfrYyvnTHMCBVMw9foKXynGAE82XJigcwAa+Kif3s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=077IKe36eNWdanI/NSg4TmRMG1kyBEesu2yjY0UQn6yAyawPV/BrOS++CHffJRV+N
	 OdTQ4LGeoagW2xbQYX+FXWeyeorZpChZuHUcFzs83AosT/kGLIt6LHlI6rd+VUM/63
	 VMxDcL6RNfwTosMDUnXIscHbEGDTzRXzHYY+Sxgi0rdkw6rFT06Ap8EHx0LasZpGft
	 TIo85Z6SUUffCWqaUWevDahqdD1C637hw6xTyimeIbOum0QNQUAMA3T3/HGa96rlHE
	 T8IFN5OfisWsmzYdEkWt9U+zIgAOFtD0jBGJiVjzKnEKp8l88reRQJtnKfxbCYJCuX
	 WpbSnSnH74e5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3EB7B606CF;
	Mon, 19 Oct 2026 10:34:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C2491DE
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:34:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 72B64606F4
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:34:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3hi98hPuEyOY for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 10:34:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CF4F5606CF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=116.203.77.234
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792406070;
 b=NNxZ3Cz8LbZvLdTnH6KLzlqm8nBrfCTGj3I1TS2hcmgFTfaSuGHArHfeHZ4qcVUtcaba
 1YBN+VfQxbDjpWzykQFwRzg6jWZ5LUG9+3qsYyukhfc8b76Qb7l5Ol+Tlu72fIUlKdDv0
 0XNN2y0W3QlAzjF2pGa5outzEmKyUmrTv8Ig965zzdMhHu81cV73ofpYnyDw/wCw19ttr
 Q5GjfDZGQde+GtZDsnaSCMxF3lasVVV74RzuyexoFteFJAAxkA/ZwFHr+VQvyjWOtNs7v
 PCC5SGOHNUMBo8tEJ6sXA6iSKL2J8jya6udtsT7JXRI602HFuK/g9rnu0sCYXxGu04g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792406070;
 h=Received-SPF:From:DKIM-Signature:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
 bh=1rcfrYyvnTHMCBVMw9foKXynGAE82XJigcwAa+Kif3s=;
 b=bO4iKLSESan+8glDni2JFUdDCrdofhdToQ69+XPm4vxzSox4lFQLWDPNFtsFfYsbsRUl
 NXAk/8mT5oYuG5xKLl4izoxU8qJMoabmlOisZnBnCSaFHrU9bER/4rKosZgjuUMsMAqiG
 OlVxXCiJcPXKp7YrWozbDk+FUhYCnBHzp2ZIJNAEQByCP8q/g6HLZ4PoklyCQyajj9CE/
 aLjeIb+3haUlmzmlZr2xzpef1GXOwJ/WdFmRl06wzLl8nRuQUxUIN8a5ujIdHJOEEmN5Z
 6F/HqQlXQo1dAloH6S3ZAYk4XA3d6G6i4dsVmpYER195FqrbdsAzHMT/hsOX3EhcrWA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=fris.de;
 dkim=pass header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail
 header.b=F1QkYcIN; 
 arc=none smtp.remote-ip=116.203.77.234
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256
 header.s=mail header.b=F1QkYcIN
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CF4F5606CF
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:34:28 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1792406066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1rcfrYyvnTHMCBVMw9foKXynGAE82XJigcwAa+Kif3s=;
 b=F1QkYcINMEfFjkRfM/7Z5q71mkmm4hamRBgi6d1700e+Al9zB6WRQvSsrsyQUQxwWCwVb7
 xwaJBx3uJwxiYQcNcJ7nKQ5m0yd0L8zcdGMeC2KzNpZMafFn57QpLu98rnPB0AQcPTMI5j
 JUGnk0CBQeNfTEQppTViIeGvJs6hv0IyfiB4JYR9ZJ+FY/1lvPWkPWUk8prFfhLxsYB1R3
 d1KJaJzvJsnrvsesH6vCl0j0p9HiDSUtu7uHKy7aD+sdmNI71V9zlwkEHCg50tmJmh6L2P
 RIllkkEif3Tvq5fa1qn4820T2jqTxRp3u2aT03oYy2xo+5xlpmkGMNjctSQOZA==
Date: Mon, 19 Oct 2026 12:31:07 +0200
Subject: [PATCH v2 1/3] ddr: imx: Use the correct GPC registers for the
 i.MX8MP DDRMIX
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-feature-main-imx8m-ddr-reinit-v2-1-be22a99c6fdb@kontron.de>
References: <20261019-feature-main-imx8m-ddr-reinit-v2-0-be22a99c6fdb@kontron.de>
In-Reply-To: <20261019-feature-main-imx8m-ddr-reinit-v2-0-be22a99c6fdb@kontron.de>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2460;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=EuHR31Ly7KRwKVcpT1dZhNY0ZiBGr3O7UspuhfWVrSc=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIevqJ8MCM9UtZg2NCQs+PpFjenf5/q5vJ3TtVuZFvnoft
 9jklDprRykLgxgXg6yYIosUv8VrW7NYH/lj1VEwc1iZQIYwcHEKwESu/Wf4K5HZ/kC6d8KCv6/Z
 j1UsOPXjwvrFr+fePj5pdssl6fLLq1gZGQ65MR7cWXBf3+DD3MpqztLvn3nr7YpOG26t7AuZqle
 TwQIA
X-Developer-Key: i=frieder.schrempf@kontron.de; a=openpgp;
 fpr=1A0F38EB3D365D4C1FC67B5A69761B25107C8216
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

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The power up procedure in ddr_init() makes sure the DDRMIX power domain
is mapped to the A53 and powered by writing to the GPC registers at hard
coded addresses. These match the GPC layout of i.MX8MQ, i.MX8MM and
i.MX8MN, but not the one of i.MX8MP. There, the domain mapping is at
offset 0x1cc and the power up request register at offset 0xd8 with the
DDRMIX at bit 19. On i.MX8MP the procedure currently writes to registers
that are not related to the DDRMIX at all, such as GPC_GPC_LPCR_CM4_AD
at 0xec.

This goes unnoticed, as the DDRMIX is already powered on after reset,
but it prevents powering the domain up again after it has been turned
off.

Add defines for the GPC registers and bits of the DDRMIX domain, with
the i.MX8MP values taken from TF-A and the Linux gpcv2 driver and
verified against the i.MX8MP reference manual, and use them instead of
the hard coded addresses.

Assisted-by: LLM
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/ddr/imx/imx8m/ddr_init.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/ddr/imx/imx8m/ddr_init.c b/drivers/ddr/imx/imx8m/ddr_init.c
index e9209ce8b61..0706face14a 100644
--- a/drivers/ddr/imx/imx8m/ddr_init.c
+++ b/drivers/ddr/imx/imx8m/ddr_init.c
@@ -10,6 +10,19 @@
 #include <asm/arch/clock.h>
 #include <asm/arch/sys_proto.h>
 
+/* GPC registers for the DDRMIX (DDR1) power domain */
+#ifdef CONFIG_IMX8MP
+#define GPC_PGC_CPU_MAPPING		0x1cc
+#define GPC_PGC_CPU_MAPPING_ALL		0x003fffff
+#define GPC_PU_PGC_SW_PUP_REQ		0x0d8
+#define GPC_DDR1_SW_Pxx_REQ		BIT(19)
+#else
+#define GPC_PGC_CPU_MAPPING		0x0ec
+#define GPC_PGC_CPU_MAPPING_ALL		0x0000ffff
+#define GPC_PU_PGC_SW_PUP_REQ		0x0f8
+#define GPC_DDR1_SW_Pxx_REQ		BIT(5)
+#endif
+
 static unsigned int g_cdd_rr_max[4];
 static unsigned int g_cdd_rw_max[4];
 static unsigned int g_cdd_wr_max[4];
@@ -333,8 +346,8 @@ int ddr_init(struct dram_timing_info *dram_timing)
 			     CLK_ROOT_PRE_DIV(CLK_ROOT_PRE_DIV4));
 
 	/* disable iso */
-	reg32_write(0x303A00EC, 0x0000ffff); /* PGC_CPU_MAPPING */
-	reg32setbit(0x303A00F8, 5); /* PU_PGC_SW_PUP_REQ */
+	reg32_write(GPC_BASE_ADDR + GPC_PGC_CPU_MAPPING, GPC_PGC_CPU_MAPPING_ALL);
+	setbits_le32(GPC_BASE_ADDR + GPC_PU_PGC_SW_PUP_REQ, GPC_DDR1_SW_Pxx_REQ);
 
 	initial_drate = dram_timing->fsp_msg[0].drate;
 	/* default to the frequency point 0 clock */

-- 
2.55.0

