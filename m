Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D97EC88E56
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 13:24:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 03F7080F2C;
	Fri, 11 Sep 2026 13:24:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9prk9mFViT_Y; Fri, 11 Sep 2026 13:24:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3E0EE80F54
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789133076;
	b=FbOVDPIiyslQzxPm0+RQUGl9TBxVLPiry215IRYpVR4330ZcMkCHTpSNC85EOs+3j61m
	 zUuX0ipuoVgfI823aLrmQM/w4lrTTCyiTJMK4Vrr1vyOfKs46BeXNXp6c/ad8BLahePqH
	 HdXlKv/RhP8IEqCAotuYjED4tT5Eh/48wQ4ueP9havJIyUpzQWHyYX8qFr/ZsPvAsUTwT
	 oREqSjwmkCvzeAhjZB9qvUHKNbt9sZx2bdVPUWunW1Cut8+ELXzp8W7Um+okKnhHqqqZ2
	 IZ6FN6tl/DBVRAYhfg1LUx7nWjqVRqUiE1QaxwYxPGX1bifEk5icP7A/27yNwjCMHfQ==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789133076;
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
	bh=h4qXqiTp5Da6ByZgze4g1JjNEzYCsyYP4c+IxgBEe2Q=;
	b=OeI1rx5Fxw5FcicYwqjfS3EROHTJyK+OduiPpp8/fkT642D+QRk34NQ/wa6YegCc+lvm
	 DWbsxo4Iw+Jeqi2/s3fycYWVh5K7J4MMHOXo/vLWkWUxeYDuySfWQVqY6EeEOUVEQ4W/T
	 sKUzVkG+AJyYdUpltfnR1JW0WzdAKk99f1pBLVlgzxHHOwRoatH5UZB0ETGReL4kVO4nE
	 dNhKqetdHeS9aZ604mOEB2tgpNTlPXkDlq2zp+Xv5/TFpE+cvos24sjLvjy4Q/gkSEaLw
	 LpFqMKfHNQo3c6W7SMV5tRbvWN8x/Ji8zaw33Yv1CrnLSNy5aqQ2QEnhbxpWLF/f3Zg==
