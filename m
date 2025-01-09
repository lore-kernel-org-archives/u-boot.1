Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92A5E77199
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 02:23:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9C2D801FD;
	Thu,  9 Jan 2025 03:23:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nQGiCvKm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7F4A8006D; Thu,  9 Jan 2025 03:23:16 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::60d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47B2A8006D
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 03:23:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p8IzOfNSQ6XwABHm4GevJb9Us0cqYBqegailes61dbHiqiU62T6cDgYYZhPo3xvdIla1dxtUFd6ivh9Gvvr3dD/1GS4ULYsgdnjrBtiPYFbadpGVswykV6xVCZdYsanzQFFsEsoDJDWWD19U5VW6lZgI9yNl0Gl5WZgEYaMMyY7PzM9Rlzb8KI4dKmhV7399TJxoHHEmJXrZziaNIyd/KmHciY2VMG2MipMdEObZFQa4lkIUQLewv3G67TVj17JShRNrDpP22z3FOB2X9TBp0du5FMH5Yru7Szmzi2wTAMjpUN/W6U4UKWQdpEl6WxLb6PNpXuTakJtyXayt1gPFbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ffrfmx6MiKX6+wzlQ9UoZMbr89Tt8EK9U1+Ps/iNe3Q=;
 b=tjSKXXKns658rdQN1VjJQbI+65tExTrT0dfv9EUqFgkEQ9HL8k69tclHHd+Mtza93C6y04z9fIZbVpVIKcp5iVsMi3dDfZ9idO77+NLanT8IqfA/HaZKIM4OQ6epbtpWkMMSDDAdAbai9ecHd2LYT+3dooTwNXm00mMWFvJOTuKeuvxwfXUf20vgU01e2s8tYzmxZdT50Q1/Yu79KFGSCkK1MiQQMF4aGwoC8yzxMZa9z4VJIn+TkfJZv6qoxwvELXtchA2vWKke/gi2+EyPp3CgTgTY+/rKlwR0ynn20R6FTHWeZBawG5M//By87cgcjbhNmix4OPOuOovdzh82Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ffrfmx6MiKX6+wzlQ9UoZMbr89Tt8EK9U1+Ps/iNe3Q=;
 b=nQGiCvKmryPPFoZe4e5TuMOps2sJhz7kZfH5L2jxxoy9EA5Sl1lEur1ENDMFxeeIPq9HsF2oIVFtx3ZUyAIoXAe+ssXxKMVJlDVdlxYnlCoNvHqSbPVaYNfd6lElwwTjo92PUo7Ju5h8UaqiT+8seW9VNCMf8lH2Uc41/kLZdI2HEMqZ+vm6+3o0ieDwDKTKAyKTK81S1SefQbzZ1ZYT2/eFt9PcgBUfg9lpdC7DTYh2IGZ5Qfsi303F5UInSg0Wd/HAaULXZNSo5/jUk/EgYL1N8kk2HysY9lVi4p0rf1BM6pQ9RlXzb8ckCK+oXpzFNwaZsiGvg5z6DVsMtqS1XQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by DB9PR04MB9355.eurprd04.prod.outlook.com (2603:10a6:10:36b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 02:23:12 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 02:23:12 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 09 Jan 2025 11:29:02 +0800
Subject: [PATCH v3 01/17] imx: imx93_evk: switch to BOOTSTD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-imx-bootstd-v3-1-16e5fc0baecf@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b5ea0125-2c1e-4c83-4d17-08dd30549135
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VFV6dDBJeWpiaElyZ3hNVFFOTjl5R1dSa1NadnByVDVDaWdybDJyYlZndDVj?=
 =?utf-8?B?VjBWLzFyZlJlRWZ3QU9seUtnU1BJdTc2YUdtVXluQjlPR1gvU3p5azhEQ1Zz?=
 =?utf-8?B?Y1d2dlNUMEFmNEpPNUhzOGVlYWtDdFZsc2daWFFkZ0VFSlNreTRiemxScHhY?=
 =?utf-8?B?d2JWamNjaWkxZ2FqdGpBSHg3a3lmQ1JFWGt6RGVVQnVlaVMwZXR5OFpxZFhX?=
 =?utf-8?B?YmVVZkhxcDNnQVd0MFUxUTgvNUhmc0dydVFPK0ZOdFV3c2t4SGxtdkd2b3JG?=
 =?utf-8?B?YUZjU3oycXo1cUp3YXBqcmE3cmcrUXNLUlFMUUJzSThtaVRkTlh0YjBSZ21I?=
 =?utf-8?B?eUgvR0VVaHp2Zm5ST2s4cEl6Vmx3cmxnc25hVjFjRjBBUWRyT2gzWjhHZE1S?=
 =?utf-8?B?Y3hsS3NYVHNram9kNS8zS2g5K3VQVlBkNkZMYVpjTzhiQ1pXSU1HNjkrZ0Fa?=
 =?utf-8?B?YU9hL2tQelJXcSt0SEhGUWdRWUhmWmhieXpnTDFqVzRhNGVDby9WZDlnRGNE?=
 =?utf-8?B?VjhmVXVNVWdKOEU4cFZYczEvc3VhVzQ1cEwrZ3JZQTBTL1FYTGxTaHBIb0Iw?=
 =?utf-8?B?aStuWnVESjZTOGl1OFcrbERWeUdiTkczckJxeWJzbFFWMy9FVC85WmtVdmVN?=
 =?utf-8?B?YXgzZ0IybytKbFFadHVkVXk1akpZOVZmRE9PcHNZcFJ4NlJpSEo1UDA3Mllh?=
 =?utf-8?B?QUFha05wSW5KRWNiMXBvS3B0OFFUclZlV0hiRENqc0dlZU5aSGVtUm4xbUNW?=
 =?utf-8?B?OGhuRU1mcGZKOExQU0s2VE4rb0xGeXlvekdlNmQvUGVzUWN6OFZhb1BzSGZL?=
 =?utf-8?B?Qm1WRG9FQk1IcG5QYkZsS2tuMHc4VTFVM0djcXYvTUtFUUJmRmJISkZ5eCtM?=
 =?utf-8?B?WkZ5MXVSZ3BHd2ZDek55aUxYZ2IwZytMZ3g1SUhJa25Uc3VEeXQ4MS9FbE5h?=
 =?utf-8?B?R0kvbXhvMmJKRUtSekllS0NVSmhnaG9GQUFmQVRCZDYvL3RxTENmb3FKcGtX?=
 =?utf-8?B?VXNwYWgzUm1nZjcrUGFROEZtWWh6bWJpUW1MY1JsWjM3Yk0reXZrQTJqMktJ?=
 =?utf-8?B?TjBra05ZaXZMZkdVTmpaamJtQUhWdDdqcXRSNjhuWnU3ekpVZHBnb1FabVcy?=
 =?utf-8?B?ejdvTFhSa2l6NEVhOFNvZktaRnQrcGhORk5VVTd5aWJSVGJFNmNUajlMd1JK?=
 =?utf-8?B?S0FMMHN2MWg3Y2k1ZGNpeTJDcC9BeEdDSURodGZzUHU2SG5BRkJzOEpBNDhk?=
 =?utf-8?B?aGs0MGI0SlR5WWtNMU5sZXFWWWJWZjU2RlFoczhLclo2eDVzcDV2VGRSQm1t?=
 =?utf-8?B?ZkZCZXR0eEVwd3M1SUVZVVFqVHVPKzZtdVJIRjdxb1p6anp3R0VwYXE4TUNR?=
 =?utf-8?B?MGdFL3FzVWpIMkZ4cU9LTXdLNzlKbjFvb04wZmcvM0k4V1R0Q2pDdjRudnJF?=
 =?utf-8?B?cDZaSHowU0xjNzZWMFlVNStqdUtob1liUlNYUXhZeUJ1Z2ZVNlFZbXpVWTM3?=
 =?utf-8?B?SEFtWFdsU3JKUGo3RkR4TDR4R1FCRUFJYXNKVGU1dEI3UGFWZTdKaXNJYjZG?=
 =?utf-8?B?NWc5UUQvK1Ztbzlxb2t6NnRxREZWdlIvOHE0aVQvNThWT1Radmo0MGRqWFBz?=
 =?utf-8?B?NHNOQ2lzYnV6MXQ5N2p5RG5GSVp3cjZWbStwWDBCVndNcFcxSnFtSU1KMnRt?=
 =?utf-8?B?dHRtbjVUeUlzM3dBRERZMnc1N3ZxYmRPNkRFUzA0eDA1OGt6L3dNaTZSdDQ3?=
 =?utf-8?B?VXFneGNEWGlvTXVhVzRSYS95cFdYaXpiNDViS1NYaE9WUWVtbWVIdm1pRjYz?=
 =?utf-8?B?ejIwK2lJRmpHdVNFRFQrdFJDZms2K3F0NkpQbXpuVHRISkFPckovV2JEM005?=
 =?utf-8?B?aEJCT0lwbnR0WXhIcVJoZzlzQkppOThzVG5rRDU4VFBQWUR2Ymp1cGdZVU0y?=
 =?utf-8?Q?RF2/Kc1fds/ayhK1RyTolVaLF6IdC5nc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sk41YnJzbHhtRHE5MWE4VFpTNlJHN2w3LzRwbHEvNHYxSGF1NnlPRnIxYVZJ?=
 =?utf-8?B?b00yNkx3MkJuQlFiaThtRFFCOVdMRUh0WDFYYmlPcGFhQjlYSGI4Y01YVUF4?=
 =?utf-8?B?SjZnRUJVazVqYnNrNCs3WW5vb2dhNXkyQnROZWNnK0dOR2lFUTlQR2FjL3Zr?=
 =?utf-8?B?KzVjY2k2ak9hbnJSdm1WQURXbW13Z2tpSXBrNjJTbjhKUjlGNWlkZUZCUm5Z?=
 =?utf-8?B?ckR3MVNrMWlUaFRnVGlqMGNwSDBudGh5Z2l2cmF2alAyS3paV1FzYjFTcTFU?=
 =?utf-8?B?NE1kOTZnLzhiZ21hT1c0VHVoaVZaNmlLdWwwMU9qQi9US1diTDlQcE9QK1lk?=
 =?utf-8?B?MnplNTZOTThFdEdodm1tTlhWMzVnMmh2RTljaGVzYUJ4OExESXJkVzJCMUU0?=
 =?utf-8?B?dmRKbmZYd1djVHdyVVVMa0pKUTNsYkpKR3ZTSTZOUjJibE5BUUwxMFRrREpp?=
 =?utf-8?B?SE1ZQlRybDlONmxrRjBUSjZOaUV5UmpRZFdZQlF5MlJYSHgra1JaaVBvUG8y?=
 =?utf-8?B?eW1PK3BvMkVQUGN1Rmt5NTdKeDNuQUMwL01nODB0ZjYyVHNMcXdJcW5DOHN1?=
 =?utf-8?B?ZjhJR3lPVDdobWJLNWhiTEV0eEg3MktTN29GaUdNS2RxbzJORjdmWGI0QUhv?=
 =?utf-8?B?UWMreG10MTVkUVRaaGcrV1RDeU53Ym5URFlGb28wU3lvUTA1UUE5RDVoUUFP?=
 =?utf-8?B?Y1BQTjVoMW9FZlJENndrdlppZ0FPQUYzRU1ORDc4YnRjczZ0aFBxbDZBcHJz?=
 =?utf-8?B?TXpOQytsSWl4ZTdFZlNYMUdtSmRJRGthV1VXb1htVUxJSEdyZS9PajVsWlU4?=
 =?utf-8?B?bmhYM042MEc1ejRCaVZzdC90UzF1dy92QnFPUjg0N1lRbSt2U0JsZlFQWFRB?=
 =?utf-8?B?czBmVS9zdXRGckJsdml3aktDNnRKclp6NHBTa01XcklJdmZYZTlrM2QxTyto?=
 =?utf-8?B?cTlieFhXV2UxUkxBWDBQcTlvOUk4UDVNZDI4S05qYUdPb0ZiaTQ5aTNkd1BT?=
 =?utf-8?B?M2xXV1ZhcUNBOUk2elBuZFA2NW91RThrRWphK3piWlFPWnVCWWwvN3dGbzk2?=
 =?utf-8?B?SXNGYWRDNVcvTkhkcUN4Q3ZFMzhYQTVmZDJQNUlqQklLVHdpc0hMV3VOZFhz?=
 =?utf-8?B?Nnk3dSt0WVlGRW5EUVlCUHZ2VER5NDlPd0NlSW1aUW5ScEVnTzBYTTJXbGhi?=
 =?utf-8?B?QkM3SmY3Y3JNU0ZNOXVER3g0eEFQMEhvTmcvZmRuQld2c3daellHOFRDR29s?=
 =?utf-8?B?Mi9OdUNEWGhoS2wyZyt3Y2FOeXkvNFZSdlhBb01PMG50SkdlaWY3b1h4YWwy?=
 =?utf-8?B?M3MrV0hva1hXeVZ6YlR5eUc2a3B0YUhkOFlENEJFZVd4WVNrSUFVYkxVUS9k?=
 =?utf-8?B?Y3M0TkZLbDRkZ3V1LzVwU01UWjQ5K1ozV3NPQ3RjdXdkQXF2b3MwRlhDVmxR?=
 =?utf-8?B?SndMWUl4Ui9wSnJrT2tPYkFEMHhVUUVDZ2l0Qndhb1hzcFo4VnpmaVc0MzQw?=
 =?utf-8?B?SzdGdkFvQjBaNmZxeFY1anNRM3owbWJLY2VKWTEzb1FVUnUrcmttUFFwaGdx?=
 =?utf-8?B?RWlYRXFFUFhrVmI0K0JVdHpIUUZ6dXFkd0tQcjZIb0pKaFR3TzVZY3IvbE5G?=
 =?utf-8?B?M0h3czhVRXZJcGh4Rjl3T21sVlg2czRlS3hyTTFBWWREQ0oyb3J6cGxITUdP?=
 =?utf-8?B?cEFDSkxxdGFOQXFNR2JWUmc0ZkZpZCtaZ29wUUU2N3dic3huUkQ5YUpPRHlv?=
 =?utf-8?B?aTFZbmNwcVV6R3FrMzJpY1ZLMlNaNTg2WkI4QndQMVBvdDYvYWV1UFpEU0h2?=
 =?utf-8?B?MzY1a08yUEYyVzFiZGNIN2o5VGFZSDgva201cmdmYi9oRlhEbmNSUkZEd0xU?=
 =?utf-8?B?ZkpMMTltYnFnQWJNRDRLWGl4S3k4M3NoUG9oZGIwMmxWUzFzd0ZQc1ZuUGRl?=
 =?utf-8?B?VzdHUGVGdml6WERpTVNBdTEreUwwUUNxd2hzT1F6QS82WVU4K2d4bkJGVHIw?=
 =?utf-8?B?RHBWMytxYzNSbjQyemhTZmJnYWFnTE84M2ZvY1laOU1hUzJzY2o1cmU5NVZE?=
 =?utf-8?B?YjV3S3FTWS9oU3JqaCtiZlVicFpLZi80SGY1SFlVTkpzZTR5c3hBNWtaZHB0?=
 =?utf-8?Q?aCqSkNP9QTGDeTi+Jf5Ep0S5G?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ea0125-2c1e-4c83-4d17-08dd30549135
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 02:23:12.9135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ws3Y/6JUBIDWaGi4WzTicwSb3xmMKax5hOwo/qLTnIWnx8FB4CXdvTTI2SjvUzqtSKwos4zSimOuR21OYGumg==
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

Switch to support BOOTSTD with a bsp bootcmd as fallback.
Move the env to imx93_evk.env

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/Kconfig          |   2 +
 board/freescale/imx93_evk/imx93_evk.env |  88 ++++++++++++++++++++++++++
 configs/imx93_11x11_evk_defconfig       |   2 +-
 include/configs/imx93_evk.h             | 105 --------------------------------
 4 files changed, 91 insertions(+), 106 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 54c6b117fcff21be5c3800ebd1dc30f8ea12ac42..c52546084394a7cc26f35c93ac8fb62d9c5fe795 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -47,6 +47,8 @@ config TARGET_IMX93_11X11_EVK
 	select OF_BOARD_FIXUP
 	select IMX93
 	imply OF_UPSTREAM
+	imply BOOTSTD_FULL
+	imply BOOTSTD_BOOTCOMMAND
 
 config TARGET_IMX93_VAR_SOM
 	bool "imx93_var_som"
diff --git a/board/freescale/imx93_evk/imx93_evk.env b/board/freescale/imx93_evk/imx93_evk.env
new file mode 100644
index 0000000000000000000000000000000000000000..f692f42f78ab67f004a483d886388218fadcbc15
--- /dev/null
+++ b/board/freescale/imx93_evk/imx93_evk.env
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+
+boot_targets=mmc0 mmc1
+boot_fit=no
+bootm_size=0x10000000
+cntr_addr=0x98000000
+cntr_file=os_cntr_signed.bin
+console=ttyLP0,115200 earlycon
+fdt_addr_r=0x83000000
+fdt_addr=0x83000000
+fdtfile=CONFIG_DEFAULT_FDT_FILE
+image=Image
+mmcdev=CONFIG_SYS_MMC_ENV_DEV
+mmcpart=1
+mmcroot=/dev/mmcblk1p2 rootwait rw
+mmcautodetect=yes
+mmcargs=setenv bootargs ${jh_clk} ${mcore_clk} console=${console} root=${mmcroot}
+prepare_mcore=setenv mcore_clk clk-imx93.mcore_booted
+loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
+loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
+loadcntr=fatload mmc ${mmcdev}:${mmcpart} ${cntr_addr} ${cntr_file}
+auth_os=auth_cntr ${cntr_addr}
+sec_boot=no
+boot_os=booti ${loadaddr} - ${fdt_addr_r}
+mmcboot=
+	echo Booting from mmc ...;
+	run mmcargs;
+	if test ${sec_boot} = yes; then
+		if true; then
+			run boot_os;
+		else
+			echo ERR: failed to authenticate;
+		fi;
+	else
+		if run loadfdt; then
+			run boot_os;
+		else
+			echo WARN: Cannot load the DT;
+		fi;
+	fi;
+netargs=setenv bootargs ${jh_clk} ${mcore_clk} console=${console} root=/dev/nfs
+	ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp
+netboot=
+	echo Booting from net ...;
+	run netargs;
+	if test ${ip_dyn} = yes; then
+		setenv get_cmd dhcp;
+	else
+		setenv get_cmd tftp;
+	fi;
+	if test ${sec_boot} = yes; then
+		${get_cmd} ${cntr_addr} ${cntr_file};
+		if true; then
+			run boot_os;
+		else
+			echo ERR: failed to authenticate;
+		fi;
+	else
+		${get_cmd} ${loadaddr} ${image};
+		if ${get_cmd} ${fdt_addr_r} ${fdtfile}; then
+			run boot_os;
+		else
+			echo WARN: Cannot load the DT;
+		fi;
+	fi;
+bsp_bootcmd=
+	echo Running BSP bootcmd ...;
+	mmc dev ${mmcdev};
+	if mmc rescan; then
+		if run loadbootscript; then
+			run bootscript;
+		else
+			if test ${sec_boot} = yes; then
+				if run loadcntr; then
+					run mmcboot;
+				else
+					run netboot;
+				fi;
+			else
+				if run loadimage; then
+					run mmcboot;
+				else
+					run netboot;
+				fi;
+			fi;
+		fi;
+	fi;
+scriptaddr=0x83500000
diff --git a/configs/imx93_11x11_evk_defconfig b/configs/imx93_11x11_evk_defconfig
index df62eecdde455af561a23a54fde5dfc0a66d1835..43a67232d045e6f308b7bf79998d707841d3886e 100644
--- a/configs/imx93_11x11_evk_defconfig
+++ b/configs/imx93_11x11_evk_defconfig
@@ -26,7 +26,7 @@ CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x88000000
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x90000000
 CONFIG_REMAKE_ELF=y
-CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTCOMMAND="bootflow scan -lb; run bsp_bootcmd"
 CONFIG_DEFAULT_FDT_FILE="imx93-11x11-evk.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
diff --git a/include/configs/imx93_evk.h b/include/configs/imx93_evk.h
index 260a5043d5370478a6245bd4eafcf5f1c24b495a..eb40a69d20cb0aeec973a9c1a32a6fcfd831b967 100644
--- a/include/configs/imx93_evk.h
+++ b/include/configs/imx93_evk.h
@@ -17,117 +17,12 @@
 #define CFG_MALLOC_F_ADDR		0x204D0000
 #endif
 
-#ifdef CONFIG_DISTRO_DEFAULTS
-#define BOOT_TARGET_DEVICES(func) \
-	func(MMC, mmc, 0) \
-	func(MMC, mmc, 1) \
-
-#include <config_distro_bootcmd.h>
-#else
-#define BOOTENV
-#endif
-
 #ifdef CONFIG_SYS_MMC_ENV_DEV
 #define IMX93_EVK_MMC_ENV_DEV CONFIG_SYS_MMC_ENV_DEV
 #else
 #define IMX93_EVK_MMC_ENV_DEV 0
 #endif
 
-/* Initial environment variables */
-#define CFG_EXTRA_ENV_SETTINGS		\
-	BOOTENV \
-	"scriptaddr=0x83500000\0" \
-	"kernel_addr_r=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
-	"image=Image\0" \
-	"splashimage=0x90000000\0" \
-	"console=ttyLP0,115200 earlycon\0" \
-	"fdt_addr_r=0x83000000\0"			\
-	"fdt_addr=0x83000000\0"			\
-	"cntr_addr=0x98000000\0"			\
-	"cntr_file=os_cntr_signed.bin\0" \
-	"boot_fit=no\0" \
-	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
-	"bootm_size=0x10000000\0" \
-	"mmcdev=" __stringify(IMX93_EVK_MMC_ENV_DEV)"\0" \
-	"mmcpart=1\0" \
-	"mmcroot=/dev/mmcblk1p2 rootwait rw\0" \
-	"mmcautodetect=yes\0" \
-	"mmcargs=setenv bootargs ${jh_clk} console=${console} root=${mmcroot}\0 " \
-	"loadbootscript=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${script};\0" \
-	"bootscript=echo Running bootscript from mmc ...; " \
-		"source\0" \
-	"loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}\0" \
-	"loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}\0" \
-	"loadcntr=fatload mmc ${mmcdev}:${mmcpart} ${cntr_addr} ${cntr_file}\0" \
-	"auth_os=auth_cntr ${cntr_addr}\0" \
-	"boot_os=booti ${loadaddr} - ${fdt_addr_r};\0" \
-	"mmcboot=echo Booting from mmc ...; " \
-		"run mmcargs; " \
-		"if test ${sec_boot} = yes; then " \
-			"if run auth_os; then " \
-				"run boot_os; " \
-			"else " \
-				"echo ERR: failed to authenticate; " \
-			"fi; " \
-		"else " \
-			"if test ${boot_fit} = yes || test ${boot_fit} = try; then " \
-				"bootm ${loadaddr}; " \
-			"else " \
-				"if run loadfdt; then " \
-					"run boot_os; " \
-				"else " \
-					"echo WARN: Cannot load the DT; " \
-				"fi; " \
-			"fi;" \
-		"fi;\0" \
-	"netargs=setenv bootargs ${jh_clk} console=${console} " \
-		"root=/dev/nfs " \
-		"ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp\0" \
-	"netboot=echo Booting from net ...; " \
-		"run netargs;  " \
-		"if test ${ip_dyn} = yes; then " \
-			"setenv get_cmd dhcp; " \
-		"else " \
-			"setenv get_cmd tftp; " \
-		"fi; " \
-		"if test ${sec_boot} = yes; then " \
-			"${get_cmd} ${cntr_addr} ${cntr_file}; " \
-			"if run auth_os; then " \
-				"run boot_os; " \
-			"else " \
-				"echo ERR: failed to authenticate; " \
-			"fi; " \
-		"else " \
-			"${get_cmd} ${loadaddr} ${image}; " \
-			"if test ${boot_fit} = yes || test ${boot_fit} = try; then " \
-				"bootm ${loadaddr}; " \
-			"else " \
-				"if ${get_cmd} ${fdt_addr_r} ${fdtfile}; then " \
-					"run boot_os; " \
-				"else " \
-					"echo WARN: Cannot load the DT; " \
-				"fi; " \
-			"fi;" \
-		"fi;\0" \
-	"bsp_bootcmd=echo Running BSP bootcmd ...; " \
-		"mmc dev ${mmcdev}; if mmc rescan; then " \
-		   "if run loadbootscript; then " \
-			   "run bootscript; " \
-		   "else " \
-			   "if test ${sec_boot} = yes; then " \
-				   "if run loadcntr; then " \
-					   "run mmcboot; " \
-				   "else run netboot; " \
-				   "fi; " \
-			    "else " \
-				   "if run loadimage; then " \
-					   "run mmcboot; " \
-				   "else run netboot; " \
-				   "fi; " \
-				"fi; " \
-		   "fi; " \
-	   "fi;"
-
 /* Link Definitions */
 
 #define CFG_SYS_INIT_RAM_ADDR        0x80000000

-- 
2.35.3

