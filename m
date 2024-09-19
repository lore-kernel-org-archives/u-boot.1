Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AAD7CDD562
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 00:14:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0321E8903F;
	Thu, 19 Sep 2024 02:14:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PgZMjodd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B85A789048; Thu, 19 Sep 2024 02:14:45 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::624])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50B788903B
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 02:14:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AIQBY0r15n3M6u/uyJ7CZw00ddrEoTc5KLTvXrCZvdrHfv1McsaJ1h8or9Qp1ceQO2k04qd7J9dw2zHR84BcY+yRWrjmXmHu4YdKRgZSsVK5NPd+pqf1QvKXadI+Z+Tgv48LqzRFOV4rXODUDAUi3zsV6U3HFtOsTRuVExz0xUMjAzO77sENT25GKWJuCW9Liuh1cuOVvunG7MdISGdaFeE7beQynSN9vFVpjfNkVFZu3JB29lp2lTsRSDcQlYH0npM+TpPJgrICEyov+5r4GjlJrHoZPHWhm9LqtRl+ufaKwqpXGTlvHfRkV6tmjHpbBVx6wZyo/gpsaLBD9KB1Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMo4MU+UKFqginqCyJdet7Tl0UPaEb0JOuncMkNX8I8=;
 b=P85IsrU11zFaKOA1rpWGXMTzR37WHyxJRBsqmN69Fu4zDt6MJBFUoiiVMI6JySG3295uKo5f9c0FZbz+ZTO6oLwqVo0KaKNx1y2aeAaAcbMmaUU9mCj1T74Dvrg5jAuZXwLfqK1VCx4+E5XQcLzT/D4QYC/F5w1GN2Q/TU/dfUNKWYt0k5lXvoDUYD/i/G0eMKfomVcGzT5gRgZ9esXoPCb51mblmA5kBa+qYSy5Zc7ieFgclVavb3FwYnyrumLeb58IHQYmtUnGTF9pY2ZrKM9ivLTnUiHkJKOtg/U2LCpuqCDKkDJPN2w/fEEMIvoSmGl0T0LYgSi4Scy60c9Ojw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMo4MU+UKFqginqCyJdet7Tl0UPaEb0JOuncMkNX8I8=;
 b=PgZMjoddb4QRMWhiQOuv0w+AH9E+X6oz9MBFG9DXZvDdn7CWOFFJ1udUP3QzFLSXie0gwcVTsKniGyw01mi2A02Gea+uQ00/6FwUuYpb87JVp+H6ab3I6nfdENsPFTJK/9HKnj++8X3DpqRBSpJvQYY7q87YMK/Q5PTcjgL3nFJkBEzixiT/hRbeqhbW7MPh8Y4xyMMUbdda02ypq/awj9a5NgqZtF10Pcpug3UZsniLkSx4CY2XF/m9s5+VeQtHI9x32DQzAXEpCNSU44GmFX0Ndvj8u/uHY5moojbpVA79nzHjVCKBbs8N9CqXeMIRWIbxKVBx6sEyOY3ca7Tf4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB9066.eurprd04.prod.outlook.com (2603:10a6:10:2f1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 00:14:40 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 00:14:40 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v2 00/21] imx9: various update
