Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E495E77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 12:31:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEF548061B;
	Thu,  9 Jan 2025 13:30:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fgqXVc92";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 248E680658; Thu,  9 Jan 2025 13:30:55 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2391F806D5
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 13:30:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3a817ee9936so2208985ab.2
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 04:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736425848; x=1737030648; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=syrF8fHhehgu3r84uWzxEx6vGQ1IJq6bqq33R3NY/8Q=;
 b=fgqXVc92OE9pb5pgwtRDEmbfk019/Gg4V/6LoQe17mQnrbVB6tU9+mh33B1+dfwWqw
 OdNN54n3ns7l7o+6UpTgIIlNC00+robtNx9E1rBXiAHeeBoI97chfo/ssyI7nPcWun+b
 BrwoaKg7ui++cfq01yvLtIE18VmGKu/bn3a8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736425848; x=1737030648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=syrF8fHhehgu3r84uWzxEx6vGQ1IJq6bqq33R3NY/8Q=;
 b=LjIx3/ZmZzOOHjzFKwq8Cp/qv+2tgPukU22Lb9dTsjhL1+0kPVVzvHRREZkU9Ck0ZJ
 yxFCXl66mi3OkXgxoUYXmwLsaNO3wyjBx0dY5cpX5fpdg9vUnqAaIkBxGjDK+k+OCTdd
 IjZH4RAFQUExiRhIseHBREiLQHTzQlEeO6v8ZPGpQlSab+iDquiO+FBn03epqESTWKlz
 XtXMETQkMaT6v3tWWIeW/c9TxvEZ151yzc03oSFIzH1+vjAshq7tmbpTgJFGnBpq7bv4
 SaD7rbJ/vbH6dLlJv6ErWHeD/Ahjl510zVgiy7Cg8RD56B1r4v8VPDScUWwUQP/425/M
 nmqw==
X-Gm-Message-State: AOJu0YzcwA4FXRXNBFb2B+iogQVzNLJcpGboDc6HTKu74mN3H2OfH74K
 gCX0bvHWe6aD7Q2lv/UuzFvrWeeVKWowRrkpBe0MKxpsl5V822v8VGOOKrxE31bFQhtUAZp2b6k
 =
X-Gm-Gg: ASbGnct2hLCuFaWWvL8AEwo/N/HC0qWB+hs07A4tufHtr/Rqhfln6VGnn8+l4Tq6qmK
 e10UMpXP8F6bsZwJZuxwICwJMeFc0AkT79jB+rupC+JrjbtPb6jz8SK27c43Xfsle7exZwMMMXK
 J53w7vCuVKeijSM9OfYiIneh/8UR2i4vJGh3UPg/UlFO4Kb4UVEcILY4/r6LWKRRdakTy68LAFy
 jHZLu9P84rMOnIiqI8ULI9k3X/4oSbWCRQpi9bx+dfuzzqXKyJb/Vx2WxLpanY2iWLYYhk9gu7C
 EcCvT5IYQk58NiJ2HA==
X-Google-Smtp-Source: AGHT+IEDrTu+9OdBk90ztozpumjIeSjT35zy8lStCx5C8XSx5DfVItQsAjevXahtVHmay+S4Ku1i3A==
X-Received: by 2002:a05:6e02:1547:b0:3cd:b013:5c12 with SMTP id
 e9e14a558f8ab-3ce3a9d40b5mr51444585ab.20.1736425847749; 
 Thu, 09 Jan 2025 04:30:47 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm281678173.20.2025.01.09.04.30.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 04:30:46 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 07/15] vbe: Allow loading loadables if there is no firmware
Date: Thu,  9 Jan 2025 05:30:02 -0700
Message-Id: <20250109123010.4005298-8-sjg@chromium.org>
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

In some cases only the 'loadable' property is present in the FIT.
Handle this by loading the first such image.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/vbe_common.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/boot/vbe_common.c b/boot/vbe_common.c
index 02e2c4ae066..4b297e780b3 100644
--- a/boot/vbe_common.c
+++ b/boot/vbe_common.c
@@ -96,6 +96,13 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
 			     IH_ARCH_DEFAULT, image_ph(phase, IH_TYPE_FIRMWARE),
 			     BOOTSTAGE_ID_FIT_SPL_START, FIT_LOAD_IGNORED,
 			     &load_addr, &len);
+	if (ret == -ENOENT) {
+		ret = fit_image_load(&images, addr, &fit_uname,
+				     &fit_uname_config, IH_ARCH_DEFAULT,
+				     image_ph(phase, IH_TYPE_LOADABLE),
+				     BOOTSTAGE_ID_FIT_SPL_START,
+				     FIT_LOAD_IGNORED, &load_addr, &len);
+	}
 	if (ret < 0)
 		return log_msg_ret("ld", ret);
 	node = ret;
-- 
2.34.1

