Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF4B606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 16:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=e9FgoDdX;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Lb2cEXs+;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Lb2cEXs+
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C19A6407D3;
	Tue, 27 Oct 2026 16:03:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CwFOQKY0_vP8; Tue, 27 Oct 2026 16:03:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AF0BA407C5
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793116982;
	b=WvJOd5EyUkBxKN9A52RGAXkyJCMywsx/ueJECFgC8RVv/2pDQE9PYZ7J+EYPJ9+dgoC5
	 cFjFkQf/BorEWfMvssQ5rBpMLPAf4RaKE44pLIO02G8sXYYBoLMSS4IsHX4uU95m5dmnU
	 /oNFqJrrkFLqFFjl4CfnUuhbLedXcYm/YUtVUbbNP6ZbVCz9gUgqZfB60ER4rYjFX+L8K
	 TX4aZPhXWGHrO2RHr0e3nytwiJpiOMRa/TNHCG7Hqu1TTSMon7UsMhqPtqvGW/7vqj4cu
	 Fj6CgPLbtzgQbpQBD85s3Ko5h/KHqIEpPKp4D5p2CfdwgAPamMUb9nvlUr9QKiKGdPQ==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793116982;
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
	bh=ELfLXWHWKqXxhcLP74JRvccnSylU3qIRMltAdnhkcTw=;
	b=GG/7LDDw20yjVF5LLTklezJORmouQeDcT8toMgAs2C8CYwja+G4jcJ/hU+iW5F+/4g/d
	 tfrtTHyuH0X9dVIn/B1AKQ0OKeFTWzucBMKuBq6M/Wtj3l95FV88JoCZJrrbm2/tB+OTT
	 zjHX4gPY8JGQ+rTvrkPsBZWtvRK3D+NmL+b4LohF/2EC6r/m6q/FAwFotNfk7eTQIbiQO
	 4moH1MoNtdYxYTTrJSCLPnkV0t0uOgtWi+UUbmEkRZD4ZKEv0w4f9Ca2dtLsMcOHqPbgg
	 T5Mzzp4xR0wvurDGmQ60exBQ1BJwqgBm/EoFD+51pfOdcXsP7g1uBhVWszZwt0rcuMg==
