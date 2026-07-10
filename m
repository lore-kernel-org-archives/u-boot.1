Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2980C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 10:23:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3514884A4C;
	Fri, 10 Jul 2026 12:22:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="m49X3c6p";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cO2T4IVJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F31984A49; Fri, 10 Jul 2026 12:22:50 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 382DC8496E
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 12:22:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66A83s0V2275440;
 Fri, 10 Jul 2026 05:22:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=EiQrneDtHk11V
 qiUuHRQiNaVG5w1MBaXlPhKzhR2kOw=; b=m49X3c6pZ6JqQnIG6r80AwgyjChlF
 TGNgokywKFtKy64isGpBm9HAkJ7AgxOeHTPtsAmK0Wm+0M9rVd7T6YfCQVlwlABs
 VrGvUqb1lsO5g25d6NLpVeGljrbIj9b8e09F1Oion5FGp+gCwo6DJZB9kup8ekp8
 5/4kiYqIFjUi1eoJVelxwMR4YMYxl+PCFYGZzAXQvnM9cdcrvb/gXCGwHZgj7RfG
 ZpOyE0QoxGYKOYbK2STBvZ809HFDrPswKcSoqIHcXIX9sEkTjdRHCVkM6qDF7+bq
 Vtm1BdLm0VhQUGyPVJElkz4R602zh/ypBgbzelGxvfI2CMoSnzNi0gwAQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011066.outbound.protection.outlook.com [52.101.52.66])
 by m0384305.ppops.net (PPS) with ESMTPS id 4fadx0ns8v-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 10 Jul 2026 05:22:44 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aVjXHNi99zZuuEpU5/8i3WbspJeijbL78tskICEbpAahGaLbs0/z8grav1fs/cTxu/+9warKuuMuivODY2Vk2AyxtChiUvTNQBswkv+zY0EzA9J4MCa/TXaktfk3qmAKA64RWQWBz/WAZPBipkiRlp89CI1iH7rl7zlXNEjL5zqFYE4a0XnSkj5aFUSBklXWc4woSPrefCCcyBbxdSL7ckbnf6mE8AvdR4x4RRT742utIAspOEB0DX5ycUMZlrTPx6VLFZbVBujeweUSSGO+8M4/NDHXxrv0EG6f6Ynn42u9Gu6IDKCLlPKrR+mjtS080+KBPbKoVgTAk3joLoqejg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EiQrneDtHk11VqiUuHRQiNaVG5w1MBaXlPhKzhR2kOw=;
 b=wRwA4bJsFhzrEsfrdpAA0dMx07/hjSw0dWjb9mt9b9S2Rb38LlFxD+E1gPkEljVTVI9uH8VOlmQnctkZXV1z/MgNEiBHA40XdHLDNU8dlNsaix8w5zs2A+xmN+2kFALS7A3GYLcwB/yFgVF2vbP8/hRkhIVw6/4dzMGQ8whznZbnOmucaTZ471mCW0W/eqg/0ZhOF9CQSnCi3ijicVhx3KpGjP+FI7WQ6hIc1qcX7HAMGn0JOOXr4nJfPPzhml7g/MBYbp4FmEShOuULJektppRu3q4felO/8s1df35N6Y1ItgnWrsjcKGgMpX8Mpmi2Rs0gNLDn/4pGp2v+mQtBEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EiQrneDtHk11VqiUuHRQiNaVG5w1MBaXlPhKzhR2kOw=;
 b=cO2T4IVJymW3AmhYpdRwwCUa8oVQ8U5PJZu9iS+aICuDkp6Glt+hN7QwJbAiTdtk9ZHe/enpgB928AHlih41Z3lfw8FqMtsyg4LpZP+fBtQBRsFS6IY+XxSYkrAyOx/BBNHG8pxAs2HXZ42gO5oCXtLvx/lvc2ErGNQvlv8nDJs=
