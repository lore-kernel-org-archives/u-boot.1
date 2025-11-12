Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C39CCFA1A
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 02:02:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D45183B81;
	Wed, 12 Nov 2025 03:02:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="JlQ7Ue3Q";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="h7Eb9/eu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8BD483BCF; Wed, 12 Nov 2025 03:02:44 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1485F83AB4
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 03:02:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4d5mrK5g70z9shs;
 Wed, 12 Nov 2025 03:02:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762912961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=bfY42FQ1rd+17IN+KCvu1JbFZyR+mvGzR3dOtdR8+ig=;
 b=JlQ7Ue3QZFzhJAVwBD1PSqQ+ruDlwKNSuodDsR/bHJ3iQb5hMJhDd01YalFWofxLsiNr81
 kTR6jjzz4s65cZAEJ6EXqffvqAmJDTfO0SXu6lJFL9M9V67czRElU0ngn2yhm27CIHYjh+
 mVTkHcvS6xtqA/q/bLi3P09V4lucWZrB53zhkoYxqLkrpQw2rnJx57lITFDmweGUoOwCK5
 Cur/yNVgeYvCj4+015XyS4/Hx9Ossn59XdPOaGidNnKkumwaHl1HB41pKJeD0WJHqj5J6Z
 d200nA+/YEaddHvIRnewKj1Pq2zkYjFD6fv4/SEnZ7Lp2jsTUqPvLUq40ijJ2w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762912960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=bfY42FQ1rd+17IN+KCvu1JbFZyR+mvGzR3dOtdR8+ig=;
 b=h7Eb9/euv5QYR5gbcJYnJipSp+RzxWvQuyh1UYnvhuUk1foBxvG0qJuh8dwjQpB0tARbl/
 vg2qEKy9SYSg3+3dG3DeMGkNz6EhlheAa8uBqoGfLBf6RbRY7fpBYTq5Y7bXHaaaVqHU3A
 BwikhjT6z3Eagqp2THCt8YNXd12YPOMQZ61jVRe5ek23i+FXH3mxkTFtZkdxP2dSNTCX3X
 XvNLLSVkmV45CZymfkw+Yswgs5r/avW6ipGra/cVR0BJ4KMjTQ9ZSF0jgEcBNOycGV7zY9
 CVNVJ3w8Lj4olfU22Y70eS/GaqZkkprVG5FQV8iugocm9EI8ErKgAvUMqPUt2w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] test/py: Use aligned address for overlays in 'extension' test
Date: Wed, 12 Nov 2025 03:02:21 +0100
Message-ID: <20251112020230.414101-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: f694fea0afc965353cc
X-MBO-RS-META: 7jqx71m9weesid1dbk99kyxxu8wpw77k
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

The 'extension' test would set 'extension_overlay_addr' variable to
decimal 4096 due to conversion in python. The 'extension_overlay_addr'
is however sampled using env_get_hex("extension_overlay_addr", 0);
which converts the 4096 to 0x4096 and uses that as DT overlay address,
which is unaligned. Fix this by setting extension_overlay_addr to 0x1000
as intended, which is aligned.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 test/py/tests/test_extension.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/tests/test_extension.py b/test/py/tests/test_extension.py
index 61223496054..ddc62e7d5ca 100644
--- a/test/py/tests/test_extension.py
+++ b/test/py/tests/test_extension.py
@@ -38,7 +38,7 @@ def test_extension(ubman):
     assert('overlay1.dtbo' in output)
 
     ubman.run_command_list([
-        'setenv extension_overlay_addr %s' % (overlay_addr),
+        'setenv extension_overlay_addr 0x%x' % (overlay_addr),
         'setenv extension_overlay_cmd \'host load hostfs - ${extension_overlay_addr} %s${extension_overlay_name}\'' % (os.path.join(ubman.config.build_dir, OVERLAY_DIR))])
 
     output = ubman.run_command('extension apply 0')
-- 
2.51.0

