Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDAD6C982E1
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 04:03:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 772F86064C;
	Mon, 21 Sep 2026 04:03:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jZ6BBe3awP1O; Mon, 21 Sep 2026 04:03:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8773060617
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789963412;
	b=A6EiXSRbMaVJUPqvUzIZILDyhGOVYlVQDSA+yrUtMkGTAIEuCb5QE7U8wenoOwp4FZLd
	 b3n7AS4SXWhflOYOmkwLdYjvL/EHbjbpz+/Qqr2zm5GQHh6QcwU67s2FKG+WMJAVXLr1a
	 g91pVB3OoYapXMFshTHmDrI197iJNLND1yYWGeE54cizToJI33Vvse4eckCxP2AzvClzW
	 dehT5U59jREAMs8NjNS/MJ+WPJhHqnZdcgyHJSTdzfWphC74lSjXRtsNuZ2ppVBG3qLeA
	 ffCc1bhURZe2SPosPYgFNM3yTEDpAW/Ul/TFw6+wXOYScsmoBP528jJsDYa6e+eHzeQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789963412;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ufS1rtmc2fAVRRWfEUcBkjlRLy5re3DterhfPx/gG4E=;
	b=ddRishl//0sUzbPDgWhkdObF9p1d7R5k/N+2nwZQfeCoSHhUJ6bhcA1sXmRQ92mUmGQE
	 AoSRNSk/GDBgDHYqhkokYK3YgncPqvHz/UwSu2MeBle3fIpuhPL57p8axTixSa2fLx8Vz
	 U2ub6/ve77X5pH/077hHfu+sxB+u02VgAQxJ+bpmRpazAlGLpI1vpM5drm45lh8SnTdj8
	 t1DBmFP3DKBtNnHZQ2y/uVx3iW/Z1QBzMjnfuNNJw0oUcZ7HQBo4e200vJjhY8DemGWbY
	 QlKj9VBgtTbnpg/qU0dP+wukwg20jd8QjUvUWW9pdRWZA5vzp7eGxCfaAZ8Hg9ALXeQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789963412;
	bh=ufS1rtmc2fAVRRWfEUcBkjlRLy5re3DterhfPx/gG4E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZGJXLzdsK8dZssqFQyZgW+075OfklmxWPzyDzq00Hn+85oI/h08Kgb0+DCA7rZtuv
	 sWvAKoH0d7Ba2EkLxu8qLMPI2IoX28Kt6Y8l8cjt0UJAH8G7YSLPZ6Tgkk9JSueCYN
	 hD91OWL+4kuCeGfsCCziCIIffwhYjieHrayEPhBVZtcHXtNe4H5n294jnVKyzS5ucS
	 vygVtLa5H4kI6m/j1okQEi0nq6WzUcrsn3VQlo0402dS+ctRWrYWS0cYZXFEhwa99n
	 IFmTJ9pweLfRE06nmd3kfBvnBG+IuE5jQYVbZg6TlbXYd2fR1ngzp9YAmGzfyIFPhE
	 wH0SdarVSZwhw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8773060617;
	Mon, 21 Sep 2026 04:03:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EB4EA28C
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 04:03:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D0BFC40DA3
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 04:03:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3B4QuS-L87bB for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 04:03:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5423540D97
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c101::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789963410;
 b=JnUeDEtPzGli4LM9q0F9i4BDux3QuxmCs2dgGsAxBdqaX07M/gLFjZ1xJOSOafwdXs9F
 euBscdEKlLB5ooPeEo3Miot6ReYR3njK4x9UvJKgygmyfjaxiku6cTe32lkTkw9Ojq4IQ
 R1IYc34jSxRWjce1Fx/IZ/nEseUHY5c+1dTSMyYfqm66ob2XyIhncWkvrUbz4miNANJMf
 I4EwMS6Lw2rwydar7xgAR97UFgbDTDb1rTND1r3dUQidbGeG4vb3OkIEnJOblvcs+eQWF
 7sRKorAjXOiDD25M5FWagnYf/ej9D6hSuc6e14sLSqyu2LfICBeM3rU5Cz9FHlzDPuA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789963410;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=ufS1rtmc2fAVRRWfEUcBkjlRLy5re3DterhfPx/gG4E=;
 b=TiHI6V7kAKKTF/dEBwjThzCkyOHr6U9OJzdh1Qln8kVl6ZM+0Pcqkn0E8+C2LVxphqMW
 96MEuDpVTZSqa38P0P4t8J5hRxYWtDDSz1mrE5+f5Tmd1w2sEVm4S4ya8q54jQjHR9Yee
 HhK2wep/ky8Rbpcjd7GndYFSvqo4E5Qe+CJfnWv8esEiNfsM1QMXcDKGfGtC3S0+1z35D
 SZta7HAeJ92qT05ag1QuuugleIqzyo6HHz+OGtR4IXo20Eq1PRS1G+TK47E2cnfYkoqFo
 tu3Sm6KxFUGUrkibUliimEbA1T/uhMI6RlDkpFVgPK91isLZROw3X+pQRINsV9xoJfw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=altera.com; 
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b="g3tE1k2/"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c101::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c101::7;
 helo=bl0pr03cu003.outbound.protection.outlook.com;
 envelope-from=tien.fong.chee@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=g3tE1k2/
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5423540D97
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 04:03:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sf2l1oTf8CFxP8AzAelr0Z1o7RvcPpY47fnoe3FdB8Q3PMxkyKbSQguHdXTmWzYJrrEgc+7I/raDjAI4ku4LJ2b2JgRjCco5n+wzoe1VZjB4YbmzruhD8Z8H/Sm2uZ8mpEc4Y/ebvtXBKsE2lx+h3BPVptzvzrFZ2l5GJJ7zNcNDlQVg7DrSbrg2pCVQG794VxmGlaaF8f6/FZY56pP7ceBbWjbNgIYH+aPBXXwYu3z1LBhSRgNvl/GbRbTv8Y0vt4cV9jdGArO7E1ddOUu8FNPZW1cxn3E+756oQuEDdnteQ5WX8QjmHoTgEa/WigHMxrxeAAXJVmiF+lqcn0coKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufS1rtmc2fAVRRWfEUcBkjlRLy5re3DterhfPx/gG4E=;
 b=xdYp/XZMKl6Qw2Lz/9M41UOP9RSJUwnmeT/7e0fkcskAzyrz7MMZCywTDSTbmLIQJr3pCzatNSHFFFENawvgCYxn/ixfXWMdY9FT9MER/98skjS4RfzlDOrxBt0GM0lfMar+JqSt8/Mye4sLcmeFB+xI4JdyyQrtHNgLLzbRW4xXK/yvIlZD8Dy67HbrwDO+ZCGlg4KajJ54doZPRbk1f2N0qSzblM+mSp12NDUteJV9gELWMjreyMAbyRV5xY7BdLKV4HVtLcxQHvtM2fpBdKmj9jIBLXbJt7YtyP3GKTYCm4SgsdCuG2sVS/ARcoKMmyUMyXBrs6hrT4MU1ETg/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufS1rtmc2fAVRRWfEUcBkjlRLy5re3DterhfPx/gG4E=;
 b=g3tE1k2/JgYkncWTuiRv3xltzfEA5t5ucz+3mQcpuhvGn7VSV0LA4Srw7uflTdSpynjm9NYi7L1b0lRgHFp+zx2BhEYSICpg5PEFb3iyErys26YoNGBBLNQBe20H+MhVtjMl+dUH/M28uTrx0hvelbnRv/qs9dWQqzb4Kt124xjKHMhmtb7AK0cs4BvNT+DscIHTS4nBOpaVKGw7jmLbOkoRC5fsG4bwCJgEk1+XGODP6FlPYWYko4uM7o5JhphD43q//WbxHaO45VKpFDfzpEvor0t2YZsAwNSK70K6opD39Xl7u9xus5A1knrgTn7Ld4dAzgkEQY4lTqOiAbD+WA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB8229.namprd03.prod.outlook.com (2603:10b6:806:465::17)
 by DS7PR03MB5654.namprd03.prod.outlook.com (2603:10b6:5:2c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 04:03:23 +0000
Received: from SA3PR03MB8229.namprd03.prod.outlook.com
 ([fe80::2802:a21d:f4ad:97]) by SA3PR03MB8229.namprd03.prod.outlook.com
 ([fe80::2802:a21d:f4ad:97%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 04:03:23 +0000
Message-ID: <31544555-7fd7-4b15-acd1-42f6f23eb9ec@altera.com>
Date: Mon, 21 Sep 2026 12:03:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] drivers: fpga: Adding Freeze Bridge for PR console
 support
To: Boon Khai Ng <boon.khai.ng@altera.com>,
 U-boot Openlist <u-boot@lists.denx.de>
Cc: Brian Sune <briansune@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Marek Vasut <marek.vasut+socfpga@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
References: <20260814144747.12988-1-boon.khai.ng@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260814144747.12988-1-boon.khai.ng@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY8PR10CA0040.namprd10.prod.outlook.com
 (2603:10b6:930:4b::16) To SA3PR03MB8229.namprd03.prod.outlook.com
 (2603:10b6:806:465::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB8229:EE_|DS7PR03MB5654:EE_
X-MS-Office365-Filtering-Correlation-Id: 2caff036-a7ae-4eaf-cf74-08df1795481f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|10067099003|11063799006|6133799003|18002099003|55112099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: lehja/hky9PW1E75CIdwHbNARRQcz9t1mORZG1DGRA1+o99apUSr0peDgKxNF7MomG5EFfatfLs9nySJA7NGl7tonP5lMi+nCGCXtjDd2FwuMP8wXcc45jq+5QpeODTYLrJ2/kzkgiastTDozp9OWvQC0y9x5A7X/r7vZioomMLUGobMGKxeHKpjUxdaUt4lOV7TnUMSWD0rZ1eTeh120eqta9Aa24aCR0YZej8rjeKfdUOjKUronoGlHkhffkRpbc+AfBNoBtcnbgPdn3lnA94z4KjaO4X+6a/ftBwfivmgyy8lNujcOOwRiz6vg4gpcuoKZAzVNHVlp9g8mkPEjyXYw0Gr3VCUcPCbHimvXme8upqLq44Iatt1+J65wXhquHdg49+86YgjoklERPeSOcDR1w6+IW3yEnzshkouelSN/+X7NOR9vGvkXdPI/j/cDGNpQFEXLCEVnljqqGkR5wVOe4EpJzr9UnnaH0/+CE6Rh9dkk8/gYD6fFIXeeR+BQE/+iaUpxS/GlXirgzcanK/EYbpB1j7wkRbWVwWgfT0iZHS5X7hg9d05ZPeVJpjefKVfECM2D9fqEgzeyfN606iVS6Kh3elqOrRS1tD3oj+y0vlFueKsOSegm80d4pLx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB8229.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(11063799006)(6133799003)(18002099003)(55112099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wk5WdklNZHFYZzVFSW1RU3pnVzZvR2Y5Q0lTRm1QWWRnVlozdGhIVW9rNkQr?=
 =?utf-8?B?Z1JWS3AxZDBTRmxOOWhmcHo1YWZPOFlndmRVbU8rZEVIQThTb0dCMm9rR2Jk?=
 =?utf-8?B?UXN5QWpIb2dKUEFjaTA1clhJQm1sUUZwaWlVaEtUV25ocmNjcFhBOGJ2RGRB?=
 =?utf-8?B?VTJ3SkJHYmQwNE9yb0tPRjAxNzRBY3EyMlpCaGE5TUttYzduaHVOQXpVdDFI?=
 =?utf-8?B?dlpaR2s1Yk9mU3hPbFg1SWl1ZVd5MGlLcTdWTkc1eXJLcStmSitDQ05wRHpC?=
 =?utf-8?B?aWFzQUMzbE5pWXZaVC9hYVpPWjU4eFBYK0l4RFU2TXJCZlRvYVpiazVDNGpG?=
 =?utf-8?B?UVVJcCtmTVA5SmNYWVhSWVQ0b2VscTM2bzFKc0xQOHg2L2Z2NkRDRGg4NWZM?=
 =?utf-8?B?RXNnNGtIMnRBNUZYQnpJVjJINTR1Z2Y1ZjVYTHZydGZtVGpIRHVHVVVoRnNk?=
 =?utf-8?B?ZGdSWmUyMHQ0QVN6T0ZMcGYzQU9ra0dnTUJzZmJiMWRJaW1LdEdxQXBxSHRN?=
 =?utf-8?B?ZWtPckJZeDQxeFBQendWSWRuY0xXYmhmeHlBeWVnR2ZsM0VMNUg5SitSdjJT?=
 =?utf-8?B?bEpXWVVTRmhTZzlGVXlLa1JpZitGTVZQNDRWTTIwSFlSd004VndCRVJWcHpS?=
 =?utf-8?B?aUtTdERGNFlsYXd6ZWNrNllGcHVZSEY4azkrZVFROC84K20wdW1WKzRmZVJJ?=
 =?utf-8?B?VXhVRUN1ZkUwL1BYZU1mTEEyNDNmUTFmNXRMbm9aYkdnR0cwQjU5VnZjTkw1?=
 =?utf-8?B?angrVmN0bUNtelZNazVjTFRJTEVMN3h4QS9rVlRpWW5nRGlaWlMrd1ZCdkdH?=
 =?utf-8?B?cHZpZEZWaTMrd1I5aThQQkN5STh2TnJXTi82d2ZUQjlpcytMWlYxMHNPQ0ox?=
 =?utf-8?B?REhzbW9YdURxZVlSWnR6dTVrdDNPT2dlNHU5UEdIS1BUQzg3SDh4d3JiQ2U4?=
 =?utf-8?B?TnNITnVpYnI0ZkYxTE5sWCt0akc1dXJyWW96WnJoeDNDMDE3N0dqeEFURTMv?=
 =?utf-8?B?eExFNHZmMnptTkszdTQ3K0l3TFZMQ1k1bGdScURUVGMwOG9XcTJ4QkN4MkMy?=
 =?utf-8?B?Tnk5UUt4M0dBWU1PdVVMQWNkVm96ajlWQzkxclVYQjQ2Q24yTWtxcC9Fd1ls?=
 =?utf-8?B?UUI2bDRYdnFtbUhYN3lUVlJJZmgzOGl4RFdpVXA1Y3p4a1JWTmNDMWx6WWNh?=
 =?utf-8?B?N0pNQ0l0ZjlKQUcyN0I5VkxNNnVOa2ZyaUZsVFhLMlRUa3AxamtkMXRtZHFU?=
 =?utf-8?B?R2MwcWdWS2l3dGxlYktjTllYTWIzdVFMY2pINFV2cTcySzA3QkU2Rk1aajd3?=
 =?utf-8?B?ZlpuSkpWSFZJdDZoZjlNQVBjZWxkNFpMVWg5Smd4UEdNWTQrMXhQMzVYZlJO?=
 =?utf-8?B?Q2tyNlNZMkFRTUY3VGhsYmY0czhURUJYSjhXcGhHTyt3NEQ5Z1pjTU8xdWVX?=
 =?utf-8?B?LzY0UWU3K0tzMkQwOWhmRWUvZkNZOUZ5eC84Yit1RGhuQjFTejdmOHplM3h3?=
 =?utf-8?B?Vi9HQ21zd0czejA5ejRJdExtcTh4R2NQRmlTQXNRSGlSbDM3VkNaZ09aNFlD?=
 =?utf-8?B?SjlzTEFLdTNWUGRKaEpHWU1scld3anZJamxKbUJ4c2VhWldvZE8zUXJTWHcx?=
 =?utf-8?B?eWJLeDA0dDdHRDF1ZmVZM1VuVzU4RDZsRzhFYXZWNVBDLytCRUR0ZVREOTZq?=
 =?utf-8?B?S0d3QjM4Q1NyTnlhWHhIYkRjbmd0TmZYTi9qMkNaUHRKWjJDYXBlVzBvOXRh?=
 =?utf-8?B?K3lENHhoV011U1BMTm4wdnNCaWFLZTlSNUcrVVE5K2pyTzRaUThyTHUxd0pa?=
 =?utf-8?B?ay9sRGp3RnNtVzR2OWFGZ20vRzJyTFE0UnowT21EZTBFZDhSQTBBbmp5a1dk?=
 =?utf-8?B?YTZKWjlLNEFhb3RubzlvMUYrTEdNMFV5TDlhclprL2tQQmZCVzJnVXBKSEdE?=
 =?utf-8?B?bmxIaTBRcE4vQlVFeUl4WEZPYWNoc00xMEdBRXBScWR3VC9PYktKS0NRVnhX?=
 =?utf-8?B?dUhENlArVzNZeEZFSEV1S0pNaW1MblZ1d3NzamJydlFRUS9KZGo4QTE0MVpJ?=
 =?utf-8?B?ZTRNMHo1N3JNUVE1U1R5RDlGTDZxYTRKTlAvRlVYVlFyc0NLQlpMcTZWQ09v?=
 =?utf-8?B?WWt2UFFYdjBIaStQWW1tOFZsbHpEb2p2Zk10Q1R6Zm5TUnN2TlFQbXZhdXIy?=
 =?utf-8?B?dHVrbDhVR2dubUtUN0Vzck9sMVArdnl0S2xLSThlbHlOTjdRZUJMTms4Nk5J?=
 =?utf-8?B?b0ZxcVlleEtlY3pxVGFUcGVaVGh2Lzk1RkY5YVY3eHZLaGFZWU5hY0RxSkRw?=
 =?utf-8?B?ck1hbEp2SEcrSzUzQ1E5bTFTOTlWRGE1V2NhbzlMVEZkcnE2SUFJUT09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2caff036-a7ae-4eaf-cf74-08df1795481f
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB8229.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 04:03:23.8417 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9fcRb557lREqz3G/Uoh5Qc1LesTqrUAzRJkk7VASLOaR96isknvViCJA9+jGycY7iLOtkEtnU7cNI4exODIumbNKxlRXf1Ja+mb90X7f2wI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5654
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

Hi Boon Khai,


On 14/8/2026 10:47 pm, Boon Khai Ng wrote:
> Adding Partial Reconfiguration (pr) command at U-Boot console. The pr
> command will control the Freeze Controller which will freeze
> and unfreeze the Partial Reconfiguration region. The pr command also
> support multiple Partial Reconfiguration region by specifying the
> region ID.
>
> Here are the example of expected steps for partial reconfiguration
> $ bridge enable
> $ fatload mmc 0:1 100 pr_bitstream.rbf
> $ pr start 0
> $ fpga load 0 100 $filesize
> $ pr end 0
>
> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
> ---
>   drivers/fpga/Kconfig     |   9 ++
>   drivers/fpga/Makefile    |   1 +
>   drivers/fpga/altera_pr.c | 188 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 198 insertions(+)
>   create mode 100644 drivers/fpga/altera_pr.c
>
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 1658c73bca4..82f887128f1 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -55,6 +55,15 @@ config FPGA_INTEL_SDM_MAILBOX
>   	  Enable FPGA driver for writing full bitstream into Intel FPGA
>   	  devices through SDM (Secure Device Manager) Mailbox.
>   
> +config FPGA_ALTERA_PR
> +	bool "Enable Altera FPGA Partial Reconfiguration driver"
> +	depends on FPGA_ALTERA
> +	help
> +	  Say Y here to enable the Altera FPGA Partial Reconfiguration driver
> +
> +	  This provides basic functionality for partial reconfiguration which
> +	  include the freeze controller support.
> +
>   config FPGA_XILINX
>   	bool "Enable Xilinx FPGA drivers"
>   	select FPGA
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index ccfed94717e..1e1011e9da8 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -23,4 +23,5 @@ obj-$(CONFIG_FPGA_STRATIX_V) += stratixv.o
>   obj-$(CONFIG_FPGA_SOCFPGA) += socfpga.o
>   obj-$(CONFIG_ARCH_SOCFPGA_GEN5) += socfpga_gen5.o
>   obj-$(CONFIG_ARCH_SOCFPGA_ARRIA10) += socfpga_arria10.o
> +obj-$(CONFIG_FPGA_ALTERA_PR) += altera_pr.o
>   endif
> diff --git a/drivers/fpga/altera_pr.c b/drivers/fpga/altera_pr.c
> new file mode 100644
> index 00000000000..7ac39c79c45
> --- /dev/null
> +++ b/drivers/fpga/altera_pr.c
> @@ -0,0 +1,188 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026 Altera Corporation <www.altera.com>
> + */
> +
> +#include <command.h>
> +#include <errno.h>
> +#include <wait_bit.h>
> +#include <asm/global_data.h>
> +#include <asm/io.h>
> +#include <linux/bitops.h>
> +#include <linux/libfdt.h>
> +#include <fdtdec.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +#define FREEZE_CSR_STATUS_OFFSET		0
> +#define FREEZE_CSR_CTRL_OFFSET			4
> +#define FREEZE_CSR_ILLEGAL_REQ_OFFSET		8
> +#define FREEZE_CSR_REG_VERSION			12
> +
> +#define FREEZE_CSR_STATUS_FREEZE_REQ_DONE	BIT(0)
> +#define FREEZE_CSR_STATUS_UNFREEZE_REQ_DONE	BIT(1)
> +
> +#define FREEZE_CSR_CTRL_FREEZE_REQ		BIT(0)
> +#define FREEZE_CSR_CTRL_RESET_REQ		BIT(1)
> +#define FREEZE_CSR_CTRL_UNFREEZE_REQ		BIT(2)
> +
> +#define FREEZE_TIMEOUT				20000
> +
> +static int altera_get_freeze_br_addr(fdt_addr_t *addr, unsigned int region)
> +{
> +	int offset;
> +	char freeze_br[12];
> +	struct fdt_resource r;
> +	int ret;
> +
> +	snprintf(freeze_br, sizeof(freeze_br), "freeze_br%d", region);
> +	const char *alias = fdt_get_alias(gd->fdt_blob, freeze_br);
> +
> +	if (!alias) {
> +		printf("alias %s not found in dts\n", freeze_br);
> +		return -ENODEV;
> +	}
> +
> +	offset = fdt_path_offset(gd->fdt_blob, alias);
> +	if (offset < 0) {
> +		printf("%s not found in dts\n", alias);
> +		return -ENODEV;
> +	}
> +
> +	ret = fdt_get_resource(gd->fdt_blob, offset, "reg", 0, &r);
> +	if (ret) {
> +		printf("%s has no 'reg' property!\n", freeze_br);
> +		return ret;
> +	}
> +
> +	*addr = r.start;
> +
> +	return ret;
> +}
> +
> +static int altera_freeze_br_req_ack(fdt_addr_t addr, u32 req_ack)
> +{
> +	u32 status, illegal, ctrl;
> +	int ret = -ETIMEDOUT;
> +	unsigned long start = get_timer(0);
> +
> +	while (1) {
> +		illegal = readl(addr + FREEZE_CSR_ILLEGAL_REQ_OFFSET);
> +		if (illegal) {
> +			printf("illegal request 0x%08x detected in freeze bridge\n", illegal);
> +
> +			writel(illegal, addr + FREEZE_CSR_ILLEGAL_REQ_OFFSET);
> +
> +			illegal = readl(addr + FREEZE_CSR_ILLEGAL_REQ_OFFSET);
> +			if (illegal)
> +				printf("illegal request 0x%08x detected in freeze bridge are not cleared\n",
> +				       illegal);
> +
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		status = readl(addr + FREEZE_CSR_STATUS_OFFSET);
> +		status &= req_ack;
> +		if (status) {
> +			ctrl = readl(addr + FREEZE_CSR_CTRL_OFFSET);
> +			printf("%s request %x acknowledged %x %x\n",
> +			       __func__, req_ack, status, ctrl);
> +
> +			ret = 0;
> +			break;
> +		}
> +
> +		if (get_timer(start) > FREEZE_TIMEOUT)
> +			break;
> +
> +		udelay(1);
> +		schedule();
> +	}
> +
> +	return ret;
> +}
> +
> +static int altera_freeze_br_do_freeze(unsigned int region)
> +{
> +	u32 status;
> +	int ret;
> +	fdt_addr_t addr;
> +
> +	ret = altera_get_freeze_br_addr(&addr, region);
> +	if (ret)
> +		return ret;
> +
> +	status = readl(addr + FREEZE_CSR_STATUS_OFFSET);
> +
> +	if (status & FREEZE_CSR_STATUS_FREEZE_REQ_DONE)
> +		return 0;
> +	else if (!(status & FREEZE_CSR_STATUS_UNFREEZE_REQ_DONE))
> +		return -EINVAL;
> +
> +	writel(FREEZE_CSR_CTRL_FREEZE_REQ, addr + FREEZE_CSR_CTRL_OFFSET);
> +
> +	ret = altera_freeze_br_req_ack(addr, FREEZE_CSR_STATUS_FREEZE_REQ_DONE);
> +	if (ret)
> +		writel(0, addr + FREEZE_CSR_CTRL_OFFSET);
> +	else
> +		writel(FREEZE_CSR_CTRL_RESET_REQ, addr + FREEZE_CSR_CTRL_OFFSET);
> +
> +	return ret;
> +}
> +
> +static int altera_freeze_br_do_unfreeze(unsigned int region)
> +{
> +	u32 status;
> +	int ret;
> +	fdt_addr_t addr;
> +
> +	ret = altera_get_freeze_br_addr(&addr, region);
> +	if (ret)
> +		return ret;
> +
> +	writel(0, addr + FREEZE_CSR_CTRL_OFFSET);
> +
> +	status = readl(addr + FREEZE_CSR_STATUS_OFFSET);
> +
> +	if (status & FREEZE_CSR_STATUS_UNFREEZE_REQ_DONE)
> +		return 0;
> +	else if (!(status & FREEZE_CSR_STATUS_FREEZE_REQ_DONE))
> +		return -EINVAL;
> +
> +	writel(FREEZE_CSR_CTRL_UNFREEZE_REQ, addr + FREEZE_CSR_CTRL_OFFSET);
> +
> +	ret = altera_freeze_br_req_ack(addr, FREEZE_CSR_STATUS_UNFREEZE_REQ_DONE);
> +
> +	writel(0, addr + FREEZE_CSR_CTRL_OFFSET);
> +
> +	return ret;
> +}
> +
> +static int do_pr(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
> +{
> +	const char *cmd;
> +	char *region;
> +	unsigned int region_num = 0;
> +
> +	if (argc != 2 && argc != 3)
> +		return CMD_RET_USAGE;
> +
> +	cmd = argv[1];
> +	if (argc == 3)
> +		region_num = simple_strtoul(argv[2], &region, 0);
> +
> +	if (strcmp(cmd, "start") == 0)
> +		return altera_freeze_br_do_freeze(region_num);
> +	else if (strcmp(cmd, "end") == 0)
> +		return altera_freeze_br_do_unfreeze(region_num);
> +
> +	return CMD_RET_USAGE;
> +}
> +
> +U_BOOT_CMD(pr, 3, 1, do_pr,
> +	   "SoCFPGA partial reconfiguration control",
> +	   "start [region] - Start the partial reconfiguration by freeze the PR region\n"
> +	   "end [region] - End the partial reconfiguration by unfreeze the PR region\n"
> +	   ""
> +);


Can this be converted to a Driver Model implementation?

The freeze controller should be implemented as a DM driver in 
drivers/fpga/, while the "pr" command should reside in cmd/ and act only 
as a frontend to the driver APIs. Direct DT lookup and register access 
from the command path is not preferred.

Thanks.


Best regards,

Tien Fong

