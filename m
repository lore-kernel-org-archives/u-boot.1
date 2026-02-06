Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296DBECD9BF
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 03:11:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EB7F83AA4;
	Fri,  6 Feb 2026 04:11:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Wvqr5oom";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A29DA83B1E; Fri,  6 Feb 2026 04:11:12 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F4B183A64
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 04:11:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZ0wR860QqSCZIdb8xISvv1Ht2UX4fjSERKwKdB203tVZb2K2Ggvrmxw214rcnH4H5aAd2/p5D1oMWsG27uwlvKZyAYWr8pAl6lfQWz029mKPMdZJ7nGyi+yghCjnHEw/zDOZhf8ijT6abKIGB8xFZMnRLUN5/IISeqoSshBrej7tES1yi2/YBUKC8LJTslA2weVNxryo8Za/1w2WrXtmCDp4OmpAjhmPZ2cV4E/JNYusNrs+dEhRHEhzHJgINl8ENKyg3+xnTaJCaYVQHwaovrgkvspR4kUEZFBwF8ww9yAZadDhy8YTuCLUKvXYLFEpQGzlfzTLVFzkICCAHzakw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObHnutvVqEUxek5UcoLtLBmYwR2Jqxd/T7/Vy1zYB4A=;
 b=y2l3ZE49vrqvbfXXX4uJRrXkBv8PaiN0L+bFN7OJjsT3/zQkLfrfwuPyF5GjgIWxgt0IFoReLnOhgXzMeF/YnCnOv1+hr5XEFdRFwdajWNsVt5tiPYRCzlTOrMuNhdEy54gzegNP78cSHY4YhAVtfApkKk0o1DrGT0utEit1AbgOGdD/2+q+sNHHhuXiLbnYs69ChF98uPzXvSQmodu5Caynqd1Py4yINiS5dClza5AKUUcjDK6BgM8uF9V1VFIRttHll7+Y4j4gqKa2VbkBzvVT+6W5ZAzR0e7N8VBChWhXZaifi++RvH4e0CT/5HcNLHH8fPDujUl6butQ6bBsxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObHnutvVqEUxek5UcoLtLBmYwR2Jqxd/T7/Vy1zYB4A=;
 b=Wvqr5oomqTQ5x7i9lf2DJa5dCC3wM3kp44fyQhizKPCpFRRAphoR+iAf0cjNJg8kuDcN1wtgWoGfSJxXcEOOZbdFwrw1Kq1t4cNo9ZFRE8Ez/tXqtj5/c0L+TF7YWpOHwiraR88V956R4yGW3/iauoPQqNrdExocrGj/3x1qiqfsXmKO755d1Gts9KlBdNNALH7TsxKlD4oHqlSaj7hjT7yTg7d0uQunlFRxtd0BhusT7wvLtF143MWCp28lK60j7t7yBe+HMlxgEb3bWWW7czBadJ8sc+HWvW4aTV8336zDkTFsK4lhdKUrzX7Bnhrxx1BRwGj5oLpUEe/wqT4WuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS5PR04MB11419.eurprd04.prod.outlook.com (2603:10a6:20b:6c4::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 03:11:08 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 03:11:08 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 06 Feb 2026 12:25:43 +0800
Subject: [PATCH 2/2] nxp: imx94_evk: Drop init_uart_clk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-imx9-board-clean-uart-v1-2-3965b4e7f79d@nxp.com>
References: <20260206-imx9-board-clean-uart-v1-0-3965b4e7f79d@nxp.com>
In-Reply-To: <20260206-imx9-board-clean-uart-v1-0-3965b4e7f79d@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Alice Guo <alice.guo@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS5PR04MB11419:EE_
X-MS-Office365-Filtering-Correlation-Id: 131f4822-a056-457d-5bee-08de652d5fc6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|19092799006|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NVk4dy9zRXIvbFN4VVdIOTNESGFRcUFSM242SGxXUWFZN1lnZlVLYVdkbGIv?=
 =?utf-8?B?VzE1MGU0WVZnbkFXS0NzS2pDbWZWbldpK0lyYXExRjVkbnhrUnBXc1VIZ21h?=
 =?utf-8?B?UG9XaGNQT24vU3Y1bll0SWpmTWVQVTJYdGR4aHZzbEd6S3NNcUIwNTUxVWs1?=
 =?utf-8?B?ZGh1a2hSS2Y2OGloUGxLSnZUSTBUUnVVWS8xMitzOVpjbmZ6d2tUQ1JHVHdI?=
 =?utf-8?B?V2h3RnZRQlA4RnU4cElvZ2hvM3JlWWRSZWhxM0QwK2ZjQlZuZTZWNUk5NWtV?=
 =?utf-8?B?ZEJOZ3VSSHhCejlzUldNNi9haDhuUThJUXRTaTBuNFZVSU00VHlxL3lncG1h?=
 =?utf-8?B?Wi9RN0NkRWFXZTVXR0tJcHZsYzR5cS9wclNzcU5hZDI0cUF0UVltTUhJN1VY?=
 =?utf-8?B?cDI2TGFjWU9HYkFBQnN4aVN1NDlQMHNFQTgxb0o3RkYycXphOUhJb3RuSFNC?=
 =?utf-8?B?N1Jkb0FaQ05zRHVvTHN4dTBjdmJIN3ZtWXJzQ3c5L0Y4bUo2clY1Tkt5Z1la?=
 =?utf-8?B?VGZPLzlpT0xlaG00RVUxaEpVSDZvblZqcU54QVliMzdlOU9qenpvYWJMaWNY?=
 =?utf-8?B?UFFUYUF2ejJuZEtQWEQwQjlBU1RoRUVsNnRLUEJmLzc5aC9uekVhREtLRGFy?=
 =?utf-8?B?VlV6Y1AveDJNNnVyOU5PNnVGM1c3MEZUTWFvRTZ5OTdVTkpwMTk5cnZPMUlS?=
 =?utf-8?B?aUdSazRrcWNxQkQ4Vm02U3lvelNZRE8wcmRyMEU3cVgwSWMycnBoTG5MMXFy?=
 =?utf-8?B?TGlueFp0Q0c3Ni91SnE1SDJNVlk1U3hBNXFzd3VTZkJuRFZiOWJkaXRIT0Rz?=
 =?utf-8?B?NmZ1aXc0UElCenZtTmZKRVl2VVN6STZ5WVJoRmFjQTFETkRiRG9pLzRMdVcw?=
 =?utf-8?B?VmxqTkNBaFNORU1ZcnovWGxmMWJqN0JnbXdWZmgvaVViZUNJRnBQVmJKMUNR?=
 =?utf-8?B?UWJSbWdhTGNCdkZ5dTBuMGNQUDkvTGEwaTdBWTFuOFpmWWk4YU1PZUlnV2pV?=
 =?utf-8?B?amdmZkMwSDExNkwzWnpiNW5rUFRDSTNGcldJQlBtVVZjUXhQV0VIbFphVVJB?=
 =?utf-8?B?dFpoMEI2cytHU3RHTFFBcjN4NHdZUXZCQXhoVTl5Y0JoaEJzaDRZbTZseEcw?=
 =?utf-8?B?NWMrVUVhMS9idUZxR1F6SUR5TUZHU3VUd1NNTEVUcW9XNjBGSDVKc1JYRDNT?=
 =?utf-8?B?ZHBHNUlhN1R0WU04YnBmcE5PZGMxUittTkV2bDZJQ3Nna2JQY1BnWW1CVW41?=
 =?utf-8?B?ZEx0QmRrWUwxTFRUTUFaM2xaMEtGN3VOVG8vTkc2a1FZQ2xhKzlHQmJpYVM1?=
 =?utf-8?B?VUQ1RTlJaTM3M1Z6ZzBEM3pNYm1lNFdrMGJHeUtaeTVZT2E3K2VELzErTUhU?=
 =?utf-8?B?ZG93ZXJYbkIzaU1weFdBaWt4cXJTVTArTXkyWXhmaEl5REFqUlpLNi93MkFw?=
 =?utf-8?B?anBDUFpmenRxYzFlQnJrMXpCRHYxZDIyWXh4U3hzd0J4UnBLUGtaeWJOT3VK?=
 =?utf-8?B?TFBWdVpwY2tlTTRrNUhNRmdwTVdjK1NVaUFGdEEvZU1OaHc3TEwyek9FeGNt?=
 =?utf-8?B?M3lXSk51aTBQUVcwWmRtVHlHdHhkT0VCZzg1REhlMCtsUXBsQXlHN3NDdm5G?=
 =?utf-8?B?ZGJWY3dSKzlIR1QyaXQ5ZmIwTHRtOUpJOUNvN3diNDQvNVdHZzkxR0RoRU5X?=
 =?utf-8?B?NmEyWmIzYlNqQThWZmhELzl4YzNuUUNuQitzV0FqUm02K2ZRVjlUaFdXaTNi?=
 =?utf-8?B?SFk4aFVFL0R1Mk5HaTUxZDFqT2txSXo1VjlvVXYvaktUUHhBQnNyd1lLYm5W?=
 =?utf-8?B?My9KSFpzWkhMYzdIWTdwcWprUWNra1RscjByR3N3Y25ueExEWm9CQlNsdHFt?=
 =?utf-8?B?bzNzaG8xMkhJdU9MUXlJRDd6L20vK2Q5NkRyWE5qTWFmSnpwSWNYRU4xZGg3?=
 =?utf-8?B?Wi93MkZZSldHYXlXN2FoV2NxazN1Z2RjNmVrdnRoSSsxb1U1ek1Fdkp3VnVQ?=
 =?utf-8?B?cGVDMWpUYUo3QVhOeG96MDFsT214bEw1VHVKTFdpc2hZMUdyd2x6djdTbG1D?=
 =?utf-8?B?UGFZbDRqMlM3Z1RmTUZTUndzbTcxY0pISDFLdEFFYVM1N3FpazJZc3RzSEE1?=
 =?utf-8?B?aU55bFhjQk5FY2NnSzAxRG1oMFhTbVVjd3Q2djBvbS9LcGhGVVdMU2FxNzBZ?=
 =?utf-8?Q?mB/H/JhnB0KU2D3aie01TCc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(19092799006)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnB6Z0hoeW01UTAxWVA1K0hJdTVoM2hQTjJHNno4MWtHbGFyc0ExUFFSM1g1?=
 =?utf-8?B?bFN4VFNMNFRCQ1ZkYkFEUC9EV1Vodjd4ditOUUZBTWhIblljVXEyM2NtdGc3?=
 =?utf-8?B?NktpSGlOMzE1NFBoWFNGbjZWUkYyRHZoSkNHY2JpNk1RN0JzRStTenNiQkZ6?=
 =?utf-8?B?aHo4elV5cWkxTUxYZExvaWdjTGZ3MHBXRDY1TXY4ek9qbG5KWVc5RUJjWk1Z?=
 =?utf-8?B?M3B3ZUtHZERxeDFEWmNidFRHazdpR3JETGpVS3o1UEcwKzN6MEZxaGMyYnZT?=
 =?utf-8?B?cTZkQW5IL01kUU9SbUZXOTA2NWo1MTBuR2UzUlNhNGVaWVg5Q0FiODg5M1Fu?=
 =?utf-8?B?c241bDRKaWhteEcva3Yrdm5jZEgwZ05FNWs4ZHUwWS8zNllzUjhUUWFybmhD?=
 =?utf-8?B?QUI0cEI5aDlJVm1UcURCTGpUVU1ST0p3Z3U4dnc2V0hFdjFkUWFhTG4vNVRJ?=
 =?utf-8?B?TXBVdEdwSzE1RWkvMmlsZDEyTzc5U2ZtUmFqenlhanBHUFN2Z1Z2N1gybGJh?=
 =?utf-8?B?SkVUdkdaRGYvbG84TXdzNVlhaTVYenRucTFaRkE3aHkzU2ROTzVxMnpST0ts?=
 =?utf-8?B?MkdzbHFON3hxVEc3MmxQc29iMUIzdFdwRmZwQWt4MkZnNE5nZ0EyeEwrNEx4?=
 =?utf-8?B?cEwzdWVud0hHZkpjS210eCtLVllWZnM4ajhMWTFWeDNubHJzTFZhemxkdXBk?=
 =?utf-8?B?TFhKb3BhNXB3VGYzMWUxV2pXMlk1K05UTXdrYmRIMUljS2p1alBET2VMcXM4?=
 =?utf-8?B?djc0WXJnTUhQOS9lMnhJelowZUdqTlVWdC9NR1FmV2VZL1FveDAzd25OU01S?=
 =?utf-8?B?ZkJPNVVzejR3NVp0WFM1NE4xaktldUdvT1RBRFVubHlvS2FWbm9TSzhlZ29h?=
 =?utf-8?B?aUlBaXk0MTI2UmMrdG4zTnZWRWwxdHowOFJRU3BMT1FaL05Gb3dTVkVJQUc3?=
 =?utf-8?B?cE94dWowQjNlVkZIRHE4dmE0ZmQ2dDVNSFd6WFQxR2Q5OWFpQWVFbFNrYUN5?=
 =?utf-8?B?NVF1ZjdST2VnTnVCTXkxaUtDM0tIOENSV3F1Y1Y5SnhhSVhpVEUzRWc3M1pJ?=
 =?utf-8?B?NlNodmxEbXNoL2xiMmhnTGw3bk93Q3RMVG50Z1J0Zzg3ay9QSzhId0pRZi9M?=
 =?utf-8?B?Vmo4UVNiMFd4SzhMUFVNZ2tuSlN4TldEYlN2KzQ2RkxqdzZVd2l2b21qc0VV?=
 =?utf-8?B?WnFxU24zUHRTVHlyWWNYbFFIeFFtdDUwdmQzdTdObnBnb2ROUTdEOGNSNzlL?=
 =?utf-8?B?a2JSWmU0SFBlekJhQytwVWpvR1BLbVlKNHBHTVpPT0VqajNsdG1aRmp0dmcw?=
 =?utf-8?B?RHplUnNhYmZaMU1aOUd1TlFGZXRvRTBqaStXbE1uVFZtUzRpNUM0c2ZscTli?=
 =?utf-8?B?S0IxaVRIOXh0MDQyQUhBSGJrRVQwODk1bU9LV1dHcVZhaTc2SlcxNnVnbzhD?=
 =?utf-8?B?UXlMZ1RhdUFFZmNZZXNScGJCWjNQMk5EZEFRRVJsNEVLMGEyMkZhOFlaZUtv?=
 =?utf-8?B?UnVRcHNTMzRha2xtVlVDZDBRWEsrVUtNRk5LWGloSklwNlJwR2lkM2grNXVU?=
 =?utf-8?B?cjdjR2ZGNkhGQVRTeTBKeVpWMlplbDRqVjU5SjRrQmJFSHZXNjJDZUk3VWd0?=
 =?utf-8?B?SG5rSENjWGtPci9Ucms2bDZXU3Znb1Z0ODZiNzlIOFEyTjBqWkxpa3QybTlZ?=
 =?utf-8?B?WVFrN1lLcVBpVVB4L2kydnB3b0JXOW1ocDFIZTAvUnN1dUlBSTFPclFZcmZT?=
 =?utf-8?B?UHlhanVXdHllNzlzV3BhQ2xVeFo0eE5ubXp0SkJUVlQ3cGdOU2RXZlR1V20y?=
 =?utf-8?B?Wkp4QzRWZ0JScVNhN0o3N29VODlxRGxMcVhGZC9QcUx2VDk4eHRaNU5MUUlG?=
 =?utf-8?B?SHNkcm5HVENuMjRYRDlTbGJwZkJENXVyeno5U0tGdUI4bE5EMElwWE5ySkQr?=
 =?utf-8?B?R0ZjSzlxTkN2VjN5dXBGeUlzSHdOVFNiWDluZEdhcTZHdG9taG5vcW9kS2ZV?=
 =?utf-8?B?TS9xM0RqcjRERkNWTllSVEhid3FtQTU5TkR1bTBPSk1sdlUyRW9Zb0JsMlVr?=
 =?utf-8?B?Z0hYZEc0dFR0M2FkOWtSRmJiOEd1SE0rOUFQbEpjN2dRWXV0cmhqODVQSDh3?=
 =?utf-8?B?d0F6SmFTQUlESFh2bXhsa1pYdUU5b0k5QXRkZ2JMSmJhOVVjcm5iYnVZUjNh?=
 =?utf-8?B?Y245eC9YUmFFbTdpbEJkVnpxTndjNFdwV1JXQ1F3ZGc5ditUTTB4M0FPazIw?=
 =?utf-8?B?dS9FWEVUcEVwV1RhclY0QmpXZ2R6anczQWZrUEhoMTIzNEFhR1N0bEU2VmJQ?=
 =?utf-8?B?Wm0wQmlSeWVISjdrb1FlVE1YZlFzTXIzQWRYK3Y2OFRyb0R1T2J3Zz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 131f4822-a056-457d-5bee-08de652d5fc6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 03:11:08.9137 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vm755TbBxpEuvGkOD+GYW3jiUe+rwph8Y85j32eKEgiP3fBswKEo3ygZ3lzg/7RNtlGCmLxwjkrh9lOBG0cxaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11419
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

Rely on serial driver calling clk_enable to enable the lpuart clk, no
need to do init_uart_clk in board_early_init_f().

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/nxp/imx94_evk/imx94_evk.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/nxp/imx94_evk/imx94_evk.c b/board/nxp/imx94_evk/imx94_evk.c
index 588aa7548d4..dafe680edbf 100644
--- a/board/nxp/imx94_evk/imx94_evk.c
+++ b/board/nxp/imx94_evk/imx94_evk.c
@@ -11,7 +11,6 @@
 
 int board_early_init_f(void)
 {
-	init_uart_clk(0);
 	return 0;
 }
 

-- 
2.51.0

