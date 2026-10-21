Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2B8606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 08:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BmlORx7A;
	dkim=pass (2048-bit key, unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=kFGKMULa
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6AEDE81186;
	Wed, 21 Oct 2026 08:08:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cS6pX4HinRRQ; Wed, 21 Oct 2026 08:08:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 718818117D
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792570110;
	b=Bk/pykUPDtn3fyz3quWKGyGUeDXBXToYifFh2gpCxqblzbTUE7mmu+EJ51rSf2+s2HHS
	 q6sABle/0+ABjhQ8n/hPaD1NA8bUhbg1769dLuJnpEPyaUxecJox3yYaTA02tlDc3pONR
	 jv7eNBNlppI5licn6CBvJhhD9wKcXXUt6/bEl4HAepKRE91Q2bZvQAkpifICaYeLJWKXQ
	 G6RmiTNkVi5Fu39OXonTBIgclUka05MK02Z7WJ1FiQb4KUZOTrzj7qq8tkVLxdFMi5BXI
	 LVdPSHzzh9mC01Mp1F+j5xc53szw7tbRThBltMAGUpUNlyvmVtr6R4R3IUu2trC7/fg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792570110;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9Pp2MZy1wMqGqQvXOUKarIKLaE1+xvfNIYqgNixT/VU=;
	b=bn+qJAtGVQS69tbXBS+os7CoUxATfvja7fZr6YcOhCxk0224W7NpXLGarbqrRjcDivBN
	 tDEgHDWH4Q1ncuZThTKQXuXH73JkgF7q0MwrNuX1Jw0e+fQH+9CMACT4DgcdkCmDG6bBM
	 mI0GBLOIR3tLCFYEQUodjlLqdMoXhr5pXn5bLGiUXfelwAF0Oun50bxyoe5A4PByFQ1EH
	 8nt1TPqozt01Pyf4YW/A1R1E0H7NaJcjPiz5MWdmqkDU2sQohgX1xNN4reAcvoABS8s2J
	 RB+0k/N+SQaMRVdm5MP6ykX2ySLhPMiJY8u0fvH2ncNhZtB1OxgiTRpV0WO67G5YOZg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792570110;
	bh=9Pp2MZy1wMqGqQvXOUKarIKLaE1+xvfNIYqgNixT/VU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BmlORx7ASCuQWZbrAzGZ6MPRKi1SNU8S925nY5tuIGyntcnZZES1DOZgNCPZHXeCI
	 akfmq0Ni4S5RznpgbiP+apvX6GtFPLrJ64GC9i14aFGcm6zRhuZdmmZIapHuRcnucC
	 M1LzrkuejtD+kr7Z+JQOi04W+gdNHlJX4+G7NJv2WJ/aB/21EG2MfjT3g3pp/mSs1M
	 VU0rR6ce3AYnuT2Rclzk+IOFvZdZweiDMw8Kv3VOXZJXRb9XZe1Dn8W12MoeWohyLX
	 ekfunBor6Nqj4f/E47MZbUqh1tpecGJ25HlsN4h9+YkyHmhpH/2dCVAOxYbCriNFzv
	 ODtapzxyTD83g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 718818117D;
	Wed, 21 Oct 2026 08:08:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0A276769
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 08:08:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EFD7F60773
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 08:08:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zn4Pth0SZWNO for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 08:08:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8A7406074D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792570098;
 b=mRnVtAR+Y3US0rrqPRAXtGVfhhu9yqLzx/e0gXDnZDGMaX3AFB3QILLF1NwHUiZT6zOp
 QECr6EGVPpRKbVeDE2T0AMPhBJ98GJJzVlEfjBzEYQ6IW+eqwLMGM301gnsKE8VXWMlbt
 fXijDDbTUmevoYKJYJ100IJw+s/EBNW40SoBpA5JHlQUqmZV5O8d0abb3E8bHSKMqQsPw
 2odep0jZ4MSKetcNYTAK+GoQr8VB3lhhDuulVRB39rRycxhfZJJBFitaioUm+0CoNwWpE
 uwhZB4oighUaD4hPnXGAtojmv0P6f3igU/FSdAzfuK1Xhxu9dQy7Zltf+HmoIQZEnMw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792570098;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=9Pp2MZy1wMqGqQvXOUKarIKLaE1+xvfNIYqgNixT/VU=;
 b=E7PI/TiHqR/uLx4GaIQclmJ+8insHRWhrGtFp1UMGtie2wi34bcauqfdw5jmWhiZXBwC
 5dAlYRrR6hvO+WSoQy5r6n1166yYl8K16qqR65iAjYtalT2DxkwbULXwpbtFdh9IjW92j
 5kGmKZ03E+WELT07yZM2JnQwPIzgptasfUhFYKpkOcQTZxzlJkOlWy3ukNOf0MyWLxMNP
 fqmwKrVWjNbDhsBWHfPBhmtatRTFOKJuLAFSiN5dp55nHbcdWQvGtIPHaMm9T4PDWTgkj
 hHAF4iC855vBR5Xr7Q5C/hBEdceDDCW+DaRj6r09ltdNw05RRwVEuCqegSM8Y35lmhw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=nokia.com;
 dkim=pass header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=kFGKMULa; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=juuso.rinta@nokia.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=kFGKMULa
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8A7406074D
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 08:08:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ET7tL97UJerJ0AGQLO+zWxhJCs+px2Q2Bm3xMRfF0JggZQrBGLCgkQYDlfY5NCUHKjnfEo8ibZII3UDn2g9AEZGEMc0jqiTRbM0QShU98YDzdy9O0LT3hXo5q5vQuIYjMxc0gNFLl0Cj793cgdBhVwskaHZR2eL+ctxJuEd5cNsFiZdNnGayqGRAGyHRfgMEAeEjFBcXcSg5JRxML/iOx4wUHXJzO5wD1JfeWlcEyNy/DLg0g7PpiAtgOn6Acs++roVtA5er995Hi2AwK2gVipcQLX7iHBmCM+uG1hz5L4Yp5I0iw+sAmUQFVgg215UXVq6XhZg/+CiFwjwgDLBv7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Pp2MZy1wMqGqQvXOUKarIKLaE1+xvfNIYqgNixT/VU=;
 b=up8golsC2JRWwujFv+QISHNaZYy6tOv6DLMzq7kNoN7P4zaAo2aekRr2p2f0dRSlOxSFYBoh9WoCiU/Bu2W2wznpDY/hFSG/MHkyCQDs/2Zeb5m5BGIK/bPnv+tO9Q3G8ZgEm5VUQtRg166RrK6HNF+oIzmBt4f1HSlRQNMZW1Jqoee6aFrgMvdcs1wLXl3qYLStZGh+KFlH+GM61X6mOUPUX+EZcEigvI7TAatI2KdG6rWTXoW4vaUXWntDUcIdmTM3OKCoB4Oo1gEx7Su2KB5s76pjcr7BjRi9AmhsC+iA/kfvJR9TmLy3Jdtel5BAGi+ghv1pT2N+pzdT2lTzVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.20) smtp.rcpttodomain=chromium.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Pp2MZy1wMqGqQvXOUKarIKLaE1+xvfNIYqgNixT/VU=;
 b=kFGKMULarMJUblzxU0WMFJ3rVVTarqC4eDe6HhuWdp/9ws/EBM1OPH37+YjdpSznGYdW507C01fWZ/mQyU3DHFXwmRf3F7zN2AiQ3v9tsqnUgV6Kr9EaSufNeS7aJl3nzOPvqykxmLqQ4Mbhwcvvurc5/L/SsMLsp8VSzO7lvtYhlgZf12C7vcUGzi89ZrtFR+eXTsFuwvJQQa/7NKqOevynk8sTsC2QWznFGgyJa81Vb+i1oe1/lVPAtauFi2+UEAusCCXm5VTubDsCvXyP1Rbc4ibcYiFpCkGakTsuXVzNlFgTdxEGISNhKc0XdwxdomQTmKOI5RhVQYyAGi8VpA==
