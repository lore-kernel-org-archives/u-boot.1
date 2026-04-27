Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E66FF8860
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 12:07:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED7C083C14;
	Mon, 27 Apr 2026 14:07:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rf/4uHK2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HpHVEXCQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D402B8407E; Mon, 27 Apr 2026 14:07:10 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59D9780433
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 14:07:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63R8T9MZ1762101
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 12:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CH2sh64zuUGVIgoqFSFo5N1hsS0D/q3FSIwR/Bjddfc=; b=Rf/4uHK2aOEFzw+w
 34V0YeW84uxpdmz4GfRqH631IVAhUY7B2uu+oGHfFCcYXJcja2ooBlgmUzFCWcb7
 y7swTzSNYVV3+wIjmzei8aZhilvO4KuzyUrtsQkGdB2QqrXSg6O0PePy96T9c3xo
 voClSOB1B/I5HP/g0ueBzCvbT+33FQW46etRchziW8fh3qPy78D1YZd7hf7YtOBw
 JAEZE/00UVT0wXN4GPNQGACPfO5JVVtcqYqsihggTt6MZxs8bPnTqoiDvlaYLhJ1
 695iw1QPSaMcsRTZHWL4LdZbN7Dl/R5W1h+s9mSjlMN5jCvnkT+4LuMG2LlnwRvP
 c+CTgA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drpw9dy5d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 12:07:06 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-354c0234c1fso11113443a91.2
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 05:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777291625; x=1777896425; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CH2sh64zuUGVIgoqFSFo5N1hsS0D/q3FSIwR/Bjddfc=;
 b=HpHVEXCQCBM9qBkN3Zzg4Gb2CMfNNr9l8IWKymhj/DYhbswboYyasakf5cELkAWHih
 kRSeb4hdzQUZ0kOxyZGkiW24gjGIg1ckKhZoxLh+Yl//o4SXBYl9YtUiA8mm2S4BlzXU
 xuCRvLeykROtQmEKoN7fba3arT9KMZG/HDzC9s9ac0pMusxnGAChMPBsuGLrK7kTnaUI
 y00Exz7hwkYWqapfAl3FG70nMXjLRybYUnY8R7uNaZ4oah4ml+3gRd6jnUqLJL9FGYrh
 fEo4thAl8S4wSU8YKZ7HupeXWzWhpHZPwdC4PrQbqLOH2DD+gObCLmkA5iUb3IFBJnpo
 /QiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777291625; x=1777896425;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CH2sh64zuUGVIgoqFSFo5N1hsS0D/q3FSIwR/Bjddfc=;
 b=S5fess9tqp6ivI/sx7J3HwOYzXJUkf6KyXeILZvEYHkmMKtaKVKNByL3N37J9vskJA
 c5OpvcDGsiXTkFfzgoAenil548cj/y6eIKLU35CGgPArFgyE6y37h9+2fSX5B7pXAMvh
 29ZPNjASAVInAL7rcUVQWWQWed3iqvLjzLnuY6wjeobuyuPiBP6qht9UT9d7+u8CQPwF
 1sQ2E5/zpsMwD5y9SHgqNemvT1p2T7N5/xNh8/Wn3qRqdpXtRV4unfCAy6tTjlyr0rn2
 wtluCkY/W0yIsHlgq0RhRIG6gYmxtlZUfM4uYF1+2L7WQvzL/mUvnI3lFpWpBiaX2ZyD
 95WQ==
X-Gm-Message-State: AOJu0YwpeXXfNeiS2i2m8wawoCYCzyWrcJW0x0i6Y0kBOx+OY4A7DQB4
 esb1DfUr3rK6J1oKjzQGYcR4E7I5zyZ8Y3niv45Y0xJ7R0tw1+4XglifAMRibz4zal0rZ7v0EL+
 dYjFZsnsyutYRDbbOe2QjPINgdIvHaNGQNK2ixTgRXvFflAv+UN0pxx3z
X-Gm-Gg: AeBDietI6tkeGiMAd4ddDOxa/jtDNOi9wjAfcdosMmxdcBaF92VSZwGvGgVsYYJz9sd
 Sq7VbLJMHPBxUACRV2eeuFBWYpKviCmuZTvzGN+zLsTmOkvXzlY4e2Qak0aSgFEZ4fOhIQOlnV2
 6WElYY1g4s8tXM7aEx32HQLvt+Uj56acoFL4sWwlHrNVKKPtW0cuN3d3PzSsUBHfIePHgCFF6fJ
 IsUubR2aXrwyn8VkeRcriZI4mRMc46e4KZim2AD+1Ih1XKbI/jFLADB13d7ysXlvlwGid8vYpKR
 9ZWEIAQDIK5gXau/4gDbu2n25KMdLsdDo66VnDE+2aV4SZOKnm8MnnQr/Jf27BHmIy/DPlmk1MO
 +5tUMTZkQzLD/sccAOQ1v+1koZvRhZjTI/6b9kGC/+okVwuTMQoFLz8PRZ07NtIsNkKR+AB45T0
 VqRPCuH/iuIGwWcsEGC+RNl3WfTkKhdrHVhwotIA35TpJWUFBTiGwxJ2UYBFOK
X-Received: by 2002:a17:90a:d40d:b0:35e:27ec:de0 with SMTP id
 98e67ed59e1d1-36140462a99mr43442607a91.13.1777291625414; 
 Mon, 27 Apr 2026 05:07:05 -0700 (PDT)
