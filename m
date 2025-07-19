Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADB4C83F17
	for <u-boot@archiver.kernel.org>; Sat, 19 Jul 2025 00:57:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E376A836CE;
	Sat, 19 Jul 2025 02:57:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="x+i1VjmL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F899836C1; Sat, 19 Jul 2025 02:57:42 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB44E834B6
 for <u-boot@lists.denx.de>; Sat, 19 Jul 2025 02:57:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gRZd7Vgycy/Tw8ZJbxv5bMWCjJaw1mgjJmDzzef6QNXkzUPyXBfiNBNb0inPtFQwXswvbWyUfCYovjG0A+4EhgX2fLCjKM6fUzgcD14XvHA0BkqDR5dKYB8rD0gmDTIUIgekqTYDFD6deAhFjT0iCsWWMFL58Pj2T5DxPei5UjsjjEX7WUG1XIrnytTHcWxLEX06PDSLK1FZ8spfNvG57pn3vXScDaNA15HxIp4Hv21G2AYlptQLBWPKLerhtE5Z6hBwMxfM3UHr7mTLqiK32JPyeO7xxajE67ITrlue2gbK1D2ulAhz999tIeHCOalWfn4Olr6C2oHEx1Bl/NO7Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJvV7wxeZuR0/woymv3EQGwLeyLwnPledlAn157p/MQ=;
 b=n4YlHWbEw8H8DbzqOkxK/tmHy6VwWp69fsdJzFtoqqBiwacoDZr0YXQxjJmkmkv1XJFxoz9x7eVa6CsN8yGrzPYa/Rtyhod2HxRaRsq7oDlferi/gceJv1GX1qVTJv9D3OqcwxVVQUBl71uNY67FoeO9HSw4pvli1mj/aXc7Vd8nCnlnkYAG6VIXiZqPFOv4fuUyMSI06teX3iBUB44WtWQRo5o04pcvnD/vG5zHRO5nV3ls33YE5tKm2Z4RyHt8ZznSe8e7isXEPHI0ZPpBOx8QsMS7TrzpSUAYsdlr1qZdLi2uPNZB+/NMhfSUmQdb1mueIPaqH5FAdCHoeneZ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJvV7wxeZuR0/woymv3EQGwLeyLwnPledlAn157p/MQ=;
 b=x+i1VjmLvYKEnkHz4x94VWEvIYXXWbHv+d+lJklRKYD2ecZLn9I2xzGfz1H5wTGr+qmTEmTxJZqkCuiyERD/8XJcOneK4WtGM7S650taymFJgbpB4kKTyE3DM6vUE+BNUSOMKRKQkklFPeCFugYLEgwvIilavi0lTXF6dZYgHDwMCVUQ8x6z9ZRdS+Y0pVld2CTRpdNWtC1lw+wZ5lVOOBAqsIwKGWkrarEwW4W/gyPHfT2AZEMg4TLUXIs5Z0nOGH9RbqeOsm3ZPczxAYcOfiCs4z22YngfgAnbnZ4gHhdMt5lHmjPp7lNKZq43ioq08k+KWFUluCrJciuLnkZlBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI1PR08MB10218.eurprd08.prod.outlook.com (2603:10a6:800:1be::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.39; Sat, 19 Jul
 2025 00:57:35 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8922.037; Sat, 19 Jul 2025
 00:57:34 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 0/7] arm/airoha: add support for airoha en7523 SoC family
