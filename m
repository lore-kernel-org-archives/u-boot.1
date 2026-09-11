Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58AAFC88E50
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 13:18:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B6BB40812;
	Fri, 11 Sep 2026 13:18:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BWNGE2Z-qe0X; Fri, 11 Sep 2026 13:18:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BD7EF4080A
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789132680;
	b=EMJdpJpfcmgyFsIwW/y2XunXgKlXeJTeY0utafXjpVEQ69xNpNLEOerSEGfA1KFkXNew
	 VoLROe+SkeD5JP7suOkwD/IAA82zi7aGwcWTnIKg+6Et5lv5nqpwlD5nZIyGX/opYt9Gu
	 oidM1QmC8kbkHzq5+mD0LwVLIBgKka/lNU4B7DtYg6UwL5zT8cOJDUUlEhAAEChvoR8gI
	 Hy9Rn7agWhP18Vi3viMY2xDM1L3v8FfJJ7T59wUOLaRCd/1A8F2OZgdgSGYML3QaNgwgp
	 S5q3u3ldLrqAXLdiv2CKm6mqthN3sHGxo3AJqeKWhGLVIAmlyQPpy0B0LmsaJdleD2A==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789132680;
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
	bh=Nyo7gZTCDN5lXZ6hAN5tiUQsfyinfCpkPq06m+BZmeY=;
	b=ZIKMZKv5q7biyqNxwiF2o2BLDeXrjIha8xkl/8db/3bTnP/KLjG0ezl9mhETjIuZScDV
	 TP3+1i7Ko1EOWzKj/rhoPECmGjqoDpadiTYRmrLadA9hSq4srRuNn4qtzJz5/JtVfP4Vl
	 UlzlBqzGY0n01W9lRl1vT7/38bYxq/e3HPskNVPfxbS+Ots3KZUqvt0qsXf2NPsbgABXO
	 B2DRkGCf+aPiJ9mytG1nVz2zzCEb5haXfxzrhmTCkXtIC0Q/JCRfGauDd3z/3QFtIvHvJ
	 NHpv3qzpNwaKIkMNDhxRLcTXAeupLVcrSIgSiQwMDesSpIb5NmFKW0KnhNO0i3fI9Mg==
