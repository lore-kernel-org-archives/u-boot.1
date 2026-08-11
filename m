Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8AECC5AD7B
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 05:19:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 845AC80F4E;
	Tue, 11 Aug 2026 05:19:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HBLMXTkhcanc; Tue, 11 Aug 2026 05:19:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E140180F05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786425595;
	bh=dEyZl+81f6mXF4NvCmT9i0GPIOTQTt3uX2FpGhUUFcM=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=wjDGxJ4r0FXwfaXfAm6xTiUwRzyqEPczX2Gsp6oq2g+Z4k5oueoojQRzNd4ugMHLl
	 wkNOgXWKjKk5/GDZiuJeOEnv5eRwy5t88wdGmXqTyeXXnlKu+HVEE0Yx/DE8dK8HXN
	 l5ojzpcl4gaOQ2RCMtPsty5w+neoTKVjwB1OszZYQIopzXNDs5z1EGFQHNBZ138M9t
	 yJzHvHg3EeCo38eEe1+fpwaCqLwYRL7IHFB08OjESqi9SUsFRODBpdETHzZ12GaG/H
	 73aVU46TLNASHb7Idt7dCLEegcn5GGDgg/scokArRapbx76RIMk4Igni8XQmuSWTeP
	 3oiS8985PDzGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E140180F05;
	Tue, 11 Aug 2026 05:19:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 982EA282
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7EA7A60634
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9G0NFxCVMCwH for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 05:19:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6E26160629
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6E26160629
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6E26160629
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:52 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AMpsTH2705347
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:51 GMT
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjk62evw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:51 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e667368f0so5160126a91.2
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:19:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786425590; x=1787030390;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dEyZl+81f6mXF4NvCmT9i0GPIOTQTt3uX2FpGhUUFcM=;
 b=Rq/CZHuFBkFcedSVB+ReSOK23W7KHN/HTUstUeGvJvALYwCymwh13zAd23Vob7P/fh
 kzMfBWq+IGLWgOiCbCdVdReKI9nnTSUmvwzQXePuOZ9TBA9iobtHuCZUy2FF1U7bawfQ
 o9cKScOwoySiw85vWqXJiYlpgJIDSkFbwDDTraS2ryBvTlzHJoxXRSwt4yRTt9q2mWAI
 F9IGPxETlaByMlIsy36LKm+uc0C+t6rCCeXv7Wb1PKHxief+wnsyFcnLNBFnQWPGL1By
 5ZyH57zltSK0IQLlmd8AGHufPV2U5VHEV/F3Uu/LlxjMY8TsXbWpKi0sFbla1qng7Hut
 SZow==
X-Gm-Message-State: AOJu0YxNjEaAkXqcTZ27CEyOQ8dskiwgP1e57qjpcbEcFJj6LOyHF8gw
 Hec4UrqOdzgyvgZLXIk5jI+1Yl/zf3+bF5RUsoChrLlBzigUabP7EYsgft/zJNIzqMPu8qtiRh0
 Dcfazab4e+U8lhgEXTEhfz3tv/gTOAztk2kq7T3RjsYGO6bQio8u4ArlDqW5jXDWav4NAQzg=
X-Gm-Gg: AR+sD13iekh3tgQAevWalouCzxvlIsmqAq5KOAET4YOJb/b29uTXWOf43QPFNRRubgt
 Qhzh2ekoOTO9QKXz6ggsNI11yS6BgFI8dleekNKDNwHAOgXEjeosB+BnQeRuOFfjgAKamoQtueq
 QLc1Ne0n1UdzUoekXoZh6ciOtqIJQQoo/cBhv6I7r7s8YVynGNFm37+otMW/lksqcdbQsGQjU4y
 Sl5NPQzc5pzDvLvk5ksavcUxjVa09VMCZmvnTVLsTlqFX//LLFUQzcz4uWOYiMdm5dTpJRa4M+g
 za8gUlXj82OmEJInTmLLAM64SARriJnOkFxZJUhW4vJ805ppbsyQV0q2Udfy12uEZthn1ZFBn+Y
 73IMejHP73VtBAtmTwuH8RUdHLyROEnUWKrRylaye1/+XDE+ABW2rWJV00V9PcAc7TArrNZpZVN
 IaOO59j6rhHcuYs9dAQ8drP871Rw9X
