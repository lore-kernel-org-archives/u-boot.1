Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6789C79F82
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 11:01:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 95FA2606F7;
	Tue,  8 Sep 2026 11:01:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RXEf4W2Ahnvf; Tue,  8 Sep 2026 11:01:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 89C40606D5
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788865304;
	b=MTPTWPKlSV9LJ69iKcarFcDr5pdO8zcQxt6C40T/pdhWlJYp0jmQNFfEMaHA0lkSHXzi
	 AL3+VfhrEFe9s3RUcNfbWKLvtFyB83fGlA3FnOhNwjNsWnBWOyQoQJIn7tlSkGh/16eVB
	 v9RXqLJK3FdcyXwmIQPNV041j+m0axsdLhpcyq7sLVWDv7qqSn4Nlw3VdRGBYav5IZnMX
	 yHhGqMUs+2bK3jwkfBQYAGpg14XE1mk9SNdBRa3ahkEkLYs315m4d477O2+T7caY94MXC
	 wHGaGEYJRlzMUOFZAqbPLWp0ILahL8oX6pV5yBV94UTFsnz7kwfOIq66BTxBQdAdSKA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788865304;
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
	bh=DRG84YcwuYHg5FGWxlNJRKwK7sK8aCA+Jj8qbagf0k8=;
	b=UtyO5+JQztub0gRO/NChZuUaHlJvNEdutTow/59WVgE/NrtrGDnNzGQZycVD6oQ8/hzx
	 Q6NYCiJsehPpZ6HVLnE97GIRB48xi/aVWfnUAS9dPTDEItjUsw0PvrDRcpuXkXIWhTsPl
	 4V5p0ZSGqG5YwOngbC+DJm921nAVx4rypbPPuwzXGEThQdOypBtKLhy6+spbCoB7djLxC
	 VKuau7kIweBsU082wCtQiH8SKY54E4OB6GCmTbCyuVQF+WZUuv8uItsbSIVKHHsPghesw
	 KZ7yzFqXell4T9GORY/ez4dPGaGfAcQODd4zkMOZmGpGre1imuT1WxCtjt4xHxkhv7g==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=fjak91ST;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788865304;
	bh=DRG84YcwuYHg5FGWxlNJRKwK7sK8aCA+Jj8qbagf0k8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xsci1KXf0fN6WCifPjLglIKomaYe8qlx0XYBcB6K3YSdwM624me90M5QMTDFZJsnA
	 mwZeI00xJtXmNJtlHfAmLrnmnZJZ2olpVcPrArPemHWqsi3n9WosgRxoKW8ZQu5T3L
	 G5R6OFVzna48u97CZXBF+9zZu1bIp6M9KEZ3a1TLi+3MU85Zgwv/l2zVjrNkFAjQhs
	 Ztur4sJYY08o3FtkmwoPo5p3oqKZlyXcw2G4XLR80u/B4S/Cftx6+vLxMsdcCV1YIe
	 hYqA8YRm2S4cv2h0iZWLwdyTEWRRX6KdiJA+N3ucbwG2aGoTMFDvIktHe49+ZL1jbb
	 On6EiEQdJ2MzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 89C40606D5;
	Tue,  8 Sep 2026 11:01:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5724F230
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 11:01:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3CDF2606D5
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 11:01:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uh6uoRrJK9Gv for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 11:01:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5445A605CE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788865302;
 b=p0/5NGYk1H+5C+YhH5q+3DC0MbnuLb3HwbNTDk62X7rYwjN2FkZSJERpT2C3a+ZxATJZ
 ljycfZNfcdsl22SuLsuQY3MNgR4K2h8HciCwX1746ybsP1nHFxMwrzZa3ylZGkSrsVI1d
 nn6Cs0MLWNdsdzZCwYPdctqWYTxSzYAuv4EFflTGb3e+/4xUNevBWLp0rd3rM4Q1giS3J
 skxPSoWCXh6+zA1BxUVjH6CTlk1yanLqQpL5raeS6Tob/vDzm2hTrBH1X7ZngHFp2eJZJ
 YfTZvusi+mEG6ZKrkpbN5ir7d4M6jd4hS5uVdX98RT6BBLoc1KxbzVM+Z4vbLaksYWg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788865302;
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
 bh=DRG84YcwuYHg5FGWxlNJRKwK7sK8aCA+Jj8qbagf0k8=;
 b=LaXQXsYZHUs3W6qQ6XxJoRYVDoVxtzOJh4HwvefS8rfCRJ9t2WYzk9MNqJ5u0DbUyZAf
 1lkxxLPMj8L/UOvUUg0imNMD1tvduVUJBT63YD60HGYXFeOsnfStcuwL6E/WNaLwlneyh
 LkC9oZEEPcQkgsYs4Hf1iHqXUVuxmWXbNwt0HMVni4gorslABx6QMGQ+gFqkNbY/tl5cv
 IZ4eN/1MHqLULo3SPauZFaXqSwelob3Qh2NPwRRfpmnyVfeDGt7V2ZF1wGaABBP0C2bfE
 0pKLFcLDXzk5SJEArJbxskhUN83y/EUcVugjK0Mr0pWi22ju+DsAhkHtJUtLuDIYhqA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=fjak91ST; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=jan.kiszka@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=fjak91ST
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5445A605CE
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 11:01:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IoGqM59u0uqX7kdEToXdqaXzDBtQwQDyVcvkOVWYwX2BaXNx6D5Rz4GPJZxHvavyll8F50sPh4bUfofchxgS9LSd6dPJgq4zzcWnLd4n2kc8UYUUOoid6HI1YKXkWEQK/8PvfVjdUSmcrENWJOpLw4xylGl6tXkizX2JTz28ot8uRDQcpW8AfpqXtpWSIApqWgMj0kJgzDSvUMwTas2MLj9Letkta1hfpWnETneuW0kPy/IenApu+Bjza9eLPK6Xa4IRI1oRbHZ2W8Mukf6donBUdOsj9vKn2q+426ZCgR4CaG2nbDKtkBNFF6V48w6MR/UGD780P8GiZbGwW4O/QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRG84YcwuYHg5FGWxlNJRKwK7sK8aCA+Jj8qbagf0k8=;
 b=owhV/RhopWf3q/paP7W/jGcPiLIsm3sskKRge6LD4hBgfZjFmkLEhcZkjHbFkF0IJiO19w1Ofy4trB38iCj+Uv2YvgKjnjgFO8VJCr09UC2J/T3S2q6vc0t6OhL2/sO79H/exmIv4YKsQ+Q6+36iM2YnDSwMhfNh7sd4DDvAxPDrLpG7jGzVsF1W0HnOlDudnNM0nphxgiP1lxS7W5wWEms82TZro1KdZygURuHUXITfTpnz6cuC+YpmJi050qDveLnJHCuu/UK/XHmcCu6W1tb+NEZWNUvs1pIfRORuacIXTOSA4ZHTyYT2n8W6d4zTJU9Bom9Cjy4umR9Yl+CIHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRG84YcwuYHg5FGWxlNJRKwK7sK8aCA+Jj8qbagf0k8=;
 b=fjak91STcbKh+7YFKQ1snPxFBigEY0ikOrc/lXUcxSWwbiZTFjNdBd8VFabnnfh5Zaf7qq6XVsdRDUDCu1SZvr1nRCaHOBvFVrbj1RRt4XVotWGryX5mmnhEWXzQyja2wKIRopj7bGXiAHu+6vfbCfpK8UWuPwuli9CEq4Eprcx9fL3A5UZJ1W5C0Rr1Tvi8bXV6NDrFdxP3AoJSHdycIMByiOH71lhvr+VWFNT871gLYYgX1gneLC7Vg80qwCNgK8jWjKwQ0vHUwLFIqUSReOHC8urf6+kUBo48KTbv2i1JDjU15h2lS0b5EsskW1FvW4DeR7z8Q/pSlls6aOfTSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB980137.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:3ba::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 11:01:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 11:01:33 +0000
