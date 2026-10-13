Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86BCBCC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 11:57:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 94C66605E8;
	Tue, 13 Oct 2026 11:57:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qMd8t9RXjX7I; Tue, 13 Oct 2026 11:57:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CE5A3605D6
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791892643;
	b=RS+Q2DQmOF0Xg7BzexugekEIbVp61N6GkejYAYLOTYYlzJ6tzn63UfOxj0ukGjvWGYO0
	 y1Ry/hr6dZJajhZDPpKUNRUo26sN/OSbBu51OBX3VjE+cUPTVBifhOEobWMPETcZh5XDT
	 QswxvzGRPoYI6G4mXn7oigE40CE7CoFs6iwg09JHtT7JAAib/TOJkEEV5VxaN74W06ZjI
	 5ScO+euKFY4eYTpvS3DdjV2sldTupP9qM6rBS8QP8BLAFUflN9Y51iUJhquBmDxGF5oba
	 L/5m9brtHeRMTUzdNf2vvb6jbAXs04cIGK1pZp6gK1GBbElCUEubffM+rnIi7qNlICg==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791892643;
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
	bh=F+6Jw40aoxeMlrwjLxfjU40YIlCR2Kr60dptfixqyP8=;
	b=n9gVf8+ykvD0C6E2QvI7rPt4MHj1+3SHxuLxJ/oYTNmNowyzE2mH0bSVlSUoJlrSseSY
	 QI1Gx8zLZze7TjJU/MvG2UspLWSS2zB9yMFCKsitOV82N+Lpt4xkpzawR0xku8shKreM7
	 SXelqCWV2LVjK2x7r3f1aJi2tAyRYOHTLk5++kptxMIjEuxuuXcifGQcUO1EWD9Xq6Tj3
	 ILK+eMhdEpVuD5mHZpnp2GmpjaL7u8AhyuRg21kLsKe8dLgBGQ5Y2TiB/yLAObEepMXxM
	 lK3PD7JmdV4Q9rb/x2/nunmpXsy10XgPo/VeQYX1JZX/EUdDIUE5VzOkOC4qy3JrbaQ==
