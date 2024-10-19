Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC63D3C91A
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 15:27:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F18389335;
	Sat, 19 Oct 2024 17:23:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Bs4yDXBr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 759E18933B; Sat, 19 Oct 2024 17:23:07 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C214A89338
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 17:23:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3a39cabb9b8so10866635ab.1
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 08:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729351383; x=1729956183; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NhEJ3i2J695tl4/KBnp6AtfGV2Dv0QSQ2cTlxRrr5n0=;
 b=Bs4yDXBr2e/gL66iHScgIjakt3WiQfhgWBifGlHA7GDDG2y+0pTpZuijZ6AMUFz5hA
 5tvfO5GJ1j3EiujfdJzpyM6x6eRzFxvyHPyHsoaC7h69/s0swL8PUivXImQ4iteswaYp
 0k7g+SjYUai77fEu/vTC8P8lF2eRcGHehTtUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729351383; x=1729956183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NhEJ3i2J695tl4/KBnp6AtfGV2Dv0QSQ2cTlxRrr5n0=;
 b=KU5u3JPXBfwvaPNSEtGcPgX817KTYNkw1IvEdKyHxLBdQjDLPmOWbD9TdbLARrbgrg
 kmj4v6OZc7/ceqSaTDzO5B3qYiV9xsWxixHUy3CY4GdCmZ1YIKrfqSM0YTMMvpbmhMHJ
 ZUYGenUllg4H7Opgr7wjM6NaM9UDhQA6G2/X+WuPgw8yOnitIlrxo/8pEwRTn6YO8wHm
 tMXWdRkwk6NqKg0YNE7bGNhWE+ZoW0G9Wg0f9L52O7Jk2MGfPecsm1AEu6rzPV90tPPo
 kc1OtvBU5quuQwbxuxWPCexHAIF+wtGNIVLSN2Dq+qMVkirWbcw1aksaomY8eKVlT14y
 Bdkg==
X-Gm-Message-State: AOJu0Yy83w63JW7qkUsnbPtqHvjtmhIakSy3tVIVVK302r0tvA9EwC13
 pDJX7QMLZTKFpUFhEFC6iNpK22jWh/n93mh7ndKbi4S7dhOLW49koMMQmPHYHOLsEP9HcJ0w7u0
 =
X-Google-Smtp-Source: AGHT+IFhIXRl5cbXrE35j6pGiuC223x6rMJ2pojV2YDU9CEj2UBJ1kMY2TC5dUd+vRPxuiKGFxMZww==
X-Received: by 2002:a92:c566:0:b0:39d:4ef6:b36d with SMTP id
 e9e14a558f8ab-3a3f4058e85mr54500095ab.7.1729351383068; 
 Sat, 19 Oct 2024 08:23:03 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b83faasm1006111173.52.2024.10.19.08.23.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 08:23:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 29/31] bootstd: Avoid showing an invalid buffer address
Date: Sat, 19 Oct 2024 09:22:09 -0600
Message-Id: <20241019152211.1014896-30-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241019152211.1014896-1-sjg@chromium.org>
References: <20241019152211.1014896-1-sjg@chromium.org>
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

When the buffer address is not set, say so, rather than showing an
address which looks very strange, on sandbox.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/bootflow.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index 3e9769e0d42..1c1146ce11e 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -393,7 +393,11 @@ static int do_bootflow_info(struct cmd_tbl *cmdtp, int flag, int argc,
 	printf("Partition: %d\n", bflow->part);
 	printf("Subdir:    %s\n", bflow->subdir ? bflow->subdir : "(none)");
 	printf("Filename:  %s\n", bflow->fname);
-	printf("Buffer:    %lx\n", (ulong)map_to_sysmem(bflow->buf));
+	printf("Buffer:    ");
+	if (bflow->buf)
+		printf("%lx\n", (ulong)map_to_sysmem(bflow->buf));
+	else
+		printf("(not loaded)\n");
 	printf("Size:      %x (%d bytes)\n", bflow->size, bflow->size);
 	printf("OS:        %s\n", bflow->os_name ? bflow->os_name : "(none)");
 	printf("Cmdline:   ");
-- 
2.34.1

