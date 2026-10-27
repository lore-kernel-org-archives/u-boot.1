Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF1E606A31B
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 16:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FGs+8jFW;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Leg0tlkr;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Leg0tlkr
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 024B180F87;
	Tue, 27 Oct 2026 16:03:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2fUEdhxPAv73; Tue, 27 Oct 2026 16:03:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F193A80F79
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793116980;
	b=m1hCq7TwcpMASX9ixNZ22hL+44sEnIm2szoOEUwuou0ggGxM/1iqCEw7kG6JWcqBUWsa
	 gEIETLSItLboavUPFRdQVxisOdiLcVwnxZiklQMcxbYvfW+pDGxIC1abTE8hdFDZy508C
	 bD6HZwQpBT709BG7m1NHX4Pct7H15mGsxZqsqP4lGz1c5TujFixlgOBWI21/uV6Xh20EQ
	 oMpZD5I3wplqlrmHsegYoK+n9oj3ru1pBrtVW6e2o9Xl4Emt2sBTcbijNFkpR013ufmBM
	 3oF5FAPbRikgSxgqRSuwVEw4DcYybI6BCSc3HbthbhTfjjza2XX2wRLHjHi6KjZ4G6A==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793116980;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:Content-Language:To:Cc:
	 From:Subject:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-TrafficTypeDiagnostic:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cMiGNozrOaBNrpo/Sb2mIacttzcFABW7MSzbp+ywpDg=;
	b=AMlArU6NbyFfFxqR3jFfgCx9t+HMAMxwJbIzdjDjUtca0x5D4+XJ/ehamuCT1tlmeV6O
	 2RCyc/IyY6IoS0e0eTuMvo/nKx6fugO8NXazHp9tBmQrRkbN5AxyR53nPwGcUqHrN6CS5
	 KKBJC+HZm5fZx0nAtiwFqcVD45fQxV+8xqlqSm03YBKtxVOfTF90Y1QK37WX5FvS0GccP
	 hWn49Wb6kNKiRX+IRoFrJb+uolC7qrxWEM/3y85xqN1Ogmimb10of+YUG1dfSnTFj390Y
	 mVjZ4q/1uixqZwqt6zM5gvMqWnzyHiGJnGUX+bsxcx30BZM/1dcYRShRmZPCRoyROFw==
