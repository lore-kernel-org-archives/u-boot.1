Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23DD8CCFA13
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 12:48:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A563283A2D;
	Mon, 10 Nov 2025 13:48:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JhFJg+Hd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12F628397A; Mon, 10 Nov 2025 13:48:09 +0100 (CET)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE92E8397A
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 13:48:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-ba599137cf7so2205626a12.0
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 04:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762778885; x=1763383685; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=6krbzXvUvZ6wdYeV8wERppIk6uLxbgDGpq8jOkSi7Hs=;
 b=JhFJg+Hdugry3rlKmvjKyuBKL2guCDrqUlO+DskMC/G7JQDUtEV8hZif7aBQcrhLta
 AHwR1G2wFGpE3lTxPGCNQv7Mco7zHuCNh6KSyhHHcWaViRUmU+gNjBk6hLmxz7Fiyzws
 eCBVNQ2VPJx2qVDDkGawBYIEfZ3zhOo8qMJenkP3hhF2VDk7k2zFXDf+L/iWj/PYcrqK
 RwpI7H61fhZQ3dJ8vQ2Fvc7wltOkK+BWlHBvTW0jYVfTCMOG+BGc7C7T+ymY/431/o+B
 GwNvxG8IrMaGj6yA6l2AJhyCEEn+Xkipu16VvxxTKoHhd3NbPcmhG9zexAAC1ckJWW/P
 nj1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762778885; x=1763383685;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6krbzXvUvZ6wdYeV8wERppIk6uLxbgDGpq8jOkSi7Hs=;
 b=uM9wAh2vcMcyNfb5Xm+z9LVax1QEbYWeiKuoD5UTmMk/roKu0JjtPOU6yhd7TAVlKZ
 Ux5+WaPm9qjqhNfNmn2qSGEsw7Yk2FVxfEn8auypbcaejFGH57pXmo/OgkgIqBaeTsgg
 G9LDwHBUXNTwCoQoTU2wlOpX83hS3Cy+45wyLMF4Xg05vQrrMcWhFTvf0oV0Y+OyUwPD
 Hw0ytBi8ISpY2ISBap8VqM7ltSrnTMnmvalO422oiNJLPjx+yLfUt53dsgou1c8aC4GL
 KyJHJp6NHEa54oJYM6BxVAdnI39MdXe150yX83XcelvA8CH/FApdRMsaA3GJYrWsgvJO
 l2Bg==
X-Gm-Message-State: AOJu0YyzUw7R6SBQhQkdGxsO2teG7wnL/O86wAbCc6MKO32wBTL4zN4E
 yKNVYfHaHdDIQ4tUdsw1W8hKyUY78YK1yj8NokX2H0Sj58ijAhHfRMIlDOMF9UEy
X-Gm-Gg: ASbGncuJ3kXsH3L9/VFMm+he2MswIC/Ah7St5exHOESGQNYdhgfq/XznQof6ZLNwMqc
 u7CyP61eKOvrRck4skcOsnzKqtGm+fR0slwk6Wljks6QSQL/cYm9qlUQSYyvnhNNzbCnRZDdqG5
 Hw7KsRAthf2MWstEZAItrs9I7GWsiL6sAMysw4lViWZ590GPT2sPkYJhvw6rCeeqrHhxdaIXD8Q
 XnuxgNcQyWTARk7c0uGRZ6ubW/pQd8hd+dp5RklUDKeEPeZPRrXWu71BSEejimxyhX14XtT9HEz
 TKxv0utMp0DHJmedURuOzZIVbyCvmA3rnojKbyY17ZAMNXv+JgbTr9Sr+1UwZY+R762pCj81vxJ
 3Y3kPlM5qXxwO0QrXrs6/SB66r7xMDxKaPlan2eilhwqg15tjL01upM3eClclKXjCCrzHmKkhHk
 A1V7pJXw==
X-Google-Smtp-Source: AGHT+IFQvRZn+VRiapXT4gbgSY/1OrnMnCfcB4IFNCMS41nte6R7o0wt9QM4WZR9nUo6byK/U39Gsw==
X-Received: by 2002:a17:902:f684:b0:274:777b:ca6d with SMTP id
 d9443c01a7336-297e56cc02cmr102414695ad.43.1762778885025; 
 Mon, 10 Nov 2025 04:48:05 -0800 (PST)
Received: from ubuntu.. ([111.196.133.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29651ccec04sm145345885ad.102.2025.11.10.04.48.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 04:48:04 -0800 (PST)
From: Bin Meng <bmeng.cn@gmail.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/2] bin: Fix the broken symbolic link of qemu_arm64 config
 file
Date: Mon, 10 Nov 2025 20:47:59 +0800
Message-Id: <20251110124800.1642591-1-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Commit 48a0f7fa renamed the conf.qemu_arm64_na to conf.qemu_arm64
but it forgot to update the symbolic link in the bin/ellesmere dir.

Fixes: 48a0f7fa ("bin: Run the conf without board_ident as default")
Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

 bin/ellesmere/conf.qemu_arm64    | 1 +
 bin/ellesmere/conf.qemu_arm64_na | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)
 create mode 120000 bin/ellesmere/conf.qemu_arm64
 delete mode 120000 bin/ellesmere/conf.qemu_arm64_na

diff --git a/bin/ellesmere/conf.qemu_arm64 b/bin/ellesmere/conf.qemu_arm64
new file mode 120000
index 0000000..dee6855
--- /dev/null
+++ b/bin/ellesmere/conf.qemu_arm64
@@ -0,0 +1 @@
+../travis-ci/conf.qemu_arm64
\ No newline at end of file
diff --git a/bin/ellesmere/conf.qemu_arm64_na b/bin/ellesmere/conf.qemu_arm64_na
deleted file mode 120000
index cf56db1..0000000
--- a/bin/ellesmere/conf.qemu_arm64_na
+++ /dev/null
@@ -1 +0,0 @@
-../travis-ci/conf.qemu_arm64_na
\ No newline at end of file
-- 
2.34.1

