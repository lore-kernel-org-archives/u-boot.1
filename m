Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C275C52D6F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 22:49:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 728CA88AEE;
	Thu,  8 Aug 2024 00:48:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V7TuZnkh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B005F88AE5; Thu,  8 Aug 2024 00:48:14 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93E23888F8
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 00:48:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-397ba4f7387so2283925ab.0
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 15:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723070891; x=1723675691; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=spZHfR6nUyJdkwY/1j0TIIYOp3ly9C8+WGByeLEyfm4=;
 b=V7TuZnkh/hSyYxTvS8MVaqN3Xx2OY3eDD+Xhe+uBmmGR/U+taJo1bqJljiHMLQY9xF
 mQEGv97FMCM/5RoVjzQsxFDRFsg1DIzRT2XK2PxHT7CRBHmO0ZZwOuFRqaNM8s9KbJWZ
 WCB8mrg+X1G9jJEdZdfrHkl9elPAsheUb0xiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723070891; x=1723675691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=spZHfR6nUyJdkwY/1j0TIIYOp3ly9C8+WGByeLEyfm4=;
 b=ZTdPT5bPVFKoUw018O6qRhvhCmj1UmpX/ym1yCZgtBKiJ6+NccfUmslSUwbnLsjctk
 mSq6GUHf1pfWPlW3UxTNUWUQWxAEX3EuSHcgaP0j5xZ67ncg14Z1QPlL2Q6aNGbbDPvp
 FFYgK+lCdLX+/28BB964BNFU+ZXiOwdTuoIP78vau31yVIJyQSLQOrshD/rPtyY8KKkF
 0+FqRiqKvvoL5wySR6CpDR14ngA2A1xx8o1O6xabpSTH+wiQyy8KojgiRAR+uSzhfkTN
 6JlnSXIJ39II6s1qxBj3C6D+LybNwo7sZrLeOW5ujIlz0yQnazXOuaRNHuQ2XBq+10Ur
 GyKQ==
X-Gm-Message-State: AOJu0YwQXPvTdWNJZnzlTr7eKIRIpmdHedP/MZjw9xQeNvVQEItV0nkQ
 q0RfI7mnRGo0ZBlawtqYnMs6VvBFJ6BYtdzElnzBKotsoLBQ3MJeJ5STHyD3T9S6+erce4pYKok
 =
X-Google-Smtp-Source: AGHT+IHBsrCrdtMClth+jThzcfE9hrD3Hwi4mYvmBJ5P2kImK0XtsIdqevMuUSB3OlFOjkVR+JV7ng==
X-Received: by 2002:a92:874d:0:b0:39b:1ed5:4a4d with SMTP id
 e9e14a558f8ab-39b5ed08592mr626515ab.19.1723070891161; 
 Wed, 07 Aug 2024 15:48:11 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20af1528sm48275205ab.80.2024.08.07.15.48.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 15:48:10 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>,
 Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 08/21] sandbox: Set up global_data earlier
Date: Wed,  7 Aug 2024 16:47:26 -0600
Message-Id: <20240807224739.3858517-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807224739.3858517-1-sjg@chromium.org>
References: <20240807224739.3858517-1-sjg@chromium.org>
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

It is possible for U-Boot functions such as printf() to be called
within state_init(). This can end up checking gd->flags (e.g. in putc())
before global_data is set up.

Move the setup earlier to avoid this. This fixes the suppression of some
debug output in memory allocation (when enabled).

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/sandbox/cpu/start.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/sandbox/cpu/start.c b/arch/sandbox/cpu/start.c
index dce80416529..0920ed55965 100644
--- a/arch/sandbox/cpu/start.c
+++ b/arch/sandbox/cpu/start.c
@@ -483,6 +483,9 @@ int sandbox_main(int argc, char *argv[])
 
 	text_base = os_find_text_base();
 
+	memset(&data, '\0', sizeof(data));
+	gd = &data;
+
 	/*
 	 * This must be the first invocation of os_malloc() to have
 	 * state->ram_buf in the low 4 GiB.
@@ -501,8 +504,6 @@ int sandbox_main(int argc, char *argv[])
 		os_exit(1);
 	memcpy(os_argv, argv, size);
 
-	memset(&data, '\0', sizeof(data));
-	gd = &data;
 	gd->arch.text_base = text_base;
 
 	state = state_get_current();
-- 
2.34.1

