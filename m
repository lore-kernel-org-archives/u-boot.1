Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 283D9FF885D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 07:33:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EB8684671;
	Tue, 28 Apr 2026 09:33:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PmliukNW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EMsJ2A1J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 047E984671; Tue, 28 Apr 2026 09:33:16 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2887284698
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 09:33:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63S5lWWQ1625526
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 07:33:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aZT/3kcC0XBZBfsWeqjvxSDEPV91XcnzwQrJtysXgh0=; b=PmliukNWJZROa50/
 bj5tvphlVEKKIdDHPo+QpymWGCY6Z5k1LLGv7PFwiSBanhrnL40Pr1t7LXpY20+I
 HXfpIUtl4Y7/ja9JkuvKABJG+GN10EKMxWjFG6m4VZRAM7b8IjLchqOz2223McXA
 u3VJgyepVXq7IxVIlG6TmG7wNo81jbEYoqyIRbi5+ZcT9h/xL1rNrLnh845a+QeI
 Wkq4smo2wNs+KWgxe4Wps9355Cuz14M/3teA7XoUvRyqPo5BQP3Sg5lvXS3qfXNt
 duQ9qdFTGEgYkiscmB9xtRozDBJyXFP61fzrWNEE1zZ1TXpRH//lf7B/KdsNtpz4
 uo7Ffg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtgms9rtr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 07:33:00 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b465bf993cso113609245ad.1
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 00:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777361579; x=1777966379; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aZT/3kcC0XBZBfsWeqjvxSDEPV91XcnzwQrJtysXgh0=;
 b=EMsJ2A1J3sanf5QWVhbR8YxVqCcfiesdUTHL286fw5JROlqQxFRwHXq88TgnFcSRIa
 2uXELgEGebR5iAEmZNWOTjbquPD4ERUquf0SdPY2phRcHjgJNPiGBgBetP/t3VmFcl5p
 B6vT2pSdAtyReq/8IMNzeyMpEze3O9JJjMoFfm2QleILfUhWGqNGwNYelRjlmvQfAKtg
 CbNtM5Bi6b4HepbXiZyg95DYJ6qqaDpn5MECVUUM1txWa51VHUQbVYfYBZVxMY5xet5i
 MlbHPdEVKFXJYTR/ifWuxLTwKgBeEUkmopj2f6CplIUb5lGbjyFdClwhTx123ilFcK/1
 bbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777361579; x=1777966379;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aZT/3kcC0XBZBfsWeqjvxSDEPV91XcnzwQrJtysXgh0=;
 b=Lx73L4NvfAC2wRZRvQdQOJezeOep8VA6G1QSG464kfUko2TLsRZdoWn9s/qoK1dlWa
 9+FoRJrdvURZ6hFi/LsbxdtXU60mVPsaqGRVwwqtkh4qpGFlN/hrpD+mI7hqywNGMptf
 j/Bcfy0b0syuga3TWnj4A+eW0P5g62j0SgXN7tCpk/q3j7pMhxD76Yw8mvg+mw+lKaAk
 734uHOqXXImC5t6pciPM3n79POC3UEFcdaCp0dX2mMMBy4ghIWb9komIAhf3UDuAhkD/
 B4A6r+N3A+wkXJmtyL4YKU/h9fnErQjf475HttzxpkENCY98PTabDP/ERNmbADtCI0hu
 vOzg==
X-Gm-Message-State: AOJu0YwKDM5bLRf8vV4unRkee1nJrQCS7oiRaEhBiK6N5LTmmRbEDFtS
 u6zjwFCbQM1TsyZaGdClSA513dKmRo99o39kIZiDC+iGJkrJ4d+mbtSmezFnpeam6Wr2Owopyd7
 5n/PGmhq8SAx3gfsp4Rw2nK2Yi86VRdf/Oi0WIkDF2pk4nrANDA0zySBM
X-Gm-Gg: AeBDietH44xSk4RzeRKzg31Cj95lceZukTI+2LQEoHWuarHDMx73rwzZFA6jjVVVrXT
 lNLcYjm6jFtk434I1joEYiIlQOUKkQwIzyUAmYCFqJbbih4PR1fwK2nyELJSvDLMbGh6W4P0KI2
 tbPF9t2kVUOw7/gJq1ZCOYf3ACYwcrwYyjwFw/oV1NPAETI81XCmvaa2XhLlNHJJpXHMR5SDZgi
 RSrr3g3ygLv9yEHhK7UrTJt5BsQQXAxt6Z70uIu1U2uWHdQuAHbKMGGQuK+D7Xt5IWe0YXeIGVF
 Xxs9qbqZx4wDpUN5Mq48Yt6j9UQTskooe2gXlaT0jWovny9LYS1hqf7GrdGgz+iCfQpspF5RjDs
 dVnu+uXRdQPDAF1bTv5D+tT4Y6G+FqAuqvEqpISfelj//Z205U3Hmu9Fop11qR5EXrUFN+NlGsb
 /oeBMobRpSQVUdrYVbv7fGph653cqERb5Z9yylyC4JZnDm2pf4mWAzrVAOAaGr
X-Received: by 2002:a17:903:298f:b0:2b2:680c:2193 with SMTP id
 d9443c01a7336-2b97c456f5bmr20785185ad.31.1777361579491; 
 Tue, 28 Apr 2026 00:32:59 -0700 (PDT)
X-Received: by 2002:a17:903:298f:b0:2b2:680c:2193 with SMTP id
 d9443c01a7336-2b97c456f5bmr20784645ad.31.1777361578977; 
 Tue, 28 Apr 2026 00:32:58 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b97aabaecfsm16054405ad.36.2026.04.28.00.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 00:32:58 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 13:01:50 +0530
