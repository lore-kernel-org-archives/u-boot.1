Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E90DEA7194
	for <u-boot@archiver.kernel.org>; Sun, 19 Apr 2026 10:25:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1FBF842C2;
	Sun, 19 Apr 2026 12:25:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cGbB4UIk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T0dGJqn3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B25084214; Sun, 19 Apr 2026 12:25:03 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 986DB839D9
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 12:25:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63J7C3ET3707906
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 10:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CzHIsSWKZI6xsXxV3c9vhs4HHH2OjnOMr5i8pSR0oyY=; b=cGbB4UIkiZJrNi9M
 gfF8iYWSB4Aebp97HQjcWD9n/MT0iXR+Ri0OhVdk/JPUepMdUCnQJZoWmMzFP2jU
 XMz6Wi+Ae25NU6GKFrbhP6HzYo5gZRMJCl2UwGFSJA1+xvvxX0E4KE29Xu88Y7Ap
 eVPZWTxTE3J47OA00mWqRUH0t3QrBJpmEgzOrEv6JE4LvUx63qT5vlmO+Jj0dofk
 s+m6kujK/TjfWWStYQiKEKOHS5FPPBNKKU90wVI2eZ19MmkqbrdLXzJGbdJfePql
 wfMotUD+0m0oLaKa56KpN56vyDoqFTb19f9t21dXNW70m25SesFMLpLngOlDsOM8
 jlsrgA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm2b72b21-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 10:24:59 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b24af7ca99so25335195ad.1
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 03:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776594298; x=1777199098; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CzHIsSWKZI6xsXxV3c9vhs4HHH2OjnOMr5i8pSR0oyY=;
 b=T0dGJqn3d0YT6VfJqs0f0CSoF9Vq2uaPjqVyGnD/lvA+RNSqokZgLdqSLBOUkF64P1
 4xFuZdRUiVqo4ysoEA42v72bBsqQCjMCuU06n3O4q50SNuweV4UfQ1vCjwKijWaMGsF9
 pfS0TK9F+7+spa5ZzLBJ1ZqCNeA5qiP3T8ne/g7TO9f2zz//qMEQ1CO9uTLhKZL6337W
 qAY6HkCVXRfVLIkfT9Ryr/9MBv7GKh2OGw+znalgkkggIxNX4U469WNBNei3KfjKQuWM
 LsYfXJCVgI80JxZSAxTKOBoIhSJA9/YUN7ybP29b84eBOyaRNnKjeyCdNOzF+i/k4WgS
 j6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776594298; x=1777199098;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CzHIsSWKZI6xsXxV3c9vhs4HHH2OjnOMr5i8pSR0oyY=;
 b=AKKVgmKVtu9wYdK1H8w6KxX28CwxbJEBfhCprGKEcGjhREuhEW1dyS4gO/+RMrvP7G
 /GlfZN49KNjj4i3zRrGJt5EVKWZCevVRlvc1kl4WwcYvLDAifOCJegnWyG5eVXI+qD+V
 ocl3mUQB6PO9w5AROb9qSIVUEUL9E+RSauLJWxOI70LzJeZKEPcNzGr8h2szp6CFXR27
 zL4PQheQ4uW7UhSqXUtDb2/39/wzYdWd+7hhco1tGEPJPZ/tdlpxzl0DoY3oWfDD0Fvf
 zo8AKtGyUTIz36nLQYhvaVxMw0NA/nvM7dSyj27oDlfheeIlFeO98TlOYyoaPD5re4OR
 ttmw==
X-Gm-Message-State: AOJu0YzvpHcdTeb79ZA77plGqw3+ykhIxf3hyl9TzvUkxjuuhqU2wi2F
 GB9DS4bmp2WJyoGXsNeA1RK5GJ+ty68JR92idUq+tJBhZkigmuQ97ebz80VfrsSRIwZKXz0M+6B
 j2GaXIOmmDgb526XSfsViLh3tFd+MLGh2G3bNpjFphPmpeKOWVujaTgHi
