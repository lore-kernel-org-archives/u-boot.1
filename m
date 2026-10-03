Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD87CA5FDD
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 21:33:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ABC4D60615;
	Sat,  3 Oct 2026 21:33:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zbMHXLW31DRi; Sat,  3 Oct 2026 21:33:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E2C2B6062B
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791063187;
	b=rGe8MppxdMaFQDX5n+7SrqZU48ef7HwQUel0r9kuOt9EQyQu+oQTXZyDrQ1rn/qWmUZc
	 yQ3cgJdeOx86kFixJuD2EMHn/zka0UYBQOT5aLHwsvKEB3SbSQUTUkG8+5utB5CRX/q7K
	 u214KFP0ykukTgUk21oFCBqy8WFaH74TShJxKsETTDUQK9zLb991wjwNA8zE5H3SbC+Z9
	 1wtv8w2K+X8RVJDYldnTbq/FTN4uZb4O7SscYszm/kg2J1GUWG4oGw4gjuCkgWoyq90Mx
	 C7tGvltN553Gk1Kgwp6YX53VrBbcJ80vhq395n5KLcP7ZEKijMLVki9vWNLHNgJi5cA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791063187;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Received:Received:Received:Message-ID:Date:
	 User-Agent:Content-Language:To:Cc:From:Subject:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=h1K699SQN6lT3EOfvTDEow6+snHiBdzTL7LH4ID0T/U=;
	b=CFB9uZAoSht88zVfivRkuIc2gQTF4a+85rV86XcWdmfqzjYOgawkE2Imv4vRpto6U6dE
	 AhBnVktSK2GACYT5c4Nfrxum5TemSuwmqU51marUt2HBEE31pl1L1HPt61GW7SfbxxaWB
	 y6rUB/zHecRe5vIlM4yd3GIa0WKYX/zV/idK1GbIqF7ETMJNMicGdirPg2w67nTOoKmr+
	 h+YnUNYXgJKPa/WkQT2PW2pLh9sdZMm/YmVIUBDEcZWDdAonr3q13+cc2xQK+XQoUDJqe
	 6Ql5bm34XZxV8TPymxAURqLVk40JO0aKrE6FLAftLqS0fAwM49LBznyLFFhhOchSs+Q==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=analog.com;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=AvzLdMZ0;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791063187;
	bh=h1K699SQN6lT3EOfvTDEow6+snHiBdzTL7LH4ID0T/U=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VuPR8VDg+9FaKHzjPY+yGOpU3AZ2Gf/J/jCgNimdBbjNbeC1EIPoHDl6Jp2iYsW23
	 o1dGLa0ZTj7d0E/JTZ65XViuLJ1o0cVu2Y6gT06LxmjWkF/tO80HIWZvJxBcJzHwG4
	 xFIU9FXgf3ac9txGCdTTPt/o+oTlHmYNBAKLUu5eK2bI4GCqsf1Bv2Qfc3MxNxfQny
	 UEyFDcdUn06OTwc5bFWInouz40/5YHsz5tdkVhzQesqQ3pQhCrSdkQzBgcAvoDXUy5
	 GbfaO5xAgCqQhx71Q/QoVXzAojaSaUQhFLIWv0AM51osVDVmydRLGxQaQJYNSq2O6E
	 LXraaJk5Xy1gg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E2C2B6062B;
	Sat,  3 Oct 2026 21:33:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A2AB282
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 18:31:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5BD12606B0
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 18:31:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UeeY50TSpVol for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 18:31:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 789F4606A0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791052317;
 b=S/NgF5JeKcfQBZO8VVLWWVv8gcw1S1gJZIBAlEXaQp7+jlvA4RYFDU3/f09fs05KANKR
 VjrJAbjErcuMzZ8jTQgPCH74/PnTABDJr8rxyLcIYQRGI/oZtAz/yKN7h3iMIYY6+IfFi
 b1lo8ksQDDi5qRoTYdBWJDWeNG6CKFnI6htsCRibk/RpB22BMD7E3cRxp4Xo1DkoD7Nfw
 i6Kfegkl6DerogpWEEjBJOO9vBL2lIICdo99NyQ2BBOL5fAtkKadL21BCUCiViGR1BGOY
 r6v5bLUm8InljEGjBRubprErQKJVzu2tB0l0TyQ86CZ5MORt30paA7teWN4KB8Ni27g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791052317;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:Received:Received:
 Received:Message-ID:Date:User-Agent:Content-Language:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:
 X-MS-Exchange-AntiSpam-MessageData-1:X-Exchange-RoutingPolicyChecked:
 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=h1K699SQN6lT3EOfvTDEow6+snHiBdzTL7LH4ID0T/U=;
 b=Lji6Oqtq77yxxxYFMjcKgFPNbwA+OOUVGzwWXlKc+BEuGKiRlb0JSNrEvQ6THpUDG5nc
 vhBLPl1BGiLwVZu/iGBXJthYkBBYPu3ByrWXtNkbHOjxoAGwnnlUinaXQb7XriYO0Z2SZ
 aof5oZSGT58IB4jNKS3IrNx1c5ktAwhpqxvwqhgVd78AD727gc9AedYUtPC/dvSGuFyah
 NQwTDMfdlGPiSekesW6DZyHzc1AA4AGLmLX2qKvRYAnbvFUpMIN8jWXA1LrTVXctyMlFs
 IGuUvztwg8r7XNZ2UinOUd48r1YN5jf0a8q5Sb7lW1CJo2mtstzaeUb6HeFzP8xXSsA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=analog.com; 
 dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256
 header.s=DKIM header.b=AvzLdMZ0; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
