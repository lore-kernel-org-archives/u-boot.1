Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C059D18158
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 22:34:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5D2389246;
	Tue, 15 Oct 2024 00:32:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y47au7zk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 902CF89256; Tue, 15 Oct 2024 00:32:32 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 627CF8921C
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 00:32:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-82aac438539so199001039f.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 15:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728945146; x=1729549946; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=905M5qZ5jVKL5O0WyD3QI9Wh7lOj1Sf2iljvk3vfyhk=;
 b=Y47au7zkwyyOp91OoH1zXgvSOYuDg31Lr1vJWxjnhFm5fMwD2yExsRQnHoFk7hK4wH
 agJ5zGh0a+S2FdUTFnaCWsmj5sWYj+ShkQ2FLZhr8U5rcc5rt0ideOgmJqgjbFcSE28t
 UDvRAj3lXBJJETbfrmdWd4jejioZAfi3zU5FQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728945146; x=1729549946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=905M5qZ5jVKL5O0WyD3QI9Wh7lOj1Sf2iljvk3vfyhk=;
 b=h9mi1VQzNoNmM529eVcrfKP1a8HS5UxmLr2fhM/8lTdlML9wRuNhzZUHYCmfjikpV6
 LgmOguNrXPaaklv1M/tyxDpsYvUE98u71kc4fOYeK3x4yUF6zgKAJ+VaOUuOkoTv1gDv
 meetqnF8rPSPHl/HMi/U5ATfFl7Mh9QkV4vO9xh1HtX+0Tz0devmBEU4HAWSp0HJPsXQ
 pAJPqOG+MsqKbdY5xVbYlYPlG0dbMhKmuj9RO9hmrbNcch7ObA8bO7Pxye3nh/jB8oU/
 waYG+mVJPQSM5eEqhU37+ZHNULfLZnmIe6mpPkFKDClnsoxmW3F0obHvqXmMd9UEXvij
 GmZw==
X-Gm-Message-State: AOJu0YyLfCeArp2NJzuaZsYkWBaqW/K1UoJy8kr+pYJwsJRJS99hby2k
 XA4NzRT1yFNJsexZlmVxls/AtADWTa2acimW0KZgT03By6wYGrfqMvMDlkoeYoINWOwk/hfHOEN
 e+g==
X-Google-Smtp-Source: AGHT+IEhd3mdJjAdL3BpiEQglvTSig4B8knaiyzw0EyF++RSvAn4RxeWwfeLdvtZubRuySYCRbZxfw==
X-Received: by 2002:a92:cd85:0:b0:3a0:8c5f:90d8 with SMTP id
 e9e14a558f8ab-3a3bcdb3e15mr60801205ab.6.1728945146013; 
 Mon, 14 Oct 2024 15:32:26 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dbecc4924dsm14847173.153.2024.10.14.15.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 15:32:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v3 11/20] expo: Add forward declaration for udevice to cedit
Date: Mon, 14 Oct 2024 16:32:03 -0600
Message-Id: <20241014223212.2212442-12-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014223212.2212442-1-sjg@chromium.org>
References: <20241014223212.2212442-1-sjg@chromium.org>
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

Some files may include this header file without first including dm.h
so add a forward declaration.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/cedit.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/cedit.h b/include/cedit.h
index a31b4245247..856509f0c7f 100644
--- a/include/cedit.h
+++ b/include/cedit.h
@@ -14,6 +14,7 @@
 struct abuf;
 struct expo;
 struct scene;
+struct udevice;
 struct video_priv;
 struct udevice;
 
-- 
2.34.1

