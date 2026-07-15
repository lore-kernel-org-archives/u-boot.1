Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C6FC44501
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 17:30:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2A5E84C0F;
	Wed, 15 Jul 2026 19:30:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eL+5C2FB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GjudpcuQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FBFF84C63; Wed, 15 Jul 2026 19:30:14 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2B8184B86
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 19:30:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66FHBRQT1288430
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 17:30:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=K7Ru7JJdyMj5Sl44N0bGLHyVrG/8tXYwLiO
 yyQ/jpbw=; b=eL+5C2FBmb4CGsMfzjKIpvzEilfmfhjGMPJWUSWqFTw8uCs/pBz
 WSMO6dEAYCmx2RYcvaOADtkdk/qRI5qAsomDPFAvanfAHFq4oL1aIzii69vT65fk
 X/QMij9eJoYRgieJMuj0gpsN1VCFRE/cHYE/iAZ3N3BXdig9t6v9WCc0gV9tOM4z
 v+t14UqQ4JmMC7ivy7u9E6goJoqzr+fjfXP3D3f8WcmQW4h3IYNxJCX9tEo/yXfE
 QV0EAHcIc8NrAj8Jbo/gXrZgK73XuBcoRvw571xIM24bOmwCEA5xmlNkXbePqfND
 V0Hlf+xR2tvPjuTqIjwa1/TJEoXYpXB6RHg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe68wtemk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 17:30:09 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38869800848so8826120a91.0
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 10:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784136609; x=1784741409; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=K7Ru7JJdyMj5Sl44N0bGLHyVrG/8tXYwLiOyyQ/jpbw=;
 b=GjudpcuQJXtwbsBg3lSeYbFFQ4Kgt2HP1gpE8mFqkhD4sH8nBOGii9zyvpIm7Q4PWf
 qHOjn0I1Aaa2hzN7Wu12mfxE97kNE2AZuegFKYmVnoZzuoxSFqNk389grFpmJ2Gp2wgo
 RGKW76warZ0T7v+t8Iy8c06TR27l4IHLmXD8dB7VWWkCB8AITcllDi+nCBdUCoeTslUe
 6/1O4I5XAafnaJeqyGUk8YjMEEKRBY3YjPO5sra9OJ6qFHWE/4Q/jRxpsSRQ5uyQ01ry
 45xm+c0d2y7YdMohWEe+lYuIwS72gEO9NwQ/zj7+pecUO2AM2v3+L2JAHcFpeIEEYMrG
 fW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784136609; x=1784741409;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=K7Ru7JJdyMj5Sl44N0bGLHyVrG/8tXYwLiOyyQ/jpbw=;
 b=UOquq+1Hz9vdMBCgYr8n20TU8rLFH9gYq4f35Jterwu9K2tScOr66EZ3hGx8cwp2RI
 KqWpgeNjpsWJ36rwCF/8d1EO0QsKhMCILJJK2qRnuSsDLt/FtrtmCsfH2b/U4SygaL39
 jCap/tk7Zb4x9E11pimp42bNhTYoZHjD/9Fu3Xguzm7ChuDUqraKhSDFgrM3KS3/rTe9
 1iRie9S4nSyBPu3lzZFxvgQ+e/DRcdP3QHKv2GJrK31IEr1SalGPKEoqbiOieajWGXVo
 mnpzCF/L9bvD7pcnPOLuttuXs+TOLTM6KZILPo/otS5Hb5sFpECYBvMPXdU9Iy3GXd8G
 OSmQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoqI1iCnreUZtjx22yCHZY65oZDyoOMD6Myyr0L69WCudP3U7gkhAjnd1ql/CJLnC8hbi6TnCI=@lists.denx.de
X-Gm-Message-State: AOJu0YyOkfYCuFk1ExdEazcapmDkZ789xDYu88C4QSOZWIkMKEyWfwdO
 kQPjaOBHIpQirSsG8qwj3owGipyYp0YdVJEj4DYk2QlsZ5U3f2A8nk+2Xa89b60OrIqRfjI9FzD
 BSq5VlbIV0e48Pn25djI94ZIIYIV7UkOHxjx2VclgsMsAxyco1wOwAB4S
X-Gm-Gg: AfdE7ckbakx6WDay7F9hm5ToZAoFZUaeA2odhQPjIMCbvv3PqvFRAOLWM0QrUNYEWPI
 /Mka9DzmeryB2lHbR0v42c+YC61vVwMUJ3i0r0Vf/0i6OijLIEhkRQ0IbIsevDkrVw0tZRrr9x5
 Ozuv2tK+WDqbQPXu6H7gMGGdQ4DV2xD+jOcYjkq+VDtGp7b4Bd9j4fVYmXenpHIlSM8CJsipS8a
 FtyhC5xapgT5DuK7EspYCiP2MOBj3D5j8EpBsGYqZcJHWLj3dmgWZnmPGrCGDHuWs3YUhxvTJtf
 0xG6wa4467Fsh/h+QJpGTc5vmTNfDkO3Xmbz0uUGcwJiCF9XDhBFS9oOWmsun1PC3Kck+KPFxC1
 Qi3BsbHxkmAFmyulaSlDg2fWpchB8+yt4jmobXgLXOYY+T9do+E5ef/hYJakldWbm/ihD25Quir
 O++7EnsGR9iyQt4n2P+RCqVfGPTzpoxw==
