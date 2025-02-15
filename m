Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3936C021A4
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 03:24:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA2BE80EB0;
	Sat, 15 Feb 2025 04:23:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fgOe3JTl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79DA480F7B; Sat, 15 Feb 2025 04:23:39 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56A7A80756
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 04:23:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-8550803e1afso212990839f.1
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 19:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739589815; x=1740194615; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nlP6bUxcy2ZERKgB0l2T8o+gOQZt1svTpktojBx+cFY=;
 b=fgOe3JTl1cQLDKxDVvf9rEaSE0WTXuwKC7L/D4R383lcay54Fvncr5N1AtsGp4vl+H
 LQULIlgHK8+JvmRQ8f2e+aY9iLTEjJ9zawgzbQiyo7o3b8Opx+B30y/kkhRleBH4nYWr
 9R44JRYOlihpiossn5Mksb4FrHxmmiODK5Bwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739589815; x=1740194615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nlP6bUxcy2ZERKgB0l2T8o+gOQZt1svTpktojBx+cFY=;
 b=mP0w1/oPytJ07EaDZJWWqFmKYP+LCtwfu1nttyLu54Wp4eyqr73Y9GBZ1jqIs5LCBn
 r9qE3meO1AL0IUp/wa1ukRhVAwjye9mOZY3149SqBxR4Z9lQ9TPz9PqiY8dVi+7PkWNU
 nlzo5lH7wW9qwIN8/tSvNcFwLJekNHCmyz/mWl/jKHAy+CdGHzuMYjZqG8RXoZfTlik4
 sn3CNIUny9kAYAJOewxa3zhMVQljcL7RJ8dZi6EZHTw/8Ls4L6PpqPKUC69ty6EVc+Ko
 lJIhA6jV20FK5v/7iQkeT0ty+PY/xEBGtE47NM5M5SjSreXw3w9A6pnP74EIGUEe45de
 QRdQ==
X-Gm-Message-State: AOJu0Yw9bPfY/a5SQZFaa22Q/FTN6s8D7qnpmyFS74y+7okqdV6Whn8g
 EzfPkKN7NZiLVC8Aes+/wFtlXwcqn/wstdpw1HNKgpr5CW2+tj/IdqfNisNMYMKi/R7qYfcF2dg
 =
X-Gm-Gg: ASbGncuw+LHKcz4aiqBf8sgiYdxNFbdzZIU2+0chS3WNkUTpfGTDmtlB+jX252/NS90
 8DHw7RFkXf/amxhqLPKVNvQIt7PGoOgi3HSj0gSZHU9f7HtxsleAZPjf8+9nILpj4ULTWibYFuT
 pMsUQr1Umjvg9V0Pnf3kt+QFr0lgy1TFCNC9pdw6J5h44YJKyYS4z2X/uvxrsF81cJ//xzFaX9l
 XcWTV00iONrOWH0V1qcQ8ZUwef7S0YWqBrfNrn8LkJyLci1+PxfSLo78eBqXYLWtern+Lygwiu5
 myZrpoNQxLQmACpgEamcjIjBPu467mwJz5aI9IZPLkx9RsL3Hr9D
X-Google-Smtp-Source: AGHT+IGLGkGDgwyMhi5ZguOUOwbH3QEqsrAhTI7gXOHpUPvVrvv+OVU6grnQHvuO3ZYJKu4Joz1CRQ==
X-Received: by 2002:a05:6602:13d4:b0:855:563a:da78 with SMTP id
 ca18e2360f4ac-8557a156617mr182389439f.12.1739589815053; 
 Fri, 14 Feb 2025 19:23:35 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed2819d0f5sm1087697173.67.2025.02.14.19.23.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 19:23:33 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 10/29] efi: x86: Allow setting the global_data pointer with
 EFI
Date: Fri, 14 Feb 2025 20:22:31 -0700
Message-ID: <20250215032254.4121030-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215032254.4121030-1-sjg@chromium.org>
References: <20250215032254.4121030-1-sjg@chromium.org>
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

