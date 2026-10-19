Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 186FDCCF2DB
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 13:36:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E7A9980FA8;
	Mon, 19 Oct 2026 13:36:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4YyKwFcuA_ZL; Mon, 19 Oct 2026 13:36:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B7FCD80D7A
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792416969;
	b=P8n1PzN4bqlQjxv+3m7PcGhDzZkp5ZmxvuESWo3H5tzo7I/Xm7xJzx4pY5ie9gblbMrI
	 xms+fWpiJSDg26GgnNO7MNEtJR0IUzjqUlkICOrkpdo4pPvcnauYqNXxKC+aynwoImTiW
	 7h/z0KzrWhL2J+OfrYdI25eydsWLUt9SFe5Dk9UKkotA1yMdNsr9Ye3VhwWhB8/r2sQKl
	 8iOPjyHt+VTQ7BlBez76fy2X7gKNaRLVJ+9VniLJfECw7WIOZam7di7YVwJNcvnjexltH
	 wYJ3wPp9uXAn0rGJuJA6roQtSjZ9gYVpoByAwGwSSqbbo+tgHSoxvN8SWHcETSOOPMA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792416969;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1QoED+Key7dsZKhzZ58B4ftIt3wml+sTih2Q2Fq8aCg=;
	b=Kz9XR+VwEvB9dBJAhxuDgTnQXc332xOQieAMVDdU+3/f9VNHwekKzb1AV6sV3YLjqmOI
	 QrPY0TT37BCHH8RLeROEgwioqpzd65C+sHIYCPnbB8Ipup1C6/PhD1a/3iQv/pm7YKYLj
	 abyCg7WVyuVk2paG4+KnuDxZyEW34aFU2Wj6TXR4QMFTxZa4r0XtvEVcygnXtttMf3Qu/
	 fUpqU58FgEG9VTLHNLMAMyt1n2wS/eetZ8QKFcT+EgIqZww/J6TfE59cbET1NmmLtIZNs
	 R5NZK6UsmbdV4e2yeLuCHKdFiSy5IAt4XyyxJ6Tu+cqPHr5wMNzqmU2ULGVsafHYIGg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=Yo8TVNpE;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b="odBB+/eJ";
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792416969;
	bh=1QoED+Key7dsZKhzZ58B4ftIt3wml+sTih2Q2Fq8aCg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zRxcwhzIo0BomsVeQNzQqVt1JNF5Cog5q/l3wpMcWc3Z2TOxJXezY0fLMPNYFOwgu
	 ciKwQet7kPbdWOf0Q0HunTUvc2ut2b7HCxdm6Z0giKBctqVUxdW3hv6lqAyfp4BhR/
	 1VjnmYC3UVVUCtAx1LNQDV1lk7F4w1605lbCcehWNxhryJ9nqATDptsxjfClIqRYLL
	 w4iuBgvsVEhHRe7Dvx2FUKbCJUIgbpuWGzbRsls/D+lgKdSiqu/S/nH5+pR8XVF1zi
	 lyldjlGqoQ7x3uSDpQWOjDE5wZRSNFluHxdKXi96EbusKKrrr+CJ83TtivSkFrmYDx
	 SG/32Ml28Cnpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B7FCD80D7A;
	Mon, 19 Oct 2026 13:36:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D7A81AB
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:36:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6AA6C80D7A
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:36:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id klOiKQGCcs40 for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 13:36:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A537B80C42
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416967;
 b=L81yB2rLYFesPZGox6FAYRvyQueKLaOWz/tVf+X8hZxFDtLG87ub5c5/b0tUgKb2uXaJ
 moCYSYo/BALSmXhVTS0E++34HIHDA1g2REk4xtILT4Uy7KjL8qHS48zJvq8w4IqtJz7RW
 lG7R+Got1oA85qPqTC3R5rysGrdUIIP9LZiAhI9QWFbdHnVMYXEyIoISaNWB0kI8YzThR
 vHgRASeooFzIx7SBxGvJ0bKXWl/2Td8T7gQI3ogymeoI6RkZUnV5QaSqXVLTxQ4A88RB2
 sTDnC1Z/22UTNYrUK9plOHGQoKgqjV416uoiar0cR0xoliHJRv4YPy8jKSc8jsJKL1g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792416967;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:CC:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-EOPAttributedMessage:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=1QoED+Key7dsZKhzZ58B4ftIt3wml+sTih2Q2Fq8aCg=;
 b=bAInHPdiR3uAfKYA7XYohVSHhZUCr/c852J26ayLo5uyGIytyT7ETCZ2g2//OO6dwkWp
 5RExzcQRsFSrYQhjA7233zj1Q93K95CMIDv5X8zkCSfXRaP+V0/qfvDhUq+2CUGFm1kCu
 W1xlmst8B51AAQcetuB1YNxzwkk117OtMf7hXwOTTuSeOdwWVzHYHQeg7aDp8V+zr5HDO
 5k4a4Ms4r0ERQPa7AHb7xH1ZFvxeQ6984MSYh5Y2RyMeXvjE+JyBVrELIsn4wHsK6kz1Y
 w4XsHfkv/5uB0jrWJSawmo7lxYO08st12zJ3gnXy+ePnBwKOo3Lx4Ewyz8r2Pkvg2tQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=ti.com;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=Yo8TVNpE; 
 dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com
 header.b="odBB+/eJ"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=u-kumar1@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=Yo8TVNpE; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=odBB+/eJ
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A537B80C42
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:36:06 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JBRTI83810452; Mon, 19 Oct 2026 08:35:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=1QoED+Key7dsZKhzZ58B4ftIt3wml+sTih2Q2Fq8a
 Cg=; b=Yo8TVNpEAOyCpdm5Vm6VTNTsCFMEsL7D0jCeE0AmdkF0WiYtZziWLnkTH
 t1SYm6//M5F4j6ypgNs3ge81lJRBQr65MEGItb/CMiy06VaNiYcI75wEEoeyJH6M
 12QIWwyT3698EUTgmuisYMsP2dq0GZ2i8CrGJP1StR6RCpdrZPNf45GCqa01g/YD
 Va4xJhDxUfr8tTHQ4y5FD0ywhpg5eTWbz7Up3+x2ghI1JlPTV99oRintWssTj/5I
 OhNMt+LVHYlCWxeBGoi/A7lGwcXcCr6QiqZj4VZqH6MAGSmMIOnFgtwtHAuEPoD8
 sS6TKyzB4UWeT8I9wwozXzUk8ZbXQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012040.outbound.protection.outlook.com [52.101.43.40])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hdjbkrsvt-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 08:35:58 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ULd7x11/TUzGWN2NJRuNTOfZzIlAMn8ARjcuQonQ2Pw0Z4hb2tTGdgP2ehfXi5J7GmzNZezrDTBer1gccn5wTD5I9T1F7u27WmSgDNZifASGOyXtvy0u+XTONZQDLCWiK2C5XiSkSixJVNaW8KX+hfzwhubIJ7q8EoXHUcd2sHD+slHl5/V4EF0PiWwjsDrRVJYrTEz3KL5nqZSqjfwRI4YML1UJvfTbKVopMMIMcT21swkhJvtP59D8FTmo97FgNYMLsceIDrT8TI8lmL9tLAAZOrx9K6h16XjoApza5oOCeSsHj4aqzTAlTh9YaVu1EE8bVXm5cbBGKp+z6+j6Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QoED+Key7dsZKhzZ58B4ftIt3wml+sTih2Q2Fq8aCg=;
 b=sh2Qo923517jNZxmHF7L2MetfEX0TbxxK4sHnrWnpj69vkKkRpMiiy3gSwRO52F81FvoABF/w86p1ekMZkR+3T+WKtUyB1uQRsymLj/qpQpNGm1W01YCd4ozMGUXzz/iRkJQ1ebVjQPR256oA0+sUqfAcf6bO2GedtCvS9dZBft5LotApvrOsxN8TxoVvavdGlNu4VRJt4yT8xdmjwpb08gYxibxRaSTgU48tpH/0vd3zSKLsyo/a/GfBywZy6osAPRY+o/+lAgjEpcnmE+1cWGQKz0jYDdBCHThiNr85HcX2JnjK7z/1skaFCrjbwefl9hDRilBrReBHhlUPr2mHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=canonical.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QoED+Key7dsZKhzZ58B4ftIt3wml+sTih2Q2Fq8aCg=;
 b=odBB+/eJcJ31JOnhXMxrn87rEO6eugcxABjv088WS11qzqUZbyLKnXF2KiQXSpRX7IRq2IELK2mwtTNIHSh3S8HUNpHiqVixL6pvJCyR5fNfj6dXbs7h40wXShNJ4oaBK0VQMVCCBVGzQUyofftbSaemGuJk8Z8h21Dr3JBa67M=
