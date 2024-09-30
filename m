Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D72D8CF6495
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 01:50:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE26488E07;
	Mon, 30 Sep 2024 03:50:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mGuYH4o2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A36B88DEE; Mon, 30 Sep 2024 03:50:16 +0200 (CEST)
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com
 [IPv6:2607:f8b0:4864:20::144])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C57F88DB9
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 03:50:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x144.google.com with SMTP id
 e9e14a558f8ab-3a0cbc08b38so21195095ab.0
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 18:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727661005; x=1728265805; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dbo9XIbfPu+qBB4oruzLa05bATz1A+yQvgxUT+dIVMI=;
 b=mGuYH4o2h9JZ+76CdGiwnpZKU6uF54j7TCmKcDG84YDt6UTlQSEoPX9uX6PYX1B1BO
 YlqIF5+HLclhB9lRHCObtEokD4DzD8KNAfWKLCxMoXlarK1F1frxfwQL7l90uZOpMRpu
 8fI0vuU2sD3IXWOHvKqjgFhnYuv46e4M931JI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727661005; x=1728265805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dbo9XIbfPu+qBB4oruzLa05bATz1A+yQvgxUT+dIVMI=;
 b=Z6n2wDuHb5MvRYZmiQF+Gp52qxU6gu3MzTe7zfaSkbcX8Moq0OGorMKIRwRkELRSuD
 lsjqyQA2yxVJUoet9Qzb0gh4lQ3m1UBuhCI56mpLS8GC5GJlCpjllFoiXEBHx/l1R86Y
 OsOeTVdyng2BRIssdFGLQ4qwJosnebkbt3ujaUWMitAyJyhGDSdQTFOXCgYIXtCPIFQx
 ls32gU2gkwIO3MhpsdvPbwC99A4WHmn3UAud/Dm84vNA0Pd9qB3139lrNsRzoT/TaKQP
 oxrkF//bVZysIXvesAY1A/tab/z6S7SIabL10ih4NA8LJ3tOiNq1RmZtw9fP78CFw4aQ
 DdLw==
X-Gm-Message-State: AOJu0YyXWUtzYsKiRNHPxce4omVVTh5XJGq8kynZPu/hm2wQV7Zqg/aS
 +NECa4S1rTlT1VIgU6L1Cloy3X6nPU8yHT/Yp7W5TjfkobecutkES+a0gHnIbtycQXPGC73Iwb4
 GaDOx
X-Google-Smtp-Source: AGHT+IHEsImi+zuGFXCxGmOQFcb1mLQWcU+SVwkgRuKk5U9qwipjO2D59N78eP+WLeb/fgSKMII5Ug==
X-Received: by 2002:a05:6e02:20c5:b0:3a0:9b0c:6b2c with SMTP id
 e9e14a558f8ab-3a3451aadcfmr78849125ab.18.1727661005600; 
 Sun, 29 Sep 2024 18:50:05 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a344de1d5fsm22074185ab.62.2024.09.29.18.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 18:50:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bryan Brattlof <bb@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Masahiro Yamada <masahiroy@kernel.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 01/33] Makefile: Add a u-boot.cfg file for VPL
Date: Sun, 29 Sep 2024 19:49:24 -0600
Message-Id: <20240930014956.1434060-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930014956.1434060-1-sjg@chromium.org>
References: <20240930014956.1434060-1-sjg@chromium.org>
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

