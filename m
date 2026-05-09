Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60FB4CD343F
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 10:27:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CCD784CC7;
	Sat,  9 May 2026 12:27:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="E7lrEY/V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1D7A84CD5; Sat,  9 May 2026 12:27:18 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85CA684CC3
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 12:27:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yt/4/CVwdcSDn07hUEZOkP1suVg+zkjchQCf4WxJHZuFz15+xIrmNDQoYP4wtFyrpAUujI12rwbhviRpSyBcsAXo8MB3rI3TnJ+NG1ImY+Uy0bFAfQMuq9NWhBefWm4TrxSgA/33mbUX5R1Uzh5lBcjpglsEqvjCz5IWVmrxNvT9zCMd6MKRI0ZeDpv7+0yBicZsucJm15/2pfjH49W7OzEuG5s4E9VhfPELaQjoaaF7GYpFYmj7ib5brbxsdjcRNajgJIJfu5csdgd3TRzU+xCo50hboVMJiOP+NjURWeY/7tloyxX77YxqKwLAV1N7HSxkPtO31WFA8quigYLBpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYQk6bs7kC4jcFySbvgINlqbihtU4GECoRMUJqOw0es=;
 b=x6CZMGglGwk+BeDhTAXQAFIf1DZHnek8tVRMaULp6pDUO6juD36/pOqWTxW7ftOXo98O/LE0YzY2ju1M6nSaZBc9i+4InZYaq5TXt8cFzegm+BOZXlV8NyRE8hOBtWLWftPU7x724eBAbtiU9BSwXfhapJiTe1V2ygZmpRdfwkBJOip67aqHgFZP1uIvK48GGC5VjdpTLzGBDKuRHT2eM0cd0/hGoagmnCWL3+OwRg69Mrwxz7SACuRFIGvgG/qSmvbenCeHk/oYYxGGSw96EOqq2no/RJVHkeLkXJnahb2yLrkcS1908I1HcQc8VjJxF9hxbF25lsegDpDWEcFSRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYQk6bs7kC4jcFySbvgINlqbihtU4GECoRMUJqOw0es=;
 b=E7lrEY/Vm8LAEceJk5YNRZTbg+fKRZRpns5lETko2QrfQwwC6YgEhcJ8i5x2YC65rYnGK+FxnqOJAVZD1ZWPiPesaCU2qfXun/PPk9H1y3v4ZOzcRJvzXQu3p/snr31mSwszX9gRTE5Zme/eDeOukMc3Cm6tqU65gaHqzOEhQxb+/fXj8yH8BMg4EEv1Ggi91qCnCi8X7/amGDLchZStZZkcw2CQsIG3vULMlosGPOWgnC2EhGt5MjDfR4zb+iGWM/18ahYloSY/U57iK4+qZPuk7SsRzwocABSqMJyQiX1tefV4DF5XCfklbF8RwZXbPuxbw8z62RXZdAQahC5//A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PA6PR08MB10417.eurprd08.prod.outlook.com (2603:10a6:102:3cd::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Sat, 9 May
 2026 10:27:11 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 10:27:10 +0000
Message-ID: <f1487e0d-04a4-4ccb-b618-396da085dd29@iopsys.eu>
Date: Sat, 9 May 2026 13:27:06 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/9] pinctrl: airoha: add shared pinctrl code
To: David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Michal Simek
 <michal.simek@amd.com>, Sean Anderson <sean.anderson@linux.dev>,
 Yao Zi <me@ziyao.cc>, Anis Chali <chalianis1@gmail.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>, Crt Mori <cmo@melexis.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>, Markus Gothe
 <markus.gothe@genexis.eu>, Matheus Sampaio Queiroga
 <srherobrine20@gmail.com>, Benjamin Larsson <benjamin.larsson@genexis.eu>
References: <20260504130306.2764862-1-mikhail.kshevetskiy@iopsys.eu>
 <20260504130306.2764862-4-mikhail.kshevetskiy@iopsys.eu>
 <a12b78a1-fc6f-4306-bd7b-40d6f8e6c55b@baylibre.com>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <a12b78a1-fc6f-4306-bd7b-40d6f8e6c55b@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVX0EPF0005F716.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::395) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PA6PR08MB10417:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d9b21db-7b1c-4640-9054-08deadb58726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|921020|56012099003|18002099003|22082099003|3023799003;
