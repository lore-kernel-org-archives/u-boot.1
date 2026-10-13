Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5FCCC6B0E
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 14:31:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4AFCA60743;
	Tue, 13 Oct 2026 14:31:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hGetgph92Avf; Tue, 13 Oct 2026 14:31:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EDB0B6073C
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791901898;
	b=UMcgpIoVnztK9tdK+YLMiOda5aDVnjSUqmW7XBkwMZP9wu/nWSFc+oCBraFbP20sKN2q
	 BCM9d7kA3SrALfA+OUbc45VDbQIsDTlEOyaCg8upGBNCzpH0FZOVPk6nsKUHreASrTqmC
	 /OSMEJ2+0p+HofpZIgVr60XzemErRt4F1Kut+bCGArCYCAvOQ/oz/Ybgt/P46zmn5NmnN
	 oJ87ixgRykMu7hGGfSdxnTI4kbMAKRHafCqMe2jrb0PiasML5xaR7zCA/IYHX2gMvZXJR
	 Vy7xEA0ZcWfVPoc1CFHZDRKm1qaJYG5HyT142PeApPhokPV39goWaP1lrtEssspsnDg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791901898;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xvhTTO9k0SD3zNZ+6BSLAuBp83p3ug+9juyQJFyQ8MY=;
	b=bImAZwRjde2m4d3JU9VfmEsfuoOPjBz1bhqcJXiL5adKqulIbj+N6EDUI/wIbZLxcARx
	 sxnKwbLOCValdhCmHEglJExCoWHeBkW7Uq0ZzwxXRCw1ppt7MPsU0/nDKEQ59ssdRwhQh
	 JahJSJtjM1NKw+Xwp4iTzfYZbDdC4y3SSf9OWSysMx9meTVQCAr+3CDzsxbF5K+Jazqmy
	 tfK7MK2oK+svUg+qWsBaJYa3cU6CswRq1jPDlEpJUOUqaJmOb1zE95GRJOAZniSSthrM9
	 x/kIshYuJSwgnfmPgU7YnZgRsEtNj3ClMWs88lPYFN1OE0rhkXlF9CRbp5Fay28r9IA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=LmkUE0zf;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791901898;
	bh=xvhTTO9k0SD3zNZ+6BSLAuBp83p3ug+9juyQJFyQ8MY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AohtuYINbcmKCAXGmB5Qj7OERdLaWxdvxojIlvuomOGj/9aKweoIp1gH1u3xB3lK3
	 6tQOXwN25wrpGoaa5Svs5mZF4tmukVZ3BMveEKcwGV7W2Nkg1+vFEtfTjG5Tim/y13
	 Es7UR+Qqeh6bjPdjooEe1xXQA6PsHCB+BpUdwUov97D8rrdVg6F53PR+B5g8GbaSrz
	 Emme6hoK0UfxszN//1T1niiEH17YlDn04uCfggWdyPtxnc9MO1n7o6oTSH32jeGN/5
	 O39RU9BmwiK2qw3/Ay1wUOnmtzX+cO2uVahw1NHDcv4r8OXrJmo5Lyb9UsVSHRANki
	 Zu9MMVcVvVSsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EDB0B6073C;
	Tue, 13 Oct 2026 14:31:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D1012E0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 14:31:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 113876073C
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 14:31:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u9hGU1tEZp4j for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 14:30:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BEF466072B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791901858;
 b=Hk2W3WP9KhP0mOvhJiKTZHLKIE4P5FF6qsSgnMUePyTyx1NEUa8sXBYIq80xlslMvxQM
 xyPkGUjSH6AzKOlM4DvT5NDQf8TXA5jeu8KIcQM8g+IOioYr7BU2ba76gJryQkohs8G3a
 wOidh58gatGEGntDN3vdZk5rbcg+0pYOR0d12vy2nsrwfOWi6lK3synHoh9JUhU5CPWFL
 taJSIl2OigrJQx7ff+VejByjjGm/b3UEzVYz4b8d0ET2beFeflJpNisdStQzPPTRIrE7p
 cfiz2FdtDPaQR5K+ZPflL4369fj0ECSC45oaTdoY2oj+1xCIAr7aHO5lbuX8rAjE6iw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791901858;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:From:Content-Language:Autocrypt:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
 bh=xvhTTO9k0SD3zNZ+6BSLAuBp83p3ug+9juyQJFyQ8MY=;
 b=SSEXAXDTurwLiTvWCPbs2dccvzWGQFDzeZUZt/QbjAeWuYwZSAVTQ9b4Boo72YtrobSQ
 1UXkqzt55jB0zRJvmizZZEf4LRm2WTpxZbeMcKqEKzvzqrm23JwTitC4BtsQIYPzT4Ddr
 4UJk+vu5KLx6t0I1Qt/FKwb8Rlw4IoakL2cRs47rqBr+hGu26UH5V4o1XOguHcpEBwyZK
 E6/NP2cpu8RmlhNBMrd1cC0Lx+JBAGwGhxb+X9SXjZec5+rrxmoluqAqrWPbDhjcy33en
 YvM7+IuRG14ILnsNSTi06mke8WKtzRJQw0dABeZDkV00HPUtK3y8Ki038AGIYN//rdg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=LmkUE0zf; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=jan.kiszka@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=LmkUE0zf
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BEF466072B
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 14:30:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNL3Z9gSCuigy0EQGBUI4yJqqQv3KV85H1KTNJY0JwMmiYMs4Yr8bIDCQZUtl2EiQq4lS+uIEO6BUa/D7/faGBFPm2dkXFWRtEgfhv/JUVqhNM992UlvsS/MjObJTSyyTJ/cSszsm2HYAet0kdE42OD31AlVR93MCdGYiaxPeVZ/4zzBL02wRjDBClR5uuqOfPp1P4q5GASZZJz9Oz3OG5nuPhPea3lFNbUX9woikAYje30rSifsc2R8F4AJRjYBG2W6RuSWO3KZoabb7R/vn5f2JcRFPLk7k6z9qcjRcKdXqO0J4TBMQui6rI3GtQrMTOHp7Cv9zTr989fT//TnQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvhTTO9k0SD3zNZ+6BSLAuBp83p3ug+9juyQJFyQ8MY=;
 b=teprfihZihiek+K1tq2ZyCMbO7+ZL+dWU+GqMC7q20b6/1X+eXcAeNiglzGOJNjeap9RvbHpSlHo+t1SRw6Kyop8zbZQ6ppqnZWDUpq7xG6a3YYzdFSvPE+Wx+4P8YXT9VhnlEh7y6Pv+VYYmHfTrAKrXcQ7n3WpwhEjFBA3td+IIOwjhK3xOZT7INfusQ2xL95x6Q8Y8vScq1yq+n4blwLcvR3XX8V+6YpOlauSSxuXsr1a+JZ3Jkm7IzUFOPOLHVyPQ79LsM+Ngn3wUzL73TKwSuKcMYL2xiGfxZ/nA4Cj1abS7haa98ktUT08WlEQS+GWIswdV+lFEMA+Ss1RqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvhTTO9k0SD3zNZ+6BSLAuBp83p3ug+9juyQJFyQ8MY=;
 b=LmkUE0zf3NGUwM9B8fNkr1XwnfpAiDQ/nge+Wi3WCPev+GD7Xr/+gcf7DTCQPt3C/2GbrcvEMhNbz7XiX+c922ZaQiqNaSb0ecmL64zq5d29VDHbyayLZhtqhW8sqFwjo4GkNMpJ6nhhsBLGK9+VPXK67vnsP11GX7mkhhQnIUxXXXCVn3uXZTZWCiaefvSOHXrDOWRKoJD+1+2bR8BjJcJDWDzzFbrKbn5/+omp6CKkxYa/baPbi71tqXPat0onbs1IJp+0gC9bgEnwSb2yFBoSimqBDXFo4Y8lkmj6tOPtszxfZfIVgyVK8IEc9d0biZgH002cVXgw8AZqgoLrrQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AS5PR10MB8055.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:650::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 14:30:51 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 14:30:50 +0000
