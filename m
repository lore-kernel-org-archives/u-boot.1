Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84580C5475B
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 17:00:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3607987EEB;
	Fri,  8 Mar 2024 18:00:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=garmin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=garmin.com header.i=@garmin.com header.b="CEWnVJ4j";
	dkim=pass (2048-bit key; unprotected) header.d=garmin.com header.i=@garmin.com header.b="lCe7KR/W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93BBC87EEB; Fri,  8 Mar 2024 18:00:14 +0100 (CET)
Received: from mx0b-000eb902.pphosted.com (mx0b-000eb902.pphosted.com
 [205.220.177.212])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1F0587E96
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 18:00:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=garmin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Colin.McAllister@garmin.com
Received: from pps.filterd (m0220299.ppops.net [127.0.0.1])
 by mx0a-000eb902.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 428DWLCH007786; Fri, 8 Mar 2024 11:00:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=pps1;
 bh=5vHRNt/+tjMx3uFWWHz6DDRdWomwHkHbvEzWJmw0Q40=; b=CEWnVJ4jsWDE
 8jNDlWTVO2gRd8AcurABbxhMt/Yb+eyt0FPXazwYhHNpeAe2Pp+MwEefwTK9u0Hn
 YtlJIVjLlbaI5DKUcq0yB0rSmBme9ePR1TcxSaYzXCceeDHzvGCYNy1ygv9mpTgM
 eZpjEgUDLntUrEGxQGazrVzx9Gq/vuqU38tk9fOnie8G88qtxbELAVSMT85JF5B+
 s+vUBisEpF+w528bq+WyOaJegsZm5z7aunilww8vrNzXZyZz+NUaim9xZpCobP53
 2TVfAH2winGvGoi7mdYZmC5LNvRqWLuSdsHtsB7IUM2PaY3MJp0qeSWeBFqkUeTo
 WM+K4LZGJw==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 3wr0hys721-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 11:00:00 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+CZBzDDyUNQkNt8YPoWt3/e1YmM0g/kTsa2wAvcBC3dKS+u/ibjMclU6pPLSJHQWBYg3Qb+CQVbyCxqBtITTQTqCGSN+OQgqWkBE+B0xSID9OOpPF4S6tdT/gqjtoJ8SiIFfCtcHr532D3HoM9J1/VL+zJVIVmpRYN9A7lbXSS9r210W+U5o5mwSHHgtHBRk6Vhqbch1B9mlWyjFfc2XBOwjAr1R7LRCAix/wr5QlMHvIjXvtRyo6AAr9Am5vapvkQs4+3fxJsgl1/qJQ6MC9sgsBb6dsF+AbcIW3UcgDXEtmWuB8SkXBJHWIJZqDeWgwqgvY0nkdiQ6AeaRdTOWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vHRNt/+tjMx3uFWWHz6DDRdWomwHkHbvEzWJmw0Q40=;
 b=cpmupXmC0Oo9Tnaa9tv/KgCSUPZnDh5l+GwNiSv8YI0h/G21lZwObQhhLTuVUBF/actG828XWxygLGlWyQsJ12UIxxtLxqHnJA8TkHO6kf4C7kt4nEfzHJUKaF1S2+qw/bsNfG9d4UwpoX1fhDsAf2PH5f0w6+RSYTL0YqCnwgxOAFuoOF4hoWfi0VG8kpnot9eQwPzZF442RXC7fMcznTc7QnG5lp4hlgBdkNIxugjrgl0Gc+vPWZZydjGgadKLISqs3OXfbsYtKpDDyufXZQQcamqkFAyEVAdHl/EMBg5jbogT1IfhVAeXPOHg1BGCZi85k+8Ocrccshbfi2zc8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=garmin.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vHRNt/+tjMx3uFWWHz6DDRdWomwHkHbvEzWJmw0Q40=;
 b=lCe7KR/Wsr33QZYaq0tufo4w5WuziNLtvGredWkITP5BVor6fSWvSYZ4qhRDxnIRwtih2MrcmFd3h01muBPs3FV+JBPs8hIiVryzPKZU7cvSejSjHTooN42L259zFPNp37/OJhftPJ+0yKciFH6XUhtVZjHLthvlE3FkxDJq/ypJnUTYCiEaUr/lE7cRAAi5lzHRH+hasmhkAL+Z0Sxq5WAniF6uHIMn2np7qLEFTzT4TdJwsEbOgGm3++KUWQz5G0/R4NJBbdfEcZCfaCLFMQHWCdxwG31caSB1oYwZDhRSdS74xSPnivVMNly/3D4DUKn2DRljvWHTo6eCs3A1DA==
