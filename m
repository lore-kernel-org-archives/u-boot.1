Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A9CC44539
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 07:43:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 776EE4073D;
	Wed, 22 Jul 2026 07:43:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NHGJB-FqAmtp; Wed, 22 Jul 2026 07:43:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4231F40778
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784706234;
	bh=TvcMEgbuVFEBM5Mr6rw1EtqvHC7auw59FFYK8ddipdI=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=dyY7a1wJu5hhklk2oKFT+a/lxefFqpf+3b+YxEmy9zSvdj+Ke8fvQUBzIooP5G7ka
	 joP4TlQswBXTuchca3faTLSmZ4zw0W7e2RPIcrK7opqIyeC+DG/9HiLZ6eKZIyrDj9
	 zZIc7FX6c46N3Gy98oASScbXYFyXNLDP6p3B9N4pyxoAfazOhmV9JlVQFlvDbFm6BO
	 9cazEDCAUb2M2++WbhG6ivLHbOtq/ZCmdu6Diog9O8CWPiDGJhHDSACXgq8fIU2WsK
	 EHHvOoIv5Vx/mqyMq27w8zkJfZfGbUpuLX/K91pAuouonN4EF5wPE8tx4UMBXhRlfT
	 DcuPgrkRUHAIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4231F40778;
	Wed, 22 Jul 2026 07:43:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C371CDF0
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:43:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A95DB4073D
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:43:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Oj_sF0TwkpJa for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 07:43:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4848940778
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4848940778
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4848940778
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:43:51 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M53ppE3787372
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:43:50 GMT
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj9aec99e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:43:49 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cee894b3d8so169676615ad.2
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 00:43:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784706229; x=1785311029;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TvcMEgbuVFEBM5Mr6rw1EtqvHC7auw59FFYK8ddipdI=;
 b=KdTsguFhoqRGcMk85KwbFIG6ErcPIEPiYZfkMahy0d8GjrH89UnVKgB4Gldv9iDVPZ
 oeL4uPoYuBk/8Wot8CcQMcAJdpgdMBcwfj3G9tKc0yb8D2vfhIdnYbVALVnYMc0RKqMY
 gAgxvYS+loL9T0+LiYBpwblhCh2TARjQE7GdU0qSfR/np1BdgzL1f+INPaDPNIY51J0C
 AsguiIZ4DP/ED3/kz8G9YY7Zfm/9UXaCBYF2siAiG9nMEuGMiAbF3o+N9Geq/XL2fNK/
 d1Q+XKkQP2SGYnQj3SyGGVVOQ3GoAQ2PHFoTI8NPCmiVkVLKiuy9x4+sf1MolF924BDD
 WlHg==
X-Forwarded-Encrypted: i=1;
 AHgh+RptZk2MN5PwWPI4XXy4OxBY7JIq9qr25S29wpoU1xZPuXi+lszf7VheLT5dsCVk4XRkJYOiGng=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwV4MUvanigRupZ9WLTtQRbvgsO28w2zoCtBTVX3iWNeBRK36bI
 fDpyvqgfAk0ZLxisFw2bvYJhieTX0CgAFKExMbIZ1kjYHMGP3t+3TtTNC0e/tv02TD4M7WiRZ/D
 tr1WKceSAp/DBE3MUDRVBmoqyhzmYzs0lL7qmfF5KGy2aod1an/c3XM+pbf0fEr73M0yYHYI=
X-Gm-Gg: AR+sD11EFnIWPXD5tAWNbsUAVUrnRCQMbaz0RX2V8xjSky7l1R5wh1Xc1Jyz0N0CaWq
 RZ4LVNIxC7+aJmfCm0SQcvM3TbYQTb+9QtCwjr2/tQsO/gRHTAG9/GLCSFvgVP96teLAEvteHl5
 RsHIfg7cALuBBahgRxFmEaJBBURMe1CUa31AIFKNi9tjDMgWME3PM6h6BBvs4K6lC+baoyeBYAL
 3p55hZombzw31J1OK7ZNBdWs+fF1W9WKAsX/ao3SlE98aWEcUkNv6O1ZECi2Gt3PBIjBVvuJ9/6
 QSDJs0/hqOlN4vsJtsOCBCH2Cb55cF93sJ6tIbQ4busf0j9OMIBsCP4iaC2NqBBORMpr+Ox0xaD
 mNHoiG9VGzZNq8H3lfNlSxEzKeO/33JL8pZRl+XJJYU2s8mTKvgSiWM7BBc9qdRAjRXZ7WfdwyH
 bVsGIV+IYZ7gybF+/OSXpfJPKhfkIpzA==