ARC-Authentication-Results: i=4; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791892642;
	bh=F+6Jw40aoxeMlrwjLxfjU40YIlCR2Kr60dptfixqyP8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N+59LrSPsgduE4pOuONmHDGM71PyJDEg9rrMfOafL/GfqKvl5hTqDaAiUnbXzWhaR
	 Z0SZQrRg7mB/I7vqxXpN5f7JdiCpVzp6Tk6p74tlTNgh9RoVIklHOm+v8/LRybFFY9
	 H5xa34K+EkRrauf5QfXRgslzfoRPSRhKuFzkR/RBOur3Wg6a2hBLKXWETFNMhxsAbR
	 xGp4vVzKAz2WQ4MqOs4gwmWobhKtLndY9DTQvtmWB3gcN8Eo6H3bSQocEflNUK0gd7
	 Bg8bbz3s06grjirFG4HM0BOwXh1087LwWI2pbmnHpQUxLOv/8NjDorTF/q57OaUr0O
	 dpbO1L/Mq6PXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE5A3605D6;
	Tue, 13 Oct 2026 11:57:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 75A25362
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 11:57:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 647E840448
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 11:57:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZC-L5Jzz0rPq for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 11:57:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0DBC540435
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791892640;
 b=Px79ES/D3hyuaKFVgEHIZA7VLAGlegtKB8KPA4VqkriY/qCsu0bO+HLHh2yvaYdTGlKi
 ZEhAvufATx37fewR89VzrV9wg9Jvbpzp/8lkCr02JvzJzATr+VuQDNT6d2eYdtutXO82k
 2AB/vvc7+jB00xvOBjNx8kzuErsK7340B24lrFMzwisGPgpmkmsyQgSx5492aYonyV0zA
 cjqG4QzdJs1ukWmCNUm1R1g7qcz5n9lhax6i71ssD0Ur9XYxoKWQYWqIPQ5377v76nrgi
 3Nommqav3/vhvHxRyO+pElfjt/sCDgZ8PCTV8umKbFhuD7ZjuyZfYsaTvoxZKN0Z0eQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791892640;
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
 bh=F+6Jw40aoxeMlrwjLxfjU40YIlCR2Kr60dptfixqyP8=;
 b=Ag1LpGRKkT+/RffjerExcV5Rt3Y6WOktv8eAVPsZggsmTnkQLOAkIHD25VoujpfkVUqR
 kUhol/lVR0jnVx/paiO65B5EjgQdFQTWppOrEEiPIum/EL3BjMPBuOio09ZuDll5uH0nn
 mF9Dt0nsm2/lHPXqjIdAWLFePKpaT0DAacY5+6vk2fEnlm5b0Ki277udi4cQ/vU+ZuF31
 LSJuVI1hI4TUPI116SAYh+rNieGTDom+u3hprV2Q733Fl4I1CkxoMJpuY8JucjWz5uejF
 J/MGBDy9DVjPUduAwfc/D/pDqQS+np52U4W3XtZxvX+2Y24ZEZq0bjDSh/k4IOdnk9Q==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=G9YwXTy0; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=G9YwXTy0; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=G9YwXTy0; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=G9YwXTy0
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0DBC540435
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 11:57:19 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=md2ak4LWKmfwCT5i98pNTrHPP39L4UFAwa5RR2QPhdTqgt14M+f0MHYr3krgprRPuJfC37iBVu02dg6oU98h99MvFuFRPhzBo7+flLuDPE+iP+BlxKEZBfmvqBHLXNh4qXTOnLtAmTTzMHWfQuX/6sWy9MTY3aC2fiXf9RP5ZkPQCGaKjgm/2NhEsyITsX7mvKcl3n5YK3cwZ6O1DOgNP64TDkv7yX9MKfsc/PUhDbOD6xhVwh+6Bz2fI6GnQ+VZrWpF7qU3QcFRq/ArlpnbxiIkAJR1E/Tt1nwPmaNeEOebDpwClmGsoaGxIPXctd0TleoZNWPtzayzSsgAi361Hg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+6Jw40aoxeMlrwjLxfjU40YIlCR2Kr60dptfixqyP8=;
 b=wTXAphHQCkFdxYpYe7enE3ljw+16+TiB+AxJEz6l8JtIPRXnWJX986CwJblN1b6b/MVbV3Ji61CIwoCLrgjTPoIK9fC+RZPX4Febu1Fkqz39mhNkdbiMdfEqyqyHKLDN/RuivxidVcW2HAAwB268+bH5KnRqI36xGKYsmjEFEzmVeyI6gyv6/eZ2z4mNGUeAWou57ST3f6d1Pv4gztXQ4iT8myTEy8u7ZmaM1exo+thfKq1ekVIJHLaZkZ6R/ZtoJOWpRgHsvWSQvCKQnQwZ+rSe0ijfmi3mN4oKv5r2fL3n3Slwxhv6jBWP8M7yFcjHQqbfmhZwqkNDu+w7GG3YkQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+6Jw40aoxeMlrwjLxfjU40YIlCR2Kr60dptfixqyP8=;
 b=G9YwXTy0Lj+3hROoxJ6AD/cAzKVa7JoQo14damheV08PgbxXHvFL5li6m3i6VHzkOKlQJfHjpraOI18boj1wPHH9NgHYdbI6mO8uDpOcCBv3PzDaJgxK6kcZoQSlkJCRStLsXEzujw6OCySjKcLqfQ3n3znw1ozNgb5I9OQBdiY=
