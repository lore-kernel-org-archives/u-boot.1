Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75CFCF58E2
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:25:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD02E893BE;
	Fri, 20 Sep 2024 09:25:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fR6P834J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 463DE893B5; Fri, 20 Sep 2024 09:25:02 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D34DD89325
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:24:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42cb6f3a5bcso20397855e9.2
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 00:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726817099; x=1727421899; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bIGoR+CyRXutjDnSN6AF+1wfyfBLN/4tYx//54TReYQ=;
 b=fR6P834J7bulTJj9qIFhXq0uA341Gl6S0xQberhVaU2hgKyJJBQxqnJXjfS67VhufL
 zGK0yhh4tulc1B79varaQE6x8rTd0fIogLwPXvbNRTRTa+WjyN2YIlQGNlH3UI5nlse2
 GBRPqh2hdiZI5bNla0SNxrNTIFBk9ZyQOo74s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726817099; x=1727421899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bIGoR+CyRXutjDnSN6AF+1wfyfBLN/4tYx//54TReYQ=;
 b=BSegmKMtJIB4L5e6zjWXpgEA/gpCzgT6dQr457ChnC6/T824xnx9PeBEi7WMQOBTE9
 1nKhHEDOrqqQjhZ/BUXVvvjac674AuJVsUrhF+QI/wB0IazpoeZYQ21DiYUF/GxgWrN3
 CY8k5e7SKoR0JItxdKlRypl+Ct3ylAAPcuOOk+5+EhqULka2kFyEGqKf3aci/CxyMowZ
 s0WbL9KsRWwLaxUINBVKw7wmMSIgKzFQsf+TBKn3gcjo15hkhWzSi4W6aDGxYBp1k8MD
 vl7MR2CkpKiHyiXScp1Ap8bc/3w0iPGRGdX1wbLzYjMsIC6/8krIhKDqRSoEU/1Y4jjm
 X38A==
X-Gm-Message-State: AOJu0YyZ61HyFVqLq8dLL7IWNiDEUfvL1Qq8BV6hE8Lu/oBpnlJ3/nAv
 jGFtZm//ALWKJDNahNXJ9gCUUmLa9UO3KstZ+KPEa7uFnm6x+pax4v64mBIuyS2IK8PCRFodoJ/
 2ddq8
X-Google-Smtp-Source: AGHT+IFjAuPlAKJGeEAxnW3kLtv0i7f5tt9HHpZOQO75jJCgtUfZ04+U6HQ+pUMrG+X0X3GxgmjMxQ==
X-Received: by 2002:a05:600c:4fcd:b0:42c:b508:750e with SMTP id
 5b1f17b1804b1-42e7ac1dd5fmr17263845e9.11.1726817099143; 
 Fri, 20 Sep 2024 00:24:59 -0700 (PDT)
Received: from chromium.org ([185.44.53.103]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e7540e32fsm41504535e9.9.2024.09.20.00.24.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 00:24:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH v2 02/18] bootstd: Add stub for bootdev_setup_for_sibling_blk()
Date: Fri, 20 Sep 2024 09:24:26 +0200
Message-ID: <20240920072444.134997-3-sjg@chromium.org>
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

When bootstd is not enabled, bootdevs should not be set up. Add a
static inline function to see to this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/bootdev.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/bootdev.h b/include/bootdev.h
index 2cee8832d26..ad4af0d1310 100644
--- a/include/bootdev.h
+++ b/include/bootdev.h
@@ -395,6 +395,7 @@ int bootdev_next_prio(struct bootflow_iter *iter, struct udevice **devp);
  */
 int bootdev_setup_for_dev(struct udevice *parent, const char *drv_name);
 
+#if CONFIG_IS_ENABLED(BOOTSTD)
 /**
  * bootdev_setup_for_sibling_blk() - Bind a new bootdev device for a blk device
  *
@@ -409,6 +410,13 @@ int bootdev_setup_for_dev(struct udevice *parent, const char *drv_name);
  * Return: 0 if OK, -ve on error
  */
 int bootdev_setup_for_sibling_blk(struct udevice *blk, const char *drv_name);
+#else
+static int bootdev_setup_for_sibling_blk(struct udevice *blk,
+					 const char *drv_name)
+{
+	return 0;
+}
+#endif
 
 /**
  * bootdev_get_sibling_blk() - Locate the block device for a bootdev
-- 
2.43.0

