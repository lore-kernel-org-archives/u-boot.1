Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21882C4450A
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 08:06:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8D6784CE4;
	Thu, 16 Jul 2026 10:06:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QR9afRoo";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="upKXtylq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0A8E84D87; Thu, 16 Jul 2026 10:06:15 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2757F84CE4
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 10:06:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66G7GM4f3171647; Thu, 16 Jul 2026 03:06:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=X9ZTpb8bxjZSH
 voOyZNQ1OfDO5AW0C3RIIMFaNZwjyg=; b=QR9afRoomfFk3WYE43F0IDXsEUE0a
 9hCtrZVSMy0O5+TRGfEdZdbrFbwjRShwWJoBhyHEa84ZohyFRrD6TF6pUvq/R0TB
 6Bzz7Mr8Rn20gnDYQTVXFCdZPIlCp6d3314c8HQv2bnHV49iMUqeyuQlVDCGb1SS
 3pOaEdYPjSC6dAy/2kSeoRS96mn6qsW3LiLH1DujSbPvBp+BWzbkIpEiaF76gpff
 /x8j09gDYlHVYljO1D1Jv2uzZ3Z8K4E9JIsxpM0dAqz0RKwsUV2amS4cBXH4r24N
 6FkxSSTLotoykCNt0UWi1dlozuFJpARknLJWxNnvbYQUZZN0kJGzTsgXA==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010043.outbound.protection.outlook.com [52.101.46.43])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fe96tpba6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 03:06:11 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJuUHb4jyoBfcHsQxJ5MhZ638iaBF2/F/7cCWzJij678ZDufHQExByF95k5L4qCJUA/I4ujyCfC1x0BR0LENwm6lfKBi16X7wdKm6WZqLDZ+ZgA+jcH1hg+IqMCdOrvPDZAmt8qvyfI7H4QxfLTYHta9t618/rUrhm1UcKkn5Rz18H0dxIyyIdvC8ETKXwS6NoWOvKxNdGBHSxvlso2f/XbHJHfjF2c5Q9MjlIXISNNY9nxG5DkUjR+8KhCD8+SLAWBEpgl2LyeaSAF9uFHOwf7FW31/cJKns/iti93EOOXmXxqqA5On/XpkQaG4PLQz40JQABs2HJF9xlGrjUB3aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9ZTpb8bxjZSHvoOyZNQ1OfDO5AW0C3RIIMFaNZwjyg=;
 b=loEjspMaGcZmdbtLuLE8xpt/cH44MIQAg27UMythz0DgYBASa6TDptE4TvhKo66DXhT6sA8GpLt6zyfMP8BNRLeZuVDZpD1cLcI1VMuJAWrNsAw1vb+lN++WWcB9zfFwmizD3Yh1HQ29uxURH/NhpjCFXo3pQaptkpnKTDUs7hXvyvIu8RBiVGYGcbgOEmtCXwkSRO4ewa1MGuRiym9W8Ep5/yMHxfzO83a7atXxq/ZTpqTXcgn4QxGQYQ9dQ8ybTUhHJxmqQViKP9kgzdOXQYIXoW0G0ZObUaqVJP9OyQlS9Lneo/kcCqB1TpadP8JMXZyAKm6eELlCJv1UrXMZnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9ZTpb8bxjZSHvoOyZNQ1OfDO5AW0C3RIIMFaNZwjyg=;
 b=upKXtylqP+AqN2pYUjYMx46VZPcpTrFknP0SKP67Hdis6wn6yI3jtwLruU6C0e6mlNpP2V5LUMPkcw9ogHxfAr+BzWs2nJ1UpGcCWaDOotOlMDzWIsJvHA24sllkSdEsP8bXl4sabE8HHqdKDayypAzHZvfZ3tjLIzeN1sGfNm8=
Received: from BN0PR04CA0042.namprd04.prod.outlook.com (2603:10b6:408:e8::17)
 by SN7PR10MB6666.namprd10.prod.outlook.com (2603:10b6:806:298::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Thu, 16 Jul
 2026 08:06:06 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:e8:cafe::31) by BN0PR04CA0042.outlook.office365.com
 (2603:10b6:408:e8::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 08:06:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.3 via Frontend Transport; Thu, 16 Jul 2026 08:06:04 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 16 Jul
 2026 03:05:56 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 16 Jul
 2026 03:05:56 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 16 Jul 2026 03:05:56 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.231.164])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66G85tKf867773;
 Thu, 16 Jul 2026 03:05:55 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>, "Wadim
 Egorov" <w.egorov@phytec.de>, Chintan Vankar <c-vankar@ti.com>, Bryan
 Brattlof <bb@ti.com>, Anshul Dalal <anshuld@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v3 0/4] Enable Ethernet boot on SK-AM62A-LP
