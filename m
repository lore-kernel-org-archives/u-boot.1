Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0790CA601E
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 17:08:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A3029608BA;
	Fri,  9 Oct 2026 17:08:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZHN3KfUqt2Cj; Fri,  9 Oct 2026 17:08:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BE04A60727
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791565725;
	b=VRi0v6a5L3SMsw1AB27+7e6YRcIhrcsa5jB+h1UJTV0xZVs9suaVS/8g/37G5WxX2HLb
	 KAWlOzeR/BscB9eyIsZOBvCj3+Zz0xj1Zc2TKnfw0zpSH+Nz35e/Sgt6hPYAvx6jUd355
	 0dfW/kjPt1O5mw9imp6XiXXhKWqKonYBcgoqka7lhlg8cQ9Vg3zR1Jmu06Iv54KT/zleH
	 ZKQEHWmwuGjIwUicTOJ0ZVwHxk+cFd7AbjRq2u64K3w0SLe2dwoJ5H8U3QgrTLqOkWOVn
	 MXuhFhhHTfU8z2kkci5eWGVMpGRMkyj7XTJecWR3wdkYy2malKWSjlN1TbW645tDoqg==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791565725;
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
	bh=vnKJRx777wbJGf3nl1sPMfp6+++puyamM6iVK6Lp8Jk=;
	b=KUa6CPP5oPHTnWvc5TcG6HPD/SdoDi1LqPb3+MbPJMkl396dnvjh4sfFx3QJsSCUKQeV
	 GHiCIXDeXUVT1lKeIehKCu/+sMkgW/rrGNUKp+fyS/ycqabsDTpXjVKReb7lKGUoTZyXE
	 FMsPcDeqsSBPVI026lR7rv1JppwFjMgrf4vn4dn5g5gDccjZK06buTnvKUIpmdX3fcuUG
	 QdNHpIXsJXesKTc3UCQE64253vsfnAL1yh+HhpggTyPf4p1kqknpkLsa+mHVO9+YUT042
	 i82Q6rU2paA6d9mbeP+45Mb/pCnbDUbjRCVtLyHCkPEzm9Nj25nTpi0kgXK+qBliL7Q==
