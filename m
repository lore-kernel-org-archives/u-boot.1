Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37EABCCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 08:06:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ED7D83A2D;
	Tue, 28 Oct 2025 09:05:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="o1oh3SHw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A70A483968; Tue, 28 Oct 2025 03:48:23 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC5FA838F8
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 03:48:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ru3oMXE5INDnBEN33EMXk8SutYY2aZIj1W/sdKyCz4fgeiKYqdXfiNBfvpj3inW9ieExLx9Q8zB5Dv5C9+X3WAS3fCN+hX6z4jCsYmf0QqmhcvI1lodfKq5HZhK4/sXg8s/7iPolT86Lli7P3Hwtl1VxkggKVL/p4UNslEEfZcx2TvN/WAQljQdwuXFDW28zxshw7ljWZH0sX0Umqx7MTSysGtAqPwwMx3OHuZ3BwrYzxE2y8aYqiwMx38WQE1YkGHHKzU6zwZBuJ4xScTzteA/Vzhh/RqArnvraWswP+6NL/rz61dZnngj/yrYxgVvqI3WXTPlM8JrkA+rOcFKwzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5V3UKnAh3lDB+5Xyq2KiHED8BiEGcPkrFaQ/yLlzUP0=;
 b=W7y6aa/RHViWSvVtsCioKBjkujRg5CaZS+xfNxSiDLseke8u8DzJw6SKtG6c1wRIqvOj8r9JAVVBAqfPQmcwzrNQhp0bzMPXG+YHMWl3g+PO1OY4u8Stu6Lohj2xfyyhfHWjprWCor98Ymz7Wyz3R0F172g5y0yylGnqA4eQFj6KnEGE4mdeVW3jCzKLAtuYryKVSz3URAnvMiDyUVQ5Pn34EQQI7G/ow5lvZdJC0cjuhpnWDHMH3gu1vM2FttKOb8X0riHLeIzn7wa6gwrxixntU0Qy+6QDmmFOB3gdHY8LVmuSFkcu8s/ntQ3lDkXWzGmpHSCL8Gzmlb+pi7fTRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5V3UKnAh3lDB+5Xyq2KiHED8BiEGcPkrFaQ/yLlzUP0=;
 b=o1oh3SHwTrrCR3OLLP4Sa0JpjFWGcW4kd97byEU+H3Z6MpF2baThYhJf3kS/+EF6Ur8sC2iU24doiJ+9PAsg4ool0r12jrmcrMIwGwg4J88cNhnhO9XGkYAo3dj5TlowkkyhApomRSAuDmAwQztmRhDjbJFrKnujzem2H0XIULPpGNYFtaBssEfzTDRo4tNOi9momxJS2dmWIoRiblz3/q/KQ1APKS1i4K0xQDaFR1FS+4/4lg6C5iOiA6uzsYLWLs+Ox+zH/6gmXrx0m13MBzsFtKcW9IceJmqEjq10LI7bZ8Yqjd1nMz2xjuwp8kgpIGXDPrIp2iXM8hXpNm4Sag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7891.eurprd04.prod.outlook.com (2603:10a6:20b:237::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 28 Oct
 2025 02:48:19 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 02:48:19 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 28 Oct 2025 10:46:28 +0800
Subject: [PATCH v4 07/10] imx943_evk: Add support for booting from USB SDP
 on USB3.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-imx943-v1-7-955b8370c685@nxp.com>
References: <20251028-imx943-v1-0-955b8370c685@nxp.com>
In-Reply-To: <20251028-imx943-v1-0-955b8370c685@nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Jindong Yue <jindong.yue@nxp.com>, 
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tim Harvey <tharvey@gateworks.com>, Frank Li <Frank.Li@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>, 
 Minkyu Kang <mk7.kang@samsung.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Roger Quadros <rogerq@kernel.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <ziyao@disroot.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR06CA0222.apcprd06.prod.outlook.com
 (2603:1096:4:68::30) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM8PR04MB7891:EE_
X-MS-Office365-Filtering-Correlation-Id: 4258c4b5-e637-430e-9cc6-08de15cc7401
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|366016|7416014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkdCZUlVaVlTWS8xaWp1a21FRHBNNVJDTDRGTUo0MGxKRm9kOHZKa0dQS3Ar?=
 =?utf-8?B?OWkrTHhkRlZyZjA5TjV1YlNrSm9DVmJVM0VaRnFGN2lRc2dJL0t3TUIweTcw?=
 =?utf-8?B?NkRnUmZFa0dvUG1aSXhSMGM1dUNnZEFFQ2g2WXJycVJjK2N0Wm8yRTA2U0tB?=
 =?utf-8?B?U2huWHp5cURBbGhxa2ZYUm8zS0ZkeDh4aDVIZGVzdVhxd1JrcEZYYWJOdWUy?=
 =?utf-8?B?UEhHOFFaMjgxU2IzOTZDeVhaVlRUSnZCd2JaMml4YWhFS3VNa3Q4MWgxcUFJ?=
 =?utf-8?B?NUlJZzFpTFAxYk5sbnFhTVJOR0FNQ3M4SlgzSllUVmJvWDVvNWZRRFVYalNL?=
 =?utf-8?B?L2N3QWlGc2hXbGxUNW1qK2E0YjArWXUzY1U4Q05ROXhib3o0RTZ6YVZmMktm?=
 =?utf-8?B?MjhLbFNSNUNIY3RaVExsZnhpeGw0cjUxaHhjTWNZNGtwZU9GM2F6K05lUC9B?=
 =?utf-8?B?UVgvRWhBNE0xUTNhYXYrS3VaQXFqMG5RWFZMYlVybG1tL2lUanIyaDFrZnkw?=
 =?utf-8?B?MDFEWE5zRU5MZWdKSzdMWlNKN1FJN1IyYWNGMlRSMlB0eGRjNTdZZEFVYVRx?=
 =?utf-8?B?K2hGb2ZIQmZXcXovZUVZbDZyWW9BTU00UDIzU3crWGxkejlua1ZVOEtrSlJp?=
 =?utf-8?B?UTlFRWdmUEZFMExtKzBiOHc5MmhoN2ZQVnk1LysrRHBPaFdnNDM5UGk5cm5Z?=
 =?utf-8?B?MGpIaDRRdlVGZStOZE5oazEzMHhQZm56SGMzT1BPaWZ2elZZZWtBYlRzS0RJ?=
 =?utf-8?B?Y0tTblhxOGhSWkxlekc1RWhXRVU0MU9WLzRqbStEQlNyWEVjVldUQTU1bDN5?=
 =?utf-8?B?N2JDNjA1MTNhb29VWWRRRnYxZ1Z5aGZDVC9BVHl3a25EemE5WjVOcE5jWVVl?=
 =?utf-8?B?K3AzZ2VIQ29HZHJ2UFN4WnNYYU9QczBWbFEzRXBaUXBtU0gwM3dXbkJIZHFU?=
 =?utf-8?B?YVk0a3JFajllRzFqZ0NXZVpxTDhqdlF6OXdnbm5GVXlINWZ4ZWNZa0NycEJ4?=
 =?utf-8?B?V2RuTC8wWjBsREg4TVdhaE9MNzFURVJ0NUV6ZTF1eTlwSWJQczN2NjdzREZH?=
 =?utf-8?B?RURuTVQzekFMNWdOeGgrZHBTMStIM2NlWEhEZzNRY0V4NjVvdUpnUHV4WWlt?=
 =?utf-8?B?d3oyekM5WTc4VE1PS3pFTHEwWWRSYjVRNGpQYTNKbVEwSTMzZWREc3laSVFh?=
 =?utf-8?B?aUNXb25oSWpDSTN1VE9lM0JMWU9qUkgreVE5TUdaRWRJUGd5UmEya1VvSTdG?=
 =?utf-8?B?enpWOUVZMW9PZy9GL1h5dW5qaCtzQVp4eERiYjJSVWV4OHBHK0Q4NENMMkJ6?=
 =?utf-8?B?akNUOGpiUDB1QnlrTEhIMlRoVUxyNVNES1RLNlJVd1NQaXh2MG9xUnNxN29W?=
 =?utf-8?B?MndKU1ZMenp0dC9XOFZNaG5hWExScWdGVVhOZlFqc0IzYXEwRWZOc3htZDBj?=
 =?utf-8?B?QlRvcWZzckFkdFVIVnJpVGdJNXU5aXZIbGpNUFJPaFBRTXYxVFJiNkp0Wnl0?=
 =?utf-8?B?UDFkL2Y5Q09OaTZMaTlKeDZrZDZQOHU5clRzWG5BaFNvb3ZTdnJWaXp5MnZw?=
 =?utf-8?B?aHlwMmhmSW1aWGhWREVpYnEwdDl6QVNqN3puNlhtZkorRDU5SG1ibjlWL0RZ?=
 =?utf-8?B?OWcxQjFjVkwzMEZMVmtUc29iTmlOdlVOT1NleHlGcGFMaUc4VkRpVjJvV3o2?=
 =?utf-8?B?bXlCQTFYK3JpZjBVLy81QW1NMTBYL0UrTWxudjU4TFBBV1RzUmlRR0hVMWVZ?=
 =?utf-8?B?ekp5K1N6L0MzME5EZ1lQMnF0L3Q5eDQxN05CNVBlZ2FEUkIydENwT0xYS3BT?=
 =?utf-8?B?cHpLZm9kbGcySG9hRnI4Y0NCS0JWa0hkdEQ1OTdMZjdNWStqeDZmeGtFSFpt?=
 =?utf-8?B?N0M3MFJmcFREYmNHbk1xWFJpU0VyY0phdDQrNzR4SmlGdEI4S0xTUzE2dzRy?=
 =?utf-8?B?T0xDOHNZLzF4ZkUrVGd1MFlOdVNOd1g3ZWp6ZWJ4eGt5RFBnT3VsQjlSOVI3?=
 =?utf-8?B?NWxLT1NFWG9qM3MxUFp4eDNURGFPSHFEYmRkR290RTVQL0I1bFJ5ZGE5YS9a?=
 =?utf-8?Q?sD4zjP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(366016)(7416014)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UE5yLzVvbUNIYjhVbDVqdWlJTEFvdmo2RDhIZmZETWVHVnl5QjN2dnlhNDRC?=
 =?utf-8?B?MTRZVGVpNFUyd25qYVFnRGtKcHdxMUFCRkErYkFobUdEQ2dzSGNKVkdtNStZ?=
 =?utf-8?B?MW9LRVZtM3UzM1lLRGF4bXRiT1VnT2ovcDZwT2NVWXpjUTJ2MHdnd0N6VGpm?=
 =?utf-8?B?U3dyYk5vUmcveVdtaFhOT1hmb3dnTWJuMmszTVQrK2VySk1sQTBLOHQxMDlS?=
 =?utf-8?B?K2w1ZGdkTHBmU0FpbS90dGZLUzA1Y2V5L1p5alByT04yWmZNd0JFdjREaGwv?=
 =?utf-8?B?RWd1UzhjenFTV3hWaFZQLzBNaUJsb05YbUJFS2psNi9ha283dVFiTjFaWWcx?=
 =?utf-8?B?SDRlT2hGdWREQ1dHL3NqWkZlUUd2dXIwZDRzaVR4ZU9hSFlCVm9uV2tPejIz?=
 =?utf-8?B?WHhJQnB4Q3BtTlcybDlybUx0UkFTaGJBbSt2RmZNcU1HeEdvUml6anI5bkZn?=
 =?utf-8?B?VGp6Q0xuQ2kwTlZHSktOT2N5ZFNrUkMvNUh6bzg0WWd4bTFGVGZHcWtTRmtU?=
 =?utf-8?B?K29pa3pnZEgwaWQ3YnZ6ZkhaTjdKRDJDaldHWGp6OEkrVndTKy90OHUya1JV?=
 =?utf-8?B?UnU3eWxJcllvamlXdmZvS0ZEWjZEMDYzU1NDUEZkVDNtWU1vM3VSYTZSZTc0?=
 =?utf-8?B?V0Eram5GelpuWENVUm41cVovazh5dWpFUFR2UkxNeThONy9NOFVIZEFkM0d4?=
 =?utf-8?B?R1hMMzUrS2M1amhLQ2JJUndhMWdZSHBWWDdpR3Q2Y0tXck5DejVTZUoyM3Bt?=
 =?utf-8?B?TXhDWHFUaTJZRyswWFVaYWJpSVIycWRJN2FiOGhIZldxZzJQRHZPdU4zSWhz?=
 =?utf-8?B?bE5iREVacVhCRFEzcTJRQWJmT0VQaExkTmNmY1VuRkJMLzd3Y3phL3FVYmJv?=
 =?utf-8?B?eld2NDczTlI2TkVFV2d2RXpndm93OXdkd2VhZHhPQlAyWnljbmpxVXljbTBJ?=
 =?utf-8?B?dlprcm5XV3EwN1U1RVBsbFBsdk9sMHVYdGxtdHk4c0ZwYTlxNVp6dHRhSURs?=
 =?utf-8?B?MFFFWXNXd2NteW9mb2V3VE1ZWE94c3Y0T0pLMU5QUHdsUHRWU3N5NTQ3VUVo?=
 =?utf-8?B?anA2QTduR2pJNFdmbSs2V2E3Q0s5MGtBaVhNZFNJcWoxWFhHbGdzVEZTaUt6?=
 =?utf-8?B?ZVcvc2pQa1JJOWUvSEtmZ2x4OWQrL3FyWXFzMmZFY01Ud2tUMzhuWjU1a0p6?=
 =?utf-8?B?Vi9XVm5CMlA0bWdsUGFWSExHK0E1K21Oc2M0SjZOR05iaUhUMHdzRGZmMW53?=
 =?utf-8?B?RVd6aE0wTWVxSEJZNGlqSm9wSzBkYlJYcW5DOGhucmU1MllzR2VWVndGMzN5?=
 =?utf-8?B?RVl5Q0RzTVZSQTRaVUdqL1VPT2NOZzd3aU54VjEwaWxHekE2SVlNRVdZdkhT?=
 =?utf-8?B?UktTaHlDSlFhR2NPZWVnd3hBazg2R0t3MU9VYjNLTHZoMzZzUEMwK0FxRE9p?=
 =?utf-8?B?MW9KcXpxK3FidkIvMWkrbXRBZEtjNzNBT0R4R0lHSUk0Uk82bjV5VWlFOUY4?=
 =?utf-8?B?UU9zT2FnNjRxSlVQd0ZaMGoxUHdZa3VwOGxCSWZCZlA0Tjd1bVB3NStQUGpL?=
 =?utf-8?B?Um8wLy8yUHJXNUtHeGM3YittSEdzRGUxZUNFRFMwOE4wZmJGeGtSNXpYMVRY?=
 =?utf-8?B?WkhhanlLM0VDR1crNjhVR2J1NklIVDlndXp1bEJ2UDl1aUhoNGRXbndnUjdy?=
 =?utf-8?B?Uy85dUcwc09DN1pNT3lyWVRXNE9LU0RmL2gxR0VHdFVZUGd6ZFJOS1VNckdj?=
 =?utf-8?B?ejhGbUVCTEJOMG9UTzlUZ2xJSjZZS3dXaWxMTjZKRDVFTG1EQmdLdzVqdXhw?=
 =?utf-8?B?RzVrUEpNQnZZclpOdi9najd5emtZWW5HVUNDQmJmVVM1b3c3RFFhM1NFZE45?=
 =?utf-8?B?RURhY3VyWHBHSlZiMVFLTmQ1VjFObkdicTN6ZnZnSUZOSS9hN3RNWlU5anh1?=
 =?utf-8?B?dDZ2NSt4Z2kxdjFYeW1TcDBXQTB1c1RpZnMzam01Tm1zSCtrcTI4T2k5N2tn?=
 =?utf-8?B?d0NoTkRpSEJxSW9EbEY2b0pTWUJNNkZMQk5hcVZMbEsxQzBwdklSWFloS1Nz?=
 =?utf-8?B?aERmSXVqWkhkenlIZlBDR1JsVHh3eXhlRkFmVmM2eC9pUmdHR2EwWlo4eGxo?=
 =?utf-8?Q?l1I8J2XJA4ywUsBwGxQGH/Ga3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4258c4b5-e637-430e-9cc6-08de15cc7401
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 02:48:19.8651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WDFqkq5xErnpgQJhkL77pX5xEgbIlom1vE/WWR2Nxrbca2pknNxeud6sUeniaurPsk4i4+4befLpxSu7JFFaJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7891
X-Mailman-Approved-At: Tue, 28 Oct 2025 09:05:24 +0100
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

This patch is used to enable USB Gadget in SPL to make i.MX943 evk board
can use SDP on USB3.0 interface.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx943-evk-u-boot.dtsi | 24 ++++++++++++++++++++++
 arch/arm/dts/imx943-u-boot.dtsi     | 40 +++++++++++++++++++++++++++++++++++++
 configs/imx943_evk_defconfig        | 14 +++++++++++++
 3 files changed, 78 insertions(+)

diff --git a/arch/arm/dts/imx943-evk-u-boot.dtsi b/arch/arm/dts/imx943-evk-u-boot.dtsi
index e6abe7ed2e0..3995176f090 100644
--- a/arch/arm/dts/imx943-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx943-evk-u-boot.dtsi
@@ -22,6 +22,30 @@
 	status = "okay";
 };
 