X-Gm-Gg: AeBDievxXA7WsLKNqOnYNznVjPBL3hUzJyDviZ/CbsTUZy+t9w6A2x+LezaidzT1hUR
 1GNwc8JnoErh1n4n0TfSBOHK9cl4IzunSsH9PMNiYlWfiKET7ybeZUaOjf46hj4JZgVNTZkbjXz
 pXQBEC0LjSPmvPP7cAh4W/UEAMPo/CPzdWSXF5I0p96D9CCgQFOVnwCLVLWyD4J6svJ82BXYR2O
 ylAUkIiE2Pz2uMJ432sqXU/J769K46zsxhdshldYWxXsaZ+E8psaBJk2pzxaNEL8depyC9lbTlH
 ornsVf9SwD1fBA9zWXIjB588eeu0xMnOWvMPqdJ3DnckA2LUDZOFuSHSulzS3CX7klkEVSBZWKS
 7QThz3bHmTENU88CsoMvSqjxPmO6S88tJFZCcVcRdxCfqIY4ATCk+Vp30Wf9rL+Sqdn5JIOt4lJ
 GD2YRdaDZpHS5pn+zPaWEw1OxuxpKCFM1mk5iWLrUPg2gXm7rhN4HvyboHnoai
X-Received: by 2002:a17:902:ce0a:b0:2b0:af2f:b27a with SMTP id
 d9443c01a7336-2b5f9ec3590mr93725255ad.11.1776594298102; 
 Sun, 19 Apr 2026 03:24:58 -0700 (PDT)
X-Received: by 2002:a17:902:ce0a:b0:2b0:af2f:b27a with SMTP id
 d9443c01a7336-2b5f9ec3590mr93725005ad.11.1776594297636; 
 Sun, 19 Apr 2026 03:24:57 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0caf1sm72754675ad.42.2026.04.19.03.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 03:24:57 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sun, 19 Apr 2026 15:54:07 +0530
Subject: [PATCH v3 5/5] test: dm: Add partition type GUID lookup test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260419-type-v3-5-ec49acd6870e@oss.qualcomm.com>
References: <20260419-type-v3-0-ec49acd6870e@oss.qualcomm.com>
In-Reply-To: <20260419-type-v3-0-ec49acd6870e@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, David Lechner <dlechner@baylibre.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Simon Glass <simon.glass@canonical.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michael Walle <mwalle@kernel.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776594245; l=2578;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=KIVYT7v6LY5orPwCWXRMzeFFsZRA6c2T6xPfOIOFGuU=;
 b=Yk3qteIzf7eiCCfjtjpXAs9yvYXnWHPT//rIs8W4eQLhGMStX5LdXPF22Dw3oQ5XWfeeA3R6b
 Rj/4S5HTgPaCPWYF8G2VthMidLgHg5Q/7juN/ZyNkS9fn1USi/O0uV3
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=KZridwYD c=1 sm=1 tr=0 ts=69e4ad7b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=QOCIwyBpk6KF-oVkDwMA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE5MDEwOCBTYWx0ZWRfX4LVHFeLOCz6m
 vkAk+UiLiGxC2iyRxsLsJLDpjyKFVDEgzkq+T9Xq/TYZYWmQY/5lpr0AsfSnV63gKIodPckWO8e
 Q2g2DwpkO/eYN7F8C3wgbDElrEMEahz8G+1aNHD0JXz48xMcWLz2rpahymi+RsCB6Q18eBhbOTs
 YwoVykCq/3m8p2XW3cVlZVLtbzlRk0p7GJEwOpvyCHVPSb+WPd3YZ4i8UBg9nPDcHbjjmZ3xvd0
 kdS8z5NsJAn2BK0auMfrai1rhR4ErQZpzTNrRj0pjcjLjFTwrpVpKtYZk1Y6GfI8GL+7k5EeRy6
 rGqSQztOXj5AvGqGcH3sIBinGrW2SvL95h5mGFQjGwYm/3rj2mMudZDg2fvILS76ywZ3eUTfsvn
 lQ669pydFX2/GrIVY6OlyYJnOEFl68QO9G0jbbJ93xEVrlhjI3vIpCK5zNpYab55sXQP6qi77ub
 TOaarloN9okbt8DrAZg==
X-Proofpoint-GUID: sEyIGlfY4WIVrAdruBPuZqAtOnhc5A5X
X-Proofpoint-ORIG-GUID: sEyIGlfY4WIVrAdruBPuZqAtOnhc5A5X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_03,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604190108
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

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- Add unit test for the partition type GUID lookup functionality
---
 test/dm/part.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/test/dm/part.c b/test/dm/part.c
index caae23bd4aa..41fb6efe5e4 100644
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
@@ -195,3 +199,47 @@ static int dm_test_part_get_info_by_type(struct unit_test_state *uts)
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
+		return -EOPNOTSUPP;
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
+	 * ChromeOS kernel type GUID (fe3a2a5d-...).
+	 */
+	partnum = part_get_info_by_type_guid(desc,
+					     "FE3A2A5D-4F32-41A7-B725-ACCC3285A309",
+					     &info);
+	ut_assert(partnum > 0);
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

