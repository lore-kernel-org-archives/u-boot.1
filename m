Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 845E5C7EE30
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 09:24:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA85782103;
	Wed,  2 Jul 2025 11:24:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nRSr5bQv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C3D382B18; Wed,  2 Jul 2025 11:24:20 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 632A280E9A
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 11:24:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-450cf0120cdso42203145e9.2
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 02:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751448258; x=1752053058; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=D+fQaXoqgUBJiFHPrJkOyS7dUpX/wWbaJwAKSJsKSv0=;
 b=nRSr5bQvsHkJlkbCnyRtIbjXxO6j8xHAUiCzdET/iGDhKGJQ/fVBvliaT7he1MoWPS
 pvJOgaEOatLTtusUPzeqQlk0oEyj/715A+EXpiN4dsPIQxgJcHks5tN/wL07Qt+1yWfC
 uL/MR0Ktjt+f/mpMHMB8287NxxKwvlXxI4/0cUoKSC6SiU0S9MzAVlKmTRk+eW9vf/D7
 wspVlD61pis4495UQxyaTsYjsOba1HIWq3VzptyNMHnWfTN/msomh0hZsSd8fUtCoVyZ
 AdIFhOb1dDzwnFuw4seW4nW1tVc/PJkkIzAOgCUcPzKY6eKHofllfKeVmb4DdupsM5dZ
 UGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751448258; x=1752053058;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D+fQaXoqgUBJiFHPrJkOyS7dUpX/wWbaJwAKSJsKSv0=;
 b=Esx2ODHG2eeELz5aBWk6iv6S4jymsoHcwsqwBmt38lpgmDPwSCKuY5Ow25uWRPApQJ
 LWgVdM7rJqUlnRV0kz1EiMFES0Ey/Fptsa22ydBpG6XOSbKwjuhQVnPrqgNysZ+2uZuL
 mPJNEd5zC9iTyt0M3lQSptBDwGXuIIi9D7rguvvSs3YzDIklQ3TvrWw/LqWW9lD1Y3iG
 adzK8NR5Ca1gQMG2uYWoCPecb4PXtOkpr8F+Z7EFDMqambulAeE+FiThBu2IAVm5Yip/
 Y6tC9cpvXHX1k5HsSRbyGfxi1a6iFT7NjKS523DtQkILkZ8ygr7ADFTMTNt53Dv6qGTa
 iKtQ==
X-Gm-Message-State: AOJu0YxdSPWKcS0r0NlccvZ1pPymcY3ePTXo56/YzgTlRlGm7oLkh/1d
 U7om/Iwf066mw5wj4/ckGJ0abrINJQhLr7F8s374IrOZPheoriTocoiYUOMoGKAqZ+1qV4CD4/g
 Msscn
X-Gm-Gg: ASbGncu1u4iTgA33azOZmGqeFXrwtvSkfgy0NU3YH9I7dMKbkVmakzssXjU66u7VK7P
 ahJbXLWDwLf3VFaV2hBOzs95snWF9yUymVPtIc4trZB66jyuuRPynjEnoBzuFIAEwJfSWKup3yr
 i8YpCMCp8FHbBN+EOpaRAxfsRZAKFPmR/TWp8mNSAJ2gDslmOMWI8k6Cv2jAqTDLAM2Dsf99xCn
 OQ/6VL4J8iOLQyOwj0JZNxI1sIHpyzDHK4n8/HMZDl3KqMCBmcaz6Jkq3xSazGMpZ5L2Vhyj8PV
 3r2oeRREgBIkBkWpgYuZLa3TvaZ+PJBORs24SqIx0Jy3NQzas4T6oXSSLQzZAeQlgYw880gs3/X
 3gw8WTeJIO/NNNg==
X-Google-Smtp-Source: AGHT+IFFSKxF0mZxSdIeVtwNJx+lnjx+zgYFL1y+Bx66NYuiyAg6NxwzGfFIsE+3XTehMqQeqmvwQg==
X-Received: by 2002:a05:600c:6818:b0:442:ccfa:1461 with SMTP id
 5b1f17b1804b1-454a36e3ec8mr22802145e9.13.1751448257659; 
 Wed, 02 Jul 2025 02:24:17 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:e07:801:2aa3:3d9f:604c:fc30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a423abbsm196918255e9.39.2025.07.02.02.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 02:24:17 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 02 Jul 2025 10:24:16 +0100
Subject: [PATCH v2] boot: menu: Do not dereference pointer if pointer is NULL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-scene_menu_fix-v2-1-7d9141a45a63@linaro.org>
X-B4-Tracking: v=1; b=H4sIAL/6ZGgC/3WNTQ6CMBBGr0JmbU2pWIWV9zCEDMMITaQ1UyQaw
 t0t7F2+7ydvgcjiOEKVLSA8u+iCT2AOGdCAvmflusRgtDlre9IqEntuRvbv5uE+ympbaEZ7IaM
 hnVqMrFpBT8N2GzFOLFvxEk773XSvEw8uTkG+u3jOt/SvY85VrkqitsSipKK73p7Oo4RjkB7qd
 V1/9rj4bsYAAAA=
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

scene_obj_find can return NULL but this is not checked for before
the return is dereferenced. Add a NULL check.

This issue was found by Smatch.

Also add a NULL check for str.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Changes in v2:
- rebase to -next
- Add a NULL check for str
- Link to v1: https://lore.kernel.org/r/20250630-scene_menu_fix-v1-1-9ccb9a49c4d8@linaro.org
---
 boot/scene_menu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/boot/scene_menu.c b/boot/scene_menu.c
index 8db6a2b2f4d..23404172093 100644
--- a/boot/scene_menu.c
+++ b/boot/scene_menu.c
@@ -571,14 +571,15 @@ int scene_menu_display(struct scene_obj_menu *menu)
 			return log_msg_ret("txt", -EINVAL);
 
 		str = expo_get_str(exp, txt->gen.str_id);
-		printf("%s\n\n", str);
+		printf("%s\n\n", str ? str : "");
 	}
 
 	if (list_empty(&menu->item_head))
 		return 0;
 
 	pointer = scene_obj_find(scn, menu->pointer_id, SCENEOBJT_TEXT);
-	pstr = expo_get_str(scn->expo, pointer->gen.str_id);
+	if (pointer)
+		pstr = expo_get_str(scn->expo, pointer->gen.str_id);
 
 	list_for_each_entry(item, &menu->item_head, sibling) {
 		struct scene_obj_txt *key = NULL, *label = NULL;

---
base-commit: 5ab660663ded12cd6e063933016d27c9eafda2f3
change-id: 20250630-scene_menu_fix-60640ea67c20

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

