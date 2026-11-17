Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9937C606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 09:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jHnT2J6O;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=Pw0GRB2t
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6A70E6083E;
	Tue, 17 Nov 2026 09:19:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d_Ix-W328EQu; Tue, 17 Nov 2026 09:19:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6E6946081F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794907179;
	b=h5E8KRAVz0e3AAmOhax+aTA4LMEYY6GuWaJoIPEb/JsLMsU+nTc7wAnwJfaQyudAZsXi
	 E+IR94wlM8movy4UwL1Qmrx0EYfGuAOifFildhJVL3OSq36cyNhNYPvaUXuf+6JA55B8k
	 5JP+m5bTTtvSKvTHqnm31opWkG9vdGq1PIaHvtMUqE18ueHFsF1taLdvEWTAJ9ce9OAAo
	 kDXNIq8Aa81kUrhUcpzgoi6paLDaAZ+EgMtv2l1V1lVSoFJXXyZXUvm5T6Ztzha0tom5B
	 0PVt3PMwG8z/k2wO9/Pyrp3cjU4L3ipUmfSjZZtEXzrbmr3yBEa5JCVnbuCAzmwFrAg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794907179;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1DN4VdTYbucIb9i8KG3Yzte9L0amJe6u46WoWUA3S/o=;
	b=aRDxy1LATzuOBaKhxkNJHu5fEI6l+o5Ht42DLFmwlgBFyR9SpahSDXeTOZaFKxpgb/Rh
	 DeS5okLr/KSS94PAP+8MCHkNcxnrAUSk2WRGkNO0+l7tqfFmph9NtV+BC680VnCVkQaOG
	 MpG2+83FHPrMQe4ZEwmaZIdZKJBy6vucT3rK3IkS91IX2SBD0PArLXlWK4iMMwqlgnrzZ
	 ybtNCMugfjn/8q9ph0WJd3L/XbB07rbo1fv9jeFFvbIGlolC5+ASkjlu2yhPaTTdnh/7S
	 35hzje80Hj1QmIeMWa+/YON89F+b/tLt/Q+BdvRV7tUOchUGY3bxy+D8Y3tefj8Gmag==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794907179;
	bh=1DN4VdTYbucIb9i8KG3Yzte9L0amJe6u46WoWUA3S/o=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jHnT2J6O1aKHcUl14a6Hg4T1HvSBIlCVkEJd7OxR4BDATM7OjyKNpQJ/g/7lQLqNF
	 tUpAjvohTLV+ekpB+bkYMPLUWlqIv7n2HXGwBxF7WCV1xBoQhR8tocVhFaQr3Zk9Yu
	 BRJ34Ltz0vHRSFhJC0z4wAqXUpMiP9Pip6fw9AdbGP3fDfW+GdaVSooMw9N53GByt/
	 wzJ8kq3Mib9SCWgkCyZ7ClfC9menLBL3XD+7CFt5DjQOA3vt/OflDNIuUWQY/8aYVr
	 rj/0iIaAo+WsEzydRbA2uhRfF8D4S5nKQjlvLwZtG9DhxiiP3lXz6CqrhZGPMb7Wjp
	 S9EP0mpqov3aw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6E6946081F;
	Tue, 17 Nov 2026 09:19:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 80DD11E7
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:19:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 72502400F3
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:19:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XsCn8EHFRvoP for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 09:19:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D2F11400BC
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=84.16.66.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=84.16.66.172;
 helo=smtp-42ac.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=Pw0GRB2t
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch
 [84.16.66.172])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D2F11400BC
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:19:35 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jTK1c639GzwJZ;
 Tue, 17 Nov 2026 10:19:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794907172;
 bh=1DN4VdTYbucIb9i8KG3Yzte9L0amJe6u46WoWUA3S/o=;
 h=From:Subject:Date:To:Cc:From;
 b=Pw0GRB2t61h/rexwa1uQQzBwGFRnVrc4NOLlRixdxJrAa7PAuuEeQPJUPe/MBmJaE
 Mma+ERz7HwJPEFxi1P0RgvFiY5Z/vJLUFgsN1dm98GlYHwK23bLRiftnypoM7j+liH
 r+ayc1P/ER7Y8lFaCPzeBLAHD7f4CvtZBWcR6QPpvtdehWGBn69lJ1IyDW/J1iqLWT
 /UYCyin/sksCdVBjB0pEwGuRcTaW39JshEUeYqSaTbWjSyd7LrAFIXDHUs3hRI4nlE
 +RsYZRYMSqeq+z2Fh6gAEA9AmpN9+lMk9KNSV0yvUBKoKNIuowoKagasuhHfzHOmyK
 HRJ3WJIK28bRQ==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jTK1Z1sCyzk9j; Tue, 17 Nov 2026 10:19:30 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH next 00/10] rockchip: follow-up series on Johan's
 documentation series
