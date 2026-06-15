Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B277CD98C7
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 12:19:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2240D84884;
	Mon, 15 Jun 2026 14:19:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="R7uwB3ee";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h0BUtrta";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3064C83FEE; Mon, 15 Jun 2026 14:19:16 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F4328488B
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 14:19:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FAoP9k3983377
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 12:19:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=wOuhKXAolrk
 wufCg63goxA2aZfQUSCkFpuVx/rIA/mw=; b=R7uwB3eeDEi3fCzZ637FTfYqDxp
 xnkWQFfZTKeL6vudZvCGkWYPRJ6QP30mebZDOkPk7jP8z47HsZfSB98kR7TcZ2nR
 9NLtShlP6Qi1nG3wdw9Pcfm4YkBQ2eh+JdBCEKYFf7SSVYALaTkt4htTfoq19Jww
 semRyuPsc1LbhFYP01aV6euk1qCQSpiraMwLnF/v0vH8mpwl88aEJ3qWFRyh+Qj/
 NkzaYBTxjZXGBjS7UP8VxYt3CPck016rrzYUrNTyWYc8CTdEhlWSPxrSMXvr5TH2
 B9nZ3pD1lRpYW0XPyX3T361gW6aGMVjo1TgEnfC2slm1elJeIUV+9yuFwIw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etfa70g18-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 12:19:08 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c85a2cde332so1556822a12.3
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 05:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781525948; x=1782130748; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wOuhKXAolrkwufCg63goxA2aZfQUSCkFpuVx/rIA/mw=;
 b=h0BUtrtaDYSpP3iYE8e7fZ20E3kRGAOli1LHOIsK8mJp9OhVFDjvjmVHiJEjeMuZ2s
 sc+jqN7yf+nEIEAh0INI4Vq5jIfK3VCifAHi/qf61BXvyW9fOUEuijDMzSwYjYVd3L1A
 1PrcGvoinclx3yIgDSfiWRCGKXJJ5+u1F18fFpqLEldOaoCUz5dA7LR08F8edareDJNW
 Ioj4hJaUwl/FtWZDoHWmTH0jHvUV+oMxyXQ/jbQQCISqoGKE98babSsY1jygpiSCgi+I
 rBWmmf0dxHaZXlgZL6ntfFw/Vq4R8TKKUSRA4LOwIWoIBdmaxlMWSlses3FGFhWWh03f
 6CkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781525948; x=1782130748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wOuhKXAolrkwufCg63goxA2aZfQUSCkFpuVx/rIA/mw=;
 b=nCt9pEnKFNugTubguHLcqbwCHk4ZrD2s+LjeZqKiC2UxTIsB0seoke3j1kvUU7Qycc
 NhlpTm/3URCVFX76KAG5hWxhdYSSff/RtW/W/+NWPk1LkUGgAkxDzqpEXQXHngzCRlvL
 cfkYG2Ha3ZCo+he/2v1gTF5SqHHb2tZWeSy1VhNMQ/nwufOkfwGJdiQhNX1xBuStwsyv
 IwbWi32xnMWz0kjCDxtmu5LecmxGG4ymMCG9OcaW6zDWIfG0YinpMYNM5XmNJJWmrGB9
 5YN9AJGiaNBo9L8BOESc2lElC61YucHHClJ8dySpuJaJ9YXxAWqaFW2I2vRBMeuVKfO+
 iZ1g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+GxsqzI2IIWVCHY18wi48SqO/6Lbi3OXOEDkHxg/vvKohMh5RUeI+yAVvmFGWnfeeWd4lRcks=@lists.denx.de
X-Gm-Message-State: AOJu0YxZUI6sdlIUeItPytcSXysmri6zx8MbApuFGiys3t/B/gxmsyd3
 zTZHZx8RAbgn3P4CssmUOah7FES4L66BR9LeFiuqHnW/R+JfY2dP2uy1w0Ll5TlIAU7yVj73eH6
 tCn2LqpOEJC2WkOzrj56+VNjAQhyq5CaTIfcabvRZjahebaZpgSKjknaz
