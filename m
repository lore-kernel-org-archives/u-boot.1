Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C6FF41980
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 09:29:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AC2583C2B;
	Wed, 15 Apr 2026 11:29:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="GRpRM5H4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 653CE83D8A; Wed, 15 Apr 2026 11:29:37 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D32183936
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 11:29:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIfhIFb7ZDMLpMZvKn3I0LzpsjvYfu5BWvFzPpSUpXoiNLMkZfmxsjMVcLPa5AAkdYZwEOvmGmbTUnknX1BZ5EZ5jtNoBxp+sp1GcUV3ELyTBAlktMqt4b8M6+6JqMP3rSgA/MIHWyxakSxNaRY++883HJJWqLFXy+GKPoFTPAd3FYG/JuAUfytDF8eYQ7v+S6y/iizguABtSwMUseMnk8ceTkeXdoNZf8cQ2myHcNOi/mZZEP4Eo8q+fqRaGdkagBFdAjt7+H9vnKy9LeKDzXBIb8bE7hJrybaqvWi4IiUF+ENkKajEx3SVKNdC5d7xTZlZyissUAl6XUSwzs2vvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0KRx0/QhSyNBnSkpWr+485BGgW14rIkTaLueqkeCJs=;
 b=tmx7ORnc+0XJHszS9SFpcXsLn8icMRzqGTpA76pGkJtfuB8LX3K8m5R1sR9S9e5wcYXJtlDPaS0WcHmRr3oShf/P+QN3D2rKqdzhgsSNuTe1txeuuzwLmZwtLfgwXUymacWG1bGybBgO5HXJXwzC5vC2MkPEj1pS6tWejT9EhP7fNrUq49mKbGFbqXfEmTy8py9ZOCXvkwhR0pd7nVcMCMxyMK96KqilscPlOk+9sXmcauUa/5FVl9+RUavLS6CQnmyuDF4N6FQzJG8E3VM/CvIJw1qBceAOxOUuauY2buIpcvj0rbyIU9mOsvo3fSu93QaQkQ9WIZXB1TsshuyYvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0KRx0/QhSyNBnSkpWr+485BGgW14rIkTaLueqkeCJs=;
 b=GRpRM5H4SjEs9sjf2iHnWm4Q57ksqbQoT7rrgSq5h2jZDTIvEW2fpu3M9xrhpeshhlPzYFD1kDth7YvflFO/6Su+e6qVkDlD/0dIYRXY9eoJAxbSD1t8PKywyv6Ht5o/KoZDZkjWC+xlNCmrakToM3oNglHVfzA+0YlnFGF/Bj6SICfjW4CBNbfO5dksF9F9JHVmKM1b8GOB0Z4AOnfMzjwoTMa/rhwCScdu3Cr5zjDKB0py3aLSPouh8OMQnU6Vwvow9Nqer7ZvBOXedDKLtY3/PgPlu9rJqI8H59MpZFTnagtNULo4yF2YmiP3jTpUu93TE91WmbMXyejb1oyuyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by SA1PR03MB6594.namprd03.prod.outlook.com (2603:10b6:806:1c9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 09:29:30 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%6]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 09:29:30 +0000
Message-ID: <e1c354cb-4fab-469b-94c5-d816faf3500d@altera.com>
Date: Wed, 15 Apr 2026 17:29:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] include: configs: socfpga: Add environment variables
 for distro boot
To: Boon Khai Ng <boon.khai.ng@altera.com>,
 U-boot Openlist <u-boot@lists.denx.de>