Message-ID: <d62b282c-942a-48dc-b595-365852575691@siemens.com>
Date: Tue, 8 Sep 2026 13:01:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] tee: optee: Do not warn about
 TEE_ERROR_STORAGE_NOT_AVAILABLE
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
References: <cover.1787514446.git.jan.kiszka@siemens.com>
 <13fc430cf440cdbc490bce630031ca49e81e1e13.1787514446.git.jan.kiszka@siemens.com>
 <DL9R0HDE15M7.1NFT7IXOOHCZ4@linaro.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <DL9R0HDE15M7.1NFT7IXOOHCZ4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB980137:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b0b3fd7-61f7-43fe-a004-08df0d988b51
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|4143699003|10067099003|6133799003|3023799007|11063799006|5023799004|56012099006|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info: HpuihWaL9IPls4Zzz4b+3EdYjqveQTbNU5a+YE1kNyiOif4I1TUzd5uziDG0XpumkCXTLL5P0qQllekKTv4vYyLvzlOKW/mv3bZShGx3XwZYZULT9beLSSokKU4otb8KK3w0bW1g9Cd01ylfsfjiCNowzE7UA5b4nuqvtlelxCQlntKyqfXuKeTiTg/OBZMASUfiNLg9Ihj06seAfbNT+gVCVUxWGvh3uVDcFZZmoIR4b0/PKz5WWP+q0vLkdYQKRpGUWBSU5/UYVm5IPGx5wO/vDXhX5WClnVXOwDdDmzWribDH7iv0cQlyncaQyTyxBskHeFKa+rwlxWOX7qoaYw2cKVNXYQytwHPSCYvsdOvwI/rizfDDqCsN3li0VcuZE5Lhs41/gA3WnZmuQ+7cCOAYsuRpTRcQ7EhJN6OwbJjP1Pdt7JzFTQFNbEohIlQywXzFSQlKlJh1YnFsR1Dwz385iYd3jiQMqVDf6hLKIYPbswvLr/P/MXWQY8oJdYDddoQIMDUup6pHqwmoV2EM9/rgjD7xDKZpElcBCJyfusxyfed9LMHS1Tn/d4PaKd0TQx5KJ51whq+WwkN2a/qXd0P9UmEs/p8IFj3NxLVZtDgBAdeyFqTQF2nVefcU0o6fp3zPykfhgd0CNnlJjnDqkiuSSro4Y5V2plyad9CMV1o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(4143699003)(10067099003)(6133799003)(3023799007)(11063799006)(5023799004)(56012099006)(18002099003)(55112099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2VsLzh3STV4ZFJtbWUxOUFkZkJub3RWVXA2dGFIdUlmYXc3RGNlcmF5YVBp?=
 =?utf-8?B?R1h1WWxyZjZzYTQwSDdiMnIvRllmT0swOW9CNmsxNGo1MnNNZTJlcU9pVU9L?=
 =?utf-8?B?SHNPVkp2UCtvREFBeUxzMDdIZDRuRkx4NWNnbTNXcytnRG1TU0NGRXNiTXV4?=
 =?utf-8?B?bHFpcWdEWkw0V3NOclhpUDRaSTRNNFkvdThoeGRJNDRFSmVldDQySWV1Z053?=
 =?utf-8?B?NTNnaVhsSUhIb1JYdjdQV1o2dXVkRjJJLzJCbGhwTGZ4YmYzTW1NZVBKMHZF?=
 =?utf-8?B?ZHZ3QnNvUm5pKzlueUVubHlDVXF4RFM4QUY0MXU1RHVocVFaS1BGQUY1RGRw?=
 =?utf-8?B?dlk4azhqSFR4MWp6TWF6NEtGT0FoQThGYW00MmJhNFJHZU1IRjNSRDgzWi9u?=
 =?utf-8?B?WFArQUp2UDFUQ3lsZ2d4NWZNbWpZaTZiZVE5SGpSVm9xd0lpeUpST0Zjd21r?=
 =?utf-8?B?cHlTdmxKVGhLRTVId1A1UWVEdTlPOTAwbHJGLzNyTGlGTmI0YVBjVmlzSXJv?=
 =?utf-8?B?eFd3K3hNczBBTTdVU1dhN09TTHlmM0pHVVZ6eTQ5V1JzVFNYUkxCYWtjMzZx?=
 =?utf-8?B?aERYR1VMRHpjZGcwRFRzaW9xL21BdnBBWFpFdzdzRlhnenlna3lUWTFBZHZR?=
 =?utf-8?B?YmIzU2d5bk9NQWMrb0FBallSYlpGN1dpOFFoOFRHL1phNjM3N3VxeFJEeE00?=
 =?utf-8?B?YXlJbHEzUkNNTHZkeXUzZVZLcmpSKzdxTVdLNk9rNUV3VFplVHZPR2lzUVdz?=
 =?utf-8?B?YnFkd1ZWcDJDbHg3Q2JhcXhJT0EwTEhkYWgzTkM0QkRVYldlWk1QL3ppcE9v?=
 =?utf-8?B?NGl4dytucU4xdkdHMDM3alR2MHE2d1ZHUkh2N2hnb05Ea2JweGhnYXN5VlVB?=
 =?utf-8?B?VTF6KzlCYmVjTHVJbWxRQjBiMW03QUVEaXhXcEtIQkhtYUx3bnJ2U0V4bFNj?=
 =?utf-8?B?RjdidHFac3NpRk95OTVuWXRlTGVzRUs1WkQ1L2Rvbm1RYVpvT25xN0puOFc2?=
 =?utf-8?B?blNVcjRwb2VhM0VrcDBzUWhXdU9PTy9PWHlKSU5QQkRRQnpWQjZ3ejRCNWhD?=
 =?utf-8?B?bkZQNHlUc0Q4SmFtRU0xdTFPQnFMZGNBTTBGOEtlRmhyUWhOMmN0dWZKcUhp?=
 =?utf-8?B?T2Qwb25YUmZ3TmthWERRa3A3cEJXbjhCY1hGZjRyTkxZdkJITHl1WGJFcEF6?=
 =?utf-8?B?N0RkeHBlZG5VMUNGS3c2RmxaTTNqdTRDM3dKbWYxQXBaUTgvM1JKRVltTk0v?=
 =?utf-8?B?U2NVWmFvOW9OaVcvZDA5TEExcytYZ3c4NmQ0ZVJSQnlKTHoxWVozQVdFQ3U1?=
 =?utf-8?B?VmJxZkhXc0NZUjZ6V1NTL0J2bmVsSE5ta2FEeG9mU0NtMmI4bUdyMnkyL2FZ?=
 =?utf-8?B?QUJpdkhaK3lLQmZpeVBKWVR3OGY3Y0FicUVlU3Jnb2w2c3Uvc09IcDZiWUJB?=
 =?utf-8?B?aE9xZTA4ODNhb3hPSTVXdC9zY1V4aEF6NkZERVY3ZzZaTXZSb3V1ZEt0MUdE?=
 =?utf-8?B?NzZFbDRGZzZQVUpxd0cvSjFSaEtJOFlHWXhJTSt6RDBXNnlrVW4yTDBwdmlj?=
 =?utf-8?B?NzFzbFhHdGM3Rko5TWMrZzdrVFpvZVZrdnJpYTAvWnBXc0JOaVAxRll2aGh1?=
 =?utf-8?B?N2hPOEREMEVGOUhublpPbERMUnNDcll4OS8yVnVudHV4bng0VDB2SEhDejMz?=
 =?utf-8?B?cW1oc2lrUzYvRWRzK21mYXpzeS9DWjdHdTI4bUtLVUMrdnN3VGxKeVV6WExT?=
 =?utf-8?B?TlByazI4TmZCb25rdGdTVFNManFTY3Y3QjB3aWZMNkgzNlFJV2FZa2FISnB5?=
 =?utf-8?B?SWFxSjhJZHg5Z2VUMGM5SVNlanprMlNmMWxGeldpNnY1Wm1pSXRQRWJaaHV0?=
 =?utf-8?B?R0NqeGxVaDhNWDdmblcyV3pqY3MwRTBUbjV3azBKRlhFMG92M0xyQ0ZITVp4?=
 =?utf-8?B?RGE4NTgzczRmQWl5Rk92N3B2WVUrb09paWUwaTR1QmNBUlk5NEw5QUhkK3Fk?=
 =?utf-8?B?cWZXQ1dRVS9jV0YxQ2t0MWV1QzU4T3ROTVlxYkJsWC8ybnB3cG12SGJtNFc1?=
 =?utf-8?B?c1Ria29XQnlZakVGeTZkZVF3OUEvUFp4UEpUZWFJQjNtcmt0VXB3MUZ3RVBi?=
 =?utf-8?B?YmFnNnhZUnU1VjhRRVpLSFUzcmNmc2UyQXhZeG4rYndzemVlZlBHVStGcHNC?=
 =?utf-8?B?cE1TMmZpOXJycjVJMyt3elJsVW9tSFpTYm5kVllpcjd5MnVYLzV4cWJXbmZw?=
 =?utf-8?B?aHhKbnMzOE5qTGJMd2dVazdTU1N1ODRPRWsxRUZLcGZUZVdOOFpwL3Y0RXZr?=
 =?utf-8?B?NVlQUDV2NFZtM0pTZU5aNVJxWDYwQ1Z0dFViNUtFaFVFZkNrU0JyUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b0b3fd7-61f7-43fe-a004-08df0d988b51
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:01:33.5090 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tj7dJMU74UBBpt94Fc1f1Dr3LxJtszI1Lmz2nEn2K6g+AuMbebrOU0jdec0SMTirsYFYRLI3Kw7W0btEyVfDIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB980137
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

On 08.09.26 09:15, Ilias Apalodimas wrote:
> Hi Jan
> 
> On Sun Aug 23, 2026 at 10:47 PM EEST, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> This is a transitional error that is resolved once an RPMB becomes
>> available. Keep it as debug output only.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  drivers/tee/optee/core.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
>> index ed8f2b6ec74..d3b5811afb8 100644
>> --- a/drivers/tee/optee/core.c
>> +++ b/drivers/tee/optee/core.c
>> @@ -106,7 +106,10 @@ static int __enum_services(struct udevice *dev, struct tee_shm *shm, size_t *shm
>>
>>  	ret = tee_invoke_func(dev, &arg, 1, &param);
>>  	if (ret || (arg.ret && arg.ret != TEE_ERROR_SHORT_BUFFER)) {
>> -		dev_err(dev, "Enumeration command 0x%x failed: 0x%x\n", pta_cmd, arg.ret);
>> +		if (arg.ret != TEE_ERROR_STORAGE_NOT_AVAILABLE)
>> +			dev_err(dev, "Enumeration command 0x%x failed: 0x%x\n", pta_cmd, arg.ret);
>> +		else
>> +			dev_dbg(dev, "Enumeration command 0x%x failed due to unavailable storage\n", pta_cmd);
> 
> I don't mind changing this and I like the different error messages. Isn't the dgb message useful for
> users though? Or it is something that's not expected to happen in production systems so we can hide
> it?

First of all, it's now something that will always happen due to probing
of services that need RPMB when there is none yet. And, as explained
above, it will be resolved later on. If you user misconfigured the
firmware, though, there will be no resolution - but that is a debugging
case.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
