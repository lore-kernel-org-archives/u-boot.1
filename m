Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A353BC88E75
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 11:50:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 093BB80BF0;
	Tue, 15 Sep 2026 11:50:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0A3A65YP4Bo9; Tue, 15 Sep 2026 11:50:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D71AE80CC3
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789473052;
	b=hJwDWc7c+vaAZBxSF2u+SUdhjneqv2rlUNmJx0gTBg8hIXr+X5RopDhPTUuFxYfnBBp6
	 IvTItd0YBHXbUxbYpy7OL9YA8UAlAHQVF2hKlG7BKl71SxLX4zM+7qjyKFudH4RfQsEbx
	 upVKhhZPmymaNt2a7LWHx2eTUCY33xJa2G54uBRHCDGlu7F9pBBZvXBb5GN+VN9n0FnUS
	 ZsHAXTJDzq7OsvSDZzOvIVFXH+n3TaK1P2onKIOZVwWDLYENWsoK32mNXuKVzdk0LG8FY
	 RCHtGTem7yg79rRrnrLiTkvb2+73T5e1Vt62y46+SlQvjMBOY8RiW/BO/0rIMvpR+/Q==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789473052;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:Content-Language:To:Cc:
	 From:Subject:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-TrafficTypeDiagnostic:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=adSYfLuBSECSNcHrI5LY8YGskka/dP+65Dv/kgYDV2I=;
	b=fBDkpNiasE6aV1idgr3LZG3S5GKb8XC8mS5lKFpqeBiOyrQqneDMLl8ixP5nHNrMJQb2
	 S1QwQXFflI0y3iW96iYgFcZnfSTaIh/m5S8k+KETvwQFtPtCtCjWcCVn9gSXVI9x0UoNv
	 1Jwu7SZ40APgrHHX5H+Pe3HPP7Qb5GtHw7x9kVlXGN5CCHSjGIoZu6FTkHFCF8QMA+FqU
	 skFWbzKEBApg5Osq+IOJzBWUACTheyF/xMc217Hm66o9tp89egT2LkxyFk4GSFwg9paeP
	 nnPfU+dHM5G8+Ng44SFS/LRLvMp34Sg+H9qT7mzg5ytYRNxdLkO1GFW4OGMV+w5US+w==
ARC-Authentication-Results: i=4; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789473052;
	bh=adSYfLuBSECSNcHrI5LY8YGskka/dP+65Dv/kgYDV2I=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PqDF2C3uojfRmo4TeXz1cZiL2DjeezlBvYjNVQf8QpV2bEkqpkVoFmJL96GC3NX3h
	 nNpqxaRQxwDnfER56kA0TQUFoTe3CHpgWdTo46akoNcs9Uq1lqHiMLu+F0aWUSMBPf
	 utT+eIobm4ZUVIO7zwgZaowrhBy/ePO1GXjLEHEf4iLXpnpTMoGunkE9qclIZKzH/G
	 5C+0SH1Zxnkkrz5gmcD5MrUQCd83ihGn3jHZtQBPmkMFaAqeobKLUdo/w6hEX3igHj
	 3PMIeQ6AYLXy60w+xM1DF+SixnaYtjHveLOkgeFM3FdwGgm2fszdSJyX+ZTPRG4Q82
	 HDqGzG67WQF3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D71AE80CC3;
	Tue, 15 Sep 2026 11:50:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2EB4B362
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 11:50:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2076A401DD
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 11:50:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JrXn_ggg3Qhk for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 11:50:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E43444002B
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c201::6"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789473050;
 b=DtI6+eq9AJ3fdM9uhYMLQIyn0dXXvbVNECJzbes4jPyiU5TTinO/7MeQsxQYwDSMLRnS
 JWsq3iVjDbipd/NHPAu72PhyJqtwuNJSIHWeiFir3+0EffQktKad/ax8UvQTsORcsQ/UH
 CLz8H5T/PdepQeQjwfkB90mT26uwnlkxUpqLFBa1eLyQDeBDlsuHa/oRgnGuZgxvTPvjX
 nKlAwkX+LPR2fcPh2c2PuG9tCc94ss0+2O7YO1kNiRMEISvC0Gke93pB6BPQ/REZg6yvR
 9dWsEwDLWbhiiM0kvBQx9C2BhLMWOeJgnyBNjtzPUp2ppvVhvbArak4gaURUrUYl89g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789473050;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
 DKIM-Signature:Authentication-Results-Original:Received:Received:
 Message-ID:Date:User-Agent:Content-Language:To:Cc:From:Subject:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=adSYfLuBSECSNcHrI5LY8YGskka/dP+65Dv/kgYDV2I=;
 b=C+AuYX1Visgn2zlZn6Ly8RhwDQPEdFnR49JzJ1DxxGcrCheVjdV7UGHr1jWj1gX3chje
 4ez2CuQrPepFMN/RKUx9LqSfLagr5rwNmEZ2dgKaFbsy8M/HNHJ2Q9hnUE6xN3uY1x0lb
 RvObRuo0ER4PKbfO9LWI+A/zFA+HIFmE4uYeHwDIXlUb0nHrk7BD+hXFxmQxmLiI4b0xi
 7/ULt/Iagk+c5JTx8P0HXQootehJByZrsbLWXiVN1iFYG+8m++0iAV5/x9B5lRL1fNti+
 RRQes1C4d2gcCs/vFomtblAeAdQCVAQ2M//nNgJboeGhD9mtLn7ACOm+dzj4kmvytuQ==
