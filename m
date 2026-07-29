Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB81AC53219
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 06:01:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8EC15607BC;
	Wed, 29 Jul 2026 06:01:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pWPx7MRVUzuG; Wed, 29 Jul 2026 06:01:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8DDEC607E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785304895;
	bh=AjwHog1Hk6Q+omLu7CS+KlWnZQoigsQi+ByJXC3MivY=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=GA3SftfnH7I3AfVoePhnE15RUm5SImec2KujmZNyLjqZoQ1qxhOonarDLxWXKFgIr
	 XR6UDtSXy0TdrPWaRheTkGYosbLw0aPtkz4kl3FSUwXH2Q3rI2OsRbzxyd++4p/KZk
	 pXBh/qkYLzOz3giCelNxzv9xZZocJZZjhxg7ptQD2WSQvugk1Bu3DY3GPMktOfYd9b
	 5eyjIPr6cMTaMyWbTquFJvgZDlU3GNIBYB9pTbwRRRlEYoHYO0IcPrPy22+/Cexzqq
	 Eq2zI/NlUl30Le6UXCrO/JLKB0/vYsJxsKOjeBpfnNfiHd8JOYU8NavVaxWi/SxZB8
	 ZcMVnjb4Psoww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8DDEC607E8;
	Wed, 29 Jul 2026 06:01:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8AFE726C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 06:01:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7D87880FB2
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 06:01:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EhW8Eth1JSI3 for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 06:01:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=badhrinath.s@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 16AE280F82
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 16AE280F82
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 16AE280F82
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 06:01:33 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9818C8494B; Wed, 29 Jul 2026 08:01:31 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FFC78404D
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 08:01:29 +0200 (CEST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66T4cFLK677560
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 06:01:27 GMT
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fq5sah6nm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 06:01:27 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c88cfe287e1so460120a12.1
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 23:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785304886; x=1785909686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=AjwHog1Hk6Q+omLu7CS+KlWnZQoigsQi+ByJXC3MivY=;
 b=QIqu8UT70gAZNKQ5lPzMa+eOQI9L3NoNuCBbdVZ8WWzplF3XahLbp/H13ADOrL1IA1
 s/9LgNWO1vDJhRmSaix6WocRCoAcQePqsL7XA9uZG4YmTP4vMC3Jxj99scqCJSrI19NJ
 duZPUF/1Nu4Lxy3UIoHWI+EaMVyUNilVc98DkUxm/Wsyhp0NQaX2iw1NHWhimy9KFHh5
 sLuVUvTTMGvJtm5m4ESoj3J4ZQAX7GetBJV2vHBWVctG0Th0sKGm/1Z0CLPdYykZAj4d
 IBlzCnFgjxcW0JZZd+e/B7wQj8hpIGM57Monp6AJLl9GSOtc5IpB8kxBXVpnCPbs8vKi
 Fl5w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpSXQVXY6MJZ0k++t29l/iVDC85zxxpEjs+3tfZRg0SDIV201THaA2Vgxq+ipHGknebdbepSAc=@lists.denx.de
X-Gm-Message-State: AOJu0YxP+bXaqcjX9INqXAFuqMU6Rl8SWDsY7cxqDLluZl/2dRCCzqLb
 695B7XLT3uPnC8stqxzPIu2DSRD0eLQvXdlf20Vc+tMNLWkeJmKsodPMeoC2jWLrCdX7AsTVFah
 xliAcZdgC4LP1rtMyRh9ISEd/MLK1IkLkxfzwvt/cDJjkSxMZedkECtsB
X-Gm-Gg: AR+sD101NkBHGGMgSI/4i0ef7Y7iuq2QWxnZcOarWnlb69hUCaOsfHHN4lRGL7btbyz
 0KkgvMsy4iQ0BZWt07Sr6PyOOrpsImQM+OegwPJah5o2wVCRljifn4bCk4LX0N53/7izXn8XS9y
 LCAJ9/rtPVVtaYb/1xIx/AzKx/NZmuwwv14SXV0eHinzAESRR6MXt6dgd1XE5I+I6ZOrMfPt5Rg
 7qNe98/p1Ot17rZ7hrfftQ82KvcwbnUrEUPntyQIBlJzEKQBT0Op5WTuK4OAElS5c4p0WRsQbQS
 /4mUGTPcie/Dj3C+zGJKRcWAvT0e9oYYMbxY8QqPp+yEZxv9Yq74ykM26ZmgM5mM40w0QNXG/b/
 935grDh7I57kMd5fjBjf+CGmB9Gw9+M+6eMv2eNiCuCE4lhW1XYWizS8VBqQW1bCg3+6uNcrmLp
 XOkXt1oY5BmCZQag0OeJMZ
X-Received: by 2002:a05:6a20:1609:b0:3b7:807b:3cd3 with SMTP id
 adf61e73a8af0-3c8b71c6f7dmr5910029637.23.1785304886462; 
 Tue, 28 Jul 2026 23:01:26 -0700 (PDT)
X-Received: by 2002:a05:6a20:1609:b0:3b7:807b:3cd3 with SMTP id
 adf61e73a8af0-3c8b71c6f7dmr5909967637.23.1785304885984; 
 Tue, 28 Jul 2026 23:01:25 -0700 (PDT)
Received: from hu-badhrina-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504dd42a9sm6868367eec.30.2026.07.28.23.01.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 23:01:25 -0700 (PDT)
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, lukma@denx.de, badhrinath.s@oss.qualcomm.com,
 michal.simek@amd.com, luca.weiss@fairphone.com, danila@jiaxyga.com,
 aswin.murugan@oss.qualcomm.com, david.wronek@mainlining.org,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v5 3/4] arm: dts: ipq9650: Add override dtsi
