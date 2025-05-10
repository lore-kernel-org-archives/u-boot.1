Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266FBC3ABC9
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 13:07:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6485182B32;
	Sat, 10 May 2025 15:07:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HaqrCv47";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E6D282B0E; Sat, 10 May 2025 15:07:10 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6825382A8B
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 15:07:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-acbb85ce788so443891166b.3
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 06:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746882427; x=1747487227; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p98sJwUg6KPiNLYQwnrsoXxpXFFi6EY29JQ6uEU3nHw=;
 b=HaqrCv47tASbV0tf5IkjYG7IuVJExnBJK7MoAsFaQe5ofChtEbk/X2HEvCFsjIn/0Z
 aI88Oc/8JyhaSCJ8wKNor6TQOfd1M5Bt8spwNpDxQs9GUXkpq5LQD8QWn0JFRE/F0XXI
 jIEyACUzGU89uFkn2D/EPbmRH3dKx/rLns8aI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746882427; x=1747487227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p98sJwUg6KPiNLYQwnrsoXxpXFFi6EY29JQ6uEU3nHw=;
 b=mloNmtIyfUmoQu9M5+Tziz8xk+VDz3zXvTaMLjgoBxdiMt1LohxrB0OGH5DQP/eEvh
 oyswRlEEgVCSxkE6Dn64es1y6FNv3rPv/3i1wmi7SXDpo/YgYznzQpUHaS/SFZxWb1dv
 WZ2O+8mkLg9ZNTdExOjZBnMYYv4BM9700/3pabYyaNdoArh5gXFLmymnxFVk4kCg1u+h
 otVbDSMU0OPLxWLPneMs0Mw2EtH84zplEHAuUWwRn78t+t+60r5kYR1j+lJh6+T+81M0
 uaRxNOS3agRHTIDopAznLt+fxJnhKFbcf04GbLKBhpHQZvgVoqDdy/1S9NYmyrdDuQ6A
 D6PQ==
X-Gm-Message-State: AOJu0YzSTsYPJuUZCopeFywrXWn8LZrKIm5S5GQcmqCI+fsG2ol68uE6
 dMnhl5pjcztyC1VQh9k1qivDFTKo9FmjgrxBlm5sr6eosUspdrRGd5DZC6CWWDXVn/WRgu1sAG9
 0x2c3iCkWhQ==
X-Gm-Gg: ASbGncsIb/Y7Z16IXbQQRyIjf4MzD8f+X9igpncWXKmAgpvMa1tB09o1AbQCLrYvzhK
 wY52gFqrBtRWFY3ZIPpGT4UBp7BLfeMUn5c6LN9wLt1rdKReSq7urCEQvQAIWgcC4uiQTbk0KLl
 d0o7TRIQ/fddIFdYr6qfMoT1y6L4m5atYo0vb5w6ZPsC/W2ZY0prKFam2gPAJf+KTA+9Kh3MTgN
 ToWGDgMpNIOpFUZFCPIhwz2irt+3TgRcFUwUoHpQTGOvlR9cg7peOF86xgmLqFVI1/4ZQaNihOW
 si/Nf7Y6FdUDuakgi2XfLisOeSgrpExrzkUzpa4de5l3fiA=
X-Google-Smtp-Source: AGHT+IH79nqqdYBEliV7JHqzLcb8dkl3XPdLE6UaMtZaWAR4Soq7H3PdSYW5dmr+VWRoAw/yR5xH9Q==
X-Received: by 2002:a17:906:4796:b0:acb:bbc4:3344 with SMTP id
 a640c23a62f3a-ad218f10673mr675153666b.22.1746882426963; 
 Sat, 10 May 2025 06:07:06 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad24085b44fsm52272966b.149.2025.05.10.06.07.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 06:07:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Richard Weinberger <richard@nod.at>, Tom Rini <trini@konsulko.com>,
 Uma Shankar <uma.shankar@samsung.com>,
 =?UTF-8?q?=C5=81ukasz=20Majewski?= <l.majewski@samsung.com>
Subject: [PATCH v3 06/10] ext4: Bail out of no_blk_pergdt() if there are no
 blocks
Date: Sat, 10 May 2025 15:06:12 +0200
Message-ID: <20250510130642.1575114-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510130642.1575114-1-sjg@chromium.org>
References: <20250510130642.1575114-1-sjg@chromium.org>
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

If the size is too small, return an error, since no_blk_pergdt is
assumed to be non-zero in the following code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 fs/ext4/ext4_write.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
index ae26354fbb2..f9d5eccb2ca 100644
--- a/fs/ext4/ext4_write.c
+++ b/fs/ext4/ext4_write.c
@@ -116,6 +116,8 @@ int ext4fs_get_bgdtable(void)
 		return -1;
 	gdsize_total = ROUND(alloc_size, fs->blksz);
 	fs->no_blk_pergdt = gdsize_total / fs->blksz;
+	if (!fs->no_blk_pergdt)
+		return -1;
 
 	/* allocate memory for gdtable */
 	fs->gdtable = zalloc(gdsize_total);
-- 
2.43.0

