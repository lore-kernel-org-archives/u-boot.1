Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80657CD5BCF
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 06:56:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F234A846F8;
	Tue, 26 May 2026 08:56:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mS2AoPCl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dEHQy0jU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9B1E846F9; Tue, 26 May 2026 08:56:46 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B65183EF9
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 08:56:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64PMniO43263603
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 06:56:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=ecyPdUgSFKi9vO5V9A+q2W
 Yfk8ga3xyanzgeVjvFE88=; b=mS2AoPClRcb7lf4jtR9GAwIgYmb0keZ7iWeLkM
 T1ZI7lBBL79X5IFGBrahfO+6yAerRPSX5T9MlszYfCbNDBzdEpqQ65z6Q4TEKTc7
 t44Rdi63gV43JQ/p1zmGHlOHhL6+BtPfKulZCRjNkMymNQLaS3eJw8b87LznZrRQ
 +cp4BAdcFoczUv68PrxMSjAZSNkZ++CVCGj8JmymK7MEYuN1qKAfFBGKS5nCpnG9
 AlaSm0GwsqiS4I7k7wwpjF7Uu9scq6FoDEPu5ypbbBr6u6I/aSHBqeZMBsCb7f3D
 F25vK2hMlH1s6i/S0pEZePT6n4fUzjU3XZFu2uDvHEl4Av0A==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecnhs32k9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 06:56:42 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-82f9f49e4beso5105907b3a.0
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 23:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779778602; x=1780383402; darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ecyPdUgSFKi9vO5V9A+q2WYfk8ga3xyanzgeVjvFE88=;
 b=dEHQy0jUz57D8NJH/4QxPj7WPDkv6Kg6BwzJd5LZKXqXMeA17Weqv0w08qe5aZuucW
 sVAoqwKnuscksFcwWlKzEubHapL/uiP2N1T6UsCDt+hYvCwEd/tLuhM1ooitNW+6wEUF
 5s8U1Co3fv/b+MDrSMAj5CxVUOb3DkN71aLwZs2SbPxCasp/b0lQ/zrsBXzBJWSkUG1g
 n4FqRfyQsdrlV0GeEEfvdlQmezM3kxJdCsyQAT3uM9+Eq7q3oXNTjIPkbzVO23SYT++h
 jeClK+dAR89b4XepTbnbb6Mpq4g8TPB+Y5rerNtSfMvkQ73Cg2DbYey3UOLrhPRIEy/V
 LIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779778602; x=1780383402;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ecyPdUgSFKi9vO5V9A+q2WYfk8ga3xyanzgeVjvFE88=;
 b=AwDj9F6MmYnA1qpB72AJ6UYFSVbJOjs8j4qPLuZgKyzxpwtNAZyYSc0qpESQlOE7YY
 iWmjFKzm3husLmWGOBZAmLtgU+P6tyj6S6vY5hiwZIBIDM5Snx1AicvO44DkzH1Rt9b7
 gvPPvhODVhFQ/v8H49cx5bb1+jryaBlTX9bB98xiUf27T5Rp0DkmF4yGSewToQgZmqdJ
 uXp4Iq+D6YCVETguPEw1YzK95rwVxFoDsEse+AbVofB7dTqvX4sekzW8rtJaC4LPn5og
 +wjyag99B961lEmTqo3MMVrA0+tRDdrFBsaM2Q5fvqHHK9VXzFXh5N1RNaN8D4a4Az3I
 kZ4A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9oRpz8WWuZd1GspgQja0kTrL+eVO6z3ZOrkjrx1JeICaQK4Xm1RwjVZRt2XhUTuqlCqULtb3U=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1+hL1GTPE23Z/Oe23lZmsHHH6dpgh4+jf68MJdpOWxVP7wwnf
 z3scspkd0GsO/KXem1/6CoP5R6el0UG7p28bNm6b650/VKpQauPL+vQQ2xpRy7uWEfdbmjIvceg
 iImYI1wAlz7phEmYPjD+r24WZAM+ErdJcXdEM/gkb5DNCAjBsbMIf/I4w
X-Gm-Gg: Acq92OHGgnY52jXbdyMoFm3sjBrb7WQ2GxAAlBfr5EO5ikLNhDjpesi5jy7oqsAGGkO
 evC93dTQWvqF/oUyA8MAzfhhdcIgcaeqF9PQWEzFqtOoGl0ve0X+95UdmIeCReMTWiVALfS6EE7
 /TloxvjUo1nCc5SWPn6OWPEo8SgefVCtP3UEWQRfPVNLDqRm5x63GndMCSeGKOI+QE1jYNgp8Yh
 HMWOstGv/MEheVhqopecPxmpXcGOri7CHupvAXyNR6U5Wo9bW26UDLES4EXIHritfe6ly3dC90Y
 lyq1Dex6IPVBsNZGfeNwquES77GuhYiD0s1JNfChgq6oE38BMPQHsCuasXdbHG3TIfKbgYrcnwd
 wdI62BEdH8uVb1z7RxQbufxvvay9yHV7AvwMQpBVUmd9VMbwgDOZ4rSeL7+ir7/SzWLLOxFPjEg
 drKqbLR9o25jfP3VQKQ12CiTaibC9tChCtj1ZBOGzi6Hhh3yCw/w==
