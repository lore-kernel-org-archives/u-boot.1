Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23306606A328
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 13:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vjqvOyMk;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=CH993qrl;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=CH993qrl
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EC89B60851;
	Wed, 21 Oct 2026 13:05:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BbF51KmX6nBx; Wed, 21 Oct 2026 13:05:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CFD0260719
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792587902;
	b=XEQNxXZIxAJaIp6tsuTzVk526z9Q7nJ22DHWUBTTKqTXC5dwG+pL9epbC3dRndD4gVaz
	 fQnO/sOP9mAlnjHZf1TFLKAiKdwSfdkrbV9YNUAftFe3wrpl7G/W2fG4f4XRlwJE/5rGi
	 zTaH6SpKcZkmfk0ysoH7E8yzEM18olUdXGdc98R2bDxgJpxg4seDVukicNpxEWVqgtrES
	 B1c4fALO8nIB5wVkviYVrEQNwnCIUFBScb7+xQVovRNbjV6+76svh05F+zfmyiFY2g3v5
	 Nuea8/FhODs583GKp0pavKpkoVAX55QAc7SYjXtG4LAjfGgMmnaecoNlzvNP5aVTc6g==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792587902;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:DKIM-Signature:Received:Received:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
	 X-Virus-Status:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=j7f4I8BJUR7joPuldS+7XKNhZ4pErpEyth+4mstEeiY=;
	b=M0UVzlML6x5UIc7UScnzAuQ2pEr2SZNWfdx/dG1TMdQA+IIb65IHavQOaHwXNHypVGXv
	 pRRND4Wib4CPw/mhGmrSd0r5NVbBtNjX2A4+BEELKe6U1gHuOiOLM6ExWGJ22HqtMKib6
	 /GxQtzTrzi4fKSOELiZ9E7bV3gULFPzTtPlWvIpV3W3IiL3oRiNPAnzBAqORv9XQjKVyw
	 quBEBR63c7rqyjKjLaE4hvGyvv7G5AsLKqvJdBHKHwcPHZHF40OCYgZxGtJcuDAgptq8P
	 A5J2j7ra7UwH2Ol8OU4QKFoS4POcO3kGZ2HDeXvwTKTCl6hHCe5dkqJY/L0jJFeGc4Q==
ARC-Authentication-Results: i=4; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792587901;
	bh=j7f4I8BJUR7joPuldS+7XKNhZ4pErpEyth+4mstEeiY=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vjqvOyMkmLGaORk4/svqfpmM08dwAMzuoV2o8mUV/qkKFaIMQxpNicGzqS71bftUz
	 BcuCbD46b5Gy+Gc7UVRI36euhXPhGCeZ7Yqr8c2E0pTmnMvlC/qj+R6iHqD1Bbgrmq
	 lcoOYIH0/JZsYbL6r/Vs6R+Y1PJV3MiwlyE1cYBSw+EzZluOFkgdAu4L/tOc1ugyNt
	 x5x/ejXlNupKtwa0iiUVXNnNpZXVPTxmzNKslEdxDCmCPNGmcQpWkGwlFwxx3iUVRc
	 yR/MNCrlhOPq7mcbzmuZX2+v317Y264EsnTRF8HRkvnIWOwHuHsnGKv+sydMLiWEb5
	 WwRxzatUzXVZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CFD0260719;
	Wed, 21 Oct 2026 13:05:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 07CEE3A4
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:05:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E2B74403AD
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:04:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UEnzRrroxbm8 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 13:04:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 416E2403A6
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip=85.214.62.61
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792587899;
 b=RC+J0B7kqbdeEg4sRTKPZNesQEm6trbT4tANhcp7NBg5XgrfYCScXrYT6Mn0KKSkij02
 OitWHp8upC2Kz3t10GqKzaSTuy5Xpcq5Muw3A029Qq+r/d44XDtpHgjJjTilKYa86TpdJ
 apIVWvjn/xq/rBteqtKDU5bI7gnC57yMGwO5bGPFdzTS6C2AhqoyUlLlHOndhiBK/g+yD
 JLuNOQamGd651EHwb75jH+/mVfkNwNOu4BeMrCHlwSUxrDU9T2qiQm3NLjCZwsbRJyrn5
 pjIsT6P4Wv41QpSOsxZUbU4Oz6k7zub55xOMDOomFjQxrt6q1R+lsSnPW4V1vaMcChg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792587899;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:DKIM-Signature:Received:Received:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
 X-Virus-Status;
 bh=j7f4I8BJUR7joPuldS+7XKNhZ4pErpEyth+4mstEeiY=;
 b=ZEdW5jTkfDxpTOM3gUk7SVWpfAAo4I07a3ZcSidE2nN7dRv8VgeUbwjHvWRqi88OA5+y
 iM/FHCvRJIlDcEKDXcG0fL7SLlZJYJ5MbXimoAmBoejk+7dan5NfYdgVUbSdrj4e4aQFf
 urDHEW0qc1KtR3B21XFzepI4W3I4BVdFUyHKUfn99clPvu4cLjYKGaLASWTszJkFJCx+R
 77dppj+wCM8KZ+Mbjn7KEnmin3x2ukLKi7L1mC7TLfa04Zu5d97X0vcAaqTC14jz0d3qm
 JeJf+wn1TCyJLngHnHUxRwB+xJ57R6MJF3S8PN+RLeEVCiTPqpWCEoTVsXDc9kBICFw==
