Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05CE4C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 12:52:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B57284AC9;
	Tue, 30 Jun 2026 14:50:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="biAqjgJc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YNyJX8Jf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6972E84A73; Tue, 30 Jun 2026 10:09:13 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2270F84A35
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 10:09:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U6CHKS1029910
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 08:09:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 d4hH1J5DkLY+hydy1poWsnioo4tIlTU1REJgJl/76IM=; b=biAqjgJcQtP8eXTu
 mzc9msuvvlvk0lRqPMnz8kmJfeMj5+akfHGtcJFGWlDV2eC3mCQRWCExa8b4yCkW
 DZT+/gsMnBgTaD2v4XPAy++zj/d8Eqk0rq9ljr9rUl2YwuvtQfwe7kdDBob2nTHK
 D6NsNthxrTJVtE582CZLHMEdcRGWSSQhyD8RmlxZ0TN9/LkGrAQKDgjlpMRfSvan
 hA6aJz3YQQD7rSWMFR/Qf5yyJ+26K87j7hwEDyX71Jx3qbGYAuBikgHuItBBAVwC
 Xdz0fJe7uVhGue3mjpM09p04/HWyw6OTGlZCVWPDHlHqdcrlEQvb8OPvNDRve0IW
 iN/t2w==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f44v4h8s4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 08:09:08 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30ed9113e03so132987eec.0
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 01:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782806948; x=1783411748; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d4hH1J5DkLY+hydy1poWsnioo4tIlTU1REJgJl/76IM=;
 b=YNyJX8JfcYj5aSkjLz44vtnKSOmy0tlMXBe7mcQNgEJFFqAPmc7EEx8qJe6aITReb+
 P+4x8vZ53bv8xbrzvP9xlnnhTIDrGuimWO1Yc2/uoOqOp6GDSkAwwaFTdLyeBg9Fu46F
 EdIN8wOVhh0kE5lgWPRrg18fOLNcxWEZGaVRr7cFcX5pigRuSc3x58m/8260c0LI+xKK
 7Wuijc/HX6ybVhHuAD9S19uQT9w/8dpMcJhQLC0nPtqMTU4U0Re7jae0gXb4KejgUXSZ
 sf9qdk7aaWmuO9pyhH4jMpbLesF1wYtbLPM2OQqm9LtnnUMwpCNst7m/L0hj9x+XWXzs
 1l5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782806948; x=1783411748;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=d4hH1J5DkLY+hydy1poWsnioo4tIlTU1REJgJl/76IM=;
 b=Ccobt0nuhkoFM7ltKycaY6VXDlaNSs4/cGbh+bNc5CYZaA5pMVz5VKCiwFocWPV3MD
 ZQnso7+LQXz2Iq35nzKJSYedxRJ/5/MA3ebe7HT6NrzWRGk5r8BEoyMa746YF2lIljGC
 SFXLXgXZc/jVz0aVWYXFeIa8QP+miDKLSGgzrkOBQg49pWJt3mV/7/yn0mvLTBgqN6hi
 4urGPjqQgKYoVqxxQ+dOmeMYkoWjEzJkCS8kIBp3rNa07pHLlEtTwqdt8whDdulv+QbB
 25VDfqyLv7+6ZCrQKscY6kLD29HuCSGh+sIo88eh30mMwO61wx6YpQ903gOMXmBTUDO/
 OJKA==
X-Gm-Message-State: AOJu0YyFBJ5349bs57meI76ZdVQYCHMZrsufQxGAZTJzg0EhhxT6/+cd
 YRHxFPH2BfzM9OOzW/qnkOirbFMTjPEFmWraHi4mzrVklabn39Fjww1fQDH6H/QODf7MIIqfvwy
 hfy+CzsK+RGdNz0Aicx7YIUfK4mxb865xsl+34lB01ism7AivGiToh2Kk
X-Gm-Gg: AfdE7cnKzupFHlJQQD11fYGFfGVSW1m/N7052yDNYzqVI4d3T8J30fdM2P0G1qTVdwU
 8lVuHlPW9Opis9gt1QGmSvkVZoGBTXXnObss2HW5zGoCUIZaYY1DWmaUGZLi18CjR3NfwXQgocG
 xDlXhu156Uf1hYB04blh/7ikEMakIq+BZo7/uGkcrexBTKf1wlEecMgiPxdx5yGXLbc42zdMHv9
 28BGGdq5nPJ5qqsMlyss1+jQtjh1Au9ZWzuxELiBcrNmuCBYbPnjVl8KIM5S0klPWXnYzi+n9k5
 9n+wEUWaV7OAAOdiQds4R/eCtySYrNlulTh3Tx5HgbdmRoFqJoC2Y+bBmkakEI8CshGhLYYcAKd
 J3R7SqintcA9ldp/xp47q+dxcikrnM3/XIWTXFgQVwzwngFWVFB+DSUqdPbSSs6SjmgZMV8Ibiq
 OFMkB8ePViib5X41gv7SIa7uq4kJPRSsWkzEMxXS6u
