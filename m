Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAADBC79F9E
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 06:57:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 84896605E3;
	Mon,  7 Sep 2026 06:57:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fv-SGzKCKwsA; Mon,  7 Sep 2026 06:57:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B910C6060D
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788764261;
	b=CnKqBYBgFyUYZQ6iCUmRVFWMYS39xs3nJkOtXCigi6oMpC0cf/tSQ2o++tlVAMFkQnvv
	 UBl67nnQlAPSlJZy0xcM8qFt3qbmNdOrWJDAspGyeMlHJSdb89buwfISMoOSDtkBe06wH
	 joFHVWp8XYb9OUeL0fwnREGefTj9NUAh3ORpIZBFeFImrED3Ppl4VPn0wu1lrBVbJ04L0
	 VVywthDnJhVZJBZwQb/6KH3EVYpKynBMn3O0g61s1lppSOn9CtvOKvvQzGAkAvmOhVPkr
	 wFQ0fWCvR+2uTaT2O1cSn+9nfyTW5wEontQndTmuqmRvNwri/8WWDTknuS5ctFKSEjw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788764261;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
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
	bh=l9ZbAo+FYxhx1MHgVxSE8COwjjuf6pOXiKbB+7WOHBc=;
	b=oxA+1R0Uw2V2VZg9kHt0CTbj4BTPuYzd3Ajzj4KPo9pMuDUFo69MUd94ASOHaZOs22uK
	 RfTxt/v+/OVLA3JXRH3r9cm+CbRI3vrMPpuXoRd5kVO7WIJmS14L0NAeqGWGXNyQB/wdu
	 VKgCSc96NRk1pcUo/Da0rf1F/V+K57FuYUJ2OCEzLtvfIJYhaJWexrQadkM5I5OBK4qth
	 YAWfNQ+wRVLKj3fDnjzN0+Zx8nlWco2LEzBqB5a/ZdNcNq9BrVC9E9/0WUJVeXIACT4y1
	 tSkgu+O7QxSDMctVnvh9+s+oTSK+FKTxtf89wokbK4TqVvTXSPl1z3939dYTq8SYySQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Mte3p+ie;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788764261;
	bh=l9ZbAo+FYxhx1MHgVxSE8COwjjuf6pOXiKbB+7WOHBc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TBopJ6ocTvWATYvDnmvoqVGcdl1DaVyaOuVpg/HTkEnzNgu6ovvqP9i+10ncdZJv9
	 kVGMRlu1PKih9y8TFqYhICbQl6QXMyJWZuh2xGsdoUSlFqtOjFniXI8Sp14SD1qpPO
	 dmI0cxXbS9fswzKezEZ639/Cc/5BRA0vwb335st0QPUHeyXfurtil334kbpQ7arMzy
	 51CwFbCr7H2CLswlmjeaG3TmBe9NmAT5mP/+rR+R1RPqeWPBvwUQmNnOxozcGzszsZ
	 AK7L1ofJRP8kBWZkFS9Do5jsgWXwStcJxZT6Rq3fZORQz7zsVCx67zJBYp6ZG8tMS9
	 fP3HJUuOxSIMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B910C6060D;
	Mon,  7 Sep 2026 06:57:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E2345970
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 06:57:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D42FE605E3
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 06:57:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9Fz2WBlCX8e4 for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 06:57:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 094C16060D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c100::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788764259;
 b=KCEFowwafsIU40/JpFj1ke/w8b3MMCV/yqh4+IdHBFJmvaVgHNfT4GQuoNTnfJi2QLOd
 YwKz8ApQspDuCIoED46A5wkL2sEuyxfnjggefwMdBGfy0w77gUeyFSQUhZ5ke5yBXzs0f
 vBPhypdw+0dEMZd7iTVvZwsoFAi7Pk2PImKPcduthEMOMGGGV58010Z3kAikvpc04/h+d
 j/2bfn+vjGtx3SlqiIE5o4pGYcRc4R4kHc5H6zSxCGxLznWtOuWYm9LVOHBi4M7xTjXmg
 FSYFlQ+aGWFypa99lYnMMH/qsi/g7kKI0CVOkmz9QZxXbXLIMvjTr4+rJHOx527Truw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788764259;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=l9ZbAo+FYxhx1MHgVxSE8COwjjuf6pOXiKbB+7WOHBc=;
 b=ZSrp4LMPXHEmt3L2N1ZeEBuDoT57XOIkf0xu/lEvexk6mfS5Co3eJbU598Ydm9jLwhBs
 tjcCGnJGRw4MYt6f0k77EwL888tGulRmya75CASJvWteg4EQ4bpaRBxpfIeNh6PzsGHVu
 8w1hRnCjF1NqgaHQyV5Yt3HnRHhXSv8wt8SveLPKN6/UKOrWKAJgxLh62h2LfSBmQWt1k
 JpPxBxKvuc2UAWTLrQiTT9ehYL25D3R8ShN1c8pWGcDeagU0JzJeu2K6BUFA5yMl7mKjx
 3eqheOopZ2uwlSg4tNotbMXlreSQ6NXxQ1Nh8+2sPhUK3lEC0XCwUMidIM2RsmBxsmQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Mte3p+ie; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c100::f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c100::f;
 helo=bl2pr02cu003.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Mte3p+ie
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 094C16060D
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 06:57:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chukmHh5t0G57wrwduEJusbvG4gRs51fE0pFjIlVzXZ0Iortx7I+BMNgye+1Seiin3oL5i1egTX2rGnKl/NpluQssEsGv1Wveh591HaemMZVoTuLXmWf/C6j6JYTBtZq6xkeimSxvWhZPWFU72wvhjJvYkb91SLsWu8vgt+TKAJT9AjVOp71Z20G8I1rgUvABHmqeoL3hpC44ocABme9kxSd09lpQ6sPjeZjeGMZXgCqox1Q9AHl4haFzkpSJaEpYmZjIYfnTXSy88BiC2UOVYWMUeaajVai1NXcMfgaIPtZAMrLIWsJ7PMA9UkveXev2PrLuoF8Vz77WfRGRgRbMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9ZbAo+FYxhx1MHgVxSE8COwjjuf6pOXiKbB+7WOHBc=;
 b=LZrfy9+SmZ7VNUrwXfg8P6llgjzWUDuf6bNu3ZNXzGv2EQngWag3GJnfYh0dufX8MkQuY7nkzIHsqKXZrSSb0Oq6VmKx9IMd/CPJqMRDQg7WNW6z4Cx+gy//fd8S4STGI9MY0MjdvWjXUIo8EIhJPwTt8q6mo0w/K2hiNHSRS4QrONLFCpnAI9iZ7WEWaw+nraqNQ5PZnjf6V2H0VYgt1cEhcUNhoj5/Ivq6Khy713ZNeiXUriuCYBBOasYCdG7m6hyuuSfs2oa9MaICEsIXCR7tjIx3qDhfMMrvJ4ybbNAQBQJFbewlz13Xy7Ks4KmCqTyipAGBCW2OqIYheaDGow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9ZbAo+FYxhx1MHgVxSE8COwjjuf6pOXiKbB+7WOHBc=;
 b=Mte3p+ienFLjc6HfQ0d/lN6QZ2t7eePemLcRwmAEdADk4v6DSrw8tYEaEfA3chzWNMqan6WLmBpo79TfYB+o3rqIOpJzfSDCBkAGqMUhhvJnNJNYgLD6VD2utSpC7uz+LjcQEW9vTOVAkVcZbUEJCFwAatw3PAI2oAlsfOPgTb4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CY8PR12MB8339.namprd12.prod.outlook.com (2603:10b6:930:7e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 06:57:31 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 06:57:31 +0000
Message-ID: <f9799644-c1a2-4a1d-bd60-cf6609bec249@amd.com>
Date: Mon, 7 Sep 2026 08:57:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] net: mrmac: Fix Rx packet loss on back-to-back frames
To: Padmarao Begari <padmarao.begari@amd.com>, u-boot@lists.u-boot-project.org
Cc: git@amd.com
References: <20260820092623.1647844-1-padmarao.begari@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260820092623.1647844-1-padmarao.begari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P220CA0177.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:33b::25) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CY8PR12MB8339:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ecb4f8b-c94b-46d8-1faa-08df0cad495e
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|22082099003|18002099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: mcyOjz25yK8g4SrQTSBfoAIeiKFQfiThU/oRsoJvQYhDOlXKaw59WWM7UT3RZbemyv9T/KlNEPDKX0U8QRjxpgRH3SsMQwJS1wLnAPJvWW7UybJ7PDAU3gDxJT+poy7zsuFT//3F4aFgnywafObu3aUuxxAia8yPisytAKdHNkc1YBFA7TZvlviJoZwqanuE0rsMTne0m7MVN6sZyQkCX63ujUHeHy4Mr0D7H5s+p72ERRmVGMMg3AM8swAywVFoanuJp5MXZcAVakXCY58ti+sVAAJ4jR0dzX5tlVbepiD7Xg/ErFOiGABKqFGHu5p+PBypIP/f8o4U2NjitZoFUyoQoMXhCxNgprsZY+x7ImFelT0Fhm6l0u90/MHeNQ8TYhcjYSfsTTuge/UF9WD4AVkbhNkFQ1WNOr2duq41n45k3BV8Xi0OrNgaMboJrT7mzXi0T8ExKHx0pjU0TiE0awqmkPCJEH8i8peag4+a03gh/uCEq8uerXLWtpkWuIDVXSTIdcYNUh9h5xOoxBpLMEHyslrbRCPgrW8NIpMP77cRdyV26AFdnwr+jvBb1LsMtvDyK9OFI+/i5WilC4cbx2EXlZ12gxn4u0tP9/kuoiTZR0A857nJ1HG09Ze05aPgGmQX+obLDHESOLMkEpPZvcUt7pLglPOyDSb07KuupZM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUZqdy9aVTFjcTBCMWFMUFpRYXkrZ2lHN1p6b3hqdWRuakVodW9ya2thTXB6?=
 =?utf-8?B?SVFnWllVK3NFTTFnTnIvQ1R4SlFDY3pwZnhYVk1Kb3N2Vnd1N29jLzdkT2h0?=
 =?utf-8?B?cFlWM2NPd3VKWVNCOE00cE11S2h5OWVkcTFuSjZHcmVkR1NTRVVUd0J3R1o3?=
 =?utf-8?B?Uzc3L01YSmlMQXE5RjQ5dmFuVmE5VDNYcWN0cEVRajhWVXROcDRIOTFxSjZU?=
 =?utf-8?B?bGRxdEo0TWxDaGVpbWtBTXoySzYwSHVlNjl4TE1GTlFoWnFWK3FJZkNqNmNr?=
 =?utf-8?B?T3RBVTdqdXhmMmxQM3JHSG4zY2NGVFVxR3l3WlB0R0RVZy9yWnkwWTVBTGEx?=
 =?utf-8?B?WUJaRDRmUy81eVBYM204cnA1djhGc3RpMktBK2V3SFd3MGExeFZEd2RqVHJ4?=
 =?utf-8?B?NWY5YjdMUHFzVVhoM2hmMVBGMXZkaFFPNkZ4KzVYQ0krdjZlR2FXeVJ0MFVB?=
 =?utf-8?B?Y3Nqa3ZsSzlyQnJyZlNhUzBBTDBmYXNvZjJUa2VhZHp4dHRkYzUrUXJoaWty?=
 =?utf-8?B?c3dnV2hMbXpuV3pUZVg2MkRBdi9CVjVMWGZWVDFmUjVwTndOc2hNUDlCanJV?=
 =?utf-8?B?UExBYllKdVJVanJPNFBoTTlLUGVQVGhoWmpWRENHWklZVGo0SUJwT2NDV2hP?=
 =?utf-8?B?ODdybjdOVUg5VDVoTWFlaFBqYWJVSHZNTXF0bXFiMU1SNWVUNFhLLzVkVTU2?=
 =?utf-8?B?M25BMWVVNVhxL2JyYTNXakFJT1QvMjE2WVRBcWZJc3VNZVVsZVJldkVOVmlF?=
 =?utf-8?B?ZFZjZHg3bVRLcGZBbmtIWlNxV05MVkx2TlZmNm54M2ZEdjNxYmk3NmRjS1lm?=
 =?utf-8?B?aExOUmFoNjlSTERoTElvUERrNC9kOE96YkZady8yQVZzQWNyMVNQYUIvN1Jt?=
 =?utf-8?B?ZWRIMTREM0drZW96ZFBYUXdkKzVDSE9CZ2pMQ1JCdENBQXg2cFBHSngrNHAr?=
 =?utf-8?B?aitjU05zNC9PZWVDTFhpVnpiSzJxTkQ5ZFdrVWRzMmQzNkhHTXVRaXJ0NTVF?=
 =?utf-8?B?VWxQdmF4djBKWi9oSFVFbktuaXVYSTdnSzArczhZczl3KzRwYWREb25ZWmVp?=
 =?utf-8?B?dkJodXNwNmFtOEFEYjZlQUNoOFlaOElTTmhRUVFacVQ5TW1ONFdlbTltNEdW?=
 =?utf-8?B?OC9ZTTdzUzh6a1pIemVsQW1XWS9qSjdwenh6WXRwMFVHRmN6SEZtdVZJdllU?=
 =?utf-8?B?VGZBUUQ4VFlRQUNBOE5GdG05MEdpUC93R01QdDhLckorVkNmcUtsRjF0V3Jm?=
 =?utf-8?B?eVd4UWV3WVcvLy9uY1NXbUJkUFhkQ01GS1N1YVFoNWNSQkVWdW9JaHFPSUxX?=
 =?utf-8?B?aTNRSXZhKy9EMXZkaElWdWo4VmFoVTcrdFVhdnZZNW04K2ZGL3hMaDZ6eG8v?=
 =?utf-8?B?Lzd4eXh0cTRQaXNKc2R4SURWL1E3U20rRklxc1MvN1ZlczFCVVB1RmFwZGM2?=
 =?utf-8?B?cktSS0JRZEJTQVcwRHJ5RzNTUFUzMFZob3dEUjI5bUpZK2t0OEpITHVrT0tV?=
 =?utf-8?B?dEo0Qm9kcEsrN1ZIVXk3SnB1TmRqb2o1RlltaW8wVFI4UHZRcUYrZ2trS0x0?=
 =?utf-8?B?bzQyK3JTaGJRZ3lqMktmQUErc000YS9tbi9IanFhNUtETy80eTNnSmdPM0ZH?=
 =?utf-8?B?Z3FqZCtVRkl6LzY1M3Y0T0pYY3JuR2FMTzdZdC9zMnJ4NC9hNUNjM1J6dDZs?=
 =?utf-8?B?bTZ1WWd2WU5iRVVtNHI2WENETjVVVC9oQWlDeDhkUWMyWTNUU0ZjNS9jek5N?=
 =?utf-8?B?dGtENlRiWk1jUkRQOWxxU1MxaDVwT05oM1BaY00vdVA3bHRVSlZjK0pUT1ll?=
 =?utf-8?B?aDNsTEtkdFFDZHNJK21XTEdIZVR1WDVtK3N2QUhIa1NQdVhXcEpmdkxkaW5F?=
 =?utf-8?B?K0tqUFA1c1hZWGtxc05QMC9HN2dOOWtPRlVCVFh2bkVpYnN6ank5eW1rUSsw?=
 =?utf-8?B?L1RHaUR0L0ppNnFwUUNHZitFa245dDRsRVFxT0EvbnI4ZlBSVTF5MndZT0R6?=
 =?utf-8?B?c2lMdzhaREc1eXNBQXFwMStLbkdzekpVUmEyaFJGSTU5MFEvb0pKa3NOcFYx?=
 =?utf-8?B?WWxqUzZVbmlnSko0Q25CVy9aTStFT21QeWphdVA0SVYrQUNGMlFOdzNsUnAx?=
 =?utf-8?B?Z0llMFR0aUt3QlJyVEJnaGFjdTdnL05PVzd1aG1ULzVNcWVVQ0wwZHdpaGNK?=
 =?utf-8?B?dlJhK09WVStIa1BIWVpxVUcrc1RXbmV2V2JDdmpoWUFxWnpZUlFyTVlFQlN5?=
 =?utf-8?B?dFZiRHJRUFFWSzAyWnd4WTBKUEZKYWwyQVFFVVhaOWRoanNDaXVjRVZvT0lY?=
 =?utf-8?B?NElYKysraDgyRzhidEl2c0JRSFBHVllQaFlYUUkwYThYYzNGU1VHdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ecb4f8b-c94b-46d8-1faa-08df0cad495e
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 06:57:31.0748 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j4nphSkmqeONVfVx5Zf8duuQI/j5rzasB4bu6OqrpBr68BR5YbbmoJ1qBnTHiQvW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8339
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



