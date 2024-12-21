Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26AE1E7718B
	for <u-boot@archiver.kernel.org>; Sat, 21 Dec 2024 17:45:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8221880562;
	Sat, 21 Dec 2024 18:45:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VWqiZ7xp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E92028056A; Sat, 21 Dec 2024 18:45:36 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47525803CB
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 18:45:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7b6f19a6c04so251122685a.0
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 09:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734803133; x=1735407933; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ajjHue8u0/PKcNGxr0SoXKRzOUHirzMZvIVHXLG6QDE=;
 b=VWqiZ7xp6h+Wl9sGPSClt1Cf1H8AexCztGBUW0DrJTL5jpFOEmHuRRRUVEjVTvDW5P
 1TIM8lzwFFe75/VwdIdnz97wD2z6JNEe1dPTjFqxAa7X4WqQDOUxHWUONFxNzAzkMroJ
 pBbbDgMLBI5GlHknUXcH1kutoxHZ9VtSA51y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734803133; x=1735407933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ajjHue8u0/PKcNGxr0SoXKRzOUHirzMZvIVHXLG6QDE=;
 b=kGuY/F+a/yU11ewgJJdv/pygBPQlbBMzCq721Rh+ime9+amT2LQV6qBw0knJPxxD2Y
 vQs2ydeRSYgiglMIkAC4/g7VYQXm5wk+V3DsXugKbptsMj/6i3GpJI5LsgWd+61TWb0E
 fFuc7OR/dn1yiTJ1CvnE94xuDzbjwqhY9LCD5aHZU1YDRjZdQ/r0L5ehSuXXwYDjrk2n
 FO9IvH7Q8NNAQ+knhsjRJ3JwgaemP25vBjSHnfHIDIWdS6Ga2BI3ZBwyiaAd3fQkFjJt
 9mI4OlTBaTrAsYxD4EhSQTSbSC6I8COz0mj2Z2FIk27VKIvzkAwf06FBJOeFdkCJBwHN
 A7zg==
X-Gm-Message-State: AOJu0YyCa7FYw4O7THme7HjwGaxnSY9xn7r8RzSV+JVwZhA2SzgAZMzz
 W2o2fkDXoA3y7dcvNvjdE2iUe+7FBBwWrkqLLziMxTDc9Qi7I4ecp6QbScNwI8TQe/I9RDFtnXB
 H3ds=
X-Gm-Gg: ASbGncuXpoQ2lmDO3wnxsJ1jD/fVBzf2JWVpwN3AgjW68Cxx7jZIFHaCUxkCrrv0M44
 Z0DBw4f27WZsY3opnGPC4i0ij7CwxJlbOifU1OviSwjUBz+CYrq34TpwWPmBu+jwnBtUsv5WQwH
 hGvq+aLyNegoB8001JN52FWlgt8dtGDVrtJwnkRMycshJNxf7HbFMV14vJwh2GlpTz33u2dHrmA
 XQ4Njf0occNql4FDm2FcXRY7Qy2LKkrEwHSk+WWcaXqt7dpP1TTa58P8mXCERK9r6ZVbbNJ8980
 cqUY
X-Google-Smtp-Source: AGHT+IG4TXd1HNdmd/w9Rz3ICewDyxV5T0z/DrWYe5x37GVqE9/D4jXi/+aFFOlVzELLq7cmgCgZPw==
X-Received: by 2002:a05:620a:244c:b0:7b6:d8aa:7ef8 with SMTP id
 af79cd13be357-7b9ba7b18c6mr1453500585a.37.1734803133029; 
 Sat, 21 Dec 2024 09:45:33 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac4cd53fsm238231185a.112.2024.12.21.09.45.31
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Dec 2024 09:45:32 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCHv2] doc/develop/distro.rst: Better document upstream definition
 of extlinux.conf
Date: Sat, 21 Dec 2024 11:45:29 -0600
Message-ID: <20241221174529.1839959-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220144754.3734519-1-trini@konsulko.com>
References: <20241220144754.3734519-1-trini@konsulko.com>
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

First, the "Boot Loader Specification" link has moved to a new location,
so link to that directly. Second, that link does not document as much of
the extlinux.conf format as I recall the old version doing at least.
However, the Syslinux Project wiki is the current location of the documentation
linked to in doc/README.pxe and also has a reference for SYSLINUX. Link
to both of these.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- As Simon noted there is a SYSLINUX page on the Syslinux project wiki
  as well that documents other options, reword the introductory
  paragraph more and link to both SYSLINUX and PXELINUX and then our
  deviances from that.
---
 doc/develop/distro.rst | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/doc/develop/distro.rst b/doc/develop/distro.rst
index 637bc27fc2d7..1d2f9c4c32bc 100644
--- a/doc/develop/distro.rst
+++ b/doc/develop/distro.rst
@@ -67,11 +67,16 @@ Boot Configuration Files
 ------------------------
 
 The standard format for boot configuration files is that of extlinux.conf, as
-handled by U-Boot's "syslinux" (disk) or "pxe boot" (network). This is roughly
-as specified at `Boot Loader Specification`_:
+handled by U-Boot's "syslinux" (disk) or "pxe boot" (network). This format is
+not formally standardized and documented in a single location. However, other
+implementations do document it and we attempt to be as compatible as possible.
 
+* The UAPI Group Specifications `Boot Loader Specification`_
 
-... with the exceptions that the Boot Loader Specification document:
+* The Syslinux Project documents both `PXELINUX`_ and `SYSLINUX`_ files and is
+  the originator of the format.
+
+That said, we have some differences to these documents, namely:
 
 * Prescribes a separate configuration per boot menu option, whereas U-Boot
   lumps all options into a single extlinux.conf file. Hence, U-Boot searches
@@ -440,7 +445,9 @@ way in future u-boot versions.  In particular the <device type>_boot
 variables (e.g. mmc_boot, usb_boot) are a strictly internal implementation
 detail and must not be used as a public interface.
 
-.. _`Boot Loader Specification`: https://systemd.io/BOOT_LOADER_SPECIFICATION/
+.. _`Boot Loader Specification`: https://uapi-group.org/specifications/specs/boot_loader_specification/
+.. _`PXELINUX`: https://wiki.syslinux.org/wiki/index.php?title=PXELINUX
+.. _`SYSLINUX`: https://wiki.syslinux.org/wiki/index.php?title=SYSLINUX
 
 .. sectionauthor:: (C) Copyright 2014 Red Hat Inc.
 .. sectionauthor:: Copyright (c) 2014-2015, NVIDIA CORPORATION.  All rights reserved.
-- 
2.43.0

