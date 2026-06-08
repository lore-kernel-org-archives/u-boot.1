Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A7CCD8C92
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 09:07:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7543F83EEF;
	Mon,  8 Jun 2026 11:07:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GmC4ZCYw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pcgyta5B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7EC883EEF; Mon,  8 Jun 2026 11:07:20 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8100B84825
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 11:07:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6586OeUu2385877
 for <u-boot@lists.denx.de>; Mon, 8 Jun 2026 09:07:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 S/RxYWQyfY1YXg3QbGACAULV9wPqXGFXUbrAFhc092k=; b=GmC4ZCYwS+EbSoty
 KfsxwH6LoRXF/uU8ShvshhRpxkrEubnxkUKFFilwPV4V8ixQYNyHvvAKG9eWfiAM
 udlSGnx05tBl6OAJU1rCiXie7/AoVShW/pKR9vnFkpbfXrh9zSs1R3N23mVAutiZ
 PXjhbpYFkh1dVg3nwN2gCJe5n0odq4GxZjIiSqhzYXGxYXyCnSw7NFCcqypBRhvJ
 nbVch/CC9FrS05hiuKrDd7gofvRz/uzJwyywtgzmZHnuYidXxdCQATTqateOR+HG
 5+zsyY/8MbBwX1ic+zb1p7ewqMPuAqMYSekTv+G63YEh4t4KMt09fgQOnmu1fvdV
 fX9fBA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcu8xssc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 09:07:14 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2bf11699875so41571745ad.1
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 02:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780909634; x=1781514434; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=S/RxYWQyfY1YXg3QbGACAULV9wPqXGFXUbrAFhc092k=;
 b=Pcgyta5BTi0vZyUlpBBaO/iI+NwUCO0NhGIxnNzV7Bn1GmgLi8s/UUiFM4yo/aHNK2
 9l3O8OShxPL1y4yD79vb694+0UfBZWrOf/2PFbowlsrOvWdcqb/C3HCjUF14Dr7F43sv
 Ms51MxtBFwfJmDXhAeTAlzyVbF5hrLkt1agJoN1b6XBszEoSJFwWT4c4pDXcspUsRBNH
 n+HrNBiv/x+KUCo8ewEwiEWgNI5PAj9MaCx1mdUJKR5J1McEJSRW9u/55zjd1PHMqKDh
 MqdYCWfaIZho4GciasmPPryxoyclg9Qsk5Hav5fYQbzvcUgrfOF26PnsuKgOGYgjALhH
 0RCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780909634; x=1781514434;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=S/RxYWQyfY1YXg3QbGACAULV9wPqXGFXUbrAFhc092k=;
 b=K7DWBm2dz1yuBDyhjTT1vowpyOvInM88YwJseJs923UE+2xadXr1w46rkdEH/F1ezH
 YS3Nw4prfWM8OTt1a5aOHHgen1Fq+qaIq8wgonSO9ZmcM52IWvE36usZXiS2A82qiAdJ
 w3tE/MWDhUkrskRTbdt9QCjnv3VvkbEQ9UY3o1gXO18tMRXIOI0TlRplO2Wfzanl3UhN
 /LItZmxXXzeDwhYsiHXSC4/HXvsce1SpvYVv4tTofr/aKU/+IMAWo3R0gQlzZJpnsCu6
 kg/y4bIbNNK0fnfLZXSvkYNaNHZEYGs2mUm1/qOtSa23fFidEGfwN2++ET2TO5u8hq8k
 iViQ==
X-Gm-Message-State: AOJu0YwYklyqqZVSRxytDScbyiXts0JQiAJPh6Q2i0r3bVBMyiXZ3GSY
 Zke6mwwplImHqGMlNf/dy93YVY8DsVe6aLdVK6u9nTGdFcJdfQ+4woZlrcMvqiWddB1ZBIgPBmn
 lLtPSEjcLsreFdo95lZhqvr/Yq5RyaLdlokI8Lge7WQTqbNQOuzkkETDN
X-Gm-Gg: Acq92OEmilR71drkJhiFewSbknvR9Zgx92lly6SUvG5OXzjuS1ESFAf/3qnZmEA6X5s
 3ISEG1blPKcSGYZPlmvDbgnAujUTjhX4yQr7hEm7Esr6rIFLa+1nBwO3z1GcIy2ajOEcBnou0Sf
 HvigjDuasHTgLivgvvDYava1wiitwqoEhdbJOc4JWDBR0J4L5oukLuIzVfATLpOh7Xf3deyIUqq
 4vLcVQ9huJFy0fwPTvVfC9yD4ckayVmiN4vk6Gs53598+x6vYwR9zlmDy0cOk2Y8qkmFX259wTz
 laAKGETdzpXSAP3L9ZflFw+2zfeS0WUlVM3+B+ox7yifrSh8PxKvP7LDdYueEgys5QJIZ9ryZOd
 Qy1bqqDmue0ihyR/QqKWGRtN8T6Y4fghoncx6DeRvhl1iqFI6WUocQVRF7PeZ2LZeTQbakx3dAC
 Pd6ALO89x8kbYiL+eV/LbNH1BeQNH3Hg0fFMJwKvD0VD7CXTk+bGMuIauaWJj5
X-Received: by 2002:a17:903:8cc:b0:2c1:6ed:513b with SMTP id
 d9443c01a7336-2c1ec94d1a6mr135636705ad.16.1780909633719; 
 Mon, 08 Jun 2026 02:07:13 -0700 (PDT)
