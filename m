Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1564EC2BA18
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 17:57:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF2A988387;
	Sun, 23 Jun 2024 19:55:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nnohYxEY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23F0988549; Sun, 23 Jun 2024 19:55:28 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D0DD8855C
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 19:55:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-7f38f5584ebso117232539f.3
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 10:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719165324; x=1719770124; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=asc59Z1ZDtMFES+Na6cEttWuA//ajEC8Am+1ZXIXMXY=;
 b=nnohYxEY8Rym8CgQ39a0+5EsYVdki+eoi9Ak8ZzZh0MdfkJZjL9JBnkWhcQRibKCte
 aXi6Bl6zKhTO3e71qUetXivOAuEc6yNBMiD+slI2v0363HrLp7xG9WA0dPozOsroHRZA
 JNd1TLM3PPe7MT12jgidiY3nRh/iE/RIzMvuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719165324; x=1719770124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=asc59Z1ZDtMFES+Na6cEttWuA//ajEC8Am+1ZXIXMXY=;
 b=ZuDWamq8K7u5J9nbwJWBoM5Cbv/oi6CN+T1q1ptaPC1ccHilGEzJobEypp/elkkFjI
 hozQDiNR75DKv2BZLJ28OcMiT/7vP3hwXzNKwCKe0LbwAE4TLNPc5MLwfxPh3jezolbj
 fDXYNBs4roclmhVkPnZiNqJDV4rDEYE6WLN27LAsC7jbe+XoihJqsjSuq1dqgWn5cBSe
 eQSDT7c69pkU2Yjx8jFgcDnuP1LYkaqgtd5165HRk3HvscfgETxneprZ5GVWwAwtiEww
 k7p+arARyCqvUCTx7SoozX0rQGWphJ2idBBO6RrzqkwJwNEBg7KCKYIEIABJHqgUQBtl
 k4FA==
X-Gm-Message-State: AOJu0YytPX8jTqkinIoicSUHJoHQiWW5CpB5p9Bpql4VZy67iJfI7w1t
 muG2Bk/v+7KxRg9vDBsKlEEkptLT2b08SpdoxPf2H7wkD61TLzn1v330euqgRhSDsactxLbmxq7
 8Ww==
X-Google-Smtp-Source: AGHT+IFuXQ2X6poqfrs6c9g0WdBsYODnh4TWtZEzS9qqlWV1LU2fwja70PK7BYWzkvV4OqPfDj+0+A==
X-Received: by 2002:a05:6602:6c03:b0:7ea:fc3a:fff6 with SMTP id
 ca18e2360f4ac-7f3a4dc3607mr353921639f.6.1719165324004; 
 Sun, 23 Jun 2024 10:55:24 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f391fc9b12sm134472239f.5.2024.06.23.10.55.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 10:55:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH v2 06/14] binman: Make Intel ME default to position 0x1000
Date: Sun, 23 Jun 2024 11:55:07 -0600
Message-Id: <20240623175515.1466908-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623175515.1466908-1-sjg@chromium.org>
References: <20240623175515.1466908-1-sjg@chromium.org>
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

This cannot ever go at offset 0 since the descriptor is there. Use a
better offset for the ME, as used by link and coral, for example.

This matters when we start using assumed sizes for missing blobs.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/binman/etype/intel_descriptor.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/binman/etype/intel_descriptor.py b/tools/binman/etype/intel_descriptor.py
index 7fe88a9ec1a..3ce967fe81a 100644
--- a/tools/binman/etype/intel_descriptor.py
+++ b/tools/binman/etype/intel_descriptor.py
@@ -59,7 +59,7 @@ class Entry_intel_descriptor(Entry_blob_ext):
         if self.missing:
             # Return zero offsets so that these entries get placed somewhere
             if self.HasSibling('intel-me'):
-                info['intel-me'] = [0, None]
+                info['intel-me'] = [0x1000, None]
             return info
         offset = self.data.find(FD_SIGNATURE)
         if offset == -1:
-- 
2.34.1

