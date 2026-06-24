Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D14ECDE002
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 15:36:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD581849C5;
	Wed, 24 Jun 2026 17:36:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cnowwAao";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Yraxt+0S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D96B9849BF; Wed, 24 Jun 2026 17:35:59 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C31E849C5
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 17:35:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OF2eLs703896; Wed, 24 Jun 2026 10:35:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=k8kvIiAkkmHx6WW2hpjKOaJh34LOLYzaEJBCMkLIZ
 54=; b=cnowwAaoykchbPw2Vu7X1AVGVlWlVGONOSvo7p3Y05AGinkFwrVECjXQ6
 HmzIvFfHnmvtjmQ2IgadtZ++FaK/huWLnLIPP93Q+WSOxOO/OKie5fWo1luflTfT
 XHdD1RY46E3kE+OaxGMU3ebGzXs701xcGzPlTXl/ebtWH6MP3Y5pD2ZQtCLaRYmc
 ZImkKMmbn8JnGAwYeHitwHlgnqguVEWgtYGwShsWuTMSUXIpvOvJAoFm+2WoNFVh
 6rOLNBLpeQit6IwTdAGba8j6/l+hwoGwysncsygZjEP2RHddXanu79/7t+Wzu8rQ
 qw8aZzqn70L6CsCdh5dQI/JfRTKqA==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11010041.outbound.protection.outlook.com [52.101.201.41])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f0e5m1jm6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 10:35:55 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wbDgWO4wbw4gHwQe4uIAhRDpS+1zqDPBz/WvsFuC+2meLmfdvN/ISNE6S52Ejx+eFsWtZtrv3ymiGmlVcjLkTjmGaGXjFr6S0RAggo+VrCZm7RAlViCyWHZUD0L6ANS5m5RPInXAKNNMUK9tLzhZbmBN0WVcokI1tMOL1RuVLwjtev8mB+aArk+3OeGdPQ/7G9ztQbjL/Pq3nn7tplIxgtS6/S4SoVgWMvu0s7AIIR1lz7/JuGS4jc+DzeJ08hNcyQFfTZvg5F000OegG44pJi9QBIqHALAhAlTuGt1jD4lyzGPGOkCmvtYAjFBYt9efPh/P6SKzxySDTIVlM9npLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8kvIiAkkmHx6WW2hpjKOaJh34LOLYzaEJBCMkLIZ54=;
 b=yfZkg2NeUsPixrbdmvftPJkIZcuZTLnpbYijpM4p82b+RH4jFJYkPD+wanGaAg2nBsq7SHavWSBpGDfdKPrkYwAnnVvmc4V4Q7IIazloto/aJOdGILTxodDt4Wg8hHCdULiEHpJKf7jbHK29fNgm2ZLJGICdTiBpKqK7+xg4JSXLSVZObBeDATM6L6fZc45jmEXhiCmOavU3Tt50obtLgOYJkvEPBbCdHaGwQPv5cM3Y3f/QToukCq+1WP0D0AMRIcwoLCq0HXKDLUsJg+o0HDoOAdWOrM38/a8KBAa0Q0+IiQaF48H7p/cC0zNmufsqxlF0R6l4CiW363k/vIv0sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8kvIiAkkmHx6WW2hpjKOaJh34LOLYzaEJBCMkLIZ54=;
 b=Yraxt+0SYZRlKSEcgQtIx+NcXXrIvJTPXjQ5QhCWPN/OLYOKZuvX+vIRYz0CrCaKBuu39+LQG0MtAh/PGwnRx4gwwStS2808MdP9rvrt79A9bgZcI/Hx2wwojjrjb/Ii2YLdKhIl3NRjw+VUf25R4n/2nSbXhzAG6JhVnSKqr48=
