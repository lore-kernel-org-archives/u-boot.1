Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511EFE6BF3B
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 22:07:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1545F8459E;
	Fri, 30 Jan 2026 23:07:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="1uhDLfju";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2781284564; Fri, 30 Jan 2026 23:07:04 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3C1584581
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 23:07:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PYn3QqFNb5CmEKYbOWrIz73ocja8V0eT3T2+7djF9R/TcLab7u3djUfFMZxw/lqd7ivd+jNlv2kWnPzkBxOF5t3YUCckOpAzX1aZODAHuFJcnQK1jCiprspqqYsFjKVVC+0xO0TvlX7q4vDAy0KBKNl+ECxF+J8M7AR7og4UWj4gO/6E/Q/E9vZLEIDvzv4iar9efdcI8uxNy9ScknG9BgeStFNM2RIESMA9M5MAkpu0iCQIzXJJj+GOav7+P4SgPuYUEeEcmwuWgfgnft8iq7KE09Rp53VbS6D90F7uUSqxfK0n8Eby2DZGjRP2HLCVr3COFijLKA6EkG0GNlodYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWlAJmd5QYHKkbhaeSJkXMadjwIDK8qvFa6aXxz14/I=;
 b=ys3WJVhO6YQP5Q+EBZvcfTw3CgFTCUBnEy3UoSPrBel8HOpuG3Krur40hSW2hVzatoBYDr3s40E3g34jAmC5VNev7xY2apGzg284aiVU8EInE/lbuusxhBsCd0plksyn/GDJpCIA9TNGYk7RoOZ9sr6N/XWeaE/0ovXogWqomCjd+y+M/SSwwKKaqjROQ7h461XHzWlWjxrSRzmSbdhLgIxi7P1cPXx92gmyvwUXjQj91aIy1k8LWSDm0t+kmlUlcqsY7doIDSKJJYM/1OOv3LMHyfM8JMiYDhKn5BCxKcF7WVFklW8rMdoIHmcM4z0zdRfAdoHShq6toMyUz7KpPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWlAJmd5QYHKkbhaeSJkXMadjwIDK8qvFa6aXxz14/I=;
 b=1uhDLfjuJ/P1FHRN2d+yDFwnJS6jpBHHLUWHRC4f1J+rJ6Y6UZgPT8OcIhhVGxOdVBJe02sd6MdNJf960Lhe34QhAspG3GzqjDsEqeim28bM92ROCSSE32+UmaFrhjH98QxdFJvAf2jAgZjp6trH9Ab33tvkdAMZp+Lsj8Q7znrtG6851v4vrx5CiTEcxOjZj8E5s1jSIuYESOC+19A39WwzXiSVh6GH8LB1Kiv3tGD5Y75VMNA5IymtiGiXZZ0mAN1SLncG9FCkYaOMC95H8xc4RjGWZ2MsUeYdh+I8lsAbifQRipAyKYBfPbXXDlVyOefKDXraoiJo6hrGqGx38g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DBBPR08MB10697.eurprd08.prod.outlook.com (2603:10a6:10:52a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 22:06:58 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9520.011; Fri, 30 Jan 2026
 22:06:58 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome@forissier.org>, Ray Liu <ray.xy.liu@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Yao Zi <me@ziyao.cc>,
 Robert Marko <robert.marko@sartura.hr>, Greg Malysa <malysagreg@gmail.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 6/7] configs: en7523: add mii/mdio support
