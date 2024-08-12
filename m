Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1E0C52D7C
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 20:57:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7551386BF1;
	Mon, 12 Aug 2024 22:56:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YTkGHCjd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 997C1888C1; Mon, 12 Aug 2024 22:56:47 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6EAE88703
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 22:56:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a7a9cf7d3f3so557249666b.1
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 13:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723496204; x=1724101004; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dSPhPLrkOupbWWvPT5Cpp0+hW/YWwfV0IjHdf2GnvOk=;
 b=YTkGHCjdM9aFFVpmTXWBRB15dy8iTOVTKDXSBWXiOd0Qj2z2RHh2+DPHyj5k2yQT5z
 hpHfGjoNoLWlHPXKZYIPGPji4UdMuT4H65YA4PisnSu/BzLdk2GVx73m+eHwbSIizl7Q
 gKHfUEUSDY/epiaOUeN2Q/XQ2HA45gc3ZB5whXpxBsXdb8mdT6X5pKeHvlJljSu4vVPT
 asmcj5y1eNQoo7H62K06pMhe+BLjJc4t07WWVHfqOOap2iHEZ1Lxr25suzmoG17tgLNi
 kHyHSTefW2j9u5wsFDspSnscWqSTpxIOPW0Z0VVQltLo0MTkafyzLSOyFGrYC6vFGjuX
 /5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723496204; x=1724101004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dSPhPLrkOupbWWvPT5Cpp0+hW/YWwfV0IjHdf2GnvOk=;
 b=rj9D5po8ER5RgdL+/XkSsR/ugCe5pOwM/AaHmVkLC48dXDQacfXrmeOupkyEuEgbh0
 q/bayL3Oe0SAp2EJQyAHFzqy8okZm0j2Fqp+z4NtxL+1U9SLODsH2XLGs2iq0dmxOs61
 N61xRcr3KblBbd1uLhkFCNLZDe3uN2Xx8wQ2LNHIZ853FYly8zPVMLhpKtxdjXId+gVW
 jnX4691p8QfuVix0nfCBmadbYo4z9bhTKAnYkxul5oD84zFu/lKHj+kuB6K9abXGDfdE
 wiceTYI4fKFuLJzxG/ictZ8Uqny9PL8k8nAA2mOprb04QBDT7DoFotEqnt09PuHsQKZ+
 y2ZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlmGdIGaFvsTBbCIuXszLB7PJfiuJTDjdu5aTtrJD8KQApIRG9psH/eCBbt9l8OsW9VcnR5ki7iQvwaTW55Wzx1o4ypw==
X-Gm-Message-State: AOJu0YxMkj0Sn2wfObStkTkKIBNzV30JjDGNZWo6u1A11Es7NKux6/AY
 MQQGZI2XEIcMWGZ0MOXxoxLjZMlq67KJzhykJUfP1HVqFX1/6I9hvneiXMrpMUY=
X-Google-Smtp-Source: AGHT+IFzael6SCmBPPmpw3DzOQ+EYPNSqHv7/+wIBs3PMzNVzWLVCoYY4x7odcRFI2rGI7cz6DXh/g==
X-Received: by 2002:a17:906:f599:b0:a77:db36:1ccf with SMTP id
 a640c23a62f3a-a80ed2c87c5mr97191066b.42.1723496204041; 
 Mon, 12 Aug 2024 13:56:44 -0700 (PDT)
Received: from localhost.localdomain (ppp046103060252.access.hol.gr.
 [46.103.60.252]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80f411b51esm9491966b.134.2024.08.12.13.56.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 13:56:43 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: kojima.masahisa@socionext.com, u-boot@lists.denx.de,
 akashi.tkhro@gmail.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 2/3] efi_loader: rename efi_bootmgr_image_return_notify
Date: Mon, 12 Aug 2024 23:56:37 +0300
Message-ID: <20240812205638.1732159-2-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240812205638.1732159-1-ilias.apalodimas@linaro.org>
References: <20240812205638.1732159-1-ilias.apalodimas@linaro.org>
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

We use this event when returning from an EFI HTTP booted image.
The name is a bit confusing since it suggests we always run it,
rename it to make it clearer

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_bootmgr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index 181fc8775b96..03cdee15017d 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -421,13 +421,13 @@ efi_status_t efi_bootmgr_release_uridp(struct uridp_context *ctx)
 }
 
 /**
- * efi_bootmgr_image_return_notify() - return to efibootmgr callback
+ * efi_bootmgr_http_return() - return to efibootmgr callback
  *
  * @event:	the event for which this notification function is registered
  * @context:	event context
  */
-static void EFIAPI efi_bootmgr_image_return_notify(struct efi_event *event,
-						   void *context)
+static void EFIAPI efi_bootmgr_http_return(struct efi_event *event,
+					   void *context)
 {
 	efi_status_t ret;
 
@@ -533,7 +533,7 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
 
 	/* create event for cleanup when the image returns or error occurs */
 	ret = efi_create_event(EVT_NOTIFY_SIGNAL, TPL_CALLBACK,
-			       efi_bootmgr_image_return_notify, ctx,
+			       efi_bootmgr_http_return, ctx,
 			       &efi_guid_event_group_return_to_efibootmgr,
 			       &event);
 	if (ret != EFI_SUCCESS) {
-- 
2.45.2

