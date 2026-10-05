Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2671FCA5FCE
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 13:31:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C9BDC4069B;
	Mon,  5 Oct 2026 13:31:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oCaH09ObEu-G; Mon,  5 Oct 2026 13:31:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D3AD040687
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791207080;
	b=JEL/MJN3wftxRMf9YaeNKP0eGUc1fgzLLp8aeKCpDd7bv7DjiTaOVD2KtmhEbql8EcQe
	 yq7d4fjp1WrxuDUzaKqvchm3zxcT8D0kiNfTDGeDjqFniYUFcghTDyvsbTiTdpfcz8ejQ
	 ogk2GRwgxsLtfSbualfkhMsBUZ0GyCSJkK6juLMBaRYkC1eHgA5afuu2I97WTle1BGLj8
	 dJBRrxwuWHzGwYYOq/W6n9DaRtSYzdkPhG6N7g6MzTF/LPlK6GPaGA5k1/Mq8oBBHmw6x
	 Gkx8lBlDPJCz1tg4Yhoz8BNCN7PQrvCSIosrx6ZQkm0E2HCD5tlwDlyQegp4ueVH/Tg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791207080;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 Feedback-ID:X-SES-Outgoing:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=K/ecIXq8kBtGFOiWNb4Lu8lk7DsNLcg2J000xs2L/Sk=;
	b=TRIF0ahnJ4YePGuParziSp0lUlns0pz0iEbXVAJbQm5nK3+uNiSgIi0faeFdDczw9piz
	 Ep2GO3KllVj03437KcsnvdU1SyyO/VbUwCB0++gPzoILjlTOUg/TdEBXEimr4k4hR+HAK
	 yWimC6nHIW9CL/vdwLmx89iy299MYFq9IMWxM+TxqI1mth1BEzvzaiVsof4aIz5lESWDF
	 0XfCSKsJig/xpBZHsVqOApiBWbMLvSVHlNjAwdXrbrEKRaZ/lJbwQGrx/xWgXhHAytS7V
	 kAzq4B17OcOA1XoEgdCH151ZoPXbqRs23rKtRq4qgl/vlq0xXwoFIu7i6OZIh42x6Ow==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791207080;
	bh=K/ecIXq8kBtGFOiWNb4Lu8lk7DsNLcg2J000xs2L/Sk=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ux7OpUBpPatWpXy1nOrOBtWRfr/KfyjTZwrVwraEkVlZfb2uYPAvg++wwCpkhKEkp
	 DxV1PrDPa7/itFGQvmtXeNm8Nuf1pTYpXWHm3tWBT/43bC+Uw5w/SBX8l/rGpmb03V
	 NdOgV81d9HL1ym9+721xKii6NpqMNw4PUp93pSgUbSSgVsePe0rOJOrM+KKizev3V9
	 uK+wtfxLwR8W5mt2YiA/+2LfxB7CEQjH6h4QoNVD+ScAxpLkiH6WZE5HlzPOdH+/n6
	 KCS/6AECOVcDBO+LIsgdv5MQZvwemgJ1fGCXaSPVkFFUvJUAhK5G2+cVy037hVlnmw
	 rXU/Qui5gS/wQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D3AD040687;
	Mon,  5 Oct 2026 13:31:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8422875
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 08:46:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6AAA860613
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 08:46:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vvnwgqd776kE for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 08:46:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A01C9605F3
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=69.169.224.8
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791189996;
 b=gA1XiOemQWjk6WScKoXEyyE5PHuaRNbYN/2vpnSTeT94w/Mr8IUNS6YdSziy9XNv6hgd
 JunyNNOIsCx09lersNGYLRkIEFPEV7SZAOTFdy3lisNV+GkQmgJf5qS71SAHolJN+f817
 hmz7plh128KwJUOOYuHThTJJmhbKS6B+5yH2mf7b8vXzcBFbiPQ/Dbkyfm8uMDm1gNOjZ
 CwcJOuKhtxb9fZCcGNjWel4O2ocf0n9iebkHsZF3+hrRQYiabjShr51eQDPZuMDrK6t1W
 fobvhuLKGBVjv9Xbi899eeIKrsKE4+T9jGXjO/njq/AFBe9MEi6xZTWgvxlgh/bQ4rA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791189996;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:Feedback-ID:X-SES-Outgoing;
 bh=K/ecIXq8kBtGFOiWNb4Lu8lk7DsNLcg2J000xs2L/Sk=;
 b=rOI1o/vMUGv23yDz1UszEdcOfkJ22IPiNnfYl3eA0TJp7rjUOoVMGnsAQWKSWtAFVP6m
 +TVhqTem/4sn1AX7gdIqBCSfJxs/kyN/HGmP6ckRUq1RbdK0lsQLFx7z9nv9Djkfcp9t/
 fskc6zickp584aA/NlpWQJK9LaYu2nlPSSG+I57uh0gcJB97T9LpWE0QjCAT97ycoAx7C
 8x/xVtY+yp+CRG87+BHz4O78P/HGjGpFHLSOoj2L+NW8qFmvlmpFlPwwixVQJY6SEzmnz
 6636baDw6O0x952wtApsxb1v3asMJYIxpy5JONwQNmPitM6/fYBWgD7MAujFcQzq2Ow==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=freemyipod.org; 
 dkim=pass header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256
 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=Vdg7RefX; 
 dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256
 header.s=sokbgaaqhfgd6qjht2wmdajpuuanpimv header.b=ML3+ejKG; 
 arc=none smtp.remote-ip=69.169.224.8
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=69.169.224.8;
 helo=b224-8.smtp-out.eu-central-1.amazonses.com;
 envelope-from=010701a10b3e4582-979b6c8d-12c9-4819-ad7f-7ce925de5824-000000@ses.freemyipod.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=freemyipod.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org
 header.i=@freemyipod.org header.a=rsa-sha256
 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=Vdg7RefX; 
 dkim=pass (1024-bit key,
 unprotected) header.d=amazonses.com header.i=@amazonses.com
 header.a=rsa-sha256 header.s=sokbgaaqhfgd6qjht2wmdajpuuanpimv
 header.b=ML3+ejKG
Received: from b224-8.smtp-out.eu-central-1.amazonses.com
 (b224-8.smtp-out.eu-central-1.amazonses.com [69.169.224.8])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A01C9605F3
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 08:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz; d=freemyipod.org; t=1791189993;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:To:Cc;
 bh=nh3j7wVbO9sMd8GFateGwoizDutvH+iOx3kA9Xwty3c=;
 b=Vdg7RefXZO7ijkdZQhuBUsd4WJnEsuyEo5WwiCZDosCd3hjtwDD8w34vjoH0ZR5G
 wkTuYLh5idbPnyGUEZ2983cEie04Jg4SF08DC6yhFNdqSkT5AfZut3SdslKdlvsilHc
 JgmJTkyz2istY82HdClanhEbV4I+0C0uGtAGquzDRzkVxGtDVixdDPx/5wAoLE+kgl5
 1FYPVqKFN4E1JWaJISdzmhWt004SEq/zg106+d18GRKSISZgovLzxQn7xEJnF+0LJzu
 otKOD6iTyMNK+MxFMwEaatI3dcJ520mJz4gdqF7QffsoPUz+9wW2wavzBnFr/uuWhO1
 +fcxdFoS5A==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=sokbgaaqhfgd6qjht2wmdajpuuanpimv; d=amazonses.com; t=1791189993;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:To:Cc:Feedback-ID;
 bh=nh3j7wVbO9sMd8GFateGwoizDutvH+iOx3kA9Xwty3c=;
 b=ML3+ejKGFE6paZ6+1VzoBkP7YsyUFMBfiJzKk4QzkKVHVxGN3xXMKEibUXcHNKV2
 wmGwIegMcsXL1tAYbOYW556t85KxQTX8YjasUBh02RSLSioChMz7FOMu4G/R+VEBFTy
 tC6k9n7Q00MfZ3yE8yUQ1bnhuwseyEJG0XdHJtc0=
From: Vencislav Atanasov <user890104@freemyipod.org>
Date: Mon, 5 Oct 2026 08:46:32 +0000
Subject: [PATCH] New platform: Samsung S5L87xx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <010701a10b3e4582-979b6c8d-12c9-4819-ad7f-7ce925de5824-000000@eu-central-1.amazonses.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMyw5AMBCF4VeRWWvS1t2riAU6GBGkgzQR765Yf
 sl/zgWMlpChDC6weBLTunioMIBubJYBBRlv0FKnSspYcDLnmXOiL3KVRUabREnw9WaxJ/c9VfV
 vPtoJu/2dw30/TmJye2sAAAA=
X-Change-ID: 20261004-s5l87xx-f98173d2d510
To: u-boot@lists.u-boot-project.org, Janne Grunau <j@jannau.net>
Cc: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Vencislav Atanasov <user890104@freemyipod.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791189992; l=103271;
 i=user890104@freemyipod.org; s=20261004; h=from:subject:message-id;
 bh=nh3j7wVbO9sMd8GFateGwoizDutvH+iOx3kA9Xwty3c=;
 b=ZtAiJ47i43SXTkuBhRQqAH016bxS43gjc7NyZx0UaRB0WBEHnl5mb1zzlH2l73MLkLLS+yELM
 EKZcmsDXuUnBy03T4nfAolXGuXz8GDhyXPNgUvnQIedGv++E7vnh6RF
X-Developer-Key: i=user890104@freemyipod.org; a=ed25519;
 pk=klj5EgxMkX+YF0tPboUEB9kwBfthBgHWLhDOkwnmUus=
Feedback-ID: ::1.eu-central-1.GZFSN+SpSZlcZgoCjFtpLsnhzRcxifcxl4uaxXIRIUo=:AmazonSES
X-SES-Outgoing: 2026.10.05-69.169.224.8
X-Mailman-Approved-At: Mon, 05 Oct 2026 13:24:22 +0000
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

Port U-Boot to the Samsung S5L87xx SoC family, which is used by the
Apple iPod nano (2nd to 7th generation), iPod classic (6th generation)
and iPod touch (2nd generation) digital audio players.

---
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
iPod nano (2nd generation): Franz-Josef Haider <f_haider@gmx.at>
iPod nano (3rd generation): Tucker Osman <osmiumusa@gmail.com>
iPod nano (4th generation): Vencislav Atanasov
				<user890104@freemyipod.org>
iPod nano (5th generation): Serge Bazanski <q3k@q3k.org>
iPod nano (6th generation): Vencislav Atanasov
				<user890104@freemyipod.org>
iPod nano (7th generation): Martí Guasch <m-gsch@guas.ch>
iPod classic (6th generation): Vencislav Atanasov
				<user890104@freemyipod.org>

Links/resources:
- https://freemyipod.org/ - main project wiki
- https://github.com/freemyipod/u-boot - development repository
- https://freemyipod.org/wiki/U-Boot - building/running instructions
- https://freemyipod.org/wiki/Hardware - device and spec list

Signed-off-by: Vencislav Atanasov <user890104@freemyipod.org>
---
 MAINTAINERS                                     |  10 ++
 arch/arm/Kconfig                                |  14 ++-
 arch/arm/Makefile                               |   1 +
 arch/arm/cpu/arm1176/start.S                    |  43 ++++++++
 arch/arm/cpu/arm920t/start.S                    |  44 ++++++++
 arch/arm/dts/s5l8701-n36.dts                    |  26 +++++
 arch/arm/dts/s5l8701.dtsi                       |  62 +++++++++++
 arch/arm/dts/s5l8702-common.dtsi                |  34 ++++++
 arch/arm/dts/s5l8702-n25.dts                    |  26 +++++
 arch/arm/dts/s5l8702-n46.dts                    |  26 +++++
 arch/arm/dts/s5l8702.dtsi                       |  44 ++++++++
 arch/arm/dts/s5l8720-n58s.dts                   |  26 +++++
 arch/arm/dts/s5l8720.dtsi                       |  42 +++++++
 arch/arm/dts/s5l8723-n20.dts                    |  26 +++++
 arch/arm/dts/s5l8723.dtsi                       |  40 +++++++
 arch/arm/dts/s5l8730-n33.dts                    |  26 +++++
 arch/arm/dts/s5l8730.dtsi                       |  42 +++++++
 arch/arm/dts/s5l8740-n31.dts                    |  26 +++++
 arch/arm/dts/s5l8740.dtsi                       |  43 ++++++++
 arch/arm/dts/s5l87xx-nxx.dtsi                   |  22 ++++
 arch/arm/dts/s5l87xx.dtsi                       |  78 +++++++++++++
 arch/arm/include/asm/arch-s5l8701/uart.h        |  29 +++++
 arch/arm/include/asm/arch-s5l8702/uart.h        |  29 +++++
 arch/arm/include/asm/arch-s5l8720/uart.h        |  29 +++++
 arch/arm/include/asm/arch-s5l8723/uart.h        |  29 +++++
 arch/arm/include/asm/arch-s5l8730/uart.h        |  29 +++++
 arch/arm/include/asm/arch-s5l8740/uart.h        |  29 +++++
 arch/arm/include/asm/arch-s5l87xx/s5l87xx-clk.h |  19 ++++
 arch/arm/include/asm/arch-s5l87xx/s5l87xx.h     |  79 ++++++++++++++
 arch/arm/mach-s5l87xx/Kconfig                   |  53 +++++++++
 arch/arm/mach-s5l87xx/Makefile                  |  36 ++++++
 arch/arm/mach-s5l87xx/relocate.S                |  27 +++++
 arch/arm/mach-s5l87xx/s5l8701-otg-phy.c         |  56 ++++++++++
 arch/arm/mach-s5l87xx/s5l8701-timer.c           | 109 +++++++++++++++++++
 arch/arm/mach-s5l87xx/s5l8701.c                 |  26 +++++
 arch/arm/mach-s5l87xx/s5l8701/Kconfig           |  11 ++
 arch/arm/mach-s5l87xx/s5l8702-otg-phy.c         |  72 ++++++++++++
 arch/arm/mach-s5l87xx/s5l8702.c                 |  18 +++
 arch/arm/mach-s5l87xx/s5l8702/Kconfig           |  18 +++
 arch/arm/mach-s5l87xx/s5l8720.c                 |  23 ++++
 arch/arm/mach-s5l87xx/s5l8720/Kconfig           |  11 ++
 arch/arm/mach-s5l87xx/s5l8723.c                 |  23 ++++
 arch/arm/mach-s5l87xx/s5l8723/Kconfig           |  11 ++
 arch/arm/mach-s5l87xx/s5l8730.c                 |  23 ++++
 arch/arm/mach-s5l87xx/s5l8730/Kconfig           |  11 ++
 arch/arm/mach-s5l87xx/s5l8740.c                 |  25 +++++
 arch/arm/mach-s5l87xx/s5l8740/Kconfig           |  11 ++
 arch/arm/mach-s5l87xx/s5l87xx-buscon.c          |  25 +++++
 arch/arm/mach-s5l87xx/s5l87xx-clk.c             |  66 +++++++++++
 arch/arm/mach-s5l87xx/s5l87xx-otg-phy.c         |  55 ++++++++++
 arch/arm/mach-s5l87xx/s5l87xx-timer.c           | 139 ++++++++++++++++++++++++
 arch/arm/mach-s5l87xx/s5l87xx.c                 |  22 ++++
 board/apple/n20/Kconfig                         |  15 +++
 board/apple/n20/Makefile                        |   7 ++
 board/apple/n20/n20.c                           |  57 ++++++++++
 board/apple/n25/Kconfig                         |  15 +++
 board/apple/n25/Makefile                        |   7 ++
 board/apple/n25/n25.c                           |  50 +++++++++
 board/apple/n31/Kconfig                         |  15 +++
 board/apple/n31/Makefile                        |   7 ++
 board/apple/n31/n31.c                           |  96 ++++++++++++++++
 board/apple/n33/Kconfig                         |  15 +++
 board/apple/n33/Makefile                        |   7 ++
 board/apple/n33/n33.c                           |  57 ++++++++++
 board/apple/n36/Kconfig                         |  15 +++
 board/apple/n36/Makefile                        |   7 ++
 board/apple/n36/n36.c                           |  19 ++++
 board/apple/n46/Kconfig                         |  15 +++
 board/apple/n46/Makefile                        |   7 ++
 board/apple/n46/n46.c                           |  51 +++++++++
 board/apple/n58s/Kconfig                        |  15 +++
 board/apple/n58s/Makefile                       |   7 ++
 board/apple/n58s/n58s.c                         |  57 ++++++++++
 board/apple/nxx-common/nxx.c                    |  47 ++++++++
 configs/apple_n20_defconfig                     |  35 ++++++
 configs/apple_n25_defconfig                     |  42 +++++++
 configs/apple_n31_defconfig                     |  41 +++++++
 configs/apple_n33_defconfig                     |  35 ++++++
 configs/apple_n36_defconfig                     |  35 ++++++
 configs/apple_n46_defconfig                     |  42 +++++++
 configs/apple_n58s_defconfig                    |  35 ++++++
 drivers/serial/Kconfig                          |   4 +-
 drivers/serial/serial_s5p.c                     |  45 +++++---
 drivers/usb/gadget/dwc2_udc_otg.c               |  29 +++++
 include/configs/apple_n20.h                     |  15 +++
 include/configs/apple_n25.h                     |  15 +++
 include/configs/apple_n31.h                     |  15 +++
 include/configs/apple_n33.h                     |  16 +++
 include/configs/apple_n36.h                     |  15 +++
 include/configs/apple_n46.h                     |  15 +++
 include/configs/apple_n58s.h                    |  15 +++
 91 files changed, 2862 insertions(+), 19 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 55c394536ca..fe8f4a7ad58 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -565,6 +565,16 @@ F:	drivers/clk/exynos/clk-exynos850.c
 F:	drivers/phy/phy-exynos-usbdrd.c
 F:	drivers/pinctrl/exynos/pinctrl-exynos850.c
 
