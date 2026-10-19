Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD69CCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 13:23:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BC96B80BCF;
	Mon, 19 Oct 2026 13:23:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gKlqyqaBQ-0u; Mon, 19 Oct 2026 13:23:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0922680BE8
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792416238;
	b=fRyq43VBionuyonfMZE02kzY1NItFNzF6dyeADkgML6kpcFfNtSSzR3pSuqSc19LXbAX
	 EW3kKRsS3+YUiToWAGXNJzGwYUGr8tYPU51YZEBJEGNEk3tm9g3QN+ZiWj0vgInYTXiaK
	 RcY4EBZrP+10SdBK+e9HRR2o4Msom1N2/Ti8SBdWWgsLQuZ45mNfROCmMmGwD7LWf4RwH
	 EQIx0Fhwc7e9ZYQmtBb7mLi0AejbdEP+kwvxxGwLTkD2jLOnuDDEmmcVZqPK9tr+griKs
	 MBaraoQUMeGbKE/zyZps0jWYiy6bWXy/kyywUKAQngxaMpxB03xVbUuWQNfuSb1m8FQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792416238;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:DKIM-Signature:Received:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=moMoCZtuPcUN3yz1RiDdS4KMkKVOnz2oOH9tAkYIsJo=;
	b=jRZS4qN9/BPfgCo+EF0dZyqiEKLjZuMglOgy9bwYc//k7MMxoyAz88Os37hoqszbIkxq
	 V7D7iUh5OfjhVsvTwm0Mv7cSwyhpeSX2t2aLHPuCOtlZTKmXhBxuMZ7eLBnmQedBI9w3U
	 ulYb6dMweobCueLhJCMBxCrjV0T/l8GXs2B/RqVNYvu9sce83YTDDvRl1Js5/HEJHuqT3
	 n4xUmdSClAicXDCzoPQoAcv4eHyuxIikk5Xn51T69v61srr/u2GTu8clq7b1mVVv6hphY
	 6JrzA0XtVf9ggt4od0nwvHpVgbAM95IivhWMwaOZs88Sdb6IBybSBFAp6Q8Y6fBGThQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792416238;
	bh=moMoCZtuPcUN3yz1RiDdS4KMkKVOnz2oOH9tAkYIsJo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=I+mWLHF8SaU9AsgtJQZ98Zwb38Fl/y2i8g9YBLZmoN3+MwvbqMKiaclNEo1TreGpO
	 WG6xSetgflcJiY5PC6XDkv3scsLXMlGCFBDScyUbFbmmXID8tVoTSFdmvwF54Y3JpQ
	 C2QKWQ7cEz29UDJqTI4xEE8aGmT8NgH/oOeItNHiOH2uisrZCcrU/qfZB2tvTK65G0
	 dVvfjG96DKD7at/sYZYU16oGvDUaHzSyJhmcpXdY8/Bs50a7NqaxR5ptzDREc3k8eQ
	 aUaPb+Lmyi4kEfxaHj4jLg9hEdPNcvT4JLEqI3YnAdDgcntf7UsQwON5518NPn4L+o
	 MQNdiCN05EAYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0922680BE8;
	Mon, 19 Oct 2026 13:23:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 20692465
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:47:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 05F88401EB
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:47:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I_WyiILbn5xu for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 08:47:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DDE2840062
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792399654;
 b=J5yuJ+HCYSLvdJvslPlTiPbBH/eEkaVMPPWVqQGWWLEbX2VsWMe81SSzM5d0TKTeRIdO
 3nB62/ce6i7fwrg/JgSGSb/fw3D0p14g9ixUu8OTBS0j9My2kcIaqc3EEf6KeHYh4QSgl
 fs3kj8sDj0XC61wJpU6aLHU/uADmmltgZCBMusftDcRnt9GZDzZ6uEUnPGeqRw9Nk6kQm
 ieEt1SXt6h2D3ZEqP9cA74yl9PtVWwStGaFUPKSrVlD844842tb1fjoRf3Tl8kIVCdiEG
 8AvaDaJIHBiYt5F475zCMLacM/ZX1rJ6KZREAhESPIAXwcV/kex9upGXfoiS3Rfjq2A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792399654;
 h=Received-SPF:Received:DKIM-Signature:DKIM-Signature:Received:
 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:
 X-MS-Exchange-AntiSpam-MessageData-1:X-Exchange-RoutingPolicyChecked:
 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=moMoCZtuPcUN3yz1RiDdS4KMkKVOnz2oOH9tAkYIsJo=;
 b=kpqhekuR5dR5hhEtE4aitdnJae1jM43J1O3Fqeo8jkFKsA2ZmTARU5II/IrKaOD3Rh2U
 VNoALfgudI80uB+SMe/9E/VDUmae/hOvXXu0xHxhJflfIlpjk7Y++TrFwyem46tIIcGu0
 SD+vXtmrk9tyTP54TIBMX2vQa0OtJpd+Ax4UcXD/AziTcVW/GtwsMuR4lZVZR3MVuB+LH
 pHZ9l6mAdrV8AJFri/dKDKPWdrk9ulXIvPtNcEtx6PBGkT2O7AGRIyUHAbPKMIRbKaZOr
 kJklUoEstSW71GQEYHfpAfvb3zty2jc0Zg1oKUCQE5X0Y7Xe00FqFem6c2cZGpvX+Uw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=analog.com;
 dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256
 header.s=DKIM header.b=G9pr1oej; 
 dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256
 header.s=DKIM header.b=f+aaUtwj; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.135.77;
 helo=mx0a-00128a01.pphosted.com; envelope-from=qasim.ijaz@analog.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=analog.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com
 header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=G9pr1oej; 
 dkim=pass (2048-bit key,
 unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256
 header.s=DKIM header.b=f+aaUtwj
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com
 [148.163.135.77])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DDE2840062
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:47:31 +0000 (UTC)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
 by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8N1EU992103; Mon, 19 Oct 2026 04:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
 h=cc:content-transfer-encoding:content-type:date:from
 :message-id:mime-version:subject:to; s=DKIM; bh=moMoCZtuPcUN3yz1
 RiDdS4KMkKVOnz2oOH9tAkYIsJo=; b=G9pr1oejRm+pUpxkNPbPhgoSR7QGNTgc
 HtChJRA9pBDS5UFOgnL9Lpb0uALMqKXcy8h7mV0hGK8PVr01Jy2KBaCTSbVwpzCu
 Z8vzv4naKD/om/FQJe6g6/uFfmhNVWbrAv/LEK1MBjeo6huAFj9/5HDcsGg2FAFd
 eaZ5Xj2Du7BuNzDLrNmLCEZRHS3w+JBGLb4IuhRCLLmYgTtyeU/TxMG9MPezbgbW
 s0+CU4zGV7jjgIwDH5+9iw4AjU0iWAjYa/LZoGm2cKKhzez6rl52aSLqsEvJGO5Z
 D3vNpkOaWQFaW6wezPB5BP+WvooHBJsPYhvOIi6oxdnQsHA/5iVWtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=DKIM; bh=moMoCZtuPcUN3yz1RiDdS4KMkKV
 Onz2oOH9tAkYIsJo=; b=f+aaUtwjrTJp6D229Esz9Jia3f/2lhYy83qjgeKwwFc
 K+RWxiYGqof6BCyRd6oWf175xyjNdJ7p3hQZrUc6sggygkkf2SxR5szTiiVU20a6
 QLiaWnHo49FZOg9zzgHByyiCRA8I2utF2T0/ahiQ3nz9aPECJAjPysMK+Uz8JkV5
 ny4mX4g+fXCw3hQ5UNY4HF/rKJW99IsxaH3RRHGBBT1E6mVMcf1e3kDQJudwHvsX
 GaJ944+WmlpwaoQy7niT81g2v98jMsDIiAP5c69XAs7uiY7a/87Y7hMiI1sLrJhO
 g17LhFd3M82/f8ERCMJfF++pBx++D12+8nnKbehZQ9w==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012018.outbound.protection.outlook.com [52.101.43.18])
 by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hd89btapn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 04:47:30 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pVH+hh5Hfdvn5hwlYfdb6O8Up+yR+ro+cqJrYJXYl+vR+Sm9p3QbfKnzCwMgKAvb7r4AN4jy6qhksGKEJ3hK13rD5P8SUTApe0NsVmeDHwSPgNOEl1FQQ49OqYiSKZqeSlsAQGaADmgWEp+kpyN6AVj88WZcDV419HqckCdjcvB3rFKxmMjnHvnuDRSzodGCOTIYU9JcHFT61kmkajSSnAG+aw52xNzToae/q9EgdihfmldsNfy76eMqSsfXqwA8bd9EyJPBrav79xZm/ii+SX7IDQUdOpLMW0WhWiN2rx/UXTT23vl5GkqP+RfptmSagAWjJbXaDe+R0f5yC6QrDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=moMoCZtuPcUN3yz1RiDdS4KMkKVOnz2oOH9tAkYIsJo=;
 b=csoWw7/j0b8vnIsc/Ayg8BVS38MCUIruoCffKRtc14pNt/ZQTZVxEv1bdtrjRSVuvUegp31ILMVV4WU5psDgRrLL3sipEj/mdBfwxSzr5sGwc2jSF+U1EFQjl8UFAgkHqJsrmB2v9gs2YoHYF5CsDNnsDl7SBrwVmZtSN3wcA9LodT7dsjfV7nDPp6WsZdoVSJSLKKIOZ2XU4yCh0If0mhEWfdiLJvlZr3u7bJz1ipYjpEsuGBdaSZBkuo9RqvjDB5BQUhDbbpsKG6PHqHSr2dV/JNh2o/XGPGpAjiEP97OFqw3oplJvPMl7fPP4/76mZnLB6BEKG161RAwKUoGzHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from PH0PR03MB7116.namprd03.prod.outlook.com (2603:10b6:510:297::6)
 by DS7PR03MB5461.namprd03.prod.outlook.com (2603:10b6:5:2d1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Mon, 19 Oct
 2026 08:47:28 +0000
Received: from PH0PR03MB7116.namprd03.prod.outlook.com
 ([fe80::50be:b527:c519:6e53]) by PH0PR03MB7116.namprd03.prod.outlook.com
 ([fe80::50be:b527:c519:6e53%5]) with mapi id 15.21.0522.011; Mon, 19 Oct 2026
 08:47:28 +0000
From: Qasim Ijaz <Qasim.Ijaz@analog.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Qasim Ijaz <Qasim.Ijaz@analog.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH RESEND] cmd: clk: Don't truncate "clk dump" clock rates to u32
Date: Mon, 19 Oct 2026 09:47:06 +0100
Message-ID: <20261019084707.35955-1-Qasim.Ijaz@analog.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0160.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::21) To PH0PR03MB7116.namprd03.prod.outlook.com
 (2603:10b6:510:297::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR03MB7116:EE_|DS7PR03MB5461:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b177411-b5b9-4a6d-1d09-08df2dbd9ab6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|10070799003|366016|6133799003|10067099003|18002099003|11063799006|260925021311599003|260925022911599003|260925021911599003|56012099006;
X-Microsoft-Antispam-Message-Info: AyNQckas93aSeeTsB1ax0CV6e4P31WpLw4LxsmPD03v0KjP6s4mYcUu6ie5NuiZ819m/erkjRoFS/+GV++CZgr14LaDASv9WIEOgTDbuTIhIaloOWmKIgFFF9OocJki3/EDJpaJNktTtOKoaLoJVZpTxmkVjrYmDcgcEJZYte8nZqZMq7nu4j1Qb9eW6lzRiqGqH1aiDS4yys11DuDOm+zKkWBnEdhqpmrm3nkKn0gf6Snc4oXPYrjLodtH0N54xPN6e3aVL1gcJHB58XEJ7JXqwgeTV57dkCTRyCivPjhSmodZED93AADm3PG6cL1dOpPEn3n7qdOllv2Q1LVIkdcXN1EIFl/x9XUP79NxPGKXnwNbuFRpFarzK5Sno4286pT/pZ1jrZlVU9WCUgVpb4Ge/dnogrUas2JK3ZGigVNg20LXNrJ9Rf3gzybQiIdd7eN63N6LdEb5vbZl2DYXOHQnpiHR5UnoGUeVKyu+a7BEqldNdzF/z1JNdLkGshnmjEfFpp6vn5hXKK+Ft3m/5U6TSDNG0vAN8Ga8eslHn2AHo7UIRlOc208fDFrOVDRIyvAYFVGz94ZSJAAlu5253zF6xd64TUbstLqrkljNUqUwiD9/mSPdN0gnXDCugbDpvw5yIybxIlr0IDEsx4T1vzfDW7HE6io4hDtCgxCDQXl4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR03MB7116.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(10070799003)(366016)(6133799003)(10067099003)(18002099003)(11063799006)(260925021311599003)(260925022911599003)(260925021911599003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzZteC9jZVNHWWYyVTJvY1VUdVhCM2g5TGJBM0RtWTNCU1ZJWlV1bnREd1lN?=
 =?utf-8?B?eUliYjFzZzljUDRzSlhxUGJuckZ4SVhORGg3ME5KdjRGcDdWMUNocTRFUU55?=
 =?utf-8?B?ZTBFVUF6SFc5Ym1FR0VRYnoxNG00eUJUdjVkbURocXdKZCtuS2d3SmpKcjZv?=
 =?utf-8?B?ZDVXQS9zY1c4L1ZkWGNCd2tSOFNwSDZRNWhtejBpTE9NS1BXdldrMVNjTHp4?=
 =?utf-8?B?MlArMFVNbjgxNHNGM0FTTnNHd0VBNGJQVTBFZ0pzZmVOWkdUa1RnTjRnQldB?=
 =?utf-8?B?V2gwS0x1UjJiL1RNYjE2YWE3Z3BZQWxjZXRxbjA2UVl4K043bk5IYVpRQjJ1?=
 =?utf-8?B?MCtoR1BqQko2eWlBY0c2VG0rUkM5dEtnU3dRb0hOODR1VG52SlVrR1ozZXhp?=
 =?utf-8?B?SVdBNGNyWDFMTk8rNWtCbTkveEI1cnRPRGlaNE45QmhTWHpLZENvZVZnTTNq?=
 =?utf-8?B?R2pUQlNrN21pUmV5WHVuVkN0aW9ZRWxtaVdrUlJqOGk4QndhZzBJMU11ejJT?=
 =?utf-8?B?WGliOGYzSkcyU1ZZRUtuanN3NU5jR2dyY2ZRdzNGaDBmMkdkN2xXSUUrcVdN?=
 =?utf-8?B?T3BpMHkxUFBuek1jb3RtR0NHQ0ZDOXkwYlAraEp0dkxRUW9QOE84Si9yamE0?=
 =?utf-8?B?RmxicmxaMEwxN3YwZVdUcjF6ZTAxcGZWMU5YMEQzZGlBazduMlEyUGMzdkhr?=
 =?utf-8?B?bTJQMldxUEhlUSttdnROMGVvRUpOL0tLdDAwUlFEYlhkYkYvYzYvYlNIcVA3?=
 =?utf-8?B?Z2tLeXdSQTE2SG9UVUo0QnYyYjhuTTlqSHFoVjQ0TCtrSFlHWlNtTkF3amhD?=
 =?utf-8?B?aGQyMHBEakRiVmNUbEJXNGZRdDZZSzBsMi9VRlFFZXhPTnJ3Z0JEWktBTjJl?=
 =?utf-8?B?U1MzdDFzOTN5eGVhRVRRbWFZRjZIYkhsQlN0bUNjdTVyMnU0Zm1TZ0Ixd0Y1?=
 =?utf-8?B?KzJ4cTZIOVpkSFo4ZUtzb2hFSmxCaXlFRFMxbllXSkhWclJiMDJOUjBUZDMz?=
 =?utf-8?B?NjIvd1gxYkovL2s4VWVMWFQ1ejNYRmpqOC9sRVJuV3VVTitIR0N2amp1VW9a?=
 =?utf-8?B?OXJrUERKWkxUUjAvbmJCaGxlZlJpUnI3OVhCSFAxaHpJUHZXbWl4c1JXY1NP?=
 =?utf-8?B?bFFmL2JNSzVsYXN0MXVWa3RtTHBqVlNLN054UldtS3N5TkhBVjI4T3EyL3ZY?=
 =?utf-8?B?ZXh0NUZkeDlFMnZwZWl6UTZQS2pFam5rQWkrK1l5WHMvZ3R4VTRHZFdxZUxz?=
 =?utf-8?B?bHB3RU5UNXQzL21yRndBc1lKNmE2akMwWERVZlU5N1diTkFHT2Y1cUhTME9I?=
 =?utf-8?B?RGIybUlwZTJGYXYyUDdZTjNJTHZPUy9xbDFmSW8xVGF0eHE5S2ExWk5uVlha?=
 =?utf-8?B?cUIyVjFjajFUZGJtWG1ubXlZZGplVkg3RWtMb3ByMUdVNVFYeWhrblllR3J5?=
 =?utf-8?B?Z2ZuNXk2QklHRExTbEZoOU0zcGVNVEFkTmtlaUxqTTk0dEY4aUM1WWp1TGMy?=
 =?utf-8?B?Z1VzNVdZR0NjVThwN2o4bE9EdUxhNm9rUE1LcHl2WUI4WCswMklrRW5iUHdH?=
 =?utf-8?B?LzYrYklUT2wwNEtVditVb2tsUDJRSW9tM1Zlc0d2NEtZQkJyYXNSS0Y2ZXFh?=
 =?utf-8?B?OUpkb3JuQTdyZFRMcVIzem9iYkZEOU9WeVplMGNvNnQ4R2FhRjdYUVpuSm1V?=
 =?utf-8?B?RjNiTzI2VGZwYjcvTXVzZVRWRGJjaWs3SlQzTnphUFV2RUlwK0FDd040RVRX?=
 =?utf-8?B?b080M1d6dzA0WS9RV3E0Vm5IS3dhYlJaMk16cTZzeCtHVGJta0RiRDF2cEVJ?=
 =?utf-8?B?VTdLTm54MVlDTEJlSGJ6c2NqZVNDL2xBR2FsZDNMWWx4Y2U3RHBxMHQ0SnpQ?=
 =?utf-8?B?bkVGZE1RYk5DVkM4UUI5aGYzUmlINEtNMVhKOWFnWG04QkpYVVZMZlpEVkVi?=
 =?utf-8?B?UTRCdFNESEEvWS9OUHVIZ3ZlV2UzOUE4OGtCRVYveEo0YmNmRW9GNG96V3NN?=
 =?utf-8?B?ZjRtRXV1TzQ1V09RL2VwS3Jka2VheEQ5K1ZaRmJrM3BvVDRPdHB3T1lVQy92?=
 =?utf-8?B?bVI4dEVQMGxvVzg3YnV6T2tVcExHSDlsODFoc3gxT2xtU0dDNmhRYXdHUjZN?=
 =?utf-8?B?aGQ3WFErY0Ivanl4SVZIMlI0LytLUEZQK0dacFFYTEk3ZTdLMC9oTElaZ3RS?=
 =?utf-8?B?RUFkVzNsalNzWmVoTmxZc0pnOXg4VVo1bXVHV0Y5TWlGK3hGc1FvQ0JjSGFt?=
 =?utf-8?B?d1RVdUNtWk54bmZzanl4dUZ3TVNHVUMrVlFWbmc1K1RIbUl0SE1MTjgzbGRJ?=
 =?utf-8?B?SjFzd3c4TE1aZVF4R21CbTEweFl5WXBGc1dtTUtmd1pZYWVpRkMwN2tPVUFt?=
 =?utf-8?Q?lQ84CUZz+/0KNJqdQGpPplGBE6ZfdoQfG0f8lwSR58F1K?=
X-MS-Exchange-AntiSpam-MessageData-1: IHusH9CUnjaLfQ==
X-Exchange-RoutingPolicyChecked: 4NNMUSzZnDLl4amtVRIijpIdhBcOEy4sdxmKYBxvhnXXm32IsKNlZHUaBFbskcZ47Ll4mX4K5hb56m5OSZvVbUeK49ltJgrMgPzDaWHfxs7DYKMZBF+adDusDdZPOm/tEutHAHG98YKAJm1qfnvxkrGlQRexjAjv3w02tn4DAnTdh2TsF1ZjFAHkfeUJpj/GGR145DnQpoDIq3Alz4a5ul3qwDZsazdYgDVDVfcOJqFfMMRVJblmbAqevgitq9Hgm6M6v7K22fGoS6sbR5Tg8aJPsHMAINr5vvCCvcwsZWTQMMiT7FJtahKrkxvBGffCFV/tVBAMi+WqMHk+vEImSA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b177411-b5b9-4a6d-1d09-08df2dbd9ab6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB7116.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 08:47:28.2872 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nt+lPUNQ9SZpRnhLrkI1d9dxmUhJiG20fnhLZoWfVONUE4Qu84jihSfnOp7stG/4ivfA+sCSFF5NyqZuFAgmmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5461
X-Proofpoint-GUID: DwjayZiq11_OTdTFrmRMxxuF1DPbWQ4p
X-Authority-Analysis: v=2.4 cv=XuhvqlF9 c=1 sm=1 tr=0 ts=6ad5d922 cx=c_pps
 a=aTmL5QNlyH7IpnOKEqsBOA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22
 a=gAnH3GRIAAAA:8 a=byfB9pGBAJdzxDXkMXwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzNCBTYWx0ZWRfX9tjTN3u7fIKj
 ofyhXtD4GjBYaWH4xzvju7jfOkmHtFyeobAAFnaxhDjtgr5uaE+SzPTdUymZrAOpaqDuC13/X7J
 ljIbMvV6MDM7YTreQ98njpn/tFL9YT03Xvi7cRAZfzukhW2LKYuX
X-Proofpoint-ORIG-GUID: DwjayZiq11_OTdTFrmRMxxuF1DPbWQ4p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzNCBTYWx0ZWRfX5M/NkhTdNhnr
 K/QTFa1zNmIq/smu80pCfgsDIfe8Dndk9fdMfWvKqRhOFRPTwtAZ/pk/PSu2zA8SyuvIPaiyhLg
 0ahQpM79b8bZ5vbzJo6MrluemUF9SoegVpeq7e08nOV++GcC3sZXmLhc3YNFzf1ckPKMqStcXHz
 WILj6ZcRwba4mPF7xqT+wwz/cTWbkNQzvJYxX5bzUTF1Y7NF/h5BS3RZMwKVCHWYHTvmaqMP+0F
 W/FJnzRtOjD98PGpDjdt+nhbn2dDbDV5zcLsAzVpSFkv0thbnWY1sKcAJnBK6KS5pb+HSf4F3GY
 KeODY9j1x0FNv2scmUxgC8Jx1BO/R7q555dUk1zRlusQFdatzFkor8lelu7mS1fvuQQxtTWNvYx
 LGsQQqqNqWJIghBVFaY/fBxl0ZN3RsUK9pP9KtqF67igcQk4Wo/5MJN6IRUYtmPNmx/QmIIksMJ
 adt3oY/sSBvykMu2+bA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190034
X-Mailman-Approved-At: Mon, 19 Oct 2026 13:23:57 +0000
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

show_clks() prints information about the clock tree such as the rates of
various clocks. While doing this it gets the rate via clk_get_rate() and
stores it in an unsigned 32 bit integer variable. This limits the clock
rate to 4294967295 (or around 4.2GHz). If a clock rate exceeds this then
"clk dump" will print a rate which has wrapped around the unsigned 32
bit integer.

This was observed in the clock tree of an SoC ADI is currently bringing
up (the ADSP-SC846):

	=> clk dump
		...
		cgu1_vco       505032704
		cgu1_pllclk   2400000000
		cclk2_1       1600000000
		dclk1_1        960000000
		...

In the above the VCO clock should have a rate of 4.8GHz via:
VCO = SYS_CLKIN * MSEL * 2 = 25MHz * 96 * 2 = 4,800,000,000 Hz. However,
4,800,000,000 truncated to 32 bits is 505032704, which is the value
reported above.

To fix this issue change the type of "rate" to ulong to match the
return value of clk_get_rate() also change the format specifier to
%lu to accommodate the type change.

Fixes: aeeb2e6d9c67 ("clk: support clk tree dump")
Acked-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Qasim Ijaz <Qasim.Ijaz@analog.com>
---
 cmd/clk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/clk.c b/cmd/clk.c
index 2fc834e5549..3c816a41730 100644
--- a/cmd/clk.c
+++ b/cmd/clk.c
@@ -15,7 +15,7 @@ static void show_clks(struct udevice *dev, int depth, int last_flag)
 	int i, is_last;
 	struct udevice *child;
 	struct clk *clkp, *parent;
-	u32 rate;
+	ulong rate;
 
 	clkp = dev_get_clk_ptr(dev);
 	if (clkp) {
@@ -25,7 +25,7 @@ static void show_clks(struct udevice *dev, int depth, int last_flag)
 		depth++;
 		rate = clk_get_rate(clkp);
 
-		printf(" %-12u  %8d        ", rate, clkp->enable_count);
+		printf(" %-12lu  %8d        ", rate, clkp->enable_count);
 
 		for (i = depth; i >= 0; i--) {
 			is_last = (last_flag >> i) & 1;
-- 
2.43.0

