Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D304C982FA
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 06:55:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 504D960675;
	Tue, 22 Sep 2026 06:55:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id arvdpjOdGH0u; Tue, 22 Sep 2026 06:55:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 823B560662
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790060130;
	b=s42qovP+O/GFU0DpdQG8tdVMan8sCkIUmF8YysGn+3XTGEKuPbWaEa5aQCLkNqK2dyAG
	 N6J3A4+dmRO5HbOYA/sdxK7IF//2ojF9p7hwxOI8J/L69r0S5dsIPWNbeBjVW+4QaBEji
	 +4F+My8U9SuVceKkjKpRef7MHkSOLtRw5/P5epVghC7koXIeue2kp41ZwuNRwmYe8xaDT
	 dWhUzCO702GxpjeeINaqq7vFOtwo34/WW5NQqJA/3gaZRHMiW7PBrJb4kVdHmbeWwxUOB
	 6Zicb9RefO22t48a2W2YZIwnXsaLeQo5q4Hl1jMoQKSTUIhj/+gtt06O+dyUO+rYp4A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790060130;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JIVbKt2QLW43Zzvj/mH9ahfa1/OCpSSfXm7BN0rpsWs=;
	b=LCVj2WWy6yqO//X49c2sq8Wm1rytZ1RhGQC1QF2Hwp/FIAK135hMoTO2L1Lszlx04lCi
	 rE0kPEibznoMqNJ5O62N1pgRrE1z4P/13E/2R+yLZraTsjzVPda08TluoXxE/rUhjoJP7
	 I6wbeCzVCwgrl8vC/7gGXBVoDILU+5lS5eozdZEKD41T+cj4ree6Pp8K63vKUqtqsmGyk
	 T5pug1q6YHHKOPl6OeVBBuXImKpOqZKV0i7efRogXrb9rtgn9KfldNEL7NbUGha7e4U7r
	 GC7oW7cZV8R+YBYFEqdtvSqKCt3ax7uFDAIeteo96lDcTBwqlyL/8vfdHuSllUuLh4w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790060130;
	bh=JIVbKt2QLW43Zzvj/mH9ahfa1/OCpSSfXm7BN0rpsWs=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=0eFPDBqFfiR96DvM5V2t/M4iP08UZ2QZWXxN9ivuTc8lRnri4yAIGSCLrdsVJdy92
	 HdjJdFqZdSWB5YyFqxQEYTr//ccXxuxBURWxO8BA94MXWF3n7KC+/lIus+O2XzLzPZ
	 2Vuo5nYMQTqhMZN2VO1TM/FqBiaxDkaBL6VILrMCCow/RZizXAgMmrwZOnEFs4Qy5a
	 amYqU2WRBXEiMBjmUjLcZACl/jLvttfOwZm/E8VlwDecmCdgOw821HN2U/4xA83XA9
	 +59cmYe6T8q1G9qPfDDIv4sB0Uj+FJdQSi1nVl4aaEhKIsa1RaRoywW9s15SrjtJRx
	 ++Xve0JgjoyIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 823B560662;
	Tue, 22 Sep 2026 06:55:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 901DF34E
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 06:55:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 756A080DD2
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 06:55:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VfRSCU-gtTWn for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 06:55:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8F06B80DCF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c007::2"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790060127;
 b=G2S+lw9dcbwZXo3eCTVSW2IrC0yl36YKNw0a+RBDxCM8tA5MosH77QhfdU/gmgz+WJB9
 05S3pwbyO1RDoWSRumaGItOweLqJYIdbJpag+y3KTEU/9FbjwuCQwXeYO7J+0c9DRzG5o
 eIJec6D1UBFz6GKWSF+LWhamGBxkl51JCl6aji8NM2uzRaxTjQatT2G+hcymC5OuZpTok
 qAxuGFQ6ANLBHiY1SYvparTgf+eJjSFP1ngizxRGqvTqD49PNEIjvvH8XgDpsK1Tq7BFC
 tgGJVajtuutWhI5uv2GSUzcDtA4+qUT6sc23a5/M5LzDAA4cB4kZpBHKHcaTeFC5q5A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790060127;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:Content-Transfer-Encoding:Content-Type:
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
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=JIVbKt2QLW43Zzvj/mH9ahfa1/OCpSSfXm7BN0rpsWs=;
 b=iel7BmP6C6SNYuMOzTF80R58+rJwTf++nNbpF+cm1HlNqiFbxygHQmgqWnVOre0Cy3lB
 aetDz3dmr452iARjK49zxtepzWwaQ+3x6AjU/G6fI+mQntifwkI2bW5Zt+mHr2xJPsM+M
 z8Ox6HqYEdZ964XgEzs0x1bKPVrTLzuMQqgoZq2/kR8ByLXYV1TymZi8tVsoFu9NhLONO
 XhlRpowDSWGAoDgenkJDpBagOmxOvPcKorZtXpCPUngyfr1UMKFaT3R9JTkMjrfAUkSty
 peJrFlwgcbmEylTl+TDEfTmHOHrzqBAvWZdqE0uCafaiNHO7hM2ZgXhZ5fJh5PXWQ6A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=xjq7TMc7; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c007::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c007::2;
 helo=mw6pr02cu001.outbound.protection.outlook.com;
 envelope-from=pranav.vinaytilak@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=xjq7TMc7
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8F06B80DCF
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 06:55:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c5JYuD1F2V76i23jgMcinNDSv3gH78zIy+GiTep+kLT6ofehi0QqCu717yS9+BiaQGsINUCTFvSTJlXHmXl020BtUGC5Us8yhjawtJogbzRzvNOD635ODEhcOzPRseFXXAFdjGZz6k/wjLEIPFDayKvNZ1pVsAubw+gbsCGf3nal4NuvGAvqcPPSSPTws29UV0XDX7K9twQfzLWLxRrppZ+/DKs9FnUWCtNRJc7eZZ4JWcNphTtiXzLu6dI2rMQZcHrhRzXvvYr2G3gIPVORpQX7bFSFYJJfJquQnlY8NcqQoeddzWeCsUsCzfDbJexIm8HEI8VYu3FvzYSFi38Cxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIVbKt2QLW43Zzvj/mH9ahfa1/OCpSSfXm7BN0rpsWs=;
 b=eB2Zqo6zRfj+I2jSQ8qs1M1smE0uSnqHTATzIJCHCiqMdtoi3tmM+leFtwjdrUjkCrmTCvJ1ZG8xMmrykmjg6Yci/pJRuUpcuhaQuMzxuANoPDVEdwJsWnXIWKFxZHV3jLNQ6KbbH45RvGqiOt0ZdoSZjp751sDqRLTkmuRvFViBcGLHGb5vwtI62j3zck3fvRKdl6As/gHaZdu7DYlUZD2ruY+Un9KFm/aK69JmrVL7io6Scti6k0Ucel6OdB69mpSiBRGcvP15tVD8fCyrUNBRfcPNIrUpGjmApljS8DTjy+85tCoC67F0QipFIbWUBBKP9LwutY4j9Jf47doQsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIVbKt2QLW43Zzvj/mH9ahfa1/OCpSSfXm7BN0rpsWs=;
 b=xjq7TMc79LbyTouQjjhnvU4KZaX9Je++uZkf7Um5PhklJ7DyNjNwcv2xu9Qr5/vlKFiOAPYBWPrQSCgLob95sydEqtjBZ6MBqj6ffHSXQY+BqIzwNVg/fz/hr7rBp3BDFL53mw9XeFlG0B9IIkEaNtoB3q5RPQ9bAd3OVPJYsyk=