Received: from SJ0PR03CA0061.namprd03.prod.outlook.com (2603:10b6:a03:331::6)
 by DM3PPFA9583E3CA.namprd10.prod.outlook.com (2603:10b6:f:fc00::c40)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Mon, 19 Oct
 2026 13:35:51 +0000
Received: from CO1PEPF00012E7F.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::3a) by SJ0PR03CA0061.outlook.office365.com
 (2603:10b6:a03:331::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.18 via Frontend Transport; Mon,
 19 Oct 2026 13:35:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CO1PEPF00012E7F.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 13:35:49 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 08:35:09 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 08:35:09 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 19 Oct 2026 08:35:09 -0500
Received: from [10.249.135.178] ([10.249.135.178])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69JDYwvV2890511;
 Mon, 19 Oct 2026 08:34:59 -0500
Message-ID: <51c23f5b-9ca2-4ebe-8f3e-72d22e404617@ti.com>
Date: Mon, 19 Oct 2026 19:04:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] arm: mach-k3: j722s: Wait for TIFS initialization
To: Richard GENOUD <richard.genoud@bootlin.com>, Markus Schneider-Pargmann
 <msp@baylibre.com>, <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>,
 Daniel Schultz <d.schultz@phytec.de>, "Anshul Dalal" <anshuld@ti.com>,
 Aristo Chen <aristo.chen@canonical.com>, <u-kumar1@ti.com>
