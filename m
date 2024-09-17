Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5513C35FFC
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 09:02:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E38088D54;
	Tue, 17 Sep 2024 11:02:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="m9VaJMEX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F03CB88AAC; Tue, 17 Sep 2024 11:02:28 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8ADB88875
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 11:02:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a7a843bef98so550929266b.2
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 02:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726563743; x=1727168543; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1l1VSnhkTHTx6roKF5FnJSflHZFYfWheMEVUrJVeX30=;
 b=m9VaJMEXiDIVo9cg7ODyEXhllAeQgaQ0tOaAh7tEew6q7J7Yu6rfCy48jLfMJYGQWH
 Xsq35fhJgteGuKD/cMhpOM5Kdwc88h8GO+xpQKPan3/B4ZRbWtnlxwGL5xRpBYbDhPwy
 6qkghlHQUOzes/ZBN1eEtqFpLPAK5Y69RwNkUewj/LREGnn6v43EuM8ApjAnQXF1Mw0c
 grN/BhRrqMhJBuK/nBEpPcZkD+mGE7AqfFie5fGHFKlaJkGAybaYn/UcR3r9oGVQRuk6
 aqjtTLmgnXo8/JZQc09I78x1mra5p9vHmY+bmoQ9+2FWsU3DzSwVQuFSEKoQgqwcK0SI
 CdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726563743; x=1727168543;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1l1VSnhkTHTx6roKF5FnJSflHZFYfWheMEVUrJVeX30=;
 b=NsaB31AE3Obko1bZ3tVFbjI0cP2MFYOOziF6CVV0P3JNm9HVvflIXtNkX9xhWDxiaC
 IsdE0y2bOVTB7sA2kFCmqgjgTyzcdpgJpXLyuxKA6Q3lCRBmhL7dv/Z/H+mc7tbVscYA
 ZVg1vlSgk+rH2Oe8GP2ytaRPD+fq7OueosVRvwzzLiY1P44INZgs4XP1ol43J6EUNDLa
 xIWniDqzympXJmUaPcYG5sX10OJr/tUOw/IkcoR/JkOtW9RCu2y7//Z81z6i+xjR672+
 3mqQcN+Xyc8O4kDAkhRixymC5p7fSXb0Vfb3RSmeoZ2g+PRmU9ZUUhoXiV7wxJfdDE3v
 j/AQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjT60h2UnJmHiJas3SUhgkQvkA41XSBbeDvBc+bn6eDpeAg5M2DjyymU14JwKgt+ZrdGosiBg=@lists.denx.de
X-Gm-Message-State: AOJu0YyTabwAfiZz2fJ+85Ue5EFDYfqYj3TYE89k4LghpkjrwicUh5NW
 1oeuMkQWuaidIxWr8fQSAeNkqwcMt4DcSB0zg/bN/0t5RNndDbvr1bcG9LeBpGA=
X-Google-Smtp-Source: AGHT+IHE7bcxZnir+WtveOvHdN3ULeAMkQxC0ksmN52b245mg0jhGRc7/sGC6k02Pc3ySOeLVIY1OQ==
X-Received: by 2002:a17:907:7ba2:b0:a8d:e49:c505 with SMTP id
 a640c23a62f3a-a9048108047mr1295232166b.45.1726563742664; 
 Tue, 17 Sep 2024 02:02:22 -0700 (PDT)
Received: from localhost.localdomain (ppp176092143132.access.hol.gr.
 [176.92.143.132]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90610966aasm419239566b.26.2024.09.17.02.02.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 02:02:22 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: [PATCH] efi_loader: Don't allocate from Special purpose memory
Date: Tue, 17 Sep 2024 12:02:18 +0300
Message-ID: <20240917090218.77246-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The EFI spec defines special-purpose memory in §7.2. That memory
serves as a hint to the OS to avoid allocating this memory for core
OS data or code that can not be relocated. So let's ignore it when
allocating from conventional memory.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_memory.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index c6f1dd09456e..74732e37f8aa 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -422,7 +422,8 @@ static efi_status_t efi_check_allocated(u64 addr, bool must_be_allocated)
 
 		if (addr >= start && addr < end) {
 			if (must_be_allocated ^
-			    (item->desc.type == EFI_CONVENTIONAL_MEMORY))
+			    (item->desc.type == EFI_CONVENTIONAL_MEMORY) &&
+			    !(item->desc.attribute & EFI_MEMORY_SP))
 				return EFI_SUCCESS;
 			else
 				return EFI_NOT_FOUND;
@@ -460,6 +461,9 @@ static uint64_t efi_find_free_memory(uint64_t len, uint64_t max_addr)
 		if (desc->type != EFI_CONVENTIONAL_MEMORY)
 			continue;
 
+		if (desc->attribute & EFI_MEMORY_SP)
+			continue;
+
 		/* Out of bounds for max_addr */
 		if ((ret + len) > max_addr)
 			continue;
-- 
2.45.2

