Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBFAEC8742
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 16:00:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC93A86A7B;
	Thu,  7 Sep 2023 17:59:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ka+W9+sd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 830C786AC0; Thu,  7 Sep 2023 17:59:45 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E4FA86A93
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 17:59:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-34e202a9cc9so4500515ab.2
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 08:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694102381; x=1694707181; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oUwTrNOrBU3cDJ/jUUNKTqXrANK3FAh44F+MUkfbvuk=;
 b=ka+W9+sdLrbnbR0Smp3G7C4TdLdDOASAx+148e5QGcbar2RKIbahBHAE+b3C4SyITz
 sUM8PGYmp2TFzBvPdcVt1WI8yG6izB4r5nCrpeDVkY6Naw7JT8KYKs283l9d5D0yWFHa
 9/J1tTJOviXOhUN/UzQE+3iT9K7nVjbw5z/Gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102381; x=1694707181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oUwTrNOrBU3cDJ/jUUNKTqXrANK3FAh44F+MUkfbvuk=;
 b=RUOXpy0cZdSiW1szAu53REOI0I/akSSWIEyjfk05KSCfTa6ZchciU2gwtF91JbrgbZ
 7bplLdir3kmoZeUEQX4u19e3IZEvkyHnrnoV48exvh1BI9aBBTxX/z9KayVLiJUirhyl
 ab/LJY9HtC+w9Ny/IvrGmSENB23x92YYef9e58kxW0LbE6ke7AUfsW/fVbp9kOGUMe9p
 mUxsxYZSK5+dzcOpxz4TOPpHfxqk+D0bWp/OQ4x9uC9T4uP1NQpPAfm7S85Hzs5pprlE
 D3yV9hRYDM9QFEPPwS23yOQDV0qPTeQLAPljpuz81Ng+8bZmvrStZcmUOpICVmd/FmK9
 qfHQ==
X-Gm-Message-State: AOJu0YxMaH/f8udtF82T2Dhlo7PDE0Xluc8rm7E9OjXiebN3mkGEbi16
 6ojezym8mm771NbF1VvM8lZSKarw4k7oJwl7YVs=
X-Google-Smtp-Source: AGHT+IGeHPBcKiykmHoaYihvPox39bpWYWOW9fSKJ3PFuWJCDnY8/4LgiAkYmguMwB67AOoI6pp/lQ==
X-Received: by 2002:a05:6e02:d51:b0:34b:ba9c:78ac with SMTP id
 h17-20020a056e020d5100b0034bba9c78acmr82508ilj.25.1694102381033; 
 Thu, 07 Sep 2023 08:59:41 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a92d4d2000000b0034989674ad7sm5637727ilm.52.2023.09.07.08.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 08:59:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v4 02/22] Kconfig: Move API into general setup
Date: Thu,  7 Sep 2023 09:59:07 -0600
Message-ID: <20230907155933.48511-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230907155933.48511-1-sjg@chromium.org>
References: <20230907155933.48511-1-sjg@chromium.org>
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

This is perhaps not a commonly used feature so should not have its own
option in the main menu. Move it under general setup.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Kconfig b/Kconfig
index 91170bf8d223..0a2e97578dfc 100644
--- a/Kconfig
+++ b/Kconfig
@@ -585,10 +585,10 @@ config MP
 	  This provides an option to bringup different processors
 	  in multiprocessor cases.
 
-endmenu		# General setup
-
 source "api/Kconfig"
 
+endmenu		# General setup
+
 source "boot/Kconfig"
 
 source "common/Kconfig"
-- 
2.42.0.283.g2d96d420d3-goog

