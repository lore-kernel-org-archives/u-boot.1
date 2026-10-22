Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC35606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 11:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qUTsywLy;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=p76MSdnK;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=p76MSdnK
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2607E8125F;
	Thu, 22 Oct 2026 11:49:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h4LGU6DhSCKy; Thu, 22 Oct 2026 11:49:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E1CFC80DC3
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792669792;
	b=EnTcoxamUZ63za6kOiZu9GK3FnOTEC4urvAi7k6hheEnEgIeJ95fo8dRP0qgm0nf6YHw
	 jWvi5uKPYQ6AHBI3xGpFRTPeSEGeIFmlq545G1sP519kGsBLaPK1WBlwwCvHYvkTOzxCX
	 9F4D23OJysGqZQI2IECBp+Q167v6m8zPqnCIBeq/Wjh2QYnvT+SQrAHUwev5qoqOwm70v
	 nEqPEgtF3cgAFs1mvL1QXCth1SjHc88umbDzcsdAXgdB+OLqaOMy6x6Tu+qP/Q8HHm3Dt
	 hF3txGFtHuWdGadNqEqOLbQxrcjqiEEXnpzC31LsDYrtEmV69T+zRZ1Db/DqndZniKA==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792669792;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:From:Subject:To:Cc:
	 Content-Language:Content-Type:Content-Transfer-Encoding:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=C4nAow9Nhmt48oJTaozjmGq0dCOM2LfX3XWIDmZ2n+I=;
	b=btvqUSlhZ3N2Rwu0F0WnOryXLnBwYDp95Xx9FQfKmzxmPl2xpazuOpM9ofdXaK85aRb9
	 4GQmELUbqpmKTSw2w0/PEsX3luDoIuQZDkc2ZU2b/MCqwGDKX7NGngWQShJXmjGp1CMpV
	 51QB35PmIVNsbgy3wvpVSpIowajaoa51i1mdzzZLimKsOmeVIFcudg8JsGsEq83xY868B
	 gtPqaITZcz4pOjsR8hJENIE2eAhmtdwDX8tmh4ZJ60Fip+Kx+OBc7/v0FNWLEALhKGRaQ
	 taWL6W3zhYGRTFigLz4HroiNnLY0p6UVnI+Fcm/4GLy7xoYY8ocYGXc62aqnQ8hYhlg==
