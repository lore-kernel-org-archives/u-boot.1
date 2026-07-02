Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B53C1C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 08:13:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CDD584CCA;
	Thu,  2 Jul 2026 10:13:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kJMWL+Hs";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="T711VJ8E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CE3484CCB; Thu,  2 Jul 2026 10:13:12 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8646A84C85
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 10:13:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6626klZf1063210; Thu, 2 Jul 2026 03:13:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=ge70++6whi7Wvj6hd0YnTbFDofU5J1CKMBGQ8YLbf
 Ks=; b=kJMWL+HsccLIzcFdX/NL5yW2FLVyt98mJgDg4oPhHxsoDSv1SG5qtxpsN
 n12nKbXdzaU5NGfIvTqgM3J1Xxio+wewJrUbQfceuILmC6/Me6EBSLjIkjagBMTP
 xrIZEbqIKw5eusQi73u0K6TSsf5UblZHHiJZTYc+/FyssuUhfE0iGmO7uNtIauxx
 KVu0opQjqLWlqGGzREJnnugKKgLGjbINSAkvlpFYrYCPukcbdmRO3IZiKdgYtYJf
 jXi97y25oRjbCZT90zO7YkAvQZs5Zx1F/hPgGLrF9FE5Ey2E4mm+HdsGS0iyRaoE
 lpmXfOMXeNQ8z1933d5ghvj+Fxw+A==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11010011.outbound.protection.outlook.com
 [52.101.193.11])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f51vu6qxe-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 03:13:08 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nVLzZaNy9VXoEJ0HKL9EdE9fP4+IgZiZZvCoSpmdrOCIl5RvFhPiceOBkfk8xoB/pJLnlDNlx8ouPJPsk8In+JhLGk5hLZPWkuWFQKNTML/BIA6SsfbmM/ZN+tU5LSHR2QalEw3Z2iU8OGfA+1dv9Rm6BLwg4RW+GFp/b7xQbZ/w60pIaDZPl5nVLj/mhfMSpziePGmmDFXc+xPXxSTKDSOwasilG1GIhcHf7Vuc+Ebt2goiVyuhPhTE2TG0WwC9Fl7DJp9EgfUzNf5STL9xB5WswVGK2s4iYKxaZoZAFA17Mt5QkDXElbMjwYktdVWb52OgE9YSr+p4CZtVQORlnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ge70++6whi7Wvj6hd0YnTbFDofU5J1CKMBGQ8YLbfKs=;
 b=U+2lpASqpWD/MLIltxj8pyjdATKlRVhugiyeGp6fuuhRGs7Ekl9q8qS3TyXIDGVf+21w6Trd6c3b4RNhTUOhW/BvHA3FhtAQtRlYY8kVa89zVBmi18lOABJhnb6cK20Z68vBhi+34/UgEvg52xN2LuIJnIaneeQHXSeI5RNJGaxec4wLbL+yPO7soSwGG6oegmTJNBXtqF0qrNCYrlDJgRpGsmCQ3cK5btxbO0H+nodI8ADyadb2P6SemYfHcXIuJ5MrOnspoacmU1EfTsUvR3E6yvu3ayTdQUiMc2OSA3tcCa35xIwhDNhkjN60iilRoDcSPKvkHUBTtkU4zyyHJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ge70++6whi7Wvj6hd0YnTbFDofU5J1CKMBGQ8YLbfKs=;
 b=T711VJ8EvpmYyph+o811X4Xxzo4hbxCaBtQBCggkaZlL0VnfhLtV8CBkKXTWU3ejySJro9XtaautfVLApf5/x5A5gpexFjYIc30/PHVosRQs324KIkiBeOuJFt4oAwYLMrCHIdlY5NHg528vXQ5P73Mh1twkXj8RnoX9ygbwVJo=
