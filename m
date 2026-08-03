Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C18FC55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 15:59:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C38A260675;
	Mon,  3 Aug 2026 15:59:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nv7XT_8lE0H4; Mon,  3 Aug 2026 15:59:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F220A60625
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785772761;
	bh=VSnqj6TBb3fRydfEGm3isQgxi8NQKh4noba6DONmQec=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=WEe9rfTg4z0gCZ1I5Hyi9/Vgc8z60A7q+3qTEdzOp/VQkhq+tN+LUsBdmTx/9XjCL
	 SRS2fPcJqFaXVmqGTpBHFxlsnQNdNryAcNx2oN/lvTuV7Oqn9DSb7iWEwK4EC2YW7W
	 C5FzFCFr5ZMuPNgV/dcVUQ+9d1nN9avYGlSBQkMolEOg62aunKvHYRqFzgs4S51qtz
	 eRBqOMMosFgXh0MymC5jnkQADbTZFMTiIamV339Z7FC1Ps06eTRCltUdALZ3MwJT+Y
	 WolVwYECNTluuKvP0ULvDuVYjD+HzPBTk8yG9Aq53Igy4/kJFzeAgx1/gYDG6oo0Ag
	 WN9kx7CsLqvUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F220A60625;
	Mon,  3 Aug 2026 15:59:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5236F2AA
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:59:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3FCC74008D
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:59:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lj36dN-m0YA2 for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 15:59:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2E35240042
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2E35240042
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2E35240042
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 15:59:17 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 673EBu4b976864
 for <u-boot@lists.u-boot-project.org>; Mon, 3 Aug 2026 15:59:17 GMT
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftp16a98w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 15:59:17 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cb4bd11ddf8so4170325a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 08:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785772757; x=1786377557;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VSnqj6TBb3fRydfEGm3isQgxi8NQKh4noba6DONmQec=;
 b=mst1pqIRVZ+yczhA3QWvHPaR6r2ZDNwsc3aEakvbEJHfIubZMLg3c9PrGIoP+OXgrf
 QOF6pjej0mlpZqGjgR65asRThA1d/72h2TX8XMIkLN9icnbPhcsgchDVrhiTzcag/+zR
 vVUdthLTQknBrU+gdQaX20lA1iUpoK8WnKIZrXuPmSjx4TJfdefjwvhLuWdw/B1x2r//
 AVBDWMAGaZufyI6DgkdkLOWnkBGJilh31Q1dyK3G4VJjL+26LGqbF5sSgAanCLq0Dxx+
 flYvrvghpTdKoAHOU0IgrNz+jFBc5oLR4880oCZ/fpU55xxRZZRuv9Ij7iDJUaVzTCRX
 sulQ==
X-Gm-Message-State: AOJu0Yyy3ipix1ngkRMtllyM89cBZ2DSlsq3qT8tV7ZR5C4MMoHljFJK
 J1e7yXbR4ml1dcZTflgz4H0UxwgDzJKPLcHmjHLiv03uuEcM90ocb0cG76OCzkT1iWFLFD4lYCb
 cOmk7VM7sktqGyHROfkRyAm5MgefkZ0BWUMZKmVZsut6e7af9J07CEzj1X6JzENMyVLHiGHsqt5
 oIp/w=
X-Gm-Gg: AR+sD1179gKog3vin+LTHCasfrIiHj/WOiiGbqyIEAY/oEPmHo5kf5gU0xlz0axegVO
 hXajd6HKXNhwZl8ma9sLfu8G7+klRcU0jnRS51zbmmf9MFgrb8Dm40ezCTzrDef/SaPgVB2FQtp
 /CQsAOu9kByxu296nMR4bEBWsi7lV1VJHqe++mdhkxbps4ndSA+etxSrQMNEDPqvhIqFs5worjY
 rbilkc4kucBllt0+vi+4V7clbDuI6U+zPTKCucY/NSWNhCaX01q8QWqb/Pq6hkLICdu+sSWXTjG
 D0iW2AkDzZOOv/eK4LdhxVr4GyrKWxsu2jr8ASGB16kc5J87IVjkRgvGdEvzqzOn6uTlOL2HIi+
 3s57Evo1SnwS67q+6Rl/A9K/K+VmJ3pAKexzBS6r2bQjMOpac0LRDi6O9IYbT2C4d8z0l52/+1k
 BURoU2X/0fIQ0h/AWXh4dSGYtuiidO