Date: Sat, 19 Jul 2025 03:57:10 +0300
Message-ID: <20250719005717.113842-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::19) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI1PR08MB10218:EE_
X-MS-Office365-Filtering-Correlation-Id: 87d0a168-1d54-46fd-5fb5-08ddc65f3f43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OkC6EeeIJcfkSyxAzi/MFkdK5T8lng6QXMG5De8tXUJ4JxJaRLgYz7PJhTeX?=
 =?us-ascii?Q?W7Lb+D7Cu4veDtjA3MgdKAIVRSZWLxGJZgs+LS1CCVgHZSnnSqPmrEoUlsQ0?=
 =?us-ascii?Q?dgfTvOtdUMU3EI0UEw5Vvni71CRjQ8odyjng0z8LN9wxRZqTXpYxuoCJ99ZE?=
 =?us-ascii?Q?sNG/wHX3W6Wo89ms3yqU6n3eIQaoDVuo6zAI8DHulLuMD/TWbDs0k0ZnOgxY?=
 =?us-ascii?Q?QACvlG/6VuAaAY1l6EumzcEcrfXoiN1ToBZcsrJGxXlkzNj/cZGRq+P1gMUa?=
 =?us-ascii?Q?+kuJapu4EddmxRz9WSYPOy908H4Hwso5fDeYAc7Lnte3PymggyirhxUtXoMv?=
 =?us-ascii?Q?c+jRlp3Q602FnXW33Nk+b+5khiHdnaULTBDR3HyGBbG7qQLLqV0GuAAvC6Wp?=
 =?us-ascii?Q?aHFYziWMxylrJlPBPj+MVxjwNcYvyFJ3GvIMoH+cr4FT+goxTeCrreJ0RgLN?=
 =?us-ascii?Q?+7Wr5LMUSzBxHF6jupsqvDBDZ0Q+cFDZ7/v/wxHAafPC+DEKaFKNjnmCiicd?=
 =?us-ascii?Q?vaqrZI4Sp5CyyvT94PiVAXna3e15NtPinpddLj2WuogwoLZp6Oe3Ztc9y+Px?=
 =?us-ascii?Q?KFKZvWYFMreC7ASjNk+iaOJLrTLzdjGj/n09vH2ZBq06ufXjAAwSbeJEr71c?=
 =?us-ascii?Q?rawtN7pux8pF3D3aaLEdS+tmUwUilb+bSu6M5M8Pm2cN5BsHGsF7q/6G9Hhc?=
 =?us-ascii?Q?1Ixba5AaEFY8io9NJfGXGIA1H2O6HYyT+n7WmHwkIQSEzFLE/NHKeTACTNxa?=
 =?us-ascii?Q?/YXx622O+NtG6issWKbyWBpOJcjnEfFI1sZ7a1u+YhLaPOwL48UA25Z043aK?=
 =?us-ascii?Q?o2fiUzP6ILBOQ/qeddiC7w+BHnAVaGtw8InZRsngrvg49+p5MYfdmG1npX0Y?=
 =?us-ascii?Q?+peENueZWS1vJ+OPoP8gdXxzrifZ69k7Zs/GbqcWod78l+vlHZ+sCnK4Mo9U?=
 =?us-ascii?Q?RxjJdiOz5usrBRPoMTi/b+a8XMQ1LoVRrQI7bm9SML0fZAFJ8hXPF+TD9DOq?=
 =?us-ascii?Q?Bwiknwo6fXGt/fja2xNRKtfKKpuSNy0ChWse7MWT5yiFWpahBDqGnjPOGbam?=
 =?us-ascii?Q?5I1drNY3vmoWZSk2H203q3sSFjukyXSg+IWkIrbHO+Giw7jJ52cx9AHCfoet?=
 =?us-ascii?Q?xzRQodfMD5QP62kLqobDbfOAD7QYjM/8tzmCAnohes251iLG7dvf5JO0vqz4?=
 =?us-ascii?Q?94bo013BkucFq7jVvRUr9Ga6IuUhLpuCcD+t9YWDoFkTpnN80Bk046n++ogR?=
 =?us-ascii?Q?ZcaToxp6ycoXsg4B6y3NgAAtR9MbO5bzR+M0m9CEzOwRxrFG+6RwcwmiO6k3?=
 =?us-ascii?Q?lufiPFQhxe8FSB8zo0kgz7tq/ROfIIw02EMz/BkSvh5VrFQk/5H16l1CG5zJ?=
 =?us-ascii?Q?Rwea5CzRII5rcdLYgHvOWOx7lwQQur5EqHtT+Mqlgi/FprLdVvbsBnb3s1hP?=
 =?us-ascii?Q?kv3FxrHiAfaTga0r71qHGjQ9d3l85lHg6RhcCJBafJq4Mc5nmJDR4kKwOf20?=
 =?us-ascii?Q?IkNdAm+373FKJJk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j5DwPUk6hkjybYmA1kNh+QHXaf+KICxQ5LPaJZeBDHvH/DSW7JwZVxTjpduj?=
 =?us-ascii?Q?8KRPqbH7Ff28eF1N8wnI0PtouruNG6O8PlShDTqFgR8g0Rv0ltyhDNrXfH9Y?=
 =?us-ascii?Q?Ir3nhy+d+oHBQxEZsKWNprXk0OqsbK2gJBmKtItwcS/0eyWPbCvzXzcCzB1q?=
 =?us-ascii?Q?uMcLEvqCppp56ih6QH3ro+JmyT6kd8Kkt2QQMtHUVt8LhqiiBOSebbD2erSz?=
 =?us-ascii?Q?6ZFh2mpA7m4vJNaZeO9nI16yVDcvOimISw4A0Z+oHLUOcb2ePKekPfx7pz0J?=
 =?us-ascii?Q?y74wS4ChZCvv+mX58rWCCNVTvSL3EkkLJH+8s6/Z64Eihpsa739uw+yTYC47?=
 =?us-ascii?Q?e3ScgRKqj56zylXDAx1DUE1QRq2/DyIh7TqqgHuh1b+fPzQ6iJMbnVlkXvjy?=
 =?us-ascii?Q?BppzctH+TrC5lANmYQg7at7f7CtnMdjn2rj4pDtGXsRDJZqSUbOrLsc4esgU?=
 =?us-ascii?Q?E/K3RlcWybAdM4Ll+uBCK8H1PpHF83m1UVReIoFgwHz6AC57JKGb0BH6VKws?=
 =?us-ascii?Q?7MXkiZRVoQv2sdIHnxhcT0xs/r0HZjBP13Y3nP1DWNZJHffuPqG1Peh90onc?=
 =?us-ascii?Q?BAG15QpXneFVKvzvPErAdVzJUdAHPTE/SZxKtmZfvagx3DsjOUPB7ZY1dDp9?=
 =?us-ascii?Q?ZABZe3ecQGwZ3N2FH8vCiaUzbQpthPiW8945UJRJMDUGsr72pkbCM7hXRohk?=
 =?us-ascii?Q?9SoPkOIQYz3zhzOV3cS0IMFKV8HmCYNneXpnoRTe2aY3C6gAhScqsDLKWsn6?=
 =?us-ascii?Q?WuZQUH9whZTYSnLQ3oAagtfjXfu1wOYQtd5wSMoCe2z1M4MPoRz65OZyOL/v?=
 =?us-ascii?Q?hKmi6vDWdmYG45NGjBXahsUDUSds1Z6jbosmH/tcAhe88QYVVWqsDGj6nQzf?=
 =?us-ascii?Q?E4mPaFcA44YCEqgetT2mCZ/ZCAaB1E5M+xcKd6MOiumaUyhJ0JoRHt/pe+Dm?=
 =?us-ascii?Q?C/ylUa4OngOrPn5QEulwfK5EbQlvhcAFkiFtEh5PGA38Z2Z7f/Jrjxexgrq2?=
 =?us-ascii?Q?o0OgSxzgOtLUqRPEa1dFLUUxPCXRicWJikKYxW55aYGmvXoY2VWs++WyiY2b?=
 =?us-ascii?Q?7D+is50x5CICJKMdz3Jt+ij21YeOM1AsNGOeKh2lLFXJTKkkCfo5gnt3MIr1?=
 =?us-ascii?Q?XEyMPNsxLD9CH+dF+IuckzW5STHM54fsqz6kCCZEkbztFVAbvSCL4cdPjWjH?=
 =?us-ascii?Q?T1oVgL8ZJtDdN0XkgW3eene+tX6B6d6scBDMjRIzLD2fARv9q4tnp6KjrKXD?=
 =?us-ascii?Q?GBmcco9+jqMXIvNSU1Ye1WlFPB2UUwzwutP2V2k15zRDGIBsVc/cYOhCxeeZ?=
 =?us-ascii?Q?y4ZPNWojKl0BUReKvfmFJHGsxEnbHtiuKfEr3i27K3gt+CGt0tgL8fvWeKIH?=
 =?us-ascii?Q?6Gkzhy4wCr1+vc4Qq/1bSFXhOp5ZYAwpo5PjfHjm4qkhkkQwMpIbP/gc9R9u?=
 =?us-ascii?Q?/+UGptbbIXfI/tFkna0T7WH8vPAm+jtNkQ/rTjn7qXk15660pSGWTZLP8qq7?=
 =?us-ascii?Q?qBBd8tirM7NOLlNRk0mYHuMjPhwZH85Xp//xQg3sMg1cmJtwQuxatjR6rrLt?=
 =?us-ascii?Q?4U4CvoKCJf/YBy4dekRnyf1GKsmaCdzuc82p2esSJ4ZQZ9EWcn4xHn0wcZYI?=
 =?us-ascii?Q?c59ZqQxLNADd2ItFHmpCq9E=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d0a168-1d54-46fd-5fb5-08ddc65f3f43
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2025 00:57:34.7315 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VKHl8XKeFplMN5uOfjp9li143vAcLTxFUQ5lJPR/NKU1Fbmf41PlznmwVY6v7iPjvIW2rq3Tk2p6obiDniMo2gBqvguR5iHLZsyv2F544VQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10218
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

