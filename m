Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F24F0C79FAD
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 09:43:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 20872606B6;
	Tue,  8 Sep 2026 09:43:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EndOxCEgzgSP; Tue,  8 Sep 2026 09:43:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1CAA660640
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788860616;
	b=JHSF5/JbyElvpw3vsImvYGyaO60W56hehJ9/3OtvjiaeorKS4Y7p0NMgRGBcL+MJ3cfc
	 Lh7SIXxxKXSZn7ifIsFnwuAbC0xTwgWzNqD29fAgjkaxUkbhH8eDC/lxgJJ4WPuYuYujq
	 kMMetKk3EwmCSUEJE0iZZLwJDNC79lDeugc3zZRJqjM1jU5jxs0SrHTRSDjyBv3YA5mcr
	 90Ds9FEw5aTrBUQaa12n6ZY13xtrwG6VNn6f31aUdGdS9d/Jjb+xPkry8DV5ApIqDFPOx
	 ZNvbpV3tNsQYewVe0s14v6OoAaSIqFkAyi+CG6vkkCy4bW8xMM7qLrjdBi8SbbcBL7w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788860616;
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
	bh=8llnUmVOSkGRf6TCcpIIPPZkGqY3vq5Ve8rWch0gN8g=;
	b=PAxnYEPOz25Qlc3C6PR9r3S6oj474tMAGsL0xh4OvwxtmBLGf99tIjAouTwwvXGvmmqs
	 x+lnmo/L4MIIRUXIcGS43W7GzAInaKkspamPvJwmHXrIcacFv1Kcq97VbBsUpZPUV2EiQ
	 Jd/rkkQAyThBMaVbRizorQSE9/hiF3+3Xi4pL4Zu5Ab2vZ7sqzbvankdJ4fKdyZFrHkPB
	 ZO71+xlzIBx8WizCMi3vwqh+ptiJoZe6b2k9N4GQ06YR1rJLn9K42Y01iqZs1Jwsq3iPh
	 ann5FOyKynyKr/MtlnLiOXZFyxubJ95Vqyphtlq+LZYrVxCI1tPKkm4HUhbCoNZ+dOQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788860616;
	bh=8llnUmVOSkGRf6TCcpIIPPZkGqY3vq5Ve8rWch0gN8g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mfWN9+4dS+ewK1RnYe0B16qjx/0i8TI4hno22pi/mZJ2MWlPROIyEqQXARNEJwjPp
	 U0hTOZFpEqxQ8+/zQJYg4lk2L+nMGgoQOKstc5MoZaGkR7G8hKOSBo1Tgnsue/96Fy
	 p8bLxE6FUpNAsD48YdYAG+4uS0PtsOd30kapNG39kLnroGzrQ7AMmt2nVrXKdCoArI
	 1gELvDnAAm0Boalzkrc3cpx7jxZdC3KhNMYQ9mZwO7+/lsyKyMPdSFGhSVrdlYjVNu
	 UkybJfOZN0VGlGtYHVNg6raGiudgZeXQWZrbrv8wM41kHBEgWUBMWphm8d+OPxhNzg
	 iScVZBqvflMcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1CAA660640;
	Tue,  8 Sep 2026 09:43:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EC884D90
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 09:43:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D26F540063
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 09:43:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TpIYGPBSx8-y for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 09:43:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 431174002B
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::6"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788860613;
 b=exykXtrLvNUIau3kuW5YxSftdeQDjgYHCQPKlsNu7goaNvjrwnoj6oT24/QKobN5hjNn
 x4cRDlMxt2JdGmB12IX2lZsJwbxvZ8fNL5yxVprU8zSRfBmpMyJtH6byJu3/4Mfv26JCY
 w4E9DrAHSrfKR9ihsPrWnQBJ13ixf45trDFCBz0quV+oM95/64zz23BBwAcMEJEPzml9g
 2y8reqwuk/o2BGFTd4I5m/zwiYXKMPCm/kyTfmVUJR7pF88TbtCeAjebs3WjUG909rDxc
 vVN86v5MSTotaDvOs79zBHnWWgiVL9jF4ZlBafvxgy1ZSH5sWQqIW8KyCXTffVt9fnQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788860613;
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
 bh=8llnUmVOSkGRf6TCcpIIPPZkGqY3vq5Ve8rWch0gN8g=;
 b=IkmGTWCDdlQ/tE6LsNusqT6xSaGXkXRKASPFiyzdVtk4xfZuT2rOhFvVR9EZNGk3+asM
 gZvkM0yClGz/YnyPnqN+jy39gRte4DUdvrcvZfbAI0OLuVZXiwb1eA0lKYx5ptCZmlY1S
 eFmVlGGi8L3kOjGWKnhBgSSfMGa3XbtlquzK0paJw+Sx7ZU5IhPbmxYKu1uriOtIAlnMc
 tqelBb8rIkuitMN6Hx8mLJdBRmDaB4mGYeoUJtnHjwHrwgzMqZHrruyP4F59Z8hgbByco
 LIL473W01RQRkBkz9B2AvxgFsqqAgT1SewPwhY4Txrrhtw4agol3kb2slo4PYK/4jAQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=dLmBTKSl; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=jan.kiszka@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=dLmBTKSl
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 431174002B
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 09:43:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oz91/uui5rWbwIuovrkqHUl8lOcdy+OcwtRR+juN/gqOHMETnNzkYFZjokN8aZOgCKtSgXa83bQWkBaEF/yh5wyfVlESWGc8cER25sdmMeqzrc+vnpfKA9itKTuWTFpaJvfyXamR2qe7c98lv1UA0hT0FZwAJsL0SYa5Ouy6n7VQG5HaffjPC17BY+BqWsSXTvH4R6ZZWyXsZugjsHshvewAUQ51OoTDt9nUtm5/9GnmqTQ+h34DqQkCLul6ccffJQnqX1mClI+BkkrLMAj0z5unNCrLqvz8jv4S319btiHbaLqyhQghktVL2qhDKpoQdAQPoJDP394EnjdOWklNuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8llnUmVOSkGRf6TCcpIIPPZkGqY3vq5Ve8rWch0gN8g=;
 b=dTi6jhjYHW9NL92SdSlPNl7346YtDHuNZAppb1W19v4ZXbl3LEeOmFe+7jgpiGKqnhObMFCuao2BU4L25b9Dmi3hNo1U93E0UlpITNpny9p1upd9IP/E759lYfpLq/oowkrzPsTJU160+a0tsinJu5svzn5q/lMqWqfIPWEKm57B6gTaVCIPyVvBkGDvD9h/QunvE0Xo6AeoFtiZDNNj3QubOfdg0P/QqPrNuAnyEyAZ5VulrFmQcX1hMioUsXkJ6c1A1CKcsVtJLUygEOvqIdp9TmD/iPLypVFlAY4IlUpsweVerVLlq/3jArnW2ctADf2iuj4khWGS0WhicMmG1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8llnUmVOSkGRf6TCcpIIPPZkGqY3vq5Ve8rWch0gN8g=;
 b=dLmBTKSl//DE4iyai6I/cRvYMYb1xi10fUj4VvEVS+2780DnyNKelmO7hLyu/knK4VCcdA3+XBnlivkzPPu/Pq/imEcCIz7pkAl6gAV6yjP+74Zy8iLSO5bJSk/wY8zMNbw1PeaSOmAz4B933Q+hSim2c+IXkD8ebF7J0Q45rPlWjrZRVvX6qgZH4nsZo2tQ3ewL+i2uYXg2t7C8KwbWwLsWxMdzow8etH6T/FOLqvHQALeZI+not53mcJb23BibutPoO543U3otza60LivHCUvlY/ND7bjT12AK3MwdRMuVu3jsxx9sBWUs/6B4vuUEf+YzpcxlWlBMhJJKKR3suQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3851.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 09:43:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 09:43:24 +0000
