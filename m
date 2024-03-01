Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDDEC5475B
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 07:11:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D82687C92;
	Fri,  1 Mar 2024 08:11:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BeOlpz50";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACC4187CF8; Fri,  1 Mar 2024 08:11:35 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4896387BE0
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 08:11:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWdcyHfm+/GV1CWpb40885AaNk3OCqZXV4EGp2Zgv3CWivEA3YSpcBfwkFUhLsKwi8acR+MKL6tjBOyl7kecdrPccLt5w6Ri6INI6UXaH18Lx4uL5QDSEquec0lhZ27wMqhZe9jla3dxQeF5BpW2ssN9MyDvPJ6oqKy0Ogi4CjL+rJwuEHRPSH5oewIT7BN2Ayxy3O+sfqXNZ7WyFg2qzN+t/9f3SSXqgKMwR8N1Txtht55Rw4GZQU07/JymqZEgm5vLjrBORG8gDZwUKFTIOTSokVKf+AlFWjdDLno5T+MH+3e+uZRKEQCFD6hTgUKwK9L4nch9RX4agwCZGHKDOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GAUx8UZM8s1Q7NhsZfifow1gjbgXMrLz6I5oCGFVALM=;
 b=dZjJyBwe1ilb5FfaN/FaP0WI7nSdEyD8xsvH1Appa8kzXW65X4pzWY2RySCXPHtODjgcDINmJKELIJ16mmCJTyVtOX/JzjtYvyJzCiAFF6BEkPF79VGh+84qItiFKOWHTD+UptNIpaMdr0StqD+AfRxudNiM9sFqea8Sd8ELmrSoHzsDj4lgRUQuzQ51cOz7u9WfGBQ9NJyIptwftsX4Y58y7APeTvAdNboZBriHEXgkZVs8sxuSuc2eSDojKts8Yn+tNxDl79XPd/L64fpJ8Iqx/2RnvIWkUIGyL+MvI0V1VfXPB92J8GJCIfdFZcRcjNC/qXfkHMQua9kOD5Njwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAUx8UZM8s1Q7NhsZfifow1gjbgXMrLz6I5oCGFVALM=;
 b=BeOlpz505Sf/YHh4c7Gn81ZkSRn8bu06xNJMGSPMzH5o7vfs0gPozVANtOzsXv1PEOmxZ4D+feZ1tSB/igcc8ZTkJL8NPSdUdWChtiicCe9vjSou0urjC/meaRSGLLFDC1lRRS9/CgRbTv4fDh4P94saLC3aJoTQq66EEf4J9Hw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CYXPR12MB9443.namprd12.prod.outlook.com (2603:10b6:930:db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 07:11:29 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7316.046; Fri, 1 Mar 2024
 07:11:29 +0000
Message-ID: <6f7ddd90-47de-4d13-8e74-38c13e9e04ff@amd.com>
Date: Fri, 1 Mar 2024 08:11:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] configs: zynqmp: don't remove power-domains for spl
 device tree
Content-Language: en-US
To: Steffen Dirkwinkel <lists@steffen.cc>, u-boot@lists.denx.de
Cc: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <20240223140613.1240570-1-lists@steffen.cc>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240223140613.1240570-1-lists@steffen.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0202CA0014.eurprd02.prod.outlook.com
 (2603:10a6:803:14::27) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CYXPR12MB9443:EE_
