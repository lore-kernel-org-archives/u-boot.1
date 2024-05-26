Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD8F3C25B75
	for <u-boot@archiver.kernel.org>; Sun, 26 May 2024 18:02:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9ABCC880A8;
	Sun, 26 May 2024 20:02:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="sRJtOa9y";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CxG3qBce";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C57AC87D07; Sun, 26 May 2024 20:02:03 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA77C88077
 for <u-boot@lists.denx.de>; Sun, 26 May 2024 20:01:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4VnRS52Rmyz9sdZ;
 Sun, 26 May 2024 20:01:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1716746517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=cDf9fKhnmAAtGjnHld2JbXUKPIxvodD48FU/dBzIaFk=;
 b=sRJtOa9yT57lWboO0XoMLh282W+j7ybQSe6+3AfQ9Ae+dCLeKnXYK5/yB5MBWZVOyiha2h
 G7HHqV79W0UUj9XLaK7FG/d+I5acH9rge44WJmb1s3AQzh4j+gRRgJg9ucvlTTuIzD2t+l
 Mmv82oPjLs3vYZ2B7alkj6fB2cmmWTQunC7+cyktJ5y96AOQwX+ks8JRmoAKFxayIC9M4l
 AcAQpu+tCslAB9t/zdIUca9FSai3+EkHNSu9/w3GDAOzc450pPsq1rX0J2TGL2WLz+4Y7m
 d0rgKAjwn0ZpORw8gpSUh3EKn+TLi5n6sHGvtMlpCX939f/PkmF2q76DLx7WJg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1716746515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=cDf9fKhnmAAtGjnHld2JbXUKPIxvodD48FU/dBzIaFk=;
 b=CxG3qBceUdpZkM44yZIZLcFkl2EO4h8mqsAapk4Ko5FAoMB64Fsr2Mzgz0px2Iwv2zcPMO
 tVPsqchOgsjXxLYKJW+RcxwFjc83WZWEwjA4dlRBLxDEeWCsvd60Uk4OJwHSq+A2TO5/CY
 pGVnRbIq41Zfmg3rNJrPmyFC+5bwaAQmtlYxyJ8XsIKSwuHDZzjchRG3EN3CxNK00yOqib
 FjrPApXug417LM/hyLEXv53GpZ+R4BAUxOoH5Ivdi7vJI/w51EmfXq3Z56sYLdwe69hqXy
 o0cHCl99/8AZNwLmx/Ov9P5JP1REMQ2eO9V3m1CFsjKj4tN+XtRJTJFHZrx8yw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] ARM: dts: renesas: Switch to using upstream DT on Renesas
 R8A779H0 V4M
Date: Sun, 26 May 2024 20:00:25 +0200
Message-ID: <20240526180128.2807306-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 3w31npo16fjxjri86gkb7ss8m7oncmt5
X-MBO-RS-ID: 0a1746cca99fe7bd9bb
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

Enable OF_UPSTREAM to use upstream DT and add renesas/ prefix to the
DEFAULT_DEVICE_TREE. And thereby directly build DTB from dts/upstream/src/
including *-u-boot.dtsi files from arch/$(ARCH)/dts/ directory.

This patch finalizes OF_UPSTREAM conversion of R8A779H0 V4M which DTs
landed in Linux 6.9 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 configs/r8a779h0_grayhawk_defconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/configs/r8a779h0_grayhawk_defconfig b/configs/r8a779h0_grayhawk_defconfig
index 6bd872f063f..a986a09b8e0 100644
--- a/configs/r8a779h0_grayhawk_defconfig
+++ b/configs/r8a779h0_grayhawk_defconfig
@@ -5,7 +5,7 @@ CONFIG_SYS_MALLOC_LEN=0x4000000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0xFFFE0000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a779h0-gray-hawk"
+CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a779h0-gray-hawk-single"
 CONFIG_RCAR_GEN4=y
 CONFIG_TARGET_GRAYHAWK=y
 CONFIG_SYS_MONITOR_LEN=1048576
@@ -39,7 +39,6 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
-# CONFIG_OF_UPSTREAM is not set
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
-- 
2.43.0

