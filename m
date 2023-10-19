Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B91CDB482
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 10:29:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C66348720D;
	Thu, 19 Oct 2023 12:29:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hUVpK1PX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48E49871F5; Thu, 19 Oct 2023 12:29:18 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::609])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 383F087211
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 12:29:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4VXCEK+sJOU29Rt5jEbbMWHJJtXChq/i1iiDY/TZV5s9PGRPZQuXMcfOi1ToaPZAf8yY0bksy9MoneW3bNqJtztbDWEBlW0hcJyO1JnK1EHYYlJgqXCucgljYofb8MV99doAzMSbd2qOBNuRntQ67JnWTXOaFaW8g5EQrIlegShEWztttKcOVd2KKheTlZwaHxy+NX/JduOG8EPveV7JscYPlTOx5FICb4caEsndBk5MiLNKqIcGc/jeRsZ3/oLfg4H3ch+wW+9+nRdBbk+Z4liGah0DBBHySy9L7AY9GXa8I3g/FxmR3xbgD66NVe41B/X5QrPZYdH5dSfHS7NWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBoZHgeacEQ5sb4/Nqiqfturk8cXwzT25L2HNRO0x6U=;
 b=hfr6uzD+3wI7CXEcGpzu8vZrIo1LMB9Bm2E5Z2qOeduoVP5AHrT3WQ3KPBKckxHrIzbG7mUlY1TnduuG6QNJB/8QEjyxYZud2OnxLRQ50YieTJrcHImVXgTNMmtYY/PhABnp22L/GU5Kv0sKbtvicJViY8uyo0W+/2BqDdDuJwCNkvMbO0YVyyvD2BBgtuwfdMQOBSzcar6EtkXvy0GcqSJ1ZeZicFUpmshv6sn5mVqHieDZM1aniSrX6X4Z4TYw3DZJBt94XQrE1pvpy+KhStnk36m7rkMF7A1JpX7W9H/T7Nvv0YwlkB9EvPnVyhwzpXZH8R5L3hP9YiYIMNAspw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBoZHgeacEQ5sb4/Nqiqfturk8cXwzT25L2HNRO0x6U=;
 b=hUVpK1PXKfF7wKSIJYULRjJSfXz0U6SFegkkCNXDjy+XAOCVkUXcsFNj8tZFswsuLF/7gQPMa44Ful5BWLoLgiIErt7zUZRuhWR1W1tqdYwzC9sroOU/lKKShiDWRzxzYcMk0tm5Sj7xmIAaZay0rKjIbx2ONdvBSqGvDDNuy4A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Thu, 19 Oct
 2023 10:29:05 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::b220:eeee:98e7:a62e]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::b220:eeee:98e7:a62e%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 10:29:05 +0000
Message-ID: <f926f5ab-3fbd-454d-a634-3df2ad8b0f30@amd.com>
Date: Thu, 19 Oct 2023 12:29:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drivers: firmware: Handle error case in the
 zynqmp_pm_feature
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: git@xilinx.com
References: <20231011025647.17200-1-venkatesh.abbarapu@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231011025647.17200-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0066.eurprd03.prod.outlook.com
 (2603:10a6:803:50::37) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|LV3PR12MB9166:EE_
