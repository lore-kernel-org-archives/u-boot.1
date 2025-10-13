Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C6BCCD185
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 07:19:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93F61839D7;
	Mon, 13 Oct 2025 09:18:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Xqv63IOm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21EB18384E; Mon, 13 Oct 2025 09:00:53 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 122AF8381D
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 09:00:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F3nCEihSnA1e5MgiA2v2djpiJzgG1+EPIxZowsWzRS0xPDjf2tOJs3TgQ5XczSTjBOCCU/HLxgrwf9Chj5gujFJJrh2uutLyMNS/c+2Hz3SOf92jGqXGT0s3kbdQRcFa5rT3zWA/bNN5ADahgINa4BGmLc7eca2rwsMNHQOJ5Nas+Z5031eqiWFkE4Ln7uBP+G/MT3jQAZpIra0aJBbaV6l4FN8KemiZxX0p21rwFZvBJDam2k2LNDdjUGpi4eOurawNtz5q3kbhgaAtgBEc3B91U+xIbo8xfDd3mT+V6OcX09cUIk241EXkwB8xppw4FYqt0hnZivnmnRgZojD82A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxx/yXgr/0tVLQm/NgNnBZLu1mP6HEkRile7cpPTlxg=;
 b=KKmCOzeipKaQtCZEkyObFkWnSEWwXfyrWMrsMQMwDMwuo77CRZ1Nl8UkWmJ/ZQGYRGyb3CRbRQ0GZqS+npjZlFbYJ2r8Qtj/0LeAT2Vq7vINK9WvxRot+ikBbD5xP1A+nZgMQeb1Ftz3Mp+LxMshvguqYCbnlfBeBn6u+m0H4MVGh/DNAl8ytyqlIUiKqh/4yUcs+eduegiFnyNd3+Q4JU+a4vKeyMjY23AXPGvLr5RB16Iv/8slQPlNSZW9AKDdC4pBdVtH7P50GqhycryxwHBq6hprik4dmrKwvAT3M09WcZIFCGpvVfHgQrMgTpl+MFmdwvEt3B4ZBjIGpeVU6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxx/yXgr/0tVLQm/NgNnBZLu1mP6HEkRile7cpPTlxg=;
 b=Xqv63IOmXUBc3+7uDMFizUO83+YJTeOlBIsYdSNeU+2sKngurmS8rVjRW5T4EDIF5Qanc47aF+Mvxs5ABiu/v5KbqBVjDt6QQGlWHXV3cwTxlVlokEzS6UVvGF3YwRA/FtBuEXhnXF4EDXS7VGIQOIqAjIDiRvCIlLoTNK+LXYPzt/YRa9+a3GHYIn2cKEMmFVmC3oErjVw5gYfi4kRpDMDfvJy3H/SlBvd8F7OImiD9H+OwNOkwMGIG4iAdw1rflO5UMX7L0vIgmcZb5FxaWw79dsIlCZHDY0iDm0fiGKPBn9q7AoCgLfSnsunMBnIjMlmSdTTpW9BAIasWCLWkgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA1PR04MB10098.eurprd04.prod.outlook.com (2603:10a6:102:45b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 07:00:49 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 07:00:49 +0000
From: alice.guo@oss.nxp.com
Date: Mon, 13 Oct 2025 14:58:51 +0800
Subject: [PATCH v3 10/10] imx943_evk: Enable ENETC1 and ENETC2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-imx943usb-v1-10-293e79d4bc12@nxp.com>
References: <20251013-imx943usb-v1-0-293e79d4bc12@nxp.com>
In-Reply-To: <20251013-imx943usb-v1-0-293e79d4bc12@nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Alice Guo <alice.guo@nxp.com>, Stefano Babic <sbabic@nabladev.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Jindong Yue <jindong.yue@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Frank Li <Frank.Li@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>, 
 Minkyu Kang <mk7.kang@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Tim Harvey <tharvey@gateworks.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Roger Quadros <rogerq@kernel.org>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Hanyuan Zhao <hanyuan-z@qq.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PA1PR04MB10098:EE_
X-MS-Office365-Filtering-Correlation-Id: b083fa91-21f9-43ed-8d90-08de0a263d53
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ymt0cUYxcTFvWEo4U3B4aEVER3FHTWhtMXlUd0phMXlhMGE5UmgzN1U1UnVo?=
 =?utf-8?B?cDFaTmhTWFpncXpka0p5U29xeW11bkRMa1h2SkJ5a1RubmI0QWk4SWZyYlpB?=
 =?utf-8?B?aWQ0RE9kd3AwN05iNHEyS3JPck9pSG1VN29hUnJaUjNMcHVnUzhFcUpYdWs4?=
 =?utf-8?B?VHJlNG1Bb1hXN0lHWkpTb0xGMnRPNU11RTJ5ODJwUWtERTA5d0thV01yQlpW?=
 =?utf-8?B?d1AzRkZnajFDWFllWFdXRjlrR2hWRmNJeVU4Z3I2dU5RQ3dJRmVDQWJrbHFu?=
 =?utf-8?B?THFxYWZWRWlvb1FNcmZ4eDAzWVRYcTRyRzl5a0FOR3ZJbWhQcHliNjNkemli?=
 =?utf-8?B?UmpVRmxPYW1NVWR3dW5rM3k3K2JGL1JzSGFSM0c2N3ZWb0pZSTNBMGI3Q2RX?=
 =?utf-8?B?cll0eGtRc0lPd1MyYnNubE90TFNrbDZlNEtpam44QU93MlYzeStOQnFCbXdN?=
 =?utf-8?B?VTRMUmlVTnozRUpHN0d5WjlOTHFWM0o4UEtuL1J1S09ZdEJwYmlZcTVSY0ZV?=
 =?utf-8?B?endDRG9mQVVJcnRaSHoydmpwd0hQaFNyMDFBZ1B0YlJGVHI2ZUg3Wm9ZMXJo?=
 =?utf-8?B?aWNsclBrcWN1bWwrdUtXNHdVaUNFcVBkTERlYUpnanFxbktMUVNnMjBIRGZX?=
 =?utf-8?B?bFczVmtyblhVUzFha0EvMXUxeGZuY0VWUXM0cnk4dW1qQzhGOWtBbVpGR0l2?=
 =?utf-8?B?NFBrRlJETmxPL2tLdmJWSTRiQitxYVJ0ZzNwM3FqRXJudXBCTU5lQUF1WitF?=
 =?utf-8?B?Wmh2M29Yd1MwQk5kOHM4bjhVNDFGZVI2SStVakpndjhMS0VFN3h1UVRPS3E2?=
 =?utf-8?B?YWJWcWoyY05FcnU2Y3JLeTRZU1RweFRtM1kva3lvbFowTk5nblZxaUp2d1p3?=
 =?utf-8?B?bFFpTU5ZaFhxYWM1aHY3QndUNVBEVGJTVDV2M0xuRDJaTDZlNE0vNEdnRFA5?=
 =?utf-8?B?QUE5Z2VmamFkdzRmRTFzZ254elRyd0YwbDV0SXc2MnNQcXpaeHIrUmVEWGRx?=
 =?utf-8?B?WlFlZ0pnOXNRRkFsU1YzTWtpT1A5UVdCZlpwVVZZZzF6L2JFZVpzWFVuaTlJ?=
 =?utf-8?B?RGFNbkNTTnZpa3pWVDZmTytEVVM3QjE3bGxvODBnNnpIRWRXV1BYNzFubCtJ?=
 =?utf-8?B?T3kxbFpFUjEvcTV6TXFzbjF3TXRLWllKbE1uVWlySGxhbGY4WXJBZzhiRE1H?=
 =?utf-8?B?MEFEVnBWNU9zejNkVlVmNHZ5VE5CMFBYcjR6cWtMSGpRVWU2c0I4QXlrMnFD?=
 =?utf-8?B?b2Y5bGM3NE9qdzY2ODZUNm1QcENGRkxwZ3BjTVdyOENZN3ZwRkVSZkJwZ2Np?=
 =?utf-8?B?RGtYNlhNT21VdnpLTEhETDgwNDJrVEk2YTdoNlQwMGlmeENpOWhxK0dDTlg3?=
 =?utf-8?B?STdLeFlOSitCdkorODhNZ0R2YU5Za2RLdlkzbzE4UU1haDFjZEhONWx6aDlZ?=
 =?utf-8?B?ZUVFK3lnR2VEZXlvNW1MWHRhRy96OEZ4clVtR3dCWTZpQWNmRGVpM1RmYjBJ?=
 =?utf-8?B?cmQyL1RDUzNoZEpWRm0vSUY5a1BYcENlT0prMUNKYmhhbmlUSkxDR3pydGd2?=
 =?utf-8?B?RFB4NU9ERGZvMmp6ZElkbWpHYTY5Mmh0ZXJDL1pOUEg0S0lCTDlwclBya2xr?=
 =?utf-8?B?WWk2RWo4YktjQkNIcmh0ckJGVC81SVpEbUtvNndJeEtlVXNIRzN4TnhzWHlK?=
 =?utf-8?B?cXU2RDVpdS9DQ0cyWWlRSlFPNjdFd3M2S2Erb3FLSU9qV1BIbEFIdTh6aDZE?=
 =?utf-8?B?eS9yUFBIeDBGd083Q2dhVUllTFdubUxGckhIdEk4V1FJN3ZNcG90WE5BSWxx?=
 =?utf-8?B?eTA4ZDRWdDdoM0pzTEtsMWVnWkRRK1dVZVN2SFhSVmsrMWo2aG5Cc2JiRVFL?=
 =?utf-8?B?ZWJsbS9jdTFSY3BFYURrSUVXSTFuRlFPd2c4ZURqQStOcTZvZ1gxRGFGLzkz?=
 =?utf-8?B?bFdCWSsvaC9oc0U0RCt5WG5hcWRicDg0MFBpZDJzelR5ZG9OaVEzQkE0T1Rp?=
 =?utf-8?B?dVAzR3FxUWFVVENGZXEzNmRXdVFOak95WXlmdzdNSnJOMU9HQ3FOMzNSaWo2?=
 =?utf-8?Q?8YGZ6n?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(19092799006)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3VzK1d1bU4wUkhTSHRTaUl3Zk9mVjFlckdFdDdWb1d2S2RTQjVlNmUxa05Z?=
 =?utf-8?B?ZXA2WmxjeDlEbUNmY3VaRkF1QVp2OFJoQlJHd3VUc3Y5NjRKNjQ5Vm4wK1Jx?=
 =?utf-8?B?aEY1OWRnVFA2T0d1aU1GZVJVR2lOZUpvVm16QVZFZkZqeHpWeEdlc09tQkJM?=
 =?utf-8?B?SW5CWGRJdFdUSnoydFFKdHpNdzhtcFIrQi9USTgwQmNFRkw3UnMzellFM2lS?=
 =?utf-8?B?NElTbkpzSk1NU2tIdGNIZ082Z09TQ09LcU8zM0JCTzNxdzk5R2JUWmEydnpp?=
 =?utf-8?B?dUw1NWNDZ1pDbERlTDA2Y3NxRmhCaVo3V2FFYWFYTStibWNsYjNkb1lnS1ZG?=
 =?utf-8?B?ZEhPT0U5VkZMcnNRNjN1TXdvZDNweUVSVkZzbi93V2NVeTNJZDNsc3BOK0I0?=
 =?utf-8?B?S3VqOExvR3R0b3VvRERXck94eldVaHUvRFlYY1E5cXFiYkRmRTRMUlN2ZnJD?=
 =?utf-8?B?SmNORmtWWmtnRHBUYjNjUDVoNkFlUEJRWi9NUlpmcGpTV1c4OHQ2S1E1V1Ex?=
 =?utf-8?B?b0NRQUJqektPTnpUU3hNN0RGUlE4aDZxNnhiVFovTEI2TFpnOU9EeWdvYUZQ?=
 =?utf-8?B?YkZIVDJKT3VyazlSZWdhdVF1VnE2ck5KdmVlbVp4c2R6ZlVzditMWkk5WkV3?=
 =?utf-8?B?ZXRZR1VzSWo4c1RiQjAwSXdtSlI3Tlh4UVMzMTJLTjYzZGR3NERTb3FnWjVB?=
 =?utf-8?B?TDJqeTMrWU1KS1pXckJMRmx4UFAxMEltZzJBUGFrL3k0MGJsYSthM3hmTHFV?=
 =?utf-8?B?ZzVIaWh1WVRyKzhtZ2o2SDZHL1E5QktXVlJFaUgzWmdVS0VBejh4OER1am5R?=
 =?utf-8?B?UDJhRHNDNWNaYzVnV3ZxQmt1Y3p3SVZCY0VJQVZJYWZlelpZcnk3T0ZQckhk?=
 =?utf-8?B?aTlNMVIxeVg0c3JTVTJCTUR1bkdJcTF1MFpoT3VIeFpyNmIycHZpYlplQUp0?=
 =?utf-8?B?bGwzR2xOdHhLRFJ1UURYanlwN2pnS3dnU25GaU42N2FCQWpYRVhBRGcvRzVz?=
 =?utf-8?B?aW95Q0FKaUprdWsrQmpCMEM0STlURmRWcHN4L1VmRHNBdzlHTjE4Mmlpc2ta?=
 =?utf-8?B?anBBU09mM1drNzhxa053UWVxNWdncGVtNXFYaEpSd2ZDRjhjNmEyRUUxQU84?=
 =?utf-8?B?OUdycUJtLytGTHgxZkxlYzhuQ0xoQVBjMElNUFRiVjczRkpNaWdxa2NvREJr?=
 =?utf-8?B?WDZscnpHbnluRU9WU3l6L1JKZzFod21zR0h6Ry9URDhacjVadHpFc1pXbDQ2?=
 =?utf-8?B?Si90YmowcWNES0RPMXF2TVhITWhOc05jZ0dsUlUzbzN6cFprMjlqeTNMaTJi?=
 =?utf-8?B?ejhvczNNSkE0TFFMdFcwWHFLT3V0QmxFNzAyRDZMUkF2MnZqMHVpRXdBZUJy?=
 =?utf-8?B?MS8wWHp3OGh6VVdwRG02Y3ZJRk1qaWE2TjNFZWlhVXc1NlQxSHhScGZFVDUw?=
 =?utf-8?B?U3FSVllpUGtJcVA1dms2ZkR4SUR5NnVmNkF1M0NnL2J5VDJXYTZQa0tuRk9s?=
 =?utf-8?B?TjZHalhoN0dwNzN2N21aMURRUHkxaXdXTXlhbUc3V21vMzQ0dHNLM1Awd2ps?=
 =?utf-8?B?d1VDOG5ja0NVUHE4UzRzNjNWNERtQ25sQ1dxd2tJQnhpcHlLS3pPVHV1STJD?=
 =?utf-8?B?QjJkeEFOdEx5SkR2UEoyRGxRVTR0dERDMktFbFF5OGV2ZGdPMkNVdnRDbTlr?=
 =?utf-8?B?eFUzaGhHeTBqbGVPKys1M3NZR05USmN1bG1XWFR1UHpIUEZSa2VqR3V6ZTRq?=
 =?utf-8?B?a013MHZWZXZCRmVPbGN2ZXR1MEl1Y3lEVjFRWUFQY0w0RXA3alZlaXl6WjdK?=
 =?utf-8?B?VkVmWFBHYnk1M0kzd2cvdkRPYXlqVXlrZUgzaFJNdHFGVE5DcXhjZklHWGZH?=
 =?utf-8?B?S0FseTB5TDNZbW9sU2hlOGpBZXJsWW0wRHU5WUxHM1hMOXF4S0k5Q1gzNTh4?=
 =?utf-8?B?TkxJNW1LNnh1NWFLODJ4MzFyUlYxdE5tQTNtOVpyczhnemc4bFZsem9wMFpj?=
 =?utf-8?B?ZWI5OGdiVGZzTlZqWUQzSlAwM1gzbXBXclRjNERmajNXVVBVa1BzMXNhb0pV?=
 =?utf-8?B?NlU1NHRyZHNGOHlDMXFoYWltbjJzakVUenpvbi8rSTRJb0ZXOGJZaXJ4NHhS?=
 =?utf-8?Q?6JKYg/oLfvXKE7seo6PlYytii?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b083fa91-21f9-43ed-8d90-08de0a263d53
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 07:00:48.9748 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u/zjldo6HXfi0uNBbgQ+0ewLJbcq1CcoggvcP+9zhXhszDHE58SlQHYN8JpffNb4grUE7Y2nOvGOOcJi682DgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10098
X-Mailman-Approved-At: Mon, 13 Oct 2025 09:18:15 +0200
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

From: Alice Guo <alice.guo@nxp.com>

With this patch, both ENETC1 and ENETC2 are functional on the i.MX943
EVK board and can be used for networking.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx943-evk-u-boot.dtsi | 149 ++++++++++++++++++++++++++++++++
 arch/arm/dts/imx943-u-boot.dtsi     | 166 ++++++++++++++++++++++++++++++++++++
 configs/imx943_evk_defconfig        |  13 +++
 3 files changed, 328 insertions(+)

diff --git a/arch/arm/dts/imx943-evk-u-boot.dtsi b/arch/arm/dts/imx943-evk-u-boot.dtsi
index 3995176f090..528b3b02a3f 100644
--- a/arch/arm/dts/imx943-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx943-evk-u-boot.dtsi
@@ -5,10 +5,109 @@
 
 #include "imx943-u-boot.dtsi"
 
+&enetc1 {
+	clocks = <&scmi_clk IMX94_CLK_MAC4>;
+	clock-names = "enet_ref_clk";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_eth3>;
+	phy-handle = <&ethphy5>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+};
+
+&enetc2 {
+	clocks = <&scmi_clk IMX94_CLK_MAC5>;
+	clock-names = "enet_ref_clk";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_eth4>;
+	phy-handle = <&ethphy6>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+};
+
+&lpi2c3 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpi2c3>;
+	status = "okay";
+
+	pca9548_i2c3: i2c-mux@77 {
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x77>;
+
+		i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+
+			pcal6416_i2c3_u171: gpio@21 {
+				compatible = "nxp,pcal6416";
+				reg = <0x21>;
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				ethphy2-on-hog {
+					gpio-hog;
+					gpios = <2 GPIO_ACTIVE_HIGH>;
+					output-high;
+				};
+
+				ethphy3-on-hog {
+					gpio-hog;
+					gpios = <3 GPIO_ACTIVE_HIGH>;
+					output-high;
+				};
+
+				ethphy4-on-hog {
+					gpio-hog;
+					gpios = <4 GPIO_ACTIVE_HIGH>;
+					output-high;
+				};
+
+				lvds-en-hog {
+					gpio-hog;
+					gpios = <9 GPIO_ACTIVE_HIGH>;
+					output-high;
+				};
+			};
+		};
+	};
+};
+
 &lpuart1 {
 	bootph-pre-ram;
 };
 
