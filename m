Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B32C83029
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 16:06:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B8DD80B9B;
	Mon, 30 Jun 2025 18:06:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eei9n+xd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24D8D809A5; Mon, 30 Jun 2025 18:06:15 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A61DE8206E
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 18:06:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-453426170b6so30194465e9.1
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 09:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751299569; x=1751904369; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=G+ymrSxpJ72qwuMlDLSaNnvZrsXg4cD+qInF1AmDOiI=;
 b=eei9n+xdOSac+dMG/NvKITbsFp5gLzGlmUPyupSK0oUMBGDoap32gIRZI6riyD6XxN
 ynmrH7uAJfTRlS7fOGyHR5I3O1Px/7O7vV/hVrGtj93MmdjJdG8eaN2opIvzZNxaaZQV
 ZzZBAJfpbZNkXHRxK0MhsMnxwta6cLLxVcRwLAeDgDKlVMv0o4wuiQoZ7hJT9ohQRZG+
 pIvV7KaLIUbOVslt0X9mbJdixjN4OD+zBreb9KSZYBH6KbmtAbm71EsHW075/DvhkwAQ
 0RTo9H1BX7AtRgdMQ49biEIE/6T5VFsk/+6Zc2AY5kQuDJdC1kWRiLP7aLBEy8FH3i0S
 xlrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751299569; x=1751904369;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G+ymrSxpJ72qwuMlDLSaNnvZrsXg4cD+qInF1AmDOiI=;
 b=Yt8jDlzd5Ibe/Kqy9slzpoMzZQyFoiQQsgAa1hBAGlCs+gc9sLc3EjhUGWB0+tU4ut
 vK4gqlWOMumVFJbMJgoMPgBMWuh3UuCZAysUKSIpqWBb1JjKfGErlU6afsj8cYxxndEP
 EmYFKB3sTDScmuIrnLnIDFuPaicq2SpPKOcocxi4AALrX9SD238XuRx+oAt5tFMA+Z/0
 hBziyAdI67QfqFZTjFyRf3qZyep8HI2RZsYeMjaTP6vDb4ZZAnOzkv/I3MTmn5vRWZRs
 VkqPuRCrUuHib4fklBF2k+bwQQ8bdMMs4Mmbw7InZCvA5srNJqGEmWTrXSUzdepmeq29
 FV3A==
X-Gm-Message-State: AOJu0YxqHD7NfabAK0+neEixT4Mmjd0qqR80CKGjzlB1AUDX0tWnM960
 UdUu37rHPWa10rdqMwoP3YuCCVby45dzKswdHhXiyluXkrGt1Lp6FrccsX5pf3gJ1Y0i/qLQJYa
 jxw/Hkhk=
X-Gm-Gg: ASbGnctV2zq/NPEZF5hWEQC46APJj7HDCXehklgi8SD+Lu+d75vVXAaAyD7jxlBOQaz
 GOPTuOV5MSSRe5d/OgsC+HiPuNZntyeTrxtClLjj4MffW+CWncXD7PAMLq1TXsEjDSDQQXXyLrf
 pF9K/3yHhf36WQ6WhPucvER9Uj/WNMH/QW5+WkNURzuexBLmiARxBZ8CI1MTM1JJA6QSTcWWIhi
 WLN9J/vPEsz0IAQd9eMbODyM8FPVTmlmv+mypBzsRfRE0aTBtmHPlRuYXCvRa0V+ht3x26s2X9W
 F7zF9DDKJcffbfNWmpd0gLawsTAAzfhHHKIhtRiWe+F1BbpbbTJhPCji3DLFWXtO0Mwspkqx5Kv
 KBXzAHKRJ3t1KNsc=
X-Google-Smtp-Source: AGHT+IFEq+/teqVExysx2/MMGjhhUIRDPTm7TIxTHYLadtKPFSHpysxzsumrEWWpqV39LVICcG1tZA==
X-Received: by 2002:adf:9cca:0:b0:3a4:e231:8632 with SMTP id
 ffacd0b85a97d-3af0f43218cmr139131f8f.12.1751299568894; 
 Mon, 30 Jun 2025 09:06:08 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ee3:2301:10fb:ba4d:cfb6:8c75])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e5966csm10878371f8f.72.2025.06.30.09.06.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 09:06:08 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 30 Jun 2025 17:06:07 +0100
Subject: [PATCH] boot: menu: Do not dereference pointer if pointer is NULL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-scene_menu_fix-v1-1-9ccb9a49c4d8@linaro.org>
X-B4-Tracking: v=1; b=H4sIAO61YmgC/x2N0QrCQAwEf6Xk2YN46gn+ikhJz9XmoVESFaH03
 736OMwOO1PAFUGnbibHR0Mf1mC76aiOYnckvTamzPnAZccpKgz9BHv3N/2mwmXPkHKsmalFgwT
 S4GJ1XLNJ4gVfxdPR9v+n82VZfvbZ+cd5AAAA
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

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 boot/scene_menu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/boot/scene_menu.c b/boot/scene_menu.c
index 17150af145d..9a6e37d1c64 100644
--- a/boot/scene_menu.c
+++ b/boot/scene_menu.c
@@ -508,7 +508,8 @@ int scene_menu_display(struct scene_obj_menu *menu)
 		return 0;
 
 	pointer = scene_obj_find(scn, menu->pointer_id, SCENEOBJT_TEXT);
-	pstr = expo_get_str(scn->expo, pointer->str_id);
+	if (pointer)
+		pstr = expo_get_str(scn->expo, pointer->str_id);
 
 	list_for_each_entry(item, &menu->item_head, sibling) {
 		struct scene_obj_txt *key = NULL, *label = NULL;

---
base-commit: 7027b445cc0bfb86204ecb1f1fe596f5895048d9
change-id: 20250630-scene_menu_fix-60640ea67c20

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

