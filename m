Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E9FCAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 21:29:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B29E681D6A;
	Wed,  1 Oct 2025 23:29:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PDv5KmHJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 073468328F; Wed,  1 Oct 2025 23:29:31 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5BD780107
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 23:29:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-42d8ad71a51so4349715ab.1
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 14:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759354166; x=1759958966; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mLdPKjUBWVZoMziaAxlotj1jFqKvn0P8KDYyPwfoKtA=;
 b=PDv5KmHJFYT7B6Oia05RXiM4Xs9/LqV/Xm9+5pkcMxerqyfrgs3BtuWiTBjhh9USA6
 wzPQgkZD42xiUZC0i3d3ZPfH9cQVpUEpDJJtrdr312pl7gbTeTh8VwY5Xl59HkJTdxJ4
 9yaUrDLXHbUrecDMBv8dImayAjDeV9TK/kOfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759354166; x=1759958966;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mLdPKjUBWVZoMziaAxlotj1jFqKvn0P8KDYyPwfoKtA=;
 b=IcJlvr3V7Wo3R5jCLF1EAnL+wrJjsV7Kcyk66WWpRcA1YeEMs9zsxk1BENucMndvlF
 HGta3LJZ82ajyea8J4UjdD1xUMAg8/lWmD89Vyy6PJIPoul3k0tQvqm+q5SUAjyV56bK
 QhLOJU42m9JcaKpBWo2vvLMx9dP4SGw7ThsGisnRrpKmjWCbVYgJ9FJpZuJIj4goaapd
 y0vEYHACUV7yyye6vNn5FMVpOpe6A0oxKMn7s5Zbo9MJX3HMuhd64udDPPgcFhgyzJAo
 gZ4ymlhIjFKGRhICpzk4sExOmfagLPoVFrYP20NBJr1g2+AxaXkuW5qTSR8Yx6VTgjbq
 hDsg==
X-Gm-Message-State: AOJu0YxUEF0IvfIi0g0E9lfV2pIH/79OqDPj7QKlSUxG3QMIMNKRSuhb
 22b/lDM/Mgpl3o6t27dfwcydNQaGSgb7qa++Zy/Zr27thFh/Ala2B2Rn0ay7I9vGlylc6mFSUrY
 5cGTVZrkj
X-Gm-Gg: ASbGnct+yr7A3azBpsbqQTEowLUYKth8Nl9VlOAwsYxFmi2oHTPxxx7+LKGGJaQYmxm
 De18l+oQq688zsVDkJQGMVGFtM28y1SC+HNP/2mWybPPA1bnTdjYw7lTdrNsLOrnGN9I5wKiwHR
 Jwz0Vi33GXPrcJO8JGck9C5mS18gAcI9XUxpQCrNitBVwJjLxeSa2J/LoT/Eah9xdM2YbpCbACX
 ElXEKNfBQlePEy76KF9GABDDYPLCGX1ZUTNrKPMQsDJnwu7a4h9kkglSwBVrA8SFIrLTmmebhDn
 HeeLg3FbAVJHC+DSEVTraoq92zaricHfrcAVgcYaj6dC4AQPT3+IsNLoEctowevsMQWlmGhk0RO
 TBsiNQQGoV3zSbzDlDi0V92uVhEv505gttmGafNCY
X-Google-Smtp-Source: AGHT+IEncW3w4RYMYPMP9xZ/BX7XTZVg/5POF/H3Xx8cjqLhn3+B6Oa2YCP+A7g+DV7izpw2iHGI0w==
X-Received: by 2002:a05:6e02:4814:b0:42d:a924:f25e with SMTP id
 e9e14a558f8ab-42da924f2ddmr2892755ab.24.1759354165686; 
 Wed, 01 Oct 2025 14:29:25 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-57b5ec09429sm202844173.55.2025.10.01.14.29.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 14:29:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 00/17] boot: Support priority for global bootmeths
Date: Wed,  1 Oct 2025 15:26:25 -0600
Message-ID: <20251001212649.3263574-1-sjg@chromium.org>
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

At present global bootmeths always run first, before all other
bootmeths. Optimisations in the code take advantage of this, putting
them at the end, so they can be used once and then forgotten.

In some cases it is useful to run global bootmeths later in the boot.
For example, the EFI-bootmgr bootmeth may itself scan devices and the
network, so running it first can hold up the boot significantly for
boards not actually relying on EFI-bootmgr to boot.

This series introduces a new field in global bootmeths which indicates
the priority, using the same scheme as is used with bootdev hunters.
Thus it is possible to insert the EFI-bootmgr bootmeth just before the
hunter for network bootdevs is invoked.

Despite the simplicity of the concept and the relatively small series,
this is a fairly significant enhancement. It is also quite tricky to
implement, largely due to the way the original code was written, with
global bootmeths being a small, size-optimised add-on to the original
bootstd implementation.

For now we only allow each global bootmeth to run at most once, but this
implementation is written in a way that we could relax that if needed.
Then the bootmeth itself could decide whether to run at any particular
point in the bootflow iteration.

Size growth is about 390 bytes on Thumb2 (e.g. firefly-rk3288) if
CONFIG_BOOTMETH_GLOBAL is enabled, which it normally is. With that
disabled (which saves about 4K on the same platform), there is no
growth.

Changes in v2:
- Add a log_err() for an invalid state
- Update commit message to indicate the bootmeth will always run
- Document how the priority was chosen
- Add a bit more detail suggested by Heinrich

Simon Glass (17):
  boot: Improve comments related to global bootmeths
  boot: Try all bootmeths on the final partition
  boot: Move obtaining the label into a common file
  boot: Add more debugging to iter_incr()
  boot: Move showing of bootflows out of the command
  boot: Add a new test for global bootmeths
  boot: Update first_glob_method when dropping a bootmeth
  boot: Add a flag for whether there are global bootmeths
  boot: Keep track of which bootmeths have been used
  boot: Move preparing bootdev into a function
  boot: Support rescanning the global bootmeths
  boot: Only run global bootmeths once each
  boot: Implement a priority for global bootmeths
  boot: Don't change the method count after global bootmeths
  boot: Run global bootmeths after all bootdevs are exhausted
  boot: Run the EFI bootmgr just before network devices
  boot: doc: Update for new global-bootmeth features

 boot/bootflow.c                  | 318 ++++++++++++++++++++++++++++---
 boot/bootmeth-uclass.c           |  15 +-
 boot/bootmeth_efi_mgr.c          |   9 +
 cmd/bootflow.c                   |  66 +------
 doc/develop/bootstd/overview.rst |  40 +++-
 include/bootflow.h               |  39 +++-
 include/bootmeth.h               |   4 +
 test/boot/bootflow.c             |  75 +++++++-
 8 files changed, 457 insertions(+), 109 deletions(-)

-- 
2.43.0

base-commit: aff68c8514858ddd8d2e508d47bede566511521b
branch: glob-us2
