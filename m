Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C72CECE7A9B
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 09:32:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EC0A80433;
	Fri, 14 Nov 2025 10:32:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="QFwhJCfw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E3C183F30; Fri, 14 Nov 2025 10:32:55 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14C75801CF
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 10:32:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A86F03FB52
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 09:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763112771;
 bh=6980VSu48a3+iAPAWt49K77JfvDApQYnXdEGhyk9P8A=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=QFwhJCfwA7HclOWzclqOxPY4Xk72APy36TAR0p5O2DMjyGPiNQVThVOyEXjENEIQf
 AGXdyH+lQUKUkQpuVozPz0pRfiuWoeSvCnFZf8LTtKG5iJ9BSJpBXFJEu9McRyqz/3
 l7ig/VnZeqGohG+36+Eju6cJyrLTrnOnRFjGtMJGzNWB+J9tz69BR1OdSduRBaA6tk
 ooTBi0I1qjDsBfWnQjFzLvPsZfGjHL8ESFCoADw36/qWJ15P/NnDg2K8ntdlOC4o3Q
 oIKR8Z9EMRINGestIy+t8VPbFLnHZb8kVii3V+wUKPsK8RSr57to5Zrysg3rnD+dz1
 Crh01wOLksxT8D23jDoKgPDm3Kg4L8PwzovazRnp/0w3Q/nh71KGDW+NTpVvs+0ErA
 yhGOgVvql2FJT2wM+yOzYjiGnB/7vwKs1oJLYX33JblvchwQ82z3h3opvcPO7ZQbYf
 uksuDvfIMMNanUweIW5vE1SAYslPb1XleaaKo06tD+q7Y7q9vNM3jFeiYnGACzScjL
 xm9XyFaGnojv7/0Ds2PXJKniu+b0K7TGppzdlen470uXGjrQDYqFmVYDLJZK38ZQy/
 9gquYjTGPpFEMJSOehM9VoIrl/IrFrcVStE1GXxFL+lw6WF1PLldP5fA0Qs4fJNt5T
 jjmfU30CL5lhlj0lOtTo9YO0=
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-477939321e6so1216515e9.0
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 01:32:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763112771; x=1763717571;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6980VSu48a3+iAPAWt49K77JfvDApQYnXdEGhyk9P8A=;
 b=BanUSXM4FkT88TpdjCF0f+hVBk6cvwxx45oh0fBrKLh/w7It32zXZ9HVL+m8XjHXGs
 VooEDl3HaECP2reQWjShkC0WG+QyligJTeQugTlDWbC+hjhDGjPbyX3nAM4rTB4usmbO
 hx8vW1oDy2DffiQHkA5+LLHzWgQPe+nqWKKcle/BboaVQS5pqAUrS91MVdZgOaXPytax
 /B0LwdfG74SwXTVMCYWcPVxH3SZJsHxe15PjGYcdnEU8r11+X+lM5OVtpmGoh09vLvWI
 1eRiibP4ivrg3PH+FiI7xtuRhi7Xb2wO5pzoeitSLM3UCiUxOJ06m1ykiVaZ5t7R2cyf
 tRjQ==
X-Gm-Message-State: AOJu0Yx/96qMKMwd/sX5PYmO8Odn4B+BDa0VToo9pYO4w1qVzdmKAER0
 9qns0s96ZzF9IUVA7KIjEm2CfEHksLCyvu0NVJknubOKFcZcEZQs0Tv0oRevIlermYpbtV66vK8
 XXFMt1Xkn2sScv33I21mWOG2GEW3URiGLARpyzyP5eik8QPDgNtkHuLSsXpLTBFK6IJ+MBjY=
X-Gm-Gg: ASbGncvNohYn8Gtbb1wFwLT+DUZw6XcsQEHeQ+M0JdmfyAXHWNQ6AUF1IyT3spbe3LR
 9WhUSvkRs/dnOFgwOPYAlAgYeJsGUerK9u1I526AkVoQV4t3xhv8QioRNF601WBSsxtSOTGHAV2
 7QHLT6/hf899bkzx6hiMNnTfjruLtXEGqw6LRgFtMLkyLBLrsSKEw+zs9CGWRJ/UDYDfUl4Tq8a
 awwHfpVqbCkfluulF/MZKGD1KB/huPp3BDAyJFtRivrxDXL6kn3Mrf+c+m/oK2IjyO/yw1hzXYD
 j+8bqUYh5WKNtSW0bQNI1pZMqxEDskzLFYSckukGhP5t1/rFpoOTuMtnRYrw2n3Aex/IQR2aWCN
 W62Tfd2hc+KqjbGMHn/N/AsaeWWQ8PGgN1cKa3QMvrJX/b/hbB2mg3b8yP3fz/ttEsg==
X-Received: by 2002:a05:600c:4594:b0:477:73e9:dc17 with SMTP id
 5b1f17b1804b1-4778feba6c6mr23141725e9.35.1763112771165; 
 Fri, 14 Nov 2025 01:32:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEN7EAC5ren3/zqGqx3bbu1iqgx4wHrPx3AO3Jl82FYy4Xy8Q+IdMN+gu20loraQbk6LLL2g==
X-Received: by 2002:a05:600c:4594:b0:477:73e9:dc17 with SMTP id
 5b1f17b1804b1-4778feba6c6mr23141505e9.35.1763112770766; 
 Fri, 14 Nov 2025 01:32:50 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4778c857311sm85462825e9.8.2025.11.14.01.32.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 01:32:50 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/7] efi_selftest: expose runtime table address
Date: Fri, 14 Nov 2025 10:32:39 +0100
Message-ID: <20251114093246.56422-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

Save the address of the EFI runtime as a global variable.

Simplify most tests accessing the EFI runtime.

Heinrich Schuchardt (7):
  efi_selftest: expose runtime table address
  efi_selftest: simplify efi_selftest_reset
  efi_selftest: simplify efi_selftest_rtc
  efi_selftest: simplify efi_selftest_set_virtual_address_map
  efi_selftest: simplify efi_st_query_variable_common
  efi_selftest: simplify efi_selftest_variables
  efi_selftest: simplify efi_selftest_variables_runtime

 include/efi_selftest.h                        |   5 +-
 lib/efi_selftest/efi_selftest.c               |   8 +-
 lib/efi_selftest/efi_selftest_reset.c         |  20 +-
 lib/efi_selftest/efi_selftest_rtc.c           |  25 +--
 .../efi_selftest_set_virtual_address_map.c    |  38 ++--
 lib/efi_selftest/efi_selftest_variables.c     | 121 +++++-------
 .../efi_selftest_variables_common.c           |  55 +++---
 .../efi_selftest_variables_runtime.c          | 183 +++++++++---------
 8 files changed, 190 insertions(+), 265 deletions(-)

-- 
2.51.0

