Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E38B1C77B7C
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 15:35:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F2B882E05;
	Tue, 24 Jun 2025 17:35:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="CwNhKU+I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E597E82C2F; Tue, 24 Jun 2025 17:35:12 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B36DD82D17
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 17:35:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 012333F595
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 15:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1750779310;
 bh=JaHh9Qmo4K97q9N8Lj6K5nO4EWSQks9vV7ft8SqrO0U=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=CwNhKU+Igwt1wKPll8VramjT3vprZB83cwYaKmqpgAU7S9OxIGD+xENtNrwN2G+ug
 vnafk6pao2QG45wNzJOOBZsoeeKh8EbJ6XQeP9shr5dmb7wjVkGWK06fYGa2scnj5S
 3IxQvL3k5NowGEzU5a74bjkZM937YaBPyE3gJmWeMOiMY+rSblYlkG+upzKCryJHnY
 JybEPoNbWjNM8Yp5ir4MnFZdiUZB8s3RPTj0opG2J4wfbVBoHmtpg4QpPYUSpxIKoO
 HxZH78sVOUKZqZSrdAF3M5pv0Rdp6eUK261EFiudaOi9Qc1OXvYtGjaszfV1VY8HJi
 tWyHX1omPL/+w==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4535ee06160so38911925e9.3
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 08:35:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750779309; x=1751384109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JaHh9Qmo4K97q9N8Lj6K5nO4EWSQks9vV7ft8SqrO0U=;
 b=o50hliIWD5+LLkhXZGtRYYxOLhz+Gb34N5pMOg3004O7eKCU+E5ZpfGILxAYugIFa5
 c/2c70e920mJguUzE7YeikdT7in2OQ+Li1r0x0nuSvXzfOxxQpXV/cW6GR7zjcoORNyi
 0fDsWd02GPDsS/xAuBnkeHEGcVmuHtbfNS+Rx40p9dI44xE3tnocYWboD2+KcNQE1u0C
 wjgp7A7fZ5rCR/+1cw4hBL/1gwLzWB9HmcEfAez4JtlXxpLroF7sPx9gKQAkD5shLfQm
 Q7PYdwaCtxKH40y4zD53wVYQU45NJa5VPJYx8GFRCE1c0WQ01DjMpyTNak6eLKgvbBz3
 15+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQSZtpe4LaMZP1ly7YGIgAXSlnVCYu0+DoWBngim+j937R6WD2bHSJQ6DlPLQCIA4foLKjuJQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzPya27FDMHmvfdNABO07PJcBqpTsPB+DnnnUXHsAEnRQcdQuaQ
 TcabUfzOXdiPnyA56RYhU7kSvWSk40HPB2bxiQllj7ImkKsacCbWUgPIGjrFgzcEDwaz/SSFCni
 1cffNcW/x8rIk7M3Shu3k3DOvLZKKbEBsnNlpRODeoMAbU1Oclg1CPeBjsWQbsXdezhcsVlI=
X-Gm-Gg: ASbGnctlu0wEQBVl13dP2QKlgFQ0U+Fw4pqZw14Nk3e2qAwdhKG2QJ/jPTRG40X1U4c
 dtJfqP31uO1sCXkmp3LrTj8tK3CxVKVeiDUKEqpWMsZe4yDiaCNgIhG802Le70q2xPOlnewqyRp
 OgzMsP8oP/RN9REgEMhzP6FtnJ+IwIAjYvWf6oeBJcy0rAIRSElFBLd2n/Ye5xOzMeg9b5Djjfg
 0flSYwp2q4WJO1wCUj5keNWDnIjmOiWFQiI4hK4YEATBETruDCs3OZ9H6FT70t/iFq7mR13qCx2
 wbM9FW/1AasGtx1rcusW+lFKqojpBIw6p82mbtR/lI9SFTsI5iECOcNV
X-Received: by 2002:a05:600c:6306:b0:450:d01f:de6f with SMTP id
 5b1f17b1804b1-4537c8bb475mr38795385e9.15.1750779308993; 
 Tue, 24 Jun 2025 08:35:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUlU3vR5vtkbFynOFACqpPC1/0iUeK4aAux7OWnrrik/tM9Vrbmo54PMC5P5gJHUACaR1IgQ==
X-Received: by 2002:a05:600c:6306:b0:450:d01f:de6f with SMTP id
 5b1f17b1804b1-4537c8bb475mr38795165e9.15.1750779308663; 
 Tue, 24 Jun 2025 08:35:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:3035:6e0:9801:7335:789f:7f15:8b3b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e8113b00sm2277019f8f.96.2025.06.24.08.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 08:35:08 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Sam Edwards <cfsworks@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/2] common/spl: guard against buffer overflow in
 spl_fit_get_image_name()
Date: Tue, 24 Jun 2025 17:34:31 +0200
Message-ID: <20250624153431.46986-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250624153431.46986-1-heinrich.schuchardt@canonical.com>
References: <20250624153431.46986-1-heinrich.schuchardt@canonical.com>
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

A malformed FIT image could have an image name property that is not NUL
terminated. Reject such images.

Reported-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 common/spl/spl_fit.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index e250c11ebbd..25f3c822a49 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -73,7 +73,7 @@ static int spl_fit_get_image_name(const struct spl_fit_info *ctx,
 				  const char **outname)
 {
 	struct udevice *sysinfo;
-	const char *name, *str;
+	const char *name, *str, *end;
 	__maybe_unused int node;
 	int len, i;
 	bool found = true;
@@ -83,11 +83,17 @@ static int spl_fit_get_image_name(const struct spl_fit_info *ctx,
 		debug("cannot find property '%s': %d\n", type, len);
 		return -EINVAL;
 	}
+	/* A string property should be NUL terminated */
+	end = name + len - 1;
+	if (!len || *end) {
+		debug("malformed property '%s'\n", type);
+		return -EINVAL;
+	}
 
 	str = name;
 	for (i = 0; i < index; i++) {
 		str = strchr(str, '\0') + 1;
-		if (!str || (str - name >= len)) {
+		if (str > end) {
 			found = false;
 			break;
 		}
-- 
2.48.1

