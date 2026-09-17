Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA45C982D0
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 08:52:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AC44360822;
	Thu, 17 Sep 2026 08:52:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U-qYBNvjHhZD; Thu, 17 Sep 2026 08:52:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B837E607CE
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789635121;
	b=U63VEkIc3lFDl8jR2wCAA+5muGd+3d8ue46X2S973he6bpRTjNl8AG3fkcujgOYlkIGM
	 3UhnprpcBsncEIM78YaT9gTOepDVoxBjW2q0/wd1sPPz3dSeFiakCAMgiryMxOW7DAZxp
	 U9B7wM+VTurMJJj+95H3OFTGVLZ7S8Yeof11hzzgU5JPjb9YYDKJjmVuQ8plS5DrHmfHG
	 Xm7py4kSm2bchlNClYtl2LG1Uo55tnn5u2i/dmMb6X32TNkvJOTgKKtedF9Gm6IQHvVTv
	 EgcBKIAq0smr/R+S48utHBPQ57IPBqDk48XaiawUgpfYU4drtu5QEhEEw2z7wFolQxQ==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789635121;
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
	bh=6FiUx9pu9lDSdR7VmaQM8lsvIIOS6L188ohA20QXJx8=;
	b=Q7Z2jWIvLYnpws3F9yExI8k66UbfP26BJ2BpYQP5gkIrDzTaTB9oRUYshE4WZO0QduL1
	 ENno9OKZlfckFlHwZ9ctKr1pu0o4IMxrAtXQP9VtuCW/1EIPnbIEre6QapgLDYT1pcEU2
	 N8eliOYc4bckR9g7WbgA0ByM69N91Xr8BPgMVIhhMU9SgiM/pLXi5WDleVpaTwRxscwxG
	 xTx3PdsLNwMkJ4kur0UASf0AZZEHvcRZHolDbmZZHGj8ZxE4ICkueUEivtu9+5++1IUtt
	 Nqc4BrWFY7Bf5aAqLu4z97R1F+vsLZ6Jl+6ghXRJP89w9uWlKBP/5q56ckXER2EcFPw==
ARC-Authentication-Results: i=4; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789635121;
	bh=6FiUx9pu9lDSdR7VmaQM8lsvIIOS6L188ohA20QXJx8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=og1gp7+17ZE23yQIlW+/zpt5LFr7lGwcp35DENOK/sFLT2CnQFiIr9btwMMj8NgfV
	 kZxQz+3RKqZ5/hrSzz0HO5PJ7QqZb6/sm4sQD54QPcSTv0WYIzFigt2Un8eKqR2cho
	 K1kS/osPNn7yJXCaBX0S7Pf9aOFEHFDPn8nJ5oMFCFGI76PFv+JCMqL3tgHTJxN2Rb
	 EmPmQw2gZ8Vydh2YY6GmZzlRxBl5P6IKzlsjZlfcKDbwiIQndOMBPm2avREvFdLL/U
	 u4TEDnPB15YhMR0t6zGaL+YwSTPBGiyFBise5xS5B+KJ9Xn6YUeWauLp4VnPrUP9BC
	 jppA9oThmwpuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B837E607CE;
	Thu, 17 Sep 2026 08:52:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A347737A
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 08:52:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9449F407A2
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 08:52:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3twawvwQ84Xz for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 08:52:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E093F4079D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c201::6"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789635119;
 b=bwg/wQhYQbl5URrWUt+aITF196v7AmJrft1M17I7AKEyYerysMg5WDiqxiwqEcQjO1LR
 SXFfiVRdzGKgwMRHgGNGycCw9VZnVugsWGI0AmiA++a4ykjs1uYjts2NqqiwB7jqHdOPh
 cH537MykAJ7/kaG1lkMub+aQng6MQ78JxPQQLNc6psZoZLU4ZL9BmJIKq9VbDSfH7Path
 zmjDIdSMiGoevPYMZMhClVN9VucxfbylXyRrilFnXkB1UZwiwnL7nwyDzOucaNOIV4baS
 o4MrCeUp5DS9v7B6Shj7B+Kq25yc+IeDjUlAoOjqzecXc2X0wJRkZxiV0+Ef+icTqKg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789635119;
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
 bh=6FiUx9pu9lDSdR7VmaQM8lsvIIOS6L188ohA20QXJx8=;
 b=OA0QK/kXkgOnPttBDglXxGaQEoMipL8tneSa1rIMDACl0H8ddtoJ+Fsj3+wh4PHUvCN/
 Dm9/j2xMntNjRRlSw/XiIatH1Mg8Qvc10L4tTHRC2EhR6ljFjGO8Qd5IgunxIYKbgEwPP
 YV5I2kK/u875y2GgQyE65MASnzVARKjd9EVRtYgJqC4U04JkZXDUuya5Xuv0xz/qaYUfi
 82ZHyOCoXwwNqjjskNfcTqKFkEYHNV8UApTgylICDg/9868YH+KkDZi5kaDB6m26cL6kC
 /nEFZWakmL7Y1an5TejW2AJQFSAyUQsQj4L9DQChwBDtSIH6jcWDOr6UIyZfmqaWB9g==