X-Greylist: delayed 5658 seconds by postgrey-1.37 at util1.osuosl.org;
 Sat, 03 Oct 2026 18:31:57 UTC
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=analog.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256
 header.s=DKIM header.b=AvzLdMZ0
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.139.77;
 helo=mx0b-00128a01.pphosted.com; envelope-from=qasim.ijaz@analog.com;
 receiver=<UNKNOWN> 
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com
 [148.163.139.77])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 789F4606A0
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 18:31:56 +0000 (UTC)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
 by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 693E7S3U2076622; Sat, 3 Oct 2026 12:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=DKIM; bh=h1K699SQN6lT3EOfvTDEow6+snH
 iBdzTL7LH4ID0T/U=; b=AvzLdMZ06/GGsa3TqEqYEhjn5TB75Z2cze2jUScAxbG
 hppdyAgEWzV4qrE2mxNnvpohYV23pDp5TMp09m/QHh3AT6P9DpH6L9Is4AA7OOYz
 9u43yiztRyHwVEscWiqiGZqDxBO4znM7dGPIoxVZThtsJKneaW7TSsLeNnTYlsEG
 oK/cA6QAwqJYo3OuPezWYGUH3Z38p0zQbVRZFSdx+IwVWraa9pftEb4g3jDKL2Q2
 4nnnY7q4M25SRz4DVRJv4pHv1FK2tR5nCqJ3eBeqkrt7ck8w729t73XF1on2WUNX
 sPdv1JuhrsBtvLLjSbxu73Cvn0Bf+L49AJG1rhHQjsw==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11011006.outbound.protection.outlook.com [40.107.208.6])
 by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4h2xb49rf9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 03 Oct 2026 12:57:37 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t1j7Ffr7qeo8nL7vbb4/HOZz7mQ66nWUDiRBTv50lh+Eq5eSO+08e/9zG0Ltq/u7YeDkLJ9yoUcy/vQCdXxrgG40hfwacD/t22ObJS6yJCtiu5iNetSS4vHusV4Fq91mhg1CQLNeY/zrSvejD6eshKOdFm7Vfv92/w/Ymy8wZtnzUc3JOnsW9HDT4IMVhKhyVu1Uk3iBAM+fXCHM85Ih5lYiUAmTW+V4VH4wJFo2AYm1bP1wrkb0FBcN4vg/2PjCdpPD51W2YPcWQj3UcXpKC6NKWNDvMlG5gFv+xKsK434Oe2X5hIXssTC1WN+kWnVKco2aOGYO3oOh6qb6NInwRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1K699SQN6lT3EOfvTDEow6+snHiBdzTL7LH4ID0T/U=;
 b=mv30rm5dxm+qAen/pzLxz6mjIohatVj+LEJe3phdhaUJT4nIzn77pSsx/UhCmCNpMNcgpKCI7dcVK4o9kHoekGe4Kl2ymZVRAuimMRbOKzwA+RpJJ7aSrpTtK4m9q4NhZo3VW/7m6jss6LZzoi2oIIuUsqb+lgdbMFjWDicGkyuqwRyBwzLS+0sfRPQW9b7Yik6Pcua5q/W7P2mtL6U9d3n5U7Iq5MyP4o4cXWrA0XTbsaaDn8jmBdxHHREOxZoKhxoVf9XPCD6qua1rdDsRFB8DaFSqPkaIYKR88tfz7NVV5N5uo5sOQ3u9Vw+6sZXBNS6p1EXLnf2Z7mdXLGecXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB7101.namprd03.prod.outlook.com (2603:10b6:a03:4e2::10)
 by DS4PR03MB8424.namprd03.prod.outlook.com (2603:10b6:8:324::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sat, 3 Oct
 2026 16:55:16 +0000
Received: from SJ0PR03MB7101.namprd03.prod.outlook.com
 ([fe80::1a89:5399:a130:9a6e]) by SJ0PR03MB7101.namprd03.prod.outlook.com
 ([fe80::1a89:5399:a130:9a6e%5]) with mapi id 15.21.0451.022; Sat, 3 Oct 2026
 16:55:16 +0000
Message-ID: <dcc2d705-eef9-4346-a2da-ad42e53e973e@analog.com>
Date: Sat, 3 Oct 2026 17:55:07 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>
From: Qasim Ijaz <Qasim.Ijaz@analog.com>
Subject: [PATCH] cmd: clk: Don't truncate "clk dump" clock rates to u32
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0005.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::10) To SJ0PR03MB7101.namprd03.prod.outlook.com
 (2603:10b6:a03:4e2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB7101:EE_|DS4PR03MB8424:EE_
X-MS-Office365-Filtering-Correlation-Id: b44ec8b7-a2d4-4500-871c-08df216f1970
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|23010399003|1800799024|10067099003|56012099006|260925021311599003|260925022911599003|260925021911599003|6133799003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: +MpK81cAUS7LX+BUptZLoEJ5VGE6PJy50wrJsKiy+KkzZ0O7GWf+EREFzrPZxKfBSVkR6qcP6W7lurZsbKDCbhuu2Cb7yiiHICVh+eUtYcmuJzGFvuHCLh/CRyBWdEGExRKWWT4bQAVySkOFFWOLY2PNuLGcyi7LWOrTuCITP49qcX8mGbJTmkXKu2zuD/r/MCGJHYhLYxqXiA0EpJxC7zpUsQryjDRU252FTjPvad30nDh5eOOnvnHF3wBPaHWNb9O47KE7QiveqKcl1lpShecEcq45MqXIGnvBM3gsWUDX1v1TZulp1nr9ktl2uA812qEImYdd9Ygy4zN//NuUPcDjzqi4fm83HYhwWI7dmrLzFKWUCE8pIYP2m9iFUrSZ6nr6/9Ha+e1E/zSCuhZykzmwaV9XZRSBUUqkhCOEeIVMFbL7Nqw8nhVwga8xlCysl4pUdNr3m8fvvx939nKraMg8t0+c9T6FHHK5KKFIgJdL8l3hdlOJTNVRo7cTJqYT4EPd7QFqwcRkUcIvf4VmjD7/1dfg3oz05p40bi4CGbn6wmq/B1d4Eb47RaC0vW0RRw1L3cKAUN/oO9nZB6VaUDR9/rbvYa8cGsgEkGRo33yihemLyYFiFTOKisjLGbNzT9/4Vre8W7EURFb/T8c2kZyXkqFZY+YyMH77sRD7RjI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR03MB7101.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(260925021311599003)(260925022911599003)(260925021911599003)(6133799003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2pTVlFIMVNGY0tmMTFRbUJ5aHpEa0V3N2M5TmFtYkZicTdJY0lSTjFjazQv?=
 =?utf-8?B?akNIcXNXSzcvS0piWGlsQWMyc3VTYUdkcjllb09Pb0dOODRjcEpLWmRsUTJC?=
 =?utf-8?B?VGp5MUNNTHBoMUFRL0s1clpnRE1RZzV5OGRwWWhqQ3liZnFCTDNVb0h3ZFpi?=
 =?utf-8?B?alllemdYZTU0cEZjNGlGV0tGdkdvbWhVM2xrUXJQTTFVdXlLNmJyMHI5LzN1?=
 =?utf-8?B?T2JCdkd0YmdOeDJEb0h5YWtxc2ZDSk1BU0xONGcrdzFpZnUzNmx0Vjd1VVR5?=
 =?utf-8?B?NXZQSHFEMUhpYnhKYmM4V3NkaThBRjJTRVAzWmo4c1VaYm1KVzRldkw4c3Jh?=
 =?utf-8?B?V09CWmd3QXpjYVRWRmMwSHdna2pqV1lTZWRzcThjVktiZ1ZxN3pIWDVYRWlk?=
 =?utf-8?B?RWR3MXNaOEpGZlJ3cTY1aDhrdldkT2x5Z0UwWmJUWVNDS3ZObEhzQ29xdjdR?=
 =?utf-8?B?dFA5YUQrSzNzWTRqWkRDdG8yOWJXYVNzcm0yRVdsd3RQdElNdGxaRFdKZ1A5?=
 =?utf-8?B?eTRUZEZnQ09KN0RKd0hOOWRZK1JlNVpPQWZ2emdPbHhNY2RkcmFSWEkzYmRB?=
 =?utf-8?B?d3NKSk5rTGtxQzY2OFBaZXdyLzZBblVMSHNOaFJreXdPRHR6V292ZFROemJX?=
 =?utf-8?B?ako3amp0bGxhbjR0bnA2NzVGT0RJci9JYlI5QTNCODk2d0J6dnd5Y3Y3SGhQ?=
 =?utf-8?B?bzI2ZUo0V1oxN01PczUzTVptN1plcUVIMVRIQmlXZFZMY0pNVU9zTkRheVdR?=
 =?utf-8?B?ZUJTbTFyKzVrRGcvVkdTWFRtYkd4OElrVEhZZEZOMW1XQnArb2l3aWlKcmdm?=
 =?utf-8?B?eVJSSkQySUVwUUU5MnlVUVRoTWpkRk5ScTRYa1BxLzVMdmZyTFB5RWQ0VGh0?=
 =?utf-8?B?aHlSaDdIdkFzL2pPUG12UlpwZnp1MmFDZDYxdUhrdjMyZlFFUnBrejllMEtS?=
 =?utf-8?B?R2lqZ0NsVjQwZGFJTWRjTTJucVZuMTRSUGo0dHVqYWZReXpzUEdZbUJzY3ZX?=
 =?utf-8?B?d0dXSnlDdXFKN210bVYxMHlyMWJoMlQ2cXJ4czR2QkpncXFiNXJKNU1IcUln?=
 =?utf-8?B?U285SzdDMjQyYWRteFJRYVo5VXRPVXVic0J0SUQ3MkFEckpyYnk4SmZ3TFE4?=
 =?utf-8?B?TnhOV3lQOC8rYzZTUHJwS2tXMlB0K1gyZHo4TDkyWXZSOTA5K0FPbmdKVVFy?=
 =?utf-8?B?Ukx0NWFWN1EvZmEvYmtkOHdnbm4zRXU3SUUyRzU2MjhGd0pieTVIM3dnK1hj?=
 =?utf-8?B?WXE0azdqYnBybldpaUlvZFd1N2drcVdXMisxNTlIQ3VVNk1SYjEza1RXdWJn?=
 =?utf-8?B?K1VDR0hQWFJmeVpkWlZMWlhlbHNCeVYzWDVkNS94blBqbHlIWHNQRkZyem1K?=
 =?utf-8?B?Q2NRM0pkZ3VHN2tQM1MyWDhUR09vcldXRU9ESThLVHZrOW1DV0crTGJIWmpj?=
 =?utf-8?B?TzRtWGJtQWV5TWV5RzNlVTErRU41Vjk0cUE5YjBWa0VIa3pYVmdpaDByVC9s?=
 =?utf-8?B?Tkc2RUd2ZUpLMEVYaDFub2NoZTlONzlzeG8ySWZ2RGgvT0FwM3ZVVE5VeTlo?=
 =?utf-8?B?S200emMxdDYrYXpOR1ZKWXhvMzF5R2hUR214bXArMlZZemtDQ0tzUEhPVVNC?=
 =?utf-8?B?Qm9JRzRvSkVsaTBkcmthZDhDRG93V3BtWkgxOWNTWC9XcjNqcVZ3R0w2cFFv?=
 =?utf-8?B?Yk10TndHN0htMDVGSmx0cEpuTEIzL0FXWFNMOElldE5pL2daNDBvakt4WFFm?=
 =?utf-8?B?MFpZRnc4bGJQMVhyRjE3YWQxeXJaSzdCK1BmSUQ0b09jZ0xSZHZQOEpydUNQ?=
 =?utf-8?B?T1RWUU9HSjkyWEZZaitPWFRVYkxrQUt6VE0ySGxUZmtOOUlmYVBwTm95SUVk?=
 =?utf-8?B?VnZsa0UySGlpOFNwMlRJam9kMEJhczV0L0dRZDVFcEovMDdxYURERHRrSkcy?=
 =?utf-8?B?ZHIyVFhHYWZWUlQvcTJROGtuQVNDN1BnLzlCOXRhbHViVnlhRnlxNjJKcXVm?=
 =?utf-8?B?VXhhTnE1YUt6b09GdFh3OE9YaUJEbVIzM3daUllXWmk1bDlUZFpURXg3Ti9M?=
 =?utf-8?B?WE9LSks1d24ycktUMFhYN2Q3dVFaeEsvRGtPeVlxNEIwZFhWd1hVU24yMjc1?=
 =?utf-8?B?YytBUG52Q1VUK2RzVFQrUWJRSkp3aEluYjU3QlowUGJxR1FEL2MzdHJqTjJh?=
 =?utf-8?B?MDZWN3poRnRpMjF4REE0b1IvY0hYdXZWYzNCbHVJd1RPclBVVUwvUzNselV3?=
 =?utf-8?B?S2xpT05NRUx4aEZtUFBmNzVrK29XZXdGelhVSE9vVHdUazNta0d6a21jY1lE?=
 =?utf-8?B?azdhbERaWHl1V2R6OFl0K3lCNjJjL2dHZVgzMkJDVXlIN2g4d0VXdEd6VldD?=
 =?utf-8?Q?FYprzvJWOkfNaf3wNbuhC3qGsAyF7o2AsXJ1mbUbXqPRN?=
X-MS-Exchange-AntiSpam-MessageData-1: D9Wsp0pg49Ao3Q==
X-Exchange-RoutingPolicyChecked: gWyWTodz3HzgQjYzHWuOWahMbOvK5rMHXBlQhRBsIEEfMv/SbFerILX4EqsjVslOxoQv/lkBa3C1OolVXqM8a62fssdjS8GWlRT1g2Hsii1ufffswAyGgtfaYAhHFUWJGf5gOja1KhH/gAO8TuJUdnXolyR7Xo39dWu/Deg92RTj7ZkfBi8jlYT2hELrFARIwdpBJPqI7a6D0vt3rOKIZyyT7WRLYSnYnwnI4sOUTeH+e015n5hIQ/53EZxESZNTGRH76XdZDgoTceeXqewAiE9BuiHWfEy83GKhbzM48XZISMeoZNOv6JD8fEGAFlfCpz1sO8qEIZqOi7JyOWcJrQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b44ec8b7-a2d4-4500-871c-08df216f1970
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB7101.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 16:55:16.5790 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J2r71qKCywtQ+MbeoSHxfYRzTV62B59ONjfIpP6U09Tuth+RdvsYtGu9LvRQXK2RDc7ENqaPjMU4g/E4F943Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR03MB8424
X-Authority-Analysis: v=2.4 cv=fbE4WEQF c=1 sm=1 tr=0 ts=6ac13401 cx=c_pps
 a=HPJBkY93y09GhBhYB2jcmw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=_jAD5XSDOtq9-5Nde2OG:22
 a=gAnH3GRIAAAA:8 a=byfB9pGBAJdzxDXkMXwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: nZtG9Cmq7jK5cHimUJreJ3ccZUgsKZ_Q
X-Proofpoint-GUID: nZtG9Cmq7jK5cHimUJreJ3ccZUgsKZ_Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDA2NyBTYWx0ZWRfX64Ix6aZWGHsb
 ISKp4Mj4fN6iIU5ZzTeJiBYdi2/NJ8+l1orX1vQbMnA/YgaYN3Z3sjBaJgrGGSxT8YJSvnkxi0v
 hbErQLpl7qW+lV9yWfHGMos9x+KFGYlJ0XyNjPusE0hTDd4z6u5d8hnZBDflFktbOwiwkv77/im
 cEsWuV0D08iLQugmQvWgCHKqdFNkm/nSrO/nJqh1vhyRh4Sd0gVtER46o6PoToo01uzHjwGCu4O
 hVMNLjOhnJ39hxVOKZPT2j/2fo/15HqBrU8NQUms7tWseQiDUCpCgc5Qhf/EGjhInIRPHfJ670c
 swTCiQI+MSoG9M/IshJAVw4OBxUbruMNU8n7+fyaceClw9GtFXqF8lPoy501mK8ilIzZReYCDYl
 TKlifZ0XXbuRvBu8bcR1oPmG1GusSWmTmt3/Dl073Tc6MFJtr55ePh3Yv0VUIll0Ebk8CpSw0cx
 1DN4OH9ptcvWQLny9Dg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDA2NyBTYWx0ZWRfX0GTh0plAIgwD
 anfKvL5HblsXNCkk1tW7VYIcf8trkHswsHI465391nkxMEkHJM4qmjuOejSaiWkCvGlFRKbRGfx
 xbDS8wZtLFGrXGHY0MDavdXqvsMuEyicXtIV5PoUqbTkCU1xH5pm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-03_02,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1011 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610030067
X-Mailman-Approved-At: Sat, 03 Oct 2026 21:33:05 +0000
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

show_clks() prints information about the clock tree such as the rates of
various clocks. While doing this it gets the rate via clk_get_rate() and
stores it in an unsigned 32 bit integer variable. This limits the clock
rate to 4294967295 (or around 4.2GHz). If a clock rate exceeds this then
"clk dump" will print a rate which has wrapped around the unsigned 32
bit integer.

This was observed in the clock tree of an SoC ADI is currently bringing
up (the ADSP-SC846):

	=> clk dump
		...
		cgu1_vco       505032704
		cgu1_pllclk   2400000000
		cclk2_1       1600000000
		dclk1_1        960000000
		...

In the above the VCO clock should have a rate of 4.8GHz via:
VCO = SYS_CLKIN * MSEL * 2 = 25MHz * 96 * 2 = 4,800,000,000 Hz. However,
4,800,000,000 truncated to 32 bits is 505032704, which is the value
reported above.

To fix this issue change the type of "rate" to ulong to match the
return value of clk_get_rate() also change the format specifier to
%lu to accommodate the type change.

Fixes: aeeb2e6d9c67 ("clk: support clk tree dump")
Signed-off-by: Qasim Ijaz <Qasim.Ijaz@analog.com>
---
 cmd/clk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/clk.c b/cmd/clk.c
index 2fc834e5549..3c816a41730 100644
--- a/cmd/clk.c
+++ b/cmd/clk.c
@@ -15,7 +15,7 @@ static void show_clks(struct udevice *dev, int depth, int last_flag)
 	int i, is_last;
 	struct udevice *child;
 	struct clk *clkp, *parent;
-	u32 rate;
+	ulong rate;
 
 	clkp = dev_get_clk_ptr(dev);
 	if (clkp) {
@@ -25,7 +25,7 @@ static void show_clks(struct udevice *dev, int depth, int last_flag)
 		depth++;
 		rate = clk_get_rate(clkp);
 
-		printf(" %-12u  %8d        ", rate, clkp->enable_count);
+		printf(" %-12lu  %8d        ", rate, clkp->enable_count);
 
 		for (i = depth; i >= 0; i--) {
 			is_last = (last_flag >> i) & 1;
-- 
2.43.0
