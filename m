Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 839E4CD8C8E
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 12:48:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83E7184940;
	Sat,  6 Jun 2026 14:46:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MrkY9F+u";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AxpPxhX2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E24998405A; Sat,  6 Jun 2026 12:21:57 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFF1B838BB
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 12:21:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65660jR5599660
 for <u-boot@lists.denx.de>; Sat, 6 Jun 2026 10:21:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7IvAobIfvsLLvQ3ld/PCAPR9nsRdHP4315et3tlu9R4=; b=MrkY9F+uX03ID+3z
 qQ9lRHvJvTCmQPSzMZYL20DUr1PZ1ZeBm9CoXquQYw8jyUMPAyKH8RtMiU2peOn8
 VIXkrVyldcrbcgNbpDAZc1G0D01/Zm2N6oM0pEmOIVTUE8mJ1ObdebbEpTywk+Mc
 F4HwAY4s9FBLzwWZN6qZ1T81zKKZXtFQmxNg22oC7n4Q92t/SRA0wYj4wV/VMTwV
 Hp90b6OKX2AtKhNDQInFbpgFaKdiW6O7JPrpIL9wsaZx3XR7nZRMflvKh46NoCnj
 B9J587IeSJIQzhwgOXhqzz4jSu86t1U30L1QtDsun5h+cugvfgXZKHQ6DWK36TZy
 D+MiIQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcqgrm3v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sat, 06 Jun 2026 10:21:53 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2bf243973c2so19443115ad.1
 for <u-boot@lists.denx.de>; Sat, 06 Jun 2026 03:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780741313; x=1781346113; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7IvAobIfvsLLvQ3ld/PCAPR9nsRdHP4315et3tlu9R4=;
 b=AxpPxhX2G8DU/4ZAsCVmoaOOJImFGY9rP3fLlrJ8SCQgGgN9e+dM/GIhX2YMnaUH3e
 JL93SrLZClay4I+MzqYjFF2vA8aYkKDiXOIcxBvmOrPs2OcCv/9mvd8RcgHS1CKQLWUd
 d0nXnCXJEkaNEj9g7FFrxr8IcpkLZ5St3B/XjPXXi7XH0NYJzMqpHvSKfpspFANwALgy
 uAxR+PWt2ZL11RFV6H8bKWkcMk7kyW1r/BXP8tKiThLuJQhRfWXjqOmZo8Ul+7v/pFJd
 m3BW5jt8/JSTCnE2smLAWn0uNib3UdwF0o4xGF2yUD7Pheob6BJfU1ViTEG2hy6wPRf9
 OChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780741313; x=1781346113;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7IvAobIfvsLLvQ3ld/PCAPR9nsRdHP4315et3tlu9R4=;
 b=QGfw1OuY5BIweEmlegmN+rapNOy8VlfsCM3LOQJUg41O+kO/Mm8zHmnuCMQthqho4/
 aRMqAQVhsQD5A9V66GVSX/t3eURdwEB82ByuVI+yBD6T3FjpFeY+rSjA1PHOviR4lBAE
 /Ibj3z+I0qtiI7Hh6D+D1bLTJiJbLc/gMqJg3sFRdZYtPVwaF1AbxOzWxXIYbC5GOC+f
 ZYLa2dTu+VttU7k/7eIExBwSHE4JvgpB3fU10XUxu9qFFhC9cBxtiTJ6k9XRu1beuhBI
 7weIXjrFya2j5dhyvbSRhraHJ3ZdiywTbPx6z5Qd1PUgV16/HWk7O1PEPbaDUEbA8/Jq
 4KTQ==
X-Gm-Message-State: AOJu0YxnHVgngK4b2yaME0hQ0fvYT4UmSmFBcuICeK4Nl2D8HGD7u6Kt
 U1h3wXLMEojbYRSNX1MHfbd/DbMVmukXQE5jXbajiaSAFGilIbD5Dhyl4q9SvWggVEj/+fQQKjB
 EemRXoI+uIRvsvuGre0xYZPDX2fKRWxhUtf4MB2kAOqeUxhKC1yfzkuFj
X-Gm-Gg: Acq92OGPQnEaMdiRmCNOk56H4B7Yax85KhFg1zdRKgJHeGrTnksd5pJmWueU5n5Oj8D
 1lwWQFrI2CZ06YGRTD/IPkECnboWYK3nCax/oOv2of7tpjCpbcICY9PLEt92z3qGKZtrM5mcCkz
 IESKfqw7QDWc9CDH7nPmObfjsksAMfuyPs++Y4bxSElnD8u6dO5VOOAPzk8lwiWek4ZhWI2+gEw
 BNP/NNs/Ncnl+xfOnlYnslKc8nc0ZLNOy/F++LtXgF/Wx30Y4KRigFvwBVM78uyqtaVFvQ3gBsR
 KF0loHiOPnNow+RtHsviSTigmc/5RkNw663CrYrUocLBboLZYcjR3OA04PUO2T6Xt//BalhZIOu
 nrtVf9QfKDMTmNZebiboAFoarEyW+msQllrLNeJuTNE79Y7alK5Wqb44/+cRY5jNpP+ZCcirsvi
 8kqWG7CVJRK07VIJz1zqUKle1SgdikoF4bp8Ngcj68yMCIdtVwJWAXDkBL2ZEk
