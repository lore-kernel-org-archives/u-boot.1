Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF97606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 22:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UrGYT4XT;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I+NLRqO0
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B82181696;
	Fri, 23 Oct 2026 22:18:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GzBsBSSOwxll; Fri, 23 Oct 2026 22:18:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 40DA98169A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792793938;
	b=Y9KpH1+apVnydrabvKdtA1txVqe7hCjZ9pSmmNpbNElMHPrQwiTwlnf8NacyYzrj8aFE
	 zjj3vZTWh8q/+bHNgaQsUlThOIwJHl15PqOuPxPZpdMhcQVMDReO27BAD/t2Tm84M0BWM
	 tfW393Tm+mgUGSkHzCgyxLztN4ys+qeXLrc6CXsNPM5cIBGzGVe/IhELR0IAq45xRMBbH
	 5s7gDK3EfPeVT4ZV3jmCR+4mnN5fT97iC0uqZR4Xf6ZkmTY1k8Rps6MVi7TpE9Zdz8/QZ
	 YWxC+1EhflkmNEa0kpqAyuFklgXnQFFJZE1oiJi32vIiPEL3MB0Wjv9anuR6pbC+KIw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792793938;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=C7qjAgyKXAXRQdzS80eYoVzeXnkLd2ByTYUBCB7KpT8=;
	b=L//rXM2RVJZEDfmzmKxWaLeAtQm3U8sh8ivqeRzVCEmgeODHMA/ONThYWR3fBvCGEEVW
	 i9TaOgH/MAlruTctlf82wgMA7d3YGjq2Jxw326XU1LaDaZylI/dSODY0Rk/UJRKKqkZTz
	 eoDfA7XCox+ZhlsLVU/MSUOGkv9CQxuPfkO4Hw2uwdosP4fMFzvN9YA/LapsdXrwcabGW
	 pCE2KHWQVPTFsvlOnfTooJXVDy1kq15KrDOG8lyK6N7f1Otd8+3SULZNZo5EaP2oCIIMC
	 5nh8hcP2UbYAVkjKDJQEaf9j3s77QPY1goh7d5H0HoIgRLvMFtSlQjo9DbgU2v8KzCg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792793938;
	bh=C7qjAgyKXAXRQdzS80eYoVzeXnkLd2ByTYUBCB7KpT8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UrGYT4XT2awsYM4tl65krIOaTU+qNSGBUqm6QyzFIPxpbx4kP8OpQY5J3dDlmqjJL
	 PyAdSUXyyqT8bXqijjtOFTvu4PiQgEQiAVkQcJIRUs2g1upYTzpPQDbY+ajDNzwTOD
	 FPO6b0h2ZqHFWnPefMU1DOHJFyrXAQ6E01D9bazpHgzopgO2hvC8cxn3o+wHM1Wx2H
	 50hPnzyDwXnfqV17RxUQpSoAN/ZG/ntnAwIiIC91G4S39zCSd1Ctp+uoA3KPmhxxVU
	 MHwnltna5V1IJRKwIZ8Tjy7x8vTqPs9fry8SYwEUOV0natT0Df0CAYDpFdesgVI699
	 yTaqoI6uWDJ6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 40DA98169A;
	Fri, 23 Oct 2026 22:18:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DD7A279F
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 22:18:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CEEE760A7E
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 22:18:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cZBSfUusasSw for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 22:18:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B96BC6065A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792793931;
 b=augQMZ7Nn1PewV1HRpsIAdAjRqLdysYjwfuV0lpi/Ht6yE3rIaDiZtHR4eecLaSomouh
 IO/4dcZq9UDc9NE2lVsI59a0utGhRAaGoiQz5yxnwSPHElCvlVrmdTtRCLq0me3Az5w5L
 7ojynxNzc1hE8Id8fwRj7nEdHG0VbKaMOpXoPdxnPvkAXnxy4DUXozIJRYpNlVT1b62TM
 NBf+U59u9uQoU3dDs25pwjCnhwtQLVL9HI2pPxhNQs0mjJuY1rSi6ZdobFGozq7QgD6lx
 po19VrlIZwwlqaG+X+19qTTcTcBc1sotkaIL5e8cMxdJ5/bJsK3pBPBhqLuogFoTluA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792793931;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=C7qjAgyKXAXRQdzS80eYoVzeXnkLd2ByTYUBCB7KpT8=;
 b=LyQ2Hpe8eQHn2DGe2RjdXseclhYPQGRX/d9ZY3CkhSbeJqAF2GRRV4PaCEnuKENl4VUN
 hgCwIF+zMkiyrlzM1UM2abOyTDuXq7IhCIrETOYBOMYRyL9co1y+46aL40BzAD2UbWpaV
 fjzeYLQ0Ken+jieuVffNvPl3w2+hoLxg8TPvmgG3fv4s9o0MNQRBvBbQgFf+y8XqSnSCq
 Fh9OMY0GKJ+zCniXD6oKu+TzA3RfGKrrCK1p7clOS/Kb3/8TcvDGfCpkqGIms+k1vz3nF
 4rsvJOJusW6AhziG2TLP0ubZpBJN1LJAlW4ghwROm1e1xa8VLu9XyMKLeVzlfxcuJXg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=I+NLRqO0; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=I+NLRqO0
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B96BC6065A
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 22:18:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C1A3F60A54;
 Fri, 23 Oct 2026 22:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6ECA1F01825;
 Fri, 23 Oct 2026 22:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792793929;
 bh=C7qjAgyKXAXRQdzS80eYoVzeXnkLd2ByTYUBCB7KpT8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=I+NLRqO04ek3GqaZyF50MXbg5ioF13QEaQtL8pFhVjLCDmAecP0NMLJ8URNjR2ZLR
 RUyi9ccy1Tg8No8BFyYvDO19U2yQkVD1/n9jpppPUGt+e29grR1L3byK9s8xIVy2AG
 etqqKjoPle/0Rdm5ev6Cwcs09DzgR2jniWs4zR91HQmaSHaulRkBcwedEPWW8fklgO
 LYZShbm7mvQ4HQZYqxtDyNxmXhoxyrUV2yrr3jF34czEhcFRHmBZxS+kzqv6Dh/qKg
 uubytS+TNxAXlRA3JEnj8D9Cshq9dHvhDEqT1Oy53jGuuqHsRQb/nJHA32wTQRgjUR
 ZQHaJj64mmxfA==
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 24 Oct 2026 00:18:35 +0200
Subject: [PATCH v8 8/8] arm: u8500: Package Stemmy device trees in FIT
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-ux500-external-sdcard-v8-8-badcdf6db2ea@kernel.org>
References: <20261024-ux500-external-sdcard-v8-0-badcdf6db2ea@kernel.org>
In-Reply-To: <20261024-ux500-external-sdcard-v8-0-badcdf6db2ea@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Build all seven supported Samsung Ux500 device trees into the FIT
appended to Stemmy U-Boot. Select the appropriate configuration at
runtime from the machine ID passed by the Samsung firmware. Codina
and Codina TMO share a machine ID, so distinguish Codina TMO by its
board ID.

