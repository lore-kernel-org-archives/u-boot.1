Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 856F2C25B6B
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 08:31:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1E8B86F95;
	Wed, 25 Oct 2023 10:31:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="LNlL9/k9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1560586F95; Wed, 25 Oct 2023 10:31:52 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on0708.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::708])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D575E841C5
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 10:31:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wx3DalM6nnd5w7V3BKaz5tewC1catlGmcrCVTtWD4h0jxHSmT/sQgLCGAIEGHRAbWjY4CWTq3aKifkHqgA2zowNB3vPk1TNr2ni4DD2KWTAtmbrKpTxXxEGw1Pr8kRTpVKaODU2ilHCmPphq5eXD1PhoeyHSTs4HV6oeWb1TBXYjmxMb8qCRTld7mPW9U053hOqoMKEf5PGlqnR6M2rQKQjd4KduEH/X6YOliobduhSFkChyU5+WWbM7wZ8HrNEnl7BVSaTKrumCOIGq8IjDjwqT7Pdn89kFOGHhM6e37LXN97EWmfw6FK2P1AiAsdrGKod61284OzPqWTsC3RKuxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGrHntXP/5yg/g08WW5g0FBQJCi371F6o7Cok1V4VEw=;
 b=ZIgJQ/N73h0SAA52f3FXFvp8vNVvMLofXcBECLxHSH/F2yL4Rzx0j+vQW5lDQDpQR+8fh321JcAOKM/S5Bh99JXswUxU1n0S9CsAIzxbq1xz2mxLatEq4X7VtFo9bDngJnyPxpkvMVR2NdDO0HQq8/7FxGtVai3UQtIXpNbJEbuaxythlGh8YExq+svtacX5M6LWNHuRGHtNxVcj0tGtxIBF1dyC7hD54Viq1XG5AWbd0IUrKT3Scyaa0mMhRnArkaYNc/qCKiQcrZzFWTVD2eqNKVwITldid23z5fLRRigKojMdbq+X4vvJMb0UWb4pr+Jjk+05A2DDXjsgY4+5dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGrHntXP/5yg/g08WW5g0FBQJCi371F6o7Cok1V4VEw=;
 b=LNlL9/k9ZYbihqKSI970ZqcHVeiPLJ9ZlXVQK/bZ9wTXp9oJgKVn5R+HlwYQ6POu3umqV15coAGaYnBoEk5b5ytgwS7/8Cu6p8mwDDZIF3D1WqsoZsSFvzdXm8GelGAQ6LyuVAXG4smwGWClTbXb8XO386iiWzytYzXYo6ZX4Wc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by VI1PR10MB7830.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1cf::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 25 Oct
 2023 08:31:46 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6907.030; Wed, 25 Oct 2023
 08:31:46 +0000