+&netc_blk_ctrl {
+	assigned-clocks = <&scmi_clk IMX94_CLK_MAC2>,
+			  <&scmi_clk IMX94_CLK_MAC4>,
+			  <&scmi_clk IMX94_CLK_MAC5>;
+	assigned-clock-parents = <&scmi_clk IMX94_CLK_SYSPLL1_PFD0>,
+				 <&scmi_clk IMX94_CLK_SYSPLL1_PFD0>,
+				 <&scmi_clk IMX94_CLK_SYSPLL1_PFD0>;
+	assigned-clock-rates = <250000000>, <250000000>, <250000000>;
+	status = "okay";
+};
+
+&netc_emdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_emdio>;
+	phy-supply = <&reg_gpy_en>;
+	status = "okay";
+
+	ethphy5: ethernet-phy@6 {
+		reg = <0x6>;
+		realtek,clkout-disable;
+	};
+
+	ethphy6: ethernet-phy@7 {
+		reg = <0x7>;
+		realtek,clkout-disable;
+	};
+};
+
 &reg_usdhc2_vmmc {
 	bootph-pre-ram;
 };
@@ -58,6 +157,56 @@
 	status = "disabled";
 };
 
+&scmi_iomuxc {
+	pinctrl_emdio: emdiogrp {
+		fsl,pins = <
+			IMX94_PAD_ETH4_MDC_GPIO1__NETC_EMDC		0x57e
+			IMX94_PAD_ETH4_MDIO_GPIO2__NETC_EMDIO		0x97e
+		>;
+	};
+
+	pinctrl_eth3: eth3grp {
+		fsl,pins = <
+			IMX94_PAD_ETH3_TXD3__NETC_PINMUX_ETH3_TXD3		0x57e
+			IMX94_PAD_ETH3_TXD2__NETC_PINMUX_ETH3_TXD2		0x57e
+			IMX94_PAD_ETH3_TXD1__NETC_PINMUX_ETH3_TXD1		0x57e
+			IMX94_PAD_ETH3_TXD0__NETC_PINMUX_ETH3_TXD0		0x57e
+			IMX94_PAD_ETH3_TX_CTL__NETC_PINMUX_ETH3_TX_CTL		0x57e
+			IMX94_PAD_ETH3_TX_CLK__NETC_PINMUX_ETH3_TX_CLK		0x5fe
+			IMX94_PAD_ETH3_RX_CTL__NETC_PINMUX_ETH3_RX_CTL		0x57e
+			IMX94_PAD_ETH3_RX_CLK__NETC_PINMUX_ETH3_RX_CLK		0x5fe
+			IMX94_PAD_ETH3_RXD0__NETC_PINMUX_ETH3_RXD0		0x57e
+			IMX94_PAD_ETH3_RXD1__NETC_PINMUX_ETH3_RXD1		0x57e
+			IMX94_PAD_ETH3_RXD2__NETC_PINMUX_ETH3_RXD2		0x57e
+			IMX94_PAD_ETH3_RXD3__NETC_PINMUX_ETH3_RXD3		0x57e
+		>;
+	};
+
+	pinctrl_eth4: eth4grp {
+		fsl,pins = <
+			IMX94_PAD_ETH4_TXD3__NETC_PINMUX_ETH4_TXD3		0x57e
+			IMX94_PAD_ETH4_TXD2__NETC_PINMUX_ETH4_TXD2		0x57e
+			IMX94_PAD_ETH4_TXD1__NETC_PINMUX_ETH4_TXD1		0x57e
+			IMX94_PAD_ETH4_TXD0__NETC_PINMUX_ETH4_TXD0		0x57e
+			IMX94_PAD_ETH4_TX_CTL__NETC_PINMUX_ETH4_TX_CTL		0x57e
+			IMX94_PAD_ETH4_TX_CLK__NETC_PINMUX_ETH4_TX_CLK		0x5fe
+			IMX94_PAD_ETH4_RX_CTL__NETC_PINMUX_ETH4_RX_CTL		0x57e
+			IMX94_PAD_ETH4_RX_CLK__NETC_PINMUX_ETH4_RX_CLK		0x5fe
+			IMX94_PAD_ETH4_RXD0__NETC_PINMUX_ETH4_RXD0		0x57e
+			IMX94_PAD_ETH4_RXD1__NETC_PINMUX_ETH4_RXD1		0x57e
+			IMX94_PAD_ETH4_RXD2__NETC_PINMUX_ETH4_RXD2		0x57e
+			IMX94_PAD_ETH4_RXD3__NETC_PINMUX_ETH4_RXD3		0x57e
+		>;
+	};
+
+	pinctrl_lpi2c3: lpi2c3grp {
+		fsl,pins = <
+			IMX94_PAD_GPIO_IO16__LPI2C3_SDA		0x40000b9e
+			IMX94_PAD_GPIO_IO17__LPI2C3_SCL		0x40000b9e
+		>;
+	};
+};
+
 &pinctrl_reg_usdhc2_vmmc {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/imx943-u-boot.dtsi b/arch/arm/dts/imx943-u-boot.dtsi
index 8c89b8be04b..2b93ba9a38b 100644
--- a/arch/arm/dts/imx943-u-boot.dtsi
+++ b/arch/arm/dts/imx943-u-boot.dtsi
@@ -84,6 +84,25 @@
 		};
 	};
 