X-Gm-Gg: Acq92OHa7h/ZIi/XE+acyX/WMs0/o6JexWepa2Y0oWJr6o2NVEMhOxxU9JHId6U9P7u
 J3oBOcUdoCP3AuAYqTooy/k8Akh0PwHdN8rDm26J/COTjMnTxIlFaxlMQCEqTMqxO1GjmHqZZzf
 vqXKTlLN++zADPMNpY9gxCCEFPMX+3vf2yRajuZsUX0MpIla/BLOesMwU8jcwXOMZBnfO73CSup
 N02A7Y6Jd8sXraNxdeV8W5Iq6nokxuQuIEHHfA9QdlYDKYEWcbCRkl1d9MAq3mbWxr3zz2TrkvX
 IzusKklcoGdu2Y13uAHxXqhAXs+w5/PY48uyQALEl6rpuemYn8gYp0FZfaapNoJtRXBqyXZOjIG
 6/k+zySOdP9LGAUtLqffpN9ZkKgdPi7NO29z0qutbdIaWEQSw953q/U8LH+e4lx7c0BPsDAK3ec
 xasoSK7dPv06oFM/pqrgVoHtQvLbb3uNNUrI1FmkJ4
X-Received: by 2002:a05:6a00:3d48:b0:842:3a98:b34d with SMTP id
 d2e1a72fcca58-8434ce83f17mr15546872b3a.31.1781525947526; 
 Mon, 15 Jun 2026 05:19:07 -0700 (PDT)
X-Received: by 2002:a05:6a00:3d48:b0:842:3a98:b34d with SMTP id
 d2e1a72fcca58-8434ce83f17mr15546803b3a.31.1781525947013; 
 Mon, 15 Jun 2026 05:19:07 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434accae18sm10434823b3a.17.2026.06.15.05.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 05:19:06 -0700 (PDT)
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
Subject: [PATCH v1 2/8] dts: shikra-cqs-evk-u-boot.dtsi: add memory node for
 boot
Date: Mon, 15 Jun 2026 17:48:22 +0530
Message-Id: <20260615121828.1798789-3-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260615121828.1798789-1-aswin.murugan@oss.qualcomm.com>
References: <20260615121828.1798789-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: hU9QW4ce52PTLP0eof8u3dW1IyW7TiwL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfX/bt+q1m9P0GR
 6/AEphdp7SgERdIb85bFL19TAsoyxzKEPkN8Dgm5f9LziYMCCRZJGGmi80TkXzkrzJuRsjXZlM5
 xVinVD8XteoNp5vqF33qO0r+QfhzC0s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfX/38A2W0DEtc7
 UjMeseUX9HIPZMDmu2jK+NtEz9JiHCw5CVYwIKoDYtWGqaC/N0NhIp2znMIZhmlPWKzCjB+hJbl
 cjbJEQGEBIuShVzaStOahdKQPj0sT4yoF9gn51XNdNV4R8A2LzHCl1WE5l6xjJoOZWmYBoTVUTj
 wPfTJg8go1Oa0FpjrtjWTLokoOuvgfWSbJLEXtpWQNLTPHNg4uwOObR8VqE7XgfLEu7x4l6p8v7
 fnG20dhwFfj7veY19bbLLxp6Zw2C4JIGUTUev2hUg25z/7PF2paunueRIRtega7S9Z7mLvbSCnB
 HKb/MrB1zcg+AtnMUIzp8ev8XIuIEaQv6O0NwpkMGMfrp1xYtxl0m26nPiF8aBaFSWiI971aggK
 YGedGupYJmLbEaMdSEB3Ww+mkNU9dxCiJbFBPVAdy941CkP93JefaopkKWmKunHSSVzb/R+AUxg
 6PB77uiJSJKZhTW992g==
X-Proofpoint-GUID: hU9QW4ce52PTLP0eof8u3dW1IyW7TiwL
X-Authority-Analysis: v=2.4 cv=AN2yTM5Z c=1 sm=1 tr=0 ts=6a2fedbc cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=ickNL3SGw8CT5CJkEdkA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
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

Add memory node to enable proper system boot.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 arch/arm/dts/shikra-cqs-evk-u-boot.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 arch/arm/dts/shikra-cqs-evk-u-boot.dtsi

diff --git a/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi b/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
new file mode 100644
index 00000000000..5a21e0894e6
--- /dev/null
+++ b/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+/ {
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x0dd00000>,
+		      <0x0 0x8dd00000 0x0 0x15c00000>,
+		      <0x0 0xa3900000 0x0 0x4ff00000>,
+		      <0x1 0xf3800000 0x0 0x0c800000>,
+		      <0x8 0x80000000 0x0 0x80000000>;
+	};
+};
-- 
2.34.1

