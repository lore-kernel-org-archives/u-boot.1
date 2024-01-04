Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25169C47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 18:53:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DABD1877CD;
	Thu,  4 Jan 2024 19:53:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=collins.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collins.com header.i=@collins.com header.b="i84EFEBd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBB58878AD; Thu,  4 Jan 2024 19:53:13 +0100 (CET)
Received: from mx0a-00105401.pphosted.com (mx0a-00105401.pphosted.com
 [67.231.144.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ECED87716
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 19:53:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=collins.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=brandon.maier@collins.com
Received: from pps.filterd (m0346907.ppops.net [127.0.0.1])
 by mx0a-00105401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 404Hbxgt029928; Thu, 4 Jan 2024 18:53:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=collins.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=POD051818; bh=ThsrrfOL5UGRg8vD0nqdlf8bCOQmu/Gjn/1BggxFCA4=;
 b=i84EFEBdNzqBe2w6a3xdJA0M7hxCExFIJKWsaBptQsOC+Tl5X9hNf4SvoRWTtz5kxVcy
 YVfISpnKZUdoM9U6+ynuQ/EQc6SlREa6rSgxAUx1AuLR/enXyEK2z3aK+SVoiOkRsFoQ
 Q81iNmGoeV+ozyHKMYtzqtAssfb156bgRXbij1rmvZREmMF6Qf0mk48tb5uUYTL6fqay
 8lGaw7SnA57G9LB1gZtTKjl5asa/bmi3lG9zsj5HfKK6CMOvSjcBSF2akLWAHfz3UgC6
 SLEY7omXjoXi6P03LOWHI8AuhL+aEbjfn1jyZjkjqsLdv+QAYeBNROEpUKDrlZUGHUQr wQ== 
Received: from xusxph005rp050.rtx.com (xusxph005rp050.rtx.com [128.13.121.147])
 by mx0a-00105401.pphosted.com (PPS) with ESMTPS id 3ve182scy4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 04 Jan 2024 18:53:07 +0000
Received: from xusxph005rp020.corp.ray.com ([128.13.121.224])
 by xusxph005rp050.rtx.com (8.17.1.19/8.17.1.19) with ESMTPS id 404Ir6hW017518
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 4 Jan 2024 18:53:06 GMT
Received: from dtulimr01.rockwellcollins.com
 (snat-utc-mailhub.rockwellcollins.com [10.172.224.19])
 by xusxph005rp020.corp.ray.com (8.17.1.19/8.17.1.19) with ESMTPS id
 404Ir6Uo013619
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 4 Jan 2024 18:53:06 GMT
X-Received: from bspbox.kirk (kirk.rockwellcollins.lab [10.148.204.208])
 by dtulimr01.rockwellcollins.com (Postfix) with ESMTP id B5DC1603A0;
 Thu,  4 Jan 2024 12:53:05 -0600 (CST)
From: Brandon Maier <brandon.maier@collins.com>
To: Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>
Cc: Brandon Maier <brandon.maier@collins.com>,
 This contributor prefers not to receive mails <noreply@example.com>,
 u-boot@lists.denx.de
Subject: [PATCH 1/4] tools: zynqmpimage: show info on partition 0
Date: Thu,  4 Jan 2024 18:50:06 +0000
Message-ID: <20240104185258.39465-1-brandon.maier@collins.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_11,2024-01-03_01,2023-05-22_02
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_11,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 spamscore=0
 mlxlogscore=705 mlxscore=0 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401040147
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0
 malwarescore=0 mlxlogscore=648 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401040147
X-Proofpoint-ORIG-GUID: 8VvjMuY3f99Cj8Mh_bnFqQ1N3WUY277s
X-Proofpoint-GUID: 8VvjMuY3f99Cj8Mh_bnFqQ1N3WUY277s
X-Proofpoint-Spam-Details: rule=outbound_default_notspam
 policy=outbound_default score=0
 priorityscore=1501 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 spamscore=0 mlxlogscore=808 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401040147
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

The zynqmpimage_print_header() skips printing the first partition. This
is because the image header can contain duplicate fields as the first
partition. However some fields, like the partition attributes, are only
present in the partition table. It is also possible for the first
partition to not be declared in the image header, if the image is not a
bootloader image.

Signed-off-by: Brandon Maier <brandon.maier@collins.com>
---

 tools/zynqmpimage.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/zynqmpimage.c b/tools/zynqmpimage.c
index bb54f41a153..05af1e81a24 100644
--- a/tools/zynqmpimage.c
+++ b/tools/zynqmpimage.c
@@ -262,9 +262,7 @@ void zynqmpimage_print_header(const void *ptr, struct image_tool_params *params)
 		for (i = 0; i < le32_to_cpu(iht->nr_parts); i++) {
 			next = le32_to_cpu(ph->next_partition_offset) * 4;
 
-			/* Partition 0 is the base image itself */
-			if (i)
-				print_partition(ptr, ph);
+			print_partition(ptr, ph);
 
 			ph = (void *)ptr + next;
 		}
-- 
2.43.0

