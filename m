Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4FD9C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 04:02:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C16C284118;
	Wed,  8 Jul 2026 06:02:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UuLdZUVv";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VrbIJKGf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A949284942; Wed,  8 Jul 2026 06:02:35 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B34D838D7
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 06:02:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667MbVYI627450; Tue, 7 Jul 2026 23:02:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=8LBOjghTICY8YWvR2aDCYCcF8yP0ZMZ05qYXuBHUp
 Xc=; b=UuLdZUVvYBdKx0QZl/9CcqHzc1ztP3KgFdA8iRqDI49O3Km6tnSuUBf34
 yS/hFsmRiWQK58Do8ctR13peMxUs5wRSMLfWxbfqBM05S9ZS04NAD0cdF4KwbASp
 p5PvnzHzfwrOM7GfCEeP+4vDRVzjqAq9yvfsRPWbBjHiYx0jopZuqYMxb+8YSjOR
 9ZqOU/m5m2SyeeTM3hIjSp8K+4VAKF/ZbEZA7shlWXs4gbcsDGvuoa/Rn23z2KXT
 2v3mbQu52pgHLrYWDRs05DFEUqMHZf5MN+JGeHSnvFA3glHDdpZzGeH/pC19jIZY
 LA2nK7bPZ0peHSO8Gh6WoN53jWOQg==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010044.outbound.protection.outlook.com
 [40.93.198.44])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f94m7ca3q-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 23:02:29 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SXnI6jj6HB50DR3BTsiHV/APucLxDq4lB+c1BjYjkJBLPdF7ZTIwohRX5RKizc0OjNWyZW5gXBDYWOdMUT4axLIuFfgK4+DD3jZ+ggstBprkXItxKYXYOfRh+O0Vh3I6QzT4AlSqTYBz2T16mTBgU3HZ2KffdZZEe0DSEzuaz0sL7+D74U9f/a3nO119MtRZZRIj1nl32FRv5eh8Oce7IPJjOP2h+JgkTiPAoD023TXlApafwQCjdKvvuh5oiy7JIc1Gb4vslaZKncHxuQNp1CL+ZAlTZkyPMBRJlBfPpDCKB8ieq4zxYaiOrlWJ72Zijiczatm81eI8enVjWh4Gfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LBOjghTICY8YWvR2aDCYCcF8yP0ZMZ05qYXuBHUpXc=;
 b=peG/DynKxu3hubEZECk1O5/gzgW8Zlhwj+FS0zmDktpZlZFosC7d3Ip+t7129TXWqOTpT4pDHDMqXVaFfXovSANr1ygXUpTExidYpkOCvuvNvU8SHzzfIldPsPLhlKUQ9tElLjAziM0Ai/BUaW0REzWY1R0JOk58iMSsJk948/vd3Ea00t/WxnIrqA+RCTBkCkq5se+mGawi6aUA9blMMaUj3J5KGW04hddaP485+JaM1X6Jfh/Ei9LTpZ4sPD90XsX8S6XQVqZRVmsOZyOdQenQA6veGjcrvvbjIk5IidbaF4+vqaOm93zYbSZUU3Zuia9Zdf73jMlGGagnm8ygqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LBOjghTICY8YWvR2aDCYCcF8yP0ZMZ05qYXuBHUpXc=;
 b=VrbIJKGf/Az896wwEJoJnDkT7mPpiz++PNi8t9a4gibjmamsR5ahg2UFB99ofbipdBez4RUkMYDi3c5TdhmofCk9EdREUAsoubGO0mRiz/rgxECdCcoUP1UDdl/flnnM+YDdS3CyqYbwndONvFGfmpH9AmYPRWzes2dXISbVZF8=
Received: from CH5P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::29)
 by IA0PR10MB6819.namprd10.prod.outlook.com (2603:10b6:208:438::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 04:02:26 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::85) by CH5P220CA0006.outlook.office365.com
 (2603:10b6:610:1ef::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Wed, 8
 Jul 2026 04:02:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 04:02:26 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 7 Jul
 2026 23:02:23 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 7 Jul
 2026 23:02:22 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 7 Jul 2026 23:02:22 -0500
Received: from [127.0.1.1]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66842I5f1259162;
 Tue, 7 Jul 2026 23:02:19 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/4] arm: mach-k3: Fix phandle corruption in fdt fixup