Keep the multi-DTB FIT selection, default device tree and device tree
list in stemmy_defconfig. This leaves the base U8500 platform available
to non-Samsung devices (non-Stemmy) using their own board, defconfig
and device tree selection.

Print the firmware machine and board IDs to aid diagnostics and future
machine ID mappings.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 board/ste/stemmy/stemmy.c | 77 ++++++++++++++++++++++++++++++++++++++++++++---
 configs/stemmy_defconfig  |  2 ++
 2 files changed, 74 insertions(+), 5 deletions(-)

diff --git a/board/ste/stemmy/stemmy.c b/board/ste/stemmy/stemmy.c
index 66330184af86..8526deeb29bc 100644
--- a/board/ste/stemmy/stemmy.c
+++ b/board/ste/stemmy/stemmy.c
@@ -21,6 +21,11 @@ static ulong fw_atags __section(".data");
 static const struct tag *fw_atags_copy;
 static uint fw_atags_size;
 
+#define SBL_BOARD "board_id="
+#define SBL_LCDTYPE "lcdtype="
+static ulong board_id;
+static ulong lcdtype;
+
 void save_boot_params(ulong r0, ulong r1, ulong r2, ulong r3)
 {
 	fw_mach = r1;
@@ -40,6 +45,70 @@ static const struct tag *fw_atags_get(void)
 	return tags;
 }
 
