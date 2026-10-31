Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA81B606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 21:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=C/aW5n/L;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=dxWg7nTK
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C03ED4067C;
	Sat, 31 Oct 2026 21:55:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wW74NHGiIXhZ; Sat, 31 Oct 2026 21:55:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EAE54406A2
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793483717;
	b=R7bRKQ+07Wu/hp4Uo7eFB7d16EqFY/+BOMaICvsmYH3DTY1ggxLytCl4pNfYVKdq5jvw
	 qZHvWSq0qOeEC/EvRxab0uRF9dyNFhhUAWrMQX8Y9WeRzi3f7vKmWUJZWS+2p+AEcas2N
	 1M4pOhxRa3BSq4dRBZhAmpiGXSpNRh33NTA8qNfbx7WDjXi8h7mciQfKyw7s5TVaSEV8K
	 0wtcGnigZbZy75fEwKsd7JDAeIBia1KBSVA3t/iz7bfR2Z4C2WnguALbRoUjb4MEYmzQ/
	 0cZE5MB77UqjUnZLqa/QIQ/+NZ6p3WmPjFbZSD7xqyQzsoVFD4NWJis+I26aSSxSppA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793483717;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EEz8GlX+9Fx7rrOOWBaK1KC1NisTFSnzk6zIHF085Ac=;
	b=cOQzTdCfKxU+XK/CT1BtPhA/0mxgTqgyqwYCkQcuH4e2JiazOxCSfPnvvaLo5Qu4yejG
	 HpkBnafzRmXuvWHR6TDgsJ79dLoSzl5YHIJdFToE3Rvg2USrQQjBdioysFRLJj3VuzUIG
	 Y+c1+88lpxUHhuWHsUzdHeMhh6mYVltKQu9SQtX07IVZRiiTDhZXfdvYC9viWh7OmxdR6
	 I/FnKAyr3Yzx+lkTV5em2IAteEA8c58szZYxHAvoT3tWdU2FSb+h6mbEDTufQaqHzvPcH
	 fMix4RzgaJ9+euagnoVCvMoImAj1QRMI3HtiLgDi3FCKS1OOVXN1FSa4StbcEKMoR8w==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=dxWg7nTK;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793483717;
	bh=EEz8GlX+9Fx7rrOOWBaK1KC1NisTFSnzk6zIHF085Ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C/aW5n/LALTdl+g/GQn9oVM0Q4qVsYMHi7nUUNdn6OMBcSeSOsQ2fIbWUtywDBvuz
	 Ebq5sjL0PWDbk0Jfr2d61W7+IiW3xKtOwcsedISsRFoI1Hxt3FXSZjBB3dDSQ7pnGX
	 EmvFD33T5J4em3Sumjs9Ns7mWgm+OAHvGDtXiSb89kTeFkHMSdELDf4pXQPDoPiHvS
	 LUnnam1YgALrvzishc18HIg3rWkz1PM/pMq/uZByM8OM4j2jfvte3DMqb4GBjCGNgR
	 xw/Ok1O68Muokbu1m4//RfCdjmZStYkdpqa19hn6HrqqQ+kLTSzEtswIVp2DweXhTY
	 DNM4Cw7KWSh8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EAE54406A2;
	Sat, 31 Oct 2026 21:55:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E3466380
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 21:55:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D523040640
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 21:55:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t0aa2x2Ju0or for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 21:55:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E77E44055F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c101::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793483708;
 b=s04ZN6vVjwobzKkYPp72900p/ZyRNrK9ZokitFRZQU0jK90RjjDESYeJMLSnRv0gOdDn
 XWPQXqIfn8zUVsgbpX9nAnpAw2VRNTkuoiq3z89yYNlSYljr9uhPWDRU4JDnEgL84MwoG
 NR9Za1Zxihfj4U5xnRuLjWboTtnt/WBfEwzMWT/blLJ9VdOwHV6P1cdCEKqhatNdOcZaL
 rdvU3h55gjekzRPBzWcVoryQEUOAOFA+45JDAHXnSuhiHdaJWrOiAG0YE1hSmqLXMEVA6
 pVPpdchAJqkmFi0FX4gGwBpfqQZGm685/WN/q1liISrshMBtPL79CZZ2FTT8pyQXziA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793483708;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:
 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=EEz8GlX+9Fx7rrOOWBaK1KC1NisTFSnzk6zIHF085Ac=;
 b=gJTEoMee/SuD0iotw32h6Mgwx7uJ4HFJqHqRymsL2VBUK5vdcWyQLqSei4EIgHxgX2y8
 cqQD9yRRSiIra2LqxGc0zgDeJc5QHcGE87Q6BSD6bFeWaan2AWUD6GF06REgNQ9+J1Eco
 z0hV06H4d7y+JEKpyDPRo/t9I8RT9/rPvalOl5W/0J7MUXPTN0CLmmMTqAAWoYabKogLR
 bAliNRi32JhBJZwjYIyI5znOT102j0QzQSoAVdhGfO6OPQke2v9WyiVg5dYvgF/HwX4eG
 vqpW6VoakzVaPSQ5SrVG6m+aFCIFih7/Pnlyb8L6MNLOcYEXOXOwWATanjFdvMALECA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=dxWg7nTK; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c101::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c101::7;
 helo=bl0pr03cu003.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=dxWg7nTK
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E77E44055F
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 21:55:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h69vDyCw8MBbXwAd1VpTfVURdlsPz8+FyqPLSf/j1JSwJ+5zd1h76hD4FtUeEjVnQAxdY4kaQCQrz6IbqPw3PVgps+jTrDCK0gJmuCF/lPsrcXsEE38e8PFGdIo8OFjYKaIf+Fg8sqBs8gwgkd3Z9amdOWNCO5wWqCDHlEAkOPQ//4Kub2oQ68JT5okfkyksEiXo4t180BQBiChZlAOzFC5/2VVDuUAiKyOmGW8Wi4Cghj0HtWHLI6LI8ArevZKG9S9sKibAebktXfYLJ2p3n1fG1pGATVn/x/RvAIhmAG9Dg8b8mYgJtkcg2x2FHtVDgu7jsiZH7TjXMs2FZAch0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEz8GlX+9Fx7rrOOWBaK1KC1NisTFSnzk6zIHF085Ac=;
 b=hNKDi0FFroHhfP7U/5Ww92EbP1l7mkWUtPJysNsoFtuGyCAbFgQa3j3fknAcQT5kJICmY8ji00njTc4LMQf2mgpOq2NEeXD6RrzSNG1/FgXe4p8DguOPNZdpDVcJ76WbSh16mY4n63X75uuL7RX20En7ckPRMoRT7FlPc8AAFJ9PJGNCR+d/ujrWMsQp6FV0Lxu6acnVGa1g4usPQWcZmwweynO0rRhRvl3Jqsz83V+9tflB/dop/jwJrJvKV1MsGlulbOfVDcWVGofv+MuaWQofjQGvahOuZoTCabaxXvWoq16KPDxoz4dumchnaX+g+oth8nky1RHOEyfXV3LQPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEz8GlX+9Fx7rrOOWBaK1KC1NisTFSnzk6zIHF085Ac=;
 b=dxWg7nTKwDqFxb78+r/3eLRDEXJB+CNauraMzsy05KTuu94w9TBQmwnO8PwsaXPpLIxUJ3lwCoBTqHISWotxLTv0ZZCTMtlubUFHtwharC0XdSSO17nkSpQ1vqI7e1UVyMMOFhHaXJtKKtizrAebYaMn7ONWQuoP6Mv6PFdXxVMPzugtJZ6jFokn/6IgkQBp8PENSff/F41ixxSz7YtlZB6A0mBRnNHEkn/ppNEwDz56WET9XsvBJXNAkxIapnTtk9p4Sh8P5NZq81Q6A8pGRwsgkgNS9zBsQ6GH74E0TmI4BwCzDvhoWTPcl6ceJa16tI7oAg4Yxac7rJ/5VIH8fg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SA1PR03MB6481.namprd03.prod.outlook.com (2603:10b6:806:1c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.11; Sat, 31 Oct
 2026 21:55:02 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0569.010; Sat, 31 Oct 2026
 21:55:02 +0000
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
Subject: [PATCH v3 2/4] spacemit: k1: do not force the SD I/O rail to 1.8 V in
 SPL
Date: Sat, 31 Oct 2026 14:54:50 -0700
Message-Id: <20261031215452.16013-3-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20261031215452.16013-1-tanmay.kathpalia@altera.com>
References: <20261031215452.16013-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0011.namprd07.prod.outlook.com
 (2603:10b6:a03:505::20) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SA1PR03MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dbd094f-9f8d-4245-acc5-08df37999da3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|366016|11063799006|56012099006|261009223027099003|261028144727099003|261026121527099003|261021121427099003|261021123027099003|261021135927099003|261026140227099003|261022105027099003|10067099003|55112099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: XkjCV3jij/37+RFx+ddE8a3J7l3DqQCPMx7zcm67swxO67iyPcVzYAiadXE9TnzEzGqHN4HuXHTyY5uFfY4jklQeJv6dwY2BjedImQ6H3bgfWwuc9ydAc+3B29+dpRBdyKQNRbPy5nBJqw4TMboYcnOyyqNSNiMdHVrTGUA24fm8nS2PNAwPd9R0AJKAj1h2k7Z0wDzOCnNput7WN0zypkwjkfLr1N/YBSQMRveSxmGbi1rirFMfw+4kLXu3pF84Dmc0+dmLN7ioZZ3gVnVHZ4Zgfkl9XzRTB9Uzv+cf9kNtLSDR2js3iutPmHqTrn/ndfeAQhavV7ABc6FJTtVUtbXOsx9989O9lsHR+BQEPr1Fhkf29qCC8/UBqF1HkvNeX/zRQ7TZk+3MiDYgZgobnlmCCq8Ih9G1TX3ZyTu7lmnBTcMl+HaBCynNdL91Tl2+7nAGn0KVowXvYTuI09B5iS0fXSS1wFSnXXBKeyh+bov/6+HGH1m8jm81L36wtqBDJFDOnex5imr/Dfal/49IIO1RzoHT77NzMDT6fThH9YSp//KtC2PqOCwjNcb61lO/zbpo/mI2u/fC68eK13IrwOR+tZk9oVh1pq2RLJDYij5uY8EVCf45W1EH4q1tY+sv4/aYe+ZnbjJRHXXVOTiEQyw4fQ5yG6C2iQnCjlndMHc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261026121527099003)(261021121427099003)(261021123027099003)(261021135927099003)(261026140227099003)(261022105027099003)(10067099003)(55112099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bN23j9zLleUlyQApnYWOucRbNkURfAFg/5UdoGib6UdeslavvsLRVIEjT/15?=
 =?us-ascii?Q?FIVC1tZXukNN00K4NB73pKUGPD7C+vFgSbL2XpkJ73fqmROjCF7VLbbHFg5b?=
 =?us-ascii?Q?F0QKbivLRqnfMW/IK9fXSqzp6nIBJAi5ev8NiFOIth4pveFNl5omZbIkzXhF?=
 =?us-ascii?Q?UYtD5LSp1uEzQQBaLxo+3f9+p8TyUxO6qFrs3dU63WYKuwx/OlIGa/+jaoNL?=
 =?us-ascii?Q?UliSF390M6/cZCt5zIPCryoTRxtp/F39L3kxfZh3jjmu7sfRGEhDH++Rts/c?=
 =?us-ascii?Q?bttSEnhCqg/E4fZLpiu0PGV7pTyXTlD0QDgQSr6CZx3mnfeVAJkl2R1KJK2S?=
 =?us-ascii?Q?kZEgxp2bcbqzZ6EXzpFfvf4H30UoC2Igz3KGw5jY/uKy14UxDwh5eniR2mes?=
 =?us-ascii?Q?BcO+t1Rms8bLySFgGelz2Mm6QQOXXZz/X5mIF/BTEimH9h+lFiW3FKvrq+69?=
 =?us-ascii?Q?3eWprdyt6oPwSauubqyWs25o+AC8BRTeiDWDCk/pdaojzetG/v1YHLnUACXU?=
 =?us-ascii?Q?CS8rfzZCLiZXvbJjsGs/XdDsnYTIlCYtbA6do5k6JHf7OoiRRUIg6NS7xkmz?=
 =?us-ascii?Q?1EXp0W8ZhdQ1AaKzyNHFUl5s6jLL9v/WAJZGAGLyeNyDS68mMoDGMy98Bete?=
 =?us-ascii?Q?sWNy8DBTpKKeOysPpiMk/UcVeq3T3HrYpvXBUsfoL3KJltme9Ye79/nkt/aS?=
 =?us-ascii?Q?IHywddUP4fkHmEa6sq5zz0I6NURbkbxjmUjQCGQAEp4G2WVRybY1GIks2K5A?=
 =?us-ascii?Q?1kmUc1qFw77rrP8VSnv1IW02kq2QG9nNv5XH1A7EHbRTtlkjgNKzya3N/hYc?=
 =?us-ascii?Q?cnAc13PtKNxgij1FNhqrT42EoAoU1lUcjHz9f/qjIV1g6MIQqmwE55HSo+3h?=
 =?us-ascii?Q?au2Egwp6P/OjhAGHH7kJ2D3T5f5X/9YUbmbrcjDIINc9MNMrhCaljegc2U0y?=
 =?us-ascii?Q?RWZjHN7lW9pTS7B3mCXjMx+W3JLOMAuJqJCvvZeskh1Lk+cjpmUg0GNwssfB?=
 =?us-ascii?Q?tjmVT/5q4A7MTIZr/rVJkrrxlHnEca2BYiN0RRt6mWYnDDQf3iYBxjCgiCir?=
 =?us-ascii?Q?Rha9BiPS3Ke5ECQbmzLO/gFlFUvCjcM6IpWKKks3JuetINEKPos6Iaimo4aX?=
 =?us-ascii?Q?/vYYOy0J6PL4dnQVTL6QXnNaMqoFR5L18VoTAGiuuEGQ4F0PoozMKU5JsMby?=
 =?us-ascii?Q?cQpXCxdS6BXj6wUM+4xucI7lWMK6MBNZJo7EOtQDiMQnb+2l2KINHCWnqjH3?=
 =?us-ascii?Q?vEyJXC57s3fA7JUJq6xNpeU4YWbxliLwWVKovDCl93fEpixXwE8Jy2DprtkH?=
 =?us-ascii?Q?QQbioF9vqDnFLCdDZ6XHCQVzCcHQPfkJULyKRxeO++fkiDTVCpzGzzo4j5zE?=
 =?us-ascii?Q?8ILGEQfgePzBGVtxhcU7WBioeru/RZC32IEbiqCYDl1fVBIIuGeMlK8N8P/j?=
 =?us-ascii?Q?njbcwz1k1cRJ9WU97rtg4kPCi9/bbNbhW8RLQkqyzOTA5DI/o6z3EDVpZTcd?=
 =?us-ascii?Q?PlYiNcSmT+ue2NzAcBpT23z+vAK/wgqA1cstFgMPMhXHyyxVlzwgvJo7zw1l?=
 =?us-ascii?Q?6/Moyx/90gHNV1qdq6Zd02Q9RheY2jM+PrYNck7YO4BO387pRT8fLP/PrSMD?=
 =?us-ascii?Q?WoW96amOxobo2HTwTbQ8VF2nff1UTwCH1pd1yKlhuO3uFXmzZB0JKRUuAGmY?=
 =?us-ascii?Q?i/68u5ptov0AX+WktCiOJeaqS5spyJ4e5xgruv3vCkmjSB11yWlzFSfIU9qV?=
 =?us-ascii?Q?pR4DpnKOvcN4kBttMBADwKO5ymrjPNc=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dbd094f-9f8d-4245-acc5-08df37999da3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 21:55:02.5052 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j7YiY2wwgVxkL0Wtqfeg03oTKrARh/DhtqXl3AXXGliP5a6NlZlLuRNl3xqSdmwz/BQ9+qMs6T89vYGOZNKosSTM1ChnJuCMrALjjjEfQvQ=
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

set_vdd_mmc() sets PMIC aldo1 to 1.8 V. On the K1 boards aldo1 is
VCC1833_MMC1, the I/O rail of the SD card pads (vqmmc-supply of
sdhci0), and SD Default and High Speed signal at 3.3 V. The BootROM
sets it to 3.3 V on a cold boot, and with SPL_MMC_IO_VOLTAGE the MMC
core sets it before talking to the card, so the board code should not
touch it.

Drop set_vdd_mmc() and the U-Boot-only "vdd_1v8_mmc" name it looked
up, and the matching line in the sample SPL log. aldo1 keeps
bootph-pre-ram, as the SPL needs it as the vqmmc-supply.

Fixes: 80aa3d316060 ("board: k1: enable pmic in spl")
Suggested-by: Yixun Lan <dlan@kernel.org>
Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
Changes in v3:
- New patch
---
 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi | 10 +++++-----
 arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  |  2 +-
 board/spacemit/k1/spl.c                   | 21 ---------------------
 doc/board/spacemit/k1-spl.rst             |  1 -
 4 files changed, 6 insertions(+), 28 deletions(-)

diff --git a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
index 3077cdee55d..36c1bfc12fb 100644
--- a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
+++ b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
@@ -57,10 +57,11 @@
 };
 
 /*
- * The kernel pmic@41 nodes use the standard regulator-* properties only;
- * U-Boot's regulator framework looks up suppliers by `regulator-name`.
- * Carry the U-Boot-specific names (vdd_core / vdd_1v8 / vdd_1v8_mmc) here
- * so SPL can program the bucks that DDR training depends on.
+ * The kernel pmic@41 nodes use the standard regulator-* properties only.
+ * The SPL board code looks up the bucks that DDR training depends on by
+ * `regulator-name`, so carry the U-Boot-specific names (vdd_core /
+ * vdd_1v8) here. aldo1 is the vqmmc-supply of sdhci0 and is needed in
+ * SPL as well.
  */
 &i2c8 {
 	bootph-pre-ram;
@@ -80,7 +81,6 @@
 			};
 
 			aldo1 {
-				regulator-name = "vdd_1v8_mmc";
 				bootph-pre-ram;
 			};
 		};
