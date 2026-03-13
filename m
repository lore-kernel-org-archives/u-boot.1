Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53491107BCE2
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 20:14:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F4E2842FC;
	Fri, 13 Mar 2026 21:14:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=garmin.com header.i=@garmin.com header.b="Dp/cAutD";
	dkim=pass (2048-bit key; unprotected) header.d=garmin.com header.i=@garmin.com header.b="eAZcqksA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5198A8430A; Fri, 13 Mar 2026 21:14:28 +0100 (CET)
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com
 [205.220.165.212])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D602A842F4
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 21:14:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=8532df2eba=colin.mcallister@garmin.com
Received: from pps.filterd (m0220295.ppops.net [127.0.0.1])
 by mx0a-000eb902.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62DBJ2pH3424116
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 15:14:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pps1; bh=4OvCvilisLbRHBpINNzOOkeYB62
 C2/ZACTfJ1kS8ShM=; b=Dp/cAutDE6XYLCbuUwbLpdOdRv38YMl9cMMMvWpB4yg
 9BFdWVhW0l/13DAlbiL9t9nQNcBkYbndo4od7kTNfP9EZzZXSuMiUo32EAf8zWBO
 tcbyMujJKhHDCWphLbpRVG0pBWFZWdeb5rONQk7XWI+EWTmDd4IY3bIFF59GRMT1
 tod7tptB0+aHk7EKXiPr6UK1W8KqjUoBmnoc+MDfvXRTuES90LdjmtK/uNMbuOn0
 Ia4tGSYNPZhIfkwI/hTtNYYdxrFf8NHSTf3HMr7mliJifhZUwzgsCRfjcWmFXyRb
 Qy/OKxNbZpmCqZ/fPb40ojJ2ZOw+y8dM+e4uBHhMLSA==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020117.outbound.protection.outlook.com [52.101.46.117])
 by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 4cvhkd108r-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 15:14:23 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I6cC4FFn1pU2XwaBDuzVQf3RbEZT/mfn+K5I3Pvbg8i8tatiwio7yJ4PN/GlIP6cJS/uyme9zz7eGKkmtql/5973j1USuhHvdUd5OlRgq2wdPEIEBcg+zrVRo2oBw7a0JUSG10wadBOOV09TKvRxHmCFY8Dr8JqOPvFUspVz8XxJqxiWKP/D7L2UJxgYlP+RGP8LaX+aFh6yQsRjuGpTfTwfm7QTeJPK1ULKUWkG3xfVkor1VI2irF8z+Y2DxSKqNzcN06KsiDmXT58oTNhNwzy0e1S1FbbkxQ1STUTCd6f3Su1BmDT0CBJqxljc93w+vySp4bfAiFBUN6lSIbHeJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OvCvilisLbRHBpINNzOOkeYB62C2/ZACTfJ1kS8ShM=;
 b=ZpAuw9CH7Qem0qPdwaQJAUVsi/a1mzIXTBbKPcHzGlqW/nw144AXMa7ooXKmNoX6YCoqZhoFl0eCgjY8JDYTejvcm8LNM0QlcKf4/oBrEYGxuCx5/6vEJVr91KkpjTf7V5r6jbs4N2j+eErxcEPuRqvMckdCFiPId0euzJiNuynzMUkNhNxhI3BJRrIcVhn5uEMT7Y4RbyLw5VlE6O5GMRx7+iZSQnz6XGrx8fL7e2Yr3gFoKmTqlIsK1GgsfoX0QZWK806TTtEB02lc2RmjWL8V4sXaemcB3ifQrPbgdME/vLLmPzectVrb2cURGC+BSe3OaswG6DxwfObd+uzVQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=garmin.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OvCvilisLbRHBpINNzOOkeYB62C2/ZACTfJ1kS8ShM=;
 b=eAZcqksAjgTfSpCG7obvR3pXOM0/SHmOVBNpwN+AC9JQa6TFG71ptc5NQgO0UKhqW/q7HJ8/BHmT+yHNFYXMjy1Ne7i+maDtcdOaJ/KXzk1kmROt3s5eJ8QOWsvPz1PKRp/C7C3bQTDExaAOF+9XtASXfKOzLWa8uVgAFLShrEoc5VwZ04zrAEuqZoGOOEbUs49q3bBp0aI+JxQmVydcNKTxYmnuL1OAabMr/As1LFRNEmIvp3xj68hTQNCVU3gUmcxpWlnBVB084AtT/alHVqrbXaQQO/ADQ0EB/LPmvI7fpwKeTYufYXxDNC5y2RRlAePsZlx0C/bC0szIC3+llA==
