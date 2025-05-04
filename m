Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD1FC3ABAC
	for <u-boot@archiver.kernel.org>; Sun,  4 May 2025 13:25:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAD2582A46;
	Sun,  4 May 2025 15:24:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GUc4Tq7X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E318782A8B; Sun,  4 May 2025 15:24:23 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA64F82A27
 for <u-boot@lists.denx.de>; Sun,  4 May 2025 15:24:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ac3b12e8518so609588566b.0
 for <u-boot@lists.denx.de>; Sun, 04 May 2025 06:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746365060; x=1746969860; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4pnsMOYd0SvjozLZMGs6BO2b5x4GMxcVsGYoUZ9eQK4=;
 b=GUc4Tq7XrmPxVLMQnb6d7G+jWjaRqA2bgtJd3eklLYsHlMsXzNGXemZpqtbGPbSt0b
 zghwLMGPmEkI3lSV2EyBkAQiUDTjlleYVyz6p4Gy3jY83HOmCUJ8q0TGpa5LnqAor8d0
 CPU5uktQs2LdUqDzn5jl7ekWh2qL2MFRqlq1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746365060; x=1746969860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4pnsMOYd0SvjozLZMGs6BO2b5x4GMxcVsGYoUZ9eQK4=;
 b=I9jojgS0E+1ISayMtSoBJbU6JeJoZNT3atl0OIqq1klPa1vHVdbcMDrWuGKKnRNl7q
 xwmPvW5KlqZC6K6Hm9B/dqFP81ynmTQ/bVxbo6A7wMny+OwcpUxAwLIRpNAx/KvRanMZ
 bGG5fRJW33/Zip5lM7VH6NOJCaFZXTeRIDDzH0ytRDBeMvaqDpDxUO5RlGuIb/Z47BY2
 QxQDj4wn7b77bimP5+7pa/sYNv/pfJYDgZh9XKsHe+IcRgG46VqJ1gTgUbgeCtKfsDWK
 z8hE4GZWqRbpTVzOrsZUIAjc6k3PY+YbP3InAmqQ61+NIZROo2iMUyktGQLpQfTYOCkZ
 DM6Q==
X-Gm-Message-State: AOJu0YyqtMKvONn2ePVs0NoXcv6ZyZvM1YqPrWvHuz4tdERXDUxITdhz
 Xo/7kCiwfeSWl6WdZV2NT+4+8uKQPj/phofn+EeMd9QLjLS0p274q0rbQP8rRlPf3gLyJOqazHE
 iAJKRsBU=
X-Gm-Gg: ASbGncvD9PTeXZSbzFDLkQFtO696hag7NYW3qm5e5rEeX5Hq/Zv7UOQojrfPCCwmBjs
 gE3BHbmRKXm7a5f/Ge6EbbEoYAddx3u+dE/7JYii3MWw4zRrpnt+V/SPNIrTceR0wuq6b7mmk+c
 9Cgls+dIDnJsbPlxfgQVb+CMDv3q/E+cB7j11YLBz/JYL1pYWZ9RkYSnccuoxbaZHsqdiPG1w7A
 B6FA6RzZusZQNubUYNwBAwnQDYZPNxSqq+7l6tF9gikh8XJqC58zN7TXWiEwcK9htyNhzcg785Z
 qm+3KMsYWvZHOjmckizOmNTbWLHrt6ZD1IeD
X-Google-Smtp-Source: AGHT+IH4HfTY+RO2a2zxcVWchuKSy7I+nC7RLaloud/3ecsb93rnIHzgXfWxqmuujDQz82ygA/uSUQ==
X-Received: by 2002:a17:907:3d90:b0:ace:c2ab:a729 with SMTP id
 a640c23a62f3a-ad1a4ac116cmr346372266b.42.1746365060536; 
 Sun, 04 May 2025 06:24:20 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891f508asm328655666b.85.2025.05.04.06.24.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 06:24:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Douglas Anderson <dianders@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 10/30] patman: Correct a stray quote
Date: Sun,  4 May 2025 15:23:26 +0200
Message-ID: <20250504132356.2317305-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250504132356.2317305-1-sjg@chromium.org>
References: <20250504132356.2317305-1-sjg@chromium.org>
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

A quote character was added a few years ago, but was not intended. Drop
it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/patman/func_test.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/patman/func_test.py b/tools/patman/func_test.py
index a31c950051b..161b5ad4288 100644
--- a/tools/patman/func_test.py
+++ b/tools/patman/func_test.py
@@ -152,7 +152,7 @@ class TestFunctional(unittest.TestCase):
             Commit-changes: 2
             - Changes only for this commit
 
-'            Cover-changes: 4
+            Cover-changes: 4
             - Some notes for the cover letter
 
             Cover-letter:
-- 
2.43.0

