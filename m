Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9432C606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 21:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OB4PU7TO;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=aEFQxuwp
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 58E8560639;
	Sat, 31 Oct 2026 21:55:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bX2o1ayVT7ZO; Sat, 31 Oct 2026 21:55:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4753A60612
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793483711;
	b=nj84NkVBnjOUgUB3bLAgK1krxHmFCCBvajo4bHgjt9DeAJCH0jfNsz+5jbp+rCru6Wx8
	 hkc+qj4ttVBFEEeWlq9osNf1HAOkpMtWzwVRPVQsPPERrdVx16lwSV6UP/oZ9QLAezgYN
	 xpkrnOlWeHV2fMuPJsNoFUY23Ei3umPbWmuI33/1IsdyfpnIkKE/60a4n9lQr7UxpY/H/
	 HHmCG7rPWZMrBSgrlq+llyB62Strlp2qgTJLh1yHyTem5/dysoxPNCeJpkoln4Sy+xbqW
	 G8gYyPWIm2fkaF7OY79bdpWux2idLxCMGfy4eePN7KK0Fgr7o0qvQXqGJ5h6BDbvz0Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793483711;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=T4jQuMlnEhjIU6eWrHTSyCKZjurd1J5svO2A9+anMfg=;
	b=iCGhiEgIHgzTiAkeT8sOu9UuvMQPczYKhUJWMskIkk1HDakdj2KTOkrwM0ILVTLLCMWm
	 qZ5lN5GD/G1F4wrPiPehYUmHhWqM7pnTvJ6IIMGplAHkImChsrNB0tbesOJMZQDJN1FYC
	 eadnfHQ+i09KwImi8j3d7khTdfcPetxFfW2XL2qoeO1IC3nVH5736sST1x7so4BCO9L98
	 u2VPcXG3Leqk0EekxlnhSUtSGXtDQNw/b7eW79qRnkBPbuQ5o1uDgLA4SonctS5IEPDjs
	 1C2ngps7ulbIepoIabg/lyz03cCN/bNNJMD0aISDgaMoN46GoYmQOhxqPcY6s5R8kxg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793483711;
	bh=T4jQuMlnEhjIU6eWrHTSyCKZjurd1J5svO2A9+anMfg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OB4PU7TOnAsGTbzFkOSVbukR2mqO3T47UlkJgyKKOwrUI5FCnHAKyKi2QNr5h2u5g
	 MDACvabBKMgUkzXQxHJs26ES2QiAvjx49747CRofig5MezsCFfOQZBjAXAhJO8w/o8
	 SauqzVj5I0X8z+mf1+KegYHGeqDgNtQARxTgN70YbzfTchRlB2EfMdO3wLhdOtGVGE
	 Q4BfLehBaMQ9lye9Y5fL89s4FQGOad5YEuvse7WuvsvmXc/00Dcwzq+R20iiyj6H+9
	 VdcVbOh3O39cdDdotVq9a5G+CblD9y4SjL0e0Wef/+3yumZDvyucuQ/9zF9BIbuM5v
	 VijX8E/4kXxvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4753A60612;
	Sat, 31 Oct 2026 21:55:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A90D4E0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 21:55:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 703F94059C
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 21:55:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j8X-Hz6_O-Hy for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 21:55:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 62A904067C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c101::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793483707;
 b=iTn1XidJewdCYd7HOYfLcVZ3YYxSSqk5LF50WzXoVpCPSx4T5SWwiA0lgAid0vEU4yrY
 doWQyPI12mqel0YRfEFDrxx4QASWToB5c2tpVWewhPmBr0P61XirRyHpJyVOJd3e+V5RU
 piScGK2/wbbkuvM6xwBKahvnudHTMSCp2J/iO0JNvGdXcM/6B4xeNPbv7zVLpBdbBSniK
 8ltvLWciICu68mvDvI5rmaQuVo+wSX2NwV8TV2iUR0H1GDGGLfHXMHWKm0AzU+ECPszLF
 OLbepwdrJon88bNSrsmZyC53oli+sB4qcgbdoVa1D7NCRijOCITQC2VmSyT45Jsxe4Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793483707;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:Content-Transfer-Encoding:Content-Type:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=T4jQuMlnEhjIU6eWrHTSyCKZjurd1J5svO2A9+anMfg=;
 b=DQ0w/hic8bE2FMR18ACZ6ZvXgeeYinAwqO5GaRU1DBbdQT/bP89AVvaDu5oVADjd3qD0
 +1OpPwuzH9KLeg38XPBulTktRFc3RCd0r5dY3dIqrUtavsH+6fhSGZHT091TOHrVo+szN
 Fd5g1BYds+l2xEl+oRAYRE1+EsjzBv6Bzk+/vtkOjK3wN97b+mvjxPZvIJwC9HOm2u+/s
 r/NMASlwmF3b44cFqi1jb4MzKqHmuSiBcPXGrLTeA6EEPB4m70eBVfMKW33GXAxRRDYhp
 gYkdy56c2IW4Zcfb1Owf4VkQXh7q4ZaLuh21BIcLqQFBbUKaRISsO93TPLwrWFxX8+g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=aEFQxuwp; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c101::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c101::7;
 helo=bl0pr03cu003.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=aEFQxuwp
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 62A904067C
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 21:55:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U9ctrObOlY1AChOXanUfWm1Hkd9ZiCWhvbB2QwNGh6Uw7gUIy2Xci6QHhOzLRTUUnvhXGYaiAKjys4oMgJ2JMfnASxLarr1FmtFK7V+DGs2t5wV6sgHBBkG7j4Xo9TixHmZZPKMHLje0qwnfyOrvFAtCAX62z59YabWqp870YeIhkkN0WBrpxbtBRr/5p5loBG1a6L/LSiKb6Nus0TP3Sxo+lG+SyfJAWg5o3O/KdwadovjZB2R354tA7+tEcUgqJquNw3fOc1RrVA2a9sLNp9Soux7+POk0iPT/zQzX7g3TYa5gGKPDf4G2KOY+QPetMXYe8E7YczqePHrD8n/gjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4jQuMlnEhjIU6eWrHTSyCKZjurd1J5svO2A9+anMfg=;
 b=x8HhBHi2WTxWvUuc+8qQPkRLPD1yXFAKy+sT0kTEppSJ3TBI/SgfmRr9YV2ofLq9FDL8oD6cpJxmqK7+5ZwvTsRHYRosqlniCWdSlMBEgdSG0X4FHNni3YO9PDcWJsgMSpysvwbiKk5J9wqI6tO5+g03sQ+OLpLldol/XWhJNkNTZvmqgBmyZFsj2eGc4KHkAOTUGqnVXmbzZZmtrtcKzBAC7Vis6KdkTt1Z8Hgges4IjDRKd2Om8p26e0UNiJsoXMbJ0ImCM92/DGuIUtwzBvdGgYaG+gpwaUu8W7ITdveBh3QlYBIY/zS4N8t/Kv37VVVchT0nzBMsaIix0fF2Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4jQuMlnEhjIU6eWrHTSyCKZjurd1J5svO2A9+anMfg=;
 b=aEFQxuwpmTRSxm08RX260vy/BcOpmXfLlv9N3fwTtJ84UovsrYM5/MaViFoezOIkNQgP4xRifydB/PrRYIcgHGHKnobfQJRji/jqFQdrFp4nHkpZyTk6yJeVsMXBmU83dv5OkGZYl5i41kwnwr4mb/UPongCy2vgtlCrn+mw2bsRAOq0AiGNnfSR02X3spTQhCtljSpLC5UR0pFqqP7ZAQt1oZvNdXrDZfHC4LaNh3TyJWiXZZNloidaVncyvEy2DbH9J3ujoIySwgsy8VQPn7o5XcuyX1O5Dw80Pz75ciWxt7n2NQHj52vKE4jTeZcJwIVo+FZZoY5IBXXnZqBiuw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SA1PR03MB6481.namprd03.prod.outlook.com (2603:10b6:806:1c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.11; Sat, 31 Oct
 2026 21:55:00 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0569.010; Sat, 31 Oct 2026
 21:54:59 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Yixun Lan <dlan@kernel.org>, Tom Rini <trini@konsulko.com>,
 Eric Chung <eric.chung@riscstar.com>
Cc: u-boot@lists.u-boot-project.org, u-boot-spacemit@groups.io,
 Dave Klotz <DaveWK225@protonmail.com>,
 Zixian Zeng <sycamoremoon376@gmail.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Guodong Xu <guodong@riscstar.com>,
 Leo Liang <leo.liang@sifive.com>, Tim Ouyang <tim609@andestech.com>,
 Yao Zi <me@ziyao.cc>, Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Subject: [PATCH v3 0/4] mmc: k1: multi-block SD reads in SPL and a probe
 failure fix
Date: Sat, 31 Oct 2026 14:54:48 -0700
Message-Id: <20261031215452.16013-1-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0011.namprd07.prod.outlook.com
 (2603:10b6:a03:505::20) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SA1PR03MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: a758b2eb-7f19-43ef-b435-08df37999bb8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|366016|260925022911599003|260925021311599003|11063799006|56012099006|261009223027099003|261028144727099003|261026121527099003|261021121427099003|261021123027099003|261026140227099003|261022105027099003|10067099003|55112099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: iFh8qrTQV2Jaq+AVFfxsZubBmx+Qt5HRkCm4k/J3U9/XCeQWT0u7crR2uvzX9npN+6JNpzEesq3aknP34LpEwHK9MGwWO8nyp8iVoD5dORI+AaUAOVYKKsUHXLJV03KfgOdJY2RY+XQsCzdUcLS9LwV9FrL0fmGVeaVxyKvfcrO5N+WDAVspKYGU8zMHtc3shXjcW2Aqp3ZN+6FF8Ex41Ib6HBMq3MpxpHqu2bLVFuGxrPybX1e3QcSwSP7ESaKlWan6O5sui1S5xQjCn9G1wXlYaBIL+zrOa9tQE1YHeBdZAR7h011KgHQK7Lp3/HWpGN0laM35jIhqAjfeE/VLgQUu3Q5fxbQK+K9zgKuEVOFEZBZheqz6nUbkpakTEehlkAPxWqrIsK9G2GNZ2azW8vEmUSbeVh5SJhgPIK4ljAVNOadsUGT3qMYPrakdVenVnkZP2Dm6OlRxc/nwJ9dQ37rBGQMJuL8V8r4k/naB8hOHjUnb49p92r+PJby9IrWXPlcuSCknk/Aph9sZPxsOOWL/6JEIRQ3rZsgn+/wnsv89WZs5FJRpMM9q/YpA8caD4kOgI78vRbItXDYdfijI3WzVTlmpPDWcQUdjJWS/NWBsw4rbHkCzHekoI975pMNI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(260925022911599003)(260925021311599003)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261026121527099003)(261021121427099003)(261021123027099003)(261026140227099003)(261022105027099003)(10067099003)(55112099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VX2gfgVGaVlBn+uEGsmF1zu38vo89IJU5sCUotlAVzTUTwOdxsJBKFzEnNZ7?=
 =?us-ascii?Q?VQhU5W36CCPNKxVIhebBO7gEtQKgT7HBxniglengJ7aH4pkE793BIHnGVnNb?=
 =?us-ascii?Q?oAmmqnMqVVbPFP4lLrgFFLLjNPMF52EIwIPTBpxfQdC9jx1Tkqg77STmZYrv?=
 =?us-ascii?Q?iiq9Gzv330l3F4HPAG09yW51g9oQWsk01DGTHncihvyGA7296OTQ1VvLYnqp?=
 =?us-ascii?Q?/VENZjYooYlJkGNXr70GVg2kdccd6T3oiPX9RhoynaVbR7NhGFgcTZnunbB1?=
 =?us-ascii?Q?ZvDko1Ky21FmPeC8ezhH6/4dJjChtxeAOK9ucQOjmqeLVIkWG54PalEiCv/0?=
 =?us-ascii?Q?7MGOLy/xG6zzRCPdYd0ao9c4iy7Re6CluiHbPybESKQ8hurrMxhdUlemRqaQ?=
 =?us-ascii?Q?Sxvd+JnVEKN6lI5z6jG5u9M/6zI6SRTvr+7s/T1+AjMbHYfE3NKMw1VOVy9I?=
 =?us-ascii?Q?hFKqlxKNXyatiUv9HDApWEPLmHaPQnFCHiMa3yQOEuwcNZATrDPgdtqGf1Zm?=
 =?us-ascii?Q?ZAp5VT1N/kRwQ3GeX1Ch4/jyqmgpUXVQfQf/qQoI76mHZfbg+dP0KfYrQ4aS?=
 =?us-ascii?Q?5Rm046S2jluKoMSTUd9ghO57+AA4VGWtT+b2aA1wWLIlFWi0EVMTRF6GOqon?=
 =?us-ascii?Q?itMKoxn7d8NMpxTW0P2IaxAXLJt0McggzPg+kD5bm9wAmmX+V2N3wa5EgZfC?=
 =?us-ascii?Q?9w0nYixeiwWjQeD13KNCHbPfMCBvu3kmA1w5cIHSoqqN0W7tqcjMJ356xxrQ?=
 =?us-ascii?Q?3TF/9yqbQrypPt1qWavLwiISmn8Vju1wrQ+7aQ11oXIMP1vgjFd6TeB0bbP8?=
 =?us-ascii?Q?LU+MGIbn2GhDwdgbw+NH/4A053CcUD3RTyUzQXGCfHAjdLPKe5hiHvqA+ezO?=
 =?us-ascii?Q?/ETHXJqapUlPZyCpHyvuPdVIPL3m42OHkYxRsjhWv/xZTVpJI33Kh05LVoMj?=
 =?us-ascii?Q?gb3kscZHCLw6pGnolo8unCn+3LK79buP5BH/61jJQSi/TKf3OPs8cba8XIQW?=
 =?us-ascii?Q?5bcjPblyNjGdns1V1dX6CbNSZluF6qGcCJ+L+TXRcq5/uRyE/TjDMGGqVgn9?=
 =?us-ascii?Q?WqH7buTPu6WW0/S9g7pbO27CunXmv2OjRDJCvOZE4wUxzdEflRa/AYYNRVK5?=
 =?us-ascii?Q?whHQSAUIlT7NFh91YRPypbW47ZTQHwGdoqn0DMsrfiXfWHKBXjDwx6edeykN?=
 =?us-ascii?Q?qnGFGK7KSd7CEWwZPp1Xva0YOfrYPw+ViraRC7gObxJqtQBeVmQmHAHYbs+b?=
 =?us-ascii?Q?UxeM3kDAPuy4dfxlonyJrXMwBbiNyhUJQKwmPkB4stGyXLtZNs4hvsWc6vry?=
 =?us-ascii?Q?IL+24qtW01BZzNtAGrTLf594QrbfTqQHdzY5ja8aUCCiPuomFJ+oB8Jci07s?=
 =?us-ascii?Q?QZzwMXfGZfH1oEnrllyKSVuaoNQM+H+zFcMXu4y6OGgjxpFxKAsMfULVylD4?=
 =?us-ascii?Q?0WlkLodxykxbda+2eAHQJcQHXhpqZDt5hAhZL63qgYkG+XzgpobGTtAqXSer?=
 =?us-ascii?Q?6ypKRXCRG0ShY5axinCVHKqvmSXz847FMqje1ZVfDexZiiq/d0fF4w/KJBBS?=
 =?us-ascii?Q?mAeDliynXNvwI3qf/mRCFaJCm7+HkABsbCQOH8svuiE3OkJUEzlD/aw8Nmpd?=
 =?us-ascii?Q?i94/pKXZxVjY3qY92Zfr53veViVdSvNfnWoTS6gq6lnS4dL2BCqKw8yoUStr?=
 =?us-ascii?Q?yytrXfoPL3dCLRi3Ab9VikgFbo9mttLfg25uB4ohb6IrlxWJLXtzw3RlCc9s?=
 =?us-ascii?Q?ZnHImVQDxwbX/FRkjal4bIHwPjUuNr4=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a758b2eb-7f19-43ef-b435-08df37999bb8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 21:54:59.6288 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: poP1SAIDnBoITuHLSM1LVgzr+J3CVOMbBD3VyzIAsSPsQ3zagHcN1m2Xg1aD3v0zLlDD8jXpVTLpCndU0i0h/bxTRkr1Ixo0Zmxg8fIv2U8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6481
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I am taking this series over from Dave (thanks, Dave).

Testing v2 2/3 on a Banana Pi BPI-F3 and a Milk-V Jupiter showed that
multi-block SD reads in the SPL fail because the SD I/O rail (PMIC
aldo1) is at 1.8 V: set_vdd_mmc() sets it, and without
SPL_MMC_IO_VOLTAGE the MMC core never sets it back to 3.3 V. Patch 1
lets the MMC core set the rail, patch 2 drops set_vdd_mmc(), patch 3
is Dave's multi-block change, and patch 4 is Dave's probe error path
fix, narrowed to the resets because, as Yixun pointed out, the clocks
are reference counted.

Not in this version:
- v2 1/3 (missing max-frequency). As Yixun suggested, the io clock
  should be set up with assigned-clock-parents/rates in the DT, which
  also works for Linux; that will follow separately. Hung-Chun has
  withdrawn his matching RFC.
- SPL_PINCTRL. On its own it links no K1 pinctrl driver into the SPL
  (there is no SPL Kconfig symbol for it yet), so it would not program
  any pads. It will follow separately once it has been tested on
  hardware.

Testing: I do not have a K1 board, so v3 itself is build-tested only.
The changes were tested piecewise in the v2 thread, and in each case
multi-block SD reads in the SPL worked: Zixian enabled
SPL_MMC_IO_VOLTAGE on a BPI-F3, Yixun dropped set_vdd_mmc() alone on
a BPI-F3, and Hung-Chun set aldo1 to 3.3 V on a Jupiter. Zixian,
Yixun, Hung-Chun: a Tested-by on v3 would be much appreciated.

Thanks also to Anand for testing v2.

v2: https://lore.kernel.org/u-boot/20261005T135220-0400.mmc-v2-0001.DaveWK225@protonmail.com/

Changes in v3:
- New: configs: k1: enable SPL_MMC_IO_VOLTAGE
- New: spacemit: k1: do not force the SD I/O rail to 1.8 V in SPL
- v2 2/3 -> 3/4: commit message explains the BPI-F3 and Jupiter
  failures; code unchanged
- v2 3/3 -> 4/4: keep clk_release_bulk(), only drop
  reset_release_bulk()
- Drop v2 1/3

Dave Klotz (2):
  mmc: k1: let the SPL read SD cards more than one block at a time
  mmc: k1: do not assert the shared AXI reset on probe failure

Tanmay Kathpalia (2):
  configs: k1: enable SPL_MMC_IO_VOLTAGE
  spacemit: k1: do not force the SD I/O rail to 1.8 V in SPL

 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi | 10 ++++----
 arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  |  2 +-
 board/spacemit/k1/spl.c                   | 21 -----------------
 configs/spacemit_k1_defconfig             |  1 +
 doc/board/spacemit/k1-spl.rst             |  1 -
 drivers/mmc/spacemit_sdhci.c              | 28 ++++++++---------------
 6 files changed, 17 insertions(+), 46 deletions(-)

-- 
2.43.7

