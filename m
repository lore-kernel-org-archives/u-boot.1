Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0233CC4451C
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 18:09:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BE5844099D;
	Tue, 21 Jul 2026 18:09:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1vpPWOYhfTUp; Tue, 21 Jul 2026 18:09:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BC6BF40988
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784657363;
	bh=lsueD3aNs/8W39JWzXiXt7VlAv4qjkpmUFC62HFGC0I=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=s4nxkcYdHSP7Zm0Hav+uc6yUor9dYGD26cSyJJN4hkxxbdLQPu6i8xJV6RHiuvcsr
	 Hi/KwOOcF2Yz89RrzhakhS0XC2DWZihpETsIjIQ/g0CRbCzIe8S9AUwGjL90L2C+gQ
	 eTME3tJiiHawdMGPEii4tuLW5VfXOnvhms8gXAEUfVZWCPDnBL7nKVCSe/O8kCb9cH
	 2rHGX5OOwCPA/hH2f3ycLmVz70TRkfax65YXEE5wQIRr1FtTVKsBCMPpWXHQr9Eqby
	 YCADQ/9z8Oi4KBjN2PoEnRlBAqSsM6/OeiZYB8M5s9PkVDhXTKGd8EqROWigTm6U8A
	 UMnGFpIP2kdBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BC6BF40988;
	Tue, 21 Jul 2026 18:09:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9040A109F
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:24:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8AAB140838
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:24:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N5ll2DUXKdDQ for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 16:24:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6424E40829
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6424E40829
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6424E40829
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 16:24:02 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66LDjLV51017937;
 Tue, 21 Jul 2026 10:30:46 -0500
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11011044.outbound.protection.outlook.com
 [40.93.194.44])
 by m0380145.ppops.net (PPS) with ESMTPS id 4fj077kv8y-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 10:30:45 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GAstpv0ZR7nlf+WYVda8vEsZPCQFRkp8DoyC9vBp0XlLG06YDprYgLsXmo9NXURhijYOdK2sUI/xy83ygL7WMJtIjmAQwfyb2yser6V0BJhOJL89U2sTf8FKEkQ7Cd/SaMb8n/xpOsWtCP19f0SyIjRzif3LbTJHNk73oEYmqgCxxuZgnjrgrMk/KdcvPPP77faQwsx+Riwh++n2+v6bGze7Ydi1ADO46Wi59BwPb60Vdnk3mU8VZwCJKp4pESRop+zGnlh/pbxwkLF3BnAgVgfvzxkGVrxd4fYeq58H3RwI3OjSBRVy/i8tdNodfPNUFeakOe0rWyyqWPsJM54Jjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsueD3aNs/8W39JWzXiXt7VlAv4qjkpmUFC62HFGC0I=;
 b=U3fIIcu0prlcc40sIC6xdES5Sv5f4Z3EMX3qb6xuHOTiH6ZITQeZfDTfqzRYlWtvzki0YdM5dns1FYE2iepm80c3DANWpmsDlqUv0IQQON/wSYUJ/zKs8eyhc7iHJ38SJcW4XqXgykHEruucwHZ/9KMvMLiBT1fIkju7DL9r6M4nUMCBiLGqaOQg+es7YJGWAU13W884EJ2uevDeIPSDJ0BIYgvXcY3gw2R0t+xykFa3AzlOZWgUvq9mlCoEll8G9gJzLf8i4JmK0neDLlHycloFN4DxHRJeqBI8w+26VNM02tuOBs8CtBmlo0gS8kHTyb0Jv4BKgwaiUKXYyh44tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=linaro.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from SJ0PR13CA0033.namprd13.prod.outlook.com (2603:10b6:a03:2c2::8)
 by BY5PR10MB4194.namprd10.prod.outlook.com (2603:10b6:a03:20f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 15:30:42 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::21) by SJ0PR13CA0033.outlook.office365.com
 (2603:10b6:a03:2c2::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 15:30:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 15:30:41 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 10:30:22 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 10:30:22 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 21 Jul 2026 10:30:22 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66LFUMZS1655319;
 Tue, 21 Jul 2026 10:30:22 -0500
Date: Tue, 21 Jul 2026 10:30:23 -0500
Subject: [PATCH v2 08/11] configs: am62lx_evm: add initial defconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260721-am62lx-v2-8-33ff580c267d@ti.com>
References: <20260721-am62lx-v2-0-33ff580c267d@ti.com>
In-Reply-To: <20260721-am62lx-v2-0-33ff580c267d@ti.com>
To: <u-boot@lists.denx.de>, <u-boot@lists.u-boot-project.org>
CC: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Alice Guo
 <alice.guo@nxp.com>, Anshul Dalal <anshuld@ti.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andrew Davis <afd@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, "Kory Maincent
 (TI.com)" <kory.maincent@bootlin.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Daniel Golle <daniel@makrotopia.org>, "Rasmus
 Villemoes" <rv@rasmusvillemoes.dk>, Vignesh Raghavendra <vigneshr@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Dhruva Gole <d-gole@ti.com>,
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Paresh Bhagat <p-bhagat@ti.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 George McCollister <george.mccollister@konsulko.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Frieder Schrempf <frieder.schrempf@kontron.de>,
 "Swamil Jain" <s-jain1@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Shiva Tripathi <s-tripathi1@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, "Aristo Chen" <aristo.chen@canonical.com>,
 Johan Jonker <jbx6244@gmail.com>, "Apurva Nandan" <a-nandan@ti.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, Hrushikesh Salunke
 <h-salunke@ti.com>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.16-dev-d5d98
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|BY5PR10MB4194:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c99aebe-646a-4400-69a3-08dee73d066f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|7416014|82310400026|23010399003|6133799003|18002099003|22082099003|10067099003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: /mTxwgqJEnPU8eRa6tfkiNG0N26YfWpfrs02HMBpOI8RhGdMZWwn4JwD+Ju2MCc4JLIXyjvLL+ezWRyaB5+lGp1jbBsEAHPwHJmAtpYw+MRKIl+GuaHEGD+Cythftg0oP1DSsmIC0RLfHr5z6GGR/7oWjbJkW5++uvlQ5WYeQGYLartWFkaE2UoGm5/htRUccwhqb1oEdSkTUPwCVM2/mdjUmAnWTCjmSU7D4l38RTzrnefwCbxJQ0QON6C+kSra0UOfz5hIfz0ezqFh22B+AVBtZE9VuUk3x55mL18k8JrOfaf1NZyTAZmqZtj6Z+VstgQ2nBA+ahSnBovL/tWqCw8rJy0wUfcxjfWzUSehN1Lko0F4vJhCVTFqdEXjRC5PDyUf32c6bTbG6zdE8Abe5KukSGxsamktOWBaXa3XBuVurS08QPtfpH3l6uj+6pVOAv6P7PuaSOqF09pvUspf7EKbcROPLgHKU2doIFDbh5B7mQIMJkBm6ay7SP31bp8Osjvv+9sfCv1JveMe2rA96sth8+TehpF4vxEK8pTRd2YgVr/1XSWCWKguUVAiNi113bajwpPp16OLp0U92WFJRKYarSJ7MiIgWnnbY1f4KDKpmVPHwy9hqh+UrW3i8Xfek8BNt98dbkgGnEwRRzrLsXY0WOA7/g243AHwne6VETAN6diHSMwetHxZ5FlwtbxUD8pSNQ7eHxF+XIiW7dFefw==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(7416014)(82310400026)(23010399003)(6133799003)(18002099003)(22082099003)(10067099003)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: h1SR8dOnYCWb1rFxuAY/Iox9z/lNo4U+UCSIg9Qn3ZuyeuF/92pvCtY9WNbUsEbhsYDHPFE2GSWn+OsksLQih0PJlyezRzASVAYF1Q7PCz6rXcagBuzaB+5SCh1IwZqGRzbCZXDuz8umZolumfmrTbREzbHKM4kZ0HwJ0u9Dr5FHY6ecORxmRvHHgYLe0cw0Uq2eXeICkTYDiBA31TMw3o61dZ4iD/8IkbqvvdwzA7FKjTqRZfyKjjgMmYm2iZ00tBC8W9eTdWrkpjuuEohxVmxneIJ+kguBbIcgGiI6Qqk82U6G7y6jqSDMAfLfjRTbve0btBZY03FBSjyic7RuPou3pwi2eYNoLZWBY8T4YjHjp03K2tTGD5pg91YoiAlxTGCObqEgibrmRpP9evkCbYzevqUO7TkIctDMfoy/nr5ifJR43cfCkeyGWv0Jiybo
X-Exchange-RoutingPolicyChecked: PyxomhPWgj05oXFiqUssUkdebU13SRXYM6HGFJ+boLg/BfLn7uFP7mg3iuHLaAv5h9tL5Yi0uRPtgEQAqyQWiL+hvOynJBbUK5rUjUW8OqUYw8ui9/+H5nDNJRPaxslzofXGAqOxDisOjVfv+OYITBqE3VIcX3G33wt7oQ7vgUP+23LYkFWcfvDlzjFaG2k8uaykw/zhha3B0s2t5WHZ7ow33T1timYdJxNjLpEJaQTt13knUQOjVMLQ7kG7xx7fHBWcK+orFPzC0YovfEm+HDjNeMK9ew/7lIkOTOshkl4qoqGqWO47JAkb3vvLpelJdqj5vtAbjNkEmVSlAbGXAQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 15:30:41.8810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c99aebe-646a-4400-69a3-08dee73d066f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4194
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE2NCBTYWx0ZWRfX36hhPYOZWx6S
 q+AVd/hcFOrv3B/3Y8TwnlBb3MPCeKzyZE0XgO7SVoR+qbuocreu17HkgcCw5W6KL4Mih4fXJov
 yi5WVLR32Cmv8/vuPRg/WrT+Go/Da3t//OUrYQx0Ttye5mhVdsdQiEHovCSfJy3MWTP9vWLcGfC
 o7coEyZZPdY5Q7mwhxBS7qswWfhXjE9kiY1v2rz6j8iRh3Vx3zIcwSClv4jGllbIo9ij1iUT0+6
 +xy9/1VPFjoSgGwCF8ttawWeHUD/lzyNrXnq2MlIhC6RMWBX0xW2DLgblMSkR0aHQA2uiJm06AB
 Bp2UResQCoVE50zX1SlnAqwayKrdNBqFR1sfiaz0UyRK1e/RIHaOg0mHbCK/bynTn2EwpZw8QIa
 DQWVnY/icdg6Ca9nmeZklRjpTQR6UsG/LENUIafEkLUWNbSdnFpKLpf2WGELxQUxbVeww8N4Z9d
 R7XwiyU8XO194604Uew==
X-Proofpoint-ORIG-GUID: fTSQWVKp3n2uERnluLUOZJgYu0sd0t20
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE2NCBTYWx0ZWRfX/jDnPWFHmyPl
 EZL/7udYiXhSmNCjOftE4rHug5xIobgKkT2Z+lrDj7+xu8b0PWPSDxF+bnTRTiA77pgRcCcHPib
 Mi55R+bYA2mAW6fKfX/m6EOCngZj9KQ=
X-Authority-Analysis: v=2.4 cv=KabidwYD c=1 sm=1 tr=0 ts=6a5f90a5 cx=c_pps
 a=IGlUesXJXvI2YQKUC5af4g==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=mgJN0jjOy1CJ0z1pLmQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: fTSQWVKp3n2uERnluLUOZJgYu0sd0t20
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 clxscore=1011 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210164
X-Mailman-Approved-At: Tue, 21 Jul 2026 18:09:10 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=lsueD3aNs/8W39JWzXiXt7VlAv4qjkpmUFC62HFGC
 0I=; b=CnELO28vEFw10yKpucWUklw+EJmWkRdQSgElf4EdwLsme7LgnRD/TTPNM
 EGKt6poMej1MgXWQpPEHYYubGpe2UurtRzKmdSAckN2mr8lPn+4lycqg9zAn4hD8
 ajIFFY5dkpWkiIfT7+Jy35OkxClGvyKUOugx3cEvMnGwrIbkuwrXnCztj/A96TeS
 bvwmwMS8EMiNXF0vwaKYVOsqiuB+AbJUWv5YLn67YGM3bQn+48EAyUxnrRcaz2Nm
 dlXmD6tk2XaMsLwzCIPScNbqIrHHoee55q2sgklWazF27tq7GPgKefCSSMAMho26
 hEy67XnRu/8yABGI+OIQz0fxPhSjQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsueD3aNs/8W39JWzXiXt7VlAv4qjkpmUFC62HFGC0I=;
 b=n5CSIR21yipTRxUrNFdwotkQCvtQse9p8oYMEjPkwR8VlcYbfI0Ags2fd1UODmoQWuqdHSh737q9FdAsDf+tw4vyVglTqd7HJE1fA+ND0itFG9PDFQgARj3B2feJsNPns5inkQJZqY2+jy6kkLCwjv4fTncR4obVj6AjfbBNKlE=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=CnELO28v; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=n5CSIR21
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
From: Bryan Brattlof via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Bryan Brattlof <bb@ti.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add the initial minimum configuration needed to boot the AM62L3-SK
reference boards.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Changes in v2:
- removed options used for fit image signing
- Link to v1: https://lore.kernel.org/r/20260717-am62lx-v1-0-b9830633afb8@ti.com
---
 configs/am62lx_evm_defconfig | 139 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/configs/am62lx_evm_defconfig b/configs/am62lx_evm_defconfig
new file mode 100644
index 000000000000..2db07b508c2a
--- /dev/null
+++ b/configs/am62lx_evm_defconfig
@@ -0,0 +1,139 @@
+CONFIG_ARM=y
+CONFIG_ARCH_K3=y
+CONFIG_TEXT_BASE=0x84000000
+CONFIG_SYS_MALLOC_F_LEN=0x8000
+CONFIG_TI_COMMON_CMD_OPTIONS=y
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SOC_K3_AM62L3=y
+CONFIG_TARGET_AM62L3_EVM=y
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x82b80000
+CONFIG_SF_DEFAULT_SPEED=25000000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am62l3-evm"
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_DM_RESET=y
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_STACK_R_ADDR=0x85000000
+CONFIG_SPL_TEXT_BASE=0x82000000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x82c80000
+CONFIG_SPL_BSS_MAX_SIZE=0x80000
+CONFIG_SPL_STACK_R=y
+CONFIG_SYS_BOOTM_LEN=0x800000
+CONFIG_SYS_LOAD_ADDR=0x84000000
+CONFIG_SPL_SIZE_LIMIT=0x50000
+CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x800
+CONFIG_SPL_FS_FAT=y
+CONFIG_SPL_LIBDISK_SUPPORT=y
+# CONFIG_PSCI_RESET is not set
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_EFI_SET_TIME=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x83000000
+CONFIG_BOOTSTD_FULL=y
+# CONFIG_BOARD_INIT is not set
+CONFIG_SPL_MAX_SIZE=0x58000
+CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
+# CONFIG_SPL_BINMAN_SYMBOLS is not set
+CONFIG_SPL_SYS_MALLOC_SIMPLE=y
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1400
+CONFIG_SPL_DMA=y
+CONFIG_SPL_ENV_SUPPORT=y
+CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
+CONFIG_SPL_I2C=y
+CONFIG_SPL_DM_MAILBOX=y
+CONFIG_SPL_POWER_DOMAIN=y
+CONFIG_SPL_RAM_DEVICE=y
+CONFIG_SPL_YMODEM_SUPPORT=y
+CONFIG_CMD_BOOTEFI_SELFTEST=y
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_EFIDEBUG=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SPL_DM=y
+CONFIG_SPL_DM_DEVICE_REMOVE=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_OF_TRANSLATE=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_RAM=y
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x40000
+CONFIG_SYS_DFU_MAX_FILE_SIZE=0x800000
+CONFIG_DMA_CHANNELS=y
+CONFIG_TI_K3_NAVSS_UDMA=y
+# CONFIG_SCMI_AGENT_OPTEE is not set
+CONFIG_SPL_DM_GPIO_LOOKUP_LABEL=y
+CONFIG_DA8XX_GPIO=y
+CONFIG_DM_PCA953X=y
+CONFIG_SPL_DM_PCA953X=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_OMAP24XX=y
+CONFIG_DM_MAILBOX=y
+CONFIG_K3_SEC_PROXY=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_SPL_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_SPL_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_SPL_MMC_HS200_SUPPORT=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ADMA=y
+CONFIG_SPL_MMC_SDHCI_ADMA=y
+CONFIG_MMC_SDHCI_AM654=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_SOFT_RESET=y
+CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_S28HX_T=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_MT35XU=y
+CONFIG_TI_AM65_CPSW_NUSS=y
+CONFIG_PHY_TI_DP83867=y
+CONFIG_PHY_FIXED=y
+CONFIG_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PINCTRL_SINGLE=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_EMULATION=y
+CONFIG_DM_SERIAL=y
+CONFIG_SOC_DEVICE=y
+CONFIG_SOC_DEVICE_TI_K3=y
+CONFIG_SOC_TI=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_CADENCE_QSPI=y
+CONFIG_SYSRESET=y
+CONFIG_SPL_SYSRESET=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_SPL_DM_USB_GADGET=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_AM62=y
+CONFIG_USB_DWC3_AM62=y
+CONFIG_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
+CONFIG_USB_GADGET_VENDOR_NUM=0x0451
+CONFIG_USB_GADGET_PRODUCT_NUM=0x6165
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_SPL_DFU=y
+CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
+# CONFIG_TOOLS_MKEFICAPSULE is not set

-- 
2.54.0

