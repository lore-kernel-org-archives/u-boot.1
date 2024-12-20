Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 834E6E77184
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 02:57:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8D198036F;
	Fri, 20 Dec 2024 03:56:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AGYecuRa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 733CF803F1; Fri, 20 Dec 2024 03:56:15 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::630])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B7998032B
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 03:56:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ovuB2/lwojtDmpczZgu+vjzlJbU32VdPDJOTlwigEBHDj++jZ9sUebUVtzsUIRVWPHRCoTUSnlScPbhmQmZBBebdakYqYH9+cV3mnW/MII7Fya20UZOOwFI+QhDFkOcxwr0opX10D66SDjx4uq4vjI9lIcYT4KwjRxECHaGgpVKVAKEtRi6JOyiLndZ4al2sEUeO7r1F+ZuBVexIZ5h4176e6ucT8R/PQZjACzywBcw+9RD0IoJ3yuHqCM0efhjJHxW5I25240mPdOFDSwB4ZBFaLeMax0beYFiMGYDUaiDaKrU9qH+KFc+PjOhMEl112+7BMWh+ONaYIxD5FuRJbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuwOEQZEourDzHfu60ciKo7M4Bx1uaaHFcG+diFR7v0=;
 b=eppnuWjdW0oQO+HDGNO/6IBI6q9AGxXoB7fE9VHq53phIp5bQ+2qPt5koHWrE9/Surt5sseNPFvBMLh7VGr4Wqh6L4zSNFNBEsZxiWUwR5cJ0Rxpn0iST10XZycmU+fKTbxGFtFuWepioz30Sshjda2TuTVAFLgPhIbE7pfdZ2eN+7gi4KgCBhFynvEZlGeczTNOpQHP5s457SZFXDPA6cL7tpyTVImjQmfTxqCFYW7QSGZrBo1YUdigclHGGIwSM3nbOnX4EU1QIuCh2UOt5leVrGu5iCIOG3ystViWhi95nBYWtZpEyJlDTMJTvUe1BKGPizfNqXYI+1208iW85Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuwOEQZEourDzHfu60ciKo7M4Bx1uaaHFcG+diFR7v0=;
 b=AGYecuRa8Grlc5sfTCDIpMmozq3H3vges4w6C7e36FgDaPAJ+PHI3k+W7FqND7tWEdBegKiAb3vloxStiuPVjMfMGVTb+xIewnMzWcJFvc4VkhoKS0X1C3lzFsr7ivSd9DRl8SP6gCkqkR3aZq1NuWs4KygzZvd0LLm8c9gOJRpxbVPlRgpv326GADy4aoHZHUKl/amv2dq5tzml3xd6CexQXhgdzLtQaD6HKGDaLQCiIPGH4xWYOHSR9rPWYutHUPQxHdpFtzWQPItRdaLUUXzhArYgIAx/5yhUW1h9U2MK2X9q2CMmtQ+skEIiiadbjM+BBemla/ICU/idKiru9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI1PR04MB7005.eurprd04.prod.outlook.com (2603:10a6:803:136::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Fri, 20 Dec
 2024 02:56:11 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8251.015; Fri, 20 Dec 2024
 02:56:11 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Fri, 20 Dec 2024 10:55:15 +0800
Subject: [PATCH v2 17/17] imx: add V2X container support on i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-imx95-v1-17-ba81dfd8e369@oss.nxp.com>
References: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
In-Reply-To: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, marex@denx.de, Alice Guo <alice.guo@nxp.com>, 
 Teo Hall <teo.hall@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734663311; l=4715;
 i=alice.guo@oss.nxp.com; s=20241220; h=from:subject:message-id;
 bh=5mjLko0D90emd8eazTMT621owZ10RDbCttkbBOSrtws=;
 b=I2zDmCvtYlwGxMl6UZSycnuziR3FXfTsQp89XbMZBSSGNbv5c7u5VU6iUGUeWQBUherRaRfJ5
 Htv4LP7IH12DQ6y1XpmllIZ0Tb8j4VYcr7DpQeQBB8Ph6K+MwU0CwP4
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=I4wA8H8Q53tsp7q3voqI5LHsTQDw4TELC8szgsg5azM=
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI1PR04MB7005:EE_
X-MS-Office365-Filtering-Correlation-Id: a64569ce-ddad-4ea3-ab67-08dd20a1dc5f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aHVnMVVSZGZYS2tCdWdwZUR5RG0vSGN4WjhiZUdTUjJ4eVc0K1NRMFVTWU9R?=
 =?utf-8?B?YlNyK2x5ZThaLzEwQjdHZytjL29pdkJtUmtHVmYyQzlHeUFBeHlRcXNVQ2p0?=
 =?utf-8?B?Z2FMZ2NDdnpKQ1BacVNQOS9rWWllS1ROWnhTQ1ZxVHpNVDkyRDRiTW8zc21W?=
 =?utf-8?B?bFRWSkVIZUEyUnQrTzlmclc0YjBvN0QxK3BhdzA3dTI1NGpuWWFHZFZFU0RT?=
 =?utf-8?B?Z1ZLKzZTQk1rcjBUUG45RXlwQ2dsejN3M0RjYkpTekNYRVlGTjgxemhnbjJk?=
 =?utf-8?B?OTRHMDRzejYvcUsxSjNUazJNZERKd2QwVUI0RFc5NjJnRGdWN0wxWTVGSmQy?=
 =?utf-8?B?d2R4c0NHeTZUN0FRRnl0NVNqMHBZVkhOZVZkeXJ4a3VqRzJicFVqNGVaOFB4?=
 =?utf-8?B?bE1ER0VaOENOVHEvS3k2TmgzTnFFS3FvM1RnTDJOclFJVkxzWHoxSXhscFNZ?=
 =?utf-8?B?elRYVG5iUDJWbnJxRWtHZVdSWVR6TTVwWmlwLzBRNm1BWlRHcS9CZkV3dGlk?=
 =?utf-8?B?d0VPb0gzR0dWNy9GQ0dWL1ZGVXQ4aDRlbkUweURidXhlTmxUQnZlRjBhNFM1?=
 =?utf-8?B?TGdWZHVMYU1rcXpHM2Ftdkg4VVE5cFF5UWVkVDVoZ3NEaHpEenFySWxjUHJZ?=
 =?utf-8?B?Ym90Uk1Fc3N2RlE4ZWs2Z0dVQlZacW4zUnFVNUxCeldVMVZua0dEVUhKOU85?=
 =?utf-8?B?UE0wa0NLeEtLcldVM25xUTVrdXRlYkE1c1NkTmZGZzFNeHEzOGZvK2RLWXY1?=
 =?utf-8?B?ODkrYkZXNkdhWFFUdzBUbGt2dUVyazQrVGx1NlBvTGliVlVVeEZOZURtTnRl?=
 =?utf-8?B?ampjbnZGd1VsMmc4MjlaRDFLVDdJVktDMEh0V0JKcmZKUXFVWjFqTTNNS0R0?=
 =?utf-8?B?ajJtRGl5QjhxMkp0TTd2M1dDOWhhT2g4TlFhS1VEckxmUmNMS3J0OTJiVWpt?=
 =?utf-8?B?WFExTGg4LzJ0Y0dRR1dIR2JLb3JCT1VFa2lRQXp2R2k4blV4SmNIeUliWlVK?=
 =?utf-8?B?NWZpTXRKY04wMkY0UW1veGNaOHg1ei9hMFU4UEtpLzM1WTl6NEtrRzhuRWww?=
 =?utf-8?B?aGFNV0Zmb2U3YngwSVhKbFd4QS9lYUFXL3JNbEI4bzN4djZzNGpZUHlDU2ZY?=
 =?utf-8?B?K2F5WUNVaEt4a08vb0I5YzExMzMvYW1wQng5TjhTOEMxMlQ1dENlcUxBY1M1?=
 =?utf-8?B?MkMwQkxvOEE2eDR2cmxIakdEVkU4TnNkZ1VZdEZ3S1dQOVlkR2xVTWNxc2N1?=
 =?utf-8?B?ZDRaT1UreXNMaVFpZ3d0RDcrSU1KcXQwc0hmWmVJZThWcmdIZ2lRMmtCemdr?=
 =?utf-8?B?NkRiT3dYbVFhZi81SEtVcS9RZEZEZ0twVlpVZVcrTUJuRTlQaHBBK2tPRHJU?=
 =?utf-8?B?c2NxREpoUXpxUUJ3a3ZlbTZ0VFBrUXRyRFdyd0FJeWZzYk9wZVJtS0gxN2lY?=
 =?utf-8?B?a0lkdDQwdVBlajR3aGxLZmlCbktTVGVpdHhWU1BuRG1Rb0tOUUtOTDBrdWxP?=
 =?utf-8?B?Znc1eG1EVzJmYmp4ZjdlOWd5eVZHaFY1U1g1b1M2eDBJNTNYdDZwZGFuUEhs?=
 =?utf-8?B?YlJKSXpFTmJGZjErNy9NSmdGb3paMGJkMzFHTHBOeWNpU3RoemNjMTBSS0Ja?=
 =?utf-8?B?c2wzaVA5V3NxNWVsNmY2YnVzRlE3RlhUZmcrQmgxUW0ycFpCOTJvVHIxaElk?=
 =?utf-8?B?OTdYNVdiTndiTkg1SUNoU0JFTVkvdXM4c2gxYWNGSFFYd2FLR2M5RC8wcEFI?=
 =?utf-8?B?WFhndWJPbGVtSlNOMjZtbEphOWdLYjFwYUk2RDZjOUw2bjNTNllDdHFXdXEw?=
 =?utf-8?B?YkhYaFFpS2pocTlyR1gyTml4aWtGczJDSE9MTXFkdlNRemVpU2hzR2NLWito?=
 =?utf-8?B?NnhRK0JGVlg2K3IvdGNWUzZmL3dzZnpXbGZJSnFZdUVLRmVkL0JiNnV4NlNm?=
 =?utf-8?Q?VuaMDvQQ0Erf4ZJrAKNFnFWYa41XMOgl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXVXdXVudXNLQnJXZnNyQ2dPeFdOcUJnUzRIVjFXdTlDaXVFajU2TS9tV0Jp?=
 =?utf-8?B?dkFGWjYzMDY4UGNwR1hxWkkrb2FtTTdnaTZvYm1YQ1l1TWNESk5NNU5KWWxy?=
 =?utf-8?B?aS85M2RsQk5JVkFueFRVWGdNdlZIbjZXUzFkbGhLTjVVTHFzamFUWG5CaEEw?=
 =?utf-8?B?dEJiNHZ4Uzk2aG8zNnFsV2J2aTRnMFo2MHpSOTNkRHJYL3JyVmtiejlFOEZ5?=
 =?utf-8?B?UXZTSytMeStHeU1uK2piN2NKUnE3R0ZRb0tEL0pjbG9rbEtTOEZMOCtJSUxu?=
 =?utf-8?B?anRGd0VWODJrWXR2Z0k2Y3FJZWxXZ2t3OVB6MGg5Mm9qdTVVSkFUb1BNN3VR?=
 =?utf-8?B?ZGNha3ZjV09oQzdleXR5eEY2S1hNNHN0SWF1ZmpVTzFyeHdDSjQ2QlVrMzdn?=
 =?utf-8?B?cHNmOGVQUERjU0FyaDJyVXd4eGM1RVdqekdzMVVlR2gzallwckl6aGYwbEVa?=
 =?utf-8?B?dTZ1TDJwbzQrT1BBMmhybkdmMTRkSGQ3c1h3QVRNNEEzcngvS2VQbi93YVdY?=
 =?utf-8?B?ckJCK0orMVM0SkxkUTRjZHJRVjJJUHBtcEk2U3pXOCthaWo0bjRXcG9OTEcy?=
 =?utf-8?B?YmFVZEY3Q3dPdjBIN0ZIWUJQS3BOZXdpV08zZlYwd2lCSUQrMExrQVZlMkJ6?=
 =?utf-8?B?ZlhUWVRVZEZ4UnhLKzBZKzEvc2FEV2tWOXAvTmMzUThralJhL21EbzFsMm9y?=
 =?utf-8?B?NHFYZHBPS3V1ODJ2c0tJRjN0aUtHaVBOcGlydHdKYTMvbk5kWFdycHpBK1lq?=
 =?utf-8?B?eEJRUCtacVo3djVDVXM1ZVB1ZWU4ME5oblRuYVRGM3Y4SWQzditKOFo1NWdH?=
 =?utf-8?B?UnV3b3pnRnMwNFpWdHNPL0kwemVoZWNDUEF6YkthbklYQWxuQ1gxN0RoSmoz?=
 =?utf-8?B?N1k3MjBGYkNqY3ZqZDlkM0xPc0ZKaW5nWGRIUWgwa2x1dEQvWkplK1dNQ1hh?=
 =?utf-8?B?cUxCUlY5WE9xQVNrVlNMekdQSk9ydGc0WUJhMVpNWU9rUlhDYk5HQ0Zod1pK?=
 =?utf-8?B?YTU3RWxrdUNsbnVEUXFWOXFOMzk4WFRwQXJ5V3A2emIyVEthOTZGcE5YVzBG?=
 =?utf-8?B?QmhKRnRMVk4xSnFSRDNWdzZyUXBBRm5CM1RTc0FkTEhCZVNaNjdFUXBMSG5F?=
 =?utf-8?B?cWlhakM2K0VsMzljanRJUXA2ZDdDUUZBU0lNR0Qwb0ZPRlB1aUwxMWYvcitS?=
 =?utf-8?B?dDIrdkN4REF4RjNST0lVQk8vMjU2am1qMWtJS1pXT0dlb2hlMm1zSkN2UThC?=
 =?utf-8?B?VU9yLzBBZnFmc1MyRGloZlEvQVJSN1dkczZjNW83eUhrN2FnWlc5WmlXL1Rl?=
 =?utf-8?B?dFplVkJSRjFVUkI5UHBQTXZkTFF5d3dUWXFKMTBKS2NlU0VscE9OYmlaYmpn?=
 =?utf-8?B?dnJQa0pjTUxGREdGcTVBVm5lSXpzb2I5d3BiWTdUZmQ5eEVsYVhHRHhGdUp0?=
 =?utf-8?B?TUxnRFd6cXErTmwyUDRDd2ZFd0swajcvK21uUkdXa0ZaTk43SlpvR2J5d2Ex?=
 =?utf-8?B?cjJtajZBQ1NKNklGc1g5ZklXS0VnVnNlQjU0WGFKVU14VzBnZjVKWHVUajFw?=
 =?utf-8?B?WDMvTEFrbGlOaGJCUUxtMVJMNlVTWlhtdXliNUkzd3VReUM1S0JpUEZMb3Jh?=
 =?utf-8?B?S1ZjTDlJM3ZTNm5EREdUSDRUREFNMUJMdXF6Q21uVnBpQUl1dU4ycW56WkR4?=
 =?utf-8?B?ZEl6eEpuVGhndkFmMzlEWEpBS09ZU2NUN0pCV3VXZTJ3cVovT2haNFJER0dW?=
 =?utf-8?B?TCthSk1Wck80OU9tbnVBREVuNENFSm85UThBTC85WXI0aE1nbnJObFVhLyto?=
 =?utf-8?B?UUJ4aTMxYVcvU3RFMEsxUjJ5Wm1xMEk4N3dKQk02TUJQeE1ycW9vMWw3eG11?=
 =?utf-8?B?NlU5RDY5YlY5ZExsR3ZEOVcybFJYeU9nTTBsbGVkSjJxRThCdWFzd3orZUJh?=
 =?utf-8?B?WEtCMVVSZXJoM28xd2hGT1RFZC9VTTE2K2JrMlpmc0l6QmlFMUh6QWhrY2FG?=
 =?utf-8?B?MXp5TGpPOGJva0dkQlhCZjBIZjM1VUdsd2lKa2dwSmFKZHpISCtlbFBvVUtw?=
 =?utf-8?B?VEhBTmR0Tld6VnR5ZUx4WkU5RjRRQWpvUXNjRVNKSW1xZkF1ejlXb0pPSUVt?=
 =?utf-8?Q?D1eJuPLezRtRUMH5MNYuf7Mqh?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a64569ce-ddad-4ea3-ab67-08dd20a1dc5f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 02:56:11.6402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bUfyMQ6ASkGLfsollmvrO+iA1u/uAEvy+IRp1oU7hoEQRSFX1orpLJPZ+PgctTZ7MnYZV4xvoLup6fGmDw3Prw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7005
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

From: Teo Hall <teo.hall@nxp.com>

This patch adds V2X container support on i.MX95.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Teo Hall <teo.hall@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/mach-imx/image-container.c | 63 +++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-imx/image-container.c b/arch/arm/mach-imx/image-container.c
index 2afe9d38a0681862098a6566a873873f24069b88..54ae7721888dbc93fdaba8e5aedc52c4506bb1c1 100644
--- a/arch/arm/mach-imx/image-container.c
+++ b/arch/arm/mach-imx/image-container.c
@@ -231,45 +231,62 @@ static unsigned long get_boot_device_offset(void *dev, int dev_type)
 	return offset;
 }
 