From: Neha Malcom Francis <n-francis@ti.com>
To: Paresh Bhagat <p-bhagat@ti.com>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <praneeth@ti.com>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>, <msp@baylibre.com>,
 <v-singh1@ti.com>, <anshuld@ti.com>, <afd@ti.com>, <m-chawdhry@ti.com>,
 <joao.goncalves@toradex.com>, <bb@ti.com>, <n-francis@ti.com>,
 <sebin.francis@ti.com>
In-Reply-To: <20260701075021.3626094-2-p-bhagat@ti.com>
References: <20260701075021.3626094-1-p-bhagat@ti.com>
 <20260701075021.3626094-2-p-bhagat@ti.com>
Date: Wed, 8 Jul 2026 09:32:15 +0530
Message-ID: <178348333511.719416.1361864525543952269.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783483338; l=479;
 i=n-francis@ti.com; s=20260428; h=from:subject:message-id;
 bh=bWqGKoWaqzNh5Pu22o9wX++p25OHgNvfWLlFmgRL5Fc=;
 b=9ssLpG7SnNXPW32ZEnOlbNk956Cm0HKooZJY5NwWjonLZwGUgCmRi78QHwOV8FRIziY+WkuAf
 sNEJB5tpKaACiESqxZLlhEYk0p2VCe3kiw4WRIUOLC345vdQ9OF5XCo
