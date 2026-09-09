Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E71EC79F8C
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 09:43:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C6925406A3;
	Wed,  9 Sep 2026 09:43:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5jyWfDVE7Whh; Wed,  9 Sep 2026 09:43:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C45B4406D1
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788947007;
	b=F/yjPpUdH8l79IDXKOONQrEyHdjKNf6tphl8RvevsDPjDRzKwtuSkehMjxdtuBCUlLZd
	 LJB3Bry1QdRH8uAEpPnevvpiASNZQyA3t/xTtkNFzxDzp3M88LCU+JJMu5n/MwP+aLSiC
	 jBZQzbSXpUMEMh7S09N2JfpnBfUMgg3ntQSGUSM5SmHWiTW/SmWErgtFyTO2b37zPQJ7k
	 wxfTQKlNlCK/Z8Bl/+1So88OPW+BnRWTV9HpGva47OTdUBrTlwO+YtFOu9LRXa8hIh00J
	 ABcCn90l7XmDyxF7xRfqBBrwdeKpPsk3A18X5OwN1BDWcmhfOwglAvpJblU4RizqczQ==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788947007;
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
	bh=doLeCJOwR0QSQL7/uRTzZtyNWoT9Am8Px+cL3QAnwLQ=;
	b=HVGgBXYtUbfsH4PFsr+HIQT7Be0EUFXHNk9KJ4wm3JhpOEwT2y9Ge0aCH6kvDqepC2YF
	 V1dCEXivRB/O0zA+qRyPDUHRkpPgQWRhLe1QHSofJOd9FztVGYeCuG3RtBD6dL2ppz9Dz
	 tdxCtGQDtOJ3byzdNzLy18h27guehDdG1Sw0sjWBAhh75+zRo62Y157mW5b/qVadR5Q/7
	 1vUCQxSt8KFzhTzfzc8zbCpbYkqccSPZjf4HSYIeue5QiZqm+EEA/JBWoeQnCKZ/3tMVQ
	 G/UznvB/K/rFjagnMVbtTKZlGC1ldwlegyGRf3p7yVrlAJNqEwSMnH41QMjRxDy3CFw==
