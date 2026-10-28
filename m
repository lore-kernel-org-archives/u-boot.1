Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7598606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 01:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Omn6m0Yx;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=GHdd2bnW
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 445C180C48;
	Wed, 28 Oct 2026 01:28:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4suF1WHEJYF7; Wed, 28 Oct 2026 01:28:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0953F80BD2
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793150933;
	b=TKFw6VjdzWDqi/9N7isxn4eH7bdiuREJ189472viuB4o5seqc2MWk0zJDlskMjrb8jVX
	 R88v4Hw4ONxNxz9kI4g7ezKy2NiVRKX1zpQE0wrnAfeGbORWvGaGzNFC6WdMVrH96H6ln
	 yV95hLS0WhTEq9yrKFOC7INaR6XTSDUSmHMyuQdUJ3JMsQwDu5ZyN8e7QRgAp0KieLhnH
	 Jitl8SxsAog5jeRjGXP5E9ucaslsVZbsklsCV6CQNctTfWmEscMs4eBrfa9fjEj/UyHij
	 bT9EfNUhFmvtOR0b8/gntqS3doRdZjSOpkSsqYfVjSoIEKaSCjBEbN26W087C2uVlmw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793150933;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
	 X-Virus-Status:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=oEe6rdLkdFBEB10rVyUoYetDhpfFl3KR0NS5ZiyYtvY=;
	b=jHe/Z2y7AsUmjVILI/PS8roJYKz9em4NWLZoGJ44/URpYlPBMlnex8AP5y0lsD0XKAH2
	 WzPmqeBEBBlM/LyDJSRWyBV3TzrhiVVb1FQYWSfncLhpgzITg3kecOMYUe/0OMpbKaRFt
	 9vs18pV1XNxZv6El0o0P8IrESZfDx5KYsuNxDBdV3c2PEge0/4siA+qJ91icrZFukP67Q
	 kvy7LJs58VOpZ0IwReqwnZ+0yICExHTCw9TmWH3v2cqF8UJ/KZX+RbX1ICgdt0b3zu+k5
	 uwmN6knazdyxFpHDwZUYwbJwP5sN0iVsQBS1r0KyRRWieDB0uJxWhkDcyOwiGdxVStw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=altera.com;
	spf=fail smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=GHdd2bnW;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793150933;
	bh=oEe6rdLkdFBEB10rVyUoYetDhpfFl3KR0NS5ZiyYtvY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Omn6m0Yxl3I+M+gFSaQTpnf9R3xU/nv1ft3HPGfwx3WOLi+SblqgpSEEg0MS81Iu/
	 NbH6OWOD1NMgLLzqcE1SQuowp1rbAehZJ5Ondq1V31u+e7p333KrGu6MKItgng7YZu
	 jLWcomKjnUd535v39X3DHTrZoFDyQDEYnN+FmujxtolDppEgPZu++wQaG4r3MSw2P3
	 ckpON1ebTilhPxpCxJ8YfgPay29oIlte0eST5oxzANG7+8QiRkuNoHEJXvPB1GfEMS
	 JZ2Uy7jf5+b4FwGkV6rh9U/v2JT/Epk/xgUgBq9+J/AvSIexjlOpMKIk+gRBx4IUlx
	 rieDxA7gjJ/EA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0953F80BD2;
	Wed, 28 Oct 2026 01:28:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8ADB34D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 01:28:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7091880A5A
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 01:28:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3GsR8JMMbMtS for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 01:28:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3A8AF80A49
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=85.214.62.61
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793150930;
 b=Da8rltnGT39jCkLLym1TprxKN5okREBonK/3WVP1/Z2VLnBFgbylrKn+fNW+1jguUOEF
 MxRC8QgIT7odaIvGc1XAFUVxIlbXuG5uDgPgqpAyIgOTtNtFE1SXiwxDdnEBclihbfcCa
 SJ2TzbT5LqwTQAY1tJ1ey0hjNJPQRYGYX2ZGA2Apu6Qrwm7tLEdtv70WTNqbrQz60a6AD
 D/BZeFE9pC1dMp2nlqIYBv2AL8vNGagy3AAtnoCgyGqS1g+8KFXr5pb8EYAKMgoL0tnWQ
 isF+jTh98quzucwo9ZUeJev1zZarSv1LzvmxL8/BrJdMAoAW7XiNPoWnXZA1gPPk2gQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793150930;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
 X-Virus-Status;
 bh=oEe6rdLkdFBEB10rVyUoYetDhpfFl3KR0NS5ZiyYtvY=;
 b=qd7zM41iifvWwqE5n6YXBUUajg/qI2uDHiWlS+cj24u0v1JFTgXYd0U9TJBhUJsUXhQb
 /N9CJKe8TwSGcOx3vwLQYZdL3RYP8q4iRV2e8dn91E3N03On/mOewajtQ3bvhTL93Takg
 TbjXXaQ6P1+lD0pUpgOjH95MJm7mGqMwkBy16qMz88L8HICw+UbAgfw91o7fWTFtPE2oq
 cBlnzePSS1/HO8zy6oL6dTXDh+mStRuZ0xsm9HR1jhYHP0Iu5NuWhPZFvmuy0jpssencV
 B/WzUa4TZu16Tx8el8IIw0SdYwHOgLuODNCgHtKM4SPoJwgtcRh1TPQhLZkGiwDnJVA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=altera.com;
 spf=fail smtp.mailfrom=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=GHdd2bnW; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=alif.zakuan.yuslaimi@altera.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp1.osuosl.org; spf=fail smtp.mailfrom=altera.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=GHdd2bnW
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3A8AF80A49
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 01:28:46 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id C22BA84119; Wed, 28 Oct 2026 02:28:42 +0100 (CET)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62D8683108
 for <u-boot@lists.denx.de>; Wed, 28 Oct 2026 02:28:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CgY+pUXe+YZ14u85RdXdQwq4sUMHOARUlumwcT7VRtS57BO6nn5V1kl9AMtAJww0WxcyGtMrlTR1ApNOD0pl9ISHlC1gK5HIrkmti1lfaskhJP6DAZ19BEfpy4UUXw28w8kexWpglkjcg+Rakbu5NNeT/E53vMtQ11/262hj6U4PTag8rVAbRVK8obD2cLulvlb//25EA+GcRKeZZwm8FONuQ3yqi9QF5IEaZ81/zkY57jPrJ4LYvaGvfRp/Lt/AmrZ/2zH84ZD5bmMV4PhPVc18t/BVZt6uIKP1fsAAcQggw0+pR0DOpBWldsrXsbs0BHJBBT2po2rD9QGE3bPWMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEe6rdLkdFBEB10rVyUoYetDhpfFl3KR0NS5ZiyYtvY=;
 b=JoS14fDeflIxwNGzz7fiJ+UzkGqZEz/pBlXj9PEWxPfPYh8cS3wIVfSCRpHd/BOOtVZaMjPbocDdNgrx1ZqDTVHGaXwQ1tKDRY4hNMqjEFfvWx5xSwv2Y3jIWdkgWVpjKC+JE50nYeyYB+fbL4b5u7Gav4UMQe7V4y2Jh17kcBS5gRTVHYfctoYM+e8QNvbQ+wPPOFAIFEYSWuNJHaVkHQNWhqM/oLxKRWseo8NkLeuVbBidqVycPL2MnTqQhOiBoaaVPCyDqMnPvHoNaJqrvzjhiprvVSARIqfEft/Dg6b0ncYNiFA+pdxKv3j6WhTYbGBQ3KroFKcyHSy3Rf+Knw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEe6rdLkdFBEB10rVyUoYetDhpfFl3KR0NS5ZiyYtvY=;
 b=GHdd2bnWDT/YODA3K6et7BecjpYeLMMLyr8JEAB8T8I1VRUxcuKwZerHV6UksbQmxj89AiG2mCOTLc09KKLIIuYimXID9JrLmtU/eg2PUwBMx/ljWkZR3qIvITJNFXRURPmHmoJHdGOMvXPWf3y/TO14bkKW8YzAdZTc9FXn3z6xPrWl20M/hT4mPfCJ2tP4+RTkzN0QiVlMiNIM9I6WRPthXhCGbtWNVAcU6NojsdC7d1CISt25s7CJgX03imoj/mct/ItTWID7MBno56+G9wXyIY6BkBMH3ozOLh6PjicgCvk9idhN25Vo75Vz+UJWM2/ipbOiMjKzNkrTtOnz7w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by PH0PR03MB6447.namprd03.prod.outlook.com (2603:10b6:510:a8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 01:28:28 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 01:28:27 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+socfpga@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Tze Yee Ng <tze.yee.ng@altera.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v4] arm: dts: socfpga: Add Agilex5 MDK external GPIO expander
 support
