Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4486CA9EBD
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 17:06:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8D72660663;
	Fri,  9 Oct 2026 17:06:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kH49z4x4AY6z; Fri,  9 Oct 2026 17:06:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E1B8F607B2
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791565579;
	b=H+O/62iCCjdOcAbs5qEdvk1A2O1zn1wznzuNBHqJSI0RnIjTuNLB9Mfm3WnLVYM7a/p0
	 HxVSklGF2jSC0Bvpz74A76TPMoWY/PrNT+0hE1JbqCH7c1h79iFVLFH6KL+OSt+mwtTBU
	 Ex2QTAntf3o6RoFeHai++mTBFqOOYkFF1FRW3CICo89VE0055aHKdoMZT7hfhsBUolL74
	 yXzX+Vl8JV7I4Izk3F4L7Pvfuw471Mcbha9t+cFr9MfCYnMfFwKlBAPKN/ycd4PjHYbgj
	 TXfdjgFgynoKKjhNvvedKJuNYfYGAvifKB/u9SdySKMaU6C7hV3Xy2BesjBsauPzAfA==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791565579;
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
	bh=wGigw5imRjQuHvBYtNrOnqESCK5HGCKJZZOp3Ae2AZk=;
	b=XHWyKoS2ZCne9v2baq6g+bOU6iq3Cb0Cemy01aCl1iYvs/s/ldfOpBm3iFl7YCj9hmd2
	 0SO7jVLC9Iy5iaQwMfZCBZXQfMYnWbP7XU5rM+qO0j/RDtEAZGrDu6tXbIinWGYlV4DxJ
	 aLz5bEur8ja2+uejvhkC8SHRc0EHutTuurnjWLi50yBPh/k4sVMfKVsDB1tGTYbanub0y
	 YDMLnYminj7IDscvPThw2d2jQp9RRnzyN+xnlo7sqQCTGM7qtj04M52h7TQVdyxAXec17
	 eZY7T76XjMdCTC+EPJvnCfh0V+VZTca5LFzVQw+adNVGm6c9mvD9ydZXyC6lFl7lwNQ==
