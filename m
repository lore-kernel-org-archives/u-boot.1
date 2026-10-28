Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4185606A31D
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 16:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=W2dqbYPJ;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=rJFRFpBw;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=rJFRFpBw
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CCD0281141;
	Wed, 28 Oct 2026 16:17:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S5TMRPJwgjSO; Wed, 28 Oct 2026 16:17:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AB5E480FAF
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793204271;
	b=W4CytPxIDVyBfrGSH+xWB1B9PQ8YBO0epsKaerenClYaKPiKpl3dIz8Mt5tZB1bQ0Wj5
	 hQUI3P3+5YHJkaWD7ji4Qg5jqUkbNMcMlvzrkzIPhzhh8Ty97oG5onTv8HWz9lgG7bRSX
	 vCnajXpCHtiKxQKIn0cKv+TyRIhCNHEgpgWfCkg3DQnMzurKrCYzD2U5VNYrYvzQoeB/g
	 ylajyuYbmPRDM88zYzcHVqb7YJ84PZmHe7kcARVVEMCjT5WHQMUIllllY4DwJeyxQldYy
	 0sENeAl96rjESD1J7MEjHstcCeAu9Hbmy5lV+65fI4EZw41oojVtDfdZXgWQ7p+HMRA==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793204271;
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
	bh=h8fQF4eenS3yk9undYvoQmmhUPRKJzIict7zspFYtj8=;
	b=hlDq8RkpMf+DWq6cwxKZ81QCLO/L15eTFSiSrpfVcOwBHaWQDoeFt7A80wcHO1ySKWPX
	 tYg4MiYEwp4K91NGIxJxHvdknV8uqpOapeBgHl1RXnQnP39hmc8uohPzAhsQTtkYZ2ZLD
	 Oh7uykYz8MpdjvotY78ZXmCFZI7h9GfSfskZGA7puSt6UBI1HtFo3TILbfFOCIOzcUJrA
	 Tywmv7DEmKMwQWRIZSxKjbS28VMl7UZhlBhPhYXLPglHwi0eOVh9Pyhh5serfXbF61NL9
	 RTZzKnADxTcYvVdddsdPRWEIrFc/jw0FDY3mc37fwpqXXuublBfE5gATybefW7ExWlg==