Date: Wed, 28 Oct 2026 09:28:16 +0800
Message-ID: <20261028012816.32184-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:a03:254::8) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|PH0PR03MB6447:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f886485-de99-457b-f166-08df3492c42d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|261026140227099003|10067099003|261009223027099003|11063799006|56012099006|261009220027099003|261022105027099003|261021121427099003|261022113327099003|261009221727099003|261021123027099003|261022075727099003|261009223327099003|261009221227099003|55112099003|261026121527099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info: IiCEOQL5diMm8OEBBiuz27uYWxy0WtaNPk6FLFMlbnQUJd8oO3ZXCGpl1yqgfjFDmPs4AnmE9fBNFE+nwvKmayiTrg+vBPPK1t5ZHgniK+R7f3HHItHsgettOGbp4q0piz2LfKojLFZ6TbMpwy16SF4+ob5UR2Ea+Pdq+xYBxsGOsBImj6Bn61ngbKetKtE90b5Wt9GhbssRncGVZl7L6dJyB7EXJMXPQAkjxgflTEv25j5EychN1MQpA5J9Uc+jnuzNW7yURY/qTTElu2zYx7LpmnCDKPPP3ZtTidR0F+5IICfqvr+/ftXHdiUBJA/PTkWlYMUfHZv/6oRp0LpIB7nr4TmePn6Y3a+j86nmUpSreSqQYNrb2aPeyLcUycRPTwmS97Ja3rVWMBwF1xESM1V+hHOYe6veHMTQGcQQxBlZk2ut0I8vJUfoePLjyxwZdksZH3ByINq7zFJs35726h3GBZ+B2cyCCdW6zGR4T2F57ZdZQORyqio8s3IRTPh3Wd50wgho3zM5NZgthiEOU/scXos4Utt5Z6VHjJ9ZGw6hqrGcBfEFcGNMDBATTMmAYyAtukNYiRVfWn49DKGYStIRF2k3zvo6r1Kis/CaMtE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261026140227099003)(10067099003)(261009223027099003)(11063799006)(56012099006)(261009220027099003)(261022105027099003)(261021121427099003)(261022113327099003)(261009221727099003)(261021123027099003)(261022075727099003)(261009223327099003)(261009221227099003)(55112099003)(261026121527099003)(18002099003)(6133799003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f7bocwbkIoVUDr3sf/MhDEMT6ehSEvc4GlF7UfBMkGpLg8UrOk+tN/Xn4gK9?=
 =?us-ascii?Q?aZfXK6t22ue4B3Eip+N1Nzxagz3dyNPLU1ZicqthN9Q64v3gwnCahUuBSVz+?=
 =?us-ascii?Q?58FyAF6AFfL7Wkx0M0Lp3XJzF4iTWBOljMxz/w1GMHjAIuYcb9IFs8cDXbYQ?=
 =?us-ascii?Q?JQ235Ea9cRVfn+aveoWXmNIz0YaucgNirGr/PD9XdmiKhS4Dr+R9J6SR/GBq?=
 =?us-ascii?Q?4YfOOJ5o+OURNOU7+R0FzpWWZrttV3i/fQOwADGeGbLcwtdu5kfdQ73vrT2M?=
 =?us-ascii?Q?vUTEe9YfyW0yfvent7apsNH404NdlvE9rsMojBA7Xud7YB98s1ey15Gaviow?=
 =?us-ascii?Q?yqQpfEgwkhfYjieh61pl2g8cDKZ2XfS9RjK3hzpE+lgDs++e6cXP4gX17jDu?=
 =?us-ascii?Q?cfQ+D2ZlRpJK4fq/8b/3yFt3//IUSplO6Cp5QcTWs0ay1WjiV1Bm+BfVtfGc?=
 =?us-ascii?Q?SC5ATYwKEv2pdySkyE4NB74MpW9EerNGY1QFSE1T30jjHwcp+40KOdPvjm8C?=
 =?us-ascii?Q?GRD7iACD6xGYNw8zDUkQRVuXOf/5KS1SfFYE3OvdQEloWfWuBAm0G6wWdKa5?=
 =?us-ascii?Q?s3um5zXCBZfDIju5vJsjwUDDoti2uVGdf4DlSwmpmSvDlOf8ekWhTJMHptXO?=
 =?us-ascii?Q?w2aV8l4EFCjofPKvrUoEmqV4v5e5fJYzOSPjq7n9XAyKI5AIVkXCLlEwo5MX?=
 =?us-ascii?Q?K4ZEJhr+yihxyZalb2LP+s32eh8BULU+pAcIDKuHhIB8uGT1stGJZgt5Lg/9?=
 =?us-ascii?Q?ojv6xz5B5HMEcB1Kr2cu2zrqY3/kOyFTP33r3LgUh+F465TFEUA3NE6W1rRh?=
 =?us-ascii?Q?2ai6CJ6I32MvNXCItkDiRyBFhmI2G47S/8PS5A0SJeBLGNa6wod1LWRINwpl?=
 =?us-ascii?Q?aOYt72qh25JZSezGN8JASWJ/K4rSsegKihGBiT3twNNmMbPbcjqcWyJWNhG2?=
 =?us-ascii?Q?EqaK8jQXegZrWXWapfWqEZkSJSDyj0mI49q0sgUo4AvIt//IATDCzKwVFnob?=
 =?us-ascii?Q?tMDgoflzs2ORB8rSXPLIAO8Z1VXXlb7SOdPZiHW3+fnMsBaa0twaPDkR+kGf?=
 =?us-ascii?Q?qvp5r+O8DePThKaf5SlzEZDCDbVD5iJZ35pHK4ZLOd69mpop51y4h7XxSGbZ?=
 =?us-ascii?Q?qvYad/zE4asInRFzFJn0SNb0CJ36Fym3s3fQWJ9IPfxbNMkd+Jm1mdd3XLC9?=
 =?us-ascii?Q?JO75g8hRwx3+kRUpaNcIez6D9iyG715dIPbtMeQDUs0WFGJs9vWMj3fxs3yj?=
 =?us-ascii?Q?fYQttgogUgL/squvOUG0D/Yeuan7DvdU9PPyRdzVxkxgV+MUQxUYAxSrUqKA?=
 =?us-ascii?Q?1Pk/ZdUqef4lus/jBlohMG26NEwhbl6AOWGnqRy0rH2FnFlwlTmd+NKJ5V3N?=
 =?us-ascii?Q?Y+GVm9obOYyzgQ0HlD74hJ15WYFybj7YtOiRXo6o5FD3cfXpfEMckckBuUgA?=
 =?us-ascii?Q?jZhjqwx6GVovGBYRBbvrSLRV8aQmPO5AfNpjPKZ32obHuqovJPrP7z/LW+01?=
 =?us-ascii?Q?4KxMNP/IZqeJlOw0i3S5fKtwKpz5yoxNfMay5IW4JeKx6nz1d+14Mi2bir8o?=
 =?us-ascii?Q?ohI1Q7GaL3xrObwHi7Rtc93/Ea1mhFhvkghtIPtr9XfzbDZ9tOqfLbWP8wkf?=
 =?us-ascii?Q?t1Z8G8z3kqqalrJ3gUMW653gwZJ1xKDIg/fXKCb19+yHnDL+l3Zg3sFGEbsy?=
 =?us-ascii?Q?9x/b6x7MfcIiE712i1K+L9NbP5fqB6fMC23jnZ/grUBLpwwumAXwsFWnCTUZ?=
 =?us-ascii?Q?sLsSzcGtip/inL2xqWVFHGJ+A95qU1s=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f886485-de99-457b-f166-08df3492c42d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 01:28:27.5507 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: czDFs74SO+EjN7dkxhc4bJhffMU0QustKE3jKR2iwuAHQx27Eojujl+UyCNKGaPcHX9VMEfa69aDW2khLr8/v/EaT4wQsCe0yFpo41d+kvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6447
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_FAIL,
	SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Unlike the Premium DevKit (onboard GPIO), the Modular DevKit steers
SD I/O voltage via an external PCA9535 GPIO expander on I2C (address
0x27, pin 1) for the level-shifter control path.

Enable SPL and U-Boot I2C DW plus PCA953X so the expander is available
early.

Co-developed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Co-developed-by: Tze Yee Ng <tze.yee.ng@altera.com>
Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

---
Changes in v2:
- Removed binman node setting to delete kernel subnode in
  arch/arm/dts/socfpga_agilex5_socdk_modular-u-boot.dtsi as this will be
  done in common SoC64 dtsi in series 503845
- Commit message clean up
- Add socfpga_agilex5_socdk_modular.dtb in arch/arm/dts/Makefile for
  arch-wide make dtb compilation
- Update copyright year to 2026

Changes in v3:
- Set model string for Agilex5 Modular DevKit
- Advertise SD UHS-I SDR50 and SDR104 modes
- Add sdhci-caps-mask to clear mismatched SDHCI capability bits

Changes in v4:
- Respin subject to match series title style
- Rewrite commit message to lead with hardware delta; drop file inventory
- Add Co-developed-by before each co-author Signed-off-by
- Drop CONFIG_SPL_DM_REGULATOR_GPIO and CONFIG_DM_REGULATOR_GPIO from
  socfpga_agilex5_modular_defconfig
---
 arch/arm/dts/Makefile                         |   1 +
 .../socfpga_agilex5_socdk_modular-u-boot.dtsi | 151 ++++++++++++++++++
 .../arm/dts/socfpga_agilex5_socdk_modular.dts |  82 ++++++++++
 configs/socfpga_agilex5_modular_defconfig     |   7 +
 4 files changed, 241 insertions(+)
 create mode 100644 arch/arm/dts/socfpga_agilex5_socdk_modular-u-boot.dtsi
 create mode 100644 arch/arm/dts/socfpga_agilex5_socdk_modular.dts
 create mode 100644 configs/socfpga_agilex5_modular_defconfig

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 099e3f082b6..e5360b23870 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -418,6 +418,7 @@ dtb-$(CONFIG_TARGET_THUNDERX_88XX) += thunderx-88xx.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) +=				\
 	socfpga_agilex5_socdk.dtb			\
 	socfpga_agilex5_socdk_emmc.dtb		\
