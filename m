Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F70CA5FFC
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 08:37:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1FCF280BF1;
	Mon,  5 Oct 2026 08:37:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UdsYUwFiez4k; Mon,  5 Oct 2026 08:37:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 140DD80883
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791189434;
	b=ROeHmiON2Ot/Eo2fNnSQ/QSpb9+QlkpOZHBeeIGj+iNpdY8kZfXFvUob5RRsldu0ZQkD
	 vepnwDVwH/pPA3W5LvL0KIrRnArwOMbCIfFnGAuj20GmNzOZmUNzdYgzxcjwn38O+YzrK
	 yCzmTFx5YILvCubodRGeMoKtnAvy6Ro5D4gkVKWLHQTMtThYM3/+zg5cTxAwoglGbUKeS
	 4IlQgyUDPsLCOOsdUw7o1Pora38VWJ/pra+wgiWVPXZb/fibR6+mZxuIUAgHF/tEDQmGe
	 1lv3ZOVywQ6og9dmqgAiDK5qBOzX930UkaaiVe0+QzSCp4ZLg7Hx2GmaGwBLlRDWabQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791189434;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=o6ETUmpW3NZqfj86SA9lvAEhhxHMwsUHD5FKzSTxeko=;
	b=enq7vwFUBtrcZ4BkUUeW7zs2i7qO+8j86kFMLZLLO1Ezd1vma62nt8xNJiZZfeIEk1By
	 fhNm4A4mTOTiM5aDWyq482e6L4b9Y7ZuumJBJqIWTacmE67Uj3yfMqDYvfi5P5Hsjfaaz
	 CfsfYsGCmxVgQh4MG5gOOdAtLQckI1F1wOCBEeAmUy5C3kE/t29joEfXZF+MyDeDtL2kp
	 ZWodZjOwMwH9HfhOhFWCIMxcliH2wGeNNLyJ2mJ+sTb8KOwrBg7tR+hu/ZaA2wZuPuNZF
	 2hE7z0lpGjXeQ8EkaUDMVrRF34efFsi4Xu3FcW0a7uEnG/JWWXjnk+IIqaCfQYA+JiQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791189434;
	bh=o6ETUmpW3NZqfj86SA9lvAEhhxHMwsUHD5FKzSTxeko=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oeZ3Af6qcDlZlUKhPMilQKaHqchJz1bDHrKlIb5k2nytfrC9aRBQJQ+/DZtmubw1t
	 wTrlwQsE3PhjOu9HttsKraBTxjJfHK4zJwQUqccTaFzY51xc/plLsmiGQbWVuJpiq0
	 kXjJKj/A/47p2sUe8u9msrLO8+duiSXs333C3o8Dmt19eIlXdNLL+6hs+E5+j+Vdh8
	 byXMM4YF92F+7+2x44xOiuPF6APIeM6F4ECeoATEwbxCgsloD7Y3tlBRzF+IkkLdaY
	 W7+OF/8IDHYM/9ZKRWWNvlFcNUp1PwoWvsHiRJd4HcV2UAUYNi9P/ynsfVrVziqcNq
	 5GCyWJSkrQdvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 140DD80883;
	Mon,  5 Oct 2026 08:37:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id CB6D72E0
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 08:06:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B0F3C605EA
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 08:06:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4HxyM5O4nepU for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 08:06:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A36D8605DE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791187579;
 b=X5gPtccXsnY707QFsrDTs3HX9feGT3Ofq/M+U64na2YpHah079oYq9W65sBxBRT0yoaQ
 j2SFqSQQW8+/hPsrha0zFbxh8SwCxDSRDnP8+1VY6TDIvEz/K67PS2ycrL8wmrRr336HT
 y0PIyLdIogbId+JGKLM0p2KOJwONp6fwReyJJJIygWL7v36A26Vvw2VFpJQVL64TicpOK
 HTh6Yxpz+9IwE4n3s/6+KKPIRA86XpRQ9ieUh3Ik2++cLDyo1eA1FltNW6uXhRoMUZKKU
 fSgV48ly+qDLtR/T/Qv9l70Aeqg49U6XSFscjfedFCKE/l8yWWfqaREtY/M19iziIAA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791187579;
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
 bh=o6ETUmpW3NZqfj86SA9lvAEhhxHMwsUHD5FKzSTxeko=;
 b=NKEKePuLZffSoF2e5OfJFZ2pr0mrOw4Ax9f7RTdXvg9kdf6Ev26cjrCGPXw259wmzwkw
 CtScr1ppQbXhY8PIVGWGVG5DcbSXdvXo1XrWu2xxGd4zPh4QKm8OP/9X4NYeFTwLTuAPO
 2H2ptJJavZk5wYUNmQzDz2p+KetZ11w4NeCYz8pfFMN7a9yW1s2Wbe1KVWTe3MfraOYn5
 DNTQPl5dSf0lwfLsgd3HF3uURbtMwhssN2gYD6nZOMjOaVCtNgbhWdeeSSjghxYzCEjFb
 gjgZM7U3Z+ml5n2ZBzYa/HNfD2E14RekVd5h7qu8hYty74LaDartPCBkr5ti3fcXuEQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=altera.com; 
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=riQEFqhg; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c107::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::1;
 helo=ph8pr06cu001.outbound.protection.outlook.com;
 envelope-from=tze.yee.ng@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=riQEFqhg
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A36D8605DE
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 08:06:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Au+CrVMu4VtyFMLm6GY0AV0gxtEAHs/dwPMbpz8iK9ln7th3MuWV+1zyUhVbwgCvoDnJvLLjGuGiRhM4Ny4BmMNuBQlPNoKYLNxjwlDBnDqD3A1S/VWSMxugkZ1LWeeyHuZEEe9sLMKU9xPREV2V8IvP8uCEOUEUfHwK+7bY11LSCSkN395cL4clHefgaErsMx2Cy00loDUsnAPpUfj1CuEBeJ9MFJMdHKS0yTe52KwrVJ4oERgraFnBoqfkV2Uq2cCyGxjFtzjWZxXeU8luHfy8HnLxxyYqBr8tDoxoHGJYkBPywKcRQ6gNhT+u4FbPvGxhRvXp+m0S/wonpLcejQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6ETUmpW3NZqfj86SA9lvAEhhxHMwsUHD5FKzSTxeko=;
 b=So7di4r3VGQRzCTU85OmMv8UzYhMShVVKsQ3Ixu9Gqzat9mLYKmSiQSUZJAli4MlCpiZNH6QSByvsD4b8td2Byz+l0ya8L8u0XAiabPi80hvs3MVn0wwM5Cfj3g0iVi27Nx9aMc9QRdFlp1cnFsQ/4FxLSLRmoXJYI5emBm3Dw8k1sgA54zksbyMyBqTNdoX66o6ZSiYsq/aRK/5TbmbGmB5G/EASXYl/BxUUXWJfay1sFyJKvCYfRuIKv3mB117ZqRGC3n44GPiUum1NTlRybf2HCA20bG+8HbxZv9nitAPkI1gsdc5HXC/n49phecwNjXZSHzWDMmwxEpYqtGZ9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6ETUmpW3NZqfj86SA9lvAEhhxHMwsUHD5FKzSTxeko=;
 b=riQEFqhgSe0h2J1YS4+f8natpIHdjWXk46nlWu6EM4C35iahzRNQ4cR+lR1QJIBPkSBjZgN/ML9zE8Kjcd+7xeAINfUjmkxf4mKtPKIoqdWdL2yp1DzxFqYtJ8m6JWhYk0OlxeT2hHn8MutbEAgh66nE9diDuSPp+gy04R/7x/6l9fKtgEwe04XWHgsJ8NT/Sdnj57n8GBU6JPpv2lutPBr8qOt+b56XvoY07d8NjM/dQMuZwbq9Y+Bx6+V1huGurUM5mxWccFQVI69/tXlzni6CimakBktqxwIesQY4YaG7jdbC75i7BuxG7sZJR+QzaMtcRf8qew8/kcM5cTFUfA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by SA2PR03MB5803.namprd03.prod.outlook.com (2603:10b6:806:116::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 08:06:14 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 08:06:13 +0000
Message-ID: <5a6c71d7-e7a2-488e-920d-0f1bce3a8d6c@altera.com>
Date: Mon, 5 Oct 2026 16:06:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] mmc: sdhci-cadence6: configure PHY control register
 per speed mode