+ARM SAMSUNG S5L87XX SOC
+M:	Vencislav Atanasov <user890104@freemyipod.org>
+S:	Maintained
+F:	arch/arm/dts/s5l87*
+F:	arch/arm/include/asm/arch-s5l87*
+F:	arch/arm/mach-s5l87*
+F:	board/apple/n*
+F:	configs/apple_n*
+F:	include/configs/apple_n*
+
 ARM SAMSUNG SOC DRIVERS
 M:	Sam Protsenko <semen.protsenko@linaro.org>
 S:	Maintained
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1b474a346bf..8be83af966f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -42,7 +42,7 @@ config COUNTER_FREQUENCY
 
 config POSITION_INDEPENDENT
 	bool "Generate position-independent pre-relocation code"
-	depends on ARM64 || CPU_V7A
+	depends on ARM64 || CPU_V7A || CPU_ARM1176 || CPU_ARM920T
 	help
 	  U-Boot expects to be linked to a specific hard-coded address, and to
 	  be loaded to and run from that address. This option lifts that
@@ -746,6 +746,16 @@ config TARGET_BCMNS3
 	  ARMv8 Cortex-A72 processors targeting a broad range of networking
 	  applications.
 
+config ARCH_S5L87XX
+	bool "Samsung S5L87XX"
+	select DM
+	select DM_GPIO
+	select DM_SERIAL
+	imply CMD_DM
+	help
+	  Support for Samsung S5L87xx SoCs. They are used in the Apple iPod nano,
+	  iPod classic and iPod touch series. All CPU cores are 32-bit ARM.
+
 config ARCH_EXYNOS
 	bool "Samsung EXYNOS"
 	select DM
@@ -2377,6 +2387,8 @@ source "arch/arm/mach-qemu/Kconfig"
 
 source "arch/arm/mach-rockchip/Kconfig"
 
+source "arch/arm/mach-s5l87xx/Kconfig"
+
 source "arch/arm/mach-s5pc1xx/Kconfig"
 
 source "arch/arm/mach-sc5xx/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index de975fc9368..d27808dfd05 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -80,6 +80,7 @@ machine-$(CONFIG_ARCH_OMAP2PLUS)	+= omap2
 machine-$(CONFIG_ARCH_OWL)		+= owl
 machine-$(CONFIG_ARCH_RENESAS)		+= renesas
 machine-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip
+machine-$(CONFIG_ARCH_S5L87XX)		+= s5l87xx
 machine-$(CONFIG_ARCH_S5PC1XX)		+= s5pc1xx
 machine-$(CONFIG_ARCH_SC5XX)		+= sc5xx
 machine-$(CONFIG_ARCH_SNAPDRAGON)	+= snapdragon
diff --git a/arch/arm/cpu/arm1176/start.S b/arch/arm/cpu/arm1176/start.S
index d3ab5928eee..3e82676456d 100644
--- a/arch/arm/cpu/arm1176/start.S
+++ b/arch/arm/cpu/arm1176/start.S
@@ -37,6 +37,41 @@ reset:
 	b	save_boot_params
 .globl	save_boot_params_ret
 save_boot_params_ret:
+#ifdef CONFIG_POSITION_INDEPENDENT
+    /*
+     * Fix .rela.dyn relocations. This allows U-Boot to loaded to and
+     * executed at a different address than it was linked at.
+     */
+pie_fixup:
+    adr r0, reset   /* r0 <- Runtime value of reset label */
+    ldr r1, =reset  /* r1 <- Linked value of reset label */
+    subs    r4, r0, r1  /* r4 <- Runtime-vs-link offset */
+    beq pie_fixup_done
+
+    adr r0, pie_fixup
+    ldr r1, _rel_dyn_start_ofs
+    add r2, r0, r1  /* r2 <- Runtime &__rel_dyn_start */
+    ldr r1, _rel_dyn_end_ofs
+    add r3, r0, r1  /* r3 <- Runtime &__rel_dyn_end */
+
+pie_fix_loop:
+    ldr r0, [r2]    /* r0 <- Link location */
+    ldr r1, [r2, #4]    /* r1 <- fixup */
+    cmp r1, #23     /* relative fixup? */
+    bne pie_skip_reloc
+
+    /* relative fix: increase location by offset */
+    add r0, r4
+    ldr r1, [r0]
+    add r1, r4
+    str r1, [r0]
+    str r0, [r2]
+    add r2, #8
+pie_skip_reloc:
+    cmp r2, r3
+    blo pie_fix_loop
+pie_fixup_done:
+#endif
 
 	/*
 	 * set the cpu to SVC32 mode
@@ -115,3 +150,11 @@ c_runtime_cpu_setup:
 WEAK(save_boot_params)
 	b	save_boot_params_ret	/* back to my caller */
 ENDPROC(save_boot_params)
+
+#if CONFIG_POSITION_INDEPENDENT
+_rel_dyn_start_ofs:
+    .word   __rel_dyn_start - pie_fixup
+_rel_dyn_end_ofs:
+    .word   __rel_dyn_end - pie_fixup
+#endif
+
diff --git a/arch/arm/cpu/arm920t/start.S b/arch/arm/cpu/arm920t/start.S
index e792e8e795e..02a7b4d3e53 100644
--- a/arch/arm/cpu/arm920t/start.S
+++ b/arch/arm/cpu/arm920t/start.S
@@ -26,6 +26,42 @@
 	.globl	reset
 
 reset:
+#ifdef CONFIG_POSITION_INDEPENDENT
+	/*
+	 * Fix .rela.dyn relocations. This allows U-Boot to loaded to and
+	 * executed at a different address than it was linked at.
+	 */
+pie_fixup:
+	adr	r0, reset	/* r0 <- Runtime value of reset label */
+	ldr	r1, =reset	/* r1 <- Linked value of reset label */
+	subs	r4, r0, r1	/* r4 <- Runtime-vs-link offset */
+	beq	pie_fixup_done
+
+	adr	r0, pie_fixup
+	ldr	r1, _rel_dyn_start_ofs
+	add	r2, r0, r1	/* r2 <- Runtime &__rel_dyn_start */
+	ldr	r1, _rel_dyn_end_ofs
+	add	r3, r0, r1	/* r3 <- Runtime &__rel_dyn_end */
+
+pie_fix_loop:
+	ldr	r0, [r2]	/* r0 <- Link location */
+	ldr	r1, [r2, #4]	/* r1 <- fixup */
+	cmp	r1, #23		/* relative fixup? */
+	bne	pie_skip_reloc
+
+	/* relative fix: increase location by offset */
+	add	r0, r4
+	ldr	r1, [r0]
+	add	r1, r4
+	str	r1, [r0]
+	str	r0, [r2]
+	add	r2, #8
+pie_skip_reloc:
+	cmp	r2, r3
+	blo	pie_fix_loop
+pie_fixup_done:
+#endif
+
 	/*
 	 * set the cpu to SVC32 mode
 	 */
@@ -95,3 +131,11 @@ cpu_init_crit:
 #endif
 	mov	pc, lr
 #endif /* CONFIG_IS_ENABLED(SKIP_LOWLEVEL_INIT) */
+
+#if CONFIG_POSITION_INDEPENDENT
+_rel_dyn_start_ofs:
+    .word   __rel_dyn_start - pie_fixup
+_rel_dyn_end_ofs:
+    .word   __rel_dyn_end - pie_fixup
+#endif
+
diff --git a/arch/arm/dts/s5l8701-n36.dts b/arch/arm/dts/s5l8701-n36.dts
new file mode 100644
index 00000000000..f8d6cdc8dba
--- /dev/null
+++ b/arch/arm/dts/s5l8701-n36.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPod nano (2nd generation)
+ *
+ * target-type: N36
+ *
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+/dts-v1/;
+
+#include "s5l8701.dtsi"
+#include "s5l87xx-nxx.dtsi"
+
+/ {
+	compatible = "apple,n36", "samsung,s5l8701", "apple,arm-platform";
+	model = "Apple iPod nano (2nd generation)";
+};
+
+&memory {
+	reg = <0x08000000 0x02000000>; /* 32 MiB SDRAM */
+};
+
+&clkref {
+	clock-frequency = <24000000>;
+};
diff --git a/arch/arm/dts/s5l8701.dtsi b/arch/arm/dts/s5l8701.dtsi
new file mode 100644
index 00000000000..df14e80f083
--- /dev/null
+++ b/arch/arm/dts/s5l8701.dtsi
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Samsung S5L8701 SoC
+ *
+ * Other names: M1
+ *
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include "s5l87xx.dtsi"
+
+/ {
+	compatible = "samsung,s5l8701", "apple,arm-platform";
+
+	chosen {
+		stdout-path = &uart0;
+	};
+
+	soc {
+		icu: interrupt-controller@39c00000 {
+			compatible = "samsung,s5l8701-icu";
+			interrupt-controller;
+			reg = <0x39c00000 0x1000>;
+			#interrupt-cells = <1>;
+		};
+
+		usbotg_hs: usb@38800000 {
+			compatible = "apple,s5l87xx-usb";
+			reg = <0x38800000 0x40000>;
+			interrupt-parent = <&icu>;
+			interrupts = <16>;
+			phys = <&usbphy>;
+			phy-names = "usb2-phy";
+			clocks = <&clkref>;
+			clock-names = "otg";
+			g-rx-fifo-size = <256>;
+			g-np-tx-fifo-size = <128>;
+			g-tx-fifo-size = <0>;
+			dr_mode = "peripheral";
+		};
+	};
+};
+
+&cpu0 {
+	compatible = "arm,arm940t";
+};
+
+&clkgates {
+	/*
+	 * Clock-gate name -> {gate, bit} table consumed by s5l87xx_enable_clkgate().
+	 * Each entry is two cells: gate * 32 + bit, with 0xffffffff for an unused
+	 * second gate. The Nano2G (S5L8701) uses single gates (PWRCON registers).
+	 * See https://freemyipod.org/wiki/Nano2G_clock_gates
+	 */
+	clock-gate-names = "timer", "uart", "usb2-phy", "usb-otg";
+	samsung,clock-gates = <4 0xffffffff>, <8 0xffffffff>,
+						  <14 0xffffffff>, <43 0xffffffff>;
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm/dts/s5l8702-common.dtsi b/arch/arm/dts/s5l8702-common.dtsi
new file mode 100644
index 00000000000..4c2aabc35a0
--- /dev/null
+++ b/arch/arm/dts/s5l8702-common.dtsi
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Peripherals common to Samsung S5L8702 and later SoCs
+ *
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include "s5l87xx.dtsi"
+
+/ {
+	soc {
+		vic0: interrupt-controller@38e00000 {
+			compatible = "arm,pl192-vic";
+			interrupt-controller;
+			reg = <0x38e00000 0x1000>;
+			#interrupt-cells = <1>;
+		};
+
+		usbotg_hs: usb@38400000 {
+			compatible = "apple,s5l87xx-usb";
+			reg = <0x38400000 0x40000>;
+			interrupt-parent = <&vic0>;
+			interrupts = <19>;
+			phys = <&usbphy>;
+			phy-names = "usb2-phy";
+			clocks = <&clkref>;
+			clock-names = "otg";
+			g-rx-fifo-size = <256>;
+			g-np-tx-fifo-size = <256>;
+			g-tx-fifo-size = <256 256 256 256 256 256>;
+			dr_mode = "peripheral";
+		};
+	};
+};
diff --git a/arch/arm/dts/s5l8702-n25.dts b/arch/arm/dts/s5l8702-n25.dts
new file mode 100644
index 00000000000..a069e4e3609
--- /dev/null
+++ b/arch/arm/dts/s5l8702-n25.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPod classic (6th generation)
+ *
+ * target-type: N25
+ *
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+/dts-v1/;
+
+#include "s5l8702.dtsi"
+#include "s5l87xx-nxx.dtsi"
+
+/ {
+	compatible = "apple,n25", "samsung,s5l8702", "apple,arm-platform";
+	model = "Apple iPod classic (6th generation)";
+};
+
+&memory {
+	reg = <0x08000000 0x04000000>; /* 64 MiB SDRAM */
+};
+
+&clkref {
+	clock-frequency = <12000000>;
+};
diff --git a/arch/arm/dts/s5l8702-n46.dts b/arch/arm/dts/s5l8702-n46.dts
new file mode 100644
index 00000000000..e7fe5cb26ec
--- /dev/null
+++ b/arch/arm/dts/s5l8702-n46.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPod nano (3rd generation)
+ *
+ * target-type: N46
+ *
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+/dts-v1/;
+
+#include "s5l8702.dtsi"
+#include "s5l87xx-nxx.dtsi"
+
+/ {
+	compatible = "apple,n46", "samsung,s5l8702", "apple,arm-platform";
+	model = "Apple iPod nano (3rd generation)";
+};
+
+&memory {
+	reg = <0x08000000 0x02000000>; /* 32 MiB SDRAM */
+};
+
+&clkref {
+	clock-frequency = <12000000>;
+};
diff --git a/arch/arm/dts/s5l8702.dtsi b/arch/arm/dts/s5l8702.dtsi
new file mode 100644
index 00000000000..b94dbd87b9c
--- /dev/null
+++ b/arch/arm/dts/s5l8702.dtsi
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Samsung S5L8702 SoC
+ *
+ * Other names: M1A
+ *
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include "s5l87xx.dtsi"
+#include "s5l8702-common.dtsi"
+
+/ {
+	compatible = "samsung,s5l8702", "apple,arm-platform";
+
+	chosen {
+		stdout-path = &uart0;
+	};
+};
+
+&cpu0 {
+	compatible = "arm,arm926ejs";
+};
+
+&clkgates {
+	/*
+	 * Clock-gate name -> {gate, bit} table consumed by s5l87xx_enable_clkgate().
+	 * Each entry is two cells: gate * 32 + bit, with 0xffffffff for an unused
+	 * second gate. Timers carry a secondary gate 4 enable; S5L8702 itself gates
+	 * all timers behind one gate (rockbox CLOCKGATE_TIMER 37 = {1,5}).
+	 */
+	clock-gate-names = "timer0", "timer1", "timer2", "timer3", "timer4",
+					   "timer7", "timer8", "uart0",
+					   "usb-otg", "usb2-phy", "bootrom",
+					   "timer", "lcd", "i2c0";
+	samsung,clock-gates = <37 128>, <55 129>, <56 130>, <57 131>, <58 132>,
+						  <69 150>, <70 151>, <41 135>,
+						  <2 0xffffffff>, <35 0xffffffff>, <30 0xffffffff>,
+						  <37 0xffffffff>, <1 0xffffffff>, <36 0xffffffff>;
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm/dts/s5l8720-n58s.dts b/arch/arm/dts/s5l8720-n58s.dts
new file mode 100644
index 00000000000..033127ebe28
--- /dev/null
+++ b/arch/arm/dts/s5l8720-n58s.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPod nano (4th generation)
+ *
+ * target-type: N58s
+ *
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+/dts-v1/;
+
+#include "s5l8720.dtsi"
+#include "s5l87xx-nxx.dtsi"
+
+/ {
+	compatible = "apple,n58s", "samsung,s5l8720", "apple,arm-platform";
+	model = "Apple iPod nano (4th generation)";
+};
+
+&memory {
+	reg = <0x08000000 0x02000000>; /* 32 MiB SDRAM */
+};
+
+&clkref {
+	clock-frequency = <24000000>;
+};
diff --git a/arch/arm/dts/s5l8720.dtsi b/arch/arm/dts/s5l8720.dtsi
new file mode 100644
index 00000000000..1c6853deaa6
--- /dev/null
+++ b/arch/arm/dts/s5l8720.dtsi
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Samsung S5L8720 SoC
+ *
+ * Other names: M2S
+ *
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include "s5l87xx.dtsi"
+#include "s5l8702-common.dtsi"
+
+/ {
+	compatible = "samsung,s5l8720", "apple,arm-platform";
+
+	chosen {
+		stdout-path = &uart0;
+	};
+};
+
+&cpu0 {
+	compatible = "arm,arm1176jzf-s";
+};
+
+&clkgates {
+	/*
+	 * Clock-gate name -> {gate, bit} table consumed by s5l87xx_enable_clkgate().
+	 * Each entry is two cells: gate * 32 + bit, with 0xffffffff for an unused
+	 * second gate.
+	 */
+	clock-gate-names = "timer0", "timer1", "timer2", "timer3", "timer4",
+					   "timer5", "timer6", "timer7", "timer8",
+					   "uart0", "usb-otg", "usb2-phy", "bootrom";
+	samsung,clock-gates = <37 128>, <55 129>, <56 130>, <57 131>, <58 132>,
+						  <59 133>, <60 134>, <69 150>, <70 151>,
+						  <41 135>, <2 0xffffffff>, <35 0xffffffff>,
+						  <13 0xffffffff>;
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm/dts/s5l8723-n20.dts b/arch/arm/dts/s5l8723-n20.dts
new file mode 100644
index 00000000000..f2996f495b2
--- /dev/null
+++ b/arch/arm/dts/s5l8723-n20.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPod nano (6th generation)
+ *
+ * target-type: N20
+ *
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+/dts-v1/;
+
+#include "s5l8723.dtsi"
+#include "s5l87xx-nxx.dtsi"
+
+/ {
+	compatible = "apple,n20", "samsung,s5l8723", "apple,arm-platform";
+	model = "Apple iPod nano (6th generation)";
+};
+
+&memory {
+	reg = <0x08000000 0x04000000>; /* 64 MiB SDRAM */
+};
+
+&clkref {
+	clock-frequency = <24000000>;
+};
diff --git a/arch/arm/dts/s5l8723.dtsi b/arch/arm/dts/s5l8723.dtsi
new file mode 100644
index 00000000000..be83c0f4ebc
--- /dev/null
+++ b/arch/arm/dts/s5l8723.dtsi
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Samsung S5L8723 SoC
+ *
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include "s5l87xx.dtsi"
+#include "s5l8702-common.dtsi"
+
+/ {
+	compatible = "samsung,s5l8723", "apple,arm-platform";
+
+	chosen {
+		stdout-path = &uart0;
+	};
+};
+
+&cpu0 {
+	compatible = "arm,arm1176jzf-s";
+};
+
+&clkgates {
+	/*
+	 * Clock-gate name -> {gate, bit} table consumed by s5l87xx_enable_clkgate().
+	 * Each entry is two cells: gate * 32 + bit, with 0xffffffff for an unused
+	 * second gate.
+	 */
+	clock-gate-names = "timer0", "timer1", "timer2", "timer3", "timer4",
+					   "timer5", "timer6", "timer7", "timer8",
+					   "uart0", "usb-otg", "usb2-phy", "bootrom";
+	samsung,clock-gates = <37 128>, <55 129>, <56 130>, <57 131>, <58 132>,
+						  <56 130>, <57 131>, <69 150>, <70 151>,
+						  <41 135>, <2 0xffffffff>, <35 0xffffffff>,
+						  <13 0xffffffff>;
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm/dts/s5l8730-n33.dts b/arch/arm/dts/s5l8730-n33.dts
new file mode 100644
index 00000000000..fb2fecedf09
--- /dev/null
+++ b/arch/arm/dts/s5l8730-n33.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPod nano (5th generation)
+ *
+ * target-type: N33
+ *
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+/dts-v1/;
+
+#include "s5l8730.dtsi"
+#include "s5l87xx-nxx.dtsi"
+
+/ {
+	compatible = "apple,n33", "samsung,s5l8730", "apple,arm-platform";
+	model = "Apple iPod nano (5th generation)";
+};
+
+&memory {
+	reg = <0x08000000 0x04000000>; /* 64 MiB SDRAM */
+};
+
+&clkref {
+	clock-frequency = <24000000>;
+};
diff --git a/arch/arm/dts/s5l8730.dtsi b/arch/arm/dts/s5l8730.dtsi
new file mode 100644
index 00000000000..902a8ac5dc1
--- /dev/null
+++ b/arch/arm/dts/s5l8730.dtsi
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Samsung S5L8730 SoC
+ *
+ * Other names: M2
+ *
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include "s5l87xx.dtsi"
+#include "s5l8702-common.dtsi"
+
+/ {
+	compatible = "samsung,s5l8730", "apple,arm-platform";
+
+	chosen {
+		stdout-path = &uart0;
+	};
+};
+
+&cpu0 {
+	compatible = "arm,arm1176jzf-s";
+};
+
+&clkgates {
+	/*
+	 * Clock-gate name -> {gate, bit} table consumed by s5l87xx_enable_clkgate().
+	 * Each entry is two cells: gate * 32 + bit, with 0xffffffff for an unused
+	 * second gate.
+	 */
+	clock-gate-names = "timer0", "timer1", "timer2", "timer3", "timer4",
+					   "timer5", "timer6", "timer7", "timer8",
+					   "uart0", "usb-otg", "usb2-phy", "bootrom";
+	samsung,clock-gates = <37 128>, <55 129>, <56 130>, <57 131>, <58 132>,
+						  <59 133>, <60 134>, <69 150>, <70 151>,
+						  <41 135>, <2 0xffffffff>, <35 0xffffffff>,
+						  <13 0xffffffff>;
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm/dts/s5l8740-n31.dts b/arch/arm/dts/s5l8740-n31.dts
new file mode 100644
index 00000000000..a5248ba06e1
--- /dev/null
+++ b/arch/arm/dts/s5l8740-n31.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPod nano (7th generation)
+ *
+ * target-type: N31
+ *
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+/dts-v1/;
+
+#include "s5l8740.dtsi"
+#include "s5l87xx-nxx.dtsi"
+
+/ {
+	compatible = "apple,n31", "samsung,s5l8740", "apple,arm-platform";
+	model = "Apple iPod nano (7th generation)";
+};
+
+&memory {
+	reg = <0x08000000 0x04000000>; /* 64 MiB SDRAM */
+};
+
+&clkref {
+	clock-frequency = <24000000>;
+};
diff --git a/arch/arm/dts/s5l8740.dtsi b/arch/arm/dts/s5l8740.dtsi
new file mode 100644
index 00000000000..e14a1d0c10e
--- /dev/null
+++ b/arch/arm/dts/s5l8740.dtsi
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Samsung S5L8740 SoC
+ *
+ * Other names: M2R
+ *
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include "s5l87xx.dtsi"
+#include "s5l8702-common.dtsi"
+
+/ {
+	compatible = "samsung,s5l8740", "apple,arm-platform";
+
+	chosen {
+		stdout-path = &uart3;
+	};
+};
+
+&cpu0 {
+	compatible = "arm,cortex-a5";
+};
+
+&clkgates {
+	/*
+	 * Clock-gate name -> {gate, bit} table consumed by s5l87xx_enable_clkgate().
+	 * Each entry is two cells: gate * 32 + bit, with 0xffffffff for an unused
+	 * second gate.
+	 */
+	clock-gate-names = "timer0", "timer1", "timer2", "timer3", "timer4",
+					   "timer5", "timer6", "timer7", "timer8",
+					   "uart0", "uart1", "uart2", "uart3",
+					   "usb-otg", "usb2-phy", "bootrom";
+	samsung,clock-gates = <37 128>, <55 129>, <56 130>, <57 131>, <58 132>,
+						  <56 130>, <57 131>, <69 150>, <70 151>,
+						  <41 135>, <61 136>, <62 137>, <63 138>,
+						  <2 0xffffffff>, <35 0xffffffff>, <13 0xffffffff>;
+};
+
+&uart3 {
+	status = "okay";
+};
diff --git a/arch/arm/dts/s5l87xx-nxx.dtsi b/arch/arm/dts/s5l87xx-nxx.dtsi
new file mode 100644
index 00000000000..152d8fc23a7
--- /dev/null
+++ b/arch/arm/dts/s5l87xx-nxx.dtsi
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPod nano (2nd, 3rd, 4th, 5th, 6th and 7th generation) and iPod classic (6th generation)
+ *
+ * This file contains parts common to all Apple iPod devices using the s5l87xx.
+ *
+ * target-type: N36, N46, N58s, N33, N20, N31, N25
+ *
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+/ {
+	memory: memory {
+		device_type = "memory";
+	};
+
+	clkref: clock-ref {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-output-names = "clkref";
+	};
+};
diff --git a/arch/arm/dts/s5l87xx.dtsi b/arch/arm/dts/s5l87xx.dtsi
new file mode 100644
index 00000000000..ac985ee6c37
--- /dev/null
+++ b/arch/arm/dts/s5l87xx.dtsi
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Samsung S5L87xx SoC family
+ *
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			reg = <0x0>;
+		};
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		clkgates: clkgates {
+			compatible = "samsung,s5l87xx-clkgates";
+		};
+
+		uart0: uart@3cc00000 {
+			compatible = "apple,s5l-uart";
+			reg = <0x3cc00000 0x3c>;
+			clocks = <&clkref>, <&clkref>;
+			clock-names = "uart", "clk_uart_baud0";
+			reg-io-width = <4>;
+			id = <0>;
+			status = "disabled";
+		};
+
+		uart1: uart@3db00000 {
+			compatible = "apple,s5l-uart";
+			reg = <0x3db00000 0x3c>;
+			clocks = <&clkref>, <&clkref>;
+			clock-names = "uart", "clk_uart_baud0";
+			reg-io-width = <4>;
+			id = <1>;
+			status = "disabled";
+		};
+
+		uart2: uart@3dc00000 {
+			compatible = "apple,s5l-uart";
+			reg = <0x3dc00000 0x3c>;
+			clocks = <&clkref>, <&clkref>;
+			clock-names = "uart", "clk_uart_baud0";
+			reg-io-width = <4>;
+			id = <2>;
+			status = "disabled";
+		};
+
+		uart3: uart@3dd00000 {
+			compatible = "apple,s5l-uart";
+			reg = <0x3dd00000 0x3c>;
+			clocks = <&clkref>, <&clkref>;
+			clock-names = "uart", "clk_uart_baud0";
+			reg-io-width = <4>;
+			id = <3>;
+			status = "disabled";
+		};
+
+		usbphy: usbphy@3c400000 {
+			compatible = "apple,s5l87xx-otgphy";
+			reg = <0x3c400000 0x100>;
+			#phy-cells = <0>;
+		};
+	};
+};
diff --git a/arch/arm/include/asm/arch-s5l8701/uart.h b/arch/arm/include/asm/arch-s5l8701/uart.h
new file mode 100644
index 00000000000..da07b296b6d
--- /dev/null
+++ b/arch/arm/include/asm/arch-s5l8701/uart.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2009 Samsung Electronics
+ * Minkyu Kang <mk7.kang@samsung.com>
+ * Heungjun Kim <riverful.kim@samsung.com>
+ */
+
+#ifndef __ASM_ARCH_UART_H_
+#define __ASM_ARCH_UART_H_
+
+#ifndef __ASSEMBLY__
+
+struct s5p_uart {
+	unsigned int	ulcon;
+	unsigned int	ucon;
+	unsigned int	ufcon;
+	unsigned int	umcon;
+	unsigned int	utrstat;
+	unsigned int	uerstat;
+	unsigned int	ufstat;
+	unsigned int	umstat;
+	unsigned int	utxh;
+	unsigned int	urxh;
+	unsigned int	ubrdiv;
+};
+
+#endif	/* __ASSEMBLY__ */
+
+#endif
diff --git a/arch/arm/include/asm/arch-s5l8702/uart.h b/arch/arm/include/asm/arch-s5l8702/uart.h
new file mode 100644
index 00000000000..da07b296b6d
--- /dev/null
+++ b/arch/arm/include/asm/arch-s5l8702/uart.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2009 Samsung Electronics
+ * Minkyu Kang <mk7.kang@samsung.com>
+ * Heungjun Kim <riverful.kim@samsung.com>
+ */
+
+#ifndef __ASM_ARCH_UART_H_
+#define __ASM_ARCH_UART_H_
+
+#ifndef __ASSEMBLY__
+
+struct s5p_uart {
+	unsigned int	ulcon;
+	unsigned int	ucon;
+	unsigned int	ufcon;
+	unsigned int	umcon;
+	unsigned int	utrstat;
+	unsigned int	uerstat;
+	unsigned int	ufstat;
+	unsigned int	umstat;
+	unsigned int	utxh;
+	unsigned int	urxh;
+	unsigned int	ubrdiv;
+};
+
+#endif	/* __ASSEMBLY__ */
+
+#endif
diff --git a/arch/arm/include/asm/arch-s5l8720/uart.h b/arch/arm/include/asm/arch-s5l8720/uart.h
new file mode 100644
index 00000000000..da07b296b6d
--- /dev/null
+++ b/arch/arm/include/asm/arch-s5l8720/uart.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2009 Samsung Electronics
+ * Minkyu Kang <mk7.kang@samsung.com>
+ * Heungjun Kim <riverful.kim@samsung.com>
+ */
+
+#ifndef __ASM_ARCH_UART_H_
+#define __ASM_ARCH_UART_H_
+
+#ifndef __ASSEMBLY__
+
+struct s5p_uart {
+	unsigned int	ulcon;
+	unsigned int	ucon;
+	unsigned int	ufcon;
+	unsigned int	umcon;
+	unsigned int	utrstat;
+	unsigned int	uerstat;
+	unsigned int	ufstat;
+	unsigned int	umstat;
+	unsigned int	utxh;
+	unsigned int	urxh;
+	unsigned int	ubrdiv;
+};
+
+#endif	/* __ASSEMBLY__ */
+
+#endif
diff --git a/arch/arm/include/asm/arch-s5l8723/uart.h b/arch/arm/include/asm/arch-s5l8723/uart.h
new file mode 100644
index 00000000000..da07b296b6d
--- /dev/null
+++ b/arch/arm/include/asm/arch-s5l8723/uart.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2009 Samsung Electronics
+ * Minkyu Kang <mk7.kang@samsung.com>
+ * Heungjun Kim <riverful.kim@samsung.com>
+ */
+
+#ifndef __ASM_ARCH_UART_H_
+#define __ASM_ARCH_UART_H_
+
+#ifndef __ASSEMBLY__
+
+struct s5p_uart {
+	unsigned int	ulcon;
+	unsigned int	ucon;
+	unsigned int	ufcon;
+	unsigned int	umcon;
+	unsigned int	utrstat;
+	unsigned int	uerstat;
+	unsigned int	ufstat;
+	unsigned int	umstat;
+	unsigned int	utxh;
+	unsigned int	urxh;
+	unsigned int	ubrdiv;
+};
+
+#endif	/* __ASSEMBLY__ */
+
+#endif
diff --git a/arch/arm/include/asm/arch-s5l8730/uart.h b/arch/arm/include/asm/arch-s5l8730/uart.h
new file mode 100644
index 00000000000..da07b296b6d
--- /dev/null
+++ b/arch/arm/include/asm/arch-s5l8730/uart.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2009 Samsung Electronics
+ * Minkyu Kang <mk7.kang@samsung.com>
+ * Heungjun Kim <riverful.kim@samsung.com>
+ */
+
+#ifndef __ASM_ARCH_UART_H_
+#define __ASM_ARCH_UART_H_
+
+#ifndef __ASSEMBLY__
+
+struct s5p_uart {
+	unsigned int	ulcon;
+	unsigned int	ucon;
+	unsigned int	ufcon;
+	unsigned int	umcon;
+	unsigned int	utrstat;
+	unsigned int	uerstat;
+	unsigned int	ufstat;
+	unsigned int	umstat;
+	unsigned int	utxh;
+	unsigned int	urxh;
+	unsigned int	ubrdiv;
+};
+
+#endif	/* __ASSEMBLY__ */
+
+#endif
diff --git a/arch/arm/include/asm/arch-s5l8740/uart.h b/arch/arm/include/asm/arch-s5l8740/uart.h
new file mode 100644
index 00000000000..da07b296b6d
--- /dev/null
+++ b/arch/arm/include/asm/arch-s5l8740/uart.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2009 Samsung Electronics
+ * Minkyu Kang <mk7.kang@samsung.com>
+ * Heungjun Kim <riverful.kim@samsung.com>
+ */
+
+#ifndef __ASM_ARCH_UART_H_
+#define __ASM_ARCH_UART_H_
+
+#ifndef __ASSEMBLY__
+
+struct s5p_uart {
+	unsigned int	ulcon;
+	unsigned int	ucon;
+	unsigned int	ufcon;
+	unsigned int	umcon;
+	unsigned int	utrstat;
+	unsigned int	uerstat;
+	unsigned int	ufstat;
+	unsigned int	umstat;
+	unsigned int	utxh;
+	unsigned int	urxh;
+	unsigned int	ubrdiv;
+};
+
+#endif	/* __ASSEMBLY__ */
+
+#endif
diff --git a/arch/arm/include/asm/arch-s5l87xx/s5l87xx-clk.h b/arch/arm/include/asm/arch-s5l87xx/s5l87xx-clk.h
new file mode 100644
index 00000000000..ad6a9ceca87
--- /dev/null
+++ b/arch/arm/include/asm/arch-s5l87xx/s5l87xx-clk.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#ifndef __S5L87XX_CLK_H_
+#define __S5L87XX_CLK_H_
+
+#include <inttypes.h>
+
+/*
+ * Ungate a single clock gate by raw {gate, bit}. Unlike s5l87xx_enable_clkgate()
+ * this needs no device tree, so it is safe in pre-relocation paths (e.g. the
+ * debug UART init, which runs before the FDT is set up).
+ */
+void s5l87xx_enable_clkgate_bit(u8 gate, u8 bit);
+void s5l87xx_enable_clkgate(const char *id);
+
+#endif //__S5L87XX_CLK_H_
diff --git a/arch/arm/include/asm/arch-s5l87xx/s5l87xx.h b/arch/arm/include/asm/arch-s5l87xx/s5l87xx.h
new file mode 100644
index 00000000000..ebcfe51e8b3
--- /dev/null
+++ b/arch/arm/include/asm/arch-s5l87xx/s5l87xx.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#ifndef __S5L87XX_H_
+#define __S5L87XX_H_
+
+#include <linux/types.h>
+
+#if IS_ENABLED(CONFIG_S5L8701)
+#define S5L87XX_LCD_BASE 0x38600000
+#else
+#define S5L87XX_LCD_BASE 0x38300000
+#endif
+
+#if IS_ENABLED(CONFIG_S5L8701)
+#define S5L87XX_OTG_BASE 0x38800000
+#else
+#define S5L87XX_OTG_BASE 0x38400000
+#endif
+
+#define S5L87XX_VIC_BASE         0x38E00000
+#define S5L87XX_VIC_OFFSET       0x1000
+#define S5L87XX_VICBASE(v)       (S5L87XX_VIC_BASE + S5L87XX_VIC_OFFSET * (v))
+#define S5L87XX_VICINTENCLEAR(v) (S5L87XX_VICBASE(v) + 0x14)
+
+#define S5L87XX_INT_BASE 0x39C00000
+/*
+ * Determines which interrupt source is masked.
+ * The masked interrupt source will not be serviced.
+ */
+#define S5L87XX_INTMSK   (S5L87XX_INT_BASE + 0x08)
+
+#define IRQ_USB_FUNC 16
+
+#define S5L87XX_PHY_BASE 0x3C400000
+
+#define S5L87XX_CLK_BASE  0x3C500000
+
+#if IS_ENABLED(CONFIG_S5L8701)
+#define S5L87XX_SWRCON    (S5L87XX_CLK_BASE + 0x30) /* Software reset control register */
+#define S5L87XX_PWRCON(i) (S5L87XX_CLK_BASE + ((i) == 1 ? 0x40 : 0x28))
+#else
+#define S5L87XX_SWRCON    (S5L87XX_CLK_BASE + 0x50)
+/* S5L8702 only uses PWRCON(0) and PWRCON(1) */
+#define S5L87XX_PWRCON(i) (S5L87XX_CLK_BASE + \
+							((i) == 4 ? 0x6C : \
+							((i) == 3 ? 0x68 : \
+							((i) == 2 ? 0x58 : \
+							((i) == 1 ? 0x4C : \
+								0x48)))))
+#endif
+
+#define S5L87XX_TIMER_BASE 0x3C700000
+
+#define S5L87XX_WDT_BASE 0x3C800000
+#define S5L87XX_WDTCON   S5L87XX_WDT_BASE			/* Control Register */
+#define S5L87XX_WDTCNT   (S5L87XX_WDT_BASE + 0x04)	/* 11-bits internal counter */
+
+#define S5L87XX_GPIO_BASE    0x3CF00000
+#define S5L87XX_PCON(n) (S5L87XX_GPIO_BASE + 0x00 + (n) * 0x20)
+#define S5L87XX_PUNB(n) (S5L87XX_GPIO_BASE + 0x0c + (n) * 0x20)
+#define S5L87XX_PUNC(n) (S5L87XX_GPIO_BASE + 0x10 + (n) * 0x20)
+#define S5L87XX_PPIE(n) (S5L87XX_GPIO_BASE + 0x14 + (n) * 0x20)
+
+#define S5L87XX_PCON_PINS_CLEAR_FN(rx_pin, tx_pin) (~(GENMASK((((rx_pin) + 1) * 4) - 1, \
+	(rx_pin) * 4) | GENMASK((((tx_pin) + 1) * 4) - 1, (tx_pin) * 4)))
+#define S5L87XX_PCON_PINS_SET_FN(rx_pin, tx_pin, fn) (((fn) << ((rx_pin) * 4)) |\
+	((fn) << ((tx_pin) * 4)))
+
+#define S5L87XX_BUS_BASE 0x3E000000
+
+/* Move 0xd3 value to CPSR register to enable SVC mode */
+#define svc32_mode_en() __asm__ __volatile__				\
+			("@ I&F disable, Mode: 0x13 - SVC\n\t"		\
+			 "msr     cpsr_c, %0\n\t" : : "r"(0x13 | 0xC0))
+
+#endif //__S5L87XX_H_
diff --git a/arch/arm/mach-s5l87xx/Kconfig b/arch/arm/mach-s5l87xx/Kconfig
new file mode 100644
index 00000000000..81485943d00
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/Kconfig
@@ -0,0 +1,53 @@
+if ARCH_S5L87XX
+
+config S5L8701
+	bool "S5L8701"
+	# Actually an ARM940T
+	select CPU_ARM920T
+	help
+	  The Samsung S5L8701 is an ARM-based SoC with a single core ARM940T.
+	  Peripherals include USB2 device, USB1.1 OTG, I2C, I2S, UART and SPI.
+
+config S5L8702
+	bool "S5L8702"
+	select CPU_ARM926EJS
+	help
+	  The Samsung S5L8702 is an ARM-based SoC with a single core ARM926EJ-S.
+	  Peripherals include USB2 device, USB1.1 OTG, I2C, I2S, UART and SPI.
+
+config S5L8720
+	bool "S5L8720"
+	select CPU_ARM1176
+	help
+	  The Samsung S5L8720 is an ARM-based SoC with a single core ARM1176JZF-S.
+	  Peripherals include USB2 device, USB1.1 OTG, I2C, I2S, UART and SPI.
+
+config S5L8723
+	bool "S5L8723"
+	select CPU_ARM1176
+	help
+	  The Samsung S5L8723 is an ARM-based SoC with a single core ARM1176JZF-S.
+	  Peripherals include USB2 device, USB1.1 OTG, I2C, I2S, UART and SPI.
+
+config S5L8730
+	bool "S5L8730"
+	select CPU_ARM1176
+	help
+	  The Samsung S5L8730 is an ARM-based SoC with a single core ARM1176JZF-S.
+	  Peripherals include USB2 device, USB1.1 OTG, I2C, I2S, UART and SPI.
+
+config S5L8740
+	bool "S5L8740"
+	select CPU_V7A
+	help
+	  The Samsung S5L8740 is an ARM-based SoC with a single core ARM Cortex A5.
+	  Peripherals include USB2 device, USB1.1 OTG, I2C, I2S, UART and SPI.
+
+source "arch/arm/mach-s5l87xx/s5l8701/Kconfig"
+source "arch/arm/mach-s5l87xx/s5l8702/Kconfig"
+source "arch/arm/mach-s5l87xx/s5l8720/Kconfig"
+source "arch/arm/mach-s5l87xx/s5l8723/Kconfig"
+source "arch/arm/mach-s5l87xx/s5l8730/Kconfig"
+source "arch/arm/mach-s5l87xx/s5l8740/Kconfig"
+
+endif
diff --git a/arch/arm/mach-s5l87xx/Makefile b/arch/arm/mach-s5l87xx/Makefile
new file mode 100644
index 00000000000..08648c59392
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/Makefile
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2026 The freemyipod team (freemyipod.org)
+#
+
+obj-y += s5l87xx.o
+obj-y += s5l87xx-clk.o
+
+obj-$(CONFIG_S5L8701) += s5l8701.o
+obj-$(CONFIG_S5L8701) += s5l8701-otg-phy.o
+obj-$(CONFIG_S5L8701) += s5l8701-timer.o
+
+obj-$(CONFIG_S5L8702) += relocate.o
+obj-$(CONFIG_S5L8702) += s5l8702.o
+obj-$(CONFIG_S5L8702) += s5l8702-otg-phy.o
+obj-$(CONFIG_S5L8702) += s5l87xx-timer.o
+
+obj-$(CONFIG_S5L8720) += relocate.o
+obj-$(CONFIG_S5L8720) += s5l8720.o
+obj-$(CONFIG_S5L8720) += s5l87xx-otg-phy.o
+obj-$(CONFIG_S5L8720) += s5l87xx-timer.o
+
+obj-$(CONFIG_S5L8723) += relocate.o
+obj-$(CONFIG_S5L8723) += s5l8723.o
+obj-$(CONFIG_S5L8723) += s5l87xx-otg-phy.o
+obj-$(CONFIG_S5L8723) += s5l87xx-timer.o
+
+obj-$(CONFIG_S5L8730) += relocate.o
+obj-$(CONFIG_S5L8730) += s5l8730.o
+#obj-$(CONFIG_S5L8730) += s5l87xx-buscon.o
+obj-$(CONFIG_S5L8730) += s5l87xx-otg-phy.o
+obj-$(CONFIG_S5L8730) += s5l87xx-timer.o
+
+obj-$(CONFIG_S5L8740) += s5l8740.o
+obj-$(CONFIG_S5L8740) += s5l87xx-otg-phy.o
+obj-$(CONFIG_S5L8740) += s5l87xx-timer.o
diff --git a/arch/arm/mach-s5l87xx/relocate.S b/arch/arm/mach-s5l87xx/relocate.S
new file mode 100644
index 00000000000..65987d0f1e8
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/relocate.S
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include <asm-offsets.h>
+#include <config.h>
+#include <linux/linkage.h>
+
+    .section    .text.relocate_vectors,"ax",%progbits
+
+ENTRY(relocate_vectors)
+    /* Remap SRAM to 00000000. */
+    ldr r0, =0x3e00000c
+    mov r1, #3 /* REMAP_SRAM | REMAP_ENABLE */
+    str r1, [r0]
+
+    /* Copy vectors to 00000000. */
+    ldr r0, [r9, #GD_RELOCADDR] /* r0 = gd->relocaddr */
+    ldr     r1, =0x00000000
+    ldmia   r0!, {r2-r8,r10}
+    stmia   r1!, {r2-r8,r10}
+    ldmia   r0!, {r2-r8,r10}
+    stmia   r1!, {r2-r8,r10}
+
+    bx lr
+ENDPROC(relocate_vectors)
diff --git a/arch/arm/mach-s5l87xx/s5l8701-otg-phy.c b/arch/arm/mach-s5l87xx/s5l8701-otg-phy.c
new file mode 100644
index 00000000000..28ca39b160c
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l8701-otg-phy.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include <init.h>
+#include <asm/io.h>
+#include <asm/arch-s5l87xx/s5l87xx.h>
+#include <asm/arch-s5l87xx/s5l87xx-clk.h>
+#include <linux/delay.h>
+
+struct s5l87xx_otgphy {
+	u32 pwr;	 // 0x00
+	u32 con;	 // 0x04
+	u32 rstcon;  // 0x08
+	u32 unk[4];  // 0x0c, 0x10, 0x14, 0x18
+	u32 unkcon;  // 0x1c
+	u32 pad[36]; // 0x20 - 0x44
+	u32 unk44;   // 0x44
+};
+
+void otg_phy_init(void *unused)
+{
+	struct s5l87xx_otgphy *otgphy = (struct s5l87xx_otgphy *)S5L87XX_PHY_BASE;
+
+	log_debug("s5l8701_otgphy: turning on\n");
+	s5l87xx_enable_clkgate("usb-otg");
+	s5l87xx_enable_clkgate("usb2-phy");
+	mdelay(10);
+
+	// Disable USB suspend.
+	writel(0, S5L87XX_OTG_BASE + 0xe00);
+
+	writel(0, &otgphy->pwr); /* PHY: Power up */
+	udelay(10);
+	writel(1, &otgphy->unkcon);
+	writel(0xe3f, &otgphy->unk44);
+	writel(1, &otgphy->rstcon); /* PHY: Assert Software Reset */
+	udelay(10);
+	writel(0, &otgphy->rstcon); /* PHY: Deassert Software Reset */
+	udelay(10);
+	writel(0x600, &otgphy->unk[3]);
+	writel(0, &otgphy->con);
+	udelay(400);
+}
+
+void otg_phy_off(void *unused)
+{
+	struct s5l87xx_otgphy *otgphy = (struct s5l87xx_otgphy *)S5L87XX_PHY_BASE;
+
+	log_debug("s5l8701_otgphy: turning off\n");
+	writel(0x0F, &otgphy->pwr); /* PHY: Power down */
+	udelay(10);
+	writel(0x07, &otgphy->rstcon); /* PHY: Assert Software Reset */
+	udelay(10);
+}
diff --git a/arch/arm/mach-s5l87xx/s5l8701-timer.c b/arch/arm/mach-s5l87xx/s5l8701-timer.c
new file mode 100644
index 00000000000..4d4044e7744
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l8701-timer.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include <init.h>
+#include <asm/io.h>
+#include <asm/arch-s5l87xx/s5l87xx.h>
+#include <asm/arch-s5l87xx/s5l87xx-clk.h>
+
+struct s5l87xx_timer {
+	u32 con;	// 0x00
+	u32 cmd;	// 0x04
+	u32 data0;	// 0x08
+	u32 data1;	// 0x0c
+	u32 pre;	// 0x10
+	u32 cnt;	// 0x14
+};
+
+enum s5l87xx_timer_id {
+	//  Timers A, B, C, D: 16-bit
+	S5L87XX_TIMER_A = 0,
+	S5L87XX_TIMER_B = 1,
+	S5L87XX_TIMER_C = 2,
+	S5L87XX_TIMER_D = 3,
+};
+
+#define SYSTEM_TIMER S5L87XX_TIMER_C
+
+enum s5l87xx_timer_cmd {
+	S5L87XX_TIMER_CMD_STOP = 0,
+	S5L87XX_TIMER_CMD_START = 1,
+	S5L87XX_TIMER_CMD_CLR = 2,
+};
+
+static struct s5l87xx_timer *s5l87xx_timer_registers(enum s5l87xx_timer_id id)
+{
+	switch (id) {
+	case S5L87XX_TIMER_A:
+		return (struct s5l87xx_timer *)S5L87XX_TIMER_BASE;
+	case S5L87XX_TIMER_B:
+		return (struct s5l87xx_timer *)(S5L87XX_TIMER_BASE + 0x20);
+	case S5L87XX_TIMER_C:
+		return (struct s5l87xx_timer *)(S5L87XX_TIMER_BASE + 0x40);
+	case S5L87XX_TIMER_D:
+		return (struct s5l87xx_timer *)(S5L87XX_TIMER_BASE + 0x60);
+	default:
+		panic("requested invalid timer id %d", id);
+	}
+}
+
+static const char *s5l87xx_timer_clockgate(enum s5l87xx_timer_id id)
+{
+	/* S5L8701 and S5L8702 gate all timers behind a single clock gate. */
+	return "timer";
+}
+
+static void s5l87xx_timer_configure_interval(enum s5l87xx_timer_id id)
+{
+	struct s5l87xx_timer *timer = s5l87xx_timer_registers(id);
+
+	log_debug("s5l87xx_timer: configuring %d in interval mode\n", id);
+	s5l87xx_enable_clkgate(s5l87xx_timer_clockgate(id));
+
+	writel(S5L87XX_TIMER_CMD_STOP, &timer->cmd);
+	/* configure timer for 1000 Hz??? */
+	writel((3 << 8) | (1 << 4), &timer->con);
+	writel(511, &timer->pre);
+	writel(0xffff, &timer->data0);
+	writel(0xffff, &timer->data1);
+	writel(S5L87XX_TIMER_CMD_CLR, &timer->cmd);
+}
+
+static void s5l87xx_timer_start(enum s5l87xx_timer_id id)
+{
+	struct s5l87xx_timer *timer = s5l87xx_timer_registers(id);
+
+	log_debug("s5l87xx_timer: starting %d\n", id);
+	writel(S5L87XX_TIMER_CMD_START, &timer->cmd);
+}
+
+static u32 s5l87xx_timer_read(enum s5l87xx_timer_id id)
+{
+	struct s5l87xx_timer *timer = s5l87xx_timer_registers(id);
+
+	return readl(&timer->cnt);
+}
+
+int timer_init(void)
+{
+	s5l87xx_timer_configure_interval(SYSTEM_TIMER);
+	s5l87xx_timer_start(SYSTEM_TIMER);
+
+	return 0;
+}
+
+unsigned long timer_read_counter(void)
+{
+	static u16 last, high;
+
+	u16 now = s5l87xx_timer_read(SYSTEM_TIMER);
+
+	if (now < last)
+		high++;
+
+	last = now;
+
+	return ((u32)high << 16) | (u32)now;
+}
diff --git a/arch/arm/mach-s5l87xx/s5l8701.c b/arch/arm/mach-s5l87xx/s5l8701.c
new file mode 100644
index 00000000000..9cacbf3eafb
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l8701.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include <init.h>
+
+int print_cpuinfo(void)
+{
+	printf("CPU:   Samsung S5L8701 (ARM940T)\n");
+	return 0;
+}
+
+void enable_caches(void)
+{
+	// Caches already enabled by the bootloader
+	// This is here so that we don't see
+	// WARNING: Caches not enabled
+}
+
+ulong get_tbclk(void)
+{
+	// Corresponds to timer setup from s5l8701-timer.c.
+	// Is this correct?
+	return 1416;
+}
diff --git a/arch/arm/mach-s5l87xx/s5l8701/Kconfig b/arch/arm/mach-s5l87xx/s5l8701/Kconfig
new file mode 100644
index 00000000000..5769e689db1
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l8701/Kconfig
@@ -0,0 +1,11 @@
+if S5L8701
+
+config TARGET_N36
+	bool "Apple N36 - iPod nano (2nd generation)"
+	help
+	  Apple iPod nano (2nd generation) is a digital audio player, introduced in
+	  September 2006. It has a NAND flash of either 2, 4 or 8 GiB.
+
+source "board/apple/n36/Kconfig"
+
+endif
diff --git a/arch/arm/mach-s5l87xx/s5l8702-otg-phy.c b/arch/arm/mach-s5l87xx/s5l8702-otg-phy.c
new file mode 100644
index 00000000000..f8913c196a8
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l8702-otg-phy.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include <init.h>
+#include <asm/io.h>
+#include <asm/arch-s5l87xx/s5l87xx.h>
+#include <asm/arch-s5l87xx/s5l87xx-clk.h>
+
+// S5L8702 OTG PHY register layout, reverse-engineered from a disk mode QEMU
+// trace. Differs from the S5L8730/N36 layout, so it is kept separate.
+struct s5l8702_otgphy {
+	u32 pwr;		// 0x00 - power down control
+	u32 clk;		// 0x04 - clock select
+	u32 rstcon;		// 0x08 - reset control (3 bits)
+	u32 pad0[3];	// 0x0c-0x14
+	u32 bias;		// 0x18 - analog bias/trim
+	u32 pad1[5];	// 0x1c-0x2c  (0x28 read-only by bootrom)
+	u32 intfcon;	// 0x30 - interface control
+	u32 pad2[3];	// 0x34-0x3c
+	u32 phy_ctrl1;	// 0x40 - analog power stage 1
+	u32 phy_ctrl2;	// 0x44 - analog power stage 2
+};
+
+void otg_phy_init(void *unused)
+{
+	struct s5l8702_otgphy *otgphy = (struct s5l8702_otgphy *)S5L87XX_PHY_BASE;
+
+	log_debug("s5l8702_otgphy: turning on\n");
+	s5l87xx_enable_clkgate("usb-otg");
+	s5l87xx_enable_clkgate("usb2-phy");
+
+	// Disable USB suspend.
+	writel(0, S5L87XX_OTG_BASE + 0xe00);
+
+	writel(0x000, &otgphy->pwr);
+	writel(0x000, &otgphy->clk);
+	writel(0x400, &otgphy->bias);
+	writel(0x007, &otgphy->rstcon); // assert all three reset signals
+
+	// Ramp up PHY analog stage 1 incrementally (from disk mode trace).
+	writel(0x300, &otgphy->phy_ctrl1);
+	writel(0x340, &otgphy->phy_ctrl1);
+	writel(0x346, &otgphy->phy_ctrl1);
+	writel(0x347, &otgphy->phy_ctrl1);
+
+	// Ramp up PHY analog stage 2 incrementally (from disk mode trace).
+	writel(0x0c00, &otgphy->phy_ctrl2);
+	writel(0x0fc0, &otgphy->phy_ctrl2);
+	writel(0x0fe0, &otgphy->phy_ctrl2);
+	writel(0x0ff0, &otgphy->phy_ctrl2);
+	writel(0x0fff, &otgphy->phy_ctrl2);
+
+	writel(1, S5L87XX_PHY_BASE + 0x100); // enable PHY output
+
+	writel(0x000, &otgphy->rstcon); // deassert reset
+	writel(0x400, &otgphy->bias);
+	writel(0x000, &otgphy->intfcon);
+	writel(0x000, &otgphy->bias);
+}
+
+void otg_phy_off(void *unused)
+{
+	struct s5l8702_otgphy *phy = (struct s5l8702_otgphy *)S5L87XX_PHY_BASE;
+
+	log_debug("s5l8702_otgphy: turning off\n");
+	writel(0, &phy->phy_ctrl2);
+	writel(0, &phy->phy_ctrl1);
+	writel(0x7, &phy->rstcon);
+	writel(0xff, &phy->pwr);
+}
diff --git a/arch/arm/mach-s5l87xx/s5l8702.c b/arch/arm/mach-s5l87xx/s5l8702.c
new file mode 100644
index 00000000000..58d8f9918d3
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l8702.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include <init.h>
+
+int print_cpuinfo(void)
+{
+	printf("CPU:   Samsung S5L8702 (ARM926EJ-S)\n");
+	return 0;
+}
+
+ulong get_tbclk(void)
+{
+	// Corresponds to TIMER_F setup from s5l87xx.c.
+	return 1000000;
+}
diff --git a/arch/arm/mach-s5l87xx/s5l8702/Kconfig b/arch/arm/mach-s5l87xx/s5l8702/Kconfig
new file mode 100644
index 00000000000..96307bdcad0
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l8702/Kconfig
@@ -0,0 +1,18 @@
+if S5L8702
+
+config TARGET_N46
+	bool "Apple N46 - iPod nano (3rd generation)"
+	help
+	  Apple iPod nano (3rd generation) is a digital audio player, introduced in
+	  September 2007. It has a NAND flash of either 4 or 8 GiB.
+
+config TARGET_N25
+	bool "Apple N25 - iPod classic (6th generation)"
+	help
+	  Apple iPod classic (6th generation) is a digital audio player, introduced
+	  in September 2007. It has a HDD of either 80, 120 or 160 GiB.
+
+source "board/apple/n46/Kconfig"
+source "board/apple/n25/Kconfig"
+
+endif
diff --git a/arch/arm/mach-s5l87xx/s5l8720.c b/arch/arm/mach-s5l87xx/s5l8720.c
new file mode 100644
index 00000000000..339d9ba6e49
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l8720.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include <init.h>
+
+int print_cpuinfo(void)
+{
+	printf("CPU:   Samsung S5L8720 (ARM1176JZF-S)\n");
+	return 0;
+}
+
+void lowlevel_init(void)
+{
+	// unused
+}
+
+ulong get_tbclk(void)
+{
+	// Corresponds to TIMER_F setup from s5l87xx.c.
+	return 1000000;
+}
diff --git a/arch/arm/mach-s5l87xx/s5l8720/Kconfig b/arch/arm/mach-s5l87xx/s5l8720/Kconfig
new file mode 100644
index 00000000000..f02eb9cb886
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l8720/Kconfig
@@ -0,0 +1,11 @@
+if S5L8720
+
+config TARGET_N58S
+	bool "Apple N58s - iPod nano (4th generation)"
+	help
+	  Apple iPod nano (4th generation) is a digital audio player, introduced in
+	  September 2008. It has a NAND flash of either 8 or 16 GiB.
+
+source "board/apple/n58s/Kconfig"
+
+endif
diff --git a/arch/arm/mach-s5l87xx/s5l8723.c b/arch/arm/mach-s5l87xx/s5l8723.c
new file mode 100644
index 00000000000..439a7655f63
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l8723.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include <init.h>
+
+int print_cpuinfo(void)
+{
+	printf("CPU:   Samsung S5L8723 (ARM1176JZF-S)\n");
+	return 0;
+}
+
+void lowlevel_init(void)
+{
+	// unused
+}
+
+ulong get_tbclk(void)
+{
+	// Corresponds to TIMER_F setup from s5l87xx.c.
+	return 1000000;
+}
diff --git a/arch/arm/mach-s5l87xx/s5l8723/Kconfig b/arch/arm/mach-s5l87xx/s5l8723/Kconfig
new file mode 100644
index 00000000000..6d2a01ecf4a
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l8723/Kconfig
@@ -0,0 +1,11 @@
+if S5L8723
+
+config TARGET_N20
+	bool "Apple N20 - iPod nano (6th generation)"
+	help
+	  Apple iPod nano (6th generation) is a digital audio player, introduced in
+	  September 2010. It has a NAND flash of either 8 or 16 GiB.
+
+source "board/apple/n20/Kconfig"
+
+endif
diff --git a/arch/arm/mach-s5l87xx/s5l8730.c b/arch/arm/mach-s5l87xx/s5l8730.c
new file mode 100644
index 00000000000..91e6abfb03d
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l8730.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include <init.h>
+
+int print_cpuinfo(void)
+{
+	printf("CPU:   Samsung S5L8730 (ARM1176JZF-S)\n");
+	return 0;
+}
+
+void lowlevel_init(void)
+{
+	// unused
+}
+
+ulong get_tbclk(void)
+{
+	// Corresponds to TIMER_F setup from s5l87xx.c.
+	return 1000000;
+}
diff --git a/arch/arm/mach-s5l87xx/s5l8730/Kconfig b/arch/arm/mach-s5l87xx/s5l8730/Kconfig
new file mode 100644
index 00000000000..4292529c6f8
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l8730/Kconfig
@@ -0,0 +1,11 @@
+if S5L8730
+
+config TARGET_N33
+	bool "Apple N33 - iPod nano (5th generation)"
+	help
+	  Apple iPod nano (5th generation) is a digital audio player, introduced in
+	  September 2009. It has a NAND flash of either 8 or 16 GiB.
+
+source "board/apple/n33/Kconfig"
+
+endif
diff --git a/arch/arm/mach-s5l87xx/s5l8740.c b/arch/arm/mach-s5l87xx/s5l8740.c
new file mode 100644
index 00000000000..f817bd4e2a3
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l8740.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include <init.h>
+
+int print_cpuinfo(void)
+{
+	printf("CPU:   Samsung S5L8740 (ARM Cortex A5)\n");
+	return 0;
+}
+
+void enable_caches(void)
+{
+	// Caches already enabled by the bootloader
+	// This is here so that we don't see
+	// WARNING: Caches not enabled
+}
+
+ulong get_tbclk(void)
+{
+	// Corresponds to TIMER_F setup from s5l87xx.c.
+	return 1000000;
+}
diff --git a/arch/arm/mach-s5l87xx/s5l8740/Kconfig b/arch/arm/mach-s5l87xx/s5l8740/Kconfig
new file mode 100644
index 00000000000..f58c16cfcd5
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l8740/Kconfig
@@ -0,0 +1,11 @@
+if S5L8740
+
+config TARGET_N31
+	bool "Apple N31 - iPod nano (7th generation)"
+	help
+	  Apple iPod nano (7th generation) is a digital audio player, introduced in
+	  October 2012. It has a NAND flash of 16 GiB.
+
+source "board/apple/n31/Kconfig"
+
+endif
diff --git a/arch/arm/mach-s5l87xx/s5l87xx-buscon.c b/arch/arm/mach-s5l87xx/s5l87xx-buscon.c
new file mode 100644
index 00000000000..2b79ae8c8f1
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l87xx-buscon.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include <init.h>
+#include <asm/io.h>
+#include <asm/arch-s5l87xx/s5l87xx.h>
+
+struct s5l87xx_buscon {
+	u32 unk[3]; // 0x00, 0x04, 0x08
+	u32 remap;  // 0x0c
+};
+
+enum s5l87xx_buscon_remap {
+	S5L87XX_BUSCON_REMAP_ENABLE = 1,
+	S5L87XX_BUSCON_REMAP_SRAM = 2,
+};
+
+static void s5l87xx_buscon_remap_sdram(void)
+{
+	struct s5l87xx_buscon *buscon = (struct s5l87xx_buscon *)S5L87XX_BUS_BASE;
+
+	writel(S5L87XX_BUSCON_REMAP_ENABLE, &buscon->remap);
+}
diff --git a/arch/arm/mach-s5l87xx/s5l87xx-clk.c b/arch/arm/mach-s5l87xx/s5l87xx-clk.c
new file mode 100644
index 00000000000..13a7453a30a
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l87xx-clk.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include <init.h>
+#include <asm/io.h>
+#include <dm/ofnode.h>
+#include <asm/arch-s5l87xx/s5l87xx.h>
+
+/*
+ * Sentinel for an unused second clock gate in the device-tree
+ * "samsung,clock-gates" property. A real gate is encoded as gate * 32 + bit.
+ */
+#define S5L87XX_CLKGATE_NONE 0xffffffff
+
+void s5l87xx_enable_clkgate_bit(u8 gate, u8 bit)
+{
+	u32 reg = S5L87XX_PWRCON(gate);
+	u32 mask = ~BIT(bit);
+	u32 value = readl(reg);
+
+	value &= mask;
+	writel(value, reg);
+}
+
+static void s5l87xx_ungate_encoded(u32 encoded)
+{
+	if (encoded == S5L87XX_CLKGATE_NONE)
+		return;
+
+	s5l87xx_enable_clkgate_bit(encoded / 32, encoded % 32);
+}
+
+/*
+ * Ungate a clock by name. The name -> {gate, bit} mapping lives in the device
+ * tree under the "samsung,s5l87xx-clkgates" node ("clock-gate-names" paired
+ * with "samsung,clock-gates", two cells per gate). Works pre-relocation: it
+ * reads the flat tree directly, so callers earlier than the FDT setup (e.g.
+ * the debug UART) must use s5l87xx_enable_clkgate_bit() instead.
+ */
+void s5l87xx_enable_clkgate(const char *id)
+{
+	ofnode node = ofnode_by_compatible(ofnode_null(),
+									   "samsung,s5l87xx-clkgates");
+
+	if (!ofnode_valid(node))
+		panic("%s: no clkgates node in device tree", __func__);
+
+	int idx = ofnode_stringlist_search(node, "clock-gate-names", id);
+
+	if (idx < 0)
+		panic("%s: unknown id %s", __func__, id);
+
+	u32 gate1, gate2;
+
+	if (ofnode_read_u32_index(node, "samsung,clock-gates", idx * 2, &gate1))
+		panic("%s: malformed gate1 for %s", __func__, id);
+
+	if (ofnode_read_u32_index(node, "samsung,clock-gates", idx * 2 + 1, &gate2))
+		panic("%s: malformed gate2 for %s", __func__, id);
+
+	log_debug("s5l87xx: ungating %s\n", id);
+	s5l87xx_ungate_encoded(gate1);
+	s5l87xx_ungate_encoded(gate2);
+}
diff --git a/arch/arm/mach-s5l87xx/s5l87xx-otg-phy.c b/arch/arm/mach-s5l87xx/s5l87xx-otg-phy.c
new file mode 100644
index 00000000000..d7553d4ff62
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l87xx-otg-phy.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include <init.h>
+#include <asm/io.h>
+#include <asm/arch-s5l87xx/s5l87xx.h>
+#include <asm/arch-s5l87xx/s5l87xx-clk.h>
+#include <linux/delay.h>
+
+struct s5l87xx_otgphy {
+	u32 pwr;		// 0x00
+	u32 con;		// 0x04
+	u32 rstcon;		// 0x08
+	u32 unk[4];		// 0x0c, 0x10, 0x14, 0x18
+	u32 unkcon;		// 0x1c
+	u32 pad[36];	// 0x20 - 0x44
+	u32 unk44;		// 0x44
+};
+
+void otg_phy_init(void *unused)
+{
+	struct s5l87xx_otgphy *otgphy = (struct s5l87xx_otgphy *)S5L87XX_PHY_BASE;
+
+	log_debug("s5l87xx_otgphy: turning on\n");
+	s5l87xx_enable_clkgate("usb-otg");
+	s5l87xx_enable_clkgate("usb2-phy");
+	mdelay(10);
+
+	// Disable USB suspend.
+	writel(0, S5L87XX_OTG_BASE + 0xe00);
+
+	writel(0, &otgphy->pwr); /* PHY: Power up */
+	mdelay(10);
+	writel(1, &otgphy->rstcon);
+	mdelay(10);
+	writel(0, &otgphy->rstcon);
+	mdelay(10);
+	writel(6, &otgphy->unkcon);
+	writel(1, &otgphy->con);
+	mdelay(400);
+}
+
+void otg_phy_off(void *unused)
+{
+	struct s5l87xx_otgphy *otgphy = (struct s5l87xx_otgphy *)S5L87XX_PHY_BASE;
+
+	log_debug("s5l87xx_otgphy: turning off\n");
+	writel(0xFF, &otgphy->pwr);
+	mdelay(10);
+	writel(0xFF, &otgphy->rstcon);
+	mdelay(10);
+	writel(4, &otgphy->unkcon);
+}
diff --git a/arch/arm/mach-s5l87xx/s5l87xx-timer.c b/arch/arm/mach-s5l87xx/s5l87xx-timer.c
new file mode 100644
index 00000000000..355df62fa88
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l87xx-timer.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include <init.h>
+#include <asm/io.h>
+#include <asm/arch-s5l87xx/s5l87xx.h>
+#include <asm/arch-s5l87xx/s5l87xx-clk.h>
+
+struct s5l87xx_timer {
+	u32 con;	// 0x00
+	u32 cmd;	// 0x04
+	u32 data0;	// 0x08
+	u32 data1;	// 0x0c
+	u32 pre;	// 0x10
+	u32 cnt;	// 0x14
+};
+
+enum s5l87xx_timer_id {
+	//  Timers A, B, C, D: 16-bit
+	S5L87XX_TIMER_A = 0,
+	S5L87XX_TIMER_B = 1,
+	S5L87XX_TIMER_C = 2,
+	S5L87XX_TIMER_D = 3,
+	// Timer E: 64-bit (unimplemented, different registers from others)
+	S5L87XX_TIMER_E = 4,
+	// Timers F, G, H, I: 32-bit
+	S5L87XX_TIMER_F = 5,
+	S5L87XX_TIMER_G = 6,
+	S5L87XX_TIMER_H = 7,
+	S5L87XX_TIMER_I = 8,
+};
+
+#define SYSTEM_TIMER S5L87XX_TIMER_F
+
+enum s5l87xx_timer_cmd {
+	S5L87XX_TIMER_CMD_STOP = 0,
+	S5L87XX_TIMER_CMD_START = 1,
+	S5L87XX_TIMER_CMD_CLR = 2,
+};
+
+static struct s5l87xx_timer *s5l87xx_timer_registers(enum s5l87xx_timer_id id)
+{
+	switch (id) {
+	case S5L87XX_TIMER_A:
+		return (struct s5l87xx_timer *)S5L87XX_TIMER_BASE;
+	case S5L87XX_TIMER_B:
+		return (struct s5l87xx_timer *)(S5L87XX_TIMER_BASE + 0x20);
+	case S5L87XX_TIMER_C:
+		return (struct s5l87xx_timer *)(S5L87XX_TIMER_BASE + 0x40);
+	case S5L87XX_TIMER_D:
+		return (struct s5l87xx_timer *)(S5L87XX_TIMER_BASE + 0x60);
+	case S5L87XX_TIMER_E:
+		return (struct s5l87xx_timer *)(S5L87XX_TIMER_BASE + 0x80);
+	case S5L87XX_TIMER_F:
+		return (struct s5l87xx_timer *)(S5L87XX_TIMER_BASE + 0xa0);
+	case S5L87XX_TIMER_G:
+		return (struct s5l87xx_timer *)(S5L87XX_TIMER_BASE + 0xc0);
+	case S5L87XX_TIMER_H:
+		return (struct s5l87xx_timer *)(S5L87XX_TIMER_BASE + 0xe0);
+	case S5L87XX_TIMER_I:
+		return (struct s5l87xx_timer *)(S5L87XX_TIMER_BASE + 0x100);
+	default:
+		panic("requested invalid timer id %d", id);
+	}
+}
+
+static const char *s5l87xx_timer_clockgate(enum s5l87xx_timer_id id)
+{
+	if (IS_ENABLED(CONFIG_S5L8702))
+		/* S5L8701 and S5L8702 gate all timers behind a single clock gate. */
+		return "timer";
+
+	switch (id) {
+	case S5L87XX_TIMER_A:
+		return "timer0";
+	case S5L87XX_TIMER_B:
+		return "timer1";
+	case S5L87XX_TIMER_C:
+		return "timer2";
+	case S5L87XX_TIMER_D:
+		return "timer3";
+	case S5L87XX_TIMER_E:
+		return "timer4";
+	case S5L87XX_TIMER_F:
+		return "timer5";
+	case S5L87XX_TIMER_G:
+		return "timer6";
+	case S5L87XX_TIMER_H:
+		return "timer7";
+	case S5L87XX_TIMER_I:
+		return "timer8";
+	default:
+		panic("requested invalid timer id %d", id);
+	}
+}
+
+static void s5l87xx_timer_configure_interval(enum s5l87xx_timer_id id)
+{
+	struct s5l87xx_timer *timer = s5l87xx_timer_registers(id);
+
+	log_debug("s5l87xx_timer: configuring %d in interval mode\n", id);
+	s5l87xx_enable_clkgate(s5l87xx_timer_clockgate(id));
+
+	writel(S5L87XX_TIMER_CMD_STOP, &timer->cmd);
+	writel(0x40, &timer->con);
+	writel(0xb, &timer->pre);
+	writel(0xffffffff, &timer->data0);
+	writel(S5L87XX_TIMER_CMD_CLR, &timer->cmd);
+}
+
+static void s5l87xx_timer_start(enum s5l87xx_timer_id id)
+{
+	struct s5l87xx_timer *timer = s5l87xx_timer_registers(id);
+
+	log_debug("s5l87xx_timer: starting %d\n", id);
+	writel(S5L87XX_TIMER_CMD_START, &timer->cmd);
+}
+
+static u32 s5l87xx_timer_read(enum s5l87xx_timer_id id)
+{
+	struct s5l87xx_timer *timer = s5l87xx_timer_registers(id);
+
+	return readl(&timer->cnt);
+}
+
+int timer_init(void)
+{
+	s5l87xx_timer_configure_interval(SYSTEM_TIMER);
+	s5l87xx_timer_start(SYSTEM_TIMER);
+
+	return 0;
+}
+
+unsigned long timer_read_counter(void)
+{
+	return s5l87xx_timer_read(SYSTEM_TIMER);
+}
diff --git a/arch/arm/mach-s5l87xx/s5l87xx.c b/arch/arm/mach-s5l87xx/s5l87xx.c
new file mode 100644
index 00000000000..b9a1c54c13e
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l87xx.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include <init.h>
+#include <asm/io.h>
+#include <asm/arch-s5l87xx/s5l87xx.h>
+
+void reset_cpu(void)
+{
+	svc32_mode_en();
+	// According to S5L8700X datasheet
+	// rSWRCON = 0xA5 triggers a Software Reset
+	// rWDTCON = 0x100000 is not documented but might trigger a Watchdog Reset
+	// writel(0xA5, S5L87XX_SWRCON);
+
+	writel(0x100000, S5L87XX_WDTCON);
+
+	while (1)
+		;	/* loop forever till reset */
+}
diff --git a/board/apple/n20/Kconfig b/board/apple/n20/Kconfig
new file mode 100644
index 00000000000..252baff3c33
--- /dev/null
+++ b/board/apple/n20/Kconfig
@@ -0,0 +1,15 @@
+if TARGET_N20
+
+config SYS_BOARD
+	default "n20"
+
+config SYS_VENDOR
+	default "apple"
+
+config SYS_SOC
+	default "s5l8723"
+
+config SYS_CONFIG_NAME
+	default "apple_n20"
+
+endif
diff --git a/board/apple/n20/Makefile b/board/apple/n20/Makefile
new file mode 100644
index 00000000000..e3353451653
--- /dev/null
+++ b/board/apple/n20/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2026 The freemyipod team (freemyipod.org)
+#
+
+obj-y += ../nxx-common/nxx.o
+obj-y += n20.o
diff --git a/board/apple/n20/n20.c b/board/apple/n20/n20.c
new file mode 100644
index 00000000000..1195ba65812
--- /dev/null
+++ b/board/apple/n20/n20.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include <asm/io.h>
+#include <asm/arch-s5l87xx/s5l87xx.h>
+#include <asm/arch-s5l87xx/s5l87xx-clk.h>
+
+static void board_gpio_init(void)
+{
+	// UART0
+	u32 gpio = readl(S5L87XX_PCON(0));
+
+	gpio &= S5L87XX_PCON_PINS_CLEAR_FN(4, 5);
+	gpio |= S5L87XX_PCON_PINS_SET_FN(4, 5, 0x2);
+	writel(gpio, S5L87XX_PCON(0));
+}
+
+static void board_clock_init(void)
+{
+	s5l87xx_enable_clkgate("uart0");
+	s5l87xx_enable_clkgate("bootrom");
+}
+
+static void board_vic_init(void)
+{
+	// Disable all VIC interrupts.
+	writel(0xffffffff, S5L87XX_VICINTENCLEAR(0));
+	writel(0xffffffff, S5L87XX_VICINTENCLEAR(1));
+}
+
+int board_early_init_f(void)
+{
+	/* Enable GPIO pins */
+	board_gpio_init();
+
+	/* Enable clocking */
+	board_clock_init();
+
+	/* Configure VIC */
+	board_vic_init();
+
+	return 0;
+}
+
+void board_debug_uart_init(void)
+{
+	/* Enable GPIO pins */
+	board_gpio_init();
+
+	/* Enable UART clocking. Runs before the FDT is set up, so ungate uart0 by
+	 * raw {gate, bit} ({1,9} + {4,7}) rather than the device-tree name lookup.
+	 */
+	s5l87xx_enable_clkgate_bit(1, 9);
+	s5l87xx_enable_clkgate_bit(4, 7);
+}
diff --git a/board/apple/n25/Kconfig b/board/apple/n25/Kconfig
new file mode 100644
index 00000000000..cdeac8303aa
--- /dev/null
+++ b/board/apple/n25/Kconfig
@@ -0,0 +1,15 @@
+if TARGET_N25
+
+config SYS_BOARD
+	default "n25"
+
+config SYS_VENDOR
+	default "apple"
+
+config SYS_SOC
+	default "s5l8702"
+
+config SYS_CONFIG_NAME
+	default "apple_n25"
+
+endif
diff --git a/board/apple/n25/Makefile b/board/apple/n25/Makefile
new file mode 100644
index 00000000000..44143c4dc44
--- /dev/null
+++ b/board/apple/n25/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2026 The freemyipod team (freemyipod.org)
+#
+
+obj-y += ../nxx-common/nxx.o
+obj-y += n25.o
diff --git a/board/apple/n25/n25.c b/board/apple/n25/n25.c
new file mode 100644
index 00000000000..c1a94efaab0
--- /dev/null
+++ b/board/apple/n25/n25.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include <asm/io.h>
+#include <asm/arch-s5l87xx/s5l87xx.h>
+#include <asm/arch-s5l87xx/s5l87xx-clk.h>
+
+static void board_gpio_init(void)
+{
+	// UART0
+	u32 gpio = readl(S5L87XX_PCON(0));
+
+	gpio &= S5L87XX_PCON_PINS_CLEAR_FN(4, 5);
+	gpio |= S5L87XX_PCON_PINS_SET_FN(4, 5, 0x2);
+	writel(gpio, S5L87XX_PCON(0));
+}
+
+static void board_clock_init(void)
+{
+	s5l87xx_enable_clkgate("uart0");
+	s5l87xx_enable_clkgate("bootrom");
+}
+
+static void board_vic_init(void)
+{
+	// Disable all VIC interrupts before U-Boot configures them.
+	writel(0xffffffff, S5L87XX_VICINTENCLEAR(0));
+	writel(0xffffffff, S5L87XX_VICINTENCLEAR(1));
+}
+
+int board_early_init_f(void)
+{
+	board_gpio_init();
+	board_clock_init();
+	board_vic_init();
+
+	return 0;
+}
+
+void board_debug_uart_init(void)
+{
+	board_gpio_init();
+
+	// Runs before the FDT is set up, so ungate uart0 by raw {gate, bit}
+	// ({1,9} + {4,7}) rather than the device-tree-driven name lookup.
+	s5l87xx_enable_clkgate_bit(1, 9);
+	s5l87xx_enable_clkgate_bit(4, 7);
+}
diff --git a/board/apple/n31/Kconfig b/board/apple/n31/Kconfig
new file mode 100644
index 00000000000..4b26a9f22f3
--- /dev/null
+++ b/board/apple/n31/Kconfig
@@ -0,0 +1,15 @@
+if TARGET_N31
+
+config SYS_BOARD
+	default "n31"
+
+config SYS_VENDOR
+	default "apple"
+
+config SYS_SOC
+	default "s5l8740"
+
+config SYS_CONFIG_NAME
+	default "apple_n31"
+
+endif
diff --git a/board/apple/n31/Makefile b/board/apple/n31/Makefile
new file mode 100644
index 00000000000..78c1f982c88
--- /dev/null
+++ b/board/apple/n31/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2026 The freemyipod team (freemyipod.org)
+#
+
+obj-y += ../nxx-common/nxx.o
+obj-y += n31.o
diff --git a/board/apple/n31/n31.c b/board/apple/n31/n31.c
new file mode 100644
index 00000000000..2375d052c1c
--- /dev/null
+++ b/board/apple/n31/n31.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include <asm/io.h>
+#include <asm/arch-s5l87xx/s5l87xx.h>
+#include <asm/arch-s5l87xx/s5l87xx-clk.h>
+
+static void board_gpio_init(void)
+{
+	u32 value;
+
+	// UART0: pad 0, rx pin 4, tx pin 5, fn 2
+	value = readl(S5L87XX_PCON(0));
+	value &= S5L87XX_PCON_PINS_CLEAR_FN(4, 5);
+	value |= S5L87XX_PCON_PINS_SET_FN(4, 5, 0x2);
+	writel(value, S5L87XX_PCON(0));
+
+	value = readl(S5L87XX_PPIE(0));
+	value |= BIT(4) | BIT(5);
+	writel(value, S5L87XX_PPIE(0));
+
+	// UART1: pad 9, rx pin 6, tx pin 7, fn 2
+	value = readl(S5L87XX_PCON(9));
+	value &= S5L87XX_PCON_PINS_CLEAR_FN(6, 7);
+	value |= S5L87XX_PCON_PINS_SET_FN(6, 7, 0x2);
+	writel(value, S5L87XX_PCON(9));
+
+	value = readl(S5L87XX_PPIE(9));
+	value |= BIT(6) | BIT(7);
+	writel(value, S5L87XX_PPIE(9));
+
+	// UART2: pad 8, rx pin 2, tx pin 3, fn 2
+	value = readl(S5L87XX_PCON(10));
+	value &= S5L87XX_PCON_PINS_CLEAR_FN(2, 3);
+	value |= S5L87XX_PCON_PINS_SET_FN(2, 3, 0x2);
+	writel(value, S5L87XX_PCON(10));
+
+	value = readl(S5L87XX_PPIE(10));
+	value |= BIT(2) | BIT(3);
+	writel(value, S5L87XX_PPIE(10));
+
+	// UART3: pad 10, rx pin 3, tx pin 4, fn 2
+	value = readl(S5L87XX_PCON(10));
+	value &= S5L87XX_PCON_PINS_CLEAR_FN(3, 4);
+	value |= S5L87XX_PCON_PINS_SET_FN(3, 4, 0x2);
+	writel(value, S5L87XX_PCON(10));
+
+	value = readl(S5L87XX_PPIE(10));
+	value |= BIT(3) | BIT(4);
+	writel(value, S5L87XX_PPIE(10));
+}
+
+static void board_clock_init(void)
+{
+	s5l87xx_enable_clkgate("uart0");
+	s5l87xx_enable_clkgate("uart1");
+	s5l87xx_enable_clkgate("uart2");
+	s5l87xx_enable_clkgate("uart3");
+	s5l87xx_enable_clkgate("bootrom");
+}
+
+int board_early_init_f(void)
+{
+	/* Configure UART TX & RX line GPIO */
+	board_gpio_init();
+
+	/* Enable UART clocking */
+	board_clock_init();
+
+	return 0;
+}
+
+void board_debug_uart_init(void)
+{
+	/* Configure UART TX & RX line GPIO */
+	board_gpio_init();
+
+	/* Enable UART clocking. Runs before the FDT is set up */
+	// UART0
+	s5l87xx_enable_clkgate_bit(1, 9);
+	s5l87xx_enable_clkgate_bit(4, 7);
+
+	// UART1
+	s5l87xx_enable_clkgate_bit(1, 29);
+	s5l87xx_enable_clkgate_bit(4, 8);
+
+	// UART2
+	s5l87xx_enable_clkgate_bit(1, 30);
+	s5l87xx_enable_clkgate_bit(4, 9);
+
+	// UART3
+	s5l87xx_enable_clkgate_bit(1, 31);
+	s5l87xx_enable_clkgate_bit(4, 10);
+}
diff --git a/board/apple/n33/Kconfig b/board/apple/n33/Kconfig
new file mode 100644
index 00000000000..5c9dea9fbb9
--- /dev/null
+++ b/board/apple/n33/Kconfig
@@ -0,0 +1,15 @@
+if TARGET_N33
+
+config SYS_BOARD
+	default "n33"
+
+config SYS_VENDOR
+	default "apple"
+
+config SYS_SOC
+	default "s5l8730"
+
+config SYS_CONFIG_NAME
+	default "apple_n33"
+
+endif
diff --git a/board/apple/n33/Makefile b/board/apple/n33/Makefile
new file mode 100644
index 00000000000..721718361e1
--- /dev/null
+++ b/board/apple/n33/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2026 The freemyipod team (freemyipod.org)
+#
+
+obj-y += ../nxx-common/nxx.o
+obj-y += n33.o
diff --git a/board/apple/n33/n33.c b/board/apple/n33/n33.c
new file mode 100644
index 00000000000..1195ba65812
--- /dev/null
+++ b/board/apple/n33/n33.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include <asm/io.h>
+#include <asm/arch-s5l87xx/s5l87xx.h>
+#include <asm/arch-s5l87xx/s5l87xx-clk.h>
+
+static void board_gpio_init(void)
+{
+	// UART0
+	u32 gpio = readl(S5L87XX_PCON(0));
+
+	gpio &= S5L87XX_PCON_PINS_CLEAR_FN(4, 5);
+	gpio |= S5L87XX_PCON_PINS_SET_FN(4, 5, 0x2);
+	writel(gpio, S5L87XX_PCON(0));
+}
+
+static void board_clock_init(void)
+{
+	s5l87xx_enable_clkgate("uart0");
+	s5l87xx_enable_clkgate("bootrom");
+}
+
+static void board_vic_init(void)
+{
+	// Disable all VIC interrupts.
+	writel(0xffffffff, S5L87XX_VICINTENCLEAR(0));
+	writel(0xffffffff, S5L87XX_VICINTENCLEAR(1));
+}
+
+int board_early_init_f(void)
+{
+	/* Enable GPIO pins */
+	board_gpio_init();
+
+	/* Enable clocking */
+	board_clock_init();
+
+	/* Configure VIC */
+	board_vic_init();
+
+	return 0;
+}
+
+void board_debug_uart_init(void)
+{
+	/* Enable GPIO pins */
+	board_gpio_init();
+
+	/* Enable UART clocking. Runs before the FDT is set up, so ungate uart0 by
+	 * raw {gate, bit} ({1,9} + {4,7}) rather than the device-tree name lookup.
+	 */
+	s5l87xx_enable_clkgate_bit(1, 9);
+	s5l87xx_enable_clkgate_bit(4, 7);
+}
diff --git a/board/apple/n36/Kconfig b/board/apple/n36/Kconfig
new file mode 100644
index 00000000000..19190eddbc1
--- /dev/null
+++ b/board/apple/n36/Kconfig
@@ -0,0 +1,15 @@
+if TARGET_N36
+
+config SYS_BOARD
+	default "n36"
+
+config SYS_VENDOR
+	default "apple"
+
+config SYS_SOC
+	default "s5l8701"
+
+config SYS_CONFIG_NAME
+	default "apple_n36"
+
+endif
diff --git a/board/apple/n36/Makefile b/board/apple/n36/Makefile
new file mode 100644
index 00000000000..a8fde44f930
--- /dev/null
+++ b/board/apple/n36/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2026 The freemyipod team (freemyipod.org)
+#
+
+obj-y += ../nxx-common/nxx.o
+obj-y += n36.o
diff --git a/board/apple/n36/n36.c b/board/apple/n36/n36.c
new file mode 100644
index 00000000000..3969f22bfb3
--- /dev/null
+++ b/board/apple/n36/n36.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include <asm/arch-s5l87xx/s5l87xx-clk.h>
+
+static void board_clock_init(void)
+{
+	s5l87xx_enable_clkgate("uart");
+}
+
+int board_early_init_f(void)
+{
+	/* enabling UART clocking */
+	board_clock_init();
+
+	return 0;
+}
diff --git a/board/apple/n46/Kconfig b/board/apple/n46/Kconfig
new file mode 100644
index 00000000000..efbb15d14cc
--- /dev/null
+++ b/board/apple/n46/Kconfig
@@ -0,0 +1,15 @@
+if TARGET_N46
+
+config SYS_BOARD
+	default "n46"
+
+config SYS_VENDOR
+	default "apple"
+
+config SYS_SOC
+	default "s5l8702"
+
+config SYS_CONFIG_NAME
+	default "apple_n46"
+
+endif
diff --git a/board/apple/n46/Makefile b/board/apple/n46/Makefile
new file mode 100644
index 00000000000..ccc6abd8067
--- /dev/null
+++ b/board/apple/n46/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2026 The freemyipod team (freemyipod.org)
+#
+
+obj-y += ../nxx-common/nxx.o
+obj-y += n46.o
diff --git a/board/apple/n46/n46.c b/board/apple/n46/n46.c
new file mode 100644
index 00000000000..b1dcbc01f0d
--- /dev/null
+++ b/board/apple/n46/n46.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include <asm/io.h>
+#include <asm/arch-s5l87xx/s5l87xx.h>
+#include <asm/arch-s5l87xx/s5l87xx-clk.h>
+
+static void board_gpio_init(void)
+{
+	// UART0
+	u32 gpio = readl(S5L87XX_PCON(0));
+
+	gpio &= S5L87XX_PCON_PINS_CLEAR_FN(4, 5);
+	gpio |= S5L87XX_PCON_PINS_SET_FN(4, 5, 0x2);
+	writel(gpio, S5L87XX_PCON(0));
+}
+
+static void board_clock_init(void)
+{
+	s5l87xx_enable_clkgate("uart0");
+	s5l87xx_enable_clkgate("bootrom");
+}
+
+static void board_vic_init(void)
+{
+	// Disable all VIC interrupts before U-Boot configures them.
+	writel(0xffffffff, S5L87XX_VICINTENCLEAR(0));
+	writel(0xffffffff, S5L87XX_VICINTENCLEAR(1));
+}
+
+int board_early_init_f(void)
+{
+	board_gpio_init();
+	board_clock_init();
+	board_vic_init();
+
+	return 0;
+}
+
+void board_debug_uart_init(void)
+{
+	/* Enable GPIO pins */
+	board_gpio_init();
+
+	// Runs before the FDT is set up, so ungate uart0 by raw {gate, bit}
+	// ({1,9} + {4,7}) rather than the device-tree-driven name lookup.
+	s5l87xx_enable_clkgate_bit(1, 9);
+	s5l87xx_enable_clkgate_bit(4, 7);
+}
diff --git a/board/apple/n58s/Kconfig b/board/apple/n58s/Kconfig
new file mode 100644
index 00000000000..6a61a9973d9
--- /dev/null
+++ b/board/apple/n58s/Kconfig
@@ -0,0 +1,15 @@
+if TARGET_N58S
+
+config SYS_BOARD
+	default "n58s"
+
+config SYS_VENDOR
+	default "apple"
+
+config SYS_SOC
+	default "s5l8720"
+
+config SYS_CONFIG_NAME
+	default "apple_n58s"
+
+endif
diff --git a/board/apple/n58s/Makefile b/board/apple/n58s/Makefile
new file mode 100644
index 00000000000..293c92895e3
--- /dev/null
+++ b/board/apple/n58s/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2026 The freemyipod team (freemyipod.org)
+#
+
+obj-y += ../nxx-common/nxx.o
+obj-y += n58s.o
diff --git a/board/apple/n58s/n58s.c b/board/apple/n58s/n58s.c
new file mode 100644
index 00000000000..1195ba65812
--- /dev/null
+++ b/board/apple/n58s/n58s.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include <asm/io.h>
+#include <asm/arch-s5l87xx/s5l87xx.h>
+#include <asm/arch-s5l87xx/s5l87xx-clk.h>
+
+static void board_gpio_init(void)
+{
+	// UART0
+	u32 gpio = readl(S5L87XX_PCON(0));
+
+	gpio &= S5L87XX_PCON_PINS_CLEAR_FN(4, 5);
+	gpio |= S5L87XX_PCON_PINS_SET_FN(4, 5, 0x2);
+	writel(gpio, S5L87XX_PCON(0));
+}
+
+static void board_clock_init(void)
+{
+	s5l87xx_enable_clkgate("uart0");
+	s5l87xx_enable_clkgate("bootrom");
+}
+
+static void board_vic_init(void)
+{
+	// Disable all VIC interrupts.
+	writel(0xffffffff, S5L87XX_VICINTENCLEAR(0));
+	writel(0xffffffff, S5L87XX_VICINTENCLEAR(1));
+}
+
+int board_early_init_f(void)
+{
+	/* Enable GPIO pins */
+	board_gpio_init();
+
+	/* Enable clocking */
+	board_clock_init();
+
+	/* Configure VIC */
+	board_vic_init();
+
+	return 0;
+}
+
+void board_debug_uart_init(void)
+{
+	/* Enable GPIO pins */
+	board_gpio_init();
+
+	/* Enable UART clocking. Runs before the FDT is set up, so ungate uart0 by
+	 * raw {gate, bit} ({1,9} + {4,7}) rather than the device-tree name lookup.
+	 */
+	s5l87xx_enable_clkgate_bit(1, 9);
+	s5l87xx_enable_clkgate_bit(4, 7);
+}
diff --git a/board/apple/nxx-common/nxx.c b/board/apple/nxx-common/nxx.c
new file mode 100644
index 00000000000..85db9ed3589
--- /dev/null
+++ b/board/apple/nxx-common/nxx.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include <fdtdec.h>
+#include <env.h>
+#include <asm/global_data.h>
+#include <linux/sizes.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int dram_init(void)
+{
+	return fdtdec_setup_mem_size_base();
+}
+
+int dram_init_banksize(void)
+{
+	return fdtdec_setup_memory_banksize();
+}
+
+int board_init(void)
+{
+	return 0;
+}
+
+void set_dfu_alt_info(char *interface, char *devstr)
+{
+	char buf[96];
+	ulong start;
+	ulong size;
+
+	if (!env_get("dfu_alt_info")) {
+		/* don't touch the upper 4M, U-boot is relocated there
+		 * use upper half of the remaining space for loading
+		 * and the lower for booting the payload, e.g. Linux
+		 */
+		size = (gd->ram_size - SZ_4M) / 2;
+		start = gd->ram_base + size;
+		snprintf(buf, sizeof(buf), "firmware ram 0x%08lx 0x%08lx;"
+				 "bootrom ram 0x20000000 0xc800", start, size);
+		env_set("dfu_alt_info", buf);
+
+		env_set_hex("loadaddr", start);
+	}
+}
diff --git a/configs/apple_n20_defconfig b/configs/apple_n20_defconfig
new file mode 100644
index 00000000000..79ca75bb7b7
--- /dev/null
+++ b/configs/apple_n20_defconfig
@@ -0,0 +1,35 @@
+CONFIG_ARM=y
+CONFIG_ARCH_S5L87XX=y
+CONFIG_S5L8723=y
+CONFIG_TARGET_N20=y
+CONFIG_DEFAULT_DEVICE_TREE="s5l8723-n20"
+CONFIG_STACK_SIZE=0x00100000
+CONFIG_TEXT_BASE=0x08000000
+CONFIG_SYS_LOAD_ADDR=0x08000000
+CONFIG_SYS_MALLOC_LEN=0x00200000
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x00100000
+CONFIG_SET_DFU_ALT_INFO=y
+CONFIG_BOARD_EARLY_INIT_F=y
+CONFIG_OF_CONTROL=y
+CONFIG_CLK=y
+CONFIG_USB=y
+CONFIG_USB_GADGET=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x05ac
+CONFIG_USB_GADGET_PRODUCT_NUM=0xff00
+CONFIG_CMD_DFU=y
+CONFIG_DFU_RAM=y
+CONFIG_FIT=y
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="dfu 0 ram 0; bootm"
+CONFIG_BOOTDELAY=3
+CONFIG_POSITION_INDEPENDENT=y
+
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_S5P=y
+CONFIG_DEBUG_UART_BASE=0x3CC00000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_DEBUG_UART_BOARD_INIT=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
diff --git a/configs/apple_n25_defconfig b/configs/apple_n25_defconfig
new file mode 100644
index 00000000000..e794d8bca3d
--- /dev/null
+++ b/configs/apple_n25_defconfig
@@ -0,0 +1,42 @@
+CONFIG_ARM=y
+CONFIG_ARCH_S5L87XX=y
+CONFIG_S5L8702=y
+CONFIG_TARGET_N25=y
+CONFIG_DEFAULT_DEVICE_TREE="s5l8702-n25"
+CONFIG_STACK_SIZE=0x00100000
+CONFIG_TEXT_BASE=0x08000800
+CONFIG_SYS_LOAD_ADDR=0x08000000
+CONFIG_SYS_MALLOC_LEN=0x00200000
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x00100000
+CONFIG_SET_DFU_ALT_INFO=y
+CONFIG_SKIP_LOWLEVEL_INIT_ONLY=y
+CONFIG_BOARD_EARLY_INIT_F=y
+CONFIG_OF_CONTROL=y
+CONFIG_CLK=y
+CONFIG_USB=y
+CONFIG_USB_GADGET=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x05ac
+CONFIG_USB_GADGET_PRODUCT_NUM=0xff00
+CONFIG_CMD_DFU=y
+CONFIG_DFU_RAM=y
+CONFIG_FIT=y
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="dfu 0 ram 0; bootm"
+CONFIG_BOOTDELAY=3
+CONFIG_POSITION_INDEPENDENT=y
+
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_S5P=y
+CONFIG_DEBUG_UART_BASE=0x3CC00000
+CONFIG_DEBUG_UART_CLOCK=12000000
+CONFIG_DEBUG_UART_BOARD_INIT=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_BAUDRATE=57600
+
+CONFIG_SUPPORT_PASSING_ATAGS=y
+CONFIG_SETUP_MEMORY_TAGS=y
+CONFIG_CMDLINE_TAG=y
+CONFIG_USE_PREBOOT=y
diff --git a/configs/apple_n31_defconfig b/configs/apple_n31_defconfig
new file mode 100644
index 00000000000..ac9b2e76482
--- /dev/null
+++ b/configs/apple_n31_defconfig
@@ -0,0 +1,41 @@
+CONFIG_ARM=y
+CONFIG_ARCH_S5L87XX=y
+CONFIG_S5L8740=y
+CONFIG_TARGET_N31=y
+CONFIG_DEFAULT_DEVICE_TREE="s5l8740-n31"
+CONFIG_STACK_SIZE=0x00100000
+CONFIG_TEXT_BASE=0x08000000
+CONFIG_SYS_LOAD_ADDR=0x08000000
+CONFIG_SYS_MALLOC_LEN=0x00200000
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x00100000
+CONFIG_SET_DFU_ALT_INFO=y
+CONFIG_BOARD_EARLY_INIT_F=y
+CONFIG_OF_CONTROL=y
+CONFIG_CLK=y
+CONFIG_USB=y
+CONFIG_USB_GADGET=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x05ac
+CONFIG_USB_GADGET_PRODUCT_NUM=0xff00
+CONFIG_CMD_DFU=y
+CONFIG_DFU_RAM=y
+CONFIG_FIT=y
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="dfu 0 ram 0; bootm"
+CONFIG_BOOTDELAY=3
+
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_S5P=y
+CONFIG_DEBUG_UART_BASE=0x3DD00000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_DEBUG_UART_BOARD_INIT=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+
+# CONFIG_LOG=y
+# CONFIG_LOGF_LINE=y
+# CONFIG_LOGF_FUNC=y
+# CONFIG_LOGLEVEL=8
+# CONFIG_LOG_MAX_LEVEL=8
+# CONFIG_LOG_CONSOLE=y
diff --git a/configs/apple_n33_defconfig b/configs/apple_n33_defconfig
new file mode 100644
index 00000000000..43eb1c30368
--- /dev/null
+++ b/configs/apple_n33_defconfig
@@ -0,0 +1,35 @@
+CONFIG_ARM=y
+CONFIG_ARCH_S5L87XX=y
+CONFIG_S5L8730=y
+CONFIG_TARGET_N33=y
+CONFIG_DEFAULT_DEVICE_TREE="s5l8730-n33"
+CONFIG_STACK_SIZE=0x00100000
+CONFIG_TEXT_BASE=0x08000000
+CONFIG_SYS_LOAD_ADDR=0x08000000
+CONFIG_SYS_MALLOC_LEN=0x00200000
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x00100000
+CONFIG_SET_DFU_ALT_INFO=y
+CONFIG_BOARD_EARLY_INIT_F=y
+CONFIG_OF_CONTROL=y
+CONFIG_CLK=y
+CONFIG_USB=y
+CONFIG_USB_GADGET=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x05ac
+CONFIG_USB_GADGET_PRODUCT_NUM=0xff00
+CONFIG_CMD_DFU=y
+CONFIG_DFU_RAM=y
+CONFIG_FIT=y
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="dfu 0 ram 0; bootm"
+CONFIG_BOOTDELAY=3
+CONFIG_POSITION_INDEPENDENT=y
+
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_S5P=y
+CONFIG_DEBUG_UART_BASE=0x3CC00000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_DEBUG_UART_BOARD_INIT=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
diff --git a/configs/apple_n36_defconfig b/configs/apple_n36_defconfig
new file mode 100644
index 00000000000..1a58528310a
--- /dev/null
+++ b/configs/apple_n36_defconfig
@@ -0,0 +1,35 @@
+CONFIG_ARM=y
+CONFIG_ARCH_S5L87XX=y
+CONFIG_S5L8701=y
+CONFIG_TARGET_N36=y
+CONFIG_DEFAULT_DEVICE_TREE="s5l8701-n36"
+CONFIG_STACK_SIZE=0x00100000
+CONFIG_TEXT_BASE=0x08000000
+CONFIG_SYS_LOAD_ADDR=0x08000000
+CONFIG_SYS_MALLOC_LEN=0x00200000
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x00100000
+CONFIG_SET_DFU_ALT_INFO=y
+CONFIG_SKIP_LOWLEVEL_INIT_ONLY=y
+CONFIG_BOARD_EARLY_INIT_F=y
+CONFIG_OF_CONTROL=y
+CONFIG_CLK=y
+CONFIG_USB=y
+CONFIG_USB_GADGET=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x05ac
+CONFIG_USB_GADGET_PRODUCT_NUM=0xff00
+CONFIG_CMD_DFU=y
+CONFIG_DFU_RAM=y
+CONFIG_FIT=y
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="dfu 0 ram 0; bootm"
+CONFIG_BOOTDELAY=3
+CONFIG_POSITION_INDEPENDENT=y
+
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_S5P=y
+CONFIG_DEBUG_UART_BASE=0x3CC00000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_DEBUG_UART_ANNOUNCE=y
diff --git a/configs/apple_n46_defconfig b/configs/apple_n46_defconfig
new file mode 100644
index 00000000000..34d37716e11
--- /dev/null
+++ b/configs/apple_n46_defconfig
@@ -0,0 +1,42 @@
+CONFIG_ARM=y
+CONFIG_ARCH_S5L87XX=y
+CONFIG_S5L8702=y
+CONFIG_TARGET_N46=y
+CONFIG_DEFAULT_DEVICE_TREE="s5l8702-n46"
+CONFIG_STACK_SIZE=0x00100000
+CONFIG_TEXT_BASE=0x08000800
+CONFIG_SYS_LOAD_ADDR=0x08000000
+CONFIG_SYS_MALLOC_LEN=0x00200000
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x00100000
+CONFIG_SET_DFU_ALT_INFO=y
+CONFIG_SKIP_LOWLEVEL_INIT_ONLY=y
+CONFIG_BOARD_EARLY_INIT_F=y
+CONFIG_OF_CONTROL=y
+CONFIG_CLK=y
+CONFIG_USB=y
+CONFIG_USB_GADGET=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x05ac
+CONFIG_USB_GADGET_PRODUCT_NUM=0xff00
+CONFIG_CMD_DFU=y
+CONFIG_DFU_RAM=y
+CONFIG_FIT=y
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="dfu 0 ram 0; bootm"
+CONFIG_BOOTDELAY=3
+CONFIG_POSITION_INDEPENDENT=y
+
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_S5P=y
+CONFIG_DEBUG_UART_BASE=0x3CC00000
+CONFIG_DEBUG_UART_CLOCK=12000000
+CONFIG_DEBUG_UART_BOARD_INIT=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_BAUDRATE=57600
+
+CONFIG_SUPPORT_PASSING_ATAGS=y
+CONFIG_SETUP_MEMORY_TAGS=y
+CONFIG_CMDLINE_TAG=y
+CONFIG_USE_PREBOOT=y
diff --git a/configs/apple_n58s_defconfig b/configs/apple_n58s_defconfig
new file mode 100644
index 00000000000..98005787a38
--- /dev/null
+++ b/configs/apple_n58s_defconfig
@@ -0,0 +1,35 @@
+CONFIG_ARM=y
+CONFIG_ARCH_S5L87XX=y
+CONFIG_S5L8720=y
+CONFIG_TARGET_N58S=y
+CONFIG_DEFAULT_DEVICE_TREE="s5l8720-n58s"
+CONFIG_STACK_SIZE=0x00100000
+CONFIG_TEXT_BASE=0x08000000
+CONFIG_SYS_LOAD_ADDR=0x08000000
+CONFIG_SYS_MALLOC_LEN=0x00200000
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x00100000
+CONFIG_SET_DFU_ALT_INFO=y
+CONFIG_BOARD_EARLY_INIT_F=y
+CONFIG_OF_CONTROL=y
+CONFIG_CLK=y
+CONFIG_USB=y
+CONFIG_USB_GADGET=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x05ac
+CONFIG_USB_GADGET_PRODUCT_NUM=0xff00
+CONFIG_CMD_DFU=y
+CONFIG_DFU_RAM=y
+CONFIG_FIT=y
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="dfu 0 ram 0; bootm"
+CONFIG_BOOTDELAY=3
+CONFIG_POSITION_INDEPENDENT=y
+
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_S5P=y
+CONFIG_DEBUG_UART_BASE=0x3CC00000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_DEBUG_UART_BOARD_INIT=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index ffc58d663ff..879eec9a41e 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -321,7 +321,7 @@ config DEBUG_SBI_CONSOLE
 
 config DEBUG_UART_S5P
 	bool "Samsung S5P"
-	depends on ARCH_APPLE || ARCH_EXYNOS || ARCH_S5PC1XX
+	depends on ARCH_APPLE || ARCH_EXYNOS || ARCH_S5PC1XX || ARCH_S5L87XX
 	help
 	  Select this to enable a debug UART using the serial_s5p driver. You
 	  will need to provide parameters to make this work. The driver will
@@ -896,7 +896,7 @@ config ROCKCHIP_SERIAL
 
 config S5P_SERIAL
 	bool "Support for Samsung S5P UART"
-	depends on ARCH_APPLE || ARCH_EXYNOS || ARCH_S5PC1XX
+	depends on ARCH_APPLE || ARCH_EXYNOS || ARCH_S5PC1XX || ARCH_S5L87XX
 	default y
 	help
 	  Select this to enable Samsung S5P UART support.
diff --git a/drivers/serial/serial_s5p.c b/drivers/serial/serial_s5p.c
index d46a88610ab..d6d93a5c6e7 100644
--- a/drivers/serial/serial_s5p.c
+++ b/drivers/serial/serial_s5p.c
@@ -13,7 +13,7 @@
 #include <asm/global_data.h>
 #include <linux/compiler.h>
 #include <asm/io.h>
-#if !IS_ENABLED(CONFIG_ARCH_APPLE)
+#if !IS_ENABLED(CONFIG_ARCH_APPLE) && !IS_ENABLED(CONFIG_ARCH_S5L87XX)
 #include <asm/arch/clk.h>
 #endif
 #include <asm/arch/uart.h>
@@ -40,6 +40,7 @@ enum {
 #define S5L_TX_FIFO_COUNT_SHIFT	4
 #define S5L_TX_FIFO_COUNT_MASK	(0xf << S5L_TX_FIFO_COUNT_SHIFT)
 #define S5L_TX_FIFO_FULL	BIT(9)
+#define S5L_CLK_NCLK		BIT(10)
 
 #define S5P_RX_FIFO_COUNT_SHIFT	0
 #define S5P_RX_FIFO_COUNT_MASK	(0xff << S5P_RX_FIFO_COUNT_SHIFT)
@@ -61,6 +62,7 @@ struct s5p_serial_plat {
 	u32 tx_fifo_full;
 };
 
+#if !IS_ENABLED(CONFIG_ARCH_S5L87XX)
 /*
  * The coefficient, used to calculate the baudrate on S5P UARTs is
  * calculated as
@@ -86,6 +88,7 @@ static const int udivslot[] = {
 	0xdfdf,
 	0xffdf,
 };
+#endif
 
 static void __maybe_unused s5p_serial_init(struct s5p_uart *uart)
 {
@@ -98,6 +101,14 @@ static void __maybe_unused s5p_serial_init(struct s5p_uart *uart)
 	/* No interrupts, no DMA, pure polling */
 	writel(UCON_RX_IRQ_OR_POLLING | UCON_TX_IRQ_OR_POLLING |
 	       UCON_RX_ERR_IRQ_EN | UCON_TX_IRQ_LEVEL, &uart->ucon);
+
+	if (IS_ENABLED(CONFIG_ARCH_S5L87XX)) {
+		u32 val;
+
+		val = readl(&uart->ucon);
+		val |= S5L_CLK_NCLK;
+		writel(val, &uart->ucon);
+	}
 }
 
 static void __maybe_unused s5p_serial_baud(struct s5p_uart *uart, u8 reg_width,
@@ -109,12 +120,14 @@ static void __maybe_unused s5p_serial_baud(struct s5p_uart *uart, u8 reg_width,
 
 	writel(val / 16 - 1, &uart->ubrdiv);
 
+#if !IS_ENABLED(CONFIG_ARCH_S5L87XX)
 	if (s5p_uart_divslot())
 		writew(udivslot[val % 16], &uart->rest.slot);
 	else if (reg_width == 4)
 		writel(val % 16, &uart->rest.value);
 	else
 		writeb(val % 16, &uart->rest.value);
+#endif
 }
 
 #ifndef CONFIG_XPL_BUILD
@@ -124,7 +137,8 @@ int s5p_serial_setbrg(struct udevice *dev, int baudrate)
 	struct s5p_uart *const uart = plat->reg;
 	u32 uclk;
 
-#if IS_ENABLED(CONFIG_CLK_EXYNOS) || IS_ENABLED(CONFIG_ARCH_APPLE)
+#if IS_ENABLED(CONFIG_CLK_EXYNOS) || IS_ENABLED(CONFIG_ARCH_APPLE) || \
+	IS_ENABLED(CONFIG_ARCH_S5L87XX)
 	struct clk clk;
 	int ret;
 
@@ -286,26 +300,25 @@ static inline void _debug_uart_init(void)
 	struct s5p_uart *uart = (struct s5p_uart *)CONFIG_VAL(DEBUG_UART_BASE);
 
 	s5p_serial_init(uart);
-#if IS_ENABLED(CONFIG_ARCH_APPLE)
-	s5p_serial_baud(uart, 4, CONFIG_DEBUG_UART_CLOCK, CONFIG_BAUDRATE);
-#else
-	s5p_serial_baud(uart, 1, CONFIG_DEBUG_UART_CLOCK, CONFIG_BAUDRATE);
-#endif
+	if (IS_ENABLED(CONFIG_ARCH_APPLE) || IS_ENABLED(CONFIG_ARCH_S5L87XX))
+		s5p_serial_baud(uart, 4, CONFIG_DEBUG_UART_CLOCK, CONFIG_BAUDRATE);
+	else
+		s5p_serial_baud(uart, 1, CONFIG_DEBUG_UART_CLOCK, CONFIG_BAUDRATE);
 }
 
 static inline void _debug_uart_putc(int ch)
 {
 	struct s5p_uart *uart = (struct s5p_uart *)CONFIG_VAL(DEBUG_UART_BASE);
 
-#if IS_ENABLED(CONFIG_ARCH_APPLE)
-	while (readl(&uart->ufstat) & S5L_TX_FIFO_FULL)
-		;
-	writel(ch, &uart->utxh);
-#else
-	while (readl(&uart->ufstat) & S5P_TX_FIFO_FULL)
-		;
-	writeb(ch, &uart->utxh);
-#endif
+	if (IS_ENABLED(CONFIG_ARCH_APPLE) || IS_ENABLED(CONFIG_ARCH_S5L87XX)) {
+		while (readl(&uart->ufstat) & S5L_TX_FIFO_FULL)
+			;
+		writel(ch, &uart->utxh);
+	} else {
+		while (readl(&uart->ufstat) & S5P_TX_FIFO_FULL)
+			;
+		writeb(ch, &uart->utxh);
+	}
 }
 
 DEBUG_UART_FUNCS
diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_udc_otg.c
index 570fed347c9..5c6c4017b11 100644
--- a/drivers/usb/gadget/dwc2_udc_otg.c
+++ b/drivers/usb/gadget/dwc2_udc_otg.c
@@ -287,6 +287,14 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 
 	enable_irq(IRQ_OTG);
 
+	if (IS_ENABLED(CONFIG_S5L8701)) {
+		u32 value;
+
+		value = readl(S5L87XX_INTMSK);
+		value |= 1 << IRQ_USB_FUNC;
+		writel(value, S5L87XX_INTMSK);
+	}
+
 	debug_cond(DEBUG_SETUP != 0,
 		   "Registered gadget driver %s\n", dev->gadget.name);
 	udc_enable(dev);
@@ -316,6 +324,14 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
 
 	disable_irq(IRQ_OTG);
 
+	if (IS_ENABLED(CONFIG_S5L8701)) {
+		u32 value;
+
+		value = readl(S5L87XX_INTMSK);
+		value &= ~(1 << IRQ_USB_FUNC);
+		writel(value, S5L87XX_INTMSK);
+	}
+
 	udc_disable(dev);
 	return 0;
 }
