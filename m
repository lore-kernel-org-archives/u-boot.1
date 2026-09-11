Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681A9C88E50
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 13:18:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 30BB96068C;
	Fri, 11 Sep 2026 13:18:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5Gh7irszQjZ6; Fri, 11 Sep 2026 13:18:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 672266066A
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789132692;
	b=gNiMIkUmU4pQZFOScyNvP8QHZxWFWDMF7adH79kmyPGMeP46FfTX1leK0R3XQwqe9ruW
	 pDjNdT7R3T53DBvm2hvokpsd+8Gcl7GuZDr3iM/+pGMiRASjP2TjknJCLg/nIct/cDNl4
	 GaYue5llzzxAUBvtEb17+RWZ+O5f/yD1aBvFY7jpvcS8RWF+zeLBcrUSqtzewDLl6mfAh
	 KApmHtScAXB+vzm1EwkekprxHVm0EYAby31UTcDuna+MQp5iayLrXPco+Ef+W7Krrx+q7
	 WKE6V4MPvAZW7XyVCoTH9gvNJZeFuaKc5ONBr1GX4HjQe+flzAr6AJV0o6nprr1Di7g==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789132692;
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
	bh=2B+1Xil9VCsLZ9B61DMliZqkV0dHLcXhFPEQfue7A0g=;
	b=khkagZenKVMejUrRI7d8R8+PfHdDu2a9dNkE3HYZt7FSMGeP50phCBqNcMxwBOdhaYZG
	 +JphTgYZzrFyLoHn9JjOpY7i8U843XuiOwZTCvqNmN1BFjl1BHXPdb8W+z8+HtpBFQX4q
	 23Rpc1J962F7VSSnCsFia5pxPM7rK+/gwBFZOpMPE8WxdOORBDv4eaDiV0uPTDCrb0KNt
	 Z9q+UnO/D/3m5sgBebclS6coRnpq7U3GKBZSW2KtE3cmOpiV/nOlQe5T+iaowoFnu3+Ir
	 r5RpNQUS7Uc28O8Z9/lzwSdqK+oj9pHM7//Cs70NRhYkxIi53NB3Z9W4srInHi3CePw==
ARC-Authentication-Results: i=4; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789132692;
	bh=2B+1Xil9VCsLZ9B61DMliZqkV0dHLcXhFPEQfue7A0g=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sFXctgZANb+vQ7uEX3aLw13d+7kDsgsRTpBdCeRWNHU4wP2pHQ73JtsK5VQfIcBu5
	 NnNOA5LWPgIwteDqKzdhm/n4HcUuN8q6qtjxX3F62VgFkU+3Z+m66buwgqCLnl+J+j
	 M6slNsF0wxtJUg/OhcVLQ46hUQ2yAoIabSMhAhqgTwgi8PMn5wQD+g4VwyyREyXKyp
	 eD5Zc5XYUeeyrk4kYYOjHleCP4tAki/hHfiVfDluClfA0XHbaXGdWH4vIHsm3kWOTk
	 Y8yGHNEow50jGt5w+m3Z5uWSZX3h5IaUguB/zWTaNC2Sgh+g7fRRQLNKkI0eDB8yyR
	 sVkOWSuLzDprQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 672266066A;
	Fri, 11 Sep 2026 13:18:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EB53F2E3
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:18:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DD71F40822
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:18:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tlt2wSo0f5fL for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 13:18:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6D2CC40820
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c201::1"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789132689;
 b=H0JsoZ2DVafFOhYEGR8HcYtCiceLFJxX+ZIatFZ8Vimn8JzCNxGXzTVCRMWq6PdcLdad
 a6BcJQlA4WsvxXBw9B7gI+o2PNbOYzg42oboVjIhXxkdwMj45gRrs8k3VRWSAfZ2S+GSC
 pZ5NkKQg2ABqcdkuuP+enx6lUNo0kWfdLzUznU99TVncgxyaUrltWYQBQWFmiUtNL7t/K
 DMw9ygtjDFG4Gso9kecnacdd4PS+J8gblb8w2cNTWcCU+HW4oKV5oEkIQthtI5l4vJGpo
 xszambUa+Nx4Wi5hQOsJYqAm7HGBtqnXZDEy4RdKV+dezotv2huBhkmir4ONYkGuh5g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789132689;
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
 bh=2B+1Xil9VCsLZ9B61DMliZqkV0dHLcXhFPEQfue7A0g=;
 b=OY5KyMfpFJIuwIVgi0xBHVzvSYwJhcAB2OP5r4Dsi9NwVjk3jBYclkx8BTD/w5jBcGc8
 Ez87HbpMu6doQ0Q/efOT9hejHZ/yFz0+VKWQ4kqcnZmzbU6PTEey107QLge39hSXPIDEh
 fQz3z1dHbhN82dr0mSR7GANDoOBXTMXrL2MxkZgFuwtXg3/TIM/emygTSfRYyqRMLNvzt
 0WjPXcX5qBo3h0Sr7hQ4oeSLomgmQ55IMxuj+LAR8L+xn+bWeX5sO+MPYkiozGBzWtkvz
 7vLMNabeix7gUUvfY1NB50nWfNxpzU4g+qoJ3cEK5VMgjPyW42qnxLTdAgTpoGuiz9g==