ARC-Authentication-Results: i=4; smtp1.osuosl.org; dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=E6hF0MzT;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=E6hF0MzT;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789133076;
	bh=h4qXqiTp5Da6ByZgze4g1JjNEzYCsyYP4c+IxgBEe2Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KpFkm0G34tIwoTLpvILphFQYgJIf+7j8msgF2guAVjFrzPTXA1AnHnx/uPHe7rh9K
	 IfscUWOt+r7Q/bRI/29Yd5Zu4xvWW7c4lwfZsPMIetgn5efjpFay8sXNNby80acQ6B
	 gcXiOdjwPqIPG/+IoEl/xzZCYh27VJXIMQWIgXDTH1wdE5ctSIQxiBGASGCjOLo8I6
	 FKryQI5pylj2Lqyy6ShEs12XQxTR8e9NJij7IzyyeugblAhN56mbt7MhV/isooJ8vf
	 Yu3UVOIj6yPPNBLN+VuIjOYTJPtZzb1ep3wVe/Q7Y+ofA7gKRC+q2oStmqN7Uw73/r
	 ZPCp/mf2A/CqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E0EE80F54;
	Fri, 11 Sep 2026 13:24:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D3F6A32F
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:24:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C56AE80F54
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:24:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AUG7q8ldxPE8 for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 13:24:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D438480F2C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c200::3"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789133074;
 b=a3aDg/+30zFIb4H+xBghWXRfLRst0ohcs+Iug27bKCD92M+dbAkm9El8MYjpA/sloBd+
 Tk+bHQpJoC6wihaQ2kdapmxZ0SVfMaS4bqnpfm/63Dd7YLk54kD/i649eghtXi6y90NZF
 RU4Jgd0aPP06bzLMRP3Td6kjYGctqZVjrGpFSMBSd7geIezNkITsAJ1dnrwSz9QNk+zf9
 XyULgYGcvkWp1yIg6YyV+dl89/uXEKxCi0mdiQcF3NzqMfgASiajI4ECADuQtyisCGNvh
 iMwfCYgxo99z8X98hrhu5450os2YZs52ynXP+kIbNRD8HAEzWXhRUf+lcoDIPK3g7hQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789133074;
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
 bh=h4qXqiTp5Da6ByZgze4g1JjNEzYCsyYP4c+IxgBEe2Q=;
 b=Luw4FkdXX2PLCjxi4ssCFI/p/V5kNrKf7y1FH6ZvDf/HnjQcQ/pXgmf+VpJhXinlDcBx
 MiulYkCrsNDU9sjNQ66RWqJWTnHEsJ54qFM+e5iDMBgpME7r7lM02tfve26ycEesUn+Nf
 iu9anHtI7tXuLDx6pzWLMxQYlIEvc4mGeipGehPB9kXKPu36/aMLeBEETVkfIywY0jb4Z
 8z+be44XQM7w1UgB2I7yAWa5w3i6PvC9jW80wTYOlIEm9Esr1JVydtgn+IIm72u7EZpee
 LJU9c4m3Gz9Dl/A4udQZf95cotfAIQy0iXU4z6UoYWvYerxLbkU1UxtcYk0aXSXDFHA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=E6hF0MzT; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=E6hF0MzT; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=E6hF0MzT; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=E6hF0MzT
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D438480F2C
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:24:32 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ZhV2BTHD6tnRhwZMvLPo+oZMW8qTObfUYYyn6lmRBHKH0kDgTYan0RcxYu2Lc63clJLn0cj1NNOXiLOHeKM/4nhwUNltV0mOVuljEVO5poFnR24aln182O+bi7jF7WTCZ9D70qGUJ8zE+FxKIsY8+8lCrfCFygiW4mD9lOI859GZWutQM/7+Kq33bTw3Ef6dX931oDZXKQUvprm3BaNlC4FbvRUPQb62aH2rrJmXs9nMBEN7M/9bRHI5BEUN1YRuG2u555v0Tr6MRbt2wyNNi/736tDVznaYZpVwjEmRlfAnRmDHrVUDFC55nF6hQEWRQweLIhxG41d+cAmYv+x52w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4qXqiTp5Da6ByZgze4g1JjNEzYCsyYP4c+IxgBEe2Q=;
 b=jZeISHUFBWIJb+6VlNwTDrNlHPp3VgSEil+8Cjt5egyg33As0khJWT9wfn1NkoFC0hh3SWKcGkZyWjDW6i19BDwZNyBtmOLKu1LQTCHrrcIHM3fryY9YVp/h3uDCOBNLjfk71ahBLJ5lbytbDdzn6e+ZFraJknA2vf2IsAdSNmnZ9ZIq/p/0jVfbSGXBaC/xFCfHRTtVlhBOYvCAYbvuv17+PQk3mwGwqUrpOee9bh4fXX0rxapAA/FhBgkjyOu/Y0ucYi9ajoacfKXGJ6DyF8VQhV/zsxRNOK2rSt25XoMSryVAvxJG7fpAzuK3J53FBPX9gSwcXcVj9/ZnyuXfog==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4qXqiTp5Da6ByZgze4g1JjNEzYCsyYP4c+IxgBEe2Q=;
 b=E6hF0MzToYDXMahIypz4QIBP3Gsyh8AtnOTmRL45tOkGq/303MF0S5aCu6Au94Jk1HByc7Wm8qHk1K5y6E4P5HNYB1g5KJgoi5fvUfPjTNGU5O9MByq3bmlgACc0LtMGSmY69wQkzuRxARiPGefkM3UrGX5CdEK4S47WCaZOPfo=
