Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7345C54E49
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 16:18:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA50387E1C;
	Thu,  7 Mar 2024 17:18:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=garmin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=garmin.com header.i=@garmin.com header.b="VJ2YbvEl";
	dkim=pass (2048-bit key; unprotected) header.d=garmin.com header.i=@garmin.com header.b="czISQ2up";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F185F87DAF; Thu,  7 Mar 2024 17:17:57 +0100 (CET)
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com
 [205.220.165.212])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B114287D16
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 17:17:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=garmin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Colin.McAllister@garmin.com
Received: from pps.filterd (m0220295.ppops.net [127.0.0.1])
 by mx0a-000eb902.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 427G0wKK017413; Thu, 7 Mar 2024 10:17:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=pps1;
 bh=OuoT2u+MUoe8jakbTDJJDsPwPE+TfxojRxSTXBOOzac=; b=VJ2YbvElqjtA
 Rpaag0crokrmXSl8ULOojxnF+oVBT9YVHlOBMZgxP93W1rtTbrmICF2yYiRDfysK
 mENmZIzHQnrllCATvczmKoelpsqhfK5Yctdvn6yhRlZXlIKLEPQ5RJ3Q7vSQ0S6D
 0NMX1fetm9H6VdQAWvshVgYMLf4Qytgq7ffamlQeE/+7R4YmR6/TiaVS4ZWVmdsG
 80ENhcOJzA5LUagLeRhoawV/FqyK/K0URUxQsvbCVIK3raKXZ7CaaciJbGRPLIDB
 tuPUAbwhAbktPzXAvY8FhDiID/NMB5+LgQCwZxuWB2EK89g/nElE7e7XZN5jqr2a
 01gpp9Rvhg==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
 by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 3wpvvhjf0t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 Mar 2024 10:17:51 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzoiVZAYfk1uJCFO+gLSEVyluwQ4vBWvM1Xn9U65+c/C3sfGoMO6+11aiUwxd2dflM/L+8mHSFXzILJ9x+biC4wEh+mHz4lhb+lMG5mft1/sS1uK4ShyT6Slp835tpeWzFBLwRNLL6xSRW5Muii1B0zIIwYlOyLolRyysTNcKgOdaXfpGYYqglUfjvwYuDfgMMijQVJ12bob19u8GPH3aVPbReguavhnSm7IV1YuCApR1iYo1x9Sxz+Lmk/koGHdHQq/C7QxUm5CNR7fvnqtZqoLyt9yhFQCWTf5zmbA95cRN+wLJX/uiDiBKib8f70kXNUzQB7jNFhDEGYItaDm4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuoT2u+MUoe8jakbTDJJDsPwPE+TfxojRxSTXBOOzac=;
 b=iawqNLiosvT5zND8YRp9KKOmKba6QAPAX2hwGXz2cfoRHZaYHtBNrITCqYw4c2XmvVzLm2oTjFbsOMEE2Q35WhD8p13TLTX4tFsuLDRKIvzr1A5SubvfD7KENuxyhxKvDb2jGkQtv1OZ3qy8P3FW3U+ei2zGOQ4OJfxd/iyCuBljVgeeqkEUNZzM7GFX6sxpa0KEpBz2jDK3aUY3XyL0Xip3JS2jvktuCt/acNpu2nuw6HO7s1p+D6801mUwSf043oSf0Y5GbvhqSMGJMPcpfDmxAoXkW57ciRJJ93ggiNxKLgh4VVQy1UEQJn6X7c2ie3jbvrArbbfUzuI7aKFKZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=garmin.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuoT2u+MUoe8jakbTDJJDsPwPE+TfxojRxSTXBOOzac=;
 b=czISQ2upJbeHic7EHBFlNzTZUjEjh1q2p4bfVDouxDmt5NhLuaTc7MQGft/mzhLJP/FytvLaCVQK5djQaMXtOV9FyM/+PQrUKKBjqAGYCeScxuYEsilpJwW7MnD5fqf9hjT6VaZk2Q2z5buiIGqYGhbkHw6tvCcUNiqoBoEMElHxT3YUsnPYmR1XJTx6xujFZcRTIBdGvkFHyCX0ar3UVHHfDlZCUkWU2g6F6jfqUxspzw+HKF4dxur8TATrf3L3Xhrpe6mUQFtpuUQFyXAemI+4seMlgNMaUwPqaOR+5F5ozmQOY77D82vfatNmtSnkjtvTI1D8RpUq/PCqV5r3VA==