ARC-Authentication-Results: i=4; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791565579;
	bh=wGigw5imRjQuHvBYtNrOnqESCK5HGCKJZZOp3Ae2AZk=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rK850krIIgilJ1AC+FwVhvRubkbiH3H0vFQaJBDxf/NV3vq+GNx7UOLDPEADVUrL1
	 jEgDkjBpz/X5PaRhWLxKsdh9vZwF4YmStJSrXlzJ+/d8cnJ/GQW5vp/KI+d1ZJ5xcv
	 IWGkMfFf4yASok64SDPFMgskYIPLoeEgk4DEufx+KrVwVP5bXEVHeoaZW75oRrG6av
	 hfuVmTZ8rAvLUCRpR9+PuGDZQ+BxuWmEyPrFkOMtv01fEcDVlfPapRzszTbW7u1DQ9
	 +vckcd24mcg8bAigoK9HFa5X531/+EOp0wZkS1IQh8BZJVy8TjXwy5imaVSeqPGcpV
	 ni2yQ5zHfeyFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1B8F607B2;
	Fri,  9 Oct 2026 17:06:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 85B622AA
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:06:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 777104095B
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:06:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZTaRiqLDuBhx for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 17:06:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8AA86408C7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791565576;
 b=gW2ilPIjkGQHdg5XoLEKTNUvWiNiFq/s+teeGKXMmA4AhyT5LuMWC3OjWwjVeLwk7ABb
 QGtC/020lPoAx969saLes2kaebJingHXveo+47LDuP+dpDLUAeafxBvxANxhgxgZM7JWn
 ZoJzBKgDfe86dtJXN4rQ2X711thkEwCyN/0/vJOm8ew/IBdPxeSn3bRKfaUEB+QPjTu5U
 J8Ut3LXA0oH2VhwVCdcRXnyRzBvT1eMKCXNlL/uJ6GkVTbL2Iq717eoly5X3D3NOcQSc6
 MfPjuQ0D3Un8uEUry2zbUZDPdba0AwA1/9V0OO7dGJKXA3jlTOTndXCFL67+ZMhFUmg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791565576;
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
 bh=wGigw5imRjQuHvBYtNrOnqESCK5HGCKJZZOp3Ae2AZk=;
 b=S/43FwiCh0QD/XfY882HJYmTxQ6J1gDvpHpe2jx9zAm+AhRwBIhY6fQIMBnPP2jp+b4a
 OH0TS00Q8+tsPhqifqtjJjbedI9GZ1xec5VPVDi6X0E8qqX6+9ay4S/0MeztDJA7Depaz
 TIzWua4Vvtj0l53obpSKS1VLpG9a9z6+mRxM+LyQR9mWSvMh1PeWxUQO+ygwXrtzNquk4
 FBDvvp7ThnkQwRCZz9csze8D1HTj1PsFiVKEEfAIY4qszVP68q+OsDB8TuXqXKpRaT3nq
 Q3Yg+FS8bs0aozMWracf/MvD7gGXQu516m529+7ep3aeFjT9pNSds61bRrT0k8ivibg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b="LHWGJh/A"; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b="LHWGJh/A"; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=LHWGJh/A; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=LHWGJh/A
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8AA86408C7
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:06:16 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=nBAZcHNKQH1WA/KFTK9kCmwj3lZVqj/0RowHZCS08NAAiduVZ5aBs0/6YicNcRemiVlFNmSby6NaUiQ8BB6BabJ8h08Tm2K0a+kfUeHErSRxBp12WF9wATM473tO+YwBXOklZj4Be5XIRDjTMLEvH/jfWx0adf4cywLyTzHauypRWoHHZ8LIIsVn8L+EjA89atroBAyDu2xshNtYnSeIRhqN3ZA2JBqnjVExPpxDdU/T3dwrrWbSOOB7wdz1WQGJGtmSj8JTX9Trqu2Q/EjljFkJQf5H6fef9fn9bD+9jYixa/i3hsi4PpnpnQklOQFuxxxbSVUllp0C8koEgjyy6Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGigw5imRjQuHvBYtNrOnqESCK5HGCKJZZOp3Ae2AZk=;
 b=xaZRPtGG/ouyhdfW2dwVG6iBH1Aryu5eMTX+AkkMESvXLeiUzedeAXFh+Yj3CZDutRqOwobk3duv1YkOr64brnFAd2mozouK6xtMem6PJYhOdyUDLl19YIuy3xec4fqvtDWKyDvsyLTDbIB2qccYU3sv7RWsvbc26q1118aXk1VaUex847T6EvQjFqGE1HrvrDihAecwBybYpUVyKCyrxG/zRQsOeAkdPvHlDS3THBcMRJFKu4XbUrFh2OCI699FkT6QC73RsSxq5cyscDKohmcsNdG+LzfJIToCi1Zo9ULgkqrT/PrHkPfCFlmK5ligGX5wzyIyXbTcU1CZ1jUZ6Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=0leil.net smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGigw5imRjQuHvBYtNrOnqESCK5HGCKJZZOp3Ae2AZk=;
 b=LHWGJh/AdRVJ5i2qDeSE5QgR8X9VYeSuZdiSWm9aKyfTYyfivmZz5GGsTbIwk7oxDC07hEWVH7L8N/roE6TlVi3c4DL6xMSZaA3tYRL1/8pU9HPnULihwB1CvZI6xQ4gjYkV+SZz5cZ8RssGLiUoLxsqprUBiJb7Ie50nBbB93w=
