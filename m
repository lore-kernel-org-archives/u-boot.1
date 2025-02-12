Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3B5C021A0
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 22:24:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5361C80EB1;
	Wed, 12 Feb 2025 23:24:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qK4Zh/2O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3C1E80ECC; Wed, 12 Feb 2025 23:23:59 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9E0C80207
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 23:23:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7be8f28172dso13755185a.3
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 14:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739399037; x=1740003837; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kQfMML5IquHM9E7Bj5MhInC9tch3ZVYH70fbKjqoXNo=;
 b=qK4Zh/2OXN1Jq3uXZSVwekMJY3NhsGC+EiKXrimt8JTeOUZ5PmeURbETpDRMEq+0Cl
 wqyJGCUyeZSHlArtNUlPNuHxQ6s+ANC2XEBJs2AQTUoCPlbbHDqA4DgRlG3bSq0m1c6Y
 sRQyqxWIpbbDmwkmLTtNy4Cw/8ev36RaviETc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739399037; x=1740003837;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kQfMML5IquHM9E7Bj5MhInC9tch3ZVYH70fbKjqoXNo=;
 b=BYU7PgeXhKWDDJkfHboyd5O+1LshnmLs1OBfI6+mizk8vd0oEKkrwyughubE8f5S7W
 YIR/DKF52AfYHj+0VJTmYWN/O+AIZMhsTN9qMARv6bB7Hfg408LQicPYLKZLEURf7quK
 DfAKLHecnRPKdnjR1/ZZ22Cd+Cs9br/EfYb2gQev+a70wzfdz+1iu0CzFRKIgBK91PyK
 DHx8fIIWBAKj2AyqnxqEpMm8aJfJ5rVhgG9t225WlLPqEpklQEPdmgF6CaVgTNLCKs4o
 7SVio5EiTyUEzOKEsS6+S9v3DarO0vFdNQqercVD3WORG4yhh0NCKB5YvrSDMPHtDQAT
 QdBA==
X-Gm-Message-State: AOJu0YyNqPEAfBLzmwJv2GZ0DVrzPtRBqQDZbM7OlFtjQ77sOEbnuhIe
 VyrsieNDxsfx1/UQD9YPglhb/KN1OTfbCxNJczbUeC5cLvZWttPhWpTLGXe3yaheIpKA6i/eZvB
 w
X-Gm-Gg: ASbGncvmg9GTrKWtZ9ITby0GkOiMB2DobzKs5l2oaEv0fPhiqFG/dweZbjLf43ibT1O
 ivaHWTGGHIUss1JEfgOSmGcpdRdUiF891QNXJdsNkpRJUEXw+yQZzhMTEMXRcjmdPB9jMwjnQtc
 MvBjJqWcEd8Ld/gQ0MWRwmLKUCn0vL4M3aU1JkvVbLCH8/DAFb6GFLlxvYybgouQQ8O9G6u0gse
 MihqjnrUvW7jJwoW3QGh6Y/9siqWK5lUUo/MNkPOjxU2OSPf6w3Z56en7S7w3T8bY4jfBxfS7NQ
 6SNFwus2urPEULAayA==
X-Google-Smtp-Source: AGHT+IE9ZmA4lyUjFHDOYkeHg8WJCmnhfEtsoYwZqpCrOlamFFbnAdPJcMYK/fFwVIMszoWDIxqAKA==
X-Received: by 2002:a05:6214:1d2d:b0:6d8:9f61:de81 with SMTP id
 6a1803df08f44-6e46ed8a7d4mr60745796d6.24.1739399036759; 
 Wed, 12 Feb 2025 14:23:56 -0800 (PST)
Received: from bill-the-cat.. ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e4e2b22e2bsm16473896d6.28.2025.02.12.14.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 14:23:56 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Love Kumar <love.kumar@amd.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH] test/py: Have test_usb.py raise an Exception with unsupported
 filesystems
Date: Wed, 12 Feb 2025 16:23:54 -0600
Message-ID: <20250212222354.684526-1-trini@konsulko.com>
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

With a newer pylint we get a warning about how offset could be used
before assigned. This is because when the underlying filesystem wasn't
one that is supported we would have runtime test failures. Address this
by raise'ing an Exception if fs is not supported.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Love Kumar <love.kumar@amd.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 test/py/tests/test_usb.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/test/py/tests/test_usb.py b/test/py/tests/test_usb.py
index 566d73b7c647..9bef883325f0 100644
--- a/test/py/tests/test_usb.py
+++ b/test/py/tests/test_usb.py
@@ -580,6 +580,8 @@ def test_usb_load(u_boot_console):
                     elif fs in ['ext4', 'ext2']:
                         file, size, expected_crc32 = \
                             usb_ext4load_ext4write(u_boot_console, fs, x, part)
+                    else:
+                        raise Exception('Unsupported filesystem type %s' % fs)
 
                     offset = random.randrange(128, 1024, 128)
                     output = u_boot_console.run_command(
-- 
2.43.0

