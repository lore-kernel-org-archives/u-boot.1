Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D279C44515
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 08:52:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B29B8488B;
	Mon, 20 Jul 2026 10:52:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bRG3+m+f";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PmZ0wY6v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 881018493F; Mon, 20 Jul 2026 10:52:18 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34BDC847AF
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 10:52:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K7rdZL2979848
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 08:52:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=P0wFRJwr1LS
 sWJuL3THb88wpaaUswrRULwPQG8M2XKM=; b=bRG3+m+f63fKWAVQFkaw2bIMvjf
 y/8hPCbfmaPcHbDAX1grnrxQBcjwSPDWFOX2YAUi+NYHq43Ok7w4C/AE2UM88E9K
 PTK5K9l407T2OK9xyHxh57pRtfxmrNqycCmGCa+W0hcnx+7qEfxXu5d/xSSJnBgJ
 ujibyQ+rY/rlFHI492KHXVbggg5tid0E34VyhMx4zRdbieBWjZyrKwgyQL2gCfzS
 fIKktEnk0z29VoxLJ85xNfZedvPkejUN6koZ+Lyqe8vfDFN4/I9o6hml7gC0jWrH
 9ee2XgKcReZJBb/4eZMcuCVqYT0VoUuLyuueO6f4LBNE2iwKAkTpE64wOuw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhfpg07fr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 08:52:14 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8e97889ac8aso161140476d6.3
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 01:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784537533; x=1785142333; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P0wFRJwr1LSsWJuL3THb88wpaaUswrRULwPQG8M2XKM=;
 b=PmZ0wY6vCxiCllBFrMR1xxjvgUWZiZI3O0VjclVgQL1OlRqcb8yUaN7CUL+ItDI3St
 JTDZF5b5P5zdItnaJIgFJ/076W9tbTNNLUID6RU+BsDZ+ssIqU3gnhqKRmkAkzbSlm1e
 V9v9juhuA95j5HQjjEqwEKRrxFQyrBaAsK3YJ16m3+THRta8AhhfEW48FJ+u8Yr6UueH
 m+QwaFdqUU1t5stnn/ALHs2uRIoilCNj1pprZMfb7hF/UbtWXTm+XjojL9zPJzfWMNEk
 y27gf+2pwrMv1enydazsN9bEBEIsUzZRe6d+Z02S1y54AN4J/dHMlOtzgPSi2k8bo+Cm
 u21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784537533; x=1785142333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=P0wFRJwr1LSsWJuL3THb88wpaaUswrRULwPQG8M2XKM=;
 b=cSTTQ1AwJpRRZW9IhfV5o40NEZPuwaFHYU55duaqtj8r2UOH+XCRaD/D3fGa3TNmCq
 KlztfiX1I8K1rJbvTyHhFy3JRm41MQMsy7CsYwEe3cWKOrTlYQ0AM0DpoffMPG1daNga
 bRbZjFEjzLgItyh2nH2tRAJVIRgUA5YgU+Rl+17LoI0wVGMHbaL21MTatawr9elLjZox
 Qw0xUq4/+dttSXn69Rf0fDhrAx8xq/CHa+fZvlEQcA0mHfc7aDPlPEwJGos3ZnsdZFmI
 /+SHuSjAnk25nDd4xfeUUdFdImEeQ4Z+BqKuLBjKQ/PMuorBfK7Q0pqrZFGdGEH6lzqy
 mbWw==
X-Gm-Message-State: AOJu0Yzbv+mMHqn3NelMrIcJ4DWbYIUOmH0SCt9pLWVMwSBY10mye3Yp
 SzsyuOigOn/VgP0QtZdAURKs0huUeq4H3ae+EhVHv3SuzaBPqK3RuoFHOokjywIJdfeqoWIYE7d
 J6VwwHwCQEpQ6w+FzOOsWOddjyxYKXx6A8umQhj9KucL0TuwFLQnyAvPkrAZzFCwT
