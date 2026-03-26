Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C96510A1E82
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 11:51:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEFB283A1B;
	Thu, 26 Mar 2026 12:51:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IDEUwYc6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E17E83FAF; Thu, 26 Mar 2026 12:51:36 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B52C83CD3
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 12:51:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-486fb112c09so8834515e9.1
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 04:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774525892; x=1775130692; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RpDsnJinn+rLKUwzyIAAVlQMlkkamKYjWnCMEpjdruw=;
 b=IDEUwYc6j44xPmn9DhJW6HQxX2GzavKixqkzQJ3g1OtnbHOIJITQwKBYCKYIAp6qpf
 FD/uAO0anwpAHW6g/IM/qlRvuq5Ph6SjJz5aqU9W25O7GdpeTBzIAjihp5xGW/QXUlM9
 IYaMi61S4MRQgkU9vMgokEfsQHv32Po/abaOk7AAjj3UxL9ZxQaS2e12aVBIcnD9QWvv
 mf+I/CMWPXYLiChSMKdkFuEWvFuDkGIOzU4o7Bmgm8aT5Dl3muMGLQJxBwhpaua7ckyf
 FZDUkEu5b2nKw76WdAL+oYYTqJX/apDLgdXMFaJnnkS8FtS2SMQk38F1gg0EErcxyeUA
 vYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774525892; x=1775130692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RpDsnJinn+rLKUwzyIAAVlQMlkkamKYjWnCMEpjdruw=;
 b=Xj7TdpeGUxr4D4a8RLb2ZI5RTUceU+hwoAQvdHhdlQjdTgC526tkXPRKV5EGlX2973
 8j4xzyJ/BDdTDF5L9WSFzDwX70NjWCwEw5Z47zwKSLn5atiHevoEBmMsXqwKQ6DX1J2U
 MGjWM++Gs1CoA0o988SUzfbnPez6kj4XXA/BvnlS1ucMUhPlqnivArEVn1euxhaCWUvc
 xmiOBzqMRt7EptqCB773oSCmjkQP2rpHgv9wBxcNvGxoq9yPbeeK8UxY1o/EWmhU1xVn
 d2w0PqO5FXvcbKXYu5mL46dqlNi6HexcebY6H8P2Tg8UBLME3cjT9pmAzQc55a70d5cv
 /t+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWw0wXdlebeuEeRnims+1QUiMLx0GLJkhXb9oqv4C+w1Xp1sflA0UlMAa5Ktboe60dU6skOJDE=@lists.denx.de
X-Gm-Message-State: AOJu0YwbSidt4tVZKucR3afzc/fjna642Xgpbxxcp1ZhqJn+2RyA76ms
 CPFtMW5RLEypKe3F/m3SiHSdubskWEma9i5FxHU1Z4dGU0FFu7Ok7geBOzluuuy3g8RqWjXyzML
 x8MKF
X-Gm-Gg: ATEYQzz7oW5im41KVPFClOdzicpq1KY9cs+USlWbNMRfG7gTUmIEH4+ET5yw1kYia5V
 0M7RNM9p2eTFEaqoo4jK5vbSpIX/Dcc9NeTydJQIudT4bfit0/9cqO7RyQRrzUUTcry4Ri9CRxj
 xB4TMwEq7NUwuKbQiVhFCWQM3ugoLX6qa76gBu/0DYOcNf2QWxG+b/zdDZM7eBYpvO+CycsBeeu
 W0S2/lMpgVUiNbUeSYgvEnDmdh1CQQq/BUNAcP0f5JNAb5vdp4UCxg8cjI/w8VUyW9vqlYYS9jO
 78npU7O8N2bvOP28+wVOlT6MGn9gQQpXUbknJVMjW+TP74Te4aTPYDl59P1Lc8jeAuIFmj1Jjc2
 ZU07D0Lv4R/dK0cDpMGTtpxt5J6Rmvx+Zvkg4pwHP9B4bVWcXYjeWSfhc7bhhv6Mc0vkPBJ6mqR
 609wNKYKngVHG2baBV5kHQJHRX4NrYCTog/6+4HdtTXGRAvStVKN0N5X0WzHp+qBvExJ5uJGor3
 1pl9Yo1wWWSOYj8coBfWdKoAa/leFBNvkeXDJTpLOgg84bAc1x+ACiciGOLuBStGiBwoTJNz5Df
 4nuWt5x0AmCfOpssvsa0FpTh7NRoqKt21oDf2xVW/5LtZQyy3IgVKrSOFiOgYv+rheuJlSSsjbb
 3AjRvHM2tBwmOdA5QGN/eAgo1pn/gtNDsX3gOumPd8Bf/FrLmLQ7G19R8QI7MsfHroK/W1dgzhk
 GUUDWP1pI/wyIL9VtUTRAS2pavf3conL5m8sJ9UimrDHZgIUpBJogXsMn3iWGa
