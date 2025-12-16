Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEDC0D5E133
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 11:26:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02695839B1;
	Tue, 16 Dec 2025 12:26:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E6418398D; Tue, 16 Dec 2025 12:26:44 +0100 (CET)
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::42a9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56D8E8394E
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 12:26:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dVvlN5MGWzf46;
 Tue, 16 Dec 2025 12:26:40 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dVvlL72fbzrPl; Tue, 16 Dec 2025 12:26:38 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH v2 0/3] rockchip: more templating for binman and switch SPI
 image to rksd by default
Date: Tue, 16 Dec 2025 12:26:28 +0100
Message-Id: <20251216-rockchip-more-template-v2-0-6372e27fc689@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQqDMBBFryKz7pSYaJSueo/iQuLYDK0mTEQq4
 t2beoEu34P//g6JhCnBrdhBaOXEYc6gLwU4389PQh4yg1a6LpVuUIJ7Oc8RpyCEC03x3S+Ere3
 H2tixodZCHkehkT9n+NFl9pyWINv5s5Y/+ze5lqiwMso2uq2UUebuPIls14GgO47jC5Ltzl+8A
 AAA
X-Change-ID: 20251027-rockchip-more-template-86af536f7e86
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Johan Jonker <jbx6244@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
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

The images to flash on SPI and MMC boot media are very similar and
binman templating engine allows to override properties after inserting
the template, so let's do that to template the idbloader.img part for
MMC and SPI images.

While at it, swap the default format for the SPI image from rkspi to
rksd. This patch should not change any behavior, just that the new SoCs
are expected to use rksd if unspecified instead of rkspi which is
assumed required only on some SoCs (like RK3399) due to some BootROM
bug/quirk.

Finally, a small cleanup of rk3288-tinker-s including twice the same
file.

Note that I'm planning on adding support for image signature to
rockchip-u-boot.dtsi in the next few days/weeks, which is the reason why
I'm doing this now as I've had to duplicate the work for the inclusion
of the pubkey in the SPL for the SPI and MMC images for no real reason.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
- rebased on top of master,
- moved changes from arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi to
  arch/arm/dts/rk3326-u-boot.dtsi following commit bf6c7cce09fd
  ("rockchip: odroid-go2: Move SoC common overrides into a SoC u-boot.dtsi")
- rk3576 supports rksd images for SPI according to commit 7f4192d99098
  ("rockchip: rk3576: Add SPI Flash boot support"), so updated the patch
  to reflect that change,
- simplified templating by *not* templating the whole
  u-boot-rockchip*.bin, but only the idbloader*.img part as the fit
  template is now required for usb471 and usb472 binaries, since commit
  e22335a221f8 ("rockchip: Add support for RAM boot from maskrom mode"),
- Link to v1: https://patch.msgid.link/20251027-rockchip-more-template-v1-0-430672840303@cherry.de

---
Quentin Schulz (3):
      rockchip: binman: template idbloader.img for MMC and SPI images
      rockchip: make rksd the default format for SPI images
      rockchip: rk3288-tinker-s: remove duplicate include

 arch/arm/dts/px30-u-boot.dtsi            | 12 ++++++++++++
 arch/arm/dts/rk3036-u-boot.dtsi          | 13 +++++++++++++
 arch/arm/dts/rk3066a-u-boot.dtsi         | 12 ++++++++++++
 arch/arm/dts/rk3128-u-boot.dtsi          | 12 ++++++++++++
 arch/arm/dts/rk3188-u-boot.dtsi          | 12 ++++++++++++
 arch/arm/dts/rk322x-u-boot.dtsi          | 12 ++++++++++++
 arch/arm/dts/rk3288-tinker-s-u-boot.dtsi |  1 -
 arch/arm/dts/rk3288-u-boot.dtsi          | 12 ++++++++++++
 arch/arm/dts/rk3308-u-boot.dtsi          | 12 ++++++++++++
 arch/arm/dts/rk3326-u-boot.dtsi          |  1 -
 arch/arm/dts/rk3328-u-boot.dtsi          |  1 -
 arch/arm/dts/rk3368-u-boot.dtsi          | 12 ++++++++++++
 arch/arm/dts/rk3399-u-boot.dtsi          | 12 ++++++++++++
 arch/arm/dts/rk3528-u-boot.dtsi          | 12 ++++++++++++
 arch/arm/dts/rk356x-u-boot.dtsi          |  1 -
 arch/arm/dts/rk3576-u-boot.dtsi          |  1 -
 arch/arm/dts/rk3588s-u-boot.dtsi         |  1 -
 arch/arm/dts/rockchip-u-boot.dtsi        | 27 +++++++++++----------------
 arch/arm/dts/rv1108-u-boot.dtsi          | 12 ++++++++++++
 arch/arm/dts/rv1126-u-boot.dtsi          | 12 ++++++++++++
 20 files changed, 168 insertions(+), 22 deletions(-)
---
base-commit: 41eddd89235303309ea4e8f2d1f5a076605ee8ce
change-id: 20251027-rockchip-more-template-86af536f7e86

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

