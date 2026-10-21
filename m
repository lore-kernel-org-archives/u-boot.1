Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC163606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 09:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UTHEv3II;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=PrpT3l0e;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=PrpT3l0e
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C90B04077C;
	Wed, 21 Oct 2026 09:52:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E1cMsmeQZDcJ; Wed, 21 Oct 2026 09:52:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 999894078E
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792576369;
	b=nD7pVxxWk0Z04sNkXp/Cvusc0ZC7kcF867poT8QIPCQUCrv1K7nOvDrWi8PsfoZib8Go
	 nz05kTVMZillmU2g1qsoSHZN2SmLJCkjKMx9QerGAQzGWyM1TjcMwVGC9II6GJO11KsnL
	 8GOpuK0De9q67ophW/3TLu7DHVmbdHQM2e0tYzo+iZEj9dvCOVg6wlr9CPNF8t93pw7Bk
	 n+orujAUS+vsE1rK6DD/sra5VKZ4O3pOfHlltcxsaiqKhyYeVfnCNBNTi4FXeJT4qCEtf
	 8KzIL5SaRSYZDmHOn0XUx1sBzv/37Xai7PrKYtvK6rG0iTNiSt+3WWRXsnJHkNGD09g==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792576369;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:From:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 x-checkrecipientrouted:NoDisclaimer:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3HFKQaU+0L5NsN1OppPCdmpBeg2Pfx/n7J3HZ89LOTo=;
	b=dHZet1BBQFNX/Mg4spMY89q3/E0Ar/LCTPpsvSdrTyi0pJtlf55J6IM5ZrCCmPChEUc1
	 9YMtFn8cVT0zwiNSYH9Kq8i0Mv/NjFSz5/wh4Kb7OvC5Pli5q8avSMkS0QPj/CZgkEB8S
	 Ijs/a23Ol+nGrmFkF2R+2VoT8BRpL+1y47o4i1IeBAtlbAQyDXMUVQ3Q1KZP/93vgLAFx
	 2kllbvxa3uEyozBIZYP0oLh1Gg2zmIJsTNV1zB+Bb5sM0bz+CkHxbU8uEQPNK1WNd5jK8
	 2qZ247Lf2S6X37ZXJkbVFV0ee8t6CitJAjeM6LKoPXIXiatjALs/GA0v0+UGItTeStA==
