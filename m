Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 186BEC83F03
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 04:23:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 564A383394;
	Wed,  9 Jul 2025 06:23:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DjWFqobY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9ABF9833FA; Wed,  9 Jul 2025 06:23:47 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2159083390
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 06:23:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-40ba3c10b3bso1535119b6e.1
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 21:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752035024; x=1752639824; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ynILmVRpyGRxYoc8vapKuO8pDpVgQPFsPuAa7jNXshk=;
 b=DjWFqobYJ1/tZmWOjL2dkdI3zSqo3fexdWh9e9OQT2AeRapEhBp89/aEEm9nrvPVVI
 FFrFegN/oN4sEPPdI1aywfe/vJMx+uCxsfbD4RtF4HiMTuCaM7EBAG+5Iw0xJ87RBX74
 0Y9Z/lvxu3sJ1RhXLFSPV5M0VxCzDnekIplRUl8Lf1KbJ4Qq6hCe+MV3llJxOLFHMr7C
 CWw2mYNBvuYPCfx32cdSwKlPCYWwOiI/4X8qxXqVBS+3ANOOcUXaizlaz+dqVSdwi0jv
 YyHBkmiHDvA4mlHMeCJ4k8AqtWxxGFwBiIy0K2lWe12RKs8Qf+VZCyooW1DyVZFZXXr2
 sp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752035024; x=1752639824;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ynILmVRpyGRxYoc8vapKuO8pDpVgQPFsPuAa7jNXshk=;
 b=RgG0TEfiV1WdyaBoO8cNMBEbFzHIRzQTdVuBsj24UmiajFwjwuZwu6+3gEkRq2yIdE
 z+eSHnN4ZJkGtl+X1Cn4l2yVa8TjdHuoxehUPOexbqP66brKSZQoHbU8lH+/iHM86jwc
 lTKfYIyDi0Hpvf+QuzB/QJ81Fehy/nnYLGtmEsEuntEWoXn+OMf22Fqn3uaHl2xvHV0J
 EJ7DDGDNf9r2m36BZbqa6E59mSdBCRuvMIZk855WhEZX9EN9CvgegXR1/dxYeo2DUevA
 PGbzu2gBZKts/f8aQvqNq2lFubIOURg5kxAa/ECRKO1v74RJoEqsiqaP1JUTSQ1dZrtc
 w6Sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0Aqi/kp820RoReEfdIcn68bVIZuG99IcGnKWbqsgNNW+sSfQDZPb+GkzhNtMW+37fJFpTfpo=@lists.denx.de
X-Gm-Message-State: AOJu0YyKnapHpfOpjfspyuMySGNps8z31OaQILuVE0SkAQshiA1tCrps
 aMINRS625s2e1FNypET8BYrnaqQeTV/IPRacwRQHK2c2YPnosZ+r//7BxnL16f2UDqw=
X-Gm-Gg: ASbGncv8nIUpEdKH2bOiX3cITEMSa42BqcClO0/84hZWwweYi4e8nQHQHIUlxL7vKB1
 Qa7OINHInlgX//UF/tbK3OYBAHVqzYh/7iFzcdXw55TOGrufaTTp1b75sAjtsbp6Hgv8Zl4GtsC
 d9R+trpnsGLIzshld/eFJfK1MFCu5snQ6BOkzwvQDcVUYd6tArYNymTIAAz1Lup6cqY+6PHm7Qu
 3ppZDLqP2DpDhNE/CMxX+SKMcmojc68/lxFub0PXbNmIAt6vTSTPiOjVBiPoOYcYgmw7mtsRsUc
 GxZS8Z5S6q92vlvfPB/eEboErAydgNzaxAP2Y2sLoa3QR/wYG3IQ08BWL1pceBM12KrsHRsy+NJ
 UKp+zCjU=
X-Google-Smtp-Source: AGHT+IE4FTFvAsHI1/M3WSxfJLN/Haq6LpuLCoAogwlwdA/FcZmISHLL+obakfpJ5vmWtwtgvI5AvA==
X-Received: by 2002:a05:6808:1901:b0:406:7186:5114 with SMTP id
 5614622812f47-412bcf940f9mr855908b6e.36.1752035023674; 
 Tue, 08 Jul 2025 21:23:43 -0700 (PDT)
Received: from localhost ([2605:a601:a0f4:b000:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f79020c7c6sm3261638fac.35.2025.07.08.21.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 21:23:43 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Subject: [PATCH] dfu: Fix dfu_config_interfaces() for single interface DFU
 syntax
Date: Tue,  8 Jul 2025 23:23:42 -0500
Message-Id: <20250709042342.13544-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
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

As stated in DFU documentation [1], the device interface part might be
missing in dfu_alt_info:

    dfu_alt_info
        The DFU setting for the USB download gadget with a semicolon
        separated string of information on each alternate:
            dfu_alt_info="<alt1>;<alt2>;....;<altN>"
        When several devices are used, the format is:
            - <interface> <dev>'='alternate list (';' separated)

So in first case dfu_alt_info might look like something like this:

    dfu_alt_info="mmc 0=rawemmc raw 0 0x747c000 mmcpart 1;"

And in second case (when the interface is missing):

    dfu_alt_info="rawemmc raw 0 0x747c000 mmcpart 1;"

When the interface is not specified the 'dfu' command crashes when
called using 'dfu 0' or 'dfu list' syntax:

    => dfu list
    "Synchronous Abort" handler, esr 0x96000006, far 0x0

That's happening due to incorrect string handling in
dfu_config_interfaces(). In case when the interface is not specified in
dfu_alt_info it triggers this corner case:

    d = strsep(&s, "=");  // now d contains s, and s is NULL
    if (!d)
        break;
    a = strsep(&s, "&");  // s is already NULL, so a is NULL too
    if (!a)               // corner case
        a = s;            // a is NULL now

which causes NULL pointer dereference later in this call, due to 'a'
being NULL:

    part = skip_spaces(part);

That's because as per strsep() behavior, when delimiter ("&") is not
found, the token (a) becomes the entire string (s), and string (s)
becomes NULL. To fix that issue assign "a = d" instead of "a = s",
because at that point variable d actually contains previous s, which
should be used in this case.

[1] doc/usage/dfu.rst

Fixes: commit febabe3ed4f4 ("dfu: allow to manage DFU on several devices")
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/dfu/dfu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dfu/dfu.c b/drivers/dfu/dfu.c
index 756569217bbb..eefdf44ec877 100644
--- a/drivers/dfu/dfu.c
+++ b/drivers/dfu/dfu.c
@@ -147,7 +147,7 @@ int dfu_config_interfaces(char *env)
 			break;
 		a = strsep(&s, "&");
 		if (!a)
-			a = s;
+			a = d;
 		do {
 			part = strsep(&a, ";");
 			part = skip_spaces(part);
-- 
2.39.5

