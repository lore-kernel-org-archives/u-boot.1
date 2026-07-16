Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B961C44511
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 16:22:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DB8384F02;
	Thu, 16 Jul 2026 18:09:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="B1RZxmLu";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ICwgMu6O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DA2284BBF; Thu, 16 Jul 2026 16:54:52 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADF6380398
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 16:54:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-liu@ti.com
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66GDLUJ43949351
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 09:54:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=HrCDTDI5RjuUp
 Zsa7eFycCcO5yoxB5gMcC9Pch/23Lg=; b=B1RZxmLuZv7CnxJpIt3lpGJGUruTD
 +MrInbhywk6MOK0nDNMaPGIzH9ZBs3iN1c6RKuaVxAXi74h2CCnmUz2H+ppjjOmG
 qHv+qe14d2lhy+MDHNRbdW/xE5UoH/1MAEIQh/dU0tSAqybEvMe2mDXZ6RFjIS1b
 fhYAjN84sFVooTQXcpCOba/GaYK2HPfXM5xqYf41vAcvpFq/3KRVUtVOKdrOkIBc
 xm1FMNKs+FYFlVEa3eYZA/9TDqToxsuApLy+q0CgbR1xANNGh/joXvh8HQr/9aXZ
 xEjSzQz/Yv69h9hr/FQfLm/IGGvnl2NN28XoSMKxc4yELP6kEL1ekp/9Q==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11011070.outbound.protection.outlook.com
 [40.93.194.70])
 by m0380145.ppops.net (PPS) with ESMTPS id 4fex78966h-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 09:54:47 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r50ko1wLf7uWOX9XZ8OvFH1DUWmaPhs17FqS0PkzLnnDS6r8SDCJcrbbt1MwKC+JxGmnvgomxo14bAD15Rk+RQAcdSIy+irSsW0U8z0dThEsnaO47eOgTBpx3B9wekQ37v8phQFny6zkK1S1FaZTyni2FiwUaWyrMpY8Cuicy8Cb8ZWC9ipG08A9lKW4r0mEo3iKIRAiyQeHUoEkSYL0ngjgGsC7Mlnqe7XwY3hmHWqO4XcTH9nKIrxpYxbY2Cb2MmLD6gg/Hw6j5c0xg+w/FdnDZ9yAd0AP0AvyrZYLeDdyirfgGh93KOiVDJZZTK9TUKwhGj74UA3SQixuj3N3Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HrCDTDI5RjuUpZsa7eFycCcO5yoxB5gMcC9Pch/23Lg=;
 b=CapYRERw6lYpeIFOvcg+SApO9RV4vqBZtOZCRSuaaAEPLTxq635P4n+ys5DTK77OLq5JH9RTHTDFywXl8mpspsOF7Qcu+0FtXYnw7RfAv/DcJTnZireIdilDNdLUagBZnFyvA73Z7AIbv6sV5xSmOlOA4stliHRjTYeGHpD3q0J8CuSz2gSHimUQ/mvq4ZYZ9NPmOaApIBeguIVCm7uBeJkGNEE8F4xBVIU9ntmouTm35uzpP2jcwdj2NVvO1rqPe3p0spzDKwLKktDaOLJ1IllCI6VRfvcU+NLrcz+/QuHzoFtsJMGEqHkYkjGAaN9JgHF7/QdoL7Ivp8Y34y7C+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrCDTDI5RjuUpZsa7eFycCcO5yoxB5gMcC9Pch/23Lg=;
 b=ICwgMu6O1v3IXHHqDAN87CL2ZZ1Gis2fubJ812ZrHPY0dFSgWaVrmwh22E++ls57zJjybreps4xFWij0aw7QF84uh/8jPGqgcE7Y6lyJfLzrbkwLZL7PeNSYVF/056mZhzuBDOII4u5e7J8uv229icEJvdRSMR+9JaEYbA/r6BM=
