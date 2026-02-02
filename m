Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4557FD172B3
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 01:43:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C10B283C61;
	Mon,  2 Feb 2026 02:43:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="twpjp+9d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43EC783C2B; Mon,  2 Feb 2026 02:43:04 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC60983BC9
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 02:43:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sH/G3Za9u2V3hlo1lP9vLk+NtX4bEHcRaubp1qS5wdeH21pray0RKXH5xcmEH476OX0zkZ9Km05/hRPObSCQ+SIcj9bCM4q0XkmHS462/hj1FAGtWxn1C9b+CQpxcMHBwQcMO7pMhpK9+6dY9i0Nubw8BJ+UkZeIH125dwR8oqsqO5KOOXvNolLn98Tk2ctcGUYui3EFpjtRfYJxfc4sIN65osJzwvMF3GW7hC1/9sf/TlajbbgLgSuJtWnB2k9R6B6Fa5QRCyLjuA8L0a6kIxcWiFNZ87U+gflLjIoYyQUki7N7yNkeSr+HcgEx61lokLEgbyNtCt8lmluvzL8oTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O00JWSbiWRtDIPYXkjWD/fuWPvHjifPxit5E/p4XTGE=;
 b=CtK8hq0r1nQKl4m8g82f6IaBE+HB4ClUCVQTyCTq0GDkkDCLM4Km+LIHKC+tpskiVXeWHepavpE3QKAbVJQnEwS77AQqFudTJ3XyXau4qdhejSQROg5x1Roar2UH1/LZ7Uy68PG+X13WjkFWqqCAM7CNVHaT9oNkyEEFXfZLfcqaC9XooHeN6uKAWswBCvG4sMYv2bWjdz4+p5zMA5L1XVPwfVYn/4ziqP5ruuHveFLNe0C+BsJTR3X96e+osA5TNKnOhr/VlEg9qy4cYEDARt3/namBFS1PNL8WiSQ80RVdMmaehZ8YFTjZoNjhddeas4G0j9EcYf5qkvIUxAj4jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O00JWSbiWRtDIPYXkjWD/fuWPvHjifPxit5E/p4XTGE=;
 b=twpjp+9dGdHZ7c5nShxKZTRdjEs5YdD9Y4hlinyuA+/2OLjdq0+zIMJ65xM785pLMqyRTGq1gvX4E7mTgr4FaiBd1q3SJtMzriSVt7iK19d2gcbl4a6TvrhM7EhHKKmIx6RiptdRNt+o8RB/V/Z1Y+O1R8VoPv+n6+Mrp4vpyBxb8OUmXMwb7fut41jJ3xx5RwINtDsF0X54cQCPw3/He7JJim1eQqmq/N6RMTrE7rABgwwoy/qmGuhMry7H9Kp43Yix5aJzjVc0w9QWAaJfey5tjABDGAMsS/+g4/KmoEYGf3Cik1FajcJ4CLwCDRtEiykM3z5HXbv4/lW4+HRROg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB11483.eurprd04.prod.outlook.com (2603:10a6:800:2cb::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 01:42:58 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Mon, 2 Feb 2026
 01:42:58 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 02 Feb 2026 10:57:44 +0800
Subject: [PATCH v2 1/4] remoteproc: imx: Support ECC initialization
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260202-imx95-rproc-v2-1-b85fc7db23fc@nxp.com>
References: <20260202-imx95-rproc-v2-0-b85fc7db23fc@nxp.com>
In-Reply-To: <20260202-imx95-rproc-v2-0-b85fc7db23fc@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SGBP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::19)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB11483:EE_
X-MS-Office365-Filtering-Correlation-Id: bee4f4e2-e0c4-4745-2071-08de61fc64c0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dC9GRWZSdkVDRm5RdmJhcTNDUTA4Wnh6eUJzcC9mdzkwdzEwMEJUeG5ibHov?=
 =?utf-8?B?c3lnM29HOGd0N0F0ZjZqTTdMRk9CU3drYktLa2RCRlVBczVpUDBYUU9BM0hs?=
 =?utf-8?B?S0trRzZ0V3REQWFsc1ZWTndpQjltMmNZOUFtQVFNRVV4WmRuZHZsSy9LcVlE?=
 =?utf-8?B?M0FJSTQ2d0RDenBpNFJSK3JkNHJOOUI0NVBqckEwd0Q1bVZkT2RVc1Z2akxh?=
 =?utf-8?B?eDUwMnZjUkVONlZZcDhCejZ0WGQ4OXZBNDc2MTNYUUZ6bHZxWEJEdmF1eTg1?=
 =?utf-8?B?Y0NhSk5HSnBJdUYvQTRuNFduYkNrVlZjNU9VWmJvTHBDR0pvN2E0UHR6ZmE5?=
 =?utf-8?B?TUl2WTExZUIyQ0dUVGNuNkRRdVU5YVNvZDFmMnZIaldiYTVCcHNLVDRIQjYv?=
 =?utf-8?B?UElnQStLdlA3ektidWVXVFNrcFNOL2UwVnlCUjZjT2Y4YnYwNXBGSVVTbFkw?=
 =?utf-8?B?a1hscE0yeGlvYnU3S3RZTzZ5WGJZRU13ck9aL1FRRWsxUEhLZzVLakQ0Vzd3?=
 =?utf-8?B?MVp2eXZ4REY1Uk5uejR6QVAvK0wrdytNZVdGU3hldlJGeU5FQk92RzRSeHk5?=
 =?utf-8?B?TDcxSmlIYkRTUFJoRmNLTS82WU93TDNadGpkNExOZ2cwSS9HRXhzbU8yZTMz?=
 =?utf-8?B?b1pDejNIdkQ3cmhnM2JsVkxZdGdGa0dacmlObnduU3Z3MXdaZ2JyQ2U0WXBD?=
 =?utf-8?B?T0pFM0FGQTlNVERVTitiTUQ4am82a0diWVBaTGxWQjhMUVdDZm9sRGJVczhy?=
 =?utf-8?B?a2JROFM1ZCs3REZXM294dmdjZ2hpWXFpS0VpOUNUa0t4cU5QcURJbUsycTRG?=
 =?utf-8?B?T2lkNU5JeHlDUThFTkVOTWhtSkwrZEVHSE9LaUh0eUJFNkNPMHdLWUpHKzYx?=
 =?utf-8?B?VnBCRkF0azFhK1gxYWJ4Zm54STVuays0bmsyem1jMm5ONjV0aWtlU0piRjE0?=
 =?utf-8?B?akU2TytzYVI2UUFZdjArMkhmR1dMNWZBWkRDbVNUMGlYNUYybWhCL0pxYVdO?=
 =?utf-8?B?enpqdlFaWnBJeitkWjdPemcvdW5ocWdwZkdxb0xjZkJra2YwSXU5MndTNTZo?=
 =?utf-8?B?M3hkSzlTaEJyTlhLQ3NsRjVDUmZkRk1zdU5vZnlST2FrdGtWendITWIwUGYx?=
 =?utf-8?B?VGtwV0Y5bnlJOWVuK05OQnJjOVl6VnJtd3lnTHNzVi90MHQ4ZGEvNlFKNDBl?=
 =?utf-8?B?ckVQcEFybmFtejg4L1BVcTNIRkJYcklmRStuNzQ3bEp1L0tvL21Vb3lhdEFl?=
 =?utf-8?B?R21mMlAwMElhNzNjN1lhbTRNeFRaL0k1bEVYTTNJSWZoYXlMY2pta1U0L29I?=
 =?utf-8?B?NzNVd004NXdjQzd5cTFmRjBsbjNmenB1VElVSnhDSkNOb2NobFRSZ2ZFUlJ4?=
 =?utf-8?B?ZThBdFYrekV5TjdSVzJyM2hIMENJaHlBbDgycWcvOWxhaFl2ZnBpays5N1Uz?=
 =?utf-8?B?aEFlWkVqRHFlbGU2QU9uME5rZkVxa3BrbHYxOXVQZzZIN1B6b1V6UHVnQWsy?=
 =?utf-8?B?TFQzOFBWUkdndGszd1p0N0w3N1RaRC92ZkVoUTh5NW1PWDJsMTNEK0EveW9T?=
 =?utf-8?B?ckVnemUwazVJNkZTbHo5d2RUVVZzNHk5cm5EcnRYbzZVZHlMbWk3UzJSTVd4?=
 =?utf-8?B?cXJ6cVdoV1ZxVFpVdy9QdXZmTzZSOEtLYXc2ZWdjQ3QraVlldUNDZDM3Mjlo?=
 =?utf-8?B?aWQ4aGVhR0pZaU8yd1JGdjJRTnRrSE1ZR3cwNkwyNmVqeHdMSHhLTllsOGZ6?=
 =?utf-8?B?Y0ZmWUQwa3ppRWlpZFJDNWJlR0pHUXhmNmVmdEwzRTFoeWdnOXBBRU5SMXRL?=
 =?utf-8?B?WHpSbW9ZWTlrcGVoNEI4NXd0SUFFYlAyc2dmT0pzcGZoRjVOd3pkSWpiMXVy?=
 =?utf-8?B?RHhhUDBjWWhTZUVwUGt0SGFlbng0N0x4N0FKS01QVzA5N1RVVXAvRHVWV09B?=
 =?utf-8?B?eXk2THJacGhVUk1rRm4xdjhUUVN2VFpVU0tEL1JXMGI5TWh4ditjakI3alJl?=
 =?utf-8?B?eXVHSjExUDN4SGEvaGlnQWtycnRrYTlXNGN4MVZYQlJZZUFyZHI0YWJoVEZs?=
 =?utf-8?B?QkIvTzR3dnlzYk1kbDFMVnZiRWtxaHpBYUgvTlNHUDBUR1BLeTBrR0pGL1NW?=
 =?utf-8?B?ZWFXSk0zenpJc0R4cE4wcVdUN2o0RElsRnFWL2tzK1VEU2trdjcyai9VbzlT?=
 =?utf-8?Q?oVxkfdYTIrBPS9OmqMws/yE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmRJN2RVU0puU1hvSGo2TnRzWUQ0QjFHOTFlYTB2STlkVWw3QmdGMk5sSmRp?=
 =?utf-8?B?eFpKMkxwUFRWVER6bFljV1FVYVJjMGhaRWNlT0k0b0VlTjhmVitSaW5WV01r?=
 =?utf-8?B?aG5jODR4TlZoSVpJcjlFbEpxbDcxbVo1cE9pbm9jOGpWeEpibzU3U0RRdTh3?=
 =?utf-8?B?RkVPbEJodjIreTJWTU5CSTlHc2l1ckdpVlpmbk1ZNU5SVWd6ZWEzZlVTYmtu?=
 =?utf-8?B?VTFsZjJ3UVozUEpSODlNRCtZRXBEVXhXMlRrYTdES3ZMT0NkNUZ4UWdOTzBM?=
 =?utf-8?B?eWNyUmU5Y1k5c0FEb3ZJZzZtYmFKU3JTQ2FnRW9Yc0UxcmJRbU9BZERkU3Vq?=
 =?utf-8?B?SXFCME02SXUxWFY4c2JMYmthL3N2Y1RCdVZJbkVBOEFyb01WK1hhTWxJRFdD?=
 =?utf-8?B?djVQR08zUWxId0Q3U1lMSDhVaFpaZTZQbk1sT21KdVVnTTAyOTl3ZFo0M0xP?=
 =?utf-8?B?R1NrZ1VMaDEyNjl1dUNrYy9tRUtKa29jTmE4NHpzQ3IxNU96SUNvVGJ6ZFpr?=
 =?utf-8?B?MnBtbmVFZk5TWStiWEwrelhPdzc2L1NzRG8ydnAvYU1PK0dwZ0RVZ0ZNMzh2?=
 =?utf-8?B?a3RGQjFweGpONzZUS1lYVVUxUzNSUWJhV1l6dERrRkpCQnpONzU5NlNpa0ZZ?=
 =?utf-8?B?Qzk1WlR2TnpSY25YRDNaTE83N0hJV295NzlRcktLTnpOelp3WHFVRWNnVy9C?=
 =?utf-8?B?d2tqYVVZYnh3dHNDSzIyeWtQalBocGVtK1RUNmM1SnRGTlNXZHBRa1E3TURP?=
 =?utf-8?B?cWlJMUduUUp4U0Q2dEFsWlc0cStGODB1U1FMVFM5aE1jMVhHUFdtNlh0a1BX?=
 =?utf-8?B?WWE5UVFrZDRxTkFRU1J3ZDEyRUpZbmE1c0RjL095bjFiYUdCNXZ1amp6TWNX?=
 =?utf-8?B?ZzFXSStDcWpGb2drbzE0WEZkdTJZWkFPazZnVWdUSGdkdG5oTk5WSHVUUUNJ?=
 =?utf-8?B?SXFSYU1pNjFnbkRHLzE5M2VYSGpscmZORUQ0RFR6YThqOFd1OXluL3V6TGhT?=
 =?utf-8?B?a25UcnZPSnR3eTBUeW9PbkkwM01XSlJGWDVkMDVrUUxxMlFGcUJFUmxkUVla?=
 =?utf-8?B?aENhaHh2OWRqWVoxOVQrS2JRU0prSFdWT29RUlkrTmtUZEp0c3VDdUZmSXpE?=
 =?utf-8?B?Y3ZEVGdabnJnK3k3ZzdEUnpEQm1vM2lGalRFVFV6Q1U4RnR4OVVoNDdEZHkv?=
 =?utf-8?B?M0Q1RFhXb3czWnhka0diSVFqSlJCNVRtTFBvNlFhdUhIOVA5U3dPQi9nLzFB?=
 =?utf-8?B?SEJsdTVMeC9oQUM4cmtZclhBSlFpSkJJNWFabVM5SmZGV043aUg1dHc5cVhm?=
 =?utf-8?B?dEFFdGZ6dHVVcnRnMXlYUEZiMnBIMmc5UWdvQkcwUmc5Q0FzT1RmS0x3OTBI?=
 =?utf-8?B?TWloQk02RTk1bzE2bDhGenJOamh6ZXJPTldtNjNsWFFSN3dEQnUvLzgyMDdT?=
 =?utf-8?B?R0s0dFhtVmtpL1NsT0psNjJlSlhTU09ZVm00WU95NXFXc0dzTzVTRzEvQTJQ?=
 =?utf-8?B?ejluOTZKVm0zTVUrd2tNWWE1S2pzTjVCNnRWMUs5UWd4TFNGTHhIR1VneFBF?=
 =?utf-8?B?Rnd6VDRENDA1RDdld3Y3OFR0YXJOZUU3eVFlUy82dEIzTkMzN3J1VFpnUlVU?=
 =?utf-8?B?MGFPemdPa1FaQklPS3VkWktEZm5FMlJGVWZUOU9LSzFNQlpVR3pZZ095cFlH?=
 =?utf-8?B?bjhjWUdGWnEwb3ZxWEZzQTVCdFJCY0dSRjZhV0dwd09zK0wwOGNIYzZkWE1W?=
 =?utf-8?B?cGdqbzZzNTU1UVJ3QVVJcm5TcWhpTVVMckpHSkxhMWpWV0FTYXFSSWNDN3hs?=
 =?utf-8?B?T0lrN3FGOGRSNWRqOGNLK3JIMTEwL1R1TndpSlJqR3RXSTVaU2VYaW12cEx6?=
 =?utf-8?B?NXZsKzZyYmRNbHhFWCs2Rmhuc2FhcDVDR0VmNmozVWhyejhad25tMk8zdTlM?=
 =?utf-8?B?RFZuSDZOSzIrcU1YSUFtakNlbzhyL2V1c3NOK01SUlpHMVUrTmhsb3hsc0kr?=
 =?utf-8?B?cjhFQ3BPZlE5b3FDbUUrUjh6TjdZTXVqdFRvY2w1cEkwWmVTcXBBcFRSUHl0?=
 =?utf-8?B?Q2kwZ1F1THo3YVc1cXo5L0ZsT2tleWdqNHhJd1psM3lhS2tUMHdMcGJMR0I4?=
 =?utf-8?B?Y2dNSElUb09jcU9VNERBYi9RcXFRc2N0SnoxaUVxTTlZS1NRK2Q2ekF3MlhM?=
 =?utf-8?B?QUJhMGF6SHp2TnZhR1BUM0R3SUsxQy83WjA3UW81ZTZrUmwvRWdHRmtwNFpU?=
 =?utf-8?B?QkR4Smh3Yjh4MDFkTUxNdG1xamhFaTdPUktjWk44R0dEMzZsR0JzdlUrSTZl?=
 =?utf-8?B?T0M4amFwcllZc0ZCR2VUODBzUG91WVR2NUMxcEpCQ1J1ME5ibVc0UT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bee4f4e2-e0c4-4745-2071-08de61fc64c0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 01:42:58.7175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nFl+V3C3I24T+WkrVEU3ZCayAwurWXPczEEsoEzK006b6DwPbb/zH18pLht5H1/Tj3rYdgBjasLZp94PJ3LM7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11483
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