ARC-Authentication-Results: i=4; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793204271;
	bh=h8fQF4eenS3yk9undYvoQmmhUPRKJzIict7zspFYtj8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W2dqbYPJSB/SEVPyL18R3oCtp6dRToM0QuYlQGC3LFOP+LJsIJVM/c16ths26RaGT
	 2AxFHBo+5J0eijLNM5S2mGzVQvpfP7b795lQ/u7hY1/eu7s4yIWNPAIjIG/+vDXVZM
	 mUPISL4ee/jtqX82zsTIiYyIvhMhygEBKo2unJuAUj7IJylRZelbw9LrjihNoz1rVx
	 4QRKmfofztImjKEYk41yw+QWnXt+Rsg3qKI5HE5xXt+nfF61TjSpbUzVCpjCKzza5m
	 R4SJLcFrSE39zue+2FhpzShEmFBBMefPTtHBcX197jAKE3+hkuAnePdwroaI1hv9eO
	 EVSa4y04UcFbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AB5E480FAF;
	Wed, 28 Oct 2026 16:17:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D97F54D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 16:17:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CB07E406E4
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 16:17:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pB7yfgXxfcmV for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 16:17:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 51BB3406D2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c201::3"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793204269;
 b=XQW4DhyDGMC9z1YIMkLPRfjlHz5E+/AkC0ke78PlBzXyXf5IrGdUHhqa5URh3M9z5GlR
 /WNrAkWomaRXvWNTlB1y0FmZXi3YLorF+iUkjJ84GqBTddZWaJGDtd3SylgZ7pqY3CAEI
 wNSTTo8Phwsg1sX+M9im07vi0Apd+B3bfPZfiA9Tv/pE0VVtkPO8aPtvhDnf0qyQXJ8hM
 T7jDUsUpcjx2TcSDJA6VjR6S/N8Mx5ij/taMObNCwHIwe6hwSKuVPmO07Jh0uF3XHflcF
 89CWoMGAbZK8gMks62DCDJuMu6Jt7v2KlQJQwJxBvWdm6VHpss2qcEmY7RK3c6ZEfrw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793204269;
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
 bh=h8fQF4eenS3yk9undYvoQmmhUPRKJzIict7zspFYtj8=;
 b=BwACGfjFdkGKCK1/aUeY0+fSGqh7YF7dsgMj/6U+Al/QMeMJ2W6QVCrA4NhZq9mWdqky
 lkQZoU72qHDLczvIhwLN7chxKGHscvWLjIIaOND+Uci8ddB5ywV98lA+G4liDp7L6rnt/
 1aKx4g75mKJi/1g1mBPII1WxKYvTcHq7FYVd62c/R+SNYd0VWAhJFhSDpPYOuyZcXPVXU
 Cyy7atVaHg7TeafYUi1Tn+IAefz8OzH515HQfnPPWmL9BOhvtCeozg+gUukeauz9zYx84
 wbciEGImttIm11dgZJcnojRLXUuWOCoVLOGqND6wbtrL+Kcvuz0gwMl5QoSmqUFQ6Sw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=rJFRFpBw; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=rJFRFpBw; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=rJFRFpBw; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=rJFRFpBw
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 51BB3406D2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 16:17:45 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=XJ5JwRIbQNdL9IU6f9KcAkww4K4nePOsRaUuGKcm2kMpJ8WDDUzkoykZqxHUsC0eztm9z4xsDETIjQotj7e9iPZB4GvY0pbUhsACL+idgs7DxmlGrvjrh8WdGtvJv0BTulaud6NIcsjNB+k6UqiwBj/UbavMjPkDTLcRQ0MYDosThu5AvQNlzFUMqqRde0KfZgiT5NRzmiFMQhiw/qKcr6NQNEMIrgy7J1AqZDz6cKSCKIPPAdfdx0auE8lZEze73G2QxcqUfnT/B4J7pBvsKQ4ctWj2+elmn6Nq8ffiXl3U13dxWCEpcx6zxtN8m9Nlos1E5FINQxzddSmPjh2SAQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8fQF4eenS3yk9undYvoQmmhUPRKJzIict7zspFYtj8=;
 b=lU+KF6BXQs+R/qsH9X1SKMYbM6uvs0nHL4jORhjz2KAevykWOcVkd4BKeyluJ9oFzqjwCjrdS7zQkbpazRsNouUinoW8P2xAdkSuIvwm+3iYnTq64dKUF9oL6FjDfKsUJm3zl1fPFE3Mqyt8zfdIqZ3XuNHlanYf6N26hiYiM1ZZazi6j487Ha89HHGe6jInDvNZ7RXeUfKxp5U8MzTLc8mQqxaS+2iaLB68Md50QC26zFEx/LMkNdDwqSJWf486GvBj/W3NrIV6uPYvohe13T8VPmTeDfpk9z8UtVPW2pQVRvVusd6U9RICwSzRuIqZBEKNFv2Sx53V3S2As+XG4g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=chromium.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8fQF4eenS3yk9undYvoQmmhUPRKJzIict7zspFYtj8=;
 b=rJFRFpBw5sWeisQa+To8RuhmR9rREU0Tr/8Mq1jpKWHUiTvZBOPlWyRCjX7ZwREH2SAe/UhDrjMcLtRO/4ufueSln24PQIt6cctXpupm+SPuvBlL0RFpJaA6RmYM20SKFasvRT2/3du7INxPXBCUmc86AzEP4FYE1lTRcCRGX9I=
