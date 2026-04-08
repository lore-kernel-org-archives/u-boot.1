Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCAC01073CAE
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 12:56:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1635E841D5;
	Wed,  8 Apr 2026 14:55:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JOcQ45rH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="izcKcBDL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A40E838BB; Wed,  8 Apr 2026 11:13:01 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69AA880433
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 11:12:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6387TJoE1259273
 for <u-boot@lists.denx.de>; Wed, 8 Apr 2026 09:12:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=BPdcVsucJ2d
 D3GumboDckpTME9pxKJaJXJYAu6Ouye0=; b=JOcQ45rH80qnzTnys3A49YY5lND
 eR/YT834JwNldqnr2BGgtxjLCl9AZsuxfmnik9v9vsEVYhYzngAvGn9izI/NuqVi
 kMdyV7esQ4iq3QaJz6vpzV9gkOgtuMs5PZcCPic79WORNWz186NPlUzIh0uidtqd
 3qmHY03yth/L1FHvmMYZ7vYrMg2aVQOtN3hJtTzJAT9WC0ev/fPtjnUQdrjQgggy
 4W59B2WbBOH7kC1o0YcYpiwccxPtH7n2RI6R/7rdmcCbKTYb3z+Y6fZ1Hlc6Pxyk
 PPKAmdbQBvXo4rmjpBveaKKoQfWfIgM7NdZiOHblkFZoAFsrIJuPSEi+j/Q==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddbttst1b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 09:12:57 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c76c62eb15bso2474155a12.0
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 02:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775639576; x=1776244376; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BPdcVsucJ2dD3GumboDckpTME9pxKJaJXJYAu6Ouye0=;
 b=izcKcBDL7Z5bdhBUjQ0oZoN37h79nf7YSayzsWwCXPB/1hMEf83SraaGZkplwj6+KE
 3GJMpMlHXtmw5+PojuaODsQpD4hI8kSjtIDYiKBms/v16YAETLhoiDKoU3AcE96V5fEP
 GLqH6AQgIJAK3GmKcrg/iasJWui/9mYZY92dk3bFHASCuUDQgvmCmVA65MF12LofFS79
 HHnM7zJ3J1jIZHL/s/tW19CD48qeLZnbN8Gt5oNusMj2NJ22iGsWFTXXaNhF47VVwDtd
 6bFqHMP8WJa5JvI2GNb1jHnH3glJKLHTTD/viGz8TIi3mC+b3sp4eYVJGXLpiwduj1Dj
 zg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775639576; x=1776244376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BPdcVsucJ2dD3GumboDckpTME9pxKJaJXJYAu6Ouye0=;
 b=Te1ZBxm+RR3oefITOtOC5ch6KSd34shdqwocqrnqA5bMPUGJRT3hVmw8sJlYujUB75
 yNzSp+wjgDdPpl6dQogOqqgoV3qpF+RCghLE9I+pwtgsOAnJ6mRcgof//Xgn/i8/gbkA
 ZKYePM22aPFjMtkxaJGThfSUie67UHEEzRgHdahYqzi8BE4HWjewwE612kRZPPYMONCO
 Q/WvdWr7WSQrX7F2j3D/MVJjHlHqzWTedwhhyOmDUWlnmo5IlFFyIOUu6We2bqxCNBIJ
 Ja3SeXCps0UZn94Zh7VmnUZH2B+b8n9hk/DCRbc80R7BinlgtPzjiTONt6LaMsvM152P
 FYtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpWhjlozaReMRWFYjrAYQRkOElI3xdlzhV923SGRioxVW59Ya0twgLW6Vkip76vSuAWBbY67E=@lists.denx.de
X-Gm-Message-State: AOJu0YzkXgCakX4am4k0UBKvNj+2xQ8lk8soyX3TcZc+5bZs/hFdDfWX
 BtdHqqiYGe/Z4DMZL0/vfyuNnDoFiAaNBqIJ2BM554uiGIgmHuIUZt5HZ2z/BbubQoSS+ORrwuv
 X8268h2my4npf+AtGKsy8qrs1YMJQWEVzcaugAzIC7gyGv050S+VkLErt
X-Gm-Gg: AeBDiesESggBs73AW4PCod4/M5EKdjpwL42TcJtP3FhYHUJvQ8n6kJg2qcXnK10NvIm
 N8TmVuqQhKoOzXR6KBh+8aTm9X9CsLvA26HTrKOY4XMWn/iLOBBwgopGqz5rr0sYCDO1e+10DmF
 P5fRTt/dE9W7GcI8160Eg314i0CGkgjd9eHamYvI5Oe07Q+xgN+wjNehAy+4BlB1CQuzakSEPWn
 HTkVdmhkrElaPsJDD9wdWCOWVVeC6z7WMGT92HP9wQbF/J/Vh0nxQIZXttDvWoyzJDc7GO4xKaz
 FS+tJxGqiwjVh7DsLl1dazwuuOcEbISB5DwZJAzj8oz5I/0An6u50diSJkhfYAbfOuaSIYJNLEO
 9WBuOpZsBr+gksphnQo/b1dgqQsDYlQbF/u2aiec8aHOzPQ5QDJf16KiWVv1nbzIvIUMFfJFBxP
 vfYv8XWAFQblS6QKztz/qOI6ejWO4GARntGkiTPG09dv6Gvz9YzCY=
