Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236E7C4451B
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 08:01:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C7DB8460E;
	Mon, 20 Jul 2026 10:01:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="b0y7MNqg";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Z9EOv/Te";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A575380517; Mon, 20 Jul 2026 10:01:53 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B95D847AF
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 10:01:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K6U8i21428036; Mon, 20 Jul 2026 03:01:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=pH4ZF1/SIGpwQy5mdqmFChV4s4NezhHxQ29RX0aLE
 H0=; b=b0y7MNqgslAovvVDZIZa60JiZGZe9raKGGLZMS2tD7vbWYuFTrp9H3VZG
 PybJ9EDldy5cXFFL8xJDDUAvJbiACLt1DM15gaS/Jtgoqg4ndNNPjVXnVkSP5cg+
 ketF8KZShsb160yzlmLjdssT65grcN9Xmg+EJ64yCRuC380/ACtT3VGrsheXXjko
 kfF1mEqjmK3v8lA/6YhqhmhIwo+ad/hC30F3CQOiRLqG+QqQaP/v2SQkEV74LaUJ
 lmLSfm0KmGvrDzHHAmxmWsr2xGBp082jvzBNCXDLCMuL4rjU9FAF8zwiN5CH8XEe
 8qJNAd2QWSxls+rYXZ/sH65/FBhHg==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11013036.outbound.protection.outlook.com
 [40.93.196.36])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fgrmkvvbq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2026 03:01:48 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+P5/tPETgmVGEcz2hxzsjepQjKI7KWnzMLj/NtFSRDeXAxji1IW2Ln6eY9bXSbAwaFF1W9Yr6ADqzc5Bt8Bul68VDNprjjvx65NRj2W/ewM3mTvlpbvXoYRL7szkc7koC/FHxiOJeT6SEg3Jq23Ww2YTrjgM2aLb3q/vVfU31hmfKJUIxYAVjHkWZMau5ig51tU+hF+CfzMKFYqqlwKmKvPqWvhTaZ/4RI+OWzSGs06mt6A6VXVJrxGMHSMyg0pFwuksmAwLM5BLB3ZC+P7kY88jSx2M9MN5W/r73EinhLruXZVQmpEjyq0AVW3s5HdABNbdQ6CBRq+Lmqb4jVEYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pH4ZF1/SIGpwQy5mdqmFChV4s4NezhHxQ29RX0aLEH0=;
 b=v+jBxPh7STmaO3tOt7UsLP+Eu/16I/ATgC6O1fbwq2klzjfQy3CF9GJCiEvr9m88lZXJYqTx8EX/DSkw3zbraGNTpnFYsP8hUS7qkZW9u6OAyodYrwteQMl5d2uao4UH4yDqm+aHREG3FrYeMBS/3JlsiYx2+JtQ0PF8kEVNTY60e03UCVd/qCTfLRHT1jYsIADAbTewEdnLmd6BzSIanjoJvBFsGqg4YlV92I5EqtSYOtcEAV0NlMpKm8rtMv1I4XVvUQimKiuYXS7qshKv+odfw5pKcTpWD6Ru165wK75MQUVulPmhxGpn4ATefrzmz5rcbaFBxhfJ44hO/HFe0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pH4ZF1/SIGpwQy5mdqmFChV4s4NezhHxQ29RX0aLEH0=;
 b=Z9EOv/Te7svREAR+SZjoISANZ8lUOSc0qjWnq/mQmrUixV4BwSielFWWyWQxZ1AjKCB2Zz5cMeVsEwVtHseSuI7HryVrToGtouwtVcq/oD9kC4kPU6vtFfPhLlO8z4JBFTGqWd8t3xcMiNg5qfp3dkr2xdnpeurEJ2IDsXdmbck=
