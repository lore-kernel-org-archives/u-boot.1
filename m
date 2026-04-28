Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A51FF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 07:32:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3711E84605;
	Tue, 28 Apr 2026 09:32:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="g+/KLSlX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ijTAhoXy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 277ED84605; Tue, 28 Apr 2026 09:32:19 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 081AB83A91
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 09:32:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63S60opR241140
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 07:32:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eG9U7dnb2C3q9Aau42VGF0DONNuh3XA2qPsYGjSZU6k=; b=g+/KLSlX48xtVv/o
 5ACGZCjGRr761kMbUwqJP54LyIqlGxU0VQqfWDiwNaaidrxAp/ROcE8y5BVI6FsV
 z68KNX1qiMYQL6VUEwiVv6yrbQGLmE/y1mFd4dztos40pDbRIP0RZJgKDu5yv0IH
 BJXR34+Fg+/Zs2Yy6x9MnDn15cJMmZyLDmk5/rvylI7nnRTuFTxs5AR0Ip905Zkc
 xt1v7wMjSb5ySezwQutm6mvQB3+FaP1CFE/aAOrZeFTfGLkfCbSMOdk/gMiZCv94
 8xh1UbVLkmDhJy+LXg7ToVScA9IlcllN3bKo6EVVEXGt+u4TTfXl5ztMPbcZOqyx
 iNoHeA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt946ujt7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 07:32:15 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b258636d16so110793955ad.2
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 00:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777361534; x=1777966334; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eG9U7dnb2C3q9Aau42VGF0DONNuh3XA2qPsYGjSZU6k=;
 b=ijTAhoXyKm/nPae6mgN/ZFvGjtGji19LXEaJg05Nd4nPkPFBOnEIUR2gIAGmd8+rwb
 Icn1frpdnSo3n5zUM5nCgjLsL+W7SxepqmWFN0Mr7LfTEPHTE9+Di0LhrVfAc6Di/00E
 QrgCHK7ymuf+SlT9ZrTbB+Ih3mcFKyqob67/5JJUOM0Yn2WKCtYWamGYO1p3IEhP48mI
 Yn+e1oYkiB4m3jZ46Qeebkva040EvINyvT3TQs+isE8GRde/ZF16WI9rd/QAr6pzqP+C
 J7hoHWqRrxDX1TmWaeLnmscfkoB5aKjgt/Ow6A7KqI7fwmiQk2mhzNM0KI1ZSQVsj6tQ
 iRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777361534; x=1777966334;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eG9U7dnb2C3q9Aau42VGF0DONNuh3XA2qPsYGjSZU6k=;
 b=oHwxb31hkQGga8Dd4FLUB7f48sG5YupSSQ2tXkFqmwXZaxGRzBwdNQZU3qTKIsJgnq
 62+f/tR0tGVuq2P3McdhufE2gfY0Y1F5HKprBn2/BDIWgTaub8EG80IHzIC7U1Sr/lUh
 AvXyWhgprnC6X5iWYvMcWT+OPfQT4MNKdTueGErh55tF4Pm5I7YwqrCOcyxQB2F59Qtd
 DjP9YohNYMb8ws5KB4ZwIXAtCYJZCncp+Nb76VExlm9jjh7Hedb5oW3i03yA4X09Dlh8
 AzF1+oHACcIlw8LhTD0pkXrUXtjNxFkfKnhXLcmloZpY3mpz/Um5u+5zvod8avlzsOJ7
 9XeQ==
X-Gm-Message-State: AOJu0YyCUNftGhUDa+7X2mOg2UteoDxdQkKfZi5iPwLcSv176aZIUvjP
 SIXfGf5amzqY4rmzsTjFf/bQRwqxjjHUaXC+I5sv11n/UEi9YG7v3CCiVxkYpcsebhaitOAHXqu
 Bh5gdS1EbP2vuhRBk7eOoKwONsw9XBopWJAmr4q3xgDbLePpuUYFLGnm3
X-Gm-Gg: AeBDietINwkIacDzuw+1nRlaHf6UtMkmmRi/TWarthilAeQGcuQX+uNnIcI4zvDtJJV
 +CAAlEg+84WwV47f0Xa6MM2sn9+0dF34/o+8A/TOAKl8LleE5/jRiV38pVhk8R6aQpPlglv/NEI
 7u3a3hWTJeFaL0LlRiUU3L8dlC7b1aKFInz/FMdJZ1boeoN/7NoVeF9sMk3yZguzvs14hIXHlb3
 ue+wJMa+YVaHxvjdHP2rse6PGNjk0OIasX+Cq4K8dWfThx0Z6p31ykuD5pVjuLYe7UCviTHHsog
 iOgyDQu2QSj33lI46yl9tR1YvhLFTpykPhj9EXASlOOKvTXn6ZuG9jkNA64NIDUE3r3IUWO3b/Z
 ITWkxVE4jYpId3nCbEv0aeGafxwOyV755aIiZcsc0QUq4yzNmK97NxC95sFhICDU6E5+eJ6WDQw
 HG994OwLXv2ORGTZE/IxHAYiNk2q2Swafa744Q98mMaLqfd8BhVT6gMNp/j5pq
X-Received: by 2002:a17:903:189:b0:2b7:8a56:7cda with SMTP id
 d9443c01a7336-2b97c3cb634mr19993185ad.4.1777361534286; 
 Tue, 28 Apr 2026 00:32:14 -0700 (PDT)
X-Received: by 2002:a17:903:189:b0:2b7:8a56:7cda with SMTP id
 d9443c01a7336-2b97c3cb634mr19992635ad.4.1777361533772; 
 Tue, 28 Apr 2026 00:32:13 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b97aabaecfsm16054405ad.36.2026.04.28.00.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 00:32:13 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 13:01:44 +0530