Date: Wed, 29 Jul 2026 11:30:55 +0530
Message-Id: <20260729060056.2183090-4-badhrinath.s@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260729060056.2183090-1-badhrinath.s@oss.qualcomm.com>
References: <20260729060056.2183090-1-badhrinath.s@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: R8iHM9XC3-eYnOJDwxJkBYyr6qFdBKbm
X-Authority-Analysis: v=2.4 cv=C5fZDwP+ c=1 sm=1 tr=0 ts=6a699737 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=kOoMYcB8HEV07GVGuZsA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: R8iHM9XC3-eYnOJDwxJkBYyr6qFdBKbm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA0NiBTYWx0ZWRfX0dSKd2Gnt7M2
 n/Jb/JARUW2NNx8y05S1jcW3vrr3kTXBsos80wcEzEaGSaxx49nvUPlvRPwIn0qziEwHuQCLjKu
 xF+x84+Z/E8Js0CxeXNRxh233rF76Y0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA0NiBTYWx0ZWRfX44L0RvHlqDzY
 gHE0xvjsgT0jGqz5ThlpgB6ALmgBvZH2vby+brOHp51SiSnK3bR7l5GZeIdQGnf+In6GnMiq9cr
 jY3JdcFJxpINkc6TV24f/dw4LnGrqnnJzkxpuX/9Q/28v+MdLATWDDQy4A8MFTJ1Xx0ziyzaZLP
 Gzv0FGVsZ32k+FYYMHfmQam04ghFR9eLNExi/+Bdf1A6Y24NXLDtBqjFASeT6fHAdyGhr8hRhjJ
 SWqHkQUpw3SuS+pAMqj61BnOgSi4ctPdzp8enVYayC3LKqtbFOvcFuBkTttBlf61ArIaphP5ORC
 o/K4EAJ4FF1yJ553miniiU8PB9iUuWi1z258bh1eSZqTDihFF5Seu2rftvsdl7KDt6fbJhUjytM
 FLl7Sr76z8cutEruafxezBya3QHOzHi+b2pAxw1BBgCtPsh+2dJiXHPZl3TC5dorDgIqN558ctT
 QS9/jLYO5nWjY0rzoUA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_02,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290046
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=AjwHog1Hk6Q
 +omLu7CS+KlWnZQoigsQi+ByJXC3MivY=; b=j1+Cs0NamiWLAO2aUo/0DhNL1mE
 7PJrOxyK78nbW4h86jHFZ5j7nFtPk/8G6bHbpOQjveTNy44IckjnhjCbXFd6xKwC
 k8mLxonOm/AheCsYFT51tLayafh2hGvZIAS4VDBabtvSreE+sgXsB0s5rv9LXl+I
 1hlQh9yYxKlSuyeCKrE+NeFruCOIVOwrWAvDGWd15welNxkAD7P1Gx3NL7NUp4Xx
 ssILD9w8nQRTKqVBTXcyeyUUgTyalW/TPRXHb2xxbU8MMGajLiTpPtbwcOqeS5fZ
 8pCJkcurQE5TZDps42VzhP1qiU/SxvV45B3Yl+uYG11ydI83Qjsnp9I7PzQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785304886; x=1785909686; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AjwHog1Hk6Q+omLu7CS+KlWnZQoigsQi+ByJXC3MivY=;
 b=FWfWN4gTnMv6plLv0RBUzIspm7v9wtQDFZMIPN9xgqE8dnKZ20KTX2HPWeCMgvTP4K
 EpWY3KUlHvp6rXI2k2aeuK4hoCv1V3nscxOExOjbG8p1f67FOChnFwPWYga5El3ejujj
 +W6wlJn/fUOpQP/7+rBv1uGw8a5QEIPmeQR7duL7zE7uDqFyqUcr9wtp3d+uyCMWSCz4
 hc+C+Jh5sS1DyHT65s9nIvRzmYlGGRJk4pN2jp7LwLSs+yWTSNN5sOJAsXsyPGyXu5/B
 mqgEzTA9QTYM1kjD+KpbBEsJoJA5q+CHc7qtP1Vfvpu90f7zITuDAckGtOX+bVTddk5Y
 nTWA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org; spf=fail
 smtp.mailfrom=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=j1+Cs0Na; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=FWfWN4gT
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=badhrinath.s@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="j1+Cs0Na";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="FWfWN4gT"; 
 dkim-atps=neutral
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
From: Badhrinath S via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Badhrinath S <badhrinath.s@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add U-Boot specific device tree overrides for IPQ9650 RDP488 board.
This includes memory configuration and SDHCI reset configuration.

Signed-off-by: Badhrinath S <badhrinath.s@oss.qualcomm.com>
---
 arch/arm/dts/ipq9650-rdp488-u-boot.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 arch/arm/dts/ipq9650-rdp488-u-boot.dtsi

diff --git a/arch/arm/dts/ipq9650-rdp488-u-boot.dtsi b/arch/arm/dts/ipq9650-rdp488-u-boot.dtsi
new file mode 100644
index 000000000000..dd03de98b921
--- /dev/null
+++ b/arch/arm/dts/ipq9650-rdp488-u-boot.dtsi
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * IPQ9650 RDP488 board device tree source
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+/ {
+	/* Will be removed when SMEM parsing is updated */
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x20000000>;
+	};
+
+};
-- 
2.34.1