X-Received: by 2002:a17:90b:39ae:b0:37f:e326:6557 with SMTP id
 98e67ed59e1d1-392ec3626f9mr840592a91.4.1786425590083; 
 Mon, 10 Aug 2026 22:19:50 -0700 (PDT)
X-Received: by 2002:a17:90b:39ae:b0:37f:e326:6557 with SMTP id
 98e67ed59e1d1-392ec3626f9mr840553a91.4.1786425589543; 
 Mon, 10 Aug 2026 22:19:49 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31c619d01f8sm1353804eec.2.2026.08.10.22.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 22:19:49 -0700 (PDT)
Date: Tue, 11 Aug 2026 10:48:42 +0530
Subject: [PATCH 7/8] test: dm: reboot-mode: test trigger dispatch and mode
 enumeration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-b4-reset-edl-rebootmode-v1-7-2e15adc156a3@oss.qualcomm.com>
References: <20260811-b4-reset-edl-rebootmode-v1-0-2e15adc156a3@oss.qualcomm.com>
In-Reply-To: <20260811-b4-reset-edl-rebootmode-v1-0-2e15adc156a3@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Biswapriyo Nath <nathbappai@gmail.com>, Simon Glass <sjg@chromium.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786425541; l=4681;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=iRb3tFSoP1wDZvzmFuqjNG/T31Xch7nP4O3J9LwGdgE=;
 b=Mo+OnLSziIJOalrR2z2NcuVgXWOQww5YtD5lHjHeA1WwrM5lsj4yv2JuiSGhE/dFYXZq1QkTu
 R+AiBimZ3L5DUf+OlsHmeoRY2x+BDYJn6Ltm7JeepMco9hFPMFm97/A
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=Nb3WEWD4 c=1 sm=1 tr=0 ts=6a7ab0f7 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=0bRx7GVgnYojyll-HuEA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: QxcbuEOVx14PHGJJZSvwzjWC8-l34aKY
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA0MiBTYWx0ZWRfXzyHyN91dfv2t
 Bb8pbPt7S/i4seT/W+LlF/Me++VcS4Tq5xwmlRfOYyvGyaAcFfw3klZXyiXHRtsPh3zMpM6d1Yk
 wPJO1RGdahI2WPnXmy6iWdux//YsEYU=
