Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7EBCAC5B8
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 13:39:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C317837E2;
	Mon,  6 Oct 2025 15:39:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="HFQKyLLd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4535483804; Mon,  6 Oct 2025 15:39:22 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD06C83734
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 15:39:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0B96C3F2C5
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 13:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1759757959;
 bh=gOp0lSSdM4Sv6VjLmQoVwVfU8dpFF13mgcS78iOWGzw=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=HFQKyLLdztjUqYid714RpItElvXi6YY0iMmtDIYxwKE+3u2TFq0AeCGAcRnm8mFv3
 jYonl3Ok7wF3jAdQ+1X0cuGNsF9AOacW4L/5F7bk5lMx7ajRdlpJ3KIQ39Lxt4swGC
 2TOg6VuLm+gLIiKtNmPJSIL8am1OFoHv+8XhdkX6qXaBfEYnEAgRBtDZ3QMw2emGqx
 BpksrySv+DHS5UBmrVXCup1zrtEruFr6f10LHgvqUbuT46OcrmyaHobFuXrqrPU+sN
 MtNOW33JOlJ5lr0K+unwZhXllhIFCPf80nf5ExRppB6UOi7xYOLkJwe9Vnt5ot3kcp
 AI8cQwNOMKP/+o0jtWDbnWSvHbpSPQUbrbg//KAAx1xYI9BZRGbN536xUWA5t/xnRq
 ySNiu2dibIbATJvmhxCM5vP7o5mQ9fCKERIYMKot4RnNVlnOotggDkVKaZ8oUtKY4M
 ugUqQuKeoR94ehLMmSlC/LejKGrnHA/5INCrr+pESBp3/CYCvH2QggQqx/Xteq4q3a
 Y218ZOXB97LApxal6VBtN/hRQMKnAvVV7Na8YGbTU1+fjQbq8Idcs0/jj5dM+OtMQT
 9az33A94Lt31zSoMogXafzzmo0i8vy3ZqkytSnpklaeFZmXEMqOWSq5k6oCpw8kAKX
 R3lWK+VvQMuhHUhIovSorBXc=
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e4d34ff05so23936905e9.2
 for <u-boot@lists.denx.de>; Mon, 06 Oct 2025 06:39:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759757958; x=1760362758;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gOp0lSSdM4Sv6VjLmQoVwVfU8dpFF13mgcS78iOWGzw=;
 b=pu00qT/a6/1qGrzsbomGYXR/9bRv/Xf1A0In4xCLUkdJtOQVBC3qq6mHXsEkq8RySW
 NV0+tdZfw24ykGWmOZGCkKp2RmH/d7FSQDypORJzEiXD4S6bzT9QNjvumhoV+kMxv838
 DmVk/FsStALM5TIZpt8/O4/pOlT0NfLViTxdFCoIll0X1OZ2hySLCgBrUHwUV0IobgmH
 +hE3Lvh+B49RuF8PaBS26EKCpC/HalJ335yNjHnIBiqiBwVILzGqeEJc2ui70bKVPLpF
 +1nMP/HWN05OFgIVtWNO2vcMUeuWQnRe18dWJEURm+RDaDqAcQcqByyZWGIAswQDQj0d
 FCeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbDlWlMW0MDCKHihwBPRd2FI2nelrZZ7ClSXEAw6A3RPfo4W1N2SMgxFua2y5U3ke1JHi0RiE=@lists.denx.de
X-Gm-Message-State: AOJu0YwmhSvy6uqrxApvxTGNE8ElyA9VRempz+J9yBJMDwUVGhDtl2Dy
 06ZhVBpYQDXAdSGl/RQBUh0xVDuxdvmX2bn8inEvJdlEm21UNXbBUx/7NebQwYH/c3Vbl6uC1Se
 JDCgDSGcP5EBuebHW12OHKMsrQGOjMMMUnVXNbEMKDrg4nBViitc8yzLOXG+cFKPJ/fvGa8U=