X-MS-Office365-Filtering-Correlation-Id: d28544c2-f47d-4ba7-fb7e-08dc39bed090
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ggKopiIQyqiEWYXUW7iuIPMewJmOmqCgJHHNhsjgV7WkBeoRYPiib4Eax5sb4T+mxRyKHzGu35NMifX1EKgioGF4QBCCPC6zncKZDenuEAyErEG8A4bD1EfR2NlbqbJDu8p4hL+ZM6y5fFRBhmmRsQg26QKhujlnrV3CS2VcaTKuq3ixOwzlJBWYarD2Epff0amz4ZhbXoU1mb1v7J4IzsM9sq7cXx9BYSdJ7qm/FV/TeqiYod1YT9cXZBmniU3ZZ89WfNAkCTrRenBiEUHlU0FrQhcG2prk3N3yGwD0cJVHb4rIMrG2eA4hBQGOBCx7OxyqDYE9X4vs0YmYYxfkyTlpxIB6kq2AF8DZm13OK/jophH+xOYCCZ4q0yceNQmKiHOI3Ai4H8R70K4Bt7a5XnDmxuiAn5/qdLVJi4DM8EXjUFx5ZQSaL81W3sVJAxibuodsaW4+8nLu+P/Br8SqyNaMKQz2FldXxqMvcDyfDqWZcADQzFOh0ilC61VVB9zRqhBfT9bRTm6ofypgtD8qEu3+8ph6DTxP+AamoMuHJDcrzHzVeOGz0idKmM/C0tNKaI4+HGXyhud2id1Ip977gdxD+HAbaJHnlF+iVYq2mCF/5fSF9WVPdHoiGxZKEPocPc0vt4xnC6YIl40oy/CD2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnhXMHVXVzRFZHR4ZUhwaHVKKzNjczVMZ0RZMGorV0NWZm80TDZlRytJVnpR?=
 =?utf-8?B?eGIrdVIybko5ZzBaRVM5VFpjYzJoNkVsTGhlTWhBQzNnK3NiZVRFZEI4d29I?=
 =?utf-8?B?cEVtQllNMlpJdENzdyttaVRpQTB4QmxYV0tVV29xRDkyNVRUVVZYdHlIL0lh?=
 =?utf-8?B?eXhnMnNvRXpsb2x2WFlrUFkxdVdpUlIrdFVpNjRUcmxxeEpveGdRQnNjM2V3?=
 =?utf-8?B?WjgxL3V1U005c21kRWRBa2lxYlpHQVhROUZuVHNFdXlKTFBiWGJMTEdLTFZz?=
 =?utf-8?B?NGszMzdPcUpxV0FZODVhN1hyczR2aHptNTJPMnhJSnNwVnQ4Q3oxVVBoa2NZ?=
 =?utf-8?B?NExBTGU1SUVNWVF5aGZudEJpUTdDSzR1Q1FxalJkbXlyVzJGZ0J2WEdKa1U5?=
 =?utf-8?B?cUxaL0xYVWlFNjJKNUVXYzdySkRhNUJuR1NuWlVkeDdiQWFCQjRnSlJFSzdI?=
 =?utf-8?B?bVdnRUxjYnZMa05BT2JodlhFR0tqbVhUUG1jYWw1UXZkOUJzTWRNVnRzbEpn?=
 =?utf-8?B?WkVWYkNYeU9taHJVdkxXUzVIdW1sbzhLa2ZYK2RvMVh2SlFRRDRXaWlrNU0y?=
 =?utf-8?B?WGxTU0t0OVlpbk5UYkxSQWtVbmNVWUNnSEdoWWZ0Z0xkSzVjSndiUkUvRGJK?=
 =?utf-8?B?NTZ5N1hzRUFrd2ZPcUdrOVZhc2JIelYwZXNFZUhZYkQ2RzJoYVZwRndNOGRY?=
 =?utf-8?B?aTBVMy9MTmwya3d0Ny9UVTNBZDRyMDBCSVJCOGdrTmlkaE9GMHVvSkZmVzBE?=
 =?utf-8?B?cE91Z1RBMll4TWo4M3luNm1EcU5aQ0JDYXowT3dDQ1dKZ2JDWlFHK0hVV2dJ?=
 =?utf-8?B?OVNHaUZGTUlyVVVuaHl6OUFPUUQyNFdHTkdXQ1FoeFJLNW5CSXpVYVgrMmtO?=
 =?utf-8?B?MkhmM0lmc1MxcWl2MWlkUzBLTWZacFFsVTdkTFc3N01vWE91UXdwKzN1UlF6?=
 =?utf-8?B?aElTRkgzakZRNzJoOFFBcWx2Y3N6NnFUTUlWWklWY2tnM1E0STZnQTBqNGlv?=
 =?utf-8?B?M0JNRnIxbHdyM0FhUzB5Z2VlbGpsVGxjcWo1QTdQVWR0NVFSbGpJL044SjFD?=
 =?utf-8?B?YWZ5anBLZ0w1dmdTWlU1alg3ekdoZ0pmdEw4OThGTHRmZ2NJcitOOENEbXJz?=
 =?utf-8?B?VU1xSVRIcjZLZ0Q0Qlg3elYxaUpWYUgyaHZaR1ZQRCtPY3Jxc28vbUZhbEQr?=
 =?utf-8?B?UUxNM29PZWNhZHJjYVFGSHBnOHl4dU5PbUpmcHYxdHBxaGk3NGRvTE03YUE4?=
 =?utf-8?B?T2k2R2cvaWU3cUZmNjNkU0hsblJwYlFWb1A0ZTFDSk9UbUM4SDJEMSttUFg5?=
 =?utf-8?B?eU43aWVZNjF2eHNpQ0xFU2tqc00vNzUrdnhjdDZuL0lxRXloVEdRSXB1YU9q?=
 =?utf-8?B?TEZxaEU0TndPbGhZNmZ3cWlKZnNpNGZ4UUpaK1BtWWpYMlI0MERaRWw5R0Va?=
 =?utf-8?B?dlBHUW1JUFpHeHYwcmVEbHgxeHI1SkRhS2xNQy9IYnhmcm5ib3NDblVxUHZQ?=
 =?utf-8?B?Ny8wNEhpZGtnQkpsOEVUV0I4ckg5UXpxQjREU3dSMEw0Zk0zNUMyR005WXRJ?=
 =?utf-8?B?UjBLN2dGWW8zS0ZNOVJxcm1YWGlIb3VHY3NaWUszM3BLTldLWXNnL1dJaW5R?=
 =?utf-8?B?TDdkTlpzQ1B2amwxSWN1ancrc2ZQVnJQTzhVZGhUUnV5MWVTVkNNWXUzT0Z2?=
 =?utf-8?B?WkJSYnJ4VGJ6TzZrUGZ6RjlxY2tmWXBxVFFJSmhyS1FSNWVpTFVZazl2Q25v?=
 =?utf-8?B?ZmlYeHNnbk8rVkliMmZmeXkwU2RkdWo2ZktPRWN2b1lPZzlvbTdvZkZJaEpI?=
 =?utf-8?B?TUVaQ2ZlelpOQjFQVzJYZldFMExsVEsyTmNaNytpazFXakVQSFFUejNoL044?=
 =?utf-8?B?eVJHMXJwaWJkTlVocGpaMjRjNVdDdnFMbllwQ3NjTU45OGVjNDNGaURXdmxp?=
 =?utf-8?B?YXA1dHVzaW8wUWthZWFVV2FGc3FsdmhDTmpYU0lhMjM3dnhzSVlPQXZhRHVq?=
 =?utf-8?B?cWtqZDV2Ym5MQ0JIbGtLWEV2SU1MaThGRWpHYmtDTmFWVHIzY3QvUUJMU0hM?=
 =?utf-8?B?Zzc5K0pRYXl0MTFmWVliZE9Uc3RGZXBpYWp4OWlPMlNhQVNCVmxLWmZUZE0r?=
 =?utf-8?Q?3G0JDAaRDvAIB3nuygT20AoBy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d28544c2-f47d-4ba7-fb7e-08dc39bed090
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 07:11:29.5478 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QmiZ6Yk+eYuhInM3cjUlUlrs4rLb5V/h83e5zwXqiP1OhLz2XDDJMg0MBcj/QVLn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9443
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



