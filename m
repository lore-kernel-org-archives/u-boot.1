Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12425E8FDA2
	for <u-boot@archiver.kernel.org>; Fri, 26 Dec 2025 14:29:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7134583984;
	Fri, 26 Dec 2025 15:29:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fbV0OrMv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6065D83984; Fri, 26 Dec 2025 15:29:06 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C32C8392C
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 15:29:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=usFSqPCl0rC2xKRJ3ffeAFDTmvMdpoyXDH2qU6+sKwMTj4QJjGvRfRHW01hrCwf4IxtMtGnPGT8e+bTEOvVt8Vfk6BpR+s7ZBUv1XgpKHa6dMBVlins3qOQdSsj/++WN8Y1XQC85OAJOxY7zMd947CIXJETdHDkUAuyPPwMGy8T0sr0hIXieMKksy1KY4r7k4+am3OzWGft9OxPfoPCatboiCRn/ysANkJHc9x/z9F+jtsLct6xAPPq5bm6QQbtEFd95XgmZTRu5RokU2150l4yWbCOzdAPsWC19StsxJ+9cgmwmJvCHxXyoeXjIHqNta7TcSUHtQvHesn7z2cSLDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELmFm3GEvcjdI1dDPAXpigAaIcqv/JOdf2HpiMu7/kw=;
 b=laSD/ohIwSR/fP8BXtoww/upX8PLP28cONajFAn0yOu4h3bv4j+aDnLegjsHqKfWImy0MRwMxj1UDWp3rpzm8vH1fCUO4YiZ5Jiidn8w/m8SDWC1qA7v67+3A3xCOPZLeSIZcBlGGAed5OwNB9TKbx5i2Uwxyeejl8bOjq/oVd94Z0YnBhUz0XlNTPQY0Rm2PaCuAhqeeS+RXW1VC0mUKEOoePlDd4624PbkCTHr4Z/DZO0rx68/7ZoMsH+8jYbn/akmfF3BQDFvHyuN0Deexxh5lc6S4zUtqVQU/th6qHR0W5MCKJt6QeJWJ7A/s+s/N8w6v4ngG8q8QO2eFD5fPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELmFm3GEvcjdI1dDPAXpigAaIcqv/JOdf2HpiMu7/kw=;
 b=fbV0OrMvm6FtzptkbohJnf/I2EWXeuiXfUY27ZjHiMA33aL3RKOg/8GCNtHBkxF682UqDOxHFERTYr8E+RYxdQ50x70XSjv+ZoUiDZ+8lp9kq0vbX3z6+pwh1ExzhwzTboFD4BjYKmhauF5ZWyaYEoYmZVy5fkV6W2pH4denChN/TpP1nRzsVjXjYqRagz6jFOZ8VlpEu7gNO0fgqIWbnVIuRXNKtlUVpQm03kbG4qCp/Jg0F8w3weobo0Hj5XEYYb9A+FHqbXdsGQAj2QdvVsbZltrYjFbktXJtMglVnNQTQjkSJetvNf6MxbGE67VogB1GTir9U+0XQYRIyrWy5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DB8PR04MB7033.eurprd04.prod.outlook.com (2603:10a6:10:125::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Fri, 26 Dec
 2025 14:29:02 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9456.008; Fri, 26 Dec 2025
 14:29:02 +0000
From: alice.guo@oss.nxp.com
Date: Fri, 26 Dec 2025 22:27:41 +0800
Subject: [PATCH v2 2/4] misc: ele_api: Add support for XSPI SET GMID
 command
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251226-xspi-v1-2-4bb116750dba@nxp.com>
References: <20251226-xspi-v1-0-4bb116750dba@nxp.com>
In-Reply-To: <20251226-xspi-v1-0-4bb116750dba@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Peng Fan <peng.fan@nxp.com>, Yao Zi <me@ziyao.cc>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Heiko Schocher <hs@nabladev.com>, 
 Alexander Dahl <ada@thorsis.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Boon Khai Ng <boon.khai.ng@altera.com>, Ye Li <ye.li@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tim Harvey <tharvey@gateworks.com>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:4:197::17) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DB8PR04MB7033:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f1ff939-42c0-4461-4744-08de448b1dbe
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|1800799024|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?KzVuSmQ2eVI2c2R1WjBSbEVtN2p1M1BocnRZaC9XRGVpeFk2M3BjbDk2YjdG?=
 =?utf-8?B?dmVaeTJweWtHMDdqdnpBUGx4Uk9JVlRBQnVXUG9TL2UzODFyWkN1ekhkZzIx?=
 =?utf-8?B?YUZ0YjUwOXBlZkZxUEhCbElTYlhKMGZjNUJZWm03Z1BaYmdLQzF1TlBWTEJ0?=
 =?utf-8?B?ckR5V04wOUdjQ3BRMjh4czJKd0szM3hLdXdQYUo4TTIxQmFYV3krM2NWQ0ln?=
 =?utf-8?B?TkEwbHJMUldJb21PbmREREhCTVpMNlVmSllxVXdzYjdqZWwzNE96aUFVSWt3?=
 =?utf-8?B?R3hmZTRDRy9mbmVyOGM2Q0NxRTdra0tYaGNjZzdTY29ISTF5b1dvRU9jSmlF?=
 =?utf-8?B?THFBNlRDWW1ab2tSRlRGeGRTMWdhV0o0ZjZick5wVGh0VUVsWk84Uy9NVTdh?=
 =?utf-8?B?eWFhelB3RCs0ZDVOeHRkd01YNklNRHcxMjUxT2Z2RzYxakJGcUYzYXY4azds?=
 =?utf-8?B?VFg3UzBGaHdxNjJ4ZXpub1VVQ2tSdWJiekhxcEUrUTNIaG9JQ1lxemVCODRy?=
 =?utf-8?B?L2dkV1Z1YlczTVhwNWdYTjY5eXFtNU9Sa0MwMGxNV25CTGhRK1hBVldsRVBz?=
 =?utf-8?B?MVU1bjVMR0htSlpnMlBKbENJbGQwcUkyejlmNnd5QURlY25TUHR3bDlHMk5z?=
 =?utf-8?B?QWtsUHhKcDYxTFROcURzOGZuNXFyQitMV2hIb0lkTEQrTlZsbUVzQVZ1dG5S?=
 =?utf-8?B?YXJXS2ltMlM0cElZY0tValo4RW5kNFBrRDQ5emlzMjlwQ2tjTXNjZjQvK0pK?=
 =?utf-8?B?SlhoWjdmeVRLRTE3ZTBOdkNucGVUWm41aGpKUGFYdzcvZGFxdloyS25tRnFh?=
 =?utf-8?B?L1RDWGprQjdDcGg3UzdhUVlnV3ZNM2lxeGZmRjlvTTNkM1l0UFM5RkpMTGxO?=
 =?utf-8?B?NnE3TjFxakovU01TbGdmT0xvKytXZ2ExWDBZb0kwKy80cUd4TWU1eUpqUlZh?=
 =?utf-8?B?Z2RiNmQ0bVRPNWpsZEUybWlNYm9SV0tQbWl2dE40TDU1U08yUUtqamI4ajll?=
 =?utf-8?B?VkxBWkJHL2N5K2tMaEh4OUJQaklDUnZIS0ZpSHQycXRwR1k3aXUvZmROVnd3?=
 =?utf-8?B?ZEJwU2JZSmFFYzBEMEQ2alRQOFpXRHQ1MUtPajBSSkJ5VXBzZjNQeXcwS1NL?=
 =?utf-8?B?NnBKeGZzOTdVMFRDMTNJRHdOSUljMmpKbk5CZ2lhQU85RXo2ekxFaU9mRlNm?=
 =?utf-8?B?QTRoVU8zQjRGb0RDcXBKT05oNUwrSUFWOFhyL1kwMzhrdkpJZ1NQSmtzTVAy?=
 =?utf-8?B?aysrc2xUNjE2ako3YnVFRW52M3hWSzQ3aVFDaU82Q09yN1B0ci9zRER2QzRu?=
 =?utf-8?B?SjRBdW4wZmVGcU0xSG5UbmRLbHJWYWVHejdKbTFFUXkrUDg5emNtbTFKc0xE?=
 =?utf-8?B?ZEI3dnlRRDNqNkoydTVmYUlzc0tCbVQyQWhCdzlQK0NlY05tWCtySWZ3b0Js?=
 =?utf-8?B?anFpRlo5ZG5Wdlp3QUhQVmgzblh6RW1Xd1k1VWJZSHQreHlDS3JEd3F3MERP?=
 =?utf-8?B?Q1lxVWRCSjBJU2hpUWpLZ1c0clMxM3lVM3A4NGNsZlVwOVkreVRlclNIdDRt?=
 =?utf-8?B?aTBpTWpGVEMzZWxaN3k3aVNBWm9kMlUrQjhLeXNDS0dPOS9NRWNxbTRoano1?=
 =?utf-8?B?OWxET0FDb01RaTlHai9jRUM0c2txQ1BzUlUwQmZoamFBdlNPSjlUU3RPUnFi?=
 =?utf-8?B?V0JXUTlyMEowWUlvcVh0M3FHc0ZRcndVUmZOMXdrRmlkMkpjS0kxMkszR2xR?=
 =?utf-8?B?RmVTVWgwTmVtRWxxVHR4ZVpra2xEekU1MVlWTWQzaW80TXd1Zm1wQnNaVFIz?=
 =?utf-8?B?UWFSaXVPdGozSFJ5eGFsMmVZQzJRNkVXT1dFRzZXN1R5QUk5c0dxd1RVUFFQ?=
 =?utf-8?B?QkFwUEVFZkpFWVdGS05ZVEFiYUVMMStqQ0haakMra0syZEdRblRVanREMCtQ?=
 =?utf-8?B?MGpRVXFpUk1Uc0ZpRFdzUEtzaUtKU1FhMHhyektQaEpBNnh2Q0JFcmdDTlhS?=
 =?utf-8?B?dnk4NUwxT3lvaUFwNEtNenlqdkJKZDJBZ0FvMkJ6b3ZyNWxSUlR4Yy9EbGlx?=
 =?utf-8?Q?SZOFTX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(19092799006)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2RlczM0N0QzbWZFVGw3NmlkUEVUR1Ztbmo1UXN2dVpWM0FZeHVzQUVjczlZ?=
 =?utf-8?B?cGRrQmxPZmMxY2xiaURyZXZ2NndRTDBnaHhHaHVFR1RUQ24ybnYzMDlEaUtz?=
 =?utf-8?B?ak85bEVNZUNweTVvY0ZJK2RGNlpZNStrTCs1eXRSUzhJMmFBS3JzR0NKNThk?=
 =?utf-8?B?aGxyQUNBSXBIdEVJQXJRblRSdFdlNnk5b2Vmd290WEgwcjlLZFhUZnM5QW1F?=
 =?utf-8?B?R0d5R0VJMjB4RXlsemxaam9Ibk5mOGZvbmJ6VlZtSTJ3bVg2TjZqV3RPYWRn?=
 =?utf-8?B?SVV2M2V0cGVhemt5ekhsZVV4cXp5elh4RTY5L3V2bXhzWEhkQ2ZPUXZKR3VS?=
 =?utf-8?B?SEVFQW1TUm42YzVHRnE2TDNNamhuYjNyWWdpR0lETEo3QjEzNlRET1NrUDdh?=
 =?utf-8?B?ekJOOGFyUkdmZWN0SDU2NTZsbmpzVlZialpQZGpic25RSkU0TVdheW5XblVW?=
 =?utf-8?B?eTBBYWp3NytNYWNCSXpkVXNZWUN5eG91NjgyRmZyWloxSmo3QzNKQVNrbEVt?=
 =?utf-8?B?ZXo4S1h4bVFYdXhiN01KZVo2RGIzdG1KWjNucnBzNHhiRzBjWkoxSjZVRTdp?=
 =?utf-8?B?UjFxa2U2b3o1UGg2eTFHYU4xWWpnZWFjUlQxd2VyR1ZFNldTQno0OG83M0ho?=
 =?utf-8?B?R2dHWEY1TUMyWVJiQkIvUnVFTVA0NXc4OXFrWFhVOWQ5eGx4M3hSNzdhdmhW?=
 =?utf-8?B?bk41UDBlOFNXcHAvYmEweGdlZThMWWdUS2xwMjIyWS9aZ2JNeDk1Rmk2OWYw?=
 =?utf-8?B?QmJyZHpnck56VGpoOTY5MjFJRXUwKzNEWDdpTHlUSXJRMWlOMkFWN1JvSGcx?=
 =?utf-8?B?TXpXYlFKM0hKWk9BeGJXV09jYVc2UTJFbk1WYTZPdEZLZG9xNDdpaVZmZCtn?=
 =?utf-8?B?SU80ckdtcEF0TU45ZXJINTkvNDNZSy9KUFFtSHIxV2lnRVpqdjhyOUNGSG5G?=
 =?utf-8?B?VXBPSUJYcDlvZktBNG5PdDBHZmh2VDVvNWNPbjNLRS9CcmtzN2gzb0dCMnZi?=
 =?utf-8?B?TURMUnFUMkovM1dPYlBoelFxc1BHNUZFclRyUndvaDYyZzB1VEtKcE9QZjFk?=
 =?utf-8?B?Z3VGTkZORm0xMWxMbGQ3aTZ1V0k1cTAyQmljVHU1SlVvRDh3bmNmR25qQ0NY?=
 =?utf-8?B?VGI5YU5HeTU5QndsemdWbDk3WGg3U3VrZ1Rkckc2VklGbGU0ZlMveXRvYXlp?=
 =?utf-8?B?K0FFbzhMaHJmd1EvVXFHcSs1SDFCQW54VEFSTklDUmVLK051TDlWanIwREhu?=
 =?utf-8?B?NWN1OWkvczI0YWQrUytNNzBObG1GUTc5RlBTS05CVkZBenhsbzgxUW9vcGEx?=
 =?utf-8?B?OThsVjJUdmpQRE9qcWRGR0FtM3BNcGtVNVV3WU5NSityZ3dTcDFNbGxBZlJT?=
 =?utf-8?B?bHJjTnJlenRCTGEyanp6SXlKSzN2YWhMTWl4WTlFOUZEV2RFWkJwc0YzcGpW?=
 =?utf-8?B?eXgwVTVra3VDWk9iMW1yd2tXTGt6NmhoL0Y0bTdvWmdheld6WWNFd3ozQ3BF?=
 =?utf-8?B?ZW5yR0xjRkRSeWxNMW1QdTlzOGZud3liQkJuWDBiRTRxdm15endORU5HSjBw?=
 =?utf-8?B?alBqZjQxbUdlaDVmT0ExTG54WTNDNzZDVS9JT2dtQWN4MUN5ZUJEeFN4SWd4?=
 =?utf-8?B?aWRpd3dYZ2EvN3RvVER5ZDA3MTlkaEdkNkdoSUY2dEpRTHE2bmpHb2plZWR1?=
 =?utf-8?B?bTdrRG41Q2ZGclZwdnI1RGMrV1FIZlgxMmNBc1I2WHpkUWZrZlhqdlBiamw4?=
 =?utf-8?B?SXVRZ0lpSENqMURjZkhrVjd5UUhLOHZUU2J5MC85OVhtQ3VuQTRXTWo0MEFD?=
 =?utf-8?B?UVNYczBqYmZtMy91ZDFZTk1Ba0lDcXk5WFl0VVZVa3hjWCtyeVNQK1lGdjE4?=
 =?utf-8?B?WldZVFBXZ3hkOEhmSXhNVUlSbVlmMzBxcFBOTG9DK09rUU1yL2ExTFlxdnor?=
 =?utf-8?B?eU5GQkV1RkJjWVQwQUtWWU5JRENUZVNqQ29wQ1NOK1FPdDZzNmRPalovOVN1?=
 =?utf-8?B?TFRPTXRPK3V1aDIxRzJ2YnpBb0NVWDZERXlNTFhLZGROaEYwRVVYaFlzblB2?=
 =?utf-8?B?ZzNxT1NkOEthQmtlcWJBMEE1Z0lKY2g1dzlyR2Z4U2Fja0tpUzBkQVhVK3BV?=
 =?utf-8?B?eUprTDBERHA5eURLNzhSaWFZeVBXOFovL3lTSEU4THBIYWZGdWR2cGk3ZjVC?=
 =?utf-8?B?YlFTNDMrcGlHVkIxdzFiblNqVFJjenV1dDBMbGxTQzdBRkNTYW1WL296SFlF?=
 =?utf-8?B?SnR1c2swYWJETkFmQjArK0lxaW5IUGZ4MTRhWDFsbmF6dmN0bzdRdkczbjQz?=
 =?utf-8?B?RldJbE9EUmdtaTIxUVhmaWY0aHVOWXFORFlJZHB3YWNoMnQ5ZWZxZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1ff939-42c0-4461-4744-08de448b1dbe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2025 14:29:02.4544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oz0gvI8CT611g//UAaMzcvcFyKl0opf4radDtzF/bs6w//tkl6grNg9HKIdwqxFy2gPKeGx5Gorg6cY4GXdXbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7033
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

