Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62250E64019
	for <u-boot@archiver.kernel.org>; Sun,  5 Apr 2026 11:13:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7C1B8341A;
	Sun,  5 Apr 2026 13:12:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I7v7Vyqu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A8658418A; Sun,  5 Apr 2026 13:12:51 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D0D484142
 for <u-boot@lists.denx.de>; Sun,  5 Apr 2026 13:12:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-470145d7df5so1013660b6e.0
 for <u-boot@lists.denx.de>; Sun, 05 Apr 2026 04:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775387565; x=1775992365; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ttR43zO9jTnl32obLZ1Y0YvGoXAC/qGSdc8iGpo8wg=;
 b=I7v7Vyquq4Ze+PxOUVWdfBPSu7yHFe2x02YoCwk4/pFRfwUcNNtG6g+kYshXnMValA
 PImjPaOE2hna07gpzfK58Zlvhm/J4RuKsyhW+1v4ebS+Yt5Kx6bKMpkUS+orRsxLZ6jX
 NpA8zWqsgL8UHiWW7S1ZwtAehit55lzblX6GE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775387565; x=1775992365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8ttR43zO9jTnl32obLZ1Y0YvGoXAC/qGSdc8iGpo8wg=;
 b=N8VBQH1raq4BKXT5ei8xk+qfT5wwk5BNSxd90ZTYiLQUW7aOMoDQo0Tfh5oCfzDYjY
 8H7dOuUBhOpJf7jMYmyrPFAgVVweLy2IQ/LywGhwaVJ97L18rmoKdNlzefKk5oFWPaAM
 ExQjETBwC3hoEZkeRXlX1EQeWfPHGCgYYk14vnVw+uCJNwiwhFIJriX4DL9qr1e4vSBh
 e3rl/urRRjnxvAYJ0qlxEfrL4GAYwzO5kI3alfyM0xTmtDmm8fFKZ0xDd2JyWd2gEJIy
 TVtVV/B1PHePDb44sgDziHofm3AEm56lmIvLfRozyImKWMq3S2rBVFLilfyHv2C/nL6S
 YECg==
X-Gm-Message-State: AOJu0YwYBrqWT3IjkwyUV8S4ubeJnA2sy0fQxAfD6KPFEBSmL/ZqpinH
 gxgzdaidhK6RnBVhf13espJCqPTAurw1Z71jaLYJ/ZiI6t2rpvTL0DgHiYQPs9f7rg/RJdsZCsY
 m9Tmzrw==
X-Gm-Gg: AeBDiev8UOzv0p7hoGHHXYk7Z9i+uZz7aNH118wBNDmfR1hD9BeLeoQOlK/EVYzCdjJ
 w4mTb1l69N1K/QWBHDr0w3IXbPFvLGhMC1eD80plsfs/k+JItjwpxn7q8lyrUxu1rS5huwxR8RP
 XNmHGWfqfx7JenyueizczMr0tY3xIMw/CIRQoX9cpMHcm9ZR/9vmyhkhY3XW6MOl9y0zUG94LUm
 qf+L5hlUQ+Bydr9+Evw8r0B+uB+kbQU5ZILEL8DjuyvM/RhWQFtAY3/oweDShsenfw/9vIrX7rY
 r6tqIz+BDUomsh7XfA34qi8CX6L3CZrG2q0OzAYzguVJN02NJf5Fjrty40QZ/RAxqoNcCPvbAGn
 DSHhEl+2ZBu4lXfA0sFsYJxx5ZokG6tbY3Gafvfa23P9cEZGI62+eAkmHxKAkYcdNg5P3rEYb4q
 4pG3XxDy/n7Wv3AeW+Kg==
X-Received: by 2002:a05:6808:1910:b0:45f:a12:5c88 with SMTP id
 5614622812f47-46efbde63afmr5203896b6e.49.1775387565486; 
 Sun, 05 Apr 2026 04:12:45 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46d8d109b69sm6414382b6e.0.2026.04.05.04.12.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 04:12:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 8/8] test: Add documentation for the FIT test
Date: Sun,  5 Apr 2026 05:11:53 -0600
Message-ID: <20260405111206.945185-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260405111206.945185-1-sjg@chromium.org>
References: <20260405111206.945185-1-sjg@chromium.org>
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

Add a Sphinx automodule page for test_fit.py so it appears in the pytest
documentation alongside the other test modules. The index already uses a
glob pattern, so this is picked up automatically.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add new patch for Sphinx documentation as requested by Tom Rini

 doc/develop/pytest/test_fit.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 doc/develop/pytest/test_fit.rst

diff --git a/doc/develop/pytest/test_fit.rst b/doc/develop/pytest/test_fit.rst
new file mode 100644
index 00000000000..3a2359f1e89
--- /dev/null
+++ b/doc/develop/pytest/test_fit.rst
@@ -0,0 +1,10 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+test_fit
+========
+
+.. automodule:: test_fit
+   :synopsis:
+   :member-order: bysource
+   :members:
+   :undoc-members:
-- 
2.43.0

