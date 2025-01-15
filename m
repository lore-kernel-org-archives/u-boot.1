Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC43C02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:31:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20A5D80737;
	Wed, 15 Jan 2025 14:30:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DALgIW0n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0921A800C2; Wed, 15 Jan 2025 14:30:18 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::616])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDD618077F
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:30:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hssd6oTS7Ey5Dbo3Yo2PwjTqgXzEm1gbuaiFxAPklRayQMR/kjixgAcJPWOPQNyzydQzuS53RNpfIsBfyGgndE6IziuATGRT4HXCmA7MPe0gJQrQQR5f+ucFYD0g1mNIlnfmZVBdiT297J9AWfNjj1eb9zEpSSlRm80tjPnTssTN3xUIjNz5xmuuU0F9aN4Y0lRETtYAxqm3U+Gp/M9sG9piEMQbNRw2uawXCwhFP7W9Y9fkn5iQaTqi53rG1ywJWXtpPbpAk2RbpcOaK/AIyKyFERiUok792nMmmOprKny2+5ZC5g1xPGyFANHcnOlh3gtslEtfVUjG+GtXFGBRpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+qQhUwc5KYSelzx2quK8eh0Ek3CR1QNvkPwSYCY1C8=;
 b=Sa4HLwE2kj0XU4HrH1i76/Y0JnuNa8OYBgqPli2I+E6ZCXaFKF3El7h/2cfY8qx1ciiAL9eueUz2ZK6vLCXYtXTRjK8b9b9+4L1x0zW4G9//SWp9IWTI9wUVRAh+5vQWEJYV5x+s1pXzYewbY6oIcZrifMbrPJ3i+oOYeED+Wz7SPmCHmeKngh51Pd81EojD8xY6qWEQ5WDV5d2D9vvDvC5XtGyBIA5trYvAqrWhmwByVIFFS10bmeIYCDwFAFnvlCG8m4HIGErlv21ctH7hf98ELSOOoFyoJNS75EDlKPVKAvZgCOAxvcj3sec0U4bC7JlZJOUFQFJKTNIcBw+MpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+qQhUwc5KYSelzx2quK8eh0Ek3CR1QNvkPwSYCY1C8=;
 b=DALgIW0nkoDtzSKKkVSLDtRhKmKtjn3Vq/bDnRK75oXaY4rFTQf/Wvr8jtPcmemUF9DxmxwS/I5GZsz3QTKmCycPbe+gJyjWe0AbhwCJGorT3gizvdgWmlJ21X/GabuZZs2qwDpNMjxMvWK8QSPw8IsHamEtzYyL8CYNyIz5WcIUJk9WuL4I+E/9ttF9T/EyoM6RdOve9C/kdgHrh0gwtSXBxKFsimmDu4YXRSccX6RNOeN6aKa1PW+Mdrk0scPE/X1jhvT6KN/EgIJISdTmZOfV7BElf0SeQyoSu1fMekxpXiBFAQgHb44QvTmFelgUYjZhLEMcdaaiEd0PROUX+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB8593.eurprd04.prod.outlook.com (2603:10a6:20b:424::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 13:30:13 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 13:30:13 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Wed, 15 Jan 2025 21:29:03 +0800
Subject: [PATCH v4 16/20] binman: add a new entry type for packing DDR PHY
 firmware images
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-imx95-v1-16-93b28a514dea@oss.nxp.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
In-Reply-To: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, marex@denx.de
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736947742; l=5098;
 i=alice.guo@oss.nxp.com; s=20250115; h=from:subject:message-id;
 bh=875gBGIkSErbgtQsNPPuwEZd6+dJnIkt+9sHWZvI418=;
 b=l7WMYnbH+BCVoMwr9Kgo9Nv4RY5+CFPqQle45QSyXxAHgCV3hOV70iIN36efIiDytyNONfIb+
 usjT0WzndtJD8XAEUbG2JLsa6nYBeu2njXzuhLjmTduofTCfSIz/YzY
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=MQFotjdbgvdbpnpHmN/PUzfJXX0wchusR4L7yfs2VZQ=
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB8593:EE_
X-MS-Office365-Filtering-Correlation-Id: 03641e98-97d0-4230-d58c-08dd3568bdcb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WmtJU21OR0N2aVVUN2QzNzdVdW9wUkFFSmw4dnhLWTM4QlFhaUdDelVjWmpj?=
 =?utf-8?B?S1Fwdk53WUNZWHpLWjR6bnFmQ2VuaWhDVi8xVmZNMThkLzZlNjExeUJRbjJB?=
 =?utf-8?B?bWlMQ2RLOHNVS1REVWZHaVI2VlNtcTZYTmZ5c1NPZlF3NlMvbytNd3pNK3Aw?=
 =?utf-8?B?aEY5aEorWUM3QWloUlNBd2hCTE4wdlhYSGdxa1pmSUZnZUh5MG9uT2cybmhj?=
 =?utf-8?B?RzRzRzJBT3ZJOTkwaGJrOXJzZTQ5Y0ZURXJGT0tPYUI4T0dSbXZGQ2VtbTJN?=
 =?utf-8?B?OEY1djlxZnRUV1haMmR4bGNXMFJ0b1h0SWlHRlhWa2dtU0JUcHlKYU5mU0l2?=
 =?utf-8?B?QXpDa3Y5ZEk4RkZkRE9hbndMSURPTmNhWG1FNFRxM2RJOTZpb1BqOWhJV0Z3?=
 =?utf-8?B?ZGpsRUtFQkFCL3JLazZHSDJReHpHNlpEQndhajZUNEFmT1dxZVZNeUYvUE5z?=
 =?utf-8?B?UjFwZEYxdGtHR0NoZFZKT0JBZTh0YzVVNWRLbjU0OE9WU29hSGt1NUczbmdX?=
 =?utf-8?B?c0hRSit1OXBkbndIbU9SQ2dCWUZRcEZITzRSaVh5cWtibnUwSkRNMmxWd1VQ?=
 =?utf-8?B?dzJLSi9vbVpOUmR3Ykh6bmY4UTZlV2Iva2lwQTFTRXVaTjRXNzR3dVJqYzFy?=
 =?utf-8?B?L1ZwMEFQSEcvS3piUmpCbHdrbno0R1lrQThiV3ZYNHVmZ1p4c1hQb3d5YWov?=
 =?utf-8?B?MXJNTC9wTWNxdVljYlJ5N1lRa0x4NHJMb3RmU3N6M0RxVnI3emZRUllOQ0Jh?=
 =?utf-8?B?RkNyVkFxUmpyS3ZVQUplU2t1eUZvbjJzUGZ4OFRTSDBvT0hDWmhlb0l1aHJx?=
 =?utf-8?B?Q0ZVZHZ6YVhQajlmUEUxemNKM1JvQ0MzYTVManJ2VUQ2WU9UNDRlWFdpeDJz?=
 =?utf-8?B?M1hVNUNqR3Z5bXZqRlpvWlB0TkVrN3FEL1JkaE5RWmdJQVp6WC9tNXV0d29t?=
 =?utf-8?B?M0NQYmpwNm8rS3pzdFNZemdvZVhNWk5qRnZJcVhaaS95WTM3S0srWWxHdSs0?=
 =?utf-8?B?MW11SnIrM042cGFndGVyVTAyUmprQXh1S2d0ZERDNVRCK0ZYN3BpME55RkVi?=
 =?utf-8?B?dWhPWSszRDJOZ3NEQ0wxZW8vTHBCM0kzdDVXWEw0TjVaOW5CV1krSGFjODli?=
 =?utf-8?B?OHVRVjdmQ0xhNjRSQnI1UWxtTGU2Ym1FYXpERExlbkVoTTZ5QUlmeW1tUDJV?=
 =?utf-8?B?SVZ3YXFVMC95b0Y0RXhHdjVMUk5ITmVTemt3Rlk3QkZid1E0Z1dndlAzZHVi?=
 =?utf-8?B?cDRRYm1IOExEeGswSHBFNEQ5dVpxWk53U3ZEVHp1QlZkYUpWVmJVbFEzejBh?=
 =?utf-8?B?MHYza2VQWEtMcjVNNkh3dkZJOVhXdnRYOHM0QklsWEt3dDIvb2ZjK09QMU1P?=
 =?utf-8?B?c0pGQXkrcDA4clJ6Z1BlYVJKOGdTVTdEbEs4djF6WU5oV24zdk5yRm12dm9j?=
 =?utf-8?B?ci9na3QwNWw5TE1OMTE5SXBTcDdwMW12aTJ3TzJCRnFTaHhiYkMrU1c4Y1Fp?=
 =?utf-8?B?T2tIVGg1eGNobVZGR3VWUmJDSTFoZTI5VFJVQUtsOEZ2VzJHRGtUa1lMK0Zk?=
 =?utf-8?B?ZHg2TXpoNTQ4Qk5WbUMxQUtCREZOWkpjcmZDQ0RZdFJuYnY1eHpRL0NRbEQ4?=
 =?utf-8?B?V2cwNnJhaG03VHQrQ0hjTGVQdytuYVZ1Y1Jibm53TmsyQ0VUOE4zS3kzWEx3?=
 =?utf-8?B?VExDV0sxRGdob1lzSm5XWUZjK21JQy9OS1B0bFhDbERYTGlRcjNkY0FPN2p2?=
 =?utf-8?B?dC9qWHAwRmlxdG1uaXh2N0hCVXpHeWpnY3hWUC94VkMvWVBPSEVGN3JETVo0?=
 =?utf-8?B?SlZhOTZrbUh2b1NZSGxjQmw3ZHd4d053WXFJbGwwb25aL2hFNWtKa1pXNU5w?=
 =?utf-8?B?eFYzY0xHM3N4RmZTN2ZhQXFvTmRHMTJ0NXJCQ0pWcUNaRnF1NnU3a1hxeExU?=
 =?utf-8?Q?iwX8Pc6qZEO9FTryTiVQiIWHw7BNrwIJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnF2NXp5ck9WdUxmOU5zSnRGTE4waGVwVTBJQUJqd3FISU9MWEd6YzZiWFp6?=
 =?utf-8?B?Zm1YeUg4MU9YMUpLQ3BVMGpVbXU2Wm5weTNxUFpyRURuREEzSzYzYUJmNWFS?=
 =?utf-8?B?Y3JtcXhMU0dYczBqb3luT3JJUWM2a3UrODBlZ2kyZGRzbXErVW5HT3RSbVJn?=
 =?utf-8?B?aWFRdTFiNHBaaUhqWUdmQkNyYjhxaUxEcTh5VjVpd1ZwWHQxZWhveFBiVFU1?=
 =?utf-8?B?TUIrOEZxd1V2VXc2cVN2ZnFYMUhDTGltdGhQVDZvRDhUV1RPT0VxdGMwdU9M?=
 =?utf-8?B?VmFrUTIvc0FyWGpDMy9BQWl0eVVpZFFyeFN4Z3RXUG5JUG1UZkI5M3JxRHNU?=
 =?utf-8?B?SDg5TG5GaEp2aDJqS1BMaVZ2YVhOaFNDUmdiZldKdnAzRHdvWGIxSzFHTkdp?=
 =?utf-8?B?czVxclJ4MkRxQzJGdzErSTNJQ2F1NEV1TlhVcXArTHpqU0FzSm96KzZkazhU?=
 =?utf-8?B?bXdJbHE5V242WW82bjM2eUpuV3FLa3lRQnZDNCticU9rb0JqcTZsRWpDWTlI?=
 =?utf-8?B?cDJUbFRWV2hvT3pCNnpKR084RDllQitxL0l6SUJabVpRTkdTQkVvMmhyVFJy?=
 =?utf-8?B?Z0YzT1g0V0JtTU10QkZuUVVwZ0ZSeHlMMmNhQkpnbGo0UGdBcy9SS0drL2hM?=
 =?utf-8?B?QlRwK1hodkJuR1hwOTd4NVY4dHFTeUNQN0RnazBoN0gzWVNlaS93emFNeXlm?=
 =?utf-8?B?bC9oZWJ6cXZQSTZnMXhEdEp4VkxQVU81alZSSlEvaHVlNTNTOTVYdmUxT2VY?=
 =?utf-8?B?Y3hjcnNSVnFWUVpYQ2dzTFBzaXV1dWgvK0ZBeTJRR1BzVGkzVE1NRFFucUFj?=
 =?utf-8?B?dVg5VzB5Vk5MODFSRmQ0WHZpaWlrZFpvZ0dWaG9nQmNoRm9EUDRnbVNQY0F4?=
 =?utf-8?B?TjVCUGhSdHhqVE1KNXVLNGhrR0VtY3ppV0Q4eVVuRGtTSXVxK0RleDhVR1RB?=
 =?utf-8?B?V29UdUEvdFc4L1BienVnV2UzQ0haZk0zS2NFMEFEdytMSVZGVTNsa0txQk5h?=
 =?utf-8?B?TmlrM2VNekFQSlp2R2dUNzZNZzRheDJjSHh2VWFNcjZKMHp2OFQ5U0FJeWhu?=
 =?utf-8?B?UUpLU0U3UzdERG9RMFF6cVIvWlVoOEV3Z2pEaXJYSzNMZDFUZWozeVp4dzZh?=
 =?utf-8?B?dXEvMTZnZW5CSngydWI2bVBXN2phSVBDWVdqVk9OM0l6VmplNGY5bXBsV3Bs?=
 =?utf-8?B?ZVlGSjVYVFRDcXkzVWVrMnVPTkllQUdyc0szTWdzc2wveDRKRTVncU9TRUxv?=
 =?utf-8?B?RzM4L3hQSHhyNUdFbFdadVZWQXNrUlRyZCt6ekd2R2dPWlRxdTBBMG9EMkV2?=
 =?utf-8?B?U1JnMjN6bUFsVWlCQ2hYYThDQkpiZEkxL2hzLzB2blNMWm43aE05d1hwc2Z5?=
 =?utf-8?B?bXNkUW5uSUdQOEtpbkpTencyNnNLZjVycS85N0t6MExuaTg0SWNrSkttOGlq?=
 =?utf-8?B?bEM1MEdXNlZHTGdZQ2dWcTB2YWk1Z2VPQ3R0TWp5RzRWNm91M2hGNVJwNkJ0?=
 =?utf-8?B?VlBLcjd1cThpaFpDSFFUeEt5TCtBRXgzYzdHcHBZMnN1RHN2ZVJ6ckJwOWhk?=
 =?utf-8?B?MmV2SzcwQTZRa1FDbUlHc3RTVjdieWxKWWFGeEc1YVh5eFZtNlF5dXc0Wnd4?=
 =?utf-8?B?aGlPTi9GRzNSZkNKOVVtcWkyUnBRNmFQSFUvalpPcGV2dERYYWJXNHEzMDF3?=
 =?utf-8?B?cEgvSmN4ZGgzZDJmTE5DbzV0S3ZadkRjMFR4eUN3NWtBZ203ZXQvZUhTUStl?=
 =?utf-8?B?UC9XcUwwclJzNzN3TGpaYVE1MVljTlZDeFV2em1wcklKUGU2QXFyNS96am1K?=
 =?utf-8?B?QkJPalNWd1VYcnQyMXhRQ0VXL1kwTGxyMytsR3dJTEUrWHFTTDRTNUordTdj?=
 =?utf-8?B?Q1UrWTRMK3l3ZGg1L2JBaXVaUGF5aGtRRTZidGJnSFY4WUpKcjJjSHB4U01t?=
 =?utf-8?B?SjdEd3hxT2JyaDByK0M5aUhMMVVpa3N4ZUJnTkxKYVh2NWovbzVnaS8zc29L?=
 =?utf-8?B?dllJNXcrZ2VIaEdZOVZPZDRwemNBT2pXeXZLbjNsR3FONmtPZEdUR2c0dXhn?=
 =?utf-8?B?SDZCd0NQMjNvS2dhQ21BUVNoOVZzcFUzaVZmSG1IelpLSWNsbVc3WlFTZDdI?=
 =?utf-8?Q?beAoEISWFOvi6uk3p00Rstn8y?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03641e98-97d0-4230-d58c-08dd3568bdcb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 13:30:13.5103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g1jgn8Hb6eMDw4SqwOLlaVWZKwzUArsJ1aEo1nSo1skrfyVKoCazV6AH9bFB+pLtOKMn69dpQ5B0q4oBmRD5bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8593
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

i.MX95 needs to combine DDR PHY firmware images and their byte counts
together, so add a new entry type nxp-header-ddrfw for this requirement.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 tools/binman/entries.rst                  | 10 ++++++++++
 tools/binman/etype/nxp_header_ddrfw.py    | 32 +++++++++++++++++++++++++++++++
 tools/binman/ftest.py                     | 11 +++++++++++
 tools/binman/test/346_nxp_ddrfw_imx95.dts | 24 +++++++++++++++++++++++
 4 files changed, 77 insertions(+)

diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index 780e9817fb6496b5f2a4aef6ed1c0b4c8d9a4ba2..6da3f0b904643360ca11da32e31129f5f54d279c 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -1663,6 +1663,16 @@ Properties / Entry arguments:
 
 
 
+.. _etype_nxp_header_ddrfw:
+
+Entry: nxp-header-ddrfw: add a header to DDR PHY firmware images
+---------------------------------------------------
+
+This entry is used to combine DDR PHY firmware images and their byte counts
+together. See imx95_evk.rst for how to get DDR PHY Firmware Images.
+
+
+
 .. _etype_opensbi:
 
 Entry: opensbi: RISC-V OpenSBI fw_dynamic blob
diff --git a/tools/binman/etype/nxp_header_ddrfw.py b/tools/binman/etype/nxp_header_ddrfw.py
new file mode 100644
index 0000000000000000000000000000000000000000..80e0611df609107d6e092a5a6d8aec05b80a6347
--- /dev/null
+++ b/tools/binman/etype/nxp_header_ddrfw.py
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright 2025 NXP
+
+from binman.etype.section import Entry_section
+
+class Entry_nxp_header_ddrfw(Entry_section):
+    """Add a header to DDR PHY firmware images
+
+    This entry is used for i.MX95 to combine DDR PHY firmware images and their
+    byte counts together.
+
+    See imx95_evk.rst for how to get DDR PHY Firmware Images.
+    """
+
+    def __init__(self, section, etype, node):
+        super().__init__(section, etype, node)
+
+    def BuildSectionData(self, required):
+        section_data = bytearray()
+        header_data = bytearray()
+
+        for entry in self._entries.values():
+            entry_data = entry.GetData(required)
+
+            if not required and entry_data is None:
+                return None
+
+            section_data += entry_data
+            header_data += entry.contents_size.to_bytes(4, 'little')
+
+        return header_data + section_data
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index a553ca9e5642b685b908e817972b42bfba1d8a0a..62acc1d885cf6565999672d25584602929c3c4c3 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -104,6 +104,8 @@ PRE_LOAD_VERSION      = 0x11223344.to_bytes(4, 'big')
 PRE_LOAD_HDR_SIZE     = 0x00001000.to_bytes(4, 'big')
 TI_BOARD_CONFIG_DATA  = b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
 TI_UNSECURE_DATA      = b'unsecuredata'
+IMX_LPDDR_IMEM_DATA   = b'qwertyuiop1234567890'
+IMX_LPDDR_DMEM_DATA   = b'asdfghjklzxcvbnm'
 
 # Subdirectory of the input dir to use to put test FDTs
 TEST_FDT_SUBDIR       = 'fdts'
@@ -202,6 +204,8 @@ class TestFunctional(unittest.TestCase):
         TestFunctional._MakeInputFile('fsp_m.bin', FSP_M_DATA)
         TestFunctional._MakeInputFile('fsp_s.bin', FSP_S_DATA)
         TestFunctional._MakeInputFile('fsp_t.bin', FSP_T_DATA)
+        TestFunctional._MakeInputFile('lpddr5_imem.bin', IMX_LPDDR_IMEM_DATA)
+        TestFunctional._MakeInputFile('lpddr5_dmem.bin', IMX_LPDDR_DMEM_DATA)
 
         cls._elf_testdir = os.path.join(cls._indir, 'elftest')
         elf_test.BuildElfTestFiles(cls._elf_testdir)
@@ -7826,6 +7830,13 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         """Test that binman can produce an iMX8 image"""
         self._DoTestFile('339_nxp_imx8.dts')
 
+    def testNxpHeaderDdrfw(self):
+        """Test that binman can add a header to DDR PHY firmware images"""
+        data = self._DoReadFile('346_nxp_ddrfw_imx95.dts')
+        self.assertEqual(len(IMX_LPDDR_IMEM_DATA).to_bytes(4, 'little') +
+                         len(IMX_LPDDR_DMEM_DATA).to_bytes(4, 'little') +
+                         IMX_LPDDR_IMEM_DATA + IMX_LPDDR_DMEM_DATA, data)
+
     def testFitSignSimple(self):
         """Test that image with FIT and signature nodes can be signed"""
         if not elf.ELF_TOOLS:
diff --git a/tools/binman/test/346_nxp_ddrfw_imx95.dts b/tools/binman/test/346_nxp_ddrfw_imx95.dts
new file mode 100644
index 0000000000000000000000000000000000000000..889f6f29860746c09a91aaad7658976559760d9c
--- /dev/null
+++ b/tools/binman/test/346_nxp_ddrfw_imx95.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		imx-lpddr {
+			type = "nxp-header-ddrfw";
+
+			imx-lpddr-imem {
+				filename = "lpddr5_imem.bin";
+				type = "blob-ext";
+			};
+
+			imx-lpddr-dmem {
+				filename = "lpddr5_dmem.bin";
+				type = "blob-ext";
+			};
+		};
+	};
+};

-- 
2.34.1

