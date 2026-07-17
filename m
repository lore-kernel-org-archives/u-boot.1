Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D4FDC44516
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 10:25:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F05984DBF;
	Fri, 17 Jul 2026 12:25:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="E4Ggl1q6";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Iux5Rgg3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42AF384DC3; Fri, 17 Jul 2026 12:25:23 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 680AC84DBB
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 12:25:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66H6algX1759256; Fri, 17 Jul 2026 05:25:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=gDb/vTF6K6k6UlnTKI95CkdJe4Z74Vu4Wx90+M6PH
 Pc=; b=E4Ggl1q6J28MA0USwsuef91CfrQ5P9G+nWfYWgubUjFWSlcglYhxhKjf0
 9mWfLsJoO719E0pLK4zQo2uda2/SVJVCQO56WGlBrlQOl8VLET4MwXvjyUFIi4Wm
 0r42od7G4v1K45pyw10a+nKjRGV/y4sgoVzYvvLgSjSGZPyV5hfEAYJzRKp0xzcV
 3kZPR4EWsLAh0vXApZcsiU6KhKEd20cdg7WRjMLsNSJi1wL7GMbmYrE5QuQzEgRc
 bqKofbD5rBZCK6OxZbvHAJZV+KmlnEppoH/ho0yl1NEfuiq9Yefkugn0lhW/V7HJ
 J+VytbjgZXdePwozo0DT1gtBDZIdg==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11010040.outbound.protection.outlook.com [52.101.201.40])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ff1p6wa9v-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2026 05:25:13 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rDaRDgdL0V2AeapU3dBPjcA5AYUcVUe3NjA4FSWOrYUT9ZepNdnINywlvV5cSOy07JTwfmlJsO/5APLX79/OuqWC52+5cQGm5RS5KQWQEuMHolQzwXpeMWU/Ou92UQZgVvniNtqCyfFZcEl5ZgoHA+bPFq6pXHSlnUUMZUsmOA77HCL6HEwH8sKHEL1/I05C1vFGNKBAMXqA8jSZ74KuwSFG75VomyjKyFKxXH/+jCRx9bhvweyzdW7HNDF2Tzo3as50NQRoPGbDITjV0mOWffaGXHVjANTX/eGyBaOBvdafcuhrDPu7npBg3uiMfRKNDWX5p40Hw9Wgf7JqxxaSDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDb/vTF6K6k6UlnTKI95CkdJe4Z74Vu4Wx90+M6PHPc=;
 b=gWsTg81ujg2bL5F3vxn6t2fXvRZ3zY5dUGAPD/o3I8hbqPCprQPciTkrEFUy9JW2NydAvQQNtKHcasI2jM+wypNFEBa3KFD7+bUak2lcF61zbcmS89i48jzyzCHUsnBnUo6FwoG/xdtGygV1TJwLQXann13o9WU3If6nd31MVo7k6zvJjmMWg5yOjpjQ3t0+ArwLGGwOlF2AdkkXMyGt7I8VKa/qsjm9S+ihUPyqXKXbU6hLN/u2ks73eSuz/mQh8+FbR5lu/f5h3pNU7fSBb99kGG3WaL+aKYlLshgrYBgO7WsppH3V6NWMCSZKMHGyZumcceFa2Rv+9LTUsRAG7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDb/vTF6K6k6UlnTKI95CkdJe4Z74Vu4Wx90+M6PHPc=;
 b=Iux5Rgg3HVaMp2W8uWt88D+fGwfpXkuhkjnMd/5F8Dhcut+psJ5XTih7+xRxkM213s4A1aTg0Ne+c+xUmKeqUPGMa2TP7hJ1IJnSVZKV9wSedJqbjhVs/uktZLVkXFMbhaxwpSfSzdG37kXir/1ivqJ073vBi/Pv9Wokg/WOIlQ=