X-Received: by 2002:a17:903:19cc:b0:2cc:db71:4db5 with SMTP id
 d9443c01a7336-2cf349d3ee3mr233775235ad.37.1784706228649; 
 Wed, 22 Jul 2026 00:43:48 -0700 (PDT)
X-Received: by 2002:a17:903:19cc:b0:2cc:db71:4db5 with SMTP id
 d9443c01a7336-2cf349d3ee3mr233775005ad.37.1784706228179; 
 Wed, 22 Jul 2026 00:43:48 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147df09ac0sm5572577eec.16.2026.07.22.00.43.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 00:43:47 -0700 (PDT)
Date: Wed, 22 Jul 2026 13:11:26 +0530
Subject: [PATCH v8 15/15] doc: board/qualcomm: Update RDP documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-spl-v8-v8-15-cbfa79e85a9d@oss.qualcomm.com>
References: <20260722-spl-v8-v8-0-cbfa79e85a9d@oss.qualcomm.com>
In-Reply-To: <20260722-spl-v8-v8-0-cbfa79e85a9d@oss.qualcomm.com>
To: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tingting Meng <tingting.meng@altera.com>,
 Anshul Dalal <anshuld@ti.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Johan Jonker <jbx6244@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Erikas Bitovtas <xerikasxx@gmail.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Jens Reidel <adrian@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: qMwWZMD13VXlJjsd5M14daDyiFp1h3P3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA3MCBTYWx0ZWRfX1L1RZv1IkD9l
 khjlm+/oJOJ5mB7d/G7MOcYnaZjLd3inOSP05dr0N7DfbshaN0/x4pnOCaxlZLZwdBXEmRfn1lj
 Xoa8cTVmUBl3uJC9wbS1rwfo04zIPuQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA3MCBTYWx0ZWRfXwn/XNFtumXRs
 hdonwWm1V2y696aQO5s1KMA0xcmmVVmNEPB/2/Md0CrW8pj5ZUQQxz9AYm4t3xipjj7/dMHzmKq
 FkrJeYcNxCHksU9Qmk1HWbZFLLdjg3twjoiH0HZFWr/Zh+6h22myZewbPJ/ngOSbBwpFsRVObtB
 hm8nJ6mcdQLzJZ1jKp0FqDozyFAO7wCkUWYSAFoqlQ0lufuvwaUhAzh6FKNPIEzsR22XsTUGN5L
 ptiGHwXqBHp94IeQ9vj/rdN9fL9B/RmrvS5YJaPLACKHyehBXdWNV6ELP/vfOrZLxbFBWwhK6FB
 ipXYPe2Ych2OXDgY2zbb9/OPJfr6JYK9eTUu2y2PVezM3W5VuEYxTzfccQGWplOO55UkSJfIaCi
 TM8uPeUpu940RKdDblc/+XWAA7bNQAbx7FLDStJilqNkr85JOMgmIDusjoEXy4mnl6aq1xRUMec
 z2k8m8wN0zrH/RUNkhg==
