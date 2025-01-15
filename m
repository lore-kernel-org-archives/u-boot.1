Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB762C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:30:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D3C18073D;
	Wed, 15 Jan 2025 14:29:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fxu5WLBj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A10C800C2; Wed, 15 Jan 2025 14:29:49 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::61d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81C4F80703
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:29:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PYDNx6jWiXDcrRelN6ZPorlE5R1ePseOLwI/l45xD/bX0AJWTFj2rBcSFpDL2ZE1ZmQ7rK3I2ixrOEsOuwh5VHWB8fzc87wZkSuqPIW9WtAY0gJhP82RxAiDgz4nKXg4MGLEJE42KxjiZEjxG8kQlSBa2XLuYBTGx/tVzE8o1yNw0oaAJWWocRkq8UP2eEbIadvgRpE2xlYRlLKR3aD9fS3bQloka/ELJkofQ5rA0Eimd7gzp6nm/UClQpcnE56+j4b1GDJUkejgFBDr+sxF3cUp6udsA/OSti1w6IGjvKZbeEChp+rMzRTWcdrAfrj5GVY+h2x95hcNEy9UgZsBfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNKSUsLVvKzN8pAOCFUIxHvz+gg3rbsEFqERdThRs3o=;
 b=r8cuYTULQi7qsVSvjWMBkM1nj7i9DAhWT9ECB6hunbJ1kuZuJZ4latnxOdt0uXvY09QANXrWB9YXB055torWT0IPhfPvW/yCAzCTl2SxNTESvHCNccIAI5ZtPEc4qvpJ94xtksxTs2/JgdG9KkUAIRx3RTnO7f8OY3Iczll7riwywzUgbgD1jzb/1Amvl1Z3k7nm1lCdgFkYdAGqTjFD8jBUnH96GKhatp68JX8jEh2Y47XCpltsBT0ASVzzMsIJKMt8JseEStOZ2MKOD9kDxRTdAnkmHoiUE8/0MDbBCwZ2zpNNs0NrWppVgLjPGyFu5RXEzRLwzWLyQJXacPOP9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNKSUsLVvKzN8pAOCFUIxHvz+gg3rbsEFqERdThRs3o=;
 b=fxu5WLBjviclHW5zeUD5lB/X9qTWuCadWmwI8r50di2zqyU3WyW7jkuL4NjEiOdFlt5OQDhKP1FhN8sJUpMX4JODoZZBgBh8yJMyXxiVyOstFZZ/IUFF7SZHo6msnDhrYmZ9fzK+IACd75EuDei6LsqqsvI41WYfk3S3S20N4rhq5iI9x1JT3wDRCHQ0iV8VYbWTCpUM2XsJlsmECvdfi/OzfYhch3Ci6CNFIePvvAhd+bEMmKu1ygiWjQxVdawZmx+y+QYu+ZBLjLR+TEOblmYk8y84uyJ76S6rFstfsfvFBOdt4wOefTnSu8e3Mh7L2AI2fOYRTvOSh77QO+uWhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7764.eurprd04.prod.outlook.com (2603:10a6:20b:244::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 13:29:45 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 13:29:45 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Wed, 15 Jan 2025 21:28:56 +0800
Subject: [PATCH v4 09/20] sandbox: add SCMI clock control permissions to
 sandbox
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-imx95-v1-9-93b28a514dea@oss.nxp.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
In-Reply-To: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, marex@denx.de
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736947742; l=4383;
 i=alice.guo@oss.nxp.com; s=20250115; h=from:subject:message-id;
 bh=oCHkjh0FX629mvVAKnvXaLpXRKdCwJDl+2c1pYrcJ4o=;
 b=RJFKAYDsFs/AWKzjf+k2hiy/cNyCHvY/ytIyMXEHKteiwKzAEhTTwUUyWQHwNTyEyytYDkznW
 HIQ9FbKWuHRD76BXG5lmt/+8EjndiKFEv4Zm0UVgOzKOhr0O8cKk+ow
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=MQFotjdbgvdbpnpHmN/PUzfJXX0wchusR4L7yfs2VZQ=
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM8PR04MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: 158649ba-f951-4a81-583c-08dd3568ace5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3l3Nk03RzhjYWliMHcxbU9VbWxVNCsvc3lYQkx3TDJmZ2VEbHcxamdkNzB1?=
 =?utf-8?B?ck1WY2duOFk1eGR0aHR2OFRicExnZUxVbDlDRjNBQ1RlTEhCNVJXL2ZWd3Zq?=
 =?utf-8?B?cFpleWpRSWtsbkdtd2t4VUhCVmhObFp6U3g3K1VBSm8xMCt1OU90MlA5WG1N?=
 =?utf-8?B?ZGp6dHlOVzRQcDRCZ25lVEdQWVVGZC83UWtUVWtIUi9vbnM0RFcrVFdZc1lE?=
 =?utf-8?B?c0JKUk4yUXpuZnFsUUNSUno2WXlrd3ZvRUswL2hhcVdFaFlXcVJJemZ1c3dy?=
 =?utf-8?B?dmVKTzRFbklpNmxxb1hZZ2JuRk9DSWdscEl3aDFsOUtzK0VxQlpXM0RnWXFv?=
 =?utf-8?B?MEpHZld3d2hCYlRUU3ArRmFTSlN4WDZSK29HQW9kL3JjQVNZNzNDb285a2RL?=
 =?utf-8?B?QktCek9IQzNlTFZDOFNpYUlHMXZobmRNRHZWSGNCd01ibUlpMDVzK1NVZHZo?=
 =?utf-8?B?a2NqbENnVXUrc29UdGgyVnZNZUlZR0M1V3AxeWRsVHBwZ3FVWFh4cDRzZGZG?=
 =?utf-8?B?SFpVQ1ZicjlsVDFnemhIK0Rrc3VmMWlIb1g1SGZhdXJQMitqaEpoZktQTHBK?=
 =?utf-8?B?QS81dm1tT3FrVG1qWnlSaWJ5Uk5MK3BaZFNZWHBKUTFGSnZPNTZ4ajFBNStL?=
 =?utf-8?B?Q05iRWU1cjMyTG9jVkhZK0ZOeG94ZFJrSU96NG9mZ1diMGV4NzZNTjdaNGRS?=
 =?utf-8?B?M3ZOSEVRTUJQaVZBbFNKbkRGTmVlb0xEWDJ6UXEvbVNkNk1ENW40NnhDR251?=
 =?utf-8?B?WXpLZktuZ052K2c1TU1wV2FReSsxQ2swUzNSaVA5bm82djhoOStDSE51dDE3?=
 =?utf-8?B?MGtKL0dJbDlvVE5ZK0xLemJpaVgxUUVlVEYrOTZnWWVNdnZMeXpUQW40UlN5?=
 =?utf-8?B?VGw1ZGdzMGxwTzRsb2IzNlE4SjduS29wOWQ0SzNZSHJpSTRPcFYzRVNZU1Fm?=
 =?utf-8?B?STFoNlRUckczSC9HekJMcTlBNWtlRkI5OXFLRGNWdk1BNzlhTnlsMlcyVzBN?=
 =?utf-8?B?cGZmSjN5S1VyQk5lNTQ5d3FkK0kxdVNsVVllSnlQL3kvZEdvOUgvMU91QU5L?=
 =?utf-8?B?TUpMam5SZ2hJRlRwTG94S1dVSGpMRVg1bGx6a1ZnNDZ4VTU1eStobzQxMmEx?=
 =?utf-8?B?UUFoNW9ySHlPQkY4Q1plK0JUU3NGRnEzRnBCdDgybUYyUTVMbk9NS2NPK3Yr?=
 =?utf-8?B?ZDV6SzZROWk3NXZPeGpOYy9JNFB0K2ViK2pyOFhvNGxNMWFYWk05VmN6Slpq?=
 =?utf-8?B?bkRSbjBaV1VqYkxqNHRlUHNkcmhiRjF6Rm9qVFp6RHpBanZVaHpwUFdtandk?=
 =?utf-8?B?aDhVTWFnRnI5M1YwV2ZPelR6MDFIcGw4Ly9PaGpkL3ZNcFQ5ZWRLNUlvMVBK?=
 =?utf-8?B?eXg3czJDWUhMMlBUWlNXa3BqWitxU3B3ZVNGdXpxTktXcmo3ZDBzZ0N3OC8v?=
 =?utf-8?B?S3hOcnVKT0owaE5FbWREWU1RcXZYamY0MzFuQ0Z1eTkrYUJoOHVGRC9KMk1Q?=
 =?utf-8?B?OUdrV1NtQWg0VEZ3MkNXUzRmVTBFWDRWQjdxZXlmWWozUmtlSk5xU1Y4V2N0?=
 =?utf-8?B?dzhOUG5vSTBqZ3F6a2Z6TjRZM0ljQ3hZZkUxdVI5RUFHcGlxelJCUWhobW9I?=
 =?utf-8?B?WnBNcFAxVGRoL2ZXUWlRS1ZSQSsyUDVyZnRFbWN4dmE1SFdFR1AxcVB0WXpC?=
 =?utf-8?B?VDhOcHZBbC9nTXpzcytSMjdsOEdYZllsREVtQmU1YWd6eEhxaTR5WHJObk0x?=
 =?utf-8?B?NjBpL0hSaVBQWjVYODU2Wit6emt0ajlBYU41eks3M0pxclBFc1BuRnBiWTVJ?=
 =?utf-8?B?d0MxcEE1c0ROZnBXb1plL1JHOExPb29UQjJNT3djV1ZVUVlWQkpBTGovcmJ2?=
 =?utf-8?B?VGxLcDRnY2JhTHpoRDlzRUswY21IeGNVaEdxSWRicElRVHN2aDlQK1lOTVR0?=
 =?utf-8?Q?cHtHHrQFz5C+sCaTL3niCL9TlSAfuIn9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXk0OHVCYXFJRjMzMUU5N2dRSGcwRzMxTkMzMk9jWjNQQTNIbWFQaGxoNGNj?=
 =?utf-8?B?SVhsODZRd2sza1JQMXB5Zko0ZnZ5RVpxRHRJSDhyay8vMnUvcjBneVRYQ0hQ?=
 =?utf-8?B?RFdrZVhQMzk1WWlqN2c3T3FWc0dObWJ0MDIxRGxLbmVmVVc3RGVUaU9uZHha?=
 =?utf-8?B?VEZhUWllYnY4TWZOY1dGTDY2RUVqeHk2Y05HeVJjcC9uSGVJZVcwTjRQZ0J6?=
 =?utf-8?B?QXVOaTJzYk8xQU5ZVWV3MHJIMER6QUU0U1dhOTZvWW56UmgrU2lxZkM0K2xa?=
 =?utf-8?B?VEJxNVBvRjVLYnA4L3F6Qk9nUUFTbCtCVTlmVnp4WnpGNUJjRGc0bFdmVVE5?=
 =?utf-8?B?S2FJakRxUGw1Mm9IOE9DclBhcFMyU3NCM2Vqb2VPTWdBdjNidy9PLzZkcFNt?=
 =?utf-8?B?RXU4NnFJYXBLcWc1bkhTVWhrMytZM2s0bW1oUHpIMjBNY2hKMEovSHlkTk9m?=
 =?utf-8?B?NWVNV3pTQmk3cU5wZjlaelhPeUkydDE3NFlOcDFDTTVzZ0VhSVA2alUyRTIx?=
 =?utf-8?B?SHExWVphZkdDc2dKS2RBd3hBaXVLVStZYkprMHVvLzJZSmpLZ3orY2FUcmRt?=
 =?utf-8?B?MWlQUUVUSlNzMnVkNkUzSXR6WUU1TzZDeEZpTjE1V3ovTFBkcThKdUgvdFpX?=
 =?utf-8?B?aHczUlp0UDZyam5uc2VMMU5vbDByVjlFQkRMeDdNK1I5Zk9heDVVMjYraEp0?=
 =?utf-8?B?Wkc2TFBRTEFLdWR4cnpiM1FjU2JZcnlYS0w4ZExwbElBRlZCWmI5Y296NzU4?=
 =?utf-8?B?azNIeHFrNnZIcm8vem1hYUNMdkRFWGpsMGYzTmhyby81b21VbWFoNWl6Ukc5?=
 =?utf-8?B?dWVjRWRoNlFBYjl6SCtpMFVyRTNuQnZ2dWhxNTNRblRyenM0MldOZHRuMkJM?=
 =?utf-8?B?dXhYTXFEb0NWcE0vTXJoTWdpME84Sk1xemhMM0d3c0tBVUJGUmU5WE9iaUNM?=
 =?utf-8?B?ZXAwMjdrUFpvUFZoVEV6dFFyOGMwM0hJMWZrakZTQVRaUTdQdW1OdkxuTzV2?=
 =?utf-8?B?cDhKdXlMd2NMNzZGZlpZaThhV2pDNzBNYUQ4VmpVQWV4QVBMUm1jQTBaRkFy?=
 =?utf-8?B?L0xnN3M2c1ZyNHh4M0hEaEtNV2lXWmRSTGVWcDQvSDU5Z2MzUFNvRlo5RUtQ?=
 =?utf-8?B?SElVY05SbjZpeHY2MjhYMXliN1NFQW5JWFBDaU5LQkgwZ3hiWGlKbnMrV3Za?=
 =?utf-8?B?dUJrWXM1S1BudFRwTzRWT1RQZ2pXSFRnK1cwTm1VV3krVEZuZDMwdnE2Q1Aw?=
 =?utf-8?B?THBMR2FDcHJhZ0pzSERXanNUZWpudERHc3pINmU5UTdPaXRXcVVXWjNEU081?=
 =?utf-8?B?WmxUa2hSU216a0FtOVdXaFBqcm5iT1lVY0FQZUtuS2JLeHk2V3FPK1B3SlYw?=
 =?utf-8?B?bll3NDVvVkZqMmxKMFEwUllJSE8zZkFMYlpGbXBKTmh3WUd6WDRUOUx2N0Fr?=
 =?utf-8?B?WTR0NHc4eSt0a3JiRENCY3dRWEo2YjNJQ25hckVCQ0NoSVJDNCtMSDRkdnJr?=
 =?utf-8?B?ZmFmUW9yZ0xrR2ZFd1VZTXdUZ3hWcmExQnZ6S0wxMDF0Q05Na0p6UURTdDBy?=
 =?utf-8?B?aXpXRVlVYlBCVGNYWGhCbHJsRTY1WXZITEl0R005YnZ0M2JKeGhLTWJ5TzhQ?=
 =?utf-8?B?SmJ6ZGNYcEdSK3RrKzhHLzNyQS9nRldjRmtTSzFBWWkveThxNjRDMTJ1bk05?=
 =?utf-8?B?RmxnaGVXVVc3aWZJWWtXRWhVQ0x1SDUxUzBMQUtlTjhad3gxbHVHdDNnYWhW?=
 =?utf-8?B?c1h1a1l2SnNFaG1MTWRld0JEVFBWUXBRNWl2SzhSaVNjOU5YZndDTzU5cW5j?=
 =?utf-8?B?SjRUN2MrM3c1YUx6VnRuTjBvUWdjWFRtcXhpZEpJVHJvdFhtaFNFbDJibVFN?=
 =?utf-8?B?b2UwZ3hDLzAydzQ0djY3NkFLd3VscUlOZE9yY0NHVkNBSE5XNWVwd2JueXNR?=
 =?utf-8?B?WEovMWYwbVdqSTNyZ3ZScGdnN0dwbGlBQzU0c1Q1aWNtcGhXazByVDY1OVBB?=
 =?utf-8?B?dE1Wbm00aVF1cFlyelVOZklJZW16UFppRG5wbFRiTDR2S0g1eTBhL01pMWNH?=
 =?utf-8?B?eEFPZ1p5M2FvK2VTTnBCbmVZOSs3Z1FqN1FoZHdmN1FwR3BqNDF4NFRHUVRx?=
 =?utf-8?Q?FGu7AG8RYs16deBbzwDUVPsEn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 158649ba-f951-4a81-583c-08dd3568ace5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 13:29:45.1298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FWEAnaOdV9ytUx8/VkkXWpJ61nv8L26/xM8g+eOV/ykEisED7tGv6I+yCm0oNX1fjMYOUFYU1KHrCDpQ+NoY+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7764
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

This patch is used to add SCMI clock control permissions to sandbox for
testing.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/sandbox/include/asm/scmi_test.h       |  2 ++
 drivers/firmware/scmi/sandbox-scmi_agent.c | 56 ++++++++++++++++++++++++++++--
 2 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/arch/sandbox/include/asm/scmi_test.h b/arch/sandbox/include/asm/scmi_test.h
index 619f8f5098cdd82ba2343897166c34c82c753422..b30e536a35771ec3e1439c1e64fd09de3728dc50 100644
--- a/arch/sandbox/include/asm/scmi_test.h
+++ b/arch/sandbox/include/asm/scmi_test.h
@@ -27,10 +27,12 @@ struct sandbox_scmi_pwd {
  * @id:		Identifier of the clock used in the SCMI protocol
  * @enabled:	Clock state: true if enabled, false if disabled
  * @rate:	Clock rate in Hertz
+ * @perm:	Indicating state/parent/rate permission
  */
 struct sandbox_scmi_clk {
 	bool enabled;
 	ulong rate;
+	u32 perm;
 };
 
 /**
diff --git a/drivers/firmware/scmi/sandbox-scmi_agent.c b/drivers/firmware/scmi/sandbox-scmi_agent.c
index 19be280ec44845369d1f46509978ec9b5b59c60b..74a87832dcb14d63550e450f4bea2632844199e9 100644
--- a/drivers/firmware/scmi/sandbox-scmi_agent.c
+++ b/drivers/firmware/scmi/sandbox-scmi_agent.c
@@ -80,9 +80,9 @@ static struct sandbox_scmi_pwd scmi_pwdom[] = {
 };
 
 static struct sandbox_scmi_clk scmi_clk[] = {
-	{ .rate = 333 },
-	{ .rate = 200 },
-	{ .rate = 1000 },
+	{ .rate = 333, .perm = 0xE0000000 },
+	{ .rate = 200, .perm = 0xE0000000 },
+	{ .rate = 1000, .perm = 0xE0000000 },
 };
 
 static struct sandbox_scmi_reset scmi_reset[] = {
@@ -700,6 +700,21 @@ static int sandbox_scmi_pwd_name_get(struct udevice *dev, struct scmi_msg *msg)
 
 /* Clock Protocol */
 
+static int sandbox_scmi_clock_protocol_version(struct udevice *dev,
+					       struct scmi_msg *msg)
+{
+	struct scmi_protocol_version_out *out = NULL;
+
+	if (!msg->out_msg || msg->out_msg_sz < sizeof(*out))
+		return -EINVAL;
+
+	out = (struct scmi_protocol_version_out *)msg->out_msg;
+	out->version = 0x30000;
+	out->status = SCMI_SUCCESS;
+
+	return 0;
+}
+
 static int sandbox_scmi_clock_protocol_attribs(struct udevice *dev,
 					       struct scmi_msg *msg)
 {
@@ -740,6 +755,9 @@ static int sandbox_scmi_clock_attribs(struct udevice *dev, struct scmi_msg *msg)
 		if (clk_state->enabled)
 			out->attributes = 1;
 
+		/* Restricted clock */
+		out->attributes |= BIT(1);
+
 		ret = snprintf(out->clock_name, sizeof(out->clock_name),
 			       "clk%u", in->clock_id);
 		assert(ret > 0 && ret < sizeof(out->clock_name));
@@ -837,6 +855,34 @@ static int sandbox_scmi_clock_gate(struct udevice *dev, struct scmi_msg *msg)
 	return 0;
 }
 
+static int sandbox_scmi_clock_permissions_get(struct udevice *dev,
+					      struct scmi_msg *msg)
+{
+	struct scmi_clk_get_permissions_in *in = NULL;
+	struct scmi_clk_get_permissions_out *out = NULL;
+	struct sandbox_scmi_clk *clk_state = NULL;
+
+	if (!msg->in_msg || msg->in_msg_sz < sizeof(*in) ||
+	    !msg->out_msg || msg->out_msg_sz < sizeof(*out))
+		return -EINVAL;
+
+	in = (struct scmi_clk_get_permissions_in *)msg->in_msg;
+	out = (struct scmi_clk_get_permissions_out *)msg->out_msg;
+
+	clk_state = get_scmi_clk_state(in->clock_id);
+	if (!clk_state) {
+		dev_err(dev, "Unexpected clock ID %u\n", in->clock_id);
+
+		out->status = SCMI_NOT_FOUND;
+	} else {
+		out->permissions = clk_state->perm;
+
+		out->status = SCMI_SUCCESS;
+	}
+
+	return 0;
+}
+
 static int sandbox_scmi_rd_attribs(struct udevice *dev, struct scmi_msg *msg)
 {
 	struct scmi_rd_attr_in *in = NULL;
@@ -1193,6 +1239,8 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
 			return sandbox_proto_not_supported(msg);
 
 		switch (msg->message_id) {
+		case SCMI_PROTOCOL_VERSION:
+			return sandbox_scmi_clock_protocol_version(dev, msg);
 		case SCMI_PROTOCOL_ATTRIBUTES:
 			return sandbox_scmi_clock_protocol_attribs(dev, msg);
 		case SCMI_CLOCK_ATTRIBUTES:
@@ -1203,6 +1251,8 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
 			return sandbox_scmi_clock_rate_get(dev, msg);
 		case SCMI_CLOCK_CONFIG_SET:
 			return sandbox_scmi_clock_gate(dev, msg);
+		case SCMI_CLOCK_GET_PERMISSIONS:
+			return sandbox_scmi_clock_permissions_get(dev, msg);
 		default:
 			break;
 		}

-- 
2.34.1

