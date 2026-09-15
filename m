Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B824C88E77
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 17:18:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E22F580D8D;
	Tue, 15 Sep 2026 17:18:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 16HmfAhHQ8JE; Tue, 15 Sep 2026 17:18:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2DF4B80D16
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789492711;
	b=A7ISqkJB0NPfbWHyU2J7g6Q0Q0x3eCaLIp7wMG0g1ALNvARK/4nvL1kXfFYNM+CzP6T9
	 iNnIUw/OOWJ4RwCs1E0HUMh0Wbo+02b1C7IFmNWknI+UMACymTdXdBDDxDFOnsT0QMl2O
	 ib5JyOe2g2iE4eZHpfXrRSFfy5D6XK9dxLVFrS2nDQdEGtgeSyAIltBy2yZdNmVVSYjYi
	 nA7Q4hgNWXHQ6AV+26Sn6dUnYFU/HXeRYFrATRgUxoGQ8SZE13gXwgPKg+k3D4Jr/1goN
	 ScP+YjBbNpJ0YxB28gUcIH3b+9NSXZ6qRQRzBj4e/JW2maM+dF3AHYnzkZ5JRBruV5g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789492711;
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
	bh=4htkWCUNMr1IJEFCk4MskR03f/Ab0lAgQi8fzp/wRRM=;
	b=d5wpSD7JMw76KpUxpoi7ZEqL9Lw7r5vxfUAcfzqEN3lqdVu1Ww2mvmJ8aV1xeUXsqqnK
	 FfQzuX7iV1uWkyMJJjJkwvJzKvDkwYl7Xcl14P82+sJdmP2DGXnUBAOAcCJUaw7qNjYVe
	 GCdZ88mkZDpQQiH5A1zIhmoFQuqumc+87NSS1xZtFk/g1WXRwI3tVLfxervBXT5VH45kp
	 gDFNVdPgcyZDGbPdqBBEXz3j+RmD2BgFiewA/LDhq6hmG3wnS6ytQlldGif2TfHj8NoJc
	 pp1lyCSpWMhjKE5JIRhqNj5z9+lGCFqddsGmrXmx+D520zKpUTyEQGg5l9s5BL0EsYA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789492711;
	bh=4htkWCUNMr1IJEFCk4MskR03f/Ab0lAgQi8fzp/wRRM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rAOsCXApYuNTYQGJiNNEcmIoYRAziV/DoEumJ9sLn4DAy2uE4FVzfroJWzUmeobcC
	 /f0lR1et9itSswaiUEx6cFvqymxaMpF+yAwEata9l2MjL+a+aZ9uVplnM+dmG61iDs
	 ECSOFYpo7F7KvPAwQigJJWYiqbQOf+FihNiiKnMuuuqpgCWEIHvHxqJ2M+GSdniFB9
	 J08Phk6wMl19Z7tMOjroffB5V4Ndeo1AnpXHL63UlELDsOT8O23O1atA5FX7pdSks+
	 6pg9236uLmiTlJJysm+hbT0L/TeD7cezGD8bhDFXbJVpSAXRl5pWeViGyqv1LHqQkS
	 pzF41BgiO+rYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2DF4B80D16;
	Tue, 15 Sep 2026 17:18:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3DCA723F
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 17:18:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2C2794052C
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 17:18:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AyNDuqGYCg0N for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 17:18:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7859F40525
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789492708;
 b=Qb7IPY+1Mv/qhNszp2uWup1q2VSry9CI4eN305DFCghse565X1rkMqi/L41qfHZchPan
 ZzZ0xutcPCs0BOPg4riQAfielDElxB+bxYjxUckqVXKKgHO/qTyGo0NDq1XHLnr0cG/VW
 pwiryt7EjfHaO0UQULt4xu5kbyYwdjll+TvEbrtfRvH0HmKt3iI3xKVgp1XJUSfrY+o0+
 9mq4r7ZP7DED0/528wKVxtB2XFhrA3CtMr6FapeWSpFGfn44+ZmlKrE1wDo6ngudZIpm9
 /noiDCP+jFJ0NT/AVNCRoTwkOTmHJWHoce4klcySxvEoebzvTQss3hb9Y/wVt1OMUtQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789492708;
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
 bh=4htkWCUNMr1IJEFCk4MskR03f/Ab0lAgQi8fzp/wRRM=;
 b=kffZ9zjG8Ir9xnQ+Xn6zQ+5sDvhRRoWwZDAHvJudWeOUPj+d83D/EHirLJeArgS4pm1Q
 drvlY46BivlQ1CgDRWuM7TxmJoas/GngO45gWRuEQUNc7qkW8AR0+jUjX/YI4dCwtbOnA
 mT8kDPXAfOdzxFeMZ5c8NzuKhyZsAC057a03ru0LuTrmQVbAbpvm4QLsY58yc39gVePzd
 09SEsh5qTa1HDUjl0mUnF6uyHR1HfqBtcelpAao49BcO58x8uwLz2juJY1A09LyC6otAL
 UGlXav1VzbKQZ6yvner1QtabRA2wBOWwO+qfRfqa82wo50o10fxnAyQDvrRhz+TdFGQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b="YKZ/23/J"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=ludwig.nussel@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=YKZ/23/J
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7859F40525
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 17:18:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/smV0YCAcC+ckIqNuJKwPjAxDOyald/vV7SnkQVjJgMk8uIHlDcyb+C6WURjrdQMR7BIZKiBYgGaTer3MuT+OZgeqXCJoSOkBXGE2MTyAMsKTAWf6bfgy+T7shmG7Ccpuvc6N61WjNkO+BF80lPosULwhmHCoIoazmi5CL6R8cN3XiABaGkXB6zDRC0/WZSNB+5eDLydpiChk6XPs7AFC6CMQU3yHD+/wAh6I2dhIRFqZVKnrxM4ovHE4+uL6e1oLb8eQt9jdU1yeyxz/eQ9M6Hdm7Sa/YVPfsyPLJArHS8bRl81xcajBu3qGgRd36T+5HFjffnN+lRiRAadmwBkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4htkWCUNMr1IJEFCk4MskR03f/Ab0lAgQi8fzp/wRRM=;
 b=zUusCHNvPuYu7QCPRF5F7NIRfZhDAww47c9rAfT8oPRI/aw0glIf9//8lu0wntnhhxnhProjMcyV9j7wz9KA7xpITRF0YfMdvkgncyeWEdLESXwnG/b9bcPrYZoXjtqm2BTIzrRJu5cfJYAf9rqJ1BCYgnbEiSMBJNFgReADdHpO+OCO94IHMi5Y7Ir75y1pDKxFTD+QVWUP6EU4gB2tHePJ3GoO72beYzj3SkqPdzveo55VLPNTB6zkej9NSD2SLupLmAObUe8grCeK9rd2dBCvvpUmMl4Lh0lt75JfGYT9oviwfsLcaRaUAzedJtkQRQBrKLj0AKPofSTfLpP/aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4htkWCUNMr1IJEFCk4MskR03f/Ab0lAgQi8fzp/wRRM=;
 b=YKZ/23/J3hQawnjxQ99BTnDf5Z6VBIW0NQAbZLmz51uqzbhtcdv/vQG9gBn9jsbVkhu3J9vi0tN6mebgE1YA6HkXnQjLRVwTdX7YiH3d3/YcFFsxlAEu/mrLn7Ejsw2nL1naDqvwyBRMr1wR3H0UkcXAG6NjCxgEzCqpKOMwAQZ1503PKA0P8ta1ecELUhHKdxSTq9IQonbM3P8GH14Zx14leuDb+vTWh9Oj57A2xVgVU0/EDzKZwJWkEsJQ3+sZQULxffcKerUfMRyx7IIkvbVQAbZpd+Do4KDyF8FOELL9B1zf1tVvvhis2ldmkGpTRNnH5+XZrfOTkwIzOh9p1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2cc::12)
 by AS8PR10MB7825.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:63f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 15 Sep
 2026 17:18:22 +0000
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1]) by DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1%6]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 17:18:22 +0000
Message-ID: <0ec38395-d0a4-42d0-a3b0-0e98412c18eb@siemens.com>
Date: Tue, 15 Sep 2026 19:18:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [SECURITY] FIT signature enforcement fails open when the control
 DTB has no /signature node