Received: from BY5PR03CA0012.namprd03.prod.outlook.com (2603:10b6:a03:1e0::22)
 by SABPR10MB997942.namprd10.prod.outlook.com (2603:10b6:806:509::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Wed, 24 Jun
 2026 15:35:54 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::31) by BY5PR03CA0012.outlook.office365.com
 (2603:10b6:a03:1e0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Wed,
 24 Jun 2026 15:35:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 15:35:52 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 24 Jun
 2026 10:35:13 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 24 Jun
 2026 10:35:13 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 24 Jun 2026 10:35:13 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65OFZDSv725348;
 Wed, 24 Jun 2026 10:35:13 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Wed, 24 Jun 2026 10:35:08 -0500
Subject: [PATCH 2/2] arm: mach-omap2: am33xx: check VTP before
 reinitalizing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260624-335-ddr-cke-delay-v1-2-21d65d40a83f@ti.com>
References: <20260624-335-ddr-cke-delay-v1-0-21d65d40a83f@ti.com>
In-Reply-To: <20260624-335-ddr-cke-delay-v1-0-21d65d40a83f@ti.com>
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=2078; i=bb@ti.com;
 h=from:subject:message-id; bh=19W8Db8OY8fZpXzgjdWTQQRbP9QBio0SdmfF4HZv7hc=;
 b=owNCWmg5MUFZJlNZICJcwwAAYH/////tS6s/yM/xP9hSsZh/uzVz/978nPqfY/5azt787f+wA
 RrbGMUyNAADTQAAA2oaMhpoaDI0B6gaDQeoAZA0Gg0aADQDyNE0NDanqaep5qRBk0yGgyBiA0aG
 gNDIMJoMhpoehAMNTRoYCNPSNqHqANMTR6gyGQGTQyAMQD0gaPSeptQYmmQD0gaaD0RoNMgADTQ
 0DCNBoYBMQGmgyaaYgBhGmJoPSAACoH3Y5GLvjgsyrBDg1tNLXFA+vPJ+L45wROfkIHZ4SOt6J+
 tsRIiFxEbXggBr0qtjY5MhasccuudunjdBDE9rcZMdl+jtX6oeNUYy348/Tr5fVVDlSQRaBt6ZD
 EZ2drkwjBuBMqZFub4MJq1bJPgUBz5EQk920/RPsPXPJHrcHz0FxioxULyzNh7n9vNOUM5CT9oo
 9MNa2D4h512hPF3Ygt07B2MdpKgn0QAwzbFCa4XzVKr6FeNAOkS4dsjwEXQwqJFocGWJlHsZwKc
 NqZx5c1SzbszzH3CSBiiFnujREJ7RlmbpCQlwNpQ8s5FWzzkXmgYA3PNK9nocQC9Dt/zZCTDvcI
 0w4Almpr7a4DNUPTC3y5ZfqO8UV/2wND8EfG5fryNSPiwIelanOYAjQ2oRt4IYBTpsN2PAAv5eQ
 LuSKcKEgQES5hg=
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|SABPR10MB997942:EE_
X-MS-Office365-Filtering-Correlation-Id: 56cce25b-9c5a-47d8-e299-08ded206467a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: XcC0QAgDZMmA9SS7O5azkrXvbbCT5I+3iFkvdmMwJlFIAXLFtvEgkGMlRW1OsXP9Z05U3jSXGVbYJGJnv/lGEiftUcMyJwqUiXJVYN2TYIpuJmkwc0uhFfw93YrU1vHHW534qKJLfm+6V0GgjkHiQqF8mpqzFCacO06qi8ytZ19dQp32aD2l7+0I0YT4OZ1KbmSoiNIO2wr+E/2dT1e/PVDZ+hy14+1Q4IupK48PVoDh1Q9lVnJfw0+l+NQUQMJQ7jERxRLFKEBUbl5ChqTCzWwW4rnoDLjpNTLpepyMpHYe7VIbC9nkPR8xHmHX+gi2i7fyjXQVE7l5ZNEP7/JQX+VV2Xzt8OOHfIp7YV85hoKNeuP5JGgY8i3bux16KdrSI6j8bmjXITj9tAfSKWjZZGgAW46D5ffwToKUIsZDvol78BsoxIDHUI2VSL3sDMiSEbNe24Ue0Zxx1ZeFX4lCRqGCOr5MwlE9E3jeFAIhkZWsuJZ2m4BJ+RRUYnSCJksfHq1MeHdxnsamifXQ1nl7Kzb/YWikVNS5gA2me8C9IMGZOHBA0vydyrows3dzXWO6NL4/2bv40DxPJdZvyREwFhW0Dt/KaH/r2yIE8qoxM1nqdxBZvibvzrEa5u6h/9r7YIUpZogvWiQC5MHSuKBRX0x46xI94MFQVYa7SlpaIYZjkAjtIvYBvdWldu166NeO
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DXfxLN2CO5pNgiStFMetsVLbtHfFZMYZcuawS2d2SBjw1BDZRXJDAmBeSX9qBRDSxOBEmLTXEEkwmb94h5vrOzUHq2c2ToTXWwQtWHi0Ch71CKP2Cv+SKDkXgJEANYSE9nV/zxH5irI4QPZ32P9gjo5N0mkUmYgQlsMIsHoBQmQsMdDaf4Vt3Il8P8uBdo6lM9yr3MWjRrN9YMN3u0qY6zhZINeMW7TP5DLKsFXUyOBaWkkucUXy0TQMZ8cw6tXS/+Rs5otCbm+x3sSbAvTykzy1VJ+/XPtFBOkaAEH4s4XY6t4LqS5R8OvDgwiQCIEsi++L+To5j+vdd6BJpdLiRoLXPzhyO1lqeT9wusaryALfGafwK1vsVUEGbaUibKP4hgBpBYSfJll4oOSd9FoU4/V+CpHqLxJ+5SEY0lRwjSkQPTJ9wjN5r4QjnnMsx73h
X-Exchange-RoutingPolicyChecked: f9a7GhEINvywhVjNG4LEtwQbUchQzYfKVEbQq46zZ6Ko1+fsi8/Jx0xMKd/ReTBS7UHqOF3n4+2Jud0/5YZxxROZQYLveSCK+pkr/D0MIMYLJe5dZm5JUQ+i7y2iS6a8prLK9IAMY+T2Xnu4Bf0IXDuJCOzPWWylDdrRfdEKi7mX8vdvrSdRrJE//d7Vqq8IS913JbGyWQ+XZ2twcSuiXG2HofDuDj45/i+c+tYVYAf/reZwwyifRGVO+ofd0LNRGyshJpjSrc6Ttv2p/oUlBUvbEDGPY1rT0I+S+dvwG27tTp3EsHv23tEtEPWbR1TJ/ywLhU1zsX7UcKddmaCfQw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 15:35:52.6000 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56cce25b-9c5a-47d8-e299-08ded206467a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SABPR10MB997942
X-Authority-Analysis: v=2.4 cv=I/9Vgtgg c=1 sm=1 tr=0 ts=6a3bf95b cx=c_pps
 a=xSIn1YjG+VojQN1dL9/zMw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=KB5W6_E69N1DC8CFUvUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: VuunpukF33LbILQj74ymxb0fwFN3X1gp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDEzMSBTYWx0ZWRfX7gdY6Rn25U6V
 CX0N0eDb6ZO2ItK5BD/j2xShDPsbGGuqlWvpueCkQCd2W1jguL4Nf7RaMgJdOc9UVlJ+3kIo3Kt
 C00n64PX3eM7HuNHVsw7Apw6p5DWSrFzz0r/tCBSqTNT0J4nUSbRmDaCgTplv3ALvZqKIdbfarK
 C8CWD4l011IcV4f9d7oKNydHzNZifmNW06mv5IiC8w7ml3MhvlPHcXiPbfIAkO3cVWmMb+F4IMx
 s2kt149t9FXmj05gvpZvNkIyE9HdzI5RZ78reBRmcZDCOoYWpCbxICjBZ+lxN/ZIAjcfcBRee7k
 VpJM5Fqme7ObHHhm40GKZNmo/y1nE7sTfygnC1t1C+0Oa5yq9hI0m0Bm+P3yeZ72PCb+ATeeFw1
 oEqYCk9JpRNL7oUv0YwvriT9PkZReaVleyCq36WKoDKsxXCCtDbFAYrlUwmZA3GPD6tXkpesalN
 I3qdlEiCc0GG/8aHXzw==
X-Proofpoint-ORIG-GUID: VuunpukF33LbILQj74ymxb0fwFN3X1gp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDEzMSBTYWx0ZWRfX46HyxyLeAwaV
 M3q3+D5XpMKIglc3gIItoDXWHIPV/6e7hAE8Rcd1Rc0nWGAGiGxluknyNyGqGm6c2Myd30JklEv
 t8EYT25Hhj1mQT5jcO+d3T8ZOgdY3eM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 phishscore=0 impostorscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240131
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

During a warm reset, the DDR controller will be put into a self refresh
state and will exit self refresh on reset release which will put the
controller in a ready state during bootup.

However we will reinitialize the controller regardless which will
temporarily (~6us) glitch the DDR_RESET line low

Fix this by checking if the VTP controller is already in a ready state
before we initialize the controller unnecessarily.

Fixes: 3ba65f97cbed ("am33xx: refactor emif4/ddr to support multiple EMIF instances")
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/mach-omap2/am33xx/emif4.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/am33xx/emif4.c b/arch/arm/mach-omap2/am33xx/emif4.c
index f19c66822d20..96e239b31a0f 100644
--- a/arch/arm/mach-omap2/am33xx/emif4.c
+++ b/arch/arm/mach-omap2/am33xx/emif4.c
@@ -29,12 +29,21 @@ static struct cm_device_inst *cm_device =
 
 static void config_vtp(int nr)
 {
-	writel(readl(&vtpreg[nr]->vtp0ctrlreg) | VTP_CTRL_ENABLE,
-			&vtpreg[nr]->vtp0ctrlreg);
-	writel(readl(&vtpreg[nr]->vtp0ctrlreg) & (~VTP_CTRL_START_EN),
-			&vtpreg[nr]->vtp0ctrlreg);
-	writel(readl(&vtpreg[nr]->vtp0ctrlreg) | VTP_CTRL_START_EN,
-			&vtpreg[nr]->vtp0ctrlreg);
+	/*
+	 * A warm reset will result in DDR going into self refresh. Once the
+	 * reset is released we will exit self refresh and resume normally
+	 * so a reinitialization of the controller is not needed.
+	 *
+	 * Check to see if VTP is ready before we reinitialize the controller
+	 */
+	if ((readl(&vtpreg[nr]->vtp0ctrlreg) & VTP_CTRL_READY) != VTP_CTRL_READY) {
+		writel(readl(&vtpreg[nr]->vtp0ctrlreg) | VTP_CTRL_ENABLE,
+		       &vtpreg[nr]->vtp0ctrlreg);
+		writel(readl(&vtpreg[nr]->vtp0ctrlreg) & (~VTP_CTRL_START_EN),
+		       &vtpreg[nr]->vtp0ctrlreg);
+		writel(readl(&vtpreg[nr]->vtp0ctrlreg) | VTP_CTRL_START_EN,
+		       &vtpreg[nr]->vtp0ctrlreg);
+	}
 
 	/* Poll for READY */
 	while ((readl(&vtpreg[nr]->vtp0ctrlreg) & VTP_CTRL_READY) !=

-- 
2.54.0

