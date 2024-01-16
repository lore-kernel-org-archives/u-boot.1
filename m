Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1DA1C47077
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 17:15:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B562587A08;
	Tue, 16 Jan 2024 18:14:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="N2N8GHp+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 038A786F67; Tue, 16 Jan 2024 18:14:49 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9A2C87A18
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 18:14:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6dc8b280155so3876863a34.0
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 09:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705425285; x=1706030085; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y+SbtxPaLs0sI6B8Aif8NsZLo5lvyC+gWqu8P/RNRM8=;
 b=N2N8GHp+IyUw4BVPJq3AVjz+fNyh5ehy+0o85CNoB4Fc7ZwdlAATIOnZ3GrSMwwxXk
 fAYp9qhyyBjzDE514rhWKv1dK2BdosfDkd5LNwX/BHY9KYWFkdOc8UH/w77mPZ409yGl
 646+JjCxeAlTeD3l+hA3ddpzjiPK/bIOdi8u2Go1q3Xv1pbiyuYFZjfyXwHcfvU+UpqT
 e1izR+5lLZHuqyAiix8VN86JLBVYWN+WpttSrhCtM371KVkwnrWAJbyv606F75ISc+S8
 RSCjcMwPoViw/fn/P4Twc2tGHZZEkXvQYGhNj5DEb2J+m7wyvDzPAmHN+29lQH5br9/m
 VJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705425285; x=1706030085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y+SbtxPaLs0sI6B8Aif8NsZLo5lvyC+gWqu8P/RNRM8=;
 b=e5KZXXRwGJH8cWEkkJuxgLwl1gf+ZdUjVXTCBl/oodINhmFB6S624/GfKBdsgX6TyI
 xA6WGJCVGLvR5DJxsMGGHdCmURzWbJa8GI1nuwDlA74rN06iTkFHTdWrFHUy/2lq4tp9
 c5d5QPT2wdBSErj3PI1Fum1PbHjv9MMhA+snwSM3J+OAhWJ9IAzJFDsGEQf9NbqXIbqZ
 Cr+P5UXlooUg/psMHrkV6R0St+uUMjpS4ZULOQQGpHTuiiMJtvxK4wguVGhC4nvZOGVj
 HvFjbCk2MG4mqXqM8QlvWeivgX4d8P2EIk58/RQbectf22dOnlInkKDJ0cWW4+ydXd8d
 eOvA==
X-Gm-Message-State: AOJu0YyTzrLOrTT1+u0qYGqPAQFhc06RZgF2VtFlaUwH1awpENsmqXdk
 u3jX3MwZRMHKExjV7LmY5Jjuc0G0wzBiQ+FWymKCq9vNhPk=
X-Google-Smtp-Source: AGHT+IEIJTIqDe66l7vol6MlXSRq6zxEtI6ktZnnnsHORjIfRFuG6eybnytSSTNZxrhYPf7S+jYqIg==
X-Received: by 2002:a05:6830:1bfc:b0:6dc:23a:6dd0 with SMTP id
 k28-20020a0568301bfc00b006dc023a6dd0mr4496521otb.17.1705425285066; 
 Tue, 16 Jan 2024 09:14:45 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 bp43-20020a05622a1bab00b00427e0e9c22dsm4988291qtb.54.2024.01.16.09.14.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 09:14:44 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Fabio Estevam <festevam@denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Yang Xiwen <forbidden405@outlook.com>,
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>,
 Peng Fan <peng.fan@nxp.com>, Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <seanga2@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v6 7/7] bloblist: Load the bloblist from the previous loader
Date: Tue, 16 Jan 2024 09:13:52 -0800
Message-Id: <20240116171356.376801-8-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240116171356.376801-1-raymond.mao@linaro.org>
References: <20240116171356.376801-1-raymond.mao@linaro.org>
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

During bloblist initialization, load the bloblist via boot arguments
from the previous loader.
If a valid bloblist exists in boot arguments, relocate it into the
fixed bloblist memory region.
If not, fallback to support BLOBLIST_ADDR or BLOBLIST_ALLOC.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v4
- Add weak default function.
- Add comments for BLOBLIST_ALLOC.
- Add local debug macro.
- Refine the commit message.
Changes in V5
- Drop the dependence on OF_BOARD.
- Remove local debug macro.

 common/bloblist.c  | 62 ++++++++++++++++++++++++++++++++--------------
 include/bloblist.h | 10 ++++++++
 2 files changed, 54 insertions(+), 18 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index c2fd07575f..ad06d7a179 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -487,37 +487,57 @@ int bloblist_reloc(void *to, uint to_size)
 	return 0;
 }
 