X-Received: by 2002:a05:600c:1394:b0:486:fe46:b647 with SMTP id
 5b1f17b1804b1-48715fd6193mr108646385e9.10.1774525891894; 
 Thu, 26 Mar 2026 04:51:31 -0700 (PDT)
Received: from hera ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4871fb3d09dsm25968005e9.0.2026.03.26.04.51.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 04:51:31 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: marek.vasut+renesas@mailbox.org,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	u-boot@lists.denx.de
Subject: [PATCH v1 2/3] fdtdec: Introduce fdtdec_setup_mem_ram_top() to
 determine end of topmost DRAM bank
Date: Thu, 26 Mar 2026 13:51:08 +0200
Message-ID: <20260326115111.1631261-3-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260326115111.1631261-1-ilias.apalodimas@linaro.org>
References: <20260326115111.1631261-1-ilias.apalodimas@linaro.org>
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

From: Marek Vasut <marek.vasut+renesas@mailbox.org>

Introduce function fdtdec_setup_mem_ram_top(), which determines the topmost
address in the last DRAM bank, to be assigned into gd->ram_top in order to
relocate U-Boot to the actual end of all DRAM. This makes use of iterator
function fdtdec_setup_mem_for_each_bank() introduced in previous commit.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Changhes since RFC:
- Account for the ram_size as well

 include/fdtdec.h | 16 ++++++++++++++++
 lib/fdtdec.c     | 20 ++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/fdtdec.h b/include/fdtdec.h
index d9fcd037ed26..26e40c3cdb46 100644
--- a/include/fdtdec.h
+++ b/include/fdtdec.h
@@ -933,6 +933,22 @@ int fdtdec_setup_mem_size_base(void);
  */
 int fdtdec_setup_mem_size_base_lowest(void);
 
+/**
+ * fdtdec_setup_mem_ram_top() - decode and setup gd->ram_top to highest address
+ * available in any memory bank
+ *
+ * Decode the /memory 'reg' property to determine the highest end of the memory
+ * bank and populate the global data ram_top with it.
+ *
+ * This function should be called from a boards board_get_usable_ram_top().
+ * This helper function allows for boards to query the device tree for topmost
+ * DRAM address.
+ *
+ * Return: 0 if OK, -EINVAL if the /memory node or reg property is missing or
+ * invalid
+ */
+int fdtdec_setup_mem_ram_top(void);
+
 /**
  * fdtdec_setup_memory_banksize() - decode and populate gd->bd->bi_dram
  *
diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index d820f75b031d..c5ee2ecb3a49 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1162,6 +1162,26 @@ int fdtdec_setup_mem_size_base_lowest(void)
 	return fdtdec_setup_mem_for_each_bank(fdtdec_setup_mem_size_base_lowest_bankfn);
 }
 
+static void fdtdec_setup_mem_ram_top_bankfn(struct resource *res, int bank)
+{
+	if ((res->end + 1) > gd->ram_top) {
+		gd->ram_top = res->end + 1;
+		gd->ram_size += res->end - res->start;
+	}
+}
+
+int fdtdec_setup_mem_ram_top(void)
+{
+	phys_addr_t old_top = gd->ram_top;
+	int ret;
+
+	ret = fdtdec_setup_mem_for_each_bank(fdtdec_setup_mem_ram_top_bankfn);
+	if (ret)
+		gd->ram_top = old_top;
+
+	return ret;
+}
+
 static int uncompress_blob(const void *src, ulong sz_src, void **dstp)
 {
 #if CONFIG_IS_ENABLED(MULTI_DTB_FIT_GZIP) ||\
-- 
2.51.0

