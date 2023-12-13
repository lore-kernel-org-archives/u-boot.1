Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D945C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 15:48:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 111EC86C67;
	Wed, 13 Dec 2023 16:48:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XplRsa0N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF13A86813; Wed, 13 Dec 2023 16:48:40 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::617])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2D5E86D2B
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 16:48:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYqW60fV4Ulacx8aTDGOm8nEd74nw0H3mer+ylXbUqAVx5Hp4Ot7KtlmZaEPNOOD/q+I3za4ffEjrID/ueNe/P0vfeki0wk+T0p6PaLxTCCgVNEVr4/XFSxjQr4Iw49Aa9gviMkXnLL16NRBTMjldxNn5rM2VmIpv8vFTxBChXEb3dA0nz4Uyjyn1+Qvt5djfuZsFCKBUe9GHXkCBsUFsuaugBQWkFx31sDZvHd499GM/jONw5bkL6ta32hbnLurfjo/D4CFeCLzI4/IWgMMiP7EnRAXbBXcc5Q2X6cn8uwWeMGS7W0TYui2icMKE5qvabIa5quXOuXaGr9Scn5ddw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+J2fBq47RGrXjcCnOFn1yJVLmc80XFgPIO8saO52Cw=;
 b=n7rJMGx7yEMLuUS1Wz7NuxwZJqEyxVPibJ6CcQc/XaZNI37kyLt53ye+t9sdAhYJPMEAwU3ttADrBEoAqbpdhwsC1vUM2pD4GC44pvEh4jJMrmDN/w2ugBJKdIyFZ1jVy+Pcv2MwlO3nJTbeHgiT89cVvbUe8uFQ+l7IKBhoImT15svyJyWSUIKVemiqgrLp80YMKHXxjTX5Hw81P4GwpHzyXs+NdJSYO3CkglMizDlsc+/lsUnp9dcGLLF1o2+h+r3xr+i43EDCGtCGUreGayDRIPcpxLfv16R9yUM8Hf2X4jsLdlynaq6RUFbYpbOKNUU7QcbS5n/PpgyE4gLFiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+J2fBq47RGrXjcCnOFn1yJVLmc80XFgPIO8saO52Cw=;
 b=XplRsa0NcwU54cXnUDn8ax4Y9EvCa0dYEWCkhpPe5cZKzHMS/fPBhDK+ofG7VNjX4S+mYbZwdWf9IdYN3/BjaCZ39EHqsjDOGq0iWHmFRphmPwshhNbIHmF5ujI1SMEEV4y36BGuqMIfqoiNRhcr1SvBWmlNB+62kqstDAOuF+o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by DM6PR12MB4450.namprd12.prod.outlook.com (2603:10b6:5:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 15:48:35 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 15:48:35 +0000
Message-ID: <adaaa42d-388c-473f-829f-ed5c31a56dfa@amd.com>
Date: Wed, 13 Dec 2023 16:48:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: zynqmp: enable topsw_lsbus clock
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: lukma@denx.de, seanga2@gmail.com, git@xilinx.com,
 Sreekanth Sunnam <sreekanth.sunnam@amd.com>
References: <20231204084515.9488-1-venkatesh.abbarapu@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231204084515.9488-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0115.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::44) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|DM6PR12MB4450:EE_
X-MS-Office365-Filtering-Correlation-Id: b5993e06-d291-4058-cd7d-08dbfbf2f728
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OPk+al5gvV2AB0Xwltr+5Mx7is4yaR5C0K/06r6oRDFhLa+SW2zbqMF6OC+/P8pkgYb6fudrTQyuZkgLfL8CjaJPKPs19IXbm1PfW1kHL5k3W5iBbDjJZtbeWNp2qoGTPsx6yKUsxdyejoHc6EFC8zJPaAG48pnA0Ebj23BoKidTbNwR8U22Cwasy1WGzjoqng3EmVRYlNDj8CeyVZSWfJtXmjfQRzXNM8TC9UE3huja3CiAJVfQRkjNvFupJrDmb56FebjV4wIyo6yXNv9DtSA8yWOpczJVMLJeYn75vGYVl0QlQdDw+eun2u412ckYOk2/Jt4M8gktj2JxogrhEdqWypwRFDWZqMxp61f+2NHvHB9/IVJt4JKXwh4CkxAcFYXjP+WLvMY8X4YWC4JVzeqCmRwxJX7Wq0b9ChLLGQOvkDVdQIO+aWxMfXtwhKx/zY1b05VuonZBbOVKAXlCyaYeYdiDr52v1jeK5Ewq+S7YnhxOQghIHmBf1FPNgxMpHTI+kr7gly3JmdbfMdgmFUyEUM7P3XEynis6h9SWcalHst39kCyLUQ5h76puX+0eLm9WFmHXHMu4AaqbSXgVvgQJhr+9ITbSi1N007lEspEcJKP5vJyGMnpBcgZiRAt8XUuz3PpApGibH4oy0iVRng==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(39860400002)(366004)(346002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6666004)(6506007)(31686004)(53546011)(36756003)(478600001)(2616005)(66946007)(66556008)(66476007)(26005)(316002)(6486002)(83380400001)(44832011)(6512007)(4326008)(8936002)(8676002)(4744005)(2906002)(38100700002)(5660300002)(41300700001)(86362001)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFU2alZBRFhqWURhajErK3NhcjRTU1BwQ0VHUmxtM1lnNjF1OTJab2VXZEZG?=
 =?utf-8?B?N0xTS0NodDcraW9tZzd5UVNJemZLMzZibjlDMFZxUGhCNVZUOGJzT3A2NUE3?=
 =?utf-8?B?UHhCZ3BUL1A4R1ZpSUswZnVrK05MTmRFTVRsMWZweVQ0OHREditzS0I4Rmc1?=
 =?utf-8?B?SmpkU3ptWE9mdkdTcUp1Q2t5NWM5c0VRYzVaZEdSVitvNkpzU0RtMDFVbmhE?=
 =?utf-8?B?L1l2MGxXNFlpNEppOWZLYlViT2JyUUs3SkhqUDYvTWxYYS9jMmtuVnNzSDVu?=
 =?utf-8?B?THZxc3VIaGwvc25iV2VkUjI0d1JYTkNNQXpDRFNYcWxQSGx1cFU0N0kzaGNZ?=
 =?utf-8?B?ZXVUa1poNFFraitmaVNpbHkvWjh3NlF5cngxY2xyZkpoZk5ZVHRsM215cUpZ?=
 =?utf-8?B?dUFpa3lpczJBaUswazFSc2VoZUlqamVNbzY3dGxJSTRzcXZPSUtMMUo1elpU?=
 =?utf-8?B?TnRJbmVJMmhEOFlPemVvaFFRTVUvbjAzM3BnZTk0Y0hyQmttU2d0UlJYY3RJ?=
 =?utf-8?B?T0gyMHZZNmdCa1hSSDYxelM5eEhzaFNNdXVrSUR2bXByRVA2YXBYeXpIei9l?=
 =?utf-8?B?ME9wZTEwSkVFcGVnbzQ1RzcvZm9SVGtiWUpHUGxGcTNVQ3JlRU80a3VPL242?=
 =?utf-8?B?US96WGV3UFRWQTdMSzk5VEtTWXlnNmFMZGpXVC92MVFTclVZVTVBb3dNVzlk?=
 =?utf-8?B?c05uSll3V0F2WnZMTXpKTDlRUDA2aUhpc2hlMHlSZkxwNmh6ekMyV0dUVzky?=
 =?utf-8?B?UnM1ZnM5OXZHOGFaVnBhWXVLSEhIK2tQeWFmOUVWUTU2OW5KMFBSNVpVOXlY?=
 =?utf-8?B?Tk0wR3ByUndzUzB5T1NuVUNLS3pGQ1BZRGJrMmw5RUp5OUltQXU1YmdHWU5Q?=
 =?utf-8?B?TWlGQWNEamlySmxheHV2Tjd3Z0hWczQ0eFBaM21Ya3ZvS0t2M09KTVA5aXdM?=
 =?utf-8?B?MDNMb0Y2aDBBSnJJbmFaYzYrcDRZOFhSUVdjUlk1Rk5SL0JKR0lGSkd1Tk9L?=
 =?utf-8?B?bWNGdXFyRmJqSkxFRVdtejhqa2t2TCthOG13YXNhVmxHc2lCVXJMZVd4c3JX?=
 =?utf-8?B?L09OMEVOelczbm5VanExSktFbE0yY3d1Q1NUQmdIMWhsdGloL2I1d3F5dU10?=
 =?utf-8?B?S0cxUW5aSER4eE5xOXFKRFBucHhHeW03QlVTRzhJRlVqSWR0Q0FONWFCR1Vq?=
 =?utf-8?B?V0J5WFkwZzVBSkE1bVBsS0lrSDNyL2daMWsrSkR4KzdSYjZwdi8xam82cjRQ?=
 =?utf-8?B?VzhranNWQWlSVmtLQlNNbFk5Ui85V2xnTUlmL3F0S09CQWlCNXZDUS91WlJr?=
 =?utf-8?B?aUs2c2prV0FZSlQ0RlR3NytjMENrUlpsUG0wVFJKVjFOWmNjZEVBZWducHBC?=
 =?utf-8?B?ejVYbUhEZ1E5NUF5Wjl2RG5nMWVXUjViZ08vd1o0L2d4Z0RPRUNBU2VDSE41?=
 =?utf-8?B?anVSZXRWcFZLTEpRb2M0d1QrQVpTY3NkL2FmNi8wT3BhN0E5cVhlNFN1TklS?=
 =?utf-8?B?SEFrVXd3Vy9jT3k0NlJ4Ty9WWTJmd2RLSkdPdi93bUpPRWFVMTZYbmpRTGxO?=
 =?utf-8?B?SVU2QmxwTi9UTUwzbTVLaGRPVFRza3RkWGhSYVJiWTZrTWplQ3NuWlppQ202?=
 =?utf-8?B?MlBJK1RUaE5Uc2syQVJQeUVkSVFPNnBuWlU5SVBkQytxWVVRU0tBbTZ4SWF3?=
 =?utf-8?B?ejhwOGpDN1RZVTFnTGVFUE41NWZkanR1QXNUN3hjUnY0c3lSbXh2VVhPUFIz?=
 =?utf-8?B?eHVRQ2h3VzlhekhBbUx0QUh5OGwyeERZcjVFb0ljR05lNVhydTk5V1ZUM1Nv?=
 =?utf-8?B?NEh4b1lVQ0htSFIwZC9xNHkzNzR4T09CdUZiSTJIYi9ZeFNFQVZuVitxbFlT?=
 =?utf-8?B?L1ZjdnUzZU5Zd1lQZVJDUEJKSWhYbXgrMncrT0dxT0IvOVdvWldjT25LelNn?=
 =?utf-8?B?bEtOY0RIdGRIZ05va1FaNkxmdzhHRGpZNjNtSkVlUFNlUDhTL2FQTVVtVkxB?=
 =?utf-8?B?c3QxdjZzNG5DOHlQcDliS0hpQlFaNno4QjdORDhrT3YwZ3FjbHFSYWNlTjRB?=
 =?utf-8?B?SkNjQ3dJTUhFWGFuR2taUWsrZ3NJckNBU2MzaVNWUW5yQk9oSjl0WDJFeHI3?=
 =?utf-8?Q?SUpASzIBxmNJrozX/9GcmlFNw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5993e06-d291-4058-cd7d-08dbfbf2f728
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 15:48:35.2902 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B4qm40WlaX1B9rsBEOkOyOT5r838Aw6F/Ga18XWvpDocCaTGRka0bSbHdkcsj3OP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4450
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



On 12/4/23 09:45, Venkatesh Yadav Abbarapu wrote:
> Display port is using topsw_lsbus clock, it is failing
> while enabling the clock, so enable the topsw_lsbus clock.
> 
> Signed-off-by: Sreekanth Sunnam <sreekanth.sunnam@amd.com>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
> Changes in v2:
> - Fixed the name to Sreekanth Sunnam.
> ---
>   drivers/clk/clk_zynqmp.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/clk_zynqmp.c b/drivers/clk/clk_zynqmp.c
> index 1cfe0e25b1..c059b9e8e6 100644
> --- a/drivers/clk/clk_zynqmp.c
> +++ b/drivers/clk/clk_zynqmp.c
> @@ -844,6 +844,7 @@ static int zynqmp_clk_enable(struct clk *clk)
>   		break;
>   	case qspi_ref ... can1_ref:
>   	case lpd_lsbus:
> +	case topsw_lsbus:
>   		clkact_shift = 24;
>   		mask = 0x1;
>   		break;

Applied.
M