Date: Thu, 16 Jul 2026 13:35:49 +0530
Message-ID: <20260716080553.2664147-1-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|SN7PR10MB6666:EE_
X-MS-Office365-Filtering-Correlation-Id: f85e45bb-f251-4e54-c3a0-08dee311151d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|376014|82310400026|18002099003|10067099003|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info: R422X2fSi1HSLMQMu5+qpizbZ5OTFX6WnIFTa0kgGxW3dP6y6nlr4tNx8pQBy6y40l2++oK6LhXc9q2WhrWSUZBPedRqEO05/XIYaabbiOdb7v40di46NDFip5Dx1D6V+X7l8uZJTR1w5QRu/1NHmAOT42BF7foqNXbVyGYdvmef2ZBte7hF2OBDp4LJpt3xFqCPwYiPeHQf2BBQUh0KRky/GEcRAQkCLGf0L1y3HdsgymZ8bdyL+tPfCTO9nbTvdsPK8N2GwYAYV/qoUeXSzR+BJDczaV+k2CcYZ071ALkSdQt5lAdNe8N+sE69OfeAD2udrqhhvLNCuUOD/PtvMCGWQ2LA1F4NKYc3FfwPyhxnQAGRiZvajOCjVDOMjwc2Iwf8D9CLxI0Krx5OAHhNqtxKi6iTAtxl2bPysT2Ck4U7hn3OfznqYjpU2sVD2Mb5KKKejdjDbqbqntNYGVR/Rwgk+zc40TiPNtgddmVE3xnJCV/9JqKbvASvT7sb75G9LhaUjcIUwgtSAlmK38k25J6q7jDAErtCmS9Zw9IL803ZG4V87zN13rW7vrt1OKGPM4pIjqoxJysNhvomZVwwNCTtyAX1/xgWdF0hkpFG3pG68zyJu2Ibbjjnb619xE6MskgU1umICQhYJk4DJW6s2b3S2jf60kqTR++OkBDi4IsLzN08mqacxZS/oFXMO3v/6Z9iLfg8fO8Yo/YnsThWww==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(376014)(82310400026)(18002099003)(10067099003)(56012099006)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 03T4xjlMQhKTZtrDYKeSZhOxirFuhI40syql2kk3uItYXiGukACBhvbHgdA7Yb9YQPDTfPm/HD74sJR2W7Tfc/86KTRkxVIG4+FZuFZYZm+odYAKnLnPviSyhwfhanS9U1etk216xHxC8AC5scpsyDLk20s3CIojqQKUUiJMAYsyiyVuwigRnGzSiV76dq8yrdICpuhhW3AmADZFq0rIY2SY7rMOha3AqNsAJo42cweIjuiHEp8WlnfU/0ynmleQaNBW+vdFgvrLtfjlSY82thDMfSW6cv/PEP515SaCOhS4Kn9eM4Ic1uyNnRqF6LdIV+72lcgEiHKN4bkCdpyYMzfJ29OSkSF1q1B4xIFHWRw6WrvOBuZF2MAMPB0BsqN/4v7Q3EnV+TVL3sEu0AxvedulH6ngzzVoazlf4nQOTU4OZVBHa+eAHXK3z/ELGREc
X-Exchange-RoutingPolicyChecked: ofxQDU6MrCbshrJ0+3sgWV+RKyznjhOHmygi/LHLhN9gfpjtx5XDvQm8Jsmk3Fy49MibjBsEL6CeBXJVdAZqK821xn1oPOfHXM0J4gAEv1YZGXLJSdz63C40XUbZlnjPU/YYPwFL6FWFtaHMxian7rHkrCUXFFT1B0zY47a5jPLUct59qjI0OV4ZF583yXeMkDqKFMHvjQjk22YwUB3RQZhRFRCFveCcof6KwZnpEULD4rPL4XTGPl1ELN6X/TrjxtmIYIXCC/2v+2A6Cdzsy1uWhRaf5a017q6UKgI6qwVUVH/CrMxmbc2WpTSQ6+Y6xXaFobTIQlGgKFfpl2d2eg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 08:06:04.0182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f85e45bb-f251-4e54-c3a0-08dee311151d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6666
X-Proofpoint-GUID: wqW3bXkQW_pVuB3HJFd0P4eenVIaNJQ3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA4MSBTYWx0ZWRfX02DMIyrbeYRr
 UgH0YV96DtuxKcoyqXwJQSEcesvb0ZRSMrY6yNcSNzhF84d9ockmP9dsTIXOQndlGPSBXGZ7w+H
 k8/1RbSDGrDph3KTiPd87wlwqTFKO8o=