ARC-Authentication-Results: i=4; smtp4.osuosl.org; dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=PFuSdiZ3;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=PFuSdiZ3;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789132680;
	bh=Nyo7gZTCDN5lXZ6hAN5tiUQsfyinfCpkPq06m+BZmeY=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ww6F2vrissrd5pcvgl2E1up2CZF9eYIWmLRn9YIq50UrwAiyUMO4/i7YF46rCjWUJ
	 5bEz1Ba+t4YLkT5Ihj67PL6h8dtywnMKEPPoR51OnE/c9x1MyVjR6ToWDcjgZDFD3L
	 Bez8MkCGOsJunpazpB3Y1b6iurnkB5lf1DYjJlhgK2jOiuyuED3R74AAYd8Bgx76d4
	 jm5FGmBfqAEBmsZvAfT5ySnr23SffWrS69QnjglE1Nh4xrjrZLPIK4dPCnNfw5LwVM
	 J8gFz+UrjsdgrhahG1m7Y+iYjvwlYrnariTaVEmwXj/RuKAUJAgpddpeqFyejBUD6K
	 NeISTA3wCTP5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD7EF4080A;
	Fri, 11 Sep 2026 13:18:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 76F832E3
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:17:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6814C4080A
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:17:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ts8bEyEiw_O8 for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 13:17:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 38500407E8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c200::5"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789132677;
 b=Ff+UfSJq66k064e8b1p6DPHOlZcfe8F2EdlDENDJf1rkzFP4dWt13Tmn2E3zzf3wEiGA
 llFSYjTo5LiU+evE3w1wRP4pnfBgcaAArzAQXUkUivsbBBIxV5k0UYm4o7Adefw7iuRZ1
 HDjojkLzh9CuYtAYgRgCGY4IDa4TDIWyWPtroup3XzqsmsBgmaBCt+SJLBAQSYQt29a7o
 UJ4ChyLUMvYbyBFgn9zu+oBUjHXgRrMf/8jFSa73Czj2v4oYKECHsVgW0jeLYwvTU4db1
 DsN4FdG2F1vMExDBZFlkO/QGILW/FCLUzQrqX1Rmk/n5U2PEUx/fdcKxMDm/BtHoDyw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789132677;
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
 bh=Nyo7gZTCDN5lXZ6hAN5tiUQsfyinfCpkPq06m+BZmeY=;
 b=OMVdjEYXRf+rKO/QMuoyCOpakICB6IDS85Vel0De4J25tvhsS814KHEkoA7SI67sQEvP
 yPl0wHO3KmtqHT6QvVbTNlv1utgC+NwIJh0KN/LMCr93JedCLt7ywavoODAtAqcuYE9pA
 HMkNCJ/Pd1G9QoHPKwvrB3dCJ0WE47gyhjpJe56C0BSSPMo7UnmuwpJQ0b5ZNzGJs3l9+
 6dBbBUhRGiLcxhonl0OlCcFTOZu1Z3wgKE+RXWsuSM/lwR+jBpa3JJaBSO5+cXxVi05Qc
 5l4MqvPGc25r0k8315HGaOeEAWRa4JdPgTcf3a7TOYwuEOSGyECBqneA4zuKewDojgA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=PFuSdiZ3; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=PFuSdiZ3; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=PFuSdiZ3; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=PFuSdiZ3
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 38500407E8
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:17:56 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=abDWc92AtEyPEytwRrUoduSzKYRUi02A7TyWJGQfnjuIRI6Z+8OrAneqgo9GlVhw9GG06+sVJIDnGarvXHXIgmVderKLlQv2Qbo8/6QLnvvEsfB8zoNfF/+1DhXqn1x2FYDdNpadG3FvulYtfdbkdu/Q+5zMkkgYfe2RqnPSC10vOhnjG9zr544AFzVhAASX8PmqWDhktfbtEnea0JqQqUGk2pDAPopCwMUOJv5qHTUJq4/5HcwYRJ3ZXm167id7G0Wk2dfmR7Lfo+WgsonFFyQHsmF56+6ZMauDZSqw7uFi+pM/52EA2UtqhbR2czrmOFAgtD1rd0utZaw5oTbpEg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nyo7gZTCDN5lXZ6hAN5tiUQsfyinfCpkPq06m+BZmeY=;
 b=k/qhJy7pPik187EQjQ72/ymWN7kovK+T5UBViKJ4q69xphlbQczO7b6VEsi3Thr0HKMsnWn1NC9rxoWZejT/YbuueZ8mMpD2bcfCgqVohfPCfe02L4sd3mLKkdeC7jz04XUFVHbHKViHyko0li7NNrrUjONWn7dJFJL2y+7BH2VTQLUDsP4kD2DT4HNjHE+UckslgY6W5sWrS7HlaR+03qK3etmLW8yQo89Xk4K85Vpp7xbyakgSLoQN+Mf1i0OSmlRulFusS9mAzFQWgeYeJAYyi5PYyi6bCZNCkhNeAFcxrleUJ8BQkLx+Wfr5Kw4u+g+r55aBlLEKpCHj2es1Ew==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=arm.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=arm.com; dkim=pass (signature was verified) header.d=arm.com;
 arc=pass (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com]
 dkim=[1,1,header.d=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nyo7gZTCDN5lXZ6hAN5tiUQsfyinfCpkPq06m+BZmeY=;
 b=PFuSdiZ3K78wYYOezqq2kDQE3l8cd03BaLpd5jwGnPRFyCZMMtmVgY9YXwjky+8YS1Yyg1DSVHEpWpazoJuiiv13H9uPtvK4f8ESLS1okdv6XlZeC0o/72nz50aEHra+1VQ0rWOHiE8P+n42OFU0m/zFIDzgq/Q0xpDfswoAjHw=
Received: from AS4P192CA0011.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5da::8)
 by DB5PR08MB10095.eurprd08.prod.outlook.com (2603:10a6:10:4a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Fri, 11 Sep
 2026 13:17:51 +0000
Received: from AM7PEPF00000055.EURPRD83.prod.outlook.com
 (2603:10a6:20b:5da:cafe::5f) by AS4P192CA0011.outlook.office365.com
 (2603:10a6:20b:5da::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 13:17:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM7PEPF00000055.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.0
 via Frontend Transport; Fri, 11 Sep 2026 13:17:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/mvv+IGyvsUwUW2i9++H1PrJ5SyayMQD4jI7h8mx63oh2zA50jAbZEaFxjuJci5Y/l+RsqMutV4myxNgbMG6MOxm7UTjnVtUgT40T3Mjo/JNKAMqRHoXPevlr1QqZBLQjgLHa498STYE0d2z689/ynr6juAtmQPFd+oXk04WN6vg2qA4VKgCchxAwnS/D1CWxJ2qfNe+1jyC3IUjD3lEJ1MXzKWlO891FYY5rmObNQgvCWvL48xpIlwsUUolB3mZpdwhCOY/WVCuol6hYgl2sE4nwH/IISLh8jVpr3rRsyqm+v9e0n83G8C4F3FreUK/xJzUtdlES/ogTxpcV0adw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nyo7gZTCDN5lXZ6hAN5tiUQsfyinfCpkPq06m+BZmeY=;
 b=YTzZo+6ClQDKoRM3g5KdRNX/V1ai7SIDwXYL76zQ3IlOubqQfM/R06BvsIzKuZcj+XE4QQXtZxYC5JBA3y6WQXpqQDaZaVQaEn1H7oNp4kI0NGtwxIByfpO/zimboul/BpyFIpLUKkgxp9xgy39Y6j4B39qJQVmkx2TcUViZvPEYY7wK4jA3asqcS12OqSSAZfmbOuXJGq9rQhVfou846BtwIXEEgCMk2feCD8SddYRISqNfLEAbLoL7qJk+QUT3VfLTnxx6rm6Dx7xLZoBwNTcgfFP3J3ZhuYqSte8+LqHgYbQ2ELrB17KBeM8C3yVDuSJWQQBuzD0V8vpMCRJI5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nyo7gZTCDN5lXZ6hAN5tiUQsfyinfCpkPq06m+BZmeY=;
 b=PFuSdiZ3K78wYYOezqq2kDQE3l8cd03BaLpd5jwGnPRFyCZMMtmVgY9YXwjky+8YS1Yyg1DSVHEpWpazoJuiiv13H9uPtvK4f8ESLS1okdv6XlZeC0o/72nz50aEHra+1VQ0rWOHiE8P+n42OFU0m/zFIDzgq/Q0xpDfswoAjHw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AS2PR08MB9224.eurprd08.prod.outlook.com
 (2603:10a6:20b:59c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Fri, 11 Sep
 2026 13:17:16 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0406.005; Fri, 11 Sep 2026
 13:17:16 +0000
Message-ID: <829d6c31-e211-402a-972a-ab5d66e5f8ad@arm.com>
Date: Fri, 11 Sep 2026 15:17:15 +0200
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH v2] net: lwip: support syslog
To: u-boot@lists.u-boot-project.org, James Hilliard <james.hilliard1@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Peter Robinson <pbrobinson@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>,
 David Lechner <dlechner@baylibre.com>, nd <nd@arm.com>
References: <20260826-lwip-syslog-v1-v2-1-8c457f2b35ea@gmail.com>
Content-Language: en-US
In-Reply-To: <20260826-lwip-syslog-v1-v2-1-8c457f2b35ea@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::19) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AS2PR08MB9224:EE_|AM7PEPF00000055:EE_|DB5PR08MB10095:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eca1294-0f45-4d77-f93a-08df100714b6
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: XdMCqqpufeJsrCYKLa2/AcCJWgaHHPyVgdpYZxTFzd0suUCsMSSDrQIIRNnLGRuayDTFYSoy9UexajeLsNwAXEzDuKsZ3hmc7aqMO5FbloSsShRjzY1Y5AFozvl/lu+kJQJXN+3wiTIDps0wkCY+ktVVRBRNKtGdN78OE+OV/WPvH37khmI9qdMQxi5j5nMjO9FyzwCAjXi2Ccd7kyZ6ehR1zvul3GfEBM6c9Jqj7zOedi5lB9Kl1+1JR++NxhV9RfiMHDGNtEF5KmZji/pjZ0kn7P00x9uVRkeITcoaXp+e+brMv7YXGYKvUgK1k81aS3BQydU8/gFur4n59JF2ex1f3Zo1tihLMjvWp3MaAL20OvvwxzmjKmQjAj4uVwOONH9hZX5tNYLdKnKq+IXBhh8OcboXQYZ/OaJSQED856ggn9m0KMXyF5Q3nOGUHt5o6utVb0JKcOrlwxD98i4QFTPQ7U56S3jO7Ia8WQS8siI+w8WldGk9GcwwVZukrwyNGuUWUzhwO+Gv30A4VWWb5G4iJMP4/Sj8SUzfJMmAF07BQ9ud/v/5ZPPlGF3pcpzzvK7yxc4PysEqoxMdovrRVjGAZwyFhi/Dors9jZd6MDGuxp3tB9CBspDisX5djS2V4NYA6SZB68hoBm525w6I3aSnrQpZqMw/nYN/eNbSiMc=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: 4g94SpCqGvteWdj2cf3UFQP4vDttWZ5BNVpn7Ts9AhSzEo3cBHkr+xSqbb2lprk3B5Wl8ETpFd/RtPQEoTooaR0kI5NxX6EYdho7nWom2STu5CqLheJThXUAk3XKwSvOSdWe4lmAWvIPS4oQu9cWuCIF/gw32bydqJYkDqmAe/HeN+X1r3mEz6XGunbkD7tE7TLrJv0CYHmJio1aXTuYbfd4IiYJdyl3MU8j8eYJrzfDjcH4cOxACIudwqUcM6ReVgvktbsqo6XMVe2EQD654NL3vQ4D1UQl59ZkCYbrGVQmJVFaxAc+00akfjwgBOqtmZGvMB1uW0WB8lH3Sj4geA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9224
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7PEPF00000055.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9674b3cc-653e-4c2a-15d9-08df10070059
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|376014|23010399003|36860700016|1800799024|82310400026|35042699022|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: vrIBndLQ4BCVML6G8tl/aoNVV6kx8OKBylwdqrhbDWkdIt2bAatbr0f0PuGFxkPSfIAeM/ZNRmVH3lJ//63HYOq/cGMmU8oiFUz4BYUmu8zvDHSjTPcRljoD99PaqorncsrzcwidQ6dyIrS60Xzkyopxe2LXHE6HmqO5VQaT4GFZ4gETjEBfpkooblNulm0FHLOCOmuSFF1BRhAkHzkTIKg2SiqvcFq0dqznJhPYow9OXMJBQhsX5ofpQnEQwZDu4l9rXutl779OF38iR2PvxCB4FZjmgAgyrFLMAiP+qEzGhdBjpOGZDr/EyLdBboAqFAGCKxFxPzu2kmiixntVvHMjtlcRvQNW6rFr1nAWv92rUp7t2xk4sp+4Ye60jesgeoqSpkDM4yCciS/dG3NFx0w7M2rjIRLK9+TtT4l2GBu4xPz5gHv7voZsCg1tabaE+kYs+feCTtrqEjUEHrO9vd/kwAGZCM1zRbGEtV3k1WKkm7IIbf+wa6T3zWOd9TqUbrmJy6N76Snd+4TLc7rR4ah2CthvsgY9iNwmD3yvZGNkg4RhZ0l4V/5NLLrLJXVMswSlWlkrQHAlMW5dK6GCsrIOzid1t/4YrSnQw/E1ztLrxhCaU6QCG4wJ5c0/PbWrcf/uYHaYKM1cA15wsdUJwStUKRxYtTEBsGOrxJfIYt9da4gVMnsgqYhwc1aeWLG5
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(35042699022)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mk7uaSjTVU0lT7JVSuzUjphw1hUwtgV/7O2+Jqs/ggQHlXPOEiheE7aukLLn3Gvmd1FlADBDpju6YTz2CI5J1dHOLPIgS7D731l2KR/gNLLn4YHD0FLCmzqqakq6767KQyNpn7N9E43xYbHN/g5HCmoG14pM0Clk19iM+PI/orZ7SR8FrKGPV/Iwh33ygbLJHTJC+visBqw/HMe8GA+IYNWAy1qw8xt/qMYkdY8+eKFDJEUgZm0huCAaO3Dphyp2xrww+e7H9oDP+oXepB+neHG9g+P4kJHZ+Ao7M6GeQvd6Mimyud1rU8rCGxIT45AEjMWUVKbCg33yVrxHuZ5KknzogBvmExQMzhUfJDPzd2LlPo5QOAHKCil7P5w+mu3mmBGBUPs4YvYD6Aujq750N6snEzZjXfM4A4rmivBNANiJ2zViafVXKAJKKTUhA0aw
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 13:17:50.7361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eca1294-0f45-4d77-f93a-08df100714b6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7PEPF00000055.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR08MB10095
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

On Wed, 26 Aug 2026 11:36:18 -0600, James Hilliard wrote:
> LOG_SYSLOG depends on NET, but the raw Ethernet and UDP header
> builders it uses are only available with the legacy network stack. This
> makes LOG_SYSLOG fail to build with NET_LWIP.
> 
> Provide lwIP implementations using the selected Ethernet device and its
> indexed IP address from the environment. Move the shared declarations to
> net-common.h and extend the syslog test to check the source MAC address
> and IPv4 header checksum.
> 
> [...]

Applied to u-boot-net branch for-main, thanks!

[1/1] net: lwip: support syslog
      commit: 6410670d25b4ca6ced6b5308d582318f7c888f9c

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>

