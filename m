Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A886BC47258
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 09:30:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EE08869F7;
	Mon, 15 Jan 2024 10:30:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1GVLhrOm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7D3D86FB6; Mon, 15 Jan 2024 10:30:18 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33887807AE
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 10:30:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9j1IzUXpdY+W6XHk3ICxCIviewkXzBrFtsV5NfDjvirAV5RgBZlsRnCRvk2aHh8BN3+TOLHOJPcQA+NX3uDTo+oxNPDPE7Q33wkdXVqUarYXO5pkJAU3tlTsHL1Rkg30UBB1KCbpKs6MW1DsTHj57atFur2Rf9RY7q6ZCXtSGHDGQ99z6g9yn92IgDHTCQ7nYtVnsEDeHNm8W07ssJt8Y3X59DSMTR4ufv0OavijpoeSiK5iAkLgrsix3R4jei8775UsQFwdC5D0+KJqCMAG3GSdUt3Bqz1NpIqzCsNZZVk8lQJyDXHdWKFlCU11tOJdweSndPdn6+rReSKhHB4CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=waB3xBc/ynFPXPITbsk7CynWlS5Si4eYYb2mcpJc1Cc=;
 b=f2tW4kjOtZXMNr8iua6dwoQXz7fsOUghFNbjCbS0pQjsZqRULgCgGFVZ8ibaRPImRJTBYhhp0OZLCFeMAamwn1iDAccLMmOaneTZw5xUlNGKvR59cSjrmD9uzm1Yicq8NOj6ayXHWQQ0maK4nbOpoDl9iBb/pZsmu2XcV4WnD81n7AF8W896g053Vcc8M0ytq+9HzmS8W4hYZX/sxX9Z8dJf8wTH01WU9bX2roGTlhM9FWv1zfW/Spm8+ydYY+jAv/B8J6dzqXTh1ixgBEZ6zqlUH41QzN/GZvm/pRJKnCbZPiOxfNyW/1d/+TubDvgkEA4tvlHljDTrKJgRb1ixug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waB3xBc/ynFPXPITbsk7CynWlS5Si4eYYb2mcpJc1Cc=;
 b=1GVLhrOmi80j9y01jXvYARtqxyPOv7254Oo1+rm7kPnWxQvkPCiJKe6jKRdg6dzHlMzbIBAogBXhbBvr18+MmFZoohLAVXMqhJDJ76a/GDsKzGKBTbRn/Xg8pMPBpajAyyCArcLbRo2qJuNY7bTgG0IPwoUAI54zlsEHdmE9Xac=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by DM4PR12MB8500.namprd12.prod.outlook.com (2603:10b6:8:190::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Mon, 15 Jan
 2024 09:30:12 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7181.018; Mon, 15 Jan 2024
 09:30:12 +0000
Message-ID: <679c773b-4978-43b6-9000-76c4ea9c0dc1@amd.com>
Date: Mon, 15 Jan 2024 10:30:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Update the i2c0 node for zcu1285
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
References: <3dfe8b41142de2e8c25c56702450ae1a6b1becc0.1704725223.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <3dfe8b41142de2e8c25c56702450ae1a6b1becc0.1704725223.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0019.eurprd08.prod.outlook.com
 (2603:10a6:803:104::32) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|DM4PR12MB8500:EE_
X-MS-Office365-Filtering-Correlation-Id: 2724c997-e8d3-4339-9a7b-08dc15ac931e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c8nD+/2kzoJ6z+gIMjY6Cpglbq6QUYLO/9dr1WtowKqMwY7WV5I7rh+qdEla2FS9ltXdd00dBhyccJUTERIRjXToTF2aD6MhRRjbydbJWxPUzCfEKin684DJSu8DLCpoVjVYYwIsDuhA0Zn95OxGdsUzpWXuspDIx1AgIbZyAXZcV5krtCmb7+IK3nE5wzL2HTemclmQYipENobxpnNZWxDmsb7P5LKn68pCldM0j/oMFvSayUu2Gqz4PlywCyTVXYvYasUB1d7+f/641LBxqqvyfWYtoqco0a2W+ai/q+iZyImyi91sbO/5M5RmLZisJXRHNtvriqwWRv0ZRBw2bQ81TudIInICDgHlQlKvr+/zFJZPNkRJ21Aud4ecDey5F/qQNYSTpOWO2S4ubP9dXOK7d2U2aEuYFK47Toj+doFEPkXY4u4O6I3rKuBd0se9eb2X9qQjkPgV5EunaHGmti51WwHK4BAm6ohN8CArVIBDOprdYO3Q2cJd5S2wc7AQgjhGSD5edqH9CiIwEFB8cTJsSUOI13epFyxV9Omt3m5bcByODt4BnDq1LhdWVpga7uElOGVUokv5CXVtPie6KgEeIzsCAVGTytc+LTXT7A9fSlEzTYWUC5UmFwI2W8HSzCGDJH4U7k0VqidmnWTwsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(2616005)(26005)(53546011)(31696002)(6506007)(6512007)(83380400001)(8676002)(41300700001)(86362001)(44832011)(4326008)(316002)(5660300002)(2906002)(8936002)(6486002)(66556008)(36756003)(66946007)(66476007)(478600001)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWlzc2V6cmNnNCtva1N2MHh0bVdzUk9iVUVFU25TZzlYRE8zRmFxLzRTZU8x?=
 =?utf-8?B?UXErZjhnK3g4RWViQnJrdDZvcUJ4THd2WXF0UDNHcmNJYUd6T3p5TzUxSXAz?=
 =?utf-8?B?NlBWZnBQWnBpdjNuUUplSTlDVDR5YVpMZHM2OGNiZ2xHeEpMMUgvc1paZ2NN?=
 =?utf-8?B?UG9QQ0UrWlByU0ZwQWtnWTlnSWtKei8yd3g5N3NqK3lwU1pHNERQOUdQRmxy?=
 =?utf-8?B?VVpCMkxWQWtMVmpjN3JWb1B4UTc3TEU1ZS9zNlhVeVFBMkt4YWQvL1dwZ0R3?=
 =?utf-8?B?VCtIMjNPNXJZVEhXV3JsWDN3cHFrYjRaL0xVb0pqWEhwVGhHWFZ4ZFVhZU56?=
 =?utf-8?B?U01ITXp0bmg1emZhbGxoTHFWczhUWWpiNk1kaWhoUU5ZNDV0Lzh4dE9YZHh0?=
 =?utf-8?B?bW8wMGNBSng5NU0zK0toUjZOZER6VEJ0ZVdPak9pcHIvRGZjcjlpVDdqejRV?=
 =?utf-8?B?aityTlkvSGVKYXBqQzAxbVQ4K21wc2RPdjY1SVUweWhDZHhQbTI2a1B2RVEz?=
 =?utf-8?B?bUg4WjRiNzNGejE4bzBjV1o2Zk1GVTBPaUVzS1pYYll2ZUtDRVRDdTNaMjFV?=
 =?utf-8?B?WEZHWUVtcVBoMkdNRlBvcTBHTHdIRlg0UCt4M1RxZHFLSHVJMTRuRTMrVWdr?=
 =?utf-8?B?RzdxTHJnKzB3bU1acG9FeEw3TXpEMnpGREZmWllhREdHZkI5bVkwK1dKd2N4?=
 =?utf-8?B?eEE5UDdXbDhiSXhBZkVJY2RqekRnc1dRZStTY2VVMGZ1aVQzcktEMkdzeXRk?=
 =?utf-8?B?SXNudFFrR1U0VmNzbTdaclAyTE5LWFdsZTBLNFBDSDBRWU9ZZ3QzbDBIbkpU?=
 =?utf-8?B?WTFycmdrbjNKTDZ0dFJLcGIxdDlKS3A1RXBtVzJJb00xM0JXSGFweEtnN3hO?=
 =?utf-8?B?dHVRVW4zZFVEd1B2b3NoTXBpMzJKNnpEV29yZzRuU3JxTWVpN2hmOUx1SUJ2?=
 =?utf-8?B?R0ZxTWVKeG5CM0M0OFdXRERYVndSNU9IOSsvbTdKOVJiQ3Jwa2pLS2YrTU5y?=
 =?utf-8?B?YWNIUURPQlMrVCtJMEQvZjd2dlB4ZGZudkFJcGNrT2dWNW42VHhZN3hmRUkx?=
 =?utf-8?B?TGV2alNwTDVnYklqdkNyN2FoeWsvRUg2VWhiQitqQ2FtNXdDRUYwQU1UeVFB?=
 =?utf-8?B?a2ZSRUtpanFycVVuSnRzbDB4QkwyU2JNWVRoUXVVVFF1cjl6RUtLcXB5RlVX?=
 =?utf-8?B?MVJtZVlvQ2VrMlJsRWs4aGt2RHpqemI4dzZpcFgvQURTNENzRGFYSWZ0Z1U1?=
 =?utf-8?B?TWVlczZ5bnM4TGtUdVFEOTBIMDZSbERRckRxRi9tVmUvQ2dlb0l2K3B6bzVK?=
 =?utf-8?B?bkdlR3pmYlB1OEQ2eUliTGt5blVUeTdPNGM4bWRzMTM2MitVUGM0OUJaM1lB?=
 =?utf-8?B?a2xJbkNWZzhGcUc5eDhyQUVtNnZWR1RNbmdzcDhSY293ZzFYaFgzWVBINDhz?=
 =?utf-8?B?MmFiSDIzYXg2cEdEbUIvSnFGaXlQazJJU2MyNWFrNGRMb1ZmRlNzTkViTUEy?=
 =?utf-8?B?VVdrVGdDaVVmY0Q0S2hlOGJ6YlppK1RmZFRWZTNhak5uZzRHOWgvNEw2Skpo?=
 =?utf-8?B?dkNRcXAvcCtmcjEwZzk2Rml4WUxvcnBpQ1F5TUdZelRhaW9LbUdjd2hMekNB?=
 =?utf-8?B?OGdpdWRrdHF6WVZ4T1ZNU0trdlF3RTRkczhFbytZOURUd25uazRjdWJ6RTll?=
 =?utf-8?B?d1YyUTI0N1B6RjdsU0RNTjZQS1pjZlFzTjhGMHpZbTc1RjVSbFdMQ0EyZ281?=
 =?utf-8?B?eGVSNno5NytOajg4ckh0ZHpEZ1hBaU1Xa21EeTl1dzRBZ0I5QkJ0RGZQSGZh?=
 =?utf-8?B?bTErb0RRVFArK1JLNXFXUG00WmdXYzJXY0ZDUWZRQjdTNHVCcTk2MHFpT29n?=
 =?utf-8?B?Rk44WkJHRGtmektLUWtnY0tjMzZpR0FiVDJ0dkZzQ1o0d2JaTjhxbURzQVJH?=
 =?utf-8?B?K3RWeHRiT2dSSlExdXRZRFo1REppTXVCN0o4NG42aWtNNlZ4WmxRSUtySWZY?=
 =?utf-8?B?MHp3RmtpTTBUQXNCNndncThLYVpnUGNoRXYrdzQ4MVVFT09ydkJWMHUvQWtp?=
 =?utf-8?B?N3BTaHVTN2liV1Y5WUJxTWgxOThOM3dmTnN5MDdvYldpb1pveEh6dTNWVVNJ?=
 =?utf-8?Q?QLwjIHqD3gDTo85Xnu6SOauQc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2724c997-e8d3-4339-9a7b-08dc15ac931e
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 09:30:12.8892 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qSD5ndEoYBjAtdZonCnVm7D02g/yYpgz+IAyD65oyf4FJAHqcJFGRUAIOvvAs4/J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8500
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



On 1/8/24 15:47, Michal Simek wrote:
> From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> 
> The pca mux is not added to the i2c0 bus so remove it from the bus.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp-zcu1285-revA.dts | 174 ---------------------------
>   1 file changed, 174 deletions(-)
> 
> diff --git a/arch/arm/dts/zynqmp-zcu1285-revA.dts b/arch/arm/dts/zynqmp-zcu1285-revA.dts
> index 4f85837e64f6..38735b1ce1ac 100644
> --- a/arch/arm/dts/zynqmp-zcu1285-revA.dts
> +++ b/arch/arm/dts/zynqmp-zcu1285-revA.dts
> @@ -37,26 +37,6 @@
>   		reg = <0x0 0x0 0x0 0x80000000>;
>   	};
>   
> -	ina226-u60 {
> -		compatible = "iio-hwmon";
> -		io-channels = <&u60 0>, <&u60 1>, <&u60 2>, <&u60 3>;
> -	};
> -	ina226-u61 {
> -		compatible = "iio-hwmon";
> -		io-channels = <&u61 0>, <&u61 1>, <&u61 2>, <&u61 3>;
> -	};
> -	ina226-u63 {
> -		compatible = "iio-hwmon";
> -		io-channels = <&u63 0>, <&u63 1>, <&u63 2>, <&u63 3>;
> -	};
> -	ina226-u65 {
> -		compatible = "iio-hwmon";
> -		io-channels = <&u65 0>, <&u65 1>, <&u65 2>, <&u65 3>;
> -	};
> -	ina226-u64 {
> -		compatible = "iio-hwmon";
> -		io-channels = <&u64 0>, <&u64 1>, <&u64 2>, <&u64 3>;
> -	};
>   };
>   
>   &dcc {
> @@ -67,160 +47,6 @@
>   	status = "okay";
>   	clock-frequency = <400000>;
>   
> -	i2c-mux@75 {
> -		compatible = "nxp,pca9548"; /* u22 */
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		reg = <0x75>;
> -
> -		i2c@0 {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			reg = <0>;
> -			/* PMBUS */
> -			max20751@74 { /* u23 */
> -				compatible = "maxim,max20751";
> -				reg = <0x74>;
> -			};
> -			max20751@70 { /* u89 */
> -				compatible = "maxim,max20751";
> -				reg = <0x70>;
> -			};
> -			max15301@a { /* u28 */
> -				compatible = "maxim,max15301";
> -				reg = <0xa>;
> -			};
> -			max15303@b { /* u48 */
> -				compatible = "maxim,max15303";
> -				reg = <0xb>;
> -			};
> -			max15303@d { /* u27 */
> -				compatible = "maxim,max15303";
> -				reg = <0xd>;
> -			};
> -			max15303@e { /* u11 */
> -				compatible = "maxim,max15303";
> -				reg = <0xe>;
> -			};
> -			max15303@f { /* u96 */
> -				compatible = "maxim,max15303";
> -				reg = <0xf>;
> -			};
> -			max15303@11 { /* u47 */
> -				compatible = "maxim,max15303";
> -				reg = <0x11>;
> -			};
> -			max15303@12 { /* u24 */
> -				compatible = "maxim,max15303";
> -				reg = <0x12>;
> -			};
> -			max15301@13 { /* u29 */
> -				compatible = "maxim,max15301";
> -				reg = <0x13>;
> -			};
> -			max15303@14 { /* u51 */
> -				compatible = "maxim,max15303";
> -				reg = <0x14>;
> -			};
> -			max15303@15 { /* u30 */
> -				compatible = "maxim,max15303";
> -				reg = <0x15>;
> -			};
> -			max15303@16 { /* u102 */
> -				compatible = "maxim,max15303";
> -				reg = <0x16>;
> -			};
> -			max15301@17 { /* u50 */
> -				compatible = "maxim,max15301";
> -				reg = <0x17>;
> -			};
> -			max15301@18 { /* u31 */
> -				compatible = "maxim,max15301";
> -				reg = <0x18>;
> -			};
> -		};
> -		i2c@1 {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			reg = <1>;
> -			/* CM_I2C */
> -		};
> -		i2c@2 {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			reg = <2>;
> -			/* SYS_EEPROM */
> -			eeprom: eeprom@54 { /* u101 */
> -				compatible = "atmel,24c32"; /* 24LC32A */
> -				reg = <0x54>;
> -			};
> -		};
> -		i2c@3 {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			reg = <3>;
> -			/* FMC1 */
> -		};
> -		i2c@4 {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			reg = <4>;
> -			/* FMC2 */
> -		};
> -		i2c@5 {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			reg = <5>;
> -			/* ANALOG_PMBUS */
> -			u60: ina226@40 { /* u60 */
> -				compatible = "ti,ina226";
> -				#io-channel-cells = <1>;
> -				label = "ina226-u60";
> -				reg = <0x40>;
> -				shunt-resistor = <1000>;
> -			};
> -			u61: ina226@41 { /* u61 */
> -				compatible = "ti,ina226";
> -				#io-channel-cells = <1>;
> -				label = "ina226-u61";
> -				reg = <0x41>;
> -				shunt-resistor = <1000>;
> -			};
> -			u63: ina226@42 { /* u63 */
> -				compatible = "ti,ina226";
> -				#io-channel-cells = <1>;
> -				label = "ina226-u63";
> -				reg = <0x42>;
> -				shunt-resistor = <1000>;
> -			};
> -			u65: ina226@43 { /* u65 */
> -				compatible = "ti,ina226";
> -				#io-channel-cells = <1>;
> -				label = "ina226-u65";
> -				reg = <0x43>;
> -				shunt-resistor = <1000>;
> -			};
> -			u64: ina226@44 { /* u64 */
> -				compatible = "ti,ina226";
> -				#io-channel-cells = <1>;
> -				label = "ina226-u64";
> -				reg = <0x44>;
> -				shunt-resistor = <1000>;
> -			};
> -		};
> -		i2c@6 {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			reg = <6>;
> -			/* ANALOG_CM_I2C */
> -		};
> -		i2c@7 {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -			reg = <7>;
> -			/* FMC3 */
> -		};
> -	};
>   };
>   
>   &gem1 {

Applied.
M
