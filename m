Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8997FC54F32
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 12:10:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FC6483189;
	Sat, 24 May 2025 14:09:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KHK/vccT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35778830E9; Sat, 24 May 2025 14:09:56 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 404DC82E28
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 14:09:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-44b1f5b917fso3491475e9.3
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 05:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748088593; x=1748693393; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kvc4wFolzswGGq9nOYG6dcV4F3HSiXDtw3lRskxzcg4=;
 b=KHK/vccTH/zs7A8ZK9TIh1FlpI99DQKwSegpFuQ0aQmbqdTMFb5MMiLOPo/x80r+RB
 DKgpZD0l9Ugb4xwA2t8VpT+Duoe935WJodMcFyjgf/ocvkEJwuQQ9xlrFJqD2/o+QkKj
 sCTY4SHtSvMJRRYV30Jd+vN/vomZOPLDny4UQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748088593; x=1748693393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kvc4wFolzswGGq9nOYG6dcV4F3HSiXDtw3lRskxzcg4=;
 b=nWvJ5xxEeUpRMjjic9IQJoaxy4IUXwSr+labyNFEgORYolq/0ATI8rkXC4REumNKPk
 92LGyRY+jJaq491p/8pgWTSSAwzNKb6tVzJUXMEOR8J/e81d+0PG1vQcTkRmZ1Oq+0hQ
 DTeRAtkKMWYUXY3XrS3hRA09kDKF5hpL18MjMLALIpPZKmTgOQXnrcKhQ9Gs4eCMdyTf
 ZEcYSLUfz9BWp67Ya323OTrq6N+Omk+9hcPKQxppOHjLKCNuxPOb56tk6PqoY5nZim03
 k7/FGU0eePytSkyhWrzhuyyAB1YGSBmOy6QvfSUVbONJeiJxcGR0uAcR4sM3Y2SeiUu6
 bhVA==
X-Gm-Message-State: AOJu0YzJKv4KKV24xIp2o5+X5enEVLcwF3fhClDHWSTCxCAunSby2Xpb
 5wusSx8HbQKCByC6yb0ggCpVJMGTnkrkWGER4GWIHgb4aTzTB0mgWmBOB4x6p+MxX4wxwLM+asK
 ATlqe/D/V
X-Gm-Gg: ASbGncuJq4aL1eXoF0oO5uygzxKv88gF5sGbcRP6mw+7YtLqVUDQXbjDpaY1r+iYT/3
 tNdqMmmEdWKEvqnd/BFYSJdGUNJYz8Y0oduxWoeYNBrYgnfbBCvnruxrBal6ooulfSmr9NBZDi1
 7G8KC6EW5PZCtTtp44jgp4YOHxhE60aN3ySjjld0EVygFaP73BiGcPr8cnreJvzVjnuHTYNWoHv
 6Uzw9Zk9xKO/06yj8jrOv7D5S7rGy+lEYAbbB66ya3AaggjA7KbKEeEpjc5j28+MsoS+H1Q7kW7
 Bfp6AOGaGj1ne7H8ge+Kn957gssFQN6FJq+QhNSqp0wEkNDBRaSVhqNr/yOjQcFIlgqgVH0=
X-Google-Smtp-Source: AGHT+IFGeFMkDUR6biHca96fMX8L/zsBCLEEHsIT4r7OPl3m57LfviKdNQMmXqbl2oQPHGmToyJTIw==
X-Received: by 2002:a05:600c:3b90:b0:43d:77c5:9c1a with SMTP id
 5b1f17b1804b1-44c9141a950mr25450755e9.4.1748088593133; 
 Sat, 24 May 2025 05:09:53 -0700 (PDT)
Received: from tasman.. (host-80-43-238-15.as13285.net. [80.43.238.15])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f23c07bfsm177028585e9.23.2025.05.24.05.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 05:09:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Adriano Cordova <adrianox@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] Revert "efi_loader: Moved the generated ESL file to
 objtree"
Date: Sat, 24 May 2025 13:09:01 +0100
Message-Id: <20250524120904.684977-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250524120904.684977-1-sjg@chromium.org>
References: <20250524120904.684977-1-sjg@chromium.org>
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

This reverts commit 31f66cd7577664ea8725520bf2083cf010fbc477.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 .gitignore              | 1 -
 lib/efi_loader/Makefile | 6 +++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/.gitignore b/.gitignore
index 272257a77bb..e93c33da1bd 100644
--- a/.gitignore
+++ b/.gitignore
@@ -78,7 +78,6 @@ fit-dtb.blob*
 /drivers/video/u_boot_logo.S
 /test/overlay/test-fdt-overlay.dtbo.S
 /test/overlay/test-fdt-overlay-stacked.dtbo.S
-capsule_esl_file
 
 #
 # Generated include files
diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index cf050e5385d..d8864e87052 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -79,7 +79,7 @@ capsule_crt_path=($(subst $(quote),,$(CONFIG_EFI_CAPSULE_CRT_FILE)))
 capsule_crt_full=$(srctree)/$(subst $(quote),,$(CONFIG_EFI_CAPSULE_CRT_FILE))
 quiet_cmd_capsule_esl_gen = CAPSULE_ESL_GEN $@
 cmd_capsule_esl_gen = cert-to-efi-sig-list $(capsule_crt_full) $@
-$(objtree)/capsule_esl_file: FORCE
+$(srctree)/capsule_esl_file: FORCE
 	@if [ ! -e "$(capsule_crt_full)" ]; then \
 		echo "ERROR: path $(capsule_crt_full) is invalid." >&2; \
 		echo "EFI CONFIG_EFI_CAPSULE_CRT_FILE must be specified when CONFIG_EFI_CAPSULE_AUTHENTICATE is enabled." >&2; \
@@ -87,8 +87,8 @@ $(objtree)/capsule_esl_file: FORCE
 	fi
 	$(call cmd,capsule_esl_gen)
 
-$(obj)/efi_capsule.o: $(objtree)/capsule_esl_file FORCE
-asflags-y += -DCAPSULE_ESL_PATH=\"$(objtree)/capsule_esl_file\"
+$(obj)/efi_capsule.o: $(srctree)/capsule_esl_file FORCE
+asflags-y += -DCAPSULE_ESL_PATH=\"$(srctree)/capsule_esl_file\"
 endif
 
 # Set the C flags to add and remove for each app
-- 
2.34.1

