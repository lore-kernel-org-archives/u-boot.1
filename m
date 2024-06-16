Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C05C27C53
	for <u-boot@archiver.kernel.org>; Sun, 16 Jun 2024 17:31:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74B23878ED;
	Sun, 16 Jun 2024 19:31:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="wMiCtn2+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C2FE88122; Sun, 16 Jun 2024 19:31:09 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 639108812B
 for <u-boot@lists.denx.de>; Sun, 16 Jun 2024 19:31:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-041-025.um47.pools.vodafone-ip.de
 [178.202.41.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 3EB5140F7C; 
 Sun, 16 Jun 2024 17:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1718559066;
 bh=1eapSsFd5zDuuemIQfOOIZJOtVCHkhaQAjVR1UtTh84=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=wMiCtn2+uAZiXCHVMSbaWWSpJY8PtXebiTfS7p4ZWkhCVqm4vRqIlRy8A1chkI3u9
 /NPNZf67XnlDNbvrwEdPdyQBGERU9d26x6X/PdhBqUt1X31uLh7yDJbUtGFFidrcyA
 3SmhZM8wjforKY9bLTmbiwJBDwdGHyREsIKBfcIxUkvs9YEO5Sg33DkpJs24CwYytl
 S0p06W6ZTHqjjKwKQgZiOei8rtSfpWaSplI3zUNQUZiJrH/9uKNrE3b20ZTO+gsN3M
 gdjZfMvNZke13QDYUpPJvibxhZfpz+sv8FnYWm14AEe3MmXSVLLcxBgnRlvOYTWcVv
 i3GtRQw0ZgYRg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/3] cmd: avoid duplicate weak functions
Date: Sun, 16 Jun 2024 19:31:02 +0200
Message-ID: <20240616173105.7430-1-heinrich.schuchardt@canonical.com>
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

If we have multiple weak implementations of functions, the linker might
choose any of these.

ARM and RISC-V already provide a weak implementation of flush_dcache_all()
but cmd/cache.c provides another implementation. Add an #ifdef to avoid
the duplication.

The EFI sub-systems uses invalidate_icache_all() after loading binaries.
Both the EFI sub-system and cmd/cache.c provide a weak
invalidate_icache_all() function. Remove the EFI instance.

For ARM11 functional implementation of invalidate_icache_all is missing.
Add it.

Heinrich Schuchardt (3):
  cmd: avoid duplicate weak flush_dcache_all()
  arm: implement invalidate_icache_all on ARM11
  efi_loader: avoid duplicate weak invalidate_icache_all()

 arch/arm/cpu/arm11/cpu.c          | 12 ++++++++++++
 cmd/cache.c                       |  3 +++
 lib/efi_loader/efi_image_loader.c | 13 +++++++------
 lib/efi_loader/efi_runtime.c      |  7 ++++++-
 4 files changed, 28 insertions(+), 7 deletions(-)

-- 
2.43.0

