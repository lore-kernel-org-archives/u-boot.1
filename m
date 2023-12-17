Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863CDC3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 17 Dec 2023 16:38:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43A4487CD2;
	Sun, 17 Dec 2023 17:36:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hLtpeq7m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D045E87C8F; Sun, 17 Dec 2023 17:36:46 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3C2787CA9
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 17:36:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7b7a9f90ee9so86999139f.0
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 08:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702831000; x=1703435800; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RcgQluQqNMcVNvTsXACQeH7hM0OQB9gYi/tIKcUbYnk=;
 b=hLtpeq7mNy23pxu+mM+EQfGMMW6BkuecGEzHhS6NSwq96HrkUUWfh6ZOf9LL5BQZe4
 BcVuJa0zrrIQ+GpOLQ6OJxqdNh3pgUBCjk3dmdW3nYn00C2bHuevD2tZ2QPvLdru/7Ex
 C7BS79c+aWXhEarjOmQ+KeoANwgjaMuBfy0gU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702831000; x=1703435800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RcgQluQqNMcVNvTsXACQeH7hM0OQB9gYi/tIKcUbYnk=;
 b=r4L0uhuNHxJiiI4sa0PjDAr6ptet/+FmpDKwAAPTalMeSeoN/8c3ot3TRsLh2Lcay3
 sjP7wuOF1u4cMNnnULst1ev+7k6rwKjll0nqF7gFGFDxixF7DNyr78KGKdvqfqUMui1i
 WTa76cWDAZIJ6Brupg8O0AY1HCMZJsVvG7WxzsXLWlSOnnvlTxpQe1BwdJrVn5/+J3y4
 VhLrCPHNUeFIfFzjzgnD4FMhGhn/998TSDZT7iY2NwzLKB2rBEJhj93M3MoD5oo6QRX1
 0ST4FnzUs06qaIrIsHkHj0Uwr0w2gUGJI8n0udfsAuN18acVCA43mu9qU1v9tDYtcSBW
 aeIA==
X-Gm-Message-State: AOJu0YyATHnyswQpod4BNdiPCE29zeya8H6Qcb3gTdjpTiTchEkUJ47N
 0VecYOheByykauo7c92PRHIBdHfxCPC2UglQW7rJ1w==
X-Google-Smtp-Source: AGHT+IFdrlDqNmyPZRB+iucCMx1oRmbkVbxTG5UhEJWQj/F1JkStBAd9Opj4pyGDox9JkMobECTtOw==
X-Received: by 2002:a05:6602:35b:b0:7a9:6a65:e361 with SMTP id
 w27-20020a056602035b00b007a96a65e361mr17318232iou.9.1702831000549; 
 Sun, 17 Dec 2023 08:36:40 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 ei10-20020a05663829aa00b00466917fbfc4sm4925770jab.71.2023.12.17.08.36.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Dec 2023 08:36:40 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 08/10] sandbox: Correct SPL condition for building devicetree
Date: Sun, 17 Dec 2023 09:36:21 -0700
Message-ID: <20231217163627.2339802-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231217163627.2339802-1-sjg@chromium.org>
References: <20231217163627.2339802-1-sjg@chromium.org>
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

With sandbox, CONFIG_SANDBOX is y so the current rule ends up building
the devicetree for only those SPL builds where it is unwanted.

Correct the condition. This allows sandbox_vpl to produce a
u-boot-vpl.dtb file.

Fixes: e7fb789612e ("sandbox: Remove OF_HOSTFILE")

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 scripts/Makefile.spl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.spl b/scripts/Makefile.spl
index e450ffd5d5ef..407fc52376a5 100644
--- a/scripts/Makefile.spl
+++ b/scripts/Makefile.spl
@@ -314,7 +314,7 @@ endif
 #   - we have either OF_SEPARATE or OF_HOSTFILE
 build_dtb :=
 ifneq ($(CONFIG_$(SPL_TPL_)OF_REAL),)
-ifeq ($(CONFIG_OF_SEPARATE)$(CONFIG_SANDBOX),y)
+ifneq ($(CONFIG_OF_SEPARATE)$(CONFIG_SANDBOX),)
 build_dtb := y
 endif
 endif
-- 
2.43.0.472.g3155946c3a-goog

