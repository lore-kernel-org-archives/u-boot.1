Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF9F9C79FA1
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 09:47:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D219802D0;
	Tue,  8 Sep 2026 09:47:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qqhz44QK6iZx; Tue,  8 Sep 2026 09:47:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 32E5F80963
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788860866;
	b=tBaMnVs4RTfeHV2ROVoK3sOARmAluUriSHQwyp/nPhk6M+kN01XWGGmtTpQfe5V/JTN/
	 sJFkzb/NCnkmYEFK2W3vhgxMrLS1c0mTdDQL0gAkSjt9qPM09cbYEUTjVGBV4AxvkJbD3
	 gjsNQ7tMqO2LC/7tXg9XGUb3tcoAclOBgczxD9IFy5RO2I2nt1RuRytJb9hBsSrHqLK4a
	 mxednZ6r+GGr0P2sUaAW1DNz+9rjgCAHDFZNo6MioTds9SKzky96hvR7psOjGbskCSaG3
	 hk+s0Z9gYjQFxro4Jy0BWLnZHptE2OI6W+YaRLZgucUqA6x+1FscQyU4w/+KIMwNhWQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788860866;
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
	bh=94jfX20OnKlC65ehv4u0bo7gOoY24/nHC3Xv9NE7g/0=;
	b=QvbKgbf35qjkOGMAdKtSOArpzW08CbVme1AfV6RrF2WZO7mS6Yc5SGrEzkUqc1QTQyZg
	 mjvdsUi3zjjnbIknf6CyimYUtAg1+nxf4z4K15uxxGhncQmc77guQVQsTMi0C+1femCAe
	 nWDPlNv0np6m49DFmPR10w/gmMklbG66qmXW9mKgFkIqjOtJi41m9YmAsR06S+Pyb1Wjm
	 FJwbBmorOLOKe5Xd5tWMJpjLQ9Wqlqdgl/zYB/FceViHZWC5W/0AGH7q5xLGlDnWWb8/4
	 11cFGlm77xB7dHvUrB2ZDNehc7mu6rvZ++Lv+Bca6x3fBz5kAEpOB4Dcr023fx5gy8g==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788860866;
	bh=94jfX20OnKlC65ehv4u0bo7gOoY24/nHC3Xv9NE7g/0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WXm/feU3f2Vy0SE9WUPlSjXuxcDUB1T2Mgvc4WCgkGHotFp376bqC0+8Wsg93I/Y/
	 OJyjQ/eQUZI7vRyanNdIJQu0tFTm+0skCmAIGG3Avbh4XA+xktvQb+VUsr2h03pjwG
	 uJDLy5zaeZBJ5Yhm6FnZZzpiL2JZYngWv1lAGvv1QE88qCgdMrYc9dcEw+3B1iqHAq
	 817kx6m4I/+7upIq80QfFuybl064hPfnEGK9t3lt61LE2sSTz2rm3lqvSIELQfnJkT
	 acxrn24YeDUJfgZBaZkq4OoTEH9kyzsFGfRKX83aDvRUEz2lstC9Lqs2qnF8wn0WnB
	 6dEBcZfVVSY4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 32E5F80963;
	Tue,  8 Sep 2026 09:47:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id ACA05372
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 09:47:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9A815404F5
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 09:47:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CQS4c4ZGNKz9 for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 09:47:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7EC12404F6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788860863;
 b=f4+JV1gFcpOJnf4akDR4VZGrp6JldbaXxxv0QsWr3IOogdY4huxyeykHD/TAKO5soB9s
 vCIpDAh873oPdkRJA103/+8EgrBoEW56C/crmw+BCsOn1yHWxQ+XHToZm2M7IoVKG2WNj
 ZQRg08M1aBPsS+W//M2qZ2zPzbr1RRDgA0TjWtFN/0a8NFEVnMR0PNoV0shgayQJ2ZcwV
 BA9/kRc2I06DF0Yz39yrS10ANSnhyCTo45QnxZEsPNLhlsmIrJAIVXGb9kwrfXi5nrUKb
 nVD7scKvQUmRCTyJScpUO5UdMAe/7j73jM0Yp8/OLWflbg+mX9fyU1HNtTBaYg/jgDQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788860863;
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
 bh=94jfX20OnKlC65ehv4u0bo7gOoY24/nHC3Xv9NE7g/0=;
 b=sUzHJCRvPMvbPreSt7SOMAULArra6Tr0wqKL8IVq0NHkPYvfOk1Js4b8f2qB7vZU1qqa
 aEGviqK093ybxqkWW5+KPa9YtBAwVQ9uzDV3PhBZK7maqhIPbn9kYSxkQBo5HcwpFNF7z
 hEKMUaZ546qJ2kzrOSU0+CZXb/UH88K70S/vYNeTfU5lrnM5JBWHF8q5Mkw5FakWhZi5N
 ui2fqHgqoiSycOiicaIYgfpTlfeQowF3//rj3kiA0EMErbjyc42pFvCijKlh+KEVeS2h9
 FmRrFXTZzVfu7rh/1Tp+IYygkfHDuDuTxqye69uZ2DhSx068fNfN4Us+0VCXjuQMY9Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=ZHsW7oMF; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=jan.kiszka@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=ZHsW7oMF
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7EC12404F6
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 09:47:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQFThXH5MX84jKI237JlIdE8ii1EOHE0KrYaPS576H65CxjNW47eDKZVXzwRThKv6A7CMJPih2/lerpWwldDBA0GFVFItnnNdB6Mp/aiM11gC9or+xmXeVPcACbylWkRGOk8nNZjg6OT0YrxwKh89opKnJUjvak8+UrlZUzFgJaKaXIBYBwPBnjPZSf+GyeCG10ASq8p89+sjEH9KgXJk7xKugHSH91wXlH23ap6U38lFqg1I0OBOtJ6/095/RPys+/v8xORH7PPSJOO5vRMV+U2nQ2ZqM8Alm/CTNaeRpkDxgmr9HH+NlqCwbuvhzGP4bCtVrFFKulSVQYibOGzMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94jfX20OnKlC65ehv4u0bo7gOoY24/nHC3Xv9NE7g/0=;
 b=xmBGULVdRlXWOEIDdkEKkf8VdA0UrGW22a5t2IrVpMZBst93cCr+kAhJfYCVBhHOgfXvs+03hUrqZsxhgMPHG/GRh3+6zhx+FAcLWqpg7inSffZvElJKQZEDq3ikhWhBsi8EEkPeg/qEhXQ37sZm3th8tc2Z63wrO4Lqx3iTVN1llT7Y8TzJgJwQ92frglAse8hhrheCv5/MolIVfI+OGx8PiAOBtQtJC/JyuUKUm8o2uY17c2wAheR4wSG39brivJdsNbRCTH3vbZQa+kY84IL5x5aXHzwI84dFDGCZBU2Af/z/TeIfSrw50I6Uw7rnwInF3F7F6ZlhJOiq1rGLTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94jfX20OnKlC65ehv4u0bo7gOoY24/nHC3Xv9NE7g/0=;
 b=ZHsW7oMFQSCqiWL9I5pfoO7iIC+F7/F6UnMy8/mO6zrUGl/K1AtnEU8xh54PrIje/JoybBmUWSO2EBXKdPWAXKrMgeVNawXm1OmVeb2nAQ5xr1HRVSF3j4t38h65ADj7BrRmKc9KiIQAtAwzKu+C+xkNQuyPjsrYjuF2TcePNaw2Wv4zWANiBuG2BSWMEl+UtLkSXe5/dRWIDeA8vWb5/cLggzCC0bzAY4G8AziNM9yTFjixHXDnUza38mmv5AssDMUVeiYfOGxoSwMDTfDaKyflhD8AXnsGTzqsyfqp/aMouL5dn5WYl5aWLihTN0L0wPlPMd7bIoqvsoxP/y/bGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6083.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 09:47:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 09:47:37 +0000
