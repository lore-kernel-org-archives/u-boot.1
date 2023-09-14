Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDEEEEAA59
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 16:56:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47F8187098;
	Thu, 14 Sep 2023 18:56:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Lqu6dGkG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F8E58708F; Thu, 14 Sep 2023 18:56:35 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B2EF86F58
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 18:56:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7951f0e02ecso39702939f.0
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 09:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694710592; x=1695315392; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hIoTUagu0rwjHhcFAvs1k6k+YYxbxMgOBeThyVtFCys=;
 b=Lqu6dGkGglfVz2LrEfv0wyYm/USbAuKK8bYeuiuiAidALFHx534iZ9WEWgUsRjQ3Sd
 4QMjiovh8daH5o5y5ugMqIevKOcaxqIMnHMeacKWX+spNnBEBemOmEW/NhuhI7cDY3FG
 3uugp99q7l27b/dN1y9jTu156m0R31UmUsJDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694710592; x=1695315392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hIoTUagu0rwjHhcFAvs1k6k+YYxbxMgOBeThyVtFCys=;
 b=LR10HRbN9GkGElcBzV4t5IgHjLKquMAOIdBRO07s7J4oYvYg0Jmnj9rvXOqQ1hNZN1
 btThmKoCxHzmWDacuWv6uIV54Z37GDntlJ4Jlcd/bq4+kMftPsNssM/g8ACL8qSHt0jB
 aYfEmVnWRcwhAvcK5v+wXmSVoREpVYhAnUodYkGh4xbR9OzKpGlnHF/sLWCnk5gHodFY
 bASpTt8XkSCD1wVM0/CDyPzrDTanxkEtN4BTtIFzXXPW55hUMBcXeEHwaZZczcQDfr6d
 hwiVeC9IMcnYRiY6jYw9IZu9bVjK+WlyGqpYcVa157d5MvNIhRbNZeIwUvA2LxId0D8O
 yIzw==
X-Gm-Message-State: AOJu0Yy1Y2aU/j+ecoTspEey0UofCoxJu3/2nYooml1Btw8DOMPGEoip
 I2zb49gqykCcoMm2e3mK1gEccAAXn9xBzxmWf+0=
X-Google-Smtp-Source: AGHT+IGYdNy/iAMPW2uAfzRzntD4GeL8yJgGRzscLpV8no0D6iwxdmYAOVvwd5vfZpKicrs8ohC2/w==
X-Received: by 2002:a05:6602:2753:b0:785:d4f5:2225 with SMTP id
 b19-20020a056602275300b00785d4f52225mr6885482ioe.19.1694710591929; 
 Thu, 14 Sep 2023 09:56:31 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:a8b6:76a8:ff58:a8be])
 by smtp.gmail.com with ESMTPSA id
 s20-20020a02c514000000b00430979b6aa5sm535339jam.0.2023.09.14.09.56.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:56:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Andre Przywara <andre.przywara@arm.com>, Johan Jonker <jbx6244@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH v5 02/21] Kconfig: Move API into general setup
Date: Thu, 14 Sep 2023 10:55:40 -0600
Message-ID: <20230914165615.1058529-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230914165615.1058529-1-sjg@chromium.org>
References: <20230914165615.1058529-1-sjg@chromium.org>
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
index 91170bf8d22..0a2e97578df 100644
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
2.42.0.459.ge4e396fd5e-goog