ARC-Authentication-Results: i=4; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792576369;
	bh=3HFKQaU+0L5NsN1OppPCdmpBeg2Pfx/n7J3HZ89LOTo=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UTHEv3IIowUSKsFoebPbvdi30lWbQajHVGTdDfOvc8Wa+sqFozu/Bss+4G9QDC2VI
	 4YwAF5YS11ONS+z1yAWmKmZ3pgSzng560Ju11RWbrO9krAVErNELp5rb0xP91jJ0bO
	 NyQ4j6/nQInSbJfiU1VzRKk5evInut+J7+cdz51B2OlxJY/EAgTiHXf9yV/wLFOR2i
	 CZKqildx/8EwOlqRThHNfUJXSjZCRBFB++KVIHoifUpzOXxIyx59zXocz9joJ9e2WK
	 Dho8tTm32fGz1DVrA4z0FUcEip22qzGA3lS5GpUUsjVlUIZAgNqyy0UBXUfwpbTKK2
	 t1zvEnP2wBJwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 999894078E;
	Wed, 21 Oct 2026 09:52:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 89A342A8
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:52:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7ADF98102A
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:52:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hXzkPgAGR_ZV for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 09:52:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F04258100D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c201::1"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792576366;
 b=ImT2LLL+XRG8q9lF+fK7vscITiEa/EOTPu9JAOoecX8KbiqZb78sI3pkAhQop/hbdznB
 BBleP6QRnIuQjxa0H3UO/Yjt+nI8ygl7sFfuY1mGwh20JRk+KxOt9XFvqS49l8F+mLGmG
 0EJ27EpyyNEL/pVTcEU+bipmpGGowsNTvpZaEC/8AijUeHxcA37XbSsVZa7l3+nJQL7ms
 CdImg/Il76FPwChjZAAnKThhblfwp6Msp6W+SOlQTNFu51RwvN8A6wfHcKTn2RxZzQ6X5
 yLINbkurI1KaPKjCd6NS4b25wL3maHMzt+AM/QP/Kst1TezWcuiFqe+4nYcv1eR8SPA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792576366;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
 DKIM-Signature:Authentication-Results-Original:Received:Received:
 Message-ID:Date:User-Agent:From:Subject:To:Cc:References:
 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-ClientProxiedBy:MIME-Version:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:x-checkrecipientrouted:
 NoDisclaimer:X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam-Untrusted:
 X-Microsoft-Antispam-Message-Info-Original:
 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-EOPAttributedMessage:
 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=3HFKQaU+0L5NsN1OppPCdmpBeg2Pfx/n7J3HZ89LOTo=;
 b=sXzhTVKKV1G5sy78AKenU16C8j8K3ypTJfkgkrBilz3SC/ENl2rm7Xk2PLL+YZlNFiIO
 NKoQ662t8fmS6I2ARgix6VQAWBtViBf+DNeyuPePlTyP5KO9NsQm44v0htQX47FN+HgZQ
 B2JjXTNoXF9VvMuacWYqzmcGJ8u05b1QNT4b0yuNTVgAhmHqLp0WtB1yT+r5vuMjZmwd8
 QxF2QAO5CY4nHsqC7QFgIFzVnrzAYmDisFA7ekjBg1m43lY/QPMdUphuT6+rfwazS58MC
 wfK86bqkBpopr6oIX0Lska4BLR/jUC/vfJb2VO79W3T7V+XKbVW+h1A76ohd8I4pogg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=PrpT3l0e; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=PrpT3l0e; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=PrpT3l0e; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=PrpT3l0e
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F04258100D
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:52:45 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Gr0ypUSlmATOV6+ROKvMnY12r20jIi4LcVZA9JdgL8mSIxs95Plgn4CUG5ZMk5JTrQffhGF3qe8v7GwRUNKHmdUsymthB9G1A6EXwKShnu4GMTCh7wcRVJbA1aQUhygM6yiy+K+w2N7LDck7dbIKVk8zf35ULBGwpqG1dAJKWbl5oTGPEcS4AaD7XSFg4GxQlL29O9IkInBqOsVmMITTC++zRUTbz4No9HOZ08Cs2n5+ER+Lj+HlX9BBXXv61/MPx7Tnt3oivY/S3kYjbRT7JAOAiDOT/nkF38VZ7BA57tPajbFFkK9WYiCS0QCIrZV9K4yP4LgUJ3RF6kFhyX6FMA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HFKQaU+0L5NsN1OppPCdmpBeg2Pfx/n7J3HZ89LOTo=;
 b=AAX6zvH8p6n01mOxy6APfSjCQKYy9nWIeWLDkIEcoumDnH2c1Dssc/XbKJ6Y/ulPdfNGJlJIGsH8/t0JB6nNSed2wNhraQzX1Wy2rJD9QbPm1lTKOGpaHKbTtxYIPZzcBRHLwJ3DAGgJnnCC6UrpZs/t9g9Nu6j805pey49LBXJr3cw5CS+VTy2+kLEIUsd+LhHXOiuRtb22QuS5CTPmDSqowy1utfR0tbWcFpKdm8XrllO/EZntak46nBpTfiMXxEUAaASaDzgwZ8NcikLTGd62zTN2Ir850iJnRh9auvENu5PtUcTTagAYW8RjS1E7mCjnxd3T/1JSVgefs/eSXQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HFKQaU+0L5NsN1OppPCdmpBeg2Pfx/n7J3HZ89LOTo=;
 b=PrpT3l0e+LL6JIKGBAAkFEcl3V2eP/0D9RUcLlqLZ5+zAgSR4CvEWgoq201AcazKEazgqLJuVAtF5Fnm5a4fdWCuPrQx4JhqDZhcfCThC3HiYMLaRUioY5YdODM5m2w8UWQvG0ORSLNEQNG1eLRR2qKYeNv4z0ZZArNfMUuuMrE=