@@ -1042,6 +1058,17 @@ static void dwc2_set_stm32mp1_hsotg_params(struct dwc2_plat_otg_data *p)
 		p->usb_gusbcfg |= 1 << 30; /* FDMOD: Force device mode */
 }
 
+static void dwc2_set_s5l87xx_hsotg_params(struct dwc2_plat_otg_data *p)
+{
+	p->usb_gusbcfg =
+		0 << 15		/* PHY Low Power Clock sel*/
+		| 0x5 << 10	/* USB Turnaround time (5) */
+		| 1 << 9	/* [1:HNP enable]*/
+		| 1 << 8	/* [1:SRP enable]*/
+		| 0 << 6	/* 0: high speed utmi+, 1: full speed serial*/
+		| 1 << 3;	/* phy i/f  0:8bit, 1:16bit*/
+}
+
 static int dwc2_udc_otg_reset_init(struct udevice *dev,
 				   struct reset_ctl_bulk *resets)
 {
@@ -1201,6 +1228,8 @@ static const struct udevice_id dwc2_udc_otg_ids[] = {
 	{ .compatible = "brcm,bcm2835-usb" },
 	{ .compatible = "st,stm32mp15-hsotg",
 	  .data = (ulong)dwc2_set_stm32mp1_hsotg_params },
+	{ .compatible = "apple,s5l87xx-usb",
+	  .data = (ulong)dwc2_set_s5l87xx_hsotg_params },
 	{},
 };
 
diff --git a/include/configs/apple_n20.h b/include/configs/apple_n20.h
new file mode 100644
index 00000000000..7cb68073fcd
--- /dev/null
+++ b/include/configs/apple_n20.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#define CFG_SYS_UBOOT_BASE		CONFIG_TEXT_BASE
+
+// 192K SRAM total, first 64K is the fastest
+#define CFG_SYS_INIT_RAM_ADDR	0x22000000
+#define CFG_SYS_INIT_RAM_SIZE	0x00030000
+
+#endif	/* __CONFIG_H */
diff --git a/include/configs/apple_n25.h b/include/configs/apple_n25.h
new file mode 100644
index 00000000000..007cda4c9fd
--- /dev/null
+++ b/include/configs/apple_n25.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#define CFG_SYS_UBOOT_BASE		CONFIG_TEXT_BASE
+
+// 256K SRAM total, first 128K are the fastest, then 128K slower than DRAM
+#define CFG_SYS_INIT_RAM_ADDR	0x22000000
+#define CFG_SYS_INIT_RAM_SIZE	0x00040000
+
+#endif	/* __CONFIG_H */
diff --git a/include/configs/apple_n31.h b/include/configs/apple_n31.h
new file mode 100644
index 00000000000..85f35e81697
--- /dev/null
+++ b/include/configs/apple_n31.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#define CFG_SYS_UBOOT_BASE		CONFIG_TEXT_BASE
+
+// 256K SRAM total, first 64K is the fastest
+#define CFG_SYS_INIT_RAM_ADDR	0x22000000
+#define CFG_SYS_INIT_RAM_SIZE	0x00040000
+
+#endif	/* __CONFIG_H */
diff --git a/include/configs/apple_n33.h b/include/configs/apple_n33.h
new file mode 100644
index 00000000000..a00e773746f
--- /dev/null
+++ b/include/configs/apple_n33.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#define CFG_SYS_UBOOT_BASE		CONFIG_TEXT_BASE
+
+// 448K SRAM total, first 64K and the 256K at 0x30000 are the fastest
+// 128K at 0x10000 are slower than DRAM
+#define CFG_SYS_INIT_RAM_ADDR	0x22000000
+#define CFG_SYS_INIT_RAM_SIZE	0x00070000
+
+#endif	/* __CONFIG_H */
diff --git a/include/configs/apple_n36.h b/include/configs/apple_n36.h
new file mode 100644
index 00000000000..cad28a3cc8e
--- /dev/null
+++ b/include/configs/apple_n36.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#define CFG_SYS_UBOOT_BASE		CONFIG_TEXT_BASE
+
+// 176K SRAM total
+#define CFG_SYS_INIT_RAM_ADDR	0x22000000
+#define CFG_SYS_INIT_RAM_SIZE	0x0002C000
+
+#endif	/* __CONFIG_H */
diff --git a/include/configs/apple_n46.h b/include/configs/apple_n46.h
new file mode 100644
index 00000000000..007cda4c9fd
--- /dev/null
+++ b/include/configs/apple_n46.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#define CFG_SYS_UBOOT_BASE		CONFIG_TEXT_BASE
+
+// 256K SRAM total, first 128K are the fastest, then 128K slower than DRAM
+#define CFG_SYS_INIT_RAM_ADDR	0x22000000
+#define CFG_SYS_INIT_RAM_SIZE	0x00040000
+
+#endif	/* __CONFIG_H */
diff --git a/include/configs/apple_n58s.h b/include/configs/apple_n58s.h
new file mode 100644
index 00000000000..79192cc4497
--- /dev/null
+++ b/include/configs/apple_n58s.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#define CFG_SYS_UBOOT_BASE		CONFIG_TEXT_BASE
+
+// 192K SRAM total, first 64K is the fastest, then 128K slower than DRAM
+#define CFG_SYS_INIT_RAM_ADDR	0x22000000
+#define CFG_SYS_INIT_RAM_SIZE	0x00030000
+
+#endif	/* __CONFIG_H */

---
base-commit: a6ab6a66146ed0bf1420db0ee858b49005783222
change-id: 20261004-s5l87xx-f98173d2d510

Best regards,
--  
Vencislav Atanasov <user890104@freemyipod.org>

