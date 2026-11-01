Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36928606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 20:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=R/nFi/WW;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=nZoIiy0e
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0DD82405E6;
	Sun,  1 Nov 2026 20:12:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kkoBuToTBwyN; Sun,  1 Nov 2026 20:12:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DD264405D8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793563966;
	b=ctlzLddtIFX323H6RXVfa01I93VT9P4ce/dMGFfiVy8kNWN/RlbqCyXi3sQ3VA5AnHjk
	 sG+JyaAiYStwpn+epnnGUCbZr4SFKZvxlMT2BuhRewYDnelYIZi+qCe/48ciy7tomlv4a
	 m7RuQg4dLRG7LOzYjCNE1EOG4sAmK5IHXrKyUHfgMf1t1mHFctMz3QJzJvAGXPb9+3Z1l
	 KhBiS2mxwCBUB+ogDcEAx3yfTA7Q3x1AQwt8kDCb0iipL8qaFP1uv97zrFFG3BqOiT+xs
	 aqzldup1HHgymXmk1kYzouYjywNgceCrYhBvYf3+Gh0wVAUhkg2rRQYIIK5kHY0kAFw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793563966;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YNVUEsda2Eua9N8rwKmryR+w9UuN2EX4k2CR6iJm2RM=;
	b=CI9lTWuggquAh06AyJpNYlX1CzBr4enngHJM+KDAfhy9GMgL57Hfa7INLJw/4dKrlcad
	 5cY4M6Y6+BolUpBGx2eGOp63OeoVh2JWIvThrVmOwx9lsr8yd5V8Dj4syQvJmcbQfLUs9
	 KV4BjE/zpdLhyrplsVOfcE3hN5+noIq8efO3OIULQul97JTScn+tbnuoK5jwpCQMVRDXW
	 KO18kxlPZWc2G2dHrm0PeNXLHv0BDFD9fLmY2sDSxLgjtRNfiPntbhOJwnsZAjuIzZscD
	 NX9PtpP/SFL2dSD+9UTj3SyQ2HkQ/847cq28BxIR1FwF7bEYkgZ8tECc5tyPKeJZieg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793563966;
	bh=YNVUEsda2Eua9N8rwKmryR+w9UuN2EX4k2CR6iJm2RM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R/nFi/WWP9E9E3uD/VPXwBwNEP3UyXSgglF86gNFkNNSs8Fr22H5SufUKV/W3BWfJ
	 n3jzIXhBMOoWCrnEBvduKU0Oa0C6AJekQKHCM/49y7DoJAIfNX0Y3oAFVUcNwGIcGn
	 h3LHYMihu2/t342k7d1j91NwDGjRjdQSvRGSWJ/L8FPwv8JzrWTr+U3m+mzZOUo5gu
	 Gp9LERQ7//pkHoVyMUuUOsHOB70MuySHLcH0TKQUEr5dbogJKuauMr1vdAKS6awZCE
	 F1+QAI8jvuHy5sG7H19X/ongFVaGoGnxgdvyxXEHkH8IrJOoduQIjtqqDYtFq8gXFE
	 K9hTCqM6Er1yQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DD264405D8;
	Sun,  1 Nov 2026 20:12:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 863313A7
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 20:12:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6C33980DB8
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 20:12:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hOtMkE1S-2N1 for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 20:12:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6A07F80DB2
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793563962;
 b=JwWN9S4hgizfU3+Nq+xbvAQvq9kq5HR69yxEVJ10CYfDjrFasZUvIH4cZk2AeOUPVs0u
 JKpLmS8p1uIrg0ExaZWcWG+T4gPstbDzUR/ZiOh6TPa0M1PcxIk2nhAzZ38P9YY8WZJEi
 PR07uJ71mE3Eug8R2PqdmVQgszdPv3J6YGZRKL1GnOPPu4r3KsLf3QA4xwdLXlT6KY6yZ
 iMeewkR/lhYOCO3wZv+mu74OoQFAPD/I3DVKhTZoE9EREHYliJJ5MeMoRVgEtLTbusZYB
 dPJV1ICvnDZR6RRJOu9Wh1Pn/f0i4ELH3tjr8r0Il+yOOMsEClhK0HY1XnY2Z77KTgQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793563962;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=YNVUEsda2Eua9N8rwKmryR+w9UuN2EX4k2CR6iJm2RM=;
 b=p9YfRNvStCFRPXxVhBgy8kPXn1FAw7ik8BLQb1sc9qloeZd2Fsm9rzf5iLP4cfhL8siG
 zDK5DfYSfaiGTQPNFjSQIK169h18VUhAXBBr4fDAEYvK/+erPu0CLolQkGmHq9JrA0EcA
 WHg3mhs8GStl/MGOasL9Ein4OIFE+Rfi0sucJIWDn46275pEUxYXsLM+IgXZhFMEEar1g
 vkB3uVkLvaXWCccd49UbpRi++PQtWMAQ3kQ5p/3gUqqZx9KBgfCkB7A0wBpACHUXHzJqV
 kWJy7Ep2lDTzHuQPJoLbfk8QshjYnFrVQA+K5D96ZQ2wB7UQ17eVegaHZ8fzTDC7Y6g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=free.fr;
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=nZoIiy0e; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=nZoIiy0e
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6A07F80DB2
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 20:12:40 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 439E9B0054C;
 Sun,  1 Nov 2026 21:12:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1793563959;
 bh=k/SYTJxUM3GsgX8UGrX+K7AuiaPz8aJWZfD0npk+T74=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nZoIiy0eCMo+yc7tHrdZrklXwDL+C7p8ZdrRVgVq1dwvLA001SwJ0QjkuxDPJi484
 6VjnS2MKbSuOO1tIBQx1DdzLewqraEJ0/Gukh/YdMSRTmmVRXM0zZnCEOK/t97ufrO
 GEGInanhe7iuW+fER74j7nGTUipbyiWvurRvC0XiRPZhjPXtHDIx31eV/NaulzWply
 1D9AGlodhbApfTzKvVT2A/gCO+Y6vpXduTcubQBTQ+L0JW//pH3KlEmKeY7c2IAmUj
 gQSzAd8QiUp3BzitbN3eDuuePpQyUrm1tFT2HsrU/5xYs65xcu862DX6eo6TbyUfQE
 oIjkQ5eMlcCMw==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 2/2] doc: board: nxp: convert the Layerscape SoC README to
 RST
Date: Sun,  1 Nov 2026 21:11:20 +0100
Message-ID: <20261101201126.426751-3-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261101201126.426751-1-vjardin@free.fr>
References: <20261101201126.426751-1-vjardin@free.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Convert arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc to
doc/board/nxp/layerscape.rst.

The text is not modified.

Suggested-by: Tom Rini <trini@konsulko.com>
Link: https://lore.kernel.org/u-boot/20260928191412.GN858934@bill-the-cat/
Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

 MAINTAINERS                                   |   1 +
 .../cpu/armv8/fsl-layerscape/doc/README.soc   | 444 ---------------
 board/nxp/ls1012afrdm/README                  |   2 +-
 board/nxp/ls1012aqds/README                   |   2 +-
 board/nxp/ls1012ardb/README                   |   2 +-
 board/nxp/ls1028a/README                      |   2 +-
 board/nxp/ls1043aqds/README                   |   2 +-
 board/nxp/ls1043ardb/README                   |   2 +-
 board/nxp/ls1046afrwy/README                  |   2 +-
 board/nxp/ls1046aqds/README                   |   2 +-
 board/nxp/ls1088a/README                      |   2 +-
 board/nxp/ls2080aqds/README                   |   2 +-
 board/nxp/ls2080ardb/README                   |   2 +-
 board/nxp/lx2160a/README                      |   4 +-
 doc/board/nxp/index.rst                       |   1 +
 doc/board/nxp/layerscape.rst                  | 517 ++++++++++++++++++
 doc/board/nxp/ls1046ardb.rst                  |   2 +-
 doc/board/nxp/nbxv3.rst                       |   2 +-
 18 files changed, 534 insertions(+), 459 deletions(-)
 delete mode 100644 arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc
 create mode 100644 doc/board/nxp/layerscape.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 7774562a3d0..59bb5fa2897 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1081,6 +1081,7 @@ M:	Peng Fan <peng.fan@nxp.com>
 S:	Maintained
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-fsl-qoriq.git
 F:	doc/board/nxp/hwconfig.rst
