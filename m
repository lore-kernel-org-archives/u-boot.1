Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDFF1C001E0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 08:51:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 244ED8780F;
	Mon, 23 Oct 2023 10:51:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Pt5gx0oE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 980FB87873; Mon, 23 Oct 2023 10:51:16 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on0710.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::710])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43F7587825
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 10:51:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQXAfJ92JqecMKH9tNMI4rKN1tlWcBhua8yhIHfbb/H2u9bIU+f1MdfZhNt4WZIGM9XHyjSuyEHI5cNNliyYGoLmdqK8hsPi4D/z+JrxTujpc97Um43pgRNoDge/Ndd3zZND5ABtMxmK2gAcjlG6Eiv1bG42VLlGfYk6inuthgDCFuV5Ls/hW0tpRIwo5e4/onbMBAC/5WNBBH7tmBExCwQ/phrTSUJUkKX1StqJmtaRrsm+X+YCQezWk6EszQvAccaN8cdRSStFqE5/iR6RzzQ71Z1BgQfy0EBxeeKkcu/UFKsQnI484Woty3iC+/+zKPTfTGGwN0zaj4EhL7C0hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYU6CrJ3VDhgpwL2dTpng16I2qMTtr/DNpGqp0sj2Bw=;
 b=Ygy6xQfyfRa/O0BxC+v51024kHEy8OawwPmUT0glCDjM5epr6Qd+fjvTtA+9uuMYsanwkVcQHr97oUyUmiofZ47G5xrYm3O8jFN0njnCUhsj0id/GH/psUaD3LC+K0p84vW9RGm3l8geMElm+X5H2RHqjRmr1TOgpsoSqZ2JXS3Ink1EA63beOi/nQrvoeeGRC6jrMBivSWUojPplkVJXJeRSRM51eT2OBJHk9oAQe+EMk5AqN8vEBa59guJVwVW+fqufc9xGLYOnyqivevaA6pAmwSOePgk3EyYEco42voBGGhg9VgdMeF27ZBl6xZKZLeDp9tPU7u4K2EZ8Z8GBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYU6CrJ3VDhgpwL2dTpng16I2qMTtr/DNpGqp0sj2Bw=;
 b=Pt5gx0oEKew7mcozJm1fqcQyV4ZYdFa3xOfF778t88h1RbihkdmkHC8AaHwsmkv7uIMBTkeg5LbXLmx8q3mndBtC+jXiM0HC7MaIig0vPpaKKIPX9xgvLBON3/AdJoq7AvhJTEnnbSNCgcmmDmSWJfaNY20oM/HI3X144+5IVjE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by PAWPR10MB7365.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 08:51:12 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6907.030; Mon, 23 Oct 2023
 08:51:11 +0000
Message-ID: <7d38b732-e5f4-4e6a-9a5d-7837e285ba55@prevas.dk>
Date: Mon, 23 Oct 2023 10:51:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] led-uclass: honour ->label field populated by
 driver's own .bind
Content-Language: en-US, da
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Philippe Reynes <philippe.reynes@softathome.com>,
 Doug Zobel <douglas.zobel@climate.com>, Tom Rini <trini@konsulko.com>
References: <20231019095837.2084458-1-rasmus.villemoes@prevas.dk>
 <20231019095837.2084458-3-rasmus.villemoes@prevas.dk>
 <d4389465-e5bd-492b-8f86-7b4a93ff6016@denx.de>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <d4389465-e5bd-492b-8f86-7b4a93ff6016@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0120.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::34) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|PAWPR10MB7365:EE_
