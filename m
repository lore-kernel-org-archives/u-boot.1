Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE21FC5475B
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 07:32:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 159E687D98;
	Fri,  1 Mar 2024 08:32:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qCEUXsHm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2F8887DB1; Fri,  1 Mar 2024 08:32:45 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB8DD87D82
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 08:32:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RR/yiQIWUOTIzaMgboxElQH5PH8hLNFVhr1YADy86DwZ+D4qhrBBVsw4YsdVQdlE/78h3G2o9TJs19qfPJCRdJ+mbpEOzyr1EjdDQqRXWAUmM3fNDTwW0iIMX0OrepgkLwCVw83TcjnF6wOLwv5bCjGHbpvXatgWF/bWcfmvn2TlSYOAY8SImdo8WqoQL3co/YhmToUUWLgbpqCj6cmSnYN6god9cropUaRXInpGozf4T9No9eGZsVc0idU7bgOIjINLVApA3Vq71VgqvpTpxIDX/C9tqHciieLI0AZ4HF/UNdGeH5c3hr1FxH+dQ2hhGKH/3QiSTyMvhKWcLTc9Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9JgiP2VSn6E8FhPvtNO9IbBOadauo9xw1FhkDxX7ys=;
 b=XBU2zB8gImCwVo1XGau1q12+qAc9OaeXz0RqXT7+ss1aZK8YYJKUKyffwgNX8OcfjzA+rKzW1AzXbdrULSsj0jQQZ8k7XBZDD3+lOy/NCoqVKYxgbAQyjZ+XbuKrHiZ80n8sG4LwXcRLFEQuJkjuXVH+h03qTNOxnAp8l0zGjv52zui3nJBuC8RuxtvGIYx87F0mR4Ux6Kk20/IuAfw0q0H67ZznRG7Bz8NHecGnSJjcmLNi2Cy1G0YFZmKPzZR+ssl8swdU7PhfvmRW5tLLZzeGdZSt7uWtoQ4heKjCZvE+N04yHVSkXEdZZGDgWdid0IJSQR2sIzHDTgOO+eff/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9JgiP2VSn6E8FhPvtNO9IbBOadauo9xw1FhkDxX7ys=;
 b=qCEUXsHmDEiiUTHDpMDjgQZuMl/OPuD2irkaC4DOq2wzMefif3U1jjH4CR8BmiN4Q5iJvUKXDyoFnb9gIXQDUiDu0MxawmpP7P1zeHXZOBqBMnHWN9bfDF6C6jxq/4mlyxWZWeNMxZi3VL5HlnsYMKAEXzQRJe/1CqT6Rq9pJHw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB7234.namprd12.prod.outlook.com (2603:10b6:510:205::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Fri, 1 Mar
 2024 07:32:38 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7316.046; Fri, 1 Mar 2024
 07:32:38 +0000
Message-ID: <5be065b3-3188-4e7d-b335-da914491a503@amd.com>
Date: Fri, 1 Mar 2024 08:32:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Remove snps,enable_guctl1_ipd_quirk
 property
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Piyush Mehta <piyush.mehta@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Tanmay Shah <tanmay.shah@amd.com>, Tom Rini <trini@konsulko.com>
References: <2067eefbad161dee64b1dc7d97c498f09a8307a2.1708962844.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <2067eefbad161dee64b1dc7d97c498f09a8307a2.1708962844.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0012.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::25) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB7234:EE_
X-MS-Office365-Filtering-Correlation-Id: aed8fc3a-9e32-4c69-671d-08dc39c1c555
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2xXY9P2O2u+yKhy24uGJVh90AdhatAPc22ZUdkMeSjYoccV6Px0nMqoVu5gnpyFcQJcD2g7uZoG0lcERMIwKOA4QZRnJyh27WMQTkYQmvyq8wj+l24YRy6F4cVdQ6ApHtoFiJVnWlaXmlKBatiZnhBe/Eq5tDsX+rHmctofYuAUWBx3mrEb0R/AMrtuSTTMaPA/FOIowEnZnZwWW+hP6552KPsg1w14bD2xsoCEeQ7Am9LKH0nh7o2FhIYD4zyXTKDSSsbcLGCOO8IDJYQZ8aj/r0fbj3v+//P1t5KZmLNbmaiwdHtxqmYX9ewD5XUCYV5w7xBBumVqWV5eIArIhe4Q5uSmNx6RF0bP/ilXV6yfcgA0abWLZbID8qC+0vho3KEABi6V08YcEOzMqSUaXFcmWrTu/x0zmq+Wx0+RAtFXLgrwSpp4fE5JcSrIlKDozdxI3Gm1cK2oCwXoaCmV23vWGBkc+sPQg9DwdV9QmImcMBQiAyHhY1GsDqdZsfhnZeIfY/bxF5gPklC1ukMbSfex784tdG+cs38FbY8hzZ1AHpD8U7qwG2fYyDXu2JiSnUaXyT9JtoB/McE2z2ZO/TSg6re70dBc9PadHevzpwyU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlF2bllHckdvL2wvaXNTRFlQMTNlNjMvdmQwUEFSVmVCN1BQVVo0SnNrcVRp?=
 =?utf-8?B?YzVZdUthT29QOGowVnpCSUhsVWxNMHJteXNVNXEyZnk1cXBac2l1dzI3bFp4?=
 =?utf-8?B?Tm1uM2VzUmJjaUlHOHA2U0RkZ0VVRitFUTlueW9wamg3Z0ZBMUl3Yk4zOWs3?=
 =?utf-8?B?TlFXakJuWG01aGJiNzRDYTVTM214NHo0a3NUbGU5UFduaWYvWUc5QkpPNVA5?=
 =?utf-8?B?cW1pUC96WHV1Z2dFckdBbGgvU3N6eU9TQ3hRU2I2WWNYdXFNQkVWY2JJKy9t?=
 =?utf-8?B?ZGI5dldTb242Y1Uyc0hNZzVBbm4raTRQRkp4ckEzOEc0U2pvcGxydllibVhW?=
 =?utf-8?B?Z09jeC90aGowM2dZZnBiSjc2LzFWRVdJUE5BTjYrT1FVWCt4RTlTTXpzKzdQ?=
 =?utf-8?B?N0ZGSnZ0M1BBdEYrK2lsQWFocXNGMXRlRnM1SHFTZURzcnhvQzVnOWVIcGND?=
 =?utf-8?B?dG5rV2RHQmZic000aldDOFhWa1ZuNVZKZmdQWFpZeGJ6YmtRa0VCL1BscVpM?=
 =?utf-8?B?eElvb0xJWUx3TjBMRnphaGNvaUtIdExRaHhuZUtJNnE2bXZ6a2xHTG5mRmNa?=
 =?utf-8?B?MGxtaEprWXVWWnI1a0tvYnBHS1hPZG02UUJvMERwbEl0cmRXeEt3cTByVGF2?=
 =?utf-8?B?bjVxVW10MXltUkluRFhyREI4R1Q0bVNxMDhkdHhhUkVJeG45K1BoT3dhQzlS?=
 =?utf-8?B?am1YNFZ4dGNkNFpFWloyNXVOcWZQNXo2a2xnRE5qUkhkbWNhcnhrWWZkRlFL?=
 =?utf-8?B?ODRBcnNVdzErQnpJdHZnaGdpQ0VBdTBvazEzQU5rSFRqRTd2QkZGNWhMcDRh?=
 =?utf-8?B?UERUYXFLVjhxYUpWUjFJUW9rdndQek93RTRCM09BbzZqNjFCMXF0SU9sK1JJ?=
 =?utf-8?B?Y05YdDErVmRZL001VzdiTjloQlVaNFljYWNlcEJtQ0ttSFhMS3ZZZ0UvWTFj?=
 =?utf-8?B?WHFiTnVKeDlobER3L21RWEVYMzkxb2ZSN1lnNWRyRCt2MWJOUE01NlQyK3Fa?=
 =?utf-8?B?cXd0Q2hTdWRSU3JkYks0NGlRU1I0MDFaRm1YaVAxempLdUpLdlJMd241RzVE?=
 =?utf-8?B?My9sYzBTd2lvUnNlamt1M2xaVFV5TlNyMXFWbGQrUVVZM1BobWcvaGlYbWU1?=
 =?utf-8?B?L1RWM3VvcllvSUxBQXVPMXl2aElrYmlsdEpPU2F3dk5BcVJkb3RvcHl5L2cz?=
 =?utf-8?B?SWZCTlRQOWJYUVZWY1I3TnhENEJOenN1a1Y1Uk9wUnkxVFVoMDRYQS8vMm1y?=
 =?utf-8?B?Z2V5Wm5GUlRjQ2RhK1BmYlIxcm1jYkxrQllpZWdZaStNVTlBWU9yT1J5N3pv?=
 =?utf-8?B?Wkh5WjdheXBkTUpNWHk2MmJNK2R2MHZta1dqMTdkSGRrS2NkSWJjNEd6VE5O?=
 =?utf-8?B?L1U0aDNhWEZCNEtkdHpTVXNOVHJTU1ExNzlzcHI5aTc3dGVGb1pmQTYwTTJm?=
 =?utf-8?B?TFdGOS83akxFbGE5WXpTeVpEWnZya2FCL3hvU0NpckliVE5ObEdKMU5NREtk?=
 =?utf-8?B?UHF1NkpoSUhJVjNwaWZGMVE1SFNGRDNwMXhmaXVWQmZmRXh6S2IzV2dGT0xG?=
 =?utf-8?B?ODV3eVBtS254Yi9QT1psNVlFcXFtbDY3OVZmQS94N2RhcU1Kd1dBenU2U3pJ?=
 =?utf-8?B?WThQdC8wT2xqeTV2c3ZQVlNwWk9uT2dxRmVBaWQrVHpLTWJpSkhKN2kyelYv?=
 =?utf-8?B?UnlmWmt4aTE3REhXQ0tZRlNMSUwzdTF4ZHl2a0EySjFQZWhNMW5zWVo4Vy9a?=
 =?utf-8?B?TGx6dXYzbjNMZ2tsUkF0YS9yMU55VlU2bXYxQXZwUDZObUZLWXF1MERtU1pQ?=
 =?utf-8?B?dXFYMDNSaS9SSW1JZmV0QUZKczdmZENTa2xGTTlJVE4xUjcxc3llU0M5NTJC?=
 =?utf-8?B?UDRmeThHTjNTUEp2b2xPaXB4WWxPZUs5ZmgyUnV4WDE5dWZweHVQWWZMSi9p?=
 =?utf-8?B?VnY5WVgyMTVEbTZ0MG9MLzkxK3k1Yk9sR3gzVUkrb0hxMk4vTlN6Njd1SjlD?=
 =?utf-8?B?WG84b2NVQVI1VWtvdjhFQTB6MGpYSHBvWkh6cW5LV21tUXdHUE0xbnBYL1dI?=
 =?utf-8?B?V3o3VEx0OVpvY1dKU2ZiZXFXVElaeWlXYThVcnpFZU1BaDNqTEE0eERGdmZl?=
 =?utf-8?Q?IFEgrvgZof+NK/gfV/w3AqZix?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aed8fc3a-9e32-4c69-671d-08dc39c1c555
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 07:32:38.4623 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uGa2vn2lqY3RNzGCGPu3IuSHApfe+AiJfH0CrNJ93BwGepsBXZjvMiWp48v9OVYe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7234
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



