Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA158C369B2
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 21:17:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7680829A1;
	Mon, 14 Apr 2025 23:16:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="AD1sd24D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 799888214B; Mon, 14 Apr 2025 21:47:16 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 249138209C
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 21:47:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=samuel.holland@sifive.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22403cbb47fso50478155ad.0
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 12:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744660032; x=1745264832; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kOWHc8CksJbroqY2V7AwxDuPKHU7b1s9t02Psz2GmUs=;
 b=AD1sd24DH8QwrT9TG51KBAQ0oTODUn7jpYwVb4XBYDjdsi5pFXJFeHFrP2v68wmXEm
 +FchZauR5kgpA0cwp48IfeW7LnZKYU8yvFFiXLzVe9ZHMfQS1I2UdvPgfCT01J1uHNKU
 Ed2KLH/fVXbuEpNLCrdpNxxSn6BkWV1LEB4TaNV3R8IvU2Xz+mHyJhoCFFkTb8cKc2uC
 THeLj3wjVnH/jLXzPu/Ugnuzsp7RVqP0JiJNud6b6VJPZqexnDZ2fEkeYsAFZJf9fZ+f
 Bx/06xQSDNrvREP27RJllCOe1rRB9iIQJxfAO0HM2shEnD+gXGDfF8D05/I+3gELN+e3
 Fr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744660032; x=1745264832;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kOWHc8CksJbroqY2V7AwxDuPKHU7b1s9t02Psz2GmUs=;
 b=FejW/H2EJW7Dnke1N5LVFRlIvD4JHjivE6FkxuM2ThsnqE8Wu+WMKSob097ej+SRB6
 e/Kxoz+3krr5RrEBrf9ube6CnRfuhRKVXg3d/u4yQqhhdtbcBHbQYOII2UoHRlMiy0BG
 UDmzmI4cjI6hbJnZmDdTlpN7amk5yf30BFCLA3SmRrYGhRb0wsA/TqICglsW5Zk7VZ91
 G1+Bq7OwXik++bZKTPhxRnu/OHnubI7ZkYHoaXqmDJs1smE7CuQJHRBPh+xuF+EBYBWq
 z/2h8sqF+hgIsklYKSJ7tUQ6X1XCvm92q+iKYUHQHkWWn7Hq0RXogAsWxXQxLmPL19y2
 JOXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwbyzPw2rx5MTxMaPQ+ZyHqV8ug+7TSpTZDv/zsq8Wn+PnhVY2nUnhIJIP8JEzF1yGi8lIdO4=@lists.denx.de
X-Gm-Message-State: AOJu0Ywy25IpBgNr+ZcvXyRUuxZhwvncc+MK1UjqRrcbLoUZ1RNnGyGd
 XfdeCvintjUO+D0RCddQ8q8r0LE5+IlkdGn5VlQ3zW7SamPDax3JLk2MG2JKHmk=
X-Gm-Gg: ASbGncsGsI6eawoOarxCxldmSuF45pQ7fZ5EDtNhuZecEC8dfFta3ftiyXOEcori6Mp
 rT7kcs1vwgn5oAj0VFVWG6leJgwPanfUvERgSLO4yaycR2BjFEy8+Ltcvzz/MU5dkogr98XtuZ3
 Gl4OY200X19yabDUwjC60pEM2ADQWhNlzM5YMj1ssQcJ6kH/905pqz9y8dN9bVbUDEnItBLkQr1
 dpzN+Izwra6ltkBt831O5wh749v+UphCoQvQd5nppZBenViKmiQzlrARE0lvJ+8H5wvrEdBpOB5
 w/AmVKkhxVKaFZaTMksTQxCQ7vNIUVjhlrPq3g7VoG2Pjxjin7ofnzggIJ7PAD4FgIlEsuBHnA=
 =
X-Google-Smtp-Source: AGHT+IHPhbBD2tC6MalVDu2U5O1TOCux1RwPEGD2PYT+ShG/xgmIr+iJUjg+aIZWbLdn7FlOhgKagg==
X-Received: by 2002:a17:903:904:b0:216:2bd7:1c2f with SMTP id
 d9443c01a7336-22bea4b90b5mr166451645ad.18.1744660032598; 
 Mon, 14 Apr 2025 12:47:12 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230de19sm6987222b3a.124.2025.04.14.12.47.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Apr 2025 12:47:12 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Simon Glass <sjg@chromium.org>
Cc: Samuel Holland <samuel.holland@sifive.com>,
 Baocheng Su <baocheng.su@siemens.com>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: [PATCH] smbios: Do not look up children of invalid nodes
Date: Mon, 14 Apr 2025 12:47:04 -0700
Message-ID: <20250414194710.2096669-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Apr 2025 23:16:49 +0200
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

If there is no UCLASS_SYSINFO device available, parent_node will be
ofnode_null(). Calling ofnode_find_subnode() then triggers an assertion:

  drivers/core/ofnode.c:598: ofnode_find_subnode: Assertion `ofnode_valid(node)' failed.

Check for a valid parent_node, not just that OF_CONTROL is enabled.

Fixes: 44ffb6f0ecaf ("smbios: Allow properties to come from the device tree")
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 lib/smbios.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/smbios.c b/lib/smbios.c
index 7c9701a57f9..b8c2846277a 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -950,7 +950,7 @@ ulong write_smbios_table(ulong addr)
 		ctx.subnode_name = NULL;
 		if (method->subnode_name) {
 			ctx.subnode_name = method->subnode_name;
-			if (IS_ENABLED(CONFIG_OF_CONTROL))
+			if (ofnode_valid(parent_node))
 				ctx.node = ofnode_find_subnode(parent_node,
 							       method->subnode_name);
 		}
-- 
2.47.2

base-commit: 739ad58dbee874a3ad3bddd116e995212a254e07
branch: up/smbios-assert-fix
