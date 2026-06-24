Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434E3CDB479
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 15:22:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 532FE8460E;
	Wed, 24 Jun 2026 17:22:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ZV92x7+5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDB5E847C3; Wed, 24 Jun 2026 17:22:44 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 301AD80398
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 17:22:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMqNlL6sc+D60wmvGiOAiIwhWXlytFWTt5hvmWC5FKxkSVX7fTWN31O+wofH+7wEoOAcuWI5yp8rJoWewggAyrgbnY9Ne1khibuK2aTIMvC+VR51CwYJjnu5JyTyAyqI22AL5mow95lcGBKMHwh5E+RNFOKXupTo3d2MwSHtuztQ7jn6+MlwxASxOHk78PidxLgJZV70S0euNPZAHhQtG/0DHQRnjFijkVUkTkLdo03lrX4Er94vDzYnMicbMsr0FDNfX8f3H5+in7ianCVcFahdZaURnPN2R4H6soMfSeK4GUmkIh6+HzGAlflmf7EkJcLvlm0+9MVsHAoWjm3lfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fhKKXhnie696FuCyuA3h1alyO0tyScDDCVfpPsT84M=;
 b=CdNxnm3Vd2f+uCvPvrR+ag4XieZcFpznB62KfdXlwNb6dYjU7dYCFmtaCTFU19L4DIWWKqbwOEbF95WfcbxmB1SboTYtlCPEOnZ4St1+dRuhEQPiNx1MQSPGX3Y8pDT1Oqhqr4+c80SsDobI89wKXJqZeZIHiXtk+JE2S8Yk8IzqOq88bZ4zBn7fvSiXq9pXreeVgeg49XOLyOakzpuXIhWiw/AYZh64Bx+YbnJz9eODSznXWnwFHCFCuEfF5Bu9+PDh5NIUNx5kXWMUwTRm1lRargzu8ctnUBdgmmMfiy3FNaNYv1tXZeymVKvwTfZ2M+rC6SQJS6RbWc8BIqy0nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fhKKXhnie696FuCyuA3h1alyO0tyScDDCVfpPsT84M=;
 b=ZV92x7+50vqD+bDnx7cRtpfqOYFm3C8evsJ7yaqaUwmbU8EN9sV8vB0lCPxn8UujexrjhP4JhncgdKOddcOTEGsL/ApfJn5y7lf0AetTuXYgih3Z9M1ukCWfUIcpbBq3Jtk00xFunOZwcPpAECvcskNi5WUig8RZ9fidep4rzlU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AS4PR04MB9622.eurprd04.prod.outlook.com (2603:10a6:20b:4cc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 24 Jun
 2026 15:22:39 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0139.018; Wed, 24 Jun 2026
 15:22:38 +0000
Message-ID: <171792c2-fd8a-453f-8eff-a5b3f44adbf9@cherry.de>
Date: Wed, 24 Jun 2026 17:22:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: onboard-hub: Add support for Corechips SL6341 USB
 2.0/3.0 hub controller
To: Marek Vasut <marek.vasut@mailbox.org>,
 Alexey Charkov <alchark@flipper.net>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Michal Simek <michal.simek@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>
References: <20260512-sl6341-v2-1-fd5fc55e1f38@flipper.net>
 <14653d07-924c-46bc-9d3a-f1681e85053b@cherry.de>
 <317edc52-aaad-4778-bae3-7ce177f49e84@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <317edc52-aaad-4778-bae3-7ce177f49e84@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIVP296CA0045.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:353::8) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AS4PR04MB9622:EE_