-static int get_imageset_end(void *dev, int dev_type)
+static ulong get_imageset_end(void *dev, int dev_type)
 {
-	unsigned long offset1 = 0, offset2 = 0;
-	int value_container[2];
+	unsigned long offset[3] = {};
+	int value_container[3] = {};
 	u16 hdr_length;
 
-	offset1 = get_boot_device_offset(dev, dev_type);
-	offset2 = CONTAINER_HDR_ALIGNMENT + offset1;
+	offset[0] = get_boot_device_offset(dev, dev_type);
 
-	value_container[0] = get_dev_container_size(dev, dev_type, offset1, &hdr_length);
+	value_container[0] = get_dev_container_size(dev, dev_type, offset[0], &hdr_length);
 	if (value_container[0] < 0) {
 		printf("Parse seco container failed %d\n", value_container[0]);
-		return value_container[0];
+		return 0;
 	}
 
 	debug("seco container size 0x%x\n", value_container[0]);
 
-	value_container[1] = get_dev_container_size(dev, dev_type, offset2, &hdr_length);
-	if (value_container[1] < 0) {
-		debug("Parse scu container failed %d, only seco container\n",
-		      value_container[1]);
-		/* return seco container total size */
-		return value_container[0] + offset1;
+	if (is_imx95()) {
+		offset[1] = ALIGN(hdr_length, CONTAINER_HDR_ALIGNMENT) + offset[0];
+
+		value_container[1] = get_dev_container_size(dev, dev_type, offset[1], &hdr_length);
+		if (value_container[1] < 0) {
+			printf("Parse v2x container failed %d\n", value_container[1]);
+			return value_container[0] + offset[0]; /* return seco container total size */
+		}
+
+		debug("v2x container size 0x%x\n", value_container[1]);
+
+		offset[2] = ALIGN(hdr_length, CONTAINER_HDR_ALIGNMENT) + offset[1];
+	} else {
+		/* Skip offset[1] */
+		offset[2] = ALIGN(hdr_length, CONTAINER_HDR_ALIGNMENT) + offset[0];
 	}
 
-	debug("scu container size 0x%x\n", value_container[1]);
+	value_container[2] = get_dev_container_size(dev, dev_type, offset[2], &hdr_length);
+	if (value_container[2] < 0) {
+		debug("Parse scu container image failed %d, only seco container\n", value_container[2]);
+		if (is_imx95())
+			return value_container[1] + offset[1]; /* return seco + v2x container total size */
+		else
+			return value_container[0] + offset[0]; /* return seco container total size */
+	}
 
-	return value_container[1] + offset2;
+	debug("scu container size 0x%x\n", value_container[2]);
+
+	return value_container[2] + offset[2];
 }
 
 #ifdef CONFIG_SPL_SPI_LOAD
 unsigned int spl_spi_get_uboot_offs(struct spi_flash *flash)
 {
-	int end;
+	ulong end;
 
 	end = get_imageset_end(flash, QSPI_DEV);
 	end = ROUND(end, SZ_1K);
 
-	printf("Load image from QSPI 0x%x\n", end);
+	printf("Load image from QSPI 0x%lx\n", end);
 
 	return end;
 }
@@ -279,12 +296,12 @@ unsigned int spl_spi_get_uboot_offs(struct spi_flash *flash)
 unsigned long arch_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
 						unsigned long raw_sect)
 {
-	int end;
+	ulong end;
 
 	end = get_imageset_end(mmc, MMC_DEV);
 	end = ROUND(end, SZ_1K);
 
-	printf("Load image from MMC/SD 0x%x\n", end);
+	printf("Load image from MMC/SD 0x%lx\n", end);
 
 	return end / mmc->read_bl_len;
 }
