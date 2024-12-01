Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16690D49779
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 16:39:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C148B894B8;
	Sun,  1 Dec 2024 16:25:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nAGC0rUm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C882389462; Sun,  1 Dec 2024 16:25:39 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69B518945C
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 16:25:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-84386a6669bso139509139f.3
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 07:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733066735; x=1733671535; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DmHlpcCp6GCqh3b1woYvfhLdcOPBlyNsqlhmP4GLQNQ=;
 b=nAGC0rUmB+S/ivv3pYXYmyCSFe3ZZcVofBgPoyMAL/x9uTMpvZ5uJeLpZLxDlhq7Yu
 XRpgNDa+79Y0zSbncfH6JFqW7Yc9Z+VVIbp2st2Bu2X+ZMU0d9mhXORNf/7ZlK+luJuZ
 rZKEvUdAkRWUbMuUWU0We7aZtEwhyNrxNOoTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733066735; x=1733671535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DmHlpcCp6GCqh3b1woYvfhLdcOPBlyNsqlhmP4GLQNQ=;
 b=HMDOYkrKjULxB7t875LjzRXGiNedvTYOXc6EahRtqGiUvME+VqzpQZ72ljIR0YHpUC
 IMvXQU0oaTMDtwiv/6EOLtdEqALZn/yUjyqdnT4DpySbYY/68/2cp0sg/lK4TnkCCLNE
 KDq/o5GZNqDyc4OPJMb/sJ40ihPf9FV3VXuWzaq5if9CFiqxzogsQpkvEXVYnLZDZB5D
 XhcZYAutHlvpjZ1xblsjyGxadcauQgU2uJDkVGse9S8q5VuLDiaSkfHhD6B95+u05hJ2
 Tf2FqUl6W34zHLn6dUXk0Du0lQ0bzi7cD/GbnewxdpsjiVv/1ktiA3iTlGRjS2Q59vMb
 4RDQ==
X-Gm-Message-State: AOJu0YyzazcOQuCMKncQWR+4ha8N9NOG23tncYshslU2GAD0TXm5EkGv
 ja+E/2tSbSTolMh7U5JbPwG909zgYgvoP5uYSZkLg3i9/HF7yRs8AYYH1eR3wYbzsVbs/ZaWNEE
 =
X-Gm-Gg: ASbGnctnT8Vf2Hf3QGYC++rcQ3LxmgQjC+oqC8gPGuMtjjVXx+H02PXJmx6tI7jlrvH
 ECncEEcYPWF0kq+BVCWUOOA91CuxhAj693Jg81is27hs7UbTwcbh5cY47lZO7rFLGPRjwFSdiAf
 hWvaZZjWFnTv28zh/D/UMk4RuCM0p/d5OvWwR/QUQDOwkPCKtxJCiWmPaOuw6lViZRxhrcV4AmV
 8ULbUV123v+ZVGk0EhxF9bJfy5IVjd6MwFlYzjMIHWI
X-Google-Smtp-Source: AGHT+IEbxmIBD4hdYnayPCQjKxCQlrOwM8gprNqCbt6wyqPZ6tzjADbF0UpBeHhgmLZ8Isrenrv1MA==
X-Received: by 2002:a05:6602:3f93:b0:835:3ffe:fe31 with SMTP id
 ca18e2360f4ac-843ecffe1b2mr1766828639f.8.1733066735737; 
 Sun, 01 Dec 2024 07:25:35 -0800 (PST)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405ec8d88sm159755239f.19.2024.12.01.07.25.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:25:35 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v4 08/25] doc: efi: Add the EFI-loader API documentation
Date: Sun,  1 Dec 2024 08:24:27 -0700
Message-ID: <20241201152505.1666789-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201152505.1666789-1-sjg@chromium.org>
References: <20241201152505.1666789-1-sjg@chromium.org>
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

Bring in the documentation from the efi_loader.h header file, so we can
see the API defined there.

Fix efi_alloc() to avoid a warning.

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---

(no changes since v3)

Changes in v3:
- Put the header-file in its own section

Changes in v2:
- Add new patch to add the EFI-loader API documentation

 doc/api/efi.rst      | 6 ++++++
 include/efi_loader.h | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/doc/api/efi.rst b/doc/api/efi.rst
index 43d6f936fb0..49814bcf5ea 100644
--- a/doc/api/efi.rst
+++ b/doc/api/efi.rst
@@ -54,6 +54,12 @@ drivers, handles, loaded images, and the memory map).
 .. kernel-doc:: cmd/efidebug.c
    :internal:
 
+Overall API
+-----------
+
+.. kernel-doc:: include/efi_loader.h
+   :internal:
+
 Initialization of the UEFI sub-system
 -------------------------------------
 
diff --git a/include/efi_loader.h b/include/efi_loader.h
index 00a1259c006..3f75f2efcb6 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -764,7 +764,7 @@ efi_status_t efi_next_variable_name(efi_uintn_t *size, u16 **buf,
  *
  * Allocate memory from pool and zero it out.
  *
- * @size:	number of bytes to allocate
+ * @len:	number of bytes to allocate
  * Return:	pointer to allocated memory or NULL
  */
 void *efi_alloc(size_t len);
-- 
2.43.0

