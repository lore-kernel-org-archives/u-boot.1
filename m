Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A65FDC54FCD
	for <u-boot@archiver.kernel.org>; Sat,  1 Aug 2026 04:04:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7C0F26069E;
	Sat,  1 Aug 2026 04:04:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vAYUzZ5O5dhM; Sat,  1 Aug 2026 04:04:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8F32F60678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785557065;
	bh=IRFKAk1pTC5XvL0eI7L759AfOeyzYxfv5ZLYWzadomI=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=gbH2GrWzAgfhQ8qo7XUOWbyWMFIOgsr2sKLVo/GMtyScAPwfCrl2ISqOQ9VEnbTt8
	 5Y5TZ7LFhgBx0mpxDZ5ihWrIf6R1JDZFx0mpjHCeouoPN79FD8is6RlByou7JUCSV+
	 1OQiP1s2w6QF6TQchrTtCLo6Cccp2krRm+3EZ/TAS3z9e9bwmJ/zsWasaIjZER0nbn
	 BSCWTc9u+JuNp+ZxBrIJB4xxOPFY+X/divZCtdHfABpK96/Gchw+XEIx5NSQF9Kvoo
	 w9HPfAQGnhhNxrJ93evRJL2ODnQRbSrkbguR0UL1H9HVaz87p4JSNqvd5ByvjRfZXV
	 HIOV5fhVCFPLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F32F60678;
	Sat,  1 Aug 2026 04:04:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6968F1344
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 04:04:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 52ECB4005F
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 04:04:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PeD5LEDXnhGK for <u-boot@lists.u-boot-project.org>;
 Sat,  1 Aug 2026 04:04:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.146.23;
 helo=mx0a-00498f03.pphosted.com; envelope-from=dmukhin@ford.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9D0644004E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9D0644004E
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9D0644004E
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 04:04:15 +0000 (UTC)
Received: from pps.filterd (m0367126.ppops.net [127.0.0.1])
 by mx0a-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66VLw7Bd1973266
 for <u-boot@lists.u-boot-project.org>; Sat, 1 Aug 2026 04:04:13 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11012019.outbound.protection.outlook.com [40.107.209.19])
 by mx0a-00498f03.pphosted.com (PPS) with ESMTPS id 4fs068uqt5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sat, 01 Aug 2026 04:04:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DieGorAdf2p5NqBemDB9AU7p+0vCQ76d8Wxkqolf01kBEQRQv4OVdi5snXeVLvSM5ms6K67GyGk2AfXpEOraPh6H/RiQzOF8lpSNORjMxzDCcumU8NTtWNpFMyCvKKsy29//HXj44hofMeX9a4MUaOWJyPD9DbiONxD25Ky94WTs+ms/ATNfXfpXbbd/CkJ3c+HgqW57zdn55eMLMCgPNCTo4gnM3NvlHWQDLgryD1ca5P2Nn12E1liqHON3vwVWWeG2yuuwI5vuGJVbL9QhM+lahhdkBv248tzx7UXAFbIbek0yCV3SxmAoo3bdQyRVflrO6gNosWsuoGKcwIpeqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRFKAk1pTC5XvL0eI7L759AfOeyzYxfv5ZLYWzadomI=;
 b=aPaGHKmRAfYePamIsn3Kt//8N3vPQvMpjxQ6JyzZ5aLKfW8eWSXFLCq/9cJEBjSPhQGxCrR7o0308jQ8+AVpiFZeG07bGbdIfoMfBw/aHv3m2CFo926PRMGkBdlwGU0G91QSUG1G5jaG67RQ88cw4CWt2WHEKxeldpHMymBtOY/PeOpRIQnZQ+SIMvicuF5elf2ci3l5ybkNdozvO3jh+h/tQHwMCPd1RFN/hZ4pq3kRL3unDZSkIpBeIbD8yP+PDZ5aIr+guN01IKyLpNoh+8m1Feam0orALKCzUydxMkp3npeq8YArUAa/ri03XSmiAF9swriUmcq0eXDq12yvMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ford.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com; dkim=pass (signature was verified)
 header.d=ford.com; arc=none (0)
