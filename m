Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE99C02182
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:27:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C091D807A8;
	Mon, 20 Jan 2025 22:26:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A2upIg2B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2748180717; Mon, 20 Jan 2025 22:26:40 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB37C80759
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:26:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3cda56e1dffso15145605ab.1
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737408395; x=1738013195; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CO1TjM65SEiYWihO+5BFfUIJTuHFlA1Pg/VAS+ZGMaY=;
 b=A2upIg2BHU0U30Og48rWa1U0sgzeCgRsDfvTIO8B2u7GzDPHIlKXLou4cD30op67x/
 XNIo6r9bf0UbeKBuwIHaQzXy9/MjpM2y+rnb1/ldweDilyxFFFlfHaNaMGCrqfBJd2BU
 KmDO0GS6JFsHEhXMhu+khIp/8pAPXQQcC1IRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737408395; x=1738013195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CO1TjM65SEiYWihO+5BFfUIJTuHFlA1Pg/VAS+ZGMaY=;
 b=jHCTKlNluGE8gjw60udHBpanzwbGXxutmPJHacEMJKOhOchhTf9nM53GnrrVnZwIOc
 gT4Y6TnWufcetrV0HmrB0Wx0O+WxM55XxO1AjIJswdQAPG5tzs2nNwcw37zfOtj8PjPw
 6o+EW0tG99HURds+EgAI2acurTxc05kltXNiia080dZhg5cq1w+5N4A/Zh6gaKK597LU
 g+z8OZnejSbzpFkgikFF8F3VQPDBXRILFHZM5RqD6FUVtRsFtj/g59+tFvxSRQotEMgf
 8Zw7u0hKaFN2XdqPscwVt2XAx6bPeN+Z7yyPK49idCYHBFHg0hDc2sTWq359IYZxptjy
 FpQw==
X-Gm-Message-State: AOJu0YwZBquy4BG1O06yi29ExNCBHmqu0szupGAv69Fv5pveFT2uQuQx
 sDT5Qqk+CCHvdaCV5AUQ9KCMom8gXgCfkTZV1xWPtjwUboS8F3MxNXK8SBwth9lVyfIwj/4FMYE
 =
X-Gm-Gg: ASbGncsieV3cnuA4OVqa3BBogkZ0RU6nsD6gbcZ8y5E4ik5d/ZHliW42WiVzFgAgA+N
 lTfipVDqct7/Q92+VR5Ey2LD1hRqR6mraeI8oP7ejl6ofJDbr1kX60h9awPjeFjhXoSVxz3qXbW
 is/UbPBK/jmU2dOC+2pI8DoBN9xM+C/7c1sJICjEelqAYKW9VXXw2GO3dbO6ONxlNmylez/vpey
 3NuxnqPiNNCKyf0159HsBkHuB2U2UfPgnUoLiOUob5SX/iJNixrWXF+rr/M6uJ8Eyotbs23QHqT
 J/WgWDKqjfZj3ozVH8+nDMXiHWOWew8=
X-Google-Smtp-Source: AGHT+IEpFn/oXAnG7nomPi168pEnnZtwo6JECIQ3tWDMcUW5LQKl4XRYvClWWkIsfJLks6++E1pa1A==
X-Received: by 2002:a05:6e02:1d8b:b0:3a7:820c:180a with SMTP id
 e9e14a558f8ab-3cf74493955mr115794155ab.19.1737408395617; 
 Mon, 20 Jan 2025 13:26:35 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea75440a24sm2847693173.33.2025.01.20.13.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:26:33 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 05/44] Improve support for linker lists in data structures
Date: Mon, 20 Jan 2025 14:25:27 -0700
Message-ID: <20250120212613.516664-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250120212613.516664-1-sjg@chromium.org>
References: <20250120212613.516664-1-sjg@chromium.org>
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

Changes in v2:
- Correct linker-list documentation

 include/linker_lists.h | 57 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/include/linker_lists.h b/include/linker_lists.h
index f9a2ee0c762..0f4a2d686e2 100644
--- a/include/linker_lists.h
+++ b/include/linker_lists.h
@@ -186,6 +186,63 @@
 		_ll_result;						\
 	})
 
+/**
+ * Declares a symbol that points to the start/end of the list.
+ *
+ * @_sym:	Arbitrary name for the symbol (to use later in the file)
+ * @_type:	Data type of the entry
+ * @_list:	Name of the list in which this entry is placed
+ *
+ * The name of the (new) symbol is arbitrary and can be anything that is not
+ * already declared in the file where it appears. It is provided in _sym and
+ * can then be used (later in the same file) within a data structure.
+ * The _type and _list arguments must match those passed to ll_entry_start/end()
+ *
+ * Example:
+ *
+ * Here we want to record the start of each sub-command in a list. We have two
+ * sub-commands, 'bob' and 'mary'.
+ *
+ * In bob.c::
+ *
+ *   ll_entry_declare(struct my_sub_cmd, bob_cmd, cmd_sub) = {...};
+ *
+ * In mary.c::
+ *
+ *   ll_entry_declare(struct my_sub_cmd, mary_cmd, cmd_sub) = {...};
+ *
+ * In a different file where we want a list the start of all sub-commands.
+ * It is not possible to use ll_entry_start() in a data structure, due to its
+ * use of code inside expressions - ({ ... }) - so this fails to compile:
+ *
+ * In sub_cmds.c::
+ *
+ *    struct cmd_sub *my_list[] = {
+ *      ll_entry_start(cmd_sub, bob),
+ *      ll_entry_start(cmd_sub, bob),
+ *    };
+ *
+ * Instead, we can use::
+ *
+ *    ll_start_decl(bob, struct my_sub_cmd, cmd_sub);
+ *    ll_start_decl(mary, struct my_sub_cmd, cmd_sub);
+ *
+ *     struct cmd_sub *my_list[] = {
+ *       bob,
+ *       mary,
+ *     };
+ *
+ * So 'bob' is declared as symbol, a struct my_list * which points to the
+ * start of the bob sub-commands. It is then used in my_list[]
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
2.43.0