Received: from AM9P250CA0013.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:21c::18)
 by PA4PR08MB6143.eurprd08.prod.outlook.com (2603:10a6:102:ed::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Fri, 11 Sep
 2026 13:24:28 +0000
Received: from AM2PEPF00070CF2.eurprd02.prod.outlook.com
 (2603:10a6:20b:21c:cafe::9c) by AM9P250CA0013.outlook.office365.com
 (2603:10a6:20b:21c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 13:24:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM2PEPF00070CF2.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Fri, 11 Sep 2026 13:24:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a00rIbOuepQTCzX2JyxT/aXxQ0vJXtHt+OOZu5eWjoycBRmXVdiZof6Rg61FIPnp3GKf8A/TFzC/oM9lpntDtRnXGd4MD/2bV+oVibea4gm43EL47IDPufvKb18wSI3GLnrckohyPLZ6tjU4tnS+Q6rN87GC9dq72H7BkLhLfqlhNxz/5KfQTtMgorJyzKDO7WpNLdUoRU77tbxipCPYAShiURm23ndQuMZNSoEEO26MppRAqJ9W9xBsBUSjiRqBN1EbUanR31Pwa5y9A/O9S25h4dflTfqr6i6TaTgn2u8n72wb3LDNRqvpxDISQTVHUKI1/S+PTH6ZbaZiHekGLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4qXqiTp5Da6ByZgze4g1JjNEzYCsyYP4c+IxgBEe2Q=;
 b=IDm9HLKf1K5RJHmWDkzdDuedF7IwpVszsd0d2eFINshFOTVuAS4+/IcldRnL0QJkXtkb+TCxb1AopGCLhpK/ow2wr8bx5ej3yg5fq2h5IDPyvAsUXx2XLz0QMme3C/cAAWHs7N6YPD3DBSke9mNlayonZznnSEB4uJ0QT3V2BgBAGioanfo6Lx9AdDZny8+CssIMUXyakr980HKUECe0LqXPi8pPPOvQr33dvaMPyu52vWSwDrgq/kyGCyWBoVraQl96+oruMkHu3W6i2l5rnTHCzzZBNnAUciV/Ps4pIPrM/fDsPMne7CQevsXr7S88l63VcjiTFkYn+9B73OIbHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4qXqiTp5Da6ByZgze4g1JjNEzYCsyYP4c+IxgBEe2Q=;
 b=E6hF0MzToYDXMahIypz4QIBP3Gsyh8AtnOTmRL45tOkGq/303MF0S5aCu6Au94Jk1HByc7Wm8qHk1K5y6E4P5HNYB1g5KJgoi5fvUfPjTNGU5O9MByq3bmlgACc0LtMGSmY69wQkzuRxARiPGefkM3UrGX5CdEK4S47WCaZOPfo=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by GVXPR08MB10668.eurprd08.prod.outlook.com
 (2603:10a6:150:14a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Fri, 11 Sep
 2026 13:23:53 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0406.005; Fri, 11 Sep 2026
 13:23:53 +0000
Message-ID: <ee917807-7d75-4c51-b0b8-38d69483ab1e@arm.com>
Date: Fri, 11 Sep 2026 15:23:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: pcap: support lwIP
To: James Hilliard <james.hilliard1@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, nd <nd@arm.com>
References: <20260825-submit-lwip-pcap-v1-v1-1-d31cd4ed6923@gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260825-submit-lwip-pcap-v1-v1-1-d31cd4ed6923@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0045.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::14) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|GVXPR08MB10668:EE_|AM2PEPF00070CF2:EE_|PA4PR08MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: 888bb5c7-158a-47f4-1c59-08df10080188
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original: loYQwIBLFvb70IT6R0JGdIboelSZ48vtBI1a9HAkSxXDApUQtZDK/dK29yA1PNFDGJnkTCgMqLKX1kvI6bZ4KT4TSfiQZuF5dagTJN2H85fTtW1vV7S6mHNjJiGUMTiLTKfNHHS26lBiu2Nqzx55FdG6/CsyLNOkD51CVG/otTG3CkbJAhEvDLGFVG4FHnOyno7EKzShvRyS8UhM7KmFUrmQORTtZXsyg+A+onzRcak9uV/V6Y39GdYZn7ueaL9TYW0AYf7Rd/WzbulMit9UrEqO9hKZ+pBBSIAXNFYVfOLR6u3ZKxxdqhqvj4RezfXr/XnkQ1T0h1Hekz3gbPi+86tmSF03F357NXBS008efQrX2tIrlrbyJhSQFT7kTMkX45/ZVNveqjrZodvn61CFatuQMo+L1SMnHIun7bzHhzIwc7Hh+tysm9b6+v4uapeE2fvq/Kfu+C35nYVsLtRrU52HETtN1HiY5NSKXNngrti7kv42JucPx/ke0Y2L9KVmWVnWsZAdNvBLJuiZOjjYWWGeFI4rq2mSwrBzsLAJ52pFv00TlPAN0Zja7JyCcXIh2h/PCIetibnfle5+sHs6KAK3S74+uRlT9ADHn0+xgZhrY+0KZuB7mCERdl5farrNjXNzEwJ75cRD1Eo4M70mTcD5Q3cr6m9yWi1Oa37u59U=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: sjyz19kWBnfa4m2Mf4JlJ/Z632tnyVRKveiFyKMTKZcANcC5Vw4diefqK38MYfbvUlrV5XIUOfwc0DliAPEOmFGU0PZHK3wEo+xGRF+t1R4zCt/jbutKDmxP0PLK5eFeDraN1Kc1laB8kJqkN3nYhAu5f0OPK928kofG7TZQKWNQwriYz+29gFe5jQFFBHRjvx/mYpsqXGy6vuNS66nSNI0Ze7nd/tom17A7GAfPdks7xXovceiMq1J5c1VDeJFeFn7jsY8daw4a0NuJmrVmKuNgaPME2MVizNeT/c+6JsO4ai7x4gd5mMgyAG3tnFc1KPA9D/WyvwbpN4txWuvztQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10668
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM2PEPF00070CF2.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: eb9297c5-9df9-4921-d0a0-08df1007ec91
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|14060799003|376014|82310400026|1800799024|35042699022|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Sp/PSM1M/b+cWgfpzS/qlyY8hpZU4jJaVdeUFQ5gwNZhrN2HybI2NaFKGJjjd7RkzVpuVXmoiVMJGHij2aWUAwYKF/xT07FGCSHHIymzP5qzb22ENbcDwhOQCYXf22l7Shoer3cS8AME3/gH5TjKnqn/avd8rDG9twwp6v5PYgnmVMTogxAW3aW+dzhhl0Ulb2XDWme0FPCxz4afqGq0apibdLmK+qCHGh9jUyYbrI8ZRA7vRVJo7GnnPn1z3VXkR3BESCkAGwSWXK7SqutarRm/VisonKmabhOJPAaLbJCa62l9eRRO4yYNJY8oFud9dQkh3XXAwdNCWa21ELvXq3DlKDSeKjf3tQW9e7i5UXMI19EwHd7uUi7wxvP4+T7RYb9xUk1JNzR5SO2ejeAB/szoLULKkUKy97sbs5ZznKzL5TN9ktiEwPbQXs44ufbTu6RkopP3emwnbztzY8wqy7ED3ycidVhE9Rh9+tSy2sin6L2ZW87d/0jud75pZjmECSzAy7SKiLwFVb5Cs1ZVKNCFpxURgGJM30smPBi+3q+KLbdQgoYIbfRYGvR+y7j/fyL7sBL3OFdzB1KLH0NTkEyvgi0D2MpZhQ37EAH4QYBb8BE4CYhBNwO+F+JmbVYSu8zW8bMnPnXmxQY/f+HNXHdUaJnukBR+hej3Zps4ZD8Tg0GI6M+RkE0X4zEu+JXIFB5ZUPIBxgpvf4VOErwEfg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(14060799003)(376014)(82310400026)(1800799024)(35042699022)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tas0vD6lLchViSCWUyeBd0CVsxuw2f260x5sHcGSx6IBIPeB08YIzyVBjBTCKhUCD7gZc9EZWhDbguoSXBfuSkBh9EllWrAB1fovTYAEVTOOzkLLxI0cCW/rGm3KXRhTqT0E+Z+MPMYOx4EnROooRvh5iaJXgcFnM0G59jPBqQL4ugQ2Rx61twXpPKblP/kx3E6gwrDJAG/ihDkUwH2uE+mqYqxOlB+yxt2Jz1O968quKRbX89JYoLTGN1B7ONXzPfkevY0DbdCsbBO2A8IGI8IvhY6dIeP5ZD/ZAHmTUXNS7oObYSAxngBniqkYwOmzrTL/zPn3FRVNZ7QU74UvsWdaLF9wNscvYcvahy9/hnjQr4Q44Eg4u5kzT+1GIP6jeqaq7exVQcuk2qmHMJon/NGexbV/nA77GsbBiicw5qranxE9/eT0jkAa+r7TiQqb
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 13:24:28.0491 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 888bb5c7-158a-47f4-1c59-08df10080188
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF00070CF2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6143
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

On 25/08/2026 19:31, James Hilliard wrote:
> The packet capture command is restricted to NET_LEGACY even though the
> recorder only consumes Ethernet frames. The lwIP adapter sends and receives
> directly through Ethernet drivers, bypassing the legacy capture hooks.
> 
> Build the recorder for either network stack and add capture hooks to the
> lwIP transmit and receive paths. Print the capture summary when the
> outermost lwIP network operation stops, matching the legacy net_loop()
> behavior.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  cmd/Kconfig         | 14 +++++++-------
>  net/Makefile        |  2 +-
>  net/lwip/net-lwip.c |  8 ++++++++
>  3 files changed, 16 insertions(+), 8 deletions(-)
Applied to u-boot-net branch for-main, with minor conflicts fixed, thanks!

[1/1] net: pcap: support lwIP
      commit: b3075a8c17f1577653fc0c7f94f9c1a3bee05ade

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>


