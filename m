Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7AC7C021A0
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 22:24:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03314807C0;
	Wed, 12 Feb 2025 23:23:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XFFAJrx/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDC1680BAA; Wed, 12 Feb 2025 23:23:54 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8D4B80EB5
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 23:23:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7c05bb6dab7so27943685a.0
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 14:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739399029; x=1740003829; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YzEqfFo2B0vkvhcxPH15IPXHp6PMNtln46teapam3iw=;
 b=XFFAJrx/JQhgQkkGl14CBtvQnNUQVOeoTBbInFfPVBL565q2IguB50YEcnQYnrbAHx
 azAYGG4sgPiKX1k+WtPR8VffxFPCbhgDBk6G7KyOT5ATYvpKRsLQCtB4XhMTz3ft4/3F
 405kLZgHw5rxF/MJ6Ta+rar4yq4QIxUmKcsgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739399029; x=1740003829;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YzEqfFo2B0vkvhcxPH15IPXHp6PMNtln46teapam3iw=;
 b=pl+dnqmK4oK4oIdBo1318d293Mpswrv6+LB0mEZ672g0dP/fsA/J1dX2HHlxR3gQ8x
 gUfVWXjVYURHpGMQfTjnkKtcFIh1dJ2ffs3GL7dEB4qh6iQrnqIiy4AZSUGFtY/jmX4E
 V4OeJE+bnUNNmvoIYDyWylXW44dS8taR3oW0qD74QrPQxx61IB+OvAqx8b0DLQMWHpYr
 AVUpF1o9H2oEEKaIdCDzc9Me75UtempuwSyk/d3BwW7vNSYb/owp7JegB7v+uxGmrP2r
 fxG9yl0hbEuGthwt9Ihu/FND4kOTGfE8uptWUGTogT1RFoPynBFcgcs4IXRDYdCQt6oN
 EHPA==
X-Gm-Message-State: AOJu0YxT4ZbJKWNLGwouj/SZQVQVpMUUabkXU9XUJAjIJ0AkgVmDHjZ2
 b009esvPA5K8+++D1muzS5pPEwg8Ro/zUYltGsdTSNQy0JCGVpDLsSnVFiMhxOqQvG0GmtKEkmD
 V
X-Gm-Gg: ASbGncuen3WtG6UD2/Yn4KVIwQFVzfpJhXoIggDFfzXCEx+Y9InGutKoB+6zYA/eIVp
 eIV2v5xqC7QQiJMWX+YAcDJOhJPF2gBp5QglUWm+NAZXM84DYkBud5AyCsz+8ZNUfJADafBZAq8
 kHi7M+2CPJ+KS6FLhPdGb3SAH/VCc+7PNV7hQOpP4wO/WIBAwS1CakKwVMBfYW98VuXNohj7Pc6
 bros9NUgbcpZ/vbT/DPYmIC7clK7itLXIJuuW/hlTv1d9Rk05jLg3eALT/9TrRIC4gS4WxlkdWr
 nc2zKU4Rz4u1iZI80g==
X-Google-Smtp-Source: AGHT+IFfA1V5Oa1xIZ4Jg38jhBiW4fZrHUreUloPkAh1UiWT95Yk4pxnvRyq+Eipt+XMzattjvOnKg==
X-Received: by 2002:a05:620a:c44:b0:7c0:5b5d:c82b with SMTP id
 af79cd13be357-7c07a8f8fe4mr120364385a.28.1739399029617; 
 Wed, 12 Feb 2025 14:23:49 -0800 (PST)
Received: from bill-the-cat.. ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c056b42b89sm611570985a.69.2025.02.12.14.23.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 14:23:48 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH] dtoc: Switch to setuptools
Date: Wed, 12 Feb 2025 16:23:46 -0600
Message-ID: <20250212222346.684498-1-trini@konsulko.com>
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

With the distutils module having been removed with Python 3.12, switch
to using setuptools instead.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
---
 tools/dtoc/setup.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/dtoc/setup.py b/tools/dtoc/setup.py
index 5e092fe0872a..ae9ad043b013 100644
--- a/tools/dtoc/setup.py
+++ b/tools/dtoc/setup.py
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-from distutils.core import setup
+from setuptools import setup
 setup(name='dtoc',
       version='1.0',
       license='GPL-2.0+',
-- 
2.43.0