+F:	doc/board/nxp/layerscape.rst
 F:	drivers/watchdog/sp805_wdt.c
 F:	drivers/watchdog/sbsa_gwdt.c
 
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc b/arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc
deleted file mode 100644
index e226cc22467..00000000000
--- a/arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc
+++ /dev/null
@@ -1,444 +0,0 @@
-SoC overview
-
-	1. LS1043A
-	2. LS1088A
-	3. LS2080A
-	4. LS1012A
-	5. LS1046A
-	6. LS2088A
-	7. LS2081A
-	8. LX2160A
-	9. LS1028A
-	10. LX2162A
-
-LS1043A
----------
-The LS1043A integrated multicore processor combines four ARM Cortex-A53
-processor cores with datapath acceleration optimized for L2/3 packet
-processing, single pass security offload and robust traffic management
-and quality of service.
-
-The LS1043A SoC includes the following function and features:
- - Four 64-bit ARM Cortex-A53 CPUs
- - 1 MB unified L2 Cache
- - One 32-bit DDR3L/DDR4 SDRAM memory controllers with ECC and interleaving
-   support
- - Data Path Acceleration Architecture (DPAA) incorporating acceleration the
-   the following functions:
-   - Packet parsing, classification, and distribution (FMan)
-   - Queue management for scheduling, packet sequencing, and congestion
-     management (QMan)
-   - Hardware buffer management for buffer allocation and de-allocation (BMan)
-   - Cryptography acceleration (SEC)
- - Ethernet interfaces by FMan
-   - Up to 1 x 10GBase-R supporting 10G interface
-   - Up to 1 x QSGMII
-   - Up to 4 x SGMII supporting 1000Mbps
-   - Up to 2 x SGMII supporting 2500Mbps
-   - Up to 2 x RGMII supporting 1000Mbps
- - High-speed peripheral interfaces
-   - Three PCIe 2.0 controllers, one supporting x4 operation
-   - One serial ATA (SATA 3.0) controllers
- - Additional peripheral interfaces
-   - Three high-speed USB 3.0 controllers with integrated PHY
-   - Enhanced secure digital host controller (eSDXC/eMMC)
-   - Quad Serial Peripheral Interface (QSPI) Controller
-   - Serial peripheral interface (SPI) controller
-   - Four I2C controllers
-   - Two DUARTs
-   - Integrated flash controller supporting NAND and NOR flash
- - QorIQ platform's trust architecture 2.1
-
-LS1088A
---------
-The QorIQ LS1088A processor is built on the Layerscape
-architecture combining eight ARM A53 processor cores
-with advanced, high-performance datapath acceleration
-and networks, peripheral interfaces required for
-networking, wireless infrastructure, and general-purpose
-embedded applications.
-
-LS1088A is compliant with the Layerscape Chassis Generation 3.
-
-Features summary:
- - 8 32-bit / 64-bit ARM v8 Cortex-A53 CPUs
- - Cores are in 2 cluster of 4-cores each
- - 1MB L2 - Cache per cluster
- - Cache coherent interconnect (CCI-400)
- - 1 64-bit DDR4 SDRAM memory controller with ECC
- - Data path acceleration architecture 2.0 (DPAA2)
- - 4-Lane 10GHz SerDes comprising of WRIOP
- - 4-Lane 10GHz SerDes comprising of PCI, SATA, uQE(TDM/HLDC/UART)
- - Ethernet interfaces: SGMIIs, RGMIIs, QSGMIIs, XFIs
- - QSPI, SPI, IFC2.0 supporting NAND, NOR flash
- - 3 PCIe3.0 , 1 SATA3.0, 2 USB3.0, 1 SDXC, 2 DUARTs etc
- - 2 DUARTs
- - 4 I2C, GPIO
- - Thermal monitor unit(TMU)
- - 4 Flextimers and 1 generic timer
- - Support for hardware virtualization and partitioning enforcement
- - QorIQ platform's trust architecture 3.0
- - Service processor (SP) provides pre-boot initialization and secure-boot
-   capabilities
-
-LS2080A
---------
-The LS2080A integrated multicore processor combines eight ARM Cortex-A57
-processor cores with high-performance data path acceleration logic and network
-and peripheral bus interfaces required for networking, telecom/datacom,
-wireless infrastructure, and mil/aerospace applications.
-
-The LS2080A SoC includes the following function and features:
-
- - Eight 64-bit ARM Cortex-A57 CPUs
- - 1 MB platform cache with ECC
- - Two 64-bit DDR4 SDRAM memory controllers with ECC and interleaving support
- - One secondary 32-bit DDR4 SDRAM memory controller, intended for use by
-  the AIOP
- - Data path acceleration architecture (DPAA2) incorporating acceleration for
- the following functions:
-   - Packet parsing, classification, and distribution (WRIOP)
-   - Queue and Hardware buffer management for scheduling, packet sequencing, and
-     congestion management, buffer allocation and de-allocation (QBMan)
-   - Cryptography acceleration (SEC) at up to 10 Gbps
-   - RegEx pattern matching acceleration (PME) at up to 10 Gbps
-   - Decompression/compression acceleration (DCE) at up to 20 Gbps
-   - Accelerated I/O processing (AIOP) at up to 20 Gbps
-   - QDMA engine
- - 16 SerDes lanes at up to 10.3125 GHz
- - Ethernet interfaces
-   - Up to eight 10 Gbps Ethernet MACs
-   - Up to eight 1 / 2.5 Gbps Ethernet MACs
- - High-speed peripheral interfaces
-   - Four PCIe 3.0 controllers, one supporting SR-IOV
- - Additional peripheral interfaces
-   - Two serial ATA (SATA 3.0) controllers
-   - Two high-speed USB 3.0 controllers with integrated PHY
-   - Enhanced secure digital host controller (eSDXC/eMMC)
-   - Serial peripheral interface (SPI) controller
-   - Quad Serial Peripheral Interface (QSPI) Controller
-   - Four I2C controllers
-   - Two DUARTs
-   - Integrated flash controller (IFC 2.0) supporting NAND and NOR flash
- - Support for hardware virtualization and partitioning enforcement
- - QorIQ platform's trust architecture 3.0
- - Service processor (SP) provides pre-boot initialization and secure-boot
-  capabilities
-
-LS1012A
---------
-The LS1012A features an advanced 64-bit ARM v8 Cortex-
-A53 processor, with 32 KB of parity protected L1-I cache,
-32 KB of ECC protected L1-D cache, as well as 256 KB of
-ECC protected L2 cache.
-
-The LS1012A SoC includes the following function and features:
- - One 64-bit ARM v8 Cortex-A53 core with the following capabilities:
- - ARM v8 cryptography extensions
- - One 16-bit DDR3L SDRAM memory controller, Up to 1.0 GT/s, Supports
-    16-/8-bit operation (no ECC support)
- - ARM core-link CCI-400 cache coherent interconnect
- - Packet Forwarding Engine (PFE)
- - Cryptography acceleration (SEC)
- - Ethernet interfaces supported by PFE:
- - One Configurable x3 SerDes:
-    Two Serdes PLLs supported for usage by any SerDes data lane
-    Support for up to 6 GBaud operation
- - High-speed peripheral interfaces:
-     - One PCI Express Gen2 controller, supporting x1 operation
-     - One serial ATA (SATA Gen 3.0) controller
-     - One USB 3.0/2.0 controller with integrated PHY
-     - One USB 2.0 controller with ULPI interface. .
- - Additional peripheral interfaces:
-    - One quad serial peripheral interface (QuadSPI) controller
-    - One serial peripheral interface (SPI) controller
-    - Two enhanced secure digital host controllers
-    - Two I2C controllers
-    - One 16550 compliant DUART (two UART interfaces)
-    - Two general purpose IOs (GPIO)
-    - Two FlexTimers
-    - Five synchronous audio interfaces (SAI)
-    - Pre-boot loader (PBL) provides pre-boot initialization and RCW loading
-    - Single-source clocking solution enabling generation of core, platform,
-    DDR, SerDes, and USB clocks from a single external crystal and internal
-    crystaloscillator
-    - Thermal monitor unit (TMU) with +/- 3C accuracy
-    - Two WatchDog timers
-    - ARM generic timer
- - QorIQ platform's trust architecture 2.1
-
-LS1046A
---------
-The LS1046A integrated multicore processor combines four ARM Cortex-A72
-processor cores with datapath acceleration optimized for L2/3 packet
-processing, single pass security offload and robust traffic management
-and quality of service.
-
-The LS1046A SoC includes the following function and features:
- - Four 64-bit ARM Cortex-A72 CPUs
- - 2 MB unified L2 Cache
- - One 64-bit DDR4 SDRAM memory controllers with ECC and interleaving
-   support
- - Data Path Acceleration Architecture (DPAA) incorporating acceleration the
-   the following functions:
-   - Packet parsing, classification, and distribution (FMan)
-   - Queue management for scheduling, packet sequencing, and congestion
-     management (QMan)
-   - Hardware buffer management for buffer allocation and de-allocation (BMan)
-   - Cryptography acceleration (SEC)
- - Two Configurable x4 SerDes
-   - Two PLLs per four-lane SerDes
-   - Support for 10G operation
- - Ethernet interfaces by FMan
-   - Up to 2 x 10GBase-R supporting 10G interface (MAC 9, 10)
-   - Up to 1 x QSGMII (MAC 5, 6, 10, 1)
-   - Up to 4 x SGMII supporting 1000Mbps (MAC 5, 6, 9, 10)
-   - Up to 3 x SGMII supporting 2500Mbps (MAC 5, 9, 10)
-   - Up to 2 x RGMII supporting 1000Mbps (MAC 3, 4)
- - High-speed peripheral interfaces
-   - Three PCIe 3.0 controllers, one supporting x4 operation
-   - One serial ATA (SATA 3.0) controllers
- - Additional peripheral interfaces
-   - Three high-speed USB 3.0 controllers with integrated PHY
-   - Enhanced secure digital host controller (eSDXC/eMMC)
-   - Quad Serial Peripheral Interface (QSPI) Controller
-   - Serial peripheral interface (SPI) controller
-   - Four I2C controllers
-   - Two DUARTs
-   - Integrated flash controller (IFC) supporting NAND and NOR flash
- - QorIQ platform's trust architecture 2.1
-
-LS2088A
---------
-The LS2088A integrated multicore processor combines eight ARM Cortex-A72
-processor cores with high-performance data path acceleration logic and network
-and peripheral bus interfaces required for networking, telecom/datacom,
-wireless infrastructure, and mil/aerospace applications.
-
-The LS2088A SoC includes the following function and features:
-
- - Eight 64-bit ARM Cortex-A72 CPUs
- - 1 MB platform cache with ECC
- - Two 64-bit DDR4 SDRAM memory controllers with ECC and interleaving support
- - One secondary 32-bit DDR4 SDRAM memory controller, intended for use by
-   the AIOP
- - Data path acceleration architecture (DPAA2) incorporating acceleration for
-   the following functions:
-   - Packet parsing, classification, and distribution (WRIOP)
-   - Queue and Hardware buffer management for scheduling, packet sequencing, and
-     congestion management, buffer allocation and de-allocation (QBMan)
-   - Cryptography acceleration (SEC) at up to 10 Gbps
-   - RegEx pattern matching acceleration (PME) at up to 10 Gbps
-   - Decompression/compression acceleration (DCE) at up to 20 Gbps
-   - Accelerated I/O processing (AIOP) at up to 20 Gbps
-   - QDMA engine
- - 16 SerDes lanes at up to 10.3125 GHz
- - Ethernet interfaces
-   - Up to eight 10 Gbps Ethernet MACs
-   - Up to eight 1 / 2.5 Gbps Ethernet MACs
- - High-speed peripheral interfaces
-   - Four PCIe 3.0 controllers, one supporting SR-IOV
- - Additional peripheral interfaces
-   - Two serial ATA (SATA 3.0) controllers
-   - Two high-speed USB 3.0 controllers with integrated PHY
-   - Enhanced secure digital host controller (eSDXC/eMMC)
-   - Serial peripheral interface (SPI) controller
-   - Quad Serial Peripheral Interface (QSPI) Controller
-   - Four I2C controllers
-   - Two DUARTs
-   - Integrated flash controller (IFC 2.0) supporting NAND and NOR flash
- - Support for hardware virtualization and partitioning enforcement
- - QorIQ platform's trust architecture 3.0
- - Service processor (SP) provides pre-boot initialization and secure-boot
- capabilities
-
-LS2088A SoC has 3 more similar SoC personalities
-1)LS2048A, few difference w.r.t. LS2088A:
-       a) Four 64-bit ARM v8 Cortex-A72 CPUs
-
-2)LS2084A, few difference w.r.t. LS2088A:
-       a) No AIOP
-       b) No 32-bit DDR3 SDRAM memory
-       c) 5 * 1/10G + 5 *1G WRIOP
-       d) No L2 switch
-
-3)LS2044A, few difference w.r.t. LS2084A:
-       a) Four 64-bit ARM v8 Cortex-A72 CPUs
-
-LS2081A
---------
-LS2081A is 40-pin derivative of LS2084A.
-So feature-wise it is same as LS2084A.
-Refer to LS2084A(LS2088A) section above for details.
-
-It has one more similar SoC personality
-1)LS2041A, few difference w.r.t. LS2081A:
-       a) Four 64-bit ARM v8 Cortex-A72 CPUs
-
-LX2160A
---------
-The QorIQ LX2160A processor is built in the 16FFC process on
-the Layerscape architecture combining sixteen ARM A72 processor
-cores with advanced, high-performance datapath acceleration and
-network, peripheral interfaces required for networking, wireless
-infrastructure, storage, and general-purpose embedded applications.
-
-LX2160A is compliant with the Layerscape Chassis Generation 3.2.
-
-The LX2160A SoC includes the following function and features:
-  Sixteen 32-bit / 64-bit ARM v8 A72 CPUs
-  Cache Coherent Interconnect Fabric (CCN508 aka “Eliot”)
-  Two 64-bit 3.2GT/s DDR4 SDRAM memory controllers with ECC.
-  Data path acceleration architecture (DPAA2)
-  24 Serdes lanes at up to 25 GHz
-  Ethernet interfaces
-  Single WRIOP tile supporting 130Gbps using 18 MACs
-  Support for 10G-SXGMII (aka USXGMII).
-  Support for SGMII (and 1000Base-KX)
-  Support for 10GBase-R (and 10GBase-KR)
-  Support for CAUI4 (100G); CAUI2 (50G) and 25G-AUI(25G).
-  Support for XLAUI (and 40GBase-KR4) for 40G.
-  Support for two RGMII parallel interfaces.
-  Energy efficient Ethernet support (802.3az)
-  IEEE 1588 support.
-  High-speed peripheral interfaces
-	Two PCIe Gen 4.0 8-lane controllers supporting SR-IOV,
-	Four PCIe Gen 4.0 4-lane controllers.
-	Four serial ATA (SATA 3.0) controllers.
-	Two USB 3.0 controllers with integrated PHY
-	Two Enhanced secure digital host controllers
-	Two Controller Area Network (CAN) modules
-	Flexible Serial peripheral interface (FlexSPI) controller.
-	Three Serial peripheral interface (SPI) controllers.
-	Eight I2C Controllers.
-	Four PL011 UARTs supporting two 4-pin UART ports or four 2-pin UART ports.
-	General Purpose IO (GPIO)
-  Support for hardware virtualization and partitioning (ARM MMU-500)
-  Support for GIC (ARM GIC-500)
-  QorIQ platform Trust Architecture 3.0
-  One Secure WatchDog timer and one Non-Secure Watchdog timer.
-  ARM Generic Timer
-  Two Flextimers
-  Debug supporting run control, data acquisition, high-speed trace,
-  performance/event monitoring
-  Thermal Monitor Unit (TMU) with +/- 2C accuracy
-  Support for Voltage ID (VID) for yield improvement
-
-LX2160A SoC has 2 more similar SoC personalities
-1)LX2120A, few difference w.r.t. LX2160A:
-       a) Twelve 64-bit ARM v8 Cortex-A72 CPUs
-
-2)LX2080A, few difference w.r.t. LX2160A:
-       a) Eight 64-bit ARM v8 Cortex-A72 CPUs
-
-SerDes 1 lane grouping
-  SRDS_PRTCL_S1 is latched at reset. U-Boot can still configure SD1 before
-  the MC starts:
-  1x100GE + 4x25G, 2x40GE, 1x40GE + 4x10G or 1x100GE + 4x10G.
-  See 'serdes1' in doc/board/nxp/hwconfig.rst, and the 'lx2160_serdes status'
-  command.
-
-
-LS1028A
---------
-The QorIQ LS1028A processor integrates two 64-bit Arm Cortex-A72 cores with
-a GPU and LCD controller, as well as two TSN-enabled Ethernet controllers and
-a TSNenabled 4-port switch.
-
-The high performance Cortex-A72 cores, performing above 16,000 CoreMarks,
-combined with 2.5 Gbit Ethernet, PCI express Gen 3.0, SATA 3.0, USB 3.0 and
-Octal/Quad SPI interfaces provide capabilities for a number of industrial and
-embedded applications. The device provides excellent integration with the
-new Time-Sensitive Networking standard, and enables a number of
-TSN applications.
-
-The LS1028A SoC includes the following function and features:
- - Two 64-bit ARM v8 A72 CPUs
- - Cache Coherent interconnect (CCI-400)
- - One 32-bit DDR3L/DDR4 SDRAM memory controller with ECC
- - eDP/Displayport interface
- - Graphics processing unit
- - One Configurable x4 SerDes
- - Ethernet interfaces
-   - Non-switched: One Ethernet MAC supporting 2.5G, 1G, 100M, 10M, one
-   ethernet MAC supporting 1G, 100M, 10M.
-   - Switched: TSN IP to support four 2.5/1G interfaces.
-   - None of the MACs support MACSEC
-   - Support for RGMII, SGMII (and 1000Base-KX), SGMII 2.5x, QSGMII
-   - Support for 10G-SXGMII and 10G-QXGMII.
-   - Energy efficient Ethernet support (802.3az)
-   - IEEE 1588 support
-  - High-speed peripheral interfaces
-    - Two PCIe 3.0 controllers, one supporting x4 operation
-    - One serial ATA (SATA 3.0) controller
-  - Additional peripheral interfaces
-    - Two high-speed USB 2.0/3.0 controllers with integrated PHY each
-      supporting host or device modes
-    - Two Enhanced secure digital host controllers (SD/SDIO/eMMC)
-    - Two Serial peripheral interface (SPI) controllers
-    - Eight I2C controllers
-    - Two UART controllers
-    - Additional six Industrual UARTs (LPUART).
-    - One FlexSPI controller
-    - General Purpose IO (GPIO)
-    - Two CAN-FD interfaces
-    - Eight Flextimers with PWM I/O
-  - Support for hardware virtualization and partitioning enforcement
-  - Layerscape Trust Architecture
-  - Service Processor (SP) provides pre-boot initialization and secure-boot
-    capabilities
-
-LX2162A
---------
-The QorIQ LX2162A processor is built on the Layerscape architecture
-combining sixteen ARM A72 processor cores with advanced, high-performance
-datapath acceleration and network, peripheral interfaces required for
-networking, wireless infrastructure, storage, and general-purpose embedded
-applications.
-
-LX2162A is compliant with the Layerscape Chassis Generation 3.2.
-
-The LX2162A SoC includes the following function and features:
-  Sixteen 32-bit / 64-bit ARM v8 A72 CPUs
-  Cache Coherent Interconnect Fabric (CCN508)
-  One 64-bit 2.9GT/s DDR4 SDRAM memory controllers with ECC.
-  Data path acceleration architecture (DPAA2)
-  12 Serdes lanes at up to 25 GHz
-  Ethernet interfaces
-  Support for 10G-SXGMII (aka USXGMII).
-  Support for SGMII (and 1000Base-KX)
-  Support for 10GBase-R (and 10GBase-KR)
-  Support for CAUI2 (50G) and 25G-AUI(25G).
-  Support for XLAUI (and 40GBase-KR4) for 40G.
-  Support for two RGMII parallel interfaces.
-  Energy efficient Ethernet support (802.3az)
-  IEEE 1588 support.
-  High-speed peripheral interfaces
-	One PCIe Gen 3.0 8-lane controllers supporting SR-IOV,
-	Two PCIe Gen 3.0 4-lane controllers.
-	Four serial ATA (SATA 3.0) controllers.
-	One USB 3.0 controllers with integrated PHY
-	Two Enhanced secure digital host controllers
-	Two Controller Area Network (CAN) modules
-	Flexible Serial peripheral interface (FlexSPI) controller.
-	Three Serial peripheral interface (SPI) controllers.
-	Eight I2C Controllers.
-	Four PL011 UARTs supporting two 4-pin UART ports or four 2-pin UART ports.
-	General Purpose IO (GPIO)
-  Support for hardware virtualization and partitioning (ARM MMU-500)
-  Support for GIC (ARM GIC-500)
-  QorIQ platform Trust Architecture 3.0
-  One Secure WatchDog timer and one Non-Secure Watchdog timer.
-  ARM Generic Timer
-  Two Flextimers
-  Debug supporting run control, data acquisition, high-speed trace,
-  performance/event monitoring
-  Thermal Monitor Unit (TMU) with +/- 2C accuracy
-  Support for Voltage ID (VID) for yield improvement
-
-LX2162A SoC has 2 more similar SoC personalities
-1)LX2122A, few difference w.r.t. LX2162A:
-       a) Twelve 64-bit ARM v8 Cortex-A72 CPUs
-
-2)LX2082A, few difference w.r.t. LX2162A:
-       a) Eight 64-bit ARM v8 Cortex-A72 CPUs
diff --git a/board/nxp/ls1012afrdm/README b/board/nxp/ls1012afrdm/README
index e60ed606ec1..0d17f7b9abb 100644
--- a/board/nxp/ls1012afrdm/README
+++ b/board/nxp/ls1012afrdm/README
@@ -7,7 +7,7 @@ high-bandwidth DDR3L memory and a full complement of high-speed SerDes ports.
 
 LS1012A SoC Overview
 --------------------