ARC-Authentication-Results: i=4; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793116982;
	bh=ELfLXWHWKqXxhcLP74JRvccnSylU3qIRMltAdnhkcTw=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=e9FgoDdXcDKERzeMhM0xRpJoTulDN0dLTcCxV7+Xyxlgnq5b8SbOfjs/PfQDU537J
	 g4I5qUydB/e/ZaQX++sUg7vTsjSnr8YJ9yqUmG2yYuMUWUvXQAYBpf37sMLfWeTwe2
	 D9xAWolHUtBFX++Lwr/Z2KEVHZmZAxlfEMMXdVb915FcgOIGQWO5f7ixlnOjPl+T9G
	 BwGp95+s/SUsSc7i3NuuSWYe4hW9Ma+iKs9lMS0P5ODSw+tlYXmPnUHNWFXOSd3P5u
	 4neEho3wPl0v2oT/xGtSK03FnK4xZvutC9U4IxBWg0zUtt/411ELeXtsu46IrL/YyX
	 YeAUMCCrp0WBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AF0BA407C5;
	Tue, 27 Oct 2026 16:03:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E2ACA72
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 16:02:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C810A80F72
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 16:02:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XKDUeccD4ipB for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 16:02:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 52AAD80F79
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c20a::7"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793116977;
 b=hjZwQHkV2qzfGAh26gLeKA1Yh8HPyie6UkGjeFUfI7BPRWCAslYjr6eeUNADamqy3KEN
 WFgoNwmvvSmdnhklTzNwwmUSR8hrDpHVGo5vBxDP6b1eisbhFLCTu+TcpL4JbEjT8X+qg
 MPLaiHkc5K6Y73R8z/KdsIt6tP/V6qXmE7NMj5rXfdEXOnBuPhkEBGHIUrIa5ecSGJ+Ra
 Zg3993ZQb7+rI9MVgEQeuajBZp3zdnjQ8pkmceelsDoMv3ARKawF3QHyxALFe8zRKzQ1l
 /skEaKa03A83/bMq+KGoswYGNa3NCmCMcPDI3fA9UTRBpZJrkHn/jhWylSyLpxQ6ZUA==
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
 bh=ELfLXWHWKqXxhcLP74JRvccnSylU3qIRMltAdnhkcTw=;
 b=HOnj+/NhOlOCcd50u4qpGLfDU81NKob4WvCQT4MQK5s3Kb593kDY9bOkAvEChLMTNwMZ
 R+ACDSVdIniJBScRPvWfOOiP6qZqb1mCzXieDyB6iZbUxAo9Gs279+/vz+bMjhdGaT3CD
 LRylC7PcsfUlEIyVemJo0ievmIUBtQysnd98xFBTAQSg7PGecFLky5LpEhbqtvn/wmnFn
 kHITn6oQhJkM+6gCkE2mSD3vrNTFy9coBDV8yNc8Vf/g0yynyy/ciDE3invFg10+1L6/W
 6dMcLJ+MDudG4b3q38kZ9UMOqXWfvOibuF500PXOYd9dc66ev7ef1KgLmB+Diz6VFtw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=Lb2cEXs+; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=Lb2cEXs+; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=Lb2cEXs+; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=Lb2cEXs+
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 52AAD80F79
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 16:02:54 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=uRlLtgewb8j23bqt/Q9sieRyyZSGBld5WQo8ze1eFKTZTkfXvP71sZStBt+8HESweLQOmHBF5DGtXhEbbFwGeEOFnneihkasXsJ5OcVdKlXcgkj4E0VfA3LU32ledxVDLyr4ctpmOn21Le5Jnn/DC2i2s5KTVe8bgmA+I+6Nar/iSciSOdiBLCXwz9rwSahSYCyHoG4l0vPAyuWwHCh1890za9f1Jz0jDbai9suISA9Wxn3y9OMS7w4QOX4hhQaCQ0mZL+5dB3etQ96NgsMs79OQ0rMDZqi9alFWrgoDjXNjR3qfqlOwQjJipHppdOPZqmrPALQN3Qkj8Ys65a0t1A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELfLXWHWKqXxhcLP74JRvccnSylU3qIRMltAdnhkcTw=;
 b=B5rZiXBpt/7t/tBY5GIRtWOkbUJ7/5erfgw+TXsU7Evmq9R/QNIUanxASjdYW48BAQPEa7ksSVMCEyQK6gcnKYKqAVXbsfB6e83mQjqhr5C4YAvkqFdBEwAcDWmsw5FYTB4qu1jdnNrww5WWCEZHzEIpxkWq2JG7qjS1tepCT/FX6NL4VzkNLv1r9H0YIMOuxL0qu2sfvqwAVE1sjSBebG2QLhJca5FEBaiWnXIYSzSGHxYi6V5DUkZIKKXksoDPBI7tpQx1Ws49WzDPSc65HmLCJsH0bIxHTd8FLJUzpFJjYilNFchZW6Mqm7J2ySDd99B/dn9JdvtDzkupkrOh6w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=chromium.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELfLXWHWKqXxhcLP74JRvccnSylU3qIRMltAdnhkcTw=;
 b=Lb2cEXs+CIBfhLWJfteFAnJcaEuJuH3y18tcEcG/65inqbiIL/gvLeeiOj7cwz1LXT9RPr+DmtN5uWJzXFXlBh8dI2danqHMIzG6P3WtAE9Tan5mfXthaR7TaAYhPrZsi/RxGO5g6twDFABOh3ZVwhqCIDIcs3P0qWcO+wjkcZI=
