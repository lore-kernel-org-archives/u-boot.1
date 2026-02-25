Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D19FD3776
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 16:50:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6C3084199;
	Wed, 25 Feb 2026 17:25:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iE7u5Oyj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62F508419D; Wed, 25 Feb 2026 17:25:47 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20A5584199
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 17:24:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d4c3484268so5019217a34.0
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 08:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772036666; x=1772641466; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=605VAxG1U4ix+UF1Z6CayPuaDHeihlSURj9D6gzzLDQ=;
 b=iE7u5OyjfC+PGNZRrxAbDRIZ3s1JFn3MYk+o4mKKLKTuqFfddwi/zl9mucbKQ05j9o
 8B7qOKbM5TBIVwSLjVZJP3zNYr7dpON5BHfs/x/dDWPkhKl0bRB3jPw1g60RVo3/2f2i
 HFVhY1XLbDsPtUkl4XS+G9wHGISCN1/3XglIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772036666; x=1772641466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=605VAxG1U4ix+UF1Z6CayPuaDHeihlSURj9D6gzzLDQ=;
 b=sEL9z/VPLae7HU4hezAL+MIdSOvhHqK2ZsijPhVEFVbdenla38jQpdjd3NIMPAOmUw
 6oL1Htb9TXXcZ08ForCRcZ6z3yE1rAEVqm90QY8lvfDZFfqbuYtZetAaquh8Ya3cdu+0
 1Kg75kviA/fHFxsHrTIDMGfDn0Ur45IqDEMjr0Z9ey1sALKXzvRL7gUjNRNhWNdZuIbS
 u93DFdu3D3S6QWcQATgGGF42BHA+CGBO9vS4jjeD7ze33LuYkUHyrUf8zM7MZ2OUdA3b
 /N4e3wetA3meTTtiCLdEG8dk2OZuZMv6H4Az3VVSIrBxEDekc6IlNlKTVJTjfHiKKy78
 N5cw==
X-Gm-Message-State: AOJu0YzO5imFcSIR2tsufVuDmW2hJZhNYbJy1QSKHNpIwvGoYL5CLsur
 vDHEYLhet/U87y+Bv9EEZprCgvi+ooXTj9nDkhvj7muZuzK53HQNoyePasO8Hvdb2tzM0UY2HMD
 hKUE=
X-Gm-Gg: ATEYQzz1kFGfii7CarfMkXeqMxPPoTIi9D9R1AOzXPyPNNdtGxpdQ/J9lv6+At7RXot
 WMmBher4KLjsRYQMIZco0yIOdh1YXxQVrXHXpRo5a2V93OnzmyAUzv/OhPO5tllTPeDYBrxfDnW
 mXw39UWYM1sqdfAZ37O95Rz1j7BXNiUYZpGTAiPfuohGy7jnmPwUU9P+kAomjjx2g1pRYaNli1M
 fuLllQniPYQUGDGGybKbRWMrK80AhIx/rGF4EX21eTgOQjJUvnb+758LmPxqryCmfXOnOI27hDB
 K+8sDi95L8yPN4boq/kCz3FHAUQA23OgKpS5dbhytz9K1y+Eyp3fTnfarqDRi95hjPPThCaIdG9
 kPkk2vQquEo6VaPi7nEi4MYavnqtsdtnp0LR7l5IIHKCuZsxp19EvqS1tTffDbLhcFUoR0no7ut
 1zmheDpobJ8vj5lYrMiQ==
X-Received: by 2002:a05:6830:82ad:b0:7d1:4f4c:532a with SMTP id
 46e09a7af769-7d52bf20502mr9480889a34.20.1772036665881; 
 Wed, 25 Feb 2026 08:24:25 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cf7874csm13534383a34.1.2026.02.25.08.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 08:24:23 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
Subject: [PATCH 2/6] test: Update comment for fs_helper.setup_image()
Date: Wed, 25 Feb 2026 09:23:46 -0700
Message-ID: <20260225162357.3449937-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225162357.3449937-1-sjg@chromium.org>
References: <20260225162357.3449937-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

This function actually allows creating two partitions now, so update its
comment to match that.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

 test/py/tests/fs_helper.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index d124f03a7dc..aedf6af0aeb 100644
--- a/test/py/tests/fs_helper.py
+++ b/test/py/tests/fs_helper.py
@@ -83,7 +83,7 @@ def mk_fs(config, fs_type, size, prefix, src_dir=None, size_gran = 0x100000,
 
 def setup_image(ubman, devnum, part_type, img_size=20, second_part=False,
                 basename='mmc'):
-    """Create a disk image with a single partition
+    """Create a disk image with one or two partitions
 
     Args:
         ubman (ConsoleBase): Console to use
-- 
2.43.0

