Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09604C61DD6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 06:31:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 82DAF4083F;
	Wed,  2 Sep 2026 06:31:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QssvLF6LRIv4; Wed,  2 Sep 2026 06:31:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788330688;
	bh=Hi632BLtZsjN/oXFTB9dfjl9R+3i4hCBzM949zW/DM4=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ckm8LGzLtyYzqAelI9uiMghXC9QZxdyFvPyqRmbe4MR4Md6ub8eqhlGY99gyzoOQ+
	 Qajq5V3c3S4fZ4tKsysrG+20AJyX/b8H9T6fMFQN2BG7ZV9nTRo0ZXQOkNw4ZgsZMT
	 hIbuzYzH+i6zxObXjMFR1cWPG5/tCoAzl8fR/pWVULt4bJ9Re46e3j8THOlrUvI4/f
	 gDW/xB+01l+lOXr2tDY1xFFZvUNWpwcJMUTdPgJrW970lchqW2m4peqzxj9dTp3rJQ
	 mpKIpC1FxTfR9KRjalDiCEJkkRvXVtquTuHauhPXLlktq5O7ZbUzv357CmDCqzTGjf
	 nR33rWE0XkSiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7024140828;
	Wed,  2 Sep 2026 06:31:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A61EB465
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 06:31:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8C20480E58
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 06:31:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R0LIBCwoikIq for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 06:31:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.154.239.83;
 helo=forward100a.mail.yandex.net; envelope-from=nikita.shubin@maquefel.me;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=k0fapSmD
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net
 [178.154.239.83])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8A3CC80E54
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 06:31:22 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c17:2010:0:640:2180:0])
 by forward100a.mail.yandex.net (postfix) with ESMTPS id AC881C01BE;
 Wed, 02 Sep 2026 09:31:11 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net (smtp)
 with ESMTPSA id 9VdE69DeMiE0-o0y6ocbN; 
 Wed, 02 Sep 2026 09:31:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1788330671; bh=Hi632BLtZsjN/oXFTB9dfjl9R+3i4hCBzM949zW/DM4=;
 h=Cc:To:Message-Id:Date:Subject:From;
 b=k0fapSmDoB3pdYj4XdNny8lSPrMpMI8wP9+SXcjJNnrTvUJ1Pg40erdcHK0Ps2Dk6
 X3efyQcnP9jDIIyFmJ7j61hTbnN73gZ9ZwWfTGIw2iEJHDA84hOr3b36ZC5DxBwqzQ
 dUiB3iK9L4jRd7h4oU+uxa5uAxLCnVybKVgNX/zs=
Authentication-Results: mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
Subject: [PATCH v2 0/6] RISC-V SPL: fix OpenSBI FULL FIT loading
Date: Wed, 02 Sep 2026 09:31:10 +0300
Message-Id: <20260902-riscv-full-fit-support-v2-0-493e904a129e@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNSQ6CQBBFr0JqbZkeVNCV9zAssKmWMgjYUzSEu
 8uwdvmS/98bwZNj8nDJRnCU2HPfzaB2GZim6h6EXM8MSqiTyLVEx94ktLFt0XJAH4ehdwG1ErU
 ubKGlJJjPgyPLn1V8Kzf28f4kExbbsmjYh95913KSy26LFCL/F0kSBSpZ6YPNz0YfxfVVvSNZa
 vcvgnKaph/M3Dcf0AAAAA==
X-Change-ID: 20260731-riscv-full-fit-support-320d38f8311e
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788330671; l=3605;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=tsAs/QHOX0E5OD/F15LUbIT/nRRjPrYM6JCAd6+RAUU=;
 b=nb9bOSp7z/0yrnpypzHcHl3yDzEqceVlssXjsu8vPX1e8A+XMMdArbpJciqTDyBh24VI9el30
 /kbrSAtfNNxAW6R4FuHICarhOz2oZ5mTaJCTEh4Wpgldf89cBjhNW1n
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi all,

