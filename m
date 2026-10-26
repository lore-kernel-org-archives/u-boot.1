Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E638606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 07:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Z11/YUaK;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=h7f4Dsuq;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=f4jsxA/B
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E03180D91;
	Mon, 26 Oct 2026 07:17:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gb9VQAmmieFa; Mon, 26 Oct 2026 07:17:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D471B80CCA
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792999028;
	b=SnxWnVYgkVv9YALJYuzDTchnf7wLQmA/+a5mHStHTnESlHB0vVE0qxxWbX2z5+3XufCe
	 C8pPmgWcp8flVF7mnDfcAHnM3glmzA9Y+cebc7nCmNrHhqoAk7yWvRNPHXbIMrCy8X7TT
	 a50jUZDUOwI84ujfch6BdtRtiX0k29v26him46KrQdTVpLaCDAmDz4Dl0NRJjogtbsNxa
	 athJeFyT9vaAg1b+ZOXhrtaafE6G1eURHpa2ry6x4s3YXhHJZFY2eUcghYvBweG3gNWLG
	 wgy/CqY6D0AK1Lnxm7VgNIcWtNWo7Qm2lt0hhqzP52Bb6Rmr69qt8o5qXdFC5XKW3KQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792999028;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:CC:X-Mailer:X-Developer-Signature:X-Developer-Key:
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
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/tp4ZwLj+eQq23BTbk7hzYYg7Hv6zNVZR7io8qg5ey4=;
	b=Fc8fwAUG62NnLNQ+bK7fefYu6sruRWY+6YGFdO9W/gSaHkHJkS5PVneEOEEzNpqL8wrC
	 7LOqBwt6m0kEgsGj3p4P2Z0E56vDxruZXPjHgob9Ske5HR5xyBxv62eIL9gaqIMilu5UL
	 aI5DlGcOngwVoEj9skuVDuYd52l2odJG0gUeTUkMr5dzhZfmN6PYTzrJDQnJDuxBEDILM
	 gx7n9ovQgVSBn70WXsp862dUt5CCmZJMSj1vkxN6XgUiu/q1RjHpfOaqaZNp+vJAyWLaX
	 vJWrkLwKf2vv/jJXaCy6/S8lw/b4DJyV3i2MY7qKmX6kyO2KTD+kmzepKk/mIrDCv8g==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792999028;
	bh=/tp4ZwLj+eQq23BTbk7hzYYg7Hv6zNVZR7io8qg5ey4=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z11/YUaKxDxvI0l1FcbZFAekPcCLhcJov0MdXz2J8EavyEl3JUhF9hSa9N52zBNV0
	 a3C+UyHtjqVlxCabQKE5ogTTKxiSuhT0eQnAPESoDnDw1EJt1EyBTCBkDU9jwlvrmU
	 j3cdoCl0RGePjhGHGt9SV0zzJkvX4IPcH5ApPwucxguPfABQTPJ+xRm21NgkSyjaAh
	 I7YGm7H4KF+o5pSSkyyMdolt6x9PxFLxLLXDnADwIg3dLJPQbY4aQfkSz50Dm3ZTXi
	 Vltd2h4MXY6op1MWgYA+i2EllkAiRDQbMd55bElasjN59m/OKwjF8l3K0ity5Etsdd
	 kirt7rmQK73AQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D471B80CCA;
	Mon, 26 Oct 2026 07:17:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A2E13D9
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 07:17:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5059B405F1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 07:17:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s3hpcx0u0e3O for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 07:17:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 42F3C405E9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792999023;
 b=PBQmWQOmjCZr0iMiv8a2sg27DW2WCC+yq+mW1ot6HhyTQgBTQ1SdMm+Lt6x2wrJDKZ0R
 6jCnZ/kU4pOyl3T+/kIJAuLeqslYwwCgZfXzubyr+wTHwxxz2qboVyRnuCNfPCuJWcMR9
 dBwft4ySbE4U3L7ljpsL9hsw6vazURkPAaiKdxpG3evcRbyGyH/kTg4WaHLNL8YlVAcjS
 tD0OdUoXj8CNt8x7QjeVEDPhpDb0qscqt1sjrTb10Cssv6MjrFcipee2bOrqNSeLkzxRK
 keeFLI1h6TkpsY2mjvdVvNXwL7IdaVV3VOHwOCZM1tSLU93/KIsDYDofkwoyDSr/YKQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792999023;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
 References:In-Reply-To:To:CC:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
 X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=/tp4ZwLj+eQq23BTbk7hzYYg7Hv6zNVZR7io8qg5ey4=;
 b=fgo2alx8zBv1+6kITsW2+5XSVf6IbATaBIStSmNHEhPw8P0SbwhWI3G9a8IP5PIGtgpb
 2Dv1kuoEmv2WIEolZrS+ZaIoX204Ro9nQUmJSHaMIIqRQUFflw+DbZ2/VZz3t7Z0KaGFs
 Xbn2moTA/1qultxaVVCqC/eu5LMKsKwgoxcLiQv2G02II3raG9GLF8VpsmLXsjiESrEjT
 cStn8FHHih0A6na+/7bEA7ayJGfwl3ZLcVjl8O9OG/HWLbuq13EzA5e4QW7AL5hPqmCHO
 wKgV/RUBS+iMa5Pd9aja6ef6ndisGRZsmcNbvif7OoACGjZhFmcMoQBLb2jQaJkkHAg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=ti.com;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=h7f4Dsuq; 
 dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com
 header.b="f4jsxA/B"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=s-jain1@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=h7f4Dsuq; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=f4jsxA/B
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 42F3C405E9
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 07:17:01 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69Q2MiLg3846007;
 Mon, 26 Oct 2026 02:17:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=/tp4ZwLj+eQq23BTbk7hzYYg7Hv6zNVZR7io8qg5e
 y4=; b=h7f4DsuqMJdu37usAKFEsP+1I6XK1rVYmctY2zK+fZ12JDTTkN4ftWCtV
 B5XEaJ/ZmkP/8kRuQ4s8L26nk3Wqq+LrKQObQXPjgyTmxU5tg/NI8EP1GkZY9OSS
 iu5JoM9slam2NkpoYS02f6gDV6nCLRgQ9XDpgtHSOI8KLCdyjF4xxjL/twMqoT7c
 q9jEyanXNL2B8dS9gO1xYsJT9N5tEcLfFoRP4BqXq36O6FYBgl/NguMDCRGaM1Q0
 g0EqR+qYRT/Rp/EdoBm65OJthJdRTVSVaAOcPXzcnG/EUD8FGsy7pzJ4T8XGMueu
 GoH2iZtptoRS0SxuK7RJ9dhEnZZ7w==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11011038.outbound.protection.outlook.com
 [40.93.194.38])
 by m0384305.ppops.net (PPS) with ESMTPS id 4hhemnm0cn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2026 02:17:00 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tOoFBGi52YmXG9SEDh4iCoOjZS0KHZPwAwl4kyo4VxMt+75RPW3OvWiAns+7nMn9AjW33yRH6ud3Ur0bxRrvXFdQX2NdqUul4GuzMIdXA49XNnqq6UFV24VEwngMxuwZ16Ta5bbF2s1cc3ceFIwMeimMb9pYxY3RR3HnkAF0kVGLRGma7qJVUHVvMgItIpD1scQfkCH7JfnxRXxoBQMf3J245j6Ekq8URujlihTVsaAdhwN5yZyNJXVlqLOLTpYoupZctPezmdOUbkkMe10RkT7On9z6LqENtABjIzpjnxDGr8lsDDDr2RbnuHyvi2ooAOmjilkc/4gKYbGj5emIOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tp4ZwLj+eQq23BTbk7hzYYg7Hv6zNVZR7io8qg5ey4=;
 b=v+by3tFSxO+7q8y4J+jWbq2oOfTFwIiUDtQLoQpZH5EkWe62SB2anpUgJoohCLw0BZiD1iG3C5Web8DkOtgy6KNoVr7xBw0WCD6QNYWpH17Bc9aKtVcczwDYNxGU6dUZ17abSI8kmuLZCJOfVVgTp5P10fg5SYjwKhzGN9NUZyFqxya3+ExLjH9gaiwWyYp1utySSML4rcMK+SExfkvcH3hBrZeJvOAmdCtkQ+xKevEH+k5EkL8/JYLlXUyP3oQHf7Wp8xEVWbZbrQ2X2RS2paJqIdnhkOA8qQ4gKqkU+2O+Kl/Zr760/F/HOQGiAmz9h0FA1pKPeXoRMdgc9OD8hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=nabladev.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tp4ZwLj+eQq23BTbk7hzYYg7Hv6zNVZR7io8qg5ey4=;
 b=f4jsxA/BWXUumAiHX1Am20w1D4zxzdCwD1SgtxGLIIO8ulfncpioOhJZ6ydAmG4zc6DQ3fVbgeZUWewRGDYDD5Zo3/ytm8nKFUieQVFdriM6LrdwhNHvircVsSf04FrnHpYULGutFAH/Rf6sd385O3Egv/fjNV13n7SpzsiEMeY=
