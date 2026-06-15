Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7F7CD98C5
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 08:35:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD9738488A;
	Mon, 15 Jun 2026 10:34:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="R7x9TtYR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NH6llKB7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E62B984704; Mon, 15 Jun 2026 09:01:11 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBBB983FEE
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 09:01:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65F6KZU93709657
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 07:01:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ILmnPNd4WCt50z+CuhfPNfvRZoImPJBCjkCkmCUk0LE=; b=R7x9TtYRvi4r34M+
 lkijwY89d3E81Xr9F83m5je2ngW1xt9Rzbyb6TQuMowolucSRLVPovudMAC+w+qO
 kCD4uknpe7nz1QISYznBxWdv1f/+oYf02WShCJkYSIsxJMDkKmCFa0xb/rVTeS4U
 0U0ELEdZmIkSQkqJRZiHEMDMLg+5RwkhjxCHyZhyi/xaJvoodpO53ehprF3rsaYS
 3qEtyAtaH3DafA/MvVTHBgbJXFQvDfs26JowT8pofmtq0S2+VWxj9vHTPcuutZfg
 kcgXmDXfC7SgE494pB04HdYIET8FQzAPPBzpgcPc2uzDp0whLb5ectw/HXEf7KBn
 1vyTkw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery956359-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 07:01:08 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8423f1fe39eso3782797b3a.1
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 00:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781506867; x=1782111667; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ILmnPNd4WCt50z+CuhfPNfvRZoImPJBCjkCkmCUk0LE=;
 b=NH6llKB72Ux3Wc6oP8paxAw98wBmIRFvM57iKAxnEhz07ENrGqYWGu1rXrrZBQR3oe
 a0AbEB+DdaAWCxWVsdm8AqioBe4f9oBgV3AKfghbXozuFMeg1DA2QbIHf9bUQjp3PpPT
 PC1Xv7nv2S8iwz8hDL/5ze6LcocSxhdDlkA5432rCRLOf9MfW33HwJ7KfrZqfJeY8n1t
 rjZwjaEBUuWUesIX2XUJ0l5WrhyDehhzh62cCq2BfDa8vxonxtqNW3zAHXazn6F3ZHAw
 yeWPdS4j+zfzRfH9l0b6ld477EmH1p8l1gfoaGMI4zp0iZJ78g/tqm86FGDRoyAzpmhV
 kbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781506867; x=1782111667;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ILmnPNd4WCt50z+CuhfPNfvRZoImPJBCjkCkmCUk0LE=;
 b=UTMFaABSSxwsUjCYJEXMyLYCslnOTPDmRfu6xIz7hh1rjW/a9sjXqGuyGmiT7lZLtk
 89brMluY/JA+x8lTZuuDaLUiIgWiULYDOtWnuixqNulFh1VMa6qErin4sqwESOuS+rSf
 hDnp7NwY/ISi+lotGcHB8/4WjrJEJ36NlGl9dZ1NFn9hr8kgdFRcik0j7zENr4Zue1SQ
 rSYQUNxos4+Af4OrGuY+vCgB4JuvFph20sVEXTsUiTP5oKjeEBCbyy8B/4ItFCmVmE0v
 OfH0XUfShLuCqGPL5GIWmwyK/ym0I4esxQ8HjBWYDtpcz2hke65sOFxMOJKwlsVchWXL
 6I9Q==
X-Gm-Message-State: AOJu0Ywk2D+yprylOBr7eNr7CrNl/Nj4Lng0EhqApjUpQ8CCpPC8wXFF
 04d3zn1pxRw02aCqBKx22gQQXAuXHbfT2u54CTatXrF6Wbf7pm/s3Tnuc9uCmBB10H5qtCzwT0N
 s7VA5ll9ahSd06rYs0E0k9XVbBnye8onMLt4q9Gf9HjO4m3CSsQtawhDM
X-Gm-Gg: Acq92OG2Ywmp5URmV1pmbMfhaSagthPmfbHnuQr+uLKR4wuWo1gMT+NoQsAkTFGm5P9
 rYSOu1wEqiQ8yVJFvQa1GuKCJofMwWZDznDg0oJRQ5dH1yeFCq6IWgVqnDMXBdWNC3p7r378scX
 wcm9kFDUKEt4FjNC7sxcS2W/sa3YMXHy3fLbPAb4ffcCjSaUm5/S+RiC5HQGPbsURvcO/02Xk1S
 Uhdi5UxhP2BHA/eSQb1QN5wQ2br7WcIYIta5MJArXeqb4ywPUz9eqmTC+FLlh8wIzdCygn8XiTi
 WHVSdKKggYJpgawgrn46OmeW+6qi+Lhos/pyC6y805CX8Dg8IuALWPYT3nr8EHypjFo9UstJw08
 UzRLWQF3BGgRCZKcYXqOWvzr0F1cMR7Pmfz5mLxsouH8Szj8EpAuAnyRLNHfowjDVMyqusWV3yb
 mvd6hk2n8DLsA8pCafyI176ZKGcBhIrchuBcHJanKOQe5EIbF1JQ==
X-Received: by 2002:a05:6a00:94db:b0:832:e65:ddcd with SMTP id
 d2e1a72fcca58-8434ce7a608mr14209513b3a.45.1781506867159; 
 Mon, 15 Jun 2026 00:01:07 -0700 (PDT)