Add a new flag ATT_ECC which indicates the memory region needs ECC
initialization. If the flag is set, clearing the whole memory region to
initialize ECC. If ECC is not initialized, remote core will crash if
directly access the area.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 9bb55327998..9eecbe70f0b 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -46,6 +46,7 @@ struct imx_rproc {
 /* M4 own area. Can be mapped at probe */
 #define ATT_OWN         BIT(31)
 #define ATT_IOMEM       BIT(30)
+#define ATT_ECC         BIT(29)
 
 static int imx_rproc_arm_smc_start(struct udevice *dev)
 {
@@ -202,6 +203,26 @@ static void *imx_rproc_device_to_virt(struct udevice *dev, ulong da, ulong size,
 
 static int imx_rproc_load(struct udevice *dev, ulong addr, ulong size)
 {
+	struct imx_rproc *priv = dev_get_priv(dev);
+	const struct imx_rproc_dcfg *dcfg = priv->dcfg;
+	int i;
+
+	/*
+	 * Before loading elf, need do ECC initialization by clearing the memory
+	 * region, if ATT_ECC is set.
+	 */
+	for (i = 0; i < dcfg->att_size; i++) {
+		const struct imx_rproc_att *att = &dcfg->att[i];
+
+		if (!(att->flags & ATT_ECC))
+			continue;
+
+		if (att->flags & ATT_IOMEM)
+			memset_io((void __iomem *)(long)att->sa, 0, att->size);
+		else
+			memset((void *)(long)att->sa, 0, att->size);
+	}
+
 	return rproc_elf_load_image(dev, addr, size);
 }
 

-- 
2.51.0

