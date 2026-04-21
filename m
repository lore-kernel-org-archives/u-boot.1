Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F8DEA71BA
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 04:46:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F71B83FFA;
	Tue, 21 Apr 2026 06:46:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gd/7UxMY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KWXH+Gag";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D359F8407D; Tue, 21 Apr 2026 06:46:09 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DE7280433
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 06:46:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=gurumoorthy.santhakumar@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63L3PePw4168274
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 04:46:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=/S//DLVafWyoNpQ8yLek73+U6bhnXrgjAYU
 icHVGMmI=; b=Gd/7UxMYuT4IKc3C9Z7JFWQ95XruUx56JeUHhJ7QrvWkrHn35VI
 lDq1EVwRmPpc/4ESbDpp91jWd3c3jkOP6RjuMXtRiKqoWnCj37LwRqTMpkOCWz+a
 reQecjdrdDz97GvlaIVSCzwEcUbHI9bBaIOwRGM9eqrheSoeewpdFeIzfKDviTbC
 2AwmPxkpOy55QOMz8VXCNfn8k45NG2zhdwIY5wFpCoIPJwMFhX1V8FFFEUi8heNv
 xN7A7wo337RSIcbt7pk460QwfCfVexyE1Wwggl3xv5s+m6n5/udzJNQMACGtwqm1
 RfLp9VPxMisnEnkYq7qBgyN6AC8+rk87iYQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dp1au07fe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 04:46:05 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-35fb6cd0879so3593119a91.2
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 21:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776746764; x=1777351564; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=/S//DLVafWyoNpQ8yLek73+U6bhnXrgjAYUicHVGMmI=;
 b=KWXH+GagSPViNz59xHRzBj7QkDnXel6AE2DH9Bcgy3mBbtajHylW9TTKygz1usYjFP
 NsJgam5mNpvv6wtJFV3hixHWbccveJ/4KUIkjl8K70/uODDToohAl71xMAna0/qC54NG
 hnnmK5TUE7cKvsrndvhAaDeONXbdhHXAl5ab441eHXNlXYUzHYnDpWXVNNwBVir95MSq
 jNiYT1pHNwzYDaAO3QSwZ9SwdqazN4xbUdExOHvl5/GcN55p2+fYXs3WIlhYVYLWv8Xx
 l0X9Ih0qvUpECU9hniL5NPc2Dz+IQZyT7+EjewUhF8A+Csx/lVYlHx+zxI6I8KR2utat
 D9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776746764; x=1777351564;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/S//DLVafWyoNpQ8yLek73+U6bhnXrgjAYUicHVGMmI=;
 b=SMvBQSxvI/zItwRMvpBSPt9fBntt6VAlvM7uk6WIAJ8UzaM8ooOl7WKnq5e0xanzTh
 rbPwxGlKu2PUXtQgKIPEYOyWAN7et+IVkglxQ85yT9GVkB50k4UOowK7rNdmIBVfBloG
 JYJZG7ntBBhAT4aVodePf/PRBOsW6WGubX2aNjpo+CnQj20teiWeODdyGJO4XL2bGSst
 xDVlmC1pE6Z3CjFbOziha7sRRinsT/JraydgDcVd5nBICts8ZgLUdaf4vHwGfxUVwUWk
 1pmbXPO6FQLllGfg4uHyfePrbYEV157tSo7pUjZzu+WRLxuoT6QOAfvtD6lWOg8ymv+I
 556g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ENlUFeIuWzm6RMYPMQh8WKyYbOtPbQRftvJtlym5cznYKQOU5X25rvbeh5cYdQfChFwO0ys8=@lists.denx.de
X-Gm-Message-State: AOJu0YxfGEiM9iOkxBJ0dJVbk9pSDgzdeBIa9FH3XQRulvtKBBk3m0fP
 Vy9CeWPVhaPo0TndjFg90TjpmgWK8/FdjHPhaUG7Zm93vPSGUZawSaPNL/UmpOqnCSuGVcxApGR
 z7GrMZmDOf38KmexpVESdvzFzeyo7fPHqy+0ywC0ePMJALZLTs/CejKsl
X-Gm-Gg: AeBDiesiZWkW3J42HtoKof86SprFZsHYGh+WHE4KJd55yaxTZbU8BgN/0tCeZbhu4j5
 mpLB5KOtCczQ5HiHpEn0lH8dP4Ym3S0jk7g6DQbrgaMP+mcqEtfhoTfugHwlFRGeae/OhmX9NwW
 FWrVncKlAwLC/zmTDg4vDoI3iui2GkomVjbUJFOEHGTXEbgpha5mI8kyjpE5/b/3aXIi6Wghvcr
 IvIjUUeVNdeKVwoJ5Lf60jwL5ht3PbAZwzdqwD0ZJA4EpVRcctxJivEVDF2b9hWWx7ukp9LV3k8
 fnHdwtMGcc2ca5s6sNbpTaDZ68cE+tHbHTnGIE0TIY7hGQXO9sG6ZsLIbIa/XSivwCC0ZGNgP4/
 i5JL/F+gu6YWyV/NOfUWlQzxC9TRmggD6sYHayC2SfxhLcBBgefRHNaDvh04pT7jR18McyiOIRY
 w6hia6JxKEscUbtGvLmejCcZxneSUg1O7zUgPXdoUM71WxU75ukWY8wdcKEf4UjIBBiXw=
