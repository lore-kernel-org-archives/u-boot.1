Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD6C3CCFA13
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 12:50:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7113183A41;
	Mon, 10 Nov 2025 13:50:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Te5eJAGn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11D5183A41; Mon, 10 Nov 2025 13:50:29 +0100 (CET)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2AA6839B7
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 13:50:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-77f67ba775aso3513118b3a.3
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 04:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762779025; x=1763383825; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=6krbzXvUvZ6wdYeV8wERppIk6uLxbgDGpq8jOkSi7Hs=;
 b=Te5eJAGntKIvLQdzmDYGYbdwyX5BYAFSnavo/FByiWNw93+Si8edGbtrrUTrTRvUV7
 pz9AaFIjwYb7P3Ss98Yd6FWbjyISsDDH1rxu1G+ey+SDk3G9k1rrs4NVH4XB+YFGM3Es
 LG9z0TSBWHDxiG0FWL4obm3ZQzf9+tmsAv9m8maIbGDCC/6o65Uu7hMYhMNsEI12SoSg
 wNQDxh8HIN80UssE7DY8nGHVwEcMSUwDEaQlTMXFMnKlQw8HZwYA0JjGzCkQz/Vprkhb
 KqAQxhvtT+XZQmbT0dBhUcD9+Tnfv6L4YAUT9E1nbSq8C3gaezBf8Ldb/eMkvbNZzTxP
 Is8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762779025; x=1763383825;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6krbzXvUvZ6wdYeV8wERppIk6uLxbgDGpq8jOkSi7Hs=;
 b=NJeBJ/EX38cT2QsOWNDM4W67GgGxOHeiqZ72mgKslfnWHUu4tJjx1Sp4Yw4gRBhkWg
 E4hzXSG7TsIOsXlGrivL6pb9Kh4fnPTpXLFtSZPNvx+5I3a1kzeGLciqKBoW0Dm6ML/d
 Au6ZSMlgoelRyh0hzUv3QXORB2ta/0rfs81kxG4fMlZAuNd26biCghV6TIzxoiGh23yx
 1ILP/2acDW96r6PEg6dc3jg4p34y7HKr5srmzINiKn+PlQ837j3H8qOEelw49cG1E3wX
 32Vav9AVKWSC5/vtuyGIvpBoDHwOWExsrisqHJ2NZfEWNg/QsDJBYNKFUOg8HyHUiSqc
 oPHQ==
X-Gm-Message-State: AOJu0Yynd7SOBUtjt2xE95VEuP6VWIcIrwGAgKW86dGgWTb0owEZCjWZ
 8+lj4+lEbeQZlYM1yjQb39oAy6pyLIt3dShXemMi8gAupWPgzmPOiGcOKmqJ2afv
X-Gm-Gg: ASbGnct+2VuHublxvvmbKFfilLdQCFkJMiWi1BslrHUNg9IBQVnnm3BMqR+5CnIpO6d
 tfEIOAWZw8Q9lvD6nV7Sc/U+lZIVdNOMQJ7WfEoeJRWmwE/ng78YW2wLN9YsnQzApi3zgSaNUZo
 ZEaSJTmV3+prcYplD9igRmHJVzQBmeGfej1b8yDK1JQg1e0ikw6pcMTi2jc+Vzq7rinCTyKhhZu
 uBoPY0jAp6Gmh3QUPVoRXT0on8MpBFG8l/tg6Ky3ssA+90HtQEccfqLyWnEtWxxp4vK665pZS3q
 3gmP/nUJ1TYPYS+qJ9UmSEucEVbGKmeQHOJX+aZC4PYoYhbfDDuEU08UhimkKQGw/6Qc+MU+Poe
 wa/azOoWjNqlCiTxhYNkT3/D0mg1d9dLD6C+RqrozgxSDVizRFIo3tfA8u/oFqZPZB0EbHWY=
X-Google-Smtp-Source: AGHT+IEYL4lwmzjJZZYK+c2qhR7SvWDxYeMZp23G/oKtMiVFhSc1VMRpaskW2kww7JUtqPIzyYN92w==
X-Received: by 2002:a05:6a20:3d25:b0:33e:eb7a:4476 with SMTP id
 adf61e73a8af0-353a1fddd16mr12993320637.23.1762779025164; 
 Mon, 10 Nov 2025 04:50:25 -0800 (PST)
Received: from ubuntu.. ([111.196.133.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7b0ccd4edc3sm11835506b3a.66.2025.11.10.04.50.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 04:50:24 -0800 (PST)
From: Bin Meng <bmeng.cn@gmail.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [u-boot-test-hooks PATCH 1/2] bin: Fix the broken symbolic link of
 qemu_arm64 config file
Date: Mon, 10 Nov 2025 20:50:20 +0800
Message-Id: <20251110125021.1642684-1-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Commit 48a0f7fa renamed the conf.qemu_arm64_na to conf.qemu_arm64
but it forgot to update the symbolic link in the bin/ellesmere dir.

Fixes: 48a0f7fa ("bin: Run the conf without board_ident as default")
Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

 bin/ellesmere/conf.qemu_arm64    | 1 +
 bin/ellesmere/conf.qemu_arm64_na | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)
 create mode 120000 bin/ellesmere/conf.qemu_arm64
 delete mode 120000 bin/ellesmere/conf.qemu_arm64_na

diff --git a/bin/ellesmere/conf.qemu_arm64 b/bin/ellesmere/conf.qemu_arm64
new file mode 120000
index 0000000..dee6855
--- /dev/null
+++ b/bin/ellesmere/conf.qemu_arm64
@@ -0,0 +1 @@
+../travis-ci/conf.qemu_arm64
\ No newline at end of file
diff --git a/bin/ellesmere/conf.qemu_arm64_na b/bin/ellesmere/conf.qemu_arm64_na
deleted file mode 120000
index cf56db1..0000000
--- a/bin/ellesmere/conf.qemu_arm64_na
+++ /dev/null
@@ -1 +0,0 @@
-../travis-ci/conf.qemu_arm64_na
\ No newline at end of file
-- 
2.34.1