Received: from MW4PR04CA0132.namprd04.prod.outlook.com (2603:10b6:303:84::17)
 by IA1PR10MB6196.namprd10.prod.outlook.com (2603:10b6:208:3a4::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 10 Jul
 2026 10:22:38 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:303:84:cafe::3b) by MW4PR04CA0132.outlook.office365.com
 (2603:10b6:303:84::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.13 via Frontend Transport; Fri,
 10 Jul 2026 10:22:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 10 Jul 2026 10:22:37 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 10 Jul
 2026 05:22:32 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 10 Jul
 2026 05:22:32 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 10 Jul 2026 05:22:32 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.231.164])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66AAMUuW2871360;
 Fri, 10 Jul 2026 05:22:31 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Andrew Davis <afd@ti.com>, Bryan Brattlof <bb@ti.com>, Chintan Vankar
 <c-vankar@ti.com>, Wadim Egorov <w.egorov@phytec.de>, Anshul Dalal
 <anshuld@ti.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v2 0/3] Enable Ethernet boot on SK-AM62A-LP
Date: Fri, 10 Jul 2026 15:52:26 +0530
Message-ID: <20260710102229.2980029-1-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|IA1PR10MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: 57d721f6-5e65-4b62-58f5-08dede6d2a18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|13003099007|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: FnfXn9fw4B4eFG5Bu/3lNQqEzh8GPKO5F+o2pZyDEG+yJgf45KOS6Qt2zzGffam9uu9D+4uTFX6E15tbuScHaXceIGilbZS6z9kHopzqYSHz00HlZiALV4Q9tGGcD1IRlpiVnAFG5+HlBx1m1n0tuc32Pcp0smrUO4qskIlBj/o0nrmqbSv1AGby0Y7PGhgLH3KPyJAV4J8p7rBRfYURU4OG903B4Y4EcHp4j8rDMCmcHvkL7mjv//4FKFX6y3iMy+n/6DVylm/WrXb/hdKgiY/RsJSv8ivrPDh6DI+yy9eErU7AAlSO1OQVS1ckfWLMQa209bgqP63GJLtRAQWmLjKHG/+9IZe8Oi3XGkOzcTB3lkadoh6m6eaIQgyKgV+/VyZWm+0mumrM1zQBc5IzUZBD40JJ54jMQ31npeqD/mWJ6GEO4di6hyPiw9zqnxGguPzN+xEs8JZM093iO5C1afIUyntAIm5r9SxgGQPP99MUX2PKiuQTjvvsEzD4VWCBDmtZ866EETa41Gp+NksFZd/tsAa2jsqbKseyPki6mISi294lSAbfX8QX2txRmWGHH9NY5PdyKV/FLafjm6YIGCNGOA3CEW4r4zQPOKcKX6GsThwwezYSwOjkjLmpBmPs6tE2J0durRCIFP3UL8PRKjU3gY26QdmtA/OfzahYuabeHvApiAlJ/2hJI4uamqVgec6hNRMOq4s/nahvV4Xkuw==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(13003099007)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DipQsuzihPqWmRdVkmm2FA/ncfsqyXM9pfDo54EM78cn/oXkcNMcJ7GUSIEk6P320m7h9KOJHvPiTA31ONT12P1JLbCUlIuRYFkXPpiddceSVDAvv4NrZCtL1pUJ8624WTU/m/230ZmKEGTB18Hb6/2y2VUTqayQ46g9MSUP4COybqkOyGllIFFJ565JS/kr/y+KLTStLFd2rmBdgH+OEDCuNy+Moamkeq3/B+L9099/K5s8km9ua/AUg9Vy5a5ny5PVA4+IWF52q+3FR4ZasVzxe/WPcwKt+fGzI6whGHShJNlEN+Bm3/5rSRbGQk6XmG11zdCKqyTYgsocdA0wQCdMxGbkErBQKvtJBxOvttv9/2TcmqYgByZg6efeR+eLOUb/WQ7Jg0Hv6iTR2aL/2VzguU00YETLmpHnB4b+BybJQVDW+9uf2CEN9uJkjz34
X-Exchange-RoutingPolicyChecked: QeNU27jI6mmX07yX7Ea3eO5ZjMqxowfscJWYi1M93mg7drXK10i/bPocZbyVL7y4fZLqPGkAnxruB1E7FBLWY+IIzvjRBeAXTLtlCYC70H9DrBndBFVVCiQZN4JTDcQiZaN7F4RJfw/6vFEaACkxsFYP0qktJ7Z6fkeTCwg8/dTZrGuQyrhyknfgFzDX1FHFFhdxAo1RrPcciLvl3EmwCYrxRTedlYaVxulEi2TzTO9THpbqxdGiQgPx/5jnW0kaS2IBQCBGcD6AmJK6P0fg+tuOupPaUs8AbVaomBsjoWGs5Pdqxn+zLS1LED97M+sW6cMJAL9n3yBlZ/HmaP9P6g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 10:22:37.0958 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d721f6-5e65-4b62-58f5-08dede6d2a18
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6196
X-Proofpoint-GUID: 10zbEYNKHz_s2zul4NhXUCmGUYVIGDzR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEwMSBTYWx0ZWRfX0XRSpT04YaOw
 jdvNuKPjC5GrlF8NxwBd21YciYu5lbdVSCtJpQhd80BVHCaK9E3TCMX7dQxO5mfaH8wXN+WeI72
 W8kUhDKotIFh9uwNOOlWloYdtPrxOJQZuY784Wskld3HVZZUl9y/YrSSAXpCFKtVxJrEnK3BV/J
 So+mG0KipYbxPR0eUaeON0DGSRo8i7tirrugwrsuOs89hspqKZDbW7RPiEhNflxoHjNS7RLPUJ+
 XB4HQRwhMZQsvWqKKgkLMrhp7TFM/17TBxo94J1bl1y4uxbilCPNSiLWrYUNKDuR1pMIlJ4cC05
 jBD5LkvmuOZSWA88NHe9FS06QQk+vlB/vWpSwR0cX6FYJeS+lTuL9waknpziPASDhYHSfZTpZ/m
 cPpPXhiB/WDh2jVFCYY1FgLnMgN2DU/gKvb4ua1n7F4qiYlx/PdxU+Twahjxnu9ZS8Psg9RqWXm
 qPbM7pB3WpRB9c+dQsA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEwMSBTYWx0ZWRfXz9Cp9MX6Hl4J
 0b7wdbJNwa7UhnhDzl6R1J3Ec55qwFQhEDnqtVUWJdCznb0W0M/AC5mdhJvnabP9lqvkncgL+n5
 oOEMsGxij9ujWj7jEWwKiDV1CGrkO0U=
