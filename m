Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6BC9C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 17:27:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E60D184AB3;
	Fri,  3 Jul 2026 19:27:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MATV3oPF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UsYh2VUP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B075E84AA6; Fri,  3 Jul 2026 19:27:07 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4335A84A95
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 19:27:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GISCS446213
 for <u-boot@lists.denx.de>; Fri, 3 Jul 2026 17:27:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=4/5dDc/Vuot
 TEMWhzcVCQ3iIVFXoVcTblEiPb9xCtFs=; b=MATV3oPFaMyQrlZMQbWyTDxtX6B
 c/4oe3P5ZCRz0GGjhmZp5oNNcbiw7fjjUcgoWiPjJl3LSLqxM5EJ28sC8Phro5OI
 +oBKimTA0RAs8W4fRKYnkDrVNoU2SjJOlZyL+zdlkZZVPVS/Derau72EYYvV9wLj
 bNw6qZfah3Ii3DQalOUhJu6a/ZONfXWiqnwH40kAL7rhxAOqne9e0mv61Y4uB38y
 bGfYyGn9QMUiqdOBKw0ilI1f8hrE92pxT6MvtgHQza6YKXAECfQQAxvMLHEX9QRl
 mj2nMwIfVSN5T7aBkPH4pY/LFEaXJR0uj2Vqp0xOvURKzJFoFeD7ZY7swNg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6b039kda-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 17:27:02 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3811279d51aso1445519a91.1
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 10:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783099622; x=1783704422; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4/5dDc/VuotTEMWhzcVCQ3iIVFXoVcTblEiPb9xCtFs=;
 b=UsYh2VUPkWlQAnY+rglpPLD2p9EueGMZM0TObcqFwxJXRtukkb8aeQbPC3zNGou6iT
 grk2zMzoUt4dszSz9hFsTmOmN+Ac7hVcEnoAcK/ogxaweSux8Ghz2hYbqGmWOcSUlYW9
 yGew3nXs4tTOTVYuiaw5K+F+FLpxBDsz1h0pzsLugI8bZCkdj7wG2k1Bx5LG6a8wcHUU
 ezyNzk0y3iaLajD5uRUqQFsjrRPHVqWJg2reLMfkca5TIEOWFLEzGXgnOwd9dxf42Ofk
 1mcQQmJawsR20jlXzHnUTEwrSPoow57UPvBboFg7bgu1qvhb3htHuu5pKMVM4Adsj+UO
 22mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783099622; x=1783704422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4/5dDc/VuotTEMWhzcVCQ3iIVFXoVcTblEiPb9xCtFs=;
 b=qYB41G0/a4fK+z1DQKmrmY3GO42UtAW0reQQSsOxCI4ixcGkq1fS8ExkNbwEsLTQvp
 y2blKlqagO2L/5uPCEav8fO+KO/bRdXTQARz3cAG3JRngjRHykFWHEAoWN/hfwcgFaPv
 /QZoEveeZVHUaXs3TJQQWGUgViUtHYB/+2dA5rBh0m/uBzCudzV0ZQr+o8OfDS5OoT3R
 EAjdjIQ3HN1xK2ahuNs0VAn8opUimI+aZXFLMtkFjrEjrtPGd/z+EeUA3b8xjgShGwwG
 3us/7qiFvv2ndxG/kPWW8tBLEZRU9p12sAcAhFQc5OrStr5tyg1eqtNq46iRua1bZd2d
 Uwsg==
X-Forwarded-Encrypted: i=1;
 AHgh+RquUPRitUUanb/h78ggV9jIUN/5hz7POFC1d+3dOYwOuLLLEwBb9YYbG+nIUw58B+WSMPZAaHs=@lists.denx.de
X-Gm-Message-State: AOJu0YzWVTOUeZrQmsutgCjY1iT3L9gF6mnHKOB1uEiZhkQ6OLiaxsbt
 omSyeuLLnBrjGEvAh9gNC90pGOg7FBZgwej9etF3V7wpQ3KACeJsJYV9Zvz2ZE7E7DwidQ1aXmo
 B7m/KFzfDmqMbfds44yV/Vhm4tPqqmOgRaiid1cXAIqWmgAny+eVeJ0SE
