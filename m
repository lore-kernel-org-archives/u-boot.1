Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC55C531D2
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 14:39:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D21360A48;
	Thu, 23 Jul 2026 14:39:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gmHQJ6-T__et; Thu, 23 Jul 2026 14:39:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0044F60A3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784817555;
	bh=r0asHuHtEDIOvtzG2JWitICI6TThEojsi30TcWyzmTM=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=Nq1yH1yXmw76NcUjWgqTJIrNxlT4di/eYRtCkU4UylFDIs1SYOXcNT3aqKeHX6HOp
	 yw7N3UD441HfUm8QxlMd5CtHYbrzdrvNT3KzTGGpE/K5+jgMtLlwSAtBogq9ezKVlb
	 +MOaOkeF6iEOhC97at/bi4n2WE0mqWeFiFMfPnDEJ1lUwPsjYzCIHhuZ/h1jt9vjnx
	 ZM4IjfPnAXWsD1ukxSIhpx7eqpNDnGi5zOPyfOQapfzlM6i8Rv7eWv/p/mBD3jbxfA
	 Dbms19TiLkf8XKUj51dJTldKWliihwL3W8Ru7zc9OyelL2g1iYYrdJbLT0WcdvbUTg
	 VTrbdBagL0kKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0044F60A3D;
	Thu, 23 Jul 2026 14:39:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 740BC4BF
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 14:39:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5366740A09
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 14:39:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ANrq-x1E3V7X for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 14:39:11 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=jorge.ramirez@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B2461409C0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B2461409C0
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B2461409C0
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 14:39:10 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1755E80117; Thu, 23 Jul 2026 16:39:08 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A656B803F6
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 16:39:05 +0200 (CEST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NCvYsO3954489
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 14:39:03 GMT
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fke0ksw4c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 14:39:02 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5174a236220so13556991cf.3
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 07:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784817542; x=1785422342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=r0asHuHtEDIOvtzG2JWitICI6TThEojsi30TcWyzmTM=;
 b=ePi9yYhHaz6gYlpzHuNjJnZP4a1xKsefpD+sESFeA3mTNuNN2PsplCu1d9et9BWwsb
 oJAYvluco56J0ZQNrn4nIp/oWeqNQrrmjlbc8SVCGG64TwcPoRHCg1jQAzVQfTc80Xyk
 lii1T7JO+WzDflFDKg9Mi08/qIFLi1HfK2/yGa18wEVd0HOzGtLHPN8+WLCDT4tkkK0c
 StRO1XWp3N7UmSbxDgHPKRIakX8q5QP3QfI8amq5sTWRWZyBTUJ4MQS0faq247T0Njx6
 ipZgZ2pcM2FpGmAn1L7dMPB9PV4Zgx6Er4g1xkjqe5LoVf2U/TW0qWGybavl6R5y7Ly2
 r/XA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqwG46eUS8GXsC5u/t8yVTZEaOD3eRMZ9E1zlZyQ82Rm59pZGnzgQHeZwUczvtVjGVEk/k+q8Q=@lists.denx.de
X-Gm-Message-State: AOJu0YwR5oKtJjQ6yPYndAxtC/Om5r/qZzMiWnTvO3GDMgjXDZXi267V
 uz4sQebkLqn/V0LImBL/uyUFHW3xfudMgavVvOqLDF3GWO/ktOKFom5xo03OrSFXyKf0uFCSOb1
 4thDuVtwMBm8a62+w8kPc1rRjTS45fh+2QquiJk4pUMXSnrvG7Z/Gdw2n
X-Gm-Gg: AR+sD12Br/XX1IBnbNlvgFd10i+7S/AQ349T/1i7aS/i7BUGarjcxPahfGU2vO/MQfG
 ZFKzjIEYkUI9ar66BUYgwkVE6Ucd2IxeG98Duv/A+6O1JHRthQ0t3nskQy0h52qMVREyDIAaui/
 KBGrv+HEXqNUQNoA4svJuk+Q01j1B8WztlkWzEWFwV5d2E0+6jFBLcH3GCtka9uecKq5n0yIzLq
 fA0MQgN/yqr4bk4RY8HbLAEFTKEzBR4ZYvSOswyAQPkOxl2NUbdvxQzxU6XBVGoqNakCg110OW5
 wkJsjBAh1RmQ6q1G2Uy6u/7WPw+Lv17+WE1N9g4W3SXXlPf5q8x0PV/ThArMeBU8YtFqdJdcqMz
 e/96qI0l9lPGWY4Rh9s4+XvTEWe4kh9yKtTzPnb2fQCfZldgkRhg=
X-Received: by 2002:a05:622a:1102:b0:51c:92a0:b2cb with SMTP id
 d75a77b69052e-5283de1bd7fmr30680261cf.26.1784817541897; 
 Thu, 23 Jul 2026 07:39:01 -0700 (PDT)
X-Received: by 2002:a05:622a:1102:b0:51c:92a0:b2cb with SMTP id
 d75a77b69052e-5283de1bd7fmr30679791cf.26.1784817541278; 
 Thu, 23 Jul 2026 07:39:01 -0700 (PDT)
Received: from trex (182.red-79-144-196.dynamicip.rima-tde.net.
 [79.144.196.182]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c67339sm16968193f8f.31.2026.07.23.07.38.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 07:39:00 -0700 (PDT)
To: jorge.ramirez@oss.qualcomm.com, neil.armstrong@linaro.org,
 trini@konsulko.com, jens.wiklander@linaro.org,
 ilias.apalodimas@linaro.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 bhupesh.linux@gmail.com, n-francis@ti.com, marek.vasut+renesas@mailbox.org,
 igor.belwon@mentallysanemainliners.org, shawn.lin@rock-chips.com,
 alchark@gmail.com, tuyen.dang.xa@renesas.com,
 yoshihiro.shimoda.uh@renesas.com, padmarao.begari@amd.com,
 jstephan@baylibre.com, hayashi.kunihiko@socionext.com,
 macpaul.lin@mediatek.com, venkyada@qti.qualcomm.com, j-mcarthur@ti.com,
 dlechner@baylibre.com, u-boot@lists.denx.de
Subject: [PATCH v3 2/5] ufs: add RPMB transport over SCSI SECURITY PROTOCOL
Date: Thu, 23 Jul 2026 16:38:19 +0200
Message-ID: <20260723143852.2287208-3-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260723143852.2287208-1-jorge.ramirez@oss.qualcomm.com>
References: <20260723143852.2287208-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Bc5qH_BcIF5d2fsQ71kgzwqURS0aHYSp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE0NCBTYWx0ZWRfX+8Tl71asA+dO
 JTuBT3aXqab6kt4HHH3ElcOgqIoUjnLCQBqZvVzglRdE2780o1s1xjqXUYviRzAR5BkPV6jCdAL
 l9jqIrJBSF/2qPX+l+lm4KcL8y/d7H4=
X-Authority-Analysis: v=2.4 cv=S7DpBosP c=1 sm=1 tr=0 ts=6a622786 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=2lELrtOEK2EaG96G7mOeag==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=opyxpeFzTCIEhlyN3soA:9 a=O8hF6Hzn-FEA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: Bc5qH_BcIF5d2fsQ71kgzwqURS0aHYSp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE0NCBTYWx0ZWRfX5cvbUThFT2d7
 BelKxzpulrSEsYuhJDevqS2ByPfsiBuikBzbXpRgKibn+dm5GjKhasrzoGXs/yl0BPxHf5ThjCa
 0ArN4UWjgdVZWJYBo6zBUQmDyWMyt74GoyKOMYjYrxHBa64DlZnmrFdMv6xZZG5b4Y1YXMato8n
 yjDC6+uCnx62cZh0rZPwEczRjomhpLogmlvq7pq72S2TLlVLjn4Km5SJ2jHJIKJKZTuxjk/84l3
 orqv1SLAzhGj6VbRAH+itfbNBXmSgNsvNtphjvuCBi5LobPc13SSjRwERKzBz/6+ZCJzjzOK3/3
 0rlI5ArNSmWb0d39yLgtgz418L+esnoQNmnI2tqFFB3Uf3d65krJcRzeChJdOYYel9JK6xQl2H0
 1GvrYgzSpYLQFtDu9GoLVQ1EYgytPvyyR+MuxSe9aiEAN893aQ5XRQOZnzYYTHiDOeiRSLWEt+S
 D4v1G/n1wMnQTSMw/hg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230144
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=r0asHuHtEDI
 OvtzG2JWitICI6TThEojsi30TcWyzmTM=; b=ioFt+9EplBHdj2lyP+RXjCorxBn
 TGOVLXSL/abt1beBB0B0HL8obHSxOluFAPILnmAhd+ilcDWkyvR192CkupE7dpkf
 JPFC6+S7C1AOQtY4ccDxKQxZ3jI/3FYFNzf8vzzXek6R9CNn5Da+eP4NiBSNXCIx
 wxIGRduZvkr+utoaAZBPPknTCfKLBLobCUT/nXzZXlNZ+Do4t1nWvnHYjne67OsM
 kUMvLDcSIWGQ6ldIjpKGzaI507BRLsF/bPTri251FHdy55wdtwc7Im4KC8G7+aPr
 4UVTWAzyWh5EAFtU2aJb6DbPwuVv1zJIE6wpALngRl/Pf6KPFF7sMe17vUg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784817542; x=1785422342; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=r0asHuHtEDIOvtzG2JWitICI6TThEojsi30TcWyzmTM=;
 b=j83pmilEGzbkF4tb6t27lVUG+ATRIr0i8A8uj001AjWl5VLN4jNXk02OqfDewlgWzi
 7cnnHL/lxiQ2nYW/1STKhZ6lkXBLSi5S/P6T4kIfioqDPWvb7K4OghDDyadjFtWpnTnO
 ki+NPUDBPT5S7aPD6ubyS0f+x5SmX2ZRjCQ3n5v62PB9e50wVQmWO1684JWqKx2SC65L
 JK2i75b5cEMBkULIzCr/XtwyKBm8DUyZZjv002pmHCqg2VzKN8AEre5XAWOZYc95p2VE
 9efomuZMjNw4nazQX27p36cFiuiOHjYRbOhR8N3/VO1elJITz3AfvfMtwwDLvrIbh8wg
 pSKQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=ioFt+9Ep; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=j83pmilE
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ioFt+9Ep";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="j83pmilE"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Jorge Ramirez-Ortiz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

OP-TEE secure storage (CFG_RPMB_FS) requires RPMB, but on UFS-only
platforms with no eMMC the OP-TEE RPMB supplicant has no way to reach the
device's RPMB Well-Known LUN, which UFS exposes through SCSI SECURITY
PROTOCOL IN/OUT commands rather than an eMMC-style RPMB partition; this
transport provides that missing path so RPMB-backed secure storage works
on UFS-based platforms.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 drivers/ufs/Kconfig      |  10 +++
 drivers/ufs/Makefile     |   1 +
 drivers/ufs/ufs-rpmb.c   | 173 +++++++++++++++++++++++++++++++++++++++
 drivers/ufs/ufs-uclass.c |   6 +-
 drivers/ufs/ufs.h        |   7 ++
 include/scsi.h           |   2 +
 include/ufs.h            |   4 +
 7 files changed, 200 insertions(+), 3 deletions(-)
 create mode 100644 drivers/ufs/ufs-rpmb.c

diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index 49472933de3..99160a0819b 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -92,4 +92,14 @@ config UFS_TI_J721E
 	  This selects the glue layer driver for Cadence controller
 	  present on TI's J721E devices.
 
+config SUPPORT_UFS_RPMB
+	bool "Enable UFS RPMB (Replay Protected Memory Block) support"
+	depends on UFS && OPTEE && !SUPPORT_EMMC_RPMB
+	help
+	  Route OP-TEE RPMB requests to the UFS RPMB Well-Known LUN using
+	  SCSI SECURITY PROTOCOL IN/OUT commands. Required for OP-TEE secure
+	  storage (CFG_RPMB_FS) on UFS-based platforms that have no eMMC.
+	  The OP-TEE supplicant handles a single RPMB transport, so this is
+	  mutually exclusive with the eMMC RPMB supplicant (SUPPORT_EMMC_RPMB).
+
 endmenu
diff --git a/drivers/ufs/Makefile b/drivers/ufs/Makefile
index e7f3c1d30c4..d60440ca119 100644
--- a/drivers/ufs/Makefile
+++ b/drivers/ufs/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_UFS_RENESAS) += ufs-renesas.o
 obj-$(CONFIG_UFS_RENESAS_GEN5) += ufs-renesas-rcar-gen5.o
 obj-$(CONFIG_UFS_ROCKCHIP) += ufs-rockchip.o
 obj-$(CONFIG_UFS_TI_J721E) += ti-j721e-ufs.o
+obj-$(CONFIG_SUPPORT_UFS_RPMB) += ufs-rpmb.o
diff --git a/drivers/ufs/ufs-rpmb.c b/drivers/ufs/ufs-rpmb.c
new file mode 100644
index 00000000000..fb4cd42ad75
--- /dev/null
+++ b/drivers/ufs/ufs-rpmb.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <dm.h>
+#include <log.h>
+#include <malloc.h>
+#include <scsi.h>
+#include <ufs.h>
+#include <asm/cache.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include "ufs.h"
+
+#define RPMB_REQ_KEY		1
+#define RPMB_REQ_WCOUNTER	2
+#define RPMB_REQ_WRITE_DATA	3
+#define RPMB_REQ_READ_DATA	4
+#define RPMB_REQ_STATUS		5
+
+#define RPMB_FRAME_SIZE		512
+#define RPMB_FRAME_REQ_OFFSET	510
+
+#define UFS_RPMB_UA_RETRIES	3
+
+#define SEC_PROTOCOL_UFS		0xEC
+#define UFS_RPMB_SEC_PROTOCOL_ID	0x01
+
+#define GEOMETRY_DESC_RPMB_RW_SIZE	0x17
+
+static u16 rpmb_frame_request(const void *frame)
+{
+	const u8 *p = frame;
+
+	return ((u16)p[RPMB_FRAME_REQ_OFFSET] << 8) |
+		p[RPMB_FRAME_REQ_OFFSET + 1];
+}
+
+static int ufs_rpmb_secprot(struct udevice *scsi_dev, unsigned int region,
+			    u8 opcode, void *buf, unsigned int nframes,
+			    enum dma_data_direction dir)
+{
+	u16 spsp = (region << 8) | UFS_RPMB_SEC_PROTOCOL_ID;
+	u32 len = nframes * RPMB_FRAME_SIZE;
+	struct scsi_cmd pccb;
+	void *dma_buf = buf;
+	void *bounce = NULL;
+	int retries;
+	int ret = 0;
+
+	if (!IS_ALIGNED((uintptr_t)buf, ARCH_DMA_MINALIGN)) {
+		bounce = memalign(ARCH_DMA_MINALIGN,
+				  ALIGN(len, ARCH_DMA_MINALIGN));
+		if (!bounce)
+			return -ENOMEM;
+		dma_buf = bounce;
+		if (dir == DMA_TO_DEVICE)
+			memcpy(bounce, buf, len);
+	}
+
+	memset(&pccb, 0, sizeof(pccb));
+	pccb.lun = UFS_UPIU_RPMB_WLUN;
+	pccb.cmd[0] = opcode;
+	pccb.cmd[1] = SEC_PROTOCOL_UFS;
+	pccb.cmd[2] = (spsp >> 8) & 0xff;
+	pccb.cmd[3] = spsp & 0xff;
+	pccb.cmd[4] = 0;
+	pccb.cmd[5] = 0;
+	pccb.cmd[6] = (len >> 24) & 0xff;
+	pccb.cmd[7] = (len >> 16) & 0xff;
+	pccb.cmd[8] = (len >> 8) & 0xff;
+	pccb.cmd[9] = len & 0xff;
+	pccb.cmd[10] = 0;
+	pccb.cmd[11] = 0;
+	pccb.cmdlen = 12;
+	pccb.pdata = dma_buf;
+	pccb.datalen = len;
+	pccb.dma_dir = dir;
+
+	for (retries = UFS_RPMB_UA_RETRIES; retries > 0; retries--) {
+		ret = scsi_exec(scsi_dev, &pccb);
+		if (!ret)
+			break;
+	}
+
+	if (bounce) {
+		if (!ret && dir == DMA_FROM_DEVICE)
+			memcpy(buf, bounce, len);
+
+		free(bounce);
+	}
+
+	return ret;
+}
+
+static int ufs_rpmb_send(struct udevice *scsi_dev, unsigned int region,
+			 void *frames, unsigned int nframes)
+{
+	return ufs_rpmb_secprot(scsi_dev, region, SCSI_SECURITY_PROTOCOL_OUT,
+				frames, nframes, DMA_TO_DEVICE);
+}
+
+static int ufs_rpmb_recv(struct udevice *scsi_dev, unsigned int region,
+			 void *frames, unsigned int nframes)
+{
+	return ufs_rpmb_secprot(scsi_dev, region, SCSI_SECURITY_PROTOCOL_IN,
+				frames, nframes, DMA_FROM_DEVICE);
+}
+
+int ufs_rpmb_route_frames(struct udevice *scsi_dev, unsigned int region,
+			  void *req, unsigned long reqlen, void *rsp,
+			  unsigned long rsplen)
+{
+	unsigned int n_req = reqlen / RPMB_FRAME_SIZE;
+	unsigned int n_rsp = rsplen / RPMB_FRAME_SIZE;
+	u16 request;
+	int ret;
+
+	if (!scsi_dev || reqlen % RPMB_FRAME_SIZE ||
+	    rsplen % RPMB_FRAME_SIZE || !n_req)
+		return -EINVAL;
+
+	request = rpmb_frame_request(req);
+
+	switch (request) {
+	case RPMB_REQ_KEY:
+	case RPMB_REQ_WRITE_DATA: {
+		u8 status_frame[RPMB_FRAME_SIZE];
+
+		ret = ufs_rpmb_send(scsi_dev, region, req, n_req);
+		if (ret)
+			return ret;
+
+		memset(status_frame, 0, sizeof(status_frame));
+		status_frame[RPMB_FRAME_REQ_OFFSET] = RPMB_REQ_STATUS >> 8;
+		status_frame[RPMB_FRAME_REQ_OFFSET + 1] = RPMB_REQ_STATUS & 0xff;
+		ret = ufs_rpmb_send(scsi_dev, region, status_frame, 1);
+		if (ret)
+			return ret;
+
+		if (n_rsp < 1)
+			return -EINVAL;
+
+		return ufs_rpmb_recv(scsi_dev, region, rsp, 1);
+	}
+	case RPMB_REQ_WCOUNTER:
+	case RPMB_REQ_READ_DATA:
+		ret = ufs_rpmb_send(scsi_dev, region, req, 1);
+		if (ret)
+			return ret;
+
+		if (n_rsp < 1)
+			return -EINVAL;
+
+		return ufs_rpmb_recv(scsi_dev, region, rsp, n_rsp);
+	default:
+		debug("ufs-rpmb: unsupported request 0x%x\n", request);
+		return -EINVAL;
+	}
+}
+
+static int ufs_rpmb_read_geometry(struct udevice *scsi_dev, u8 *rpmb_rw_size)
+{
+	struct ufs_hba *hba = dev_get_uclass_priv(scsi_dev->parent);
+	u8 desc[QUERY_DESC_GEOMETRY_DEF_SIZE];
+	int ret;
+
+	ret = ufshcd_read_desc_param(hba, QUERY_DESC_IDN_GEOMETRY, 0, 0,
+				     desc, sizeof(desc));
+	if (ret)
+		return ret;
+
+	*rpmb_rw_size = desc[GEOMETRY_DESC_RPMB_RW_SIZE];
+
+	return 0;
+}
diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index 8f120fbbee8..e320a6dcfbc 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -1457,9 +1457,9 @@ static int ufshcd_map_desc_id_to_length(struct ufs_hba *hba, enum desc_idn desc_
  * ufshcd_read_desc_param - read the specified descriptor parameter
  *
  */
-static int ufshcd_read_desc_param(struct ufs_hba *hba, enum desc_idn desc_id,
-				  int desc_index, u8 param_offset,
-				  u8 *param_read_buf, u8 param_size)
+int ufshcd_read_desc_param(struct ufs_hba *hba, enum desc_idn desc_id,
+			   int desc_index, u8 param_offset,
+			   u8 *param_read_buf, u8 param_size)
 {
 	int ret;
 	u8 *desc_buf;
diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index 0f6c93fbce7..9f55735602b 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -10,6 +10,9 @@
 struct udevice;
 
 #define UFS_CDB_SIZE	16
+
+#define UFS_UPIU_RPMB_WLUN		0xC4
+
 #define UPIU_TRANSACTION_UIC_CMD 0x1F
 #define UIC_CMD_SIZE (sizeof(u32) * 4)
 #define RESPONSE_UPIU_SENSE_DATA_LENGTH	18
@@ -809,4 +812,8 @@ static inline void ufshcd_rmwl(struct ufs_hba *hba, u32 mask, u32 val, u32 reg)
 
 int ufshcd_probe(struct udevice *dev, struct ufs_hba_ops *hba_ops);
 
+int ufshcd_read_desc_param(struct ufs_hba *hba, enum desc_idn desc_id,
+			   int desc_index, u8 param_offset, u8 *param_read_buf,
+			   u8 param_size);
+
 #endif
diff --git a/include/scsi.h b/include/scsi.h
index 2520a8b8fe6..cc79b6dd4c4 100644
--- a/include/scsi.h
+++ b/include/scsi.h
@@ -183,6 +183,8 @@ struct scsi_cmd {
 #define SCSI_WRITE_LONG	0x3F		/* Write Long (O) */
 #define SCSI_WRITE_SAME	0x41		/* Write Same (O) */
 #define SCSI_UNMAP	0x42		/* Write 10-Byte (MANDATORY) */
+#define SCSI_SECURITY_PROTOCOL_IN	0xA2	/* Security Protocol In (O) */
+#define SCSI_SECURITY_PROTOCOL_OUT	0xB5	/* Security Protocol Out (O) */
 
 /**
  * enum scsi_cmd_phase - current phase of the SCSI protocol
diff --git a/include/ufs.h b/include/ufs.h
index f6e27d90e43..1bec3ce73a4 100644
--- a/include/ufs.h
+++ b/include/ufs.h
@@ -20,4 +20,8 @@ int ufs_probe(void);
  */
 int ufs_probe_dev(int index);
 
+int ufs_rpmb_route_frames(struct udevice *scsi_dev, unsigned int region,
+			  void *req, unsigned long reqlen, void *rsp,
+			  unsigned long rsplen);
+
 #endif
-- 
2.54.0

