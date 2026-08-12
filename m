Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC1AC5CFC1
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 01:12:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CBCC360A42;
	Wed, 12 Aug 2026 01:12:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fTJC1uSmJhXG; Wed, 12 Aug 2026 01:12:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C7A8760909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786497166;
	bh=tbP/k6WchHnH+sdK7hagnQaQRMQmXXKRkcaAVCnJbXQ=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=AxevBMCWM/lCZ5V6LsHHH4hmVvR/ssyv61Hd4wuI28SB4QM5A8x1exAFigkbb8N7S
	 LXUtzE/ztGKyVEJXHCVk4uJwEpttfUJfpsbT/015b+W1HJNmCWeEOGSicV1fXyuxoY
	 Q40aXzBGm+1gm4X2nCPI45uJiOwqNaChLapVTaoPMHwrfErmkg/uQLE3Nac3axeVBD
	 DjhxEGrSnfzLQzUWLs4BBp0EIgjHUmO90bCqT3jDvDkAOacczaBOmZLbyoHkzOx5of
	 A3uIwE+0JjmaEufRNDPQ7JR+ax6EGJgvNu1B2+WraItrrUndhvPI2Hu2+6Fii1+j+v
	 n/Jd4FhnAENig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C7A8760909;
	Wed, 12 Aug 2026 01:12:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1BB1F1F41
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 01:12:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 01D2E80F29
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 01:12:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id suAKBBBngGnC for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 01:12:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org DFD3180DB0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DFD3180DB0
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DFD3180DB0
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 01:12:43 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BNH8tQ1990193
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 01:12:42 GMT
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049gtt6b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 01:12:42 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2ce7dff6253so14628365ad.1
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 18:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786497162; x=1787101962;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tbP/k6WchHnH+sdK7hagnQaQRMQmXXKRkcaAVCnJbXQ=;
 b=FR/czVFNKh8jaS8nkDg+PNx+d8HeAJ1axJ6KfsHgTvQ2A75PVICTNstf2PzwdCxERH
 Mn5mSdo1Jc20owutgV7TMTPXChnDnqQUl27SenRlR3wTGuN/4d5GHeFshWcsoWQWuYN6
 4rm6Xrre9nfTQDBzQaYPjT7DWs9DlS5mUj78m+Uld2E9uJGwynxBtuHTwMsadva14ulS
 /UXFXNzo7orNI5QjgQXOu52jquvsEEeaPQ/Dw8RC56zilyYxY6pG/cTNF7D6o8FRaSAM
 1FDK97zOc3Hd/R2MZLumczRgJQPQZ9HglhHWGjzmQPgAz5crYXJ8Jz22ip1LuEji+2HJ
 F1kQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrZ725Cv1+hdJw8hP3ODJVCXHk5wVwRmGDNSJQ/LPzsTTSrfXNSIY8t3s8EvuAPo7r7B6lAnBw=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yxe1AwAkYAobdv7BhP6jwK0rsTzNi3vZnR5x6HrefNK1Cyz4K9J
 58D42MoOoiohdOZG5b7vKEfSygOEHUwOJfQBCoVtktFhThOLeKmW7tUfqkaAE067nVZ/moCxGL3
 w0ralfy5LDVE0UxNTpzqJ7n2XpZrJbjQ2y1Kdh4GNart9rFc4nMj1/8OG2y4TA2xJ39Z8xGEbHF
 6j0bA=
