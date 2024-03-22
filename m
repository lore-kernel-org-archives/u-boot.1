Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E0FC47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 11:43:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0255881E0;
	Fri, 22 Mar 2024 12:43:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711107815;
	bh=aQ18ucHHsrnEOmsZVUn30gOFLplg7XwVwLRdc9RGvvc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=apsl1QhCHN/FLktemQYQLPju88fntSIFw8XXXWmYhsEGynCC6cEeB76mtl6qGl0wU
	 eTmNYo7tBg4nm9nBzP8ugxcixdzXjwz2jc6pMRC+3iccmUd5Q/NqWvqNGH8yPDxgtG
	 +iJdqsnyMw5uhfv+zWvSFc81S3/WeiIereTMce5jvVe4R8tUtj0lDMZNOwEOQWityW
	 d2wK3qiRVB5WMkZdCe+cJcdYSUVKFLjgJZnf5O8M4tkFQGtXMjSocJJFT06wboIUkK
	 ZyVKXLo1sGUwLrM0kyOWOK2r7M3F9D5JL2woO485xdItT4a80u68oPykM4QgT7VfI6
	 h0XB0uLMm4jIA==
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DACDA881DB;
 Fri, 22 Mar 2024 12:43:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711107814;
 bh=aQ18ucHHsrnEOmsZVUn30gOFLplg7XwVwLRdc9RGvvc=;
 h=From:To:Cc:Subject:Date:From;
 b=j9FZ2vQm2Dq6x8XbT8kWKmIIg2ZNT1NYWd11pAPQ7+C0c9rN/0sZ8PXU0BA68xki3
 /b+RYkULnejvJNcFnrZ7lfHAiR5hgSt9nhkg4DEmqcd5I3+0ntn3hEANt5nmwRwHkn
 iU53E/uCLHayhImO4dnmvU/5WpYaRr9uXpk7G01927k69mKDz06Z94IUfjhMlF1NMu
 jI3cKX2RC0Bm719JoOhioZTVRbHyFDr3I3LoJ9tuVLBafDu3pcRUMJ3YIDDtcmges+
 tgp2hyt+bBJPiM1vBCigq8vst+EE0/0VWb3PYQ0+XAT+DtiTTDFSb5MSBIgaalnKjH
 gRe29UIH7mfCg==
From: Lukasz Majewski <lukma@denx.de>
To: Stefano Babic <sbabic@denx.de>,
	u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Anatolij Gustschin <agust@denx.de>,
 Christian Hewitt <christianshewitt@gmail.com>,
 FUKAUMI Naoki <naoki@radxa.com>, Fabio Estevam <festevam@gmail.com>,
 Hai Pham <hai.pham.ud@renesas.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Marek Vasut <marex@denx.de>,
 Mathieu Othacehe <othacehe@gnu.org>, Michal Simek <michal.simek@amd.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tianling Shen <cnsztl@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 00/12] arm: xea: Provide support for different XEA board HW
 versions
Date: Fri, 22 Mar 2024 12:43:03 +0100
Message-Id: <20240322114315.2720727-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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


This patch set provides support for different XEA board revisions.
Due to very limited SPL size, the board's switch DTB decision is
performed very early in u-boot proper; before driver model is set.

Adjustments for DTS between revisions are for the u-boot adjustment code
(i.e. tweaks due to functionality not supported in u-boot), hence
there is no need to update them from Linux upstream DTS.


Lukasz Majewski (12):
  arm: spl: xea: Remove I2S pins configuration from early initialization
  arm: xea: Add support for reading SoM (CPU) and base board HW revision
  arm: xea: Rename imx28-xea.dts to imx28-xea-1.dts
  dts: xea: Move phy-reset-gpios property to version specific DTS file
  dts: xea: Remove outdated comment
  arm: xea: Add support for multiple dtbs in u-boot
  dts: xea: Add device tree description for XEA HW rev. 2
  arm: spl: Add definition for PHY reset GPIO for XEA HW rev. 2
  arm: config: xea: Enable support for multiple DTBs for XEA board
  config: xea: Enable late board initialization to set revision variable
  arm: xea: Print information about XEA's SoM HW revision
  arm: env: Add support for booting different HW revisions of XEA boards

 arch/arm/dts/Makefile                         |  3 +-
 arch/arm/dts/imx28-xea-1-u-boot.dtsi          | 11 ++++
 arch/arm/dts/imx28-xea-1.dts                  |  8 +++
 arch/arm/dts/imx28-xea-2-u-boot.dtsi          | 11 ++++
 arch/arm/dts/imx28-xea-2.dts                  |  8 +++
 arch/arm/dts/imx28-xea-u-boot.dtsi            |  1 -
 .../arm/dts/{imx28-xea.dts => imx28-xea.dtsi} |  0
 board/liebherr/xea/spl_xea.c                  | 21 +++---
 board/liebherr/xea/xea.c                      | 65 +++++++++++++++++++
 board/liebherr/xea/xea.env                    |  4 +-
 configs/imx28_xea_defconfig                   |  5 +-
 configs/imx28_xea_sb_defconfig                |  5 +-
 12 files changed, 128 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm/dts/imx28-xea-1-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx28-xea-1.dts
 create mode 100644 arch/arm/dts/imx28-xea-2-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx28-xea-2.dts
 rename arch/arm/dts/{imx28-xea.dts => imx28-xea.dtsi} (100%)

-- 
2.39.2