On 2/26/24 16:54, Michal Simek wrote:
> Remove undocumented DT property. Suggested solution was to apply quirk
> via glue logic driver that's why make no sense to have it listed in DT.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> For more information please take a look at:
> https://lore.kernel.org/r/1708023665-1441674-1-git-send-email-radhey.shyam.pandey@amd.com
> https://lore.kernel.org/r/1708717523-4006664-1-git-send-email-radhey.shyam.pandey@amd.com
> ---
>   arch/arm/dts/zynqmp.dtsi | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
> index b50b83b7723f..daae23c12b79 100644
> --- a/arch/arm/dts/zynqmp.dtsi
> +++ b/arch/arm/dts/zynqmp.dtsi
> @@ -1008,7 +1008,6 @@
>   				/* iommus = <&smmu 0x860>; */
>   				snps,quirk-frame-length-adjustment = <0x20>;
>   				clock-names = "ref";
> -				snps,enable_guctl1_ipd_quirk;
>   				snps,resume-hs-terminations;
>   				/* dma-coherent; */
>   			};
> @@ -1040,7 +1039,6 @@
>   				/* iommus = <&smmu 0x861>; */
>   				snps,quirk-frame-length-adjustment = <0x20>;
>   				clock-names = "ref";
> -				snps,enable_guctl1_ipd_quirk;
>   				snps,resume-hs-terminations;
>   				/* dma-coherent; */
>   			};

Applied.
M
