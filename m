Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BF2E77199
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 12:31:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24FBB80601;
	Thu,  9 Jan 2025 13:30:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nk65nttr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E015580654; Thu,  9 Jan 2025 13:30:46 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B567E80613
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 13:30:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-844d555491eso23312839f.0
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 04:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736425842; x=1737030642; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4XNkPBAakG207Jkd4Pz0rMcKBRIeLp9x0ZJ0mFZe9gk=;
 b=nk65nttrmWpL9bV3lOGkymzitmsaeWntqkptoyR5N6fM2VDVWUGQ7kM4zzmbq4a3dN
 A+iZ/rdUnjKO/oHqC0iCXh1NPEngjOPRgeeo3micO3hl5WkljReJcOB4y/1fD6CKyYZy
 hc8TcZE+/I3oBfnWB9mVlGt305bv8tknZbMv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736425842; x=1737030642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4XNkPBAakG207Jkd4Pz0rMcKBRIeLp9x0ZJ0mFZe9gk=;
 b=ru6bd6goebbg5Uw3Qpz2tH3FfumVIoG7/fTZvden+7+lMkhyEOlcw6OlQDBL4mUfCV
 NsMj73Xoki4fwIjeMbSpjxQNiJjTVKYjiOQ1k7zz8elSe0PuO5HR5qFjPFWC8aOsxW3j
 85dUIhTITR+xdt6O1Z/MjI24yrxOXi4Ntx0fUqkQEapXIoNzlexsjBCv69WGsuUHooU/
 wN+WUPX7AhYIefrhmt6R1INyNfEbhKU+6suFfUBMv7PYaveQThpANbMFNUdz8gLakSap
 v3m/KIHlvLRc+gHmOyImEdfZfC3xsX/Mh70VtfSo3kA1h3C5KBXzPa0aML62p7wNLG9+
 mRQQ==
X-Gm-Message-State: AOJu0YxraPXznsDDoAF+0nYoubFKINyNe8zY851OdCfjIVHuqj7HwuzM
 mbQ0GLNyqlX1n+in0SgTyvwMg0r9VmdUWRJ2yU0b78/p9DotvFb1qh1GNMgLhXuokU2/lD7DXgg
 =
X-Gm-Gg: ASbGncvXY1kftt6Jh/wqdDIhkdL1T7Ux2i9+ZbmnG47Zon0eem/3s6aBc/90bf0mrr2
 04qU5fhzjPtD/9SCYllyjyZTxDockHo1oia+zhseFOruzQ7qLz0sMM655YHfl9HhlRRK6A/R6NF
 FBkaHtaLI/rBU+nxfX71NgQ5Z23eKuYmhZebihJ8DTh5xIoTzJNSiOGWG/HEP5UQ+sFayeVwqa3
 omILYHuLKhenaF7x6a8rev1uOZP3tJHwvCmuE4ez1rbhIfc6Roll86aHnU5agnbqCL7U/BMY/m+
 EBeqanXHTynmwBMoWQ==
X-Google-Smtp-Source: AGHT+IFzbnREdkn0D9hSwXO3g2Rw++rcrGWAvdKSg3pasVS2m+aTGZCJ2StRNRGi34qOVUWUgqG3Xg==
X-Received: by 2002:a05:6e02:b44:b0:3a7:c2ea:1095 with SMTP id
 e9e14a558f8ab-3ce3a9a572bmr54672555ab.1.1736425841061; 
 Thu, 09 Jan 2025 04:30:41 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm281678173.20.2025.01.09.04.30.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 04:30:38 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 04/15] vbe: Allow VBE to load FITs on any architecture
Date: Thu,  9 Jan 2025 05:29:59 -0700
Message-Id: <20250109123010.4005298-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250109123010.4005298-1-sjg@chromium.org>
References: <20250109123010.4005298-1-sjg@chromium.org>
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

At present the VBE implementation is limited to sandbox only. Adjust the
call to fit_image_load() to remove this limitation.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/vbe_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/vbe_common.c b/boot/vbe_common.c
index d2d20cabe00..dfe44822430 100644
--- a/boot/vbe_common.c
+++ b/boot/vbe_common.c
@@ -91,7 +91,7 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
 	fit_uname_config = NULL;
 	log_debug("loading FIT\n");
 	ret = fit_image_load(&images, addr, &fit_uname, &fit_uname_config,
-			     IH_ARCH_SANDBOX, image_ph(phase, IH_TYPE_FIRMWARE),
+			     IH_ARCH_DEFAULT, image_ph(phase, IH_TYPE_FIRMWARE),
 			     BOOTSTAGE_ID_FIT_SPL_START, FIT_LOAD_IGNORED,
 			     &load_addr, &len);
 	if (ret < 0)
-- 
2.34.1