X-Received: by 2002:a05:6a20:7286:b0:3c3:7df6:536e with SMTP id
 adf61e73a8af0-3c92a95b9f0mr11475036637.67.1785772756744; 
 Mon, 03 Aug 2026 08:59:16 -0700 (PDT)
X-Received: by 2002:a05:6a20:7286:b0:3c3:7df6:536e with SMTP id
 adf61e73a8af0-3c92a95b9f0mr11475015637.67.1785772756353; 
 Mon, 03 Aug 2026 08:59:16 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd9c1casm38955713eec.10.2026.08.03.08.59.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 08:59:16 -0700 (PDT)
Date: Mon, 03 Aug 2026 21:28:49 +0530
Subject: [PATCH v6 4/8] arm: snapdragon: Add CONFIG_QCOM_SNAGBOOT_MODE option
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-snagboot-v6-4-e8bf7a6fc0a4@oss.qualcomm.com>
References: <20260803-snagboot-v6-0-e8bf7a6fc0a4@oss.qualcomm.com>
In-Reply-To: <20260803-snagboot-v6-0-e8bf7a6fc0a4@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785772731; l=2045;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=QGi+Vu1LgJvQVFfHj3/Pqd8bdl6aU2WQsiC2oQGXszk=;
 b=ajBQmWSM7fqL9Od3nCyEfef8Bf8m5dRB4V53BW0haYjvdO8HdW0UZg8S74XCWQhjYuSNw5tU3
 z5BMipDpqehCW7PD7TQ6+g9y1ab7C/XGHDMvEgNc8Xcofi4RyIy1Zde
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MyBTYWx0ZWRfXxzU+TIQmdE7S
 s9dUrUaorSDHxXqrxU+zvXkNR/8DTljWy5OKxUdgsL2VuFvDYvbrYARZE9IhHuLHTbkYYySfBvG
 aK+bMLG1MtAvTxeQNn7xhQTM/WjLY0vWoT6s/QOqDtMckEyh5rMUpyzDh6bweRPwpUmP64P5Mdf
 O6wG9L/4pnvS33gUhZ84+VtE/oXZeo03mJfQP4akzdJQC8X5umQXzuXwFnNHzzoPkVtpGZfxD7k
 byk5MIsSsGzWHUi74hPBdo4IKQiEwerU5HiGYtjrD1GkmCSl3riyxz9efakr58dyIG7Tkkmog8V
 GdpR8AKpbh18p6JgoYvUgZmI/rA2YAWf/iD1US1DXuuD9esIpA57pApgjF3opySbqbL2mRZ7KAk
 /Qb+dFh6JfpUiSsp7z0YgeYVF3O+hqvafPyDDJ6HX1OrQaBUHvCB2Nzv0VZpT/1lYLNJaYveGOb
 KCT5/CWTl5kUtjzd2QQ==
X-Authority-Analysis: v=2.4 cv=Wpob99fv c=1 sm=1 tr=0 ts=6a70bad5 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=ZHSanarjU4c6-wJI9dcA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MyBTYWx0ZWRfXxJj+q11cW1QL
 OHVPdVVF8izTTNpi0orxMVb7oMXHAj7e9JyV4Hi4UCUzCVK4y9iLNZIcC59knlzI64Drw8s3FrB
 Ejny9hul2/RFwquijGoJy5P57t6p0As=
