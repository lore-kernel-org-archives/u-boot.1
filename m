Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ACAAC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 08:13:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8EC684CC1;
	Thu,  2 Jul 2026 10:13:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kbeZgeQn";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dj3U8P04";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 360FB84C85; Thu,  2 Jul 2026 10:13:03 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A376184C85
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 10:12:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6623D9ml1285542; Thu, 2 Jul 2026 03:12:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=1YpJHsf6NkerW
 /Ca1Tr0Hpfem1BgCiM410/DewacVbI=; b=kbeZgeQn9hZlaCDda+uA/3ojhnk+e
 qlyhVxj8eXI7Q+xL6tNqU1fuO2KKXpIg+Yl6D8tZAjYqsc76E0tDTNJ/vo/d8kwB
 dQIBSTLewxTbjk/BFjmp/xKGbgJP7CCzB6fZxQQvZ39BRRV9ZzD7TqHR/2kxyX0a
 Aek/x99Llz7qTl9a2AGd/GwxLLftE1IzQdprp6TFpkMyQKVmDrWSU6sLu9e3/ArC
 +KWWHksYYfmGQ+ZhdH09jOfwqcVGhDFYOptYnnch9uIW6SnNmKv/57+g+1qGIirJ
 FiufuT9U1kzy+RKgUWuWm0Illgv2hTUdhK6sn96k7w23ACz3O7+oYmUrQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012044.outbound.protection.outlook.com [52.101.43.44])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f5fvyhe19-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 03:12:57 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B4EAXkYwMzCZxqaBYUkUyBXa6caJmYWZWr3RXQ8g60p3BAK7RU8nd9JH21svpmNZ7Dk7VQRBnXqse7f9hNEoFlOCH/ykG382d7nQaf04B1fOCBDWktm+eEpx2Vvkpf9xdyhsIauF+6iyQt/AqdcBXCaIBBvirqk4Xm+o6t3QQOzSJNQWnJYpbyJfz87RAJdN0tSkbZPN30jpJgfoWwrwduYnnNnN+M8SA17l/4QeTw80wId3l74oc/3aqiRFLplTUNEtY7l7m8A0RaznFhGmSyQ5+myu7ykyyhkWWN7XAAfEecySUDhGhj7Px7GPEaTonHJsNz0KZ5C9cTy9qMyTcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YpJHsf6NkerW/Ca1Tr0Hpfem1BgCiM410/DewacVbI=;
 b=fDKSkCkSBiCvQVPzn5dhxz3Hv/TgvO1FDzlbx4lbeOnobLXNSiAw/HHw8wPNkrJdd63ZL0wlBmyUITZUoNOezjMdywCjBNUtO450xHL+d8xFSDkuT1oG5U4ykf0b53wj94ghmndqtjYPR3m86c7J5zocWT9yWlxc+/yXfIpXH8W+c+8c0za4IGyFzZ0xlJrGQjMreHIMC1BmIYCDdpWJQngoao+VldoHXbbaggQ0Uk6poM+/m6pxdXCiBunC0ahpDzl3vpxhSTQemMejJeRaX5pWHUM2Zptaixk0SIN/5kLvNb9t8q6PPsb7YKX25bGyuCleWYwZ+GiK6oGs8ZjnZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YpJHsf6NkerW/Ca1Tr0Hpfem1BgCiM410/DewacVbI=;
 b=dj3U8P04iM+TsYmNRnooMce1rAGDPSt4eBqDULo2Vz2z/Z17Hc47QE+mZimMDTXLil2Y6eop9K3IpjdBKOalC2eFBHM2bALIkTkuZ7o2s5V6I10BpFMlGp9vzz/AM86pdzoYrZFijaA/bLO82Ek0kdQBtoeod8hBH3vdY6Abx74=
