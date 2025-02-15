Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3681C02198
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 03:26:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE60880FDD;
	Sat, 15 Feb 2025 04:24:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Cmz2iTBn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 086C780FDD; Sat, 15 Feb 2025 04:24:22 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C62CE80B98
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 04:24:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-855772a109eso51320239f.2
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 19:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739589858; x=1740194658; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NqsemZDvLkbAruJ2lgR+CD/aaTI16fARdGqOiVSIzmc=;
 b=Cmz2iTBnauvZeN0VkGJTyKqX5Apq2vghSOlYf/woQq3jwaQ3W1wmup8SFycJtF3JtU
 I5Vzb5jaA1YucSksRvF5Ex6nAOX1h0MsZeAFuWrJpuBEexpEizp91/LdWxUowolFjWFT
 F5ND2cYBgJAJX1Btv/bx6OCE4uwCku9TifNU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739589858; x=1740194658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NqsemZDvLkbAruJ2lgR+CD/aaTI16fARdGqOiVSIzmc=;
 b=i+l6mzD4cPLHg4YeAKV6JnrRSDCTbouytCck5hxAsSKq+jTVXun9WC9EvUSbQSy6ph
 4RaSArc03ifPNTl2XRqVsB1Wm6fnEWbDcPgB2o9B+cxNlyJnTTU5x23XDO6HmDDkHjGA
 /s9JDAUG7vNYn64A9hAs+i4udsn0isUSvFpXVMmKsOi70KUVP5qoJQroSB6CFrDKokt9
 vs+/lZR0hxV7KuP55EYnOG78BYbCy9u5W+FFQW1lWXUGlzkyUF29hvfhpm92//MBTQOs
 9lrHeBosxqsiRDEsRcc4gDs6TrEzJDBiCwXzZZvKgB2MCN9cWI213sVJ2uAglq2BLiLu
 94mQ==
X-Gm-Message-State: AOJu0YwtRZGABRS8loNacbBlwsDfOEsUtXmTnCajikfdz+fX6pEfRJYJ
 4h2cMnASFR6Vq3O7Cj3t449GwHyjkB32aAG83HoCr5Rr9guwFajhQnvabnatOrZKpFB8wffNnF4
 =
X-Gm-Gg: ASbGncv93/t+ovNmTkpNvPQOkqGUmVbr/t8rjdqvsfM0EB70pgUALX4X2VDEsFGEcB1
 F1/rLRVOll7befeapnH082hykFAdVEw7xWL+tlG6Wemjlk2NDF4GlxSA0c6ux1BHJ4cTHhaTiJY
 /7otD9RA59SxzkL/bi60JInNblUAu4O0HUIOWUARlo3l90K4AIAJ/iz4krOK5AYLM0PP+pue8ZO
 4ahF6FPTq7ipN1OouaV6lbZ2OdCYnddQO7qqStA639k82DobD5mU9dNWdYs/xtoKjx17p+UqsA2
 CULcTQHKhtJ3FajLw88Wwbhx9PghL1/5reinE2szB9qdV0WkaEsw
X-Google-Smtp-Source: AGHT+IFZ7g1742I1i5m1DUl4Yb6uXkcg2sEMMMXYbMV6Erb914XON/4Xxsy2O1joJE+kWOE/xVcG+w==
X-Received: by 2002:a05:6602:14cf:b0:855:4e6c:e7d2 with SMTP id
 ca18e2360f4ac-8557a0ee3b6mr162530139f.7.1739589858000; 
 Fri, 14 Feb 2025 19:24:18 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed2819d0f5sm1087697173.67.2025.02.14.19.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 19:24:16 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Bryan Brattlof <bb@ti.com>, Marek Vasut <marex@denx.de>,
 Peter Robinson <pbrobinson@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 25/29] efi: Generate the app as a shared library
Date: Fri, 14 Feb 2025 20:22:46 -0700
Message-ID: <20250215032254.4121030-26-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215032254.4121030-1-sjg@chromium.org>
References: <20250215032254.4121030-1-sjg@chromium.org>
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

The app should be built as a shared library, with position-independent
code and the -shared flags. Update the Makefile to handle this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Drop the confusing comment about position-independent code

 Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 5c4e03f9ce1..e6800792f35 100644
--- a/Makefile
+++ b/Makefile
@@ -452,9 +452,12 @@ KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
 KBUILD_AFLAGS += $(call cc-option, -no-integrated-as)
 endif
 
-# Don't generate position independent code
+ifdef CONFIG_EFI_APP
+KBUILD_CFLAGS += -shared
+else
 KBUILD_CFLAGS	+= $(call cc-option,-fno-PIE)
 KBUILD_AFLAGS	+= $(call cc-option,-fno-PIE)
+endif
 
 # Read UBOOTRELEASE from include/config/uboot.release (if it exists)
 UBOOTRELEASE = $(shell cat include/config/uboot.release 2> /dev/null)
-- 
2.43.0

