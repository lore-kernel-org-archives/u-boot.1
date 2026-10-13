Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 237BBCC6B0E
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 06:48:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C0FBC809BB;
	Tue, 13 Oct 2026 06:48:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7nh7jzODC00z; Tue, 13 Oct 2026 06:48:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 156F780A87
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791874091;
	b=J71b/EN7gE7e3pmkx+mMEe2gAkbO2nFuVJuGYjYF4ldMvjEfcR0ELbhJko2XEWFatgkg
	 8Ep9O6Wh9R2PaalHZbsgRvTHSkdVJrkACUSaIp/C41xdCjfmRtfFqA+1d4GlybvOZMT+o
	 EJj9weokmf4P3mtxTSzwZSYTNXe0najMGxta/cFfVkX5HMe1RnCZGTTkGwMtPlPymhfKM
	 KHFGYZrMu94ptuCT1Kg9DrMPWU1gpK4qfC+L3jWxJhW7qFDXKkY1TTPFFYPA06CUaNtvc
	 an9zCcoW1onuDEEUhe5eQiil4lgp44GwKka9+9lzYeTldPgkkW0DgnyLkM8Kkpud9BQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791874091;
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
	bh=SiJq+oxzPyL/0gfVrgpvMgtuoPaiS77olliM53eMOH0=;
	b=QXrHN6q3DEOVsmsnRDV87B5zByD2mVxIPkNAsKBs3XkK7qyCLta/7V149qbQpOH3Nn7e
	 6MdGcU8MUyz2VFOvj8mwyvoLXzZgK0ubonPe1kzfHf0KFi5QU7U08mc35Vj8IslRwoDpg
	 V4+E5w47BlgMtc1N0c/wChsWPpmfh0NytE3Mky+2vcVueh4JVhMchIHInsDQnvyiPCTPa
	 Q6BgB7GsUN0Mshue9hH2kRywQM4VOArPs5lxepQoS7OnlR5NRZdrifT3mBKKjfWasYOOL
	 I4OzXN6VFYPvTJAWznz+LersHAm5bT7QhHPo5exv5+3m1kShm6p9z347BsC24wyKokQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=YmGqF54E;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791874091;
	bh=SiJq+oxzPyL/0gfVrgpvMgtuoPaiS77olliM53eMOH0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Apcu5l7Xj5DW4KxIZqJacbEp/2WKyHZk/X9qyoQymyyT37bFNwOL/TbuUO72/m6Vg
	 /VRthIivrWUOOz7cZ85IjdNrUf5Yhj8JD53ij/9PwIgIjmHNe3RxupL8PlHtc0IE/w
	 3B5gkdlQzN1N5efBhkn7FkfS+4a70DB9sHkRJFT6MfHG62AoEQV5txNjDMNDfuLFXN
	 IEHAX9kKlcoVv0+B5D0T/Lw2qEJjZNdwdGX4Ojv2jubD7fwzwjksnW8/XaYqSb50pY
	 kjqUD+DwJb9azkrJk+w3gODBxyrdei1U5sRjenrIMXKIA923SEikjzhGsPnDnORWWv
	 +/PXnuScaTQvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 156F780A87;
	Tue, 13 Oct 2026 06:48:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 96AB3A58
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 06:48:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7BFC980A87
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 06:48:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cfkZpCcfcqCz for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 06:48:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BBB90809BB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791874088;
 b=KpaoiAc8LnZ7XPHEfc5BSOgp021s/9jUpkttJmWVsPEZPphJYBC0d3Itkl7AgyUNCruC
 Y1O/jL7BjMQBTjsyd8Vqj9Qpmd+ohnZKYoFnLcoGQZ/R3XtSmNeieYUDlOmyuPgXyxH2m
 HDvnMubn75SvHBzqyX6n24/Ve6k0bqbEyT7/qIdyB9T2hbmAZQ7aaTbZIq8+UOA9KV0hj
 4kJqEOYetwHLzr2+euXe0siNWi9nyQ5OvYWmzQ4gPZRz9BCSOjIKoKf0R9XYaASJho/qZ
 I6KZkMy+9WzB+nEMQfglwQlSep77KQQjKo6lagdz/GhGYiTz6+HJKUvxLrdi2/iKDlg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791874088;
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
 bh=SiJq+oxzPyL/0gfVrgpvMgtuoPaiS77olliM53eMOH0=;
 b=eEljs1dYI0MhYZoiOAhep5gKVLl119dBQhK7c79aBcXj7w6pR0+vDK/9CGxanRH3uP/p
 Kpat1jAHf1vqBTPUcuUVzvyodWx2tSUi0ktUoyRMx7AFTgNYlpt6S3LhpoVjh3IX5VRY/
 WpmNoNnUpwCRQuk90YGFLs/Dd9/PbEuqjNevMenIkXCYh2RDSNfPoVPJJp+JviKNeDc1K
 J4246lbmLtAl5YIvxzPhFOY58+OcQ6f8mlv01iMog1/1LccsaTUKrmPNTGfuPKRwBY6g2
 ybLaJyk4v/1QJYeczwnOIIglR7vmTL5PewRifLVl6CL97n4L/k8Qoa41uChF9RqbrXA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=YmGqF54E; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=ludwig.nussel@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=YmGqF54E
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BBB90809BB
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 06:48:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QhPbi+oUqScYYC11DvNADmoFn7+vI2Jrq8TLo11RcHl3709+rZ9Zepn9fVFZGtG8GaNlVyWDYr/5k0MwJv7FVYEVisYjfj8cEZFfFNVhk3PrVTtPWssf0eKyw7n991p3J5UBXg5iM5fv4n0BZlMClBHmGRh4eF54eJb6yhYrBVo4eSDqA5iwfLMA1yCNDdfzTg0HHRBc9kAt1zHm21GNKECmYT3d2izD1lZ5wEM6TTxBOpg7EpqT6u6FVVBXG1BScLxG0ZCs9dKP7RUi/hzn3ErrUeczi86fMm2m/vcJullBR7xYzBG6mbf8VmCaH8yV+XJYlRiedHnzSfNs3eg0kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SiJq+oxzPyL/0gfVrgpvMgtuoPaiS77olliM53eMOH0=;
 b=kfCu79LI2M244ISkXWIGLxPrRa3G/2LkOdbXwN9ilAN/kWezq0N5piZ8X48VnmH2VVcbMmRD7EUwOisyVw7kjFLyUf8Bg+13F/FVMjqW7o0eL4ra6rsNjdB+lMIboIUBOHq69KzUyupL03dHMt/su3kP2F7V/S63+9GZWhoqoy2HHijqlvRzhkl+MT7/1/J9AAYKGV9SW6geMSWexJwrn1cggIAaF/S6g6BvK+Ux4T527UFUcm/GlK82LSBl0PIascYfKPn4QzjcsmiL+ZhfvanKCNzlm0bk02zLc4ry7kXIzk4sGI1yKQYSlR8MIk78aCgfp0YURtL2wEZNovU/fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiJq+oxzPyL/0gfVrgpvMgtuoPaiS77olliM53eMOH0=;
 b=YmGqF54E0p9zZGzJYYo4g4+Ute1rSCe+UV4Z6qCqwwXJ1sDzJQcY0BTUVSst7t+aMYZmw42SkkUUBNq0+Wv4gzNT2aRTYHklOVqmJLqhbq6UtTcD+K5cusYeW4eaSnw9aCEJr+dfP96GaF0UBZE9A49CUTDDhNW4cViYeiekGlY2eQ3YTU/d9ywTMy1zpqt02bryZN4LOx8okrqWgJAn79dqFXWEPnFus3+WVEC8MycjbxMlvkREHWRpXT0n9EOmGhp/4Rt364wgXI24EUxPIkhcFNDiS2jv04M6Z2nmTFyCUGd377K6m5NgNPGXyLx2Jc2wVbW1XzR/JSeetvILAg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2cc::12)
 by PA1PR10MB9123.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:443::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Tue, 13 Oct
 2026 06:47:52 +0000
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1]) by DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1%6]) with mapi id 15.21.0472.015; Tue, 13 Oct 2026
 06:47:51 +0000