Date: Sat, 31 Jan 2026 01:06:28 +0300
Message-ID: <20260130220629.4040550-7-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130220629.4040550-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260130220629.4040550-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0002.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::7) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DBBPR08MB10697:EE_
X-MS-Office365-Filtering-Correlation-Id: 579e19d9-01ea-4718-1c72-08de604be2d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|52116014|376014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YzrvcCckqHdKgGy63t0sByHP/kEVjuFT8G7Jwkq7lnGQkmFhXf0k08O2ZMRn?=
 =?us-ascii?Q?eMnlQikyy7GuTUig1xhp2TCzFJYAiwPRV+OCzKQKnKoNSBeCrAPU3ixSm07e?=
 =?us-ascii?Q?zAcH/JSFdL1WpCdgkcJsBXvR3FA0kmdh562Belsiv9TmwXoem8RmxYvP92EI?=
 =?us-ascii?Q?Dgtr/ncC8OpdzVPzcmkNTYNQl7GjIjtavX3KLhdWdCzuiToEsFZ55YDnIPst?=
 =?us-ascii?Q?Pi9W5fFE2GVwsUOzuPWbe12em/5xlphx7PdDWqCTUyE38wFL3+oQSbMV1CCU?=
 =?us-ascii?Q?ZMyme5vFixp9YUj3fs2Z44+1tAmkEGgh9JX0VHWttl2Qrpe0CTu4/au3zsUd?=
 =?us-ascii?Q?R2f5+JUZwGjj3WH6JvwiOZBRoFWrYCj22Uk3MSUk/5ln1ioUWnj+6+mN/Pzy?=
 =?us-ascii?Q?8kwAle3p+rRwKLBWn62ibIA6eVlVE/jZVDHRUeBHmLS+IplBhuLuc+PyyEvR?=
 =?us-ascii?Q?9fVxH2nA713bzi6OKa/mLh3xijtKo1ZR3YKBaGBw35o0dTPJs0QMv6VyV8F6?=
 =?us-ascii?Q?rcmLjflW3Yz0tN76TyAu7SLGouQBaKyWtCp4lUaHlPjiC7GJ7VwbUBRvfuFZ?=
 =?us-ascii?Q?3BDC0bueQHlCeWMVvAnz4A+hC1/ILM6AbZtFzqG4x8mRXIoKZxOycW0Q8jrx?=
 =?us-ascii?Q?Q8RuTQXHhyMYDHXsAdCI5LiO6GfW4qujmOkE/5bDrrEMWsbRa5CJlBLi4XTU?=
 =?us-ascii?Q?WsYAC40OaIBwZSv/4Sg//SElckqOo90TY5iRFufLIbVi2hyRZfWRTCwwotDR?=
 =?us-ascii?Q?M54QiBicsNZm7miCWVID3hYRSo6C4log3m9EIqb0DmhrquZMpmBFnP1KuAX9?=
 =?us-ascii?Q?ingrYvXPjdxkL1xsmtAEH9yFSFsnGbZGlUgzK3I0XygC2b7ambk28UMJm7uM?=
 =?us-ascii?Q?p8crGLek7msgol7cNOSBve/5UFLfzy30Xrorq+bmylqOyRxCBYn1XAkHzt/x?=
 =?us-ascii?Q?mDOhyYNHyb/zgpEyzluxSBD/SCItLBO/qUxMEaQLykQnndQOotYhk2W2bf5G?=
 =?us-ascii?Q?Mp9hH+ddK6aoy1U8KEGH78IfG0kjMqwXETlwrd5oiEL/8jda9WKtkcRGphqk?=
 =?us-ascii?Q?4r28BUerLLczinI5cpkbwGMfWqDxboO4v6HjEcIXjUBMVowZven5XT4mq6Vi?=
 =?us-ascii?Q?XkhNWjMnIEO0W8PgXYlsgutFFUrjy/jwYK/SZw10mpsCiYl9GkxxtFh8kW01?=
 =?us-ascii?Q?v0gSTvBPAgrRC46rJbB5J0dnLxSdvJQnqUmncN4EGJl7qo5Km8LS6Nspgy1Q?=
 =?us-ascii?Q?my1DkJjdLgwF5f+FgMVmk48gAUdJ/O/Dz0gEJA63NblIec4J4F2ltmXYMHsm?=
 =?us-ascii?Q?J7TK8YRnIuik71kEiTMf6fmglI9gYmBweXZ2x0uSIgdE37u+3WvZxaNcb1aF?=
 =?us-ascii?Q?MMIJRfwqsUsI0fko+DauC3B9ds3OYuX/re7z8noxh/vXUvPMlusynjjoqyEk?=
 =?us-ascii?Q?InNpBE1gZvKf29ICkXFXAm3m4ticdySHbASBssIWfzz67gBQnWQ8IfRXhlR4?=
 =?us-ascii?Q?gj4Xze5NwyjhLsc8gYPnq92R8IXTwCEJy271+o3VuywVdPnnAVCoo4joXaQE?=
 =?us-ascii?Q?IrtR6W39aZWk+zzGiXeAIGWyIKrKPTndNTheXTRiS0EburGJXnoFFtIGwPe+?=
 =?us-ascii?Q?30zuV7qa2bLzcsdRdHhdEI0ZiLed7z+D5zPFS2qx3xUe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h19tVUX8J3l2VaM2Haf/bob4+roX6a+8bVr7gRGoReLuvkSYWsukftgzRWvG?=
 =?us-ascii?Q?l6+Gz4IVxcPtxExyBkJPeYRcGli7CcVTgZ+Vt5vKvi24DcdkAH21OwtPyFt3?=
 =?us-ascii?Q?NBR5625F/CARHfH70ozI9lq3EYMPwqjbGyXsGuw46gZNhb5flQMK2viD6PaJ?=
 =?us-ascii?Q?uSKYasD/vWsCtM1hi9KQrmKyedqbceu7iSuFT/rCPceMb+xXuVE2Ag0R5pYu?=
 =?us-ascii?Q?jzzDjS66WI/sYFSlJ13Bn4aSq8rBckzzL0XQTiqEj86SpNlfLGjs1XOHLmjR?=
 =?us-ascii?Q?ml90XjnikflKvqAK6JgHo96W95hCGYSbiKZwM7T27pvLr+280tUxwRUAAnYM?=
 =?us-ascii?Q?ZwW/eQr8iKXmWOEd361NMHyQ/Ffi72dSvlNd6Lrrgy7bXZAAiVhPFMlgyvgY?=
 =?us-ascii?Q?k03zYA0mrAHIw05XZU6JXnwu8YApDKYQnxvL4C0R+O3bt4mvHWQy27JWECp9?=
 =?us-ascii?Q?WVUTWpHB5976+j7a6ddLt7GVyG0AVEGNtzj42Tv72ZPDRv8iUcskqPrXSL4v?=
 =?us-ascii?Q?9drathNpVAtqMp3llogKuUwTj88MivbmMqWfqITNjrbx4fsxkQLc3wYy/L6a?=
 =?us-ascii?Q?HPnQKwmAROCy6R00vLv5GVf9PsVOHALwYprEiRqtDAQ+b2Jva/guv6aVfSEk?=
 =?us-ascii?Q?5zoyKZoF9qjnrUBGg+7wLnBalwdgN5EaHrVQADmp/CLRM4XNAd7aZufrBvVE?=
 =?us-ascii?Q?ie5xJUpN1fgDlZW74tMtzE51seHpGokPsSfnUAgXMmSHl1GOsvAcl0DiAY0o?=
 =?us-ascii?Q?+wUYiD3SWdfHHhYHLpZTNuidJ+q8lpzTZ81fyIUAiYLmerZ2ZfCvchJMg8X+?=
 =?us-ascii?Q?UKFO/j2VJgNKwCcFBlw2G6zp1waKj8vGRxpe6IXiM6+8C1SL6OblKb5ucnnR?=
 =?us-ascii?Q?zxNG9y1CggiBMtRUsAu3+r0jBL00MuAtfaxtu+WPejoIHcX7+sXpkL/rjQxA?=
 =?us-ascii?Q?6YuZVgWapO3SnW3+vCoxzGg6hrQTuKGgDSgdmLr/dSHwyDy0B0mSjy+pBftt?=
 =?us-ascii?Q?W8bI1q4GFhF8cS1GXdxXiN2ocOydlzjB5+TG1M4XESBdJXazBgNdDnRaGtEG?=
 =?us-ascii?Q?ixhETbPorJlg6EtWUC0H/o0E8AjUIEixDweQAbe6LHwU5qh0CgtwR17tM0zy?=
 =?us-ascii?Q?dZyD6mh4HJigXW+KRMhMsxMpkMipQM3pTzyg3vAu0NeoKZwjuumgdYvckTNx?=
 =?us-ascii?Q?TKVsgrZgrwAoHMcgocGsSD2bteysqvLkoGxpzSVHfXeUViQoERc4qiettuM1?=
 =?us-ascii?Q?bUjHNtcJgMqeyQI0pIWmO0j8qgv7Spxe/LXIbauXYsCKj5o9csRauyPLWXIB?=
 =?us-ascii?Q?uMDX7RfHtmUlOqmwXWfWHhGv6p0TU6EvAF4jZ9PTWf39bT2KXdheXdtgd1bQ?=
 =?us-ascii?Q?ma7+gVpZdOK7i9g2lJskoFPV2k6HlfAtsrBlgs93bAIY7cfgQHtYtbpADod+?=
 =?us-ascii?Q?1NgKv70++nmY2dCiriEpnlWLH3PeaMdQsYtWVpXmyoXHOwVQaOmL7Se36v2M?=
 =?us-ascii?Q?b6anZp/EgtK7IxSO5x3IASYE0MwLZAGn9zPwkSFJnnzm06uyWv6LIvAS0bYo?=
 =?us-ascii?Q?040C/3Gpc2SHV1jI8Ntzj1PVrut05STiVecUH0Ih0/TcAdS3YY3d62pM4l4q?=
 =?us-ascii?Q?FryV8TSVEnjhnM5Qeq2j+guGeTxSyP/fBzf7CDy2rZBoY9kZyZSUYUerVEN+?=
 =?us-ascii?Q?E+e5g7renU8G66XEOMapAKP3MNashK/y5sDC0wyDA4Mpx1OBTopwvAPnMrsj?=
 =?us-ascii?Q?2rkBhle6U7N3QEOA7S3h3X8zJnkpy7M=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 579e19d9-01ea-4718-1c72-08de604be2d5
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 22:06:58.0282 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LbgwmSLgvb0hl6/OEyC+tL/GyKtNA9SIh0x7085WfFAVFQJ5a/tFgOgWMWbjCKrm9Y0+XeieNBcvZqvVYOyngxMpeWDDuiGfXoTjDyg2rG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10697
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

This enables mdio/mii command support.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 configs/en7523_evb_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/en7523_evb_defconfig b/configs/en7523_evb_defconfig
index 113ddb46a7f..ebd99d133c9 100644
--- a/configs/en7523_evb_defconfig
+++ b/configs/en7523_evb_defconfig
@@ -51,6 +51,9 @@ CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_MTD_SPI_NAND=y
 CONFIG_AIROHA_ETH=y
+CONFIG_DM_MDIO=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_MDIO=y
 CONFIG_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
-- 
2.51.0

