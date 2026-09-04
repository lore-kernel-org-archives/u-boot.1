Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A79BC624DE
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 08:10:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8E01540B78;
	Fri,  4 Sep 2026 08:10:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d23rUEdetsBg; Fri,  4 Sep 2026 08:10:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A589340873
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788509433;
	b=eVn0qLxYkY0lAXRXLtak5h8TwOQxK1Pjjw9VyqQzzlNypztD3PAjTIGKh0+KOdrOeHIZ
	 H9Zpr/Br990gUgAcoRymXSFk9xYylAsRnIzc6NngHOYPzcR2ez7PDrpLRHXkk69culm95
	 lfO5SlxEU3qg2evSAsCSfMJLhyOwaJX0YFau6FWp9S3TWFqZTaxgs9EMdzRzX6fyihL5v
	 qzaoqTQ3BvQuKg6BMNI+S2SZctMh9e/CqOuVc1tyxkSZNqQUf7ZqTFHv4DuplwzhJ7bJ4
	 AHcbqpHpmWLDvNbuveMG8nQfzaTcvoxbJKengs1chB/NNkSqDDcqhil3nWDf5Fhe3pA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788509433;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=twMAVvjZPqDnUTSY2/nY0CfCH2on7m334SyMSIuO5YM=;
	b=UGOEuOMhHCe5nxckx7sTIvPK4waruZelyXu2AztN3SddcPkPz45pXEBHaLKVOyIlaE1s
	 e4E+e8EDWm35anxGlaQIWQhIL9vcoxe3f+OJDer99q3wsLWOgg8eEruu0cmw7s+P5RD8i
	 KQU4ht0uk8xLjr2sr6x9tJEp4OlcdXM5g1jlZtPKIV6Vdouew0HQJv97KRPdkrDhjTE21
	 duj2LEp3G5EoOQGxoBecGZ4Q72I7EXmrh++PAQrqIg10fzjlNLnu+R8srI1uOainWoZfE
	 8u/cv9qHOh9TROC7QoKy+n6aNjSmiOxYmhLw4kit6CBZ+IprbL+ITvJfgy6l/gx/jzg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788509433;
	bh=twMAVvjZPqDnUTSY2/nY0CfCH2on7m334SyMSIuO5YM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KPvcFFiVZ8VQ/N0r8cqKTOJx/Yx39M9o7aZWKb1x0UouyfndBRgcesguKI+woohJa
	 Aq3+s9WHil00zinZKkXNpsnNa4MClwvTQooCPwYc2/oswFEV17VuEb4D3c0XzVv0zw
	 +z2SvHKYbKJrVJ+o9C2AeaH0Kx8ac+fAnUgeLAHhA6sz3vQzRIXdgH8KjbxWeh4UUn
	 8M/XMBAcF4KOZwmzG1jIod+BnE235QaY2GDFKYOulP4nCn52JGJgRwiVBQtZqvWWw2
	 zyALqPjoxyPiDCR15Gsljwq5S4pICFW0VshYZYNIYZZHuHh/5xObO+foJTIuwR5s8j
	 tGTCV6cMjeN2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A589340873;
	Fri,  4 Sep 2026 08:10:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A0C5C3AF
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:10:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 86705810E2
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:10:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZYd0ANBFPhoO for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 08:10:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CCEA48114C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788509431;
 b=lU0hQVSPjScyLAZY7dc7AiQlde6B8fID7EqnHK0952p1GXt7JNn+beCjm17/1LiOm6Gq
 2QWNlKnUKaesNaSXHGUJyY+5/jnonVdADnlR4fJXd+EG/NeSLCFlCXYV1GwcE5oMb4eiu
 5sdPpABX2/rCl+qgTfAZUTzFb1VrVaO8ZCrNw47JgDgbJmZTxAvX3N6GhDlSXvRfdTWH7
 dxT2GCeEU8Arb+ZkvkKzRG50pABEousi02Tb3VJoTM/uNuhVONUWFPE0YFQkopLj2mvQG
 Rm/dvYCv4urksnFsw88RDq9Do7V/3yibJuNMm+2Nk8Aw1ICsdvDkAKW6re5yKJvRKtA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788509431;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:
 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=twMAVvjZPqDnUTSY2/nY0CfCH2on7m334SyMSIuO5YM=;
 b=VIbTYjTtAqd7sefJyeSbSRDxWkLzPWGzpYSv89s6C5wWynam3Nb2JKt87hL0UnwER3Q2
 VF5ZJzeavKCqZg4ubADhuwRi6iytyPvLltc0noLeQ0tkoi6c3oDepoC3VparwgSdYkPW3
 3mKO33WRgWZzWGrC0wBgV9iOmfzR8BcJJZqGE9VxKvy3ECjUmWBEe38sJBt41O938janS
 4gIiW9hdLJoOF29hKVxvncf0WPPLmtuAUFmaaFEM1g5reK9OAxErm0273ZmhRXsveJBdL
 HyzsFNqWCKzZes5843oiaN5eAFRmwTganxiaPHDKd7bWxtGTnUGCuLQxuyi774cwIlQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=none header.from=softathome.com; 
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=SUEMHsfd; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:c20a::;
 helo=pa5p264cu001.outbound.protection.outlook.com;
 envelope-from=philippe.reynes@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=SUEMHsfd
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CCEA48114C
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:10:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8XkJNJCEe4qzS5nruEd3lhASyuAwLDMHKkRg9VT7X/Q4fnJsVw8TG0DpRLd+R6l9xrjTtZXrr3POHZxkOkORhQrqtri/6q1T+fjM9FZhDfrqn0OrpUuIS1Kyk465VmSyfTv8kUaorWKIp8YBUXGAYE/01Kvim8FFtil+Mrti9LeHyGAULaHjnzqVBwNUV+lxEa9qco+w7aue5XjV6SM5QxFdq5afoLn+UuMmn8L2E4fGgWPjWU3xl0osIJbeNkV1AJ63KDa0CgrStvjpdq5ttCwrl3yx2cOh5wdV/E82pvVQrHrvVUE5Nx9BfRgTiNSN4YvksS27/Py+RMU0ZvojQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twMAVvjZPqDnUTSY2/nY0CfCH2on7m334SyMSIuO5YM=;
 b=KezvmdnRvWEXWh3M0lg5l6tXMfCg7GepqTEPvCBYfAyxh71l4N9gCknMy/51t0QnwpsN2Ifhlx4wXYJaClg/YhhPhPAbBE1/caAJwwtuVVXxmvmqmcWOET3lAf6I+cWy2VsedfBVcr1ZvhC1KwFYVIP/Ynu7QvWBaOq9MbM3T0jK3IFDjyB8RYYI8pOA+JsZS5fPMUa07Hi4lWX3HzPAKO8mwUCRWZnHVfODXRDvEk26fIf1YMaaiw6Sly/5GumK2H+AmaNGmqTYCy0EwwMpZek1//MFX6jUEKZPq8dX2IDJsBfVT2w2s5h+amW5INBOYeoeKl++3QKReQ52KFAYCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softathome.com; dmarc=pass action=none
 header.from=softathome.com; dkim=pass header.d=softathome.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twMAVvjZPqDnUTSY2/nY0CfCH2on7m334SyMSIuO5YM=;
 b=SUEMHsfdtmKTmLuWq//U8+/n/lgweQQ4gTJ/GRLYLA274p2IkHOyz6OAyfzzVKcsVpQ3v7EGTM5wIKLOD67E5X10YrnKNp+zmS3Bt3trrX8maakpOH0wIV6sO0foTJc8jyGufN/WaHL1s+BY0wXFm3x8/Wchzxu9gnEBazLjpxgyJrpbWcYMOb7CzaRHKwjAiQTVka/5PLnwLhrPn31Dm33HTC/t79ZVBKndnEtV1eKdHmivyuuRtGig6UJQOeIO5xd2DibxIBAPBWvjK38jcSLe24WGqDPc7KJKjus6gX/GKSaioLxu7S7E+DEG3YJ8WhOS2K7zgu/26cV+36T/bA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softathome.com;
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d0::9)
 by PR0P264MB2952.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 08:10:25 +0000
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6e14:438b:5c18:8557]) by PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6e14:438b:5c18:8557%5]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 08:10:25 +0000
Message-ID: <9c0d700d-04f3-4ad0-9453-bae0dbe6e471@softathome.com>
Date: Fri, 4 Sep 2026 10:10:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/15] add software ecdsa support
To: Tom Rini <trini@konsulko.com>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 simon.glass@canonical.com, u-boot@lists.u-boot-project.org
References: <20260903081705.12894-1-philippe.reynes@softathome.com>
 <20260903183521.GL1764417@bill-the-cat>
