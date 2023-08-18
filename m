Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84EB9C2FC0E
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 00:30:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12BA886BFE;
	Fri, 18 Aug 2023 02:27:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J9fgk0cj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF81386C27; Fri, 18 Aug 2023 02:27:34 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05EA386C56
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 02:27:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-34b0f3b792dso1386135ab.3
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 17:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692318449; x=1692923249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N78vJe4BlzGTbM/DBt5oXYAhkNvldGR1j59twyIqBMg=;
 b=J9fgk0cji8soeSmafHVHIItkjv8/NW7U/hgNlzW1uzufKxWZVW/URx16RLRTKuN8jr
 HdGqHE65oPUOLTNtdq5CVknOd7MkIejqpw3eiVcTa8drdWCbvcB0ugB+btnvGKTJLMK0
 rZFw7JFzESziAIzTPN2WM5qW7Drf8r7xDT//M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692318449; x=1692923249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N78vJe4BlzGTbM/DBt5oXYAhkNvldGR1j59twyIqBMg=;
 b=cvSQcHUd8mE26QUvEzO12gn7Zxw/sO+aTqX5cB/a9p79xziIcu0E9os09jwolfKczz
 hzBm0VpKShpcYhKqCWbCB1ZESRB+sgYMFk6jqtbrnjNH6a858//ZhFs7mN63H7/DVVwC
 tXdjFU1nMfgCEdlatDqeJGhM+T+TginkfcV0DrGvjy3Zvf8fPOVQqE526aiFIa/z0hfa
 kfIxe0sCW5npY29R3R5JJht+RqSjgtRAPY0okJq5vu3anQjNVkoAkxp80KxmptmtScpM
 /FY8jF/DqOPI2Z6CdEeeNj+1NJ2pL15bAjklHueEMVeN7COJVZP0O6sibkO3i9f2STyd
 e2wA==
X-Gm-Message-State: AOJu0YwzAfdwnInL8Znev3ZIc6xUgnVCSMwf/e2O7bhkxZRFOTVhtniZ
 xCuasveQjXv0W6TnLZohDxeiH6apXKnSEZYFgB0=
X-Google-Smtp-Source: AGHT+IFN4RlXMXFCjJ0HRQoWsugx0gr+3kaPxTwYIKYUXrUBxFaiPXyLOaKhpp0Wd9/Fon9yPg5dNw==
X-Received: by 2002:a05:6e02:1c43:b0:349:501:129f with SMTP id
 d3-20020a056e021c4300b003490501129fmr1547357ilg.2.1692318449643; 
 Thu, 17 Aug 2023 17:27:29 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 i14-20020a056e02054e00b0034bad471d1fsm190376ils.3.2023.08.17.17.27.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 17:27:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Coreboot ML <coreboot@coreboot.org>
Subject: [PATCH v2 20/20] x86: doc: coreboot: Mention 64-bit Linux distros
Date: Thu, 17 Aug 2023 18:26:59 -0600
Message-ID: <20230818002706.853550-21-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230818002706.853550-1-sjg@chromium.org>
References: <20230818002706.853550-1-sjg@chromium.org>
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

Add a little more detail as to why coreboot64 is preferred for booting
Linux distros.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add new patch

 doc/board/coreboot/coreboot.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/board/coreboot/coreboot.rst b/doc/board/coreboot/coreboot.rst
index 88437c27740e..a32c3a864f90 100644
--- a/doc/board/coreboot/coreboot.rst
+++ b/doc/board/coreboot/coreboot.rst
@@ -82,6 +82,8 @@ build in `$CBDIR`::
       -device ahci,id=ahci \
       -device ide-hd,drive=disk,bus=ahci.0 \
 
+This allows booting and installing various distros, many of which are
+64-bit-only, so cannot work with the 32-bit 'coreboot' build.
 
 CBFS access
 -----------
-- 
2.42.0.rc1.204.g551eb34607-goog