To: Tom Rini <trini@konsulko.com>, Eva Crystal <0xiviel@gmail.com>
Cc: u-boot@lists.u-boot-project.org
References: <CA+pz=k+hAU5dqbO4GOLJ0fRMRdyrq=kTSnwUc0OcR3r9PotUgg@mail.gmail.com>
 <20260914173412.GD1764417@bill-the-cat>
 <1f194a25-f27f-459f-9b2b-8277457d56a8@siemens.com>
 <CA+pz=k+SnTLkKyj3uYy4L=wM93tSOD7q=Z_sFmdLQ9xScsGK9Q@mail.gmail.com>
 <20260915154140.GA858934@bill-the-cat>
Content-Language: en-US
From: Ludwig Nussel <ludwig.nussel@siemens.com>
In-Reply-To: <20260915154140.GA858934@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI3PR03CA0003.apcprd03.prod.outlook.com
 (2603:1096:4:297::13) To DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2cc::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB5019:EE_|AS8PR10MB7825:EE_
X-MS-Office365-Filtering-Correlation-Id: 5244c567-661d-48b4-aa84-08df134d57e2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|6133799003|22082099003|55112099003|18002099003|56012099006|4143699003|5023799004|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 4RfR9UgeHp3x2Dt3F2IuybnBNsCCLmtnZnPZkJY8q9rq8Q/ktQUlRAQMJBwscvZwld6RSSxKqOjfpSw/BaATkmRHGsSbUGBH0vmTOK1F0SYosDVvtIpaYbZ0b+hIAva6W2c2Ci68MsaBstzkwl3pfXrAItPgdxpJ6y/NU0/xO+F6N8eLOd+tB9lIhfioZXvJtHc5aQOzC1wjjyIOJlG+y5pACWe92IP7oXRqy4KczVnA8xvm9ggvqyhMsB+MUl3tC+EqPf2wmi3SFYXB96yDQyRpgr8LHLmTbGispRjpV0Nwx5DoA/Lgm25c7v5zZecv+oCnCfTf5Zsi5AFU3TqOq6uf/qHS8ewQmnIEkkFqccLb1J4OLUVJboL6A03CB0+zrvmdZ7Ah5qes1MU4ggfHvV0TPEOf6rK8BgpX7yYdLCa8xWAcOnYDfQN8uusfhLRedzp64XS/nN/NnUSTKAMR7gPxxtKj5GSGV0G+bmMYCzWpxNeQkrTwkkafXdGbe/OWcn/N/zgaSpCiP+fdGErEr3iZG/NVEAVAw/nDzEEuihkdna49fmuwYCoB9o37z+BuaDfNoKxGBSnclVmA3kcXaRPnFg2dRAwrTwFQBcEMerQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(22082099003)(55112099003)(18002099003)(56012099006)(4143699003)(5023799004)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amp5L1dZWnJQUlRYN05VVUtvRDBrQXZzQXA4RlpjN1VFb1VmNlZIY21OSy9I?=
 =?utf-8?B?LzViOERtRVQ3Z2NDV1J0RnZNMThWbFk3NWtLK2lnN3BseDhuUnM3UWlOYTdN?=
 =?utf-8?B?TFRaRUxsc1RuTGZsYy9pdzlCaXZzTjFSM0huQW9CVmxVQm9SVkdzZkczMFdC?=
 =?utf-8?B?dkdRQ1BOeUlWRWdrTGdodHdOaXZnZDNEdmY2VmdjQ3Vxd1ZoZDBFRDZIYjZP?=
 =?utf-8?B?M2Q4RGZXa0F0UWpNdjFEbnYwRkdBSTdUOHNyWXAxZllxZXZDUjcyaXIxdVQy?=
 =?utf-8?B?cHdpQUNkcjQvV3dwZVRwZTZRNkNnZ2xBd2hsQ3VEc0l4bklpTEYyb0RLcGEv?=
 =?utf-8?B?emQzb1RSc1g2bVBzMitnT05GUjdUZlR4UlBUQlQvQkFTcE9LSlRDWkFYcFVr?=
 =?utf-8?B?K1VqeWtRMktVZnN6bFp0WXoyQTI0d1ZCakkwNU9rbUxSbUtyYUNUek9KaEVx?=
 =?utf-8?B?SGVyL2NxMUZKaXFiVDhsRlE3L2RFQlVhNE1UTUJUT1cyQ1NKSzE3MGY4K0NS?=
 =?utf-8?B?Y3ZsSXJXTytXeW9UVG1KbC8rNzloaUlCYmNSUSs0aElxSGtIajRmWGp6Zm13?=
 =?utf-8?B?Nmp1bXBPUmM3MHZYUDRKSUs5UVU4SFpUVytzMzVUa1htU3VwYzlETTFmMGhQ?=
 =?utf-8?B?RU83ODZOZko5eCtpZGhmcEczSUxjTFdRb05sNkEvL1NiWWZQeXAzUkl3dWNZ?=
 =?utf-8?B?UG84bnI1Tm5kQmZKYVl5SG5Tdjd3K0dSVEhneWlCTDhCdHp3WHRWUkN5T1JT?=
 =?utf-8?B?SEFPOGNOQjh1NTBDcVZPQm9aVVU2WTR6NXY4QkJHWnVrWXVWanVacVVGRFdn?=
 =?utf-8?B?MFpqTjFhUXpWVHVMblNwbkMvdVo1Z0hiVnhWcjB5TVQzbytOZnVtZXJyYXpP?=
 =?utf-8?B?VWxJUXBhdk5XQnBOdStJS1NINUN6UFNuUUk4aHRLQm5Rb3U1SkJRY3ljNy9w?=
 =?utf-8?B?d0JpblVoYmZhZ25zSXNBOFQ2T0ZDTjRTenBaWkg4M0lQTHhLTXRYb1VrQ1Rm?=
 =?utf-8?B?eUd1bis2a2JUdmo5Q1JvYmttdTZHUFFOc1VQUGRVVWhhd2pmblRwYnpxTDM2?=
 =?utf-8?B?aTRSZHRHMjB2VWkwSW9jazVoM0JQSXBxZW9NK0tXUVEwRHJEd0svTUJkejNL?=
 =?utf-8?B?RG1JWlFGUjE5TkJEbHBDZ3Zaa2k5cCs5RHpuZkNuY1M2RFFFRi80STE5OWlG?=
 =?utf-8?B?d0lJaW5Wd3RzU2FsU0JENFhGMjZ0aVZubUd0SUU3Skk2T2JPcmROOFlyanZh?=
 =?utf-8?B?SXREYVpMZVZMeG4xeFIyRStmYWovQjFPYjBkR0hydHhSeGJFemZ5b3E4cUxm?=
 =?utf-8?B?WG1LM0xJMDZOcWlUd3Y3bUl3VlV0ZldNN1pUK2psZnRKRWJpUFJZL0VwMDZB?=
 =?utf-8?B?aEhMTjRSNytUaGNxMVJIMFJRSFBRNEs3YzNQcGRSbHVHSlNvZThKV0tBaEN1?=
 =?utf-8?B?a2FQTWFPT3pXcEFyRGdVL0xKWFZZd0pUcUFaNFRNanZuVVVFVGVJM3BSbjEy?=
 =?utf-8?B?d0xZcjZqUXh2bFNRNHIzd1g0ZVZlV3R3b0NqOUMwZ050M0JmNHNiNnBhczgz?=
 =?utf-8?B?NkE1REJyOE51aHMzSVZrcVlWQTdxS0ZLM0JNeTZlWkhlaDNiaTdPVWRrV0NV?=
 =?utf-8?B?cityeUtZcDc2M21kdEhaTmt3WW1DT29QcjI0Zm4rd0IzclNyMVczaXFBOFpD?=
 =?utf-8?B?RkppandCV1AwNllacG5MQ205MERnR3hXaVpmLzZIbXRUZlBTSkxTMlZmWjdM?=
 =?utf-8?B?cWoyT01PcExjakpUMHV1V0lVc3J2YXkrVUtoeGpseEpVVzVNT0F1cmZTMmZ0?=
 =?utf-8?B?MVgvNlVKbnBvWTV5SThqYWRBdWoyazFWSkJibjFscFdYYXBiR3RmY1V4TFpE?=
 =?utf-8?B?N3lsbjhQUUJvMXhEekZKREd5RlVLWjFRSDF3TjlXRTU0SkMreWovZHI3MzZx?=
 =?utf-8?B?L1crVjlwNjdzR1BqZ1dXR0Y3bmYxdHpWK1U2b1MzTDcxQVNsU0dhcWw5NDd6?=
 =?utf-8?B?M0FPUDhldmY0MkJuZUZLWC9FT2YrL200M0RGRkJ3Vy9FTDZMNGxBZko0ejdJ?=
 =?utf-8?B?Mk92MG5ZUnpIbnlacUNYMTFYMmhENjZ2eWRNZ0ZUcDZVd3ljdnJTWjhhRmNY?=
 =?utf-8?B?ZXZWTFd4eGpIZ2t6dTlNVUlXdUpsbWpIejhDSmpYcnRWS090OFBMZGR1ZzB6?=
 =?utf-8?B?UnJOVGlOdUxqKzdaMm1zNm1RTGZDQ0F2YUFEaHR4NDNNWlpQN1NMM2Z4b2Uw?=
 =?utf-8?B?RGhzMFRjUEZMTVZ6V1IrVzdCek0yVEZ2Q0lRV2ppVDFtVXBtZVZDMzdvNUI1?=
 =?utf-8?B?VXA4aWNTaklwMkRkTm5iT3FSbkNqY0swRnpydDdKUGpJalQ0Y3kxZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5244c567-661d-48b4-aa84-08df134d57e2
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 17:18:22.2299 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EKjwUu7ieipTLc1A13ryse2XCf9ANmRxk/44kwueuhCQsePmiCyecVt11BfMHKpOmsSLBKt7r+WGSOZ4xq+OXthV1R6FLobgWZaX+m7iS/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7825
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