Received: from DU2PR04CA0268.eurprd04.prod.outlook.com (2603:10a6:10:28e::33)
 by AMBPR08MB778461.eurprd08.prod.outlook.com (2603:10a6:20b:78a::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 11:57:12 +0000
Received: from DB3PEPF0000885C.eurprd02.prod.outlook.com
 (2603:10a6:10:28e:cafe::e) by DU2PR04CA0268.outlook.office365.com
 (2603:10a6:10:28e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 11:57:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB3PEPF0000885C.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Tue, 13 Oct 2026 11:57:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fzjrVBAg3O+nfdq5fyY2jFiRAnD7qNeLjIqCDU4zr5afHvl1iVV2fXMY/o0d7PAR3wJnVdoCNmfcNHvalY1SHKG8nKEPn1G4JnEvSLrOeR8b/gFOzgrguinHm3opI1WpWkzujx+nxLn8MSlwTBayQ/V9Obc0trTZ1Dh97E+cobWIdbTNaaQ13T1+I11vQ3K7N6rqqaj03dK0x7aeQMdeNWwE3P89qHkt9Btxr8rrW2vkx3xI9FJkSr7TsbfIxNP7+740xEEG6BpnrW/vVUUanHcXkcZDmndeVaBkvB2HBqIzG+cmGHwkc+p0KFGzbdRF919R2ATCE3e3jVeYungPkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+6Jw40aoxeMlrwjLxfjU40YIlCR2Kr60dptfixqyP8=;
 b=SyXPwAnZFNgYV+gmsr1g9ysaVqM/4XHIXXIzAd/ARv20WZNDZaJ/CUbyCTiWjTiK8ByKGZigCTj5moq4dlLCyDOhGIBCsiQpQ25Zir1YY+FOmYjAm//+O5Lfb7VjRQPYnGvmzt/a5QVxpw2SDCt48LE7yrt4t9O6n4P/9BW3vLJrGlue3ybMS2gI3HaF3SimqmaiJBQrIU18SFAiLqm/kyqbtI8wjoZE0KzyWgx0Ay4ADalgnl+ycdeLJ1RN5wUB0y/sfyZjS2DEu86kubA3kYZP/cMiHJWgKpMz8AysKCEqh87mTYnSyzo+6be87bd3rNj+S9rf+k8Wr74c186Bpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+6Jw40aoxeMlrwjLxfjU40YIlCR2Kr60dptfixqyP8=;
 b=G9YwXTy0Lj+3hROoxJ6AD/cAzKVa7JoQo14damheV08PgbxXHvFL5li6m3i6VHzkOKlQJfHjpraOI18boj1wPHH9NgHYdbI6mO8uDpOcCBv3PzDaJgxK6kcZoQSlkJCRStLsXEzujw6OCySjKcLqfQ3n3znw1ozNgb5I9OQBdiY=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by GV1PR08MB10931.eurprd08.prod.outlook.com
 (2603:10a6:150:1f3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 11:56:39 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0522.006; Tue, 13 Oct 2026
 11:56:39 +0000
Message-ID: <d354dd07-f33d-4e23-ba81-0a5b2b1030de@arm.com>
Date: Tue, 13 Oct 2026 13:56:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: designware: Disable SGMII auto negotiation on NPCM845
To: Jim Liu <jim.t90615@gmail.com>, JJLIU0@nuvoton.com, trini@konsulko.com
Cc: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 Stanley Chu <yschu@nuvoton.com>, nd <nd@arm.com>
References: <20260914091613.1194020-1-JJLIU0@nuvoton.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260914091613.1194020-1-JJLIU0@nuvoton.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0005.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19e::10) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|GV1PR08MB10931:EE_|DB3PEPF0000885C:EE_|AMBPR08MB778461:EE_
X-MS-Office365-Filtering-Correlation-Id: 62e668d7-0e81-4756-a0f2-08df29211e1f
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|10067099003|18092099006|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info-Original: 1Z7YR0tpiPPigz2/AvxJsFB+t7cMJGOHho3ROuNTiumvaRXiewQ8ULBi9bnkmstqPjqJh2g96NDfPv6hbg+nj49L3fT6N4mV2wbqGRwv6UbPCqzEjglSKb6lU+7WTr14djR+pKBwP2tpOyMZLZMaacfVvuY5SSM0v5Furhln2V+GHm48/aVZTkTOeYfXjYsLNG8AOwfbkkEG75JwjpQfn9twam6NzUCCAKGYAEleryEFbHsyjw/DnZR8GZT39y7e+Pgv9E6BAnG/rI+KIxufErXqqB+g+/+vBvfaYKllDIa6AU3IGbA0d6OZ6ohjvvehzfv5vvmq+Xx8zSG+AdfAeFFSJJnAoDWWlC4yL62jjouVYO66XezboxbHvKanwfxB3cggr4kRtgU5HRB5KyJpR9MxlA7Hl2hizOri/Mm7c0ueN8PcwJcYrNB0O0InzDP8D9VOxGozdtY3ZNR/sq9/2avbPXXSZPy0NDYBsxWGK+HkNc4/PB570Z6i5kKoTgObKl7R7R9VZTuGd14dvmburX4of4shi6O6i9iE3CeY8d57F0aHeg+xLIfQAgs/KjXSd9xUr0G+praDayTgh2DliFXNNVvztT/M00TfrlWWdMevXAJ6wlxiUA8YnH+5iiPoxbYAdHiV0R0+Dhx2uyyAMQHm2KwWDo7F1lFwptMMsBw=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(10067099003)(18092099006)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: qxw/PfTlehYORAo8LywTzsA9/rzjLZ9eObPEQ704VsXB1iwB5IxzTooWAwL9KbJffBKFRudb+N8EwSJS/blPuJ7YhVx2qECuvDAjFgQQ1USD9Je4ZUWZF3tqoCsoigQWv1wkGMZOV1zh52gPmrC7Z+lTkpEkl+T45GO/CYLcUcV9sgbIIuGtCc3u7r8c8hydEslEwSx4GbvEbbg8ugMAXe8cteGYI4w3ELZGWIGzqAyD1k6u1XhOcRQD3p0q1FSMogtTwGUI/BxA4+6RDQnJV50nDuiVnY5AzmX/PFWg3fzOWM4b2yZ62xyauM8MFSTjH7O4JS1tI90NSsGz17odhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10931
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB3PEPF0000885C.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0b2c358d-4aa8-46d5-312b-08df29210a53
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|376014|82310400026|14060799003|1800799024|36860700016|23010399003|10067099003|18092099006|22082099003|18002099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: nHVOSz+GhIFhfcd5nQLeQLofvuXkV0GjdHueP0NTm0XEoNWgnFPNuPvFeBsXhSihGNSSLrzvd0FU0FCGB4RE701Z14+NhEfPufOi2rGuvYOsqQGOXQYmZ58hjkOBVZ8QN1ADTfWSXH9ftYvrOc0Zin4BfSNLqR5ITwZXeyAmxU3EyRqJ1qwORHj936QcAYPP+BJFK0vF656CWitpGpb4L92nu86do62IsA9GCNoyF20CABKVlC4rxtKJKKjPbE4IrzHOg4C73C2HzeOcPnhznt02kdak+3bG0tY5ldbwTcfonueQxlFIjugTChcf49gSXrgvTRgjWwuRG4ClWNVR77VwwUJZ8b6LM3gQciys9sZlMNHc1v6xHNGjZGjoAgHaWfg9UB5qbvaJnlwGEyYH5vaCeikyyhRAtknKOJCMEP7OYxV7JjBPdShHOktZyCzrcqQBjr7HDYYUnPQGgK7/l1+fspNa5iz9EM4OYNPtoUtl9pBubbLcSX3Msp5j37UdKmkt0Dz3wIGL+l3YQPxGEYWvQmZMQi0bMtBMwsaxbwD2xCb3+WDe3qbJTHpRt3TlfZBo4QphLAhTsuvGTGZZDUwRfc5yKsNR8tchNRCLuulAZXyKCk7j/uvGKX1KixBAWAbw1d6r8RK02/y/UvasSm9YSeDE8k6ouyTSYtIY68uT5ULMHsROpZBusBv/bRtAzkAQLMSxdFKjloJn9RNfhA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(376014)(82310400026)(14060799003)(1800799024)(36860700016)(23010399003)(10067099003)(18092099006)(22082099003)(18002099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 31H1VjV66A0upkUY8s+6imcWA9h6z+fS2D98iwB1CdgqataOVTlWHUxm1mfZwZKq/51OAjhKCI/WtlEHMnflsueWHlE5T0JRRVaerpTD4OwmzlDtMl1wb9fnGtaBi4Su4urPNpORo6WcbsSXopzcIaXCY2o9bKVakVDnOZK3+fVKaz/QGt/2DmkT5gx+yQbCP/lvmdjhJeBHTYy3/V8QAHiDZp86loXs1HczWIXlsWde3k4pDFJo8h/8UG8Axm58HdiO+MtEdmWajSwBnJG0a0MFeg06wQgOm7j31e7mDgC5SARqMqsVihkmYuam6EakAcKtcCgIOXG0TmYv+0HOdoFiQCqVcKdnXaP8wYyuk8WFEl+u0QdhrtY2cM6qYCcaogk05PgXomXrr2mg9wjrgtQmYkv861QbXzmN01X5QP+ucEQEMB75ZRbcbpRhwxzy
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 11:57:12.4908 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e668d7-0e81-4756-a0f2-08df29211e1f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF0000885C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR08MB778461
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

Hi Jim,

On 14/09/2026 11:16, Jim Liu wrote:
> From: Stanley Chu <yschu@nuvoton.com>
> 
> Disable SGMII auto negotiation to avoid link-up timeout on NPCM845.
> 
> Signed-off-by: Stanley Chu <yschu@nuvoton.com>
> ---
>  drivers/net/designware.c | 33 +++++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/designware.c b/drivers/net/designware.c
> index 6ed9c6d538a..5ff84c13bf9 100644
> --- a/drivers/net/designware.c
> +++ b/drivers/net/designware.c
> @@ -498,16 +498,33 @@ static int dw_adjust_link(struct dw_eth_dev *priv, struct eth_mac_regs *mac_p,
>  	if (phydev->interface == PHY_INTERFACE_MODE_SGMII) {
>  		ulong start;
>  
> -		/* Indirect access to VR_MII_MMD registers */
> -		writew((VR_MII_MMD >> 9), PCS_BA + PCS_IND_AC);
> -		/* Set PCS_Mode to SGMII */
> -		clrsetbits_le16(PCS_BA + VR_MII_MMD_AN_CTRL, BIT(1), BIT(2));
> -		/* Set Auto Speed Mode Change */
> -		setbits_le16(PCS_BA + VR_MII_MMD_CTRL1, BIT(9));
>  		/* Indirect access to SR_MII_MMD registers */
>  		writew((SR_MII_MMD >> 9), PCS_BA + PCS_IND_AC);
> -		/* Restart Auto-Negotiation */
> -		setbits_le16(PCS_BA + SR_MII_MMD_CTRL, BIT(9) | BIT(12));
> +		/* Disable SGMII PCS Auto-Negotiation */
> +		clrbits_le16(PCS_BA + SR_MII_MMD_CTRL, BIT(12));
> +
> +		switch (phydev->speed) {
> +		    case SPEED_1000:
> +			/* SR_MII_CTRL.SS6=1 */
> +			setbits_le16(PCS_BA, BIT(6));
> +			/* SR_MII_CTRL.SS13=0 */
> +			clrbits_le16(PCS_BA, BIT(13));
> +			break;
> +		    case SPEED_100:
> +			/* SR_MII_CTRL.SS6=0 */
> +			clrbits_le16(PCS_BA, BIT(6));
> +			/* SR_MII_CTRL.SS13=1 */
> +			setbits_le16(PCS_BA, BIT(13));
> +			break;
> +		    case SPEED_10:
> +			/* SR_MII_CTRL.SS6=0 */
> +			clrbits_le16(PCS_BA, BIT(6));
> +			/* SR_MII_CTRL.SS13=0 */
> +			clrbits_le16(PCS_BA, BIT(13));
> +			break;
> +		    default:
> +			break;
> +		}
>  
>  		printf("SGMII PHY Wait for link up \n");
>  		/* SGMII PHY Wait for link up */

You mention NPCM845 in the commit description, but this applies to all platforms using the
DesignWare driver. Could it cause regressions?

Thanks,
-- 
Jerome
