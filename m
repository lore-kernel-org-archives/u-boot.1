Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEB7C61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 08:17:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D98B81113;
	Thu,  3 Sep 2026 08:17:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G3ujrDTB_3eu; Thu,  3 Sep 2026 08:17:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 42BD1810E3
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788423466;
	b=MUJdgAvv6HOOQIIe0RMz+FAOb4ea80gCV6TfiSqbEmHDJx7ChtHikq5+nWus5myaEhb8
	 UVv024ObQp4PR0YCeGsUgcBD38Bl/ERp8HJ99JuA/TRWHI7xHhkUAD033Cpe/0oP/3HzB
	 CQpwm6YqPVhuf3YVayRdK0AH8EBeEoq7Ad3hDu9BxHH10uQHD3f/yciKelzjm16QqLgGc
	 fcJNmHd4uOaZlWZicUdxHeDP+BAMjnG1ptI6uq2HXG6bhq5pY2yw7cZmEf1RrBwFNG6Nu
	 AQhQDGLdEAyi0gz+HxsS/JVcLGca0phNLX2sbru+toc6iA4rai7Z2NNc6hlHgDMmLiA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788423466;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
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
	bh=YzDnEXJ3LlBP11/pfno7hvH5oS5DZZJuwOGheVXgpdk=;
	b=HspDWulDEAN3DZKpGDe00ce0lAtUpBlX3KCOLX6ioOl6m3+uruYlywVCUsMvDq5sPVaF
	 m/ggb6+NkYDplsQtEGM43TRfeP4WJLyL0JV38ZyYJGEeI10vD2ycZlJftCDx1M5Ja3/jX
	 /Vn+EYRVO5ASqWTpiRKWGzM2mVBhv11ibzduiFZoOIgwzfz/tjIgQj/hzoHzQIOSX3jP8
	 IM2sIoLmQIY95If2vOHxQx54HXHf4tiAxiGIQljQ5udT9sYIfwakE/J0Srjlqojlb2+Jg
	 CbgtFM6SxtyiysmgVjiqn5OOsMdNcRqdCvuS9nXHngMAU3R4ss/lS1wOLonDel8UHJA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=none header.from=softathome.com;
	dkim=pass header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-softathome1-onmicrosoft-com header.b=we8ntpIh;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788423466;
	bh=YzDnEXJ3LlBP11/pfno7hvH5oS5DZZJuwOGheVXgpdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VKv0Nyj2orU8GjPW6N8/IV0BOI/3QQqPzRRhE6uBW9RmF2Rpx48S2T05O7YDNrQSs
	 dNhZc3I/0qY0N4qAlIrJnFD65Swye/2R2FOIwMBHLl+PWFfgEv9ZpWF7cU/upiM4Ep
	 UDsOakRj9ZHB6tgcxclidlJQ/5vjbL5Dksx1F8GGRTKghe7DjFFBrjRkilZzYyU4ra
	 DlaKIiUAiNFVgD6ZTxA/WzjlncvP0JUHHq+kkQrJ//x5BEO/xOlzz8cGbOp6Cn59nP
	 I0dbVuUd463jitd5svcUTxN230IagYvzrjLoI8KFjzDMIRMya015sb6nQOJdrdAZgb
	 9lxXng3x6pXfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 42BD1810E3;
	Thu,  3 Sep 2026 08:17:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E306363
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 240F48081C
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yKyGDCHTCvOT for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 08:17:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 47AF6807A1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::4"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788423443;
 b=ABueMRzD5Ku2xktduFL2iw2M/2jlhehDq6jhvdxZfbAM2gdLcm211/psxhfKJ6jmjHNg
 lI28j3A2jkUSiI78/yeZ/HnAk+55csmZH+otJywfsp9dDaMC0oXtcFjX9N9SFzqxqII1g
 OrxxaXG8/wjUdTtyYB8X4jz6jYbBLt7jzr5G6l+11zTS5FAehfN9B5QUXwGBJ0s/fexst
 YKBi8rNIfVvJhDZJZHfik0ulYYwBzvfh8IqTkDKPPXS22utdSP4zaPANkYfk8CEBJp32c
 XrhGE2JRHbo1Z6fpUb67nWGUKNbNjo4+TIlVrgYDCXp9a2xi2fbNS58eV7xMJTWxqaw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788423443;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=YzDnEXJ3LlBP11/pfno7hvH5oS5DZZJuwOGheVXgpdk=;
 b=VjHRSgDgymC0UFCeDdwVzldLVnbQhPm3DSL+QlnRm5vEgPZ6LvWAZR/YBP3QITGrlo/p
 gJPCOovb0xBw0HOREYrrDDQ2eD9zHG2GvwXxSclu06n2B76bBu0NKwW2fLHziBecLgvvM
 Vt2YX7ryK/8WOZgFa2peFnwMV1UGAF1tyknM6cHErZzsJ8Ecqq6kyrq6mg8W0O4XQadKm
 Ke1ZP/aLsAeqqCfbPMljHZ5Z4synifOJUrR2+QgWQevS0ygAeRbJSoE9caiZ2kksvneMF
 3nKhYF8RZBg+wRT58HDgX6UdTc9bdoWrc3d6Fuz7FW1l7a7CfRVBySoYwjZ4xXbfOjA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=none header.from=softathome.com; 
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=we8ntpIh; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::4"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::4;
 helo=pr0p264cu014.outbound.protection.outlook.com;
 envelope-from=philippe.reynes@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=we8ntpIh
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 47AF6807A1
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSUN+LMLwLsEgkKZZTa4q9IqhbBgMkIecwyzRqinLW9zzJWnw8BXPjNp8hPjbz6i6UQv0Qrhgoz2RWx/5ay31bw+u/6C596uzp27ta367pRXjmjhMGx/FCGr7s56+EgmTlwBOnIq3YBhZPBamJcWbqYTWBpU8ymqQwlhLLzrCRLTxdj1xmDyk+Dau9Q4+8B6RcmlZutpvp7c36kwVW1htcSpxx/QBJJ6ykex18IKGcBwhSstc6gln86YYL/3B2TxNYEw+0KPloe1jxtrH+5kK4tz9HtMLlMd40iYobBX9mkjzK9H3uTmNCQmJYKBJUIroOwua4Zlvvpg74M8Fnwqtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzDnEXJ3LlBP11/pfno7hvH5oS5DZZJuwOGheVXgpdk=;
 b=l4zm3rMUFHdjwDZtyIzS2eQNRx7Z6R7MEjQBPMn0t+kRxontolXLa5pblyiUdTXoA7ajpKReRoj8oef9niVDqDPeNn17+GF/S9ra4DeXm9o+YUp1H6RzFFld3UyoCCwgRloh6reiT0l9OS0HxrFSpIa/zwW3eH2th2sB0sUrjG/YPKr5Y1pCUFMVvuG5Df9GSpACM9cGrfQDEGUdVM7V8XXktdFwn5IJfKB4vLN5ZuDtsvnYt3DJdKLo1Q9ooewy2XHD5B13+GOy5u2kvP6qp59tzbM5MIhC/GJ+aqe4X0URnfuWay9uTwiLJe0P6m7bQaJWjrwZAbZl0vUaC2+Rtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzDnEXJ3LlBP11/pfno7hvH5oS5DZZJuwOGheVXgpdk=;
 b=we8ntpIhdJ8aa4w8J0VNLo5ZtU3y7pAZkJDX7JhjH+OxFaTPMVhzGZa68nRckq9FREuvPs4G6V/JLTTTrTtAVVa90WSEPZM/EJShZCMsHg/9r+r7LzQcoGgm3jthQxJpYeGmp5R4zLTk1k/16ZtiKA/+XbxUZKTXW7b4uFonHw11rhhB8hEkGYSSMqcq2QOOHy0AyDBdlZeKaJm+gSDJxUExDOzlFAr669fE8NfluBv+SiwgdH7Ts48gwSt885wbDYHl/kYBf5KMaUXyLqRhfbqzBSJDZZSaPuixoI1eZKWQaypYOuMCYiBQjKH74U48p3AqoNKXvEq5fCPEbE5bPQ==
