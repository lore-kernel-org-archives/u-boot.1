Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B6DCE7A88
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 19:45:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E43C86ACA;
	Sat, 23 Sep 2023 21:44:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L9GKbiov";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5480886A24; Sat, 23 Sep 2023 21:44:37 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F254786945
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 21:44:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3512614822bso5144105ab.0
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 12:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695498272; x=1696103072; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e5FSM/z+BEPq4lE0y77huZtHIecaLQmYWFr9jRvCBwM=;
 b=L9GKbiovz1RBcSYKx5cKp9p+oYqenPN352ixacjr8BNgkidq+k4krJoyrSbOT1kgv6
 Vk3SaAN7C1C93BxyL6AIFXb31uN/QlfcJQwiZ/hGxDM7LsOR5WLXEf62tg3IZbIEhyhp
 XUWRrlIQAc3SPfwMFen8PfyypEBnIGY1uBqCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695498272; x=1696103072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e5FSM/z+BEPq4lE0y77huZtHIecaLQmYWFr9jRvCBwM=;
 b=c+x056+ZXqzlB0KhUsx2eiEu9pdHwrjkvaJdR7KV1hoY85Wd6Mkf25xiiaDgjIehip
 JTdj9IqogdC5zn8H5fVXuq2KgZeMtq6l7k62zB1rktYmOm874liwx232aVpWY9uRkYFH
 XEZQzPvvmckIJe0JQ/3NPXtINvuIk5aWS8FsH6cA/MhQunZsLcc+iT5pFVLBn8lQJpuW
 Ugmrj9n04JYbslx7JMPOmfbNaMl2LqeGb97Z2GBPTgX5bylPmF2IvLU61TiP0KW++W7h
 q5rVAtRQucjkhP+BGNU/WFimGT44ZlDfT8qyK1GCt9GZA3WuUuqoS6+PUiuxepNkqYe0
 uhLQ==
X-Gm-Message-State: AOJu0YzZtuzKZ2Nw2ZelsF06pRNBBc34V2nxFyJ+wvQHCeNLMLK+lvvi
 xXhZhQhfz3JBnkPFZtS/3ySui5hdH8/A8E2zpEI=
X-Google-Smtp-Source: AGHT+IFQfndI0QLv3ayUTjNkQvcmHvWI0b7EX0eJp+6IXMotC+XjKs8B51i9wTPHOIwA8t/atYP2Dw==
X-Received: by 2002:a05:6e02:20c5:b0:351:ab2:2621 with SMTP id
 5-20020a056e0220c500b003510ab22621mr4622439ilq.15.1695498272587; 
 Sat, 23 Sep 2023 12:44:32 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 el9-20020a0566384d8900b00439d4db47b6sm1697786jab.39.2023.09.23.12.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Sep 2023 12:44:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 03/27] moveconfig: Correct ordering of asteval import
Date: Sat, 23 Sep 2023 13:43:52 -0600
Message-ID: <20230923194424.1739224-4-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230923194424.1739224-1-sjg@chromium.org>
References: <20230923194424.1739224-1-sjg@chromium.org>
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

This should be after the standard imports. Move it to avoid a lot of
pylint warnings.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/moveconfig.py b/tools/moveconfig.py
index 2f7dee88c7ee..a6dbda7bd0ea 100755
--- a/tools/moveconfig.py
+++ b/tools/moveconfig.py
@@ -11,7 +11,6 @@ See doc/develop/moveconfig.rst for documentation.
 """
 
 from argparse import ArgumentParser
-import asteval
 import collections
 from contextlib import ExitStack
 import copy
@@ -32,6 +31,7 @@ import threading
 import time
 import unittest
 
+import asteval
 from buildman import bsettings
 from buildman import kconfiglib
 from buildman import toolchain
-- 
2.42.0.515.g380fc7ccd1-goog