@@ -312,12 +329,12 @@ int spl_mmc_emmc_boot_partition(struct mmc *mmc)
 #ifdef CONFIG_SPL_NAND_SUPPORT
 uint32_t spl_nand_get_uboot_raw_page(void)
 {
-	int end;
+	ulong end;
 
 	end = get_imageset_end((void *)NULL, NAND_DEV);
 	end = ROUND(end, SZ_16K);
 
-	printf("Load image from NAND 0x%x\n", end);
+	printf("Load image from NAND 0x%lx\n", end);
 
 	return end;
 }
@@ -326,7 +343,7 @@ uint32_t spl_nand_get_uboot_raw_page(void)
 #ifdef CONFIG_SPL_NOR_SUPPORT
 unsigned long spl_nor_get_uboot_base(void)
 {
-	int end;
+	ulong end;
 
 	/* Calculate the image set end,
 	 * if it is less than CFG_SYS_UBOOT_BASE(0x8281000),
@@ -339,7 +356,7 @@ unsigned long spl_nor_get_uboot_base(void)
 	else
 		end = ROUND(end, SZ_1K);
 
-	printf("Load image from NOR 0x%x\n", end);
+	printf("Load image from NOR 0x%lx\n", end);
 
 	return end;
 }

-- 
2.34.1

