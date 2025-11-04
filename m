Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD6FCCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 18:32:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9442838CE;
	Tue,  4 Nov 2025 19:31:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=arista.com header.i=@arista.com header.b="JUhXDTYc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A62EB832AD; Tue,  4 Nov 2025 17:15:29 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1660808AF
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 17:15:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adriana@arista.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2952d120da1so2288955ad.3
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 08:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arista.com; s=google; t=1762272925; x=1762877725; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pxY63+MNf1k3Zw1gdkO+Y94ztdZW6hN/ZyUKdk51++Q=;
 b=JUhXDTYcVwMPtBudx5jsI9la2wW3l3Uyhi/y9FePk7zP01z4LovYPYhBKlBNq3e5e0
 iG5Xfea2msYEVL1SGhDt6wnX2slEeBxa5C+wXyR7WOIOzD5UHS7gwtD1QDL9kVPdP9KD
 Xv4ZjHycR3sZKvxhTDvqs/0ZMjxMih7CjfmZJvBxDJWXlwXwcxDrTRNMItLysfj6zzPG
 ydomL+Jw355FsT77yL1NfyYAYokK4UmJ6jRc1IQH6IfqtBEu15ridt167mWzm9WJ/Iw3
 U1v1B7gC846Q2nontJb4moqQqxlWAmFdYU8PvyYRLQ2SKMqlYL7g6GzhyjPGjF3q9dJ5
 wExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762272925; x=1762877725;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pxY63+MNf1k3Zw1gdkO+Y94ztdZW6hN/ZyUKdk51++Q=;
 b=ZPxoEpmjcBAXYucp/g/CIa7aZV4yBW05g03v4PyOItGIAZ9XGDgIai39EtdgQJde03
 KQMZ/y3Kldnwx2+pRHGDQ3/+XRDI7ynm7FLv/5zR3jzVLby5aYf+pDwZTdS59CqH8Lp2
 kp9g8LfccvktSu0iP8Nn8vyLNwC4eSUmok3gWONirFF8dqKADr4U4M6dgkEe7gtDA+H1
 LVESYgrchIbUnUiVNKYQh+y5TF4y1eJSEv7phno2C99FTMKsFC91S14FZKXALsl293Zm
 5wH5puwVCnKDh++0rQeBiyEqREcutcn1P3eqwke8Pt8AEAEENVS+4WE6YL/tGk/pa4PH
 z2AQ==
X-Gm-Message-State: AOJu0YxbZc+QtrEbghYIMWRmjsEQ9sdGJWd2kjF9tk9f6RjoB0cJfR1s
 W8tsRq2wWVQRP9RIdgZdNy2BzfgvGXb4DT/DqiMJ1jMfk0M16VRBUm+AeibklxHKMw==
X-Gm-Gg: ASbGnctIEHMUJQD2ixZ73EzIokcZhCfewhD8uYEiTXrsHujSEQ+b2yOF/S0Tuj22Dd4
 8DJuCxehPHDQ+UZmJYfNMGJLelZ1MzXyA8rhWw21KI2xzf7aCo+NJu/W9QtuCuVCJPI5Z18ZP78
 rUAOiWn8Z2la7c6zNyBEx5Uf6dFfCkpzObsCaT73lV9lpwNoL7uPzE2bPwUzqt8QvpVm6FEZQ35
 rUEJ4gcFb8Mnu/5TQ21arTw4SGhRRC8Ul4jBr/n2PstaensJwzZIcI7frPdtAfNkXUSwlsHHrHH
 PhalKss3jbbD7jCD03vaVCUAkhyvXlugPU8qTvUSsOK77zu4tu06/LLFhOljG0rccc4mplP6G/Y
 c/ZqPgo8gGmir6mU9lThPoJf7UpSknU97OeipoZUs4XpHpb86PMs1g81f6+O9qlgnjwcEUldKzH
 qukSXaPeFonI6FgHIOl5fO7yZtV+dIlPk2UZJVi4AW+iEBsy0=
