Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D384C02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:33:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB076807A8;
	Wed, 15 Jan 2025 14:31:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XmJEZckb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18F2B8082A; Wed, 15 Jan 2025 14:31:33 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C30B480714
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:31:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-844e9b8b0b9so503276739f.0
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736947889; x=1737552689; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Np2pIR4nIF+vH15uf8exWEQ9+7XhSI4DWbdzaFxPZ88=;
 b=XmJEZckbphxbTyk8wRoyjLA183Ur97xB52v/+4HETMZZLXiecrfLCoPnOVQQjcKfYL
 6OAwc6gcHS9h0RTDz0xyEhNqsvd2ifmb5xiO+3G8ZEIlWYsX9kBz6Udb0KjvSlXcjww1
 bSkigSWZpckKtzNlXQiMr1UeUNrhSUhc+VReo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947889; x=1737552689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Np2pIR4nIF+vH15uf8exWEQ9+7XhSI4DWbdzaFxPZ88=;
 b=AU/JCchxeZTdHk2IhzqQMCzkEqfRF2kc6NRx7qqLKz0PflPxNi6Hn1t8FW6jUmvb2k
 hcerxl/fOO73JMDn51QOKzzX78otHaLtCyX840E1vNqe/8v8APh3AMuUrYATIqW7DvoL
 jiBY0HArERGBXCts/b3blT4tLCwiI8Ips7TLq+z3PrL9B0XNLErVB7Kp9D4qFSmwcAqX
 zu51mK7bdDl77SaUggAfOyJY12UkxXjXicP2ov9UvW8BE0x0EVkyXEBwJuued/LDleTn
 rZy02/E7kODaK2DgyHNB5HJf2ziVSCRbE0SNQSalm8fIY4anw22RLHKpKgw2ND7rsWCR
 67hQ==
X-Gm-Message-State: AOJu0Yz3gn4d05sgBQwFYaFVSt9Nd10QTedknx2f1a+UD4B0eEM7jPIc
 l3I6xDyenUHDu3wsaCxPSxktXuTImOHYLfa4lRW2+UQ69L5V4EANrpIwUBfxNLoP1knBZKX/mlY
 =
X-Gm-Gg: ASbGncsEvb4kN4gt7sPy8Ov2qNvuWX8Lz7ya6ESLTBXebZLRo5PzWvOBMmzh6Si9Kbf
 hS3fqIKBds1HqNIu+2To5WhzKbqH01ZXhlAPbI0DaBN0r+ZAXG7FmPGQI7Z9vMVrpsvW/kbEc0U
 PkfLoFhFVUke+CorLT3cO5JGRpzq2lKwEvGrG9QuT5ttsg+D7OFUf8IX6V8ojl1Z2mBSumIxXZy
 HIRa3GPA3RWjSUo9OnHK68lb6IpWc5rlc5QMsqQMv+44S6TpmbA6908DJmF31gfztn6QUAfTPQM
 MJlKVub4FVaw8oce0w==
X-Google-Smtp-Source: AGHT+IET+p0ImuywxcvxZn9znJic8YVgVnyq4kAA/ADe/qga4lslQveGCiADzp2acgfd7lltRq0zNQ==
X-Received: by 2002:a05:6602:36c8:b0:841:95b5:8953 with SMTP id
 ca18e2360f4ac-84ce018cbf3mr2901707539f.14.1736947888926; 
 Wed, 15 Jan 2025 05:31:28 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm4091248173.20.2025.01.15.05.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:31:27 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/43] Improve support for linker lists in data structures
Date: Wed, 15 Jan 2025 06:30:35 -0700
Message-Id: <20250115133114.590375-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250115133114.590375-1-sjg@chromium.org>
References: <20250115133114.590375-1-sjg@chromium.org>
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

A limitation of most linker_list macros is that they cannot easily be
used in data structures. This is because they include code inside their
expressions.

Provide a way to support this, with new ll_start_decl() and
ll_end_decl() macros.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/linker_lists.h | 51 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/include/linker_lists.h b/include/linker_lists.h
index f9a2ee0c762..c05b99c886f 100644
--- a/include/linker_lists.h
+++ b/include/linker_lists.h
@@ -186,6 +186,57 @@
 		_ll_result;						\
 	})
 
+/**
+ * Declares a symbol that points to the start/end of the list. The name of the
+ * (new) symbol is arbitrary and can be anything that is not already declared in
+ * the file where it appears. It is provided in _sym and can then be used (later
+ * in the same file) within a data structure.
+ *
+ * The _type and _list arguments must match those passed to ll_entry_start/end()
+ *
+ * Example:
+ *
+ * ::
+ *   Here we want to record the start of each sub-command in a list. We have two
+ *   sub-commands, 'bob' and 'mary'.
+ *
+ *   In bob.c:
+ *     ll_entry_declare(struct my_sub_cmd, bob_cmd, cmd_sub) = {...}
+ *
+ *   In mary.c:
+ *     ll_entry_declare(struct my_sub_cmd, mary_cmd, cmd_sub) = {...}
+ *
+ *   In a different file where we want a list the start of all sub-commands.
+ *   It is not possible to use ll_entry_start() in a data structure, due to its
+ *   use of code inside expressions - ({ ... }) - so this fails to compile:
+ *
+ *   In sub_cmds.c:
+ *     struct cmd_sub *my_list[] = {
+ *       ll_entry_start(cmd_sub, bob),
+ *       ll_entry_start(cmd_sub, bob),
+ *     }
+ *
+ *   Instead, we can use:
+ *
+ *     ll_start_decl(bob, struct my_sub_cmd, cmd_sub);
+ *     ll_start_decl(mary, struct my_sub_cmd, cmd_sub);
+ *
+ *     struct cmd_sub *my_list[] = {
+ *       bob,
+ *       mary,
+ *     }
+ *
+ *     So 'bob' is declared as symbol, a struct my_list * which points to the
+ *     start of the bob sub-commands. It is then used in my_list[]
+ */
+#define ll_start_decl(_sym, _type, _list)					\
+	static _type _sym[0] __aligned(CONFIG_LINKER_LIST_ALIGN)	\
+		__maybe_unused __section("__u_boot_list_2_" #_list "_1")
+
+#define ll_end_decl(_sym, _type, _list)					\
+	static _type _sym[0] __aligned(CONFIG_LINKER_LIST_ALIGN)	\
+		__maybe_unused __section("__u_boot_list_2_" #_list "_3")
+
 /**
  * ll_entry_get() - Retrieve entry from linker-generated array by name
  * @_type:	Data type of the entry
-- 
2.34.1