Message-ID: <60f664a8-df8b-4c58-a7b6-fbc5f245ceb0@siemens.com>
Date: Tue, 8 Sep 2026 11:43:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] optee: Add support for enumerating RPMB-dependent
 services
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
References: <cover.1787514446.git.jan.kiszka@siemens.com>
 <CAC_iWjK+o0Udb6mSkfCPr-CAF+A+A-gDMC+BZ3xr4U_FMqVftQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAC_iWjK+o0Udb6mSkfCPr-CAF+A+A-gDMC+BZ3xr4U_FMqVftQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0344.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3851:EE_
X-MS-Office365-Filtering-Correlation-Id: 645bb5de-25b6-4c6e-08e3-08df0d8da05d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|6133799003|3023799007|10067099003|4143699003|5023799004|56012099006|11063799006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: KlSSoOfpxdeIV4KMnhbfrLI/7U4qDzvMuWkdsxCqlArRvg+kYYUlY/afsgoQBTDx+FJLOfFFwQbzFlFPAyDEF7TDwQAWe8WQoLIshT2xh9VxujZjIenSzWhZMfYujbbBHp0UFPASaUQy+i9lq9hBS9vzu3d7UUu8rSEHhpevs4Vuait/Re9arDihmTg9tq7eUSX8VehBluH3TpfAhdeV90ZvUZKLvdqyqchcaSmIJhcB970Jk8BUswWCcTcD3A95fN0zbJuHnzvy6WnPzXiiD840s0Ykv327cEzpEnxzyhbqCzLhHMkLzEOnGUMkeFW1DUBxFVGoBkPsA3ijT50kjceDuxaO+tjv5HggjluukcTwbMb5kiZpYelIcpQstJMB5xXupTHH3q+mCaUI2WZzdqu3z/HGC/yRaRvDazmt+Ib6KsX4kCntt2TlAbxdXpTYVh6Cl6VZzaooUppC9ushXw91MYqZSsLV7pHuMGRaMJsoXv/n21LipiywRul6Rf4AHuFTmN8OAd68sufqf747rVY4PowoDSVS8FkNhJfnNtdp9MLxMwWH8eugLA1FD017Aza/y2VcUXPRx1nwzMWkOn7XtDZm659Udwo1ILQaz4gkaMqixyZ/rYKJYKeY+BRr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(3023799007)(10067099003)(4143699003)(5023799004)(56012099006)(11063799006)(22082099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHFyeTFDU0tSK0pNdGh6dEVZeFVLUWwvaFVuc2huOVVVd3ZRb0wxRmlWc3BR?=
 =?utf-8?B?LzMrOVFmTG5RZWVLVmJoRnR6aXF4bGYvcXQ4THJlYnQzc3VzaUFkUk9UVmxv?=
 =?utf-8?B?dC8wbGwrNlBLdkNweEtaQXg2SU1OMFcyQkx1aStqY2RtcWprNXAxcERhZExU?=
 =?utf-8?B?U2tHTHBqbWl2NGdSTVpUSGJKQlNFRG1zazc4R2VDYU9xL1lqVEp5RldOR0xH?=
 =?utf-8?B?S0Z1VnJsWWE1MjE4UWZXSHBmUENya0s0YmtsNE1pOFdjWForckpkY1dveUdv?=
 =?utf-8?B?a1gwQnpxN0N2MWVpOXZudnN2TE54bGFadG90Rm9OdERQWUpEUUdCWnNSdHhs?=
 =?utf-8?B?T3RwYkk4V3ZoMlZMWUFNZlF0Z3NYb3BlTEtnbWJwN05ZdXB5TWRoWTZsK0Rp?=
 =?utf-8?B?ay82L2xUUS9zTWlXempyakpJOFpjem9FOGkzM3FKVFBUY2wzQVl3cGtaVllO?=
 =?utf-8?B?SnNVN0MrWDRZcTdwNjNxbWxMNXNlbndEc3NSSVVpLzk4b0EwL0FnbXdVNzl0?=
 =?utf-8?B?MWNic0ZSVmRlTTJFdVh0U0ZjMUNldi9laFF6VFBiaVBuT0RYNHpIbHNUZjZH?=
 =?utf-8?B?R0ozQ0xEZlFLUnF3YmdyL3dPU09Ec29kSlczNG0yZC84dzcwU3lIOFZyNzRz?=
 =?utf-8?B?cGJYSUFvVXUveVF1NzNIVGd2dDdnUjNwUGF2VmRRZmR6S3JZZDZwbHFtNlRI?=
 =?utf-8?B?dGQxOEZCTE9wSkw0cG95YmRodG52a2UxU0R1L3RwR2NrbExVaEJmUDZzbjlP?=
 =?utf-8?B?Y1JLSDRHeUZ0aEY3eExKYkp5TUo4YlYvT1B1eGlSQ1p2Y3JNd1g3VTVkeWg2?=
 =?utf-8?B?Q2lVdHhuWE43RnFNWVZOT0hiTnNXMFZUTGl1S1pIYVRhTVZUd1JnQ05sN2Z6?=
 =?utf-8?B?UkE3SGE2bXhVaGVlQjQyZlZwMXFyY3ZCZ1ArVWlPNzVzSzFieFYvT01td0Jv?=
 =?utf-8?B?QXF2YVl6dmxKRlFiRUk4eWFERmZ3a0NNcTl1aTlaOXIyVEoyY0RVZ2QraXAz?=
 =?utf-8?B?RXR5OGcwOGRJdmNDVi8vQU1JMzlwRkczeEVGQzdEZktNNWRFZ21XQ3NpbGtX?=
 =?utf-8?B?czhZKzluWG92bUFIRGs0c0xDS1N0MjRKaU5rbzA4ZWVMbE54M1NYMUErd3Y0?=
 =?utf-8?B?SElCK2hmUGlrbTBENjZBbzNsbTU2WGU5S1VJcnE4MVVSLzkzd1kvSlJOZkxZ?=
 =?utf-8?B?QzRtRUl5YmorbXBBY0tpYVRmYzBJTExZTWVFeE9BR2dMOXhrNGU0bTFBZC8x?=
 =?utf-8?B?YjNxMlFnY3JjVE5uSmFKSE52SW1NSjdXWXJVNjNVVTJjbkNWWWtQL0lMY1BD?=
 =?utf-8?B?clY4Z3Z4cVVLZWhwcDZnSzZLai9BcndqK2RmenhzOGhZcWtTcnkvamFpb3VX?=
 =?utf-8?B?cTUwOHRzL3lObXBybmNaVmx5Z1BYdmRuMmJ1ak5uSis4VG1YZndkemtyYVNu?=
 =?utf-8?B?VHN3UnkxYmFyY3NVb3h5Y3ZNN1RGbWtQZlBXUE1WRTBrWmgwYldULzBOWVFD?=
 =?utf-8?B?M3pNNFdrTGswWXlwWjkyRU1NdXpxRDl4czI0V1JPSkxuZVhFcFhDQ3ZMU1JY?=
 =?utf-8?B?WHVKa2JUb2JrNDZBVFBwQ2c0U0IyLy9wVVBDdnhHaDBoMFRPMGt1RnZxV3Er?=
 =?utf-8?B?ZDFZOFdraVdtOXcvVUFnU0FKRkpDTlNXR0o4T0Y3WjEvZ2FxM3FwKzhxbDRD?=
 =?utf-8?B?QUFWWDladTZsMVBJSThuQktiZis2cnZid0dNa1piaDh6QmlNbDdkRk9GQi9w?=
 =?utf-8?B?UDA3YXQ0aXdMeGh3cEpPU2tsdlQrTEhpNWhBVkkxT05VcFp4Y2JIOGdwYTRL?=
 =?utf-8?B?V0xIalZJcWxZZEZCWSt6RStQTjlJWS9wRy9YcTk3STNEczhySENwNWdpclA2?=
 =?utf-8?B?SjlBRDlBZEFIWlMway9WU3B2RGQ1cHFiZS91TFlvNCt0aEtvUlpGYmJoQ0VV?=
 =?utf-8?B?SzkxNEYycmxndlVUdVR5V2lSMWFNSzRMeURSQzRXYW52YnBleldIaWZmOENM?=
 =?utf-8?B?Yjg4K09iaE5DbG12aEJ1Z2lWdVhvSmp3aXRwYXdEWGQ1ek5ZUkN1OEtwTUZq?=
 =?utf-8?B?dXE0aFRJU1BheVZBUXJCNDA5dmpyVUlVVHdyczhsTDhWd1Y0ckRmQWZNOWxr?=
 =?utf-8?B?M2FHcVdoWHhXOFBCS0dyemlFbGlsOTRBdGY5UGxZMWpKTEVvdDBJODE0Q25i?=
 =?utf-8?B?TmkwTlFWZTRLNzB3ZWUrdHhOdFF3VnZ5Wkg1UU5wUXFxRHF5U2xCK0k2bXNz?=
 =?utf-8?B?Kzh4SDV5dlBJSXZ2dG4xc29raXMwa0JRRTd1MllsRFprM2tVQ0tyOFBxMWpz?=
 =?utf-8?B?ci92bXRMSnNlZUhsM1hqeTVMbSsydjFWZlRSVE8vT214dk83NDJyTVB3dW9T?=
 =?utf-8?Q?gIni/JEUu/qGoifM=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 645bb5de-25b6-4c6e-08e3-08df0d8da05d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 09:43:24.3394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+KXrsLZN6FTpLho2WeYB9kOGNvDA/7POhVloS9A1gt8huew5N0S/oSuPhiV5GrdZzhHTLbjhwoVwa5vH9HGYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3851
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

On 08.09.26 11:36, Ilias Apalodimas wrote:
> Hi Jan
> 
> The CI [0] complains on this. My guess is it's due to the dev_dbg
> changes, but I haven't found time to look into it. 
> 
> [0] https://git.u-boot-project.org/u-boot/custodians/u-boot-tpm/-/
> pipelines/1208 <https://git.u-boot-project.org/u-boot/custodians/u-boot-
> tpm/-/pipelines/1208>
> 

Yes, looks like (log is cut off, though). Let me sort this our first.

Jan

> Cheers
> /Ilias
> 
> On Sun, 23 Aug 2026 at 22:47, Jan Kiszka <jan.kiszka@siemens.com
> <mailto:jan.kiszka@siemens.com>> wrote:
> 
>     This allows to find firmware TPM again with recent OP-TEE versions,
>     possibly also other services. The StMM service was not affected because
>     it is directly invoked by efi_variable_tee when needed, and that is late
>     enough so that all dependencies are available by then.
> 
>     See patches for further details.
> 
>     Changes in v2:
>      - fix build breakages with disabled CONFIGs
>      - structure code differently between optee core and rpmb
>      - debug() -> dev_dbg()
> 
>     Jan
> 
>     Jan Kiszka (5):
>       tee: optee: Factor out service enumeration and binding functions
>       tee: optee: Add support for enumerating services that only need RPMB
>       tee: optee: Do not warn about TEE_ERROR_STORAGE_NOT_AVAILABLE
>       mmc: Call back to optee after a successful mmc_init
>       mmc: Make "MMC Device not found" a debug output
> 
>      drivers/mmc/mmc-uclass.c          |  2 +-
>      drivers/mmc/mmc.c                 |  4 +++
>      drivers/mmc/mmc_legacy.c          |  2 +-
>      drivers/tee/optee/core.c          | 58 +++++++++++++++----------------
>      drivers/tee/optee/optee_private.h | 24 +++++++++++++
>      drivers/tee/optee/rpmb.c          | 19 ++++++++++
>      include/tee/optee.h               |  6 ++++
>      7 files changed, 83 insertions(+), 32 deletions(-)
> 
>     -- 
>     2.47.3
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