+&usb3 {
+	bootph-pre-ram;
+	status = "okay";
+};
+
+&usb3_dwc3 {
+	bootph-pre-ram;
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	usb-role-switch;
+	role-switch-default-mode = "peripheral";
+	snps,dis-u1-entry-quirk;
+	snps,dis-u2-entry-quirk;
+	status = "okay";
+};
+
+&usb3_phy {
+	bootph-pre-ram;
+	orientation-switch;
+	status = "okay";
+};
+
 &usdhc1 {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/imx943-u-boot.dtsi b/arch/arm/dts/imx943-u-boot.dtsi
index 9b2c1072366..8c89b8be04b 100644
--- a/arch/arm/dts/imx943-u-boot.dtsi
+++ b/arch/arm/dts/imx943-u-boot.dtsi
@@ -199,6 +199,46 @@
 &{/soc} {
 	bootph-all;
 
+	usb3: usb@4c010010 {
+		compatible = "fsl,imx95-dwc3", "fsl,imx8mp-dwc3";
+		reg = <0x0 0x4c010010 0x0 0x04>,
+		      <0x0 0x4c1f0000 0x0 0x20>;
+		ranges;
+		interrupts = <GIC_SPI 386 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		clocks = <&scmi_clk IMX94_CLK_HSIO>,
+			 <&scmi_clk IMX94_CLK_32K>;
+		clock-names = "hsio", "suspend";
+		power-domains = <&scmi_devpd IMX94_PD_HSIO_TOP>;
+		status = "disabled";
+
+		usb3_dwc3: usb@4c100000 {
+			compatible = "snps,dwc3";
+			reg = <0x0 0x4c100000 0x0 0x10000>;
+			interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&scmi_clk IMX94_CLK_HSIO>,
+				 <&scmi_clk IMX94_CLK_24M>,
+				 <&scmi_clk IMX94_CLK_32K>;
+			clock-names = "bus_early", "ref", "suspend";
+			phys = <&usb3_phy>, <&usb3_phy>;
+			phy-names = "usb2-phy", "usb3-phy";
+			snps,gfladj-refclk-lpm-sel-quirk;
+			snps,parkmode-disable-ss-quirk;
+		};
+	};
+
+	usb3_phy: phy@4c1f0040 {
+		compatible = "fsl,imx95-usb-phy", "fsl,imx8mp-usb-phy";
+		reg = <0x0 0x4c1f0040 0x0 0x40>,
+		      <0x0 0x4c1fc000 0x0 0x100>;
+		clocks = <&scmi_clk IMX94_CLK_HSIO>;
+		clock-names = "phy";
+		#phy-cells = <0>;
+		power-domains = <&scmi_devpd IMX94_PD_HSIO_TOP>;
+		status = "disabled";
+	};
+
 	usb2: usb@4c200000 {
 		compatible = "fsl,imx95-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
 		reg = <0x0 0x4c200000 0x0 0x200>;
diff --git a/configs/imx943_evk_defconfig b/configs/imx943_evk_defconfig
index d308d29a1a5..e4fcf2eb576 100644
--- a/configs/imx943_evk_defconfig
+++ b/configs/imx943_evk_defconfig
@@ -100,6 +100,8 @@ CONFIG_IMX_RGPIO2P=y
 CONFIG_IMX_MU_MBOX=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_FSL_USDHC=y
+CONFIG_SPL_PHY=y
+CONFIG_SPL_PHY_IMX8MQ_USB=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX_SCMI=y
@@ -114,5 +116,17 @@ CONFIG_DM_RTC=y
 CONFIG_DM_SERIAL=y
 CONFIG_FSL_LPUART=y
 CONFIG_USB=y
+CONFIG_SPL_DM_USB_GADGET=y
+CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_GENERIC=y
+CONFIG_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="FSL"
+CONFIG_USB_GADGET_VENDOR_NUM=0x0525
+CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
+CONFIG_SDP_LOADADDR=0x90400000
+CONFIG_SPL_USB_SDP_SUPPORT=y
 CONFIG_ULP_WATCHDOG=y

-- 
2.43.0

