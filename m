Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0CFCCD8C92
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 09:07:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04E7284825;
	Mon,  8 Jun 2026 11:07:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="b7afuMoS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kUyZ60q5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 822F684869; Mon,  8 Jun 2026 11:07:35 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 180C6807C4
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 11:07:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6586Oeat2385883
 for <u-boot@lists.denx.de>; Mon, 8 Jun 2026 09:07:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GBqCZKs5Fs/PJcTrUkJRPy/Nr3/EOk9wUq+UUfT2g3w=; b=b7afuMoSu+iDcDeG
 fNPKvKp/82bqbcMb2ScHT8+6zdphc54g8qSYb7eB5gtty0arwEdiGZT0XR5P1Fti
 y48toSZvAyhZnrEgXaoIjEyMYOIuyh0UkFfN5+oc83ch9yawq47hhWUj6yKHp5ef
 M/Ta06h6iZYonHarDkZVpz0acRdi63dxGFAlG5fmJXMBq9TduUzk8QBqz1zY9V//
 Zu+ftRzbW8Fd7ayk7m7LGtFDbrcN0D2jcQD2qCWFZThj8XJpgKED0yNaZQDh3KXU
 kZoEQRe8rZsXDp3U/IaghhJoIQhYBzmXqOZU49QGwp3zIkCTixzAYUzw2jXQ5wi2
 5mEwxA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcu8xstv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 09:07:31 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2c0c272e532so43688475ad.1
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 02:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780909651; x=1781514451; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GBqCZKs5Fs/PJcTrUkJRPy/Nr3/EOk9wUq+UUfT2g3w=;
 b=kUyZ60q5oERZFTYMdfFmRFJ82ovG6Q2+Us6Q4r2bKV4hVEVTiawyHdyVvDpDiQ9RXo
 BL8MQhY1if+XuifVjXi72KkpiNcA1sW2WGq+qS2lwTiWmNBu361xYJnZ9ruO18IdbvSz
 SdrUIUrx4RI6JUlqcfgZY3TFv1XU9HCyRWWdwsPYVVfwPkFq9mDCJYCp/H61+1k5DKRu
 aSlAfMmfHQjf6faSwhd4sMT2ftNWmuoVcGyDOaPvifVpQay2FN/0jfmtZsNl8Tr8PkGm
 UvcLzHJ4KKpxuxrry5MWXVd47QRPM7GrJJwHd9EfEjzXM030vSMJ7Jm5ys518p5aELlf
 dCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780909651; x=1781514451;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GBqCZKs5Fs/PJcTrUkJRPy/Nr3/EOk9wUq+UUfT2g3w=;
 b=GNWdMFU9cUANPoazchq7ZSQOaJgpAvoAx0HqsmdcCp3jWaFXOvBDf7L3rzWSr3fqg7
 tx50ocviPO67MV+9OStf6PSJ5IGOLlCQ4/IW4xjQyg3kLQkistNcT+YS27WpewneNr4Q
 abP3mljtZR7WDq2/2Likbo3pS9CR8m650BJ6XRNSkKKIBIvTzvdwjdC7mllQVKumJoKA
 RWyz20aKLikILf5Z6RaMTCA2PAF+0xl+M5mZ5xmb6Q5zyjU43+fFPjLiORCfqqgmC0xI
 cL3P0ARnaiO5PH2Ira6nfuGRCP0lg8fPayzORISKVaawsdO583fdtstBd7rFhOxMrZBA
 TGUQ==
X-Gm-Message-State: AOJu0YwPc/oaYH1EXN69UOFm86YL+Xh+eRjNpGLO6AuitHIfhwwUtgeR
 JO/I0SY6T8RcSnymn4j3h0ioCwpViIGSYAkZvF5uys00gYUIKlEekR4Z8+ccPy8ydzAd/QSMQgt
 k6Axtu1xAjkOcIPCO9YI8AHH0oj/yxrWt+ePSNFyso5Nd1d6RT9MXTH7u