X-Proofpoint-GUID: qMwWZMD13VXlJjsd5M14daDyiFp1h3P3
X-Authority-Analysis: v=2.4 cv=Cr6PtH4D c=1 sm=1 tr=0 ts=6a6074b5 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=qC_FGOx9AAAA:8 a=NEAV23lmAAAA:8 a=cm27Pg_UAAAA:8
 a=COk6AnOGAAAA:8 a=KTYltAS7syDh-o5V6pAA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=fsdK_YakeE02zTmptMdW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220070
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TvcMEgbuVFEBM5Mr6rw1EtqvHC7auw59FFYK8ddipdI=; b=cghubk60K6D5EDct
 i+X1A95EwKqxk4W+qJOAkWgizh9Z6icmOS5Yq/LqQ+k9aUroT4zB8Mx5R2TeNCUj
 dYCJQUdzJxJ+Ds1nLqRIDknHG58wOFsQsmiZx6wia78q7K3ZVkS0Q2tyA83A8BWz
 1VrfXBKjjefZEE+V2syIVaIiiBIiGwU10F8V+jTxzBATPWCJNmg7cyHMxi0G7D1O
 tIxjvy/OK1fpHY/sMHVgqVHSZG3d83sQbyhckxbpx4umPXzBIKhJHr11H5CCnzC3
 ybBh/BNRIcbneSrmWaLB/l4Oz0XAbTAqruZf+kk4hoKhsEqoNLi2HTBDYXOkeT0G
 8dqqhQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784706229; x=1785311029;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TvcMEgbuVFEBM5Mr6rw1EtqvHC7auw59FFYK8ddipdI=;
 b=GyJdOgKlJwLNPhLNwHjOS9W4BreSU0FZ87N0qALDGnenYy4maySQ2XalVygktztbAQ
 uZJxahvHUTig944bTJxxMZGJ/tzPTEO7qyZghKXZ1ROHsxovreD0SbL9YzGa5pe2PrPn
 G4OurO+BMCGBpm3WDkSKliS1CW56LdIRmPPZeWkOH6THSjTKhbsCQps4ovsujmxx6qjT
 hJzwh5nFIBMgmRZr46ZD/vzWQQgahYsr/95PH1tXDDlt78AaYMeBwirk70aaMeL6vbux
 rltZ8OGTpQ8dYs0IIZ4o+IIhzkThX4moInb/gQNQg6XqjpBqLuzote9PiQqmS0KGWjHo
 y+Mg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=cghubk60; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=GyJdOgKl
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Varadarajan Narayanan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

index.rst:
- Include 'spl-qclib.rst'

rdp.rst:
- Add details about the SPL & U-Boot proper build steps, converting to
  flashable images, source URLs for the needed binaries and scripts.
- Update author e-mail id.

spl-qclib.rst:
- Describe the SPL - Qualcomm Library (QCLib) interface used to exchange
  information between U-Boot SPL and QCLib for initializing the DDR.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 doc/board/qualcomm/index.rst     |  1 +
 doc/board/qualcomm/rdp.rst       | 79 +++++++++++++++++++++++++++++++++-------
 doc/board/qualcomm/spl-qclib.rst | 76 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 143 insertions(+), 13 deletions(-)

diff --git a/doc/board/qualcomm/index.rst b/doc/board/qualcomm/index.rst
index 56b8d894c2a..ddb75c49bcc 100644
--- a/doc/board/qualcomm/index.rst
+++ b/doc/board/qualcomm/index.rst
@@ -17,3 +17,4 @@ Qualcomm
    rdp
    signing
    spl
+   spl-qclib
diff --git a/doc/board/qualcomm/rdp.rst b/doc/board/qualcomm/rdp.rst
index 4e63fe624b8..8aab9b606d0 100644
--- a/doc/board/qualcomm/rdp.rst
+++ b/doc/board/qualcomm/rdp.rst
@@ -1,5 +1,5 @@
 .. SPDX-License-Identifier: GPL-2.0
-.. sectionauthor:: Varadarajan Narayanan <quic_varada@quicinc.com>
+.. sectionauthor:: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
 
 Qualcomm Reference Design Platform (RDP)
 ========================================
@@ -22,17 +22,6 @@ First, setup ``CROSS_COMPILE`` for aarch64. Then, build U-Boot for ``IPQ9574``::
 This will build the signed ``u-boot.mbn`` in the configured output directory. More information
 about image signing can be found in :doc:`signing`.
 
