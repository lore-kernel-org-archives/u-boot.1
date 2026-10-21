Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50FF606A31B
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 09:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cQzC1ezD;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=SYEql9cd;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=SYEql9cd
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B092407B2;
	Wed, 21 Oct 2026 09:51:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ORbqlfLiN6FM; Wed, 21 Oct 2026 09:51:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7B1D640776
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792576288;
	b=IVdca8iI0NEko8hd/QTNehYbrqb7ZiDfQkfLujrFQGjwveKnlqQqR7W/uhlAM3cmYhBH
	 /TeJ3r2bUjFJ3kgKd66h3InhTgQHv3QGx2ttEKNFfKYLLa1E+73Qqu8UK8+cLx/MDXWbd
	 wy73laD9pfM+NBqMBt42Ma9bJ+EOWMyReR7xbqpkm6eNrX1cgvst7OY5ApkSx4XUKWGoI
	 Gcy7Z6DStVWQdFq6cCiFZ7SBol8bFjCsfMNo/lCtRo6TAk3MlAQ41tYTPrq8JyP/vjirg
	 vBH2tpLAAJBzypzJwTWVm4h6kA3PpIzvtfJngDDQMEzTUY5/Q2RLDNnH0bY/2zJd+Kw==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792576288;
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
	bh=zzcUpY6tI0PDVuqYvtG5SpSvS1dHqpnz1mclOUbXfKc=;
	b=XB9192l0mCAYYZV/rZrlS6o92ygz9HmUbgLgMpFa+cZeCQbtPjUg5zrGsqB6aG0l6/Hc
	 di+o1HdfG9QJgKAb38zAal98TWsbSoV9NnRexY3Xl6xZpR6RtWcsdj2JrxpfpzAXZCjh1
	 94LljVALv8i9z4L+BavjjtDHPmcr366crD8ydpTH6CjNDFkRt0SLw+egLZ09tctheJdbO
	 4AsluXpZuaVEi9dYRSKoI+BIoRADFK229SqBF1NWiDevEque39gSttmV5uAjp9Bl34Jsv
	 STDLzrD/LlQNWqxx4FVxYtO3mrLHYDT3P8epGZCIvUTt3DIb7SnKb5NIhV98erHIojw==
