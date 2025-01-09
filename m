Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DFF0E77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 12:32:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7221380613;
	Thu,  9 Jan 2025 13:31:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mAIYbaV0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B93D80619; Thu,  9 Jan 2025 13:30:59 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FBE2806C6
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 13:30:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3ab37d98dd4so2139525ab.3
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 04:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736425855; x=1737030655; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YRqE5v/qu+JYbL/PaI25WpmQJXwRbHeICojZgUI8pPc=;
 b=mAIYbaV0QGmgZYi87s9hiCJ8Zi0J+bfHWDygfcfsM4TmdHOz9bKZ1y9dCJjlYZTPfw
 MTrdfYaf1SWtZhcvepEHcvoJERi+VHa74TJP9oEBTCixZH2yTQWMKYZbNK48dVRhPYy1
 2uPK8QpCaQZqsiX41Y8pNCnZlVN7V1KdB6wUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736425855; x=1737030655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YRqE5v/qu+JYbL/PaI25WpmQJXwRbHeICojZgUI8pPc=;
 b=YRgyCfKePe2k+rqIvYwziUzpOOrv8VgUWHaAP1KsRfY9E1IptIAIUMybDugFWUuszR
 7rdDsnIGVmWlTs6BebqrtVoimmY1D9yA6Lf0JxL1sSEGFkOFWEWQbeat/Q7ARw69ezgz
 s5xQ7Aoq0L8Cg9TnNNKH2S7l8SjUJBxjZF2U7O3c5+xJQ/HXdOazb9V6zRtGNNufZ25W
 hpisbjOqiXN09FsQ8PEMKD90kbyWLmnEV/hYcsJFkHHegMj0tmft9F6XDZ2L15pf4S1i
 xudEISuTplnmuQ4iUvb41uURWQ5JaZBO5xUpcD/2ar6aO5/DyZwYIZGjZTwBrqmZeSxi
 zXEQ==
X-Gm-Message-State: AOJu0YxJ47eUNfA/d93h4Qp8KePAdRAUIrCac92EsBZ0z7dP7CkUycBA
 mM545bQGDQCtFUmb+m76beDxDNO5XVupqstEJ8cHip2XcjV/1oUWKOKg6fzRYKjHGOXAhKzNz+Y
 =
X-Gm-Gg: ASbGncseuSWxkYnlZqMPbqBON6tfndiMtYi3PB3G5JMc37XWEcoHoOQFxiw5S7pvHzu
 mNMkmIq72LzjBGUiszpTs0QJc1rCeTYUouZLB4s6djxDeOJQF9sbNuYdDUz0LaFWbAiUSvgIw1v
 pz3vdlgnqEob+59rS+RIGkfip2t/JWdocLyeQdPETXSkbk3MPun58lD/9VpAjQz64mfdLoKmEei
 asaQxtFz7luNLbN2UXkVb9dVdJimhzbdQdxcVQ9zx7FzC4ojt4jSu0GvhowAm43ccCHAl1BfdGT
 4Sb94rL3h3ptp+LUWg==
X-Google-Smtp-Source: AGHT+IEVB7nTsSW2F/908DqY98+pOk9VzscHuOdrg0QKPkIrgmFnnmcJC/WPpCsYiV+dkH90aMV/nw==
X-Received: by 2002:a05:6e02:18cc:b0:3a7:1c73:e18e with SMTP id
 e9e14a558f8ab-3ce3a8e0a69mr52588865ab.21.1736425853470; 
 Thu, 09 Jan 2025 04:30:53 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm281678173.20.2025.01.09.04.30.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 04:30:52 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 09/15] spl: Add fields for VBE
Date: Thu,  9 Jan 2025 05:30:04 -0700
Message-Id: <20250109123010.4005298-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250109123010.4005298-1-sjg@chromium.org>
References: <20250109123010.4005298-1-sjg@chromium.org>
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

Add some fields to track the VBE state in SPL.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/spl.h | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/include/spl.h b/include/spl.h
index 43b344dbc55..781e5a2d638 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -14,6 +14,7 @@
 #include <asm/global_data.h>
 #include <asm/spl.h>
 #include <handoff.h>
+#include <image.h>
 #include <mmc.h>
 
 struct blk_desc;
@@ -265,6 +266,11 @@ enum spl_sandbox_flags {
 	SPL_SANDBOXF_ARG_IS_BUF,
 };
 
+/**
+ * struct spl_image_info - Information about the SPL image being loaded
+ *
+ * @fdt_size: Size of the FDT for the image (0 if none)
+ */
 struct spl_image_info {
 	const char *name;
 	u8 os;
@@ -276,6 +282,7 @@ struct spl_image_info {
 	u32 boot_device;
 	u32 offset;
 	u32 size;
+	ulong fdt_size;
 	u32 flags;
 	void *arg;
 #ifdef CONFIG_SPL_LEGACY_IMAGE_CRC_CHECK
@@ -316,12 +323,18 @@ typedef ulong (*spl_load_reader)(struct spl_load_info *load, ulong sector,
  * @read: Function to call to read from the device
  * @priv: Private data for the device
  * @bl_len: Block length for reading in bytes
+ * @phase: Image phase to load
+ * @fit_loaded: true if the FIT has been loaded, except for external data
  */
 struct spl_load_info {
 	spl_load_reader read;
 	void *priv;
 #if IS_ENABLED(CONFIG_SPL_LOAD_BLOCK)
-	int bl_len;
+	u16 bl_len;
+#endif
+#if CONFIG_IS_ENABLED(BOOTMETH_VBE)
+	u8 phase;
+	u8 fit_loaded;
 #endif
 };
 
@@ -344,6 +357,32 @@ static inline void spl_set_bl_len(struct spl_load_info *info, int bl_len)
 #endif
 }
 
+static inline void xpl_set_phase(struct spl_load_info *info,
+				 enum image_phase_t phase)
+{
+#if CONFIG_IS_ENABLED(BOOTMETH_VBE)
+	info->phase = phase;
+#endif
+}
+
+static inline enum image_phase_t xpl_get_phase(struct spl_load_info *info)
+{
+#if CONFIG_IS_ENABLED(BOOTMETH_VBE)
+	return info->phase;
+#else
+	return IH_PHASE_NONE;
+#endif
+}
+
+static inline bool xpl_get_fit_loaded(struct spl_load_info *info)
+{
+#if CONFIG_IS_ENABLED(BOOTMETH_VBE)
+	return info->fit_loaded;
+#else
+	return false;
+#endif
+}
+
 /**
  * spl_load_init() - Set up a new spl_load_info structure
  */
-- 
2.34.1