ARC-Authentication-Results: i=3; smtp4.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b="d/DxiRDr"; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b="d/DxiRDr"; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=d/DxiRDr; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=d/DxiRDr
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E093F4079D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 08:51:57 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=rWD4xDoeZB37LOje8fZyTXzGtruDV2fSdsQ//s4WaPZVjxZhi0gHcwY7KEFKPvKvpmq/7CQZBmxyZWB0QPgA89AR/GsdWzUQEW4kytDohpsyRPq6p9HK3UZBMbW1jDMZfOaNwSzR+XbdFGrpt/McHKAdVrZF7vFssi2K9Q4VaGRUrxqpSRax+V8WRaSsIncYakeMvufPk8jAlBDFLVC7UO/6oLOmv9XWBb9FDV9tgKUSSUKUIVN4NMg09tzTNGSXH4z9RULXYNefdA3ICY9T1QYpQZ0zeYVPsYwuEfpSdI+pAoTGF6RwxKi1WpavMt1TQB7KWsyVakHjlG4Xf7/T5w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FiUx9pu9lDSdR7VmaQM8lsvIIOS6L188ohA20QXJx8=;
 b=FQ8hv0LdApZPVUoAPDvpCtCwD3zn1+eygsJVI4e6tX7METRtC2F4aoIpa8Ch9s/U2LLSg/zBK99WTMJssP20CChRAYKvrVvupP6L4Q5gWnTrahYoI77mgTU2t5H/kwabZMnpXRIJsSIHWgxJS9AagGYxYJMFSzW8D2QSHrMBDM5Ou+WxE3JpyA1K+5BrnYNAzLFZvsC6E9DhUBd4n762rFLOsJJbLRprgIKkhmAG+Ap4HJCJkuJSpGshRnROIhxtQvS6FI1hSSj97m+HizQ95Pl5atIH5AAxT4EmVdYacR53wKifI3Nsnlp4Jl9tOFLIrcW7lPB/ftg8dDz29NoXVA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.microsoft.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FiUx9pu9lDSdR7VmaQM8lsvIIOS6L188ohA20QXJx8=;
 b=d/DxiRDrOR5aqDQLMeQQmqPtjjhtNXqLxaLTRaVRSgREZN3imJixRPSVBYYX27sBAu6VlBct/8YcVwmmNrTQ3+TgNXa3uk1siquqkW7Nc8Hmem6+OVb6IGI/lemf0m/tSpxnUFE05lEwAO+yrW5By9x6EAQyZTn1xkJbPLXbh/A=
