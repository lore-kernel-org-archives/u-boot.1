Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C6A3CD5BD2
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 01:19:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FB1584944;
	Wed, 27 May 2026 03:18:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cpDrJ3uI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8A3184958; Wed, 27 May 2026 03:18:48 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E49E08493F
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 03:18:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qp1L4FkFKNANxPi4IGxJ1RIgCyaXFuq0oC1sfdYxqFEjchIQFAagv/rO0btERvdPA7uRd/ogrQ0dBTVKsO10u4Rk2ASqnGUlJTJokxTqT78x7NK7HNXtcUasAQszcEh+7YoGqyP+dfpXU7NZd38L3vGXUqjUbpULEJMF4B8i6vAJeO0wa7t5smlyKzZNwIWLbIj0uHfNF0S6RuIMIP+Vorra/8phTZwu6aCvn8+kZo2CpKlp5k3azV2h7hcngpXDg5POJkkEq2uvoYmBRK/wJEf3T6IF5NR/0Z0X/wCmn4ycQLlHddDyMCHgXpKiGklL6eS+LwK6xHmN1ItKDx8BRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNghdyShugr7xxaQg6dELYLX2ocRqphwyKVWZqfD+Ec=;
 b=dYbFMBq3w+cwiph5Z4p4v8KwUld4MEk48LRQRa4j/QFeA6D1ejke+e+Sk5tHYsbj8dTRXxN+9OWQwGSnhpIajJpMfZC2k85Dd00dOWYkeiEILJHCnnq2mYyC9H1cEuBhCeVHl+HS+THQxdLRvWY8RokWew2187IyFD8dszYAnQJaqnmsaNKpRRSJ/9kyRhIjo+5TFBm6sMq6pn1GxsfykeQI22RExHsggjMM0aIx1C9q25Xnc4DULBMlJCcSwgVCJf9JWOJYFiqY7E+HLeyPdb56WImuQIqVQCRA8jyqgvTxDs66KXXBpO2b+P3/cUXCSPBVzpgN/L3Oeiz/m4gdGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNghdyShugr7xxaQg6dELYLX2ocRqphwyKVWZqfD+Ec=;
 b=cpDrJ3uIiD6dgHQ/fOWIHDGA/XOqDr9t6SDLU5YQEsKlpDd8u6FrTgjvuuAIM77lhMahZWdxNEc6XFVPSEjUlyjtmGqSWWfJfflYwkMXLSKnZI+UTi16eUdi05z0DycluPcNPVyAzA1AfuQYKvRFxA4hPsBfskgjzYUZ/emSXAbBU/E3ittxwzaMm4Vg/cNK89uW5lNb7J1csjR+pgorLR4x8W4sBGaurbrPsTkb4Mkpap1+QEDeXG0qdGrZDG+I4tnXjOg9o9vpNczRRVPnGfLZ2Y4bsm0bdjP8FbhEHWUW9P9bP7jX67zXrNEt2cqrUBpCW6xKMoOowgc/mpIZEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA1PR04MB10208.eurprd04.prod.outlook.com (2603:10a6:102:454::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 01:18:44 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Wed, 27 May 2026
 01:18:44 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/5] spi: Convert drivers to dev_read_* APIs
Date: Wed, 27 May 2026 10:35:23 +0800
Message-Id: <20260527-devfdt-spi-v1-0-37db1f6c168a@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGtYFmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyMz3ZTUsrSUEt3igkxdI0tDw2RzIwNDIwtDJaCGgqLUtMwKsGHRsbW
 1AMFMuohcAAAA
X-Change-ID: 20260526-devfdt-spi-2911c7201281
To: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
 Naman Trivedi <naman.trivedimanojbhai@amd.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 "Noah.Shen" <noah.shen@mediatek.com>, 
 Meiker Gao <ot_meiker.gao@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::11) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PA1PR04MB10208:EE_