Date: Thu, 19 Sep 2024 09:17:59 +0800
Message-Id: <20240919-imx9-update-v2-0-0d798d9e08ad@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMd762YC/1XMQQ6DIBCF4auYWZcG1Kh01Xs0Lsww1FkIBKyxM
 dy91KSLLv+XvO+ARJEpwa06INLGib0rUV8qwHlyTxJsSkMt61Zq1Qledi1ewUwrCYnUDLZDNI2
 B8giRLO+n9hhLz5xWH98nvqnv+nP6P2dTQorW0kDWom56urs9XNEvMOacP6FZZ5mkAAAA
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SG2PR03CA0130.apcprd03.prod.outlook.com
 (2603:1096:4:91::34) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU2PR04MB9066:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ca23c9c-e53b-4d69-2dab-08dcd8400d0c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M3FlbTJvRDdQcmx5WkFmTS9xZTBwczIwS080NzFSbjJ1azhsQWJSQ3FycUU2?=
 =?utf-8?B?NHQ3NVd1cUFVa09DckxJTXdnUDlZdlcxWm5zaEY1OXd5VW1kV1JNRDlqYTB4?=
 =?utf-8?B?SVp4dm9oQVRweDZpbUUwajdRZE5jVEFtWUJSNHBMVFBmeHN5azhsTnZ3c2tl?=
 =?utf-8?B?UlJzeUpSWTVQOUtQRHZRMEZmVEd5RzIvNUpucTBFVCtOS2FJVld2OFZkK01l?=
 =?utf-8?B?Nlk0R25NOUtzUXJBcmhoZW1aVGZRU0Y3bGs5aWhCeU9nRWw4TWNaYW41OWtC?=
 =?utf-8?B?Y25mejZSY2ZjRHlGZlUwcGl3UXNMcS9uR0NrNkJqTTNBTGZFR0hUSUhWdkY5?=
 =?utf-8?B?RkZpMURHcEZESkZSTDRlTGJjZDlaU1F5ZzdCTStlZ21kU0tqbE0rdnFDbE9C?=
 =?utf-8?B?OFdoVUdoaE5CQ1RKSGpSS0Z5ekVEaGF3N3BteUlnTmovb01NSDBod0ZhdHhz?=
 =?utf-8?B?ZkFLcTdmNHdIOUQ3WnM3M2h2QkdnQzNKbXdwQUhNZFBpNlplN1l1SWF2NGVy?=
 =?utf-8?B?YjU3WEprU25hWXhHOWpyYzcwZ21pK2ZnSHB5aFFaOXdDYWJTOW13WFMweGdm?=
 =?utf-8?B?Z3ZnMEl0cHlwVGhzYXdKTTZScCtlK1cvQW1JMERkNU8zdUFOQzZ3Z292VVdK?=
 =?utf-8?B?bG9OdjZrb0NIV2ZoWXhSb0poOVNVZGZqY0pDY1ZESEpYeW1YVXM5akRZaXVV?=
 =?utf-8?B?K05NVzVHSE9WZUtKMENFUDM0T241TEpXZXJDaEFxUHhIZ2ZLbVh6aW9JZlNO?=
 =?utf-8?B?aHkwL1g5Wm16eEYwVCtOY2NGRzVFa250akduVUpFVklqcFlocitQWGxSdXdm?=
 =?utf-8?B?TTNScEtBY2l1ZjBuZFJ1cW95R2RrN2lKMkdSdThLaUNkMXhsYnpjdUh6d1oy?=
 =?utf-8?B?NXZRUDRNdDc4cjNtYzc0elI2MUN5NzBXa1FzQVB5YW9Nb0llSEIrKy9NMGJY?=
 =?utf-8?B?dExyNnZTWlBuNllFQkxxQXphQVhuU29oWlhRRHVuMkYzaGZpeFdITEVFejdr?=
 =?utf-8?B?d3IzMnk3Njg5Qnh1OTBHaDd2T1huT0pZVG5jNmQzeWdEQ0IxYnIxMDdXMzVC?=
 =?utf-8?B?bDBpTFJMQnp5SXhlaWR6RS91L2VJbzdtc09BMmlXNDlhMnNUL1kwWDUxQUZW?=
 =?utf-8?B?QWRmQWQxSHdLdkp2VWgrWGVIVCtzdmFjU0hRVERUZHVkeUhOTkdINXA2Tit0?=
 =?utf-8?B?QUJWVFJvVmU4a1ZPbExMaFZNbHJtU20rV1VzVW1NL0lCZjNCb2FreXZTKzcy?=
 =?utf-8?B?R0VmT0FRNTRUMkRObGVCQTgzM1VDUzB3V0Q0Mk5LZU4ydHZnMVlNc2pRSUFM?=
 =?utf-8?B?SjU4Y3BvVVpkbUF5ZnljVmdaSjEvNVRYWkdxenRWQVhzcUtmaDE4Zm5rYlpU?=
 =?utf-8?B?ZjRhSXY0cmtRZWxVTG9XeEtXV2ppcGJVZ1I5VFVYQ2lmRk5JNnlweSt2QzBh?=
 =?utf-8?B?NGMzWXJCZnlOS2ZzRkw0UExmdFNuM3dTSG1iMDc0RTZJNEwwR1J4ajhLOUox?=
 =?utf-8?B?VmZmYktJNyt2OEZzdHpGOUl3RTBZRXd3SDlZTTJBZ25BTDNxb1c0N2Uzbmhw?=
 =?utf-8?B?T1p5em85cng5U2RGdU1Bd0RwVlhIM0ZsV1ZOejNOajYwbVJPSHlvamlBR1c5?=
 =?utf-8?B?WWlDMGVmbVI5TE5SbkY3MlJ6cmdiYWlzalFPY3orbE1NaHI2Mm0zSytSbVBx?=
 =?utf-8?B?SkhLR3RsbG91bmNKREhNRUtUd1BXR1JRWGtyRDBsMURMTDNjd0R2N1p5V1Qy?=
 =?utf-8?B?Z2tHUmdLSHFJOXQ1V1h2NkZCWlJ1eER5VnROSHp6c1haK2Q4R0RNQ0t3NnNl?=
 =?utf-8?B?bVppRUdVc0ROK3drRUV2VmpyajRmL3lCRDBTVjBPUU1BZDNCQW8vekNwRnRo?=
 =?utf-8?B?R0duUlJLVFZuM0s3eUdNbXNGUWtsNWVBRlBxd2lhVHU4dEE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWh0MlJwb3FvYVpNeEJlMnlhV2M1NXFveStVU2JUdHIrcDBMQXBHUkQ3bWkz?=
 =?utf-8?B?WW4wcGVMRGlWN2gycHR5N2JvZjIyYVBnb1RjeFljOGVUTEh2amJBUDcyUGFQ?=
 =?utf-8?B?WHRwakpEQXNtWlBITXQrUWNmNG5BVnlHQlhCcXlCTU81a3F6Wjl6cVJtaXEz?=
 =?utf-8?B?cnF3em9ncFh5Ym9kbVkwQ2o3SkV5aUx0SFNBR2NRRXJJcGRIUjRiVzFncmlZ?=
 =?utf-8?B?ZTdnME03N2NwT3F3Vk9QdWV3NDQrTUFMYng3OTdMVEZIaU04N2prVmViQTlN?=
 =?utf-8?B?NmxxWGc5UnZXcUhnbHdyLzE4VmNrcjhDUDlaUzVnc3dnUVF0NGJSL1JuSmo1?=
 =?utf-8?B?c3NNR0VlNTRGT21qNitIYlh4aFI0NFBSVVoxVkc0eHFMNVRQc2RCNGowQlBL?=
 =?utf-8?B?ejFTZlFNTFpMY1dWKzU3elA5aG1WQjZUMk1rZE9EOWkxbWpQSURwZ3ptTUxl?=
 =?utf-8?B?MmU2eGM4bUVjeStTVkQvQ2N0SUpVMWFuVkRYU1JHVnhPUHRpQlI3SzRVbk16?=
 =?utf-8?B?bHExMUk3V0xyQmE1YXNyUmoxeG9EakxCQXhuSXFNRGR4U1JrTzV3TFJQMzMy?=
 =?utf-8?B?VHg4Y1hlUFozb0wzVCtHbzZIQWpYd2IzTDRUazRReWJqU0ozTFlZejlkWjhQ?=
 =?utf-8?B?bVhaVmxBNEt4a2lJNTdTcGx5MnFKbm1sSU56OW5KemlPK2ZrK0pIQ1JNOVFk?=
 =?utf-8?B?TWIzSTRPb0xKWEJmek1DWUxsb3kySXNvU04ybmwySEM4Tzg3UFFBZXUxc2ZS?=
 =?utf-8?B?bTlaZGxDaWpNTW85eGRnM08vcm1uOUlpMnFlRFErT2hNYjFUNURLUGU0UitO?=
 =?utf-8?B?UUoyU3lzZkc0Vk81bXZhSStUV3d2TEZLU3puTmtvMnZNdVpVTjBiWmx0TVQ3?=
 =?utf-8?B?Vlk0UzRKV3JEV2ExVFBrdFlhNDc2bEZJeFV6T2NQSFM5dkQ2L1JHY1VzTFhF?=
 =?utf-8?B?UXJSM2s5Nm9CeUkzSG9IYmtYZGJhdlgxR2ZYbzhNRk13bWNZS2xhZ1hvcEZu?=
 =?utf-8?B?aVFzY1U5WFNyS0JzYXVDTE5OanNabElZajdaQ09xMGpNVjBZM1Rmay9rMnpo?=
 =?utf-8?B?VWMyT2xnVzdnQ3ZabnlFNnNUbUt2c3Bia0FkSHoyUmRUelFMaEcrT1ZvT2Zr?=
 =?utf-8?B?M1htOGFySWJsR0NBczNjOStrYnJpZ0RhUCtsNWlBVXZzK1hDb2dSaG05bUNo?=
 =?utf-8?B?UkRYSk04UjI2Z0FTaGcybFBQblp0UE5RNFBFTG9CbXc1dUwzdERvZjlmZ0E3?=
 =?utf-8?B?T1M3aVowS3VIWGZFeXFCSEtnNTU4Q1VyZzVBdWkwYXZIZFVEOEJ0bC9Jdkh4?=
 =?utf-8?B?emZkcTVoZWJnbitKUmc1V3Mza1FrNEJDcEpPbVp0YnNyZTNkQUUrWElSb1A1?=
 =?utf-8?B?cDV6K2FMV1RLU2FUSEZKaWlDOC8xRlpZSTkyWWdIaFhNb0xHTXYrRnhMbzlX?=
 =?utf-8?B?QTd4UDJVR3dnSlpBMklVOW93NDF4YmU0RDQ4SVRadUJWZE45WmVkeDR2T0pk?=
 =?utf-8?B?UlJrS2NqbzFjTms1cTJWNDVuMGhyRzF4aE5tZVpkTkpZNjdSdXlTYmdWNUFn?=
 =?utf-8?B?RzZBTUZWUXA4dCtTalhiUTJSMHprMjVlUWF1WWhFTzRKRVFaaEpCS09ycW1v?=
 =?utf-8?B?NFR5QzRLTlErSzJLQ1VIRjFjVERtVGZIbkQyQ0JpSXVWZXlTZ0lXbVBEd0l2?=
 =?utf-8?B?RXBQU2N4S3RRdXJUcU1GVnp1RUJCdkl5L2hGUFl5ajY1cDdEUzFQSkNabUM0?=
 =?utf-8?B?YWJ6V3h6SGhiaUhzN2lPNXlIQ3BEVmovbUNLSVRnRGNTb09xNjZKcEZpZUNi?=
 =?utf-8?B?UjIveUdJdndiRWl4ekoxOWFpdW1rY0ZOTzVieEZEWFRkWXdud2tWZTd4emZo?=
 =?utf-8?B?ZldWOExGV2o0ejZYWjVnTDAyREgwUVJqVktOQ1NQdjFXTldsM3JjWUpMeUdm?=
 =?utf-8?B?eHdEV3hQVVMxbXNQZ2l6VnUxcU43ZkpnbFlrU1B1NU9JRXgrT3lUelA5TVB6?=
 =?utf-8?B?SkNzOE5ianNiRm4wcThYelJvZGNIMG85R3pYaFV2eXBkUTdvallLc1BPa2pC?=
 =?utf-8?B?ckU0b0lycW51cGRWdE5jSzIzNTk0Z29CMjJqNS9aWFMyMjN6cnJBRmJhbjlE?=
 =?utf-8?Q?7pMLqR1+zvVVzeRb6SISHcaf6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca23c9c-e53b-4d69-2dab-08dcd8400d0c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 00:14:40.4517 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CcLYKnWxxJhZr9oy5ujoVAtuUPPVeKe3uQpbP2MNxYRzuXX+p77esPQQ7lt+qNoFR7WzW4V7WhjtTikw8S5ISg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9066
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

