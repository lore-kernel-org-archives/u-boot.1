Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864BCEE20A6
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 14:14:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1194E83AA7;
	Fri,  6 Feb 2026 15:14:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="uAR8kw/V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4206183B5E; Fri,  6 Feb 2026 15:14:10 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED3A3836D3
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 15:14:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ulzkw5d+v9Sl7nXdrvis/kV8/uKJPb2FovHwfC4pppgFzPSJGkmItRdmOwBWP5vkjwx1a8oCIv3OLQmXEOeYfGzkZplre44EcOZSO2mYtZFZ1mgYz4BJsnGFx0zrnVoOX0D/2Dd9WRPEtoIENOYhkI74DK9dI6/3KcH2ixccynESqa6XePKuRNwuN+nDMpcg+GYmZvEFIPs3UigwDaIKUcH8bJPcCLI6NDvk/sCxcd13LsfybOmirJpo8UkAZtGhCAp3jMfCFV/ZJ/p7RMwLdw2SY1i2HDoUc8vNncY6T7UYCkHvD61zlKCf4ossk73wJy5L0KRpqFd18mfRzzPtNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXJ2zoBw40QxBCfA7idLK9c9y/1O0cL7We5WiA+IEas=;
 b=onbOSZ+DnMLFkucGk8jVAXqxJpvLb/NduJrB5DeQCc3ls1gDKpQS5DmnGUeKefrmqpbDmz8FofiGvFU8YAGlWGRxxcylWqG7yK2/vZ5uB4PIfC3hXv3Z/rRhYh4upnr+zDui8ySAZeq/oK3KCVLSJ8HB5R3bec6RYymlEOiEvNTkPj8dgidNInAVxHn69hlVlJbKt78ZttrYlbSsUZ083Ns/kfEcRclnrx1qMsBBR+dCyUhe8IKD6NAAWMCfS5wWgKV52ahijrN/j0Jx5dtMdD97eb4MfSUHzu1/Zn7LacyRUG5rMGLFSH+MbH4aPfPF+0AmuzP/5EQHOZP0t/j/Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXJ2zoBw40QxBCfA7idLK9c9y/1O0cL7We5WiA+IEas=;
 b=uAR8kw/VloXWj+kqaPQmW94kblO6KbMtSN0vRjTK0gsimV6W/N4+8RbmaXgSBlnUdrF20RFx2rElnebQl0BOiCBF/ySOS9bX7pfKxR0ZRkORdbMpL2uLhXu/m677P+DVrfYsEMcEhQ+F3IMKA1LL4Dl6XMN3ln8AsxAJD3JO/M45cu6dKeLSpJPLLM1slSffX05o/nTm8s4QkrIKWCwi8jupi5BNhDtsbfkJ9lMmIt0JwwN8jveCCEXVTNqXf5Y1dRTDd7y6pioOtkPkXlc5Ms3A8wNAi/fsI8dBX5JGIcRMfxbPtwieDNtp+57lB7TW2GLRP+6vSUlNbK68Ix9UpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU0PR04MB9276.eurprd04.prod.outlook.com (2603:10a6:10:357::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 14:14:04 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 14:14:03 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v2 0/3] imx9[4,5]_evk: Drop init_uart_clk from board code
Date: Fri, 06 Feb 2026 23:28:42 +0800
Message-Id: <20260206-imx9-board-clean-uart-v2-0-ebee8158586c@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKoIhmkC/4WNQQ6CMBBFr0Jm7Zi2Kg2uuIdhUdpBJpGWtEgwp
 He3cgGX7yX//R0SRaYE92qHSCsnDr6AOlVgR+OfhOwKgxKqFkrUyNPWYB9MdGhfZDy+TVxQkzP
 S6oGctFC2c6SBt6P76AqPnJYQP8fNKn/2X3GVKPDS1Lf+SnrQjWv9Np9tmKDLOX8BveWLL7gAA
 AA=
