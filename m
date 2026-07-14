Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEC7C43458
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 11:05:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5C8984CEC;
	Tue, 14 Jul 2026 13:05:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Avsi3NfP";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="loYjKCdv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E73884CEC; Tue, 14 Jul 2026 13:05:26 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA14384AED
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 13:05:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66E6UVNV1524544;
 Tue, 14 Jul 2026 06:05:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=SwbMnIhOWCaWUoJXLKXdPZWfkfeIHWulYUvJuAVSu
 qc=; b=Avsi3NfP7P4ldXklC0PhkhO428mtg6Vcs5r+4dIlPZT7v0PvgtTBb1Opc
 44Xoa/CeGvQQVT3oy2a/DL5lUbXRgZCI51mceGuUtJvGy6MywSsP4ILL8cumNb43
 RWtKeanvdme+pFr30vDvKzbVZ/mWJFBy8V8cpd4hWXLZi4Gwyga/xmQ0CctmADGF
 nbvfmPGihjQF8Dzt7bJ4TY/8PRzAOMPabopY2yiA6wBNtMmHjFkjUVh1Gw+22CFn
 8hlQaxH8Sg5zSW065fhPNG7vo6oU/c7jruLeCdpo/qRCS2KheU+gpWQJrqFCzpiX
 1p8HGa2d9GGYtr9LCXbbCZ6Ggnbqg==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11013000.outbound.protection.outlook.com
 [40.93.196.0])
 by m0380145.ppops.net (PPS) with ESMTPS id 4fdcw5a2bn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 06:05:19 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GkT20D2eXtxM9zPCCqkvWbGNQ/zS+Q9GHnMVF8w4kTd+T3ygn7MMgOVV55uaj2g+yFudmrvYai/bnMnEDf0Icphmxr9BGYTVXR+wSuheLjT/Wxtmamzs3/xb1Vtvr/TGrtTlLnHLxFJF+Z+XzIU6lOSaLnquSoSPUjHBYNRMMEgOU4Qso/5ucWyj1qFQU/u7U7VJGN/tKFelqC5UQq3nG83leIgdn/ukH+HTqE7Inb/pc0H0I2DJPuopN8wsG+w4hGsk0RsA8ahsapPLMcQqh1nx/uCkZpjVhYry/bhU5L7dpK+coUAzdBngrslkb9OoUmYjLsnPDpcxy6dnzpFhCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwbMnIhOWCaWUoJXLKXdPZWfkfeIHWulYUvJuAVSuqc=;
 b=c7QRc4/Y/JIUrgiIYcDwRp7Y34SdYwxYbybpqYYhKlRus8BJpxHP34uXABK+JUNa89Mwlxel75o+fUrKVh+7gNETXc7ST3wF6dow1SW2Twg0iWhTcszRqZLrl0Wfqy4EmtEC7LKfRidS2022rzhumyfjCyV3XX1cQTOpJyAlhK/d4TRCHA9e1gByVKCsZkOUjQeJ1J5OS78Y+MspZWMgQLEz28WdkgD7u8GMny5MAcJpVYRN9jVmNYMLfuSdHcJj69mUdafeUejnFhNXoKaLgPnpoqU5DmZDABQDJ+mpL/1tIshortsESyyLGsJWUf03eWbyuc5Kl5HVxUtDfiHCZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwbMnIhOWCaWUoJXLKXdPZWfkfeIHWulYUvJuAVSuqc=;
 b=loYjKCdv3lS2Ejn/PzjVGfkJx9JxkpsSEliEdty4WeAqkpdnW+rAhKOp70HuSqlCO7N0mCdzLoVSOYuHg9vvkOJkTYQ5YZuGDp93Psss9BQ8YyIcd0mOfH7OCoSSyXUgMa/VNQTBmXfLRbz2inmIS45uuDzNCAtY1ApfBPist64=
Received: from PH8P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::11)
 by CHAPR10MB997696.namprd10.prod.outlook.com (2603:10b6:610:2f5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Tue, 14 Jul
 2026 11:05:16 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:510:345:cafe::98) by PH8P220CA0010.outlook.office365.com
 (2603:10b6:510:345::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Tue,
 14 Jul 2026 11:05:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 11:05:15 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 14 Jul
 2026 06:05:13 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 14 Jul
 2026 06:05:13 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 14 Jul 2026 06:05:13 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66EB5CJ13983835;
 Tue, 14 Jul 2026 06:05:12 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/3] configs: am62ax_evm_r5_ethboot: Enable config
 options required for Ethernet boot
