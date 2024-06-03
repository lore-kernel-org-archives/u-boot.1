Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772C2C25B75
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 13:57:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEAE987964;
	Mon,  3 Jun 2024 15:57:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95C5788353; Mon,  3 Jun 2024 15:27:38 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on20718.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::718])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D85B8881C3
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 15:27:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJWIqsbymOtX+GFwucH9tt8KoobVnl2Oj930BkNYaShczMwXmyRNgqiwTfE0sZZiszMD7odTtFjGgInN1O/W6K32X2gJkxgepBuOIQORmRvD97oDcMc5M+9esgooW0zpd23kpTZDVJ51Fym7WVGATeDHhQHiP9+McBdVCurtQYCB5UN01eD3torVYtSdRpmZr+PRHBFmdGJYCNQiKvfO5dw/5PB6FxjlHdDI+eEGsr7KWA3wTiHcipaoZG4MDtWmUOT19XtpwbD4yGzxEWiYSrzI5sf88z6/X6RxKYe1nwVX6d0x6nshvg0jfwNwPjbG/bE9nh4q/BNakwjWgAo7XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKLHtC5X8vKMsk1YCO16w9EJ226TeC3Na8AYadHxbDg=;
 b=N2Fo58K1ctA9aYqc0al67KsunKEB1fJk75mn8go1pjlKYJ7ielhetO/XaoBXQB5OlxaFEDMgS+KfS7YmL0SirZlYsgPT0ZWyncZN92rDh1CRNWF5GcechGAlKj+RUHZFPizRHzDL9j09JUwWH/4TfpdIROmtX4Qtvgpx30aF/fp9Xibpb9u/Z+tHKLvdeFQ/njrfmgKd6HnHO4O68+8PBIeoM9BFNtjOIWFcSr99bRO+Yrru0pidu6P3F7Wj6TePu9rnjbQLNfHdddOB9Y9jkRGyXv91l/chQMHBG0ufWOKPXt0sSzZCeJnKmiVKaFUgNw7LhDjMumq1cvnpQIIYSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1242.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.43; Mon, 3 Jun
 2024 13:27:29 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::61c0:a8fc:1462:bc54]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::61c0:a8fc:1462:bc54%6])
 with mapi id 15.20.7587.043; Mon, 3 Jun 2024 13:27:29 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo Yu-Chi Liang <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Rick Chen <rick@andestech.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/4] Sync StarFive JH7110 clock and reset dt-bindings with
 Linux
