Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 824DCCD98DE
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 08:36:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CCBC84951;
	Mon, 15 Jun 2026 10:35:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="a4juMXwu";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HFPTPMz9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2EA884704; Mon, 15 Jun 2026 09:03:05 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 912F883FEE
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 09:03:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65F6IuEF3332546
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 07:03:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EoA8fP41oEX6xD60LiOis4BE1LhPXZJ+BOpQJ8/57YM=; b=a4juMXwus0v2M0/g
 EMaarg+pn1kMUbHKYO44FD6SbZ92VxmKh0LZYANQ1+KNbd8i2NZniuADA5l8upll
 UT2X+g1QpSobon3zEhu0GEnPCSeR8VO4cshBU2BuX+qcocnygrHAsKcLfhf5leQC
 8seOmAFIGfUDaBigum0R+15Lww1NLcb3n6Z1/tUoTJ8vgJXCGo6lZ5TS9ql1Ousf
 icNFPdP5gqFQEdki1D5M9ArQ7vYInbDerH5O2ZfcwUuymEPO9L4xlTYrxK/TUy/6
 WlYZzFu5nJ9ho+OsJhPyhNygaQHstvC2NfBBrBL3OVMU33TCcrELSTGcaYDZtlHl
 e2xNiw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4erye164xd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 07:03:01 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8422ca754d8so2287955b3a.1
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 00:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781506981; x=1782111781; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EoA8fP41oEX6xD60LiOis4BE1LhPXZJ+BOpQJ8/57YM=;
 b=HFPTPMz9u/dUtKNnUf48SQQ69HKLJVobA9exEwG0smLpYFImxkqookdxVv9mLihrER
 ARrZ8mk6Z83pbB00/qrdJarpMw0MGe0y3qcUl8WlOGkuXkeyH3zJp22tv0dYARyY2OLP
 N3RrM4Oh3Af1g7o5aB0LBATGprY27+FoYIfVGyJ6Kb3qlZRiJ+MmB6yWYLFvYbwrH5Dy
 mRo1AGZ5De9548lD2daXmF+XIH1Duyp9ZQKF42/yXdQhZ5rZzLuOKS+iKbQDl9qGiimD
 73a741VrnKa0b6Lj8zqVLWhQN8jIGyr5sENOJ0fPdY32iggRCJo0O+gItgPmUYKCirwf
 4mCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781506981; x=1782111781;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EoA8fP41oEX6xD60LiOis4BE1LhPXZJ+BOpQJ8/57YM=;
 b=k5Qa4ic0w/TpKXW3E69qLVZOIC4pCwISP6kzMoFpASRKCsJWu6r3sR07Rky70XY3Lj
 AiFXPQ0nsdSUnwRNPvCIz1UsWzxo7E75zA/wQxiAAmeAFklVxtRaLPdHzJT3HsKeILeb
 k21wwH82vKsutie6o6WxYdUHcA/8TQfreV9j32UNn7csoabMyHdYoyAFiqUVeBwAxk7I
 QXqRugmT3nV+ySDKiPt4IEf/6CrFJoUyYhI4gpwEtircDQoAABXwZUqFxujzphMsUOGB
 z5f/O7HYz26a5ozrvaeArP80qXNxVSLPFMs1uAqGrWO/FVqPFpTu1OdK8EV7qUViPHFP
 lIWw==
X-Gm-Message-State: AOJu0YzHkjzHUecTeUQRJQ2Smi1uARkGhXjxOhD9PdcS6bGzjHFvKjwq
 q4NACn6xSDC8Cb8lsnq0NPM/kjvVu2e0mPVEsoBR2YdZGSD25wydJt+SmZaUjhCloRUmkLnu5Wp
 XulsY4nEsHa8cYeVWsvtZBHgZVO2C9S+mnFl3A+L3GIhkozLjzjDRdbE3
