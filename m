Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FD2F5A8BB
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 20:34:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E83C18446D;
	Mon, 20 Apr 2026 22:33:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qdiUERWY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1525584308; Mon, 20 Apr 2026 18:36:14 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B080D84315
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 18:36:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sigmaepsilon92@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488d2079582so38465105e9.2
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 09:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776702971; x=1777307771; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rg76lOxP+GG8Fy5/znfBXqhxRJJ32H4CX3GdFulytlA=;
 b=qdiUERWY+DpKVJ7ViJj7j+DS+bytfTrfCp7U0b5C6/r0nkfaL/FVpqEEU6NUgpTfuj
 eGfx51+5YDFYmaZXt3m/O665JU9TBhngDVxSlGvwql4v4iTKivaeW8mziERcMwYDhH5z
 TbotlZRX8+SKQqutswGai/5+TxH6ZwiioR6Fmr7B3m26fj/oXhU6SUu3rNu0F+zm+/hH
 Uh7+oyCcBvQ8WG0UVByqbUCYxGauetyjpBpjTMGxEENXozSFGhAMvIJWSY5IiGKmHc0D
 NGNX7+GljQUC4fztcDgYiiQ0oGDwzHXVLC8WZ/NRxifJAYjz/Yws5OaIk/y5m649YrCL
 lvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776702971; x=1777307771;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rg76lOxP+GG8Fy5/znfBXqhxRJJ32H4CX3GdFulytlA=;
 b=Rb38DNb6rqdTZ4T2EQT2ngeQ4bDYrvtm8SegB6EjFwsn2SxDIM46CfcQJlZbTgnhDg
 kmI13boHlhIdZMe/KdwbA9P2RAf1/64rj5oDFLbebQixcXueyUTdAItsXwIVyce1jqQA
 BENi964rO7JtRID32xnaFiZqiRNxE7s9J186t3NlI48oBO0B2P75lxqgyN++CrHkHOje
 ZOpXiA8sA8i4y6uQjFmtcP6VldU6ymT3EPKFu3vDQIT+IsVkaESNNCZBdp6WVbn5fV8N
 g/xeXeSZyXob/Dow26v/hoartPqVf3m3tu8ZF/J/I0X2OXdNyI9B4I9otgXQoasIYwvF
 4egA==
X-Gm-Message-State: AOJu0YxgZILuvUk1EU0AhAv8LwXy5bycdUR+k0Yp/75AGT1Ny3wRMY61
 +SaTRrBLl5oNVnl87I1X1p1nbatTe8Tp4h8QDuKejsp7EA5XHQksn3MYKJxe0K+D
X-Gm-Gg: AeBDietP9PLcgkeeGfGdru2ZwXHEDwZScDVVL2NYIkqw09RFGtL9ugnftSsaqVeLblW
 oEkA3xvR0+N6JLj5vMpUjxICMon7AfPdfnGLlzzcXMMzbN8GpB/dTo6eAdIBDGRQdjTc4VGzGFE
 H7zxxwOS3GZl76Zw+u5KMAbM2E7jVNhQ2AfzYieJ6yi8AUt8A00dI44CasgHdLtPN02VWITlE6h
 PBELSrmFkcGB/6Bj8fv0gVHwxRhpY07P67V4TI+vDIM/csqbgBLJKXx1H5ILekMutTQKyO9IfeO
 +Y6lUVAgorhObJVxByWuFOJLGDMPfm8P/yvNcQZLnyTPPR3ua/uL+u5/nEKbIHsAoweFhyyMxB2
 4pL8ChEVHoIchNXS6bEK1ZWeWLragkN41lNPra7xZ6cDwhSN6kOYVqNFouNwQKf+UI+v49Y+3Uu
 x+nhHBddIS4/W56eumFBgOT5OooXMu/4L5/38FHnMrXXY7kSxGw3OxLcHLrxBpoCVQhkXzekHD3
 TBm/jKwNwWakPLelYedkhyKNA==
X-Received: by 2002:a05:600c:8883:b0:488:def6:bb17 with SMTP id
 5b1f17b1804b1-488fb73a9admr159671265e9.4.1776702970644; 
 Mon, 20 Apr 2026 09:36:10 -0700 (PDT)
Received: from toolbox ([2a00:1e:8743:eb00:edd1:4809:dfe2:efaf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc140c82sm273834445e9.12.2026.04.20.09.36.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 09:36:10 -0700 (PDT)
From: Michael Zimmermann <sigmaepsilon92@gmail.com>
To: u-boot@lists.denx.de
Cc: Michael Zimmermann <sigmaepsilon92@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Eric Kilmer <eric.kilmer@trailofbits.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joao Marcos Costa <joaomarcos.costa@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Simon Glass <simon.glass@canonical.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?q?Timo=20tp=20Prei=C3=9Fl?= <t.preissl@proton.me>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] fs/squashfs: Set ret to 0 on successful read
Date: Mon, 20 Apr 2026 18:35:31 +0200
Message-ID: <20260420163551.515651-1-sigmaepsilon92@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 20 Apr 2026 22:33:40 +0200
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

It might still be a positive number due to the call to sqfs_disk_read.
This only happens when reading a file from an uncompressed squashfs.

I found this by trying to boot using the extlinux bootmethod, where
positive values are treated as errors.

Signed-off-by: Michael Zimmermann <sigmaepsilon92@gmail.com>
---

 fs/squashfs/sqfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
index 543db8c7e9e..0768fc4a7b2 100644
--- a/fs/squashfs/sqfs.c
+++ b/fs/squashfs/sqfs.c
@@ -1636,6 +1636,8 @@ static int sqfs_read_nest(const char *filename, void *buf, loff_t offset,
 		*actread = finfo.size;
 	}
 
+	ret = 0;
+
 out:
 	free(fragment);
 	free(datablock);
-- 
2.53.0

base-commit: e3405917a1806971d9e72a94186b299f05581e1a
branch: squashfs-fix
