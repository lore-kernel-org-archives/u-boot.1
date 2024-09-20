Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D84CF58D1
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 06:05:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 896E88932B;
	Fri, 20 Sep 2024 08:03:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g3fB1rCY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CAD18931B; Fri, 20 Sep 2024 08:03:16 +0200 (CEST)
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E5138935C
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 08:03:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x544.google.com with SMTP id
 4fb4d7f45d1cf-5c42bcf35fbso2198815a12.1
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 23:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726812194; x=1727416994; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gCbLUUK7oFu4ayaP9AEMNud9vWUxtGMyqzJTRPDFw+g=;
 b=g3fB1rCY+biOP66gtYHvnZLHnD8WL6U6kBE/clafx//PQBlew8EDo5ItJy3OQCeRrc
 OyZSpdzDXwY8nS/ZgcsB9lf3MndFkMalqxMl6Shy3UwYxs+mLK7anojZqgyMGoKXZyA9
 fCEta9e0la3FtHH9gjeP2f5m40nbh+Vbm22Ps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726812194; x=1727416994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gCbLUUK7oFu4ayaP9AEMNud9vWUxtGMyqzJTRPDFw+g=;
 b=Bwp/PE6HQxub2o7KnZMZprACwuiJEvhl+MBqIKT+5o1qDi7tNHmYImsn9wfc0Hl2F6
 hvcqjuQNBhkXNJVdlrAnxWNoLf9H8sHFbjFFKCuDhJZ60dpV4HOpa7rakjsFMUOhoaQl
 vMQpKmzgV19Y72FUduekTr3776LPq4U8FD+Y4L9urtGxXoEDJ8HSzT9EYkSuWZy5hRiV
 itnaLKxiw5gEEfUWiPFDswMf9hR4TsilY8rswLCWYzxRB4bMT2A13tfUm/hUR4m7cTSK
 ZtgvB2ddJacjiS7zyd4zjsAAPqz5CFzqmM13VZQ1pot5EoEfRquV5JGmM5A6iitj1FVs
 xpyA==
X-Gm-Message-State: AOJu0YwObPgY8SQ/m7TwaMWHXvpL0eSPbkVMOaLP7ypTqNXkVWI2v9Qz
 xHy0ZjxD9TuaQt72Xh1Of7PZQYflcgSV0lsble4LkfUMpCnXsD6TBNuL4Sdwfhjd8wbmEz6vier
 4/QDMHhk=
X-Google-Smtp-Source: AGHT+IHoKHqPXkaB9mct2ivWDYlufOWHNLvEbzMMqfF+sPZoXXnqA2byxgu4t798dR3kW4mGUCQRUg==
X-Received: by 2002:a17:906:bc2a:b0:a86:8ff8:1dd8 with SMTP id
 a640c23a62f3a-a90d50d033bmr127643766b.46.1726812193553; 
 Thu, 19 Sep 2024 23:03:13 -0700 (PDT)
Received: from chromium.org ([185.44.53.103]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df750sm796420666b.160.2024.09.19.23.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 23:03:13 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 14/19] test: Fix mulptiplex_log typo
Date: Fri, 20 Sep 2024 08:01:49 +0200
Message-ID: <20240920060158.106612-15-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920060158.106612-1-sjg@chromium.org>
References: <20240920060158.106612-1-sjg@chromium.org>
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

Fix a typo in a comment.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/u_boot_console_base.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base.py
index e2e78179555..f610fa9a6f8 100644
--- a/test/py/u_boot_console_base.py
+++ b/test/py/u_boot_console_base.py
@@ -123,7 +123,7 @@ class ConsoleBase(object):
         Can only usefully be called by sub-classes.
 
         Args:
-            log: A mulptiplex_log.Logfile object, to which the U-Boot output
+            log: A multiplexed_log.Logfile object, to which the U-Boot output
                 will be logged.
             config: A configuration data structure, as built by conftest.py.
             max_fifo_fill: The maximum number of characters to send to U-Boot
-- 
2.43.0