Content-Language: en-US
From: Philippe Reynes <philippe.reynes@softathome.com>
In-Reply-To: <20260903183521.GL1764417@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0206.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36d::12) To PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1d0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB2741:EE_|PR0P264MB2952:EE_
X-MS-Office365-Filtering-Correlation-Id: fc158c8a-0989-439b-07c2-08df0a5bf91b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|10070799003|366016|6133799003|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: UsiJSLuwnQbcVAwfIk6Ey7PjTozuYJry//HG7bwyOSjIwv5EZ63zI0btgUE2q9SBkfWq9PtfQ2SYTNw+9QHrZ1ApIC+gXpkOe7hW1d9NwhP8q+CvwrpbxPGd9gsvflTSBaGJNyffNOZ+0AIW+KqVCAeOYrKFfb1ZbDJOmZhtuIcXWAIDuFD9+2i0cls+rP5hZVEDtXuqv86rHEaTRkUlBsVDs4rjLS15Cbd3JxkCDSGYaaIiBrcX8y0/AdOAMB5V6J5NYhisN+YooteT5Ui+bo+QH/iGKGblGYfEe8dRH21va6NJU+2Oi5pBxbmDhT/9FCHKmQPt5iiV/xA10cmfNiJB+I+kw6lRextRVNBMQLdNx9vLBQOK/6Kiu4onPiEBX/hJgREArGM9axZk1iqdvTS+X8LB/CkTjjOP8k771SMDM6UO9bLjD2H22qufahJ+LecAKnHAIcnSkPhDGHxf0QS5eCN5s9DPGreeAkTLj8tEeVHv5pqlrhjOBvATBQF6K6I8+XVuwX1bThzKE/wmPzQLRkfXHziwktXBhZhXJgqMDKAFjUlElmAJ5LlcI6bcA1ijcOouqCpig7VnPzcXLqdYlZ+wi3LQUIPjy5aPGWdQTKnN2X6CNRw3x1Jg9WvJYt6txPbbx47MqB70UQydz0muLXAKAVwSR0DuQ1kPpOw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(10070799003)(366016)(6133799003)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2hyaVdGaVhhd1ZMVXlSamV1d2gzRUgxeFErdk1GNDl4WWttcE9QSmdmRGVV?=
 =?utf-8?B?TVBMMzU5YVN0NnR3WENHV2R6RUZJTHFqb3A2YmFaVk8yc3QxVDY2bGlvelpC?=
 =?utf-8?B?cStjUlErd3ZNcE1pLytOWm13MzV6UW1wZGJoUGQwbjRiK2UvZk15STRibWNp?=
 =?utf-8?B?MzBJQ2JUVU9oVVJFMGplL0w5WXZpVlo5dXNkYUlrMDBScXJHYWNEdjBTY3hw?=
 =?utf-8?B?RUhISDRIMnVrczI5LytqTU4vSVJLZXpFUXBaZ3h3SEJHR1R4c21xTDZMU2hW?=
 =?utf-8?B?Rjh3b2J4UWJmVkZXZ1VpSklXY0x4cVB6SlJSampVWFJOY01yNnQvdEF6S2xY?=
 =?utf-8?B?eXZVVnJBZEMwUTNlUGROdVJOTWJNbWZOS2lFbU9SNmdtbjJ4VlVsWSticFc5?=
 =?utf-8?B?TEExTVovQkdSZlVneUxZTzZYYnN0Z0RkUWw5UnJZNE9nblhrTlg5YjF0c3Bo?=
 =?utf-8?B?VlVQMUdQVGx6SzY5MTFnSHJhMGwxSFB2ZWJqam9RVXpReGJEak9zMmVVMWNG?=
 =?utf-8?B?bVlnSFBsbTlMenFHeWRUSUVUTWtNR0RvbHhwLzJFMkhJYnFtVm9zSEdod1ZL?=
 =?utf-8?B?L3JpNkxSZ3dWL3ZXdmpDNkM1elNUNmxXQWJSNTNPcHpNV3l0VXF6RVpHbDNK?=
 =?utf-8?B?TXdNUDNzWFJ1emljM3Z6cmhNczJDZ1Nrdlo2dWFBTEF2dFNKaUdQRW9NZHVY?=
 =?utf-8?B?ZnEwdVNHSzhkclozRW5DREd0RlJOU29wNUJhbzNoampwVkRYbTlGbVJDMVE4?=
 =?utf-8?B?akR5UnNQNHJuMjNicTFsend5cCtNeWJyY00xSnpEWlJsNGhVK1EvNndUa0th?=
 =?utf-8?B?dlZPRllWRTFpbUJsYU80empXbGowaUlra2lZNWN4VDZrUjExNG9ET0M2N1lG?=
 =?utf-8?B?ZElCRUR2RFI3dENKeWtVR3hBVkFaRFlRRlV3czM5WGJRVU5tMnNybVJlQmVi?=
 =?utf-8?B?NVFyU3lSQnNZWW16Q09BY3gvMHFKc0trdzZqbnlFZlRlVk8vSkxYcmltNUpZ?=
 =?utf-8?B?dEZwZlByRVJua0pTQ0FrWnJ4VGpaTm9nNWZqRG9pOFZCNHBFRHVHSkE1Ni9K?=
 =?utf-8?B?dUlqMFlkbDlENWYxN0tuTGlKcDVFMWVwOWIwZVZGaFUrZ3hKSUo0YkZMUmEz?=
 =?utf-8?B?Zk1SbVpjektDS3E4T3pBOWNzY1d2elpFNUZWdFZaeXhoZDdhVHJuMy9SaE5h?=
 =?utf-8?B?TUl1T3F4TXE0YmlNem9BbHhqeHYzUnh5dmhBb2pWc0x0d1crM0lydXJ0dFAy?=
 =?utf-8?B?eGJ5eVFmZnJzdkswd3l0MzJKT2RYTm9uQlBYcTlUU1E4L3dMVVZURWhuRzl1?=
 =?utf-8?B?OEl0WGxhU3RlbWxQUXRSNW1OcFh3aFBEVTlXM21BNE8xQUdjQi9IM2RDR29N?=
 =?utf-8?B?eWVISWF2d3F0WTh1eXUvS2xZVWd3RWhvRENYdFcwblI2RDB5OHlOTFB2U2Vh?=
 =?utf-8?B?Rm9yN25md3NtUDE5TCtlREVjRUtVSm1PRzZ5ZVU5T0xGUkhZMzN0VDMyNWF6?=
 =?utf-8?B?emg3UzdlR0ZoV21KTGZZMFM2MkkyY0VrOHQ4Q3NkYlB0MlQzUG52KzBaM2dq?=
 =?utf-8?B?WUlWTGRGRWtsVEdzMDNBek1NakdDYWcrZXFRSytFa21MNTZVSWQrMTFNWnRB?=
 =?utf-8?B?MFFlTW10ckFtdllyQ25qeVdlbU54Ynk3Qy96Vm16eHluckRmVGJBK29CSEpz?=
 =?utf-8?B?NEhkUHdGcWY4cWduOHFybmt3dmZYbG9KWEtZenEyNUUxSXdpcDEzaHJmbFBk?=
 =?utf-8?B?ZEwxZTBpZ2p0K0tJUWxZRCtUVUN5N1Fpd1NWalhTNlluUDRXYkZwUHh0KzU3?=
 =?utf-8?B?TzFmKytsSlZtK3EwRUNhSGtLYjRqSU05NVozQllsM0oyT0NUaUhUc3VGb1NT?=
 =?utf-8?B?VjJCd1MyUTZFRVorY2xaODhFT2w0YUdJNERWVVYwVnVCRGdvMWREZnl2N3M3?=
 =?utf-8?B?OGxFdmxyS0FDK2pYa3p6eXhJaGZBOUhEWUpBV041b01WekN3dWpQSUY5cG81?=
 =?utf-8?B?QmI5RmwwMVk2QnVVbVAxQ3lKb1FHY0RPWEdiNGVUMVRZalBTU2czT2Z5Q3p4?=
 =?utf-8?B?L1VSSktSc1VkT01QOHkvdFdWTFdabkNMejFpN3BXclBoMStQVHk2NmFqeUo1?=
 =?utf-8?B?RnNMbUpXM0Q4YlNBQk1iY3RrVFdpL0hZRy9ZSHJmN1pTMlQ3OXpLNUUrVlVQ?=
 =?utf-8?B?SWQxN0ordHhyV0RGQml2YVhrWk1GWTRHYjlnQmw2NW8wVFYybnErenZFTXdW?=
 =?utf-8?B?WHBtaUdoR2VKRzIvdDUvajFuUTQxRXozM1lJVXZOOFg5aDFPMWV4VWc5Z2FU?=
 =?utf-8?B?Q21ieFpHOW9kdWtScFMxZzdjZ3FPQzNFQnhWcDIwMXQ5UlBrVWwrZTh0eWFX?=
 =?utf-8?Q?aoGymVi2Jrziu2FroX1s8aQlNS6kVLqdvAWsu58VkXwLt?=