Received: from CH0PR03CA0007.namprd03.prod.outlook.com (2603:10b6:610:b0::12)
 by MN6PR10MB8165.namprd10.prod.outlook.com (2603:10b6:208:4fc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 08:12:55 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:610:b0:cafe::f) by CH0PR03CA0007.outlook.office365.com
 (2603:10b6:610:b0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Thu, 2
 Jul 2026 08:12:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.0 via Frontend Transport; Thu, 2 Jul 2026 08:12:55 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 2 Jul
 2026 03:12:54 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 2 Jul
 2026 03:12:54 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 2 Jul 2026 03:12:54 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.231.164])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6628CrlW2889344;
 Thu, 2 Jul 2026 03:12:54 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Andrew Davis <afd@ti.com>, Bryan Brattlof <bb@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, Chintan Vankar <c-vankar@ti.com>, Anshul Dalal
 <anshuld@ti.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH 0/3] Enable Ethernet boot on SK-AM62A-LP
Date: Thu, 2 Jul 2026 13:42:48 +0530
Message-ID: <20260702081251.2691159-1-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|MN6PR10MB8165:EE_
X-MS-Office365-Filtering-Correlation-Id: 92d98062-077e-4c39-d61a-08ded811b870
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|13003099007|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: A6ldRWwoihwI01k4vITQAWGRmvgpkdKShM94ZspsSR1wFWTTbdtZvEdhYzuEikb5rk0Y0syumX+mt/KCQNvgTVoJBLzSXPVeAkH6wmVpNn4ZWncf5uC48iZXWnCIn7uR5o0fpqFNz0aNce/J2x6iEfZg90xaC82QX1WosiownEPfOfUlXgjajkbxV0D27W4s7/5ZsfZaRUn4iS0xfDXeJlwx94nBh8DFZE05NtL7y4uVRpJxh4zve03cZB6sIUU13zNVy3dgHNKDmYUtryN4sjRSNchv0rYcIpWkK4TXL8blgGGxf3Yn/y4bVxvCRtn+Klx/dvrMX3/xKMpqz6EnlXQyCzXFxEuOUI6eaGFA30ZRhHT/oXgXlKMIvryZwBtMd6B+CpK0k6s+UJnCGSmq/Ylac/8HqF8GFzV+UCq156V9kBvMBPhJAyeJsJNCHAkO7+GwZj3G4E3ZevHfpf4dOBaZxnJai/wAbqoagAR7Ff//2PEZfETIbcFO3+LLpKIStaQRz3lrd3d5gj/kilT7ukyA4hFKFh8d4D8HSip2SgG0+oacDjJmZ2iCu0k1DA9mZsIF63LIkxxnZHwRLlJzNCWNUhTSXPi6gNAYIrDA+mfKp2Ydg0vzUmE6JVgUYG37W/v86gSE6Pe1xHBnJzrZiCpGYc0axEEW/FZsbOPS4O3uJ7SE+yVFphB9fsX/uIi1j+eaRyHGRccV6/z6gOb6tQ==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(13003099007)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XBIo7dr4yuqjf5rd5NFeVfbGvPg6S6uz7hC7AYh6cD1I9otiAOJBv0I6FNes72GZdkD8W+AD+2KP8GO3747xeXZ3R6J61TXBWCU86Y5TWTz4fp3///RR6/hbHzD7xtrm241ZVQgxUOsV507JiIrqaK+zX2ArMjxb99zBZlmBkQk/ljvNBYN5zN/5YBNBORM4W/oaCIZNE0+7Ke6bJSI+Y1eavmB2JM+k2jeAF16ww5xEe0yCTBo81HQqGDFQRbe/bVh/zONbhNNI53ZPa7gnEfVSylk/9bHL5lgDevwKG5sofu9fmZCegt30P1+pKFh4evDsCRYDux40HhSmREihhrRHvCZTVeij+c4kzEq8tEfB34VFmd6FODmyJkFhk0IX25bI/SxaLs5LITyDyQkXjgqe9qH7CSoLHcqW1GReawlHIsMT9XP2p+7p3WJrGN64
X-Exchange-RoutingPolicyChecked: ZwNsBeFaV7GkH0S8oBXqC+eDTFIeMWoDxYyPHWvTpkVbYlv4FOX66iszaPi4XpazhSOSYlMYoqMxRDaaxAObg9up7KPbuFRCgJ7cy9aiHrCXup0vONiONIPGNEJSGRe62o3VVrENtVgNmFsQ/3DDYCpNkbtLRDWaqOO+m30VHgStJdJZvDyfOt2tCrZ06xJyqBUNrUFbAhCaBlTA6pZ8wp+cRfl/UneHyzKnoGneVucLGA2b+NcQusXdMQYaCIJgDY+NN57Edt2MtpetS5QsqbOrGxYbmCt4IjUcemCyu8+2Hc9tOXgnG3Q28HtSrZ3d1TYdv3RKrmQhSU4kyssXIg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 08:12:55.2655 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d98062-077e-4c39-d61a-08ded811b870
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8165
X-Proofpoint-ORIG-GUID: p7UPPEfSaGXGLKNmuM5zy0ynxHbZEOtg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA4MyBTYWx0ZWRfX+Bk+4np+vRpv
 be2SztQTBJquw7KQztkOqF2KLc5+2h0kg5OIRfHbe7PgGwKUEtiMV8wMthkZ2vX5WGlUW05mGu6
 NyCr2QcqYP192HT52VhPGRx/82ijK+BtcZkJm1GlPPVr8BKtEFlOQyJOPVgzsjU10+ctyWNlpvo
 G6QNuzY4HTr5JMznsDDkQTJDv1OmftUD7uCpF0p5qJDCoMagCXAmxobsIJZ5K275SaK5z4suuYn
 QiZF1mrADYYgcq9ek2kHQ6gugf2mCuk4HT0fcTXVWplXvBKSopNrmmJW+0zMHkZKTIphPbT965c
 UPu9oA4omcrMBawrALs0qkI7mNDmQiKVfDEc5FnzF1Lre3/0kS1pbjMG/2EvwTXG/UINiD6HH1D
 8vKKNiX1ccfCd2pOt14gkqjHz+Ihl00/UmQsBF8oHHQPp9jpb4lwO9LUri27JFm71D+d+Twf3eF
 HK5PqD4oMqn3byLROnw==