X-Received: by 2002:a05:7300:ea18:b0:30e:5de6:a464 with SMTP id
 5a478bee46e88-30eea0d8832mr460751eec.12.1782806948096; 
 Tue, 30 Jun 2026 01:09:08 -0700 (PDT)
X-Received: by 2002:a05:7300:ea18:b0:30e:5de6:a464 with SMTP id
 5a478bee46e88-30eea0d8832mr460714eec.12.1782806947616; 
 Tue, 30 Jun 2026 01:09:07 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee3264f52sm5415816eec.28.2026.06.30.01.08.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 01:09:07 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 13:38:23 +0530
Subject: [PATCH v7 01/11] dts: ipq5210-rdp504-u-boot: add override dtsi
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-fix-edl-v7-1-1dcb0d2a347c@oss.qualcomm.com>
References: <20260630-fix-edl-v7-0-1dcb0d2a347c@oss.qualcomm.com>
In-Reply-To: <20260630-fix-edl-v7-0-1dcb0d2a347c@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>, Jens Reidel <adrian@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Peng Fan <peng.fan@nxp.com>, Neha Malcom Francis <n-francis@ti.com>,
 Anshul Dalal <anshuld@ti.com>, Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: ctDLA1d7A9UUpJH-0qHBUFdAZv3wcP0P
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA3MSBTYWx0ZWRfX1+WSMwxUtjtF
 Ai4nR5U93ajTR1+sB5+wh5zza4TLof/sC1YlNXGwWh6qGNLbFwKj0//eUofef7ORMN9KY5r7g6c
 tNBHVD/FQ8+K5/mX+ftMwxyeNRdUYOA=
X-Authority-Analysis: v=2.4 cv=JI0LdcKb c=1 sm=1 tr=0 ts=6a4379a4 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8 a=t4X9H54Ucq2VsXYocbkA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: ctDLA1d7A9UUpJH-0qHBUFdAZv3wcP0P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA3MSBTYWx0ZWRfXzuUcful/xyK5
 mGgcXBMERoEwmh1xIPUwapahTbLl4mPypL6GGhPzBGLzyOM3QGO0V0IjvQKgsCGUxIKVifdlENm
 /UOS/Hvh3NZobizBMG8NjmRPLqRsg6BcnZeIM20aMKdJ1gyRofbsAz+I77ymEbComaDq32ZKGPu
 dfXKseWv8PYMD1A7D9I604rd0qnP3l32wyW0Hcr9wnggc0JNb1dQr6hMoBtHwX6f7Kze9w9/tVR
 ZkLvScVgAiy8AuPMmo1DPumg4bctIIjUnxqnptrh0knbWQqz73ZyodROlr0l1DPo6Tvm82hSvGG
 hHO4a0kGHpJec8VbYwa5J/I3o7aL/0XDej1EamJN6wIsTDLQba4zJxKrNWB20/hv0dtQxByWuBx
 As1S8lPyR1TJyTmAdDvm1Cs28LY/xTjnwAZ3TSdegWX9hV9pRgMbcVH72CN9jx2hqCeERc8e3vq
 oFMNmR+0Ubqjl9p2UqA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300071
X-Mailman-Approved-At: Tue, 30 Jun 2026 14:50:53 +0200
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

* Add initial support for the IPQ5210 MMC based RDP platforms.
* Define memory layout statically.
* Mark the nodes that would be needed for SPL.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/dts/ipq5210-rdp504-u-boot.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/dts/ipq5210-rdp504-u-boot.dtsi b/arch/arm/dts/ipq5210-rdp504-u-boot.dtsi
new file mode 100644
index 00000000000..b3d048dd251
--- /dev/null
+++ b/arch/arm/dts/ipq5210-rdp504-u-boot.dtsi
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IPQ5210 RDP504 board device tree source
+ *
+ * Copyright (c) 2026 The Linux Foundation. All rights reserved.
+ */
+
+/ {
+	/* Will be removed when SMEM parsing is updated */
+	memory@80000000 {
+		bootph-all;
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x20000000>;
+	};
+};

-- 
2.34.1

