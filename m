Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 482E0D49771
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 14:43:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F1F189321;
	Sun,  1 Dec 2024 15:43:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MhMAHsdI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34A1D893A1; Sun,  1 Dec 2024 15:43:06 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D0FE8916D
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 15:42:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-84435dbda4bso20106339f.0
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 06:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733064178; x=1733668978; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rwrEYs/v5KgkvrdgSGS+AdvjDSjaxvGcn4Ck0B+Srs8=;
 b=MhMAHsdIJmJfd/eLhjclF68tVY9BrYpkqklUO/JCWr9gFJHksjcYVQbVTuRtXCjd0c
 FsJul9zCTunj+vaWslzKkEW4jw7xUFUoKifn6MsxOR6LWe4OhZ/Xi6FtlgxqVZ4VS5hp
 YgbpTrVOVohoNnMP1oQuwQrPY/DtfGz25VbSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733064178; x=1733668978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rwrEYs/v5KgkvrdgSGS+AdvjDSjaxvGcn4Ck0B+Srs8=;
 b=tYipLBeMcjNdLLDhMQ443R8xxof1tPqZmA9Xd69wim6eDHtN/R5A7bsVcSJImFYm+W
 u1lqifYrHobPtK520tNz/Q2QzQXQwH8G2F+pQHuXlnjnVCwLU64PkHiw7ZbU+u28aZnD
 d+vae52numh6A6XPEq9VwH3hEeuGtICjBECueFVax8It4rlJkBR5k2XtHF3aVgdhVCDh
 IVxMioebtIJxNMkKyFsFi2ue3O5cS6r2np9fqe5/hBX8ADo3hyU9nX2vgjqRSJqALfBv
 5W0ADuH3bJ3+ZBjwktONS/G4j9TySQAVC/MMIl0tzXVm82BYQ8FlHSswCCpo0gDWvOAY
 NwTg==
X-Gm-Message-State: AOJu0YznLFTo5vgsXcmD58v61fgSk2oEWrGwrdm4a6HcA9ZIj/btxj/O
 sf+PpFbJ0yUxx8eUIMqXlWTAgbWiS4tC0rLLmcLvP5T+MG4zAeWKOGKoZghTuu94QB5FCT1nqQQ
 =
X-Gm-Gg: ASbGncue1nHA+nh0icNNtgjB5r30ukV84SmxwydjR/wshFUjehZKcm31n5lO7U+LKQJ
 kHbfE83afOLbxZXgaL3ozhm+XFkxUbTma+rT8ssv4docX85/xNyCUM7GMNEYIQf5RM2hRaS655b
 ZbJhNItRD1uvNb0EahYQa79Qf6j80tScfNvH5ZrZLkFXyFhsZBdyey+e02yhqTZaEgXvGj3i+TT
 z3oW4rDviP8bFyidaVUupWe4Uawqa46j23tsqguGb2o
X-Google-Smtp-Source: AGHT+IFEceVnSVgEe/rQVvCCIUt7Q/EiDnTkEcA/mNoymX448VmScvQ8zHtvu2TTZozTrTeIB4A4mw==
X-Received: by 2002:a05:6602:15c6:b0:843:f220:fa86 with SMTP id
 ca18e2360f4ac-844014e75edmr1354039639f.1.1733064177746; 
 Sun, 01 Dec 2024 06:42:57 -0800 (PST)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405ec8755sm160826839f.17.2024.12.01.06.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 06:42:56 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: [PATCH 3/8] Revert "fdt: Correct condition for bloblist existing"
Date: Sun,  1 Dec 2024 07:42:31 -0700
Message-ID: <20241201144240.1664398-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201144240.1664398-1-sjg@chromium.org>
References: <20241201144240.1664398-1-sjg@chromium.org>
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

This was a work-around and it isn't effective, since bob and kevin are
still broken. Drop it.

This reverts commit cafde93ec02d654a092ee5b3fd0ed706347a9744.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/fdtdec.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index b0655988029..1842da62f37 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1668,16 +1668,8 @@ int fdtdec_setup(void)
 {
 	int ret = -ENOENT;
 
-	/*
-	 * If allowing a bloblist, check that first. There was discussion about
-	 * adding an OF_BLOBLIST Kconfig, but this was rejected.
-	 *
-	 * The necessary test is whether the previous phase passed a bloblist,
-	 * not whether this phase creates one.
-	 */
-	if (CONFIG_IS_ENABLED(BLOBLIST) &&
-	    (xpl_prev_phase() != PHASE_TPL ||
-	     !IS_ENABLED(CONFIG_TPL_BLOBLIST))) {
+	/* If allowing a bloblist, check that first */
+	if (CONFIG_IS_ENABLED(BLOBLIST)) {
 		ret = bloblist_maybe_init();
 		if (!ret) {
 			gd->fdt_blob = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
-- 
2.43.0

