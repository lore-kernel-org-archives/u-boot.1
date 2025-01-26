Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E73BEC0218D
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 18:44:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 281AC80FA6;
	Sun, 26 Jan 2025 19:44:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MKVkRyZL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC30F80F85; Sun, 26 Jan 2025 19:43:59 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DF4380FA8
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 19:43:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3cfc1ff581dso8079915ab.3
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 10:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737917035; x=1738521835; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vePgJ4s8qb1ZCw6INa7MdBZUvqYda3KQNEeTGNzEIvo=;
 b=MKVkRyZLJU/p6IANZ49Mscv3+3ZdqM5YZUAwl/rudeccM3aC7cHcmzJtpos1Kn0DvT
 KeiOBO41D+PkvR8M4agBY9/VsYEV/k9edVpTl2R5mvuHTEts/NkzMmObgTOXXAVRP48I
 n+yRnfqmDJLDqTGYSi+cWUJUeW72H/R0cfK9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737917035; x=1738521835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vePgJ4s8qb1ZCw6INa7MdBZUvqYda3KQNEeTGNzEIvo=;
 b=E1TMvT+n88C9QTSprfFNG1lHzEI84WjNJGABdD2GJ4d7B4X/BnxqmxI7FMNXkv/sOQ
 YycE7KWcOvYyjgY1u87Y4vMv4w24pyo2xaay0r8fdsRfTGEx714Hl3Yz1ZAMbQLOLHJD
 vznKb62HPHO9ZSSoJPsDcxd0qqiERTNot1GeLlN5xdCZk3ghjRcHnuEin0T55PR2rasP
 1smfjCgsGqCpGCI6yjdFNznqSBNRmRJYM+k5LbJJd0zevuiDPoMsYGWhaDnuqZBK4jkI
 tghG0qogcy/VpBYkorCqXPORrwLDTctTuNHO/AdNPNZBvUKVWsNeKWAztyfvonA4fgLB
 RRFw==
X-Gm-Message-State: AOJu0Yz+IM1eapdiKsAnNSwzO0jmI3DmesTTIgw91MLJLTe4bVjKkVXO
 lQu/M8trCDD6ghs0YwhlvID13StpJDKhNEo5qCCd7VP6D/9vOLAjSvApniX4/tUmJiXJ7U4aUIg
 =
X-Gm-Gg: ASbGncvVXXzitkdVUDjpAbNNZ0YHWdGYhAI/bByD6qeUinNbBWuiiWhWLyiLXtYz721
 06vkhXH3cyclrUPRoR8+tMgocNEenhtccku1vhXN06IRMVaz5mu8iXMYo2wkbOVTV/JK5qD/Igf
 nm+VEZKjRDt9h1wjgwA9Q4eoyNhOy20hzo2+IewWVO4e083kDxlRNV2EDSWUw2x4Ksf2voIWuga
 OiGo+WsMWloMMFjEMvFiGoQ1fjh/1met0vyvkPplSkKBaum4XRaisLo1YlEGSjfL8sLnt+DmqQ2
 AR1eX+wYX7u++yWlx+25q2ZIyxTwGoGqTYPG5qrsUQ==
X-Google-Smtp-Source: AGHT+IE7zjzoCMd4vO0ik8IOCPK7CX2BWDAW1d01zx4CWel0plTfpXkV/TtvNyQn713xQNIIvFJsbg==
X-Received: by 2002:a05:6e02:144a:b0:3a7:8720:9de8 with SMTP id
 e9e14a558f8ab-3cf743a907cmr307287755ab.5.1737917035679; 
 Sun, 26 Jan 2025 10:43:55 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ec1da317fesm2160641173.42.2025.01.26.10.43.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jan 2025 10:43:55 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/19] spl: Adjust debugging and xPL symbols
Date: Sun, 26 Jan 2025 11:43:15 -0700
Message-ID: <20250126184333.4058848-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250126184333.4058848-1-sjg@chromium.org>
References: <20250126184333.4058848-1-sjg@chromium.org>
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

The size of some malloc() fields has reduced on 64-bit machines, but
the spl_reloc code was not updated. Fix this to avoid a compiler
warning.

Also update for the new xPL naming.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/spl/spl_reloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/spl_reloc.c b/common/spl/spl_reloc.c
index be8349b535b..324b98eaf98 100644
--- a/common/spl/spl_reloc.c
+++ b/common/spl/spl_reloc.c
@@ -154,7 +154,7 @@ int spl_reloc_jump(struct spl_image_info *image, spl_jump_to_image_t jump)
 	rcode_func loader;
 	int ret;
 
-	log_debug("malloc usage %lx bytes (%ld KB of %d KB)\n", gd->malloc_ptr,
+	log_debug("malloc usage %x bytes (%d KB of %d KB)\n", gd->malloc_ptr,
 		  gd->malloc_ptr / 1024, CONFIG_VAL(SYS_MALLOC_F_LEN) / 1024);
 
 	if (*image->stack_prot != STACK_PROT_VALUE) {
-- 
2.43.0

