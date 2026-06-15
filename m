Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E451CD98C5
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 08:36:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9B0B84957;
	Mon, 15 Jun 2026 10:35:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nROCSs8F";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iArZSM3m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD2A883FEE; Mon, 15 Jun 2026 09:03:21 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2F7B83FEE
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 09:03:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65F6KbgF3910878
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 07:03:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 y2DYHzil/h5BSL6GkB7otpP1v/Y8BvzvdwHwgfkfw3w=; b=nROCSs8FHFR8drpn
 usuvS1NulK6tOwjomW6w5ZHF+eNTrscLGmF6+3jTVcxeVaxJk5Bdg7IqMPBR/dD7
 TffWJHJ+q9/M5oCvy7+EEPgvpLYKzJZfVghpIWx2d5vwWxI/lTH8pC2iuW7p3ou8
 puyjpxh8gTc879KezLeK3MqyYKRTH8LQg2qu33ISfPJrJ8PyfkNiiZkZ1JJ5T4Dv
 lOKxKRDpekYWiuC6Ox7V7GF2kYTLiGzgWZp9tH4bKG9DbO8HLpACdh54p5ADjfXm
 ABkj4ql/dTtlSCE8OaXEQ02ZwaaXXXAzqPumCSs9Z9dq8xnsSHhxNweS+RUFdZkg
 BgN2sQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eryc6x4rn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 07:03:17 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8423efdbe6fso1973475b3a.0
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 00:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781506997; x=1782111797; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y2DYHzil/h5BSL6GkB7otpP1v/Y8BvzvdwHwgfkfw3w=;
 b=iArZSM3ml/y2BJfzzMhFxVmJ7Isp9e/YXrycHTnGZ4pIN0i1T/9Ab12CX0VfmtK22E
 ebPZa+bR3sk2e8maM4J2lXPtcBurQKrGlI+Ev7wG08CrTatZEL/FHmbO1Gp/Gj/zAQje
 AV/SVyNM2G+Hfzsb9GM6cHBZ0oCfbOLsmGJ7gxsVFD2UNQPO0namrD/KLrsZhJ/bcFNj
 P4v89306ZfrIr/Eq0ezIoBjoMnh5+aUQstqjGRZdC6cqggLcLsLgpG8JFP+oP7QtTzUl
 G0MlGKRCdhL2EysOeh+4th2FEXi4cowl1htXSNU/IOJlATCAN63RiL8fZO08s6UW4TPF
 ugCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781506997; x=1782111797;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=y2DYHzil/h5BSL6GkB7otpP1v/Y8BvzvdwHwgfkfw3w=;
 b=BgUwvj/CTWK7eoBh9pvrH+iCycFGz2OUHtCOX8qJZD2VATNvfSYABVH3PGn0V8FnHf
 eMZhWpai8cGzGNmLQLXe92RUuoSONActLhWWHo4SbMPoWSNd9aXjvNOmmXMXNp9r/hgN
 ux7Y+4H/cblrXMGWn0Tp442HZBM34DrSnsWGQbWovrl55IP7X8Fs4XxApjURQlwHSxUN
 p91rf5NZqE3smCiuUiy2aoEVVBvjIOIwaFJcvoyCE6OXMQHvfeIQ4JxftPTMrcYVXaoP
 sVKkpTxtEwJOdaNRP8+DphmkOrDFSK8EbmikjSyLaaHC4cm1ji3ICstyd+qWSv+UCMh0
 On4Q==
X-Gm-Message-State: AOJu0Yy8tqZWwejDud3T9xmDiT2TN4CI0eIALxbLF0i79xZFIhSjWJRb
 o1sw68CtFEPN1To8dHGPJdNFOVuqMxq7joKf9QVVsfuBElU1wcFexkx8gskJ3y2iPgyEvK2ecMT
 tg8i+C9rMDoM7oc7whgpLnS1JFQBb/yirdkvWbzwpygplg5GUuSRl2J1m
X-Gm-Gg: Acq92OH1nYh93J/ZB6SU2tGUbjYS1n896kSyEXN4H+/96qtdgzsmqf5JPIGFZLmf7gK
 6OOrVbK90ER9qdyUqjs7mjyx5syoPPzW5cyUlbrhhbQCyqo/InKKYWedCduoUvAYpT1y9MwUMAJ
 T9ZshRooWAI7jtKxUe+OjqFzMPzFZ8Z88t/ZHfQON6COrjCkfqeEFCSVTNcmj/6hg4hGTbrednA
 O1euNP5KLvrdYPHu4OczbFzYxvcfyDO9i9xHI4O3vhHapZJcLul7v7peMuywfCfI5/GaCJoCIq/
 3Fe9jMLQ44kKnkbRVNK6mOjDiYcwYsGK3qXjCKD9Hx9U7xaFfC02XwyxUpVVLxBh+QOXFf/r+a/
 gio8vsX8UeinO1kqo6BP2iXpE+y9zqHcV82vesYUdTcS+L/JKhiAFjhfDAos3H5BtBtFl7WXH3P
 xDa3NL49cVVw7vZ1+FozJwPx/znQ7FYkBEe5ntuaoZF4IXderPgA==
