Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F337BC5AD7B
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 05:19:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 97F1640742;
	Tue, 11 Aug 2026 05:19:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n6_VgWxHaxeo; Tue, 11 Aug 2026 05:19:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 697F540726
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786425569;
	bh=V2e4OuEjemH5i5nAl0hSGWO2xtblIJ8b7s8wF0NJekA=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Occ+2kwTfpcibmhtJsb3s7GS4yL75fvR3lOBzL8jGtPASN3P5y0LeR+P0A3L41Jf2
	 CRWcyWDm/s57czaaqolTHxtZPTp+uvDggTvW5ZC/NG8vA4bF9WbJgl+nF0HKAj8LXz
	 xN5rdaoYvXK+69SLmJhQpkJDSgCn5Ym/PK9AVnkI6ka88iSJRkmnT+0WTo7GOydbq3
	 FxLrQDp/ZJ4JKSe7H2zBqR9Cvv1Uql9ZMNcXmcnn+gALFTGJodpdBYUjDtXl7Eoolg
	 EfRZUAspGqgP4oyP7pqxmU2wGU2Ha/QVKiJaXXqOvn8rh5ov9GCt9emOaQDFT3mlkQ
	 Cnjo4TwLkCAFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 697F540726;
	Tue, 11 Aug 2026 05:19:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 754CB345
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5B31340726
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kBjRnayAzvRg for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 05:19:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4FA4B4071B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4FA4B4071B
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4FA4B4071B
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:27 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AMqeg93049535
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:26 GMT
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjk22gj3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:26 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38f5ac7354dso5105712a91.1
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:19:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786425566; x=1787030366;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=V2e4OuEjemH5i5nAl0hSGWO2xtblIJ8b7s8wF0NJekA=;
 b=K1xtXXbD93zpRC4bbRbXFK0i6crTHgtN56AyRYKgUgN7ewymPqF9KgemRhqvs8Lm+F
 Dc69BuwfprFgwc1dYKKdfmJ4wFJ1l9hViZ6XT4qOjOml0e+0VkXU7/Z52tSmDpDpFSDc
 D7nhc0lNBPMhACq7jdbydN5QBlqQ0pfgHibbHxgSiUAGkbNRKEYXVvqAibmR5As8NJGh
 OT6bsYEG2JGGwJpVj9+b8BMtPibJiQvd/Ep81Uq/bbc1VQ7Gmgxb4FZy4rV0DwqNFkRN
 ZwUD01DK2cDrEZle1c6pyjU4K/096SojMzgWOtx/sQ3xJtRh2iY29G8m5w8fVFq4I+dk
 6C4g==
X-Gm-Message-State: AOJu0Yw230ukepWuhB4xJ+jl7zspTsrVFigEWgMclsmdIGpgK8ZBzmJ1
 3g9ioZNb3YS6bczWWNV6HkY4bdCC3Vik1WwOyxzyoPaVSXqFYqwyMqA57z6qotGF2J6PrU+FkvW
 YW8fPBBCBvZhlAZczZjkdmZ7xGX+m+aAQbum4268ur/ciPwEfcE1tjrgz10OzN5uWHDwoXuo=
X-Gm-Gg: AR+sD10zBQgR9PR3zfRrlL51KVh1XSySTyhZYGwixaY1c9lGoxIMqLUEI1D+utqFqeV
 pEHa0RI4Ejk+C/bgV0IVEVg394H8U1Lm7bECYXJ4tey6KjAyLaHpqM7ToP315zktbitF53G0Rv/
 DC5YKziAxKKKXQNCrZR0zNt1lSoF/JwdnaDrmT1IrHF/xkxrP+0Kq3u5+yYI6n+1w53Gunmj4SZ
 VrIQGFzd/RSwfdWF38c2F3Gp2da8rtVLT3syRqwpT6peBVo1KkUDstcvXgDJLfX+U4I0GXpvg1h
 vw4eIAPCIUZbSAOzpq+O3/CmR352vjB6DB9zIkcx6ZS0Ymvz6gNMNq+6nq3ujMU+doRyc5oeTVZ
 PgKjkWv41CQxz0BJO9HQvHRa8bDVgshYI0wFx4K0074zAHpOTWn2zLTe6I3hldMA9O6CE1b/Oj5
 1lxKwXgfIGPVvV3onfCGdPlOZYkFus
