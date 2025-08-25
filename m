Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC83C8303F
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 22:29:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A75A828A2;
	Tue, 26 Aug 2025 00:29:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SExica6K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6578282DA1; Tue, 26 Aug 2025 00:29:36 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75AFE80819
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 00:29:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-45a1b0d231eso28119165e9.3
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 15:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756160974; x=1756765774; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=O8AQmAJ/KyjAsCu4PbTjAd/ChlqhDHoWGaopIuG5cGk=;
 b=SExica6KmQ6qCRwrXNCaJPSxKNdbcJo/Cnd7qjleyTzB5kWtkpEAkK1EkbsKgUtGWC
 HfVgwjVtwm4+IFMWfTcjeJgMO3zygNiOdrhrPco6UlAVdfK1h8O58oMhED0mSjKesRRd
 IpRDBeWckmtZ5FDhEq821ZfKw4FaPdZquEMOvlIY0OHI7cilC2wqEGqBJUa+yopZXvZ6
 bmr9+ZtULsPOd+3XGsgolow76ZghaHab9meqXlJaxr2Pl8/B0Cidx2jt7YBR8NFJJOf/
 y9OxfUYD1m2sgsrAaaPx0TpgJrESauBMDzZsBNrvW0e6vBNOGaDgXdIPFzQUlNEe8z3q
 tzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756160974; x=1756765774;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O8AQmAJ/KyjAsCu4PbTjAd/ChlqhDHoWGaopIuG5cGk=;
 b=H5+FKOuPHmivr+0SjigRnezyxewU63bX1h+iTtyImQXjKQju5CQsKGTm461heWIx3c
 rpNBX0VeVhL1coj7vkx191fAG8aZSCIPI8gLXMGNoqEVKEhXpdg4Eeoxr2ba71z2Py8x
 Xd6lq4UImiHmUOdpZlGTTnkXWZIt36r1QHRT69BCvaq4PZm4/KQHgQI6DffQ5wAQoTd+
 knC8ALObm76/fEDzZlWTEFL41+hnZjc26JOhFufyQFicRws5Z5nc8ha/rRni0pqmaf2i
 q1HwYsNwE1rf7t/0BVQqQvovBq2pmCLxjeWnHnFaNBh3decsALaQ7elpGE+lqnWGFM5V
 3CAQ==
X-Gm-Message-State: AOJu0YzIkIp2EcQfwp+Nzg7bz+i9dzF2B/kv8sbB0c+9oEffd0joMQiM
 VrPArhNWaXkQUpjuXzIB4kNNJJzDbBo/gMrfVo61WgwZOg/T++yM2i5PZGWRaUDdoS4=
X-Gm-Gg: ASbGncs9pj16h/58itcOtGinqfQ+k2YhNuQPLpXvICOEwyFQASaF6ZxGnGcMfRj8PMA
 z8zNmxyvfnqYAqZrZ7EDidH9TyShm3fPRVvKUy7BrkNciVr3Aqhf9ibAFJvKxGEZBao5N36Vlgb
 1585oiOQ0NHA9o1ao8Xfg5bLgVlY30QYUg08xWIDoQfLNM18oUqgO1rAb8jCLr4sZ7bNEMsxBoS
 mYaq/g+4sNQpOvQdrbN5y+6qk1YF2rYBudiAWRsUG9aZ0DEvhbHWyBkKhiFFKmynkV1HH3HCfZS
 ooSJ1AZgwqB6wkuAbYYMsjB/U3fFExCwNC7xkJou0TwdnrWnxE20kkBHubKe0OMB5X3Dik/OaNK
 USkA9qgtwAgewxeiJFzKixrOelkEW
X-Google-Smtp-Source: AGHT+IH59+OizcnZ2/Rvz4zfJN11IalTe32WUDwtnn+d2Wt5ynX0SwBLTM5xVhGcN21HSu2QdanZ+w==
X-Received: by 2002:a05:600c:4715:b0:458:f70d:ebd7 with SMTP id
 5b1f17b1804b1-45b517c2f25mr107963005e9.20.1756160973515; 
 Mon, 25 Aug 2025 15:29:33 -0700 (PDT)
Received: from N580G.. ([2001:8a0:c46c:a000:ba6:baf1:694:9882])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b57444b3asm126997325e9.4.2025.08.25.15.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 15:29:33 -0700 (PDT)
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
To: u-boot@lists.denx.de
Cc: Adriano Carvalho <adrianocarvalho.pt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 00/10] doc: minor fixes and improvements
Date: Mon, 25 Aug 2025 23:27:15 +0100
Message-ID: <20250825222739.671380-1-adrianocarvalho.pt@gmail.com>
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

This patch series includes minor fixes (mostly obvious) as well as minor improvements to the documentation.

Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>

Adriano Carvalho (10):
  doc: Fix obvious typos and minor improvements
  doc: Quote all long form options using double backticks/grave accents
  doc: Use "supports" instead of "has"
  doc: Add riscv and unfold the list with the architecture/code name
  doc: Rephrase in a simpler way
  doc: Rephrase to be more clear
  doc: Rephrase to read a bit nicer
  doc: Rephrase to be more precise and less confusing (build)
  doc: Capitalize the word Buildman whenever it's used as a proper noun
  doc: Use a em-dash instead

 doc/build/clang.rst                |   8 +-
 doc/build/gen_compile_commands.rst |   2 +-
 doc/build/reproducible.rst         |   2 +-
 doc/build/tools.rst                |   9 +-
 tools/buildman/buildman.rst        | 217 +++++++++++++++--------------
 5 files changed, 125 insertions(+), 113 deletions(-)

-- 
2.48.1