Message-ID: <7bf19381-d820-47d1-b65e-ba918b9c2239@prevas.dk>
Date: Wed, 25 Oct 2023 10:31:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cli: Consume invalid escape sequences early
Content-Language: en-US, da
To: Yurii Monakov <monakov.y@gmail.com>, u-boot@lists.denx.de
References: <775fa336fa5bfb2b9e1e892ee631bd743ea12364.camel@gmail.com>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <775fa336fa5bfb2b9e1e892ee631bd743ea12364.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0083.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::24) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|VI1PR10MB7830:EE_
X-MS-Office365-Filtering-Correlation-Id: 497fbf2c-e206-40a6-bf57-08dbd534d350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jzqIh9+f4vFPxNBf/adykDOdFiUb+NfZhOOv2RGBXhbHAfYAftBkwnw3uvxzKcZR5kD6Nfa5N+8IYxt81Gx0br3GTo+U4yrOk8RlHisIDGG3MCp13PxSokISUbc7AaO2IQLk0veMEDvczK++cP+X+sGZpsYCHlhw2xdTmrrfxBCoKydo4ysxEl+64F9K3KGeYp2jD42uQ3M154uy/avQmabuTozyJS/lBkE1tIeLHk4oJ2IaDBuBveqPIhqsPYqk3pmx5wyuyW6d8iXAvtpkLZDeRnab1DjKioCCltD/pg/u6/VINFb0iAvvG5tQNSREMc0hGGpq5wbqFZ0jPsGDicGISN9QwPqTdl6CCJL+cvHlKmjxwHhITxYkrx21BHyNtosUEjWOtjs7BN+Vgso2A7eWbdj2YCDN4xdhNKOk/aPKciWEgsX1HwR6J1GC5RIRZGKNo/HSzEbVMHOP3m05BtlGYIsy8Fy4Sdrt0gGG1Fr++XPySU/dDrGcTzxjYlL8KGeIaHlb0Q8VNydHZMES5JGfWoQHOFJAIHdC8YnrdoyCLpdCby1B3B/Qm4G2rs2iHgTOaqRvgIerSLwo4nyoOe2CNEeE1b3EcIWApT6i1Gv/TQvurXGNeKy7IEDsJFyGKlw71fp/Zv012ch33JlBgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39840400004)(396003)(346002)(376002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(31696002)(86362001)(31686004)(38100700002)(478600001)(316002)(2616005)(6486002)(36756003)(66556008)(5660300002)(8936002)(6512007)(6666004)(66476007)(6506007)(66946007)(41300700001)(26005)(8976002)(2906002)(44832011)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTlOREtObGQzdTk1dW83TFZyTC9kN2JKUXhIKzcybDJCT2crYmVDTmRxcVY3?=
 =?utf-8?B?bGpxckxXSFl1WUpFeUx3cFJhaGsrZjFYTkhrWDJOZFFXVjZDREEyaG9XSm01?=
 =?utf-8?B?Z1RtOFlDN2ZiS2RtOXhycWc3cFRwNEZvQkl3M0poR1JYd2lpcFRicitVME5I?=
 =?utf-8?B?OEpiRFpEVFRtY2VVd2FNa0ZvVFJGcW8zSFh4dXNCN1pJeHYrQ3c1VXgzWllm?=
 =?utf-8?B?RTExZWtPUDNNY0NFeW5sOW9STVR6ak5zeWdSdjYwZHdkRXVBOUZrYUNwN1JK?=
 =?utf-8?B?dFFLcnd2cllBNmVFZWNUem02U1Y4aGxrMTRtNDRDeDdHd1JuSVFsbEdOcFFj?=
 =?utf-8?B?elBxYTcxVks1TFhiNTB5YTFaQnU0ZHJKK0kyNmlDZkRJVlF2S3J3VjRBSG4r?=
 =?utf-8?B?YURXRGZzTDR0WmxtQThiNmtiOHo1aFVxenBhUzlhdTBkc1ZSUGwwRlBkRlFo?=
 =?utf-8?B?Mk4yTHQ5VXE2SHlqUEN1YUNEanU1UW5hbCtNTUoxb3k4U3ZFL0h2Y0FwMVFx?=
 =?utf-8?B?K1VYckg2SlR0dXozMDYvVTJWTkx5NjQxa3p4Z1pPMGFrcG9ranhsU0huWVdw?=
 =?utf-8?B?K2g2VzU4NFV0TG1ocGxLbmwwaG5CKy9xT3pSMS9EQlhET0VOa1VkcW9KakFG?=
 =?utf-8?B?dWN3dmZqb1gwWVB4SzM4bkE0Q1ZsQnZYZkFLWnl6UEVQd3l3MlNNOHRwUWNw?=
 =?utf-8?B?Z2pCMk9DWkc0VkFySzQ0WDA1RDZIWVpqZkVFdWljdndJaUI1eUpEZEswTkI5?=
 =?utf-8?B?QnBCQ1hwemVGL2NiVDJXM0UrM0xzTDM4V1FLTEl4cjhDOGhjMWdqRmhicjA1?=
 =?utf-8?B?bzM0dU1qbVNHZDZzSEVTbGswT1g5TkpKMy9PTStSMDZEaFJITGllWDJmZHYx?=
 =?utf-8?B?cTFMZEw0WGxWM1NQeGlCWUg1ZFk2MEJweGJ0T1l6Zy9MUllBaVRsdGNwdi91?=
 =?utf-8?B?YVg4Zk9IQ2szK0ZFUUlXQ3lBUEluNTJhcmEzUE9jYVpuM2dsNzZIdE03VU9P?=
 =?utf-8?B?TmJXb2lReGJpNnc5V1BDYTlOUlhtbktkSGhXc0hYdUdQUVEzVTcxT3RFN0xK?=
 =?utf-8?B?RytnMUp4RVlzQ0dJaDY4Y05YRjlUcTVPaENQOUNPUGU0ajFYbGNaOGlvcXJW?=
 =?utf-8?B?L2JpKzlYQTlHb0pMc3hUeUhQM1FvakJUc3g2L25BRTZ0emhVRU9ob2V3OGZi?=
 =?utf-8?B?VlZkQlZ4UXBKN05TU1puSDVEejExanJ2M3RjOWFJUG1uSHhaNmNOWHk1a1FC?=
 =?utf-8?B?TW9RZ0g2NDJvaEVDNCtBdFZQMTRJdGdEUTRZYTloNVJsaUJzSmlCT0E4c3lV?=
 =?utf-8?B?cWtMMm1tMVlpRGwyRmpCL0l6aWRuSjlTRk1RR1VWV2RnZm55eVcwNWxBUDJm?=
 =?utf-8?B?d2g0UXBxWGNMbTVFdjJCa2ROODI0blJwNUNxZG1NaWFaSzh1cVp1aUN1TEJQ?=
 =?utf-8?B?SFpyQ0ZQcDBkRmJ3N1BwcEg1U0tycjVKVEJ4YkZtUFBjM2FEamxTdThsZFQ0?=
 =?utf-8?B?S1RXblQ5cDhkMjZRenNEcGJ0bHlFUjJLelMvV0VPYXEwV3JGdFB2UkF2bytw?=
 =?utf-8?B?QzhBSVV5WUdnLzlaSFZpK2ZzbkQ4dlJwdCtjU3MvVUxrYTdyV2Voc1V5YlJU?=
 =?utf-8?B?TXFCdmhKQ1lnZkhQVnhrMndJdmtFK1E1RGU0K3hRWWh1SmNGbGxJRzAxeHVt?=
 =?utf-8?B?ci84ZzRzelRjR0creEZhaUdGK1dpN21Ia05LZVNzaEhCaGhsK0FOeU9STE9C?=
 =?utf-8?B?eHFkZWxrZFlXSDhoMWRBOUJLcXM5Nm5FcU1CTXpKdHFCRHhxYSt1dGJlaVVj?=
 =?utf-8?B?Z29VMmFYN2w0b016eFI1V1hVQm5NNHg5ZGdVYUVpdUJVbmQ2dDFEdElrcUh1?=
 =?utf-8?B?VWJWZGNtaDJBSmN3aXp3ZlJNUmpSbGV6Z3JwM2syMHNuNmxFVnhTTmpUREtw?=
 =?utf-8?B?eU5sMTA3MFVxV0t0cEtOeVhmSXpMNUV5Y0tRVmRQUmwrYUd6TGZ4Sm05VTh1?=
 =?utf-8?B?bThNS3lDL1RTNW9zZDB1VnZnRlJYRElhVDhoUUpoZEpjeDNIbStyRkJseWVC?=
 =?utf-8?B?cVVjRWRRclUwenUwTUk1eSsrMTdzREFVR1I1dUFxV1U3aTNSaW5WUmk3OXUr?=
 =?utf-8?B?RFU5WG9xQW5iaGZVMDdXUk9BR2FlSVVPcS9ZaC9DQ050c290YzdYckh4RVhp?=
 =?utf-8?B?dWc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 497fbf2c-e206-40a6-bf57-08dbd534d350
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 08:31:46.4558 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eR+qEwkgBA6P+ypUET2J7lUONeYB44l22odJrH8e84ertasEdCajQ0zNNlx7IbjWLQcECD01Y/C5E8Hb7eX+3SbVZgnRCFCf8ts1dbMjBhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7830
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

On 10/10/2023 10.16, Yurii Monakov wrote:
> Unexpected 'Esc' key presses are accumulated internally, even if it is
> already clear that the current escape sequence is invalid. This results
> in weird behaviour. For example, the next character after 'Esc' key
> simply disappears from input and 'Unknown command' is printed
> after 'Enter'.
> 
> This commit fixes some issues with extra 'Esc' keys entered by user:
> 
> 1. Sequence <Esc><Esc><Enter> right after autoboot stop gives:
> =>
> nknown command 'ry 'help'
> =>
> 2. Sequence <Esc><p><r><i><Enter> gives:
> => ri
> Unknown command 'ri' - try 'help'
> =>
> 3. Extra 'Esc' key presses break backspace functionality.

Thank you! This has been bugging me for years, since we have

CONFIG_AUTOBOOT_DELAY_STR=" "
CONFIG_AUTOBOOT_STOP_STR="\x1b"

and pressing <esc> to stop autoboot did have that side-effect of
swallowing the first following char. But I never found the time to dig
into why or if it was even fixable.

Tom has already applied this, but nevertheless

Tested-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

Rasmus

