Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1968FC53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 10:50:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CA55540B8D;
	Wed, 29 Jul 2026 10:50:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dceS26xNQraC; Wed, 29 Jul 2026 10:50:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4D566408E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785322232;
	bh=IjpDX8TXuzAHSVwAcveSyJcziGv+rteKkDghYO407gk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FRGotKDOGmJt7Pfj6TAHw+Q4KwavdafHBUoHviRuQYQm8M64Ak62uZH9M2gUK/nFk
	 rkpSfn0UKwijZRlhP/qbPL2FKQCXlh0FBJhNKgN7Vbc2IK/uBCHdiL+nwC8ZKTrEw6
	 wjl/+qqaeVBq00HTbkvIO7Z5UQeRPCl09+3wsL+7+8pHjM7illqXAvdGzXSdepwmKO
	 zLf7didWlfChFg1ZjlyYdRJ5P7ec0ngk1z5g8ig92YleB7MsFVzndUQxGlQkGxY0tL
	 hi5BK30ceOHz9dEWAg+w5PWhc7ZRDSDHgzoiQuNMqwS+d+/RCfpGLDzshaky6HTe0g
	 vMaFgEBN+FwGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D566408E0;
	Wed, 29 Jul 2026 10:50:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 39E55350
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 10:50:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 375F660811
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 10:50:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hAf6Y5OUrDiC for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 10:50:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=anshuld@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D6ACE60612
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D6ACE60612
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D6ACE60612
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 10:50:29 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5197D8404D; Wed, 29 Jul 2026 12:50:28 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1008E803F6
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 12:50:25 +0200 (CEST)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66T7ef0f2162171; Wed, 29 Jul 2026 05:50:24 -0500
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010066.outbound.protection.outlook.com [52.101.46.66])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fqcwv11da-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 29 Jul 2026 05:50:23 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Acu4SlWJjW8J6N86FdNsh07e2V7rIXoHd4NahQslLBDT/483wm5wZVksqbTl1yPK6rP4CyPdbOAgpcC3pIZj83hH0lLEI3qixUpNuIHYyJg9C6e2cAH9yLMgjQYw6Pf55L3EW9JqhUGAcPZghPWafo0uCgUOJxE+SQyF5i47yldxgOR5VuIAXNgXdwti6R63mQdAXhP38uhJiXoriw2cT0C1/qHgDmDoIC0slDl0xWVKziC6pgD3m+u9ME9RR/FDBrRkcL3IoxeIjNgG24Xg110960OR3IP7lX/vDp0UfWEMsNEGS2UpVi40lMXpITVb/TqqQrSgqkT5XWZL6oO0wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IjpDX8TXuzAHSVwAcveSyJcziGv+rteKkDghYO407gk=;
 b=EobvioDidTriQv3sO8kuWf6s0svcSdMUsJklz1rZd0GWoYZ4r35BXqLnGrvF2LR6FFLB2dMeLgKCrsw2AojpVBJeLGrwxPqF7CTY06HhvQlUbbWpQiCita9ZF1nC31DoACkud1W2EqHuiKrVrBXPs1u/Nj6ofOkfQBJxeFXffKRk/gIxCiOwQI2fL+r/Tjk2aP0+A5q/w1n4uZPqy9OmdNxtwHo0EK9Z9Tfh0XW8c4fpIosZbjpJSzyd+TMqBcFVW3PfMunTRjrvRRMAUvD4OiOR5SYACzkau9NP0VWIhS3T/NMqJRl+rLObTGrttpGC1UTpP8IDzahJW4zpBSlTJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.phytec.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
