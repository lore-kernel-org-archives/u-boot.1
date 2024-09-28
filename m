Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE481CF6491
	for <u-boot@archiver.kernel.org>; Sat, 28 Sep 2024 20:00:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C804B88B29;
	Sat, 28 Sep 2024 22:00:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PlSTA5FV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9C9688AE8; Sat, 28 Sep 2024 22:00:43 +0200 (CEST)
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com
 [IPv6:2607:f8b0:4864:20::d44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AE3988B99
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 22:00:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd44.google.com with SMTP id
 ca18e2360f4ac-82aa7c3b3dbso160554039f.2
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 13:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727553638; x=1728158438; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dbo9XIbfPu+qBB4oruzLa05bATz1A+yQvgxUT+dIVMI=;
 b=PlSTA5FVWBllEasvCDFdzJM/Vz3WCC1ISzSDV1d3n4EY1k1tnVysa6S/uS9Iq/SoaL
 8g5EBD4ru09hlLUnU1oMi4s1DrEDySuu7jGs4fdiyVQSvlD4xAleGyYu/ygXs3nuF8a0
 Ney1cACzdYcLn6/0h0LnHRHszN+g1BPyJtAOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727553638; x=1728158438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dbo9XIbfPu+qBB4oruzLa05bATz1A+yQvgxUT+dIVMI=;
 b=Ysz0PzpNwOA5o5x04tPaSQ2iqYGxwMBGyEko0tOIHy0M/aLzDPwCc4FrBDITcM1Gbn
 cvgmjMKpKrZ4Drt1KXKjEyEOXkTeJu1NJRPU2OuWohlItLCVdtetdfaIybSi3RM83sQx
 7ISv2PFhmaZ5yf9O7/CXMT9ORYdlCU6UueBMl5W7YMkfGSLRTIagyBHuJAC9LgzwIWqX
 E1igF/FxDugHh/Kmw+KMVoEC7OZZiPEY0t+ntYWg8S2KgybjEfa8ZmHmdCMhGdgkmsLu
 aHjGxlBegbJgNt3C4Un1nT6GzeLZPOn6aWwEtW4LLTD/v/TWAoRmtjFmxVw5qUUnyz5I
 vZXQ==
X-Gm-Message-State: AOJu0YytqzCYN51c1pHOZD/TclvKKDcidT4p8lH8dzibBXMAhYQZqBgI
 kpqXlpcRjeY/ebr3BTXZtc5bu6dx3dhUaxnMP/2b2ltCMGwGZ+xYZr16X4Sn2grWyFiWO3lketj
 Vhn1+
X-Google-Smtp-Source: AGHT+IGiwP7//EAJwAab6TBDBqmmJZeXPkcHxNrDQnxvA+4AF2Pd3zDp4dEtwIYwE3BZvWDheE5xHg==
X-Received: by 2002:a05:6602:2c02:b0:82d:16a3:55b3 with SMTP id
 ca18e2360f4ac-834932415c7mr859561539f.10.1727553638592; 
 Sat, 28 Sep 2024 13:00:38 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4d888835307sm1242590173.2.2024.09.28.13.00.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Sep 2024 13:00:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bryan Brattlof <bb@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Masahiro Yamada <masahiroy@kernel.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 01/30] Makefile: Add a u-boot.cfg file for VPL
Date: Sat, 28 Sep 2024 14:00:01 -0600
Message-Id: <20240928200030.194546-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240928200030.194546-1-sjg@chromium.org>
References: <20240928200030.194546-1-sjg@chromium.org>
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

Create this file for VPL as well, for consistency.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 525576f987d..300cee2e7f6 100644
--- a/Makefile
+++ b/Makefile
@@ -624,7 +624,7 @@ include/config/%.conf: $(KCONFIG_CONFIG) include/config/auto.conf.cmd
 	@# Otherwise, 'make silentoldconfig' would be invoked twice.
 	$(Q)touch include/config/auto.conf
 
-u-boot.cfg spl/u-boot.cfg tpl/u-boot.cfg:
+u-boot.cfg spl/u-boot.cfg tpl/u-boot.cfg vpl/u-boot.cfg:
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.autoconf $(@)
 
 -include include/autoconf.mk
-- 
2.34.1

