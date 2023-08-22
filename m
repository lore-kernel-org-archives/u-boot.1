Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6404EE49A4
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 03:17:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE1E5871C8;
	Tue, 22 Aug 2023 05:17:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CBLCYnlJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4CAF871FC; Tue, 22 Aug 2023 05:17:16 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC3C9871DB
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 05:17:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-790f831c6fbso136810539f.2
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 20:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692674232; x=1693279032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RRo3Dz24GXmTpYkB89tDQVw3K9KJj/ZlctobBTm2wII=;
 b=CBLCYnlJ2Y6C4yrE6PX8RbJobF0haWlPSL2+EZlfgWRg8rH5PHnEcDZAAROLQcGfMY
 KVsjOEWREv7l9IffCJa6QKlyIatOlaEFUrpuehQ6l8NPTm1tqK8haie7zwDmBettoR3l
 YYcPyKKtJAtqMuNgFw2DRcX/54giLVmZKPNx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692674232; x=1693279032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RRo3Dz24GXmTpYkB89tDQVw3K9KJj/ZlctobBTm2wII=;
 b=SFkUVNRdmoD0uRQIzJxIf0vKzFF1UnfifopHmePHHVLqYpGMPg9yquYZRpimuoQjRc
 ZKRhtIqRRia3njIpX9xsGqn3keYKUzApVor/WddWTHWvSeTHEAYflwirxqPd1Rnwltqi
 xA4WFb5VSAQ/hVe949utWVkDr7wt/5uZYEseqOyyp+KAUddpLlrgKUcpY9YRIGoCZ+Tp
 JtsxFh9gAL7oIx2/Ctfv0FZS5hnyWu5C7+QORF4G8PGEeP/uv21aivC7uRi/eC1lc6lz
 YF8i/iiW27pga79ebFiccUgl43man8XEr627Vfm2Z77Us8IBvVNe6K3/57zqGRxQo59d
 gNWw==
X-Gm-Message-State: AOJu0YyQqWbg7eD44/xd85Z2ueIQAz5hJnH6mpck+iiybmjr4TYZWuUa
 OWV7W4t6ZYEvF6fK7/nFuDmI0kE6anJKia87LNU=
X-Google-Smtp-Source: AGHT+IGahi2Jqzw5lwiSAof+xPTNRSfwNjc/CrxgdSSUjROBNwRHKiHCkiAkkHGXgtmX+kRq5dQOEQ==
X-Received: by 2002:a5d:9399:0:b0:786:463b:2ceb with SMTP id
 c25-20020a5d9399000000b00786463b2cebmr11031829iol.11.1692674232342; 
 Mon, 21 Aug 2023 20:17:12 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 gv14-20020a0566382e4e00b0042b37dda71asm2722735jab.136.2023.08.21.20.17.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 20:17:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Alexander Graf <agraf@csgraf.de>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 03/14] initcall: Factor out reloc_off calculation
Date: Mon, 21 Aug 2023 21:16:50 -0600
Message-ID: <20230822031705.1340941-4-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230822031705.1340941-1-sjg@chromium.org>
References: <20230822031705.1340941-1-sjg@chromium.org>
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

Move this into a function and do it once, not each time around the loop.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/initcall.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/lib/initcall.c b/lib/initcall.c
index eedb0fbf1d5c..89a68b2444fe 100644
--- a/lib/initcall.c
+++ b/lib/initcall.c
@@ -11,6 +11,20 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+static ulong calc_reloc_ofs(void)
+{
+#ifdef CONFIG_EFI_APP
+	return (ulong)image_base;
+#endif
+	/*
+	 * Sandbox is relocated by the OS, so symbols always appear at
+	 * the relocated address.
+	 */
+	if (IS_ENABLED(CONFIG_SANDBOX) || (gd->flags & GD_FLG_RELOC))
+		return gd->reloc_off;
+
+	return 0;
+}
 /*
  * To enable debugging. add #define DEBUG at the top of the including file.
  *
@@ -18,21 +32,12 @@ DECLARE_GLOBAL_DATA_PTR;
  */
 int initcall_run_list(const init_fnc_t init_sequence[])
 {
+	ulong reloc_ofs = calc_reloc_ofs();
 	const init_fnc_t *init_fnc_ptr;
 
 	for (init_fnc_ptr = init_sequence; *init_fnc_ptr; ++init_fnc_ptr) {
-		unsigned long reloc_ofs = 0;
 		int ret;
 
-		/*
-		 * Sandbox is relocated by the OS, so symbols always appear at
-		 * the relocated address.
-		 */
-		if (IS_ENABLED(CONFIG_SANDBOX) || (gd->flags & GD_FLG_RELOC))
-			reloc_ofs = gd->reloc_off;
-#ifdef CONFIG_EFI_APP
-		reloc_ofs = (unsigned long)image_base;
-#endif
 		if (reloc_ofs)
 			debug("initcall: %p (relocated to %p)\n",
 			      (char *)*init_fnc_ptr - reloc_ofs,
-- 
2.42.0.rc1.204.g551eb34607-goog

