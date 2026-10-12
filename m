Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599A9CA9EBD
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 02:01:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B35F606CE;
	Mon, 12 Oct 2026 02:01:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g_aa99oqC6jC; Mon, 12 Oct 2026 02:01:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2AD236069E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791770499;
	b=ZKvudwjyPEjCTWTZAlPNbd/3IcUs5F2dqMRtDgJvv0O+wO6C7/iPpDlZM9T7sHwaB/y6
	 QRa566h91OVgxF194NzPCK2XIucKIHsifvkiuK/L+392J/DHk75h1Hq+aAnO1rEdHnXXf
	 EAmFDY6h8edTtzDEgxHE3Hp2RxrmWlWGishTMnNDvCEuWtXC0pZVbiQzXOzeSJQj2xHFK
	 +7UvP5yddxPofoeciZquYyqoz67lqskhf+hSaHvMCun2HnJgMv5u1qrfxmelBlXcOTLI6
	 EuSnbv1VwpGkIp3lwp1JyaCJRXqRVj4j0vdlJLprQpY9+A7x/ydd8UgXfR/77iid5yg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791770499;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:X-Relaying-Domain:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xtBmvZlKggFiu7xaOE+EDz/gNeA3fNJb6vP9hIb0rog=;
	b=ZVldUfMKu2zQeU3euWUZ05ldB/yesz1wCXWVgDCAPMSW3BdI9jUG65H9bdYbeeKr/W8x
	 UQZdAnwwtqiXQKYpkvKhtXiWpUnazbr/fC8eapB5u0bWFv6+tq/mx4Py16ZOCBGhVUAJ7
	 8PpJjxtNE37LTVcuQ74YPQ58Yey33koSnGm5lWzQQ5VH/zOgcaHo7AM3YCCLd7KEzRwNG
	 iM4NnTBDFkyk9RwUHJb8myPFb9usqBdGrMgHHLJQ73t7Wh6TBz/MQiQfH8K0xMKrqynsA
	 kRJm0ZWsU4vRzWKGV04/XqoaMmjXUI1VIeuqDSNH913yTAjLUdTlSxnaDti2Sp3sk5A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=ausil.us;
	dkim=pass header.d=ausil.us header.i=@ausil.us header.a=rsa-sha256 header.s=google header.b=Xco5H0Pm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791770499;
	bh=xtBmvZlKggFiu7xaOE+EDz/gNeA3fNJb6vP9hIb0rog=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=TXlQBru/RLZd/F/r9EfrrKzt39NJHj2SdCauusxs46S3oOYcHXX5nsDFBdcfq3a5d
	 sZEFW+cYCknDMEsivFoSfiGBvIE2qwB+AtFbRu9J0ZrmRJCqLG14SkzLufSVMI/SOw
	 OnEPrhT+rC2N57ylR1laePP2PGR/4IzTKJYeAVLSg5/FSGRHKTyFP734RkS5VPMAuM
	 PWBoNxes3B6WHoW81rcfDmlrB7X6JXisZ/ntpnWy4S2k3l8hJZuEsW0wzfdyfDPnpm
	 N92DgZBOEnpjBHb5fIipg5GcQhh09jPgRdZOi/+nOhkjEoWioyNC8M4UaF55f5x3P9
	 SriclnUSb6WcA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2AD236069E;
	Mon, 12 Oct 2026 02:01:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 69D6F194
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 02:01:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5A4656069E
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 02:01:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pdKBU3CEY-fZ for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 02:01:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2B0B760603
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::661"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791770497;
 b=Zte0gSV9PD2JcbmqtLUdsXDm6bPedBGDv3AEV3UJ1dnWOIzg4opO4VcKTB3YjdcomSNO
 rr3GKu3M1FRnL9p8YEDfbdQZYWvdVM30LFYcCM6QjeaZ3YRSbPwX5g7jm513dW1L7kq8O
 ptHyBDkbJ3jCMZYj4dJhisTqqlfzYYcr5vNr232hF4X18Q+BmZ1aiPyX1OMGmUn/XLGxv
 0Bb8d82g8F7WwXRvJuYAqFK3lyjhokE+PXiVy6ul8ImAwSEzeJCp0bKtROYU/wSMyy3Iu
 a1E+tbi07h2TTs2jsbZ8r+JvViFeI0AKCAqswqg3BtmAyqz/l323LRWJsT86vZwJSTQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791770497;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:From:
 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=xtBmvZlKggFiu7xaOE+EDz/gNeA3fNJb6vP9hIb0rog=;
 b=NJvule0zFC9hwgg5Q1nce/sqocU/nVdEnpX3874JtMqVjpq3jL9MIlULC4Mkhi8IIRVq
 ejtwNsakiqHNjyGpSB3uQaqvBQAHPhmooTXdbkfybpde/0LTbbnyMQxWrf7o2zhXypwgm
 y36hAH351z8ngTS+UxGo+fw8wRl+m0eyxksyU5JVTk50P6t3eiMphVb1//s6Y/Hamf3S7
 +28tOu4U95Hvkmm9O7BkLly4IExdSC1AjHY2IyV/l93M/ewT05XOGGrxZ4dae44kT+DC9
 0I/CbTBAG3TEsgMmEqGAdvcE8gnS5kzVyBMwoFusSJmbvg3MdgrgjoEBiNImOE/69Bw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=ausil.us;
 dkim=pass header.d=ausil.us header.i=@ausil.us header.a=rsa-sha256
 header.s=google header.b=Xco5H0Pm; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::661"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::661; helo=mail-pl1-x661.google.com;
 envelope-from=dennis@ausil.us; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=ausil.us
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ausil.us header.i=@ausil.us header.a=rsa-sha256
 header.s=google header.b=Xco5H0Pm
