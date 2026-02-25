Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC86FF55434
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 00:14:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F3DB83E36;
	Wed, 25 Feb 2026 01:14:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OtEBg0mA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68B8983C39; Wed, 25 Feb 2026 01:14:24 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E1E083DCB
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 01:14:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SW6Iq8IzVieMixBOEmYuEGcsO/W2Mtqdwi1bx7eIo5uDPQrO0M6hAVpUWeaoDHW3IyHc+wh8BUNW5Co8VLpWcyXMgsrMGT1bkrRvBEpSRB/XBvqVzKseh6cC0obSRJoDcLtS+1QhtRgYq+WPG6oBUps6gDdw5QrsXYmRZqqTHmCUT8bD+LNg8BYVcx1UF10tr5PSklBiiCihjZb9h4WiUJ67wbqx4xkpGD1Te+nKQP8rpqHHZL8QQTJiTQfJR2m/llJXLW5nU04r0VUZ0uNMx+rrnTGVYTVD5K84gPkXI8D+LTK0+vOdO+pzt9noP85Dp4w6LkV523QBSLJOaV2/gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4Ao4Es6VEhg5+f51WWrn5AIcB8Y/uuRMD+MwCMJ2EI=;
 b=LCjmlP9O1/EqKRT+2Jm1YVBmdHGzBdtcBs4DMhB5NzY6sijbCad1PB6oRXNm9Ov2hT1JRJHIbQaKyYHMhDY3znoEW/zAftvG8W09ICgqVhtBVEWJQrt7OY5nTHTjfeEvLVspQf4o7y4W7J9WaDVRszdvxjf7CRuF1Wc7e2JjsMHWUgoenjkg+cKElQDBPWPXuw3/dY50svgnsLzz5CjyaJmwSIyL4MivQ4ZsX0MgjYQDKRWAsxDbjYRv/bZXXPMf5GAOcfbwgsFc3Q+CXi+Bhq4y2UkwZA5cKc3X/OZeIjPk37BaO4oGx96HZSiZBdpqzOj4v7q/R9fDJaG5WLd/+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4Ao4Es6VEhg5+f51WWrn5AIcB8Y/uuRMD+MwCMJ2EI=;
 b=OtEBg0mAPuEDRcCoxOj40jut+GYICkpgl1aH/SH270P3e5GSiuqbABrLSHRQEKpahGnvuWoUCIRo4bqbU5dA4mp6JzdBr2DKiftU8wY8pDE2ofvnrqB72IU1bq+q+BgxVnhDn9nzwB/OUrw7S9Bd+h7/0wfGu6TjavL/MUFLOQjL23A4f9mco9rrpIhaa7RS7rvejeB4O6C6m8EdGUuC8VunupU/wKtMMZVt/nxX01HDONfct7oHpd7zOgP8Z6SXTxZSaCqmOihO++PmJtuvfx4gVjQCHdrgBJqR/NO2RhkMGYGh+hxz6dRpzyT+WkU6lde9tE95jfaZlKtmY10Omw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VE1PR04MB7342.eurprd04.prod.outlook.com (2603:10a6:800:1a0::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Wed, 25 Feb
 2026 00:14:20 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 00:14:20 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 25 Feb 2026 09:29:27 +0800
Subject: [PATCH 01/10] pinctrl: nxp: Kconfig: Typo fix
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-imx-pinctrl-v1-1-7a149ab8feba@nxp.com>
References: <20260225-imx-pinctrl-v1-0-7a149ab8feba@nxp.com>
In-Reply-To: <20260225-imx-pinctrl-v1-0-7a149ab8feba@nxp.com>
To: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:195::22) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VE1PR04MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f56f0ca-11c1-4b28-998c-08de7402d298
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|19092799006|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGxyRURsQzFETFhKREN5VHVRcEc3Q0lKYytyR1drL2FlNm45OVZiVWUzWm5k?=
 =?utf-8?B?UUdqa0RxU3ZMeVJ5V1RUZGR5VTQ5NzVVbVk1cFZJeFZNdU9hWW03VHQ3NGo3?=
 =?utf-8?B?eUVhMXJWNy9yT0V5VXVGWUMweGtGV01MRVhRVmpPNkZ1LzJLVGROSUFiOGFj?=
 =?utf-8?B?aWpsdW1uOUVvbzRERlpRdWFLdWVMRVROZVV0SFIvck4zMWFtTVJ0NVJ5ZEp4?=
 =?utf-8?B?Rlp1LzJMQUpPZmJLU3NhaWFMU2t1eEp6Z0JlS3gySVlvOEs3YmdMOVlsMnJP?=
 =?utf-8?B?YWhpSjBnNVFPbitiQzhTdkV3WUl6dVErbnBIUHdEVGNLWnZDQ2FaSFlPWCtm?=
 =?utf-8?B?cVdEbUdWMjB1SmswRFRCREd2SjRmaDkwSkJ1M1lWcDFTSTAyZWxCMlNlRVNF?=
 =?utf-8?B?Nk11clIrWnFocHpmUzRtZndsaTVwdkg4dVRYblBPVVNhMDZoWVpqc3ppWjFJ?=
 =?utf-8?B?dGl5VG9uREM5dWtITjlWMnFvTEtRYS9udFZkQnVnUENUN3ZCbjRNK3RkSUFY?=
 =?utf-8?B?U2pvSFA2VWlTTTJyNFdXL1B3NXZiOWQ0NGFndkZOdENqeExLeDBKcmYzcENF?=
 =?utf-8?B?b0l0dDBIcDdGNXRsYitsQ1Z6VTJqVWVQWTVIWjAvV3hCZGM3TzFuQmNSOVgy?=
 =?utf-8?B?eGs1TXR1U1NlSFpnVjZxTjE3MWZHTkRHTFFPdnFZU3FvNjkzNzNTZnFaNnVI?=
 =?utf-8?B?dHFTMXZxekhXS0FrUEp4Nklza3BpT29YOTVzNExhWU0yZTh6SkgzWjNSekM0?=
 =?utf-8?B?SVoxc29YUFE1UnY4SUplUjcxV1VsaVRLQzBWWEM2a2lMaTl4ekZ5TkRhMHJW?=
 =?utf-8?B?L3hTV0IrUTVFbFczVUJhQnhiSHlQVHlCdXBBb2NkRldaK2J5dHVrNmdiTVJq?=
 =?utf-8?B?WWRramZRTU9Ha3lTVWQyZFprbmE2RGNsczlzYzQ4MG1RTGt3Q0VuVFhXbHRi?=
 =?utf-8?B?SDBtKytFRlFhSTVYSjZxaEY4elBSSmFkYjJ0WFNtQVIzVjZDWUtBNjlzZUdx?=
 =?utf-8?B?OS9YVEJLcExGYlN5YkZJMTNlaG5SVzgySTFkUW9xQTdBNGVSVXR0YSsxQ0xI?=
 =?utf-8?B?S3JXTTNFY2JuMW1BVnA0QWlkbnd6ZmIzb1RLcGR3QmdlMWppc3BCYSt0a1ph?=
 =?utf-8?B?aUhrRSs2ZHZqTWJnQnJGN3dJRE1aVlFFdVZjenFlOExBVlBkejZrOUVCcDlh?=
 =?utf-8?B?dmtIbkxvNGJQS0pLK1FlUkhkaElPeHg2bFdLRTU5K0JOSHdzUzJTK0FabUdV?=
 =?utf-8?B?SU5IVjIrU0hFU0tiS3VJbUZPVThjS1NrMUZ0dk9FMThaaEpnTWJ1ZW95ODJN?=
 =?utf-8?B?NmxsYW05bENicHpmRlFWVUhVNTNNSXdvRkUraVJ2dEI5QVBJLzFjOGpha0t6?=
 =?utf-8?B?R0x4Yi9WOEt3UEY0SWhGZGludElNa05KcmI3bW5qTU95N1lGL3pwb3VvUDVV?=
 =?utf-8?B?L1RYU25TWUpOak0welI1K2dXQ210NFNMMXNISElPQnd1d0NuV1hPWm1BUnpo?=
 =?utf-8?B?QksxMjkxNnpZK2U5SFY2U3Zxd2VaemtmVE4xMUNIdjcxVGJQY0s1YzhTc1NQ?=
 =?utf-8?B?RkN4aVVSSk9CSjlIOXQzR3hySVlkYmdlZHN4bVhDci9Tc0lsUnFMMWVYNTFN?=
 =?utf-8?B?cmdlMTVRTUhzQktocFhuSHRiUENPT0lPMVo3eWZOTzhIUlBDOGNrbnd0SmhR?=
 =?utf-8?B?VDRmZDNnVFhFQmlmRDhGdVplQ1RTajZlWVpVT2FXRTdmbTR6VXo3VnZ5bDRK?=
 =?utf-8?B?YnhLcERYcXlTaWVySU5qNzRjNS9PbDdIYzE3R2FUUUViUjR0TVhyNlBqNkRU?=
 =?utf-8?B?dmlYZEdJYW5vL0w0MFE4SDBkY0NDVi9kRUtkK2sxOWVDeVhlWWtXUFZkVCs4?=
 =?utf-8?B?dHIwZkU2bjBiLzF6RkpMdHV3NkYwZ1FLRzVrNUF4clIyUjYzSW9ZL1FDNkdH?=
 =?utf-8?B?THExVzhpVjFad3MwQS9TNEk3OWlzdGhiUkpkU1FWc016STdlNFZPdmsxNWhy?=
 =?utf-8?B?bkF0TkJqSTR1N3J5QW1odEl6dXhTc1RJdmRtRWo5TnczemhVN0dwV3VMUE1X?=
 =?utf-8?B?SUJHU2p1YTBnNnIwMzBmb3Q3dEVwcnNiVzF4c0FXSVZCNEVkWTM2bVFRYU9Z?=
 =?utf-8?B?RXFxSm1KclRXeUhKWkZFWWl5VHUzeU1vMHo4dWNNampNMnlZbVlrOWNGOEtx?=
 =?utf-8?Q?jN4utSBHAcLjjlCHfnpExJ8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(19092799006)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTNycTh6cElCWWp2ZTVxbjErZE9ab08wbVJHbkJpNHptK0RtWHYyRndWQ1E2?=
 =?utf-8?B?ZXArY0J6REF1MTh2YVBBaCtWNi9JajlKUWdLYnoxRytFN1hjalcyM3d4WHlH?=
 =?utf-8?B?dVNxdTNYNHFGWVl3TlZleVUweHJsRmVOb2lwdnB5MEduamZOcGNmQjJCUzRU?=
 =?utf-8?B?SHZxY21IeStqZ0greW9IcWxWeE5CWkEwd3VrbmZoWEJQeHloaGtjT2Y5alNm?=
 =?utf-8?B?bjBXSHFCUlA1ZzdLOTE4TllwQ2VnMU1QK1I1TzA1cS8yc0txWHlnV3lGT1hz?=
 =?utf-8?B?eFNGMXNZY3FCUzBtZUtNSDhwOFdReUF0WlJ3Q1JTQk8wRkVIT2kzZnBWTWVy?=
 =?utf-8?B?L2kvSjYra2JlQWtPaUdybVlEeTlaVjlRaUN4SWc1K3NZdHZIemIvb3ZvUEFF?=
 =?utf-8?B?NFd1Nk5QOW0wOVduTWU1L0U3N3doeUZFRktFQ0U0Q01zVUU0L1F6RTJURGRY?=
 =?utf-8?B?aUlnM2NWdWNpNGp2aWZqV3RXbE1ScUdMOER3TDVMVDBTRmdLOUQ2MUlOdGg1?=
 =?utf-8?B?c0NyZjVqekpySXZ2NlBNMTF0MVFyL2RPUm1FR0VTSTFKcWlaUjN6QVQxbVp4?=
 =?utf-8?B?MjRjY25NdHY3VVRkMlRKUTBqL1EvUERUTzYvOHBGYlI3TTJ0L0lFaWxrWkhZ?=
 =?utf-8?B?VVZMdVN4QVJGU1czdWUwdWdQQWFTM3RNV1gzNjdSWmpWcFc2a2FCdllYOEdi?=
 =?utf-8?B?OU45NHJZaS9VV3hXaW1HWHFmT3llVVFpWVljYVo0VE1IYWYwb2NnaFhoeGov?=
 =?utf-8?B?OEl1UDVBanZrSlpISGEyZ2NWblJKUGxXbmFkN1AweXdhMmVsczlpMW1KZHpG?=
 =?utf-8?B?STRKT29XSWdhNmE5T1B6Y0dzRjJNcUVXcThNVTUyNnZaNUgydTBtWTNLWU40?=
 =?utf-8?B?Ti8xbXhCc081T3BSeUFSZnAvUTNIcERwUkdKV2JLYmMwVmFWZDVQaUxKYW9H?=
 =?utf-8?B?LzBDRWFqMkhoYTY4dkU5SzdXajF5NThlMXVMb2RKenFnTlcxN1Q2MlgzT2ZX?=
 =?utf-8?B?NEFUelhsaSs0Mjk2aFFCcVhvVFB1ajVacDB6WGcyWEZjUExyaTJQR09kd0g0?=
 =?utf-8?B?Y05sOHUrZjVPY3lKdC92aVhpeTJycUFCekg4bHhCS2dpdW9TL0JCcXpZMmQ2?=
 =?utf-8?B?b2Q4OGM5U3NLWW0yN2hZQkdrN01QdldYN08zQ3FPaVZ6ZklSQTg2K3JQZ0ps?=
 =?utf-8?B?Tk1UV3ljUjZXdkZHUWRubFE5dXU5QjV4b0pKVzlpN21ka05QQVNlM3Y2ajlh?=
 =?utf-8?B?TE01RXhsRTJQVE92QlBSTnZlalNEUzVjbVZadjZBZkFQelZQSEJiUWpkNW9q?=
 =?utf-8?B?Z2twd25vZ0diQXIram15OE9OSlRWQytKL3FWOGtoREJvZUQ1RnJleHNKK0s5?=
 =?utf-8?B?WXNvUWEzY0tldUdhS3lpRW9MZm9DbnRwbXR2MFhuOXFzSkNNRmNTbGtHZ1Fu?=
 =?utf-8?B?bzNUeEpPZ0xRaWUxVjJvYzVNMFQzUnFtWjhGaFdtQnN0SWMwcTV4VnRKWUxt?=
 =?utf-8?B?S0JDM2xTcXdjTDNiTDFMMGRtQmIxODVxbERZcjBMVjNFTVJZQzJwSVVZalg5?=
 =?utf-8?B?bWJJTHBtYjFDdFo0b3ZlSWgralV3S3MyN0pBWU1GTEgwOHhqRkwrN1lvYzBI?=
 =?utf-8?B?dG5PUFpPY2R5WC9LNWs4emxpMWxlVlZQblhLZ3NSeDJzdjFkaGFKN3F5b3dh?=
 =?utf-8?B?Q1lNVHcrbUhnZzNPaXFLL1lOVUlNYkQ3TURYTzBMZ2ZBRzlBbFlDNzBqME1s?=
 =?utf-8?B?NFZLdTRrZllLQVRPNXFWTXFCTlFadTU2MU9tTEJDUlJzY215dHdFVVhER1Nz?=
 =?utf-8?B?eFRMMTU2d05oM0lkL2hqQUhET01VL0ZkT2N0V3ZUdnY3eUVvSEMrR0FJSVhQ?=
 =?utf-8?B?ZzhaRXArNEVSc0x6UFV3U1BUc2RZdXdCRjE3ZjJIMlg3OVZsMHNRaFYxOEhM?=
 =?utf-8?B?blhoS1dTaElpSVVXQXBaRmw0T2hibmt6cE1id1gvSFVBSVY1RVJjNW4yc296?=
 =?utf-8?B?cUtpSXZ5T2tYWFBsMDNBS01kSlJjR0xFS25xTG81cmNiMDMxamZ1WHlLYUV2?=
 =?utf-8?B?TmJ6bkd5Q3duQ1E0cnhxTE1qV0JDNHQ1UEw3K2g5blhOTGVLdnVzUitpa1ZI?=
 =?utf-8?B?Sm1mT2dlMDZ6UHpBWTlPM3JWdVFCQnlqSXd6NzBpNXpyOUFmZEo3bENURHMy?=
 =?utf-8?B?WGZYOWxybHVPdktCWEYycXRRUUlWTm9RbFYxeGsraTA1aGx4dVJGOCtYeXh1?=
 =?utf-8?B?VCtwR1hBRHFZZ0lKUzB6RXpnSG0ra3NVUmtjMG1MWTNlWUppUkJpek9zaGR6?=
 =?utf-8?B?MnRaS0JuT0plUFBBdnZxYzlDUm9Yb254ODBjZ1JEWlY1bHpBb2FZQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f56f0ca-11c1-4b28-998c-08de7402d298
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 00:14:20.6392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wUHzxTz7sPaBSQ1neyRECDrdIRyyleByRw7SBNTeN6xrGFp+aMinoHmq4VJdF3Wz3B/y0T9UeNnnEoD5lifhcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7342
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

PINCTRL_IMX93 is for i.MX9[3,1], not for i.MX8M, correct the typo.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/nxp/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/nxp/Kconfig b/drivers/pinctrl/nxp/Kconfig
index 84d9a3641ff..b2a19557a27 100644
--- a/drivers/pinctrl/nxp/Kconfig
+++ b/drivers/pinctrl/nxp/Kconfig
@@ -103,13 +103,13 @@ config PINCTRL_IMX8M
 	  registers.
 
 config PINCTRL_IMX93
-	bool "IMX8M pinctrl driver"
+	bool "IMX93/1 pinctrl driver"
 	depends on ARCH_IMX9 && PINCTRL_FULL
 	select PINCTRL_IMX_MMIO
 	help
-	  Say Y here to enable the imx8m pinctrl driver
+	  Say Y here to enable the imx9[3,1] pinctrl driver
 
-	  This provides a simple pinctrl driver for i.MX8M SoC familiy.
+	  This provides a simple pinctrl driver for i.MX9[3,1] SoC.
 	  This feature depends on device tree configuration. This driver
 	  is different from the linux one, this is a simple implementation,
 	  only parses the 'fsl,pins' property and configure related

-- 
2.51.0