+	reg_gpy_stby: regulator-gpy-stby {
+		compatible = "regulator-fixed";
+		regulator-name = "gpy-stby";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pcal6416_i2c3_u171 5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_gpy_en: regulator-gpy-en {
+		compatible = "regulator-fixed";
+		regulator-name = "gpy-en";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&reg_gpy_stby>;
+		gpio = <&pcal6416_i2c3_u171 6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	usbphynop: usbphynop {
 		compatible = "usb-nop-xceiv";
 		clocks = <&scmi_clk IMX94_CLK_HSIO>;
@@ -260,6 +279,153 @@
 		#index-cells = <1>;
 	};
 
+	netc_blk_ctrl: system-controller@4ceb0000 {
+		compatible = "nxp,imx94-netc-blk-ctrl";
+		reg = <0x0 0x4ceb0000 0x0 0x10000>,
+		      <0x0 0x4cec0000 0x0 0x10000>,
+		      <0x0 0x4c810000 0x0 0x7C>;
+		reg-names = "ierb", "prb", "netcmix";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		power-domains = <&scmi_devpd IMX94_PD_NETC>;
+		status = "disabled";
+
+		netc_bus0: pcie@4ca00000 {
+			compatible = "pci-host-ecam-generic";
+			reg = <0x0 0x4ca00000 0x0 0x100000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			linux,pci-domain = <0>;
+			bus-range = <0x0 0x0>;
+				/* Switch BAR0 - non-prefetchable memory */
+			ranges = <0x02000000 0x0 0x4cc00000  0x0 0x4cc00000  0x0 0x80000
+				/* ENETC 3 and Timer 0 BAR0 - non-prefetchable memory */
+				0x02000000 0x0 0x4cd40000  0x0 0x4cd40000  0x0 0x60000
+				/* Switch and Timer 0 BAR2 - prefetchable memory */
+				0x42000000 0x0 0x4ce00000  0x0 0x4ce00000  0x0 0x20000
+				/* ENETC 3 VF0-2 BAR0 - non-prefetchable memory */
+				0x02000000 0x0 0x4ce50000  0x0 0x4ce50000  0x0 0x30000
+				/* ENETC 3 VF0-2 BAR2 - prefetchable memory */
+				0x42000000 0x0 0x4ce80000  0x0 0x4ce80000  0x0 0x30000>;
+
+			enetc3: ethernet@0,0 {
+				compatible = "pci1131,e110";
+				reg = <0x0 0 0 0 0>;
+				phy-mode = "internal";
+				status = "disabled";
+
+				fixed-link {
+					speed = <2500>;
+					full-duplex;
+					pause;
+				};
+			};
+
+			netc_timer0: ethernet@0,1 {
+				compatible = "pci1131,ee02";
+				reg = <0x100 0 0 0 0>;
+				status = "disabled";
+			};
+
+			netc_switch: ethernet-switch@0,2 {
+				compatible = "pci1131,eef2", "nxp,imx943-netc-switch";
+				reg = <0x200 0 0 0 0>;
+				status = "disabled";
+
+				netc_switch_ports: ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					/* External ports */
+					netc_switch_port0: port@0 {
+						reg = <0>;
+						status = "disabled";
+					};
+
+					netc_switch_port1: port@1 {
+						reg = <1>;
+						status = "disabled";
+					};
+
+					netc_switch_port2: port@2 {
+						reg = <2>;
+						status = "disabled";
+					};
+
+					/* Internal port, a.k.a management port */
+					netc_switch_port3: port@3 {
+						reg = <3>;
+						phy-mode = "internal";
+						ethernet = <&enetc3>;
+						status = "disabled";
+
+						fixed-link {
+							speed = <2500>;
+							full-duplex;
+							pause;
+						};
+					};
+				};
+			};
+		};
+
+		netc_bus1: pcie@4cb00000 {
+			compatible = "pci-host-ecam-generic";
+			reg = <0x0 0x4cb00000 0x0 0x100000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			linux,pci-domain = <1>;
+			bus-range = <0x1 0x1>;
+				/* ENETC 0-2 BAR0 - non-prefetchable memory */
+			ranges = <0x02000000 0x0 0x4cC80000  0x0 0x4cc80000  0x0 0xc0000
+				/* Timer 1-2 and EMDIO BAR0 - non-prefetchable memory */
+				0x02000000 0x0 0x4cda0000  0x0 0x4cda0000  0x0 0x60000
+				/* Timer 1-2 and EMDIO BAR2 - prefetchable memory */
+				0x42000000 0x0 0x4ce20000  0x0 0x4ce20000  0x0 0x30000>;
+
+			enetc0: ethernet@0,0 {
+				compatible = "pci1131,e101";
+				reg = <0x10000 0 0 0 0>;
+				status = "disabled";
+			};
+
+			netc_timer1: ethernet@0,1 {
+				compatible = "pci1131,ee02";
+				reg = <0x10100 0 0 0 0>;
+				status = "disabled";
+			};
+
+			enetc1: ethernet@8,0 {
+				compatible = "pci1131,e101";
+				reg = <0x14000 0 0 0 0>;
+				status = "disabled";
+			};
+
+			enetc2: ethernet@10,0 {
+				compatible = "pci1131,e101";
+				reg = <0x18000 0 0 0 0>;
+				status = "disabled";
+			};
+
+			netc_timer2: ethernet@10,1 {
+				compatible = "pci1131,ee02";
+				reg = <0x18100 0 0 0 0>;
+				status = "disabled";
+			};
+
+			netc_emdio: mdio@18,0 {
+				compatible = "pci1131,ee00";
+				reg = <0x1c000 0 0 0 0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+		};
+	};
+
 	elemu1: mailbox@47530000 {
 		compatible = "fsl,imx93-mu-s4";
 		reg = <0x0 0x47530000 0x0 0x10000>;
diff --git a/configs/imx943_evk_defconfig b/configs/imx943_evk_defconfig
index e4fcf2eb576..39b616e266e 100644
--- a/configs/imx943_evk_defconfig
+++ b/configs/imx943_evk_defconfig
@@ -39,6 +39,7 @@ CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
 CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_BOARD_LATE_INIT=y
+CONFIG_PCI_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x30000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_LOAD_IMX_CONTAINER=y
@@ -83,6 +84,8 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SYS_RX_ETH_BUFFER=8
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
@@ -97,9 +100,19 @@ CONFIG_SPL_CLK_SCMI=y
 CONFIG_SPL_FIRMWARE=y
 # CONFIG_SCMI_AGENT_SMCCC is not set
 CONFIG_IMX_RGPIO2P=y
+CONFIG_DM_PCA953X=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_IMX_LPI2C=y
+CONFIG_I2C_MUX=y
+CONFIG_I2C_MUX_PCA954x=y
 CONFIG_IMX_MU_MBOX=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_FSL_USDHC=y
+CONFIG_PHYLIB=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_MDIO=y
+CONFIG_FSL_ENETC=y
+CONFIG_PCIE_ECAM_GENERIC=y
 CONFIG_SPL_PHY=y
 CONFIG_SPL_PHY_IMX8MQ_USB=y
 CONFIG_PINCTRL=y

-- 
2.43.0

