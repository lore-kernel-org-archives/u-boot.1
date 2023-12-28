Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D72EFC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 07:30:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86D668798B;
	Thu, 28 Dec 2023 08:30:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="cN+pD+Ae";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B635E874DD; Thu, 28 Dec 2023 08:30:32 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF6A687745
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 08:30:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F02B53F73A
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 07:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1703748629;
 bh=8zj09qb4O7Z8vS/xU0Gu0lwUD6asmJfPd39ugd23FKw=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=cN+pD+Ae52hc9D+rmjqTRbnJ7TyivfziQ4P0LFJeKHF57Lzi114/iKBTwQMKTzS4c
 Vn0KuU4/jDqFV04+bYMVvViAnY+RYfYvSMb2su4r7+gqkAxtw3Ahz3QuM3g7LwVOuN
 GZOlORreZVDkD9pAMh9hy85iiqrlEu5qHyhMXQzA5HL4Y66xZaFHSJ0ZeubLeEox2w
 O/3UuCse4lDDdEaITWwMekFHBNYrZsxgJ6mi3UIndpjE+lS5PIAaTS0HdbYIBa6yV/
 zU0OLveyuAxZJScj68p9cgqN3R9ZoGu8MQ9+krlOrymPPCrQEpcShccpwPt2EDPesH
 NPtvP5AK0VyUQ==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40d6045090cso5948365e9.3
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 23:30:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703748629; x=1704353429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8zj09qb4O7Z8vS/xU0Gu0lwUD6asmJfPd39ugd23FKw=;
 b=kxkhubcI6RS8c/YQI5iSZdKUAXMw0h1RxvFnBmzeIP5PiZvSoauYjdOzbv/iCV1WSY
 D9IGHW1agbyeMd1GHlbE23o6fZgFBoRZdS59gDZIti3qfNu3p7EJrlvJvd2m7huI2fEM
 uhuNYTD2d0aMK+64FLKn81cqly5x/gzckVuyHPZ6uyP7csYa5fCqhRxLpSAvCzFKn7AL
 pUyJdvpUl+LO/6oA0txfN3c7CE1AVPBpV3+sT086PS1c+mMcreoSPa15xQBeOosbZAVx
 xjbv/RPcpNA3CZ+xOcWjVpGkJ2KQRyXts55qEL9v7eBinX2AN1JLsN0IPCFU7B1Wv2Zf
 IJyw==
X-Gm-Message-State: AOJu0YydQSvKC/xWoKJ83bX7SQsNyuH2DmqxZiN0J5F8Quzy+AzubYnN
 rQxZ/pIwr8H37hqqRNF82y8ZSoqfzxdprSmA+fMHKjOLI3GoWPbCDMzDrnjLt3vy7RcTEYOdd0N
 gbRUqm01F1kngJs7bClLtdw6YzphSW6BPJ3QwtQ==
X-Received: by 2002:a05:600c:1c15:b0:40d:5bbd:a091 with SMTP id
 j21-20020a05600c1c1500b0040d5bbda091mr1667584wms.67.1703748628988; 
 Wed, 27 Dec 2023 23:30:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNSJdfMhNWarE0VvQ8B2FEI4l4d5dodMhZsBoJZ/Eh+KdhFdjbTwjRHxGhSVoVCJQq0hUrxA==
X-Received: by 2002:a05:600c:1c15:b0:40d:5bbd:a091 with SMTP id
 j21-20020a05600c1c1500b0040d5bbda091mr1667576wms.67.1703748628368; 
 Wed, 27 Dec 2023 23:30:28 -0800 (PST)
Received: from x13s.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 bg42-20020a05600c3caa00b0040d6b91efd9sm967191wmb.44.2023.12.27.23.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 23:30:28 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/2] smbios: enable setting processor family > 0xff
Date: Thu, 28 Dec 2023 08:30:23 +0100
Message-ID: <20231228073024.6508-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231228073024.6508-1-heinrich.schuchardt@canonical.com>
References: <20231228073024.6508-1-heinrich.schuchardt@canonical.com>
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

Many value of processor type exceed 0xff and have to be stored as u16
value. In the type 4 table set processor_family = 0xfe signaling that
field processor_family2 is used and write the actual value into the
processor_family2 field.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/smbios.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/smbios.c b/lib/smbios.c
index 45480b01af..550b2471f9 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -467,7 +467,8 @@ static void smbios_write_type4_dm(struct smbios_type4 *t,
 	}
 #endif
 
-	t->processor_family = processor_family;
+	t->processor_family = 0xfe;
+	t->processor_family2 = processor_family;
 	t->processor_manufacturer = smbios_add_prop(ctx, NULL, vendor);
 	t->processor_version = smbios_add_prop(ctx, NULL, name);
 }
@@ -489,7 +490,6 @@ static int smbios_write_type4(ulong *current, int handle,
 	t->l1_cache_handle = 0xffff;
 	t->l2_cache_handle = 0xffff;
 	t->l3_cache_handle = 0xffff;
-	t->processor_family2 = t->processor_family;
 
 	len = t->length + smbios_string_table_len(ctx);
 	*current += len;
-- 
2.43.0

