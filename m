Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4173C54F4C
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 13:21:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 921A8608AD;
	Tue, 28 Jul 2026 13:21:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5DI1FqnI-md1; Tue, 28 Jul 2026 13:21:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EDD3C60890
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785244863;
	bh=mjSewuVK/LliTSJ5TeIkELL6oetAfiM89wlh7uvovgE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U3FUdurHXRxbM63dIAuHbWU7X6fKzJzv5HBI+Z1A9jyJhdlQ2s3R9P1sHn+W+RdS5
	 dGYLLO3JvIgpKtctE+0K3jIkGpORPnVz6dc9Dmgm9gL4b6vnmralyyO+vxu8v2j5tA
	 Rydg1/lqLXGUSrM2XJMVbB7MDydbjHT5XKBOlu620lMYFZTLF8nrGvmvC5VxrUjNIX
	 ses/pQNtDeeCPiASreIiazCyANl8OiY+zXOyyHoTvCtRXDVOXD9dRildk/YRNFh7/N
	 eMUhBiWR9UaDjoL+9df68+sjXMsN5BXC8cPqftKNmZqaRsh21dO68ZQNSIr0Sluiyz
	 5TsKemhsmLSpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EDD3C60890;
	Tue, 28 Jul 2026 13:21:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A1E4545B
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 13:21:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8718340935
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 13:21:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k7S29DykgiB8 for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 13:20:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6FB8340927
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6FB8340927
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6FB8340927
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 13:20:59 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49550ec592cso6213225e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:20:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785244857; x=1785849657;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mjSewuVK/LliTSJ5TeIkELL6oetAfiM89wlh7uvovgE=;
 b=dEz5ER3piZYdSasoFS3oFFnQt0t8qZ9Paxqhnovg+5FJTeSuNHiOZ0DLhESXpEMjDX
 0wAjk24mGuZ3fBAaCD/6Fd9agP0OMG4co+2cfELU3PfvBtHlQgcdxvEKL+87U9Ae31/X
 3TksDaPMOxkqYv6c23405gWQSaPYo7d9kw7f07ngQdb+xFhODcGWIcPvvwbxc9xcJVwo
 nFKTCfs+A4Wpr46WArZ3xIrrUFlROTT21TrIlI+dVtW8ClJ+c1gTaDbtTOJfh8qiXDFn
 nwh/lWPRbbq+H5kQsIemTqb7haC8USn8jqCx2v7CMkFA/nCLLaEkrF0wgjYEqRdLkk2S
 d13w==
X-Gm-Message-State: AOJu0YwQwCjpBsAFDJ0kZNdft3ynr90KjKTMNPaYoxs1WInJTElaidUX
 p7iYquCZHP5LCaQppxiBiaKZSUTe/EFDWH0zt/ePnzWPa0ue/7bYGxQbEICxYjl/zVc=
X-Gm-Gg: AR+sD10e22Dh7frpniW0iGmJicF019p1w9G9wtxd0U9zPJQZdLcQ1WDH2AiPLlO5Ba4
 J3cZq4QpjSOS+orhDfMd8FPZxaQY0GGi32UQVU/3j7j2ZJWb5i46IfURHOq9TFzoOvcytJJzmV6
 kYS83Vp7P6z0Xi+ZwZJWYgmJM6Tpc6hBxBD9J25odRm+rborn75DckW9Bh73m2lwbi8VKW7qnJ9
 W7tRoJTJjngWbrHDPsai29zf1INDaav28+6xFB2+Sy4UldicKTRCo/Fs2gp1OeOmOxuocc3Lb/+
 1UW3IcPVnsUzuBLBdM6yQvvyzYO+TcqEpm8OMFaHOPwqpAFhv/6O0B1MMprDkBcov/e6eYWp2rn
 sbCzP60EvX7Jr/jaqFx8MoaMsjeJwV+uEVsk6Umb6FyxQZxuykIB8Mu8Ad2IUK3QXYx2Kg+r/Id
 a2onPb+eVitkEfAB8Au2hYUBaKt1X/Aw5v63tj1gMhRk7h3kRw1ZJNzePRBPzvdBH8bfamZQ==