Received: from mail-pl1-x661.google.com (mail-pl1-x661.google.com
 [IPv6:2607:f8b0:4864:20::661])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2B0B760603
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 02:01:36 +0000 (UTC)
Received: by mail-pl1-x661.google.com with SMTP id
 d9443c01a7336-2d6d28aa26cso5911765ad.2
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 19:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ausil.us; s=google; t=1791770496; x=1792375296; darn=lists.u-boot-project.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xtBmvZlKggFiu7xaOE+EDz/gNeA3fNJb6vP9hIb0rog=;
 b=Xco5H0Pm+J9/OVnzSHhT6JOwsx9cVwUzjZ3v1DLnrdXBTfRrYZEeDonWh7cWrBf9wq
 G5Jwtpl5+GIRJy/mWJ0bfVZk0wuhg9WilE2/c/r0Aq509a5JgBYC40gf+XM20yHXmIJB
 1h87BaQ3Dn9vWD4sSQsvCggqVaescRuOpQD/zozPU6i9o4JIn7G1FYNbKiYtXUH/kPzE
 +XWapWn277rhlgrVS2lwjtBn+JSNJyBeq0fSJgvrVWdWCe1SDAhOMdA1g2x+mejnTYa7
 zJotXyx9E3u41J6qrSNw7P0dOqgsfrW8LDqeIRDgGM56X3z/qTC4Z865+lD+pxiEDXNK
 Q4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791770496; x=1792375296;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xtBmvZlKggFiu7xaOE+EDz/gNeA3fNJb6vP9hIb0rog=;
 b=PesFshxjWddsL0JPEH5zClF+Jfr6te+d7ZzMeoweVmPnSAPnL7ibRQYdELtIsa9sAt
 H76VqlBZKt8lgrD4Grrg+3HmTm1E3kkiz2EGs6g7uo4QuJaZupl09dcJNZp3LW/PAwKh
 Di0AJPcrYEmISlOLtcKWdYpdBFOWFd0J3K8G80yizLk4LekO4zeOh7zIVPCUdR9AiPtv
 /POzKB8G1SCp2o888bXfFguGGrMh0BZGaDI91KLmbL8Mdx+R1wKHCNparpQ/eAOGDxK5
 D637wdUxrYZ1jLZurUA6IRdNZICbnKUAqwkSB1LJQxiCJUVDFkyCMxjvAI/Ju+Dpe0ve
 D+gw==
X-Gm-Message-State: AFq9FYJi5yEJPGm8OUxkffVvgVxC0E+aan9uv5si5yIea1jhK5WYHR1v
 POZSTW5Kt4bCLc2ssq5m9vA5nQm2iOMEUAWroWQoKGv6RYqa8V3A4bhUv+3u+cCAMiAsxzMQtVR
 cbn611BIqt582hdjC5lOrh2NXXe0IXbbr0eX49UilXZtO
