Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7FF9E7716D
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 18:50:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 018B189416;
	Wed,  4 Dec 2024 19:50:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WENmfjg2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D26A89443; Wed,  4 Dec 2024 19:33:25 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AAF58904E
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 19:33:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-434a7cef2e3so155875e9.1
 for <u-boot@lists.denx.de>; Wed, 04 Dec 2024 10:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733337203; x=1733942003; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dFjtlPX1zp1mbljkuzde1RqHu4H80Tx9D5kEWYwOmEQ=;
 b=WENmfjg2mWbct4roRVBsIayk2O5jYnAkHwFVA30dyuvkbbnrpX+5a37HX6Xm5/oseD
 8f2hkR79KpY215nFUylZ1GRP7as9F0koAc/snT7P3421Zh2sHOoLhVMyUQE8fIGA40sQ
 VIeyWrYQt7hGlWquCsZsZGgTpZkCrXb8Qxd6H7JSjeX6kAiWdRUy/HtFQ7ybu4EgXvjj
 ddCUtOCGd/KivAJ+CFKPzXWUwT+XrWeYw6epPmTGL+vVO829Df7OmRKmDL0tt4tR8yX/
 Q35TTVCDagb8mn0zVy6oqpQbjU4kM2IjXzem9gYc8OgTa3hwcE3lYqSzJeV+n2wm3MXM
 6Vww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733337203; x=1733942003;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dFjtlPX1zp1mbljkuzde1RqHu4H80Tx9D5kEWYwOmEQ=;
 b=F/39W2tG4nuip9Ls6/hJgNpLSDcPYR/hGskOWK+8Gv8vybxWAfaNphTszQGNAeBl7E
 73VHgDG2entyKWd+KyswmvUdGctFX3pMZj4MOuHIQ/K+p8q2JZhw4tkqIJ7sACJMKViA
 nKkqHAekFMaEZPB0HtTiBSBDjCcEEq6JHesAdWzbmtStXBu93m9P8uHDk7oOpLghsI1c
 3vc0oHPDNt1TQSgTz3p+I8KliEaKDKdN/51nhFSiNQFJKC6j9iAJ+VG5KtFqbGIh5gEB
 wxZbyikhbwmRR/e9b30/3L+/0sXHfIHmFINMfdnJVXIFy7JjLLDYAG4rCOuAn6GJhhhH
 6fFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+hiafM1PECvU8fIJxhwJIPV0YhxfYAQOR5/JbsflsrP2pOPV0ankscwYzFSce4Q2wxrNpMG0=@lists.denx.de
X-Gm-Message-State: AOJu0YzWbRyETblqvHncbiQFLAqH5DgkHYBdjvE0mC88OrsOV2LXXe/L
 9KbnqM2zKhfsrfE6LFrvtXKHdPpoOYF/g9H2P8v2xSKCaYT6v+Cn
X-Gm-Gg: ASbGncu0CJGlpsWkkeRo9nKALlUwsPeldYjMQX45WBEhJyI+tiPbv6UdZ+oFn65EEQn
 JLyNM5nQdXMCW4gFTHyH+8mZF3M2uac7UUme9Witw5cH/kvjdeFLmqt+xpcuDXzmCaJBO51eIXk
 +JuHN8Lz1pzY7buUg07keqfoD+4ZbmbbqfzVeirNXqXF42G3yJge18vbC7m1jOG1vKVmeMfBMcP
 k6C7FsD9KhB5Ftyh/4tYmHKAHUnDafwWZXm1u3ijXkhZjDDScB3WvfgXRLWCdjsdjLB7QlMAF+4
 gci/pPai/QgIVq3oa5PkkEXKF7MY
X-Google-Smtp-Source: AGHT+IFeJXeNlrlMmwwy/5bGI+dr/zR+AlZrS1X76v+kPvkWmFY8Rvaziq6dwtQCXcbDolYPq/Km4g==
X-Received: by 2002:a05:6000:156c:b0:385:e877:c03b with SMTP id
 ffacd0b85a97d-385fd3c7737mr2486198f8f.2.1733337202843; 
 Wed, 04 Dec 2024 10:33:22 -0800 (PST)
Received: from 7b58d44c4ff6.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd80435sm18663825f8f.100.2024.12.04.10.33.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 10:33:22 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: sjg@chromium.org, trini@konsulko.com, alpernebiyasak@gmail.com,
 ada@thorsis.com, xypron.glpk@gmx.de
Cc: mkorpershoek@baylibre.com, dario.binacchi@amarulasolutions.com,
 u-boot@lists.denx.de, l.rubusch@gmail.com
Subject: [PATCH v3 0/2] doc: orthographic delights
Date: Wed,  4 Dec 2024 18:33:11 +0000
Message-Id: <20241204183313.144473-1-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 04 Dec 2024 19:50:49 +0100
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

Fix some typos and wording in various files. As asked by Simon, several
patches per file. The commits are extracted from my other patch set.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
v2 -> v3:
- htmldocs checked and fixed
- remaining typos
v1 -> v2:
- dropped entries.rst, since it is generated
- prefer British expressions
- use term "devicetree" uniformly
- fix several typos mentioned
---
Lothar Rubusch (2):
  doc: develop: Fix typos and wording in binman/binman.rst
  doc: develop: Fix typos and wording in gdb.rst

 doc/develop/gdb.rst     |  10 +-
 tools/binman/binman.rst | 234 ++++++++++++++++++++--------------------
 2 files changed, 122 insertions(+), 122 deletions(-)

-- 
2.39.2

