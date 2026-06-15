Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7718CD98C7
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 12:19:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E095E848C5;
	Mon, 15 Jun 2026 14:19:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bkMJSWAx";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IxlQxVR3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31F64848D1; Mon, 15 Jun 2026 14:19:37 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F7FE83FEE
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 14:19:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FAobU33986858
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 12:19:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=y76OORBfQvm
 cnDlqw4pA0FoNFMOmB4elsxkT8LxVo5o=; b=bkMJSWAxMs8vAoavmxzL8d3Pa0J
 Bc0BF0NGpQTLGawdl3UZ8ivn/svU1etUB7RROsNNccAj5Y/VZ0AE3ItRcrnwi5RN
 4C5jAMYwWNu4Lxo7+hWYf5pASeUzcNxg0gBJeVTQvmHS9Eyl1SVV5Uc/6+Q+3p++
 WR49oQKgsrUrWJeavYp3pCtp/T/LBXs5i9AQv4JBIJxLZnsQLaXS2d0aCujlHrOY
 6PSbVXGiWmWdH6Jp49Nz3nWQxchW4Lkn0Gc+EjYJM5n7H5YHnYdBaq3s6/ffsJNS
 gtW1wgxc607N3HSYdjbGGzO9iuvSVbUwnzCfNAPRlYXLmW3ACLmSRWhJ1CA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etew0gkp7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 12:19:33 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c8584e3fc96so1551875a12.1
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 05:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781525972; x=1782130772; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y76OORBfQvmcnDlqw4pA0FoNFMOmB4elsxkT8LxVo5o=;
 b=IxlQxVR3mj7TyU2kg4agYSsumgAw0ElhgMxH1hpT/pmdh+Ed4hlbMCm2lMuGxAD0t5
 6quqM17vYkuSXeWlDGq5e0dRPBvsxCBhzcJJ3jJev/tFofqOUCdL8PRYk27VKUgNJFx7
 21lEY3tFIF58aO2Rj/TspBYH3TOescUlS0kxIZWnudActmsWWbznvPQijh7TqzCBuUAC
 ucJZGqN7jLeTA9hP43yVnRD6SltIm8xyOQOlp0gxV8EMV6qeOBl8Yf15i20kCHjFFK1T
 vwscrwnQv3YfjNLjm1R+wcqzaguuCsnJWwCgJ4NnTamnHs2RvzVANr2MAD39UjEbxyar
 eU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781525972; x=1782130772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=y76OORBfQvmcnDlqw4pA0FoNFMOmB4elsxkT8LxVo5o=;
 b=C0APpZYKplX4f8JRj3YCuOAicuUMiZcS3bZJzuFuBifm7Q6zjkJm9+lfZF6oVcgQll
 0Q+fqBGzRPeydPaCZ9wEpXDnX2CWdDpYMVqMZAAKqfKjiBlAcr8SomhcjDzse7O/H0Qk
 aBGlv2noaw5JpsBEexn9UtbHkiu5hAjPkAI8YfDGrLKEdRf/N/ve5TaNLyRkZMAjopMv
 fn25q9eb/hnF1CaDqetrZPYHOsrcfYvPB305fdyz9vgFkUMCvbn61hcvsAADe1p/fpEs
 TQMMVkiv9gvLjWrqTyc7J2eVKYa9v/SGE0L05n3ZFnQY6kWWMyTp9uYnnCbr0FzT+agU
 dMGA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8cXwOy0+WD1rEhGEEtlCqV9qFa9DbnSoPWezSFB4Kw2dCGXDReS0PnN8wJ9L/UEIcR9UHogOY=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9uu73qHxdfGYtT3D41yltwPIGIPdUMx1PuJuvZkQqaqouAHxy
 RcuSlrmAcg8GHJtEHb3nzgBH2FuvQz5OBFk+lFtdN+RwTIc+Mtk2VSDpn9JcKb8Tpplab3zU1EZ
 epXCkE0vLBOwfOovIm5kwK0sNTStp5skBABbUHUKcM2L/3mfWtqniosnF
X-Gm-Gg: Acq92OEgQpGwByjRS+28CaGSxjc2KvZ+iR3McBMkeU5sL6HZm8GuaR5e3XgFnRQWmwo
 +xWBYYrSZ9kUAypsf0edjWm7LdhJtMOySvo5PiSy4DXZP8mC9XIL7v1oCo6aDoXvXcBHH0gqUNg
 OA19g9v49C9IEpQQPyq/aZN6LVXks3OHX/DQvbgFELKGvi+FTOb7gW9oWULgMUbXZ3Do/uH7tk4
 x1LfovAT3GgsV50FW6ikFS2voon7P8QNqadGwS01iH9sUL37u0xjgAPTjKEEt+PbBNm54/nJsBk
 m3ElHaykU/oBE+8Wfmsz+7nRyq8xeDrNvmyDINNPrZ6n8DbG9E9jF5w5xrh6sxkYcsNqzvLEp9i
 6gLIEraMV0pMF4/wcaGhlCfDC8eaDCOpO6KhvtuoU0g5arBrQTtMsZGw2GU7Qi8oxG+7uOdTXKg
 x4I6p9BYcoVllExNuKqub6Pus4cifjnYiiwaE6jJQy