Received: from MW4PR03CA0347.namprd03.prod.outlook.com (2603:10b6:303:dc::22)
 by PH7PR16MB5214.namprd16.prod.outlook.com (2603:10b6:510:2a6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Sat, 1 Aug
 2026 04:04:09 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:303:dc:cafe::a9) by MW4PR03CA0347.outlook.office365.com
 (2603:10b6:303:dc::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.16 via Frontend Transport; Sat, 1
 Aug 2026 04:04:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.8
 via Frontend Transport; Sat, 1 Aug 2026 04:04:08 +0000
Received: from pps.filterd (m0426315.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6713OgTn3309318
 for <u-boot@lists.u-boot-project.org>; Sat, 1 Aug 2026 00:04:07 -0400
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [3.215.31.156])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4fs8vc813a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sat, 01 Aug 2026 00:04:07 -0400 (EDT)
Received: from localhost ([19.12.76.221]) by cmsmtp with ESMTPSA
 id q0xBwrLK0ERZKq0xBw6hZf; Sat, 01 Aug 2026 04:04:06 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: q0xBwrLK0ERZKq0xBw6hZf
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
Date: Fri, 31 Jul 2026 21:04:04 -0700
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: dmukhin@ford.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v1] part: efi: use BOOT_PART_TYPE symbol
Message-ID: <am1wNHNt7OXMPrqE@kraken>
References: <20260730013946.1858341-2-dmukhin@ford.com>
 <215fcf2f-90c5-4a14-b38a-33d2882b0e72@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <215fcf2f-90c5-4a14-b38a-33d2882b0e72@canonical.com>
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608010023
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|PH7PR16MB5214:EE_
X-MS-Office365-Filtering-Correlation-Id: 768fbdd7-e877-41a0-d27e-08deef81efb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|22082099003|4143699003|11063799006|56012099006|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: dH9s+oDWm06xBEfzmyCT181CaMMXJDSZiLZr1E8dNm0UgsWrfZvKLdn1qa3eWAyfa3OsD0SQQ9FKRZ3Ayd/yq/ZeRc+4zfIMjrvdCOPo/wcwwg5LTDewYTKoK4eeECHV/cijcG3r1o02SgFxTr83l40LTJZZpztU3bYO98RFa4UhK87HKNkb87gY9JIBUMFcSiaNvIs/9pFHv1X5yLkYX97cZM6GBC4XX1/Pr9oeD77HFrqVn0rONQDwQwrqe+nzoxZ/YmLCpuoQ7+MgCJEjOMGZsWOD6e9CsawP4WZpFeYgUDmJfE8vQJg2Ey+6tVJiGsPZ1qF2qCsblBj/jr6gQAeuavIJTV+qP00C7rdOIeBMvnAViEScOW1BiM9C2VVaiTvwzYg4kF+gw6yggyt8IzbmffwsMm4rFbJc7coNoVgv+fUx7k6/71oObbrUDarbtv5gtYaaVHf80GtTY3UoHR0Dot/618B3uHDssWUvvi1y0usGO2m8p4Dho0KQFYVdG6i7GH3qp0eSfjHXSiM7SLISGEYPW5xkqXP5GL6dWCPQ6DdGL+xlassXfSLKWPOoAymlST5uT7GrR0poKOJBRnU2cagHvxPZAAar/6iDEe+B+uj6v3xoJprK3oDnhWX1Z8s4SIKuATVyABdjxpT5adUreEHZNHlXkxXTdFo3NUxHgCPr1BsiX3p27U8cmDH2XTomrXNxtk2q+FPW9217aQ==
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(22082099003)(4143699003)(11063799006)(56012099006)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Z1/AwdCvPS6aOGLZEE0HffWu3+Qz5hCetH1s6QRIpoXaNQ3bQY0JaeQF9xx0AnfK4TLxWmLTYKHKo2GvKQ+8rcxWCDxUdvd4qoSjZAc+etGh0xKAhXNcyhVC9OKFR2Ld15XZJ+hEjJqPxS+DvA7VU6xJd6JXC/G3V4hP8sEncNDdD61wGRm/hnSKO6QBlPHJTQ5vs5DflPEifFMH0j4GWGYpKWF7dsrvMT8/fRtr9cnVifObA3puKTrdkyksaIjGq/SlxAQ8+qVWUmwyCRjL/3Wsi2FzwoDgtkc/6cK8XMq7f4IqQMdd0nHG8tmPJa1rvoy0wwYUp1tBhUgeqepPCQsaToUHec4RJT7zGm2IGZ1eC6byrE+WYSra9OecjW2ve3du2ypTYBFqUkX7QbDaObL/j5ikLX+/g8AWkymsn7mtqtaFWJBCSiKHwGXAgNnT
X-Exchange-RoutingPolicyChecked: LdTsnqOk3v2h6DG9sAoPnw/VMemvQ+A8pUk/851lLTa3iNmVgMuH1yC01KY58VscK4Sqe2Sdl0Q6qixiSEXjejZc4sEbBhjp6EFm0UgpzjWYYHlffmLLV4bmQ3lL3pPGpR6wxviib+2AK5XR6TZaboXXRZwOYqYB5CAHhktKWrmiq8ffUCeWUKKi8HAI34EnQZB+1Ogb/qWj5t2RcSSduu/ohGuXrP2B+C24aw30tnJKpRhLvr+rIswPuwjpIq0uDBbWK2JKkh4fnWSnwBEuvh5iixRe/rENckgMHfcUsyDq/LKzYJTuW8kCXUFPXB7QtkyU9l3TBmGl9v57DPl1tg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KL+D143o07fykpH30wBXRu1xUw1VAkT0sWkUG6MskSSloCOBs1UERwGl2QlcLnwM3RIoRYSsneToOAEcX0rD6JNV5GN1aH4VK0LCC3ylU864cZlByr/zzhplBQ/EEsbvdYHKhKOr9EMJxxtmZnvYogly7f0uJ6gkCFETq+Ge5uVVtqbMZl9tfu8E4/eFxqBksM0BtVjhO9ESXmLrr8iqbAN5+M3U2h/iiJv6rq4x4mWBO5aX9yqX6v6qJKYcVQ2bz+ZhOADxzX5e51JC2uyvUFic2r8ETAIs5WEOpYvTLgGnmfBaldhN2rWZnqyby1sxIWA/Z9wTDgYRb9ABlOr8i9KZ9/+L0MAqhk7mMKts1Z9HmABjtFtD4LBbd/C7WHKFcpiQOr54wWfs0Xf64qmXtxjQ1LSfmVe9nVJRxKGg+8AMjm/qxXqDEwSa4TNplVIj7pP1kOHlIzvkZkzL1FlylH5fTmSvvEE4uLvuJtExfRD6P9GZ20+QGLUSbZKs6ldR/JuFRWImORlPzat8LtkK+IOFX6UFdueBrZ3ikY/OySW33z2IAmNRA35nz1iwJfH43IUaXCaDH/m1Kr6cmPOSUI1b1H3UIqb7mbJAbGKy4WPy3VANn2iGLK6Os/A0o0nT
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2026 04:04:08.1760 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 768fbdd7-e877-41a0-d27e-08deef81efb1
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR16MB5214
X-Proofpoint-GUID: mlxlrOyfndqTyEUsK6XaaG5OsAS0n6EJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDAyMyBTYWx0ZWRfX9rfld63SnkyR
 x7oXH8kfYJ1waZ7imHfjZOa2ea4/Q6s7QTIVcAE8rRBS4TTxIgussJ6aMlM5GlK+D/pH0ehyGn2
 UzP8JJh+xBsP6fryHF9/K+/spnrai7lJuyPzjas0ADr/MNjkWOBR