References: <20261016-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v2-0-c7ab53f79b34@baylibre.com>
 <20261016-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v2-5-c7ab53f79b34@baylibre.com>
 <be2d29d7-0ae4-4110-aadc-b418e4a7f96a@ti.com>
 <747b779d-e24e-4a5c-b6bf-760948d5c313@bootlin.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <747b779d-e24e-4a5c-b6bf-760948d5c313@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7F:EE_|DM3PPFA9583E3CA:EE_
X-MS-Office365-Filtering-Correlation-Id: a7d8f4ee-0d5b-42dc-6658-08df2de5e35b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|4143699003|56012099006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: u+WaSwrD3OaSln4SWDyajbye2cwRDfrsXUN2NHhWj0BVQM+iA2PiF58VOEPlH6gBCk4SXHcz7xvdjBxf8Sc3wyg9ZvbUZOXIz2r5ZT+1hRLMDcesJ4S3rLx3fAnJVWNV4oeJhKYTGbpBK5OPXCPiSM5XwuEGDBsv3WZCtxiDmrQtu0m8GEs/qe4ynp+FKB+9G6T0YFUT7rJT7r+/P+hN7GY2ZI0XaXt/ts7/p0dzqGJJtJDaCSoOOKqpNgS+epX5QtZpiJF0f8Vmg1SxrHRdpkVkeQKZXe9Qb2by1rWqsPzhfoih1iVPm1pbiJFxAzdUDqjrO1QLztY+97IfsWGb2pn8g/yBuq5Fuf34kOFsVHHzQt2oih/xjpTPfxtfgh/T6ZS8KKgt0ePtriZeBjefXssar0srNewbwyYeN/dwIG7lbJ2RVCnA6mSq1PFvgk2inffrCx7KEaFyAqmnMGLiftjOuibsZo+N76+QngqsV6FeUXmYBRpYuhVJEevEtW6dRbuyCXzoIB8SAGezEGyBv3fNR1JNLVv+ddbU3fEruwGvDJz8XqfIrYM9j4CUhIKzR5J+w3cSNr+nj4obojOigqd7qTgv0edOL7VsJ65tEOc/frUDxWJeuPqSin/Bl4RIh30EfEIROL3ztk94KPZh0evbzQ9G9gD+A5o7MGW/2LE=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(4143699003)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UC3tU2HJa3b+iz4Cgst5kxeRmTRDUCm58Hay6N98IjSrgdHC1bK7jdQgIQLcd6UmynVCX+11b8YTmWsJPMmjYAibkHTlIu81Ea+6Fvg0xhQ2TfKr/lmeJz5skBLb0RZ383KlaIspgmXYAp38HirlfwWiZxhp8LT5525S7QgIfKHqfqK328Bym44JSmCDSelS8sCYk3WBQ7JQ5SwJWzWRjO6kFrrHhce7qgXGSeAysMXHA5fTyQdDyHxkN+xgEk9KkhKv3fF/QAfC7j92rNDcdwM+4ql52j4Aw+NIXEgnvqL8YERPdQzP1WRuRBXdlguTY3W4E2DiUZZ8o8LzyQq9PSWvCOy1ZGVI/szfEQjiP3NGKfAmQF9hP3LF+k+/BTmtK86ox9ripsNxtepzktQbhtNuGuECO8AnrFx5YlzX79xwPuFo3Fz/7FMbnfWornA2
X-Exchange-RoutingPolicyChecked: XzkcI3jwNt88d0IO8+qDebEhLwoL7pl2ykyIOKwJJ7/rKGvFjC3K8pJrkhy65e//MKfUnn0gaHErtaRhEp0SF9PZOToPSL/eEicwc84DpJdEgNlcCVh+nIy+joW7xfIY4/Zl9w23dSjGAeVReZT/B5K/BnwJ9qGgtQzTsmKlXFvvDeqbJCBHDn8WdsHw1KcWu4m+6e1OwN9SaeXCkQMyfIzH/M/JVdYX767dsBH1F5Gem78h7RpzhcHYG3Wy7N3A4vBntVa/uw2wL8URel/mgkDEW0OzgOXwlW4pfuUVzDnq+2tHSAkwvGH/I1pa6fWi3Tvg4R9LxdGvambQFi3W6A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 13:35:49.3754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d8f4ee-0d5b-42dc-6658-08df2de5e35b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E7F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFA9583E3CA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1MyBTYWx0ZWRfX2TI22NQj7hzU
 U2HsDG7XxGuxB/C2iIJu8KN9GqbCPQD9/V5CRRUgGaBIMF5TK1FrLzx74L9bmyoJqUxF+NIQUzh
 /ptJMukWSTjCqYt5GssnWQTaaKtCiI3vooGXY3WQZWx6jEPN6Q8wbZ5usuWmvvcrssnes3WyfwY
 BllhI8CHd+k4x96voUL7pHR1ox3GNlrWWx2z16HVANqn7jlS74ihlSj36vY034t9u+wXXgaoBjw
 duB8/SRPUTyGBnBvN28mwJg5Wzf4U/xgsD0SPDHglPcth1/tmI6aVrl8fnZfnrYaDXs8tPiOKrF
 V80ZOiLK92LVnFZhq55qKiL0H0xtoys7p4iYpUYAhcc9CWepwWF8ugIsMlgpkybgvvcReWxuYd+
 V0oLwG6l88xdlelJttwQGaueB8NZ1E5EIONY5hnepf0N7QXBXPLQWfMaRQRZZvd3b12Zoxy0gmi
 gowpZK8Y1P73lfHGmvQ==
