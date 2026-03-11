Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E7FFFD88D4
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 00:17:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AEC383FE1;
	Wed, 11 Mar 2026 01:17:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ocIe6rP9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A45F883FDE; Wed, 11 Mar 2026 01:17:46 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EBD383F9A
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 01:17:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-464ba2bb3aeso322925b6e.1
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 17:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773188263; x=1773793063;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PGuxMhY1T1DlXy/L2Vbrzivqu+YLu97pG5VOzR7Nelw=;
 b=ocIe6rP9K2zpVymgm8uqmw2l3IOBuHxR/A6qPb7RirnrfXfCg9YhLRBLIJ8O++w5UF
 5Asbm6NrfYuqgr7DXmi5F/Nke+jgIPp4sHGwSnDjohZO32QMvgdjE/WXZGDYlEyHa99t
 xE5wvJYMe9bB1BEsdbpW8m4Fm1pr8dk9/ohQMjQZ6FNEwxwqIEqI9DlbICXa1ohsHkNA
 7y/OrC/khlhp0QQPjn4nahDeZEy6VDAXixIE33aaUtYS6gkYP2jlyx8DC3scCigI5aq+
 MmmMkhkrQQkrkSE9xwmsj2OTBbEm0l7mZIJlwZJJcAFmys/Atn+OUyBR6cOUnmAP4Aig
 iTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773188263; x=1773793063;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PGuxMhY1T1DlXy/L2Vbrzivqu+YLu97pG5VOzR7Nelw=;
 b=WEF6DjZuk8w1lQSohXpHT/tmNoplov5OzlqzEtvrJkx9LPOjSxe5L29TcvBiZDaIej
 fmN6VoQ90l60FhP8NwPBwZMJovCQFrg3HwBL9FY15KuqG3mme1WrDI/mOCXgEtX/YLNM
 4OlwOGmA60n+VHfPc8YvaIQnu+HSmxUFUeDeqDt6g3y8vfQ8haJP8epWAxm0vz/RqV96
 3D2N6SemNtwM7q9bKt+WKajaATV8u9EijZxXaNJ0uH6Bvs83FGtHol9XEo+it6Uz7hgg
 E3mTWQ7/gRPRNsSCtr7ESxAAwaUqmR2mH4cHp1yg6EkPnN9IIuXMbEgJD4CqFgEmtiuw
 lliQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTbP8iQ7LfOwlKDdXVo1EpfC2VnVP5NntZz+piZCB5rYVzqBtjopBJIAgc6FjuVmthqvz0oiY=@lists.denx.de
X-Gm-Message-State: AOJu0Yz/EsOYuLIcv18/vVPvpNuDG3Bb3uyL8mJz98MC3+ERfAPo49RH
 6Kl2LPBGqCMYb6IyC2FRxdcK+aqh2037S+jbYoxDm0+UKuuEyij8aVCNkHlFtYaja8w=
X-Gm-Gg: ATEYQzx6qxVg93o2ZD3X3y+emKwCGdR/RL5S2R9H4BvCJazMmBS7uQ3cmsTqaLccDAa
 tHnv8qDYN2EELBLjur19PibAuf/TBV0g9JdmwVsAdfnEhwC+OqtOMZB6OTmweDrZ1fTmEbAUvou
 aMaHM7f+f7QXko46h9leFvYjqTpU1cNMW6lGGILYXNQ3NuiEfy6fv3lMcyhqv62Gi0OZC5ZYCnu
 Lb0o/37cbXXnggUmqVxkQKIDxA8p5Qt+8Fh/Lfi5jJx2luBJv3dgOU4GZi1Wj52vjRI6xDC640O
 eV300wdVrQLXvpqTpbe7rzew4SfNKtzoX16LZ6Mc+K26mUDB5RFFDUtZpb8UNyFy33PeWaY5i3S
 op9S4RM9h2flR+Pf5dWRoe91mqXFTPqCw/m0CpSOeTWc7Rq78R3xgbqDsbAi+OgswrdEqfHBk0K
 cJ37EbGLiamFKMH661dJa0dzHRhhtAqvqq+Q3KnUM=
X-Received: by 2002:a05:6808:1454:b0:467:6b8:ddbb with SMTP id
 5614622812f47-4671bf57e27mr2928834b6e.17.1773188262643; 
 Tue, 10 Mar 2026 17:17:42 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:82ac:f3fe:2e5f:ec03])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae6a361sm466304a34.20.2026.03.10.17.17.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 17:17:42 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 0/6] boards: mediatek: initial support for Genio 720 EVK
