Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0333AC53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 13:21:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8D9FD608AC;
	Tue, 28 Jul 2026 13:21:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NZLtAa1aQDWn; Tue, 28 Jul 2026 13:21:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2895A608C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785244869;
	bh=IQ70fROUub68ZXEO6ulYzo7s1+Mrr7Sa5TFRSyPXpc8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mSZi6HrRzmCPOEPmKBmvfGRmsatUpBLMAugXuWBgOfEQMWBI27cowHQka/eFIK9/+
	 6wFsB5JERpvTZxPcydU1q3ZSz3oo4JlFLVQUAs5q1ShGTzQesMSOsp1Yf4OLWNfIIH
	 h8gii7IqeYPTdys641Et0W7RmR4Nk+IOz89iSxr1naPTAhuXbit21UYbj4FHUUAjvD
	 gXBPu71vF7YZZL35WAi5cZlyr/u5yamdpxWrXjxZIwMfPn67kg6Nkc+lbiZlxrI8Kf
	 H+t3S5sR8WgHDAVRmlAEd8myxWBhJxXBc6ImoCMtEBxXruJwdOnlT9yUi35bCHduNq
	 4TAsGn3ZEVacw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2895A608C4;
	Tue, 28 Jul 2026 13:21:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D444350
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 13:21:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9090840528
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 13:21:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZJDs2wFuwXKe for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 13:21:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2D6954097E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2D6954097E
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2D6954097E
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 13:21:02 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-47f6609c657so1851868f8f.2
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:21:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785244861; x=1785849661;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IQ70fROUub68ZXEO6ulYzo7s1+Mrr7Sa5TFRSyPXpc8=;
 b=jdkT7bxEBB6ffAd1tGn43cHanqrNCRamsE5ndLh6NOnUNwhL1iTczzeloqZuL78o7Z
 mLD0MkwRo5zaYEeWM7j/isbE/kWLiTF4pYvXr6h8n81VCDYdBcCCl/sRzgI366+pKVzr
 fCR6//j7oWiqROjeOrd0Ej6kpzW6zoM7wX6KRwpS/06FzxsvD7ht6TLDm2Zp5FBocPKC
 TEE4CkHHr/78PF8Q6otnxubmthszV1SRVuvAj4LzJ05qIdJkdhY+fwvdHvrwuwewvXlQ
 802IiX8MfItN265mpHKityKjsHRwysLYYmmE4aXMze/ewg5rj4m3nGQpyz3u8QE/UNb4
 qEdg==
X-Gm-Message-State: AOJu0YwzeZalqOSIMRRa9aCKUgdJjFENxso/cLf7XORcMXE/fSqBIOcZ
 3TPFqd75dWhOCdH8HqCPSGxLcalEcn+2IlVltC9QDn7F8stQPlkU+xFQbwSt8dJ867g=
X-Gm-Gg: AR+sD11RYKgjLgx47+eu1ydzx4Hqw+8f3Mujbx8op2obreaU/ON4YrNyslRz6DBH16T
 +uouHSUcpsdsiz+uNdD+Y0yh5OMp3RqqiIBuB30PNjhPCwuVyrR+ZxuzhY4mPp9ScRJ3wS70bm4
 345+aOTSzbtxOqnafTZb7guRL48/4z7tzkZm3q0UfXLf/AimWIDW8LlEpobQvujc1am4FlamBTe
 58UwrU5+uVyOJ7bkfofgM4RcmDcj5MwJM62BFfvbRlxRULgKRmeROF3blGHe4USOxz0P+WtX/8s
 b6V7IC2pz93z0Ead3NzyunjYRBNU+cqcWq65vtGzwmR9qKH5BzuOXEb0qJTYKR9TxzUUkOsYR1R
 JrZo1um8JraXvr+UvASZQ2al0U1V3GiHX/3KaIvuhKtk4hh/BF9sYgYGoHInn39Z1SqxKygj0Ov
 RCY5+P3or0JNmalKIfTmpAAx0iYdaktQ7naxwfuuituoi/0n73NMB39g8JTHA=
X-Received: by 2002:a05:600c:a44:b0:496:bba5:33a7 with SMTP id
 5b1f17b1804b1-496c659679emr25953985e9.27.1785244861158; 
 Tue, 28 Jul 2026 06:21:01 -0700 (PDT)
