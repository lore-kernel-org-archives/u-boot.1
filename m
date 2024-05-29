Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D661C25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 14:30:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D2498840F;
	Wed, 29 May 2024 16:30:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cuk7p89F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8E62883BA; Wed, 29 May 2024 16:30:16 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B2A68840F
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 16:30:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P17WTQlCA5MQfgEGb1imEQR6F6xF8Vaa7Y9MELc7HCFJCdmGpscaX2IMsAl8VoI4ZVuKQs5GJe1xD6++YPla+DnYZR2jo/7bZX3NPuCGsbMWx11ybELE+E+3Nui5qHG33JWSMtZo7XsfNV2Z9nX1LJuBe2eoPr1Q+PfmJteN2d2rlXKLc6cS8CbvITxPIkX2eMjxRyMoQOLgPhp8Alr0xM6E94ylj0pSNh1voGAeeWJuk74isxxPwBgNecLS+SpeNuz+ulgVF5L0Q2D+62xpeyuWOOM/CKDXwNorhcc8WJssQZk2ajggZTkOKb5/teiXhHfk2u+gAhgrK5i89LBV4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MX/TOjPfDFTyXNyAyXuMbsQ/JT2yy1FBUdr1nAmcT0g=;
 b=K8zfNNHDMcZ8PDf8yJUVDcom95x2kb46ufq7ywL/HJXoJn/0pXIF06QiCMTe28pawIbg/JDoqnUAoWjB3p+sN7wxjkZcVzrPS/e0xeXQ0frwfoYUCMiJEnCvLcmu0UJgIZ8lVpKlIvi+8c2l/wA0oDN1Ne69RGaMraCPh+Dk6Eifsk648TIhZuLknmpnf1hUOHoCtTwHTfARxMbuRRn2MJTgGAYhgJ+kBCGJaTtw1Xe0YCZNoUAYMutpuFYW5k7P4EMARBO4HmLLyH3ABm+yVuIgCR0qUo+8L67hnYNKFFpPlqaCON1jOs4KgqTklkgrH/AGwtCQTHJ5J3d0xxEzUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MX/TOjPfDFTyXNyAyXuMbsQ/JT2yy1FBUdr1nAmcT0g=;
 b=cuk7p89FABx9Wd4QMaHsm4BTVNGBe64LIJ1qc/wFmbGUQllMhJxOrDa0ZHatikRjh+L5ptKs8F/IGkf7qviKgQB9j47HcRf0+LuKyrZ2NNTMIeRdP9DQiQgCHgX2T229RiK3ldlvamdYVmXPLTggcGzOGDyhZJOMSaWqfL9sf+8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by BY5PR12MB4114.namprd12.prod.outlook.com (2603:10b6:a03:20c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 14:30:10 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.7611.016; Wed, 29 May 2024
 14:30:10 +0000
Message-ID: <98b1a9a1-32fa-4a21-b136-8c807deb95ec@amd.com>
Date: Wed, 29 May 2024 16:29:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] firmware: zynqmp: Add support to access efuses
To: lukas.funke-oss@weidmueller.com, u-boot@lists.denx.de
Cc: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, Stefan Roese
 <sr@denx.de>, Lukas Funke <lukas.funke@weidmueller.com>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tanmay Shah <tanmay.shah@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <20240515124125.732487-1-lukas.funke-oss@weidmueller.com>
 <20240515124125.732487-2-lukas.funke-oss@weidmueller.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240515124125.732487-2-lukas.funke-oss@weidmueller.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0225.eurprd08.prod.outlook.com
 (2603:10a6:802:15::34) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|BY5PR12MB4114:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b0b21b9-6fcb-4e37-435b-08dc7febd81f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0JDWjFhVklrNTdmNjdjSW5JUGY5Z1daTUZPelZJdUZweUJKRnB2RGRYMWUr?=
 =?utf-8?B?dlVvNEZCUC80QzNjWmltcDNueTNWbEVwMnRody9JdlJsRUFYVXpQS2Jkbk9r?=
 =?utf-8?B?OEtram43TzV5ZTY0eWUzZytYL0xMQk1EVjA2dGV6dGEwWXBJc0JkRllPMGFO?=
 =?utf-8?B?Y0kzbCtWbVp0VU1OYXJxamZpUmd5SkNabTBGcitnY1lXYkJUdmhkTUpscHFq?=
 =?utf-8?B?bjBoR3RiU1l0YStybDlHVGN2eXlsWUNwL1Q1QXFDZE9IOGtjNEpiby9CWUpU?=
 =?utf-8?B?OFM5QTlDem1BWGI4Yk5SWkZqWXA1N2Fqby9yZm91ejFlZUFBRHRlS2J6R0t2?=
 =?utf-8?B?MyszZzEwYTFKbTg4YVp6Uk9LMUZyeExxTDRFcThBMnNDa09DQUF1MHpDR2hY?=
 =?utf-8?B?TVNxVWZsa2g4VGpGNElkWHVYdVRLNFkyTi9GMmxrajNjeXgxMC92bWlGaG91?=
 =?utf-8?B?aUxGVGRmZWF1YldXK3JhM3dsUGFqQ3FJUTZLOXZEOUpxRVhhK1JCalBQR09V?=
 =?utf-8?B?R0VxeWFOTkhnL052bklQZ1kvbWNkSUR2NmNGSXZqS3RUMnh6ZEI2Y3Jsak42?=
 =?utf-8?B?UGhULytqVW03Y0RMTHBBTk9mM3Ayd1lNamd5RklsU0Y0U0hQNHhkdEVLWkZj?=
 =?utf-8?B?WmJYWlN3NUtrdzQyekkxWllBL09SNWNxRjB6eFpwNTNLTCt4MTlweEdSRVdC?=
 =?utf-8?B?RFZtc25ncStkVEhnRnJhYmxyZ2ZFY1EzRUpSM0tWRnpldWdEd2RDNEdMZnAv?=
 =?utf-8?B?aEROMStQUXg2c00yQlI3OURBMFJpRy91UDlwSFRqZW1EOFFqcThrclpnTTZI?=
 =?utf-8?B?SkVaTWZZS3J1ZXV3eWNUMFBnQmhkUXUxZ2ZJWFRCaHZMbytRZXlLRHk4RFEz?=
 =?utf-8?B?RnVzSDRSb0thVWRRemtCc2piRGxQR1cvYXd2eUM4bHBUQnhjMXRMRWlyajVF?=
 =?utf-8?B?ektQUm5KL3RRUE9NLzVDcTVQM2R0UG1rZm4wNmNlLytvWTBSejBuQURPQWdO?=
 =?utf-8?B?ZjErRG5sRWk3RFhGWjNwaERoeUpLTGxaK0ozTkdLdDBaSkZlbEV3MG9hUnh5?=
 =?utf-8?B?YlkwNjZMK2VvbldWU0pOWWdYalNSQjVCY0xoZG9ZUnFWcjNLd3JuNjgrK21t?=
 =?utf-8?B?SHc4RVUzcExrMU8xRUY3aUlod1g3VjllYlFYWXhLMnNha1ByOEM0Yk5TOHRH?=
 =?utf-8?B?eE9vTHJua2YvR05sOFFOWXNhVTd6RUt0SC9PQVF1TXR1TjFMOFVLVGtWWVJE?=
 =?utf-8?B?UVN4QVBZeTlpMmVUc2hnUkd0WDhNTk9EVjYyenRzUHVFZEhWOFd0OXZSWDFI?=
 =?utf-8?B?VStIR25jV2xVOVozY2pGVTR2OVp1bkt0amNXdVQ1VlNLVUpjTGh1LzJwK1oz?=
 =?utf-8?B?LzVEN1Z2UnRrOHdESVRZbFJRMVk3dFdKSzZteWVkN2x4N0dMZHdab2Nkam9E?=
 =?utf-8?B?bmNoK29lMHVQZk9aOGoxREdoanBqdEFTVDVEWUdWSElySnNjU2YwSGp0MG5l?=
 =?utf-8?B?eThvZG8vTTE2SndIRFRTYmxEZW5MZ1hHWkVDNnMvZ2JEMFRwcmRZa1FqYmFJ?=
 =?utf-8?B?YzhocFVqYW4wbWY0amdubldKVGJyU2lZankvNkFrdWFGbE1CaHUweWhyb3dG?=
 =?utf-8?B?WUJ3YUlFVVArUmJJb3lSMTdhR3ZZM1dkU3JUY3ZzWHU0Mm9Wa2FjS0VreUVq?=
 =?utf-8?B?WWQybHZobUVIc3pMam9WbG1ER202MXVaNFgyZnNJdFlOZEkzZWFaeVNnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlpQbnZpbzB2ektDMVJwVmdiZUdNN0FCdnViS0UzN1ZLUC9TUUZtaUE1ZkF5?=
 =?utf-8?B?alRDd2I2QVpVSmlDcTdnZEkrRDFvRmNiTmtQMmdVd1JhQ0lDN0xVaUJ0RDdO?=
 =?utf-8?B?WkJWRnBRaDJlQ2EzYmV0em9CRzlSNXVKQWJaUHBXNHlZeFc4eVFUNjBPMGRM?=
 =?utf-8?B?M0pjU0pEcTM5TVNqNUpIT01iK2lYTXFpNVQvbGRCdy9pTUpydUNyRjNYQkdv?=
 =?utf-8?B?aFYrVytiVTBVVGpFOTMrcy9uNHBqYkUvb21qcnd2ZFA5cStFdExPbWhiZGJa?=
 =?utf-8?B?a09iaDF0UVJ6NVlIMVkvOXgyZmF0R2lJa2d5aTlwUUZ6OEFHTjhJNUZ0d1dr?=
 =?utf-8?B?ZEp5bU9FNE9RcVF1VWI0eWJscWtvY3A3ckJseS83QmN2cUdUN3JYRTRpZlZD?=
 =?utf-8?B?Wit0S3lYNjIwNmVNZUVxbWN4ZE5LYVBLQ1YzaENOWWdJWjJsMnY4eWMxWThr?=
 =?utf-8?B?L0IrekZKRXlkNDEyM2xWejF0dis0eStIcE11dUhpMDlRcllISDNsQWZBSzVP?=
 =?utf-8?B?cW9CNVZmR1oxeHlLZ2VZaU9hbGoramNwZGRDUmJLc1VyWGRuYk5SY3drVW9J?=
 =?utf-8?B?UVRoL3I4RTZFTk9PR2ErV3BZL2VEdnFEYTJmWmdIa1c2NlJ0bXNsSWlBMURt?=
 =?utf-8?B?QjE0TnV2L0tKakc0U0hTbFNvQ045V0F4VFViRGwrU2V5Z2xPT2RsRDRyT3pV?=
 =?utf-8?B?MittZWdjTGxnaVdnMU8wQmZGT2dmRHR4SVdWMFpIQVJNTnhjZnVxZXdaUlN3?=
 =?utf-8?B?UkNaUHJUVm1jWDZKYzBCME9ONWxTR2U0MjlLSXlJSS8xdUFsTGlwajhucTF6?=
 =?utf-8?B?TUhZYmNxQVArREhPaHFwN0hVY1NjZDRSQXNiRTY4MDNRRlV0aDR1VkhSMU45?=
 =?utf-8?B?bUszbHFtUFBXMDlkKzE0TGE5WW54dHNmOUdPSmZOanR3STZDd2RiSjkxdjRU?=
 =?utf-8?B?NmMxYVlJekVXbUpMVTdRa0tLVlloazB4U1FrTEV1SVc1TlBlamNKOEo3V0Vs?=
 =?utf-8?B?QktZQktEMEtBRHJPSk1yQ3ZUYXQ0b2gwU0lRejlQL3hRYzdtWWR2VWo4YkNW?=
 =?utf-8?B?dXJaRmJCUlZncGlYTjZvMThXdWxMOHlCZGNBQU1JdmoxbEFhaFdPWnJVWDlC?=
 =?utf-8?B?V1JYWUtpVFNoSFpDeUQ0TUJaVklEbzRYcUxiZ2dmR2crSXNuWlNBMXIxYUNJ?=
 =?utf-8?B?SWh4VmRVbUl5OUpXcS93RG1aTk1ETkRtWUJ3eVhIdm56MWh1K2tMRFFOd3Jp?=
 =?utf-8?B?YmVObGFYcjVMaTJiT0dheFFIQ2tSZCtzRU9pOTVWaEdGOXFYVGQ2M1lrTmZt?=
 =?utf-8?B?OWdkWjIzMzQ0WnpjM2RzNDFzMjc5djR6UTRHckVUMG4wOGxuQWJtckNFWldC?=
 =?utf-8?B?SWdxR1lCOHBLa0dYMnJqTHVsM0hFNk1oQkhObW5WTXU3K2llcDFPd01BZjdL?=
 =?utf-8?B?ODRwaWhWV3lwajVCZXd2ZGg2Nms2WkhxUzRZZXZMQS90YXIySWpuUE9kc2JN?=
 =?utf-8?B?dnl1K2hGbjZIOG1vWW90WVM3VEVnNHVKZXZwVFdtOS8zSENMWFNoejdnTHZs?=
 =?utf-8?B?THZQN1EvdHBYc0dqUFRZV0dEKzVSQjE5UVpHQ3BKYzltekdvd2FyUTRWK00w?=
 =?utf-8?B?Y3kxQ0JxRGNIRWZiS2piUENNL1Q3dmx2a2hqUTZGdHMrdm52Z0h6Zlg4NXhW?=
 =?utf-8?B?RGxCcVUvV3k1d2RaOFVCT3RxQjJibXdWNDB6Z0Z6TExsZEVhQ3VFaXB5V1d2?=
 =?utf-8?B?T1hkUXFTMk9TNDVJenl3dXdxMjN6eUdZS1JRQWxreldDampTVFR5U2FydmFF?=
 =?utf-8?B?SGxUakhmbkVONkxxOXVKY1pQUzZpMGhGamZMaUhqY3JjU0VwZ1dtNmYzVVNP?=
 =?utf-8?B?RDd4cndKb0gyc3VjOUxMUmt1K2p5TjYvSEVtNGhJM1dGZ1drVTg4dzdrSFpn?=
 =?utf-8?B?T2s4d3B3bExJQVpZajdXWTFYUGE3Z0kxMytmRFViTkt2aE8xZS9NUzYwQlFC?=
 =?utf-8?B?UDFTZmhLREZzMmxYczRjNnhZV1o2SUczanhLTlBnMzRWR25qcmFCT0czSnVX?=
 =?utf-8?B?YUxGVXFPMXdpRTY2eDRxUTV2d1RNMHhZSVdjMHR5YWtJQWh1ZTZ2VXRyQUp2?=
 =?utf-8?Q?DiXq+vBGkNZjFlRmmVO066Z1c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b0b21b9-6fcb-4e37-435b-08dc7febd81f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 14:30:10.2405 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tHnp3geq7gptQVxD6Ni6cRuDTBhZb7HRQFEKZBv7qlGnPHZlSFUrknah2QpTbRDy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4114
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



