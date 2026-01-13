Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A1ED0C84A
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 10:39:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E023E83693;
	Tue, 13 Jan 2026 11:39:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lvhyrYTl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O605p4Dd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5E648004F; Tue, 13 Jan 2026 11:39:00 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80ADE83693
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 11:38:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60D5Sq3C3868770
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 10:38:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=rYLAcMJ92RZ
 Ss6Xbe/HVS7HYg7ioJFQopCfEnZzH4NI=; b=lvhyrYTlG8enDI7FIP+GjvnZS16
 gfYz4Xv096MxjV1r0HYGXHD0if71C+L/5QwQDu735kZTFRXGjsEE2mr8heIOF++w
 4CyDS7L6AIe83hs4XVoRO3iAqNVP3cxBcJyuupd0ftLh7+QHj5YeOpR1kb45v65G
 bZLjIFSM/dUpGfiPb5xcSMkTmvzUZC9QFn7/wPwFtda4PRtK+kBUHcO3Jc4v59qX
 76kP6c2CSQqWZqmDk2prKS/4Ychwc+l11Q5PGQEUkOEOb8C9ue+HGm3ovxJ4By+P
 18iapHAu6fnQbKaxDN8f+/ikjhyhDvZ04RR/xM+Xl0uWXncR6Jxzza9ApnQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bnfxk8x1q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 10:38:56 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-7f89d880668so5763277b3a.2
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 02:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1768300736; x=1768905536; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rYLAcMJ92RZSs6Xbe/HVS7HYg7ioJFQopCfEnZzH4NI=;
 b=O605p4Ddwmlij3MwEFVMq2StTlxqNelNq6lo7wb58ekZeC6/XHqQe5rW/q7v9xvCBB
 /5Gyn3dcDy1rODlH2hZeOwZ4Ep7gbddB7N+WdUTMmNfWYVNBJtiMCzIfUCXRBJKhTBWm
 a6lnR4nzvJJ06vkscZWj4kgOzaYYwqR9HcONYW7wcSJfWxozWR9ms+AxoQ4uWl9rMAms
 xXzCadqG+zLU/6q6yTNi/o3/kFKzGishIw4wk+uO8iY9zFup0FoDGg+Y0dH6lUcPVhuG
 llQJEDXL6mvqachpLTc8RYek5OTdqarE9PuNzDW5kmBjW6arRxJG2fGirT3qsjyJspKA
 TtMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768300736; x=1768905536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rYLAcMJ92RZSs6Xbe/HVS7HYg7ioJFQopCfEnZzH4NI=;
 b=LkLE/tgMgHnEDRC5zHNpEX/E44OV5bd3aatYPbi8fhBLqxQo49kFIHFzTyYp0WKGTP
 PO4+fGagrXb/mI6i0FmnW2adrUYoV9L/BS4BN+YJvFw+SkVGF1JN5pJE9z4UiUFt+CfC
 GDuR3VaY7f4xh1XZe8iYnl+sW4fWMNKoIW6ptVOaY9ijWb7Y4rDXTphLQULc54DmQ4dB
 UGxvkP+e8ieG+UTGep/blR44u8nmBOIsK6fVCZegsmHSDkIx+bToE2YP+VW4FFVB5nun
 CXqm+lOp+uJYfglcc0nY8paaUnhY9oP8pmAHY2ZGbx8TOoKmg0g3TLZW+c1A3FO6U1kf
 cMsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/Sq+iHogxST2wil7I/8YnMZojftHY1pRm9idT28j+6wcbdYTQL/cO2H/hmon0/T8nd2XflQo=@lists.denx.de
X-Gm-Message-State: AOJu0Yxqf9qjQvpa2lE5AZxMSmgPaQWQQefx3XpEn8Q50DdWiJEnYJNf
 eLPrZVUvNkvzvucc+V9FTGMNrORAhUylrXIfNkyLM/qgjXL+oeHirkRb4UPDF9y7vQqECGl03Fm
 hIMZxJz739ncM377reZCiDiriHHKweBzaf5lCIMjNqAOrXd/OtbSstdER