Received: from BN9PR03CA0391.namprd03.prod.outlook.com (2603:10b6:408:111::6)
 by PH0PR10MB4646.namprd10.prod.outlook.com (2603:10b6:510:38::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 07:16:57 +0000
Received: from BN7PEPF000000A3.namprd04.prod.outlook.com
 (2603:10b6:408:111:cafe::35) by BN9PR03CA0391.outlook.office365.com
 (2603:10b6:408:111::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.18 via Frontend Transport; Mon,
 26 Oct 2026 07:16:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN7PEPF000000A3.mail.protection.outlook.com (10.167.248.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 07:16:57 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 26 Oct
 2026 02:16:45 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 26 Oct
 2026 02:16:45 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 26 Oct 2026 02:16:45 -0500
Received: from [127.0.1.1] (a0512632.dhcp.ti.com [10.24.52.205])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69Q7GgTR3511942;
 Mon, 26 Oct 2026 02:16:44 -0500
From: Swamil Jain <s-jain1@ti.com>
Date: Mon, 26 Oct 2026 12:46:34 +0530
Subject: [PATCH RFC 1/2] i2c: add flag to support ignoring NAK responses
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261026-rfc_i2c_nak_suppress-v1-1-bc01e8393b9a@ti.com>
References: <20261026-rfc_i2c_nak_suppress-v1-0-bc01e8393b9a@ti.com>
In-Reply-To: <20261026-rfc_i2c_nak_suppress-v1-0-bc01e8393b9a@ti.com>
To: <u-boot@lists.u-boot-project.org>
CC: Heiko Schocher <hs@nabladev.com>, Tom Rini <trini@konsulko.com>, "Swamil
 Jain" <s-jain1@ti.com>
X-Mailer: b4 0.16.1-dev-53874
X-Developer-Signature: v=1; a=openpgp-sha256; l=2210; i=s-jain1@ti.com;
 h=from:subject:message-id; bh=rmx40eP8aURvxK/yw1rNH9RHb+jNbaMDYzv3URcUmIg=;
 b=owEB7QES/pANAwAKAXQhhQx4u/uZAcsmYgBq3v5ZDtVk7wPs8EnKwsyjjWi7eZ3HK57343Dd8
 ksE5Lw65c+JAbMEAAEKAB0WIQSX3grxmEgbaU60Blx0IYUMeLv7mQUCat7+WQAKCRB0IYUMeLv7
 mWoGDADFR6G9yOkTiNnLtdB/yUTZJc89Vo4bKHhBD1raPTpzNIrti27/ZZRdcn/AE8L1GL+V/ix
 1i3yqmA9xE+v7ikO8RxzpdIqJnc9v3S1RCugvI414XyoxEFO3Y7nld3ZvOKQr/s4+83o85xf1sf
 8cRLi4Mbh/HDDyPKclnnB1hsBu86FUh5ec5qZ7xG7HJgdKx0//4KXyY2AgehwVkKR1T2RqHpGxg
 NHz1X7rV9cdzPPfJSbEh/a0Z+SpD2HsoRcnS1wQYTS4cHCoPRrY6fUEWCSYEB1Qb1Ck0xnd9R44
 6E78Y6KBdZVVZgtLgv3qqeXGJlN9T/aueXQdL6QRFLzhTPAG0/z5oYw04A3Sgk+aeEyp3Ua4+zz
 j6bsbnN8ZmX5t+MGQ19WDEs5JFv2tboksEBMVJxWp6c7Bl6GDeRkaqERvjhbNVwT1LIhtK81yjA
 wWCswoHAM0qWaTiZumEptcCi1wjR1tYHC1AMa/tD9Om4zshYKHzNvZPjn9K4yUg9YYrSU=
X-Developer-Key: i=s-jain1@ti.com; a=openpgp;
 fpr=97DE0AF198481B694EB4065C7421850C78BBFB99
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A3:EE_|PH0PR10MB4646:EE_
X-MS-Office365-Filtering-Correlation-Id: 00c15cd6-51bd-4114-328e-08df33311ec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|10067099003|260925022911599003|260925021311599003|260925021911599003|56012099006|261009223027099003|261022105027099003|261021121427099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: teaWi8LB/tqNTtGizojupkpHFFqNWZy9BmZGpwip3R0yGQ2ABzn0qEGuuDBEyeXPzx4zvV3gCY+yIwSTAQfFKsI30VqlxPej91ZXZ74tsSQ6qjTk1znj9iUjjy5EeUMMFue01hxsLkZo97MP9GYaRKDu6j30DrALgCrEmaPBbTDxw1W0A/l47cqs36WWtkd+/jPpqILbeudbhOcsNr9OYc71Yh8IkWxaz0F6NIfIOlH4L5cmxmurXBppFW39TKv+CHDM7hoTYAyPVLCpVIXNiXuvLCxQ2rzGNfbHop1BVV8MmoBLTpzCr8BD9Y2ldmVIjjErzi05dUWGc2HPORGGgzBZ4ATw+QmdoLoyf9BIFgK9CqsTjE2I+Bv6DqfRVdAUOwAm4ojquqWiSJoGrLsDdygBqvMsDPIXM5RdTIS7UzGqKlFTjAY0pwCsXTaWgJh0TewJymQp7unWFaQ7/GpGjCSZfKpmhehn9n3K6ntl4QPM+k64E2FD9IcPMlYtnCzoJT9POsDwR6Z0i8fhDpiJmB7EwhV9Fr8PttHVsjnRTc38o9F59+8c8D/8ygpJus+8e3wNRVx4ovNKKPz7Yr6ZFuDcP//Xgtoz0r4+/EfS7Fi5fkSqqGaASeVzwcnQRvSrreie70Ld+xEIBUb8uZ484ANebgFqsXdt6toV8YV8Us3kgVRPTcTBFDjlDWiFxwsW
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(10067099003)(260925022911599003)(260925021311599003)(260925021911599003)(56012099006)(261009223027099003)(261022105027099003)(261021121427099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 54RyJHktVoQbKSEWnIOBgPyBA0syBQvwvIFTZ9JelfcK0P7Ek+xQVaDsgN/5UnJzgmI+D0QfSUVt6oJdl9dZB3yWXoVGVX7kVyc5WPf2+9mi7RNw22w1l+TPVe2YK1MubxpFqe4sL7yua4Ak+YF6XYtOEeiyZ+yqvJKo3Vdzk0dDwam0qPTPpTsi9O9jEF/GHop3zAyinpdNPdwQuev+N8kAS9aqMz04pdxZYClTxZZkjyAMb7utJ9up6UvSJi36NfqXJ7y1n0mn/NVE16IlDjO4fwd/HynSevXnDHk6ITd1HcmePxCaN99oDp5lNdrqiYMJlP0+42OOtoMDvDj1AcwFFtQaXnhdwsW03eFbjH7nKM3r5nfJd0DS8F8NKj2Ng26nPVeVlALn5snvweHL9vRRqRNyojO5EBLPcZtkkiFelenFNOHZq+8S5kUJaKXv
X-Exchange-RoutingPolicyChecked: bmj5JK/DRI97p+t2T50WivZxw79Htx9rxTYLTdsh7oS1sfZK1aPkKVvUokw44fqIsfGdsiaHIz7US8ixSEbWF5xNUElS0U/pduFB0dnFlSIxjI49DIl7preTkrimoidXz4NYJ3taM3kQx7Wtjkk3GuMVpprjBP08W1xekwmFsufUldhqiVccYM+tQVoqbfsAr9mZJT48QXdm3s50oXMdOt1XfqQM2hDZzkkyZFRt9oyIdHw8XNgYG73TflLIp+77WeOuJClpZrIO26Ov4m4vBa1QCBHzx6vYzGZ51hrgr3Uu78vG0zATNzhds5Kd2Bz22lLNUo01NKxdClWJArQoRw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 07:16:57.1631 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c15cd6-51bd-4114-328e-08df33311ec9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF000000A3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4646
X-Authority-Analysis: v=2.4 cv=P4qvFSAu c=1 sm=1 tr=0 ts=6adefe6c cx=c_pps
 a=w8e6fJRD9yN2bKWo9pBaJQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8
 a=KMU1asjhICwJmo7gOT4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyOCBTYWx0ZWRfX8YhHxdGQTq+C
 3/aUwknZB8GOqfRrL/igLRu6zL44XdRWagw6j0j2JSjVFIEbjEOAWu2sgFH/8pelm5Gg1VyVAcJ
 LIT91nMrjLAcp2dqYrH2uBSH0YdGNPc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyOCBTYWx0ZWRfXxDW3iXXxjL7v
 g+F56U4UY0bQpCWIu9FkE/YB3lxQa8X83OAx6XqcH2fqJfT8jyWDCImeL9zi18d2yU+pU0HBByz
 r108KGLanfux+yiMwUGj8LIp1zmmYV7XZmFtePn3QaufmXmyhXVzz9bPCus70yT4cTwrk9J681q
 Uvq58EieDOMpoc4HS5z4hruSWAWwXRye1/DUJhZQNRx7bm2/+vxfbjkA3FE0sIKCgYyd4Fki4Hk
 3+iBYEhoSXgtEt6yHhQcu1KyXYjnaj372qBH6CjQkDJQukOa3ZGgY+OARsHb1+TpLEOvC54vYxx
 vX9zuJwO/fJ7fILW5JycVRu/v8QeT2f5YnaePqgqKRBdqgqRal9xaGnXZeCo09nN4I/PNZACUpu
 FOt5LU1+r3Wy3GHlO+ZKjn20qeR3ZZVJaRliwBY3BCdbyKfO7j8cbRnrEvwldLTdGDurnoAjwkV
 jm9Vqpx4871u3Cxrlaw==
X-Proofpoint-ORIG-GUID: iZ7bXSoZfXXFM05F9RpYMHCgUNXckeDp
X-Proofpoint-GUID: iZ7bXSoZfXXFM05F9RpYMHCgUNXckeDp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260028
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add generic support for the DM_I2C_CHIP_IGNORE_NAK flag and
I2C_M_IGNORE_NAK message flag. This allows I2C transactions to treat a
NACK (negative acknowledgment) from a device as success, which is needed
for certain devices that respond with NACK in normal operation.

Signed-off-by: Swamil Jain <s-jain1@ti.com>
---
 drivers/i2c/i2c-uclass.c | 3 +++
 include/i2c.h            | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/i2c/i2c-uclass.c b/drivers/i2c/i2c-uclass.c
index bb32ebd9981..f64ea4835c4 100644
--- a/drivers/i2c/i2c-uclass.c
+++ b/drivers/i2c/i2c-uclass.c
@@ -65,6 +65,7 @@ static int i2c_setup_offset(struct dm_i2c_chip *chip, uint offset,
 		msg->addr |= (offset >> (8 * offset_len)) &
 			chip->chip_addr_offset_mask;
 	msg->flags = chip->flags & DM_I2C_CHIP_10BIT ? I2C_M_TEN : 0;
+	msg->flags |= chip->flags & DM_I2C_CHIP_IGNORE_NAK ? I2C_M_IGNORE_NAK : 0;
 	msg->len = chip->offset_len;
 	msg->buf = offset_buf;
 	if (!offset_len)
@@ -150,6 +151,7 @@ int dm_i2c_read(struct udevice *dev, uint offset, uint8_t *buffer, int len)
 	if (len) {
 		ptr->addr = msg->addr;
 		ptr->flags = chip->flags & DM_I2C_CHIP_10BIT ? I2C_M_TEN : 0;
+		ptr->flags |= chip->flags & DM_I2C_CHIP_IGNORE_NAK ? I2C_M_IGNORE_NAK : 0;
 		ptr->flags |= I2C_M_RD;
 		ptr->len = len;
 		ptr->buf = buffer;
@@ -283,6 +285,7 @@ static int i2c_probe_chip(struct udevice *bus, uint chip_addr,
 	/* Probe with a zero-length message */
 	msg->addr = chip_addr;
 	msg->flags = chip_flags & DM_I2C_CHIP_10BIT ? I2C_M_TEN : 0;
+	msg->flags |= chip_flags & DM_I2C_CHIP_IGNORE_NAK ? I2C_M_IGNORE_NAK : 0;
 	msg->len = 0;
 	msg->buf = NULL;
 
diff --git a/include/i2c.h b/include/i2c.h
index b2572076236..69f19ae9eeb 100644
--- a/include/i2c.h
+++ b/include/i2c.h
@@ -30,6 +30,7 @@ enum dm_i2c_chip_flags {
 	DM_I2C_CHIP_10BIT	= 1 << 0, /* Use 10-bit addressing */
 	DM_I2C_CHIP_RD_ADDRESS	= 1 << 1, /* Send address for each read byte */
 	DM_I2C_CHIP_WR_ADDRESS	= 1 << 2, /* Send address for each write byte */
+	DM_I2C_CHIP_IGNORE_NAK	= 1 << 3, /* Treat a NAK from this chip as success */
 };
 
 /** enum i2c_speed_mode - standard I2C speed modes */

-- 
2.34.1

