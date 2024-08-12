Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB39C3DA7F
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 20:56:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DABD87DB6;
	Mon, 12 Aug 2024 22:56:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Km9Dj44A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2CB287C38; Mon, 12 Aug 2024 22:56:46 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0114087E9D
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 22:56:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4281d812d3eso47386175e9.3
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 13:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723496203; x=1724101003; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rhn0BE9ahqyPm2j1mQYO9hlkMjX8QPEfn+w8vdq9OR4=;
 b=Km9Dj44ABPJjt4aT8yMGSO3lb5anyowebMOQBgVkwn6EjVKG6U6uo2PW+sntjHHraI
 tGaLNSxCVHI7VoIprDsO3VyTSBbinDCYc7S0vcPV/v4O+dtgQFcHUfPGG99+zhftsfg1
 8sfZFFuqsgmCyrFH6NCfeWyeOYpCvCFlwzFIncF0B8OTMmMeuzLV/M8F/nJzZTUwbdpE
 +T+XEutOiCEjrJGrLLFFl3W7ryUIsQHdSVr3HIswg8ZZjwjuvGQu6GB9zo9NSx2gZ7K4
 dz7/qae+NHn2S7QA6eFqJwDxmHzO6C7RxRlL9uDG/pRW43LbT0ROLugLd2kWb8JaQjtm
 puvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723496203; x=1724101003;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rhn0BE9ahqyPm2j1mQYO9hlkMjX8QPEfn+w8vdq9OR4=;
 b=FgVyir09ighjPu9AahuJ7wD5BERCIYTbikDVyF7O1WhGINTrkuuQ+8OMcfKuzIXiJP
 zQeJtKbTLq4+m/sgTkJyXJ6WnvwxqFEQdRUXcjSCIDFfkdpZ6wLK3oeZYd3GTsKd5Wzd
 vm7lMr8eLLtSErHFyFS9mgCJXquRobIM2G6xmj+XiCpP4Z44mvRhbw2PPPSmwt3dCdK4
 qITzWlXn7Dtu9lACwACua9tRZfxk3+D1hY0+jbutyz7Zh5swtVJ37U9dgU/0kLyymyNk
 5ZLasSz/HcktGzwZYoyQ4Ndy7Nf7/IgYpjRoU6u/LUXg/IHOQPibAKSZk0BCQwhsOVB4
 6Puw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGzgW6EbqKrtRrvdL402VDXTd0vjiI7giYM+dnNsILSdcw5R5tNwk297cR0UmZyaJcRRHpv2A5esrkG0Y8m93FLEqF2Q==
X-Gm-Message-State: AOJu0YxJXVGfAb7CpsM+CYNEhWKuXsTOuMU/KEbZ8uYhU1kLfxFBMSet
 AiTuJhPbmZN1/7xCwH8o3tVRHgqb6mOxMDMVsZGHWSi8x+7k+ks+axZ2HOseuNo=
X-Google-Smtp-Source: AGHT+IEUnZZ/dLHRTTxatSPex+ymJYf9BxeNOL0KptZmR+ntwLLpaj+kbFBJAEPy5bqyEZ5Sap2/4A==
X-Received: by 2002:a05:6000:2c1:b0:368:3782:c2b3 with SMTP id
 ffacd0b85a97d-3716ccfa0e2mr1347250f8f.29.1723496202764; 
 Mon, 12 Aug 2024 13:56:42 -0700 (PDT)
Received: from localhost.localdomain (ppp046103060252.access.hol.gr.
 [46.103.60.252]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80f411b51esm9491966b.134.2024.08.12.13.56.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 13:56:42 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: kojima.masahisa@socionext.com, u-boot@lists.denx.de,
 akashi.tkhro@gmail.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 1/3] efi_loader: shorten efi_bootmgr_release_uridp_resource()
Date: Mon, 12 Aug 2024 23:56:36 +0300
Message-ID: <20240812205638.1732159-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
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

We use this function to clean up leftover resources when booting an
EFI HTTP boot image, but the name is unnecessary long.

Shorten it to efi_bootmgr_release_uridp()

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_bootmgr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index 589d3996b680..181fc8775b96 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -380,12 +380,12 @@ err:
 }
 
 /**
- * efi_bootmgr_release_uridp_resource() - cleanup uri device path resource
+ * efi_bootmgr_release_uridp() - cleanup uri device path resource
  *
  * @ctx:	event context
  * Return:	status code
  */
-efi_status_t efi_bootmgr_release_uridp_resource(struct uridp_context *ctx)
+efi_status_t efi_bootmgr_release_uridp(struct uridp_context *ctx)
 {
 	efi_status_t ret = EFI_SUCCESS;
 
@@ -432,7 +432,7 @@ static void EFIAPI efi_bootmgr_image_return_notify(struct efi_event *event,
 	efi_status_t ret;
 
 	EFI_ENTRY("%p, %p", event, context);
-	ret = efi_bootmgr_release_uridp_resource(context);
+	ret = efi_bootmgr_release_uridp(context);
 	EFI_EXIT(ret);
 }
 
@@ -544,7 +544,7 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
 	return ret;
 
 err:
-	efi_bootmgr_release_uridp_resource(ctx);
+	efi_bootmgr_release_uridp(ctx);
 
 	return ret;
 }
-- 
2.45.2

