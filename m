Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C2DC5CFEE
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 11:28:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C1E7811BB;
	Wed, 12 Aug 2026 11:28:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wJH5lqlSJOkm; Wed, 12 Aug 2026 11:28:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 06BF3811A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786534124;
	bh=UHZwUjmqbqpXKOqEgXhx4h2IA9691TpxyBlv2pFOXoU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GINs+RpA17q+BuW2juZIDAZd4iLNXaYCjqYHYrMOJb2TC9FcyiqbszpSpVkiYtCbE
	 anypJw+4q2lgOarKAr3ohwJ1ojfhZ8Pn0gSxRcdUgFP1xFoTiPBv7OcBVduBgtDS4x
	 hzm98smQmbJYaReT7GBcrgfLcsj0jDGSlZ54wgGZMH6I5/I36uIXc6kLTnCS2ZtxBt
	 hj0hg2FsTSiOl2Zf5mXLcbYUUZoo/jeU+02cYArc4H+s3AVL/5XeEL+9pvYbjQRCHu
	 XbrX2hAHn1D42mSaz17Xi1FLPSwmNLi6Ge6ft+xXMxmNSuDjG/o69mye4ZUHxo69Zv
	 OcbqF01ybEV/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 06BF3811A0;
	Wed, 12 Aug 2026 11:28:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 340E81F41
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 11:28:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 19B2940853
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 11:28:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VbDEspHxkVSO for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 11:28:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c110::1;
 helo=bn1pr04cu002.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9C94040855
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9C94040855
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9C94040855
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 11:28:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MSeogYsx0ziKgTEKC3Gh3THf5coDLxHXQTSmVV4c9xmjCIv8+f15742yI/LJM+Tjhrri2TUGPZAjOtJmz02dGJ7WF5lLL5nHp0Ezyf18/5uQ1DKX0+KndoYgmdIt8+yaKxrzwkXnGp0iVeFgibhcl5kA6phe7RwEpwMFMDrdiF66qqQ8aMCvPvv50cP932BTM1soRonTnsjB4Ox+V2DQOnK0yFPrX6BQ8cXCWHab+ZM++E9fEz2pgHN7TE+7HDvrSHvG9Un4vgb2kYyv08xyWBGOHx99eHuUfY2Cc8TCNrn6p2mSq8wfbalZUCg64tPwT2buyiOQnV/boDkNmboVkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHZwUjmqbqpXKOqEgXhx4h2IA9691TpxyBlv2pFOXoU=;
 b=RS2qVss1Qe8865NZyceskQah8Db/bCfoxsP0PmlNUurn4s/JBWHZ73gs/zX3BWysY9tiVsMiHM6klM4iCc4wpDEidm1cKw9UeVvPDZQiV6l6UfEfFlXQM6x4ZZRj4yUEO+9U7IdRcHn7LHOlQyak9+K1v/HkFPyWOjyFnvs8IDLjcSRMYL6NHhVuEmDrBnC3VUxUAI4QnZQNR74hu4AsBtaju8kkwkVK69KWkHdXF6HvynOGe7HrA2/2tibtD9DF8CZcH474A14qkRIuySkkB/FcOFZ9bLQ6jlk/9p5GnJPcNvONYpdwIItu2KHXtITrIciDzmW5Bj0xWJMZkmshyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from IA4PR12MB9788.namprd12.prod.outlook.com (2603:10b6:208:5d5::11)
 by CH3PR12MB9281.namprd12.prod.outlook.com (2603:10b6:610:1c8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 11:28:31 +0000
Received: from IA4PR12MB9788.namprd12.prod.outlook.com
 ([fe80::aac5:ae06:3bf1:36db]) by IA4PR12MB9788.namprd12.prod.outlook.com
 ([fe80::aac5:ae06:3bf1:36db%5]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 11:28:31 +0000
Message-ID: <5ef6b6eb-5f90-47cc-8c87-872c01eaf3bd@amd.com>
Date: Wed, 12 Aug 2026 13:28:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add missing fragment for Versal Gen 2
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.u-boot-project.org,
 git@amd.com, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
References: <11956eca5ebd0b3626b7e2d0fa52331cbd3dc1ec.1786361819.git.michal.simek@amd.com>
 <f29ac2fa-4d73-410f-ace5-819c2a459cb5@amd.com>
 <f71ebcbb-6cdc-4c07-8d1e-0f39ccbfa141@mailbox.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <f71ebcbb-6cdc-4c07-8d1e-0f39ccbfa141@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::20) To IA4PR12MB9788.namprd12.prod.outlook.com
 (2603:10b6:208:5d5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR12MB9788:EE_|CH3PR12MB9281:EE_
X-MS-Office365-Filtering-Correlation-Id: 157070cb-48ca-4a70-38b7-08def864d64e
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|22082099003|18002099003|11063799006|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: cEi7tpiYunwJR7blOnOK3oTq6eFsy6dJQM0oOF62eIMGTXvqh7qFyaPNRQRz5oIgJwzwbhAl/CzlxByIzw1wijaXk0D87eUSx+sfy54NFjHnIAz9bWPwNeTzBT0m0ZEoHx1B4YMRT6HZMeCpOfyaq9cLIi2T6j9XXZCRWfG0stke8/xZlCipNB2IQSxCHVyVPQQ7cLxE2mM0VeK5OWK+LhGXF1aQCAzr5oLlpGRUAAHjyaumDgbF/ya9vUd0xcU6Q9uWJpjMMVTaqFJxvJU4YiA7Sjzgjs8S5ow+eaOdgnkKgsw+Hhc1XfbEJw2+OxSrQfN0jjucaQxbHxBt6x/KRO/4DokAC8elxRXwu/maaxC3wlYymtddAJX2XVSLn7OboQa5JKD+hqY8qC1pzP/iICBuTpVkPrr3Lcgw6kqSSpORTkd+/rQpruFEGysQirEM0yFJtYvgghUkTjitKVPundSShST7iieCSAlQqbzax3OOONJJthGnGWwlxmGjibftwJwtzYV4F+Ve9Yc8EThavx9Ew4b338CAgnnbDT0EpbC9HKPjKxe6vQEHMPMAa9EU4UpwMzb2ww+w3C2LjufqjAPtZRlB8fzA3D/KK1xIuKnhnYa37vpqVLB1X2ZjEra6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR12MB9788.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGxQdjhjQ1ZGS3hBUGZ1cWwvWUIwMkM4b0x5VFNxaHo1aGZWeHhRS3pMdzc3?=
 =?utf-8?B?Q0w0R3pWeURaU0Y3SW5XM1krTDRvTExHNCt5cXFRbm5pNFBNNzNibEs3cnpT?=
 =?utf-8?B?VHg5UmQ0WDhoQlZldUhTNCtJbkVsdXlaUU1QaVptaUVibW1SNHhWMngvZFVE?=
 =?utf-8?B?ZGRhWFIvWU1SK0c4VmRtZy81Q3lFS0s0MFp1SkVDMCtaNkZNeGVIaklaUEJE?=
 =?utf-8?B?ZWg2RG9jaUlybGtkZEFiQUkveGJac0lXc0syMmlEcmVLc09XZFJnZHpMdVN3?=
 =?utf-8?B?VUI2U3BmOXUxVnF6VmJZT2xQVlRHS3hLTEJnTy9iaEMxVVhOcTAwM2dYZVZr?=
 =?utf-8?B?d1oxUnJCSUR3WTkvejdnVmZXYm9IRVl2ek9iRHRVYkdPc0ozREd1ZS9VR1k4?=
 =?utf-8?B?ZDdlTUpxditsb1dFSUp3eSt5Q3VvbzBLS0FzaitFZURURGpCT2t0ZURBVU9F?=
 =?utf-8?B?cXY0aWY1N2R6VXNWbk5FRGZyVXpqK3c4SkNFMzA2MDlhb3owbE9GOFFyKy9I?=
 =?utf-8?B?Z1JveWFkQ1NVblVqSnFHTWtQZHlzMVdWUVBPQkN2cEEwVjhhV1I3UWFRd3RO?=
 =?utf-8?B?L0pFSWdvNlJqRUt1UndtcW0xU1djK1N4SlV5VWxRbDVocTNvQlBzVmVkd1Fp?=
 =?utf-8?B?Wm41QzJ1bU5jV2N6ZW5MdTU4Q0FhQUp5eCtBbUxwRk5WMnYzU3NkUnJFNFdj?=
 =?utf-8?B?cTR5SmhMaWI4MmZORE1abjVWbEowM0RFaFErbTM2cTFmSWtTVWZaaEViTDIx?=
 =?utf-8?B?NlphR2tlRnNIVTBMR0ovSldTSU5UZ3gwdElYaXVZSVc4VkQ3bnRBZDVMdjAy?=
 =?utf-8?B?NlJsa0dTNFdJMm9CRVNVMmRTRnBZbXN4SGJKS1orSU1FRGk5RjZpcGhGa2hw?=
 =?utf-8?B?cy9Ha1AvblMwV212Rk01eVZ1YzZRSTh3enl4VEEvdElmSDVxRVpwZ0J4ZkU4?=
 =?utf-8?B?NTU3d3Bua0FKL2lSWEVGbFFEeE1UQisrN21iZ3IyR2ViaXF3T1lEM1U1MFlC?=
 =?utf-8?B?b3EzUk1rSEFBSkJROGdid2ZGY0lteDIxKzhJbnlMRGhzL29TZUxTSDRzSjEv?=
 =?utf-8?B?ZTdvS2dZNTFkL3lmbklXOTd4cXYwSytEUDNoSVRUQ2xVZFl1QXN1bzJDMWpp?=
 =?utf-8?B?MC9uSURZL2Z5elIwWVdBTEUycHpKYzQ4YzFUQnpMMWdlemFKeGI5eVFFcnlz?=
 =?utf-8?B?TmtZTDFaMjk2Vjk0Y2E0VHBIMUFXMk5HdVpMdGsvelBuZFBhV29JNm9HVVQ1?=
 =?utf-8?B?bkdDYk9yYlptOWZJRWUyQU9mc2QyQVpXTXdINndHa3JnOHlGVys4U2hGdjRN?=
 =?utf-8?B?WkJNYmI1Tk5XZ2hHZURFK1YrZS92UE16WXhaSVhBaHc4a2R3RngrYk11R0g0?=
 =?utf-8?B?NHZ4V2c1Mkh3SkQyS0c3aEdQMXlkaUx3L004ZEsvL05DQ1A0Nmd2TTRkcHBC?=
 =?utf-8?B?VlZJQVZYam1namlUS2oySlBnaCtMRjQwamJ2OVZIUHAvbEk0dXIxWVVqMFYz?=
 =?utf-8?B?MVFpZFNiSDMzUHYybHM3eXlGVTBDY2xSTU9PMmdHTy9lZ2FzUjhxTzZML0Fv?=
 =?utf-8?B?Ni9QbE1HRFQ2VVFZVWp6ME8wbjdvTEhLZythc0h6cjlJUFZ5dE9yTE5xbVRm?=
 =?utf-8?B?cm8wak11VW8zaHJnSjJnTGRZbFIrUktDY2dSYWNUQkJ6UnZ2V092aER0TWNC?=
 =?utf-8?B?Z25QNE9zYTlNMWpnVGNzTXlKbzUzejhxdnFraVN2OVlkem1xcE1iOHMzZXBi?=
 =?utf-8?B?NTBuYXdKNExVSnUwMkZXRmExZ2xVRVV5NDZaRldHdGF0YUcrQmd2bkZ4NUJu?=
 =?utf-8?B?UFp6T3hpRWd6blU4MkZvTUlpK1lmWmF4dk8xNzhiVncwRTNIbGlqeFh1cURx?=
 =?utf-8?B?QkJzalNEc2ZwMW01aHplZ2pRWGNaNzBDY1AwcEx6TU43WTVYbDlsb3dsQlZ1?=
 =?utf-8?B?cEpOVlE2d1pDWTRLVHZOTjZXN2VkTDZrVTNlZGlHTHA1WWpEYjBZeGEvblMw?=
 =?utf-8?B?SW11UVRzZUM3bTcwTFJreFBmczBUTHZ4VGorRlVDdkFyVjdhSnI1dDlTRGQ4?=
 =?utf-8?B?YkZBeDlhanpqRTlGdWJ4S3BZL3A3ams2S3VGS1ZmZjJoZG1uc3hpK2pVUXph?=
 =?utf-8?B?V2FxdlVlaFk5NDBjZVZzMVJycXc3Qks0SitIaHBpSHZVVU1ZNHNqRFp6ZlVB?=
 =?utf-8?B?ejJ4aHQxWElVYVIva00wanFXUzZRNFJoZWEwaXUvOTBpR05Yakc0czlZQ3Fy?=
 =?utf-8?B?eWh6dk5xY1JzZmRNK2xqVlQ2ZkZ4M05sRWl0WEIwZCtOSjZFQ0tPWWpqa3BD?=
 =?utf-8?B?QTgvcnJnNUJ3dHJMOWZPU05UWldyeUlIMU5oRlpnS3VRUnVqc1FUZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 157070cb-48ca-4a70-38b7-08def864d64e
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB9788.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 11:28:31.0403 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ByM6T1tqJVL+936Hc+2fhktWZleU68jzwO4P1HeejE1QjFXgH40hUF1oPs4lb+Cb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9281
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHZwUjmqbqpXKOqEgXhx4h2IA9691TpxyBlv2pFOXoU=;
 b=MXAjvIbkkDmf14X73jheF1UeQMQ5Rj9reV0zMeqJK/2AzDHccuxXlwNUZAf8SRXOGlzC4FtAze3/X4PeyTrZ43URPXQxq990oTBSmtdVleJ7cCwnkutFcUe4oiF3/VGg20Sgy5M5DJk2VikZYPpvp5sLKgKYcHBhcOfOIRwCpXo=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=MXAjvIbk
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>



On 8/12/26 11:11, Marek Vasut wrote:
> On 8/12/26 8:35 AM, Michal Simek wrote:
>>
>>
>> On 8/10/26 13:37, Michal Simek wrote:
>>> Versal Gen 2 and especially march-versal2 is not covered by own fragment
>>> that's why add it.
>>>
>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>> ---
>>>
>>>   MAINTAINERS | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index e1379a6a3e7e..eb48eea55c5a 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -821,6 +821,12 @@ F:    drivers/spi/cadence_ospi_versal.c
>>>   F:    drivers/watchdog/xilinx_wwdt.c
>>>   N:    (?<!uni)versal
>>> +ARM VERSAL GEN 2
>>> +M:    Michal Simek <michal.simek@amd.com>
>>> +S:    Maintained
>>> +T:    git https://git.u-boot-project.org/u-boot/custodians/u-boot- 
>>> microblaze.git
>>> +F:    arch/arm/mach-versal2/
> Use "N: versal" instead for the globbing match .
> 
> In fact, "N:    (?<!uni)versal" above does not work ?

nope

Before
$ ./scripts/get_maintainer.pl -f arch/arm/mach-versal2/
Tom Rini <trini@konsulko.com> (maintainer:ARM)
Ilias Apalodimas <ilias.apalodimas@linaro.org> (maintainer:ARM)
Michal Simek <michal.simek@amd.com> (maintainer:ARM 
VERSAL,commit_signer:14/15=93%,authored:10/15=67%)
u-boot@lists.u-boot-project.org (open list)

After:
$ ./scripts/get_maintainer.pl -f arch/arm/mach-versal2/
Michal Simek <michal.simek@amd.com> (maintainer:ARM VERSAL GEN 
2,commit_signer:14/15=93%,authored:10/15=67%)
Tom Rini <trini@konsulko.com> (maintainer:ARM)
Ilias Apalodimas <ilias.apalodimas@linaro.org> (maintainer:ARM)
u-boot@lists.u-boot-project.org (open list)

Thanks,
Michal
