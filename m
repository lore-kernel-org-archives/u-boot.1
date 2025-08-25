Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EDDDCA0FE7
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 22:46:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4F76830B3;
	Tue, 26 Aug 2025 00:46:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lvzGoi7y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6191D8307F; Tue, 26 Aug 2025 00:46:14 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D27A82DA1
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 00:46:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-45b618b7d33so11463715e9.1
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 15:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756161972; x=1756766772; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AkIJB7YIcIqhIkMkPujBBd8M1pBZPghoiZCky818a80=;
 b=lvzGoi7yafdQgdTCDosa1WdJVuDTsklATwu8mh/7R1FzY8qdN5j2yQUixhps/ZePyf
 n94PiQn7CHfEpxYii3qZpW6lDYvd6PK/nfqsKqqnhhetb5RrAsL3WGaFI7Gp5u8HXPL1
 3zUOaGuJH2+bnqMjwfkXZo+EMknVOtzz6RMfK+gQYQpiPfmBwxK1Kx2mXYS7TwOrlYKC
 Z3JwEiskRZAsnKnWzqWcoV/l3BQuKxbsAVbT43nnaLXe/kwuAKYlvJWnfidvbNqI/WaL
 UYxPvoKBWrTxreRfzzqNJjU++9SS/dqPq39vt+CiiZ1TTTMhpxzqpvZZw1aotQaRJ5td
 zH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756161972; x=1756766772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AkIJB7YIcIqhIkMkPujBBd8M1pBZPghoiZCky818a80=;
 b=aPD2mVtTdpDWek4E1u5Hkt5Nk9viVNIPKB1HO2wUtD+AhCWowlvU2nIZvShbWH5E8v
 2S1HtC+wUMAcbwGSpRTOT5uTjP3jhT2r1u3dZyc9Euf9gC2zGxifn21+G9dSE/u84L4G
 3gNJ82dHZTdKm+YoTcDl66pOBgj+5XFchBrxHHBIfoQ0unDCQbJ8jz6nTzib20t4sSso
 LGXMYtIKxmeyQl+Xh4lEtnxI/fabmHla6rjLmkybHW4MQnG579xbD1QwIRYzrHV7NRpV
 ar5NgZhzHFOWJL5EOpHDMv2zXsqUENh2KUpuySGcCne7HxQsbFlBGeGGBLPProzScbgb
 TPIw==
X-Gm-Message-State: AOJu0YzFB+mJ7YaudKMMK9j6O4xC+LgJ/evXlZdvHBB7nFehrCt/WFEA
 NByEFx15LAGzkuLGiQu2kWYR6Ld3OALC5arYC0QZlHb9KSPAJdAU5m9G8NFTEGWPfvk=
X-Gm-Gg: ASbGncvffoql6/qvqJRA37I6z4s8DG3mXzem1LjO/cEeZ+pA/WNL5wlW6Lm1mFVzkhc
 p1Z6OgWnfiOW4puBtcYwwmoSW5fgRxWdtECactWTrN5MuFloQT6Pmz+T4PcUoF3o+lggM0hygYF
 UPaKZlZyqioeUkQXneoNC9Dsvgt1AL6BIoSedY2eXP6+YfvcsL8QHgnKa99HmOj0xm9jjq6Dt08
 VfhgsrKcwNf7Tppu3R05c+8yw8GsJGJDLqbjCPoAed4NeLnKKPfkIrZObq0WIdEXKCbt6LZnmEI
 XpJtxAVqgQH+1FuBa6JgqwIAs44YNabPgO1rL5zz3Sb40DB/R215gg+nB9so/iYcv+qvQ/H/QMP
 k+2+1A3MOy9VxEn0yKPE4lwJ9HdMvhnq+RWF6Qw4=
X-Google-Smtp-Source: AGHT+IHtIkCHpMBizd/yu3KP3n7KrHiIcFc+AFkyD+IzX2eUPpxidjkecBeyYdDTdPrAncybshPxzQ==
X-Received: by 2002:a05:600c:4715:b0:456:302:6dc3 with SMTP id
 5b1f17b1804b1-45b517d4c47mr104168625e9.26.1756161971510; 
 Mon, 25 Aug 2025 15:46:11 -0700 (PDT)
Received: from N580G.. ([2001:8a0:c46c:a000:ba6:baf1:694:9882])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c7116e1397sm13296086f8f.49.2025.08.25.15.46.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 15:46:11 -0700 (PDT)
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
To: u-boot@lists.denx.de
Cc: Adriano Carvalho <adrianocarvalho.pt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Neha Malcom Francis <n-francis@ti.com>
Subject: [PATCH 1/7] doc: make pdfdocs: Specify texlive-xetex as a prerequisite
Date: Mon, 25 Aug 2025 23:44:44 +0100
Message-ID: <20250825224459.682403-2-adrianocarvalho.pt@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250825224459.682403-1-adrianocarvalho.pt@gmail.com>
References: <20250825224459.682403-1-adrianocarvalho.pt@gmail.com>
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

If I don't apt install texlive-xetex, this is what I get with docker.io/trini/u-boot-gitlab-ci-runner:jammy-20250714-25Jul2025:

uboot@35c89b9ab70e:~/u-boot$ make pdfdocs
  HOSTCC  scripts/basic/fixdep
doc/Makefile:89: The 'xelatex' command was not found. Make sure you have it installed and in PATH to produce PDF output.
  SKIP    Sphinx pdfdocs target.

NOTE: This won't completely fix the pdfdocs target. See next commit(s).

Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
---
 doc/build/documentation.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/build/documentation.rst b/doc/build/documentation.rst
index 098c96a4c4f..68d7e11c572 100644
--- a/doc/build/documentation.rst
+++ b/doc/build/documentation.rst
@@ -16,6 +16,8 @@ the following dependencies are needed to build the documentation:
 
 * texinfo (if building the `Infodoc documentation`_)
 
+* texlive-xetex (if building the `PDF documentation`_ through the *pdfdocs* target)
+
 HTML documentation
 ------------------
 
-- 
2.48.1

