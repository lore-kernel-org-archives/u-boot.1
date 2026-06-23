Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC12ECDB47C
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 22:08:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 619E384A04;
	Wed, 24 Jun 2026 00:08:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="agQTQBB7";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="NoGxFD2c";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="lPj8ZpIZ";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="Z6uZhm89";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B0C284A06; Wed, 24 Jun 2026 00:08:57 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8719C80398
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 00:08:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0482515.ppops.net [127.0.0.1])
 by m0482515.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65NKrk5a3157425
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 15:08:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppford; bh=Ao7hzBA5AeyQR9T8Ncc/gCIxxMN
 DCdGAGaYJOxWtEzo=; b=agQTQBB7uZ15EkjHT+jlpOzLJu95Dgr419T83I4Plv9
 dHKmc4zSMEmS+0jFuxLTJLNd7l7Qvis7TtnXBORpWNuNu2tFPqle4dpEAPtODxtw
 bt1nrlT/NXS9GEhxDAxLStgCkDVaOK3Q3N58uDt6vp7uKyj0ooofLUbzhIcxkCdx
 4NkUpeMgvged+ObtN6DoVTAraRvPdNjT5cc4Qs6pwQahY3Eco0sCrrT70rekRr+i
 ywiqiSNaHYjsu3hrgTpMUGbZaU9yjUeQ0YkKJ8a/+1QTHRuS+Hdo4IgppajZvvKl
 7mMQWwcRVFqemSiWcg/8Z+iS5mQ9ofNqsq/8JCx+Jyw==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013047.outbound.protection.outlook.com
 [40.93.201.47])
 by m0482515.ppops.net (PPS) with ESMTPS id 4f01k50hq7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 15:08:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIPmsLEGJEQpBN4anjIeUtKvn4AlDKxaL2tDDSuFIxhf80lgXJ2aAFgYafe0GsLA+nrAIfwncPzWZmGRm1JzMQ1Lnv/QIH91OEmf7PllQh/e+S6PUYHNxL/JMatF3xlVdWhSs4D/mdIPGUmdi7bENOfqpqfYW96qBhD2jh6M57Tgx0mlZ4xuHTe218kaanDE3/pUUIrOr22frTgf8A1Pd96JOmcVW5HuhHE7rfAofBv0yzzRkE/dna2RXPP9N9xWVJWgUNG9jJIqXu2hNU+/QAI8o0wbx0bH8Tje8z3h1DxLUjQxSuGsq0UuDKrkIz9D/Hc7PkGsebNgiShq4wtNBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ao7hzBA5AeyQR9T8Ncc/gCIxxMNDCdGAGaYJOxWtEzo=;
 b=cI/U3n5UaIoTpUtiWYgPkcaWZ6CBwtYINWFl7P9Et0dFiDFMq0hzjX57jox0xD8vWKPyJfFZBESuDN2rZXRGahHnNc5uTkFfqzK+owyfkb4sxq9ujdCyIu7CdBKJsVXRnF99kwA3KTyt+0lFsW5kKB63AJ15al+kiKvHLOylM0WLCtXUYXUORrLqqQb0Y7X78ugcGh0Ughng35MCiG6QCux+57x7g5FpfxVY/uM+pt7QvBb/5b9RtAERmX+y1IaacjcSkiSXGKoPme8DZWTRrDTcZdgitSffQd02A3+lfvQVJm/+uqeU266Wu0krCWgbL4PZaAuUhTz4eCzBrKNIKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ao7hzBA5AeyQR9T8Ncc/gCIxxMNDCdGAGaYJOxWtEzo=;
 b=NoGxFD2cbm79zH5wHkJy3NKtqej4D9eE+3Lu9er7mtUiKfY5irAwzDuopR1SzDV4XEBV8fCYfbOMwUUBt3djRw/twoZxc9kBD2QBbcmLs5tb/NpkJgD4Gk08BJNxwC4XaNzRjKH/r3CRSorddUIBiRpp+qGU/ztMkRM6CwQlLJw=
