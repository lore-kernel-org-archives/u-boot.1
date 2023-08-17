Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F03EB64DD
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 08:57:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 608D086AB3;
	Thu, 17 Aug 2023 10:57:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Nn9mEScM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02B9686AB2; Thu, 17 Aug 2023 10:57:26 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B1CE86A4F
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 10:57:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=T.Remmet@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1692262643; x=1694854643;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GkcPnTr+4LzVvQteCNczqy3fFXC8uoJciABFpcDsV+U=;
 b=Nn9mEScMA0sE3f1rcu8ZQeRioeemyJsm4jPgyaEmhE+/5vjIm4mSr66NhvyBeJk2
 w8EIG5jFOb7p6JyN30rmBqzUIFm6igKi6BSIngeh6zwhuAg0VyOY+5DO8XNBNNQC
 z6q7ETmNpTgIpA/WQ1OLO/oXF9udOcPNDgBRwgVTNiM=;
X-AuditID: ac14000a-917fe70000007ecb-ab-64dde0f308ed
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id A2.D2.32459.3F0EDD46;
 Thu, 17 Aug 2023 10:57:23 +0200 (CEST)
Received: from llp-tremmet2.fritz.box (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 17 Aug
 2023 10:57:22 +0200
From: Teresa Remmet <t.remmet@phytec.de>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, "NXP i
 . MX U-Boot Team" <uboot-imx@nxp.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Yannic Moog
 <y.moog@phytec.de>, Daniel Schultz <d.schultz@phytec.de>, Wadim Egorov
 <w.egorov@phytec.de>
Subject: [PATCH v2 0/6] PHYTEC SoM detection for phyCORE-i.MX8MP
Date: Thu, 17 Aug 2023 10:57:05 +0200
Message-ID: <20230817085711.45339-1-t.remmet@phytec.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPLMWRmVeSWpSXmKPExsWyRpKBR/fzg7spBo3tohYPr/pbtJ/ysXi7
 t5PdYsrj9ewW3e/UHVg95s06weKxc9Zddo+zd3YwevR3t7B6bHy3gymANYrLJiU1J7MstUjf
 LoEro/FvH3PBPKGKP6v/szYw3ufrYuTkkBAwkfj94jVrFyMXh5DAEiaJzjnNjBDOM0aJnXvn
 s4NUsQloSDxdcZoJxBYRKJN42PuJGcRmFljMKLH6tyWILSzgILF9/jqwGhYBVYlD7c1gNbwC
 5hJPlrcxQ2yTl9h/8CxUXFDi5MwnLBBz5CWat86GmikhcfDFCzBbCCi+69JJRpjeaedeQ80J
 lTiyaTXTBEaBWUhGzUIyahaSUQsYmVcxCuVmJmenFmVm6xVkVJakJuulpG5iBAWyCAPXDsa+
 OR6HGJk4GA8xSnAwK4nw9vDeShHiTUmsrEotyo8vKs1JLT7EKM3BoiTOe7+HKVFIID2xJDU7
 NbUgtQgmy8TBKdXAuMDq4H6ZIH1bZ7PzPel989IWT5+xIHBicdTugglyzac3fUzn3nZ26f89
 DAGvDA9vXf15d7ADz6HS5DdKXz37c96F8ewXebnC/pp83VvxutW/91R2Pd0a99/onbnz/7Lm
 uV37nWXtbsc7HLGZu+j4hViJrcxWQaZyPw+tUBB68ZXP+9vLgCdpCUosxRmJhlrMRcWJAN6m
 AyxSAgAA
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

second version of the series to add support for EEPROM SoM detection used
by different PHYTEC SoMs. The EEPROM data consist of 32 bytes containing
information like PCB revision, RAM size and other SoM specific
configuration.

For SoMs of the i.MX8M family the data is written to two areas of the
used i2c EEPROM.

We initally add the detection support for phyCORE-i.MX8MP. Due to layout
constraints phyCORE-i.MX8MP SoMs with PCB revision 2 and older can only
make use of a lower RAM frequency. This changes with the use of newer PCB
revisions. We make use of the factory flashed EEPROM data to detect the
PCB revision and select the fitting RAM settings.

Changes in v2:
- fix wrong RAM Timing values as pointed out by Yannic
- removed superfluous goto
- removed blank line at EOF
- fix string conversion to integer
- fix typo s/revsions/revisions

Teresa

Teresa Remmet (6):
  board: phytec: Add common PHYTEC SoM detection
  board: phytec: common: Add imx8m specific EEPROM detection support
  board: phytec: phycore-imx8mp: Add EEPROM detection initialisation
  board: phytec: phycore_imx8mp: Update 2GB RAM Timings
  board: phytec: common: phytec_som_detection: Add helper for PCB
    revision
  board: phytec: phycore_imx8mp: Add 4000MTS RAM timings based on PCB
    rev

 board/phytec/common/Kconfig                 |  13 +
 board/phytec/common/Makefile                |  11 +
 board/phytec/common/imx8m_som_detection.c   | 168 ++++++++++++
 board/phytec/common/imx8m_som_detection.h   |  54 ++++
 board/phytec/common/phytec_som_detection.c  | 203 ++++++++++++++
 board/phytec/common/phytec_som_detection.h  | 109 ++++++++
 board/phytec/phycore_imx8mp/Kconfig         |   1 +
 board/phytec/phycore_imx8mp/lpddr4_timing.c | 278 ++++++++++----------
 board/phytec/phycore_imx8mp/spl.c           |  78 ++++++
 configs/phycore-imx8mp_defconfig            |   1 +
 10 files changed, 773 insertions(+), 143 deletions(-)
 create mode 100644 board/phytec/common/Kconfig
 create mode 100644 board/phytec/common/Makefile
 create mode 100644 board/phytec/common/imx8m_som_detection.c
 create mode 100644 board/phytec/common/imx8m_som_detection.h
 create mode 100644 board/phytec/common/phytec_som_detection.c
 create mode 100644 board/phytec/common/phytec_som_detection.h

-- 
2.34.1