Several updates to i.MX9 SOC and i.MX93 EVK, the related code
has been in NXP downstream for some time and gone through several
public releases. Some are directly cherry-picked(with R-b kept),
some are modified from downtream.

This patchset includes:
power domain on fixes
TRDC cleanup and update
MAC address update
i.MX9301/9302 included.
runtime detection of voltage mode
PMIC update
generalize some code for i.MX8M and i.MX9
i.MX93 EVK update and misc.

CI passed.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v2:
- Improve subject to patch 3
- 'EL2GO' -> 'EdgeLock 2GO' in patch 4 commit log
- Use HW_CFG1/HW_CFG2 to replace bank2,work[3,4] in patch 5
- Separate patch 6 into two patches, one is MAC update, one is print
  ELE information
- Typo fix in patch 12
- Drop patch 21 "imx93_evk: Enable M.2 VPCIe_3V3 and deassert SD3_nRST",
  this needs kernel dts update first, then U-Boot could follow that
  logic.
- Link to v1: https://lore.kernel.org/r/20240917-imx9-update-v1-0-4fe8effc937e@nxp.com

---
Frank Li (1):
      imx9: soc: imx9: soc: Align UID endianness with ROM

Jacky Bai (1):
      imx9: soc: Mask the wdog reset in src by default on i.mx9