ARC-Authentication-Results: i=4; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788947006;
	bh=doLeCJOwR0QSQL7/uRTzZtyNWoT9Am8Px+cL3QAnwLQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YyUvoc1LSByg4PRdbGutK0i05QVsef+tszRNeQOGQttx0O9I5zpsJRRHwtlsm/Ge9
	 wBL/mNR6ePn9m+J19vtlgLMDuCCrIJ+IF5/KZaBr6tf4AlDj1fUB/ZRtwU/NbKgbcB
	 PywQgXdusMFVM2T1PamBRt5isf+tmAY3bZNjB3oIG++SFv+aYbwLs47oG4AXpbtI2F
	 cDMzMT/OuyguOC6jC4VEZbjfeiEfHpS5NZoYrI5+pR9/Y3uaUSgqWzp0MFDY/g07E2
	 WeSM/NEk0Ru7FEGcEPL8CQWs0fIE3ci4UMnsetwJLjKjIm50ndlpHsDPiTsvzZvhes
	 PYpcOsTHvbDFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C45B4406D1;
	Wed,  9 Sep 2026 09:43:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BC9282D2
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 09:43:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A292380C8A
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 09:43:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tj8Wv9X7G6Lk for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 09:43:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 361D380C63
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c20f::7"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788947004;
 b=qT7HREseJPZ1OqR4weyXixBTTSj8h3F7pSd3VRJaUvg7IspF5EJJs4hl90p8WrgKMjce
 wN2SrcPa/frCY0io4bkRW0KXoIds2eCSkxAVNquJhvmoWUtOgNHUwYC/sQsPnuRzAZDF2
 x0maqblW13Ph8MYD0QdftPIh2nN6k1uzLyVjhUdGByURlFgYesoY/2tS85yg7XvZyC2Lj
 htFpYNq4RBrm4RlVEEVxB/7wSMKy3rZYEJuTROS42+4OO3mwj3SDD9osXAXO8E9+usjIX
 rSUFMwP9CEZHBZd1PNFcphRssAAsFzFmg5ebQw8rEYRCD+UoLNHGxX3mdNoh6JfEy9w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788947004;
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
 bh=doLeCJOwR0QSQL7/uRTzZtyNWoT9Am8Px+cL3QAnwLQ=;
 b=I7baFdx1NHvmzHeJjR2mxvm83XenU35EXdXRa80iRDyMNEh2hYl+s3WfSQC/C4F0gX4f
 i3v7YoPzrGcJiPsdFOUnq6RKmOiUtADZOpFtQ04YvhDNVia3WggQpXpry3tmG5qVypjGa
 nVlBjvtY344P2xG8esC+xQLKjnzSATuqASIEolCEMFu+eb7Ot4JxRACGN+Gzvcfl10ncd
 RDepVkQnK8ldvSnYecwVRBYPh4uXK20XYFSptOvydrNNPfC6CfO+2FsHkYRxA97c6VyiA
 5C6M6ZB/whX5OoDbNabQVCiqmF6p97ulXWTonbri9dGyoT64ELJaG2fInaS+gzsdAEw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=TC+Qr7oO; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=TC+Qr7oO; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=TC+Qr7oO; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=TC+Qr7oO
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 361D380C63
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 09:43:20 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=fz2o9+j0eQJpkXPiOlDjej3TlU3Ne949SnnmXEOYayDeM85rYDZpFVFEewfSzdZtdPpgfydNWD4k/PslpYqHjpnkcdi4vhdBl7NOUwnPSvMGsAYQD/PbOy0o2rM5Fx1BlSLb5WuxqBeMQ3Gj6m7lK9sKUJwyW4IU2pJ9F/0uv4JeDpahdH6YJX47Mn4mrFZwE8Y+RwjX+PB5z+05qJ0iZpo5AuRlIxPrXdpbdgUMBfATY6QRt7RknVG5aNQWN1/iq32TQsB9ni6TzxltL9Wqr6j0NY7NAJmYVHUPaZ+zZq4mRHWCfN78Jk+0rRTYgWLiD1pqs0/hmZYWAne03EXBEA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=doLeCJOwR0QSQL7/uRTzZtyNWoT9Am8Px+cL3QAnwLQ=;
 b=bxQqIwF9TcMbrpLTiC1NguoeLD/qecUzo7wiFGu5n1+RenZ0rZy3FvlZMbu2t6voqbm/RrHKcj/mQQbvkkhdGHjeap51JihaK/cHSEHwHRP2dVLuSnzjnJxFFDpZzosOszR/H5J7Ur583h2QRDpptrnDwU+w/0kyXn/nxIyda4XmY13wRm+8I3PTHwQ43Vyf+tGRQk5TaWCZi3xOrAsLOHuym14UNsPlFwSp5J+LhMF/8v/D1hNLOjZED7bhY94f7yv8GZWGg/yrtwAq+zU/GfrxeLjpwCTk3of5JNXZAER7NSly8Imxy/7ugO90PQ8H37OhDERUDqjqmYywZh8AcA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=google.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doLeCJOwR0QSQL7/uRTzZtyNWoT9Am8Px+cL3QAnwLQ=;
 b=TC+Qr7oOhGXwa53i5BGdwD2SqjARss43uev6KwCLDD2mca/4/bf58bfBokUB5x7LnLqtsfybIjSPJ2zRRdtQwmg56bp56buowip2nTH/oilFji8hVRPpMcRovHPeQJoEkQYBvPPG33pSPCbFElTfYIYmhGp+jn8XLqeQNVRh8Ak=
