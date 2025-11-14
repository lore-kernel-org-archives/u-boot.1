Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C50CEACD2
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 21:54:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35524841CD;
	Fri, 14 Nov 2025 22:54:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XKLbVeSg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADFF984246; Fri, 14 Nov 2025 22:54:52 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85B77841C9
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 22:54:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7c6da5e3353so1929119a34.3
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 13:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763157289; x=1763762089; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=i6rpNw0XL/6XkA2sqFCylSAjJfT5UTorQW1NBkbssok=;
 b=XKLbVeSgofgYpNpg037z14L32KRFCZz6Y+C8oWR71QItQ3URULn59MJC9q/Rb1wncQ
 9qal1t16xmO+tGcNi8MnhexkfjhtTPur7YVN7uQtXUlN18WkR8vd6+HArvVLqPhND+Kw
 9xQ6zhCQOieewfkNoBX2aAGpjBa/7fQWpVUgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763157289; x=1763762089;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i6rpNw0XL/6XkA2sqFCylSAjJfT5UTorQW1NBkbssok=;
 b=GiQAp+hcVHp3jFl6jyZEkHfpDiBDgHLyDknJo8Wxb5Lupor3BAyYpfAGu+nqQm7L63
 h6cxwmKUTZQsGW6BH30gIRj1zBrJXR0tdjuSESg+3+achFxU8+6nzw20jRJTn88/4wA9
 Fn4fHLSgh7K/UwOgPkdK8nq4nhanQDSXRBcpxoRzxgDPHCNojN0gyWHpgSmRVl9NgleF
 6ocQBDewqxl5VHBx2lCgpMzuUK029xZQA0EF2keyAx8r2TaAjqYWlQ7OmWipkaL6FAkB
 1Ogu4/pE2L/1XZEY4qFaXTIjfAh7d4BhecPxclOcGaE4QlKGU4J71paZyvfqdRQOEa7/
 eQFA==
X-Gm-Message-State: AOJu0YwEyhJ5gqtiTjLWUsJMfUr3pVt5gOAChrc1Y4KIdz/6dkrF2OQx
 heN+ibKDfQDg1jrbq+6UTp+cgR+Js1QrsNlVB4Pa4wQujBOmVVGg35ypUy5EbBg8SE8UNkiKZHL
 DMjC0eTxhgw==
X-Gm-Gg: ASbGncsoPRpf6TC/BGD7sng4NrcMmF6eZt9Ovvef0juSed8pKl+4082lqPIIChTpmvP
 JDIrPsTmIoo2oVI3rSiyMcrryrkt3hwMETyOanf7vu3eSgoASgQYxlkiEZGL3rIdWs+CClPTNi8
 1xIdUlcH7p+N+rgNzSssuLRqltt1pxTU20WrjZzebZBEbwje+HXXUDLWpZmWw1CGobIrv/tb8zx
 Aar1FSm+E1x0JKrfpQU9C5fHfCuF8WG7tbb8VF2CX1E+vjTbf6DOcOBBGbzZgD3jmN2K34xnaj+
 JYroJSylggNVlcrQfkwA7bHLh/2amkONq2ApPNUQ9ofy1B8pAkXJXCO/te/p6OTzr6zdk9MtSHx
 cS7uTXjhOU3DO7MMKE5Efy7irUWH6p5EhqyjfP1QH98WERnPgzGsxNMW8jOS0wWuRuDN6ZYn38J
 7a1Ze5xi/1yO0fmzXMNkAgZh6KfLavtn4p5tVMuQEV7A==
X-Google-Smtp-Source: AGHT+IGYs7+aDVjlNIfeKLxLabqsEGQs2B1rNctzJwFbGbK9jyvjAhKGEiMp+JuwOTieF8JpWTiLmA==
X-Received: by 2002:a05:6830:922:b0:790:710f:60e3 with SMTP id
 46e09a7af769-7c744555edbmr3404298a34.23.1763157289096; 
 Fri, 14 Nov 2025 13:54:49 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c73a28428bsm3123374a34.1.2025.11.14.13.54.48
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 13:54:48 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [u-boot-test-hooks][PATCH] labgrid: sunxi: Add writer using
 write-image
Date: Fri, 14 Nov 2025 15:54:47 -0600
Message-ID: <20251114215447.2395858-1-trini@konsulko.com>
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

Labgrid has the ability to write a given file directly to disk. Make use
of this to behave similarly to bin/writer.sunxi_raw. Note that since
labgrid passes "bs=512" to dd, we need to adjust our arguments for this
rather than bs=1024.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 bin/writer.labgrid-trini.sunxi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 bin/writer.labgrid-trini.sunxi

diff --git a/bin/writer.labgrid-trini.sunxi b/bin/writer.labgrid-trini.sunxi
new file mode 100644
index 000000000000..0180f908a5ea
--- /dev/null
+++ b/bin/writer.labgrid-trini.sunxi
@@ -0,0 +1,30 @@
+# Copyright (c) 2025 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# Ensure we have all environment variables set
+. common.labgrid-trini
+
+build=${U_BOOT_BUILD_DIR}
+
+echo "Writing build at ${build}"
+
+# This use bs=512
+labgrid-client write-image --mode dd --seek 16 ${build}/u-boot-sunxi-with-spl.bin
+echo "Done writing build"
-- 
2.43.0

