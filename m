Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 974D5EFCD93
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 10:51:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2702683EEF;
	Mon,  9 Mar 2026 11:51:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.b="pPOtnk0F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EA9483CDF; Mon,  9 Mar 2026 11:51:36 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACF1283F1F
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 11:51:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3599019ae92so4338885a91.0
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 03:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0x0f.com; s=google; t=1773053492; x=1773658292; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eKwOyDks3QY8J/rwGHse7Fq/YJaJArroebXUxv3IGZc=;
 b=pPOtnk0FsIrqboHiDJ2lX+rTqPvF+l30LbO3hC+iIOVhyQl4CHkNqWDKqoc9B5dslu
 MqeJ9S9sPpv6ba4UI4fam3cQUQa06gJED6TjAu4O1m//5z4sf/tmvi5omSntHy5M0Hi9
 armfKsfF+uB6va3zu+8dwm/taWxn82yZSznpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773053492; x=1773658292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eKwOyDks3QY8J/rwGHse7Fq/YJaJArroebXUxv3IGZc=;
 b=nyEGflxy9sFM6+2dnGqq4lAHODWEZTc9MlJfSysdvwU9wWE9onJ1+6xqVLhgeSXz7K
 TdY4sze4vT369vhZ5fBJYId08MGG805afHVwn4r2ZaGlXCSNSSjudKcPYX8/dMc+a1xh
 k/TlKaG7eWKbryVBZy9poXXTJZub9ckza3+QT/WaoFMH7poj7cujXifue+ZuVo6ntJUi
 2bsu+R+UOKCmwKpci+imImp/+NmSZ1gcr/HcgoIVse4CjuBRoSYACrL5rmvLlez3wVdh
 8XP7H5RPiSmuJRPLtVSwBQl7egjGyV8osOAPQ2IIH33o2Uh1B7YiLqLgXwBnB3zpS3do
 5s4g==
X-Gm-Message-State: AOJu0YyYoxvUD92CzMWzgBDaG9kXj1BD0E3S5SD1QzWR1jEyojIsiRuq
 rbC5x1bDRo4TykpQruL+QzoxHoAmj6H5jHB8QM6RuosPJLBoBSsWwgFrOc0QLmFnmczKqpzhgiR
 geeQd
X-Gm-Gg: ATEYQzw2h/W7kV4GSRpm8PgF+TyY9XqjVJNaCkq7FNqJFegamuipszE/ml6Q8J5OrbG
 p6COIvlYFTbeqZ4YPCMM36fNCXcEp7lfaZHiM8eCzfbEkgx0iK6+eRt5ioWYJRelmWv3YXLhjD4
 1rd0mE6kWsU7E4kYlqOC5ohsbH+015dZ85QK6C2Lvvjnbl//YXrwzcWHY5DDySB+81Vvy1dEq9O
 z2YVnz2cTAnx6RMTHAhk5wdTQ1/NqBuZM9Q+Z2Vj3OOXNRwPFm8rgFUXNFu5S5TjNVEdnuDe+zK
 s78ifwWmbonfmqDgH2kC7gutE9vZ0oew7co90gf7pypuWC+zFElPIa49kkvw02eXTIauV/QTmZe
 KLTPGFmFizuGKPMtTH9UgJHJRvMiYaugHUQEQSozw9SCXFdZa8zallwVjay1uKq1IyOwSXKUwVq
 Aa2VHyNOKNcqIyaseNO4v4dM1GBMuN5Oo+KhWSo1FOb8oNfZAv+/7zHNYS/5ZXYn8DZQ==
X-Received: by 2002:a17:90b:4c50:b0:359:2d1c:9206 with SMTP id
 98e67ed59e1d1-359be331408mr9858514a91.33.1773053491984; 
 Mon, 09 Mar 2026 03:51:31 -0700 (PDT)
Received: from shiro (p1766150-ipxg00e01sizuokaden.shizuoka.ocn.ne.jp.
 [153.167.218.150]) by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-359bbbaf51bsm5491921a91.1.2026.03.09.03.51.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 03:51:31 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: visitorckw@gmail.com
Cc: u-boot@lists.denx.de,
	Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2 3/3] doc: board: virt: m68k: Detail how to use debug uart
Date: Mon,  9 Mar 2026 19:51:10 +0900
Message-ID: <20260309105110.672832-3-daniel@0x0f.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260309105110.672832-1-daniel@0x0f.com>
References: <20260309105110.672832-1-daniel@0x0f.com>
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

Add a paragraph to explain how to get the address of the goldfish
tty and use it as the debug uart. I think the address is actually
fixed right now but it might change in the future.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 doc/board/emulation/qemu-m68k.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/doc/board/emulation/qemu-m68k.rst b/doc/board/emulation/qemu-m68k.rst
index 6c4de54cf6a8..2f2e6bd6444a 100644
--- a/doc/board/emulation/qemu-m68k.rst
+++ b/doc/board/emulation/qemu-m68k.rst
@@ -31,6 +31,16 @@ The minimal QEMU command line to get U-Boot up and running is:
 Note that the `-nographic` option is used to redirect the console to stdio,
 which connects to the emulated Goldfish TTY device.
 
+Debugging U-Boot
+----------------
+
+If you need early debugging output enable `CONFIG_DEBUG_UART_GOLDFISH`.
+The base address for the UART can be found by activating the QEMU monitor,
+running `info qtree`, and then looking for the goldfish tty device and
+taking the mmio address.
+
+Baud rate doesn't matter.
+
 Hardware Support
 ----------------
 The following QEMU virt peripherals are supported in U-Boot:
-- 
2.51.0