ARC-Authentication-Results: i=4; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792576288;
	bh=zzcUpY6tI0PDVuqYvtG5SpSvS1dHqpnz1mclOUbXfKc=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cQzC1ezDsfSRWtbYNDsurC5ZaSu7VmoMAQV8/NHSGjMBw5x8E2pns2W8TQ+Wdg7cj
	 gICK0PWfyaL4VuAoQU4ZhIFDexrDQmA3fivbblX29FGUhH9zVam7s+YoN/rkjvi/Xq
	 4V7A908UzdjQ9uljojheqw2lszPtCyZRpo0IIi/60pbZtQTylnZsr8ugbdWX3D1ldh
	 BwMGYZOi+BEXhKD332+uAK+yi+UIG1mlKT4149VnJnaCUUcn/TOCHXCbBMgZ/MFjn7
	 k9B+EJrd3RoDy+7pC01KNWueImOdVLvoiScrLfBPy3tucTpSdosBoM3mKTfHIL1xzk
	 bFfTXdHx3gwQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7B1D640776;
	Wed, 21 Oct 2026 09:51:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 12D7A2A8
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:51:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 102C58101D
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:51:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ybisImW_n5Rm for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 09:51:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 488418100D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c201::6"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792576286;
 b=MjbN97vnH4VaTmuesHU9905Q6usGIn6qpR1ms7UzuLhsusNekQjeZniSX5f48IWG1X+K
 mvKpZDECjRSwDKORt7qJBVVTstfhiySdykrwXaX4lzLYVjKSMFjn8AGHlvBiCrQlsDgOx
 NC8kZ7iYQ22tOpqnXvcMaSV/psRMMhc8U5qDTfQPjt4dyYYDZgnlnb0IPI2us8ht2RDKo
 i1bqy2zdFRcMgSyuP0yI87TDFn55hvaF34kV6sf16JtlQ73J8qhdou/yl63ud97rUk0K1
 dsXAMv7E4cW64oDOOYlZV+V9111Qucq7rWXgsFU+GSxQAwQJxmsc6kDNHlewnpBNEiQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792576286;
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
 bh=zzcUpY6tI0PDVuqYvtG5SpSvS1dHqpnz1mclOUbXfKc=;
 b=Zyeq52z2xI0NPnKZ9Tx01cYDwAdv1KUh+AZJuEpGriQ293b4z2zjFVamXG47XPI/Ra7b
 WypjE4dQlaKyWZolZwSALk1AOZEb1HbqTJ1MfW5Py70Y8LntqapvdsjH4xhJ4QoAZYm9W
 3d/RJeSkENpeKSnH8k1li+1IvzUJb7oHDBwrlHJVAvPzqVfQgBnnLpySN7KzNhSNrQ1Fv
 R0ZRXZY7dL4h0yGBIWElAxw1kvxf0aQuZMMeMAujEOnhrinj5+F/v23W4O+77xnJBpKNW
 qN2NvPbm20q93bthvpyq5jRioO6VGirNyFbC5GNUYnoZsl5jFXm2gPjBoPCEXQ/zuOQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=SYEql9cd; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=SYEql9cd; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=SYEql9cd; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=SYEql9cd
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 488418100D
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:51:24 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=jbgZX9Z35lIwHNeCn3+v5nr2tV1FpWZ/r+po87T48P30JflGlth8tOM6gXnf4QqVnJhm6Xxg+cbps2YpV/XGaOcxsVys2AeLE+Kx5on03nWVDJMBgIAhkQ0ItpktzAiUumr5vL0OpXoHN03wK/+Jtr3J1fg7rm73+M+13hxUFm931lC+MH9HElHh56ivpYwpGzI0kVHOPY5LwgebiTRmdpJa+B8yUPokXGIx0aDGzIWj09OTA/qgaUYU+j/xtMH5YFEv9YOXFlwQt7Ew3GE6ms4ZHbgZJbj7+ZQX3QrnCNpMz8EEOpMaQGh+vSA4MtBP2R4WaZ+L3D7nY1O06v6CVw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzcUpY6tI0PDVuqYvtG5SpSvS1dHqpnz1mclOUbXfKc=;
 b=NnC8+MvmouuJIut+YXmNTV4HQ6rizxS3z2Lu51duMvLe3lkmhulmw5XRYcciOdryRZTh/jajvIGxhFKT22jbm+ctK6bkta4LMFRayKuKXe0BVT8xAGpQzAATltNdvbPEfsgMiHVtGldkU9TQtA9Va8HXiGNukJFElDKAUF36R58SJTypH0Pqx+4YaCaGYuaF+bUiuNcuReIZ80+yo+mt5f8iMG064vMg2SZBXHv2pWqAD5vUO7LsPosJAflOwjhFQafK4hXv2hTy/ebm6fqsvntflArTw0lPe5awgYcvqtXIxz6ydcp8lvIEMHwb6rBUDWUkgMN5AFu1N+H8jaU5jg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzcUpY6tI0PDVuqYvtG5SpSvS1dHqpnz1mclOUbXfKc=;
 b=SYEql9cdtTEZjdi2gB2ZDVmtl4PJfjELA9AYGcFFIR82G3JCCCQtOSPetk19Wsi52v8loAoPU4YrCNiJ4tO/gfCeLMgekR8vGvfGyirc35NSOrSGmcnr0k4484p8p7cmhndScqEiJgAvmMAunarQOHtomcpQvfI3PBoQmIqsn/Q=