Subject: [PATCH v4 2/8] scsi: Add partition lookup by type GUID for SCSI
 devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-type-v4-2-b7051dc45a88@oss.qualcomm.com>
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
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Simon Glass <simon.glass@canonical.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777361510; l=2489;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=5rIB0/JhdXC1aGeFtozbagVVwrXCrkVF0G7Jbtnb908=;
 b=RqOpI3HOD+9svf9G0ih1zW1zp7m/XaIdXkpgxpV/T22gl1qUxIE2bI+YUGJEm460VCVAJ/EdA
 Au1+8EOzCbgD/GuD17U+8OP2zZAZtF7S74BRWcXTY9lVz8/Pmgd5mI4
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=YcWNIQRf c=1 sm=1 tr=0 ts=69f0627f cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=DfNHnWVPAAAA:8 a=EUspDBNiAAAA:8 a=4Z9OGKtuVjyKH-hDXNMA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=rjTVMONInIDnV1a_A2c_:22
X-Proofpoint-GUID: Qh0_rY2ODsq2vJo4SOkF9-I-8UtT0B8r
X-Proofpoint-ORIG-GUID: Qh0_rY2ODsq2vJo4SOkF9-I-8UtT0B8r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA2OSBTYWx0ZWRfX0B5dLoeH3OCI
 /BFattGpV2lEjS2hgdptFRberXwjRCq/2LmorCg5Sxai4ZRLGpZ8g0FRa5V77UYlqbSco2iA7xY
 DBLkK+tOeCLJQbrfV90XXnNttN0wYN1uFXKLFDR/m10CvI6CvscMhnIUuumRF/3CvE7RNh/xP68
 8oVAl1FYhWQaKWPOYQ0Onuy+YpGMIuOV+addNC5ebP4Dh8Y6/WnIEuhq2sVrQF+2J0usNkbM43s
 OmCe7h+X0N7XWV4ChwfmauW3MxuGkD6PPefn7ZHLxfisAfB4vLqH+u3h80+gd4Xmd0nILvwphKW
 ZTLaSoRnhIuJINc314y8WN52Y/aAiJ5JI3Q3MLuW1zf6gpIkkr/SdnD8PLYWXKm8Gp7NSiwrZAd
 e7ThMREVArq5knlHtlo6mYmZqLqmUWpTsT6Wqd3GV9Wj1wxZcApdcPAywKVZ/RgRUkY2PmY6N6O
 QbzFLylNpFODlggQDLw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0
 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
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

Introduce scsi_get_blk_by_type_guid() function to enable SCSI
partition discovery using partition type GUID. This function scans
all available SCSI devices and searches for a partition matching the
specified type GUID.

Reviewed-by: Simon Glass <simon.glass@canonical.com>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v4:
- Kept only scsi_get_blk_by_type_guid related changes
- Removed scsi_get_blk_by_uuid changes

Changes in v3:
- No changes

Changes in v2:
- Compute blk_find_max_devnum(UCLASS_SCSI) only once in scsi_get_blk_by_type_guid()
---
 drivers/scsi/scsi-uclass.c | 23 +++++++++++++++++++++++
 include/scsi.h             | 11 +++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/scsi/scsi-uclass.c b/drivers/scsi/scsi-uclass.c
index 39b4c7476d4..cea6d771f7c 100644
--- a/drivers/scsi/scsi-uclass.c
+++ b/drivers/scsi/scsi-uclass.c
@@ -47,6 +47,29 @@ int scsi_get_blk_by_uuid(const char *uuid,
 	return -ENODEV;
 }
 
+int scsi_get_blk_by_type_guid(const char *type_guid,
+			      struct blk_desc **blk_desc_ptr,
+			      struct disk_partition *part_info_ptr)
+{
+	struct blk_desc *blk;
+	int i, ret, max;
+
+	max = blk_find_max_devnum(UCLASS_SCSI) + 1;
+	for (i = 0; i < max; i++) {
+		ret = blk_get_desc(UCLASS_SCSI, i, &blk);
+		if (ret)
+			continue;
+
+		ret = part_get_info_by_type_guid(blk, type_guid, part_info_ptr);
+		if (ret > 0) {
+			*blk_desc_ptr = blk;
+			return 0;
+		}
+	}
+
+	return -ENODEV;
+}
+
 int scsi_bus_reset(struct udevice *dev)
 {
 	struct scsi_ops *ops = scsi_get_ops(dev);
diff --git a/include/scsi.h b/include/scsi.h
index 2520a8b8fe6..83aaf0a70f6 100644
--- a/include/scsi.h
+++ b/include/scsi.h
@@ -366,6 +366,17 @@ int scsi_scan_dev(struct udevice *dev, bool verbose);
 int scsi_get_blk_by_uuid(const char *uuid, struct blk_desc **blk_desc_ptr,
 			 struct disk_partition *part_info_ptr);
 
+/**
+ * scsi_get_blk_by_type_guid() - Provides SCSI partition information by type GUID.
+ *
+ * @type_guid:		Type GUID of the partition for fetching its info
+ * @blk_desc_ptr:	Provides the blk descriptor
+ * @part_info_ptr:	Provides partition info
+ * Return: 0 if OK, -ve on error
+ */
+int scsi_get_blk_by_type_guid(const char *type_guid, struct blk_desc **blk_desc_ptr,
+			      struct disk_partition *part_info_ptr);
+
 #define SCSI_IDENTIFY					0xC0  /* not used */
 
 /* Hardware errors  */

-- 
2.34.1