X-Received: by 2002:a05:6a00:94db:b0:832:e65:ddcd with SMTP id
 d2e1a72fcca58-8434ce7a608mr14209385b3a.45.1781506866054; 
 Mon, 15 Jun 2026 00:01:06 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434aca3041sm9226124b3a.5.2026.06.15.00.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 00:01:05 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 12:29:58 +0530
Subject: [PATCH v3 02/14] configs: rename SPL_UFS_SUPPORT to SPL_UFS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-spl_ufs-v3-2-360bceb29596@oss.qualcomm.com>
References: <20260615-spl_ufs-v3-0-360bceb29596@oss.qualcomm.com>
In-Reply-To: <20260615-spl_ufs-v3-0-360bceb29596@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Alexey Charkov <alchark@flipper.net>, Andrew Davis <afd@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Javier Tia <floss@jetm.me>, Rasmus Villemoes <ravi@prevas.dk>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Dhruva Gole <d-gole@ti.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Michal Simek <michal.simek@amd.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Heiko Schocher <hs@nabladev.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 David Wronek <david.wronek@mainlining.org>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Yao Zi <me@ziyao.cc>,
 Daniel Palmer <daniel@0x0f.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Julien Masson <jmasson@baylibre.com>,
 David Lechner <dlechner@baylibre.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781506816; l=1281;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=dsfp8ISaqJXHbzwW0NRhBIHoCZXYkfUNOfNrtXek9Gs=;
 b=keCVfrlbYzrErIfs5CWk39Y7oPLSDuU95op1vUdO2rxkc2YNrot73hfoCZzHhLIyVJ/fhEGGm
 HDvEB0in6+iAxEX1bxGjHmVkdxnil4wYmkC5ZvPph+ogogtWl1Hs6eP
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: IGjQzfod4LQV1fqKF06j2GojvoKm8I4Y
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA3MSBTYWx0ZWRfX4QLw5Am97Vml
 T4CHggflMdpxjGG1AJTNOO9Yn46luJRz7uFRNnwd6HaYo10ol45BrEyk+8X5yLNO5glYXtL56dE
 yyDtPaMz3B0I9N9RMH+cAIGZ4flw8SM=
X-Proofpoint-GUID: IGjQzfod4LQV1fqKF06j2GojvoKm8I4Y
X-Authority-Analysis: v=2.4 cv=EbP4hvmC c=1 sm=1 tr=0 ts=6a2fa334 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=Yvbya3M1uE0sRtRQesYA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA3MSBTYWx0ZWRfX8eL8j25uXd53
 fro5HlV81lZlv+L8HQGArmF0TSM5tqJMjkxcPUa7BeWFAtJn76Pxur8X+kpfrsEK8avYIu9Rkn/
 iOULMwWi2r8uaqduOoQqVKrFF//QMyTECYlgKCXc/Iqm0um9XWkn9adI4cLH81SOxmyNrS6ufoO
 FOh+fRTKVsadYc1K7W8HpRBs09JyVjpTcmotUlB9d7tZHxylfD02jkVfGqFsmcT2mmKJjv8W20k
 SsCVEzxc5EzxpT5mtK543TnJWGfVLDKwdJMI7VwNt5dYXfhyosqb2Zq9n5oj9dZjGjiSi/Znh9J
 fmFJ7BodiY7J/uXvUzzjNj1HsyTwAWCjw0xi5GLXye6LU7GgQrpIYkkJkurGnaKrQL0Hskk0rhK
 PiQfiloZgVeFVb4qudvXVqezpxCgRDDwRkGPREQVBdxYAMjVOEj6hBioKqedYbBYH5fb0hXKuwX
 dybthingNsc5E2z4y7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150071
X-Mailman-Approved-At: Mon, 15 Jun 2026 10:34:58 +0200
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

Update all board defconfigs to use the renamed SPL_UFS config
symbol instead of SPL_UFS_SUPPORT.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- Added newly in v3
---
 configs/nanopi-m5-rk3576_defconfig | 2 +-
 configs/rock-4d-rk3576_defconfig   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/nanopi-m5-rk3576_defconfig b/configs/nanopi-m5-rk3576_defconfig
index 88b6d0f9e86..edb71b87a7b 100644
--- a/configs/nanopi-m5-rk3576_defconfig
+++ b/configs/nanopi-m5-rk3576_defconfig
@@ -23,7 +23,7 @@ CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
-CONFIG_SPL_UFS_SUPPORT=y
+CONFIG_SPL_UFS=y
 CONFIG_CMD_MEMINFO=y
 CONFIG_CMD_MEMINFO_MAP=y
 CONFIG_CMD_ADC=y
diff --git a/configs/rock-4d-rk3576_defconfig b/configs/rock-4d-rk3576_defconfig
index 7228a9d879a..adc8761f160 100644
--- a/configs/rock-4d-rk3576_defconfig
+++ b/configs/rock-4d-rk3576_defconfig
@@ -23,7 +23,7 @@ CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
-CONFIG_SPL_UFS_SUPPORT=y
+CONFIG_SPL_UFS=y
 CONFIG_CMD_MEMINFO=y
 CONFIG_CMD_MEMINFO_MAP=y
 CONFIG_CMD_ADC=y

-- 
2.34.1

