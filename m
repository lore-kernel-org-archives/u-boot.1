Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F82C44512
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 06:08:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B809B60771;
	Wed, 22 Jul 2026 06:08:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jodh6Wzjqgg2; Wed, 22 Jul 2026 06:08:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A66F160777
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784700514;
	bh=apmqgzFhuuLVV1BJhDcGQ9IV+vjiYbBCeNnQX0tGWJM=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Q2DC2J0KzNp6kPf88JtAXQud/28vAJJ8dbrdSAyxozcab7P2sRzNL1sKgVkB23L/L
	 uTxN/Wu9sZHKxu8Zja8+mLOnjMFq4OeXB/iUj9jvzZsLoRm9n2QA9Zkbrn4JmJAR/H
	 D2qID71e6VRy/I8gdiZvI31dNjT+yKCWfQSbsrvApDreQTAlQiFZnBh2Arkd00VRAs
	 Goqf9SmX89SGRJDgjUUf7z0nT9VpQbzENZSATUW08/XopDFq+M80iBT8Y4lE6a2d+/
	 WKQKXuXciQow+R76SAQNCSVNw0fh267vWUGax16IWPE3sex14R5sMSii4PVtA4mFiT
	 DKkQaWvo2GMSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A66F160777;
	Wed, 22 Jul 2026 06:08:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A999DB4
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 06:08:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 67CE180DC1
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 06:08:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7qJ7fyaJ7YL7 for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 06:08:31 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=jorge.ramirez@oss.qualcomm.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1D62380DA4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1D62380DA4
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1D62380DA4
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 06:08:31 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89C868494B; Wed, 22 Jul 2026 08:08:29 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F03B846A4
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 08:08:27 +0200 (CEST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M53YK63767515
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 06:08:25 GMT
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjnu4rhnb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 06:08:25 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5276aa86d00so17370481cf.2
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 23:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784700504; x=1785305304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=apmqgzFhuuLVV1BJhDcGQ9IV+vjiYbBCeNnQX0tGWJM=;
 b=g27fydM422ae+rfujh3t1KZ8zKI3EZ3pL58wi9uuiNa0qoUG0Sy+4G7GYc0BsSQ6P6
 FU0UlbIfKWTtwwDZ4HtJfEBFeXXbZKRFLwkdtYcQXQ8i1AefYTe2tiZaK2h1BpPp1Bhh
 3eaXH9RYRkzXYFiXSjh6k3mSHjzdmU8uPnDyxliJQUBA/OoBIlliNsomQOxELEdXkGMQ
 cRjFkRwdqOSoYhAyRXOnjsb+4ASopCqv3dtwPb+x0wtZKMFrfkmHldWvm5XZ5VyLX7Fn
 D6BBjp4sV+8sXk940xJHWAxO+ueAeLTOV4USn8SoZ0ackPJo6ErMGMZSCV9wiOxoVeXr
 0HwA==
X-Gm-Message-State: AOJu0Yw0uGPL+Xwuy3dIXxOVbD9v6PSnIz4n/5Uc/rvWRIFnVla7qALJ
 0MpN7CDygcAoigl/4Oep4FHVhL5oLI77hBjW8Wf5aBW5pQ5H12/QzmPUg69rKxkwsuFYxIn3IGk
 uZwkVzHqPKfeeUT0HG7EzQK75AzMXOW357GjCdradXLxxEABrkB/YEjmA
X-Gm-Gg: AR+sD11Q/WhmHc6SRbfyECYVYHfEeUcyO9/z/c4hhUsVkdDfx3Nr76irJb+b+KexnUk
 rAYOkAZH2skvdl8CWB0krFNYy16mvl8kawV2L05X0VIIwIvGIvN1EMlALoFCRnyLOXXrYmzP1Ns
 Loyls/4O8SN2lZPHU/4W98X4YWP2iUIMOlrczpkwbKDmj+XNgNlAoDHT7ttaqSpnonTPnrSNJ0k
 B58+alpAh0T1/NH8mDtnTvw3AHwLj4bB4x99CKv6zjTebh0w5UYJUUU52rqlOC2PRCLOcX67E3t
 rYojcMekMJwwIcbSgrxWtp712n+t5+qa8tb01KBSGnkHsj4+S10IifphjOfI3KQ15nytjAXjR6n
 rEilDntzJX5OBP0qsIr2AyQaivS6O8TjF2df2uPQKibhbfLuKh4U=
X-Received: by 2002:ac8:7f53:0:b0:51c:7b12:5ff9 with SMTP id
 d75a77b69052e-5213d7abfc0mr207693441cf.85.1784700503755; 
 Tue, 21 Jul 2026 23:08:23 -0700 (PDT)
X-Received: by 2002:ac8:7f53:0:b0:51c:7b12:5ff9 with SMTP id
 d75a77b69052e-5213d7abfc0mr207692961cf.85.1784700502997; 
 Tue, 21 Jul 2026 23:08:22 -0700 (PDT)
Received: from trex (182.red-79-144-196.dynamicip.rima-tde.net.
 [79.144.196.182]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49565373200sm110860865e9.5.2026.07.21.23.08.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 23:08:22 -0700 (PDT)
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
Subject: [PATCH v2 5/5] optee: implement the RPMB subsystem interface for UFS
Date: Wed, 22 Jul 2026 08:07:47 +0200
Message-ID: <20260722060805.1428110-6-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260722060805.1428110-1-jorge.ramirez@oss.qualcomm.com>
References: <20260722060805.1428110-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: KhedfubfwrKaLUXkGSQAJTGXLDran4Qb
X-Authority-Analysis: v=2.4 cv=KLhqylFo c=1 sm=1 tr=0 ts=6a605e59 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=2lELrtOEK2EaG96G7mOeag==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=4OB2SniIEselFtn8B8AA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA1NCBTYWx0ZWRfX9OKkgt3ea8O/
 u33coG/CN4iXYdLLNe4X6TVZa6Wo7jMXBlOnoQu335lyM4tINlGompkiFPwEruAULp8/lWFYvgY
 ByQi76MyMt4jTd3yuRAJsWTQbyeaFGelCqd5ysVi5qRssCCawZ1rqel33o/v1SyaV3BWqe2XIA0
 Vl9gXXT/P+8HDHCuar/fUTAWmzbpir1OD98W7sovJ/ILOE/N3tq6iog3WBGDnsaOiiLGvLj4+RD
 VkDV1U4F0A2GKgI9PR4Ww9XLG4KWY78W/SI7cLl91/YK9hbjh9P6OcfcVDHuo8CxLrH6AH+8/Di
 fB3p/1bdD/Zn5GLbxdrfyF7mUvRLcXAKLVa3wSxmXI1Hhmw35eNZU4QmdXtOgHlpxH43KbK05dS
 /eViLJ2/hYTVJRnuv/TBmstmrdL6fGCYaiiIp59DcgmUBJL+ZxMIhwxnGVbE3KIjhY6D1yhF72x
 tZBv71pJxj4CDw5knGg==
X-Proofpoint-ORIG-GUID: KhedfubfwrKaLUXkGSQAJTGXLDran4Qb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA1NCBTYWx0ZWRfX49+7rAKgkrgL
 LsW6czRdgNN9OIz19V27eklULeZhZqYD56CS7Hntx7a6ndNNmMWahUbbZuWrAlL3wcbt1F8vA2x
 gB6eingyqjq7FZmTlWEOXstifu74phM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220054
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=apmqgzFhuuL
 VV1BJhDcGQ9IV+vjiYbBCeNnQX0tGWJM=; b=dfYArrCcH4olxNTLCRyswPj4yHe
 dLso9gdVWb0BmvNtn6n+I15kssXmDcdwKHbiyjIEbgIurkBVHnZbrAAtLD6cnz+f
 CGV5aWIExHBQrBItU2RCIc/G046lAz0NnxS8Yswf8PhC1Mrb2ccGb4TGHA2RaFSP
 6kvvF+zLRkL3zKGVAQ0BxzNBwmJcCDtlpqopabP6QZd6t74SK/s0TNcZY4h3e6WL
 leR5cBwDenDfB6nFxkxDXBCS5jiv/QYWVIWD70UZpbE/ItNLgHDPcxILiFCr5qlP
 rp7j9i8Fj+iAJhwk7ttVxFEpwQ3q0VPOlejC89mg3qoe93lzlNix1yK3t2w==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784700504; x=1785305304; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=apmqgzFhuuLVV1BJhDcGQ9IV+vjiYbBCeNnQX0tGWJM=;
 b=XHenLIyrIz+2m+46fEJSVc2UHVbJ3UEhJmW4m+r9bQ10v5UPZcshmKjH9rFtRPEAVM
 maNMJEXxf7p1bgB1u52DsFmu5s4GKSABWh9hTAu/26ud5szyFG4LcpdeBAEXAhjGgRNr
 Z78LInnq8AKhJyj0W7lY8gNYUuBPy7EvEPPxEGyCUr1tgZxNw7HCmaaAiirqRyOoUiqA
 ePl9T5tL/UKIoLGF9xzAwWP8WmM4jGluqILgwelHiP1s46Nhid13zyP5ktbpFjdvOkJ+
 H7DgZaf6IvnL6G8RSh3rVON0VXBODjajiR9X73yagPMuUk3VyENBC3X+HYrsmTGus6Yn
 yrnQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=dfYArrCc; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=XHenLIyr
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dfYArrCc";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="XHenLIyr"; 
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
the legacy interface. As the legacy interface is dropped in favour of the
subsystem one, an eMMC backend should be added here so both transports are
served through a single RPMB path.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 drivers/tee/optee/Makefile               |   1 +
 drivers/tee/optee/optee_msg_supplicant.h |   8 ++
 drivers/tee/optee/optee_private.h        |  41 ++++++++
 drivers/tee/optee/rpmb.c                 | 124 +++++++++++++++++++++++
 drivers/tee/optee/supplicant.c           |   9 ++
 5 files changed, 183 insertions(+)
 create mode 100644 drivers/tee/optee/rpmb.c

diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
index 8321cf53a19..7af19834c00 100644
--- a/drivers/tee/optee/Makefile
+++ b/drivers/tee/optee/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_OPTEE) += core.o
 obj-y += supplicant.o
 obj-$(CONFIG_DM_I2C) += i2c.o
 obj-$(CONFIG_SUPPORT_EMMC_RPMB) += rpmb_legacy.o
+obj-$(CONFIG_SUPPORT_UFS_RPMB) += rpmb.o
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
diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb.c
new file mode 100644
index 00000000000..9c3e0f031ad
--- /dev/null
+++ b/drivers/tee/optee/rpmb.c
@@ -0,0 +1,124 @@
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
+#define UFS_RPMB_CONTROLLER	0
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
+	if (uclass_get_device(UCLASS_SCSI, UFS_RPMB_CONTROLLER, &scsi_dev)) {
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
+	if (uclass_get_device(UCLASS_SCSI, UFS_RPMB_CONTROLLER, &scsi_dev)) {
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
-- 
2.54.0

