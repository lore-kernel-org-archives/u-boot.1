Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33905C624A4
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 09:01:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C166E60B0D;
	Thu,  3 Sep 2026 09:01:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wu3BOesuuX7Z; Thu,  3 Sep 2026 09:01:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org AB805608B9
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788426089;
	b=r2CVgx3OFBu0N+yYupfVc/Fsjr5Lc+nRXoFj7kvLKhQc+Sk8IofIQQ8EFvD4WaMktNMt
	 aZuiLKYQ4duVXRLzkritO7I7iBvSrAH244ieHdEOlXP5l4vRl50PlWbANiHNCzt+GA5BU
	 qExeQrdtL670aiT0DGJ4C8kR0HAVLGTXhd7qYq4Wcv17ZSE5yR/Kod4eHHZToE82xiexE
	 0vzHbNQZOd4KdrhLk7C6DIOCIBLIJOE+rMmbJXO4bWd+qioonupdddDdAFh80U905yrfs
	 hkRdXNTfZ354AKV9u9eKyiQ2HFD0b/8YZeXP1gFG+5JTAnasm/bsCxxG3YcbepA4uhQ==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788426089;
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
	bh=i6aofk6NL8YISM4qtSLb4/JbTqLIm5Ywnu5O0dVfsao=;
	b=MhLEeGDiCDcx1skDVV6QC7fpOFxsxZHr8B3IOuClwVedp2LX/fTFEyYgYkGXBNVzNzVi
	 tzRD0ic92sWzAgCV/ZUfJvhA9zKovkPAmOkQXzHGEF8Spc2KEuaahuDUMuy40/OgLwoal
	 uUkv4o8OgP0cWHf6JvjjewfZeF/UiDczgeXtVWY4IIQfT4/riUcsM7c+lOV2W+pxq8ygT
	 ZYImEDuVVaInxy5LCHMdzi5dpkHuOknF7+7GuwvQBDfAjzGETqpFxGabC+g3ey2cYtZ11
	 WsLJuvU8vWDQurCPSU6ZbW83QSFF2ULbWkqhRBzAPrcMg/FsaxJus0VedJhZ9dFuQEg==
