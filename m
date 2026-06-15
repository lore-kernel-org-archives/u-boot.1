Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E942BCD98DE
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 08:36:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54A3D8491C;
	Mon, 15 Jun 2026 10:35:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hNoedFuN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fsUyeGqQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6236784704; Mon, 15 Jun 2026 09:02:16 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31DAC83FEE
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 09:02:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65F6Isqc3346529
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 07:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YU2ahEcp3IFY8G9ffEEUdtTeet3sWjtV72U7/l6LciA=; b=hNoedFuNrA5TPQ2/
 yuh+VlOO+vbR1WwpVLfWwTCq2Qaoju2sfz/a4h+qZH3khpjFR3Y+5onpBrIuDl3h
 Qwy+Jg6yhOi3aSkPTwOM3jazhC4YYMXoOR9X+VbjQZlXv1TOS6og7NdC3gBEgfvx
 rW6MJQTfhnOE/XuA8QP/5a0/XOtbNjpBL/pM+SayoVWnZ/m3P54+gaXuUjWzwQ44
 reDx7NNhYktgppjs6uBG/MFVkXfn5SVCWpabr1oIsj7c+Q/kC14EIW5mT8EqXwDu
 MZ128bZGBGBmhCXySG+z3xrb4Ep3KuKNax7xriFgq0yPU/5k10gx220S5az0JcTo
 3uuxYQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4es0g8633g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 07:02:12 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c856470fe9fso1381873a12.2
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 00:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781506932; x=1782111732; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YU2ahEcp3IFY8G9ffEEUdtTeet3sWjtV72U7/l6LciA=;
 b=fsUyeGqQKkBG7F5V14F2O/wU26tnLN5OLg2ZaJ78SxMxKq4cWqJE4X4BTRdUdPX+Ij
 q7oFXxBblk4PikzU16a6w2skplBX0IL/e9M9kqRdgR2eKK5Y+Oz8dS+YxKO7F2zaFHpz
 TiCkxMIPNSP0bOb9n17Mm5w9+JuDfWa8bapJnAkkeTslgMMkdKBnunZw4zePDnZbmUoR
 VrHj1UjgU8v+Idgi+/CqU/21kelASPH90pw+kNCojQXOn12hejTcDASOOsS1Dt5zFYiK
 sdyZLOEj76ISxIrYd9Sx9eB9WFVQ1Mld/Wgd7o8a6iiaRte1QYT3iUsRJPeNzOvamU+H
 x3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781506932; x=1782111732;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YU2ahEcp3IFY8G9ffEEUdtTeet3sWjtV72U7/l6LciA=;
 b=oZThdu76l4JdtTbCxyrZfy1vOjT9oqEvmjF0csRXB0NxLuuD790T0brC9sFZzf1Sbs
 z0ZydEp16VNcaEjc48jdIwa6+SI71LdZimuJXeorZaCvvYLngofGOWGEnSQ38cGe9ock
 fkMbcOWCLFSeOyWijFYKKT9HHRavW5JXvj6okfCzxaAa5GcZe+GR5EC1CLwLPSyiulxt
 d+A79Lj4mjGZF0ANW4ry+m5BKXfT/B7LVuDWZLeN0YW1Icw52SPg9cR6KGnwLrKtZfrf
 InKoLruT7YIOqvd5zurT8sJyF6m8mvWRkk42u9FIPz6xyiiL9cQkavkn896Q0Znszh3v
 aQqg==
X-Gm-Message-State: AOJu0Ywvh69LhJ4NcXlMUKogNPX5MhswR6S0xSSnnwqLy1vXxF6yhjVy
 qW0j+G83HwfjIM7bI78sM/BadDA8zhX1KfArNdragttmvnYkVi25ffJgnVU1TzyYpn6RGwZugeI
 Fj9cdgCgO+nEL0GyStRR3tOLzp70pmXkJZz9/N0aQNJCMm17bV8TgexKY
X-Gm-Gg: Acq92OEazpqp9ISU1bCa+09gtMK6on1Yd0WtVv5HkLWiCKAigluNOdz7GIVC1/THNGb
 seUk0gCO38qAvK4c5cxrw68ho6Kb7e1nYDXr1hMPQxTE2eyX15hVyaiZeDWGyN51/DmNycz6xS2
 UyTAtmpC+cAMF8b2PqVr8UZLSrRWFhKE53aOfCuyf2tYi8QHS/KH9Ap/MlwrRTdx4qqU8RbUDoi
 RK1QCbrBcWTuzxBYlMwBERGikDKuzUss1hUDobrDe8Dkl+6dZJlZQTb4zfhXVpKJdbPzNSQGbX/
 bJl9t4svqq9b/R7/AHknwY+pcIDHsbgN6sc+Z5f4Iu6wtMxSWBrJYZKBVpCnfMOjdS0sL4jxL4M
 SLdgHS59To5AsKza4qkYCeGReqQNDby/4euNlu8b0mFg8mNDaTzT4qPA+Ow/YMJK/OK/3ARopJr
 WO6MYdDkazu5UJwivFqMv1OEgLZytIRtE9cPWpFfGxzm2RrJNabA==