X-Received: by 2002:a05:600c:3103:b0:495:6934:4146 with SMTP id
 5b1f17b1804b1-496c6575ad5mr24099795e9.11.1785244856983; 
 Tue, 28 Jul 2026 06:20:56 -0700 (PDT)
Received: from [127.0.0.1] (host-87-0-90-136.retail.telecomitalia.it.
 [87.0.90.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957bd9e980sm306898645e9.0.2026.07.28.06.20.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 06:20:56 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Tue, 28 Jul 2026 15:20:43 +0200
Subject: [PATCH v2 1/5] efi_loader: bootmgr: preserve a passed devicetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-ccaione-upstream-ebbr-v2-1-4efb529140d6@baylibre.com>
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
 d=baylibre.com; s=google; t=1785244857; x=1785849657;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mjSewuVK/LliTSJ5TeIkELL6oetAfiM89wlh7uvovgE=;
 b=eKWKM3CDWqUx6gc5Ks4Fgq2Hl9LS1qpygzoJFQtr+IlcjOKlHXK/WsKSlsT8uhPVRe
 bdyTsvMfgoecr0JD3J+p9hucOfr3BjpH91euSy80EpyZNc1jtB12zNIdBByiBAl7wJ7Z
 T8yQP6EV9FyW3yYCCEchmoyNTKX90RBsUgmFxSL1mRwWhicT4oe/ovLfW5tnSFV1w/IK
 y6mqM4pLjd+gwzi6Ws7oCjzS3fdY1RzvsiQ47SB3/j8M3ca9gnTQcrj2bOVxOSy/xRar
 pzX0v9dN4W8XHgtPdAVfwSM/mvwdDhk7lqvwMbkNAxY5wVzCu/pALAmnTU1zgqR/mQt6
 50DA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=eKWKM3CD
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

An FDT explicitly passed to efi_bootmgr_run() is currently replaced by
the FDT referenced by the selected Boot#### load option. This makes an
operator-supplied devicetree ineffective whenever the boot option carries
one.

Only consult the load-option FDT when no FDT was passed. Document the
resulting precedence so the explicit call argument remains the
highest-priority source.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 lib/efi_loader/efi_bootmgr.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index 8c9a9b5eb56..785484abf23 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -1294,9 +1294,9 @@ out:
  * efi_bootmgr_run() - execute EFI boot manager
  * @fdt:	Flat device tree
  *
- * Invoke EFI boot manager and execute a binary depending on
- * boot options. If @fdt is not NULL, it will be passed to
- * the executed binary.
+ * Invoke the EFI boot manager and execute a binary according to its boot
+ * options. The devicetree precedence, from highest to lowest, is an FDT
+ * passed in @fdt, the Boot#### load-option FDT, then the distro/ESP FDT.
  *
  * Return:	status code
  */
@@ -1305,7 +1305,7 @@ efi_status_t efi_bootmgr_run(void *fdt)
 	efi_handle_t handle;
 	void *load_options;
 	efi_status_t ret;
-	void *fdt_lo, *fdt_distro = NULL;
+	void *fdt_lo = NULL, *fdt_distro = NULL;
 	efi_uintn_t fdt_size;
 
 	/* Initialize EFI drivers */
@@ -1320,11 +1320,13 @@ efi_status_t efi_bootmgr_run(void *fdt)
 	}
 
 	if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE)) {
-		ret = load_fdt_from_load_option(&fdt_lo);
-		if (ret != EFI_SUCCESS)
-			return ret;
-		if (fdt_lo)
-			fdt = fdt_lo;
+		if (!fdt) {
+			ret = load_fdt_from_load_option(&fdt_lo);
+			if (ret != EFI_SUCCESS)
+				return ret;
+			if (fdt_lo)
+				fdt = fdt_lo;
+		}
 		if (!fdt) {
 			efi_load_distro_fdt(handle, &fdt_distro, &fdt_size);
 			fdt = fdt_distro;

-- 
2.55.0

