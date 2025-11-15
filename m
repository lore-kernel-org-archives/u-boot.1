Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A19CEB2CD
	for <u-boot@archiver.kernel.org>; Sat, 15 Nov 2025 11:15:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57FBC839FD;
	Sat, 15 Nov 2025 12:15:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=arista.com header.i=@arista.com header.b="DTHrAscj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8750F83E23; Sat, 15 Nov 2025 12:15:43 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A594C839DF
 for <u-boot@lists.denx.de>; Sat, 15 Nov 2025 12:15:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adriana@arista.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-343641ceb62so498994a91.1
 for <u-boot@lists.denx.de>; Sat, 15 Nov 2025 03:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arista.com; s=google; t=1763205339; x=1763810139; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mCB4MJlIczU2QtEAc6l4rfCCC5Zfq5uQwvH8aIN2w68=;
 b=DTHrAscj1XyYyqgVvRFDFwU/fVT1yciSkuTM7ajSzJhr3WaUcTgFY0pShK+Ix42Yij
 XZ0KuBlVsJMTrxhfmX6vBCWaICcQDW8zmy7OA0vYDcUWjY/izs1qFe4ghZE31pMcHOox
 +/ODQ4MlD207ESnTyligcZVW9+kDHqO+bHQ7kLKfMRYOeqBuxYYwZ6UTVce1ecBWuDuH
 adKVneGTD4y38l3f3Hmeb0GNcA/RE1u95yCZl54dE5TwfOGkkg6w5isk0ub3nBOioIl+
 yvz9nbnWqxZ38WWiK7Z8eaaHq5+Pis2Ma9xRHgpmTbGblG2zu3GqhYpXwA83NNdG9Em+
 Ac0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763205339; x=1763810139;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mCB4MJlIczU2QtEAc6l4rfCCC5Zfq5uQwvH8aIN2w68=;
 b=VdBA+u8tYXsGW8mR4z1hTTWSRVvHkZrPmBRQQyOsx3Wow1ZXHhQNC2OH++HeRyqPPU
 0Nn7v5dJMM6pS+yIy6g6hMIMOhRMXAMmbTmgxK9lQJ5Ufqo0gCIG7TcsQ5srMW5H/6Vi
 8owex19UTu1J7g0jWFgKq90efZnxBhzAGuvlcDQZ9YfDcm3WbxuWK4rdp5DzMpGyTkF2
 I5l9266hraYI+x1HqUv2U/2+q7TcR72CqiZP9Mm6P6609K82w5WIrXr6jrMEQnRElz/8
 VO3HIfgYJkPattoZQ+N6e4Wo5lClM3CC5WBVEZKvw/QsLf8lmTMNGwzrUBGEK52Ube0e
 K90w==
X-Gm-Message-State: AOJu0Yw/KsoVtd9qzMcwGgbgnz5flwByveBxF/M3qqeouv+6D1PkgCdf
 s+e8R5Q7u2SKRPzAvo6JC08XSxgh3J5PDowJuNl7GwsQignXhRtqsRm4EPVxyMgPLUiuUkIOpGa
 PSHA=
X-Gm-Gg: ASbGncv7FH3LHEfpbcc8X6ZfT82GP7xuxFWhp6dQI3HTTCaU9V8JpKLsEJe6xL9tQRJ
 VBwA+IO7uoFMFbjBJXGXETkDN67VFF7hyoUzbT5QRRyLlVbUhrrdJkbBS6kmcn+xG09IGOx2kP0
 zObHzXuPAZeEngbCcDxBh2AXPo/FF+YPaQAUcibMjcknSpaeXIn9EYSxs/tuMBm00IO7uO/iqK3
 exhBE0FyzfG4okYzdiU2bPMfSBRA10DfZgIBLjat727+92JM5sH/KMQZx79gVY26cFCdeaV6zmJ
 n0ukW++17CPwJy0GhS3IOV/iu+UelZh5ZuUmLnWNkWVrikAzIde3LYlh9UL5jmMnPbCrCaZNL5c
 TgjH+BwWxRzp0Jz7zmjkcFuuED30jsUpG4FVqBTWZoZJ437e6bVyhUlnye78zfimq/7jV6v1yh0
 0RkNn32K4Z1r5kEZQhf5DqWhmb+98PLQWQ9rlow9GXS6ebAuc=
X-Google-Smtp-Source: AGHT+IGZ4wFp8kvgeNjdBd6lXMLbr4iSaoT/LTEDJ7uybP2xKCV195IeL461KSqfcWswX1EyBAFFQw==
X-Received: by 2002:a05:7022:411:b0:11a:5cb2:24a0 with SMTP id
 a92af1059eb24-11b40f87c55mr2314389c88.1.1763205338457; 
 Sat, 15 Nov 2025 03:15:38 -0800 (PST)
Received: from adriana-dmi-upstream.sjc.aristanetworks.com ([74.123.28.12])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11b86afe12esm8559986c88.6.2025.11.15.03.15.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Nov 2025 03:15:38 -0800 (PST)
From: Adriana Nicolae <adriana@arista.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, ddrokosov@salutedevices.com,
 ilias.apalodimas@linaro.org, quentin.schulz@cherry.de, xypron.glpk@gmx.de,
 kojima.masahisa@socionext.com, richard@nod.at, semen.protsenko@linaro.org,
 joao.goncalves@toradex.com, adriana@arista.com
Subject: [PATCH v2] boot/bootfdt: Add smbios3-entrypoint to FDT for non-EFI
 boots
