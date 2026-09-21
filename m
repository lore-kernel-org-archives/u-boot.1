Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACEA3C982DE
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 04:08:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 735DC605F3;
	Mon, 21 Sep 2026 04:08:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id toOKnRxrQm8s; Mon, 21 Sep 2026 04:08:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9566560613
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789963688;
	b=ZOvtIUGvQs+hywceb9oTwGLun3c04EcYQA0veqB6KImOBxw1B1OGagAL1p5FLx3E3LGb
	 4oqvFPeye1Uj0ZTCQUJX5gDZo7OkC5+HYh+ghzM4jCoBllSMyAPPS70SkUx1m/i7wGEsw
	 WRn8sg8oObb4f2e6mD/1gY0UB6g+R7f2k7AVHDI3/HFMzJO8raUt1NgvBo5cbVXPWu75i
	 BkylU4ydwHlDZLjAXNwaBS1XMcgSI3oFJE+KkZbJsqHoMIy4t9COhNtRf1EW9LoPxzIiK
	 d4mGRSnT3Owf8NAx6SfpePEtZH60lQzVObu8DUmtBBT3rdetvAzuatwIw5yv1X9GUDg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789963688;
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
	bh=kMjEAgS39e57JSgjQzZeGi+yMsos4Kxe7sdRj3/Ot4Y=;
	b=FZni1r1vmaFh0qFf6TzNYrMERykRl6PIM8HlV3d9pynYKgcwkBx8s7VjDYWfiFzCToI8
	 lKie9P5i9Wml5CAHderw3OwPhPWjbXXq8KqnN/AAAtX5fy3m5AYnL9s6yB62Fco5sce7+
	 dAAM2JpCtuyZXzwy5BAwCVrMVIcTG5j9vbNQQb1d7jnbgCxN9DB0HspLhdGsbpQHSCdnN
	 zIzxzHykxToQwMPvfecVSOc7o1sIGn7wUwPePvk1/QcchHfgSHY0avbAXXsckd+NxpsIg
	 ow+CFETHySKS8xEAEVrVaeS/e0Sv+7XRF6pp45iAJpFIX+jqpXGGwf6rc4tjqC5JwTw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=NbdbHtSu;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789963688;
	bh=kMjEAgS39e57JSgjQzZeGi+yMsos4Kxe7sdRj3/Ot4Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F8kgYFyzqramjh2PYzmE+yuZijU+FqTgi0vgQrKeRVYraV8Uc4icJ5bjVKPuePfs5
	 W9yUKZfcANxGqjRkVcIk9IYPmiVztSiIoKHGFja3UnTKurTuAgufx2uNfLIZuhyZli
	 JuJ2uYmmoPzO6rD1EWVm/mOo6KV5dBlGRSTmC72ezIxNcDLUlwNxdWhJkX/XX/vxE5
	 FKnnyaw8MYYf3CeHPX+/4KFLRcugA43ONo9uMeUNDp5aR2SRcKmejxe3YVtKx869Sp
	 e3gcoq2+R3TN3ADBgfEzvPXKoGnEkjrUbP6zlA3pbeyC5GFYEei2n4+8ghE5AFyogk
	 Gy1Gm6PpxghsA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9566560613;
	Mon, 21 Sep 2026 04:08:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id EB25A28C
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 04:08:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D106660613
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 04:08:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u-LfG3zkxnf6 for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 04:08:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CA2BC605F3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c105::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789963687;
 b=IVu7ZpurgSwK8Yl0D+fHrV3dsiDFAM0hEdUC9BtERL6tDmMjTDqnzOe0IOqOV4Enwme0
 P1RUln0FWbiLYktx4CtYZSclaM94nKohl4T5e5nzrp7uqBrEnrZW2Zvarp3SpWJ/8Ydzl
 rnIdjYj5TpWH2xuJLueYK/ukRLSjESk5mctzWzhHNy3jEamke7enH0eMPGx3KD+MNF1fE
 TlWA2euG849xtgWoPMZailreJpp6h1+g5ewh14AcrIjXOyoSyaYRTUAhesIv+PIEIho0W
 UI+RTRQPhPVtbNIDFVT4EWXtHPiaT/4vGEBdNPK+O+Lozzk1LgUAc2YBOPwxATtgtDQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789963687;
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
 bh=kMjEAgS39e57JSgjQzZeGi+yMsos4Kxe7sdRj3/Ot4Y=;
 b=gsmjaoN5R9DLTTbusEI6PwZZPHd9Hzg5X90bYdiDUEkC7cSOPn+oBCgNQX6Pi1eyjhpS
 rUKy+BG4QbjoUsg/cjmdajy1M5V8Nx6LFLBowTWJ6tKssyWZ4cZil7mdfC5g4PT1+RaLB
 xwS0XxJPrwu0aN1ZPw0fy1Q5+W78ecxjyaknpbZb7oc8U/RAO4PLMzqFAjlkJe3PF8agG
 IQAaPwYb6LUa45Zm7XRmlNWKR6ZhitQ+BXmBF0Boi0xmdNkRNdQ78eJCQP431MPvqsP+l
 9XQpjPFu+PNCGUGU4OxRyooXrydcTz5L9O/8o7QnwYbPhmqfxlOOcqBuqVP1dRoeOAA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=altera.com; 
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=NbdbHtSu; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c105::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::1;
 helo=ch1pr05cu001.outbound.protection.outlook.com;
 envelope-from=tien.fong.chee@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=NbdbHtSu
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CA2BC605F3
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 04:08:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJjbe5ihSflt5Z51ImOHnNTUiWmf2Dd/YqvHYdQb8YJioTShi6Ma31UWen1Pvq8VFfF3pqkxUmvEBHLFUIPYmdq15X/8VcMFfrrH3JWClfIEeLsSw37Dr298HRauAT6JlueLVY1HG9KGVz+cIy/Nivif1t007WR0VXO8mTouRTz93j891IIiU92h3eUnfd3/+4SoaVEHOCbqUI+u/ad32KR4blszZHfvWf2epVOzv0YIu95V5O/vErHQoi6MqTREhmHfHYX74RqRzykmJJbKzN6kZosYEh+d6PzIGwKEBrDvBCmDI0nbt1o/QErFhBGgDajw0ZYWhrtGnDVYeckEZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMjEAgS39e57JSgjQzZeGi+yMsos4Kxe7sdRj3/Ot4Y=;
 b=wmtXAKiL1UU/MEGfZAwsAEVJunju2xmgJOHdSNFDP5fAZsSkSOMKpID92DYB0M6d6YeeCFcMaOeVBkrvn9zXmVK5BUCn8VsFJACczLQKuTu8Q5PPTcwU6TlLJov76k/Mts9a792BZHSHyLucYEinsLrYETnk/mfuzAxfwNL/kUSXEmawHyvp+f2bwgAqNi+1juHwz+GBZx1D3eYhtb8Pr8sIQxxhnr7BmH23HwJwjCHu5E3cTN+sazUd2w3b7Dte3Oajied4lDKD7XuDipcERrPHjGso1ze/311hab+exVm7qLFUqPEy6DPWBsG9yTjtlugP8k/X0lUpPbAK9n5ZJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMjEAgS39e57JSgjQzZeGi+yMsos4Kxe7sdRj3/Ot4Y=;
 b=NbdbHtSuC+McFecKt6oYWLT+v0A8WPfet+u1g91VC5p2N8H5PdQ4SdCLkYT2zQXrsIMaqGJ7Qx2urACIfSHptWAswC5ejU3o1/MqdeOR+Yy+VRoiXvremAHif70eGDu1OBf3l+LK61a1PEY15TMtBBebkL82tfDwknAJx7n3h13f5OC/7YoxgWgOaupj9vfxH/KSgMdXCN+/0vtY/m4dWvb60wrLfjr5F5t9U+fewjfGpYp+CGtQXuApulhcs8w+P/kLHIqAG/q7cyDh3cabpc3Dvp94KlwUebJNMSyy65UpXR+u7c1fqsCstomzQbOzfekXFY8n3DKrbd3SzKfG1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB8229.namprd03.prod.outlook.com (2603:10b6:806:465::17)
 by DS7PR03MB5654.namprd03.prod.outlook.com (2603:10b6:5:2c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 04:08:01 +0000
Received: from SA3PR03MB8229.namprd03.prod.outlook.com
 ([fe80::2802:a21d:f4ad:97]) by SA3PR03MB8229.namprd03.prod.outlook.com
 ([fe80::2802:a21d:f4ad:97%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 04:07:55 +0000
Message-ID: <8d664067-686b-4f57-85fb-e940b27b3f53@altera.com>
Date: Mon, 21 Sep 2026 12:07:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] include: configs: socfpga: Add environment variables
 for distro boot
To: Boon Khai Ng <boon.khai.ng@altera.com>,
 U-boot Openlist <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20260817032152.30718-1-boon.khai.ng@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260817032152.30718-1-boon.khai.ng@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY8PR10CA0040.namprd10.prod.outlook.com
 (2603:10b6:930:4b::16) To SA3PR03MB8229.namprd03.prod.outlook.com
 (2603:10b6:806:465::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB8229:EE_|DS7PR03MB5654:EE_
X-MS-Office365-Filtering-Correlation-Id: d9ad00f2-a97f-4c5f-07dd-08df1795ea4a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|10067099003|11063799006|18002099003|55112099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: JOu7+CCYbxaZ7IR4/4YCnzvx7XeR8FTkkbkc3iYpS77jQHnGfJgujtO8qk8Bm4fvv30Vm5Q8WITmHN++IJO83cXoXvb9CdQc4f5eVY4WY+e+HESv048EUbhCzJuTuSN0z84mXVMLLwL/5QgGEWrP2tyFlz4DTV6ypurz3GlMl8cKi4fUT/5wiyMxDFlzDqE2hJ9Wrn8sLFwMsc2xkystL1tp2wAuLhAxcT+JLOuaXAImcfWEE8+mogQQsy1vOTO1F3QlnP+nc1O2LqJgOMOJypxnl1g9BmfwsJemYTagzMJ14989q5V58u7rJ7WlCrkYoMhSWnaBDbYqVSN6dFb+EoUMIvUhQE9mjuPlnUgKuJOjA3wjdzd+phyR0VlVAB1l6cShPSYv9xdbz7j40CXV//kKN6rEdrU33Rsu4KBB//0aTWPy+zZ9NzuMCYlT+5Ej2/YufH6ACCbdsNyxQGksOTuiDw4nfHPUOn1ns5v383CJKkyOceDdp1YO+LP27kEoa5fdAAFRNB/bj71IPxajLBFi3f2WBt+Z7zwWDIUUfyRxCQlHX9Y0Pgr8ctdY0v0AZYIdx2CpyFwJFlUE+kV8AQlCVaarNYr44ABQvdjgeZhYhBAODEeGL/HqHFjTXmwr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB8229.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(11063799006)(18002099003)(55112099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmFKa2lVYjBtUk5hQzF3eVo2WWNCcU1BdWx6K2tNNFdsOFZBTzBQMCtMTStN?=
 =?utf-8?B?QldrUG5hSFNkREZrZU9zakE2NnBDZ2tScWY2Vmg2UDZCeklTVUxKTnNRVk8v?=
 =?utf-8?B?Z3I3cVA4SE05YmU1ZnR1NlJHbkVaVXZQNytXUERqMHFOU1RMbllINmVHdnhp?=
 =?utf-8?B?c1NVWlNkTWJtSXpyN2w4cUlvRWkyTFJxOXdqbk15WDV0UEZ2LzltVHI2VmRr?=
 =?utf-8?B?eFVKRTUwSGtPTVVPci9DYURQZFd6VkJodDJGd3FuRjJmNHc5OG84cHFBSlpD?=
 =?utf-8?B?Mkt4TXpuT3VpWmNPVFhMeGhxYVAxNkVMVVhhOHlzMHlsVnpOa1F0RXAreU1q?=
 =?utf-8?B?cyszWHlWK0lmRHhlenZXVllxN3pGMXQ0QVdtc3pzUFRVVzBxZllsNFBzVXg1?=
 =?utf-8?B?M09DaEp2OWluZUxGMUpuMGN0aXN0MlBEbWZXSC9hYkN5TVVEUnJmWHdDdHBh?=
 =?utf-8?B?RE9zeVBiRjRnK2JVWWlZMUNtR2wzTWZWS2gvT3F0MjBBSWNzWnhrZ1p5Yk42?=
 =?utf-8?B?YW9EbHgwMGhKZnl1dCtpN01uZ3A4eERydDVmVFcyVlNGTmd0VEdUTkFoSDhG?=
 =?utf-8?B?ZDB1eGRCUS8zd3VtUVNsUG1zeFcwSXRlL0VuRTNnQXFoN3lRUVNhYWs1NFI4?=
 =?utf-8?B?WTc5TVNWT2I0QUxFU0NoOWtEMEhWY0FFOW95UlFiK09SS2Q3RjE4bGZxMmJ0?=
 =?utf-8?B?Z0VyZlJ6S01udWVqNGM3dmRNTDRlbzIzWnhzcndTcU0wNTZJVFFUNUpXbTBL?=
 =?utf-8?B?WGx3TS8zQVkxcUZpaXhtMGpqcWZCSXZ5dlcyK0g3aHBmL29teS9HbWFPN0tD?=
 =?utf-8?B?emJIQVE4cm9lbVFOb21zWmtsTGdQYWlsNFR0SkxPbDQvQXFBdm9TQUh0MnMw?=
 =?utf-8?B?L2VnZ0JUT2Rpbkx4Yk5yOTAzNmU4dnBxMVlWdWEyd0E0Ym45ZFNkbGtMNzVM?=
 =?utf-8?B?dUVmUGNrbkVpcWEvL085Slk3eFB4Z1Z5OVluc2hSRGRkWEZCNkRMaHkrY0dD?=
 =?utf-8?B?d05GdmYvdi9iOGQ5VU1Wc3dWSEoxR1NwcGpQc0V2QVM4NWhZVkF2cExxUWFJ?=
 =?utf-8?B?SHB5VTkwNkdITklyRVYrRWpkUGR5RFFjVzE3L2xkQy9RREs3cGY5czF1ZTBL?=
 =?utf-8?B?TXk2RllQWXZYT251b1FraHMxZHh0YWszRGlSTVVmTkFGelNIUWw2dDl0M294?=
 =?utf-8?B?MDBmWVIwUTUwRHFId09Fd3dnVCt1Q3VuT3lrTkV2Ky8wa1B2VG9GczBSQmxV?=
 =?utf-8?B?YzVDa3hSMFk1VC9HWGNPU0J0M2IzYjBGa1hBT2hJa2N6RnpCRUh6NlNZOGRF?=
 =?utf-8?B?cVZMN0M2ZWZjK2p3OWJZVUxIY3NXME5FdGUxZDk3T2hQMlh3OWJnTEVSK2d2?=
 =?utf-8?B?QXI4Yjh0ZSt1eHFTYm5BOVlmNzM1bzI3SzF1VThpSHZrRDAxN01aQjhKV3ZJ?=
 =?utf-8?B?dmtjUDB2WEJ1cVFMWUdRYk02d3lHaHNyUWRiSEU2TlFSMDl0VzhBVXBqdUxE?=
 =?utf-8?B?RW56Y1VIVFdDaVBXSTNpeCtPNjhkMTlYYzdxL2ZCekdnT2RYYThrVHFTdER6?=
 =?utf-8?B?U3p4a3NIY3ZQY1JITG5hcTZBTzBQN1hkZGdoRUpjNEZ5TFJEcDhVT0kzSWlE?=
 =?utf-8?B?M1U0Rm5LUEpGRG1YRGhRRDBRdXBoMFN0Zk11K2o0TXJTMFRFcVZhUmkyTnF1?=
 =?utf-8?B?alVCam03ZnB2b3JPSHpLSUxBd0JKWTZDRC9JZHpmZzY4cnFvZ010WDJ3cUlw?=
 =?utf-8?B?bTQvTGxvcEVtRDJuVElUQ1JzMTNSSXhWM1VMMU4xdit1bEJ2dkFrWGdYend4?=
 =?utf-8?B?R1g4eFpHSG5SYkVWT1lPd0RoczBKRkgvRzkvWmpPK25PYklZMmh5UVpPbmVs?=
 =?utf-8?B?NWk0bG45dDc2a0RncHZ6UERNYVRLRmd5dFBGSmRKSnNnZ09wcUZyYTBobkZy?=
 =?utf-8?B?Wkx6TmpkeklLNGNtQmdCd3lYVC9DMzdMSHVhZHd2MVN5RGllbU85NTVib1NT?=
 =?utf-8?B?QVRDNmJzR0VzYUVSSTFxSWhZS0pLeGxEVS80Njk1Y0t4THdCTHFkcmNUck1G?=
 =?utf-8?B?WFlSZ3kraEkrN0c4Tlo5alR5cTBQSW5CY2pmRGtFOWlLbTRzVDlSeWZLR2hv?=
 =?utf-8?B?MzMwamxONzR3SE5NME5Gbi94WUUzSjF1YjM0L2hONUVvbkNwb1hGUlpFOXU5?=
 =?utf-8?B?eGJDMFdiRStzRFVpYnJ6aEFBZExZdnE2L0l2ODNkeGVWdUtOWEdPVW9kRUUw?=
 =?utf-8?B?Y3AydEp3YkNNTExYeHczQk9SamdweEF3QTRaRXN5ZHFuMHRDQWJVeEQ0ZFNr?=
 =?utf-8?B?Rmw4Wkg4QkYzT2FRSmxMaTBhbVpsdGpxTjZVbkN5ZFhlUk5wVWlqdz09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ad00f2-a97f-4c5f-07dd-08df1795ea4a
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB8229.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 04:07:55.8769 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3XYRMm/HaCtH/CZW98Ca42RDemftxQ90pwUEk/AoRbOtMYY2qeqeY0UR8neazboy+VOWqS7DcGmDzNw3nOqIjSdbT8B7n+rRmBW6mZGritc=
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

On 17/8/2026 11:21 am, Boon Khai Ng wrote:
> Added environment variables needed to support distro boot.
>
> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
> ---
> v2:
> - Drop the rsu_status environment variable addition. Per review
>    comment from Tien Fong, it is not required for distro boot and
>    the RSU driver is not yet supported.
>
> v1: https://patchwork.ozlabs.org/project/uboot/
> patch/20260304040201.9265-1-boon.khai.ng@altera.com/
> - Added "nandroot" (rootfs UBI volume for distro boot) and
>    "rsu_status" (helper command to show RSU DCMF version/status/retry
>    counters) environment variables.
> ---
>   include/configs/socfpga_soc64_common.h | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/include/configs/socfpga_soc64_common.h b/include/configs/socfpga_soc64_common.h
> index 4d333c63ad9..daa208a27a1 100644
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


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

