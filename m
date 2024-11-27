Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612BAD6ACF4
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 17:24:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DA1C8983A;
	Wed, 27 Nov 2024 18:23:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Zs4lcAVk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83CA989807; Wed, 27 Nov 2024 18:23:11 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A16DC89803
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 18:23:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6d41ac03343so354426d6.0
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 09:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732728187; x=1733332987; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z5k4NikxVKGKMRlotO1ucIdf1QIaBZqTLmY3rmx6VQY=;
 b=Zs4lcAVkbEkDlibS0E5Abwzn6zAlTW7jT38KJaE7bFMQ01jNvOKIEBgVrMveCq4Xdx
 tKE2/n6Nf4rJPL148sDYYUZR2HClt+wY9HfdoS4Nt/oF10bLF+yv/LSKiNcOxn6RwwC1
 8lfOLcB9lPaG3jbXTen9FssttkNGHywsEE2gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732728187; x=1733332987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z5k4NikxVKGKMRlotO1ucIdf1QIaBZqTLmY3rmx6VQY=;
 b=a/BhG/O5OHF+REqyAEx6Zw3xDs7ko5zlaLnvLTmRxjCZ3S+QPaR27QRpafjpvdLhVC
 ia52h4W8kYHm1c5glAyHhu7PB9ZfSLNpuQJ5i31ndFo59I1d0Gv2KZule29pwlCMm/ml
 WoZtJXgJeVXpjeLHMdffFAwgOFq4jP18jbMw1kg4m6knc1oPCxu6Bi0Ca1p6sMlNNo+D
 fnfwg0PilloUWyP313r+lrD675P52KplB6ynlxdecxgHUPNVMjyJSdiYhnrWQYjAy3oF
 pIcFJVnElqxpqQEAT7dwFEC4vit67jhWX9rAtSgbi75wHENBkktpJmQS0eEGZO7qHC3V
 Oz+g==
X-Gm-Message-State: AOJu0YwKk9RQ616TFKkERqyd+0upmQTSAGc7CU8LZtJEHmyJLEX/X8VQ
 fj8L/kXmKOt01UODjiuwY66bEIq9jzggkfXki01oINLeYWbVDI9JPVWY/FXHyS+9H9JyGGUgu8S
 nDYQ=
X-Gm-Gg: ASbGncty/nNfgxjXoxOlt5k9Fy/wvPdhTpQSfBOob3oTPsINapnYL5HUlsbzO9Gb9XW
 MYEmamddfDMZ48h0tWwzd4J2WfnCpp0qtEmkX5Cr0zT8aWe4FRRMJe745H3CHHA7F378LCmGVP+
 OvlOFqh6BKaRHQhO1/jsiO96BvB3eugZURKUTiHUXheDS6xhzg0qh5yTsihKko0yXI82ETCdqgu
 gZS6y+C9yxeyfb4AXgleg6Xj8sUnY9jPqyoQFzHU6QHmplv+oftKyiR0cI4E+YLaLDF81dT
X-Google-Smtp-Source: AGHT+IG/5jWFNPa0wL/0BszHQgZOa5BMbg5RukU9pt2eq2PhmFW81+ix6/dmXgr1Zn/7Pknq6ZcrMA==
X-Received: by 2002:a05:6214:1c09:b0:6d4:277d:700c with SMTP id
 6a1803df08f44-6d8729ce677mr2053496d6.18.1732728187617; 
 Wed, 27 Nov 2024 09:23:07 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d451b23e25sm67160976d6.89.2024.11.27.09.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2024 09:23:07 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [v6 12/12] CI: Add platform variable
Date: Wed, 27 Nov 2024 11:17:30 -0600
Message-ID: <20241127172247.1488685-13-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241127172247.1488685-1-trini@konsulko.com>
References: <20241127172247.1488685-1-trini@konsulko.com>
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

From: Simon Glass <sjg@chromium.org>

Add a list of possible platforms that can be used by gitlab runners.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v6:
- None
---
 .gitlab-ci.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 23bbe2c24b8d..f0113361a3fe 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -4,6 +4,7 @@ variables:
   DEFAULT_TAG: ""
   MIRROR_DOCKER: docker.io
   SJG_LAB: ""
+  PLATFORM: linux/amd64,linux/arm64
 
 default:
   tags:
-- 
2.43.0

