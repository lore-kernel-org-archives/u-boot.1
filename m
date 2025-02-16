Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30070C021A6
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 02:04:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 660C280F57;
	Sun, 16 Feb 2025 03:04:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oEIzRp4+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11DFB80F5C; Sun, 16 Feb 2025 03:04:23 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73E4B80C7E
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 03:04:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-8557692f4c9so112953339f.3
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 18:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739671455; x=1740276255; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ohY4GCuGdlEJpYyK+bH+AjnRmYTczmMlcupzi9SQY8=;
 b=oEIzRp4+Yuy/7j7NBczvfxmtnVjabnKug4iIqd/F+tp/7LtJ6NNOzB0PDd5Eg/3UYt
 rr986GN7uGa7cxNwFR/yQdKRlvKoLVirnT4aPoS9vaJjvFGNiXplY+1W1Cp6JhbOOkWE
 koCNO8P2I04Ogk+a/j9sLljV9Ay6M7femOXj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739671455; x=1740276255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ohY4GCuGdlEJpYyK+bH+AjnRmYTczmMlcupzi9SQY8=;
 b=pW1jid3L+f4JTvBMlX++xHmw8/kxr+Ut214OQTrTnVXobwxvNbv6qllsmW/R3b7kaO
 UTDiHOk4+r/4SY9bToSSyeSyXt73VUn1NdfwKaOZkE8CqDfaoTVyB+Tw8R6NiWOLzvbj
 EDTnT+JCnrhMKrnzYF03PLl2sIhziS5s+ikZKM+BJeLpTIFX+wOQkOyzOkbwdy7HQ0iC
 sbGUxIcrr5BEM95rR7PTa+GZRTMbSS+2+E/4acVWnSEzmIozVGwVZ7j86iQPXDJgT3oM
 VRidUO0NRKpkhLFYHN7zltP29hwT6LnEWFuVPuKtcR+4K2VeNE4mbLEHpEaWzY9GZdI+
 vL3Q==
X-Gm-Message-State: AOJu0YyqL36b25VCh+rA18yyGfANEjAX7Va5bEbV6z1AsllcmWE9U8j7
 I0KPmtE6ZeLffRgg6Dnh3bHJJZ0geg1bhisD9+aHwoAN+CDPuO9/gA6vXrXDu+Ps6o7h+tSw7P4
 =
X-Gm-Gg: ASbGncvqBf/swh4Llsn/VN/RBtedeQpFHZ/OTHpR/hYk/35O9hqaXVc0ZRI47zZgmDl
 3oiKQwAVDlk9vTdjhFs4ciACaL9pVKlsw4dx04xNoGrXa1HxF68HUb4LT7Lmnqb3/EMgZpca9AI
 HaIj4rqBbHwJsDSY8ZhWTQId3HBYtKagHOjUp7QQwikQs0kFwdUro8RvyDS9uaqpUNOx7bZ6bf+
 jEpXXLtIE0G9pZYsD5Sg8od5O01ElpSh6hlTPORWRcm+Whe1mRorCGqHiwD1HwqvhqvruHDOTw2
 V12i1lsdpH2+GktkTDIZlRq/H4rv03bz2NwMlVmNImUHLk1PO95b
X-Google-Smtp-Source: AGHT+IEMltSBcY7OVxPdO0tzK/9rcbhhTDxkevMdQCoZHXUUudfZRrnZIorqItbG2WfuxdmIVcDYjQ==
X-Received: by 2002:a05:6602:1686:b0:843:f220:fa3d with SMTP id
 ca18e2360f4ac-8557a10d705mr402000539f.7.1739671455574; 
 Sat, 15 Feb 2025 18:04:15 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85566e63bb7sm133525339f.25.2025.02.15.18.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 18:04:14 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] binman: x86: Write skip-at-start when end-at-4gb is used
Date: Sat, 15 Feb 2025 19:02:37 -0700
Message-ID: <20250216020359.3878546-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216020359.3878546-1-sjg@chromium.org>
References: <20250216020359.3878546-1-sjg@chromium.org>
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

