Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED3FC5DF82
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 09:39:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C5EA780C5C;
	Thu, 20 Aug 2026 09:39:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YBVeIBiXRWzU; Thu, 20 Aug 2026 09:39:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787218798;
	bh=0kLTshydcEGy9c04LWSpB3cpzxqM8CYpsij2+gbfhx8=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=P8jsvyCwzafn2Yi6520LbsG50k3iLdALkpUOL0QMKONSPclHt7aELVzEsrXO3hej1
	 ajLDvMX6Qwh/WNowghXA7UrFdPmo8H7wOabkHR7Q50G5EwJCaPiVMGdE9yR0TeA4s7
	 XAN9hgp2BWqOeBb1bztua9Lmukcsmj2A5KgdfhUqJiiwreQDnRrM2lQWZhcp73fUDm
	 BFrEitxU1sJKNqj1rzC3bMO9dnWBMpa8JBkaX2wo8GzornZYBwwRud0Gs9jY4M4+6J
	 Df5f2TuLMJsPS4hngFzbCQflNychb3/urib2kcJIXeOJQo8CJkrWl1iX/pvR/O+MUw
	 0L8Q6ml9h/SsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C4E6E80C49;
	Thu, 20 Aug 2026 09:39:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 860D429D
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:39:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8370060656
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:39:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aofkfyGe6agI for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 09:39:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=K2XtY3uR; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=WwdEkOJr
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5A3A660619
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:39:54 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67K6VZVJ1777702
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:39:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=0kLTshydcEGy9c04LWSpB3
 cpzxqM8CYpsij2+gbfhx8=; b=K2XtY3uR+M8c0Bo13EeVB8nQPMIBuiZ2aN18z3
 6XVmi/9vhzisBS59pdcGYtd+kZEEK3lOSSOhqwU8nNJiO/Czdt8x09vF8yClxIA6
 n9jpGvJra7gw/8un+Jtox8Gpr58ZS6/zte3zKPKiCvGBnTLNf/Z7HIN1KxjOAdoN
 DKSZXfDrmoq8z+2KzZVJ3vfxO7t0a9IiaugByttxGj/FLZ9ajl8/bCKLB3EVZnNU
 mbokcBxFXALPFYQgNJ+UEvbSdW4QDuId2bllGQ+BfHQaYPwtmGhxGSwLjxK5f7IK
 Sr46XbFsVb/yGSBYOz/mwFOkuhP2lG5KoUeOonG1KuTsbQOg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5es3m5ja-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:39:53 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cbb92868263so1358470a12.2
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 02:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787218793; x=1787823593;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0kLTshydcEGy9c04LWSpB3cpzxqM8CYpsij2+gbfhx8=;
 b=WwdEkOJrQ+oOBxL0coJ0eIT/kB/eczZEAVLYBT48vt59SlLcDkbxclPzhXc1l7UHxV
 Ful1PHwZ3pQruPuFglq4yDdhhDQRp1ZT3GyXAvokeXpLoXVdJxqWBehZ+WeyXTcELZ15
 eE81KYfWS1uwwOfuIL1kBsoGWatpuZtXVqMEwsINoAtQhhjiDeTzYPhLZordGsgITi5s
 A2InWG4FwA4SHueXCWrwoEnMYCGsHQVo6od4N7H6yQxCywtgDbphD+V0MYrIh9F/OGiP
 fk5ZVffOF9ON22oaSnFBzfC1GXRbRcEVD0v3LpxvdVshQn1H2u8UYwWStwqzu8NOLhu2
 5UCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787218793; x=1787823593;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0kLTshydcEGy9c04LWSpB3cpzxqM8CYpsij2+gbfhx8=;
 b=sFLBMcODqrG4oYWOPzvP99tJiGGJ+Z4uG5m/hxj8Q6pWMH4toVNC9IJgVQYPTBtg6F
 zhsBEMNmh5ppMIdVekImHLnTmxGuCWQUre5ig5Es+slxwz9+ecy/FgpueuDMtMD4AwQq
 fFvo52Frnu9HOvoPJCtQxaZ9tgT8rwlvZoRigrjxOtS+YAcEw3cENf7DH07KK8iLTdNX
 B9rGumtbHFfqfLb9Pry7EMU607MumkV6ghlOCS7ZRA9rX7JLr0YqybU1l4TKn0lfUlhs
 y1zvSKpmojRVFlmfCMrOERsaxP+F/bIU+pXFpacjl+japeKcD+07iexwR1aRKB0dKE+g
 5Srg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpRwAWKklOvFS+xgSmkGOZLN5BwxrzjgKJEn1v/REDixQDcapDqNmnf5cBFVRFpK/YYIzJ0/14=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lfJOLsFJbcuDQQo2g7ay08I/g5ADQyCoc0do1BvguTz5uNIGrD
 rT7Uldf1ZtT1eWUK0BN/KHmd40aVg/ITU1q4c+Plv++c9Hv8VKbgvJoftDCqCk0rgvzE0nCZF1Y
 d6ZecP3N4KQthvPduXd+3TkgxVQVmvxPyHgGWV9EyYUab3nQ86AFnIXT/ni/5WeX/9TqYQaY=
