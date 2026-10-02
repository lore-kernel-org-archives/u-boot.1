Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB78CA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 03:13:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B38D40B30;
	Fri,  2 Oct 2026 03:13:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3ZSfrzZm9isL; Fri,  2 Oct 2026 03:13:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4C6B340AE4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790910829;
	b=g5/+xNh6Fi34V0nQr6F3fV1TLK4f3mcIbru1s69pdkFpbzvFwpORepLEpEeVVGvDFnXm
	 7uu419EDabCXH7EvNjpIujV0RgdPZct392uijW9MnsftkG3THPISSyDdNUJQP5/Z5Wojl
	 1cZ7rMk1JUa14L9gARV4bdhsra5iWhR4kg7SXIsb8xhmOTxzclcAQ27LERYDTj/Ha7g/X
	 EQwtlxuNK5SLkC/SWxYcVcO2VQLEK7g2NOuA46ns6MCHVP8w8VKF61/XwnzrtrH03qZBU
	 Yx2mMbYbPi7wgJpZPMNbhqvWzgS88AQZPTsMMJ5BlDzxp/b6DAy6S6yuYY87pxVmxSQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790910829;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:X-Relaying-Domain:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mu6n2WGRajEvpbjUcR8aK+aZ88DAx/dznKW8vRjZWS4=;
	b=UO+mv9PG5YfUJqvLD7mTOONTiAB2dnRkRIZ4//x8hQ86G7YxvtAvXsOhqrXK0u9V0EF4
	 g1YGSnm8mJd8/tldUMVWjvo911da0TjuyIfQYOvWzfwiRnH5ftcR/iunXCVoCZCVxSVFd
	 ff2/Yap6L8ftj19G9okEZetFSysyG3xVFYCl4Ua0kUljUnxA9ceynCleSqzyN1ZBZrP9H
	 RFV6AIu2aZar2p2tlMVbG9oan7bbjNo64CwnuwUGXljwtmvdf2gDfOEsTGVwpAB/Ryrpu
	 SzqSB06BNwv4hbKGoU1XZxw0EZEbqmMiMlcEv7tphF3QP35/jLkcb4sRSM58xlkM5xA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790910829;
	bh=mu6n2WGRajEvpbjUcR8aK+aZ88DAx/dznKW8vRjZWS4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=e0aU3d2CWrpT2lfRhprhcz/KSgyuu5NE7kB/0II3bW4lt+6zirO4ynNv3zJgp4+Iz
	 ACaYiv+Jk8kmN6ewPyQkKIbrp3LguRT5oCMrDO3+mTL+Xrr69uYJovhiyAdiwCeHxa
	 n/V/9jmQAxnXaERFJ4KCv9VZXc6jsTT2OCh3EJr/2ELAHHZuI1mTRpMLt3YDAuB4po
	 etr3hUDeU1z43SRdBaMK8r3NQhDQ6m2ADl5UAjEXHUEohuGFlJg0Bdr+imoJVr6fse
	 aBsPsmHDsl5H7kVEx64RXngvquHKW/kSLtpz6STcYYYfnHhE6UqEpONdgow5VHJied
	 V/qVH7CGSgdTw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4C6B340AE4;
	Fri,  2 Oct 2026 03:13:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BDF724D9F
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 03:13:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BB90F400E9
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 03:13:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d5j2D6tUpcRj for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 03:13:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 8993140062
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1064"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790910826;
 b=FRJjdEwV7OQJGpt5xs5kamyE5qyL5F6WayFbygX2bh3yTpVNCdS/Ck5ML2XC4wv6LcNm
 ZrVCY0qaBB/gX4vO5nLzvt9uAq5G9XQBaCDI7mP4MvqOx7e3EUm+r0GxBRqeW+sLqxeDa
 c7iKtwLDQfGYsMgKJsvM5X1vLyv+cnsMbveiClujQ7TndUntCcKQFcYhWK7r5tO7CT6ZI
 rLvx5bfKa0Esobxg6xdtOs2Z3HlMX9x/DcOYgK+4r32iS3KWOYYdyw5YpAAFueojXpW2c
 PU1u4VXQTQZGhQApydY8E3IbkApUOR+RKFhZttpAA9Fg0U4csY+ZTLsahljczmgveGw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790910826;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:From:
 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=mu6n2WGRajEvpbjUcR8aK+aZ88DAx/dznKW8vRjZWS4=;
 b=pKLmD/EAC/PPpRIDlDE+04yldJSm+4IiB7iOQvf707JKnoUiF78Mh1Q87wDDUF+xirbs
 j4pFhKg7BWaVDM8/ykuP49IONnnGsXNFDiwf+IUHBrhTSFyYJWY8AUJpmKvTqdD0kLIiS
 6wxt026RYUBI/szRCwtURa8Gq9qoiX6D41o8YX0ONuWSWi1NP9vAQ1XyiCnKuG51FMfUE
 aGShqCaS/KCgamtkrGtUg5tcchAXlJAPTHw8jnwzUNzLokrVS6qTepPLCGgJ5hXorX60g
 15KwMa9cjrtEVL3HtX09OClmQW0ngysKMOMUmtZbhgr6JGUts95fOCLeAvoCMev65Ag==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=ausil.us; 
 dkim=pass header.d=ausil.us header.i=@ausil.us header.a=rsa-sha256
 header.s=google header.b=C+akMXe+; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1064"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1064; helo=mail-pj1-x1064.google.com;
 envelope-from=dennis@ausil.us; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=ausil.us
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ausil.us header.i=@ausil.us header.a=rsa-sha256
 header.s=google header.b=C+akMXe+
