Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F5BDC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 11:19:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8094084852;
	Tue,  7 Jul 2026 13:19:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UTP2ZzMh";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SUMadX6H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0683B84942; Tue,  7 Jul 2026 13:19:44 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85553846B4
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 13:19:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 667BCRQ72614500;
 Tue, 7 Jul 2026 06:19:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=e9hUgUyagAyU5MWEp0Sh697f9tpd5E6nf9pJVicvu
 Uo=; b=UTP2ZzMhtxT3K/SYFJ07v5u4OOQ6zDbK+z9a5sDnsYLJgh+hTlDAQHhBm
 bI07VnKsMMnu6kxERCcraU9ArHG00ajpB8FNoXUhBA6hqw5XY7khxEP0gVgUc6hp
 139l6XNF/1cgKrB/0VQBgWy4LGqM4EXhoBZWD0XQZREKxvQ6NHtZreo3Erwylw6p
 RiM1YtVtmpxIjIZDBnbqnCK45CN9JeTqb1LU1tw7zsEo89xKyqAjOOOdqXlP5vXF
 ITf4gk6cVugC9Td+llcna10gq1B0QKI4fjKwA+yYsrsLrplKoyKX1qn2F2Mch3HF
 lSxcXmKBP42ewHdI+6JqhMEMJ2hMQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012054.outbound.protection.outlook.com [52.101.43.54])
 by m0384305.ppops.net (PPS) with ESMTPS id 4f90cn00xc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 06:19:31 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PLcvrZJPOirq54SiXSXo9xaZ6V1oBnsoIZ3Wa/lHq4CdJzpxwTJVGWe41RDY4eYONkFSl0BNeE1IltR2RJZ1pTIV0+9XbQAodKAkYhSuOeyTDpFkhxAxtKYnWet83WnD4THYlc4IgPoZki6QuKca3/EEd80DI2DDhBOX2VKjY6/5Uqx8Srd311nrLHvPDu5Gz6G5CQ589veJ0AOrHmc7bUnfbOrkeccqf/Tc+9OHhOpv11dB2bzKrHVT0QIQnZPOCQgUW8bhLr1GT4/Lelr1fzOxZvrr3xEYO3dJ2USLLorrbO1r9yxvx2g02IGVgR9H5lXq77Snw90bBMLsDICIgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9hUgUyagAyU5MWEp0Sh697f9tpd5E6nf9pJVicvuUo=;
 b=SBN4zaEAt7ngvkRFxNTzrJKRVph6BUuHa9qxYWkaERk6nGPXey6vAjtUP9aVlVfw258Fqvmfo+XedeNbu2+7Y+nuwsNYnhctm3+3FlhRCRU2oMtXT7fVVrwBAX+FBqPrfcYFBm7gHZbksUUSqz0ANl22nFBJO5t3Q2cofC+jzwxveWfjv0JWn7ue3OYbfFeinnsGhnOGuDxXsppBd+Rw6KanKbdFTp1RdXZOMQk2jxTZhvwD4TZVGhvkoG8l/Zz8a8jvyhRg6c6p+eIsrG9jNFqDEcqRC5gnSBg6uzjWO/J5SpCFw0WV6Bt/V/0VvbbGpOnCVund2udAsDuawjAoeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=etu.esisar.grenoble-inp.fr
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9hUgUyagAyU5MWEp0Sh697f9tpd5E6nf9pJVicvuUo=;
 b=SUMadX6HRnL5FhClEfA6U16GLkhCo17GHZ2ojnEbcB83nHuv8BAubtOIENivRicwCyBq1NsC6mPfukdjYFr+DF6PF4t93/LfWgY9tcsYJTFTALnaFd5Apyl+ztoqKkfDh8wnKeWZAjjmVCk3gfHlRAA1ujahUZ+GNpj5hZw8FpA=
Received: from MW4PR04CA0252.namprd04.prod.outlook.com (2603:10b6:303:88::17)
 by CH3PR10MB7908.namprd10.prod.outlook.com (2603:10b6:610:1d1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 11:19:26 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:303:88:cafe::84) by MW4PR04CA0252.outlook.office365.com
 (2603:10b6:303:88::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 7
 Jul 2026 11:19:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 11:19:25 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 7 Jul
 2026 06:19:25 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 7 Jul
 2026 06:19:23 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 7 Jul 2026 06:19:23 -0500
Received: from [127.0.1.1]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 667BJJpo092347;
 Tue, 7 Jul 2026 06:19:22 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 2/3] ti_pwm: Fix EHRPWM issue
