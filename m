Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB82D1AD5A
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 13:34:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C36688DE5;
	Wed, 16 Oct 2024 15:33:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K0v+v6UC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F205B889C3; Wed, 16 Oct 2024 13:25:11 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C245E88717
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 13:25:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jelonek.jonas@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4314fa33a35so6662715e9.1
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 04:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729077909; x=1729682709; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=z9k91Hxbmczl+ZxxH+dj80D4jEZjrNH+jBqEDsqq+Lg=;
 b=K0v+v6UCgca3ODsket7rZD9F9v/ZHmVVLMRWDFLCN0VphtU3ykCJVP4ZArdraotEF+
 WUCrHQdlTaHN6dSasE/GuLt9Y6YWoqla2mrdMdWdF2fVhsKDvCDNjk54MnCSiYcvUQ3O
 Vz6AePFOsctNWQr3j33xYzvzsXx3m+AZjD+tgSNlI6EPIvIo3vUtN4mLsTChrc2HLeJ8
 LuVkq5VAfOBFnHs57JHn9VFyB4lc1BCnuvoVr6tzwpSvrJFIbHIE4P7r90kst6eCftJh
 r9Zaq+22N8VG+sfQVU5NIlfwYkEQF8ZsvNYQD05qOCvAnine1PFq9Aads2Y8eiuQRaMs
 rZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729077909; x=1729682709;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z9k91Hxbmczl+ZxxH+dj80D4jEZjrNH+jBqEDsqq+Lg=;
 b=eK74BUjwe06iM7BhCxaNodFERf5YO+Zu22PbianItB30oYr6p6GYfq91u2MG3PAXyC
 rof97KnUNGTfzWHv/zujUajMeoCKGSQEZdZWenCHGQdDG1yRndugp6DhLm9tf1UXWe1y
 pQR8+uwPF9PYG5ZmxS5SSlespltZqnJ/fP2Sr2D/Vxf+g8LJNro2z/lPC4lhoNSfhZwI
 sKgU6sb1MmQj+vAa1MCPyJaUvEdJ8OlELuy14ujhB7U5gB4VrvJ5YbVUuApsCqO1Gzf7
 P8zjllmiyBoDO7kIqdk3CSmYIEqI8ltpOOtoG7H+ohFhWFA7VKEL+3Wytr8mR+GvPiKf
 vRuw==
X-Gm-Message-State: AOJu0YzDxyGPhRxf/FxfUl3rl6bR1YA57MolyAd3MYogU8moFwd5NX8S
 2lVDoVlvEbypx3WxffbSNVOLbuADwlpXHDxTeRo4hUArKUwliXJiwF9Ppg==
X-Google-Smtp-Source: AGHT+IE/7y9JskxxT1RTwBk7HvCSEWWSBeVJkv7sBnD7xijUtIfrT8lykGRUog42rfpME6u8jKJOow==
X-Received: by 2002:a05:600c:5129:b0:42c:b750:19d8 with SMTP id
 5b1f17b1804b1-4311deb5f3cmr141880765e9.4.1729077908717; 
 Wed, 16 Oct 2024 04:25:08 -0700 (PDT)
Received: from localhost.localdomain ([2a01:599:81c:8ff7:8cd1:2207:fa9d:5a1a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa7a23csm4092572f8f.18.2024.10.16.04.25.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 16 Oct 2024 04:25:08 -0700 (PDT)
From: Jonas Jelonek <jelonek.jonas@gmail.com>
To: u-boot@lists.denx.de
Cc: Jonas Jelonek <jelonek.jonas@gmail.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/1] arm: provide noncached_set_region prototype to fix build 
Date: Wed, 16 Oct 2024 13:24:54 +0200
Message-Id: <20241016112455.35700-1-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 16 Oct 2024 15:33:18 +0200
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

In OpenWrt project, an issue recently occured after updating u-boot for
mediatek to v2024.10. When building with GCC-14 toolchain, it fails
with:
cmd/cache.c: In function 'do_dcache':
cmd/cache.c:57:25: error: implicit declaration of function
	'noncached_set_region' [-Wimplicit-function-declaration]

It is presumably caused by commit 7d6cee2cd0 ("cmd: cache: Remove weak
functions") which removes the prototypes. Arm architecture provides an
implementation for 'noncached_set_region', however it is not available
to 'cmd/cache.c'.

The issue was already discussed in
https://github.com/openwrt/openwrt/issues/16697
and temporarily fixed downstream in
https://github.com/openwrt/openwrt/commit/92ca322dd1f48158b8829fec59319a12e4ae4295.
Another user reported the issue in u-boot too, and confirmed the
solution working (https://source.denx.de/u-boot/u-boot/-/issues/42).

I'd like to discuss here if this is a proper solution to the issue or if
there is a better proposal. Since this is my first contribution, I have
barely an overview of the u-boot internals.
Please give also hints regarding any wording or explanations in the
commit message.

Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Tom Rini <trini@konsulko.com>

---
Jonas Jelonek (1):
  arm: provide noncached_set_region prototype to fix build

 arch/arm/include/asm/system.h | 1 +
 cmd/cache.c                   | 1 +
 2 files changed, 2 insertions(+)

-- 
2.39.5 (Apple Git-154)

