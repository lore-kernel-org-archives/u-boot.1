Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F36A3CD3447
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 10:40:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9D9584CD2;
	Sat,  9 May 2026 12:40:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="sETLtTJM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFF2D84CD5; Sat,  9 May 2026 12:40:12 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFB9B84CC9
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 12:40:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/P0eEtxEN6wI0kb3TNSTgOGBC0GRuvTNTjkmiW9SKGn90tI3Mvv6et+PIH+Opdf/k4Zm5EOaPYEOMC5XowifSBE3gGtOMzalNKB4KLcLIuTJKFxbLmA+xz/bLE1A9DbjKsTOBx5Gj9eb/dnEnGEQ5rAgaE9eY1yuIyWEMGFWg88MBYH/wGd//GBsJ8mr+qJFrl9SfcMbrMnNuLNLux85QHeI7qSwP0JxUZ0YKqZ9jyRqWz4SlRWCHSSSfF2jKab9OgRf0jPkLkTl0051shLnxgukhEOudE7RiEzs5PJiC0lJCWErYBzWy5CgGulw/rSS8L8dwYkoly2RxL0SbFcqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ggf3i9G4C1ngRkyYXOGDM9sbDTOsm/n60/mg6VtFHHM=;
 b=WegKAVeOoCmh8hmI16IAZU5NCq+IxdSQw2EtZL7szHg8f7ead9C1/PcRtsZiYnKNCiwJcRQu/5k3vNSJFsEb+nSbDIvLEOhvZPXoit9WWuSTpeouOSko7pgZEqxY4u//vqpw8NfiBjYwGag5c7CKxsr7Zngqk0ImSEPtyCdf/kKzJk84P965KPya9/Ku9+9IzX8MYSZLRaSgCojUKivHiTKR7PO9RD2JV3awLp7ruIFlEuQBuMtg+U+BHYe70FkzYGn62DxqMzBiBlL3ktj45M+Z11VZ+/MVK9YvLKdHT8yk7v0gVB+tPcs4gAYzO9xmnll4n6LcqfJLh+g/AUkM5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ggf3i9G4C1ngRkyYXOGDM9sbDTOsm/n60/mg6VtFHHM=;
 b=sETLtTJMCHMjhZATd+RsP/XRbOfrxF+tRUrN08WM2r8W5FKgX78wXrDNndWpK790s9C7L4Yf/PhVg/Fr2LjKSdpd/YpNCjkX4RJ7o52NyvsiqMd0otzMFpfEtfNeNvkwyvqfUxXDsdHJIX6DRt4z/UHXdrf/AsnRT5ZyDMIhhpp6aryZNRv3dudm9IsKFsz3UUkqQN1NNmcjOwdEnIZOrxeh3ppk7i/MUdhUysqbhEUKEO9jZU90UTY5cRwExCdEoYcVdxm+KyUeY9uGXvKnV9PZ/kGyTmFrnn0T916AZZIHdmyfFHxennD+h6noC/kukGjBwkzwjqiaMokAjkVD1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PA6PR08MB10858.eurprd08.prod.outlook.com (2603:10a6:102:3d8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sat, 9 May
 2026 10:40:02 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 10:40:02 +0000
Message-ID: <d0d07e96-c638-4639-b2b5-12becabbb933@iopsys.eu>
Date: Sat, 9 May 2026 13:40:00 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/9] pinctrl: airoha: add pin controller and gpio
 driver for AN7581 SoC
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
 <20260504130306.2764862-5-mikhail.kshevetskiy@iopsys.eu>
 <63eb62e7-f301-470f-9524-c261c85dfbd9@baylibre.com>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <63eb62e7-f301-470f-9524-c261c85dfbd9@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::14) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PA6PR08MB10858:EE_