This series improves CONFIG_SPL_LOAD_FIT_FULL support on RISC-V, primarily to enable loading OpenSBI as firmware and recording loadable images (e.g., U-Boot) into the FDT passed to the next boot stage. This aligns spl_load_fit_image() with the behaviour already present in spl_load_simple_fit().

Patch summary:

1/6: Allow IH_OS_OPENSBI in fit_image_load() so OpenSBI firmware can be loaded without error.

2/6: Enable spl_load_fit_image() for RAM boot when CONFIG_SPL_LOAD_FIT_FULL is selected.

3/6: Use map_sysmem() for FDT address handling to keep the code sandbox‑friendly.

4/6: Initialize spl_image_info in spl_test_load()/spl_test_load_fit_full().

5/6: Record loadables into spl_image->fdt_addr during FIT load, providing the entry addresses needed by subsequent stages (e.g., OpenSBI).

6/6: Add a unit test to verify that loadables are correctly recorded in the FDT.

Tested with provided sandbox test with a grafted FIT image containing OpenSBI (firmware), U‑Boot (loadable) and a DTB.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
Changes in v2:

Addressed all review comments from Simon Glass:

- Patch 2/6: common: spl: ram: Add LOAD_FIT_FULL support:
  - Reworded commit message to explain that FULL parser is needed for full image verification (CONFIG_SPL_FIT_FULL_CHECK)
  - Added fallback: if spl_load_fit_image() fails, try spl_load_simple_fit()
  - Mentioned fallback behavior in commit message
 
- Patch 4/6: test: spl: Zero spl_image_info:
  - New patch added to zero-initialize spl_image_info structures in tests

- Patch 5/6: spl: fit: Record loadables to spl_image->fdt_addr
  - Fixed typo: "lodable" → "loadable" (subject, commit message, code)
  - Replaced -1 with FDT_ERROR (from image.h) for missing entry point
  - Moved FDT size adjustment before loop: use fdt_shrink_to_minimum() once instead of fdt_increase_size() per iteration
  - Extracted duplicated code into helper function fit_record_loadable()
  - Replaced debug() with log_debug()
  - Removed backslashes from debug string concatenation
  - Added note about gd->fdt_blob limitation in commit message
 
- Patch 6/6: spl: fit: Add test to check loadables
  - Fixed typo: "lodables" → "loadables" (subject, commit message)
  - Removed unused variables (uname, str)
  - Added FDT size fix after fdt_finish() to prevent external data offset drift
  - Replaced #address-cells = 2 with ADDRESS_CELLS macro
  - Replaced fdt_property_u64() with fdt_property_addr() for entry/load properties
  - Extracted duplicated image node creation into helper append_fit_node()
  - Fixed assertion: ut_assert(noffset > 0) instead of ut_assert(noffset)

- Link to v1: https://patch.msgid.link/20260807-riscv-full-fit-support-v1-0-21a34f79c350@maquefel.me

---
Nikita Shubin (6):
      image: fit: allow IH_OS_OPENSBI in fit_image_load()
      common: spl: ram: Add LOAD_FIT_FULL support
      spl: fit: Use map_sysmem() with buffers for fdt address
      test: spl: Zero spl_image_info
      spl: fit: Record loadables to spl_image->fdt_addr
      spl: fit: Add test to check loadables

 boot/image-fit.c         |   1 +
 common/spl/spl_fit.c     |  66 ++++++++++++-----
 common/spl/spl_ram.c     |  19 +++--
 test/image/spl_load.c    | 184 +++++++++++++++++++++++++++++++++++++++++++++++
 test/image/spl_load_os.c |   4 +-
 5 files changed, 250 insertions(+), 24 deletions(-)
---
base-commit: cc8c034e78eba6b2a3845783889b80753bb1af1e
change-id: 20260731-riscv-full-fit-support-320d38f8311e

Best regards,
-- 
Nikita Shubin