X-Proofpoint-ORIG-GUID: 10zbEYNKHz_s2zul4NhXUCmGUYVIGDzR
X-Authority-Analysis: v=2.4 cv=A+pc+aWG c=1 sm=1 tr=0 ts=6a50c7f4 cx=c_pps
 a=IzBZuH+2DL2Wyeknq0uBXA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=NEAV23lmAAAA:8
 a=fdwQ3TzUzb8g6BDI8vUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100101
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
commit 'a18265f1ccb7' of origin/next branch of U-Boot repo.

Link to v1:
https://lore.kernel.org/all/20260702081251.2691159-1-c-vankar@ti.com/

Logs:
https://gist.github.com/chintan013/db875ef8b703094af70ca681659ba7f0

Changes from v1 to v2:
-> Removed the duplicate config options from r5 and a53 defconfig.
-> Updated commit message for [PATCH 1/3].

Chintan Vankar (3):
  configs: am62ax_evm_r5_ethboot: Enable config options required for
    Ethernet boot
  configs: am62ax_evm_a53_ethboot: Enable config options required to
    enable Ethernet boot
  arm: dts: k3-am62a7-sk-u-boot: Enable DM services for main_pktdma

 arch/arm/dts/k3-am62a7-r5-sk.dts         |  5 +++++
 configs/am62ax_evm_a53_ethboot_defconfig | 10 ++++++++++
 configs/am62ax_evm_r5_ethboot_defconfig  | 22 ++++++++++++++++++++++
 3 files changed, 37 insertions(+)
 create mode 100644 configs/am62ax_evm_a53_ethboot_defconfig
 create mode 100644 configs/am62ax_evm_r5_ethboot_defconfig

-- 
2.34.1