X-Received: by 2002:a17:90b:5608:b0:366:3517:1aa2 with SMTP id
 98e67ed59e1d1-392ec184a5amr886132a91.0.1786425565844; 
 Mon, 10 Aug 2026 22:19:25 -0700 (PDT)
X-Received: by 2002:a17:90b:5608:b0:366:3517:1aa2 with SMTP id
 98e67ed59e1d1-392ec184a5amr886106a91.0.1786425565391; 
 Mon, 10 Aug 2026 22:19:25 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31c619d01f8sm1353804eec.2.2026.08.10.22.19.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 22:19:25 -0700 (PDT)
Date: Tue, 11 Aug 2026 10:48:38 +0530
Subject: [PATCH 3/8] reboot-mode: add PSCI reboot-mode driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-b4-reset-edl-rebootmode-v1-3-2e15adc156a3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786425541; l=5451;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=wneWQGK4azTZ1nZedmlgNqn+CqmoTJeD6FEdWZe0CrM=;
 b=0eRTz1Fo/Tq9Iw4dxhRZYW4Eh3y8cjzdlwbwUOk0g5B/jQh66k1zftNeQRdVsZKEsvOOFeztI
 YTWloN7jYUEB6MaeyBEPE8cD2laVd3irySUHLMPBL7PIoWLeFy8v2YD
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA0MiBTYWx0ZWRfX7CwrZR0m6OqJ
 mPJFmtIrXHKb+3xomkxuCsvyWOkwiVBPxehZ8YMnOru5nC07iwG+gxedo95nCJk7kaeTevmwBCQ
 ujLDyusgv7iONz6yCJcBAlZAol8M7cU=
X-Proofpoint-GUID: R0HFypY30waWZL8YPih-mjmeqP33LYCG
X-Proofpoint-ORIG-GUID: R0HFypY30waWZL8YPih-mjmeqP33LYCG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA0MiBTYWx0ZWRfX6nmKAZiP9aOd
 AnSU6RcmkNMdcvEpv3SgvbPBjMbPLvIWQlbUcFRUBd/QlKH1f5MM6v23sRPvc72E1pHvYSk91AH
 sZLQBUpLgQDTlk51gSwki3KQrsePJY53elCzJmyxVA1burSekWLhifP2gWwjg4CqMXRr5y+7gPo
 viRAWverl6RHr6vxP+5sg9JgFOE/vxcXs/sTGLSd+qV/dFTeg1+A3ce2/XwkDqwd1G9sxhcnpjI
 r1WH4HPQb+v4W2cQeEE4kYoYgpbA4bN9cwQ1Uq1eSzFtsveFgU81rctZ1l3OqwYIBHRSqy6ih44
 gVGO7hR+olN6EkBcFQm9LQZcCMqKYhbgjAIWrPhHKopkoz8eNuIJR+bsaEWJoZIQtvTuQQhNSbk
 FwZiG8HV1Gnx0UylFOSAlcOnzl/2BwN8iwr0vymtkrOPImP+RTdy1HrLnxUGKxmu6RS0xCwogRA
 sEj7chiysuc/yC/c76A==