Received: from DB9PR01CA0008.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::13) by AS2PR08MB9617.eurprd08.prod.outlook.com
 (2603:10a6:20b:60a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 09:51:17 +0000
Received: from MAD0EPF000008B4.eurprd04.prod.outlook.com
 (2603:10a6:10:1d8:cafe::49) by DB9PR01CA0008.outlook.office365.com
 (2603:10a6:10:1d8::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 09:51:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MAD0EPF000008B4.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15
 via Frontend Transport; Wed, 21 Oct 2026 09:51:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hBRrARgn7rtSzcz1yTzz2iC1P1LsVJwlhAcjFiRR/zrainCV3HL5CokY8QL7U6+sUCTtB7LE70mv4InSee0jSJmsddI0F/AFpyRLKEMhUyIyqz822WCandh0vNb+BK8gehEclXMX7VBMGWOg4wd/FWjK2/anpSOQ3FkqYtIdOMWWm/cQzc4/t/fvLG7xaU+awwhw21OamPxvHwUcWbS095k7cCOtsTxgMeZ2yoV0cw7ss+pa4orcohhMwiRxn5Kl7+5cbdoOfkbPUnOk3s5zBzgWVQ6cAE+Qng6/S4Nu8wgI4qmVDpKwI8jcYo0Y4HhkAr0ejbwplREOEsm/I1lJNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzcUpY6tI0PDVuqYvtG5SpSvS1dHqpnz1mclOUbXfKc=;
 b=Fp653zBzZseIjUagTxI5Nzi03344jzXPhn/zmLnHsHzd4si6q5/raRn/RA5ztMto6ORm0Y2/chRfbAs42+Bg9gmpRbpwOhHlvV3fnt6zyKhKRnqx+BOwpGjLEEDUZ0dinGGU+0aEK/FbZiFAa1IqDcxgEFvGBAsBFg0UAgYymhVIoxwox48Ngc8/nrubHV+I+vBi3QKb/IsnllZLFD4+J4pyDh8YJc4sXkJKKe6QdH9b/FdfWx+4+VzmVDfaEwSjHUORS2kOkmDsk+0DqDsuvNX/VGaEvzUWNgEE07EWK7DBquPog0+8EMfSpwfm7prPCO0+U3pb/kPPyPBwflrzAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzcUpY6tI0PDVuqYvtG5SpSvS1dHqpnz1mclOUbXfKc=;
 b=SYEql9cdtTEZjdi2gB2ZDVmtl4PJfjELA9AYGcFFIR82G3JCCCQtOSPetk19Wsi52v8loAoPU4YrCNiJ4tO/gfCeLMgekR8vGvfGyirc35NSOrSGmcnr0k4484p8p7cmhndScqEiJgAvmMAunarQOHtomcpQvfI3PBoQmIqsn/Q=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AS8PR08MB9431.eurprd08.prod.outlook.com
 (2603:10a6:20b:5ed::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 09:50:43 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 09:50:43 +0000
Message-ID: <878c87ad-47c9-42ed-853e-916e5cf0c921@arm.com>
Date: Wed, 21 Oct 2026 11:50:42 +0200
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH v2 0/8] net: return -EAGAIN when no RX packet is ready
To: James Hilliard <james.hilliard1@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Anshul Dalal <anshuld@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Pranav Tilak <pranav.vinaytilak@amd.com>, nd@arm.com
References: <20261012-submit-cpsw-rx-eagain-v1-v2-0-c6a20425c15d@gmail.com>
Content-Language: en-US
In-Reply-To: <20261012-submit-cpsw-rx-eagain-v1-v2-0-c6a20425c15d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0024.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::19) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AS8PR08MB9431:EE_|MAD0EPF000008B4:EE_|AS2PR08MB9617:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d09fe58-c2e7-42ee-4cdf-08df2f58d9a3
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|366016|6133799003|18002099003|22082099003|10067099003|11063799006|261009220027099003|261009223027099003|261009221727099003|261009223327099003|261009221227099003|56012099006;
X-Microsoft-Antispam-Message-Info-Original: Zj8Ie7stG8HmTJV7oCPVgKcxrNWPrKhHg5qSD+Opf25aT5qGw7xsVt1QWOewdCdwjbhaf8i4S/5R7ebPxt8geC8hwefe6lZ6A5CTDORkfSJSZjTRZimLHzeE+HNSOXWRYPwYmG9ZztCGcONsd7gPE+YhOUoU3QQi4H24BeadPqY6ORYdMq43/j9vspegl4uK5CVFAqRSyQH21GZzkJnhCH0HhgqDfLTeTWfizFwD/X2qWPGkO64OleHZBK3L8AVGfMX/Rj3BloX/iPE8JQKXk5a6jbpPXgTUq+hirXuqNk1GUTixCHJ+0Ajm1+vKFkc0yZ2BNXRmChnKlDr2PGLISa05AHrOQ/hewXadtgVr4Jk0unmosTwnmM8vcOnWzaJ14L5kYV/cn+w9QbmPvMLLVi8Z1/JWly5xytJarEky9017NuHTPKdIf9p8/MRJHVhVB3N6a0H7wLa22BoML/wQo9S3ZWitw8qGaeBb0ozxeId9+ynnaVUfTcfoKIiVkGJ5epbDCnXjlh36g/Er8dXrKBTC0eUuLZXNXW03jSIsgUXrzChaZUYWYhpDDithZu2eFxyeKxajz7Zcr+6KHV/BqgwNKfsn7Lt2UNGHw9W4wQ82pb86AUn3cUHWCPooRP1u
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(11063799006)(261009220027099003)(261009223027099003)(261009221727099003)(261009223327099003)(261009221227099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: 5B4hO1c3EouBqXAczZ0c8Z+24UbvCwczUBBy9UHLFrwFq3aIRqI/X0qfQCCc8VniQhyVsPTFJ36bWzVOEuK4onjfaUkhm25ZIyVDqL5O0qZvJyVYWSNcwu/3AGuv2EhdVuIN+hkElEIoLVy0dgFmOuE5Svn0wFxupkHeCdTWbzxdTamWKzwInhumYiBt//nkEaUo8bbpDnNSXEorpapphRTl9ON5iktFUPxnXKzVQqROcuHat25HtQP0uKZJ7fNLl4s2PUwpOg/UO6CEVh/MsUmZkAKj55Mtj0gYGOsq4C05ui9lSXJXOMZXJsKlfyKCtDtXoocU0a0HN/7GXcdsug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9431
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MAD0EPF000008B4.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6aefe2ef-9b29-44ae-1fea-08df2f58c5f8
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|35042699022|376014|14060799003|23010399003|36860700016|82310400026|56012099006|11063799006|261009220027099003|261009221727099003|261009221227099003|261009223027099003|261009223327099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: BHZ8MQ0yoC8D4eoTbFf6FdBldjFvst/NsXsxqEXfs/cNJx1z8loVT6jwVRt+QRAm0QMnM3Jo6S86K/I15gs5x27FwTC74nBKI9IhONGSZjVJPWGxN9EtlyNQyP2VThof0vF64qhy4Og4WN5sxmViNm9yRQrOZiT3uiqmqvC74yuvRF5ooqmy3n5KbsHiovBUG6dyvK+1ZhpsU/961j8xb3j2V5PrGnm2PCmvWP4VGblz6Z69OJeYfESrxkv6W2SUK2GMCo6AOYlAYIhnKacLRCwEvOiWnTExURFkzgulWcpNWfVZcXCT92RFNqySrmo8tnq6apkVsi5LlbInFy7NUp1Z9WpSK1ZN6VR2prM7D/C9dazdjUMiIn5BXVKFVzsIUJINcEWO/7jxOGlSOnefFZkpaoUmapvoWVlEHOUeiBmWHnpkygkqIgIS51B4JusKdhSJXEIa6O8b9DPQPDgGM8Z9iWUEL/Q5zRW4GyXknUw7fk6qPli+yQAAmEqYkFAPfV39pmqyWxGdKLvaGHvgisJPQzaCx1D1Ry0j3bqrFBAw583ez7IZa0sDAcHgamwrqdP1zOZ0tji7C0DKi9X8Po7b7a7zJdUf7ZUIPjMUO0vbs3E6qyrHKCDqtfJSQs4lPyKtMJfKARrmKuga5pSwEg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(35042699022)(376014)(14060799003)(23010399003)(36860700016)(82310400026)(56012099006)(11063799006)(261009220027099003)(261009221727099003)(261009221227099003)(261009223027099003)(261009223327099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5Qrf2Sadgq8wmzggvAHEIGQfbgbL68L8gm6Cz5G+NMuKB3YrXE7yuInqNEwnH7mNvhD23G2vPWoNQsG0PNOq6ZH0wMZ5wUA+vNdqgsu0W9USRPMx9sFwBQeKi7nYQq+tWFMGXmLvVAWmybL98HWyMUb53Y7T0rZ461smF2WAnl6W4BUjzX8niFNtfNsqurEDKgEXF2Zsl+P39Z3R7CDxqzZAWFT6CDAbcewjgZAU2hvjoyrdk1m84rg8gva9YdyeR+8TWI6NSYckCt7F1vd5p9sq3MBts2JH+hsXcd3pK4+jlvzcl8vsWbHgMIMSY9vhs12wHJJ+HxYhEV8k6B0fTW5fhxL31Gr2iBH6RUtCZxK+Ci22PNgCQTE+weKqvsYmbHyvbm1b4kEeJnQuQ/eLcIOHyZrU24k3tvOQ3PoNvIYNCY0EN5ieHY9bOjMnoHol
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 09:51:16.2754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d09fe58-c2e7-42ee-4cdf-08df2f58d9a3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008B4.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9617
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> DHCP now checks net_lwip_poll(), exposing Ethernet drivers which return
> fatal errors for an ordinary receive poll with no packet available.
> net_lwip_rx() treats -EAGAIN as an empty receive, as specified by the
> Ethernet driver interface.
>
> Keep the CPSW fix from v1 and fix the same issue in seven more drivers:
> FMan, ColdFire FEC, Marvell GbE, TSEC, Xilinx EmacLite, Zynq GEM and
> HiSilicon GMAC, with one patch per driver. Change only their no-packet
> returns, preserving packet processing, actual error handling and polling
> limits. The driver fixes can be applied independently.
>
> The additional cases were found by code inspection following the
> BeagleBone Black report. Cross-compiled the seven additional drivers
> with both lwIP and the legacy stack, and checked their receive functions
> with stubbed registers and descriptors, including negative controls
> against the old code. These additional drivers have not been tested on
> real hardware.
>
> Based on u-boot-net/for-next.
>
> Assisted-by: Codex:gpt-6-astra
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes in v2:
> - Add separate fixes for empty receives in seven more Ethernet drivers.
> - Add Tom Rini's Tested-by to the otherwise unchanged CPSW patch.
> - Link to v1: https://patch.msgid.link/20261012-submit-cpsw-rx-eagain-v1-v1-1-0fbdc9751568@gmail.com
>
> ---
> James Hilliard (8):
>       net: ti: cpsw: return -EAGAIN when no RX packet is ready
>       net: fm: return -EAGAIN for empty receives
>       net: higmacv300: return -EAGAIN for empty receives
>       net: mcffec: return -EAGAIN for empty receives
>       net: mvgbe: return -EAGAIN for empty receives
>       net: tsec: return -EAGAIN for empty receives
>       net: xilinx_emaclite: return -EAGAIN for empty receives
>       net: zynq_gem: return -EAGAIN for empty receives
>
>  drivers/net/fm/eth.c          | 2 +-
>  drivers/net/higmacv300.c      | 2 +-
>  drivers/net/mcffec.c          | 2 +-
>  drivers/net/mvgbe.c           | 2 +-
>  drivers/net/ti/cpsw.c         | 2 ++
>  drivers/net/tsec.c            | 2 ++
>  drivers/net/xilinx_emaclite.c | 6 +++---
>  drivers/net/zynq_gem.c        | 2 +-
>  8 files changed, 12 insertions(+), 8 deletions(-)
> ---
> base-commit: 28ddd369e2f7199539cdefe22ce014c592b890bd
> change-id: 20261012-submit-cpsw-rx-eagain-v1-bdda0f670600
>
> Best regards,
> --  
> James Hilliard <james.hilliard1@gmail.com>

Applied to u-boot-net branch for-main [1], thanks!

[1] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/commits/for-main

[1/8] net: ti: cpsw: return -EAGAIN when no RX packet is ready
      commit: 40df38dd830981b00a257260983de43f883bb54b

[2/8] net: fm: return -EAGAIN for empty receives
      commit: ac07b58ba47f69bf50a4b5ec84890fb500289ce6

[3/8] net: higmacv300: return -EAGAIN for empty receives
      commit: d6fae8406e8e8641c9c428949ccc75259b94d2a5

[4/8] net: mcffec: return -EAGAIN for empty receives
      commit: 7927fd19290bd78371907a3e7a8bbf86c112cab0

[5/8] net: mvgbe: return -EAGAIN for empty receives
      commit: b530afa1cf32d3acd8390f850b5b8d4fbcbc2975

[6/8] net: tsec: return -EAGAIN for empty receives
      commit: 0b9a1026cbe26343d0c529553ae186895cc0b842

[7/8] net: xilinx_emaclite: return -EAGAIN for empty receives
      commit: 3fc35d33b5c24be293ee6294cf161f850f85e97f

[8/8] net: zynq_gem: return -EAGAIN for empty receives
      commit: 2f11f0a20f73e88f7719a5123a379910c366a4ec

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>
