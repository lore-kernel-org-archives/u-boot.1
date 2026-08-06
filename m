Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3F2C56208
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 16:13:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D08C540738;
	Thu,  6 Aug 2026 16:13:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QQjhdW-lQqWM; Thu,  6 Aug 2026 16:13:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EC23240706
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786032785;
	bh=tbP/k6WchHnH+sdK7hagnQaQRMQmXXKRkcaAVCnJbXQ=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=dLtYXh6VTKKh92JKt0kwieU1HuFCZqM0m+oSDQ/ozSIoNPPQuXq/xdTUoQjdxwnUH
	 47B5PEwBqmylUUw0OhnlK3Vi/1xSJh9xwZETPhIprWk09lhsJR1jFRw9g/gp1WRPc/
	 Qt+ehVuxWtwRBlH+hT2h+lawryNt6xjiROLzzAZHwK3wZDdwgbWhyEGs3KmQRkRhXD
	 2EPjpD9QcRk45jNkMiwq2XWoKlW7JLgaSqVkW0yrsTyC2wGN/C5IMK2MXs4e8LY6NS
	 mbuvexZL1gDAZvAUnHKtgG2eSsdywxqdF/2HXG6R+YBXkYy93zpBUCUhBKSNiuJKe2
	 kSf+9TKfHZyjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EC23240706;
	Thu,  6 Aug 2026 16:13:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 93B01218
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 16:13:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 85457402A4
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 16:13:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i7aiYlne6s4s for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 16:13:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B9549400D8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B9549400D8
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B9549400D8
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 16:13:02 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 676EnXwB2005402
 for <u-boot@lists.u-boot-project.org>; Thu, 6 Aug 2026 16:13:01 GMT
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvp72ae5s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 16:13:01 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cb733fc5024so3250821a12.2
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 09:13:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786032780; x=1786637580;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tbP/k6WchHnH+sdK7hagnQaQRMQmXXKRkcaAVCnJbXQ=;
 b=sPCCxxs8GusmsLJcQ8tl6LIiGKTC+HQK1DFxSv7/sYiQEwog2SQCYLrTvIC4DjtUte
 8KyC1ShlZeT88RLfBwcnTucpKiLrONfr5qMuEhGbjIC6B1sckXNTTEzyDXLd/nNcDJXe
 NaR+vFbOdI9P/vfEUZoTJniq+VHYwT4eVVhf07vryRijrQIx4+m8ij2RBa2VcP4xMGJs
 piG/QsCegJkE9k+GtTzXn+LLCy4SbtuYzfE4cJYm3oiN4N6Hx2tJFDxJ2B840ytebhjc
 cqfGMeSCp27XpP/k4wfixdvgC61GU4meuXnhdzL6jc+vd5hHbDTNoaarppIa3dJC1zES
 0Z6A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpnHtbWQBJUUYpyvUSOuG4MC/19FvizBKqCp9XyTZYmWF12tMBgVQwdEe8GX5d4WCOP+hKS80k=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yyc7f/pGzNyQCGG8QtwTXuRR/jRMRe1CUSCyXC2hW41zzXXai3Y
 wMoh8TWXFOx7Hp8KgJqPyaHerqAr1Xrvfy8YtZVxLQT6L+mBn4PPKJzf3u6vvtlJerHG4u8kXZC
 dpWcTZ/B8qGbZ6odoQn48toRmn4L8wDJtzDGNmpjG+9P2g6YyF6pWyw1PbIvY62ZiZXM4Nuzufg
 SACzA=
X-Gm-Gg: AR+sD13CGwNy83BIpkT7CUnEGM9IPqam/ffvtEuXuTjeasuTFUdTxojdrLd5QxTL4f7
 1ghzUJLdYzsp4eKIAmu6j3xMe9CYmAi/qsfAGARyaLIOgcFRYqOuKYcdDwd59kM4X+zTTz9Ng7R
 swuMDH1RxxJKZVoiq8Y3RrBHPNLEgrLz4vUGmmbsnS/6jVYsSjf6scevHmCGwdeLIlqfuXKa46T
 mDv0OL9KvQ/e0BM+GNJ2oKgLfbsQ+25UgtY/dhGR6ScdjPsrvee13OpS6U/le+VL1zokVawy2T1
 TFgagi7MbHlruq8EQg1H9arRILV+AtgS1od2RJUQOB8eD2lLyi11KoYOfNnT2a9MwtNcnP6fmtj
 B42BjqC5cPUgeYfPZD8jKGduR0RMnIp6hVH4TOfyj8N7621ihdMd0rP/arDYo4lb8cruRnOE5Rv
 0BtC9GUyKJt7+vRq102p/uIb2h/MUc
X-Received: by 2002:a05:6a21:398f:b0:3c3:a41f:ce7d with SMTP id
 adf61e73a8af0-3cb85bbea0dmr18906375637.0.1786032780156; 
 Thu, 06 Aug 2026 09:13:00 -0700 (PDT)
