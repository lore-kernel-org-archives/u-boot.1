Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510B6C79F9E
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 13:22:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E185880981;
	Mon,  7 Sep 2026 13:22:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e4HRWZ1WOVdB; Mon,  7 Sep 2026 13:22:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 819D4809CE
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788787360;
	b=iBOR9mjGTnuF8rJ/rzX16A8EETwKaLxUNk10tq7+aE/WnPq/7P4aQLeFAdn/i1cGBFAN
	 jcvS0bU7gvwb/M0MI1Nwvc/kW2J1nIb3mw6Zvj71gG/VzF0BBF/Kgu2fYjzUxqBpupdND
	 lTu/7IxprDqnKWzZ/jNyA23OL569rXXGuGwp4jFaHGVj87zc1x8v9AbvmqyAkiXO0LXAv
	 zpCi8bwVLp9QNMSyNO8M/n5BXWNuZ15mgVpDl4NVaCqfL+VP5pQRhGvDtpdSPISTkrvRx
	 V1B8H+zsZqh1meEVJtRuUjr/8pAZPOYxbgCGrRNvuBC0Ru3yVJamDD5oU5IuioJokZQ==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788787360;
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
	bh=+f2WIgynltfCBWRGPimVsSXOAY+3E8UfwZwZ9TzHTLw=;
	b=MwHMGEe2n6weA6CVYi7eXuvRbKp6gXq3+NhJ+CyqlH/QxYiAr8R1Hj3M5xOOMsjmJdlw
	 0b25tpFdRrKaWifniISrFZ68OswCd4Mi/H6dgyTF60fpCxloZD4dsIARRqEVlsKmJNKyE
	 MtojYvJba9qVDtpNl/2FekfEzj/8XZAJLBcufY6yY4GAa0Ok/vtZnXNhSCmx1HYwKwnwo
	 BGriBiXpQn6FlONQfTCO0IlSZ+WyA3tDLP70B2kzEya4549hXw5BdA9jMKDx1OBxOw1Ry
	 nhhjwnurS7pQ9xnBIKTjbpokHuqVTw9GVOzDRTpUwFI9nQrP9VXk386Y97zHi6XZw1A==