On 2/23/24 15:06, Steffen Dirkwinkel wrote:
> From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> 
> These are used during sdhci initialization as functions are called with
> node_id even if we're not talking to the firmware.
> 
> Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> ---
> 
>   configs/xilinx_zynqmp_virt_defconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
> index 1fcae45e95d..a96b088534a 100644
> --- a/configs/xilinx_zynqmp_virt_defconfig
> +++ b/configs/xilinx_zynqmp_virt_defconfig
> @@ -107,7 +107,7 @@ CONFIG_PARTITION_TYPE_GUID=y
>   CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_BOARD=y
>   CONFIG_OF_LIST="avnet-ultra96-rev1 zynqmp-a2197-revA zynqmp-e-a2197-00-revA zynqmp-e-a2197-00-revB zynqmp-g-a2197-00-revA zynqmp-m-a2197-01-revA zynqmp-m-a2197-02-revA zynqmp-m-a2197-03-revA zynqmp-p-a2197-00-revA zynqmp-zc1232-revA zynqmp-zc1254-revA zynqmp-zc1751-xm015-dc1 zynqmp-zc1751-xm016-dc2 zynqmp-zc1751-xm017-dc3 zynqmp-zc1751-xm018-dc4 zynqmp-zc1751-xm019-dc5 zynqmp-zcu100-revC zynqmp-zcu102-rev1.1 zynqmp-zcu102-rev1.0 zynqmp-zcu102-revA zynqmp-zcu102-revB zynqmp-zcu104-revA zynqmp-zcu104-revC zynqmp-zcu106-revA zynqmp-zcu106-rev1.0 zynqmp-zcu111-revA zynqmp-zcu1275-revA zynqmp-zcu1275-revB zynqmp-zcu1285-revA zynqmp-zcu208-revA zynqmp-zcu216-revA zynqmp-topic-miamimp-xilinx-xdp-v1r1 zynqmp-sm-k26-revA zynqmp-smk-k26-revA zynqmp-dlc21-revA"
> -CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names interrupt-parent interrupts iommus power-domains"
> +CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names interrupt-parent interrupts iommus"
>   CONFIG_ENV_IS_NOWHERE=y
>   CONFIG_ENV_IS_IN_FAT=y
>   CONFIG_ENV_IS_IN_NAND=y

just FYI. I have asked my colleague to take this to regression and see if there 
is any issue. I will let you know when I know more.

Thanks,
Michal