-The firmware expects the ELF images to be in MBN format. The `elftombn.py` tool
-can be used to convert the ELF images to MBN format.
-
-	IPQ9574: (MBN version 6)
-
-		$ python elftombn.py -f u-boot.elf -o u-boot.mbn -v6
-
-	IPQ5424: (MBN version 7)
-
-		$ python elftombn.py -f u-boot.elf -o u-boot.mbn -v7
-
 Then install the resulting ``u-boot.mbn`` to the ``0:APPSBL`` partition
 on your device with::
 
@@ -43,6 +32,63 @@ on your device with::
 
 U-Boot should be running after a reboot (``reset``).
 
+Build steps for IPQ5210 based Qualcomm Dragonwing F8 & N8 Platforms:
+--------------------------------------------------------------------
+
+Please refer to the following URLs for more details about the platforms.
+
+	F8: https://www.qualcomm.com/networking-infrastructure/products/f-series/f8-platform
+
+	N8: https://www.qualcomm.com/networking-infrastructure/products/n-series/n8-platform
+
+Since U-Boot SPL is enabled on these platforms, the build command generates both
+the U-Boot SPL and U-Boot proper images.
+
+Download `tmel-ipq52xx-patch.elf` and update CONFIG_QCOM_TMEL_ELF in the config
+file (i.e. configs/qcom_ipq5210_mmc_defconfig) as appropriate.
+
+Assuming ${uboot_dir} is the top of the U-Boot sources and ${out_dir} as the
+output directory,
+
+.. code-block:: bash
+
+    cd ${uboot_dir}
+    export CROSS_COMPILE=<aarch64 toolchain prefix>
+    make -j8 O=${out_dir} qcom_ipq5210_mmc_defconfig
+    make -j8 O=${out_dir}
+
+U-Boot SPL image:	${out_dir}/spl/u-boot-spl.melf
+U-Boot image:	${out_dir}/u-boot.mbn
+
+TFA:
+
+.. code-block:: bash
+
+    make PLAT=ipq52xx QTISECLIB_PATH=path/to/`libqtisec_dbg.a` SPD=opteed
+
+OPTEE:
+
+.. code-block:: bash
+
+    make PLATFORM=qcom-ipq52xx -j16
+
+These binaries can be combined into a flashable image using `gen_its.py`.
+
+.. code-block:: bash
+
+	python gen_its.py --arch ipq5210		\
+		--qclib_path `QCLib.elf`		\
+		--qcconfig_path `qc_config.elf`		\
+		--tfa_bl31_path bl31.mbn		\
+		--uboot_path u-boot.mbn			\
+		--optee_path tee-raw.mbn		\
+		-p qcconfig qclib			\
+		-P tfa_bl31 uboot optee			\
+		-o output/hm_503_test_uboot.img		\
+		--template `template.its`
+
+This should be flashed into 0:BOOTLDR partition.
+
 .. WARNING
 	Boards with newer software versions would automatically go the emergency
 	download (EDL) mode if U-Boot is not functioning as expected. If its a
@@ -55,5 +101,12 @@ U-Boot should be running after a reboot (``reset``).
 	Note that the support added is very basic. Restoring the original U-Boot
 	on boards with older version of the software requires a debugger.
 
-.. _elftombn.py: https://git.codelinaro.org/clo/qsdk/oss/system/tools/meta/-/tree/NHSS.QSDK.13.0.5.r2/scripts?ref_type=heads
 .. _edl: https://github.com/bkerler/edl