Received: from SJ0PR03CA0056.namprd03.prod.outlook.com (2603:10b6:a03:33e::31)
 by PH0PR10MB4630.namprd10.prod.outlook.com (2603:10b6:510:33::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 2 Jul
 2026 08:13:04 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::97) by SJ0PR03CA0056.outlook.office365.com
 (2603:10b6:a03:33e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Thu, 2
 Jul 2026 08:13:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 2 Jul 2026 08:13:03 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 2 Jul
 2026 03:13:00 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 2 Jul
 2026 03:13:00 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 2 Jul 2026 03:13:00 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.231.164])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6628Cxd82889460;
 Thu, 2 Jul 2026 03:13:00 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Andrew Davis <afd@ti.com>, Bryan Brattlof <bb@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, Chintan Vankar <c-vankar@ti.com>, Anshul Dalal
 <anshuld@ti.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH 3/3] arm: dts: k3-am62a7-sk-u-boot: Enable DM services for
 main_pktdma
Date: Thu, 2 Jul 2026 13:42:51 +0530
Message-ID: <20260702081251.2691159-4-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260702081251.2691159-1-c-vankar@ti.com>
References: <20260702081251.2691159-1-c-vankar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|PH0PR10MB4630:EE_
X-MS-Office365-Filtering-Correlation-Id: 39dc1957-9164-4e9f-1c1a-08ded811bd2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: BzsnA1YmzdTO3ScBuqRf3zGyPbKsqCL9Ju+lrHQNgg3DPFPexK4uk6ovbD160gQLytf1mvfNMHRE+RAQ4X6DnPBkaWQ5W4DlKNGwHDRdLHbw96TGb6xnZ+/7e8JZtZzzqceqMo0bu+LpvdM7QE1omzzAKI9vzNHu3rZtFBKZ3bJEbA+w3QSPBnte3iQ4pRcy5N7Eac5ivZ6WK7oaafP9FisoI4esvbGiBQambBfgWxs0lllLTBlrwS9HJqgjeipqijESHunQXMQiASLENtbX2i2vL0f/Xt1/u+Ae3+h92HqEXCnlsO1bSAX1iTZH+VFBpDj66ovXX8vh5FsgmYGHMD4GMCwmUaLdZqeWzgVg5nyLJe8RIXXj97F19DMkznn9tYsAljJY4svXn0omBMNBJWPlw7ZVjbBevjDH5LQcAZqiFvAGDkDzSee/LtCL+qwpGhgOhK03yNKs7Ng8JvwG+DfgfCSTDSKF/ndFMjRDmJkiauGkdPhKWizkuslq5pMcnV48xfE9p70NQG15LJdlYHf1AFOgExRMWfGjD0NFWbdApkqHSqmDiB3LNSlyV9wfhWvF72h+6sFMJ3C+LshXZZO5c9SxnBVrEHQH0X6ErLCYKMpfogrtstvE49y5PVc9jARW8irixUxhwx7qmJJbshzoTq09Qm0sb0f71gK38zkXR3mPEHcG99LHFlK3XAEMYiXStJgfM4p4/JUWASCJGA==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nvA65G5nFsvokhQp0vD9Ck53kbwnwzlXEy1ma0OpIC0Z30G0C2CurPmcR5sBoUve5bx/xp6aMILWHxZX+TsAMDJ0w/vCDwuDyVHn2MmNx/G42Q47w13u7yWWTbSs6Q+XOaasZss29Dr+kYvG8qYbCgg0Cck81Vm3MNRbd60pRZ1nntZFBZBJA3mHuIT+oXuJcbCbFpLvm9Wus2m7MlxqHrl/YI9mRTCg98mvOnkF9/ejwtDUhPIujJQGhYLCiZvDoPBd+K1mQRtH+q+EcG/YTU+MB/9v1t5gVPIJ3KHzHppjK24odhZW+ZDZTdnTDR16lJ+h63A4IeAe9lUEJbHekm2gIVDyInioMi0TWkF6E4dI7lnoYTMRVUYVfqWa/Ip83OEgzS/UP/WuH2fCFls5xpuABMhlAHbF0FsjQUAcV7ijicrkq63dQuTzPH3FznZJ
X-Exchange-RoutingPolicyChecked: p/5IaiSTNW71ipuJ6Dd51CdwuDwH7t2wT0Y36xN019DIX1xeN2tjZxnxte5Z0DxWpbgCx27FrHDDVDa51EjldLMuIOgXR2jJU6MvwsSowHQucc5lgRFhpe9u42dIvdjqr9tXbmmYBBVkuHGJ9oqCMv3TxIbOW7WAJuEwKysj9wiOENFMZ86Gb8i+qZgO5mk4TjlpM/7Ym8/3tsdm5q9cBgyNGI44r7YJJKRtx6R3cV8L7ILLl/5zsa+WgK8ik4GfeLuXuWROjqhneWkBZ01TmGaZP/rDC8JFBFAftuBT1iAR5FOKF2Z5A0P3wd5v39HQgw/o7OUuxevpe+jkzcQq2g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 08:13:03.1841 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39dc1957-9164-4e9f-1c1a-08ded811bd2e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4630
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA4MyBTYWx0ZWRfXxbmoB9HGtqTs
 immXzojEYDw7KRGYFRgEkDpl2MK3Hmg/BbIe5yUucyqQfevzQD26A5AAuCTu2JK7UZ5xK4lMJuD
 8TCOgawKFu1w99Pmx4OSP6ejEw8pBaUoCjoxcE84yWcuweSJv042U+iMCd4jv8dpPAvfs6w8c3y
 MYNMpm7qFy8dFxTfDGtlWCCR6N5E7PKuYIFkjc6Hr2tvf8bB+nE/fi0iCuwzpBRqVQoMQBij9Vc
 1Juh6ZGWh+l3sybO7gYG4euGvMbbgsa9kUXpnqGXAO3w8C+Q1tQv4JW7pLENuumQC2J38ICnya9
 mSyDqwJJpHOZS4Q6RBXIfcKyqLEwrM+HF7JusDMujw0Zs+nwhUmBqfduXvSNeSIq2AD4+zTuUFh
 pCFhxlDOxL2hfUHDpcjbGED6+ACQ+uH0qQE/slcODzcd9Im3quc9Lrw/OSEjZ1n7S952TZtBNVT
 4B7tvVlPAwGfUse9u1g==
