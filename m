Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05803F9D0CE
	for <u-boot@archiver.kernel.org>; Tue, 14 Apr 2026 13:16:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A7E884227;
	Tue, 14 Apr 2026 15:16:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="Vw7l/+dz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75ED48421E; Tue, 14 Apr 2026 15:16:25 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CC7E84206
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 15:16:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yan.wang@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MB+7EnoA+QMvq7bZkMeOO2ByxR90elgPtx/qMiY3YqsfX4gocdO3IbsRjbPy5WvLnRz683mlcqRu/srdEIn1jKA7+wl0sh7rR+rkYmScJeG1ukptEBWt4CG0D6/5bm2wNBLrZOCmI6Rek3zx4rk0wzdCb6NABCJfFfbhgnC+X7FiqMcfWA8Ptejf+6XeCQSBP1qg/nrh9UKgwXJ8N60tNiXHkQlprT/HeN/uN4KIgRdFT+vTZTd24ve+bWsekwYQIMCH8Akp+EFn2v1uUSgYW+cbshZDk0GgFrPKrVsNPZWuTfzqSzQG5Jl4pnJdQAYf9MkJpa3IYpCvUZ/Rfz2G2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xO0Tk5lSMyp1sLNpLy1X/fhgwmo+NoqX7TjlC4EU0JA=;
 b=NYL7Hnk7QyroEf2Uo9Zs1Mldw+vlfhovreQT08gLuMFJBDmp6R3H0/Hb/pdokblF/bqzaz6jvekpwj5jkQGMaiWrhND1Lf2GJry9E+6tPU/D1Ufn1mcuA7GMTBCdUhKSdm37DmHIT+muVruex/HJ6YTDn6VSBTSOcjJrj5Ai3K/y2ibniT3CQr085rtUMWZAps/b4z0+YWzDGmaeegSaBWC0sscx8lmqvlayVrmubGIjK//fFPN0tipThhksR4yAD2u1u6VJVkT+J26gnuZEpmXwBHH2jdNxCXilpycIdipAVma506Vqqi38YavpaeUzqXrnwivjo8hswnVlYRCeIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xO0Tk5lSMyp1sLNpLy1X/fhgwmo+NoqX7TjlC4EU0JA=;
 b=Vw7l/+dzWl5se02tCTgvSSmf1YrFeaciWZiwV9NCIKuheASoe5mDxEVP2lsb+G+CnmwtaFsp6ScUcZcGfr7OljyCB/9+Jzohe8eG5r9rLMc0fMV34yp8FdbFlRrKS+vKLCTt7J6SuTWZzuqCxhjhpZJ8GMg5DqTOlpnSQe0H+eJ76oiFoem/VuYyQBC/5ganL5b6KNluJEOScChCm/6461DDmsrcdQ2NI9zFjnRR3qXJJOvHW/4v0HD4LPHSJY5TDUzwK7/M2P6SGRMNLjIWljzlVjKnnzZtCatcKZR3LPS9+znlmlTlFBcXyXLSqwYU60KdgLzqL5iSa58GPYEDjg==
Received: from PA7P264CA0096.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:348::14)
 by PARP264MB5420.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3f1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 13:16:20 +0000
