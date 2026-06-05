Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3F2CD6E74
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 07:50:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A15784715;
	Fri,  5 Jun 2026 09:50:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="HUYhw9Ah";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04D538484F; Fri,  5 Jun 2026 09:50:22 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 352AA8469D
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 09:50:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U67rSaMtCE19K7UVXYdDJ4oyOyiBuXWEc55yY9fl6+Fmwa3lQ/pMOWu8xAKGOuEjl13HLHb/h4q2GxA2BiueK09rEjsIqiQ1toJ7KrOb+1IxtMNxg5PKECsgX9R9yISwvBbQXhY/EqZ7cHNHR+RPQzsSvxB5GnzW/Nso6PwVyTHpkX22xi9JP8G2KELxUkl6Q6vuXs2IHlEGVkZ7sHXFzQssEMoczJ7Q1D+L6i2AD81c2uZoy65W4hHWwp/9Fjx+0E9TRb9OkTrt+gTfWRbRV1wBzRf3vKs8qpR0Z8yYpvTT1vT74ELh5Ab2GlBmbeS4dT5NEyccr1hxfE/eiXCnvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utJlFnajisCQb62HYtpRH1bGwFo4/PHmu0vb5Mo0O/I=;
 b=V5keDHA1fR2YQ8Kj2l9D+9SY3tO66kFeuOTSoZAT2pYuNdzc8OlGhsd68PZYKlhSPRdvPswJHo1q+6MyRyzPQWWe2CiNS1MdT1kUCa+DKMrFm7rIBlvYyFVpWzH1IHA3qr8VOoiqw9TL8FVmA25FN+JPM00XP8kmIBS+60Iz+P/T9GKDgFpzKRJ2lrwgeWnM+yeDt9eIfuDGz9VOMFAUlBZQC2fwJSbtUUFlZYVc89qSd6UueLRLRYePBGDDv6nuagX8WgIBwoHPGa1RkUgxYLsJtZGuhDC7cvrUY/0i1+wk+BTqCMAhqjaY90bM9uX0U1SsFJZhIMhnW0gxEpxWag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utJlFnajisCQb62HYtpRH1bGwFo4/PHmu0vb5Mo0O/I=;
 b=HUYhw9AhmG+UD1rjG2/t+V2YOAQPyNZy/zsVDocBRI1OgK9N4I5FApffIabSybpRZnmICzNoOwKreJJo3K2mJs8ZT+IVuBwdyn+1AgXfhpqZQfG3hDMRwP9HyzG9l272rYpCMUjV2HOJbtwtou2Iv2LoG7pBBvwSU1NUfsOzmQuf5gPiGv5WAHJT0N+RdC3zWFVrqk6C7WBOGy7/tkjAex2dveKh8k96HTdciP/tzTRBQ6krskiaPqMYUPbLhZ3/2tLjZgMAPVOwkRie+RfIvvweHgVijrRMOWfVcgMipUsK7a+AyjLjd6xbNAWSnw+sLHcUfgoiXhA92YnL3w3P4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8SPRMB0073.namprd03.prod.outlook.com (2603:10b6:408:242::19)
 by SJ2PR03MB7138.namprd03.prod.outlook.com (2603:10b6:a03:4fd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 07:50:13 +0000
Received: from LV8SPRMB0073.namprd03.prod.outlook.com
 ([fe80::28e4:3784:eae4:a3a]) by LV8SPRMB0073.namprd03.prod.outlook.com
 ([fe80::28e4:3784:eae4:a3a%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 07:50:12 +0000
Message-ID: <64915d37-b53b-4e38-a1be-35d81caa083f@altera.com>
Date: Fri, 5 Jun 2026 15:50:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm: dts: socfpga: Enable 8-bit embedded device
 support in Agilex5 eMMC device tree
To: tze.yee.ng@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>, alif.zakuan.yuslaimi@altera.com,
 Boon Khai Ng <boon.khai.ng@altera.com>
References: <d37a55490954242118fbf1e9c4c58fb4e20096e7.1778036424.git.tze.yee.ng@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <d37a55490954242118fbf1e9c4c58fb4e20096e7.1778036424.git.tze.yee.ng@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::8)
 To LV8SPRMB0073.namprd03.prod.outlook.com
 (2603:10b6:408:242::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8SPRMB0073:EE_|SJ2PR03MB7138:EE_
X-MS-Office365-Filtering-Correlation-Id: 82cb0576-a09c-4e2c-413b-08dec2d712e9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099006|6133799003|18002099003|22082099003|11063799006|55112099003;
X-Microsoft-Antispam-Message-Info: 0zlfJhKYKYHq7u5lvEhIDOeHMAOxzJbvRzB7LnL8yuLcB0kGxQth4yiR9nBHVylhnUq2VHJ9VNqmkls2WNohl0yJfwpUQ8DrDSDyAkLPvI2pODHRAq254hK5q7Xk0JFYzwhI/P2jG0bGWLfVRgdt7ABuoCvgRnRiWQ7w0IZ8JPfsx8dxvcjXZYgb8MCvbYpBHokvn1VjlJ5pyQ7EfpygZ3JwzveJXc/4MBKoBufOalOhnlbt2Qe9gCs4moXwvsptaSuMv/ZBLWf2uzKh1H2jiWCh2i86vm2Rz9kyFeYWSUQEbbgeSkpcw96LZ/OyF9I2pPK+1o0OGgcfYYT+GWCNn63i9T0DhCRrI7+srNhXDrhfZlyRqma36/638n00CF8Jt/er3yAPjUEx2CwL7VazFZ/zUeVREVYaKzGopCLLJDkfbGBkeu9erRtN/rw2tv0bj7hd/E2wujzY8W1Twm7Iyy9Vl6vfVErGCRJGRE/uJQrG46tndjS/GDC6eITLtizznVX5JGGUtBz840GetsaYh58p7OZMZyloq9Zyrd6dM8da1XpoqnVHmha1Tj3P+BTWJTwZ6laLfSs19i5ueMGiS6KuKB5HTJtoQOuSBeM3cBgxJKMXMhYCnW+MaZf+bEGA/cMKrxJoMLNn5JyoPKetNnnFGXW2uYMwourBMtidXbBRwQf+zGdeNNUYyOfZ6TuU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8SPRMB0073.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099006)(6133799003)(18002099003)(22082099003)(11063799006)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3BERUJKb1prYlZDWmFrOXdQekMyMTlmMnI0RmY5Nmc0WWEvTFJUVHVKK0sx?=
 =?utf-8?B?UHp1N0lXMjhoUDhWWnUyaFFMeGY5aFJCWDNhVGxzWHRDWlF3Y2plSG12bU5G?=
 =?utf-8?B?YXFoVWNFMHZweFB1RmVHY1hSNFhkdXVscFVaZVNPeG4rQ0dXajNtT2tlNkVs?=
 =?utf-8?B?WXZ5K0RncmlsUEx6aHEzVllmRTk1cXJja1J5ZXBPSVdJTlFiRFVjVFo4SzVJ?=
 =?utf-8?B?M0tRb0hJcERNbHNRbWNiRndIWm51UXdJS01uWVpiSUlVR1JqVDhiYTBzUEZy?=
 =?utf-8?B?eG5uT1NEcE4yUDhKVVh2QU9QNzB4ZGdiSktwWmk0djVuaUFDL29DanZSYUs5?=
 =?utf-8?B?MjI5aE9hT1BxRFovTWw4S2k1bFM5L0JXREErWTY2bzJTWTgybmYrQmRxUGsy?=
 =?utf-8?B?OWY2T1NBODEvS0h4cmJ2N04vN2cveVB6TzRRcTNmanQ4Mkppc2Fzam5Kb1hL?=
 =?utf-8?B?dGRnajRGTTJLVXRlT04wN3UwTFJEODFnK3lmRkQrSlhDdlkyeVA1SWY5NFY5?=
 =?utf-8?B?aE1jT2NYcDhaeFFjOStEQjZwY0M3UzNVd2pzVnZBTURzMWJvSE9UMDBNQlQ3?=
 =?utf-8?B?ampqc3AwVWpncVovNlNRSFdRVi80VTR2dzFzejVpVWpFbjdYTURTL1ducGJJ?=
 =?utf-8?B?Rk5PUmNqc0N0T2FVZWpvNWhzRHdwbE55OWdxbUlQZTRZRG95K3djeEtZbG0v?=
 =?utf-8?B?QWcwcTNhbENRbTF3cEUzUXZVb1pvSjRjVUZ6cnIvWk1vWkwrZWNLYjFEZ3B0?=
 =?utf-8?B?SE5TbGdmbXU5N1FydzZJNHdaWkhyTEtZQnRicFRXb0ZUa0gyM0NkSzIxNzEw?=
 =?utf-8?B?TUZoN1Y3MWNHNGdVOXNqOG1ZMlhDKytrUFRXSExDbWxqOFIzYTBLN2FMdHZ4?=
 =?utf-8?B?dEZrcEZrK2srSW5YR29mS3ZNRnpZQ1FLSDZsOWc5MDFYeFVNMkdBekRBVlg3?=
 =?utf-8?B?N2lsMkNJcTRNdzJBWDFqSVZjOGtlRzdOTEdjY2ZCT1hPWUhUb0g0ekRmVVQ0?=
 =?utf-8?B?M2FvWHBVUlEvTmk1ekd5MTJaSlpZT1RVSUFtNnRTL1RRdFhjdXBybWdRNXoz?=
 =?utf-8?B?MFY1Ykt5dGdML1h3Qm41VmZxVTJ0UVpzRitNcTFUWm5NMSs5bDZmcGtIUGNp?=
 =?utf-8?B?aVNkK2FSRkkxTElTeVhLWUdMWC9UR2tpZWhlWDRtcCs2cXhmY01YcWpzQjhz?=
 =?utf-8?B?c0o5NU1uR0plRUsvQ2N1S1lCTkNjYWFOY0pSNFFPbk56SU9KOVI1OUJzWlR3?=
 =?utf-8?B?MHlONldUZ1lwSjhoWFdialVjMHBmSlB0bitGelF4ZWtlQnZGbWJqVWJNenhl?=
 =?utf-8?B?SU1OM0doZGFHeENTUVR2MFMzOVIrMTBCRVFzVXlFemowRW9ZMDEvSHZxVmVJ?=
 =?utf-8?B?VWVla29iVy9tT1o2b1JXMTh5clhlT2taWHBSRVg5dTF2RHVXUGYwMU9rWDJu?=
 =?utf-8?B?NlErZTZYK2M1RkxGb1h2YnBQdnVhMDlBWnp6WGp1RldTSzFCd25IdnkvUlhH?=
 =?utf-8?B?VHZuaXN0aUVHNFp2TTE0Q2dyeURyUUVjbVdmVUpGL1hKVHAxbGhkNjdtckMw?=
 =?utf-8?B?dzhVL0U2Ym8vMzU1NUdIYUN2LzV3K1VBSjYrb3h1OU1iMGxlcjNBczBjMmQ5?=
 =?utf-8?B?cTlNcXJGTFZDT1U3R1psT1VYTlJUSW5zV1IwUmJGSDlGNlJMU25kN2pFZThF?=
 =?utf-8?B?TlhCUEQxN3gwVVZzQUNpYzJqOFU0TGEvbzJOeVFDMDRvcDlqMnVSSlc1WHZS?=
 =?utf-8?B?THZkQmJUR1dUWDNyT2NNNnJ1bkdqQzlQeFBqcTZRNHd3OC9TU3pjd2FSRzBX?=
 =?utf-8?B?clg5ZEJKcldYTDNrUzdFNi8zNzlhRXMzTjhxZmJTRVo2YnorTEp0TmVhZ3My?=
 =?utf-8?B?bWdMb05TclQ5cnNLS0hpM29pQVo5MVpYY2FGdWFJa2k3T1lXUWFINjdFcDVR?=
 =?utf-8?B?MVVaRnpLd1JBOUd0N2lEbHI2Tm9uZmlvRjFCQjJYejBzRUJWUFE2WUFkbEtm?=
 =?utf-8?B?K1JweHZ4RVpSNTV0V1F5SWVZVFRSOTZuWWtadklXSnF0czVuYWttWVc3RUJX?=
 =?utf-8?B?ZGxzT09QaG9BbzdKVUtFSXB5U0FzTU9XT1VXSnJXa3RUMkVjYU5BWmI3Y2wv?=
 =?utf-8?B?NUZ3MDNkQnpxVUVZZnlYd1JJeTlWNkFIcGx4enNkVGlsUEhmTmdCWmNmSXpJ?=
 =?utf-8?B?bGFoZzlaQWkzdWtTK1c3Zk9mK0d0aE5iM1pJMjNGTHJsZXdQajVUV0NCbXRR?=
 =?utf-8?B?WXRDN1E5YW9sa3V6bytSM3pmWTFEOVljVkZLdklOTWhRZnJKT3VtcDdkWXdw?=
 =?utf-8?B?d20yUkZRUEJZNWxGQWs2bVhnWjFuR3c2K3FkUzg5Q2VSUnA4RVJEblRMM3py?=
 =?utf-8?Q?sqNRZEjE3beYs8iA=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82cb0576-a09c-4e2c-413b-08dec2d712e9
X-MS-Exchange-CrossTenant-AuthSource: LV8SPRMB0073.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 07:50:12.8312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dYDRiUkESA7oCSjsMDLeKnR4N++wkov2HAMqKWCIc3O9T86ypeNADYxHRYBzrHN/F+Bcj0/HMB2dCUbio0z7rDteFQ6PXID2rpapzXUysrI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7138
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

On 6/5/2026 11:14 am, tze.yee.ng@altera.com wrote:
> From: tzeyeeng <tzeyee.ng@altera.com>
>
> Set SDHCI Capabilities bit18 to enable 8-bit embedded device support.
>
> Signed-off-by: tzeyeeng <tzeyee.ng@altera.com>
> ---
> Changes in v2:
> - Remove /delete-property/ sd-uhs-sdr50 and /delete-property/
>    sd-uhs-sdr104 from mmc node
> - Fix wording in commit message
> - Update commit title
>
> Changes in v3:
> - Dropping the patch 1 as it is already applied to master.
> ---
>   arch/arm/dts/socfpga_agilex5_socdk_emmc.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts b/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
> index c06781064ca..52aa92e4292 100644
> --- a/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
> +++ b/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
> @@ -32,7 +32,7 @@
>   	vqmmc-supply = <&emmc_io_1v8_reg>;
>   	max-frequency = <200000000>;
>   	sdhci-caps = <0x00000000 0x0004c800>;	/* SDHCI_CAN_DO_8BIT */
> -	sdhci-caps-mask = <0x00000000 0x0000ff00>;
> +	sdhci-caps-mask = <0x00000000 0x0004ff00>;
>   
>   	/* eMMC legacy mode timing configuration */
>   	cdns,phy-dqs-timing-delay-sd-ds = <0x00780000>;


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