X-Gm-Gg: AfdE7cmCXZmmWK9C0N4456px0WTFIGLYO6ByMsGoPZSZErFMloaJGjflMJqC8/A9B57
 GkC+UiLtLzk4UEy4z5UxksdRx+BOyFAObEiplPq75hTfF+sRSB1ni9R3b9RvDmmwTVBDJBiDr4M
 rnq/DshuucbRB+jZDhjRycuxQo0TJc4dZdIL7DEOFvOt6++zh3fPed7F28yMZqUlX77z3DunG9x
 wbqbIko6RjN0jjM3o2vlJqe0Y2RK6JYc72CO/13t8nBGvDzWiO3c0AVE4NTENwoNnxITdU5qI1r
 p+lhGhlouh+vI9uwu7xGf7NJlrnanCnrIqa6QLeP6pO3qgSbZZVv8CrrIrG0oCbK6vWEvav9tIS
 8ziJK6iKqF5S+nXBiSgh4pxeg+qEA/wMTZUZpnrwQSI7ToVFdLio=
X-Received: by 2002:a05:622a:250:b0:51c:8dee:964e with SMTP id
 d75a77b69052e-5213e28f1cbmr127951491cf.57.1784537533279; 
 Mon, 20 Jul 2026 01:52:13 -0700 (PDT)
X-Received: by 2002:a05:622a:250:b0:51c:8dee:964e with SMTP id
 d75a77b69052e-5213e28f1cbmr127951141cf.57.1784537532670; 
 Mon, 20 Jul 2026 01:52:12 -0700 (PDT)
Received: from trex (182.red-79-144-196.dynamicip.rima-tde.net.
 [79.144.196.182]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e499c2sm26450052f8f.4.2026.07.20.01.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 01:52:12 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, trini@konsulko.com,
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org,
 neil.armstrong@linaro.org, bhupesh.linux@gmail.com, n-francis@ti.com,
 marek.vasut+renesas@mailbox.org,
 igor.belwon@mentallysanemainliners.org, shawn.lin@rock-chips.com,
 yoshihiro.shimoda.uh@renesas.com, alchark@gmail.com,
 tuyen.dang.xa@renesas.com, macpaul.lin@mediatek.com,
 padmarao.begari@amd.com, jstephan@baylibre.com, bb@ti.com,
 j-mcarthur@ti.com, venkyada@qti.qualcomm.com,
 hayashi.kunihiko@socionext.com
Cc: u-boot@lists.denx.de, sumit.garg@kernel.org
Subject: [PATCH v1 3/7] ufs: rpmb: derive the per-region RPMB CID and size for
 OP-TEE
Date: Mon, 20 Jul 2026 10:51:43 +0200
Message-ID: <20260720085202.537019-4-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720085202.537019-1-jorge.ramirez@oss.qualcomm.com>
References: <20260720085202.537019-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5OCBTYWx0ZWRfXyhOqwGxKzPcJ
 vcY8zaUG4AI2QkWazL3jQIbXn3gLUMdw1kv0ArdXmIvreXBT0HHyrWKY6N+gdhj56TE39ie3IK+
 4k59Db/Cigk4rxGT2td54mYc1XQZSy0=
X-Proofpoint-GUID: FXmJSXRO-FQzmVTEaNtQzB4LqGwKJwir
X-Proofpoint-ORIG-GUID: FXmJSXRO-FQzmVTEaNtQzB4LqGwKJwir
X-Authority-Analysis: v=2.4 cv=c+6bhx9l c=1 sm=1 tr=0 ts=6a5de1be cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=2lELrtOEK2EaG96G7mOeag==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=G5GF0-_rzHmN2XFElfUA:9 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5OCBTYWx0ZWRfXzOyvjQv9XnXH
 5INJKRN6Hp9VIhgbvfpDKkdrUqm+RZnoy2fvqkgGhW5lSQUmSAbl5xdj9PF/v11iDToJB8tQcN9
 onZ1lLOe+8mzrVHx+s6CjAmISel7J0cicbs+a79a6TLVB4rpd3ZMT6K6NeFyYU79yy7rnP7wT39
 Klp0weIvq9r/I2z7td8gsK4UmsHgvx/+lc48vZozCpO+1Y0Y212uK4iRjlNHZNVQmFe5/YYOUaE
 6HLyFltFzDVM/LnIkUbkDXNElZWiQhJFRuROXy3Y6Nh/3P2+T9qhTlBR15IO45G072Ssr3hZKCn
 2g1U/Fwnz5sKfJu/rkb6U4hCSGoBMNVR0RzodGd1s4ICtZGJLK81ZazKtgb4zqH2/uD8inispp2
 llL6cGiJIGKJ8UL7f2A4McZFsekvUo0Yz8cRymfb4AmzPa43H96vXFtolS4wnTZQyhwWiCPBSuV
 NuqoIjLXoiqzxyP/TZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200098
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

Read the UFS device, unit and geometry descriptors to report each RPMB
region's size and reliable-write count, and build a 16-byte CID by
BLAKE2b-hashing the same device-id string the Linux kernel derives
(ufshcd_create_device_id() plus a "-R<region>" suffix), so OP-TEE derives
an RPMB key that matches Linux. Exposed via ufs_rpmb_get_region_info().

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 drivers/ufs/ufs-rpmb.c   | 135 ++++++++++++++++++++++++++++++++++++++-
 drivers/ufs/ufs-uclass.c |   4 +-
 drivers/ufs/ufs.h        |  11 ++++
 include/ufs.h            |   6 +-
 4 files changed, 151 insertions(+), 5 deletions(-)

diff --git a/drivers/ufs/ufs-rpmb.c b/drivers/ufs/ufs-rpmb.c
index 636ccb6e74f..7919162ddae 100644
--- a/drivers/ufs/ufs-rpmb.c
+++ b/drivers/ufs/ufs-rpmb.c
@@ -1,8 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0+
 #include <dm.h>
+#include <hexdump.h>
 #include <log.h>
 #include <scsi.h>
 #include <ufs.h>
+#include <vsprintf.h>
+#include <u-boot/blake2.h>
+#include <asm/unaligned.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include "ufs.h"
@@ -130,9 +134,8 @@ struct udevice *ufs_rpmb_get_scsi_dev(int dev_id)
 	return scsi_dev;
 }
 
