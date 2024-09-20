Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF8DCF58E0
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:25:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B01F1893AC;
	Fri, 20 Sep 2024 09:25:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LfRlDPZz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C60D3893AB; Fri, 20 Sep 2024 09:25:00 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFA7C8931A
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:24:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42cb9a0c300so14420505e9.0
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 00:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726817098; x=1727421898; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3OX0vrWofXUX3tDwqNLSoX0fY8kyAyXd0nLgHqZRKqE=;
 b=LfRlDPZz6pCCuVTUrhmKEKEhXfMmcWNEsLLuevBxp4KEuLTl+bgtfb7Pu7EK5/RcaF
 VzVs6Qzd5tcJ/sguqPvnHyVwqmI9pJEuE1+uf8ovTaYi/bP7ovQplr49vrXVjD5iYxkA
 n4EWrepgSY6FOGL7YVZDLiG8pf+xGmueYrOQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726817098; x=1727421898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3OX0vrWofXUX3tDwqNLSoX0fY8kyAyXd0nLgHqZRKqE=;
 b=mCG6sBq5UsIq6yQt2L+VdE5/meB/lNao98e0viDDnAZocQO6959csn+h9rNOcI2D4g
 xwzgA3TrNgY8bT2Q1IEpkqraPHgzpDgY/XLnQ7A7/K23MhclUFJZ64uJTDUT/82L9ibB
 7Zmj0O9ZkVvQMxIvg/DzSouqEMD9dZaNs1gpdcO/TPOTMID86c2lFsmlbP4u5Sb5ByB8
 mOAZ418yap2spKlImaG4arDNhIt0X2JoGTCgybJOPvakeGY7T6L/+xrTsRb88IzUSHgo
 F1FrNfnwVwv+pj6FxiwpYqBoXxlqmdn+Kiiysb9wlCeVCdhhtx23Pe54DIAMj7xsdVfM
 PzWQ==
X-Gm-Message-State: AOJu0YwDj5eoBMzlmYkx+8zo3lgRQXCDGkfegVSkX/xz9W3HBx5V/Ct2
 OFnjF6GjaLoFDVf5coA1I6by5qZhaTxSUrbO9Gg2xgFCaZty+zeaVhIJ24BHLg2OO2R5kCUShUd
 sUK1/
X-Google-Smtp-Source: AGHT+IHvMPQXjux4QZgmVEtecUTt110wZ28s3WqT0lQ6XoRbTY/so82Wlmmjdgb5W3tzAdI5O89kBg==
X-Received: by 2002:a05:600c:1d29:b0:42c:b309:8d18 with SMTP id
 5b1f17b1804b1-42e7ac23136mr11840945e9.19.1726817098129; 
 Fri, 20 Sep 2024 00:24:58 -0700 (PDT)
Received: from chromium.org ([185.44.53.103]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e7540e32fsm41504535e9.9.2024.09.20.00.24.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 00:24:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 01/18] sandbox: Add missing header file
Date: Fri, 20 Sep 2024 09:24:25 +0200
Message-ID: <20240920072444.134997-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920072444.134997-1-sjg@chromium.org>
References: <20240920072444.134997-1-sjg@chromium.org>
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

This file uses __aligned so should include the header which defines
that.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/sandbox/include/asm/sections.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sandbox/include/asm/sections.h b/arch/sandbox/include/asm/sections.h
index 88837bb35c8..5e1577419b0 100644
--- a/arch/sandbox/include/asm/sections.h
+++ b/arch/sandbox/include/asm/sections.h
@@ -10,6 +10,7 @@
 #define __SANDBOX_SECTIONS_H
 
 #include <asm-generic/sections.h>
+#include <linux/compiler_attributes.h>
 
 struct sandbox_cmdline_option;
 
-- 
2.43.0

