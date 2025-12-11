Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F27D41C17
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 10:09:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A922C83642;
	Thu, 11 Dec 2025 11:05:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="S6nMKJ8P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A3C983655; Thu, 11 Dec 2025 09:57:29 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD9148352B
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 09:57:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y1XXipcpgCX99knR42BtNJvP4iQWiPR3WeOTk9JWIimxBjOzk61k8LElXgAXUlpbG7/TjM+djpQy+M2uGwlujVytbU0MT8zziBsmuCWemi3hkopk1Zb1lUWnylByThuhecw0VWT+dYel5IvUD8/vKyiL7Q2nzuqkjM18LMIy2JuKCiMn/BFEx1o+nFoAITY5JpliwVOvPCtLe4+ryUyY/ujahQnuZgkhUFXNjChxJg1VcJiG1uYzkrxWqte1pSZnP6aaJO9YIAzDc+5zTLDRLZDb+16YCAkLWCc+Ty5yyTl488NGjFcxGa5F40peayM/ICYakHl2Wauj9toxipR8Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSCzJvIzgzbWXdXp3Q+T4r9j+HXKC/iCAIdTKaw95ec=;
 b=LNPR1EdEiovYglFRW9RpiIqPjhpYglOubyrOKvhz5GBA377hlJN8SWtz6WDV9SImBkOF/K8WjPMPsnUlsvY0gxps/hWUVNnBhTusYJt7PQZ4nmW7xtrVCUx8yyQA4XwvprC15aMppIb5FwQZgjfUZFXVsHvmox6sjz7jjnMWwQTTMK8CsnqYuUqiZKYFEzWLt4sIO3v2X8XO6qF8OOlwh8Zid994k38z/yFjiGhAEYYaOBl6t3WYwMrKdfrcY2kt1Ta6QjewAJdDw447TiKu89+AbYUYZhYwFhgx5U7YNimdGWj5fjW/m5PbzAvcJNye99RIopsNPUqz0FLATpC+fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSCzJvIzgzbWXdXp3Q+T4r9j+HXKC/iCAIdTKaw95ec=;
 b=S6nMKJ8PcsVM3mBDlcZTNGaADsUpKUP1ucQO2JBl34hbgc5a8AepBmLAhId5M8os1dY5HphgYmsB7Z2iW9K501UUW0bMRWhT19kcY3Ya4lFzQXT4hQS5R71Kz3jHV+cbhycZp5SjP/2AZ6rZGILqp7mjXd9vG/GcBI2VDrqmxF0Zl4dogC4LRtjf5dRd/hah4+mI5zaYeMQDeNunTJLVQ0mLFuAFCubXnc9JpDkARaDKxJbMHT6zK949qiHJjUkqKGVI0g/tfe5R7DhRmxXhB4qhu3bolTRiYgdkyozlSX72Wg5Lu/aGhG1kPFzbb6P1Qk+qINjHhEcxFgewMMWNQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8325.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 08:57:23 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9388.003; Thu, 11 Dec 2025
 08:57:23 +0000
Date: Thu, 11 Dec 2025 18:10:55 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, jh80.chung@samsung.com,
 trini@konsulko.com, marex@denx.de, tien.fong.chee@altera.com,
 balsundar.ponnusamy@altera.com
Subject: Re: [PATCH v2 3/9] mmc: sdhci-cadence: Use max-frequency property
 from device tree
Message-ID: <aTqYryUMYQpbnpF8@nxa18884-linux.ap.freescale.net>
References: <cover.1764760325.git.tanmay.kathpalia@altera.com>
 <fe65b64f4f53d119302e2a6d884ab02f45e54c1c.1764760325.git.tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe65b64f4f53d119302e2a6d884ab02f45e54c1c.1764760325.git.tanmay.kathpalia@altera.com>