From: Anshul Dalal <anshuld@ti.com>
To: Chintan Vankar <c-vankar@ti.com>
CC: Andrew Davis <afd@ti.com>, Bryan Brattlof <bb@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, Anshul Dalal <anshuld@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
In-Reply-To: <20260710102229.2980029-2-c-vankar@ti.com>
References: <20260710102229.2980029-1-c-vankar@ti.com>
 <20260710102229.2980029-2-c-vankar@ti.com>
Date: Tue, 14 Jul 2026 16:35:08 +0530
Message-ID: <178402710825.246195.801934357937492160.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784027109; l=650;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=WI43HKTwIU7yZ3wj5SldxS3uxEyIrGF3ltmCw5SpFwk=;
 b=+RrrwAyIVCWKuhmD3Qnqn/a6L1NS0VMFjj9JX4iUgsGBTl62Uqtv6g2hpxThtyrCnov+oBsJn
 x+Gq0pbJk3WCwDuS70dPzTXGjnjQUVl8plJbf8nSNXZ8GejnR/C9mLJ
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|CHAPR10MB997696:EE_
X-MS-Office365-Filtering-Correlation-Id: d0019f89-edf1-4887-4023-08dee197c877
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Wb08pgSsX6hk2ObR/ttec8Y9IBeiqBWEpSKli/TLJva0YDSpyQNle5zW93nWLKeVlNUiCxSC2EzSPb2tQ2UkRYlr+o+w/skxBTtpLJCvkMef5Z+QD4BfePwKJELnSfDODO8QKr20p57t1P64a4c1up4+/sj0Mr4DTiN0wZqQPPZlc7osNtyZRg/LU/M8m5nKHMlIn8wOfKc7rs+lF4OiXrFZfrVWM0DlxPrcgC5sVBMExnLP2OP+KtJpa/W+oDjPLXDF+1Sdzgkoj0BrdByjRBlJeGKide9etpc31qvvzF6bQAaeMb1Zv3rwiL64p2OF599aBJlMoYFSh10QRuNzGw9vlmR05t68ShMtuwF2WkKu8iXyUPoHiD2hvQvGoTKqoNgErdntFvTzGneUXG3Srxthc1Kfs9ESoz/Ja3+DLwfw/Wi9qO7BIptiDHCKvZVWYvBJFwKCJNZu+kSdq+gK0UIkzZ2P6u1oismhIuNXVzgxyPAjcv7iYjXJweA5iVRMisRn9HTTI8TFhc7AFNv9q6EkRuWbh7tgNZcNhwXHBzKriXHErSPWuDfTpRf9vvlktveoAOgwh3kRaPWXV7NNqTVNKf/nzNmPQjWspSeCBXI7xagu9ZDT0rOpl6iyf172eqiHhC+7k2P05u8f8npUKDJfAHfW8+z6CFYnaV5BVNjMzyFiNtqPpqpxLjZ09C84QjPKuiqvporJrkjHFNdDFg==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ALGsD0hgVWVxTXX0dFvAZkiYSWymxJAI/r2wphLzYmsZwSljlz2IOS951lhbMjNAUV0mhCHK1zYQDlluT2Q9r1NyllEtN972YAHaJLtPhhB5oFoLO7gZCyYPVOSL7Kk/cl5H9AaMt3Hykab5Ceowo6hvmZvN6xkY+yHnY2svL0TQ2yEjW27vi1MWOsHNVw+K58FUq/99bT/+dhbkyp8o/KGabfOTpEPtp/OFpQ67Mw9WWOGWEgxpg72pSoPIDHmUZsCCZTTAlB2iw9X80B90gZ6oVzx4dvP2uOwi9Dqd2DaVL5VnHGsECUK02g6BbCzAnoGr9vJQppX87jRmoP6xZ6zM38ecxnsTmcYLBaJNWJGirbl+3AvYci7FPG/rdLqbJqvqF1U+0ovG6pVH6z8/aRwz4mGB/ZkbMkA5PVs1nvWy7vAjGTTeyEKhfR6/IwIU
X-Exchange-RoutingPolicyChecked: TXN02ZvPKh/HtJisFy1ZepN1D3oBygg+mAYSFvU32euMwfnwNPwFIpub/2tMRbKgX9/HeM26qSflmvdKx0Uh5CUyDVXwyBUNEDCVXNHVlP3r4ALKafP/s5uRvU+YncdzyKc2CtszGCBPbfckPhVnvrIH/HU6gLFtcY132/eulPt6lHQ2e21duaVcq6weq18HoBfA/DQ51SjbUK4KlsPhozKFz5Vy1nPJn9t1ftdOvi/Ul952JzpRYFQskdeSU4jWznpcAVHohxux1znFAaT98p3n6iX0bKVIXtu2Uxcbkeza1PQeUHQB/JIo4+Sf7XdB1/MhFFIBLv3fIiypuu0iVg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 11:05:15.1119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0019f89-edf1-4887-4023-08dee197c877
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR10MB997696
X-Proofpoint-GUID: 3uc8VqjfYVOfsdzlWovn5oCV0U5T1eui
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDExNSBTYWx0ZWRfX/vcBi2d8U+D1
 T/ZDtk/AcEe+jNpD+eGdPCLNJLDgX3Akhucrk7GrJUoduLcblsyAGAMAYNa4kmtMRWSR02YtH+L
 pB7kQ92sJZ4js/qFsYEnOheS+VPuyiI=
