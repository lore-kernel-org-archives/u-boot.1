Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0A4C3ABC9
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 13:44:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBFEE82AA8;
	Sat, 10 May 2025 15:43:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oZ4qESUW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8844C82BA2; Sat, 10 May 2025 15:43:54 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B09882AB2
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 15:43:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ad1a87d93f7so500045466b.0
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 06:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746884631; x=1747489431; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9RS5XQn/RyCf37J6HIuCxoN9XpKDPzZvDAYlKSDHaHY=;
 b=oZ4qESUWKN3HBAPkDAsI9S5VbaZpC/aAmJXRLpz7c4ZZdpwSWoy/JaShMmU4PBIxn9
 7T0iTbYQHmEH9egobit/pRqk0IVgTxbWIUt61VtYowKBsh5Z0izn50jDDWnHyJM4rFOE
 ULIRnqI2YIinOU7f36NApzEXdZ5bRCHJLnhT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746884631; x=1747489431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9RS5XQn/RyCf37J6HIuCxoN9XpKDPzZvDAYlKSDHaHY=;
 b=SrdIk9M/HRsD/m5vBkKYRZVP/FoNpgGoQopt7i3rW98+tYu1KiZgcXhDyWxE/cmzHX
 Gh7lDHP6aDrpZcAsrdg/LIb8YRPWRudQ2HwAMmvNcmUmIlU7jivzUkJ4vZGB1qQeHoze
 /WX05p/iuGhk1+E7iQgcDEk7VROlFJ22pvPPemuyzkC2qW97e+SE40/R6fmMmj3YePoE
 KSiv6WJ5GyrvX3F/wcn10aWg1i21LwHEYXuBTXA8pCgt/LelFtIUhdhP7ZoTdSfqrTfe
 a6WxWOXKIwiHI1QwhSNdxevfkNgYc+jNXWtszQrv3bVKYNRZzyWW7jTtJMjzeWODCRkp
 4aaw==
X-Gm-Message-State: AOJu0Yx2DqoknMNl8cUJ4E57+IgAiyVxmzzFbaR8aNp34B3LeOFlUgqL
 tXb8Mh2ICgYKHuk/L5FnytxUQ5V11jvESY6Ps9tBXJOX9fYiXvTR0EwJhsb6KGfCX4em36yfpeB
 8u3VgT6YjSw==
X-Gm-Gg: ASbGncvvG71N/Cg0DXOgT5rJdZspHibns5d/KmL6poGYlmwTo/MvSY7et+gIfjqmsTe
 wshj58VyC6cztyiLq5C5kVYV3KuN9M5FbCScZBVYfkluxFLSmE1FOHSTZ8cAybRfaZxloGFArwV
 8wA8treUN6Qiql7c9iaUE8OlWZOG4EUDRwQlinRZQf4dbWMYnyzSKrQ79FEiXRTamE4FdVfC8ne
 XZ3ERXTz3y4uQoKZKA1Pz0X0cFsjbVGgKaMZEFVlZj8vW+lPq52KAb2tLq32bSKLleSdTJashHK
 DoeAMak5pbxcJvtFqHczsi5UIsvWp2MGv54UDotqAsD0gUHs/AJyPx+PgElpafC6qa01
X-Google-Smtp-Source: AGHT+IHF4w3b5u3a1qWRyVn9Xo2Tqqyjz9UqCii2EuTyZGgPWY9ejCeQR5Gxohr3rC9QSI5xH0/qJQ==
X-Received: by 2002:a17:906:4796:b0:ac6:fc40:c996 with SMTP id
 a640c23a62f3a-ad218f22586mr675878966b.23.1746884631229; 
 Sat, 10 May 2025 06:43:51 -0700 (PDT)
Received: from chromium.org (82-132-222-17.dab.02.net. [82.132.222.17])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad219747028sm319763866b.106.2025.05.10.06.43.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 06:43:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joshua Watt <jpewhacker@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v4 10/22] passage: spl: Support adding the dtb to the passage
 bloblist
Date: Sat, 10 May 2025 15:42:08 +0200
Message-ID: <20250510154214.v4.10.Id6acd05e6730b3301ddc62b415a155202ddba74b@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510134253.1581164-1-sjg@chromium.org>
References: <20250510134253.1581164-1-sjg@chromium.org>
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

Add an option for SPL to add a devicetree to the passage bloblist, so
SPL can provide the devicetree to U-Boot.

Fix a few long lines while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Rebase on -master
- Update the commit message to mention the long lines

 common/Kconfig   | 20 ++++++++++++++++++++
 common/spl/spl.c | 43 +++++++++++++++++++++++++++++++++++++++++--
 include/spl.h    |  2 ++
 3 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/common/Kconfig b/common/Kconfig
index c6a8fa54363..1f908790139 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1243,6 +1243,26 @@ config SPL_PASSAGE_IN
 	  firmware phases to communicate state and settings to following
 	  phases.
 