diff --git a/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi b/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
index d6299c96949..200836cc204 100644
--- a/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
+++ b/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
@@ -105,9 +105,9 @@
 				regulator-name = "vdd_1v8";
 			};
 
+			/* vqmmc-supply of sdhci0, set by the MMC core in SPL */
 			aldo1 {
 				bootph-pre-ram;
-				regulator-name = "vdd_1v8_mmc";
 			};
 
 		};
diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index ef23db62d6c..87fde0293a9 100644
--- a/board/spacemit/k1/spl.c
+++ b/board/spacemit/k1/spl.c
@@ -275,26 +275,6 @@ static void set_vdd_1v8(void)
 	log_info("vdd_1v8, value:%d\n", ret);
 }
 
-static void set_vdd_mmc(void)
-{
-	struct udevice *dev;
-	int ret;
-
-	ret = regulator_get_by_platname("vdd_1v8_mmc", &dev);
-	if (ret)
-		panic("Fail to detect vdd_1v8_mmc (%d)\n", ret);
-	ret = regulator_set_value(dev, 1800000);
-	if (ret)
-		log_warning("Fail to set vdd_1v8_mmc as 1800000 (%d)\n", ret);
-	ret = regulator_set_enable(dev, true);
-	if (ret)
-		log_warning("Fail to enable vdd_1v8_mmc (%d)\n", ret);
-	ret = regulator_get_value(dev);
-	if (ret < 0)
-		log_warning("Fail to read vdd_1v8_mmc (%d)\n", ret);
-	log_info("vdd_1v8_mmc, value:%d\n", ret);
-}
-
 void pmic_init(void)
 {
 	struct udevice *pmic_dev;
@@ -305,7 +285,6 @@ void pmic_init(void)
 		panic("Fail to detect PMIC (%d)\n", ret);
 	set_vdd_core();
 	set_vdd_1v8();
-	set_vdd_mmc();
 }
 
 /* Set default value for DDR chips */
diff --git a/doc/board/spacemit/k1-spl.rst b/doc/board/spacemit/k1-spl.rst
index 187eed56e8e..69ebfc5ccb9 100644
--- a/doc/board/spacemit/k1-spl.rst
+++ b/doc/board/spacemit/k1-spl.rst
@@ -211,7 +211,6 @@ shows output like::
     Fail to detect board:-19
     vdd_core, value:900000
     vdd_1v8, value:1800000
-    vdd_1v8_mmc, value:1800000
     DDR firmware: [0xc0815840]:0xf0227179, size:0x8d98
     DDR is ready
     SPL: Unsupported Boot Device!
-- 
2.43.7

