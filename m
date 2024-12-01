Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A345BD49771
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 16:04:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A71A89624;
	Sun,  1 Dec 2024 16:25:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cMz9B7ff";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDABD895CD; Sun,  1 Dec 2024 16:25:57 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52B398961F
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 16:25:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-84435dbda4bso20949539f.0
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 07:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733066752; x=1733671552; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iIFQDpqZB4N+8qQuVIxDkxP8ByUZC30JSzT8Ag/NWz0=;
 b=cMz9B7ffl2rJr7HcyuD5p5O2uscOb0aUI6opy1sI3VKtPG4FTFaXEC4EhLHiSBfFZW
 9Ch8w87Z4T7tXlTKR83pXKjzirrNdr00iOCJjtrBtHT2cyNBLMeaFCkoENxql5OFAWOS
 Cq14XP3ynX5pn4ccjiJNwSJGni7IZLUgfzSrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733066752; x=1733671552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iIFQDpqZB4N+8qQuVIxDkxP8ByUZC30JSzT8Ag/NWz0=;
 b=Vu2noBLu5dWtG2Q23pnP8cQWVC4sOJQ0y/N+AiEtFVLVlxejGVgTjz6lnRwYBDgqwh
 TeejnKyKcI7UZq8r7lGpb6t0TjgtZqnKHdSjQmAK8pDzkzWjeosRfvK5F/D3A/G1y4Sg
 yqAIKga01r9BfbZt6+F+1PG9PRlYcS6bepZKeUnrsOwiZCb4hNd6SjC93pnkdqV5s2JM
 CnqpJeBlUQG0hbRMepNIbcNVufFkjJxQE7WomG5cyUk7SaX2qeIupHGO1yY3eXTBTyPo
 oFWEPrcBymB2I2s4kg2zUjHuWXvUNMnCeSf2eKFAIg1H4JWjEpAcJMrfepZp119sBp7o
 lLmA==
X-Gm-Message-State: AOJu0YyWUajjXPgKXEK3K0bwnV7gUXwj9nowdv1f1iqY/czGlM50GPWv
 GWZgpCj9DECTd6NnuQ83JcVqeg1P4dhz4NjU1iTtgOXVYve0M2QYEVUNfd4cxILuqK3hCOzKgwM
 =
X-Gm-Gg: ASbGnctHn6QZRN6cte+1c1Hi3TWIDmI8BKLMMpigF7uNa+QFH75LOh8ZeH86yjIWp2U
 VoPsSpwdCfaoRi/Pg8ycrBTwCGT3AVPXLTZKBvv8DbkmGfogur48U+xFFUaA0vkR/10IviBhJnV
 bSY1mlFczfaJPac3BoSxKfCq/2kCmfQ2ZadQg9u0li0qWO3pZXJDUSoC6Dz35fup6MIv0t8Wztl
 XOGWmBxHM4kY9i2z4kKu7nKdSpPdYo7y4kZQzTRLIqw
X-Google-Smtp-Source: AGHT+IHLvA2q1MTsi+LV25fXAmI6ZOfa3puE38vemAelsThU3NyfpaOe1wxWDFfNa9qRo2lT1v3u7Q==
X-Received: by 2002:a5e:a60d:0:b0:841:9225:1f56 with SMTP id
 ca18e2360f4ac-84401589d4amr1191204139f.3.1733066752144; 
 Sun, 01 Dec 2024 07:25:52 -0800 (PST)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405ec8d88sm159755239f.19.2024.12.01.07.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:25:50 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 14/25] efi_loader: Avoid assigning desc in
 efi_mem_carve_out()
Date: Sun,  1 Dec 2024 08:24:33 -0700
Message-ID: <20241201152505.1666789-15-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201152505.1666789-1-sjg@chromium.org>
References: <20241201152505.1666789-1-sjg@chromium.org>
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

Rather than assigning desc and then changing two fields, assign all four
fields, for clarity.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/efi_memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 83f2e32b9a4..b51bb367899 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -268,9 +268,10 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
 	newmap = calloc(1, sizeof(*newmap));
 	if (!newmap)
 		return EFI_CARVE_OUT_OF_RESOURCES;
-	newmap->desc = map->desc;
+	newmap->desc.type = map->desc.type;
 	newmap->desc.physical_start = carve_start;
 	newmap->desc.num_pages = (map_end - carve_start) >> EFI_PAGE_SHIFT;
+	newmap->desc.attribute = map->desc.attribute;
 	/* Insert before current entry (descending address order) */
 	list_add_tail(&newmap->link, &map->link);
 
-- 
2.43.0