-Please refer arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc for LS2080A
+Please refer doc/board/nxp/layerscape.rst for LS2080A
 SoC overview.
 
  LS1012AFRDM board Overview
diff --git a/board/nxp/ls1012aqds/README b/board/nxp/ls1012aqds/README
index e9b80cad506..2dc4269aa01 100644
--- a/board/nxp/ls1012aqds/README
+++ b/board/nxp/ls1012aqds/README
@@ -8,7 +8,7 @@ a full complement of high-speed SerDes ports.
 
 LS1012A SoC Overview
 --------------------
-Please refer arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc for LS1012A
+Please refer doc/board/nxp/layerscape.rst for LS1012A
 SoC overview.
 
 LS1012AQDS board Overview
diff --git a/board/nxp/ls1012ardb/README b/board/nxp/ls1012ardb/README
index 26b0485a7f8..785d0d406b8 100644
--- a/board/nxp/ls1012ardb/README
+++ b/board/nxp/ls1012ardb/README
@@ -8,7 +8,7 @@ a full complement of high-speed SerDes ports.
 
 LS1012A SoC Overview
 --------------------
-Please refer arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc for LS2080A
+Please refer doc/board/nxp/layerscape.rst for LS2080A
 SoC overview.
 
 LS1012ARDB board Overview
