Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3613C5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 08:29:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B96B7839B9;
	Wed, 28 May 2025 10:26:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QtXr/znv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97D7E83966; Wed, 28 May 2025 10:26:40 +0200 (CEST)
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com
 [IPv6:2607:f8b0:4864:20::d42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FA39839B9
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 10:26:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd42.google.com with SMTP id
 ca18e2360f4ac-86cdb34a56cso42805039f.3
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 01:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748420796; x=1749025596; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2RsWDqgdt/QyuSlEenZ0d3bKooSLL0Nf1VgwKhyEYss=;
 b=QtXr/znvVYYG6xXT9SCl6RL9uvA1d1pdO68QzRh0SmugpZvgUcMYFpuk7mSTkhCh8y
 F9yedNdDOQ4vc2EsTAPGld8mBfjal6LXgIdmJP4dWleXwrxNZLndzriTLEgcsxnn4Dj1
 CsYskYkIqaYzGC3BV7xdHUF2I/5gEs01OIe3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420796; x=1749025596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2RsWDqgdt/QyuSlEenZ0d3bKooSLL0Nf1VgwKhyEYss=;
 b=gWZMtWE3PiwsS0T84ZpqqCWU6LfSsYSaX7cZlSdI/6KhxaAFetUVaoK3e/OJux34WV
 XVF5SO0Qw3XG3CSMEA78ioRkGiJ61ILHdL7z1ACEe/PPzbgEj+lYauYDF77RNtdWqYOz
 7/ErwIDA6KjSDN28fDIDKUbVqDeEUdGPdzqVB99299yYcDTcoJWmLAbju7RPvG5bGVkA
 o3mMHZT2K8EggNwNxZocQgpK4ZMFRP6EugbHIjqDD8zHtmNnwbIt3ygFsrBru4Ers82V
 ZiL5mljQuH+luaz/SBqy7+p8X5HqoSKrnr+Hp2tZHVqcx7+uiUt4eVmQJXfclEMBhMWF
 lXug==
X-Gm-Message-State: AOJu0YypO4J5Pabzo+wdr4+in6A26w2ZlF4JPtqA1aJm6HFI6J7bRTNx
 zNchhoCPs76u1ErRlHS7udtue6jukhrZcEgEvBxXvx24nXGfD85JeLA3tU2zdyBfOyolqUCPRk8
 HDuoBlTHALoo=
X-Gm-Gg: ASbGncvYl/eoObBWtnt4n1xp/5LslD953Wz33xgSBqoekBR2Gy0THciUAVkqtwVfDpq
 utr66RlO38qJsNurq/OS1kU0WJcC1namKcpGZKledwbhCHBTLiVs9R0In2pNzd+njbDPzbt5Uu3
 phR74O2xkmyqAkyWp8DETspQlVinUAiZ4ZJkLvAUOOoa7Pd3HVFBhp03B8NpQbdFwCbCYr8MHtR
 SAT8pyFnx35uW2vM3hfYQpljWQMeS3xwn2ZbOrefsA4zGRUyRrHz4OF9U3PwPUatksjRCHWZc3M
 slRUXaS9qqiXPX2+lS0h5LadW6Nn99tb4AeJPSV0TS1FjffGkC/MsuhXZe/JWczLCfny3xXAa4c
 dtmbJ5SV9knMH
X-Google-Smtp-Source: AGHT+IGks4qcnX/8wNoH4oWS+5Xvf5qBBFyIB/ZwCxtRVsyXEFBdckQ1bDfEmpIGvne57kipZJ60IQ==
X-Received: by 2002:a05:6e02:3788:b0:3dc:8273:8c81 with SMTP id
 e9e14a558f8ab-3dc9b719446mr166048625ab.22.1748420796570; 
 Wed, 28 May 2025 01:26:36 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dd8b880f80sm1870385ab.0.2025.05.28.01.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:26:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Matthew Garrett <mgarrett@aurora.tech>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 24/27] x86: efi: Enable --gc-sections to drop unused code
Date: Wed, 28 May 2025 02:24:50 -0600
Message-ID: <20250528082520.152391-25-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528082520.152391-1-sjg@chromium.org>
References: <20250528082520.152391-1-sjg@chromium.org>
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

Add --gc-sections to help reduce the size of the EFI app. Add a check
for undefined symbols too, since using these can hang or crash the app.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/config.mk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/config.mk b/arch/x86/config.mk
index ac1f1922b12..0deea05c15f 100644
--- a/arch/x86/config.mk
+++ b/arch/x86/config.mk
@@ -77,7 +77,7 @@ CPPFLAGS_crt0-efi-$(EFIARCH).o += $(CFLAGS_EFI)
 ifeq ($(CONFIG_EFI_APP),y)
 
 PLATFORM_CPPFLAGS += $(CFLAGS_EFI)
-LDFLAGS_FINAL += -znocombreloc -shared
+LDFLAGS_FINAL += -znocombreloc -shared --gc-sections --no-undefined
 LDSCRIPT := $(LDSCRIPT_EFI)
 
 else
-- 
2.43.0