Received: from AM9P193CA0017.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::22)
 by AS2PR08MB9690.eurprd08.prod.outlook.com (2603:10a6:20b:606::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 09:43:14 +0000
Received: from AMS1EPF0000009C.eurprd02.prod.outlook.com
 (2603:10a6:20b:21e:cafe::9c) by AM9P193CA0017.outlook.office365.com
 (2603:10a6:20b:21e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Wed, 9
 Sep 2026 09:43:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF0000009C.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Wed, 9 Sep 2026 09:43:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWdeLQAeIlFviPt2kvO2Jn6uzq2+EwmkWktDRTn7iAVT+aIkgRa8Ygv20/Ni3bf116qwQbuxU9afWRCERM/nP9BhppqPdgz7WXgyI9ELyE/1K67fOm1y8cSQaUWkdLU7yUJ4DB4EU9mShQ/Grik+x3gBRAOlsok3+cew27mJQUCw+PxPdvQ/8YWM1PLr9n1r1CagXhazEJa4igLwBmVS0RyjTldmARKCMgq4b/fMEeYdgeC2t2bYBOI+pLzTXwMfQfZebiAMk7BRsSsbW+fQPVgodCt+iXGg1k25xaNCvuktTeAzJiPdLJNbGX2yl77aDSf1PIgzPtT6fpN0/DRucg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=doLeCJOwR0QSQL7/uRTzZtyNWoT9Am8Px+cL3QAnwLQ=;
 b=hirV8xV5Rb67PZjxuoChBEHDvFhXiBI/ckvT25DN2yqbEh34iNERevsj2NgmRikgLf/Kr9/Moxd20oihAkGpBUPlTQbjVqxnWgG6WYokr9eDnJMX/JLaycQpRVxbFIeg+QiCbiVpzbPDq4v/T8xX6C/dV3r40t6ZcmZg9KsGzOI16FbZE26BUCxOBl3du+fGKW0VW9b8iVIBH68EPpvy9DiFe/lCFFnsdyMMh3nIWn57nHRvnqieZptWoIxaSRM5bxHbHeEpMnWwZcx4WexCwM1JIdLYOEUM/V/IVzGgqTsRdKBBSNzjfPWTkYoLBDZCyql1SeX4wnJdyJRSjZvU6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doLeCJOwR0QSQL7/uRTzZtyNWoT9Am8Px+cL3QAnwLQ=;
 b=TC+Qr7oOhGXwa53i5BGdwD2SqjARss43uev6KwCLDD2mca/4/bf58bfBokUB5x7LnLqtsfybIjSPJ2zRRdtQwmg56bp56buowip2nTH/oilFji8hVRPpMcRovHPeQJoEkQYBvPPG33pSPCbFElTfYIYmhGp+jn8XLqeQNVRh8Ak=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by DBBPR08MB6027.eurprd08.prod.outlook.com
 (2603:10a6:10:20c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Wed, 9 Sep 2026
 09:42:41 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 09:42:41 +0000
Message-ID: <5e256015-056a-4599-94f5-d995af7b285b@arm.com>
Date: Wed, 9 Sep 2026 11:42:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dhcpv6: support rapid commit dhcp6 option
To: Yuxiao Zhang <yuxiaozhang@google.com>
Cc: u-boot@lists.denx.de, Francois Berder <fberder@outlook.fr>,
 Johan Jonker <jbx6244@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 nd <nd@arm.com>
References: <20260825175417.1068611-1-yuxiaozhang@google.com>
 <63520249-a647-47ea-bd14-c9b6a41b35f8@arm.com>
 <CAOOoKeSLKjWaeGBxvrMmc2MqvgdNahcBrbV=-aRQFLL0_caLnA@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <CAOOoKeSLKjWaeGBxvrMmc2MqvgdNahcBrbV=-aRQFLL0_caLnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AU2P273CA0114.AREP273.PROD.OUTLOOK.COM
 (2603:1086:200:6e::7) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|DBBPR08MB6027:EE_|AMS1EPF0000009C:EE_|AS2PR08MB9690:EE_
X-MS-Office365-Filtering-Correlation-Id: 68914bfa-6051-496e-a85b-08df0e56c4e5
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|4143699003|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original: rwV3H0J3lLe6kbPmfDyWKg+JK0owHF65gwUftRGKNdktA+yGiTeYp56rOZdERXnACOVZDHbvGNgU8irY406dwmDP3bDD2daS6+/rwJ1cngy9qx3viBRo9vjQgag0vL92l1JevwbIM1TYPWDp3k9HfvcivQy3GKWaR6ibOenZEHxsZ35E+AhVdqAAIf4I6Ry6S0q8WvLx7UxUIDKj1R5QZK5vjj2jOuXHhJCgcuNd9xie/vXIZcHdrG7U+DIQ1d4Hh4xzcTXOqTBCC+V8hg5KoEUaY2w8vzGM9dHlw3m6mQoy8uWMPxQXwbgl7yT8x6LIlhn8InOHkcYE2Mftm5N3RoA05D4JHZcRxAMfocai5MLmOcOH+m4VGg683BzQmYQvXf0r6by0sDM1nNKEMVKr4QYB5pWl0/WaKxILP3YWY08oUeYQCL+Aln/jp2BnDimj0BeSKt9YO4UVMiVHSXIatgBdbtz4itGexrcsaFL9xhNH1SJuFmg7U1ZMA1mgO2Ah27FOJuWqsAOlIjGfpW5bazwsIwigLkRksujJlzvf60sljTPY+bwRu03vgr/wO11J30N31RTorEAHW3GKc4kKQ7NykZ6SDjX9moa8Fkvg3k25SL41jYR27wlIDSN9/gP8bmwf/5c4uJnY6uY8wMov5HBJtySSR6f00GVGlj3rwbU=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(4143699003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: pAYpuLPjc53efJjx6q/SnCSTubb32AjJGipusOtjCt7MrY9sqfORHyWmVmHIdiWCs3N5E8zGvOCjkaV2IAXkBJYYl/p89MgSvXJP5v10/C+I/CC8kTFgIbfSB7xYOlRGSmbgBSkAt7nwywut48PXxGlUyUQ+qZgNJUqPmUR09Ds8ds8pMbvlUgnTgAlKBkBRGnlmXietpxEU3acT9W9YVjxCH2xlWVPLInuU8oAz+/EILrQv3anDVlDYVAAYde2a3xsfDvCrh7u3iid10USNQ/YcbRVW6EaRg06URkFdiuIYs8yS3xfkderKfGoheAgbfDx5KXLIsmy8usD/peIWYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6027
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS1EPF0000009C.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8ff9da7c-49cd-4568-1e3f-08df0e56b109
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|35042699022|376014|32650700020|36860700016|1800799024|82310400026|14060799003|10067099003|22082099003|18002099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: rhx5SDGQJ+1dyIy9JR4fwNfprLemMw727QnJmjGrvvsGPr0VGJYPka7mTH8PZUl13JEO9UaqINtvOIIc9r7/d1H2DtH+u9G/j+OaiM7dQgUeNEhbrOUcpYIHTrJVA8SNTVUgnPt7Hkkm26+kOkbJr6cMcszYiz+Sim5kBt/UMhpYQycgxqc3R3yLFvLjzG6K5HH6AMsHKJVl88WT4aWSicO9qIVOV1cWcnFfDMFMO/712BkUCEAJaxCw+P6hO2QYlDkAp1VphyYt60aHFYzF0ZGwkJilaHp9W2YibEYWp1nKzso7UazPgCxjB2mUUG6Rv3pgNi93b/cnO6FrhyyflqDlGfxOXspXC83FgZIcEs0QF6R/iOPGZGexwaopl+BD2UN9680h4X1B7LFwynwsgjFlnQ1BUg6p+MVZUDptmqfYG0D+0thyJHjM7CADcUwwOYeDMq2DHmruh+WcfDIibi9j/0+J3dy7FlQjxa0Y99h6ZCZ0FYEo30tvhKdt5ThNknpDZR3uhzyBBzQXElzLLgYROqr9NXkdxObDIn/Qs8fVT8bLrb4gKm7J07NpNXoFEmuXL6UwJtrKomKYBRHkyqlD/x4sr44iqBNo/1K3pWiHnQEQ3kl9s4hrF7Bs1CQo2EooYAnw0EqcFkG6rngs0rEFwGi6rxsKR0Ub9fosXk1G4j79XCG/NB85QrtjccK/
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(35042699022)(376014)(32650700020)(36860700016)(1800799024)(82310400026)(14060799003)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 80bX0XbpnwxUy7FYzqJo6xDtwq/oAHgI5+PzwMpIDKUoBSecchql5Mtpr/mz4+lO2zB0FQcKSzXMbe1ssWxIXIwMLYVjJZExy+y0+3lzz2A5wejR1/XhSARH9dHiAVkDd1hoHJDLrTgBeISJHab+Um0zdJeZoDjYVctdEgYAtQiKN0QsaN32Vkuqa5fdbA5GVprzVtwiyR3GbvMsp2bLniRAtUkpM0BMo44x7v66kdDhbXMvSbJjtpLfHshP/7Lq4Gc2sPyACdNo3RV0tADr0GT0cm02hAiXqhxe8EuVzaB0juYDi25B6MxwYu5hYIIYNHv/uT8P6uGigxsMQgofjPCE51yyn2qL95IPdkWVx4X5lo9hPud+T2f5atXMwKfdT8SnGNbRZe2gAGugHNyDs1Oc6cc/xOZAmlt1ePQJPiLaN0Z2pSYpH6lrqlaqRpvj
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 09:43:14.2277 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68914bfa-6051-496e-a85b-08df0e56c4e5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000009C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9690
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

Hi Yuxiao,

On 08/09/2026 22:55, Yuxiao Zhang wrote:
> On Thu, Sep 3, 2026 at 2:01 AM Jerome Forissier <jerome.forissier@arm.com <mailto:jerome.forissier@arm.com>> wrote:
> 
>     Hi Yuxiao,
> 
>     On 25/08/2026 19:53, Yuxiao Zhang wrote:
>     > Support rapid commit option code 14 which bypass the advertise and
>     > request state. The option is enabled by DHCP6_RAPID_COMMIT.
>     >
>     > Signed-off-by: Yuxiao Zhang <yuxiaozhang@google.com <mailto:yuxiaozhang@google.com>>
>     > ---
>     >
>     > Changes in v2:
>     > - Reject rapid commit option if option_len != 0
>     > - Drop redundant NULL check on dhcp6_hdr
>     >
>     >  cmd/Kconfig  |  8 ++++++++
>     >  net/dhcpv6.c | 43 ++++++++++++++++++++++++++++++++++++-------
>     >  net/dhcpv6.h |  2 ++
>     >  3 files changed, 46 insertions(+), 7 deletions(-)
>     >
>     > diff --git a/cmd/Kconfig b/cmd/Kconfig
>     > index ff90a87024c..b3cf3a6d8b6 100644
>     > --- a/cmd/Kconfig
>     > +++ b/cmd/Kconfig
>     > @@ -1996,6 +1996,14 @@ config DHCP6_ENTERPRISE_ID
>     >       int "Enterprise ID to send in DHCPv6 Vendor Class Option"
>     >       default 0
>     > 
>     > +config DHCP6_RAPID_COMMIT
>     > +     bool "Request Rapid Commit (2-message exchange) from DHCPv6 server"
>     > +     default n
>     > +     help
>     > +       Request the Rapid Commit option (option 14) in DHCPv6 Solicit
>     > +       messages to enable a 2-message exchange (Solicit-Reply) rather
>     > +       than the default 4-message exchange.
>     > +
>     >  endif
>     > 
>     >  config BOOTP_MAY_FAIL
>     > diff --git a/net/dhcpv6.c b/net/dhcpv6.c
>     > index 640f089a2e1..5ed8449edb5 100644
>     > --- a/net/dhcpv6.c
>     > +++ b/net/dhcpv6.c
>     > @@ -115,6 +115,9 @@ static int dhcp6_add_option(int option_id, uchar *pkt)
>     > 
>     >               opt_len = sizeof(struct dhcp6_option_ia_na);
>     >               break;
>     > +     case DHCP6_OPTION_RAPID_COMMIT:
>     > +             opt_len = 0;
>     > +             break;
>     >       case DHCP6_OPTION_ORO:
>     >               oro_opt = (struct dhcp6_option_oro *)dhcp_option_start;
>     >               oro_opt->req_option_code[num_oro++] = htons(DHCP6_OPTION_OPT_BOOTFILE_URL);
>     > @@ -194,6 +197,8 @@ static void dhcp6_send_solicit_packet(void)
>     >       pkt += dhcp6_add_option(DHCP6_OPTION_ELAPSED_TIME, pkt);
>     >       pkt += dhcp6_add_option(DHCP6_OPTION_IA_NA, pkt);
>     >       pkt += dhcp6_add_option(DHCP6_OPTION_ORO, pkt);
>     > +     if (IS_ENABLED(CONFIG_DHCP6_RAPID_COMMIT))
>     > +             pkt += dhcp6_add_option(DHCP6_OPTION_RAPID_COMMIT, pkt);
>     >       if (CONFIG_DHCP_PXE_CLIENTARCH != 0xFF)
>     >               pkt += dhcp6_add_option(DHCP6_OPTION_CLIENT_ARCH_TYPE, pkt);
>     >       pkt += dhcp6_add_option(DHCP6_OPTION_VENDOR_CLASS, pkt);
>     > @@ -448,6 +453,16 @@ static void dhcp6_parse_options(uchar *rx_pkt, unsigned int len)
>     >                       }
>     >                       sm_params.rx_status.preference = *option_ptr;
>     >                       break;
>     > +             case DHCP6_OPTION_RAPID_COMMIT:
>     > +                     if (option_len != 0) {
>     > +                             debug("Invalid rapid commit option length\n");
>     > +                             break;
>     > +                     }
>     > +                     if (IS_ENABLED(CONFIG_DHCP6_RAPID_COMMIT)) {
>     > +                             debug("DHCP6_OPTION_RAPID_COMMIT FOUND\n");
>     > +                             sm_params.rx_status.rapid_commit_found = true;
>     > +                     }
>     > +                     break;
>     >               default:
>     >                       debug("Unknown Option ID: %d, skipping parsing\n",
>     >                             ntohs(option_hdr->option_id));
>     > @@ -618,14 +633,28 @@ static void dhcp6_state_machine(bool timeout, uchar *rx_pkt, unsigned int len)
>     >               break;
>     >       case DHCP6_SOLICIT:
>     >               if (!timeout) {
>     > -                     /* check the rx packet and determine if we can transition to next
>     > -                      * state.
>     > -                      */
>     > -                     if (dhcp6_check_advertise_packet(rx_pkt, len))
>     > -                             return;
>     > +                     struct dhcp6_hdr *dhcp6_hdr = (struct dhcp6_hdr *)rx_pkt;
>     > +
>     > +                     if (IS_ENABLED(CONFIG_DHCP6_RAPID_COMMIT) &&
>     > +                         dhcp6_hdr->msg_type == DHCP6_MSG_REPLY) {
>     > +                             if (dhcp6_check_reply_packet(rx_pkt, len))
>     > +                                     return;
>     > +                             if (!sm_params.rx_status.rapid_commit_found) {
>     > +                                     debug("[DHCPv6] REPLY received without Rapid Commit option, ignoring\n");
>     > +                                     return;
>     > +                             }
> 
>     dhcp6_check_reply_packet() calls dhcp6_parse_options(), which has side
>     effects such as updating the bootfile information. I think the Rapid Commit check
>     needs to happen before applying the other reply options.
> 
>     > +                             debug("REPLY (Rapid Commit) good, transition to DONE\n");
>     > +                             sm_params.next_state = DHCP6_DONE;
>     > +                     } else {
>     > +                             /* check the rx packet and determine if we can transition to next
>     > +                              * state.
>     > +                              */
>     > +                             if (dhcp6_check_advertise_packet(rx_pkt, len))
>     > +                                     return;
>     > 
>     > -                     debug("ADVERTISE good, transition to REQUEST\n");
>     > -                     sm_params.next_state = DHCP6_REQUEST;
>     > +                             debug("ADVERTISE good, transition to REQUEST\n");
>     > +                             sm_params.next_state = DHCP6_REQUEST;
>     > +                     }
>     >               } else if (sm_params.retry_cnt == 1)  {
>     >                       /* If a server UID was received in the first SOLICIT period
>     >                        * transition to REQUEST
>     > diff --git a/net/dhcpv6.h b/net/dhcpv6.h
>     > index d41a3c30615..49f20390730 100644
>     > --- a/net/dhcpv6.h
>     > +++ b/net/dhcpv6.h
>     > @@ -24,6 +24,7 @@
>     >  #define DHCP6_OPTION_PREFERENCE              7
>     >  #define DHCP6_OPTION_ELAPSED_TIME    8
>     >  #define DHCP6_OPTION_STATUS_CODE     13
>     > +#define DHCP6_OPTION_RAPID_COMMIT    14
>     >  #define DHCP6_OPTION_OPT_BOOTFILE_URL        59
>     >  #define DHCP6_OPTION_OPT_BOOTFILE_PARAM      60
>     >  #define DHCP6_OPTION_SOL_MAX_RT              82
>     > @@ -152,6 +153,7 @@ struct dhcp6_rx_pkt_status {
>     >       enum dhcp6_status       ia_status_code;
>     >       enum dhcp6_status       status_code;
>     >       u8                      preference;
>     > +     bool                    rapid_commit_found;
>     >  };
>     > 
>     >  /**
>     > ---
>     > base-commit: 527115ef6783cec49e5610c523c124b399011361
>     > branch: main
>     >
> 
>     Thanks,
>     -- 
>     Jerome
> 
> 
> Hi Jerome,
> 
> The rapid commit validation relies on dhcp6_check_reply_packet to set rapid_commit_found field so it cannot run before dhcp6_check_reply_packet. If we want early return we can add a rapid_commit parameter in dhcp6_check_advertise_packet and do the validation inside it. Let me know your preference.

You’re right. Looking at this again, I don’t think we need to complicate the code.
So this is:

Acked-by: Jerome Forissier <jerome.forissier@arm.com>

Thanks,
-- 
Jerome

> 
> Thanks,
> -Yuxiao

