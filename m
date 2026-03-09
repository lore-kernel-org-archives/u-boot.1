Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7909BF41808
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 15:14:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D067E83FAF;
	Mon,  9 Mar 2026 16:13:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZtVOQs3j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49AC983BC7; Mon,  9 Mar 2026 16:13:43 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB5F383F53
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 16:13:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-5091d71aa11so9072431cf.1
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 08:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773069205; x=1773674005; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GijFLuqRg8WVk+Ej7Pnwl/z3kbQfOIIU/Jg4kwTdxjo=;
 b=ZtVOQs3jlQkuRWwc5I4MgwZ49gixyMgh5h2iVCKVsA0vUpfuZu/J30OOgNfKTC3sZv
 YbR53s500f0dfYjDT71GnSH1a7SB3VKfVOQesAJ9+N44wlbeDLPNCCz4GmZSaVysRNad
 4gr66gOg74ljZrnuHU89Iq9KAS4n/UTMgUM+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773069205; x=1773674005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GijFLuqRg8WVk+Ej7Pnwl/z3kbQfOIIU/Jg4kwTdxjo=;
 b=GWY8R/KpFLVrtdctB5qZ2zhi1Z6KLKIYChUtOexn6im+v2raC6L9eUwQoRqg5Y1nEL
 5dOdlpj2FsUzIDVq6yxeaMXUkqsxWWy2vk9j8sLZo+Cv533pLYb3gn9v8aS4ECQxHuo3
 K9FY61y7e65HY4A0rkoxTas5vx+y36K7O9YbXwKWJ7jz//DHFqMgZtfNWLMOGOjNtKKZ
 tjHwKejzAe168kMS+tiAKIc39Wy9g801qXFQUSP9IbjnJrjwyfJ8zP2R2bFN3CnhJfEe
 GgUB1RLq+7JG71+H4Q9b464MexL2ENWFmmGe21PogUpuAMCvqRYmpp4iG6P3NtRW4wHZ
 sBQA==
X-Gm-Message-State: AOJu0YxPUewBg4CLu3bkOgCYKobil222sr2CFT58P8xdfoN6dRTAHcAW
 PAR/pClm4zqlZEGAS2y2YKi9sOmBrJN0ULP5WscDVWOSjOIGYjX5luqg3xvclDRmNkvYKygP5wl
 9sxk=
X-Gm-Gg: ATEYQzxpJ10PReHEsUm4pCnTOWemVjk8zmhI5zqM1cI7EW0aEu5bj/uLcBRBBennrGn
 U0zvAEn3sqvPC+ILJXjJ7i/rktjevksj/DeU8njPxjfXH8c/LqXjo1WC4dUoZTfEWZ1Kx/FrGIm
 CaiAAVlXD3+8M67SZatNawXyWBuYq+pIlID9kB1/bUmkl414QKz1mm5u23Xv44limfFK5e79h49
 3e8c/UbVx5rA9z+sgkpyY50qYBjQ6rW+EGshH9fy2u/jK1WuzMH29aghVAx1LOYnB1Zc72G/R3i
 VOszC8QaSdivefL+ghrl0Q2mt6DnyKvgAp4bYfKIMjTDHmJwHfyA0soIT8wViyTrummZ/UtiXWy
 u2ZQmG4RQs/L38wXmU8CKVPCmvNSH9TjYoJruSqP8fFOvFe7GZ2NKmGbgsXxIBxtwSsFs/rjJCV
 lSSo4ONiOicKMgEcLtEg==
X-Received: by 2002:a05:622a:1ba4:b0:4ee:26e9:98ac with SMTP id
 d75a77b69052e-508f4abe6e9mr135291801cf.16.1773069205546; 
 Mon, 09 Mar 2026 08:13:25 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5091a7dec85sm19337291cf.32.2026.03.09.08.13.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 08:13:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
Subject: [PATCH v4 3/5] test: Update comment for fs_helper.setup_image()
Date: Mon,  9 Mar 2026 09:13:02 -0600
Message-ID: <20260309151307.831537-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309151307.831537-1-sjg@chromium.org>
References: <20260309151307.831537-1-sjg@chromium.org>
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
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 test/py/tests/fs_helper.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index 4b123ab0afd..47340295fbb 100644
--- a/test/py/tests/fs_helper.py
+++ b/test/py/tests/fs_helper.py
@@ -85,7 +85,7 @@ def mk_fs(config, fs_type, size, prefix, src_dir=None, size_gran = 0x100000,
 
 def setup_image(ubman, devnum, part_type, img_size=20, second_part=False,
                 basename='mmc'):
-    """Create a disk image with a single partition
+    """Create a disk image with one or two partitions
 
     Args:
         ubman (ConsoleBase): Console to use
-- 
2.43.0

