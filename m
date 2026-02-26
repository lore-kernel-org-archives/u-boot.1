Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAFFDFC5915
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 12:17:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D41883AA9;
	Thu, 26 Feb 2026 13:17:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="hY8wUsur";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3F0683E83; Thu, 26 Feb 2026 13:17:03 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C5C783642
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 13:16:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f49AmboB+sO5D22uTfYRCc780nYUyRwi2USMFxuO9CtVsPLoYDCENliTkcVrgsEMTWv5ea9N54Fi/VVRtdcMpHBWHCAqI6ocprtZpGUuecMLQ9Rpw1gjiVnZOouu3lOZgrsUXfYk8jKoZVr0n/yLWuX/3HQSt1o9unsEz7UQd7Ugbjg/Rq2sb1vqzdAT5d3uJE2Y4WvGVlX0fNKbKqd8s9mIFFunzp6x1AFh34q5S3bzZ+X6RNhb8jHirq9XYL2sQhLUVhzozNHC8Z2yOtbF7MM1ldsabJze2/hZMmE+GF6Zx2SpMprqexzOvdmpiZcuwrkheZ2WbAQMmPqSkXzWaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZTreOiRnqKYjsIhCcIuQWUIC26rFfTH++r9mQrwPbQ=;
 b=SXm17fV8NL4MnxA4vjdh7lNRN/G87X2zxXQNfecJfmIdJOTs85Fkh+Dp9Bg48mzxF8S3acJCZYqj9NBYbMhJjofSC1sB5AbKyewH8bWoK0f2ABC4jkQVpoOp8dy/l1VQeS5MNsVY3SKjQDW0cqRKkdCqTG8ATZKTs3glVxmlLuVrn0Mhwoi45Z81ggJqyKBUZ5NeSNfa0I7BZ/csaazXy5Y/n/Lxp7Jxdmp5WOQ2gDD4i90tfUKIlKgdZZProqcvdHvC7K6vauczgyQfdgnFKQI01yQW5mMVNMxoczl75MZOYZEki33oDYD9tZYXyr+nMYC4MC63eYoDL8ZTZhjN+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZTreOiRnqKYjsIhCcIuQWUIC26rFfTH++r9mQrwPbQ=;
 b=hY8wUsurf/X6gYDDIvBkQtY0dGrDAihg8pjSWz+wc/Dt7tjAQtw6dsMfvmzIBdKaWpqM2fo3dtdbP0U92YQv+EzUBcXyMRFBxozCKSOX/vpW9pCBNGjJ3zP+WvuIai0mKCmAsqRyEHmO4gJ9Te07DYoRo67PieboYrMgzgbRvc8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by VI0PR04MB11546.eurprd04.prod.outlook.com (2603:10a6:800:301::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 12:16:54 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%5]) with mapi id 15.20.9654.013; Thu, 26 Feb 2026
 12:16:54 +0000