X-Google-Smtp-Source: AGHT+IE4jwWACHVIb2r3gIS52FMfmjBwGvzr7HMqC+3rNdgSSGbLFObrS7xJN6yz8RUN89Z1EuqdpQ==
X-Received: by 2002:a17:903:22c4:b0:25a:4437:dbb7 with SMTP id
 d9443c01a7336-2962ad25ad4mr1103645ad.4.1762272924965; 
 Tue, 04 Nov 2025 08:15:24 -0800 (PST)
Received: from adriana-dmi-upstream.sjc.aristanetworks.com ([74.123.28.15])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29601a3aba0sm31278695ad.64.2025.11.04.08.15.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 08:15:24 -0800 (PST)
From: adriana <adriana@arista.com>
Date: Tue, 04 Nov 2025 08:15:21 -0800
Subject: [PATCH] boot/bootfdt: Add smbios3-entrypoint to FDT for non-EFI boots
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-smbios-v1-1-99b79a8f59b3@arista.com>
X-B4-Tracking: v=1; b=H4sIAJgmCmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA2ND3eLcpMz8Yl1TC3OTRGPL1GQzI2MloOKCotS0zAqwQdGxtbUAVi1
 EyVgAAAA=
X-Change-ID: 20251031-smbios-5874a39ec623
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Richard Weinberger <richard@nod.at>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 adriana <adriana@arista.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762272924; l=4383;
 i=adriana@arista.com; s=20251030; h=from:subject:message-id;
 bh=w37r2723kM/K2OtICnaUR55dYZapMXKZ2ZgDP5UEzAg=;
 b=W0HlCc6ss1Lab8GT4g/KHKgU9Mowvg1KibOkwmeMD1jAiEYD/wXTxMdq8HvRZemH6oB4JbAs3
 TbWs70QuC0WCxAdwZ9Twkb1Rz5Mec9bbjmQ2HuU0MkN7/tIExUwKnx3
X-Developer-Key: i=adriana@arista.com; a=ed25519;
 pk=lII+K3k+wnbGA8lid1LtGpyLz6AegAq0xb4hHGsHZc8=
X-Mailman-Approved-At: Tue, 04 Nov 2025 19:31:58 +0100
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

The Linux kernel can discover SMBIOS tables through two primary methods:
1. Via EFI tables, when using EFI boot;
2. Via the 'linux,smbios3-entrypoint' property in the /chosen node of
the device tree.

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

Signed-off-by: adriana <adriana@arista.com>
---
Changes in v2:
  - Renamed device tree property to "linux,smbios3-entrypoint".
---
 boot/fdt_support.c    | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++
 include/fdt_support.h | 10 ++++++++++
 2 files changed, 65 insertions(+)

diff --git a/boot/fdt_support.c b/boot/fdt_support.c
index 92f2f534ee0..e757ffe673c 100644
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
+#if defined(CONFIG_SMBIOS) || defined(CONFIG_GENERATE_SMBIOS_TABLE)
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
+#endif /* CONFIG_SMBIOS || CONFIG_GENERATE_SMBIOS_TABLE */
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
@@ -387,6 +429,19 @@ int fdt_chosen(void *fdt)
 		return err;
 	}
 
+	/* Inject SMBIOS address when we have a valid address.
+	 * This is useful for systems using booti/bootm instead of bootefi.
+	 */
+	smbiosaddr = board_fdt_chosen_smbios();
+	if (smbiosaddr) {
+		err = fdt_setprop_u64(fdt, nodeoffset, "linux,smbios3-entrypoint",
+				      smbiosaddr);
+		if (err < 0) {
+			printf("WARNING: could not set linux,smbios3-entrypoint %s.\n",
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

---
base-commit: 08bf42e1faa4411cd347c2e370da790a0116e318
change-id: 20251031-smbios-5874a39ec623

Best regards,
-- 
adriana <adriana@arista.com>

