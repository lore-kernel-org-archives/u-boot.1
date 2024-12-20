Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C52FE77184
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 02:56:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A36580291;
	Fri, 20 Dec 2024 03:55:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="htG7H7sB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33D788021D; Fri, 20 Dec 2024 03:55:52 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::62a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB197803F0
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 03:55:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hMNzOpoSF803lf201j5DGzOj8C/b4SKT3PmWIWAT7kLjmaYpK4UtLq5lubIdp8hkbA5MQED8fGedFMcWSXp1TkxADeq5qdj02QP33oR75vXJosH+M0S2T74nOBR8mlVClREktoISiw/FUcJbYxkTe2901yZdwLA2g95mneFPDQ65lC3W579ABpeQzd5WTK6F2CQM6/lhfY05451Ee2UHq/VWMGmszYGOzROqWcUPKNfGRJm5iZgW+Cgfhrl+qkmORk7MmY8Sg4GP7Q+tMI5VZzjyGWlY4aILmr1LDO5Hz+mcXhY5LtKs8xQQIyQh49V79Pt9znSkefiHqr1DhRzAXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3U8wfdNPzExHN6f4s/lmeRIWv9K5RqS5JOkb4aiq1DI=;
 b=Fu407YXTL1ICOeAE7a5Kx93gFCiUuBf+lkXuTHnVK6wuOPYfNBXlrmjO23bovebsEgtMypv6AobeX5n7JXElxaJWrNZK/eJxYoeQb3BS1mEitgbWc1ArhybJpT38dODk70g8vBCtdT1K85lcyww8vSY0j9bESpAemNuXGbWCxf9xD6HymusOxsuhuJ72TqYj/x4Uvss6QEwgMu8KX48+qenDPhtlDp5FmGREmFU1QTH5Gi7Rv17Odrn+wiOvjFVEaLbrNP90PAImhgTqbhuRpch9Gul+4A6HTCxOzMOeoESLSP3M9HQReP7XqeMNmJ5kICwMTYFhRdkOUi8jj0B99A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3U8wfdNPzExHN6f4s/lmeRIWv9K5RqS5JOkb4aiq1DI=;
 b=htG7H7sB4DtB/5Ar2o4xbs+lrHiWbjASvuv5PoRsCPvV06hKPfd7HRTDpLS5JyFxXGc8vC48uiFTojvdu0t47JCMoIZ6xSAxWfNv4MLl9tqDyTxeU5/zazBuJrqYZg6sMWxhv8UXPwQtK0F1h9oioIuBwIet86gbI60oxRxNi5CHKUIa5dympRC6mluAnHtY8O77+IUGJKcVsfVAV668hpIHFBwSKMFMFDSdxAoaQn3qSHr2cDyd0fjsdkZUQX+FJqQEmtVqrkt+jviK5jMXDvTuRSYbt8zeLgWGLkRUJGS64+IcG4y7enLbudmciwW2TxYxwlE3Ovumf+ELhj8DSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB10981.eurprd04.prod.outlook.com (2603:10a6:10:58d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 02:55:48 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8251.015; Fri, 20 Dec 2024
 02:55:48 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Fri, 20 Dec 2024 10:55:09 +0800
Subject: [PATCH v2 11/17] imx9: scmi: soc: Override h_spl_load_read with
 trampoline buffer
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-imx95-v1-11-ba81dfd8e369@oss.nxp.com>
References: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
In-Reply-To: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, marex@denx.de, Alice Guo <alice.guo@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734663311; l=2986;
 i=alice.guo@oss.nxp.com; s=20241220; h=from:subject:message-id;
 bh=0SWAyUnu8lenlnzbPKA7zXinH3rKLf/eOt49NBp9GjE=;
 b=AqckVYqyggRtUMmixQXN75YdPYE+GToGOGfcA6P5rOxW9Pr04Y0mjk1/+47puSaj+PIT6mC88
 cAwUoyrpoLTD4lCavddVqxF1diNfPN42cAE344KXscvl0iHnQN3inYC
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=I4wA8H8Q53tsp7q3voqI5LHsTQDw4TELC8szgsg5azM=
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU4PR04MB10981:EE_
X-MS-Office365-Filtering-Correlation-Id: e540f445-6dab-4892-90d2-08dd20a1ce87
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXZleDBOOTZLbnJmNjUrT3ZRZzZnSS9LdnhYa3RjRnFSQ3JSZFF4WXlBUDly?=
 =?utf-8?B?NU9Fb0VOTEJBYnI4VjZlazMyWHdhZmgyK0NMN1Y3K01EZDB2c1NHSHFaT25B?=
 =?utf-8?B?TzFhLzN5bk1ETXhxRzZzdnV5SGlsOCtQYmZ4OUI5b0hOWXAzNXRCMGVGZjlJ?=
 =?utf-8?B?b1gzb3FzUmxwdU5yWUZ3eS9uRWNpbStkZ3haSEVYQ0xFTzl6dWtkWWthOEcx?=
 =?utf-8?B?TjQ0c2gzeG9JdHVuRFpaYXBncWlJSjQ4OUtRUTBLajlqbVZrWFl6ZFExYWJM?=
 =?utf-8?B?Tzl5ZEVHM2lQR29vd2FXTTNJOFZlZG9FUTh1YndBKzYyZ2J1ZkRSRWNDWDlP?=
 =?utf-8?B?QUZ3M240UFA1b1ZsaXhpZVlUZkpkYStwZEcxTGVIYS8vU2JpaGxVU08xbjJH?=
 =?utf-8?B?aGdXeXpmK0NqaG92M0NNbFI0MHFLQ1BzMmhQa2lpeDRFU0p5OVBHa2RFMlBh?=
 =?utf-8?B?OWY5R1NqQTF2LzU2SU9YYlhPV3BJcS9yUDZBT3dNLzh2RUdJb2JHSUxsL244?=
 =?utf-8?B?Z0ZQbXZOQ3RZSk5WVHZuY21Qdmx2Q0ZJNGNNcjY0VXBMTUdTUXhlU25mQ3h1?=
 =?utf-8?B?aUJCUU1qSmdCejJ5SVcxejFkelZmamVyT0tVTmkzQXA2QUU5blB0S2dXNnJx?=
 =?utf-8?B?aVdZS1kyL3VoR0FMTjN2R1FNT3RtMEVidmFBSUdIUlFrbCtOR3lyNk5adnN5?=
 =?utf-8?B?OFhBNGJ3RnJpUC9QSFNvZVJIVmhmcTFmZGJBWUJGOHl3a2M2bnBBYzVQcVpH?=
 =?utf-8?B?Y0lCTXk2NE55NENITGlNRUcweDF4ZjNTdlJRRjJHdGJmcUQ0ellScElpbGpG?=
 =?utf-8?B?Y2lWLzhkNWFjcGpyZnUvTUtlUXZ4aTVvSllaM2xwbkw1UUJZNGlRaWEzamxj?=
 =?utf-8?B?VlJGY0FPOTBhWlQzbEkzVHNQREh2ZTR5dWZYUGtlenFrcFhWUFpweEZtNTgy?=
 =?utf-8?B?K25DVmdWMG41SjdqM2pIdXdIbGE3cDYxWEU2MlViV1BuLzQwaWlhMS9VckE1?=
 =?utf-8?B?Y3NZVUlReGdXNDF6WlpkUUR5elI2SGthV3dVYTBkS1lLNTZHRFozc3laWlFR?=
 =?utf-8?B?cmdWOHhIdzIwZERUdTBEdWV4MmZ4SFk4eGR0aUdYZ1ZZc2o0VHlKYUM0dzBo?=
 =?utf-8?B?eEUwcHJUYTNQSWVjM0MyUUh5OU00M2Q5S2taNmxNY3dLcjF3T0FwdGh2VUEr?=
 =?utf-8?B?STZaL2FaZXR4bTAzS3ZuZHlFWWVmU2VNeDhIREd4MVlBM3IzQ2M5a3VTa1Ni?=
 =?utf-8?B?SE5QMkI5WjBLeWh3bjMvZms4d1dWaGEyYS9KdHZaQU1hemNJTjBDdmJxdmFC?=
 =?utf-8?B?YXhlaWVrdnVUYzJqd2h6TDFJQS9SeGY2QXBmc24rbDljbGJtUm1McStPb1M3?=
 =?utf-8?B?ZHB3c1FleFBaeFJnaXEwWVAvRVFmaG1aZ1ZaV0VKN3lvdVhNbDdDbGNoUjZs?=
 =?utf-8?B?aGxJemRPUlpmZFpYWmVDNVhRR1I2dVRpSnIvSHZ6NWRmZ0lLcDRLU3I0bW9Y?=
 =?utf-8?B?ZXljajBqMEhYeUdkRjB6ek5udFF1WVdibUZqV3U5bU5ZVGdvUUpVWEpVWURX?=
 =?utf-8?B?TlhRS1hXZmNHc3lQNDNuK1VmRnhiN281YUM3QjJLS1FoeWdsbCtUazgwMWc4?=
 =?utf-8?B?YnVWMi85UzExeHU1ZC9EY0kyNjRlNWJtd2VWeGlFSkw5YVVtRFlib1dYZmJt?=
 =?utf-8?B?dGVKOFNnWXIwN0RDd2tnNGd0OEJnWkc3RnNSbTdIR2IxZkltQnovWTdMQjBI?=
 =?utf-8?B?My9PQ1JMMVhPdWJ4YjUyY2pnVUljNUhPNld0Nk10TzNSNldqMk1Od2w0Mk1h?=
 =?utf-8?B?bU9lWloyWWltdjgrTzVibVFTNk52N0ZUZ0dJZzE2YUNXMVE0UjUrMHVIWkF5?=
 =?utf-8?B?cUNvMHBmVHhOWE52aFcvVXdyTjZTYUY1b1dJV0ZZY3VIaFBvRUM0a2MxZGR6?=
 =?utf-8?Q?Wxqfx99H2AAVf6Fv9AFgSl+G1pvuQPKs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGtYczlNRUVFYzhSSko2ZDhydFBMT3lLcUJFb3liT1FPY2ZWZFBFMFFMaEhQ?=
 =?utf-8?B?N3NmaTNYMFFRNVZXNHplUjZZRHA2QTRrSUZJeFl6ci9TUWhwVUZqbFlkbzlJ?=
 =?utf-8?B?aG4vcThiUThtcDZ6SENzdWQ1bEpEd2VDREpFS0thUks3ZkU1SHQ1K094azNw?=
 =?utf-8?B?TlRVYWFGS0p3TkNScUFpUXlTbjNpVWVRVHhHcmtTNy82TlZDTEVCeTJYYnR4?=
 =?utf-8?B?V0dkYkoxWUZWcG9vSHFtRU55SGJUMUMrVU9vS25TZDdYSkI1dW44V2hrTGs0?=
 =?utf-8?B?NHdCdU1MTnorZjZOMTkvSU5HSVQzQ0NJQjhvS09pMlZWNnpEeGtoOGNOOVAz?=
 =?utf-8?B?bjQ5SkNtekxrZ3RCeDdCSWRHMEt6ZVNaODRRc0J5Um5GL0JqQlFsY2xLYjRF?=
 =?utf-8?B?WjYzeHNVVXY4Wkl0QmhIbGFiOFJLc0lmQmR3Nmx0ZU9Bak96c1ErS0lTMzR0?=
 =?utf-8?B?UUlpajRuTFhkMGFyUVJzQXd6aDlvTFhmQXAxZVk0M0d0VnRaeGRzSU5MbGRU?=
 =?utf-8?B?YUhsYUxqYkdSWElhait3R2ZyZVNpZDZDeWtRSldWMlVxMWtTaGpWT2tIS2s1?=
 =?utf-8?B?dmlZcm01ZkhSNU5FYUloZUZ1SDhQYVg3aXNyaHFRZDVVRkRPMzcra0NNTU15?=
 =?utf-8?B?dytJT2ppTGVQWGRqbEZQajVEMlcwVEhWbzF3ejNFY0FjQUN0MnphUXYxUlBB?=
 =?utf-8?B?TkdiVno5bHhJUVFKYlBzNkVKS1NTaWtWU0pEUHRhOGpraFlTQTlDNG9NVmFj?=
 =?utf-8?B?VU1hZUJWVkJGV2loS0JJRlZYSHVjeWRRVkltUWcraXg4dE81NEtkVEpNKzFD?=
 =?utf-8?B?TW80MUI5TEJTUG1SUFY4bjBmSFYxQmFXWHByakttNllRWnhPR3pXTjhQY3Jp?=
 =?utf-8?B?NkF0cVJ2S29URlA0NHpFd0pMSjVHYlh0RFd5dUdGSFJ0dXpKbGwwRDRGbjMw?=
 =?utf-8?B?Z3lFN2hudTRIcFI1MnRmdkZ1Ky9WWk5MazVLazhQeWh3c2dkcmg0WWtVcFQy?=
 =?utf-8?B?a0plb1Q0V21mbEd4Y2VwaXdsY01PV1JVcmJiUFlmY2QvOUl6WXVDM3NhWTlh?=
 =?utf-8?B?b2docjBBOEhzVjkxZjM5a2l0bzFsQzdUbjMzblFsSUpBSld3SXpvY2hMNFBS?=
 =?utf-8?B?OTZLd1pYdXZXTjBwMHFqK2V2VWg4NGZBYWtCVjRLTzJVVkZLZ0dTdThvTEdD?=
 =?utf-8?B?SU1OZDVHNFNFN0dsVFh5dEJQOGNZbkdZOUVkUDFKYTBXdnM0Z296YVB5REE0?=
 =?utf-8?B?UjI0d1lQU0s1cWJ6d3U4VTdOUC9mV3dCTklHb0RCeEdsalhMR3lXa0ZVSldJ?=
 =?utf-8?B?dVc1b0tUakhEb1UvbTd6d2FBWUpiR05sbDhmWUsyeEdCeGNpYUtZeDJBVHE5?=
 =?utf-8?B?b2owUUphQktYSEtHRDFRZDJxUllVRU5FaVEvbUo5TEhFWStkc00wYVE4RGpB?=
 =?utf-8?B?bjA1UUZmNm02dEd3WXFnZnlXYkZZUFQyOHRFZUgreTdiUThHaWluZjhWUWRR?=
 =?utf-8?B?UHE4bEtWTXdiaXE1cXlpU3VIZzU4TnU1N04rVmZDTG5lcnBySmt5d2I0cEs2?=
 =?utf-8?B?Tm1DSnFJbElsbHViL2VHSWtmWVJuK3V0S3lTTTVjcWtPVjlEZXh2Uzk2WUdU?=
 =?utf-8?B?ZUtrdzR5cGM3ck90ZjR1UE9adkpGZmYxZGtkenR3RlpzdXhzdVVEUjhQRkMz?=
 =?utf-8?B?ZjFpQ2JxbG1NdEU5bVpYdFZOeG40cFIzazZKTGtVNE9tZWVYVWVSY3JxOSs1?=
 =?utf-8?B?bGI0TmhvZHBUbEZpUFdURzk5OWw2Uk5IOXp0M1cwYXI1dUhKM0Y3UFdLZ2Mw?=
 =?utf-8?B?Q0c0NGM1K3Y1UnZhdHRPbk9kYjlwSHc1NWhEUzNiTjhiSTBlclBnR3phdDMr?=
 =?utf-8?B?cWR4RnNiWWp5cEliN0lGVkdyZUlvTFlYTVdRL0xrOFNZSGl5ZmZWMytoVFc3?=
 =?utf-8?B?YVhPL1p6L0szYU5IL0FpMUZqVDZLQ0swM01lNmlKZVd6UWdhUDNXN0h2UldW?=
 =?utf-8?B?bnJRSmF4dUsvVHJmTkJLb3h2WktqNVpaV3VvbGllT0VXYjRURUxxNXRySFZJ?=
 =?utf-8?B?eTN1RjNGVXJrWnFkMytLbHNVVmExRHVlbXpiZ21KclRNc282YlZqTnpnMzBB?=
 =?utf-8?Q?asnz3pcSIagb/xVm4Vh/xw/74?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e540f445-6dab-4892-90d2-08dd20a1ce87
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 02:55:48.4431 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/hNzZWRNLlJl2t2KR5x0d0woEc8EcLYkb1Ig/i+odTEin5z1B40fXp0J2PP39bNVeobmpJ/9JvbEVZbr3OP8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10981
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

From: Ye Li <ye.li@nxp.com>

When SPL loading image to secure region, for example, ATF and tee to
DDR secure region. Because the USDHC controller is non-secure master,
it can't access this region and will cause loading issue.

So override h_spl_load_read to use a trampoline buffer in nonsecure
region, then use CPU to copy the image from trampoline buffer to
destination secure region.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/scmi/soc.c | 40 +++++++++++++++++++++++++++++++++++++++
 common/spl/spl_mmc.c              |  2 +-
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index fefb1a6f4ca58722a5d93c39e4f6a7aaf85aa177..8a7df24afecc1d6d77b7162be639b56af95fd975 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -41,6 +41,8 @@
 #include <scmi_agent.h>
 #include <scmi_protocols.h>
 #endif
+#include <spl.h>
+#include <mmc.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -830,3 +832,41 @@ enum boot_device get_boot_device(void)
 	return boot_dev;
 }
 #endif