X-Received: by 2002:a17:90a:d40d:b0:35e:27ec:de0 with SMTP id
 98e67ed59e1d1-36140462a99mr43442539a91.13.1777291624765; 
 Mon, 27 Apr 2026 05:07:04 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36140feea38sm31832910a91.6.2026.04.27.05.07.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:07:04 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 17:36:45 +0530
Subject: [PATCH v2 4/4] doc: fastboot: Document block device selection syntax
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-fb_gpt-v2-4-9e7fe3c1649a@oss.qualcomm.com>
References: <20260427-fb_gpt-v2-0-9e7fe3c1649a@oss.qualcomm.com>
In-Reply-To: <20260427-fb_gpt-v2-0-9e7fe3c1649a@oss.qualcomm.com>
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777291604; l=2803;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=PAWPglHHQqQ/oLL6xWsVay4ApyLNDJ2kUhnwly9cJT8=;
 b=8+JcNq6/Rn9DSuylLxuL8PpHfBORiASTnWJA2lVkj1EOSP7ZPMPoI6XUlBT56SRNNf7mu/UL5
 lkyDjun0ywHAKzocYvfvRmCoZQE3O8lJyze8hMjppFXpB5AgTvLCg+I
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: ZvxfNtDkl6jpR_bQMvgbxJ-5JNIHX1C_
X-Authority-Analysis: v=2.4 cv=H67rBeYi c=1 sm=1 tr=0 ts=69ef516a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pwJvMj_HW4Ly6_9t7PsA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEyOSBTYWx0ZWRfX3OKAkrpVLGhv
 wwkCAaXYtJ5EUSvO4WeFqojla841FcUCQ7HtwrOIZbbh8yMhzNt/EvvoFFBbOEqaHGc3PrFXK3h
 Rv2iU7d+sTFHz6KF0snfdEigTPuy21d2IDX9yIhTjtQjsnwEB9zRzUNX79k4NbUKnEeQlIuPCN0
 vHTtsU3KiSjff3H5m1TB8rys/c8gPJC4CRJ38s+oZmipTZ9svd/ujkYNbTHffAV+kP5J+YhgmBy
 HfLiMewQBi2Lm+1HJJ1ycCBK96BJluDoG80RvxiPgT6gkL9/Bt17kD46EnteEJPK7xREpoaA0Qv
 CqLSQDSQex86GSR3KtnyZg0YMvhcj5tpKKB2E3cq7zElxsIxuyVTKgUQXUVgxu6WBP37Ns+Iccg
 8vEtMkcMKdqpxxUTW2jbmrixfvmgM6pm5GLBLusneazf7flrYWlCtcf5x5wZiErln0ZzS1zwpYF
 etZcCPI87rton4iflOQ==
X-Proofpoint-ORIG-GUID: ZvxfNtDkl6jpR_bQMvgbxJ-5JNIHX1C_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270129
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

Add documentation for the device selection syntax in fastboot
block device operations. Users can now specify target devices
using "N:partition" format where N is the device number.

Document usage examples for regular partition operations like
"fastboot flash 0:boot boot.img" and partition table operations
like "fastboot flash 1:gpt gpt.img". When no device number is
specified, the default from CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID
is used.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- No changes
---
 doc/android/fastboot.rst | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/doc/android/fastboot.rst b/doc/android/fastboot.rst
index 19e2ee9d407..ce3a030e701 100644
--- a/doc/android/fastboot.rst
+++ b/doc/android/fastboot.rst
@@ -147,6 +147,38 @@ The Fastboot implementation in U-Boot allows to write images into disk
 partitions. Target partitions are referred on the host computer by
 their names.
 
+Device Selection for Block Devices
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+When using ``FASTBOOT_FLASH_BLOCK``, you can specify which block device to
+target by prefixing the partition name with the device number and a colon.
+
+Syntax::
+
+    <device_number>:<partition_name>
+
+Examples::
+
+    fastboot flash 0:boot boot.img        # Flash to device 0, partition "boot"
+    fastboot flash 1:system system.img    # Flash to device 1, partition "system"
+    fastboot flash 0:gpt gpt.img          # Write GPT to device 0
+    fastboot flash 1:mbr mbr.img          # Write MBR to device 1
+
+If no device number is specified, the default device from
+``CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID`` is used::
+
+    fastboot flash boot boot.img          # Uses default device
+
+This syntax is supported for:
+
+* Regular partition flashing
+* GPT partition table updates (``gpt`` or ``N:gpt``)
+* MBR partition table updates (``mbr`` or ``N:mbr``)
+* Partition erasing operations
+
+Partition Name Formats
+^^^^^^^^^^^^^^^^^^^^^^
+
 For GPT/EFI the respective partition name is used.
 
 For MBR the partitions are referred by generic names according to the
@@ -186,6 +218,15 @@ configuration options:
    CONFIG_FASTBOOT_GPT_NAME
    CONFIG_FASTBOOT_MBR_NAME
 
+When using block devices (``FASTBOOT_FLASH_BLOCK``), you can specify the target
+device by prefixing with the device number::
+
+   fastboot flash 0:gpt gpt.img    # Write GPT to device 0
+   fastboot flash 1:mbr mbr.img    # Write MBR to device 1
+
+If no device number is specified, the default device from
+``CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID`` is used.
+
 In Action
 ---------
 

-- 
2.34.1