To: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>, u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Marek Vasut
 <marek.vasut+socfpga@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <cover.1787710268.git.tze.yee.ng@altera.com>
 <15e724cc7260e5f280ccced5b453b2978490df79.1787710268.git.tze.yee.ng@altera.com>
 <ec129b92-3fb2-4f1b-bc9d-2a901163fd76@altera.com>
 <c97dd7b2-4375-4352-86ab-8870a1dfea4d@altera.com>
 <081f83da-8d7c-4cdf-8c6c-151e0372a5a1@altera.com>
Content-Language: en-US
From: "NG, TZE YEE" <tze.yee.ng@altera.com>
In-Reply-To: <081f83da-8d7c-4cdf-8c6c-151e0372a5a1@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::20) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|SA2PR03MB5803:EE_
X-MS-Office365-Filtering-Correlation-Id: 31a85b46-138e-4a8c-8ace-08df22b78619
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|56012099006|11063799006|4143699003|3023799007|6133799003|260925021311599003|260925021911599003|260925022911599003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: IGYIzUlsgdMbWhroVxHzKKXyMfqrYkCiJUe+i0kDqiu7BlGMHl8iss7iQp4PMQq1XMJI++IrUkYM4u9qCLcVx6JMAZlj3i8vf+9tOznslo5jrBlHZeaKhNJV60Ui9uLJFeq34BosVqdC8qFz6sk765zWO2sYrFWWXHRpRuDNf1O5bTgSguNe/OV74/UBeupsap7t8A9Q+x0Nx9iYTJugFltrWBmtzTeLLAGC3F8wmX+GX3tLDHW7jAf69d0qpzYrch0LhTBdDpsc1qkc0Oe7f/tnuEotJtH/h8sHJQBngu2wxblhzaiDMOIH1bvMP2KIxzjX9qZ9afBBsJQN2cwwpjKQ7hwnQAORKqccTCq0B3dsCrLU5DPI3jHCiYtBrx/sh9WQlzro/nmj/SkSl1cW706nvFXSuME6CCUsrOWjt/cSTp9BfyvNxkTEyqqQMJiH9r4QGkqDMQYJwE5hWhllTHSnnesA0BLc0GhwMFH6c+97xpQiIHeI0vSNXBeTjsoGgEEcVn/24Ysb8rc6g5HA3s7IrswGo8RBbRR5+zgR6foa9rrbI8uVXyDNI4rsL29SgsNr1bOrMN9pTB0nIQE2g+RIp6z7VkkSL0DkQTQcgEVCvmbGo6+hID8EFXqTdstb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR03MB5950.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(3023799007)(6133799003)(260925021311599003)(260925021911599003)(260925022911599003)(55112099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2ZOaFowL0NBczh5dTZSSE5ZWEJ2cmIyV3YydnRMS2Z2bHl3eEIwM0U2dDlz?=
 =?utf-8?B?R3NrL082cjUybSt0YkpBYUZWYUwrWW04MjlnWnFMVE1KemV6RUlEbFMxOGlp?=
 =?utf-8?B?aGlaVkpzaHdCVjVObkFCRGw2czZ3MFlwZ3RwR0lrcUJVUTRJL2hNZXlhVTNo?=
 =?utf-8?B?OXdQa2JsSGh6dHdTaC9SRDJnTXRDQ1d4dzIxdklyWE9WdWxHV0NWMnFUanox?=
 =?utf-8?B?em1nbmVHM0NSc0t1ZTRDY25CWGpLUUM4eUJ2aXA2dTFVbWxEQW1GOFdxNGlj?=
 =?utf-8?B?eS9rMUxaSU1oVEZScUYwNk1SbWMrUFBZRFZaTFpHem51S2lDbm52bGtoN09N?=
 =?utf-8?B?VFZ0T2pxdDk1S2JFSXZadTllYktLcEpNOWFUWndRdFlHTTUrTWZHSmRHVjM5?=
 =?utf-8?B?TzV1Qlh0NTI1aGpQOVZ3TlpIR2Fqa0JwOTA4cjlocEhmc2lXdTVEc3RQU3BZ?=
 =?utf-8?B?aDZsWHFrcmRrbVBWNnNOK0Jlb3AxN1VWRmJLelNFUWJ5YzE1WXVWQ0NhUDM0?=
 =?utf-8?B?WWhXNm11MnJuVUhkMll3Q28ySmhuZUdzdlZ2Y3pFQzMzdk1TTlJFR0d4RTBq?=
 =?utf-8?B?WEJualE1ZitqMWsycU5HSS9QYzRlUUNTTTUxYWxaemg4SFFXQ21JWnRTc2l0?=
 =?utf-8?B?WGNpR1k2aWhNcFdiNlJKdTI1QWVLT0FPN0kzU1Z5KzE5Z0JxSzZETHNSL3ZI?=
 =?utf-8?B?dGdjR0hNdno1UmY0anY0YTVGWEVzOWQ1andJTkJYeVllZjFYOFhoZTk5eG1P?=
 =?utf-8?B?SllxREhjS1UzdGs2Z0ZaRXgwa1NkN0NERm9BekxBWGR5QXg0L0V4TCt3b2Na?=
 =?utf-8?B?dDJXOTVIb2ExZnZkQ05pcTRrbUFXVWJwTkdKc0Q3RDIrTk1TSHpFdkIzcDB1?=
 =?utf-8?B?dnFNTUU4dXdLQ3lrNEFSMDhxRVVZbGwybXdqNVdhVjZaR2tKclNzZU56TlZm?=
 =?utf-8?B?cWcxeHUxTnpWdktVUDdmZWh1RS9KSzVENUJNeXhSK2g4Mzk1SlZvZ3RmL0tm?=
 =?utf-8?B?VnJEMGp5QTRHeGQwNGl1YkJOT1BKbFU0Y3RxUVdPMW9LRjRQYU9yV0RnaGxu?=
 =?utf-8?B?bndPUkptaUNzYk5ueUFTVGhJNW9KNm16QkNwSUlNVDYveWhNZkFzdEhLeGcz?=
 =?utf-8?B?RTBsdTQ3cHk3dm9xZUl1TXVkRzhhSWlKbnFpNkRjZHRBSE9XZTBET3ZLV3kw?=
 =?utf-8?B?RGVuNHV5WUVsNVZncEUzencyeEdhSWxUWnJxamNvVFN6Vm0vSDRDSUtycU1j?=
 =?utf-8?B?MjlJT3JPV0ZqOEFTUmIwYytMYjNkUkFRRXA4THZsb0hnMUJjVWZEOWdPMS9O?=
 =?utf-8?B?dkdCMzlUYTJNWHNaaXpUOFhVN3lvem9XM2paL3ViYmMzUUh5SHlyclRqR1RM?=
 =?utf-8?B?c016V2t3RllKODZHZ29aMnFWYXVGZThoS2w2cFNOVjN2TXZsOGFLclBLTmow?=
 =?utf-8?B?ekVnbmVySFhSY1FGNHhSRHpIMWRJVCtFZm5iQVhvbWcyZjRGM29SNWo5cFhY?=
 =?utf-8?B?VEdUWWk5WVhKL2hkRjBoWitUY1g0VXp5VW5SWWozcTg5dURNYktxU0RlenBj?=
 =?utf-8?B?bE10d2I0eTRHZjlvbXZGQnFzaG0wUnRhYVFOOHhiRVR3R0VlVXdwVmdySmJZ?=
 =?utf-8?B?cUpQejNRWGxpbjdTM0gxQ3RCMkRGbHdBVDNueWhXRUt6Q1VJa2h5WTNtSFVr?=
 =?utf-8?B?OUVnY3IweGVHNkpkOE1LSUprYUFNNWUxcDJWWHlaODQzQzdLM2g1MjZwbkNl?=
 =?utf-8?B?TmNmNk9uUnA4VEEyUDNqZUlwUzhoY05UZHhJT1U2NXducGxsMmUrSkQyWXNy?=
 =?utf-8?B?MlhSUFM4em9uSS9idWdEUi9mY3E3aFFmVUVNUUlIWlpRQkpBcGpSTlM5Qm8y?=
 =?utf-8?B?enU3M1VVWGx2ZyswUW1FVDlWS21KK01MTDQ4VWF5WHJ0NU9GVGFudzh0NEda?=
 =?utf-8?B?dFk3SkRZSXpEblNNWHBuK2ZxRlFVSGdmSnZDRnVSbnZSb2djRlVKdldJNFV3?=
 =?utf-8?B?UE9kb2FMZWR0c0xZb2V5dE45dmRlM1NYMUtYMzlqcEFCOC9CS2pCdDQzK21j?=
 =?utf-8?B?eE5vZXNIMHRpYVB0SUR1Z3labFZxbVE1TzVBc05Kc3lHRFdpVlREL2wyOEZ4?=
 =?utf-8?B?RCt5SElMb3lQV3E0Q0kvZWp3anYrOUlVS29OUWlkS1VSL1dBQWZWc3p5Mzlz?=
 =?utf-8?B?bFRrdnJiZFVJcHN2RGorQk4rS2x1QkNqaTlhWFV3c211NlJaWDZQbjdlN3l6?=
 =?utf-8?B?Rmh0WDRKMzNVQmZHN2pLR2c4UCtuYUpreE1XYTJGeXhzQytkT3hPKzBPQStB?=
 =?utf-8?B?L0dJZjNMTi9rR3BWZG1IVFZGa1p0VC92VE9WM2E0TjdlajFjSkJsUT09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a85b46-138e-4a8c-8ace-08df22b78619
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 08:06:13.8494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qj7+f7CfmBv9fFvJfJExT7/Y436IQBXlJEHXIcHTvu/QamqE8TryR9yixQXAEvovt4DFPr7azeN2VoltN00wHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5803
X-Mailman-Approved-At: Mon, 05 Oct 2026 08:34:58 +0000
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



On 4/10/2026 2:53 am, Kathpalia, Tanmay wrote:
> 
> On 21-09-2026 09:20, NG, TZE YEE wrote:
>>
>>
>> On 13/9/2026 5:06 am, Kathpalia, Tanmay wrote:
>>> Hi Tze,
>>>
>>> On 26-08-2026 08:23, tze.yee.ng@altera.com wrote:
>>>> From: Tze Yee Ng <tze.yee.ng@altera.com>
>>>>
>>>> The PHY control register (0x2080) holds phony_dqs_timing (bits [9:4]),
>>>> which shifts the read-capture strobe relative to the data slices.
>>>>
>>>> Extend the per-mode PHY configuration arrays with a "cdns,phy-ctrl-*"
>>>> entry (default 0x41F0) and program register 0x2080 during PHY
>>>> adjustment. This lets each speed mode - and each board via device 
>>>> tree -
>>>> select an appropriate value.
>>>>
>>>> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
>>>> ---
>>>
>>> The PHY_CTRL default needs to be corrected. All six tables also use the
>>> same 0x41F0, so this is not actually per-mode.
>>>
>>> Please fix the defaults.
>>>
>>> Regards,
>>> Tanmay
>>
>> Hi Tanmay,
>>
>> 0x41F0 is the PHY_CTRL (0x2080) reset value from the PHY spec. The 
>> driver never wrote this register before, so the PHY already ran at 
>> 0x41F0 in every mode. Using it as the default in all six tables just 
>> preserves that (the write is a no-op unless overridden), while making 
>> the register tunable per mode/board via cdns,phy-ctrl-<mode> in DT, 
>> e.g. on Agilex5:
>>
>>   013b:    cdns,phy-ctrl-emmc-ddr = <0x4010>; (phony_dqs_timing = 1)
>>   modular: cdns,phy-ctrl-emmc-ddr = <0x4000>; (phony_dqs_timing = 0)
>>
>>
>> So the defaults match only because the reset value is mode-independent;
>> the real tuning lives in DT. You're right that six bare 0x41F0 
>> literals are misleading. For v3 I'll add a named constant 
>> (SDHCI_CDNS6_PHY_CTRL_REG_DEFAULT = 0x000041F0) for the default and 
>> reword the commit to say the register is made programmable with the 
>> reset value as default (no functional change), overridable per mode/ 
>> board via DT.
>>
>> Does that work for you, or did you expect distinct per-mode defaults? I
>> don't have validated per-mode values, that tuning is meant to live in DT.
>>
>>
> 
> I expect mode-specific, validated defaults, consistent with the other
> PHY configuration values in each mode table.
> Please determine the appropriate default for each speed mode rather
> than using 0x41F0 universally. Board-specific DT values may still
> override those defaults where required.

Hi Tanmay,

For v3, I'll drop the universal 0x41F0 and the per-mode cdns,phy-ctrl 
table entirely. The PHY_CTRL reset value already works for the SD/eMMC
SDR and HS modes, so there are no per-mode defaults to validate there,
the driver simply leaves PHY_CTRL untouched in those modes.

Only the DDR read path is sensitive to phony_dqs_timing, so the driver
programs it just for DDR50/DDR52 via a single mode-neutral property,
cdns,ddr-phony-dqs-timing (shared by SD DDR50 and eMMC DDR52). It
defaults to 0 (the neutral assertion timing) and a board whose DDR read
path needs tuning sets it explicitly: SoCDK, eMMC and 013B use 1, while
the modular SoM's longer SD path uses the default 0.

The binding goes through Linux (its canonical home), currently under
review:
https://lore.kernel.org/all/25649477d9967bb04b12c6e60b0ee76443f356af.1790074790.git.tze.yee.ng@altera.com/
I've adopted the cdns,ddr-* naming you recommended there, so the U-Boot
property matches the binding.

Let me know if you see it differently.

Thanks,
Tze Yee

