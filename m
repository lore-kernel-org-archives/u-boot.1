Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5414D606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 10:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pYUMBzVz;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=JAxnX1cn
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2532980FFD;
	Fri, 23 Oct 2026 10:44:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wTI-B7FMFxl5; Fri, 23 Oct 2026 10:44:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5D26D80E22
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792752296;
	b=jqsx60BwmCRaIJA4L7n14nWVZ66AhOGYbdTvtBkBGtQceF1bh1wzq6AfVZc/phopwTDz
	 rTx5mYd1lX1vb+GNbmlY804iJDLkFvqmotZY6HNryOKZnZ6Fcx/le6hRTupIK+mGrVuvB
	 l0AmgaL8U05AXWvM0O4KICeyzYtAFN8dapK86Xtq90TUrf0L887IhG44Syap75v/XqV/q
	 1OInTrlqolT2L4/L5NL/28vuM71/tx4GAKqMWh4iUlDFCzVtzVWuwxs0rchFA3jAEcmSg
	 8abvIf96Gy9VrX7RLevEAnxznrdyIwseu7dsDRYCJaSagc3Ob9gQb/2jvVsnUUWicuA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792752296;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wohxFIQ5YmaoiVfx8cFj8bNkt1esTlFJlRz/uSwB3Gc=;
	b=Eqbe8Vf3vKF9hHWxbxAqIZ0EsWcUdHOi9AHZVM2Vmu/dBXDpwmayDl3MuwHIc0lK2Sc9
	 iH2CzUowB+UtLMKZED2TRQ0INAaDRB84KF4nZvxwCHw2/qK574MLsHQSJyFVtp+IVZ+3I
	 XhzxmHx4xkFkYY/iIHWzfsZZ/M0CMnSK5NgNQLR0IjUHBkTy/wjndohZ6KZs5NFiitPVR
	 ZY8H0YB+NPzEVBnHLbCnZAMJDA7mM0K1vY8J8jMqsqPuYuCi8S4Y8EfShEQQ90Hw/qO0M
	 Xh9eMHR5AOhb+fZXl656N0i/uui/+JX6Swnq7DYm/z9FKvRe2MTbnxx8esp5kqucfgQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792752296;
	bh=wohxFIQ5YmaoiVfx8cFj8bNkt1esTlFJlRz/uSwB3Gc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pYUMBzVz++bOWamdzhtRoZCnTRXQIDzfAThH8ugcEX2TgwIlCDiORQ1Wn2wZM8jgi
	 fhv7HBypzsMrdHejsfhxj8KXnvit/zQuuK9Fxmvioh8uqu6OFaDi8ZiTp2OWnpuV3L
	 Rwfkn4i0KluiB2kX85sN5BrED2VJwW4Fw3wDPROkue0gA6/9z8EVG3PZUHIKVciapV
	 cBk8N4jvoio2QKzpexL/LrkUCYqqhETbT3V73JRzP7vN3Zfv+urfwM8KkIp4jNRV7D
	 yYFw9NDKfwOcrMqREw43Z/RSfcK5vvra5ipEvAQdS61W99fNPAmgYbOZ981Sh24I8m
	 OozEy3gSP4nvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5D26D80E22;
	Fri, 23 Oct 2026 10:44:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 04B8949D
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 10:44:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EA64960666
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 10:44:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LFrQVbIs4V4V for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 10:44:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7974D6063A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792752294;
 b=msix3pkitJJNRhQQRqbulRBKs128ChDmhT8RwwoczrfyaGIAR632iFVJf0tnnX+tXMOK
 KtlaVzWxR/WJgzOnfTQ0L11Vm/IldjoH5ornFFIXo09f7XRH/qulws7HhuPjkwaiBa9PA
 VQHmre/pkHab4KhxjBP52kdd9xs6VH5jf+TcTwwJ9eX462euIwor+Fxm3lFE2KHZWrZka
 fiqpLYDe36XZUcYTCYaedjhay4+uCRKkC+USiMyGiUpPj702w07u+DzuhdvwLJ0H8REk5
 i8oCg4tR24x6txYdBVAcZatjtyk0j8Iyau6KPU3nsxjuqAECJ2KFJaHLGcVQsEytWHg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792752294;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:Content-Transfer-Encoding:Content-Type:
 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-LD-Processed:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=wohxFIQ5YmaoiVfx8cFj8bNkt1esTlFJlRz/uSwB3Gc=;
 b=e8RJIrNpsDUhYk3FNQF5QCM31EIEps1NOhLgfU3qcDmJ1KDRRUC43EnJ7NzMxPAH48n8
 ASZ5L1zk8ZsU8Hp5lKnmQYKm1WWJzMTxlVcUUyHpoX+kQ8xoo2bhDGProkXzp11v4cPa0
 EHvWCdSJ5HRValbU/EHdpyK9OVQ2X8+zkWDw2IKze4gHgUuMt5QPysWrS5cCFxq2oZvfq
 yUD13bzaWte168awI1W9R1/nSgUIgvjj9nQNNO4bs2vYyj5OFt6l8IxKrUGhUfCLiIyfS
 C47mV7H7wFtMvIgAQsGp7RoEtXOpjPRzfyrVJiOQCZ/CDbJajge1VA+19UhqD4pnyVw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=fail header.from=oss.nxp.com;
 dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=JAxnX1cn;
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=ye.li@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=JAxnX1cn
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7974D6063A
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 10:44:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sM0CvF066WyoYI9KKaV/QjCd0GR4QN10iG7Aum1eK3DeFlCnUBMZu7MUxqsmlAcdd1HVtI/EPPLagAkDcx1AR3o/6Hc3CVUZv9aULaFint5/4Nn81Dzd6IvanNNOXm7aDpwtUoQyoNXr+GjNjDJQ0F1XMvxoYnybg7QtO5IrF1A6EjBY4e2MwJuAZ5zoTBEl/J1ztbMuqw42UMQ6um6qMwxKr6jHt/u/VS82U4YpOYQS1FcqRTuVRqj/c7JltZespRyf9rMob9IlBYrxD8Wilz9lt/dDfwOgAxPnzFnJnjgg9+HJ+liNkMrq6DgweqrlYGpvEAEvE6Pkd2+zIXBV/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wohxFIQ5YmaoiVfx8cFj8bNkt1esTlFJlRz/uSwB3Gc=;
 b=eVi+6UCfsK8x0eB1HYXYKKCAdz6sv09FFq0+07CRzhIkuEoGGLdX2XDR7rg4SSXo+sMVl8ZsJw8WsvhigeMsxxKlBFNqlAgjlhZMyqaVwCmRej9yTn+mMliGMqXBg5QoWkMkMe0I1dei7MZT3wsmKqJ0l/zAkACyX//L+JLvtPxaJIL5R6vkuy+CvrJ21VidfFeMlvGCOybhV3H2UO2rpe4GeRg2zmU9lrIyg7IwnzaFD1x25WGfM28dI7JpNzlvKmjdE6syAMTkEyBhLs/nnNcTvy32hwitv/ZgC/qyQUYa92EJ3AhmwF6582Gqr04haTA66Um2YYFyT8yHTB9Wcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wohxFIQ5YmaoiVfx8cFj8bNkt1esTlFJlRz/uSwB3Gc=;
 b=JAxnX1cnC4GhHeJ4t/L1ZQWz00M8IP3dS9nGLZg2ZUrHnaae8nWbc2c3NETIA0y8qBJJu1pnT793rcriXDO8C97KeNqtpsG4Uid89mqm1CP54wBRshWvtsIrl18havjdO4RsNcgfVhZWO3LjOcEMomVC74ZM1wbxbY8w/WT1gfMVwwyWp5QFjdDg+dFEAJNcGb76BZpiSKnIE8WBzDv3c3VaS+l9pOzy1ivsc7/sW4k0UsDM5pftU6kQf4XLL/ln/0seslwS/LETUzFDuRjsqDwiAZTjrdbLTmgXl0APGRjdFAMbH9fRE2abYvgOGwz3ZFJzu95DF2AUM7WWPGWbqw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com (2603:10a6:208:c1::16)
 by GV2PR04MB11564.eurprd04.prod.outlook.com (2603:10a6:150:2b0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Fri, 23 Oct
 2026 10:44:46 +0000
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::da59:a278:1b1a:4592]) by AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::da59:a278:1b1a:4592%3]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 10:44:45 +0000
From: ye.li@oss.nxp.com
To: festevam@gmail.com,
	u-boot@lists.u-boot-project.org
