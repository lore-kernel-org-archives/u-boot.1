Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D28CC43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 17:48:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8E4E84B73;
	Thu,  9 Jul 2026 19:48:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="GgY6NCHu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2412884BBF; Thu,  9 Jul 2026 19:48:25 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1483F84A8F
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 19:48:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eBqlHbYQog9z86Gxehr2TMJxGf4A5aGrsPNyTHIU2AIgezEiumf7ygz47aRsFAHIQMAxV4+FO6X2iGcCYUGRWHrqArJCqvOdrFmXApnoGDbqLaMTVvajL8Bt0FMbS1AqgaZRJGNCzBY4mgRhoFMwHj9C0CzepcBM2xpLZfYTsKdQhWYPrmu9F6zHwd8KCb3UarYUmoGhmGH1e2hEb1WNyf2dGKdbexUSIQYFg8GjMJrm8Z4QaRCVmy8WsnlZMmYfkWIBaLBpjDQrqeCP1nHCRWvtWCfbspg0KvU+WT5FLkNBXTvji/jqhRz4oaKgeV7YHApDxFwbDo9K98mD0vtOCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVH+jgcxwTW3LjIgbV5cYFEtkmTgHBhpWTQvaiBySv4=;
 b=Bo1zaChumjCgVvrJvygx+VvymhoKcArDREaH+dZePbDEKd8tYaTieupMObu1l7mlZXGBnPK/yn/2hc1pzqmfZAQq6+lpbkNZSQAnRj0Gj+nUrIUNl5OYmKpH1oFE7IGQi5pIfuE2Kib7vkWCuB/Nu2MQ9Ztovw7wZPK1soJoIBpJkmByz2d5xfGFZf/G9nRJ2WBep+sHUjvRAGr0N4SJT3NCCsFkUjjVdTYNCOJN9mz1PsYamODGEkyUCwwhK/Hk79t1i1+TbDgh1MB3XzzaNgQhIG4xLJWCnpSzB+waMMa7dDk5KTyFjB0BxjkmX3U7xg0fi/fjo2c+xZEAadFA0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVH+jgcxwTW3LjIgbV5cYFEtkmTgHBhpWTQvaiBySv4=;
 b=GgY6NCHu2fbinVVATOGv2fWjjuIaSQGmPjp+AEix06h/pLj9+EsDsqFXcxHIF+h3s5nqjEkmDGxognyTSa9JPfC7/qjehDRWxwlhDicEOLJsVcqmiFVcoSAiEQImqaTTt43gVFV16Ls2rqfIhM4HsNJDl/nJS0N7qi/LDJVzn5g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by VI1PR04MB9761.eurprd04.prod.outlook.com (2603:10a6:800:1df::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 17:48:19 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 17:48:19 +0000
Message-ID: <817b7bd1-f27d-4887-ba3c-e76e906d67bf@cherry.de>
Date: Thu, 9 Jul 2026 19:48:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mtd: nand: raw: rockchip_nfc: fix oobfree length
 calculation
To: Johan Jonker <jbx6244@gmail.com>, kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 trini@konsulko.com, u-boot@lists.denx.de
References: <12b6e0d5-637e-446e-9e4b-82c82e6fad40@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <12b6e0d5-637e-446e-9e4b-82c82e6fad40@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1PEPF00005B70.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::609) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|VI1PR04MB9761:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cd30e2a-e695-4d05-9d1b-08dedde242e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: DZ8z2GcBml3uGgprXyMoTwYUY3vAGr50ezgmwX8QGhdYHQEteKKEQpUhC4NxIENhwEhyX/LUZmXw/+njoQn31MdNW8f6KFOG7BgYZoLgqnetVuQLgAaWAXhrOP5fU5A0qiXLIaQtH57DnY5S5WCQ2YqWTufKRqxg8xdjl8k7s1H49A5NqsMGJ+VyOn4Lx54qbd7ZK41kftI8nfOBcO8NHWI4maBExYKKQYbLWu09Eipl5FRtfN3tcK1UcFdpUdd2NocZjywIDupj6WZT71MFayXhIrh2Pxyz5SCOuGN7AZ6HWw5KUXNKSnOEOZlII2V2R1Ut64ZSyV7CZiyA8iZ6I3EdAvQr1i9FBvxOhLtaTDcF5PikF5IoNmot2aLG0LScCBq15X/f6ozsOZmNoAuet1ucvgVgKYvsD1/FRbR1hq1XWNp6hsIheYsbigdqqM1EX2Ixzj+DDqneNhclt5FXtMlErrRMRFmCkkK5CNSa66+/srllwplxYyllyiGRtwyovSldtV5ab5q0c3NcY+oXwiIdP2NVMZ2wUBxyT4WWcgvQhkYLS+WiU3H1m2YzOBQQZEsIgrz1SlGXnNk44mEB97aU6nGRTIcAgFOycH5TJA3L5+8DItLOT8hth4/BFA8tD0ftf1uXTdUT/ucphU8UKk2OQolUhKwxzHsFjUFPy4s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1RUQi83dlhMS29hZDU3QVpVdi9IMnFWL0Z2Ly9RMUtlZnI5VFpnWDhic2d3?=
 =?utf-8?B?TlFzV0prci9lWkFLblczM1UyWitzMzhpM2NTSVA1YU1YTnkxOUdHUE91djNl?=
 =?utf-8?B?b1pvR0IrMm1YUWdLL3pPT3JxWnFBUkhqRE9JUWlRN2E5U2M5T3AzSXdpSGpB?=
 =?utf-8?B?cGJOYXR3U293dUFyck9seTBBdTgrZGF1b2l0OFNmTTJXLy9pVG5XOTczdzQx?=
 =?utf-8?B?Y3ptcHN3RVpocnFhNmpLUFh4MlhvNDRqa0NYZGRTY2VsK3phQ3RHQ0NOOVFS?=
 =?utf-8?B?Y0VDOHFKSVdHMDFYdGZlVWlXTmVDelhhWXRUcjM4dXRlZTF0VURidTIvVis4?=
 =?utf-8?B?c095b2cyUnl2T3M3MmJPUlRObGF2WWF4cW52TktaS1k4UUJYbW5idDVhdzA0?=
 =?utf-8?B?YStWNUtCd1pKdTMzcjBBM0J0dEg4OGxuNXplaGRyQSs4VGxoNDhKT1BWcVhF?=
 =?utf-8?B?U25zZFJlWGE1TDJhUDhqTXM1UkxuK1hzM2xkTGExM0M2RDAxTEl5dEdGU3FW?=
 =?utf-8?B?RzFxaUxkT3YvWldBek9yL1k4QmJNc0dXalJPMnRRZnFvTHhodjFlR1QvNEh6?=
 =?utf-8?B?RWdzaWd4ZXFrY1Y3cFE0YXk0dGMvQUdiQ3JYdHpQa0l3QkxFRG9UcHkzTU13?=
 =?utf-8?B?b0ZNRlBYV0dxT1FibUNpTHhKemxJSlN4T1RaenVQSFFpbHRQNGJVSEJ4RGFT?=
 =?utf-8?B?bTVac0daSGIrQUZVVkJWOUpIakdvSUJqdU94aVUrMDMybU5sekU0WWVqQWpJ?=
 =?utf-8?B?MCttKytnajRJazZ6K3RwVnMrMGJqL3ZEOURTVXdkZVFhZndtNTZoSWIzZFZ0?=
 =?utf-8?B?WkV4QjFDWDRsbkVoVUtoeW9wOXdLK3Ywb0tvVXZURlNkcGgzRHdWT3gzTGdl?=
 =?utf-8?B?V0ZzaVQrRkVRVVVJTk1wbkU4Uy9FekxCS1FwUzk2cFE4SnZQTU53N0RoMEZQ?=
 =?utf-8?B?NUFINXcyT1BaRU5yZmpyU2JTbnJWTTdwZ0JGMndkOUMrK0p5SkdvSzlLVzQ2?=
 =?utf-8?B?Nmd2QTFUWE10eDJ5SXViK3htWExDM0ZoK05KcVlhTVJNTWw3eUpVVnlDclQx?=
 =?utf-8?B?MklVRDV6Z1hqZ3E1cnVhVHdoOTdwcFlaSG1pL2lrNnVkK2l5MFo3Q0ZETlhY?=
 =?utf-8?B?VWVxbWREeXI4elQrcllYWTdpN3BqRFFzcHlkTWZFejI5MlJ4ZUxhZnZLcm1l?=
 =?utf-8?B?b2JmeFdSL1R6Vi90Y01uTnJ1RHU0YXVXYncrWHFvV3dmbXU4V3VyZ2psU0hv?=
 =?utf-8?B?K3prSWtYSDFkOVIwM09rKzRmUVdvSGxFdXVuRWsxVXJQVEp1QTFnb0V2Y2dh?=
 =?utf-8?B?d0pZNG1qc2VDTjczMXVZd29iT0VLbVYvSi9vSU8vZlBFYTNTVTVSME9ZQ3N2?=
 =?utf-8?B?UGpaekxmbjVkQnJIQnk3dkU1NjNvRzhla2FxbVlUTGFxbE10WUFTYVprK0xp?=
 =?utf-8?B?ZGk5UmJpM0JDQUFMQUVrWnAzNUgvVWxONG04enkzTEJ1MGRYb0hGNDhQYW9M?=
 =?utf-8?B?dTJyU0xpNW01eFVOTWNaeFYyNHpFaS9iQjZLdXVkMWRYUWNyUXc4bEhoTVNH?=
 =?utf-8?B?RERNYklGdDhBNWhGNFFhNnhVZEpsMEVCT21Qbzh4dkdDZU9vR2p2YkVWS0NJ?=
 =?utf-8?B?QjhmZ1c1T28xSGt4RklFeG5HWHB3QlJNS2EwQVY1akV4b3JoRW81YmtOY1ho?=
 =?utf-8?B?Ymt5bTNhV0dWelVLZjFoOHFmbVgzd0E4UFp1S1ZpRisrWHNTUVF5eTgyNHhv?=
 =?utf-8?B?M0tjRHdwSm5TemxvOFQ2T3liNnhVUlVFWmxuUllOREhkaWxENzdEak9SamZr?=
 =?utf-8?B?N3dCMTdTTGhGQy9scjcwWHgvMUFrNGI4L0FzNXlCQUJmdXlTTG9IR0RkcUNs?=
 =?utf-8?B?Wno1T2ozZ0lmRkozWWVrM3psSGlBa0ZEd0Fhajc5a0JSWk93aHBQNzBWblRy?=
 =?utf-8?B?dGRUNnp1M3ZPRVhicjYycGpMSVIwVWdHN2pkMHZXSjRzQkJsUWpuVFMwbkN3?=
 =?utf-8?B?OFIvWENMcFFHK3dUMWdaeGx4RnNMak9SSndKaHZPZkRoUzh4WURBMis5RnlC?=
 =?utf-8?B?TlZ0c1lYeStZMnJQTHd4QmJtWXZYTEQvSVUzTDFQSmtMWDQ1KzBrbjR5ZjEv?=
 =?utf-8?B?Z2dYMTJjYjFqOEM0TmZCYm1JOE9nWGxtKzNuVjBrZnlSdDZKa1ErVUtjM3hD?=
 =?utf-8?B?QmViQWRNcVorWEpiMDlkcHM1Q3ptMER4ZEJVcllWVEplWnJobUtqTjBqUFhw?=
 =?utf-8?B?NVp5SVU1eHlTWlBWK2U2Q1prVTAwREtPK0hzVndMb3IwREJYbkNEYTBObDB3?=
 =?utf-8?B?MTV0cXVYWWRKRGNzOHFsQmZGWkpEL2pzcmJvTUtiNTVvY1MzZ0V3UT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd30e2a-e695-4d05-9d1b-08dedde242e9
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 17:48:19.0843 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jFTHM808vm+rQsb89vSGjnXN1rnYLy6dda8kajz9EUcAjvL9OnvQY7oiKV6UflAir3MuMhsHgemuwqSK9PXJY0K1GmDAl2onNd8OoVyfMDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9761
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

Hi Johan,

On 6/30/26 3:32 PM, Johan Jonker wrote:
> The oobfree[0].length calculation depends on the

Not only that, but also ecc->layout->eccpos[i] just above.

> rknand->metadata_size value, but this is calculated
> after the function rk_nfc_ecc_init is called. Move this
> calculation to a location before it's value is required.
> 
> Fixes: 1b3fcb3c0456 ("mtd: nand: raw: rockchip_nfc: add layout structure")

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