X-MS-Office365-Filtering-Correlation-Id: 3df215c5-115a-4b7a-c3ad-08deadb75391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Oe4847Z8yAmRjG2kg38gxQ4tyoRYTQUMGyTMeysddZCzi2oel6TZUK0v7UOwi+fDapWfazNAh8/xMGQS0/0VgMGpI4s8WNKvUEZ/2qj3xIVTaE0iCqQ9ciK2ieMGvjqJTwAdwEGEpoWPk5vVBuN8IpSPwJFiBoiIdDnNIx0zjd3YDf76r8FlJc8e+VbCiQVkPYv8RTCzvPGuLYqU51KMO9u7rPhx1YpJh4yqk/NjrSVzHhU+Y637iJ91noWqjOawkW26D6RIJIWgLIWJsIdn1vGfLHTfwl/9cdIXX6V2yh55JL8WLNyfl3K4jWy5yWKUCPdAyFIY+S9i16g0JBt/HxlcfcMQBnwW1iOoDh0CAkj0FmKayEAW9n8c90bq6wXd2PF5VbnOzh8rHrp08i3lnWudg3bd3+TnWlBuf3ef1nlQr/lR9Hh/uY1JImR3cbk7mqASSopHAH8qgNg0e6yPDHY7OnMzyiyUIZauU5EFZF3V+3E6rgX1gLppGCmEEX9Rf1Yf0GgvbyO/Zkg9cHR/lUASwyWx4g+tgWgjQjp27scrf9ZNDCA4YUa66hrB+RoHWgY7DLpp1cMUB0xacu3GrLlLVeVfTmZkIRlZXq7QsoErIwFqAIQQ2odEGtr7YSoLpDEq6bSlIHbnoITCCvONez+f1+1N0+tk+pL7aM40TpCb5fLFlcOKFXKA3HQJDJ5A/IdoBJZvpbgQRSFpgYmq3V3u4h+O31horvTxzANv16M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlhrbFhNd2s2ZVVsK2ZvcW53cmprODBxWnlHcFhneC9QNTlKOEFEQnptb002?=
 =?utf-8?B?M3p0VldKeUM0bzF5VzNjbk44YjdzMTZ4RmNVS1lBb1ZSZXVha000ZHl3QXZY?=
 =?utf-8?B?cHhGWWwxWkZHeEE5cWZ5VnlMb1g2RkZvbGxuMURmNkNaOUxreHVvTE1pd1Ur?=
 =?utf-8?B?ZHdaY0k4K0lGcmFKQTNKM0REd3p3NnNwakc2WExvL2d0OEtZOFZBaW9IRUZ3?=
 =?utf-8?B?VU81aWpyRzQ2dms5eUtjVlVhUXVsZTh5UUFobXlOTzd3SWZxdVgvVEN4c0JY?=
 =?utf-8?B?NDM4SE1Ybys2VURXV0h0eHpBaHJxSEttaEJUVUcxS2xXNW9zazNBWHB3YVZM?=
 =?utf-8?B?SG1ZY0UweTcwQmg4bW5zZ1FuSW5uaHhVM0QxVm1ubXFQNm53L3JlYXpDZHhJ?=
 =?utf-8?B?OXVLSVBHRFF6cXdRVzJKa1QrKzBoYTg5RHhVVlUyYmc0VC9LZzQvOUx2aWRO?=
 =?utf-8?B?RGNDeVRQNGp3bFZuTGtSejJ5L09kWnZ4WUE0c3lBMW9RRENPT3ZYd1pHVXJ2?=
 =?utf-8?B?T3lvdlFsRWoyN1VMbXB2M1NIMlo3REFCL3l6QTNtZk0wd0dDMENCaEwreVlw?=
 =?utf-8?B?dDVuZXQ4OHFSb0pyUFdCVnlwbzh6RFNsNDNtQUhyZFJVaHpKVHc4ZytSN0M2?=
 =?utf-8?B?bXdYVzZvV3FxMURHL3NOS1FEa01XOXUvSFBxZnlKeVhMOGZDbjU1amQ4MS96?=
 =?utf-8?B?d3JBdzNoRVd2VUt2VDg0QWF2NG5wTEJwSFNRRnN1bjQ3RGFLa0U3eEZnSFhG?=
 =?utf-8?B?bFR5Yi84TXRWS1pEaUdZQXhnWFJ1bFpGYS9hcFBhd1ZuSm1mVnkwVktRV2ps?=
 =?utf-8?B?bE9HZkhOU21CMjZ5WGZha0paR29QUzJDTW1oNHMrbFNWUElnZjBIUC9KWkpj?=
 =?utf-8?B?OUhEL1QvSEp2OWpFY1AveDlIWGZFQmlKeGNkamZQTnU2ZFNGelBnQTBzbFhk?=
 =?utf-8?B?V2grR2FycWhtc01CNlZCT1ROV0taV002eEhpV1Z0dkp4TDh2OWwxYzg0S2d4?=
 =?utf-8?B?VjN0b0drZ1ZKWm1pbjJYQ0FCZkZMaTBIRGNQUno4QzlkWS81SXZVRndxcUt5?=
 =?utf-8?B?TFVNQmFOSEFuNkpKQ3VpR3BCK0JNRzBKMkc0TE1NUHpnb21TRFhiL0Z2WXBn?=
 =?utf-8?B?eXA3NkFlMWU2OWxtRzNzVmNHbGFkSGR2ZzNZYkNVUXVJbUFBUXoxRS8reERr?=
 =?utf-8?B?NHNDRG12WGlWb21zcm1lRnRDUitDL01wdnNVRlNvRUtVNCtCakVIKzhDR2pl?=
 =?utf-8?B?ekdhYUNOaTR4RmxnUkYwdDdPRkRuUituM1RCcEQvZFNhemIxcGwwaDJmKzZX?=
 =?utf-8?B?WnVYUHNsdE9tUGJrK0tQakRlMVJId0Z3cmh0UU4vTW1BRzdjR1dsNXV6c0JS?=
 =?utf-8?B?WUkwOS9RSFZCUjZRWnZ4Q1NJRlVzMjhnUTd2SzJmUFM3YitLOUJ2MDJ3K0hR?=
 =?utf-8?B?VW9Ja2dxdmwxdEthNiszeCtnb25vY1dYVFdzUmJ5NG1wN2FvRXJxd2RWSkI5?=
 =?utf-8?B?VEdvSFFvamF3UWVhSFpkdXg5U1QxSFEvSGZlUG56ckN5OXc2NStlQzVaQVQ1?=
 =?utf-8?B?VEhZVVovNXNhWVpFa3F4RzFkVVVlS2xBU1MrZjc2aWZMTVdRYVdVOTZGcHBS?=
 =?utf-8?B?UnFxc1VmUU5LVkxpTWZDVElST252ODNrQVEydGVEdE0wUW1TejI1OFBPRGdn?=
 =?utf-8?B?eGNHNGs0bHM5RHJaclhHeC9aNTBoS2lxd0l5bmxFRnA2MjZ0MlhIZDB0Vkht?=
 =?utf-8?B?aTVOSTdCZTVUMXIxRnREelV6OGprWUFFNkJVNURzL3pVU3cxQ1NIL0cxL0ZQ?=
 =?utf-8?B?MjcwN2F0VUY4d1l3UkpoUG92cnRZZG9hVDJBOTJEbGovWk5xS1ZsVWx4bmtp?=
 =?utf-8?B?eEhVdHVkUHN6aTRmNG1hNlNiRyt1eTcyTDR6REhRZlNDakR6eThwU01IT29N?=
 =?utf-8?B?Qjhkd1AvZmwwcVFJU3QvOUdMQUpsSDNyU0llWkNuTnBYTCsydzR6RzNlYUxB?=
 =?utf-8?B?eUlNRU9Ja2VxV21DbWdPUTR5c2owSXVYcFVCMXB1OE9jZTd5djJJRTQ3anZB?=
 =?utf-8?B?WUdUZjBFSWRHb09YNWQrbFNTWXhQQVp1K1NpZWpHdmRBMWh6Zk54SldoVExN?=
 =?utf-8?B?VXNEWFhHVFpCejBWTE1CdlExa2NGcDhUR1licFlQazVRTFp3a25CbzlMNjQ2?=
 =?utf-8?B?UTN1MkhYM3pSdHdPL3J2dC94b2VZRXFmcXhPZm92WGFIVU94OEdjOUNpKzly?=
 =?utf-8?B?SW9HbEZoaldQb1d6ODhNdXI4VWJHNzRwZlBidVJ2MDVDVUVzZXZzRmZ6SEFU?=
 =?utf-8?B?dEdDb1ZkN05qVUlVb0RBUG90aStCd081S3NId1V4QXBtUHJBL3JrZXNqVVJR?=
 =?utf-8?Q?Vq42blpqPmOOTrAw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df215c5-115a-4b7a-c3ad-08deadb75391
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 10:40:02.7208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cflOil4aEDdSnlqJCjv8xaMZB4m6TR1wwUpelKH5wV+QdeVUgoitD0MEVARO8RGVsUFV0xp2rPotJnB7M0R+RsO8ct3DD9yp9Wn6mTTiSGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10858
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


