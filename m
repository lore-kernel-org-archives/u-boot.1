Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3763C02198
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 03:25:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B436B80DF7;
	Sat, 15 Feb 2025 04:24:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jUjXYNT8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 034D280ECC; Sat, 15 Feb 2025 04:24:05 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 897CE80F98
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 04:24:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3d1988be53dso4767495ab.3
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 19:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739589840; x=1740194640; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2R9fw80H3xQCRLS4aEBBcSEDBGZlxyy3RL/V7lgHx+0=;
 b=jUjXYNT8Yj8Ps67DJbUCK0y4+26EyMIEhPydmWTYFINK2z77bcv7mUnqkpAzcEc3Qx
 FB2PWEUkgJFlRMc6d6wbBtSy4z+aFeL3OGYnJsfeUxK76MK/NRiJKCQdFUiyO8sOmHMb
 iGUtxatVoo4ZtSRzV3ucQARoWiexOrK0/puMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739589840; x=1740194640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2R9fw80H3xQCRLS4aEBBcSEDBGZlxyy3RL/V7lgHx+0=;
 b=N2SFPcAvss9jTDlFp4VU5GJKiIc37i5e/wKjgacWUr884/FgT9rL96oF86NuP6T3wX
 fAFLw7fUVOHEwaIyrhfF2LRbob0zvKdR3S2+2Gt9fs+/FsChvhRpvLHj0liXojHa/Sog
 xSf4uABl83ESwwr9i7xkx8gotDLR3a2SfrWWgjQNCVUuivIuxdlqkwAhYjghJl+onYwm
 KdLjln/asM9CRzUM9VjkmY6AWrorrprFtnQ6TeI2s+t4DC8D7ue6zj+i1JUyTm6FeWlT
 1MTmI89HgzQUF8iAWuwkvP9R/N43J2qUyTwGUwctrX1kfJjSO2ei712mR0oGQj1stwzv
 NI7g==
X-Gm-Message-State: AOJu0Yx0E4pVqnYJZuzzvbgsbd1Lpbcv9D1g1qXAU47G31QHdc9dJsV4
 iISCaWGJd80vzk9uD4rCZBxxfFDlFh8Thk+MBkiisJ7yhtZdK5qYqvdwph94xMS19tWPxtLu7UY
 =
X-Gm-Gg: ASbGncvxsC+IFAcq4CfDE3qFCzfwd4jdfxhYIwakYk7VL+unMizGoOAj1nTLrmG57Ix
 Fw+uyUkUi/EKMiHJoZZfo3/ODnb9Rm7lRAuJTyiWN58lAHhDhJUoZ8V0cqgWAPhS+do5aNKskeM
 5CKsX9we3lm/lAXoa35D15rYnwPGZuXFM0TyP+HDa7ZS4WiJQJzBPNklmAlnix9WbUtD+LXH54u
 MmjV3z6b+2qzWTxGeiKQBo4AkTWUWZehuf1iasfHuVfb/3GKtL5CWxeveAwqjCh8Nd2WTpkLCfn
 Q+2DpHQgagBsvrX2w+E1QPywApjx9uospN77ejKgIVhJknFHPLnF
X-Google-Smtp-Source: AGHT+IEGFKgRBIrW0hDUqRMOHaa1pJOJBXjJiscpif317Cm4Myjv3sgEkceMr/pBeJR2HsK2AjbrCA==
X-Received: by 2002:a05:6e02:378e:b0:3d0:23f6:2eed with SMTP id
 e9e14a558f8ab-3d2807b0595mr11120945ab.11.1739589840716; 
 Fri, 14 Feb 2025 19:24:00 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed2819d0f5sm1087697173.67.2025.02.14.19.23.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 19:23:59 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 19/29] efi: arm: Drop exception-level code when running as
 EFI app
Date: Fri, 14 Feb 2025 20:22:40 -0700
Message-ID: <20250215032254.4121030-20-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215032254.4121030-1-sjg@chromium.org>
References: <20250215032254.4121030-1-sjg@chromium.org>
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

The switch_to_non_secure_mode() function cannot be used since EFI is in
charge of managing exception-levels.

Build just the exceptions.S file.

Modify the existing SPL rule to cater to the EFI app too.

This is quite confusing, so add an issue to clean this up:

https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/36

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Rewrite the commit message

 arch/arm/cpu/armv8/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/cpu/armv8/Makefile b/arch/arm/cpu/armv8/Makefile
index 2e71ff2dc97..7bd6cf21b19 100644
--- a/arch/arm/cpu/armv8/Makefile
+++ b/arch/arm/cpu/armv8/Makefile
@@ -13,7 +13,7 @@ ifndef CONFIG_$(XPL_)SYS_DCACHE_OFF
 obj-y	+= cache_v8.o
 obj-y	+= cache.o
 endif
-ifdef CONFIG_XPL_BUILD
+ifneq ($(CONFIG_XPL_BUILD)$(CONFIG_EFI_APP),)
 obj-$(CONFIG_ARMV8_SPL_EXCEPTION_VECTORS) += exceptions.o
 else
 obj-y	+= exceptions.o
-- 
2.43.0

