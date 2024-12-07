Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64884E7717B
	for <u-boot@archiver.kernel.org>; Sat,  7 Dec 2024 14:52:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8814488F83;
	Sat,  7 Dec 2024 15:52:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ExkXv/x+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 320A889049; Sat,  7 Dec 2024 15:52:36 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5BD888F75
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 15:52:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-84198253284so110402539f.3
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 06:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733583152; x=1734187952; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3BnRMLPAt+TMus4y+5zK2U1BzvXfuVQ2L1Prxzsr5V4=;
 b=ExkXv/x+eYxgi5dvgenTTNkfEdrFdnaTM0ryaxEcWcq/S14KKwRkhFJe8vbQxe65fv
 KIRe6xjlfYTP3iOMl3pXAk+wMn5qC0TTD7KRVChfQhnyEWUWrACUP6j7uT2Z2QV+rYCS
 uP+xSD1CYIw8CLDsfQyHFfhhBcdkP/VOBzmyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733583152; x=1734187952;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3BnRMLPAt+TMus4y+5zK2U1BzvXfuVQ2L1Prxzsr5V4=;
 b=A4UrcurgbX3FxAucCC6CLQuxxfD8xGRjKyu3R1u+TTKaVu0bjlGdwzrgktlOApyRFL
 nxmanBIqdqFzbWyojSH4yAdclPFMqmW9BkD92H0MAEFRykDa6JOZMKlT2PxzW8Tkpgn5
 cVtCwe2hpv9TvgNP+TmO+tuWR+A7FoI1a3QlhMSOMuJjv/c6H2TAvZLsbABYvSP9qu2B
 Nk4/3itq+3Au3NnziQC0q5HkKdoDc4hCW62VwfOEQc/i21C1006wJTqwy10AFO2GiXog
 3De3KA01m/V+kHim1n/IZ9152WfTC0shug8IyuGWHSCw4l2s6eEzrNqVEfFuxR1jkBXG
 mf/Q==
X-Gm-Message-State: AOJu0Yxhd8A7KJ/SHqkGszSVyajzU/XtA3wb8q1QMxsAQBKpo23xo4RV
 O80F4hJ3iLzpz3FqD1R8zjB7IXgccfgXDjybykjJaSz5/DwCOjA5zBugZwi8F0enngSO6CcqDWk
 =
X-Gm-Gg: ASbGncvRtqbXUKxWHgMK+8JtCbHq+FfpcbtiRUEgDw36zJk+7bqK86eCsuq99pFFkPk
 tsMRWbjb3XaGRudiyaPY8T51wmKKJSOjD2I/1lIe7n1zZUCCyg8Nz3vSIRzmch0gYeVxz306DjX
 Ef1Od1VYqzJDLjbvTnfMqtuTpX7t57m7yfAfsydq8GDMNTSZq9KWDYNjvQZEB1aM71rqn3xdy5R
 xVvuSnDCcaz5wTWFPQwioLn1AJJ26zVOam/Zb8ViRBKU+cOiyyf3lsf1XyY6CnL9Qn3E/PeZxEk
 1aweeSL8y+4=
X-Google-Smtp-Source: AGHT+IE6I5rCBF/PhCNPvSyZcQpVGv7MmiDW/sk1O53VLIztAE6hR9kuOy8NWduEL5cGPL/gMaZ2OQ==
X-Received: by 2002:a05:6e02:219b:b0:3a7:fe47:6228 with SMTP id
 e9e14a558f8ab-3a811d90261mr91157845ab.6.1733583152024; 
 Sat, 07 Dec 2024 06:52:32 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e286222bbasm1333371173.149.2024.12.07.06.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Dec 2024 06:52:30 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH] boot: Use correct PHASE_ variable for expo
Date: Sat,  7 Dec 2024 07:52:27 -0700
Message-Id: <20241207145227.1024491-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

This patch was written before the XPL change-over. Update the Makefile
condition to the new way.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: ae3b5928d61 ("x86: coreboot: Allow building an expo for...")

---

 boot/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/Makefile b/boot/Makefile
index b03d628187b..1d7f2a1a24a 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -61,7 +61,7 @@ obj-$(CONFIG_$(PHASE_)LOAD_FIT) += common_fit.o
 obj-$(CONFIG_$(PHASE_)EXPO) += expo.o scene.o expo_build.o
 obj-$(CONFIG_$(PHASE_)EXPO) += scene_menu.o scene_textline.o
 ifdef CONFIG_COREBOOT_SYSINFO
-obj-$(CONFIG_$(SPL_TPL_)EXPO) += expo_build_cb.o
+obj-$(CONFIG_$(PHASE_)EXPO) += expo_build_cb.o
 endif
 
 obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE) += vbe.o
-- 
2.34.1