From: Neha Malcom Francis <n-francis@ti.com>
To: <theodore.oviguian@etu.esisar.grenoble-inp.fr>
CC: <u-boot@lists.denx.de>, Theodore Oviguian <theodore.oviguian@se.com>, "Tom
 Rini" <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, "Neha Malcom
 Francis" <n-francis@ti.com>
In-Reply-To: <20260706083507.18386-3-theodore.oviguian@etu.esisar.grenoble-inp.fr>
References: <20260706083507.18386-1-theodore.oviguian@etu.esisar.grenoble-inp.fr>
 <20260706083507.18386-3-theodore.oviguian@etu.esisar.grenoble-inp.fr>
Date: Tue, 7 Jul 2026 16:49:16 +0530
Message-ID: <178342315668.657164.9442616742148473825.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783423159; l=1162;
 i=n-francis@ti.com; s=20260428; h=from:subject:message-id;
 bh=o8hRD5niNILD/taZ+Rt1Zi1Gkyfayadc7MzWgkh/p10=;
 b=DbXPxLk0YhC8uXhu2/hV3dkiRTcoGND8pAAfMDmNdJRq+H4invSb/WLjkPET8GSmNiowIG4My
 jZLMgmp+QcZBFmA9ELZ2rCUMQZ2tFNESLrTj66bCmwUCuSh/KuOsIGK
X-Developer-Key: i=n-francis@ti.com; a=ed25519;
 pk=Z4nV5FmpAM9e1Jk0HnCKOoVUtHW8cscgDRncr2IngXg=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|CH3PR10MB7908:EE_
X-MS-Office365-Filtering-Correlation-Id: 655bc7ec-9400-4fa8-e24a-08dedc199a91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4Rq7/LUU+JCJhv/Xdy7YXkkk/K8qxtnarx9H0+vF1xtAbmrXIPqqDjw2i0Safp9n74mhZNUvns6KUFrzBRlOtrINIh9TTA06xIZNCwCG/6VU1LCvVBxA6zZf3UYo+BWGs3hthyO3VGlt4dWUHYx3uu31+bSKrfkb3eOj1+jvCsjviImN5t5l/KEQoMOh+JDxqEBXYunxOmS31XAJb1JGK8uK1g4a0alp8Z9Am2PllOB8zRL667IOaCKSdDas18vW5zgZZfBAzfXv5JTLBEUq2BtIC5gZCyOfdOa+G7nNAD5OwUFWdWji4gvbIBBZllEb3HEZ9KDX12wZe89jMWICYa1lVskEdkqpj6IrgHZ7s+r/I7nqoiuRCPjHG7F9A48Ta+0Q9bFWc6qfbsEPRYcrPHnopE/9wGPh+Gj52/U3EuAvPwrsahLD9bctKL17aCrxLBDzgrY9RfdoUCipVtsUV9S3Nj0a3nvvHjhAGPl2En01gCP2wU0UNlFEVlZuwaNcJuVf6S6TRs7rRdFKk9aFkdGls7ZwaNVhrgdABPwxc7PnaKGQYL4qFGLtCfYDhI1BmPk381xs/v0+ojviQfL+0LH5q2RCSyEQ6eJg/hP7A3LsSdTr2Ku/iZL/GpG5PaBbvxGfDwZZM1JD9Vd5CIZtRUGCPSXaSFPjond+lAxgFtfIMuXWXZPDR8BKkvj/P5utNTbVPPdWSvZyP3HfeSvdBQ==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OkbWVr0TXHJxUBC3I5PILQsT/0wiJq+IJUXweZXXo7JYoYc90pr+0NcF59rbuZoW9FIgE99BLngXsy/JGGQrOQeLeJ96XIigh9bCYuy+3f4mCA38FiUHGqcEaqTCvQNJ7tI59wkJVDi9qSawzWSUtw6+Txt0xq2ffcNI9AflzoWz+qVlREZ9IQcj9XyTh6VHt9OGTu/yoVKjhvzYMVRkNLRNmMYXZWcy+E3NynnxtdVxmRdfnKwktRKTsbNcVuRHvuZ01ehPLnx0MsH8aK7C4xREL74NGVhNRSNwqamxbYyt0RicSN8MlSidqD5sw57b0Fhsk1JQMQ2hHeQ49cgS6LbmbVcUtLuEIqU4Va9sZEHo3ScMN/ZEobiLH9uZT9Pwwxrch4JJ06yrJ3ShWF0tGH5Ra+Pg8tMv6kUA5AyEoaAPj5qKScTlD5NBcLdV3tbx
X-Exchange-RoutingPolicyChecked: PsW1XqCP0mMZ0nT9oPdVPdij7GKeYDrDqIw/mMrjxKvJCHhOYVHy1ljFw2oG6H8ukd+eL8xVd2EASBQwkiwqIqaPLF2MD6s5Av3v4tRF/z3TA9LYojqBMDqRCJPGYazI9OjwvQ7IHucZAMqjepbT9OJChQEBYSNVMRA2jLxT6nCb50uhn9qQaXWEz6nfUvn+hOblw8R4rLLPoauWBHpNsTJwBFGIeSjFenVXtf19jUqcxe6F1pd0c8NtDfAAmcD95RcYGor6V5bTlNGwXNtM4w59w3a45/M6eODaOINlArfaH+Qt4P/be/x0uPE9l4TBJLDLZEpQltptPfc7kNu/iA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 11:19:25.7446 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 655bc7ec-9400-4fa8-e24a-08dedc199a91
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7908
X-Proofpoint-GUID: ocxrnKNAm3aKYNtmRmMytNbFYIzJV4Tu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEwOCBTYWx0ZWRfXzkVZ2hU4K/6m
 dDrxsTT5RSzOo3eZp7XY1XDk3NMWUoN3BJiYasaRQ+IYPh7tOXcS275amrFCtKSsbUX5zi6GLEE
 e24V4wFZncuuz6k2thV5JbtpWVSvIkTpDtaGtVIgwavLF2EFuH6IiGfatTPn0XfKTb+ecgkOjzA
 6VqrbhS/LSMdEmML3r1E/ezfNPw1Sz1fal2ioa+sHxosCH//gteEeKfhGKBH2xhEVAlGzmHfH23
 aQYlCfZDh0eXQoOv2mGsIGb+NWV16S7juqXKFNIHDahBn7ggmS3Lmnzz0k+/ebv8WubxdaOvqlO
 Y5IBjSwQ07ioRQTKLWgaR9RLQ6KY0kEYq0fobn5q/sf9XQJ0npSzoJ2360gR3zVTD5Z5/pKW7zY
 RCaO7Bd0dK32HdTRI2UHH4zzyNVuEhZC3GvU/T4qNs/cyUxCC4rL2b4kX1J6q1J+FKax4czgmIh
 OiZNRBvwcoGpKrVtGjg==