Received: from MN2PR14CA0008.namprd14.prod.outlook.com (2603:10b6:208:23e::13)
 by IA3PR10MB8164.namprd10.prod.outlook.com (2603:10b6:208:514::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Thu, 16 Jul
 2026 14:54:46 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:23e:cafe::46) by MN2PR14CA0008.outlook.office365.com
 (2603:10b6:208:23e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 14:54:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Thu, 16 Jul 2026 14:54:44 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 16 Jul
 2026 09:54:37 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 16 Jul
 2026 09:54:37 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 16 Jul 2026 09:54:37 -0500
Received: from uda0271908.dhcp.ti.com (uda0271908.dhcp.ti.com [128.247.77.70]
 (may be forged))
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66GEsbn2992473;
 Thu, 16 Jul 2026 09:54:37 -0500
From: Bin Liu <b-liu@ti.com>
To: <u-boot@lists.denx.de>
CC: Neha Malcom Francis <n-francis@ti.com>, Udit Kumar <u-kumar1@ti.com>, "Bin
 Liu" <b-liu@ti.com>
Subject: [PATCH] ram: k3-ddrss: fix ecc range checking bug
Date: Thu, 16 Jul 2026 09:54:37 -0500
Message-ID: <20260716145437.1686611-1-b-liu@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|IA3PR10MB8164:EE_
X-MS-Office365-Filtering-Correlation-Id: 35f913b7-4c2f-4de5-1340-08dee34a2c3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|56012099006|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: 1KnHM54z4sOusZ2zjQ5eT7ChELHgFIWCF3S2y+jOSvV/KXQUx01vjU0vcgA+88yVozw6cRhMptiyInKyN3PHhX/pd1/FvFef4QSKE6g2NL0cfPLJ9Iiu8m+f282Yv1SU4jkuCZfcKAQjLRjrpAy2Rgh73YFWuWzi++h8SdN+S8kabEUOkfhLWPzpcoChw+kemI8Xni41q4Sx9yUNwGHs1sDSD2N83k2GfJ9EkoxCaPSoftXorlntWt9o3aP4D8gTWnAYxm+iFQ0Pm5r7ucDY4R+MaIkKE8EKnm0LMvKLmLvfnUGA547eDq0eN+EKEcKbIim8DPqc/HvNopqycSiWueZ/LNMN8fANwrm6LZVEc2a6vCTkwQU91VkIou01oFVl1dr7M++iqU2UlxVk673E9hkbsZFv+JO/5rtHrnJSV4ZHP1yMBnXMKbjcr9SAK5nS3Bm/1/R07sM6MlpoDZRx5qSd8Npxm5pjtstPBskXMUkawnwqDrPJ+4fxT5PB3pZV+ccpmoVVefolaAKuzAHqjd3LwCD46HRy3nGIbmwwuGhEDy3d5Vs79pfUUX7eKiGMJoEvwnv2HxNDOkmgXbjBCQCTuLAQlN0wGcPDH2FkvHEGfpKEvn3mZpzjHNJKAIkgD2UWTjRXNDRcexuzy9s9kM19JUV97JHBpxEanfiS7tjBPDpOoIG4CFAwvt2cMUjw9hXDSgz4lFPTjvpk9eNKzw==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(56012099006)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kzjDOmoeW/rc3n16PI0OJZoPYEbKW7rqJqxpXYxIccM2YGTyMPk1kp0KL3SdkrcJVBDwVAU/8oAPA6+KGgK5ZctsraUnycF7iAvA7EHAbNaez4xCvYX5nTKAo3BsdfVBeECzUIy0rI3nbsgz/nk3X+Lf+JZDsJWpyUCjBTVDy3x6XuD39r5fMkT9JFcLbFTgXlRrzHByPFtPq2v/j/yVJs0Qo9g3iJdiLNA6x7DJcsGikzWsfw63BFodrbOVzYm54VirOODWY62OjTIsJZg1VVgfwmuR3/RdO/8RFbWZvfv3YD5kJikGAy/frlYFr5c/YsXsHx5BxAhZ6NpC/zAOlEjdy7Nh+HaYrSNmXGG65KhkQuF0aDOHtKJGCALXByto4rrs+m8461L3iU1CoSsw/OFvVZdr+CNVqtIA4+wOU9dNqQ6SsQTkkc8u9Hdy+Wvi
X-Exchange-RoutingPolicyChecked: Pp8dK1FqEnr/2yDoBlsdv9cxLrOMzSu6La55fastyTwTDwl88lfxXLdfkqQqBlWAs/qmzSEatPGIaAx1eVlsSxc4t4Xxccy6ywit8BdeeS0Wf/1ONWPTIURvII68me5v+De7Y+JXNWWDhOL4iFoGJ83tTm6PASFpkj1Qm/KwmbQXeEoryY4okXETtyF6D3ZA/OedeHuREOf/+1wCaJQeqXdSXtUeRsFb9HazqjBIJmm3YGYEDS+r3FWPCI8X3wJN8ZLArguejn7mqE4D/gnzUKz6ss3J1s1NWEU3bxIh9Ue+do5Vg6WRhw6hQ13EfiyGZFJcz34dfvyyOROTIYRqtA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 14:54:44.1113 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f913b7-4c2f-4de5-1340-08dee34a2c3b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8164
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE1MyBTYWx0ZWRfX3kIddM6ORXHi
 QxlFEe5Uzba3Kz9Jc0TfceSnRv2zgMrhbnv1/k48twBpQH2Yk2aie9WGUM1WoZ+059ufxcYQzrc
 CQ5zNFSnkoTDgcrCz8gLfcztf1gXkTp3nxupa4y3B7nRULeCagwpALGobKWdaPjjcs9SXKttpac
 jgNraCywB9dfBMDiIt11Z+YQQ0rq2AmssXosNU1djBC9ZQtuD3IC9Gl+awE05yv7YD17AjS20Pz
 pOKSHBjVQUMFhJbBW2DB56r6XJxw6YzqT/U0rNdgNUWX0rCgSPOZ9eFs2Lr1yoJY6wl4N0+oF0E
 Xp+biVS8xyfvfYvq76zvsQY9oDyr6QwbMrnL6cHqxEQDv9SgYXwGiYdElt4KNddICohbhJJUKye
 5hQ2o+CTS4MekaFwWy40W/wOFXmZ9X5oR6U3Hpg8d4ejVnNWzgEGFt22UH5LDm6vNmlGOtQpUWU
 FO9U50ZyKgpX4Vu/FSQ==
X-Proofpoint-GUID: 8BUhGsd3AQzFP9a6J6GCt1kUa5vOgN2h
X-Authority-Analysis: v=2.4 cv=TeamcxQh c=1 sm=1 tr=0 ts=6a58f0b7 cx=c_pps
 a=W+QshtcN2cchze3Z1b4Psw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=sozttTNsAAAA:8 a=rlIMIUDJTj8RfMpXCe0A:9
X-Proofpoint-ORIG-GUID: 8BUhGsd3AQzFP9a6J6GCt1kUa5vOgN2h
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE1MyBTYWx0ZWRfX+kEp88Jrcl4I
 ERQxdO5gf3ph49IFO1BtgM3JoitPfDqHVGyqF/GJ9aVFrukyBlkGN79WYWUtLptZGr2Lv8WG+1V
 2hGs+NdhPjp7g46AORgxLmZqCnSv86U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160153
X-Mailman-Approved-At: Thu, 16 Jul 2026 18:09:12 +0200
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

The original checking is wrong, it basically compares memory address

    end = r->start + r->range;

with memory size:

    if (end > (ddr_ram_size - ecc_res))

so the if() condition would be always true. This causes the ECC config
never take input from the devicetree.

Fixes: f43f71012254 ("ram: k3-ddrss: Add support for a partial inline ECC region")

Signed-off-by: Bin Liu <b-liu@ti.com>
---
 drivers/ram/k3-ddrss/k3-ddrss.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index 5144470b9313..c406998b20aa 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -931,11 +931,10 @@ static int k3_ddrss_probe(struct udevice *dev)
 			struct k3_ddrss_ecc_region *r = range;
 
 			for (int i = 0; (i < K3_DDRSS_MAX_ECC_REG) && (r->range != 0); i++, r++) {
-				end = r->start + r->range;
 				ddr_ram_size = ddrss->ddr_ram_size;
 				ecc_res = ddrss->ecc_reserved_space;
 
-				if (end > (ddr_ram_size - ecc_res))
+				if (r->range > (ddr_ram_size - ecc_res))
 					ddrss->ecc_regions[i].range = ddr_ram_size - ecc_res;
 				else
 					ddrss->ecc_regions[i].range = r->range;
-- 
2.34.1

