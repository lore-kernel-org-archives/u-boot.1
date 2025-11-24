Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33999CFD313
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 15:56:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 480B383E8E;
	Mon, 24 Nov 2025 16:56:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EyEEX1E3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jr9ekuJU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45F2583E8E; Mon, 24 Nov 2025 16:56:05 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D91783B85
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 16:55:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AODR6fg452550
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 15:55:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=LBlI7VpNGjo
 Ql5Tz12IK6qgb4K+jzvDWVepzthF/PKI=; b=EyEEX1E3JduchRA6hEHOlr77IQq
 IIod1XHJxIYZNkepxq4sSsCZv9u6dLaoTaoG9YI9RVkXF+03Nrq8lj9hPESF7W8g
 ecZh6RBFT8EHHeJEaaU5wj9D+bLgPkaoZ7EpXn/cIIAfbDUgsg9vryeRz0itTtX7
 hFO0DhtFebdfsFoY8Z4Bd1pPF0nCxMSUSHTU07zQVbeh/EfXmc0tU6xp2atCaE4q
 iPG/qeP6GfsDADFFSnr1PwocNglkmTSgWgFhFsnFgBLRiNRUjrvZjmzVSoaiWAJ0
 jtagig2FrMpZruqsCGlmRKGHgl1+rNV2pojZYxsne+5s9Dw7hVsjG2mKyYA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4amr8s8dqk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 15:55:56 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-7c7957d978aso1312860b3a.1
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 07:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1763999756; x=1764604556; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LBlI7VpNGjoQl5Tz12IK6qgb4K+jzvDWVepzthF/PKI=;
 b=jr9ekuJUDyBSYn7vD6wphsx/jxLxk7nJGWGc5VugTJ+RbwGJuliK4GkJ/DixapZ0Qg
 hrU4j2PNWICfoFhes3/6soPMfPWzGPbpWGuJv+chQmlT2WNAuPkjVu0tozL3JhXAZn9W
 CxDNkOEdhkGGVupHpPeFStCZM+k1wVPAaVkSMHgR6Gl3U0XvNNIaZ8S93ZbmaMsoXoRs
 7uPgUGL8Ay+WH8tGBSMA3PphNSe0MS6jcVUk9ppzcHiAGscvY4ed0wp+i+aFYZUPtnzi
 ngplyr/VSexOjX/jaYOcK1+6Hd7LoaKxZxGmSxLV7SNfqqsIreHtKsVumT57io+sa5E1
 p2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763999756; x=1764604556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LBlI7VpNGjoQl5Tz12IK6qgb4K+jzvDWVepzthF/PKI=;
 b=FerUl08p0bzAF+t+O8E8Ohqp+3zbjxCzHRFFydr5ZZaIuDRLyg33Z5oNu2L9Q4/ADz
 x9SHgbS14BwGp13tiSLnjZIkFiCflHaM2KSmrBBPvtdDWlN3AnZNNO1Pdv898kDJQ1uu
 u7P71lfxVjD/FPXd39BefWkUzIpzJEHRS4rGj+/gVE0G6zkTSd0ZmKHdHo70xUl77Cgb
 XUoPVFBzR9cOBk4sRrtfpNRmzNClyzwT+S+K9q8Ut9BWQV4Gp1u4yBMSJXbECVA3mql+
 xpzyT0F6MS8VtFNSwvbAHUPH3qRMCVqNLnARJvKOKmEk+yM5izN+X9DGDVfVHKZcVfpq
 m6UA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfFWdQEYFU2TCbB47RfbpydIa4L9LAiwcsCorriOYCehDVwzEjpXOUy6GkKpmXBV7XBVHHuis=@lists.denx.de
X-Gm-Message-State: AOJu0Yz8O9QptHnpaF2CP5cdUa9hsz4hVdpbPzIOROQXDuFn7HmTwkRe
 YZZ+uf69Jl1LCTcNyxKWw+aYvrgNLpk5uZBN8gePkxPNJZjTJiqGo6QuTKRODuTlF5eeepNFnux
 t87lXeaIJ83blfO/pwrj7pv2OlDreluTDuq/LVl96zxfsrpDR3KbdWcjc
X-Gm-Gg: ASbGncvuomwfH5i20YVkCbh+Oy+4gnQgYgsur/El651C6cje6En8Aa26ehcZBDzUuXP
 9HpJ1OD9rQ6qZLBFxU74l8BRUZX5RQmttLGOhP5ZEbTWK/ew83G0ewfLe7S2lvg/Rb4eLakKLxO
 +xj2+dqu4Sr5981W6wbb9hRttdso/1VOJ8McCh1Hdy/7s80ai8Kl4/Kkxh9ERVWeSN6DiX2xUK5
 9trkpSqdOOHUX5JbVzfN0Qla48KWp+hU8103rP6552NUjuvnRaI+aPb7joUFCCtLMShyBc9ozMI
 6cEMVNuKY3YG7x53cz6a14oFjcYJTBlrMt+x9KMXybNpe4Beo0/z2OJfPef3GgfsQEanlkbC+hR
 S4UkTZVDaL7+7cF/BS5lEE9QIVqkVX4I3zb2cVAlXTYteY3s781b5WqoL6nvZFwMTQYz6sugX+C
 sWl67OgGaATBNkjuzci9sOOj5InsY7fo19pL7caA==
