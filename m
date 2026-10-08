Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A009CA600D
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 19:06:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D195281395;
	Thu,  8 Oct 2026 19:06:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pDHbydhZQVzQ; Thu,  8 Oct 2026 19:06:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 88AD7813EE
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791486387;
	b=LBKPbXBTNnad1M7B6tJ3o3/P+jQtTeAxdqfMpYCsMbPIOAlXJ135N1vpc6RVKg0VdHou
	 CiAdWmK+MKV6ViP5MZzSRDouTWm48pAWc0DzfqY9MRVXdEfspvKAzSaI67T9JcRUqkkcS
	 g5O0tQimNuwUXgbkqPiDPWiu1N6dbUj+hWuELbSerssQdB3c9NtRZsewMEgZnPK0fRoLL
	 085VSLHzf4CvYLeSylkk9xPY2ALVqIMFLAvw+4yONZo0gEIUTU//2y5x6YprMmlVn7ZyU
	 ajyY8PQX5jkpsLRrwVvmUBgAmmTUpQnDTOtJzYn7b3oNxUio29UYkuKQ4vTUvaka8nw==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791486387;
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
	bh=CcJgvfunD+bkzhjLxRlzGJUVUZjOEvXujswcX9HGcuI=;
	b=qdYz7u+AWgbGdPHIkkvDj2BU23SsfcTpV+X9D1OTJUFLQO1OTVbdqZBuakW1ABashyKV
	 dL4mOYj4f6OzyAfrVRYAHritfuAL7J7Ni01+Xo2CQqe5pZWdP/tXWRitkO/Ryxz4F+eE5
	 ooxiE9HoQ6bRD4HvGIUIYevIsXBatBklCEZTvfcqB5gRLthNc6V4aNaTDzM2r1tWXUGXb
	 R2fsZnXGh70g17tLIY2atPo0mi8C9NoZr6KuMyua1ov+waT4x95kbkzgiaRhCfiIztNCi
	 ZR7lbmZSxvQ5tzLwRYGnyINofFk8RmFU0vj+4+MEfPsh5p9z3UZfhKDA+i4BVa7thig==
ARC-Authentication-Results: i=4; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791486387;
	bh=CcJgvfunD+bkzhjLxRlzGJUVUZjOEvXujswcX9HGcuI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K+D4/KZWSq/fwcbl9WBwfUTPIlDhbKhqMsE4N4nxhoh0NhqVxlo6ttW1bs6pyaZWA
	 iMgutlJgPdW7+rfSOhm8XT0y8ZOIzIcK3CdlpwMLg+LTzNUxhkUVjMopkpxkX/lD3G
	 8QsSQTffYdUUpRt5P+vP7c+k+lFu1Th6OXj3gj1XjuCwxgpuD6+Yq42t06oPYXdRKk
	 y2hq6c7xjPCHTPQkzoMU7sLeaRZQfzWu3NBNAyAXz8f9VZPxWRfU/eAfCO2S/Ix1r8
	 JQeWPFAbPxMNccL/EAcBP438jO8vm6+6hsmm0zcsOWXTTtAQ4iOMPVxyWWoVLw/WC+
	 p8dYdaFJg+fvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 88AD7813EE;
	Thu,  8 Oct 2026 19:06:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0EF4034E
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 17:33:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 092FC4016F
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 17:33:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nAn4LKc2CdDy for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 17:33:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 97C404008F
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c202::7"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791480831;
 b=MVdMNpZE4K+3V4B4MIYATBL785zdXv97zM7dCME7FprgAqPx/VSINu1j7ds+doKviPkJ
 a5rnxf9iR6vIG+7Fh1BXCB6cCSj0wKd62lZcqfUgZx2njONpY8IyXRYp8IYc4zX5jeQQt
 uiAMRARf4h8tDocjHobpLWvc4zFIuQf0iDHcvyaqZ352gsbz3SvGkEAU+uo/0dFmn+bEW
 qUdgPIH39ozS2IFUi5FyKFHDEw0cmwlLhb6siD05QCrYYihwJ1iWekCYqbO6s7jljX9G6
 N6UgHwAbMgEwn6Z3fwzyNl2Sa+i5M6GD+liPnYYayZOfkG8+TyZauuU5/DOtZkjmVag==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791480831;
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
 bh=CcJgvfunD+bkzhjLxRlzGJUVUZjOEvXujswcX9HGcuI=;
 b=YJRwyMpCLU/q0lhIF4olHAFywZJ9SICAjZz3RYfYp5XIsJ0AHlZhHjYBodpzYFDZ42Bt
 UHR1xYMTrm90OAiVolq51Oh9gLOCSG05FLdTTHoY/K2ISU0VVcmgFv2PzNamSwDY4RlOC
 ZMYXDitD6tWyjKOYeDHFW/i/ZKNzn+6n5jMHEWPxnySnp+xeSzYQDS//ID8D3f6X69E0C
 9E8ARhuiTUhhkbEt7h2ug1HDMIz27+er5IAPmwvRg4UzIT8lvcc5134qVF2R2gdECQbbx
 MZmoJfLGDiFuc4CzUJzyVt2jW2dGHkxlnL+IXvwjm1eWlXQ92aysBEGGSTkDRZN+skQ==