Cc: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Brian Sune <briansune@gmail.com>, Dinesh Maniyam
 <dinesh.maniyam@altera.com>, Tom Rini <trini@konsulko.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20260304040201.9265-1-boon.khai.ng@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260304040201.9265-1-boon.khai.ng@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::17) To CY1PR03MB8121.namprd03.prod.outlook.com
 (2603:10b6:930:106::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR03MB8121:EE_|SA1PR03MB6594:EE_
X-MS-Office365-Filtering-Correlation-Id: 43e74513-8148-4bb0-6a51-08de9ad17ed8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|55112099003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: njcWYC1yupX45sFf5rUyc9k0lZzlwTJtZ56RVCX1R2CGAlvtCoYjN3fM+Et/Zh52fnz6oV33qZcvYnlg0kq1E6eRxjMQfTWmU4gBFedkPfhRpn6C//US82iatcVGpiwuE+c3SziUYtE0dTRgvD18m0tpe+Q2VdRJc7zIcMieh4sNshy5IITqg3bI1+MjZEfnDbDjznwcnTkWVqj+WbMPl6uXueKKeh1810MWB2xvDPOAUp9iWW7+USDR2rdhoLf5KAYUxVMtdQ24WcIhrzC4gNwjcpg4I+hyqntG3V5Iboa8Nw369kTDrZSnNbhuUJG/KM+3u3UxrCWISm7i6J2CTe3q8P0zpuA8z0V4Y7gJvYE13VA8NwwAsTIavbMKQD8Xnpn9Rzl4AHXLK6jLvi0dqET1nid8y0BT88guKPnUF3kzbbx2+S/Eehe0wHWzQKHIfsG67erQU6qdToRzgtFuFLOIdKQ+Z69bw14nAQjusQxntfonyEkwDfIP4fwKSKSvgW3lGol6N3WKRqvzx/56J5RQIvm/E+HbQPdIRsGB3H0SCgjb+AhK4EFg6QzolZYRN1HNQdnmw8/Pk96uCh4GZbOTmqsxKbdEv2ls2v9414hn8C5wwH5cC/XgyxCmucQzKMpv41ZJnz0iThKDOFDCuq7QygIDFxiYVLvx9ujd6kWbIhQW7gOBlrHrTS8S1h3OXKZbmmeHFSnKUAYLQuFfi86JevyFJeNDhJ5yhnb9uTM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(55112099003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDRtbGxQN00vbWJ1WCtZZFdqWVd4bVk1UVdFeWVOTmd1eFFEWk1RZjlnZ3pQ?=
 =?utf-8?B?NVpnMSt6Sk0wbzhGTW0rVDZNMEtrd1YzNXFTYlJabUdvQklSdlFXbXFicWNt?=
 =?utf-8?B?SWhnaG1hSHNOYkkrd3RMeUZZbDZqY2VDMDdoQzhkTUMwUGxmWTRzSkhsdmJQ?=
 =?utf-8?B?U1RVb2dKUHM1a3d3dzQvK1BuVGREVFROdlBOQ28rYlB5akZzVVUrK2hTNEFn?=
 =?utf-8?B?N2dqQ2kxazk5cGw2ZDVNN2xTY0ZOZ3BsVllyTmVqMmlGayt6UjZUR3ZOSjhw?=
 =?utf-8?B?Z01zRFQxZ2JqWi9UMFZCWmNpcnZBS21KUER0MGk0MWhKeDNmSjNZTDhiRXRo?=
 =?utf-8?B?d3B3RXZicGV4MTlrK3ZLSkRnOE4rU0tqVytOUFIxazF0anhJZ3llN1FpbGJS?=
 =?utf-8?B?OTlCWStaWkdYMDh3a2lZVkZWb3loNFdLcTJ6NHBsb0cvaFBFQXVkQlg1WW1F?=
 =?utf-8?B?ZHVIZVkxNktaTDM1R0RiN0d4cTlNeWh0Z1F1NGpRSUpJK0FveFIzbzM4U3FC?=
 =?utf-8?B?NGpRR1FrM29BanVDSkZjNHYwVXFCSktzUGhubG56ZW1VSytFZ2Yrc0N4Q2tr?=
 =?utf-8?B?c3ErUndXSjV1ejZDQVdIYlozMXRwR3hCSkdFMGh1VmdjQUtnc01UbGdwckZ1?=
 =?utf-8?B?K0dlZTFQUnllTkFFUXF4clhLNkFuUHpTU210dTNuRXdPZW00Rkg1azRSU0dU?=
 =?utf-8?B?cWp2YURKR1pWUlJTR1Z3azNMMm00b2dHSmo4QlBybmNEMTh4bk1qZ21JRHRr?=
 =?utf-8?B?QThnQzk2LzRoQVRSRDRvUG45TFVDTG91eWtrTFQ1L3N5ZHo3TUJFN1dNYnVQ?=
 =?utf-8?B?NHFibkl3bXIvTFZvSk5oNzRCVFh5a2NqKzZxVS9DSDlBT1o0TzZqZmdFcExG?=
 =?utf-8?B?S1I2N2tjZktlSXNrelJEQWVOZXdQTjZnc04rdXB6SXBVMHRNK0NCVForQTZX?=
 =?utf-8?B?ZDkyMEk3S0hhOE1DbFg3dDM1dU5SV204ZGN1cUdoU2RoUkw5QTBXUVY5Slp2?=
 =?utf-8?B?L1FONDhTaTVGdTJVZ2tOTjl1Q0NnelpBU0VGUkZjTkhxcUlQbTFTZ3dDZXBa?=
 =?utf-8?B?YUlkd0lRU0J3LzFoSjdyZlhJQmpHSy9kbHBMclFLQ0kweTNjVFBESHpuTDl2?=
 =?utf-8?B?dmw1UUNkOERLVUxjdDlEOFZzeGpkNUlqcHBaUHlsaWl2Y1pndU5oQ09jOVI1?=
 =?utf-8?B?OHM2eHBLZzNDTG5uVFJSYWs4YVZpeXo5ZmxlTzdNRTlNazFuRkJqMm52a2w3?=
 =?utf-8?B?MGdqb2UvTGFOWitQMEJKVm1zekMyYk5HVXRhczVZODdGbTRFdzllWVM5S0VL?=
 =?utf-8?B?bWhDRFh1YW94Y1RYU1VSZzZSTFFmc1V6cXFLU2l0S09Rb3JYalo4dE1kcHJi?=
 =?utf-8?B?YTBuODhoblplL1BLZkdXNm91c0FWTDExN0lyTm54NTU4STV3NmI2TjNQMkhh?=
 =?utf-8?B?V0tQYUs4UWhqT29CbitUUkZhWFQxdWhEVVNZT0x1bnNmMjBteitTWUd5Sk85?=
 =?utf-8?B?dE81TFNwRzRCb2tWNmxML1JsaDNmR3dDZFFJV3Joa3h3d1dkak9WcXFKaUUy?=
 =?utf-8?B?Rm5RUEpYbHRnbGpScEk4R0NzWnhVajVtbWFQekVUQ2h6UGpyOS9NZXhiWHNq?=
 =?utf-8?B?OTZHUlVzWGZ1ZEdqeExwUUlRU2dMTmxTdVBRQldmNmU0bGE5cE5oS1h6NHNS?=
 =?utf-8?B?YkxZUzdmaFkvUHZmTi9oRDgzNklrK3BNM21vakRDVHdxeENEeUMzWGlORDB4?=
 =?utf-8?B?RmNnSnljcUZLQWtWQVB2TGZ2RTJJSWNkV0ZzSWJiKzBxdFNDaDJMczhiTVlI?=
 =?utf-8?B?TUtOcWgwcGZlS0hCbUg5UjdGNnNDb1h3WjFVTFR3RDNxZTZuVTZrUE02b2xL?=
 =?utf-8?B?V1E5YjF2am1kdGtoRUd5dnp2VXc1ejNKZjQ4T1VOWHYyUTVMNWg2RW5qSUMr?=
 =?utf-8?B?RFYvRHVwVkszdkN4Nmx0ZHl0Q1ZjY0Fwc09LaWlaWWRxS3RGMjRFZUd0dnFX?=
 =?utf-8?B?cE9lazdlMVRXa0pCalBmMTZ6dGlPaDBOQWpwWTJ5bW1DVDJYUlBzbUg3Mnhm?=
 =?utf-8?B?ME9pYkNmcVZ2TzY2aEEvclJ3Nnh5eHBYK2N6UnlaZ3RuOGtyL3ZkMWp1eUgz?=
 =?utf-8?B?Wm1NODBuRHhuNXNROUNEbGwxYTdjZ1VXbjVnZ0NsZU9McGxiVGNaeUdZWWFR?=
 =?utf-8?B?MlV2N3p2cE5idkRWV3RWTXJZN1RJMlc3L2FjK1hEdE45bVB3NnVoa245aHZ2?=
 =?utf-8?B?V2J0eXl1R3RCQm5nWWRMOEptWUlxYTk1UjVabUFDcm9Od20wVml3MWwxOWdC?=
 =?utf-8?B?SC9hOW1BRWlFWURrbzZmR21ISzQrSWExbys5UVh5MzN6dXVhT2JoMjRuaHov?=
 =?utf-8?Q?2KJ6UAGMpuqaa/zo=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e74513-8148-4bb0-6a51-08de9ad17ed8
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 09:29:30.4252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JUPLgjZgMfHz+9QgUvRPRTdTowVQFGQTGKnik3LLWtIqtYOQjAKX+ke+2/n9BbvO2T1H13jfOgJC94KZE/YQHeTLedl7cPnwJhbdbtSpqOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6594
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

Hi Boon Khai,

On 4/3/2026 12:02 pm, Boon Khai Ng wrote:
> Added environment variables needed to support distro boot.
>
> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
> ---
>   include/configs/socfpga_soc64_common.h | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/include/configs/socfpga_soc64_common.h b/include/configs/socfpga_soc64_common.h
> index 4d333c63ad9..14c53a1da5f 100644
> --- a/include/configs/socfpga_soc64_common.h
> +++ b/include/configs/socfpga_soc64_common.h
> @@ -144,6 +144,7 @@
>   		" ${qspi_clock}; echo QSPI clock frequency updated; fi; fi\0" \
>   	"scriptaddr=0x81000000\0" \
>   	"scriptfile=boot.scr\0" \
> +	"nandroot=ubi0:rootfs\0" \
>   	"socfpga_legacy_reset_compat=1\0" \
>   	"smc_fid_rd=0xC2000007\0" \
>   	"smc_fid_wr=0xC2000008\0" \
> @@ -178,6 +179,8 @@
>   	"scriptfile=boot.scr\0" \
>   	"nandroot=ubi0:rootfs\0" \
>   	"socfpga_legacy_reset_compat=1\0" \
> +	"rsu_status=rsu dtb; rsu display_dcmf_version; "\
> +		"rsu display_dcmf_status; rsu display_max_retry\0" \


rsu_status is not required in distro boot, and RSU driver is not 
supported yet.


Best regards,

Tien Fong

