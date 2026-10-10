Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263D0CA9ECA
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 22:32:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C29EA80D1E;
	Sat, 10 Oct 2026 22:32:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id munCNP0pQa7r; Sat, 10 Oct 2026 22:32:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B882B80C34
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791671537;
	b=dYVLqkJ//BVNlA8qwPwc6gPd2auSjXTS8Rp20ae8+Q/WedSW/kcPmYewSmCT2SVU4VFt
	 z+i1TJbMxjHN30hVaopbvap2hGPisDUvQre8fmiS5DAK+y00kr3IzGi6tVa5dvAs+BYZl
	 Ih9bIDM55U/kexXsP/aU1BHRfhkzx0JEq/yzBdSRzWZGgseYA5Ftp8Ou7lVh9v1HoKR9n
	 HqoQzdcTy/OFgpDeAKdx/PsBkwpBTSLhfu1kbSjgRvG0q0CzuxNz7gy7TkQrthsYKdgIp
	 TkbGjfuZ+/8GqBmOJVZfJeYWv5A43+sDgrrPmqZ0KMeyOSOYp+qhOtO542kBULo2cng==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791671537;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=D0OWz0g9MYSsZtS6QxBc1/6vR147vE/A78Pm/VaNKyA=;
	b=WmyEPTlj1ycQU62USe+W8ni2o5fDXV5vVMaQKg3b52clOGZRzWeWnny/DrlHunK0xIs4
	 dbz10B0y7f1C4b9kTTZCDey+8n/NYuDiklcdU+tmmxfoknrtmorckePhu8NtUB55V0B/b
	 77rL/GdBoct/Jl5v5fTKM7tDK7NZI6sqiiq+X51qOWwmGQ/1tN2/P1lTO0kp/pg2hwVR/
	 tmQa+bng0yYeo+83cJFFoux+os8DGLerJ1MPXlPRYUZAE4Mh76+ux5aq/kzTlbem3QfSX
	 mAp1y19LVWbG37bxGdLEiWDGZjpB03ZNS9rJscXGWB7Mj3bYUYn579rDOT9FrQciBZg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791671537;
	bh=D0OWz0g9MYSsZtS6QxBc1/6vR147vE/A78Pm/VaNKyA=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=M6lWjM3fCCbfvQBdVtIJBicxiUAtX9lF2AoBwtIy/0AasNq/mvQkA8dY9Jwkp1GqB
	 4/QEK3Oe5RyUkxm1MRYYaK4Ddk5TcNDhqJC8lLgU6zFz66AxSJByTerVZ7Kl4miPym
	 6ZYPhVy3xyOqI2gtJPqaNK4GdazgNGaOGjF9j82AigaS9AtmGIWR0CFpjLJvCMxkv3
	 eZc8DdjRoQJnop3JH/ygOmOV7ATJo9R1qn/RQgP/TZUnx07UCWOi9O1b25lmqfWTai
	 +FoIxujUzRJvx56meG5V8ZBD+fck8KVDRIjUmi5U3oQ/jZGEzO5iNxA9iRqQ73BPFq
	 JtR/cfXrYGL1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B882B80C34;
	Sat, 10 Oct 2026 22:32:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AAE709D1
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 21:08:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 90F2E4082D
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 21:08:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J5QDIgXiB2jo for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 21:08:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8D8074082C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791666488;
 b=LbFcxBzpc+uCMX+STSzE4A8ouOlmK5hUdzLrxPAVcn9Q6/fltpGVPJscJulfa54rvBSB
 REK9RIIf5voYElIlPst4dN9MHHB9rvLMMEhI3AFGL2ppS3xMxmg1p+6Lk1FF3mFFSjUSt
 pPa1G1PiT9c/gQI3K/JH6H1xI9fVMQiChpSEZYpAoHKIFYfOroKwE9D+YlNf8NoDng1Fu
 4ayLCSLLUSHzr5uvm0/X4FQ0EF7Zix+H7SuE150PfyRIk3e5AyJS+23ARc8W5lKbjGGXh
 0sC7J/keGSiiSLM21Zqnq+iG2KLK6mexgHqNAn2znD//6O0Sc2u71g6Jcv/aJzkSOZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791666488;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Subject:
 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To;
 bh=D0OWz0g9MYSsZtS6QxBc1/6vR147vE/A78Pm/VaNKyA=;
 b=IVTNxXUzU62tvo3A4WN79AHKCVmtp5ZWomMNK+4nlyfPDM52lqZpBLobGJ/Jubn/zVY6
 0SPI9vpsZH9cfeJuM3f6nUO+1dlPUIxWnzYqDfpwvYZa1OkPu9ZyQR7aLSN3i7O9j4CBm
 d5NQpTXTKeFlEMLMAR7iaY5uJ15RKP/HofU0VBVlmNGvEHvLW0HemaknSh+1uBRLaNQKl
 S/G7//RJD4KwxbUBXHTFHllyyLm59XS40PZqnQyIxWFbgp4Kke1YjOLG6hZDzs6tfYgti
 5u4rKwVw2HzXBG7yrlgFD7OwE6uTuDuhb6xTqlkhKM2HFL+ckuBTzgS2MhIKmJsfXZA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=VrmmkY27; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=VrmmkY27
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8D8074082C
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 21:08:07 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2C67E41238;
 Sat, 10 Oct 2026 21:08:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0AA33C2BCFA;
 Sat, 10 Oct 2026 21:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791666487;
 bh=7APOP7QbN4fzG5Ms4rgUh81UyGymuMvzRWMyCEU7A5Q=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=VrmmkY27YLaCIXeS5w9yBx5Kmrn52ZXFe5IUI/k7PnxCLrQFw6ysU7nssWVQKYqFI
 nx1PjGa7O5yJgiUGEwy8NgViw9pvPtnreYww1U2KHmI+6t3feaXEB6JoV3gcCBgrm3
 P9pInTjsICWWMz2AR/sPOSSoLG88KeRL4TMqISNG2R/18xxUk5bucDSEnJTddiNc90
 Wctbo6P1tHkoGhIVtzLuNrCuZdQ6pEgEdsJAxgX1UX2dXNeSqW0JeUVTx76P6lmVKs
 Zy9em3Kvh0+37HS7elWDyl602ypccOVqdI4GYPEaGxyVVK3yaBjuXwmJ7oK2zKW5E/
 auunSTw/a0Zww==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id D928ACA9EC5;
 Sat, 10 Oct 2026 21:08:06 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Subject: [PATCH 00/11] cmd: phonemenu: phone form factor boot menu
