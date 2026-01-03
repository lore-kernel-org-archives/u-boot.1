Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC705FC6165
	for <u-boot@archiver.kernel.org>; Sat,  3 Jan 2026 00:22:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9189B83C04;
	Sat,  3 Jan 2026 01:22:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ye24Zk1Q";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vpAtykJd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F4BF83A64; Sat,  3 Jan 2026 01:22:01 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B8A583BDD
 for <u-boot@lists.denx.de>; Sat,  3 Jan 2026 01:21:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4djh86633Vz9s7H;
 Sat,  3 Jan 2026 01:21:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767399718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GUotB6uy07ZTFwhvSU/Aqsj9nhOfJJV+FvvG4PAgvMA=;
 b=ye24Zk1Q6P7USPyHIVs6vrGpXk8LfR8U8pxdtyOh3LX0GMr2sspNqHGIO6Laqp1y03upca
 8VTgSOYm/0ZhJA1DuEhW9YL2bQ6kSQ9zDebLa1AQwBgRg5jIWQRfJ5tPNs6vjEYillE+cL
 m4EyN/gWWsCoHvQUQVDZr7cX4Dqg7lXYCWhGpZ+RSyDgBvPQ+gSEAwPQd0iyCxOrHoQsIJ
 GDSgXV6PXzP8331k/lOYfB8calKxMtzHGjFkjpTZVwEy7htXGd/AovQkTyoVIW+qcDOwvs
 /PuIvm5vylY91KcAf2If7o6Pw3Gre3HiDasr79EKqJ6ifrq1Y99gNBnEJcyhOg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767399717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GUotB6uy07ZTFwhvSU/Aqsj9nhOfJJV+FvvG4PAgvMA=;
 b=vpAtykJd0n1o0sEbHxiqlUGu0XQt9j4yHx0Z/tF1yfKwKlI2RogTRLQsHIfrEEtxyzbx5u
 S6Bio1/IgigB8Rj3KuII9TusbYAbtAbxUotJL3VDTFinBN78cgMpAqSiJEaIFlaLb9tXKN
 g3q9uijVRqHIsvP43XSqulOPCyCsUNXkuf/f/UYHkaxMT4vSwZP/WDHwU+aASDOEZyFe0N
 NF/5e6UDL1RguMAyCvN/HRs3oicscQvP+CHkFABJGx49rAJy+Dwv0IRzVzBwwII0DcJddy
 5TxRmC1G3e4+bHLnCKs8/6tS7mPhdh1e7bQyd34UN/I88D+J2oa9ZlFWDPXFBw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 2/2] ARM: renesas: Enable fuse driver and misc command on
 R-Car Gen4
Date: Sat,  3 Jan 2026 01:21:11 +0100
Message-ID: <20260103002151.183285-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260103002151.183285-1-marek.vasut+renesas@mailbox.org>
References: <20260103002151.183285-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: h844wpm9hwsy1n5g6or5m4btiyjxargs
X-MBO-RS-ID: 0006228358df13cc606
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

Enable both eFUSE driver and matching 'misc' command to read out
the fuses from U-Boot command line on Renesas R-Car Gen4 SoCs.

Example usage, read out R-Car S4 OTP fuses 0x144 and 0x148 which
contain UFS tuning:

"
=> misc list
Device               Index     Driver
-------------------------------------
fuse@e6078800            0 rcar_efuse

=> misc read fuse@e6078800 0x144 0x56000000 8

=> md 0x56000000 2
56000000: ........ ........
"

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: u-boot@lists.denx.de
---
 configs/renesas_rcar4.config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/renesas_rcar4.config b/configs/renesas_rcar4.config
index 6ebd93ede9f..675dfc95a81 100644
--- a/configs/renesas_rcar4.config
+++ b/configs/renesas_rcar4.config
@@ -4,11 +4,13 @@
 # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
 CONFIG_ARCH_CPU_INIT=y
 CONFIG_BOOTARGS="root=/dev/nfs rw nfsroot=192.168.0.1:/export/rfs ip=192.168.0.20"
+CONFIG_CMD_MISC=y
 CONFIG_CMD_MMC=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_MMC_HS200_SUPPORT=y
 CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_RCAR_EFUSE=y
 CONFIG_RENESAS_SDHI=y
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SYS_I2C_RCAR_I2C=y
-- 
2.51.0