Received: from CH0PR03CA0356.namprd03.prod.outlook.com (2603:10b6:610:11a::34)
 by MW4PR04MB7172.namprd04.prod.outlook.com (2603:10b6:303:71::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 16:17:48 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::f7) by CH0PR03CA0356.outlook.office365.com
 (2603:10b6:610:11a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27 via Frontend
 Transport; Thu, 7 Mar 2024 16:17:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Thu, 7 Mar 2024 16:17:47 +0000
Received: from OLAWPA-EXMB12.ad.garmin.com (10.5.144.16) by
 olawpa-edge2.garmin.com (10.60.4.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 7 Mar 2024 10:17:42 -0600
Received: from kc3wpa-exmb7.ad.garmin.com (10.65.32.87) by
 OLAWPA-EXMB12.ad.garmin.com (10.5.144.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 10:17:46 -0600
Received: from kc3wpa-exmb3.ad.garmin.com (10.65.32.83) by
 kc3wpa-exmb7.ad.garmin.com (10.65.32.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 7 Mar 2024 10:17:46 -0600
Received: from ola-jnrkg73.ad.garmin.com (10.5.209.17) by mail.garmin.com
 (10.65.32.83) with Microsoft SMTP Server id 15.2.1258.28 via Frontend
 Transport; Thu, 7 Mar 2024 10:17:46 -0600
From: Colin McAllister <colin.mcallister@garmin.com>
To: <u-boot@lists.denx.de>
CC: Colin McAllister <colin.mcallister@garmin.com>, <JPEWhacker@gmail.com>,
 <sjg@chromium.org>
Subject: [PATCH 1/2] android_ab: Add missing semicolon
Date: Thu, 7 Mar 2024 10:17:10 -0600
Message-ID: <20240307161711.3177729-2-colin.mcallister@garmin.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240307161711.3177729-1-colin.mcallister@garmin.com>
References: <20240307161711.3177729-1-colin.mcallister@garmin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|MW4PR04MB7172:EE_
X-MS-Office365-Filtering-Correlation-Id: bd886bd2-01a4-48ad-4b72-08dc3ec220c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LVqiY1QB4v5Ug/TdNyaMq9M4Z1SnKidtlCVTsln9zLliW1ytJn1b/4nJjEwOHl9IVfG4dRVzMn3gExpmBhXF22p0mpqUIer5IJ7i6n2JwZl1fC3QHTboOwgdtG2OaV0bxWxkP4+DVXH/JH7Bu/JrYTw43JI8yC6etBFdwo6ahoPp1MIjh71jGvzNRlzHGQNpJgyUDUbor2i1V1TzD4pQYwG9X6amKdaArPSHmoCRryX9kzsGp7eaXAFVWaBfFbYCOXl2jDBVePtQC/KWnMVcyGqoJfwz+0shzquPLEMEYnk+pz/trTQCNE9yq+t9nbpvptx+6omCqo7CFJNPlWXWW3JKQUyrX3ve8hTVkVS/afD5VUydaLRsFI2w/cvW9q/Wc3A5m6ogP7ODFdQMBtqWnp/EpJL+vab3mWvKWs3noGfsTBcaHgUB0evfi3BnBwp1uTIsXnahNHZ4XB4dWnIO/l8c/CpOYecBSJtodEfsJwYaF2dWEiclGmj3ROi7x3i7caXv57Y/3Axfg8NmTxm9j2P8OrXNU6PGfNPO4lltjboLmY0G16kDOzxKlnAKZ71UGgqunriRCBXGh2RGYH9EPmMjf5c+iqki8gejLDXuGz8G7hVi3obpLCCLsc7ASRBWK4ZmM2eOpTZJ2jMzLhW8dll/1RKknLqaS5p80LgRjLH6o8hatefUDM/uUYpXYIg4pK1snQhvYSQ0zj3Ha5j0+2AyqOT7xqUn3Po+D7ZUwHGEA9UdPItWlouYfYp2VfRT
X-Forefront-Antispam-Report: CIP:204.77.163.244; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:edgetransport.garmin.com; PTR:extedge.garmin.com;
 CAT:NONE; SFS:(13230031)(376005)(82310400014)(36860700004); DIR:OUT; SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 16:17:47.3143 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd886bd2-01a4-48ad-4b72-08dc3ec220c4
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d; Ip=[204.77.163.244];
 Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7172
X-Proofpoint-ORIG-GUID: U_uS6NrqlJHjklOGtbAP0W1Hsz6xy1bk
X-Proofpoint-GUID: U_uS6NrqlJHjklOGtbAP0W1Hsz6xy1bk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_12,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1011 mlxlogscore=999 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403070112
X-Mailman-Approved-At: Thu, 07 Mar 2024 17:18:26 +0100
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

Found a missing semicolon in code protected by a #if that will never
evaluate to true due to a separate issue. Fixing this issue before
addressing the #if.

Signed-off-by: Colin McAllister <colin.mcallister@garmin.com>
Cc: Joshua Watt <JPEWhacker@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
---
 boot/android_ab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/android_ab.c b/boot/android_ab.c
index c9df6d2b4b..9a3d15ec60 100644
--- a/boot/android_ab.c
+++ b/boot/android_ab.c
@@ -221,7 +221,7 @@ int ab_select_slot(struct blk_desc *dev_desc, struct di=
sk_partition *part_info,
 #if ANDROID_AB_BACKUP_OFFSET
                crc32_le =3D ab_control_compute_crc(backup_abc);
                if (backup_abc->crc32_le !=3D crc32_le) {
-                       log_err("ANDROID: Invalid backup CRC-32 ")
+                       log_err("ANDROID: Invalid backup CRC-32 ");
                        log_err("expected %.8x, found %.8x),",
                                crc32_le, backup_abc->crc32_le);
 #endif
--
2.43.2


________________________________

CONFIDENTIALITY NOTICE: This email and any attachments are for the sole use=
 of the intended recipient(s) and contain information that may be Garmin co=
nfidential and/or Garmin legally privileged. If you have received this emai=
l in error, please notify the sender by reply email and delete the message.=
 Any disclosure, copying, distribution or use of this communication (includ=
ing attachments) by someone other than the intended recipient is prohibited=
. Thank you.