X-Gm-Gg: AfdE7ckMRAzjstskaTnCQpYfLpqMdjhH0yDle00ZyzfYNfE1eeog1YGR/mmueKjIgBx
 CnsDYT6HN2mRhT8u3ma/6240CQztyJNse65iApRWwKKUHdWsiOP0kS6nSD16w2u6do7/O254rkV
 J60NVY84pyDUJy91507TJ6eXnvHJ4ugkQ6aek36FfXSxCtIIrpS5Ey/X2vpBAb8xsEkw5CMI/3r
 2ioebtKrNY7WAcUPiAqNiuuEWLMCEJi3n1QsSXZdOcAmG2ljSuPRC93yn9uJuiMu2WwqUAja80h
 hy5fjJ1S2A6SHtT20pYmnj2m8uIzQ2aD0GroXArFgUxEfNcZAsY4r2eEmQgAFa37LZo4G9o9mbr
 Vix13XbF0kXReceIEKPkymuz6S20J8W6yKGSg14WyVeWXNUKDslZZp1nrqnw22t0Y0XXZx7Xuld
 yLLDVZWcjVzGunLxKvNFmsRbDwNDuekQ==
X-Received: by 2002:a17:90b:1c8c:b0:37f:9ce1:cda7 with SMTP id
 98e67ed59e1d1-3829f9e9bb1mr386230a91.29.1783099621796; 
 Fri, 03 Jul 2026 10:27:01 -0700 (PDT)
X-Received: by 2002:a17:90b:1c8c:b0:37f:9ce1:cda7 with SMTP id
 98e67ed59e1d1-3829f9e9bb1mr386207a91.29.1783099621266; 
 Fri, 03 Jul 2026 10:27:01 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0b813d37sm23489561eec.10.2026.07.03.10.26.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 10:27:00 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, quic_varada@quicinc.com, Michael.Srba@seznam.cz,
 sjg@chromium.org, aswin.murugan@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, dlechner@baylibre.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v4 3/3] configs: qcom_qcs9100: Enable Gunyah exit support
Date: Fri,  3 Jul 2026 22:56:34 +0530
Message-Id: <20260703172634.140515-4-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260703172634.140515-1-aswin.murugan@oss.qualcomm.com>
References: <20260703172634.140515-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE3MyBTYWx0ZWRfX2UOjV2Ko3lqi
 lp2CTDRTbZ1tQGuLJdV68n4ou2PAap7bqF+Ko56cfJcrWVpW9og61xR67KmoHbnxiiRZwHUwKUV
 0OYOYIWjWslO2IYetJi9MIVBTY2lAw8=
X-Proofpoint-GUID: BCzv_g6GY-h4yokJ7Mr7KHFduHS6Ykwx
X-Authority-Analysis: v=2.4 cv=FoY1OWrq c=1 sm=1 tr=0 ts=6a47f0e6 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=u-SOsaVsrQWS628QcVcA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE3MyBTYWx0ZWRfX/gC/Xm4h2TU1
 YSn8W7anOUbB4ahUg/WiZnUbqfc1Ddb3bZJdO7XkxPQ62Gl8rE+Ag1wJX0urELPcXLKZmZ+T66U
 HwMh2RvEUKIDViGBqTEpp9EGmOB0j9SssNrXgz0ewGm2RlZBe6AiGvgIlNt7FVd3HjZZ5OX60ap
 c1BpsLbSJFU9xQVt1yhe5gW7UzCOq3Y/xACwoxoEqjDPE/liiWCqo4Yv4USPzDurxx38a1h50Cq
 iUQeS1h/mnOKfUCpYb/JpO5cH4fsjrX+pQeTkzJVpp4zbm5awB1Ty8B7nfiIVLXyJ6eQyxx0o8F
 4mkBSZnP9mtI6EFm+6bzo94gj5VRWO94RT7A4IGpepIwBEFJRNic220nxVLdV+/Cp0Ql+uwLx9f
 IuoRkVP6QOZk3K8KShfp3SJxuYRtUvYY0YmRgB1Dr0MbA4/IS78P65xtalg8AHt7C9EhYihHTmX
 5Jp/nQWrq7GSE1/Z8NA==
X-Proofpoint-ORIG-GUID: BCzv_g6GY-h4yokJ7Mr7KHFduHS6Ykwx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030173
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

Include exit-gunyah.config fragment to enable early hypervisor exit
on QCS9100 platform, allowing U-Boot to run at EL2.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 configs/qcom_qcs9100_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_qcs9100_defconfig b/configs/qcom_qcs9100_defconfig
index efd6c63f212..fb7addb5276 100644
--- a/configs/qcom_qcs9100_defconfig
+++ b/configs/qcom_qcs9100_defconfig
@@ -4,6 +4,7 @@
 # a dedicated "uefi" partition for edk2/U-Boot)
 
 #include "qcom_defconfig"
+#include "board/qualcomm/exit-gunyah.config"
 
 # Address where U-Boot will be loaded
 CONFIG_TEXT_BASE=0xaf000000
-- 
2.34.1