X-MS-Office365-Filtering-Correlation-Id: 1787bd32-769d-4569-c7ca-08ded2046d3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|5023799004|4133799003|4143699003|56012099006|11063799006|6133799003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: YN5sJGwaU7MzShy+fX+VtLctgtDM20YGG2KwP8qIk13f9JJhZOeT3UaJMNWRF7ShOad/kDD13C0Kwvk9XjHZ/awg/fN69zz41L1DEs8nQSXlfpqxgBwpP8kqennAm6ZycLXE6/c+6pWMoD4fcSOBbJniIisd2ls7i6YXZEzhSHXSCUYLkv3MS6R/lXPc7FaROSv0F7G+G25WDtP2VNd1OIGR/qkX8Ujeg48WQazjnBM/HnxCBIN0Hj+jpYTPM4X5StY/8/+OEH3tIXhKBfbfJkVDV5Kw3wIbK2TSx7cbTsUXx1kW+cVxPWEvbysHYRR32GbjspvR/CNdsJ6uFPtiYpfAhWnUssLijyCT68UsRU1+l4066D6pe0kucROctLpBSXaglvIonk8RL/uIrr/5ADgZrL58HGau688ZJyLXh05n/xruOCAt5jlwYabKAsD1TwrrTp1sY9uYmUhSi9TY5Zy/7qo/tEw8CWxl4pR4o+C500LAJW0dTG2AE35eduF+nJQlwxLcNG+fohTLDD5I6sl6AVw7QzMuph+YUGCeizvtKGfoPT4z/OkunTDJmPie8RkOEFw58e9HPGUC0+1KNpq5lTm8niC9G1aZlhXsUvGskQ0zM8KW1amVLZ5R8fS0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(5023799004)(4133799003)(4143699003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajloOHJ0WEY3MTc0M3J5ZDdEamNxSEdBaU5YMm5XTmVXMHJVVDFheXUyWXNw?=
 =?utf-8?B?TWVacVlaVFd6U3h3MkVkaC9WMkNZd1pLSlhZd3dwUm9kZU96enNpUHh3bldU?=
 =?utf-8?B?Q3FxMmNaVHBsTXlYZzR3QmFxeTJ4MEdFQ1VEMy9TNko2N3Z5M0dUM1k5bnJs?=
 =?utf-8?B?YzBYTXEvcjZPUk1UWnVaRkhacEhRdUY5V2czcXkzZ1VWallzaGNla2pFUTNZ?=
 =?utf-8?B?Q1dsbzFrc0FscGM0R0QvRHB5TWd0aHhPWjNRQ25hYy9kY0tIaFdtekM0RE5H?=
 =?utf-8?B?OGVWOWp3eFhTOUFNL2d3NVNCY3BoQUFyc0RwQ0g3WEJ0RVhMMmNwdTRWQzg1?=
 =?utf-8?B?Y2d0UG03MVFPRDR4d2wwdlpWMytkYUpCM0djZHlHN2J3a3ZzaGhMTDU1SDNw?=
 =?utf-8?B?ajNUQy9ZM3VRREl4US93ei9yS2JybVlnWDZnQ3JRTUN0NDRGT21MYytYb0lI?=
 =?utf-8?B?YW1UTVQ5cmx0NFp5c0hFdGFKYVZLcklPT2NlRGw5UkxPUXROZ0ZJZjJLZlAy?=
 =?utf-8?B?V3RoR3VWUXJhQ2E5M1JNZnNxbDVwa3BYMERRZWhFUnUvdGliVFdjM0cvSEI4?=
 =?utf-8?B?bnc0ZEJmS2dmN2VvaG9aQXJhVmpYN1IvQkZPeHdMT0srZjdmczFDYkY3YmhD?=
 =?utf-8?B?UHJDTERDL1VWeWRQUldoMHdtZ2ZEaGVxVFNBcEREMG5rWG5Xa3BpMVFWS1NF?=
 =?utf-8?B?ODhob0F3VG9qblFsTkg5aVNUKzZ2MHNTV0ZaakxqdXBFVXAzL1ZrQTRJVjNO?=
 =?utf-8?B?NHhKNWswTEtKYzBHWXF3Q1Q3aGRINWtIYU45UFk1UDJFWmhtUkFlbW5pRFlN?=
 =?utf-8?B?cVNtOWlEMk9CWXZ6dXQ3aWxpRlRVY3oyZFdBMG9NODJZTmRkVlJZRUFhZks2?=
 =?utf-8?B?Z2hWUTcrYVFyeC9qVEJsR0lERHN5STR4bXpYZmpKalpGMmlacmlVaVRBNXg2?=
 =?utf-8?B?YVhXZ2RjQmNBd2psQ0ZXeU83ajgyY2FLVWhISDdFMndqVDdFUjlrMm5DMUo5?=
 =?utf-8?B?Mm9wUU85WEs3SGdYbXBNeUZVa3o4Y0hVbWpQc1BmQWVISEVLM2pJSWsrZmxX?=
 =?utf-8?B?OTZTTlR5N2JLR1lJN2Z0c05LWnJzeGFSM0xabngvdlFhbmZqMWR2N2xKallz?=
 =?utf-8?B?YXdUTmEzVDdVaU1XSlB2L3ZOamFkT1YxRFlWN0J2aHpZYVZBQXpMZWJ0QThw?=
 =?utf-8?B?QXhTVHZRbkk1SjhVWmZObmZGdGh3eUhoQnNGVXNVZGwzQjM0TUl2L3ZWOTdr?=
 =?utf-8?B?Z2I2SDNYZk0rNzZKQ3pHWUVTbm5ac0NwRE9ydU1aU3VOYXM4MTB3YWkwS203?=
 =?utf-8?B?anBCVjI4b28yS1lzL0s3ZGtLczBTODBJM3luVnFYN3dEcWVJQXVOQmlTZTZi?=
 =?utf-8?B?RW5qZTFXcFBmUk5HcE5oRmxvU3phOWVSWkFRSTRIVHZyWFF1bjg4c1E1MGx1?=
 =?utf-8?B?SVlsYm5qeUpoTFFram5NaUxxcVo0MVBrYUZiRXpGSURJMzdlSEdudGZLSWE5?=
 =?utf-8?B?RDdkbDVlQ3A4WE5lQWo4ZXVwWUZ2SllmYWxvMUJsQ0dMWkl0SHFoSStYY0Rx?=
 =?utf-8?B?SDU0K2dQRGhqTjM1M3JiTXlsVEl5VGlJZENDRDk1cTRnYnNvOW1yYWxpVW94?=
 =?utf-8?B?ZXhUeTU3ZDRTdWQxL29kKzRQWEJqQXk1QURzUXRVcU1DLzZXamlzTkpPNDR2?=
 =?utf-8?B?ZjZ3SnF4MC90a0NTSW5iVnRwSkhOK0NsYmRoWlhDQ1hjRnNyRUFLL1drNzBV?=
 =?utf-8?B?cDE1TVQvSFRSa1NhR05NSXpidFRWQnAxclZNR2U0MlZGMHl0Ujl0Ym5CRXdy?=
 =?utf-8?B?OElyb3ZhL3UxeW9GSVZKUmV1YldBWkVtMWRMcTdCbUQ0L2N5Tk5xYno3M0xa?=
 =?utf-8?B?b1hlVjhtSzR4NExvMHRDQUVGNjg1MGNZNXppY2xVR3UzS1VoeTJSVzZVVnRx?=
 =?utf-8?B?SGs4d040aFhsY0pXbFBxWGJPME05NDR0U2cxckFYMnY0UjVzOVV0cE00c0R1?=
 =?utf-8?B?blFWME94QW1jRkJMcjE1c085UUNRNnhrSUsxQnRsMmQ0enJBOHIzZFVmVEtH?=
 =?utf-8?B?WndaL25hSkkxMHQ3alJqamtIaFkwTHhIbjBkV1pwZGtOWlZCMEpUZ3llYkR4?=
 =?utf-8?B?VnU0R3dudFRSYjhPSmtwQ21TL0h5YmoyTVYrY2hrTXUxVUV0WnJ2OXRoWmJM?=
 =?utf-8?B?OXNNejV3bUlUSkJ5bk5WSVIveFBkNkZpR2ZEelgwUElNNnJKcXRmSHBIUWxk?=
 =?utf-8?B?NXZLVG5xR3lISm01eVgwSzRCVWlPaHlSMll5RVo5azU1R1dPazRJRVNnUisz?=
 =?utf-8?B?bjVSWTlKaTBMNEFYNlNOR3IrU2o0S3ZlRnEzdHdCM1hrL2h0UGRxUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1787bd32-769d-4569-c7ca-08ded2046d3d
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 15:22:38.8819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WmxpJeYMwdwY77JaGQh5XO2Gc3eCBKg5gTwDB3N7FWOpyFh/Jam2Y6bhNoq4GzTS4g3V+07M+7jiw3StejQANWicO2LueGgYDFfbylmxHIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9622
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

Hi Marek,

On 6/24/26 4:28 PM, Marek Vasut wrote:
> On 6/24/26 4:15 PM, Quentin Schulz wrote:
>> Hi Alexey, Tom,
>>
>> On 5/12/26 3:55 PM, Alexey Charkov wrote:
>>> Corechips SL6341 is a 4-port USB 2.0 and 3.0 hub controller. It always
>>> requires external 1V1 power and can optionally use external 3V3 power
>>> (or alternatively it has a 5V->3V3 LDO built in to derive 3V3 power from
>>> VBUS). It also exposes a reset pin.
>>>
>>> Device tree bindings are merged for upstream release with Linux 7.1 as
>>> commit bfcb86e58f3a ("dt-bindings: usb: Add Corechips SL6341 USB2.0/3.0
>>> hub controller") [1]
>>>
>>> Link: https://eur02.safelinks.protection.outlook.com/? 
>>> url=https%3A%2F%2Fgithub.com%2Ftorvalds%2Flinux%2Fcommit%2F&data=05%7C02%7Cquentin.schulz%40cherry.de%7Ca44d3da6a7cf48b547ca08ded1fcee13%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C639179081433018185%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=FecJhM5NGeAK%2Bo6iln1t3m52BN1DPNVV6tuQA4K4KWc%3D&reserved=0 bfcb86e58f3a58d05b95970d81b94cb011982780 [1]
>>> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>>> ---
>>> Changes in v2:
>>> - Fixed the comment to correctly indicate the USB 3.0 entry
>>> - Added an upstream commit reference for the DT binding
>>> - V for volts in captials (commit message, thanks Marek)
>>> - Reordered the compatibles by lexical order, not hex order (thanks 
>>> Marek)
>>> - Link to v1: https://eur02.safelinks.protection.outlook.com/? 
>>> url=https%3A%2F%2Flore.kernel.org%2Fr%2F20260512-sl6341- 
>>> &data=05%7C02%7Cquentin.schulz%40cherry.de%7Ca44d3da6a7cf48b547ca08ded1fcee13%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C639179081433057206%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=Te0MkaUEYkT9gxZvlDl8HlVJKQMpKAS2PHjMjtNK5Q8%3D&reserved=0 v1-1-2819ac19e050@flipper.net
>>> ---
>>>   common/usb_onboard_hub.c | 14 +++++++++++++-
>>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
>>> index 6fc34489a98f..0684f7bfd479 100644
>>> --- a/common/usb_onboard_hub.c
>>> +++ b/common/usb_onboard_hub.c
>>> @@ -262,6 +262,12 @@ static int usb_onboard_hub_remove(struct udevice 
>>> *dev)
>>>       return ret;
>>>   }
>>> +static const struct onboard_hub_data corechips_sl6341_data = {
>>> +    .reset_us = 10000,
>>> +    .num_supplies = 2,
>>> +    .supply_names = { "vdd1v1-supply", "vdd3v3-supply" },
>>> +};
>>> +
>>>   static const struct onboard_hub_data usb2514_data = {
>>>       .power_on_delay_us = 500,
>>>       .reset_us = 1,
>>> @@ -285,7 +291,13 @@ static const struct onboard_hub_data usbhx3_data 
>>> = {
>>>   static const struct udevice_id usb_onboard_hub_ids[] = {
>>>       /* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
>>> -    {    .compatible = "usb424,2514",    /* USB2514B USB 2.0 */
>>> +    {    .compatible = "usb3431,6241",    /* Corechips SL6341 USB 
>>> 2.0 */
>>
>> Would be nice to have an additional newline after the opening curly 
>> bracket to avoid this unnecessary chunk in the diff next time we add 
>> support for yet another USB hub. It's also a bit surprising to add it 
>> first in the list instead of last, but eh, nothing too important.
>>
>> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> @Tom, can you take this for next please?
> Why would Tom collect USB patches ?

$ ./scripts/get_maintainer.pl -f common/usb_onboard_hub.c
Tom Rini <trini@konsulko.com> (maintainer:THE REST)

and this patch has been sitting reviewed for 6 weeks and the status in 
patchwork is still "new" so I thought it somehow got lost. I did miss 
that you were the delegate (or did this change recently?). My intention 
was not to bypass you, my apologies if it was taken this way.

Would you mind if I send a patch to MAINTAINERS to add 
common/usb_onboard_hub.c to the USB entry so that it's clear you're the 
maintainer?

Cheers,
Quentin