Message-ID: <1750928c-438e-41d6-a825-ce59123be540@cherry.de>
Date: Thu, 26 Feb 2026 13:16:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] net: do not use non-existent CONFIG_DM_CLK
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260225061426.45981-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260225061426.45981-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0028.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::23) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|VI0PR04MB11546:EE_
X-MS-Office365-Filtering-Correlation-Id: f61b35e0-5371-4195-ec76-08de7530edb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 4WtVnsbbaGxJAgsIzLUs3dX0853HGtiiPdZaWbDzDRtfTxerfRuA8M1bPcvqgmlaqUGJQ+UrunZwSueot4OuGL2sU/u3mo5p1JJGWF6IRHzP4m/MCFg/lEK8WQSjBj/zzj43SoOi6ZhecBpSKAmmJ6sqZZbUNsZxBMAwq+NKF2yBGKZjSQDLeklCBQ4V29lQB1s7LTT8mrKPrcl0Yvr/vXwCcd8dyNf4E58w3ULSAQvYr1o4IvoBsbQJ5iibuPtOybsVoCinIlCHhByHm9VobZCnnTbwdjYgvpE2sGp79kVUpMzUZ+xOQvSU/SSQ/mefW2UzQrRevstuMqhTAW+ybiBJ4/MjEXgCoF0dKHNqI4GK1yse0BZToM6V39lxQa1Bu4Viy8xjJk7sd9JkDHFy909Dk8pRxnnfq964hk057GLM2qO017VGVzq2mHObb6kMIih59sV3LvlTg+zkKDrJziD6p5rscKe0FzBRwt3E2ZPdtgwNbp9jy97IO3D5vACUePq0GuT0pus4E6B8Rm/PSnopfgHaA4qoCbJL6+SPDAAgGOMYSrumwpRESw8e6b+Ng/vAK9tLI437hUdkpgK69Nc1YNDAdo9ipdQBfjVVEGOwNknTt+0ouT7iwj5ECSF8vdWWUD3R8+lTrjs3KOwSKVnBDCJ7mBRS4jeocA7wAFrqJez1CxLxM9BJRDjqiPsbzLiIigpTsqqW8mNbW/Fg9X+hmFPO/W/7XQDRMl3Z66I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkVTVGRpM3ZXUGVkYUtRamc2OEU5QWRJRkVhWjVvYkpqcVJYVllIdFhNbWg0?=
 =?utf-8?B?bVNoUWpDOWhSUTNXNGttTTg0MzBoYlZSbkNqQldTaXdyYy9CUTZQSVRqelBU?=
 =?utf-8?B?TUdXUldpSkJ2TWYyMFVVaVBuZCtOdHRxNUZJclZMQUgzOVpSUUtDaVVMRThm?=
 =?utf-8?B?Z24xcVczQmdSaDFOVzhrWm9nSWhYTFpxZkU0bllVeG5nNzJRRExVTTZuTnRs?=
 =?utf-8?B?QXJhYzh5c3hvdUJJYVFWVEErb09RYlY3V1MxcEVoV3ZTWkE5TmRidEg3MFQw?=
 =?utf-8?B?bGxvZnNFZHR0Vmg5Ylo4bGhzQm5JTndhT0M5Q2VmRGV3RUtJQUxDNnVBMkcw?=
 =?utf-8?B?MmorS2N4MHZMNW9NUndpUTJhUnRqMDBQNlpnT1VkU04wTjJvbGhzRHE4RXRt?=
 =?utf-8?B?cXRndDBSdFVmWGdiN0dYMWsxVVUwNGhTN0duR3hTV05FMXFBUmNSSmE3SU43?=
 =?utf-8?B?RFlEa1g4VzM5SXFMSkJ5ZFZyZDBkTXRhNUwrZk10ak93a05BL2ZuaWFaRFRG?=
 =?utf-8?B?SndwVU1ka25yaXpsdEl2dDkwK3lDT081aXM5aGRJeGYvb3BiT0FaUEN0Ty96?=
 =?utf-8?B?cDBFbEJhTGFmY2UyWCtYNnVzbktTSUUwayt2b1ljTUgwVGlVamJKb0tXalMz?=
 =?utf-8?B?RmpsRHVONlQxeVA1ZG1ETGt5dUVEYmxYMHI4a0dDOUpENk94U2xSNVJ2OUZF?=
 =?utf-8?B?OFh0N25ra0pMTEh1WGlvV1k5R1YrcmNYYi8xUHEvU0FUYmd6NHVyUTBlUEk3?=
 =?utf-8?B?YmNtdHBTZnZmeUMyWEtabmJCZEoyRTdsRFJDeDM1SWUrQnpQQkNIQktqT0gr?=
 =?utf-8?B?VnFTSWo4dUtBU3F5bUNHTUxxeUVheVdqSVFqcTBabTlmRnBtUTNSajNmaGRv?=
 =?utf-8?B?TlBqK3R4WmpHa05uR0ZZNDZTSzh4YjVhazE3b3FKa1JMOEdGYm8zQkpBTUZS?=
 =?utf-8?B?QWhiSlgrbk5aQWJDaUVCa2R3aWdINFBOaVdNYk40a3QraGVtY0dWWHh0bjJt?=
 =?utf-8?B?bkQzNk5NQlRQUk4wVnB3dTA3NjhkUE9IMWxvY0tCdmx0SlNEU1pqRzdzbVRM?=
 =?utf-8?B?SVBnTklwaWE3M2JrZjB2S1VIbkpGOVdNdlZCU1JOQTE3WloxSStwNW11VjNT?=
 =?utf-8?B?RkxPR2ROY0R0aEFoK091cXR6MDV3L04wY0liS1NxalpiK1FnTGJUOUhDUGFr?=
 =?utf-8?B?OTRKaG1TQ0NlSm9LS25KS2pkSy9JRlFyTFRYeGJNdHN5cmFDczB2WVoxbnlT?=
 =?utf-8?B?M3BVZXdDcjBiWGRTZUpHclRkN2NEOEh5RnRFTE5VTHRIdVZ5YlZhSm1LbWph?=
 =?utf-8?B?bndEWXIreXpoVkx4MHE4bytoUC9LREFUbXl2RVRLMTJsdG8xYjh5dDZvSmhx?=
 =?utf-8?B?YXY1Z1pTQ29WZmxuRVpwNmVJdUl5b3NtWUorRGI2dmxvaUZBdEtmUmp4WkFj?=
 =?utf-8?B?SURWUDlZVGVuc1dZUWE1L0Yrb3pKTFUzV290N1BrNHB2VytzbXVCSC9Sam5z?=
 =?utf-8?B?RisyVFVnSnJyMEJUZGUxZ3lJdVRlc0F5ZUV1cXdiVitaSitFN3NHZEpzK2kz?=
 =?utf-8?B?V0liNk5jT2o1aXQ2MTlsS2VISWZIKzhiMnpSSWRDT0VuWHRYalUxbmRLQzFk?=
 =?utf-8?B?QzBlTUdMWGVPSzN5ZEdqSjJnS3duRTgxK2pURXlkdFVKOThZRDB6dGtjOGtx?=
 =?utf-8?B?aDJvZUVKVnZTaEdSMWcwUlF1bmZ6OXRQc0c2MjhxQXZPaUdvcENISWVxR3Yw?=
 =?utf-8?B?NEhtK2tyVStwTTMyMExVWW02RytRb29oV2hYQ3dqd1NYc0xRR3FUaU5qY1E1?=
 =?utf-8?B?S0JjenlaT0cwMDFDT09KR1hlRmoreC9UbFp1Q2RHYkpVMXRnVEJDc01iUGJE?=
 =?utf-8?B?M3BkV0dGTkNJYVY3NnQwWjloeDl4b25UNGY4K1dJS2szVDZXYjkwQ0Fucmlx?=
 =?utf-8?B?S3VlcWpoYkt2c1RRY2VRaHM5Z1dQaFZGS29yS3lmeHlhOEN3TmZmZXZqTkhH?=
 =?utf-8?B?bUM3MXlOWEpwMVJLRjZoSEc1MWdEcER1VzNqdDNLMnpnRG9ZQWpSTkt4QnpE?=
 =?utf-8?B?V0F2OWwvWnhLVElLZXJpU25vOEsrRUZ4dlVEWUZHaFp0OWUvWGNkMmRpclNw?=
 =?utf-8?B?WlZEZHRJSUhLOUtkVnpZZlduNTZFeTVVYXVEWCtIOEZrejVLZkU4WTRRelda?=
 =?utf-8?B?QXdwQTNuckR3N3JaTHcrUDVkMTIwMlpmendBM3ltbFBDZ0F3ZHFKRlR3YzE1?=
 =?utf-8?B?eTVPUGVKbHdUamhjalQxcGFEMHBlMm83YnNTbnJqdCtBQlFHOVJoZ2RtT1lw?=
 =?utf-8?B?djVzSC8zTDBrTXFtRS9Yay9KS3F5aU9IOWdWUWk2bEpnRG5oQ1VQQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f61b35e0-5371-4195-ec76-08de7530edb8
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 12:16:54.2694 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5umgW4hjC8YA5FlWQdKncriD1JHnNntF33Z5PFfCv13wkDSlKkJfwfNPzTIa6mNQAC7A8mpEyxnWvdHsn5CA7kT0YIhsyUc6FOTRcFVd840=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11546
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

Hi Heinrich,

On 2/25/26 7:14 AM, Heinrich Schuchardt wrote:
> For enabling the clock driver we use symbol CONFIG_CLK.
> Select this symbol for the HiSilicon Fast Ethernet Controller driver.
> 

Fixes: 6b5c8d98e204 ("net: add hifemac_mdio MDIO bus driver for 
HiSilicon platform")
Fixes: 9d8f78a2a79f ("net: add hifemac Ethernet driver for HiSilicon 
platform")

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