X-Gm-Gg: AY/fxX4mgTw41Cpol53Lrn1JxH1LuxUoAn7GKP6NiCawX3zh7aVXSovPwT8LG+M2Wib
 pAn2ZR9xKCc3G4AX2MPAaQdhUFeDA+wEM1RC4xbfDtFE74UbY/8M05cmgA9yYTDk3jxBhaghXpL
 dMSFq74vpRUkzfSnd8tQBDY+S2VwHB9DKQB7lxgPGqZNSXunBDLtW5yKjCvJ6QeX8ejU++aFaXv
 cvvPkitRz8Xor38+G4E9EEO5ymGVDl8kxr4qiUNOX9oiX8L0f5xhQhfj2ZdWBwHC6LmfMJ9MXbQ
 2cgNPWEcrjUaPLRum75IUsXfgEiIECDIDCMNI3at+SsNHpAwCyzqCoPu5hYUo8mQQMSwmITnHc1
 Eg06P5LhOOE75gFZ6Fa7Ek06qqL5snxDQMMjlbTJevQrglg7SJHCFWkEtSqufhNVq6aebMbTiSh
 CfDoLwUTun54Vu25WbbY4Wm8qkeCMC/Mi05p7nqY4=
X-Received: by 2002:a05:6a20:549d:b0:341:262f:6510 with SMTP id
 adf61e73a8af0-3898f9ba35dmr20183865637.41.1768300735741; 
 Tue, 13 Jan 2026 02:38:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJpvBG0MybRWcgg/IcyApeXO/nmb8qf/Oi/+318UwwJQM4wrPYCBEc7NiN1gF5cpGv93XrZQ==
X-Received: by 2002:a05:6a20:549d:b0:341:262f:6510 with SMTP id
 adf61e73a8af0-3898f9ba35dmr20183828637.41.1768300735206; 
 Tue, 13 Jan 2026 02:38:55 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cb2dd4sm195286965ad.47.2026.01.13.02.38.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 02:38:54 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, varadarajan.narayanan@oss.qualcomm.com,
 ilias.apalodimas@linaro.org, jerome@forissier.org,
 marek.vasut+renesas@mailbox.org, christopher.obbard@linaro.org,
 me@samcday.com, michal.simek@amd.com, clamor95@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v5 2/5] drivers: sysreset: Add sysreset op that can take
 arguments
Date: Tue, 13 Jan 2026 16:08:37 +0530
Message-Id: <20260113103840.1948029-3-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260113103840.1948029-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260113103840.1948029-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: RUnRUISffBJCc4rDAufGTeK8idZw6gey
X-Proofpoint-GUID: RUnRUISffBJCc4rDAufGTeK8idZw6gey
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA5MCBTYWx0ZWRfX1r5ea0o1/2aD
 1w6vbx+66wFKvD6bH0tTu6CJddhQENWgz+fzeUUozitKIrqBTL1t/H6WItUH0qT5nnFSlOF1NRc
 iSpbP5M/RvcriT8Nard0BrHsfVR7pKUkXL4fJCv8seb4xOwQ2xoq+INbGzIo+mgnBR+zN3zU0JH
 hoc/Nfczcw3R7fneEbQixAM2vLb/ZyJN/CL9qh/tNQ+cccBzP+t68/UK3FnKdhxQQ1MGaiR4aI9
 zkP7/gGU7H6GMsOkx3C935y3v+RjbTVL59MXB4cXbQ+Lj9lzjlkWxyqEi0CNEnGPU72UzGwDY+3
 ttDZQa5vjzQ9jkyYzE1FQq4mzJFBs28kkuULZy6AsMYV1zkMmxKxlHJ7HG168FsmwxMyBg5awCd
 Ho1Q9cQuImPgfuoQxTO3rldbAJR0gE6DRqUt6OoG+z8mpXW83n13LdDh8FMkLkBTPJk4mIsgFjB
 P7znMYqHWrbRGzwyKTQ==
