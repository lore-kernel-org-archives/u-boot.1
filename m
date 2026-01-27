Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 964CCD34099
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 16:01:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA4568408D;
	Tue, 27 Jan 2026 17:01:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="H1gZyzbI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5127840F8; Tue, 27 Jan 2026 17:01:56 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BB8184088
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 17:01:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vgv2MCmDPNdBmqtthqktbM8iyI09qxwJhH0Psz8Uqynr70d3pY/WVb0QPHxT9yIBHkYDPvpjMNQRPpBX0gTrQj3nCzx4qytnzW78JSavBTUbCfzVCPKkD4tYHFmyHlgYfaMysr7WR8tba6C2NRb3D+uchK4YtPr24TUSaxA3S9EnrSDaVObAG4kMp2Bh8IsSVtWO2p2cyK2/erFMvI2YSHDxLkVoYatMNK5MJIhKOpba1Ln2ZFWcqHqCOFY7gT8HreD1wFPgF8DMcz85tp0UkqaDjfNZb1EY7O15iFzVdydMljX5xUTLg/M2tn+gelTE7f/QXZjeY9QiwUtnhdTADw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjMQye4VWV0+vGniaTVEWW0bxSvqX8RPD6Zy5p3R03k=;
 b=Qq0U9zmFS1schui6v9fMidA7EPQW6OTDUhg4jAaCzCG/Z3P3YDd8NB26O0zcARn+opVEyvNlhohxRTXJDyn/O5h/vipHKIP4tbH1SFfrTKREqUdvN3UhFpB42AkuM5LAUKXub/uPYHNJSSBwqkneWuxkTOfYmnNtOqFomjgIZpmyETsIjp8oViS4lUciA6LnieI22PGhVLE7Uf4PeuWUg9xvQ1pj+LndoKsxn4/Dhz4OtnD8wY8oxsU4aa+4am/nBHuRrUYEp+bk32NwbjgSnvhG36pL41PIw8EXDKKkdrqqHakjT7Ji8qCN+MxvXdyM4t7cvAxOqfJ+qTT10+xKPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=phytec.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjMQye4VWV0+vGniaTVEWW0bxSvqX8RPD6Zy5p3R03k=;
 b=H1gZyzbIepffnQbn8zO+7vq8edGh+zXct+3SJUHq2y+nDQhPgoJW45jvwMcQfBBPwR7L2O/fuKRM8xjr5JdovJNYhAPee1VC3/NXqCdxaI1wOBSgn/9N9EB6qnZVCM4YcR5/5jL3lM4ZYuUfMfRwjKKkkPv4Mzi2LkMvao5Q+Rc=
Received: from CH5P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::16)
 by BN0PR10MB5191.namprd10.prod.outlook.com (2603:10b6:408:116::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 16:01:50 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::e1) by CH5P220CA0004.outlook.office365.com
 (2603:10b6:610:1ef::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Tue,
 27 Jan 2026 16:01:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 16:01:50 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 10:01:46 -0600
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 10:01:45 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 27 Jan 2026 10:01:45 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60RG1imh765482;
 Tue, 27 Jan 2026 10:01:45 -0600
Message-ID: <39769c9c-d79d-48b1-bb9e-292d13028f42@ti.com>
Date: Tue, 27 Jan 2026 10:01:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] arm: dts: k3-binman: Use configs for ATF/OPTEE
 addresses
To: Suhaas Joshi <s-joshi@ti.com>, <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <n-francis@ti.com>,
 <s-tripathi1@ti.com>, <k-malarvizhi@ti.com>, <kamlesh@ti.com>,
 <vishalm@ti.com>, <d.schultz@phytec.de>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>
References: <20260127081652.506357-1-s-joshi@ti.com>
 <20260127081652.506357-2-s-joshi@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20260127081652.506357-2-s-joshi@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|BN0PR10MB5191:EE_