X-Proofpoint-ORIG-GUID: mlxlrOyfndqTyEUsK6XaaG5OsAS0n6EJ
X-Authority-Analysis: v=2.4 cv=Vq0Txe2n c=1 sm=1 tr=0 ts=6a6d703c cx=c_pps
 a=fNyNANDL+C7JeK/y+7sGAg==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10
 a=3PXLN80vpJUA:10 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=P_n1zlmtWsCQbjROFjcg:22 a=-OawqTZBqJjt90xPb8wn:22
 a=cbNQJ9GKAAAA:8 a=FWgsAu_whCAhwSU3ApoA:9 a=CjuIK1q_8ugA:10
 a=G69WFyCBNqGPyalROSdv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDAyMyBTYWx0ZWRfX/bQU7OlUDxud
 EBkRnhpbdPkkOZcfKufMHwWaA/Yy93iIlEVVOWmU4ts3pQ3M6Y1iZQZS2IEY4jj6wEvjEbEfbT1
 kbyTw7TMB75KDS9jQvOqelzuU4XdfaRjiflAQlsn8x+xcFpRALZxOgrIQE+MGDL03mSRwampZu0
 L5/7TpPYgK9JdfY55JXRkhTtS8hzZtYot5Y1Z7fT3tm+53jCaqBWKyPnUyRq/lePnrWqa3oI8to
 TckWU7hT8AeD95u1uxwroAqSb2nVBXYYR8OYb6eKhcviJxRWCUcJmgdtJknmUYT+WdZOqW5XK+0
 xua4hrnRLLDw1feY1ZZEPISKpKYjylzpp6c0GdBCH7s+oNarSj1GicsW7Snz3d9i/EpcObITt1O
 uVctrLWrWzNDuqHovfJPpNk3ncNoyHRZz8XY3x7I0FJqO0U8XO+xCImeq4MglMChbpFLQJMWXYl
 iX6qtZOfeIMVe4AgZeQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608010023
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppford; bh=IRFKAk1pTC5XvL0eI7L759AfOey
 zYxfv5ZLYWzadomI=; b=c7lnPBKVJIuFmzFtE12G9zpcbnRuNdoQKjNnM+GEdcm
 3Zc/jwraJUk2UQ5mVp8wIO5iU4jabftug6aTge6Fmi4D8Uk+K/KMnMe/4Ov5tN2c
 6A9dzIdqvQQSQEKdwqoywnB/P+W/D7jIEWhIwRDILBq+KIPYRucjZC1bb4nYeE8u
 JPQzp9sw6gGA/Y3XPHjtJmlQNbhDUm0cw378gzC25/DnDYjdlgp2JeYJ0NJ8c5Oz
 r11mINWFoLSmU10KaAc4rpVFm089CfZaaQvQy06v1iILzsF6KHLIqW1oYoW6CK//
 iVUF71f7CXoNg3ZbTmKUBtfyj5KcrS3gywgfIblo9Uw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRFKAk1pTC5XvL0eI7L759AfOeyzYxfv5ZLYWzadomI=;
 b=ILbfLlfOZdEpl1HtxjgDzaraSQnEKyJG2SEWsbgvGd0uOkiiyXbo0VRunW59Ej0UUeKoEO7/xjy+ql4xxZ8P/R3sEIhrnISN+E5iwBoiToSjt3M9KB0KP4mRKQHrncKeJoXBUMBUCe9by3icYTcljOYWAAaQdYgF8ldsZQDdzEk=
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppserprodsaar;
 bh=IRFKAk1pTC5XvL0eI7L759AfOeyzYxfv5ZLYWzadomI=; b=drDCiK7R2TP8
 9aUUKYE4BFS8O8mBWNpIWKuXuTquMmYIsC4M9ONSu132S7ONNGPT+J/rDdKj7+NN
 0qCcJkMk6+lg2vcpOqdR1RZ632P941xZDZBk/BTM4Pj/FUJiOy65zlmFfSHq4NgL
 za7HEwTkPcjrDwuQ/uQ+yyR1eq5sxdQ1QDM2zLQiIGB8iExOYdrfikUVd37xoC1X
 baGo1NAWJUPdqXGy+22yu0qT2lrib57kPd7vVvx1+vKCi8WRLwcPaFIeWRsSZ9BR
 lUO0ZQuC3XrcHwV1L9nYFy7W2J2/4stt0u1oaqDsRTia0A7DF5Bdr4yeA7YOUI1B
 vdM+JRbauQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppfserpocford; bh=IRFKAk1pTC5XvL0eI7L7
 59AfOeyzYxfv5ZLYWzadomI=; b=Cocr5h39SDO6FKk5LlrjAzP/cchM99CcfZra
 RWjUpkIMZRb/RAapFTZFkCA17e4nmELLziOCvXwIEweFg9xI9RWGixAg2Kdlx598
 9WN9xMhzz2FMTkxKfeMJkxmTKfiNXExYX6FYNn401et4wxQgZ10aexanLY7ZMITB
 Teiic92MdFyzQNYd21U2KiV8cj+a1lSYTC1jwcX5MJdQS7kiCIVdul2PgytCpaOW
 FBcvVJ0t0zlUyFWEMsHxpinO9PbwZVkgFB2YYHhm2GrG+cD/uA2hldbogtTP8Ysu
 MpXtKaB3FLG4ONPcVHvlFW1WcztNkCIOahvH3zkt92acANaisQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=ford.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ford.com header.i=@ford.com
 header.a=rsa-sha256 header.s=ppford header.b=c7lnPBKV; 
 dkim=pass (1024-bit key, unprotected) header.d=azureford.onmicrosoft.com
 header.i=@azureford.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-azureford-onmicrosoft-com header.b=ILbfLlfO; 
 dkim=pass (2048-bit key, unprotected) header.d=saarlouis.ford.com
 header.i=@saarlouis.ford.com header.a=rsa-sha256 header.s=ppserprodsaar
 header.b=drDCiK7R; 
 dkim=neutral header.d=ford.com header.i=@ford.com header.a=rsa-sha256
 header.s=ppfserpocford header.b=Cocr5h39
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
From: Denis Mukhin via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: dmukhin@ford.com
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Fri, Jul 31, 2026 at 01:08:23PM +0200, Heinrich Schuchardt via U-Boot wrote:
> On 7/30/26 03:39, Denis Mukhin via U-Boot wrote:
> > From: Denis Mukhin <dmukhin@ford.com>
> > 
> > Use existing BOOT_PART_TYPE symbol instead of open-coded "U-Boot".
> > 
> > Signed-off-by: Denis Mukhin <dmukhin@ford.com>
> > ---
> >   disk/part_efi.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/disk/part_efi.c b/disk/part_efi.c
> > index d8b17ec2e91a..1efd2ea113f0 100644
> > --- a/disk/part_efi.c
> > +++ b/disk/part_efi.c
> > @@ -304,7 +304,7 @@ static int __maybe_unused part_get_info_efi(struct blk_desc *desc, int part,
> >   	snprintf((char *)info->name, sizeof(info->name), "%s",
> >   		 print_efiname(&gpt_pte));
> > -	strcpy((char *)info->type, "U-Boot");
> > +	strcpy((char *)info->type, BOOT_PART_TYPE);
> 
> Thank you for looking into the value of this field which unfortunately is
> not well described in include/part.h. It is used in print_gpt_info() to
> print a user readable description of the partition type.
> 
> => gpt read host 0
> Partition 1:
> Start 1MiB, size 62MiB
> Block size 512, name Linux filesystem
> Type U-Boot, bootable 0
> UUID d3f19932-f3fb-408a-81dc-fadb4438ed5a
> Type GUID c12a7328-f81f-11d2-ba4b-00a0c93ec93b
> 
> The constant BOOT_PART_TYPE is unrelated to the field type. It is used to
> define a linker generated list.
> 
> The value "U-Boot" itself looks wrong:
> 
> For a Mac partition we would expect values like "Apple_HFS", "Apple_Driver".
> 
> For an Amiga partition we would see for example "DOS\0", "PDS\0", "SFS\0",
> "LNX\0", "MAC\0", "MDS\0".
> 
> For a GPT partition we should have a string representing the partition type
> depending on the partition type GUID.
> 
> If CONFIG_PARTITION_TYPE_GUID=y and CONFIG_LIB_UUID=y, we can use
> uuid_guid_get_str() to get the correct value, how about:

Thanks for taking a look!
I will check that path.

> 
> diff --git a/disk/part_efi.c b/disk/part_efi.c
> index d8b17ec2e91..1385bdae577 100644
> --- a/disk/part_efi.c
> +++ b/disk/part_efi.c
> @@ -304,7 +304,7 @@ static int __maybe_unused part_get_info_efi(struct
> blk_desc *desc, int part,
> 
>         snprintf((char *)info->name, sizeof(info->name), "%s",
>                  print_efiname(&gpt_pte));
> -       strcpy((char *)info->type, "U-Boot");
> +       strcpy((char *)info->type, "gpt");
>         info->bootable = get_bootable(&gpt_pte);
>         info->type_flags = gpt_pte.attributes.fields.type_guid_specific;
>         if (CONFIG_IS_ENABLED(PARTITION_UUIDS)) {
> @@ -316,6 +316,8 @@ static int __maybe_unused part_get_info_efi(struct
> blk_desc *desc, int part,
>                 uuid_bin_to_str(gpt_pte.partition_type_guid.b,
>                                 (char *)disk_partition_type_guid(info),
>                                 UUID_STR_FORMAT_GUID);
> +               snprintf((char *)info->type, sizeof(info->type), "%pUs",
> +                        gpt_pte.partition_type_guid.b);
>         }
> 
>         log_debug("start 0x" LBAF ", size 0x" LBAF ", name %s\n",
> info->start,
> 
> test/py/tests/test_gpt.py might need to be adjusted too.
> 
> Best regards
> 
> Heinrich
> 
> >   	info->bootable = get_bootable(&gpt_pte);
> >   	info->type_flags = gpt_pte.attributes.fields.type_guid_specific;
> >   	if (CONFIG_IS_ENABLED(PARTITION_UUIDS)) {
> 