On 8/20/26 11:25, Padmarao Begari wrote:
> The MRMAC Rx path drops frames when two arrive back to back. recv()
> always starts at rx_bd[0] and clears the status of both descriptors,
> and the status field is the only record that a frame arrived, so the
> second frame is lost without any error being reported. This shows up
> with multiple boards on a switch, where the extra traffic makes
> back-to-back arrivals common and network transfers time out.
> 
> Fixing that needs an Rx ring the driver can index, so the series first
> makes the ring scalable and then fixes the bug:
> 
>    1-3  Independent cleanups: check memalign() failures, give the
>         driver its own Rx buffer pool instead of borrowing the shared
>         net_rx_packets[], and read the link speed from the standard
>         max-speed property.
> 
>    4-6  Make the descriptor ring scale: index the contiguous BD blocks
>         directly, build the Rx chain in a loop over RX_DESC, and
>         program CURDESC only once the ring is complete in memory.
> 
>    7    Track the descriptor to consume next in rx_bd_idx and take
>         completion from the per-descriptor COMPLETE bit, so a
>         descriptor goes back to hardware only after the network stack
>         has read it.
> 
>    8    Size the Rx ring from ETH_PACKETS_BATCH_RECV, so a full
>         eth_rx() call can be served without hardware running out of
>         descriptors.
> 
> Padmarao Begari (8):
>    net: mrmac: check memalign() return values
>    net: mrmac: use a driver-owned RX buffer pool
>    net: mrmac: switch to max-speed property
>    net: mrmac: use contiguous BD arrays
>    net: mrmac: initialize the Rx BD ring in a loop
>    net: mrmac: write CURDESC after ring setup
>    net: mrmac: fix Rx packet loss on back-to-back frames
>    net: mrmac: increase the Rx BD ring
> 
>   drivers/net/xilinx_axi_mrmac.c | 235 +++++++++++++++++----------------
>   drivers/net/xilinx_axi_mrmac.h |  20 ++-
>   2 files changed, 137 insertions(+), 118 deletions(-)
> 

Applied.
M
