Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4BACE7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 16:32:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61BA280323;
	Wed, 11 Dec 2024 17:32:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="rrrkAi1S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9CC28037D; Wed, 11 Dec 2024 17:32:05 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78175801E7
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 17:32:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 606B94063A
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 16:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1733934722;
 bh=ezo2DI/RVObPZyn5Y7v9dmECHpvo+HFAScYpnw2ju/s=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=rrrkAi1SGvSTaopSao9jbnQ4T8Wu14qvlyCEmlLxPTC4sJKEOYAnBiowmp+E2xm9S
 0H0ubFKF2bfmBMSCVnFhvCl5buF9LmDHehIO6uZyrVpyRO5fmjHKGKBFH+Qi7/XSZr
 R7B1SLiNyv64m+eAntgktseeT2e7x93Xl2vtz8vOs76gf1+ACJ70F0Js2PtN4XZl9d
 tlwkIA++NdJ/QDT+BhtgrXnsiecr76khJXB5bcPKBm8szrSVMknLG5fjRa9BLGaDzp
 f6Qak9yrpTUzwFg7Crk8XQ88VBWVaRT2eYYMnHWjeEoKFq96vipjxsXSUDslqKnPqd
 SdYESsLfpcy1g==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-434efe65e62so26919775e9.3
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 08:32:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934722; x=1734539522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ezo2DI/RVObPZyn5Y7v9dmECHpvo+HFAScYpnw2ju/s=;
 b=cSMUm6tl0jzBJv35ukHLe4ukn4eHATk6TNVAZTFU69TlHpuzc8XFHTvh9pu4mrlAx7
 JQ95HCbgVyk6+BuGloAWCeCYjLGH4zDCRiK80Y8gz7gmIUB2MVcG+a+Xgi92GVQzXmHf
 9aiaKq6a5uecxaWz1GkxE25YSh1N/CxeMV7hEMd0USM9vNS88Q5DFc5IYF1Phx44EoWx
 zUHLblNIpMvvxHp27EUHfhcEvsauRjryiQnWncbKvD3LWOz1fuYol6Yj9ypqXsfknK4E
 CCsaBu/nIeloIr4rQHgSI2jDbRY2s/kTTjYu7yiODHh2n6wve+Wgc6HHLm3v/YdbTRBJ
 h1Hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuri+3af3fj9UQtOFpzLnZC1I0+4kUasct1J8tNQy0ePvf9jr5WL7IUK753Zlg7gDFYsMP8eE=@lists.denx.de
X-Gm-Message-State: AOJu0YxkiTybhTkh9xCprD49CNUJNEmKO3Qr/C0+ZI8yp0R1zIGJIQRy
 F3wEZsiqwz44AvyOtZJC9lSDjPCcbx+dqWA8R3fGK+1PBlzCjN67gpz35qgXPjxQme7GEO3bdTI
 hyFiuQIVZe+C6FabSekRQ12lcSNUXpoSeZCgapoAVIWKGV8Qd5U5582mJC/bDQis0OyM=
X-Gm-Gg: ASbGncve+Swg4+5kiP1biaXx/jDipSojbXzUPhYl6DME7utVb10I7oJb/W1ylVZMYmE
 6B9SPNemAQgdbaXlQWatJWAGHmUllb/kY2Hbu9Sj4Fk4rhjI0pDsJEygLxlAKQo5PzQXr91Gws0
 vXghJeCKH2xOD08tCDc2+yQH+R8xaKyXFZIldTaz+aqE/ZyAE1fbkZ1dGkq2OCPSibrbaOgoJkT
 ZdvwEVK4xJzAxNZUn4XOs1adwgche8GNdNn84L+sSUI3BmEweJxrrY3tbaRwgKAzZWXj2m9YqqD
 W1j/nLOrMRc9mevhPgbJieKs+of7KcJoD6xp2yBpQG/QTtcspDjuk240
X-Received: by 2002:a05:6000:1f82:b0:385:f56c:d90a with SMTP id
 ffacd0b85a97d-3864ced1f55mr2809595f8f.55.1733934721682; 
 Wed, 11 Dec 2024 08:32:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRrUQNxBZNK4MzOSh2J1TPHsBkBg4uH+NIP8BE61/wHihm7o5P5na1XByI/uj0QJwIvrNpTw==
X-Received: by 2002:a05:6000:1f82:b0:385:f56c:d90a with SMTP id
 ffacd0b85a97d-3864ced1f55mr2809566f8f.55.1733934721342; 
 Wed, 11 Dec 2024 08:32:01 -0800 (PST)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3878248f521sm1627311f8f.16.2024.12.11.08.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:32:00 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Ashish Kumar <Ashish.Kumar@nxp.com>, Gaurav Jain <gaurav.jain@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Jason Liu <jason.hui.liu@nxp.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/3] scripts: add volatge to spelling.txt
Date: Wed, 11 Dec 2024 17:31:53 +0100
Message-ID: <20241211163154.56272-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241211163154.56272-1-heinrich.schuchardt@canonical.com>
References: <20241211163154.56272-1-heinrich.schuchardt@canonical.com>
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

To avoid future misspells add volatge to spelling.txt.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 scripts/spelling.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index 17fdc620d54..aec616b1d3b 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -1584,6 +1584,7 @@ virtaul||virtual
 virtiual||virtual
 visiters||visitors
 vitual||virtual
+volatge||voltage
 vunerable||vulnerable
 wakeus||wakeups
 wathdog||watchdog
-- 
2.45.2

