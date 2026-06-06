Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29337CD8C8C
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 12:47:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B7F1848A9;
	Sat,  6 Jun 2026 14:46:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JbzOblpp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IQQi0qKF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 195268405A; Sat,  6 Jun 2026 12:20:35 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFCE6838BB
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 12:20:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65663vpm675783
 for <u-boot@lists.denx.de>; Sat, 6 Jun 2026 10:20:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nlTsIQ6yWgUzID2Vzj+PQ2WOu8rQA8D6+hoovkfgNX4=; b=JbzOblppSNGdEEoG
 n7KTRwMrQb+uVfWdLTFgWaQVBQiDqEeP6qhufIKm+RZ28zCsSzmBHlQJRi0txwfL
 LeeMdD502UtkZFzNPDvE2jLKjtCu8LWwEM6Gnnin0mOHHi5DTsUKk4S0dRxISYoN
 1UIqhfGKwtoWZDk9qKtVGND6F9axVT8ytgrMqCDhYQgD+EQrY7UhG4AUf8ACxNhS
 xFpT8pyUsxWCeGm89w8rX6da8MNwRB1iwztymVglssIFuvJ4KxPqGP2BT9PLfRg8
 fdpONZjcuMwnMPycoSSiz0ExBcHKXJfHyuu2pvatspGGy1XE0r+CaZetOJejKcP5
 K+73lQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emb4w0ynp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sat, 06 Jun 2026 10:20:31 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2c0b1bb53a8so22104595ad.0
 for <u-boot@lists.denx.de>; Sat, 06 Jun 2026 03:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780741230; x=1781346030; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nlTsIQ6yWgUzID2Vzj+PQ2WOu8rQA8D6+hoovkfgNX4=;
 b=IQQi0qKFmVGuD7H4fh58uSbf4+bRvm1FBfhQ9hF3Wj6UqBWrBjlKbOreMQbnb/VhSq
 C/lDSwCRnr3VWomBuW591dxkNXHp32nmtPDHITamV51UvAENwiR3MxGw8HH+kPrGB0lN
 e7GR1LWLCxRnWCLY6nV7II+SLwvvlb0bX4OCi5wd2lEEzd4YqoFXuYbZmOOcK9Gp6gbp
 Rqgkqf45LmOfyPBeu8ieKqAeex0yQnNpYMb5Y6xsSg1pk9hK9RbRqcqfsSZuAr9fIRV6
 /xbwrQ3RS55qCyET5IssavSyMXAvvhazwVQZywT2f8BOI9+9V9oc/yyStQK56V22j50N
 m8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780741230; x=1781346030;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nlTsIQ6yWgUzID2Vzj+PQ2WOu8rQA8D6+hoovkfgNX4=;
 b=AMrlpmwDY7UQylAaGJ3A6DzuS7wNWzPZHOB6rgr+l/Br5ezH7wDxXDuTpXcX+buF8F
 tNez664+rpXiJOo0bGnwSQJPwvTQMFiSLLqMs1BYq/JZafGPi0kRwNw1GiSYhl/azLfn
 gTh50Ic5Z7xSzwcGryCYDd1MXiYGtrEUQu1FGGbg1in0gzzHXXA6vJxf9IpK69pxWQJH
 ZnKwNz5W6q7R9vhY/r/qIgePR7lOT+t1yY7LezR3/tCbAVBcWGISVc44rGI91+gAOrjc
 pzddPqoZKfk7RKNt1sL+9e6tdkYJ5Qbnn8A7qadYbpfgibrpBtbqa+y6/Hhd56y2OaB/
 BDvg==
X-Gm-Message-State: AOJu0Yz0JGMFO09AL1AgeXaO+Rh+zEU3XMsUTE8Iw2VIs3a4zz/N+jxm
 uwaopYc0zESRN4os5hDG+Ec83MdsKp+zQgZp3Av1VccmEm+GbdcSHGHn6fGqDes7wsBzf4p1fg4
 hz8/0uXX6kY1SqfHid5bfvOYi5gNlTwbnF1rwKlyZeiSOnL9wG5kfWq7Y