Received: from BYAPR21CA0018.namprd21.prod.outlook.com (2603:10b6:a03:114::28)
 by SJ0PR04MB7165.namprd04.prod.outlook.com (2603:10b6:a03:2a3::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 16:59:59 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::e8) by BYAPR21CA0018.outlook.office365.com
 (2603:10b6:a03:114::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.10 via Frontend
 Transport; Fri, 8 Mar 2024 16:59:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 16:59:58 +0000
Received: from OLAWPA-EXMB12.ad.garmin.com (10.5.144.16) by
 olawpa-edge4.garmin.com (10.60.4.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 8 Mar 2024 10:59:53 -0600
Received: from cv1wpa-exmb1.ad.garmin.com (10.5.144.71) by
 OLAWPA-EXMB12.ad.garmin.com (10.5.144.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 10:59:56 -0600
Received: from ola-jnrkg73.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.71) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 8 Mar 2024 10:59:56 -0600
From: Colin McAllister <colin.mcallister@garmin.com>
To: <u-boot@lists.denx.de>
CC: Colin McAllister <colin.mcallister@garmin.com>, <JPEWhacker@gmail.com>,
 <sjg@chromium.org>, Sam Protsenko <semen.protsenko@linaro.org>, "Mattijs
 Korpershoek" <mkorpershoek@baylibre.com>, Igor Opaniuk
 <igor.opaniuk@gmail.com>
Subject: [PATCH v3 1/2] android_ab: Add missing semicolon
Date: Fri, 8 Mar 2024 10:59:36 -0600
Message-ID: <20240308165937.270499-2-colin.mcallister@garmin.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240308165937.270499-1-colin.mcallister@garmin.com>
References: <20240307161711.3177729-1-colin.mcallister@garmin.com>
 <20240308165937.270499-1-colin.mcallister@garmin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|SJ0PR04MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: d6fbc501-57c8-4b31-fdd8-08dc3f91300c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: snE9nebiDFSqu1eGTpih/qHQMBnqgBTwpUwcVmXejVPoG22/DbZb9xkddoH/nlEIdywRJ76/650vsKA1wchkI/tKhOa4W1iMFIWwwKyD3h0erbhWmjXf0KgHWGM9YcUx3Um90VaFFO9r+3r8jpGTy5AnJ4oCfhWEKLjiRnWS/szW0GBNUUv0guxILlIxoLNSgijwYofoIhrFrzSJGOydNNmOEr+ZT8Upl3uLK1SFb+Gi1BQWbKvPFJ0pl1tCnYO1G5nKzdfsZIGc0cE6hDA/f1dFLMiObhXfdmiUfXm1jOr44XlTGUJ4nLHlCROEsgsgv+cP1XEVmoHlv2vPZMhYHUg6S0gdBL+VZPEfXEDscQm7gZ4zm7bwwiu6+nAaNnvXMJeElZbOtPC3OrCKFfuAYHZoRijPafss87ERX5FQRXDzbHjHdwv8atgOEpPX4OCZD+FRaFeO81oWDJiUKEnEAd9xa1VeeZRqj3F+JeBuiTR5MYAKJZh0tFB4Nr9UOptnVlI3Yhr9fk/ztSZB+nADvWwzvITb27g6w6HwbWRlLjgLFeSRNaoFH5B+5KDhXyn1esFsiJbeFlHY/WZzO5OB9PnaW0dffsvjf4N0g1w7CYs3YcNRAf/k5IqJqwHtDU5gOfERHZDT9w4ntkgBkxBajGhkOpHUA2kyDwPdwfDsBzfTarGTjRFdoq1H0QjuYfoOaUkbPBeSUYgRx5CCv5czusZX009QghNaUikuzepLNfOwvK3bvejpvxWGvf6JK8Sz
X-Forefront-Antispam-Report: CIP:204.77.163.244; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:edgetransport.garmin.com; PTR:extedge.garmin.com;
 CAT:NONE; SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 16:59:58.7327 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6fbc501-57c8-4b31-fdd8-08dc3f91300c
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d; Ip=[204.77.163.244];
 Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7165
X-Proofpoint-GUID: uggtKBu59vgvb5S2hW896PNPYZMkd03W
X-Proofpoint-ORIG-GUID: uggtKBu59vgvb5S2hW896PNPYZMkd03W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxlogscore=999
 adultscore=0 impostorscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403080134
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

Fixes: 3430f24bc6 ("android_ab: Try backup booloader_message")
Signed-off-by: Colin McAllister <colin.mcallister@garmin.com>
Cc: Joshua Watt <JPEWhacker@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
---
v2: No changes
v3: Added "Fixes:" tag

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