Received: from BN9P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::17)
 by SJ0PR12MB6926.namprd12.prod.outlook.com (2603:10b6:a03:485::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 06:55:20 +0000
Received: from BN2PEPF0000A891.namprd04.prod.outlook.com
 (2603:10b6:408:10a:cafe::26) by BN9P221CA0009.outlook.office365.com
 (2603:10b6:408:10a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Tue,
 22 Sep 2026 06:55:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A891.mail.protection.outlook.com (10.167.248.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 06:55:19 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 01:55:18 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 01:55:17 -0500
Received: from xhdpvinayti50x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 22 Sep 2026 01:55:15 -0500
From: Pranav Tilak <pranav.vinaytilak@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Pranav Tilak
 <pranav.vinaytilak@amd.com>, Tom Rini <trini@konsulko.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>
Subject: [PATCH] xilinx: fru: fix OOB access in OEM MAC record parsing
Date: Tue, 22 Sep 2026 12:24:27 +0530
Message-ID: <20260922065452.1908297-1-pranav.vinaytilak@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A891:EE_|SJ0PR12MB6926:EE_
X-MS-Office365-Filtering-Correlation-Id: 60941c2e-9b93-4069-b46c-08df18767706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: VXXNyhUxqzenWdUMXxIX7jN6/51hKmA8tZkRAzSIYxxypg4OBDVzRt0RHVaWmBilAOlpQ4yjuFQC0zbVjVB0Vg2AmGSGSK+6oeI7EoXwYjBqoL0HwqDCJpkbAsw+YMae6V0A2THGYwD7TF4qSYN/mMh6bpZrVnOYbTeCRn3Jvyy85fr7/meAyWvGVGDe8zBuDwj4YScT5CSeEwkpcIaY5hSjh+/GD8fuv6PNfACuu9QDWin3BnC9hnjHBapM0rj94fTx6yMWPfCPLFLky+sBhbJ/MAusTgCcZh8JsGX4Oww+p6dYZl3qEBE7l1cmTFlBKBKK/VaLCSbdfLdPsP/uenoqQVWCeRLOE/lJsy8V0rGgPNCFW25iTieEPV/Mmn4fw1hDAa9r1VxALwB4odiozZq/L47vtaDKdil+G+I6qGGNPVnu9kBmJhA+edRph2ncozW0YEmZIXSc2iXVGNJBkejeae/Z6U8rw7XB/5SicPGWNMTx154bTyAQTteR642aucRw4oN/xA8bDoGhQmJokHRDTgjLH9JyWvavpPFqu3oHv40Fkkye4gTEMUDW3JIy8MqYkyduDUso2elmSh7sNH+ZAVIwIlDFW9rfyB6BFahWX4W0yNij05Psd34xQoAhjLRhJ7hzhb7yzd9glCkd75JmcxsddXtJnUfjKDENnEc4i8rP9nABpfjRN1sj4d38dJRExDo9MLzIIxi8sXv5NQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: J9O0+BK7OosyL7kfGYnieMdy1cdv/4LgNRdLOk0JOUf2anJuXtvBw7r1M7Zy6qP9+hAajV8w5c3Grfmz44uBfteRP/U8dDroYjET16v+UDH1TCCWQcCh/6RkpoweyUH9bLKnsF3YjWrt+KqATM42EbwsuVhIltL8ZdnCZ9/5bdmSNc+EiH/tVaORFYta2nR7JpQykXfyWgZp3GCerLprZMVI1Fo0SMEAP2nZPMuDhlylIbumh//s3SpJORrYaZUFcv7SeaYIB7DJzfUgC1SGB6lM6esen/2Mp0oLs0qGOuzCcTE3b9ASk8niiEq36QW4eQrGgSocSfevfwJL89M81WcO4/jdlLw4t3Itn62KKlhn14mRF/nobW6teglVz/AC4yrzBndqlIkOQeukQ7a3gvGGEIescmBHqiXohyv8RCDgjxkPj7LTflZzH7Y70XLE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 06:55:19.1649 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60941c2e-9b93-4069-b46c-08df18767706
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A891.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6926
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

In fru_parse_multirec() the OEM MAC memcpy uses the EEPROM record
length minus the IANA/version prefix with no check against the
destination. A short record makes that length negative and it is
converted to a large unsigned size by memcpy(), while an oversized
record writes past the stored MAC array.

Validate the OEM MAC record length before calculating the copy size.
Return -EINVAL when the MAC payload is not a whole number of MAC
addresses or exceeds the destination buffer.

Fixes: 7a036b674fc8 ("fru: ops: Add support to read mac addresses from multirecord")
Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
---
 board/xilinx/common/fru_ops.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/board/xilinx/common/fru_ops.c b/board/xilinx/common/fru_ops.c
index 610293bccf7..24b135f7666 100644
--- a/board/xilinx/common/fru_ops.c
+++ b/board/xilinx/common/fru_ops.c
@@ -260,8 +260,13 @@ static int fru_parse_multirec(unsigned long addr)
 			if (CONFIG_IS_ENABLED(FRU_SC))
 				type = FRU_SC_MACID;
 
-			if (mac->ver == type) {
+			if (mrc.len >= FRU_MULTIREC_MAC_OFFSET &&
+			    mac->ver == type) {
 				mac_len = mrc.len - FRU_MULTIREC_MAC_OFFSET;
+				if (mac_len % ETH_ALEN ||
+				    mac_len > sizeof(fru_data.mac.macid))
+					return -EINVAL;
+
 				memcpy(&fru_data.mac.macid, mac->macid, mac_len);
 			}
 		}
-- 
2.43.0