Date: Tue, 10 Mar 2026 19:16:49 -0500
Message-Id: <20260310-mtk-mt8391-initial-support-v2-0-1dc862d58532@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Oyw6CMBBFf8V0bU1bEqSu/A/Doo9RJgLFaSESw
 r9bMcadi7nJuYt7ZmERCCGy025hBBNGDH0Gtd8x15j+Bhx9ZqaEKkUO3qV7vqrQkmOPCU3L4zg
 MgRKvnPP+WEotK8vywEBwxec2fqk/TPAYsyP9ygZjCjRvD0zy3X5d+p9rklxwqwpjtRdWW3e2Z
 m7REhxc6Fi9rusLVxzTANwAAAA=
X-Change-ID: 20260202-mtk-mt8391-initial-support-8ccdd761918b
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lukasz Majewski <lukma@denx.de>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Cathy Xu <ot_cathy.xu@mediatek.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2599; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Phr5Fiu/qJeaZqNuenqp3PO2v3B9Bet7/U96rVFRWok=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpsLR3kgvPiinS0RkJGP6PYYkFRy2gh3GA7UkIO
 DOSra5hQ7WJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabC0dxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A7bUIAJHTOiVpQQr0Bw+HOEUZAw/qJ4dx+/RQMx0bW9/
 FJRai5QXPsXgNYfRpeK/V+RHPc3qALGi/ZQFqzASHXvyKtoJxo+p8CkluBYVZok9QVSwd097OmI
 KBCcGW6o+namD1RQ8/QChWVW5SecwoL436cIlG4GCrDWlx3hNMshanKYa9+ijRnkzqW1NFDazDe
 SV+/+SEdyS6jufWZM7gavaQjnLj33lPbRsnrNhbSGpiaXE0Fk57FAGn5sev2tJUR9Ctn/DAiPD3
 K1HJlaV8ETyaEMTUEL6D4G0zAKECyaMVNeozKpsFnU76i55JpbhgQLlcYUL2ehcr1LGAmees4W+
 jRXI=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

These patches along with the listed prerequisites are enough to get the
MediaTek Genio 720 EVK board to boot into Linux from the eMMC (with a
bit of extra config that isn't included here because it isn't generic.)

This is currently being upstreamed in Linux as well, so we just have
some minimal devicetree files here to hold us over for a while until we
can switch to the upstream ones.

This depends on the pinctrl and all MediaTek clock patches from be
currently under review.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- New clock driver patch to add required clocks for PMIC.
- Added pinctrl nodes to both dts patches.
- Added "mediatek,mt8189-vlpckgen" clock controller node.
- Added "mt6359.dtsi" include and associated regulator changes.
- New patch with macros to support the change above.
- Fixed wrong CONFIG_PINCTRL_MT8391 in defconfig.
- Added defconfig and dts for virtually identical Genio 520 EVK.
- Enabled more config options for things that have already been merged.
- Link to v1: https://lore.kernel.org/r/20260209-mtk-mt8391-initial-support-v1-0-b23ab9d0b9bc@baylibre.com

---
Cathy Xu (1):
      arm: dts: mediatek: mt8189: Add pinmux macro header file

Chris-QJ Chen (4):
      arm: mediatek: add support of MT8189 SoC family
      arm: dts: mediatek: Add MediaTek MT8189 dtsi file
      arm: dts: mediatek: Add MediaTek Genio 520/720 EVK DTS
      board: mediatek: Add Genio 520/720 EVK defconfigs

David Lechner (1):
      clk: mediatek: mt8189: add some VLP clocks

 arch/arm/dts/Makefile                  |    2 +
 arch/arm/dts/mt8189-pinfunc.h          | 1125 ++++++++++++++++++++++++++++++++
 arch/arm/dts/mt8189.dtsi               |  301 +++++++++
 arch/arm/dts/mt8371-genio-520-evk.dts  |   11 +
 arch/arm/dts/mt8371-genio-common.dtsi  |  176 +++++
 arch/arm/dts/mt8391-genio-720-evk.dts  |   11 +
 arch/arm/mach-mediatek/Kconfig         |   11 +-
 arch/arm/mach-mediatek/Makefile        |    1 +
 arch/arm/mach-mediatek/mt8189/Makefile |    3 +
 arch/arm/mach-mediatek/mt8189/init.c   |   58 ++
 board/mediatek/MAINTAINERS             |    7 +
 configs/mt8189.config                  |   34 +
 configs/mt8371_genio_520_evk_defconfig |    4 +
 configs/mt8391_genio_720_evk_defconfig |    4 +
 drivers/clk/mediatek/clk-mt8189.c      |  289 ++++++++
 15 files changed, 2036 insertions(+), 1 deletion(-)
---
base-commit: f6914b17b16992f09e3ac3dc942d0a0de6e973cd
change-id: 20260202-mtk-mt8391-initial-support-8ccdd761918b

Best regards,
--  
David Lechner <dlechner@baylibre.com>