X-Authority-Analysis: v=2.4 cv=PvSergM3 c=1 sm=1 tr=0 ts=696620c0 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=v2ldV8uNSCBI4ujoSEIA:9
 a=2VI0MkxyNR6bbpdq8BZq:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601130090
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

Add a 'request_arg' op to struct sysreset_ops to enable sysreset drivers
to receive arguments given to the 'reset' command. Process the
request_arg() op before the usual request() op.

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 drivers/sysreset/sysreset-uclass.c | 32 ++++++++++++++++++++++++++++++
 include/sysreset.h                 | 18 +++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
index 536ac727142..6eb090a37aa 100644
--- a/drivers/sysreset/sysreset-uclass.c
+++ b/drivers/sysreset/sysreset-uclass.c
@@ -32,6 +32,16 @@ int sysreset_request(struct udevice *dev, enum sysreset_t type)
 	return ops->request(dev, type);
 }
 
+int sysreset_request_arg(struct udevice *dev, int argc, char * const argv[])
+{
+	struct sysreset_ops *ops = sysreset_get_ops(dev);
+
+	if (!ops->request_arg)
+		return -ENOSYS;
+
+	return ops->request_arg(dev, argc, argv);
+}
+
 int sysreset_get_status(struct udevice *dev, char *buf, int size)
 {
 	struct sysreset_ops *ops = sysreset_get_ops(dev);
@@ -71,6 +81,24 @@ int sysreset_walk(enum sysreset_t type)
 	return ret;
 }
 
+int sysreset_walk_arg(int argc, char * const argv[])
+{
+	struct udevice *dev;
+	int ret = -ENOSYS;
+
+	while (ret != -EINPROGRESS && ret != -EPROTONOSUPPORT) {
+		for (uclass_first_device(UCLASS_SYSRESET, &dev);
+		     dev;
+		     uclass_next_device(&dev)) {
+			ret = sysreset_request_arg(dev, argc, argv);
+			if (ret == -EINPROGRESS || ret == -EPROTONOSUPPORT)
+				break;
+		}
+	}
+
+	return ret;
+}
+
 int sysreset_get_last_walk(void)
 {
 	struct udevice *dev;
@@ -132,6 +160,10 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	printf("resetting ...\n");
 	mdelay(100);
 
+	if (argc > 1)
+		if (sysreset_walk_arg(argc, argv) == -EINPROGRESS)
+			return 0;
+
 	sysreset_walk_halt(reset_type);
 
 	return 0;
diff --git a/include/sysreset.h b/include/sysreset.h
index ff20abdeed3..d1cc9ebc542 100644
--- a/include/sysreset.h
+++ b/include/sysreset.h
@@ -43,6 +43,24 @@ struct sysreset_ops {
 	 * (in which case this method will not actually return)
 	 */
 	int (*request)(struct udevice *dev, enum sysreset_t type);
+
+	/**
+	 * @request_arg: Reset handler implementations that might need to process
+	 *		 arguments given to the 'reset' command.
+	 *
+	 * Note that this function may return before the reset takes effect.
+	 *
+	 * @dev:	Device to be used for system reset
+	 * @argc:	No. of items in @argv
+	 * @argv:	Arguments given to 'reset' command
+	 * Return:
+	 * -EINPROGRESS		if the reset has started and will complete soon
+	 * -EPROTONOSUPPORT	if not supported by this device
+	 * 0			if the reset has already happened
+	 * (in which case this method will not actually return)
+	 */
+	int (*request_arg)(struct udevice *dev, int argc, char * const argv[]);
+
 	/**
 	 * @get_status:	get printable reset status information
 	 *
-- 
2.34.1

