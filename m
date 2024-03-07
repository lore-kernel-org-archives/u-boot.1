Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B497AC54798
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 22:11:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A0E887E83;
	Thu,  7 Mar 2024 23:11:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=garmin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=garmin.com header.i=@garmin.com header.b="nrdg3D4Q";
	dkim=pass (2048-bit key; unprotected) header.d=garmin.com header.i=@garmin.com header.b="nsP+2iUz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C8EB87D80; Thu,  7 Mar 2024 23:11:13 +0100 (CET)
Received: from mx0b-000eb902.pphosted.com (mx0b-000eb902.pphosted.com
 [205.220.177.212])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82A3787DEC
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 23:11:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=garmin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Colin.McAllister@garmin.com
Received: from pps.filterd (m0220299.ppops.net [127.0.0.1])
 by mx0a-000eb902.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 427LcM3h007858; Thu, 7 Mar 2024 16:11:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=pps1;
 bh=OuoT2u+MUoe8jakbTDJJDsPwPE+TfxojRxSTXBOOzac=; b=nrdg3D4QDDTt
 Y9pZiyvm6aNxLM0B5AvpXI8rJnmLJ6EUaPEOoK5cTYnyqpThJodv/uQV7ISjpILr
 X+NurCGgLkGVxgs8yxVH03QXBJd1tkzTPSlTog27y7LzGaoCfk9rRlKDbuP3xLqc
 zzEaXkmGooGpu0QLpkLdUhTqj0E+ockqktgriJW70Cjr3iJyoDDLmuHuuJswdM4W
 90iSL06vD1gb0rdm67WNJm0DVgP9W0PYiiLz/cGKrCytFOv82ja20YueVtQK99e0
 NqPP/WUqTrIV3PHM3cXEsYh99ZYPToHrjAPjIjcwwR/TnO0wts9E1TuYb1AH3OQr
 1oz8jnvXPQ==
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
 by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 3wqfnp8yyx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 Mar 2024 16:11:04 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TH35bqQrl6/wF3AB5RpymWhhqbf7qN5D+EDinynKLrSZLMczlim/OT949btAwvy++Dhu7kEMaqvy2y9kYgEkIybkfM3mLSuQJ06Pwz+khvaMUzLYRswWBctNnyn4tGl0QHwCcBF255U1VoZJLFwkTOh3dVpLaflv+h8NjMiV7TjZbNO4oeC4tduRVPqD7deW64oRYqUPwe7gX3dlcMecE0FXtWVs+Q3zKFbF1fSeDkZgMlH02k/taXg2zSAzYmpPCLsZXYPdKU6Uh/gNllrwTrji0fQRgVFwJXT7ZwLOY+1Fdw2WpcUMl76KfRbHPM+S3tuSVVPdHbP7l09AGuJruw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuoT2u+MUoe8jakbTDJJDsPwPE+TfxojRxSTXBOOzac=;
 b=AAUGeESGfxYPYod+jvUoFD8cXyCFE81x1lTS1QBdwcW+RmxjWRZ2BzsM3OD+VVTf+IlQ+M6n4Exsw0tYhczmcX1COc9UxI8icNvogoAUVvBLu66LYaZkpUARlyGjziaYjUPeNApermTHGxeLX8Ymy0wWu5D87gf8v2J6q54NpAoIQDqyLop/1NSgAAQagIT6a2hWK20p/uWbZYN/MZu0cvpZnrN0GsGMAa+fOqvxEGcCFCjYgblYwJ8HbtziuAcqmcJ5YSmgaQqC3VMzvRrRTxrqQW6hRb+I2hz8F+VnthbM7etyV95blkTR16xelNNAnMaE4yZhD2n2g6iM85aGJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=garmin.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuoT2u+MUoe8jakbTDJJDsPwPE+TfxojRxSTXBOOzac=;
 b=nsP+2iUz2XD0Ly+VVtbAjHgxOIFjBeoCa+y/nWZFM4hY6taFe5WxZU/f7BmYpXGHhgdXbnS4JpUXmsFPHo/ctzg8ILZIsbjL1fRkjny/NFx6O+mrZlNzxJN3zvZ/551xNW0WZT0oT5IffVnHcpLC/NMxpTa7G5sCb3a0ulYU7RWBqMfOfS76emca1Eb/GD6c6p6cJVMoaO/72zCLBWbpaYInLRn/MBCq7nUuaZBUlwc7vhxO53zGHV5VVVpI/iBAreDr+fe2iYh1j7SVgmRu6J8c9QZJsJvSQ+fgddD+WS0pnoXcvpjqbpbrF2mp7LtC/dyvrWMSPyKwr9MS6wtyuw==
