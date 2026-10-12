Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D9FCA9EC5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 07:46:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C4D6605EF;
	Mon, 12 Oct 2026 07:46:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aGZLPEBY8fUd; Mon, 12 Oct 2026 07:46:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4AEDD60602
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791791172;
	b=hjt3iVqmwVZM00fORrLdftIlQG6UHv5xFLplWzl7CdCYtFlC4rvqh3MO34py0Czm7Qmu
	 1r35K+4pHpSwHfhWHI2XhCvIZI7bGMEjll0lL/SBZkWPftxzQuirycv7UHWHuz+0ZYBEd
	 4LzUg8WkdHANNaIAby90f4N3PKlFo0+0Wsc8/lXIAD0WOJsjLSJlYuY+7vnSdR2Xu+MYl
	 t72ZM3Fe2LeKRMWJXMBkhNRg+DLxxtZm5lIK30sUUhmKOsskNbyPwhcDKMDAunPcQL7Xt
	 AOcvJ/qBgg4SKA22YJ0JQmq9UbyMbHa23WnF1T4uC8DopKV4zYWBPux9f7D8qGGYNMQ==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791791172;
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
	bh=VUhX+e48i+tyEHoAPaKFQr3vFsDNVH4E4fDGY5aHc9s=;
	b=RiTJQGtatSeDPdU9qc+tWwRqKb3NMzMBYqG4Kc4VyW4sDJGPOa+rzhX9YX8iJesjDspx
	 IXipg/fqvL/CMc3lkeP9SELSYOW2bYy4GyzYeIEC7rZ1mAQim67P4CqvsFK44zb4iXNc4
	 Q2pZtJ9OmXb12DSRhdUvtO3MyAxVnNxjVp4bBNCMecC/XcSiuTciYCrJh70KwZilEKL2o
	 JP4n8v61MgG+FcqD1BihkMfyaavBNa7b67KI3bgjKTNuvs3mQ05Lz5l2YVUf8Z5z2Nbvn
	 g12/M0E4vXnFdZobFOACKc8RZ6sxs1rC6Rvd9v5xxb41Jcbu1hkehSu3kWPDZ9Xwpmg==