Received: from MR1P264CA0054.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3e::7) by
 MR1PPF7240757F4.FRAP264.PROD.OUTLOOK.COM (2603:10a6:508:1::235) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 08:17:17 +0000
Received: from MR1PEPF00000D58.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3e:cafe::77) by MR1P264CA0054.outlook.office365.com
 (2603:10a6:501:3e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Thu, 3
 Sep 2026 08:17:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D58.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Thu, 3 Sep 2026 08:17:17 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 513542002B;
 Thu,  3 Sep 2026 10:17:17 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.u-boot-project.org,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v9 13/15] tools: preload_check_sign: add support of ecdsa
Date: Thu,  3 Sep 2026 10:17:03 +0200
Message-ID: <20260903081705.12894-14-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903081705.12894-1-philippe.reynes@softathome.com>
References: <20260903081705.12894-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D58:EE_|MR1PPF7240757F4:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1f469cad-5fde-48d1-0d12-08df0993c4c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|10067099003|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: S4mUSVxmVHa65z8XEEexfVx+IC/cvEpE6nqnjJUBDil2k/8O4H6rnxYaj/h+YtoClvYEju5IcCLgxR3YWBHFiIU5VhAl2sLOPHR8BYZL0IPMkSIa/8qpT8TS1Z6oo9mHaYzuWZJJXS4oG7b7rSqhHyGPDmxHg9X6AYEGQvDg5EBMDMBYtwztBlQ6vZLB8j1Kx6LJvE6NEvKE+9N3/qlt7mIeuumnxLyP92DwsILqVQ9q3ngCqPeZr8JbugCO/5MWGWpxS6oy14bBbJwWwyA3mBDqWdYTWsvRQCJt07ohuIfu+R/C9Esg4mSPp670n8g7xas3dpjt3p043H4yasjSgUpUhSYeKBiTA5XCbQORhLrtFxCwdEn8xJ2OzLzPEAqqaDJ0RxUCVGyPWxqFnKdzQIBl7BBUdEaCsuPb4NFX26zD6mOkUT9YQStRNXZ4O8avm6sZzGRi7VKutbDh2rXeIY65Jxj9osxah1LtiRmuf8Nu8XVt8qQlq98F2a24jRKKJy+MpidRF6N80PZM8s1Qd6yQb3LCEreTmAPjnUG4bocvgZjMnIIj3o/t3y1aTbSyrelOmnj6FQCBsAFuJ8P7QiqgpchMwZK6MuIwNtZGKXSQdL/C8yP2ocijR0oAm/eZvwbchrNYnbZW+l+NPibi6L5I5f/K/gxSFwCNwomfhl2xcZk8wIhkwk9ygvQgXQBANRVPWduw714WDFiPdFtgag==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(10067099003)(6133799003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kAA7foNl1ENCPiW70Eo8Llaqoh1sOzL2tqvIW/h9HSEZ2JJkTpJafZxhDXOW/PdpzgUcYNqE1IJmNxPgWOftWEjppbacGLzkLO1YaJIoiApHvGfXiNdJngijtrZGALc+LP+V/dvYkpM4hWCW744/1jg16Dp9PxCUd623NYKB93m0XIhS9+szrlklm4tLh5rRqA/XvTeZUKwk05uNXYIfHHiv8vuHeiRpJ6YDwahJiinqbZha5ArLk5/LdFFMsO3W3evoqdxuyzVI/OB1aneGwuLsjzr9l92ejUarvQ2h6MWcRMPSJ6I/hKslUdi/u/OavDdylQdf37fl3MK+g0+d0+eUolJnbTYz3SGJOT37mEYcP5I3Krblyp08D2jSKNZMSAoi9vnof2Q/kRVJQSsb0IB1S8QhSTc19WpyimKpOah0216Qz1wcYWTNnPcpAb5Q
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 08:17:17.5515 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f469cad-5fde-48d1-0d12-08df0993c4c8
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D58.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1PPF7240757F4
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

right now, the tool preload_check_sign may only
checks an image with a pre-load header with rsa.
We add the support of pre-load header with ecdsa.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v3:
- initial version
v4:
- free key to avoid mem leak
- fix error management (set ret before goto out)
v5:
- add include ec.h, evp.h, err.h and image.h
v6:
- no change
v7:
- no change
v8:
- no change
v9:
- no change

 tools/preload_check_sign.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/preload_check_sign.c b/tools/preload_check_sign.c
index ebead459273..d94f0509e74 100644
--- a/tools/preload_check_sign.c
+++ b/tools/preload_check_sign.c
@@ -8,9 +8,13 @@
  * complete file. The tool preload_check_sign allows to verify and authenticate
  * a file starting with a preload header.
  */
+
+#define OPENSSL_API_COMPAT 0x10101000L
+
 #include <stdio.h>
 #include <unistd.h>
 #include <openssl/pem.h>
+#include <openssl/ec.h>
 #include <openssl/evp.h>
 #include <openssl/err.h>
 #include <image.h>
@@ -144,6 +148,32 @@ int main(int argc, char **argv)
 	info.sig_info.key      = info.key;
 	info.sig_info.keylen   = info.key_len;
 
+	/* For ecdsa key, we have to update some values */
+	if (EVP_PKEY_id(pkey) == EVP_PKEY_EC) {
+		EC_KEY *ecdsa_key;
+		const EC_GROUP *group;
+
+		ecdsa_key = EVP_PKEY_get1_EC_KEY(pkey);
+		if (!ecdsa_key) {
+			fprintf(stderr, "Can not extract ECDSA key\n");
+			ret = EXIT_FAILURE;
+			goto out;
+		}
+
+		group = EC_KEY_get0_group(ecdsa_key);
+		if (!group) {
+			fprintf(stderr, "Can not extract ECDSA group\n");
+			EC_KEY_free(ecdsa_key);
+			ret = EXIT_FAILURE;
+			goto out;
+		}
+
+		info.sig_info.keyfile  = keyfile;
+		info.sig_size          = (EC_GROUP_order_bits(group) + 7) / 8 * 2;
+
+		EC_KEY_free(ecdsa_key);
+	}
+
 	/* Check the signature */
 	image_pre_load_sig_set_info(&info);
 	ret = image_pre_load_sig((ulong)buffer);
-- 
2.43.0

