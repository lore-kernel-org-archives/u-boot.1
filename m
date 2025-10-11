Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2965CCD184
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 18:07:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8841A83A3B;
	Sat, 11 Oct 2025 20:07:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="c4z/vWsX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D82283C2B; Sat, 11 Oct 2025 11:07:12 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D86783A8D
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 11:07:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AvK+8+gOPyvE7jTjkFmRCm/i7MYcMLOnG2pdN1PBdxoYFX5ImVgjTj8tH2yMiK5wC7v1PUZKnqLcXmIRaJp8j0H4ePuX/i6pOCmeANgoNco3HN0gxwvvicKKi6E4ynnFwojNrLHrkPwjBwJenZBqcvTFGCKmHyk5DgYAAbIvU3YDHGNUtpOMc9NM878XvoqLwt06ZdTR+f31yCmp65ubkGfB50Y3VX04/FaXpYgGeDgW/63pB15fND2xNtqq9R2+CPfIU5KNSmgty5wAiy1Tk17qlNsydt1bGzVozhObBf9nh4HUve7Q3vN0x3KMzhY2Ep5Z417M5AmDvESOBopkHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnY50a1M1a+qNf8/41z7eItKB8Lt5t+slkAwq4vNfdM=;
 b=SrH44yA+3BM2BePifHfQ3c/CPvWcCVitVGLZXk0lLCiiL0OZ6WYM2yj1QagxB+3zFsQhBCYxvDOc2FwvsdKuF6a2LI/CWzpbnQ+kbNwD6V6uykKksEtpVSbtG9ub/ItchPcg3RxMeNcRuQOaeP+tkqb6eZmXNReE6bLNqJ+Rfk/CwtQkEt1r9xYrFfMy2s6toui6SLhsLttjPbMU/Oa2+MduTtT/1GGQl3SG46ciQ6x6eku2cVKmswrW6ArSwONXNYa7+da0/4WGVqCENSFPQCBRU5qG8Q7mRUmUe4fn6Dgxcl51nkfpy76XN4v/VvcBXFfvRYT7eHgsE62N5EKuaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnY50a1M1a+qNf8/41z7eItKB8Lt5t+slkAwq4vNfdM=;
 b=c4z/vWsXRUwE9xWqPABWSffiVZAsdQdhYLeqq0P4Ic98NVJJ8WLHQA3RLqYoSloD4KQpxrfMdXfmxN63MSPBWqgSG6QtxvbTdYeZTp+OmiEW2MhIPALM2QsdJrLJ+wvm+45M76cpJZR2RMPk7JTrqWpWd+VtIov2SSTSy1+I3NuYUvKfybDQa5Y4xNcd4drIMgfHQboULx9jhyqOBrpAZIppUwS/3jVCaztpFJuXMzoAfhMHlLCQm2RJW/5hoLGUtf06498yQMdzXgTlrewS7FBTVyrw0irINDHsELFmWEuIk1WLELIXUDFKzKITaGFiLOv3x2YcIFY5V1TabUMucw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU6PR04MB11160.eurprd04.prod.outlook.com (2603:10a6:10:5c3::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 09:07:08 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9203.007; Sat, 11 Oct 2025
 09:07:08 +0000
From: Alice Guo <alice.guo@nxp.com>
Date: Sat, 11 Oct 2025 17:05:41 +0800
Subject: [PATCH v2 02/10] arm: arch-imx9: Add USB2.0 and USB3.0 base
 address definitions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251011-imx943-v1-2-3331e2dc3a35@oss.nxp.com>
References: <20251011-imx943-v1-0-3331e2dc3a35@oss.nxp.com>
In-Reply-To: <20251011-imx943-v1-0-3331e2dc3a35@oss.nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 marek.vasut@mailbox.org
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alice Guo <alice.guo@nxp.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, Jindong Yue <jindong.yue@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Minkyu Kang <mk7.kang@samsung.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Roger Quadros <rogerq@kernel.org>, Tim Harvey <tharvey@gateworks.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Hanyuan Zhao <hanyuan-z@qq.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:4:186::9) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU6PR04MB11160:EE_
X-MS-Office365-Filtering-Correlation-Id: be358a10-7ab8-4ef5-9bc6-08de08a58e24
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZmhyVW1mcmFSbjhYN0lzSkRMbEloNE0xNHFIWUd0OW4za0dzVW42TUx2TmNu?=
 =?utf-8?B?ZFFPdVVNcG9PaTE4akZ6M1NqbzhJRXJGVGpxZFppV0JnWXZQN0xGVGN5R2Yz?=
 =?utf-8?B?RUpxSWdiU25HWTdzeUt1VkJ4enNyUkYzL0w0dk54aEE1UDZPV2QxMUNFaDVV?=
 =?utf-8?B?VXZRenUxTTB3d3pxZ2VaVVlYM2QrZk5RWG9CckdVM2JaRU93VEFqVGoxWHE2?=
 =?utf-8?B?WnhHWXlXUGN2dVZ2MFpLMWx2ZEM2SHl6R2w4dDRlQUdGZ0dCem9uZXdGZWJU?=
 =?utf-8?B?OFBoTEhnRkRBN1lTNlRETHFNNUVwQ2dCKytXaDB1NnlLRXF6SmdnNWFrdDdS?=
 =?utf-8?B?T1d2TGpWMXJocUx3ekNDZllzdW1vYWxLTTJsN2YwQ2h3bVZFU0N5V0hNOUFX?=
 =?utf-8?B?UElIT01kaE1yREhqejM5K1Q2NlBaSWR2R3R4Yi92NzdoVlN2U2p2dW4vai9L?=
 =?utf-8?B?YTZhRWYzSS9YWWhUMmsxRCtpTVdsVWVRVmRBdDZrK05RenpIS2c2enQvY0o1?=
 =?utf-8?B?dGVSQ2liSTJFMFJ3TmNRbU0wUXpOWlVDN0JwZFhYM3JMNmZPeG50OVZwYWVH?=
 =?utf-8?B?dVIwZDV4UkFJbGdaMlhydUtWNmRkMTc5Z3g2N3dsaFRiZGdTT0c2ZjhUdUJI?=
 =?utf-8?B?M0U0dVJIOWJuZTlOSUczYjB2eFJKTnNxTnBQd0FyVW95a0oxaU4rUzZTbzM3?=
 =?utf-8?B?SDNoc3BEYXA0YWNRL2RXc002ak05VVQ3WlRJMDk0Z2hoMDkvdGVLTitYa0VW?=
 =?utf-8?B?RS84VnhuNmluZXV6Wit0WEhkSGdSYngzYjdMVmM4dEJGL3ZlUHdDVzNwTEU2?=
 =?utf-8?B?M3BRckJ2RUJhZnFPOXN3QzVXS3dwVXQyKzZjQmQ0Vlpybk94QVBoM3FCa3A5?=
 =?utf-8?B?R2gvNFRkNVo3b1ZvQXg3RlhBS3d0bTMwa1FYblp0ZWxLTmQvRVM4dlhkYnJ3?=
 =?utf-8?B?QXl2L1V5eXkyR2YrQjJ3L1VUU2RvZ2lma1c5K1lMTkd4a1YwWWhlYmpDRjlH?=
 =?utf-8?B?aFpXUTdKSnovc1FFT2VXWDR2a2NTUGZZV3E2VzYyVUp6RzY3MVI1V0F5WlJx?=
 =?utf-8?B?SzlaRXFDd05raGlVMVpkQ1p5RFlrbVkzOGRJVHBSSXEwK1FZdlM1SXlqWHdZ?=
 =?utf-8?B?c0pqaGhqRFpTMGJldGsralVnM0NVbzV3SjN0SzVqeDEzSzcxSnc5T2N0QU9G?=
 =?utf-8?B?MDVNSzdWdUJHaHF6YmFQMlRHd3VVd0pMWVJiMmUvNHJhNysyU0Z6dFd5d0pR?=
 =?utf-8?B?MUlmVjFpWmp5L0IzcTZXdUJTS2k3dDJCNzh3ZjI4QndaQ0VSN0cwUnFHcitl?=
 =?utf-8?B?VWFEODVnejhaRzI5enljanQ3NGQ0My9VQmplTHlKYnlaZzU1R081T0VSOG82?=
 =?utf-8?B?OS9RazZuaTRXNTU5akhPbC9VRE1nZFlhRXNxM2NiUWYzMmYvRTBXbnY2aTU0?=
 =?utf-8?B?QUxta1VIckVSMGpNdlZBdFVhVGFRTS9NajM3M3RQQlUyUDBibEhsK1hzbm5o?=
 =?utf-8?B?VVpybDZobWYxODhyTnhnSnhiY09JaHlOSGJKdXNBak51OFhzaTFLcGFSanJ2?=
 =?utf-8?B?ZjI3Skc0WmlzTGNKR2liQ1ZQYjVYOHI4bjhCZGR5NXFEV3JSbEVCSVMrcisr?=
 =?utf-8?B?Y3k4SzI3a2FMemo5R0tmSWxsSjdoK2tIYjdzME9SYm1IdHg4S3B3TVd2VnRs?=
 =?utf-8?B?Ukw5TThLSzc4dkFkNWpmM2FXQ2VXRmZkL3FLU09BazlKMUwzMlU3NFRWVVNF?=
 =?utf-8?B?UkgyNm9xM3VkOVZ5OFRodGVZUms2VXBHNm1IMzM0UC9SV082N0ZSaUg1cHZ4?=
 =?utf-8?B?Y1I3Qk5IMG1paU9IZlRVWERNWVJ3eldvQXg4UmEzS0dXMzBVNWw3UFd5bmJQ?=
 =?utf-8?B?Z0IzUmRzM29qeEdoUmt2WW9CVTh4MFpPOVlRanA5b1NpY2JuREVYMEZEdkpB?=
 =?utf-8?B?K1ZRL2lQaGpDNUN5MFI3dFo5aHJMMUJLYXRLV1M0dy91NG8xcUV3dGRzeksy?=
 =?utf-8?B?Tlc2NmJNNDRva1pYNEV0VkhiWjljZ3V3NktNS1FaTFhwZ0gwd25qMVZ5dXdL?=
 =?utf-8?Q?R9pc07?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(52116014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXVlK0YySnNpcWZvTVlaQlVtenR3azdEV25WTVZrQzNIRXBPZU1kMEhoV3d0?=
 =?utf-8?B?TUc2M1QxeTkvWVVaRjJkT3B3MHZnRmlMVkFJeTB1TnBJTUtLK1RuLzByWHJx?=
 =?utf-8?B?eXMzekxVeDV5WHJUWk5RRkFTRmVjNzlEdmo4Q25TZ0ZIM0VraWhIUzFGUHg5?=
 =?utf-8?B?cnVuakd3MytER0pPa3hyVjFEa291N0ljaUZvTXlmaDROMzlkd0c3S1g1Nkpx?=
 =?utf-8?B?aFB3d1FoTnhPeEl2L3RIVXV0ZTFZb1dMUkhmWFRxNEF6SDdFTTlwSFdmRVd2?=
 =?utf-8?B?ZGFSTFltZUU3OFBPa1F4Y21uK0hEZ3p0M0wyU3NXRXVHTWlwcWVYNjBlY1FL?=
 =?utf-8?B?aUJ2Z3JsVWNRa25YTTVld2ZQUDArZXlabk1PbWRlYms0eFpkZkFIV0dtcnlk?=
 =?utf-8?B?bDJ5b2taUjlpYUUrTzl5L1N0SnZDWGxtZEZVRUlWMXdVc1psYmwyOCtNUlRY?=
 =?utf-8?B?Q2V3Wk5ma3hGT0VXQlhxYXMzNEhZaHBnOVREWFB2YmlmT1FGL01XK1BCM3My?=
 =?utf-8?B?WW4wSnZZcnVET0k5d2NXVExuS3JhLzVVY21xam5JQ3Y2WmlPZ2JGc3k5ckxq?=
 =?utf-8?B?Tmd6RzhVMVVMcXdVbnFrbnJFNXBpUnpQeXozOXJvdlp2UHlXcHBOSHJRV05h?=
 =?utf-8?B?d012NkxQYzdmbFFuSkgyVmM4cDJKZVF0TCswRVRROWZLUXR6eHJ3VlhleFpF?=
 =?utf-8?B?bDNZU1BsTUpUanZGNDdTdnJ3R3pvV2JuQ1dtN1NSbUZnK0paNDdnS3d0NWFa?=
 =?utf-8?B?ZFduWGJvcFlGeEFxUmwxbnJQVWVLQkZCWUhqOTU4U2kvdzh0MUdMWW1ZWG1t?=
 =?utf-8?B?STNnSlBVOTk1OXNKY0pkcXdOcDUxR3FSMUtzNnZ3MVNkK0FYZkNwbmorSlRH?=
 =?utf-8?B?aFhod1ROb045OFNaUStWRmwyYS9LcVdUdUlSWGRYTVVFWTM2aTNQeXhEYVMv?=
 =?utf-8?B?dWw5U1JWWjJwZlpFci93RjFFNG1yMDRQclZOeUJJRFJJSlhmSndzVE11NXNN?=
 =?utf-8?B?L2c2WXV4bXc0WW1ETUVRZUo1eEJiYVpyOHBDWVgyOGdyeDdzbllzVUNNUDRI?=
 =?utf-8?B?ejZtSGFtd1ZnQSsrbzVzbEpsWCtDdExmeTBOMDBMNE1PZ2I0TTkvT2N4MXl5?=
 =?utf-8?B?N2V3Ny9hTG84S2x5bDRXVVcxTkE0cmYwYWJFRTJVK0lxV0lKRjNEa2I1Z2xK?=
 =?utf-8?B?amhJL3lOczZmelIyZ2FkQ2VMVkJNRUxnRlRCVFcrWEdvQjRvOHhVT1Z6VmVo?=
 =?utf-8?B?MHVQZWQ4WDhsMGJWSzVxRzNyZjRHWStBS0UyQXhQbFExV0hTS0dUZEU5aW1j?=
 =?utf-8?B?SjZ2bW0yc3RUVW5KSTZpdCtuK1N6UmxnZk4vNFZGM0J0RmNsbmkwYU5OVHdQ?=
 =?utf-8?B?V0VZWTAyM3RUcHRaeVp5T0xZZ3piVThHYnBoSUU1MVhhc0V4d08zV0V1ZjVu?=
 =?utf-8?B?cGlLenc3d1UyTHlwS2ZjVTRkMHdzVmlvM0NhYlpmd1l1VjFhM3RpTU1RT2wv?=
 =?utf-8?B?b0JETzFkclllMjVjaHBWU3QyZEx0MWVWaTcwNXk1TGxzazdhUjdvTXFWcUN4?=
 =?utf-8?B?VEtxVTNiTjVqUGNSVnlPVmxEbDUvQWo1N1JYVE1qVWM2RDJsTXNQQXAvWWR2?=
 =?utf-8?B?M2FRQnBkTU1hQ3NwaDFGcWNxUTBLZmp2YzlQVWc4UnNJMGJ4YWhGOWRFbEQx?=
 =?utf-8?B?dnBUUWVOUWlQaGlndm1pOFFKU2xtQ2Jqb0hOakNCRTVPb29iL05SSlZkREFM?=
 =?utf-8?B?WEV5K05xd0FjOVNvZ3FQbHdUQXR5ZDBFak9STThpVTlZZHNtZW1WeDkyWHkx?=
 =?utf-8?B?V0UrYmw3dU93cGw5aGkrazJjbTE5RG9OUzNFejFOSnpkY3JhVk5MbE1WVDV2?=
 =?utf-8?B?ZHVGOWtEcytBdnFPcVVCeWtGNlRNQm83MXU1S25VcmttcFpjOExJdjBLY3dq?=
 =?utf-8?B?WS9JWGFDRmFmUEliVmdmdEJXKzZ2eE5MdXkwRkRIOEh5VWFoM01FczlRMHdV?=
 =?utf-8?B?Nzd4OWVkbHNCWEJHeDYwbDJmQldnMXgwVEZRclBKVlcvYVlvVVpOS2d4NUNk?=
 =?utf-8?B?dWdrMUp3TVJOdGo3Z2ZEVVU5YWZCUmJURnhRUDBkWlpMUTFKMnhvNjUxT3Bs?=
 =?utf-8?Q?MXz6okn4oC/PAl+8c+vd7knFl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be358a10-7ab8-4ef5-9bc6-08de08a58e24
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 09:07:08.2219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6mIpWUOg8R+c1T6FpApd2BqsjiyTj/UxCJhlLT7n4a8HiVLrtqHailGLCApWjnCFrEAWEENU+yb8LrCh9cfQzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11160
X-Mailman-Approved-At: Sat, 11 Oct 2025 20:06:59 +0200
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

Add USB1_BASE_ADDR and USB2_BASE_ADDR for i.MX9 platform, and define
USB_BASE_ADDR as an alias to USB2_BASE_ADDR.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/include/asm/arch-imx9/imx-regs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/include/asm/arch-imx9/imx-regs.h b/arch/arm/include/asm/arch-imx9/imx-regs.h
index e641ed299c0..2d084e5227a 100644
--- a/arch/arm/include/asm/arch-imx9/imx-regs.h
+++ b/arch/arm/include/asm/arch-imx9/imx-regs.h
@@ -39,6 +39,11 @@
 
 #define ANATOP_BASE_ADDR    0x44480000UL
 
+#define USB1_BASE_ADDR         0x4c100000
+#define USB2_BASE_ADDR         0x4c200000
+
+#define USB_BASE_ADDR          USB2_BASE_ADDR
+
 #define BLK_CTRL_WAKEUPMIX_BASE_ADDR 0x42420000
 #define BLK_CTRL_NS_ANOMIX_BASE_ADDR  0x44210000
 #define BLK_CTRL_S_ANOMIX_BASE_ADDR  0x444f0000

-- 
2.43.0

