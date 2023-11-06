Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29FBEC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 11:42:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CC3D87049;
	Mon,  6 Nov 2023 12:41:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="z8g0G9IR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0B7387026; Mon,  6 Nov 2023 12:41:24 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAAE587049
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 12:41:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1ccce410660so6050855ad.3
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 03:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699270859; x=1699875659; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9yfAtkx/MLAaC2e3oTVCEdGrlnmIaFPaJzkqM3lqaYU=;
 b=z8g0G9IREQIGeBV1KgbA2jvNobm+Gq3DjDh+NUwkZIrp6znUanRj3gFLMnS6XRxqZd
 Qr+ankKla3fpvwpU8yqzXu2W4jr0Vrp3DAOPJSJKBcp2RPhv/5lAcVHyua0no2TKE5DA
 PNMthT+hfM47g/oyG9uWDNq9GgET3LPqjSKB4FgcCx6q9M2knG5RlXj48S+7u0M+AtKO
 HtfvsYVzjQDFDoIbb8EzbVTUZcg7jD/JlCG6Uak+FlEVxP43lcQ5IsRkNnr48/WRKOij
 bMngA4nAsKRE6yPPtpFEtvR8SZs6mN8map/QCMIAb3uQ7zgUdEggH+s4ckPR3Gnw7bet
 Jv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699270859; x=1699875659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9yfAtkx/MLAaC2e3oTVCEdGrlnmIaFPaJzkqM3lqaYU=;
 b=j8zUUCuL8sUHHQiX0Ftq2RrumD9jxDOtyljcnD001lZwIbhEkrf2RBtD824byMaXqU
 jMjzUKzfDMChrkNqbM3U0+N7JeFIgIquCXwBOzxUX9SBiv/QAVQzQW1L0QOzzBf81zZT
 nqet1UX0IgMTNgi8k0cM1DfOZQx8uktYhX4cj3sSYeHPpYxLayOjp/EdjOCcj2h31rqi
 Jhosp5+zUGRai3PeL0n9FjviFdxcb5cnJCgrE8JahURDschvX5oFs36snIIfUmeK7NNM
 FukCxlgs2mI+JxEdYivdcs9GgGQcYYxAPVclV1+3Rpat/iTYSRyJddblPb2YtBzElh41
 SRtA==
X-Gm-Message-State: AOJu0YzgB/BQ16fQZgTLIXJXfJTngYHphuNZnbquhW0Rpz6jSlj2H2gV
 7yQdRwUsCkLT6U6VnISrJHn5forL+Gv3I0Fj/IQ=
X-Google-Smtp-Source: AGHT+IHSTk5o+RFlRkFcXZl+QqHfaulA+NJZ4GqBWOt/EsD6Xj5dn8qN1UQnWsS4a6v0Ypy2LSq0CQ==
X-Received: by 2002:a17:902:d512:b0:1cc:4b1b:2759 with SMTP id
 b18-20020a170902d51200b001cc4b1b2759mr21325036plg.63.1699270859514; 
 Mon, 06 Nov 2023 03:40:59 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 s10-20020a170902988a00b001c60c3f9508sm5729506plp.230.2023.11.06.03.40.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 03:40:59 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [RESEND PATCH v10 9/9] doc: uefi: add HTTP Boot support
Date: Mon,  6 Nov 2023 20:39:20 +0900
Message-Id: <20231106113920.3631591-10-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106113920.3631591-1-masahisa.kojima@linaro.org>
References: <20231106113920.3631591-1-masahisa.kojima@linaro.org>
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

This adds the description about HTTP Boot.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 doc/develop/uefi/uefi.rst | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index fb16ac743a..ca9a573669 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -642,6 +642,36 @@ UEFI variables. Booting according to these variables is possible via::
 As of U-Boot v2020.10 UEFI variables cannot be set at runtime. The U-Boot
 command 'efidebug' can be used to set the variables.
 
+UEFI HTTP Boot
+~~~~~~~~~~~~~~
+
+HTTP Boot provides the capability for system deployment and configuration
+over the network. HTTP Boot can be activated by specifying::
+
+    CONFIG_CMD_DNS
+    CONFIG_CMD_WGET
+    CONFIG_BLKMAP
+
+Set up the load option specifying the target URI::
+
+    efidebug boot add -u 1 netinst http://foo/bar
+
+When this load option is selected as boot selection, resolve the
+host ip address by dns, then download the file with wget.
+If the downloaded file extension is .iso or .img file, efibootmgr tries to
+mount the image and boot with the default file(e.g. EFI/BOOT/BOOTAA64.EFI).
+If the downloaded file is PE-COFF image, load the downloaded file and
+start it.
+
+The current implementation tries to resolve the IP address as a host name.
+If the uri is like "http://192.168.1.1/foobar",
+the dns process tries to resolve the host "192.168.1.1" and it will
+end up with "host not found".
+
+We need to preset the "httpserverip" environment variable to proceed the wget::
+
+    setenv httpserverip 192.168.1.1
+
 Executing the built in hello world application
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.34.1