ARC-Authentication-Results: i=3; smtp2.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=M0OSuDkP; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=M0OSuDkP; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=M0OSuDkP; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=M0OSuDkP
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E43444002B
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 11:50:46 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=MSeID9GHJ3+0ptq4IvUjyEAc6nxdnCMqAbp4A0rtw9AwPN5S2UwjGdOIthM/gR11w8DVwAEATSH4PGxlL0kBvy43tMXY1bzblRQJo3GJ2Jydw1mEaANwrFIBTfPJYlIYCQFbYbF3vHiZwBGhjq+dItfwCTmP8fLsKtNv+YgseQoIzo4FxYdyMW415QKqAufIEZK6JvwmY3SzPgDOukqFG4PFL1uH3vx1pCiaxVK+BLuNY1XexfAfpI9VW3krEUBhtUNL0+dAhkeGbbtmXYcYKYQL2WPVXUSvoTXEzuVgfVAzAVb5YTqaFHkzRHR2z+xZ/bTdew/pI7qJEBY0ue7IbQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adSYfLuBSECSNcHrI5LY8YGskka/dP+65Dv/kgYDV2I=;
 b=KRDVd8Vtql4G8/xncqQsCDJQoFJkLAPdMYn9LASYxaUexi1O0cnPueD02Hssp9Kheh5LWAD9AWo8bBv21vo91F6zMPWtjbm9g8ASRESh8yR4ujrnHZXNYQDrGYX9QvwOFMtPNgJlN7IxwUnn56iSB85H+kZxIr+KTHhqS3ehg/BQ4U88khtyME93/Su8CemgIatHUd519itHPwsArikV2yp4Vgp18OBjPhpyEMxW8BHHcCfy4qOOJDT0Cly4rvXa8JHjqL2wJTuGB8hT5ZUe36Zub0elssE48HzKto+KCoMnHzIT9mAdMksZv85qiwwgeabgq61pEZvIdKOhI8x3jg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=konsulko.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adSYfLuBSECSNcHrI5LY8YGskka/dP+65Dv/kgYDV2I=;
 b=M0OSuDkPVYJ3s4FJVCcWKMPmGy/LVS1o1vRQU7FquYu7ufQ3VDG4UsHzIZBBmzN8jqp3QB9lO+M7trvkyZpzjrmd6mySImQ7RaCCoULn0MAnLA1yc9H3EBf21gGdFXTaMCO0PeQvzVDylf7tJxGEYZH58bIVGbZRNdUwps+lm3g=
