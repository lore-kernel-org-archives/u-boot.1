Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E650FF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:06:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D15F84236;
	Sat, 25 Apr 2026 18:06:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xAC4qgWw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E15B1842C4; Sat, 25 Apr 2026 18:06:06 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0BEB84150
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:06:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
Received: from AM8PR04MB7876.eurprd04.prod.outlook.com (2603:10a6:20b:240::22)
 by DU4PR04MB10670.eurprd04.prod.outlook.com (2603:10a6:10:58d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.24; Sat, 25 Apr
 2026 09:00:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hB4NSsoPaPbmsCxy+FAd+66n74FQR7B1j8QvVr1R6w1bTcvteKcjgANvLX+vnAcs9MTJRqcex6a36S7YhJGLJBw98UCWJ18TG7CETSoLDq4QlIlpLPoKGg/INrO7heWcO7PDU/k9P7o6C9K1X+BkpH5jTZJZGOvWNpn8yYi4JL0qhSRzJgCGE/pPy1FRKUWoqRaGod+bqNdsLVYTveLc8ylbf/bZYGf5khKhoage4iNaUNO+xwRe1RVcqeEHAFfYmPqmAlDBwpMcja7bOnR935bM1FhrHfvyGaaMzk5IIOFqCPSasHb2wcb7lnN3NFg6LKd8VqjiELZ84xAB7HIZjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecSdAiEOpZLQ0/PhcUBQ8yBiIHrTZzKNK/L2/7G5uu0=;
 b=kKEJ85D0zEu+tlNZrOBGJkrYPT/wKNGStMGxg7FLvZJj+XSTuC91B69sov8Qx0TmQEf7kxrgQfq2Xnp+ESpN9T6tG9kVfLRjkcX1thG6hs6Y8rWow7/6uCGzrhWn/2IMHjfcUbtdanhywZgT+v8CHPwam2V8pDSgfaDlLFUFLO3bbHz5qrVMtAFwqtMmIEKAS+AdVERHloWZ9amqb0R/XwUgMCgeUAvw8w5+wyCvXIV86zZU62SnMbH17qASYMc5MvRT4zQGH7Oc8anAmo1i1CC2qBrpUgw+/ByEtOtLFw40d/uB4l1fZh7HvFjxoGIcgg+6+bCRSoGcLEp02h4eZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecSdAiEOpZLQ0/PhcUBQ8yBiIHrTZzKNK/L2/7G5uu0=;
 b=xAC4qgWwdbyqiYBnqjIFjiZ+MsZqwsmF6Bfs7Bi0HIXyp4D58NzzeG0MUZMsk+kk0IXRLxjDL+8zQtAXQd0Lr5mGwR55xlIW67pZ83DzON1KMyTI25964cU+P/0rvXtrZ0C44aqms/ThZkkGthIr01AnOWU0/RX2QRzQ+AuTlefNXWyTDObpu209G6s4U85WuRZraYVERVv2wyofOx5fhu9GQi06LJshFn+mYC2p/+Qw++ZzF+eQ480SpeNnwZmCNIJy5gHC/wCB1EsMPIZIIDIo7vh+lzyM9iDCKYRGEe47zn9qhLSc1yIhxxdiaJBndRRAuinraqrAFBhHHQ8YaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB7876.eurprd04.prod.outlook.com (2603:10a6:20b:240::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Fri, 24 Apr
 2026 23:21:37 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 23:21:37 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 25 Apr 2026 08:37:04 +0800
Subject: [PATCH 12/13] imx8mp: data-modul-edm-sbc: Switch to OF_UPSTREAM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260425-imx8m-of-upstream-v1-12-07527be92e5d@nxp.com>
References: <20260425-imx8m-of-upstream-v1-0-07527be92e5d@nxp.com>
In-Reply-To: <20260425-imx8m-of-upstream-v1-0-07527be92e5d@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 kernel@puri.sm, u-boot@dh-electronics.com
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, "Lukas F. Hartmann" <lukas@mntre.com>, 
 Patrick Wildt <patrick@blueri.se>, Ye Li <ye.li@nxp.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Benjamin Hahn <B.Hahn@phytec.de>, Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marco Franchi <marcofrk@gmail.com>, Alifer Moraes <alifer.wsdm@gmail.com>, 
 Angus Ainslie <angus@akkea.ca>, Heiko Thiery <heiko.thiery@gmail.com>, 
 Olaf Mandel <o.mandel@menlosystems.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Matteo Lisi <matteo.lisi@engicam.com>, 
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM8PR04MB7876:EE_|DU4PR04MB10670:EE_
X-MS-Office365-Filtering-Correlation-Id: 135837a3-f096-4a65-59b3-08dea2583bb8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|19092799006|366016|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: Gg783Uvbk6SI40+LiUdfCJoIw3a9cHamhHLUUBDyS5WPG87wBSSPwBH6MC1a66nfJSbWWtmzV+J0j7pExx3UhPDzahYLNIulizJRcpJP/m4r+4Zy4WQxATm4yKIeoXQqZs190tx2BX6Lot3wLH4vcbHBJy7RXQm9lq+qOL/VtglnKuDJ6lnbj8mh/P4Zt1RuDlAqR9UIwqLa0S+X56jYZ0Dlh+c1fVs2Q2YuzYo0bnxf18ncNVUVr4hEmOCWNVoFYuBk1pUTjIlRCTdjIS7X6szDGjCKHNvOF2+cyQGXD4kSj34uBiPBQVPGFqJ0JAHr1O/F81VH0+6ZjJpayOe4jEJ4cBlryh2uVVwOsSiABREIccY5iCSe0EzbWZ0yCYy+3bA8y9vTnO9Qb3weojkbI7tdRdws6IcSknrU6M08XycnVQEyzRY8l+4JbEkxezXEPzACQWirs5pXeNgy54xlfjyFkWR4R19CLBFMXKOeymxPKfAEUTjvyUVhHNjwRTkz/YAydXd7DgkAkcp2wzcXsm57qDd5ZEBgtkwE53NnjOGoXR9xf8lXF6jN4lX6h7upJ4sg4t7N58QdN/+5CeHzb/7oub26/wjJWHn+LGs9JAup5NpcW4mRYbM9kKHx1ZWFEX9mRg5Bowy5toC5wEuNQXgI/8WVDa10yBbUp1SXOX1nE3Z3bqafcf9+Ce/zvCS/GShSzWmp2C93qEHek2R/yvcPYUcUOv5NXpp7sldqHAAgSwBlmvPAMxb4mLCaQdgTEQxDgXBiIK1IxuoAgXJvH2cINW0fYqlyI8iGEIPAB8s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(19092799006)(366016)(56012099003)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ai9GbDR0ZWtXMzhpSkJLL3NPSVd0SUFBMEJBYUpJZGMySU0wcWhQNWkycEsw?=
 =?utf-8?B?WlBweUN4OU0vZ3hWbkZ1OUd0aXIyN1pNaWVzL3dtK0crU3Y1RDArR2gxazdT?=
 =?utf-8?B?RzVMTUFNMndYS3lIMGhIR1Y3T0FrOWFSUFI3WFJUZUdkT1IyTlhrR1ROK3lr?=
 =?utf-8?B?bTErRzRZWTkrMW9ESWxWeXpwRGtjTXhNejA4NGtub3FMNU1VN013MVhURFgz?=
 =?utf-8?B?MEpLN0JjUU1mOTR1WWVTZWI0eVgzMUdia2Q5T29ONkdURzBhOUhnME5WdWp2?=
 =?utf-8?B?K0tHNERMOCtBR1BKM2dCSVB0YmU0OUFjRldKTFlsQVVWL1FYNXg3OC9tTnpu?=
 =?utf-8?B?b01NcDJ5U3lwWGVBV0Y4aVlKVkVXN09SNDhsK3hiVDJVY1NjTFBIRUlwQjJM?=
 =?utf-8?B?MXEzUTlxYk9CWEFzU0ZHWkIxUWJ0TmR2N0dncjZPRitzRVhUL3dxRFhRT2pj?=
 =?utf-8?B?TnFBdGkwVUNCVW5udXE4RzJuTW5SSUF3OU5jZjVBQlZVNlByT1FLUFVTUHky?=
 =?utf-8?B?dGJ6WmZnTVM5NGZIUnpnZFRDdDJRL1RUazFZT0VkUEZ3RFlwakhkOVA3U2do?=
 =?utf-8?B?YzN0V2ZnSnFsVXBYanBBeHhXSzRhMWZFdDdpaDF4VTI3ZVlHZXVTdnlOZmRM?=
 =?utf-8?B?RXQ2SU1sZDg3Zm9rZTdvS1NiWjFhaitJUHRuNS9nTnBKUkEwVW5mUkQ5VG1h?=
 =?utf-8?B?a1RGK1lhMTU5Z0Z5b1pHTXMzN1R4SE5Vc3NsKzF5b0Fva21NaFNGYnJ3cVZx?=
 =?utf-8?B?akxVTU1URmY0MitadDdaOGFWSUdZaTkvcFZ5eU8yeFBvMHVBZi9sQkFqRnRE?=
 =?utf-8?B?eFB2UEJDVEtiWVBTYWc4aUsvY2hsVTJvSmg1VDRCb2FwUjlwZlNNNERqTkZZ?=
 =?utf-8?B?MC9mcUtYV2RlbkVQSVVBR21aWjROdG1HSUptcy9uRXFOTlFtbm9EUVV3QWZu?=
 =?utf-8?B?R1NRYlFGRk02SVNsNytidi9pS2lld2pZbkpERTRqMXZXWFVaYUh3eXlyczgv?=
 =?utf-8?B?R3N1WW1LM00vR0hVWXlBT09IWCtmUFVSSldCRUllcHNPNzJFclhtYzllWElw?=
 =?utf-8?B?RGJzWFZpZHo5SWFuZ0dkNlkwcGxXRnBqbGpwWjFrbFdPZGJENDdVdldTSDVy?=
 =?utf-8?B?RG5Na3VEYVdtb29qaFVDUWJvR05DVGtjeDB3WUZGYzI0MU1MdmF3V0ErdmRo?=
 =?utf-8?B?Y0l4UzNsM1lGZjNBV3lUWW1Odk5lYXEwK2JaeE5oTnBRSHdWQjlIWTEyQW5I?=
 =?utf-8?B?a2RvL0d1SFBiT3JIVE1PNXpvSnFJOXRiWG5OK3NSSnhRRUlUdWRhNDkzdS9a?=
 =?utf-8?B?SjlPaFJrdTI3YWlBMWZBZFh4VkMxNVNMZGJOVHQ5NUZycmljbVNsQlZNeU11?=
 =?utf-8?B?RVdTKzh5Q0tRUCtEelVpYi9iMnEzSGNhWFpQUGVZQStGSFZwQ1NZeTFpeGd1?=
 =?utf-8?B?Z0t5M1l1bU50Z0g3NngxZVJNZDRrQy94WDZMaHM1UHBIL1d6clFSUlR4MU1D?=
 =?utf-8?B?bWkya1o0dzRlWHVYYVhZSjdXNTBkb1MwK1JRdTliOVJrQ1hXRXh3Q0xQR29D?=
 =?utf-8?B?TWpJMzR4S0UwLzRINkk2NDkrWUkvakhMN2o3VnFIeWYyWEUyRnlvZnYwd2dL?=
 =?utf-8?B?MkhyTStXODBUaElGK2IvV1pRajJ6VS9IaS9VaE1xV0s2VjErL3lLdkNwNFpH?=
 =?utf-8?B?OUF5WjBUaVUvcHNnYU5GYUsvUVhwWkJBOTR5eitUT3gwODlZdCsrWUxrMlFv?=
 =?utf-8?B?SXlJNFBDemZ1SzVjYW5tNnRjdllDN21RYnJuS1NrYVhWbWxDM3dhZVlidnR5?=
 =?utf-8?B?MkFIelQ5M1R3YXhWQ0ZCTHAzbzVJWVFvVHlBbWFtOVVOQ25zQXVuUFR6bUZq?=
 =?utf-8?B?VlZqdE10U3RpZGQ4VDlHaUZPL0VXTUpqMjdvL2NXanZGVUtYWlVhUUNkaGZt?=
 =?utf-8?B?THV2TmQwYUtDSk5SNWVmamlzSitVYzFoZVZZaWhoeVVaSUgwRzI1Z1hPWHU3?=
 =?utf-8?B?aVVpVWprSXVScTlSdllVTmFMalN5dFE5UW05aTBwU1IxV1dSdXNRVWFkSExZ?=
 =?utf-8?B?ZGpWL3dBUjhjdk1Jd3pQWWN0WHBMVW83c0RCWnZINHV1V3dHR0pzZmpXMkRH?=
 =?utf-8?B?TjlvZXZWa25SYkVGYmxWdzA2aGJwaWlWaHE2L3RPSlUyamprT3lIaWtka0Jo?=
 =?utf-8?B?bmlPY2JoWEpiVndDdUxpZUUreHBQa282a2c2V0k3dHo4cEIyODh1SFJDcXFa?=
 =?utf-8?B?Z1d2N0hmd2lzT2tiZHlDcldjWkVTd0FEZXRmVmdJSFpKZ1ptMHpsV3RBcTFM?=
 =?utf-8?B?QTJGcnQ0SE00RGdkMVVud3BlajBVSnZmNGVaNWhMS1c4VjY0OHM2QT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 135837a3-f096-4a65-59b3-08dea2583bb8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 23:21:37.8047 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DidrlJL+7XgCSV8qGaIYorGypqz/nafqmOWP8C1ORmBlw+E3IrlBI5FK1u7npAFKA8/SR3xBacLhDU6ptEEWSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7876
X-OriginatorOrg: oss.nxp.com
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

From: Peng Fan <peng.fan@nxp.com>

There are some differences in arch/arm/dts/imx8mp-data-modul-edm-sbc.dts
compared with the one in dts/upstream, but they should not impact boot,
so switch to OF_UPSTREAM by dropping the copy and selecting OF_UPSTREAM.

In upstream dts there are two eeprom nodes, eeprom900(default disabled) and
eeprom902. So change is update eeprom alias to node eeprom902.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/Makefile                              |   1 -
 arch/arm/dts/imx8mp-data-modul-edm-sbc-u-boot.dtsi |   2 +-
 arch/arm/dts/imx8mp-data-modul-edm-sbc.dts         | 972 ---------------------
 arch/arm/mach-imx/imx8m/Kconfig                    |   1 +
 board/data_modul/imx8mp_edm_sbc/MAINTAINERS        |   1 -
 configs/imx8mp_data_modul_edm_sbc_defconfig        |   2 +-
 6 files changed, 3 insertions(+), 976 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 434bcbfef32..d2ddf885c1a 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -875,7 +875,6 @@ dtb-$(CONFIG_ARCH_IMX8) += \
 dtb-$(CONFIG_ARCH_IMX8M) += \
 	imx8mm-phg.dtb \
 	imx8mq-cm.dtb \
-	imx8mp-data-modul-edm-sbc.dtb \
 	imx8mp-dhcom-som-overlay-rev100.dtbo \
 	imx8mp-dhcom-som-overlay-eth1xfast.dtbo \
 	imx8mp-dhcom-som-overlay-eth2xfast.dtbo \
diff --git a/arch/arm/dts/imx8mp-data-modul-edm-sbc-u-boot.dtsi b/arch/arm/dts/imx8mp-data-modul-edm-sbc-u-boot.dtsi
index 1e82e718b8f..a4d5ed1649f 100644
--- a/arch/arm/dts/imx8mp-data-modul-edm-sbc-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-data-modul-edm-sbc-u-boot.dtsi
@@ -8,7 +8,7 @@
 
 / {
 	aliases {
-		eeprom0 = &eeprom;
+		eeprom0 = &eeprom902;
 		mmc0 = &usdhc3;	/* eMMC */
 		mmc1 = &usdhc2;	/* MicroSD */
 		spi0 = &ecspi1;
diff --git a/arch/arm/dts/imx8mp-data-modul-edm-sbc.dts b/arch/arm/dts/imx8mp-data-modul-edm-sbc.dts
deleted file mode 100644
index 6b40106e3bd..00000000000
--- a/arch/arm/dts/imx8mp-data-modul-edm-sbc.dts
+++ /dev/null
@@ -1,972 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (C) 2022 Marek Vasut <marex@denx.de>
- */
-
-/dts-v1/;
-
-#include <dt-bindings/net/qca-ar803x.h>
-#include "imx8mp.dtsi"
-
-/ {
-	model = "Data Modul i.MX8M Plus eDM SBC";
-	compatible = "dmo,imx8mp-data-modul-edm-sbc", "fsl,imx8mp";
-
-	aliases {
-		rtc0 = &rtc;
-		rtc1 = &snvs_rtc;
-	};
-
-	chosen {
-		stdout-path = &uart3;
-	};
-
-	memory@40000000 {
-		device_type = "memory";
-		/* There are 1/2/4 GiB options, adjusted by bootloader. */
-		reg = <0x0 0x40000000 0 0x40000000>;
-	};
-
-	backlight: backlight {
-		compatible = "pwm-backlight";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_panel_backlight>;
-		brightness-levels = <0 1 10 20 30 40 50 60 70 75 80 90 100>;
-		default-brightness-level = <7>;
-		enable-gpios = <&gpio3 0 GPIO_ACTIVE_HIGH>;
-		pwms = <&pwm1 0 5000000 0>;
-		/* Disabled by default, unless display board plugged in. */
-		status = "disabled";
-	};
-
-	clk_xtal25: clk-xtal25 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <25000000>;
-	};
-
-	panel: panel {
-		backlight = <&backlight>;
-		power-supply = <&reg_panel_vcc>;
-		/* Disabled by default, unless display board plugged in. */
-		status = "disabled";
-	};
-
-	reg_panel_vcc: regulator-panel-vcc {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_panel_vcc_reg>;
-		regulator-name = "PANEL_VCC";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		gpio = <&gpio3 6 0>;
-		enable-active-high;
-		/* Disabled by default, unless display board plugged in. */
-		status = "disabled";
-	};
-
-	reg_usdhc2_vmmc: regulator-usdhc2-vmmc {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio2 19 0>; /* SD2_RESET */
-		off-on-delay-us = <12000>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_usdhc2_vmmc>;
-		regulator-max-microvolt = <3300000>;
-		regulator-min-microvolt = <3300000>;
-		regulator-name = "VDD_3V3_SD";
-		startup-delay-us = <100>;
-		vin-supply = <&buck4>;
-	};
-
-	watchdog {
-		/* TPS3813 */
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_watchdog_gpio>;
-		compatible = "linux,wdt-gpio";
-		always-running;
-		gpios = <&gpio2 8 GPIO_ACTIVE_HIGH>;
-		hw_algo = "level";
-		/* Reset triggers in 2..3 seconds */
-		hw_margin_ms = <1500>;
-		/* Disabled by default */
-		status = "disabled";
-	};
-};
-
-&A53_0 {
-	cpu-supply = <&buck2>;
-};
-
-&A53_1 {
-	cpu-supply = <&buck2>;
-};
-
-&A53_2 {
-	cpu-supply = <&buck2>;
-};
-
-&A53_3 {
-	cpu-supply = <&buck2>;
-};
-
-&ecspi1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_ecspi1>;
-	cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
-	status = "okay";
-
-	flash@0 {	/* W25Q128JVEI */
-		compatible = "jedec,spi-nor";
-		reg = <0>;
-		spi-max-frequency = <100000000>;	/* Up to 133 MHz */
-		spi-tx-bus-width = <1>;
-		spi-rx-bus-width = <1>;
-	};
-};
-
-&ecspi2 {	/* Feature connector SPI */
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_ecspi2>;
-	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
-	/* Disabled by default, unless feature board plugged in. */
-	status = "disabled";
-};
-
-&ecspi3 {	/* Display connector SPI */
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_ecspi3>;
-	cs-gpios = <&gpio5 25 GPIO_ACTIVE_LOW>;
-	/* Disabled by default, unless display board plugged in. */
-	status = "disabled";
-};
-
-&eqos {	/* First ethernet */
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_eqos>;
-	phy-handle = <&phy_eqos>;
-	phy-mode = "rgmii-id";
-	status = "okay";
-
-	mdio {
-		compatible = "snps,dwmac-mdio";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		/* Atheros AR8031 PHY */
-		phy_eqos: ethernet-phy@0 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <0>;
-			/*
-			 * Dedicated ENET_WOL# signal is unused, the PHY
-			 * can wake the SoC up via INT signal as well.
-			 */
-			interrupts-extended = <&gpio1 11 IRQ_TYPE_LEVEL_LOW>;
-			reset-gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
-			reset-assert-us = <10000>;
-			reset-deassert-us = <10000>;
-			qca,keep-pll-enabled;
-			vddio-supply = <&vddio_eqos>;
-
-			vddio_eqos: vddio-regulator {
-				regulator-name = "VDDIO_EQOS";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-			};
-
-			vddh_eqos: vddh-regulator {
-				regulator-name = "VDDH_EQOS";
-			};
-		};
-	};
-};
-
-&fec {	/* Second ethernet */
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_fec>;
-	phy-handle = <&phy_fec>;
-	phy-mode = "rgmii-id";
-	fsl,magic-packet;
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		/* Atheros AR8031 PHY */
-		phy_fec: ethernet-phy@0 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <0>;
-			/*
-			 * Dedicated ENET_WOL# signal is unused, the PHY
-			 * can wake the SoC up via INT signal as well.
-			 */
-			interrupts-extended = <&gpio2 2 IRQ_TYPE_LEVEL_LOW>;
-			reset-gpios = <&gpio2 9 GPIO_ACTIVE_LOW>;
-			reset-assert-us = <10000>;
-			reset-deassert-us = <10000>;
-			qca,keep-pll-enabled;
-			vddio-supply = <&vddio_fec>;
-
-			vddio_fec: vddio-regulator {
-				regulator-name = "VDDIO_FEC";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-			};
-
-			vddh_fec: vddh-regulator {
-				regulator-name = "VDDH_FEC";
-			};
-		};
-	};
-};
-
-&flexcan1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_flexcan1>;
-	status = "okay";
-};
-
-&gpio1 {
-	gpio-line-names =
-		"", "USBHUB_RESET#", "WDOG_B#", "PMIC_INT#",
-		"", "M2_PCIE_RST#", "M2_PCIE_WAKE#", "GPIO5_IO03",
-		"GPIO5_IO04", "PDM_SEL", "ENET_WOL#", "ENET_INT#",
-		"", "", "", "ENET_RST#",
-		"", "", "", "", "", "", "", "",
-		"", "", "", "", "", "", "", "";
-};
-
-&gpio2 {
-	gpio-line-names =
-		"", "", "ENET2_INT#", "", "", "", "", "",
-		"WDOG_KICK#", "ENET2_RST#", "CAN_INT#", "RTC_IRQ#",
-		"", "", "", "",
-		"", "", "", "SD2_RESET#", "", "", "", "",
-		"", "", "", "", "", "", "", "";
-};
-
-&gpio3 {
-	gpio-line-names =
-		"BL_ENABLE_1V8", "PG_V_IN_VAR#", "", "",
-		"", "", "TFT_ENABLE_1V8", "GRAPHICS_GPIO0_1V8",
-		"CSI2_PD_1V8", "CSI2_RESET_1V8#", "", "",
-		"", "", "EEPROM_WP_1V8#", "", "", "", "", "",
-		"MEMCFG0", "PCIE_CLK_GEN_CLKPWRGD_PD_1V8#",
-		"", "M2_W_DISABLE1_1V8#",
-		"M2_W_DISABLE2_1V8#", "", "I2C5_SCL_3V3", "I2C5_SDA_3V3",
-		"", "", "", "";
-};
-
-&gpio4 {
-	gpio-line-names =
-		"DSI_RESET_1V8#", "MEMCFG2", "", "MEMCFG1", "", "", "", "",
-		"", "", "", "", "", "", "", "",
-		"", "", "GRAPHICS_PRSNT_1V8#", "DSI_IRQ_1V8#",
-		"", "DIS_USB_DN1", "DIS_USB_DN2", "",
-		"", "", "", "", "", "", "", "";
-};
-
-&gpio5 {
-	gpio-line-names =
-		"", "", "", "", "", "WDOG_EN", "", "",
-		"", "SPI1_CS#", "", "",
-		"", "SPI2_CS#", "I2C1_SCL_3V3", "I2C1_SDA_3V3",
-		"I2C2_SCL_3V3", "I2C2_SDA_3V3", "I2C3_SCL_3V3", "I2C3_SDA_3V3",
-		"", "", "", "",
-		"", "SPI3_CS#", "", "", "", "", "", "";
-};
-
-&i2c1 {
-	clock-frequency = <100000>;
-	pinctrl-names = "default", "gpio";
-	pinctrl-0 = <&pinctrl_i2c1>;
-	pinctrl-1 = <&pinctrl_i2c1_gpio>;
-	scl-gpios = <&gpio5 14 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	sda-gpios = <&gpio5 15 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	status = "okay";
-
-	usb-hub@2c {
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_usb_hub>;
-		compatible = "microchip,usb2514bi";
-		reg = <0x2c>;
-		individual-port-switching;
-		reset-gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
-		self-powered;
-	};
-
-	eeprom: eeprom@50 {
-		compatible = "atmel,24c32";
-		reg = <0x50>;
-		pagesize = <32>;
-	};
-
-	rtc: rtc@68 {
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_rtc>;
-		compatible = "st,m41t62";
-		reg = <0x68>;
-		interrupts-extended = <&gpio2 11 IRQ_TYPE_LEVEL_LOW>;
-	};
-
-	pcieclk: clk@6a {
-		compatible = "renesas,9fgv0241";
-		reg = <0x6a>;
-		clocks = <&clk_xtal25>;
-		#clock-cells = <1>;
-	};
-};
-
-&i2c2 {
-	clock-frequency = <100000>;
-	pinctrl-names = "default", "gpio";
-	pinctrl-0 = <&pinctrl_i2c2>;
-	pinctrl-1 = <&pinctrl_i2c2_gpio>;
-	scl-gpios = <&gpio5 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	sda-gpios = <&gpio5 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	status = "okay";
-};
-
-&i2c3 {
-	clock-frequency = <100000>;
-	pinctrl-names = "default", "gpio";
-	pinctrl-0 = <&pinctrl_i2c3>;
-	pinctrl-1 = <&pinctrl_i2c3_gpio>;
-	scl-gpios = <&gpio5 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	sda-gpios = <&gpio5 19 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	status = "okay";
-
-	pmic: pmic@25 {
-		compatible = "nxp,pca9450c";
-		reg = <0x25>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pmic>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
-
-		/*
-		 * i.MX 8M Plus Data Sheet for Consumer Products
-		 * 3.1.4 Operating ranges
-		 * MIMX8ML8CVNKZAB
-		 */
-		regulators {
-			buck1: BUCK1 {	/* VDD_SOC (dual-phase with BUCK3) */
-				regulator-min-microvolt = <850000>;
-				regulator-max-microvolt = <1000000>;
-				regulator-ramp-delay = <3125>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			buck2: BUCK2 {	/* VDD_ARM */
-				regulator-min-microvolt = <850000>;
-				regulator-max-microvolt = <1000000>;
-				regulator-ramp-delay = <3125>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			buck4: BUCK4 {	/* VDD_3V3 */
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			buck5: BUCK5 {	/* VDD_1V8 */
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			buck6: BUCK6 {	/* NVCC_DRAM_1V1 */
-				regulator-min-microvolt = <1100000>;
-				regulator-max-microvolt = <1100000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			ldo1: LDO1 {	/* NVCC_SNVS_1V8 */
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			ldo3: LDO3 {	/* VDDA_1V8 */
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-
-			ldo4: LDO4 {	/* PMIC_LDO4 */
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-			};
-
-			ldo5: LDO5 {	/* NVCC_SD2 */
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-			};
-		};
-	};
-};
-
-&i2c5 {	/* HDMI EDID bus */
-	clock-frequency = <100000>;
-	pinctrl-names = "default", "gpio";
-	pinctrl-0 = <&pinctrl_i2c5>;
-	pinctrl-1 = <&pinctrl_i2c5_gpio>;
-	scl-gpios = <&gpio3 26 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	sda-gpios = <&gpio3 27 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_hog_feature>, <&pinctrl_hog_misc>,
-		    <&pinctrl_hog_panel>, <&pinctrl_hog_sbc>,
-		    <&pinctrl_panel_expansion>;
-
-	pinctrl_ecspi1: ecspi1-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_ECSPI1_SCLK__ECSPI1_SCLK		0x44
-			MX8MP_IOMUXC_ECSPI1_MOSI__ECSPI1_MOSI		0x44
-			MX8MP_IOMUXC_ECSPI1_MISO__ECSPI1_MISO		0x44
-			MX8MP_IOMUXC_ECSPI1_SS0__GPIO5_IO09		0x40
-		>;
-	};
-
-	pinctrl_ecspi2: ecspi2-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_ECSPI2_SCLK__ECSPI2_SCLK		0x44
-			MX8MP_IOMUXC_ECSPI2_MOSI__ECSPI2_MOSI		0x44
-			MX8MP_IOMUXC_ECSPI2_MISO__ECSPI2_MISO		0x44
-			MX8MP_IOMUXC_ECSPI2_SS0__GPIO5_IO13		0x40
-		>;
-	};
-
-	pinctrl_ecspi3: ecspi3-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_UART1_RXD__ECSPI3_SCLK		0x44
-			MX8MP_IOMUXC_UART1_TXD__ECSPI3_MOSI		0x44
-			MX8MP_IOMUXC_UART2_RXD__ECSPI3_MISO		0x44
-			MX8MP_IOMUXC_UART2_TXD__GPIO5_IO25		0x40
-		>;
-	};
-
-	pinctrl_eqos: eqos-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_ENET_MDC__ENET_QOS_MDC		0x3
-			MX8MP_IOMUXC_ENET_MDIO__ENET_QOS_MDIO		0x3
-			MX8MP_IOMUXC_ENET_TX_CTL__ENET_QOS_RGMII_TX_CTL	0x1f
-			MX8MP_IOMUXC_ENET_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x1f
-			MX8MP_IOMUXC_ENET_TD0__ENET_QOS_RGMII_TD0	0x1f
-			MX8MP_IOMUXC_ENET_TD1__ENET_QOS_RGMII_TD1	0x1f
-			MX8MP_IOMUXC_ENET_TD2__ENET_QOS_RGMII_TD2	0x1f
-			MX8MP_IOMUXC_ENET_TD3__ENET_QOS_RGMII_TD3	0x1f
-			MX8MP_IOMUXC_ENET_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x91
-			MX8MP_IOMUXC_ENET_RX_CTL__ENET_QOS_RGMII_RX_CTL	0x91
-			MX8MP_IOMUXC_ENET_RD0__ENET_QOS_RGMII_RD0	0x91
-			MX8MP_IOMUXC_ENET_RD1__ENET_QOS_RGMII_RD1	0x91
-			MX8MP_IOMUXC_ENET_RD2__ENET_QOS_RGMII_RD2	0x91
-			MX8MP_IOMUXC_ENET_RD3__ENET_QOS_RGMII_RD3	0x91
-			/* ENET_RST# */
-			MX8MP_IOMUXC_GPIO1_IO15__GPIO1_IO15		0x6
-			/* ENET_INT# */
-			MX8MP_IOMUXC_GPIO1_IO11__GPIO1_IO11		0x40000090
-		>;
-	};
-
-	pinctrl_fec: fec-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SAI1_RXD2__ENET1_MDC		0x3
-			MX8MP_IOMUXC_SAI1_RXD3__ENET1_MDIO		0x3
-			MX8MP_IOMUXC_SAI1_RXD4__ENET1_RGMII_RD0		0x91
-			MX8MP_IOMUXC_SAI1_RXD5__ENET1_RGMII_RD1		0x91
-			MX8MP_IOMUXC_SAI1_RXD6__ENET1_RGMII_RD2		0x91
-			MX8MP_IOMUXC_SAI1_RXD7__ENET1_RGMII_RD3		0x91
-			MX8MP_IOMUXC_SAI1_TXC__ENET1_RGMII_RXC		0x91
-			MX8MP_IOMUXC_SAI1_TXFS__ENET1_RGMII_RX_CTL	0x91
-			MX8MP_IOMUXC_SAI1_TXD0__ENET1_RGMII_TD0		0x1f
-			MX8MP_IOMUXC_SAI1_TXD1__ENET1_RGMII_TD1		0x1f
-			MX8MP_IOMUXC_SAI1_TXD2__ENET1_RGMII_TD2		0x1f
-			MX8MP_IOMUXC_SAI1_TXD3__ENET1_RGMII_TD3		0x1f
-			MX8MP_IOMUXC_SAI1_TXD4__ENET1_RGMII_TX_CTL	0x1f
-			MX8MP_IOMUXC_SAI1_TXD5__ENET1_RGMII_TXC		0x1f
-			/* ENET2_RST# */
-			MX8MP_IOMUXC_SD1_DATA7__GPIO2_IO09		0x6
-			/* ENET2_INT# */
-			MX8MP_IOMUXC_SD1_DATA0__GPIO2_IO02		0x40000090
-		>;
-	};
-
-	pinctrl_flexcan1: flexcan1-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SPDIF_RX__CAN1_RX			0x154
-			MX8MP_IOMUXC_SPDIF_TX__CAN1_TX			0x154
-		>;
-	};
-
-	pinctrl_hog_feature: hog-feature-grp {
-		fsl,pins = <
-			/* GPIO5_IO03 */
-			MX8MP_IOMUXC_GPIO1_IO07__GPIO1_IO07		0x40000006
-			/* GPIO5_IO04 */
-			MX8MP_IOMUXC_GPIO1_IO08__GPIO1_IO08		0x40000006
-
-			/* CAN_INT# */
-			MX8MP_IOMUXC_SD1_RESET_B__GPIO2_IO10		0x40000090
-		>;
-	};
-
-	pinctrl_hog_panel: hog-panel-grp {
-		fsl,pins = <
-			/* GRAPHICS_GPIO0_1V8 */
-			MX8MP_IOMUXC_NAND_DATA01__GPIO3_IO07		0x26
-		>;
-	};
-
-	pinctrl_hog_misc: hog-misc-grp {
-		fsl,pins = <
-			/* ENET_WOL# -- shared by both PHYs */
-			MX8MP_IOMUXC_GPIO1_IO10__GPIO1_IO10		0x40000090
-
-			/* PG_V_IN_VAR# */
-			MX8MP_IOMUXC_NAND_CE0_B__GPIO3_IO01		0x40000000
-			/* CSI2_PD_1V8 */
-			MX8MP_IOMUXC_NAND_DATA02__GPIO3_IO08		0x0
-			/* CSI2_RESET_1V8# */
-			MX8MP_IOMUXC_NAND_DATA03__GPIO3_IO09		0x0
-
-			/* DIS_USB_DN1 */
-			MX8MP_IOMUXC_SAI2_RXFS__GPIO4_IO21		0x0
-			/* DIS_USB_DN2 */
-			MX8MP_IOMUXC_SAI2_RXC__GPIO4_IO22		0x0
-
-			/* EEPROM_WP_1V8# */
-			MX8MP_IOMUXC_NAND_DQS__GPIO3_IO14		0x100
-			/* PCIE_CLK_GEN_CLKPWRGD_PD_1V8# */
-			MX8MP_IOMUXC_SAI5_RXD0__GPIO3_IO21		0x0
-			/* GRAPHICS_PRSNT_1V8# */
-			MX8MP_IOMUXC_SAI1_TXD6__GPIO4_IO18		0x40000000
-
-			/* CLK_CCM_CLKO1_3V3 */
-			MX8MP_IOMUXC_GPIO1_IO14__CCM_CLKO1		0x10
-		>;
-	};
-
-	pinctrl_hog_sbc: hog-sbc-grp {
-		fsl,pins = <
-			/* MEMCFG[0..2] straps */
-			MX8MP_IOMUXC_SAI5_RXC__GPIO3_IO20		0x40000140
-			MX8MP_IOMUXC_SAI1_RXD1__GPIO4_IO03		0x40000140
-			MX8MP_IOMUXC_SAI1_RXC__GPIO4_IO01		0x40000140
-		>;
-	};
-
-	pinctrl_i2c1: i2c1-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL			0x40000084
-			MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA			0x40000084
-		>;
-	};
-
-	pinctrl_i2c1_gpio: i2c1-gpio-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_I2C1_SCL__GPIO5_IO14		0x84
-			MX8MP_IOMUXC_I2C1_SDA__GPIO5_IO15		0x84
-		>;
-	};
-
-	pinctrl_i2c2: i2c2-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL			0x40000084
-			MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA			0x40000084
-		>;
-	};
-
-	pinctrl_i2c2_gpio: i2c2-gpio-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_I2C2_SCL__GPIO5_IO16		0x84
-			MX8MP_IOMUXC_I2C2_SDA__GPIO5_IO17		0x84
-		>;
-	};
-
-	pinctrl_i2c3: i2c3-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL			0x40000084
-			MX8MP_IOMUXC_I2C3_SDA__I2C3_SDA			0x40000084
-		>;
-	};
-
-	pinctrl_i2c3_gpio: i2c3-gpio-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_I2C3_SCL__GPIO5_IO18		0x84
-			MX8MP_IOMUXC_I2C3_SDA__GPIO5_IO19		0x84
-		>;
-	};
-
-	pinctrl_i2c5: i2c5-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_HDMI_DDC_SCL__I2C5_SCL		0x40000084
-			MX8MP_IOMUXC_HDMI_DDC_SDA__I2C5_SDA		0x40000084
-		>;
-	};
-
-	pinctrl_i2c5_gpio: i2c5-gpio-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_HDMI_DDC_SCL__GPIO3_IO26		0x84
-			MX8MP_IOMUXC_HDMI_DDC_SDA__GPIO3_IO27		0x84
-		>;
-	};
-
-	pinctrl_panel_backlight: panel-backlight-grp {
-		fsl,pins = <
-			/* BL_ENABLE_1V8 */
-			MX8MP_IOMUXC_NAND_ALE__GPIO3_IO00		0x104
-		>;
-	};
-
-	pinctrl_panel_expansion: panel-expansion-grp {
-		fsl,pins = <
-			/* DSI_RESET_1V8# */
-			MX8MP_IOMUXC_SAI1_RXFS__GPIO4_IO00		0x2
-			/* DSI_IRQ_1V8# */
-			MX8MP_IOMUXC_SAI1_TXD7__GPIO4_IO19		0x40000090
-		>;
-	};
-
-	pinctrl_panel_pwm: panel-pwm-grp {
-		fsl,pins = <
-			/* BL_PWM_3V3 */
-			MX8MP_IOMUXC_I2C4_SDA__PWM1_OUT			0x12
-		>;
-	};
-
-	pinctrl_panel_vcc_reg: panel-vcc-grp {
-		fsl,pins = <
-			/* TFT_ENABLE_1V8 */
-			MX8MP_IOMUXC_NAND_DATA00__GPIO3_IO06		0x104
-		>;
-	};
-
-	pinctrl_pcie0: pcie-grp {
-		fsl,pins = <
-			/* M2_PCIE_RST# */
-			MX8MP_IOMUXC_GPIO1_IO05__GPIO1_IO05		0x2
-			/* M2_W_DISABLE1_1V8# */
-			MX8MP_IOMUXC_SAI5_RXD2__GPIO3_IO23		0x2
-			/* M2_W_DISABLE2_1V8# */
-			MX8MP_IOMUXC_SAI5_RXD3__GPIO3_IO24		0x2
-			/* CLK_M2_32K768 */
-			MX8MP_IOMUXC_GPIO1_IO00__CCM_EXT_CLK1		0x14
-			/* M2_PCIE_WAKE# */
-			MX8MP_IOMUXC_GPIO1_IO06__GPIO1_IO06		0x40000140
-			/* M2_PCIE_CLKREQ# */
-			MX8MP_IOMUXC_I2C4_SCL__PCIE_CLKREQ_B		0x61
-		>;
-	};
-
-	pinctrl_pdm: pdm-grp {
-		fsl,pins = <
-			/* PDM_SEL */
-			MX8MP_IOMUXC_GPIO1_IO09__GPIO1_IO09		0x0
-			MX8MP_IOMUXC_SAI3_RXC__AUDIOMIX_PDM_CLK		0x0
-			MX8MP_IOMUXC_SAI3_RXFS__AUDIOMIX_PDM_BIT_STREAM00	0x0
-		>;
-	};
-
-	pinctrl_pmic: pmic-grp {
-		fsl,pins = <
-			/* PMIC_nINT */
-			MX8MP_IOMUXC_GPIO1_IO03__GPIO1_IO03		0x40000090
-		>;
-	};
-
-	pinctrl_rtc: rtc-grp {
-		fsl,pins = <
-			/* RTC_IRQ# */
-			MX8MP_IOMUXC_SD1_STROBE__GPIO2_IO11		0x40000090
-		>;
-	};
-
-	pinctrl_sai1: sai1-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SAI5_RXD1__AUDIOMIX_SAI1_TX_SYNC	0xd6
-			MX8MP_IOMUXC_SAI5_RXFS__AUDIOMIX_SAI1_TX_DATA00	0xd6
-			MX8MP_IOMUXC_SAI5_MCLK__AUDIOMIX_SAI1_TX_BCLK	0xd6
-			MX8MP_IOMUXC_SAI1_MCLK__AUDIOMIX_SAI1_MCLK	0xd6
-			MX8MP_IOMUXC_SAI1_RXD0__AUDIOMIX_SAI1_RX_DATA00	0xd6
-		>;
-	};
-
-	pinctrl_sai2: sai2-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SAI2_TXFS__AUDIOMIX_SAI2_TX_SYNC	0xd6
-			MX8MP_IOMUXC_SAI2_TXD0__AUDIOMIX_SAI2_TX_DATA00	0xd6
-			MX8MP_IOMUXC_SAI2_TXC__AUDIOMIX_SAI2_TX_BCLK	0xd6
-			MX8MP_IOMUXC_SAI2_MCLK__AUDIOMIX_SAI2_MCLK	0xd6
-		>;
-	};
-
-	pinctrl_sai3: sai3-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SAI3_TXFS__AUDIOMIX_SAI3_TX_SYNC	0xd6
-			MX8MP_IOMUXC_SAI3_TXD__AUDIOMIX_SAI3_TX_DATA00	0xd6
-			MX8MP_IOMUXC_SAI3_TXC__AUDIOMIX_SAI3_TX_BCLK	0xd6
-			MX8MP_IOMUXC_SAI3_MCLK__AUDIOMIX_SAI3_MCLK	0xd6
-			MX8MP_IOMUXC_SAI3_RXD__AUDIOMIX_SAI3_RX_DATA00	0xd6
-		>;
-	};
-
-	pinctrl_uart1: uart1-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD1_CLK__UART1_DCE_TX		0x49
-			MX8MP_IOMUXC_SD1_CMD__UART1_DCE_RX		0x49
-			MX8MP_IOMUXC_SD1_DATA1__UART1_DCE_CTS		0x49
-			MX8MP_IOMUXC_SAI2_RXD0__UART1_DCE_RTS		0x49
-		>;
-	};
-
-	pinctrl_uart2: uart2-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD1_DATA2__UART2_DCE_TX		0x49
-			MX8MP_IOMUXC_SD1_DATA3__UART2_DCE_RX		0x49
-			MX8MP_IOMUXC_SD1_DATA4__UART2_DCE_RTS		0x49
-			MX8MP_IOMUXC_SD1_DATA5__UART2_DCE_CTS		0x49
-		>;
-	};
-
-	pinctrl_uart3: uart3-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_UART3_RXD__UART3_DCE_RX		0x49
-			MX8MP_IOMUXC_UART3_TXD__UART3_DCE_TX		0x49
-		>;
-	};
-
-	pinctrl_uart4: uart4-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_UART4_RXD__UART4_DCE_RX		0x49
-			MX8MP_IOMUXC_UART4_TXD__UART4_DCE_TX		0x49
-		>;
-	};
-
-	pinctrl_usdhc2: usdhc2-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK		0x190
-			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD		0x1d0
-			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0		0x1d0
-			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1		0x1d0
-			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2		0x1d0
-			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3		0x1d0
-			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT		0xc1
-		>;
-	};
-
-	pinctrl_usdhc2_100mhz: usdhc2-100mhz-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK		0x194
-			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD		0x1d4
-			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0		0x1d4
-			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1		0x1d4
-			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2		0x1d4
-			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3		0x1d4
-			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT		0xc1
-		>;
-	};
-
-	pinctrl_usdhc2_200mhz: usdhc2-200mhz-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK		0x196
-			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD		0x1d6
-			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0		0x1d6
-			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1		0x1d6
-			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2		0x1d6
-			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3		0x1d6
-			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT		0xc1
-		>;
-	};
-
-	pinctrl_usdhc2_vmmc: usdhc2-vmmc-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19		0x20
-		>;
-	};
-
-	pinctrl_usdhc2_gpio: usdhc2-gpio-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD2_CD_B__GPIO2_IO12		0x40000080
-		>;
-	};
-
-	pinctrl_usdhc3: usdhc3-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK		0x190
-			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD		0x1d0
-			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0		0x1d0
-			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1		0x1d0
-			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2		0x1d0
-			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3		0x1d0
-			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4		0x1d0
-			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5		0x1d0
-			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6		0x1d0
-			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7		0x1d0
-			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE		0x190
-			MX8MP_IOMUXC_NAND_READY_B__USDHC3_RESET_B	0x141
-		>;
-	};
-
-	pinctrl_usdhc3_100mhz: usdhc3-100mhz-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK		0x194
-			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD		0x1d4
-			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0		0x1d4
-			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1		0x1d4
-			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2		0x1d4
-			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3		0x1d4
-			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4		0x1d4
-			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5		0x1d4
-			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6		0x1d4
-			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7		0x1d4
-			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE		0x194
-			MX8MP_IOMUXC_NAND_READY_B__USDHC3_RESET_B	0x141
-		>;
-	};
-
-	pinctrl_usdhc3_200mhz: usdhc3-200mhz-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK		0x196
-			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD		0x1d6
-			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0		0x1d6
-			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1		0x1d6
-			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2		0x1d6
-			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3		0x1d6
-			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4		0x1d6
-			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5		0x1d6
-			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6		0x1d6
-			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7		0x1d6
-			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE		0x196
-			MX8MP_IOMUXC_NAND_READY_B__USDHC3_RESET_B	0x141
-		>;
-	};
-
-	pinctrl_usb_hub: usb-hub-grp {
-		fsl,pins = <
-			/* USBHUB_RESET# */
-			MX8MP_IOMUXC_GPIO1_IO01__GPIO1_IO01		0x4
-		>;
-	};
-
-	pinctrl_usb1: usb1-grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_GPIO1_IO12__USB1_OTG_PWR		0x6
-			MX8MP_IOMUXC_GPIO1_IO13__USB1_OTG_OC		0x80
-		>;
-	};
-
-	pinctrl_watchdog_gpio: watchdog-gpio-grp {
-		fsl,pins = <
-			/* WDOG_B# */
-			MX8MP_IOMUXC_GPIO1_IO02__WDOG1_WDOG_B		0x26
-			/* WDOG_EN -- ungate WDT RESET# signal propagation */
-			MX8MP_IOMUXC_SPDIF_EXT_CLK__GPIO5_IO05		0x6
-			/* WDOG_KICK# / WDI */
-			MX8MP_IOMUXC_SD1_DATA6__GPIO2_IO08		0x26
-		>;
-	};
-};
-
-&pwm1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_panel_pwm>;
-	/* Disabled by default, unless display board plugged in. */
-	status = "disabled";
-};
-
-/* SD slot */
-&usdhc2 {
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
-	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
-	vmmc-supply = <&reg_usdhc2_vmmc>;
-	bus-width = <4>;
-	status = "okay";
-};
-
-/* eMMC */
-&usdhc3 {
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc3>;
-	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
-	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
-	vmmc-supply = <&buck4>;
-	vqmmc-supply = <&buck5>;
-	bus-width = <8>;
-	non-removable;
-	status = "okay";
-};
-
-&uart1 {	/* RS485 */
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>;
-	uart-has-rtscts;
-	status = "disabled";	/* Optional */
-};
-
-&uart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-	uart-has-rtscts;
-	status = "okay";
-};
-
-&uart3 {	/* A53 Debug */
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart3>;
-	status = "okay";
-};
-
-&uart4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart4>;
-	status = "okay";
-};
-
-&usb3_phy0 {
-	status = "okay";
-};
-
-&usb3_0 {
-	fsl,over-current-active-low;
-	status = "okay";
-};
-
-&usb_dwc3_0 {	/* Lower plug direct */
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usb1>;
-	dr_mode = "host";
-	status = "okay";
-};
-
-&usb3_phy1 {
-	status = "okay";
-};
-
-&usb3_1 {
-	status = "okay";
-};
-
-&usb_dwc3_1 {	/* Upper plug via HUB */
-	dr_mode = "host";
-	status = "okay";
-};
-
-&wdog1 {
-	status = "okay";
-};
diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index 00b5963b30e..d56fc7bf7f1 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -237,6 +237,7 @@ config TARGET_IMX8MP_DATA_MODUL_EDM_SBC
 	select IMX8MP
 	select IMX8M_LPDDR4
 	select SUPPORT_SPL
