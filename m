Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0601C25B75
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 14:30:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26F1488297;
	Mon,  3 Jun 2024 16:30:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eso9ZLaT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14AD7882AF; Mon,  3 Jun 2024 16:30:43 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8816987ECD
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 16:30:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwUa6RW7odTzD29J9GiU+dK4IkxcdgAMoQ+6LgcPCEABKhxW0whdT8p57J/C8nsFbkLq4qI3m3TXy91vQSU/imr81SgWTTBCecKTD+JCcWuymYatN5boJtzunRcElBKAROZF8+22FTct/gTYgfj7uaJ05XaJIhjSvAfSsdmY6SgOe1wNWh8jnP1l0nOin9hFsLDzftIsCgNbOz2nrMbqnp+2QRuaQesguJRmHx9YPVYsT1FNfIQlAE5sFK2D5CFpD/TqNYBhkO7gYQjaXeJlW4TY0cjnjVNE1XUgdkk98LxSXfM/3WXnzEp5blegWr8+0bDt53PyB6Iw57rGO9lxLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUf/weHmc0JTM832YDtX2BIyymqVRYxFC0rcw69rRFA=;
 b=Xgm//1q2aoBWxZjZ9nOzgpm4WrYmmvzaGmquq1x5fzDuPwBRv1wjv4hyO30oq1JSNY21hZ05xe4hj9yP9rzByinenrfk3oHWT4S204FrEIAvKaVmBrV2mzvSbYH2i0b/xjDCMK2QfYCIJiWRiLnsbtz2COtlsMQwDDRN7OZFWCGYpigbAmsBPS/75ZDlwWA3tL17xMkJB/zNv2t9caxU2NxFNyAvB1rhBq38btY42pY3kvGYpF7caLdnQ/r+qVnx41r908P3gyTSULB2Ho7ETKxKsarwtsCifz/OFamG08bdce0iZziX5cO38gXDrWoQau4jjxlWaUMZAKxOyjfd6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUf/weHmc0JTM832YDtX2BIyymqVRYxFC0rcw69rRFA=;
 b=eso9ZLaTfOcOpHsYG0Gt3ohyG3/TQb7zJFqZO5e6B7Do+QKEljcl6zdvJNpmB2922oFh0fHoaXnL0loX/BsLffuvbYU/2d+hpZmJL3mPt3oqLmfVe4V4EWY3NBKOQLE4KwNCASZO0C6W9PIBvpvNSj0DwPLk7RqA9ZEcsOZSUSQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH2PR12MB4039.namprd12.prod.outlook.com (2603:10b6:610:a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Mon, 3 Jun
 2024 14:30:36 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.7611.016; Mon, 3 Jun 2024
 14:30:35 +0000
Message-ID: <61dd0177-12af-422f-a61b-18263104a600@amd.com>
Date: Mon, 3 Jun 2024 16:30:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: zynqmp: Add 'SPL_ZYNQMP_FIRMWARE' to Kconfig
To: lukas.funke-oss@weidmueller.com, u-boot@lists.denx.de
Cc: Lukas Funke <lukas.funke@weidmueller.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <20240603133447.173402-1-lukas.funke-oss@weidmueller.com>
 <20240603133447.173402-2-lukas.funke-oss@weidmueller.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240603133447.173402-2-lukas.funke-oss@weidmueller.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0165.namprd03.prod.outlook.com
 (2603:10b6:a03:338::20) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH2PR12MB4039:EE_
X-MS-Office365-Filtering-Correlation-Id: b6bf4ea6-fabe-4caa-5555-08dc83d9bb6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3BvUlBjMVN2VHlkV1l1eWtkOXMrMlowS25KMzIwSGc1a1RoMXl2ek9PRFFo?=
 =?utf-8?B?bVJCQkNSb2lBZ0tEMWhadnhoUitQR0lJWC9iVTV6eHI3V2dseHdtOWlIM1Iz?=
 =?utf-8?B?U3ZaWUV0K0dDUVBGd1J4dnpCU0k0a2Z1RWx4RTZnZXVjV01WMSttV3o2VHpY?=
 =?utf-8?B?OHNwaXFDdm1tdnZ5WndMaStvTFhwWFVLaHFoNEVYVHNJWU56Qkx2NHFjRzI3?=
 =?utf-8?B?ZDZjYXR5c01KeXNSdThZOVBBU1Y0V1A1S2tWamVoU0F1UElkZkoybWlFaTho?=
 =?utf-8?B?QWlyVm9TZTRaeHNXcnZCbFUyRGxaZVR4YkVTKy9vajc5ZG5wYWJqRUMxUzRF?=
 =?utf-8?B?K0hIQTlqclpFVGdicEUyRXRLTUlzRWR4RWc4MXlWZmF1SXdKY2MzU2tLd3Nx?=
 =?utf-8?B?SnZLS3VyeVVxUWFpaEJkY1k5akl5dGlsRTkwZTlyQnhPZHd2MEc3OFByeEY4?=
 =?utf-8?B?c1pCM0ZlTndWNkI0VVVQQmJsUHVqdU82cklCY1U1c2IrYnBrNGdXWVNOVGJT?=
 =?utf-8?B?YjBURytFTnRpWjJSYU5hLzc3WGR6OWxUWE5BOThDSGVNdTVhWkpQbGVxMGZ4?=
 =?utf-8?B?clFlRXZseXlpVnAwdnVNaVJkc0wxeFVVaCs1YmVIR2NrVVhPcXZqdVpzclRX?=
 =?utf-8?B?QTE2dFFEbm02Vi9OYWxaK29MaitkTUh1ek9YcGdYVHFnSlMxNGhBbDVXYktT?=
 =?utf-8?B?QXlmMlEyYzNYQndUaDNpMmk1UmpWdGpuMGtOOTVTTVRqbXVRNTJKK29QYkhV?=
 =?utf-8?B?ejhkUmhhakdXTmpTdnZTdkprMS94bzNtUTBpSlRPdHlNSTRMY1UrNjd1ZUlV?=
 =?utf-8?B?UU1FNFphVVg3OFIwdkxvajZRQnduekE2YXE5VDlBM3YrcGxxT2VYMnd6cmMr?=
 =?utf-8?B?TjdZSTBHUXVCWHJiKzRuK1FMMWFhMWVGMEtHVjQvTnFtZ05kOWtkZFdwZVhX?=
 =?utf-8?B?dHFLVFpiR1lQMEF0eWYvb0Y0NkdSREc2MTFPWWJyYmNTRHpieFJ2RFlLcUh2?=
 =?utf-8?B?N1l5dWZhNHE2ZzJsSzN3Sm1kbzBJellocnpCVlFqS2FMS2JUbkNPaHpWY3Z4?=
 =?utf-8?B?OUtlM0hlTXB3enpJRXBzbmN0cDZIb0FTMkNSbmFiZlRZODh6amQ5ZXNzeWpq?=
 =?utf-8?B?N1lCbmFBMjUza3BVS1NNanpFRElMYjhJNndiZktkb25LWk55SFdaNEoxVlM0?=
 =?utf-8?B?ZWtVSHpEbk9hK3pnMi9FVEVwZ0g5Q2hkemtRMFdVeWFDOU43SzRpSGxZdG5Z?=
 =?utf-8?B?clNVN004c2dCWTBnem92S0RFL250QjdaS0RScVVzalRxRnJVY05OY0dXRUNO?=
 =?utf-8?B?OTNwVlVnNlhLMm84Y2lKY2ZDdlE4aWFrSmtFU1ErUWVFa1VHaHpKYXRKeUlm?=
 =?utf-8?B?dGN3SUJ1MVpvT1ExUSt0WksrN00vb1NZa0xEcUovNXVLUlJoTU55Y1hSNTVl?=
 =?utf-8?B?OWhzUnRCT2p4Z0pwKzJTRU4yU0FWYnJSL2pHVFFrdmkyZWs5VndHSmhQd1B5?=
 =?utf-8?B?TEorMXhNa3F4QXE2NERXSDNPV3p5ZmNqa28yczk2amJFMGc3RlU2U2I3MStq?=
 =?utf-8?B?ZjR6Q2hJazBZZWxWVFB2aWkvejM5SjAwUmtjMXdaTkY3d3dyTXRNdGJDZG1r?=
 =?utf-8?B?c25xVmpYRk84bTNRNXBNdStHYnBSMklFdGQyRUlocXNRR2JWb1M2K1AycHlU?=
 =?utf-8?B?NlM0c0VoemV1K2ZPalNtM0dHNldLdWFkcDl1Z25DRkdwdmRjV0VFWnMyOTBk?=
 =?utf-8?Q?TppPuKoLdd8teyHGkg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(7416005)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elVDZ1JmcnhCMWhUYVFxM2FaUnlEb1RQczB5UkxwYjhrd2FjUXAwNCtiNXVp?=
 =?utf-8?B?UnhsaFF3Nnp5VitEd2RHS3VpUVM1QkJ1MmFwTzF2M3p5TXhpemlGbzhaaHVt?=
 =?utf-8?B?dE5Ra1lzZUFxSUlVM0Z4d2t4SGFwNSt5VUcrQ0s3QjFuaGpKY2Y5dVYwRUJM?=
 =?utf-8?B?NHdWUzh4N2I2R3A4dlg5T3NSaXBwakQ0WkxrOVJaUFBVSVhyNUZaQjdpVlps?=
 =?utf-8?B?NVQ1Ung3alYyMmtLa2poMEl6YVNkVHdVczBtdkJYWDRZUXFnQ3grdEc3T213?=
 =?utf-8?B?RE5ZMGhlQVo1bE5Pc09KWDVOcFh1QjBJWEdpbXVHWkR0M3F1dXJBL0pGODl0?=
 =?utf-8?B?WTkrSVpDaUJZY2lrenR0dGxZTkptTklidmVxa3k1SmJUci9zRWVMTEF0M2VE?=
 =?utf-8?B?dmx5T25ubjV0NzhPc0h1Q3FXcnVWcy95SnN5SjYwRU1HTUE0eU8zN25mQlJK?=
 =?utf-8?B?NlJTbVBJdlNrOVZreVJabG8xQ1ZjNmpXbWNwenI5ZVhrUHFHQTJmVVJrRFU5?=
 =?utf-8?B?R0lrVW0wZDdBTnBzZktqQ1FzK3FKRzhaTjlhVGRjVjhLR2VCK1JjVmpSZTlK?=
 =?utf-8?B?VEF0L0xIcUZKVnhxSi9UYWpEdzBJeE9Ndi9TNWZjVXJWMXFCNG1zamFtbXlu?=
 =?utf-8?B?NFRVQjhCcy84NDdndVFmbFY4MDhSRVJnUzcxbCtDSFN1UklRUFRUc01OSklu?=
 =?utf-8?B?aVRZL1U3OUZvbGlFQkRWTVloYTBtdVBMb2tCY3JCaUUyUWkvQTRnemV1RGM0?=
 =?utf-8?B?dlQyakNBYjc4eWVxRWpqK3I4bmxsUkFsa3U3cXV0aVZ4ekgvOEhmbVBSdVU1?=
 =?utf-8?B?MmdtZWNTMnNqVitPcXZ4aHRFbUMrd2ZkYU1LU3lIWDRpQmo5eTF0STJyOFZT?=
 =?utf-8?B?M2N0cmNOMlBxeko3SDl4SEN2Ti8yMEhMclltbEY4cm9oaTIwMS9kRXNWUDBH?=
 =?utf-8?B?eGg1WkZMUDk4cjNlV25xdTU5K0JXc2EzdytELzQzVWFVajBkKzZHUE5pWDQ1?=
 =?utf-8?B?VnQyMStJN0d1WnlUQWl4L1NHR1FEaFJ0cFVkNkJ6c1V5eFphdW13SkpVdkli?=
 =?utf-8?B?b3ZIbTJOYnVsQlhrZW92ckZBL3NaZU1Xb0R1YVRSRGFZWlVSTzdaZEZLQk1a?=
 =?utf-8?B?Q282bmtBcWt5SVFRa2NlSWhxemdnNzVaS2kvUnlFYnc4WXowWkpGK0tOb0Nm?=
 =?utf-8?B?ekNZWDZCWTlhMXluRjFpWWZEMDN3T2NtcXBjYldiTmFrenQvdnEvd2NOSURU?=
 =?utf-8?B?Y3FUOG5ORE1tenZTaTVKZC9lNGZIZXJzdmxoV3BhS0hlMWZLU2pkTDc0emMr?=
 =?utf-8?B?aTFJNTZaVnZyMXhmWEppU0tDSGI2NmV5d3h3YVg4R3NIWE1nS3lWdndnc3lR?=
 =?utf-8?B?aSttRUtvQTlQdHRQTmFVdDFEMFdnS2NuZEhaOXl4OUVWS09QM1M2aVU0WGVH?=
 =?utf-8?B?NUhIakR5ZVdBM1pwQ21KWFZJMG9EaUo4MS8zV1UwdGJkVWc5RUs4Z1YvQlNO?=
 =?utf-8?B?QTU2UFVHTVJ3QnJPMG14eUdSdm8vd05ZQ25nRlFkTGlmOEs2bUVKT3hhMENF?=
 =?utf-8?B?Ty9iRVlzOFV3dXJNbU1DQlZiRDVESE83ZW9wYVA0Y1dFTC9kaVhGQ2hWZUpU?=
 =?utf-8?B?UFBQcFlXdm5JdXMxaGZsM1NjSDlyVlNvUE1yeGpJU0N6NVNoVHdUeHNudUl3?=
 =?utf-8?B?N0tyUHgrMnNvaC8rU2JPcVo4alFHODJxWEplZnNGRTcvMGxxaVdZazlUK2po?=
 =?utf-8?B?dGovQzZ4UnNacCs4aStrT3ZpTnhCS3JmdExCdEN6S3AwZ1g5MTcrUHRhMjRP?=
 =?utf-8?B?UTl2YUN5dFh3a2FNdnRjUFpvYTVOaklYT1c4cDd5TWs2Nk55ajA0K3VTYWxH?=
 =?utf-8?B?ekxFc2pzSmoxT084L3lNVm5rWG5DVkNtOFQ5eUpkZmk4dHNIS3ZHeEpIVXRE?=
 =?utf-8?B?em5zVm10NUgyOExBWW9IQUNaRkExWUpyY2Y4ME5DNXFXeE11RUFuYXhGc0hV?=
 =?utf-8?B?U1VrUkdLdDdwRkM2bHpsZVVIWmI3TkR2VFdlQXFnNm1lZmxCSjltSGk4WERY?=
 =?utf-8?B?cWprRWpYeXQ5b1d6enFoMTVoUURUdUtiaUdmTUI1MVNDcXJKbGp4VDZVUHp1?=
 =?utf-8?Q?dpv1JWDF1BOT5nc62Rp/AbUxc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6bf4ea6-fabe-4caa-5555-08dc83d9bb6f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 14:30:35.8116 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HcZJOfpqhyxrzwqSAHp1bMOBBhmuH2o/A88ekF6pg3ZDwGArsxBwfEZhrPias4k6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4039
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



On 6/3/24 15:34, lukas.funke-oss@weidmueller.com wrote:
> From: Lukas Funke <lukas.funke@weidmueller.com>
> 
> In order to make CONFIG_IS_ENABLED() work with 'ZYNQMP_FIRMWARE'
> introduce an additional Kconfig 'SPL_ZYNQMP_FIRMWARE' which is selected
> if and only if ZYNQMP_FIRMWARE is enabled. Driver are adapted such
> that they build with and without the config being set.
> 
> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> ---
> 
>   arch/arm/mach-zynqmp/Kconfig | 2 +-
>   arch/arm/mach-zynqmp/aes.c   | 2 ++
>   arch/arm/mach-zynqmp/cpu.c   | 4 ++--
>   board/xilinx/zynqmp/zynqmp.c | 4 ++--
>   drivers/firmware/Kconfig     | 5 +++++
>   drivers/mmc/zynq_sdhci.c     | 4 ++--
>   drivers/pinctrl/Kconfig      | 2 +-
>   7 files changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-zynqmp/Kconfig b/arch/arm/mach-zynqmp/Kconfig
> index 0d2238ace1e..304dce45439 100644
> --- a/arch/arm/mach-zynqmp/Kconfig
> +++ b/arch/arm/mach-zynqmp/Kconfig
> @@ -36,7 +36,7 @@ config PMUFW_INIT_FILE
>   
>   config ZYNQMP_SPL_PM_CFG_OBJ_FILE
>   	string "PMU firmware configuration object to load at runtime by SPL"
> -	depends on SPL
> +	depends on SPL && ZYNQMP_FIRMWARE

Isn't this SPL_ZYNQMP_FIRMWARE?

>   	help
>   	  Path to a binary PMU firmware configuration object to be linked
>   	  into U-Boot SPL and loaded at runtime into the PMU firmware.
> diff --git a/arch/arm/mach-zynqmp/aes.c b/arch/arm/mach-zynqmp/aes.c
> index 8a2b7fdcbe9..100dde2f372 100644
> --- a/arch/arm/mach-zynqmp/aes.c
> +++ b/arch/arm/mach-zynqmp/aes.c
> @@ -17,6 +17,7 @@
>   
>   int zynqmp_aes_operation(struct zynqmp_aes *aes)
>   {
> +#if CONFIG_IS_ENABLED(ZYNQMP_FIRMWARE)
>   	u32 ret_payload[PAYLOAD_ARG_CNT];
>   	int ret;
>   
> @@ -54,6 +55,7 @@ int zynqmp_aes_operation(struct zynqmp_aes *aes)
>   		       ret, ret_payload[1]);
>   		return -EIO;
>   	}
> +#endif
>   
>   	return 0;