Basic support for en7523/en7529/en7562 SoCs. The following hardware
will be supported:
 * spi-nand flashes
 * ethernet switch
 * serial console
 * clock/reset controllers

Mikhail Kshevetskiy (7):
  airoha/an7581: increase the number of rx network buffers
  airoha/an7581: add CONFIG_TARGET_AN7581=y to the defconfig
  drivers/reset/reset-airoha: add support for airoha en7523 SoC family
  drivers/clk/airoha: add support for airoha en7523 SoC family
  drivers/spi/airoha_snfi_spi: add support for airoha en7523 SoC family
  drivers/net/airoha_eth: add support for airoha en7523 SoC family
  arm/airoha: add support for airoha en7523 SoC family

 arch/arm/dts/en7523-u-boot.dtsi               |  90 +++++++++++++
 arch/arm/mach-airoha/Kconfig                  |  13 ++
 arch/arm/mach-airoha/Makefile                 |   1 +
 arch/arm/mach-airoha/en7523/Makefile          |   4 +
 arch/arm/mach-airoha/en7523/init.c            |  31 +++++
 arch/arm/mach-airoha/en7523/lowlevel_init.S   |  68 ++++++++++
 board/airoha/en7523/Makefile                  |   3 +
 board/airoha/en7523/en7523_rfb.c              |  16 +++
 configs/an7581_evb_defconfig                  |   2 +
 configs/en7523_evb_defconfig                  |  79 +++++++++++
 drivers/clk/airoha/clk-airoha.c               | 126 +++++++++++++++++-
 drivers/net/airoha_eth.c                      |  22 ++-
 drivers/reset/reset-airoha.c                  |  63 ++++++++-
 drivers/spi/airoha_snfi_spi.c                 |   1 +
 .../dt-bindings/reset/airoha,en7523-reset.h   |  61 +++++++++
 include/configs/en7523.h                      |  19 +++
 16 files changed, 588 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm/dts/en7523-u-boot.dtsi
 create mode 100644 arch/arm/mach-airoha/en7523/Makefile
 create mode 100644 arch/arm/mach-airoha/en7523/init.c
 create mode 100644 arch/arm/mach-airoha/en7523/lowlevel_init.S
 create mode 100644 board/airoha/en7523/Makefile
 create mode 100644 board/airoha/en7523/en7523_rfb.c
 create mode 100644 configs/en7523_evb_defconfig
 create mode 100644 dts/upstream/include/dt-bindings/reset/airoha,en7523-reset.h
 create mode 100644 include/configs/en7523.h

-- 
2.47.2