X-Change-ID: 20260206-imx9-board-clean-uart-7eda1c7fed1c
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Alice Guo <alice.guo@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Ye Li <ye.li@nxp.com>, Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SG2P153CA0030.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::17)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU0PR04MB9276:EE_
X-MS-Office365-Filtering-Correlation-Id: b745048b-72c1-4d96-98b7-08de6589fb6d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|19092799006|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bW5aNFJYekYxcFUwVWhxNnVOQTU1VS9PVVRzTE9NY0NmaGNOYlZRdm5wZmNO?=
 =?utf-8?B?SU9zR1E2OXBFMW1NK0JqVTZSSjBVN05iZnRPcFZJYzhkVHdzZEpPK1A3aVVs?=
 =?utf-8?B?YUMxeGFEMnVkTEM0MjZNWUNES0loQ3Z5eUhpRlVuL0xtQXk4NXA0RGthcVBW?=
 =?utf-8?B?UDNvTTJlV3o5NXA3VDdSYm9pa3Z5SXRvTE0rN2d5Uy9EQTBEQkhRYXEzREwx?=
 =?utf-8?B?UkRYNFpQcXF1TFB0ZGl6YmZSVG9KaE14UVFRaEdVRU9kREwvREFNYlVNZm1s?=
 =?utf-8?B?S3pEaUhMOVdYdkF0anU5ZytOSVhLQ0pZdUFmWDdCdmN5QmVISjZDNFgwQ3k1?=
 =?utf-8?B?Tmdiby9ZbEhMWUFCNDhwOURkNDZKUlp6Q1VYajl0NTZVYzRSRGFqb1ladE9I?=
 =?utf-8?B?L2hGUnUvcEtaZFVnSlFkbXFla2J2SXZwV2p6aCtzbUI5MENNazIzUFlwWnQy?=
 =?utf-8?B?ckZZcm1PVm4wRGZFU1BkMlg5MUoyR2JERzBWYTBhNWJkcVJhWkNIS2NhR0lX?=
 =?utf-8?B?OGlQdHJvakZqeHY1UWRBWHNqVVlialRnTThINm9KbE8zMU9RK3VHL1cwU0l5?=
 =?utf-8?B?L1VwWmRxV2FFdUJSZ2ptMkdROTM2eWtxSW5BZHZtUW1hMXdNSzdoOE4zcnhQ?=
 =?utf-8?B?emxaeE9kVnZxUDBSOEZJRzhZRmxLMVJ6V2s5QWowaXJ1eTdBSFJSbi84U3VM?=
 =?utf-8?B?ZE91bUpOS09jSVp5Y1p6VUdQOU5rWkZRQUlaeGlZNktuOHBzZExpUkVqU3pv?=
 =?utf-8?B?bm13QU84akhzZmRzYWtpZU44Q0pNREkzTEpsL0E2VmJkZFBzYmU2YzlSd00r?=
 =?utf-8?B?OXZnbVh5WEtMS1RLcEFtYWhBbmF2VnZWcHVhTEJ6MmUzZHZJZVVPdkpaUFdZ?=
 =?utf-8?B?d2JtT2JiUDFSbDkzTU4vVUZHc0N0UnU4ZU5pVHZrd295N01Ld1ZNUzlvbzhx?=
 =?utf-8?B?dm1CUEN5NHJaUmpEUW5zRnlSR0ptcmUvcVlWakM1eTJRRGpKSUh4SXo5ZDJ4?=
 =?utf-8?B?aFVGRUpzVStScHZoS2ZQVGFsZVdtb0hCOEVXQTBjLzF0YzR3SWpyQTJ0Q0ha?=
 =?utf-8?B?cTJmR3NMUHV1V29md1I5M3JzMmpqOTBPNFVGUFVsWkhHRmVXMzBkNHdCTmp4?=
 =?utf-8?B?M3A3bUVubjU4aWpRSVpLY2pOUVdEUnVaakxLdnh1UU5aMVZBK24rVU82WStZ?=
 =?utf-8?B?N3hreERZTE1pMU5yVWMrV3F3QkYzQUN1YWErY0xiZDR6QUZNRElST3J3Mm1Q?=
 =?utf-8?B?WXhqalE5TEczdGVhejI4ZEVFQkZldFFkZ3JIczlKTGtTcDY5Uk1GOFBnV1I5?=
 =?utf-8?B?U3BUNjNiMEtXZWVyOWtuZXp6T1p0dE5lZjRHMXpCbVN0RWFkVE9qYk8xdHdt?=
 =?utf-8?B?Q0FJdUZQc1JPVlF2ZThSekFVN0ZpTmRFWXpsWVlueTJKQ1JUSDB3Vk1ZdjRu?=
 =?utf-8?B?YUtGMnlMbjE1Ui8rNC9HZEJ1MFV0RExYSVFnaXYvNldQSmZUMnZDYzllR3Jp?=
 =?utf-8?B?ajhyamEyaFFzZFpUWXJxd0JXbjBZWThoRVltOHpVMEN5WWdZTWxMM0F6MnZm?=
 =?utf-8?B?SDFHYzREbytNenJVcVdkdFpPMytHRGF0VDQrVDJNYWhpTUR2WUxiNi8yUDJl?=
 =?utf-8?B?MFI0V1lTVWxlQWw0SUdrN1ZSRDZqK0xjWDFVR2Z2OEdmZGNidDM5NFNucXA0?=
 =?utf-8?B?aTZtdlQ2a1RvN2cycmRuZk1nRXlKQTJPdXAvSFJKVG1PU0RKcjQxWmJVNFd4?=
 =?utf-8?B?OXVsZzNxMWlwOWx3NHJVSEhEcVdmN2w5S0t6OU41MFdWTDhkeUp5M2k0TDhH?=
 =?utf-8?B?Mm81ZlJNN3h2b3NZM2tzSFBHSG1STHA0aXJiRzhBTDYxTzFLKzRQdXhPMVMr?=
 =?utf-8?B?cENieTVzQWVtOG1VMUJnN2VydWxjdWFNa0JienJYdHdjUGZFOHE5NTdyTFl1?=
 =?utf-8?B?cjdiUVltR1Nla0piMnd3UzU0N2o3SHEycDdrQUFlTkNTaHJ2N2FENHpwZW4w?=
 =?utf-8?B?aW5rUzhZYnlEczBXb2haU3NkaXFCSGlVSmdUck9aL2JpaVM0T0JLc0xSYkh1?=
 =?utf-8?B?M3o5RlRYNzdSTjFxTzhzL3IyRnNnQWsvMCtFZEZZQjN3NU1PSzEzaXJtaW1L?=
 =?utf-8?B?NmpKcTh2TE81dnN1aHZXMzMwYnA3NVFKZWJLdExOeUVlcmFyOU5talQ0M2lr?=
 =?utf-8?Q?KbgqoorStkkdVsQNCSVC4t4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(19092799006)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWFwZGg3dS9hUDRVamhtWWlNanVRdm8xSVhnVDV2bE5HbUFPNEZlRW1YMkJk?=
 =?utf-8?B?M3VackZCTVlNcHRvVXkyWjZuQkNvcGpLV1F0a2RKT3MyWGtoMnVoaHM0Q2F2?=
 =?utf-8?B?M2lodmVkS09EbVovN0p1REZGNnRjUTZ2SFVRVXV0OU5xTWlPRkhkTWkyelVi?=
 =?utf-8?B?ZUp1VUd1ZDRjWmx1UEpGTjFJK1c0dkg4VnA1dWVXeU13czNsdWFGRjdDQlc2?=
 =?utf-8?B?ejlxOVd2NzZyTGRwQ09XU3lFeWFQU1ZYSElVdDhhU0dNekZNdWhYVXBxWU1G?=
 =?utf-8?B?by9pNDJ1T1d3elRFTHlIYTIycHJVQTdoVGFhUFQ1bFQ4N3ZmeStJbEZwd3o0?=
 =?utf-8?B?YlpoQmtNaUFqdTZuWjdJdmI3cjBrUldWdXovUXZFVnJhMW00ZXFkODBHZzY3?=
 =?utf-8?B?STJmZ09RdnJLejgrVnlNcWxneFhGTEtOQzNCd2RPUUZKWXIzcDh0dTh2Nkpt?=
 =?utf-8?B?aFhTQ2VURmlLUHpOeEFYb1ZxbDZqYkMzd1BvcmQrTHZUcDFJWE0zWm1BUWxE?=
 =?utf-8?B?TFlvY1lPUzVZOWw4TmVQY1ZwQlQ5NmdjTTdyeXphU1I5L3lmVmNyS3ZPVk5S?=
 =?utf-8?B?ckVSR21aTis3eFpXbEw3Qzl1UEt6OHMxditFSDFtRGJDMkprYUNneitqUEJB?=
 =?utf-8?B?M2dRcWxyNDNPcHlPeGRpRWZ5NVpVU05vOTc1ZEJ6WngwbFRiN1F0NUIyaTNt?=
 =?utf-8?B?U2EwZm1zWk5oUmliOFRIZjQ0c3ZCdkNYem5xUnJuK2F0emtzR3d4cXpzN1Vz?=
 =?utf-8?B?aXBVNjFjWmZxZEJzTkVFWXh1L0d0aTJlMXg3akRLSHhueWVzR3FoUXVucXdR?=
 =?utf-8?B?dDg0UEhnU2NnUHVxckw5MXBybURKckR1TGtZeWMwWWQrNXFXVy80ZGd2Yk5D?=
 =?utf-8?B?NzlQL2tYZjNOV3p6MUtWcXFIYU8ydDBpT1RHVURwVEdJcDhLZERYNE9CRExP?=
 =?utf-8?B?RTVXRTVCMFNaMVROdjhBZkNZWnNBaSsrdWZJeWFJNVlHS1VTYVZkSU03Yk01?=
 =?utf-8?B?Sm9Bdzl5Sk8wWDQyVkx4NU5RNThLazV5TlQ3MmI5bWM4UldvUnZOYjExMG5K?=
 =?utf-8?B?OUtjRjR6ZDJPbThaL2E3L3hseHNYb0dZOWNNODJYRFRuQno1WU1VMFlpbWRQ?=
 =?utf-8?B?bnRhT1NOMHVtQTdCNUJTM1dINGZzaVJkV2FiTXBxWkJST0s2YlZWWXh3NzRw?=
 =?utf-8?B?M3g5S01vUFpKRE5UUHhnQ2kvekd6NitSSU1ZR0kvUFZBT3E3VUFzd1drc1Y0?=
 =?utf-8?B?MjRORzVRbmNLTEZzSy95NnJvT2NJQ21ROVZzbVZYVDFEOVBHdXhJNzBTd1BZ?=
 =?utf-8?B?RXc0TytHODN1RDkvSDE5VUpBOUJreVBscjhaY0h0OWlad2xqQmtSYWZKQkxV?=
 =?utf-8?B?TExQb29PTkpUTlIxUWZpMkR1anoxYjhubVVNVWpmaENnK0xscEFvcjZJaUpP?=
 =?utf-8?B?VkU1VWk2YkwxSEt0RHNyLzFGOTZkYXFqdWp2djdtbGxoK1UzTmU3cDhJaGdj?=
 =?utf-8?B?d1BQb1lkOHZSSktvYUlsUTQ5M3ZvRVZZdkxFbmJ5d3pVUGE5ZGppQWdIblVv?=
 =?utf-8?B?WFJDZE0xeHhpOGJYRnRtSmhSdE5JVzZqZEZ5bTFsMnNVZUs4ajZraGYxbFQz?=
 =?utf-8?B?QzA2WDI0MHF5WjJyWUV5Y2pqYU00eTlxeFI0Y1JMVVgzUzRHenEzR0dIN0pR?=
 =?utf-8?B?b3AxTHdJVjh3QWpmM0xJUC9TdzhPeFpGWUlvWDFualVEUWJPUlNCRkcwUTRD?=
 =?utf-8?B?d216YTVxN2RLM25FRUZPTElTZjRNQTlFUzFHNk1BQUVaL2F2M0VjNTk5TUkw?=
 =?utf-8?B?Y0dnMlNXTWtUNllTUzd3aFN5bDkvMXMvamFiTW9EVmdxK2VyS0VRRkVON3d5?=
 =?utf-8?B?UXJzbFo4S1hUcjNtYUNhUFJvWiswaU9QenllbHlYUmNHNG52dnIwa3IzcDNP?=
 =?utf-8?B?N3REdWltd0VKeHA4ajRGUlcrSy8xUS9Ncy9US0pyQ0J1Yno4cko1cVZla2Mw?=
 =?utf-8?B?L2s2YzJuU3JpUUxqVlF5eWVBaEZPVlR6dGxqSW9sMDJ2cE5jcHBoVUZGcXFY?=
 =?utf-8?B?b01iaEt3SmdvZzBENE1yenkzRFVpTEp6THZNTU51YTJNR002WWdWb1N1RnBu?=
 =?utf-8?B?NjRHT0w3T0pqc21TbC8rL3RUYXVrRkVtY25iYXhJNjVXbkdNNW4rSFZVTlg1?=
 =?utf-8?B?YTBrTHJuaTVTNXRJMWNBYzdTYzhDSzdsTVpyeWREWllFSHBMU3RXMy9sOWcw?=
 =?utf-8?B?N1dBdmZaMUlDdXRneitUbmh5Q2ZRMXpMVU5OdXhaY1I5bWZTL1ppUDdYVUwv?=
 =?utf-8?B?ckJFRUJ3RlMyUFRmakxKaVRoQUswNWZRQjZLRkw3MHdIVkc5SjRHQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b745048b-72c1-4d96-98b7-08de6589fb6d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:14:03.8469 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cCJakK8EcwbYNNi7Vb1EjBm+FXbytFzzRBrSfYlI99ZwM0aTS4sdm98BqmmnQm+qpAaLSa96Nbaf0/K0IUW5Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9276
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

