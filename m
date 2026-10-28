Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FB7606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 09:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ULwXR1zC;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=qTTUoNEo;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=qTTUoNEo
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BFA2940664;
	Wed, 28 Oct 2026 09:27:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eV3JNUs2HF6l; Wed, 28 Oct 2026 09:27:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E53F2405BF
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793179639;
	b=pbHrPSPdNUsN7AB2w+S6WJsPrNEc/45WDIdMZz6+D2fE2y6He2sum7Vi6vvCEracZ+Ph
	 PDD9A3Hr0xPar1zotvVaCzOf/aoYaQ9knOfM4v4oRbCKWP1fFECTxtXXmyaZf7+Izpgi8
	 /47laaDtxcbWI0swaTIKMfVzhx4w041sn5xXwLEMsO/q28tF2tQ4newZfX7G1lXhFXJN2
	 LsdJ+QGqIm2Pb8x6U8uC3kJUdUT7TxLIwTUL3iff2LrRXdRFjEDiFCepP1oagWbWuAcg+
	 gGbAxaKIgx8lhfj0ClEfQQs3ID/Sy/19WSbe9eT9Xe/z7aJ4rdHjK04xPKF8QBSgmnw==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793179639;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
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
	bh=f7yPZcUNGpY8xkWLDjmmRJqjwzrp3ECyILByCItk0kc=;
	b=F2azPihVfNxiTlrNop9GqWUELgSPcU8OuFij7fvUmWUMyKLezrRgNZ8Ax0pOk928yUL1
	 SxyOjjx1HHpuo8I0DpUmcnbEKCjjc9Q3GX5KDZRuDChRUS+ihOYDNWmcyc61uWk3ULdaD
	 aD1APeukpMzMZ1eWT+1/PnGlNZKgYWsGpqdTWceN7srGLrQUejZdk65W4JNxmN9H5Wp1+
	 R0UDHQaxUq4LbVTNyYNKDbmyFzIWvXIg7mbFFUNtKyuaaenitsbdSB6WLWSNzYaPxYkvi
	 M3p/puGd28jckJa/0qlLr9e0trhMCl5DSjb8Njn/cu7AuEvg8658ywA5cJuxtZRg+ug==