X-Proofpoint-ORIG-GUID: 38HZMPJ2yNa5SF70B4Jwp6FejC5tHG7U
X-Proofpoint-GUID: 38HZMPJ2yNa5SF70B4Jwp6FejC5tHG7U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030143
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VSnqj6TBb3fRydfEGm3isQgxi8NQKh4noba6DONmQec=; b=TY/M9rYIVqSyt+HQ
 0Ni+oeCiXLa8fT3ykKC1B3korJAEu0EJBsKrJ6i+IZpNnYg8vDFSDlNQ/j0nirte
 BpFETtliIw3/eT/dm1JYUajMtytqcsn2iKLGcN9j6oS56JGeBWcknLK4+Y7KKwSb
 8HpA/zsAX26/mO9iKBC6o0OCOoURUzVMuhwksDKdl9qj/JW5xKnQLyb1smEAeB3S
 Z/7HsUC/ZBbSvEBwyN52txSv/KdwXTKNwEIMVAzfOwRQoj9bAYhhOFTOHIO6D/+h
 /aGDLUv4PUqKNXR46w6GYtAh42Sgxf6bbZtDw9M9vZLmuVm6Jxkn66RHvZ2AOiWa
 W5lUeg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785772757; x=1786377557;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VSnqj6TBb3fRydfEGm3isQgxi8NQKh4noba6DONmQec=;
 b=ZxnEfFYit01F+oqAn6aFfz9eezAwijYZRS3k8rjx8bd2OCnq6nPPZM3qFOG9cxW69A
 QVGhH3kQ8JuYxFimLhjK//p+WTf9hjVg6sZAF44lqvKa6xjRxXUuUFus7f2LCEvXGKOP
 wc+/CtM+AmUKCsNXFzGVCmFGkz/MZkpBpjbCdCxxxSDa4gZmqcNHLnD+UgbB+iNtFz8j
 lQ57f4t6D81Y8pKw6RLntIvy+kdUzWlbYX4fpi5nyqz/8TLVuvADT++6iNnvHFxori4h
 c9Z60WqjtCqL6BDEo1E0KxvqmCkFkWjW1Yr4b3MXnzKQIdrQfDkQg/1itcnO60RngENa
 /p1w==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=TY/M9rYI; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ZxnEfFYi
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

Add CONFIG_QCOM_SNAGBOOT_MODE to enable snagboot mode on Qualcomm
platforms. This config automatically selects the required dependencies.
Express the platform-specific requirements and configs that must be
selected and disabled in snagboot mode.

Add QCOM_BOOT0_SNAGBOOT_MODE as a hidden boot0.h config, selected
automatically by QCOM_SNAGBOOT_MODE. This boot0.h config is for
disabling MMU at the start of U-Boot execution.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v5:
- Made QCOM_BOOT0_SNAGBOOT_MODE dependent on QCOM_SNAGBOOT_MODE so
  it is not exposed to users
- Add dependencies for QCOM_SNAGBOOT_MODE explicitly as "depends"

Changes in v4:
- Renamed QCOM_SNAGBOOT_SUPPORT to QCOM_SNAGBOOT_MODE
- Added QCOM_BOOT0_SNAGBOOT_MODE for boot0.h which gets selected by
  QCOM_SNAGBOOT_MODE
- Document the platform-specific requirements and configs that must be
  disabled in snagboot mode.

Changes in v3:
- Newly introduced in v3
---
 arch/arm/mach-snapdragon/Kconfig | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index f863daf6bb9..3cfac19188c 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -58,4 +58,24 @@ config BOOT0_MSM8916_PSCI_WORKAROUND
 	  uses the buggy PSCI implementation.
 endchoice
 
+config QCOM_BOOT0_SNAGBOOT_MODE
+	bool
+	depends on QCOM_SNAGBOOT_MODE
+
+config QCOM_SNAGBOOT_MODE
+	bool "Build U-Boot for Snagboot mode loading"
+	select QCOM_BOOT0_SNAGBOOT_MODE
+	select ENABLE_ARM_SOC_BOOT0_HOOK
+	select SKIP_RELOCATE
+	select ENV_IS_NOWHERE
+	depends on !ENV_IS_IN_SCSI
+	depends on !PSCI_RESET
+	depends on !IOMMU
+	depends on !SAVE_PREV_BL_INITRAMFS_START_ADDR
+	depends on COUNTER_FREQUENCY != 0
+	depends on TEXT_BASE != 0
+	help
+	  Build U-Boot to be loaded in Snagboot mode on Qualcomm platforms
+	  for device/factory provisioning using fastboot.
+
 endif

-- 
2.34.1

