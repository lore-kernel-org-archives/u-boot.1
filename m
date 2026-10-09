Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54973CA601E
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 13:42:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8A40340911;
	Fri,  9 Oct 2026 13:42:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X_FpTIlfb7UL; Fri,  9 Oct 2026 13:42:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7177940917
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791553328;
	b=EH3RQylCad3++rLEZ0QB0DKfviwB7KoqImlGv8cpX7YWfTUCXPcypV+4WiaJE3ctLJbO
	 jwdnbiGfCMvgOuIosWxLiT4gnuRdKu9kmCbQWlR9V+H00bfGf+G0qZw34TEML4JsWVwv/
	 h1tXPwfGUHwlOXBUXDe4CbFWeken9zNguZp7A0Y5hM5LDUCafu1lhFlVfX5vCA4TLKOsZ
	 v2v7B896NqXQFH+zqUv3LOmC/DUC9EiezK6Zk+VtoOrRxTSuo1q5YoIYXkiNjr+kmWoWT
	 hxHiIczPOUtykZGqTOs8i40uuZddrBHuXSI6032SLqcnSwKz3STL2LKIIfVK37hbTPA==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791553328;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=y7W/WWQT++4GsJeHBt5xa/MPrgQsErwQ8TR9Yg5OrDk=;
	b=TWIRbIkSV5ZEWrLAVoK0Y0xG0Mvfelme6wkwuaROhnR1Ftq/01nMi3/DpE5F0+XT8Xpr
	 kuziz4CUxkIfWVHgV59WakhPcb/pme9i+AFWj03epOr5cxZpTX2uh5F3yt4qRLozqJkdK
	 DqdylHjmv+ZJbTbCRbZ0WghMOsXFNXFy23O2keeR+77KD4P0NO1MVkf0MsyOP+Ja4bYYs
	 +8mMPVHm4DrOiAfGauMhcfgneMcY3r2T00xeu5l+IGoEs4W7p6ixB4xP0ObtrwM8Qxlqq
	 T9ceO8tP8slMDwny5NR9SQrPrDgMTPaniPWS5wqIcxxrfAUzOg44MlGz4kIFdOqlv+w==
