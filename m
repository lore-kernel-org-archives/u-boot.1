Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF4DC43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 17:27:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DCF784A8F;
	Fri,  3 Jul 2026 19:27:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EYQRmLT/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gDdGru3T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2143E849BA; Fri,  3 Jul 2026 19:27:02 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C181D84A8F
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 19:26:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GInZD476529
 for <u-boot@lists.denx.de>; Fri, 3 Jul 2026 17:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=XWoM0Gjx6h+
 PtQMi8/ZixLx9KL1hLxqldqsz3ppRpH4=; b=EYQRmLT/T3n0f0RxkBJg7Io8+76
 xoXDzCkW6LWgLJWcbqV5wj9vSvce62x/BnrIuufTsYWVVh+Dc6yocSWDqy1iBcUW
 orn/dnMxmq4chxEXeqUha45aKKpFzc0cH2/oBQihxlDrl3WQTHL4cYX2rFZFID37
 wzuOHwuts7RSgC8TGPA0aZ1ERBek9RewW8RFURs72q09js+eGZp4Arrh73ZmA6CA
 pp4lSPQ2JU0a5OHqufH/c0vswcc2udiV3wQNKFSMEQvNnH5WQ+E3QupwQBHPLVug
 UXXv/K4YY2IXySenFSYZJVHgedFzqD/4ej9GHlYfizC53zqVJR5Y8PgC8Sw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f60eyc36k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 17:26:58 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3823dcc1647so161634a91.3
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 10:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783099617; x=1783704417; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XWoM0Gjx6h+PtQMi8/ZixLx9KL1hLxqldqsz3ppRpH4=;
 b=gDdGru3TML537xxpToNxIPhORNQfv+VB0HHKKfWuLl0yJB3jLiSTsJcCFg3N/l4DYb
 igpxow5PxV+bPN7haflEpl7BecRhnrjXPru2hRyOMDxsrthHOXm9t52L7ZVfL/FJTTrr
 2anIakmxZtrbo2dSbTcXzuIY2Kd+uKl8cq5foLv6E4W0t1tRCzFlb8LOqoym5fE1ZLeU
 QPvmu8Jh6+arVm7vkYJ7oxYitnX/V+x+TiPJdPRCjzBiPriuTTAv1Tq3oy0IjkfoWU5F
 xEMMb0781qxNkb5KiH1X2iF4HsVvIVKFe1RW+/UzxrtwC5I0trms2cpXei94JYyv6He0
 SFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783099617; x=1783704417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XWoM0Gjx6h+PtQMi8/ZixLx9KL1hLxqldqsz3ppRpH4=;
 b=UCxZAG1P2T/MB4O7O3r8NECtx5vIjCZgchK5KC2cfTPLq4RrUJgHUFG30MREZkZHF0
 5ao8+DLP7m4DmyyUEjertg6QEFE5eu1d00lbCW08LNgTaQ4bKPG1vJUY8zZ4+b5/wLOP
 jWVPA0zLCHY6/UAAdPJKw5DR+ol5GQUHM1/EKrkuGEhyIiWJkVvrYtG8LnkkFwzSaR6F
 NACywbiC+iUp6AlDBW3D1k6+ikZ3aHy1z6JkB3MNMXXzeKSmBcxePZZzqG7HFIdjsMyR
 +zw6aaUkM2+LForwJi8qGvJ0s9EIFY3L9NDxC9XCIN/GasbVvhOtxeTBA//AZvI+yj3b
 PGxQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrMMzOnq69xwqwH8tn+rax2YQFwLskYqTsLI0GJJQxv1Fm+1MxLr+1OAn3+KAtu3P1XyINOlhU=@lists.denx.de
X-Gm-Message-State: AOJu0YybchJYW7dmFbGVpx6DYQnkU54I39+iw1Cv3YH2uDQBc1ejS6e2
 KSMhkNVWwNzfEbkeuzfgPkM+VsXfYsJT2Dkg45X4lih1pUHLbBTemaE4AYnZG01SOqU7ZFyPas5
 /WGyXlTgmq6q5Si1PgGoO1OxRjnuHoVHEAkgsOFoYFpt0bQjQz7WQEaKD
