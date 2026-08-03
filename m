Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F0B9C5518F
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 23:31:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BC456606ED;
	Mon,  3 Aug 2026 23:31:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D2o8uEH1TanE; Mon,  3 Aug 2026 23:31:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CEDC2606B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785799882;
	bh=SiL+4F/2XvTx69hP1ue/GMB9L0TvFrFNviej4l+JGBo=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=LO5KwjS2b+h9gs5WpmQz7FDBIKnh1OIDUa5UVyN0aTypAN0LwZI4DbR3wwqRvpyZd
	 mr1gbo4YYvcQ8DTWjQmV8V31SghFW7CXfdPi//j0ZWJSx0+rhUWqWeLYTgDR8ajV3q
	 5bUvIr9Ku5yMyLXjqqLC/ut5Qyi/uMaBsi1laFmmSJY7Hv26FX5wxJpuBcO8xHyz2I
	 llrQfXREOzfJZtR60/3z1Xw9RJ4uOCIWvVvSR8+PgotDnW32mMSORRsKk/sYlpgjPl
	 /XJBOJyNGoi/KvKsfvRRs3Ym/dFOXpFws6BCMmacgD5nUD6sTxdYDXFk1DXtZShvhB
	 G6CRyM+FPGYGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CEDC2606B4;
	Mon,  3 Aug 2026 23:31:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 486EE23F
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 23:31:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2EAE0400B4
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 23:31:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YEc3qAkXFjrs for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 23:31:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9DF1E400DA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9DF1E400DA
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9DF1E400DA
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 23:31:16 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hDXxG3X0BzMlGK;
 Tue, 04 Aug 2026 01:31:14 +0200 (CEST)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] arm: renesas: Enable RPC on R-Car R8A78000 X5H Cortex-M33
 RSIP port
Date: Tue,  4 Aug 2026 01:30:31 +0200
Message-ID: <20260803233104.391908-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260803233104.391908-1-marek.vasut+renesas@mailbox.org>
References: <20260803233104.391908-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 9r1urbqyfwpnxqz71n4rr9a3r99ucdjg
X-MBO-RS-ID: fe2c274438f64b6a9de
X-Rspamd-Queue-Id: 4hDXxG3X0BzMlGK
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785799874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SiL+4F/2XvTx69hP1ue/GMB9L0TvFrFNviej4l+JGBo=;
 b=SP9Gx+mhigN7pkdRodlvjroRxb6wJJnjRd695t+l+srUVDP7RfnBlyo+94vgxjYyP7fXk9
 4Uk3Mkos2SOQsLE6JjmuJRmnO1gu1XsPIgoWx+VYqazj5A+9wk3zdZeamHbgHUF1eWiWrx
 AOQpaoqeYDcTRTXiMc57kB6srCsYQaPDUP3FXAWZncfHpqYfJ6qLvEhNrAcy+mjLiU95QD
 Xs6KRMaijlZ9Rix/2uhe0LoFCGxsEjXPGuDyZQDpxyOPnq1WSlBNvj+lFE0vH3oEP/Z3Z+
 895piLqnhCWeC7tt0+7XaiFRN23MwDA7vPak9ayefcMUpeZ7ANS+Vjs2vy4/pg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785799873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SiL+4F/2XvTx69hP1ue/GMB9L0TvFrFNviej4l+JGBo=;
 b=LWueeWJZtZw3+dO6olDHnqVcojHw69GadDqQ1CTNH8Aiw4VfSgJfcQVSXFnntp+nzDOTEK
 LYY5jPeRp7ADAngSsKnB4T1vf5T6pTA4M6wHIAhvres4V5gBOpctq4PIAn89nbHcW5tCly
 ehX99mQnf4vV1ZlVw6yPCFxCgaOFZMQOxa812fLChFoMZhiCWqwryVy9Zz4lXslEoCJDxm
 F5oBRSPtrzOpDRbd9fIB77s1LTp8p3ss0uZIIGuZF49ar+ACTQkY325KW1XN/QhN6OavKG
 nXCk/BYRrbld7w5hDG7WfkxqBtD8V+UNv8B4oiU/rRgWzrnLMD5B3DcpiDeCnA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=SP9Gx+mh; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=LWueeWJZ
X-Mailman-Original-Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=LWueeWJZ;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Enable RPC and HyperFlash support on R-Car R8A78000 X5H Cortex-M33 RSIP.
RPC is used both to update the HF content, which includes the U-Boot on
RSIP itself and SCP firmware, as well as access the U-Boot environment
for U-Boot on RSIP.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 configs/r8a78000_ironhide_cm33_defconfig | 13 +++++++++++++
 include/configs/rcar-gen5-common.h       |  4 ++++
 2 files changed, 17 insertions(+)