Received: from CH3P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::9)
 by CO6PR10MB5635.namprd10.prod.outlook.com (2603:10b6:303:14a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 10:25:09 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::5b) by CH3P221CA0007.outlook.office365.com
 (2603:10b6:610:1e7::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 10:25:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 10:25:09 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 05:24:58 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 05:24:58 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 17 Jul 2026 05:24:58 -0500
Received: from [127.0.1.1]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66HAOspH3583337;
 Fri, 17 Jul 2026 05:24:55 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ufs: invalidate the whole descriptor data segment
 after a query read
From: Neha Malcom Francis <n-francis@ti.com>
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
CC: <neil.armstrong@linaro.org>, <bhupesh.linux@gmail.com>, <n-francis@ti.com>,
 <trini@konsulko.com>, <marek.vasut+renesas@mailbox.org>,
 <macpaul.lin@mediatek.com>, <jstephan@baylibre.com>,
 <padmarao.begari@amd.com>, <faiz_abbas@ti.com>, <u-boot@lists.denx.de>,
 <sumit.garg@kernel.org>
In-Reply-To: <20260717093013.3253643-1-jorge.ramirez@oss.qualcomm.com>
References: <20260717093013.3253643-1-jorge.ramirez@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 15:54:52 +0530
Message-ID: <178428389242.1179430.4019304952514382568.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784283894; l=271;
 i=n-francis@ti.com; s=20260428; h=from:subject:message-id;
 bh=qV+7vYNjLdt9fRZR0D1en/ZKGlrwKZRRZZAnWZKorgw=;
 b=feUQ0ejixjPG+SsTVIHVgyqI78vhNocVoeDo2k/oIPbzsDh2sDgeo+gRTOdFaDCzbkNkNlPkZ
 8XWfwM1Y7G5BtkIssyVXstVmtXH+0aNNHrjIY/3l74QLdsc4scjBwVT
X-Developer-Key: i=n-francis@ti.com; a=ed25519;
 pk=Z4nV5FmpAM9e1Jk0HnCKOoVUtHW8cscgDRncr2IngXg=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|CO6PR10MB5635:EE_
X-MS-Office365-Filtering-Correlation-Id: edd92bca-1b66-4839-58e0-08dee3edadc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|7416014|82310400026|1800799024|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: mCkP1P24yY+v0/ULJcy2ZjF7Uwko66jSzvpvfsnOTRawlUdyWnPBvLCy5afVvGvui7Q/S1QnlKGfyTb+3xQLQCeDwu9DKU5ytVlPLlHJTmJmVPUwYigAC5BKUce95vzVLawCldm9T9j7C03jbpMLp62xEKzYReqXTET4I7LRIOZ50GvOWzM4QSvhuR0npYZQmaVKRDX+E/a2ohFWnPF4uiOEnBO7qlZnIATUG8AWAC+jut/zDSUqLsSYn8KnQSIZnyRyc6yTX3pE1u671gekUzOQx+I105xdWXPF9Ir04b0JlWKXD+WEwGySp8OzBs54n0qTiZcYGjyeBZI7ptIv77nfj0c5sXBjZVix636RJsC8bhxBuGesffrF8lzlQJGB5MpNv058tadJeI0eDWyQ5yS2+wZzmyaPwE+8irVHcCDZ1Hlcs2UNSCxmRC6+NL48iNol+jvh6tW+aslqcnE+bIlrAOXkv7iJVUkla0XODBTDRU52655Lfmi4rdYPdM44oXbzXAxuDNg+KBRNKnuw/sn/Ah+4N5JzEKci/qHoB46C+UI2t5yv7zK2w9FjjNPSZcMuZ6SgZgY6D9sNUFYhigRhaJLndq1t67liZ6Sa0DLQMsMd20HeQkDh7uLkwRBfFbqh5LUcdJKea2BvzjPtlz0aJE/qB4ie/HVs1pqq3vmMovVFhpFbYWhdSgVB6mSkF5YJuSlYAIrMqKHXFodHPA==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(7416014)(82310400026)(1800799024)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /TnEYqq5WVUDETUie77M7q9b5StQPzE6Ma1QiRI2O/Vyb1DDhGo6IOzJk9JcL9X2Z4fZxmCKSX8KbkCmuY9U/qKNLjXYo2TZ8+0JzamW74u2JvkTcgLlOXJEP1lmABALj07bEW2onUWuVcojiKrTFiJY3UQ3QjIRwa4xi61rckDF16bpoAdvsprKYW5A8NK4WhgsCVoSWeBlgL616LGiU3AZ8Jt+xW1kSH/3TmYjcJLSNev9Be6TlsDlXJMsuo3lQDk2JiskPgxsQJcKsxAonBESMMrP59zmwgru2Pbv5Q4CjhfOSAaYLNqgqWfeewr543bmpigC+kUnCINTiApNhqXiv2ep66QIHC8QEVoUacu5VtmrEidLhMFGw9BaQntLcZcdulFryzV5J5DL/aDlRO25CrKJpjtJ5N9nor41OQ5VPVsNuo3EFUsskZALSnjk
X-Exchange-RoutingPolicyChecked: Pe4dyi2ze8T4esO6thde4ff4xoxD+6qODDsR+nVDysWT1M06rsBfTSkAx6dzWXoZeuIHzmG+BSiJZkdM91130K+bkZcD6MDFFMZsxaZkryAYwW+vshctsTlFQP4YS1e4XAiM6RB2c1DLzaATf6ScwiG8zepSiaVIVqfdtouY/EfNDG6pvDuErKN5QBvzwZOaDKmwtgheJoq1By8as1xfhFwoT0+koi+XqEbIp2miorAA9mWiv1mVkOyqm3PgjioxX7qoM2jLtg+aohD3J++9OprPGVkpDyHX6ZuC3WLIgLNrXz1nYS5E6LWmH6jgjgWlwyKdvXTqHnB+FxvltDDBdA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 10:25:09.4639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edd92bca-1b66-4839-58e0-08dee3edadc9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5635
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEwMiBTYWx0ZWRfX0H67KZAWYV4s
 lNmVSFmZuzpwsjdsrx3Ua80VkbEK56jcdZ7V2/Se1+wdHvCUNBowT6ntG3wko8TPREC9ExKRkML
 NCXZTp9fd2dnxdZ+W6TrCe9/ADSwRVfuJdhEIWx0bDIyRCoB5Z7Kq8+xVBBrvUw4Ql4EtJXq3ha
 mrwv1IFqeAo+LI+CVyb3YsexApENBP18Y66QaD/08FgmW4+Hr2w+mP/jykiZQHn1qp2zDd5rUv4
 0QYt7efJUVlSVRaMqkZaaKGuBTVELhMgR5PUm8/2Yy+o8i+CrF7URcc5p7WUhHC/ysQEvlRXvQO
 UFeO7TpRZ49T5LilnEPb5qDKeJ/F1vJLwDoKv/Q415OGefHrQ3Yg/VJDsJiGVehwzSFGDru826v
 7yLc/wkw86R9PfNHunjcH0haYh1aOV84SzkalH7t4SHgE97atqB8yH5u3kB3w7qc9gshZvh1+xB
 3Ci23wbr780fMvkBPQA==
X-Proofpoint-ORIG-GUID: UE458kuFJlq-p9YyGowTMjm2MNZ-kFKw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEwMiBTYWx0ZWRfX9yKGT8Jv7BLn
 FbKlei83AFxUp0xjRj3Z98Y2fd1XdXqoZuQviJh8FPouI6PWARZ20FSlUrLuumiftE6mB3DHpYk
 htkc4l6yQMeGcj8K43k/6wBhA6FipHU=
X-Authority-Analysis: v=2.4 cv=IOoyzAvG c=1 sm=1 tr=0 ts=6a5a0309 cx=c_pps
 a=TO2QspbEOyvqwnNCDF3LgQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=EUspDBNiAAAA:8
 a=sozttTNsAAAA:8 a=VD___nb0v5aGHT0uwEMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: UE458kuFJlq-p9YyGowTMjm2MNZ-kFKw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 malwarescore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170102
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

On Fri, 17 Jul 2026 11:30:07 +0200, Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com> wrote:
> ufs: invalidate the whole descriptor data segment after a query read

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Neha Malcom Francis <n-francis@ti.com>