X-Proofpoint-GUID: p7UPPEfSaGXGLKNmuM5zy0ynxHbZEOtg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA4MyBTYWx0ZWRfX07axpWXq2/kQ
 V209Rv3d/23nNU2SWornH+v0W/rM9V3NxJvAL0GuLwIjsapWFITNvPUNHurwzn1kMNA621bqJIv
 9dMSeNja775cKn7UBOtaVFA/nzi+z3Q=
X-Authority-Analysis: v=2.4 cv=T+q8ifKQ c=1 sm=1 tr=0 ts=6a461d89 cx=c_pps
 a=JJOFz727VvkGy7wKLfv01w==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=fdwQ3TzUzb8g6BDI8vUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607020083
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

This series enables Ethernet boot on SK-AM62A-LP. The series is based on
commit 'e800cc67f5b6' of origin/next branch of U-Boot repo.

Logs:
https://gist.github.com/chintan013/b31f9111decfbc55303a605cd2f77dcc

The functionality can be verified after U-Boot DT is synced with the
Linux DT with the patch:
https://lore.kernel.org/r/20260625113223.1711052-1-c-vankar@ti.com/
which doesn't have any open comments.

Chintan Vankar (3):
  configs: am62ax_evm_r5_ethboot: Enable config options required for
    Ethernet boot
  configs: am62ax_evm_a53_ethboot: Enable config options required to
    enable Ethernet boot
  arm: dts: k3-am62a7-sk-u-boot: Enable DM services for main_pktdma

 arch/arm/dts/k3-am62a7-r5-sk.dts         |  5 +++++
 configs/am62ax_evm_a53_ethboot_defconfig | 16 ++++++++++++++
 configs/am62ax_evm_r5_ethboot_defconfig  | 27 ++++++++++++++++++++++++
 3 files changed, 48 insertions(+)
 create mode 100644 configs/am62ax_evm_a53_ethboot_defconfig
 create mode 100644 configs/am62ax_evm_r5_ethboot_defconfig

-- 
2.34.1

