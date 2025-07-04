Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B210FC8303D
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 21:00:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 111C382F14;
	Fri,  4 Jul 2025 23:00:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="2YbuLBgG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2DE582F4E; Fri,  4 Jul 2025 22:59:58 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0457E82063
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 22:59:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CThhQ6qwS5hqPo2jKLKk9fe1jqPuqJiEnp51jtV/jyAzswQN4Q1Vfwbph8dXdem1pAxNoYGXDXxL/bsvgy0K1YUsjOtjiHM7ZnwWUoH3absikWlMPAOvz9xD+yqjFyeR3UJ4lvar5zihCinLnzVG58wH4w+8IkO7lsg272JW6+9mbeuWVCsUl2RrfvAVuhzLTaeGbY56xqKomsziX96IIV3uZu/Iv1hca+X+yXUrsMre2Mp1RPpR4WRCCRiaj+/myV0lYZe1Harz+RO/wv8bum9U+q12Hwrbq5wgJMNEs+HI4re0LO2FnXYLc2WN4/BQPRi2ImjT/tc9Vh/KB/EdjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hz2kRULdgnHmhbxZkpWP8ZlkaRbW39tiT0J45ZEdiaQ=;
 b=c0+vDSnc0ho937uwY74ShI9JT0qk9qyA88AG+7IradZF3NiWM8X7VrypnZMlb4of84HGMF4fQXWG7AeM+pKn1HZ3oI8LBvuElgrzfnHKiWrRoi7rqHX7xbq7B2iHkNANBCkTS9nQVL37QoNY19oXFFlxSLMBHYe1mjOsS+KbItFKPDX9WSfBUxhlQihK6YcnYB8EIU8aqlfwIfKprvtwl0z4byK5ESwrfBwT7Tufy0y1WRDm5bRBvIjf9bBelyd3STSlXrZSz5C/D+wNBGPvuUySaVM7PtzQf8QprKzX+ZUDaBpxaUUG17dKCT8uRWWj8gtAASnkB0yVeyqovKDq9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hz2kRULdgnHmhbxZkpWP8ZlkaRbW39tiT0J45ZEdiaQ=;
 b=2YbuLBgGyKVODoiS+E0RPbEYL8hM4eOmXyEqAFUTlpOpCJK5nrc0Rc91T3Yp9wceRFd7xc6JX+aCeUETRaumpD62muXomAHFZLiUyv7GGjUTguEsB3Bv+rJ6n7l7qmmFAiqmyEgLNN8hkD3L1kIufGH8bSUEgxO1ZG1ZqdSnnz+Ngx7FKd3yp1COHl++/O1gT344LRUFUzPl1udLtjzs5JECgkSBwI9cJv9XKhUnE4EDskw7HSvQoOH5Q4Y3z0IO+i2X/qP5RgUWCw80t8Nv9xSw5Nl1r5/KNBUS+qjpbYbqF38oqToS219JPMkVW9mYSbNhoeYVMI6bCPJlemcUzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB6342.eurprd08.prod.outlook.com (2603:10a6:20b:31a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Fri, 4 Jul
 2025 20:59:53 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%6]) with mapi id 15.20.8901.018; Fri, 4 Jul 2025
 20:59:53 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 0/4] drivers/net/airoha_eth: fixes
