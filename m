Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89C5C282C1
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 15:41:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35CC8809D4;
	Fri, 28 Feb 2025 16:41:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eGUK5jFi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5560F80FF2; Fri, 28 Feb 2025 16:41:57 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::611])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA23B807D7
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 16:41:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQsiI5RX7pr17tzdqteYWkpbk+Y+W4/whwKpqH+ofjMPD2IBXyB8D2yGV70d1Y13W9TMg7ij7Tzgrs6JCUGL2kWCaFCi7QaJQUySZuyWWx5zyCu5oxk5Ffxf0e/mi7njwMSCCMb/mbFh/L7prIbGlHmudFNUgzQNxknk9fXLa+J0NhdgwjA8xSwndLEQRvkMc1cix2MOHkjMZR9eNOTKjGwTHIXq/SBBSNUHDH/PuMatNPn5C/XZdML2wqD48WvvpnCiJZ16PZ8LfVln1sxh26zNGB26rONX6jT4+US/eTi3FzkD+sILW1+ItYXUYazAlkTt7ULxSeFGk9MlDSIhOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKhcmi9fcIAqyiF1+pE5dWqE47wStiUmHhWiNsAwTFY=;
 b=b/HrLtf/VcFB3+aYM3V0YwGxWwTzlIuaCRJG5mmYrjSW5yTYv+Dvqt7JahpUZKOS4h7PYi1pT4xLpob2ENLcVchCY2vRm58gTixpTkWY0vpJrL3sTWt6z0k+9bR9EA8/9IuvV6Mja2FpoJd2tKrHwhDoaS5gbC0PmS2sdyaP7tbDWaUha4j0lxqUIzL0MSREDM89dhAQNJIYquR3cOc9H657ztXSHcZoVwsRP/IkP6ZCxgCYmVvtmd7WZ93iqj0oJHXsz0LMiIodW2P+Cu27U/P7Cf5mY8UJZKRUSV1I/M5svWRu2ipDzlkVZmkjIdq0m1bNt+JLlTFzOBtpbh6gcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKhcmi9fcIAqyiF1+pE5dWqE47wStiUmHhWiNsAwTFY=;
 b=eGUK5jFiXNwJbuOH/u9+I9zrtdJerjuVBgWNGx32CkgzlJnVHBXEPzaQOwqTHRlQCWsy5wjkRtmT6cq5EMHWG2/B0R0rFuuPoaFgbFGAtvhQEpcJJffMl1osNBx4MSu8LXA4FxtfKfcBBYPZLPuva65PM0X3tiu6dTb+mit6Egk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by SA1PR12MB6846.namprd12.prod.outlook.com (2603:10b6:806:25d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.24; Fri, 28 Feb
 2025 15:41:51 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.8466.016; Fri, 28 Feb 2025
 15:41:50 +0000
Message-ID: <1a85dacb-9e84-43f3-a223-5a5aa7e68179@amd.com>
Date: Fri, 28 Feb 2025 16:41:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] xilinx: dfu: Fill directly update_info.dfu_string
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jonathan Humphreys <j-humphreys@ti.com>
Cc: u-boot@lists.denx.de, Raymond Mao <raymond.mao@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Udit Kumar <u-kumar1@ti.com>,
 Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Hari Nagalla <hnagalla@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Santhosh Kumar K <s-k6@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Daniel Schultz <d.schultz@phytec.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Aashvij Shenai
 <a-shenai@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Wadim Egorov <w.egorov@phytec.de>,
 Tom Rini <trini@konsulko.com>, Robert Nelson <robertcnelson@gmail.com>,
 Nishanth Menon <nm@ti.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Lukasz Majewski <lukma@denx.de>, s-vadapalli@ti.com
