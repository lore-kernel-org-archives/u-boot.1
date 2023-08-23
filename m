Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C828EE49A5
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 00:17:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C03C8864B3;
	Wed, 23 Aug 2023 02:17:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="CUoI1Q80";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fag79Bzk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5405F864B9; Wed, 23 Aug 2023 02:17:22 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D3A8864C1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 02:17:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RVmxV6Yt6z9skp;
 Wed, 23 Aug 2023 02:17:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692749838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=dv6NxLJXMjpARlPRU7QOT6GSYVWFSdv49RcuFoJf15U=;
 b=CUoI1Q80HIB3SjNu+hgqsJz3Mmv4GbBXNVKnWtXsOkNqOft0aBRX5Vq5PdMZgt7ChYEnlk
 4mTkWgAJa7aWWqzckW164udFhzlsow4MjbEz6CYVkszdWHSXeQ+LphlrzHh8+5vP1iy+Ql
 mh0rxV23W5ZHkHD/xXvlWx96I5zsLH6qY3lUdeOL/MGY9sWYfrM8zKgx5vw+B3F0A1qyc+
 V2OnYskQaKXjpRHBRFoOwpdendOYLk+27Kd9bonm/0oI1r0GtZ0It/y/cSHK0cNTgJT0l9
 r+vCE5XbuknmQND/ZyFOqS81lODHkxoEwO56U0AqUus1ksvEc2SAuLfXepbNuw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692749836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=dv6NxLJXMjpARlPRU7QOT6GSYVWFSdv49RcuFoJf15U=;
 b=fag79BzkgZXVaxLyp2qq4TXOIXLCKJXgxqDO44VLglIUzOyI4CkHBE/39UeBUtuCpUFfhI
 fTJysBFD792C0Ikgm4iNQy3VJL0b1yOPDbMfhhAXQpXe8xzJFfa3wig+lzoQ1gDC17RzcC
 52jPgaC+HpGc0R9MlTZh708zS9MYBbVoHnKwejk2KMj8w5ixrQOE5sI/A6mWcbi6Ld0l9l
 f+DFhUDw9FoT3nKTXC/RxN9GbUUreV0hzjRVInBeqB8VjbAGacZOy3MC0AiFFMG31DRKYF
 TcRB+yl7M5Ei7lswntnJ1LlBKTh+bjiMBWpdVRc6NKiwLy0n3bsstQzyC79E9A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonas Karlman <jonas@kwiboo.se>, Mario Six <mario.six@gdsys.cc>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH] configs: sandbox64: Enable legacy image format support
Date: Wed, 23 Aug 2023 02:17:12 +0200
Message-Id: <20230823001712.266249-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: t3semqwbpbaqbnonxsx9gquycf37qk76
X-MBO-RS-ID: b06f0d2352c6b94f4a1
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

Align the sandbox64 defconfig with sandbox defconfig. Enable missing
legacy image format support. This fixes ut_bootstd_bootflow_cmd_menu
test.

Suggested-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Mario Six <mario.six@gdsys.cc>
Cc: Simon Glass <sjg@chromium.org>
---
 configs/sandbox64_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index 55a01b7eb9d..b97380544a3 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -13,6 +13,7 @@ CONFIG_SYS_MEMTEST_END=0x00101000
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTSTAGE=y
 CONFIG_BOOTSTAGE_REPORT=y
-- 
2.40.1