-int ufs_rpmb_read_geometry(struct udevice *scsi_dev, u8 *rpmb_rw_size)
+static int ufs_rpmb_read_rw_size(struct ufs_hba *hba, u8 *rpmb_rw_size)
 {
-	struct ufs_hba *hba = dev_get_uclass_priv(scsi_dev->parent);
 	u8 desc[QUERY_DESC_GEOMETRY_DEF_SIZE];
 	int ret;
 
@@ -144,3 +147,131 @@ int ufs_rpmb_read_geometry(struct udevice *scsi_dev, u8 *rpmb_rw_size)
 	*rpmb_rw_size = desc[GEOMETRY_DESC_RPMB_RW_SIZE];
 	return 0;
 }
+
+static int ufs_rpmb_read_region_sizes(struct ufs_hba *hba, u16 spec_ver,
+				      u8 sizes[UFS_RPMB_NUM_REGIONS])
+{
+	u8 unit[QUERY_DESC_UNIT_DEF_SIZE] = { };
+	int ret;
+
+	ret = ufshcd_read_descriptor(hba, QUERY_DESC_IDN_UNIT,
+				     UFS_UPIU_RPMB_WLUN, unit, sizeof(unit));
+	if (ret)
+		return ret;
+
+	memset(sizes, 0, UFS_RPMB_NUM_REGIONS);
+
+	if (spec_ver > UFS_RPMB_LEGACY_SPEC_VER) {
+		sizes[0] = unit[RPMB_UNIT_DESC_REGION0_SIZE];
+		sizes[1] = unit[RPMB_UNIT_DESC_REGION1_SIZE];
+		sizes[2] = unit[RPMB_UNIT_DESC_REGION2_SIZE];
+		sizes[3] = unit[RPMB_UNIT_DESC_REGION3_SIZE];
+	} else {
+		u64 region = (get_unaligned_be64(unit +
+					RPMB_UNIT_DESC_LOGICAL_BLK_COUNT)
+			      << unit[RPMB_UNIT_DESC_LOGICAL_BLK_SIZE])
+			     >> UFS_RPMB_REGION_UNIT_SHIFT;
+
+		sizes[0] = region > 0xff ? 0xff : region;
+	}
+
+	return 0;
+}
+
+static void ufs_rpmb_string_to_ascii(const u8 *raw, char *out, size_t outsz)
+{
+	int nchars = ((int)raw[QUERY_DESC_LENGTH_OFFSET] - QUERY_DESC_HDR_SIZE);
+	int i, n = 0;
+
+	nchars = nchars > 0 ? nchars / 2 : 0;
+	for (i = 0; i < nchars && n < (int)outsz - 1; i++) {
+		u16 c = get_unaligned_be16(raw + QUERY_DESC_HDR_SIZE + i * 2);
+
+		out[n++] = (c >= 0x20 && c <= 0x7e) ? (char)c : ' ';
+	}
+	out[n] = '\0';
+}
+
+static int ufs_rpmb_build_cid(struct ufs_hba *hba, const u8 *dev_desc,
+			      unsigned int region, u8 *cid)
+{
+	u8 raw[QUERY_DESC_MAX_SIZE];
+	char model[MAX_MODEL_LEN * 8];
+	char serial_hex[QUERY_DESC_MAX_SIZE * 2 + 1];
+	char idstr[QUERY_DESC_MAX_SIZE * 3];
+	u8 serial[QUERY_DESC_MAX_SIZE] = { };
+	u16 manf_id, spec_ver, dev_ver, manf_date;
+	u8 blen;
+	int ret;
+
+	manf_id = get_unaligned_be16(dev_desc + DEVICE_DESC_PARAM_MANF_ID);
+	spec_ver = get_unaligned_be16(dev_desc + DEVICE_DESC_PARAM_SPEC_VER);
+	dev_ver = get_unaligned_be16(dev_desc + DEVICE_DESC_PARAM_DEV_VER);
+	manf_date = get_unaligned_be16(dev_desc + DEVICE_DESC_PARAM_MANF_DATE);
+
+	ret = ufshcd_read_descriptor(hba, QUERY_DESC_IDN_STRING,
+				     dev_desc[DEVICE_DESC_PARAM_PRDCT_NAME],
+				     raw, sizeof(raw));
+	if (ret)
+		return ret;
+	ufs_rpmb_string_to_ascii(raw, model, sizeof(model));
+
+	ret = ufshcd_read_descriptor(hba, QUERY_DESC_IDN_STRING,
+				     dev_desc[DEVICE_DESC_PARAM_SN],
+				     raw, sizeof(raw));
+	if (ret)
+		return ret;
+	blen = raw[QUERY_DESC_LENGTH_OFFSET];
+	if (blen < QUERY_DESC_HDR_SIZE)
+		return -EINVAL;
+	memcpy(serial, raw + QUERY_DESC_HDR_SIZE, blen - QUERY_DESC_HDR_SIZE);
+	bin2hex(serial_hex, serial, blen);
+	serial_hex[blen * 2] = '\0';
+
+	snprintf(idstr, sizeof(idstr), "%04X-%04X-%s-%s-%04X-%04X-R%u",
+		 manf_id, spec_ver, model, serial_hex, dev_ver, manf_date,
+		 region);
+
+	if (blake2b(cid, UFS_RPMB_CID_SIZE, idstr, strlen(idstr), NULL, 0))
+		return -EIO;
+
+	return 0;
+}
+
+int ufs_rpmb_get_region_info(struct udevice *scsi_dev, unsigned int region,
+			     u8 *size_mult, u8 *rel_wr, u8 *cid)
+{
+	struct ufs_hba *hba = dev_get_uclass_priv(scsi_dev->parent);
+	u8 dev_desc[QUERY_DESC_DEVICE_DEF_SIZE] = { };
+	u8 sizes[UFS_RPMB_NUM_REGIONS];
+	u16 spec_ver;
+	int ret;
+
+	if (region >= UFS_RPMB_NUM_REGIONS)
+		return 0;
+
+	ret = ufshcd_read_descriptor(hba, QUERY_DESC_IDN_DEVICE, 0,
+				     dev_desc, sizeof(dev_desc));
+	if (ret)
+		return ret;
+	spec_ver = get_unaligned_be16(dev_desc + DEVICE_DESC_PARAM_SPEC_VER);
+
+	ret = ufs_rpmb_read_region_sizes(hba, spec_ver, sizes);
+	if (ret)
+		return ret;
+	if (!sizes[region])
+		return 0;
+
+	ret = ufs_rpmb_read_rw_size(hba, rel_wr);
+	if (ret)
+		return ret;
+	if (!*rel_wr)
+		*rel_wr = 1;
+
+	ret = ufs_rpmb_build_cid(hba, dev_desc, region, cid);
+	if (ret)
+		return ret;
+
+	*size_mult = sizes[region];
+	return 1;
+}
diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index 962b6093762..f5e5bfd2e27 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -1800,8 +1800,8 @@ out:
 	return err;
 }
 
