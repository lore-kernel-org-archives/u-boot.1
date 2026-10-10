Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28869CA9EC5
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 22:32:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E04B36090A;
	Sat, 10 Oct 2026 22:32:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iblJbvoIQ9o3; Sat, 10 Oct 2026 22:32:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8AF9F60702
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791671544;
	b=rkEurFwnrHNbUe6edIUvB/vP/FPMV2maBvIsKjph24dwXf3alTCTcGVIQRSwmWxB90bC
	 /ybeBZDl1kWKoXbnJcV9iAGMx1xH8etbI7gE+Mq8bsX5komiO33gA87T4yWWkIYBZzG3B
	 qF+7ZNFkXUSdz+HL85tSVEdDtaI9CgzcYRclnrIBDfl6b52DGDVC/4ux7S2kBgv4Wfcgg
	 5GVm+tSnS01Xr1Ya4UTXDuEi72Eak8mva7T/HpEUWlRxbaO7BrfyedX/lF5xokuzdyHfw
	 Nm+b+4Qn9jh+Oy2UIMiGlczV9SCr0FdkY3TyQ+X90qG6HXnIOKrZOYoiLvhKAC7S6uA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791671544;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=N5Hyw2EzqgQ6/cMZL6WrWlOmjyDIctQ3Bdg0jhC5d4w=;
	b=pvNHKId9p+5F8dO6HeCi/uK3KL1wAemnhr1jizdeHOQngmTJ21RAvUOx7vPwUFZ04Tm3
	 um1isaD6d1jigfC3iK7H/AiUW6xY1UzulHAu+hvGhSFghO6P0qXsGwgNswJxFbpWqIQ4U
	 y8KQokrBn4ReQ2r7L6nxkzjKsSSaulKEn2cOvxLJwUJlFaWEIoWVlNwABklxdzQHL9Kvv
	 5G52+Opr0RqxhjL87SMyuv43XuqEJ/PPD5jvPSPQ3lcWsMRagFiNI92w1K9uxVWuiR4Dy
	 RWrd2uEXwaichLcBU1iVYpLpuxSDK8I4jGJYe85uzuUKQNechydXNVFunOc96VR5vOg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791671544;
	bh=N5Hyw2EzqgQ6/cMZL6WrWlOmjyDIctQ3Bdg0jhC5d4w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=ExCu1fWE4kXTTJJxdwERorJE5Zsza7buBUAtY/eR2n6jzF7x6Ey3kW4gF1LckcnNp
	 uIrwBrsj/ec2u3Gi7krPFrI88VG+FLwQO7kB4jCOD7aS72b14O3iZEX2PKprJxkn1E
	 e5d6AG/Ye2goiQLKc17vym/57rT7lu7TxuvbHb3NrDtca7uvH0PrYND6Tn2IQhNSgj
	 nVrJr9DnnFHoDpgbq2c2kXT+58Mtvddtw6S61bUdznvWmUHrZyXzsdDNOKu4TXikRm
	 nprOpt3BDpROehpzKtINaM1m09NtMJNZC0cAPqBipHIsXSUgBrmyfE5E1VVbSYMkhh
	 DoGwTeJMof0sg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8AF9F60702;
	Sat, 10 Oct 2026 22:32:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1F2A2317
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 21:08:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 10B0481021
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 21:08:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vl2Hc28kcDok for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 21:08:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 41AB980E31
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791666489;
 b=NRwohKvVcCBobNbBIeabiASSgdqOtwXuZq2QPJUo2i66UvCKS6KQi8bptsnZ+DpCzm5B
 7aIzWv+r+Jx0WqUfwjh9i4VBeIAd4+ADzC43RW5qs8UFvmGR5y9GxcM+9kzcApi316pGs
 F5rRoNA6IKp8dBAzbJwXe/GhJp0WcXKScWIqzrflUQe1RUVn7cGf6roBrZV0J+inUYzuC
 a7NKOs4LoAYLvYX7E3hRA22vJsOAJ30784XgR0zUSjqjn/PYsoM+xZDz/1sMWzInVbhg9
 F4zVa2ZiVFJat3FTJixMDIudT08cWME1AfguguyEjDIPXa5l8LeSf0/euWbFg7D2i+Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791666489;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=N5Hyw2EzqgQ6/cMZL6WrWlOmjyDIctQ3Bdg0jhC5d4w=;
 b=tEShKwaFznVYw5p7XrxSCvEwey5zo0cn0ZCpvkyY+Fj8Qi4AcJ8FfEnPwYWwLCnLuWGz
 ju0ApS9z6VDQNGuq/wNoR9RujQMGzifZaD2RFXgwhInZqXCEIo8PPVQ9zylN7I/Hu+jc4
 yTO20hJZpFw45mC3BN8z/D5AeozFS78Ld9qv2fJwUhbvcYF2UtccK3W+1MN1fCHJCesXp
 nmlHo6TCb8toGoAbfBB78EfhzG/gQHCQN7c+mQF+E+X2fd2yGAvkRyjaVc2paqmy49+wv
 ejV6/iRyyyfmDCtrTjYCFopWoY0Qiz2nlRGTNuE9eT1ZrJvNDPffEFJtARvxn6IkPlQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ailgvfwp; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=ailgvfwp
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 41AB980E31
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 21:08:08 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id CDF0D447A1;
 Sat, 10 Oct 2026 21:08:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE160C2BCB9;
 Sat, 10 Oct 2026 21:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791666487;
 bh=HQVFg0Y5nRzCSkCiTf9L5Imm7YmOZjThwqY7tDw9AqA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=ailgvfwpHQzil4ls1ZOOb93nWQmKUQ4tae6jiH2GozbWnfBg2QZzOjGEoxTY121jY
 0440l2adN3CBe95g0y4oKm/4oF+RdlTuOM3bWzPTxUfzZml/je46KtYe7CRRlAMbvV
 sZeXD1zfbCcZ8zMA7uFGlk2I/vPDdQU1EDkgSbyjMnI9zqVir0/iyKea9wgrEiks0z
 Q7rM7CunPnwEl1mi4PpGI4ccw2mcnh13bf3DTgA5DmrUlGv4LJwvFs3IGtpZm2S+S2
 LlLmG+Wzem/6WcvhEvX0eZoXVC8Wv6zVxHD0v+y46+1sX68TwamjUUMKA/Ye9H3ZFv
 A04lkBoISEsag==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB6DCA9ECC;
 Sat, 10 Oct 2026 21:08:07 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sat, 10 Oct 2026 23:07:59 +0200