Date: Sat, 10 Oct 2026 23:07:48 +0200
Message-Id: <20261010-b4-phonemenu-series-v1-0-bfa23de6eb0b@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ5AMBBA4avIrE3SUj9xFbGgBiNR0iIS6d0Vy
 2/x3g2OLJODKrrB0smOVxMg4wj01JqRkPtgSESSSyEFdgq3aTW0kDnwj1FmQ1aoMi9SpSCUm6W
 Br+9aN7/d0c2k93cF3j9l3iUUdwAAAA==
X-Change-ID: 20261010-b4-phonemenu-series-15f574867344
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791666485; l=3116;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=7APOP7QbN4fzG5Ms4rgUh81UyGymuMvzRWMyCEU7A5Q=;
 b=5alhi/tvg9vdbbCIjVlQiwcTXeft2MDX97az5pU9Fiye2H2atCU2vOxY91xxkk6vn3ftFMCw1
 W00mrR3fpOiDEihjNFJbR7WNSpRaiuA6T8p1oxFHrz4De0P/yakEVGK
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

Add a boot menu for devices with a framebuffer where the only inputs are
the volume and power buttons. The menu is SoC independent and SoC specific
parts hook in through weak functions. Qualcomm implementation is provided
in the patch set.

1. Add helpers for several commands. dfu_pwr is needed because
   the stock dfu loop only exits on Ctrl-C which a phone doesn't have.

2. The core for the menu which reuses bootmenu_loop() for navigation
   so any board that maps its buttons to keys (BUTTON_REMAP_PHONE_KEYS)
   works unchanged.

3. Phones often have no usable display during bring-up, or are driven
   from a host so the same menu is also drawn with ANSI escapes.

4. Not specific to the menu: Qualcomm keeps A/B state in the GPT
   attribute flags, not in "misc", so ab_select_slot() is wrong there.

5. Generic header info for the slot lookup which is a weak hook and
   the block device comes from the "storage" env var.

6. The Snapdragon override of that hook kept out of the generic file.

7. Shows why the device booted (e.g. recovery, fastboot). Reads the BCB
   from the "storage" device.

8. PMIC reister layout QPNP-PON specific for PM660 to decode the boot reason.

9. The USB ACM stdio device can be listed before it has been started
    and puts() then dereferences NULL private data.

10. The weak default picks "mmc" from Kconfig, so on UFS boards
    "fastboot reboot bootloader" could never write the BCB.

11. Usage documentation for the commands above.

Here's the URL with image of the menu on blueline, sargo and enchilada:
https://download.ixit.cz/u-boot.png

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
Petr Hodina (11):
      cmd: phone_util: add poweroff, dfu_pwr and USB Ethernet commands
      cmd: phonemenu: pixel drawn boot menu rendering and navigation
      cmd: phonemenu: mirror the menu to byte-stream consoles
      boot: android_ab: read the A/B slot from the GPT on Snapdragon
      cmd: phonemenu: show active A/B slot in the header
      cmd: phonemenu: read the A/B slot on Snapdragon without "misc"
      cmd: phonemenu: show Android boot reason in the header
      cmd: phonemenu: show PMIC PON status in the header
      usb: gadget: f_acm: check the acm_stdio_puts() against an unstarted device
      cmd: phone_util: fix "Cannot set reboot flag" on fastboot reboot
      doc: usage: add phonemenu command documentation

 MAINTAINERS                 |   5 +
 boot/android_ab.c           |  42 ++++
 cmd/Kconfig                 |  11 +
 cmd/Makefile                |   1 +
 cmd/phone_util.c            | 148 ++++++++++++
 cmd/phonemenu.c             | 550 ++++++++++++++++++++++++++++++++++++++++++++
 cmd/phonemenu_qcom.c        | 112 +++++++++
 doc/usage/cmd/phonemenu.rst |  92 ++++++++
 drivers/usb/gadget/f_acm.c  |   3 +
 include/phonemenu.h         |  17 ++
 10 files changed, 981 insertions(+)
---
base-commit: ece349ade2973e220f524ce59e59711cc919263f
change-id: 20261010-b4-phonemenu-series-15f574867344

Best regards,
--  
Petr Hodina <petr.hodina@protonmail.com>