X-Received: by 2002:a17:903:8cc:b0:2c1:6ed:513b with SMTP id
 d9443c01a7336-2c1ec94d1a6mr135636335ad.16.1780909633229; 
 Mon, 08 Jun 2026 02:07:13 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f8679esm169309335ad.21.2026.06.08.02.07.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 02:07:12 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 14:36:31 +0530
Subject: [PATCH v2 4/6] soc: qcom: cmd-db: Allow boot without CMD DB data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-snagboot-v2-4-036bb0343bf7@oss.qualcomm.com>
References: <20260608-snagboot-v2-0-036bb0343bf7@oss.qualcomm.com>
In-Reply-To: <20260608-snagboot-v2-0-036bb0343bf7@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Anshul Dalal <anshuld@ti.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 George Chan <gchan9527@gmail.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780909590; l=2573;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=x9UjR+UXdMmSGMWBqOG1v9yG7EJo4oSO+zHtgrZ7i9M=;
 b=jXG7+iFBLKlJy5QiB9PhedMORU1Os4Blw0nhByv/WZOr9frW1+JjmUG3wgUAQl/gJsPOKjCbh
 QqMb1Csy7xJCjGl6C4uBaCqEgwm8MFPK8+zzlzvhOO4BQUCvIkIMkTj
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: h_80lUm_SokzxRY09SEsiSfYMNNk2tBB
X-Authority-Analysis: v=2.4 cv=deGwG3Xe c=1 sm=1 tr=0 ts=6a268642 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=VT_t5Kp36RIPchdbbsgA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA4NCBTYWx0ZWRfXw+S4d2t6pjR/
 7ZDLaxFt+2cG9bgceOjU1n+aMRImUrWmkVciQHWHH5GUk45/1dPtq2yyc4a9smO/k0CaFl20rNW
 LiOeMSe5MhHgs2PCCQtIURZHmaesyNePc878Y6MJgI3/66tIumcG7I/G/4EVWNRBJ6Q6Aa567I5
 ZykSZ6IEkEbvueeSU0UqFAVl+sABxMqlvGpdmIOCWKkkwN22d8ZZkeiLLYWKygHGnr9jgmTwsQz
 Vi8sVi7Q43lgYPAwQAJ0BcwJ1uTymx7c/7IoH/tl/yc0ftOjdJRXxwNjmR1Vg+PQCtNeCpColCL
 01w9/Ryfx6of4z3iv5OLac8I4uu52HWYcafkU5rvoltJTS5tRcdTh2BKeoWC01Vu87QR0utXRkL
 wmvjVCgP2B2FVKgeswTUt68wVOjZI1xKOqkYppYCYzL5jrbsdizEvz+Vn1RgNmp34GUD1NyU5us
 +yNhRX57IKX1VE1iPfw==
X-Proofpoint-GUID: h_80lUm_SokzxRY09SEsiSfYMNNk2tBB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080084
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

In snagboot mode, XBL loads U-Boot directly without populating CMD DB.
The cmd-db driver fails to bind when CMD DB magic is invalid, blocking
boot even when CMD DB is not strictly required.

Add QCOM_COMMAND_DB_OPTIONAL config to allow the driver to bind
successfully when CMD DB data is absent. When enabled, a warning is
logged and cmd_db_header is set to NULL, so consumer drivers receive
errors on resource queries rather than preventing boot entirely.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- No changes
---
 drivers/soc/qcom/Kconfig  | 16 ++++++++++++++++
 drivers/soc/qcom/cmd-db.c | 10 ++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 8243805e46a..239d87e044f 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -18,6 +18,22 @@ config QCOM_COMMAND_DB
 	  resource on a RPM-hardened platform must use this database to get
 	  SoC specific identifier and information for the shared resources.
 
+config QCOM_COMMAND_DB_OPTIONAL
+	bool "Allow operation without Command DB data"
+	depends on QCOM_COMMAND_DB
+	help
+	  Allow the Command DB driver to bind successfully even when CMD DB
+	  data is not populated or has an invalid magic number.
+
+	  This is useful for platforms where CMD DB is not populated by
+
+	  When enabled, missing CMD DB will generate warnings but allow boot
+	  to continue. Consumer drivers must handle cmd_db API failures
+	  gracefully by checking return values.
+
+	  If unsure, say N. Most production Qualcomm platforms require
+	  valid CMD DB data.
+
 config QCOM_RPMH
 	bool "Qualcomm RPMh support"
 	depends on QCOM_COMMAND_DB
diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index d0a6047b8a6..b4682d811f7 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -252,8 +252,18 @@ static int cmd_db_bind(struct udevice *dev)
 
 	cmd_db_header = base;
 	if (!cmd_db_magic_matches(cmd_db_header)) {
+#ifdef CONFIG_QCOM_COMMAND_DB_OPTIONAL
+		log_warning("%s: CMD DB magic not found (0x%02x%02x%02x%02x)\n",
+			    __func__, cmd_db_header->magic[0], cmd_db_header->magic[1],
+			    cmd_db_header->magic[2], cmd_db_header->magic[3]);
+		log_warning("%s: CMD DB data unavailable, resource queries will fail\n",
+			    __func__);
+		cmd_db_header = NULL;
+		return 0;
+#else
 		log_err("%s: Invalid Command DB Magic\n", __func__);
 		return -EINVAL;
+#endif
 	}
 
 	return 0;

-- 
2.34.1