ARC-Authentication-Results: i=3; smtp2.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=oBgoRCiQ; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=oBgoRCiQ; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=harsimransingh.tungal@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=oBgoRCiQ; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=oBgoRCiQ
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 97C404008F
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 17:33:48 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=YNWebTisrxz9NR7ZMLqT86CjzZCuakupr5A/yf5tpKByDI5zf54hb8vvIeroIzoC+ItBOyhyQjjbqGJi3mF9vuXtVkwg/y1mtPc1giKMxuXlVlT7SPIwyNA7MRjBsWtNa58yqVWpKFfbZikGQ068JwP3cpSATWB+awC5Dp8D7FzLgSEYTE8wDGj0OduMaSJAGVgjZp4puBMtXnJMAqYYy1RApQD38Q/N5npCV2TXIOKLBXG0j1J8Pjin9oxUBEg79yAIuleWXVWCn50MoSq5X3LisfrUsjhFp/1VOaxzA8zwxFZgrTgb/1kRgPmSS5O/KZCJVQZFKnn2Xh+sJ4sslw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcJgvfunD+bkzhjLxRlzGJUVUZjOEvXujswcX9HGcuI=;
 b=DiGT71Uud4ejhAkEmg03In71QS3S6+wReGIQf4aCt81LPJiX+/+VOcKDJF4hTq6fkXIIApSjnSN+Sj9x1msHNzxqF+nIni1EQcSRzDERDbT+HN4iw6o2YXSKRgacnR+UDF7i60VZo/pjgaB0Ps7/reEF78zaMpmgGyTqx3n0B8oAekPXKiS2msx5wXI7GWdp4lWXa/XhHGx55WkSgK4gnCojXpt2wWD9TYwtzweepeXC7+YsZi1lJYOtk6VrtctByDQ+7sW24PhwE6BRQI65dINR6MsnmHksSokhQeks72jC7BEf/85a+VOi70dRej56GrKx6/Ja4+ZtwieHCHkgcw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcJgvfunD+bkzhjLxRlzGJUVUZjOEvXujswcX9HGcuI=;
 b=oBgoRCiQErCyLnSKaFyWhZOf/IYdcJGJ2Kx0d+BeghBaKlfzpx3u8p36tpiIUlX3StZ4btk7SQIPmRFxrvd0ADv1SDTORL7QHRZM/pYClxROoRl0YE8+E2W6NuQXmB0nHxfGY0hVl6VHwbQkGD/YoDCJrEr9mExhLg7zqGztiNM=