ARC-Authentication-Results: i=4; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792669792;
	bh=C4nAow9Nhmt48oJTaozjmGq0dCOM2LfX3XWIDmZ2n+I=;
	h=Date:From:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qUTsywLypUg40os1WYHQhEPYtEERLjVINyposaKCA9Vswl1vv/i64EnsCSa+oe82s
	 ZiErn3dYVn+1xjl/0YtWBHzUtE2/C3JwFVU7lacn/Q6JKRkkEZ3ifVh3k4tytiWXRm
	 EjNjTCe+JNR2WKRUZcFmFtDfCO3+wZTL8g2ewP4OWif0lJnn6LLrVB1ak/M7ZLxiOM
	 Qah+4V/R7474W/BMICsXQKGYqQeavW1TIoz0V0rWRCscD3VHYWD+/+kIRcgLvnp523
	 nTPpL+Z8G2I4/BptqZeXqDnHmLHTG08JRWFNqDqPiS/aMBCZE2Y6+gumvrDUYy5f5o
	 xnYtaiuqTIAMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E1CFC80DC3;
	Thu, 22 Oct 2026 11:49:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AF1E81AB
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 11:49:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A0E7160719
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 11:49:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iM8C28GOmZvO for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 11:49:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DA3276068B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c202::7"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792669789;
 b=TQkoB5sbweORkPvLpQGEwzb+xzFJqxTdZw4JzRTJBUKgi6VTtjnG3EPfoMp4XLbyJwqL
 IjMHctaK8TNeqvbhuAdd13WuMoizs0sFxRiQoPzxBxqAcgJqA4GOjXNR9XKxZDS9QQzTY
 vRQHGXJsd4OVcwIwDd/a7Gf7PlLvLXH00caVSXOWgXwsieWISYtYVvVdOhOXAVVQsWB7E
 TPsBn6ChlHG17dYtDMTARxsn3GZTIrzuKndRfAGW8nR+MO9p955brvRODXX6GVBHaixD9
 HQRY38NpFA1whprQL2sUKiwDimYULNzRACyU6DjlrQj8QQR+d4I+W2a7Y4iNBKYQK1A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792669789;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
 DKIM-Signature:Authentication-Results-Original:Received:Received:
 Message-ID:Date:User-Agent:From:Subject:To:Cc:Content-Language:
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
 bh=C4nAow9Nhmt48oJTaozjmGq0dCOM2LfX3XWIDmZ2n+I=;
 b=K45UzdT6g2TYkspf6FTxLn0RskKn22U5jwrgjwyAyiQt+FHh/wc2d/jUfIg+Uo5wmbM5
 pVnCY4qQA8dYHiNr7/fck0DjdApTxIxdsksHJDG0TySmNbs2oHI08MbKUFQO9wKpjTZyQ
 yvK/dJ6bmq6E7NTgTuCspY2IcoAM6+HRC3gskGBxAZ0bR9oUPQnSd4DBYFLnUiJD9yFzm
 odVhed5rKdi3X7v4+bU86I13ciK1ujTX8FiVCqqhN0Nj28vgOLx1O2p0ga10kzW0uyL63
 79f54XMg1uduChAP7xzaiNTqYFxmV5r1Z4de2vOe+luItvYmHF4Un+tL5G++dhSDB+A==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=p76MSdnK; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=p76MSdnK; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=p76MSdnK; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=p76MSdnK
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DA3276068B
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 11:49:46 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ZS3fTlv8Zz4RoGSqWuXvWUI/mnjVp3NQ2G202nkG+HUcveZJoYui9aEmypPA/Z5ybNBWvuLxR8WBiLqekWJTxlBZAJwfq5ydw4Vt2ytIYk3d6xSZUe7KcinRoESAC63HvFmHLJweaWJ9y1DgYjoHf6E/g77wuZqeCeNoMAJkv4sHAMtM+hFlw4Nhl7eWwDAHBOcKRSzBj2pG4qV0jkbf24q/ia7VTV/bVwIEkMS/wQhNGuRcGBoxh73jmLiGxGw2/A4NwQ/csUVJyhQHNPbjAotvDxo89z5SkNTTixUAWWkeAMD9Pl3wp30Hqpzwm3AyHvkLGt6uK9THw2CHiv/4qA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4nAow9Nhmt48oJTaozjmGq0dCOM2LfX3XWIDmZ2n+I=;
 b=QqGpXbT7t1F0GQJ3KygslXdhaUdUUGc9M1XXfnrsY3nniMT0TghJ/zxHW/Eafpvay+mlrYR1M8Ch1voPvyD3Q1tY6CN29Nn5uH+bn2RhX9qcH8sg+RmkQqKTzFWuUdC3arkINOvCUNWcRk9eXxvD45EP/GgAnraDbl1d/ycz134Gdc3qRdDxZ+7x5E6pLnUu752aovm1frsPRQj9qef4QpVDfwTEZsk/Ixarhpof3w1Y8wcfUric3UrriuGu830lx9kR8L4kRFSwbSq9DrZDFgxwCu4vvC+RAQkrkj5L8vHHNq+nlQ8zT46ZS4wqsDZ4rtydJvRNgZaAJKAhdq9HZw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=konsulko.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4nAow9Nhmt48oJTaozjmGq0dCOM2LfX3XWIDmZ2n+I=;
 b=p76MSdnKNw2XicBizeBRaMh0YIall86C9cyXItpRLT7ndVY1bRiljCTdCO4amAFPv6oV3zcEqefgki+b12np/jei5Ykd/0Ed/1DM053aT6KqGjEpxf5daJQ7JNwP3M2X+0bgAJXBN6CjjGz2UkKrry6EGFz/4HAQtMMzSlfA7ec=