X-MS-Exchange-AntiSpam-MessageData-1: tsWswHOcidSLaH/sog6kshlPK/w98M5H4xU=
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc158c8a-0989-439b-07c2-08df0a5bf91b
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 08:10:24.9331 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8QrHUpUfqVHc4FTYiI1swRR3ytEaNsHEQ1iaI0ReMms0PI9Fj28Yuryg47PJrnAASxqnlMLSXnIPFrrGWgIeEmsIzogWFK/5RY993IFcznU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2952
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

Hi Tom,

Le 03/09/2026 à 20:35, Tom Rini a écrit :
> On Thu, Sep 03, 2026 at 10:16:50AM +0200, Philippe Reynes wrote:
>
>> This series adds the support of ecdsa with software
>> using mbedtls. So boards without ecdsa hardware may
>> also use signature with ecdsa.
>>
>> To achieve this goal, several changes are done:
>> - fix the support of secp521r1
>> - enable support of ecdsa in mbedtls
>> - add software ecdsa signature check using mbedtls
>> - add support of ecdsa for internal fit signature
>> - add test for ecdsa for internal fit signature in vboot
>> - add support of ecdsa for pre-load signature
>> - add test for ecdsa for pre-load signature in vboot
>> - enable software ecdsa signature check in sandbox
> OK, so it's enabled on sandbox.
>
>> To test this new feature, just follow those steps:
>>
>> 0) build u-boot using sandbox_defconfig and adding those options:
>>
>> CONFIG_ECDSA_MBEDTLS=y
>> CONFIG_ECDSA_VERIFY_MBEDTLS=y
>> CONFIG_ECDSA=y
>> CONFIG_ECDSA_VERIFY=y
>>
>> 1) add a signature node to an its file
>> 	signature-256 {
>> 		algo = "sha256,ecdsa256";
>> 		key-name-hint = "private-key-256";
>> 	};
>>
>> 2) generate an ecdsa key
>> openssl ecparam -name prime256v1 -genkey -noout -out private-key-256.pem
>>
>> 3) create the itb file
>> ./tools/mkimage -f <file.its> -k . -K arch/sandbox/dts/test.dtb <file.itb>
>>
>> 4) launch sandbox u-boot
>>
>> ./u-boot -d arch/sandbox/dts/test.dtb
>>
>> 5) on sandbox u-boot prompt, load the itb and launch bootm on it
>>
>> => host load hostfs - 1000000 uboot-ecdsa.itb
>> 4628674 bytes read in 1 ms (4.3 GiB/s)
>> => bootm 1000000
>> ...
>> ...
>>     Verifying Hash Integrity ... sha256,ecdsa256:private-key-256+ OK
> Does this mean the new tests aren't run automatically?
The tests for software ecdsa are added in vboot, so they are run 
automatically.
Ecdsa signature in fit and ecdsa signature in pre-load header are tested.
This last paragraph was for human being, to explain how to use it. Sorry if
this adds confusion.

Best regards,
Philippe