Date: Mon,  3 Jun 2024 21:27:17 +0800
Message-ID: <20240603132721.6522-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0029.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::10) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1242:EE_
X-MS-Office365-Filtering-Correlation-Id: 5465baff-25e3-4eb2-f33e-08dc83d0ea88
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|41320700004|7416005|52116005|1800799015|366007|38350700005|921011;
X-Microsoft-Antispam-Message-Info: dAlELAUTQP++WQzgHtAAxwDgkh3Xjt69jHgHGCT94OJ4R70onZIUoJUyDObNUM5pjuPSuBOej/ZLEZFsArQHw3SDozg9qe/euuYDzwiUETxSCM6V9E4O3wbjTX/wM5VrZGAZCZBfzhsxUdnZD0Y3H1KLzaxgJOjbnQYQ02x8Br/ugA02KRO6iz1Zef4BkcMOTdbOM7HGei2JxOA3psa3KSLks1DgP5JoGaLUsihFvLUQephqgkVX+2DDLU8P1Y2M3zuP2PGMzs3va0UfIDBXZDoudC7ULUlrlqGKpZVVgCYpLg+hYfzWSM2s0ZVd65LoorW7eD3HnjgZeQB1j/OSlABlzI9hQXnreXLVfWLpRPQBvDcyll0Jw22jGkXVPrW1csbUr0J0f4iMD9JVgPaFg06G0gkJ23EkMhcO6ZDaWXw6h2SVJN7iozxuXgI9KX6BJtluMvrqct8SYnaHmCeWfwZ4OU4O/+0KctrRhzRkLTshDJnvFSYBVMMHGSfOIYCb3EyjwF62A3KGJcboHoMIgvhoZp5QbBDrOXh1He2UzPmVbEmY32I7VaUL4IWZOhvnzqy6GmdSxVia95YlZedZqPSf1gjsClLnfYb/peyY8jyCvTAz89fcfrYK6ZydkKpb4QHIkFz03UJ+SZseUsdcGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230031)(41320700004)(7416005)(52116005)(1800799015)(366007)(38350700005)(921011);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c3MGffXyOYMb1L2E4cassbdVrj6XJc2R/fLSV4GGZ88vfLjkNf3+Odbo9xGu?=
 =?us-ascii?Q?EvF1X9EkJe6XXVol2uMigeMWJL/XSsg7qsf47sCPtAZAFwPjjbp63UzVQB0A?=
 =?us-ascii?Q?IYLc7YG09o08Q+gDA2mzFmJId6x1eHozlC/R5pxDWjj350W/JUEjyzw+8/kg?=
 =?us-ascii?Q?8qT/lTTtm3twJl4rnLWgQiz5DR5v/qWfRcH0pc0DNxKrJzcRRQpixYBNgtDM?=
 =?us-ascii?Q?3xjgZLHeg6hOSDvt9AN5KCCx33Bt2Tns1s3s59s5bud0SGPC5gCb964igrTP?=
 =?us-ascii?Q?SpKSYQC506ElOJkzZTQBM0xXYYxTSQmfY9N3Xo8YYQ/z+32kjXxdT3t5A/FG?=
 =?us-ascii?Q?GUfFEQUQNt9Ff67jg5Ixz/SD7YCf8Cp0PCDwwlWvNmyllki2AJEOfDOqTr5I?=
 =?us-ascii?Q?LtU/bRZOJOAyxnCYjOfOEpKGwbU2YPSVDsB4W5gZfb0RvemxI4W9v/W3Mnzp?=
 =?us-ascii?Q?azKmN9F1ZHtHrHnPdzu2Q2vgIRkX/ffwRRoIl8DwNWo/dizeYqwVhwviQr7c?=
 =?us-ascii?Q?ZdEzxFuCpXnP76AYxx2QTM61O5w3489MmcqrkOl4/tzn6jqpQXjAf21JGbAo?=
 =?us-ascii?Q?bjXImAzz8TqUL5RPLmgto1UNsNM7pxZz+fkwmm+NIiG5Kvz1NkA4TQoSugPn?=
 =?us-ascii?Q?mFm5FXJoiVNhrOUXB98UwjiFVWVvs7kXwBClVj3lTY9fL3pbks91mrfFuPK5?=
 =?us-ascii?Q?IGbgGBU2XdON5lIU4qz1AZmxpDDkpiqaNWij8mcTrmPyHhzIQfbhRrNSuAbq?=
 =?us-ascii?Q?rMQ0btatNNWcai8HYRF26kD1CY++ud+BckHt5PE1P2IfjKtRnVKm0nCaXwmR?=
 =?us-ascii?Q?GR1qKXIrpgek+RRyzvbD6rDn3yDxwQi3/SjpUPRwiUfh70dal1MgkAnFe349?=
 =?us-ascii?Q?x6azrvvIvVxp1190xqj9tQvaXzy2ejfJFF/uAIBidxDZVNK+NU2oBXZNzbDM?=
 =?us-ascii?Q?/ad0FuK8vP8TwrYD3iVz5B/W5eP4BWG3bthz5iNw9Uou6mxmMT0VuuGPalLd?=
 =?us-ascii?Q?qZOXPKI88DSZRL5LhA/dIDNvb54yekEYallnqwQYUF6MqnBLcxmPDDYx/5PK?=
 =?us-ascii?Q?6d6/GroBTMhGia8baYc64AGFYeuFSX3p7teSBQdl8FCsq9ZJCly+4wzpl/om?=
 =?us-ascii?Q?tEzSt2UWqK16+kFRair+PCeDeyKBaLDNXwDyblkf4hzvTi92qv/I3oeZBPxX?=
 =?us-ascii?Q?wfcJFSQaNgNUAMdZHP0OwHNDMp5mL+wBCaILKyfhsZHNCKLNMxA1KwPKYnwl?=
 =?us-ascii?Q?jyCDp+yzKZixLBhgNV0K6uJz5TQ/YrpIOwRK5nZ3Gdmw6HqFlCJxftsnGL3t?=
 =?us-ascii?Q?wdKg232gVVNtLYI8X4L3G/a39I7kNh24/bomeKPpd5+U6MgUvkldpgCYcYO9?=
 =?us-ascii?Q?Sgg7vW30P3fT0OEfW/J12hwMfIBUvbjswSq01XhhJTdMa/T5p6iXOQo4ReQt?=
 =?us-ascii?Q?omdtSvYUMmaXpkMo2eNopuLLBJnhRM+MQE36H+aQEqVFreuWTQN4lFhnThDZ?=
 =?us-ascii?Q?ZMWdDbo5hDBNOgi6CxYZ4BKYmxVl5SZhxDM20GhsI7amTwuOyAQQz7zbbpNu?=
 =?us-ascii?Q?2eSUldJIWfoMaOEkE5O3RqagDSQl3hQ/SXZFYp0WtGDc4umpL7O0Rogd2NKE?=
 =?us-ascii?Q?8A=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5465baff-25e3-4eb2-f33e-08dc83d0ea88
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 13:27:29.2161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jzza0ra5bxVweVyABS5xt+ZjLeJ88e3D+gZ1LKI/8cqqHsYzvBMST/HwV3FumKmg9gagHHw87wdGyfVapQYX6G+mYkGZDApqWIC0F+4+b6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1242
X-Mailman-Approved-At: Mon, 03 Jun 2024 15:57:36 +0200
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

There are differences in clock / reset dt-bindings between U-Boot and
Linux. Sync them, so it is feasible to use OF_UPSTREAM for StarFive
JH7110 SoC.

Hal Feng (4):
  dt-bindings: clock: jh7110: Sync with Linux
  dt-bindings: reset: jh7110: Sync with Linux
  clk: starfive: jh7110: Sync clock definitions with Linux
  riscv: dts: jh7110: Sync clock and reset definitions with Linux

 .../dts/jh7110-starfive-visionfive-2.dtsi     |   6 +-
 arch/riscv/dts/jh7110-u-boot.dtsi             |   2 +-
 arch/riscv/dts/jh7110.dtsi                    |  28 +--
 drivers/clk/starfive/clk-jh7110-pll.c         |   6 +-
 drivers/clk/starfive/clk-jh7110.c             |  44 ++---
 .../dt-bindings/clock/starfive,jh7110-crg.h   | 180 +++++++++++-------
 .../dt-bindings/reset/starfive,jh7110-crg.h   | 144 ++++++++------
 7 files changed, 243 insertions(+), 167 deletions(-)


base-commit: ea722aa5eb33740ae77e8816aeb72b385e621cd0
-- 
2.43.2

