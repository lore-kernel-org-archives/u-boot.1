Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD63606A321
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 22:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PnJgBpWe;
	dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=WKKZtbZ8;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=H4vD1nYm
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 143E460611;
	Mon, 26 Oct 2026 22:55:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DAqpn82D83Xy; Mon, 26 Oct 2026 22:55:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 393D3605D2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793055308;
	b=qiHK0AVxI6wrYj7QteismXSD0n49NOL9B12L4eZ3ofTWIJfy3HgtOWjOwHrfj70VWnR/
	 dZL4z0POzHvivgd2TUZuxRv9zyBbdShE68/Cj2DA8+LTC3fXNJDui+nu7zltmzsGwQaYb
	 ixTVmFDkQnEP9Xcnyvy6dINQCWKQeV/deaJ+ZPbHfZwUdLu+35qrom1JECGTZs42bjch/
	 3QL/V1XcopVnKc4SRbfjWrd/SGHhmjv1p2F16rVjhymAkK2D2xvt4USv5/kcW71JNo+QO
	 0Z65IBnSdDRjcwJm/TZBFkyVhTXTS0OVMKWBTyntUWHKBJfXcDct+aFnqOnVxoiNwBA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793055308;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 Feedback-ID:X-SES-Outgoing:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WzJ7n05TqZLZ8sUAzVJISdIbx7uNUXsQiiUyVPPsoTs=;
	b=r9B1kIfMgWUFfiSSXS/RSd9pj3VjXQjpLqh5Ge739txzzFzmxwMUc39AzjmT9R268Nes
	 E56dQx/FGE1SWV2f/ilfZ69km556RE2I6+oPrilWfPP0RNETw/WUu4Nz1wnI9cBKanUXB
	 K+eeFns5CIZSnf7XTGFHcarfV8HHbJUbNOKkTWUl9vYMco+WSk/x8O8zjGlYPSxtdI7Hx
	 MsUzGExYkNffz0gnxwf8u20h9U+KTspNHwJMIA7HzvuwXibFjiQlNYXEHMPiYdjd5kvdX
	 aMQ+mqH9QJMk0tTVZH5H+nIQWUrTylWQ050ypzKJcHde7Yeyk/ftFsbscf2BcLFBPRA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=freemyipod.org;
	dkim=pass header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=WKKZtbZ8;
	dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=H4vD1nYm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793055308;
	bh=WzJ7n05TqZLZ8sUAzVJISdIbx7uNUXsQiiUyVPPsoTs=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PnJgBpWefp7Zx2q6w0Z82LQVJgGwD/FHZ1cONX3a20XMbV6OSQ4s9P4XpB6IAjqQS
	 RWDpdxaUB788OQu4yJWziHFdwbzOj0CfnpSyHIkMEvKiMGX0HNMNtEkTJZv51it1OC
	 FrxIp+8IpD+EC9OkReas+X5+I+Bhx0yziXdm/3+I7evi4EO7CFjt28tudkZmcJe/QP
	 yOi/7f85OBKk8HfQN+LbaUzd3Tc9oxPXIkMTn9XS5GHKcXkNivoAneNMhVmmPJtv9G
	 zCAcKpViJsnrp8+/WQy8ofx6lgLWiIomjD4JfQiN79D+04elN6dTkL2gnbmnGkDSjZ
	 InmKAtNpfEEXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 393D3605D2;
	Mon, 26 Oct 2026 22:55:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4A7202AC
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 48084605D1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id abM7dfwX4GHg for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 22:55:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 70E2B605CF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=69.169.224.12
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793055306;
 b=e4C+SdMGbwhh36BNvVTnoVckvMU1YvfQuDQhMk0FUBcfAI/JfHZTPjeVVqNwMzns82/v
 gE/34JM0OxU4a6dkpT2pLEpoHQ3jy8UHouHaEtFH/mTQAXzLXcaJzdS+mqGh81sx1zdtc
 wIIi3hKSEY43V+BLPbYgEECU6rb38vD7XPXpZTGDlXjAzI1ATVXaXc79+dGWIKnTCK6if
 aGAmX9MLwXJnbUkITiGPmb4foC3su+LKs9kdhn2+13rjsWmlBUUcLwaFZJx5MXSQHW2+Q
 XhQjPoisJoVzsEGXNxrjSwxBhxJpVTWBvax46kvhLydESL6+a7ShCWNYlqPAnj0KjMQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793055306;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:Subject:Date:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:Feedback-ID:X-SES-Outgoing;
 bh=WzJ7n05TqZLZ8sUAzVJISdIbx7uNUXsQiiUyVPPsoTs=;
 b=O65P7GuGz+Hd6qmVKgjWu7orRAtb4CTijTRU51kkD4N2nr3Z2TEwxha3To5ai1Xio/nE
 Ax7vPArWGLyAjDZ4gycUripMShvJvw9LjSPc+KOq1u3UiNC0S0P5QNzwl6N0nyNUxbFy5
 9A6/vIVk1KzpkNjtlbZr0uxRW67J3mjAu3X9/l0LaSGdVgoJ66iCSQRF8BiTiWWdcX1BT
 tbJMySH4HvWAjG0ZIgW6dE3RM0a/4oDt6yPzOFUaop+KAjAXF0QhaSgnZKEjTkORPJG5c
 usr4tud1ZctlBNP3J5WE0/iXF145Ohg5yS894lHbAzv4IaP5WKPKV+DWSezmkowL6dA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=freemyipod.org;
 dkim=pass header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256
 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=WKKZtbZ8; 
 dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256
 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=H4vD1nYm; 
 arc=none smtp.remote-ip=69.169.224.12
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=69.169.224.12;
 helo=b224-12.smtp-out.eu-central-1.amazonses.com;
 envelope-from=010701a17a6ca38b-fa4aa982-4038-4493-aea0-7b7a5c77819e-000000@ses.freemyipod.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=freemyipod.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org
 header.i=@freemyipod.org header.a=rsa-sha256
 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=WKKZtbZ8; 
 dkim=pass (1024-bit key,
 unprotected) header.d=amazonses.com header.i=@amazonses.com
 header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh
 header.b=H4vD1nYm