diff --git a/board/nxp/ls1028a/README b/board/nxp/ls1028a/README
index 323881faa50..946764c1b1e 100644
--- a/board/nxp/ls1028a/README
+++ b/board/nxp/ls1028a/README
@@ -6,7 +6,7 @@ derivatives.
 
 LS1028A SoC Overview
 --------------------------------------
-Please refer arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc
+Please refer doc/board/nxp/layerscape.rst
 
 RDB Default Switch Settings (1: ON; 0: OFF)
 -------------------------------------------
diff --git a/board/nxp/ls1043aqds/README b/board/nxp/ls1043aqds/README
index f5aa51da87e..7363d4996a2 100644
--- a/board/nxp/ls1043aqds/README
+++ b/board/nxp/ls1043aqds/README
@@ -8,7 +8,7 @@ debugging environment.
 
 LS1043A SoC Overview
 --------------------
-Please refer arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc for LS1043A
+Please refer doc/board/nxp/layerscape.rst for LS1043A
 SoC overview.
 
  LS1043AQDS board Overview
diff --git a/board/nxp/ls1043ardb/README b/board/nxp/ls1043ardb/README
index 66ee578e99d..40baf0ae83b 100644
--- a/board/nxp/ls1043ardb/README
+++ b/board/nxp/ls1043ardb/README
@@ -8,7 +8,7 @@ debugging environment. The LS1043A RDB is lead-free and RoHS-compliant.
 
 LS1043A SoC Overview
 --------------------