ARC-Authentication-Results: i=4; smtp3.osuosl.org; 
	dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=HJRu5kUh;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=HJRu5kUh;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791565725;
	bh=vnKJRx777wbJGf3nl1sPMfp6+++puyamM6iVK6Lp8Jk=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hKR1ISo6tmzNs3xgmF9Gw6bE4FRvJxAjCmdykVxu0ZqIPTmV98+n9bkRVvndaIWBP
	 pr3vDOYoCF+Fmlajm6uv9NfVV2lpfuajOVvv83yp1Qx+3v8E5At2bF/S0NkqwRa3h4
	 BJTQi9aTSHVp3A4OVgpmzPd2eie9eBzFr1Wf7efvMiW0FezNISR7Wr6BxCoFniMeQy
	 JWu8X4ox8zfD7g4ao/ucedHNd+SM9MAy0q0vLP9+NVtGnuxaX8Xvj0rUEV32ohVRKH
	 l6x5cshvAJrjflEtmGMmEOjlOVSOILUy2hN95og2MIIHYKNpvzA7cw8DZ9SnbTzfMe
	 uHcl7eWOjHi7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE04A60727;
	Fri,  9 Oct 2026 17:08:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E6F2A14
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:08:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F3D8560727
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:08:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0Cocf9tZoovL for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 17:08:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DFB3C60680
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c201::3"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791565724;
 b=dm6H40BBx0obte5/z/Eu7y5QaY4Er8LVWXHWigKCV1bOUAmQXHQ1a81ZGu6LxqCS0qDS
 InqgWdedTdSTXF6VEGiQSzyWD1tzZopl2JEQKLe3I5QrzotxY0Zv2P+LIxkHXWC2rkDJf
 x99f7ICN1LlzJOgYzzNqCjhBOCwohPZVAJ5WvFWkw/Tgw11qhIO0JtttOGqcNton48mmK
 5B76yXIwLVHFt63Hi2yA71pp/EWsTAHQJwTOcFzchE9o5Pl4hFkb3KHdzRmw0fXNviiMD
 JNC5RLxxwKjqeYkgsVs3FWwhcgAcdgg6xuLeVGwFZSKdiXm13qujl3IbBaVAO9oNKVg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791565724;
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
 bh=vnKJRx777wbJGf3nl1sPMfp6+++puyamM6iVK6Lp8Jk=;
 b=aFtQ8rf3jypXk9BLeo0P8xHMPM5lK+fGkGODF3tV/C1oW+N8vtgsFmokuIEn8kdc8sxL
 aUUbAx6Zo013cX4K2h42AeKXlFaXDoh9iTeu/2PPGmrWWK+6y1wybK2fqM/8RO19/4Nic
 r/z7b/rGkU+xpAWFSlsoYyYa17AzGqc2Wj/KyBdTY0uAlPuy8i20kaDSo/5LUDOiWfj6C
 Dk4hqnPY5U/MiizACWBQcNfteIHNw6PLEnKlhWL3+TPtST+mommLOpPUlFZ0hlhMQjFNr
 c8yyImldzCxUi1g2ASu2lP4gqXRayzODLEt6mN7yMATHRYHWGoAn8Jk8b5lw0E2muMw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=HJRu5kUh; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=HJRu5kUh; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=HJRu5kUh; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=HJRu5kUh
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DFB3C60680
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:08:43 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=NEYCm7Q8UhLdsboYblbPHfZpcNf6NLBdM8LdO6W0VTWNY9lF3jHrHcQLe86rCaHw/hF8sBeNwwabpDxDyRmxK+blsfZWemUliSRjyBWB52DIsCYV40RKJBdP2L6KJZ5UIeDIzvb58RU3pGYOWrY+XaZotxnK/ZOceLvZ0uJlWmI9gV7I27ib6QKY2nx7RzHmR0NTKe6tEz5NvCj4OU34zK73xnsi+h9BrssmQtJrUz5JjIWzsldj1VggHKJbKZo4de0i4tzDi4bhWpWbhUZY/Blz3sVjqVGmVMs20wVbx8r/nslrd33q+yW1iLSNIeaMGl1v6SxIczvXEPhtG+xeiQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnKJRx777wbJGf3nl1sPMfp6+++puyamM6iVK6Lp8Jk=;
 b=gUe9f+HG8H9Xnpvx3b4rREirDHbF+Mzd9IGnjSCdUauEu4XFZOxxqBauwzC8up7CriCvfQxtS56a/d9hl4Un06cjLvH6SLIsbNRf1V7l+fiuAzbd45emhPiJX6Cd9KrlV3Nw+vszWmSgwnmPtPzbL0+c7Ilc47iU/u6nsUkyiJqsm/OYPXj3ie0KANxiWsiYFknXSOMalCE4i1QaB+navNFHZQnjezOwbu31DSYk+zIX7GcPd2xzhvRcX+cbhDzKz8T0aPlR0VnAb1YAzhe+lV7p8ZbaITXbd7Fr4uyZw0z9JAD6luvzaLO+AVs3Sw4a5kon2/3KMDyLD8qa5Vtwdg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=arm.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=arm.com; dkim=pass (signature was verified) header.d=arm.com;
 arc=pass (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com]
 dkim=[1,1,header.d=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnKJRx777wbJGf3nl1sPMfp6+++puyamM6iVK6Lp8Jk=;
 b=HJRu5kUhOOoOAXBU48EqQCFWSn+ipzWJVdx3QNfZnABN51SMulvUMJYGIcnFhknCsJZS8TOSBhl0oJB6MXbH39pR078yrPkB10hZR41btMX8L6gQxPkfcfQYte7SzoHAk3ToplcxkTirLdx1b+fhyiqp5vjdyZibml1VGI05Gm0=
Received: from PAZP264CA0064.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fd::20)
 by DU0PR08MB9438.eurprd08.prod.outlook.com (2603:10a6:10:42e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Fri, 9 Oct
 2026 17:08:36 +0000
Received: from AM7PEPF00000057.EURPRD83.prod.outlook.com
 (2603:10a6:102:1fd:cafe::3c) by PAZP264CA0064.outlook.office365.com
 (2603:10a6:102:1fd::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 17:08:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM7PEPF00000057.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.0
 via Frontend Transport; Fri, 9 Oct 2026 17:08:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PP2ZYbfq1XeQk8uWCM7wxlUX6i7FxhlvXbNQV8CaI5UT0WZ5ohEIFTXwBMSwzrdwx4JJXvSxsgy3L3+ie6yeKrIiwF/ssxvpYPL/gm9tfLup+dTl1Sgouf34AVCfcnmhZz9iIB26OWz3b3ITSz+jgWTJ7a+mX0MbPIKpSYzR4z2ItnKEmQHX5BTsKBSsMVWB4rxj129y+jYP3cR7JqGYWcSBdUUi6UULHTBXM0c+NCf16UW0mUBqTDdwNsSiE9vsBVPk+5UF5TExtWvPM02DHYPGxh27YvmcczjrngVt/9IctOJI6p3plV4cLF6uOWpYESg2OXtPlohekiJ6j7D/Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnKJRx777wbJGf3nl1sPMfp6+++puyamM6iVK6Lp8Jk=;
 b=PWVWzJKEURp1+d5gwrEgtQvJtWTg9Y9RJ/trHyVnPwcAvejce9GB4jD8erQhznNdO1Wz6e/d8973vCSR3QzeNtFhUJjv2fE56JWWp/W1lCmKhUP2EtSRBbtzAukQr0LXgPP6r5d2f6EQmlbeVKynS0BPdfJzpiZYNVaWrT73YBznU/pOHNGHdGPXUFdUKqMG2Nj8+P1/15Ih2rK4pshPaZLiZ5wf2ZDUeIr4WNpP7kohWgGdWqbhkJ5kjFhYEtRSK8yse9bccMXKK8SQ95YJcfKsiFjRkxIbWMCnMyXlGTggNbfWcNky99LOy9cCAGZ6Fm30EATHveB7nhMDSXpt8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnKJRx777wbJGf3nl1sPMfp6+++puyamM6iVK6Lp8Jk=;
 b=HJRu5kUhOOoOAXBU48EqQCFWSn+ipzWJVdx3QNfZnABN51SMulvUMJYGIcnFhknCsJZS8TOSBhl0oJB6MXbH39pR078yrPkB10hZR41btMX8L6gQxPkfcfQYte7SzoHAk3ToplcxkTirLdx1b+fhyiqp5vjdyZibml1VGI05Gm0=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by GV2PR08MB075028.eurprd08.prod.outlook.com
 (2603:10a6:150:381::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.5; Fri, 9 Oct 2026
 17:08:02 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 17:08:02 +0000
Message-ID: <0b0979ae-9c34-4e94-b775-ccc3a11f0748@arm.com>
Date: Fri, 9 Oct 2026 19:08:01 +0200
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH 00/20] net: lwip: restore BOOTP, DHCPv4 boot policy and
 PXE parity
To: u-boot@lists.u-boot-project.org, James Hilliard <james.hilliard1@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>, Johan Jonker <jbx6244@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Francois Berder <fberder@outlook.fr>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Peter Robinson <pbrobinson@gmail.com>,
 David Lechner <dlechner@baylibre.com>,
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>,
 Heiko Schocher <hs@nabladev.com>, Pranav Tilak <pranav.vinaytilak@amd.com>,
 nd <nd@arm.com>
References: <20260928-lwip-dhcp-v1-v1-0-2060c7365b0c@gmail.com>
Content-Language: en-US
In-Reply-To: <20260928-lwip-dhcp-v1-v1-0-2060c7365b0c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0137.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::15) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|GV2PR08MB075028:EE_|AM7PEPF00000057:EE_|DU0PR08MB9438:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f30cd87-2d72-41d4-e0b0-08df2627f467
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|7416014|23010399003|366016|6133799003|22082099003|3023799007|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info-Original: yuktqShmmkMeiZGTogTEAEXLcusOnLxPkfr7IKRpq55n9U9xx98luH6cSuoBnDT4E4augrSyBMMACVBQQCHDlMRILYtqx4cVzRGp6d3dkj2rHt5NjtyrfLW1DtQHTjpIQnwyOY2geIgP0wiwPbzPpbND9pKdzbO2ivB990XhBfVwS+V/2DG+kW/elagjWwgCPIAZI6LR5mloUmTGwlHpsLqH2KWiL/y9udnmxEz6rS6Y9zQq564VSweCTG8p7EpIRf87gmSzQD+iIVV7spyZuwqVu0Nsw/OOcv9zhP5E5goLfcp5g9NTI0NTQQdEH3NDXxByAFc2/kT+gR7Lz/QyLZODNZ/39ymf/HqDblEvBlBkMAqRnJwio8CmNzwFncLTIFH4yk+UgRChddJDtphf2aM6Yp0boQO/q4OOOJAm6PJpkavDX0/pGbkInFS/+wTPq0VBrO3WC1sfA+5FnDRoj0YsXi2+qZuEoIaddzCVemPI7LDVAcQny6GAsGFe6uGoAdyJunKnb9WY8YCcCQnOTbJ16QpDcB/5855KAJ0VOZ57kbAbHofsXBTwEo5fl1cETCW3vCTvNCYgghOm47aTSQMFnMTcT9XI/a/IKfVYRskogVd0BSzZ45tHF/oDOIwlZDGOzmQMrR7F/k3ecfbo3FP5wyqk8q3oZx465WkeW1w=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(23010399003)(366016)(6133799003)(22082099003)(3023799007)(18002099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: X7XIm+S6teQmIqfge7ufTuw78i2dE4/M1h+uzbdIjnk9MqHZcrdq+V/qPafKe2gyv0jPqnLiWbZyR3eaJATVzPsy9lGvMGuVKTZ+dh+hynjTfhZdFnLZaLnJrmfMtDoC+YXZ4Q7UuBuSuWkWvEy6yIQIonAwtdw7P9KmK/zNNCGpPvVkU6QM0jAtt047/QAX6bepktKtHbVCA4EjHMzQePRnFRuR3jl3P6YVBLK6n2GT3yjyb3pTC8kdemDml3rfRkjNTEbeZiq4BFzTQg8+AnQmJ4EDPIkWAGVfZTad1NI5XcmPFqhx9w5hdTGsvT79dS/wM7qx5pBmTNeyLaDXjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB075028
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7PEPF00000057.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: ef23b0a5-7b4c-4759-65fe-08df2627e0c6
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|1800799024|35042699022|14060799003|32650700020|36860700016|23010399003|11063799006|6133799003|10067099003|56012099006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5fAMJnrGy7ZFBHkS/bdj+HzN+7MbFYJg617dVVX3buZESIkoNGt1fUtgrGXmf+PR2siA0KrEI1q53pggVYM3Zl5lagzFul9TUlB/AwvgUM/8EK2EsVPYAWwBksN9XhrNuOlFpUZk9Xk/XhQRyzHvkJEQ9qJTMfBPHgPS6jSBaNGJWPYtZOOv2x3qxvVDMLsWk9csBjcuqm0Yat9LPnx/mgLS2r9hYPMLkFagQBVbXARfcVwwoZ7gvNsM3t1uAOPHDeUnaOeaxzCSzOVdsRXjPGcfixKJjnBF9JtCitf4DulUc3X1SNo7icZLfYOqu2w6CgeK7riV9UEqA6EwZgfpDvhaXjl0ipAswoktR8KHdcE0TjRY7hta56L2qlC2eha4FW6QfLx88Ty7tUk+HyTgUqKcWnu2i4CLYHLlAgqUjpVdiHVzzyvlbdDnHTYR+MB7NnU33ELbjYLV7NRLuryDKwRuGq5PNyRm2Xutf57kaf7Abxt7M3HCQAKIGeBjBSOTjnS0kSHyMGRMmlSMwchblzbyqKxxNKuqH2xt1GvsTnf+8yJM/DnQeYZv6Tuj1wo5LJXNmpBq9rgRhQ/yiZGl16XbHFclJBlOcnxej5Ab4NEGQ+SmOq+6v1aN1paYSHmfvrHBO+Fzyr3kj9aNQMM2arIYn/0A9UU0d9h6Ivlw3d3Mlv7PfpMk0FW+IXe5+TS7
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(35042699022)(14060799003)(32650700020)(36860700016)(23010399003)(11063799006)(6133799003)(10067099003)(56012099006)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: o+XjSUbhaIIsSKy5a5DxSJ6aPdvGwIWFs7LEfPqA+d+jjYI+0x7t6i8vCJgK9gaNa8p04GppjEzqyhPnxRuVDeX+yKZCRke39NMGysmAIv45PgMFTYbI95ghZBGC4pEGfJl1REqF/r5/56IPVwSWXgUBmIHKTdgAjQQ+zf0Blh5XTOthuJ5kIyemythTD08bDnGC3oznNkRTiL7Vs+5Ez1jc59DMWVJv/seiWNY+vCtetQmazCZTa34kX+FjchsV861oevIjri2cObLPpylQ5F8Lz1/QyBuyJGtaDZiSL4hW9GB0Qusn5YdJ7mefbSts94t4ooB1WGgcNjiwnd17M4rtrTLArLkaMWuXU8BM9dmiwpCBEb2F6gwTnqMH+HzmWUkc1ouUdxwH4tIh1x7/IpL3mvHyqpFdZS7gaL4PdUBHp2bZxUi9YGLvwy8Z6VfT
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 17:08:35.5058 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f30cd87-2d72-41d4-e0b0-08df2627f467
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7PEPF00000057.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9438
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

On Mon, 28 Sep 2026 18:21:37 -0600, James Hilliard wrote:
> Restore BOOTP, DHCPv4 and PXE behavior available in the legacy network
> stack.
> 
> Finish DHCP and release its address-less network attachment before the
> requested download. Honor autoload=NFS, report unavailable protocols,
> and restore the exact autoload value around internal dhcp_run() calls.
> Preserve explicit filenames and configured boot-server preferences.
> Include the NFS filename parsing and ownership fix before the autoload
> changes, so IP-prefixed NFS filenames work safely without a separate
> series. Use the advertised boot server for NFS while preserving
> explicit overrides.
> 
> [...]

Applied to u-boot-net branch for-next, thanks!

Note that "test: net: cover lwIP DHCP autoload handoff" was failig CI.
I introduced a fix in the commit itself, see the [jf: ...] comment in the
commit description.      

[01/20] net: lwip: bound NFS filename parsing and release its copy
        commit: 47229db624ca81aa930ef0d5b40f8eca19dd52b1
[02/20] net: preserve the autoload value across dhcp_run
        commit: 49573b87232fc880c1d10ec9d058d882a16d4b87
[03/20] net: lwip: finish DHCP before starting autoload
        commit: 53a0ca3757fe1b0b72b847cc388aa46c4b9dc099
[04/20] test: net: cover lwIP DHCP autoload handoff
        commit: 14612c5376116b1abded0345098c93c40746eac9
[05/20] net: lwip: add a hook before accepting DHCP acknowledgements
        commit: 147112c42f94a7826852d45ab520f9e5529ce58a
[06/20] net: lwip: carry DHCP boot options into the environment
        commit: aca32aa41c7788c5102c8e203be79cb2230f11b1
[07/20] test: net: exercise lwIP DHCP boot option handling
        commit: c3c69f756411901ee1f5085490605000cae11ebc
[08/20] net: lwip: export DHCP DNS settings without a resolver
        commit: 38e940dc034f5eb2ba342fa58328bd4609feafc4
[09/20] net: lwip: honor configured DHCP boot-server preferences
        commit: 3f171c1f644c1b7241b466cb1a28386d3907a6a9
[10/20] net: lwip: support PXE client and configuration options
        commit: 4c6e14eb3c75b3f2e4fdfde5651df90789f04e21
[11/20] net: cache accepted DHCP acknowledgements for EFI PXE consumers
        commit: d47ea975d4f1fd553218c4f0542bd95c1a3b0333
[12/20] net: lwip: honor DHCP timing controls and request header fields
        commit: c2d2ab86c68f3b9c502a51cb5f129e8736506e84
[13/20] net: lwip: add a hook before parsing DHCP replies
        commit: d90ff611c01e7fbf2fb89eee324f5086fab0cf87
[14/20] net: lwip: accept direct ProxyDHCP replies without a lease
        commit: c5a2e40d8dc2c53e88894636077585406117daf8
[15/20] net: lwip: retain boot metadata from the selected DHCP offer
        commit: 1a6bbda373e04a3375e27bc668603b8f080ff3d5
[16/20] net: lwip: retry DHCP acquisition using the network failure policy
        commit: d8eab34bbc4e57f6270b62304027de8d16dc7a91
[17/20] test: net: exercise lwIP ProxyDHCP ordering and validation
        commit: ba95f6122ad97a64437bb241b7c615e653533d7c
[18/20] net: lwip: separate DHCP exchange from boot configuration
        commit: ba218159ef300879bbb23ec68941f259d1f445b8
[19/20] net: lwip: support standalone BOOTP
        commit: 8effac32426a51824f649fcd034bb26ad5e83260
[20/20] test: net: exercise lwIP standalone BOOTP
        commit: 1a7e1472c170ecda9301cb7e9a72efbff07d2901

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>

