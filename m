Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09557C54E4A
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 22:11:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E75087E52;
	Thu,  7 Mar 2024 23:11:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=garmin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=garmin.com header.i=@garmin.com header.b="tAShDYr/";
	dkim=pass (2048-bit key; unprotected) header.d=garmin.com header.i=@garmin.com header.b="jqNQ+7E7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D08087E29; Thu,  7 Mar 2024 23:11:13 +0100 (CET)
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com
 [205.220.165.212])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B11A5878E2
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 23:11:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=garmin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Colin.McAllister@garmin.com
Received: from pps.filterd (m0220296.ppops.net [127.0.0.1])
 by mx0a-000eb902.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 427H3UM1027423; Thu, 7 Mar 2024 16:11:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=pps1;
 bh=K3OzmdspIi2yzFnxcld4VN3mpWnNhC0elIk+GgwmYhA=; b=tAShDYr/8Ol7
 Hu9mQXDUmTDl+PQvZN70/H1bs4+2JDJEbWHmKwNEhWY9OEJ5yYd3Th10JpB42PUF
 2WqUZP8moRLYxSFGLdVuAMtvBIHV1TTlIr0bcUm4GO8Afr/PO/aQzfPj49P7KoI9
 F9PwsFP8ek+ATZ4gOrnWoDOLp+v/D+5FKOeh1X6m8lHFQqVfQ59XzQd1emKwkVTx
 kLJT8EIUI6k42bAofewFwcwIRbXsf6l8RYc8u8xvCyQ0sRSkVyNX8bQAbH+LCV/X
 miv35RcYS8PqMChGqrvS9VKpjFiFbjYVD9Ptv2gAGWMaI/Eb6PAKbgmiRrPX8jjc
 6ZW06JIrtg==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 3wqhn60hjs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 Mar 2024 16:11:02 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PalxLTGiy3LumLiO19Wj7za+Gh3ZEOHcG+iaiMa4+famnajei53/oLcfeTcSV3i7aeULLDx7dzrXak5kEbMUk6/HIKEr0LG5UUfb5RhVtYmyrfBQqeuXjHXL25mWq+ljGo40b7FOFqFu3BVfNQcD6R476y7vtJ3pqRS0+BHykUqGWR1r72GgQGczr7YDB0pyxFtFD3rRLCkuECGtTBqz5gCuqsQte08nInJkDVRCu2lIQahxIlIw6phssZFQqHjaqJiO3MxFC5U5fUyUX+fuMT0GHp6wqvUGMByeUNSfW19M7zUQZLzN0t5yon6kOwVM0PToXIUdcoBcStuwaYHdPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3OzmdspIi2yzFnxcld4VN3mpWnNhC0elIk+GgwmYhA=;
 b=hinZgfmFZDv6L/gk24ZojD0wp1RxIYlVigcoz30RzOUbJkwkEcPN/9NVb+z9q40AXFEwakZaGeaKfBR7jD0EMpF0aVRj1NekwQAsUTP9wf5Vf2G25bjgwaZsS++izG7ImqdVb0/T8rTZPhtkolFAoHx52IzUd1tfdEWmMlBc5ys54zAVAzKhHGzqmX0sfAoRjSVlwN3UIr2Nf3lCAI6DrjUB/OoOsSmaDJxbgdIc1NW0Fg574PsmkK3MPYL0gThsObwHbvc0QIRgoVk9QzQh09xBxQSjmh4OhgOqZ6SFRS5aOALVDA2Qz8hThscAtHdrngwQ/zbvLyVFlc+L2KxDFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=garmin.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3OzmdspIi2yzFnxcld4VN3mpWnNhC0elIk+GgwmYhA=;
 b=jqNQ+7E7S63dN4joEqaE6J860mNvHT9wGi4O54P4YBlqrlz8Ldhtntz/Vf2vDET/g7j8gSD6u5XltMFv7fc3oCubgHmwUwgmfeVKNENVISRjAivTLNpPvtBQuZPJELavF92yPAZBINxuweQeh/424pI2rP9XPcDm4SMf8zuqAkWuopUgBdhV5M4mddepuuM64W35HxAA5j1wytYJ6gllhVmwTKsVhPyMYFVtleqbAQiOctbBMzusmNxfowS15aFDkPU1u4o1Hmz2PhYJEcn+i6/qpQ6QzZbt9NjLRVDlex24w4cxVOcewRgDPXM9RE8ArUSK1tE1gpauDL6VG8NfDQ==