Date: Fri,  4 Jul 2025 23:59:39 +0300
Message-ID: <20250704205943.1398968-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250610072924.1066329-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250610072924.1066329-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: cb4ae802-787b-4826-efa9-08ddbb3db8d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zVX3V8CZvGQv+je+pcV0lev7GQjgy3MV1Eeme8eKAhzuIj3zdYvgUYDfdywM?=
 =?us-ascii?Q?xWf1zKkTxdvxVGANVkZrgrTvhHIBZ4zPslepym8JL5y9zZ/yW9VaHT+GPQM5?=
 =?us-ascii?Q?kreIZziRmzXlO9FIXLCnNmQ24PNEheLNReYAGMZdeVHMALgxLSrbUcKkmnNl?=
 =?us-ascii?Q?rtj4zqbuKhYSxjn9RlhEQP6OmsD0SQeBx6OtytbLTkkkZL/jXXJtM7KPCswq?=
 =?us-ascii?Q?qKefX+iHiQfzEWziW+8+c+64EfMrVsZsL6XTMGyRy6PgV5NaqM+cGJsa4H8r?=
 =?us-ascii?Q?hHwLDSPo/VqeQxftOtnEBUcQx0OLfqjYz0PDRR1Y5XT5sdyKSXiXH6nJkiEc?=
 =?us-ascii?Q?qlMoAJs9G7iL9TnUGo/5pOP5vSopN8trqwdSmv/WhhJSancODwM9p5HkNaz4?=
 =?us-ascii?Q?7lkcpbMBOZp7H9f68OG4PXsc/hH0J6PvH1P65SqXChLNqJXJTBDJrTRakHma?=
 =?us-ascii?Q?9xpj0DhNkUbwwB5B69KnAnGUWIxv578pva//oJSXmHyK/0Bx5XZkPvSWr1RY?=
 =?us-ascii?Q?Ly+CiyFwkk3D/nTLaEuYV80ax/boC5aT/9Dz5T8T1gljBX0H6/IX80vHrs/f?=
 =?us-ascii?Q?NoBkExXlLrDyHkHUgPk5Myq8QU5LHFVqNh1HBNfnmcCJYsoAq8c4bpL/ULp2?=
 =?us-ascii?Q?aZ2oMkdjbPeWrVtlrKPKAvs1xTdhPSp8RRSfiJXkakZmiETPxABsr9xSwkmg?=
 =?us-ascii?Q?jc69AemMv0Yeada2MqNxR4epedW2DRiJoJhBZzHSX5e361N7gNOSdaVVCd7+?=
 =?us-ascii?Q?3hjwPA5kZhj+Xvv0vJn3SVozb8mgGAowTG5GoUheP7agsAttcXEGTzBFYUUF?=
 =?us-ascii?Q?Ge5kttjAs8lZaGD3cHMr/Qs7tDIdVZYr4SjtYkv7SsJ7omywoBDG9cHlUckQ?=
 =?us-ascii?Q?AS4ZGu1a4PKuQfcNnel+v9Gn4adfTKbn4HaIgsc8AM8URdSopPSfdYjPis+5?=
 =?us-ascii?Q?u1ut4k/Lqe5cGLppbJgFEggzQkwyR1wMOTSQ8PVvhjurted16jNefXB+d6QE?=
 =?us-ascii?Q?0nhNP8ZFImg9/wedckv+ejM3rjf7fIMD0/wN4tSEQMXFMGo8n4k/2Ho3d6Oh?=
 =?us-ascii?Q?2WqjhGaZA/mWam2csOiARIoPe578+Jahqw2Yp1Ymx8Z8TojTQ+FsLkgJipHy?=
 =?us-ascii?Q?yx2LfS8Nc2A+x8rL8EqWSxo+NucEwMPVAmLyc7gkw7Qn4ziRdl6266gW7I6b?=
 =?us-ascii?Q?rIkIqe1m2tlNVws/sLr0fAwDAAhSjIG+oh+r6kVs1lLpBARm0Q0VTXa70QfY?=
 =?us-ascii?Q?zd6LGh2USYBfXnCBt9j2YQAptPE0+rIr0rNkjgS1m8vC/+IXtOjl3LcbKjrl?=
 =?us-ascii?Q?3ut5iWz6Ol3j6pbs4nsAwtsC/6KbDi9G3kVqNs41Yg01lm7uEuT09L0SkEIB?=
 =?us-ascii?Q?nQ4GaVhhxhzMzkZHLoMPRw7Gwlb7vQjlff4F7LhU/Ylgo+A4DO7y8mzShmjw?=
 =?us-ascii?Q?AykO/ffijg84k/zEQ0oNdQ1Sdw9SMAvgL1ZGKn3aPg6uPJpgae2tNw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M52pqPDmWx7amZeOyeKdJ9rgjFBWN1dCqXJMdKuN7GM/L6XLQ8ijBd0PwaFJ?=
 =?us-ascii?Q?0LuH+6xlWHDXaD9d36E4z07YYE1burzO0ir0BEkcd1i54uFuT3cPZtlkM57c?=
 =?us-ascii?Q?lLtkgBs+V9hTNYorLEOy4IWedPCNh0UfyXFR8YsuOi92ToXduQ1rT7+wK3h6?=
 =?us-ascii?Q?DDJHokTovWukzt3C1Acoh5abkWjsgojvBQHnOT+1YuyxEv4PJqtDJTM8An0G?=
 =?us-ascii?Q?qOasve121nt/i76LffCLOY2e/JtBQg7cEhGQpzZlO3SehVsebzozvBhC1zfS?=
 =?us-ascii?Q?xFwQIrrw6Q8a1amLBAqZe5FMlF9XS4S0M8PZqwj+bmKA5s6R2BwbnEEmlk1Y?=
 =?us-ascii?Q?pyVx+CqdaaJH5XHP+BBkZu8rMDfCyJ85voAxiqcWQ2vdw5L4ws91il/gNz9m?=
 =?us-ascii?Q?8aGpTbY6aZ9W0gcNaxhip9+jw1F87fHEwwJfaMz/a19kgLnQzuSDKqBhllQ2?=
 =?us-ascii?Q?Y8qEq8lSp9UTFRbFLIMeYgFkAPC3eX1itVi9shnhRxv/FmMN3wbdy8bFsTgR?=
 =?us-ascii?Q?oBYLq6JIlqTl4F4KaCREXeh5lRW8KpnUjc9uqYnHlMEhKm6xeRGnzFg1b0nt?=
 =?us-ascii?Q?UCO9laZaPN7PCxhwZ8vkfl2fb4F7hCeKnWlCUdlgayM/VEAy44Vr4jLVDAeY?=
 =?us-ascii?Q?fz5aiusaqUoZPkhnAAAPXY3/APUw6+194xlOkC4FLH5wPclvGYFFCM23i074?=
 =?us-ascii?Q?0YwwSGrE7weHuEcaCD1xNFWbgMHK2KUdkBQqNpNxSCdeseEMJmEp46z0kG5M?=
 =?us-ascii?Q?olBobxUU8Gk+W4Tzj45kA5m2sRIpwo9xn+r74SL2OHVBAfj5p1eOD1N6iv9n?=
 =?us-ascii?Q?hlbuehIvT2KXmpc2evk4EghSM/oe7CVbSXUQcZ22Amkd654CB2zoTxiD2lsJ?=
 =?us-ascii?Q?oyM+Dq61LPdLyeakBievqL6Z2ppUiNEuQomNwfV7QDLkpkkH3LbfBtjgvbk1?=
 =?us-ascii?Q?9DvTvLgMLszqBipuMjPIsIsoat5Qj1JQWiR3vtStNxIcVvepogQIILIFQeul?=
 =?us-ascii?Q?ddQFuNhHP/hG1+xLIM+r5IdeI32CGvjGG68XmKcwgwg00ROJJHZ9Zd8K6Mf3?=
 =?us-ascii?Q?/Tbpsn6+jaXG/6T5qNc7asMziiMIHROx/QAGhcyF+SvipTdNPpbhdkuNLEjg?=
 =?us-ascii?Q?9TQmmJ/xy4Yh/nLDRTreoa4Ae1dJ09R3SYB1wv7LPtbIXh7W4zi87s0pj4lW?=
 =?us-ascii?Q?GFk9scyVF77zQMJ+OUCLsWsICeTGNC7rulZzQ8LvVoakbcJkBUnm6B4WkS9J?=
 =?us-ascii?Q?hzUi9Yry9Ol5uEPS5xswsZbdKPQp2CyYMdAddRpgLlgHM6kux5kVmZbw/hjg?=
 =?us-ascii?Q?N8kRFyE4j5wAlqKLoXB8MDNMheqZkxI5mkFyTJOmXK1ByXOKGMAvpFYXLRaU?=
 =?us-ascii?Q?Ii35YqXqo1sFyQBrgVZ+jfTzyVLVU6WtLqp6bcjzpKp6B9oQiqulWa157ZPi?=
 =?us-ascii?Q?wG7YWU7SNwVRF5E+cFQkyeVC75Wp9ebeyWKKTr72Onm8g7ioD7FxJoijWig2?=
 =?us-ascii?Q?7rqM9oanQrEI/o6Sc0AVb9faGqD+Bpn0e9sRJ0nHSNubYY258ou2D62WqnRP?=
 =?us-ascii?Q?Dcnn57Wjsy1MRNfEioUp1AMWk2bhfYzuKn00bLkjQ8kStJ9vYOXo5PSXOWO3?=
 =?us-ascii?Q?iqzHTD4Mx8X+9iv48OqrZ5A=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4ae802-787b-4826-efa9-08ddbb3db8d9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 20:59:53.2799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4dKDdcvqX6gbY+tJbS7BcT/JqUFGUp6377SqcTNsAcvxomIm7VtNqYDwhkZkZ2UwJ7OCRvwZnYHqKnYagjkdo1y68Jbh+elMwzdoT81+ZL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6342
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

several fixes for airoha ethernet driver

Changes v2:
 * update patches description
 * improve formatting a bit

Changes v3:
 * national letters were replaced with the corresponding english letters
 * code was tested on 32-bit and 64-bit airoha boards both

Changes v4:
 * fix transmission of short packets (length < 60)

Mikhail Kshevetskiy (4):
  drivers/net/airoha_eth: add missing terminator for compatible devices
    list
  drivers/net/airoha_eth: fix packet transmission errors
  drivers/net/airoha_eth: fix stalling in package receiving
  drivers/net/airoha_eth: enable hw padding of short tx packets

 drivers/net/airoha_eth.c | 82 +++++++++++++++++++++++++++++++---------
 1 file changed, 65 insertions(+), 17 deletions(-)

-- 
2.47.2