ARC-Authentication-Results: i=4; smtp1.osuosl.org; dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=qGMvvjCy;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=qGMvvjCy;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788787360;
	bh=+f2WIgynltfCBWRGPimVsSXOAY+3E8UfwZwZ9TzHTLw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SExw4MA/2cGBjRnaG8qsN/dndw/MePl35qJdIvXegJH0ffRstm+k8sthCiJkKfUTQ
	 2Tsd8rCYN9NweoGB/EsP9153CtWs2JzUquuYYZJWzQQ/FdLVsLjOj7+rbNabYA4lD2
	 m0FeZi7Pnif/7Pe5X5M9O/p+fqZqWq4nmTtGjnWZIV2++QLCBvSy6i8cUU9fEsri+D
	 dzQ9G/BGMscwrPcGZJvz92vnrTp0mMwr4dnSx3IWry6wCm4S6n1vXtyXadP/rVEcMV
	 5FZ1x9qwI1EyGe+eww8+hXhmCACSQGv4586AH15RI0cKVebH0pk3EyVlTN/SNX4Jxi
	 6utXvVIb2/J6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 819D4809CE;
	Mon,  7 Sep 2026 13:22:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4DD5629B
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 13:22:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3F29B809CE
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 13:22:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cQxVgqhg1_ah for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 13:22:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B635380981
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c200::3"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788787357;
 b=EsisZNuUeoM0YVy3tdoNgTlSL7WSyAUaDeiZOlhPWUSK+ac1mBxfG+rheC6tR/9JizOy
 wkiM9+EID+arL9jzC4VkReou4uXuEvbxaqINVrMSvq0QHHxSAcpZbeqKp1RscOAPCVtwr
 ox80i9qmRxC8LS3yW/V5ajQhZkVcL3VfDfN+gR3YFtro90vzMaVO2zhc3iiTyamd7H0H8
 WYEJ2lG1dZ0fEgnyF8LTLvRHPxALDO6ABrvqZHNJeJSX9bPHvnYpfaqj6lC8CJ9Omshn6
 OD1RTicgqNb6xaE0Fc+CCislDnX3l4XjcnYCMWf2UMszefV3Q7lLwN6Fh4pj6TeSKJQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788787357;
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
 bh=+f2WIgynltfCBWRGPimVsSXOAY+3E8UfwZwZ9TzHTLw=;
 b=hI0fh9dZedB7Vx9v1vKE3yAxhBaQM112EK8QTUCeXROVQYwtBZ29ihjxi/GyuJMuUOkz
 6r0fXPYQt9QRKrVj64vx0Y6YAuzjOiqsB/6GS7NubPWhI2/ahuAIr8lxtbkjKr/+vrU8o
 +Ws8VTKZLoC6fIrAhAGzUIF30y2duJNxiR+D+YjHZIC5gcEEKggQvIlukgOq9d8YkAOsy
 aPY0Yiz7Ma7tPHigPTWfapaQPbRxU6yZm6ZT4Gj+cZZ2oWqb2TwEwUbIrVJZsU896ovov
 I9kaqp22zhcLXhFYWPLJDosBSaV8zoCXFkWcMdTh3dM91Ca72dZ7O9/kcUwi11Bffyg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=qGMvvjCy; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=qGMvvjCy; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=qGMvvjCy; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=qGMvvjCy
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B635380981
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 13:22:35 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=drZKuhdXqis8Dno4F9xgtsnAl07ZbTC46nrIUES9gF5HJ96tGHFL7esWKxT+1p+W6QOfjH/WZLYI6A3hFxcvj7KrvtXxR6dz7L1oSlyPYj3ml7JRsy9kZ4wPPhCdCx6JAYrhRywGi9ptt9m5/uXx9iigsUKBrbN+bZBMtUGob4rf6OtkxkAH3lznvvSqtlHNkR2JhAduBekgATXgbL2OhUO2beXyzkHm/bIdENSxD+w9TumsFFRJ3fJikzsxBfqdGQLIf/fCQEQKxewGS+vPzbvy/5ejIPkXOXrVR8HXZnmZvwvVxxjZFx5tXiXgOH2pnM7Xsxjqg2TkRz1uwAZNcw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+f2WIgynltfCBWRGPimVsSXOAY+3E8UfwZwZ9TzHTLw=;
 b=NTrlxap89UajYfG3AVK8ViKANvFdF5FtWbGbir7h5jWblV848XJt7vx1LB6ybVqvcB/6w5BqdZpCWv2shnvqKeDn1CtlPQ4FGpSHl8rjd6/0/jVMZKRa2Zw34Ed3CrGRDhi2ES26hupFPAWvgqqVlICdySZp1Y2n0vIlGcQ9cnEzNR5xz/nqt6Jc9ALDd/QIXcG6gbhc2dFjgihstJ0Ck/P7K1Y5btPltERs3ftn3MVyTVXOUxzFUmf8M+LcajZ7P+yNyZinpBNrTn5vpWSKRiFMLBChG9tR4hHDhTcdgUkq7embktdGxwa3wi4cIAvQpoIkxlVJACeWAdvNYhCbmA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+f2WIgynltfCBWRGPimVsSXOAY+3E8UfwZwZ9TzHTLw=;
 b=qGMvvjCyZzQ+JbbeLsyHgU5TVRdld1RkGXUi2WxkVOimPRL8Qxx2OO8zQsUhz9ih5h1VhngBvo9gIyS5Qj8yabNFL/Gu6jD5Lv9hWDN+mM31hi066oGXGr+ysg6au761TBHhxGFm1JNgB4zYMA8jVB+vqpfVoZkpUcGwzpckQ9c=
