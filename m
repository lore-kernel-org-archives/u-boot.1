Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E387CD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 00:24:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE2B98486D;
	Wed,  3 Jun 2026 02:23:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=binarly.io header.i=@binarly.io header.b="h50EGEKv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D06508485F; Tue,  2 Jun 2026 20:30:26 +0200 (CEST)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DB4084852
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 20:30:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anton@binarly.io
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-517654b8e28so11919231cf.3
 for <u-boot@lists.denx.de>; Tue, 02 Jun 2026 11:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1780425023; x=1781029823; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VviefAorRKqI4LLb5/qfeUUHBzlSBSfPYIuryRLjWH8=;
 b=h50EGEKv+E5IhxgGBesCsabykTyMUVuAg5vUetbwFMY2QX/S9aphMjOJQquB3/RxRj
 pCFjnYbuUbyti+HsuUEC+/Lj7ECfK0XhugasNy0SNnxU79NHevf+5X74keA5/UmpZxE/
 dZ03CDWBkOItTFj1R4Yb7Vans0v8naLhZt8df9K1Ec6vzvEiKTtzhjtrZbrTRZ6K78jv
 fFylgQnkE5KYEUDzkPiqSZkbwk5N6Y9XgrzjYwL6G+hEZ/yJSSuN32Dkn6k77e/smqTN
 0rmZjwalXdgwUSb0dpDR8+0lb+MgY5yz3JvAyEkM09yFpnmEJP4aKZvjHxhyqgai1NLo
 Wx6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780425023; x=1781029823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VviefAorRKqI4LLb5/qfeUUHBzlSBSfPYIuryRLjWH8=;
 b=EX3EtqbNmw7qPMo4U/FxNzJ7qqfxBEbamToT3WPyq6aYEUJ0OyHaZ7Y9HV2BkQMzDF
 Kc2rgj1rfmwZ305CosFQJ6XSzuen/sQsP/gxtyiXpQ2tbUmTFJOVrIgHQStCFcG5kR0p
 l9LuPHUeBtge8fFl203yZnsx/QLmQ/e/TTBoyxvQ9NzqUhWgxOWxq8ykYxNDppVFDp94
 wksdnJvq2sUCriYqrmd4enWoLb2lnVxbtBhQYErpvQtsJWmAspp+AQGNFuQzdx75seCM
 hSjfrUnAs3rHNZFYFxmw8XhbK49otO7Iov8l8hE8I38dHyqOUGmfl92Gm3jSHjCcbom8
 ENmw==
X-Gm-Message-State: AOJu0Yx2o29ep5ZJFaC/Ht2zytJ6JscZQbj3r1afZt2/W8ds4mu89xnq
 Gmx3nN4ABExqf4CU2wyv0EOWKEhthzrdYGHgI0FLOs64GfXZjCP/zO17ywA55pEgAWa1Rl9NZHq
 EK7TW0bPEsQ==
X-Gm-Gg: Acq92OEmtLXxI1RfRJGZPZe2LaUyNanV6L0Jw60vMfS/4nV8Euttf9mIsbS7+U7EjV3
 x5mITFm/VdE2XbJWhc1d0CnmylCT4bIHb0feGe6YvI9FoMqoJ221lzU8g5vqWUIW9RiWYgFiZVp
 /j31v1JdzLh90uthRvaWSgFgrWecSM3w+OjqC2A1UZNAAMctxZsoW2EW9J9puxkAcoFlyQE4ZAU
 wtlLRuExbZfxFWOPbM9F5D2cdkq/o/DJ+53hmU27AydjwzsbfZek5D/3OUEv5kYD9BxiCby8rEJ
 RXxDvb54m7xcgwWeGwkWEIbAOqQLeMXPeDZXiFKtOe/QR30GwurWHZ99ZbpM/aTMSqWNQ65XQOq
 oNyngAG34bKxeLk5qgjYT2AR9z/x3NLpLCJ8CybPagUW/JH5ovkBMyiFnUQdxEMsNMx74TU2dB0
 LCnTC3aCJW/tgzrZqbJwQMkHZX6yHYH6awpttIqMvLupub4KraiJOWDIN0