X-Proofpoint-GUID: ThqPe5XCCuXKdZRW_wSUXC8I6gcOcNpI
X-Authority-Analysis: v=2.4 cv=FYEHAp+6 c=1 sm=1 tr=0 ts=6a461d94 cx=c_pps
 a=OswsEo8IlqVTC7zrgcx7Gg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=sozttTNsAAAA:8 a=m0yEv8o74bc4KniaoOEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA4MyBTYWx0ZWRfX+EHP7vG1M8G+
 l0yzSb3ykZAGqF2PBKjnvyngcZo33ZuKga6TQXArPLOXRhUexMZEticiX39riLONT1Eut9ZjzvF
 Gw5ZIw4p8DtpDsgLqQoLKo+btsi6aNE=
X-Proofpoint-ORIG-GUID: ThqPe5XCCuXKdZRW_wSUXC8I6gcOcNpI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020083
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

Enable DM services for main_pktdma during R5 SPL stage.

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---
 arch/arm/dts/k3-am62a7-r5-sk.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/k3-am62a7-r5-sk.dts b/arch/arm/dts/k3-am62a7-r5-sk.dts
index 4570ff6edbf..9c2a6bf89a9 100644
--- a/arch/arm/dts/k3-am62a7-r5-sk.dts
+++ b/arch/arm/dts/k3-am62a7-r5-sk.dts
@@ -42,3 +42,8 @@
 	status = "okay";
 	bootph-pre-ram;
 };
+
+&main_pktdma {
+	ti,sci = <&dm_tifs>;
+	bootph-all;
+};
-- 
2.34.1