+static ulong fw_board_id_get(void)
+{
+	const struct tag *t, *tags = fw_atags_get();
+	const char *str;
+
+	if (!tags)
+		return 0;
+
+	for_each_tag(t, tags) {
+		if (t->hdr.tag != ATAG_CMDLINE)
+			continue;
+
+		str = strstr(t->u.cmdline.cmdline, SBL_BOARD);
+		if (str)
+			return simple_strtoul(str + strlen(SBL_BOARD), NULL, 10);
+	}
+
+	return 0;
+}
+
+int board_fit_config_name_match(const char *name)
+{
+	const char *dt_name;
+
+	switch (fw_mach) {
+	case 5000:
+		dt_name = "ste-ux500-samsung-janice";
+		break;
+	case 3296:
+	case 5002:
+		dt_name = "ste-ux500-samsung-gavini";
+		break;
+	case 5003:
+		switch (fw_board_id_get()) {
+		case 0x101:
+		case 0x102:
+		case 0x103:
+		case 0x104:
+		case 0x105:
+		case 0x106:
+		case 0x107:
+			dt_name = "ste-ux500-samsung-codina-tmo";
+			break;
+		default:
+			dt_name = "ste-ux500-samsung-codina";
+			break;
+		}
+		break;
+	case 5006:
+		dt_name = "ste-ux500-samsung-kyle";
+		break;
+	case 5008:
+		dt_name = "ste-ux500-samsung-golden";
+		break;
+	case 5009:
+		dt_name = "ste-ux500-samsung-skomer";
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	return strcmp(name, dt_name);
+}
+
 int dram_init(void)
 {
 	const struct tag *t, *tags = fw_atags_get();
@@ -96,11 +165,6 @@ static void parse_serial(const struct tag_serialnr *serialnr)
 	env_set("serial#", serial);
 }
 
-#define SBL_BOARD "board_id="
-#define SBL_LCDTYPE "lcdtype="
-static ulong board_id = 0;
-static ulong lcdtype = 0;
-
 static void parse_cmdline(const struct tag_cmdline *cmdline)
 {
 	char *buf;
@@ -181,6 +245,9 @@ static void copy_atags(const struct tag *tags)
 int misc_init_r(void)
 {
 	copy_atags(fw_atags_get());
+	printf("Firmware machine ID: %lu, board ID: %lu\n",
+	       fw_mach, board_id);
+
 	return 0;
 }
 
diff --git a/configs/stemmy_defconfig b/configs/stemmy_defconfig
index c253780df2ef..7c9df043457e 100644
--- a/configs/stemmy_defconfig
+++ b/configs/stemmy_defconfig
@@ -12,6 +12,8 @@ CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x100000
 CONFIG_DEFAULT_DEVICE_TREE="st/ste-ux500-samsung-janice"
+CONFIG_OF_LIST="st/ste-ux500-samsung-codina st/ste-ux500-samsung-codina-tmo st/ste-ux500-samsung-gavini st/ste-ux500-samsung-golden st/ste-ux500-samsung-janice st/ste-ux500-samsung-kyle st/ste-ux500-samsung-skomer"
+CONFIG_MULTI_DTB_FIT=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x100000

-- 
2.56.0