Received: from PA7P264CA0508.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3da::12)
 by GVXPR08MB11697.eurprd08.prod.outlook.com (2603:10a6:150:335::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 17:06:06 +0000
Received: from ZR1PEPF0000E6BA.eurprd07.prod.outlook.com
 (2603:10a6:102:3da:cafe::54) by PA7P264CA0508.outlook.office365.com
 (2603:10a6:102:3da::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 17:06:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 ZR1PEPF0000E6BA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Fri, 9 Oct 2026 17:06:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZbF9H3Ec7A6Ct1rZdlYNNtJPkXus4Iidxi08/VwP8Kq6cAW9N17sLh3gMlyVPD8GW9HB0gOR5sYgf96p/uF+48OVpm0UzbioyaG76FNOc+ClFAiKhPbpXfpLDPwp4h93asdKqTctQ+L3h8Hw8htHbHWqI3YRmbMFUrc1Le3UMAlQv6JZgBllxi5IpmNWE/8+H4zJIRBuq7q+0GNLcyjSJ1glD47ZX043kJL09XAEwU1QKlFlnuNrxmqBkiAnFrUmIlopr0PlC/bVn9NRdVIUvkPcf/Id0hETZK5B+M4kkypWhTtteD0IkZBZU7e64gin046VDhezHxbcajuymwL60g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGigw5imRjQuHvBYtNrOnqESCK5HGCKJZZOp3Ae2AZk=;
 b=KyPzhgiC1orQE5K77/XN/bLXmiRcBx440Mc912N9HrXnZqYLOfUE/w/HUnLfD4sSax/F4T1hSwSYJHlosfQZYbrwUdWPdQs5KjGsPbbwDE18nd8G2ul0S2EuNutlsCItmPWmXVxUz2xMX07TxvmVYLi1Ro4UuzVO3+bnaFf4znWB5ncGN8mnL9UEHwUCyz3dvv8r/+xOfrpOaOJSrj4TfBpssiau5gaN7iQFT1inB/sk8QdssBriB77KGeBI2+QbQhmjQW7qC0gkoAvg/YP4+A7/8J0I+sYTYdnDWScTe93Qz9tZnRJmwTWp/qAgN5aU3nfKkdb98cpmEQrGO4qOHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGigw5imRjQuHvBYtNrOnqESCK5HGCKJZZOp3Ae2AZk=;
 b=LHWGJh/AdRVJ5i2qDeSE5QgR8X9VYeSuZdiSWm9aKyfTYyfivmZz5GGsTbIwk7oxDC07hEWVH7L8N/roE6TlVi3c4DL6xMSZaA3tYRL1/8pU9HPnULihwB1CvZI6xQ4gjYkV+SZz5cZ8RssGLiUoLxsqprUBiJb7Ie50nBbB93w=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AM5PR08MB813850.eurprd08.prod.outlook.com
 (2603:10a6:20b:7d1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.6; Fri, 9 Oct 2026
 17:05:33 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 17:05:33 +0000
Message-ID: <1976b7ba-d135-4e23-b6d2-5e18dfb5881d@arm.com>
Date: Fri, 9 Oct 2026 19:05:32 +0200
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH 0/2] net: dwc_eth_qos_rockchip: Fix use of mii/mdio
 commands
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang
 <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, nd <nd@arm.com>
References: <20261004221306.67476-1-jonas@kwiboo.se>
Content-Language: en-US
In-Reply-To: <20261004221306.67476-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0138.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::9) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AM5PR08MB813850:EE_|ZR1PEPF0000E6BA:EE_|GVXPR08MB11697:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e749947-e421-465a-f642-08df26279b37
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|18002099003|10067099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info-Original: h8IBU20Q8VQWfD++mZ0bkm3hnmsEAEMGfMkOr9KdVaZn+BSqnVct8eG+eElPeqyMZs/ZZDTXhjqqQBlFJ6/rmHODI5Ir8B7NXQHF+qLwtbuAUkROAy1WEQ3vbozL4ojvONdseE/Fv/EPFN/7kzjbBU3aohm4PJXOxjsCla0QxbNI35UV7PQ1+CiGXqInie5c0RKoaAoCXMKKy36oaJRAuonudda6NLdyCGnqbLQ7BKScxR1noQMS6ggslHOUHOWjJk3GUL/SLzF2S30tdtGi7dkHf+n8PRsbN9W3hzMxkXwAGHUfRE+h+MiUTm2L85rJKOvyjU7TIEF3nD4ozFz9BjFtZ9D89fwIFGyBQfPgUdG0BWQZK7EzQSCBuTEO44ECnXQLF9EO4mWg21f/mxAVuEtuZqwd6lOrt17JSEawsFAHN/khBO4osWHB9wE1I+AN4m2XhMl6QF63wjs/lV/tK8Zw5Lgh7/zUNruZRBziVn4l4PGzXL/IOKXLYBVq8j1P4nblW4pxqTFYDyWWecNUlC1LUh4xNLTEru74PTyqNBAFCB5YlijXln1TLGZKycIBfn/dbGNtc+oIjAYOYYjpRNV2A6roGN1dgX1SIy2lt83drGsOc3ZP1U5wP756UWTOj8ZjMH5WtdgP5tn/VK7VzZDgxROnp/HHoM7gWRt+ocQ=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(10067099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: 0cJeARmS7flPtrUFNDBCf0l4GLM6EVK0ooK/X0a7dkerh6N2FOSDbEStC7Z222pZ/hJxF3v0K348Ptz9HtsW/A1gmcoa42/7sBbU26nmkqvATBHpx2mxedDysiwuqwxPP11kQ1axAYNn9LTIRb8Cp8l3/ysKn9iauD8rtbu6EzN5mKRC99SeJ5PzgxaB3wSbASAbm5SuQkAS+ymQZOp8omWwwxWRDkxgoW9nQSOPVAMPxQtjyPP1OJjneEeoXZh4wCe4ewIR/mSMciFaeX/N2BuM9B7Q294hSnSm71JtYmeN7KFppNu4KJWSkfZNQS3vOObjCYZOHNKqr+8530hGyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR08MB813850
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: ZR1PEPF0000E6BA.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2af85799-8bde-4e80-0cf3-08df262787be
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|376014|1800799024|36860700016|14060799003|23010399003|82310400026|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: GjK2XR8RrYelTQ0zdx3uYmYYDsj83tooEGuP+UAFGLl7Y/mCB6F76tjdsJ3Dq2JfTz6cmuxl7aoPDrCnwSl2qv3WYKMRVyS1j5/BfhxlfItRgvXb7e41tq+m1540eItlXFX/oS/A7xAItu1jXm+P7gWrs9B6tnm+QvmzlaQYkDDzPwXB41jXOjsMGclYZscQjHTgi23hk075AIbp4KbIf6wozMlvK+TE8v6mk4CqGeKSgDx3DNDGWo4ezSSDrTZPddL0hT/e01nTuFqGy897cWIKCEmYah8BF7MG1BA5xoqfepDgeT+1gwxMEEWuwBwXl/rWTNVk+uZROHP7CDoMp5MTInnKdc6w0CrUAS63/rd2xjAGcGKnLl5dR2Ra8uDOgqmgvOZoWPMXlrSO0WYMHMnKx9PPs3XNuUQyl7fhB/E8//ugWyDzEGKYfzyQGffXxig1fV9HlQ0ixKoVNqyYn5zbjmGlBEPgYdcoC0d4bDv3zQBaadgnehxNtY2PAl6DRapk3xbAWVmO+M8euYx4QtRINnBXJm/AOJf0ExpIkLHzNM0RVXGz549jwHn4BJiyUeE9LVFoDIj/JYJjRZbkfXWqZPi4BOD2Wd3Up1kPOH8L76froUG5MoMeON/OFsGn6L/z2N1lEc4acTkF4GuZq5HbAesGJ0VZQCfZ14i1KSpQ9ah0Zeh9mbngLa0l91droZYpJogct2WI+ZE0BeE06A==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(376014)(1800799024)(36860700016)(14060799003)(23010399003)(82310400026)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: c+PC5eyN45sUH9Z9hiKHoTpALi/WabgrfasheH3vxRSNZbejYKch45Fl1Ue7bGd7ruA3X6PAfZilvey/v7orRojWhnYt5T1RwjHbjpe+1ad2XEDu9l0rJ1QpBLc+zet6qM4Dpxohu3ZrmeAu/aqjBDy0y0l9erLcfdxj5kABD5ndM0+BNmB4GH8HPP10eEjm6KtEFXAC2MfmFkKvrmrku925a7/zIFZYozxr1y8alnpWw7A3KAvDROrl3zzPpOvULgWXVX9MZ8YgXLYlXU5TWvdD8lpan56owxRIguXjlGhLtNdtXSkno/zv22BiXjJEnvOsOlalWB/3c5m8FVcZPtpFZzV7pLhQ2sfnmVCKK/YO2RPzo379Afqa946Uhx0svGbGtlUAtJWYteGFNt6rWOzl0rm3wy9WATRVrU0C4rx6L6Zf5xbLDyDeHgoxdnkB
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 17:06:05.8197 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e749947-e421-465a-f642-08df26279b37
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: ZR1PEPF0000E6BA.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11697
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

On Sun, 04 Oct 2026 22:13:03 +0000, Jonas Karlman wrote:
> This series fixes two reset control related issues with of the Rockchip
> variant of the dwc_eth_qos.
> 
> First patch relaxes dependency on DM_RESET being enabled, reset driver
> being fully implemented or resets being defined in DT, e.g. during SoC
> bringup.
> 
> [...]

Applied to u-boot-net branch for-next, thanks!

[1/2] net: dwc_eth_qos_rockchip: Relax dependency on reset controls
      commit: f45285fdc8634c554713d2e22efb036d00f0581a
[2/2] net: dwc_eth_qos_rockchip: Do not keep reset controls asserted
      commit: 61e9a2abbf1364dfe0205edfa1be0e9e676eb4a4

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>