X-Received: by 2002:a05:6a00:130e:b0:7aa:3fed:40ff with SMTP id
 d2e1a72fcca58-7c58c89cc48mr9832165b3a.13.1763999755674; 
 Mon, 24 Nov 2025 07:55:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlWz9IBbRTKWO1CtKjYopl4SIXxDlaigt7tV7rsFkFISnOh2PbNftAWwPOLrbPCO7oZqf8dQ==
X-Received: by 2002:a05:6a00:130e:b0:7aa:3fed:40ff with SMTP id
 d2e1a72fcca58-7c58c89cc48mr9832137b3a.13.1763999755212; 
 Mon, 24 Nov 2025 07:55:55 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7c3f023fd82sm15254884b3a.42.2025.11.24.07.55.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 07:55:54 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com, marex@denx.de,
 malysagreg@gmail.com, arturs.artamonovs@analog.com,
 utsav.agarwal@analog.com, vasileios.bimpikas@analog.com,
 ian.roberts@timesys.com, nathan.morrison@timesys.com, peng.fan@nxp.com,
 alif.zakuan.yuslaimi@altera.com, kory.maincent@bootlin.com,
 sjg@chromium.org, jerome.forissier@linaro.org, ziyao@disroot.org,
 stefan.roese@mailbox.org, mkorpershoek@kernel.org,
 balaji.selvanathan@oss.qualcomm.com, rui.silva@linaro.org,
 ilias.apalodimas@linaro.org, luca.weiss@fairphone.com,
 quic_varada@quicinc.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v2 6/7] configs: qcm6490: Enable super-speed USB support
Date: Mon, 24 Nov 2025 21:25:02 +0530
Message-Id: <20251124155503.2839766-7-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251124155503.2839766-1-balaji.selvanathan@oss.qualcomm.com>
References: <20251124155503.2839766-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ItnMsOonh5mFe4YI0XgT_kzSLvVRafx-
X-Authority-Analysis: v=2.4 cv=KP5XzVFo c=1 sm=1 tr=0 ts=6924800c cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=bWnyX05zxYj0a8V6Ie8A:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDEzOSBTYWx0ZWRfX475a37kaXnHU
 188cKiYBBcjgGRdeWwYptBmsScLMGXjJ4eEtMvdmgpF7FOP4KnKSb5FrNpYqyJYjYVjA9RacGUh
 zNKT7ZOtSKZky/r1D8OGRNBory5SuKULR533wA4Fzp5XrBRkiuFhNBDTv/XR2hcc/uByJdazMXe
 9AHI9uKVmLiN9PXNoPj35+/EGSFKgqijqMiUsRPpeQPnfr67l6PdSVvn1ypJHseXcZWRJPsb+Vw
 tLu7rvn7n8ep2s4D7GlX3zcgvihE1hmXfCPpb8x2sURoiPCnqvmIACtLjemvG6HJjkGL8SEWH3Y
 exQuqSATg/78T+Qwm4p2AW5fZNusW3LUnbO19c+mwCioMGdwIPPiiS+B+27GNICDqha5Icrkti3
 WdNkieKtz6eo2nytZdRp/PVKG9r+dg==
X-Proofpoint-GUID: ItnMsOonh5mFe4YI0XgT_kzSLvVRafx-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_06,2025-11-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511240139
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

Enable the QMP Combo PHY driver and disable the USB speed fixup
to allow super-speed USB operation on QCM6490 platforms.

With the QMP USB3-DP Combo PHY driver now available, QCM6490 can
support super-speed USB in U-Boot. The USB speed limitation fixup
is no longer needed and would prevent the hardware from operating
at full capability.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 configs/qcm6490_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
index 54eb5dedaec..1d9d9a2425d 100644
--- a/configs/qcm6490_defconfig
+++ b/configs/qcm6490_defconfig
@@ -13,3 +13,8 @@ CONFIG_TEXT_BASE=0x9fc00000
 CONFIG_REMAKE_ELF=y
 
 CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs6490-rb3gen2"
+
+# Disable USB fixup - QCM6490 supports super-speed USB
+# CONFIG_QCOM_USB_FIXUP is not set
+
+CONFIG_PHY_QCOM_QMP_COMBO=y
-- 
2.34.1