Received: from mail-pj1-x1064.google.com (mail-pj1-x1064.google.com
 [IPv6:2607:f8b0:4864:20::1064])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8993140062
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 03:13:46 +0000 (UTC)
Received: by mail-pj1-x1064.google.com with SMTP id
 98e67ed59e1d1-3a0f07eb79dso2605160a91.1
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 20:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ausil.us; s=google; t=1790910825; x=1791515625; darn=lists.u-boot-project.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mu6n2WGRajEvpbjUcR8aK+aZ88DAx/dznKW8vRjZWS4=;
 b=C+akMXe+Sz9SrgvD/p1OBIX+E0ihEqNXoc38sdyyNMvKbfQfWkt6AV72aZlJJAnPPc
 d2W2yGz+UMX1J+fRhq1IS8BkVvKdIkO5MzkWR/+jw/TKWupeUg5iZRtIvatVVbKY9eWU
 wkPzmgDmOangBtYKvI9njITlD/3DJOaNh1COOFigjeGYUI1ZXfhld/B+qUXRcDvj6Ksn
 uWQOO3mL3NMQUR6UGirvHlrI+RKZFVSppwd162wNt2gUr+FQbyobNxSM11c87/vQpjtk
 wzjX7x3bvtsodjkRUfcw7GHuDdOaQ6HPoUDluIz2UxgAYkYesQ/6RUclYTjS0IgQwuX7
 71Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790910825; x=1791515625;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mu6n2WGRajEvpbjUcR8aK+aZ88DAx/dznKW8vRjZWS4=;
 b=zM4NXIMEwc/QmxvBHw62hbfAk9O25R09k031ZgLwB+u60T2hmIj8ufBPY0rJyUK76R
 mB3kx/ZEhvutlO14x/IqkPEN/83Y8PrL8MGK2zzF32zvhK7a48VveDnD3xZzcmuJOKx5
 N2Hq4lJJJcs3YLDVqF6si/WjOYXTbVSJoVEstlzTrrxtB3lTaFEJCSCa5CIXS+n9PWhr
 +tAMvfIqnvSS/ZgJNpn8u6JZk3W2DZZ4uso6DtEQxVR+xJvyYuewerfyJqpHD+0gmAKp
 8aVFY70G0xHD+MUXmi3um+nbPKMjqdFkUN/XCikzW3R9kQjROIv+5zvE9rx+P/mIbWwb
 H3Eg==
X-Gm-Message-State: AFq9FYJ10degvESYo+551MdrnJrzwkOuN7PJK4wpjg4+Lz6TGLb8+Vmg
 Jg4UDmJsBzu69AV2eHsY37Nq8NLW4F7ylUQmoM7RjXk8M1rsegu8iSNhNOb1uY8JAAEg57rwkQQ
 d8W45sg1stnlbmDSzDQFEXIjtKcxOuXq209p7PbwC48E5
X-Gm-Gg: AYBFou3UDH7h0sROTnPZGlxLwP/EylsbaXosm4poEWp4RQeeB9Ysx8Y5KVqtj7H0lfi
 HKy5sM2sPtIeVplwboXxYlIT7klIIl1KP7tqULCQVC4gt/e6RZ9LRSRgQsBXJ10uA0J7SaAw9pk
 uMfL3NQzZey5WGbaLJOThclITW+OAVRjXVGklGsub4LZG+dJvoyswJknIyC7ErmGJ9L/8gB8PW2
 KYlkVSzVsSkkRZ3wTbrcF7xcSnEwDmCYgGvgYAOCxNQfCAT4GHbK3o1w+rKuBnDNwtWlvLPWipQ
 8jnSCh4yUAK+FUfUW4nAf56AaoXCkOX/jytMlOMeDxeW00WL5SEaby3+6LEEZ+2UIy8Bo1AXm9L
 +GWvMOA+AekOVH28CXaq/YwY=