Message-ID: <1084fdb7-2750-4aae-9d5b-d7102691101c@siemens.com>
Date: Tue, 8 Sep 2026 11:47:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] tee: optee: Factor out service enumeration and
 binding functions
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
References: <cover.1787514446.git.jan.kiszka@siemens.com>
 <70c9bcf676e253ed8c86699237c74e41c86eb34a.1787514446.git.jan.kiszka@siemens.com>
 <DL9QV3I7AB7A.3R0777LUCF562@linaro.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <DL9QV3I7AB7A.3R0777LUCF562@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0312.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6083:EE_
X-MS-Office365-Filtering-Correlation-Id: 80542e73-3110-4eb1-6a1c-08df0d8e3753
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|6133799003|10067099003|56012099006|4143699003|11063799006|22082099003|18002099003|55112099003|3023799007;
X-Microsoft-Antispam-Message-Info: 7cj0/ZMIaKcYwkaeihfAhT5070KC5qw0BVJ0mnXVRr30amfSmbdWWKcTwWQNEumyeIOCcNZfLHAQmnOaZlIsJB2pdMm/12mWmeiVgVpLPzK/lOWOU3csIdDn3wc1d8040spZHlDGG5oTApfruBVRJCV57rmdH2KfDUHcuVgNTuTLqrYfccivxaiaq8enAqf333bPCLBlM3EGjZJ/2UzAIj62F4OzifClj0AT8PiPacbclVd2iaVZ54vbJZkGyLi2necTbkGQnweGOypsl04N8b4oU5x8emQ94qis4h+Ej+SJZVA2DA+uflruj7DOyWuFogcCaNJNhIAmLahKkJRRVlQ9D3eLwMsHT2dnuA5e8XdXxFWOSjiLMS+EHj88Alk0R28LaGr0V7sagSjbFRUz1L6ukMSJ8Z9iOt8Fazt5Gg/mMBCgq8i4NDdbfGbyggivsLBll+dBPS8tb0l4UHqW+FzmAnZc7bUZ85v+QWml4O4NBCSTzC9YCoFb/zvvnEPxwDJfIxQnqbOPDGkyZ3lpp7P2g7f+sfz7AZoMP74ZwP70ZylqCBreqes9/ZsvjDtVuAE86//1Km6Gl2wsFuue6w2fRU08CvvAx9veBDakeSvNDdkOWo9o9S45quZapk7bkm+5i8secIEC5JIv5Bx+QPbJFKN6T4Lz2+L4QTN6B0w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(55112099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1BiSTBOd0UyY0dYdWZaWWZkMTcxKzZySmliS3k5SHdtOEMzY0prT1F0dDJm?=
 =?utf-8?B?WGVnNWQ0WnJSMWJDTzAyTSt2YWl3RjZKMUZGNnFBVWc4bXAxZHh6Z0JtQXc4?=
 =?utf-8?B?Ylp6Z1A2QXliYmVoR2FEUy9hazlsOThnYitFVkJHaHRFdFBuMi9iZ1BCZmpD?=
 =?utf-8?B?emR5TGVYL0hKcGRiRXVUa01Ud1Eva3hZcWJaS0FxandqMzNrTzJDRk9VOW1n?=
 =?utf-8?B?RXZwUldvNHlVYzdaRkR0WkhhL3NJN0RlcFlnUWVJY21WN1o1NHQ4a0hON09F?=
 =?utf-8?B?YnRjM1dyVUxzekJRQXVvT1hvRHdSWGdBYXlISGxCMkk1SUs1RWd3N1R3c1Yy?=
 =?utf-8?B?b3kyVU5sMWk3YU5vdXhjdU5uZVkwS2dzUlZLdmRpdk5KUlBiTWV1VmdSWVI4?=
 =?utf-8?B?blVZWWcrejNaQjJzZSs1WWZaTVZPZVlaYzhNdlR5VURBbzg4WWtqeHExV0xP?=
 =?utf-8?B?TTdGWlhoMzZPQi82NE5NRnp4TlhtdXFkY1RpNVZNTnhTYXorMkNRY2xGMEts?=
 =?utf-8?B?S2QvODcyZlAzSkxLdDRhTU5VcGpPa2pOVGxIdVFPTGQ0WjlZNytON1FQd09H?=
 =?utf-8?B?NkVMOEs5QUQ1RDdNUWJlMndqQWU1NkkyNW5ZNVludjI5b0IvaUdsb0d2WHE5?=
 =?utf-8?B?ZmtjMERiOWlBdDU0N3FlY2NoQUZ6WmxBLzYvcll2MlBVZ0JxQW1DeUNESW0v?=
 =?utf-8?B?RlJPM21tc1UydkpaQVBJeDZrZXk2SElOVSt6U2xDQVByTXZKQ3F5WkpReHc5?=
 =?utf-8?B?Z2lrT01pYXpmN2NBN2IyVEljVFNERkJoZjhLRW5aSkprd3FLRjc4dklFaGFE?=
 =?utf-8?B?SnpEbWdXdWUvMHZWaXRXNVB0Tks4RUUzbnp6M1hxWkYxVEcxOEMrdlk1ZmhO?=
 =?utf-8?B?Um8zNTRjTEg4ZXlVekJ4Zzk4UzUxSlgybHlzaUpkaURwMVhBTWpNSFB0NFMz?=
 =?utf-8?B?bkI5MlBlcXBMbFNVS3dqNDhVUzN5ZUpOb2VwSjVLWGJxR0UvQnVpNEZWNGhh?=
 =?utf-8?B?Sm1yQ3h1ZzIzZHUxVGlWb1FUT1kwNGlBMXFFanBPZmpTYytlM3B1VThPVjlC?=
 =?utf-8?B?OUZnQzJvZmtTWExtQlFURnE3bC9oMzd1NStUMjRqRDJ1SHRQb2xGbjVYYVAv?=
 =?utf-8?B?Y0VBaUJDNVFWeVJFRFpTdDNoMTBGeUZxVHdwNFpXK09IeHBNdjBGM0VaeTNV?=
 =?utf-8?B?cTVjQU93MGNxZUhMN3FvMmtxbXFVQi9aWEZ3NDBjZHlaNWpHcHpCSUNuVTZD?=
 =?utf-8?B?U3JoUGFaUWFnWTM2c0Y4UlNBNCsxejBLeEpSY3dBTDV3aHgvZ28xVFZNOXQ1?=
 =?utf-8?B?d0s0RDJmSUV2QTdZSTFGSjhpQWlGS1phTEZVVkFQS2Z5Wjl5bGhjMy9pZytZ?=
 =?utf-8?B?UWlDVVgvUitEUVlGVW1LWTJyQzFQNUpGUWtjWloyeks5dStTd01KUlBTYjd0?=
 =?utf-8?B?dWdWRzZrL1NNV25JaTNCRVU2dWx6bzJEWkJiSklzS0l2VXAxZ0tnOWw3dWlr?=
 =?utf-8?B?dWNaVEdFM3B1RWdaanZKcG9ibVU3QVk1OGxqV1RNdy9VUGkrUHp2bDdDenVC?=
 =?utf-8?B?ZWFSV0MvZXlYazNLZjBvdTR3Ymp2Z083TGlkNkRtRjYzWVVCSTFoblR2Tk1q?=
 =?utf-8?B?S1pvN3JYS0dpdEdZaFNTdjJoTEsySFhZTTVJMFpHeEIvTDJZc3ViY3E2UTVN?=
 =?utf-8?B?WUNBeFVqWE9yV2t2ZFJJY0hScnBYaVEvN3h2RW4zOVNQUnlHSzVPR1BMVitN?=
 =?utf-8?B?MnVGZnZzVm1DVm5oUDlxQU94b0FYS2JpNmJMdFg0RmpQckVTYno1VmJKQTRK?=
 =?utf-8?B?RlEwb0hITVJncC9hSzl4KzdITWwrYmdpKzNscHVzR0RkU0dmZjdXY0JJZHM4?=
 =?utf-8?B?eGNzNG1uWFRCR2VwcHl0US9yZjk0dGdyR2l5c2F6L1hYNm02S0JUc0JCU2hQ?=
 =?utf-8?B?bXlQNmNldGt3TFE3UVhXTDM3VmVEeC9ONWdnUEljTENFNXhLdkxrbHBLNmM2?=
 =?utf-8?B?V2dWdG9vUUpDT0FBUHRuampKaEYxUmdJc3F3SzJaUjJTWmEvQiswQUVpWmk2?=
 =?utf-8?B?b1UxcHRYNGNnQnJIaGVvcXFudkJjWUQ4QytWZTJ3a2IzaTA4aHprc3J2VjZN?=
 =?utf-8?B?UGZvMHVwN09kb05qbEtUMXRnbGpTYmpMV1J5aGZ0ZG00bFBYNUl1cG1OR1V1?=
 =?utf-8?B?b3R6QlRPdmxXUlJoNkNpRVk3anArbnl5b1NXbi9ZSHh2WUxhRjNXZU1ma2NT?=
 =?utf-8?B?U0FTOThOMmgyQ1pGaEFOVSthc3UxNHFZQ1pTU3NYSnFacFRoSWxjQkRtdUpD?=
 =?utf-8?B?eDYzcjNVM3U2cDJqU3BhOGVCZlVvUkNxSERYQ0djZWdwc05PWXpYQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80542e73-3110-4eb1-6a1c-08df0d8e3753
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 09:47:37.5984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: invHQp/O4FQ8w21MesGDbn/lne/B9f32sUWpIAIWIVvFLxbhcpwGejlHzfEYj7DWUbotb5xBSRo4jmMo8nXCdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6083
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