ARC-Authentication-Results: i=4; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791553328;
	bh=y7W/WWQT++4GsJeHBt5xa/MPrgQsErwQ8TR9Yg5OrDk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pYMW9PeXPOKc1oQXSzHAF25OrWIp89B9Qm8f3Qzse36Fmz0JxwETb30bR8WwfR9ni
	 2VP1tvJoqmlteD0tD9iRTYDuXi/RCHCA/IEBylryH5gtGmS78kH1H8KJnPmUG0+R7B
	 DlLE+VFHy8vIWoUuJ4Cm0AGFBLUOVs5n8azwm+IKr15VBjxiMUOFlDuhQ9FpeOmrfD
	 1naqua0g3o9O8OwT1F6+zhkLua72qbjGHuebJtRmglFgSDyEVBzUWNCJFt/bZrLnJI
	 lhEbSrU/Lid5Ce6PW6czu6biVP+jxGUnYTY+aZN/uiOb34LaGMbnzLSjgGwDKOnIex
	 x7ec99Ebmn29Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7177940917;
	Fri,  9 Oct 2026 13:42:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 71D70184
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 11:08:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6377C60683
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 11:08:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 44oGZNT3-i1H for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 11:08:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4A56860680
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c200::3"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791544132;
 b=cc2pOo0xro1YOxMDIdwct33XJyvt6yoGiDczOZ3TXOMfEk0gl1ccyfSRz/YcdDjIU5FN
 OrDq2pxdX7AQdl5VBrTv8GDVhfD+LitcCmbp/lZwu/bj7Kw1YAUpxUngtrb+SLAQ1dDlu
 A5FcU8Q5jfplps2f3QEBDgbAznIoXiX20rymwBNqO5zsGwr3sLORu0jznrk28xau59dqS
 VFFtuwy8wvbiub56npmMjlymwjjo2gr1U/ieRsAlYUx9WGtcCZD3Dn9DNJWe9XQkokrIK
 BUljgOiDR0rwHfngwjVYELuADjmekUoxnwQxu8bHQMd98fpy6Q/URGkZQDMQ0vMgfew==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791544132;
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
 bh=y7W/WWQT++4GsJeHBt5xa/MPrgQsErwQ8TR9Yg5OrDk=;
 b=e0Ev4xoFMGhYvJHeqk0mbbd4a+t3LZaZlUXJsMfUX/dHjTEsDt7vTzH+KXREYNUHAh9V
 VTZQ0bNGKDN7so2oja1GPLgs5e2ZliKBwJRT9O35iHXe/rLgctuRmwdqD4TRgGaWVxvSI
 nO86uexX7jedIwLk2a6lkPMSyjQI01xnKUjHXZE+MuhjjoAaJI+NAu3/QlAdMYHOAm451
 +3IRkW6TGRWAHqGq6froSOADUgvRSEnEgEIhIegPfnhdX1RMbBXLaai1yz9NwAUF3LdAJ
 yBdCtY6F+J81mZ2mfTkZ4HfCVN7sjGBUK4x23qK+nkPgnygMhN+GOEzU7FDdChXUR9Q==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=CXKl0k+I; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=CXKl0k+I; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=harsimransingh.tungal@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=CXKl0k+I; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=CXKl0k+I
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4A56860680
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 11:08:49 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=bsnXMhyHEed08t5kNiPu0gUSMWQar6Iph2xRZ9rjFMg1zV/K3oOFje2ws2HnVnrtLSfI35/ztJWUPwZ58ImS6WgaCmzTb3VMO/bw4B0fvgw1sa4X3Pu+xwASaea/EsnxbXq2467/89cUKZDH0Eh7AhKjderIRvDzIbDVrCUev9RYJeSTuPejKNyjQmm7gu4RB0m40D0PI6QwJKXxVqxu2X5pxUWD2HLtNtZEv6tFbMn96AiKoYF5ijv1v6CF4Mq4rdY5y474FMyk1OTSvPxNXfHTvzFuHH1x80DrOxLHQSVLKoGbnW36wv0dEloGkeqHw0D4twL4fx4+uj734TtqgQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7W/WWQT++4GsJeHBt5xa/MPrgQsErwQ8TR9Yg5OrDk=;
 b=CAn0P0S2rywtGm7oeGWcdqwj99AbOSG8EYp3ZbdRbBH7ztor7uw8djAQwxzWsfjhb3dUNUCHiH7BkqugG3gOjTrZdiMcN/otDPyaM5JSRFOpjr+tM8nfn6o6ReurKcTv2+1ZROnnXoLt1UeuVskW9SHEm95lZUZZxMRxDPXKs/J8VUM6DKEmQkcUAHwGRiYiIir314IsK3VMSZKAeXpncBhxfXT+xVSK2/x0g2bGWnufG+On0858O9T+vZOmogBUA/ztRMpK0btgr6vPw6HbHympLy2JVi0ayAT4tvhVS2EkVM4ZZ1SwNsdJvB7RbB1Zr7X8YZJnPBMj8xVpVHnNlQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7W/WWQT++4GsJeHBt5xa/MPrgQsErwQ8TR9Yg5OrDk=;
 b=CXKl0k+IZRuUf6M7FvJHL6sJXXNz2YQIQvwH0fIiS/Z1MUKVZmNWTtjZ5DfJq89lEH7C3DJZyZ9rS49gBeINp+ciz9G8xtv4BoaFo4J3Xf1Zpv7gUG8v/gc7u5azXVboa3tVJlO7H+c8k7TCaqhcjm5EzhVnHw2ov9SeUenBNzM=
