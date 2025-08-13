Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C36CA0EE0
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 16:30:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1548D83564;
	Wed, 13 Aug 2025 18:30:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="o69BWTmQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00F3F829F5; Wed, 13 Aug 2025 18:30:16 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76AE5829F5
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 18:30:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4563cfac2d2so59190495e9.3
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 09:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755102614; x=1755707414; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5awczM3VlJiW0S78tRyi4f/OywjWEU0XzUCGgBt/P00=;
 b=o69BWTmQySWBVAxJ8wSRXQmkpqJAlTokYkvPsDCXn6bzSo44h1/o6WBlJfn5F8T/h5
 PdvRSUF0q3zjPocBYUryK2GipVNpK4tvtosFVcPQ4sXrYtLTp+DGaK0Etag9RrIleocL
 BjJ493djTdvlrepo51BPy9B1LLywI321L1BjKr0Vgb67qiK0CW124wtfhnjL/TXsQZVi
 DLBKoe6zvxcHLh3YQjksKmFQJU/ZP1VHsXVGjxvNwz9xARI0IlYIRAfHB5l3+02N3APO
 k9cnGgFp/b0UQJ8w8DwZ47vyUr1FmElitSxLsiTqMwfDggYPYSI/UiGqlCB8CRjyf8fX
 cz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755102614; x=1755707414;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5awczM3VlJiW0S78tRyi4f/OywjWEU0XzUCGgBt/P00=;
 b=VWnayObY2UGly2pg+8pom0koj4vCSTar/oqt0H9iEg61Hq5CfqMbMlWmlf2/ASlnci
 EC8N7k0UF/g77yLNYSOc5pR2tOSn0X0ghbPemRHdQKUCGjpLSZc/b83OqwzxNc9Fuqij
 W31M95k9MUp5Pd4ub7x7vaOttAUslUrvGd+HJ+hlgS7PUcZKB33ny5kYIGE9MG5qC206
 uywcwkA/o5+FWsdtVX9WbPxPmZHQGDkn+nys8rVIggi+ZFxYq7LcSDliB+8VjER4+SM1
 HG9AFJmshi7G4mH59BQ/YSeQsyEYxYA3LrU8sRCi26kdkH/eP1i870coUGRt9bNfAtvA
 00sQ==
X-Gm-Message-State: AOJu0YwUerIhjkUivuN7jXmHC5HBS81hcVsRzO7lcg7zeKDHfIq+yJB4
 Oq6tFvDChDvIWd4HOx1ikOtgSRUJZh3D/YWdmVzQ7qxAlseY7feu0hVfaDCGGYnDSyg=
X-Gm-Gg: ASbGncugto6k51ODchnuCUB8Vw/ztvKtOjdKeDkLQX2pENBtijCFXMmZPf5ImXTN5fJ
 7OzUZIOOrsNiCkOwW6z+3NeWeElw6DFu2PEnCNqBulXAyLM1ynrtjGP9NVhFT9/RZClJQxPQDOB
 6RZAAKriFVYOzoriiz3KxQll6zsACIc5olGTj/Av6lRaF8beZndmuMWyCJ7+fkZHFi+GMn0N8b3
 PgVc6hgo0xMyd/KyDYoqRXEBNtqQJaVlPz+csnCp9UB2/iUTRqFfWLRDgez94YciIZnG/qorYQW
 njNAfF5zJedvOXf+3T8fQ4uhWkJvlFkyy7PEHIX4DnEbqoOFKOFYAoxjiGF8Injbm0TzfkWK+it
 Fwgfw0qpD2hxB1MVeFjgAa6X3oX+tirOXkvnqkJpFecCyr6g8
X-Google-Smtp-Source: AGHT+IFatru/qqN4xd4WFk0/Uc4yejey7xaObi9I21TfAXkX9AitSdLTkkJXogeZHoe/IbTcALZvCQ==
X-Received: by 2002:a05:600c:4f8a:b0:459:dfde:3329 with SMTP id
 5b1f17b1804b1-45a165f7e8fmr37343985e9.31.1755102613833; 
 Wed, 13 Aug 2025 09:30:13 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:f76:d65c:a81:fe01])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1a520346sm7887355e9.13.2025.08.13.09.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 09:30:13 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 13 Aug 2025 17:30:12 +0100
Subject: [PATCH] usb: cdns3: Do not access memory after free
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-usb_cdns3-v1-1-3779912fe660@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJO9nGgC/x2NSwqAMAwFryJZW/Bv9Soi0tao2URpVATx7laX8
 5jH3CDoCQXa6AaPJwmtHCCNI3CL4RkVjYEhS7Iy0WmuDrGDG1lyVdW2qctC6wk1BN8aQWW9Ybd
 8D8Zr/+bN40TXn+j653kBYoyjY3IAAAA=
To: Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>
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

The call to cdns3_gadget_ep_free_request will free priv_req so do the
call to list_del_init which accesses the memory pointed to by priv_req
before the free.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/usb/cdns3/gadget.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index a30c40ef80e..9eaf7e40ab6 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -557,10 +557,10 @@ static void cdns3_wa2_remove_old_request(struct cdns3_endpoint *priv_ep)
 
 		trace_cdns3_wa2(priv_ep, "removes eldest request");
 
+		list_del_init(&priv_req->list);
 		kfree(priv_req->request.buf);
 		cdns3_gadget_ep_free_request(&priv_ep->endpoint,
 					     &priv_req->request);
-		list_del_init(&priv_req->list);
 		--priv_ep->wa2_counter;
 
 		if (!chain)
@@ -1959,10 +1959,10 @@ static int cdns3_gadget_ep_disable(struct usb_ep *ep)
 	while (!list_empty(&priv_ep->wa2_descmiss_req_list)) {
 		priv_req = cdns3_next_priv_request(&priv_ep->wa2_descmiss_req_list);
 
+		list_del_init(&priv_req->list);
 		kfree(priv_req->request.buf);
 		cdns3_gadget_ep_free_request(&priv_ep->endpoint,
 					     &priv_req->request);
-		list_del_init(&priv_req->list);
 		--priv_ep->wa2_counter;
 	}
 

---
base-commit: 7807ed921314cd7af83fd88162d0b8c6fb20a9ca
change-id: 20250813-usb_cdns3-67b975488fe8

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

