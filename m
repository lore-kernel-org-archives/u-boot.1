Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D317FC369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 14:53:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67E1382B0E;
	Mon, 28 Apr 2025 16:53:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bTHk1V6r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1997882B0E; Mon, 28 Apr 2025 16:53:17 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC1DC82A33
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 16:53:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-af51596da56so4111547a12.0
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 07:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745851993; x=1746456793; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=phMSs1UcX3mk09T1924n3NNtQ4ZgUYOA05WESdYqVkw=;
 b=bTHk1V6rt0RT5Hrxhbsy0nPtRoPjuJT+D30C/oG7HtwLtNQzyQmUh+8t4gdGWmuBMp
 LOPDdynkDLTQ/pbB5Qzqb18s5NO6T8erHee/QWaU3kaaQR0y2OclFOyKVtTgqK5J/SaE
 X1qhXWaIjUBHE3tdC+VVgSwKTy8p1XSuYJzNx82KswGXroZqkWdfc764JNNY5Zs9qQay
 +M0tY9etVHHs+rwHct+0xZs58POD47MPE09BKx8w2b2u1xInQoqy8fPK60iKgrtmsYxx
 Yaml78RmiYDlLF4GChme7I44YI3C7JDqR1SgXl0oIxJcqhFIH+KTBM+mIqYNBz/nQDW0
 6mZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745851993; x=1746456793;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=phMSs1UcX3mk09T1924n3NNtQ4ZgUYOA05WESdYqVkw=;
 b=DuG3yLNlgeXSoT+o5oHy8j/uDoiKjQDnHokMM3Q1jYDUdMxDe66pQ5x5rGJjW8XZbR
 8/CyaMzJ1lv+9QZP78MHQyexd97vojlWtlzRsDsqRRiet1sKPm8NBsEyY/6z250q/gx4
 rh/Is23tEeZh6EPkGR5fJVRuzyPzQ6BFiySqpxw/PpXb9YUsE53L3g32taLRaiBjcAXe
 GmX7rcexf6e0KGeybj+wfYbaCJ0HctEdAAbEgAoZZI3Q+wSUhRZuabT0K8k1DH+rObZB
 pNXzxM8dECVyteJzok0fKZCfNv89HdnPJmhqoZ6PG//yhfjUyG5MO2eb0jh+h9JQDHkU
 yRSQ==
X-Gm-Message-State: AOJu0YxHXnb+Bn8SbXHrA6XHex1IHrJMrPRwdhVCN4Zc6VO6HPbpYJW+
 lCmbQB8zNkVFESQROxYglDgha72Vhb2slDkqvNnrtOg9KQsGwc5D4QW/6Ap1
X-Gm-Gg: ASbGncuoL+egJYfsV6LFZ9dFDfOmWe5ehJBBh/rEJd+ohU2lZVur/NDXv/Q/jGBzF7/
 Y/zmRB6nx91liSML3IqfUX+cJuwZW2AmCCIoO3DBDHVvqVd0H3yucPl4xnQ4KHjjNMy5i0lPxCr
 dgn8SAWgcwNNFPl9EH/lE9AysghW2a22ahVBN0SBVpE9EFAClyuKTsYa6svhWWozhbYee8UM8+X
 atqNALB/KLnSi8I5Ri85l2bAEc6OtE/xMsg+/qSXIGDqXwImSmN0c9V9v/cgMOcUMzoh1KYsaL7
 vDa6cRBrjwaKmSwjFkb3MKiJotFvXQLxLJ4m/mQho2eWLbg0cZAIzMLna/FELgc=
X-Google-Smtp-Source: AGHT+IE1fbxYYqar3cRU5GmhpSyircDWQoVrLEEZVIzxm8VcIPEyVre7GetH75O9uhz4g/7Q49j6Gg==
X-Received: by 2002:a05:6a21:78b:b0:1f5:8072:d7f3 with SMTP id
 adf61e73a8af0-2045b99e1damr18148014637.30.1745851993169; 
 Mon, 28 Apr 2025 07:53:13 -0700 (PDT)
Received: from adriano.. ([2800:300:6f54:8180:1104:675d:ec62:4e96])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a9a58bsm8317367b3a.143.2025.04.28.07.53.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 07:53:12 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, o451686892@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v2 0/2] Fix initrd loading in efi_bootbin.
Date: Mon, 28 Apr 2025 10:53:38 -0400
Message-ID: <20250428145341.2091400-1-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
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

This series consists on a couple of fixes for initrd loading when
booting an EFI binary. First patch fixes
36835a9105c ("efi_loader: binary_run: register an initrd"),
second one fixes a small typo on efi_binary_run_dp. Patches are sent
together as the typo propagates to the first patch.

Adriano Cordova (2):
  efi_loader: bootbin: do not load an initrd if none is provided
  efi_loader: fix typo initd_sz to initrd_sz

 boot/bootm.c                 |  3 +++
 include/efi_loader.h         |  2 ++
 lib/efi_loader/efi_bootbin.c |  9 ++-------
 lib/efi_loader/efi_helper.c  | 29 +++++++++++++++++++++++++++++
 4 files changed, 36 insertions(+), 7 deletions(-)

-- 
2.48.1

