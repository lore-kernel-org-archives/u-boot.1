Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D8BCA9EBD
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 20:12:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 75F5C6062A;
	Sun, 11 Oct 2026 20:12:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kuPvp3nlQBAH; Sun, 11 Oct 2026 20:12:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 706EE605EE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791749577;
	b=A708V8W2gLQ8NkduW2MXovZrVEFLEWC+CZLrYEUnwSog8sUU8C8h2ibTuHztRKxLyqJw
	 PoUjG1Mj1o/s2Ud8FQpWpJc6NULsORHQjHvd8rmOmVBGcRyiWam9ngaKhtalbJS6MUtyo
	 elP4wQSW/EkUf0autxiMESMP5JG7IG8KP2asiEDDTgf4wfQRTAlMu8g8UhEloOIEJI0iO
	 94wxI/JbuhfYxEFKIMOEIuxa1POGsMcOIskRHX6adq9SrNP5fS2bkH62SxXUJHybAQGWU
	 dOLYAysk3sHrUoVjtYLlQSj+vjGbuMVp2op8ZDxfgDlnEs0ULC7RbaaL4llBLyzTdzA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791749577;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=kAHw0tGFGPonNmk+btPXNiR7P6CUNKz3maqAwwRC4c0=;
	b=WnONaVO9xzYIUUY1IFu4V0V2dPd27hEL0LMu7Pu7Q1ZNQIsSvt5UuE3yAB/guD5t43SU
	 1xQnfpnzUMoRMZxoUtMsi3Lem9U23M0rZoOC+0yqqNM24fgNTynIwItT9skBQAPMAugLY
	 nObBnu/223tATopc3fX326B3sYXXDTF1IpF6GDoMOIUOus2jelWquJjfxiDKjP1v2gTiz
	 rUUJL3wJTHnh6Th219giterSgUgbKfCbo91aCkb6AqO1daLDBWZXostsAkZT6Yc/OA/6b
	 ryBET6hSSuX1cytan3pjuwDsRN+mrYBlnzHx+gxkJEKIcFIgh8t4UVvaylf4L2Jw2KQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791749577;
	bh=kAHw0tGFGPonNmk+btPXNiR7P6CUNKz3maqAwwRC4c0=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=y6UyGsQy4TrDHRNjRfMaPP/0LSwClpZp4kyTJb7GfEAgwTGPWhHJ0CPuCldymOrpE
	 v1T+IA6tsssPKvjYLNv/KoLPSgHXju3njKeLFPv4guO3uXHPbo5+fBT7f9w2kzLYEE
	 DbeNqaLP/cRjQHIgcEek2bUSvzK1LFH2+WdDBmdy3tBv2cjjrFVLAN/8u25w8W2fKn
	 nM9oQQix6mJAvc4FtXOpqEIXDPYa6OM/tLtiSY1ZK5PW2f0rFF+pjOLKEP1mCXs4us
	 +3KkNoUnMrYWjhxuand62Y8EE69KECOmuCmzK+iPpGLrcWiC0I4R76WwsW5lMfIOvB
	 0Rb730dbVDp7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 706EE605EE;
	Sun, 11 Oct 2026 20:12:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DAC8C1A6
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 19:35:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CCF8E40075
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 19:35:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tCkZUR3NC6Hp for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 19:35:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E1A264005F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791747351;
 b=rkUxU1KzjnuG6/v00Z6NcJbxSr7U4McBqD1uGah1oUZP9IIVhzHB6DQwmOhVbS0VyQ0L
 XyeWR3QaaLLhqwXQmlzEGtVkqCqlLVqaoObEukVNce4R3S0TNFC0w7+ZKLhYn97AuG4GL
 UpxdTnOZ2lqA9puHNyYkARI3oUB/eUFu97cx+jonwwbZt9I2xWy0e0InmlHql2XdmVKFz
 OdRFfv3XUvqYIGTR5eTeNIZWyRtpEMlemTyEdQvseyYYAEjuVZ1wlZiwCQ7da08x3Y2Ig
 jtjiydfPGCgzNkJfAys7FWUrxnmSP9HvAI7UVjr+w9wTWVmPau9dPVmIwnsqYkmyQIw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791747351;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Subject:
 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To;
 bh=kAHw0tGFGPonNmk+btPXNiR7P6CUNKz3maqAwwRC4c0=;
 b=U1U01IysW3leXdnu3OC9OgqXooos+bVuN6TIdGpkUeXG/B8GpufAIqOU07yvNIp7ZrBi
 YeshdhL550i/5sUfnYvCxm1BLGbcOxNePJml8xmMkMATG0KRBccYIv9G2WsqGHJ7J9txO
 AVAzfzhd7qmpzmzvS/FvFFZErY+tMiTcR4TJoWNjwvf3bCfXd/vvkyWE0lh5pyiiHDzPg
 H7cIaUPcveXFX+AordIWr1X1rQ2erxMOkouXT9lHz230hQpiJoBqJ2Hx1UugNowoY5SIv
 IZ3I9vM3CgKI44zKHq0iwV0gdt6lPPp7L38yPf8sX7jXgvgNXq+L91Q4cQxyyW2iw2w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=foiD5xMe; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=foiD5xMe
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E1A264005F
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 19:35:50 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4CB60409E2;
 Sun, 11 Oct 2026 19:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2CDC9C2BCF5;
 Sun, 11 Oct 2026 19:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791747349;
 bh=bMM97UtOmPn252lxqp+l7iRphjL6KRTbx5k7lFIxSBQ=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=foiD5xMeUfAzr/O5DuO1stGeP76Up4aoRDHeONDvxPVh/z1d1N69eWP86B3z+X163
 qk6JFHEWj5pmoLSSW87ov2HIHi/gD4O00/WVj+in1YWS5awogvOtdfGgjpXpUONCwn
 BxYpIjo06do1LWp4MVtMA/KDR2khhZwlPhkkXiku6SlhUXDnLDD9Njx6rH9/JM9b15
 B5VK+tPQuBw7PyMlXepm+nChnMNDDRPyFR0AgT+vpdJs29o8bND026VvW/RhP4Ru56
 945Y5t7gSbU9rrx55aYSBJCeTWl5T6BKe+SjeruTQCrmL6tCNWQYf5zcF/gBUHZYlb
 zLDJ5q+eN+cUg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 169A3CA9EC7;
 Sun, 11 Oct 2026 19:35:49 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Subject: [PATCH v2 0/9] pinephone-pro-rk3399: enable display and USB gadget
