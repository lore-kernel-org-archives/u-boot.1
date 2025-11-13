Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33634CD5BCE
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 11:55:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 908F883E1B;
	Thu, 13 Nov 2025 12:55:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="QRSdAmUN";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kpbsmi8b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C010283E1E; Thu, 13 Nov 2025 12:55:46 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E66E083E0F
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 12:55:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4d6dy85JWTz9tDm;
 Thu, 13 Nov 2025 12:55:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763034944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=XqIyLowf1FEXLOfHe0mEOMRFhUQPf913ls90c3ZC5H4=;
 b=QRSdAmUN+3oh7CKnGBJKsaNCvUly4FUebhhUAjvvop0R1Uv2h+RoMV+YdOEHNdJq/CNqcp
 qC+7jNLGkbQ1dNOVvgxylWNZSawlfPQJjFBRJcWAfGghdudvlGx29iKqg59tWlLtZi9Lan
 kzMHsUks81fune1HNePP5+mYzNTgQsPvFLqTwE4YYug0YoD6cjKVGuJoKdoSLg1xcVbs01
 bvO5wugr67UcDj+sWanv7w+sbRRL41iBI1g/hlvPb5QwNAEfwyGFtniaCbNdrUlr/CT/dz
 roCZylKWbOoBGeJ3fGVfKWgY58f/zkCLWX47lMmOGsLfg87sOU87xrPko5cugA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763034942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=XqIyLowf1FEXLOfHe0mEOMRFhUQPf913ls90c3ZC5H4=;
 b=kpbsmi8b0fV1mYnP8TmXdtOKBNVamhVT1i2E4ciZxLyXXACi09fDIie/H7xAf/CWBD5oLg
 F6zv1Jyxps0PMZfRA1f3h/WSO9RR5mpkzN2k2qqoCeYCYMy6RN19in2EtNHFHKlMiQusf3
 azDNpny2SbWgFP2oTBsst9MEirKnnPOvUnApoFbzkqVrzddxhyHpf0e7O7hNsIEAxxs4ep
 eMqjHjo0S/DPBjLR6vzoMv8SAOhMuOhElDFtWEDeh0jozDMDd0QfageQQ6ExBnnmBluWPq
 QqFsBVW5QQbR6ac/jno9PwAgVcDdsFZXefO8sEcojEge5Td/SZifqB2LfY02KQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH] arm: qemu: Eliminate fdt_high and initrd_high misuse
Date: Thu, 13 Nov 2025 12:55:28 +0100
Message-ID: <20251113115539.947871-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d20ea39b2fd3936d036
X-MBO-RS-META: ndrghhzbuk39mw59qutxzqpu7n6w4f7n
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

The fdt_high and initrd_high have nasty side-effects , which may lead
to DT placed at 4-byte aligned offset when used in place, which then
prevents Linux on arm64 from booting. This is difficult to debug and
inobvious, with little to no gain. Remove this to let U-Boot place the
DT at correctly aligned address.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Cc: u-boot@lists.denx.de
---
 board/emulation/qemu-arm/qemu-arm.env | 2 --
 1 file changed, 2 deletions(-)

diff --git a/board/emulation/qemu-arm/qemu-arm.env b/board/emulation/qemu-arm/qemu-arm.env
index fb4adef281e..f74f251712a 100644
--- a/board/emulation/qemu-arm/qemu-arm.env
+++ b/board/emulation/qemu-arm/qemu-arm.env
@@ -5,8 +5,6 @@
 stdin=serial,usbkbd
 stdout=serial,vidconsole
 stderr=serial,vidconsole
-fdt_high=0xffffffff
-initrd_high=0xffffffff
 fdt_addr=0x40000000
 scriptaddr=0x40200000
 pxefile_addr_r=0x40300000
-- 
2.51.0