X-Received: by 2002:a17:90b:1fc4:b0:35d:ab26:5786 with SMTP id
 98e67ed59e1d1-3614048eb6bmr16387009a91.19.1776746764284; 
 Mon, 20 Apr 2026 21:46:04 -0700 (PDT)
X-Received: by 2002:a17:90b:1fc4:b0:35d:ab26:5786 with SMTP id
 98e67ed59e1d1-3614048eb6bmr16386985a91.19.1776746763799; 
 Mon, 20 Apr 2026 21:46:03 -0700 (PDT)
Received: from hu-gsanthak-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-361410bac6dsm11914940a91.14.2026.04.20.21.46.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 21:46:03 -0700 (PDT)
From: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, andrew.goodbody@linaro.org,
 quic_timple@quicinc.com, swboyd@chromium.org,
 gurumoorthy.santhakumar@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: [PATCH v1] serial: msm-geni: configure RX watermark register
Date: Tue, 21 Apr 2026 10:15:55 +0530
Message-Id: <20260421044555.368486-1-gurumoorthy.santhakumar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDA0NCBTYWx0ZWRfXzW/1cwZlJOaL
 Ki27LiRsBnn2SlQ+dhdOdkCHYdSzxXVyqNeohlmjwYiOdng8xZTKPMRL2qaJ+sR4UG8KqU8BHx/
 jIUuHWD2a1m/7/DFJAMIaCgwdYinWq0j4XXmyOpgdWgc9KM0SNXIWz5rKJ4cttpQgGvV2vJy+7E
 IPZOhPyQHIgM9FL8BbXlJqcdvk7xja9WhEFqMV98W04OL9D+qjAVfDtSlbPWdmbsKx4PboU1Fkl
 J0vn9riTtxm9lrKLtrKqmVkqIsHSYkfuIDjMGxTYT41L5VxnfHjVZ9TBAhPlSydMkKcUAo1qBoH
 +QCisCB6RnJI2hcWjBLY5+oKJCUZ9ODiG1JyfFJHCMaOzuRAfOzoUBKq4Q3OqVjinsVYNLPxHOA
 6o0jtTRcxX654zKjunte7WMzPOjxdLPPvgNZLsfECDS7f+aV+sy7/YJFJ6x383JJXdtI09ovYpf
 0gL5XeerTUWc41ytexw==
X-Authority-Analysis: v=2.4 cv=F9JnsKhN c=1 sm=1 tr=0 ts=69e7010d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=ag1SF4gXAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=JQEU1KsGukfSeQCV5iwA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: ORaD3Q9wt-cHWuX9oukvRsU3ygSBWMgc
X-Proofpoint-ORIG-GUID: ORaD3Q9wt-cHWuX9oukvRsU3ygSBWMgc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_01,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210044
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

From: Timple Raj M <quic_timple@quicinc.com>

The SE_GENI_RX_WATERMARK_REG was not being programmed in the RX
setup paths. Set it to DEF_RX_WM (2) in qcom_geni_serial_start_rx(),
msm_geni_serial_setup_rx() and _debug_uart_init() to align with the
Linux kernel driver behaviour.

Without this, the RX FIFO watermark interrupt threshold is left at
its hardware reset value, which may differ from the expected value
and can cause RX data loss or missed watermark interrupts.

Link: https://lore.kernel.org/all/20200227132223.864425794@linuxfoundation.org/
Signed-off-by: Timple Raj M <quic_timple@quicinc.com>
Signed-off-by: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
---
 drivers/serial/serial_msm_geni.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
index 3dca581f68f..ae4015e0fdc 100644
--- a/drivers/serial/serial_msm_geni.c
+++ b/drivers/serial/serial_msm_geni.c
@@ -55,6 +55,7 @@
 #define SE_UART_RX_PARITY_CFG	0x2a8
 
 #define DEF_TX_WM	2
+#define DEF_RX_WM	2
 /* GENI_FORCE_DEFAULT_REG fields */
 
 #define UART_START_READ	0x1
@@ -345,6 +346,7 @@ static void qcom_geni_serial_start_rx(struct udevice *dev)
 
 	geni_se_setup_s_cmd(priv->base, UART_START_READ, 0);
 
+	writel(DEF_RX_WM, priv->base + SE_GENI_RX_WATERMARK_REG);
 	setbits_le32(priv->base + SE_GENI_S_IRQ_EN, S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN);
 	setbits_le32(priv->base + SE_GENI_M_IRQ_EN, M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN);
 }
@@ -373,6 +375,7 @@ static void msm_geni_serial_setup_rx(struct udevice *dev)
 
 	geni_se_setup_s_cmd(priv->base, UART_START_READ, 0);
 
+	writel(DEF_RX_WM, priv->base + SE_GENI_RX_WATERMARK_REG);
 	setbits_le32(priv->base + SE_GENI_S_IRQ_EN, S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN);
 	setbits_le32(priv->base + SE_GENI_M_IRQ_EN, M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN);
 }
@@ -616,6 +619,7 @@ static inline void _debug_uart_init(void)
 	phys_addr_t base = CONFIG_VAL(DEBUG_UART_BASE);
 
 	geni_serial_init(&init_dev);
+	writel(DEF_RX_WM, base + SE_GENI_RX_WATERMARK_REG);
 	geni_serial_baud(base, CLK_DIV, CONFIG_BAUDRATE);
 	qcom_geni_serial_start_tx(base);
 }
-- 
2.34.1