On 08.09.26 09:08, Ilias Apalodimas wrote:
> Hi Jan
> 
> 
> On Sun Aug 23, 2026 at 10:47 PM EEST, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> This already avoids code duplication between the different enumeration
>> commands. It will furthermore allow to implement a third one for
>> services with RPMB needs.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  drivers/tee/optee/core.c          | 33 +++++++++++++++++--------------
>>  drivers/tee/optee/optee_private.h |  3 +++
>>  2 files changed, 21 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
>> index 4d67c948ec1..2871760a7b7 100644
>> --- a/drivers/tee/optee/core.c
>> +++ b/drivers/tee/optee/core.c
>> @@ -156,7 +156,7 @@ static int enum_services(struct udevice *dev, struct tee_shm **shm, size_t *coun
>>  	return ret;
>>  }
>>
>> -static int open_enum_session(struct udevice *dev, u32 *tee_sess)
>> +int optee_open_enum_session(struct udevice *dev, u32 *tee_sess)
>>  {
>>  	const struct tee_optee_ta_uuid pta_uuid = PTA_DEVICE_ENUM;
>>  	struct tee_open_session_arg arg = { };
>> @@ -176,31 +176,34 @@ static int open_enum_session(struct udevice *dev, u32 *tee_sess)
>>  	return 0;
>>  }
>>
>> -static int bind_service_drivers(struct udevice *dev)
>> +int optee_bind_services(struct udevice *dev, u32 tee_sess,
>> +			unsigned int pta_cmd)
>>  {
>>  	struct tee_shm *service_list = NULL;
>>  	size_t service_count;
>> -	u32 tee_sess;
>> -	int ret, ret2;
>> -
>> -	ret = open_enum_session(dev, &tee_sess);
>> -	if (ret)
>> -		return ret;
>> +	int ret;
>>
>>  	ret = enum_services(dev, &service_list, &service_count, tee_sess,
>> -			    PTA_CMD_GET_DEVICES);
>> +			    pta_cmd);
>>  	if (!ret && service_count)
>>  		ret = bind_service_list(dev, service_list, service_count);
>>
>>  	tee_shm_free(service_list);
>> -	service_list = NULL;
>>
>> -	ret2 = enum_services(dev, &service_list, &service_count, tee_sess,
>> -			     PTA_CMD_GET_DEVICES_SUPP);
>> -	if (!ret2 && service_count)
>> -		ret2 = bind_service_list(dev, service_list, service_count);
>> +	return ret;
>> +}
>> +
>> +static int bind_service_drivers(struct udevice *dev)
>> +{
>> +	u32 tee_sess;
>> +	int ret, ret2;
>>
>> -	tee_shm_free(service_list);
>> +	ret = optee_open_enum_session(dev, &tee_sess);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES);
> 
> Any reason we aren't exiting immediately here?
> 

Just maintained the pre-existing behavior. But I could do this as well:

	ret = optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES);
	if (ret == 0)
		ret = optee_bind_services(dev, tee_sess,
					  PTA_CMD_GET_DEVICES_SUPP);

Simpler, in fact...

Jan

>> +	ret2 = optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES_SUPP);
>>
>>  	tee_close_session(dev, tee_sess);
>>
>> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
>> index 1f07a27ee4b..25b6b3c3218 100644
>> --- a/drivers/tee/optee/optee_private.h
>> +++ b/drivers/tee/optee/optee_private.h
>> @@ -27,6 +27,9 @@ struct optee_msg_arg;
>>
>>  void optee_suppl_cmd(struct udevice *dev, struct tee_shm *shm_arg,
>>  		     void **page_list);
>> +int optee_open_enum_session(struct udevice *dev, u32 *tee_sess);
>> +int optee_bind_services(struct udevice *dev, u32 tee_sess,
>> +			unsigned int pta_cmd);
>>
>>  #ifdef CONFIG_SUPPORT_EMMC_RPMB
>>  /**
> 
> Cheers
> /Ilias

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