X-Proofpoint-GUID: QxcbuEOVx14PHGJJZSvwzjWC8-l34aKY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA0MiBTYWx0ZWRfXzNat3EyY/ozW
 SJMQQbtoR6+HwUuTYOlkAR23RxyTPG1kbcVtd1r2/tf+9iop4ODyQoWiXSL8SnwGcw6Q+eNSmGx
 cqmviGMecO11UUTTpKcqdFav2/aBuS7hXwnf9oLKaqJpMKajUaWMbALUQAI6e766+o6CNpdYJFo
 oGddNE4qWAt9yBBoOfC7xIwbRx6eUj6mdO2yWM4rVcF/69qFhDnMrKCZ0OyOdvchgL3UTXFS6YQ
 vua9DouMvTFxnc1hCebXF1HG9WZplNpPIt0bdM/XNoD6FgsKPrUWE7N42eoe5x7NKyb+TI62K/M
 apoYPnySBJeZYXp9+cuSCGrNw8NIpFXXlBUccJ7xb4gSGXpu8PKMxdKCxL1w96Ztc67P9QPAM7E
 X4YQ6w8HN5XYMo8AepcYuoebEoG6F1pI+USpdY5//ux8L2TrkfYWHPQTLbkGWfvLqECMqF0FHla
 E7uN5x6HFFCAFL9Ol0Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110042
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dEyZl+81f6mXF4NvCmT9i0GPIOTQTt3uX2FpGhUUFcM=; b=AG1pGr2+QY/aUG1Y
 vyo+xx+73D7skY7WjlvGaFL3mtMp1ahV58k2KD5237KyD6agFQ8uun732fCKfrSM
 DgORPChR8pHnehOMohTaiDtr2llRAwv2Dr26XnmIWoiJo5EmS3sJFXvvzafdEv9x
 OSxsG5D+jdDNll2aWFugj9eXILevdBIkVhHzZTTGEVZBduXwFsY3HpiepC8nykUA
 ONrPPTGFBwFf/QVav+c6LG3yDbBMWfFQk8ZpbXmrPrnqIho3v85otSBMKNQkiAG/
 KMySxs0UGMI2vXHpLcyOJ85lb0qHzQgXKLjs4Ka5RkTbDPPU/VxO6Foz+R3uWk/K
 9sTYbw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786425590; x=1787030390;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dEyZl+81f6mXF4NvCmT9i0GPIOTQTt3uX2FpGhUUFcM=;
 b=kLobi9TqoWGF6e55f/t1EwxEOt5+yJPCIxAOvFQXmTww+OnYZxDX1nWbnFquL4UODV
 QecmiouFNeW95HSwF47byOJaQUo+7dpRN49R83XZXbU2enRLpLOVNGVfMzTf+ZiXAxpb
 ugCtiTkMkLEzUzZOKdM9ULUv9pkNT45VnaInyrRlwapDg+JveZlsZ+U0amkK9e/F6kfm
 CxMt62y2O+Zd24cwrEfW0UbNGZqQY26aZt8bD4WN0yLJ2VQ5Gv6xsLzzkipkzp5Q4cZ4
 EOqrRc6n/gFrmG//PkfBCiGtGqCYiS3QtO3aGJIzSjYVGiCd6h3LVA+LTKmaaPccZ1Nd
 y4Og==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=AG1pGr2+; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=kLobi9Tq
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
From: Balaji Selvanathan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add a trigger-only reboot-mode backend and two device tree modes to the
sandbox test tree, then cover the new trigger path:

  - reboot_mode_request() fires the owning device's trigger op with the
    correct magic cells for both a 2-cell and a 1-cell mode;
  - an unknown mode, and a backing-store-only mode (gpio/rtc), both return
    -ENOENT because they are not triggerable;
  - reboot_mode_list() enumerates only the triggerable modes and hides the
    backing-store modes.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 arch/sandbox/dts/test.dts |  6 ++++
 test/dm/reboot-mode.c     | 87 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index d24feec5422..a060c3a8a94 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -209,6 +209,12 @@
 		mode-download = <0x51939147>;
 	};
 