Received: from PA7P264CA0307.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:395::9)
 by VI0PR08MB11710.eurprd08.prod.outlook.com (2603:10a6:800:325::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.13; Fri, 9 Oct
 2026 11:08:40 +0000
Received: from MI3PEPF0000855B.eurprd05.prod.outlook.com
 (2603:10a6:102:395:cafe::75) by PA7P264CA0307.outlook.office365.com
 (2603:10a6:102:395::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 11:08:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF0000855B.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Fri, 9 Oct 2026 11:08:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rjS6f/ufIRTodWpJGSW9OjkQHMwf6qqpmG8+PU2n0fOtkwanQ5lns0VQ55EThaBu0EA2XjrYhlawWEBcn2ANSwgZIa76zOhrNknLvMNibgxuttSK8YXn0t0y382vRvmn9emfa4sWKD6x6s8h2NtxpeVJJUVcGY5VVU32WxPbSir6A8L7dtFgWulkh78oupX8PKfGXmgk9LN+vzzkXvwyp8JBDHtWRSEQFseJ5XMsyOy3zSm+xxPOwVAqTZNubeLgb/brxLR4HseLMc+at6Ny70rV7DNLB4X0EdYRelb0sH34sPCgXH6/qWQeN79yvTeYtYHaviyF50VdkRxyGad8QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7W/WWQT++4GsJeHBt5xa/MPrgQsErwQ8TR9Yg5OrDk=;
 b=NqdaqTn1EQjtnGhgJJc4JIaHqD90l28PrHs978jA9C9ShMkRNDe+xOQlGD/8zW84YDsU2C6g6BLaf7eX2JQbOnyAgkHRG6FvAuhW6FcScyANJa/Sp6DduLwquCeZ5lgSIZ3I9GvjWXpJU8D8a0oqFcuktLKCLay4sDOC6DYvln39QQ3wxFNPaq5XgXlX8EPHwSGQKFKNMIPU4Sqh39FqISdrSMKOJ7OhwpXt4W2eg7N/yWfeBDKxlhs8jflKofDrwCOMDscFDizvZjBo2blT2TL/abiBvrgr6J3t17mPllVTbuoKkzSr/QBPFd1rEer9eziZukd9i5jbAhJX9VsMIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7W/WWQT++4GsJeHBt5xa/MPrgQsErwQ8TR9Yg5OrDk=;
 b=CXKl0k+IZRuUf6M7FvJHL6sJXXNz2YQIQvwH0fIiS/Z1MUKVZmNWTtjZ5DfJq89lEH7C3DJZyZ9rS49gBeINp+ciz9G8xtv4BoaFo4J3Xf1Zpv7gUG8v/gc7u5azXVboa3tVJlO7H+c8k7TCaqhcjm5EzhVnHw2ov9SeUenBNzM=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM8PR08MB5620.eurprd08.prod.outlook.com (2603:10a6:20b:1c6::23)
 by DU0PR08MB9462.eurprd08.prod.outlook.com (2603:10a6:10:42e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Fri, 9 Oct
 2026 11:08:06 +0000
Received: from AM8PR08MB5620.eurprd08.prod.outlook.com
 ([fe80::618d:6218:6962:17ad]) by AM8PR08MB5620.eurprd08.prod.outlook.com
 ([fe80::618d:6218:6962:17ad%6]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 11:08:06 +0000
Message-ID: <8a6f0286-c599-40f0-b113-1621498d2357@arm.com>
Date: Fri, 9 Oct 2026 12:08:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/22] efi_loader: enable TEE runtime SetVariable()
 over FF-A
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Devaraj Ranganna <Devaraj.Ranganna@arm.com>
References: <20260914110106.1974894-1-harsimransingh.tungal@arm.com>
 <20260914110106.1974894-14-harsimransingh.tungal@arm.com>
 <DLINF8X5LGMM.22DVNGKNPMAM8@linaro.org>
 <eca5e6ca-ef4a-4e20-9255-f7d20ebe0788@arm.com>
 <CAC_iWj+VHR_vGb8EYqR7tzLXihZLW586BjnjPsKswf9uDnngEw@mail.gmail.com>
 <55e2793e-33fe-43da-a509-8e64aed0c432@arm.com>
 <CAC_iWjKRo7Dm4f7FmMi15fELP9_A5XYmMmBtQN8q8qBFs1e+Sg@mail.gmail.com>
Content-Language: en-GB
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
In-Reply-To: <CAC_iWjKRo7Dm4f7FmMi15fELP9_A5XYmMmBtQN8q8qBFs1e+Sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PR1P264CA0042.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cb::7) To AM8PR08MB5620.eurprd08.prod.outlook.com
 (2603:10a6:20b:1c6::23)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM8PR08MB5620:EE_|DU0PR08MB9462:EE_|MI3PEPF0000855B:EE_|VI0PR08MB11710:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aedac5b-da30-4fa9-e6f8-08df25f5ac55
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|3023799007|11063799006|4143699003|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: PzrXXF+B1bMSl/pACURUVg58EvKr4HEFjvfAqwrfkeMjkpBe8AOImTDdEuVKXQs6tAsSupIXYuWYXumBK+dvipi/36hTJ0nTHIkNHSLUfZ/WT29uUkD1KoyhWz75w4Glso7Jc9gLI/dYZ8oFaI4rkSwMR2Tvubi1IRaKU/RPLBUtWlah7V42gRjHGs07NcTlN/OYf7++JreRsFG6j0E4s9OAE9bNReXMRUK0mZrt0C36+WBKux8G31RAXD+zov6o6vHXuI4fcKPklzVzeT3WOqwkg3F19LHQlJwQejwrDogIKm+Rd884IpbrF8liaND0se5B8LOesQJsHLm1a7O7OP0Mx4xq2/cIGyOpK8d6A1NyVBxQ1hCKW/aX8+9I/HAwvsjSE4UhgSbDnJkWt+fjhhCcGrUoWansF/ynu1Ypcr8Y8eUeNt+YfJ0nH7N/9n1C6Um/hB8LystxymFyy6bPTSto9R6IMq8QsJL1IVYlyu8nL4RChLsg8GlkRZ5YA4VeMuMXB1ExV+n6S3MCBps8NconGmdZnamDXx4UnPBr6YS0VnCgOvN7RvgRa2iIz5VFmbo6y1pm12U4P00DTbX4r5OnLwBzxhxtqeWhzWkDwxhXAtjK0hHaHRZ0zLqCbtP/jKihJCq6voMjR2re4/dSTadap8EXkbFWRuoD5LSZqqw=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM8PR08MB5620.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(3023799007)(11063799006)(4143699003)(6133799003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: P86NJFVQBpTprr4WR+HM0OsJsSLpUGxqOW0nnpqL1bkQ1HQ97S06WLMzXr9yQ5ZJwcLg5F9gbnf8XVE5Q67AB/jSSnJh/mzjo6vT0xEBPCrSCGzV50lja/cLYncgc2F6Y+TyaBMBdjzSX7OeDSmxlCXO1vHw8qD/QWmV8G689Mn8lqc+w2333coM+BJRd/ZBogoZpKxVQKE1vqFa/OYVmPWl5Y1KvMRuZc5l4Fr7duCV7+RiCgciv1PKYfguctlgbcSNZGezpxUVoHZaMR6XwvNiv1SI8uYdrhyIYkK/59gVDvnAGeWmB3JXTSeu6PtEjF+6/0SqEvdbab4zcX5xCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9462
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF0000855B.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8e39ce17-d604-452d-1152-08df25f596a1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|36860700016|82310400026|1800799024|23010399003|14060799003|376014|10067099003|6133799003|11063799006|4143699003|56012099006|3023799007|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: i62SGckHZi8KonCmdvo3d/Ula9TlC6uxsLhe7T6JpprzNfopqLW8C+su42JnQ+jHPIiOFZPKY9VkqJmrhW1Quw5YKswcydIdw9zVxwIXHWtSEWrXNqJeoULILIsdJ+9YRetiPlio0rGoKG4m93z8P9K+D+UBlTEj/fDfr5tPEXPFjwS/sOgdO/FPAsbX/NxNblANSgYcUlfIe9TfRiwXGFqVP6ABrnRF53448OHMEpePoeZ4D8+iQeT8UohCF854TnylI+jE5oJfeN0ld3lpr3y4CJcORf7c5PWI8wp9j26T4bS9xqk6GG8A18WOrVyTRbg8cIQgO4L3H/KbxgL6RmoUh5+n5VAE/vQHhgvEgcr7HLH+xSqjCao3BnIZ2Bpay2FLVwcwrFu/H+jRYgMNuwV80sYw9P2D9gtnFSktErZCQePR4OL9Hu2krqW3lKPpFT+NxDmKsEIENj9wjvxfqeQzULegGIXy0rLhP1rRqZARwPF/Tq1Og6RRiJ7Jdhyu+pAXZQ63GCDOnGmR9iaSO1yX+ol6JDMLcX9G2qPDgHLXks+zGCfGO1laFuucMZZ0am5XtJ8qOLXmra8LPV2cCP243d3n2swXJwdGdiGdlmVaB7RvfuTpjjs/TYEIRLq8NdY4du+8qzHxFu2hrk04C50Qdi/q5/27PmQjMLM5xv2NNl5xlYPmUHKPpC3lk/XzMiI3ocyE5p6riwjcSaS8dQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(36860700016)(82310400026)(1800799024)(23010399003)(14060799003)(376014)(10067099003)(6133799003)(11063799006)(4143699003)(56012099006)(3023799007)(18002099003)(22082099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bp6tGC5HogdNUSjD+lUPD7DwLkQcl4cT+K4A7BNSfA7wjui/XFbglKhod95NwDQZOP7lBeILPT0FdvLWA+ywdFsQV36lAGvSlewD3ol0gSC8nAxWtlMyDMz2xuv8O+YfCwv0bVYpea2m01+YunDIhEw6oFnYnPY8Y8NMxYUch7Yx66KcN1nsRNaunszpMwOUvD4niTjAUY5Md1Rp0EHY9uEjGV/T85f8Qi1hHH2wle8bQ0oAYQ61qDVSyICwq3DkXJgcMS0h9D8qlXPI9FylE34gJU2XJptqfG1V7pyEUVGc+P9YmnOksOFBhJtE3DRECDTvnVIaYhAw11HpKld+j3WagooLh/EG8Vg5qsehB5XLvi47kvYDkJqMfBk5L+ROwmfE9wdH1POgv68QDmhuOz3RjIx30Hmd6pL8EZNTAonuExwN+ZDWSge6x2kXVEhk
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 11:08:39.6637 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aedac5b-da30-4fa9-e6f8-08df25f5ac55
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF0000855B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11710
X-Mailman-Approved-At: Fri, 09 Oct 2026 13:42:07 +0000
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



On 09/10/2026 09:19, Ilias Apalodimas wrote:
> [...]
>
>>>>>>  /**
>>>>>> @@ -1129,7 +1262,7 @@ void efi_variables_boot_exit_notify(void)
>>>>>>      efi_runtime_services.get_variable =3D efi_get_variable_runtime;
>>>>>>      efi_runtime_services.get_next_variable_name =3D
>>>>>>                      efi_get_next_variable_name_runtime;
>>>>>
>>>>>
>>>>> All the get_variable*() calls used to point to the function from efi_=
var_common.c.
>>>>> By changing this you are breaking the runtime case for OP-TEE since n=
ow we will get
>>>>> EFI_OUT_OF_RESOURCES.
>>>>> There's no easy way to fix this at runtime. For OP-TEE the kernel mig=
ht replace this call
>>>>> with an internal OP-TEE call if it's part of the firmware and announc=
es it can provide
>>>>> EFI runtime services. However, the default uuse case, which we don't =
support SetVariable
>>>>> at runtime only needs to keep working.
>>>>>
>>>>> I'll post a script next week so you can replicate and test this in QE=
MU with OP-TEE etc.
>>>>>
>>>>> Cheers
>>>>> /Ilias
>>>>>
>>>> Hi Ilias,
>>>> Can you please share the script, so that I can replicate and test this
>>>> in QEMU with OP-TEE?
>>>
>>> https://github.com/apalos/efi_optee_variables
>>>
>>> make run-fip should give you a QEMU command line. You just have to add
>>> an OS image to test.
>>>
>>> Cheers
>>> /Ilias
>>>>
>>
>> Hi Ilias,
>>
>> Thank you for sharing the repository and instructions.
>> I tried the OP-TEE/non-FF-A QEMU setup from your repository and it
>> exposed a regression in my current series.
>>
>> With CONFIG_EFI_MM_COMM_TEE=3Dy and CONFIG_ARM_FFA_RT_MODE=3Dn, Linux hi=
t
>> an EFI runtime paging fault when booted through U-Boot EFI. The reason
>> was that TEE ExitBootServices() path only installed runtime variable
>> callbacks inside the CONFIG_ARM_FFA_RT_MODE path. That kept the FF-A
>> case working, but it accidentally stopped the non-FF-A OP-TEE case from
>> switching to the existing cached-variable runtime callbacks.
>>
>> I tested a fix by keeping the FF-A/MM runtime callbacks only for
>> CONFIG_ARM_FFA_RT_MODE=3Dy, and using the common cached-variable runtime
>> callbacks when CONFIG_ARM_FFA_RT_MODE=3Dn. To make that clean, I plan to
>> add a small separate commit which moves the common runtime
>> QueryVariableInfo() and SetVariable() helpers, plus their shared
>> SetVariable() validation helper, from efi_variable.c into
>> efi_var_common.c.
>
> I am not sure I understand the plan. efi_var_common.c already has
> callback for the above, it calls the _int variable for each service.
>
> Thanks
> /Ilias

Hi Ilias,
Thanks, I rechecked the pre-FF-A runtime TEE code and I understand the
confusion now.







Before the FF-A runtime changes, efi_variable_tee.c already had local
runtime callbacks for QueryVariableInfo() and SetVariable(), and both
returned EFI_UNSUPPORTED as follows:

      static efi_status_t __efi_runtime EFIAPI
      efi_query_variable_info_runtime(u32 attributes,
                                      u64 *max_variable_storage_size,
                                      u64 *remain_variable_storage_size,
                                      u64 *max_variable_size)
      {
              return EFI_UNSUPPORTED;
      }

      static efi_status_t __efi_runtime EFIAPI
      efi_set_variable_runtime(u16 *variable_name,
                               const efi_guid_t *guid,
                               u32 attributes, efi_uintn_t data_size,
                               const void *data)
      {
              return EFI_UNSUPPORTED;
      }

The common callbacks from efi_var_common.c covered GetVariable() and
GetNextVariableName().

The regression was introduced because this series only installed and
renamed the TEE runtime callbacks when CONFIG_ARM_FFA_RT_MODE was
enabled. That made the FF-A case work, but it skipped the previous
OP-TEE/non-FF-A runtime callback setup.

I am planning to restore the pre-FF-A TEE behavior when
CONFIG_ARM_FFA_RT_MODE=3Dn, and only switch to the new MM/FF-A callbacks
when CONFIG_ARM_FFA_RT_MODE=3Dy. The relevant part now looks like below
along redefining efi_query_variable_info_runtime() and
efi_set_variable_runtime() as before in efi_variable_tee.c returning
EFI_UNSUPPORTED:

      if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)) {
              efi_runtime_services.query_variable_info =3D
                              efi_query_variable_info_int_runtime;
              efi_runtime_services.get_variable =3D
efi_get_variable_int_runtime;
              efi_runtime_services.get_next_variable_name =3D
                              efi_get_next_variable_name_int_runtime;
              efi_runtime_services.set_variable =3D
efi_set_variable_int_runtime;
      } else {
              efi_runtime_services.query_variable_info =3D
                              efi_query_variable_info_runtime;
              efi_runtime_services.get_variable =3D efi_get_variable_runtim=
e;
              efi_runtime_services.get_next_variable_name =3D
                              efi_get_next_variable_name_runtime;
              efi_runtime_services.set_variable =3D efi_set_variable_runtim=
e;
      }
      efi_update_table_header_crc32(&efi_runtime_services.hdr);

With this, the OP-TEE/non-FF-A case uses the same callbacks as before
the FF-A runtime changes. I tested it with your QEMU OP-TEE setup and it
looks fine to me.

Does this approach make sense to you?


>> Then, efi_variable_tee.c can select either the common
>> cached-variable runtime handlers for OP-TEE/non-FF-A, or the new MM/FF-A
>> runtime handlers for FF-A runtime mode.
>>
>> With that change, the same QEMU setup boots Linux through bootefi and a
>> small initramfs, /sys/firmware/efi is present, and efivarfs mounts
>> successfully.
>>
>> Does this direction look reasonable to you?
>>
>> Regards,
>> Harsimran Singh Tungal
>>>> Thanks
>>>> Harsimran Singh Tungal
>>>>>> -    efi_runtime_services.set_variable =3D efi_set_variable_runtime;
>>>>>> +    efi_runtime_services.set_variable =3D efi_set_variable_int_runt=
ime;
>>>>>>      efi_update_table_header_crc32(&efi_runtime_services.hdr);
>>>>>>
>>>>>>      /* Record that ExitBootServices() has been called */
>>>>>
>>>>
>>>> IMPORTANT NOTICE: The contents of this email and any attachments are c=
onfidential and may also be privileged. If you are not the intended recipie=
nt, please notify the sender immediately and do not disclose the contents t=
o any other person, use it for any purpose, or store or copy the informatio=
n in any medium. Thank you.
>>
>> IMPORTANT NOTICE: The contents of this email and any attachments are con=
fidential and may also be privileged. If you are not the intended recipient=
, please notify the sender immediately and do not disclose the contents to =
any other person, use it for any purpose, or store or copy the information =
in any medium. Thank you.

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