X-Gm-Gg: Acq92OEQv5cQHN172aizaGkTe8feJZx2urUWcvUQb4Z6sszbdJnSKutFFkU2DdG9Gw8
 jTwM/BwP6KJDBAqJPkSSOEgHTC7/PiRZnlMnfuPiD/+5rotwT9tmi1jK7Fqy5A3hVINhmjdTrXJ
 ZV4KjDjuUWotVKpqt2ccsbyO6xqHojCTlhpgrPiErVCNO+t6mRt4GAxGXZdyi+3ClCvouodDSh2
 ElKuuHFuzJb4eXbWARECLsRPB4h2R+/YSNvxz0G8ahGufJcVwW4rVUtbT2y3hjxASqfk1enmOlB
 GiukmDdHNCRv9s3/Me2hUkgDckaf8mJBTC2+rdPN+0ctJavfYuc7eeTXKKZyxqaYfti3UwFOaW+
 lxTTu5S639pE8b23hIwFdO7Y0im2kwokhzEGXgk8JFtYBki6f3kaeF6P52iASpjlnDWfXwVu5zb
 ZLQYrhXZkKJj5PTe++iZGeF/u6eY/ZpxGz+z72XXAuQFCJSrV4m4EqyqdumhHV
X-Received: by 2002:a17:903:1209:b0:2bc:e299:4b3f with SMTP id
 d9443c01a7336-2c1ec80a4eamr57540235ad.10.1780741230197; 
 Sat, 06 Jun 2026 03:20:30 -0700 (PDT)
X-Received: by 2002:a17:903:1209:b0:2bc:e299:4b3f with SMTP id
 d9443c01a7336-2c1ec80a4eamr57539715ad.10.1780741229709; 
 Sat, 06 Jun 2026 03:20:29 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c16609ed97sm123124235ad.41.2026.06.06.03.20.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 03:20:29 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sat, 06 Jun 2026 15:48:37 +0530
Subject: [PATCH v2 06/14] spl: add UFS boot mode defines to spl.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-spl_ufs-v2-6-72fed24ef01b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780741114; l=837;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=ERzL7AcZ0w5SHVHvtZhCBY1/M8T580kBQqS2I/6V1/E=;
 b=zmcPsAUektewFal0NOAFh4eBZV7odVRuvyQMQMQy/ynnkpkpgV7eZti9ua2UunXwv2y8gqz4L
 Ch8CJhu3JEFDjhFF1bFmtr9cbLDmWjPt8nZ00IIKm7A0jqin8t8Jsk8
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: dGo-7Rre7oC5E0wRzL3vaZY4PE4IUhkH
X-Proofpoint-GUID: dGo-7Rre7oC5E0wRzL3vaZY4PE4IUhkH
X-Authority-Analysis: v=2.4 cv=YIWvDxGx c=1 sm=1 tr=0 ts=6a23f46f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=fyTQhs28pi4JXZ4CVawA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDEwMSBTYWx0ZWRfX189nqW9URyzn
 VZGgQPcEkgi+MlTscT1HbfLjbZwiDRc5uWpXLzrbll96wc0hjB/5QzAXQCRHZB0IfwqqOVnKxfa
 1jHsAVBfK6wrdVCgx0kMSPliGYUUziPbQQ/uxCz2Snf4mNH3Zt2rJo2MwVSO/CabLipgK77KMx2
 n5JZdJz33YC2XwHptCpneR+w7E9c+2vnyB1oJQ/3JVRUcN1CV02A7gk3WWUkL3KSxB1S7ZrRboN
 OVc1y6T+ZPFLgblKFPWXKQk1A78mcux2EZE2dgZkubmztupIAULPqBpgYdPoe7fL5zHe6lNr57m
 OyPLbqJzfcyS1N9ECl6uD+xLZd7yCjBYiGkOvvX0//STS7EJNeUljOZUPuInOviPRcJx/LumfJs
 HGxmdiFtUbzeIJXy8+IZYyYanNuNyd82Zcn34+Qysijz4UsD387nVY8jDgDOClAZPwMG+2FGqWA
 iMt5RQ9M8s4Z1mxdU0g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
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

Add UFS_MODE_RAW and UFS_MODE_FS defines to include/spl.h,
mirroring the existing MMCSD_MODE_* constants. These are used
by spl_ufs_boot_mode() to select between raw sector and
filesystem boot paths in spl_ufs_load().

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Added UFS boot mode defines in spl.h, as a seperate patch
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

