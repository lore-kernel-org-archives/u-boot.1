Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 594D6C43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 15:07:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DCAC849D2;
	Mon,  6 Jul 2026 17:07:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="Skt9gtRf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C97A2849A4; Mon,  6 Jul 2026 17:07:11 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2451846B4
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 17:07:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ccaione@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-493bb510ce4so24028625e9.1
 for <u-boot@lists.denx.de>; Mon, 06 Jul 2026 08:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783350429; x=1783955229; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UZhPwm4+icuKyWinp7e8oijVTBG3PYcCD2BPoperoU0=;
 b=Skt9gtRfXV2cV86rpRCZEFLJqKOkObOmY0qcpyPBlNM5aL9oix1NRIAwcIa8C9bif6
 nBrG8Th5dJAKsJZmVmgbae9dR3TlaclrlS8nwUknkCspPVc9hOaI1Xx+E7Iehh/Y/hJF
 65/hyAUJs2Sy+epsSwO4oMK1f9PtQVT9rR1rPTRrcNGKl/bmuptuwYgIlYoTIk8+lL8f
 Zv99Eos9aYiHmmF3hDKSdHgoHdInqKHEUg+pHIbqWN1OiYyp2cEgEEGxdGyJb0P24GCS
 AuYRsWWgPBrBMTh1XxJQ/zv9X1N6iJDn6+HZHV0nKOEQRddXvktBQ8nosn1cG+mPlJaE
 XaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783350429; x=1783955229;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UZhPwm4+icuKyWinp7e8oijVTBG3PYcCD2BPoperoU0=;
 b=iyC9uAGboa0sLdWgxbOKGCfJznnEUAUXOY4GfFIGC2ikbdQXax4wzZfA/5zRGRITH1
 8J5KMtFzaQ4CvrbpdA1tey3lsRFmWTP77FtPn68lS1fhzEsY5eRJvpH3R0GDF63R0QKt
 H9wwrEVrSFtYBKr4F5AN+jZ54DOyN5LQZsQt4Z54StgQFbfDUmAYEHEXM05b9LkroK6y
 0G2KrkKwwhnloy4OOKWq5btnF8NkNwPWCuO/6B43AinBVzBikaXivIse51IKQLdOZK7q
 nQKLpGZSzep0iIfaCUVLt0/WF/WPQs3ZaqauT6bFjhbgM0W6mlWu5qirsijxiv8IllNW
 m23Q==
X-Gm-Message-State: AOJu0YzQhl0MBcSai8Pt5vdQTAH0eV9hBBe100H0o5/HUM7rDRjy3fLb
 QsA/E6GBktfNPki2L5Yrw9Vtg2Y1w4n3cZxSSvNT0NUc/+iE6zzJllfBi7V585+/MOM=
X-Gm-Gg: AfdE7ckkZBsDIP79SpQRsDmApULVxcGC/+MQsiBIQ4uuj6rOW+VHGb3XoIKgmSQt1hV
 o9zxN55/2gG5caPvrTDbH3c7yNcgvrLrXzpheAg95CE2pPT8g63IAB7SsHE0uoQfQrkTaVq98Nt
 NM4E+XpaKK8kG9EL39nHvrcnAXqFgVK8Pcg1DImwySTx3s06qtjQ0yD7dk9RzNCUL/sSyryLKoq
 hbGLIoD/opgxv4h9YMm6dci/epqITEGoAVHEKQhJqPcMAXd/5LyKtC9pQItCprXSgxqroKtM/TJ
 TX6lhiIOZQS+zM/KqChJc2IHauYLtfx4NaPEUVRuZdt2gdQqKKOycbJPI6/KlpVSLK4j8Gjzfbp
 PCZSofNbijDdC8jpE2adtjfST4s4vSmBhZpHrPlDvpe386uQv9OZ4N/9dDp1gjHSsgZSoT+4FuO
 /Sa6Hh/ZAE//Jr+vBIhqGfxOWDVcHIhzZ25vdczizDxOUEwsNEJtiU/zEZ3pJuFWvrx3Y=
X-Received: by 2002:a05:600c:5297:b0:493:d1e0:a4f1 with SMTP id
 5b1f17b1804b1-493deffbf21mr12090415e9.0.1783350429157; 
 Mon, 06 Jul 2026 08:07:09 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it ([95.236.170.123])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493cce03fa1sm281421265e9.11.2026.07.06.08.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 08:07:08 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 06 Jul 2026 17:06:44 +0200