From: Ye Li <ye.li@nxp.com>

The XSPI SET GMID command is used to assign GMID ownership to the
requester, allowing access to protected XSPI control registers. This API
must be called in SPL if XSPI GMID-protected settings need to be
modified. Otherwise, XSPI configuration depends on the previous GMID
owner to provide the correct settings.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/include/asm/mach-imx/ele_api.h |  2 ++
 drivers/misc/imx_ele/ele_api.c          | 28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm/include/asm/mach-imx/ele_api.h b/arch/arm/include/asm/mach-imx/ele_api.h
index 64b243dcaaa..09511a7e0d5 100644
--- a/arch/arm/include/asm/mach-imx/ele_api.h
+++ b/arch/arm/include/asm/mach-imx/ele_api.h
@@ -47,6 +47,7 @@
 #define ELE_ATTEST_REQ (0xDB)
 #define ELE_RELEASE_PATCH_REQ (0xDC)
 #define ELE_OTP_SEQ_SWITH_REQ (0xDD)
+#define ELE_SET_GMID_REQ (0xE4)
 #define ELE_WRITE_SHADOW_REQ (0xF2)
 #define ELE_READ_SHADOW_REQ (0xF3)
 
@@ -160,4 +161,5 @@ int ele_return_lifecycle_update(ulong signed_msg_blk, u32 *response);
 int ele_start_rng(void);
 int ele_write_shadow_fuse(u32 fuse_id, u32 fuse_val, u32 *response);
 int ele_read_shadow_fuse(u32 fuse_id, u32 *fuse_val, u32 *response);