X-Received: by 2002:a05:6a21:398f:b0:3c3:a41f:ce7d with SMTP id
 adf61e73a8af0-3cb85bbea0dmr18906332637.0.1786032779753; 
 Thu, 06 Aug 2026 09:12:59 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31586777bcfsm43381878eec.21.2026.08.06.09.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 09:12:59 -0700 (PDT)
Date: Thu, 06 Aug 2026 21:42:22 +0530
Subject: [PATCH 5/7] arm64: dts: monaco-evk: Add reboot-mode support via
 PON/SDAM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-b4-monaco-v1-5-8d7b4e2f4fe1@oss.qualcomm.com>
References: <20260806-b4-monaco-v1-0-8d7b4e2f4fe1@oss.qualcomm.com>
In-Reply-To: <20260806-b4-monaco-v1-0-8d7b4e2f4fe1@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786032752; l=1367;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=YqTtDjdgOsN4sZBv8GqsXXhu6fBSPDT4K/pgIouWu38=;
 b=133mONtefJVDdWHr60AsdCYX1wMdWxH3wBR75U00L52rBQJuV4VKXVsZaHSKk1fR2mCa4aUJ7
 hk5mae2LrVfD4YcJAar9ZTuae3Y7cI0YbzM2ZvrLYdDOUH+D1ywqN1Q
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: oPmAeM_OySnIdwIXoa-J_AyNooDkScMs
X-Authority-Analysis: v=2.4 cv=JYCMa0KV c=1 sm=1 tr=0 ts=6a74b28d cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=camUvvK6nBet6LW5UHAA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEyNiBTYWx0ZWRfX/8TRA1IukRfW
 pVttsaYAeC3Dlr81kxVSsq5nHQv+cjNHegcoT51kIPNrQN+D57DgM7Fa2AYrkmthne4bv5SEX5m
 F1ASkV7dFkPoHa0fuA7ovowsEt3IuTNKjA4t0OMr2t0vHuwMyB1HM/QMayu4HO45TCXk2HMf95c
 2n14bLrdvzTz8bRpPpPmDrX3RER+z+r7AEltjxwv9K9KwgXLuXDuSqaOkAUl+ZGwtKAZNcvSCrv
 zPP6yTKO2UhzXfJ2rVbL4AS/p6iTGEReS/BlO3/zV8cAQowV+jeedkNvQfNJsG2bYrNShCOlvcj
 zeLA0n3180QAaCE/6ZhouSsRBRfUMhov+BCLPeM0iCpIAi646bkVcPrjRy3gM0NgZlyf/UmEB6C
 FvhGnQUmNMbeT2Vh6k/WeouQU8Vp4OZGoUepBXzTz+TAt3qylZL1b13PQWOqSi/Fq9PYiyK5XkP
 FdWgnEr87uyx6NsVuaA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEyNiBTYWx0ZWRfXyFOyET6PBXVs
 vudyeRzX0aZwpfuoUe+JdQ/oI2HsAJ+1FoSeCx6Pj7sncZIMcKjFBA6DkQbXCuNlNFu0pUAruXh
 sWBbq7NcohEFvEg6lKzZTlIQTSaS0VU=
X-Proofpoint-GUID: oPmAeM_OySnIdwIXoa-J_AyNooDkScMs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060126
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tbP/k6WchHnH+sdK7hagnQaQRMQmXXKRkcaAVCnJbXQ=; b=X9c0uZxQw26FaGBJ
 IyNfgBcjjCI7uc4MP3o1uUOFROgmU8kF+MetmrPM7AXCZcvPXgKL230zdbqGNUei
 BJLtAKCsjbqSOLIN6+SNOJr7X+hflDdB2wfJ7SZBgv+LgS0HE6EPIOdJke84855Z
 7kg3sLG5rbwrn1mxDiujKCFC6JmwUKwlGM7yaKXkf6V4dTu22d86hFexrbJ1DXLj
 ilMwfiVQR/L8i3DGXcNu2ddFMc7aSlnjbw6pcQiOtMHaDpFSJZmpZhXiBA8kJvQ6
 VQG1KvcVcXguWHwsaGl821KHsjUs8168wng3itaAkNq9vqlL7ufUrfcT9qU+BrpO
 i+ys+A==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786032780; x=1786637580;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tbP/k6WchHnH+sdK7hagnQaQRMQmXXKRkcaAVCnJbXQ=;
 b=PwJeFdQpsiqJ8nOOb1qzmeRGhMh+6P1ETO1X0Bf8ylmUkn8BgXsy4O2hNJwcZRny6E
 TMv/HTDBgy2TzX8/Eg2qlDur4UJljuHMTKCjmr0Z8xREYq5vew0XTJhnAykVRWfFoF7Y
 J1kzn34uwGP0fCG50LOTSf7xc/fzVx739cFZQLyOmrafqfAy5JPDqFAZuGDMACnFtt3E
 BGyGmbPpb7/8a2Dimwn2rVTnK07x/AMxwjt53/BMaKwwQ3cWaegy2KcNpMHa/HJzwphk
 qqozIm8YxUK0e0uFWAPNUQah5OEDVN+TsHneFLb9IMidWkhBN1lmi/V+sZkOp41Xs4i2
 NFJA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=X9c0uZxQ; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=PwJeFdQp
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