Received: from MW4PR03CA0239.namprd03.prod.outlook.com (2603:10b6:303:b9::34)
 by BL3PR10MB6113.namprd10.prod.outlook.com (2603:10b6:208:3b8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 10:50:12 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:303:b9:cafe::8c) by MW4PR03CA0239.outlook.office365.com
 (2603:10b6:303:b9::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Wed,
 29 Jul 2026 10:50:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 10:50:10 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 29 Jul
 2026 05:50:09 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 29 Jul
 2026 05:50:09 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 29 Jul 2026 05:50:09 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66TAo84q489675;
 Wed, 29 Jul 2026 05:50:09 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 29 Jul 2026 16:20:08 +0530
Message-ID: <DKAZWJY7EY1T.1ICH58AHQWH8A@ti.com>
From: Anshul Dalal <anshuld@ti.com>
To: Simon Glass <sjg@chromium.org>, <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: Re: [PATCH 2/2] arm: dts: k3-am625: add template for tispl.bin
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260717-k3_binman_refactor-v1-0-4089220b4fd4@ti.com>
 <20260717-k3_binman_refactor-v1-2-4089220b4fd4@ti.com>
 <CAFLszTi2Rc52TKKoGOicXEHF25GUm09gcyuZz0Y5zTjBw1W+pQ@mail.gmail.com>
In-Reply-To: <CAFLszTi2Rc52TKKoGOicXEHF25GUm09gcyuZz0Y5zTjBw1W+pQ@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|BL3PR10MB6113:EE_
X-MS-Office365-Filtering-Correlation-Id: 42d2f1cc-444e-4618-e857-08deed5f2935
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: K1dBBDNb3F3Tazx7w+rl8FXFYezzCOODtBXXQTPR89LTEKoBcACAKRM6CGEUUFrzWIeeQ/uJizqrCXzZpfExbVZ0tkkZyOHeEvHLZ5QQdPcYGtVxec0B+msVsmH/zwcGM3e5xhlnshBOKLBhoPiJS8tWEksx4qTNdsJuUBM9upzt6ulhe8ox6jUDUXGrCPmfFO5QcyWItKOaORKbqJapfW40G0eOGxqS1P5RWU5M57odpW1yBA0a5oMTk66pqr06YOkODfbyK/KEE36+80kpWDORFIIz9Rs0kDhdgdu4S/88h9pyiCtKkPMpHgyTFubtJziVbE87PkwvO+eHqbGQF9iApwzWVLE9zu9IaA/AqP2RFDTRLRFOLdhCybEQfE9hzfAw9E5x+rwmJ2LVn5r2nP5slUGXqicnVFVr4T+sH3KHM52NPwhLa/W8mQjmKkc9Hf3ElkFfEf77h4r0qzGEnEurVfE40otAfKiZGwCQzPOlako/mSpzlJn/99sLj3RZGHElpgtcRHNwx0k+sRg7ZOnOq7bQRi7J92aH889KIVgsqpANnFHnR9hh6i325zhO2M8ybsdQ2RaFRKNLC3yKhxhiBYBxIvBiFvQrHIAmLzmZyUjlYUS0rdcI0Xls+H6oHgWTle+QBo/obkGBc82GiTec7a/h5MA5ICLanjgX1OsLVio34zvsr1HVB86Uzo0X34NBKRmRunHUTN7WF0zEmA==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jB7VU7bk9dFVyO6hB7+TVZlNSL1VM186999k8kQf9Xn5Dl+xi8CjNw32klfewfRcqFvjULJKA54P7ujJk0kod5auxzzRCHgLY3vm1B1Fqphg/nsND4UjZB1LNTvx8eKqJ8GXGbk8+hZ01RyJTHEw8hYfmKWHdmDVaSzZLWPrs69DYJGB9JcIY0y4Q9G0NQUCPA3T8+JQLHIm2MIamTKqqQ6eM+MxMFTgXUsheS4whpPTiAXRI1LL2H+BJ0XQdvQ7sCGjbS6cJd1xM6Bw4bGkktZfJ1MvYXGKmnyXxs66NEsGV1BhuSWy9tSOnCz8EqhddzP6WkwZ1V5DVWuEk+xzPbul2NdpRSqHu8cfZDjVU/HGCoi5cqnGmTQSkJGjtWs+wtrU7yKjvFtmE3IOnMlk65Q8fJGhG0UBRFOH+vPSnYvRYNZxAGa+2lzEBQJzvM/P
X-Exchange-RoutingPolicyChecked: aJejoap9VNAKkGudoTREbvGKIjRTsBrtiCQumJ2/E4r9h5RELU1zTBBlPjFziWotiTZNdYEGRf9MyBJSqR7O1tfZRbYshIN/swBlueQmejz0mOfWY+EBGzY3YQBYR01hQp5wgGWaodKm/t2g6EmlGvdquF3KMZgK5StVXnOaTuKmuoQaYxNVhW6TKKfMVwQJjHwZlzNrVA0Crm0a5jVbWYr7YSDrsYWsZrx4+cwPaWaq+iMZewnxVZRNSSAkW8cP/4CvKV+4ThCcB1zUvsUVRQeHGeAJZSaoQCQYqJCi6+LNS3qvlUm7fn1YVDQK1VOMbNafIxjOzD10XEkWFxuhQA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 10:50:10.0987 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d2f1cc-444e-4618-e857-08deed5f2935
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6113
X-Proofpoint-ORIG-GUID: VBGVGwfGJnr59tjpadmFQUmezxrf9-7e
X-Proofpoint-GUID: VBGVGwfGJnr59tjpadmFQUmezxrf9-7e
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA4OSBTYWx0ZWRfX7EoNhE6YCcdY
 BM8gbG/Qj5DsRoAcIo8w6cDzoePwu5NE5vAi3VaqxJK6gPvjp/Q8uWK+r6is3h5mjN6YBL2Wvxw
 qp9R1Grwk46KBh8RemRI4Uqewg02AEs=
X-Authority-Analysis: v=2.4 cv=PsijqQM3 c=1 sm=1 tr=0 ts=6a69daef cx=c_pps
 a=IF27h1RdCV0SK+IF5nJR9Q==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=pV0imM45fALDwbRzxrEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA4OSBTYWx0ZWRfX++S96f49vHQ+
 ah+yRcPnvy6AamAyDD5u+whpvvZ+rLuBPKe4F7GyYqGDxrCeXOPAOVgahT++jQuNgmEVnzZ496n
 KCjVjWoKHE16nw9QmQL3b00vA48bsa1psMvW0VSS+1Am0JTVc1D4DZ9/AwalwfAFoL7yKbFSGrc
 cYkNc4Ytb0a9IyuQJVxi64t65qUhLZfagxT6dpSreb630So8YD/lWN9Oz4pRGQ56HPiJfA7FMQM
 rgr0kGpI7qJ55X/PVKjE0tGpZ2+FsVt+iwAesC8ZxfamaMT7QcDMnePLaDFdA4Ee35nA4wC2bl/
 8S3nAfKHfn0SZTMx9+ZcH/jqQrMH9SpSXBGQE5c3hC3RXTQOeH1erXEeBN9Ffg2cge1+yXA7QCN
 ettSKcYPHNKKRi5K5BCcgOfKA+jg7ELRxst9wJIe8eYhUIOc1/6YgjKTd5tdNQHZCWARaVp4YgI
 8NScxCDQIyNgyl4t5wA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290089
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=IjpDX8TXuzAHSVwAcveSyJcziGv+rteKkDghYO407
 gk=; b=H2GAQgI66QZWuZQ1uQTifnchSBsMY3zMlBf8op3MVY1QAvrZrZMdloZYC
 8Pj5TTugDvFuKiU/Jq7WpQmbfvps18yWaPeCLs5noL2h9xZGs125kOx8ydIxSnLu
 zUIkuFsKeKnY6FmhFEp5n44jg2Vpy4KWe8B4+eapnP8NwfmyH0MBXiNLbP70Q6x5
 lXhNmrQ27tDp4IgVUJqCsZRXRAt4qb9m9KsSgFP8T9JWO6uBj0P42FkEQZGWKR4j
 zH+pHMnYwe9CMVKaUIwfPu216hg5LNFptgsQipGBOMF/M9U5ozwW1V31oV1r7waa
 hkt6xxF02wmS6WLlBGvz0LRQqGLoA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IjpDX8TXuzAHSVwAcveSyJcziGv+rteKkDghYO407gk=;
 b=oIiXCyIwXkCHBRrdVWE65cCGN4EZMfUIe8UxDiztmx9mnE1Y3tqZDdSewUBe73Z+jwzn6GjlI0MbSTyBGqw3Iq4PFpCncWQs8rbEYTj/feAaJvKkoj5ofNjK+0Eza1lqhDILFYMCAmnmpbhqsg5RxlpJ1UGWAQZBI2MROjEpACc=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=H2GAQgI6; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=oIiXCyIw
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=anshuld@ti.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=ti.com header.i=@ti.com header.b="H2GAQgI6"; 
 dkim=pass (1024-bit key;
 unprotected) header.d=ti.com header.i=@ti.com header.b="oIiXCyIw"; 
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Tue Jul 28, 2026 at 4:46 PM IST, Simon Glass wrote:
> On 2026-07-17T10:42:51, Anshul Dalal <anshuld@ti.com> wrote:
>> arm: dts: k3-am625: add template for tispl.bin

[snip]

>> diff --git a/arch/arm/dts/k3-am625-sk-binman.dtsi b/arch/arm/dts/k3-am62=
5-sk-binman.dtsi
>> @@ -392,16 +155,15 @@
>>               };
>>       };
>>  };
>> -
>>  &binman {
>>       u-boot_unsigned {
>
> Please keep the blank line before &binman - the file is easier to scan
> with the separators intact.
>

This is just a qwirk of how diff shows the delta, in the final file
there is indeed a blank line before &binman.

Anshul
