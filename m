Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7512E7719A
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 02:24:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 784E4805EA;
	Thu,  9 Jan 2025 03:23:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="n1ap/MGN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 149F680609; Thu,  9 Jan 2025 03:23:32 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::623])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2B01805EA
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 03:23:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tLgDfQzH5gjxmjoM8Ld+k3+jiI2cvbWePVlO0IAsNYA8du/y/lLB5aEBMmfPSs1qeT5hTtzCQZcxcrDGn8iA0rhm9rrkh9RclF6oChd4KAQc0SFrCtnAw6dmrKwGYdlrp14X9D7enIsGAE9PZPFXS9OTn2c29dU3iDszYAiD+BfB7+BX6n67mUYhGakArfexkBsAk321nQafM444gePFcezF0D9vPLcJsSH95L/gZm6+YL3hdhSznGhYYyQmyAgW4d/L/6SjUngcVbyLCWykziDKrFvQ5ti2XDoXGFrO9gdcRUdGmAXj6+EZCW1qnKO1JeqS3WJgFSWC1MxkIsgAMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uAZON3a9AeO8BesXQjz8XhsVzjudUGhDqIwVmmAs+A=;
 b=fErjHKdh8mbud64cjLBHRLQBg6J1jZ8xBd3cT1ltLqefHrcX6KKSTRRK2CoWFIRIE/TdWvS972S1vrDt83D0xeQyqHhV0WUycQT0M10jTzsRzpVxJB8tWZ9C++C7xDwohXsXc+s1hD6QxxyJVvt3M19VRzA4eKuhdLYTeGpyA6gxCE2MpAxwUQ804nJCs2hLSnpK4yvIbMCRlFSuQHtM4jAOxr7A1/6oxCCZPa8jraniTcv7XJoV/wghPcyllavCDIqBhcb/ky3AuPUuJHMqzuChWxjaavpnkrUmB7m9LdG9KKtyG48fQHSxhXF80JLut6mJRB+XN/oX6tIPtaI4SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uAZON3a9AeO8BesXQjz8XhsVzjudUGhDqIwVmmAs+A=;
 b=n1ap/MGNDwnG1L8u+qbsTkj3lqQiCIOAKx+yvMuinh6R4/XjSZGTeUK+uSv1JwoAMHW/9AIqUz0Ccp9nQnUVwJgdG+8N/O5spyTEuFptIdYBRmPOmOZPhu/nLuVCF1NClCuLZT6je+swicc+zl1q6UjOM3oCVoV74Ogqa3SsEPU7ypgmQS1EbNutPaZQCHTun0qoCWfEKXY9KpcAFTu0CuKX8BQSNdMmMc020VSLLM8hWQTf9URbC1Q3w6OowPdETuebRynE9pNs150WmZKtBfhJGh3ICq+xJCn72Sybq9ou3Gn8el8bkt5L96GKz5wHmuuPgFKr/658jtGUow/Jqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by DB9PR04MB9355.eurprd04.prod.outlook.com (2603:10a6:10:36b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 02:23:26 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 02:23:26 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 09 Jan 2025 11:29:08 +0800
Subject: [PATCH v3 07/17] imx: imx8mn_evk: Drop DECLARE_GLOBAL_DATA_PTR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-imx-bootstd-v3-7-16e5fc0baecf@nxp.com>
References: <20250109-imx-bootstd-v3-0-16e5fc0baecf@nxp.com>
In-Reply-To: <20250109-imx-bootstd-v3-0-16e5fc0baecf@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SGAP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::32)
 To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|DB9PR04MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: ac35c40d-15f1-4e9d-d4d8-08dd30549956
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WVdLK09GV3NueXVMbGl0WmJaV1BjaTNaSnQ1bURnUUVPMVYxN1MzU0FlU016?=
 =?utf-8?B?YkVCcW5uTHl2cHBkaFZ5eWQ3bVFoOHJOM0t3WXM1bTlwYVBTZGlSb29VdGlv?=
 =?utf-8?B?QWQ1azNEb1ZOVUhSQ3g1dld2YU9YTWxZTytSdjZwRzAyN2xqbjRpZmNQVkJy?=
 =?utf-8?B?czBZa3ZoSlY4M2tLd0p4THRLb1NpN25BaUF0M1FyOGtrSzVqbHg1TU9Vam0y?=
 =?utf-8?B?OUsrbDIwWmFjNkNOSUNGbE5mNDJERzZrQmhtNWcwMUJQeXhHUm13VEd0RjVs?=
 =?utf-8?B?Qll2TVZUQXBiWndnSGE4N09nMGZ3bzhxdnZJVkpBMURWR3F2S0g4eGs1TTVw?=
 =?utf-8?B?UkM5dy85Zk1SczVpQUlZakVOUUVtcHd6Wll4KytzaHdEZEZaQThnWEo2eTRF?=
 =?utf-8?B?L25JZ1IzaXBsTzdRM1lTeUZRMHdKWnh0N0hSMDFNakF2MFJweS9JTjJsYllK?=
 =?utf-8?B?TkFKai9ONlo2R3k2NmNtNDhVMWNFdHQvRDQ5V3N4cXZBdEFtU25iM2wyM1c2?=
 =?utf-8?B?N01ybk1YNExqeEJ1bFc5SmgvL0hQcnNJc0xpMTN6VlVIZG9KcFB0ckM2Y3la?=
 =?utf-8?B?c3dIQTZ0SGJjWGxUMW5POTlDRHZhZFBLRmpvMU5hTEFVV0RKNVF2Y0ZXLzJm?=
 =?utf-8?B?cGxUby91bWYwWnV0YXZONXdWTWtteFpPbXdCQU90YWZhenE5a2xleE5kZlk5?=
 =?utf-8?B?RXBsOHIySmh3enVyR1h0ZXExZXZadmoyZ1phZEdvMVZwRlEyRzFBYjIveGpO?=
 =?utf-8?B?cDl6M3NJVTd3bUFVS1ZiWTVTTi9wd0lBMXM3OE9GTmgyRDJQYWpQT0J1RTJG?=
 =?utf-8?B?WXN5RVVqTEFhZ3BOcGoyTFMzWGdtYjFYNGpHQ21iNkxqNDk1eE1BR1ZKSmFG?=
 =?utf-8?B?NUlJK0ZMWjVBbDJYUUsxb3BEWHVsTE9qVHA4cFdscUxDUHRyQ3lRZzAxZVNN?=
 =?utf-8?B?NSs4ZTZCZTJZcURZcjZhclE3RFRUZkZqa2NHMENvc1Y0dWxVM1hBRmpXcjdn?=
 =?utf-8?B?cDAvSkxIZ0tsTmV0WTZ0cVZDT21xRHR6YkNwUUtZaFNEQzV6UW9RblRIQUgv?=
 =?utf-8?B?eG9qRktsYVY2QWg5Ykt5SU80OTlwc3Y0UzRERVZKU29YU21sS2JFZXVZaUJo?=
 =?utf-8?B?a1dPcTlKeTRvdm1jUlcySTI4eTluMU5yZnJxcGZCS3RGNWRJRGsxWUdOQk42?=
 =?utf-8?B?VFhkUllQb1ZMR1lKWThmajFCWEpMcXEwMFNiZWZlTmdGY2Y3NGxtc3VLT05q?=
 =?utf-8?B?ZkZoTFFMSWxTS3RGU0YvZnpqejNkeVM5MlpFbjBkTkVkOVVNQ21LUEZiNlZZ?=
 =?utf-8?B?Q253Z1RBOUZxajUwaU81bkcwZUhRU05Ub2lobEFXeUJQck90eFAxaFlmWWdT?=
 =?utf-8?B?TGowRWdQalgrVjFCaDVVWU11QVU1VTJGZGFlcjBlYjNQaEs1MTNxTEg0Q2t1?=
 =?utf-8?B?cEFLdjFpY2owNnZDalZ1Y3U5TGk4V0NJY0ZBTlF2THhkMzhaYWNRMDA2SlMv?=
 =?utf-8?B?M3lqSng1MWVJNVMydEJpRnFVQ0hPQis0QlRTcHZRSGRQNXBac0ttTUlOeTQ1?=
 =?utf-8?B?TjE3czhIV0xoNS9RYk5qcFY4a1hCc09iTDA1Vjh6bVQ1ZDQ4SDB2NUg1MlVQ?=
 =?utf-8?B?RkJQcU1Tb3dGMXJoWlBINXVscU9wb3ZCNnZRSTduUG1lbFhhSTBuMEc2RjVE?=
 =?utf-8?B?bWRaUnE1Z0l6ZjBZdnpaUTB4N3M1K1haOXcyVW5ZdG14amVwaHdXWndMcWlj?=
 =?utf-8?B?dVg4R1BkeUhzclU4UGd4QUp4MVNsNW5wODZrZmxSaWZvOEJ0WVk4Tm9jcExI?=
 =?utf-8?B?TXdaTy9PbGlJRTVZVXdTMGFBM3gzZUgwTmMwbXlRVS9vTytxM0FNTzhkYTRX?=
 =?utf-8?B?QzYzODdyVTFxV1VRMUtFZWd3SityWXFqS0dvdGYvMHFnVE1nY2w2MWVRM2tl?=
 =?utf-8?Q?Rn+nj12WaVQAo+bRJsXMo4PcH5abRZ62?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnFwcCtOcUpUYVcxTzRqMlFGVit4S1BMbmYvSXVSTklnSlhTbStIT1RhN1pn?=
 =?utf-8?B?dzdvYnBYeXN0VU1kaDNCVGxUN3ZSU0QrdUV4QzJEY3hUTkkrKzZHS284a2hs?=
 =?utf-8?B?LytTaUtiQzc3NmZESWVNZUZFUytCSFBnNnBQZ2tSUnYwVkR1UmV1TXgvTDQ4?=
 =?utf-8?B?OFR3Q1gxalNhTEdUN2Riaklra3J5UzI5YzRIN09zcmNuam9VTDdzSnlHSnBx?=
 =?utf-8?B?cEtneVlxa2ZCaFl2cUFkcWtWYVZGRlpKOHViLy9HemJhR0pWdVBIQ1dGa3JO?=
 =?utf-8?B?MUduN3ByYUg2Ync2NC9GR1JqVVFrT0s4M05YMmRuS2FWVmd5S1k1ZWF3QUxZ?=
 =?utf-8?B?NlVrVmJMaHFLZmNvdzdrNldpZ3JHOHlMaTlTTjZPK2FHL0NheitGQlFKQ0Z2?=
 =?utf-8?B?WDI1eWNlaU5ZRmo3YkFVUGpBM2xIdUV3WlYxTkI4aEhpQ2dJZG4vQjZGRzlI?=
 =?utf-8?B?KzBVeTBiUHhFS3Z0a0VyK0xIY2FYdXRMTWoxRzg3UDJOVFRNWkVuZVhPSHh1?=
 =?utf-8?B?NWc3RDEwNHNzaHdXNUxIN3oxUFJiN2MwOFhlMkxkYjdLb2dJbzBVNGJNM3dJ?=
 =?utf-8?B?VzRZa2FEcTgyZlBKRE5qR3FwSFVoVHV6K0czMXFOMzl5ZkVEU0laNjFQbFFQ?=
 =?utf-8?B?Tjg5RDFlMjM0R2kwbUFMT3ZYQnZ2Y0JBTXVnNDhRcnd1bC9ybTB1YStYRnJ3?=
 =?utf-8?B?bElFWjdQbzFaTklpS0ZiTlI3VlltZXFkVWczNnZHbkVnMG14czY3WEFBZEd3?=
 =?utf-8?B?UGxGUmlrSTNqN0pKZ0pGZ1cwZWZPNG80M3hBK2xWb3pmTFFJNkNNMlJUWlF6?=
 =?utf-8?B?MmxneUR2bnhZamFsSWhhdnplZnFMY08vZk5XN2VSSUw5ODVyY3JMS05peEtD?=
 =?utf-8?B?U3M2c1dCTFNpajVMdE1BT2t5bTU0NytrL1Q1S3RrZnkxK1RwemZnRGtmVVFv?=
 =?utf-8?B?WjZlNlFla3gzTFl2WjRGaEVFeisyb1ZJVUF3eVU3NUpPVmFGWDlHYnFmS3No?=
 =?utf-8?B?SlZDNU55VWU1TlhXN2JrZlp0ZUdFYWViMzVBcWlodzBCRTF5bjRKbE13L1Js?=
 =?utf-8?B?WjdRY25BRTNmQkZRZnpVNFpiMTVHeXduR1ZJTEFGV0t5REEzVWE1eWRaSWRR?=
 =?utf-8?B?QnV3cnBGTU0wWTFrN3pNS1VoeHJub3lKT29yUFg1Rm8zelJPMDEzcDh2MkJP?=
 =?utf-8?B?Nml0V2UrOXhEV2VTaU9RcFRMWUdmYjdrb25kT3g3bjh0ZnFsZFFSWTI2UDZ1?=
 =?utf-8?B?eTNYOVVNZVZEaTl5Sm1HR2ZRUG1iZkxyalJNd3RmcGpZNXZzcUM0SERGRVpu?=
 =?utf-8?B?WTZ5QTlaRWpGL2x3clIwRnRDYW9LUlh6dVVZVTh4MHFDeGJ3QjNZcjhzZzV4?=
 =?utf-8?B?MkErdTlxUHBYUUI1VnhZQUhzZWVuUHBNYWhFMG00TEJQNjZyZEp3QWhyOXhy?=
 =?utf-8?B?Y3lMK2hSa29ZNVB5OFBqazVzZWNrR0c4UDBGWHZzSW5Bd2hYZmxnOTZFTEFp?=
 =?utf-8?B?K1AwVkNYSFlPZFFlS1hFM3Yyem4rUGZnczdzbUdyZ09nNCtkWWNmeE8wa1Nh?=
 =?utf-8?B?TWczMEEvVU81QkRUWit0R1l6bk1MY2d1VlpaV0dTWWlaZXU2RWdEMnY1SmRT?=
 =?utf-8?B?SVlHcGhBSTQ0bkh2RlZaV1hLTXp3VXJmU3crVkx1QkJNdW9nOVhQTUhtS3NM?=
 =?utf-8?B?MFhRR1lkWEw4MXR0YW9IQUlIaUNQOFg4SGs2SFk5d3JmSmJyT1ZXWFNZWUo5?=
 =?utf-8?B?R0dqdUZyTitaZlVVcEV3b2pzdEZZWllkRUJIZy9WeisrQzg0U3dKMlZZaUZH?=
 =?utf-8?B?MnBFaytKUDEwL3NwUHhyanNwZkdUd0twUEpnTmR3YmlCTGUybFZaaXZXR0pY?=
 =?utf-8?B?WE44eERqVkxFQUQwSnpvMitiMUV5Y0padWpCTmJhcCtCazU2N3o5dXVJWGFI?=
 =?utf-8?B?RTdyOVNDcG5qYmNGbmZWd3pOOUUxb2ZWenRjZTJNOVMyRXFPbU9pcS9ERysx?=
 =?utf-8?B?TXVVZWoybTBUcFlkc3hnbHFuVG5KMFE0QzJmYXptQXM4OHMzTWpPYUkrUUJs?=
 =?utf-8?B?b0VRV0dZenpVOVdzWUczK0haTlBvQWlXWC8rNEl4OTRqODZqbm42QW5WMjZw?=
 =?utf-8?Q?zB5kyJh8E6oNdI02+0WMK5dgZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac35c40d-15f1-4e9d-d4d8-08dd30549956
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 02:23:26.5460 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GY0cdpnOFtUDR5TED44NNDerYD1GOF+GCFKza/yLB2hqcsk6f0o//NaHzNL2zuoGs4iXjOoyyX8BymOODacZww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9355
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

There is no users of global data in imx8mn_evk.c, drop it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx8mn_evk/imx8mn_evk.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/board/freescale/imx8mn_evk/imx8mn_evk.c b/board/freescale/imx8mn_evk/imx8mn_evk.c
index f20ffbc52501a8a5c3ae9603b04847bab2cbd8dc..1b9dc51978b555256532f22e1cfd317bacee5b37 100644
--- a/board/freescale/imx8mn_evk/imx8mn_evk.c
+++ b/board/freescale/imx8mn_evk/imx8mn_evk.c
@@ -3,13 +3,10 @@
  * Copyright 2019 NXP
  */
 
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <env.h>
 #include <init.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int board_mmc_get_env_dev(int devno)
 {
 	return devno;

-- 
2.35.3