X-Gm-Gg: AfdE7clN7lnzttOGjSaigIXXe2+/1OHGFD0nxwhB/DbudX9/Xs6VdcLuRnUwj3ILpBe
 lVG3gPJvaKiYBC0NmtbwI9xFt6KJcB5ylZt+Ym+RhT/fhaRMKKpTuEG+m5ir1tC5EZnMFnDHd2L
 6YQaRZ6j+itnbWBJuoU/Wq+oVCCBLXzBmRUtNk0d3Xhzhf4qXL+UbC4G7VLTu1h/JfOMQr1mkX2
 t+MMoEbB8HIkKhN1iLvXjApqtCu9sPz/YYibgtigoh/bZguZOZ0+AEtzr+WRfOlR14Ftmi3cZBd
 qLYeKEW8YlKReaH3t4WHG7hOpwS6yIC/zfzLoujmUtSSU9w5bjXTsN+zPnIGoj07+RLm03MRko1
 8+B68hMnbYHtiDq5rd/Bo8cPHbPqyy7pmcU9FsBVXLjrtBQkZ4vuOmVMtRT31KgjZK4Lv2pPSYk
 EGeOR1C9BZcyBA2AU5PDxjccxgIOpA3w==
X-Received: by 2002:a17:90b:2e48:b0:37f:133a:3e01 with SMTP id
 98e67ed59e1d1-382803bbadbmr501643a91.4.1783099617385; 
 Fri, 03 Jul 2026 10:26:57 -0700 (PDT)
X-Received: by 2002:a17:90b:2e48:b0:37f:133a:3e01 with SMTP id
 98e67ed59e1d1-382803bbadbmr501605a91.4.1783099616882; 
 Fri, 03 Jul 2026 10:26:56 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0b813d37sm23489561eec.10.2026.07.03.10.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 10:26:56 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, quic_varada@quicinc.com, Michael.Srba@seznam.cz,
 sjg@chromium.org, aswin.murugan@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, dlechner@baylibre.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v4 2/3] configs: qualcomm: Add Gunyah exit config fragment
Date: Fri,  3 Jul 2026 22:56:33 +0530
Message-Id: <20260703172634.140515-3-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260703172634.140515-1-aswin.murugan@oss.qualcomm.com>
References: <20260703172634.140515-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE3MyBTYWx0ZWRfX109NbEBmKrV6
 E7ZEA5fvQz5M8fCuy7U98UAQK+1uoTPqn1NLgnTOxEXxUmKx/9ju2M3Xb/FHqjdVhBLPKzp4alv
 cN09c1i0GGBlGAQzm+mhsej22daLaqrrisI1Aoh3D2SfxUKt6DHhDfVd6K9OBB9ctF4uGTO+/1Q
 6gB1qUtw/o+9TlSXdiy2J0DksF+/6Zs5MNRtYRSOPoRWpeQ9aMxG3xrX4hPXSNBRCjPPcMXjzkA
 bNtnnZdCFAjRaCy44Y8iKtXac6k7sgYBwwgBklsyC0qF9MgNMBQgzEmzUnu+XXLQ+YKqN4H2AHY
 QzB6GQhPsvp26X22qwuMmWrDGQoKolivP8UAQ6U+B0xQ8OoSFmMJ6XmLVrjJYRXQJguA+tKogZv
 Ndu9foR3PoqeAYfjhp4VO7z0c6jASap8lHJ06zgwvDjmwLOtzsmhK7z8DuEPtSy8Vb6TD2Q09mr
 VkyWhR12J4YMUQtY9IA==
X-Proofpoint-GUID: yyQ0SffY3R_lrfkhBqUBKpsKKrQXoXvn
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE3MyBTYWx0ZWRfX9kpYq1+wHt6s
 pclDr11OrjdXTOGZNVL+zZT//7/WpUOVAKuF7tFxtdOF3HPhbqSjAC8hCqpBIr/IrIeyO9vhUCr
 tQehNOrhJp+HXvBEiiK6ZmVaWXff7IA=
X-Authority-Analysis: v=2.4 cv=SPRykuvH c=1 sm=1 tr=0 ts=6a47f0e2 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=4FSSibxLwv_P-sZjzEUA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: yyQ0SffY3R_lrfkhBqUBKpsKKrQXoXvn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030173
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

Add reusable config fragment for exiting Gunyah hypervisor and
switching to EL2 on Dragonwing family platforms.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 board/qualcomm/exit-gunyah.config | 4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 board/qualcomm/exit-gunyah.config

diff --git a/board/qualcomm/exit-gunyah.config b/board/qualcomm/exit-gunyah.config
new file mode 100644
index 00000000000..b9b99184960
--- /dev/null
+++ b/board/qualcomm/exit-gunyah.config
@@ -0,0 +1,4 @@
+# Exit Gunyah hypervisor and switch to
+# EL2 for Dragonwing platforms
+CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK=y
+CONFIG_QCOM_EL2_GUNYAH_EXIT_SUPPORT=y
-- 
2.34.1