X-Authority-Analysis: v=2.4 cv=VbnH+lp9 c=1 sm=1 tr=0 ts=6a5890f3 cx=c_pps
 a=BNrqkoHBqsJX0pt4tOnUqg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=NEAV23lmAAAA:8 a=kmG9WcCVhgq1n80zXUMA:9
X-Proofpoint-ORIG-GUID: wqW3bXkQW_pVuB3HJFd0P4eenVIaNJQ3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA4MSBTYWx0ZWRfX23HQjf3vrf9o
 qyXY0rv2nqjPDZdf6IDAxstDiKnmp9k6bvCOjk09RSnoAD2pZ3DE0NJhZ9ZeWqUwv9uopOS36LW
 /YpCX9k6p0U93dcqaB5uj3D2KO5Ohl+2IKDhlHDqoiGJXYqouGOmm++X4R3fiq+/IWvpOuvYdWV
 b6bQS9090qPBCmIMu9LP7Lx+ZXLXg07wCOwAzpQyYdoOfJrJMdSBsSl9XUP+izO8RA0o2dOT1U1
 aiDsIz8kipZggpYCSVyv1oqu0f2TuGfoF3J9/90dDsIgrRPIdfGHG5Mj0xlWnA/4zvKZ2OkzwyY
 Xw3WJMqI5mCzzajXOAlc1GXP1gxCmkD+cyMqpnnTHn24qDAqN1R1+IFBdtGJmB9q1JQbxWc0WmE
 bl71AxtRNZMBesHf/6HERZMjQHD6aOjNmfRG9cKAljyCDlzhaCCOJiKnVTNY6dAftAeDxeNW1iz
 9JSNCgR9MijyjsrWxxQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160081
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

Link to v2:
https://lore.kernel.org/all/20260710102229.2980029-1-c-vankar@ti.com/

Logs:
https://gist.github.com/chintan013/99c20c1c0773a48cc52a86d3eb86a98a

Changes from v2 to v3:
-> Removed duplicate config option from r5 defconfig file.
-> Added "Reviewed-by" and "Tested-by" tags from Anshul Dalal.
-> Removed "bootph-all" tag from "main_pktdma" and posted the
   patch by adding it in Linux/upstream device tree.
-> Added the Ethernet boot documentation for SK-AM62A-LP.

Note:
The functionality can be verified after U-Boot DT is synced with the
Linux DT with the patch:
https://lore.kernel.org/all/20260716064449.2505650-1-c-vankar@ti.com/
Currently the feature is tested by configuring the random MAC address.

Chintan Vankar (4):
  configs: am62ax_evm_r5_ethboot: Enable config options required for
    Ethernet boot
  configs: am62ax_evm_a53_ethboot: Enable config options required to
    enable Ethernet boot
  arm: dts: k3-am62a7-sk-u-boot: Enable DM services for main_pktdma
  doc: board: ti: am62ax_sk: Add document for Ethernet boot on AM62x
    SoC.

 arch/arm/dts/k3-am62a7-r5-sk.dts         |   4 +
 configs/am62ax_evm_a53_ethboot_defconfig |  10 ++
 configs/am62ax_evm_r5_ethboot_defconfig  |  21 +++
 doc/board/ti/am62ax_sk.rst               | 197 ++++++++++++++++++++++-
 4 files changed, 231 insertions(+), 1 deletion(-)
 create mode 100644 configs/am62ax_evm_a53_ethboot_defconfig
 create mode 100644 configs/am62ax_evm_r5_ethboot_defconfig

-- 
2.34.1