Received: from DUZPR01CA0333.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::27) by GVSPR07MB924986.eurprd07.prod.outlook.com
 (2603:10a6:150:718::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 08:08:11 +0000
Received: from MAD0EPF000008A8.eurprd04.prod.outlook.com
 (2603:10a6:10:4b8:cafe::50) by DUZPR01CA0333.outlook.office365.com
 (2603:10a6:10:4b8::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 08:08:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 131.228.2.20) smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 MAD0EPF000008A8.mail.protection.outlook.com (10.167.241.180) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15
 via Frontend Transport; Wed, 21 Oct 2026 08:08:10 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 3885F200BE;
 Wed, 21 Oct 2026 11:08:10 +0300 (EEST)
From: Juuso Rinta <juuso.rinta@nokia.com>
Date: Wed, 21 Oct 2026 11:08:09 +0300
Subject: [PATCH 1/7] watchdog: wdt-uclass: add get_timeout operation and helper
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-rinta-watchdog-gettimeout-v1-1-e7f3157b8bab@nokia.com>
References: <20261021-rinta-watchdog-gettimeout-v1-0-e7f3157b8bab@nokia.com>
In-Reply-To: <20261021-rinta-watchdog-gettimeout-v1-0-e7f3157b8bab@nokia.com>
To: u-boot@lists.u-boot-project.org
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Yuri Zaporozhets <yuriz@vodafonemail.de>, 
 Jonathan GUILLOT <jonathan@joggee.fr>, Jonas Karlman <jonas@kwiboo.se>, 
 Simon Glass <sjg@chromium.org>, Juuso Rinta <juuso.rinta@nokia.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792570090; l=3178;
 i=juuso.rinta@nokia.com; s=20260428; h=from:subject:message-id;
 bh=3WCq+AQAPL6i6+X0ukosg7hh4+ptrdz6go8z+t1ftcA=;
 b=VaA/38eaSmVOTAJkT167ZXDdiUwuwJtrVuoUcWdcjla9pqMpddWkXrASmR4ocDyGR5qQ5k3Fh
 wTJsFbqSI6LAglPNp+m/Oj2GKe+s/nSuENLRE6H3LXkHETmiraiYhOv
X-Developer-Key: i=juuso.rinta@nokia.com; a=ed25519;
 pk=CnH7U1WPlQ4t8gHpzhFvPnTjoealqDnbmbLMYEd5GDQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008A8:EE_|GVSPR07MB924986:EE_
X-MS-Office365-Filtering-Correlation-Id: a16632f1-73bc-4c63-237a-08df2f4a72cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: dHHPNp/k4pDT47cfH09BPbOWLRCgYxZzCeAC61xfAgbq5kXFCexayldMckaLvm/LZ3cCe4Cjqpj8s5Q42B+AWtpeCEFm+1QNFfKTs6oHg+0UuUu+MucHtvoaOk7kpoQDYD1qLpKMvDWc17SF7MGSrHbVMia0KcuATM3XkLQeA1PRZymRndWZ/VyL+KmjoDFB3oWLDYxplCpuFsVHCYZmq8lECudjgrrN00LaXdNFRpipXym7kUQO5KW23Gdls+28hJ5f5FnxU5Rfk5cdq1N9TlBzT0qPe5vUpdN9IPRRtSoKzFoDVbBtlNOx0mZs39UFNmHWUlu83jzZFq4TBC13l5Ae30ujBstQUcLqUfN8dEnrXeQGr15vBMgQFq7cqUMDrizB+kIUg079wvBc80wycAGfksqkzKZPzV/7p+QkGB1xr8gsByfGsMth5H4j4DwPYZPoDaflx2PIJLFcGnlEOFXAO/2eZBEsQKFIPUewFqJr44axB0F7RqYTRxLvySFJH8mNO6v2woIUrd0lNysSoaCVS/AOLnLje9jTZilaSIgKJ8hfINrsaXeXrUy3n6IWVioCAJp0+TjQMf5Olz0ifunqunmYZaZexJdLKb/vyTpn0b6flT9R+ZpGCiz9yBTaTsl9/AnLujXWQKrGX/60r0Le4VBaKJus9Jtakh7c2XNublLcWlQ8g0IltiNSFgIjXisMKzNt/M0nDaRHbXSeLg==
X-Forefront-Antispam-Report: CIP:131.228.2.20; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fihe3nok0734.emea.nsn-net.net; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: D2z+bm9cLTOFFkuqrEQPQWgPIIEuFYh8s+1zWKJA8IO/MW4lMvAVYNARiy/SQJUecz8uD+smda+MRZD7QpnOiEWG4bSOeAbXG14pxdmz8EoBYvmfQwIgdmskltjjk8rgyQXhbsVQkl7uPUMio7zsvrgHesrHUMLNvgMxaHk/j+DAvRyqD92W5lWXY1a6e4eqCQtzSrmLHN9GHmtQpN3heBoGO0F1/ivt5PRI6+btcDeRwLSXMM3TY5Kw22gPfC+fU9+0CZoxnHbgOaUC7tch5lumAOftj6xUW9kD13KQGwcNlqlFoXq1huuYgvObM9eP3XnWniw/1awJRs298QScQlRV0LhcCGZiS77oLlj+ZQq0konPfFJmC7NYP6+CX6MUDUctIRy2QylK3SRrDuVJgIgOGFk9cClz/8VN3xPPcbIKBb3+FO9yy+FemOGP6zch
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 08:08:10.8731 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a16632f1-73bc-4c63-237a-08df2f4a72cf
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.2.20];
 Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MAD0EPF000008A8.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVSPR07MB924986
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently the wdt_start() function uses the plat data to
check if a driver has reported a max_timeout_ms value and
clamps the requested timeout to that value. This is not enough
on devices where the effective value is not always static.

