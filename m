Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A478C54747
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 01:47:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9845888B36;
	Wed, 28 Aug 2024 03:45:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JejC6UZM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21D8E88B6C; Wed, 28 Aug 2024 03:45:56 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0757788AB1
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 03:45:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-81f8f0198beso303640239f.1
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 18:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724809552; x=1725414352; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=okwWaXEq5PjK8CwK2CkN3AcyLCLN6sb/dpkDZPKDriQ=;
 b=JejC6UZM1L6Eye/YBYEWFsvS8MMsKFSMO1P+FnEbuzteFPLEril/GROlnn6yivfxXp
 UA36T5O5K2zAuFAfbw29+Ts1zHszShHHIxGMF9AMSbl298sZPEkshn+BCLUE3U5QC8gA
 4eLC4GBnYS8vP93LyCkWl10n3xLgJTkagFa6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724809552; x=1725414352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=okwWaXEq5PjK8CwK2CkN3AcyLCLN6sb/dpkDZPKDriQ=;
 b=Dar7veK2fraJPJ3OUrbjzwhs8fNHyhp9z0NIS4ULprT+7bP0yg7yC8E9rKT8u3nSgB
 6p5CnJzipEwEy9D+lm4UZVMr8UY5mMloDX4QUVvrhYUCbQxr1wgZPp9g8fmPGTzu3uL7
 ysK1u4HpAvzcTEirVeI3hfkN3YKfntN+/2QEaPiDHU1W6xzozUFuk8grDLdafXaVBI3e
 JdQN2JaL8oY77PiXmdvGNLyNKovJVAwLLIxjoDUQCShoHxrr9FimuPZLuULuEJj0+ewQ
 zj3hmWSDMzNQ8to+Wk9c0FbvQzbjz0W5rXtCFwZhuYf+FznR+ua/xBqBm4CODmOdMck4
 reOA==
X-Gm-Message-State: AOJu0YzOhf4e9wY9JvT5kPJRnPdO8eem292FrpYKdGCxhEgWnP+vThYw
 DvDkW+AC//LRuXl70iAat8HXxRq5Rfsd1QCtzbh762sg5Hd3ByTQN7/gE6MKMfyXPgLolOoMh4M
 =
X-Google-Smtp-Source: AGHT+IFFBWf6hhy4w4vLd/cBZedTBGNsWC9KWBeN9c8wOrq6D4etqVBec13jYTKi4V7VIRa0dAx02w==
X-Received: by 2002:a05:6602:6305:b0:825:2c2c:bd7d with SMTP id
 ca18e2360f4ac-827881ae83dmr1656111539f.13.1724809552505; 
 Tue, 27 Aug 2024 18:45:52 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ce70f5ca7csm2898342173.63.2024.08.27.18.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 18:45:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/18] tpl: Support numbered aliases in device tree
Date: Tue, 27 Aug 2024 19:45:25 -0600
Message-Id: <20240828014538.3322013-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828014538.3322013-1-sjg@chromium.org>
References: <20240828014538.3322013-1-sjg@chromium.org>
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

Add an option so that this feature can be enabled in TPL for boards
which need it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/core/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
index 1a7be4d9b4d..d811120aef5 100644
--- a/drivers/core/Kconfig
+++ b/drivers/core/Kconfig
@@ -151,6 +151,14 @@ config SPL_DM_SEQ_ALIAS
 	  numbered devices (e.g. serial0 = &serial0). This feature can be
 	  disabled if it is not required, to save code space in SPL.
 
+config TPL_DM_SEQ_ALIAS
+	bool "Support numbered aliases in device tree in TPL"
+	depends on TPL_DM
+	help
+	  Most boards will have a '/aliases' node containing the path to
+	  numbered devices (e.g. serial0 = &serial0). This feature can be
+	  disabled if it is not required, to save code space in SPL.
+
 config VPL_DM_SEQ_ALIAS
 	bool "Support numbered aliases in device tree in VPL"
 	depends on VPL_DM
-- 
2.34.1

