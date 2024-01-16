Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8ECBC47077
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 05:55:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B361871CC;
	Tue, 16 Jan 2024 06:55:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="qoXcRe93";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A94F87214; Tue, 16 Jan 2024 06:55:08 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D72F886308
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 06:55:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1705384505; x=1707976505;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Gd1hlRK/O5675OcV1sVJ2XpIJIio3RUYjTWw3ZFhoFE=;
 b=qoXcRe93SASjp0RsySyt3qxvJN5xkRWFo/OIObeUPpdkYUiWv3p2DjAg6K3sfLZV
 mm4a8lxUPt8WXo+cMgsvIkAh1xkAmh5XoqJh8hr1l8sAR7T5IxdpdqvwjoaP5ZiW
 J6ZXDix+vrVzlB8C9/p/jaDySu6Y2aKJMbKWPm5DMIo=;
X-AuditID: ac14000a-fbefe7000000290d-f3-65a61a3903ba
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 18.B8.10509.93A16A56;
 Tue, 16 Jan 2024 06:55:05 +0100 (CET)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 16 Jan
 2024 06:55:03 +0100
Message-ID: <a6dda694-7451-4725-8fd7-bffb7498522b@phytec.de>
Date: Tue, 16 Jan 2024 06:54:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Upstream] [PATCH v4 0/2] *** Add support for phyCORE-AM62x ***
Content-Language: en-US
To: <u-boot@lists.denx.de>
CC: <nm@ti.com>, <trini@konsulko.com>, <upstream@lists.phytec.de>
References: <20231220091811.80373-1-w.egorov@phytec.de>
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20231220091811.80373-1-w.egorov@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsWyRpKBR9dSalmqwfylYhZvfpxlspg6aTO7
 xdu9newW3e/UHVg8Xh1Yxe5x9s4ORo/+7hZWj+M3tjMFsERx2aSk5mSWpRbp2yVwZexfso6x
 4I9Uxc5r6Q2Mc0S7GDk5JARMJLY//8TYxcjFISSwmEli/9IdTBDOXUaJ921TWEGqeAVsJKbP
 m8QMYrMIqEqcv/yZHSIuKHFy5hMWEFtUQF7i/q0ZYHFhAR+JqW/OgcWZBcQlbj2ZzwRiiwhI
 Sbzs3MgMEXeUuNf1ESwuJGAu0fH3IVg9m4C6xJ0N38D2cgpYSKxf+giq3kJi8ZuD7BC2vMT2
 t3OYIXrlJV5cWs4C8Y28xLRzr5kh7FCJrV+2M01gFJ6F5NRZSE6ahWTsLCRjFzCyrGIUys1M
 zk4tyszWK8ioLElN1ktJ3cQIigsRBq4djH1zPA4xMnEwHmKU4GBWEuGtvrMkVYg3JbGyKrUo
 P76oNCe1+BCjNAeLkjjv6o7gVCGB9MSS1OzU1ILUIpgsEwenVANj79LOR7x8cU80c4+FiN5l
 m1uUe+9xZN50qcsT2e5Y3okV2zKB+YvjlEKD2v03PiwvD5otYLSnZYP53qmHpzWIP/jsFbWr
 ZN+yafvfd20S3bVf2Piu9aeQnweV/QQfaJx2/zV1+0v9X2LPnt0vl5rW9Xcv74ESrevbXJ7Z
 e+sW3A/uvCmTYzrnpxJLcUaioRZzUXEiAPCQipF5AgAA
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

Hello,

is there something missing in this series for it to be applied?
I would like to add support for a 2nd k3/am64x board based on this. So 
it would be nice to know if I can do it the same way or should wait for 
more k3 changes to come in first?

Regards,
Wadim

Am 20.12.23 um 10:18 schrieb Wadim Egorov:
> v4:
>    - Rebase on current next
>    - Drop schema file overrides from binman
>
> v3: https://lists.denx.de/pipermail/u-boot/2023-December/539779.html
> v2: https://lists.denx.de/pipermail/u-boot/2023-November/538971.html
> v1: https://lists.denx.de/pipermail/u-boot/2023-October/535750.html
>
> Wadim Egorov (2):
>    board: phytec: am62x: Add PHYTEC phyCORE-AM62x SoM
>    doc: board: phytec: Add phyCORE-AM62x
>
>   arch/arm/dts/Makefile                         |    4 +-
>   .../arm/dts/k3-am62-phycore-som-ddr4-2gb.dtsi | 2190 +++++++++++++++++
>   arch/arm/dts/k3-am62-phycore-som.dtsi         |  324 +++
>   .../k3-am625-phyboard-lyra-rdk-u-boot.dtsi    |  166 ++
>   arch/arm/dts/k3-am625-phyboard-lyra-rdk.dts   |  266 ++
>   arch/arm/dts/k3-am625-phycore-som-binman.dtsi |  314 +++
>   arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts  |  119 +
>   arch/arm/mach-k3/am62x/Kconfig                |   17 +
>   board/phytec/phycore_am62x/Kconfig            |   33 +
>   board/phytec/phycore_am62x/MAINTAINERS        |   15 +
>   board/phytec/phycore_am62x/Makefile           |    8 +
>   board/phytec/phycore_am62x/board-cfg.yaml     |   36 +
>   board/phytec/phycore_am62x/phycore-am62x.c    |   59 +
>   board/phytec/phycore_am62x/phycore_am62x.env  |   23 +
>   board/phytec/phycore_am62x/pm-cfg.yaml        |   12 +
>   board/phytec/phycore_am62x/rm-cfg.yaml        | 1088 ++++++++
>   board/phytec/phycore_am62x/sec-cfg.yaml       |  379 +++
>   configs/phycore_am62x_a53_defconfig           |  115 +
>   configs/phycore_am62x_r5_defconfig            |  130 +
>   doc/board/phytec/index.rst                    |    1 +
>   doc/board/phytec/phycore-am62x.rst            |  158 ++
>   doc/board/ti/k3.rst                           |    1 +
>   include/configs/phycore_am62x.h               |   15 +
>   23 files changed, 5472 insertions(+), 1 deletion(-)
>   create mode 100644 arch/arm/dts/k3-am62-phycore-som-ddr4-2gb.dtsi
>   create mode 100644 arch/arm/dts/k3-am62-phycore-som.dtsi
>   create mode 100644 arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi
>   create mode 100644 arch/arm/dts/k3-am625-phyboard-lyra-rdk.dts
>   create mode 100644 arch/arm/dts/k3-am625-phycore-som-binman.dtsi
>   create mode 100644 arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts
>   create mode 100644 board/phytec/phycore_am62x/Kconfig
>   create mode 100644 board/phytec/phycore_am62x/MAINTAINERS
>   create mode 100644 board/phytec/phycore_am62x/Makefile
>   create mode 100644 board/phytec/phycore_am62x/board-cfg.yaml
>   create mode 100644 board/phytec/phycore_am62x/phycore-am62x.c
>   create mode 100644 board/phytec/phycore_am62x/phycore_am62x.env
>   create mode 100644 board/phytec/phycore_am62x/pm-cfg.yaml
>   create mode 100644 board/phytec/phycore_am62x/rm-cfg.yaml
>   create mode 100644 board/phytec/phycore_am62x/sec-cfg.yaml
>   create mode 100644 configs/phycore_am62x_a53_defconfig
>   create mode 100644 configs/phycore_am62x_r5_defconfig
>   create mode 100644 doc/board/phytec/phycore-am62x.rst
>   create mode 100644 include/configs/phycore_am62x.h
>