X-ClientProxiedBy: SI1PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::13) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: e89e39c3-4347-4d6a-7fa0-08de38934cd2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|52116014|376014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qrxP89hbnJEF5lh2huLOTlA1GYUpgd6pssZUe7rMsKBa9xZPu6N88wSA+XPC?=
 =?us-ascii?Q?StDtUpBlil7xevWLEwKLd/Tph7al/PHr2HXx+VreASUl8lws+7+hcFBowiUb?=
 =?us-ascii?Q?vPOXk+0SRdusW7OvO8q0c3uo2jBECGyg3k8SuTAAS6N4HCQqmnpJuuZfcr9+?=
 =?us-ascii?Q?EZ65Pt7wd/ZeLEwoNAK865pMRIXoQRArqPEaMePnJvH58iUM4XL6bh/UDaib?=
 =?us-ascii?Q?z3LmveIQkWCl+r8NaRaN+JtoRTGvqKaZ9M5yjO1p86Z1OUUnb1mId5ioTAlK?=
 =?us-ascii?Q?QC06zQ36HLtb6TYndNEWE3kpDcOrmc3tDGSdfDiAc8z2sbLVxvYWICSbHLDa?=
 =?us-ascii?Q?QRhg6OViXGWG3pehmhzRPrPUppsVhw+ApJVB//6a3pUH8WO0YQvMWGGFbKYx?=
 =?us-ascii?Q?hjrNn0C7uT/kRAgbJlGoZyUwGS2nT6LB4+MSm/2b7QRpSqIgpi6MaYUVgtQn?=
 =?us-ascii?Q?PEs/pz+5Sm9B6ZbKMQOMaDxe/fucICkjHLNhHTseBq2yXPRo+8FAtCkp/2n7?=
 =?us-ascii?Q?CFmQWK8cYBeWQUyG4EzopyfhEGdpVHMTUI9Z+z4pl+N5cQSyHRxiLuYrML98?=
 =?us-ascii?Q?LGZpXhwOmnhH502hb4PxAgwTod8Sq/0S5gL/wyvEu9h86b31ec7PiJ1dnHQp?=
 =?us-ascii?Q?e+/5zMbIlyrX7/TOSJ08jzBvy09DLu0E8ube8EAm3mEO94YNEBiPGxs0EV/Q?=
 =?us-ascii?Q?wfzeTFetS5iGu/epg8kCyR2tXVplZw91w61413i2Ge2ypri6pPypDnSF4xCH?=
 =?us-ascii?Q?Zy3O9xX7jS3NBLLicEj+aO7c3zmEXyxX0C0X3STlH1nsgrgV7222r4b9/l8W?=
 =?us-ascii?Q?Dxyox1TRkiV09sO0aBiKE1UeNUcNvM54grQ3d8OOpAmwXOceBFCahXt21Vj6?=
 =?us-ascii?Q?iLmHn555Q31cXT8dJpALptR7He1uCvWLLGrVCjsySMGc+adv34EWwUo5gmaS?=
 =?us-ascii?Q?QS5SrknHAW3uwanVJ74+Hk5BvXp3Dici0yjJYzNWlpDUcz14kqybe/LG+gXe?=
 =?us-ascii?Q?8mnV9yppYLnP/nEQ5elFBlxN7m8MzEP8JIKT0BQ1kGbn27gqSrllqen6X9dF?=
 =?us-ascii?Q?hv0HZIS/MR9OeigHlXSmRRpkHkP8zIhfUKSE4SUI+/gJb1u6NGKOil3x9djx?=
 =?us-ascii?Q?JdnJsk8A9rKj2zl8v5lvfNLaX/mSYrb8OXrpHJtk7eKTryOTm6YYhbnZ8hoc?=
 =?us-ascii?Q?O82xpdERIom+TBDCEZn4RB2OXP/Qp4nyZjBmeBzUFkLym/lCO0oBZETK7ZEk?=
 =?us-ascii?Q?ipo4zw9JcTHCXbasxPd7R2zOWV1hrihqSQSgcRlCAy8nSe1ylwScpogcuGIF?=
 =?us-ascii?Q?+F4kUg1p3/mZtcje0CVIWIoo+6zRz8jH820mjBeIX1pTi1HraTh/chPchH34?=
 =?us-ascii?Q?A1m2GBaU0ac6yqWVEuizN8e5EnDwCMnKhVQr5IPs5cagxEdTw08b2Of9BXar?=
 =?us-ascii?Q?Sl0lFPnEsq/qy0nfo5GWI+9V9+B/TVF9JiR76p4Zzl5AP9CVMT7FbWDEEE/p?=
 =?us-ascii?Q?RnwgRc4LVDvsWKGgTEacYQO+xVTvdJrc051E?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(52116014)(376014)(366016)(1800799024)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p5SzMDohYEg9KXCnd4I1pq4w3vzrxICsbCiM3D2rGYjfSRNcjgY898O8UQrO?=
 =?us-ascii?Q?VUTmWjfdecJOl2Ntp1t+dTH6NJC9giWwtEPbOSixkt3vAGwWASOYF4leQnDE?=
 =?us-ascii?Q?73NSlazf9LuDYe0OZ1HvPmSOfScFSDq7Ak4XEx4z6EyF1lER+7rU/GYTkH9+?=
 =?us-ascii?Q?/lylc/c8eTaIepaHKo2olFpb1u667sqwir7atHHUedQ1pdqin3Z+ohXWHK6p?=
 =?us-ascii?Q?4hFMaasK0O1qPbzcgMClyKKsRBervJbojaNZ5LtwBlsVDCVWU4ZVlCYvB0MK?=
 =?us-ascii?Q?y69Pb3SgImypApo8o9I5dxJM8x03+UFLK0zG37YMUDLxM+nV1nmC9u5JjdRG?=
 =?us-ascii?Q?tH8LJQUh7g37eFHcB/VCDWfzXViiDJc+MqQkPVcJjkVJG/QduQ+c5IpsDP/e?=
 =?us-ascii?Q?w4GTyEpx8YFRrpDR9QeWIxbvhwZRt/gEQEO7U/VCHTjYbEhen4O/fHpoIHxI?=
 =?us-ascii?Q?MBygRDCt0wJVyfA5feVEQ0VwQ4b5EDz6o4h0mX+Fms6ambaEN3WKpEECTRcB?=
 =?us-ascii?Q?tCOKzFvO4rVADpBDyNoStXFCMpVC3IRL3Fp9iny3M4XbqDmuzPXRZyJ4xw8R?=
 =?us-ascii?Q?25p+tYKq5o/kcKEip8AleXpxOADWG3ivUI/XrYOP2AI9dX/Q1vcDs/nbAjA5?=
 =?us-ascii?Q?SUNjd3+IjGCitKfQKxrrPqNgXsGMZIKtvcDq+7JxvVnSIMclw2TaDE2pzNTu?=
 =?us-ascii?Q?/lMZ5TY4vVfIS+xzmgmYz5YUbidGFRlGFAtEIMpZoaei54YhXUiz19p84MEx?=
 =?us-ascii?Q?f5/HMahtkGC2t50TIWi/zKPCi8v7atRZWtiqJyguPIsvpqKJISa2A5Qw3ahE?=
 =?us-ascii?Q?q7VyQCCgsBzD9HlmjjJp9CGQQH8SR6ZqAGsclUnBNVbQ8gk3YUeK+D01yNBX?=
 =?us-ascii?Q?KpAs/1s1n08rkF9HUDeYdnatDx+jKuiR+4cw0yH25hQZ4lalslTVbfu6CYVC?=
 =?us-ascii?Q?BNhnInjStURk4zQ4xh3ckpgiVCowol8fVLOyC49CCdz0lJXVW9RvV4M0vSvX?=
 =?us-ascii?Q?sdAVauZB7hk6kSRHnGArLp+75VydrcX8v5DdvMfnsK4prMiLUhQRbDm3ob4G?=
 =?us-ascii?Q?xE+oBAJJ6DM+n02A9oksgChHqZm0v0gLl5BzlRDnRx7RLpbFv4gokXvIkU28?=
 =?us-ascii?Q?ncjILxqNIvyTiWZyqfrctOJoekVDVH6iYfqyCjdgmRWSLBb7vlXIorw64GXY?=
 =?us-ascii?Q?oBwO1fWsNX/K3r1vs9eBBwxoyCSs0tgckE1QkIT5bVTA3FZJ75QpezX4Hsgu?=
 =?us-ascii?Q?LoFsoinvhqjL/8Qe/IfByTK0NKuVxcwWlK24QMu52QyCFAZHYL2r0vK1YddS?=
 =?us-ascii?Q?3lzK9J4As0Ii42qz1Zq1qJkeRAtUEaIB797dtMwbx1VOkAzPUom3EEObXsIN?=
 =?us-ascii?Q?xl6djS++68ZwA16MoOFYv4DKwJG/oOTogAH8BMNcuIAlLAYJ8rmkkLAOPZ6d?=
 =?us-ascii?Q?fpchUT856cunrg9sRzyoJvNhuAjvzOLJvw3sABNEGwzjF5eEcFnSQ7PPWs3X?=
 =?us-ascii?Q?DIgpgcZONNGfPnfpq6/fIe5KdrWt7pXBZ2a8vn+uyjTlTS4qRUVqo6KTfEtG?=
 =?us-ascii?Q?Q+qzB1jVwf2nHy/XImKjJMhMtaf6pcv+Z/GlusBa?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e89e39c3-4347-4d6a-7fa0-08de38934cd2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 08:57:23.4757 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZIRh9nYn+O4+06dK0G3aVJD5DhHaz89xGCLWXmXOTVrCanBielulwgUiM2y7mIzSfgwPfJk5q24kzeWOwSHHyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8325
X-Mailman-Approved-At: Thu, 11 Dec 2025 11:05:15 +0100
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

On Wed, Dec 03, 2025 at 04:21:33AM -0800, Tanmay Kathpalia wrote:
>When f_max parameter is 0 in sdhci_setup_cfg(), the function defaults
>to using the maximum frequency from host controller capabilities register
>instead of the max-frequency property parsed from device tree.
>
>The max-frequency property from device tree is parsed by mmc_of_parse()
>and stored in plat->cfg.f_max, but sdhci_setup_cfg() was being called
>with f_max=0, causing it to ignore the device tree value and use the
>host capabilities register value instead.
>
>Fix this by passing plat->cfg.f_max to sdhci_setup_cfg() to ensure
>the device tree specified maximum frequency is respected over the
>hardware default.
>
>Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>Reviewed-by: Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