+	imply OF_UPSTREAM
 
 config TARGET_IMX8MP_BEACON
 	bool "imx8mm Beacon Embedded devkit"
diff --git a/board/data_modul/imx8mp_edm_sbc/MAINTAINERS b/board/data_modul/imx8mp_edm_sbc/MAINTAINERS
index 8a49c8a67d5..2b43b46b207 100644
--- a/board/data_modul/imx8mp_edm_sbc/MAINTAINERS
+++ b/board/data_modul/imx8mp_edm_sbc/MAINTAINERS
@@ -1,7 +1,6 @@
 Data Modul eDM SBC i.MX8M Plus
 M:	Marek Vasut <marex@denx.de>
 S:	Maintained
-F:	arch/arm/dts/imx8mp-data-modul-edm-sbc.dts
 F:	arch/arm/dts/imx8mp-data-modul-edm-sbc-u-boot.dtsi
 F:	board/data_modul/imx8mp_edm_sbc/
 F:	configs/imx8mp_data_modul_edm_sbc_defconfig
diff --git a/configs/imx8mp_data_modul_edm_sbc_defconfig b/configs/imx8mp_data_modul_edm_sbc_defconfig
index a30aaa57109..129bed9c2ff 100644
--- a/configs/imx8mp_data_modul_edm_sbc_defconfig
+++ b/configs/imx8mp_data_modul_edm_sbc_defconfig
@@ -4,7 +4,7 @@ CONFIG_ARM=y
 CONFIG_ARCH_IMX8M=y
 CONFIG_TARGET_IMX8MP_DATA_MODUL_EDM_SBC=y
 CONFIG_CLK_IMX8MP=y
-CONFIG_DEFAULT_DEVICE_TREE="imx8mp-data-modul-edm-sbc"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mp-data-modul-edm-sbc"
 CONFIG_DEFAULT_FDT_FILE="imx8mp-data-modul-edm-sbc.dtb"
 CONFIG_DM_PMIC_PCA9450=y
 CONFIG_DM_REGULATOR_PCA9450=y

-- 
2.51.0