ARC-Authentication-Results: i=4; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791791172;
	bh=VUhX+e48i+tyEHoAPaKFQr3vFsDNVH4E4fDGY5aHc9s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kMRGSUAhiOyBTAygaScU8GpJtQ59Rjdv1V8vk8f1Zg9GRIwAnLLNg6Py7bfY7lgR9
	 BZqdbwUekwYqW7z0jNowHWlOJpXJCsYXZKyOWF2Oiw3QXjCbNsa6mAoadRQgFMY+Oh
	 TEdIRZkw9vcC5wL7jO2ZT37jyEjo0dNwodkRDIF4iuT7VxrYhvAV2+sgALWNh5+z1N
	 0ruj36mXFAGpnK00Hldwy2YQfUjqkb9BJs0abXerL6cSuKOM1TVIBKCSfGBYKIMDoO
	 ZX0dglOkiF5WUr1JxikyCIdEpKS4I//B37AaaLKLs997d81i8uep3TG8x77tmBdyyJ
	 9hIxigJB4gDgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4AEDD60602;
	Mon, 12 Oct 2026 07:46:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 58A4675
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:46:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 560FE80AED
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:46:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qo7_TOrgQAGV for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 07:46:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 354B880980
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c200::1"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791791170;
 b=GIF2GHxrn8+vpieWIVzTCeH2R4QoUdCK6QZAGXsQviRjwAPqdK4cvkjvObmhAawnZDjz
 70ibnOa2mejs7DDNPPWQnyzRbSjemmR476rlWhldLNZIVf6wnlOhBI7NR0C/jSphd3ZD/
 XDDjc6KypbbciyMqmavysCfFhLyTlr4UuAOw4jwnPVLepvZyfGCyNEays6iaRSZMUMbvX
 mYj4y1YlDsfZ6B8V48TzQ3ZsPXCyWrfhu11i4GmqzFcTuNk1F+EEjUsGnZpA1zbxV0cUs
 zSvcpx8x+xXAXm78F/AeTyjHgUacTxjzlvD4w5y09WkQorU6NXHsHAlaSQlNlO3YQLg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791791170;
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
 bh=VUhX+e48i+tyEHoAPaKFQr3vFsDNVH4E4fDGY5aHc9s=;
 b=HQ7fUJTBJTr3XZ52Srmk04GNRAx7ffw+9tLom6+t54ly9ewlY5PYsFsGHZuZb6949D92
 bT3S6zLQ2BNJDBFSEdCDSSYKMDpXAyUzbBQxywLsdo9wY8yabwzftuc9vxGJrEepRG1mW
 CaiBLbtI3wwVYINbtN2xRjS0CkfLFniFMc6nxbY0Ca+BK4ScZs/FKnbNUgb5AJz7qRjdA
 fxtxSH5ON3PPFk1oj+UR9DSKkk0Cw5KlZHQDirH9oq4qN4Pif5IBn3+rFXWTV8BeCX0uL
 4nu3+zsaINdeYisEcy1F5L0oNMG9XXjPxMN+FRvSV1560mhH/wPgZwE4gkI3r7Jnz0g==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=In4WjbQx; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=In4WjbQx; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=In4WjbQx; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=In4WjbQx
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 354B880980
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:46:08 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=s8BCkHclG9so+M7+nd6ILImQzq/xAKesuBSc9Pdf4IyN3p1C4avOjRkhcLruR8tRAawMR1o9gzZOK89lsWbynTrMNtbOmC1HhPwIY04Jt/B3/1duzyJklpyAppEv5hppRVRxerTgPSACnd5+1t0GnqWUs808anxj41opfpwVpDE114iBTcNuExj/R5uni8fOFf/NSDCEtWYW3kHchf30ggzNu95IjfxNgpWB1aBpC5IyNFLse8V/e+kDCCCK/+4/n4nPTrfl2Pc3DDRcKser9vafqmmu1h+ZkXOPd7GFKDKZHYGBztaNkKEyNoojnjmnTZaaYwx9J63xM8CejDvn4g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUhX+e48i+tyEHoAPaKFQr3vFsDNVH4E4fDGY5aHc9s=;
 b=uK0sp0C5bVkHuMfVGUnPrsZ3zHBci0AJ+fFbJTcoIngNdJ9/mmsVozsJkb2l9dTomCAtnv0FQiVdO8VKRBlkDTSH/U+jtqurYuGoiDudJk9s231tVG6hfAWdgNKNWyopfxNCCIy+N/5TQ7xLjnRbvKqGp7UcLMHCr9Q7k2WRbh45lFTCmjATPbji5Rc2EBeDTXWKGbDaEQpouL8fJ7vMuF0QLyBg/o3Q6voLygGfLz9jp423pxiByQrfUuLRR6UvoZ7DVIZWGj9j+8b4UH81XJj0V1BLPkz2GRL6PErFGgyLpjNX87YNhAf4/AVXy6FL5amXnex9HR15Ta9ku8Bx8g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=konsulko.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUhX+e48i+tyEHoAPaKFQr3vFsDNVH4E4fDGY5aHc9s=;
 b=In4WjbQxmXf4e7ppQT6hg77vBPcOjOm7QBiazvjoe3NQSKGJp8U224o/PTYDTfOjx9/OTmAz74x3v4KNPKtf7LA1cKPmkgif9knokW50t9ohTk+N2wEx4WLb35LgoZe9eC0wlDL3Ti92uNL0tqCO5c7nDDTU7hvax/j6Payy40E=