X-Proofpoint-ORIG-GUID: 3uc8VqjfYVOfsdzlWovn5oCV0U5T1eui
X-Authority-Analysis: v=2.4 cv=Ir8utr/g c=1 sm=1 tr=0 ts=6a5617ef cx=c_pps
 a=9AjoWhdl+q7f6/Aw5qa/DQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8
 a=AupYsw9dfYiDXhegs-YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDExNSBTYWx0ZWRfX/aHZIcd85pUx
 Oj0r6bXrRXZpwIpJ6HDb6Yg0YiA3c/VljM7QDf93ExN9INjA1MDZQUJjYHsBVfri1ig3P2qDgI+
 jTGYvoBZnVVyfdQ+AV9sM8MZLdHrIec7crs1QCpCugA6XXniV9CmWAy+XNJj8GgmtGsQgff8UWl
 OX0bkAkEEOYSZUnBARDqeUoOp9C1Abs9o4aSUvem7iU3ggLT2CwDkhVmEV2jOBFWjC6yQGzKEHg
 D8a+gMy5aFR7VoGfDlygdxfxIhaKv5N/DRTr5dnb343naGWtdyZhJzOYpAtijkXhzl+bjSklDxq
 Qc8g5PHomfSw8iwI3aeF+OoyW0wD7jffsyKFCWTs/DJQ0ICEOcA5csZYsPeRKKoiVHLaguaBN7g
 KNjJFC0MtZnb5yFuKpclsbh3aDuix8iO1SlcOQkeYXX6fHOq90o9D4UFYs+hHqw6x4KTp/z7t2Q
 o6mrN503WIf/NuS/8LQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140115
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

On Fri, 10 Jul 2026 15:52:27 +0530, Chintan Vankar <c-vankar@ti.com> wrote:
> diff --git a/configs/am62ax_evm_r5_ethboot_defconfig b/configs/am62ax_evm_r5_ethboot_defconfig
> new file mode 100644
> index 000000000000..2986feef29a5
> --- /dev/null
> +++ b/configs/am62ax_evm_r5_ethboot_defconfig
> @@ -0,0 +1,22 @@
> +#include <configs/am62ax_evm_r5_defconfig>
> +
> +# CONFIG_NO_NET is not set
> +CONFIG_SPL_GPIO=y
> +CONFIG_SPL_MMC=n
> +CONFIG_SPL_BOARD_INIT=y

We already enable SPL_BOARD_INIT for the r5 and a53 defconfigs, rest looks good
to me.

Reviewed-by: Anshul Dalal <anshuld@ti.com>

-- 
Anshul Dalal <anshuld@ti.com>
