Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450A2C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 11:25:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C359788479;
	Tue, 28 May 2024 13:25:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="fPRz/zcz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5592188479; Tue, 28 May 2024 13:25:05 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 645E78847B
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 13:25:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1716895503; x=1719487503;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wWxwfIsvuci/D5FKd1T/+Ke7g+hGkFgxHc+kphKhOIY=;
 b=fPRz/zczmk774k9e3yHG1vpsziq6zO9jK76XV0nDha05L+r/EkalqVr7dXjR5qqu
 lHTrgXJ6mJm67lAS0V+NZcvzilsVmqJZSnPNK4VirA0hSTEm8qEg3U2BMa6LxCVY
 +/DBmqJHsvWitgHieYfrnKQhz+YDQtKw2csclrE0Pzo=;
X-AuditID: ac14000a-03251700000021bc-7d-6655bf0faad1
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 02.F7.08636.F0FB5566;
 Tue, 28 May 2024 13:25:03 +0200 (CEST)
Received: from lws-moog.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 28 May
 2024 13:25:02 +0200
From: Yannic Moog <y.moog@phytec.de>
Subject: [PATCH 0/2] Migrate PHYTEC imx8m boards to OF_UPSTREAM
Date: Tue, 28 May 2024 13:24:58 +0200
Message-ID: <20240528-phytec_imx8_of_upstream-v1-0-c884c1ddca5f@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAq/VWYC/3WNzQ6CMBCEX4Xs2ZpdSgN68j0MIdgusgd+0iKBE
 N7divHo8ZvMfLNBYC8c4Jps4HmWIEMfgU4J2Lbun6zERYYU0wxNqtXYrhPbSrqlqIameo1h8lx
 3CuvcZRmiLuwF4nr03MhymO9l5FbCNPj1OJrpk/6c+V/nTAqVeaAmbQ2Rptu3eXYM5b7vb6fyg
 kO+AAAA
To: Teresa Remmet <T.Remmet@phytec.de>, Stefano Babic <sbabic@denx.de>, Fabio
 Estevam <festevam@gmail.com>, NXP i.MX U-Boot Team <uboot-imx@nxp.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Yannic Moog
 <y.moog@phytec.de>
X-Mailer: b4 0.13.0
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsWyRpKBR5d/f2iaQftjNouHV/0t2k/5WLzd
 28luMeXxenaL7nfqDqwe82adYPHYOesuu8fZOzsYPfq7W1g9Nr7bwRTAGsVlk5Kak1mWWqRv
 l8CV8fxIN2vBPs6K/mmfWRoY97J3MXJySAiYSLxZs4Wpi5GLQ0hgCZPEkmn3WCGch4wSb14s
 BatiE1CRePwCJMHJISxgL3HjUBsjiM0ioCrRPGclkM3BwSvgJbFttxtImFdAUOLkzCcsIGFm
 AU2J9bv0QcLMAvIS29/OYQYZLyHwnlHi6ZbVjCCOiMA0Ronpu+azQlRFSFy7uQTqOmGJ8wum
 sIHYQgKyEi/O90LF5SWmnXvNDGGHSmz9sp1pAqPgLCS7ZyHsnoVk9wJG5lWMQrmZydmpRZnZ
 egUZlSWpyXopqZsYQeEtwsC1g7FvjschRiYOxkOMEhzMSiK8ZyaFpgnxpiRWVqUW5ccXleak
 Fh9ilOZgURLnXd0RnCokkJ5YkpqdmlqQWgSTZeLglGpglLz91e7KJO51PXfNLs6a+92yJNTt
 THtM7w6dRgXZhM6vP/dF10ip2R89sapx6ZL7eZ+u/fdl7zAP/PQ9wy+JJ+Gx/Lc5177/qV62
 ZXblK6NXIoZTP0qxa/RGuXyQuXRA/UbRN0Un3deCOxd/1cgz1162aOtSZb+vLy5Nm5fIwZC4
 OsL17Ok1/UosxRmJhlrMRcWJAJ40Bx5dAgAA
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

- update MAINTAINERS
- delete synced dt files
- imply OF_UPSTREAM
- update default device tree

---
Yannic Moog (2):
      arm: imx8mm-phycore: move to OF_UPSTREAM
      arm: imx8mp-phycore: move to OF_UPSTREAM

 arch/arm/dts/Makefile                       |   3 -
 arch/arm/dts/imx8mm-phyboard-polis-rdk.dts  | 460 --------------------------
 arch/arm/dts/imx8mm-phycore-som.dtsi        | 440 -------------------------
 arch/arm/dts/imx8mm-phygate-tauri-l.dts     | 489 ----------------------------
 arch/arm/dts/imx8mp-phyboard-pollux-rdk.dts | 361 --------------------
 arch/arm/dts/imx8mp-phycore-som.dtsi        | 323 ------------------
 arch/arm/mach-imx/imx8m/Kconfig             |   2 +
 board/phytec/phycore_imx8mm/MAINTAINERS     |   3 -
 board/phytec/phycore_imx8mp/MAINTAINERS     |   1 -
 configs/imx8mm-phygate-tauri-l_defconfig    |   2 +-
 configs/phycore-imx8mm_defconfig            |   2 +-
 configs/phycore-imx8mp_defconfig            |   2 +-
 12 files changed, 5 insertions(+), 2083 deletions(-)
---
base-commit: cecb5fbb42c8b3de3d5a7df40bc01d1fdf4731d3
change-id: 20240523-phytec_imx8_of_upstream-0a7d440038c9

Best regards,
-- 
Yannic Moog <y.moog@phytec.de>

