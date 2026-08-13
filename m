Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D0D5C5AC67
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 05:53:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3EA6660A6A;
	Thu, 13 Aug 2026 05:53:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 39l-35miHYIz; Thu, 13 Aug 2026 05:53:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AAE95608A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786600423;
	bh=nhBddSvmdduGXZ/Zld7b0J1jiyDVSH4gtVqIcpSlXlM=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=RNsAWSlS2aWgLX0Wl8Vhm0ny4I5x6+32AjPzh6DE1HUDg3qPrqk7y/rlTq3yEtmtr
	 zAPxLicDM2B8UOXHEH1wasbGESjJhRKgymGEeUK2TMLLcsEQ/9pRMgjT1pZIQHvXlk
	 RpY5Dw8/yZZ1/h9qhmFttpT9uSBiMNV3dU08oKWKkoB9kMdxjjk/Oy3YSk572iTO9g
	 LKt8sXhzBVKNkh5/lJovUS7nVBHqkHEwTgKN1weTeV/xsPPe0Fknf6ndlARzNU1uSC
	 Br9ESxavj1yIxxc7ZLxveNdfnvV9BO1Vdow8o8H8CM654zs6P4yqY5xZnn1rQHXZNB
	 nUeEaQZu4Jkyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AAE95608A1;
	Thu, 13 Aug 2026 05:53:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2EB0E1B8
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:53:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 20E5840346
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:53:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0e_5fs48V6ak for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 05:53:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 18D1440121
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 18D1440121
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 18D1440121
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:53:40 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67D5g7qZ1072467
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:53:40 GMT
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g14sygqyt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:53:40 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2caf4173b1cso33860865ad.3
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 22:53:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786600420; x=1787205220;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nhBddSvmdduGXZ/Zld7b0J1jiyDVSH4gtVqIcpSlXlM=;
 b=Iqrx++giFVsIoA1exwjIFfB2X/L2P7LmMdXLPCHUWXG20jEaP3a6ujFy59Dv5nYy8d
 NjtV9uzvVefplFk52zbDpk883wDNR36Z2qStCXAysD/zv4M/xF7IwUZLGU1sFROjO+B1
 +WSrRw0y1IIIbdRc9aEihdztZpkaBFnuN1LzWXhatxnGpUJtLfQL6UGGnub6yHJ7QHig
 2g+Dk9G1eJiOW4u9J7EQ8JUD+AoTrTuoWiT9uZfF+/gKOvudYX/N52cSPVk8bu8VDGrx
 lvTfz13M+fTSfHT0doA5LGrqn9ELFRFsVVyVjumteJX3GbgTs7ebfKBd2nf8ffrIc/HZ
 QAPg==
X-Gm-Message-State: AOJu0Yx5vR8XTjQvvy+ollABfhyT9IeFfIPbn19OzLdvUEhlO2msEWvm
 o83Eb3fs9SlwjsJnzkPRg4FaNSbaibo2F3h9oy8jExlGjATcf5gYcoRt6JZMzObulr7V9ExHyac
 k57DezwyyWaM+ydKgSeiZ7oszZKbMfHLzzkHP1uT6DnnXusUZs6MMU8+TFXk2iIe9+HlcVm4=
X-Gm-Gg: AR+sD11t+y2TC7o6nRZOtc7IigVdFz7zjvVm4NS2fNiLAIOt9ELNvoSlFfFsffVu6E0
 TPbcriFy79sbIFVpOANrRm9brdslHSnnCC20Sx+CqhNOQInVxg2gXpD7hnq4zeMew5F74/iImjR
 9a0WQhqusAI/r7KJrFZCOMgkMTWwBIoa9u7iDA+k4V0PTKy7/kcnvXC6btyru+uMu8VTbq7dTOd
 J7czaN2WacsKCYljMggWmKRXu8rAA4u+CsHHxxx5wK85M6bK4O/HEvmukMDPszlp6+378ZmC6b3
 HA/2JdohOQ42Y0gcILdFs7Z+OkOWIlKw29tLQHi87lYFET2auiYZ275QJ6GLp3uZ2HpDOES60Lx
 vZ0dOChxufLHcg8z05QVlS1qxvfi4uVYjQDqW14IQVHjuDSpklyZBP7rafJBIkyue2no9CzPQoM
 fIUBe00wBJgq8kOa4vYpKBaXZHS851
X-Received: by 2002:a17:902:f64a:b0:2cf:84bb:1ebc with SMTP id
 d9443c01a7336-2d37e856fd9mr43619555ad.15.1786600419629; 
 Wed, 12 Aug 2026 22:53:39 -0700 (PDT)
