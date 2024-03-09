Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA8FC5475B
	for <u-boot@archiver.kernel.org>; Sat,  9 Mar 2024 02:18:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7E2487D4A;
	Sat,  9 Mar 2024 03:18:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1709950736;
	bh=YPrBwSwZp8Dzq6yKLJeoZ87hDvGpKNUFfWTtzmE+EW8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=i9dp9pGPXSK/A36T9IHLUdufyR7jyUkEVfsQkLqQ02KKRcupAmEPx5581fAzIQ8E7
	 xcAqANlAS2UWVJf9sn7+vTwTyLAvJET33oIWE6lj/BkpbacyJDYdg56MEHy+jfANjH
	 60fvXvDDE7vVd78Pi0NNFStk0CRsaReJovCjfROaeJQmwB/iQw46MPoCIvUNC2srog
	 glhKgkugM5lY8N1nu+9TTtd2cbOd2n0XlVdbKH9oPWmN6gxJllr4YndRSSStTMh/Sp
	 R4PikrWviyxXu3qdeWkz9Xm1LmqfABwPswL6Ti5Npm/lfc6qsyALqsakMXOCQS+7wC
	 3tRL3e0dEN/mw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9EC3B876D3;
 Sat,  9 Mar 2024 03:18:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1709950734;
 bh=YPrBwSwZp8Dzq6yKLJeoZ87hDvGpKNUFfWTtzmE+EW8=;
 h=From:To:Cc:Subject:Date:From;
 b=jyLdAo8Nu93IukzIEnxlWrUI88jxsAxp8+gXWJqgh4NV65ddIFy55oIdunYT12TOr
 Z7+TvBj74CIcXvNsI7ryAWLnMmCDC3gCcl+Ep4jgXlNAqtCe6rf230peGNsXne0l1T
 LAjTHzIAlV2iWhTF0+KfF7bVa1qKNMioohr1gJt5IfkzynsoW1g8IwoXMzM+L4o6pe
 3+PAAwiDn0mjnuK4J9MUy4PNoBm+hiyk77kNZQtUHJCjAyTqBivXySQdUTqZ5LrnAj
 meSf1iGxOtR6UNWjJI5SS3Z1Qdqj14yFU/dOkuVLAPFMc7lVPNqfwmSpAxLf0O09Ho
 BTVH1wJ9iuprw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Christophe Roullier <christophe.roullier@st.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 00/11] net: dwc_eth_qos: Clean up STM32 glue code and add
 STM32MP13xx support
Date: Sat,  9 Mar 2024 03:11:21 +0100
Message-ID: <20240309021831.264018-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
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

Split off STM32 glue code from the DWMAC driver into separate
file, similar to what other SoCs already do, to avoid mixing
the ST specifics with generic DWMAC core code.

Clean the STM32 DWMAC board code which is currently duplicated
in multiple board files, move it into the newly separated glue
code, since the code is not board specific, it is only generic
DT parsing and generic register programming.

Add STM32MP13xx support based on ST downstream patches on top,
although that part is mostly rewritten from scratch.

Christophe Roullier (2):
  net: dwc_eth_qos: Add DT parsing for STM32MP13xx platform
  net: dwc_eth_qos: Add support of STM32MP13xx platform

Marek Vasut (8):
  net: dwc_eth_qos: Split STM32 glue into separate file
  net: dwc_eth_qos: Rename eqos_stm32_config to eqos_stm32mp15_config
  net: dwc_eth_qos: Fold board_interface_eth_init into STM32 glue code
  net: dwc_eth_qos: Scrub ifdeffery
  net: dwc_eth_qos: Use FIELD_PREP for ETH_SEL bitfield
  net: dwc_eth_qos: Move log_debug statements on top of case block
  net: dwc_eth_qos: Use consistent logging prints
  net: dwc_eth_qos: Constify st,eth-* values parsed out of DT

Patrick Delaunay (1):
  net: dwc_eth_qos: Request clk-ck earlier in probe on STM32

 board/dhelectronics/dh_stm32mp1/board.c |  82 ------
 board/st/stm32mp1/stm32mp1.c            |  82 ------
 drivers/net/Makefile                    |   1 +
 drivers/net/dwc_eth_qos.c               | 171 +-----------
 drivers/net/dwc_eth_qos.h               |   2 +
 drivers/net/dwc_eth_qos_stm32.c         | 337 ++++++++++++++++++++++++
 6 files changed, 345 insertions(+), 330 deletions(-)
 create mode 100644 drivers/net/dwc_eth_qos_stm32.c

Cc: Christophe Roullier <christophe.roullier@st.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@dh-electronics.com
Cc: uboot-stm32@st-md-mailman.stormreply.com

-- 
2.43.0