X-Developer-Key: i=n-francis@ti.com; a=ed25519;
 pk=Z4nV5FmpAM9e1Jk0HnCKOoVUtHW8cscgDRncr2IngXg=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|IA0PR10MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: f254176a-b4a8-4351-a8ec-08dedca5b916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: CFzJYCfs7p27B8lagwJHDyBESvyPd+bWw8FVoNH/OLBbapA9alFiPYdxVHT8Wnla12Fn5HljBHpr97B9faDj1mewIF8QSItfFJHsfxWh/e/wN/9f1fzEMeWd832bBvoo3JjVdpW9HXPcDK8sVIbU98ojYunnNCmXVaKN3g129EQeYaFNett9IJ4E8xnxxyQ7B0ZyX+UYqXO+KT4r4ofI6HjPPT5y08qj/zXIaYw6VMYck4tdY/LCjVGfpswX2lENXb+xQdi0+nZubdeZ7mgYQAmWv72FXsW51coPE5WkmhkNOHDYbmfYfTYCIH82Pgto6TKE93Ly/XcrwVOepj46mJEMcPJU+82UvjZXG/ROKWFkw6U+n3mWVDxNOAoKznoVn3g9Lb8XVIjulGIHMReova+ECdWRIbb6TdNK6w3T2RHIH2ORGsuQQZUhGmI/R2ZQJ+fdAyiC+Ycdk2dJk+Gd1T5Mq06drl7jBAtthaCtHCqn2uwlvcgdAlIxA1IIQbBMia0eQ0chE3tXcmueMu99/mCD5qsskp+w+EFSRx7rBa0TO4SzI78Hi6we6LBgNhlnGbx7DSRW7Po46cp/7D0mM9+J/kZGYoE2lve0PAUurgBaKXDIMTP6o7mh/gHpjugCB8TxsmftXDWMXQWFMk/pEQIQuEHB81PLWHmPPWJ+uD2sahb36XRHqGCitbY6G+tYRR7TIRUtOo7xEwY45yRf4w==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(22082099003)(18002099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RJPi12V9+SXuS7uveYzV1Qm90meGZGSySfcnEWvtCT6OXMpTPaJKWAksYndeEncoSZz1kCwowGcvys8AwTlrIE5dp8DzM5op0U/WuHPygfxZgQMlNUZ1/BFNAPXS6Y+HaZXECn65yazHFoDfYmPzrmy9/9PcPU/a5Jkk8g5xzk3edwI/Uk2F5qG5AipBZdmo1fOmoxp5XDp0gbu19n3iFrg318yBLcWSrD/vrCfwUv/YaEhDum9ItzI6AINoszT9pJK65+zA01qA0Ojuhx4Us9mBJ0k6XiT2VhQ6zBdZ5a4IeoX4pm5nhbKcdDJNGexLuE7ANodC83XCi0CUkdlWt0nsZUy6H53ucjzD3nF9aexjEyv+xWl37/Z2mYJkDnHRBzAnrnv1670mLCjVA2v506XB7Fj71Zc/1XaJvQJsUxVb8w71QexSszwApSPXQYt2
X-Exchange-RoutingPolicyChecked: LDg4cFzqae8bm9eJdXFEOuFALbHJ+FURWMrv6GHU0GjJplWr5QQDqeKkXY8vI60cGBR9XUFMQP992A3v1MzeYy1sNwPU11piboz0ciwty065GTAx9ICfja1GxM2VJEEYnvm2OVlOLWBcv14f+zNqAiNg7i6RnDCETe/8FraFFlmCp9g2GFGzIsMYmqYfPd3vyrL/1mktBk/obCjY1fznJyfZr2bfxeRFPiSL6afsPrbBhH6I2XDucqc0cSOgv2CB16bs/gRSGMZ3vjiTVoZAlfEDMq7oeKiUrl0j14I4Tpp3H34ZflTsCTkfhdgZtYDpzJe4I4hqFzW3CGS8djmuKg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 04:02:26.5171 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f254176a-b4a8-4351-a8ec-08dedca5b916
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6819
X-Authority-Analysis: v=2.4 cv=f594wuyM c=1 sm=1 tr=0 ts=6a4dcbd5 cx=c_pps
 a=K+v9EGn/BNkpiusdgAbxhA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8
 a=UasPuxbFwKZ-lCVbY-0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: kdVatkz56fSEy1HxizqbzT7U_fPyrqcb
X-Proofpoint-ORIG-GUID: kdVatkz56fSEy1HxizqbzT7U_fPyrqcb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDAzNSBTYWx0ZWRfX1/JDgjbRIzoY
 +CrXMWSNqHho8tb9vpNFJh1K5ZpycWlYmyN9nJe4ipUTkcF3ihQkYlPBoZRtLnObRl7Xi69MOGw
 S/LzLu84k3iI9i/xhFYN7kK4UQMt3Yyq6ucO91nYgAn8CA9B/AyT07Oi3V38zRwWUgdU24+by/a
 Z/5DQcr/iCHQX0NW9+ly/6e95hHqqsY5ncZn40L09vb4T4RFJNzDkKjFMEFDUfsH0wVlMZ4Xs02
 bDSPII4UUc0jvvF/P4oMpWY+nbhoraNFMjO2tYkhXm/1ly9E4+JPCWjHFMBvZjtZIQ0En8QaLBd
 hocMFSw/3cM2S8duHfomF7RLy3eDWEGbCkPeV2L1dFQES6ss6eQD5M8bcTOFWnAGh+7oDjEn+tR
 +Agqle5nCN68YVkZKst+UV/x7Jt/dKBN4+rghoCJXAcynSc+ENYMQyHLnzjoihd1LPfmg8NWeea
 TZVzRQhlrj4XShW+EDg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDAzNSBTYWx0ZWRfX8wTnQa8z4Ef8
 Waq2s38V0FY3XPhEbHp/WO0yG+ORE8O2rtCsGdQCJRtoU5rBNrgE0Re3lX5aAAetYas9qizOs8L
 9ua0nogBpZI6f+R5T9aDGIpwuXV/Jjo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080035
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

On Wed, 01 Jul 2026 13:20:18 +0530, Paresh Bhagat <p-bhagat@ti.com> wrote:
> Fix phandle corruption in fdt_fixup_reserved_memory()
> 
> The original implementation used a delete/recreate approach:
> - Find existing reserved memory node (e.g. tfa@80000000)
> - Delete the entire node with fdt_del_node()
> - Create new node with fdtdec_add_reserved_memory()
> 
> [...]

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Neha Malcom Francis <n-francis@ti.com>