Date: Sat, 15 Nov 2025 03:15:35 -0800
Message-ID: <20251115111535.39951-1-adriana@arista.com>
X-Mailer: git-send-email 2.51.0
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

From: adriana <adriana@arista.com>

The Linux kernel can discover SMBIOS tables through two primary methods:
1. Via EFI tables, when using EFI boot;
2. Via the 'smbios3-entrypoint' property in the /chosen node of the
device tree.

When U-Boot boots a Linux kernel using a non-EFI command ("bootm",
"bootz", or "booti"), the kernel relies on the device tree to detect
the hardware. If SMBIOS tables are available in U-Boot, they should
be passed to the kernel via this device tree property.

This patch modifies boot_fdt_prepare(), to inject the SMBIOSv3 table
address into the device tree if there is a table generated by U-boot.
The "board_fdt_chosen_smbios" is weak in order to leave the possibilty
for specific boards to select custom SMBIOS addresses.

The changes in this patch are added in the context of supporting this
device tree property in linux kernel:
https://lkml.org/lkml/2025/10/24/1393

Device tree schema was updated to include the "smbios3-entrypoint" node
in pull request: https://github.com/devicetree-org/dt-schema/pull/177

Signed-off-by: Adriana Nicolae <adriana@arista.com>
---
Changes in v2:
  - Renamed device tree property to "smbios3-entrypoint".
  - Removed redundant check for CONFIG_SMBIOS, ifdef is needed as
  "smbios_start" is not compiled on some platforms if !CONFIG_SMBIOS.
---
 boot/fdt_support.c    | 57 +++++++++++++++++++++++++++++++++++++++++++
 include/fdt_support.h | 10 ++++++++
 2 files changed, 67 insertions(+)

diff --git a/boot/fdt_support.c b/boot/fdt_support.c
index 92f2f534ee0..f3b8d6fc389 100644
--- a/boot/fdt_support.c
+++ b/boot/fdt_support.c
@@ -327,12 +327,54 @@ __weak const char *board_fdt_chosen_bootargs(const struct fdt_property *fdt_ba)
 	return env_get("bootargs");
 }
 
+/**
+ * board_fdt_chosen_smbios - boards may override this function to provide
+ *                           specific SMBIOS address
+ */
+__weak phys_addr_t board_fdt_chosen_smbios(void)
+{
+	phys_addr_t ret = 0;
+	const struct smbios3_entry *entry;
+
+	/* Only provide SMBIOS address if EFI is not enabled */
+	if (IS_ENABLED(CONFIG_EFI_LOADER))
+		return 0;
+
+	/* Only proceed if SMBIOS support is compiled in */
+#ifdef CONFIG_GENERATE_SMBIOS_TABLE
+	ret = gd->arch.smbios_start;
+	if (!ret)
+		return 0;
+
+	/* Verify this is SMBIOS 3 */
+	entry = (struct smbios3_entry *)(uintptr_t)ret;
+
+	/* Check for "_SM3_" signature */
+	if (memcmp(entry->anchor, "_SM3_", 5) != 0) {
+		printf("SMBIOS: Not version 3, skipping DTB injection\n");
+		return 0;
+	}
+
+	/* Verify entry point length and version */
+	if (entry->length < sizeof(struct smbios3_entry)) {
+		printf("SMBIOS: Invalid entry length %d\n", entry->length);
+		return 0;
+	}
+
+	printf("SMBIOS: Found version %d.%d at 0x%llx\n",
+	       entry->major_ver, entry->minor_ver, (u64)ret);
+#endif /* CONFIG_GENERATE_SMBIOS_TABLE */
+
+	return ret;
+}
+
 int fdt_chosen(void *fdt)
 {
 	struct abuf buf = {};
 	int   nodeoffset;
 	int   err;
 	const char *str;		/* used to set string properties */
+	phys_addr_t smbiosaddr;	/* SMBIOS table address */
 
 	err = fdt_check_header(fdt);
 	if (err < 0) {
@@ -387,6 +429,21 @@ int fdt_chosen(void *fdt)
 		return err;
 	}
 
+	/* Inject SMBIOS address when we have a valid address.
+	 * This is useful for systems using booti/bootm instead of bootefi.
+	 * Failure to set this property is non-fatal, we only generate a
+	 * warning.
+	 */
+	smbiosaddr = board_fdt_chosen_smbios();
+	if (smbiosaddr) {
+		err = fdt_setprop_u64(fdt, nodeoffset, "smbios3-entrypoint",
+				      smbiosaddr);
+		if (err < 0) {
+			printf("WARNING: could not set smbios3-entrypoint %s.\n",
+			       fdt_strerror(err));
+		}
+	}
+
 	return fdt_fixup_stdout(fdt, nodeoffset);
 }
 
diff --git a/include/fdt_support.h b/include/fdt_support.h
index 47b8b63d13d..ddb8a36cc71 100644
--- a/include/fdt_support.h
+++ b/include/fdt_support.h
@@ -240,6 +240,16 @@ int board_rng_seed(struct abuf *buf);
  */
 const char *board_fdt_chosen_bootargs(const struct fdt_property *fdt_ba);
 
+/**
+ * board_fdt_chosen_smbios() - Provide SMBIOS address for /chosen node
+ *
+ * This function is called by fdt_chosen() to get the SMBIOS table address
+ * that should be added to the /chosen node for non-UEFI boot scenarios.
+ *
+ * Return: Physical address of SMBIOS table, or 0 if not available
+ */
+phys_addr_t board_fdt_chosen_smbios(void);
+
 /**
  * ft_board_setup_ex() - Latest board-specific FDT changes
  *
-- 
2.51.0