Received: from BN0PR02CA0026.namprd02.prod.outlook.com (2603:10b6:408:e4::31)
 by MN6PR04MB9456.namprd04.prod.outlook.com (2603:10b6:208:501::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.17; Fri, 13 Mar
 2026 20:14:10 +0000
Received: from BN2PEPF000055DD.namprd21.prod.outlook.com
 (2603:10b6:408:e4:cafe::84) by BN0PR02CA0026.outlook.office365.com
 (2603:10b6:408:e4::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.16 via Frontend Transport; Fri,
 13 Mar 2026 20:14:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 BN2PEPF000055DD.mail.protection.outlook.com (10.167.245.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.1 via Frontend Transport; Fri, 13 Mar 2026 20:14:21 +0000
Received: from kc3wpa-exmb3.ad.garmin.com (10.65.32.83) by cv1wpa-edge1
 (10.60.4.254) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 13 Mar
 2026 15:14:22 -0500
Received: from KC3WPA-EXSE01.ad.garmin.com (10.65.32.84) by
 kc3wpa-exmb3.ad.garmin.com (10.65.32.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 13 Mar 2026 15:14:17 -0500
Received: from ola-jnrkg73.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.65.32.84) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 13 Mar 2026 15:14:17 -0500
From: Colin Pinnell McAllister <colin.mcallister@garmin.com>
To: <u-boot@lists.denx.de>
CC: Colin Pinnell McAllister <colin.mcallister@garmin.com>
Subject: [PATCH] android_ab: fix slot selection
Date: Fri, 13 Mar 2026 15:14:15 -0500
Message-ID: <20260313201415.255744-1-colin.mcallister@garmin.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DD:EE_|MN6PR04MB9456:EE_
X-MS-Office365-Filtering-Correlation-Id: c0cf6b7d-a73b-4f67-bfd5-08de813d1d75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: hZW6gDH+gVWyj/YJ1qoyJGm1LZUErVLVmJACxdqQ9VHmEAFG7dHOGRGXlO5b+dUHzoVdE7hAcCMHN4zUXNg25WEfWdeV31RHvbDa1x2W7hQY3aD3NloMciyY4JMpv7gOitSTMFDts6N8vRtVmeDi9tm4s4vTed9sd3aHqiOduCBRfAOqFkJhlMCuzHi3GmFtFJPnSzk0GAEx3DsJ0uAWVSkBRW+dZkvD9VR2eYoCOCz6FDmNQInQVIttxThdjiMQHZY2zuDcDu4HJhHm4S5oHkvGfNG4reWD+p1mF0XRbDwadzj0V664m302FoulGEN6BYPOw8e2kYMskWwOsUC7ozsgXBimPBj+EfEcdiuJsFKsTuB+isHX8bzI5QjbYRnytV5NYfXSSeLxw1VbbDq4aGdc8v91dcm6FTkSxJ5v8YYYk9YqmuVa0JKCPra13RsmGJ6LpWVawSF0TV4pMDNYaBQtyFSBRAIIjcrZzhYf7zMq4vcy8WBYN8inydd7u74PUELm6WfIUQ4TWGIU3rHaarsjbi9UH1R8rl9kFYKxXtdiBAqQk9hFkdQhlaz4wLe9YzUMFpdibTvXjyZXnnzUVQKNGHepSmjeRhT0C3NF94M2UsAkyiDW2lWhgt5fU+2pAJlGsabgT6xgWEopQd9HltgLTmVM3cEJN6eijHjZcE+cZ514q6kX88g3RezJTTFtzsTKB7H4rchiQSiMnPhiHDISwmSJcdkt7ZRLJHcUC/2epezlzQoNTtoCogvTglYPsA1/K7+dpkDMb6P5QQZpIQ==
X-Forefront-Antispam-Report: CIP:204.77.163.244; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:edgetransport.garmin.com; PTR:extedge.garmin.com;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CXYRsA2zyHycfPxofaA8ZZGE7YHzzBsF8E65s1gjVRarkLwMKLsoaSVtktvHxIBMU4g0Q5Xc62hA77+hxyZ330C+nifrN81CTwHJQGW9bchJ1XOp4B/58AWp9rqS3XJNUCoy6Ejazy0gMn59uqCo9eLHuv3euxSSr3m5uC7zImmZiUZrR/Zxw7LR1D4tqHlvTjrmf3CFyWfDFQUI9KbT80wKbEX3QDozY9CY8gEUUSxCKxmaPAG1AS+8IjA+/Urtng+e39KFNvc0zdZiBpQsPzCa4S62Aub5LiQ7SU059FQKsRk9A5fwRAwkciPuRpRoX/59XzTzywjWgb/cdryPogbgGCOmyCEKq9Rl11A2K54jua9/eQvP3yN+Swtu2nvfdj4W6QxHaYdNVUze/DXGke54eqP+K7yRl8fArRgBpPF3Dicjk3FWKEMy4xvV6akO
X-Exchange-RoutingPolicyChecked: fQSmuv/Sx+YdNSZoCaGXAEar0UpEUPFqMAoiBAVs8V5TYWJ3a2CEyz4PykHpOixnN92TYcyzeyve0uom5JIk0pW17Nw8i8VrY1qUHMiIg15sfWFgYTCc9w9GSaXZ49YwAixWc2dRlib38CoBQ4e67rPesmkjasgrIFAn/IsAIJJzuDqE4tMO3mdOzPYMPgwpuxEIktgrDv2N29p3rvuLy8OsiGSt5gdWuilf2DgKuSi8vbqXejjmiIW9LqS3W1r8Yo2Yc5EPN6gSD/jvRhXJNyrWuSy/GMh9dE5AXzp3dXEBQu9PKpO7H9FjkHusUxv1+z75Rso9BnRlQjwlw3UD8A==
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 20:14:21.9005 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0cf6b7d-a73b-4f67-bfd5-08de813d1d75
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d; Ip=[204.77.163.244];
 Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR04MB9456
X-Authority-Analysis: v=2.4 cv=A+hh/qWG c=1 sm=1 tr=0 ts=69b4701f cx=c_pps
 a=RrdOQlmmxp+bQeXV/0G7LQ==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Yq5XynenixoA:10 a=qm69fr9Wx_0A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=mT958ORwFhrKhj1UMJhN:22 a=YTLoTrrJEVZ6FbNdITQk:22
 a=NbHB2C0EAAAA:8 a=SwPCltq1ZuTUIynPOrAA:9 cc=ntf
X-Proofpoint-GUID: bl-x-mbBAP9e6nz3bn36P4J7NaFRopN8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDE2MSBTYWx0ZWRfXwjvIijtr+qeR
 TjMjY/hWCEnQfJ87UEulJh/s/y830vCezlo4VeIleV1504sc3TjPtrGGwlavKwfX245PLMEIj4M
 8Qw7SoSR/NuXI7xEgFzAhCsZd8Gkma32TMRG67wvJ/SS6oK6UsOwGijg7gC4BhCzmkQZQMXXNF0
 Td7vNMRwhlk56Smpm7Fe+n4MMD+hVbCa1D/YKeHTttvOAxyNQDVqX/QyGb/Hs7Zh71TNsSG8Qe5
 6nyvljV+pz+p7uT3/AckHoCmsTU25MBGUA2vOXw7GkWg9f9CmnO5gYU9Un5FJGoTPDuyPMav0RJ
 4L7QmISdVUC898ZkidyG4rVr2gj6WkM0qvs4MkrPjAh1/l3ubNk1Kl5OzepwTE2WVLMxnM3E/gH
 ZdM0tIIPqVmiqxPS2XkiCryCIYoxc4g5mEUk2hOuHueP6y/CtdXaewAjlcWxgvsHzq38g71itAF
 xAUtNDDwGz6W/nHmv2ox4FfdNpNV2obzCf2aIZfw=
X-Proofpoint-ORIG-GUID: bl-x-mbBAP9e6nz3bn36P4J7NaFRopN8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_04,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 clxscore=1011 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc=notification route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603130161
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

The boot selection rules state that a slot is bootable if it is not
corrupted and either has tries remaining or has already booted
successfully. However, slots that have tries_remaining =3D=3D 0 and
successful_boot =3D=3D 1 will be disregarded when picking the slot to
attempt.

Update the selection logic so slots marked successful remain eligible
even when their tries counter is zero. Also include the successful_boot
state in the unbootable-slot debug output.

Signed-off-by: Colin Pinnell McAllister <colin.mcallister@garmin.com>
---

An alternative would be to keep the existing behavior and update the
comment in boot/android_ab.c:276 to remove the successful_boot
condition. I do prefer updating the logic to match the documented rules.
Currently, the userspace AB code will need to increment the tries
counter for a slot that has booted successfully but has no tries left.

 boot/android_ab.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/boot/android_ab.c b/boot/android_ab.c
index 13e82dbcb7f..93e74f81d4b 100644
--- a/boot/android_ab.c
+++ b/boot/android_ab.c
@@ -289,11 +289,14 @@ int ab_select_slot(struct blk_desc *dev_desc, struct =
disk_partition *part_info,
        slot =3D -1;
        for (i =3D 0; i < abc->nb_slot; ++i) {
                if (abc->slot_info[i].verity_corrupted ||
-                   !abc->slot_info[i].tries_remaining) {
+                   (!abc->slot_info[i].tries_remaining &&
+                        !abc->slot_info[i].successful_boot)) {
                        log_debug("ANDROID: unbootable slot %d tries: %d, "=
,
                                  i, abc->slot_info[i].tries_remaining);
-                       log_debug("corrupt: %d\n",
+                       log_debug("corrupt: %d, ",
                                  abc->slot_info[i].verity_corrupted);
+                       log_debug("successful: %d\n",
+                                 abc->slot_info[i].successful_boot);
                        continue;
                }
                log_debug("ANDROID: bootable slot %d pri: %d, tries: %d, ",
--
2.53.0


________________________________

CONFIDENTIALITY NOTICE: This email and any attachments are for the sole use=
 of the intended recipient(s) and contain information that may be Garmin co=
nfidential and/or Garmin legally privileged. If you have received this emai=
l in error, please notify the sender by reply email and delete the message.=
 Any disclosure, copying, distribution or use of this communication (includ=
ing attachments) by someone other than the intended recipient is prohibited=
. Thank you.

________________________________

CONFIDENTIALITY NOTICE: This email and any attachments are for the sole use=
 of the intended recipient(s) and contain information that may be Garmin co=
nfidential and/or Garmin legally privileged. If you have received this emai=
l in error, please notify the sender by reply email and delete the message.=
 Any disclosure, copying, distribution or use of this communication (includ=
ing attachments) by someone other than the intended recipient is prohibited=
. Thank you.
