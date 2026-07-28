Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6544C54F54
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 19:15:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F69740A91;
	Tue, 28 Jul 2026 19:15:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BY_4Q-fJa_nK; Tue, 28 Jul 2026 19:15:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EEA8940A41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785266100;
	bh=4HqjTZT1wSmtTaSUZuF8OB2+sVEO/d/H9l5PZxRlhj8=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=M7BOmBvk0rijBGMT06DtoLX4naqDc+mxmXL4tSn9rgWLx7EAjjpR5lzPKLjrypr7e
	 N14ayC47FMJ+DhPytVhVsaYuPtS74x2b/o4PNDdRHNdi7ai8y57UPy6xnJx+fcFnQO
	 LDHCfzedIXhT4iLUIOGzFns3K07qD4gQHiSpN3n2eeCcdrzeyKxGpEGP/C9CVBuYm6
	 gzwD9qe2k/2AEIo+cWpuIfFJJLiehzET5VOi96H4sNI+UMLYBiOGxIT/XU32WX4OSi
	 dj3ngfp5M/gVXAwIg9+D1qoGz/QXSp5tw+M6+rIpNMY1eUQBpjaZFD+h4loFPGyXiy
	 rUo0HIIHX7C1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EEA8940A41;
	Tue, 28 Jul 2026 19:14:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 575434BF
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 19:14:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3D5BD40364
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 19:14:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6Iz_Y15VWXlp for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 19:14:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org DF58F40373
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DF58F40373
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DF58F40373
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 19:14:56 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56E8C8494B; Tue, 28 Jul 2026 21:14:55 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3584F8404D
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 21:14:53 +0200 (CEST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66SIC0BB3463922
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 19:14:51 GMT
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpw731xjp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 19:14:51 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cfca8558d2so2529765ad.2
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 12:14:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785266090; x=1785870890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4HqjTZT1wSmtTaSUZuF8OB2+sVEO/d/H9l5PZxRlhj8=;
 b=R+FvYVolx5u+B/hkia2Ez9AWy7NvH+FOe1uDyfQOhj6q3uC+ti4NmsR0BY1aZmeUCe
 g0xcLFd/cJdyMAnfTzf25JJ3+MlnUA6fYT384TwRdqKWKZlhuH8lSnE7tPDiKU8g/6Yi
 tKkLaItfj3HwRSVYyTFvV/UqpedGuZGinCm0ye7qMgbBPtFpcYBlgdwRoNYVReeOiC0/
 xCw70rgg9c94W6X46EspukvGcXfGMjz65wFzoEfAbXmh6kcR47bOGnb3hyUuxFzUW2Lx
 y3t3tAxpokyFMrKHHDb/iswB2hWO1+u4C0QTRCGgEvshjBJtnC1NxMXqz1GfH0sY4F7V
 VZ6w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpbXDvScT11EEHRyj2Sa0zUwlnIAnnCxBoq8ZFj/1gjW3FkdtqqYKAChnGfpCGufr6pJnUXL5c=@lists.denx.de
X-Gm-Message-State: AOJu0YxPCO3H7B2Fy1W1SRE2hq9vq8YILR8+JOEFWVdvL5aaE7eBYVFS
 0SchJGtXoAeWzsk7eMsL43B4rvGUIn/gPF0sUj7lEoccbFiPlnG2U1Iek/WFzRrOnxE7enHxS7h
 su0/riqLHS/HrL8il2JlKH9ZLvez2yaenV4v04NmXmQPNYjlfIwAjBuPO
X-Gm-Gg: AR+sD11jhrwjFtrsAY5yMLCoFjtRXTzdc8PaFW2z307sqxj1a9pcEG7j+XB2OgjaSUc
 mgnXlivHWjw5+dAweWxfDT381wpokiHn+XtnaR+LAQvNEYkcTjrQfezCNrWg3c99iQBHRprHQj0
 mkKzBf8fqfF1T/wItIPZdcOJ3jTcItse6nwCJkqi12PNjQ00bE0zWQE0yIl13FDcFd6SlL/JsjF
 pmH+fS5sngkfY7TPqTysDQKI7iyeavcBXaRngc7N5d3UU7P2DHWqGMilCW9PFZmQ6EnRYLdN/OX
 i/wkSYIjnngqsrQDaC9ni77fP0zKrN5m6lcqJFAipmFZPrHxN6jH8mgYMIiE/lhyibGpDjVOaqp
 QrzT3plFo/DUh8W23Ol8z8DABVQG4S40dMMqPGZkX/IXxloJVXrlDU7itTFPP8p1IlPWxkWuE8d
 lLZegN2YMp4vf0Kl62GTY=
X-Received: by 2002:a17:903:1904:b0:2cf:b23a:3e39 with SMTP id
 d9443c01a7336-2d015d8f422mr42851345ad.43.1785266090468; 
 Tue, 28 Jul 2026 12:14:50 -0700 (PDT)
X-Received: by 2002:a17:903:1904:b0:2cf:b23a:3e39 with SMTP id
 d9443c01a7336-2d015d8f422mr42851035ad.43.1785266090015; 
 Tue, 28 Jul 2026 12:14:50 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504d373c3sm1261294eec.23.2026.07.28.12.14.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 12:14:49 -0700 (PDT)
To: trini@konsulko.com, aswin.murugan@oss.qualcomm.com,
 casey.connolly@linaro.org, quic_varada@quicinc.com,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 balaji.selvanathan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 sjg@chromium.org, linux@smankusors.com, ilias.apalodimas@linaro.org,
 nathbappai@gmail.com, luca.weiss@fairphone.com, jbx6244@gmail.com,
 peng.fan@nxp.com, ycliang@andestech.com, mateuslima.ti@gmail.com,
 jamie.gibbons@microchip.com, quentin.schulz@cherry.de,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v5 5/5] arm: dts: Enable qcom, hwinfo on qcs9100-ride-r3,
 qcs615-ride and qcs6490-rb3gen2