Received: from VIUP296CA0077.AUTP296.PROD.OUTLOOK.COM (2603:10a6:800:349::6)
 by AS2PR08MB8503.eurprd08.prod.outlook.com (2603:10a6:20b:55e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 11:50:41 +0000
Received: from MI3PEPF0000855F.eurprd05.prod.outlook.com
 (2603:10a6:800:349:cafe::1c) by VIUP296CA0077.outlook.office365.com
 (2603:10a6:800:349::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Tue,
 15 Sep 2026 11:50:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF0000855F.mail.protection.outlook.com (10.167.240.27) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Tue, 15 Sep 2026 11:50:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2pBQqDULrL20aePWRwrT0Z/f3szLM47VQfMMPAXSy7SUeb5GDo5dE7dx0DQhlyX97zCYPgBi24lDHqeQt/Qh5ZsWsfof/3M23Zn67OEwVIBKYQvTvh2qQSrW5X1IFxFvL/AwhVBzeMn46KXWedlQY77xqUkjlMCisz6j6It0+Oh4m8jHK5NrMSE8L16ZljK8p/s9K6bXfyIvi/v+lvQXr3Ru8PdxClfB/8KYuSDqKrQGTdPZ7uzW6m/d4NrkRsnZd1DjAyx5iDFPe88mVEuF6yR3vqSK5dEVW4jubA2fq7XPMnV3DnsE7cug3AlktTw7Tk64CZ5VFK7kN7N4+D3XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adSYfLuBSECSNcHrI5LY8YGskka/dP+65Dv/kgYDV2I=;
 b=rYhR0E/ny89BckDu9bcZHTkYvxlJUtDELrJipJgoY+Sr7IqX0fcsxJduYM738KCarFohzoZYIyqq842VLSGOe+zVh5h6nEx/Zt9EMgcZzoPKgJ31wOm7sOFkO9c+5h+ahVG5C4dbKD6Yqk4HR05Cx4jgzP+XJjJVy6ZqsnC6NwLudQYFEYjCIKMyTW4CMdMJtckpGvFqCbzsidBj+pPZi4+u+h159bxzs3FUi1aGJRT1LUHq0otHlimhR2KMv4Wi4eg+knF/QlTkN0LtU0ds/qM8BXT+0QnuaTkI6CZlDwrmbI7RhfCj8aA6SYmihnZFv0C3hSNBBU5jaHthXp5QMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adSYfLuBSECSNcHrI5LY8YGskka/dP+65Dv/kgYDV2I=;
 b=M0OSuDkPVYJ3s4FJVCcWKMPmGy/LVS1o1vRQU7FquYu7ufQ3VDG4UsHzIZBBmzN8jqp3QB9lO+M7trvkyZpzjrmd6mySImQ7RaCCoULn0MAnLA1yc9H3EBf21gGdFXTaMCO0PeQvzVDylf7tJxGEYZH58bIVGbZRNdUwps+lm3g=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by PR3PR08MB5836.eurprd08.prod.outlook.com
 (2603:10a6:102:8f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 11:50:07 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 11:50:06 +0000
Message-ID: <c7c2bbf0-7b5b-4cc6-9856-c0770a02da58@arm.com>
Date: Tue, 15 Sep 2026 13:50:06 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 nd <nd@arm.com>
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Please pull net-20260915
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0198.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36d::14) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|PR3PR08MB5836:EE_|MI3PEPF0000855F:EE_|AS2PR08MB8503:EE_
X-MS-Office365-Filtering-Correlation-Id: 7403c106-1b28-4410-d647-08df131f90f6
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info-Original: hNXfjonsu4AQ425lScTbpT8UpTmM1xkCzntiqW04t3YPUZmTzVvIk3Zs5RiARBNKNtU3XQKFzxSPum49i7WFzJVRbsMb7c8Gtf6Dq0tWLK5EBqCfBj35bjGd3LDE3OXiFbgVHLlNECI6XZ6UwdS/hZHjUW3L+f2wfWcdnqGX8novcTOY6AwrRbTs9Y7ymVK8egLr9vLriqoy/z29v0hMk1M3et0AEtTej3KCFT+0puKGWEJxsbrEnz8Tj+ff8i9vM3FWeolzHc0S/G6sHnAZgaC1DbvfcoyMvQEdQW+V67GPygkPegh0x+BEQLqEOE/PKS92ZfwAamoXEeqezWaNCgzF2pWV5urq31ilI6Y17Mwp0nTAj44vNRa7Fp7Lt6+imDdThmS1DJLVsibFl1wgoVCVeNQhebJwVvhOzFUSToBH5V7bZAlDk8T4kTGNP4uOXlxHtkNF7fRD3IVYDrJFPYtxfYdikr/c3ing4fjJm/AwtN8Wx1p9O5ef5uSxp0FcqFgVfEvdHdIKo+xpUN3qS2oLVTi1pVA/jmu7VqIQL69kXaNeBjZxWqwBmkyIugzENvebISnMZ+oxejKKVwEJcprzVb4IqpAOkv/Yrt8OR+XH1dJgPL6hOBtAWC46Gghr
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: fBDY9gbmq4/dat4MV8TbR26F/w4kbQjo1j1a5WZQlT8EX1FZ8xqP8TkeX9oROemZZYW7fD6sxOJ/2BzTcgvJhah7vJnVOXLEHY3WkEBOIcNCVk4HuFXRxsfga4wOr0G6WwxG2DYkiBpP8P8Wmanx3f5/ifUMQ2RJCrElUpTIXhYw3HS8D4PEIm44XQmKzAfMbg8Q+Y6H+93W7CXU/6tNMUMat3tROFhM1s4MVLs0gDcm441Or6z2lXA+sOBcaVjHupFDgwIWyXKE5OEhiJsTynwyJ4TlgYccB/rmI/uJXH8Nhgh0ENAWkLP4LnO9QJiswXfYcqZgNDJ82i1bM3bOZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5836
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF0000855F.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 304d0687-4878-4133-6034-08df131f7cc5
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|14060799003|82310400026|1800799024|36860700016|35042699022|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: Bv5KZ0QmoEHvMoju2GZ1lady/FoXjhMxiNXjPppgfsedFUI0W9inX8g9AXJHecVyvrlsvM582CpScn1aGNPtgWh5GWijfI2wO+sfJPQpP45WLZLoCVJasLqE20xGIqVR+y498F5EFB3vLjDX1OK1G0Diqut8p8gWnZJ/6wtX3pLUzheHqhSMhS6ZC2jd0JcvEl5ddWmLtYmgZX9rnhWuiSyLKmWbsWQZ5eBdgudKUmZp09bk93dTZp2VhfFTSiG3GlM1pZfxKx/q4vKVSv8aMSKxzaV0/Rm6eaMyYIlf+LxpUoDI2kSmcyYyLR6gYycj4/1R1s/ccQcYBdG/jyu3OKZQIh3hi5r/OCMAMSi+2bqm15tKPHFHTl3r9qJ8ot+Mw+KlzMAXLUW6TONiUth2o8S/s+5X9HhyC/EOO5l1RjbXwErkA1fUU5zKz8Ym7DvPttBHU0rrvTkQtJBDWovV9osaD432gAtj0cKH6i+b8iBwCZkMpCeBnkNQABI2mID+jrhmOBTAsh+Soj/TgbDgMP5YxlPiCXUqeAzJGCmaH1NYOSrBAguTIrSEY97BfKHEP0FJGw+XaJJPbGMguDWkDeIuiteP0IPlh/nN6jjLuYwrtLZfO4aN+hNWRojEmMJHCEZdz08e/y7K8mTMV3soSMR1Ohxk692+qEUqEFFbVqQ=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(14060799003)(82310400026)(1800799024)(36860700016)(35042699022)(11063799006)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: L1rB74qcjDslyKAc3sSnvKR5KaE7+D1vlZrbILX81OBpefRB9qQ0Dovx0Uxnppfcbiv2YJKi8SZtstuz/cxPLJvDrmLf6zExxAqBtm87lnlV0DR+snlhpQskRBeCRcQlkeJHksSemgV6t1E5YDG/WQsZJyGkzlNo7bSLWQAXb1CRGInE/GZjoLlBvoEQiPQqhNRdp+IR/R/U46uOLkpfFsL2COk+32gmXlQ0yXK84tULYT5viJ3+KxJmFy9Y2qwFebmEKQI7JRe4Q7SXrWElkAOoKYZOEOGrl91UxWeQt83WOe5yeGHfCKEI30DmGp4mcPgabgo0B4A3/m+OcFWjS2ZXIE3n+u7zF0oIxGogOSBMGo8ZmaS+yN9SkTTgzarvgc1tkrL1OyJV+w9Bz104tVGSt3VB22+TKJSVSSBUF4+cuGdPk6205NWXnrau56xv
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 11:50:40.5902 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7403c106-1b28-4410-d647-08df131f90f6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF0000855F.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8503
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

Hi Tom,

The following changes since commit a44f46af0aa17e48572e0d46c0d082886ee353c3:

  MAINTAINERS: tee: update Jens Wiklander's email address (2026-09-11 10:22:58 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-net.git/ tags/net-20260915

for you to fetch changes up to a3afed6c8483357b094be6def40fd8d73617d72a:

  test: dm: nfs: Add regression tests for the NFS reply-length checks (2026-09-15 09:53:54 +0200)

----------------------------------------------------------------
Pull request net-20260915.

net
- test: dm: nfs: Add regression tests for the NFS reply-length checks
- net: nfs: Bound the length of an NFS readlink reply
- net: nfs: Bound the length of an NFS read reply
- fix error check in eth init
- airoha: fix PCS calibration retry limit

net-legacy
- net6: validate IPv6 payload and transport lengths on receive
- test: dm: eth: add DHCPv6 oversized option regression tests
- net: dhcp6: bound received DUID option lengths

net-lwip
- lwip: allow DHCP to stop without releasing its lease
- lwip: add an HTTP client abort operation
- lwip: allow DNS callbacks to be canceled
- lwip: return ERR_ABRT after aborting wget receive

----------------------------------------------------------------
Esteban Alba (1):
      net: net6: validate IPv6 payload and transport lengths on receive

James Hilliard (4):
      net: lwip: return ERR_ABRT after aborting wget receive
      net: lwip: allow DNS callbacks to be canceled
      net: lwip: add an HTTP client abort operation
      net: lwip: allow DHCP to stop without releasing its lease

Li Xiao (1):
      net: airoha: fix PCS calibration retry limit

Shahriyar Jalayeri (5):
      net: dhcp6: bound received DUID option lengths
      test: dm: eth: add DHCPv6 oversized option regression tests
      net: nfs: Bound the length of an NFS read reply
      net: nfs: Bound the length of an NFS readlink reply
      test: dm: nfs: Add regression tests for the NFS reply-length checks

Yuxiao Zhang (1):
      u-boot: fix error check in eth init

 configs/sandbox_defconfig                         |   1 +
 drivers/net/airoha/pcs-an7581.c                   |   2 +-
 lib/lwip/lwip/src/apps/http/http_client.c         |  71 ++++++++--
 lib/lwip/lwip/src/apps/sntp/sntp.c                |   3 +
 lib/lwip/lwip/src/core/dns.c                      |  26 ++++
 lib/lwip/lwip/src/core/ipv4/dhcp.c                |  39 ++++--
 lib/lwip/lwip/src/include/lwip/apps/http_client.h |   1 +
 lib/lwip/lwip/src/include/lwip/dhcp.h             |   1 +
 lib/lwip/lwip/src/include/lwip/dns.h              |   1 +
 net/dhcpv6.c                                      |  12 +-
 net/dhcpv6.h                                      |   3 +
 net/eth-uclass.c                                  |   4 +-
 net/lwip/wget.c                                   |   2 +-
 net/net6.c                                        |  18 ++-
 net/nfs-common.c                                  |  44 ++++---
 test/dm/Makefile                                  |   1 +
 test/dm/eth.c                                     | 151 ++++++++++++++++++++++
 test/dm/nfs.c                                     |  91 +++++++++++++
 18 files changed, 427 insertions(+), 44 deletions(-)
 create mode 100644 test/dm/nfs.c

CI link: https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/pipelines/1287

Thanks,
-- 
Jerome
