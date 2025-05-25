Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23CFAC54E90
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 10:51:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64B1783689;
	Sun, 25 May 2025 12:48:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bNgrTc+9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05B8E836B2; Sun, 25 May 2025 12:48:41 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25159836D3
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 12:48:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cfebc343dso9857295e9.2
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 03:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748170118; x=1748774918; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=54Y1p/Y4BJuQExwId3XHbLWFS5a44l2pLCL5H5oZXhs=;
 b=bNgrTc+98iBw0XrYslsiapsn/OUMvwMxWwJbPakyjcIyAVgNZPoTANRDoNZU5JqJ3X
 QEgYi6rd8ZU+Fg5hHihLxvgmxDKc9nA9KzfoyHuoZEUiVQeV17g8PRGgMjthzZse4wRz
 f4HquUiAYc1qf9x5LX5N6R9ux8hKHCQipA80g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748170118; x=1748774918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=54Y1p/Y4BJuQExwId3XHbLWFS5a44l2pLCL5H5oZXhs=;
 b=jOqlBQ6nOlZ/p1BNnIBEaZLSQIdCNsi0sNtMxV8Z4pBbUGDwEHFgOLwEPzmtKxGJw2
 ESd8e6CFtOm/8B8bjvViDVhZp6VWPPo24kBY2AArJOpSgkLCJ7iGlhEg2znbjMtNwjuE
 GKXCGGgdf7lgcsoQ/XcYO6iID0g/D9SzqZMMq9o64GkRGdTdHghjW0oi7DmPLt3+ca6d
 EEKytOiFRUcunEhVYJqgcwQzwWS39gfUzkvUlpQMS6JufsiV74Y06No0DJwpbqPPCU6k
 J4FakzJmjekBnW1S2ukFM9Xqd9XcFMeSsXBjLJTZZyDPGVdZWyMX5nsDzt/hTmJ/8PWK
 X+0Q==
X-Gm-Message-State: AOJu0YysiH4vhf0hYKOIhPJneq7G7KgFDSCYSQelpE8r48wY5CtnP9TQ
 Az1edIlRPtEYI/JmdXkh2K+uvXLKlJg7YnUgIFc3hIE1dppRgZbFiEKzdBLzbcesoQCI+Wjhtjz
 zOI6lJwz+
X-Gm-Gg: ASbGncuTo7vP1SyrtRvYUZUNazKOIDDTCNLngV0cmFUZvZjBXQtljo4kbSVeoT8lcF+
 odqBDkGeGm0fouDYhIL7syxNsMf7Y476Eipg12V626yNPFzhDXTRpMZ7vohqmVWJPYdpFGUl+SF
 U1ESJWRpxyBy5qT3YhR9+ahRnCagP2Eo88OgedCsim//+xtTc1iBse0wk75E8wRwR4euTdUkK+r
 4uNsUlgw3iajqE7drB2oq6EZeOqlxVLaZ4wKYIj/nKBE6t4iM3RaZitWUga8O3BpgCxOCZcMlDi
 VLERGELcOEOGiKgFw5KAXn1X00xCEUKcP1X2t1ey5QFPX9Vb9DOWO2eT1lS8fCy/Rq1KYOg=
X-Google-Smtp-Source: AGHT+IG4ecfAHKnMhuwFGgdCiItM+s2+5Ybc/r6gpBQ25FaEofVKgrXqR9IK3W/duIE6TTrCcpprGA==
X-Received: by 2002:a05:600c:3115:b0:441:d437:ed19 with SMTP id
 5b1f17b1804b1-44c91ad70afmr44360835e9.11.1748170118121; 
 Sun, 25 May 2025 03:48:38 -0700 (PDT)
Received: from tasman.. (host-80-43-238-15.as13285.net. [80.43.238.15])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4cb450867sm5045047f8f.57.2025.05.25.03.48.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 03:48:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 19/25] gitlab: Add a VBE board to the sjg lab
Date: Sun, 25 May 2025 11:47:55 +0100
Message-Id: <20250525104801.1440260-20-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250525104801.1440260-1-sjg@chromium.org>
References: <20250525104801.1440260-1-sjg@chromium.org>
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

Add a rockchip rk3399 board which runs Verified Boot for Embedded.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Fix 'an' typo in commit subject

 .gitlab-ci.yml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 7aadd5d8b73..cf8147fbfd5 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -738,3 +738,9 @@ qemu-x86_64:
     ROLE: qemu-x86_64
     TEST_PY_TEST_SPEC: "and not sleep"
   <<: *lab_dfn
+
+# Firefly-RK3399 board running the rk3399-generic build
+vbe:
+  variables:
+    ROLE: vbe
+  <<: *lab_dfn
-- 
2.34.1