X-Received: by 2002:a17:902:f64a:b0:2cf:84bb:1ebc with SMTP id
 d9443c01a7336-2d37e856fd9mr43618975ad.15.1786600419204; 
 Wed, 12 Aug 2026 22:53:39 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31ebc760524sm3921430eec.1.2026.08.12.22.53.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 22:53:38 -0700 (PDT)
Date: Thu, 13 Aug 2026 11:23:29 +0530
Subject: [PATCH 1/2] efi_loader: firmware: decouple dfu_alt_num from
 image_index
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-efi-firmware-dfu-alt-num-v1-1-43f034253b21@oss.qualcomm.com>
References: <20260813-efi-firmware-dfu-alt-num-v1-0-43f034253b21@oss.qualcomm.com>
In-Reply-To: <20260813-efi-firmware-dfu-alt-num-v1-0-43f034253b21@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786600412; l=3945;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=kFbU1SkitSoK5qYpzRNkqdHqKbUT9tpraG3nvV2Q5oE=;
 b=tBdGkDVyNj6oex0fu5NbWFCJYWeC1Xt8kNNh4ea7xuXPO+Ks2hi0OLWIm+x9GIgzSm8kUg7WY
 r4/sey/X+RQB2fICYKzgW1IA05NOGE1jBzXnoiq0qWdhaxbiCr2cCkE
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=ZcQt8MVA c=1 sm=1 tr=0 ts=6a7d5be4 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=H1DQs1lc3By0CTYzgj0A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDAzOSBTYWx0ZWRfX/atiJVnCiOri
 St6+Q+Y6AT6y2qn7Qyg8D7Fbk1TZQNV8qsxwosYepm2FpYUCpRG3qlqx0Oovhxnhd2HToeKCX9P
 5t6t8WsgsLeNeoZQaTTh0ghJwCWCYkF7YuydkIfpLkcGPvKkTJOsfGiQOl/H1n61ymPgMUa3ffQ
 3eowc16+0GY3tCKV74VP22Hf8i0VQwvovK/FOAGecINP85LwsR7SYJ/ZZ9zg+lDA/GcqKbHKhvB
 naQ+t8ADEsjUHigEQMReERsp8tY1+vzQKOvJChFSfsDUM1+0E3lJbRfA3aRmDGVekf4VYM5ajG8
 xDFIqd47pvKlKUKmu6s7W4azjH8Rqs4KPI0sdGyqvtR37d62vXTBZK/k++uqbLcaslVXXTkBe4h
 MzFb3fhZkMwCvI+BLKPq5f3ccmcqpFTDDzNw4+fXobptfJ1dqQdZ6ik2/eSutgTNr8EbLBEdmPk
 BCp6bLho1qWAasrRWXw==
X-Proofpoint-ORIG-GUID: 0i1EpGZgUJSwxVF_pCJrHLVRmlH1SXRz
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDAzOSBTYWx0ZWRfXzk5pOryNVRQn
 GLNZKq0JhoVglxuk4ulL6wz4ubD3UVJlLhUcgawuPr8NLRQqzzu/pWSSQx8zJJSgSk4cnS3FzQq
 TMQWUlf82ncynS5PsHFQ2msf5r/78EQ=
X-Proofpoint-GUID: 0i1EpGZgUJSwxVF_pCJrHLVRmlH1SXRz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130039
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nhBddSvmdduGXZ/Zld7b0J1jiyDVSH4gtVqIcpSlXlM=; b=baDIuwH8RaplM7/A
 kyat9BARglVj1eeOCH+9BgPyf8jMluK5Spy97ZrR6fcFRkB8E7cess44C+L144Rg
 UpFmbJPFK/4xlco+JPGcY+c5mFt9tBM53nx3n95MIYR5PX/6BbEg/xtV0TqFKpuK
 VlShwyTGD61mLQ2A+CzCkX44AsoarS8hluxuVf+N5n2rfimBn7xk/OfvQzfRPK8c
 wUeyGEJ12SJ8BjXLM38u3hBFJpfadnG+R5gX9yQVEfhJeIifkM5K8WpiO2AuzDrw
 imWOjNMSi9puFagJyvRIVlzwvH73VaCZOJXLOLzEVKTHsLkYlgLoHKI7cUhFS/86
 mKsVgQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786600420; x=1787205220;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nhBddSvmdduGXZ/Zld7b0J1jiyDVSH4gtVqIcpSlXlM=;
 b=Ve/rQXb0QHJ98EvzGe6Gzxo9ORiecaKnsJzC0ufRevoLJ7h6DNJpmRx4rh354xNVGm
 6zEKdw/LdnYvIASVw+EJLK5rJE2edw57aoVsBHfrBbPr73Ut61ZtfgZvTB6++0+YwTso
 Zuv95ciN1cxgkUK4vxh2e51Lzy3r8lsmozvgA1jNTdSEevjHzR7XGVg7vk8o+SSrtoBt
 vTONCdiwQKgG/aFlGtgIioNW3UQH2BHAaYYIjho1gznNmNoVTUGbf4/OhMRV8EWeduK5
 c32YLllnbFktZ43qlUYI15ZUtVDgQcpjS80K1NNQ8/naRJDsjpneogJHCDBeN+Ff/cNx
 1OuQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=baDIuwH8; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Ve/rQXb0
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
From: Balaji Selvanathan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

