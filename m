Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD3EC27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 13:20:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E809B88541;
	Thu, 20 Jun 2024 15:19:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DVq8TpnR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 573F08853E; Thu, 20 Jun 2024 15:19:55 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 458EF8852E
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 15:19:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-376211b3a4fso5025475ab.1
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 06:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718889592; x=1719494392; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RttbVE72iKqTWkZneKSnwM5VCxPHk82fm//hR05SVzQ=;
 b=DVq8TpnRJf87mzUglQP3cchMWMq8mN0R5/s7PPgC7fcu5rzqlcuvPmavB6ymVnf0F7
 oS6yvzymY8fj/jUjbbNw231+rHjMTS5v830TMMi4l0j8K+cQJ3snuv6sN9wnrgdwLKAL
 z6PH3Z6CUFVJLS4RTxuRR+zKGJZzYN0wkYU2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718889592; x=1719494392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RttbVE72iKqTWkZneKSnwM5VCxPHk82fm//hR05SVzQ=;
 b=hYTTdT/7BWtN6ul4X42sW5gNxX7euNPFJrf3Hb4cl6CR/YXpGP4YSEPd5L79XMMg6S
 0ilz+k+zaO3KpzHkiE5q4584Qg9aTYU5Gz6c0pT/dKJcqFINs64B6cbxiMEL6FsJE7kP
 YkO4oUKOGmDxqw3Acnl5sbpLj4dCOdRf7zxMgxDjuIOEg//eIXLpPoWtnkGTMKLzlMKX
 0NcB8PCZ4uBV43jnPT5FU3+ShGGplbiOwSgD1kFIEL3Z3X3gzKpzXVGyvCb/RNv2hl5e
 UDkpvxK8EqyNJzzO3QDsRKUi/KKsOWID9FW+Wm/+KA7BXHUD67UUmnQVVOtGWhU/b0CX
 rVZQ==
X-Gm-Message-State: AOJu0YyGMiHTEBRg5kgT++SUs1IZY0d+JdJlfKmZjG8hptPhhqJEHc4A
 hxV2d6fNDbTqbUsEu3WO6Y1YY6/g5KnsuZNNIfdjv6LknkGB0BgfRAMM8ie4mNu4Xg4jMiVfkmO
 +Gg==
X-Google-Smtp-Source: AGHT+IEgApLWJzqCSCi1GJjDFwh/9Yu8yVd7Bt60jm2EjT33+IQU6NRMQegq7FQxgm5QAP/sR9CiQQ==
X-Received: by 2002:a05:6e02:1046:b0:375:a3eb:bfcd with SMTP id
 e9e14a558f8ab-376094f54a2mr43328555ab.8.1718889591943; 
 Thu, 20 Jun 2024 06:19:51 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375d866e260sm31807865ab.7.2024.06.20.06.19.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 06:19:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 2/5] Dockerfile: Add python3-pycryptodome
Date: Thu, 20 Jun 2024 07:19:34 -0600
Message-Id: <20240620131937.1130446-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620131937.1130446-1-sjg@chromium.org>
References: <20240620131937.1130446-1-sjg@chromium.org>
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

This is used by some Binman entry types, so add it to allow more tests
to pass.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/docker/Dockerfile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 0941b0f6952..a23504179c2 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -98,6 +98,7 @@ RUN apt-get update && apt-get install -y \
 	python2.7 \
 	python3 \
 	python3-coverage \
+	python3-pycryptodome \
 	python3-dev \
 	python3-pip \
 	python3-pyelftools \
-- 
2.34.1