X-Gm-Gg: AR+sD13NcrsD/V5t9c44FY1jqzczjU4doW4sWz/LRd+jcAno1JLmjs8hnyFJAJRHbR5
 AIEoO/mGiT5V1iiIcQxoZiNfeN2MQgNeuSrHEX4qqPPQr1mbXQADNbKEKQGkHxuRtXfvV0AQWHh
 f5liF8pzOyz2R9ppoocHgVbpIMt0OH10yKfbUZvJ7HRV2VqqBwGNZOfF3c0otXjvSn1uF8FsTTC
 wwqPkfc4/pM3cJdzO2ju4iP+2LvCYWSEmviDWnc4hWyMMo3Y5k98YWXNqvJ+gkZDq+H13IEpPu4
 yIuz589nwsrbzImfcmGHs/w7lg2qlPs+qsrZK8tTEkrXme0fCOvl+lEkr8aMD1N87ypyuW0TD1U
 /ZWU9WmJYdVX7WfMoSIOmZ4HOV3RLPDr/ivm9ueNPLeYDNnbJ6q+BSrPpuNS7+uvl3aVLD5JeXl
 rUVxsSAq+B0UiJlx8PghOEz1tfREFk
X-Received: by 2002:a17:902:d587:b0:2ca:d034:ee7d with SMTP id
 d9443c01a7336-2d32d7ccecemr55454875ad.4.1786497161534; 
 Tue, 11 Aug 2026 18:12:41 -0700 (PDT)
X-Received: by 2002:a17:902:d587:b0:2ca:d034:ee7d with SMTP id
 d9443c01a7336-2d32d7ccecemr55454305ad.4.1786497161051; 
 Tue, 11 Aug 2026 18:12:41 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31cf6d7a366sm4371725eec.27.2026.08.11.18.12.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 18:12:40 -0700 (PDT)
Date: Wed, 12 Aug 2026 06:42:03 +0530
Subject: [PATCH v2 5/7] arm64: dts: monaco-evk: Add reboot-mode support via
 PON/SDAM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-b4-monaco-v2-5-865d288c0be6@oss.qualcomm.com>
References: <20260812-b4-monaco-v2-0-865d288c0be6@oss.qualcomm.com>
In-Reply-To: <20260812-b4-monaco-v2-0-865d288c0be6@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Luca Weiss <luca.weiss@fairphone.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786497134; l=1367;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=YqTtDjdgOsN4sZBv8GqsXXhu6fBSPDT4K/pgIouWu38=;
 b=JcdJVA/qi5LnDKTTdY0pLWP3Iy2OCtWDkGYPyDKRIcgV1gyBmpatfjaoQ5hR6DK8UuUqsdyX5
 Fnn87I0vpN4BpIC70AJq8ryYOiQ3aSSeY2jMOn+h6JlPcTJ+aU12pVZ
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDAwNiBTYWx0ZWRfX9hng0C/3i9RR
 bJxkbbYGO5WNtfDplWMnS5pfEL/ugbeUb4kRS8gY2jjziNMRdtu1UA2WWU/4SNKPnCUwYTiVmiv
 XW4wEopD08/gAllUifN/KadyjQowWls=