X-Received: by 2002:a05:6a00:419a:b0:83c:5e:f647 with SMTP id
 d2e1a72fcca58-8415f5a64efmr17009877b3a.29.1779778601811; 
 Mon, 25 May 2026 23:56:41 -0700 (PDT)
X-Received: by 2002:a05:6a00:419a:b0:83c:5e:f647 with SMTP id
 d2e1a72fcca58-8415f5a64efmr17009849b3a.29.1779778601349; 
 Mon, 25 May 2026 23:56:41 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164e9e635sm12598060b3a.38.2026.05.25.23.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 23:56:41 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 26 May 2026 12:26:36 +0530
Subject: [PATCH] configs: qcs615/qcs9100: Enable watchdog autostart
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-wdt-v1-1-8236040fe56a@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIACNEFWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyMz3fKUEl2DZCMTM4M0yzRTw2QloMqCotS0zAqwKdGxtbUAepjpO1U
 AAAA=
X-Change-ID: 20260526-wdt-0c2460f9f51c
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 David Lechner <dlechner@baylibre.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779778598; l=1265;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=lbeMC6ztsZEZ17S6Bh9qVlymZiTRplTPgz9ncVtqc7o=;
 b=e9VVfzOb57NW0k6zME/LVMmKLq45H30d8B3fy0X2QFn1Vp1LOnFPIa2wjJMRJ7ApSJ0Mp6D4s
 TqGZgJXGqHnAiHaidC5oY+QU7nqkARLwrsP21QeavLDIg4OkvsoPFeF
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=Vd3H+lp9 c=1 sm=1 tr=0 ts=6a15442a cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=XnQnjzi6d-yt45lwBnIA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: QhI4WuA2aT5fOEw6hWfvpEDTweJ7KfEu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA1OSBTYWx0ZWRfX6jGmken3+nGi
 tmij6XsKkT473DDil4mm1LdIsowpnXBAR5tdsV+NhYbA5coLwG+kAr4NmJqEgdTIahtTqDAeSJC
 vXmaH8b+UFu4IslUtJGDQzkwks4TI4+TrsYo8HCxRHiiK6QLtl+QMnIgIFhqzWHtJRXuN6y0faX
 LZTU31ACfN7I0APmrgJOODTa69jAfICiLDEr7NFdT4kKhxcHkyCp6hW2XDtjpMoCDT0mQspoRaO
 dsikVJZ78o4TJg6saZccbqapDZ7MeHJXHZZNnDD+1hNwvkCmCb0Uu0FnDN6wIdIPAKUnJAYS8lG
 ZzY6OCbVgqi/BapX5YlXlMWyQeadhB7WVDEpNQjz+lkRhiRX7L8L/qyzda/diozXbRizYkm9Fgb
 id//c9Y/bMI1gKQ8k00XX4t13a+1FFpqYwd5LCs6Wjv7f3tadznD0Hs9DCI14C9o9g6XQPLiVDE
 vEtPJuonRNUA9T+QxkQ==
X-Proofpoint-ORIG-GUID: QhI4WuA2aT5fOEw6hWfvpEDTweJ7KfEu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-26_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260059
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

Enable watchdog autostart for QCS615 and QCS9100 platforms to ensure
the watchdog timer is automatically started during U-Boot
initialization.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 configs/qcom_qcs615_defconfig  | 2 ++
 configs/qcom_qcs9100_defconfig | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/configs/qcom_qcs615_defconfig b/configs/qcom_qcs615_defconfig
index 27666a8129d..e060fac3726 100644
--- a/configs/qcom_qcs615_defconfig
+++ b/configs/qcom_qcs615_defconfig
@@ -22,3 +22,5 @@ CONFIG_REMAKE_ELF=y
 CONFIG_TEXT_BASE=0x9fc00000
 
 CONFIG_FASTBOOT_BUF_ADDR=0xa1600000
+
+CONFIG_WATCHDOG_AUTOSTART=y
diff --git a/configs/qcom_qcs9100_defconfig b/configs/qcom_qcs9100_defconfig
index 082106157bb..efd6c63f212 100644
--- a/configs/qcom_qcs9100_defconfig
+++ b/configs/qcom_qcs9100_defconfig
@@ -14,3 +14,5 @@ CONFIG_ENV_IS_IN_SCSI=y
 CONFIG_ENV_SCSI_PART_UUID="71cb9cd0-acf1-b6cb-ad91-be9572fe11a9"
 # CONFIG_ENV_IS_DEFAULT is not set
 # CONFIG_ENV_IS_NOWHERE is not set
+
+CONFIG_WATCHDOG_AUTOSTART=y

---
base-commit: 76d62273bc8a5dc126ed79ed0fb65e5a97359577
change-id: 20260526-wdt-0c2460f9f51c

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