X-Received: by 2002:a17:902:da4b:b0:2c1:f262:494d with SMTP id
 d9443c01a7336-2c1f2624a70mr68872055ad.19.1780741313114; 
 Sat, 06 Jun 2026 03:21:53 -0700 (PDT)
X-Received: by 2002:a17:902:da4b:b0:2c1:f262:494d with SMTP id
 d9443c01a7336-2c1f2624a70mr68871615ad.19.1780741312649; 
 Sat, 06 Jun 2026 03:21:52 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c16609ed97sm123124235ad.41.2026.06.06.03.21.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 03:21:52 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sat, 06 Jun 2026 15:48:42 +0530
Subject: [PATCH v2 11/14] misc: qcom_geni: add SPL support for Qualcomm
 GENI driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-spl_ufs-v2-11-72fed24ef01b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780741114; l=1752;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=Hq1alAqP799nbDh4RO7FWpBMG8LDTWeX3vP5RJDXZC8=;
 b=+Yt+9WDF96RtFymjrhd0a+m0idyAaE3hpELRJ+421hCpo8KfKw9+QncQzcjrC+VAM0EELsAwu
 fZPudS8fmmXB/uWInVHz/58ghOPEyZKxcHsIm9Ta2hMt6vJL/CXT6hp
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=dJGWXuZb c=1 sm=1 tr=0 ts=6a23f4c1 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=ydkT0emSJiMV-jbtYrMA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 80a_hvLANKgiGFqsCoT6TS9wXOlMbFXC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDEwMSBTYWx0ZWRfX849n++HmJcJs
 WAE73NqCIyeo4gBu9+HjtnpCEeQUSvfRF/2G1R7BjC9eU374YED0fnGsenh9DuEWNU1VOhxQU00
 AvN64P26en0xdAmA8QcArxREqNf7KrvSH3kYSLlYRh49eu0aLtQ1mpJhCeqIS6xs8sc4V9xR2i8
 PIA5rfqiEee6OYnBO/n3Lksd9krdJlIywgI5CZ73x+nVSRaC2QhbDw2bR4FyNnqnSe9wBb8VWN7
 botXXy8QCuBKxrAENOShKg+OmadsjU/gDZb6q3vcOdkb/mKkGnMGU9QcyRiWgwuJMbR7Gs2g5vx
 PxJG3f0xMwvu4VISBHkG843lOUqk3in+9SBGGmEUB6/DfiHrpJFmEI9xzf8qYz/rZE5wu26NhST
 L7YkP2BlsQPRoINsyK31v/7DQc7RR+Ynx2p+tgGHsrwzFbYZQgmpXGN9dN6U5ftqQRgwwPufngE
 wzerGPsOvjMXPRxmUzQ==
X-Proofpoint-ORIG-GUID: 80a_hvLANKgiGFqsCoT6TS9wXOlMbFXC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060101
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

Add a new SPL_QCOM_GENI Kconfig symbol to enable the driver in SPL, and
update the Makefile to use the $(PHASE_) macro so qcom_geni.o is
built for both SPL and non-SPL phases

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Newly added in v2
---
---
 drivers/misc/Kconfig  | 10 ++++++++++
 drivers/misc/Makefile |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index ea785793d18..0a186538526 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -93,6 +93,16 @@ config QCOM_GENI
 	  for providing a common interface for various peripherals like UART, I2C, SPI,
 	  etc.
 
+config SPL_QCOM_GENI
+	bool "Qualcomm Generic Interface (GENI) driver in SPL"
+	depends on SPL_MISC
+	select SPL_EFI_PARTITION
+	select SPL_PARTITION_TYPE_GUID
+	help
+	  Enable support for Qualcomm GENI and it's peripherals in SPL. GENI is responseible
+	  for providing a common interface for various peripherals like UART, I2C, SPI,
+	  etc.
+
 config ROCKCHIP_EFUSE
         bool "Rockchip e-fuse support"
 	depends on MISC
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index e2170212e5a..e0293193174 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -65,7 +65,7 @@ obj-$(CONFIG_QFW_MMIO) += qfw_mmio.o
 obj-$(CONFIG_QFW_SMBIOS) += qfw_smbios.o
 obj-$(CONFIG_SANDBOX) += qfw_sandbox.o
 endif
-obj-$(CONFIG_QCOM_GENI) += qcom_geni.o
+obj-$(CONFIG_$(PHASE_)QCOM_GENI) += qcom_geni.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_EFUSE) += rockchip-efuse.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_OTP) += rockchip-otp.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_IODOMAIN) += rockchip-io-domain.o

-- 
2.34.1

