Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFE2FEE4F7
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 20:21:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B54183F70;
	Sat, 28 Feb 2026 21:20:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IqkuM78J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5B0483F64; Sat, 28 Feb 2026 21:20:41 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA0B883F5B
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 21:20:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7d4c383f2fcso1502265a34.0
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 12:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772310037; x=1772914837; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jbNJkDRJcyekcg8X+H1RQ3ImZsLFc+DL8SYDj/yAd1w=;
 b=IqkuM78JNPCfiVwzwQBYo/+R8mFv4Dquya5Qb4ShjqOSyk1PDUy2QBsDQSejTSQe9b
 8drsnfOo4OoUUWiWiD9dhCk6z9vs/TPz9gm1257E1rVzkCbsIDACMcIohMLFf0kokexP
 9C3uRbHvc4e178ivG8MNHDrg7YzDenDDPld4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772310037; x=1772914837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jbNJkDRJcyekcg8X+H1RQ3ImZsLFc+DL8SYDj/yAd1w=;
 b=bUnVEyPaI/i0VO4Pjl23I3fOXFyGwCz89KG0Ju4JgjPZv0jKKYRyCiRiPeegO0pJWY
 rrs1lxdyBSMChpqVzQi3KYyJCkzp+3YERYjy3yfidD0vf2KhWgjqDLeMMV4fQnM4fG3U
 TjSFUhvPv/HtfwImy9cvKDz7KZtQtbgBSKoqZK5Q9uhlegXWD3gDweQBrXkHEAkZIEMw
 buZ/kkO4RN70bZuM5Wlyhv0aQGHUMBcJ/H36BeSFtemQPZUjH+oXn8yQUlHAiP+J5Isw
 DWb+TPX+YrZQkGSMz65fwBvTvtCwDHrIQ4WKU5B25pK0xkc4H2gSHhQYyc2Lg0u2gxT9
 iwwg==
X-Gm-Message-State: AOJu0YxXQJkzjMxQVy9EdQ2DfWGqdr066kPlCau6je5GRyLsQ/d/fmvE
 8eQbvTXD3hLJ6vKeyScp41sCFizTNeICn/FDG4+5iFx7ymN4QOnWU5CYo+z90SQZf5D2yGqy1Ay
 eCwo=
X-Gm-Gg: ATEYQzxfKQzi4hzGkFBVxovezOgrz59I7sb2Z4UGWTPAF31uh+RNvndhwvqsd1bj+31
 JWDaHdzaPye9BmVabPbVj9F0U1G4LrxgvY+KhoslPyfzJQv50nYsXe2hD2/ERPck+/N34KlrK5p
 mtK9+hkLOHwhcUvyceLVsGOA7w7SXhBqAQR6SJNp0qowYOgOR7fuzOLeT5KmJp9SDJDhegG8y3D
 fhGlt9hQEvP0DQ74QE6/mAl+jURugHKgaYffnuUV1aDby+cJpy6ugM4+lSmhD5xYa1Wr/3HEwXN
 pMBJCYowBDxLvqjGBb6UxMEjcjgV3x/LASjy1j8NnET1VyZhCz3mgd1IaQRDe5lRrJ8QBcPRJgV
 RHdhrFDXBNrozeKJ/FYZwoy7pjRZjMROullgn4LQUwKdkonuriGkAQSHsmlqpC5sm31VNBXy335
 kf2YHX94EpSsuNe3VQtA==
X-Received: by 2002:a05:6830:6284:b0:7c7:4f2:e15d with SMTP id
 46e09a7af769-7d591b45e06mr5567991a34.16.1772310037439; 
 Sat, 28 Feb 2026 12:20:37 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d58644edfbsm6978361a34.6.2026.02.28.12.20.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 12:20:36 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Yao Zi <me@ziyao.cc>, uboot-snps-arc@synopsys.com
Subject: [PATCH v3 09/17] arc: Call bootm_final()
Date: Sat, 28 Feb 2026 13:19:57 -0700
Message-ID: <20260228202011.1834493-10-sjg@chromium.org>
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

Replace the open-coded printf and bootstage_mark_name with a call to
bootm_final(). This also adds board_quiesce_devices() and
dm_remove_devices_active() which were not previously called on ARC.

Signed-off-by: Simon Glass <simon.glass@canonical.com>

---

Changes in v3:
- Add new patch for ARC conversion

 arch/arc/lib/bootm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arc/lib/bootm.c b/arch/arc/lib/bootm.c
index 91bce5235a5..49cf437b8a9 100644
--- a/arch/arc/lib/bootm.c
+++ b/arch/arc/lib/bootm.c
@@ -58,9 +58,7 @@ static void boot_jump_linux(struct bootm_headers *images, int flag)
 	      kernel_entry);
 	bootstage_mark(BOOTSTAGE_ID_RUN_OS);
 
-	printf("\nStarting kernel ...%s\n\n", fake ?
-	       "(fake run for tracing)" : "");
-	bootstage_mark_name(BOOTSTAGE_ID_BOOTM_HANDOFF, "start_kernel");
+	bootm_final(fake ? BOOTM_FINAL_FAKE : 0);
 
 	if (CONFIG_IS_ENABLED(OF_LIBFDT) && images->ft_len) {
 		r0 = 2;
-- 
2.43.0

