Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A1FC369CA
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 18:17:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07F398309D;
	Thu, 17 Apr 2025 20:17:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TIuCwBfW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 012E7830CE; Thu, 17 Apr 2025 20:16:57 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0EF08309D
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 20:16:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-86135ac9542so36007039f.1
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 11:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744913812; x=1745518612; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+xr1KjEfia/ElVXD4435/nmxAfHWMfTW+H+EDaZvSh0=;
 b=TIuCwBfWxn5K8IUhaCtFp11NxjoPttvt6yr/VXAy6wtFksR7ody+ZvNnBxSeBnnmud
 EcyZszqnpGAsSyTXtvgWEBpMQrZlopn97G9HQMoBgxpYWqhrWHBr6i0l3rVTtQXwIttr
 yHQ7K2QsuxORjiM2n7pzTiIokbqf/DAbLW5q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744913812; x=1745518612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+xr1KjEfia/ElVXD4435/nmxAfHWMfTW+H+EDaZvSh0=;
 b=Ceeknt1jyhlbL5jC2pMM61Py9wwcDhUL108olF009pMVub8aX4XKNmH08JneTui80m
 8o9qOFzUT3xrSW+LgeiTyUke+DYMqaG2BeZPo8oXWJhYnpJOIYYVDVZVKy8yYVyr+cIk
 eckwbeKSVugOeti9z3VeVvJQO+qAx5tsr/4JzPz6h6kUUQLtEFFHOcK6H2gyRwJFNv3P
 fobWA3i4Hn6qti4gggitLJOgJ27zaTA4QVErQxn118qTWxAj1z79pKRBPLa8jJsqPk8W
 PYaU+58FL8GLt81zBSS+cXBHcA7GT7vvtgqQbtuzgYaHoIIzhkNkLS3O57+OtRxmmvdp
 vxrA==
X-Gm-Message-State: AOJu0YyZgqh25bHROpFtdF+RPvrorrtgXBRXPQsOk8T5Can1vm+FJYz1
 tHrQ6kKR2PWXf6rlBRrX7rTNIqCi86Vm4So7UU+K5PtHLrDzMEw/+sG6KTHdl0KV2p7w6CgvpDk
 =
X-Gm-Gg: ASbGncuFU7/RKZPlPJqCDnxM8sfwiGGllIVHU/UBXPPsLt1fAUtnrzc3Iyu4co+FqCT
 1u+6BkVTZoEe3EVN40bJj9fCbR4mP7bazuQ+6/db2aW1vH5X0JuwUuJ4ZQiZPRyQWPdLnyEYiI2
 /YKb49J2vfxiSOxQGcitj//XjInb7DtDryS+mLlPtWsakeLpi5NhyhAyXvQXEXPSdPm+maL8M4z
 pgaLULMFzqv//svYxVlBzCw/C6vhqd/Mc5fPsHyJZJx93ABjuua8P5ARIHYxjsGBI/ksMu07SZM
 uALicWZLDfRsWufrhwHk3+Xuf8Xy51y0LiX/tev/YTcSY+63VOxubm1KuGN9HU5HYrcaqI4VIo/
 y6Q==
X-Google-Smtp-Source: AGHT+IG/kIdQEtp4aMlVRTDSFhixxKjJF4u56gPJ4va1z61riPz79FaRRoEJlpkPoE6mqN0mUibtKQ==
X-Received: by 2002:a05:6602:276f:b0:85e:73da:c56a with SMTP id
 ca18e2360f4ac-861d89ce3acmr110736839f.3.1744913812632; 
 Thu, 17 Apr 2025 11:16:52 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f6a37cb9aesm66673173.28.2025.04.17.11.16.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 11:16:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, Simon Glass <sjg@chromium.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Marek Vasut <marex@denx.de>, Matthias Brugger <mbrugger@suse.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: [PATCH v3 07/22] fdt: Redo devicetree setup
Date: Thu, 17 Apr 2025 12:15:49 -0600
Message-ID: <20250417181613.1355024-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417181613.1355024-1-sjg@chromium.org>
References: <20250417181613.1355024-1-sjg@chromium.org>
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

The existing logic for handling receiving a devicetree from a previous
phase is quite complicated. Simplify it in preparation for introducing
standard passage.

Add a Kconfig called OF_PASSAGE which indicates that the devicetree
must come from standard passage.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add new patch to redo how a devicetree is set up

 dts/Kconfig  |  8 ++++++++
 lib/fdtdec.c | 34 ++++++----------------------------
 2 files changed, 14 insertions(+), 28 deletions(-)

diff --git a/dts/Kconfig b/dts/Kconfig
index c544f948a15..57101bddabb 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -159,6 +159,14 @@ config OF_EMBED
 	  and development only and is not recommended for production devices.
 	  Boards in the mainline U-Boot tree should not use it.
 
+config OF_PASSAGE
+	bool "DTB is provided by a standard passage, in a bloblist"
+	help
+	  Select this to read the devicetree using the standard passage
+	  mechanism, i.e. from a previous phase in bloblist using arch-specific
+	  register conventions. If enabled, the previous phase must provide
+	  the devicetree, or U-Boot will not function correctly.
+
 endchoice
 
 config OF_INITIAL_DTB_READONLY
diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index f09c9926a7a..8559616873b 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1689,35 +1689,13 @@ void fdtdec_setup_embed(void)
 
 int fdtdec_setup(void)
 {
-	int ret = -ENOENT;
-
-	/*
-	 * If allowing a bloblist, check that first. There was discussion about
-	 * adding an OF_BLOBLIST Kconfig, but this was rejected.
-	 *
-	 * The necessary test is whether the previous phase passed a bloblist,
-	 * not whether this phase creates one.
-	 */
-	if (CONFIG_IS_ENABLED(BLOBLIST) &&
-	    (xpl_prev_phase() != PHASE_TPL ||
-	     IS_ENABLED(CONFIG_TPL_BLOBLIST))) {
-		ret = bloblist_maybe_init();
-		if (!ret) {
-			gd->fdt_blob = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
-			if (gd->fdt_blob) {
-				gd->fdt_src = FDTSRC_BLOBLIST;
-				log_debug("Devicetree is in bloblist at %p\n",
-					  gd->fdt_blob);
-				ret = 0;
-			} else {
-				log_debug("No FDT found in bloblist\n");
-				ret = -ENOENT;
-			}
-		}
-	}
+	int ret;
 
-	/* Otherwise, the devicetree is typically appended to U-Boot */
-	if (ret) {
+	if (CONFIG_IS_ENABLED(OF_BLOBLIST)) {
+		printf("Previous phase failed to provide standard passage\n");
+		return -ENOENT;
+	} else {
+		/* The devicetree is typically appended to U-Boot */
 		if (IS_ENABLED(CONFIG_OF_SEPARATE)) {
 			gd->fdt_blob = fdt_find_separate();
 			gd->fdt_src = FDTSRC_SEPARATE;
-- 
2.43.0