X-Received: by 2002:a17:90b:1a89:b0:39e:53a:c8d4 with SMTP id
 98e67ed59e1d1-3a6ce6df006mr1438783a91.12.1790910825471; 
 Thu, 01 Oct 2026 20:13:45 -0700 (PDT)
Received: from ryac.ausil.us (207-179-239-100.mtco.net. [207.179.239.100])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3a6cd60531fsm834715a91.6.2026.10.01.20.13.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 20:13:45 -0700 (PDT)
X-Relaying-Domain: ausil.us
From: Dennis Gilmore <dennis@ausil.us>
To: u-boot@lists.u-boot-project.org
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Alexey Charkov <alchark@gmail.com>,
 Dennis Gilmore <dennis@ausil.us>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/5] rockchip: Add Xunlong Orange Pi 5 Pro
Date: Thu,  1 Oct 2026 22:13:29 -0500
Message-ID: <20261002031334.3285687-1-dennis@ausil.us>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This series adds support for the Xunlong Orange Pi 5 Pro, an RK3588S
board with eMMC, an M.2 M-Key slot for NVMe and an onboard Motorcomm
YT6801 1GbE NIC behind PCIe.

The board devicetree was merged for Linux v7.3. Patches 1-4 pick the
required commits from devicetree-rebasing with
tools/update-subtree.sh pick, so this series does not need to wait
for the v7.3 dts sync. They include a refactor of the Orange Pi 5/5B
devicetree that the Pro builds on.

Patch 5 adds the defconfig, -u-boot.dtsi, MAINTAINERS entry and
documentation.

The upstream devicetree muxes the PERST# pins of pcie2x1l1 and
pcie2x1l2 to the controller's dedicated function while also using
them as reset-gpios. Linux switches the pin to GPIO function when it
is requested, U-Boot does not, and probing pcie2x1l2 hangs. The
-u-boot.dtsi overrides the pinctrl to GPIO function for the reset
pins, as rk3568-rock-3a-u-boot.dtsi does. A fix for the Linux
devicetree has been sent https://lists.infradead.org/pipermail/linux-rockchip/2026-October/077635.html
the override can be dropped once that reaches dts/upstream.

Tested on an Orange Pi 5 Pro 16GB:
- SD-card boot
- eMMC boot
- PCIe/NVMe

Dennis Gilmore (5):
  dt-bindings: arm: rockchip: Add Orange Pi 5 Pro
  arm64: dts: rockchip: rename PLDO regulator labels to match schematic
    on rk3588s-orangepi-5
  arm64: dts: rockchip: refactor items from Orange Pi 5/b to prep for
    Pro
  arm64: dts: rockchip: Add Orange Pi 5 Pro board support
  board: rockchip: Add Xunlong Orange Pi 5 Pro

 .../dts/rk3588s-orangepi-5-pro-u-boot.dtsi    |  25 ++
 board/rockchip/evb_rk3588/MAINTAINERS         |   6 +
 configs/orangepi-5-pro-rk3588s_defconfig      |  82 ++++
 doc/board/rockchip/rockchip.rst               |   1 +
 dts/upstream/Bindings/arm/rockchip.yaml       |   1 +
 .../arm64/rockchip/rk3588s-orangepi-5-5b.dtsi | 256 +++++++++++++
 .../arm64/rockchip/rk3588s-orangepi-5-pro.dts | 358 ++++++++++++++++++
 .../src/arm64/rockchip/rk3588s-orangepi-5.dts |   6 +-
 .../arm64/rockchip/rk3588s-orangepi-5.dtsi    | 263 +------------
 .../arm64/rockchip/rk3588s-orangepi-5b.dts    |   2 +-
 10 files changed, 750 insertions(+), 250 deletions(-)
 create mode 100644 arch/arm/dts/rk3588s-orangepi-5-pro-u-boot.dtsi
 create mode 100644 configs/orangepi-5-pro-rk3588s_defconfig
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5-5b.dtsi
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5-pro.dts


base-commit: 527115ef6783cec49e5610c523c124b399011361
-- 
2.55.0

