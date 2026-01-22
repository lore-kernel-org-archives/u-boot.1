Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE401D4697D
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 23:53:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5F5983B27;
	Thu, 22 Jan 2026 00:53:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BDp7eJrZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 166DE8313B; Thu, 22 Jan 2026 00:53:34 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6865283B72
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 00:53:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DCFgklS216B0taaa5KhaFsqwTf/HBT7wOWJwxKt8upu/c3Nfr3+UdW1+Fhc8cMVfGhmVX98FVFi8wuguH9ZXIXGZJekbBl+djGyjR4yygGeCl7Um0faIpiq8YLM8R3xieuOXTmbAt1det+TVdNGa4DqBh7Xl8JcQkklPTxw2dcXDXQhHC6VpUENl0CkB/gczcMgocxdQUDwfZ+fxWcjIPXeBojh7c7nsjXvCoyw+7znYG80v/zuPfERjaWs8xn9XZ8LZQ+n4aMi9w6As+SM4EkkNnFBVN72iLK9HKa576oo1N3MantCRWJaOYuFWxuA6LX/+vojevAl/vPBuzIRNMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tQo2Uh0HxFEzIvY9c9Ze/XHaTuuc+uaU3Syd938vQE=;
 b=BMxJnsw1F04Ngi07gE7k1HAdkdvpAAr7RwH0JFIOw5Rfsx5U0i9bgLmGYcLv5mlPAA5V/APd07XuoPqpR2wEp4baqg8w5VfNHPmdICJdyZMCDjxpDs7j9YIXv266Mw9vp/Ff9RuyVwD/FSmAYbjE+VMCIMaUyMPQTKPq/Abde7e8ttCNNwbs1cy9jOqO2PeFg0N/PUuD3p3ACFg36+9MWfLOgemO3SE7V9nDucInWXEbK+SJwGc822ZUMxOxM0QFJ/0FExeRzIimjl/HoFcELQaAKB6LFp6gIXwxd25kGzO/Sc10fa150TwPRHgpH6g37pwhBJDYAXf0VYeOHVLILQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tQo2Uh0HxFEzIvY9c9Ze/XHaTuuc+uaU3Syd938vQE=;
 b=BDp7eJrZcuvZHKQNf35HlB335q2oayx3YmoZLjixr5+vMk+W2yIBF7k5tM679dqLE8Cbhyxb6f1I9IipZITViAQ93KHXg/4dhbe2WNpRJPVSaUBLt75b7BxbOlxuVl95XZ+prDFWXTHTBMI5O+S/15pAIX9q9MZMPAThufb6ETHrlggqsSFVqxWeZGO5ZM4BwQMdzGQp1K6G0tLIeGgnT1cNL3zCQJ8dyAldUIfUWR4fICQP06zyz01Z3wYlc91SEO57vI5VGMxGiBVhkC0X5Fy7XAgnM66Q/WHb+GH7cPbslYqbqllluM1t3zC2ZxWP3n16JbzVao/SbLWIYk4brA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB7090.eurprd04.prod.outlook.com (2603:10a6:208:19e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 23:53:30 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9542.009; Wed, 21 Jan 2026
 23:53:29 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 22 Jan 2026 09:05:55 +0800
Subject: [PATCH 12/12] imx93_frdm: Update IMX_BOOT_IMAGE_GUID
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-imx-clean-v1-v1-12-a52a94b7e173@nxp.com>
References: <20260122-imx-clean-v1-v1-0-a52a94b7e173@nxp.com>
In-Reply-To: <20260122-imx-clean-v1-v1-0-a52a94b7e173@nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:195::17) To PAWSPRMB0023.eurprd04.prod.outlook.com
 (2603:10a6:102:37e::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM0PR04MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: 082a7b75-bd8b-4f0f-a6e2-08de594845ff
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eXNjRkY3Q0svc094OW1QeUNONXRVYXFNYkRhMldXOWJleWFCUUcxMThGc1FT?=
 =?utf-8?B?K3dLSVYrR09FbUlwT2NQSnZ1Y1A1cmloaGRJQXoyZTB5NWh3TzFPeUFnbXN3?=
 =?utf-8?B?UnVMSXJlRXdPN0Z6WUh6TGY5ZVV0MzJLc0ZkYXlGT2tTMlRjSld6d05rNlBk?=
 =?utf-8?B?aldRbXN4VFkwcVQrYWVQK3UvdUV6SktrZXdEbm1OUC9xZjMrNURUNXF0MEp6?=
 =?utf-8?B?YVN5cWh3WktGaXlrcTFiK3gzVndHcnJnM0pXT0l0K0ZiYm9Pb2ZoTzhEUTlU?=
 =?utf-8?B?eEdvendUSjRNODlyMFNyVG94NFNOaVR3OXlyeXNPVEFyUjdIRGtiY05ZcEVI?=
 =?utf-8?B?WFVhNGExOUVsSEFTeEdUSW14VHpGaUJ4T2hrcExFYitwYmFqR2NoUHVydTR4?=
 =?utf-8?B?TXBlNjgxZ0FuV1BzTmloZE0wazlabHpWVmUwY2FKdTNRY1lYc2d2VWZFYjBr?=
 =?utf-8?B?dFNvVitPUmttbHM0K3FYOUV2aWRNMnJyeWFMR3Q5R3BUd3F1Mm4vMEl1S1Ex?=
 =?utf-8?B?ZWN5VEFjUGE1Y3NXVFJ5bGUzcWVuMnV2ZHRUbFp4WEh4S0ZrcmYxdzY3QU5E?=
 =?utf-8?B?S3plZE9IQ0p1bTR4Uk8xL2c2M0d3UDIxM0w3QTlTQUc0d0xyb3M5ZlA1c0oz?=
 =?utf-8?B?OXlkRnRPRXFpcmRwUWlNZTFBcGNqait3K3BXMFNhMFpNbzRVT0c2T0hROFNO?=
 =?utf-8?B?djRwaFNoaE5kRGtOOGRQb0FCMFRjN0ZFY2RZUlFQREJwS0J5VHRHOVJ5cnlB?=
 =?utf-8?B?TzFKeUxkS2ZEYUNLdEJMbXZKR2pwQTJySmkvOC9sZkNucUZHUmFVdWYyS1M5?=
 =?utf-8?B?bFdCaHhPaWZubVRMdmhiektORTExYmd3S2MxZ2F0TDhQWCt4ajlNSW42Zllj?=
 =?utf-8?B?cG9US1JPczdnZFIyVi9oRG5TMlI5MVl2S3d2STFSdStVMUpDajJ6Y05LYk01?=
 =?utf-8?B?TFZFbTdDYi9DWXBsR2s0Zk51a3VqaUUyUXZnTldPVWZYTHhDMytBQXJTUnJ6?=
 =?utf-8?B?bUM4WEVEUUpqQzNNbjFKU3M5N29zazAvYnBrWFNra2pGQkhTUWVwbW9ScHhq?=
 =?utf-8?B?T0VPd2hsN2M1dWpHdmw0RkkyNEVQYWtUTk1uaklvTVRjVzZUNzI5V2dNM2Q5?=
 =?utf-8?B?Tk82cjgvV1ZGMnlXODRlR2RtcFFjeEZXMUZvNFoxVTFGcGJlSnFTbnpJOUZo?=
 =?utf-8?B?WVBwaTZGV1pWYis4TEo3V1oySkxoeFRpdDlhUHMrYmhOUjh0ZUtia3lJaFNs?=
 =?utf-8?B?K3h3d3FRRFhPQlJvdUVmYXgzWkJyaFF0MVRBTGlYdDRiRUhQMVA5NHFJalVN?=
 =?utf-8?B?WjZKczFuR0FXdEE2Zzl1TUpDa2VTYy9zMTNFZEdhTTd2Wlp0dDBCQXVKTGJ0?=
 =?utf-8?B?dzBDdlUreE5SZEVNTTJIQms1R0dHM3pVYnFuS2dyVExyOGRRM0I4LzVFV0wz?=
 =?utf-8?B?TW9VbUdpRm1maXozNGIvaFNqMkloVTc3dVVhMGdvRGQvUGRzQi82Sk1iTmlX?=
 =?utf-8?B?dXJJK2FHYUJGK2FiMHhBTndzL0hZdDd0bTM0cmlhUDNuM2FFdmNVeDJrcVBv?=
 =?utf-8?B?Nm5QY3duSGt6TmNlR3IvdjdScmlUWlVoaGR1SG5YenlnQkNRUmN4bG9RRWRz?=
 =?utf-8?B?RlJYN2JsMlpocXBKMS8ydWl2Q1poakhDUmtTS3NKOEQrUkZtZVhNMStsVjlU?=
 =?utf-8?B?QmJNRHhVbzRVOWJGSW1UMXlEempIOEVnekFMKzRqemtwN1JiSzZMZkFPbGpl?=
 =?utf-8?B?ZS9Vc0lvamY1TnFTREtOQ3k5QjBKalFJREFxN3daajlTbW1nM3ZSVy9YTGlB?=
 =?utf-8?B?MVJnbllGL0U0Wit2MzFtOWRzQUlhbzJnUjZHUXBzbVRJRUVZdUhUMUFaTjYx?=
 =?utf-8?B?czdLT21JY1l6VkVpcjdabmxIVnJ5RjBLNEdFeEl5dFp6M3pvVjFEZXFMbk5C?=
 =?utf-8?B?cDQ2Nk56eEZiN2RIb2Rvc1JGWWJ5Sm0yUXdLeDRWcGlwc1FVNUYvQmphUzdj?=
 =?utf-8?B?MVh5RVlnK1dOa3dvakpOQm52REwxSDhpUWQxTHFCb25LWEJIUTkrWXFTN2FB?=
 =?utf-8?B?U2EwSDdYWTk2UkZhL1plZjNaeUk5eEpWdWZvck1iQWNYbm5ieXZ4b1M1UGIr?=
 =?utf-8?B?bEFPd05hMGs2MzE0aHZDMHFMTzZaUU9FSTJjblY4TjRlNGpzRTUxSmpvbHpN?=
 =?utf-8?Q?Sti8V9vUP/yhXFFBa8mv48A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(52116014)(376014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjloM1pXcTVpbzlvWENtNC9oZ1FvY2RiVEtlc0RlcUc3SkkzbGsyWFd4dlgx?=
 =?utf-8?B?ZjRUTWhIR2JaREhRajJZaU9wQ2k0Q25peWdDYTVOK1JxSUQxWGx6RTA2YUxh?=
 =?utf-8?B?WU0vd3VId09FQWNmbDB1TVJGWGs0WmdreTN1VHdOUkRMbXVVYmYvSHhtMm1O?=
 =?utf-8?B?eGhCbmgvalQ3VnovVFp2eENPcE5rb3M2OExWVHMwS0ptTFdkTUpQSGZrOHpV?=
 =?utf-8?B?VjduM2R6em9ucjVjYUNBZ0pUYjRjNzlhcFJxMFIvNVgzTGpxSGRNWFdJRzdM?=
 =?utf-8?B?cFJXTnJLMkdCNGgySTdlaXhyMTk0bnpwSUFZa0hlK1V0aWlJalpBSkVBTVFN?=
 =?utf-8?B?R1RRQ2Q3Tzh5UjIxUmp2NVBVNUhwREdEc1F1bUdRcUhseWFOMFJ3UDNyMnp1?=
 =?utf-8?B?ekwwbnltSWlzaEljb2hlYUdyOEZEV0VveVdTZXFHRGlHUzNlakJZeVZra2ov?=
 =?utf-8?B?L0JUQ2xVaVNDbnJKSkwzUEdGZU1QNHkyMTdHb015QlcyYkhkU210Ump1djd3?=
 =?utf-8?B?K0hSSjA2T0V4aHFHTlA3MDQvWE9WMGhhM0lPNTdCTVpJL2lzZFFDelBhODRX?=
 =?utf-8?B?RTRvditoakhsQzEyVHFnNDhUendDMVpMbitvWjVWdk5zcVVIck1QM1JmQzJn?=
 =?utf-8?B?bzRFbzk5am80aGh0TVczUkhZRncrTERITEJUVzdreWwrUUk0KzdvVTltQzFM?=
 =?utf-8?B?aGZDS0JGZVZJZWVHUU5rSmxranV2OVZrMlZ2b0hzQ2RoL0VsSENmUVZTMTZM?=
 =?utf-8?B?Nm9qeFljU1djTjVhK1NGOTZGUnBhQjlBMDZidTFrTXJFUlRzK3FHZ094dGlO?=
 =?utf-8?B?aGhUTkNjeEw5TFFrdFdMR0R6U2Rjb1ppTW5Tb1k1cDI4UVNoM05sZGxlMEhk?=
 =?utf-8?B?ait0L2RBbnhUczgwYUxTcEgrOG5JUDZBREozK2R6cEVVN3BzbDBKaVhBUGtM?=
 =?utf-8?B?NXhpeG1nYms0MEVsNkhzZENRNU1ndGpic0UxejhaYVgvc2tqVStKM0RHVUxz?=
 =?utf-8?B?bmZ5cGVCSVA5MUZ0MTRMQlZDNFI5cHptbHpET1ZqMzI0RjYzNE9xWTBmaUls?=
 =?utf-8?B?MzZQYnBXclorc1VmN2Y2TDI5VjY1SGEzalVVMFdXQ3YzR1RoMkNzenNsL3Nz?=
 =?utf-8?B?MG1qSmlVMW82V3lPc0FwNUVkc3ZHR1dITXNlZTgzVm8zR2diNXNSWFdqVUkz?=
 =?utf-8?B?QXNsMW93TkZZNzZOR2I2bFQ2Q1ZDb3VGSVNkTkFVWitzN2l0Nm9tM3h6Uk1N?=
 =?utf-8?B?TE0wbXZzQ2sxTm4vZTJCcmRLTEFzc3p0UDRrTDhITVA0ZHVZSmYyZmxDT2hP?=
 =?utf-8?B?MTlZU2pITThPZE0xMzJGQnp3UnV4cjlsTEhDN20vL3JhWWFlbkJ4SEhnUnBM?=
 =?utf-8?B?dWFJUEZRekxlS0hQRmJJZmJkbExtZC9CYW1WUjNVZVJZaGcvbXlCdjlJaHIy?=
 =?utf-8?B?RlNaR2xubE4vRTVPSHBsYjJsN1ZDWjJLZ2svekt4aUhsb0VDRysxdjdBRU1C?=
 =?utf-8?B?OGdqSHU2OVdGZjRWV1Ntd3g0bW91Zi9GWWpvY1ZQRStUN21tU1R2eVFMT1VI?=
 =?utf-8?B?SkkzOHZ1RHZBdm1NSHlJcmdGcEVySHhoY29zTlNvdGU3a2NNOVNZT2RFdEIr?=
 =?utf-8?B?bXd2Z0tKMHFmblUwSGRoaXZHdDFDcHcvWHFuTGVJVThEODNqdGpUK1hPSXg4?=
 =?utf-8?B?c2E1ZGMxa0lTR1lSSWdteURJSWUvQjNyRktQOHdQSHk2ZlFFSG5ocHF0M1Bs?=
 =?utf-8?B?N2haTVV4MER5VlFTbEdubVR3Uis2VVJpTkpZQnFEb2s0ZktQZGdzQW5wTXBT?=
 =?utf-8?B?cXE0THllWGVFbFB5TjI3Z0c2SjZQVHI3ay8yRzByMDFGc1RGSEZYQ084WCts?=
 =?utf-8?B?eXFaWXFYUlVQNi9DWmtVWCtXS082blhTNHA1eHFKTGJ3K2hYbjlsdmVGR0Qy?=
 =?utf-8?B?eFJvSVp5RUhJeDdRRE5EWHVBT1dnUTJ2dGJKRmVvUmRQVld5VmtjNVR3WW91?=
 =?utf-8?B?TXRxUFplc2Y2SUxyRmlTYjhRZVBCV2ZGLzBUZFQxTXFvSUxDbHlIU0xHV3hq?=
 =?utf-8?B?M3RHdjRqT1VZb1NGY0RkcE44Nnh3WTc0ejdvTTl4cmQ4VWdGeFdNVUtIcHVZ?=
 =?utf-8?B?TFpxcUExaTIzdWoxVkprbk5OalB5dW5NODRuZnN1c1NSY0FWSGczckY3RU5H?=
 =?utf-8?B?aUwwOEtGQzNxTDUyRTdlVjF1cDVqR3g4T001bFZRaGdNbThiQXdXNmRxR1Ft?=
 =?utf-8?B?N3FuNzVyOE92ejFHR2hHVEFmdDFzSDk3N0NqVGZuZElHTGFjNjdtSE1JZDY3?=
 =?utf-8?B?R05xY3N0Q0sweDNXUWE1dTF0RmdlR3ZmcFVQYlQ2OGlEUHlNbjFkZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 082a7b75-bd8b-4f0f-a6e2-08de594845ff
X-MS-Exchange-CrossTenant-AuthSource: PAWSPRMB0023.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 23:53:29.8840 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MI1rhIb8DbSTbYltCVwfG5paKS9zLZ0kCh9JgtA9TIL1UO6aXFadClf5D8D00jiKhWePugmGBWvZArOQ8/GNaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7090
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

Reusing IMX_BOOT_IMAGE_GUID from i.MX93 EVK is wrong. The ID is per
board, so regenerate one using uuidgen.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx93_frdm/imx93_frdm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/freescale/imx93_frdm/imx93_frdm.c b/board/freescale/imx93_frdm/imx93_frdm.c
index d97720795d6..fb78a9bd036 100644
--- a/board/freescale/imx93_frdm/imx93_frdm.c
+++ b/board/freescale/imx93_frdm/imx93_frdm.c
@@ -16,8 +16,8 @@
 
 #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
 #define IMX_BOOT_IMAGE_GUID \
-	EFI_GUID(0xbc550d86, 0xda26, 0x4b70, 0xac, 0x05, \
-		 0x2a, 0x44, 0x8e, 0xda, 0x6f, 0x21)
+	EFI_GUID(0x6f86db61, 0xcda9, 0x489a, 0xbd, 0x36, \
+		 0x2f, 0x7c, 0x65, 0x1c, 0xa6, 0x5d)
 
 struct efi_fw_image fw_images[] = {
 	{

-- 
2.51.0