+.. _gen_its.py: https://git.codelinaro.org/clo/qsdk/oss/system/tools/meta/-/tree/win.platform_tools.1.0.r34/scripts?ref_type=heads
+.. _libqtisec_dbg.a: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/WIN.TFA.1.0.R4/apss_proc/out/proprietary/qtiseclib/output/ipq52xx/release/libqtisec_dbg.a
+.. _OPTEE: https://git.codelinaro.org/clo/trusted-firmware/optee_os/optee_os/-/tree/win.optee.1.0?ref_type=heads
+.. _qc_config.elf: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/BOOT.MXF.2.3.1.1/boot_images/boot/QcomPkg/SocPkg/Hermosa/Bin/LC/RELEASE/qc_config.elf
+.. _QCLib.elf: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/BOOT.MXF.2.3.1.1/boot_images/boot/QcomPkg/SocPkg/Hermosa/Bin/LC/RELEASE/QCLib.elf
+.. _template.its: https://git.codelinaro.org/clo/qsdk/oss/system/tools/meta/-/tree/win.platform_tools.1.0.r34/scripts?ref_type=heads
+.. _TFA: https://git.codelinaro.org/clo/trusted-firmware/tf-a/trusted-firmware-a/-/tree/win.tfa.1.0.r4?ref_type=heads
+.. _tmel-ipq52xx-patch.elf: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/TMEL.WNS.2.4/tmel-ipq52xx-patch.elf
diff --git a/doc/board/qualcomm/spl-qclib.rst b/doc/board/qualcomm/spl-qclib.rst
new file mode 100644
index 00000000000..b430f10dc68
--- /dev/null
+++ b/doc/board/qualcomm/spl-qclib.rst
@@ -0,0 +1,76 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. sectionauthor:: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
+
+QCLib Interface Table
+=====================
+
+Overview
+--------
+
+QCLib (Qualcomm Library) is a Qualcomm proprietary firmware binary that
+performs DDR initialization and other pre-DDR hardware bring-up on Snapdragon
+SoCs. U-Boot SPL communicates with QCLib through a shared in-memory structure
+called the **interface table** (``struct interface_table``). The table is
+populated by SPL before jumping to QCLib, and QCLib updates selected entries
+before returning.
+
+Interface Table Header
+----------------------
+
+The table header occupies the first 0x20 bytes of the structure:
+
+.. code-block:: none
+
+    Offset  Size  Field               Description
+    ------  ----  ------------------  ----------------------------------------
+    0x00     8    magic_key           ASCII magic: "QCLIB_CB" (no NUL)
+    0x08     4    version             Interface version; currently 0x00000001
+    0x0C     4    num_entries         Number of valid entries in the table
+    0x10     4    max_entries         Maximum entries the table can hold (16)
+    0x14     4    global_attributes   Bitmask of global control flags
+    0x18     4    reserved1           Reserved; must be zero
+    0x1C     4    reserved2           Reserved; must be zero
+    0x20     -    entries[]           Array of up to 16 table entries
+
+The magic key ``"QCLIB_CB"`` is validated by QCLib on entry. If the magic does
+not match, QCLib will not proceed.
+
+Table Entry Format
+------------------
+
+Each entry is 0x28 bytes:
+
+.. code-block:: none
+
+    Offset  Size  Field               Description
+    ------  ----  ------------------  ----------------------------------------
+    0x00    24    entry_name          NUL-padded ASCII name (see entries below)
+    0x18     8    address             Physical address of the blob in SRAM
+    0x20     4    size                Size of the blob in bytes
+    0x24     4    attributes          Bitmask of per-entry flags
+
+The ``global_attributes`` and per-entry ``attributes`` fields are bitmasks
+defined by the QCLib interface specification. SPL initializes both to zero
+unless a SoC-specific override sets them.
+
+Interface Table Entries
+-----------------------
+
+.. list-table::
+   :header-rows: 1
+   :widths: 22 12 66
+
+   * - Entry name
+     - Direction
+     - Description
+   * - ``qc_config``
+     - Input
+     - Entry point / load address of the pre-DDR configuration image
+       (``qcom-config-1`` in the FIT). Contains platform configuration
+       data consumed by QCLib.
+   * - ``qcsdi``
+     - Bidirectional
+     - QCSDI (Qualcomm Crash Dump Interface) entry. SPL initializes the
+       address to zero; QCLib writes the QCSDI physical address here before
+       returning. SPL reads it back and passes it to downstream firmware
+       (e.g. TF-A BL31 via ``arg0``) for crash-dump support.

-- 
2.34.1