Received: from DUZPR01CA0349.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::14) by GV2PR08MB8631.eurprd08.prod.outlook.com
 (2603:10a6:150:b3::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Thu, 17 Sep
 2026 08:51:47 +0000
Received: from DB1PEPF000509E9.eurprd03.prod.outlook.com
 (2603:10a6:10:4b8:cafe::15) by DUZPR01CA0349.outlook.office365.com
 (2603:10a6:10:4b8::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 08:51:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509E9.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Thu, 17 Sep 2026 08:51:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HKNUo851HGScqJLb9r9F3W2NlVCMVbqUgmnQPI/cG0kdOm0pJVwoXPwU5kterEwImfYmiMptZLPdu+RLVFUiF5cDSG5aRDSBUr3tj7u/T5L+aBWewfMP7x8kBy2ewrUU38JwUI8W1qLp7l0v4mQPj4giquSgg4f+hdfzrsF95WCCi2WG2dYlFlKPpkR2ZGVZG1g4ooGkQYgIsxeP3vI5LuIOmV63NKPZeDamlra3Z9UUsOm9+ZcNxZ9UjxZXdQhYGjzr/c6zn9EbeKeUqa73O+5OrkM6bDNClSw0v3Q/AOJOEJq2HE2Z4oK+aaKQmyXhiDTGmk6KEnN9Xwp3Pk2mXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FiUx9pu9lDSdR7VmaQM8lsvIIOS6L188ohA20QXJx8=;
 b=kumekpjdha5AD+c3vMz3RAXzPOShgHQoYgZDZKkAlhtKNHMWmE5V5EhwP1oxlJj7ZshGUfvgNqoYDT+o2/P2+LgggZ757lCrF+SjrZCMwpo31kVrRAG91bkaNPosnpwCS+tD1qp56ogQqfZCZJkcJ6ZjAit6L17eREaEiAkQHMZ7eV+QImBIyD+gt3BC8HGu5Y1hq6hfu1cJaJgJ05IKlW8tNcXrrcF0E6NVZ53yCr3F0zu0XcQDE4LM8mlWvC/DMTaHntA/sjag80RtdpS4EAN/+8m6LArTBZSYnK5DsU6lQfHLOT4S/liznXWXPw8YXtPW2GmEhnClnh9PRnsjrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FiUx9pu9lDSdR7VmaQM8lsvIIOS6L188ohA20QXJx8=;
 b=d/DxiRDrOR5aqDQLMeQQmqPtjjhtNXqLxaLTRaVRSgREZN3imJixRPSVBYYX27sBAu6VlBct/8YcVwmmNrTQ3+TgNXa3uk1siquqkW7Nc8Hmem6+OVb6IGI/lemf0m/tSpxnUFE05lEwAO+yrW5By9x6EAQyZTn1xkJbPLXbh/A=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by MI9PR08MB999906.eurprd08.prod.outlook.com
 (2603:10a6:290:b3::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Thu, 17 Sep
 2026 08:51:14 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0451.004; Thu, 17 Sep 2026
 08:51:14 +0000
Message-ID: <9b60e9ae-493b-47b0-8506-e93e93f343ee@arm.com>
Date: Thu, 17 Sep 2026 10:51:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] net: tftp: verify the OACK packet is NUL terminated
To: Sriram Sriram <sriramsriram@linux.microsoft.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Drew Kluemke <ankluemk@microsoft.com>,
 Daniel Munic <v-dmunic@microsoft.com>, nd <nd@arm.com>
References: <20260909192016.217183-1-sriramsriram@linux.microsoft.com>
 <20260915205210.260404-1-sriramsriram@linux.microsoft.com>
 <20260915205210.260404-3-sriramsriram@linux.microsoft.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260915205210.260404-3-sriramsriram@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0052.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34a::13) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|MI9PR08MB999906:EE_|DB1PEPF000509E9:EE_|GV2PR08MB8631:EE_
X-MS-Office365-Filtering-Correlation-Id: a934474f-0b9c-42ca-5e70-08df1498e7f0
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|4143699003|18002099003|11063799006|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info-Original: 3TU4Tj5EZ7MNgdou6U4HlatHLahqMTpCYgrve4tmCd+hkab9mkYZImQuGTI6Ds37ZYWVjzOKt3caK7/N5SfmHBWpxubbAfsrhiUr+fm9SGIxNB36xmwb4s1gbH8nsYkjTwLMl/pHRAEaIGZ6FHmhYUb35KcZ7ZyOIUUPok9PYAwh3K/eOkVeu0ZQgb8UI5Wdz7b++jD1rlZV7nU3ROi61YiNi0XR6AOMKcwKZX5eTtkyfmC3E3Obf1OaoxYunaLpvuE9T1lISE7Y+fp4LdriGlq5aNapQbbpS2FNdY3dWUhqVjozwOoq++pcqOvOTbllaqGh4vvUPV3y6uaqFY0WdFS5IBb7uNZB7Tzgi7cTjbD4GkTzHQudJcug7ZQ4QYmqzRB3HjVJAuxj9DWtBOxFCLs5ZfAeKdWW/nsFCOl+e29kRDIKsASZC9YzQE3wZ5K7T+ZRyFCqz1mn46gB3IamROzCGnuccpsdlCl/Ofxk8Idiix/rbcUpf04zkzwojX3S9dWkAosrFu+HiNWgPdgJCl5/OUyY/wlvTNL8ziArli/ZNmscQ3YFrFU2KpJE6kIkXYvis9JgxwbonoUTs2kcsIYJHeu/atgoHl8z6Dcu1Ank9UZhHsteC2/tr8NIh9jj9i+zGdWiASpuKW4RYGR+ilX8nsEGz55MO3L0Kjqszts=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(4143699003)(18002099003)(11063799006)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: AjtkEK0Fq+j3VRMxlLjo0F4mFjNmhLuF53QkaqpLEBs+KJuf/MpHPR4DLZiqS/FCXuwavY/PnnWo1T95+ib4iV8F/fbkZFjwJMsGAonnAIOWsQ6MlNTGVF4GYLVmRSa6txncFtWyzzGA7vyt8yA9M3802p9VldfAKUPoa480STEGuLngFTknA+e657LO9ze7Vre2qcBqury54XBMCqusdCuRljp8ILRAkCV6RfSVzYfWvh3KV/xA/5nDPUb0k8fR+gmXOoLFuDS10s1BxdzF5j8M3iT7ZEEefMS/YIbtCX+YL2PAKcAZlmPMTN/N/iOaOWc1nXfCMzwEryVd9/L+hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR08MB999906
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6244c9d1-ec72-42a6-dd99-08df1498d47d
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|14060799003|36860700016|82310400026|35042699022|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Tc2Skk5+6wk0u0Eh2kWkMm3evp2DRBOUBY2O1pp5EESe4717PTVRDm37Cwxq/BszTgjzfHGDaI2FWpFIEcaf4do3jnUZmUliW0MPA3d/5BuTZrfV5IEpeWKHeAJg3uA8u1wmO+waB9FJimF4Sp9g9l1RKrO2D16jA81+wLQZTRZ7/uInJGEKTIHXQKTmtBC3HVg73/+TWVJ09fWWAyxVTOGv2I0biU1jxSZoxFd7M5kL4wUD0XqT5I7/XXRzIbMBRHtLP2EUQ4x2sAOKMXd9UD+RnoYzScZQGc5R2DR3uRAVoq1RDGystMwiq9DIKYHeVeM3v7nNiaE6RfSRB6sG2TsUIH0PVGB8qUdcXhbcNZUiHJlXRrAKrAzjOLtX2q9JMPXPf1LMtOgh2MqqlaIiBrK8b6oxgOjlDXX7NoMp+UtKno4u6jrr+aZIzZth4bzdmnwMlS9aABNz1SOxWMl7Gd33cyPGBCD6W/lzfnd0FV8Sg6Szg7p90xFfut3yXsXRw+lL0GUTn2qQnmLruYQAvxNDNd4STMPAmaxexIKlMB/mSRBQ1cdkukInBqH2+7Yzog5Tog8nGvUVW2G3vZnfpLGOHAqU0Am2VRFIWojjIsulZpH/IxAaCeb0KbNkeNHPjippvkuKwu0SyvcYnq8hXvQFoslXojqwyrNsNMsAiTXwNSFAv8FceRyo2ax91H/dSOlKfZWdPPq13y+qJXsLXg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(14060799003)(36860700016)(82310400026)(35042699022)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tDfRCuq4Mxw+f9DzrfPJinJvcwAsp5jYkTHODHHtrd+JXF/hM9jm5y0MxwadhqokWfNMaeCZ/uceCHWTCU/hTTs83pvC+Jtwak0dpXvM4C+j0EQJt2ytHkPOeLbrvjHPDvAfgU9C+QuWEZJ3BPePIyh9AKqd81YjHGBMi1V5SixPEsHrw4OUaQ7ivwT1GJz0f/VjRhp8UL2qe8uCnwctrE25lnpgVw/NCxqn4pWcGmBO5Dxi9hL2R0IhXb/OKZz2UYyQdFPlGgF+SAu2FbBdKJ2w7kZzfxkuKS1RMmFB7nPHEwK5fZ5+pAFk8K0ZR9WXlpR8v1z/YU2zejd4RRPYUWQ1QN5dkSfFvua4dOE3IAEfGmoFoI3Uhn+urZQyWoBUF/gkc+a2MJmTpYtRZOftdy3NihuM7NnWfVTj2spsfRbPuTJnbMf3w/0JJth+xptr
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 08:51:46.7734 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a934474f-0b9c-42ca-5e70-08df1498e7f0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8631
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

On 15/09/2026 22:52, Sriram Sriram wrote:
> From: Drew Kluemke <ankluemk@microsoft.com>
> 
> The OACK handler matches option names with strcasecmp() and parses the
> values with dectoul(). Both scan until a NUL byte, so a malformed or
> truncated OACK that contains no NUL within the received length makes
> them read past the end of the packet buffer.
> 
> RFC 2347 formats an OACK as a sequence of NUL terminated netascii
> strings, so the last byte of a well-formed packet is always a NUL.
> Check for it once on entry and drop the packet if it is missing, which
> keeps every strcasecmp() and dectoul() below in bounds without having to
> bound each one individually.
> 
> Signed-off-by: Drew Kluemke <ankluemk@microsoft.com>
> Signed-off-by: Sriram Sriram <sriramsriram@linux.microsoft.com>
> ---
> Changes in v2:
>  - Replaced the four bounded strncasecmp() comparisons with a single
>    check that the packet ends in a NUL, per Tom's review. RFC 2347
>    guarantees the trailing NUL, so one test covers every strcasecmp()
>    and, unlike v1, the dectoul() calls as well.
>  - Smaller: +16 bytes of .text on am335x_evm_defconfig, against +24 for
>    v1 (net/tftp.o 3222 unpatched, 3246 in v1, 3238 here).
>  - Retitled from "net: tftp: use bounded string compare for OACK option
>    parsing" to match the new approach.
> 
>  net/tftp.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/net/tftp.c b/net/tftp.c
> index beb9d08f5a2..73b31b8357d 100644
> --- a/net/tftp.c
> +++ b/net/tftp.c
> @@ -528,6 +528,13 @@ static void tftp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
>  #endif
>  
>  	case TFTP_OACK:
> +		/*
> +		 * RFC 2347 makes every option name and value a NUL terminated
> +		 * string, so a well-formed OACK always ends in a NUL. Checking
> +		 * that once keeps the option parsing below in bounds.
> +		 */
> +		if (!len || pkt[len - 1] != '\0')
> +			return;
>  		debug("Got OACK: ");
>  		for (i = 0; i < len; i++) {
>  			if (pkt[i] == '\0')

Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>

Thanks,
-- 
Jerome
