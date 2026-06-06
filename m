Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0AECD8C8E
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 12:47:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09BD584715;
	Sat,  6 Jun 2026 14:46:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UAsmwvC0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PkB2za8b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEAFA8405A; Sat,  6 Jun 2026 12:21:24 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A46D8838BB
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 12:21:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65660TDs621648
 for <u-boot@lists.denx.de>; Sat, 6 Jun 2026 10:21:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GOEf++nYYVU9V1x2FE/yrkvT8CPODZKMIoKFKw1BtfA=; b=UAsmwvC0hKH8WGpd
 NiKmGS7LXgbpN4jALPSz6WRlGH8Tz1zg8i4dE1gKbPMN8rdDvKhxzdX5HtcuKwxI
 qy8269F67ZiodXoDwbWh2zcp9CqMdPrCBrFcWivkRrt+4U0LGz8wrwyoBKhkWiTg
 LJr/3SmFt/VcyexJAraB/mco1ednfi1M9qfImIJKbNWE/xMRCRya5/omohTGfCY4
 LdrCF7IsdH4WWkrPcDAcMuCyfIi2/s9UOU1a5/L41NBF8EoiFSz+lmjQezg6DTzF
 JUKKL2YRJuGaRQE4HxASGFgCyFDz2KSCYW9tFrm8Mus0UIWaKf2DE8Zlt3yzCEiJ
 pFUKbA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcadrnc4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sat, 06 Jun 2026 10:21:20 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2c0c32faa62so48980105ad.2
 for <u-boot@lists.denx.de>; Sat, 06 Jun 2026 03:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780741280; x=1781346080; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GOEf++nYYVU9V1x2FE/yrkvT8CPODZKMIoKFKw1BtfA=;
 b=PkB2za8bEf4bFiAdkUKGKg0Y+hWnonysorKBQWHFxpTVL5OGzxLDDCoXeJbzJvx8QE
 aZ6ewlnCSXq+Lt/ADZMT0YTSZyeS2ypH65zCTsjT5/tKrEy9c/bcWX1PyH3+dg8dRblY
 dibxDk3jLXBaVi5+2c6bbN4xOxpxbZzk2xhetpenP+xEJ9QGFQpM775OeHu0AQFdsJcJ
 6IRibaOQj6DSIzVT3NrVXl5C4nw9E2BiVBKdDPzveeIZMBa+h5ARs0xhMcsjbQ0P7oa/
 YnmUWWXYXjJP8ILrt53XrKbhX445HAzXYjubFJKXMtkJTnY84arLQRvHlzpCKExuhELo
 ohgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780741280; x=1781346080;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GOEf++nYYVU9V1x2FE/yrkvT8CPODZKMIoKFKw1BtfA=;
 b=Oz0jWMaB1iivA9cLcNyQGrmec/dkK0CgrAt5e81XawpIjENuO6btuzV8zuc4VPcPsc
 FECiLDN+iMgNGTpYsSLyeCkjnTVWGZ4XW2ALrJa2pTfGTXUG4xd86PVTbfh1yXBSVNcQ
 OguX9ycXrFX8nAFGaoqtuleQtsiwO5puLjt0ovITJ0zcHCiCnqlwSm1hsdmzZYCJ7F9q
 LaRTySFrL/UMrVFhtaJvOAPYa9d67/mtKjJUWGmzHDgtgBeIomXozhG1dj9Mgj91hvra
 kK7LAoAmgGQRibIJ20epF1kMjoMScbOkKltu7d3TvpOKeSoQHyJb4nOVVXXBWADI6bqg
 7kcQ==
X-Gm-Message-State: AOJu0YxqWCol7ySnRSPe6LpmbV5lwPGzjeRppWTKVoi4Yfcd4EB1wjug
 sUXyN+AGcSfaf4gWZHspjX0FO7ZrYOiBZMZg/7xbqrgqJ6+aJ4nfMyQC9WTd4zEFGf1DkFmvOxX
 b+THuub66o96tN3ICfXeURTebc0ezybysYXxIAL5EGVvlYgPbKWktca+7
X-Gm-Gg: Acq92OEghxAiaNjEplOBL67pfGxhGFO9VUjuv0XbN9Q1cvDKzIjLcX91ohc2qde+qhQ
 +edYPprajBTb3wieBXVh7noeLGzTDDNc2gcbDD4ivY4H4sK7RFtGIxr9qSArzit89hPCHOVcxob
 OLVzcBrAgefKlPABZc1lNPxaQWRgZTuNu3TyUrqrnwCQ+6yhGnzWyfdGGQarXMzf0N33eitTq5R
 S8MovL5e1eWPd+P+0Nt7SJzBkwaZ/93x5AbHGLj846NzkY2bEHJXQw+ZrMNmTsTE57hpiE+HgbQ
 JelHQEOYeQmGYXjA0kK+2H22dT+uHeOqn/vlTaIuLQ24yBNFMM0dA1BH/EScwkRVZ01k/pj8AsV
 Jft4cV6TtZYY6idKKJ2TaEhnj+CVk/Oi0/48AviZpwvLg8+TgUXct/baS0bUJEmVIkNRiSXbO0H
 seLgknK8NKSi+DMynu/LNl+8L6hVX3+AY0wNUDr+4A89cVSGkNsT3NNcibW2uI