-Please refer arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc for LS1043A
+Please refer doc/board/nxp/layerscape.rst for LS1043A
 SoC overview.
 
  LS1043ARDB board Overview
diff --git a/board/nxp/ls1046afrwy/README b/board/nxp/ls1046afrwy/README
index 2c7c797a879..89d52d4c117 100644
--- a/board/nxp/ls1046afrwy/README
+++ b/board/nxp/ls1046afrwy/README
@@ -8,7 +8,7 @@ debugging environment. The FRWY-LS1046A  is lead-free and RoHS-compliant.
 
 LS1046A SoC Overview
 --------------------
-Please refer arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc for LS1046A
+Please refer doc/board/nxp/layerscape.rst for LS1046A
 SoC overview.
 
  FRWY-LS1046A board Overview
diff --git a/board/nxp/ls1046aqds/README b/board/nxp/ls1046aqds/README
index cb694735a46..bf2c2b088e9 100644
--- a/board/nxp/ls1046aqds/README
+++ b/board/nxp/ls1046aqds/README
@@ -8,7 +8,7 @@ debugging environment.
 
 LS1046A SoC Overview
 --------------------
-Please refer arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc for LS1046A
+Please refer doc/board/nxp/layerscape.rst for LS1046A
 SoC overview.
 
  LS1046AQDS board Overview
diff --git a/board/nxp/ls1088a/README b/board/nxp/ls1088a/README
index 5315909defc..00366ba405e 100644
--- a/board/nxp/ls1088a/README
+++ b/board/nxp/ls1088a/README
@@ -7,7 +7,7 @@ derivatives.
 
 LS1088A SoC Overview
 --------------------------------------
-Please refer arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc
+Please refer doc/board/nxp/layerscape.rst
 
 RDB Default Switch Settings (1: ON; 0: OFF)
 -------------------------------------------
diff --git a/board/nxp/ls2080aqds/README b/board/nxp/ls2080aqds/README
index a4cb1a6cac4..2fbd9640573 100644
--- a/board/nxp/ls2080aqds/README
+++ b/board/nxp/ls2080aqds/README
@@ -8,7 +8,7 @@ processor series, with a complete debugging environment.
 
 LS2080A, LS2088A SoC Overview
 --------------------
-Please refer arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc for LS2080A,
+Please refer doc/board/nxp/layerscape.rst for LS2080A,
 LS2088A SoC overview.
 
  LS2080AQDS board Overview
diff --git a/board/nxp/ls2080ardb/README b/board/nxp/ls2080ardb/README
index 4c1c36ea3a5..553250b5e09 100644
--- a/board/nxp/ls2080ardb/README
+++ b/board/nxp/ls2080ardb/README
@@ -10,7 +10,7 @@ Layerscape Architecture processor.More details in below sections
 
 LS2080A, LS2088A, LS2081A SoC Overview
 --------------------------------------
-Please refer arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc for LS2080A,
+Please refer doc/board/nxp/layerscape.rst for LS2080A,
 LS2081A, LS2088A SoC overview.
 
  LS2080ARDB board Overview
diff --git a/board/nxp/lx2160a/README b/board/nxp/lx2160a/README
index 7bca98dd3d7..f77937d8503 100644
--- a/board/nxp/lx2160a/README
+++ b/board/nxp/lx2160a/README
@@ -6,7 +6,7 @@ Layerscape Architecture processor and its personalities.
 
 LX2160A SoC Overview
 --------------------------------------
-For details, please refer arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc
+For details, please refer doc/board/nxp/layerscape.rst
 
 LX2160ARDB board Overview
 ----------------------
@@ -197,7 +197,7 @@ SERDES3	|CARDS
 
 LX2162A SoC Overview
 --------------------------------------
-For details, please refer arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc
+For details, please refer doc/board/nxp/layerscape.rst
 
 LX2162AQDS board Overview
 ----------------------
diff --git a/doc/board/nxp/index.rst b/doc/board/nxp/index.rst
index 4458ee0fd87..f61256e2103 100644
--- a/doc/board/nxp/index.rst
+++ b/doc/board/nxp/index.rst
@@ -27,6 +27,7 @@ NXP Semiconductors
    imxrt1020-evk
    imxrt1050-evk
    imxrt1170-evk
+   layerscape
    ls1046ardb
    mx6sabreauto
    mx6sabresd