+
+ulong h_spl_load_read(struct spl_load_info *load, ulong off,
+		      ulong size, void *buf)
+{
+	struct blk_desc *bd = load->priv;
+	lbaint_t sector = off >> bd->log2blksz;
+	lbaint_t count = size >> bd->log2blksz;
+	ulong trampoline_sz = SZ_16M;
+	void *trampoline = (void *)((ulong)CFG_SYS_SDRAM_BASE + PHYS_SDRAM_SIZE - trampoline_sz);
+	ulong ns_ddr_end = CFG_SYS_SDRAM_BASE + PHYS_SDRAM_SIZE;
+	ulong read_count, trampoline_cnt = trampoline_sz >> bd->log2blksz, actual, total;
+
+#ifdef PHYS_SDRAM_2_SIZE
+	ns_ddr_end += PHYS_SDRAM_2_SIZE;
+#endif
+
+	/* Check if the buf is in non-secure world, otherwise copy from trampoline */
+	if ((ulong)buf < CFG_SYS_SDRAM_BASE || (ulong)buf + (count * sector) > ns_ddr_end) {
+		total = 0;
+		while (count) {
+			read_count = trampoline_cnt > count ? count : trampoline_cnt;
+			actual = blk_dread(bd, sector, read_count, trampoline);
+			if (actual != read_count) {
+				printf("Error in blk_dread, %lu, %lu\n", read_count, actual);
+				return 0;
+			}
+			memcpy(buf, trampoline, actual * 512);
+			buf += actual * 512;
+			sector += actual;
+			total += actual;
+			count -= actual;
+		}
+
+		return total << bd->log2blksz;
+	}
+
+	return blk_dread(bd, sector, count, buf) << bd->log2blksz;
+}
diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index 1f69659321620739d066bd806acd1d282b66bad3..d15a6945f9c24ee427b847c036413c52475c44a8 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -17,7 +17,7 @@
 #include <image.h>
 #include <imx_container.h>
 
-static ulong h_spl_load_read(struct spl_load_info *load, ulong off,
+ulong __weak h_spl_load_read(struct spl_load_info *load, ulong off,
 			     ulong size, void *buf)
 {
 	struct blk_desc *bd = load->priv;

-- 
2.34.1