X-Received: by 2002:a17:90b:1d52:b0:37f:9ce1:7367 with SMTP id
 98e67ed59e1d1-38e1af33ac5mr6594524a91.29.1784136609049; 
 Wed, 15 Jul 2026 10:30:09 -0700 (PDT)
X-Received: by 2002:a17:90b:1d52:b0:37f:9ce1:7367 with SMTP id
 98e67ed59e1d1-38e1af33ac5mr6594484a91.29.1784136608330; 
 Wed, 15 Jul 2026 10:30:08 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e5326c0sm3071914eec.11.2026.07.15.10.30.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 10:30:07 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, aswin.murugan@oss.qualcomm.com,
 quic_timple@quicinc.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v1] serial: avoid redundant early UART initialization
Date: Wed, 15 Jul 2026 23:00:00 +0530
Message-Id: <20260715173000.178392-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: dBUKfW3ADoMl2SuV0TRJRhj2NFff5qV-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDE3NCBTYWx0ZWRfX1x2OoU0L6YUp
 fLQ0acbmVmJ3infrSImAfeeoEniQXpL43H9T9D/lQmGQIljP9PmM4wOHP48o7wNr7J9CpqYJVGB
 GMebzhNqHYjc/KcxaJeFm3inLGI0vvG9nO/wpjYkSMLN0sDhq6X7nAwVeB7uwE6QHVOtePbxieD
 Piin2PO9ybAR4uutMoY+hNb83MD9Z2T99/wI9WUSOv1yOp3nng6vMNg9j1pyHufiXZqihLfOvXD
 xTdszR6AOKe67frIiTDO9Ff59MIqfh8ep70WtKFer2bV7sr057fkJ8jxuIx8v6vU601IHoQ+vQ9
 znIaDXYraXaHt/YWfpMSYPX733xSHo3G15vD74rJ7+nKGdhcejcguxNHM53L1Zlt/bJWJaoB3MK
 pm3XmRkFvcKyn0Rqef9NAbCEPyDsuqqrsbEzjQIaJ7qvOAWeafOCZ2EOpS7IQtvqDXixdmHEZ2t
 ImcC2v5QrrFh9AaQdUw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDE3NCBTYWx0ZWRfXwTfx37A00UxI
 9CLNYZ/JG1nI5Wz6z6lCuPP36L0I56bccwC8x1m3/nanty2swrgDQKVI4cyPXrKrpVp/PtHd2AD
 bcXesNW5Yq9bOdOnKXWE/K/NUYF9SsM=
X-Authority-Analysis: v=2.4 cv=LbgMLDfi c=1 sm=1 tr=0 ts=6a57c3a1 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=Ya2ut22CaUBMltjltHkA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: dBUKfW3ADoMl2SuV0TRJRhj2NFff5qV-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150174
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

When DEBUG_UART and SKIP_EARLY_DM are enabled, the serial console
is still probed before relocation even though DEBUG_UART already
configures the UART and provides early console output. The debug
UART configuration is sufficient until relocation, making full
serial driver initialization at this stage unnecessary.
Furthermore, the initialization is slow since it runs with dcache
disabled and is repeated again after relocation.

Skip pre-relocation serial probing in this configuration and
defer full UART initialization until after relocation. Update the
GENI UART probe logic accordingly.

This removes redundant UART initialization and improves boot
performance.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/serial/serial-uclass.c   | 10 ++++++++++
 drivers/serial/serial_msm_geni.c |  5 +++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/serial-uclass.c b/drivers/serial/serial-uclass.c
index 7b381ca12a0..9be2ad270ad 100644
--- a/drivers/serial/serial-uclass.c
+++ b/drivers/serial/serial-uclass.c
@@ -190,6 +190,16 @@ int fetch_baud_from_dtb(void)
 int serial_init(void)
 {
 #if CONFIG_IS_ENABLED(SERIAL_PRESENT)
+	/*
+	 * Skip serial device probe before relocation if debug UART is enabled
+	 * and early DM is skipped. Debug UART will handle console output during
+	 * early boot. Full serial initialization happens in serial_initialize()
+	 * after relocation.
+	 */
+	if ((CONFIG_IS_ENABLED(DEBUG_UART) && CONFIG_IS_ENABLED(SKIP_EARLY_DM)) &&
+	    !(gd->flags & GD_FLG_RELOC))
+		return 0;
+
 	serial_find_console_or_panic();
 	if (gd->cur_serial_dev)
 		gd->flags |= GD_FLG_SERIAL_READY;
diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
index ae4015e0fdc..ff91e0018fa 100644
--- a/drivers/serial/serial_msm_geni.c
+++ b/drivers/serial/serial_msm_geni.c
@@ -555,8 +555,9 @@ static int msm_serial_probe(struct udevice *dev)
 	if (ret < 0)
 		return ret;
 
-	/* No need to reinitialize the UART after relocation */
-	if (gd->flags & GD_FLG_RELOC)
+	/* Skip re-init after relocation if debug UART and early DM skip are not enabled */
+	if ((!CONFIG_IS_ENABLED(DEBUG_UART) && !CONFIG_IS_ENABLED(SKIP_EARLY_DM)) &&
+	    (gd->flags & GD_FLG_RELOC))
 		return 0;
 
 	geni_serial_init(dev);
-- 
2.34.1