Received: from b224-12.smtp-out.eu-central-1.amazonses.com
 (b224-12.smtp-out.eu-central-1.amazonses.com [69.169.224.12])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 70E2B605CF
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz; d=freemyipod.org; t=1793055302;
 h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:Cc;
 bh=4i+6ZHTCrBYK5Jr5KgjQ4yKMOWygBKWrM9JjIXZ0BLQ=;
 b=WKKZtbZ8cN7rBEDSNWcf+PfWwk4CiLo/S61lSYdxrK4cN6OLbKeAj0Z2jE2/aYk2
 2xCHzu5syC7/i5WPzg0WEu2z2VSPqJX33ZlaMyBOrEfkR05/iw+EV3NOYEI3Q1JJE+g
 LHIChYth2pMwJpr3Ni39JArSSza29kQVlv8iHuuvnFg4z7dT0InJqBkPzIaDIwths91
 QB2TRnzTKBlIPJuHhMWiXle6fkm6MRxRcvcu5o4b8rgFe/6B7+NYnuYhS9I5ItKlaId
 1qXl3CTvacCIktgbkDrt0m4yMZasoew5es28Ga1f9UyuEkJt89UBxWiMZE5BIklung3
 CLFZSPFXTQ==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh; d=amazonses.com; t=1793055302;
 h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:Cc:Feedback-ID;
 bh=4i+6ZHTCrBYK5Jr5KgjQ4yKMOWygBKWrM9JjIXZ0BLQ=;
 b=H4vD1nYmrqBJ81rOpU+HuxkBVBKuySy9DNtJwbi3LgPuuMNibtZ/1nVS6d7MSTXU
 3DaxkdQSX9MSfwxwZ2vP5cN1fJzUGR445Er5lRvqXaf+mBQoGo1bbhdbVhRGPQxYCr3
 ULUne1qbdrMRr+TLGBI2T5oPiCtHCfbragA72tQk=