Received: from AS4P190CA0002.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5de::11)
 by VI0PR08MB11171.eurprd08.prod.outlook.com (2603:10a6:800:256::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.7; Mon, 12 Oct
 2026 07:46:01 +0000
Received: from AM1PEPF000C1AD7.eurprd02.prod.outlook.com
 (2603:10a6:20b:5de:cafe::72) by AS4P190CA0002.outlook.office365.com
 (2603:10a6:20b:5de::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon,
 12 Oct 2026 07:45:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM1PEPF000C1AD7.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Mon, 12 Oct 2026 07:45:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eNM33nXc6kCZ8VOuM2JSDmfrhv70cN06jSp6hcjkJ0zi4PCFWE+2i/m4USw1BNkAKdhfkRby2iswg4sVFzyXdiYXONXD7JyukLPJmzwiND0o9GcvvII5sVJ3UOqkL03n0yOWIdhGPIwNI+VQgyiydSIPG97zYtGrOg3HKFM9icHYk4Io3Kd/YKzaU4N9sS45eaXSD60p9w9IccW0E0SSZUdlHX8U4Pvy1Bpwt58l1CcEXLbPSY5B+nCu+UvtDFhIrAsUdLfI+TywbDrsfbQIYghEUWxXNX4+OmBJq/k3f7nYB7M1a73LSx6GasJV68YDiDjtnIchVBb2c5If+RpcuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUhX+e48i+tyEHoAPaKFQr3vFsDNVH4E4fDGY5aHc9s=;
 b=mnpsbh/V1ba6FiyNliNl/wEU0yiORq14a051kVsQc3BNW5eoaoNaSREL7l4hanb9dYdnqDz4lcsY62o9SKYmfgb2+rvyMBMoiB5E3jMdSQtomn3xx1AxNjn97Pwpnox/s12wgiRXEsSofsFp63DY5NFmdu2ItE/HAc42HXkqVeThQj7JCfm8avpLGRJsIuoD61LUT6pzUNCzoZWaETt2K2HUb86i0obTV5fYR4gRYuH1cXVFN//RvnzZ67quN2ALI8Gr2S9DfBSmZ+1+isA7dEhSAyZu6EkkvrvmlJWSD2XZkHrM8qeYPK6GxnRM+eLGDK4ljJB10/Dc8AwJACcN8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUhX+e48i+tyEHoAPaKFQr3vFsDNVH4E4fDGY5aHc9s=;
 b=In4WjbQxmXf4e7ppQT6hg77vBPcOjOm7QBiazvjoe3NQSKGJp8U224o/PTYDTfOjx9/OTmAz74x3v4KNPKtf7LA1cKPmkgif9knokW50t9ohTk+N2wEx4WLb35LgoZe9eC0wlDL3Ti92uNL0tqCO5c7nDDTU7hvax/j6Payy40E=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AMBPR08MB742645.eurprd08.prod.outlook.com
 (2603:10a6:20b:787::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.11; Mon, 12 Oct
 2026 07:45:27 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0522.006; Mon, 12 Oct 2026
 07:45:27 +0000
Message-ID: <bff63213-a0ec-4071-aa7a-03d0625a0464@arm.com>
Date: Mon, 12 Oct 2026 09:45:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Please pull net-next-20261009
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 nd <nd@arm.com>
References: <00ae9774-169c-45a4-bbdd-89665bd45515@arm.com>
 <20261009172150.GD769217@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20261009172150.GD769217@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0010.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::15) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AMBPR08MB742645:EE_|AM1PEPF000C1AD7:EE_|VI0PR08MB11171:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b0cecb8-bdb0-4a63-0b64-08df2834db5a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|56012099006|11063799006|4143699003|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original: dKCc8+P2ZzJfnlAsDY1I7Hj2ipd+BmEAYsDr1Nm6n+PKHjnE8M01340pLO2dewfGyAcDxmBz93H7y/kkzey5rm3GIYVyMLxImoR5r6kGKOitUzRC6rTtTwZk6UUBz6O++uLe0JuwXUTxFYkhTfmpYGWpbkxgBdp/wCR3g9jt8oow/TqNb0tYDRIHzZIvySAuG2j/xsJM7z7bTnfYsR81upxwQ+idEWAeiuTh18v+hgTo9s5Ss2DWf1qKEs9KSLYoVeVjO5YoCUHdgsn4ZJ3wT1zHaThz21co/7oMeQbbrUV+Q7OAhk5GKhW5A/0UpCnOBIDpKI1GViYrYwvN/BfoMuCTiN+6OWbqLYVieDSf7E09qAQPvG94KBlOo42L89ycHecslrJE+7fnaO+rCGvHh0MHsAorCevqKus2xIwa7TBt7JWaMWE+a2osZnv0fGVyRL9ThmNszZNOq60yiirLnANNB8vctxU5u88+a3zJks4fGaHrkM5R1g5xWCYNMwoiFnelpYnpNDthKm4tjsOknVU3lhby7HNg/ck2gd+b8Crs477UXRzb1+PlvhBPfvtyxqvZ4+pwhEcX9cVBys7QpWQe66hj1Zr1TCXhJl9iBGrHIyGSWVaYtr3CFCicqWy4
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: TgoWnbONapyVxeoiso6y589QxkOAWNOSZvRmz6x5js7SXsasydYoLO9Lfyrn/WqOxaLTCRYKx80PGbZXaZJU8xx63YfmiUkRBDjGTI7ThqRekqA/OYp8AN997sXV8/9CIQWllP8WdR6FNPMxUriKaFBuLMIflFE+LprGqEP8qA02hedOL+1xJ4liIn6kZ9NVaEpqiNw6SMTZTBPIeQ8ahoqFsGAfeVj9vBjNedoNW4wYIz27IF9adXj53JQwibxeTlXokUHUENMowMSx+LlwExSmS5hd+ebF1T7fyhsISyVgxXSFowt8gfzwFLTOUd7V9xLP7xEo7VFSYf4Jc8GUGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR08MB742645
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM1PEPF000C1AD7.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: b065ea94-267c-4366-152f-08df2834c84f
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|1800799024|82310400026|35042699022|23010399003|376014|36860700016|18002099003|10067099003|22082099003|13003099007|4143699003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: skPO3t6PS/nZcX3iQpoBQZYUpGj7UnAG7U2r7kTc/4DFHzm4mhxbxqntOAtDpwIeg1VTqSOpi+8ESAswNaW0sZTmJ5HUN9CsRqxKqdch+enYC6mQVxboEDUUiCQhc9iBfa4oDLGMzUX6+dtlFxcmbS/tzi7s62n4Fe+80yGXXuKrBskdQ3aED+cBAyla5MFZqvoiHbvBL0qLrppDr0qb63/u+WF4SfjFU8pVuXHbKFK4SRl1T1Cb7LLD2uHF+FNQFL3Ckz1X6L5WgZGuN0sPnJw3MJoy7bQnt+BYLgr2T+F772GSfuQ7d0tRcsL6Q0mtm0RfJnos/54NAbr/aFPIPIPTaJSJBJCYFJQfiPKPG/A4oyniIBkJ5XobXNfyW82iopIcp6xQG9SKwkmBNeIm29t5uf8XZoryj+NFyVA/dI2IfLvlFvXJv/76OZLPE/eP7AWHMY56bPAetYhs8VYzhsLSGELw5MCXTwWzWAuS3QrOwddrFBryVVdnras2IrRDoIVMEiz3s1oQtx3kOF4eJ57yeNk7+xzQ6vf91XUvjZFIPlj5E2anNmASdZKnz1v3OidyyHrCa8PGl7/1SLgtRCB69Zv8IG7zPt0+QO/HCgfj2zHO9ks7ULyaFcaXNlNjoXTn8vTUUU2zvHZoPTbjjHiktAhsRrRGo9+b1Mlmtgo=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(1800799024)(82310400026)(35042699022)(23010399003)(376014)(36860700016)(18002099003)(10067099003)(22082099003)(13003099007)(4143699003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XFiUNXdVcuvvvrbvJETB3/SoW0xrZ8O1QkRooVMq+MFJxFvXAR26GETvQHwcmORkFQ19eHKYOvU1ZmIhwjWpqZROEWtFwmKJIAM+8WYmma8700/zuxT8QYPCzP1rTa3LHNd4bYzE59SAnxVpbeyA0auABl5zYxt+PMw5imMZ6J7jwoI7AQ0nyd6Jt6RlsLa8Han5VS0+XQV0uhjbMFOY72qGr+HIrWvgyo79yopNkax+3R6GfO8Sx7hgGax6QrlPaIDJ++N9u9lw8OIJvoepRQGSkUdOvYDSfVqwvi+CuHTLE+1Qniig6fXrE8aEi6x4mSu37xkdyJfrA+PsX6t5O9zBlzxkPQ+Hzl2k857VaGfWI+eV/DMNOchzdPbx4ikiHxciSl8FErhng3NXF0atDhN2XsgQA5Vv9O8WERLEW9/Awq7RJbhYh5QhJyVsTd83
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 07:45:59.3027 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b0cecb8-bdb0-4a63-0b64-08df2834db5a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000C1AD7.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11171
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

On 09/10/2026 19:21, Tom Rini wrote:
> On Fri, Oct 09, 2026 at 07:16:12PM +0200, Jerome Forissier wrote:
>> Hi Tom,
>>
>> The following changes since commit ed869863c7e2aca50d57a05d843830dd843138c4:
>>
>>   Merge tag 'u-boot-marvell-next-20261005' of https://git.u-boot-project.org/u-boot/custodians/u-boot-marvell into next (2026-10-05 10:40:38 -0600)
>>
>> are available in the Git repository at:
>>
>>   https://git.u-boot-project.org/u-boot/custodians/u-boot-net.git/ tags/net-next-20261009
>>
>> for you to fetch changes up to b6aeb2b880fe96b51ece8909cf37a73a7927c4b3:
>>
>>   net: eth-phy: Add reset control support (2026-10-09 18:22:34 +0200)
>>
>> *** Please note ***
>>
>> Commit "qemu-xtensa: Increase the U-Boot memory reservation" fixes a build
>> error detected by CI that would otherwise be caused by "net: e1000: use all
>> RX descriptors". I did NOT send that one out for review to avoid delaying
>> this pull request, but if you'd like me to do otherwise just let me know.
>>
>> Similarly, the test added by "test: net: cover lwIP DHCP autoload handoff"
>> initally failed CI and I incorporated my own fix (see the commit
>> description).
>>
>> *** End note ***
> 
> This is fine. Can you re-send the PR however? Giving this to b4 says:
> Looking at: Please pull net-next-20261009
> ERROR: commit-id mismatch between pull request and remote
>        msg=b6aeb2b880fe96b51ece8909cf37a73a7927c4b3, remote=28ddd369e2f7199539cdefe22ce014c592b890bd
> 

Apologies. I missed one commit, added it then forgot to update the PR :-/
New PR is coming.

Thanks,
-- 
Jerome
