Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70783C44512
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 06:09:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3998660740;
	Wed, 22 Jul 2026 06:09:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BXkS-yvBYKdh; Wed, 22 Jul 2026 06:09:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 086506071D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784700567;
	bh=pVhXVu25tNfCn2BJorRVk2ztkGYrjgpXphC4z7TvSCo=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=M+YLzPOXutOau6e3Zi+jZtA5GtySdBNqeqwzrn/JncU8Ia7dqyctMANC0pLVfgwUu
	 4kyxXvaY7oXl74HVltSxtQO+ntdjG/q5v7zmrUwLHmNGgUCaGOGXmBZPUWm729UqwA
	 J5sDps5kJNbEP9k34lOSfPwClvYnCcYa/w1qJPXiMuetSOlb+crGRsTWDu4c7AubO9
	 Ys8WR/l+fdcMeecudjNU59pcroofbZtrn3O3KGzajZ66vto10YLhQ1JHxhzEr/l9jI
	 zhTswxej95SQ/+/MB9VLlui2hiJte9k5WktS4Na2EzV+HRGvkOAWu2U95WxbeCYKOY
	 4ULhLLblgyHkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 086506071D;
	Wed, 22 Jul 2026 06:09:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 948D142A
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 06:09:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 862C7808C1
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 06:09:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8t93oH6tOwGZ for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 06:09:24 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=jorge.ramirez@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 341C68085D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 341C68085D
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 341C68085D
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 06:09:24 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AEF0848BA; Wed, 22 Jul 2026 08:09:22 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21222803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 08:09:20 +0200 (CEST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M53YZK3882920
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 06:09:18 GMT
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjntn0jbp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 06:09:18 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1eb52e1fso129113791cf.0
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 23:09:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784700558; x=1785305358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pVhXVu25tNfCn2BJorRVk2ztkGYrjgpXphC4z7TvSCo=;
 b=iLRBbCPyIHUSKF44RtxZHLb/SnEnWyyP0g7IoMZH/VNi5r/3ZLQHbU1W0tsJ/ZNMpq
 1/PwCwsX34WSPVi+NQ2G4JRPdU1u7QwLPYlUMRI5Ky8eh2WW90zEv0QlcYeOBs1+mMg7
 4hhgWqDc6xbo2bLysFkQFoDT11n1Eyp5aELyFf4hvxXH4GKS267MyMNldfpZWQddj1ez
 EFXBoSvZfQYU5HbE3KwmKs37BfoCK785ysjaJFAabSo1ItxOowlVUQ3lBJWvc3rMcq45
 SWsUtFzdbltKlsvjkTZhpDgZ6VpEpzTuWuo7PabitOiJSFNZyiT4ksZ2rM2wPwkndRKN
 yclQ==
X-Gm-Message-State: AOJu0Yy7MGwbpAdEPIjddF4JEXl2Q19kwcqJG3tn2K/MaZNBGNButDUS
 cTtRo0k4KLa5eUizTNyK5pOpN3/q095AZKprpLRqm6L/xUdUY1AqdrN1F4wcigCvNq1IDOf7/Mo
 E2+ISINFuY/J1Dhv+izZYSi5G5QxcWtxT1ah16wyLhDYz8gdORuLvEcfS
X-Gm-Gg: AR+sD12/hfhnvzFG/TO60XXqc9RmpzqjHQO70tXeOtKuDHa4UE8878lkKP2TRA8F4Di
 Zeh1xiPkSH+zczqXiU0qDVzyScSxE+louv9J9CM2LUa4kXNapICB80iasTmCiNNjg/nyg0IQr5k
 c2t60CTo7p89Bw8SAJA+Cs4DfrzU8SGHb3083zsxjA0z6f86TJEg+p4+bRHOiSRde61EYAdMl2P
 uDd2nepNZ9ISZ5+LgH6JDSw9ULj4FT5iFVBW7rGH49WvIkaUXQFlxtDrWkuPUtvG/TrDRLr3EXt
 df9T3uUuXhlsnjU1ulSBzDi1gZJz7qPdccViB9M89TAKWswc3QxEiuLbguDUUoac63KBFSmQw7b
 /easGjCfhg5A+kX+aWNvyIk0NHS5XNXBZFgSwdJIc0zJ8MYBjU3M=
X-Received: by 2002:ac8:5f93:0:b0:51c:b98a:244b with SMTP id
 d75a77b69052e-5213cdcb64fmr213494721cf.62.1784700497730; 
 Tue, 21 Jul 2026 23:08:17 -0700 (PDT)
X-Received: by 2002:ac8:5f93:0:b0:51c:b98a:244b with SMTP id
 d75a77b69052e-5213cdcb64fmr213493971cf.62.1784700495806; 
 Tue, 21 Jul 2026 23:08:15 -0700 (PDT)
Received: from trex (182.red-79-144-196.dynamicip.rima-tde.net.
 [79.144.196.182]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49565373200sm110860865e9.5.2026.07.21.23.08.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 23:08:15 -0700 (PDT)
To: jorge.ramirez@oss.qualcomm.com, neil.armstrong@linaro.org,
 trini@konsulko.com, jens.wiklander@linaro.org,
 ilias.apalodimas@linaro.org, bhupesh.linux@gmail.com, n-francis@ti.com,
 marek.vasut+renesas@mailbox.org, shawn.lin@rock-chips.com,
 igor.belwon@mentallysanemainliners.org,
 yoshihiro.shimoda.uh@renesas.com, alchark@gmail.com,
 tuyen.dang.xa@renesas.com, padmarao.begari@amd.com,
 macpaul.lin@mediatek.com, jstephan@baylibre.com, bb@ti.com,
 j-mcarthur@ti.com, venkyada@qti.qualcomm.com,
 hayashi.kunihiko@socionext.com, dlechner@baylibre.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 2/5] ufs: add RPMB transport over SCSI SECURITY PROTOCOL
Date: Wed, 22 Jul 2026 08:07:44 +0200
Message-ID: <20260722060805.1428110-3-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260722060805.1428110-1-jorge.ramirez@oss.qualcomm.com>
References: <20260722060805.1428110-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AJsSZ1gA c=1 sm=1 tr=0 ts=6a605e8e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=2lELrtOEK2EaG96G7mOeag==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=WL-bdQ3eRK4897QdmHUA:9 a=O8hF6Hzn-FEA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: sNRUAZbak_18dZczd53qCJPE92ODHG6y
X-Proofpoint-ORIG-GUID: sNRUAZbak_18dZczd53qCJPE92ODHG6y
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA1NCBTYWx0ZWRfXwAmJYxq6PNWP
 ylfFS0j+J1eH5DHzhRivGQFFn9Ri32W4ePOvTd0o61Ir/DTqWg5A9NZoaQho67A5jgmVNQHz0RZ
 9IGkygSdzt3lOyUljjGpDQ2nS6xXmeY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA1NCBTYWx0ZWRfXw90u37lzpZwg
 DyzmUTuo8Xx9eFRkUNpLX41N1nfF074pX4ThV7Dcg/fY8CgDqg2IFoOF038pOJHue3DhgmbGSBL
 IVTPOkOXZTVjIluEEZ+yLy0n4FSfGv8lvRMamo9NaX9zFjQ3XccQEwRHl+WwhaLpKu0RMw3jEZs
 7PIiwUnqmg5Q2H0Hwfx2Y7iRleg/SMgn5RMkWY9xlQw8G8z9kBJBN5bXoT6hpzS4EHIL0SlKMT1
 POgHH8xfXPWi4DOMy+WszjEEQQfBsn854Q21mA6pTdDd9lrZYANCs8tEHac/ybnCm8/vs+VBcAD
 I+OEGx44R9oU2SWkwQ3xaj3ePsl0FQrHvBptCQOd0tXN5zH7+BOTqUl7XwZtoOHCiLz1kgQVFch
 m0+EJ1xpx/tDCIsqTJKCEDc8HaGmaoMTCZXvkbdrFmfI/5bm77x/rJsZfebxQ/jmRsl7Db/W8Mc
 Gp6YSx2zJgyia2G6bng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220054
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=pVhXVu25tNf
 Cn2BJorRVk2ztkGYrjgpXphC4z7TvSCo=; b=LhRdyaqh5v8mPqKacYxE2EAzxJB
 V2O8xeIyTFmPeH2pruxblbZItjaE/6aP99sibqZ7yDByCVh9UiQU/hXdSwNrJ6E5
 9Ju2cr6eNicLYnLH+H5f10maZTAplMVpgwZsI6n5XQ85O7AQ8pz/WwBDGTXHHcxI
 S0fXOMIvvjZNQRuq7UbFj5FUub3fjPudhAgDY+GnL4korOIl0u7vYlKI+tJtJqUR
 bfdHmKStAQRd28U6T87JDw4fFkFuewlEb9cbHbjPde22Wg899ygOyixEjSBKeTpO
 qlXhOUHIaAu8wj/xmdlfiYW5X9JaPbxNozcRC6+ZWJmdoh1tW1cu+OgnfTA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784700558; x=1785305358; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pVhXVu25tNfCn2BJorRVk2ztkGYrjgpXphC4z7TvSCo=;
 b=iFePtAEFaFe3VBtFAIJ0t9nL8ivays/UrW2EcKuuSILVz1SiVZxlcKB3bV0mPRNif6
 mrNVkbItzXr04jIo27NrjtE9J7KnRl2n4wJfDd/kvXtjrEK5PxSSx+f2/d2/t1N1+7+g
 kWSlwBmKu80jFwVpJIXN3gfgUROg8IyTOgsP+lqpy/g878/XyTlb7uh4TjGl5EKDf3fZ
 gcSRc8S+pCNUirPJO/EMAcmiJXhuFz2eeVNFiPBHCQtzZZHhH1JaQZzmeEORxtCG/UOd
 Hy69nxm3Ocn30D28FwtFY/8Mcuhywr3AxN/34x35uuzlFwJP3IpWHHVeepgPQapW7LJz
 WTyA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=LhRdyaqh; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=iFePtAEF
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LhRdyaqh";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="iFePtAEF"; 
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

Add a UFS RPMB transport that moves fully-formed JEDEC RPMB frames to and
from the RPMB Well-Known LUN using SCSI SECURITY PROTOCOL IN/OUT commands,
exposed through ufs_rpmb_route_frames() for the OP-TEE RPMB supplicant and
guarded by CONFIG_SUPPORT_UFS_RPMB.

The RPMB WLUN is untouched during boot, so its first SECURITY PROTOCOL
command after power-on returns a power-on UNIT ATTENTION, which
ufs_scsi_exec() surfaces as -EINVAL. U-Boot has no SCSI mid-layer to
auto-retry, so retry the command a few times to avoid losing the first
frame OP-TEE sends. Bounce unaligned frames through an ARCH_DMA_MINALIGN
buffer, since the supplicant may pass a frame the controller cannot DMA
(for example a status-result frame built on the stack).

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 drivers/ufs/Kconfig      |  13 +++
 drivers/ufs/Makefile     |   1 +
 drivers/ufs/ufs-rpmb.c   | 168 +++++++++++++++++++++++++++++++++++++++
 drivers/ufs/ufs-uclass.c |   6 +-
 drivers/ufs/ufs.h        |   7 ++
 include/scsi.h           |   2 +
 include/ufs.h            |   6 ++
 7 files changed, 200 insertions(+), 3 deletions(-)
 create mode 100644 drivers/ufs/ufs-rpmb.c

diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index 49472933de3..d39fcda42dc 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -92,4 +92,17 @@ config UFS_TI_J721E
 	  This selects the glue layer driver for Cadence controller
 	  present on TI's J721E devices.
 
+config SUPPORT_UFS_RPMB
+	bool "Enable UFS RPMB (Replay Protected Memory Block) support"
+	depends on UFS && OPTEE && !SUPPORT_EMMC_RPMB
+	select BLAKE2
+	help
+	  Route OP-TEE RPMB requests to the UFS RPMB Well-Known LUN using
+	  SCSI SECURITY PROTOCOL IN/OUT commands. Required for OP-TEE secure
+	  storage (CFG_RPMB_FS) on UFS-based platforms that have no eMMC.
+	  BLAKE2 is used to derive the fixed-length RPMB CID that matches the
+	  Linux kernel UFS device_id ABI. The OP-TEE supplicant handles a
+	  single RPMB transport, so this is mutually exclusive with the eMMC
+	  RPMB supplicant (SUPPORT_EMMC_RPMB).
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
index 00000000000..5417a4ec0bc
--- /dev/null
+++ b/drivers/ufs/ufs-rpmb.c
@@ -0,0 +1,168 @@
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
+	struct scsi_cmd pccb;
+	u32 len = nframes * RPMB_FRAME_SIZE;
+	u16 spsp = (region << 8) | UFS_RPMB_SEC_PROTOCOL_ID;
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
+		return ufs_rpmb_recv(scsi_dev, region, rsp, 1);
+	}
+	case RPMB_REQ_WCOUNTER:
+	case RPMB_REQ_READ_DATA:
+		ret = ufs_rpmb_send(scsi_dev, region, req, 1);
+		if (ret)
+			return ret;
+		if (n_rsp < 1)
+			return -EINVAL;
+		return ufs_rpmb_recv(scsi_dev, region, rsp, n_rsp);
+	default:
+		debug("ufs-rpmb: unsupported request 0x%x\n", request);
+		return -EINVAL;
+	}
+}
+
+int ufs_rpmb_read_geometry(struct udevice *scsi_dev, u8 *rpmb_rw_size)
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
index f6e27d90e43..f2e46bc5fbf 100644
--- a/include/ufs.h
+++ b/include/ufs.h
@@ -20,4 +20,10 @@ int ufs_probe(void);
  */
 int ufs_probe_dev(int index);
 
+int ufs_rpmb_route_frames(struct udevice *scsi_dev, unsigned int region,
+			  void *req, unsigned long reqlen, void *rsp,
+			  unsigned long rsplen);
+
+int ufs_rpmb_read_geometry(struct udevice *scsi_dev, u8 *rpmb_rw_size);
+
 #endif
-- 
2.54.0