Message-ID: <9d178f6c-de2d-4f30-82a1-d235a0f88fcd@siemens.com>
Date: Tue, 13 Oct 2026 16:30:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] optee: do not announce RPMB from within a supplicant
 RPC
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Jens Wiklander <jenswi@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20261011-upstream-optee_rpmb_b4-v1-0-7c63edca4b92@oss.qualcomm.com>
 <20261011-upstream-optee_rpmb_b4-v1-2-7c63edca4b92@oss.qualcomm.com>
 <77d8fc9b-ab0c-429d-a1e3-05e558188f45@siemens.com>
 <CAPzfCAbc6JQBz+VR0O72Zd7csNBSC-QSHtbnrHLL=E4g=ZKEAg@mail.gmail.com>
 <41365552-6c51-4cd3-8899-0bb5c2907aeb@siemens.com>
 <CAPzfCAZcP2soDNCpfpotaDF+h9vm7L+G_4_khZpG_R=rFdVyeA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAPzfCAZcP2soDNCpfpotaDF+h9vm7L+G_4_khZpG_R=rFdVyeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::17) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AS5PR10MB8055:EE_
X-MS-Office365-Filtering-Correlation-Id: 704b13c9-abc1-4062-89ea-08df2936949a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|11063799006|5023799004|260925022911599003|56012099006|260925021311599003|260925021911599003|4143699003|261009223027099003|10067099003|22082099003|18002099003|55112099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: kvFZ4OEkeZ2noKjkJR17M3G0V0ryHhU3Yrp6iSXDIDfPN7bpFMdzURgvcXeW6MyrEZTeqdYXE9O+5WEc6+xxauGRVoLm+w8nFo2dnKf8j3QlD/nISKzCKVYp4frgQsyVnZ10YnszKjXqT0LCceizN8bG0OzyAN48XtYzTfPIgZPbD0xr4ozrlNQO7KGvzlDAEzYaa8Jk5+xvp4ZFPWLM8FmzVZTTOrV33I39GXPnJen8N8WMiMDMkrlysIqa8rbIddHPqv1EJma1sRpmEU5chx4IssKlLC6adZYs46/PmL5idXBrMwcl1T9a0IbxBlFv4XaWY9w2Q0DSUcsEEOeEtgqCAzo3IGEsL2mY6DM1p10cNkbm2FpK3A5PI27vDJhhvgxMzeUfX0nSFpyIPTX4XDuucln7ogNsKwSfR0WwtWEegAQSX5FyGFo1MxlT5+gcfCNJMmyM8hbnEeNr/ckEyMf0sZ6mU+7qB4hbbwq6BTAaOWpnTm1BKEi8AT1KZ6ZiWiKGLiRK6QiRta/nTRUm537/7hOf80OSVC9ihh5TCcRTp90sppIfpvc3ko2W553B3+9WCulRGXdiQebIJH+D/59r+WRQaXJkIqKIWlbf3eGz+VCIFezKgDaYcZBp9hZkfU9LWuyQV3d4mY/15cWi7q4TUUQEu/2rPlP0K0jcdDc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(11063799006)(5023799004)(260925022911599003)(56012099006)(260925021311599003)(260925021911599003)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(55112099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkhDdlVFL1lDZFVTYVNMNEl1MzlkQVFBQVkwcDBaNk0zbnQrMzJLLytMZ3Rk?=
 =?utf-8?B?K1hKSm14T29tT2drM1FRWjh4N3R3bm96Q1FzRUZwSkEzZEN3TG4xQ2xlZmVF?=
 =?utf-8?B?bkZuY1daeFRScVlqSWk5U0RiRFRPOHpaVndRckdRbXlDTFkxcm1GUTZhR0xs?=
 =?utf-8?B?aFRoMW9FUmEwdXFzRmpmaGdkK1l2L25FbXpjeTVlN2dQWUpJS1pPcFliTTdL?=
 =?utf-8?B?UEtvR0MwUTAyTkhCb05PQ1JzejcyemhCU1NJZE8wa2FJNSthTnpoRHNEZ1ZZ?=
 =?utf-8?B?TXYxVVExdE9hMDdEVkRxQUNKaWozaGhGaVNHVDZESnhNSW94T0IzRDhhaVMx?=
 =?utf-8?B?ck56RVR3bTY2bFNjOFNhUjZQS21XZmdmcTZzVkRUNDQrWTJxMUtnSXNMN3V5?=
 =?utf-8?B?SDBKRVVXZExKbVRlTzZMN0pKb3lFdCsydkloc1ZGTU1Ca1Z4L3d5NXh2czBM?=
 =?utf-8?B?bjlMamRXZUxxcHQ4TUtKQUtzcC9idlhNbXJoM3NYTHdnR1p6QVZuRnYyK3BH?=
 =?utf-8?B?K3Irb0RGWGFMWHdmT0JiQnlSZm9CSFlLdkg4ZDBRa0xxVjhIaEp1dHdZNnF1?=
 =?utf-8?B?SlN4eHB2SGR2UTFnTmk5MzFNdW9USWxPU1IweHN1YWNoZXNGOUUwMHlmdGN3?=
 =?utf-8?B?aUhXcFZaMTNoRG9Gbm1ETWpwRWJWbFVQR1lGeTY4VGpxcWJYengrYVVjcHg0?=
 =?utf-8?B?bWVFejU4aklwa0c4MHFiSFFUeXVtNHpkNGFSUktHa1cvS3h3bVVUcjRqaER2?=
 =?utf-8?B?UU9yTGJXeHlvVEI5QzB1MjE2T3Qwb1gyU2RXQXNJTm1jd1IydWNGZFpXNjNK?=
 =?utf-8?B?ZWpsMDRoWUd0OHNmUUhZTTdjVno1dittNy8rbEJHcFkzTXBvamhjWDNEWnlY?=
 =?utf-8?B?cUdvdWdkSTkwbFppNkpYSlZKbUNkMUUwRmRoOWpNUlI3cFBtSjhJSkt2MFRh?=
 =?utf-8?B?R0h6TC9IQjlNaVBYMTdkSngxWVNpWXRCTDJsdXJGZ3NYNjlvRWt3L1Nic2lS?=
 =?utf-8?B?R0tyQzZFSnZOdGZOUXVnbTJoTStYU3dENmc4L2tmZ0R5TUo4blVOUllOcWww?=
 =?utf-8?B?RGhYNlF2MGNNR1VSck9qR3lRZ0l2U1REalkyTkFMRnZGTFUwbVQ0dk5PWlU3?=
 =?utf-8?B?b1RVRGN2TXdDdUsrcHRvTFlLMjR2aEdYTG1wcHNzSEZRYUNmS2l2eGFNaHc1?=
 =?utf-8?B?bUhISVZ1LzY3elBqZktTSmVDTjF5N254VzhwWUtMdkFCME05a3JwMjQvZnJr?=
 =?utf-8?B?YkJIVDRLQnNtNHRBMUhKUDZoUmdGWFhzQXk2MC9hQ1M2ZWFVQ2psSlRxVVhh?=
 =?utf-8?B?OTMyRnZzNjVRSVpvdFRZNTl2TjdnU0FadHM2UnV2akIyQlBNZVpHMzdYN3ZX?=
 =?utf-8?B?Z2FXejhYSm9ZKy9CWjEzallMc1UzMVR5ZVYrRGZreCt5andHV2lmUS9BZFQx?=
 =?utf-8?B?cS8xa3ZkRkpKbmJjVzRLaWdEUEZrZE1WalhZU01ZY3NBUllvY0k5ZFV1MTF1?=
 =?utf-8?B?SUUrT0h4SGd6RlBnYjVhellPSDUrR2F3Mk9XeHFZMG9MeDVnNGxoU3NVckxI?=
 =?utf-8?B?T3NWQmpJUFo5WXlqVDBZUCtQcHJwdC91VVlqRXRwN0NlTk9IVFhobHBWYTdj?=
 =?utf-8?B?ZTVUSkNrZ3RqZnJTaG5rd0NpMERhRUhWdk1OQWN0bTc3Sk5kR0lISlN0WC92?=
 =?utf-8?B?YzAxZzM0MzJpdXRSMFpLL2k4TnRTSFVJVzZlQTNSUVB3MWdrZC80MS9PTzJV?=
 =?utf-8?B?cEY3WlRFTVBPdEpYU1pvd2w4Y0t5dXVPd1l1dFVEd0ZETUhQelpZczl4Zktp?=
 =?utf-8?B?L3k3RjBLeTkxKzJPdWZXYVBuV2xzTkx4cDQzSXFkeUl0dzRBTnFoWjk5YWtq?=
 =?utf-8?B?QVVYZHhTcEdFa2hZMEJ1ZWl3VDVPSS95WEFtTFI1S3NCYjBWNnNZdkRWZ2pn?=
 =?utf-8?B?SU9OTnJ2OW01WTVhcGU2VVpEdHZDSVMxV2dhSFpGNnJ4Qm1mcHlkNlprb0pL?=
 =?utf-8?B?a1hMaElZVU5YWi8yTGRlajRHY1RtSCtCM0VyUGJGOXl3dTRTMnlXTzNNYTln?=
 =?utf-8?B?K1JhV3k3MmZtemxvd0lEb21MVC9WWjUyRmZ5N1NzYnlMa21VQ080N2hIdEZF?=
 =?utf-8?B?bzJkZ04xdm4wcERKT1RrdWRjRVY5eTZpb2V0NW9iYkRPUXViT0VSTVZyM1ZD?=
 =?utf-8?B?Z3VaU3hHbVZiT0ZJcFhnNCtDOFdJV25XK2hybWl2Ti9uc3dSbXhyL0JhT3VG?=
 =?utf-8?B?NmNUdWtsUThPVDREejNXZFBVQUZQRTA3cE1DSUNnbFhWeVhzdWd0QkIzNlB0?=
 =?utf-8?B?NDBaaVdqS285blJRR05EV0R3UTZ5RllYZjBlNC95eGNrdEErK2dXZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 704b13c9-abc1-4062-89ea-08df2936949a
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 14:30:50.9142 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /aBOq63q4af/EElv98hPKByzXEfVuA1efv5lUoyDpYLGOiUCJWleLVQc0ib34Ia2Z2+TEkNqKXKzlYnnNFlTzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8055
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

Hi Igor,

On 12.10.26 19:03, Igor Opaniuk wrote:
> Hi Jan,
> 
> On Mon, Oct 12, 2026 at 11:14 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 12.10.26 10:10, Igor Opaniuk wrote:
>>> Hi Jan,
>>>
>>> On Mon, Oct 12, 2026 at 7:42 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>
>>>> On 11.10.26 15:07, Igor Opaniuk wrote:
>>>>> mmc_init() calls optee_rpmb_available() once the card has been set up.
>>>>> When the first initialisation of the eMMC is triggered by the RPMB
>>>>> supplicant, that is while OP-TEE is blocked in an RPC and holds its RPMB
>>>>> mutex, the announcement opens a nested session and OP-TEE's second thread
>>>>> spins forever waiting for the mutex (U-Boot has no notification support
>>>>> to put it to sleep). This happens whenever a TA touches its RPMB secure
>>>>> storage before anything else in U-Boot has initialised the eMMC, for
>>>>> example a TA call issued from the shell right after reset.
>>>>>
>>>>
>>>> How do I trigger this exactly? I tried via StMM (env print -e), but that
>>>> didn't cause issues in my setup.
>>>
>>> The first mmc_init() of the eMMC has to happen from inside the RPMB RPC,
>>> i.e. nothing in U-Boot may have initialised the card before a TA touches
>>> its RPMB storage. On QEMU virt (eMMC on sdhci-pci with an RPMB partition,
>>> OP-TEE 4.11.0-rc1, environment in pflash, no "mmc" command, no bootstd or
>>> EFI block device enumeration before) it is just:
>>>
>>>   => optee_rpmb read_pvalue test
>>>
>>
>> Seems my setup lacks the AVB TA.
> 
> Any TA that touches RPMB storage as the first eMMC user does it. Two
> options without AVB:
> 
> - the fTPM TA, if it is in your OP-TEE: with CONFIG_TPM2_FTPM_TEE,
>   "tpm2 init" right after reset is the first eMMC access and goes
>   through the same RPMB init in tee_rpmb_fs();

This won't work as there is no TPM before we got informed about the
presence of an RPMB and therefore probed for TAs that need one. The fTPM
use case was the driver for the callback.

> - the AVB TA itself is in the OP-TEE tree (ta/avb), so
>   CFG_IN_TREE_EARLY_TAS="avb/023f8f1a-292a-432b-8fc4-de8471358067"
>   together with CONFIG_CMD_OPTEE_RPMB in U-Boot gives the reproducer I
>   used.
> 
> StMM cannot hit it, which is why "env print -e" is clean: efi_setup.c
> registers the EFI disks, and thereby runs mmc_init(), before
> efi_init_variables() opens the session to StMM (there is even a comment
> on that ordering). By the time StMM issues its first RPMB request the
> announcement has already run from a normal context based on the code I see.
> 
>>
>>> right after reset, with CONFIG_CMD_OPTEE_RPMB (any TA that uses RPMB does
>>> it, this one talks to the AVB TA). With patch 1 alone U-Boot never comes
>>> back; with this patch it does. The OP-TEE log (with CFG_TEE_CORE_LOG_LEVEL=3)
>>> shows the sequence:
>>>
>>>   D/TC:? 0 tee_ta_init_pseudo_ta_session:303 Lookup pseudo TA 023f8f1a-...
>>>   D/TC:? 0 legacy_rpmb_init:1219 Trying legacy RPMB init
>>>   D/TC:? 1 tee_ta_init_session_with_context:578 Re-open trusted
>>> service 7011a688-ddde-4053-a5a9-7b3c4ddf13b8
>>>   D/TC:? 1 do_notif:34 sleep thread 1 0xe9b3d570
>>>   D/TC:? 1 do_notif:42 sleep thread 1 res 0xffff0009
>>>   D/TC:? 1 do_notif:34 sleep thread 1 0xe9b3d570
>>>   D/TC:? 1 do_notif:42 sleep thread 1 res 0xffff0009
>>>   ...
>>>
>>> Thread 0 opens the TA, tee_rpmb_fs takes rpmb_mutex for the RPMB init and
>>> issues the RPMB RPC. U-Boot's supplicant runs get_mmc() -> mmc_init(), and
>>> mmc_init() calls optee_rpmb_available(), which opens a session to
>>> device.pta (PTA_CMD_GET_DEVICES_RPMB) on OP-TEE's thread 1. device.pta
>>> runs tee_rpmb_reinit() and blocks on rpmb_mutex, held by thread 0, which
>>> is itself waiting for the RPC to return. Thread 1 then tries to sleep via
>>> the notification interface, U-Boot answers TEE_ERROR_NOT_IMPLEMENTED, and
>>> it spins (about a million iterations in the three minutes I let it run).
>>>
>>> Your StMM test does not hit it because the eMMC is already initialised by
>>> the time StMM uses RPMB: the EFI subsystem probes the block devices before
>>> the variable store comes up, and an environment on MMC or any earlier
>>> "mmc" command has the same effect. The announcement then runs from a
>>> normal context, and the later RPC finds an initialised card.
>>>
>>>>
>>>>> Track whether a supplicant RPC is being serviced and skip the
>>>>> announcement in that case: OP-TEE is using the RPMB already.
>>>>>
>>>>> Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
>>>>> ---
>>>>>  drivers/tee/optee/core.c          | 3 +++
>>>>>  drivers/tee/optee/optee_private.h | 2 ++
>>>>>  drivers/tee/optee/rpmb.c          | 9 +++++++++
>>>>>  3 files changed, 14 insertions(+)
>>>>>
>>>>> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
>>>>> index a47c76811cd..b61f907a3ff 100644
>>>>> --- a/drivers/tee/optee/core.c
>>>>> +++ b/drivers/tee/optee/core.c
>>>>> @@ -424,6 +424,7 @@ static int from_msg_param(struct tee_param *params, uint num_params,
>>>>>  static void handle_rpc(struct udevice *dev, struct rpc_param *param,
>>>>>                      void *page_list)
>>>>>  {
>>>>> +     struct optee_private *priv = dev_get_priv(dev);
>>>>>       struct tee_shm *shm;
>>>>>
>>>>>       switch (OPTEE_SMC_RETURN_GET_RPC_FUNC(param->a0)) {
>>>>> @@ -450,7 +451,9 @@ static void handle_rpc(struct udevice *dev, struct rpc_param *param,
>>>>>               break;
>>>>>       case OPTEE_SMC_RPC_FUNC_CMD:
>>>>>               shm = reg_pair_to_ptr(param->a1, param->a2);
>>>>> +             priv->in_supplicant++;
>>>>>               optee_suppl_cmd(dev, shm, page_list);
>>>>> +             priv->in_supplicant--;
>>>>
>>>> Wouldn't it be enough to track this from rpmb_process_request? The
>>>> nesting issue is limited to RPMB requests, isn't it?
>>>
>>> The deadlock is, yes: only the RPMB request is issued with rpmb_mutex
>>> held. I put the counter around the whole supplicant command because
>>> announcing RPMB from inside any RPC is pointless (OP-TEE is already
>>> running and will probe the device when it needs it), and because a nested
>>> session from an RPC occupies a second OP-TEE thread, which fails outright
>>> on a build with CFG_NUM_THREADS=1. A request that is not RPMB can also end
>>> up in mmc_init(): a LOAD_TA request served from a filesystem on the eMMC
>>> does exactly that, which I have in a follow-up. But I have no strong
>>> opinion; if you prefer the narrower scope I will move it into
>>> optee_suppl_cmd_rpmb() for v2.
>>>
>>
>> If not only RPMB requests could actually trigger this, then having it
>> over all commands is fine. I was just wondering where to place it best,
>> here or in some of the invoked functions.
>>
>> But looking at optee_suppl_cmd(), though, I guess optee_suppl_cmd_rpmb()
>> is really the only one, no? At least it would look a bit nicer to do the
>> state tracing inside optee_suppl_cmd.
> 
> Agreed, optee_suppl_cmd() is the better place. I will move it there in
> v2, together with the local variable in optee_rpmb_available().
> 
>>
>> But if you have more requests on the list, I wonder how that will fit
>> into the picture. Maybe you can share the full set of changes to get the
>> full picture as well?
> 
> the whole tree is here, on top of next:
> [1] https://github.com/igoropaniuk/u-boot/tree/android-avb
> 
> It fills in what the AVB and A/B implementation in U-Boot is still
> missing to be usable in production as is: the device lock state and
> root key provisioning, verifying the boot images in the buffers they
> are booted from, init_boot and dtbo, the managed dm-verity mode,
> rollback index updates once a slot is known good, loading TAs on request
> etc. Everything has been tested on QEMU virt with OP-TEE and the Cuttlefish
> Android images to the point where Android reaches boot_completed with the device
> locked, and it is being split into series for the list.
> 
> The request that matters for this discussion is
> OPTEE_MSG_RPC_CMD_LOAD_TA, U-Boot serving TA binaries from a FIT image
> in memory or from a filesystem so that a TA (the AVB TA in my case)
> does not have to be an early TA baked into the OP-TEE image:
> 
> [2] https://github.com/igoropaniuk/u-boot/commit/2029a3bd16641668ed37bd19d7a0f0570ba795c6
> ("optee: load Trusted Applications on request from OP-TEE")
> 
> When the filesystem source sits on the eMMC, that request is the first
> mmc_init() too. There is no RPMB mutex involved in that path, so it
> would not deadlock, but it would still open a nested session from
> inside an RPC, which is pointless and fails outright with
> CFG_NUM_THREADS=1. That is why I would like the tracking to cover every
> supplicant command.

Understood and agreed.

> 
>>
>> And what does the Linux kernel do to prevent such deadlocks?
> 
> It never announces from inside an RPC. The RPMB device is created by the
> MMC core at probe time, long before any TEE client runs, and the OP-TEE
> driver reacts to it through an rpmb class interface notifier that
> schedules optee_bus_scan_rpmb() on a workqueue (drivers/tee/optee/core.c),
> so PTA_CMD_GET_DEVICES_RPMB is issued from its own kernel thread.
> 
> The RPMB requests themselves are served either by the in-kernel RPMB routing
> or by tee-supplicant in the user space, both separate contexts from the
> caller. And Linux implements the notification interface, so an OP-TEE
> thread waiting for a mutex is put to sleep instead of spinning on
> TEE_ERROR_NOT_IMPLEMENTED as it does with U-Boot.
> 
> U-Boot obviously has none of that: a single thread serves the RPC synchronously,
> hence the explicit check.
> 

Makes sense, thanks for explaining.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