Received: from [127.0.0.1] (host-87-0-90-136.retail.telecomitalia.it.
 [87.0.90.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957bd9e980sm306898645e9.0.2026.07.28.06.20.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 06:21:00 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Tue, 28 Jul 2026 15:20:46 +0200
Subject: [PATCH v2 4/5] efi_loader: bootmgr: install the firmware-owned
 devicetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-ccaione-upstream-ebbr-v2-4-4efb529140d6@baylibre.com>
References: <20260728-ccaione-upstream-ebbr-v2-0-4efb529140d6@baylibre.com>
In-Reply-To: <20260728-ccaione-upstream-ebbr-v2-0-4efb529140d6@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Ahmad Fatoum <a.fatoum@barebox.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Carlo Caione <ccaione@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Johan Jonker <jbx6244@gmail.com>, Randolph Sapp <rs@ti.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Peng Fan <peng.fan@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785244861; x=1785849661;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IQ70fROUub68ZXEO6ulYzo7s1+Mrr7Sa5TFRSyPXpc8=;
 b=LP05InOU+JIjfmL9979krYBfDcbxm9KfAcp6v4pDHQXR3WAfVSVQ3lNL7p3eO89Cw1
 F+VmxfgJrMLEQQZZxPRKhHOdcWciikZCLm2281+DNMBQTusP3K/nFvG4iD7EPLDZNNKi
 Ey+kTO8dkiq6/BJtOa0sAxG4ruB2BGZUaHiejHdR8NIAgZ4F7AMGdxoIPDryI6iOVbW1
 5MfIPOJdBKJNviWNdaeSIzn31XipLkh7oSa7kseIBPX7/6GNF4qjAU3iFNMPjOcAPTxv
 MaVGozQr0q80JNygSfuUd+cr/tWdINuTTT7CB5vlKZoKWu3RnJ2sLn7nYPRgzCOodkiO
 j+Ug==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=LP05InOU
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

SystemReady IR can boot through the UEFI boot manager without going
through the per-device EFI bootmeth. Use the shared staging helper here
as well so both EFI launch paths install the same firmware-owned
devicetree.

The precedence is an explicitly passed FDT, firmware-owned FDT, Boot####
load-option FDT, then distro/ESP FDT. A configured source fails closed,
and assembly failures are reported as EFI_DEVICE_ERROR.

Route load-option errors through the common cleanup path while adding it.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 lib/efi_loader/efi_bootmgr.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index 785484abf23..cb817116692 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -14,8 +14,10 @@
 #include <efi.h>
 #include <efi_device_path.h>
 #include <env.h>
+#include <firmware_fdt.h>
 #include <log.h>
 #include <malloc.h>
+#include <mapmem.h>
 #include <net.h>
 #include <part.h>
 #include <efi_loader.h>
@@ -1296,7 +1298,8 @@ out:
  *
  * Invoke the EFI boot manager and execute a binary according to its boot
  * options. The devicetree precedence, from highest to lowest, is an FDT
- * passed in @fdt, the Boot#### load-option FDT, then the distro/ESP FDT.
+ * passed in @fdt, a configured firmware-owned FDT, the Boot#### load-option
+ * FDT, then the distro/ESP FDT.
  *
  * Return:	status code
  */
@@ -1320,13 +1323,27 @@ efi_status_t efi_bootmgr_run(void *fdt)
 	}
 
 	if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE)) {
+		if (!fdt) {
+			ulong fdt_addr = env_get_hex("fdt_addr_r", 0);
+			int err;
+
+			err = efi_stage_firmware_fdt(fdt_addr, &fdt_size, NULL);
+			if (!err) {
+				fdt = map_sysmem(fdt_addr, fdt_size);
+			} else if (err != -ENOENT) {
+				ret = EFI_DEVICE_ERROR;
+				goto out;
+			}
+		}
+
 		if (!fdt) {
 			ret = load_fdt_from_load_option(&fdt_lo);
 			if (ret != EFI_SUCCESS)
-				return ret;
+				goto out;
 			if (fdt_lo)
 				fdt = fdt_lo;
 		}
+
 		if (!fdt) {
 			efi_load_distro_fdt(handle, &fdt_distro, &fdt_size);
 			fdt = fdt_distro;
@@ -1339,7 +1356,9 @@ efi_status_t efi_bootmgr_run(void *fdt)
 	 */
 	ret = efi_install_fdt(fdt);
 
+out:
 	if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE)) {
+		/* efi_install_fdt() has copied the devicetree */
 		free(fdt_lo);
 		if (fdt_distro)
 			efi_free_pages((uintptr_t)fdt_distro,

-- 
2.55.0

