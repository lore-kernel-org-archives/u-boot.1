Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE78C5B543
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 11:49:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A74980E9A;
	Sat,  7 Jun 2025 13:49:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="atd1FbFb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A36A828F8; Sat,  7 Jun 2025 13:49:32 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41990807B1
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 13:49:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-175-200.46.114.pool.telefonica.de
 [46.114.175.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 6295A4B670; 
 Sat,  7 Jun 2025 11:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1749296969;
 bh=Rf2UQsgBhgrsIN4Yv2PWZIbps9qluhvsXGNZHqQVaHI=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=atd1FbFbJkNyYGLLEkEG5qhbGM4xvydnO80c5qdpQEiJXuKtE0c4gvMtPvMwQnG27
 ZseNIOQ1pWusTJcPLrxcqEwEIgLExFaBd6NUEk5ISe8tZoHZEywjyX7A4ZocQv0jpB
 Ql6R0yyJKqEE9F37pR2gNUdTjuK+NCgAmTLp1Y/IpdCFHPLXo5qL5g59YRYUZnSdhB
 PpEZels+7+dtxo2cucLZQZ0zQT8AKJS35CJ0Vj+Bb5OfjG8wo5QQvCtvDlM2H5lSxD
 ihUV3fyX5SKXvrxmQsATYeshCijITbTJZRD08OvIlrTM7+oBl3fIaGBxIyU2/XvGGs
 RpBUDLqvJFiog==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Mario Six <mario.six@gdsys.cc>,
 Casey Connolly <casey.connolly@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Ying-Chun Liu <paul.liu@linaro.org>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/3] sandbox: align LMB memory
Date: Sat,  7 Jun 2025 13:49:02 +0200
Message-ID: <20250607114906.209959-1-heinrich.schuchardt@canonical.com>
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

To implement the EFI_SYSTEM_TABLE_POINTER we need 4 MiB aligned
memory.

On the sandbox LMB uses addresses relative to the start of a page aligned
RAM buffer allocated with mmap(). This leads to a mismatch of alignment
between EFI which uses pointers and LMB which uses phys_addr_t.

Ensure that the RAM buffer used for LMB is 4 MiB aligned.

Provide a unit test for efi_alloc_aligned_pages() verifying this alignment.

Do not overwrite RAM size in dram_init().

Heinrich Schuchardt (3):
  sandbox: fix dram_init()
  sandbox: align LMB memory
  test: unit test for efi_alloc_aligned_pages()

 arch/sandbox/cpu/state.c         |  6 ++-
 arch/sandbox/include/asm/state.h |  1 +
 board/sandbox/sandbox.c          |  1 -
 include/configs/sandbox.h        |  2 +
 test/lib/Makefile                |  2 +-
 test/lib/efi_memory.c            | 63 ++++++++++++++++++++++++++++++++
 6 files changed, 71 insertions(+), 4 deletions(-)
 create mode 100644 test/lib/efi_memory.c

-- 
2.48.1

