Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25111C02199
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 15:06:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B9B7807D7;
	Sun,  9 Feb 2025 16:06:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XVEy5ikB";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NIxBe4GR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 205D6807FE; Sun,  9 Feb 2025 16:06:37 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E506B80141
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 16:06:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4YrWJ84QrTz9swM;
 Sun,  9 Feb 2025 16:06:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739113592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=FV+mGBQPtEA8wGacevcR+H1Hfs/dOhAdOEoibHWD7W4=;
 b=XVEy5ikBzWVwDpzaveezjyX6Pv+xrQy0on+b+6aTKdtArylvKP1AVkCS/gZo6gzNUIIBl1
 e/V/eGNYYJHICkQxIBz6Kh6k1NQoIvrP75afWJhw/wlSNG/mtrux5ibzLrlDpvmiPVJ6YP
 2rtgsUX5WhfotTL52qBKaYZBzxiBYHlSnQa7mWVnDLCyW8fMKevjeAWKisf9yfPJksUmbh
 xAAflZfS0wuVrr8YeBYQq4rAHfOULtPnnMlcopt/mcfn4oZJCk7FM39RflTUIJW60K80gB
 ot/Pw/fskzynF9N4VpbyaVkE6itkg7C8vCTZwKszWc/afbKzm/zlhikFI1heTQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739113590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=FV+mGBQPtEA8wGacevcR+H1Hfs/dOhAdOEoibHWD7W4=;
 b=NIxBe4GRl21zFVvibwYOXJONOTUy29BbpCUHi0P8ViRkGCpmRlXNicSxlGC13fnhzwCawX
 gkipiooEy5F9ElbGOlmweWATgXa+pMNq4+60JxdJ7MR3qbylu930gVBwlQgRSDeoi+PcjQ
 z23TdLqFBwsuCDjdzwCBIo4qgYPhnU9HpXVBEAIq1GyOCRpCtmX/5DBsDp1aM/IFqBU1Qy
 7+NheuKQY3c12JdGYAHe7DM3erG5DqmcXBQG8MPx2Lxb34gQ8c2NUYAQacY21rG2rd2PGP
 o6R0UkshpFOPNhxyedMbo9oLYgonL85LYVt6eIllk40QvtxbLvIPE9x0gYpDrg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] ARM: renesas: Enable USBHS UDC and UMS on Renesas R-Car Gen3
 Salvator-X(S)
Date: Sun,  9 Feb 2025 16:05:16 +0100
Message-ID: <20250209150616.117958-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: pb7373ehx3asr5azaabfm3gmy3ja56ih
X-MBO-RS-ID: 4f5fff448a8c7cbf72b
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

The Renesas R-Car Gen3 Salvator-X(S) boards contain USB micro-B port
on which the USBHS controller is accessible. Enable the USBHS UDC
driver to make this port usable, enable UMS USB Mass Storage support
to make it possible to expose block devices as USB Mass Storage to
Host PC.

The USB VID/PID is picked from R-Car Series, 3rd Generation reference
manual Rev.2.00 chapter 19.2.8 USB download mode, and matches R-Car H3
BootROM USB download mode VID/PID.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 configs/rcar3_salvator-x_defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/configs/rcar3_salvator-x_defconfig b/configs/rcar3_salvator-x_defconfig
index 6b095f63549..39a98ccf577 100644
--- a/configs/rcar3_salvator-x_defconfig
+++ b/configs/rcar3_salvator-x_defconfig
@@ -28,6 +28,8 @@ CONFIG_CMD_DFU=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_OF_LIST="renesas/r8a77951-salvator-x renesas/r8a77960-salvator-x renesas/r8a77965-salvator-x"
 CONFIG_MULTI_DTB_FIT_LZO=y
 CONFIG_MULTI_DTB_FIT_USER_DEFINED_AREA=y
@@ -74,4 +76,10 @@ CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="Renesas"
+CONFIG_USB_GADGET_VENDOR_NUM=0x045b
+CONFIG_USB_GADGET_PRODUCT_NUM=0x023c
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_USB_RENESAS_USBHS=y
 CONFIG_USB_STORAGE=y
-- 
2.47.2