Received: from PA3PEPF000089B8.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:348:cafe::42) by PA7P264CA0096.outlook.office365.com
 (2603:10a6:102:348::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 13:16:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089B8.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Tue, 14 Apr 2026 13:16:20 +0000
Received: from sah1lpt719.softathome.com (unknown [192.168.72.213])
 by proxy.softathome.com (Postfix) with ESMTPSA id 3DD3420737;
 Tue, 14 Apr 2026 15:16:20 +0200 (CEST)
From: Yan WANG <yan.wang@softathome.com>
To: trini@konsulko.com,
	sjg@chromium.org,
	alpernebiyasak@gmail.com
Cc: paul.henrys_ext@softathome.com, u-boot@lists.denx.de,
 Yan WANG <yan.wang@softathome.com>
Subject: [PATCH v6 0/3] binman: Fix preload signing with encrypted FIT
Date: Tue, 14 Apr 2026 15:15:55 +0200
Message-Id: <20260414131558.538656-1-yan.wang@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260408150201.217942-3-paul.henrys_ext@softathome.com>
References: <20260408150201.217942-3-paul.henrys_ext@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089B8:EE_|PARP264MB5420:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3e811a82-f660-4f72-90c6-08de9a2804fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: a3xmtYBV/pjuBplhobK3PpwDqBUvEx9MH6NhP3iWRq536EotwOE+14dBmwa7gUeAZT+kINUr7CyfqTumGBnNHIhxnI86nMGdy2IuBmlyt4GAiQw2Vk2wrwdllY9Z9ZscrO3Ssv4Q25PhqUvOa4XXpIIu08Uw3mraRIzneU4NERl7MsQddmkRlg/0hpPHSRFtxOZi2MnouPi2nJkY0Xm14UKMxiitOKi76bd3Y39EZlF8yVL0ik4Yu38f4ag97J5s1Tun3zSZZEbcau/OgcjfAu/DKlXGdCS56UXLVZhjxW1Amnm+yOUvhSMdk4BYIJdey4C4KcReg899sDihPNiuOR7NpCttmedt+1+08PSgg8fB8ZuxCkyA6gEzXSbZvtbccpoY9P2TjqVgsOwO86UigpxiluS5zsnbSHgDNeYsffg1k1ArNMHvARk28psxKkWCV/6qLe9obOjAQ97f19HNJcMICO0EnYbzJyAwnJ9jLYZy9QjqprT0GeKj/6w/zvMRb3CaePDbbGyidpAOeUhiE/zPHBp5+/m3Ex3VHZhA0qmg+fu05IwDUc89zbfMSB1XL+z27+iG0pZXLWjXyWeYyFqVXHvN3l6lysesJcvc2/UxEAnuSHInPgVj9nXKjYo8+tsLxvNmxe5D7RpQ9refVyD6lQLq9ENwelSqJJwj4OHrCA3khfz5tnmCzWJspqoi2GKy+H3AR6l0aAbg/uFL2ISLs+IC6PFRBYgPJRh9vtKHnuH78Q3Gsgj8zmSxqlEt/PpNJbc9Bm+4aFin8tpeUg==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FU6SKWEBHOWodcnInuAO4pn9DlvBbESu7FrFoK6ia7x3iX++e6aDAFvAOx/dtGv3OOXE8GCSXBdjv2IBGU1UXp6Gh48eflV/i755AkNvGcyVXqsN0oSumu1lvYsY/9XutC4akPvYmqm8iPEhSbA6XXOlbwZjtRIh1QN+xUiXXZFv/ae2OPKKrSSSjVUFOr//zB8UzvZRzxTlTVuy3M4hMmRRa01LqbSuugZCYtrxdCbNSbE7S2ND0dUqVFJHJsHpXdus4gc+5E0ngIkBKloYoBXoTafvf2U5TyVsBNSTx6VqkpT/GwBY78FKYt16oe7NbRKLo2s6tXpv7OJqsJ6nZL7gh3KgODdc6tg1wuXwKg4qrFfRtOnQANeV4Cj0P64q/GmQla196zLYjmd6LNIlZW0yzTe2RYA2H2jSA1CMGd9Jk256hhzQdOHgWWEqICou
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 13:16:20.5577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e811a82-f660-4f72-90c6-08de9a2804fe
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089B8.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB5420
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

This series improves the reliability and efficiency of binman preload
header generation and test it against an encrypted FIT image signed with
a preload header.

When a preload header references other entries (e.g. an encrypted FIT)
through the collection etype, the referenced entries may be rebuilt
multiple times during binman processing. This becomes problematic when
the referenced entry produces non-deterministic output, such as FIT
encryption using random IVs or timestamps, since rebuilding the entry
changes the data.

This series ensures that referenced entries are built only once and that
preload signing is performed after all data is collected. It also avoids
unnecessary repacking or repeated signing operations by the preload.

The changes include:
  * generate preload header placeholders in ObtainContents() and sign
    data only once in ProcessContentsUpdate()
  * mark referenced entries as build_done in the collection etype to
    avoid rebuilding data
  * add a functional test for signing an encrypted FIT with a preload
    header

Changes in v6:
  - set build_done only when required=True, so it happens during
    ProcessContents() rather than ObtainContents()

Paul HENRYS (2):
  binman: Generate preload header and sign data only once
  tools: binman: Test signing an encrypted FIT with a preload header

yan wang (1):
  binman: collection: Set build_done on referenced entries

 tools/binman/etype/collection.py              |  9 ++-
 tools/binman/etype/pre_load.py                |  9 +--
 tools/binman/etype/section.py                 |  5 +-
 tools/binman/ftest.py                         | 21 +++++++
 .../test/security/pre_load_fit_encrypted.dts  | 63 +++++++++++++++++++
 5 files changed, 97 insertions(+), 10 deletions(-)
 create mode 100644 tools/binman/test/security/pre_load_fit_encrypted.dts

-- 
2.25.1