X-MS-Office365-Filtering-Correlation-Id: f199814b-9f2b-4d42-b123-08de5dbd61a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bjRSdVpLKys4d0VLeDNKWVg3OXE5aVYwaEN6cHd1UDJvQ3NYV3NDODJEUGRP?=
 =?utf-8?B?enk3d2RvUVB5VVp0Z1JaN2M4NW12YlBkWnFzM0FVaUJnR3ZVbEF6b2dDa0Ey?=
 =?utf-8?B?SXI2ejF3WklvQ09xOWpEMVpubmZjYmNFaVo3MEViTDFEYXF1SUE3SndqeU5M?=
 =?utf-8?B?b3VZVW5WdDJ3bXZXb21WZFhqZXVWeGxuR0VOcy9LNXRjMHU5MFJtSkZhR0Fo?=
 =?utf-8?B?NEozelFTTGVwdjAvYi9DRjI4K0JiM2JNQVZESDVZcU1mcEhRZG12N29sWDNJ?=
 =?utf-8?B?b3lyeVhYVCtHMkN5T1MxVXBCZ2VOY0o2NlNORnJwazZzRVBuLzFrN1V0Mmdr?=
 =?utf-8?B?UzU1Wlg0d2tFUTl0RlVpaXcweUdob0pjakpNYkVQa09IaHNNak9Fak1GNHlx?=
 =?utf-8?B?Q3NqTHVlVDMxb0h1NXJranVBbExGTWNTTG5aeW5JN0ZzUWZYczRHWE9hTzJh?=
 =?utf-8?B?YWdHRU1wSHQ3ODNqQllEaGxDazFmTGRVVmJPNnk0S2l0cnlpRTlHNUFUWlZx?=
 =?utf-8?B?MDMrRElnOE50azNXWGtkNzJncUNYbytYblNFUXFRL1NKVWZFbmxUSktQVEUz?=
 =?utf-8?B?NEJ3cDlxMW5naXVPRFNybENlQ0V4Q0dIVDZjRVg0bjlBZm9JNGgrdTRwczl4?=
 =?utf-8?B?YWV3NXk0eUN1RHk5N1NNTnN4S2tzQWJGK2pVSUpqUFFVWExHUEtqUE9aMDRa?=
 =?utf-8?B?bFYxMG4rMkFlL2kyVmhKeGRWTjUyU3hDc3BVc0UyOVBQeDVqdHFpVjBLTFNZ?=
 =?utf-8?B?a3BBbW16aGJaamx0NGQrcXFBZVZLWkZpdEdMdXhNTXl3Mkw2TDhDbVpVQXdE?=
 =?utf-8?B?Tm1RR3NXMXZ2RGRYYVBrTE1xNWtEWWJEQ1ZpeURmcmZERW0vV3lGRE1KT2FN?=
 =?utf-8?B?eFB1S1k5Y09tOHBCTmFMeDNMMjB6d1NvS2xpOGNuOXhiOEM3WmZoNEZ5N3pK?=
 =?utf-8?B?Wm0yY3crVCt2U2RyRjR0WW9udzI0WisxRnBUUE03OTBXY1VqMUJGZVhuaCtr?=
 =?utf-8?B?aUM4SWxSMWluZ3c4aHhLbWpYMzdmWXB3VnFLUDRQUnQ5dGR2NFZRRU5ncjVH?=
 =?utf-8?B?QUdWMkhYT1M2aEV1TzVYWEJNMytGeDk1UElrUWZyREFzek12QTA2WUgxdCtK?=
 =?utf-8?B?UHd6dEsrMmRMN2VnTzJCZTRjV2pXTERsVmE3VVBZdE9JUnpNeHV0alJ2ZnY5?=
 =?utf-8?B?N3dXNThseE13VmlyVE9zblB5Rk5tQStFd3d0Ykczdkhwb3pvSmJoamkrYXFN?=
 =?utf-8?B?YjRydGRvWFA1cGoyYm1IY0ZxZ01PM2VmNkpzVTFFVTNvdmhKeE5GUk0xU3lL?=
 =?utf-8?B?alNSeE80OVhWamNGVEd3U0JWYlJuYzhTOGh3bnZ4S3Vtck1aUkJFNm9jdk9H?=
 =?utf-8?B?MllpYVlqTVd3aEM5N2RrQ1RPZnV1QWg4RzFNa01wRlR6LzMwQ2JoWDhSR0FO?=
 =?utf-8?B?eWxIbmx2T2lDSGVUUnJNTzJUeEY5SXVMQTlrRkRjdEVWd3NzL0JmMWRpTzNI?=
 =?utf-8?B?N2Jsc0xvY3BUUDJ4RkR5NHJPMWNQYnJ0eHRjNVNQOEdOS2x0OUNYS21PbTVo?=
 =?utf-8?B?Y3lkcWxmdDd6NVVrSHRwU0l1MzQyV3duTkE4UDYxSWFweGVjT1ZzOFFRR0xi?=
 =?utf-8?B?WUw4SVdydXIySktEQTZMcVo0MlNkajVlU1c2OHgxdVQ1ck5FckppdG1yQVFl?=
 =?utf-8?B?Y3E0Y1VwN3JaMTFhRDBWaHUwZk9PazJBMTBFNmxhTzluc2dDM0tYZnFPOEdr?=
 =?utf-8?B?RWlYRXVaK2twWExuMEVobkIvNmV4WDNPUURwVnVDc1phUERXaCtPdW5DdjM5?=
 =?utf-8?B?UkZTUk40REZjL3g1NGlkY1pkS3czVHJPa1YyaEdCdXJyNytBVHdwdC9lUWNK?=
 =?utf-8?B?T2VrMEd3bDlXS3hFTWhIQ0YvWGNqMTRIQUltckNyclJncTRDWjdYQWlqQklT?=
 =?utf-8?B?OHZ2UEpnYzFzeTZiZlZxNW5wTTZUZW9zbHpBUVhhanlETUg4OUE4a2c5TzJx?=
 =?utf-8?B?ZFN5cVdJZjhWb0xWTm1QRlZRNExWYVp4c3RWM2luc0ovdk5Jb1M2VkRRa01Y?=
 =?utf-8?B?TDc2ekpncG53Nlk2WndnTXVhUTNvTDBYQWpWcSthVWNmaTBDNGZkT212WUNi?=
 =?utf-8?B?QXJJWm9LcE12YUFLL2w2M3hiOW0rd2dYN2pyZmJEejN5bjhIazBwZGM5ME0v?=
 =?utf-8?B?N3c9PQ==?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 16:01:50.0701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f199814b-9f2b-4d42-b123-08de5dbd61a6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5191
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