X-MS-Office365-Filtering-Correlation-Id: a783e8d1-cf4e-4776-67e4-08dbd3a53521
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EDBkYZ/1sGQrAAtTCOEZq5YSWssuM4CtictuGls5bXUXQ2rmaWQqNcx4bD74gkSTlbnO/vp5rwZi3UF2GPQ58iEIJ6S5RTJnlZ4j6RtUjdpu5okGGzpciU9bOo+n/con9RjRWW628f9sthc2wxKTrdWrlLcrzn+Dr2kFCo1nZjhXjYQ6CZ/mo+jtk+xWXUR+V5H+q39TDAX8u7Bjq+BMSz/64OacarmcsEjRyMP822IiRHm2D01KyaEGEFnFlQNeDrIA02sURlDFYMOe5HmIAhLu0rbI8IfLZsbBKkB3y/6yFijPbsDP6qUW1QNec6EpIcLkDPb0rQCh3L+qG+Tg0/KcIpnPODxsUOJGqHkmwmY+EhCQ+Ca6Zrc+tfY65kfSh94z6rxnCbWpV2/NIh8/oNzqcgJBDOeWsVYiHFkritOtdmp9CubVLIbxzgxOwGjS+hL/2/jR5IdMZJkN1GxFpqS9iugCwjVIVU5jgDz38Jbwy8+qyDwCfNW3x/Kx3PEFEIvOqoLrsRRiFIRC5A9/yiULnq3G+tYMAlzYFNP59LS4VfqRWEECCzmCHdvqHDv8mraWwzWgmJpNd8HuHyeGcVWqW/AHvGiZqfYSF7Nr3D8mRH3JUIqRG0ADei+c4gR1HIVUVXgmrSDuZiRbd+X9AUt+lofJXPTRVSHbaNvz+TU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(136003)(346002)(366004)(39850400004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(38100700002)(31696002)(86362001)(54906003)(66946007)(66476007)(66556008)(6486002)(966005)(6506007)(26005)(6512007)(478600001)(2616005)(83380400001)(53546011)(5660300002)(36756003)(44832011)(41300700001)(316002)(8976002)(8936002)(8676002)(4326008)(2906002)(31686004)(142923001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zmhndy9tSkI3TWY0RG5HUEZWR1Z6S0lFZU9CbnZPaUo1MGRxd2NnK052dmJj?=
 =?utf-8?B?bUo2Y1BaVUhaS3dOazVHcVNoTmZVbWt1dVdaSTdzblNydWJQVGNjSFNFRmE2?=
 =?utf-8?B?MUNFZ3o4THl1dU1Pc01RMkFLWEdEc3dMKzg5MStPRXg4Rnc5VmhqVHdGVTkz?=
 =?utf-8?B?c3o2UVJWUHlEU2VmY1YwV1BKaXNUY3RkSUVXQVdxUGtpNTVsU0VDYnhJaHZF?=
 =?utf-8?B?ZTBPV3doTncyTSt1RFVJTXFNaHBNdlRNMXo4RWZjVjNhNnVMallFOFFtRkox?=
 =?utf-8?B?U1JJVUpwOGZ3aHFkc1ZYL3NGM2R3RHVuNHZmUkZmT0xxOFdQYUVabVdGZm9E?=
 =?utf-8?B?c1NtSmFrVWR2S28yVkV3REp6VWwzckw4ZFQ4MGlTbnZzWnd4VjBrZUFkampz?=
 =?utf-8?B?VkpkZFpqRmtuZm5xM01zL0VrUGlBeE5wL25LcGlvNnFRbHpyTWs0akhRcFdF?=
 =?utf-8?B?b2tTZkVIa0FCb3g2MFgxbks0UXo2QkhsaGdHMGtqcEpib0FNT3p4a3l6Nmhl?=
 =?utf-8?B?WGV1SFc2T2F2Y21heGxkdmVPSUFQMndEa084Z2M0QjZsVWt4MGZUZzRjQXds?=
 =?utf-8?B?VUhxd3N6N0FMazZyWHBiRTIrSURZUWVsWjFGTFJoR1lBTUxnYzVkdk5tbGM2?=
 =?utf-8?B?cWlUUGlQT2daQWxOa09iRkFKU0d5SlJVSjd5dEVObVpoNll0NW41NDVoVnNM?=
 =?utf-8?B?andhRUQ4ZmVFQlY3MHZLamxUalNhNXEvQVFxVVBPRFhJRDZLSnpVdDJZN21O?=
 =?utf-8?B?czZpSUxBdXVBQUR5OTRid2NFTndWYlJBYi9XNWhudFRwRHB0TXRGd0dmakZK?=
 =?utf-8?B?MGRjSjNod0RhcmZlN0FXYlBGWFE4SGc0RUZxSlEvem01Y3d1MFZiWmduQ0Fs?=
 =?utf-8?B?T0o1TWdjNjV6MlhoNzVWUHhlMy9BdklqWWJhSjZ0UUprdWxqUXNGR2M2QUNm?=
 =?utf-8?B?UkgwSFdpYTRXSW9yeFBORmNSMTZxSUtJeVMzOFY1ZmdZNG0rMS9wVC9KUDY0?=
 =?utf-8?B?ZmJwWG5wNDFWbzZSQXlmeXV6Q3h1QlhGd2R0RTdrck4zbmVEOWtONzFlczNL?=
 =?utf-8?B?N2hKVUt3cGVzWFdrc0ZpSTRRUVZjbGJ3eVJ3bFE4bWJUOHkxTUg0RWxjM0xS?=
 =?utf-8?B?TlNMN0VPd0FFdEZHdnc0QmlTYkJzcjlDejl5cmwzcy9JME5KOUNURUpGWlhy?=
 =?utf-8?B?bU83WnJmODN6UUROUkoyYUpQaVk4bVpCeHdUMW9adTNHRndBOXdUZEVTdTB2?=
 =?utf-8?B?Y2NCc3ZqZkFvNVl0VUQ1NWxmbThMU2w1WUN5Qm5lVXpBallkSGU2c2ZDa0My?=
 =?utf-8?B?Mk9reURnRXVsMEVwK1E3NGNsbVNibzkvNzBtVHFjQm16ZHhLcmZhYWVTNGJU?=
 =?utf-8?B?VWxpWDJmbTF1Vm42VWpaWDhaNzl3c0VyUmhGZmZNWUhPeXU3czRLajB0Q0Jn?=
 =?utf-8?B?YWs2dFV6YzJCVHFYTVpVVWNEQnJMRGJQbjFrZDhLYVpLamZJVzB4dnNISVo0?=
 =?utf-8?B?eHQ3aHc1RUNLcXE4cWV5SFJ3MlhlZ0tOTFVVcWdSMnJ2SDhmbGVNODBJQUJT?=
 =?utf-8?B?TlFtMGN3M3ltMUV6WGxwMWgydjNvZWdUOUN1OC9LdDh2NXNhaENuYnNCUGcr?=
 =?utf-8?B?WlNlb1VOZGQ1MnZVYzNteW0wMmh1TnZDMkFwRmJZZUIrZk1rNDB5YkEzRnda?=
 =?utf-8?B?cHY4NXhpTDRFS0Iray9VeS9HR1lockdrMmExN3I3NXdncFhrYmMxOHJVUXpR?=
 =?utf-8?B?RmtjZGZORWFQVi9NRUUzRnc0cEdEOS9JTVZZWGhNWitaQkQvRGRWOFF6Y3NK?=
 =?utf-8?B?NzVPZUNxWTZqay9qUmxwb1RSblJqWWZIMmFZU2tmbXBoZHVRRk0vcVBKSU4z?=
 =?utf-8?B?NWh6NHZabVhWNytNMkI4cVdNc3c3MWQzT3dseG9TVmROMGd1YU5idk1odG4v?=
 =?utf-8?B?cElidldnbDZwRk9tVVZ4blBQMURGZkdtR3A2U2FyV282eU44SDYzOUpkZ2Ur?=
 =?utf-8?B?NUJRTVluSHljRVo2UjZkYnI1U2sxRmxxWnVQcHVIR3JST0FiVVBEbzVFY0ZP?=
 =?utf-8?B?elZDT3hacGhGajJWVWFlU0EvZE1yZkx5d21CWGUyS2xVbVVqSnZtd3hrRHdZ?=
 =?utf-8?B?NkRqeGx2ZmpHV0tjQk13Z0VYc1lSVW5HSHdJRHZTYVdSeWlEcm9xMjIrUzNy?=
 =?utf-8?B?REE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: a783e8d1-cf4e-4776-67e4-08dbd3a53521
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 08:51:11.8691 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3J14x7nzkv7RZl3+iRzbotYABUk3pg0Nf/uB0K6uRHwlraO1aEN2ZYnX06hEVxo5usSmaKeTO+jlz2qhoN82bVgUwYwTE0oiulNsj1Hie14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7365
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

On 19/10/2023 15.54, Marek Vasut wrote:
> On 10/19/23 11:58, Rasmus Villemoes wrote:
>> If the driver's own .bind method has populated uc_plat->label, don't
>> override that. This is necessary for an upcoming driver for ti,lp5562,
>> where the DT binding unfortunately says to use "chan-name" and not
>> "label".
>>
>> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
>> ---
>>   drivers/led/led-uclass.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
>> index 5a5d07b9a7..0232fa84de 100644
>> --- a/drivers/led/led-uclass.c
>> +++ b/drivers/led/led-uclass.c
>> @@ -71,7 +71,9 @@ static int led_post_bind(struct udevice *dev)
>>       struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
>>       const char *default_state;
>>   -    uc_plat->label = dev_read_string(dev, "label");
>> +    if (!uc_plat->label)
>> +        uc_plat->label = dev_read_string(dev, "label");
>> +
> 
> One thing I have to wonder about is, why does this controller have label
> property in the top-level node , what is that used for ?
> 
> (see Linux Documentation/devicetree/bindings/leds/leds-lp55xx.yaml)
> 
> Reviewed-by: Marek Vasut <marex@denx.de>

Reading the linux driver, it seems that the top-level label, if any, is
used as part of the naming for individual channels if they don't have
individual chan-name properties:


        if (pdata->led_config[chan].name) {
                led->cdev.name = pdata->led_config[chan].name;
        } else {
                snprintf(name, sizeof(name), "%s:channel%d",
                        pdata->label ? : chip->cl->name, chan);
                led->cdev.name = name;
        }

but I think the rationale in d1188adb2dabc is a bit weak, since the only
example also does have individual chan-name properties.

[Complete aside: At first I thought it was related to the multi-color
LED work that has been ongoing for many many years (I think there was an
LWN article at some point), where this could be exposed as a single
multi-color LED, as opposed to the "traditional" three/four individual
LEDs. In the former case, there would only be one sysfs entry, but with
attributes exposing the multicolor functionality. I must admit I don't
know the status of that work, when something reaches v31,
http://archive.lwn.net:8080/linux-kernel/20200722071055.GA8984@amd/t/ ,
it's hard to know if it ever lands, or if pieces of it has landed.]

Rasmus

