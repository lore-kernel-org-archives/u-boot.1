Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD6FC3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 16:54:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9E9583CEE;
	Thu, 10 Apr 2025 18:54:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cHygfBTj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F2AF83D0B; Thu, 10 Apr 2025 18:54:09 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CFA283CE8
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 18:54:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-603be85490bso547495eaf.2
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 09:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744304046; x=1744908846; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=VQP7WC0D2Xt4uqqIPFOTdMhRRWjljtZ/a/1wnqBxFzw=;
 b=cHygfBTjEcR60l2HB0ANFoASyNjtpSTfytyyQA/gR0LvlJsQRZ9GDRY2eHp7SNqb25
 lE+k8fFNRvmlX2eUO+0jeRggjdI1wdUgjeHLT4r+kqpJcuG+n64bj3uiOemC05dsHAci
 F7SZV5+MjUGmpTabCWGkcxVtocGLiaAtfOt30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744304046; x=1744908846;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VQP7WC0D2Xt4uqqIPFOTdMhRRWjljtZ/a/1wnqBxFzw=;
 b=tI8V7xv0UUz859GDHdWB5nxxdfGCc+KaAe7KcPB+fArcirHLxqbT5Nu1mVWuovr8aR
 2aemcovuVN9/YTSY1Ssx2C0s39TGElgCMsjHxB/tnn6Nnd6n0UgNb1qmz7QNnC+fpyQM
 6lAH0WMwBp+5+ZRKKl78pbq5/3IgfC9OtN0ypshs+++NyX5rSWBbT2QvgQv443mOT5Vv
 djnophuW5T3l2XhiWKkbxIYgbC2aSWLp/oCZUxMUOeGBK22Vj9uMEBQRiuIivF3PNc5E
 XefQgybn0g/B6wUKeSv4oRmNxmBtaAuoNLOAVIAmHbFN3Pk5EGgtpfzA8DzMFL2R1czV
 1DZw==
X-Gm-Message-State: AOJu0Yxxgr2AuABfTgTcYHbUSnjaQ9lM/EU4/INs9IIThUB2ExCzpB+b
 ytWVAFeyogojc92Ez1iieJ+RA6KIhRZBjW/aME0ttIqceoMasNB5k/98FPKd2u9BjeLUrY0eC67
 c
X-Gm-Gg: ASbGnctoIPafNoYaO7tmYsFe/jWY0/c1jiTO2CJ0xDjuHfI9dfaKvI/1s2oazf6qhYy
 kjLDEdVXZEDGrj0xGVcrwAUniZ0sd+fN2ncSBcsvLnT/ZY2v/efMD60Z4xrLAgu+q8fn5FoceOg
 Sf6vR5/EZpumjBvEuxPAMuwFbmBuaptt8M8mIYBbrpc0TvV0z3m+XZfiwTUpcn86Hniur1jSt2f
 42jrBPW2zwXiNunhWHS20p5vRN8xdFTjLYMmeKm+MqFWudtYNFL8GX8lP/+DCz8E3GxBqU9J1L2
 QB4QR22PSn6r7r07oEVtCRUhiaL/4fGQsjaK5CByN83Due9L1I9R2FnVcpwj2/YPoV1jaDfvw6h
 JxDan
X-Google-Smtp-Source: AGHT+IFXs3DGA/sax/QS/9QkZxC+hcYEDaY6pOnjQBVtg00xUoxqKdGHa4QYLbP1ANuvdpvPBB8v4w==
X-Received: by 2002:a05:6820:2210:b0:603:f2f6:fd41 with SMTP id
 006d021491bc7-60466c37905mr1557960eaf.3.1744304045802; 
 Thu, 10 Apr 2025 09:54:05 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6045f50ee87sm598601eaf.7.2025.04.10.09.54.04
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 09:54:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] Dockerfile: Add fdisk
Date: Thu, 10 Apr 2025 10:54:03 -0600
Message-ID: <20250410165403.2955751-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

We had previously gotten this package through a chain of dependencies
with guestfs-tools. Now that we no longer install that package, install
fdisk (for sfdisk) directly.

Fixes: eb1b90ec57a4 ("Dockerfile: Update to drop virt-make-fs packages")
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 tools/docker/Dockerfile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 589397bc1a23..a0fd174ff602 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -78,6 +78,7 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
 	exfatprogs \
 	expect \
 	fakeroot \
+	fdisk \
 	flex \
 	gawk \
 	gdisk \
-- 
2.43.0