Subject: [PATCH 11/11] doc: usage: add phonemenu command documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-b4-phonemenu-series-v1-11-bfa23de6eb0b@protonmail.com>
References: <20261010-b4-phonemenu-series-v1-0-bfa23de6eb0b@protonmail.com>
In-Reply-To: <20261010-b4-phonemenu-series-v1-0-bfa23de6eb0b@protonmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Frank Wunderlich <frank-w@public-files.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Brian Sune <briansune@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Petr Pavlata <petr@acrux.cz>, 
 David Heidelberg <david@ixit.cz>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Alexander Martinz <amartinz@shiftphones.com>, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791666485; l=3888;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=4rKlXqKLw5bbyh0WBX0SFqfRP/5sF4LVx6wodC4de+k=;
 b=sU/Uc0gIDUYK9ONTVYUdX4FFeTZootMqvUISQ2XKyzGOWPGjuyszS+6DWnDQ0YOmhTD3wuajc
 4LMgz0gc4lFAJ3UgTPdEULCs7OWMexy8Rf/4rkMb4yc0pt48LS9+4R/
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sat, 10 Oct 2026 22:32:12 +0000
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
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Petr Hodina <petr.hodina@protonmail.com>

Document the phonemenu command, its menus. header and the
phone_poweroff, dfu_pwr and usbether helper commands.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 MAINTAINERS                 |  1 +
 doc/usage/cmd/phonemenu.rst | 92 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e4c108a0412..23382090ffd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -687,6 +687,7 @@ R:	Sumit Garg <sumit.garg@kernel.org>
 L:	u-boot-qcom@groups.io
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git
+F:	doc/usage/cmd/phonemenu.rst
 F:	cmd/phone_util.c
 F:	cmd/phonemenu.c
 F:	cmd/phonemenu_qcom.c