X-Received: by 2002:a05:622a:512:b0:517:6b31:8058 with SMTP id
 d75a77b69052e-51778711c2fmr3087531cf.40.1780425021202; 
 Tue, 02 Jun 2026 11:30:21 -0700 (PDT)
Received: from localhost.localdomain ([93.174.85.138])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf05176fd07sm27178966b.1.2026.06.02.11.30.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jun 2026 11:30:20 -0700 (PDT)
From: Anton Ivanov <anton@binarly.io>
To: u-boot@lists.denx.de,
	sjg@chromium.org
Cc: trini@konsulko.com,
	vr@binarly.io,
	Anton Ivanov <anton@binarly.io>
Subject: [PATCH v4] fdt_region: Check return value of
 fdt_get_property_by_offset() calls
Date: Tue,  2 Jun 2026 19:30:17 +0100
Message-ID: <20260602183017.63967-1-anton@binarly.io>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260527112443.13870-1-anton@binarly.io>
References: <20260527112443.13870-1-anton@binarly.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 03 Jun 2026 02:23:44 +0200
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

fdt_get_property_by_offset() returns NULL for FDT with version
less than 0x10. fdt_find_regions() dereferences the result without 
checking, leading to a NULL pointer dereference during signature
verification of an untrusted FIT. fdt_add_alias_regions() and 
fdt_next_region() also lack validation.

Add NULL checks before accessing the returned property pointer.
Also add a missing NULL check for fdt_string() in
fdt_add_alias_regions() and fdt_next_region().

Signed-off-by: Anton Ivanov <anton@binarly.io>
---
Changes in v4:
- Clarify vulnerability reachability in the commit message

Changes in v3:
- Update From and Signed-off-by to personal email

Changes in v2:
- Rewrite commit message to be concise per maintainer feedback

 boot/fdt_region.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/boot/fdt_region.c b/boot/fdt_region.c
index 295ea08ac91..0a9d47bb2bd 100644
--- a/boot/fdt_region.c
+++ b/boot/fdt_region.c
@@ -69,6 +69,8 @@ int fdt_find_regions(const void *fdt, char * const inc[], int inc_count,
 			include = want >= 2;
 			stop_at = offset;
 			prop = fdt_get_property_by_offset(fdt, offset, NULL);
+			if (!prop)
+				return -FDT_ERR_BADSTRUCTURE;
 			str = fdt_string(fdt, fdt32_to_cpu(prop->nameoff));
 			if (!str)
 				return -FDT_ERR_BADSTRUCTURE;
@@ -271,7 +273,11 @@ int fdt_add_alias_regions(const void *fdt, struct fdt_region *region, int count,
 		int target, next;
 
 		prop = fdt_get_property_by_offset(fdt, offset, NULL);
+		if (!prop)
+			return -FDT_ERR_BADSTRUCTURE;
 		name = fdt_string(fdt, fdt32_to_cpu(prop->nameoff));
+		if (!name)
+			return -FDT_ERR_BADSTRUCTURE;
 		target = fdt_path_offset(fdt, name);
 		if (!region_list_contains_offset(info, fdt, target))
 			continue;
@@ -520,7 +526,11 @@ int fdt_next_region(const void *fdt,
 		case FDT_PROP:
 			stop_at = offset;
 			prop = fdt_get_property_by_offset(fdt, offset, NULL);
+			if (!prop)
+				return -FDT_ERR_BADSTRUCTURE;
 			str = fdt_string(fdt, fdt32_to_cpu(prop->nameoff));
+			if (!str)
+				return -FDT_ERR_BADSTRUCTURE;
 			val = h_include(priv, fdt, last_node, FDT_IS_PROP, str,
 					    strlen(str) + 1);
 			if (val == -1) {
-- 
2.53.0