X-Microsoft-Antispam-Message-Info: bF3FTbO2l/oy1FZsZx/KXJ71FQWM2u+iq/FrwnV/CSjyW7OQTsmy+pAewJEhdgcrUO7P/m6DDdAeg56/tj9Un4PQ4AVU4DeHdWfMTprhkOZ20NYQzL0xOZZ+zBel1euZw5EgQdoMNvB6uXYS1EGLtkbAgCAI1CMTVpy6g/ZQTr5bZBt8JwJ3TmRPPUMAjzbwNdKxYss+uANOQGPI8lzh9168vCRoksYC8vdZmTh4iq5rv0YTA1qVFDDn7qh9bmH66JAT/+Tc+iHd34iSN0aWLkuBa7vQHRtg1f1zFp77PiuVkPQcqgzmOyllT+51FBem/txhx6mQm7hXhu4WrQHDyR5O52N5gH0Wiv/ltAGBoiO5QpV3zTmw2f2yN81eYs9L+qxNmHZdC9Ga5hfSVF5IktNPjQsxVw0lojMms2l0/izhz8B0nn9vII9mvGGBdQE/pduOhHaoGrskRCL9fQyrFu2Yos0swyq90FrLAZOYZSVGnyOk56cHqkV/mlGuR73zSxxSWD6w/8I21hgak273urDWmrFErXcbE9eJv1K+sHyvxGVca9Rt8w2vT6dHc8wyYXNSg9WHJLcweEOfs5Sc9XF/H1gIEFiTplTzLGPe8Y95G+pqCWikr5xwwJfpM1g4h7BxIJ93n6tHfkq6Fj0VAqmziMASdYBNelN1eKf9tHa7vVrw/fdKWFdMOIvKYahLuManck163IjE3/e/yX6qD0Y1FMGZpVRinMoIl9iNsWNV88Q6+gVxvcpAI3IKclXN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(56012099003)(18002099003)(22082099003)(3023799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXd0cGNNZG9Xb1Bud21qMVlHQy9ITTVjK3dkbUc5KzdDUHBmdjhGeUpiNjFO?=
 =?utf-8?B?VUVybDF5V1g2aFcvdVdpRTBvT0RNYmE1VXhaREpZcEc5N1JvMDZNUGtnYmFv?=
 =?utf-8?B?R1pSMG9JK1hmTThTSFZWUE9raU1DV2JaNU1WSUZ0bjFtNkN3bGVMOW9reDVO?=
 =?utf-8?B?TmtLUk5sNExVdXpXYlNWbmhIbmY0QnlEb2tIMDhsbGl6dGM0eUdBR0k1Yi9D?=
 =?utf-8?B?VFA5QVp6QWoxZFc1MzNpU0RSVytEYzk0KzJvRGdCUWR1T0dBeVJRb2pmbFBR?=
 =?utf-8?B?N0Y4RGhxRVZ1RmhCTFh0cVMzYVlFdHZqRld1R0xZeVVTU1ZSWjdrWWhWcm5w?=
 =?utf-8?B?TmdKSmJod2wrSXArSWsyekMvTFBueWdRbFpSallveVNaUkdOQVBnNVBZUHNx?=
 =?utf-8?B?cUtOWDhSZk5zb3B4S3c5S2t1N3RwVVFLK0hkMEFOd0RTRmNybVRsQWRZQS9v?=
 =?utf-8?B?dU85YVpSRit2R1ZXUVZNK1QwT1hra2hoZFRucU9KdEhhOXZVTGVzVmpQWkdR?=
 =?utf-8?B?TnlBeWFXaFBVay80ZWpBWW5CZXdGZHkrQjZsMXBoSi8xclJqUUtTbS9BMTdI?=
 =?utf-8?B?VHZ0cW84aHlya1NZNnA4dkI4MTNES3UxcTdtUnJzUVM5a0UyRnI1enMxR0Rh?=
 =?utf-8?B?UGRUNmlZN1FUdnlCZGdJY0xhNzJDWXhSVCs2KzdFbXZpZUtiaExjYnIrZkZR?=
 =?utf-8?B?d1NKeUxRK0JqTy9RbjhUYytLeGJ3RE10ZnhUUlNCVVBaNmpEaTh6bFBGbHh1?=
 =?utf-8?B?MTVKNlNJbEdDcEZBOEFvRDlSaHAvSUpFZFJLa1ArbGlsMUp3cHordkVQVlJZ?=
 =?utf-8?B?Mm43L3pOYTJQSkpsOVlqYUIwbGFSZE4xS251Z1lYeUQ3a3FkU3VrVzJ5VjQv?=
 =?utf-8?B?YjdHSm1YTXl4QXRqUk1VeC8ycVVVc2tidSszdlNua3hiSm9UdEtzcXNTeG9I?=
 =?utf-8?B?bmMvclpUeWo5ZGZXY2R5YTEvWnE0WWo2VWd2bXNLVWwxMWxDTmV6MkhpOG9D?=
 =?utf-8?B?U1VLRk5KdU5iK1Y1VUwraGNPRlMrQnpGMjhHcWgyTEUwdzdFWDFFa1ZvaVNE?=
 =?utf-8?B?OEZwb2tRemhKSk84a01mOVZIcEFZMHlJeGp6SkJScENyelpsQjU2Z0lyR0R1?=
 =?utf-8?B?R09XRUw2ZVFZT2NYdEd6bDUxWE9lUDJuOHdUM2dVRzJDUzc0Wk9tQVAyMURY?=
 =?utf-8?B?UUhGWmtjSDBtT0RremdXemptcGpxMzA2aWdkSUVjYzhXQnpweWVqRzE0T01x?=
 =?utf-8?B?bkt2bXh5Z0Izc2dwWDA1cUhYeldtTTNJbzZhVGNwQlUxekdLb1pMR3B0VVZo?=
 =?utf-8?B?TXFTOWh3WDZKZ3hZQ05aQThKWHh6QXdHL3EvL2w1Tk9weHphNmM2YUlEM2t6?=
 =?utf-8?B?b2tQZ2hYZmNnemVCeENIK0dNR25Ia0dON0szZzI4MnpEcXFQbjlkOHpnNDRE?=
 =?utf-8?B?bUlxVS9EZ2pDc1RNUDFQbm1SdXhHVFN1VjlBU09rdWZpTWx5TWhwOXRXSTZk?=
 =?utf-8?B?MWR3ZXZndDcxWlZveWxrb1hHNWwybnVqRUVtYk8zU1JQbFg1M1owVUhBMGty?=
 =?utf-8?B?ckwyMXVUcFRrRGtnL2sxNGNLTTI1YlcrQ1R1TUx2a2dXWTM4MlNBNHdsbzNS?=
 =?utf-8?B?dTBmdWtJMkpmdFVFbGw1Q29TdnZtaDNLS1l0ZzZMU3lmcHQ5aFY2VFFOVnl3?=
 =?utf-8?B?cFVQazhIUFdoRHhGc3dGa0tGZWFyZkhSVUNoQWVnZUlQUGFaU0xvSTRiM1Qz?=
 =?utf-8?B?dlp1RkV0R3loamhyaFoxN0tBVUU3UmlUeEVrZS9tZS8zMXIzcXBvNlpOa1cz?=
 =?utf-8?B?dUFJSlVSMjErZlJ0M1BYTXo3VEVlQkhZWEtFditXTDhPWFc1dzNRRnNDd3l0?=
 =?utf-8?B?MWVTTnVjaWlPTXlRTUMwaGd6aE9wUEtPM3J2cEN5RmFHY3ZFclFWRHlubkZZ?=
 =?utf-8?B?L2RScnhrYlh5N1JFajRYRWhSdU5COHppMTJRVkN5SWM3QlhCUDBvRTRRT0dr?=
 =?utf-8?B?RE95Qm5wd0RBV0FWVWtEcDJTOE55RjhoTmxHbDFzNHB2V3RqWmdxZFhybkZx?=
 =?utf-8?B?aDMzSHEvTlM3TEtFWFlLNElwSDc3T0lPa1Fyb2dZYUR2TWg0QUhlTG5kdWJi?=
 =?utf-8?B?ZkZQK29LYUljKzR2NHJyWFpGNTRFQXRIV1E2bnEzaVljMUxWNjdxQWRVU295?=
 =?utf-8?B?aTdlbUFvYmZ2b2xPMFJubXY3TUU3M3ROUnF0cHBXU2cwTjFVNlVqd2F2QitX?=
 =?utf-8?B?Y0lXYmRZbEpLZDFSVHBnTk02bklLRGpLNStSMGFwblg4cXpIS2VId243azlG?=
 =?utf-8?B?ZDJCY01uRkVENVJYWUlVVGRkL253Z1J0bmJOTnMyazQyTXJhNVp2WDduM1RF?=
 =?utf-8?Q?q/5JgrIoSsMvFO4c=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9b21db-7b1c-4640-9054-08deadb58726
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 10:27:10.3242 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQShCWVyy3OZ58CVmj8oE1AX+EXSGC2E062IwbThc94D8FhC7tySO0R2E7xy82WaXThPsGKvizNiGtKdeocXfgd7N1i7gd5i31m+d9CL6x4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10417
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

On 5/7/26 01:31, David Lechner wrote:
> On 5/4/26 8:03 AM, Mikhail Kshevetskiy wrote:
>> This patch introduce shared Airoha pinctrl code.
>>
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> ---
>>  drivers/pinctrl/Kconfig                 |   1 +
>>  drivers/pinctrl/Makefile                |   1 +
>>  drivers/pinctrl/airoha/Kconfig          |  11 +
>>  drivers/pinctrl/airoha/Makefile         |   3 +
>>  drivers/pinctrl/airoha/airoha-common.h  | 512 ++++++++++++++
>>  drivers/pinctrl/airoha/pinctrl-airoha.c | 843 ++++++++++++++++++++++++
>>  6 files changed, 1371 insertions(+)
>>  create mode 100644 drivers/pinctrl/airoha/Kconfig
>>  create mode 100644 drivers/pinctrl/airoha/Makefile
>>  create mode 100644 drivers/pinctrl/airoha/airoha-common.h
>>  create mode 100644 drivers/pinctrl/airoha/pinctrl-airoha.c
> I don't remember if I asked before...
>
> Should we add a MAINTAINERS entry for this new directory?

Good questions. Probably Markus Gothe or Benjamin Larsson are better
maintainers candidates.

Markus Gothe, Benjamin Larsson what do you think?

>
>> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
>> index 578edbf8168..46a95a1ab6b 100644
>> --- a/drivers/pinctrl/Kconfig
>> +++ b/drivers/pinctrl/Kconfig
>> @@ -405,6 +405,7 @@ config SPL_PINCTRL_ZYNQMP
>>  
>>  endif
>>  
>> +source "drivers/pinctrl/airoha/Kconfig"
>>  source "drivers/pinctrl/broadcom/Kconfig"
>>  source "drivers/pinctrl/exynos/Kconfig"
>>  source "drivers/pinctrl/intel/Kconfig"
>> diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
>> index 29fb9b484d0..b03e838ab39 100644
>> --- a/drivers/pinctrl/Makefile
>> +++ b/drivers/pinctrl/Makefile
>> @@ -24,6 +24,7 @@ obj-$(CONFIG_PINCTRL_PIC32)	+= pinctrl_pic32.o
>>  obj-$(CONFIG_PINCTRL_EXYNOS)	+= exynos/
>>  obj-$(CONFIG_PINCTRL_K210)	+= pinctrl-k210.o
>>  obj-$(CONFIG_PINCTRL_MESON)	+= meson/
>> +obj-$(CONFIG_PINCTRL_AIROHA)	+= airoha/
> I still think this could be better placed. It looks like there is
> at leaset some attempt to put these in alphabetical order.
will fix.
>
>>  obj-$(CONFIG_PINCTRL_MTK)	+= mediatek/
>>  obj-$(CONFIG_PINCTRL_MSCC)	+= mscc/
>>  obj-$(CONFIG_ARCH_MVEBU)	+= mvebu/
>> diff --git a/drivers/pinctrl/airoha/Kconfig b/drivers/pinctrl/airoha/Kconfig
>> new file mode 100644
>> index 00000000000..eb87afbb374
>> --- /dev/null
>> +++ b/drivers/pinctrl/airoha/Kconfig
>> @@ -0,0 +1,11 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +
>> +config PINCTRL_AIROHA
>> +	depends on ARCH_AIROHA
>> +	select PINCTRL_FULL
>> +	select PINCTRL_GENERIC
>> +	select PINMUX
>> +	select PINCONF
>> +	select REGMAP
>> +	select SYSCON
>> +	bool
>> diff --git a/drivers/pinctrl/airoha/Makefile b/drivers/pinctrl/airoha/Makefile
>> new file mode 100644
>> index 00000000000..a25b744dd7a
>> --- /dev/null
>> +++ b/drivers/pinctrl/airoha/Makefile
>> @@ -0,0 +1,3 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +obj-$(CONFIG_PINCTRL_AIROHA)		+= pinctrl-airoha.o
>> diff --git a/drivers/pinctrl/airoha/airoha-common.h b/drivers/pinctrl/airoha/airoha-common.h
>> new file mode 100644
>> index 00000000000..af4964bf25d
>> --- /dev/null
>> +++ b/drivers/pinctrl/airoha/airoha-common.h
>> @@ -0,0 +1,512 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +#ifndef __AIROHA_COMMON_HEADER__
>> +#define __AIROHA_COMMON_HEADER__
>> +
> ...
>
>> +static const u32 gpio_data_regs[] = {
>> +	REG_GPIO_DATA,
>> +	REG_GPIO_DATA1
>> +};
>> +
>> +static const u32 gpio_out_regs[] = {
>> +	REG_GPIO_OE,
>> +	REG_GPIO_OE1
>> +};
>> +
>> +static const u32 gpio_dir_regs[] = {
>> +	REG_GPIO_CTRL,
>> +	REG_GPIO_CTRL1,
>> +	REG_GPIO_CTRL2,
>> +	REG_GPIO_CTRL3
>> +};
>> +
>> +static const u32 irq_status_regs[] = {
>> +	REG_GPIO_INT,
>> +	REG_GPIO_INT1
>> +};
>> +
>> +static const u32 irq_level_regs[] = {
>> +	REG_GPIO_INT_LEVEL,
>> +	REG_GPIO_INT_LEVEL1,
>> +	REG_GPIO_INT_LEVEL2,
>> +	REG_GPIO_INT_LEVEL3
>> +};
>> +
>> +static const u32 irq_edge_regs[] = {
>> +	REG_GPIO_INT_EDGE,
>> +	REG_GPIO_INT_EDGE1,
>> +	REG_GPIO_INT_EDGE2,
>> +	REG_GPIO_INT_EDGE3
>> +};
> Putting these arrays in the header isn't a good idea. Each compile
> unit (C file) that includes this header will have them repeated. It
> looks like they are only used in pinctrl-arioha.c anyway, so they
> should should just be moved there.
will fix
>
>> diff --git a/drivers/pinctrl/airoha/pinctrl-airoha.c b/drivers/pinctrl/airoha/pinctrl-airoha.c
>> new file mode 100644
>> index 00000000000..11830c44612
>> --- /dev/null
>> +++ b/drivers/pinctrl/airoha/pinctrl-airoha.c
>> @@ -0,0 +1,843 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Author: Lorenzo Bianconi <lorenzo@kernel.org>
>> + * Author: Benjamin Larsson <benjamin.larsson@genexis.eu>
>> + * Author: Markus Gothe <markus.gothe@genexis.eu>
>> + * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> + */
>> +#include <dm.h>
>> +#include <dm/device_compat.h>
>> +#include <dm/device-internal.h>
>> +#include <dm/lists.h>
>> +#include <dm/ofnode.h>
>> +#include <asm-generic/gpio.h>
>> +#include <dt-bindings/pinctrl/mt65xx.h>
>> +#include <regmap.h>
>> +
>> +#include <syscon.h>
>> +#include <asm/arch/scu-regmap.h>
> Not sure I understand the organization of the includes
> above. Why the blank line between regmap and syscon? Why
> not everything in alphabetical order?
No special ordering. Just a kind of ecstatic.
Will fix a bit.
>> +
>> +#include "airoha-common.h"
>> +
>> +
>> +static int pin_in_group(unsigned int pin, const struct pingroup *grp)
>> +{
>> +	for (int i = 0; i < grp->npins; i++) {
>> +		if (grp->pins[i] == pin)
>> +			return 1;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int pin_to_gpio(struct airoha_pinctrl *pinctrl, unsigned int pin)
>> +{
>> +	struct airoha_pinctrl_match_data *data = pinctrl->data;
>> +
>> +	if ((pin < data->gpio_offs) ||
>> +	    (pin > data->gpio_offs + data->gpio_pin_cnt))
> Should this be >= for the upper bound check?
>
> Also has unnecessary ().
nice catch, will fix
>
>> +		return -EINVAL;
>> +
>> +	return pin - data->gpio_offs;
>> +}
>> +
>
>
>> +static int airoha_pinctrl_get_conf(struct airoha_pinctrl *pinctrl,
>> +				   enum airoha_pinctrl_confs_type conf_type,
>> +				   int pin, u32 *val)
>> +{
>> +	const struct airoha_pinctrl_confs_info *confs_info;
>> +	const struct airoha_pinctrl_reg *reg;
>> +
>> +	confs_info = &pinctrl->data->confs_info[conf_type];
>> +
>> +	reg = airoha_pinctrl_get_conf_reg(confs_info->confs,
>> +					  confs_info->num_confs,
>> +					  pin);
>> +	if (!reg)
>> +		return -EINVAL;
>> +
>> +	if (regmap_read(pinctrl->chip_scu, reg->offset, val))
>> +		return -EINVAL;
>> +
>> +	*val = (*val & reg->mask) >> __ffs(reg->mask);
> field_get()?
will fix
>
>> +
>> +	return 0;
>> +}
>> +
>> +static int airoha_pinctrl_set_conf(struct airoha_pinctrl *pinctrl,
>> +				   enum airoha_pinctrl_confs_type conf_type,
>> +				   int pin, u32 val)
>> +{
>> +	const struct airoha_pinctrl_confs_info *confs_info;
>> +	const struct airoha_pinctrl_reg *reg = NULL;
>> +
>> +	confs_info = &pinctrl->data->confs_info[conf_type];
>> +
>> +	reg = airoha_pinctrl_get_conf_reg(confs_info->confs,
>> +					  confs_info->num_confs,
>> +					  pin);
>> +	if (!reg)
>> +		return -EINVAL;
>> +
>> +	if (regmap_update_bits(pinctrl->chip_scu, reg->offset, reg->mask,
>> +			       val << __ffs(reg->mask)))
> field_prep()?
will fix
>
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>> +
>> +static int airoha_pinconf_get_direction(struct airoha_pinctrl *pinctrl, u32 p)
>> +{
>> +	int gpio;
>> +
>> +	gpio = pin_to_gpio(pinctrl, p);
>> +	if (gpio < 0)
>> +		return gpio;
>> +
>> +	return airoha_gpio_get_direction(pinctrl, gpio);
>> +}
>> +
>> +static int airoha_pinconf_get(struct airoha_pinctrl *pinctrl,
>> +			      unsigned int pin, unsigned long *config)
>> +{
>> +	enum pin_config_param param = pinconf_to_config_param(*config);
>> +	u32 arg;
>> +
>> +	switch (param) {
>> +	case PIN_CONFIG_BIAS_PULL_DOWN:
>> +	case PIN_CONFIG_BIAS_DISABLE:
>> +	case PIN_CONFIG_BIAS_PULL_UP: {
>> +		u32 pull_up, pull_down;
>> +
>> +		if (airoha_pinctrl_get_pullup_conf(pinctrl, pin, &pull_up) ||
>> +		    airoha_pinctrl_get_pulldown_conf(pinctrl, pin, &pull_down))
>> +			return -EINVAL;
>> +
>> +		if (param == PIN_CONFIG_BIAS_PULL_UP &&
>> +		    !(pull_up && !pull_down))
>> +			return -EINVAL;
>> +		else if (param == PIN_CONFIG_BIAS_PULL_DOWN &&
>> +			 !(pull_down && !pull_up))
>> +			return -EINVAL;
>> +		else if (pull_up || pull_down)
>> +			return -EINVAL;
>> +
>> +		arg = 1;
>> +		break;
>> +	}
>> +	case PIN_CONFIG_DRIVE_STRENGTH: {
>> +		u32 e2, e4;
>> +
>> +		if (airoha_pinctrl_get_drive_e2_conf(pinctrl, pin, &e2) ||
>> +		    airoha_pinctrl_get_drive_e4_conf(pinctrl, pin, &e4))
>> +			return -EINVAL;
>> +
>> +		arg = e4 << 1 | e2;
>> +		break;
>> +	}
>> +	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
>> +		if (airoha_pinctrl_get_pcie_rst_od_conf(pinctrl, pin, &arg))
>> +			return -EINVAL;
>> +		break;
>> +	case PIN_CONFIG_OUTPUT_ENABLE:
>> +	case PIN_CONFIG_INPUT_ENABLE:
>> +		arg = airoha_pinconf_get_direction(pinctrl, pin);
>> +		if (arg != param)
> How does this work? It looks like airoha_pinconf_get_direction()
> returns enum gpio_func_t or negative error code.
>
> Should we check for error first before comparing?
>
> Do we need some kind of conversion between enum gpio_func_t and
> enum pin_config_param in airoha_pinconf_get_direction()?
The bug caused by linux driver porting, will fix.
>> +			return -EINVAL;
>> +
>> +		arg = 1;
>> +		break;
>> +	default:
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	*config = pinconf_to_config_packed(param, arg);
>> +
>> +	return 0;
>> +}
>> +
>> +static int airoha_pinconf_set_pin_value(struct airoha_pinctrl *pinctrl,
>> +					unsigned int p, bool value)
>> +{
>> +	int gpio;
>> +
>> +	gpio = pin_to_gpio(pinctrl, p);
>> +	if (gpio < 0)
>> +		return gpio;
>> +
>> +	return airoha_gpio_set(pinctrl, gpio, value);
>> +}
>> +
>> +static int airoha_pinconf_set(struct airoha_pinctrl *pinctrl,
>> +			      unsigned int pin, unsigned long *configs,
>> +			      unsigned int num_configs)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < num_configs; i++) {
>> +		u32 param = pinconf_to_config_param(configs[i]);
>> +		u32 arg = pinconf_to_config_argument(configs[i]);
>> +
> In all of the cases below, I would expect that we should be checking
> the return value for error. Or add a comment on why it is safe to ignore
> the return value if that is the case.
will fix
>> +		switch (param) {
>> +		case PIN_CONFIG_BIAS_DISABLE:
>> +			airoha_pinctrl_set_pulldown_conf(pinctrl, pin, 0);
>> +			airoha_pinctrl_set_pullup_conf(pinctrl, pin, 0);
>> +			break;
>> +		case PIN_CONFIG_BIAS_PULL_UP:
>> +			airoha_pinctrl_set_pulldown_conf(pinctrl, pin, 0);
>> +			airoha_pinctrl_set_pullup_conf(pinctrl, pin, 1);
>> +			break;
>> +		case PIN_CONFIG_BIAS_PULL_DOWN:
>> +			airoha_pinctrl_set_pulldown_conf(pinctrl, pin, 1);
>> +			airoha_pinctrl_set_pullup_conf(pinctrl, pin, 0);
>> +			break;
>> +		case PIN_CONFIG_DRIVE_STRENGTH: {
>> +			u32 e2 = 0, e4 = 0;
>> +
>> +			switch (arg) {
>> +			case MTK_DRIVE_2mA:
>> +				break;
>> +			case MTK_DRIVE_4mA:
>> +				e2 = 1;
>> +				break;
>> +			case MTK_DRIVE_6mA:
>> +				e4 = 1;
>> +				break;
>> +			case MTK_DRIVE_8mA:
>> +				e2 = 1;
>> +				e4 = 1;
>> +				break;
>> +			default:
>> +				return -EINVAL;
>> +			}
>> +
>> +			airoha_pinctrl_set_drive_e2_conf(pinctrl, pin, e2);
>> +			airoha_pinctrl_set_drive_e4_conf(pinctrl, pin, e4);
>> +			break;
>> +		}
>> +		case PIN_CONFIG_DRIVE_OPEN_DRAIN:
>> +			airoha_pinctrl_set_pcie_rst_od_conf(pinctrl, pin, !!arg);
>> +			break;
>> +		case PIN_CONFIG_OUTPUT_ENABLE:
>> +		case PIN_CONFIG_INPUT_ENABLE:
>> +		case PIN_CONFIG_OUTPUT: {
>> +			bool input = param == PIN_CONFIG_INPUT_ENABLE;
>> +			int err;
>> +
>> +			err = airoha_pinmux_set_direction(pinctrl, pin, input);
>> +			if (err)
>> +				return err;
>> +
>> +			if (param == PIN_CONFIG_OUTPUT) {
>> +				err = airoha_pinconf_set_pin_value(pinctrl,
>> +								   pin, !!arg);
>> +				if (err)
>> +					return err;
>> +			}
>> +
>> +			break;
>> +		}
>> +		default:
>> +			return -EOPNOTSUPP;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>
>> +/**************************
>> + * pinctrl driver interface
>> + **************************/
>> +static int airoha_get_pins_count(struct udevice *dev)
>> +{
>> +	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
>> +
>> +	return pinctrl->data->num_pins;
>> +}
>> +
>> +static const char *airoha_get_pin_name(struct udevice *dev, unsigned selector)
> Inconsitent use of unsigned. Preferred is unsigned int. 
will fix
>
>> +{
>> +	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
>> +
>> +	return pinctrl->data->pins[selector].name;
>> +}
>> +
>
>> +static int airoha_pinconf_set_handler(struct udevice *dev, unsigned pin_selector,
>> +				      unsigned param, unsigned argument)
>> +{
>> +	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
>> +	unsigned long configs[1] = { pinconf_to_config_packed(param, argument) };
>> +	unsigned int pin = pinctrl->data->pins[pin_selector].number;
>> +
>> +	dev_dbg(dev, "enabling %s=%d property for pin %s\n",
>> +		airoha_pinconf_params[param].property, argument,
> This will result in out of bounds access. param is not the index but rather
> a field in the struct in the array.
>
> Easiset would be to just print numeric value of param, otherwise we need a
> lookup function.
yeah, will create a lookup function.
>> +		airoha_get_pin_name(dev, pin_selector));
>> +
>> +	return airoha_pinconf_set(pinctrl, pin, configs,
>> +				  ARRAY_SIZE(configs));
>> +}
>> +
>> +static int airoha_pinconf_group_set_handler(struct udevice *dev, unsigned group_selector,
>> +					    unsigned param, unsigned argument)
>> +{
>> +	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
>> +	unsigned long configs[1] = { pinconf_to_config_packed(param, argument) };
>> +
>> +	dev_dbg(dev, "enabling %s=%d property for pin group %s\n",
>> +		airoha_pinconf_params[param].property, argument,
> ditto
>
>> +		airoha_get_group_name(dev, group_selector));
>> +
>> +	return airoha_pinconf_group_set(pinctrl, group_selector,
>> +					configs, ARRAY_SIZE(configs));
>> +}
>> +
>> +static int airoha_get_pin_muxing(struct udevice *dev, unsigned int selector,
>> +				 char *buf, int size)
>> +{
>> +	struct airoha_pinctrl *pinctrl = dev_get_priv(dev);
>> +	struct airoha_pinctrl_match_data *data = pinctrl->data;
>> +	const char *name, *type;
>> +	int ret, gpio, found = 0;
>> +	unsigned long config;
>> +	unsigned int param, pin;
>> +	u32 val;
>> +
>> +	pin = data->pins[selector].number;
>> +	for (int i = 0; i < data->num_grps; i++) {
>> +		if (!pin_in_group(pin, &data->grps[i]))
>> +			continue;
>> +
>> +		name = data->grps[i].name;
>> +		for (int j = 0; j < data->num_funcs; j++) {
>> +			if (!func_grp_active(pinctrl, &data->funcs[j], name))
>> +				continue;
>> +
>> +			ret = snprintf(buf, size, "%s(%s)",
>> +				       data->funcs[j].desc.name, name);
> Should use scnprintf(). snprintf() returns the number that would have been
> written, which can be larger than number actually written.
>
> Same applies elsewhere in this patch.
>
will fix