ARC-Authentication-Results: i=4; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788426089;
	bh=i6aofk6NL8YISM4qtSLb4/JbTqLIm5Ywnu5O0dVfsao=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lu+y+4K+9QX1+l1xjnSBES9S4G4WpEF1EmMV3Zy6+8gJrgj/9EujTG2WIoczbnhxN
	 AxarLJGFl43Lso8ZQ7KPYUMsELzdpVOu7Kx5tAB+jouBxHjPXPhF9EHTi86+8SDI/y
	 LlAf5qS+qpJ24K6sCRahav3JXO4FljJHEEB7WL2YlPidwkIjP9Xt4TxM5dVI0ckRSh
	 LeJWAueTem9WWM1qAAUnY404arlOgK343xVAqrj91kkwi7jdd6D0l1/SwvaKKlmozd
	 j9xg7oMAWNb4stHPZmKNqsBK7D2ieg1+LUVWGK/mSUvnTTna2TFOI+ZsgDcgFMd7CG
	 lOGTJEydS2uXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AB805608B9;
	Thu,  3 Sep 2026 09:01:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 83EA3118
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 09:01:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 754F040AA1
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 09:01:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 94XdN5vOgyvI for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 09:01:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4747F40AA0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c20a::7"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788426086;
 b=SujFHcdBjqRYx3PDHM0b4JIwHWyVTryBVQuEWWx9C5RRtp2xWtKEBQcaPsuomecMa3PM
 vnviJt1VIRC39/7YgYXOjEOcfdagSNifxbJ2oGyFxFRvDe1MfJ0khbj36FIY1jtJqJbsW
 BWIy9mGMcv26g4dOAu6xqIm2XqJdD3+6r9maHN22I/N2FW2E75kStqrMOSr6uluPRPkqW
 j/eNikN0+aSAfKXdgZkXDrW9lSR3elEpbtybAfRJ79BpLp/xoicPH17kVaRMHzZWsjaOT
 7hlB7ys5IT1dFykVVm14X7XcHrmIze4dHN/a+uxb8PH8782bBgwdFh/1CBRMIt+cRWQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788426086;
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
 bh=i6aofk6NL8YISM4qtSLb4/JbTqLIm5Ywnu5O0dVfsao=;
 b=XR6LTy11zZJ29lRsYRNm5FrYWkLPgvNjCTlg3E+BfVqf6xsOCPIV9CsmZYj/MfoQMB9y
 mQpgTodt8J4W51BkSoOhW1RX4JoJMa9nQE34nVuuF1/pq8INK83I6SNfU+c7MN1BjcLst
 OJurI08pO3CkiAV/jTpYfJPFnf+lyFc+5FyST5uLGY0ySHF4krqfkHclmEUjXPx3y3jWb
 Ih2TNagHBlwC9p0TDAwdwSZ8mNthoYOU5Pbi/c9gviCM10yDH76jovsYDnA00YRwOhIvd
 whJok18roskdc4CuD14cS6RnI3Muz65djONfqDFdvxbme3sJYeVsZ52VSSmH+hE95xw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=loMxYsyU; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=loMxYsyU; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=loMxYsyU; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=loMxYsyU
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4747F40AA0
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 09:01:25 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=L72K48+j0AoOJeYyp2LfxqqvXgv7Wob3GOHRa5Su5l+dXe/dXtD6ZhEXmSKQ1Hf8stzZWSZsLTKkQZi5AvcDxHcqeTga6RQxdBflzuoRGH3QKooqCTyvmcwQBH03/YKmv2ym8B5vLKkLm3xO8NbOhwayGNIpVmlJ90hKo7IYPkRKln5mmoAVGxfjbYy77PXveSB5aovxQK3o14e4cey0tR2vOr2PhgR9YTs/l3j/fgr1v0etYoBOXJSVXTT5ZNGR6fz7EABp+IfEVTfyJyH4SYlmJj1IgmQItK5izIg57MwaaFO2LNoLQDruvhOq1H7Poz7FshRO0sai7Yape0L1qQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6aofk6NL8YISM4qtSLb4/JbTqLIm5Ywnu5O0dVfsao=;
 b=rVlips1J1+6L0ujfy0KcYjr+vOPGax+OXxiXP8u5MtHpVeJPTBlta7RBf16mxtzGz5d/5YehFp0ja0hU7RBY3dHJdpG9jLFacOhEmG5kFJXJksC9at6TtVBs6RuPNXkoXl8TSiJdbxKDp3wkKGE2Odo1GmSdU9dlICH8qq5t55hIyRQTJkezvylLEDbc81Vnr4vVdjJGqldm2UCdpTQ2zLo2Oo2ZHlaM8wWlxgIWs3xVv2LruxVr/i4HQk/9Gq6PHnFYYLBj3BYpJa2nVUgAAKzOQiZE4RJ1P6hw/ciZseouYK093HIB7Mn+cftIe4DWahxOq9lXbwrp006e/CHvbg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=google.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6aofk6NL8YISM4qtSLb4/JbTqLIm5Ywnu5O0dVfsao=;
 b=loMxYsyUbLG06eYkqkjv/DHn0f5zEw/Nq20Ha0K/s9y8MCrHTeGjCFKh71frWr3oaP5o/OI4Vu/+gFI1TOk6eoOVXYYl+lQlTtX/kTjYr3dtmxy0QR42gPMdmyrS+Az7G1Nw0jfjJYvsEex5cSIkvKNuHiEnnut+EHeQiD0PFk8=