Received: from DS7PR06CA0037.namprd06.prod.outlook.com (2603:10b6:8:54::12) by
 SJ0PR10MB6397.namprd10.prod.outlook.com (2603:10b6:a03:449::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 08:01:43 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:8:54:cafe::53) by DS7PR06CA0037.outlook.office365.com
 (2603:10b6:8:54::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.18 via Frontend Transport; Mon,
 20 Jul 2026 08:01:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Mon, 20 Jul 2026 08:01:42 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 20 Jul
 2026 03:01:42 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 20 Jul
 2026 03:01:41 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 20 Jul 2026 03:01:41 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.50.162])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 66K81FFr2478591; Mon, 20 Jul 2026 03:01:38 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v5 6/7] remoteproc: k3-hsm: Introduce a remoteproc driver for
 K3 HSM core
Date: Mon, 20 Jul 2026 13:31:13 +0530
Message-ID: <20260720080114.775206-7-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720080114.775206-1-b-padhi@ti.com>
References: <20260720080114.775206-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|SJ0PR10MB6397:EE_
X-MS-Office365-Filtering-Correlation-Id: b16bd4fa-56b6-42d2-3531-08dee63522c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|13003099007|10067099003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: bUYJd9t/+cRpZ1Id6zlNVA1g4pOUWfm984H7+6RixTkVG+3KOxo9zLcdDJ+ifcuSf3nI38rJ5329U9kYWzfm1hVacDVS2S5Sg2/TFrdIZS6in/a/ps8h3fzSYZJ3V8PKVLUz/ZykA0IMHtdnHxUNpRkUVkYO7xvY1WBlmtUdpQVoxL0gPOjzq8jRE/9njMb4qJC7oiLx6/d+7gw8+sRdjQJZqqD10rSY7mAhOVt8m6m5/p7hQ/Tbb6UOi6kvko+OluulCXO2VtLpAAjXjznM+SJt0HFp/wjeewPfD6B34w2vLaNN7ylGb6GQrJ3etGUPBLPjPT8iC/G3nQOdT8lxOYOmlK10MfHUoVoVz8edsqmbk1MvLuJIfsQVcyeGeJih/eBzshJ2DkcsRH0w0BEYpmCOmyLRC8oGMkqo3Srtzm6xdTqvHd6CihRxPMnxEUS88w3OwxL0PeAxTOtrsARPR7rV+OVkTQD6Pt8XrJnT9uoaNbmS1Qp7PI1iKpOQi98iyi/aaLg0ZFIMLsagx1cg4dqzjiLYZo9SqZO1O8dGPi0ac5tJKMA45Jrt350kZP/0ZwlpsWbFHTYvsVfd67zUQlxkmp8a8BJuFpouYoQPF0OM6YSmOdU9LLK1KD0SpzlCo9mAT5QX5TeLeyci9ybJ0g==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(13003099007)(10067099003)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jFYilNw1Gr7Djw3o/zLecnd8vUswbqLX0y++TXbxsDBEkX3xl/Klua+TOncoXhpQis+D4KfcXDI7sWZbFqywtcUpm96CdurEeJ5rVtsclPExO2ykQ6BFvEh1hYqwmAtdJO5/zcATbRYHEltMWDLxoQELa/g05eluzYf+B5GdsXkuPsFpQCqaLkHsTK+Z5N6ST71RRkQXIrMRdVGscxQ5zcSFfoNpBtfGSelhF4VY0qAtHkqzcY/aquo1NJpoDINLYiFXgBfbFPMkHLHYEMqWoO8ifAl5K2hjMD2tYCZ8DRkCmpRghDn27POdX4WqeTxWFehQnAnkreqd5SDtPZAIDDHK1ZF+fPr0uyq46h8FoXoH8yubJy/jnr+W8MGBXn+SWGrI5xrZQz8UwxBk+XRn3g7NDRStuc40ZvzT1f0Y4MWE0RwHKu4tpk7+bQXKERIG
X-Exchange-RoutingPolicyChecked: VRWqX6BY0vG6etbe3JWFZPSHakqbShJkYvQTSbiahhBydByXHn/OqkFD7ntusQOFHTKLy+LtAVM1VxG38l1Bh6e+G+8gpv76OTXI73KWnZdgOh0ZwJgpEWAE7jLhmrZvHQI44hOlJ47OWmt/b1VfFU+V/2ZlV7TkPCULVzNQkfD6VHVR8EJyCoyGRbxZCgxp2JMClL9uLd9979faQZ8cL9mxzjIJ2CB2pwoPOI6Ln9jLbWQcjtr03r+8CZqu2JrNLoND2YxEioZfVpuQcFT7mbK103aAArdb6bMNzAGNKprfhQ48XQXHY8fFMXZ9J7OKhY+Lpxi6BMRPRaDRDX7Fbw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 08:01:42.3270 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b16bd4fa-56b6-42d2-3531-08dee63522c3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6397
X-Proofpoint-GUID: NTAx5j8AOa5TsIsEnkT7DlGnLqkvkyfu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA4OCBTYWx0ZWRfX2gFdiu1f1yh5
 JPYh5sjlebx6Ln9A8AmkdkdGCdmi3iaen5LVLNz/20bVpKTVdl5a4Q03tzhOxpk2oCcIiDMIP8n
 UvBrCfudCOknbyRxsKPGuzUE9msC2eg=