Received: from SA9PR13CA0020.namprd13.prod.outlook.com (2603:10b6:806:21::25)
 by BY1PR16MB6526.namprd16.prod.outlook.com (2603:10b6:a03:4a7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Tue, 23 Jun
 2026 22:08:49 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:21:cafe::95) by SA9PR13CA0020.outlook.office365.com
 (2603:10b6:806:21::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Tue,
 23 Jun 2026 22:08:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.10
 via Frontend Transport; Tue, 23 Jun 2026 22:08:48 +0000
Received: from pps.filterd (m0426317.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NK1gOk1843935
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 18:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppserprodsaar;
 bh=Ao7hzBA5AeyQR9T8Ncc/gCIxxMNDCdGAGaYJOxWtEzo=; b=lPj8ZpIZBFYU
 NC+U6Hqq6UYXQqDCYxWYcI/olEKGg3pnKp5DnmtdfOuDCSfecfI95KQb2mKZmi7P
 n2peHNFZc/6R/nx77AoOd82p6bsvfg1jehDmqzAjOS7vTy1buw5vY5bVnClzYztb
 fXYvDPmUkdvgGKxVNY2Q/kdHFM/OvdbfXdaxVgpgr87CibmjkXLvJVJxtf0yV3wm
 z4FIhe1maAZczbtfXx+pruGjpGCHHQtfZNBugJMleZ6JgHbPNvCEthCpUik7sQmY
 pXDr1xcFH0HgoqimLYDSAOi+ZbTnbN1YESEF8qQiD8dID0kFVrLiXEcgmLMb68fV
 dHrulq9lAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppfserpocford; bh=Ao7hzBA5AeyQR9T8Ncc/
 gCIxxMNDCdGAGaYJOxWtEzo=; b=Z6uZhm89sfjrf3BEUWdqBPl4YX9tDmYxvDm7
 s+takJBUtOsk1YbohvbvR2lVU+O24PPzo7oU8W1YL/aGdA37TijNNfQVGDybz6En
 OYqbcrELgbtIusdt+DQn8GYdKjZgm9EQFF0osd+GWN5h/lbrT/wi2B3hEyvL8EFG
 SjM6zbq38HH3Ac9BPvsTXUqNWuSf0ga/b/cYxheJNA6YOi9MwpuTD9X3KJ4mDSKS
 7iro5PV5VFm93ZGloX+FApkqNyvGACmtdsP0wGU/c4Qu1BaRZhAk1p2ReLH0wSSa
 6EspbgSP6ZrS/QLFi0h/lT71tpFZQ71OxAewuUf/K39+DSlLEQ==
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [34.209.42.160])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4ex9xp3p9s-2
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 18:08:47 -0400 (EDT)
Received: from localhost ([19.12.92.222]) by cmsmtp with ESMTPSA
 id c9ITw9iSeFhvFc9IUwAKTe; Tue, 23 Jun 2026 22:08:47 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: c9ITw9iSeFhvFc9IUwAKTe
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
Date: Tue, 23 Jun 2026 15:08:45 -0700
To: Simon Glass <sjg@chromium.org>
Cc: dmukhin@ford.com, u-boot@lists.denx.de, trini@konsulko.com
Subject: Re: [PATCH v4 2/2] test: bootdev: scan with a broken high-priority
 device
Message-ID: <ajsD7Uy2Qxb9Fe9U@kraken>
References: <20260623014930.2741494-1-dmukhin@ford.com>
 <20260623014930.2741494-3-dmukhin@ford.com>
 <CAFLszThk7mWg+7LrVcN9xY5owrpUwhCTLdf=XHi0K-M-uPKzXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszThk7mWg+7LrVcN9xY5owrpUwhCTLdf=XHi0K-M-uPKzXg@mail.gmail.com>
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_04,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230182
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|BY1PR16MB6526:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cecc84f-3e5e-4c95-3fe8-08ded1740097
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: OWCq9BdZzETiE+1+nY/TwGCMgbvOQV1RGmgX1XrWGlUPoxNUJ0sNwLDpzFdrNvVsL+nb9/HckFl2MyFs/ic6datdT5/QT6etrXsIjcYmkm3T30cvM22231h69X7JQCQxKwtA1wMhu0/fNSK1Tnv9elknab03pJ+cqVa9ngBOUPO/GpJk2rM+5w97eeS5fqFYyUJbnnzi+ltcmktmo41vAldev39fFC2YznWmdGO26xoQyIfvimo65llEZA6XnPb+skqgqtONwn0KhAbYCLgmMi10H6W7Lyk+S4r+mz36B8rCxRtNIMnW8005pe23z36wDtd95wk2ovOGWphv/T2+9VZ/LXKEPmudLHeDTzUBvU+lDRK2yoqWGTl0ag0WHdQRxdJ2UZoiPaJhTWV+MbOD5+XWXYMOtk6oNCxdjDyNRGKr9hr+feWrAUNvA1uBXKFEHFr6RZ4tDn1RH/w17bFFUUUfwTl952ChEv8ANhLVCwV/EDrCIf68Q9cTH+woW3WzS+HnHxjukjTkHZHhv+jfQFvlX4CZUHTOCijlgzx23aRz/Gn7LHzSEjgmJP+QMKSqQPPzleYE2Uv8GuH2n10pjakLJnwy7WYbDXghZVy8Kt6y56gVTJcmhZxyHofVIK2aQeQHY+pE4FVXei47CtJQb7C5VtAHrbNjsrYl6f+TVZ7fWkvYdQtcEFlKS8131czmLldc9yW4TkRKjImyFUDNLQ==
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gBxoccUOUMVudtH9BW/Dzrf5+EVFoTmlyi3TM7fdHBReG6ONTcZ0PCxQXDTOqiRlGXbfqL2qdv2eFjuXgkQbOb/xdLsplPGzRSN8pWU4Izep97PPiE3qKVQVGV3P+jL0BXK96rJGDUimHmoimJ/aOMEo938eM+zfgxoEgFR8XjKRqK47JVv8uhlVns94NMEpOhD5wq/qgq5zKZgmpCWMMpo1k55U0QQjIyEn3fdnTm7WEjPQSCyjDJ62JL1bx3DP+Fp31RCAh+UXGitHrHDFdvoaD393Naq6YdIyLemT6tYAM5fQ8ZGxKIflRJfqzqIEGWwXB5DBGFAVGYOGlrZs92UfJrJccDar/VinNR0xHMCT3KlinKKr9tG2A2PcezHMCEqrG4CxZRQtGIAZOZyIW4BSDiEe6QbwNMKqTrQQXJHYW0RQdXLTUWPUpVoDoZZS
X-Exchange-RoutingPolicyChecked: OIvk2KhwLg5dzdz8p0GQHxLxErguEuvmRsdQUPHuyDOw2mHe5y9MHrpNq7TLzZUHsZbR6AvPjpeLSHTyfj4Vqbq71SfeRwIIApp1nlCfaPUR0EXLSXlW2561CJMt17NvhN3Q6cWNSLpo4CXBOV7SFgk/m9UAN2JmOyvLmUIu3iDkcvfo5zKoFxrB9+MabkyUBgFFN2jBz7ku1j+fN5ZpzBJn8p4x6VpXJjtosJpq3pG8MN3jtHdnwP1YeU/iY9NIDa/tCxn7QMu/tJASFV4t/eMtuL16ITAXbhcDGHPcQGjewMlZ8ybdnQHcQPozK2IRLF3TL5Cq3zHB1Z+S271Hgw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Tg8N+mglWiwzUgXRqCQdoru0mvy6nPhgaGSz6lCTDDnc0tBtaSkHl2AwtEa5LNYawjZiJQYAly1m/s+8ZTZNvdKwRbYYyjfcmdrZa8r9tlEUxdZlFH3tSq0sPqxAXPtsgOKKxEFOrJ7z5iWkdztWZe9XxsBB6V7rn15vx2MmyoHb1xqiYxjiBGRLnhtUz+j0U+k1TqcG9FrwS7YZHBSds+w8KBAQDvtXmRA6P4L6nuTJ/Sd78bN7HevoML9miaq58QB1zgxM003nPyLf9GcUMk8yiPonBTlCGivtYmqVXjQlofHAPlpoxdEAEMJSaf+WopTX2WBZtk7ACftQx/MfGdZt5X/JL5HrVhnkHYIsjtzbBC4N5IXj2Xw2yOAWdwyS0xmrgx7Fs+2fVyOB2zVMfkPpT8qL4WQQYtT1EAG9j8eRVIn8XKTHOipzXbo5RUITR4KSKwIr4px5YpciRAriHp6G8GjHP0tS1JB1ivShW6AN2B4w6/D6tEmUvhUWExh5lxnN0zvu51MmBIw64Bb3Rs0cZAnKj/h2xHZRvH4E4jhPAxEt7jP6U8eRd5g5Iphc8++TSaZ8ml53pnACG0byuMkChDgwGXN6fiPgCnvHmcrg8h6LqAVv466dFkYTcn3Ey1iOqR0xZejwF4RDrfJmVw==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 22:08:48.7327 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cecc84f-3e5e-4c95-3fe8-08ded1740097
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR16MB6526
X-Proofpoint-ORIG-GUID: HSbQ5bGKhPp6LVQCTcOXUlMOlXnK9OPB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE4MiBTYWx0ZWRfX71t98F6eiM0B
 Q2CAt7ikkSQThKqmP9yKIaRVPQxhxuFwsYfRRsCUJ5C+WQB/xq9q+o695gL2BdN94wxz+zDo+EU
 5meQP5smtmO0INHAOpH61j/7gUNRxu7+lXiBNNQ2l3vFN8uBN0wn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE4MiBTYWx0ZWRfX/6dM0EPNjAxZ
 U5PLiWN8Fs46SLZ3rb88Hmt9rEfKamHVb/dmCOpa3SnYKfrRL1WLu2nPsGMJkOOQNL1VmD728dI
 oTVsBo4fh/GV3RetLg9skU3+BN9rr4kXGBI8ZBzpn4XQBsDPEmUmcDkVmL2bgiTegxm57TuGoKe
 dgkgaSGBpPh8IyCEqIyg3sEX7mTDMNAinWzyFJOcY3vZ0XGLxnNBhS8dV5FEyGt1PbX/aPDlNjm
 mKLZzUtmN+XVXTqqMlFBEnNS30Kp32Ft8AxLvVJwnGZO/cR6VsB74wisfaeokthQRvVzhX4qxy3
 1GKUtdjoxjNIjrefVZXTO7iSX+qtPRYdy/MeLnrjakW5nr1HhX1yIcDFIAY5jxVazjZQ4X9R35l
 zlXK8t3DVMY/2A5l/+H2OQtc0i4SzefMOKmN5y7oNW2ZW2+bpMOiCAOUjxx84GmzbY4riRWDoAV
 6K8oH5g86WcCXzcYZnA==
X-Authority-Analysis: v=2.4 cv=MJxQXsZl c=1 sm=1 tr=0 ts=6a3b03f4 cx=c_pps
 a=rV7DuXtNeKhYS0+Ag8nf3Q==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10
 a=3PXLN80vpJUA:10 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=P_n1zlmtWsCQbjROFjcg:22 a=0GA0A_IKJoUHBEAzNTkD:22
 a=VwQbUJbxAAAA:8 a=cbNQJ9GKAAAA:8 a=cm27Pg_UAAAA:8 a=bHvz4AWXz6CADE602i0A:9
 a=CjuIK1q_8ugA:10 a=P0bj-C3X3jJDpopQwM1U:22
X-Proofpoint-GUID: HSbQ5bGKhPp6LVQCTcOXUlMOlXnK9OPB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_04,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230182
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

On Tue, Jun 23, 2026 at 03:49:36PM +0100, Simon Glass wrote:
> Hi Denis,
> 
> On 2026-06-23T01:49:28, None <dmukhin@ford.com> wrote:
> > test: bootdev: scan with a broken high-priority device
> >
> > Add bootdev_hunt_fallthrough() test to verify that 'bootflow scan -l'
> > falls back to a lower-priority bootdev when a higher-priority hunter
> > fails.
> >
> > Introduce a simple 'sandbox-bootdev' device for the test. The new
> > bootdev can be configured to produce an error at the hunting stage.
> >
> > Introduce new host_set_flags_by_label() API and a flags field to
> > 'host_sb_plat' to simulate a bootdev hunter failure for the test.
> >
> > Adjust boot{dev,flow} tests which depend on bootdev hunters.
> >
> > Signed-off-by: Denis Mukhin <dmukhin@ford.com>
> >
> > drivers/block/Makefile          |  2 +-
> >  drivers/block/host-uclass.c     | 15 +++++++++
> >  drivers/block/sandbox-bootdev.c | 73 +++++++++++++++++++++++++++++++++++++++++
> >  include/sandbox_host.h          | 18 ++++++++++
> >  test/boot/bootdev.c             | 23 ++++++-------
> >  test/boot/bootflow.c            | 46 ++++++++++++++++++++++++++
> >  test/boot/bootstd_common.h      |  5 ++-
> >  7 files changed, 169 insertions(+), 13 deletions(-)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>

Thanks a lot for review!

I've made adjustements and sent out v5:
  https://lore.kernel.org/u-boot/20260623220630.2828767-1-dmukhin@ford.com/

> 
> code-style nits below
> 
> > diff --git a/drivers/block/sandbox-bootdev.c b/drivers/block/sandbox-bootdev.c
> > @@ -0,0 +1,73 @@
> > +/**
> > + * sandbox_bootdev_hunt() - Hunt host bootdev.
> > + *
> > + * Note, this hunter exists for bootdev testing to simulate a fail
> > + * mode.  Do not use as an example of a real hunter.
> > + *
> > + * @info: Hunder details.
> > + * @show: Enable extra printouts.
> > + *
> > + * Returns: 0 if OK, -ve on error (expected by the test)
> > + */
> 
> Typo: Hunder -> Hunter. Also 'a fail mode' reads better as 'a failure mode'.
> 
> > diff --git a/drivers/block/sandbox-bootdev.c b/drivers/block/sandbox-bootdev.c
> > @@ -0,0 +1,73 @@
> > +             if (plat->flags & HOST_FLAG_BROKEN) {
> > +                     ret = -ETIME;
> > +                     log_debug("cannot hunt sandbox device '%s': %d\n",
> > +                                     plat->label, ret);
> > +                     return ret;
> > +             }
> 
> Please align the continuation with the character after the open
> parenthesis (tab + spaces) (patman will check this for you)
> 
> > diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> > @@ -1532,3 +1534,47 @@ static int bootstd_images(struct unit_test_state *uts)
> > +     ut_assert(!(std->hunters_used & BIT(HOST_HUNTER)));
> > +
> > +     /* USB was hunted despite the sandbox hunter failure */
> > +     ut_assert(std->hunters_used & BIT(USB_HUNTER));
> > +     ut_assert_skip_to_line("Bus usb@1: 5 USB Device(s) found");
> 
> It might be worth asserting that 'Hunting with: host' appears before
> the USB one, so we know the host hunter was attempted?
> 
> Regards,
> Simon