The end-at-4gb property implies a value for skip-at-start so add it into
the output FDT so that U-Boot can read it.

Now that skip-at-start is implemented, we can drop the workarounds used
in the x86 code to obtain the correct image-pos value.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/cpu/intel_common/intel_opregion.c | 1 -
 arch/x86/lib/fsp2/fsp_init.c               | 3 +--
 tools/binman/etype/section.py              | 6 +++++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/cpu/intel_common/intel_opregion.c b/arch/x86/cpu/intel_common/intel_opregion.c
index 4a2717b3584..78caff0dc12 100644
--- a/arch/x86/cpu/intel_common/intel_opregion.c
+++ b/arch/x86/cpu/intel_common/intel_opregion.c
@@ -31,7 +31,6 @@ static int locate_vbt(char **vbtp, int *sizep)
 	size = vbt.size;
 	if (size > sizeof(vbt_data))
 		return log_msg_ret("vbt", -E2BIG);
-	vbt.image_pos += CONFIG_ROM_SIZE;
 	ret = spi_flash_read_dm(dev, vbt.image_pos, size, vbt_data);
 	if (ret)
 		return log_msg_ret("read", ret);
diff --git a/arch/x86/lib/fsp2/fsp_init.c b/arch/x86/lib/fsp2/fsp_init.c
index e4a87d8b2e1..4b5f9889655 100644
--- a/arch/x86/lib/fsp2/fsp_init.c
+++ b/arch/x86/lib/fsp2/fsp_init.c
@@ -107,7 +107,6 @@ int fsp_locate_fsp(enum fsp_type_t type, struct binman_entry *entry,
 		   bool use_spi_flash, struct udevice **devp,
 		   struct fsp_header **hdrp, ulong *rom_offsetp)
 {
-	ulong mask = CONFIG_ROM_SIZE - 1;
 	struct udevice *dev;
 	ulong rom_offset = 0;
 	uint map_size;
@@ -141,7 +140,7 @@ int fsp_locate_fsp(enum fsp_type_t type, struct binman_entry *entry,
 		if (ret)
 			return log_msg_ret("binman entry", ret);
 		if (!use_spi_flash)
-			rom_offset = map_base + CONFIG_ROM_SIZE;
+			rom_offset = map_base;
 	} else {
 		ret = -ENOENT;
 		if (false)
diff --git a/tools/binman/etype/section.py b/tools/binman/etype/section.py
index 5e11cf58d28..5c371397ffb 100644
--- a/tools/binman/etype/section.py
+++ b/tools/binman/etype/section.py
@@ -189,7 +189,7 @@ class Entry_section(Entry):
         self._sort = fdt_util.GetBool(self._node, 'sort-by-offset')
         self._end_at_4gb = fdt_util.GetBool(self._node, 'end-at-4gb')
         self._skip_at_start = fdt_util.GetInt(self._node, 'skip-at-start')
-        if self._end_at_4gb:
+        if self._end_at_4gb and self.GetImage().copy_to_orig:
             if not self.size:
                 self.Raise("Section size must be provided when using end-at-4gb")
             if self._skip_at_start is not None:
@@ -263,6 +263,8 @@ class Entry_section(Entry):
         super().AddMissingProperties(have_image_pos)
         if self.compress != 'none':
             have_image_pos = False
+        if self._end_at_4gb:
+            state.AddZeroProp(self._node, 'skip-at-start')
         for entry in self._entries.values():
             entry.AddMissingProperties(have_image_pos)
 
@@ -505,6 +507,8 @@ class Entry_section(Entry):
 
     def SetCalculatedProperties(self):
         super().SetCalculatedProperties()
+        if self._end_at_4gb:
+            state.SetInt(self._node, 'skip-at-start', self._skip_at_start)
         for entry in self._entries.values():
             entry.SetCalculatedProperties()
 
-- 
2.43.0