Date: Sun, 11 Oct 2026 21:35:42 +0200
Message-Id: <20261011-b4-pinephone-pro-defconfig-v2-0-6b7be35fbee7@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ6CMBBFr2K6dkxboUVX3sOwgDKFMdI2LRIN4
 e4WvIDLl//z3sISRsLEroeFRZwpkXcZ5PHAzNC4HoG6zExyqQQXHNoCAjkMg3cIIXro0BrvLPV
 gq3OjeKNLrTTLghDR0nuX3+sfp1f7QDNtxu0xUJp8/Oz1WWy/v0KzAAFlWVQaKyPVBW95n7wbG
 3qejB9Zva7rFx63hgHbAAAA
X-Change-ID: 20261010-b4-pinephone-pro-defconfig-f83a60a75767
To: u-boot@lists.u-boot-project.org
Cc: Peter Robinson <pbrobinson@gmail.com>, David Heidelberg <david@ixit.cz>, 
 Ondrej Jirman <megi@xff.cz>, Tom Rini <trini@konsulko.com>, 
 Petr Hodina <petr.hodina@protonmail.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791747347; l=2951;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=bMM97UtOmPn252lxqp+l7iRphjL6KRTbx5k7lFIxSBQ=;
 b=k2sk7toprx89vGq4tQW1hVbejsbu9usxcQKs6Q7eNQBxHvGtLXI93KkdAKL4MSRbUDOi+arNA
 pe7bJvNifokCKPMtlqoUwv6PxnXzBWU/vX/djy4PcDRKKA6Wxy2LmQy
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sun, 11 Oct 2026 20:12:50 +0000
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

Enable the MIPI-DSI panel and the USB gadget stack on the Pinephone
Pro. Additionaly enable the buttons, DFU, mass storage and watchdog
bits needed to drive it without a serial console. The volume keys depend on the
separate "button: adc: implement get_code()" patch series. See:

https://lore.kernel.org/all/20261010-b4-button-adc-get-code-v1-1-843d04f5dfd5@protonmail.com/T/#t

The DSI/VOP display and the USB peripheral DTS are based on Ondrej
Jirman's tree. Tested on a Pinephone Pro.

See https://download.ixit.cz/ppro.jpeg

For convenience the DFU targets the spinor so the initial sequence to
flash the firmware needs to be done just once.

'''
rkdeveloptool db rk3399_loader_spinor_v1.15.114.bin
rkdeveloptool wl 0 u-boot-rockchip-spi.bin
rkdeveloptool rd
'''

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
Changes in v2:
- Add USB peripheral mode
- Add the DSI/VOP display stack
- Split into clk, DSI core, lane rate, dphy, display adapter and DTS
- Update defconfig patch
- Define DFU spinor target
- Link to v1: https://patch.msgid.link/20261010-b4-pinephone-pro-defconfig-v1-1-55487e8c269e@protonmail.com

To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Ondrej Jirman <megi@xff.cz>
Cc: Petr Hodina <petr.hodina@protonmail.com>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>

---
Ondrej Jirman (1):
      arm: dts: rk3399-pinephone-pro: Enable USB port (peripheral mode)

Petr Hodina (8):
      clk: rockchip: rk3399: add the clocks the DSI and VOP paths need
      video: dw_mipi_dsi: sync LP command and clock lane handling with Linux
      video: rockchip: dw_mipi_dsi: account for burst mode in the lane rate
      video: rockchip: dw_mipi_dsi: tolerate -ENOENT for the optional dphy
      video: rockchip: dw_mipi_dsi: add a UCLASS_DISPLAY adapter for rk_vop
      arm: dts: rk3399-pinephone-pro-u-boot: drop VOP clock assignments
      configs: pinephone-pro-rk3399: Update defconfig
      configs: pinephone-pro-rk3399: add a DFU alt setting for the SPI NOR

 arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi | 33 +++++++++
 configs/pinephone-pro-rk3399_defconfig        | 17 ++++-
 drivers/clk/rockchip/clk_rk3399.c             | 21 ++++++
 drivers/video/dw_mipi_dsi.c                   | 33 ++++++---
 drivers/video/rockchip/dw_mipi_dsi_rockchip.c | 96 ++++++++++++++++++++++-----
 include/configs/pinephone-pro-rk3399.h        |  3 +-
 6 files changed, 176 insertions(+), 27 deletions(-)
---
base-commit: ece349ade2973e220f524ce59e59711cc919263f
change-id: 20261010-b4-pinephone-pro-defconfig-f83a60a75767

Best regards,
--  
Petr Hodina <petr.hodina@protonmail.com>


