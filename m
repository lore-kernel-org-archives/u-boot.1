Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07567C2BA18
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 20:32:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79F2D882E2;
	Sun, 23 Jun 2024 22:30:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="citVApA4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BD9788405; Sun, 23 Jun 2024 22:30:46 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EFC887D07
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 22:30:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7eee7728b00so140423039f.3
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 13:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719174643; x=1719779443; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZxLbNXGoaXJvLvumbBY4pNS0+jFG7Ox/AWRsfxKB3CY=;
 b=citVApA4uyr9BJzfo+LXSFsV7jAXyS/qInZWXlKyO2lwqektc+lDPddk92JttCYsyn
 ZN6kg4Kf/kyO0jJGPzlVPXVsgTo/rd3XtpezXwKQqks1dQSJ1dy97r6wuAv+cuKQcyH1
 ChWRSm0RHgLbn965Q+LxjRbMhpAuorHp9B8j0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719174643; x=1719779443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZxLbNXGoaXJvLvumbBY4pNS0+jFG7Ox/AWRsfxKB3CY=;
 b=KFk0wy0lzmtvfrWLAm29CJhmg3H5sER8U16umZa8EpIcjVqbcnqWMPLutYUH9tbz/x
 rBhpegcgFm8/TW4sUshOLxs/eGeR3NNKw6QJ9p8uUZi77r6WvfhcXMfM97r5DgTA3yuZ
 SBFC8Ae3y9hzJNzmZHmUYhf/iAUbIwwtM1jwupGb2dfnH/0muzoAIwPSGGvOj/xI5Ai+
 9kfLvJFm6zO3kU7VFn0SoM0jgcppybKzu729r1J6J+fyL4tYii5md8bJiFK+rCt0hOl7
 LdrTqzyjsDYp9wHOPX/ESgw1A4YLXHPxAkxo3QFvNmPYhRrHGfwK3gdmjevTGWg9IxqU
 H2+A==
X-Gm-Message-State: AOJu0YyoJ/dwWjUaFnVy0ZOH4nsbpU0WOtUJgfi3y/X8kwJtgyvB2Alo
 UIdtIVjnv5tYnpgQGF5empLXkMbHtCKO+1VlK2OoOCWYxNRQw/Y10r8ySwdnOTeexD3f3JBL75M
 3/g==
X-Google-Smtp-Source: AGHT+IHL4xGuod3l4fzZPsLC5KclCniWjLABnGGTq6pU4pLdvQ6qnipSbzWf4Ss9vVmvJDpm18P36A==
X-Received: by 2002:a05:6602:6b86:b0:7e1:e022:9e46 with SMTP id
 ca18e2360f4ac-7f3a75faec7mr308227939f.21.1719174643058; 
 Sun, 23 Jun 2024 13:30:43 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d110ffb6sm1627335173.58.2024.06.23.13.30.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 13:30:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alexander Gendin <agendin@matrox.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH 08/14] test: Make bootstd init run only on sandbox
Date: Sun, 23 Jun 2024 14:30:27 -0600
Message-Id: <20240623203033.1566505-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623203033.1566505-1-sjg@chromium.org>
References: <20240623203033.1566505-1-sjg@chromium.org>
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

Tests for standard boot need disks to be set up, which can only be done
on sandbox, since adjusting disks on real hardware is not currently
supported. Mark the init function as sandbox-only.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/tests/test_ut.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index c169c835e38..58205066ec8 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -470,6 +470,7 @@ def test_ut_dm_init(u_boot_console):
         fh.write(data)
 
 @pytest.mark.buildconfigspec('cmd_bootflow')
+@pytest.mark.buildconfigspec('sandbox')
 def test_ut_dm_init_bootstd(u_boot_console):
     """Initialise data for bootflow tests"""
 
-- 
2.34.1

