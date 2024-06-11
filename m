Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C733C27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 20:03:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF56F8877E;
	Tue, 11 Jun 2024 22:02:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cuFMjDUl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D888688755; Tue, 11 Jun 2024 22:02:24 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA469883F4
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 22:02:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-36dd6110186so6676775ab.0
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 13:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718136141; x=1718740941; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TJatQ67wLsUKufFx8+ZIAVVElx7A/F8+oG5u3y8kT7g=;
 b=cuFMjDUlcdT11GVJyfTsCQUk005JNmEfzDpX+k2XXvyTe4qRrgakh/867XG77GZvbZ
 fWFWdT0E6EsDPT/waOAxSrS2jETH6wbyz/yMDzlWTzApy2xZ1jcuNFlPFZXj+lQ+haoJ
 cNHWH10m4hG1p7vyhtdh31OPrbouPus7sWPTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718136141; x=1718740941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TJatQ67wLsUKufFx8+ZIAVVElx7A/F8+oG5u3y8kT7g=;
 b=g0JGxNymRETSWVxwx2VxGBSLtPWYWEtouU92mSpFp/wJoeH6+DUARgUme9PKt6jLst
 ndwqlTNUmRdcT6o9Zr6W7DW5H8hMM3xIqVH68oytzelUrBIw8uJWJK8UsXgqVzTDz0Pf
 Erva3bj67EoH3EkvuH5OBuX9hhxIA89RHGq7nAZ9GdtDn1HZ2UbK833iLNIrM501SL2W
 RYSaKgrZ7bJ0OlFQe4vMK9HQxy4xdH3PH4YA0sOwqpnHwMPXmHpD/1bZb8jofnJMMBMc
 f/BWyCw3CGecHfWxNuUGGaoN3FnaRlhRQ7hff0MCiuhZdcn5MFj26g9jDQ3AGYD/JAXB
 izmw==
X-Gm-Message-State: AOJu0Yzi3txJxrdnj3zHgUeIUeRfN6/eGykwkNTyjU0CSR9ps8+FXz4G
 jYEL/lwuycRHE9P8jGp+JBm+Ato7mrPIFvOKB6Y9ljkU7F7EfzmFh4WQz68AkP/FOP8IxlgCxdy
 bGA==
X-Google-Smtp-Source: AGHT+IF7CR4uSpto4C0/bEmtlGSVNtiauEiGBhDMxE3fudHfxb4OgtZdiRtxEo749C2e2ETKApN7Fw==
X-Received: by 2002:a92:ca07:0:b0:375:9ecb:acd3 with SMTP id
 e9e14a558f8ab-3759ecbb3f2mr89232755ab.9.1718136141460; 
 Tue, 11 Jun 2024 13:02:21 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375ca7617cbsm1119305ab.30.2024.06.11.13.02.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 13:02:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 09/42] buildman: Avoid rebuilding when --mrproper is used
Date: Tue, 11 Jun 2024 14:01:23 -0600
Message-Id: <20240611200156.2245525-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611200156.2245525-1-sjg@chromium.org>
References: <20240611200156.2245525-1-sjg@chromium.org>
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

When this flag is enabled, 'make mrproper' is always used when
reconfiguring, so there is no point in doing it again.

Update this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/buildman/builderthread.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/buildman/builderthread.py b/tools/buildman/builderthread.py
index 0a7ff2e083e..c0b1067e3f7 100644
--- a/tools/buildman/builderthread.py
+++ b/tools/buildman/builderthread.py
@@ -700,7 +700,7 @@ class BuilderThread(threading.Thread):
                         job.work_in_output, job.adjust_cfg)
                 failed = result.return_code or result.stderr
                 did_config = do_config
-                if failed and not do_config:
+                if failed and not do_config and not self.mrproper:
                     # If our incremental build failed, try building again
                     # with a reconfig.
                     if self.builder.force_config_on_failure:
-- 
2.34.1