Received: from CH5P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::16)
 by BY1PR04MB8750.namprd04.prod.outlook.com (2603:10b6:a03:532::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 22:10:59 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::bb) by CH5P222CA0005.outlook.office365.com
 (2603:10b6:610:1ee::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27 via Frontend
 Transport; Thu, 7 Mar 2024 22:10:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Thu, 7 Mar 2024 22:10:58 +0000
Received: from cv1wpa-exmb2.ad.garmin.com (10.5.144.72) by
 olawpa-edge1.garmin.com (10.60.4.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 7 Mar 2024 16:10:39 -0600
Received: from cv1wpa-exmb1.ad.garmin.com (10.5.144.71) by
 CV1WPA-EXMB2.ad.garmin.com (10.5.144.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 16:10:45 -0600
Received: from ola-jnrkg73.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.71) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 7 Mar 2024 16:10:45 -0600
From: Colin McAllister <colin.mcallister@garmin.com>
To: <u-boot@lists.denx.de>
CC: Colin McAllister <colin.mcallister@garmin.com>, <JPEWhacker@gmail.com>,
 <sjg@chromium.org>
Subject: [PATCH v2 1/2] android_ab: Add missing semicolon
Date: Thu, 7 Mar 2024 16:10:28 -0600
Message-ID: <20240307221030.3685767-2-colin.mcallister@garmin.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240307221030.3685767-1-colin.mcallister@garmin.com>
References: <20240307161711.3177729-1-colin.mcallister@garmin.com>
 <20240307221030.3685767-1-colin.mcallister@garmin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|BY1PR04MB8750:EE_
X-MS-Office365-Filtering-Correlation-Id: 41786a28-048d-4b04-459b-08dc3ef377e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RPpHPY0Dv8yl4NbzmYKX5KBQ+ubQYkMDdrYyNNtKgxQC7AyQKdSYK5YC97X90b8sO88zzAXwquna7+60L7aqIMfpmw2cGHc8b6IfGRTKwMG/0kaUK7DZB48Ctzw/oFCteFpCqP8mZoa54gqV+yYdWKe4UyWZIVbjJ4l/AXd4C3gozN6f2Ya/hAkq5A8LMDsEfON63I6PAMxSKnJQgaK8skoAYxLVqOEZLA6AKebJQJnYw+Jck+Uu9xzHH4fdeYQwERQUF6u1QbDS9xcFkC/phcxotbSnn41I76o1HlrT5ahdWuhHtUQRK3CpCr/nNlFLf2wxln9u2dp3NzjsEcu+TMdLZTWQh5ToqcAHV2KvCEc1tDCsju7hc4mLw8wkIQIXh0bN+XWM8vFwlF2w/YbFpIqEi2cizI06Mb4KxGTkp9HQLUJPLVoEJgs6RsJzuI092SFR7TeneNm/mOcXqmxKw/iHfDFX4KviRPZDmXYwioW58ZJKs84qviVk6omW+XXm3tba+98PqUq6Krvjl5p6n9857mRxvZJ8iVaUH+eCew2pVntBor+qyuHlWcEQ3Txpsiff+0HplO3IvV0ao8hVEbv+S8pNcJkZp2RsK/sOyl2JAexhvIXmaav0Z23T2NoNbbxaiJMSzmjrtL/M5Wf+5GY6dtEB9FXKiJXGxsDrMakfM43Ycqb4LhIiZc6JkNuRqtASy0LSASIDE+kbFtpheij/qGz9D2PuRJL/L5hZTq2z+qqaDFxGamNbKlO/lr6V
X-Forefront-Antispam-Report: CIP:204.77.163.244; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:edgetransport.garmin.com; PTR:extedge.garmin.com;
 CAT:NONE; SFS:(13230031)(82310400014)(376005)(36860700004); DIR:OUT; SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 22:10:58.8319 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41786a28-048d-4b04-459b-08dc3ef377e5
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d; Ip=[204.77.163.244];
 Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR04MB8750
X-Proofpoint-ORIG-GUID: mOvd6md8DQcrd9iiID0PP5Exr-PsUwxG
X-Proofpoint-GUID: mOvd6md8DQcrd9iiID0PP5Exr-PsUwxG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_16,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 suspectscore=0 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403070159
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