+	reboot-mode-trigger {
+		compatible = "reboot-mode-test-trigger";
+		mode-obelisk = <0x80000000 0x00000001>;
+		mode-sarcophagus = <0x80000000>;
+	};
+
 	audio: audio-codec {
 		compatible = "sandbox,audio-codec";
 		#sound-dai-cells = <1>;
diff --git a/test/dm/reboot-mode.c b/test/dm/reboot-mode.c
index 9a3b2bf0a43..7dbaea8c9cc 100644
--- a/test/dm/reboot-mode.c
+++ b/test/dm/reboot-mode.c
@@ -5,6 +5,7 @@
 
 #include <dm.h>
 #include <reboot-mode/reboot-mode.h>
+#include <console.h>
 #include <env.h>
 #include <log.h>
 #include <asm/gpio.h>
@@ -16,6 +17,42 @@
 #include <rtc.h>
 #include <linux/byteorder/generic.h>
 
+/*
+ * A trigger-only reboot-mode backend used to prove framework-driven dispatch
+ * and enumeration without touching hardware. Instead of resetting, its
+ * trigger() records the decoded magic cells so the test can inspect them.
+ */
+static u32 test_trigger_magic[REBOOT_MODE_MAX_MAGIC];
+static int test_trigger_count;
+
+static int test_trigger(struct udevice *dev, const u32 *magic, int count)
+{
+	int i;
+
+	test_trigger_count = count;
+	for (i = 0; i < count && i < REBOOT_MODE_MAX_MAGIC; i++)
+		test_trigger_magic[i] = magic[i];
+
+	/* A real backend does not return here; the test one does. */
+	return -EINPROGRESS;
+}
+
+static const struct reboot_mode_ops test_trigger_ops = {
+	.trigger = test_trigger,
+};
+
+static const struct udevice_id test_trigger_ids[] = {
+	{ .compatible = "reboot-mode-test-trigger" },
+	{ }
+};
+
+U_BOOT_DRIVER(reboot_mode_test_trigger) = {
+	.name = "reboot_mode_test_trigger",
+	.id = UCLASS_REBOOT_MODE,
+	.of_match = test_trigger_ids,
+	.ops = &test_trigger_ops,
+};
+
 static int dm_test_reboot_mode_gpio(struct unit_test_state *uts)
 {
 	struct udevice *gpio_dev;
@@ -66,3 +103,53 @@ static int dm_test_reboot_mode_rtc(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_reboot_mode_rtc,
 	UTF_PROBE_TEST | UTF_SCAN_FDT | UTF_FLAT_TREE);
+
+/* reboot_mode_request() triggers a named mode with the right magic cells */
+static int dm_test_reboot_mode_request(struct unit_test_state *uts)
+{
+	test_trigger_count = 0;
+	test_trigger_magic[0] = 0;
+	test_trigger_magic[1] = 0;
+
+	/*
+	 * "obelisk" is a 2-cell mode <0x80000000 0x00000001>. The trigger
+	 * backend records the cells instead of resetting and returns
+	 * -EINPROGRESS.
+	 */
+	ut_asserteq(-EINPROGRESS, reboot_mode_request("obelisk"));
+	ut_asserteq(2, test_trigger_count);
+	ut_asserteq(0x80000000, test_trigger_magic[0]);
+	ut_asserteq(0x00000001, test_trigger_magic[1]);
+
+	/* "sarcophagus" is a 1-cell mode <0x80000000> */
+	test_trigger_count = 0;
+	ut_asserteq(-EINPROGRESS, reboot_mode_request("sarcophagus"));
+	ut_asserteq(1, test_trigger_count);
+	ut_asserteq(0x80000000, test_trigger_magic[0]);
+
+	/* An unknown mode, and a backing-store-only mode, are not triggerable */
+	ut_asserteq(-ENOENT, reboot_mode_request("nonesuch"));
+	ut_asserteq(-ENOENT, reboot_mode_request("download"));
+
+	return 0;
+}
+DM_TEST(dm_test_reboot_mode_request,
+	UTF_PROBE_TEST | UTF_SCAN_FDT | UTF_FLAT_TREE);
+
+/* reboot_mode_list() enumerates only triggerable modes */
+static int dm_test_reboot_mode_list(struct unit_test_state *uts)
+{
+	ut_assertok(console_record_reset_enable());
+
+	ut_assertok(reboot_mode_list());
+
+	ut_assert_nextline("Available reset modes:");
+	ut_assert_nextline("  obelisk");
+	ut_assert_nextline("  sarcophagus");
+	/* Backing-store modes (test/download) have no trigger and are hidden */
+	ut_assert_console_end();
+
+	return 0;
+}
+DM_TEST(dm_test_reboot_mode_list,
+	UTF_PROBE_TEST | UTF_SCAN_FDT | UTF_FLAT_TREE);

-- 
2.34.1