On 9/15/26 17:41, Tom Rini wrote:
> On Tue, Sep 15, 2026 at 08:45:23PM +1200, Eva Crystal wrote:
>> Thanks Ludwig - I hadn't referenced your series in my cover letter,
>> and I should have.
>>
>> v8 4/8 does close the configuration side: fit_config_verify_required_keys()
>> gains FIT_REQUIRE_CONFIG_SIGS and fails closed when no keys with
>> required='conf' are present.
>>
>> The case I reported is the other gate. fit_image_verify_required_sigs()
>> looks up the /signature node in the control DTB and, when it is missing,
>> sets *no_sigsp = 1 and returns 0 with only a debug() message. Every caller
>> then treats the image as not requiring signatures, so nothing downstream
>> can fail. As far as I can see from your v8 hunks that path is unchanged.
>>
>> Two things follow:
>>
>> - I picked FIT_REQUIRE_CONFIG_SIGS for my Kconfig symbol, which collides
>>    with yours. I'll rename mine to FIT_REQUIRE_IMAGE_SIGS (plus the SPL
>>    variant), default off, since the two gates have different blast radius.
>>
>> - Jonas raised on 4/8 that Rockchip uses FIT_SIGNATURE for image integrity
>>    only, not signed configurations. An image-side required-signature gate
>>    hits that setup directly, which is the other reason to keep it a separate
>>    symbol that is off by default.
>>
>> I'll rebase on top of your series and resend once v8 lands, rather than
>> adding a patch to a series that already carries review tags.
>>
>> Tom, shout if you'd rather see it folded in instead.
> 
> Since Ludwig is already working in this area, I'd like his thoughts on
> the issue / solution, and if it would make more sense to fold this in to
> his series or not. Thanks.

I didn't touch the image path at all indeed. So perfect if Eva takes 
care of that. My series already contains too many things and had too 
many iterations. I fear that expanding the scope would delay acceptance 
further.

cu
Ludwig

-- 
Ludwig Nussel
Siemens AG
www.siemens.com