Received: from AM0PR02CA0174.eurprd02.prod.outlook.com (2603:10a6:20b:28e::11)
 by AMDPR08MB11436.eurprd08.prod.outlook.com (2603:10a6:20b:716::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 16:02:48 +0000
Received: from AMS1EPF00000094.eurprd05.prod.outlook.com
 (2603:10a6:20b:28e:cafe::88) by AM0PR02CA0174.outlook.office365.com
 (2603:10a6:20b:28e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 16:02:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000094.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.4
 via Frontend Transport; Tue, 27 Oct 2026 16:02:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+CClST50niwU7H3zIZCZsYN/sj1rUaKZmUpCmTJQBkuJtzThR/4TfeZCdL8WenZH0Pyi2jb7HKeFgetR7j3YNQ8eq/vTI/YUm0eZatIKIeURvUmamf9l4NThJiHqSr+LMMCT92MMowzdoWxpChLCGCS2vrWW/G7v1BcXv0o4/0D3RkEVjZX1wM8LPPEtnMGN+HUQuHlVBrdJ2QrTTa7YaWbKjvP6RpaY4zXeUbHkMY2O/Kzk8uZ9+YW0IGp06Vswix3GPEhiUdJGhKPazcRWTCy6Gsn7bUbLbjk79vEs1sATwKMR5T668hBL6eLiKzZXGT1pVsogQOYEE0Yed0DZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELfLXWHWKqXxhcLP74JRvccnSylU3qIRMltAdnhkcTw=;
 b=M2ZVE50MJIrkmng3W+Yyg+hcKh3/XhKO5WjdsZlXnzzoWX4jKIr8KRlFmCSZuiIB8POWvGA8jps39ZEvyrk3GKgVweI4ONg+zPLF7OBUe6JbZzhOsRFDzic0tDZMO4Cc+iwkv8k3OATTzfSZO2u/gpsz4nNQ4MXraM7kB0zKoKZLYIHxhF+vPC9kObh02P/9nEcpLVJydHsS6BGybxEpqVo1GK+querIpUA25vE0j+rRyHgAkM+0LR0s5xaLD4G8lAv73hVAXt/nZ44Rx+K53g5GFFHMcLmhYibNzL2cPIy11bdVFR8C1Ag8Zxcg7oi1pWl5RnNSnHbf+Ujwrp8nuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELfLXWHWKqXxhcLP74JRvccnSylU3qIRMltAdnhkcTw=;
 b=Lb2cEXs+CIBfhLWJfteFAnJcaEuJuH3y18tcEcG/65inqbiIL/gvLeeiOj7cwz1LXT9RPr+DmtN5uWJzXFXlBh8dI2danqHMIzG6P3WtAE9Tan5mfXthaR7TaAYhPrZsi/RxGO5g6twDFABOh3ZVwhqCIDIcs3P0qWcO+wjkcZI=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by CPH1PFE47673673.eurprd08.prod.outlook.com
 (2603:10a6:388::516) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.18; Tue, 27 Oct
 2026 16:02:16 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 16:02:16 +0000
Message-ID: <1e33c183-0677-4432-973c-4d7d59a1b96b@arm.com>
Date: Tue, 27 Oct 2026 17:02:16 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 nd <nd@arm.com>, James Hilliard <james.hilliard1@gmail.com>
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: [PATCH] x86: Handle unordered runtime relocations
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0173.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::16) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|CPH1PFE47673673:EE_|AMS1EPF00000094:EE_|AMDPR08MB11436:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cdcb2e9-b3b4-4cca-4e39-08df3443bf06
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|261026140227099003|261021123027099003|261022075727099003|261021121427099003|261022105027099003|261022115727099003|261009223027099003|56012099006|261026121527099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info-Original: UPGrlEaKaSri2yCL1GU6Tl5DjCTYZGSNSMze7tZJ8y8MiNQE1xrYOaPAR3hwWU8FDJHsckScD+tkixfJO6QdBOo/gh5rpb3HadVBEKjO/QnqA2fqiwY7BJRtNOoRts5UdB8I6tvOJqt7VdZEaRGM0XNf+Ks2QUsw7/AsfLUzrWHd5LgeR7x86bgV4EMHnUnLTa/kyd7KR16jX1tflnQr9GjCt2ro517Hj+GANLHS0dunN4G2LgnFGeC6iwlyqldQR4gfVfj+r0qNzLBVl5+E61/lny20nbZcE/F5HQzjKwPvrmzFLYCfGNhJyH8TQN7T7FIL1SLP2Zpazk1aL6l76KqRQgi4R3lILUYuRFhXv6Q0aAuyVWEsJZTf56WuPBh8CX+eMMBjrQal38+2QgQjrKTo2av6GMP8y5nmgjGFTDMBhIiSWGDTjkQpPP6FZdZGz0Tqr6g417quq9CrBnaBagLXea1uI6ifvntEo8+v2C3rfg45E168cGhzHl06Zc0tpTfLUmdc4RZ7+hivKuc5Y2HHwxhSG1lTDgqdbf0rJ5UJO4oY+W44rkb6dcQH/nB173G4Me7ApI13IWrhnhKp7DrqHlTrwDo27ShA77BVQy1P5JrjFuEazqUG0Z6ifpBp
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(261026140227099003)(261021123027099003)(261022075727099003)(261021121427099003)(261022105027099003)(261022115727099003)(261009223027099003)(56012099006)(261026121527099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: G79AnUpMcvLfOzAkCym7zAZx5P2Sz4TvYfKHmiw3HmYTlyV0BPPrG9im8frE59adAomFNLiSuOA64PkeQm2pLtoFhe6laCMIOMMBqVWt/sFVB3xQCzZUq4BQSqd3Hbzjt8LR2zqQRRKFkrZ2Rm3YWXf5jaRied+K4VW3oDw7R9Ozxn/ZmhqvHZfJlSJn6seu9Dt80OQfrnY3ptHp0WXSEy7VILTyDS5XKwAvsM5gYzgym9e6HtpZKx2mi3IQm297uCV0wrRWssTkhaTZNaUPaH+JHf1Juxh2h8Kctb5T+PpZCDd8BA0zVPD9siAVTELE7gghPR/gfyuyeDXQx07l5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CPH1PFE47673673
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS1EPF00000094.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 61587d45-bcef-4617-8208-08df3443ac10
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|36860700016|82310400026|23010399003|1800799024|35042699022|376014|18002099003|261026140227099003|13003099007|56012099006|11063799006|261022105027099003|261022075727099003|10067099003|261021123027099003|261009223027099003|261022115727099003|261021121427099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: aY/VOzatkClHLpBBSjD+C2kRBcFq0kbhlA6BBkbngJH8pjvn7HfqHYlgrXK+ZmANjK73t+hFS64PiDdn1YgezUDVrEyw009jvauLe/+FbNM3CgNxE0o/Rs926CCV4vcxe+foC24HccXassViNALEXBLTMN0cIjT9E7HzpSm0zKdESdDrDvwgx/9hOwTJ60Nc7FPqGkTkYdsYRuDqIgEQTdtXV3IbKBucXUMpHQM6WfT7tKkR/R2L3Z4BE77prTuG4qJa5BrWC69StTfgfUuhUeSuKukQrDoPqOFriWJV8uwUtNd8Ik0LGQXRb3bkscIczlCQUV4+Whh6JS8K/JCkHSCMyUwwVQ6ReETlhGVtmdU9Ygm8hdkVPa3F2gxISUhRqnwFeuPw1ZEbM6/ufhyyLOH23Y/Or5+BNJ3Gqm60sB6UbajKZG9IBfbI4ywpa8zxeEN7BGWXls11MujKf4+Yr3ElAMJF8zU5kqHmxUJ/aNw+gXna1K9bNe+iLFmwhGKGEwpmzc3S2BiSeIEIrN/yRQX4+6ZeS/bCO/3iBkBtQtXlcJaXNoFrKql9OMPVck6Qm9Z45+voOo46AuqijY+RM7Hot8LVVTh5kGrtp+yNWBTcrdNQedh9nADa5PcuWjptzPfTZTKGl++vokKX8z7/VVUj5uZNIWKx2sEjDotKwjw=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(36860700016)(82310400026)(23010399003)(1800799024)(35042699022)(376014)(18002099003)(261026140227099003)(13003099007)(56012099006)(11063799006)(261022105027099003)(261022075727099003)(10067099003)(261021123027099003)(261009223027099003)(261022115727099003)(261021121427099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /RKxYk/YhDgUxa7kbYW3d1wQUY29gTcI5QZeBHu4t4Zq0HcZVcHE9XPCzEx+w1lPH8PKRKxl9d38pGLbSkIDmJ420o5vh7kX1wr/jKIZUsO9PUoF4psMHmmlN8lMdAmusOGC/z9dCuKND6rPSMyXEvvU5rGM5RhsRdGvZ4VTOenwY5iIFfKxmIjubiUKv1NNPMHRK17pd7S6KArhu/XNi9wfKmRugEJLBOZiZpIgQnb7qEBOZszDg/MOd4nkCSk8mIaxlghEctWbk65yKxYYBDal2UnvDWvkMZsL3O072RStrjr11A9Sz9u5je5DIZyLCN5l26jfq/NKz+bGvq0LKZSc50wNg6sg8hMN9Og0wzFRSZV/KhCbWQKqF6L01Jer7cfwBKMVJ5nWmiaafyEEDIBE4GELBTMYHZ3yw3XPspEVgzElVoJpU605hbn8zseM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 16:02:48.1312 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cdcb2e9-b3b4-4cca-4e39-08df3443bf06
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000094.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR08MB11436
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

Runtime relocation entries are not guaranteed to be sorted by target
address. The existing code skips every entry whose address is below the
previous one, leaving it unrelocated.

Check that each relocation target lies within the image instead. Apply
the same correction to the 32-bit and 64-bit paths.

Fixes: b50b1633c022 ("x86: Add support for 64-bit relocation")
Fixes: 62f7970a5a06 ("x86: Add error checking to x86 relocation code")
Signed-off-by: Jerome Forissier <jerome.forissier@arm.com>
---
 arch/x86/lib/relocate.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

I am proposing this patch as a prerequisite to merging the series "net:
lwip: restore TFTP client and command parity" by James H. [1] which would
otherwise introduce a CI error [2]. The error is fixed in pipeline 1762
[3].

[1] https://lore.kernel.org/u-boot/20261024-submit-lwip-tftp-combined-v1-v2-0-0f663f735ee8@gmail.com/
[2] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/jobs/127971/artifacts/raw/test-log.html
[3] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/pipelines/1762

diff --git a/arch/x86/lib/relocate.c b/arch/x86/lib/relocate.c
index 9ce56062d247..2bb6b843fdd5 100644
--- a/arch/x86/lib/relocate.c
+++ b/arch/x86/lib/relocate.c
@@ -52,7 +52,7 @@ int clear_bss(void)
 static void do_elf_reloc_fixups64(unsigned int text_base, uintptr_t size,
 				  Elf64_Rela *re_src, Elf64_Rela *re_end)
 {
-	Elf64_Addr *offset_ptr_rom, *last_offset = NULL;
+	Elf64_Addr *offset_ptr_rom;
 	Elf64_Addr *offset_ptr_ram;
 
 	do {
@@ -70,7 +70,7 @@ static void do_elf_reloc_fixups64(unsigned int text_base, uintptr_t size,
 
 		/* Check that the location of the relocation is in .text */
 		if (offset_ptr_rom >= (Elf64_Addr *)(uintptr_t)text_base &&
-		    offset_ptr_rom > last_offset) {
+		    offset_ptr_rom < (Elf64_Addr *)(text_base + size)) {
 			/* Switch to the in-RAM version */
 			offset_ptr_ram = (Elf64_Addr *)((ulong)offset_ptr_rom +
 							gd->reloc_off);
@@ -87,11 +87,9 @@ static void do_elf_reloc_fixups64(unsigned int text_base, uintptr_t size,
 				      (ulong)*offset_ptr_ram, text_base + size);
 			}
 		} else {
-			debug("   %p: %lx: rom reloc %lx, last %p\n", re_src,
-			      (ulong)re_src->r_info, (ulong)re_src->r_offset,
-			      last_offset);
+			debug("   %p: %lx: rom reloc %lx outside image\n", re_src,
+			      (ulong)re_src->r_info, (ulong)re_src->r_offset);
 		}
-		last_offset = offset_ptr_rom;
 
 	} while (++re_src < re_end);
 }
@@ -99,7 +97,7 @@ static void do_elf_reloc_fixups64(unsigned int text_base, uintptr_t size,
 static void do_elf_reloc_fixups32(unsigned int text_base, uintptr_t size,
 				  Elf32_Rel *re_src, Elf32_Rel *re_end)
 {
-	Elf32_Addr *offset_ptr_rom, *last_offset = NULL;
+	Elf32_Addr *offset_ptr_rom;
 	Elf32_Addr *offset_ptr_ram;
 
 	do {
@@ -117,7 +115,7 @@ static void do_elf_reloc_fixups32(unsigned int text_base, uintptr_t size,
 
 		/* Check that the location of the relocation is in .text */
 		if (offset_ptr_rom >= (Elf32_Addr *)(uintptr_t)text_base &&
-		    offset_ptr_rom > last_offset) {
+		    offset_ptr_rom < (Elf32_Addr *)(text_base + size)) {
 
 			/* Switch to the in-RAM version */
 			offset_ptr_ram = (Elf32_Addr *)((ulong)offset_ptr_rom +
@@ -133,10 +131,9 @@ static void do_elf_reloc_fixups32(unsigned int text_base, uintptr_t size,
 				      *offset_ptr_ram, text_base + size);
 			}
 		} else {
-			debug("   %p: rom reloc %x, last %p\n", re_src,
-			       re_src->r_offset, last_offset);
+			debug("   %p: rom reloc %x outside image\n", re_src,
+			      re_src->r_offset);
 		}
-		last_offset = offset_ptr_rom;
 
 	} while (++re_src < re_end);
 }
-- 
2.48.1

