Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 124A4F3ED70
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 05:02:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F709839D9;
	Mon, 20 Apr 2026 07:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="LBQ0Cbq8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 071C5839D9; Mon, 20 Apr 2026 07:02:46 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 454E583693
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 07:02:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lrwatES7VqrMqlHz656ViutgF1h6gHe7e6qRz7QHMcwva2ibgJVOV49+fTZrdvA/TiLoi+kQflq7d1p4/SjLf0cr0Bpy9ht5iiVoJfYn/vbl0QQ37jhOoQcB4230V5MO4dtWmeY4+nJY77nHTYv2aRTyM2WMDMuuka2DhQTpZsjb+UWVbKIknLxfokb3+gvwMw6VD/cM9d50qDMpXP2pikiVKk0JsvAhBfkNrzUBt0mNEa/SpG79/lS08Rg/gXjno7H2ot4oD06NMPZ7oplL57cPtHeqtj+SCL5A1OB2tdhozfA3FMCNzoUIFNhsFOOPE7g5cMz/TrxGGPY/212psQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJEGc9vX8tpUBxTRls7HHbiZHOx1iPyxzXF2OUjZCsM=;
 b=lxgE/Dk/tja+a/mIJyN/KrimhMpKbfC/86IexNROe1RhLKqdvqxvELy2pAMZzVmLZCuqbs5kj5kZKolgWwQxjoEzSCB1IV6I4AmmLP0TtXps6pk0tpXwrhehCREzknEepBskZ0T/rrnDVyeg7bonNhCzP8TTUrawWeSY2mlPCXMJSnmND7C27NI7/SMc55xu5xEO7Y8s2uxtuHOQ2Fw3DDWsA/CzHyBrl5c/yfNQVYAqKgadtauLNRIdMzSJF1p8i9XtlwvS3wiAMYHYYpWahr3NsdH2SxxMJTeEmh0c5SelZ3ZjuybVwfGwoM2f3cprUcGrTiOz2i7g3/qMmWta4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJEGc9vX8tpUBxTRls7HHbiZHOx1iPyxzXF2OUjZCsM=;
 b=LBQ0Cbq8/W937BzdCf6cVLPXIA5daTQwa3TmnqMGfJYk4BCFSp4v4FAWO0K7l5rjHCR+Rpln/Sg7b94k64XWNU2dHaajk7+UqqpBFFknJz2fm6yBevhguSCi8O8KL6pcwbMsUx1ZOvmQCkOgVPcBdQ0pyEP9fAc90962b11N3UpH7gb4qsotV8EgarZVDjXqUyEaVemnj05cWwvLOrBH9O8PeKyFQDnh6IGhWlzwXy0zhtB9Mrc0Une2Dq4fEmZ8N5z+0FCLSL2wpEQNGc7T6DLHcRlxGX789iKtV8jOuUkVytEwF5jrTBxvsgnyydbCqbmHoLbfWvmkQpEPVZacMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SA2PR03MB5929.namprd03.prod.outlook.com (2603:10b6:806:11f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Mon, 20 Apr
 2026 05:02:37 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 05:02:36 +0000
Message-ID: <542d6395-44a8-4221-aa7e-97141ec249e5@altera.com>
Date: Mon, 20 Apr 2026 13:02:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Improve handosff prepare on SoCFPGA
To: Brian Sune <briansune@gmail.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
References: <20260411172730.218700-1-briansune@gmail.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260411172730.218700-1-briansune@gmail.com>
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|SA2PR03MB5929:EE_
X-MS-Office365-Filtering-Correlation-Id: 2758a304-0e79-4ac3-799e-08de9e9a09d5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003|55112099003|8096899003;
X-Microsoft-Antispam-Message-Info: f80lHdaAIxniUI+Xn1oA/XkWkQ1q+TYjGTwftYMcPZACx5J+XZoAggpM3OV2m9+ExdDqF0vvCLbDRPbltlfpq0MGPvVAAfJ7FgAjlPoTE9KPUUD/ndom+irRjL2NatETNx8PN1SCrpnJKjKx3vw5jJA+ciV9hqutg3n/wGo7mFmCv37SRXDE9U1//z7MKFsfQXYdVMa/gvsR+6H49+T3w6pWmsithPZI83BlwXCc1hsp6+fQEysH35SWxmFdTyUGBtFp7S3CYN2cDidj+dNOje/3i50NE1HlIi8UWdn+YzcattAzKZpYzlauev/gz5AEXDBPH8o6j1k0p19LHES4BlQQWqRUQL6XRI/KQXXzXKR+hkFbiYX2z70UTGWbIcRpucBLzqwHWn4fpKK7EUuhFP6cnxESoTk9CawW/w0EQ6yC55/605L+0b5W/wpX3RwVbWQBFiN3jR5fGBs8RmH6CFgbq/stY5qY4ODCNknXG8pdUQhkReC9w5sasPDKpGM0ugBfo8KST/okepAATGO7kostFy5cxxde5UWJd593WXxS1k2rW9ol/7Bbpkg0bNCX2qsPptm0NZ9haqsd5aYCJTe/QelwTAb852EanEuP3iOBA7h5QDmqhKzwOHfR3pvGa1qAviokgxRRaIrr/y0H8tRPRreGE/r+ihyNvZaMKEA5frcFr2wadk8NhXaoDMUCfpUoSg65XUxUfXvOWFEZQ37omEdnDcyvUOlwJHsKd7I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(55112099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2YwaFAzZ1lmN2YxakhJci9ya1JqZDNoNEd2d3ZXVFhjU3ZRSHFib1VZVFhO?=
 =?utf-8?B?ZWpuZmU3QU9hMWNXY2FHRmtCeEtGNmhCV1p3OFRscmtwUnV1TkZCRExkUE5u?=
 =?utf-8?B?VlJSeTZaS1BCWERhZk1vT1ZueGNOY0hIdDE4OGdsdXc2NE90VDQyOEV3b0hk?=
 =?utf-8?B?cU5wdVdLV2lUYXZMVWwxNENyR1F5cWs3OU1nbW9hUGNERmxpa0tEMkQyczYy?=
 =?utf-8?B?d25ucU1lZ1A2d3l2aGZ5Wk5zWkZPV3NOWnVpZFFLZ0x0YTUwU0JhZitBL3F2?=
 =?utf-8?B?bzE5QlRxYVhUMkU2YlpZNW5NdlYweklmRFUvRE5xVlFwY0ZoU3FIM1ZGLzBi?=
 =?utf-8?B?TDkyU2c5T0ZkT3JVbld3RW01KzJEUEk5Y0NRODZWMzRjKytDZWNkb1lmb2Rk?=
 =?utf-8?B?MGlMb01OeW5Rb2F5QjVWcXRPMUpiYkJoSGJtQ1VCSzBmbHlFOXQ3UW5DOWVv?=
 =?utf-8?B?dUtCVzN5QjFuTzc5d1lMWVdqRkdjS09aRDQzQnA3UEh2WERtbFVnTW90NUc1?=
 =?utf-8?B?NkpNMGdxQUhPcUdRK3U5TllodWJCaVRremh3cUd3UHc1dlUzOTg2RUNxL2RN?=
 =?utf-8?B?SFh3YUE5alVpbXVNYXc1ekYvVXRMQS9FeEFTcGVjSjE0ZVBzdXNndmhaZTBO?=
 =?utf-8?B?UWdOeGZKaW9XcnZsbVNiTzA1WEx3SjBleXpISHk2OEZUdUNDenNSU08zcTFv?=
 =?utf-8?B?Vk9MaUVPTm9jWGtZVU9OVTNqR2ZQSyt6WWlKeTU0YytIamtCRVFlUUpEc2tB?=
 =?utf-8?B?U0VBNTNiMnFPM3RpMlAwaCtpSmpZT3B5dGVLRXYzZTUwRXoyR09kN1c1dzFa?=
 =?utf-8?B?bXRJU0krM3V2RW01Y05CNk5EdDludWR4cGU1UGVjWWwrUmZMMU5Mbm0vMnNa?=
 =?utf-8?B?VVJ0QXRNVTFhRi9VUWdkVzFNSEE3WTlUT0Q3RnVOUEthRk5sUlJFQjI5cFVE?=
 =?utf-8?B?ZEhuSENlalJnZ2o2UDNxcG1MNGdTcWlqSzFxWWZlYW1sR2NKdE95RG9Bam1u?=
 =?utf-8?B?RDQ5dmZ6V0x3ZlRsQklFVnNnUklXUW5xNjBEN3ZUcUtCeUc5cHRUNHJSeDhm?=
 =?utf-8?B?Yk9nKzcwTjNVR1o4am44YWM5M1IySUJrTGcrTDJKZUVqQnZhVGtUSVB0Tm81?=
 =?utf-8?B?UDNuSi9zTFpBaGlsZjhEekk0QUU1UnFFU2F2RmFrc2RMN0lCenVBQ1R0UnBV?=
 =?utf-8?B?amtYMXFiemNrd1JDWldEQnRyd3BEOFQ1UmZiOWxvN2ZPZzk2OG9jVUJ2MmFS?=
 =?utf-8?B?MmNLMFZ1MjVaNlZuRWdLTk1Ud0hVakRqUVdtZmZaeUQrOUxTOEtoV0tXVk00?=
 =?utf-8?B?dkM1YmtnYTcxbW9rZTg1QWxIUnkyakdwOHA5MFZyTGt6VU1odWRGaHVkczV1?=
 =?utf-8?B?N2NFVWpzS3k4TDNPSHdOek9LM3N2Njg3UVVsREk2WjMvaFBJRW1TWllFTVhB?=
 =?utf-8?B?MzZQZzdmZUxjMjZUNnFLUEZxM1hLWEM1blRJTURQaEdCaVRiMHFwOXZlMjlv?=
 =?utf-8?B?SFFEWjlFR1UwcnhZUGNGeTJNOXdVazhYOWpGTGtyU2FESFdHSTN4RHRGMnVP?=
 =?utf-8?B?cUF0SWtMQVdCeEFLekR5bFRNTS85Sno5dDBHZm1JS3V6R2h2WmhyWTBHWWpZ?=
 =?utf-8?B?SDE0NVNEblRyeUlLejROanR1YW1BRW16ZFJMKytiVXlhaGZmK0VZbUxaNnZs?=
 =?utf-8?B?QTM0WURESmtSRmREZGdYMkdiV3RNNEZCTS9RT0F6T0tyRDEwVUMvcDZ5QnE3?=
 =?utf-8?B?TjlmMVU0aWN2M0FibnZYUE5hSTZnRTIvbXFXWGdLbTBlMEd2RVRpZTh6VVdr?=
 =?utf-8?B?MFVCaDRaRWNVa1FhelZUeExhbFlyemF6NEl6MFhzekxpZUdTNWd0V2F5OU5N?=
 =?utf-8?B?bXR0cFNXc0ZLbVVvMzJnaXVRbTFIdDI0aXFGbWx3UmIvMlVtSmVvVjdtVnBE?=
 =?utf-8?B?b2hFOG5ydCszTlh2ODhvM09wNEFTemV5SXN1bStXMFNoeHVQU2hMRmF2bHA1?=
 =?utf-8?B?Mk1OOUdGb1U2OWJWN2R2YjJ5b1AzUVRNUS9PdUh5RTJxYzdnNnlVRFNQdW82?=
 =?utf-8?B?RmZyd1dOMU5sbjBQVWN6dHhTQkJNV2xlZEtBL1pIY0pUMkJLYUtFbkJnVVAr?=
 =?utf-8?B?c05tMDJ3am1DRHJObzVLQlVpd1IrYjhuNUQ5cGltQjN0NGlrT1FRY3RRWkNQ?=
 =?utf-8?B?NHZaS2RITjZGMnhBUjdXR0xTNE1kTDh1SUdaeGRGQnBjSUVLN1J3WTR3bEdu?=
 =?utf-8?B?bCtaVlBob0t1akpYYmJYWVJjQnA5OFZQUWhSZ0RWRC9vN09DcS9FQk9mZkpY?=
 =?utf-8?B?RWdhMWlHWWNiaTB0REVUZnRBUnRQd3FjcUFUaWJTS0lBNHNSOW50VXVpa3Mv?=
 =?utf-8?Q?lFnNdi40ysMrSfHw=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2758a304-0e79-4ac3-799e-08de9e9a09d5
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 05:02:36.7577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LkPmyifrzeNCyiWRjpOVP7q5NRwo4ptTP5tumWjT2kz5Iil4gBmXHTAr8IJ17rDwsOYacWR54Jd9HlrJzOkquUBkf/Adl5dvO+RwHO3KDaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5929
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Brian,


On 12/4/2026 1:27 am, Brian Sune wrote:
> There are some cases that the Python scripts
> are run and the qts files are not replaced.
> Make sure qts folder h files are removed before
> handoff script runs.
>
> Signed-off-by: Brian Sune<briansune@gmail.com>
> ---
>   arch/arm/mach-socfpga/config.mk | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/mach-socfpga/config.mk b/arch/arm/mach-socfpga/config.mk
> index 1ca1d33cb16..d9d9d4f2373 100644
> --- a/arch/arm/mach-socfpga/config.mk
> +++ b/arch/arm/mach-socfpga/config.mk
> @@ -43,6 +43,11 @@ socfpga_g5_handoff_prepare:
>   			exit 0; \
>   		fi; \
>   		echo "[INFO] Found hiof file: $$HIOF_FILE"; \
> +		echo "[INFO] Clean old BSP files..."; \
> +		if ls "$$BOARD_DIR/qts"/*.h >/dev/null 2>&1; then \
> +			rm -r "$$BOARD_DIR/qts"/*.h; \
> +			echo "[INFO] Removed old BSP files..."; \
> +		fi; \


Thanks for tackling stale qts/*.h when the BSP generator does not 
refresh outputs.

Concern: the series deletes existing board/.../qts/*.h before running 
cv_bsp_generator.py, while the recipe still continues on generator 
failure (|| … continuing). If Python fails or produces no headers, the 
tree can be left without the previous QTS headers but the build still 
proceeds, that is a regression risk.

Nits: rm -r …/*.h on plain files is unusual; rm -f is clearer.

Suggestion: generate into a temporary directory (e.g. mktemp -d under 
qts/), and only replace existing *.h after a successful run (optionally 
copy the old set to qts/.handoff_backup.<timestamp>/ first for diff). 
That keeps the “stale vs new” comparison you want without breaking 
builds when generation fails.

Best regards,

Tien Fong