Received: from CPBP307CA0002.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380:1::14) by
 PAWPR08MB10281.eurprd08.prod.outlook.com (2603:10a6:102:367::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 11:49:38 +0000
Received: from CPH1EPF00000529.eurprd05.prod.outlook.com
 (2603:10a6:380:1:cafe::ac) by CPBP307CA0002.outlook.office365.com
 (2603:10a6:380:1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.17 via Frontend Transport; Thu,
 22 Oct 2026 11:49:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 CPH1EPF00000529.mail.protection.outlook.com (10.167.241.164) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15
 via Frontend Transport; Thu, 22 Oct 2026 11:49:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lcyoRW5DtWEe9m/UAF4+VN2XX7ZrGGx+yEL9zQA4Yu/l6NRJz9n84m8pAnmYjSGEiDmm59SKBZ+ENyhz4HPlgNW/W+VmJzPAFDvQoQIEIMok07zqw3CUnkgb6/XSBx1rUeA5wqLqDUB94DJ7a9MRpTTQ+XUhLIvuE/Zp1F07L35dVpOoJfxq6zg4ppY7NcYWgmsNjmYH+kwx42m7AcfOpBFMVm1NEsXc1FdyKoEkIVp0i9EH4t04b/Y//ZalL2aO8eZCd8qwCkRa+p6kNlQjneE8FZRNXgqQY8sVPRbBKgprDduitNUD4Rq9Act3sL9nFY9q22buxrQvE/lGcyWppg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4nAow9Nhmt48oJTaozjmGq0dCOM2LfX3XWIDmZ2n+I=;
 b=ZnsFl2MI4QsBLH0e74LV07V6zRwjoT9GWsatZmk1J4BBFUtmiV2Qm2vUpEgomsWFoLH2sg8WrMSQgKx1uUb2a+J0sxo6/ryNj8nFSR13GHEKeoaTXRlY3E1+9SYuYwihg8sM+3Yxw4xIKbg7ufqzvVn8t0WHSQwYzo7aX5Grb6Mw91tq3z5Iq7VigpYFE+ZSmjnycDc2slwqBJjD+0zkFSmPScMd1u5lmoQV9/CiPrvF+hQ33+J5kDioZKaZAkIzmUD0iXHxc1+sk5eijyz2ObsTI8P+zvpMnabIuTRjrUs9yN1WvGcllsKuPRcSSa+Dbia+hPDbUQKpqlk9iz9ZBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4nAow9Nhmt48oJTaozjmGq0dCOM2LfX3XWIDmZ2n+I=;
 b=p76MSdnKNw2XicBizeBRaMh0YIall86C9cyXItpRLT7ndVY1bRiljCTdCO4amAFPv6oV3zcEqefgki+b12np/jei5Ykd/0Ed/1DM053aT6KqGjEpxf5daJQ7JNwP3M2X+0bgAJXBN6CjjGz2UkKrry6EGFz/4HAQtMMzSlfA7ec=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by DU0PR08MB7390.eurprd08.prod.outlook.com
 (2603:10a6:10:351::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 11:49:05 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0546.016; Thu, 22 Oct 2026
 11:49:05 +0000
Message-ID: <76cccf4e-e4d7-453e-a336-46486f708303@arm.com>
Date: Thu, 22 Oct 2026 13:49:04 +0200
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Please pull net-20261022
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, nd@arm.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0484.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::21) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|DU0PR08MB7390:EE_|CPH1EPF00000529:EE_|PAWPR08MB10281:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a87635d-2d76-4960-bf3b-08df30328ced
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|261021121427099003|261021130227099003|56012099006|261021135927099003|261009223027099003|11063799006|10067099003|261021123027099003|18002099003|6133799003|261021133027099003;
X-Microsoft-Antispam-Message-Info-Original: MxBG9mSr9WKE4CH1V9HCs8D0lqKnilMxXUqgNATsJp1McgF9XPecTp1YPn/rpDdqoh//g94bCtKBh3hBBLu1UAmTWYLe939ixiM4jBuV5nEZw2Edhbh+dmRDdlbAttca5GzF+6JyXmcOEh9XeWtzBcq3NoxC8ohdPj/tzkYfuhos7tz8XOTIHGp7yb/wTDvwXY2aDlQGAvRQLnVUXzNqj2UzBjcI5wH2kjoj6oKvM+/nuDXkd2Qac+5U3JlFwoiud+NH0sJbZ5yOQpPWUzm9AZWhF7uqCmc6BW+BTHwSNV8hhj/q/jNei/FfMG/q6Ds+xxA1Gxuobc5PcqjUUTR2mGt2rhD7yckkxUnIIQqujQJzeFv/9KSbLTprGzP4N+IZFGQ4lcqFHUINnf4F9CZW+kknj3dWKKIpKlr/6IHgLXsSTCClrYEgIWFmzJVNhFPIDFxwMxzYTl0mGWpqjHQ9HCNff+Bq4b8fDCeSQjvE6y0sg3KfUy44a1XHZJqvgyEXRub4dsFr8EnJARJppmxkxFov7gN9W8Cv+Zxj4pRCYknIkCSlh4MvrwtZ0fAevDRSO8xhgKLjdbwYNuat7ayPrTzByloUGWa+o7atO2SAbEY=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(261021121427099003)(261021130227099003)(56012099006)(261021135927099003)(261009223027099003)(11063799006)(10067099003)(261021123027099003)(18002099003)(6133799003)(261021133027099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: lNMCkIY6SUbe3VuDotbeYU29i43GfQ9ur3b513LP9wgGOkVRfqIay7jq7iRfC/qjkJKHJ7fVMaB/E36IDWd2U8WImi44bh/ySl2MrqL25k0zym1PA/Yta/IX3LuKgnijSPxzc/+E/YpwAx042PCUOTm7LMVHabW33UCrPPYQrS8mG1LL5ZUzfCnh4t5rVicvJ/JAFhCrIaY1OK2ix/qmfyXAC6gbJnthd/NvrGtC/SkSqX77ci0kkIrc58LSsLrGcHBXBe0JAP/tdZ46zzkDlQdxFpAnqP2V+oGvVVPSYNxAdyrOUi/d5X3cguMEKvo2pvzOxX0TzTYUvl0Ojo/qAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7390
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: CPH1EPF00000529.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: fa246286-9e12-47d2-3820-08df30327983
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|376014|36860700016|82310400026|1800799024|14060799003|23010399003|6133799003|10067099003|18002099003|261021130227099003|261021121427099003|13003099007|261021135927099003|261021123027099003|261009223027099003|11063799006|261021133027099003|56012099006;
X-Microsoft-Antispam-Message-Info: fDrlv7fNcAAwunr/0yg0SiowrmxuyomPC0fktva3Agfs7A8HTYJEkdPb84tVYmIlyxTL+jF0NuIp8qVReCDRCsljsc+mMbBYAWe8qNJxtvM48hTa3ywB0hH1wMJjP6r2MEu3XbIoyST+i+Off6J5FB3j/9i+21mhY1pKPrghnzxm9kyAUYtC0bInN69QJSf4VabCLY9AwjYL6DOij2DHJlOB8dZiDGtG0LS91G8kcIPbC0GfforJTvlnp/ZyoBdg8vtBM9AGH10RYuA4amjyW1iqRitn1/A7m1b+6lVkkm4BZ/954bwv2FrBZq1S9AgR3Yj7avDRknQVimNnE6e84vzkngbGd6UD2jKv8QZZZDXEM1DhimhWSYH02BwJNnqA7p7j+lombcQ/YHD1/HdLD++FgrLjqixleySw+QSoMGXdNi+n0mRigC/qmEDIYkeQV7c9k71Asob7cURtkNs/1Gc0CrQNcFpHw0lqGnCQqUeZYJFy0yWAaLZGpsJP9SorvEbn1ijMuKW0HmC/Xd13MWMjePfRpNdhxdedUizbM0O8ZrCKcXlkROqqS/s+gh24JUEGcSnPYHstfJs3mUba5FATCskngRJ/MEzXIlBNffjt+pop45nRQcoN9JDwOOYrSJGu6VW67mW1y31FI7MpNA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(376014)(36860700016)(82310400026)(1800799024)(14060799003)(23010399003)(6133799003)(10067099003)(18002099003)(261021130227099003)(261021121427099003)(13003099007)(261021135927099003)(261021123027099003)(261009223027099003)(11063799006)(261021133027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xy70URu0jZZlFuxZWy1JUpuBF9PAsYLrXCXo2eICKtdRXAd8BwLqnumLDgVJ7IVUvYGcsC8/79CiNFAatgmmp7YfU2EvKllvQ8qBNoAgEqvWfTif0Q7seKZTFES3NO81tQQb9R0iRRU+lmaaIR6cFLs7C1xGLgjxX43QeMkhrfJo2KUBX1V/HH1kETRUv1e7bbvRiiBPP6pX/Ac7ZZcOayS/IcLLLFtpzKvAy9stowdvfdWpESG6sOOLrDzJg6hqSupVlGt48kgyYoQ7gbWbQHgmhgzrWVVitiLm/AQmvFxY7TEs4jzPg0DmaE1wFuDbzBIMzNVvvNaBUGWGR7tcnpk+ZVAWkyRyVNUoBNZdT9MURNdmGbPeftRtLhhU+Ezf1bX+oEzqZpDKEWA/c22iYqzdvVYJQvhzGW2kRp4t6OzTxHw7BDZ50eHCrT+TuDP3
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 11:49:37.9862 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a87635d-2d76-4960-bf3b-08df30328ced
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: CPH1EPF00000529.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10281
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
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

The following changes since commit 62c9805d8d57cad407f0295879cc9a6182da464a:

  Merge patch series "fit: use constants for the cipher property names" (2026-10-20 11:13:13 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-net tags/net-20261022

for you to fetch changes up to fca508ac5084afd2763902bb2364c09388a14c67:

  test: net: exercise lwIP standalone BOOTP (2026-10-22 11:40:39 +0200)

*** Please note ***

I have amended patches "net: lwip: honor DHCP timing controls and request
header fields" and "test: net: cover lwIP DHCP autoload handoff" to fix
two CI issues found while testing this PR. The first avoids a 64-bit
division in the DHCP timeout jitter calculation. The second makes the
full-batch receive test deterministic by replenishing the sandbox
receive queue as packets are processed and checking that exactly one
full batch is received. These updates are tagged with [jf: ...] in the
commit descriptions.

*** End note ***
----------------------------------------------------------------
Pull request net-20261022.

net:
- net: return -EAGAIN when no RX packet is ready (8 patches)
- net: designware: Disable SGMII auto negotiation on NPCM845
- net: add HPE GXP UMAC ethernet driver
- net: mdio-pic64hpsc.c: add a driver for PIC64-HPSC/HX MDIO controller
- net: macb: add 1000BASE-X autonegotiation support
- net: mvneta: drop frames in case of RX buffer oversize
- rockchip: Remove unnecessary clk_set_defaults() calls (1/8 patches)
- net: lwip: restore BOOTP, DHCPv4 boot policy and PXE parity (20
  patches)

net-legacy:
- Bounds hardening in NFS, TFTP and ext4 (2/3 patches)

----------------------------------------------------------------
Charles Perry (1):
      net: mdio-pic64hpsc.c: add a driver for PIC64-HPSC/HX MDIO controller

Drew Kluemke (2):
      net: nfs: add bounds checks on memcpy into stack-allocated rpc_pkt
      net: tftp: verify the OACK packet is NUL terminated

James Hilliard (28):
      net: ti: cpsw: return -EAGAIN when no RX packet is ready
      net: fm: return -EAGAIN for empty receives
      net: higmacv300: return -EAGAIN for empty receives
      net: mcffec: return -EAGAIN for empty receives
      net: mvgbe: return -EAGAIN for empty receives
      net: tsec: return -EAGAIN for empty receives
      net: xilinx_emaclite: return -EAGAIN for empty receives
      net: zynq_gem: return -EAGAIN for empty receives
      net: lwip: bound NFS filename parsing and release its copy
      net: preserve the autoload value across dhcp_run
      net: lwip: finish DHCP before starting autoload
      test: net: cover lwIP DHCP autoload handoff
      net: lwip: add a hook before accepting DHCP acknowledgements
      net: lwip: carry DHCP boot options into the environment
      test: net: exercise lwIP DHCP boot option handling
      net: lwip: export DHCP DNS settings without a resolver
      net: lwip: honor configured DHCP boot-server preferences
      net: lwip: support PXE client and configuration options
      net: cache accepted DHCP acknowledgements for EFI PXE consumers
      net: lwip: honor DHCP timing controls and request header fields
      net: lwip: add a hook before parsing DHCP replies
      net: lwip: accept direct ProxyDHCP replies without a lease
      net: lwip: retain boot metadata from the selected DHCP offer
      net: lwip: retry DHCP acquisition using the network failure policy
      test: net: exercise lwIP ProxyDHCP ordering and validation
      net: lwip: separate DHCP exchange from boot configuration
      net: lwip: support standalone BOOTP
      test: net: exercise lwIP standalone BOOTP

Jonas Karlman (1):
      net: gmac_rockchip: Remove unnecessary clk_set_defaults() call

Marcello Sylvester Bauer (1):
      net: add HPE GXP UMAC ethernet driver

Nathan Whitehorn (1):
      net: macb: add 1000BASE-X autonegotiation support

Stanley Chu (1):
      net: designware: Disable SGMII auto negotiation on NPCM845

Thomas Perrot (1):
      net: mvneta: drop frames in case of RX buffer oversize

 MAINTAINERS                          |    2 +
 arch/arm/dts/hpe-gxp-u-boot.dtsi     |   24 +
 arch/arm/dts/hpe-gxp.dtsi            |   42 ++
 arch/sandbox/include/asm/eth.h       |   18 +
 cmd/Kconfig                          |   59 +-
 cmd/lwip/Makefile                    |    1 +
 cmd/lwip/bootp.c                     |    8 +
 configs/gxp_defconfig                |    7 +
 doc/usage/cmd/sntp.rst               |    4 +-
 drivers/net/Kconfig                  |   17 +
 drivers/net/Makefile                 |    2 +
 drivers/net/designware.c             |   33 +-
 drivers/net/fm/eth.c                 |    2 +-
 drivers/net/gmac_rockchip.c          |    4 -
 drivers/net/gxp_umac.c               |  572 ++++++++++++++++++
 drivers/net/gxp_umac.h               |  136 +++++
 drivers/net/higmacv300.c             |    2 +-
 drivers/net/macb.c                   |   60 +-
 drivers/net/macb.h                   |    1 +
 drivers/net/mcffec.c                 |    2 +-
 drivers/net/mdio-pic64hpsc.c         |  178 ++++++
 drivers/net/mvgbe.c                  |    2 +-
 drivers/net/mvneta.c                 |    6 +-
 drivers/net/sandbox.c                |   17 +
 drivers/net/ti/cpsw.c                |    2 +
 drivers/net/tsec.c                   |    2 +
 drivers/net/xilinx_emaclite.c        |    6 +-
 drivers/net/zynq_gem.c               |    2 +-
 include/efi_loader.h                 |    7 +-
 include/net-common.h                 |    8 +-
 include/net-lwip.h                   |    1 +
 lib/efi_loader/efi_net.c             |   72 ++-
 lib/lwip/lwip/src/core/ipv4/dhcp.c   |   39 +-
 lib/lwip/lwip/src/include/lwip/opt.h |   67 +++
 lib/lwip/u-boot/lwip-dhcp.h          |   28 +
 lib/lwip/u-boot/lwipopts.h           |   78 ++-
 net/Kconfig                          |   43 +-
 net/bootp.c                          |    6 +-
 net/lwip/Makefile                    |    4 +-
 net/lwip/dhcp.c                      | 1104 +++++++++++++++++++++++++++++++---
 net/lwip/net-lwip.c                  |    6 +-
 net/lwip/nfs.c                       |   68 +--
 net/net-common.c                     |   22 +-
 net/nfs-common.c                     |   10 +
 net/tftp.c                           |    7 +
 test/dm/Makefile                     |   12 +
 test/dm/lwip.c                       |    2 +
 test/dm/lwip_bootp.c                 |  573 ++++++++++++++++++
 test/dm/lwip_dhcp.c                  |  359 +++++++++++
 test/dm/lwip_dhcp_options.c          |  691 +++++++++++++++++++++
 test/dm/lwip_dhcp_policy.c           |  286 +++++++++
 test/dm/lwip_dhcp_proxy.c            |  461 ++++++++++++++
 test/dm/lwip_nfs.c                   |   61 ++
 test/dm/nfs.c                        |    3 +-
 54 files changed, 5004 insertions(+), 225 deletions(-)
 create mode 100644 cmd/lwip/bootp.c
 create mode 100644 drivers/net/gxp_umac.c
 create mode 100644 drivers/net/gxp_umac.h
 create mode 100644 drivers/net/mdio-pic64hpsc.c
 create mode 100644 lib/lwip/u-boot/lwip-dhcp.h
 create mode 100644 test/dm/lwip_bootp.c
 create mode 100644 test/dm/lwip_dhcp.c
 create mode 100644 test/dm/lwip_dhcp_options.c
 create mode 100644 test/dm/lwip_dhcp_policy.c
 create mode 100644 test/dm/lwip_dhcp_proxy.c
 create mode 100644 test/dm/lwip_nfs.c

CI link: https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/pipelines/1682

Thanks,
-- 
Jerome

