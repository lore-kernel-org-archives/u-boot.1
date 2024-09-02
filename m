Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891D0C54FC6
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 01:19:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D747886FD;
	Mon,  2 Sep 2024 03:18:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aAgMuPgo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8250488A31; Mon,  2 Sep 2024 03:18:46 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA56088A75
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 03:18:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-39f4ff22a49so6273315ab.1
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 18:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725239922; x=1725844722; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bcP6BtqafScc0NdTztSLCjfNhuuO7jN51LuoNSQ0VeE=;
 b=aAgMuPgo1BXmLmqKxQPNqV5XuaS/f9PrnbWk8MT+oOqwlaXCb9sEPiJp/vPqxfkC5+
 1ltSdn5zwjMDeRCftsrSgfzadzlLEX+OzsLHtutB/wUgEzvygw1pfnZGeiujbrUBeDP6
 8PwdK2AKeXdXlSuVS9nrHA0seg8c0KIC+WCKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725239922; x=1725844722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bcP6BtqafScc0NdTztSLCjfNhuuO7jN51LuoNSQ0VeE=;
 b=umakw/XPxfVB3MduElYTjmszQNLBgPe705ZfLnaw4Ex69A51C6/BCeglSWbUVz3WFy
 vGreeeasiEPYDniDxZhunNhT5ztaJR2sk8ymuEOxLB+kq+7x1baZptI16VEIA3WSzh64
 FxRjq1dj1LOUeIfJuxhoCoOnmoQt4/ypEcU/sCDXMRzG/GkI+wDxLNgYPRkotk/rMZFg
 L/hUyGJQVD1aHWT7JrAWta8+c8Z7H50EHja6I0Cv/Ks9cOf13woHmFTm/d6OQlpsiDco
 GVtalxSVkRdcCbYVXrJsEMSMj+Ys9SWgigV10L4d68bcm0zHF2dHHLCApKknM7Ys4yXb
 Ryqw==
X-Gm-Message-State: AOJu0YyCFQsI5OQMKwGGareyrpwLttkso0bSXiJ9SLhO5RQCyqgeMhNt
 RwqCmp3uG9vSEExlMBfFCAV97P3vkcgZjKjB/gYmFYWhpsAm0y8gkANHZfy4W8Ow09ThcxFkobg
 =
X-Google-Smtp-Source: AGHT+IHfXVoEe3tZgRRs8KiJbof1kPWZmttOAiAcXBexl+38cG7H8ZpAxar9SxWWe8NO6xscR4MeMg==
X-Received: by 2002:a05:6e02:b45:b0:39f:577d:8979 with SMTP id
 e9e14a558f8ab-39f577d8b15mr39747375ab.22.1725239922236; 
 Sun, 01 Sep 2024 18:18:42 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39f3b03f266sm22925335ab.57.2024.09.01.18.18.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 18:18:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 07/14] efi_loader: Show the vendor in helloworld
Date: Sun,  1 Sep 2024 19:18:18 -0600
Message-Id: <20240902011825.746421-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240902011825.746421-1-sjg@chromium.org>
References: <20240902011825.746421-1-sjg@chromium.org>
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

Show the vendor name so it is clear which firmware is being used, e.g.
whether U-Boot is providing the boot services.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Reword commit message
- Use 'Firmware vendor' instead of just 'Vendor'

 lib/efi_loader/helloworld.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/efi_loader/helloworld.c b/lib/efi_loader/helloworld.c
index 586177de0c8..c4d2afcb40a 100644
--- a/lib/efi_loader/helloworld.c
+++ b/lib/efi_loader/helloworld.c
@@ -237,6 +237,9 @@ efi_status_t EFIAPI efi_main(efi_handle_t handle,
 			(con_out, u"Missing device path for device handle\r\n");
 		goto out;
 	}
+	con_out->output_string(con_out, u"Firmware vendor: ");
+	con_out->output_string(con_out, systab->fw_vendor);
+	con_out->output_string(con_out, u"\n");
 	con_out->output_string(con_out, u"Boot device: ");
 	ret = print_device_path(device_path, device_path_to_text);
 	if (ret != EFI_SUCCESS)
-- 
2.34.1