X-Received: by 2002:a17:903:faf:b0:2c0:db23:4c4 with SMTP id
 d9443c01a7336-2c1e82191bamr84998785ad.16.1780741280089; 
 Sat, 06 Jun 2026 03:21:20 -0700 (PDT)
X-Received: by 2002:a17:903:faf:b0:2c0:db23:4c4 with SMTP id
 d9443c01a7336-2c1e82191bamr84998395ad.16.1780741279623; 
 Sat, 06 Jun 2026 03:21:19 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c16609ed97sm123124235ad.41.2026.06.06.03.21.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 03:21:19 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sat, 06 Jun 2026 15:48:40 +0530
Subject: [PATCH v2 09/14] clk: stub: Add Kconfig option for SPL stub driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-spl_ufs-v2-9-72fed24ef01b@oss.qualcomm.com>
References: <20260606-spl_ufs-v2-0-72fed24ef01b@oss.qualcomm.com>
In-Reply-To: <20260606-spl_ufs-v2-0-72fed24ef01b@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Javier Tia <floss@jetm.me>, Rasmus Villemoes <ravi@prevas.dk>,
 Jan Kiszka <jan.kiszka@siemens.com>, Dhruva Gole <d-gole@ti.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Simon Glass <sjg@chromium.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peter Korsgaard <peter@korsgaard.com>, Heiko Schocher <hs@nabladev.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Danila Tikhonov <danila@jiaxyga.com>, Jens Reidel <adrian@mainlining.org>,
 David Wronek <david.wronek@mainlining.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Daniel Palmer <daniel@0x0f.com>,
 Angelo Dureghello <angelo@kernel-space.org>, Yao Zi <me@ziyao.cc>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 David Lechner <dlechner@baylibre.com>,
 Bo-Chen Chen <rex-bc.chen@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780741114; l=1151;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=8q+6V3v/t4KVWJWeDUgX5pSNyJfiHHJbT+H4TxeQ8gU=;
 b=YRFy0UZSgU9Zwq+hvTwPcEf0CnyQIv8Ep95gjz6KOE93BGHRSbG4TEeIBC/aUTz7lmL7NvPpx
 dGmgfphnig/AlJn9zvyxdpWRYr8lOmUa2H/zN7LUX2fqbpqugz3IC5a
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=DIa/JSNb c=1 sm=1 tr=0 ts=6a23f4a0 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=vxxW598hLm64NzrkEJIA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: K2OL0qRpWGsDY_eaJa2TXRft6fOFETAG
X-Proofpoint-ORIG-GUID: K2OL0qRpWGsDY_eaJa2TXRft6fOFETAG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDEwMSBTYWx0ZWRfX/9PSh2te1MNr
 DHBjYoS/3bzuJU3xnspwXdn8HhPXlvXfx+JBQmYuEyKqSGWVIsUvrh5EvX9FZwUcWQMXc2iMI0F
 0Od7vl96EQLE3ocIsq8EJL7JA5zpV4Myp1Ht+g/jiBh4YnVGOlV4ye2C45GWcUbjfzfVUiwYiHo
 Bfai/phfbBNvIoLcFPo3ShfbsirT2W8WdC7hUTBVjPDlGoPJVvNJFRAT8KpkTxk4M2Zo6e0+O/h
 xnDeOP05v7b2TpjwHQyC6GvPftCwTVUtbncSQZyDmuDdTxcjC98kKG+YXhK420v873yH2uM5d3m
 57evigFxvN6bDY0RaprrVlbRv85oP5NoRfvNYwWIqjB4EHPM8m7JBZHLh/bNLmPHITqojjfcBD9
 FHKOV95xOXH618ifaSppNecD/HmF7R/8QHFuwc39nWzAk26ZOKmyZtaEAwY5+LUX1UApKse+9gB
 a5V/59MQGdQIL2Gdo8g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606060101
X-Mailman-Approved-At: Sat, 06 Jun 2026 14:46:23 +0200
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

drivers/clk/Makefile has a obj-$(CONFIG_$(PHASE_)CLK_STUB) in it but
there is no SPL_CLK_STUB config defined anywhere.

So, add SPL_CLK_STUB configuration option to enable the stub clock
driver in U-Boot SPL builds.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Modified the commit description to explicitly mention that
  drivers/clk/Makefile has a obj-$(CONFIG_$(PHASE_)CLK_STUB) in it
  but no SPL_CLK_STUB config is defined
---
 drivers/clk/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index c2da7b3938b..ca69577c060 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -114,6 +114,13 @@ config CLK_STUB
 	  Enable this to provide a stub clock driver for non-essential clock
 	  controllers.
 
+config SPL_CLK_STUB
+	bool "Stub clock driver in SPL"
+	depends on SPL_CLK
+	help
+	  Enable this to provide a stub clock driver for non-essential clock
+	  controllers in U-Boot SPL.
+
 config CLK_BCM6345
 	bool "Clock controller driver for BCM6345"
 	depends on CLK && ARCH_BMIPS

-- 
2.34.1

