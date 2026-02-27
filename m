Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D248AFEFB6E
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 17:15:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B0A183D1A;
	Fri, 27 Feb 2026 18:15:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="RPxWIChm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2441783EB3; Fri, 27 Feb 2026 17:15:26 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3128C83D1A
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 17:15:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B23383FCE5
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 16:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1772208923;
 bh=Ki+luYmwBPNUEajsXCm89ISwUslQVwqwoaM02oUimOE=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=RPxWIChmhyyxz22RE6g9wVqFcc/PxadJu9VPskv3dt0bzuXNN4Nab+4aKKNkyzOY2
 aVA1djPbmQ8HeJXPyRi3ByzuzxwfzMfv2Z1etAZ5sK3KCmziUQR8SgktfKkaYmjV9d
 IQJWzvrPm3qeSTJUZatt1z0DTtwbKafcBQQakFe0jTKhm2twKE+gnQBBvL1b5vXIvs
 mmZATvhgQXWJdz+ArtL235hNdLmMJrfxbiqcFgCfj85t0q+dQaZDPMMGcC6niCMv7U
 u/zZJMsdzLhPtj9Q1RNekeWWCXi+ZkWMYGEXs789u2fLzqjFWQEP3PeEdRQmuhuNjP
 J+KxY8eiDCFptqQ5g6ruqgSqg8oVBNWigfMmPgMy9btQdAssT77W+ku1uvjG7pBe09
 uPqJfVX0snc2egQMp/f2hCKe0qmPL2m0qmUFM6Q06tRrejOKRe5xlyW1DcMc/C2xjh
 aaZTX9LXzug9Ucip7WB0vztc+jWQyuIagW48zJpjtuRUSCHq6HQ8pb4Wh+UYy0O3y2
 lltKgg5kAcbHj+fBQ9VLxFdrw/fq7Tjfmgfl77RkpQ1JE4KQmwiBPNeFzbHKJqhIec
 B0zYH6+44wxu2veRcAZESJ5IlEGIkMRwRauFXOIKI7ryWcHdMrTV20iVsZJN7NeChg
 aonBBzPLN0FaC5Fz3qnxvIHE=
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3591c9cb81eso8197472a91.2
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 08:15:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772208922; x=1772813722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ki+luYmwBPNUEajsXCm89ISwUslQVwqwoaM02oUimOE=;
 b=khlH61O7TWsPYhSldB4NL1Y8vwKyvMOhh5KPKI1rWjGcOvTKft6Idt0p3lu5z1Tv6n
 4leJj7h72Km24gIdLo9wy2lZVIXdqrrzFPzLMN31DCWmNuMQO7gtQPuokC0xvXOibzIJ
 +DqCMCY44VGhgewbLR7mW2Jj6CQtvp06z81Bf2vIkyOBdKRdyBwnUR1vjOfdNP80T8M5
 Z1zSgqsCT/nlC1lOWUDc51kaA1L5Wkiu6CexSP0tHeW2Bo51gxMDPehdGLot2+87evYv
 8UiY/c9wkFSS2akaAzB9pZ772MKx3LfK4NNggU+1RqarvkahrRwhr4For1ahrgapEiF0
 o3tg==
X-Gm-Message-State: AOJu0YzNDmoB6d5U+qGYB/zqY0tuiJs6JN4UXUzK1MD2L4/sE/3sszsT
 n4FebRzxSj4Kq9fFHVTDAEfOgkz6nSu3FbmIXk29t8IJih5Zf5KfjKwJnVU9lSlWSLK+foKD9ss
 0yEzNDbHRzXyyMF/f1tcjvuWQOlomS3XG522SszSq0PcKLqo4BTrxFAgrflnjha75v9eAR/zizI
 hGH4c=
X-Gm-Gg: ATEYQzwh1FujZ3nseuruQoALSzUR9fCR619wDXyqjw4MyJtiMTo4t0Bx0Fr4MnabOPM
 xlzG+D5P8hInYYkIwcUFB31urrkw5lVaLf+B2NTgEp3SNjXWZrS9UWiH+x0blrxMJg9nZFAzzLr
 0B/Vczd6gAa7z091yMS8wqa22o1OoEekwoN4pC1rUbn7EWZYKl4LmgDYEN9btCj1ADVild1GfDS
 APD2QsUEE1fVX1ayHP80+1nPL4VqqR7PGpark9o4pM0Asl1WsJNCfoTzQTMjTEBllGKa/UP/tIl
 VXNdmpV4YhOpAE7wCsKe/Xi8Qj6tZeSlqWU04H4GmfDuuW+GX4bspPehtz0YWFavsN53AyjLQye
 ONr77IWcn9DKIy8sApj3UWdWmnH7hcvffA5zXoQ5VQY1Ti14FfIrqjA8aQfjVEtKjvJi2IjfZ5n
 tc+r9ph2fAIEX9UHE=
X-Received: by 2002:a17:90b:2ccf:b0:359:dd9:3de7 with SMTP id
 98e67ed59e1d1-35965c3386amr3511909a91.4.1772208921689; 
 Fri, 27 Feb 2026 08:15:21 -0800 (PST)
X-Received: by 2002:a17:90b:2ccf:b0:359:dd9:3de7 with SMTP id
 98e67ed59e1d1-35965c3386amr3511881a91.4.1772208921146; 
 Fri, 27 Feb 2026 08:15:21 -0800 (PST)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3593dda5c87sm5523321a91.9.2026.02.27.08.15.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 08:15:20 -0800 (PST)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, quentin.schulz@cherry.de,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v3 1/1] doc: pstore: fix typo
Date: Fri, 27 Feb 2026 16:15:06 +0000
Message-ID: <20260227161508.14277-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260220031841.15708-1-aristo.chen@canonical.com>
References: <20260220031841.15708-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Feb 2026 18:15:40 +0100
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

Use "parameters have been set" and "they need" for correct grammar
in the pstore documentation.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 doc/usage/cmd/pstore.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/usage/cmd/pstore.rst b/doc/usage/cmd/pstore.rst
index 63a437135ec..b8e2a478421 100644
--- a/doc/usage/cmd/pstore.rst
+++ b/doc/usage/cmd/pstore.rst
@@ -80,8 +80,8 @@ For test purpose, you can generate a kernel crash by setting reboot timeout to
 Retrieve logs in U-Boot
 ~~~~~~~~~~~~~~~~~~~~~~~
 
-First of all, unless PStore parameters as been set during U-Boot configuration
-and match kernel ramoops parameters, it needs to be set using 'pstore set', e.g.::
+First of all, unless PStore parameters have been set during U-Boot configuration
+and match kernel ramoops parameters, they need to be set using 'pstore set', e.g.::
 
     => pstore set 0x30000000 0x100000 0x2000 0x2000
 
-- 
2.43.0