X-Gm-Gg: Acq92OENURCFpr7lbVJDJn0DIUgcnUDlJGq+K3eoDwFp2fFD703nZ7TieeNrm1KiX2c
 5NVO2lYD/jpasip5yUGW/7HLKzWsbMVpti52Dz6y7egfYlcD1Um1SSisUGiAwJpZc3N+/yg/Hv1
 mUzFhMNPu7O2xfKMM4jm/F1EnWK62xojCjbk+Y3rvLNwtJdt6QvPOz0zqfe3jIsP8hF7fBZgWDS
 6Nu8A90W/IlAz0XoP2im6NfFZQ/q1wFET/trOBujkF1VvJjnm3UpXwt4QZYDj/8RylrMDpB/ZHm
 vz3SKXaJ8lslwcyIT4tiI3oII+nRredmeslUsgkMrqcvEjFzwJTBbYjjm5xT50TbdqpfXU8quID
 FkY/IWCe+zvVMQZvr60qm52DCo3flKtVb5XTRrHvqSeqQzxd8CllXTV32YulgbHUKqg4YjrTKw7
 QxhgIuXQDLN9PIhl098xEqtVVq++G/u+Bo8bl6qCDk2iReYkDIcchl9RExuOi6
X-Received: by 2002:a17:902:fc84:b0:2c2:50c7:58ab with SMTP id
 d9443c01a7336-2c250c75a8emr63303155ad.23.1780909650582; 
 Mon, 08 Jun 2026 02:07:30 -0700 (PDT)
X-Received: by 2002:a17:902:fc84:b0:2c2:50c7:58ab with SMTP id
 d9443c01a7336-2c250c75a8emr63302895ad.23.1780909650136; 
 Mon, 08 Jun 2026 02:07:30 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f8679esm169309335ad.21.2026.06.08.02.07.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 02:07:29 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 14:36:33 +0530
Subject: [PATCH v2 6/6] MAINTAINERS: add qcom_lemans_snagboot_defconfig to
 ARM SNAPDRAGON
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-snagboot-v2-6-036bb0343bf7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780909590; l=726;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=fKayP/0FdRldOMxY/wHHn2j5grww0XV1YJmnHv3/IU4=;
 b=vxnQGgTOQ/M2wRQeA8KBREBmtxUizY/9WZ5J7/6pio1Q3szIIbrun4aCdFfYBNbOv+vh0hvw7
 biZwAlpOCFnDP2yd46cKzFyeSicwMIFaJuWqUEg/7ReO17ErWJHFL2B
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: gDntv1ZPLGQX6ttDSwFf4s8rnIBGiZpm
X-Authority-Analysis: v=2.4 cv=deGwG3Xe c=1 sm=1 tr=0 ts=6a268653 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=YfCOm-DyAAAA:8 a=EUspDBNiAAAA:8 a=CRCQjptuof7Axi10-1UA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=zQLMK8awuJ6_Hvp-_9Ux:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA4NCBTYWx0ZWRfX3WMftWEQoqun
 I8DKrp81L+ATBjzQcRHAgfNTMbkSd68rYjh+XJlJzcIjSabK9MN0FnSz0i+XckeUIRVIKszlVml
 1/NM9VM4TInjR4CAxmd2uKW0uxuLYqcRhK9w3hyI0RatECbZdUmHDlR2ESDkksDcSVb1URabkd3
 FlC/kBv1TvgcC4+iyGfzYUZohHg1LYgPL+mxejrWY5JD3EGHHblZhPC59DFH/ExTILSIaCmcHX6
 Sa7+cUccYvaJyJpKCEayR3p+pP+UDQZMVEQV0ajxHnzOAobfqDxm87NiSO3yqPzdjkKKWk1NjdI
 igFPyOAUnT9ttiAzm0Bz/d6gxdMurwSUMG+oFJ82THYhDxTIrvlh9yR60tkP8RnmtHDBiFbGDNs
 rFbR73DH9LWLZSbvG/7jkn9FqFdzeNK23ydIJC8lRg7UBxMJO3WSKx3mW37ucUcdoeSWvYfHTdu
 fENV3ptSqP+PJwcgWrg==
X-Proofpoint-GUID: gDntv1ZPLGQX6ttDSwFf4s8rnIBGiZpm
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

Add an explicit file entry for the new Lemans-EVK snagboot defconfig
to the ARM SNAPDRAGON section in MAINTAINERS.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Newly introduced in v2
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 571af196465..d7507006d8b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -687,6 +687,7 @@ L:	u-boot-qcom@groups.io
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git
 F:	configs/qcm6490_defconfig
+F:	configs/qcom_lemans_snagboot_defconfig
 F:	configs/qcs9100_defconfig
 F:	drivers/*/*/pm8???-*
 F:	drivers/gpio/msm_gpio.c

-- 
2.34.1

