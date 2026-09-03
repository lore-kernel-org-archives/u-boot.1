Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36DE5C624D6
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 22:13:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E4C8960BB3;
	Thu,  3 Sep 2026 22:13:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qb2FBYnSjWQb; Thu,  3 Sep 2026 22:13:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BB5FE60BAB
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788473612;
	b=C9pF8kfYkWp2py5EIBFmiykxEvcRpAHHsbq66WviLFf973561OzcErRL0CdgUrgIgAoz
	 jcEPtbkTpzcz+4p3SUX4407xmgnUsQ1HpkhYUcKayZRUywtWU9gPD5zHtLfJzVoP6hovW
	 KmUYWI/Az7nXXnFE6UWPF3lB+7A819Ua98pWRwPpKMAlIJDhp49yrk8CqIp+zSFSkc6Zy
	 svBgUsoYDtKcMRm+hbaJXvw8zTDGp4tmK9fBqfgjZfEkphbElH6paDRKtZqrm0Ey0VJnq
	 FmA66vP5iR9ZxwFJXrqE+Oe5jEYfNte4/SfDyuRKF3Qj2pWi7KmpGmxE4rCxDydzn6A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788473612;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=sH2Ji4KWMm4V0B3myo3f1roBi5RG331dp3d59mF+7Bo=;
	b=ktyQwtnX1lHoLGDeUy/tY8W+DUoQWkqIHAhLTWVjmyoSfYB/jk1EuwgfJkMJIOhJxU+i
	 ODvzwq2CwHmsrV1gnGEEagXUa4aJC38gw+MRweZKh7rYtF1bzRy1aTAtngCKdPj5j66/4
	 ZDy5B3rTS1iK5gK5nEeEYm7ulfJB8vewfW7W90dRWER2fxRP7nAIS9lprg6fB3FcQnpIx
	 /7xzpjIOjD0wkI7zCfAh3LgQk4/zMzIwBTp0/8IJa0+SVzIxT31aMSdpJu8kstzlyWpUh
	 vjldaVK5eL2VWYa1RM9yR3SB7RP6NhPjfYfoy9BTlsqvmXsYl0pACYJeoeZ16g1GPZw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788473612;
	bh=sH2Ji4KWMm4V0B3myo3f1roBi5RG331dp3d59mF+7Bo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L70watvzpvojRjQqAtdyLznzwqMpbQCATq3fWBZWsm081pPQDLw/Tt/Rk3kED9xkW
	 VdaFu3HQwjtJcvILJ9YSkhoOz2fDqf/dZ/SchCyZZc6oiWOOsLnfNCPmNCImqy1BNR
	 nxaaObMIWpeHsKJVqB4KOdA2J8jv8DWsi1QDnqgIUa7M5z25dLRDHK/00SoE/TLRNd
	 pCrkgJy2UQfxrWVwJ4K+wXEbBjU6FrQMF0Lm5JX5Qde3cwbqgtRVxEJFUQli2xejo9
	 pTR/TcfYZ+VETAiIlOqC7GyfL1Rp9ND6PTBL7DtJIJxixa3C4FpOdvkl6odMMvx/wy
	 0LT7QADr4KFOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB5FE60BAB;
	Thu,  3 Sep 2026 22:13:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E145F118
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:22:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C6E5140029
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:22:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ewAnOTTLJZ0E for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 21:22:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 23F7F40329
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788470548;
 b=DJwfNmeo2Q3V8PiniOEUkfTXVwH3xsC1kV+DEseckX6fw6bHsIhP3TPYyR+/9OrZqt9u
 gYCAgfNuMq4Y0/4a2EsWhUKFVSqHPAzVU9lT8uS8nAlfrnglMnvC3mpTExO80eOOtfv/q
 xQFfhbXXEa7/TPckuhdzfXsVt3tfHG7Snw5rlCuqF2zXy83qz6ZRvuh3an/AcpHNwqOlX
 b2uwY7tDOldtYP/2Df2shIaglfXmQ/3/aCLAmGFe3gqv1CMgACpIt7mqdo2g73JrYT4/v
 GucXfT0pCEej0YzfwHzvbub35sozmgveSfzLfgto9Uw4t/FbJN905nRkhCKL+9SLgJw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788470548;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:
 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
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
 bh=sH2Ji4KWMm4V0B3myo3f1roBi5RG331dp3d59mF+7Bo=;
 b=ju7wnsO0ZM7EfAjcR36fJqLC35fwF33G32GDh+emp0xRNJOYN+OvJH5kOPjaJ9r3VGNg
 NYhdVzKTnAR3UQ5Fh8G0b/nWDQUkmYxhb9lQs45Wi1FNHk0tpM6RDeibznwuIcbOstr20
 fj4MPwB+FjPYrGFrsusyhcQCtkLUQqd2Hy9NhVZI/nDhZ8Q31v+x8TXKtlGBdW5qjzsq+
 VARqr3gwHmU3PjHq7WRgnbgxAmtTST9EhK7P4ldWqua0VbL8GAujkZjLStZ/Q+HkDWa7B
 UZ832YMu+876KWFTsDMZEe8CkTd+czrABLjWU5eydSdiuCY8REwb3WK10L0SJHp2W2w==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=prevas.dk; 
 dkim=pass header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=YZkHmS5a; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=rasmus.villemoes@prevas.dk; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=YZkHmS5a
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 23F7F40329
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:22:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yXHfkc4q6+ZMkjn70t0Z60skdvTX5B9uLhacO4nf4zZZrVwRGHKEN8c2K+G8sYv4lL79lQRldLm0LUPPrnoLL44YqMDPb73hh0vogcVi5fWiHJ2jYl3lMbMhSZEtBtzQRPKcTp3RgXEmfBY/wbpa6g/ojdjcvng8BKt7DmiZfTIeRAofY8cNvh9EkiRGGkCDgzvAtugMSykcG7Iae1eiGf1fMTtS7Cl/47JNFKpENiuvy2vAHmqp/4HG3Gg8fAqAMmncOgWpCbhIL7aoQS1J7WjndTouW3dmxyhYCNIoQhZ0wFTFUGJ8ZnrmWCZvNnCanwYbXwbiIrAsxFHfnPgCEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sH2Ji4KWMm4V0B3myo3f1roBi5RG331dp3d59mF+7Bo=;
 b=MkT0T3pz9WuxbTyysv35DMuwoI7h3AGeb4fgRsLsTNzezvBHY95qQYnlI1EHXxjWoKMbKBuU4j6id3KLyBanX4Mdm6arqoMcswTiuWdMijPwVGpUPocZa1EyGBMorvRShU4nIjEfcNDXmRnBckoV8QPIgCpVWBwdTDu1uIXBzAhQLsz7d+3dSE/dAWoSgqYcmTpTTqNOOzX9G4ypFZobYTWsfLbaHI99MP7M54D8mnQ7igHICOJe2/iOEHcVZpyzKwDDDacdyBFPPD6Ji3t7tEBdhUaVxG1JQzkmvr7UQE/tsK985Hwy3jt+qeIS13mRS9tlzNnCRtfb00i6q0s5yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sH2Ji4KWMm4V0B3myo3f1roBi5RG331dp3d59mF+7Bo=;
 b=YZkHmS5aKuUk9L287TIfLCrxEhqPVr9rpKy1dUZ5LE5gnfAKhI6a0KXtoG9j7ZQ5rV0PkJmRDiWpnUK5BcUL6bTv2EbRjv6ptR/Z3TkUl5vLS1ZmgGbeerf2jre1bI8yo0DeHzRjhlfz3EiEZwHFmvypT5bZLsZeiUfA/LY/vB8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DU4PR10MB8445.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:560::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 21:22:20 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%3]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 21:22:20 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.u-boot-project.org
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 3/4] cmd: optee_rpmb: allocate large enough buffer when
 reading persistent value