X-MS-Office365-Filtering-Correlation-Id: 1073cd79-30c8-46da-2fb5-08debb8de4ea
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|366016|19092799006|1800799024|38350700014|56012099006|6133799003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: EaG4G4eMM+UaDAfat0zsPtcQ1oLCtvs8+RAtXnhwd8dfsCeb4ZGFbIsjc0L3HerHPG8xlrJ4k5sF183ihOQKCXAtWQwNyAMkX+GvC0nAsIpUGSutyFMLiR8U9fwF+XbT6uSmLVJQBZnairxkXxmISbDS+sD+7aRyKjUixGh1Vb1NM82HHC1lsaKnhFEDxzfWdiPwwU7asE0IFHVDJFRGIaiMSQi6RkQgslmp9bJF1LzMVVRMtnKyL6wlAj1NPjuNx+Tx6hWAHC2YQ8z++DQ8iZp6ylYqhRLNr78XXcFFI4GJgNSFzXEkMytzVk7zpyDDgsWiJocrbBDnQOtlWjj0hjHa6Z7zp1HQKuQIgbR0zC3OKe/j/pmz5sXSe8asTSuJB8nox83rD+YbafKO8yF2GWYnfpJEzHATK/P2WAWSuC4XW2NflDzey4kmgYtktdqotUtFKFB+WbxBdxnBYAqpEKzItlS9HD5dn4G+kuVheAQHVUS7w5IXa80wLANATIaWNmN3sir8Bo5Ysb/8fVOsfsUNMlo/L2yXIbAyZxHeTNYPlbBgUH6CBuExeVWfFW3m0tMrMbEd1EorFLCjk/mJR/von9KX8RGiYMV8uILCY+Tf2kJiHm7em+0PtN1iP8lXL5vo6zwq+qMjoI1mqv524dg905wh3ILsrX0HV3E2AEEDipGJAQSAhoAejMp74iJ2WMShul8/m95CXnXRVbqDlLKLv45501Oke268ioMh5AORPh9hnTyIwa3NiQwErAzX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(366016)(19092799006)(1800799024)(38350700014)(56012099006)(6133799003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1pMQ1c2Y3NJKzl6N2huNmdLVHlmWE9VVXV6aHFKTS92MkVQRmF0OFBJQ3lT?=
 =?utf-8?B?UkNFdUJWbGZ5RXVMSEhLYVA4bGQzeG1TYjBPM3JvYkZTN2hLNURkcU84TE1S?=
 =?utf-8?B?VjhQSVVlb3d5aTNHblZNZ0J6WHl0ZlpUWjJJcnl6Mm0velhFMmIrcElrSmEy?=
 =?utf-8?B?dTVDaEtEeGlnbXBxenhVS3gxV3lmTmliaDJ6Sk9ETTAyWm8wMVVjRnZ4RHNz?=
 =?utf-8?B?bnFLdEI2Tk5YYWtUWWUxMGp3YTJYQnQ1ZzlrUVFqWW9Yc2VVNElSY3FkMld2?=
 =?utf-8?B?L29qQ00rRkhnSnRaN09OVko4T2doRkI0dlVUa24yc3VCOFpMM0xlckdBdHhz?=
 =?utf-8?B?L1dBeStEd0lvU3piYmxYaEZhbklEV1NpVVpmVG0rbmR4Qmx0RFA5MjRzNGh6?=
 =?utf-8?B?azJiWE9wdmNlTlVKN2pmdEp4bFhIdFRCRmJ2SEZmUGx3aC83ZWlyT2FUUDFY?=
 =?utf-8?B?b3FmNjcwbU9XWU9XWE1GMFVEL1pObzV6b0ZRbGd4a2lRSitrTEVUOVRqSlJD?=
 =?utf-8?B?d0lYaG9Bd0hkbTV3UExWazVpTVVnbThPN0trVUZCaFI4Q1FrWWducnBZVVBH?=
 =?utf-8?B?MXBCSXYwSHF5MTJtNEh3eGZGMEw4NEF1by92RWhKdG4vakg2NkZBUWZsYWIy?=
 =?utf-8?B?SlpjYm02UFJWdkd1KzRFejd5ZUpXQ2tnb0JPNWc2cDhUZVIvQUdwb1JiRlJo?=
 =?utf-8?B?b3plSHVEZFlvU0NHYVlCY2R5eG91Q2w4ZXI1ZkRNdVNKZWVtTkx4OGxFb0VQ?=
 =?utf-8?B?d2NaZkJRdkRla1RGSmh1N3E2elpmdmRMNzh3aFUrOG00akdpbmlqZ1VFek5O?=
 =?utf-8?B?dTdSZDJPMXE4clhrZ3FrNnBSdXUvejZjRFZYaWpnYkUyb0pySmh4ai8yYjdi?=
 =?utf-8?B?dEdrMFFlbGZtQmVoTzhNcDNkQVZpUnJ5UlFjTDFWK2g1SWl0RzZ3OHlMeEo5?=
 =?utf-8?B?OUw5UUkxZVlnRmZRbUVKVXRjZllLSjlXUTNxWjNwTUtmcGwyZ1NMTWlvejh6?=
 =?utf-8?B?Y204VmxnK0NMdU5jeXZhV0p0RUxCenFKNTFaQjk4U3RleW9OQllPSGpXOC9h?=
 =?utf-8?B?aW1Vc2pZcGtieklnMzJ5cFIrZTFac3NiVlZrMjV4L08xUUtQam5HdXlucEJm?=
 =?utf-8?B?RitOZTN2bTNNZGIvY3k5a3hTT1hDRmQydFplMzJoZEwya0ttcnJlWXgwcWlP?=
 =?utf-8?B?UlFGQ2xZMlhSTGpJSVZtd3h0Q3BSZ2FqdElxcXRLWDZCZFJneVZLaDZ1WnFq?=
 =?utf-8?B?S1VXTEFyZlNWRmxmTnhQWHQ0M1crT1RSZFFaMXJOODdXVGZTSGt6OGFDdTd6?=
 =?utf-8?B?UGIwWng1OXJRMlliOUYzdTZjSW9XQU1NcUhRWTRWV3NudmZKbkF2NkNYamJD?=
 =?utf-8?B?dEQ5VVVJUXpjTitYVkpxdGNmZEZCVlV5NGxKMmhRdmlIRDRVa0JNL3p5UU5N?=
 =?utf-8?B?NEF0eTlQVG1MYk5LYWZhekxnQVhoRGZRdXlQMGl5ajZ1RzV2VkdMQk4wUlRn?=
 =?utf-8?B?Q1F5aWt0cVJRUkJaZnplVnh2alZ3cURtZTlyMzU1aDJkQjViRUk1TEQzZ0da?=
 =?utf-8?B?ZWUvb210QllKanJCOE5NV2VxYnpBTTdFSTNmOWQ2bGtEQnRIMkRyRzAxNWda?=
 =?utf-8?B?YU4wa1Z1UjlDSG03dXNjTkd5aTlGZFhyWUhmVGF3dXVsdGpXNjlReGxPUnBF?=
 =?utf-8?B?NjJrUTh6WFFQRlVkUUl5N2tpaGc0VG1IYzNUUXp5cnpZOEZwbEQ1QVJUMjlt?=
 =?utf-8?B?elBRZW1sRklGUFh2Sm12ZUJyQk1EcDFBek0zUW96aE85WWZ2emUyQUNTcDkr?=
 =?utf-8?B?eHFQOHdpZTVYVU9KUW0yOWNGVzR3N3FER25waHIwNDR5QUpGZXBhVHFKcDli?=
 =?utf-8?B?cE95ZFFnL3M3ODJJTkI5SUdqYU11ODdMNW1PcEl5MkxzSVEySVROL0t2VUxm?=
 =?utf-8?B?TVpIQTErVXJVQ0ZNNnhhQnhseU8zVk05Rkx4NU5MTGZkR1QvQ200NHVMMDJt?=
 =?utf-8?B?NWQ1T0xIR0pXekZCaVFhTWZoVkVmZG5yS3dYMndVOGxKd2NsNXV1VVo1emFO?=
 =?utf-8?B?OGJ4VEZVMGs4Yk5aUEt1ZmcybDJsTzlsYWdJUU1iSXU3NmdDcjJCQ0hnRHIy?=
 =?utf-8?B?RDJjQmpIbUg1RC9aMGJqVFB2NzBHSHJOUklGTWU2b2ZNbE52SS9TdmpEOS80?=
 =?utf-8?B?eWE3RG9ncnJaY1VrUEptOVo5WUh3Ymo4aVo3OENUYUdKZjJMNXdlUHpqOEVD?=
 =?utf-8?B?TjNpbzVIRTNBTFpzSnZ6K09GZHlXVjhVZlVwNHNkL2NYZUVHSWR6Vm5OV0ZR?=
 =?utf-8?B?bnJUaTVoZDVrZUI5UU4xbDN0c05GTmlaZEI4N1FmZ2ovTFV2Z09Zdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1073cd79-30c8-46da-2fb5-08debb8de4ea
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 01:18:44.0194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aB5brq9uhdco0G2VUkhEFnX3Z7nGr5DisLAzSqEADGtyNlPeVKVWoV7CqiAD0+hCGGwDkRWLwkUr9PJdnA9tXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10208
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

This series converts several SPI controller drivers to use the
dev_read_* APIs instead of legacy devfdt_* and raw FDT helpers.
The dev_read_* APIs provide a unified interface that works with both
live device tree and flat device tree backends, avoiding direct
dependencies on devfdt_* helpers 

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (5):
      spi: spi-aspeed-smc: Use dev_read_addr_index_ptr()
      spi: cadence_qspi: Use dev_read_addr_index_ptr()
      spi: mtk_snor: Use dev_read_addr_ptr()
      spi: nxp: Use dev_read_addr_size_name()
      spi: ti_qspi: Use device APIs

 drivers/spi/cadence_qspi.c   |  7 +++++--
 drivers/spi/mtk_snor.c       |  2 +-
 drivers/spi/nxp_fspi.c       |  8 ++++----
 drivers/spi/nxp_xspi.c       |  8 ++++----
 drivers/spi/spi-aspeed-smc.c |  4 ++--
 drivers/spi/ti_qspi.c        | 21 +++++++++------------
 6 files changed, 25 insertions(+), 25 deletions(-)
---
base-commit: bb354d04459f5425318aeb8a70bae995ee573f1d
change-id: 20260526-devfdt-spi-2911c7201281

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

