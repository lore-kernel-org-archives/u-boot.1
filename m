Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C32B8C55AB9
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 13:04:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 784FD83AC5;
	Fri, 20 Feb 2026 14:04:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dNZmUw5V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D7DA83CEE; Fri, 20 Feb 2026 04:19:24 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5D2B8366F
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 04:19:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2aaf59c4f7cso7458745ad.1
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 19:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771557560; x=1772162360; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mWVVuUSEZhwInqN2I2ZQr7Mhg/R/tJqclm0sTBTGJjk=;
 b=dNZmUw5VTp57ESs8ln25cl9sJ0O6mGl5AJQKjrMQgsFNe9DeHQ9in7gkb7YV+yZc4G
 7dZuzrQlcd7r5UCet8nwhSieYNXnrkUonHlWcti/3gbFYKFCYFuaBJxK7OC6NAeVfHW2
 UsntfEY4J/wFeQ8uRxC2JMWUcFqC8dpU2pw8pWfoRgtc7rsFe5KHX2wB0izT22C+eHev
 GlPibbG0d+BQkaHuouXaxqbUwuclCj9PMb9P3miP9xDIPGyaF1rRLj09Wo3IldoMYeSt
 Kl7qLsiKjVnCelWoOh9WeSCXAy3SKeX9d5j8jPW7ao3+9eAYKt54Phq6KMIgOBPAzbC0
 yCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771557560; x=1772162360;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mWVVuUSEZhwInqN2I2ZQr7Mhg/R/tJqclm0sTBTGJjk=;
 b=bCbB2sRzr0D0YSnbmb0eezeCK04EHBK00GuVdYya8E/4M4XzYsCtRtDytsIb5h9eY1
 o/QdEyWrRoqrnwD4ZMoKhW/GtEm/csiN7N6UZxdPMf6spnEiMMY8itsTuOFkIB4KbHHg
 DvRdl6FoC5XikmEjNE2LvGX60L+cPMY71v5QMWi4aOqvuaPNUHs9MvkfBCirR9xmc8Bp
 Z0GL/cH+SJ/f/JW1Url7ra2qP8VdlldtZCKlUFGjVVxPpTM1Pau1d7kKEzLygz8N9CYs
 G7fMcDqf+L04lAFkjLZiPN+cZL0BBJ52hpnSkJwaNkkOxVAdT7J7iYiN56dqSoSUi9BZ
 OPlg==
X-Gm-Message-State: AOJu0Ywvu3qEMPVS3e+0LBuDxwWcZ3ZjC5gLJeYR5n1RUkwNHGjOjRPI
 PjNc7Oqbll+gxpKnh0yn1nRVVYerZ6Awit2odCXXr5hhPOPh+9ih5mTbfaeG/g==
X-Gm-Gg: AZuq6aLsRDTujHzdInwv7szikKqDfIB9Og/ar0lEjYlqnxyiPPkgLYppRXEBHCqPlr9
 W5/7cLWvlWubHzMq7oygYuLmDqRmVMTrxFW8EfqGfS2P2R2dwkxeBJX8tqHbIgYa8ouh8i7Nfba
 67axL5RjnDg4HKyfHOWxQCRMW9USQ1jwcWLsq9dt7tK1yXsaj/+9VDaXh5dRj/Rv0IFIUWZwsv7
 5fnBEU1pp5tEyfKBkeHNuU9IWq02e1tPFg5y2a5RlZMKR41JCstCTD4jemgcFz/S5L1B5lPwYYz
 5uGLOGshLaqiVB2UwLyEyUhJAF8BRuMcD2zKh71S/l9iKTKr56CwwBt/lmQO/AvSDmG27UbRdB4
 hsHIfBfQgPGvai+6McveSn8CxhSxRPe3vnup7CUA4036IDCotl6cDWv4GNfmSIt6LCgskNdEXcN
 JsJjvBMM4Lhh3Fs26PLU/wWwD/wWDYkFSQ5h7tzOvm14MSu/gmp6LCCJY8lfwIY/XC/G1gSmwgh
 w==
X-Received: by 2002:a17:903:2f4e:b0:246:7a43:3f66 with SMTP id
 d9443c01a7336-2ad50e77517mr72042295ad.7.1771557559916; 
 Thu, 19 Feb 2026 19:19:19 -0800 (PST)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1aadc7b7sm180415905ad.67.2026.02.19.19.19.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 19:19:19 -0800 (PST)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 1/1] doc: pstore: fix typo
Date: Fri, 20 Feb 2026 03:18:39 +0000
Message-ID: <20260220031841.15708-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Feb 2026 14:03:59 +0100
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

Use "parameters have been set" for correct grammar in the pstore
documentation.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 doc/usage/cmd/pstore.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/usage/cmd/pstore.rst b/doc/usage/cmd/pstore.rst
index 63a437135ec..fd3425a1dc2 100644
--- a/doc/usage/cmd/pstore.rst
+++ b/doc/usage/cmd/pstore.rst
@@ -80,7 +80,7 @@ For test purpose, you can generate a kernel crash by setting reboot timeout to
 Retrieve logs in U-Boot
 ~~~~~~~~~~~~~~~~~~~~~~~
 
-First of all, unless PStore parameters as been set during U-Boot configuration
+First of all, unless PStore parameters have been set during U-Boot configuration
 and match kernel ramoops parameters, it needs to be set using 'pstore set', e.g.::
 
     => pstore set 0x30000000 0x100000 0x2000 0x2000
-- 
2.43.0

