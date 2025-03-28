Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91646C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:09:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6629D81FEE;
	Fri, 28 Mar 2025 14:07:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dmRzYbyw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E591E81F74; Fri, 28 Mar 2025 14:07:51 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE24681273
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:07:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3d439dc0548so5513785ab.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167267; x=1743772067; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wh1+F1P+LrUymMlTFjKclNvwQSpVMvxAzfRJyKMymKk=;
 b=dmRzYbywH7awOjFNO8nb/ZOJYRH77/DqwmHgfmvPIec4+moEBU5RnA++WOdnv5ZCfX
 /rM1BNYkZzIlOpSJzQ4U6XcnS/Gh43LNf6wVRqJDv7oOP2rxpsHeuDCvetEBd/ewFlOG
 DsoMWe1dzpO7ivbAvZmLWhdauRfAcwQhSc9Ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167267; x=1743772067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wh1+F1P+LrUymMlTFjKclNvwQSpVMvxAzfRJyKMymKk=;
 b=umsCBWU3Jomfl/6Tlwyvraae2PrZpzMdkHSUi+uuwPb8tLjUHJ+YO5tU/xTS2yrS67
 mUAq9K4NVcc+N4K6IMEH4fArEZ0Q1HR0BLUh5rRJ2Ju/WYQxPBZbDjPJ2eoPUCSELo+I
 PSMSjYA3BeiUrSDVLSeNUjT9GwMIMAvwA11tx8CedoFkK4S2SgEKEKnzuh+bHUY5CDlb
 Rzs7Sc5mi/7e0ceR75TlS1EnapRwi58OkZHM5wvS6F1fDo97xlPS8csOlnoJ2/SC3HZH
 r4mOISAjsZcB+e/tamGJzAiuBpqIIKAicGtiBUu6/Pu1rZCx8vNey3iV8XP9eRsjpDc5
 +h9Q==
X-Gm-Message-State: AOJu0YwQWU3xu8IMZ5CxR0yvm2tkgx3w7payrloNw54rMDnEoqh+Uwrd
 0VTUL8swwMrXdT+kgF28AEzhfhhRvgeuwtqw6aOw7wSPY8s6aBCYJb62aKiUnfAHNlmySfoahe0
 =
X-Gm-Gg: ASbGnct5FwpXKLe0HJWqlAS8JtIUrYEqj19g+BJd4OPTDKvqhtSbewv/XEY9c0JRnSk
 okgAzIZrGqw4PSjY83JZ0ie7dYul2+CgaWpxxFAcvops6UJF9sOa7bbgOOKOdljgLZY+nrTD9ID
 5VbaaufzsB3F7OIJo0sVInEMuheJcd4noQ71YuXuVJHLHftrgMCP17kSPQ+Z8SulgIKn6htWVy+
 uvX4mtZcT87RlHaLjlqXyRNGyqoguAHtMahpoXLHR2IO7B2N21ZWRQH94huefSy79eucoDTZ9s4
 CO7ogxigurKlwLcnr+U5snbz2/LK/2kPmnT6u9qifWHUXQdsRLNdOHd4t7QU49wA64ICSKOOCa6
 Zr1qKsg==
X-Google-Smtp-Source: AGHT+IHXy5bN9WuBfNTsp54H+Anh2OjWCWcR4aErGLxkYtYOUP0JBUzqAuJweopEFYqCzpR7JRZPLA==
X-Received: by 2002:a05:6e02:3207:b0:3d4:4134:521a with SMTP id
 e9e14a558f8ab-3d5ccdd5c11mr91852225ab.12.1743167266842; 
 Fri, 28 Mar 2025 06:07:46 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.07.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:07:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 15/56] expo: Destroy the cedit expo when done
Date: Fri, 28 Mar 2025 07:06:02 -0600
Message-ID: <20250328130713.2612648-16-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328130713.2612648-1-sjg@chromium.org>
References: <20250328130713.2612648-1-sjg@chromium.org>
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

Once 'cedit run' is completed, destroy the expo so that a fresh one is
used for any future editing.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/cedit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/cmd/cedit.c b/cmd/cedit.c
index b0eca7b4daf..2e15b063462 100644
--- a/cmd/cedit.c
+++ b/cmd/cedit.c
@@ -285,6 +285,8 @@ static int do_cedit_run(struct cmd_tbl *cmdtp, int flag, int argc,
 		log_err("Failed (err=%dE)\n", ret);
 		return CMD_RET_FAILURE;
 	}
+	expo_destroy(cur_exp);
+	cur_exp = NULL;
 
 	return 0;
 }
-- 
2.43.0

