Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D90C1C3ABA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 13:24:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF16682893;
	Tue, 29 Apr 2025 15:24:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WKT7GM2/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C39682893; Tue, 29 Apr 2025 15:24:02 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32EE0828E1
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 15:24:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-72ec926e828so1657760a34.0
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 06:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745933038; x=1746537838; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qr89c/322Mbtk+AjI75zEwzHZet8Qp6zrPk0NRsLlek=;
 b=WKT7GM2/HOKURKT/k6eC9i95TfLMe3T+pS8ZtnnsvJahGmBQV26Vch5yqH7WAehgR5
 JOni+kLMJxjI7yUXu/yuoIIZnBBT11P0E5Pv0CoroN14SaGhL7WPeNi8SPEmIKPfF48u
 fnz4TONm27P4t8ftnvaIK3CxmC5xTIhRQ0Txs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745933038; x=1746537838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qr89c/322Mbtk+AjI75zEwzHZet8Qp6zrPk0NRsLlek=;
 b=tGrity+1feSAhcZKr93w94Sky9NjF0RHprsEWrsEvdJtfCB5emNdBEf3L7+n8IxDCn
 1MjC5eQZEc5eVQsk1Q7887wRL3JmeURmu5xegEFyPWqDGDdEzfhB48J7DRCO0POadTHp
 8jHkIzoGzcTp/ZdngKxUxB6b0DX+66wAXxMGyGUErLtseQvN/BXTquIIPF5x6MNOlVxl
 ECDFXvBcVhA22hfVg7FH5KioRgR7vmrYApMsAbyZ5n3zClKntXaD+T3vz9qNmBGiNMTf
 15ORrIS+FqxgKqLQEm8qXbwgPo26YgspSQ9RqMe2V2XJHoP8Q1LMe/HyC+ZogdvSfrJv
 T0AQ==
X-Gm-Message-State: AOJu0Yw/1tlUuHcd5OqgZZX7xXemR1unQR4dAP4NCPRyUJEcLA7hcyeB
 RyrVmatYewZZlyK9GFz8O+MUAQHG/Wxg46wkxkZeO45SEl4/YlKvKfFebaThgRo6yrxY8+KQL/0
 =
X-Gm-Gg: ASbGncvCH5DWhJHkvgRF2j/HVbp3iaEq0r8RSkLQoAl0Z1Two1xVSpyk0oG/RqMACL8
 +xZZpb3s4zD+GI8gTF1x0cYOH9J/8fqvG5gaxVdv5P7nY8CJZ9TFovmH6LYBY2MI42uomPL8p9P
 LOivZU1gFS68y6UX5ICM+kUpP5rw97nNhZi8G5Yi34b5lJdqOFtJ7RUTOWK2D1IbwO/X9h4Q5cb
 CF+KRYuoA3sTNNA6IIKccESrx3pBp4sz1o0sPV88HO4o0sLdxnL4qE44h50NFhQICNZodOkb2SI
 tXBhxzKd6X7413SGi9i0Dqzpvj3mk4+gCAimX36Zzah2WgEu2dgZyG8hjSHaPdbXbAdXOlhRCdQ
 M+OoBVtH7EANO
X-Google-Smtp-Source: AGHT+IGkXInrK/7nzhkrC7kbIreHlRGb3ZGWF0UHmW7EcONs7rWBXmVgLkc/9ZJY5IQvijOvxIvPuw==
X-Received: by 2002:a05:6830:488e:b0:72a:327:eed3 with SMTP id
 46e09a7af769-73065093b91mr9198524a34.5.1745933038306; 
 Tue, 29 Apr 2025 06:23:58 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b117371sm277320a34.16.2025.04.29.06.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:23:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/30] u_boot_pylib: Allow disabling colour output
Date: Tue, 29 Apr 2025 07:22:05 -0600
Message-ID: <20250429132239.251756-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429132239.251756-1-sjg@chromium.org>
References: <20250429132239.251756-1-sjg@chromium.org>
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

When running tests there is no situation in which we want ANSI output as
it makes it much harder to see what is going on in logs, tests, etc.

Provide a way to disable this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/u_boot_pylib/tout.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/u_boot_pylib/tout.py b/tools/u_boot_pylib/tout.py
index 6bd2806f88f..37849d1450e 100644
--- a/tools/u_boot_pylib/tout.py
+++ b/tools/u_boot_pylib/tout.py
@@ -155,7 +155,7 @@ def user_output(msg):
     """
     _output(0, msg)
 
-def init(_verbose=WARNING, stdout=sys.stdout):
+def init(_verbose=WARNING, stdout=sys.stdout, allow_colour=True):
     """Initialize a new output object.
 
     Args:
@@ -166,7 +166,8 @@ def init(_verbose=WARNING, stdout=sys.stdout):
 
     verbose = _verbose
     _progress = ''                    # Our last progress message
-    _color = terminal.Color()
+    _color = terminal.Color(terminal.COLOR_IF_TERMINAL if allow_colour
+                            else terminal.COLOR_NEVER)
     _stdout = stdout
 
     # TODO(sjg): Move this into Chromite libraries when we have them
-- 
2.43.0

