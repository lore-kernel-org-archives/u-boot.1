Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48EB7C531D4
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 14:39:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 011BB40A16;
	Thu, 23 Jul 2026 14:39:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id re7cpjClmoXA; Thu, 23 Jul 2026 14:39:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F124140A42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784817562;
	bh=jCcaC7221oCazmW8wc6Ju6qZy/dFwFkvwYy4tmsVUCc=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=fN5l0Qk1GCTMdyZfYUDHvCzzhSeOTB5bEoWJew6VBlwHt9wCc7OvsrX5GwC9MMz6q
	 X7ezUnDI9rGLCfIHWYFBD0nBqX4mNMeM7z/Ln0ForfAHcedoslOoIr3awYIv1WF4GS
	 pvewyy+0kRMaFDdKn1eyveJgbz5vWTSqZzH4nUeJcOmY9edJTYXdNwpYgTpECS4toU
	 4y8zVzOZRsz0WAXikZsAex+I6YhW1W5+zT9ej/NVzp9cVd7c0u/dYhlngquDTq+q9Q
	 3pTQABTMG0er6RJ6fOe7xR/hqipUBqlYLt3PU52hVaWdiYaCRxJObLIZBLlWB35mQ/
	 b4XvAAAHVRi/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F124140A42;
	Thu, 23 Jul 2026 14:39:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 242794BF
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 14:39:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0AC83403E9
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 14:39:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pKJHAULkRAhc for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 14:39:17 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=jorge.ramirez@oss.qualcomm.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A7F4A403DE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A7F4A403DE
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A7F4A403DE
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 14:39:16 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74FE3803F6; Thu, 23 Jul 2026 16:39:14 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68C8180117
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 16:39:11 +0200 (CEST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NCw52T3605773
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 14:39:09 GMT
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkeuq9pr3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 14:39:09 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c26012cd0so12695081cf.0
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 07:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784817548; x=1785422348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jCcaC7221oCazmW8wc6Ju6qZy/dFwFkvwYy4tmsVUCc=;
 b=pkCdBM+FTxtnuapemnQxHc9iK8L5eBtqcQK/5lYlkOv0Uem9Aiga+wcC7U6eLKP6tk
 kkbHHeyVnmzSwW2pcel++zcNf7feUN3Ezz5OoFCJuD/nqNeTaoUcGyIR/iOxB5RzqyXX
 ECtBLA+btcVAbmYlbfkhEzXmBoqmj9V3lPovzji89WjpN/IevjtNDIGi4cwwXCDOnt4/
 1AalhF0xXEB6wHxG3pLepRECUbH6uwEZCD6d53XkWa9FreVX8ikqQYYB+MvXVrszG3S0
 PYz2gBQvfB4iLBEaateKihGbxrHg3wNnNbb/5YwA0fdxhymT/fjb0M3f5X+rUuw1TOdD
 i9bQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro3MlU1sMxQpuWu2phD5xwEFbm2eJsness72+okOnwpa22G9/uD7IRTEgdCH/jVmfGXN2O6Kyo=@lists.denx.de
X-Gm-Message-State: AOJu0YyslyirX0srv/qkwXTzTitcfAfJVGtFYbF2CMlLbdDJZIXaU6JA
 z1FrMpLG3nWVtpOMIib+IfLYepL0dyo2FNa5a1RppRjSBKStbkXflZy8HNgNNynq68GXvoGjm14
 oH2WODCL1rZGqptY2OhSz1ulyQUwIOml7fKjNavGF4NDsZVveF04zISkJjzqoqkgg
X-Gm-Gg: AR+sD11jh//N1ASs6HHLSKZPvTfUvnjguNDVyXAwVBYVEnnbqB9Anj5fo/uSnjtnUI8
 P85f93qfJM7KX5FthXr/03PhMkuKqvYmRw3j4DkSJuN9v/X3s0ZvckTUAWxvl6YvA79dq/96hbY
 B7R96PyVJTe0u+uC+PxPTkn73SRrWpCAl7mqp4qb4LlJQ78i90H/y1qnHtnHaxUj3oyvxUhuOT6
 GVpyzsIE2h0RAavByQmWj+VuHvtpZ4thz7MXus3Zt8PJ0W/nqqKM6FsBHmpnWSFOlD8b00IR/fE
 VKCur1ZFlNhF2v05jJetF4ritTCtY0G7WoduloV7pdcjPIft+1yivQnWeFJv3S15vjqEDzUJ80o
 ctTIdRrI4pL31WHPaZIeqwT1FH6PXVOuXt9jdNfKKVWoayRWqJoQ=
X-Received: by 2002:ac8:5a46:0:b0:51b:fc67:c73c with SMTP id
 d75a77b69052e-5283dda8d05mr31286041cf.16.1784817547906; 
 Thu, 23 Jul 2026 07:39:07 -0700 (PDT)
X-Received: by 2002:ac8:5a46:0:b0:51b:fc67:c73c with SMTP id
 d75a77b69052e-5283dda8d05mr31285581cf.16.1784817547291; 
 Thu, 23 Jul 2026 07:39:07 -0700 (PDT)
Received: from trex (182.red-79-144-196.dynamicip.rima-tde.net.
 [79.144.196.182]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c67339sm16968193f8f.31.2026.07.23.07.39.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 07:39:06 -0700 (PDT)
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
Subject: [PATCH v3 5/5] optee: implement the RPMB subsystem interface for UFS
Date: Thu, 23 Jul 2026 16:38:22 +0200
Message-ID: <20260723143852.2287208-6-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260723143852.2287208-1-jorge.ramirez@oss.qualcomm.com>
References: <20260723143852.2287208-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE0NCBTYWx0ZWRfXydvRK3qPYbHh
 3VIWieyF1A7uSi/Pl1EzlxAFM69DjVYEYGQXOJJPIuGBGjnQr4EcT8fy6o1HJ8rSXbwDidcPOXM
 LAnLTYuJri5DzqXwM0+24A2SL+VB10w=
X-Proofpoint-ORIG-GUID: Amx_5lWCxuDvVFOmSPFz4NK9f6wM35-c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE0NCBTYWx0ZWRfXyEhX8o5KehSO
 dgyA/u7cuCyF4Z2GA5HPchLtX0ZUJQVKk9GzSMTjHt0f5MWSC4bGJP7o7GCqgn4s502iPVLXqQU
 TK5uxme7Favu537sz12fq0cAfvKM3c2tCr9gNrHRKmpvnkh9qYIfUBdvL2qsyMIl2irMS7jzxZt
 Yo3Jj8W0rEOQ8Z0FHUA1zj1+DEgtbQjPOfvxY03mYdHeHcsSJrfSaoq1EfJFi/jwnUGr6k1fqyZ
 KIjc0ghgyJOR6k2ctidyoEwSSyM+OOIiL9ONs20WafBR8uiWacBUlXtJCf4w4MMHOlAD2vVB/7o
 CdJCjvI1cRYXTaa/rRWsTuFqTbN5Irz7ykzvQsPxF5CRRBJXxqRWPDT5wGcpBsPE87aOnKGREeq
 hmw7+zO4kC/R6pDq53WGzXPJbAnC6GJMl3q43haGxHQMBLnbFj/YsOWKgw8rrKTZaF+WU0bdRsL
 OfPdnbI1jPA2Suc1lEA==
X-Authority-Analysis: v=2.4 cv=cPDQdFeN c=1 sm=1 tr=0 ts=6a62278d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=2lELrtOEK2EaG96G7mOeag==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=4OB2SniIEselFtn8B8AA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: Amx_5lWCxuDvVFOmSPFz4NK9f6wM35-c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230144
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=jCcaC7221oC
 azmW8wc6Ju6qZy/dFwFkvwYy4tmsVUCc=; b=TGawguTWqwTIXkwaYFx3sII4AN2
 zlUr5BjyWbcb51SA4+5tsKvaM60RxJi3tQMECy9wIhuC88UpSNbhT3SZxfv7cgB3
 slski6vJ/eFSuyuVk6xBCw0If95MIcvV8b28MFfDpAJSdmpCRAHZ5uORmWk9Ji6u
 aGqS0flibLSyakOvdv8dmvMPZ9mjcPyRU6HxTiVWfXfLK3uX7khciRR55byHSObg
 8n6UwdzOjyoGj4XDnjsw396FkxivtBdoLDvXAn39SqBftDdTCMmk1P7ojhi0rUNj
 wW2Zs9e+Amg4fwuM0OjmqlxR4/IgxqX2gEC6tZilphozMWm9Rz3SjpmWbvA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784817548; x=1785422348; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jCcaC7221oCazmW8wc6Ju6qZy/dFwFkvwYy4tmsVUCc=;
 b=cRYrRPjTN5bXehm5c0J61DdkI+9Wu+zw+FsUvOon/T154u2RsTFRL4puecb+kFayX1
 xsiq7JQk1+gFA4DOyUAgd4yZu5rXG6VTkb3tK0J68CPOVpvgmIkWSHXX8oeJkVcf0gpk
 z5Z+fyoA/ym6yNlwNtrbcq7SW9Od80rp4hBcVeqOAM4axn5re2ZDCFa9QKiA/hKUbgi1
 e/Be3jMfClHr3Phc/sttr4kwMaICE2y9XxTDtDFPA3LTvYMa6SLtK7Xrl1DHx9Gpf13A
 PUgAEqPFvcP+ZPVdzdv+GW3GcVcDmBR0gOOxxt7aPvtDNJh/gmU3qZhzebBlvbEmvPdH
 NAlg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=TGawguTW; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=cRYrRPjT
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TGawguTW";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="cRYrRPjT"; 
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

OP-TEE's legacy RPMB supplicant interface assumes the RPMB device is eMMC
and derives the key from an eMMC-shaped device ID, so it can never
reproduce the key Linux derives for a UFS device; secure storage on
UFS-only platforms instead needs the transport-agnostic RPMB subsystem
interface, through which the normal world describes the real RPMB device
to OP-TEE. Add a UFS backend for it so OP-TEE derives a key matching Linux
and can use RPMB secure storage on UFS, leaving the legacy eMMC path
untouched.

This subsystem backend currently supports UFS drives only; eMMC still uses
the legacy interface.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 drivers/tee/optee/Makefile               |   1 +
 drivers/tee/optee/optee_msg_supplicant.h |   8 ++
 drivers/tee/optee/optee_private.h        |  41 +++++++
 drivers/tee/optee/rpmb_ufs.c             | 141 +++++++++++++++++++++++
 drivers/tee/optee/supplicant.c           |   9 ++
 drivers/ufs/Kconfig                      |   8 ++
 6 files changed, 208 insertions(+)
 create mode 100644 drivers/tee/optee/rpmb_ufs.c

diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
index d0c7f8dfb12..f2af10999a9 100644
--- a/drivers/tee/optee/Makefile
+++ b/drivers/tee/optee/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_OPTEE) += core.o
 obj-y += supplicant.o
 obj-$(CONFIG_DM_I2C) += i2c.o
 obj-$(CONFIG_SUPPORT_EMMC_RPMB) += rpmb_emmc.o
+obj-$(CONFIG_SUPPORT_UFS_RPMB) += rpmb_ufs.o
diff --git a/drivers/tee/optee/optee_msg_supplicant.h b/drivers/tee/optee/optee_msg_supplicant.h
index 963cfd47824..b720d5d7b3f 100644
--- a/drivers/tee/optee/optee_msg_supplicant.h
+++ b/drivers/tee/optee/optee_msg_supplicant.h
@@ -152,6 +152,14 @@
  */
 #define OPTEE_MSG_RPC_CMD_I2C_TRANSFER 21
 
+#define OPTEE_MSG_RPC_CMD_RPMB_PROBE_RESET	22
+#define OPTEE_MSG_RPC_CMD_RPMB_PROBE_NEXT	23
+#define OPTEE_MSG_RPC_CMD_RPMB_FRAMES		24
+
+#define OPTEE_RPC_SHM_TYPE_APPL		0
+
+#define OPTEE_RPC_RPMB_UFS		1
+
 /*
  * Was OPTEE_MSG_RPC_CMD_SQL_FS, which isn't supported any longer
  */
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index 1f07a27ee4b..2888257aefe 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -9,6 +9,17 @@
 #include <tee.h>
 #include <log.h>
 
+#ifdef CONFIG_SUPPORT_UFS_RPMB
+/**
+ * struct optee_private - OP-TEE driver private data
+ * @rpmb_next_region:	next UFS RPMB region to report on PROBE_NEXT
+ * @rpmb_cur_region:	UFS RPMB region selected by the last PROBE_NEXT
+ */
+struct optee_private {
+	unsigned int rpmb_next_region;
+	unsigned int rpmb_cur_region;
+};
+#else
 /**
  * struct optee_private - OP-TEE driver private data
  * @rpmb_mmc:		mmc device for the RPMB partition
@@ -22,6 +33,7 @@ struct optee_private {
 	int rpmb_dev_id;
 	int rpmb_original_part;
 };
+#endif
 
 struct optee_msg_arg;
 
@@ -60,6 +72,35 @@ static inline void optee_suppl_rpmb_release(struct udevice *dev)
 }
 #endif
 
+#ifdef CONFIG_SUPPORT_UFS_RPMB
+void optee_suppl_cmd_rpmb_probe_reset(struct udevice *dev,
+				      struct optee_msg_arg *arg);
+
+void optee_suppl_cmd_rpmb_probe_next(struct udevice *dev,
+				     struct optee_msg_arg *arg);
+
+void optee_suppl_cmd_rpmb_frames(struct udevice *dev,
+				 struct optee_msg_arg *arg);
+#else
+static inline void optee_suppl_cmd_rpmb_probe_reset(struct udevice *dev,
+						    struct optee_msg_arg *arg)
+{
+	arg->ret = TEE_ERROR_NOT_IMPLEMENTED;
+}
+
+static inline void optee_suppl_cmd_rpmb_probe_next(struct udevice *dev,
+						   struct optee_msg_arg *arg)
+{
+	arg->ret = TEE_ERROR_NOT_IMPLEMENTED;
+}
+
+static inline void optee_suppl_cmd_rpmb_frames(struct udevice *dev,
+					       struct optee_msg_arg *arg)
+{
+	arg->ret = TEE_ERROR_NOT_IMPLEMENTED;
+}
+#endif
+
 #ifdef CONFIG_DM_I2C
 /**
  * optee_suppl_cmd_i2c_transfer() - route I2C requests to an I2C chip
diff --git a/drivers/tee/optee/rpmb_ufs.c b/drivers/tee/optee/rpmb_ufs.c
new file mode 100644
index 00000000000..3e54a1a37d7
--- /dev/null
+++ b/drivers/tee/optee/rpmb_ufs.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <dm.h>
+#include <tee.h>
+#include <ufs.h>
+
+#include "optee_msg.h"
+#include "optee_msg_supplicant.h"
+#include "optee_private.h"
+
+static int optee_rpmb_get_dev(struct udevice **scsi_devp)
+{
+	struct udevice *ufs_dev, *scsi_dev;
+	int ret;
+
+	ret = uclass_get_device(UCLASS_UFS, CONFIG_UFS_RPMB_CONTROLLER,
+				&ufs_dev);
+	if (ret)
+		return ret;
+
+	ret = device_get_child(ufs_dev, 0, &scsi_dev);
+	if (ret)
+		return ret;
+
+	*scsi_devp = scsi_dev;
+
+	return 0;
+}
+
+void optee_suppl_cmd_rpmb_probe_reset(struct udevice *dev,
+				      struct optee_msg_arg *arg)
+{
+	struct optee_private *priv = dev_get_priv(dev);
+
+	if (arg->num_params != 1 ||
+	    arg->params[0].attr != OPTEE_MSG_ATTR_TYPE_VALUE_OUTPUT) {
+		arg->ret = TEE_ERROR_BAD_PARAMETERS;
+		return;
+	}
+
+	priv->rpmb_next_region = 0;
+	priv->rpmb_cur_region = 0;
+
+	arg->params[0].u.value.a = OPTEE_RPC_SHM_TYPE_APPL;
+	arg->ret = TEE_SUCCESS;
+}
+
+void optee_suppl_cmd_rpmb_probe_next(struct udevice *dev,
+				     struct optee_msg_arg *arg)
+{
+	struct optee_private *priv = dev_get_priv(dev);
+	struct udevice *scsi_dev;
+	struct tee_shm *cid_shm;
+	u8 size_mult = 0;
+	u8 rel_wr = 0;
+	void *cid_buf;
+	ulong cid_size;
+	int ret;
+
+	if (arg->num_params != 2 ||
+	    arg->params[0].attr != OPTEE_MSG_ATTR_TYPE_VALUE_OUTPUT ||
+	    arg->params[1].attr != OPTEE_MSG_ATTR_TYPE_RMEM_OUTPUT) {
+		arg->ret = TEE_ERROR_BAD_PARAMETERS;
+		return;
+	}
+
+	cid_shm = (struct tee_shm *)(ulong)arg->params[1].u.rmem.shm_ref;
+	cid_buf = (u8 *)cid_shm->addr + arg->params[1].u.rmem.offs;
+	cid_size = arg->params[1].u.rmem.size;
+	if (cid_size < UFS_RPMB_CID_SIZE) {
+		arg->ret = TEE_ERROR_SHORT_BUFFER;
+		return;
+	}
+
+	if (optee_rpmb_get_dev(&scsi_dev)) {
+		arg->ret = TEE_ERROR_ITEM_NOT_FOUND;
+		return;
+	}
+
+	while (priv->rpmb_next_region < UFS_RPMB_NUM_REGIONS) {
+		unsigned int region = priv->rpmb_next_region++;
+
+		ret = ufs_rpmb_get_region_info(scsi_dev, region, &size_mult,
+					       &rel_wr, cid_buf);
+		if (ret < 0) {
+			arg->ret = TEE_ERROR_GENERIC;
+			return;
+		}
+		if (!ret)
+			continue;
+
+		priv->rpmb_cur_region = region;
+		arg->params[0].u.value.a = OPTEE_RPC_RPMB_UFS;
+		arg->params[0].u.value.b = size_mult;
+		arg->params[0].u.value.c = rel_wr;
+		arg->params[1].u.rmem.size = UFS_RPMB_CID_SIZE;
+		arg->ret = TEE_SUCCESS;
+		return;
+	}
+
+	arg->ret = TEE_ERROR_ITEM_NOT_FOUND;
+}
+
+void optee_suppl_cmd_rpmb_frames(struct udevice *dev,
+				 struct optee_msg_arg *arg)
+{
+	struct optee_private *priv = dev_get_priv(dev);
+	struct tee_shm *req_shm;
+	struct tee_shm *rsp_shm;
+	struct udevice *scsi_dev;
+	void *req_buf;
+	void *rsp_buf;
+	ulong req_size;
+	ulong rsp_size;
+
+	if (arg->num_params != 2 ||
+	    arg->params[0].attr != OPTEE_MSG_ATTR_TYPE_RMEM_INPUT ||
+	    arg->params[1].attr != OPTEE_MSG_ATTR_TYPE_RMEM_OUTPUT) {
+		arg->ret = TEE_ERROR_BAD_PARAMETERS;
+		return;
+	}
+
+	if (optee_rpmb_get_dev(&scsi_dev)) {
+		arg->ret = TEE_ERROR_ITEM_NOT_FOUND;
+		return;
+	}
+
+	req_shm = (struct tee_shm *)(ulong)arg->params[0].u.rmem.shm_ref;
+	req_buf = (u8 *)req_shm->addr + arg->params[0].u.rmem.offs;
+	req_size = arg->params[0].u.rmem.size;
+
+	rsp_shm = (struct tee_shm *)(ulong)arg->params[1].u.rmem.shm_ref;
+	rsp_buf = (u8 *)rsp_shm->addr + arg->params[1].u.rmem.offs;
+	rsp_size = arg->params[1].u.rmem.size;
+
+	if (ufs_rpmb_route_frames(scsi_dev, priv->rpmb_cur_region, req_buf,
+				  req_size, rsp_buf, rsp_size))
+		arg->ret = TEE_ERROR_BAD_PARAMETERS;
+	else
+		arg->ret = TEE_SUCCESS;
+}
diff --git a/drivers/tee/optee/supplicant.c b/drivers/tee/optee/supplicant.c
index 8a426f53ba8..50b780037fb 100644
--- a/drivers/tee/optee/supplicant.c
+++ b/drivers/tee/optee/supplicant.c
@@ -89,6 +89,15 @@ void optee_suppl_cmd(struct udevice *dev, struct tee_shm *shm_arg,
 	case OPTEE_MSG_RPC_CMD_RPMB:
 		optee_suppl_cmd_rpmb(dev, arg);
 		break;
+	case OPTEE_MSG_RPC_CMD_RPMB_PROBE_RESET:
+		optee_suppl_cmd_rpmb_probe_reset(dev, arg);
+		break;
+	case OPTEE_MSG_RPC_CMD_RPMB_PROBE_NEXT:
+		optee_suppl_cmd_rpmb_probe_next(dev, arg);
+		break;
+	case OPTEE_MSG_RPC_CMD_RPMB_FRAMES:
+		optee_suppl_cmd_rpmb_frames(dev, arg);
+		break;
 	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER:
 		optee_suppl_cmd_i2c_transfer(arg);
 		break;
diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index d39fcda42dc..d7fe2486ee2 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -105,4 +105,12 @@ config SUPPORT_UFS_RPMB
 	  single RPMB transport, so this is mutually exclusive with the eMMC
 	  RPMB supplicant (SUPPORT_EMMC_RPMB).
 
+config UFS_RPMB_CONTROLLER
+	int "UFS controller index used for RPMB"
+	depends on SUPPORT_UFS_RPMB
+	default 0
+	help
+	  Index of the RPMB-owning UFS controller in the UCLASS_UFS device
+	  list. Leave at 0 unless the board has more than one UFS controller.
+
 endmenu
-- 
2.54.0

