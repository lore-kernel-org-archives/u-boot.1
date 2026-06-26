Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9F6C43458
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 18:40:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 857A68404D;
	Fri, 26 Jun 2026 20:40:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="F9eY9zHA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD3CA8460E; Fri, 26 Jun 2026 20:40:42 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD6AB83FEE
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 20:40:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n7AuxPCS0MLfjV5GQJdv8aPasCkEzq1DVvoqtyExEt/G7C9PlOnhG0vPIIeml1uNZ1Bu9flSmabqOY1yiKunQDwcyiVjlO91IHn+6lw7pInZaDwfV4AJDS9mhhr/aeOXyA1oOtFMRSzmGxiLGS27OkfmXIK6EybKvQ3hGu4Q6zchBr/i+0QsZcanotjnOi6kL4WCp9+YkfHkF8+UK++081kK1s6tpSshNZ8WA+ii/EWjyCtIlmIVm6TSOf8M7YVuVDVGXWcsb7FeVwOHFlWePHBNHkx7x2G43hSJP9EyNnOf/ljd974uCpd0tVBNVhYa2115JSP8zyNj4qzWhkXekg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8X5Kxoh7qtT7EjNieZScCzDvtdjws4TEr/0Qvh1X3OE=;
 b=xYL26U6uskI5Isx2xI+3Hui4JWEKWeGZaycJEzK1NzqACi4ct6WY6QYNejB3cu1+Qi/pq1+JSQvHSjZ5sg/04vkaS6UCofnVz/wDQa5r3RdSOq2xtEYXf9paA70ZW6QhNg/4Bq5+O8o/7q1baNjW8wl39GbkBpyEHxvpn7GfVl3NxZBfubAIcEPa3AX844F8LiX7DM+n8gR4BZNfGybuA735dtbIcGTDExQht/hFqyQXMuBFg8UgcJkFTpsUxjrgh8hMsJT9w5FiueV5+TXpHuELlnxyzMVSMYX6YLerqzg+oML+e5wlBR4zhbp/kOU4HyksL87RYOgsvJQc2G3N+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8X5Kxoh7qtT7EjNieZScCzDvtdjws4TEr/0Qvh1X3OE=;
 b=F9eY9zHApTMLboe04oxmOGIzMdDxnqewn8PusQsthwdBYAILS6rlONy7w0fY0++IMc0s5gVyeoEDpY60IH6V+NXncsyBJWZchXMBG6ksyxlQfo8FSCgeZIp095NexuxMlqk+zCBAJ2rEaUUZ/faeDDioAkGcBM+QDm1DIJpUjTU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AM7PR04MB6776.eurprd04.prod.outlook.com (2603:10a6:20b:103::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 18:40:38 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 18:40:38 +0000
Message-ID: <3dfd02eb-fcc1-49d1-aea2-6bd20f052692@cherry.de>
Date: Fri, 26 Jun 2026 20:40:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test: cmd: part: fix integer handling in
 setup_gpt_partitions()
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20260626183353.1666667-1-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260626183353.1666667-1-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0034.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::23) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AM7PR04MB6776:EE_
X-MS-Office365-Filtering-Correlation-Id: 999ed6ea-2c5a-458b-d801-08ded3b26a8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: jXkSfZJqyRCha64HM48Hbsvx3Nsq/0eJ4hSSXKo0hPV7vaIUxIIvza1eL4TeBRb4p4YaH9t17P+jilmQEkLNesG6i1IJsCp7OP5CPolVRwVs7QOTG8nPvegZBrPWnDTy1YIbyETYKJPbSDasRElW3/BZRKbzKO9F6oGvdEmljANaGakEtQqk0Slb1B/GE0fYpX3M2mk5OHGs/K3/eKJzNoZxyV7D0p76fx1+47Dn7lyXKrfIbjsoAK/g/tFoL5G9YpLrClT5gvgCAwOFMfbSYmh+Hi0ru10/d7IOc+gI1kM0eGqoW6oywWhe3+BFnlUbVbMRd3ozyZ1n2wzseeMaSFHPndPQqwqr/gNFdO8En1h1EBIFolQOGPIdKPM03oD3N0R0uVRj+QZDSq4M6PEl+ivY+jGWhJVfXeA12atMdrepSNglJov2o6B4OJDDVdIvEPE2Na81vbLn8pZFiGKaiys+Cc3F5WalikQGn/Qph3gx9RzsG/3nzxDY6cJJpF61gH6tliYC0F/q9q1ssYHHM9lI+uhQv8tRcSDARKW75YOCWkpMQjYeJtWMsYoEUpA3bILE8nxg5MOKiNTJ535Mf/dHP7rVTwDUjHLkiqwp23xFcJ6R3ohembnv/nU0HBksFSeh6nktceoZMYzOg2KIhWWr68HJ4DcvmCvELfUqUU0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1dCbGpibW5GNWJSaUN6d2F0U21TRnJkM2Z1azJmNFEzdmlkNHBlS1AyQlFC?=
 =?utf-8?B?UitDb2JwRCt1NldQN054a3VUS2czZlkxbUkyaTlPeVNvRVFwcDFZcE1OQUpG?=
 =?utf-8?B?TlB0ZDNid3NlbVhwbjNQVWtsQWtTM0VQVUM3MkxWSG5OazN4R2JRem5ZSDh4?=
 =?utf-8?B?TDJicXl5U05NbUl4WXlhb0FTaGlhZkttVHM2N2YvdTl1SW4rQzhwTXRIOUZL?=
 =?utf-8?B?cVUxRXNHbUpwdXdYZEg4NDRMcEI5MHU3UkhwaDdPdEdraFAyWWE2SDY1N2xN?=
 =?utf-8?B?a1ZSZDdadUFjME9nZVNmQXF0d1NjZC8wdnY3Zm9LWXBIZGJOWkd1eHhQQ3Fv?=
 =?utf-8?B?S1FHQWQ0UnA5OW5nekIvR3JRZXF4SzJZMjcxVG5qc1RPOEVYWnRBb1ZycnBz?=
 =?utf-8?B?d01ya0pwd3hkQ1hLOFlKa2IvWTR5SGtDV3BYNk9JQWlhQXQ3WTBGOE9SVGpG?=
 =?utf-8?B?Y2t2VVBuWHRrbTZSeFZwM1dNRjh6QWVyVzRZaWxOM0hwMnRHWEo2TlQrSFVp?=
 =?utf-8?B?OGxvRnZjTWVicENZRUM0U0oxL1AwU0tWZjdMYUxWZlJzZGVmcWlsc0JndFNj?=
 =?utf-8?B?eEl5QUt1V05ueVlpb2dpMlpSdElsZTIvREpiazdvZGs1ZkhhNDVaMGhhaXl5?=
 =?utf-8?B?cU9sOVU5QjgvTkZoZG9wWnFrZTdQTTlRS3BmeGJ6V0tUcXBlRTNCY3k3cmlv?=
 =?utf-8?B?UFpHZUgrTEcrR0V3RzhqN3pjS21TTTAwYmtwNHhNdlI1dVltcXJQZ2Z0SXNI?=
 =?utf-8?B?V1V6a3lTQ1UwMDNTaVQreXRYOUxodVdRSUduNzlFYUEzUDd1T1ZIbXJQU3pv?=
 =?utf-8?B?dXZqSnZHSGhVQzBwbUQ4ZTZ1WXhCK2JnSkVuQ2hST2FpckVMN3dZandhQWlJ?=
 =?utf-8?B?dFo5T1FlUWk0Mm9BYmVnQXQxVWMxUVBDVzB4VmM5cnY5UWp0eHpBVDFDTEcx?=
 =?utf-8?B?ZlpFa2lWWEd1djJQOUVMQXFDNlBNVkdkRFBqdDcxdWpWR0RNUHpKai90bjRx?=
 =?utf-8?B?VkJlZzBFNWNkMkUvTUtRMHhBUGtaZUdBaU8yMEpXVDZhYU9hWFZ0WTlqSTRI?=
 =?utf-8?B?cXAzaytpK0tQV0hkcnJoWXlHRGFINUNpN003RVdZNmVUZkJQU29CMVBkYUpY?=
 =?utf-8?B?R0xHanIzOUtvaUJuUHBRcjBCVCt5aDk1ZW5xOFpsRHdBU2U0cWVnbWI1d2ZH?=
 =?utf-8?B?VjA2K0hQTmRVdnJxZzErWFhMNzJrR1N6akUwQXNLNUdRd3Zxb3ozOWNDRW50?=
 =?utf-8?B?Y0xGL3gxaDM3WkwwRzdzS29tMElXUXIrR3RWUTBjL0lPZjFpeGEvcmZ6SjJo?=
 =?utf-8?B?NGJJVnkrQUlCTjFMRGJVOXpTTGhoV2VBbHU3aEx4SHBWTFdBM1hqalZyWU1t?=
 =?utf-8?B?YXgvQzVJYkNNM2J2bmFveU0wTlI1blg4N1VldEIvVTJoamxualIya09hcWZi?=
 =?utf-8?B?RUxhbzA1bmFtamVEOUFCUm5ncmRzcFVZTnUrekd4SXNIZmFHSHB0Ni9wdW9Q?=
 =?utf-8?B?elRDWUNqVnR4VjQyM2Y1UzRVbDV0a2UxY0xuK2tRWUZIdG13b1MrUmJsOUNE?=
 =?utf-8?B?aGxyNHlnVGVxcDVBK1NWZGRHbDZKVGdpQUZqbUJIbk5KTW40NUpPUzJSOHFJ?=
 =?utf-8?B?RktIYzBKU0dwb1Eyenl0ZEp5VW9BUXhtbXNxdUIrZ1F3TnNnZ3p1akV4RjhP?=
 =?utf-8?B?aG11UTJab054MTVlOWJsVkNEakZGVGJzU2dQbWZvRCtzQUh6WXpkZWhJcTlO?=
 =?utf-8?B?dXlPQWVhWWl6MGxJTGw2cGN5bU5ENThhd3BxSkRiT1Z6MXcvbHd4NHliMlFt?=
 =?utf-8?B?allOVXBLOUVkRkRhZlNPcUVsYjhoQk1VOS83VE53aWNBamNPMDhTYnhJd0dz?=
 =?utf-8?B?NjZiTTZRWlhiS1E1UjhjaTVvaHFZeTRrYjBpUDVIN2ZWclV0eVFOVUVLZ1JP?=
 =?utf-8?B?UXIxMnVoaFowQ3ZvZTM5S1J6bHJWV0lhc0FFYndSRy9zbysyanBTUnRVT2c2?=
 =?utf-8?B?RU4vRE9rS0VEYUhnb1g2ZkcwdW84TU1XekM2dCtIUHIwNkl2TmZTbnE2STht?=
 =?utf-8?B?OXFxc3Z6ZTkrT05CT3UwRWx5TDVvME5tUmNlWmlIUXUwZjd4V0JaVEh3UkRh?=
 =?utf-8?B?V1QrelZ6Z2pwVkpQM1dJd3NvbXZkdCtHK0Mzck9veXJwcE5HZnRFYmlQemhM?=
 =?utf-8?B?Q01nV3lUalZPc3hkOWhVL0xTVHNtMnhudllEdkZtL3dNekpLU2lucTg0OExS?=
 =?utf-8?B?bGErVjNwL3pOeWY4bkNnU2wyY3VNRVQ4OFBxdHMyRjYvaXZUdkxkVlBvVTY0?=
 =?utf-8?B?aWhBWHQrVVhOaXFGSWR4ZFJPNGYycklFM3VOcnMvYStjZjBqMFU3dz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 999ed6ea-2c5a-458b-d801-08ded3b26a8a
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 18:40:37.9677 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8shqvllU7tLuQjKEJBRb/LbiOf7U8Qadb4cmQ96vpWG/TCI/tJ1eIkJH+LYGVQAjariO9a2KNuZkZvaxH7gtXbEPRN0nvIG6QTT6MFbJSUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6776
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

Hi Dario,

On 6/26/26 8:33 PM, Dario Binacchi wrote:
> Coverity reports an INTEGER_OVERFLOW issue because ut_asserteq() compares
> an unsigned int (mmc_dev_num) with ret, which can hold a negative error
> code.
> 

The trick here is that ut_asserteq() takes two arguments and casts both 
as unsigned int, hence why it complains.

If Coverity is happy, I'm happy :)

This looks fine to me, so:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