ARC-Authentication-Results: i=4; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793116980;
	bh=cMiGNozrOaBNrpo/Sb2mIacttzcFABW7MSzbp+ywpDg=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FGs+8jFWm3JDakHBdU1XlOQ6QTmhGYWDHBwE2JwvpO/nCTTxrY9ChGEZOi1XD3GBV
	 vhtN/53N1wYLVypuRBXIMShmj/+tVXZdl/C55A2F8Udm0liaGxphH7xT5Pr0m9DccX
	 p3T0jCZkGPcM08yOh5Uezh/AvLo7ELgIzxtLa6aHuXSPBGGfX71hLd2KSsldG1KWWJ
	 mX3giANNnsl54CCIN4ZnhXx1Cds1K3DnyOlXioLMcHaKOqDwtcVaamw10imko9bvPR
	 duQhNhODZGbc7+OiSEEhnKcFMUmkFPefq4rBCUuTtH2M8cC23JS7aW9wVhj80ao6+2
	 9igB9ndqvZ3rw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F193A80F79;
	Tue, 27 Oct 2026 16:02:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BBAA172
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 16:02:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AD6FE60794
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 16:02:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KiD_aR9D8aU8 for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 16:02:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 14F5F60768
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c201::3"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793116977;
 b=UzeGbJqAQbXqKRySSutLAfOD/7hgZqDlXHx1Oc9lBES/yCidFLGsVChGDZLLXFj0fXjN
 NMQ5uS8TEe2O4NqKVe+PKOxX26IRNbygpz8IdncIKeWw4lwqXqQ4KUJUWR2nTgQpyMb2r
 GZ2F3HPJRWi8wBMzT3HVRD0k1KKwftYW9HXnA7qCqnGuRiuuLrbwzGws++/rqUHXZKDok
 suuJrcDKi0D0FXCSE3oCr2HfXHEWQmsAQbDhUkz8bYProBYcD6H9FuW4Yg9LTLBKZViXj
 ZP1HSp1NH/82oBfajjHHUtBtRLQgqkPr1ql6gXH54uk39nhTdZPHALBAbVZ3NtfG5SQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793116977;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
 DKIM-Signature:Authentication-Results-Original:Received:Received:
 Message-ID:Date:User-Agent:Content-Language:To:Cc:From:Subject:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=cMiGNozrOaBNrpo/Sb2mIacttzcFABW7MSzbp+ywpDg=;
 b=eaan23lTGnFeD4UA91lrJapOe44uhgA05VUESV8e6ukXFvlkoDc01tm72/gpqc0Dt2Qu
 siavuCwJIR3npIJPL2AZ1FJrgp4sCx5R6UemKNocY66wBjXeskOEZbVVSE5HqMkiAF/D7
 T66mpT9IIS5TmIgOft8VJJYPfZVmYqh7Ua8Y9wxE8NG2b0znyBUYfc5Gu3j8o+FLPcOsb
 wMNE3Qc0Z9+S1fmyy8JU+EpW/yMVehBm/UE+mPNXPsQH++FB05DeIw6KUXHC3O72VMA0P
 b0Y5WHyVTyBnn31csr0LsIapNhKl/7eY8fI+oxOMW+Z/h/ASKSuv6ClC/ZRR758CMQA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=Leg0tlkr; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=Leg0tlkr; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=Leg0tlkr; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=Leg0tlkr
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 14F5F60768
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 16:02:56 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=s4o0CpUjc1mbVzHCmkztiBfieMI/q9ZlHL2Rb7HJu58jW8fypyDE4PVFyJC6w1ejp9JQ0N49iKQOVRkfaL4vYAjBLtyTXaTIRwl5P5g3ZF/f+AYr9Rz4fJMok2ZXA7JoMHKWd1l+IMyE5U/zIwvCipqXKiROiYVp8UmwmN0LyJNjGvB1VXtO9ux+uxTA9NGCIWM3HUtmk3YZlWnsCNVGOxSZH738fnyyTRlg4Dx76cfYMZRVf07IYW3stTPwEjgGC3jWhhJFhuNdgeEJHlz6J5e/zUXXUU34T4FiLjqX1hUJf2Rc0wVONA89PGG2TRHUM7HYKieX5bMHz/S2yatf6w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMiGNozrOaBNrpo/Sb2mIacttzcFABW7MSzbp+ywpDg=;
 b=clYpYC/xKCQ0k+3xvo+r4nh7h6lx95mnInTILOYqEvb/X03Cb1cHvkcLgHFrY/Dv8U05aaV6MxCxyXhYORUZDN3JhDGGWQ9hGZVQk+0mD+Ua3lQWVRvPQgBT49vvErrbyEHue9WUZseSt15Cjmw6/79Dgop/9rmR7cFrpAT5hEr7BhZe/TnuYVBTq6DHN6jlQXoUW4TZNABhetmKMqUWzfxaQ6WZXH7rQudAa8lpqF7SftHLHtnqDK3nB88EwMTW612nd7r8Ol+h3dn10bQw+yTAlCOPdDZnk6nvKp2+2GAJvH4sf7Pjfw3a+SRQ/O/creH8hLy8orxR2t1m4jhYiw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=konsulko.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMiGNozrOaBNrpo/Sb2mIacttzcFABW7MSzbp+ywpDg=;
 b=Leg0tlkr7j5CJwH60RR3AjucW6ciirvYG4UvRH4fTKBUTX4PLWJ/ARjXzQNvFZmgUhle2aVUZfgnxSKpR6ENkl5d/KdCK52kjBdjNQr+fi8Vn/g4W5uX0TCp25jZ3fI8CN15GoZPM/mjMvPFrdmWcfE7TwkGLJQ3ynQLiE2Td2M=