Peng Fan (12):
      imx9: soc: wait ssar when power on power domain
      imx9: soc: Change FSB directly access to fuse API
      imx9: soc: Print ELE information
      imx8m: soc: Drop disable_pmu_cpu_nodes
      imx: Generalize disable_cpu_nodes
      imx9: soc: Disable cpu1 for variants that only has one A55 core
      imx: Generalize fixup_thermal_trips
      imx9: trdc: cleanup code
      imx9: trdc: introduce trdc_mbc_blk_num
      imx93_evk: spl: update pmic settings
      imx93_evk: Remove CONFIG_IMX9_LOW_DRIVE_MODE and ld defconfig
      imx93_evk: add back Low drive mode ddr timing file

Ye Li (7):
      imx9: soc: Configure TRDC for M33 TCM access
      imx9: soc: Print UID in big endian format for EL2GO
      imx9: soc: Change second Ethernet MAC fuse layout
      imx9: soc: Add function to get target voltage mode
      imx9: clock: Update clock init function and sequence
      imx9: Add 233Mhz DDR PLL frequency
      imx93: Add Low performance parts 9302/9301 support

 arch/arm/include/asm/arch-imx/cpu.h                |    2 +
 arch/arm/include/asm/arch-imx9/clock.h             |    3 +-
 arch/arm/include/asm/arch-imx9/imx-regs.h          |   10 +
 arch/arm/include/asm/arch-imx9/sys_proto.h         |   11 +
 arch/arm/include/asm/mach-imx/sys_proto.h          |    8 +-
 arch/arm/mach-imx/Makefile                         |    6 +
 arch/arm/mach-imx/fdt.c                            |  129 ++
 arch/arm/mach-imx/imx8m/soc.c                      |  179 +-
 arch/arm/mach-imx/imx9/Kconfig                     |    6 +-
 arch/arm/mach-imx/imx9/clock.c                     |   40 +-
 arch/arm/mach-imx/imx9/soc.c                       |  258 ++-
 arch/arm/mach-imx/imx9/trdc.c                      |  175 +-
 board/freescale/imx93_evk/Makefile                 |    6 +-
 board/freescale/imx93_evk/lpddr4x_timing_1866mts.c | 1995 ++++++++++++++++++++
 board/freescale/imx93_evk/lpddr4x_timing_ld.c      | 1496 ---------------
 board/freescale/imx93_evk/spl.c                    |   55 +-
 board/phytec/phycore_imx93/spl.c                   |    2 +-
 configs/imx93_11x11_evk_ld_defconfig               |  126 --
 drivers/cpu/imx8_cpu.c                             |    4 +
 drivers/ddr/imx/phy/ddrphy_utils.c                 |    4 +
 include/power/pca9450.h                            |    2 +
 21 files changed, 2582 insertions(+), 1935 deletions(-)
---
base-commit: 1630ff26cc960439b5949b80cfc604a2c8aa47dd
change-id: 20240916-imx9-update-0ce38f6ccd3d

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