X-Authority-Analysis: v=2.4 cv=eJ4jSnp1 c=1 sm=1 tr=0 ts=6a7ab0de cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=6VbQ6MiErdNNtGIdj78A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110042
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 V2e4OuEjemH5i5nAl0hSGWO2xtblIJ8b7s8wF0NJekA=; b=N6yFUj1Dbncrs5l0
 znrui+PnGhrwGf8C162f7TtIDUg05fAzdvrJLS3udEUGt1C1YdRq2T8elowuhPyK
 mp1m6P9Mj8h1KBB6innix8XnQkacwA55GZZiivLvRNdhWZlqdsLMH+npVMkjvKug
 y/7V0w8ZUpgZU3HqpE1ulaCys7XqBSjFvl2Pus51MbN7BCvTLDEWkRgzayUQaWVq
 /nPNQ0mbxPdOSc+XpjjsHSxqQPtI+jk9WYw88jg1G6HE2xt/xwPqi0OvQ7xTlo5P
 9Nj9wz2X1J4QzKHxEsKWrJ7zLO/KPSKKiVt2PTMP0jCE6LD/raLU+7sbsyulkuHk
 bSi2kw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786425566; x=1787030366;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V2e4OuEjemH5i5nAl0hSGWO2xtblIJ8b7s8wF0NJekA=;
 b=hD9FlnpyuYALu6+QyCTslmf6zrx/RyE5KJrSqP4dG01fz118DoIU5zxM6WowRUeS5n
 aV5hs4Qx4xIhKLreL1OyrXXOosyiW6BgldNK20UWBKxsVjP2yQgLitE934GNkXNFlXho
 oOKvjC20s6OJ6Goz9PDGfmnZYRrib0Ts8yDfdaBJ5WbwcfXR+f6pgKtFOl9uHqI7lLjX
 0+DCezw6q7w1bECbQkpgvJW93ljw+IKIsHMgIjr0FWcUn9pRpPZIxfoG9CT3Tm9Nklke
 WaZe0hzu9ts7yBSr/y7ZMNVr9AoGDCVbpECikz+wTQVYHObBnpEgMoB4EASF83Op420a
 y9Mw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=N6yFUj1D; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=hD9Flnpy
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

Add a PSCI backend for the reboot-mode framework that triggers a
SYSTEM_RESET2 vendor-specific reset described by a "mode-*" property under
a "reboot-mode" subnode of the PSCI device tree node (for example
"mode-edl = <0x80000000 0x00000001>" to enter Qualcomm EDL/download mode).

All device tree parsing and name matching already live in the reboot-mode
uclass; this driver only turns a decoded set of magic cells into a
firmware call.

U-Boot's psci_system_reset2() client takes only a 32-bit cookie and ORs in
PSCI_RESET2_TYPE_VENDOR itself, so the trigger folds the low cells into a
cookie and rejects a 3-cell mode whose cookie_hi is non-zero rather than
silently truncating it.

psci_bind() binds the driver to the "reboot-mode" subnode when
CONFIG_REBOOT_MODE_PSCI is enabled, using device_bind_driver_to_node().

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/firmware/psci.c                | 16 ++++++++++
 drivers/reboot-mode/Kconfig            | 11 +++++++
 drivers/reboot-mode/Makefile           |  1 +
 drivers/reboot-mode/reboot-mode-psci.c | 58 ++++++++++++++++++++++++++++++++++
 4 files changed, 86 insertions(+)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index 2e3223e1c32..781a848e350 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -188,6 +188,22 @@ static int psci_bind(struct udevice *dev)
 			pr_debug("PSCI System Reset was not bound.\n");
 	}
 
+	/*
+	 * Bind the PSCI reboot-mode driver to the "reboot-mode" subnode so it
+	 * can trigger SYSTEM_RESET2 vendor resets described by "mode-*"
+	 * properties there (for example EDL/download mode).
+	 */
+	if (CONFIG_IS_ENABLED(REBOOT_MODE_PSCI)) {
+		ofnode rm_node = ofnode_find_subnode(dev_ofnode(dev),
+						     "reboot-mode");
+
+		if (ofnode_valid(rm_node) &&
+		    device_bind_driver_to_node(dev, "reboot-mode-psci",
+					       "reboot-mode-psci", rm_node,
+					       NULL))
+			pr_warn("PSCI reboot-mode was not bound.\n");
+	}
+
 	/* From PSCI v1.0 onward we can discover services through ARM_SMCCC_FEATURE */
 	if (IS_ENABLED(CONFIG_ARM_SMCCC_FEATURES) && device_is_compatible(dev, "arm,psci-1.0"))
 		dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