Subject: [PATCH v4 8/8] test: dm: Add partition type GUID lookup test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-type-v4-8-b7051dc45a88@oss.qualcomm.com>
References: <20260428-type-v4-0-b7051dc45a88@oss.qualcomm.com>
In-Reply-To: <20260428-type-v4-0-b7051dc45a88@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Javier Tia <floss@jetm.me>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, David Lechner <dlechner@baylibre.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michael Walle <mwalle@kernel.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777361510; l=2783;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=dBaG+OJDeLWGNa9VgU86TC+TvQKnP5VOmLc+3QK5eK0=;
 b=vXKFQRfMrYEwDkLC3Hika62IIJfnA/LBPiyg9tM1BMvDjQafG0J1CGDID3h8bjBeWFo7Nk4Pi
 znm4GsE8X72DOuOWKPMgf8mpn+l1unrEBE3MZZAxHj3neuJjIGrmWoL
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: Leu868vrjpK7N5LhqvykADUT-4r9eU8M
X-Authority-Analysis: v=2.4 cv=R4gz39RX c=1 sm=1 tr=0 ts=69f062ac cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8 a=QOCIwyBpk6KF-oVkDwMA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA2OSBTYWx0ZWRfX7u3QpOSIB4gY
 CQ5ZR3Ewhs0N1CD+oP0Yo13Lw6dwRZgP2Cz351kJA5qu3q/Rt/WxfCzwXP0K7pDFEhzCJ9Qnp4b
 kaPS+JmlS6xQLXXR5DmqDCedV4EoRTmyW/16TZD3LHfndo1eaWk8iPPa7pcJ3WBqqEfcTVpjH+F
 XIZpGFXbVfeI8WV0yuK/Nv3dKGvnC81FFr4u/uv1/BV0HKKhwsBL4U77esu1eYQERkHnNHQh76r
 yQw8MmWv272wbXDgLybPt1gJz/aLA6qGqwMs9bIjButKeTlDZG0PGOG3bamm0fCY4OWAIDa2pDM
 UX3Q9w/m0Y35fHCCMXB9dZPMpu67IndBW1REC//PODbdw4lX1Bt72tfYMOVFszGkYwXRvUPDUDG
 2dLz/r70JQu4ai8d0+ZIZ0c5H1vfFeRzacubkl2aQPVuU/2QpnDJhvvk1a/GsE6yL6D/srkMicF
 r1UQFw2hhR3Z58Dkenw==
X-Proofpoint-ORIG-GUID: Leu868vrjpK7N5LhqvykADUT-4r9eU8M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280069
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

Add a unit test for the partition type GUID lookup functionality. The
test verifies that partitions can be correctly identified by their type
GUID, specifically testing the ChromeOS kernel partition lookup.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v4:
- Return -EAGAIN instead of EOPNOTSUPP
- Add extra asserts for kernel partition

Changes in v3:
- Add unit test for the partition type GUID lookup functionality
---
 test/dm/part.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/test/dm/part.c b/test/dm/part.c
index caae23bd4aa..7a427d3d41d 100644
--- a/test/dm/part.c
+++ b/test/dm/part.c
@@ -8,9 +8,13 @@
 #include <mmc.h>
 #include <part.h>
 #include <part_efi.h>
+#include <asm/global_data.h>
+#include <dm/lists.h>
 #include <dm/test.h>
 #include <test/ut.h>
 
+DECLARE_GLOBAL_DATA_PTR;
+
 static int do_test(struct unit_test_state *uts, int expected,
 		   const char *part_str, bool whole)
 {
@@ -195,3 +199,48 @@ static int dm_test_part_get_info_by_type(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_part_get_info_by_type, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
+static int dm_test_part_get_info_by_type_guid(struct unit_test_state *uts)
+{
+	struct udevice *dev, *blk_dev;
+	struct blk_desc *desc;
+	struct disk_partition info;
+	ofnode root, node;
+	int partnum;
+
+	if (!IS_ENABLED(CONFIG_PARTITION_TYPE_GUID))
+		return -EAGAIN;
+
+	/* Bind the mmc5 node (ChromeOS image with type GUIDs) */
+	root = oftree_root(oftree_default());
+	node = ofnode_find_subnode(root, "mmc5");
+	ut_assert(ofnode_valid(node));
+	ut_assertok(lists_bind_fdt(gd->dm_root, node, &dev, NULL, false));
+
+	/* Get the MMC device (probes it), then walk MMC -> BLK parent link */
+	ut_assertok(uclass_get_device_by_seq(UCLASS_MMC, 5, &dev));
+	ut_assertok(blk_get_from_parent(dev, &blk_dev));
+	desc = dev_get_uclass_plat(blk_dev);
+	ut_assert(desc);
+
+	/*
+	 * Test: look up the first ChromeOS kernel partition by type GUID.
+	 * In the ChromeOS image KERN_A is the first partition carrying the
+	 * ChromeOS kernel type GUID (fe3a2a5d-...). This is partition 2.
+	 */
+	partnum = part_get_info_by_type_guid(desc,
+					     "FE3A2A5D-4F32-41A7-B725-ACCC3285A309",
+					     &info);
+	ut_asserteq(2, partnum);
+	ut_asserteq_str("KERN_A", info.name);
+
+	/* Test: non-existent GUID must return -ENOENT */
+	ut_asserteq(-ENOENT,
+		    part_get_info_by_type_guid(desc,
+					       "00000000-0000-0000-0000-000000000000",
+					       &info));
+
+	return 0;
+}
+
+DM_TEST(dm_test_part_get_info_by_type_guid, UTF_SCAN_PDATA | UTF_SCAN_FDT);

-- 
2.34.1