On 1/27/26 2:16 AM, Suhaas Joshi wrote:
> Instead of hard-coding ATF and OPTEE addresses in firewall configuration
> templates, use K3_*_LOAD_ADDR. Doing so ensures that if someone moves
> ATF/OPTEE regions, the change gets picked up by binman without
> explicitly having to modify dts files.
> 
> Signed-off-by: Suhaas Joshi <s-joshi@ti.com>
> ---
>   arch/arm/dts/k3-binman.dtsi | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
> index 761b1730464..0fd93f9536a 100644
> --- a/arch/arm/dts/k3-binman.dtsi
> +++ b/arch/arm/dts/k3-binman.dtsi
> @@ -476,8 +476,8 @@
>   		permissions = <((FWPRIVID_ARMV8 << FWPRIVID_SHIFT) |
>   						FWPERM_SECURE_PRIV_RWCD |
>   						FWPERM_SECURE_USER_RWCD)>;
> -		start_address = <0x0 0x70000000>;
> -		end_address = <0x0 0x7001ffff>;
> +		start_address = <0x0 CONFIG_K3_ATF_LOAD_ADDR>;
> +		end_address = <0x0 (CONFIG_K3_ATF_LOAD_ADDR + 0x1ffff)>;

Not an issue with this patch, this is better than before, but we still have
the size of TF-A and OP-TEE hardcoded here, and also here[0]. Might be good
to add a Kconfig symbol for the size of these at some point.

Andrew

[0] https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/mach-k3/common_fdt.c#L175

>   	};
>   	firewall_armv8_optee_fg: template-8 {
>   		control = <(FWCTRL_EN | FWCTRL_LOCK |
> @@ -485,8 +485,8 @@
>   		permissions = <((FWPRIVID_ARMV8 << FWPRIVID_SHIFT) |
>   						FWPERM_SECURE_PRIV_RWCD |
>   						FWPERM_SECURE_USER_RWCD)>;
> -		start_address = <0x0 0x9e800000>;
> -		end_address = <0x0 0x9fffffff>;
> +		start_address = <0x0 CONFIG_K3_OPTEE_LOAD_ADDR>;
> +		end_address = <0x0 (CONFIG_K3_OPTEE_LOAD_ADDR + 0x17fffff)>;
>   	};
>   
>   	ti_falcon_template: template-9 {