From: Vencislav Atanasov <user890104@freemyipod.org>
Subject: [PATCH v2 00/14] New platform: Samsung S5L87xx
Date: Mon, 26 Oct 2026 22:55:02 +0000
Message-ID: <010701a17a6ca38b-fa4aa982-4038-4493-aea0-7b7a5c77819e-000000@eu-central-1.amazonses.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNyw6CMBBFf8V07ZC2PEpd+R+GRZkOUsPDtEBQw
 r9b8CazOMmZezcWyDsK7HbZmKfFBTcOEeT1wrA1w5PA2chMclmIeBDyrlTrCosExNwqrRtLacb
 iw9tT49az7FH9Ocz1i3A6Gg6jdWEa/edcW8ThMS644sIIXqeU5aUErXRdYGlBSNSQlUKDsaoBh
 aRlbik6GfAzd5oBaZi86UAkpjffcQgUEhx7Vu37/gO7eMfT3gAAAA==
X-Change-ID: 20261026-s5l87xx-v2-cc5d799fde34
To: u-boot@lists.u-boot-project.org, Janne Grunau <j@jannau.net>
Cc: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Vencislav Atanasov <user890104@freemyipod.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793055301; l=9482;
 i=user890104@freemyipod.org; s=20261004; h=from:subject:message-id;
 bh=4i+6ZHTCrBYK5Jr5KgjQ4yKMOWygBKWrM9JjIXZ0BLQ=;
 b=Hvj8qrxFZQbxc/WvP5V8uKk08Vdyqwo4l3ZIedmh+LVgx+emj/y2XywWHxsN3tolKyRmwvjta
 jmQonN+510GBiMA0ghIDqZdi/3x59lO/4wQAwcJh2A/xeTR3J85qFc+
X-Developer-Key: i=user890104@freemyipod.org; a=ed25519;
 pk=klj5EgxMkX+YF0tPboUEB9kwBfthBgHWLhDOkwnmUus=
Feedback-ID: ::1.eu-central-1.GZFSN+SpSZlcZgoCjFtpLsnhzRcxifcxl4uaxXIRIUo=:AmazonSES
X-SES-Outgoing: 2026.10.26-69.169.224.12
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Port U-Boot to the Samsung S5L87xx SoC family, which is used by the
Apple iPod nano (2nd to 7th generation), iPod classic (6th generation)
and iPod touch (2nd generation) digital audio players.

As there is no official documentation or datasheets available from the
manufacturer, all peripherals have been reverse-engineered in the span
of more than 18 years, initially by the Linux4Nano project, which was
later renamed to freemyipod.

The current code can be built and booted on the iPod nano series,
from 2nd to 7th generation inclusive, and on the iPod classic (6th
generation). While the iPod touch (2nd generation) uses the same SoC
as the iPod nano (4th generation), support for the former is not
currently included.

On those supported devices, U-Boot's console works over UART, using
either the 30-pin connector's UART pins, or the UART pins on the
Lightning connector for iPod nano (7th generation). USB 2.0 works
in device mode, and U-Boot can successfully enumerate as a DFU device
and launch a firmware image - either another copy of U-Boot, or a
Linux FDT image.

U-Boot can be chain loaded from Apple's bootloader or from Rockbox.
Since Apple's bootloader verifies and decrypts all DFU images, an
additional tool is needed to generate a suitable image from u-boot.bin.

There are a couple issues, still being worked on:
- The timer on iPod nano (2nd generation) is not exact, there's a
  drift of about 5 seconds every 5 minutes.
- The S5L8702 devices (iPod nano 3rd generation and iPod classic
  6th generation) use a different UART baud rate - 57600. In addition,
  the latter's UART interface is not stable when receiving data from
  the computer.
- The iPod classic (6th generation) is currently using a wrong clock
  for keeping time in U-Boot, so the sleep command is slower.
- The iPod nano (5th generation) build does not boot because of wrong
  DTB alignment. The tool which launches U-Boot does not use a 8-byte
  aligned address, which became a requirement since 0535e46d55d7.

This patch is the combined work of several developers:
iPod nano (2nd generation): Franz-Josef Haider <f_haider at gmx.at>
iPod nano (3rd generation): Tucker Osman <osmiumusa at gmail.com>
iPod nano (4th generation): Vencislav Atanasov
				<user890104 at freemyipod.org>
iPod nano (5th generation): Serge Bazanski <q3k at q3k.org>
iPod nano (6th generation): Vencislav Atanasov
				<user890104 at freemyipod.org>
iPod nano (7th generation): Martí Guasch <m-gsch at guas.ch>
iPod classic (6th generation): Vencislav Atanasov
				<user890104 at freemyipod.org>

