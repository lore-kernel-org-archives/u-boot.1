Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC3DC04FFE
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 13:37:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 945EB88303;
	Tue, 14 May 2024 15:37:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QVdOa4Nl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD94C882D6; Tue, 14 May 2024 15:37:36 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51C14882FD
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 15:37:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-41f9ce16ed8so55966855e9.0
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 06:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715693852; x=1716298652;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5sglo65XMHmczjFUKMb7iW2SnGAG9MHSaIcE86hL9Y4=;
 b=QVdOa4NlCFP8U3BFNd5WkyQbaNr+K+8EIe1sJHFvn2n2VbENViJ30XDrw/GfEUTOwv
 OofUFfAKdr5qnkq2Kt7LvCriVHp4GgrRlzXzheWNiY6p9iHT54i3ytmVdxT5Cw6YcjZy
 wGYpHoGhlI+LzmUXDZxtUu8NF+8I0ordQDcNAVfJwaMglXEjJ7ReFNn4ANzbD+WiS+Tf
 Sd+PkSUFs+uJB4o5XpAAh+un6HrA0HD0hNpdsS0iNT9yokWNHPCPqnQFV9F34ozFifOc
 sSoo7RHqaxz0FCxy5yxTG92yMPkV8Q9rRjPFJu8eTe8MyPOVPBGY/5PFWP5EMjoKseQj
 Ly9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715693852; x=1716298652;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5sglo65XMHmczjFUKMb7iW2SnGAG9MHSaIcE86hL9Y4=;
 b=Equ1WRMBYHIxh/MJUDq00M0/0kQt6MFoV27j31QL6r0rHm76rbM1b2iHp9xLVLqd+o
 a8wer+FkeenaHIfUboNkC8JgI+tDnG81sZd9tjw48wMlMgxI9IWVTvBxbEfHzKLtnHPN
 ST3CjTrRFQss/68gbJAdUMWZuHn02GvcWh/x3PKjB2rMqMkbOoKSsWjaoCnA8ml+BLtK
 5vrvx2130dCjg9vHrpn5ZJiaAIUNGryMZXkEUFtIwSOkLid0Y17WAci/NaDwSrpcadWJ
 vrfCpF14VxwNlYDOFp7xAAowyDBlWTlRAHMyx0SKWdgYWAJhl17ILv/sSD4AA7286GLP
 C0lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdVuPjlA9bb2ataSdGOA0vUywJH5macWJjcmSY7QtWcb1bjrxUHv+1C87PzbQPurQiEcl3DRlYEIYF2nhdeKmWhS4soA==
X-Gm-Message-State: AOJu0Yyk6elgZqiLAvBC/ThFTgdHTdi9ga/vRVQb41z6fh9VdhiNcEha
 eQ0FfgAJQNShbrhzBFq8xNzLBFg0vnHAEp2jTkZ+DMajni0wVwBuZifgjbL4oOw=
X-Google-Smtp-Source: AGHT+IGcCMmoBkEcCjFmAsPH7/W/qrz5oqtmszVAvC1EeTtA0RkENmBZ8F1P9FyGqVuXTLzLOsHFbA==
X-Received: by 2002:a05:600c:3b86:b0:41c:2313:da8d with SMTP id
 5b1f17b1804b1-41fea539615mr124221525e9.0.1715693851708; 
 Tue, 14 May 2024 06:37:31 -0700 (PDT)
Received: from groot.home ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42010940845sm113834015e9.35.2024.05.14.06.37.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 May 2024 06:37:31 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Tue, 14 May 2024 15:37:24 +0200
Subject: [PATCH 1/2] MAINTAINERS: add tree link for fastboot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240514-gadget-maintainer-v1-1-b170f291dc00@baylibre.com>
References: <20240514-gadget-maintainer-v1-0-b170f291dc00@baylibre.com>
In-Reply-To: <20240514-gadget-maintainer-v1-0-b170f291dc00@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
Cc: Lukasz Majewski <lukma@denx.de>, u-boot@lists.denx.de, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.13.1-dev-5d32f
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

Fastboot patches go through the u-boot-dfu tree.

Add a link in the maintainers file for it.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6853288975c0..05217db79f7e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1118,6 +1118,7 @@ F:	test/py/tests/test_event_dump.py
 FASTBOOT
 M:	Mattijs Korpershoek <mkorpershoek@baylibre.com>
 S:	Maintained
+T:	git https://source.denx.de/u-boot/custodians/u-boot-dfu.git
 F:	cmd/fastboot.c
 F:	doc/android/fastboot*.rst
 F:	include/fastboot.h

-- 
2.44.0

