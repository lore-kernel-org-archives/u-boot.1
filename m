Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707D0C3ABD8
	for <u-boot@archiver.kernel.org>; Sun, 18 May 2025 16:03:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E282180584;
	Sun, 18 May 2025 18:03:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ifpBBerv";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="BZH8vs1T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF8D38059D; Sun, 18 May 2025 18:03:34 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87B128004F
 for <u-boot@lists.denx.de>; Sun, 18 May 2025 18:03:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4b0lwh1L8rz9tCl;
 Sun, 18 May 2025 18:03:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1747584212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=RrNilHxNauXcwFhE6ymI5zZHVM0JizIGtr0EVHlGWhA=;
 b=ifpBBerv+ZyOHSciR8bYLYE3CS2rHPAfWBclnricNZ9VnGQnA6tn7akuZF0qLBlBlpR9Mp
 uVtlFKkCvVB5X+tXQ4169PwGCXBVytMD+6AGV3NSiKg3s8iolAYM7+EvXrxz03aOfHR8A6
 y3M651/uebGhKcPZnTUs4sWl7NKrw7MPrCZgEo5OJrKTX67gzilJBD0CZAWkXWSpE1aJNK
 wqihEfb4ZrX2th0Li/iomy6uVupInlqybB9m30rp0cXuF444jNV02bJ0Rnl8uhKTkZnGpf
 vFlcHCWCy0r5H2jKbWVcjwGIsA8ICaFoJK1q1pkgKW9vHHZ5IUrryJm3f6Nl1Q==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1747584210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=RrNilHxNauXcwFhE6ymI5zZHVM0JizIGtr0EVHlGWhA=;
 b=BZH8vs1THQhsNIoSYH/FVjivFcN87sm8xT4cbelGc31ly/J+FmwQLrEgwQc6C4Unoe3aDn
 Wi192PU6YAgezYu3zkialsZeyaknMQMON09LyIDOd6cpBN/Hqa70vw64qwEY9V2nnLNRru
 fszi0swRd2DYxw3h2tF3XEiDk0KbmmHnH5hhBiMSKGEM2vXnj5qGRSjWHrNgvNieNSEAls
 1S6+g3WhBeo1c+NtfahgPCQ8dhgtNrF2kACW7UPxIQ+lqoQaiZ4GPUm8w5LXS3vLY/X9zf
 /KU+GiGVB+pMwzYJqWH3wSAmBabBMa20jL+FjEo1l37yWMOvenSm/tK+g/w/Vg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Edwards <cfsworks@gmail.com>
Subject: [PATCH v2] ARM: Align image end to 8 bytes to fit DT alignment
Date: Sun, 18 May 2025 18:02:58 +0200
Message-ID: <20250518160316.112532-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 2ff6ad3a73f7dac8181
X-MBO-RS-META: ath8kkm4ey865mgpfhci57a8e6mkbwgb
X-Rspamd-Queue-Id: 4b0lwh1L8rz9tCl
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

Align U-Boot image end to 8 bytes to make sure DT alignment requirement
is fulfilled. This fixes a possible failure in fdt_find_separate() in
case the U-Boot image is aligned to 4 Bytes and DT is appended at the
end at already 8 Byte aligned offset.

Link: https://source.denx.de/u-boot/u-boot/-/issues/30
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Sam Edwards <cfsworks@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: - Fix up u-boot.lds description of the alignment requirement
    - Fix up SPL alignment as well
    - Add RB from Simon and Tom
---
 arch/arm/cpu/u-boot-spl.lds | 3 ++-
 arch/arm/cpu/u-boot.lds     | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/cpu/u-boot-spl.lds b/arch/arm/cpu/u-boot-spl.lds
index eee463a1b1c..5aecb61ce90 100644
--- a/arch/arm/cpu/u-boot-spl.lds
+++ b/arch/arm/cpu/u-boot-spl.lds
@@ -53,13 +53,14 @@ SECTIONS
 		__rel_dyn_end = .;
 	}
 
+	. = ALIGN(8);
 	_image_binary_end = .;
 	_end = .;
 
 	.bss __rel_dyn_start (OVERLAY) : {
 		__bss_start = .;
 		*(.bss*)
-		 . = ALIGN(4);
+		 . = ALIGN(8);
 		__bss_end = .;
 	}
 	__bss_size = __bss_end - __bss_start;
diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
index 817e7a983ae..78aad093d3b 100644
--- a/arch/arm/cpu/u-boot.lds
+++ b/arch/arm/cpu/u-boot.lds
@@ -153,14 +153,14 @@ SECTIONS
 		__efi_runtime_rel_stop = .;
 	}
 
-	. = ALIGN(4);
+	. = ALIGN(8);
 	__image_copy_end = .;
 
 	/*
 	 * if CONFIG_USE_ARCH_MEMSET is not selected __bss_end - __bss_start
-	 * needs to be a multiple of 4 and we overlay .bss with .rel.dyn
+	 * needs to be a multiple of 8 and we overlay .bss with .rel.dyn
 	 */
-	.rel.dyn ALIGN(4) : {
+	.rel.dyn ALIGN(8) : {
 		__rel_dyn_start = .;
 		*(.rel*)
 		__rel_dyn_end = .;
-- 
2.47.2