X-Received: by 2002:a05:6a00:2294:b0:842:3be7:4d55 with SMTP id
 d2e1a72fcca58-844e1967883mr10978753b3a.11.1781525972543; 
 Mon, 15 Jun 2026 05:19:32 -0700 (PDT)
X-Received: by 2002:a05:6a00:2294:b0:842:3be7:4d55 with SMTP id
 d2e1a72fcca58-844e1967883mr10978704b3a.11.1781525972005; 
 Mon, 15 Jun 2026 05:19:32 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434accae18sm10434823b3a.17.2026.06.15.05.19.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 05:19:31 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, aswin.murugan@oss.qualcomm.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@denx.de, marek.vasut+renesas@mailbox.org,
 kever.yang@rock-chips.com, tien.fong.chee@altera.com,
 clamor95@gmail.com, jbx6244@gmail.com, frieder.schrempf@kontron.de,
 briansune@gmail.com, andre.przywara@arm.com, hai.pham.ud@renesas.com,
 dlechner@baylibre.com, emanuele.ghidoli@toradex.com,
 nguyen.tran.pz@bp.renesas.com, j@jannau.net, contact@paulk.fr,
 balaji.selvanathan@oss.qualcomm.com, quic_varada@quicinc.com,
 luca.weiss@fairphone.com, danila@jiaxyga.com,
 david.wronek@mainlining.org, peng.fan@nxp.com, me@ziyao.cc,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v1 5/8] configs: add qcom_shikra_defconfig
Date: Mon, 15 Jun 2026 17:48:25 +0530
Message-Id: <20260615121828.1798789-6-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260615121828.1798789-1-aswin.murugan@oss.qualcomm.com>
References: <20260615121828.1798789-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfX9F94l2jW25hW
 e7yeNTV2qRbQnqZAoY/5F5tJ2Sq8+nMEDCoKJw/1wpMQoNr2eBAeJn9HXsB69U/vG3jmuKAMaQw
 FZlJEBeDgzn+jvZzD5hCo73nAourzRw=
X-Authority-Analysis: v=2.4 cv=QLlYgALL c=1 sm=1 tr=0 ts=6a2fedd5 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=Yxkw_4YrY3pusiogUrQA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfX5GRDuopH1YN6
 GTYh17+DYy4iGIakHkFSUS1yzqNzFpruBKeni2eAGhr1Ef6QbHPpvPhvYK70tTUvXi2UlvPigx2
 VS/PqHhKctGyxlfxRJSJ5jRr9rx/4JTd42n0Nqn5pV+mOJkBhnldrVKagtai1lEiNFN56eUWsuX
 FpuoPKIqWNnOh+kHjuB3tE9E7s1csAFL+jKRs1q2IKjZATKwTsit0wxIlaVk0Ws9PaQNVVTOICH
 NhyregCTzoVUgthaIuwL2vTvDp4c+aW6fSTJx56ppInYMb+OfvE5cT+ND35ybqN4j/nb8FNx+uU
 ay7BGfyQkzj+MTHoUgSMwT8ezja/4HNxfI5FYP2aaKLM79kOSq4mjyQFeLqWc+rBceBPJcxITP4
 HMzmh1WyUFD9g79yPWb64ftSuQHTpJYqIzLzyA1T5Y41zwcNqXRfvbAzaT08fkNvbwhUWyu8oCC
 8LTcpVcFNoYyrdmF+uA==
X-Proofpoint-GUID: bOIJpVp1_S5Dzj5bYnk1Zi8vIHZcsbEM
X-Proofpoint-ORIG-GUID: bOIJpVp1_S5Dzj5bYnk1Zi8vIHZcsbEM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150130
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

Introduce a defconfig for Shikra based boards.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 configs/qcom_shikra_defconfig | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 configs/qcom_shikra_defconfig

diff --git a/configs/qcom_shikra_defconfig b/configs/qcom_shikra_defconfig
new file mode 100644
index 00000000000..d1f00294466
--- /dev/null
+++ b/configs/qcom_shikra_defconfig
@@ -0,0 +1,29 @@
+# Configuration for building U-Boot to be flashed
+# to the uefi partition of QCS615 dev boards with
+# the "Linux Embedded" partition layout (which have
+# a dedicated "uefi" partition for edk2/U-Boot)
+
+#include "qcom_defconfig"
+
+# Otherwise buildman thinks this isn't an ARM platform
+CONFIG_ARM=y
+
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_BASE=0x4a80000
+CONFIG_DEBUG_UART_MSM_GENI=y
+CONFIG_DEBUG_UART_CLOCK=14745600
+
+CONFIG_DEFAULT_DEVICE_TREE="shikra-cqs-evk"
+
+CONFIG_FASTBOOT_BUF_ADDR=0xB5000000
+
+# CONFIG_OF_UPSTREAM is not set
+
+CONFIG_REMAKE_ELF=y
+
+# CONFIG_SCSI is not set
+
+# Address where U-Boot will be loaded
+CONFIG_TEXT_BASE=0x9f800000
+
-- 
2.34.1