Received: from PR3P250CA0027.EURP250.PROD.OUTLOOK.COM (2603:10a6:102:57::32)
 by AS8PR08MB10071.eurprd08.prod.outlook.com (2603:10a6:20b:633::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Mon, 7 Sep 2026
 13:22:25 +0000
Received: from MI3PEPF00008558.eurprd05.prod.outlook.com
 (2603:10a6:102:57:cafe::9) by PR3P250CA0027.outlook.office365.com
 (2603:10a6:102:57::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 13:22:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008558.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Mon, 7 Sep 2026 13:22:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bh+KFjht1FDmZ2hzEzjvm/+9HwCz2M2BVnpw/aEoyIffvz6o2Ktu5o5fMlyWDEj42o5wWvOQ0gFS/Cki5lORUbpiSbXDkSgrSPQL1/tjXDtwBJ9M0dcr2LpQ3szy4E+5nCMgDANaqCJU+2ubt3XNo3KRhF0iTsZyF2kEF+48OhyAZOezrnMGMmcAsaiExzEIp/fkHb1uu7Dyco7SqgV8wbMbpw9JfI3qIAeg9GNjTGXvbT/kM46AzCSqxVFQ2XJLwnTEKAxLaCrUXeOCpVo1z3rUDMm4dx8f7PyYlwsDbdPdLR/i294O2OCI1Yb8VnJ1riUlazgw9ENTwnWfAwS6Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+f2WIgynltfCBWRGPimVsSXOAY+3E8UfwZwZ9TzHTLw=;
 b=Wbp813Vu58q5ydDKUI1A67HfdDJ6/ZSaxulkNHr3/2M7fK+zpe79BkyGI9Ogg6wHI1bEfF9Ojzfumbpuh5HMK1B8R5gfF3VUNuVxFV7xWXkMNCz0o9OfCMWPv5LCWdrOQfmlOygZ+oRnnMHeJ1y9Id+gSsQE8+2TPhNEi6KIybhWgnfSYx5NOiRmwHu3GZ7Og6AO8GpG1o38LouGDN9Y/V9eSBvqJUV7iQKwR4LOVRwH1k6eUGHuOOx6cFlAIYZG5D9s6w0X6efyOmp8WjS3/EzffeP9kcyHFzikgBIFnaK9ab59y15Vjc+uF/HSHzZ/5fZUQMdrXllUWyAkSABNxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+f2WIgynltfCBWRGPimVsSXOAY+3E8UfwZwZ9TzHTLw=;
 b=qGMvvjCyZzQ+JbbeLsyHgU5TVRdld1RkGXUi2WxkVOimPRL8Qxx2OO8zQsUhz9ih5h1VhngBvo9gIyS5Qj8yabNFL/Gu6jD5Lv9hWDN+mM31hi066oGXGr+ysg6au761TBHhxGFm1JNgB4zYMA8jVB+vqpfVoZkpUcGwzpckQ9c=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AS2PR08MB8285.eurprd08.prod.outlook.com
 (2603:10a6:20b:554::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Mon, 7 Sep 2026
 13:21:46 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0406.002; Mon, 7 Sep 2026
 13:21:46 +0000
Message-ID: <3c8a58ac-a48e-4dd0-b5a7-f7387b9a30f9@arm.com>
Date: Mon, 7 Sep 2026 15:21:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: sandbox: support raw Ethernet with lwIP
To: James Hilliard <james.hilliard1@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Johan Jonker <jbx6244@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 David Lechner <dlechner@baylibre.com>, nd <nd@arm.com>
References: <20260903-submit-lwip-sandbox-raw-v1-v2-1-206bb597fb4e@gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260903-submit-lwip-sandbox-raw-v1-v2-1-206bb597fb4e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0346.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::9) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AS2PR08MB8285:EE_|MI3PEPF00008558:EE_|AS8PR08MB10071:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd0005c-b574-4321-50ce-08df0ce30df9
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|6133799003|3023799007|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: y6SsstzE2ZlCV3EFI5m4hrL5I9ibMHCyZPBUlZJs3kcL4+MxNlbvWABMAxXDObyX1qhdQzgJEFkILqU0e9z0NKriYpRKp3xaMawK6N2jDcdDVWQ/r8dFKs+buSX7XhCbOGjo8XmsylKytR0uUbB80l/FkknM19orYvIoVVVnV4L79EduX1hR03T1Pa0A2VhZvKSzkkhr5eAi4wwBR1AifJ+L/lAsHvj7HZl53b2vZCIR6Q5RMtXbWTKIoFSbG4OkjEVep3WC6jsrC4j7BSbAXnjxIf2AqRhhbvb2NFlaQehF7PNaLNH5Pp3jAU4dRCD25k0J1Smg6kDQxLil4vaJ97kMcIxVXcmKC4bSFrxZeM73RLn0VAKPvND5xmQ8qZ29KEJ2dgyIY5RTTU2YHmqSZ17XQh0Y8zfISbSLt8I3RmGUqkTtvEkX+X3jQ0XgjFkpUtjC5CpycSYSHUGng1ILFhdGcDHYQInVnQovNXWcEc0ouVE6+BXrcpQ2wQWaVEcrQr+6bEMKu4ptGCYf/K+7bS4vdn3FBGlyvG/1jgEIRHqCZLY/UhXLoQBS608Qn2vbpJn4bY5XzAWvLFxLjUXJlVRxBJFEv41/69t9MuieBOPnvyJTttJWGz62eHnajmI0
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(3023799007)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: SO2Al5PKJC0ZO2xjrDdekxRRmraXClELbdB6TANLpE+Qb5XlUtf2b5afrYsUm/gEEPJat5xUYVXRYHohvbRdgAITOI7PawgmpTz4d503wu428upo+sLiPmR//UgOxGwkUoBUHg9TMg5bVWGl/dJiWtHoFkoXz2cd8Zi7vBGo9l/9CtFbscYrHbbHRRUThdq8ZFwhCThQH7XzIFTZpVXxFSGc4laS2OF6eqpRBsaU0k/egUeGIUxYYOumq7Kv+wF2eIzQbxg1SrgBXgmD0pymMaYEJgh1RDRdBUfz8mv8Muvn2jVxcQN2dwJnJeCGbTA3utZdfosTV9WLDOYcq4QxFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8285
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF00008558.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4e24e480-e587-4006-0ec4-08df0ce2f776
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|35042699022|14060799003|82310400026|23010399003|1800799024|36860700016|13003099007|6133799003|3023799007|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: l2ic+zdJpg3Uce099Wl2rlbsWCxb28FeQ2R+nzIyajJKMvDz66NPBK8Wk6U8NEhgtmaaZBd/im5tGkEF6LJnI2AypldnPis2k9JDAK9Zaxd5V/bZaiLGyCF2aXgSAJiT4M6HxjM1lBpf5320AnAQy/qYF+ob8rBEY6NGKHtq8a3itmnsqGRoXAtYpe4EqWKbbknd7h1HSBL+IfxPCV32O8specTg2BUR2iTJEghndSLLTJtWsAoumANavB4E1wIaMm5L6nUcJcrOJoNL39N53RaS0lPgymjZRy3hOpXHIjaamSf7AFCe7fbk6s9HrBFMtR43mJL4vsdOxwSQk12au9wM2CGygJ3g4mEUAq2U2koM0cVnsI1TUEw7dTniQv5QJ98agVvjQnqJFXoNBbGHSSzBolSQWQpXy4E6qLIN6clntfAepW/cIGuMBv0BYVzUVnK2n8SXLxgUNM7AX0ERZZWei1m0E0o/74amdGAX0BMGXP0jmWh3Xxfocj+eqm2+3vsQUHh2Tgm/jW6tvJnyA9IQfxE3QXlDW3eX66Gpgpi1rTxVmUhrv0+whRjP4g6OZqa5e4AXMPxRQCUGtI8tCrTRvvYrboZdyp0p6zp/72B0GKSgGOkBGXK5nuONfoXUnvSmGOdGmHyTlPskGkAWvQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(35042699022)(14060799003)(82310400026)(23010399003)(1800799024)(36860700016)(13003099007)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +m+4TXcaTzZ2HPTFaU9PNsfNbpmy+iymz+WDhXwPXPJD17+XEEKBLkIStaz5ECceapTPOpB8uv879o7UDVxG49LbpVETsQ0X2Ayp2mDNcpRDQpotOt8h61MfTaquYuSHMBN96u55kXodWnf1PqgSHxz+zivDIRhDuXy9vtG7iTBTijbzTz2uY5Woq75XQtjiPwL7tPv4uIFY/9+Hyt54ILiYgbFOI6f6AvdLKNm0xJlani0k7Kggdmqpbqqiicacgcgr+8GUQYrljGzgVc+mnUdlSS9q3XH/5QpjefNc4aCbSNDTM1slIlPe0laeNmQcCSefLxguxaix6ovENa9Feh/OcTrNdUpp0tBBbIMjlTeTWdb+cMibjvw1cb5f2Oj9J/B26vQetriZTrJDOUOCHrdAmwC41cYw2bHvAr3zSV6VfL8EAJfRXpL7Us9F/OHo
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 13:22:23.9477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd0005c-b574-4321-50ce-08df0ce30df9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008558.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10071
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

Hi James,

On 03/09/2026 19:09, James Hilliard wrote:
> ETH_SANDBOX_RAW is restricted to NET_LEGACY despite operating through
> the common Ethernet driver API.
> 
> Make the localhost shim stack-neutral: define the ARP layout locally,
> populate lwIP's per-device ipaddr environment variable, and retain the
> legacy address state when that stack is selected.
> 
> Linux loopback can expose UDP checksum-offload seeds through raw sockets
> without the metadata needed to validate them. Normalize these to the valid
> IPv4 no-checksum form. Only update the dummy UDP bind for UDP output so
> lwIP-generated ICMP packets cannot disturb it.
> 
> This enables both real-interface and localhost raw Ethernet with lwIP.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v1 -> v2:
>   - skip non-initial IPv4 fragments when parsing UDP headers  (suggested by Jerome Forissier)
>   - avoid overwriting ipaddr for indexed lwIP devices  (suggested by Jerome Forissier)
>   - Link to v1: https://patch.msgid.link/20260825-submit-lwip-sandbox-raw-v1-v1-1-f9558fb4f6d1@gmail.com
> ---
>  arch/sandbox/cpu/eth-raw-os.c | 85 +++++++++++++++++++++++++++++--------------
>  drivers/net/Kconfig           |  2 +-
>  drivers/net/sandbox-raw.c     | 52 ++++++++++++++++++--------
>  include/net-legacy.h          |  6 +++
>  include/net-lwip.h            |  5 +++
>  5 files changed, 107 insertions(+), 43 deletions(-)

Looks good, thanks for the update. I'm adding this to my queue for for-main
[1]. Unfortunately and as I said previously I am still unable to actually
push patches to the branch (and send a PR to Tom) due to network problems
with my development machine. Everything should be fixed by Friday (11-Sep).
I apologize for the inconvenience.

Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>

[1] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/tree/for-main

Cheers,
-- 
Jerome

> diff --git a/arch/sandbox/cpu/eth-raw-os.c b/arch/sandbox/cpu/eth-raw-os.c
> index 39ea3b3f012..42f291a5519 100644
> --- a/arch/sandbox/cpu/eth-raw-os.c
> +++ b/arch/sandbox/cpu/eth-raw-os.c
> @@ -208,7 +208,6 @@ int sandbox_eth_raw_os_send(void *packet, int length,
>  			    struct eth_sandbox_raw_priv *priv)
>  {
>  	int retval;
> -	struct udphdr *udph = packet + sizeof(struct iphdr);
>  
>  	if (priv->sd < 0 || !priv->device)
>  		return -EINVAL;
> @@ -226,38 +225,51 @@ int sandbox_eth_raw_os_send(void *packet, int length,
>  	 * stack from sending that ICMP message claiming that the port has no
>  	 * bound socket.
>  	 */
> -	if (priv->local && (priv->local_bind_sd == -1 ||
> -			    priv->local_bind_udp_port != udph->source)) {
> +	if (priv->local && length >= sizeof(struct iphdr)) {
>  		struct iphdr *iph = packet;
> -		struct sockaddr_in addr;
> +		unsigned int iphdr_len = iph->ihl * 4;
> +		struct udphdr *udph;
>  
> -		if (priv->local_bind_sd != -1)
> -			os_close(priv->local_bind_sd);
> +		if (iph->protocol != IPPROTO_UDP ||
> +		    (ntohs(iph->frag_off) & IP_OFFMASK) ||
> +		    iphdr_len < sizeof(*iph) ||
> +		    length < iphdr_len + sizeof(*udph))
> +			goto send;
>  
> -		/* A normal UDP socket is required to bind */
> -		priv->local_bind_sd = socket(AF_INET, SOCK_DGRAM, 0);
> -		if (priv->local_bind_sd < 0) {
> -			printf("Failed to open bind sd: %d %s\n", errno,
> -			       strerror(errno));
> -			return -errno;
> +		udph = packet + iphdr_len;
> +		if (priv->local_bind_sd == -1 ||
> +		    priv->local_bind_udp_port != udph->source) {
> +			struct sockaddr_in addr = {};
> +
> +			if (priv->local_bind_sd != -1)
> +				os_close(priv->local_bind_sd);
> +
> +			/* A normal UDP socket is required to bind */
> +			priv->local_bind_sd = socket(AF_INET, SOCK_DGRAM, 0);
> +			if (priv->local_bind_sd < 0) {
> +				printf("Failed to open bind sd: %d %s\n", errno,
> +				       strerror(errno));
> +				return -errno;
> +			}
> +			priv->local_bind_udp_port = udph->source;
> +
> +			/**
> +			 * Bind the UDP port that we intend to use as our source port
> +			 * so that the kernel will not send an ICMP port unreachable
> +			 * message to the server
> +			 */
> +			addr.sin_family = AF_INET;
> +			addr.sin_port = udph->source;
> +			addr.sin_addr.s_addr = iph->saddr;
> +			retval = bind(priv->local_bind_sd,
> +				      (struct sockaddr *)&addr, sizeof(addr));
> +			if (retval < 0)
> +				printf("Failed to bind: %d %s\n", errno,
> +				       strerror(errno));
>  		}
> -		priv->local_bind_udp_port = udph->source;
> -
> -		/**
> -		 * Bind the UDP port that we intend to use as our source port
> -		 * so that the kernel will not send an ICMP port unreachable
> -		 * message to the server
> -		 */
> -		addr.sin_family = AF_INET;
> -		addr.sin_port = udph->source;
> -		addr.sin_addr.s_addr = iph->saddr;
> -		retval = bind(priv->local_bind_sd, (struct sockaddr *)&addr,
> -			      sizeof(addr));
> -		if (retval < 0)
> -			printf("Failed to bind: %d %s\n", errno,
> -			       strerror(errno));
>  	}
>  
> +send:
>  	retval = sendto(priv->sd, packet, length, 0,
>  			(struct sockaddr *)priv->device,
>  			sizeof(struct sockaddr_ll));
> @@ -283,6 +295,25 @@ int sandbox_eth_raw_os_recv(void *packet, int *length,
>  			  (socklen_t *)&saddr_size);
>  	*length = 0;
>  	if (retval >= 0) {
> +		if (priv->local && retval >= sizeof(struct iphdr)) {
> +			struct iphdr *iph = packet;
> +			unsigned int iphdr_len = iph->ihl * 4;
> +
> +			if (iph->protocol == IPPROTO_UDP &&
> +			    !(ntohs(iph->frag_off) & IP_OFFMASK) &&
> +			    iphdr_len >= sizeof(*iph) &&
> +			    retval >= iphdr_len + sizeof(struct udphdr)) {
> +				struct udphdr *udph = packet + iphdr_len;
> +
> +				/*
> +				 * Loopback packets can retain a checksum-offload seed
> +				 * which a raw socket cannot validate without skb metadata.
> +				 * An IPv4 UDP checksum of zero explicitly disables the
> +				 * checksum, so present that portable form to U-Boot.
> +				 */
> +				udph->check = 0;
> +			}
> +		}
>  		*length = retval;
>  		return 0;
>  	}
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index faa08e9ebba..c057504cf66 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -366,7 +366,7 @@ config ETH_SANDBOX
>  
>  config ETH_SANDBOX_RAW
>  	depends on SANDBOX
> -	depends on NET_LEGACY
> +	depends on NET
>  	default y
>  	bool "Sandbox: Bridge to Linux Raw Sockets"
>  	help
> diff --git a/drivers/net/sandbox-raw.c b/drivers/net/sandbox-raw.c
> index c3d40f0b59e..f62758e6d44 100644
> --- a/drivers/net/sandbox-raw.c
> +++ b/drivers/net/sandbox-raw.c
> @@ -13,6 +13,21 @@
>  #include <malloc.h>
>  #include <net.h>
>  
> +#define ARP_PROTOCOL_ADDR_LEN	4
> +#define ARP_OP_REPLY		2
> +
> +struct sb_arp_hdr {
> +	u16 hrd;
> +	u16 pro;
> +	u8 hln;
> +	u8 pln;
> +	u16 op;
> +	u8 sha[ARP_HLEN];
> +	struct in_addr spa;
> +	u8 tha[ARP_HLEN];
> +	struct in_addr tpa;
> +} __packed;
> +
>  static int reply_arp;
>  static struct in_addr arp_ip;
>  
> @@ -20,16 +35,23 @@ static int sb_eth_raw_start(struct udevice *dev)
>  {
>  	struct eth_sandbox_raw_priv *priv = dev_get_priv(dev);
>  	struct eth_pdata *pdata = dev_get_plat(dev);
> +	char ipaddr[sizeof("ipaddr99")];
> +	int idx = dev_seq(dev);
>  	int ret;
>  
>  	debug("eth_sandbox_raw: Start\n");
>  
>  	ret = sandbox_eth_raw_os_start(priv, pdata->enetaddr);
>  	if (priv->local) {
> -		env_set("ipaddr", "127.0.0.1");
> +		if (!IS_ENABLED(CONFIG_NET_LWIP) || !idx) {
> +			env_set("ipaddr", "127.0.0.1");
> +		} else if (idx > 0 && idx <= 99) {
> +			snprintf(ipaddr, sizeof(ipaddr), "ipaddr%d", idx);
> +			env_set(ipaddr, "127.0.0.1");
> +		}
>  		env_set("serverip", "127.0.0.1");
>  		net_ip = string_to_ip("127.0.0.1");
> -		net_server_ip = net_ip;
> +		net_set_server_ip(net_ip);
>  	}
>  	return ret;
>  }
> @@ -44,13 +66,13 @@ static int sb_eth_raw_send(struct udevice *dev, void *packet, int length)
>  		struct ethernet_hdr *eth = packet;
>  
>  		if (ntohs(eth->et_protlen) == PROT_ARP) {
> -			struct arp_hdr *arp = packet + ETHER_HDR_SIZE;
> +			struct sb_arp_hdr *arp = packet + ETHER_HDR_SIZE;
>  
>  			/**
>  			 * localhost works on a higher-level API in Linux than
>  			 * ARP packets, so fake it
>  			 */
> -			arp_ip = net_read_ip(&arp->ar_tpa);
> +			memcpy(&arp_ip, &arp->tpa, sizeof(arp_ip));
>  			reply_arp = 1;
>  			return 0;
>  		}
> @@ -68,7 +90,7 @@ static int sb_eth_raw_recv(struct udevice *dev, int flags, uchar **packetp)
>  	int length;
>  
>  	if (reply_arp) {
> -		struct arp_hdr *arp = (void *)net_rx_packets[0] +
> +		struct sb_arp_hdr *arp = (void *)net_rx_packets[0] +
>  			ETHER_HDR_SIZE;
>  
>  		/*
> @@ -80,18 +102,18 @@ static int sb_eth_raw_recv(struct udevice *dev, int flags, uchar **packetp)
>  		 * to get a response. For this reason we fake the response to
>  		 * make the u-boot network stack happy.
>  		 */
> -		arp->ar_hrd = htons(ARP_ETHER);
> -		arp->ar_pro = htons(PROT_IP);
> -		arp->ar_hln = ARP_HLEN;
> -		arp->ar_pln = ARP_PLEN;
> -		arp->ar_op = htons(ARPOP_REPLY);
> +		arp->hrd = htons(ARP_ETHER);
> +		arp->pro = htons(PROT_IP);
> +		arp->hln = ARP_HLEN;
> +		arp->pln = ARP_PROTOCOL_ADDR_LEN;
> +		arp->op = htons(ARP_OP_REPLY);
>  		/* Any non-zero MAC address will work */
> -		memset(&arp->ar_sha, 0x01, ARP_HLEN);
> +		memset(arp->sha, 0x01, ARP_HLEN);
>  		/* Use whatever IP we were looking for (always 127.0.0.1?) */
> -		net_write_ip(&arp->ar_spa, arp_ip);
> -		memcpy(&arp->ar_tha, pdata->enetaddr, ARP_HLEN);
> -		net_write_ip(&arp->ar_tpa, net_ip);
> -		length = ARP_HDR_SIZE;
> +		memcpy(&arp->spa, &arp_ip, sizeof(arp->spa));
> +		memcpy(arp->tha, pdata->enetaddr, ARP_HLEN);
> +		memcpy(&arp->tpa, &net_ip, sizeof(arp->tpa));
> +		length = sizeof(*arp);
>  	} else {
>  		/* If local, the Ethernet header won't be included; skip it */
>  		uchar *pktptr = priv->local ?
> diff --git a/include/net-legacy.h b/include/net-legacy.h
> index d3b122c9062..2737b683cb1 100644
> --- a/include/net-legacy.h
> +++ b/include/net-legacy.h
> @@ -288,6 +288,12 @@ extern char	net_root_path[CONFIG_BOOTP_MAX_ROOT_PATH_LEN];	/* Our root path */
>  extern u8		net_ethaddr[ARP_HLEN];		/* Our ethernet address */
>  extern u8		net_server_ethaddr[ARP_HLEN];	/* Boot server enet address */
>  extern struct in_addr	net_server_ip;	/* Server IP addr (0 = unknown) */
> +
> +static inline void net_set_server_ip(struct in_addr ip)
> +{
> +	net_server_ip = ip;
> +}
> +
>  extern uchar		*net_tx_packet;		/* THE transmit packet */
>  extern uchar		*net_rx_packet;		/* Current receive packet */
>  extern int		net_rx_packet_len;	/* Current rx packet length */
> diff --git a/include/net-lwip.h b/include/net-lwip.h
> index 8e59a2299e0..9b7755e335e 100644
> --- a/include/net-lwip.h
> +++ b/include/net-lwip.h
> @@ -26,6 +26,11 @@ enum proto_t {
>  	TFTPGET
>  };
>  
> +static inline void net_set_server_ip(struct in_addr ip)
> +{
> +	/* lwIP reads serverip from the environment when starting a command. */
> +}
> +
>  static inline int eth_is_on_demand_init(void)
>  {
>  	return 1;
> 
> ---
> base-commit: cc557af4553382f6f50e3ed62b9577054e7bc54f
> change-id: 20260825-submit-lwip-sandbox-raw-v1-749315041b86
> 
> Best regards,
> --  
> James Hilliard <james.hilliard1@gmail.com>