X-Authority-Analysis: v=2.4 cv=R5gz39RX c=1 sm=1 tr=0 ts=6a4ce0c3 cx=c_pps
 a=8Mab7lbrFfecTh0PXXvUKw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=ZTk7C5XJRZMqcEks02AA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ocxrnKNAm3aKYNtmRmMytNbFYIzJV4Tu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEwOCBTYWx0ZWRfX7zPNjMset7VE
 j+pF8a4DfeL3jeDJhejlkWR7iTuyOwR8sVf898RDlag6Hgj1NbDAaHxYVAO04zrtRy7GcFBMrak
 Fz8ATlOMTB1swhis1p8oRN9xYVRA18U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070108
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

On Mon, 06 Jul 2026 08:35:01 +0000, theodore.oviguian@etu.esisar.grenoble-inp.fr <theodore.oviguian@etu.esisar.grenoble-inp.fr> wrote:
> diff --git a/drivers/pwm/pwm-ti-ehrpwm.c b/drivers/pwm/pwm-ti-ehrpwm.c
> index 135ea3b4321..3a06da00b68 100644
> --- a/drivers/pwm/pwm-ti-ehrpwm.c
> +++ b/drivers/pwm/pwm-ti-ehrpwm.c
> @@ -333,6 +334,15 @@ static int ti_ehrpwm_disable(struct udevice *dev, uint channel)
>  	ti_ehrpwm_modify(aqcsfrc_val, aqcsfrc_mask,
>  			 priv->regs + TI_EHRPWM_AQCSFRC);
>  
> +	/*
> +	 * Disabling TBCLK on PWM disable
> +	 * Only if all channels are disabled
> +	 */
> +	priv->enabled[channel] = false;
> +	for (uint i = 0; i < TI_EHRPWM_NUM_CHANNELS; i++) {
> +		if (priv->enabled[i])
> +			return 0;
> +	}
>  	/* Disabling TBCLK on PWM disable */

Can probably remove this line since block comments mentions disabling TBCLK

> @@ -439,6 +449,9 @@ static int ti_ehrpwm_probe(struct udevice *dev)
>  		return err;
>  	}
>  
> +	for (uint i = 0; i < TI_EHRPWM_NUM_CHANNELS; i++)
> +		priv->enabled[i] = false;

priv_auto uses calloc so this loop is not needed

-- 
Neha Malcom Francis <n-francis@ti.com>