X-Proofpoint-ORIG-GUID: NTAx5j8AOa5TsIsEnkT7DlGnLqkvkyfu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA4OCBTYWx0ZWRfXzYNB6l3kRUwJ
 beNTacBwy8TfOWnoR6sbOUuRxtWXJUttZ2jHYlYJoQVQ5siLsLrST/yusCh1W1lbcp/R0A5HbbI
 nA5Uqs7YVxTxsacJp2hrT2/lHLLjXTrj2DrDpUD9LhAbvR9aGssnFrlDAPTiorcoHNv48tPnodB
 WYSIi5anldv8PiKPlwRCI02ZxvgKZWRBd/FI7kbSPqmspKa18sb0NHrWW3+5xkHYxT95Xaj8wvz
 YtLgafIwqcFVZfLAclyFFYpr3IxBGxEiIuLGKZ4z16zlQUZeUmc8b90b4IHTzRtZVb4Xn0mlGeq
 RtumLOOygRjccH3nPvJmuMAj3CoYLZwO1vrc8XWhEQPpSqM+1eFWeHlBHY84V/KDvJssaBibXoS
 WUopc5/ZvcaNitO0oTNqbSxieUAEJ4nl+Pg5OJ9Ky/kN125dzxXS4W8eJhK8ZiRL+/T10Pye8J5
 HLWftRMaaZ18fdu94wg==
X-Authority-Analysis: v=2.4 cv=KIJqylFo c=1 sm=1 tr=0 ts=6a5dd5ec cx=c_pps
 a=vqIpJ22NDJOYTIB/W/KhXg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=cm27Pg_UAAAA:8
 a=7Uu7czuuXSSy5kTXNsoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 phishscore=0 impostorscore=0 clxscore=1011 bulkscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200088
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

Some K3 SoCs like J721S2, J784S4, J722S, AM62X and AM62PX have a HSM
(High Security Module) M4F core in the Wakeup Voltage Domain which could
be used to run secure services like Authentication. Boot flow for HSM M4
core is different than the general purpose M4F cores, and is as below:

1. Request control of HSM M4F remote processor.
2. Assert Reset on the HSM M4F remote processor.
3. For HS devices, Request Secure Entity to Authenticate and Load HSM
   firmware into core's internal SRAM memory region. For GP devices,
   load the unsigned firmware manually.
4. Deassert Reset on the HSM M4F remote processor.
5. Release control of HSM M4F remote processor.

Add a new remoteproc driver to support this boot flow for HSM M4F core.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v5: Changelog:
1. Use get_device_type() to detect device type (GP, HS-FS, HS-SE).
2. Avoid typecasting at certain places.
3. Check buffer size before doing memcpy() for overruns.
4. Add R/B tag.

Link to v4:
https://lore.kernel.org/all/20260425033742.1519298-11-b-padhi@ti.com/

v4: Changelog:
1. None

Link to v3:
https://lore.kernel.org/all/20251231173621.1069988-10-b-padhi@ti.com/