Date: Wed, 29 Jul 2026 00:44:01 +0530
Message-Id: <20260728191401.849143-6-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260728191401.849143-1-aswin.murugan@oss.qualcomm.com>
References: <20260728191401.849143-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE2NiBTYWx0ZWRfXzqIbdqBcbUcC
 U64nhpaSKvy/bh5yEJR+z0dxchvwtNraqji7Lm5FeE2skt9dJxncUkQEBqU4+OiztAOVlHlA6ji
 Rz8Ue7Y+nK3Lf9VtGVuYwuFpODwIvTw=
X-Proofpoint-GUID: sKs-ZyWpvvebZbKblBqd7_L_LnaIOgd8
X-Proofpoint-ORIG-GUID: sKs-ZyWpvvebZbKblBqd7_L_LnaIOgd8
X-Authority-Analysis: v=2.4 cv=NobhtcdJ c=1 sm=1 tr=0 ts=6a68ffab cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=WA5CXkXAtKHkgwRa1TkA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE2NiBTYWx0ZWRfXz2K4TDikW1Tw
 PrD8de/kCoJADKoU3r56VjiDNEpMMMBg2LGJmRZzhkx2Yk16GcmZgyzhBgfFk4u/UCUdYj+2E+C
 nqBuUtSMfNmCZAeHugyYleCvy9nasPu0Pth0bmONNDiHStEIvDELx4rPlLsPMg5z9aRgNv4+m7p
 Q0XdkP6X0X9z/ktpIeM7KvRHItCzgB+IEYOniYRonwcjvqIDvXfKFNOERttJk3qq1S17uUN2Ryn
 1rEeyRvVypA6oUV/EByYV5fsIWFo3F2KjLSVXAxgSAmoClYOLDzd3Q/riGuEuERjXEPi9eyQMmE
 aWDMmrlmYCjmJBUILdWPAKGvgJaAOEG4g7Jygz+m3Xxiu7/Yrw06wlPmf8Mvjj2osU5fFS4TjAe
 CSopw4UGt15GbhYtig1U8bb5VwZapLXUI8dnvS05RwFbKw4NvsBptHueeqVw8V4MNSG+Cq5YR+Y
 XAv0OyGILSVr+F7h8Ew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_05,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280166
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=4HqjTZT1wSm
 tTaSUZuF8OB2+sVEO/d/H9l5PZxRlhj8=; b=mNlHOuBXsrysa+OSa+6HYVtTnBP
 8lcoYxWEiq7Lo5GzyuouQSmMsBzuKDP+y/gPyEiwNTZD5+0v+inl5reHJivoJhYG
 EC0ooLnFDUngXnvBh5xm0EzryUQ3JhNgcXQd5fMfDTsxHXqpchpIN2yugtiEJugX
 yENfKRUOTD7DlQspxBz2Tl2e0hwP6Vi1VIjRU94cJPpFXqrXqL0TKcGOzyCpDZPF
 nd5w9rv2iScxK2Sj1+pSIr3bV0JECKOjMjOrym8mTKEdZ6wnEKW6Uo5Xap1vAt6B
 U7052qd2Yk4BMOaxrC2km1wCNIOLKT6xDP/CE1S8PbKoF44vrw/0j5CT4EA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785266090; x=1785870890; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4HqjTZT1wSmtTaSUZuF8OB2+sVEO/d/H9l5PZxRlhj8=;
 b=MD1Jw6IEoeMgD2JUVvS+gJ4eiUAn9RuWIH2900nd63RuU4Cs39BZ+Fz8Y/IEq84QGA
 HT/XEnBiJ2G87YPcu285Xw7WtDW+s+4jDjJTYTlSUV1A6xYJpsHO0PZhsIHpWs4taNqP
 4USzzCX9v+mebmvs0aWLx0jD2Xx8c4r4cD6uatu6VUelhNIQMk+2newDxOFJpEn3ZZ+/
 T7wWZjGLxAebtgAKaUeJfRfUsH+77D7vbu7mkK4w+g4A8bFEUvQ+GgzBmXphLik83Jju
 sc9YEquy8b+4QRXIaMIc1rVquJS3LFRFDIS/HsOX74KH5XCEgQS+wsWLtdxciK/g4SO1
 dTGA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org; spf=fail
 smtp.mailfrom=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=mNlHOuBX; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=MD1Jw6IE
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=aswin.murugan@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mNlHOuBX";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="MD1Jw6IE"; 
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
From: Aswin Murugan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add the "qcom,hwinfo" DT node with the appropriate IMEM boot-cookie
and TCSR HW-version offsets for each board, enabling FIT multi-DTB
selection (CONFIG_QCOM_FIT_MULTIDTB) to detect hardware parameters
at boot time.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 arch/arm/dts/qcs615-ride-u-boot.dtsi     | 10 ++++++++++
 arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi | 10 ++++++++++
 arch/arm/dts/qcs9100-ride-r3-u-boot.dtsi | 10 ++++++++++
 3 files changed, 30 insertions(+)