+	socfpga_agilex5_socdk_modular.dtb		\
 	socfpga_arria5_secu1.dtb			\
 	socfpga_arria5_socdk.dtb			\
 	socfpga_arria10_chameleonv3_270_2.dtb		\
diff --git a/arch/arm/dts/socfpga_agilex5_socdk_modular-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5_socdk_modular-u-boot.dtsi
new file mode 100644
index 00000000000..5818c5ac597
--- /dev/null
+++ b/arch/arm/dts/socfpga_agilex5_socdk_modular-u-boot.dtsi
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * U-Boot additions for Agilex5 SoCDK Modular
+ *
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
+ */
+
+#include "socfpga_agilex5-u-boot.dtsi"
+
+/{
+	aliases {
+		spi0 = &qspi;
+		freeze_br0 = &freeze_controller;
+	};
+
+	soc {
+		freeze_controller: freeze_controller@0x20000450 {
+			compatible = "altr,freeze-bridge-controller";
+			reg = <0x20000450 0x00000010>;
+			status = "disabled";
+		};
+	};
+
+	/*
+	 * Both Memory base address and size default info is retrieved from HW setting.
+	 * Reconfiguration / Overwrite these info can be done with examples below.
+	 *
+	 * When LPDDR ECC is enabled, the last 1/8 of the memory region must
+	 * be reserved for the Inline ECC buffer.
+	 *
+	 * Example for memory size with 2GB:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>;
+	 * };
+	 *
+	 * Example for memory size with 8GB:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
+	 *	      <0x8 0x80000000 0x1 0x80000000>;
+	 * };
+	 *
+	 * Example for memory size with 32GB:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
+	 *	      <0x8 0x80000000 0x7 0x80000000>;
+	 * };
+	 *
+	 * Example for memory size with 512GB:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
+	 *	      <0x8 0x80000000 0x7 0x80000000>,
+	 *	      <0x88 0x00000000 0x78 0x00000000>;
+	 * };
+	 *
+	 * Example for memory size with 2GB with LPDDR Inline ECC ON:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x70000000>;
+	 * };
+	 *
+	 * Example for memory size with 8GB with LPDDR Inline ECC ON:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
+	 *	      <0x8 0x80000000 0x1 0x40000000>;
+	 * };
+	 */
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+		u-boot,spl-boot-order = &mmc,&flash0,"/memory";
+	};
+};
+
+&flash0 {
+	compatible = "jedec,spi-nor";
+	spi-tx-bus-width = <4>;
+	spi-rx-bus-width = <4>;
+	bootph-all;
+	/delete-property/ cdns,read-delay;
+};
+
+&flash1 {
+	bootph-all;
+};
+
+&i3c0 {
+	status = "disabled";
+};
+
+&i3c1 {
+	status = "disabled";
+};
+
+&qspi {
+	status = "okay";
+};
+
+&nand {
+	status = "disabled";
+};
+
+&timer0 {
+	bootph-all;
+};
+
+&timer1 {
+	bootph-all;
+};
+
+&timer2 {
+	bootph-all;
+};
+
+&timer3 {
+	bootph-all;
+};
+
+&gmac0 {
+	status = "okay";
+	/* PHY delays is configured via skew properties */
+	phy-mode = "rgmii";
+	phy-handle = <&emac0_phy0>;
+
+	max-frame-size = <9000>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwxgmac-mdio";
+		emac0_phy0: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
+};
+
+&gmac2 {
+	status = "okay";
+	/* PHY delays is configured via skew properties */
+	phy-mode = "rgmii";
+	phy-handle = <&emac2_phy0>;
+
+	max-frame-size = <9000>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwxgmac-mdio";
+		emac2_phy0: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
+};
diff --git a/arch/arm/dts/socfpga_agilex5_socdk_modular.dts b/arch/arm/dts/socfpga_agilex5_socdk_modular.dts
new file mode 100644
index 00000000000..51d3a0b76f6
--- /dev/null
+++ b/arch/arm/dts/socfpga_agilex5_socdk_modular.dts
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier:     GPL-2.0
+/*
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
+ */
+
+#include "socfpga_agilex5_socdk.dts"
+
+/ {
+	model = "SoCFPGA Agilex5 Modular DevKit";
+};
+
+&i2c3 {
+	bootph-all;
+	status = "okay";
+
+	expander1: gpio@27 {
+		compatible = "nxp,pca9535";
+		reg = <0x27>;			/* SoM expander address */
+		gpio-controller;
+		#gpio-cells = <2>;
+		bootph-all;
+	};
+};
+
+&sd_emmc_power {
+	bootph-all;
+};
+
+&sd_io_1v8_reg {
+	gpios = <&expander1 1 GPIO_ACTIVE_HIGH>;
+	bootph-all;
+};
+
+&mmc {
+	status = "okay";
+
+	no-mmc;
+	disable-wp;
+	cap-sd-highspeed;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	vmmc-supply = <&sd_emmc_power>;
+	vqmmc-supply = <&sd_io_1v8_reg>;
+	max-frequency = <200000000>;
+	sdhci-caps = <0x00000000 0x0000c800>;
+	sdhci-caps-mask = <0x00002000 0x0000ff00>;
+
+	/* SD card default speed (DS) and UHS-I SDR12 mode timing configuration */
+	cdns,phy-dqs-timing-delay-sd-ds = <0x00780000>;
+	cdns,phy-gate-lpbk-ctrl-delay-sd-ds = <0x81a40040>;
+	cdns,phy-dll-slave-ctrl-sd-ds = <0x00a000fe>;
+	cdns,phy-dq-timing-delay-sd-ds = <0x28000001>;
+
+	/* SD card high speed and UHS-I SDR25 mode timing configuration */
+	cdns,phy-dqs-timing-delay-sd-hs = <0x780001>;
+	cdns,phy-gate-lpbk-ctrl-delay-sd-hs = <0x81a40040>;
+	cdns,phy-dq-timing-delay-sd-hs = <0x10000001>;
+	cdns,ctrl-hrs16-slave-ctrl-sd-hs = <0x101>;
+	cdns,ctrl-hrs07-timing-delay-sd-hs = <0xA0001>;
+
+	/* SD card UHS-I SDR50 mode timing configuration */
+	cdns,phy-dqs-timing-delay-emmc-sdr = <0x780004>;
+	cdns,phy-gate-lpbk-ctrl-delay-emmc-sdr = <0x80a40040>;
+	cdns,phy-dll-slave-ctrl-emmc-sdr = <0x4000004>;
+	cdns,phy-dq-timing-delay-emmc-sdr = <0x38000001>;
+	cdns,ctrl-hrs09-timing-delay-emmc-sdr = <0xf1c1800c>;
+	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-sdr = <0x20000>;
+	cdns,ctrl-hrs16-slave-ctrl-emmc-sdr = <0x101>;
+	cdns,ctrl-hrs07-timing-delay-emmc-sdr = <0x90005>;
+
+	/* SD card UHS-I SDR104 mode timing configuration */
+	cdns,phy-dq-timing-delay-emmc-hs200 = <0x11000001>;
+	cdns,phy-dqs-timing-delay-emmc-hs200 = <0x780004>;
+	cdns,phy-dll-slave-ctrl-emmc-hs200 = <0x4d4d00>;
+	cdns,phy-gate-lpbk-ctrl-delay-emmc-hs200 = <0x81a40040>;
+	cdns,ctrl-hrs09-timing-delay-emmc-hs200 = <0xf1c18000>;
+	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-hs200 = <0x90000>;
+	cdns,ctrl-hrs16-slave-ctrl-emmc-hs200 = <0x101>;
+	cdns,ctrl-hrs07-timing-delay-emmc-hs200 = <0xa0001>;
+
+	bootph-all;
+};
diff --git a/configs/socfpga_agilex5_modular_defconfig b/configs/socfpga_agilex5_modular_defconfig
new file mode 100644
index 00000000000..38690a7864e
--- /dev/null
+++ b/configs/socfpga_agilex5_modular_defconfig
@@ -0,0 +1,7 @@
+#include <configs/socfpga_agilex5_defconfig>
+
+CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex5_socdk_modular"
+CONFIG_SPL_SYS_I2C_DW=y
+CONFIG_SPL_I2C=y
+CONFIG_SPL_DM_PCA953X=y
+CONFIG_DM_PCA953X=y
-- 
2.43.7

