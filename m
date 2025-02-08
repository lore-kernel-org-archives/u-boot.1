Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FCDC0219E
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 17:13:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6945A80AE3;
	Sat,  8 Feb 2025 18:12:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H81EiLwF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95A7280A09; Sat,  8 Feb 2025 18:12:32 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 747B38083C
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 18:12:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-852050432a8so94831639f.1
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 09:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739034748; x=1739639548; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nlP6bUxcy2ZERKgB0l2T8o+gOQZt1svTpktojBx+cFY=;
 b=H81EiLwFIA29yswLhleDolOkK9RyqXHjOu+nK0oaxM1Y37pxv8oqFwl6hmtD8nSxih
 v9gGb523qjVZpc+nE9orMmT4PzOV1WMVRTdqwrqibUDVtTgQ7yBNicQSs1jqF99BzQrQ
 IZYQFQdg4byJ93oIUzGuseVcVJzGh6hMBmhWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739034748; x=1739639548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nlP6bUxcy2ZERKgB0l2T8o+gOQZt1svTpktojBx+cFY=;
 b=MN0IWbdEwkNlSlaYK3pGzmKNyL3Jtl4r6G1DEgT+boC+4jPz3wWVlq+7sFmcgfy3R9
 62J93xV0sUnhL3MBYP2unNEg1QXyDNrt4cj11E4v3LI2U8gHlgs2gCi5VJJoUiMcxKnE
 bunSdNo7yyjYYJjFCEzaq4fDOTL6prQi12E6ph3JwbDSuP95akiWXWhH3zgJ7w1CbUF2
 odYPSd3ZzGFJZw1P0F+QzzuEevR5H9lHxP7rSLAIDo2ISjtpjOT6oKbQ7KmwiNr3onvv
 D7+A1ggIC81BI/xiI/Kv/PKvXKCK9YliniTpMUyig2yN3rz5dWwBuvEj7pOCQGnrvzIF
 fWJQ==
X-Gm-Message-State: AOJu0YydgEjzXdAw+FQu0hWl7JAgNhWhlXIcaSCLiI5270juNcw/zJXz
 kHqbViIDew16MJGkVN7SawqOU5sAfKjGufPQPiIcU/yKuGIfYN78akRRTyDkVhehl+nqAYa6w94
 =
X-Gm-Gg: ASbGncsH1DgEhCvTdBa2ZLBW3ldbqibGS0TUmj5HD7g3pxsa7/Qacuju/5xsXFKb4Oo
 CR6LQ2PawJqGTlbBf7ZI15XXFN9pRFLmdej0meIlm61LTf+yMffMxYK6SSTzYwUVFPMEnuEZAzW
 QxM0TJtCx4Ah5UgpFjtX2RGx9epstBtXp2uUqnk1kjMd1IkgzAJhNOmj172g/6Pm6KWQDAz2nZx
 BBjj2RLKTS379ya0EXhgQjxaNmh7Y7Wckj0kIQJu0myWRYotn+tQ9JcXwARAAW7hYA2mb6zbD1W
 AhHQXijoAfgkLAjkFYlQR9NNKXYkJWegqH5nZRL+UVxo5Hir8DDr
X-Google-Smtp-Source: AGHT+IF81hYKVANO8Tci4Jebnww9BclyRca8RbvNcrNBvAyy3aoxPF1+Ew6KmFFM4QK6nU7K11C0Dw==
X-Received: by 2002:a5d:8347:0:b0:82c:ec0f:a081 with SMTP id
 ca18e2360f4ac-854f3a2d2f2mr919302939f.4.1739034748688; 
 Sat, 08 Feb 2025 09:12:28 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ece80badb5sm371754173.68.2025.02.08.09.12.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 09:12:27 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 10/29] efi: x86: Allow setting the global_data pointer with
 EFI
Date: Sat,  8 Feb 2025 10:11:30 -0700
Message-ID: <20250208171154.1305761-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250208171154.1305761-1-sjg@chromium.org>
References: <20250208171154.1305761-1-sjg@chromium.org>
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

Provide a function which sets this pointer, for use in the EFI app.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/include/asm/global_data.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/global_data.h b/arch/x86/include/asm/global_data.h
index 06bd80ccc13..1bd1fa92078 100644
--- a/arch/x86/include/asm/global_data.h
+++ b/arch/x86/include/asm/global_data.h
@@ -142,6 +142,13 @@ struct arch_global_data {
 /* TODO(sjg@chromium.org): Consider using a fixed register for gd on x86_64 */
 #define gd global_data_ptr
 
+static inline void set_gd(volatile gd_t *gd_ptr)
+{
+	extern struct global_data *global_data_ptr;
+
+	global_data_ptr = (void *)gd_ptr;
+}
+
 #define DECLARE_GLOBAL_DATA_PTR   extern struct global_data *global_data_ptr
 # else
 static inline notrace gd_t *get_fs_gd_ptr(void)
-- 
2.43.0