diff --git a/arch/arm/dts/qcs615-ride-u-boot.dtsi b/arch/arm/dts/qcs615-ride-u-boot.dtsi
index 68fffc70fcb..8400b786f4d 100644
--- a/arch/arm/dts/qcs615-ride-u-boot.dtsi
+++ b/arch/arm/dts/qcs615-ride-u-boot.dtsi
@@ -11,4 +11,14 @@
 		      <0x0 0xc0000000 0x0 0xc0000000>,
 		      <0x1 0x80000000 0x1 0x00000000>;
 	};
+
+	qcom_hwinfo: qcom-hwinfo {
+		compatible = "qcom,hwinfo";
+
+		imem = <&{/soc@0/sram@14680000}>;
+		imem-boot-cookie-offset = <0x2a000>;
+
+		tcsr = <&tcsr>;
+		tcsr-hw-version-offset = <0x8000>;
+	};
 };
diff --git a/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi b/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
index c3ec4a317f7..ffcc2b3d47f 100644
--- a/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
+++ b/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
@@ -15,6 +15,16 @@
 		      <0 0xC3400000 0 0x3CC00000>,
 		      <1 0x00000000 1 0x00000000>;
 	};
+
+	qcom_hwinfo: qcom-hwinfo {
+		compatible = "qcom,hwinfo";
+
+		imem = <&{/soc@0/sram@146a5000}>;
+		imem-boot-cookie-offset = <0x5000>;
+
+		tcsr = <&tcsr_2>;
+		tcsr-hw-version-offset = <0x8000>;
+	};
 };
 
 // RAM Entry 0 : Base 0x0080000000  Size 0x003A800000
diff --git a/arch/arm/dts/qcs9100-ride-r3-u-boot.dtsi b/arch/arm/dts/qcs9100-ride-r3-u-boot.dtsi
index 5905dfad18f..ab10ec37056 100644
--- a/arch/arm/dts/qcs9100-ride-r3-u-boot.dtsi
+++ b/arch/arm/dts/qcs9100-ride-r3-u-boot.dtsi
@@ -17,4 +17,14 @@
 		      <0x0 0xd3500000 0x0 0x07c00000>,
 		      <0x0 0xdb300000 0x0 0x24d00000>;
 	};
+
+	qcom_hwinfo: qcom-hwinfo {
+		compatible = "qcom,hwinfo";
+
+		imem = <&sram>;
+		imem-boot-cookie-offset = <0x0>;
+
+		tcsr = <&tcsr>;
+		tcsr-hw-version-offset = <0x8000>;
+	};
 };
-- 
2.34.1

