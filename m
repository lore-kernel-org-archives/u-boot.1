Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADEE7F31E3D
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 15:39:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EB578416F;
	Thu,  9 Apr 2026 17:38:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="T+0txW5h";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LnW/8QXc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27DE984099; Thu,  9 Apr 2026 16:44:19 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 051E583CF5
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 16:44:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639CxBKt1433128
 for <u-boot@lists.denx.de>; Thu, 9 Apr 2026 14:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vxKSSloytRHV7C/AT1MD8ovCiH45weFxdVSC8nmfU4k=; b=T+0txW5hZnHCi/yW
 D6utDf9GL8/aL6LwyhTjwDk2ghTUwcSj/+XDtFbHQSN/n9TeK8dUkFDR9Cyzo/Jj
 iROeKrCNmiL5AEEwuetVBJzjMaO0y3yjjQnILbyiRUGwdUiJnlMxOPiHGDVepsf/
 XoJXma8Le/Qt3BFL8QeDmEutja8xhb0/+/mxEgC/aKE4tlLzEMY6flDVdTAvXd8A
 7BoIUeUvp6xCgOq1wzvnNh8ivycW2di59BGdz6YXHdTbGk2sCQ00ybAJIqT0p5/5
 ZbarrkiYZ9Z8ayFmhP7ymH53ymltaBeUzEMRvuSsvuOEEWMbic0m53Fz4JzWAtna
 xvkAfw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deckf8e2x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 14:44:15 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b24cd2e2b3so12500435ad.0
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 07:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775745854; x=1776350654; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vxKSSloytRHV7C/AT1MD8ovCiH45weFxdVSC8nmfU4k=;
 b=LnW/8QXcrxTvAwxu5E2+aiTgJC4v8Lrg+TYPQXjYY4T8LMsU5SA52F3IZY5OU/xiNA
 svn7vixlZE8NyM/DAjFt2inz3Cfhj/9q7asXbah/J4+64Orq9X71pYRkjuGmRbG7ZzPV
 Uf4duJ2dsbcvIqHH+EFRuQwk+KkahIyg6QP+LbTm9uLDLAXPpRZ9lqoDI7/XaCucNbay
 ypKuoccacsHgAR0zvBO8PthJtJcLDQWvR5azp3kBzZ5yGOnweKd8+Aw2ULu+sUN6rbrU
 FPRlmKErjOKbcjQKRGAB656Cj5aaVGeN/ZED423M7JOgNui15V224BIWhqMyFmJ/5EE2
 I/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775745854; x=1776350654;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vxKSSloytRHV7C/AT1MD8ovCiH45weFxdVSC8nmfU4k=;
 b=Z/C+jpIKkpDvVQq35vCZ5Tq+5M3ZmBPmANuoN+T1kzipLpeAWv3wmE1NHDQ4nCZmOx
 5RYN6mSECtWtFON/JIP6Tpt0jkLQIskmBMGBXh9zFhkm+4ldxMBD4Lu+DLr/M/b1BUBa
 jHmfaqTbYi71X4jM92tGqVKYuCPytRqmDYRhcGE3ilfnue+7UIl7S1goNWYqiGQsRzi4
 7TUHZLLguwI0oT9CtV8tj5GkIryAu3vWUL53uj/Qd30EApbkiFScm8PHIU4qQ0xqBOwl
 t7JhPBzwvxWqxaBHKbtN32vQdkvgDrE4RV4dQrNqQtoebHOSn1uO+f5TvLRnpA+14EK3
 ftgg==
X-Gm-Message-State: AOJu0Yyn907aGeXaN4L4jqOxjUdZ0a9SqVU7rNz+yTRYUWoMROfPl2H7
 KnKf9nJqAmGK7j4RyIm7bff+mUAPxZwrwNf8KIoFD1ro837HRcVKwWln2jIUVwZSTiCzPMwG3AN
 N8GnnXZ62utcKCAobJsKB8OFrKPlkdOyeMd9OD+2V4bNgbp58BOxwvOfs
X-Gm-Gg: AeBDies1uKkob7ZYYUBDBTrkny4gmlLugS3yv4pa6ElkRy4BeC3hsJt7OmuNeQo3vpJ
 PZ2c1j430SmuGcpDGwUUIuqD7bdO3DKMDdeTdFrG2oFAGABf2q6Nw/Tug9WttcggpBAga3Ub7qG
 MhY8u08fa+iJ9nbA1pGpaarAhiW1va7jppNE4JkABl7gKe9tugIP6DmDM9tagdPX8QRHwNUWClY
 aE3MvkEq1eKMUvDG/FCFBvpWAwfE2El4lCB8MaNaj3GT+cZHPiqJboqZ4vR7p+1YnKs7vAlp/Rs
 wvtKK6iQIrrch1/mtiL+p+cfRbSjXzFn7rZSufr/HtDEy+IBDzg+xK2/geo1cG0AIhsyxDEkJkS
 yf8rgj35uVfbLpbpRC68AszM5t5fQopQmUndc6qxZ5LANzYGc4sAHJ/BqxdDvNrbNHx0ect2Iq8
 ju7LIhEVGi7z63abD2YXOtsKk9tgW1Lxs1hu9clgxbFV1c6X5y0w==
X-Received: by 2002:a17:902:ccc9:b0:2ab:230d:2d96 with SMTP id
 d9443c01a7336-2b28173ee68mr271493175ad.11.1775745854337; 
 Thu, 09 Apr 2026 07:44:14 -0700 (PDT)