On 5/15/24 14:41, lukas.funke-oss@weidmueller.com wrote:
> From: Lukas Funke <lukas.funke@weidmueller.com>
> 
> Add functions to access efuses through PMU firmware
> interface.
> 
> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> ---
> 
> (no changes since v1)
> 
>   drivers/firmware/firmware-zynqmp.c | 31 ++++++++++++++++++++++++++++++
>   include/zynqmp_firmware.h          |  2 ++
>   2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
> index f99507d86c6..d7fbe6a3efb 100644
> --- a/drivers/firmware/firmware-zynqmp.c
> +++ b/drivers/firmware/firmware-zynqmp.c
> @@ -210,6 +210,37 @@ int zynqmp_pm_feature(const u32 api_id)
>   	return ret_payload[1] & FIRMWARE_VERSION_MASK;
>   }
>   
> +int zynqmp_pm_get_chipid(u32 *idcode, u32 *version)
> +{
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +	int ret;
> +
> +	if (!idcode || !version)
> +		return -EINVAL;
> +
> +	ret = xilinx_pm_request(PM_GET_CHIPID, 0, 0, 0, 0, ret_payload);
> +	*idcode = ret_payload[1];
> +	*version = ret_payload[2];
> +
> +	return ret;
> +}
> +
> +int zynqmp_pm_efuse_access(const u64 address, u32 *out)
> +{
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +	int ret;
> +
> +	if (!out)
> +		return -EINVAL;
> +
> +	ret = xilinx_pm_request(PM_EFUSE_ACCESS, upper_32_bits(address),
> +				lower_32_bits(address), 0, 0, ret_payload);
> +
> +	*out = ret_payload[1];
> +
> +	return ret;
> +}
> +
>   int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id)
>   {
>   	int ret;
> diff --git a/include/zynqmp_firmware.h b/include/zynqmp_firmware.h
> index 73198a6a6ea..7f18b4d59bf 100644
> --- a/include/zynqmp_firmware.h
> +++ b/include/zynqmp_firmware.h
> @@ -453,6 +453,8 @@ int xilinx_pm_request(u32 api_id, u32 arg0, u32 arg1, u32 arg2,
>   int zynqmp_pm_set_sd_config(u32 node, enum pm_sd_config_type config, u32 value);
>   int zynqmp_pm_set_gem_config(u32 node, enum pm_gem_config_type config,
>   			     u32 value);
> +int zynqmp_pm_get_chipid(u32 *idcode, u32 *version);
> +int zynqmp_pm_efuse_access(const u64 address, u32 *out);
>   int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id);
>   int zynqmp_mmio_read(const u32 address, u32 *value);
>   int zynqmp_mmio_write(const u32 address, const u32 mask, const u32 value);

This looks good to me.

Will be good to convert soc driver to use zynqmp_pm_get_chipid() but can be done 
on the top of this later.

drivers/soc/soc_xilinx_versal.c:53:             ret = 
xilinx_pm_request(PM_GET_CHIPID, 0, 0, 0, 0,
drivers/soc/soc_xilinx_versal_net.c:55:         ret = 
xilinx_pm_request(PM_GET_CHIPID, 0, 0, 0, 0,
drivers/soc/soc_xilinx_zynqmp.c:356:            ret = 
xilinx_pm_request(PM_GET_CHIPID, 0, 0, 0, 0,

Thanks,
Michal