ARC-Authentication-Results: i=3; smtp4.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b="W/ofLsmS"; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b="W/ofLsmS"; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=W/ofLsmS; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=W/ofLsmS
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6D2CC40820
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:18:09 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=smAKBwX7unE0T3oPwLfz+BDFtG6ghDIFP0pL0AxCR0XEz6HZ+Kii5ta44c5KPdjlRYC0pwmwyQVxK7r7Uud+ojbWzEhTwHgKMZKMdrIkqGUHjhqIoGrJ0CdU0htJtxz8EzP3q43QPdTNbaBZnn5wh0UT+GqXHKsqsD/EFPIbBjf5MazIg8D0COmyI+44Dg+oGcmlAwouGQwOc9qSgntRTquoHKY5KkqbHa3WM8dP+eiWgrHRgi95w9YfARJNTHMxKmH8lu7chlm427DRSQdNRspdiJ3YBaHYmb3QxizxKOhTRXpehW5YrnjAQtMNK2L1CXNj+fOkYghjj4w2H5dpKQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2B+1Xil9VCsLZ9B61DMliZqkV0dHLcXhFPEQfue7A0g=;
 b=k1VItMgjGigT5NQ3v3+VUXN0lTO1fVDaZK99hlMKTRT16K+DAHpaMxWgrE1ZnSEr5fsQSZGnFrUebFEBj07gwkJXSXc7gdu/m/yK1s+D8G1SP5agGN2Opjhzfo/ELhWzB2BGkJtz67sy2x93E/5wHLvm84mw/4TVqIP3WOAtz5ysQRDdeL6l+e36qTtE4LSC1A6JQZUkrjA19/LZRM7eU9pdlTJIdHEGp6O8JY1u2YkYqYwpY0VUdEmZYPBvDksnrueSl9wSJSekWbXs2ZZAFT+gjuQ27CLMwQEphL8QXfq8/QdcEqpVYxAEKsgwbwtsz0aVcMeHaT+5eOvv2EX10A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=arm.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=arm.com; dkim=pass (signature was verified) header.d=arm.com;
 arc=pass (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com]
 dkim=[1,1,header.d=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2B+1Xil9VCsLZ9B61DMliZqkV0dHLcXhFPEQfue7A0g=;
 b=W/ofLsmS2jVrkhQ7XQrtpYBo6+msEkj1q2l0tjlgsABmacVzMhvnBZe+QY7chZrVraG6rnNfC3Y3i0GARlHXl5vmfI5KHqA/cjRzB/lnOJobZgPl6fEf4bBvOIxtf3VME/HW36QclM+dAQZRyxCFK/XS/I5zqXWjkWQ1CgsooZ4=
Received: from MI3PEPF00007547.ITAP293.PROD.OUTLOOK.COM (2603:10a6:298:1::4d7)
 by AMCPR08MB999911.eurprd08.prod.outlook.com (2603:10a6:20b:780::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 13:18:02 +0000
Received: from MI3PEPF00008554.eurprd05.prod.outlook.com (2603:10a6:298:1::88)
 by MI3PEPF00007547.outlook.office365.com (2603:10a6:298:1::4d7) with
 Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id
 15.21.382.12 via Frontend Transport; Fri, 11 Sep 2026 13:18:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008554.mail.protection.outlook.com (10.167.240.8) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Fri, 11 Sep 2026 13:18:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fCBEDoT+o5zvkQiRbaWBXr3FU2ClUWTI9c8QiFN1+BaEM9kcJTp/NWcwMZb19O1DtOEYGxezT04SrA5/Zff45rxm9a3cOCbBAMniKerwCcTbCmFfUMwcthgHGobbBZo3/4qDiQZmtMF2t7dXABjQiQSEp7KEkUTfs/EHEvkc0+gu3HHfjX9KxsWA5JA1pPPFeo6dfwlKrf8YaiINWoif1rQMfCAz9AWiwYwGgVFo6pSLwf6XgANGM/c2FvgK9p9ShU0J94LL8hmsGY18P/Xtc0D00yFeWKb6DaG7Qqacwpiz1HYC0hzMCmhtrxm+tEUOk9pKKklExLNMlOI+kQe7GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2B+1Xil9VCsLZ9B61DMliZqkV0dHLcXhFPEQfue7A0g=;
 b=dCMXzFc0f59IhckVRuqZcKTsEBgudNp2WXRgI0I1OIGGXhvP7RPg2qHvlPDDZxVBOo87ICju0oQf3u8qRSt7mwsMA0ls2JiG8I4GdhJnugz6IE6asNoS3A+OsP6gAX4XOMwqNp5nqBsF0bsX47HEFa0ZDXxPvJxmh78Cv6LkdZy6WwLUQNwhV8aqdr9Ob9aSpEycb9WUstJucRBWXqRzs/R1G480QynxblDAFZKOe/GztUFoiAUK3NekeYBQIhzIp6uyOYsKgm9+zO05UuVu2r7pLHZ/P/thxdGAouj5iH6fLIpOM7Ot1ZF+GkGJ4lC070dZhRQyoRNpg9I1RqDByA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2B+1Xil9VCsLZ9B61DMliZqkV0dHLcXhFPEQfue7A0g=;
 b=W/ofLsmS2jVrkhQ7XQrtpYBo6+msEkj1q2l0tjlgsABmacVzMhvnBZe+QY7chZrVraG6rnNfC3Y3i0GARlHXl5vmfI5KHqA/cjRzB/lnOJobZgPl6fEf4bBvOIxtf3VME/HW36QclM+dAQZRyxCFK/XS/I5zqXWjkWQ1CgsooZ4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by PAXPR08MB6557.eurprd08.prod.outlook.com
 (2603:10a6:102:de::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 11 Sep
 2026 13:17:29 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0406.005; Fri, 11 Sep 2026
 13:17:29 +0000
Message-ID: <b5315387-6937-4acb-a00f-0de3d22de7f0@arm.com>
Date: Fri, 11 Sep 2026 15:17:28 +0200
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH v2] dhcpv6: support rapid commit dhcp6 option
To: u-boot@lists.u-boot-project.org, Yuxiao Zhang <yuxiaozhang@google.com>
Cc: Francois Berder <fberder@outlook.fr>, Johan Jonker <jbx6244@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, nd <nd@arm.com>
References: <"<53437d4c-a21d-496c-9587-c9832d76a1de@arm.com>
 <20260825175417.1068611-1-yuxiaozhang@google.com>
Content-Language: en-US
In-Reply-To: <20260825175417.1068611-1-yuxiaozhang@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::6) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|PAXPR08MB6557:EE_|MI3PEPF00008554:EE_|AMCPR08MB999911:EE_
X-MS-Office365-Filtering-Correlation-Id: 54d55f11-b8be-461c-8bb0-08df10071b68
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info-Original: nU9SplIev8DLeba46OaDhvWVWQ3nD8XZoPczMHa4G2ji8Ayen2SESahhy7Nf9NzJm9erRPiPyKwVegAMbaF0Vn7O7AkUenfH7rPjfcBmuNMm4RDEyKgWb0v5SklqnQcTFpTmfs4KE+XQ8WYnoF6/Bflg4njJi1uTsVNKRCl/n6c6qcwEsNP4E8nQOpj3E1Ft/ezfwsGeg8jjAFxeuZXe6MMIhgSx/FADXlorWQC0Y/y9HDsib5/mgdAmJZaYUKSwjKGagrYKeQJNjO3+Un2Qc310XXnu+7m1xAobesuVk37CjqJs+zc4mD0queHPx6qsF6kcy0RfxT/gV3ymadBiY+pclohPTMis8yf+V4tHBZCcSh6v+OX3IWi0BzLdyOzdH3iYgbY3IlyWQwB5pHp0iagSeXNRRG4HN/sFIEsYC2TUjhOaBqZnuvuoxoQ03kIb+2DwnrEsw43pTz+kngmD0wXZw+1PyWVvaB2CIOvRDlin7CbFFTBsxvNqpLtSVOhlixbrb1uVuVp6XC2fbm7soonWhBD+mtRIkH+fUTJqMr+49QvQCBRx07NrBaNtO8bc0vBTC6I1z7BPm+OGYApgeYdEoLli/MPgKZS61VNBpXGsh5xAmqfN6FVH4nYwLifCw1jDf+8/o+QzB6b2emaNvNrtjAJAWFt2tpDeCMatCEY=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: j+AC+n7JqUs5zp4Kk/WVyVWLMov68wSj7vghvIM5Adw9sM/hk3T+ny14bK8HOHVeOtpX1oLqyZVWGo2Cid6NfFHpQ/WKvdwrrpoPBHpckNPdIkWv8yf7mmEkWgYfPBY5n886zAIKBQ0ewLRWJobkKzsGKSC0WSIEflAjLnyKfOYOrY+Y7udV9WgD+PvovY4Y0CPOQE/HAD4LeIIGBvwldbWY6QCA/GhhbI0Tmhc4nKEPcISlcS2HscHsqNQ+cbdF8VzuCWfN2pZgx2NxTLLTLu+kpPXs3o1j880UBkMxaWAldmJzMFZED7U7YrWLBm+E50qfo0ponhOhV2iSTECYdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6557
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF00008554.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4ba64dbb-6fdd-4b14-91bd-08df10070818
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|1800799024|14060799003|376014|32650700020|36860700016|23010399003|82310400026|10067099003|18002099003|22082099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: oFVuKjX4zg2t44oZ9n1HRQoc9aGJpx7CCaI3hpjooVbgvvwzJ3ZSXSlADV8SSr9FPuZlqeNxH7BOO9rbqN/Uduhk4i5DomhgBQ6HR5cD5WD2BgBooqFMLqToYkpyajopw+tSrchrdkZj3cRp9KgPpcVVCM7LhTD4rtECRvr8uerEARhP7IOqJDCfGlmkh6NNQ3n5/6dmOvpwatBlFnNqijd7CDHK4d7AwVZMPZsATJhosQBEU16WlE0YpyGUTvcyQ8IV3HGDZOJCLyjjmNFVQGj2T2eFImV7CyXrWJHP1so6wg1dkz8yAhlJgVdx4CeX+xFJXDIb4j43D1m45572rFyZZcMx6cIk24M24m2+WqsZPfP4EkC1z6mRD08fZbJnGzP0SIMgEEw9dXpLlwtmao4gG3PMjiqwH3+XROOt5dQv27EtGKxc1U1j0gvqP6dTNhsg8CqI2cuR2QPdxFiWDAig/J5k5+PVDdg9IFuhlD9BMgC3VU3XVabznuwMY4D8boRaE2o8aQR2zJALj5ZemcEkcQ4pnnej94eizSS18JevQrfRIgU7i4YA9BzDpcUneoMPV9pecm7s2bW9irsKlABhtuLvJRpzFRkRTVanIkRTOUPxVZLNRsuFcyReCE06yqRfWK50dEwf4eYNkLBwruDNZy3lyIRMBykPraHhENdlndk3FWslbQ8A2XKtZigUcEnboj78SPs/QMw3o43sjw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(1800799024)(14060799003)(376014)(32650700020)(36860700016)(23010399003)(82310400026)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PO/onYeYTrSkUhI8/rJ2QSudO8wBNWnlkXT0vTTUevrh9AAJDs8/b6NmXapjDbte9wyFUzcOkBjzebtqBrdHp2Osnj/EQaFU7Fj84XzVdoPzEu48PgmxHVUi+4wTvuOiAVxuuWG9VCxBIjmx0ivYQHlSYrhX7/0jXjBEbgsUaE9g2lOSrmnvOD+qb+4Sf5kr3HuLkYiIxRcK/UlamTuhL7OcVA7/gt5oC/IasXAL+jFU+aQeYeOxHeG08nOxDHSbp3HXNaSS8oopVCGgKvZ+E/XQ/qccqRskumDiTavw8XXZ18niEWZ9Lqju3WftrO6VaAh3qhwilRJ94bdqJG3wBJiPk6aM+stgV/o6Uqu9MKsTNx41lYsPQzEt73FA7h4TZGPzLiTSUWrYZjfldeBSYk8yVRRj39It4bB6GxRcZluwreMWuek8xNqItitYLwqC
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 13:18:01.8876 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d55f11-b8be-461c-8bb0-08df10071b68
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008554.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMCPR08MB999911
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

On Tue, 25 Aug 2026 10:53:56 -0700, Yuxiao Zhang wrote:
> Support rapid commit option code 14 which bypass the advertise and
> request state. The option is enabled by DHCP6_RAPID_COMMIT.
> 
> 

Applied to u-boot-net branch for-main, thanks!

[1/1] dhcpv6: support rapid commit dhcp6 option
      commit: 111691af75455c96fca2c9f2336e64ae17c4660f

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>