X-Received: by 2002:a17:902:ccc9:b0:2ab:230d:2d96 with SMTP id
 d9443c01a7336-2b28173ee68mr271492535ad.11.1775745853693; 
 Thu, 09 Apr 2026 07:44:13 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749cbd85sm235083535ad.74.2026.04.09.07.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 07:44:13 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Thu, 09 Apr 2026 20:13:33 +0530
Subject: [PATCH 3/4] drivers: phy: qcom: Add UFS PHY support for SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-spl_ufs_only-v1-3-f7e0e243d805@oss.qualcomm.com>
References: <20260409-spl_ufs_only-v1-0-f7e0e243d805@oss.qualcomm.com>
In-Reply-To: <20260409-spl_ufs_only-v1-0-f7e0e243d805@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Javier Tia <javier.tia@linaro.org>, Rasmus Villemoes <ravi@prevas.dk>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>,
 Dhruva Gole <d-gole@ti.com>, Richard Genoud <richard.genoud@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <me@ziyao.cc>,
 Peter Korsgaard <peter@korsgaard.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775745813; l=1664;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=ILaJby8Rs1A/uUsUiqVVNvKKrwB4jnchaqaExxsKBSo=;
 b=NSb8EneSPKR3Jw/oCW86+xa0eU37kaewh/TiwdrY5lpgNtvBoGml+NarUi7UDXcGGKVSmoRGu
 PNQgP8CJPghBYPRL2B2+FZ0XnF3jI0l1VIVrUprzUvSAv2hCYZPEF0b
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=S/fpBosP c=1 sm=1 tr=0 ts=69d7bb3f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=YibrmUducG62tEOoQfcA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDEzNCBTYWx0ZWRfX/udZ8qfmaH8A
 xyvGlmGHGDHUWl+wH69zZxC4T2vxyhbcPqSBtPbETCFh2SjfHYzTORCh08XSO6ilPxK21wB8mCA
 1jGelY+Wa+Nmw0rrI+NQ9P/p1h3zgFTw3/Z30nqqZrqmyjT3xIE6PFrqNeYNMlORGwg8VF4uH61
 zUH2wKknS1FVWqiG/DHvECaxU9ZYiU8MY08UWXTbuDpHfKTzHwp9poAyuDMom7D88s7R/MsLlO4
 JRvpEK7xONBiHCsrudr7NjW+yzBWpItBWJTvuMolSkFwcKyUuza3T4BtqPgC1hQnrpFbl8RgldV
 31V8tQ9z8ZkJmLuyNWvWWoW6e8AL59tJi1dOHmcYDdUMAAmUCSHcxay7LXjRCuD57i2cRhQdxE/
 OK84Qp1ZWpB8uuGiHgrfgQOgR+GoL3hLb3f4vP7yj2BZdqt9pJZ4C2T7brag8UkRcHSLjL9GlIU
 CMuDojPqHeh0I62R+qQ==
X-Proofpoint-ORIG-GUID: 18UuyErfTyTXbcsIBuvJy2lGRkSUypNN
X-Proofpoint-GUID: 18UuyErfTyTXbcsIBuvJy2lGRkSUypNN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090134
X-Mailman-Approved-At: Thu, 09 Apr 2026 17:38:43 +0200
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

Enable Qualcomm QMP UFS PHY driver for SPL. This is required for
UFS boot support in SPL on Qualcomm platforms.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/phy/qcom/Kconfig  | 7 +++++++
 drivers/phy/qcom/Makefile | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/qcom/Kconfig b/drivers/phy/qcom/Kconfig
index 0dd69f7ffd0..e5541fd3edc 100644
--- a/drivers/phy/qcom/Kconfig
+++ b/drivers/phy/qcom/Kconfig
@@ -24,6 +24,13 @@ config PHY_QCOM_QMP_UFS
 	help
 	  Enable this to support the UFS QMP PHY on various Qualcomm chipsets.
 
+config SPL_PHY_QCOM_QMP_UFS
+	bool "Qualcomm QMP UFS PHY driver in SPL"
+	depends on SPL_PHY && ARCH_SNAPDRAGON
+	help
+	  Enable this to support the UFS QMP PHY in SPL on various Qualcomm chipsets.
+	  This is required for UFS boot support in SPL.
+
 config PHY_QCOM_QUSB2
 	tristate "Qualcomm USB QUSB2 PHY driver"
 	depends on PHY && ARCH_SNAPDRAGON
diff --git a/drivers/phy/qcom/Makefile b/drivers/phy/qcom/Makefile
index 1c4e7d8d391..a91c5377ac4 100644
--- a/drivers/phy/qcom/Makefile
+++ b/drivers/phy/qcom/Makefile
@@ -1,7 +1,7 @@
 obj-$(CONFIG_PHY_QCOM_IPQ4019_USB) += phy-qcom-ipq4019-usb.o
 obj-$(CONFIG_MSM8916_USB_PHY) += msm8916-usbh-phy.o
 obj-$(CONFIG_PHY_QCOM_QMP_PCIE) += phy-qcom-qmp-pcie.o
-obj-$(CONFIG_PHY_QCOM_QMP_UFS) += phy-qcom-qmp-ufs.o
+obj-$(CONFIG_$(PHASE_)PHY_QCOM_QMP_UFS) += phy-qcom-qmp-ufs.o
 obj-$(CONFIG_PHY_QCOM_QUSB2) += phy-qcom-qusb2.o
 obj-$(CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2) += phy-qcom-snps-femto-v2.o
 obj-$(CONFIG_PHY_QCOM_SNPS_EUSB2) += phy-qcom-snps-eusb2.o

-- 
2.34.1