References: <20250226223547.393611-1-j-humphreys@ti.com>
 <20250226223547.393611-2-j-humphreys@ti.com>
 <26b269b3-9df5-4ae4-876d-ab41aec6baa4@gmx.de>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <26b269b3-9df5-4ae4-876d-ab41aec6baa4@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0112.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::41) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|SA1PR12MB6846:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f173f08-71b9-4ab4-4da1-08dd580e6b15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?djNNOWVycytZVGxNcnR0U2ZyYUhmalZqeVJtUjY5cU9hVDUrN3NpNnVhZlBE?=
 =?utf-8?B?UkVYM2JOaU81TGg0UUlDeFFEZVAxaUoxRWhCN2tOMXhETnZpUXR0ZzF2NVg4?=
 =?utf-8?B?QkFCNHRGd0h1TGl5SG5ldkpRSDRNYXA3WVY4Q1l1OVBKWU1pS2M2eU9JcW5B?=
 =?utf-8?B?MnhxSnV1MkZZSDVnaVpCdXFOQlpGQnFOckxJSkwyZXlCeVhDZXpva2JRcFRl?=
 =?utf-8?B?M3dPZm5JZzh6d01SVG9WVDVHcnhoZ1U3bktpdFNvdlZodDBoR2xQSHBvMWta?=
 =?utf-8?B?cTJjL1J2UjIyaXg5SU9UK1A2L2wwdXp2ZVd2eEtYUTEvTjNuckJHN1VtRkVV?=
 =?utf-8?B?NUVFVkR5dHNzcTlNdTRHZnpiTUxSSVowb3d5Z09HV2pCNmU2TmFkSllYdE9N?=
 =?utf-8?B?MG9mZ2x6WDN4ejdxLy9IMEt5SldScmJVYzR6M0wxM0JmVkNGWFoyZ1ZhV05k?=
 =?utf-8?B?SUpOdjRFemRmME1KK0dPWVVOeDJjQjRzcDFJN3A2RUpLY3VQZmN6K1VRejZW?=
 =?utf-8?B?WGRSZ0IrK3hmMmdFOUdGOXd3YUxEdHpLM3hFYXhxNmYzSURMb3k1bng0WVRk?=
 =?utf-8?B?YzZJS3kvbkwybjFyb2ErTWFGVE9QN21rQ2dJUkttaTU0bk5ucEovZHhoS1N2?=
 =?utf-8?B?aVdMM1dPaWltMmpHMmx5ZGJEeXo1MG5PYnBSdEVSZXpvZzhvVXZ0a2xKVmo0?=
 =?utf-8?B?dmpqeWJEblFDcnNGZUdUWE5EbTYxUThNaW1sRHdQQllkTVZKWFBWYzhyQk1O?=
 =?utf-8?B?U2VkMmVOUHlld0kwMWRDWGRyWTRNTjJsYVUzTWhMRmVhMDZ3YlVRanJZdmhY?=
 =?utf-8?B?UUhSWDd3ZmNxbm1WWUxrdHlBK1BrR2FKNnJEUmx1bjgzQUt5MDZlNWhTNGFs?=
 =?utf-8?B?M2VJYnRrVHhEdCtGaVJnRlMxMWFSTGtuUmh4S2hSNmRXWDQrUC9EV2tEbTRC?=
 =?utf-8?B?MzB2Sy9PS0VMNnRObFAzTVRZVUJJRElWSURVS1A0MXBRcGJYU0t3eUcwcDFT?=
 =?utf-8?B?RE9qeFNoMWt1eG5FalgxVFRQZUl3Q0ZYdTNXaXBZMkhiM3RGRDhYYWpYK3lu?=
 =?utf-8?B?a3doNUpYdC8wTDVhZmFROXdWY09vZTVlLzJ2cXB4bnkwek9LcjRzR3Vkb3dH?=
 =?utf-8?B?WEgwdklDbHBHVWxnMWZxNG9wc2kzWk1XWDJWNU1HMlBSeXZPU2loeXJvRURY?=
 =?utf-8?B?VFQvYnprQ2Ixc3g4dGx2aTIwdFBCeG96T1JGWXZ6eTMvTko3U0xzVDFHOGxQ?=
 =?utf-8?B?VUFiZUJ5djZFaVU1TTRDWmRKL01rb2c0bGkyOGFWTkg1TnI3SHhOd2NlMW5k?=
 =?utf-8?B?QWJQRW42elN2dk0yN0JxRlJEOXdlRXI2VjhGci81ZEFhRHRNTzFxb0hFckNU?=
 =?utf-8?B?elVrNjdIVUJCN051YUVjd1pUQzF4WDVoaXp6SlNWaVFsY3ZhcmkrY25pRE1l?=
 =?utf-8?B?ektSSTdjZm54Q0NXLzhFL3JVeFFVNCtHZWdxSzhoMVlpWUhoVjRoQ3JaVjY2?=
 =?utf-8?B?VkJOSEpLT3k2OGxSWkNRQmFIcE5RYkVXTFlrQ0gvSmtEZmNwYUFwbGtqb0FK?=
 =?utf-8?B?NWYyd1g1M1Zvd3BEWldiZ1RuY1JEamRaV05ZMk9OWXlFR3VnakJuWGFZRjF4?=
 =?utf-8?B?MmtxT3k5cjk2QWRHSkhDTEp6SjBiTkg4b3JoeDdoWE5wMXQ3bWRaVXRMeGdz?=
 =?utf-8?B?OTRlTjB5WW96ajQvcWg2L1F3T2dTUkdDaDhQbFpnMnFZQnp4QWloUkp4R3ZB?=
 =?utf-8?B?V0JPOWlWeXpxdXRaSXl4bmt5QjN1dVpmMnRzcUJlYzVaVkFYS25tU3FzRmVB?=
 =?utf-8?B?dkZXNmlwbTBtRDFEdUc1RFFEWXZKZ3N4ZmdaeU52NDhqOXl1Tk5VUGxJRnkx?=
 =?utf-8?Q?Plke1MigTX44f?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXZsbkIvN2dwT05zNWI4eDZLSlF4akpKVVdTRzBEY3lSS1hwM0VLMTVwNTQx?=
 =?utf-8?B?M3VBbzZRV1dta1d3YVRoVk5DbG5XRjF6ZSt2WjhIdFRRa1YwRVhrcXp4TGR2?=
 =?utf-8?B?eWdXcXVKN2EvY2h1WC9DY2FaZFIxeUhCY2R4RjlwbTJtajBmd2czU0dsNXRW?=
 =?utf-8?B?UGdRMndJdE5aT1F1NjFtRHc1SVVpMTN6U1dEMW0xOEIxUEsvd0RNUndldTVx?=
 =?utf-8?B?YUt4VDVoRVJ3b0VBMkk5Y01LK1pCNUFFaWM4a1dmN01wL1dJcjVjT2s5U0p6?=
 =?utf-8?B?Ly9Lc3FNbWE0REJDRzV1SzhIZXduc2NUSC9iSGxYdGxtdDlZN0ErYWlHMlZj?=
 =?utf-8?B?enFjU2QybjcwUmZ0dUQ4RUd3QzZJR2VObjBOMkRIT3h2NmNSNS9jczFTWWJh?=
 =?utf-8?B?MFJXSXFiSkhrcG1mRzlJRzFNZHF5ZVE0d0tPT0lFejlZMFFHemdJc1RUNDZ6?=
 =?utf-8?B?TDd4SE9YejlIUUxBZTg3TExPZ3dBd0ZXN3k1VE5COXBPSHIxeTJ6L3Jacm9T?=
 =?utf-8?B?MkxYYnVLb1MrM0pXWkIyWExBZk9sQ2U4djJLc1lMY3QyQ1MvOUNRQWd2c0s3?=
 =?utf-8?B?bm9Xb2NGejQ0bWpXZVhENzBJWDlKZ2V0SVB2REpORHNHWW5IL3U2QnhrTjFT?=
 =?utf-8?B?dDRUNk12WE81ZzJJckpLbkJRTncrK3JYYnloa0R1MXp5QlV6SnhicS9STll2?=
 =?utf-8?B?djdBcnZUeDRHV0crVkdKbk5oNklnZGZEKy9kN29ZTy9XL1BPdVRka3VsM1h0?=
 =?utf-8?B?S29ta0FRUGRqemNTRno0YWpGaElDdkN1Nk1FRWE2NUxJaWs2bkxRWUVCbVRR?=
 =?utf-8?B?NnlGYlEzTlVQenR5LzNRY1NTanN4RXhYSm9UZXM2aUJtYXBOUDFsZklVUW12?=
 =?utf-8?B?MDJqK092Ums2d25wVzFtY1V0TE9kZ0czbVdqSm0zSkZweFRVb1o2RktWajJt?=
 =?utf-8?B?SUFWT0JtNDRobkpvMzY0RGZ2aFo3K2s1aE56cXJRekIrQ3dmTUpWMHhXdklC?=
 =?utf-8?B?cmhqZFpUN0dwK1FqOW9hY21LN3h4Uk50UFI2OWhRdEh2cWp3RGdibzVJaXJj?=
 =?utf-8?B?WlZxNW42a2U5eURGRlVIRlRuZnJFWXUrU0RJVGJUcndvbmlIYnBFMEZXd0E4?=
 =?utf-8?B?Ti9BTmZHQlFQaUtxbW1CdEJhRCtKUzdpcGdHSnBMZnhweUZRb202ellaREkw?=
 =?utf-8?B?V3FMMWVrWFFVeFpHRFJaOWs2bHFzVFNKY09YaGhZdGMyNER2SkZnY2RwTldY?=
 =?utf-8?B?Qmt1cXVBcUw5MnNnSm1ja0xGc2EvcHByMXBrZjdLa2lJVkw0T3B2ZG9JeHVq?=
 =?utf-8?B?K2hmdVp2Ym9LbjRlQWVjaVdUMVBtK2FDVjhYdno3K1dJY0RBclMyaUhjekx0?=
 =?utf-8?B?cEdMLzFuZXBCQk1GZ2R4L2MxRTZVejFEK3JZbk95RXRzRDBUWWlrT3Q2YVh3?=
 =?utf-8?B?SGIxU3gybllwWllOMGhPNzNuN2JuWWJZS3B2NzdteCtBVTV5VzlVVmszdHp2?=
 =?utf-8?B?SFBHMUY2dUhGSmU5cWZJSkRqLzdhUnljMGFaS1JubWFZL0EwTit6SlBDTU00?=
 =?utf-8?B?SjZJUUxwTUUwQzVtZ3daZlQ2bUpyVTNqbUsyZnNWK09laVJTWWJxL0Mwam5q?=
 =?utf-8?B?Rmc4VVRrNUY4bnhJbzRNcHJDTUNmY1RsN2VLRW5IS1JmN2NKamNkU3Y0SitP?=
 =?utf-8?B?aVFXRlp0MWtMY3AvdjRNbG1Db3hLYTZRa2F5akRITjMyWVBiS1o2NzZ0S3R0?=
 =?utf-8?B?VVNrRlJyZS9BT1BlV3dsT0FtdVhtTThNWFBzbGJoVUQwb2NGQTB0azAwcUpo?=
 =?utf-8?B?MzFvRXhtUC9kMjBNZWo0Mk44dFNvNjl1MFROVXpDOGp3clNWVTBiemlXQ1RB?=
 =?utf-8?B?aVZ4QlJnaUR1MEI4WW05TlpvRGdiR2RXQlNFU05VM1lhNW9Kb0tXZ0taSmt0?=
 =?utf-8?B?cW5jMlBraWZvaGEyMDNMSjA2Y3NGeHlJbFFYdUFWUFFaY1hVYWladWRXRkkr?=
 =?utf-8?B?Sm5mZlFtM3Z3dDlRRWJpUEJFYVlxN0RnVmdUakI2WDVUNWs5cUxvUUlLcGc1?=
 =?utf-8?B?Y3hnNU40MzVGSHpIM3d0a3prcThWcy81Qk5tdm9iMFRzajdzSkhYWWZVOWRr?=
 =?utf-8?Q?3xdnbMSMgHs4+8tbSceBOYWpq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f173f08-71b9-4ab4-4da1-08dd580e6b15
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 15:41:50.7912 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hsSUhCzZ4E6ITZZJ6gUt2ysZ3DuZk1stychRTtmu1N4KQTwbFZr4a7QJL5ESzdq7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6846
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



On 2/28/25 15:33, Heinrich Schuchardt wrote:
> On 26.02.25 23:35, Jonathan Humphreys wrote:
>> From: Michal Simek <michal.simek@amd.com>
>>
>> Directly fill update_info.dfu_string to prepare platforms to switch
>> from using dfu_alt_info variable to dfu_string which contains description
>> for capsule update when switch is done.
> 
> Other platforms only set the environment variable.

Not really.

git grep \.dfu_string board/

beagle, imx, rpi, ti and others are also doing it.

> 
> Do we have a problem that needs to be solved for all problems?
> Or is anything special about the Xilinx platform?
> 
> If we have a general problem, solving it for Xilinx only would not be
> the right approach.

This is just preparation patch for switch in 3/3 because then Jon would have to 
do this change in his patch.
But the biggest reason is when 2/3 is applied, capsule update will stop to work 
on our platform and I wanted to make sure that we can avoid it.

Thanks,
Michal