Date: Tue, 17 Nov 2026 10:19:02 +0100
Message-Id: <20261117-rk-doc-follow-up-v1-0-2cc0910f9455@cherry.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMQQ6CMBAF0KtM/ppJGDQVehXjQtpBq6QlLSgJ4
 e5G3b7F21A0By2wtCHrK5SQIixJRXD3a7wpBw9LaOrGiIjh/GSfHA9pHNObl4k7b+r2eGil706
 oCFPWIay/8oyo64zLX8vSP9TN3w37/gFadlAjegAAAA==
X-Change-ID: 20261116-rk-doc-follow-up-9d6084381b97
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Eddie Cai <eddie.cai.linux@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Alexey Charkov <alchark@flipper.net>, Johan Jonker <jbx6244@gmail.com>, 
 Shuqiao Zhang <stevenjoezhang@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Heiko Stuebner <heiko@sntech.de>, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
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

I merged Johan's series[1] even though there were still some open
topics, and I promised I would tackle the feedback in a follow-up
series, so here it is.

Previous feedback taken into account: [2][3][4].

I tried to follow suggestions from Jonas and be consistent with our
style for BootROM and MaskROM and applied that to all over U-Boot.

[1] https://lore.kernel.org/u-boot/5e1799a6-68b3-4535-b56b-f115467e637e@gmail.com/
[2] https://lore.kernel.org/u-boot/fa8799df-3e40-46ef-a4b1-8bdf57415eb0@cherry.de/
[3] https://lore.kernel.org/u-boot/01e9bbb5-508a-4582-a144-fdf14370a0ba@0leil.net/
[4] https://lore.kernel.org/u-boot/1e47521b-c3f2-4c62-86eb-51866b911968@kwiboo.se/

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (10):
      rockchip: be consistent on the "wording style" for BootROM
      rockchip: be consistent on the "wording style" for MaskROM
      rockchip: px30/3036: fix incorrect comment
      doc: qnap: reword instructions
      doc: rockchip: document BootROM term
      doc: rockchip: expand on MaskROM mode
      doc: rockchip: fix incorrect section header
      doc: rockchip: use sphinx admonition instead of subsection
      rockchip: correct [ST]PL_ROCKCHIP_BACK_TO_BROM help text
      doc: rockchip: sync [ST]PL_ROCKCHIP_BACK_TO_BROM help text with Back to BootROM section

 arch/arm/include/asm/arch-rockchip/boot_mode.h |  2 +-
 arch/arm/include/asm/arch-rockchip/bootrom.h   |  4 +-
 arch/arm/mach-rockchip/Kconfig                 | 25 +++++++------
 arch/arm/mach-rockchip/bootrom.c               | 10 ++---
 arch/arm/mach-rockchip/px30-board-tpl.c        |  2 +-
 arch/arm/mach-rockchip/rk3036-board-spl.c      |  2 +-
 arch/arm/mach-rockchip/spl-boot-order.c        |  2 +-
 doc/board/qnap/ts433.rst                       | 12 +++---
 doc/board/rockchip/rockchip.rst                | 52 +++++++++++++++-----------
 drivers/clk/rockchip/clk_rk3368.c              |  2 +-
 drivers/clk/rockchip/clk_rk3399.c              |  4 +-
 drivers/clk/rockchip/clk_rk3528.c              |  4 +-
 drivers/clk/rockchip/clk_rv1126.c              |  2 +-
 drivers/mtd/nand/raw/rockchip_nfc.c            | 12 +++---
 drivers/usb/gadget/f_rockusb.c                 |  2 +-
 tools/rkcommon.c                               |  6 +--
 tools/rkcommon.h                               |  8 ++--
 tools/rkimage.c                                |  2 +-
 tools/rkspi.c                                  |  2 +-
 19 files changed, 83 insertions(+), 72 deletions(-)
---
base-commit: 6201222134cd704b5717211fc917e2ca6263577a
base-tree: https://git.u-boot-project.org/u-boot/u-boot.git next
change-id: 20261116-rk-doc-follow-up-9d6084381b97

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>