X-Proofpoint-ORIG-GUID: gRBVHaA2d2vOERzY9dEQjF2zIyHEgmqX
X-Proofpoint-GUID: gRBVHaA2d2vOERzY9dEQjF2zIyHEgmqX
X-Authority-Analysis: v=2.4 cv=Vsa2kO2n c=1 sm=1 tr=0 ts=6ad61cbe cx=c_pps
 a=cXHsTeABgwIgPhuKzetQTw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=IpJZQVW2AAAA:8
 a=3TH9i9oSrZIpZTrtcu8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1MyBTYWx0ZWRfX5Tc0U3axxtJV
 Njz2RJvWsgBV+leDmx/JYSmmjGeHgwKnBsok8JvDbMEVJPYi6JcfvPuZqVY2l5lHemGjQEgRtIi
 Izf5THQoDx009CJ7FDclEN28G69GPPo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190053
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



On 10/19/2026 5:46 PM, Richard GENOUD wrote:
> Le 17/10/2026 à 04:40, Kumar, Udit a écrit :
>>
>>
>> On 10/16/2026 2:35 PM, Markus Schneider-Pargmann wrote:
>>> On HS-SE platforms TIFS takes longer to initialize. TIFS only removes
>>> the firewall on the registers at the end of initialization. On HS-SE the
>>> U-Boot ctrl_mmr_unlock() can happen before TIFS removed the firewall
>>> leading to a race condition. This leads to a broken watchdog since the
>>> signal configuration doesn't succeed because the write doesn't take
>>> effect.
>>>
>>> Wait for TIFS to be initialized using k3_sysfw_wait_ready() before doing
>>> ctrl_mmr_unlock(). Note that spl_early_init() needs to be done first to
>>> setup DM.
>>>
>>> Link: https://lore.kernel.org/u-boot/20250815160240.3575140-1-
>>> d.schultz@phytec.de/
>>> Link: https://lore.kernel.org/u-boot/20260225051559.416445-1-u-
>>> kumar1@ti.com/
>>> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>>> ---
>>
>> I have tested on J722S hs-fs and hs-se devices,
>> Post this patch wdt reset got functional on hs-se device.
>>
>> So for this patch
>>
>> Tested-by: Udit Kumar <u-kumar1@ti.com>
>>
> I tested it on my LPM series with j722s HS-FS, and I still need a
> ctrl_mmr_unlock() before spl_early_init() and also another after
> k3_sysfw_print_ver() otherwise querying pmic fails.
> 