X-Received: by 2002:a17:902:ef08:b0:2ae:450c:951e with SMTP id
 d9443c01a7336-2b281818ac9mr216144735ad.17.1775639576481; 
 Wed, 08 Apr 2026 02:12:56 -0700 (PDT)
X-Received: by 2002:a17:902:ef08:b0:2ae:450c:951e with SMTP id
 d9443c01a7336-2b281818ac9mr216144405ad.17.1775639576008; 
 Wed, 08 Apr 2026 02:12:56 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27478945asm260020325ad.28.2026.04.08.02.12.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 02:12:55 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, anshuld@ti.com, tingting.meng@altera.com,
 alif.zakuan.yuslaimi@altera.com, alice.guo@nxp.com,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 varadarajan.narayanan@oss.qualcomm.com, xypron.glpk@gmx.de,
 mkorpershoek@kernel.org, afd@ti.com, andre.przywara@arm.com,
 h-salunke@ti.com, dario.binacchi@amarulasolutions.com, ye.li@nxp.com,
 dinesh.maniyam@altera.com, danila@jiaxyga.com, adrian@mainlining.org,
 luca.weiss@fairphone.com, balaji.selvanathan@oss.qualcomm.com,
 aswin.murugan@oss.qualcomm.com, david.wronek@mainlining.org,
 alexeymin@postmarketos.org, james.hilliard1@gmail.com,
 philip.molloy@analog.com, miquel.raynal@bootlin.com,
 malysagreg@gmail.com, richard.genoud@bootlin.com, sughosh.ganu@arm.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: snlakshm@qti.qualcomm.com, gopinath.sekar@oss.qualcomm.com
Subject: [PATCH v1 6/9] spl: Include SMEM driver in SPL
Date: Wed,  8 Apr 2026 14:41:33 +0530
Message-Id: <20260408091136.2794546-7-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408091136.2794546-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260408091136.2794546-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: nDsp4ogct5I0AC3HWcVAPHH-P4mkt6wb
X-Proofpoint-GUID: nDsp4ogct5I0AC3HWcVAPHH-P4mkt6wb
X-Authority-Analysis: v=2.4 cv=TOt1jVla c=1 sm=1 tr=0 ts=69d61c19 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=SfOSRMh3_Z9FsQF73nQA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDA4MiBTYWx0ZWRfX9GZtUpPORsKX
 yK5BhGTzXHLADpUKKn0K61An8K1LAiq0JMB2ek2XscFXyQ2XXuLMzNQNcB4SyK+EnV5tOVLcjhg
 GKpxjNB3nWscNbSxYIj7eIWt1xoBIFVURTkmfBjZyJiygbN06IAQq5yfJaiMbj8Q/PsB4KqcxHT
 dwFE8HOdJShagDA8zpu2VEO2DSSGDm+Bk9BwhtHtCFk2z98CYAX7K59XtsJvHHEBsNNG/L0FCH8
 xaqwgsdDJd8pRSDBPx6JTdtFQ7t46C4LgP42cizQg+VUkaxA7xI0RTrmkY6p0QEi1jrV5gno+GT
 LnpPdktW/fCel+FB9No5CjniibJFA2WcQSI4Abts1AKmKBEC5Ex6dt57VmQW3kiwL3JWR+/nPqh
 tQFlssPyWYTVCQt7+oTCMzNDKUUKHb9LfpurBuXr5JyCHQHGvb50tFhIn8u1EpX5e3rZYxJNJpv
 s46iGn3w+ChU41+35+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_03,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080082
X-Mailman-Approved-At: Wed, 08 Apr 2026 14:55:29 +0200
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

Add SPL_SMEM config to enable/disable SMEM driver in SPL.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 common/spl/Kconfig | 8 ++++++++
 drivers/Makefile   | 1 +
 2 files changed, 9 insertions(+)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 2998b7acb75..4b0d3581f51 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1386,6 +1386,14 @@ config SPL_RAM_DEVICE
 	  be already in memory when SPL takes over, e.g. loaded by the boot
 	  ROM.
 
+config SPL_SMEM
+	bool "Support SMEM (Shared Memory manager)"
+	depends on SMEM
+	help
+	  Enable support for the Shared Memory Manager. The driver provides an
+	  interface to items in a heap shared among all processors. This enables
+	  the drivers in drivers/smem as part of an SPL build.
+
 config SPL_PCI_DFU
 	bool "PCIe boot support"
 	depends on SPL_PCI_ENDPOINT
diff --git a/drivers/Makefile b/drivers/Makefile
index de993ae42ac..49650a8f3d8 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -73,6 +73,7 @@ obj-$(CONFIG_SPL_USB_HOST) += usb/host/
 obj-$(CONFIG_SPL_SATA) += ata/ scsi/
 obj-$(CONFIG_SPL_LEGACY_BLOCK) += block/
 obj-$(CONFIG_SPL_THERMAL) += thermal/
+obj-$(CONFIG_SPL_SMEM) += smem/
 
 endif
 endif
-- 
2.34.1