Received: from DB8PR06CA0053.eurprd06.prod.outlook.com (2603:10a6:10:120::27)
 by PA4PR08MB6030.eurprd08.prod.outlook.com (2603:10a6:102:e3::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 09:01:16 +0000
Received: from MAD0EPF000008B0.eurprd04.prod.outlook.com
 (2603:10a6:10:120:cafe::5d) by DB8PR06CA0053.outlook.office365.com
 (2603:10a6:10:120::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Thu, 3
 Sep 2026 09:01:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MAD0EPF000008B0.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Thu, 3 Sep 2026 09:01:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GT9wBZQ8+JGg96UVxju8mahetjsrUTkwzGIXI9NYX5iFRGxZYRu2rtlKX3OEtjAbCdsnYf8ZE4m2caf4/DV5qGWZ6XUsJwjKhgkGJfY8K23a7Ro/EqtLSYTAIOzwhEsy2pTlbtKq9rv1auh564Vb9WSwjfSrNFObEitZWkugW2/2Q7eu+PW41Y4gSU7a4iSfjiajCUjWNllypWUg/h/DYG8kpU+NlkN/vuHWv+0UY8Uyv3Z8Z/jOySNu6ww43xV2ATRmeFCJks9lw0J5YzWj6yjyWpjf1Jw0SuCMBmgQNq8cfzeztqy7OB0Zj2dzwFT0eEYhIQ3B97z7pXBJ+CYEmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6aofk6NL8YISM4qtSLb4/JbTqLIm5Ywnu5O0dVfsao=;
 b=amJNHQeFX9NAT09kvVAwhueoulKv5bWuQrHGfWW/XBHJZ0mVaFn1WVfEY3RHM0fU9ttOXzNGkKjK7kUtiBUAzwPiPqdB0jJg2SYLpkAEd//548lEah6KdFY4kG7Zo4Rip5xp6hwSZ7sNQSRFnopg/LJDMpFOAABlJG/gfJ3zt0iRu97NV35MkmZC5i+QEAo+SwVmYx1MXIc6qzodksl5qd3org22J4tU7k8H02hpomhdqJXs/MvSlHH9Y2/GFVlMLiNNGyXRZksi8tigLmfPACtd0rLr1l4tjiVtbga/VFbslIO236zx+jA5aj8ql5pGFQgBrq2Pt6/UzvZ+zFVwjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6aofk6NL8YISM4qtSLb4/JbTqLIm5Ywnu5O0dVfsao=;
 b=loMxYsyUbLG06eYkqkjv/DHn0f5zEw/Nq20Ha0K/s9y8MCrHTeGjCFKh71frWr3oaP5o/OI4Vu/+gFI1TOk6eoOVXYYl+lQlTtX/kTjYr3dtmxy0QR42gPMdmyrS+Az7G1Nw0jfjJYvsEex5cSIkvKNuHiEnnut+EHeQiD0PFk8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by DU0PR08MB8205.eurprd08.prod.outlook.com
 (2603:10a6:10:3b9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 09:00:35 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 09:00:35 +0000
Message-ID: <63520249-a647-47ea-bd14-c9b6a41b35f8@arm.com>
Date: Thu, 3 Sep 2026 11:00:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dhcpv6: support rapid commit dhcp6 option
To: Yuxiao Zhang <yuxiaozhang@google.com>, u-boot@lists.denx.de
Cc: Francois Berder <fberder@outlook.fr>, Johan Jonker <jbx6244@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, nd <nd@arm.com>
References: <"<53437d4c-a21d-496c-9587-c9832d76a1de@arm.com>
 <20260825175417.1068611-1-yuxiaozhang@google.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260825175417.1068611-1-yuxiaozhang@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0043.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::17) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|DU0PR08MB8205:EE_|MAD0EPF000008B0:EE_|PA4PR08MB6030:EE_
X-MS-Office365-Filtering-Correlation-Id: 96a1d7c1-5847-4a0e-efd1-08df0999e7aa
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006|10067099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info-Original: i+wNfn8SmMT09d96o+vAt7jxDhB8V24tP0J2AiLABNvDgCZATQh7xb+JravHUY0I4zfcvghwYfkK/UNjwZQVUdOZBevh/BTXuuxTu/dFx0vDAeZoXoZ/R9JP3f3M/TpWsta6b1xUWiMPSRSCRh8RhbSDID/V0CCqRhEiPjgwEBLRSu/16oHV1kIvFq8AbMAF+XDdwON2clv3uPOh6R5dUs+GssVNhO3KESd6CbFBnK0jQBKeV2iJipfYnmWnEkJq/Z5EFTMHVFZ2sdebOJjWDHim5PtcR9hScokQgmCICCjLW2SSpqmhJL35JgddISQbqLA9FyX3qK4ozSCul+l3R11XpR+pVf8SYKUgUt9Sz4zEsP0YRKf4CzZBSPZibRA6bOdP1KVPJuJ6kIpPSAI/ijxXFmG7bkZGUlfW9Wrrw3jCzpR3xgUGFEy/EDcTM0TlqWwUtzy//MUzLY011Vr30RjNhzHQrGvdhrAYZAWVtdNP+KuPIVNgkxoRcF+1J9fvz20kWq4R8eu3m7O7NpG2bPim52RsHsJKKDrPADPSCXp4NrsEgyjlQdWb5uPHqfvEIbdbBLUApsygkGkACW6syJUUkrHhbb1gik7ONpVOCNpVeJqkSpT3YSmfmJwi9zt1PxdkWKNwQfV7mYpY5MSzS4L9k8DRJGWT2GHcKSLP/YA=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(10067099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: QXCm53luQosZZgkdvy3qG+8boG9c/oc0Z7h0qs0uspGJut9knxgvL4eX1bW96P20Sv3KumuQN3Xi5KFtHBYegDHsDqA8bPWLRkHBE6snZ9i/dmeyHKdWqZ4j6szLO+9F1CbR2/gkepK9gHIPbLo4xNhM9B5RBamRbxvM4EvKoB0PEKwLF5DJlIE5oH6U72fBc1pPJf/+IPfH6+IUzaFSepqyaCvLcx3Bfgi+L8WltKpE5djaTyj0+dSA88krM0B/NupfoBPDOKeJ9MBc5VvjEEmG0BJvKNQNMbuMYpDHtdK4PNNrRRQXj42BTLVV8/ecSj5wzCmJDsrwZ8AJNxXOpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8205
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MAD0EPF000008B0.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6678d45b-24b3-46b3-9f0e-08df0999d145
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|32650700020|36860700016|82310400026|35042699022|1800799024|14060799003|23010399003|4143699003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dRYMCskI2avicEcQ9pFNnYRfG3jgOBxGWM57PULvMDtawAx1rMTvO8mJWul6Kn3zxmkbPkiEetdjX8fCYhPCNUdsaVwH0o08WG4rhUUvTMao0EmSM19aW8PlidrLHKS535/KVCpEcMuefIkXhVzXUYypZlLcDDChf9uVD27x069KfBGiRGZVezoWKjIEOsmGE/lTPTs++Y5laMCL9wdRBFYCWctg24TLfp4iEKGfv31LiCXZvaigoQHrWAPrA5AJp+qARaSxK2lUx+wNtuyNKpNW48iLXhRDuAOLxK47q9ZzH29BAS1VFxzd9F8O84sr9N8uhc6sftj7TXt+FHhhQSOOMPuAQ9hp/Rua1x/z7q6kX1QYnDsE2bFfuiDnGis/BHLlGwmLd+SO6E8VYjnki8DgfvabCxW2+WaWYGplJudLd96rEIYsE2wR97CLhsXBqi3oWtdjmZwTi24naVTpk/KjNUeiIR0oYwgjcZ60I+/TF5tnkU+JSzNAsUPOkJS0gB+0Ypz1RwepslyRha64sF+OsTsQXSR5YAfEO+hQQ1f2VzblGmnLkU3Hc9CmIZJrniVLubo0Z8FaNdfPB+74hr8PyQHUH4hZGhiarpU6aNrJIv0SES1Lbvjeze7ioQfQVvyRYuBPTnEe0CSISHc4npbuUGKzLdAMiyefbruFmok=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(32650700020)(36860700016)(82310400026)(35042699022)(1800799024)(14060799003)(23010399003)(4143699003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: y3Cyc+SD68MgoHfzHuj/w538K4RaSPXRNci98gwkqXSuooDqRySGHqcFEeoSCAqTKZHcm+kFxNpexKyoNfndieHu70f0TiIRguTNLW/g6jQhzIZzWjaj4jwRoIo7gZf9kdpvV0EEbdBd25P5cc69oZqAoCflooXKiq5ujCwPHjwskJuhSzw24gPXLQ8WsBW3pK5S0rW/Hz/onBrOKpNVi4pDBHwgJGnpM/2RlLQeZf/XzMghKMgEM2jGQYoO4lPEL0n/3kJ3m6SwAtHP5e5s0RlggR61Uf0il4of5/l6J9vSTDHcQISLdLp4JcSiQ5xbaIi8InjncMK+9RB4eihUDW6NSaqMumeU1cJjWQQohrMTx4DloEVdzFCdFtxCqFVuTXsu1Qwbhz19Ion8c011SkfKVwUd/sYyWP08SAxwINsYYdl6KRTSIc7M+pDNrDzG
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 09:01:12.9461 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a1d7c1-5847-4a0e-efd1-08df0999e7aa
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008B0.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6030
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

On 25/08/2026 19:53, Yuxiao Zhang wrote:
> Support rapid commit option code 14 which bypass the advertise and
> request state. The option is enabled by DHCP6_RAPID_COMMIT.
> 
> Signed-off-by: Yuxiao Zhang <yuxiaozhang@google.com>
> ---
> 
> Changes in v2:
> - Reject rapid commit option if option_len != 0
> - Drop redundant NULL check on dhcp6_hdr
> 
>  cmd/Kconfig  |  8 ++++++++
>  net/dhcpv6.c | 43 ++++++++++++++++++++++++++++++++++++-------
>  net/dhcpv6.h |  2 ++
>  3 files changed, 46 insertions(+), 7 deletions(-)
> 
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index ff90a87024c..b3cf3a6d8b6 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1996,6 +1996,14 @@ config DHCP6_ENTERPRISE_ID
>  	int "Enterprise ID to send in DHCPv6 Vendor Class Option"
>  	default 0
>  
> +config DHCP6_RAPID_COMMIT
> +	bool "Request Rapid Commit (2-message exchange) from DHCPv6 server"
> +	default n
> +	help
> +	  Request the Rapid Commit option (option 14) in DHCPv6 Solicit
> +	  messages to enable a 2-message exchange (Solicit-Reply) rather
> +	  than the default 4-message exchange.
> +
>  endif
>  
>  config BOOTP_MAY_FAIL
> diff --git a/net/dhcpv6.c b/net/dhcpv6.c
> index 640f089a2e1..5ed8449edb5 100644
> --- a/net/dhcpv6.c
> +++ b/net/dhcpv6.c
> @@ -115,6 +115,9 @@ static int dhcp6_add_option(int option_id, uchar *pkt)
>  
>  		opt_len = sizeof(struct dhcp6_option_ia_na);
>  		break;
> +	case DHCP6_OPTION_RAPID_COMMIT:
> +		opt_len = 0;
> +		break;
>  	case DHCP6_OPTION_ORO:
>  		oro_opt = (struct dhcp6_option_oro *)dhcp_option_start;
>  		oro_opt->req_option_code[num_oro++] = htons(DHCP6_OPTION_OPT_BOOTFILE_URL);
> @@ -194,6 +197,8 @@ static void dhcp6_send_solicit_packet(void)
>  	pkt += dhcp6_add_option(DHCP6_OPTION_ELAPSED_TIME, pkt);
>  	pkt += dhcp6_add_option(DHCP6_OPTION_IA_NA, pkt);
>  	pkt += dhcp6_add_option(DHCP6_OPTION_ORO, pkt);
> +	if (IS_ENABLED(CONFIG_DHCP6_RAPID_COMMIT))
> +		pkt += dhcp6_add_option(DHCP6_OPTION_RAPID_COMMIT, pkt);
>  	if (CONFIG_DHCP_PXE_CLIENTARCH != 0xFF)
>  		pkt += dhcp6_add_option(DHCP6_OPTION_CLIENT_ARCH_TYPE, pkt);
>  	pkt += dhcp6_add_option(DHCP6_OPTION_VENDOR_CLASS, pkt);
> @@ -448,6 +453,16 @@ static void dhcp6_parse_options(uchar *rx_pkt, unsigned int len)
>  			}
>  			sm_params.rx_status.preference = *option_ptr;
>  			break;
> +		case DHCP6_OPTION_RAPID_COMMIT:
> +			if (option_len != 0) {
> +				debug("Invalid rapid commit option length\n");
> +				break;
> +			}
> +			if (IS_ENABLED(CONFIG_DHCP6_RAPID_COMMIT)) {
> +				debug("DHCP6_OPTION_RAPID_COMMIT FOUND\n");
> +				sm_params.rx_status.rapid_commit_found = true;
> +			}
> +			break;
>  		default:
>  			debug("Unknown Option ID: %d, skipping parsing\n",
>  			      ntohs(option_hdr->option_id));
> @@ -618,14 +633,28 @@ static void dhcp6_state_machine(bool timeout, uchar *rx_pkt, unsigned int len)
>  		break;
>  	case DHCP6_SOLICIT:
>  		if (!timeout) {
> -			/* check the rx packet and determine if we can transition to next
> -			 * state.
> -			 */
> -			if (dhcp6_check_advertise_packet(rx_pkt, len))
> -				return;
> +			struct dhcp6_hdr *dhcp6_hdr = (struct dhcp6_hdr *)rx_pkt;
> +
> +			if (IS_ENABLED(CONFIG_DHCP6_RAPID_COMMIT) &&
> +			    dhcp6_hdr->msg_type == DHCP6_MSG_REPLY) {
> +				if (dhcp6_check_reply_packet(rx_pkt, len))
> +					return;
> +				if (!sm_params.rx_status.rapid_commit_found) {
> +					debug("[DHCPv6] REPLY received without Rapid Commit option, ignoring\n");
> +					return;
> +				}

dhcp6_check_reply_packet() calls dhcp6_parse_options(), which has side
effects such as updating the bootfile information. I think the Rapid Commit check
needs to happen before applying the other reply options.

> +				debug("REPLY (Rapid Commit) good, transition to DONE\n");
> +				sm_params.next_state = DHCP6_DONE;
> +			} else {
> +				/* check the rx packet and determine if we can transition to next
> +				 * state.
> +				 */
> +				if (dhcp6_check_advertise_packet(rx_pkt, len))
> +					return;
>  
> -			debug("ADVERTISE good, transition to REQUEST\n");
> -			sm_params.next_state = DHCP6_REQUEST;
> +				debug("ADVERTISE good, transition to REQUEST\n");
> +				sm_params.next_state = DHCP6_REQUEST;
> +			}
>  		} else if (sm_params.retry_cnt == 1)  {
>  			/* If a server UID was received in the first SOLICIT period
>  			 * transition to REQUEST
> diff --git a/net/dhcpv6.h b/net/dhcpv6.h
> index d41a3c30615..49f20390730 100644
> --- a/net/dhcpv6.h
> +++ b/net/dhcpv6.h
> @@ -24,6 +24,7 @@
>  #define DHCP6_OPTION_PREFERENCE		7
>  #define DHCP6_OPTION_ELAPSED_TIME	8
>  #define DHCP6_OPTION_STATUS_CODE	13
> +#define DHCP6_OPTION_RAPID_COMMIT	14
>  #define DHCP6_OPTION_OPT_BOOTFILE_URL	59
>  #define DHCP6_OPTION_OPT_BOOTFILE_PARAM	60
>  #define DHCP6_OPTION_SOL_MAX_RT		82
> @@ -152,6 +153,7 @@ struct dhcp6_rx_pkt_status {
>  	enum dhcp6_status	ia_status_code;
>  	enum dhcp6_status	status_code;
>  	u8			preference;
> +	bool			rapid_commit_found;
>  };
>  
>  /**
> ---
> base-commit: 527115ef6783cec49e5610c523c124b399011361
> branch: main
> 

Thanks,
-- 
Jerome