Received: from DU7P190CA0013.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:550::35)
 by PAVPR08MB9771.eurprd08.prod.outlook.com (2603:10a6:102:31f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.6; Thu, 8 Oct 2026
 17:33:37 +0000
Received: from DU2PEPF00028D0F.eurprd03.prod.outlook.com
 (2603:10a6:10:550:cafe::73) by DU7P190CA0013.outlook.office365.com
 (2603:10a6:10:550::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.21 via Frontend Transport; Thu, 8
 Oct 2026 17:33:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D0F.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Thu, 8 Oct 2026 17:33:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZqQ9svGCjorjVQ7WN6WFtDSmoCMM8clw/gRIypgyKHc4tRNkwm5cS/KDiGn736SNAY4naw3O1BwysYWuSTIhtkxUDu7enO2Gw5pzL4eblgj4NYCM9DTfBzEI69XaqVjFJF+h13yTQH+/hfFBRbB5OtU13D5861km8VpDmbQdgWlIqTdZZFRfuPoMLTlV0vL/Y5lT9nc5H+sODKDIZLbZQMhF8ngbVE9ZT4/d9Ll5KybE89kAAxK8zr+GeZ1fOeNf5MTKQaZDxKf7nRXG8O9pG8ek+lWrRI+pDxBAdhra6ZIKfx/QL/D1oEElmyY89DKXZJCQZ6dG6cfumz4ocnlWDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcJgvfunD+bkzhjLxRlzGJUVUZjOEvXujswcX9HGcuI=;
 b=kMupnsUNG3WeMOsnMdpZ8yHNFC4xW3c0sWhN8dpx7zgXCX/AQ76ahx7dkVMBzZq8C2/ZxoeV4kLoU1neUC4fcAw1CMpf8Je2d28soPpxu4UNSUx5DNOZ0MhTMh4TWyEFE40ZVBPseDGHiRDIsBwWpo0kZguLyXocS5ihV5XzmWVbickhOih18i3kLPlCTNLY7WWMVYsPKbOIqjmDl3GRgorTHDqg05DRces0ID6klmLaJ1RgQjwIKg1Z6yiXjHy7u0xY925CtH0LRHUjHQhXYkAbSi8u3TnoQduBr4C55HTe+ZJKO6zzfwdrUjPFv7LAZ7kWV99QF6cLlpq7s73hXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcJgvfunD+bkzhjLxRlzGJUVUZjOEvXujswcX9HGcuI=;
 b=oBgoRCiQErCyLnSKaFyWhZOf/IYdcJGJ2Kx0d+BeghBaKlfzpx3u8p36tpiIUlX3StZ4btk7SQIPmRFxrvd0ADv1SDTORL7QHRZM/pYClxROoRl0YE8+E2W6NuQXmB0nHxfGY0hVl6VHwbQkGD/YoDCJrEr9mExhLg7zqGztiNM=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM8PR08MB5620.eurprd08.prod.outlook.com (2603:10a6:20b:1c6::23)
 by PAXPR08MB6576.eurprd08.prod.outlook.com (2603:10a6:102:15a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 8 Oct
 2026 17:32:52 +0000
Received: from AM8PR08MB5620.eurprd08.prod.outlook.com
 ([fe80::618d:6218:6962:17ad]) by AM8PR08MB5620.eurprd08.prod.outlook.com
 ([fe80::618d:6218:6962:17ad%6]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 17:32:52 +0000
Message-ID: <55e2793e-33fe-43da-a509-8e64aed0c432@arm.com>
Date: Thu, 8 Oct 2026 18:32:50 +0100
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
Content-Language: en-GB
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
In-Reply-To: <CAC_iWj+VHR_vGb8EYqR7tzLXihZLW586BjnjPsKswf9uDnngEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0648.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::19) To AM8PR08MB5620.eurprd08.prod.outlook.com
 (2603:10a6:20b:1c6::23)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM8PR08MB5620:EE_|PAXPR08MB6576:EE_|DU2PEPF00028D0F:EE_|PAVPR08MB9771:EE_
X-MS-Office365-Filtering-Correlation-Id: ef30e500-5c12-49e8-a80b-08df25624958
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|11063799006|22082099003|4143699003|18002099003|6133799003|3023799007|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info-Original: b+k/v4o/3MidLxAUfD3P9GI/MT27dYX2cdsKkcueiq1yQ50cBxXuAHYR7oH01Lt2OykQnKcsdDErMtDjQOw9cEuVZ/KupBvIDt9NSwxs8o03eC/m6kq/ksfXiTrJo6Eo+lLB+/yhhjPh1HxIsk3LTbJ1Z6SdjE/MrYWPhriq9mqGBfRwce5DCfxCSi2yygT31ho63NRfpjpPswXQN3/2ctpRqxQtwh1vCLby7mtvk7V+Ld4CXo86OT9rck5YSEPgrYEPHOZZafDgua8eiUuxa9jrw3vPzzQWGfttoelx7Qeer+KZciOsUZEf/gkKfwdg40JdVkp1+MjphKSg9F9d9OwnWoOCXdNtJwaSt9n7/XSVtJf+zQSkHB468yQL9EbUhP38TLA3882G+7wFOkZXY15meXCgEt8q4RzcmBSnV7lW0xY3sMKzo0KU+vaLV0gLMGRzwTMtlBln0VEkYf9WfD7c+DU8yPZfPj36qGW1DFWwGzSh6p8+MRK7BqHSL9c3JOWm3/WXfayqI8ttQ+L1UXqJSxdIZyyP6YA0EOAV11INhya9qPCaoNg8fou8AHgcSk2dhtJJIC7vaNUl+XkXOuMBjRji7cRp5m0JiAxDxfid0dPywiqxp6QfeZCsX4CgVYUmcR5MCssAAMNDs69Hryf0ncqeydBnI88VYnsiMoI=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM8PR08MB5620.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(11063799006)(22082099003)(4143699003)(18002099003)(6133799003)(3023799007)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: Ddbeq3du1RraTwJBJ02vcLmBa7TCm/cprZIxIyVX2wriUzhuRPfH9zQemIzyO3UO57+kz3stTYjdz+oN8KOMEMHRiA601O5jpJ+pPis/D2yk3yMRFSC+pOjzCIvfhWUfNdm1XfD4q/Vao+0Ax62RvLgKg27xcEO+ZYBt3mxEhezzenUoteANLkNdhIem7rdDqtF4vAnWm5Kr8V+LKCdCZVT8eQX1v+Ko9cYvkicIrvUAASXVeWOuW5c94SukWij6FGQTmKtI7zs8YqaVuhhHQ2uOLrfs1Zv+CT0TduxKK33srhQXQ/kTbx5iCOCaXpc2j9B505qy8KJOrb6pCQvtWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6576
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028D0F.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: d9add6ed-5492-4b19-df82-08df25622dbb
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|35042699022|36860700016|14060799003|6133799003|10067099003|18002099003|22082099003|13003099007|3023799007|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: OpuvLuBR8XqeNzknAtMMLO3tEpW4yeWS2WQD1yzjxiL5+F+VccpwnbMxIl9vj27+n6XhAxKh7LBPHkabZIyPYVH2HI7WmjeFfFdVkJcObEFpDccMd+gYQmwXAXQ3fyUFb8d+9YEZovibrAFR9upl9oC0zK4mYaF8dkLbz2AGFw0X/ZKOx96nVo/XRhJ1YC47Cu9+4LuVkZF0/4+ZEunCPMeOgKEglecK8Nk+RbdFnaZUlNAmcULab9EYd6l70t1QGIB9VOGKGAy9E8SZIgw5GNrvXp+P7YZ64HyyKcXcXFL4xZqVxHmsfT59MwupcK4QAgJSWB3VnYiEn4YHCe8p1m0w9GJREYi2URtHK20KOzm+C4BDFfH8LhXXV5gHb8AJYFyPg0Fejn+/xlwaIA59R4MK2wFrzHJfVyhhgDCdix8nvkZr4GUtdkWMl9HkXxg5+xg8j5qcihuFKtvyHrarYULo4O8AMV2p9Wsk89JO1TWXn9/2Z8DW+V+7yrVY0L/jV16ulE+niIUh5F2++vc35UNUC1M8LfNR+1gfbLKHGCCZu0p+78DWBp6vTTXMzlNG1AsMdFRzIvQenA5+0bjpvdu5n0FxaHz9WM5ENVci0ju2jC/Q5eygWxtrFuMqxySBnA6VpQHh6pWsDVcc2azC7IPiqmGTuKY2zbnwBLC51VKQXG7n1RsPv3fbZiaFo2NfFv2Nbzg4narep+rESZesRw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(35042699022)(36860700016)(14060799003)(6133799003)(10067099003)(18002099003)(22082099003)(13003099007)(3023799007)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: H4mtpwiUenRp2jLtxAy0OyEyruyX3mul4tGK420jTW2yh8eItx4vDXL04ezb59+mBB0gN1CW2GHudZPYPAfto00ojBS4IZ5hQKiBN3QLlKwO54rea5JIbmqMM0AGYioCs/JdwaGeLOjGE0DGjD+aDDvYhHLzig6GcbOtZ5a3XUXWTUQglYI28fRYi+pXAIM4NlRqL9vdlooCMgdim6EL8RDVjswDruC9d/YebDGn+tOrzQEyXmigoV7EdDV2XsPnPma64CeguGTiFX+dDyf9pc7aI/O6lkpRHTSTTxbVn+fi4OxYzgkHik/8v9pF9IMoV4Q6TQKYCWkIJ7TkpKvClcus8IohAYGF38JwcXcbM73LzhOfkeUc6PsPAkF7sF4fWolhpmL9BT5XYm2pdocr9qodXjFx4ubED7gkRTh9vgipXpQb0xYEyrKmfkcuUkpy
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 17:33:37.6392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef30e500-5c12-49e8-a80b-08df25624958
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D0F.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9771
X-Mailman-Approved-At: Thu, 08 Oct 2026 19:06:26 +0000
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



On 05/10/2026 14:15, Ilias Apalodimas wrote:
> On Mon, 5 Oct 2026 at 16:06, Harsimran Singh Tungal
> <harsimransingh.tungal@arm.com> wrote:
>>
>>
>>
>> On 18/09/2026 19:20, Ilias Apalodimas wrote:
>>> Hi Harsimran
>>>
>>>
>>> [...]
>>>
>>>> +                                                       efi_uintn_t na=
me_size,
>>>> +                                                       const efi_guid=
_t *vendor,
>>>> +                                                       struct var_che=
ck_property *var_property)
>>>> +{
>>>> +    struct smm_variable_var_check_property *smm_property;
>>>> +    efi_uintn_t payload_size;
>>>> +    u8 *comm_buf =3D NULL;
>>>> +    efi_status_t ret;
>>>> +
>>>> +    payload_size =3D sizeof(*smm_property) + name_size;
>>>> +    if (payload_size > max_payload_size) {
>>>> +            ret =3D EFI_INVALID_PARAMETER;
>>>> +            return ret;
>>>> +    }
>>>> +    comm_buf =3D setup_mm_hdr((void **)&smm_property, payload_size,
>>>> +                            SMM_VARIABLE_FUNCTION_VAR_CHECK_VARIABLE_=
PROPERTY_SET,
>>>> +                            &ret);
>>>> +    if (!comm_buf)
>>>> +            return ret;
>>>> +
>>>> +    efi_memcpy_runtime(&smm_property->guid, vendor, sizeof(*vendor));
>>>> +    smm_property->name_size =3D name_size;
>>>> +    efi_memcpy_runtime(&smm_property->property, var_property,
>>>> +                       sizeof(smm_property->property));
>>>> +    efi_memcpy_runtime(smm_property->name, variable_name, name_size);
>>>> +
>>>> +    ret =3D mm_communicate(comm_buf, payload_size);
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>>  static efi_status_t get_property_int(const u16 *variable_name,
>>>>                                   efi_uintn_t name_size,
>>>>                                   const efi_guid_t *vendor,
>>>> @@ -768,6 +800,49 @@ out:
>>>>      return ret;
>>>>  }
>>>>
>>>> +static efi_status_t __efi_runtime get_property_int_runtime(const u16 =
*variable_name,
>>>> +                                                       efi_uintn_t na=
me_size,
>>>> +                                                       const efi_guid=
_t *vendor,
>>>> +                                                       struct var_che=
ck_property *var_property)
>>>> +{
>>>
>>> The changes between this and the non-runtime version are limited to a f=
ew memcpy/memset calls.
>>> It's pretty easy to only keep the runtime version and get rid of all th=
e duplication. Same
>>> goes for the set_property_int()
>>>
>>>> +    struct smm_variable_var_check_property *smm_property;
>>>> +    efi_uintn_t payload_size;
>>>> +    u8 *comm_buf =3D NULL;
>>>> +    efi_status_t ret;
>>>> +
>>>> +    efi_memset_runtime(var_property, 0, sizeof(*var_property));
>>>> +    payload_size =3D sizeof(*smm_property) + name_size;
>>>> +    if (payload_size > max_payload_size) {
>>>> +            ret =3D EFI_INVALID_PARAMETER;
>>>> +            return ret;
>>>> +    }
>>>> +    comm_buf =3D setup_mm_hdr((void **)&smm_property, payload_size,
>>>> +                            SMM_VARIABLE_FUNCTION_VAR_CHECK_VARIABLE_=
PROPERTY_GET,
>>>> +                            &ret);
>>>> +    if (!comm_buf)
>>>> +            return ret;
>>>> +
>>>> +    efi_memcpy_runtime(&smm_property->guid, vendor, sizeof(smm_proper=
ty->guid));
>>>> +    smm_property->name_size =3D name_size;
>>>> +    efi_memcpy_runtime(smm_property->name, variable_name, name_size);
>>>> +
>>>> +    ret =3D mm_communicate(comm_buf, payload_size);
>>>> +    /*
>>>> +     * Currently only R/O property is supported in StMM.
>>>> +     * Variables that are not set to R/O will not set the property in=
 StMM
>>>> +     * and the call will return EFI_NOT_FOUND. We are setting the
>>>> +     * properties to 0x0 so checking against that is enough for the
>>>> +     * EFI_NOT_FOUND case.
>>>> +     */
>>>> +    if (ret =3D=3D EFI_NOT_FOUND)
>>>> +            return EFI_SUCCESS;
>>>> +    if (ret !=3D EFI_SUCCESS)
>>>> +            return ret;
>>>> +    efi_memcpy_runtime(var_property, &smm_property->property, sizeof(=
*var_property));
>>>> +
>>>> +    return EFI_SUCCESS;
>>>> +}
>>>> +
>>>>  efi_status_t efi_get_variable_int(const u16 *variable_name,
>>>>                                const efi_guid_t *vendor,
>>>>                                u32 *attributes, efi_uintn_t *data_size=
,
>>>> @@ -1001,7 +1076,7 @@ efi_status_t efi_set_variable_int(const u16 *var=
iable_name,
>>>>              var_property.property |=3D VAR_CHECK_VARIABLE_PROPERTY_RE=
AD_ONLY;
>>>>              var_property.attributes =3D attributes;
>>>>              var_property.minsize =3D 1;
>>>> -            var_property.maxsize =3D var_acc->data_size;
>>>> +            var_property.maxsize =3D data_size;
>>>>              ret =3D set_property_int(variable_name, name_size, vendor=
, &var_property);
>>>>      }
>>>>
>>>> @@ -1078,7 +1153,7 @@ efi_query_variable_info_runtime(u32 attributes, =
u64 *max_variable_storage_size,
>>>>  }
>>>>
>>>>  /**
>>>> - * efi_set_variable_runtime() - runtime implementation of SetVariable=
()
>>>> + * efi_set_variable_int_runtime() - runtime implementation of SetVari=
able()
>>>>   *
>>>>   * @variable_name:  name of the variable
>>>>   * @guid:           vendor GUID
>>>> @@ -1088,11 +1163,69 @@ efi_query_variable_info_runtime(u32 attributes=
, u64 *max_variable_storage_size,
>>>>   * Return:          status code
>>>>   */
>>>>  static efi_status_t __efi_runtime EFIAPI
>>>> -efi_set_variable_runtime(u16 *variable_name, const efi_guid_t *guid,
>>>> -                     u32 attributes, efi_uintn_t data_size,
>>>> -                     const void *data)
>>>> +efi_set_variable_int_runtime(u16 *variable_name, const efi_guid_t *gu=
id,
>>>> +                         u32 attributes, efi_uintn_t data_size,
>>>> +                         const void *data)
>>>>  {
>>>> -    return EFI_UNSUPPORTED;
>>>> +    efi_status_t ret, mm_communicate_ret =3D EFI_SUCCESS;
>>>> +    struct var_check_property var_property;
>>>> +    struct smm_variable_access *var_acc;
>>>> +    efi_uintn_t payload_size;
>>>> +    efi_uintn_t name_size;
>>>> +    u8 *comm_buf =3D NULL;
>>>> +    bool ro;
>>>> +
>>>> +    if (!variable_name || variable_name[0] =3D=3D 0 || !guid)
>>>> +            return EFI_INVALID_PARAMETER;
>>>> +
>>>> +    if (data_size > 0 && !data)
>>>> +            return EFI_INVALID_PARAMETER;
>>>> +
>>>> +    /* Check payload size */
>>>> +    name_size =3D u16_strsize(variable_name);
>>>> +    payload_size =3D MM_VARIABLE_ACCESS_HEADER_SIZE + name_size + dat=
a_size;
>>>> +    if (payload_size > max_payload_size)
>>>> +            return EFI_INVALID_PARAMETER;
>>>> +
>>>> +    ro =3D !!(attributes & EFI_VARIABLE_READ_ONLY);
>>>> +    attributes &=3D EFI_VARIABLE_MASK;
>>>> +
>>>> +    ret =3D get_property_int_runtime(variable_name, name_size, guid,
>>>> +                                   &var_property);
>>>> +    if (ret !=3D EFI_SUCCESS)
>>>> +            return ret;
>>>> +
>>>> +    if (var_property.property & VAR_CHECK_VARIABLE_PROPERTY_READ_ONLY=
)
>>>> +            return EFI_WRITE_PROTECTED;
>>>> +
>>>> +    comm_buf =3D setup_mm_hdr((void **)&var_acc, payload_size,
>>>> +                            SMM_VARIABLE_FUNCTION_SET_VARIABLE, &ret)=
;
>>>> +    if (!comm_buf)
>>>> +            return ret;
>>>> +
>>>> +    /* Fill in contents */
>>>> +    efi_memcpy_runtime(&var_acc->guid, guid, sizeof(*guid));
>>>> +    var_acc->data_size =3D data_size;
>>>> +    var_acc->name_size =3D name_size;
>>>> +    var_acc->attr =3D attributes;
>>>> +    efi_memcpy_runtime(var_acc->name, variable_name, name_size);
>>>> +    efi_memcpy_runtime((u8 *)var_acc->name + name_size, data, data_si=
ze);
>>>> +
>>>> +    /* Communicate */
>>>> +    ret =3D mm_communicate(comm_buf, payload_size);
>>>> +    if (ret !=3D EFI_SUCCESS)
>>>> +            mm_communicate_ret =3D ret;
>>>> +
>>>> +    if (ro && !(var_property.property & VAR_CHECK_VARIABLE_PROPERTY_R=
EAD_ONLY)) {
>>>> +            var_property.revision =3D VAR_CHECK_VARIABLE_PROPERTY_REV=
ISION;
>>>> +            var_property.property |=3D VAR_CHECK_VARIABLE_PROPERTY_RE=
AD_ONLY;
>>>> +            var_property.attributes =3D attributes;
>>>> +            var_property.minsize =3D 1;
>>>> +            var_property.maxsize =3D data_size;
>>>> +            ret =3D set_property_int_runtime(variable_name, name_size=
, guid, &var_property);
>>>> +    }
>>>> +
>>>> +    return (mm_communicate_ret =3D=3D EFI_SUCCESS) ? ret : mm_communi=
cate_ret;
>>>>  }
>>>>
>>>>  /**
>>>> @@ -1129,7 +1262,7 @@ void efi_variables_boot_exit_notify(void)
>>>>      efi_runtime_services.get_variable =3D efi_get_variable_runtime;
>>>>      efi_runtime_services.get_next_variable_name =3D
>>>>                      efi_get_next_variable_name_runtime;
>>>
>>>
>>> All the get_variable*() calls used to point to the function from efi_va=
r_common.c.
>>> By changing this you are breaking the runtime case for OP-TEE since now=
 we will get
>>> EFI_OUT_OF_RESOURCES.
>>> There's no easy way to fix this at runtime. For OP-TEE the kernel might=
 replace this call
>>> with an internal OP-TEE call if it's part of the firmware and announces=
 it can provide
>>> EFI runtime services. However, the default uuse case, which we don't su=
pport SetVariable
>>> at runtime only needs to keep working.
>>>
>>> I'll post a script next week so you can replicate and test this in QEMU=
 with OP-TEE etc.
>>>
>>> Cheers
>>> /Ilias
>>>
>> Hi Ilias,
>> Can you please share the script, so that I can replicate and test this
>> in QEMU with OP-TEE?
>
> https://github.com/apalos/efi_optee_variables
>
> make run-fip should give you a QEMU command line. You just have to add
> an OS image to test.
>
> Cheers
> /Ilias
>>

Hi Ilias,

Thank you for sharing the repository and instructions.
I tried the OP-TEE/non-FF-A QEMU setup from your repository and it
exposed a regression in my current series.

With CONFIG_EFI_MM_COMM_TEE=3Dy and CONFIG_ARM_FFA_RT_MODE=3Dn, Linux hit
an EFI runtime paging fault when booted through U-Boot EFI. The reason
was that TEE ExitBootServices() path only installed runtime variable
callbacks inside the CONFIG_ARM_FFA_RT_MODE path. That kept the FF-A
case working, but it accidentally stopped the non-FF-A OP-TEE case from
switching to the existing cached-variable runtime callbacks.

I tested a fix by keeping the FF-A/MM runtime callbacks only for
CONFIG_ARM_FFA_RT_MODE=3Dy, and using the common cached-variable runtime
callbacks when CONFIG_ARM_FFA_RT_MODE=3Dn. To make that clean, I plan to
add a small separate commit which moves the common runtime
QueryVariableInfo() and SetVariable() helpers, plus their shared
SetVariable() validation helper, from efi_variable.c into
efi_var_common.c. Then, efi_variable_tee.c can select either the common
cached-variable runtime handlers for OP-TEE/non-FF-A, or the new MM/FF-A
runtime handlers for FF-A runtime mode.

With that change, the same QEMU setup boots Linux through bootefi and a
small initramfs, /sys/firmware/efi is present, and efivarfs mounts
successfully.

Does this direction look reasonable to you?

Regards,
Harsimran Singh Tungal
>> Thanks
>> Harsimran Singh Tungal
>>>> -    efi_runtime_services.set_variable =3D efi_set_variable_runtime;
>>>> +    efi_runtime_services.set_variable =3D efi_set_variable_int_runtim=
e;
>>>>      efi_update_table_header_crc32(&efi_runtime_services.hdr);
>>>>
>>>>      /* Record that ExitBootServices() has been called */
>>>
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