RAW capsule updates assume dfu_alt_num is always image_index - 1, i.e.
that fw_images[] is a positionally-ordered mirror of the DFU alt
settings. That holds for every board that builds its fw_images[] table
by hand, but a platform whose image list is discovered at runtime
(varying per board, with gaps for missing components) can't guarantee
image_index and dfu_alt_num stay in lockstep.

Move the (image_index - 1) calculation into a __weak function that
platforms can override, following the pattern already used for
efi_firmware_get_image_type_id(). The default keeps the
existing behaviour, so no other board needs any change.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 include/efi_loader.h          | 17 +++++++++++++++++
 lib/efi_loader/efi_firmware.c | 21 +++++++++++++++++++--
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 3a4d502631c..6626674f738 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -1187,11 +1187,15 @@ efi_status_t efi_capsule_authenticate(const void *capsule,
  * @fw_name:		Name of the firmware image
  * @image_index:	Image Index, same as value passed to SetImage FMP
  *                      function
+ * @dfu_alt_num:	DFU alt setting number for this image. Only consulted
+ *                      by a platform's efi_firmware_get_dfu_alt_num()
+ *                      override
  */
 struct efi_fw_image {
 	efi_guid_t image_type_id;
 	u16 *fw_name;
 	u8 image_index;
+	u8 dfu_alt_num;
 };
 
 /**
@@ -1240,6 +1244,19 @@ efi_status_t efi_ecpt_register(void);
 efi_status_t efi_esrt_populate(void);
 efi_status_t efi_load_capsule_drivers(void);
 
+/**
+ * efi_firmware_get_dfu_alt_num() - get the DFU alt setting number for an image
+ * @image_index:	image index
+ *
+ * Return the DFU alt setting number to use when writing the image
+ * identified by @image_index. Weak default derives it positionally as
+ * (image_index - 1); a platform whose fw_images[] is not laid out 1:1 with
+ * DFU alt numbers should override this function.
+ *
+ * Return:		DFU alt setting number
+ */
+u8 efi_firmware_get_dfu_alt_num(u8 image_index);
+
 efi_status_t platform_get_eventlog(struct udevice *dev, u64 *addr, u32 *sz);
 
 efi_status_t efi_locate_handle_buffer_int(enum efi_locate_search_type search_type,
diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
index b41969c70fd..c7339412055 100644
--- a/lib/efi_loader/efi_firmware.c
+++ b/lib/efi_loader/efi_firmware.c
@@ -80,6 +80,22 @@ efi_guid_t *efi_firmware_get_image_type_id(u8 image_index)
 	return NULL;
 }
 
+/**
+ * efi_firmware_get_dfu_alt_num - get the DFU alt setting number for an image
+ * @image_index:	image index
+ *
+ * Return the DFU alt setting number to use when writing the image
+ * identified by @image_index. The generic default derives it positionally
+ * from @image_index; a platform whose fw_images[] is not laid out 1:1 with
+ * DFU alt numbers should override this function.
+ *
+ * Return:		DFU alt setting number
+ */
+u8 __weak efi_firmware_get_dfu_alt_num(u8 image_index)
+{
+	return image_index - 1;
+}
+
 /* Place holder; not supported */
 static
 efi_status_t EFIAPI efi_firmware_get_image_unsupported(
@@ -768,9 +784,10 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
 	/*
 	 * dfu_alt_num is assigned from 0 while image_index starts from 1.
 	 * dfu_alt_num is calculated by (image_index - 1) when multi bank update
-	 * is not used.
+	 * is not used. A platform may override efi_firmware_get_dfu_alt_num()
+	 * if its fw_images[] is not laid out 1:1 with DFU alt numbers.
 	 */
-	dfu_alt_num = image_index - 1;
+	dfu_alt_num = efi_firmware_get_dfu_alt_num(image_index);
 	if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
 		/*
 		 * Based on the value of update bank, derive the

-- 
2.34.1