Received: from DUZP191CA0040.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::18)
 by DB3PR08MB8820.eurprd08.prod.outlook.com (2603:10a6:10:438::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 16:17:37 +0000
Received: from DU2PEPF00028D0C.eurprd03.prod.outlook.com
 (2603:10a6:10:4f8:cafe::36) by DUZP191CA0040.outlook.office365.com
 (2603:10a6:10:4f8::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 16:17:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D0C.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15
 via Frontend Transport; Wed, 28 Oct 2026 16:17:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWKuT1EN2U0ZCr88Ve9Jvj2AejzicP03OQTRbW12N3hZc0AjuTKEACPm1uLlINRo+Z15PzDgW+SoTtGIYIj473GYCa8qTHDojxY+Ky+Nx15f/rsZ4BOk//11ZyVwTJ/deRPwhiGhZz+TA6lfmGmv1UgKYI6/saUhC8RcStmNGq+16YrCxcS2bNntzSDBvvZwz84/Mxc4t1rOI40GsseaQwt3eSbfZuEodych+cgILbWWdjUlFEjRxUEiFaKrytTNhpruPs+Tc0PCyTYIbK0WmDMdguuAFnSnPGs1ps+VHBsw7SL+dAEsqo/AekauaObKdvFpN2ew4lwk9ajwwW693Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8fQF4eenS3yk9undYvoQmmhUPRKJzIict7zspFYtj8=;
 b=ksh2diGk03FObZoGrmwkkmUp64duSAJJ6C6PnweA/e8lG/4UtJTMHCEPB6c3vOhgqxoBOnP8m1/Euw9+duqfV0kJUZMbwBhD3x8zgaPiuHlEZ6D8TumrVzWgf5MKdiDdZKNteBmnxFiqDwkZY25ozHQPjOR9g0Y3YxWNZiaLaMAhpNyZd52xrMWJ3KwaHxQARfbfuoCXP4E+qPUWZSjIF+LW+WzTd7X8mRGQgHOkvQX+3EaTW7pKR46KltuPAKFfcN7/J35XYsXZOcwo78mhZqoypzFHYtmiCv/kl9XN7J59DERUXtFst2bbmwWJpgG3balp5RK5TLLIxZRlOmXizw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8fQF4eenS3yk9undYvoQmmhUPRKJzIict7zspFYtj8=;
 b=rJFRFpBw5sWeisQa+To8RuhmR9rREU0Tr/8Mq1jpKWHUiTvZBOPlWyRCjX7ZwREH2SAe/UhDrjMcLtRO/4ufueSln24PQIt6cctXpupm+SPuvBlL0RFpJaA6RmYM20SKFasvRT2/3du7INxPXBCUmc86AzEP4FYE1lTRcCRGX9I=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by DU0PR08MB9727.eurprd08.prod.outlook.com
 (2603:10a6:10:445::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 16:17:03 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 16:17:03 +0000
Message-ID: <55431390-fdef-4c65-9d9d-6a4c1913a54c@arm.com>
Date: Wed, 28 Oct 2026 17:17:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86: Handle unordered runtime relocations
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 nd <nd@arm.com>, James Hilliard <james.hilliard1@gmail.com>
References: <1e33c183-0677-4432-973c-4d7d59a1b96b@arm.com>
 <CAFLszThd5C8p=bcgCGoFqK5_P07GPkuNfs3KRMRKbsFhiiDD0A@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <CAFLszThd5C8p=bcgCGoFqK5_P07GPkuNfs3KRMRKbsFhiiDD0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0201.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36d::18) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|DU0PR08MB9727:EE_|DU2PEPF00028D0C:EE_|DB3PR08MB8820:EE_
X-MS-Office365-Filtering-Correlation-Id: 02e24b8d-876a-4d02-4d02-08df350efb2e
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|22082099003|18002099003|6133799003|261026121527099003|3023799007|11063799006|10067099003|56012099006|4143699003|261022105027099003|261022075727099003|261021135927099003|261021121427099003|261022115727099003|261028144727099003|261021123027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info-Original: S+kB3G6xqJd4dCDDhJEwb1XOPAVwjg0w43YmYeUVAhn2dQ8Cx9W/BfL3kfuIUQz7j5826a/XIO+ZJ0ZLaqR+SlAvzYiOtrNwR0z67K0eRcT3ibbXaKhmhMS6ayCXDMEnW0qDG9YNFya2RLIDCX9AApFN2fqp9XCrJSGS+4yyPUeNfAHyla4VpzTCgPTxZq4sp80shtM7nGhBTXzlGYGcIRvJzzTr3W9VAbXlfVTDN8M4DxOdHKnMFo7QkhrtS2Ucrs+tMXypiPCSFdViMtuQ+sNoIH9ByCvkB/777hZD0eT4pRR8bBprQGLBLWTHZNNP7pqbDlxfjzo4OZNfMkLyRswp+dUAsoA3lMD6YuT2f1KwMuyhkl7EU/DO78+7/Sp9Rmi37wA/lBhl00JFm8P/rrF7F8dVo6NZ2J0gD+j7sm5hA2dyosCH1ZP/J32YeL1o9KVLcgf9PlS3i5l77JHVUX+9lXD8HG/2+ex0paKziYx0HGgmFnRMgV0P3BuhINMZzq6vc7aEwMzXL7MZ/TYtzsv820DgPRuxeGIA7qxDhiGPOeyilEd4m8yzspB3bELGJbfox32FwF1me6+SHMCzdPz5b0Ef9zRctz9SmVGzKP432m0ghdgyZT5pNM44wwGYAr/rRE8QgHnKC0OHqYt319HQhPZGKCX8ep+SeJA4vvc=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(22082099003)(18002099003)(6133799003)(261026121527099003)(3023799007)(11063799006)(10067099003)(56012099006)(4143699003)(261022105027099003)(261022075727099003)(261021135927099003)(261021121427099003)(261022115727099003)(261028144727099003)(261021123027099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: Zd75Mpbj1bYrgHRrGTY87KHuuLKRe7jYU5RdwQ/lie4zUz16sE1LthpkV84cws8uPy7x8NtJ/uqeWsQsd9kQwLlqxLPyw/2aeTKJQLaWHP8ofGGxbkClmrfNwoTNl4IkJyuTQvbyxNjuR/pUeHy//v28016l5iTStWmRxy5anDVQDPO8R3qPo+X4K5AfGhZKyCTLzVW8NVl0TJ21Y4lwA3fTRp9fskUtrbLNljvMr+h4vsitCH66jlKdBbg6k2UTAowlwVshjm0fqurF7zEPhiq1hriU0YwfeQ7oEHdP9x2A3T7MLBbIa7APm14FwB6BdTKbTatnGlVhgAcsVbeq4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9727
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028D0C.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4b34a316-1d2b-4bc5-20f1-08df350ee6f9
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|35042699022|1800799024|376014|14060799003|6133799003|18002099003|261026121527099003|22082099003|3023799007|56012099006|4143699003|11063799006|261022075727099003|261021123027099003|261022115727099003|261022105027099003|261021121427099003|10067099003|261021135927099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: BzAphtONcGFKfpSgAwAXQ8hrCWYGjXWXmSc/Z/2f6Snyp9jjHqcRBMy3tdlERdLDilwY6mRBWoOy+AyE845ck7+Rv03EmVEeSA7K9ifFYKG4oGcXo59ZlzF0odjMy66LT7s68/6YhbsZeGPNy23oQXkOO1izCUTnFs6HA9geonCs//2uvHqVejgu9zxVk6Z68yXAP6dubJJXtAAd+KjLM9zPJEVBWGo6JMqvNWtd6hqzJ9RNJAQryBq5eCgMOL42mPOHMnH04taLEjccJdm3Mj0Rp/wqdNcKfqGf9y95VtySA5i31DBmqN10PR5ns/nXg9KgqoRTaw5bgsL3/Afldv641QOXDNqogC4N9tnYGEAftH1tYKokw1wh2N5D6JXO6/WtAMXk2DnHjozAHXnizUY+A68PbSDkdNobuhWnIAT/xjWa8bV4FQS2gHhoAho6vIHMynJYq/pTcZcBIXTDNMZH3nCCA+e1RVCva0oot2Gd9CJnOt7zMeyKadwAwG6XvFzEfAYu/NmvDYaEnYbkzE4lhdO8snEwXqzLOb3G7r2RzqRS63NM71RLRS8UJhI/6MhraHop/ca/dEbouvnF4moYqXEeFVEhD8/NN4HG1F1twqW7/kkfgEUwGfOtU1EgGx2Rips2KHYoU934rXPUlpQ52h6v/2SEvXnNQfKSS4TfiZN0q/zMKQt8OXvy/s5+VOKUAsc21aw6GEEiaVdpiQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(35042699022)(1800799024)(376014)(14060799003)(6133799003)(18002099003)(261026121527099003)(22082099003)(3023799007)(56012099006)(4143699003)(11063799006)(261022075727099003)(261021123027099003)(261022115727099003)(261022105027099003)(261021121427099003)(10067099003)(261021135927099003)(261028144727099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ib1/NqgIKOYn4gaueVyCAPoG/LsNTgCaV81ZIJGhyb4ojdl0HB08nve2peFVNI2jFL8p8l/ieamcqUkQN9V6m8wYhiGpZZaTyBdLzCtkcYd/5ydErKCwoXoLVTaEPcb45XCo6wnM8ee+pfuvR1zq+Nzll1U72i1fN/Tv72UFVTYmCEp819q22UNtwnJxzYrNO24UFsn39AjEnsz07WRJkEpI36oRILnNOJy2WU9sJoVsZ4/RZQJBEYsor0arzS7jvhNl4obwGkYKn+hY3xBZ2CdlQvaNMxLrIMIIzdt/SASL3N9CT1nCUU6hZy5FZTQjrHL2L8aDnQpvQb1ef0oC/vM/zdRop/5Sjp3FQNn7DfZ+a9y39iLUJZv/CwIYMxhqd86mXPvII+tSq6qKwTlkPSMoETj9PmJ9bAY/40CEAsBKQ10W1rGqRFvKA/vT1omY
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 16:17:36.8835 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e24b8d-876a-4d02-4d02-08df350efb2e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D0C.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB8820
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Simon,



I have updated the commit message with these details. I also documented
the original corruption-check purpose of the ordering test. The new
lower and upper bounds on the relocation location, together with the
existing check on the pointed-to value, reject entries outside the
image. An in-range corrupt entry cannot be distinguished from a valid
unordered one, as you noted.

Thanks,
Jerome


On 28/10/2026 12:24, Simon Glass wrote:
> Hi Jerome,
> 
> On 2026-10-27T16:02:16, Jerome Forissier <jerome.forissier@arm.com> wrote:
>> x86: Handle unordered runtime relocations
>>
>> Runtime relocation entries are not guaranteed to be sorted by target
>> address. The existing code skips every entry whose address is below the
>> previous one, leaving it unrelocated.
> 
> Please can you say which toolchain or linker options give unsorted
> entries, and what goes wrong when it happens? My understanding is that
> GNU ld with combreloc (the default) sorts the RELATIVE relocations by
> offset, so it would help to know where this was seen, e.g. lld, a
> newer binutils or -z nocombreloc

The CI image uses GCC 13.3 and GNU ld 2.42. The image is linked with
--emit-relocs and -pie, using the x86 linker script which collects
the runtime relocations in .rel.dyn.

Despite combreloc being the default, the resulting .rel.dyn is NOT
ordered by relocation address in this configuration. Explicitly adding
-z combreloc does NOT change it. The failing image has 15,610 entries,
with 449 cases where an in-image relocation address is lower than the
preceding one.

The existing monotonic check skips each such entry. This leaves pointers
unrelocated, and both qemu-x86 and coreboot subsequently fail during
relocated init with:

    initcall_run_r(): initcall log_init() failed
    ### ERROR ### Please RESET the board ###

>>
>> Check that each relocation target lies within the image instead. Apply
>> the same correction to the 32-bit and 64-bit paths.
>>
>> Fixes: b50b1633c022 ("x86: Add support for 64-bit relocation")
>> Fixes: 62f7970a5a06 ("x86: Add error checking to x86 relocation code")
>> Signed-off-by: Jerome Forissier <jerome.forissier@arm.com>
>>
>>  arch/x86/lib/relocate.c | 19 ++++++++-----------
>>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
>> diff --git a/arch/x86/lib/relocate.c b/arch/x86/lib/relocate.c
>> @@ -117,7 +115,7 @@ static void do_elf_reloc_fixups32(unsigned int text_base, uintptr_t size,
>>  		/* Check that the location of the relocation is in .text */
>>  		if (offset_ptr_rom >= (Elf32_Addr *)(uintptr_t)text_base &&
>> -		    offset_ptr_rom > last_offset) {
>> +		    offset_ptr_rom < (Elf32_Addr *)(text_base + size)) {
> 
> One thing I'd like to check.. the ordering check came from commit
> 62f7970a, which says it is there to catch corrupted relocation data.
> On x86 the .bss is an OVERLAY on __rel_dyn_start in both u-boot.lds
> and u-boot-64.lds, so a stray BSS write before relocation overwrites
> entries. The 'must increase' test was a cheap way to skip that
> garbage. With this patch, a corrupted entry that lands inside the
> image is applied. In the 32-bit case that means a '+=' on whatever is
> there, as long as the value passes the target check.

I agree, the bounds check is weaker than the ordering check for detecting
corruption, but the ordering check was based on a wrong assumption.
I don't see a reliable way to distinguish an in-range corrupted entry from
a valid, unordered entry.

> I'm fine with the change, since the upper bound covers most of this,
> but please can you mention it in the commit message, so it is clear
> that the bounds check now does this job. The comment above
> do_elf_reloc_fixups() points readers at that commit, so the two should
> stay consistent.

Sure. I'll send a v2.

Thanks,
-- 
Jerome
> 
> Regards,
> Simon