-static int ufs_get_device_desc(struct ufs_hba *hba,
-			       struct ufs_dev_desc *dev_desc)
+int ufs_get_device_desc(struct ufs_hba *hba,
+			struct ufs_dev_desc *dev_desc)
 {
 	int err;
 	size_t buff_len;
diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index e66d2c5f533..cf89bbc2008 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -20,6 +20,15 @@ struct udevice;
 #define UFS_RPMB_SEC_PROTOCOL_ID	0x01
 
 #define GEOMETRY_DESC_RPMB_RW_SIZE	0x17
+
+#define RPMB_UNIT_DESC_LOGICAL_BLK_SIZE		0x0A
+#define RPMB_UNIT_DESC_LOGICAL_BLK_COUNT	0x0B
+#define RPMB_UNIT_DESC_REGION0_SIZE		0x13
+#define RPMB_UNIT_DESC_REGION1_SIZE		0x14
+#define RPMB_UNIT_DESC_REGION2_SIZE		0x15
+#define RPMB_UNIT_DESC_REGION3_SIZE		0x16
+#define UFS_RPMB_LEGACY_SPEC_VER		0x0220
+#define UFS_RPMB_REGION_UNIT_SHIFT		17
 #define UPIU_TRANSACTION_UIC_CMD 0x1F
 #define UIC_CMD_SIZE (sizeof(u32) * 4)
 #define RESPONSE_UPIU_SENSE_DATA_LENGTH	18
@@ -822,4 +831,6 @@ int ufshcd_probe(struct udevice *dev, struct ufs_hba_ops *hba_ops);
 int ufshcd_read_descriptor(struct ufs_hba *hba, enum desc_idn desc_id,
 			   int desc_index, u8 *buf, u8 size);
 
+int ufs_get_device_desc(struct ufs_hba *hba, struct ufs_dev_desc *dev_desc);
+
 #endif
diff --git a/include/ufs.h b/include/ufs.h
index 90c6aebcec1..79573e02278 100644
--- a/include/ufs.h
+++ b/include/ufs.h
@@ -20,12 +20,16 @@ int ufs_probe(void);
  */
 int ufs_probe_dev(int index);
 
+#define UFS_RPMB_CID_SIZE	16
+#define UFS_RPMB_NUM_REGIONS	4
+
 struct udevice *ufs_rpmb_get_scsi_dev(int dev_id);
 
 int ufs_rpmb_route_frames(struct udevice *scsi_dev, unsigned int region,
 			  void *req, unsigned long reqlen, void *rsp,
 			  unsigned long rsplen);
 
-int ufs_rpmb_read_geometry(struct udevice *scsi_dev, u8 *rpmb_rw_size);
+int ufs_rpmb_get_region_info(struct udevice *scsi_dev, unsigned int region,
+			     u8 *size_mult, u8 *rel_wr, u8 *cid);
 
 #endif
-- 
2.54.0