diff --git a/configs/r8a78000_ironhide_cm33_defconfig b/configs/r8a78000_ironhide_cm33_defconfig
index 4b01d82647a..32998a98028 100644
--- a/configs/r8a78000_ironhide_cm33_defconfig
+++ b/configs/r8a78000_ironhide_cm33_defconfig
@@ -20,6 +20,8 @@ CONFIG_BAUDRATE=1843200
 CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_BOOTCOMMAND="run rsip_ipl_boot_ca0"
 CONFIG_BOUNCE_BUFFER=y
+CONFIG_CFI_FLASH=y
+CONFIG_CFI_FLASH_USE_WEAK_ACCESSORS=y
 CONFIG_CMD_IMI=y
 CONFIG_CMD_PSTORE=y
 CONFIG_CMD_PSTORE_MEM_ADDR=0x80000000
@@ -29,10 +31,13 @@ CONFIG_CMD_REMOTEPROC=y
 CONFIG_CMD_UFS=y
 CONFIG_DM_DMA=y
 CONFIG_DM_ETH_PHY=y
+CONFIG_DM_MTD=y
 CONFIG_DM_RESET=y
 CONFIG_ENV_SIZE=0x20000
+CONFIG_FLASH_CFI_MTD=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_LAST_STAGE_INIT=y
+CONFIG_MTD_NOR_FLASH=y
 CONFIG_NET_LWIP=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_NR_DRAM_BANKS=1
@@ -46,6 +51,7 @@ CONFIG_RAM_RENESAS_DBSC5=y
 CONFIG_REMOTEPROC_RENESAS_RSIP=y
 CONFIG_RENESAS_ETHER_SWITCH=y
 CONFIG_RENESAS_R8A78000_POWER_DOMAIN=y
+CONFIG_RENESAS_RPC_HF=y
 CONFIG_SCSI=y
 CONFIG_SERIAL_PROBE_ALL=y
 CONFIG_SF_DEFAULT_SPEED=40000000
@@ -55,8 +61,14 @@ CONFIG_SYS_ARCH_TIMER=y
 CONFIG_SYS_BARGSIZE=2048
 CONFIG_SYS_BOOT_GET_CMDLINE=y
 CONFIG_SYS_CLK_FREQ=16666666
+CONFIG_SYS_FLASH_CFI=y
+CONFIG_SYS_FLASH_CFI_WIDTH_16BIT=y
+CONFIG_SYS_FLASH_PROTECTION=y
+CONFIG_SYS_FLASH_QUIET_TEST=y
 CONFIG_SYS_LOAD_ADDR=0xb8000000
 CONFIG_SYS_MALLOC_LEN=0x80000
+CONFIG_SYS_MAX_FLASH_BANKS_DETECT=y
+CONFIG_SYS_MAX_FLASH_SECT=256
 CONFIG_SYS_TIMER_COUNTS_DOWN=y
 CONFIG_UFS=y
 CONFIG_UFS_RENESAS_GEN5=y
@@ -75,6 +87,7 @@ CONFIG_WDT_RENESAS_WWDT=y
 # CONFIG_OF_UPSTREAM is not set
 # CONFIG_BOARD_EARLY_INIT_F is not set
 # CONFIG_OF_BOARD_SETUP is not set
+# CONFIG_RENESAS_RPC_SPI is not set
 # CONFIG_SYS_ARCH_TIMER is not set
 # CONFIG_MMC is not set
 
diff --git a/include/configs/rcar-gen5-common.h b/include/configs/rcar-gen5-common.h
index a0c05521c85..8ccd823cf53 100644
--- a/include/configs/rcar-gen5-common.h
+++ b/include/configs/rcar-gen5-common.h
@@ -27,6 +27,10 @@
 #define CFG_SYS_TIMER_COUNTER		(TMU_BASE + 0xc)	/* TCNT0 */
 #define CFG_SYS_TIMER_RATE		(133333333 / 4)
 
+/* HyperFlash */
+#define CFG_SYS_FLASH_BANKS_LIST	{ 0x34000000 }
+#define CFG_SYS_WRITE_SWAPPED_DATA
+
 /* Environment setting */
 #define CFG_EXTRA_ENV_SETTINGS						\
 	"rsip_ipl_params_base=0x8c100000\0"				\
-- 
2.53.0