X-Proofpoint-ORIG-GUID: 0XtYYf_5VAbLc3k4nf-vfsWN1mY78rx6
X-Proofpoint-GUID: 0XtYYf_5VAbLc3k4nf-vfsWN1mY78rx6
X-Authority-Analysis: v=2.4 cv=cvarVV4i c=1 sm=1 tr=0 ts=6a7bc88a cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=camUvvK6nBet6LW5UHAA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDAwNiBTYWx0ZWRfXx7RZ2TZFcF1v
 8mtb+YHWxZVENPAL39IDiCvoa0xc856At7cBg6VweR4hsSs0lO7NBGj41ARoDmGyEpRP6v5p7Z8
 TEuKOqO1IBGD8R1Gk2PgXbTE9kI094W/FvRFlZhHxUVR5mZ2FELrkWSjvRSfP0k1FCRK/w7gV4+
 dxaEr/jvf54iJge8eeHytJsNP/Mb9hbtPMuuHSk2ZAioJSp6MBcvBp9DkriR8HV2R0vPlze2IZ0
 XSzkInv+2YuMXAb6liL1NmJLd1bYjjaTKYgT334qn3PehBNkNimSm4n2uSjxkLKz+VWgoaUZw4W
 Cb0O9VXsgTJbr6TxBRIyaKRWFOHQ7Z+Qpijm4Hpf4dq5HPsQLmcoET1xAwh3PL6krxX1Viqc9U4
 yDXYOZWGzdqfpG0UADYqAj01SPbirffa8P5YLMrF98zpfsBJUOQ7Ug4vYXPgCWyV9N5Z98SNo3z
 fgvXSz0Y3venNaczoEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120006
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tbP/k6WchHnH+sdK7hagnQaQRMQmXXKRkcaAVCnJbXQ=; b=WTcqzbYISMOl4/fv
 kMPdj+JhO0PEXX+De2o1++ClI7zz8kI3ZvwNMav8Y0ms7H2BRGNmOMV4LK2oO1Ep
 0tkadKIztIWBVi0L31Xj8Xibu6k4KG2jxM/Ywqw5t5dUcGsbZ8PFQpEbC1fycOJF
 u4GWo//jKTvI8nEiNaMneDAOOhAXTsIJr4uh3E9z8MpvlqDNIfLPp7GYU09k5wMo
 tcqzrlXiOqnBZumzzVgyzu3Eu9l47SV2o9cLGCyzaw5zBsrfeh80fly/lgLPoKff
 Hikyg1/RWusFxekc5RmMOGDE1ZWCx2raLw7ssXSob9asR8s9nBc71I0GHzw0r6wa
 Uy3yNg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786497162; x=1787101962;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tbP/k6WchHnH+sdK7hagnQaQRMQmXXKRkcaAVCnJbXQ=;
 b=fipTF6iO7V5zaGJA2YjEIfDPirmdW7uSKpPpuna8WxwqKJfAEDGVixfIzCuvt0qHRn
 YBPnhBBjEnYZMn0QRgS8boIy9bhMVrsNJ4lmp6tznkpzVNoaqpCSxehmEp8HOSXKBlRa
 JJCF96VUmPDxQw5TwMLPbpvV7GLvvZx7wkQ1wMDOjIRGRNAbLMn42qJ9HwjENsqV315p
 WZ8clUcrQc/r8s9Pacej/qqRUYPn17yo52GIuMM2q3KRZNfWNaSt5FNaPXuDsRqS5GxI
 DUck/uwyfcMOGpd9jWixD949KVMjT76GJd+naoxdQgzyFr4mvMLoXfrm1m2KEnTP1MDX
 PZ8A==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=WTcqzbYI; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=fipTF6iO
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

monaco-pmics.dtsi has no PON/SDAM reboot-reason storage, so
U-Boot can't read the reboot-reason to tell if it should stop in
fastboot instead of booting the kernel.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 arch/arm/dts/monaco-evk-u-boot.dtsi | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/dts/monaco-evk-u-boot.dtsi b/arch/arm/dts/monaco-evk-u-boot.dtsi
new file mode 100644
index 00000000000..5520d111864
--- /dev/null
+++ b/arch/arm/dts/monaco-evk-u-boot.dtsi
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+/ {
+	reboot-mode {
+		compatible = "nvmem-reboot-mode";
+		nvmem-cells = <&reboot_reason>;
+		nvmem-cell-names = "reboot-mode";
+
+		mode-bootloader = <0x02>;
+		mode-recovery   = <0x01>;
+	};
+};
+
+&pmm8620au_0 {
+	pmm8620au_0_pon: pon@1200 {
+		compatible = "qcom,pmk8350-pon";
+		reg = <0x1200>, <0x800>;
+		reg-names = "hlos", "pbs";
+	};
+
+	pmm8620au_0_sdam_0: nvram@7100 {
+		compatible = "qcom,spmi-sdam";
+		reg = <0x7100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x7100 0x100>;
+
+		reboot_reason: reboot-reason@48 {
+			reg = <0x48 0x1>;
+			bits = <1 7>;
+		};
+	};
+};

-- 
2.34.1