ARC-Authentication-Results: i=4; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793179639;
	bh=f7yPZcUNGpY8xkWLDjmmRJqjwzrp3ECyILByCItk0kc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ULwXR1zCUeTLV9umf+O0IFwfT0h5RBFsM4g0n9Xcunbb6uXqAnV28dydeFgMjyEhN
	 SckgFzibMLsT07MXqqPlBhPKvFJePwYrH7tFawMgYW6J06hpEyUqBXZOygRWKM0zAp
	 pNz45ExIlwKdPLjkULZDKNJQjp/qCPE+QELZ2kSWG8HLlmBPi7xQ1RnJ8sybGmMU8Q
	 +YNCUDHcWJGGJaUWIjjE/DU4ld8BtKwiU4FsSOUNMgC8kI9nLAeRkNiECoW+ScrcA1
	 Reyl4cM2czSY9ttemFiWyehLCXFK1bC1pEZTGvxnguxkElMJswTjIz+V2dRw4fV0N1
	 QrZn1xE0TPgdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E53F2405BF;
	Wed, 28 Oct 2026 09:27:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B9E0972
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 09:27:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5EA1480E7F
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 09:27:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BYQOaA4iD_CH for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 09:27:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 078AE80DA7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c201::6"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793179635;
 b=Kmo8aKqK3A6DI2rSSNu2AdVLIroI9j9xXPGeHVQMRLQXojlGOn+tdteOU5bxcsLAowly
 JCIax2FDFV/crqZMGgXYNpwYOvTKvFvN+UH3X0NQdbB2xm5YqnE+c4XtRcCryOWJDxdxw
 9iNizpuq6sGOY0kscpvQ3Z8xu34J9U1K+GgofI94heA9NqrDUrPmzNdsyx8iTfwaER05V
 gzury3jvWj92iCnUlsN1aF5Cl3SGvxJqjodxadRszjQUlOaGAUdAopq9qyTQDR4v5Lxv6
 xvKLxArAp6CrI/YnxssG3K9GSLc5GYjLdX7gv1vwKRUAGaaa3qOFXATL8xBD9RHF03w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793179635;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
 DKIM-Signature:Authentication-Results-Original:Received:Received:
 Message-ID:Date:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
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
 bh=f7yPZcUNGpY8xkWLDjmmRJqjwzrp3ECyILByCItk0kc=;
 b=emHmuo7dPDr2X/z5O/9/7nBMjD6fLBkYDfe7N5aiFD+qHE0dUzbSGKumei/HTuQGmTxb
 RieMq0adgLPIasx9SIx26tSaC9TnBf0a/Ya2QnmsPY0thj1cCwoH3loP9I0CIR0vz0c7z
 bI10IhJvc4dLeaRp+fHc28mArVqRl51EfOOyIb8e40c3RRBnqYPHlVsbC7fwGTb7X0bs+
 ZrnaVKMlY5NIPYUrvV4ATcKi7B7fGZzo50rgf+magm+R7W0EPTNh6iTwx7NrqlTIfrpTS
 dE+G09VPyeUykfSP9XOXWXUtNWTqL3XUOA1TulsjwLuzbV+zou/NlOg8r0wYe8mooZA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=qTTUoNEo; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=qTTUoNEo; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=qTTUoNEo; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=qTTUoNEo
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 078AE80DA7
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 09:27:14 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=nfGnFQBCxx6LbsWX95hr+TQykI/5GbQvo0gJOGOQUCPZ/buFV1XSAktEZNb/0xFbHUAfWPB8tINLzv3S/SzrbMrJ5WsShOSzTSiJHC1+3T6WurkOO7ODw9i0akbiV3Izw7xiAmiDIYsYFn0ATnwF9A5OrYwc7+SFeVnwAKHAGR4ZJGTk/D9IXMDCjM24B4eatsd1unU+0a6OrYaVveTVh70eXEXsJfWTxvAvqGRZnFR/lAyJoEObhyFaaz++c7YFQK/tfH7SkAsx2ci7P/VV1tlqbUzKCp5eJM51B6yoI83S1h55HV34aasRH9bwP35CTNCctTX5V8o72qpUGF1hJg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7yPZcUNGpY8xkWLDjmmRJqjwzrp3ECyILByCItk0kc=;
 b=ofzmSLtLM5oWd58AXFGzfTRizbIUCC2koMrv1wOxpfYhdI821TINX6dVbAAjixL9wEoSuUprhRKlPxFDw0kKSSy4Z2by6lA9kIfIDmZS8Q17qdVJHNeMUGLGvEx40XhOor1WXRBGGJ2WbHMUmCBABNrZsYgfpdrUsit0Zkdd4IoH1XzrjUtQT78US54TaxE/5LOEJQOoEqbntB+FJmjb3brr+jRc+g8stGBFcrsXFeNEbiETF50R78K2r8/MUrSbvEl+DHHPXETpPAoI1EBom8bE5gJFYnD11wTwF4Lzb4yrCce9GBSFp6F+UjbNA4wW49cRgoFaiYNB3Xxs5/EsFQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=chromium.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7yPZcUNGpY8xkWLDjmmRJqjwzrp3ECyILByCItk0kc=;
 b=qTTUoNEo74XGAufcuJXjl5As8NlPWm6UHiaf2AuaBdp26+GGQN92nhosjPFN75ywTAgY0Ln+CUu0cEZ0Em24Os317qURobLCikEZjEMU9md1Gpf/cFxLrex5bECcUw7zzVtRHcew/vrbWO7xcxk5bjaWXHPOErUdkzvlct/RbRA=