Date: Thu,  3 Sep 2026 23:22:14 +0200
Message-ID: <20260903212215.2331118-4-ravi@prevas.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903212215.2331118-1-ravi@prevas.dk>
References: <20260903212215.2331118-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPBP307CA0023.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:2::12) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DU4PR10MB8445:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e7348f3-13df-4235-e147-08df0a017059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|6133799003|10067099003|11063799006|5023799004|18002099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: RTGJwhzNbuA8lxSzMb2v/z2w7l+/5MpbaTSgrWeZ3jeaQgvcpsUXKTpIfgHjx4Cs6mPplOAcTqw9yonYZTaAZh5MJM/7WAZGCS53eCUA9T2cIQKgnZmywOFdFgevddNjo3yIfyXbKIkLlTBcnrcLbyE4iGe3lMeXLulh1DA4BbPpsuGY4iltOmxoAf9l84/dnYvs7+qrbmLE7ud5MnVhAXwt26ZGx4WR6RLTh6KhJaAjziIrHleoUOuwmPDGlqOf2a7GOwki6iyoKnO/GnfZhbiyS1xAlTkTmYu9Js4DPtxnws5FZ4yjN664JY1FyhjZDJnJKN4COh1++oL8eB0jt5p0qjFceHCk/LUgCI2QBmUOdUTRYJx0oPHjls9YQA1bYgjKxht+OF9Ezo53Ntj7n4Ye+1Dkm/6tGgIDTEJ1vJiwk0kLY7CWIP4FulIbWUje4UTZirR1XvVg974fidonhVjH53IwePo6P8nQIuTVX6mWqJOf368VX9SxTkeFrjIh35B77PAoSmXynjFyWms/9wIZAqMV0fN9eOz0qkCaao4+b2dIDTuXgm5G4zd1dnrNA/mL6hns1Qc0CDWE9M0vyhZPo62AfxiNcOjB15vdoH4xIyomuCimX5QmKOxWibFwq0J8ZAqPRegUh1tUUv8MpEeHxlAPslruZJqBGULUfIM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(10067099003)(11063799006)(5023799004)(18002099003)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5yMzPLklSRxxdbJKZryqzoF2EdM66jSPzGujhtweIuSnihya+nNELqQXEhPH?=
 =?us-ascii?Q?ygtmDjNDmqznpwjC24FIcaJnfZZsmiJcC16xCQiae3iF/StF6v2pynbRDNU4?=
 =?us-ascii?Q?FYP5Sw4/r5+TbmIaWRgY9hS/jDnpJ6FG7RKOgsNWxxo8HEAhi+xQgT0kmp0F?=
 =?us-ascii?Q?Xs8IXT50eHn7BJ+3GSHlenTJrRVqmeAPLJYhlxVJkvUkmAwB3P4Z5/2cALUR?=
 =?us-ascii?Q?vZClJslk6P3mgCubh+CYkjvLwtKj3OEzdy5iTtSYB6dtnEdFkElitERBwMAN?=
 =?us-ascii?Q?HCMvbqc45pqDvqTyNBaOiqYhsJkndCj7Cz4zyxpX4NPsZFyC61z3XmR9R7fj?=
 =?us-ascii?Q?UcMy/8AolIXIJ3+iP9GbtnOolzDLnmTECCP3XoMEAemLxExd8to7ocmdykZF?=
 =?us-ascii?Q?63gAjbanaI03SjNxvB55RQMxuVgQAefR5KojtqqwB03g1W7YcW0Ye4ICGUt+?=
 =?us-ascii?Q?K6iQyrRS8+dQhoVQXIuFHMSUWlzzUeIDyvJs6ZD544sSURJYzVnfp5fEoBju?=
 =?us-ascii?Q?uJ2sstniRTdAg0Zw1SVx95djm7DsdykgAUcXvoSuyt/5xUe3Z35J7CXzMbK1?=
 =?us-ascii?Q?4vamEOlsvN0XLlKKH20uvDCf5kErFVC/x6mEPQi/6pJPMq0ZPYiPCO7Ufcq9?=
 =?us-ascii?Q?HY86Sqw2kVgExh1/0LnKtHovKoGR4BTiCf5jO8WU7Y1uEGkmQfWQUk46NUP5?=
 =?us-ascii?Q?3BCwYTMqWMfIxFq5f9rT2e43lvGBqg18T0bmiiTNlkFB41/jxxMq10oGuxEA?=
 =?us-ascii?Q?YEn++gcwyo5231kdu+Y+kDHPFPKYBimQc/ow0ZX3XqDx0Ev7CgAVYqYTp9Mw?=
 =?us-ascii?Q?dQMiEi+aMzvL308HnSmwb33zfawmJbSTWayM7DxCabeuE8IWEi+voALP0phG?=
 =?us-ascii?Q?OI4TE3R9cvr2PNKvBzxtZj29aucUhLUjN7G8P40FW3SMtNIyrh3Kr+ahoMf/?=
 =?us-ascii?Q?faJZt1SlUQKBilVFVTwLd1yxJIno8cIwPFu5qbzK+pDeKKLq1589EHBqW15w?=
 =?us-ascii?Q?AS3N0lOOV7SgM75MhqGIrC1W/1zZe7RyBBMfGqJDyumBF8NSByw8Vxl8GXKI?=
 =?us-ascii?Q?4trccgJ64nIeVqjnhIUAZVG/xGZYv3gdG6zAJF49N6YCcS8FF5lqmnxr57Al?=
 =?us-ascii?Q?PmVp6YDNGL/OugpG5TxTc9a2ncAlTH1JqykOhYA9kfo6DZlaveTZ8b9zIFsH?=
 =?us-ascii?Q?vvwPOTWcMl+ooZrRan4pEtb6N722gg1aS+fXiXUD3eZTpLFeCMBy2K7RbURv?=
 =?us-ascii?Q?5y8V9afYT6pvb48IgUGkKa8w8S8w6SpBxxMjuSVFf/gPzarxd+aXQjK8mWB/?=
 =?us-ascii?Q?/UYlmYJhrfkejpN2HGKhFUJP+QUwrBa9a2devbm3VYFtjdy+7WJ1yhutES8v?=
 =?us-ascii?Q?wTDuesujybbALghvNuDJ3k7j0EtIZVVSEguh+vLyxN+M13t/ypxySeMJpRPH?=
 =?us-ascii?Q?X6HJOYH4InJ1LYJ3viPRrDYNRlFpRKlXUaEbsgQe5HwjINLdbBn8d/ufbk5x?=
 =?us-ascii?Q?UnKJTK1zivXN31lqamTHuYoP8w542WlKXQVLFdVMhe0K+t2e3JH0+0gaorAJ?=
 =?us-ascii?Q?/L8214oWUnfZzqDD3SmllkxzoS+S04GlILudn8kuzqEQCJzLpFkW+PqbquIP?=
 =?us-ascii?Q?BxXxiqsV4YNaygdXd6AfBO62SwPLh73lfR74kdEfBMjLFk6azaaxHLIuH5/e?=
 =?us-ascii?Q?1+wsRhxSvIduWJxdZeUiikhfVRm+W/1OgeODaHTFkaRnqqrUylkBm9dWFaAz?=
 =?us-ascii?Q?zpFdADrcmBTlVpjl/xZyK16KLIFDB78=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e7348f3-13df-4235-e147-08df0a017059
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 21:22:20.7103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xs4TbGd6Yfo5lnsoTxZPDTATjI3T8prEwF8cFg6DkNfFxCVy/V7JroXBK2fEOZN6uO3sp6rl6XXTL9qNPxl8yfWRsizZ99gbrNeAnbLb3BA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8445
X-Mailman-Approved-At: Thu, 03 Sep 2026 22:13:19 +0000
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