X-Gm-Gg: Acq92OGFKyZVAwBwFkgjrdQducWmq0qrYZLA8j0D3PQ1hAId2Yyr3xkmwUXyhiD4I9U
 k7lww7kgcLqZXg3voXd4kVxE67N+rlUmV7pocdgnwaBfCUV6DxbB9XAFcaA6qN8Xzl59ys49GEn
 x9v4anD2s7ex6HM9rEH6P9PeGmX2fiL4LNpVIzQzKHlckkn/wsrE1J5RQtgJCI7EyncfRdXdOTQ
 ZOHthRLIC7aNCzOyQeNDZf2aPUFUxyFJxibNPHotGKWC8tInBEpUsuLUd9zk7UppjVjnL2isgrQ
 ELaAgQq2jjvIYHiDfDWJ6qu7gExX7Dpx/JiljuMEfiuj9l4jciPg5q7JPPAokpQY2fTDvqsRAhb
 kOC04n5l5PzKO1ii6MTRosP3XoHsIoc4YPd9x68UAJvQUmO94xFfGWUq4jImMHOej2SbJ1JdP6U
 fuI20kIhT1I/5OoNdQMOopQ8CDXoe+g+DwBWv3HgNDBOynRZdsTQ==
X-Received: by 2002:a05:6a00:4c95:b0:842:7476:2376 with SMTP id
 d2e1a72fcca58-8434d0d9c41mr13372105b3a.41.1781506980572; 
 Mon, 15 Jun 2026 00:03:00 -0700 (PDT)
X-Received: by 2002:a05:6a00:4c95:b0:842:7476:2376 with SMTP id
 d2e1a72fcca58-8434d0d9c41mr13372043b3a.41.1781506980094; 
 Mon, 15 Jun 2026 00:03:00 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434aca3041sm9226124b3a.5.2026.06.15.00.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 00:02:59 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 12:30:05 +0530
Subject: [PATCH v3 09/14] clk: stub: Add Kconfig option for SPL stub driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-spl_ufs-v3-9-360bceb29596@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781506817; l=1000;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=RfqX8lp7KZbrDYCyo1FK7QWMGkpIfSXrkpwN2M4e62o=;
 b=gstb0WH+/xIyKcKPyfDyWAz7IBRfwm5COKbDLiWja5LbrTIHpMaKCj7a8MMqbV1Ul8qT1VN88
 mTITk3nw7t0BK+PmOo4k2Nb8DP0/8UkAn2kVpjjUgRTxmd4r9DC+7K3
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: 6_SMyrYeksL4-S-dZRmX48pYyN-8xoLc
X-Authority-Analysis: v=2.4 cv=MNlQXsZl c=1 sm=1 tr=0 ts=6a2fa3a5 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=2BniLsY9khmVz6fdv7AA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA3MSBTYWx0ZWRfXzok5kNPAbnYE
 tP7+aZj/Rwfq6dm0t9JZHOdcnl74KaI7nxahRoVlwxsNwh2tmIHWHq27jk2U8lNYvfHgdnL0msg
 7ByIG2+/s96sNDIGQYvXAORxd103Wmo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA3MSBTYWx0ZWRfX82Tm+O1zjdyp
 EKLNLcHtyppW04mSAHOnBCp9dBHwUvmloB/AmWA25x3G5SiyiWP+bYCvbA/3c1jHFmTiJZByR4Q
 IDBevZ4iNQh+iJNkYZ4sw765zxJ9z87ER5fmoD9lcYkM8REcSxHhXL1ubacp/zTcnbEyrtzygkC
 EZOolPRn4QvZUiorpstq6Dr7gJBIE3COT3FPsm6kD0glud5+3xi5NuOoEe53NcnYsgdmz+u+0vt
 O7MD+snjj9EK8StUuV+KEA6GAkamJRfBQ0Aa5AlD+ONOA4cwhO0TezcLR9pwnaCoqec3Q7hVU6X
 GWNJIy0v+NxgTmzV3a+JCf4Zx5PiZVvEZ/SgkIf2svL0Wr8j1835TKlL9XINfGEAkLgxagxFwGw
 DyEDfraUaBHC2cc9/ZNNg3nt0uWklfNYIhrRCKYbNnfTY8/y8SszdJJ3iaWhP+2UGxZqDpaQqd4
 XkPnD04j95Tgi/11uMw==
X-Proofpoint-ORIG-GUID: 6_SMyrYeksL4-S-dZRmX48pYyN-8xoLc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0
 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
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

drivers/clk/Makefile has a obj-$(CONFIG_$(PHASE_)CLK_STUB) in it but
there is no SPL_CLK_STUB config defined anywhere.

So, add SPL_CLK_STUB configuration option to enable the stub clock
driver in U-Boot SPL builds.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- No changes in v3
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