X-Gm-Gg: AR+sD13Jw2JRd8JJre66LDbCrf4l5E1A0Vxi1ud+0wTajRMlvVWjPz783sNq0OOVGyR
 0ChrZMSh90lSTcMy4BqnOT3/yYV8wgUAPatoF1ik0AVR05bp4ucBmrq4l8ncLnRpa5J1hdGYSzV
 6c7mShz/kNYkXD22T7dH8mBRakeMGbMo6D+WbI97u3VvwE6pA8ylD1Q1Gq5YPMshNSpFrOSG8WT
 hb2z29vg/P3xjNZ6Gv7YrerqFhttyCmTJt4T9F3txyY84O6Eu7Ik7Yom48juFnKIbKae6EIX1qL
 uf5PH/YwBNHS99433fdTaiaHcD6oI1frGzsTHO83olK8nu1RV+FkBRcQz+IsGSqavVuXF1y+0Bt
 phEADciKio8TgftG7FUWbMb//YuB8tiIa5Rw4y1G95NesVT8DI7f+hQHzCNsHgo1A5dr1ntVdEi
 Yd2iY2JMQIEApOIbU3Gq+CP5z0aO8v
X-Received: by 2002:a17:903:19f0:b0:2ca:1479:d9dc with SMTP id
 d9443c01a7336-2d601ea515fmr219444345ad.12.1787218792621; 
 Thu, 20 Aug 2026 02:39:52 -0700 (PDT)
X-Received: by 2002:a17:903:19f0:b0:2ca:1479:d9dc with SMTP id
 d9443c01a7336-2d601ea515fmr219443605ad.12.1787218792134; 
 Thu, 20 Aug 2026 02:39:52 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bf1a1de1sm16140073eec.31.2026.08.20.02.39.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 02:39:51 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 15:09:46 +0530
Subject: [PATCH] clk: qcom: sc7280: enable shared RPMH clock driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-clk-qcom-sc7280-rpmh-v1-1-18100caea7f9@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAGHLhmoC/x3MSwqAMAwA0atI1gZiBC1eRVxIGjX4b0EE8e4Wl
 28x80DUYBqhyR4Ielm0fUso8gxk6rdR0XwyMHFFjgllmfGUfcUoNTvCcKwTivjeceWJyhpSegQ
 d7P63bfe+H2ttVhpmAAAA
X-Change-ID: 20260820-clk-qcom-sc7280-rpmh-ccda826d0037
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787218788; l=3298;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=EyOT08Sj2k83jXTrqBblRL8ZBt0hw/jcirzrukOZ9cc=;
 b=68SBHsgzd8Nt6cORO9/KICxkPo9qFoEtS2F7QeHQl/mfqVl+7ms1qMzl4fQpc9GgsrSusD5Pd
 qD+FSlJYt8CCo3tZPpktL0/6B0/ZKU16KoCSjWe1OUigTaB0lEgA3L2
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=UIrt2ify c=1 sm=1 tr=0 ts=6a86cb69 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=OyYgTzNitIwu50K9lJMA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA3MCBTYWx0ZWRfX32vir8SaFcbQ
 kIDiGUQGUIdf6pITvGSAXW8fJPHhO8FSE8TI3RRLNXPcb5uPo3BcfmToqWrn27P+a+4p+XYo3Dq
 dTdmFdDJ4nMBGg1CyNaIyye9jDElwNhLm2oVOZOdTbyxzUTl08sUPeBs7G6WSZK8oq8pD8slmYw
 iCHxLOBfyxJeHwnb3eiwwABJlsp3PsgW7aHLRVqnqgjtLkHAMIisUQHqWVNo5sQimLZurnQOuir
 jThLlYaJkWZVaqd3qt/QE0VkU55i+9NfkcuuIiTHIXfIFV7fATmbcDYCOVKAYnj45ai5SBb0mJq
 rfzTki7uFmHU3PQV0hzEC1dgMtanCDJLVsZt95ucAuQlYHPmY6fHYfYKe6dhG+jXA4VhVLFfswG
 TDoumIvF7y6xOPPicuDCe+sVP8Lcgd32GeYZeRV15jZs3QDCc1t/nfe7fJDIyNZp9nGyWV/GDRq
 A05jhlldVsFtJL7rWgQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA3MCBTYWx0ZWRfX/s1+SOmqZhQS
 MELxuosYuNWLHSUgZo9BKXiPbYQod0LWw/mIHIPlrnLYWoCw3Tv6qoFrpsmLrXojI+7WpDyI9Bf
 gpdX83Pjs1NJDc6pReOuI2XAz0DcXgk=