It is implied by the comments in avb_ops.h and the translation of
TEE_ERROR_STORAGE_NO_SPACE to AVB_IO_RESULT_ERROR_INSUFFICIENT_SPACE
done in common/avb_verify.c:invoke_func() that the
TA_AVB_CMD_READ_PERSIST_VALUE could return TEE_ERROR_STORAGE_NO_SPACE
when the value is longer than the passed buffer size, and that
param[1].u.memref.size would be set to the actual size, so that one
can allocate an appropriate buffer and re-read.

However, that has AFAICT never been the case; there is no mention of
TEE_ERROR_STORAGE_NO_SPACE in the history of ta/avb/ in
https://github.com/OP-TEE/optee_os.git, and what the code does instead
is to return a value truncated to the given buffer size. In other
words, not only can one not determine the correct buffer size to
allocate, one is not even told that truncation happened.

Changing the ABI of the existing TA_AVB_CMD_READ_PERSIST_VALUE method
to return an error in the case of a too small buffer was
rejected. Instead, a new TA_AVB_CMD_READ_PERSIST_VALUE2 method is
implemented which does return an error in case of a too small buffer
<https://github.com/OP-TEE/optee_os/pull/7959>.

Make use of that method, thus making the <bytes> argument to
read_pvalue redundant - continue to accept it, but only use it as a
hint for the initial size, defaulting to 64.