On 5/7/26 00:44, David Lechner wrote:
> On 5/4/26 8:03 AM, Mikhail Kshevetskiy wrote:
>> This patch adds U-Boot pin controller and gpio driver for Airoha AN7581 SoC.
>>
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> ---
>>  drivers/pinctrl/airoha/Kconfig          |    5 +
>>  drivers/pinctrl/airoha/Makefile         |    2 +
>>  drivers/pinctrl/airoha/pinctrl-an7581.c | 1074 +++++++++++++++++++++++
>>  3 files changed, 1081 insertions(+)
>>  create mode 100644 drivers/pinctrl/airoha/pinctrl-an7581.c
>>
>> diff --git a/drivers/pinctrl/airoha/Kconfig b/drivers/pinctrl/airoha/Kconfig
>> index eb87afbb374..986d23c2e3d 100644
>> --- a/drivers/pinctrl/airoha/Kconfig
>> +++ b/drivers/pinctrl/airoha/Kconfig
>> @@ -9,3 +9,8 @@ config PINCTRL_AIROHA
>>  	select REGMAP
>>  	select SYSCON
>>  	bool
>> +
>> +config PINCTRL_AIROHA_AN7581
>> +	tristate "AN7581 pin controller and gpio driver"
>> +	depends on TARGET_AN7581
>> +	select PINCTRL_AIROHA
>> diff --git a/drivers/pinctrl/airoha/Makefile b/drivers/pinctrl/airoha/Makefile
>> index a25b744dd7a..909bd9a04d9 100644
>> --- a/drivers/pinctrl/airoha/Makefile
>> +++ b/drivers/pinctrl/airoha/Makefile
>> @@ -1,3 +1,5 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  
>>  obj-$(CONFIG_PINCTRL_AIROHA)		+= pinctrl-airoha.o
>> +
>> +obj-$(CONFIG_PINCTRL_AIROHA_AN7581)	+= pinctrl-an7581.o
>> diff --git a/drivers/pinctrl/airoha/pinctrl-an7581.c b/drivers/pinctrl/airoha/pinctrl-an7581.c
>> new file mode 100644
>> index 00000000000..2505818251c
>> --- /dev/null
>> +++ b/drivers/pinctrl/airoha/pinctrl-an7581.c
>> @@ -0,0 +1,1074 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Author: Lorenzo Bianconi <lorenzo@kernel.org>
>> + * Author: Benjamin Larsson <benjamin.larsson@genexis.eu>
>> + * Author: Markus Gothe <markus.gothe@genexis.eu>
>> + */
>> +#include "airoha-common.h"
>> +
> The en7581_ prefix doesn't match the file name or Kconfig. Did you
> mean to use an7581_ everywhere?
Good question. EN7581 is the initial name of the chip. The rename to
AN7581 was caused by renaming of Econet company to Airoha. There are a
lot of places where en7581_ prefix is used. Also this prefix used in the
original linux driver, so I prefer to keep it as is.
>
>> +static const int en7581_pon_pins[] = { 49, 50, 51, 52, 53, 54 };
>> +static const int en7581_pon_tod_1pps_pins[] = { 46 };
>> +static const int en7581_gsw_tod_1pps_pins[] = { 46 };
>> +static const int en7581_sipo_pins[] = { 16, 17 };
>> +static const int en7581_sipo_rclk_pins[] = { 16, 17, 43 };
>> +static const int en7581_mdio_pins[] = { 14, 15 };
>> +static const int en7581_uart2_pins[] = { 48, 55 };
>> +static const int en7581_uart2_cts_rts_pins[] = { 46, 47 };
>> +static const int en7581_hsuart_pins[] = { 28, 29 };
>> +static const int en7581_hsuart_cts_rts_pins[] = { 26, 27 };
>> +static const int en7581_uart4_pins[] = { 38, 39 };
>> +static const int en7581_uart5_pins[] = { 18, 19 };
>> +static const int en7581_i2c0_pins[] = { 2, 3 };
>> +static const int en7581_i2c1_pins[] = { 14, 15 };
>> +static const int en7581_jtag_udi_pins[] = { 16, 17, 18, 19, 20 };
>> +static const int en7581_jtag_dfd_pins[] = { 16, 17, 18, 19, 20 };
>> +static const int en7581_i2s_pins[] = { 26, 27, 28, 29 };
>> +static const int en7581_pcm1_pins[] = { 22, 23, 24, 25 };
>> +static const int en7581_pcm2_pins[] = { 18, 19, 20, 21 };
>> +static const int en7581_spi_quad_pins[] = { 32, 33 };
>> +static const int en7581_spi_pins[] = { 4, 5, 6, 7 };
>> +static const int en7581_spi_cs1_pins[] = { 34 };
>> +static const int en7581_pcm_spi_pins[] = { 18, 19, 20, 21, 22, 23, 24, 25 };
>> +static const int en7581_pcm_spi_int_pins[] = { 14 };
>> +static const int en7581_pcm_spi_rst_pins[] = { 15 };
>> +static const int en7581_pcm_spi_cs1_pins[] = { 43 };
>> +static const int en7581_pcm_spi_cs2_pins[] = { 40 };
>> +static const int en7581_pcm_spi_cs2_p128_pins[] = { 40 };
>> +static const int en7581_pcm_spi_cs2_p156_pins[] = { 40 };
>> +static const int en7581_pcm_spi_cs3_pins[] = { 41 };
>> +static const int en7581_pcm_spi_cs4_pins[] = { 42 };
>> +static const int en7581_emmc_pins[] = {
>> +	4, 5, 6, 30, 31, 32, 33, 34, 35, 36, 37
>> +};
>> +static const int en7581_pnand_pins[] = {
>> +	4, 5, 6, 7, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42
>> +};
>> +static const int en7581_gpio0_pins[] = { 13 };
>> +static const int en7581_gpio1_pins[] = { 14 };
>> +static const int en7581_gpio2_pins[] = { 15 };
>> +static const int en7581_gpio3_pins[] = { 16 };
>> +static const int en7581_gpio4_pins[] = { 17 };
>> +static const int en7581_gpio5_pins[] = { 18 };
>> +static const int en7581_gpio6_pins[] = { 19 };
>> +static const int en7581_gpio7_pins[] = { 20 };
>> +static const int en7581_gpio8_pins[] = { 21 };
>> +static const int en7581_gpio9_pins[] = { 22 };
>> +static const int en7581_gpio10_pins[] = { 23 };
>> +static const int en7581_gpio11_pins[] = { 24 };
>> +static const int en7581_gpio12_pins[] = { 25 };
>> +static const int en7581_gpio13_pins[] = { 26 };
>> +static const int en7581_gpio14_pins[] = { 27 };
>> +static const int en7581_gpio15_pins[] = { 28 };
>> +static const int en7581_gpio16_pins[] = { 29 };
>> +static const int en7581_gpio17_pins[] = { 30 };
>> +static const int en7581_gpio18_pins[] = { 31 };
>> +static const int en7581_gpio19_pins[] = { 32 };
>> +static const int en7581_gpio20_pins[] = { 33 };
>> +static const int en7581_gpio21_pins[] = { 34 };
>> +static const int en7581_gpio22_pins[] = { 35 };
>> +static const int en7581_gpio23_pins[] = { 36 };
>> +static const int en7581_gpio24_pins[] = { 37 };
>> +static const int en7581_gpio25_pins[] = { 38 };
>> +static const int en7581_gpio26_pins[] = { 39 };
>> +static const int en7581_gpio27_pins[] = { 40 };
>> +static const int en7581_gpio28_pins[] = { 41 };
>> +static const int en7581_gpio29_pins[] = { 42 };
>> +static const int en7581_gpio30_pins[] = { 43 };
>> +static const int en7581_gpio31_pins[] = { 44 };
> No gpio32?
The bug of original linux driver, will fix
>
>> +static const int en7581_gpio33_pins[] = { 46 };
>> +static const int en7581_gpio34_pins[] = { 47 };
>> +static const int en7581_gpio35_pins[] = { 48 };
>> +static const int en7581_gpio36_pins[] = { 49 };
>> +static const int en7581_gpio37_pins[] = { 50 };
>> +static const int en7581_gpio38_pins[] = { 51 };
>> +static const int en7581_gpio39_pins[] = { 52 };
>> +static const int en7581_gpio40_pins[] = { 53 };
>> +static const int en7581_gpio41_pins[] = { 54 };
>> +static const int en7581_gpio42_pins[] = { 55 };
>> +static const int en7581_gpio43_pins[] = { 56 };
>> +static const int en7581_gpio44_pins[] = { 57 };
>> +static const int en7581_gpio45_pins[] = { 58 };
>> +static const int en7581_gpio46_pins[] = { 59 };
>> +static const int en7581_pcie_reset0_pins[] = { 61 };
>> +static const int en7581_pcie_reset1_pins[] = { 62 };
>> +static const int en7581_pcie_reset2_pins[] = { 63 };
>> +