+/*
+ * Weak default function for getting bloblist from boot args.
+ */
+int __weak xferlist_from_boot_arg(ulong __always_unused addr,
+				  ulong __always_unused size)
+{
+	return -ENOENT;
+}
+
 int bloblist_init(void)
 {
 	bool fixed = IS_ENABLED(CONFIG_BLOBLIST_FIXED);
 	int ret = -ENOENT;
 	ulong addr, size;
-	bool expected;
-
-	/**
-	 * We don't expect to find an existing bloblist in the first phase of
-	 * U-Boot that runs. Also we have no way to receive the address of an
-	 * allocated bloblist from a previous stage, so it must be at a fixed
+	/*
+	 * If U-Boot is not in the first phase, an existing bloblist must be
+	 * at a fixed address.
+	 */
+	bool from_addr = fixed && !u_boot_first_phase();
+	/*
+	 * If U-Boot is in the first phase that an arch custom routine should
+	 * install the bloblist passed from previous loader to this fixed
 	 * address.
 	 */
-	expected = fixed && !u_boot_first_phase();
+	bool from_boot_arg = fixed && u_boot_first_phase();
+
 	if (spl_prev_phase() == PHASE_TPL && !IS_ENABLED(CONFIG_TPL_BLOBLIST))
-		expected = false;
+		from_addr = false;
 	if (fixed)
 		addr = IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
 				      CONFIG_BLOBLIST_ADDR);
 	size = CONFIG_BLOBLIST_SIZE;
-	if (expected) {
+
+	if (from_boot_arg)
+		ret = xferlist_from_boot_arg(addr, size);
+	else if (from_addr)
 		ret = bloblist_check(addr, size);
-		if (ret) {
-			log_warning("Expected bloblist at %lx not found (err=%d)\n",
-				    addr, ret);
-		} else {
-			/* Get the real size, if it is not what we expected */
-			size = gd->bloblist->total_size;
-		}
-	}
+
+	if (ret)
+		log_warning("Bloblist at %lx not found (err=%d)\n",
+			    addr, ret);
+	else
+		/* Get the real size */
+		size = gd->bloblist->total_size;
+
 	if (ret) {
+		/*
+		 * If we don't have a bloblist from a fixed address, or the one
+		 * in the fixed address is not valid. we must allocate the
+		 * memory for it now.
+		 */
 		if (CONFIG_IS_ENABLED(BLOBLIST_ALLOC)) {
 			void *ptr = memalign(BLOBLIST_ALIGN, size);
 
@@ -525,7 +545,8 @@ int bloblist_init(void)
 				return log_msg_ret("alloc", -ENOMEM);
 			addr = map_to_sysmem(ptr);
 		} else if (!fixed) {
-			return log_msg_ret("!fixed", ret);
+			return log_msg_ret("BLOBLIST_FIXED is not enabled",
+					   ret);
 		}
 		log_debug("Creating new bloblist size %lx at %lx\n", size,
 			  addr);
@@ -538,6 +559,11 @@ int bloblist_init(void)
 		return log_msg_ret("ini", ret);
 	gd->flags |= GD_FLG_BLOBLIST_READY;
 
+#ifdef DEBUG
+	bloblist_show_stats();
+	bloblist_show_list();
+#endif
+
 	return 0;
 }
 
diff --git a/include/bloblist.h b/include/bloblist.h
index 0ae079d62a..7fbdd622bc 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -482,4 +482,14 @@ static inline int bloblist_maybe_init(void)
  */
 int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig);
 
+/**
+ * xferlist_from_boot_arg() - Get bloblist from the boot args and relocate it
+ *			      to the specified address.
+ *
+ * @addr: Address for the bloblist
+ * @size: Size of space reserved for the bloblist
+ * Return: 0 if OK, else on error
+ */
+int xferlist_from_boot_arg(ulong addr, ulong size);
+
 #endif /* __BLOBLIST_H */
-- 
2.25.1