This obviously requires running against an updated op-tee, but as the
optee_rpmb command so far has not been usable programmatically (the
values read are only printed to the console), no existing boot logic
can have been relying on this command.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 cmd/optee_rpmb.c | 43 +++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/cmd/optee_rpmb.c b/cmd/optee_rpmb.c
index 9a3274c4332..6f6c70ac084 100644
--- a/cmd/optee_rpmb.c
+++ b/cmd/optee_rpmb.c
@@ -72,8 +72,8 @@ static int invoke_func(u32 func, ulong num_param, struct tee_param *param)
 }
 
 static int read_persistent_value(const char *name,
-				 size_t buffer_size,
-				 u8 *out_buffer,
+				 size_t size_hint,
+				 char **out_buffer,
 				 size_t *out_num_bytes_read)
 {
 	int rc = 0;
@@ -81,6 +81,8 @@ static int read_persistent_value(const char *name,
 	struct tee_shm *shm_buf;
 	struct tee_param param[2];
 	size_t name_size = strlen(name) + 1;
+	size_t buffer_size = size_hint;
+	int retry = 1;
 
 	if (!tee)
 		if (avb_ta_open_session())
@@ -93,6 +95,7 @@ static int read_persistent_value(const char *name,
 		goto close_session;
 	}
 
+again:
 	rc = tee_shm_alloc(tee, buffer_size,
 			   TEE_SHM_ALLOC, &shm_buf);
 	if (rc) {
@@ -110,8 +113,16 @@ static int read_persistent_value(const char *name,
 	param[1].u.memref.shm = shm_buf;
 	param[1].u.memref.size = buffer_size;
 
-	rc = invoke_func(TA_AVB_CMD_READ_PERSIST_VALUE,
+	rc = invoke_func(TA_AVB_CMD_READ_PERSIST_VALUE2,
 			 2, param);
+
+	if (rc == -ENOSPC && param[1].u.memref.size > buffer_size && retry) {
+		retry = 0;
+		tee_shm_free(shm_buf);
+		buffer_size = param[1].u.memref.size;
+		goto again;
+	}
+
 	if (rc)
 		goto out;
 
@@ -121,8 +132,9 @@ static int read_persistent_value(const char *name,
 	}
 
 	*out_num_bytes_read = param[1].u.memref.size;
-
-	memcpy(out_buffer, shm_buf->addr, *out_num_bytes_read);
+	*out_buffer = memdup(shm_buf->addr, *out_num_bytes_read);
+	if (!*out_buffer)
+		rc = -ENOMEM;
 
 out:
 	tee_shm_free(shm_buf);
@@ -198,24 +210,23 @@ int do_optee_rpmb_read(struct cmd_tbl *cmdtp, int flag, int argc,
 		       char * const argv[])
 {
 	const char *name;
-	size_t bytes;
 	size_t bytes_read;
-	void *buffer;
+	char *buffer = NULL;
+	size_t bytes = 64; /* Probably enough for most cases to not require two roundtrips. */
 	char *endp;
 
-	if (argc != 3)
+	/* Use a third argument merely as a size hint. */
+	if (argc < 2 || argc > 3)
 		return CMD_RET_USAGE;
 
 	name = argv[1];
-	bytes = dectoul(argv[2], &endp);
-	if (*endp && *endp != '\n')
-		return CMD_RET_USAGE;
-
-	buffer = malloc(bytes);
-	if (!buffer)
-		return CMD_RET_FAILURE;
+	if (argc >= 3) {
+		bytes = dectoul(argv[2], &endp);
+		if (*endp && *endp != '\n')
+			return CMD_RET_USAGE;
+	}
 
-	if (read_persistent_value(name, bytes, buffer, &bytes_read) == 0) {
+	if (read_persistent_value(name, bytes, &buffer, &bytes_read) == 0) {
 		printf("Read %zu bytes, value = %s\n", bytes_read,
 		       (char *)buffer);
 		free(buffer);
-- 
2.55.0