v3: Changelog:
1. New patch. Add a dedicated remoteproc driver to boot HSM core.

 MAINTAINERS                          |   1 +
 drivers/remoteproc/Kconfig           |  10 +
 drivers/remoteproc/Makefile          |   1 +
 drivers/remoteproc/ti_k3_hsm_rproc.c | 267 +++++++++++++++++++++++++++
 4 files changed, 279 insertions(+)
 create mode 100644 drivers/remoteproc/ti_k3_hsm_rproc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 45e9076de67..9528a9cce26 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -823,6 +823,7 @@ F:	drivers/phy/ti-pipe3-phy.c
 F:	drivers/ram/k3*
 F:	drivers/ram/k3*/
 F:	drivers/remoteproc/ipu_rproc.c
+F:	drivers/remoteproc/ti_k3_hsm_rproc.c
 F:	drivers/remoteproc/k3_system_controller.c
 F:	drivers/remoteproc/pruc_rpoc.c
 F:	drivers/remoteproc/ti*
diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 7f9e35283f9..f1e586584f3 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -108,6 +108,16 @@ config REMOTEPROC_TI_K3_M4F
 	  on various TI K3 family of SoCs through the remote processor
 	  framework.
 
+config REMOTEPROC_TI_K3_HSM_M4F
+	bool "TI K3 HSM M4F remoteproc support"
+	select REMOTEPROC
+	depends on ARCH_K3
+	depends on TI_SCI_PROTOCOL
+	help
+	  Say y here to support TI's HSM M4F remote processor subsystems
+	  on various TI K3 family of SoCs through the remote processor
+	  framework.
+
 config REMOTEPROC_TI_K3_R5F
 	bool "TI K3 R5F remoteproc support"
 	select REMOTEPROC
diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index 250915d0de4..5f2127fcb05 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_REMOTEPROC_STM32_COPRO) += stm32_copro.o
 obj-$(CONFIG_REMOTEPROC_TI_K3_ARM64) += ti_k3_arm64_rproc.o
 obj-$(CONFIG_REMOTEPROC_TI_K3_DSP) += ti_k3_dsp_rproc.o
 obj-$(CONFIG_REMOTEPROC_TI_K3_M4F) += ti_k3_m4_rproc.o
+obj-$(CONFIG_REMOTEPROC_TI_K3_HSM_M4F) += ti_k3_hsm_rproc.o
 obj-$(CONFIG_REMOTEPROC_TI_K3_R5F) += ti_k3_r5f_rproc.o
 obj-$(CONFIG_REMOTEPROC_TI_POWER) += ti_power_proc.o
 obj-$(CONFIG_REMOTEPROC_TI_PRU) += pru_rproc.o
