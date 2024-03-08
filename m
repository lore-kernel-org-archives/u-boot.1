Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C51DC54E4A
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 17:00:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EBB787F0D;
	Fri,  8 Mar 2024 18:00:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=garmin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=garmin.com header.i=@garmin.com header.b="Ff3cX3KA";
	dkim=pass (2048-bit key; unprotected) header.d=garmin.com header.i=@garmin.com header.b="qSHmfvij";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EF3C87F03; Fri,  8 Mar 2024 18:00:17 +0100 (CET)
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com
 [205.220.165.212])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4043F83333
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 18:00:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=garmin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Colin.McAllister@garmin.com
Received: from pps.filterd (m0220296.ppops.net [127.0.0.1])
 by mx0a-000eb902.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 428H09P5007846; Fri, 8 Mar 2024 11:00:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=pps1;
 bh=t8brhelf+kxoCvHAizWSTRt3unpEnm2GKoMhpt23u8M=; b=Ff3cX3KACnyW
 HMGA5miR8sCQSe2zEc5uwu+hu+jFBQ50s271Pp832I9+Ocxue4XM8IlyLVuojp90
 uqbeH6hMgjN1gvqXdRhoxoxERWK1VEFNyRSG2d5Oa92ya4dpqF9L9P1xb3NStOIK
 TMkG4w1gVUAaqZtAo6UG2W+aF5ajA7/tXoiPOqlQHMoTbmaN3kWBannr/CORKAdb
 bNo1s2e5FL0DPOe5rvkI6FV4sSE5YRbOB35Y6ymm0L+ZGclzZGX5A1nONl2tgHkc
 MxbOU5VWhxowOY0HTSzVuYHrirrqaYIAoIVrYlJTT7QWbb21/l6WVaA4+SPa6jQ/
 wRfOrWXDJQ==
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
 by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 3wr6pcg012-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 11:00:08 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqR8Ypu81xTL61bxwGIcAX5ajinl3e+uaxApmQ5NDQUQ81TAZmW57zrPcWP7IA77owUFJkuJjKObmedXsjJ4yibEPhs3WKzitghd4wfTGOh7CoMx/dDfTdNr9Ggg06H3npM7qmiBTEVqgqtrdiSBCb6UrZUUQIWOhlZiNV7XItILaPHqVoy/UGtip8Zpi/N5o4FH/WuTDJOdm1TdnHhG2k6v0LGzycQHbzpLXDWLV46KQvpfavxBxqHaCs+FJEyiU3nHDgF4mH7KwfOoOsY/eaThzzTZiaNxlMaEgQAn3pywDSZF9KDIrW8kPl3JGHpXK6HbQ+PK159SE9++23ciHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8brhelf+kxoCvHAizWSTRt3unpEnm2GKoMhpt23u8M=;
 b=C/itoxQ1IXL4d0+GADXPd2AL3GUuBUwcVp/cWcyxPep6FjphleRpvhU5rrVKzi68B3QrDv+2iFEGmJZ48TCfjJ/aRu8ZxD89HKEE4Kor40hYCgetQjktvJa6L+Z7n65qixkSeea4xJd8XfLL2ymuwoefeXPm3sMInTolsoOne1J/6Ndwf1hf0tgdf+7igA/Xp9Gmk1JjvyU7Trj/AIpi5D57RK/4AIYCXO9bBi3iyGgFicYdX2T6fWxe3wqzFF2JwhzENZALcswcpZb+guZUrvmOI4zlqCvWQbF5cilfWLmBV/cOQh8FgNEii9rb7Szw9DQfi7JzJMaFZY1f0jgj7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=garmin.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8brhelf+kxoCvHAizWSTRt3unpEnm2GKoMhpt23u8M=;
 b=qSHmfvijoH8tN80LvIyjupRJvksu+pzFbvwaZ1YlsbtuZKWhev4Q9HMEJpWPzZXJn6B3Hi5sbLxQpD3eulHhPwz1I0VDmTYbfshglOVJ5/N1w45MF4EnVfeWHzKtcDaCnlA/aT1XX/n9Fjkw+c2Xaf+n9FVsmyKqNw5Q5bJxCUPTtEVcX1mKyuUG/1anM1OrZ0GJIMfLji5kO09cSuLtToKbjpiQNvqmZA+fnmyRwde7gHsvLj2zI06dzKhapIXd0s+MNaOQfnVQf2g267LjkMxNfgZU+awqpcrIk7sgcRvVzkTheXNpMZARj2Ye4EubZcmUUmvSnBKkQ3niGgdCaw==