Subject: [PATCH 3/4] efi_loader: bootmgr: install the firmware-owned devicetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-ccaione-upstream-ebbr-v1-3-e742cdd6abe5@baylibre.com>
References: <20260706-ccaione-upstream-ebbr-v1-0-e742cdd6abe5@baylibre.com>
In-Reply-To: <20260706-ccaione-upstream-ebbr-v1-0-e742cdd6abe5@baylibre.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, Peng Fan <peng.fan@nxp.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, Anshul Dalal <anshuld@ti.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Javier Tia <floss@jetm.me>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, Martin Schwan <m.schwan@phytec.de>, 
 Michal Simek <michal.simek@amd.com>, 
 Pieter Van Trappen <pieter.van.trappen@cern.ch>, 
 Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.15.2
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

SystemReady IR boots through the UEFI boot manager, which does not go
through the per-device EFI bootmeth, so hooking the bootmeth alone
would leave the boot-manager path (including autoboot) on the control
devicetree.

Consume the firmware-FDT source in efi_bootmgr_run() too, so the
firmware-owned devicetree is installed via efi_install_fdt() regardless
of which EFI launch path is taken.

The firmware-owned devicetree is tried before the Boot#### load-option
FDT, so a stale or broken load option can neither override nor block a
configured (and possibly signed) firmware devicetree. As a side effect,
a devicetree passed directly to efi_bootmgr_run() now also outranks the
load-option FDT, which previously overrode it: an explicitly supplied
devicetree is the operator's immediate intent, and stored boot options
must not replace it.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 lib/efi_loader/efi_bootmgr.c | 50 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index 8c9a9b5eb56..8835891c003 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -14,6 +14,7 @@
 #include <efi.h>
 #include <efi_device_path.h>
 #include <env.h>
+#include <firmware_fdt.h>
 #include <log.h>
 #include <malloc.h>
 #include <net.h>
@@ -1296,7 +1297,9 @@ out:
  *
  * Invoke EFI boot manager and execute a binary depending on
  * boot options. If @fdt is not NULL, it will be passed to
- * the executed binary.
+ * the executed binary. Otherwise a configured firmware-owned
+ * devicetree source takes precedence over both a Boot#### load
+ * option FDT and the distro one.
  *
  * Return:	status code
  */
@@ -1305,7 +1308,8 @@ efi_status_t efi_bootmgr_run(void *fdt)
 	efi_handle_t handle;
 	void *load_options;
 	efi_status_t ret;
-	void *fdt_lo, *fdt_distro = NULL;
+	struct firmware_fdt fw = { 0 };
+	void *fdt_lo = NULL, *fdt_distro = NULL;
 	efi_uintn_t fdt_size;
 
 	/* Initialize EFI drivers */
@@ -1320,11 +1324,40 @@ efi_status_t efi_bootmgr_run(void *fdt)
 	}
 
 	if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE)) {
-		ret = load_fdt_from_load_option(&fdt_lo);
-		if (ret != EFI_SUCCESS)
-			return ret;
-		if (fdt_lo)
-			fdt = fdt_lo;
+		/*
+		 * Prefer a firmware-owned devicetree (EBBR) over both the
+		 * Boot#### load-option FDT and the distro/ESP one, and try it
+		 * first, so a configured (and, in secure mode, signed)
+		 * firmware DT can neither be overridden nor blocked by a
+		 * stale or broken load-option FDT. An FDT explicitly passed
+		 * to efi_bootmgr_run() (e.g. "bootefi bootmgr <addr>") still
+		 * wins. Fail closed: a configured source that cannot be
+		 * assembled ends the boot rather than falling back to an
+		 * unverified devicetree.
+		 */
+		if (!fdt && CONFIG_IS_ENABLED(BOOTSTD_FIRMWARE_FDT)) {
+			int err;
+
+			err = firmware_fdt_load(&fw);
+			if (!err) {
+				fdt = fw.fdt;
+				log_debug("Using firmware-owned devicetree\n");
+			} else if (err != -ENOENT) {
+				log_err("Failed to assemble the firmware devicetree (err %d)\n",
+					err);
+				ret = EFI_LOAD_ERROR;
+				goto out;
+			}
+		}
+
+		if (!fdt) {
+			ret = load_fdt_from_load_option(&fdt_lo);
+			if (ret != EFI_SUCCESS)
+				return ret;
+			if (fdt_lo)
+				fdt = fdt_lo;
+		}
+
 		if (!fdt) {
 			efi_load_distro_fdt(handle, &fdt_distro, &fdt_size);
 			fdt = fdt_distro;
@@ -1337,7 +1370,10 @@ efi_status_t efi_bootmgr_run(void *fdt)
 	 */
 	ret = efi_install_fdt(fdt);
 
+out:
 	if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE)) {
+		/* efi_install_fdt() has copied the devicetree */
+		firmware_fdt_free(&fw);
 		free(fdt_lo);
 		if (fdt_distro)
 			efi_free_pages((uintptr_t)fdt_distro,

-- 
2.55.0