Message-ID: <44849c78-b187-4a20-bf2c-0eebaf8a2e9b@siemens.com>
Date: Tue, 13 Oct 2026 08:47:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/7] Improve FIT signature handling
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org,
 Alexey Charkov <alchark@flipper.net>, Anton Ivanov <anton@binarly.io>,
 Aristo Chen <aristo.chen@canonical.com>, Daniel Golle
 <daniel@makrotopia.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>, Johan Jonker
 <jbx6244@gmail.com>, Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
References: <20260923114940.349985-1-ludwig.nussel@siemens.com>
 <CAFLszTiM+-BsYPjaw7aD7xfzU+3kK-BO9mkYKrtXpjPOv4SjcA@mail.gmail.com>
 <11fb0589-8ef2-4870-8490-077389ce9e53@siemens.com>
 <20261012144457.GB3722450@bill-the-cat>
Content-Language: en-US
From: Ludwig Nussel <ludwig.nussel@siemens.com>
In-Reply-To: <20261012144457.GB3722450@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0044.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34b::20) To DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2cc::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB5019:EE_|PA1PR10MB9123:EE_
X-MS-Office365-Filtering-Correlation-Id: 41180456-ac77-423a-590b-08df28f5e6e8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|1800799024|376014|23010399003|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: 3aOE6CzdcKci9DiAXzYqLMuU+JZ+AmqHFIkCUbl4Wxq5cBRnJGldQYSy6yZu4m4TBK4H0NXZmcxKuVU5vwWqm5t5xVfNy8zgCeZIOH+x83jRDVF8hQ8ppyPTFepuQBhJGDiS0VnID3gC1uGYpdq4uVmIQuNYnLNtPi90mTSHP10mdiq/fkidTrsETKUd9DdhyB/hbLvTzAexffMhyXW9HyvLKJiLART9zrg+JYgcGYS2PUgVRiTkBaDwvpQI2Rh+x95MurGTn24eOSAlwxgzPZtECs2KVKbekEJMbzTPhDhEOTKYZirixleQN/ZICmegjGDCO5MQqzkUFx7J+0IIztxUsvb2qiHFzxw4WIoKpLNG2tIVreWRLPeKhjXdLcY2i/P4SY1xOzAEBX+P+sJjfyn+TinreCQURbo9wUKE3D0hKa7VgGrPdK8oKXMKF3xNzrxDudo/0SS61ZfgWmJLDNTYkx4B/lhbwBpFjJJGKjEdcoxpse0Pk0FcmLDvwZPf9NkUVCDnDCHUrrYbhguhYZkJ7Vixd1IF2tK43gTUF5+JuXHD0ilKwQpNqkevbpA1vcHiCIqeOOcoevOK9dv6iwwN+Mo6PFdjAaQVfwEbUXE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(1800799024)(376014)(23010399003)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eERnMEd4czhpRzVJVTB3TTRaNGdqSkFLOTFadU5UZkdTR2tMSG5hbVpaNmVt?=
 =?utf-8?B?K0JQRXFMQ0p2b2xsTmp6T2pZaXJ3dXBhaCtMQXZ3a3hPcmlvamdnNGR3eHdm?=
 =?utf-8?B?YnkvejVURjlVbnpWUUdaNmlMaTdPemZmRkZhRFM3cThRdHJYeVg5NEV4M094?=
 =?utf-8?B?NzY4MVV6RnpxVXhmbUVvUXFEUVpDbjFKS25jaStzNThvaWwxelJOeGNGaTky?=
 =?utf-8?B?NCtSc3ZMRHFTcjdFSUg1NVd1TWMxRlBkR0Y0NU9UZkladXMya2NXYkpYeEVu?=
 =?utf-8?B?U1hNalZFZ0lHQThhVUJCelAxVTl3cysrbVlaUlpNZW9HMTFxN3FNLzAycHMx?=
 =?utf-8?B?dkRjN0VOYjlrUTJmOGFibTlybHMxQko3cFlGQmVwa1pxcjdkLy80dnpZMlRu?=
 =?utf-8?B?MTFZOW5COEI1ejUvb3plYzczaFFMcGtZT0EzNXdhVGxlbWZyNmpRQXoxaUww?=
 =?utf-8?B?ekNVUm1PdmZWZmVxT3FtZmgwQjRDYjViVjF1ZUFPK3NMVlM5ODVma0crSk8z?=
 =?utf-8?B?NGM2VFduR216STBLRXoyV2VBZmw0YndKb3kvaUt6bklLejZOdU8xL1AraWdu?=
 =?utf-8?B?bzJPaGU3QWRhZ2dMa2hOU1MxRnVhdUZsRGhUakdhR1Z2YVBTc0hwUUFnZndk?=
 =?utf-8?B?SUpWdVAraGY2VkNteUJLQ2ZWSDk3TTRid1BZNUZxQWZJd0JVOTJ2WXJsUUJK?=
 =?utf-8?B?N0xDbUh5NFlWMWQ1OURML0NnZnM4SVliSUpBSGF5aDBsc0NrN1NQSGJDSHky?=
 =?utf-8?B?bnNWZnFvT1N0dm1JeW02aEJQblVVQ2owNDhYZlBkWFZCTFdhSVFpZkVrcVJO?=
 =?utf-8?B?clcvV0lLMEcvTUhiZHdNN0FLZDR1RXNSUDhYMlRiVzBxYmF1QktWem96Wm5I?=
 =?utf-8?B?bGtLL3ZCNjcySml5S2Zwb1JTSTZMcW16d1EwYVlSSjRjOFU0blUvRUxZNW1i?=
 =?utf-8?B?cGZtMWgxdm9lZE1xS1VFMmVUdURsWHhZcGQ0YzRPRjBwU2lKdkVIQ0g4NjFv?=
 =?utf-8?B?cWxuMklMU291VWV2cHg5YlhYMjhYaHNZVUxXNW5tcjlBSDhZVC81aVlrYnV4?=
 =?utf-8?B?bUs4dEc4V2R1Skpoc3FCVGs1ZnA1MlQza01sTG9xSE9jVyttUXVWVDM4czhS?=
 =?utf-8?B?d2taaDlneVhETmFwanZQd045SDFrZ2ZjOVBrN3ZDMGE1K3VRK2xyYUEzQ1ZJ?=
 =?utf-8?B?aGhLeXROZWI4aHN5b3dtS21QcGVOdEQxckp6NC9FQi9JRHIyN0MyWWRPbDZQ?=
 =?utf-8?B?OFVYekdHYjVLbERKUGpsZzdlRnMvMkNSZ3FTckF6aGZVSEIwV2JqOWphNlVw?=
 =?utf-8?B?ZWJCOFZidlhOV25tZkVoSGc0U2RwQVd1MEhMN3QvdndZWHJvNExvWU5mek03?=
 =?utf-8?B?S08rajcvZTRZU1dMdExaMFNHczdlS2g3ZWJma2Mwa3dFVTM0NThQcEJmeFFh?=
 =?utf-8?B?b2ljNW0zRy81OE0zMk90R0Y4a0xnMy9hTDIyWDEyclNWSFVubjlmdTJrdDQy?=
 =?utf-8?B?d3RLdWhEM0txYnJiZVhUcS9IZEYxK2QrbDlEcXZML1l6TTNwZDlXbmRMbkpM?=
 =?utf-8?B?U0JPRjRVV1o4Q2k3UWRMeWp0eWZ1NFQ4OCtjbGVSNWtDY1lvY3VqbnBMbTVz?=
 =?utf-8?B?SHJrNDJpaENaNW5Dem9VSGZSRjA2bld3WjVpZmJZaXE3NFprb0ZtZG1wZDVZ?=
 =?utf-8?B?WW5HcnZEdzZlMGorSExYMENSUlc1NzVaM1V5YS9CWjk3VmtGZjAvTDhvQnNK?=
 =?utf-8?B?T1NQdVlHY3N6TlgweG52bGtBdGRTZDJ5NCt1LzFIQkJHTXhCZVpDQ2xQSDdC?=
 =?utf-8?B?NVdNRzNVNDNwRkFrYkhJcVVjcllVYk9GbWtTSmJQMDg2d2E3V2ZESUZuMHFM?=
 =?utf-8?B?UGNudzVuMGZlaHZtQmthenl6QUMyOStVb2R6amtLaFd1aDh2OVZPNEhxb2gr?=
 =?utf-8?B?UHh1OXQ5Y0krU3h4UllHNTlJdjBFeFVuS0UxbDdzTnVWY1llM0Y5OUJDb2ZB?=
 =?utf-8?B?RnNNcXpLWmZRRENOV2QxUXZRbFh2czZIRDNsb29sUzVMUXh5TzVTY3Y3clMz?=
 =?utf-8?B?QVViTmxYU3BtWStxTHpzRWhBWksyV2ZnVi8vKzV5Y2JXWEwyOTFQQXlZU1JC?=
 =?utf-8?B?WGNFdFpBMDNWZ3hrUHhSd3VaNTFNdXJZeXNIa0IvTHZyeE9LWnM5dXIyaHhZ?=
 =?utf-8?B?cDhoaC85aDNPdWJBTm5Ra1FxcTNJZko2K1RMdEN0ZEgxVmlueSsvZVgwK0dU?=
 =?utf-8?B?L2lzeGhPMEJVcGcxczFRN3JYQ3dZTy9ocjBLdFQ0NmxpMjFDVllLcFFrbHZJ?=
 =?utf-8?B?QlhCU3IyVTFzdy9aSm8vcnBZbzZwY3JwQzN3eVNtaU1HR1g1cnpCa0Frai9m?=
 =?utf-8?Q?kXkT5O3PqiKE+nJo=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41180456-ac77-423a-590b-08df28f5e6e8
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 06:47:51.7535 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1P5xAYOEYo/t4fRvqUcDVpeOKu6GtdVsQdsIqpbtVXtYdEci6eGvnJYhOAaOJAUoEpjESPTuhC9bN8XH+oaNLF0Bv8zIozbhxPGeXtjPrZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9123
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