X-Gm-Gg: AYBFou321CJ6mheecBzboSo/4KKg37WiAC2PI2py/fM9GZXfSMWZMIG+apoFiJH3Ucy
 gjcC52gQoBthmInOcdtSkeJ9VLrtdIr/9pUhxmLgPMTUPgBFVyxYhrKmov1JQuxiSvmB6rdKKUz
 020bXSA7Z80Dfb8fv55YqK+t338YgUECWvGF31w1Gmf6mBgRxC/w0tKHYrCCx8RImkCX2sDAp7K
 Id0JWfa9j6Qh7uToogzmE8ooahY/gSQ2dCwwSbPZ9jnfykutSYes0cHhszCKdvviCTTlfseH0DT
 YK3m+xeAaiTtgwpldsAERrEPB7Bvak1Gmu8GIBsFyCvDeB990rIQXdtCfUdSxKSFRBJ8zKbXcfL
 gEJTxaw==
X-Received: by 2002:a17:903:40c5:b0:2e5:7b60:981c with SMTP id
 d9443c01a7336-2e842715c75mr70431345ad.0.1791770496095; 
 Sun, 11 Oct 2026 19:01:36 -0700 (PDT)
Received: from tomin.ausil.us (207-179-239-100.mtco.net. [207.179.239.100])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2e84131a272sm3254325ad.0.2026.10.11.19.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 19:01:36 -0700 (PDT)
X-Relaying-Domain: ausil.us
From: Dennis Gilmore <dennis@ausil.us>
To: u-boot@lists.u-boot-project.org
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Alexey Charkov <alchark@gmail.com>,
 Dennis Gilmore <dennis@ausil.us>, Peter Robinson <pbrobinson@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 0/5] rockchip: Add Xunlong Orange Pi 5 Pro
Date: Sun, 11 Oct 2026 21:01:29 -0500
Message-ID: <20261012020134.621305-1-dennis@ausil.us>
X-Mailer: git-send-email 2.56.0
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
devicetree has been sent:
https://lore.kernel.org/linux-rockchip/20261002025746.3284691-1-dennis@ausil.us/
The override can be dropped once that reaches dts/upstream.

Tested on an Orange Pi 5 Pro 16GB:
- SD-card boot
- eMMC boot
- PCIe/NVMe

Changes in v2:
- Add Reviewed-by tags from Quentin (patches 1-4) and Jonas
  (patch 5)
- Drop PREBOOT, DISPLAY_BOARDINFO_LATE, OF_SPL_REMOVE_PROPS and the
  video options from the defconfig
- Enable LED_PWM for the PWM LEDs
- Sort the MAINTAINERS entry and add Jonas as reviewer
- Add a Link to the Linux devicetree PERST# fix in patch 5

Not changed in v2:
- BUTTON/BUTTON_ADC is not enabled. As Jonas pointed out, the
  Recovery key in the upstream devicetree is not wired to the SARADC
  on this board, so the devicetree needs fixing first.
- No ethernet in U-Boot. The NIC on my boards is a Motorcomm YT6801,
  not an RTL8111, and U-Boot does not have a driver for it.

v1: https://patchwork.ozlabs.org/project/uboot/list/?series=526207

Dennis Gilmore (5):
  dt-bindings: arm: rockchip: Add Orange Pi 5 Pro
  arm64: dts: rockchip: rename PLDO regulator labels to match schematic
    on rk3588s-orangepi-5
  arm64: dts: rockchip: refactor items from Orange Pi 5/b to prep for
    Pro
  arm64: dts: rockchip: Add Orange Pi 5 Pro board support
  board: rockchip: Add Xunlong Orange Pi 5 Pro

 .../dts/rk3588s-orangepi-5-pro-u-boot.dtsi    |  25 ++
 board/rockchip/evb_rk3588/MAINTAINERS         |   7 +
 configs/orangepi-5-pro-rk3588s_defconfig      |  74 ++++
 doc/board/rockchip/rockchip.rst               |   1 +
 dts/upstream/Bindings/arm/rockchip.yaml       |   1 +
 .../arm64/rockchip/rk3588s-orangepi-5-5b.dtsi | 256 +++++++++++++
 .../arm64/rockchip/rk3588s-orangepi-5-pro.dts | 358 ++++++++++++++++++
 .../src/arm64/rockchip/rk3588s-orangepi-5.dts |   6 +-
 .../arm64/rockchip/rk3588s-orangepi-5.dtsi    | 263 +------------
 .../arm64/rockchip/rk3588s-orangepi-5b.dts    |   2 +-
 10 files changed, 743 insertions(+), 250 deletions(-)
 create mode 100644 arch/arm/dts/rk3588s-orangepi-5-pro-u-boot.dtsi
 create mode 100644 configs/orangepi-5-pro-rk3588s_defconfig
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5-5b.dtsi
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5-pro.dts


base-commit: 527115ef6783cec49e5610c523c124b399011361
-- 
2.56.0