Links/resources:
- https://freemyipod.org/ - main project wiki
- https://github.com/freemyipod/u-boot - development repository
- https://freemyipod.org/wiki/U-Boot - building/running instructions
- https://freemyipod.org/wiki/Hardware - device and spec list

Signed-off-by: Vencislav Atanasov <user890104@freemyipod.org>
---
Changes in v2:
- Split to separate commits per SoC/board
- Enabled skipping of low level init on ARM1176
- Using separate USB PHY driver for S5L8740
- Cleaned up serial and clk includes
- Regenerated defconfig using savedefconfig
- Removed unused code (BUSCON)
- Fixed tabs/spaces/newlines
- Link to v1: https://patch.msgid.link/010701a10b3e4582-979b6c8d-12c9-4819-ad7f-7ce925de5824-000000@eu-central-1.amazonses.com

---
Vencislav Atanasov (14):
      ARM920T: Add support for CONFIG_POSITION_INDEPENDENT
      ARM1176: Add support for CONFIG_POSITION_INDEPENDENT
      ARM1176: Add support for SKIP_LOWLEVEL_INIT/SKIP_LOWLEVEL_INIT_ONLY
      Make CPU_ARM1176 and CPU_ARM920T dependencies of POSITION_INDEPENDENT
      New SoC platform: S5L87xx
      usb: Add DWC2 HS OTG params for S5L87xx
      serial: Add support for S5L87xx to serial_s5p
      Common files for the whole S5L87xx SoC family and the Nxx board series
      New SoC/board: S5L8701/N36
      New SoC/boards: S5L8702/N46 and N25
      New SoC/board: S5L8720/N58s
      New SoC/board: S5L8723/N20
      New SoC/board: S5L8730/N33
      New SoC/board: S5L8740/N31

 MAINTAINERS                                 |  10 ++
 arch/arm/Kconfig                            |  14 ++-
 arch/arm/Makefile                           |   1 +
 arch/arm/cpu/arm1176/start.S                |  46 +++++++++
 arch/arm/cpu/arm920t/start.S                |  43 +++++++++
 arch/arm/dts/s5l8701-n36.dts                |  26 ++++++
 arch/arm/dts/s5l8701.dtsi                   |  62 +++++++++++++
 arch/arm/dts/s5l8702-common.dtsi            |  34 +++++++
 arch/arm/dts/s5l8702-n25.dts                |  26 ++++++
 arch/arm/dts/s5l8702-n46.dts                |  26 ++++++
 arch/arm/dts/s5l8702.dtsi                   |  44 +++++++++
 arch/arm/dts/s5l8720-n58s.dts               |  26 ++++++
 arch/arm/dts/s5l8720.dtsi                   |  42 +++++++++
 arch/arm/dts/s5l8723-n20.dts                |  26 ++++++
 arch/arm/dts/s5l8723.dtsi                   |  40 ++++++++
 arch/arm/dts/s5l8730-n33.dts                |  26 ++++++
 arch/arm/dts/s5l8730.dtsi                   |  42 +++++++++
 arch/arm/dts/s5l8740-n31.dts                |  26 ++++++
 arch/arm/dts/s5l8740.dtsi                   |  43 +++++++++
 arch/arm/dts/s5l87xx-nxx.dtsi               |  22 +++++
 arch/arm/dts/s5l87xx.dtsi                   |  78 ++++++++++++++++
 arch/arm/include/asm/arch-s5l87xx/clk.h     |  19 ++++
 arch/arm/include/asm/arch-s5l87xx/s5l87xx.h |  79 ++++++++++++++++
 arch/arm/include/asm/arch-s5l87xx/uart.h    |  29 ++++++
 arch/arm/mach-s5l87xx/Kconfig               |  67 ++++++++++++++
 arch/arm/mach-s5l87xx/Makefile              |  35 +++++++
 arch/arm/mach-s5l87xx/relocate.S            |  27 ++++++
 arch/arm/mach-s5l87xx/s5l8701-otg-phy.c     |  56 +++++++++++
 arch/arm/mach-s5l87xx/s5l8701-timer.c       | 109 ++++++++++++++++++++++
 arch/arm/mach-s5l87xx/s5l8701.c             |  26 ++++++
 arch/arm/mach-s5l87xx/s5l8701/Kconfig       |  12 +++
 arch/arm/mach-s5l87xx/s5l8702-otg-phy.c     |  72 ++++++++++++++
 arch/arm/mach-s5l87xx/s5l8702.c             |  18 ++++
 arch/arm/mach-s5l87xx/s5l8702/Kconfig       |  26 ++++++
 arch/arm/mach-s5l87xx/s5l8720.c             |  18 ++++
 arch/arm/mach-s5l87xx/s5l8720/Kconfig       |  12 +++
 arch/arm/mach-s5l87xx/s5l8723.c             |  18 ++++
 arch/arm/mach-s5l87xx/s5l8723/Kconfig       |  12 +++
 arch/arm/mach-s5l87xx/s5l8730.c             |  18 ++++
 arch/arm/mach-s5l87xx/s5l8730/Kconfig       |  12 +++
 arch/arm/mach-s5l87xx/s5l8740-otg-phy.c     |  75 +++++++++++++++
 arch/arm/mach-s5l87xx/s5l8740.c             |  25 +++++
 arch/arm/mach-s5l87xx/s5l8740/Kconfig       |  12 +++
 arch/arm/mach-s5l87xx/s5l87xx-clk.c         |  66 +++++++++++++
 arch/arm/mach-s5l87xx/s5l87xx-otg-phy.c     |  55 +++++++++++
 arch/arm/mach-s5l87xx/s5l87xx-timer.c       | 139 ++++++++++++++++++++++++++++
 arch/arm/mach-s5l87xx/s5l87xx.c             |  22 +++++
 board/apple/n20/Kconfig                     |  15 +++
 board/apple/n20/Makefile                    |   7 ++
 board/apple/n20/n20.c                       |  57 ++++++++++++
 board/apple/n25/Kconfig                     |  15 +++
 board/apple/n25/Makefile                    |   7 ++
 board/apple/n25/n25.c                       |  50 ++++++++++
 board/apple/n31/Kconfig                     |  15 +++
 board/apple/n31/Makefile                    |   7 ++
 board/apple/n31/n31.c                       |  96 +++++++++++++++++++
 board/apple/n33/Kconfig                     |  15 +++
 board/apple/n33/Makefile                    |   7 ++
 board/apple/n33/n33.c                       |  57 ++++++++++++
 board/apple/n36/Kconfig                     |  15 +++
 board/apple/n36/Makefile                    |   7 ++
 board/apple/n36/n36.c                       |  19 ++++
 board/apple/n46/Kconfig                     |  15 +++
 board/apple/n46/Makefile                    |   7 ++
 board/apple/n46/n46.c                       |  51 ++++++++++
 board/apple/n58s/Kconfig                    |  15 +++
 board/apple/n58s/Makefile                   |   7 ++
 board/apple/n58s/n58s.c                     |  57 ++++++++++++
 board/apple/nxx-common/nxx.c                |  47 ++++++++++
 configs/apple_n20_defconfig                 |  33 +++++++
 configs/apple_n25_defconfig                 |  37 ++++++++
 configs/apple_n31_defconfig                 |  31 +++++++
 configs/apple_n33_defconfig                 |  33 +++++++
 configs/apple_n36_defconfig                 |  31 +++++++
 configs/apple_n46_defconfig                 |  36 +++++++
 configs/apple_n58s_defconfig                |  33 +++++++
 drivers/serial/Kconfig                      |   4 +-
 drivers/serial/serial_s5p.c                 |  49 ++++++----
 drivers/usb/gadget/dwc2_udc_otg.c           |  29 ++++++
 include/configs/apple_n20.h                 |  15 +++
 include/configs/apple_n25.h                 |  15 +++
 include/configs/apple_n31.h                 |  15 +++
 include/configs/apple_n33.h                 |  16 ++++
 include/configs/apple_n36.h                 |  15 +++
 include/configs/apple_n46.h                 |  15 +++
 include/configs/apple_n58s.h                |  15 +++
 86 files changed, 2753 insertions(+), 19 deletions(-)
---
base-commit: b0da72e3e8e77e36c29a5f3fecc04c47764031bf
change-id: 20261026-s5l87xx-v2-cc5d799fde34

Best regards,
--  
Vencislav Atanasov <user890104@freemyipod.org>