Received: from BYAPR21CA0016.namprd21.prod.outlook.com (2603:10b6:a03:114::26)
 by PH7PR04MB8973.namprd04.prod.outlook.com (2603:10b6:510:2f9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Fri, 8 Mar
 2024 17:00:00 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::87) by BYAPR21CA0016.outlook.office365.com
 (2603:10b6:a03:114::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.10 via Frontend
 Transport; Fri, 8 Mar 2024 17:00:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 17:00:00 +0000
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
Subject: [PATCH v3 2/2] android_ab: Fix ANDROID_AB_BACKUP_OFFSET
Date: Fri, 8 Mar 2024 10:59:37 -0600
Message-ID: <20240308165937.270499-3-colin.mcallister@garmin.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240308165937.270499-1-colin.mcallister@garmin.com>
References: <20240307161711.3177729-1-colin.mcallister@garmin.com>
 <20240308165937.270499-1-colin.mcallister@garmin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|PH7PR04MB8973:EE_
X-MS-Office365-Filtering-Correlation-Id: 462f7130-ecdd-4679-1afa-08dc3f9130ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dMjLgc+oWSjfiFuKAJz2O+2i9DJzXybGIrSE+KDEALcNqi2ML6tEPxBXGZD+Of4dFbYf+nCl+RfXzbqLh9UbLb2D5uy2bPVYX59Zm1TPANl9yfApFR+qPCE55tu/uMgfgg5SS4r0nmz0ocbE5HoEGmRCT8D9xo9k2T9JMcklHTJ7fDqTB4Ev5z3vv8XIBLgmM5bJQd2SZegAIYbdO50izE5vJ6lln4wV4HwTdSXzRGD69HOThzPOIrLECE+iAZKK14DucJs1ATWfCYOdxp9Tw487LczowkXdt9WKtk3wTM92vVrPLC7JdgKUDPclVZWQ1arRICIE7Dd3byROwrorPcudQ5NrwJOl6YMOalo7dJsmhEWRbFClgW4eNDRBB3/Kga+tZc97YnjUue8i34rObfeNf199oEBYprYeh+z1G2k1bxDNTQhV70IzGPcrdrrlt175zPYIY7S0GusB9vmRDMaarYz0ydTkwf3emZz9211uu4laHB5/6RpTALNHBJ7Y8I6sTRL5F1FCy8+WIaAtoM0kDyhjr44M53xCqDP/EAWatuThrghw9L6mcxINfUqCTfTDRC5X8N+qqnO4JNrA1cI3mdsZ+BWnutjt4NeFCDoUpigLj1X9kopsyNIATDU8iZ/bi7Ohv4pIC1uLff5X5u36Crq9K+vE/o8b4u/ZGySM5Ds+PkbRCKyqVZJIt+rTIIVNG053FvuKWhTuNZ8+RTYXLzttKbhkM73wfVHnJgvRzuAb3ToBc/sI7u0XRrYQ
X-Forefront-Antispam-Report: CIP:204.77.163.244; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:edgetransport.garmin.com; PTR:extedge.garmin.com;
 CAT:NONE; SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 17:00:00.1545 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 462f7130-ecdd-4679-1afa-08dc3f9130ed
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d; Ip=[204.77.163.244];
 Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8973
X-Proofpoint-ORIG-GUID: s_Zf118Ody3tLpgJK1cC2sfEP_vRUW2B
X-Proofpoint-GUID: s_Zf118Ody3tLpgJK1cC2sfEP_vRUW2B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 adultscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403080135
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

Fixes: 3430f24bc6 ("android_ab: Try backup booloader_message")
Signed-off-by: Colin McAllister <colin.mcallister@garmin.com>
Cc: Joshua Watt <JPEWhacker@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
---
v2:
  - Replaced #if conditionals with C if conditionals
  - Opted to use CONFIG_ANDROID_AB_BACKUP_OFFSET directly instead of
    macros in kconfig.h as CONFIG_ANDROID_AB_BACKUP_OFFSET is not a
        boolean or tristate value and doesn't have different values when
        building SPL or TPL.
v3:
  - Added "Fixes:" tag

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