+int ele_set_gmid(u32 *response);
 #endif
diff --git a/drivers/misc/imx_ele/ele_api.c b/drivers/misc/imx_ele/ele_api.c
index 661f70cf870..e194091fa9d 100644
--- a/drivers/misc/imx_ele/ele_api.c
+++ b/drivers/misc/imx_ele/ele_api.c
@@ -794,3 +794,31 @@ int ele_generate_dek_blob(u32 key_id, u32 src_paddr, u32 dst_paddr, u32 max_outp
 
 	return ret;
 }
+
+int ele_set_gmid(u32 *response)
+{
+	struct udevice *dev = gd->arch.ele_dev;
+	int size = sizeof(struct ele_msg);
+	struct ele_msg msg = {};
+	int ret;
+
+	if (!dev) {
+		printf("ele dev is not initialized\n");
+		return -ENODEV;
+	}
+
+	msg.version = ELE_VERSION;
+	msg.tag = ELE_CMD_TAG;
+	msg.size = 1;
+	msg.command = ELE_SET_GMID_REQ;
+
+	ret = misc_call(dev, false, &msg, size, &msg, size);
+	if (ret)
+		printf("Error: %s: ret %d, response 0x%x\n",
+		       __func__, ret, msg.data[0]);
+
+	if (response)
+		*response = msg.data[0];
+
+	return ret;
+}

-- 
2.43.0