X-Gm-Gg: ASbGncuOo4SyzuzQu+ZfeWQiPx0r5jrXSU4kD6NqtqWXrDO/KEQMgImYO4wStoAAHfM
 Cq9GVu14U8cH/S2j40Dw10M4YzViSRsDFiyuxr5tzK4NTF72TKIWhthE/LeH5H75oDCy7NXahwA
 4EJ1wi2Z38Cs0ErPwrzY3eTF5UPa98aGUMbEpPicQV+c1t9rnPHWUanRksyKTrRQOZFe1sfBMHe
 j+PoidsaqxdSIdWCRslE/GJraTGvH/c6YlUljl5NrW4e6XX5R2P+JaR2v7mvnaEgRvfRnd7UB56
 IceZGIhKxWMnHcAjqezSQ1wbcu24psqi+mFSd7Qk35N1HzZRORz+tNUq2yX36qvVs56rlCOWafy
 THjSdbKc4LNMESYXbl12p74xTX/fHqWBXw8JO
X-Received: by 2002:a05:600c:5490:b0:45f:2869:c3b2 with SMTP id
 5b1f17b1804b1-46e7115cfc4mr89493665e9.33.1759757958334; 
 Mon, 06 Oct 2025 06:39:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2b6BpiAByMQ8wlk3m5zqTu7je1+7aAAQVCPfB1Z5nLw7IXAmVmNN8JrN2I0g8t7u6BTxIjw==
X-Received: by 2002:a05:600c:5490:b0:45f:2869:c3b2 with SMTP id
 5b1f17b1804b1-46e7115cfc4mr89493405e9.33.1759757957914; 
 Mon, 06 Oct 2025 06:39:17 -0700 (PDT)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e61a265f6sm255742955e9.20.2025.10.06.06.39.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Oct 2025 06:39:17 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Adriano Cordova <adrianox@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: correctly check if the HTTP protocol is found
Date: Mon,  6 Oct 2025 15:39:03 +0200
Message-ID: <20251006133903.58357-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

In function efi_http_service_binding_destroy_child() phandler is created as
as a local variable. If efi_search_protocol() fails, phandler will hold a
random value from the stack. Even it is not zero, we must not use it.

If efi_search_protocol() succeeds, the pointer has already be dereferenced,
so checking against NULL makes not sense here.

If ChildHandle is not a valid UEFI handle, we must return
EFI_INVALID_PARAMETER.

Use a single location for EFI_EXIT().

Addresses-Coverity-ID: CID 531974 (Unchecked return value)
Fixes: 5753dc3f6572 ("efi_loader: Prevent dereference of uninitialised variable")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_http.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/lib/efi_loader/efi_http.c b/lib/efi_loader/efi_http.c
index 9a0f2675132..2a606aa441e 100644
--- a/lib/efi_loader/efi_http.c
+++ b/lib/efi_loader/efi_http.c
@@ -460,14 +460,16 @@ static efi_status_t EFIAPI efi_http_service_binding_destroy_child(
 	if (!child_handle)
 		return EFI_EXIT(EFI_INVALID_PARAMETER);
 
-	efi_search_protocol(child_handle, &efi_http_guid, &phandler);
-
-	if (!phandler)
-		return EFI_EXIT(EFI_UNSUPPORTED);
+	ret = efi_search_protocol(child_handle, &efi_http_guid, &phandler);
+	if (ret != EFI_SUCCESS) {
+		if (ret != EFI_INVALID_PARAMETER)
+			ret = EFI_UNSUPPORTED;
+		goto out;
+	}
 
 	ret = efi_delete_handle(child_handle);
 	if (ret != EFI_SUCCESS)
-		return EFI_EXIT(ret);
+		goto out;
 
 	http_instance = phandler->protocol_interface;
 	efi_free_pool(http_instance->http_load_addr);
@@ -476,8 +478,8 @@ static efi_status_t EFIAPI efi_http_service_binding_destroy_child(
 	free(phandler->protocol_interface);
 
 	num_instances--;
-
-	return EFI_EXIT(EFI_SUCCESS);
+out:
+	return EFI_EXIT(ret);
 }
 
 /**
-- 
2.51.0