diff --git a/drivers/remoteproc/ti_k3_hsm_rproc.c b/drivers/remoteproc/ti_k3_hsm_rproc.c
new file mode 100644
index 00000000000..5e5b880c8d6
--- /dev/null
+++ b/drivers/remoteproc/ti_k3_hsm_rproc.c
@@ -0,0 +1,267 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Texas Instruments' K3 HSM M4 Remoteproc driver
+ *
+ * Copyright (C) 2025 Texas Instruments Incorporated - http://www.ti.com/
+ *	Beleswar Padhi <b-padhi@ti.com>
+ */
+
+#include <cpu_func.h>
+#include <dm.h>
+#include <log.h>
+#include <malloc.h>
+#include <remoteproc.h>
+#include <errno.h>
+#include <asm/io.h>
+#include <dm/device_compat.h>
+#include <linux/err.h>
+#include <linux/sizes.h>
+#include <linux/soc/ti/ti_sci_protocol.h>
+#include "ti_sci_proc.h"
+#include <mach/security.h>
+#include "../../arch/arm/mach-k3/common.h"
+
+#define PROC_BOOT_CTRL_RESET_FLAG_HSM_M4 0x00000001
+
+/**
+ * struct k3_hsm_mem - internal memory structure
+ * @cpu_addr: MPU virtual address of the memory region
+ * @bus_addr: Bus address used to access the memory region
+ * @dev_addr: Device address from remoteproc view
+ * @size: Size of the memory region
+ */
+struct k3_hsm_mem {
+	void __iomem *cpu_addr;
+	phys_addr_t bus_addr;
+	phys_addr_t dev_addr;
+	size_t size;
+};
+
+/**
+ * struct k3_hsm_mem_data - memory definitions for hsm remote core
+ * @name: name for this memory entry
+ * @dev_addr: device address for the memory entry
+ */
+struct k3_hsm_mem_data {
+	const char *name;
+	const u32 dev_addr;
+};
+
+/**
+ * struct k3_hsm_privdata - Structure representing Remote processor data.
+ * @tsp:		Pointer to TISCI proc control handle
+ * @mem:		Array of available memories
+ * @num_mems:		Number of available memories
+ * @total_sram_size:	Total size of available memories
+ */
+struct k3_hsm_privdata {
+	struct ti_sci_proc tsp;
+	struct k3_hsm_mem *mem;
+	int num_mems;
+	size_t total_sram_size;
+};
+
+/**
+ * k3_hsm_load() - Load up the Remote processor image
+ * @dev:	rproc device pointer
+ * @addr:	Address at which image is available
+ * @size:	size of the image
+ *
+ * Return: 0 if all goes good, else appropriate error message.
+ */
+static int k3_hsm_load(struct udevice *dev, ulong addr, ulong size)
+{
+	struct k3_hsm_privdata *hsm = dev_get_priv(dev);
+	void *image_addr = (void *)addr;
+	size_t image_size = size;
+	int ret;
+
+	ret = ti_sci_proc_request(&hsm->tsp);
+	if (ret)
+		return ret;
+
+	ret = ti_sci_proc_set_control(&hsm->tsp,
+				      PROC_BOOT_CTRL_RESET_FLAG_HSM_M4, 0);
+	if (ret)
+		goto proc_release;
+
+	ti_secure_image_post_process(&image_addr, &image_size);
+
+	if (get_device_type() == K3_DEVICE_TYPE_GP) {
+		/* Ensure firmware fits within total HSM SRAM bounds */
+		if (size > hsm->total_sram_size) {
+			dev_err(dev, "Firmware size (%lu) exceeds total SRAM size (%zu)\n",
+				size, hsm->total_sram_size);
+			ret = -EINVAL;
+			goto proc_release;
+		}
+
+		debug("Loading HSM GP binary into SRAM0_0\n");
+		memcpy((void *)hsm->mem[0].cpu_addr, image_addr, size);
+		flush_dcache_range((unsigned long)hsm->mem[0].cpu_addr,
+				   (unsigned long)(hsm->mem[0].cpu_addr + size));
+	}
+
+proc_release:
+	ti_sci_proc_release(&hsm->tsp);
+	return ret;
+}
+
+/**
+ * k3_hsm_start() - Start the remote processor
+ * @dev:	rproc device pointer
+ *
+ * Return: 0 if all went ok, else return appropriate error
+ */
+static int k3_hsm_start(struct udevice *dev)
+{
+	struct k3_hsm_privdata *hsm = dev_get_priv(dev);
+	int ret;
+
+	ret = ti_sci_proc_request(&hsm->tsp);
+	if (ret)
+		return ret;
+
+	ret = ti_sci_proc_set_control(&hsm->tsp, 0,
+				      PROC_BOOT_CTRL_RESET_FLAG_HSM_M4);
+
+	ti_sci_proc_release(&hsm->tsp);
+
+	return ret;
+}
+
+static int k3_hsm_stop(struct udevice *dev)
+{
+	struct k3_hsm_privdata *hsm = dev_get_priv(dev);
+	int ret;
+
+	ret = ti_sci_proc_request(&hsm->tsp);
+	if (ret)
+		return ret;
+
+	ret = ti_sci_proc_set_control(&hsm->tsp,
+				      PROC_BOOT_CTRL_RESET_FLAG_HSM_M4, 0);
+
+	ti_sci_proc_release(&hsm->tsp);
+
+	return ret;
+}
+
+static const struct dm_rproc_ops k3_hsm_ops = {
+	.load = k3_hsm_load,
+	.start = k3_hsm_start,
+	.stop = k3_hsm_stop,
+};
+
+static int ti_sci_proc_of_to_priv(struct udevice *dev, struct ti_sci_proc *tsp)
+{
+	u32 ids[2];
+	int ret;
+
+	tsp->sci = ti_sci_get_by_phandle(dev, "ti,sci");
+	if (IS_ERR(tsp->sci)) {
+		dev_err(dev, "ti_sci get failed: %ld\n", PTR_ERR(tsp->sci));
+		return PTR_ERR(tsp->sci);
+	}
+
+	ret = dev_read_u32_array(dev, "ti,sci-proc-ids", ids, 2);
+	if (ret) {
+		dev_err(dev, "Proc IDs not populated %d\n", ret);
+		return ret;
+	}
+
+	tsp->ops = &tsp->sci->ops.proc_ops;
+	tsp->proc_id = ids[0];
+	tsp->host_id = ids[1];
+	tsp->dev_id = dev_read_u32_default(dev, "ti,sci-dev-id",
+					   TI_SCI_RESOURCE_NULL);
+	if (tsp->dev_id == TI_SCI_RESOURCE_NULL) {
+		dev_err(dev, "Device ID not populated\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static const struct k3_hsm_mem_data hsm_mems[] = {
+	{ .name = "sram0_0", .dev_addr = 0x0 },
+	{ .name = "sram0_1", .dev_addr = 0x20000 },
+	{ .name = "sram1",   .dev_addr = 0x30000 },
+};
+
+static int k3_hsm_of_get_memories(struct udevice *dev)
+{
+	struct k3_hsm_privdata *hsm = dev_get_priv(dev);
+	int i;
+
+	hsm->num_mems = ARRAY_SIZE(hsm_mems);
+	hsm->mem = calloc(hsm->num_mems, sizeof(*hsm->mem));
+	if (!hsm->mem)
+		return -ENOMEM;
+
+	for (i = 0; i < hsm->num_mems; i++) {
+		hsm->mem[i].bus_addr = dev_read_addr_size_name(dev,
+							       hsm_mems[i].name,
+							       (fdt_addr_t *)&hsm->mem[i].size);
+		if (hsm->mem[i].bus_addr == FDT_ADDR_T_NONE) {
+			dev_err(dev, "%s bus address not found\n",
+				hsm_mems[i].name);
+			return -EINVAL;
+		}
+		hsm->mem[i].cpu_addr = map_physmem(hsm->mem[i].bus_addr,
+						   hsm->mem[i].size,
+						   MAP_NOCACHE);
+		hsm->mem[i].dev_addr = hsm_mems[i].dev_addr;
+		hsm->total_sram_size += hsm->mem[i].size;
+	}
+
+	return 0;
+}
+
+/**
+ * k3_hsm_probe() - Basic probe
+ * @dev:	corresponding k3 remote processor device
+ *
+ * Return: 0 if all goes good, else appropriate error message.
+ */
+static int k3_hsm_probe(struct udevice *dev)
+{
+	struct k3_hsm_privdata *hsm;
+	int ret;
+
+	hsm = dev_get_priv(dev);
+
+	ret = ti_sci_proc_of_to_priv(dev, &hsm->tsp);
+	if (ret)
+		return ret;
+
+	ret = k3_hsm_of_get_memories(dev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int k3_hsm_remove(struct udevice *dev)
+{
+	struct k3_hsm_privdata *hsm = dev_get_priv(dev);
+
+	free(hsm->mem);
+
+	return 0;
+}
+
+static const struct udevice_id k3_hsm_ids[] = {
+	{ .compatible = "ti,hsm-m4fss" },
+	{}
+};
+
+U_BOOT_DRIVER(k3_hsm) = {
+	.name = "k3_hsm",
+	.of_match = k3_hsm_ids,
+	.id = UCLASS_REMOTEPROC,
+	.ops = &k3_hsm_ops,
+	.probe = k3_hsm_probe,
+	.remove = k3_hsm_remove,
+	.priv_auto = sizeof(struct k3_hsm_privdata),
+};
-- 
2.34.1