ARC-Authentication-Results: i=3; smtp2.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=CH993qrl; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=CH993qrl; 
 arc=pass header.oldest-pass=2 smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=jerome.forissier@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=CH993qrl; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=CH993qrl
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 416E2403A6
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:04:57 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A8F4844F6; Wed, 21 Oct 2026 15:04:56 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D12D18056B
 for <u-boot@lists.denx.de>; Wed, 21 Oct 2026 15:04:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Zf4DKTtLFz0O3slRYqwRouXIN0HUkJnBx02mTeCWfViBMwVo/OKFTzvzPwE0hhbBdeD38N+eXppdup7uZ8xagwRMmDgjzZijLrYSD4hwv/gSnAPfI2zpIT1SOYy8twB9kC8PQsCB2KP9Ybazgl51+B+SethRd+eVTGpktkFI1QDy2bPaL/vQyQtRDARatmsWRY2KN/q1DFzq0OH8CwgmhIomUyNeZah8wNhBlwq8wGQFXAClsBvZ97iksQ3qrecjqk+XWgo6IqAwzKTQqwWIGh1titKo3b46lEwLrqU4dMd2zkvg4QhiFo7RpvC9cQjVbdhXDOKWI4V9WDhkKCozXQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7f4I8BJUR7joPuldS+7XKNhZ4pErpEyth+4mstEeiY=;
 b=wr6raDK97NQRlTvRvFSf0TGXsm9SKEz8WPsanUTj2k0Pmk5GhSPL+J2i3+LfZ1rAm2vuTVr4+4c6IraKR4Ic6GamKzRYHQyLKGQnwhkkctJEaEYc0ERHodhzItBeGlMugbEYMIrah5C3li//KKLtQhkZ5PN/r6Og4VoCuLgTsqHyVDQgSVf8EWzah2IQWKR9scum4svC87c4T7TS6jgaqXbQeNpDSFRS2m1sBXv+vS3mp0381aa1w8jvhPIhfTK2H8eA7EyAnKskYIYbUz4UiJVsTQSdmbX/vTD1pvEePqywdcgFEcS+gpc9Lcx6U+Rg9RPBE9V05l+Q95OZZTvXVQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=ziyao.cc smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7f4I8BJUR7joPuldS+7XKNhZ4pErpEyth+4mstEeiY=;
 b=CH993qrl+z/OKdk8GXVAIMoDEY1Hjw6s2/ExBZt3LnMJInBsYtto7R8fJr/ZqjZmYhQIcvweGrh3HIA7b/oeU9mOasI/cjo4CMeuFzJYIVKeWJzdEGfiWQWjexa8wjeLDBTe3w+0BNR+UPbRX9s06J1BSDg8kv34iIrBz52KYgc=