X-Proofpoint-ORIG-GUID: duVVy9aXtXbRZCiujMQ6XXOxBdBYP-uG
X-Proofpoint-GUID: duVVy9aXtXbRZCiujMQ6XXOxBdBYP-uG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200070
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

The shared RPMH clock driver now covers SM8550, SM8650 and SA8775P.
SC7280 exposes the same always-on RPMH clocks, so wire it up the same
way: register the "qcom,sc7280-rpmh-clk" compatible in the shared
driver, have CLK_QCOM_SC7280 select CLK_QCOM_RPMH, and drop the SC7280
entry from the clk-stub match table now that the real driver claims it.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
This depends on the shared RPMH clock driver introduced in
"clk: qcom: Add shared RPMH clock driver for SM8550/SM8650/SA8775P"
(Message-ID: 20260812-b4-monaco-v2-1-865d288c0be6@oss.qualcomm.com).
https://lore.kernel.org/u-boot/20260812-b4-monaco-v2-1-865d288c0be6@oss.qualcomm.com/
---
 drivers/clk/clk-stub.c        | 1 -
 drivers/clk/qcom/Kconfig      | 7 ++++---
 drivers/clk/qcom/clock-rpmh.c | 1 +
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
index 85e54841386..74825f87580 100644
--- a/drivers/clk/clk-stub.c
+++ b/drivers/clk/clk-stub.c
@@ -52,7 +52,6 @@ static const struct udevice_id stub_clk_ids[] = {
 	{ .compatible = "qcom,qcs615-rpmh-clk" },
 	{ .compatible = "qcom,rpmcc" },
 	{ .compatible = "qcom,sc7180-rpmh-clk" },
-	{ .compatible = "qcom,sc7280-rpmh-clk" },
 	{ .compatible = "qcom,sdm670-rpmh-clk" },
 	{ .compatible = "qcom,sdm845-rpmh-clk" },
 	{ .compatible = "qcom,sm6350-rpmh-clk" },
diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 8596b93d4c4..cc4053f4955 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -92,9 +92,9 @@ config CLK_QCOM_RPMH
 	depends on CLK
 	help
 	  Say Y here to enable support for the RPMh-managed clocks found on
-	  SoCs such as SM8550, SM8650 and SA8775P. These clocks are owned by
-	  the always-on subsystem; the driver only reports the fixed CXO rate
-	  (bi_tcxo_div2) and accepts no-op enable/set_rate requests.
+	  SoCs such as SC7280, SM8550, SM8650 and SA8775P. These clocks are
+	  owned by the always-on subsystem; the driver only reports the fixed
+	  CXO rate (bi_tcxo_div2) and accepts no-op enable/set_rate requests.
 
 config CLK_QCOM_SA8775P
 	bool "Qualcomm SA8775 GCC"
@@ -181,6 +181,7 @@ config CLK_QCOM_SM8650
 config CLK_QCOM_SC7280
 	bool "Qualcomm SC7280 GCC"
 	select CLK_QCOM
+	select CLK_QCOM_RPMH
 	help
 	  Say Y here to enable support for the Global Clock Controller
 	  on the Snapdragon SC7280 SoC. This driver supports the clocks
diff --git a/drivers/clk/qcom/clock-rpmh.c b/drivers/clk/qcom/clock-rpmh.c
index 69f2a751441..5d01b482fc3 100644
--- a/drivers/clk/qcom/clock-rpmh.c
+++ b/drivers/clk/qcom/clock-rpmh.c
@@ -47,6 +47,7 @@ static struct clk_ops qcom_rpmh_clk_ops = {
 
 static const struct udevice_id qcom_rpmh_clk_ids[] = {
 	{ .compatible = "qcom,sa8775p-rpmh-clk", .data = TCXO_DIV2_RATE },
+	{ .compatible = "qcom,sc7280-rpmh-clk", .data = TCXO_DIV2_RATE },
 	{ .compatible = "qcom,sm8550-rpmh-clk", .data = TCXO_DIV2_RATE },
 	{ .compatible = "qcom,sm8650-rpmh-clk", .data = TCXO_DIV2_RATE },
 	{ }

---
base-commit: 939ca75844af693dde313f279e3210f7c3beace7
change-id: 20260820-clk-qcom-sc7280-rpmh-ccda826d0037

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

