Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE429FEE4EE
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 20:22:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 627D383EC6;
	Sat, 28 Feb 2026 21:20:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Qxnouzq+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A41983F8E; Sat, 28 Feb 2026 21:20:47 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 944C483F64
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 21:20:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d18a9d2b1aso2199817a34.2
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 12:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772310042; x=1772914842; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lqjoG01NWW7JQmM6RiyOSrQD4DuxJtJkB1lYY2WK+oA=;
 b=Qxnouzq+Bwmhix6MLejngzsCB5dMtAJY0y0LaKeYNG9XqbaLC4WTLSph1bwZZfz1z8
 Qg67Sc0BZEzqmDXodb3tjWWPQDDdYLy7DCZ8n+Oi4E9f8NRFubx2N0TrPEj2cOqVNh3P
 ygzy05cOGF9h+xxqDkV9PGa+IEzmZbRgb65o4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772310042; x=1772914842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lqjoG01NWW7JQmM6RiyOSrQD4DuxJtJkB1lYY2WK+oA=;
 b=pOzwRgWPUjlv8C0dMhYCPDv9CccO52D0Ax2/7sJyrYgnTM3YiyTk2funLpovaqDA5T
 QBcvQLhifEGTnntZ502ZHkW2HlZNwGJH0vUZS7MTmpCYWgqszr3AKO4KXhemmXbgjsER
 v+OdL95oU3/wVJkAmBiHDqUfO5CQUkLwIehbSAfXhs5crByoFW5UyWQeuSKxs+Pe65PS
 bz8xZ70xxAQoXRe+XbSqbFqXXDMkjsICKOnG58UU4gmnnvsh/Fj9DNfoVZDKwuF6LK9s
 mmZYmoQsBpwnqbAuPjB5WK/56+yKBXvzf0402i5tvnJXizQ4WnXQKLecROZZvY6cBzcL
 //cA==
X-Gm-Message-State: AOJu0YxX+WV9S1s6WDysnVX0fyvOzeVS9Sg6e5hvsRDIOGr7Jo48Dhy3
 9PEyFcvrd57dFP9iuc4ls+Lf5SGgi/qocqUq6OUb8UIvuazbpcANJ6rE0wFmdeWiKtjut1jLek0
 WKNU=
X-Gm-Gg: ATEYQzzNud3mFnp+zlHdkyJK/0fBFOEdZHCbw7r71cE6k6HuIzRk/fzo/t1lPF+IMt6
 OK+ZVvTrjiqdZi45rlmUrdzc8YAxa/9cOBxT/A0JAjeKfLes8lCkQeMOG0BUmlAS6eTwkpWFzFp
 r+KtWvkfJrOD8FhoKXEU02xFAGuvPFEtr7MyHy+p4vLym4bpSX8ryPJINCnvnGqTWdMP1O2qDP8
 /9BRajMK0vPUViXDbGABmKZOEWhsHqTrYw+Xjvwxf70zdbsC4MsZTWZbnb4vppiMRXbDao0T3Tt
 XRzphKDRfRA0luPithvnOwU7NPe+Tyy7hS/idzI+W1rfbRc5Qp6raVz0+feJ9CH9WXdjXNBtgER
 Tm4u8+ME/zmaUAgzNDrBJMayb/eggqB4p1PJkgdHN7tu9+FvBP0a08c7zMaiRWoLBjpsrkPFrDs
 M8DbsHo5anBIXxa0Ea9w==
X-Received: by 2002:a05:6830:280b:b0:7cf:d819:a2d2 with SMTP id
 46e09a7af769-7d591bf8f12mr4907423a34.31.1772310041968; 
 Sat, 28 Feb 2026 12:20:41 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d58644edfbsm6978361a34.6.2026.02.28.12.20.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 12:20:40 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Subject: [PATCH v3 11/17] mips: Call bootm_final()
Date: Sat, 28 Feb 2026 13:19:59 -0700
Message-ID: <20260228202011.1834493-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260228202011.1834493-1-sjg@chromium.org>
References: <20260228202011.1834493-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

Replace the open-coded bootstage_fdt_add_report() and
bootstage_report() with a call to bootm_final(). This also adds the
"Starting kernel" message, board_quiesce_devices() and
dm_remove_devices_active() which were not previously called on MIPS.

Signed-off-by: Simon Glass <simon.glass@canonical.com>

---

Changes in v3:
- Add new patch for MIPS conversion

 arch/mips/lib/bootm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/mips/lib/bootm.c b/arch/mips/lib/bootm.c
index 87195100023..066c830f3fa 100644
--- a/arch/mips/lib/bootm.c
+++ b/arch/mips/lib/bootm.c
@@ -268,12 +268,7 @@ static void boot_jump_linux(struct bootm_headers *images)
 	if (CONFIG_IS_ENABLED(MALTA))
 		linux_extra = gd->ram_size;
 
-#if IS_ENABLED(CONFIG_BOOTSTAGE_FDT)
-	bootstage_fdt_add_report();
-#endif
-#if IS_ENABLED(CONFIG_BOOTSTAGE_REPORT)
-	bootstage_report();
-#endif
+	bootm_final(0);
 
 	if (CONFIG_IS_ENABLED(RESTORE_EXCEPTION_VECTOR_BASE))
 		trap_restore();
-- 
2.43.0