Received: from AS9PR05CA0162.eurprd05.prod.outlook.com (2603:10a6:20b:496::11)
 by PA4PR08MB7547.eurprd08.prod.outlook.com (2603:10a6:102:26d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 16:02:46 +0000
Received: from AM7PEPF00000057.EURPRD83.prod.outlook.com
 (2603:10a6:20b:496:cafe::a1) by AS9PR05CA0162.outlook.office365.com
 (2603:10a6:20b:496::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 16:02:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM7PEPF00000057.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.0
 via Frontend Transport; Tue, 27 Oct 2026 16:02:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HYCb0gpu/avVn/XhqDuwMuIlbN5d4pXR9ySI1oEbvkNlvOd+XQEiLWLatg6InYUJedvBG9/VnbxQZParJrDwzk7XNseuPZEhUZ8yveQbC7KWiyX3kNrmi+GC402X0/CT3fRvA2i32zyWt/DzoF+2YlgHKoe9S6Mc6Jec1dNJglNJ4XysG/2xQtz6n0kN9EC0inS6M1ipsUnNn7iCul++xJ1Du/j2Y92oJv7VFLF80zMU8lla5nNwgD7d5THUZMywP5J5V3I40juLpynO7YweGG34lI4Fb8IKw3SQbXwPZNejok6G1J50BRkfV+8CDseA8bDxnZCgmScopKiTwI+ilQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMiGNozrOaBNrpo/Sb2mIacttzcFABW7MSzbp+ywpDg=;
 b=YVsfPdv288XSxW2Q0fqr1xMwSRR8FTSR/E9+PiCZVFRITL4B0ov7FxLnOT8vKe7JyMY9cH19Mmo1yRRq8SoTFP7tokL1wpRq9Xc/GEveulDTrB65XpS+60d1wG44RW6/AVN20Jdz78pyyvOjQRFXjWtZnYN8fqbGmXJzsmc7vdnsTb/LVHE7Zp5ymV/CQ4GA/0Jz5JHGqj+U9ASFtbfd5IL0HkHnky2ibDkcIfJKL5YXU7psMwi40IlE26bgTEnPZ5+pTN2NkbxdLzdPguu1i+qPaYjrMOVU+f6trjPVkTdY+7wXcIBeqY9NPfHhE9roIVFbIz3mfjvBrq9lbkTzoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMiGNozrOaBNrpo/Sb2mIacttzcFABW7MSzbp+ywpDg=;
 b=Leg0tlkr7j5CJwH60RR3AjucW6ciirvYG4UvRH4fTKBUTX4PLWJ/ARjXzQNvFZmgUhle2aVUZfgnxSKpR6ENkl5d/KdCK52kjBdjNQr+fi8Vn/g4W5uX0TCp25jZ3fI8CN15GoZPM/mjMvPFrdmWcfE7TwkGLJQ3ynQLiE2Td2M=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by CPH1PFE47673673.eurprd08.prod.outlook.com
 (2603:10a6:388::516) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.18; Tue, 27 Oct
 2026 16:02:14 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 16:02:13 +0000
Message-ID: <93e4e89a-6c3c-4a3b-aa90-bd9090a6daaf@arm.com>
Date: Tue, 27 Oct 2026 17:02:12 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 James Hilliard <james.hilliard1@gmail.com>, nd <nd@arm.com>
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: [PATCH] test: Add helpers to preserve console silence state
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0173.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::16) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|CPH1PFE47673673:EE_|AM7PEPF00000057:EE_|PA4PR08MB7547:EE_
X-MS-Office365-Filtering-Correlation-Id: ed165e25-8a83-4049-7074-08df3443be04
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|261026140227099003|261021123027099003|261022075727099003|261021121427099003|261022105027099003|261009223027099003|261009221227099003|56012099006|11063799006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info-Original: wum+PibYmVIM3xrI6R5L0fdQBdd4gz6ay5sktNZtlnHrDOLD0bStYbPuWvpaK9DnX4k2qoyl6EeQ7WLYSXN9R9oCcLHcdGPEC/h4jCZw0r6c9mBARTxGXoLrN1aCAzv+c7N61ZYuE7Ii320POg0oIrcw9NV/T/uuF/IbnXbd3H68/khTN6nEV99QZDtzhOW2U8l5Ph1j/BkPvZB11CKNVY1X4JIWazEf9iGq+fyppLB2NUshZUrwtqiiapGv1j7+7rtfzlJSpR+cmltMpXwV+QChmdRgEeQB0FsJDf9QV2kebccc92/pwQIByi/a58Gb0IRhp6S5A9F3eVmFy3Fv+chX/POb2EQEQPqxPc1hpLCKc8d59jQ7M8vcGAK9VO7wK4virfRNRZhVGZ2HJ9/flAd39kn4LGPJwxedzrNXu/s+0FNmMc0cpsi/4MHXJJUGvE7lE4EBZ63d+b2R4gJhgOVPxbEqrshoh0Ssc0c8x/L2VzEegUnUpF9GNVzZD1wxfbowlIsQ1GM7v7HPlczZuo8evm8aMz40vFrDDDTbCVw2/iIsUeZPckgh5wV4UcRfDhpbd7iQJ1Z2MEyaHHC+0YHL387f1YcGu7rkygIc3fh03Iy8ZnpDsQVUT+LD6k3W
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(261026140227099003)(261021123027099003)(261022075727099003)(261021121427099003)(261022105027099003)(261009223027099003)(261009221227099003)(56012099006)(11063799006)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: yeYhjlD0hgE4++rS+D4cvmc3NcSoHLJT9MDztEIzJbk8WfTCHltsHQ3NPGZ3ZUfCPUle+n8KbcTtw1xC3C7W+VDEEkZi+IfjqpyRRiSnDy/wbLFeOZAIFcDVfy6nEcphw/P5FO4+hM8PtLbDxMGr1p/pNTDSw6mQhs3URLKiwZZ66KwThkLC6r3cIFU+4uIMW+czHfZYDqD/Mo/QWNqGQIAc/hDeVlM1tUgPGLu2B6niFSpthd/kkSLKRRkXU3PlZkgttVIOZCujXMJAqfe7GSwCyuvgy3a6mFZLnEXFDLIzMDch0z3VX3F2+ylYR8J7cci0uIdhqyFni8yXOuNDqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CPH1PFE47673673
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7PEPF00000057.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3891d37c-9095-41df-3fc4-08df3443aa5e
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|14060799003|35042699022|376014|1800799024|6133799003|18002099003|13003099007|56012099006|261009223027099003|11063799006|261021123027099003|10067099003|261009221227099003|261022105027099003|261022075727099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: 7DS002cT2ZErafi8fpSupyVn3a5gt2n77fUcwDwIXGibPkezD0rXaGnOH/KTVik0vsjFX9ZKSrtyqudDPkWzdQbZgtnVt1+wMfSCtEH6bF7keC8i7pN2aF3Y+XcydJBJYSmSQ9zJMj7EuRgW2FxnKi1p04HLadNGCKEwi2B8XR+wVa+GG6vtK8wLi/nAPpn/4GGPFn12y3MZPgZKfmo5Nl5VkmMaqGLUMU4No4drNDzGFHMT6ECJilf+1I9EQMO2CJzxHfKLtVzdGuhtRigsijemApQMIQ1oj/6FBmC2npIC+k3gkEsb7qxy5COkNvjfwxo9JR0c4UCO4euPmH7D9NrTHpojEzvduBcOOjAIC0iRSZGyBW30X8kIrNyKG7n024V8i+Lz0lsvpVw9S5NOsYmOzSM7IloZRqbn4KppTrifzn1BSxjV6N2F2kVnJ1LiqzEabedy87KMWePDThPHObN1r+e2uIhKp6/3zePIoG1tIP5f0/7jU6bjOpsUnCr54c1nrL0FjB70Smq42nrWD+3CK/0T+i7F/8AhUUdo6CKjUBJkKFw4AFLHhyxnagZLKV+kqnrmMvbJoB1+jbgNmwS+vDyjZ838sy8ZJNb+/ytCkOJ/V8KVyM3TklzxP7UuodnOAspqEePYJsnMo9P1JOGKQOW9yHNPDkvdiSO+A8w=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(14060799003)(35042699022)(376014)(1800799024)(6133799003)(18002099003)(13003099007)(56012099006)(261009223027099003)(11063799006)(261021123027099003)(10067099003)(261009221227099003)(261022105027099003)(261022075727099003)(261021121427099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rWyvW0U5PHuusju5ivaHB47oqWcvPjnGrh/gTlc6Rctbdwn6OIdfiFe0KmqM42TPTiR8/mttIusSHIpF4kHCD8C/JuzdpyADcaehiyfYfQOC4Xmqdlx1ZZkBGqN9nO1RZtytpYnGQrpDgmUxECQ/80Vmd/LydXbyxmC8xEk9+/NTao6Qt7f+MiePkhS7uxE2GkqYaS2wxiEp2Xle5J/2CaZjICt2Cnyb7j92lkEY7eRguHuk+Vf1hOzWYo0mC7NdvlSpjztA9mZHGMIeS8a/QzrVVp8IIsYxPpF+ccEH7YFdix49BG0C00ZUcPDQyI9JFhkEYycJFVqbVI6SaBwKDnN1v0nMNy15lFfkoKykeD4bKcctAqEu1/q2NMmWPocXyXtlqi0kZfUB3bjQhKmfeuwx3qmkyLBPSsP3m6efIdX5rvso/N1fu59gq9LDjUJP
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 16:02:46.4439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed165e25-8a83-4049-7074-08df3443be04
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7PEPF00000057.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7547
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

Some tests intentionally trigger diagnostics that the Python console
parser treats as unexpected errors.

Add helpers that silence these diagnostics while preserving the previous
console state, allowing tests to hide expected errors without accessing
global data directly.

Signed-off-by: Jerome Forissier <jerome.forissier@arm.com>
---
 include/test/ut.h | 17 +++++++++++++++++
 test/ut.c         | 15 +++++++++++++++
 2 files changed, 32 insertions(+)

I am proposing this patch as a prerequisite to merging the series "net:
lwip: restore TFTP client and command parity" by James H. [1] which would
otherwise introduce a CI error [2]. The error is fixed in pipeline 1762
[3].

[1] https://lore.kernel.org/u-boot/20261024-submit-lwip-tftp-combined-v1-v2-0-0f663f735ee8@gmail.com/
[2] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/jobs/128187#L3716
[3] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/pipelines/1762

diff --git a/include/test/ut.h b/include/test/ut.h
index 6510c35997fb..a528b49a7670 100644
--- a/include/test/ut.h
+++ b/include/test/ut.h
@@ -549,6 +549,23 @@ long ut_check_delta(ulong last);
  */
 void ut_silence_console(struct unit_test_state *uts);
 
+/**
+ * ut_silence_console_force() - Unconditionally silence the console
+ *
+ * This silences the console even when U-Boot is started with the sandbox -v
+ * option.
+ *
+ * Return: true if the console was already silent
+ */
+bool ut_silence_console_force(void);
+
+/**
+ * ut_restore_console_silence() - Restore the console silence state
+ *
+ * @was_silent: State returned by ut_silence_console_force()
+ */
+void ut_restore_console_silence(bool was_silent);
+
 /**
  * ut_unsilence_console() - Unsilence the console after a test
  *
diff --git a/test/ut.c b/test/ut.c
index a16fdfb3a93c..dd2fec8425a8 100644
--- a/test/ut.c
+++ b/test/ut.c
@@ -222,6 +222,21 @@ void ut_silence_console(struct unit_test_state *uts)
 #endif
 }
 
+bool ut_silence_console_force(void)
+{
+	bool was_silent = gd->flags & GD_FLG_SILENT;
+
+	gd->flags |= GD_FLG_SILENT;
+
+	return was_silent;
+}
+
+void ut_restore_console_silence(bool was_silent)
+{
+	if (!was_silent)
+		gd->flags &= ~GD_FLG_SILENT;
+}
+
 void ut_unsilence_console(struct unit_test_state *uts)
 {
 	gd->flags &= ~(GD_FLG_SILENT | GD_FLG_RECORD);
-- 
2.48.1