Received: from AS4P189CA0018.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5db::19)
 by AS8PR08MB5960.eurprd08.prod.outlook.com (2603:10a6:20b:29a::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 09:52:37 +0000
Received: from AM1PEPF000C1AD5.eurprd02.prod.outlook.com
 (2603:10a6:20b:5db:cafe::1e) by AS4P189CA0018.outlook.office365.com
 (2603:10a6:20b:5db::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 09:52:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM1PEPF000C1AD5.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15
 via Frontend Transport; Wed, 21 Oct 2026 09:52:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HnZEPhzHsuiZqhZkTmW3zu4FdwJcZomEnp7Ayoi3LhSlap70JwvCEWiVfBOmeCDqIPk18NnAma82mtuY6pRs2qAvYzsbXJALtDOKlpRs10jWyxIRWHmuPj9r3ONv9pNeEVA7WyUl5NLCclcIbEwklBVv8vO5QcrIohPDiYE7dXG7DYKK00Q7e7c7IThlpn+ZAY0ybJ9wsTAqnH40Y8Oy+0JAJQLRIYz/LPpZPvbNVkCul1ARlpHtXROM9X/L8UG7TwbIoA94Tph5QRopjqRKgzPIMQYCtzFEJIf9FDWQJIIxFmLtd3gASWiLhuGdMIxiQtoX6kolpJkHXhBT1R9/CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HFKQaU+0L5NsN1OppPCdmpBeg2Pfx/n7J3HZ89LOTo=;
 b=ZPLuLrhj4OeCDcRsQsyeaXsJ6sFshFjV8BJWqL2qUv5mRBGisUbND3IR2DUqql5jL1HQJ55gchuGIa5lapcgbr1deqN3EFEMBANjB4f4KHLSR4FHNWJT86Ov3cAarsM8bALhlEAlyEhRij60Fb6UH+dNpk0edtMTtPzzfN1gr8XydmurnZrjP98BMZOr/I+xlRg6EtsSQgQK8dYp8cr2D4qPJxyBSoR3Xsk/qXwwWv3ThwWr6AYTM9XPh2fmA1o2NvkQBm5R/ci8umHknstPqZBcBxKTAbWhhIfjBwPSxDI2GN/5puLIcTeIfq/WzjIcIhh7KWihjBJbEqI/HTgxow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HFKQaU+0L5NsN1OppPCdmpBeg2Pfx/n7J3HZ89LOTo=;
 b=PrpT3l0e+LL6JIKGBAAkFEcl3V2eP/0D9RUcLlqLZ5+zAgSR4CvEWgoq201AcazKEazgqLJuVAtF5Fnm5a4fdWCuPrQx4JhqDZhcfCThC3HiYMLaRUioY5YdODM5m2w8UWQvG0ORSLNEQNG1eLRR2qKYeNv4z0ZZArNfMUuuMrE=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by PAXSPRMB0029.eurprd08.prod.outlook.com
 (2603:10a6:102:2bd::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 09:51:56 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 09:51:56 +0000
Message-ID: <8daed5bc-bc72-4d5c-a8f5-b8506789093a@arm.com>
Date: Wed, 21 Oct 2026 11:51:55 +0200
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH 00/20] net: lwip: restore BOOTP, DHCPv4 boot policy and
 PXE parity
To: James Hilliard <james.hilliard1@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>, Johan Jonker <jbx6244@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Francois Berder <fberder@outlook.fr>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Peter Robinson <pbrobinson@gmail.com>,
 David Lechner <dlechner@baylibre.com>,
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>,
 Heiko Schocher <hs@nabladev.com>, Pranav Tilak <pranav.vinaytilak@amd.com>,
 nd@arm.com
References: <20260928-lwip-dhcp-v1-v1-0-2060c7365b0c@gmail.com>
Content-Language: en-US
In-Reply-To: <20260928-lwip-dhcp-v1-v1-0-2060c7365b0c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0184.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::9) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|PAXSPRMB0029:EE_|AM1PEPF000C1AD5:EE_|AS8PR08MB5960:EE_
X-MS-Office365-Filtering-Correlation-Id: a30044b1-5a04-48d3-70c3-08df2f590919
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|7416014|376014|1800799024|23010399003|366016|6133799003|10067099003|22082099003|18002099003|3023799007|11063799006|260925021311599003|260925022911599003|260925021911599003|261009221227099003|261009223027099003|261009220027099003|261009223327099003|261009221727099003|56012099006;
X-Microsoft-Antispam-Message-Info-Original: EJTIldCRGmOt1RJs9kt1r++e09SNTYPn2zJrJTIsHkvHPSWIMjijLAEfRkUMPCvJy3iKxPoQcN9ZA/0+38Lh7YVrOOj8Jc2NlDOQmrM7T/VBp3o3I45TSSwOY0RkCYMmPGKf7LYXz8z9cxOYsawUuy2ZC7mbMN+jQmPjqZ1aAcbfZDIuBg3zC3912k1OPFBzm/r/BdJpibRjY9FvRvrkK5J/hcYzwEKjJxEkK2rZ74DTqb7BY3PgPjdDqD2Gui6RKsJa7oSSizqkKwD95EHLp9nIjHo5arBrsyeSma2hKY53rC82dpLD4sCPOJTL6y/aGR1cae5PPycdyEmbMCTFub4evhYGCv3GRh4zuZu0oK0ZMfh90tZCfAr9owEknOFueIVj078mJ7LvRAmnhsDjGAq/SGWG/ZXMcry3IjnPiH7mlCclNTvd/z+wEq3OaLwZme5xICYJZt5ySTia60xdAvUsm1zjWEguX03f8l/PtxzCHYpTnvkevJv6uDxWDv44kUVXoDWgHJpjhUgQbbFm3kUqiLmH61V7tZfWbbM3DE2BqinTVcL6HK5lYZZ29M5Bq6VwypjHVSHmLq04jpkcr00KOgVNKBDWm8k6j5dSINg=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(22082099003)(18002099003)(3023799007)(11063799006)(260925021311599003)(260925022911599003)(260925021911599003)(261009221227099003)(261009223027099003)(261009220027099003)(261009223327099003)(261009221727099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: DCIBwPJlZQLrvM2fcGETXC8H8LaUlK6jR1GgTUBfcTAFbcpZ77AY40cvg7hrOJuLI5XYl3l5WEPmWMGyPZ401z5sD4RGiqhfNfQ1LfkkNi0RN38N6JEVlpsicInwTudHciIT1hDLGJeEu/5zbmzkwGLJn99S8CC+Yi8KmShXiVdVTh2rWeZHwxSjJxO7JctOFFpQESA35dz9sOU0dHuc8IU2IjRHlgBs7ipZ9/KItDOBd98yXMoNSTSh+7piqBrvJUzhT3cbn2J7cqv1K/E86CY3QyUDDJX+mRYXXYt5WCL835bLJkHDFcM/9ZnMOl0xUVHpdDg9ADJePuF9xgW+GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXSPRMB0029
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM1PEPF000C1AD5.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: a721bfe8-afd9-404f-06ab-08df2f58f170
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|14060799003|23010399003|32650700020|35042699022|36860700016|7416014|376014|1800799024|6133799003|18002099003|22082099003|13003099007|3023799007|11063799006|261009220027099003|261009221227099003|261009221727099003|261009223027099003|10067099003|261009223327099003|56012099006|260925021311599003|260925022911599003|260925021911599003;
X-Microsoft-Antispam-Message-Info: eMPy4fhX+t9CdeBS8urMSEYirzccPnjOc4cDAP5OghK5BJAICOx8BdasRJL8CmY3Pu0G4hFf9US1mkaEoJWEPZAtwfVxR2681rp74VuAXPSR4zoAyZ3OZNzsSXEZsJsrnHDwDqIc1tfCsi/2B/Mzz3FnBxgXinHBObyz0xT/wvyQjhHYfURGc0pMTETyHg0z7eyzqAq/5fY8NiGjPIRRWVlG6pNzCFkkILAa0KTt0V/jYqwyK1Lgy7OJnLUn3TV9giGyYhPoQvGEobuBLSoka7ioUw0Q+fV9nP4ojhNrkrFHInpztpYoE0c3j8S1M1+shNQa83pgwqulMc64nkvOO27Vo3OzgnzH55ErApsNfdIiCTeLEk5kxX+T1uRmjpzL5/D8m6Nr4sXOaVAnUg3WvkbgY+mLynCJKKQazNukUiodQsfAhcmukq3RrRKeUHWTLC8cc1+kppNyp3mcF0LqjaZilRgXxuqpHfnoSpyPuKZOXmXbDExqkx8A9gFw/WJzoWDPwHrEV4dOMPpsXol8vE6QU6RBZzGIpcc+a1vKVFO4o4EAk3/ibPDE8xI/xu41nXSuHgNJDBMkvPc0rIXwOoaX3ff1/GNIXvGrJxyTC7eBv7afC5quEPJhPJ89bPTMJRQvlDdCCwjY622KMLl58A==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(14060799003)(23010399003)(32650700020)(35042699022)(36860700016)(7416014)(376014)(1800799024)(6133799003)(18002099003)(22082099003)(13003099007)(3023799007)(11063799006)(261009220027099003)(261009221227099003)(261009221727099003)(261009223027099003)(10067099003)(261009223327099003)(56012099006)(260925021311599003)(260925022911599003)(260925021911599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4Ae0+k7FR4rXHCVCTi387Dy9wsrD125KqXMrSygMAyNm+UMe5ZyTDklIgfdJ7R0Qp7rvP+L2twyFWjOW4QpaGoB9YWe/Z24Hm15dpDLO3gi9Ziimh/V2YvWcyNUDIy86MzOAH7M7Y+OfWjViY2DnJRKKWWdy3zyAET0rzD3MDqJmaavpW0KU9cxHWOwz1nqsoxMID7bAsmUHR5G4Vm0I1L+IxmmIMacxPpwLezaQ6lmn12T9vsOANHRG4qmwO/cd4AAFy+i10qeSVtFbhCLMZUIsIWMbSlSrIWMFgY58qza1iU3M5yuT7eBFxojxEcAo21hLcwQeqDF/8iPwMQ7fKusY7XcnwxWkOPIVs+7G8fs8KEeF9QFIj/rDNqvy4/XgkHiGawVnUN67B1Mzyikc93jQLF8qmhUPYvhYLLkRonyxZJOHaZpMJKVsazSBJ8X+
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 09:52:36.0201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a30044b1-5a04-48d3-70c3-08df2f590919
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000C1AD5.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5960
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Restore BOOTP, DHCPv4 and PXE behavior available in the legacy network
> stack.
>
> Finish DHCP and release its address-less network attachment before the
> requested download. Honor autoload=NFS, report unavailable protocols,
> and restore the exact autoload value around internal dhcp_run() calls.
> Preserve explicit filenames and configured boot-server preferences.
> Include the NFS filename parsing and ownership fix before the autoload
> changes, so IP-prefixed NFS filenames work safely without a separate
> series. Use the advertised boot server for NFS while preserving
> explicit overrides.
>
> Carry hostname, root path, boot file size, NIS domain, time offset,
> NTP, DNS and boot filenames into U-Boot using the existing BOOTP
> controls. Validate and stage metadata before accepting replies, then
> publish it only after binding. Retain defaults from the selected OFFER
> when the ACK omits them, without inheriting another server's or a
> previous transaction's data. Handle overloaded fields and split options
> with bounded buffers. Export DNS independently of whether the resolver
> is built, and do not read stale resolver or SNTP caches back into the
> environment.
>
> Send PXE architecture, UNDI and UUID options, including the bootp_arch
> override used by EFI boot methods. Request and retain the option 209
> PXE configuration filename. Cache the accepted wire ACK per interface
> for EFI consumers; move the legacy cache update from OFFER to ACK as
> well.
>
> Accept direct ProxyDHCP boot replies independently of the address
> lease. Consume zero-address replies before lwIP's lease parser,
> preserve the selected address server, and poll during a bounded
> post-ACK wait. Take only boot information from the proxy. Keep its
> reply separate from the unmodified lease ACK for EFI consumers.
>
> Honor the legacy acquisition deadline, configurable retransmission
> intervals and network retry policy. Retire DHCP before switching an
> exclusively owned interface, discard pending metadata between attempts,
> and leave other runtime clients attached when retry is not possible.
> Ctrl-C does not trigger another attempt. Populate the elapsed-time and
> requested-filename fields, and make the remaining DNS, gateway, subnet
> and default-autoload controls available with lwIP.
>
> Expose CMD_BOOTP for lwIP with a standalone BOOTP exchange, including
> plain replies and RFC 1048 extensions. Reuse the metadata, retry and
> download paths without requiring the DHCP core or accepting a DHCP
> offer as a BOOTP assignment. The bootp and dhcp commands can be built
> separately.
>
> Assisted-by: Codex:gpt-6-astra
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> James Hilliard (20):
>       net: lwip: bound NFS filename parsing and release its copy
>       net: preserve the autoload value across dhcp_run
>       net: lwip: finish DHCP before starting autoload
>       test: net: cover lwIP DHCP autoload handoff
>       net: lwip: add a hook before accepting DHCP acknowledgements
>       net: lwip: carry DHCP boot options into the environment
>       test: net: exercise lwIP DHCP boot option handling
>       net: lwip: export DHCP DNS settings without a resolver
>       net: lwip: honor configured DHCP boot-server preferences
>       net: lwip: support PXE client and configuration options
>       net: cache accepted DHCP acknowledgements for EFI PXE consumers
>       net: lwip: honor DHCP timing controls and request header fields
>       net: lwip: add a hook before parsing DHCP replies
>       net: lwip: accept direct ProxyDHCP replies without a lease
>       net: lwip: retain boot metadata from the selected DHCP offer
>       net: lwip: retry DHCP acquisition using the network failure policy
>       test: net: exercise lwIP ProxyDHCP ordering and validation
>       net: lwip: separate DHCP exchange from boot configuration
>       net: lwip: support standalone BOOTP
>       test: net: exercise lwIP standalone BOOTP
>
>  cmd/Kconfig                          |   59 +-
>  cmd/lwip/Makefile                    |    1 +
>  cmd/lwip/bootp.c                     |    8 +
>  doc/usage/cmd/sntp.rst               |    4 +-
>  include/efi_loader.h                 |    7 +-
>  include/net-common.h                 |    8 +-
>  include/net-lwip.h                   |    1 +
>  lib/efi_loader/efi_net.c             |   72 ++-
>  lib/lwip/lwip/src/core/ipv4/dhcp.c   |   39 +-
>  lib/lwip/lwip/src/include/lwip/opt.h |   67 +++
>  lib/lwip/u-boot/lwip-dhcp.h          |   28 +
>  lib/lwip/u-boot/lwipopts.h           |   78 ++-
>  net/Kconfig                          |   43 +-
>  net/bootp.c                          |    6 +-
>  net/lwip/Makefile                    |    4 +-
>  net/lwip/dhcp.c                      | 1093 +++++++++++++++++++++++++++++++---
>  net/lwip/net-lwip.c                  |    6 +-
>  net/lwip/nfs.c                       |   70 +--
>  net/net-common.c                     |   22 +-
>  test/dm/Makefile                     |   12 +
>  test/dm/lwip.c                       |    2 +
>  test/dm/lwip_bootp.c                 |  573 ++++++++++++++++++
>  test/dm/lwip_dhcp.c                  |  350 +++++++++++
>  test/dm/lwip_dhcp_options.c          |  691 +++++++++++++++++++++
>  test/dm/lwip_dhcp_policy.c           |  286 +++++++++
>  test/dm/lwip_dhcp_proxy.c            |  461 ++++++++++++++
>  test/dm/lwip_nfs.c                   |   61 ++
>  test/dm/nfs.c                        |    3 +-
>  28 files changed, 3862 insertions(+), 193 deletions(-)
> ---
> base-commit: 2b8902913c19eb581fb0d567201c09b8fa46ac74
> change-id: 20260927-lwip-dhcp-v1-38748e842757
>
> Best regards,
> --  
> James Hilliard <james.hilliard1@gmail.com>

Applied to u-boot-net branch for-main [1], thanks!

[1] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/commits/for-main

[1/20] net: lwip: bound NFS filename parsing and release its copy
      commit: fa679f1ad4ab22a35cb0be7c56b3a5075190c190

[2/20] net: preserve the autoload value across dhcp_run
      commit: 2dc9e78a2f16a16efe3a119b9fb9baf1aa7b4879

[3/20] net: lwip: finish DHCP before starting autoload
      commit: e84b77bd5ba0a07bb47c0d074e34ea0d0a2d2eee

[4/20] test: net: cover lwIP DHCP autoload handoff
      commit: 11e0191bc9779d85cd34b824822cbf6333118cc4

[5/20] net: lwip: add a hook before accepting DHCP acknowledgements
      commit: e64ecc8fefb54be7728125a34a6c45050c6837b9

[6/20] net: lwip: carry DHCP boot options into the environment
      commit: a6e12d3cee69d9745b12d80be54e628315924097

[7/20] test: net: exercise lwIP DHCP boot option handling
      commit: 91fd96cbb7765fe8de9494d07698ab4e4e13535d

[8/20] net: lwip: export DHCP DNS settings without a resolver
      commit: 5a82a2ff655a1e49119601370d955be83d814745

[9/20] net: lwip: honor configured DHCP boot-server preferences
      commit: deb20475d802f86e03c0f22dab9e36d71494aa36

[10/20] net: lwip: support PXE client and configuration options
      commit: da5a85daa91d39e579a0bc9d7ca5d034d8f205a7

[11/20] net: cache accepted DHCP acknowledgements for EFI PXE consumers
      commit: bfdb6ccc5c9e16d0467a4b42100046750001db3c

[12/20] net: lwip: honor DHCP timing controls and request header fields
      commit: e39b9cf4c152c9a9ef067f702af03e95c7d321b5

[13/20] net: lwip: add a hook before parsing DHCP replies
      commit: e0d9c12c0d1d787cc54bff2beff12c3e207d7fec

[14/20] net: lwip: accept direct ProxyDHCP replies without a lease
      commit: 879b114ba03203a213af7d8323ad176d4ec38b0c

[15/20] net: lwip: retain boot metadata from the selected DHCP offer
      commit: f5f9abf31d683668344fcfa08c13ae87d58612b4

[16/20] net: lwip: retry DHCP acquisition using the network failure policy
      commit: 1997c3a8969fa451e277f032d43fee5707e896b5

[17/20] test: net: exercise lwIP ProxyDHCP ordering and validation
      commit: 691e472ab3b1302b5e2ba2672d7a95d1432beec1

[18/20] net: lwip: separate DHCP exchange from boot configuration
      commit: 7e7828180484e859fe28dc3482a8ed6c2e7dd242

[19/20] net: lwip: support standalone BOOTP
      commit: b2eae04180a0faf0e7a9b33ae9d910945614b8a0

[20/20] test: net: exercise lwIP standalone BOOTP
      commit: 45d7cf4bc8cc76adec70d10e0e7230a46b31400b

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>