X-Received: by 2002:a05:6a00:1151:b0:835:405a:7e72 with SMTP id
 d2e1a72fcca58-8434ce9e41cmr13543738b3a.11.1781506996781; 
 Mon, 15 Jun 2026 00:03:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:1151:b0:835:405a:7e72 with SMTP id
 d2e1a72fcca58-8434ce9e41cmr13543663b3a.11.1781506996266; 
 Mon, 15 Jun 2026 00:03:16 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434aca3041sm9226124b3a.5.2026.06.15.00.03.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 00:03:15 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 12:30:06 +0530
Subject: [PATCH v3 10/14] lib: update charset.o build rule to use SPL_UFS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-spl_ufs-v3-10-360bceb29596@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781506817; l=810;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=MfAexNOK7P7cE6lD07ZL0OV/pgu00tgWSuKonCNYDS4=;
 b=iIh4Mp6QldJTSh6Y0S6t4jA6/pgQLgZ+SeWOqlkronKMxlBbmifkjUcmfJETBkJNC+78Gywuv
 kxEs6rcks2CDKDMQNFiyB4c7TdZdIxaOdrJcqX5uAXXfb+BRS2wW2N3
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA3MCBTYWx0ZWRfX8a3VhEu0f3oa
 FKFXLO5AWe7RGcEzl44CQneEPRzMHIyIzrTgltg90p3hqf+MIFptkf00jG4IVW2uY953iMp4+NK
 e2YzIB/fVGsjEV3kHJrMIy9bk7HXoaA=
X-Authority-Analysis: v=2.4 cv=Oop/DS/t c=1 sm=1 tr=0 ts=6a2fa3b5 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=jAPzq1VG95-kpb0582AA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: JmL-cq-e9FcBe-vCxIsXsAhIUce0oaz7
X-Proofpoint-ORIG-GUID: JmL-cq-e9FcBe-vCxIsXsAhIUce0oaz7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA3MCBTYWx0ZWRfX4WmnsBAHQyy7
 HrIeStNkwz+u/HxmPRnb+NCwO02+9DEtEFAzWUFF5azjxT6rTHV6GYOv2oALNTnfnZ3vOmVRxSS
 NEo56l/y38qPuWJzqHHKwtHvryJqRA2iEAgYHGXvpSCEdVDcc8gjSrj5MqY7mPK2q9GbpcX2Z0P
 mJH/N2kpd5t0xPCwhvupTY4jhZgJLd6VxjjoAU+CmKCpC6gKaa8iO8bvH7DcQpgkHHMHWQCgJH3
 nQ9/x7lOxbK3dKrG9d44r/yPCZ3i+834NOChF3fSDWp5/ixC7Ab9SXybMm4T7rUsFBmV7+J4swh
 jLu837fEn2YXZ/KACTuBg5mZ7ElCLZTgvHMJWyg7G6EEEh/iNf1ZVLe2PAqN26zOKQZ1TUwuIYu
 //mEczPCVdIrF+J30H7gyhvjf5/TNGxxcNlg1+g7cgviTdh2Kb8igFmTyqNaJ9MGI0+19o1KvPs
 rn5V4p5uVtHVYK6Pf4w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150070
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

Update lib/Makefile to reference CONFIG_$(PHASE_)UFS instead of
CONFIG_$(PHASE_)UFS_SUPPORT for the charset.o build rule, following
the rename of SPL_UFS_SUPPORT to SPL_UFS.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- No changes in v3
---
 lib/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Makefile b/lib/Makefile
index d0ffabc2b47..807a459fb29 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -147,7 +147,7 @@ else
 obj-$(CONFIG_$(PHASE_)SPRINTF) += vsprintf.o
 endif
 obj-$(CONFIG_$(PHASE_)STRTO) += strto.o
-obj-$(CONFIG_$(PHASE_)UFS_SUPPORT) += charset.o
+obj-$(CONFIG_$(PHASE_)UFS) += charset.o
 else
 # Main U-Boot always uses the full printf support
 obj-y += vsprintf.o strto.o

-- 
2.34.1

