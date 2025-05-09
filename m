Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EEE4C3ABBC
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 15:43:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD61782905;
	Fri,  9 May 2025 17:43:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c5f9vHxO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A851382162; Fri,  9 May 2025 17:43:07 +0200 (CEST)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com
 [IPv6:2607:f8b0:4864:20::92c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6559182162
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 17:43:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-879ed601971so447538241.1
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 08:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746805384; x=1747410184; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bTmFgzvdN9yNrweSjSLee6ooG1UfIeq7NVPZyYO9j6w=;
 b=c5f9vHxOs8QCF0Uep3oJoRdVYVAfpKJQmHtVp4ZmvW7kJwWtJ08jleHahseCNbVtdO
 uFOCfV2KRTwCTHZy05EANWmQL/ve8kAoDKUa26MYUwqZ39qq3z39mdw+W03sufdHE9jD
 l3HhZ440EzynYZrXctXbrYzwNBf/bH/z6faHE/73GBySXqJiKm7x6yyPJddMLMsy30Bx
 qJ92VQ43SKBmHNp/DtBHAHfGYMruZuUPYEnMjWyTJgf66Nl4c2xbw2jEViYnZV8jQQw0
 Lp2e/qYwfK8ZI4ac8lfWPsUeoMIeoS7ZUUJraUM4C8Dj9Af7MFRFucrDdXKEfaSbzaZG
 lcWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746805384; x=1747410184;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bTmFgzvdN9yNrweSjSLee6ooG1UfIeq7NVPZyYO9j6w=;
 b=gvHjLr9tV8mHXEoEpdeQ8RXMkToHa3XkoZXVO6GMDvSpJlqpkrXY6FlC95jG/x1hee
 nJvkYWYKr60giaKA9jXUiFYx0D53che17qRBfH1zYowh2gbjxIT8a2UqLsMs2PUBt4qN
 kVg348GWNoVtEOzkCMpxlt0KzpypZxGw0ret+Z0Gy9q4kpPfSNeHAvSg2M069w+AkqLG
 txzjnhDVaGTOWrYmkQ+h/Tp79/DpkaM5yAatZzjeUHW+sqcj0f4RE88lVSq+cEI3Ufs6
 KNZJhQ+XbUiVMWjmRGNApUSj9BoSgDSzHvBof8CG113Ag/ig5JyKgCy+YfR9anE5Z7Wg
 QCrg==
X-Gm-Message-State: AOJu0YzDm6IzN0x/Jw4k1caSkgxQTLQKnH+8W2OTulcxGc9DypGM0KK2
 s4wampkYeps3WuV9eBaaYSbcdye13BzAXFxUHP9DBqe8acfndwdhBkLsE8d5
X-Gm-Gg: ASbGncv7QKd3LfyU72qY8F92/8Yuhb19pvTau0BdG4aoTIJr5Q2tmq//z0IjW66oQrt
 YraAVxzqHkLSvO8qCoSVZEalUE5RWkD7Y0ogIGJB8qWwOd8dsCqU/gf37T5AsGI4YOm3qRy+ymW
 wiyiTtaB2KhiHQVJDyLYQBu+r/0mb93am5TEY1FwbToOglEgXL5TFdWw2Po99GRqB+PJK0I2cKH
 PdZGPs7JvElZBiROMGdAJ5i3EN77j8Iz+Os3OGdQF/0btPnAA+2B4kkOdcz0Ler3F1W8P8fUPQ3
 UnplLqEnABiDmmrnhvTVBXW0y6hEtXn3G4cfSzT/U22DkTApWBcV
X-Google-Smtp-Source: AGHT+IEGxWJ0wQbkYvddsMZyhGSJ8vY3IEB5YTS/zMovaqOX1DTh6tEQ4tg+XO9NJvn1OxEBUYIn1Q==
X-Received: by 2002:a05:6102:8097:b0:4c8:55b8:6fad with SMTP id
 ada2fe7eead31-4deed3d2392mr3449402137.17.1746805384243; 
 Fri, 09 May 2025 08:43:04 -0700 (PDT)
Received: from adriano.. ([2800:300:6f54:8180:9366:b0c8:336a:d2c7])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-4deb203c1d4sm1303285137.28.2025.05.09.08.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 08:43:03 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 0/3] test/py: enable HTTP testing
Date: Fri,  9 May 2025 11:43:49 -0400
Message-ID: <20250509154352.3483523-1-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
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

Enable HTTP server in CI to support HTTP tests in pytest

QEMU does not emulate an HTTP server, unlike other services like DHCP or TFTP.
To enable HTTP  tests during CI runs, start a simple Python HTTP server
on port 80. This allows tests that require HTTP access to run.

The pytest framework is informed of the server's presence setting --httpserver
to a non-empty value, and pytest enables HTTP test cases. The actual string
value passed on --httpserver (e.g., "localhost:80") does not affect behavior,
it is only checked for non-emptiness. In the future, if the `wget` command in
U-Boot adds support for specifying ports, the value of --httpserver may become
meaningful and can be updated accordingly.

We also default `WGET=y` in `ARCH_QEMU` configurations so that these HTTP tests
are included automatically when using QEMU in CI.

Adriano Cordova (3):
  CI testing: add http server to CI tests
  cmd/Kconfig: enable wget on qemu
  py/tests/test_efi_loader.py: execute HTTP testing if httpserver is
    provided

 .azure-pipelines.yml             | 14 +++++++++++++-
 .gitlab-ci.yml                   | 14 +++++++++++++-
 cmd/Kconfig                      |  2 +-
 test/py/conftest.py              |  5 +++++
 test/py/tests/test_efi_loader.py |  5 ++++-
 5 files changed, 36 insertions(+), 4 deletions(-)

-- 
2.48.1

