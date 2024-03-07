Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCC2C48BF6
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 16:18:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D962287E6D;
	Thu,  7 Mar 2024 17:18:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=garmin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=garmin.com header.i=@garmin.com header.b="nozKHBNZ";
	dkim=pass (2048-bit key; unprotected) header.d=garmin.com header.i=@garmin.com header.b="PnP+qLYV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 165FA87B77; Thu,  7 Mar 2024 17:18:08 +0100 (CET)
Received: from mx0b-000eb902.pphosted.com (mx0b-000eb902.pphosted.com
 [205.220.177.212])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1109A87D16
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 17:17:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=garmin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Colin.McAllister@garmin.com
Received: from pps.filterd (m0220298.ppops.net [127.0.0.1])
 by mx0a-000eb902.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 427G0kS6008895; Thu, 7 Mar 2024 10:17:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=pps1;
 bh=dgwgTrrdoTguGiFOb3HNuC1mpYLhKzAHKUeTEvAqsCE=; b=nozKHBNZGnG2
 a3MWLVSJL9BUiLfFfpxq+BN4VzXrAmJXqjFxPZgpWVpTms4fCLft9hMM02ib+HHt
 Q0GXyikrCNwnJt9t3gXLwqQsg7ZatTWQoDqpVLCsfBkdw/mqzWrpikq4i4ToQLlR
 QNNj/dwVMazk3/3mWEepybN75nHcP1KAnAG3FjfedhHuEW1Uhft7HnxwJktm+pJA
 tr5SX2d3mNoVmCEPeO0la62DgmHKI68Oe5kk9RQ+oiGcGny4Xo+ht+ba5r7oMLJq
 mmeCQm1ynUge6L1sHzWIrMrdcy2HCDC7tfZaxyJ8XXAAAjhfJMAJEWgt6Q/dmyhB
 OdfPAtI/jw==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 3wqbgehmxa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 Mar 2024 10:17:51 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nk7j+GItdpBzDWU5wkBtuDRkQ13QZCjNRxmDdin778YT6S89E2Z+Jh3AWx844/buOVSsEY5ZCp8fXD0ecOzWUBp0rEjoLEV9ZeRx42sOnnGmLPYBWNQJ+LpLuVhMaYpEqwGmTp66kAcTiWEOa7ECzDjoyawUOzQX09EEJi4aQHU8cg0BeOWX14M1w+GpZK4wDgisUG74ILYc5yUKnWGPHksTv2itNalzeGeZxED+mdD0inyH14w73mzpUud4I1pc2ZXoAOvu8VrHM0NZ7AiW6vukV0eJm3Pzi7Xst/7JyK+D50WTNYLdPo1dgdOiQCWpfSrOssBAB3epeIMz9Cpkjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgwgTrrdoTguGiFOb3HNuC1mpYLhKzAHKUeTEvAqsCE=;
 b=gYqh8EsE47zE2ZYCxyJFjGyVtdwHSEwrw8l3BBPdOwdbBpQo+MEeatwx1dZgix4VuC+1fKcFhD0+g1fUuzvEMDwjb32jQ8FP1m29GstrkooZiyeUshj9w7PeEAXLyzMqCewF9no2ROZ5Qfd/CeLMKVQFOiynNvMsTcX04TMaYnTJNw/9/7A3I7G/pI6+U5FucyVqhDPrNZLx51poeDQJajRRb19mLbskjzUf9pWbTfOxBXFu6+ECAKRAPzZJnU3S87NGljYf26xsaLSFSJy61n7UipycteYRvefrp3o80svIXTsAl9OadW6CnKiUMfE9DtSQ5c3TiibMBWg0gqHe+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=garmin.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgwgTrrdoTguGiFOb3HNuC1mpYLhKzAHKUeTEvAqsCE=;
 b=PnP+qLYV4Opdu9wwGcKLZSwq2xJnc1IefYgXwPzWW4+f1se46SLHRU8K2uTvfwPtc3U/c4n5ZLA/j4sx5BjZufTqwzk77N6YhwM7k4zuuS+94Q0++FDrYZRwnyARLxQM8IMxFrLjoti0TR9G/lX/kPhoUFxZTo6Lq8qv23/U1y6WZ8nrshnTvbtq4a3s/3jUdOrWFZy2nkqtfShtL5lmVKT2PiYTn8KJ4/BsRocg4jPyRwaxLqlr1kjNdKGh6o3yvwyLkJ4dhwAMIe1TlPCPl5zMMbfEiCWlB/rA7JgNvaHRYR7IIvIMs+SvkkiuR469VGwK5XcKqviMnZFEMkqmjQ==
