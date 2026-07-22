Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53FABC44512
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 06:08:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A2BE80DAB;
	Wed, 22 Jul 2026 06:08:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pg9MUMsRn5yN; Wed, 22 Jul 2026 06:08:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6608180DB3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784700512;
	bh=3ZSdkHgSGtyuH8RcUgEaGCOxWugSg0hE1yNMneYZEIY=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=gm3kQybeboranPEYufcUAw3AAbi8bPxAGAbH1HbOy2/0kzCVSnyA5CeX54jZbLPZU
	 Ut8CQGLoUAXAQ/hzK1NySkhS8PkipUlzk806MiOZhMYWnU3NS4f16u4NrzFKLC8GOl
	 uf6eLpKp5qEmDybMelWj9qGtEqMUga88+ka3cly/lZlKFan/371LfO3blg/ogNPDGK
	 1wnFgAB2ItO1NhLwa1vP7hHlH5+tvjKqgXD+uktWv0TJhIUOwEOiln9d6nuEW1jlsx
	 PvixuhoC+hh2lVDKhRBZAL/5WwOvL6MTeFuNa1yzjT+Ed02KUmgLrNWhybV/Ll/pvC
	 GnmAtYkBLLmlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6608180DB3;
	Wed, 22 Jul 2026 06:08:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D8AD42A
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 06:08:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 038C080DC1
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 06:08:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PwPEDqVqYTzc for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 06:08:29 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=jorge.ramirez@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0B7F480DAB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0B7F480DAB
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0B7F480DAB
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 06:08:28 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17EE3803F6; Wed, 22 Jul 2026 08:08:27 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B09ED848BA
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 08:08:24 +0200 (CEST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M53wht3663225
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 06:08:22 GMT
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd5e2f39-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 06:08:22 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c0408254aso127622131cf.0
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 23:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784700501; x=1785305301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3ZSdkHgSGtyuH8RcUgEaGCOxWugSg0hE1yNMneYZEIY=;
 b=TFR7ZlLwlp57/sPQj8oHnr0kqDxxqebu2yNECDthjUg2w3BVWnWdp8Tuq8aAlc/VtA
 qfF0wS2iiLs49kdZGpYE/MLd/x2Az9D/+swTIlsUOpA3CVCHxP8XU5agRJW06Za8E4Mr
 zP9AGy12BrLZVSPhGD00IJKduwnzuOM808GWm1mlJBen9mtO4uzf6hS8ANgELPHvJkan
 4NtOulFCFGKg6JtQcpLsvOHXCv/bjd+QpbfsFDUFqOmzgCArUwcp+fa3AfXvB42Kxp1c
 dSjKfx2IHyW4nJ6WzIyHIAbBbYoin6Ro24iOX36cuA2ayb6JUKicZ5Eovvg97wql4IGG
 5Efw==
X-Gm-Message-State: AOJu0YxF1maZI9z8sPum84RicKqB8PrrZZhgnsoF0LfLUlJEd1row9AX
 yCadSd2mdznjI5s1ZM3goA4xER5m7CqpgPSjwy5Dadp+I72W1AJULI61bdQX8PwY1kbbdblWtKz
 nDG7PfqHhGylYHoq/E3fuW0hmWFaJHmArFfzhj595qvGcEQ5DYsHVpVJN
X-Gm-Gg: AR+sD11R+Ruj7q9qznl7iKO23HDKeklGLxBP2alVjDAzGHx5rJ5XUoKxnG14vTYlMIn
 qKBs+KfXQwIx/5A2uS6HWa6YcoK1csdmrSHUwGU117GWdg1k+wcXcG4JvlizHDEq8nFS/yuypox
 00xRPNTrn/dIO2GR0brbPfxrnnbtAyuTv21SUO8I4o8JEQYz/DE6tuOBsVpAdhBVJ0KGIgv+3dd
 /Bms4M0hI2REhZ51UP2IEPaW/K7Bq7eXwM/zZXuSG6nrModHZkWX5Ls3c2Kms1t9VHek6Ddw/jf
 cv/dmdva+DGFnfz5cuj2VcPfhH0XieQW4y4uMNmuo3aItYcOfBQZ5YPFzCKKy6aYKfsXPhYBJBv
 i3RQgtia0b4mboIUNiuo4K4650IjJMf+8UYzXHPi+9mRBKD91f3M=
X-Received: by 2002:a05:622a:1b1e:b0:517:63df:91a5 with SMTP id
 d75a77b69052e-527a70d5f24mr25933841cf.19.1784700501444; 
 Tue, 21 Jul 2026 23:08:21 -0700 (PDT)
X-Received: by 2002:a05:622a:1b1e:b0:517:63df:91a5 with SMTP id
 d75a77b69052e-527a70d5f24mr25933731cf.19.1784700501052; 
 Tue, 21 Jul 2026 23:08:21 -0700 (PDT)
Received: from trex (182.red-79-144-196.dynamicip.rima-tde.net.
 [79.144.196.182]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49565373200sm110860865e9.5.2026.07.21.23.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 23:08:19 -0700 (PDT)
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
Subject: [PATCH v2 4/5] optee: rename rpmb.c to rpmb_legacy.c
Date: Wed, 22 Jul 2026 08:07:46 +0200
Message-ID: <20260722060805.1428110-5-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260722060805.1428110-1-jorge.ramirez@oss.qualcomm.com>
References: <20260722060805.1428110-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9K79fQgeI2rPowweIFOqatYSXt94dkIW
X-Authority-Analysis: v=2.4 cv=CbE4Irrl c=1 sm=1 tr=0 ts=6a605e56 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=2lELrtOEK2EaG96G7mOeag==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=H4pw0e22ym-jj-fGjdQA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: 9K79fQgeI2rPowweIFOqatYSXt94dkIW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA1NCBTYWx0ZWRfX5kzY/Oe4OQcd
 cukSch4+brbVLngruBJUo78fibXG5eqpd/OOuPWA7LC963o/sKwADoGzU1GJPwtURehH6sUtv/k
 GVtE8jhaKMNQK++jv1yTMFqEIN6Q8zSFceYmWnSFurMSS6AD1heN7UWVwXmBOGfJ3huNLORaAZq
 cKkdNY0a//v7XV3+q7nfTBbdvPA8C6OKaT9k5Sz9c8LyU0hTkS1LRch+MFRf2M5MP54BNm58kMI
 6sEFd4ihPgYtpDBatIyd/LZ+GKKzu0ZI2qpRN7VZ2bNbxk5k63CbA456RpydReL3zAu9MiX7+kK
 AMa+ILtfy2OFaWpjaw3ziErmni6bSMCXATZEXcOFdEtBEbpaFJtDaQ39bm5UGDzj3fO76vyiHi2
 HUgR/O0TGKvQFkyEl4U/U1pJBxtqVBuGOsGuQEkHDNXFaRrNSWcgiQA6hAGz3ZNzf8+2DOFLhBo
 butPtSuoXFi3pdBVW3w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA1NCBTYWx0ZWRfX40pcpbUAGFzk
 M8+AyQ5GaOEKhhBOPNiugWbLT69lCoT1+XlaLIQNuaiInaYS61gKvyLpROMnmHqiuEnbEvRXTYy
 cY4xReNbb2JBkfccJxfr4fUfgRR77JI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220054
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=3ZSdkHgSGty
 uH8RcUgEaGCOxWugSg0hE1yNMneYZEIY=; b=bo9NZi6lDBAnHKpcvgnEAbnwVLH
 gOAnryD2E63ZQUKMEM0yBTcbsTF/7oJbsasRXYXxB/WrUz5aycHgNyRQq8HfBtWu
 MxqxsLE4qjm55AQ4TitFXUdbFM11ZqssNQEN8Y87ZVaKOj+Juph92g0uoaTRqonM
 6Qq4xqEZJKKrlebKz1eQjYDW849ET6mmhuXUJL25hE/fl6EaWmAoyMxOsdQSlGRc
 iyTvWXyyYtgFeJ0cI2SaFpnPOhpVDIlsjUA+xp3CLyjBu4XfvjminO4gZ6FPJ22P
 8tAmW03YwnxU81EctZdMNY7oTpJjfM9S0ArgMGGl2pj6+afalZ6sFqW5z2w==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784700501; x=1785305301; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3ZSdkHgSGtyuH8RcUgEaGCOxWugSg0hE1yNMneYZEIY=;
 b=Qsqkcr7J58cEyt60t+Qo4Bvl8bOSthNohIgFivQCYJU8Hu6Z3GXmRsF2wVXEPhaHTW
 z0HnA7eeWPMuMCiLaaxCBokZB3DqUj9KTvlvbXWsmMhHIWbNiAV8Xx73c9D0khYTw4IS
 oiGwtS8P9oHRmpAe+U7EN3s6ncC8lt7Ba+dK0FVt5Pghu7dkYjYsyOKW46ItiRCjdmxk
 w6ZCF8j7ZjnDmylB4EDuupE3TZY/p+uzlcVdwv14g3Qch7YU/rIUFZO9PVriRIMXXXQr
 49cTxxbhOPtH09f5lOLsPrePgMuEQ45p4yqziZAlgd+d4aaX434+ZQ9JAmZRst4wcT9x
 hBsQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=bo9NZi6l; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Qsqkcr7J
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bo9NZi6l";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="Qsqkcr7J"; 
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

This file implements the legacy single-command OPTEE_MSG_RPC_CMD_RPMB
supplicant (eMMC only). Rename it to rpmb_legacy.c so the primary rpmb.c
name is free for the RPMB subsystem interface added next; pure rename plus
its Makefile object, no functional change.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 drivers/tee/optee/Makefile                  | 2 +-
 drivers/tee/optee/{rpmb.c => rpmb_legacy.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/tee/optee/{rpmb.c => rpmb_legacy.c} (100%)

diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
index 36ac085ef42..8321cf53a19 100644
--- a/drivers/tee/optee/Makefile
+++ b/drivers/tee/optee/Makefile
@@ -3,4 +3,4 @@
 obj-$(CONFIG_OPTEE) += core.o
 obj-y += supplicant.o
 obj-$(CONFIG_DM_I2C) += i2c.o
-obj-$(CONFIG_SUPPORT_EMMC_RPMB) += rpmb.o
+obj-$(CONFIG_SUPPORT_EMMC_RPMB) += rpmb_legacy.o
diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb_legacy.c
similarity index 100%
rename from drivers/tee/optee/rpmb.c
rename to drivers/tee/optee/rpmb_legacy.c
-- 
2.54.0