Received: from DB8PR06CA0056.eurprd06.prod.outlook.com (2603:10a6:10:120::30)
 by DU4PR08MB11696.eurprd08.prod.outlook.com (2603:10a6:10:645::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 09:27:08 +0000
Received: from MAD0EPF000008BF.eurprd04.prod.outlook.com
 (2603:10a6:10:120:cafe::91) by DB8PR06CA0056.outlook.office365.com
 (2603:10a6:10:120::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 09:27:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MAD0EPF000008BF.mail.protection.outlook.com (10.167.241.168) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.4
 via Frontend Transport; Wed, 28 Oct 2026 09:27:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwZRzhCsw2FRNSWTql12swRTTh5diZDd4dwV9Ki6t1H+qxkQcMi/OCqihMXK9dA1C4bItUMsLn1cr6GeY5L4eQhR4JEMBoh68j4ZeKQCo4catt5Cnl85KHHIJQtKtx1wWIJWbyxbAeiWd/PkngSNGPrDOC5SmpqSiisrehaofQLYkwz7sZiRDQ6odes2DGk7i4zrUW9nOSQj48KStMFPFt1SNZsiHISEZiK4YgAo/O48ZB66vQ/hWKM8SPZAuJgHj6m7jDIBpkwHam2gzvYwsoPuBmgav+Ux7ZJacGPCOSPmK5ruBTY2Nt5oK0L/UV7kUb61YQOMwPhwOckgfK/RqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7yPZcUNGpY8xkWLDjmmRJqjwzrp3ECyILByCItk0kc=;
 b=qwm3piThLyh+QTxXLivuWPURWFcj0+EEb9/m9abZ0CDGxm7P1mtz4P6474AUIj4wSU8PKCnnicrChk4xsy/qpTK6D9lPNoKkvb/pJs35ymvUpZMk41OyJlbvp+91f6feqEbBBylf/OBhPmRsM7cxSf+uVIdYPCKcktkfhiDm8nvB+jfp6YOqDiwKuisbrmc/Mef6rRBRA/3pETawafZ77TAFNGMYk/L0KDvg8gXD6Z4+snhb401nwlAqN3KsjF35vtHymI3i+3yQxCkhyhO2Szfp7sVIII/HtjCkKWHCpu4TLC/DYSe9WSaLbmnD2VfrTRRgLfgOOWjO+vL2pVfjLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7yPZcUNGpY8xkWLDjmmRJqjwzrp3ECyILByCItk0kc=;
 b=qTTUoNEo74XGAufcuJXjl5As8NlPWm6UHiaf2AuaBdp26+GGQN92nhosjPFN75ywTAgY0Ln+CUu0cEZ0Em24Os317qURobLCikEZjEMU9md1Gpf/cFxLrex5bECcUw7zzVtRHcew/vrbWO7xcxk5bjaWXHPOErUdkzvlct/RbRA=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by GV2PR08MB11441.eurprd08.prod.outlook.com
 (2603:10a6:150:2ca::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 09:26:33 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 09:26:33 +0000
Message-ID: <9a4eaa5a-02a3-44f3-84d6-6559cb47a42f@arm.com>
Date: Wed, 28 Oct 2026 10:26:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test: Add helpers to preserve console silence state
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 James Hilliard <james.hilliard1@gmail.com>, nd <nd@arm.com>
References: <93e4e89a-6c3c-4a3b-aa90-bd9090a6daaf@arm.com>
 <CAFLszTiLcqE74HGeQN6-_zE7sPkboHwvu18c5f6WyZov-09w+A@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <CAFLszTiLcqE74HGeQN6-_zE7sPkboHwvu18c5f6WyZov-09w+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0045.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::14) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|GV2PR08MB11441:EE_|MAD0EPF000008BF:EE_|DU4PR08MB11696:EE_
X-MS-Office365-Filtering-Correlation-Id: 893f706e-6614-445b-9db1-08df34d5a2fd
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|3023799007|261026121527099003|261021123027099003|261022105027099003|261021121427099003|261009223027099003|11063799006|56012099006|4143699003|18002099003|22082099003|6133799003|261026140227099003;
X-Microsoft-Antispam-Message-Info-Original: MtBJvK3EhZTRt6ns+fttdIRCzlmdtWc5qm5pZCvs4b9Ci9J0cUO+Z1HUIE6ayzBr3Cy4RDKiePE1GKq+KZYqSktAkPxaHdWOhqwSutIVtZWkHioeunYXDXLI6VyrEpSZYhsTfc6ibBxCx1zEeAAh7jB/THoz+rlXrdKempL+Bub2YnPe1c+591t6CoSD6nU4gg1PNP/7XqJPGnax/YJAtSTL75uWO1YbLxcjT8AjH4V1vNpW/TV0UvzSLY4UKth1DOD+xmfjdxztk4JDj9v7rlbh00UMngwoT0BbeoMdwnRK9sUudOY6DcwToMFsPJzpUGEtJ47RQrb9vsBCOcOj5RPV+iDqRKRDGTFaS7EjiGPMqDvAgzau5TPWKVx+AjZ6vOm/Ff12QENPd9PGUlpMX9+HpehKu5uCdOkGRjZQ8dRp/htjJ5sOqSuYk4za5O1D1dJODyTURC0H1j/MtATj0JUdkv1w+JP9w8zKN61gO9vYHvAT6/ZJEU7ctz251aSGl9MGipuOu0RcoZZGInskSAc0BSIQxgh5KTVUi5n9YBSHhf5LHksr0AhkUpcHUelbi/OtMjmnQl/TBOsCLITpicGZ/Ref/9ls8/Nm1d6GfQGPxIwRq2XF3RF132ijflxV4IoCdcBwAfdJVpKGd/S2bzdB01xnXbVpYPG3KlJ2aEc=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(3023799007)(261026121527099003)(261021123027099003)(261022105027099003)(261021121427099003)(261009223027099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003)(6133799003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: UUHP6Y1K/1m3tZ6Gg2GapzdJ9X3vI/8OYTOM70V+lGi2PNDwmAjpWIJptBQeMkWxSbqehacyaD0OdOl53tMxMtEbxgjZdJai6Hcz64oKItIbGyLjhUAup6uSSNnSnjtkVDykHdzxYWJyxTOzX7SBBU/7QsFePWJa65pJ5sg98Tws5oWkmuIdSSJQmEHddzzDozDDdsngHTH/H/qxY5S9DRHxMt7ltKWbQkYp5iwvAr39MFuU5s69jarg6z344rQJ4ekzDDFzOkLQBP2jR/quaXfyNQTikFn4aBfVHvN2DBgo0kKFF6vFMxG6XI58E7iYC1+isgtvAhg9zSxxK08RLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11441
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MAD0EPF000008BF.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 29b7ecc2-76aa-4072-57f0-08df34d58ec1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|14060799003|35042699022|10067099003|261026121527099003|3023799007|261021123027099003|261009223027099003|261021121427099003|261022105027099003|6133799003|11063799006|56012099006|4143699003|22082099003|18002099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: WhDqR16sMkvOBoABdWqgrFbcRcMkoDQVaDJemY1ZRC4HTe6uGzAAOFUTVdgIl1i9nG2qZKWP+XjvNSM72rGYI4UgdeHonoAQC6q6CzhoK0cvoHjEb/XPNAhYVQw52AtM+4y/WuYW7RZWcT15U4pw1Owbz6hb9q63FGTOR5nD+162BnDtXh1zYsjM2SQVzNzb62VgJ4tZspuIrxChgI91zJP0rSdkBc8rDR5dLWjx7PX0qzbGos+262zub+BE7huA5N0+si5as1Pguj06gId0Gu1+ntI6oNDeUB51SChFGBNUa5ZoVyzw0UWQcYmXi+qC/5fmhVXe4w1ggA19q6YCy0uW8JJ8jAkDzkLq/W33/v33rTptxg74ZxkmWoQ+2gOrkbECxx88N+dqQ+c8bMGETh+ehFFuYZwQMvaA5QHdOWsNeeCPR+O64iDR24KaJUjgWuXofWGKo4k3ooUPzwPPwhyj4ZvrHYw1Utb9jg+OwbCE7G2fIwNVCtvodsMlroYbm8kZvKPxnAg6hWU7WdkSVy+jRusDHV/VAJjIfBvA53ZRkBlejsMldJiqbyVioUcDHK25Araun7emca0NnaWLLTHghirPbVzpIThig246rWJx8FiSLRCupkBSJCOiBCH7drqepLLI1nloknDWGdlvjit0Hmv5k/ah1aGRSNzdKrF//AsWj0GAg6CP+eJPobErnhQE+l9a2594b2AdtsDxEA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(14060799003)(35042699022)(10067099003)(261026121527099003)(3023799007)(261021123027099003)(261009223027099003)(261021121427099003)(261022105027099003)(6133799003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XjNyU0KMGFDayGO8p8tw+yPJmW0sh3HOrsm82pUL9AjsmWIptmTAruRoSFPPi9EAZg+sTtJAo5g7KJDfyddThWhdYh5jLFz9h9nWHIV6AJyimOKQG0V1NV1E+7A+KARoiCfOCXsFQBE3dbMkH3KZCcURa6W3kOTFwC+NnL7BH7Oq2XvnuDwQHD3UY92W1uDfDIXRIQqupX3ZOj+c9uZGyZ6xk/w9Z4A0i1Rk1Z8hg+Ac87nQyTks65N++egOO/45KGZHngxhtAkag9c//sIN3Q4L5bFZJx1C/xDvniFr8JdtkifWsIc17gereOF2t5YwepsXkqWUC8jUu+OFGKTep1jfwlt7L4Zid68X5DVL7EiZfPtBjvdTP8txaU1qQdd4Z8LKeMR/tti1gCF1NpSn/qBHrlBrpnxXlfnA5EN+s2ZyPRKXZWSsl6oZUDLhyLA7
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 09:27:07.5482 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 893f706e-6614-445b-9db1-08df34d5a2fd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008BF.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB11696
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Simon,

On 28/10/2026 09:25, Simon Glass wrote:
> Hi Jerome,
> 
> On 2026-10-27T16:02:12, Jerome Forissier <jerome.forissier@arm.com> wrote:
>> test: Add helpers to preserve console silence state
>>
>> Some tests intentionally trigger diagnostics that the Python console
>> parser treats as unexpected errors.
>>
>> Add helpers that silence these diagnostics while preserving the previous
>> console state, allowing tests to hide expected errors without accessing
>> global data directly.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@arm.com>
>>
>>  include/test/ut.h | 17 +++++++++++++++++
>>  test/ut.c         | 15 +++++++++++++++
>>  2 files changed, 32 insertions(+)
> 
>> diff --git a/include/test/ut.h b/include/test/ut.h
>> @@ -549,6 +549,23 @@ long ut_check_delta(ulong last);
>> +/**
>> + * ut_silence_console_force() - Unconditionally silence the console
>> + *
>> + * This silences the console even when U-Boot is started with the sandbox -v
>> + * option.
>> + *
>> + * Return: true if the console was already silent
>> + */
>> +bool ut_silence_console_force(void);
> 
> My understanding is that you need the 'force' variant because test/py
> always starts sandbox with -v (see console_sandbox.py), so
> ut_silence_console() never takes effect under pytest.

Correct.
> The downside is that it also hides the output when someone runs the
> test by hand with -v to debug it, which is exactly when they want to
> see it!

Not a good thing indeed ;)

> Expected errors are normally handled on the Python side with
> ubman.disable_check(),  or the test avoids printing a line that matches
> a bad pattern.

In fact I'd rather adjust the test framework than the C code. Ideally the
implementation should not need to know it is being run under a test
framework. Thanks for pointing me to ubman.disable_check(), I like this
option. I will update the failing tests with a small exception in
test_ut().

Therefore this patch can be dropped.

Thanks,
-- 
Jerome> If the C test must stay quiet, it would be worth
> checking the expected output with console recording and
> ut_assert_nextline(), since recording still works while the console is
> silent.
> 
> If we really need this, it might be better to change the signature of
> the existing ut_silence_console() and ut_unsilence_console() rather
> than adding a second pair alongside them. What do you think?
>
> Regards,
> Simon