diff --git a/drivers/reboot-mode/Kconfig b/drivers/reboot-mode/Kconfig
index 3fdb4218a8b..109a196a3c9 100644
--- a/drivers/reboot-mode/Kconfig
+++ b/drivers/reboot-mode/Kconfig
@@ -39,4 +39,15 @@ config REBOOT_MODE_NVMEM
 	  Use any kind of non-volatile memory (EEPROM, RTC, etc) to control the
 	  reboot mode.
 
+config REBOOT_MODE_PSCI
+	bool "Use PSCI SYSTEM_RESET2 vendor resets as reboot modes"
+	depends on DM_REBOOT_MODE && ARM_SMCCC
+	help
+	  Trigger PSCI SYSTEM_RESET2 vendor-specific resets (for example
+	  rebooting a Qualcomm SoC into EDL/download mode) via the reboot-mode
+	  framework. Each reset is described by a "mode-*" property under the
+	  "reboot-mode" subnode of the psci device tree node, so the magic
+	  values are not hard-coded in the driver. The modes can then be
+	  triggered from the "reset" command by name.
+
 endmenu
diff --git a/drivers/reboot-mode/Makefile b/drivers/reboot-mode/Makefile
index 48c8ab7fe71..56c7078258b 100644
--- a/drivers/reboot-mode/Makefile
+++ b/drivers/reboot-mode/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_DM_REBOOT_MODE) += reboot-mode-uclass.o
 obj-$(CONFIG_DM_REBOOT_MODE_GPIO) += reboot-mode-gpio.o
 obj-$(CONFIG_DM_REBOOT_MODE_RTC) += reboot-mode-rtc.o
 obj-$(CONFIG_REBOOT_MODE_NVMEM) += reboot-mode-nvmem.o
+obj-$(CONFIG_REBOOT_MODE_PSCI) += reboot-mode-psci.o
diff --git a/drivers/reboot-mode/reboot-mode-psci.c b/drivers/reboot-mode/reboot-mode-psci.c
new file mode 100644
index 00000000000..88133c68ab4
--- /dev/null
+++ b/drivers/reboot-mode/reboot-mode-psci.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ */
+
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <reboot-mode/reboot-mode.h>
+#include <asm/psci.h>
+#include <asm/system.h>
+#include <linux/errno.h>
+
+static int psci_reboot_mode_trigger(struct udevice *dev, const u32 *magic,
+				    int count)
+{
+	u32 reset_type = magic[0];
+	u64 cookie = 0;
+	int i;
+
+	if (count < 1 || count > REBOOT_MODE_MAX_MAGIC)
+		return -EINVAL;
+
+	/*
+	 * U-Boot's psci_system_reset2() takes only a 32-bit cookie, whereas
+	 * the binding allows a 64-bit cookie in the 3-cell form (magic[1] is
+	 * cookie_hi, magic[2] is cookie_lo). Reject a non-zero high half
+	 * rather than silently truncating it.
+	 */
+	if (count == REBOOT_MODE_MAX_MAGIC && magic[1]) {
+		dev_err(dev, "64-bit reset cookie is not supported\n");
+		return -EINVAL;
+	}
+
+	for (i = 1; i < count; i++)
+		cookie = (cookie << 32) | magic[i];
+
+	if (psci_features(ARM_PSCI_1_1_FN64_SYSTEM_RESET2) !=
+	    ARM_PSCI_RET_SUCCESS) {
+		dev_err(dev, "SYSTEM_RESET2 is not supported by firmware\n");
+		return -EPROTONOSUPPORT;
+	}
+
+	/* Does not return on success. */
+	psci_system_reset2(reset_type, (u32)cookie);
+
+	return -EINPROGRESS;
+}
+
+static const struct reboot_mode_ops psci_reboot_mode_ops = {
+	.trigger = psci_reboot_mode_trigger,
+};
+
+U_BOOT_DRIVER(psci_reboot_mode) = {
+	.name = "reboot-mode-psci",
+	.id = UCLASS_REBOOT_MODE,
+	.ops = &psci_reboot_mode_ops,
+};

-- 
2.34.1

