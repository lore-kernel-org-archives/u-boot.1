Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94B9C02194
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 16:46:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21612801BE;
	Tue,  4 Feb 2025 17:46:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tlP8mJBc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DA9F801FD; Tue,  4 Feb 2025 17:46:02 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AF8E800B3
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 17:46:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-71e2764aa46so3486571a34.2
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 08:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738687559; x=1739292359; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=8ydeXyscYcWM0hmcVoy+nJr0YftbVHgQno1j7tvl07M=;
 b=tlP8mJBcqbrsDNH+UVgZ0VgRIxE7Kpniz1DY2w1bkgn8h0oD/6Exikr3Zn1nV8hN4k
 rcosOGds1gMav2Pmj9bW041RIk08PPAJwWN2TANqqpU8/WeVY39Rg9oGjtBW+PpTvdfm
 IjCIRojG5roKbkoOuTDEwlrj26N1pk1uUrUJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738687559; x=1739292359;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8ydeXyscYcWM0hmcVoy+nJr0YftbVHgQno1j7tvl07M=;
 b=u9JkR/ncB+48mIlfdCvJUNAoGP2vI9oZTroyKBByX00K6K3SBywECBbYrfGdOx0pM/
 7rOXuJosgWoAYk0cCXr+9qjQ37u/JeJr8o08qTZp/nBlmeYdkNUusazEChspmNR1zdg+
 cTID8atCcgj4fzbQpTgQr/cKUM4fG4AtH5EQa+uIndslwjipjnSpL35u11m07UzJ2uJy
 +8T3KOZSBK7iymW2GfzX516v/gaOWu3IPUv24bkouJZm/uwqrW3KKw9EEiR9L+NZk/1t
 uIokibKld+KVWOwXWY0FsOJZ5u5CwgVbTFIV3UxWcg8Fim2A3crtxTsAHQG/iVw9W6jo
 eKjg==
X-Gm-Message-State: AOJu0Yxr5mq8/kJWhB3c+Gdr6CV/rIbMoeq4mCLHB1t/g3XVnrtW5lvH
 esr7KBgZrD6mEPXDDulTMcnG2MacRV68tBeQt/odPmBqL3qtw7Dl9LZK7R7oC+3x7qDcEeHHvme
 70mQ=
X-Gm-Gg: ASbGnctvlkqpR9LwOwcYuvOQ0qvpR7UMTXUqhi3PmDbch7dqlsphdFKnNNKB5Naq9rT
 rZRPnX/X7hK90SjTTh+4dlfJUbOYmP63w94r7Qpqpb282zSQlBLLwWJ5dP05hhhO8P9E4APeNl+
 +d3oWQCVmEy+IUnZbItIewGmc0Bt4Ln0zVjaC8QhSOTs++R+bCr8YUdcC+I7QJN4X3xesy+lyw6
 KKJA7jIAANfPRNWY6XnKxAgz5zfDx5brPShz6KR8EtGbHT1vvKBvW5jGR874WFL+U+Wa/lwE0I5
 VSOYwfpWjYnBU+ml5w==
X-Google-Smtp-Source: AGHT+IGO3ZaeMIl0sXgdWvleEst86dROUF5NCiun228EVQaoeJjsDw6XumWhKb4z23fTthPSASZb9g==
X-Received: by 2002:a05:6830:d0e:b0:71d:eee3:fd1a with SMTP id
 46e09a7af769-72656629fe8mr16157572a34.0.1738687558834; 
 Tue, 04 Feb 2025 08:45:58 -0800 (PST)
Received: from bill-the-cat.. ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-726617eb165sm3372124a34.38.2025.02.04.08.45.57
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 08:45:58 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] py: Rename the rest of the boardenv files with "-" in their
 name
Date: Tue,  4 Feb 2025 10:45:56 -0600
Message-ID: <20250204164556.448732-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

The way that test/py/conftest.py has always worked is that it translates
all "-" to "_" when looking for boardenv files. Rename the few
incorrectly named ones that we had.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 ...nv_evb-ast2500_qemu.py => u_boot_boardenv_evb_ast2500_qemu.py} | 0
 ...nv_evb-ast2600_qemu.py => u_boot_boardenv_evb_ast2600_qemu.py} | 0
 ...boardenv_qemu-ae3xx_na.py => u_boot_boardenv_qemu_ae3xx_na.py} | 0
 ...t_boardenv_qemu-ax25_na.py => u_boot_boardenv_qemu_ax25_na.py} | 0
 4 files changed, 0 insertions(+), 0 deletions(-)
 rename py/travis-ci/{u_boot_boardenv_evb-ast2500_qemu.py => u_boot_boardenv_evb_ast2500_qemu.py} (100%)
 rename py/travis-ci/{u_boot_boardenv_evb-ast2600_qemu.py => u_boot_boardenv_evb_ast2600_qemu.py} (100%)
 rename py/travis-ci/{u_boot_boardenv_qemu-ae3xx_na.py => u_boot_boardenv_qemu_ae3xx_na.py} (100%)
 rename py/travis-ci/{u_boot_boardenv_qemu-ax25_na.py => u_boot_boardenv_qemu_ax25_na.py} (100%)

diff --git a/py/travis-ci/u_boot_boardenv_evb-ast2500_qemu.py b/py/travis-ci/u_boot_boardenv_evb_ast2500_qemu.py
similarity index 100%
rename from py/travis-ci/u_boot_boardenv_evb-ast2500_qemu.py
rename to py/travis-ci/u_boot_boardenv_evb_ast2500_qemu.py
diff --git a/py/travis-ci/u_boot_boardenv_evb-ast2600_qemu.py b/py/travis-ci/u_boot_boardenv_evb_ast2600_qemu.py
similarity index 100%
rename from py/travis-ci/u_boot_boardenv_evb-ast2600_qemu.py
rename to py/travis-ci/u_boot_boardenv_evb_ast2600_qemu.py
diff --git a/py/travis-ci/u_boot_boardenv_qemu-ae3xx_na.py b/py/travis-ci/u_boot_boardenv_qemu_ae3xx_na.py
similarity index 100%
rename from py/travis-ci/u_boot_boardenv_qemu-ae3xx_na.py
rename to py/travis-ci/u_boot_boardenv_qemu_ae3xx_na.py
diff --git a/py/travis-ci/u_boot_boardenv_qemu-ax25_na.py b/py/travis-ci/u_boot_boardenv_qemu_ax25_na.py
similarity index 100%
rename from py/travis-ci/u_boot_boardenv_qemu-ax25_na.py
rename to py/travis-ci/u_boot_boardenv_qemu_ax25_na.py
-- 
2.43.0