X-Received: by 2002:a05:6a00:4219:b0:82c:e9cc:f61d with SMTP id
 d2e1a72fcca58-8434cdcaec5mr13245229b3a.9.1781506931489; 
 Mon, 15 Jun 2026 00:02:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:4219:b0:82c:e9cc:f61d with SMTP id
 d2e1a72fcca58-8434cdcaec5mr13245145b3a.9.1781506930995; 
 Mon, 15 Jun 2026 00:02:10 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434aca3041sm9226124b3a.5.2026.06.15.00.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 00:02:10 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 12:30:02 +0530
Subject: [PATCH v3 06/14] spl: add UFS boot mode defines to spl.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-spl_ufs-v3-6-360bceb29596@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781506817; l=873;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=suQsDD5Hp2N9t0w32JmHGqKCtgq0ZigKXUMM0IR6z6s=;
 b=kun/w7cdbuXnUJE/8vk19GiAdKYnTqgWQwGjCtFo55KHV1tmjaBn+9Gvyq/JVJFqrCfjEwAMP
 7w+NZXyWD9JC3yS+tJqp/G2+uB9+j5alTIMO+gMBidO+Bd0tNmc2sgz
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=OOoXGyaB c=1 sm=1 tr=0 ts=6a2fa374 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=fyTQhs28pi4JXZ4CVawA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: nx6lJc8XfUp7t7jNGaTDZDEBjbuqSimA
X-Proofpoint-ORIG-GUID: nx6lJc8XfUp7t7jNGaTDZDEBjbuqSimA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA3MSBTYWx0ZWRfX3jzTlxW4F5hd
 8oZrlmXLRn2aJq8ZEBY/LgkU1NJnbTY7X2EQGRGzfeUUxbhLZGKjZYqf4XRX1k09InP0T3113zf
 nLL+QGhrPC0fLgLR4fliuuvNMVijZlyAp5c1KlX3ApKUyawc0zHyHnF5k/tWL5HC66s1VspD/I4
 0XXO+Qk76NsmGGAry0plnNwVOfFNstzr1MYTKDIpyrCAStK52IrQ+Tai26qZQG58kCDEFXVhVut
 dWlMmzckZQSH/8SCe0joC+E7DIbRSrCcbMcUAb+9Va5pf+NTfiKcNAOV4LO/iJBbxi/Yuz9b2Yw
 sS4HpcmiiB1setmo7lsmqXrX4PvIuBISMBr6a81FFZ1GHuaGGAAAsfvTYDbJ4OyAxgmyefYRowo
 8v2UHUyduatQzFpwFjCAgKHEusiWm3OqQTqXp/9BqnBemZJzSE27xwiUaC7C/rO8Ga3lw4kF3Nq
 Pzfz+A0ifyjmcdyI/+g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA3MSBTYWx0ZWRfX0QCSczagm4Mp
 cFc86D7mNlVGoUGLfjMAvBb++7jJQlwTrnhbaWt8njt7FnM0m1NoG3wBPNyJ9k2oTiUXgLc6qwL
 c2Xe4lFjoJmtXFuwX+SvYSOdjTT59ao=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 adultscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
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

Add UFS_MODE_RAW and UFS_MODE_FS defines to include/spl.h,
mirroring the existing MMCSD_MODE_* constants. These are used
by spl_ufs_boot_mode() to select between raw sector and
filesystem boot paths in spl_ufs_load().

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- No changes in v3
---
 include/spl.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/spl.h b/include/spl.h
index 5078d7525ab..a617bc26c04 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -29,6 +29,10 @@ struct legacy_img_hdr;
 #define MMCSD_MODE_FS		2
 #define MMCSD_MODE_EMMCBOOT	3
 
+/* UFS boot modes */
+#define UFS_MODE_RAW		1
+#define UFS_MODE_FS		2
+
 struct blk_desc;
 struct legacy_img_hdr;
 struct spl_boot_device;

-- 
2.34.1

