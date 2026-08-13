Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D772C5CFEB
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 06:28:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 43B6F60A88;
	Thu, 13 Aug 2026 06:28:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nLopq99uz9Yi; Thu, 13 Aug 2026 06:28:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 69972608D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786602512;
	bh=iPSco63P9NcLOrxDN170CP6+dl3VlvVleuLWgPRlaMw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PvC45NdA1dvbU9XR5OpD3dsSugvKL5f4ugsSxI/5bFx9zHKscZJLATIVuSUH5IwiD
	 p/B1aWwahm8S70qYrsDieST9UjfD2GXrwUNIMVFW1Vb93//uX7o9UBGsagUtrGgZ00
	 dT/O5/pqvqhvxydH0n9BBl2EX4Ng9wthXXK+av9PDvfQGLgx1eFaEfZZkrd9ZpM8Xu
	 qjUjMsSxM3+lrHKPHjpShv7VsVsUDURImvi9QLA86ANNsucXvu9B87jHUexZJ/DF51
	 L0Mf1Ce5Ak3xFX2q4FUhGkh0ClngztUti8UnUlelbjLCyC0+CDxoFLmZ/O4E9P7pKa
	 sW0yp1GWQVRTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 69972608D6;
	Thu, 13 Aug 2026 06:28:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E13433A4
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 06:28:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CA40681184
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 06:28:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MJSD7rBqd6Iu for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 06:28:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::1;
 helo=ph8pr06cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 57E0581183
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 57E0581183
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 57E0581183
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 06:28:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNcDULhteZMFdyx2ZVrKxhGXtia8ciFo63Rxn115Cgg8lS2DeXwaLOX+QHPEC96G2MNkwUxkUjRsnsuJZWIa7VvXWoSYuAmxVg+7RiMJQadEijSfAO27FocAR+oGK160cKq195oJjA8zvElE1lrSzc1QEmNw7UIYcr6zJueV1wQVfn2ViJaixzh0v4Fxc69iZEwg97/oZVGMtuZhQXc0z4L5Uldjjd/SHPbFp5hr2wRbSeSVSoDb9yj4R9tsAGH2ivN49ReBTquY5jj0yN7ulgjvp//x1RJoQjfj4bN4WOyH4G0MANCtd8gSuC/qx46hNVfJXSVA/K0q7FSDTcZZjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPSco63P9NcLOrxDN170CP6+dl3VlvVleuLWgPRlaMw=;
 b=nMjkaXX1qmIMnCYlgUQ9nlpN/KYOEPUSPpTQbCdD23u2UVm8HHaeDYlD+efYBYHa5RRut021E4K0XceUiCNGtOe0/z5kSHMJMk8pDjyDlXzGQN9g9mCuyA7htov+HER+HvkwctGYTKk/N/MpXJWnUVCL8/NfoTS1Bz9COy1mpvM29D+UPC6kraQC0qdCP/eCgqvIimfixdFnu6ouSvKUH/JQlmS+dqkUI8crDW94IbdGsh0zH1vh2GM3oOlg8ByS37uwbwI7f7HLpJ+nXUH3Kz31TawBJdMb4DkILuGYFI4yP3agkjmgPMLUDj/H0rtEeJoZWbC41z1pX/TRei0SYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DS2PR12MB9613.namprd12.prod.outlook.com (2603:10b6:8:276::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 06:28:24 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 06:28:24 +0000
Message-ID: <fa208cf9-1af3-406b-a1f4-37b401bef8fd@amd.com>
Date: Thu, 13 Aug 2026 08:28:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add missing fragment for Versal Gen 2
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.u-boot-project.org,
 git@amd.com, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
References: <11956eca5ebd0b3626b7e2d0fa52331cbd3dc1ec.1786361819.git.michal.simek@amd.com>
 <f29ac2fa-4d73-410f-ace5-819c2a459cb5@amd.com>
 <f71ebcbb-6cdc-4c07-8d1e-0f39ccbfa141@mailbox.org>
 <5ef6b6eb-5f90-47cc-8c87-872c01eaf3bd@amd.com>
 <b3e35156-e1ec-4be4-9693-df16eb82016d@mailbox.org>
 <d0bd0863-e094-4b82-9635-6798960a08d0@amd.com>
 <6bb58612-6b26-40e6-92f3-fcafae0739ad@mailbox.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <6bb58612-6b26-40e6-92f3-fcafae0739ad@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR20CA0014.namprd20.prod.outlook.com
 (2603:10b6:610:58::24) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DS2PR12MB9613:EE_
X-MS-Office365-Filtering-Correlation-Id: 188fa7c9-e5cf-4e48-1703-08def90413cf
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1kB4Pqv8NLwhey4Ke7+zPQfi4uS0On2Z3gdRDDXr3tfD4xI6y4UsX3XCuHKSfwIFajABWKVZ1IN8RH1NJMEgtvMjG0s2RrdlO5MP4WUg0Ww6CYUW9MDbYdFE1rqUVMSyJ02IGBZFT9/9Jv9NlYeFENvuVaZzxCy9kJrGGOI1+94XESM3gbfzfcv/t+betYidl9UqxgUvrjiZGv4icj2WHYbNEI0lcY6m5NTiriVQ9xD7qZ6IgN6PEauSgl5FNFF7/ESdrOUr/RWmudAGNdVFjBGNF9c9zs1nUuJIN9yXMzocWStTtjgVcCAMBWuxQCI2F2MIeiVuPQ93DIti3wHa6ogptTUtwKRvabYbYTPY0dl0C2OaCbbA1zqzxhYII9rP3cFhcgm3EevXKhekPCDdMsGpzuBqpx00Sy8TGlmSDD4v0OX125f5UURUZ8g/GtglgMX61AbrUWJ1wxX37DBBHfzRzjhtMn03F01E69Qq2s+GG37AaCZe49D/jYwx2Dr4BdBRwUUGOOBMEs3/X9hicLuKzfj4RhuJga70c+I8KNXvArh3UBv7bMWwrHZn0mM8A2EbuRLA/yFSyRuWECiw5zzQxSqcKWDGVqsf+gI2by1FHVO8aHGSaFhlnIUsj/hpdwYYymomEeKynLTY0qNCVOhmvJktzbSSXZeVdY89998=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXoyVFFQdXFmQzJXbHY2b2VvWWtJYjdIcDRLQVhqdW5BZkg0S0ZlbnBhcGdh?=
 =?utf-8?B?QmZjUGZtTFNoN3RWREFGVTREQm12MzBSMkNFWUFkR1UvR3VWNW5WTkx3TmdZ?=
 =?utf-8?B?TWJjVlpPd21MQi83amVBMXY4NjI4a0hmSFhLcW1rNjVqbmU1bjVxeWUxTjBN?=
 =?utf-8?B?U3lVaDNsalhkclFtYjdKK0I1NjFuYlp5UzVzRzR3TUFURFBqL21nMzh1YkxE?=
 =?utf-8?B?NUZIVDVmNVhLYjcwQkM4NU5iSFZ6SlAzV3NNbnM1UEJ3UVhGUldkeE5uOWJR?=
 =?utf-8?B?RkJ4enZmRERBOTJEU1VOMzRhVE9wQkl6M0FWMGU4OUIwM1ZrNURyOFY5QkhW?=
 =?utf-8?B?YStsc2JDNGFsT3RYQzdwdGM5VU44alF1ODB5RUdFWFdGOTE1WUZMdGRXMHEw?=
 =?utf-8?B?aEdYN3NaNWwxVUJVbTFSTEVCOGhkL203UGpRT1RqeWN6ZkFrRjRWTldIYk16?=
 =?utf-8?B?WVJkMDJXT1lBOG95Yy9zRDFZMlF5MUNhQWsxTjc3aHV1NjBqbFlXTExJL0Va?=
 =?utf-8?B?WWhBeG1LWUZzeFZZa0pCbWVQUkNTaDQ5QVU1bEhyMVBCdEU4cytwWXJRZ3lJ?=
 =?utf-8?B?dW9GaTlTZXg0Q1A3RTZuK2t3d0hNdDJUZDd0RmowVmFEZ3Y2K3F5OUhrQzd2?=
 =?utf-8?B?dmFlTDlLeHYwWDBUUkc5UTNLTlFmV2VwMUtKUUxDV01SUDFLMTltb1JXSEpa?=
 =?utf-8?B?WlV6VitNMUtjbjJUaTZxWms2a09UOEg1NUJuUzdLWU5NaXZ6ZW5nUjBLdG84?=
 =?utf-8?B?TVM1ZzM0elV0SWh5TkppdHl1OUdLZnlMVXloR1p6REx1elRhZnM2L0RvMDhn?=
 =?utf-8?B?U3NibXQ3WVRFWDBkWk5kN2QyTVM1ZmpCMWNXZGQvcWZWV09YUmxxWGZKL2lP?=
 =?utf-8?B?a29SVFhQQkdtdjZmaE1hbEtRSi9vVlYyeXAvUlRza2FROFNoS2FFSElCMHBv?=
 =?utf-8?B?QnM2RXhPQ1BoZkhTYyswTmdDNktLanJzNkJpaTcwbVQ1ZDRMM1RpYjl6M25o?=
 =?utf-8?B?NUpLdUIzWi9NTEgrMnJuQk1FeHJkZFlRMjIrMC9tMGhEM3IxR1ozNE9mb0pl?=
 =?utf-8?B?dEFqRU5mUXc5bmlqaGkwNG4rcXFsbkhrYkNNRG96b3lWM2h0bWhHc0hUSkxC?=
 =?utf-8?B?WVhyN200bTVvWEkzMnYxaEMvNjA4RzcycXZJMkpCL2wvY2xUMTV2L21HVDla?=
 =?utf-8?B?K1RtaE93MXcrbVBFSWFteFRidFdsbVB4UGNUUmFhMy9YKzM1QzFWRnhEb0lv?=
 =?utf-8?B?RDR1d3dZNTVialVRSEI1aVorN2Yydnc5Sm0vZW5zdC9yQUNCaFp1OFJQYmc0?=
 =?utf-8?B?WUF1Q2RVeWxBWWJWZHhyLzRFNlFWT2NFR2JBa0pLZmI1M1VHZHhKQzY3RHZK?=
 =?utf-8?B?aTFQYjQ5R2xraitLemVwNVJ6Q3NZOWEzRzc5Z2R3M0xIUm9iZk5wclp2Sitm?=
 =?utf-8?B?eHM2TEdFbmNSTk05UlNNSnRiTXQyYWFjVXVzSVhDWmZLMjYzSUU3WGMrMFJM?=
 =?utf-8?B?SG90Ym9SamtabnN5djZBRkR0dTBPbWVoeTRkNlMxU0RndFFibi9tVDBRVWIz?=
 =?utf-8?B?UUV3U3VkUW1HbzFvRVQ2SEx1Um9GNmxIZzA2azRiaWJBblpxVCt4dTdiUTFM?=
 =?utf-8?B?aFRIRHJIZkg1YllUYi83bG5ic01DM2RHRkJQQ3JtUGl2QnZjSXJPQlZRREI4?=
 =?utf-8?B?TlF1TmdrNlVTbVp5UjBKR3UwVHdSdFhjOUJDQ0ZXbUlWeXdtbUJiLzRoL2cr?=
 =?utf-8?B?cXkxbHRBVzNmeVZ2YWhxQmFrOWlzTGFUdTJwd0M3S25ORm40N2dtZlpoMDlX?=
 =?utf-8?B?SnRrSVM0ajQrbGZUS0FqYXJNVFZ5dm01TjRwa2ZUc2sxOFBBK1JXZ3dEZS9p?=
 =?utf-8?B?eEhBTkgxaS9PK2wwdkVOWGFOdjNmTk5DcUhMTnQ4QnlHNGxKQmRVY3M0VUZh?=
 =?utf-8?B?WGpaa2plcCtyUlIySnF6bmFNZnVZcVRKM05tQUtNQnBRNTBvTWgvZFFha1NI?=
 =?utf-8?B?VHEyV3hXUGpRZGdpY1IxRHhpcVF1bmIwQ1RwSXF0VXJaNnJYVFVtWkt2cGNu?=
 =?utf-8?B?ODBXOXRzYVpRYk5vYmwzendKUGtTeXowT2VsN0tNWGx4MDBrc0xXUStJQytO?=
 =?utf-8?B?dXpLcjZqNDU3Yi9KWHhTSmppU1EwbnRmUnFLTXhYdzRPQjlBYnp3eGZWNHNk?=
 =?utf-8?B?MVhGNHcvMnQ3ai9wcGdmSHJRaGxiamh6aGhpODF4U3FOblJ0Yk9WcHV0SjRs?=
 =?utf-8?B?TGIzUHEyMm5TWVJ4aWpqQ3BYZ1poTlZZQnFKM1psK0NTT1BKNDM0K1B4TUo5?=
 =?utf-8?B?MzUvNDFtTG1nTDNNS1IyOU55ZmxsNVZYOEh0MWNqYzBQbkE1OVI5UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 188fa7c9-e5cf-4e48-1703-08def90413cf
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 06:28:24.1771 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMOKamaOtl9dh9dWjt6tDIU1KuU7BFigUBNZIFt2VnGMmPbZR/C5fhkzaFDENUry
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9613
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPSco63P9NcLOrxDN170CP6+dl3VlvVleuLWgPRlaMw=;
 b=mLNkQrHVhMoYJdhqmud4+/m9vZgBh0CeEpldncdYLEXr92WUzDJSybWTHiaXPLc08ySQyePoKoDuIMySnKz59MgByfzfNMxjANbnl+1DNZ+b/jS5+fQR1UpIA5PY+FfXU3lBrve74hnjk8N5GjHRHFzvATSFKzN4m02VmKd/7uo=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=mLNkQrHV
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



On 8/12/26 19:51, Marek Vasut wrote:
> On 8/12/26 3:33 PM, Michal Simek wrote:
> 
>>>> Before
>>>> $ ./scripts/get_maintainer.pl -f arch/arm/mach-versal2/
>>>> Tom Rini <trini@konsulko.com> (maintainer:ARM)
>>>> Ilias Apalodimas <ilias.apalodimas@linaro.org> (maintainer:ARM)
>>>> Michal Simek <michal.simek@amd.com> (maintainer:ARM 
>>>> VERSAL,commit_signer:14/15=93%,authored:10/15=67%)
>>> There ^ you are , what's the problem ?
>>
>> Yes, I'm listed - but under ARM VERSAL, which is a different SoC family.
>> Versal Gen 2 is a completely different chip with different features.
>> It only matches the ARM VERSAL entry because of the "versal" substring in
>> the N: regex, not because they're the same chips. (FWIW keeping "Versal"
>> in every new SoC name is very confusing).
>>
>> Also Gen 2 specific drivers/files are coming, and those should be attributed 
>> to the Versal Gen 2 not to the Versal.
>> Creating the section now is what makes that correct - otherwise every new 
>> Versal2 file silently inherits the Versal.
> 
> Why do we need 4 or 5 MAINTAINERS entries for Xilinx platforms, with the same 
> maintainer, same git tree, same status, in the first place ? Why not have one 
> XILINX entry that covers it all ?

No issue. Let me prepare a patch for it.

Thanks,
Michal