Received: from DUZPR01CA0060.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::18) by PA6PR08MB10707.eurprd08.prod.outlook.com
 (2603:10a6:102:3cb::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 13:04:39 +0000
Received: from DB1PEPF000509FF.eurprd03.prod.outlook.com
 (2603:10a6:10:469:cafe::82) by DUZPR01CA0060.outlook.office365.com
 (2603:10a6:10:469::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 13:04:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509FF.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15
 via Frontend Transport; Wed, 21 Oct 2026 13:04:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ae5DG2y2zDC54e8a6mb/0dJ+SkbSeLtyGaOLSbvaM4ivI4LZNPXwgvwFtMh4/QGtv8302RbYN6TsFlIttGs+wVuRcLzILa182r9bxn2gOivGvqH8LqrlEsn9/VFQYCyDTENioDkDz6uY0fpnE9rRSQbOUehCpxS26VjlocqWhq6OCJlhy3f48k6M8bBl+ngFfKbe5QeYTT4awEEWeTw6gzGEJDC0HRvM90wjwHoipmRA8+vffz2ZDMSzgsbZn3lqhdZNKDlllhDXtL0niArO5RNazmoVV8mml8Bo7uHg0RjU79PYK6JZBkR+tUzi4jLPPPLxqZJygWHXebiIdx9MTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7f4I8BJUR7joPuldS+7XKNhZ4pErpEyth+4mstEeiY=;
 b=lHmL5fKbWg915hSParIxGBDwnUHkjlisBoldY7LZWbA/mYX86XXswWjKPl9awbAvus+X117HO3uppZtr0PyX+mnFWKCJZdaSQMgpYivRaIInli4LpUmtQX0a/bc69EzMDjdIBpNDdPMEAtNMGxtan9U1qJk+J7ehYD/YJUPXYjNYxRYuTF7s+HPT6Fe1whg4WcCxqplyrjITqZYnri69DRPKZX+jbiilrNQfTuBHVmEX6aT5JXozUrpNTn/ydkNMVfW+fCKHBokGtnzspD04S/7NneL2G0dUfDxUs0y0OAO38TMsyilP29kj+wz1n2auEa4pGrXphey+ffvwI944Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7f4I8BJUR7joPuldS+7XKNhZ4pErpEyth+4mstEeiY=;
 b=CH993qrl+z/OKdk8GXVAIMoDEY1Hjw6s2/ExBZt3LnMJInBsYtto7R8fJr/ZqjZmYhQIcvweGrh3HIA7b/oeU9mOasI/cjo4CMeuFzJYIVKeWJzdEGfiWQWjexa8wjeLDBTe3w+0BNR+UPbRX9s06J1BSDg8kv34iIrBz52KYgc=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by PAXSPRMB0029.eurprd08.prod.outlook.com
 (2603:10a6:102:2bd::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 09:51:38 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 09:51:36 +0000
Message-ID: <845e4b39-bbc5-4a58-bd28-1499fd146319@arm.com>
Date: Wed, 21 Oct 2026 11:51:35 +0200
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH] net: mvneta: drop frames in case of RX buffer oversize
To: Thomas Perrot <thomas.perrot@bootlin.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Yao Zi <me@ziyao.cc>, Patrice Chotard <patrice.chotard@foss.st.com>,
 nd@arm.com
References: <20261014-tprrt-mvneta-rx-oversize-v1-1-3932a1326f93@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261014-tprrt-mvneta-rx-oversize-v1-1-3932a1326f93@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0023.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::9) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|PAXSPRMB0029:EE_|DB1PEPF000509FF:EE_|PA6PR08MB10707:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cab47b0-ddd4-437f-02e1-08df2f73dd9b
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|22082099003|18002099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info-Original: hdL8DFFCRIzcAP02hxuoM785AJuqHH+BW4rj857dW+tkk4kMg0zDnu4zrsSdtGRVtVmSHHn7r4MqVP13UYHUKbO1kz2yBKo7qFF8oPMKhlLHmu20o4SeZIE2ip9WJrQN/OUBdudQAOwVFzQhLecJDFHj+zRmey+PvbmBxELq6SpTUh5b8rfzyKsH5YIUJS9ww0wWxR7PXjzxQ6laAiVuGyNhzsOKKC9u5n8lROX8oJGVnyJRuloD8Z0F5WWJArIkuV7dA3av6ZhK3A/2PoilHq2UEuZlmKBbkQTqSsrp3cGRTvOO0sLRgMTgAUx7jJ2ctM3jnzR5RbAxSeKVOOlbqAkNny2BqRSBnBhG38fTtCTkn2otc/wzPdbCcX7KGjtnqjjEw1mTKK4bFRWoMAyphQG7CLbAZJFX7Ukkeo+eL/sZ1fEDKKfGQ2KarzxkbjmDV7brCnSwWtiQSj7xbjDp9fgPlHRguU4bqwLGiB99ziIKSAT8P3NkXdyIaafNYAKuQgvwcgQ+ujxHiT0uysBUaR3HdfiA0DIE+AojH9z67HAGOe5sDUjp/hvA8Ikvuc+bTPzoNyDCSXL6WELZIlp3polaTChs4Q2MXsSK43jzQOydAsX8C0kgUBb9j7Qd0etm
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(22082099003)(18002099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: Qu7C7JP1K9wmdQ0QW2/yhY14ssZxI99Q98qc0qgkcw9W1stuiOTqhJDWencsDABHY30N0kkHGSZGTI9vhHPp9FWwGWhzSVUrtw14hClpeexAoJQVVjm5LMWEgcLK85qSEAVTUeYpM+zsTKOIOve1YbFdX6uPN0ZhVnGuliOoREoPvWCgt+WsQylTwjKLoaHfbdvcBSUFr0gUVRxrPEIygJm5inuKgGHZ0AqgDvjARsvGPTDav+M+Ao93w014PTTrjpP372cRbMPOPFjkcQYFkaLIl9tX/nn0Smxzech5u6qN1hRhLplJyjSFghzJPSYDYGmsoKQaq2n0CAQzgrEd/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXSPRMB0029
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509FF.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5d68d4b0-02b4-4240-a8df-08df2f58e587
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|35042699022|1800799024|36860700016|14060799003|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: jLHmgQ6f/O0MXr/iFPRLZ6c4yzUkOG6o+dK5eO/p5ObblxFsejdVrx+4PnfFUGe0Sa8fk6anBfyZjpRRfQ6z529Utb0gDrAtZQDiuZ9wYxbxpdrQH5TI2bPeiXjrQz9lpX/pUmk9DtP3RKGn37sYVgGe02wHytGXg+2Tbu39fHrolTHxtK9to5Jj/nYg5dXcnQGQyHuwrfDZ581aYLyIDiIKAr8TSmJaaigtUtieed2BPMuzlzw7NR1sNYWQkrqz06b3zfXuS5Y8D5ja/1Pilj9gs9nlgU7+E9J7jdwS7/toJRhjrcMBeCdsb+j3bMhMS/uKyseRwighkBxD+JJyguOXJWq/XpVu0ivNoZbLAE+7VqsjxwQ+ukP55EJEcku157SxLxatExiyAclYRmOeuKM9aTo55PEs8Ov4sH5yhKuz+H5RcxGWDUlqC13k9PrSk3IFrI7uIHu3QDCDUhbCNJZiAC5l6ACAx9XLET6YXcMVKYoZgZetLIK/xX4mpaeWJnx0fqMnAw2mJsrUakOwp5zfcGhDni82P84KaVLBFSY6ZunbVMLToOqXeti1XpEHiNeNChvFn1pyfdRwLtkQOEyGeFSdNvFGUbhfblWUl/NddcQeo+eJP4vmXaO+02jip7v1qTPkKRMgwFS8gwpvB8n3cKXLabBEA2OqspPDG3s=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(35042699022)(1800799024)(36860700016)(14060799003)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oXMbVrBGfawptPiTpWFlS6l2zsDVxkG1C7HqWeRlcc2AewUL4N+OLlNl5TTSyF+ZaJiHVM3Yh8qOVmagCF4FcQXInSbFikz5hXxM0cYgTonqg+A/QRe2DqCthVZalmnhXOjgYdxne9oFbgoO0O7oYvpXB3XX/UJbZAOr7OnEAeRAfkw/srgSL9PcDRFQToD93/FbMaAyrfGlzhFQlVVqpdeLDcAtvq9J/2bdnnXtu9XJGN1ENwcOF+qlDs1O41F+r6idkPjfZmgE2PkK1PIHs4W0o44eVR8PrKyuuvjfkb1jXvI//llDST6UXAXNr8t2SAJxVB6eT0s2ocVRE3718Wa/tHsOlFRfjj7wkRsgQkyDnjms1YmCZ9ldb6hb/MCIL8zJYMGFwK6vhxWTBVjMiWThHyFGBn60T9ODUDY+hzDiQf11iYotlUBOGLkFgYzM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 13:04:39.4582 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cab47b0-ddd4-437f-02e1-08df2f73dd9b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509FF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10707
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
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
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Frames larger than the configured maximum legal length are still
> received, clipped at that length, and marked in the descriptor as an
> oversize error. mvneta_rx_error() already handles the error case, but
> the driver never releases the descriptor back to the ring: the next
> call starts from the same, already-handled descriptor instead of
> moving past it, and the receive queue never catches up.
>
> Mark the descriptor as free the same way the success path right below
> it already does: one descriptor was looked at, so update the ring by
> one, matching the comment already in place on that path.
>
> Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
> ---
>  drivers/net/mvneta.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
>
> ---
> base-commit: ece349ade2973e220f524ce59e59711cc919263f
> change-id: 20261010-tprrt-mvneta-rx-oversize-320f99f6b147
>
> Best regards,

Applied to u-boot-net branch for-main [1], thanks!

[1] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/commits/for-main

[1/1] net: mvneta: drop frames in case of RX buffer oversize
      commit: e8aa87c578b9f6a997c17b2a322543b901832221

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>