Received: from CH2PR07CA0010.namprd07.prod.outlook.com (2603:10b6:610:20::23)
 by MN2PR04MB6750.namprd04.prod.outlook.com (2603:10b6:208:19f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 22:11:00 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:610:20:cafe::62) by CH2PR07CA0010.outlook.office365.com
 (2603:10b6:610:20::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27 via Frontend
 Transport; Thu, 7 Mar 2024 22:10:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Thu, 7 Mar 2024 22:10:59 +0000
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
Subject: [PATCH v2 2/2] android_ab: Fix ANDROID_AB_BACKUP_OFFSET
Date: Thu, 7 Mar 2024 16:10:29 -0600
Message-ID: <20240307221030.3685767-3-colin.mcallister@garmin.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240307221030.3685767-1-colin.mcallister@garmin.com>
References: <20240307161711.3177729-1-colin.mcallister@garmin.com>
 <20240307221030.3685767-1-colin.mcallister@garmin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|MN2PR04MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: cc787a5a-c842-4df5-ae7e-08dc3ef3785e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z4GPrE/Daj4SfYLANmDXojQ74VJsdeLI2+S6ci2rqcoBDJEF44F9TytMFfA4CxNCsHp4h/AFzrc1Gb91jc0dUeMHSKUAU5wbn3AmoK658QTaXAc2cyduwbITUbbba7lnJIbjHnKgu+Gnm4UbBYuqMdD3guyHfTIuB1assNBS0tgh6NhLxBEW8SfP0Frz8wRmu8G1WlT/VM7EI/bQoMjTB9NLPbwGoFG6raIZ+cBULhZOb2kDYSXCO5hnje6jfgSkNnc7F6geAzdlRQSKnT8/IDQFfVhDPyN27H9T2uge6auOAoKCronIeuo4da860cfR0D3rZmEDx6ij9eu3gCMePEM6qVg4a4lstf139baeLTyQkJwBAysKB3791au4eQz75S+PHujEU72hYvP0WqI5Bh32OganPKIN5AeYRrCQAtzZsYuazhw5oLAJJ6GTFh5fMRnmx13E4LX2oMbXxKbIrGBbGuXaMe07HQt2tgz/eDSyMWz6KwiOh0Uf8tIRG5RO02a6NQjwNlUYjCXtRhCW53IHjadhmRaPsRNP6pxvm9LD6Tk3t/c+xcjJ7uS3gnrS6SLfTyuD/b1XiKHz7o/DP4hhrAG8oaxfS8jCpsEZdH0IiuC3sWH0M8juYBKqOir7uthyp4SCj5krrfg20CHZpU9rfqIz3pF/4c9ovnJq/Ucx2qkGwlWb/kXgLOkUTzkk5WxhsZipTbWQk3sm+uUEs93DIPvi+APzCOCFT/qxYF6im4NCcgX8/c/m+ZHgH3qe
X-Forefront-Antispam-Report: CIP:204.77.163.244; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:edgetransport.garmin.com; PTR:extedge.garmin.com;
 CAT:NONE; SFS:(13230031)(376005)(36860700004)(82310400014); DIR:OUT; SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 22:10:59.6120 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc787a5a-c842-4df5-ae7e-08dc3ef3785e
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d; Ip=[204.77.163.244];
 Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6750
X-Proofpoint-GUID: iXbU6m6AdKFC18pNQ-BCzg8LfPeptpTZ
X-Proofpoint-ORIG-GUID: iXbU6m6AdKFC18pNQ-BCzg8LfPeptpTZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_16,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403070159
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

The code included by ANDROID_AB_BACKUP_OFFSET has been refactored to no
longer be conditionally compiled by preprocessor conditionals and
instead use C conditionals. This better aligns with the Linux kernel
style guide.

Signed-off-by: Colin McAllister <colin.mcallister@garmin.com>
Cc: Joshua Watt <JPEWhacker@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
---
 boot/android_ab.c | 97 ++++++++++++++++++++++-------------------------
 1 file changed, 45 insertions(+), 52 deletions(-)

diff --git a/boot/android_ab.c b/boot/android_ab.c
index 9a3d15ec60..f547aa64e4 100644
--- a/boot/android_ab.c
+++ b/boot/android_ab.c
@@ -187,13 +187,12 @@ int ab_select_slot(struct blk_desc *dev_desc, struct =
disk_partition *part_info,
                   bool dec_tries)
 {
        struct bootloader_control *abc =3D NULL;
+       struct bootloader_control *backup_abc =3D NULL;
        u32 crc32_le;
        int slot, i, ret;
        bool store_needed =3D false;
+       bool valid_backup =3D false;
        char slot_suffix[4];
-#if ANDROID_AB_BACKUP_OFFSET
-       struct bootloader_control *backup_abc =3D NULL;
-#endif

        ret =3D ab_control_create_from_disk(dev_desc, part_info, &abc, 0);
        if (ret < 0) {
@@ -205,53 +204,49 @@ int ab_select_slot(struct blk_desc *dev_desc, struct =
disk_partition *part_info,
                return ret;
        }

-#if ANDROID_AB_BACKUP_OFFSET
-       ret =3D ab_control_create_from_disk(dev_desc, part_info, &backup_ab=
c,
-                                         ANDROID_AB_BACKUP_OFFSET);
-       if (ret < 0) {
-               free(abc);
-               return ret;
+       if (CONFIG_ANDROID_AB_BACKUP_OFFSET) {
+               ret =3D ab_control_create_from_disk(dev_desc, part_info, &b=
ackup_abc,
+                                                 CONFIG_ANDROID_AB_BACKUP_=
OFFSET);
+               if (ret < 0) {
+                       free(abc);
+                       return ret;
+               }
        }
-#endif

        crc32_le =3D ab_control_compute_crc(abc);
        if (abc->crc32_le !=3D crc32_le) {
                log_err("ANDROID: Invalid CRC-32 (expected %.8x, found %.8x=
),",
                        crc32_le, abc->crc32_le);
-#if ANDROID_AB_BACKUP_OFFSET
-               crc32_le =3D ab_control_compute_crc(backup_abc);
-               if (backup_abc->crc32_le !=3D crc32_le) {
-                       log_err("ANDROID: Invalid backup CRC-32 ");
-                       log_err("expected %.8x, found %.8x),",
-                               crc32_le, backup_abc->crc32_le);
-#endif
-
-                       log_err("re-initializing A/B metadata.\n");
+               if (CONFIG_ANDROID_AB_BACKUP_OFFSET) {
+                       crc32_le =3D ab_control_compute_crc(backup_abc);
+                       if (backup_abc->crc32_le !=3D crc32_le) {
+                               log_err(" ANDROID: Invalid backup CRC-32 ")=
;
+                               log_err("(expected %.8x, found %.8x),",
+                                       crc32_le, backup_abc->crc32_le);
+                       } else {
+                               valid_backup =3D true;
+                               log_info(" copying A/B metadata from backup=
.\n");
+                               memcpy(abc, backup_abc, sizeof(*abc));
+                       }
+               }

+               if (!valid_backup) {
+                       log_err(" re-initializing A/B metadata.\n");
                        ret =3D ab_control_default(abc);
                        if (ret < 0) {
-#if ANDROID_AB_BACKUP_OFFSET
-                               free(backup_abc);
-#endif
+                               if (CONFIG_ANDROID_AB_BACKUP_OFFSET)
+                                       free(backup_abc);
                                free(abc);
                                return -ENODATA;
                        }
-#if ANDROID_AB_BACKUP_OFFSET
-               } else {
-                       /*
-                        * Backup is valid. Copy it to the primary
-                        */
-                       memcpy(abc, backup_abc, sizeof(*abc));
                }
-#endif
                store_needed =3D true;
        }

        if (abc->magic !=3D BOOT_CTRL_MAGIC) {
                log_err("ANDROID: Unknown A/B metadata: %.8x\n", abc->magic=
);
-#if ANDROID_AB_BACKUP_OFFSET
-               free(backup_abc);
-#endif
+               if (CONFIG_ANDROID_AB_BACKUP_OFFSET)
+                       free(backup_abc);
                free(abc);
                return -ENODATA;
        }
@@ -259,9 +254,8 @@ int ab_select_slot(struct blk_desc *dev_desc, struct di=
sk_partition *part_info,
        if (abc->version > BOOT_CTRL_VERSION) {
                log_err("ANDROID: Unsupported A/B metadata version: %.8x\n"=
,
                        abc->version);
-#if ANDROID_AB_BACKUP_OFFSET
-               free(backup_abc);
-#endif
+               if (CONFIG_ANDROID_AB_BACKUP_OFFSET)
+                       free(backup_abc);
                free(abc);
                return -ENODATA;
        }
@@ -338,30 +332,29 @@ int ab_select_slot(struct blk_desc *dev_desc, struct =
disk_partition *part_info,
                abc->crc32_le =3D ab_control_compute_crc(abc);
                ret =3D ab_control_store(dev_desc, part_info, abc, 0);
                if (ret < 0) {
-#if ANDROID_AB_BACKUP_OFFSET
-                       free(backup_abc);
-#endif
+                       if (CONFIG_ANDROID_AB_BACKUP_OFFSET)
+                               free(backup_abc);
                        free(abc);
                        return ret;
                }
        }

-#if ANDROID_AB_BACKUP_OFFSET
-       /*
-        * If the backup doesn't match the primary, write the primary
-        * to the backup offset
-        */
-       if (memcmp(backup_abc, abc, sizeof(*abc)) !=3D 0) {
-               ret =3D ab_control_store(dev_desc, part_info, abc,
-                                      ANDROID_AB_BACKUP_OFFSET);
-               if (ret < 0) {
-                       free(backup_abc);
-                       free(abc);
-                       return ret;
+       if (CONFIG_ANDROID_AB_BACKUP_OFFSET) {
+               /*
+               * If the backup doesn't match the primary, write the primar=
y
+               * to the backup offset
+               */
+               if (memcmp(backup_abc, abc, sizeof(*abc)) !=3D 0) {
+                       ret =3D ab_control_store(dev_desc, part_info, abc,
+                                              CONFIG_ANDROID_AB_BACKUP_OFF=
SET);
+                       if (ret < 0) {
+                               free(backup_abc);
+                               free(abc);
+                               return ret;
+                       }
                }
+               free(backup_abc);
        }
-       free(backup_abc);
-#endif

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