Cc: peng.fan@nxp.com, uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@nxp.com,
 francesco.dolcini@toradex.com, emanuele.ghidoli@toradex.com
Subject: [PATCH] imx9: scmi: fall back to NOWHERE env location
Date: Fri, 23 Oct 2026 18:49:20 +0800
Message-Id: <20261023104921.3477975-1-ye.li@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0132.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d2::15) To AM0PR04MB5121.eurprd04.prod.outlook.com
 (2603:10a6:208:c1::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5121:EE_|GV2PR04MB11564:EE_
X-MS-Office365-Filtering-Correlation-Id: ac279847-4f07-4c89-b2b4-08df30f2a470
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|19092799006|1800799024|23010399003|366016|18002099003|10067099003|11063799006|261009223027099003|261021121427099003|261022105027099003|56012099006;
X-Microsoft-Antispam-Message-Info: EosF8O96ZyIdrShA3JuhPQFkU5XCZI+zUbyToSOFVqwmzvZCEWTVq1iI5q4a7M9jXlI/Y1zJcp5FmZQjqQRcWGFSgwPZcBVosL4q1HgfxBkCoA721AN9gtKmuGT1q65BKUzjLkKogIrOPFTqaKLxKp31zjfjqOsasSeVgASOvPPm6FIhIosI7zXx4ZttEC3HruKA6a0+o27bLJol3/XgEpt7C3+vLF+Rvgfaz8nb+vB4uv1FiTHxh+GyGkRBbJrn5MV8wcnXHShMMJfa/Fl0UlrmChYd/6xRQf9uJf2t33mT3bKHJwcJym9GFR+xiGyS9Ml0qPVQh047iX2o60wNlr0/tcju3Jk+/EU8+Rj/TRprQT/hytcXPC5QZFizSuF24Au1Iq1modYOwCvyl1SanttySxqHDeEP+PTgggkW2jTS+PBeCgg21NZqyX3cZB39AjhS9ZW4MmAAZwRLpVBBU9zVpPuDAKbkspVGS0gt1uUx8l6EYex+lmJIG7MzUuRU4ZDRC7/OzPFmLvoQOaM5BBpvAwawy/zTdwE2HhaQQL7IpxmRVV/IBRo2AnSoiQJMXA3hTX4zTvL3qg+K2sG+bNIirSlzeoKMbkAAiiyHvhmDkAMjtledeFHy8WZGkqkczJazElUxM3BxLoOK2iaj/9yAwV3M655Wwp7F9Aqud14=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB5121.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(1800799024)(23010399003)(366016)(18002099003)(10067099003)(11063799006)(261009223027099003)(261021121427099003)(261022105027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IPpbx/pCN2IUNWTRXdX+AkGGU/ngpEQvA26NJke8QYCXPaMlvN8jV0mJ5MtQ?=
 =?us-ascii?Q?pp4c7X5kRT8elaWCLXM/m0zh/B+6cVvQ/+zBIOage6A6MBi0Y+6dce80TkMk?=
 =?us-ascii?Q?iCy/tbuKYKz8TygnC0lDvf6cr8MixdAvY6ejE/jxTq1pDpWEFwOgmMqEBv4S?=
 =?us-ascii?Q?fMLNgqtFaaE9HvzQoKi8EfzkQ9NQp4He8HiSb5k281RFs5IMfjVBbQfOETrb?=
 =?us-ascii?Q?G7GsGfqgGAS0KUkROhwxA0wXm8WlHrWjW8LeUDwl+hOPGtQvaVbOQXX4PzAc?=
 =?us-ascii?Q?Zd6CsCJJR2TI+cSCuZkTUHkqXDN+Ff4fRH0nEmX1wLQ7kUK279zBCycc/N3o?=
 =?us-ascii?Q?h2K1ElN2HXR7fNXms3tpiFn9FLFwhJaq+kN0jn31Z6xWS9obw4W3Poagywhj?=
 =?us-ascii?Q?qubMlFYnhagtMaK3ddNUP8Yu/jwOjGptrOrp45QDTVJsnCWqLraFGJJaSNxS?=
 =?us-ascii?Q?WK41NFXHWz4Umjbp9ZUZCQ6yIIFpqH7ki2vKWwHJFswbt61h22xb5Gyk5Rnu?=
 =?us-ascii?Q?pOH8H05SsopgLnuXfY3QydmLTOPJU7rwGHkV8Y5b3CuvKjqiCbH4MUieOer6?=
 =?us-ascii?Q?e40zlUIkP4ZccxNAdT9NcCDav6mM0XUWEQKEM7nILyCCi3KIyWogvxhEifUc?=
 =?us-ascii?Q?gYA8IKLlhzu+lJmi5MK9grULWU1Qi27oM/laYjZAQcZggjs8huQ3+1d1JNo+?=
 =?us-ascii?Q?eWPSSe/tFUUmvy/1rBcSHypWzdee0CV4dEsvrzLuw5MXrSpbflOW4UGXAJjK?=
 =?us-ascii?Q?egKnkP4hHskbw/WQN4XBEEOvsugdGrNmmhTFtW8X5JMy3C9dioCpMAwZhUHE?=
 =?us-ascii?Q?zbhXg3m2KAquw6dLLqz3SRBlJAQAxQiPQysEUc1cOQUFR3JEjZugsBwQIcQ2?=
 =?us-ascii?Q?dpANpBjVbcoWjho3EhTnkwp9XcWS8ll8W/n9YDcCgEPrCPe9kiejG6uM/s4v?=
 =?us-ascii?Q?hCr4+zT8aK9KS06/jFnE9ZGinhFIic42NhAZnmbU+lySf5/C3ahmIXIsqQbD?=
 =?us-ascii?Q?24wqUyxPfImSq0ycFxj4gkmqVTj/HtZS8m4YuDwq0QW5eBGp6hnviBZ6kFDk?=
 =?us-ascii?Q?48NPOL91P9oPQPAf8HRUiJ29G1kFb/TkSESz8IWX+LTWg/nNT5c7mJy/X1xp?=
 =?us-ascii?Q?t4qBddGsrSxjxc1D6Pjj+eNQslAX8Taz1MdnOv1k3H0OHVYCBVdIab+23r1q?=
 =?us-ascii?Q?rYpZ+8ZywcE57wD2+r+9MCcVF93x2ZkRFawf8jZQoEkvp12Q1T02x0ZRXaV9?=
 =?us-ascii?Q?LVwiq8U5ZnFx/HFDxoZCcAoLIF9lVBnleyUfLjBPMgai9O9N4DSXV4CLeJsn?=
 =?us-ascii?Q?zS87v87bc4rnPzlEPSYFNTRvhyfC9tD8xrAZglAE9C+0dlcVfWnVr94zi51E?=
 =?us-ascii?Q?mrUh3I9pLHUpe1PDh9khnxVsHQQR8A7vvZZ5k+CWwTLIpe6lKylotnmm9odh?=
 =?us-ascii?Q?eMx9PJ/BKjDSF0awqXivulF3RQA5Q16U2ujhaTCHP6aGCydXQ9VtrGglv5n3?=
 =?us-ascii?Q?BfKjaJyjY6/hu/H0ILi2quQWuGXImUdyChwrDzSt5FONKUDNqGicWcJdQbu7?=
 =?us-ascii?Q?uG5lHmh5tNqgcOL4YJazMGjdE4vALCtq3uGP5+osBZ9OLBr96tf5x1GzFE7I?=
 =?us-ascii?Q?hKaZjPrgBTVApzMLyA9Yu3IETYiLS3nIpVyNebK7aj1CBJSbscRNa9LQ/oVs?=
 =?us-ascii?Q?bGCXf6W8/yNRXbaYPc0UPmkC4AR2s5Tx/PKv3QjmQMpDYM2Zn4vdT9yFBUR3?=
 =?us-ascii?Q?+rwEtW9ynZfNHdWDVKYCh5erZEBWZKI=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac279847-4f07-4c89-b2b4-08df30f2a470
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5121.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 10:44:45.9050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xTIU75RO4ChDbDMpGHUyhe60TV2OHC6KmN844CHAX9KG8o7Z3HfieqFl47UiINF+Yz2JZOulliP+IMorSh6sO/nHZlkbUL5zvmjOtRdbXoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11564
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ye Li <ye.li@nxp.com>

When no env storage is enabled, arch_env_get_location() returns
ENVL_UNKNOWN which will cause boot hang since env_init() cannot
find an environment driver for ENVL_UNKNOWN and returns -ENODEV.

Fall back to ENVL_NOWHERE whenever the selected boot medium has
no enabled environment backend and CONFIG_ENV_IS_NOWHERE is available.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Kjetil Aamodt <kjeaamod@cisco.com>
---
 arch/arm/mach-imx/imx9/scmi/soc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index fa6b9a0e53d..f6bb3733bd7 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -1358,6 +1358,9 @@ enum env_location arch_env_get_location(enum env_operation op, int prio)
 		break;
 	}
 
+	if (env_loc == ENVL_UNKNOWN && IS_ENABLED(CONFIG_ENV_IS_NOWHERE))
+		env_loc = ENVL_NOWHERE;
+
 	return env_loc;
 }
 
-- 
2.50.1