diff --git a/doc/usage/cmd/phonemenu.rst b/doc/usage/cmd/phonemenu.rst
new file mode 100644
index 00000000000..918dbcfc44f
--- /dev/null
+++ b/doc/usage/cmd/phonemenu.rst
@@ -0,0 +1,92 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+.. index::
+   single: phonemenu (command)
+
+phonemenu command
+=================
+
+Synopsis
+--------
+
+::
+
+    phonemenu [advanced|diag]
+    phone_poweroff
+    dfu_pwr
+    usbether
+
+Description
+-----------
+
+The *phonemenu* command shows a boot menu on devices which have a
+framebuffer but only volume and power keys. It is enabled by
+CONFIG_CMD_PHONEMENU, which depends on CONFIG_VIDEO and CONFIG_ARM.
+
+The menu is drawn pixel by pixel with the video uclass and is divided into
+labelled sections. Navigation reuses the bootmenu key handler, so a board
+which maps its buttons to keys with CONFIG_BUTTON_REMAP_PHONE_KEYS works
+unchanged: volume up/down moves the highlight and power selects the entry.
+The same menu is also drawn with ANSI escape sequences on serial and USB
+CDC-ACM consoles, where the arrow keys and Enter can be used as well.
+
+advanced
+    show the advanced menu: TFTP and PXE boot over USB Ethernet, serial
+    gadget, USB mass storage, fastboot, DFU and the diagnostics submenu.
+    Entries are only present if the matching command is enabled.
+
+diag
+    show the diagnostics submenu: clock, environment, bootargs, board info
+    and button dumps.
+
+With no argument the main menu is shown, with *Boot*, *Advanced menu*,
+*Reset* and *Power off* entries. Each entry runs a U-Boot command and the
+submenus return to themselves afterwards.
+
+The header shows the device name, U-Boot version and a status line made of
+any of the following, each omitted if it cannot be determined:
+
+* the active A/B slot
+* the boot reason from the Android Bootloader Control Block (for example
+  recovery or fastboot)
+* the PMIC power-on trigger, if the platform provides it
+
+The block device used for these lookups is selected by the *storage*
+environment variable, either ``mmc`` or, by default, ``scsi`` (UFS).
+
+On Qualcomm Snapdragon the A/B state is kept in the attribute flags of the
+``boot_a`` and ``boot_b`` GPT entries rather than in ``misc``, so
+ab_select_slot() reads the slot from there when CONFIG_ARCH_SNAPDRAGON is
+enabled.
+
+Helper commands
+~~~~~~~~~~~~~~~
+
+The menu entries use a few small commands which are also available from the
+console:
+
+phone_poweroff
+    power off the device using PSCI SYSTEM_OFF. Fails if CONFIG_PSCI_RESET
+    is not enabled.
+
+dfu_pwr
+    run the ``dfu`` environment alias and leave DFU mode when the power
+    button is pressed. The stock DFU loop only exits on Ctrl-C, which a phone
+    does not have. Requires CONFIG_CMD_DFU.
+
+usbether
+    bind and probe the USB Ethernet (RNDIS) gadget on demand, for TFTP and
+    PXE boot. Requires CONFIG_USB_ETHER.
+
+Example
+-------
+
+::
+
+    => phonemenu
+    => phonemenu diag
+
+Configuration
+-------------
+
+The command is enabled with CONFIG_CMD_PHONEMENU.

-- 
2.55.0


