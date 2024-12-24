Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942A6E77188
	for <u-boot@archiver.kernel.org>; Tue, 24 Dec 2024 16:02:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 760C2807DE;
	Tue, 24 Dec 2024 17:01:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zb3mkwJO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA5D5807DE; Tue, 24 Dec 2024 17:01:52 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88666801F5
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 17:01:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6d8e8cb8605so27455176d6.0
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 08:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735056109; x=1735660909; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2v44yJMOddWJK/ZNBTpR7f3UP3dJnUL4WcwKStHPLvI=;
 b=zb3mkwJOLCCGYXppjhKTr/WSCp8PiMfqwhG2aNXqsqo2gy96YsD2hCJkFQjVTm5iV+
 61TOdJmdAnN0GQUAnRuC2uV8TjL3m84HixHLOfMUxxA2WgNybLgeQkewvnh4Hv15mthl
 P6Q9HYkBK2NlWym01Zl5j3sp7ZH47tMlPhcA3+2OEVLmgvO+hJSntnpL+DkFqLc75uGe
 rchBISHZHBPP7KZ6Mf79bQsHitKxFbxSxclcHqGOLg+JQju5h04gMlVlhIFk3Y2nboxh
 ax14NdtSiZWIslJZoKBw+nHXMZ+m0YHFzSoFOtHgMy43TvvHoXR2KNcnjKDxpJEtFWdk
 Dnig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735056109; x=1735660909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2v44yJMOddWJK/ZNBTpR7f3UP3dJnUL4WcwKStHPLvI=;
 b=edZ84bnHmJ77PUx36kWUnvwMr6n+5L38AYiru5qch7c70dZEdR/x+RSe/KjkWw3b6B
 cAlxmCJRagZfmghbyR40dnHgQi675dRRmduCeI3sTFBfXa0XBg2ft9pHSaYYtPsSX4+z
 GJ6hxJhx8747wf3Q2Sot7RvuA2rR97728rd1wETUkU8ikJWiXuUcsA+ZT6NeYstAy4QP
 sjJfMkWITaqCNsD47hpGAZ4eqzmsSj0nNhEjPMY0Y0vApFBwBj65Pwm9YYMIX1QT0Z0g
 GRzjXhZs07INyCAkcQ1eUtCoQhL7CP/MSXJxq0Kiy0jb9eI8ovvYp/T6zZd6Ehfn2amc
 3h2Q==
X-Gm-Message-State: AOJu0YwyWMKqXTjIRMtOguZp4uuTVtFA/3/MZgdz81blX7tZJnfzup/+
 txMxriIFLGVsO3up1D+0u/7U/3H17CqXtczf2ZBi+5KsKcmSAPuGHZPDHIB41EG3jtkMk/Nj0dM
 b
X-Gm-Gg: ASbGncvIBx9CJ6KikdcTrV5LvPBDC3GpPCVcnIb4JNONa/UUzSsJlxXXhOtCDfB0YqA
 UZTHHjt95XIAEdY9jHqsKh1BmoOzBVwXph6rrx7ppGbjQCC1u6q0I7Oq9SwHtcW/EpyOk7UKWcQ
 kbC45lZqmuS8VBXdQLgxGWPzSPKcP6KJ7XR0yaUE0e/O3CficLVFE7Qy8no6177CEzj29lTXudc
 EJiAGPX89WfTwVltedAHmcY8TgF/a75LCyyoFVVXjGqPlXAtWgE82/yccVR4c+RApH6M1yh7wLK
 6JkO83T6i7FTHcO1bGHA++OpRigqmUloLTgCjB2Xr5BxHHs0v14KPE4=
X-Google-Smtp-Source: AGHT+IGGzn8pjbF0ocd7Aco+MqwZDgRaeGyvZErR960mDLeoW0uRhiLFK9q3FMlIirRcvg4iWhjDDg==
X-Received: by 2002:a05:6214:4290:b0:6d4:1a42:8efa with SMTP id
 6a1803df08f44-6dd230cbcabmr271865426d6.0.1735056109284; 
 Tue, 24 Dec 2024 08:01:49 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181d432asm53840816d6.110.2024.12.24.08.01.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 08:01:48 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tim Harvey <tharvey@gateworks.com>, Simon Glass <sjg@chromium.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH v2 03/11] tpm: Rename tpm2_allow_extend()
Date: Tue, 24 Dec 2024 08:01:05 -0800
Message-Id: <20241224160118.675977-4-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241224160118.675977-1-raymond.mao@linaro.org>
References: <20241224160118.675977-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Ilias Apalodimas <ilias.apalodimas@linaro.org>

When that function was introduced we were only using it to check if
extending a PCR was allowed, so the name made sense. A few patches ago
we used that function to reason about the EventLog creation and general
usage of PCRs , so let's rename it to something more generic that makes
more sense in all contexts.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- None.

 include/tpm-v2.h | 5 +++--
 lib/tpm-v2.c     | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/tpm-v2.h b/include/tpm-v2.h
index 8c43f4fd9b..87b2c614ad 100644
--- a/include/tpm-v2.h
+++ b/include/tpm-v2.h
@@ -732,12 +732,13 @@ u16 tpm2_algorithm_to_len(enum tpm2_algorithms algo);
  */
 
 /**
- * tpm2_allow_extend() - Check if extending PCRs is allowed and safe
+ * tpm2_check_active_banks() - Check if the active PCR banks are supported by
+ *                             our configuration
  *
  * @dev: TPM device
  * Return: true if allowed
  */
-bool tpm2_allow_extend(struct udevice *dev);
+bool tpm2_check_active_banks(struct udevice *dev);
 
 /**
  * tpm2_is_active_bank() - check the pcr_select. If at least one of the PCRs
diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index cb636414de..0edb0aa90c 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -197,7 +197,7 @@ u32 tpm2_pcr_extend(struct udevice *dev, u32 index, u32 algorithm,
 	if (!digest)
 		return -EINVAL;
 
-	if (!tpm2_allow_extend(dev)) {
+	if (!tpm2_check_active_banks(dev)) {
 		log_err("Cannot extend PCRs if all the TPM enabled algorithms are not supported\n");
 		return -EINVAL;
 	}
@@ -896,7 +896,7 @@ u16 tpm2_algorithm_to_len(enum tpm2_algorithms algo)
 	return 0;
 }
 
-bool tpm2_allow_extend(struct udevice *dev)
+bool tpm2_check_active_banks(struct udevice *dev)
 {
 	struct tpml_pcr_selection pcrs;
 	size_t i;
-- 
2.25.1

