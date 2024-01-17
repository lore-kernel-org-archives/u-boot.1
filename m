Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C9CC47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 22:25:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1943287B34;
	Wed, 17 Jan 2024 23:24:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="t7J9qHpd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2485987885; Wed, 17 Jan 2024 23:24:42 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 458D787ABE
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 23:24:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 0014ECE1D04;
 Wed, 17 Jan 2024 22:24:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A8A2C433C7;
 Wed, 17 Jan 2024 22:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705530274;
 bh=bYs9JwwfQHhYw3Uf6djy7mdwpLM54wPS1sbv4CA1fVo=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=t7J9qHpdfZ7394Cn85HnkIV53kRxyPeEIjXHi1vupkoMDCCa6XEbJg/u7flFMJkhB
 P52IgZo7WoFw01r7kD7j02SCn4Pbdfh1ZghjsTZ2OvS2GJdIqkapLfMo8Amcwjxkhg
 zHvmq9cEMPfbCYaSZH1xPUGLXux7JOUX0XlkiZ6RpU0s/msU0XJsQhmg+lCAKFccH1
 11MxIcDKtkqmS7JYiJXLTBZyQHRvltQLGLbnRRkkUZ7l1aPqeDS7XlTJaiUoycbIP+
 Ro/ecwLTnwR/x9OgI6ysjk/CXPi+UCDvMeYA+fqLJlmjOP58vCaiHg9SRoWdovFe2T
 fZKx2Sfv0AV9w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF02C47258;
 Wed, 17 Jan 2024 22:24:34 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Subject: [PATCH RFC 0/6] video: Add UTF-8 support for UEFI applications
Date: Wed, 17 Jan 2024 23:24:26 +0100
Message-Id: <20240117-vidconsole-utf8-uefi-v1-0-539f7ce74fb9@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJpTqGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQ0Nz3bLMlOT8vOL8nFTd0pI0C93S1LRM3bREI+Mkk8RkM9MUMyWg1oI
 ioGgF2NhopSA3Z6XY2loAfOYismsAAAA=
To: Anatolij Gustschin <agust@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>, 
 u-boot@lists.denx.de, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2134; i=j@jannau.net;
 h=from:subject:message-id; bh=bYs9JwwfQHhYw3Uf6djy7mdwpLM54wPS1sbv4CA1fVo=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhtQVwfM51K/Pnqu2XX5Rq6Ho5tmu7o4aJ5dH+clWn2ER9
 Vr+cb5ZRykLgxgXg6yYIkuS9ssOhtU1ijG1D8Jg5rAygQxh4OIUgIl8XM/wm8Vqc3UY86mDrv98
 2D8FZkxY7N1RVef31+tnXnHiwvX/1jP8Ygrh5rlWV5HX87tSV6B2o5B4ayZrbR/TysX6YZKTQt4
 xAQA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/default with auth_id=62
X-Original-From: Janne Grunau <j@jannau.net>
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
Reply-To: j@jannau.net
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Andre submitted 2 years ago DM_VIDEO improvements for UEFI applications
using UEFI's EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL but did not follow with
suggested changes. This series takes care of the UTF-8 support which
required to draw symbol and box drawing characters used by UEFI
applications like grub2 and sd-boot correctly.

Compared to Andre's version this version has the following changes:
- use and extend existing conversion functions from lib/charset.c
- convert first to UTF-32 to support the truetype console as well
- conversion is conditional on CONFIG_EFI_LOADER
- use escape sequences in tests as proposed by Heinrich

Link: https://lore.kernel.org/u-boot/20220110005638.21599-1-andre.przywara@arm.com/
Signed-off-by: Janne Grunau <j@jannau.net>
---
Andre Przywara (2):
      efi_selftest: Add international characters test
      efi_selftest: Add box drawing character selftest

Janne Grunau (4):
      lib: charset: Fix utf8_to_utf32_stream() return value doc string
      video: console: Parse UTF-8 character sequences
      lib/charset: Map cp437 low chars (0x01 - 0x1f) from unicode
      efi_selftest: Add symbol character selftest

 drivers/video/console_normal.c             |  6 +++--
 drivers/video/console_rotate.c             | 16 +++++++++-----
 drivers/video/console_truetype.c           |  8 +++----
 drivers/video/vidconsole-uclass.c          | 18 ++++++++++-----
 drivers/video/vidconsole_internal.h        | 15 +++++++++++++
 include/charset.h                          |  4 ++--
 include/cp1250.h                           | 12 ++++++++--
 include/cp437.h                            | 12 ++++++++--
 include/video_console.h                    | 10 +++++----
 lib/charset.c                              |  9 +++++---
 lib/efi_loader/efi_unicode_collation.c     |  2 +-
 lib/efi_selftest/efi_selftest_textoutput.c | 35 ++++++++++++++++++++++++++++++
 12 files changed, 116 insertions(+), 31 deletions(-)
---
base-commit: 866ca972d6c3cabeaf6dbac431e8e08bb30b3c8e
change-id: 20240117-vidconsole-utf8-uefi-fa23b4ac65d6

Best regards,
-- 
Janne Grunau <j@jannau.net>