Thanks Richard for testing LPM flow.
I realized now, you need PMIC which is probed in spl_early_init(), so
MMR has to be unlocked before this call.

However below patch fixes wdt flow in HS_SE devices.
> Regards,
> Richard
> 
>>>   arch/arm/mach-k3/j722s/j722s_init.c | 5 +++--
>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-k3/j722s/j722s_init.c b/arch/arm/mach-k3/
>>> j722s/j722s_init.c
>>> index 1180c75f551d..c15b3b2682d9 100644
>>> --- a/arch/arm/mach-k3/j722s/j722s_init.c
>>> +++ b/arch/arm/mach-k3/j722s/j722s_init.c
>>> @@ -84,13 +84,14 @@ static void k3_spl_init(void)
>>>        */
>>>       store_boot_info_from_rom();
>>>   -    ctrl_mmr_unlock();
>>> -
>>>       /* Init DM early */
>>>       ret = spl_early_init();
>>>       if (ret)
>>>           panic("spl_early_init() failed: %d\n", ret);
>>>   +    k3_sysfw_wait_ready();
>>> +    ctrl_mmr_unlock();
>>> +
>>>       /*
>>>        * Process pinctrl for the serial0 a.k.a. WKUP_UART0 module and
>>> continue
>>>        * regardless of the result of pinctrl. Do this without probing
>>> the
>>>
>>
> 
> 