X-MS-Office365-Filtering-Correlation-Id: a1b6e1d3-c418-441c-212c-08dbd08e3841
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nqKaRFRRYND8nbgvzMGA+QgrFzhklNMgbCtsKpfgSvyv9ArgD9a7w3g20xoaLaweQcd984O7NXb02UvnWwMu2lpywtfttI6PHyZskxzV8Hha0UkLSaZxpUphhpLkMS309t2OlnRgn79EV5zAnxxjvMwWENio3YVbQZxqlUJuRVAgBCHtl0c842ox4q1/6j9nbQa15zdlTSi7H5Ma9HdavuMoK7sMwOR07yBQNaf7Vu6XujF4PgNF6xHa73ZBReuWrFDgGGiqopzobw+sXZAsyHMDo5VP2Ch+DfRzKYThiaCgw3HZOMM+XVCdzgrAHCVgCEjRBaGFXn/By+/7YzmVJLCMgPkRMtlE6gjdfmiMvrECNQ4ld6LklcHNGxOtclCeTEZhWP5Eav6iOK2IJAp2f77cxBPRs75n3C8PGqVl5UxRHo16Cg1JnetoLWHmj0X//sQ3+daoHuGcwpA9A1ESp93gBu/Grehx+spSRmERw1tTee7WqGXvq+0k0Mn0jgxMryopkK8+8kY6Xj9l7GCrpDYRur6r3A6U3H8T5Y1yu6YTS8tqb/yYM2PZ0XFrdfnwlX3182Mp4tynO6pDr5rwgjloKAda3v2KOcoy72rCAGQTmrqcdxVElSwIwSdvS9sGb7bgkXRF+W8AQCJWFmyx+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(366004)(346002)(136003)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(36756003)(4326008)(44832011)(5660300002)(66476007)(66556008)(41300700001)(316002)(8936002)(2906002)(8676002)(31696002)(86362001)(66946007)(31686004)(83380400001)(38100700002)(478600001)(6666004)(6512007)(53546011)(6506007)(2616005)(26005)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHc4b2FLSjVDQnhwT3E0ZnAwN2xIaVpzREFLYzRPSVp2MmhyelZxNjhyS0o0?=
 =?utf-8?B?dzNXVTRFS2I0STA2ZHUxMHFXbm03dE9YOWhvMGZITlp1WGVJbkJ6RXRFOU1P?=
 =?utf-8?B?N0gwUkFMdDE4NEpXeENmMGJVRHJKUmxnVmNyeENMMmRlZzN5QjdDSmV6Qkx5?=
 =?utf-8?B?R0pPN0d6T3VYaGFydHJ5c1plNW9wVUVIZitkNTRaVFFRakZHbEhCK3BrVElZ?=
 =?utf-8?B?NWRBOVJUQTNzVldsNENxZDFGQnYyYkU3TVQvellScE1pckdhdXRDYzdoeHcr?=
 =?utf-8?B?T1ZYRHNGZ3luZ0lBZGVXblJjTVhXNk5CamNtT0ZaV3pwdUkrV0VYM0xoMXhN?=
 =?utf-8?B?aG1velpPQVhZcGlzcGIzbHRxNUlEZHpUVndhUG5HV2lyMDhsM1M5SVNPTmp3?=
 =?utf-8?B?RzhTdTRjUk04aFVjcnVNV2Z0ckc0MFUvNzlxZDIyRHBKUmUxN3k0MTU4Rnlm?=
 =?utf-8?B?YXpaYlgwRTIzZnNqU09VSTRHVG9obFRnaUd0U3UvYmNYcE8zdTI4YitMcXdj?=
 =?utf-8?B?TWluM09vQm5BV2lTTGNzTm5VcHpGZmhqWSsyMSs5a2ZmVTJ4OGdXVWYzek5m?=
 =?utf-8?B?ZkxUWVB3UGRlc1RqQittdnQ0L3JoL05LekozWDNmTWJWVm0vaXRLbmFINkNh?=
 =?utf-8?B?UXF3YVNFUE1QVXZwT2JmQ3NNTW1OdlR3Uk1lak1VeFhxSVN1dFBkSFhjd21x?=
 =?utf-8?B?dndMMXZDQkt0NFU5cmlkUXM3N3F5c1drclVCc3RpZGR0Smk0TFZrNGVRY3Na?=
 =?utf-8?B?STNsN3J2VlZQVGxqaWorNnliSG1iQ0lMdmRSdm1FMjEyTVhGWm1oZUhMRGx6?=
 =?utf-8?B?b1ZXWTY1NG9tT29MbFR3RFlwazN4WENHNGpqaU9JRUx3eWxhTmo0bVoxdWdq?=
 =?utf-8?B?ekt0N3FUVnc5UEZqWjhYc3BlM3dOMnVPdFU5S1VONHBUOFhWYktkWU9XUytF?=
 =?utf-8?B?U25vbmY3MnczYTc0QmNTc2tZTkNqZnB1aUxHUkNLT2pHVW5OZGhKcFhwVDdn?=
 =?utf-8?B?OVc4MGw5SDVpaXRxelV0UU9zWTBqVUtwMlRONnNEY05ET1BKZ1ZhbXNLVXFo?=
 =?utf-8?B?bnZ1UWI4MWo3RXJtL0VvUFREc1VWNHZKblN1dUhyUHRvRTdBV2NFYS9GTlJS?=
 =?utf-8?B?U0pJL044enRxUGV6SWxBdU9wWmdHc2FtVUpjemJYM2l0N3FYNjFYRXlOTktk?=
 =?utf-8?B?UzlUUVFtZjRObkluOTREVTdOdERjQ2xrU3o1Y0hxZUJJUlhMRzk4QVo5QVQ2?=
 =?utf-8?B?OUZWd2IzK3k3cmlLazd0NENQWWU2WUZUWlJKZUdJc0k3TTRad0x4am9GL3Fv?=
 =?utf-8?B?VzFTdlNBUE5aN2tKL1ltN3A3dTNRd2cyTC9zUTRxemJBejVXMEhjUFUxYUhq?=
 =?utf-8?B?N280Wk1zZjZqQkU1a3dsSW13bWtFMm1vdG1odUcxbXdvbUVydit1L25TVVFu?=
 =?utf-8?B?aTBpdUJvSCttK1E2TkpMNkUzV1ZUdFcwVWJ0dUJMUFNCcHRiU0puMWgrR0Ix?=
 =?utf-8?B?ajAyRE1oSmk0KzVFRGQvMi9VdmpwaHY1NWo0U3I3dFZuaHlnUFR3dlZxNnJv?=
 =?utf-8?B?TVIvQVhIYUsxOUp4YWRhZUhTSnc1ajkzWXNaRDNJSXIwcm1aT0xVQzRqd0Jl?=
 =?utf-8?B?dGVjc2VOeFhwOTdVcDFiajNhR3g3aEx0ck00QXNVL1FOc3NoNENBTkpXb0VE?=
 =?utf-8?B?UVZHZGRIMENKakJ4ZjV3bHplcVM3MUFmUTJaU1JNemxkMmdLT0RTWkRaUDZ0?=
 =?utf-8?B?TGF5Qk5XZ3VheGpwUVRqRjFGYTNiVHRyekkvYWdCMEZ4eG9VSDF6S1d3S0VT?=
 =?utf-8?B?YnJoWDQrTWRiRXJtNTJMMFViWHdQU0JzaWF1Q0dCalVZNU90WXIxU1o4OENl?=
 =?utf-8?B?SXdkL0ZWeXpGbUFLTDhzMHM1dWNMZStLZEJ2R2RSQ0h1RERCVFFyS01qdEVU?=
 =?utf-8?B?dnFqQy94SHc1YkRVbEEwOE9uekRlQTFvbWZVZlZ3RlkxME9SWFNKRnljYmdm?=
 =?utf-8?B?Q1VpczhZUGhqcGJiYWFxY0dsRzVmMnhFNXArb0hvZWVkS21CSS9vS0pHdGJv?=
 =?utf-8?B?eThZVnhIY1dOQUt1cFE2eHo1dE9kTjE5N2tWeGtWNzFmV24rUEtqYTEvTkdG?=
 =?utf-8?Q?LE7aQzBpljyE/ngossDn8q6Ke?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b6e1d3-c418-441c-212c-08dbd08e3841
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 10:29:05.3289 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dKcE2Y+mMx2Afa7X6kABi8OBaZUaM2J9JlidObjLmWRfp84JT7Jz0qD9U5TgQGTd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9166
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



On 10/11/23 04:56, Venkatesh Yadav Abbarapu wrote:
> Unhandled error coming from xilinx_pm_request() but return
> value is not read back that's why getting sparse warning
> as below:
> warning: variable 'ret' set but not used [-Wunused-but-set-variable].
> In case of error return the "ret" value.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
> Changes in v2:
> - Fixed the commit description.
> - Removed the newline.
> ---
>   drivers/firmware/firmware-zynqmp.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
> index 43fb7fa778..8ea15c7ed3 100644
> --- a/drivers/firmware/firmware-zynqmp.c
> +++ b/drivers/firmware/firmware-zynqmp.c
> @@ -203,6 +203,8 @@ int zynqmp_pm_feature(const u32 api_id)
>   	/* Check feature check API version */
>   	ret = xilinx_pm_request(PM_FEATURE_CHECK, api_id, 0, 0, 0,
>   				ret_payload);
> +	if (ret)
> +		return ret;
>   
>   	/* Return feature check version */
>   	return ret_payload[1] & FIRMWARE_VERSION_MASK;

Applied.
M