Very likely you want to return error if functionality is not present.

>   }
> diff --git a/arch/arm/mach-zynqmp/cpu.c b/arch/arm/mach-zynqmp/cpu.c
> index 6ae27894ecd..3515be257a5 100644
> --- a/arch/arm/mach-zynqmp/cpu.c
> +++ b/arch/arm/mach-zynqmp/cpu.c
> @@ -188,7 +188,7 @@ int zynqmp_mmio_write(const u32 address,
>   {
>   	if (IS_ENABLED(CONFIG_SPL_BUILD) || current_el() == 3)
>   		return zynqmp_mmio_rawwrite(address, mask, value);
> -#if defined(CONFIG_ZYNQMP_FIRMWARE)
> +#if CONFIG_IS_ENABLED(ZYNQMP_FIRMWARE)
>   	else
>   		return xilinx_pm_request(PM_MMIO_WRITE, address, mask,
>   					 value, 0, NULL);
> @@ -207,7 +207,7 @@ int zynqmp_mmio_read(const u32 address, u32 *value)
>   	if (IS_ENABLED(CONFIG_SPL_BUILD) || current_el() == 3) {
>   		ret = zynqmp_mmio_rawread(address, value);
>   	}
> -#if defined(CONFIG_ZYNQMP_FIRMWARE)
> +#if CONFIG_IS_ENABLED(ZYNQMP_FIRMWARE)
>   	else {
>   		u32 ret_payload[PAYLOAD_ARG_CNT];
>   
> diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
> index f370fb7347a..95a134b972d 100644
> --- a/board/xilinx/zynqmp/zynqmp.c
> +++ b/board/xilinx/zynqmp/zynqmp.c
> @@ -147,14 +147,14 @@ int board_init(void)
>   	int ret;
>   #endif
>   
> -#if defined(CONFIG_SPL_BUILD)
> +#if defined(CONFIG_SPL_BUILD) && CONFIG_IS_ENABLED(ZYNQMP_FIRMWARE)
>   	/* Check *at build time* if the filename is an non-empty string */
>   	if (sizeof(CONFIG_ZYNQMP_SPL_PM_CFG_OBJ_FILE) > 1)
>   		zynqmp_pmufw_load_config_object(zynqmp_pm_cfg_obj,
>   						zynqmp_pm_cfg_obj_size);
>   #endif
>   
> -#if defined(CONFIG_ZYNQMP_FIRMWARE)
> +#if CONFIG_IS_ENABLED(ZYNQMP_FIRMWARE)
>   	struct udevice *dev;
>   
>   	uclass_get_device_by_name(UCLASS_FIRMWARE, "power-management", &dev);
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index 8789b1ea141..ae785d55d54 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -30,6 +30,7 @@ config TI_SCI_PROTOCOL
>   config ZYNQMP_FIRMWARE
>   	bool "ZynqMP Firmware interface"
>   	select FIRMWARE
> +	select SPL_ZYNQMP_FIRMWARE if SPL

I don't think this is correct. Why you should connect SPL symbol with non SPL one?
I would just remove line above that I can enable/disable firmware in SPL or 
U-Boot separately.


>   	help
>   	  Firmware interface driver is used by different
>   	  drivers to communicate with the firmware for
> @@ -37,6 +38,10 @@ config ZYNQMP_FIRMWARE
>   	  Say yes to enable ZynqMP firmware interface driver.
>   	  If in doubt, say N.
>   
> +config SPL_ZYNQMP_FIRMWARE
> +	bool "Enable ZynqMP Firmware interface in SPL"

Can we remove "Enable" at the beginning? Or add Enable it to ZYNQMP_FIRMWARE.

> +	depends on FIRMWARE && SPL
> +
>   config ARM_SMCCC_FEATURES
>   	bool "Arm SMCCC features discovery"
>   	depends on ARM_PSCI_FW
> diff --git a/drivers/mmc/zynq_sdhci.c b/drivers/mmc/zynq_sdhci.c
> index 935540d1719..3e4cae60c17 100644
> --- a/drivers/mmc/zynq_sdhci.c
> +++ b/drivers/mmc/zynq_sdhci.c
> @@ -992,7 +992,7 @@ static const struct sdhci_ops arasan_ops = {
>   };
>   #endif
>   
> -#if defined(CONFIG_ARCH_ZYNQMP) && defined(CONFIG_ZYNQMP_FIRMWARE)
> +#if defined(CONFIG_ARCH_ZYNQMP) && CONFIG_IS_ENABLED(ZYNQMP_FIRMWARE)
>   static int sdhci_zynqmp_set_dynamic_config(struct arasan_sdhci_priv *priv,
>   					   struct udevice *dev)
>   {
> @@ -1094,7 +1094,7 @@ static int arasan_sdhci_probe(struct udevice *dev)
>   
>   	host = priv->host;
>   
> -#if defined(CONFIG_ARCH_ZYNQMP) && defined(CONFIG_ZYNQMP_FIRMWARE)
> +#if defined(CONFIG_ARCH_ZYNQMP) && CONFIG_IS_ENABLED(ZYNQMP_FIRMWARE)
>   	if (device_is_compatible(dev, "xlnx,zynqmp-8.9a")) {
>   		ret = zynqmp_pm_is_function_supported(PM_IOCTL,
>   						      IOCTL_SET_SD_CONFIG);
> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> index a1d53cfbdbe..d2ccfb724af 100644
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -335,7 +335,7 @@ config PINCTRL_K210
>   
>   config PINCTRL_ZYNQMP
>   	bool "Xilinx ZynqMP pin control driver"
> -	depends on DM && PINCTRL_GENERIC && ARCH_ZYNQMP
> +	depends on DM && PINCTRL_GENERIC && ARCH_ZYNQMP && ZYNQMP_FIRMWARE
>   	default y
>   	help
>   	  Support pin multiplexing control on Xilinx ZynqMP. The driver uses

M