diff --git a/doc/board/nxp/layerscape.rst b/doc/board/nxp/layerscape.rst
new file mode 100644
index 00000000000..ecc023b328c
--- /dev/null
+++ b/doc/board/nxp/layerscape.rst
@@ -0,0 +1,517 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+SoC overview
+============
+
+1. LS1043A
+2. LS1088A
+3. LS2080A
+4. LS1012A
+5. LS1046A
+6. LS2088A
+7. LS2081A
+8. LX2160A
+9. LS1028A
+10. LX2162A
+
+LS1043A
+-------
+
+The LS1043A integrated multicore processor combines four ARM Cortex-A53
+processor cores with datapath acceleration optimized for L2/3 packet
+processing, single pass security offload and robust traffic management
+and quality of service.
+
+The LS1043A SoC includes the following function and features:
+
+- Four 64-bit ARM Cortex-A53 CPUs
+- 1 MB unified L2 Cache
+- One 32-bit DDR3L/DDR4 SDRAM memory controllers with ECC and interleaving
+  support
+- Data Path Acceleration Architecture (DPAA) incorporating acceleration the
+  the following functions:
+
+  - Packet parsing, classification, and distribution (FMan)
+  - Queue management for scheduling, packet sequencing, and congestion
+    management (QMan)
+  - Hardware buffer management for buffer allocation and de-allocation (BMan)
+  - Cryptography acceleration (SEC)
+
+- Ethernet interfaces by FMan
+
+  - Up to 1 x 10GBase-R supporting 10G interface
+  - Up to 1 x QSGMII
+  - Up to 4 x SGMII supporting 1000Mbps
+  - Up to 2 x SGMII supporting 2500Mbps
+  - Up to 2 x RGMII supporting 1000Mbps
+
+- High-speed peripheral interfaces
+
+  - Three PCIe 2.0 controllers, one supporting x4 operation
+  - One serial ATA (SATA 3.0) controllers
+
+- Additional peripheral interfaces
+
+  - Three high-speed USB 3.0 controllers with integrated PHY
+  - Enhanced secure digital host controller (eSDXC/eMMC)
+  - Quad Serial Peripheral Interface (QSPI) Controller
+  - Serial peripheral interface (SPI) controller
+  - Four I2C controllers
+  - Two DUARTs
+  - Integrated flash controller supporting NAND and NOR flash
+
+- QorIQ platform's trust architecture 2.1
+
+LS1088A
+-------
+
+The QorIQ LS1088A processor is built on the Layerscape
+architecture combining eight ARM A53 processor cores
+with advanced, high-performance datapath acceleration
+and networks, peripheral interfaces required for
+networking, wireless infrastructure, and general-purpose
+embedded applications.
+
+LS1088A is compliant with the Layerscape Chassis Generation 3.
+
+Features summary:
+
+- 8 32-bit / 64-bit ARM v8 Cortex-A53 CPUs
+- Cores are in 2 cluster of 4-cores each
+- 1MB L2 - Cache per cluster
+- Cache coherent interconnect (CCI-400)
+- 1 64-bit DDR4 SDRAM memory controller with ECC
+- Data path acceleration architecture 2.0 (DPAA2)
+- 4-Lane 10GHz SerDes comprising of WRIOP
+- 4-Lane 10GHz SerDes comprising of PCI, SATA, uQE(TDM/HLDC/UART)
+- Ethernet interfaces: SGMIIs, RGMIIs, QSGMIIs, XFIs
+- QSPI, SPI, IFC2.0 supporting NAND, NOR flash
+- 3 PCIe3.0 , 1 SATA3.0, 2 USB3.0, 1 SDXC, 2 DUARTs etc
+- 2 DUARTs
+- 4 I2C, GPIO
+- Thermal monitor unit(TMU)
+- 4 Flextimers and 1 generic timer
+- Support for hardware virtualization and partitioning enforcement
+- QorIQ platform's trust architecture 3.0
+- Service processor (SP) provides pre-boot initialization and secure-boot
+  capabilities
+
+LS2080A
+-------
+
+The LS2080A integrated multicore processor combines eight ARM Cortex-A57
+processor cores with high-performance data path acceleration logic and network
+and peripheral bus interfaces required for networking, telecom/datacom,
+wireless infrastructure, and mil/aerospace applications.
+
+The LS2080A SoC includes the following function and features:
+
+- Eight 64-bit ARM Cortex-A57 CPUs
+- 1 MB platform cache with ECC
+- Two 64-bit DDR4 SDRAM memory controllers with ECC and interleaving support
+- One secondary 32-bit DDR4 SDRAM memory controller, intended for use by
+  the AIOP
+- Data path acceleration architecture (DPAA2) incorporating acceleration for
+  the following functions:
+
+  - Packet parsing, classification, and distribution (WRIOP)
+  - Queue and Hardware buffer management for scheduling, packet sequencing, and
+    congestion management, buffer allocation and de-allocation (QBMan)
+  - Cryptography acceleration (SEC) at up to 10 Gbps
+  - RegEx pattern matching acceleration (PME) at up to 10 Gbps
+  - Decompression/compression acceleration (DCE) at up to 20 Gbps
+  - Accelerated I/O processing (AIOP) at up to 20 Gbps
+  - QDMA engine
+
+- 16 SerDes lanes at up to 10.3125 GHz
+- Ethernet interfaces
+
+  - Up to eight 10 Gbps Ethernet MACs
+  - Up to eight 1 / 2.5 Gbps Ethernet MACs
+
+- High-speed peripheral interfaces
+
+  - Four PCIe 3.0 controllers, one supporting SR-IOV
+
+- Additional peripheral interfaces
+
+  - Two serial ATA (SATA 3.0) controllers
+  - Two high-speed USB 3.0 controllers with integrated PHY
+  - Enhanced secure digital host controller (eSDXC/eMMC)
+  - Serial peripheral interface (SPI) controller
+  - Quad Serial Peripheral Interface (QSPI) Controller
+  - Four I2C controllers
+  - Two DUARTs
+  - Integrated flash controller (IFC 2.0) supporting NAND and NOR flash
+
+- Support for hardware virtualization and partitioning enforcement
+- QorIQ platform's trust architecture 3.0
+- Service processor (SP) provides pre-boot initialization and secure-boot
+  capabilities
+
+LS1012A
+-------
+
+The LS1012A features an advanced 64-bit ARM v8 Cortex-
+A53 processor, with 32 KB of parity protected L1-I cache,
+32 KB of ECC protected L1-D cache, as well as 256 KB of
+ECC protected L2 cache.
+
+The LS1012A SoC includes the following function and features:
+
+- One 64-bit ARM v8 Cortex-A53 core with the following capabilities:
+- ARM v8 cryptography extensions
+- One 16-bit DDR3L SDRAM memory controller, Up to 1.0 GT/s, Supports
+  16-/8-bit operation (no ECC support)
+- ARM core-link CCI-400 cache coherent interconnect
+- Packet Forwarding Engine (PFE)
+- Cryptography acceleration (SEC)
+- Ethernet interfaces supported by PFE:
+- One Configurable x3 SerDes:
+
+  - Two Serdes PLLs supported for usage by any SerDes data lane
+  - Support for up to 6 GBaud operation
+
+- High-speed peripheral interfaces:
+
+  - One PCI Express Gen2 controller, supporting x1 operation
+  - One serial ATA (SATA Gen 3.0) controller
+  - One USB 3.0/2.0 controller with integrated PHY
+  - One USB 2.0 controller with ULPI interface. .
+
+- Additional peripheral interfaces:
+
+  - One quad serial peripheral interface (QuadSPI) controller
+  - One serial peripheral interface (SPI) controller
+  - Two enhanced secure digital host controllers
+  - Two I2C controllers
+  - One 16550 compliant DUART (two UART interfaces)
+  - Two general purpose IOs (GPIO)
+  - Two FlexTimers
+  - Five synchronous audio interfaces (SAI)
+  - Pre-boot loader (PBL) provides pre-boot initialization and RCW loading
+  - Single-source clocking solution enabling generation of core, platform,
+    DDR, SerDes, and USB clocks from a single external crystal and internal
+    crystaloscillator
+  - Thermal monitor unit (TMU) with +/- 3C accuracy
+  - Two WatchDog timers
+  - ARM generic timer
+
+- QorIQ platform's trust architecture 2.1
+
+LS1046A
+-------
+
+The LS1046A integrated multicore processor combines four ARM Cortex-A72
+processor cores with datapath acceleration optimized for L2/3 packet
+processing, single pass security offload and robust traffic management
+and quality of service.
+
+The LS1046A SoC includes the following function and features:
+
+- Four 64-bit ARM Cortex-A72 CPUs
+- 2 MB unified L2 Cache
+- One 64-bit DDR4 SDRAM memory controllers with ECC and interleaving
+  support
+- Data Path Acceleration Architecture (DPAA) incorporating acceleration the
+  the following functions:
+
+  - Packet parsing, classification, and distribution (FMan)
+  - Queue management for scheduling, packet sequencing, and congestion
+    management (QMan)
+  - Hardware buffer management for buffer allocation and de-allocation (BMan)
+  - Cryptography acceleration (SEC)
+
+- Two Configurable x4 SerDes
+
+  - Two PLLs per four-lane SerDes
+  - Support for 10G operation
+
+- Ethernet interfaces by FMan
+
+  - Up to 2 x 10GBase-R supporting 10G interface (MAC 9, 10)
+  - Up to 1 x QSGMII (MAC 5, 6, 10, 1)
+  - Up to 4 x SGMII supporting 1000Mbps (MAC 5, 6, 9, 10)
+  - Up to 3 x SGMII supporting 2500Mbps (MAC 5, 9, 10)
+  - Up to 2 x RGMII supporting 1000Mbps (MAC 3, 4)
+
+- High-speed peripheral interfaces
+
+  - Three PCIe 3.0 controllers, one supporting x4 operation
+  - One serial ATA (SATA 3.0) controllers
+
+- Additional peripheral interfaces
+
+  - Three high-speed USB 3.0 controllers with integrated PHY
+  - Enhanced secure digital host controller (eSDXC/eMMC)
+  - Quad Serial Peripheral Interface (QSPI) Controller
+  - Serial peripheral interface (SPI) controller
+  - Four I2C controllers
+  - Two DUARTs
+  - Integrated flash controller (IFC) supporting NAND and NOR flash
+
+- QorIQ platform's trust architecture 2.1
+
+LS2088A
+-------
+
+The LS2088A integrated multicore processor combines eight ARM Cortex-A72
+processor cores with high-performance data path acceleration logic and network
+and peripheral bus interfaces required for networking, telecom/datacom,
+wireless infrastructure, and mil/aerospace applications.
+
+The LS2088A SoC includes the following function and features:
+
+- Eight 64-bit ARM Cortex-A72 CPUs
+- 1 MB platform cache with ECC
+- Two 64-bit DDR4 SDRAM memory controllers with ECC and interleaving support
+- One secondary 32-bit DDR4 SDRAM memory controller, intended for use by
+  the AIOP
+- Data path acceleration architecture (DPAA2) incorporating acceleration for
+  the following functions:
+
+  - Packet parsing, classification, and distribution (WRIOP)
+  - Queue and Hardware buffer management for scheduling, packet sequencing, and
+    congestion management, buffer allocation and de-allocation (QBMan)
+  - Cryptography acceleration (SEC) at up to 10 Gbps
+  - RegEx pattern matching acceleration (PME) at up to 10 Gbps
+  - Decompression/compression acceleration (DCE) at up to 20 Gbps
+  - Accelerated I/O processing (AIOP) at up to 20 Gbps
+  - QDMA engine
+
+- 16 SerDes lanes at up to 10.3125 GHz
+- Ethernet interfaces
+
+  - Up to eight 10 Gbps Ethernet MACs
+  - Up to eight 1 / 2.5 Gbps Ethernet MACs
+
+- High-speed peripheral interfaces
+
+  - Four PCIe 3.0 controllers, one supporting SR-IOV
+
+- Additional peripheral interfaces
+
+  - Two serial ATA (SATA 3.0) controllers
+  - Two high-speed USB 3.0 controllers with integrated PHY
+  - Enhanced secure digital host controller (eSDXC/eMMC)
+  - Serial peripheral interface (SPI) controller
+  - Quad Serial Peripheral Interface (QSPI) Controller
+  - Four I2C controllers
+  - Two DUARTs
+  - Integrated flash controller (IFC 2.0) supporting NAND and NOR flash
+
+- Support for hardware virtualization and partitioning enforcement
+- QorIQ platform's trust architecture 3.0
+- Service processor (SP) provides pre-boot initialization and secure-boot
+  capabilities
+
+LS2088A SoC has 3 more similar SoC personalities
+
+1)LS2048A, few difference w.r.t. LS2088A:
+       a) Four 64-bit ARM v8 Cortex-A72 CPUs
+
+2)LS2084A, few difference w.r.t. LS2088A:
+       a) No AIOP
+       b) No 32-bit DDR3 SDRAM memory
+       c) 5 * 1/10G + 5 \*1G WRIOP
+       d) No L2 switch
+
+3)LS2044A, few difference w.r.t. LS2084A:
+       a) Four 64-bit ARM v8 Cortex-A72 CPUs
+
+LS2081A
+-------
+
+LS2081A is 40-pin derivative of LS2084A.
+So feature-wise it is same as LS2084A.
+Refer to LS2084A(LS2088A) section above for details.
+
+It has one more similar SoC personality
+
+1)LS2041A, few difference w.r.t. LS2081A:
+       a) Four 64-bit ARM v8 Cortex-A72 CPUs
+
+LX2160A
+-------
+
+The QorIQ LX2160A processor is built in the 16FFC process on
+the Layerscape architecture combining sixteen ARM A72 processor
+cores with advanced, high-performance datapath acceleration and
+network, peripheral interfaces required for networking, wireless
+infrastructure, storage, and general-purpose embedded applications.
+
+LX2160A is compliant with the Layerscape Chassis Generation 3.2.
+
+The LX2160A SoC includes the following function and features:
+
+- Sixteen 32-bit / 64-bit ARM v8 A72 CPUs
+- Cache Coherent Interconnect Fabric (CCN508 aka “Eliot”)
+- Two 64-bit 3.2GT/s DDR4 SDRAM memory controllers with ECC.
+- Data path acceleration architecture (DPAA2)
+- 24 Serdes lanes at up to 25 GHz
+- Ethernet interfaces
+- Single WRIOP tile supporting 130Gbps using 18 MACs
+- Support for 10G-SXGMII (aka USXGMII).
+- Support for SGMII (and 1000Base-KX)
+- Support for 10GBase-R (and 10GBase-KR)
+- Support for CAUI4 (100G); CAUI2 (50G) and 25G-AUI(25G).
+- Support for XLAUI (and 40GBase-KR4) for 40G.
+- Support for two RGMII parallel interfaces.
+- Energy efficient Ethernet support (802.3az)
+- IEEE 1588 support.
+- High-speed peripheral interfaces
+
+  - Two PCIe Gen 4.0 8-lane controllers supporting SR-IOV,
+  - Four PCIe Gen 4.0 4-lane controllers.
+  - Four serial ATA (SATA 3.0) controllers.
+  - Two USB 3.0 controllers with integrated PHY
+  - Two Enhanced secure digital host controllers
+  - Two Controller Area Network (CAN) modules
+  - Flexible Serial peripheral interface (FlexSPI) controller.
+  - Three Serial peripheral interface (SPI) controllers.
+  - Eight I2C Controllers.
+  - Four PL011 UARTs supporting two 4-pin UART ports or four 2-pin UART ports.
+  - General Purpose IO (GPIO)
+
+- Support for hardware virtualization and partitioning (ARM MMU-500)
+- Support for GIC (ARM GIC-500)
+- QorIQ platform Trust Architecture 3.0
+- One Secure WatchDog timer and one Non-Secure Watchdog timer.
+- ARM Generic Timer
+- Two Flextimers
+- Debug supporting run control, data acquisition, high-speed trace,
+  performance/event monitoring
+- Thermal Monitor Unit (TMU) with +/- 2C accuracy
+- Support for Voltage ID (VID) for yield improvement
+
+LX2160A SoC has 2 more similar SoC personalities
+
+1)LX2120A, few difference w.r.t. LX2160A:
+       a) Twelve 64-bit ARM v8 Cortex-A72 CPUs
+
+2)LX2080A, few difference w.r.t. LX2160A:
+       a) Eight 64-bit ARM v8 Cortex-A72 CPUs
+
+SerDes 1 lane grouping
+  SRDS_PRTCL_S1 is latched at reset. U-Boot can still configure SD1 before
+  the MC starts:
+  1x100GE + 4x25G, 2x40GE, 1x40GE + 4x10G or 1x100GE + 4x10G.
+  See 'serdes1' in doc/board/nxp/hwconfig.rst, and the 'lx2160_serdes status'
+  command.
+
+LS1028A
+-------
+
+The QorIQ LS1028A processor integrates two 64-bit Arm Cortex-A72 cores with
+a GPU and LCD controller, as well as two TSN-enabled Ethernet controllers and
+a TSNenabled 4-port switch.
+
+The high performance Cortex-A72 cores, performing above 16,000 CoreMarks,
+combined with 2.5 Gbit Ethernet, PCI express Gen 3.0, SATA 3.0, USB 3.0 and
+Octal/Quad SPI interfaces provide capabilities for a number of industrial and
+embedded applications. The device provides excellent integration with the
+new Time-Sensitive Networking standard, and enables a number of
+TSN applications.
+
+The LS1028A SoC includes the following function and features:
+
+- Two 64-bit ARM v8 A72 CPUs
+- Cache Coherent interconnect (CCI-400)
+- One 32-bit DDR3L/DDR4 SDRAM memory controller with ECC
+- eDP/Displayport interface
+- Graphics processing unit
+- One Configurable x4 SerDes
+- Ethernet interfaces
+
+  - Non-switched: One Ethernet MAC supporting 2.5G, 1G, 100M, 10M, one
+    ethernet MAC supporting 1G, 100M, 10M.
+  - Switched: TSN IP to support four 2.5/1G interfaces.
+  - None of the MACs support MACSEC
+  - Support for RGMII, SGMII (and 1000Base-KX), SGMII 2.5x, QSGMII
+  - Support for 10G-SXGMII and 10G-QXGMII.
+  - Energy efficient Ethernet support (802.3az)
+  - IEEE 1588 support
+
+- High-speed peripheral interfaces
+
+  - Two PCIe 3.0 controllers, one supporting x4 operation
+  - One serial ATA (SATA 3.0) controller
+
+- Additional peripheral interfaces
+
+  - Two high-speed USB 2.0/3.0 controllers with integrated PHY each
+    supporting host or device modes
+  - Two Enhanced secure digital host controllers (SD/SDIO/eMMC)
+  - Two Serial peripheral interface (SPI) controllers
+  - Eight I2C controllers
+  - Two UART controllers
+  - Additional six Industrual UARTs (LPUART).
+  - One FlexSPI controller
+  - General Purpose IO (GPIO)
+  - Two CAN-FD interfaces
+  - Eight Flextimers with PWM I/O
+
+- Support for hardware virtualization and partitioning enforcement
+- Layerscape Trust Architecture
+- Service Processor (SP) provides pre-boot initialization and secure-boot
+  capabilities
+
+LX2162A
+-------
+
+The QorIQ LX2162A processor is built on the Layerscape architecture
+combining sixteen ARM A72 processor cores with advanced, high-performance
+datapath acceleration and network, peripheral interfaces required for
+networking, wireless infrastructure, storage, and general-purpose embedded
+applications.
+
+LX2162A is compliant with the Layerscape Chassis Generation 3.2.
+
+The LX2162A SoC includes the following function and features:
+
+- Sixteen 32-bit / 64-bit ARM v8 A72 CPUs
+- Cache Coherent Interconnect Fabric (CCN508)
+- One 64-bit 2.9GT/s DDR4 SDRAM memory controllers with ECC.
+- Data path acceleration architecture (DPAA2)
+- 12 Serdes lanes at up to 25 GHz
+- Ethernet interfaces
+- Support for 10G-SXGMII (aka USXGMII).
+- Support for SGMII (and 1000Base-KX)
+- Support for 10GBase-R (and 10GBase-KR)
+- Support for CAUI2 (50G) and 25G-AUI(25G).
+- Support for XLAUI (and 40GBase-KR4) for 40G.
+- Support for two RGMII parallel interfaces.
+- Energy efficient Ethernet support (802.3az)
+- IEEE 1588 support.
+- High-speed peripheral interfaces
+
+  - One PCIe Gen 3.0 8-lane controllers supporting SR-IOV,
+  - Two PCIe Gen 3.0 4-lane controllers.
+  - Four serial ATA (SATA 3.0) controllers.
+  - One USB 3.0 controllers with integrated PHY
+  - Two Enhanced secure digital host controllers
+  - Two Controller Area Network (CAN) modules
+  - Flexible Serial peripheral interface (FlexSPI) controller.
+  - Three Serial peripheral interface (SPI) controllers.
+  - Eight I2C Controllers.
+  - Four PL011 UARTs supporting two 4-pin UART ports or four 2-pin UART ports.
+  - General Purpose IO (GPIO)
+
+- Support for hardware virtualization and partitioning (ARM MMU-500)
+- Support for GIC (ARM GIC-500)
+- QorIQ platform Trust Architecture 3.0
+- One Secure WatchDog timer and one Non-Secure Watchdog timer.
+- ARM Generic Timer
+- Two Flextimers
+- Debug supporting run control, data acquisition, high-speed trace,
+  performance/event monitoring
+- Thermal Monitor Unit (TMU) with +/- 2C accuracy
+- Support for Voltage ID (VID) for yield improvement
+
+LX2162A SoC has 2 more similar SoC personalities
+
+1)LX2122A, few difference w.r.t. LX2162A:
+       a) Twelve 64-bit ARM v8 Cortex-A72 CPUs
+
+2)LX2082A, few difference w.r.t. LX2162A:
+       a) Eight 64-bit ARM v8 Cortex-A72 CPUs
diff --git a/doc/board/nxp/ls1046ardb.rst b/doc/board/nxp/ls1046ardb.rst
index 8c0bc82dde7..01654d11257 100644
--- a/doc/board/nxp/ls1046ardb.rst
+++ b/doc/board/nxp/ls1046ardb.rst
@@ -11,7 +11,7 @@ debugging environment. The LS1046A RDB is lead-free and RoHS-compliant.
 
 LS1046A SoC Overview
 --------------------
-Please refer arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc for LS1046A
+Please refer doc/board/nxp/layerscape.rst for LS1046A
 SoC overview.
 
 LS1046ARDB board Overview
diff --git a/doc/board/nxp/nbxv3.rst b/doc/board/nxp/nbxv3.rst
index 98d5cf9e17d..7b4972f6340 100644
--- a/doc/board/nxp/nbxv3.rst
+++ b/doc/board/nxp/nbxv3.rst
@@ -20,7 +20,7 @@ bools under ``if TARGET_NBXV3`` in ``board/nxp/lx2160a/Kconfig``.
 LX2160A SoC overview
 --------------------
 
-Please refer to arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc for the
+Please refer to doc/board/nxp/layerscape.rst for the
 LX2160A SoC overview.
 
 CPU Module overview
-- 
2.43.0

