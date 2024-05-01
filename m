Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E81C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:59:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 482DA88BC5;
	Wed,  1 May 2024 04:44:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JosrAy3J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FB9E88BD0; Wed,  1 May 2024 04:44:56 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE87388B7B
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-69b782287f9so30784456d6.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531491; x=1715136291; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XgRLobhlUI/QZSgieMY7Whx9q4rQ/f0H7aOWyw3fNsc=;
 b=JosrAy3JpZhc4nHVknEFzchjEaj90ie/OKB4A1zEuklaFrjpWf8r9dtKCprtth5CiT
 ze6wg+7VDGu/nzr+cgw15SL9uM/wske1nfbgqgJBsfDj72xTWnqvX1x57z3JDUuIekaF
 F607TEFBURDSBDYMcEwooSH+1dfKgF330jXd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531491; x=1715136291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XgRLobhlUI/QZSgieMY7Whx9q4rQ/f0H7aOWyw3fNsc=;
 b=E2cSfPzk+gWM2D+TKDejvwKoHo855uDt4qJA1KEoyDfY2w9+xyYd9xsisw80xPgAbC
 2N9pCipq/PeSYLcRQEC9ojFke89Jv6Vt9NngWxjzQMDm+7KVZRD86Kr4UUhIisrdIeKo
 EUDZB/M0UqpUNpy0+fgTRMKAwajGMbW5ZuIcUc4hXusCmkg0aZuHtuvuxd5a3dJEv5eW
 O80NL4zY/18HWIej9qsK1nSK9+WFcFuSc21xOW4vqDwQe8ur/onCV2ZyKzIwhklWBvYm
 6/xTjG+A1Y/wGoyFeveQvcLw2dnLk5iE7NhmCweHkTgR0n3VrZ9BgTnPk/36z8X3iEEU
 CfUQ==
X-Gm-Message-State: AOJu0YxKFcI9vVZDtLKevzLFriSP0ildEVLTlhqFG8v8pcvC4A0uK/Vt
 h0YHXTLFbM69KVg0s05FNOOx7SQ3GrN4nEVrndj76ep08ulVWG/GwjGxmJy9OZqpp/bc30k3jy9
 K/0f6SA==
X-Google-Smtp-Source: AGHT+IEJUmcIFfjKh4k8dW+d06qfxMxQVXbDFXc46rfaZoq3D0B1WUuYu5hu2XXKym2EEKnTwtLffg==
X-Received: by 2002:a05:6214:d02:b0:6a0:b3cc:ee0f with SMTP id
 2-20020a0562140d0200b006a0b3ccee0fmr1451552qvh.43.1714531491519; 
 Tue, 30 Apr 2024 19:44:51 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:51 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Dennis Gilmore <dgilmore@redhat.com>
Subject: [PATCH 079/149] board: kobol: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:42:06 -0600
Message-Id: <20240501024316.1767971-79-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501024316.1767971-1-trini@konsulko.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
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

Remove <common.h> from this board vendor directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Dennis Gilmore <dgilmore@redhat.com>
---
 board/kobol/helios4/helios4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/kobol/helios4/helios4.c b/board/kobol/helios4/helios4.c
index 9c5b687b3e8b..4c8407bb6768 100644
--- a/board/kobol/helios4/helios4.c
+++ b/board/kobol/helios4/helios4.c
@@ -4,7 +4,7 @@
  *  based on board/solidrun/clearfog/clearfog.c
  */
 
-#include <common.h>
+#include <config.h>
 #include <i2c.h>
 #include <init.h>
 #include <miiphy.h>
-- 
2.34.1