On 10/12/26 16:44, Tom Rini wrote:
> On Mon, Oct 12, 2026 at 02:26:55PM +0200, Ludwig Nussel wrote:
>> [...]
>>
>> When I developed the patch OF_OMIT_DTB was "default". 68e65953400 changed it
>> to "def_bool". Would something like this make sense as a fix?
>>
>> --- a/dts/Kconfig
>> +++ b/dts/Kconfig
>> @@ -213,7 +213,8 @@ config OF_HAS_PRIOR_STAGE
>>            disabled in the board's defconfig file.
>>
>>   config OF_OMIT_DTB
>> -       def_bool y if OF_HAS_PRIOR_STAGE && !BINMAN
>> +       def_bool y if OF_HAS_PRIOR_STAGE && !BINMAN && !ARCH_QEMU
>> +       def_bool n if ARCH_QEMU
>>          help
>>            As a special case, avoid writing a device tree file u-boot.dtb
>> when
>>            building. Also don't include that file in u-boot.bin
> 
> No, because commit 68e65953400 was fixing how the symbol had been
> misused over time. I need to understand a bit better about what you're
> doing here next, so we can see the path forward. In commit 99df7f471551
> ("arm: Drop unused dts files") we dropped the empty dts file that was
> being used to generate the dtb OF_OMIT_DTB required.

Qemu provides it's own dt at a known address. Normally u-boot would just 
use that. The purpose of the series is to make u-boot check fit config 
signatures though. In order to check signatures, u-boot needs the 
trusted public keys in the dt. So in this scenario we need to merge 
u-boot's dt with qemu's.

Maybe a better fix would be to remove OF_HAS_PRIOR_STAGE from ARCH_QEMU? 
Looks like this atm:

config ARCH_QEMU:
        ...
        imply OF_HAS_PRIOR_STAGE if !TARGET_QEMU_ARM_SBSA

cu
Ludwig

-- 
Ludwig Nussel
Siemens AG
www.siemens.com