The serial driver could enable the uart clk using clk_enable, there
is no need to call init_uart_clk in board_early_init_f.

The init_uart_clk() function is still kept, in case it is needed for
debug purpose.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v2:
- Drop board_early_init_f and update defconfig
- Include cleanup to toradex smarc-imx95
- Link to v1: https://lore.kernel.org/r/20260206-imx9-board-clean-uart-v1-0-3965b4e7f79d@nxp.com

---
Peng Fan (3):
      nxp: imx95_evk: Drop init_uart_clk
      nxp: imx94_evk: Drop init_uart_clk
      toradex: smarc-imx95: Drop init_uart_clk

 board/nxp/imx94_evk/imx94_evk.c         | 6 ------
 board/nxp/imx94_evk/spl.c               | 2 --
 board/nxp/imx95_evk/imx95_evk.c         | 8 --------
 board/nxp/imx95_evk/spl.c               | 2 --
 board/toradex/smarc-imx95/smarc-imx95.c | 8 --------
 board/toradex/smarc-imx95/spl.c         | 2 --
 configs/imx943_evk_defconfig            | 1 -
 configs/imx95_15x15_evk_defconfig       | 1 -
 configs/imx95_evk.config                | 1 -
 configs/toradex-smarc-imx95_defconfig   | 1 -
 10 files changed, 32 deletions(-)
---
base-commit: b5213bbfdcb1812be510427857827ee8becb9f8f
change-id: 20260206-imx9-board-clean-uart-7eda1c7fed1c

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