Received: from SJ0PR03CA0135.namprd03.prod.outlook.com (2603:10b6:a03:33c::20)
 by BN0PR04MB7981.namprd04.prod.outlook.com (2603:10b6:408:154::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Thu, 7 Mar
 2024 16:17:48 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:a03:33c:cafe::2b) by SJ0PR03CA0135.outlook.office365.com
 (2603:10b6:a03:33c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26 via Frontend
 Transport; Thu, 7 Mar 2024 16:17:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Thu, 7 Mar 2024 16:17:48 +0000
Received: from OLAWPA-EXMB12.ad.garmin.com (10.5.144.16) by
 olawpa-edge1.garmin.com (10.60.4.227) with Microsoft SMTP Server
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
Subject: [PATCH 2/2] android_ab: Fix ANDROID_AB_BACKUP_OFFSET
Date: Thu, 7 Mar 2024 10:17:11 -0600
Message-ID: <20240307161711.3177729-3-colin.mcallister@garmin.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240307161711.3177729-1-colin.mcallister@garmin.com>
References: <20240307161711.3177729-1-colin.mcallister@garmin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|BN0PR04MB7981:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c2e7525-4e01-4702-a45d-08dc3ec2214d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IgIzzCpRXLNE4BmIqmilogNqmnLaN5VIQVXmRr0V2Mg/FtzjHz8p0mQYrdqFfi9FV31zgPGRUecfuTRZE1WBrLsazlOusGmykacvXSLZp3TsOSRNeThdL21XNHw2BlApVsV/2DlFlORhu7/FOO7u0WOK6XpKLVvk7azaHBtFwBIyKaDzd1glf4rtFZZ+MOkoqW+algptS7meMKM73gSrgr6DTztnA4ahhFLkwrX6gKMmayn7z60cHXHQwyvyHW0dh7WdBjNyiGVjEkvaEyqVI/x/vo/EZnt6LQNsmpuJ1vRtIh4gW9fwzlK6JR9DU89uwogMDlKReVTosUCysExF0Ub3UBMqQIDT8Q44BDc+9vwYhQUpjTQQ1hNnjlBO8/btSzi/ZGRCvsGp4vNbVgTntvTysvWKdPkKjWyumLuPMRcTSCWwInVzneTayZq132vG6jEkGy5VJUkrHip7hIbo/CI1tFW2yOL5pKndh9kf2MI45Z4Xai3AjrSNJ0VtkKIUU6mVCsc7XAC6VqMCR4AFqn6b++rX5tAr5NzqBa/Pb0OD/bjCgh+LdF8C6v9YtOd+NTkHQpofUazLBbuD924Dv9ndmTnXUoLFkOlpkZvkk7Bv5FrehC9Qx9G1m2ybxNzd/sxb6U8uJwWaaevoQC+Uw2ibEvZO55eIEQwFg36YZUqUkFfrjEaYJ08pQwVwAXBuTjN2fyEvBX4IfJkImgXx2Rj+/fuT+/nF3pZjT5cXRcwsLo2/sMvdGxEVZ1AzSuZl
X-Forefront-Antispam-Report: CIP:204.77.163.244; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:edgetransport.garmin.com; PTR:extedge.garmin.com;
 CAT:NONE; SFS:(13230031)(36860700004)(376005)(82310400014); DIR:OUT; SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 16:17:48.1675 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c2e7525-4e01-4702-a45d-08dc3ec2214d
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d; Ip=[204.77.163.244];
 Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB7981
X-Proofpoint-GUID: SD9LaxL4RdXIki3i7yDG5UPjNRzm6rOr
X-Proofpoint-ORIG-GUID: SD9LaxL4RdXIki3i7yDG5UPjNRzm6rOr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_07,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403070110
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

Currently, setting CONFIG_AB_BACKUP_OFFSET in a target's defconfig will
not actually enable the #if protected code in android_ab.c. This is
because "CONFIG_" should have been prepended to the config macro, or the
macros defined in kconfig.h could have been used.

Each use of AB_BACKUP_OFFSET is now wrapped within CONFIG_VAL().

Signed-off-by: Colin McAllister <colin.mcallister@garmin.com>
Cc: Joshua Watt <JPEWhacker@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
---
 boot/android_ab.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/boot/android_ab.c b/boot/android_ab.c
index 9a3d15ec60..a80040749d 100644
--- a/boot/android_ab.c
+++ b/boot/android_ab.c
@@ -191,7 +191,7 @@ int ab_select_slot(struct blk_desc *dev_desc, struct di=
sk_partition *part_info,
        int slot, i, ret;
        bool store_needed =3D false;
        char slot_suffix[4];
-#if ANDROID_AB_BACKUP_OFFSET
+#if CONFIG_VAL(ANDROID_AB_BACKUP_OFFSET)
        struct bootloader_control *backup_abc =3D NULL;
 #endif

@@ -205,9 +205,9 @@ int ab_select_slot(struct blk_desc *dev_desc, struct di=
sk_partition *part_info,
                return ret;
        }

-#if ANDROID_AB_BACKUP_OFFSET
+#if CONFIG_VAL(ANDROID_AB_BACKUP_OFFSET)
        ret =3D ab_control_create_from_disk(dev_desc, part_info, &backup_ab=
c,
-                                         ANDROID_AB_BACKUP_OFFSET);
+                                         CONFIG_VAL(ANDROID_AB_BACKUP_OFFS=
ET));
        if (ret < 0) {
                free(abc);
                return ret;
@@ -218,7 +218,7 @@ int ab_select_slot(struct blk_desc *dev_desc, struct di=
sk_partition *part_info,
        if (abc->crc32_le !=3D crc32_le) {
                log_err("ANDROID: Invalid CRC-32 (expected %.8x, found %.8x=
),",
                        crc32_le, abc->crc32_le);
-#if ANDROID_AB_BACKUP_OFFSET
+#if CONFIG_VAL(ANDROID_AB_BACKUP_OFFSET)
                crc32_le =3D ab_control_compute_crc(backup_abc);
                if (backup_abc->crc32_le !=3D crc32_le) {
                        log_err("ANDROID: Invalid backup CRC-32 ");
@@ -230,13 +230,13 @@ int ab_select_slot(struct blk_desc *dev_desc, struct =
disk_partition *part_info,

                        ret =3D ab_control_default(abc);
                        if (ret < 0) {
-#if ANDROID_AB_BACKUP_OFFSET
+#if CONFIG_VAL(ANDROID_AB_BACKUP_OFFSET)
                                free(backup_abc);
 #endif
                                free(abc);
                                return -ENODATA;
                        }
-#if ANDROID_AB_BACKUP_OFFSET
+#if CONFIG_VAL(ANDROID_AB_BACKUP_OFFSET)
                } else {
                        /*
                         * Backup is valid. Copy it to the primary
@@ -249,7 +249,7 @@ int ab_select_slot(struct blk_desc *dev_desc, struct di=
sk_partition *part_info,

        if (abc->magic !=3D BOOT_CTRL_MAGIC) {
                log_err("ANDROID: Unknown A/B metadata: %.8x\n", abc->magic=
);
-#if ANDROID_AB_BACKUP_OFFSET
+#if CONFIG_VAL(ANDROID_AB_BACKUP_OFFSET)
                free(backup_abc);
 #endif
                free(abc);
@@ -259,7 +259,7 @@ int ab_select_slot(struct blk_desc *dev_desc, struct di=
sk_partition *part_info,
        if (abc->version > BOOT_CTRL_VERSION) {
                log_err("ANDROID: Unsupported A/B metadata version: %.8x\n"=
,
                        abc->version);
-#if ANDROID_AB_BACKUP_OFFSET
+#if CONFIG_VAL(ANDROID_AB_BACKUP_OFFSET)
                free(backup_abc);
 #endif
                free(abc);
@@ -338,7 +338,7 @@ int ab_select_slot(struct blk_desc *dev_desc, struct di=
sk_partition *part_info,
                abc->crc32_le =3D ab_control_compute_crc(abc);
                ret =3D ab_control_store(dev_desc, part_info, abc, 0);
                if (ret < 0) {
-#if ANDROID_AB_BACKUP_OFFSET
+#if CONFIG_VAL(ANDROID_AB_BACKUP_OFFSET)
                        free(backup_abc);
 #endif
                        free(abc);
@@ -346,14 +346,14 @@ int ab_select_slot(struct blk_desc *dev_desc, struct =
disk_partition *part_info,
                }
        }

-#if ANDROID_AB_BACKUP_OFFSET
+#if CONFIG_VAL(ANDROID_AB_BACKUP_OFFSET)
        /*
         * If the backup doesn't match the primary, write the primary
         * to the backup offset
         */
        if (memcmp(backup_abc, abc, sizeof(*abc)) !=3D 0) {
                ret =3D ab_control_store(dev_desc, part_info, abc,
-                                      ANDROID_AB_BACKUP_OFFSET);
+                                      CONFIG_VAL(ANDROID_AB_BACKUP_OFFSET)=
);
                if (ret < 0) {
                        free(backup_abc);
                        free(abc);
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
