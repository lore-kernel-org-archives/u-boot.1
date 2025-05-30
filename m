Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91179C5AD49
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 15:17:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B07A683303;
	Fri, 30 May 2025 17:17:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="QUummnCz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFCBE83291; Fri, 30 May 2025 17:17:08 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DA098331B
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 17:17:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ad857db4f52so275812966b.3
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 08:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1748618225; x=1749223025;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0N85FxVBxmedtGwBQrtiL6p2XFcDCxFvfeLydJZAri4=;
 b=QUummnCzVFVndjX1RqZ+fTa9bIYqxO/fFzMLCmYGlN0Bjk9oqFe2VO0M4n9TbYzqah
 Jn0RUTOmpMOADbXXUTOi2UIrFQYXBbhV6ExIfirsIJHuJGr5h/olonmRqXoRMlbcBrwd
 IZ6c0rvnV2YAKX6IeAvLNNv/AqUS31GZSVsfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748618225; x=1749223025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0N85FxVBxmedtGwBQrtiL6p2XFcDCxFvfeLydJZAri4=;
 b=jErIbEgN2uzNraWXmYLmEHHenIQKWAGmNTO03XzM5oBDj5h02I8vWBM/C3EGQAIs16
 RBcB7512ca16inUZgYDFzV4oQ/GWoNekT6DwTMXwf5Erd1uNvrCWD1doalsfWmiY4agE
 h+m/9Dn9cFquBtJM8E30sKQmPtdN1vRe0dLym9VTKof5pTs/g+cHB4qPJsRbnmnnRV8v
 u56TvkWQ4qm58LVhDFHJ+CpzQV8iVpi5wTKL2KPdOogZUj5k+K4j0QBI3RmwlQwkG1e1
 u+8J3kpK+vxJ0lNnFSMGVetUBUziFJ0WEVg4P4rx0nkcGC0Er9wk3jLSkXLNkWaSG6sl
 gWJg==
X-Gm-Message-State: AOJu0YxcY8axQ6BvJ29A7BCqrn7mNfx0axAgoY9GIdG4VvM7WSTl4DZG
 dDBbeO6iEbeh1sv/6ICN8CRNbECJEsYOwKq8o8uwhZKQviy4k0myBdYF7h594oWJcupwtPW3GcI
 v627knok=
X-Gm-Gg: ASbGncsgfBDjip6cCt6ceCSO+aRznaPSKEDjMEZ4ssmRJOb2ilxJ0ABhWSoB/ccn1gp
 Vuiv3HaEURp8wtdbIdTdIMFFfqrKq+9Fww4nmITOniD6qsc2yC9icdvCKPBRbMBklPsbymLF5Hq
 +XaJbEzhdDxNj6o0jSSopDn2+1pxZQkjoguYyS3pYRauOkSwoBVoJFdCiJKmYPvqxaVHcmLMXvC
 46ORPKSjiye6ONVjgroLXxPTdoWmAX/sAs5RojJAhomNlsVgIgNfj4Z8EkmROdYZsbhnyRoi6LK
 tkuG6PTSZe5SbzDxu2Y+PH1OIqRVem/k40mFdEYsMNj6eZsHmaZMXVnmLw15u9/47DaJJhGWKhl
 ZKdDnPW265ZRVwJiDir8p4kV6hxjwMJuaMu4=
X-Google-Smtp-Source: AGHT+IGbZrMMXZDry5fuID7BYs53JpDCpgjOy514qHOlc+yvdY58bmpJkBW9sAcZigs92MF7Vr5Y9A==
X-Received: by 2002:a17:907:2cc4:b0:ad5:430b:9013 with SMTP id
 a640c23a62f3a-adb36c0b29fmr255354366b.42.1748618225282; 
 Fri, 30 May 2025 08:17:05 -0700 (PDT)
Received: from panicking.. (mob-176-245-161-96.net.vodafone.it.
 [176.245.161.96]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d82dd12sm345507966b.58.2025.05.30.08.17.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 08:17:04 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com, cniedermaier@dh-electronics.com,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 4/4] configs/imx6ulz_smm_m2_defconfig: Enable clock
 framework
Date: Fri, 30 May 2025 17:16:46 +0200
Message-ID: <20250530151653.3695020-4-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250530151653.3695020-1-michael@amarulasolutions.com>
References: <20250530151653.3695020-1-michael@amarulasolutions.com>
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

Enable the clock framework on the m2 platform.
This helps to increase the NAND controller performance.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>

---

Changes in v4:
- None

Changes in v3:
- None

Changes in v2:
- Ajust commit message
- drop CONFIG_DM_MTD selected already by MXS_NAND_DT

 configs/imx6ulz_smm_m2_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/imx6ulz_smm_m2_defconfig b/configs/imx6ulz_smm_m2_defconfig
index 436bfb78cc2..6e425d6e52d 100644
--- a/configs/imx6ulz_smm_m2_defconfig
+++ b/configs/imx6ulz_smm_m2_defconfig
@@ -43,6 +43,8 @@ CONFIG_ENV_IS_IN_NAND=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_BOUNCE_BUFFER=y
+CONFIG_CLK_COMPOSITE_CCF=y
+CONFIG_CLK_IMX6UL=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x82000000
 CONFIG_FASTBOOT_FLASH=y
-- 
2.43.0

base-commit: df2ed552f0b05591090369a7fe7ddc92439dea5c