Add a uclass get_timeout operation and helper so drivers can
report the effective timeout. The helper returns -ENOSYS if the
driver does not implement the operation. If wdt_get_timeout() is
called while the watchdog is not running, drivers should return
-ENODATA. wdt_start() uses the helper to report the effective
timeout when the driver supports the operation.

Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
---
 drivers/watchdog/wdt-uclass.c | 13 +++++++++++++
 include/wdt.h                 | 22 ++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/watchdog/wdt-uclass.c b/drivers/watchdog/wdt-uclass.c
index 88c5cbdf508..cdbf1bc2287 100644
--- a/drivers/watchdog/wdt-uclass.c
+++ b/drivers/watchdog/wdt-uclass.c
@@ -116,6 +116,16 @@ int initr_watchdog(void)
 	return 0;
 }
 
+int wdt_get_timeout(struct udevice *dev, u64 *timeout_ms)
+{
+	const struct wdt_ops *ops = device_get_ops(dev);
+
+	if (!ops->get_timeout)
+		return -ENOSYS;
+
+	return ops->get_timeout(dev, timeout_ms);
+}
+
 int wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 {
 	const struct wdt_ops *ops = device_get_ops(dev);
@@ -159,6 +169,9 @@ int wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 		 * rounding is ignored to avoid noise.
 		 */
 		req_str[0] = '\0';
+		/* Check programmed timeout from driver if op supported */
+		if (wdt_get_timeout(dev, &timeout_ms) == 0)
+			tout_s = lldiv(timeout_ms, 1000);
 		if (req_s != tout_s)
 			snprintf(req_str, sizeof(req_str), ", requested %ds", req_s);
 
diff --git a/include/wdt.h b/include/wdt.h
index db1faa321b3..10596fef6a3 100644
--- a/include/wdt.h
+++ b/include/wdt.h
@@ -74,6 +74,19 @@ int wdt_reset(struct udevice *dev);
  */
 int wdt_expire_now(struct udevice *dev, ulong flags);
 
+/*
+ * Get the effective timeout in milliseconds.
+ *
+ * The effective value may differ from the value wdt_start() passed to
+ * the driver, for example if it has been rounded and/or clamped.
+ *
+ * @dev: WDT device
+ * @timeout_ms: Returns the effective timeout in ms; unchanged on error
+ * @return: 0 if OK, -ENOSYS if the driver does not support this,
+ * -ENODATA if the watchdog is not running, other -ve on error
+ */
+int wdt_get_timeout(struct udevice *dev, u64 *timeout_ms);
+
 /**
  * struct wdt_uc_plat - uclass platform data for a watchdog device
  *
@@ -131,6 +144,15 @@ struct wdt_ops {
 	 * @return 0 if OK -ve on error. May not return.
 	 */
 	int (*expire_now)(struct udevice *dev, ulong flags);
+	/*
+	 * Get the effective timeout in milliseconds (optional)
+	 *
+	 * @dev: WDT device
+	 * @timeout_ms:  Timeout in milliseconds, written only on success
+	 * @return: 0 if OK, -ENODATA if the watchdog is not running,
+	 * other -ve on error
+	 */
+	int (*get_timeout)(struct udevice *dev, u64 *timeout_ms);
 };
 
 int initr_watchdog(void);

-- 
2.39.2

