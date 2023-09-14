Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3BBEEAA58
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 16:59:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 118B0870DC;
	Thu, 14 Sep 2023 18:56:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gtH4o8d2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 974198709C; Thu, 14 Sep 2023 18:56:54 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93B3086F58
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 18:56:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-34f7471b599so3814055ab.3
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 09:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694710611; x=1695315411; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q80hMvI0xHv4RSVyjF6IO9uAijPL98jvoGYWV/U9Ru0=;
 b=gtH4o8d2EPXDFxLNTONqwNJ+935nGIPXhiUZmivrdgZwSXy1JP8XmOMwhX38rVj9Bo
 VLlNd+wGlTFyRsxeXGYXiokYOMh6Gn6ZlolKL81SL52IRvKnozfYLDPRTj+m2k+c4SLd
 p9CI0f7ImbeqkBsynuOvjiBNqU04os5/+0Il8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694710611; x=1695315411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q80hMvI0xHv4RSVyjF6IO9uAijPL98jvoGYWV/U9Ru0=;
 b=MgMleE039t0nszsdYWxcT4jQhLBnXwyz0F/YNwO9OMsW7cMvtQe9X0WHLpOEraHDLW
 f2gr5GVDoV3MT2cpO3hw07bxKE0jfcRCgrd2/1EKDABkvdOf46XLUEeKjTQbJcG2DrrY
 7diV5F/6bP8pYHdsAVCJQj073E0Z5t33Sp9U4Pe0+7DJTUK6ABe9Bsu5Qj1jPCQXUffj
 iSadI9FrVnPSDtzpnc7ZY0kRYOFQpES/CI1HgGyen2IvDdu/Z5W3hYbU3QwytOCTJxZK
 XeoGADBJIZ6CPfDF4qLymgJYPiIl1BArOaf2dai0e8GajTo/CW40eKL9TIJTXEHIzwdi
 BVRg==
X-Gm-Message-State: AOJu0YyXN5fKhulMsMlHXGCO7Qnup10UtxjUX5+2+AGnb+dfwSOM8nYa
 P/G0KPp7Kf3Zsm7qmcVeO7DRWiP6HNj5Lhcejvw=
X-Google-Smtp-Source: AGHT+IEMnIXcywvZ9/2PmjjNxvl+rPp5CuND0vu7dtvCz3D+xCfgmHnyzP+/axpY99EioOInWYETKA==
X-Received: by 2002:a05:6e02:1b87:b0:34d:ff6c:3e29 with SMTP id
 h7-20020a056e021b8700b0034dff6c3e29mr7228808ili.31.1694710611246; 
 Thu, 14 Sep 2023 09:56:51 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:a8b6:76a8:ff58:a8be])
 by smtp.gmail.com with ESMTPSA id
 s20-20020a02c514000000b00430979b6aa5sm535339jam.0.2023.09.14.09.56.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:56:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 20/21] boot: Drop CMD_MTDPARTS condition for
 FDT_FIXUP_PARTITIONS
Date: Thu, 14 Sep 2023 10:55:58 -0600
Message-ID: <20230914165615.1058529-20-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230914165615.1058529-1-sjg@chromium.org>
References: <20230914165615.1058529-1-sjg@chromium.org>
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

This is not needed, so drop it. Also use a capital 'O' for the option,
while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Tom Rini <trini@konsulko.com>
---

(no changes since v3)

Changes in v3:
- Add new patch to drop CMD_MTDPARTS condition for FDT_FIXUP_PARTITIONS

 boot/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index a1592a74e62..235c5a7a993 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1476,8 +1476,7 @@ config OF_STDOUT_VIA_ALIAS
 	  exist / should not be used.
 
 config FDT_FIXUP_PARTITIONS
-	bool "overwrite MTD partitions in DTS through defined in 'mtdparts'"
-	depends on CMD_MTDPARTS
+	bool "Overwrite MTD partitions in DTS through defined in 'mtdparts'"
 	help
 	  Allow overwriting defined partitions in the device tree blob
 	  using partition info defined in the 'mtdparts' environment
-- 
2.42.0.459.ge4e396fd5e-goog

