Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99AAAE7716F
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 23:59:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACD8C8973A;
	Thu,  5 Dec 2024 00:59:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mind.be
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mind.be header.i=@mind.be header.b="hG/NV7xP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1995088EC6; Wed,  4 Dec 2024 23:31:48 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2407D89482
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 23:31:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=mind.be
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=olivier.lheureux@essensium.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-434ab114753so2026675e9.0
 for <u-boot@lists.denx.de>; Wed, 04 Dec 2024 14:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mind.be; s=google; t=1733351504; x=1733956304; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ikFNObhKQUfZcUjIucpfdA5Hg7mKLZBHpTQvucP26NA=;
 b=hG/NV7xPA2KpSoCF37+dJ1WycZPcsGXp0NGln4a4RVcaSHtAShL2JljrodX50IcKpG
 LoJZYoduUvBJMM3Iv/PBtuaoySZEin6AZqwjU6m2K2r0A99oT5stZe+WzAbJAfd12gUp
 LFGf2BxXzPMo04UHdXV2A3t0S5EY0ve2x3LJALJr5crPR7DWrKxEaqAOJzL2kdchRgwH
 3Brim9geoIlirHVXtpOFCowflCZEk1JWP7ReykJqIA0tWrBdv82Oy+GNnc1VL9dsKcHI
 DPkN5VFmuh6TpIaN/6J453EP4Xh7xbcMX4MkyPxvACQmeBucKBXEmBpnEFIn6QvZxL1y
 2ONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733351504; x=1733956304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ikFNObhKQUfZcUjIucpfdA5Hg7mKLZBHpTQvucP26NA=;
 b=vOL5Og0h/HOSJNoS5BlIPM99vGuLim+1vCkiqZFZvSdCygfKcjH4+3Hme5NaKmmP5i
 nGc6RZDCDttmDmwJ3/I5ATuFZgXX34AiOnyJ7O15P0okIt85JVGUwgnlzqGXXmkRObWB
 WGfvWTqWwWGB03pzmIP1ShnBvlTLfOfGz47SIxqdABmYyNlxL9dY/pKKohM3kFF+Ywfc
 DGzICyiF9e8NK8PNweY75EPvYf/kIa3JWLkrjooH1pORC3qrEXCzETaNEH8GGuXQEQnv
 IvdHdV+bxhfRscWPZ8gHgkiCBcjSJEZF3iKZ/jvrJF4XeJWN6DTbReyZX7lWaUIiJ+rQ
 bIOQ==
X-Gm-Message-State: AOJu0YzQQqYphYhO3KqCTJKW/uVAgsm695HnKaMLBhdL6uEkLtcUgeBU
 h3Kdlshs6ATQ6cynfHuKQt8kBzHMA5vW4me9ujrcpFk4IfhflIhHzoynUDJDF1cbGdJGJkokf8P
 o
X-Gm-Gg: ASbGnct1Xu1c14zNv3QDeq1N+xyBKdAUrUUh9WE9RqaOTOa+9sSbf85ES5mZrN/pv40
 nPvZG6y4YniAijORfv7g7yFmUI6IGH/jZhmlchxnnDYJPBn3aJmt/dAUjwisZiFLAKba6GtHTB5
 h8bZDxq0bJrKz9P/rU4nx6ZULoCqn6zONrm7IKGkckquW60t8cpQxYEs0B47TgTA46PEUtp190I
 eHpyeljPP5MJa6XpVNe9jMLORQYEZZoB8sjV1COYIQGBROe4CJR6DWl2K1BgigjSS1QdM7rIPjh
 R2C/STtIUA==
X-Google-Smtp-Source: AGHT+IEBczGE01snlx/fiN3dvWjrnl33FfVaNo/Bqm13bkLJ5SelpRuo/dcJTRieIZdqH1Zl1UUA5Q==
X-Received: by 2002:a05:600c:4592:b0:42a:a6d2:3270 with SMTP id
 5b1f17b1804b1-434d0a05523mr55948365e9.21.1733351504680; 
 Wed, 04 Dec 2024 14:31:44 -0800 (PST)
Received: from olheureu-ThinkPad-E560.fritz.box
 ([2a02:578:85b9:1300:127d:9c22:de23:d041])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434da0d6b38sm1419385e9.17.2024.12.04.14.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 14:31:44 -0800 (PST)
From: Olivier L'Heureux <olivier.lheureux@mind.be>
To: u-boot@lists.denx.de
Cc: Olivier L'Heureux <olivier.lheureux@mind.be>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/1] doc: sandbox: Fix the "sb" command name
Date: Wed,  4 Dec 2024 23:31:00 +0100
Message-ID: <20241204223107.43349-2-olivier.lheureux@mind.be>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241204223107.43349-1-olivier.lheureux@mind.be>
References: <20241204223107.43349-1-olivier.lheureux@mind.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 05 Dec 2024 00:59:15 +0100
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

The command name was "sbi" instead of "sb" in "doc/usage/cmd/sb.rst",
the file documenting the "sb" command. It is annoying, because the
index in the left panel on the
<https://docs.u-boot.org/en/latest/usage/cmd/sb.html> page shows no
"sb" command, which makes difficult to navigate to the "sb"
documentation.

Fixed the command name: "sbi" -> "sb".

Fixes: ec6d30649cd5 (doc: sandbox: Add docs for the sb command, 2024-10-28)
Signed-off-by: Olivier L'Heureux <olivier.lheureux@mind.be>
---
 doc/usage/cmd/sb.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/usage/cmd/sb.rst b/doc/usage/cmd/sb.rst
index 37431aff7c8..6fe14629b8f 100644
--- a/doc/usage/cmd/sb.rst
+++ b/doc/usage/cmd/sb.rst
@@ -1,10 +1,10 @@
 .. SPDX-License-Identifier: GPL-2.0+
 
 .. index::
-   single: sbi (command)
+   single: sb (command)
 
-sbi command
-===========
+sb command
+==========
 
 Synopsis
 --------
-- 
2.45.2