+config SPL_PASSAGE_OUT
+	bool "Support the standard-passage protocol in SPL (out)"
+	depends on SPL_BLOBLIST
+	default y if PASSAGE_IN
+	help
+	  This enables a standard protocol for entering U-Boot, providing
+	  parameters in a bloblist and a devicetree. It allows the various
+	  firmware stages to communicate state and settings to following
+	  stages.
+
+config SPL_PASSAGE_ADD_DTB
+	bool "Add devicetree to the outgoing passage"
+	depends on SPL_PASSAGE_OUT
+	default y if SPL_PASSAGE_OUT && !SPL_PASSAGE_IN
+	help
+	  Add the devicetree into the bloblist in SPL (it is assumed to not
+	  already be there) so that the next phase (U-Boot) can find it.
+
+	  This option should be enabled in the phase that sets up the passage.
+
 source "common/spl/Kconfig"
 
 config IMAGE_SIGN_INFO
diff --git a/common/spl/spl.c b/common/spl/spl.c
index f14c68c46a5..6e38f118f48 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -66,6 +66,11 @@ binman_sym_declare(ulong, u_boot_vpl_any, size);
 
 #endif /* BINMAN_UBOOT_SYMBOLS */
 
+#if CONFIG_IS_ENABLED(PASSAGE_ADD_DTB)
+binman_sym_declare(ulong, u_boot_dtb, image_pos);
+binman_sym_declare(ulong, u_boot_dtb, size);
+#endif
+
 /* Define board data structure */
 static struct bd_info bdata __attribute__ ((section(".data")));
 
@@ -412,7 +417,8 @@ static int setup_spl_handoff(void)
 {
 	struct spl_handoff *ho;
 
-	ho = bloblist_ensure(BLOBLISTT_U_BOOT_SPL_HANDOFF, sizeof(struct spl_handoff));
+	ho = bloblist_ensure(BLOBLISTT_U_BOOT_SPL_HANDOFF,
+			     sizeof(struct spl_handoff));
 	if (!ho)
 		return -ENOENT;
 
@@ -429,7 +435,8 @@ static int write_spl_handoff(void)
 	struct spl_handoff *ho;
 	int ret;
 
-	ho = bloblist_find(BLOBLISTT_U_BOOT_SPL_HANDOFF, sizeof(struct spl_handoff));
+	ho = bloblist_find(BLOBLISTT_U_BOOT_SPL_HANDOFF,
+			   sizeof(struct spl_handoff));
 	if (!ho)
 		return -ENOENT;
 	handoff_save_dram(ho);
@@ -446,6 +453,33 @@ static inline int write_spl_handoff(void) { return 0; }
 
 #endif /* HANDOFF */
 
+/**
+ * Write the devicetree for the next phase into the passage
+ *
+ * For now we assume the next phase is U-Boot proper
+ *
+ * @return 0 on success,  -ENOSPC if it is missing and could not be added due to
+ *	lack of space, or -ESPIPE it exists but has the wrong size
+ */
+static int passage_write_dtb(void)
+{
+	if (CONFIG_IS_ENABLED(PASSAGE_ADD_DTB)) {
+		ulong start = binman_sym(ulong, u_boot_dtb, image_pos);
+		ulong size = binman_sym(ulong, u_boot_dtb, size);
+		void *dtb;
+		int ret;
+
+		log_debug("passage: Adding control dtb size %lx\n", size);
+		ret = bloblist_ensure_size(BLOBLISTT_CONTROL_FDT, size, 0,
+					   (void **)&dtb);
+		if (ret)
+			return ret;
+		memcpy(dtb, map_sysmem(start, size), size);
+	}
+
+	return 0;
+}
+
 /**
  * get_bootstage_id() - Get the bootstage ID to emit
  *
@@ -835,6 +869,11 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 			hang();
 		}
 	}
+	if (CONFIG_IS_ENABLED(PASSAGE_ADD_DTB)) {
+		ret = passage_write_dtb();
+		if (ret)
+			printf(PHASE_PROMPT "Write DTB failed (err=%d)\n", ret);
+	}
 	if (CONFIG_IS_ENABLED(BLOBLIST)) {
 		ret = bloblist_finish();
 		if (ret)
diff --git a/include/spl.h b/include/spl.h
index 7c10c7f792e..4fa97078a31 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -441,6 +441,8 @@ binman_sym_extern(ulong, u_boot_spl_any, image_pos);
 binman_sym_extern(ulong, u_boot_spl_any, size);
 binman_sym_extern(ulong, u_boot_vpl_any, image_pos);
 binman_sym_extern(ulong, u_boot_vpl_any, size);
+binman_sym_extern(ulong, u_boot_dtb, image_pos);
+binman_sym_extern(ulong, u_boot_dtb, size);
 
 /**
  * spl_get_image_pos() - get the image position of the next phase
-- 
2.43.0

