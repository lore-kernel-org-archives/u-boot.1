Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C590BE7734B
	for <u-boot@archiver.kernel.org>; Fri, 29 Sep 2023 23:07:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DE9F86C43;
	Sat, 30 Sep 2023 01:07:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="EFt86sJI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E708286E45; Sat, 30 Sep 2023 01:07:14 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A11EA863DD
 for <u-boot@lists.denx.de>; Sat, 30 Sep 2023 01:07:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f3c4=FO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1696028821;
 bh=JTpfqmU5nPvli26kCgcPKgJ9jpzLik1HU+POLUSsL44=;
 b=EFt86sJI/OqfiPKTG1KEuyZu7acNcE8qsQaUiex1RJE9ta8/sgBePYe1Kw+QHwuxXAZhtHk7g
 TjjgKqvYUsZCo5pPIcE7S5OcbUWPTB5rJaoiMumlsRRWNvLmcju4YK4nEvl1UcbID+jkHSH6wJy
 2rB5cV1sBJmHOVdBO5A8X5wAxjf8vgIfeXf70UwdbJthc2qjclktNTSaqSemEezwbH7Lle9Gv1c
 6ar9eLCRWu8ltC290M58zmwgKCetn0sUdK8fq1TH1goNxZwu0jxg3e3CqDAuuYU+C2NnC6kXzGV
 yE2rSefzd9Im/pplO0oHiiHLksc+xUUrXbNTbj9oixQA==
From: Jonas Karlman <jonas@kwiboo.se>
To: u-boot@lists.denx.de
Cc: Ferass El Hafidi <vitali64pmemail@protonmail.com>, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [RFC] mmc: Remove alignment hole for cmdidx in struct mmc_cmd
Date: Fri, 29 Sep 2023 23:06:53 +0000
Message-ID: <20230929230655.2932698-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65175894d819bc962047949c
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The alignment hole caused by cmdidx in struct mmc_cmd cause strange
issues together with the peephole2 optimization on Amlogic SoCs.
Following was observed while working on SPL support for Amlogic SoCs.

sd_get_capabilities() normally issue a CMD55 followed by a CMD51.
However, on at least Amlogic S905 (Cortex-A53) and S905X3 (Cortex-A55),
CMD55 was instead followed by CMD8 (and a few reties) in SPL.

Code from the call site:

  cmd.cmdidx = SD_CMD_APP_SEND_SCR; // 51
  ...
  data.blocksize = 8;
  ...
  err = mmc_send_cmd_retry(mmc, &cmd, &data, 3);

Running the code with MMC_TRACE enabled shows:

CMD_SEND:55
                ARG                      0x50480000
                MMC_RSP_R1,5,6,7         0x00000920
CMD_SEND:8
                ARG                      0x00000000
                RET                      -110

Removing the alignment hole by changing cmdidx from ushort to uint or
building with -fno-peephole2 flag seem to resolve this issue.

CMD_SEND:55
                ARG                      0x50480000
                MMC_RSP_R1,5,6,7         0x00000920
CMD_SEND:51
                ARG                      0x00000000
                MMC_RSP_R1,5,6,7         0x00000920

Same issue was observed building U-Boot with gcc 8-13. Please advise on
how to best work around this possible gcc optimization bug.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/cpu/armv8/config.mk | 2 ++
 include/mmc.h                | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/cpu/armv8/config.mk b/arch/arm/cpu/armv8/config.mk
index 4d74b2a533e0..7177dcd7c73b 100644
--- a/arch/arm/cpu/armv8/config.mk
+++ b/arch/arm/cpu/armv8/config.mk
@@ -7,6 +7,8 @@ PLATFORM_RELFLAGS += $(call cc-option,-mbranch-protection=none)
 PF_NO_UNALIGNED := $(call cc-option, -mstrict-align)
 PLATFORM_CPPFLAGS += $(PF_NO_UNALIGNED)
 
+PLATFORM_CPPFLAGS += $(call cc-option,-fno-peephole2)
+
 EFI_LDS := elf_aarch64_efi.lds
 EFI_CRT0 := crt0_aarch64_efi.o
 EFI_RELOC := reloc_aarch64_efi.o
diff --git a/include/mmc.h b/include/mmc.h
index 9aef31ea5deb..7b3868bb5664 100644
--- a/include/mmc.h
+++ b/include/mmc.h
@@ -413,7 +413,7 @@ struct mmc_cid {
 };
 
 struct mmc_cmd {
-	ushort cmdidx;
+	uint cmdidx;
 	uint resp_type;
 	uint cmdarg;
 	uint response[4];
-- 
2.42.0

