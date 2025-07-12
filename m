Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C371EC83F20
	for <u-boot@archiver.kernel.org>; Sat, 12 Jul 2025 10:46:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D0E88006D;
	Sat, 12 Jul 2025 12:46:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="EEWl4Bac";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45214800D7; Sat, 12 Jul 2025 12:46:05 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 209C580050
 for <u-boot@lists.denx.de>; Sat, 12 Jul 2025 12:46:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=kettenis@openbsd.org
X-KPN-MessageId: 674058a3-5f0d-11f0-a9c0-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 674058a3-5f0d-11f0-a9c0-00505699b430;
 Sat, 12 Jul 2025 12:46:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kpnmail.nl; s=kpnmail01;
 h=mime-version:message-id:date:subject:to:from;
 bh=dj4tzv8TQP2qbneZHkR6+HChiZC3U9hG1ROt7ZlIYvc=;
 b=EEWl4Bac2vPXljAyYVb3mUoKzM+9gMjIegchd0yMTUF6wpLqg9ICYjl80wnNur6yV0m5edc8irvG4
 HdYd9SNu+Et2CGzcAbIJfml6R/TfYhud8vvb/p1UqiBvcG/jl3VAbNdgqmLDgEy0C7cQ9jXbMiBeGw
 3o9dxFFaTJDTsOq4=
X-KPN-MID: 33|MpRvz9h792k/hQDrPDRmRzeqqw9sqGJ2+uwFmWKt626Txf+0FV4x7faccOJFncD
 P5Q9V684j4p0O8Bsm3bVv5vMBYclD/3vOhpIYG583tfo=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|o/xGmfjyAiYp0ekRN+f6echL+VoEvAuiNutBU6WC+BKgIdcTuhQg5iJ5nQrigfn
 LFL0xc4QBwlVnC8hOBOvuqA==
X-Originating-IP: 80.61.163.207
Received: from korngold.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 674d18c3-5f0d-11f0-9821-00505699d6e5;
 Sat, 12 Jul 2025 12:46:02 +0200 (CEST)
From: Mark Kettenis <kettenis@openbsd.org>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org,
 Mark Kettenis <kettenis@openbsd.org>
Subject: [PATCH] kbuild: Don't mandate gcc as the host compiler
Date: Sat, 12 Jul 2025 12:45:58 +0200
Message-ID: <20250712104558.77355-1-kettenis@openbsd.org>
X-Mailer: git-send-email 2.49.0
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

Systems that use clang may not have gcc installed.  Set
HOSTCC to cc and HOSTCXX to c++ like we did before to make those
systems work again.

Fixes: 5f520875bdf0 ("kbuild: Bump the build system to 5.1")
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index e8f12716640..121ebd5c353 100644
--- a/Makefile
+++ b/Makefile
@@ -416,8 +416,8 @@ HOST_LFS_CFLAGS := $(shell getconf LFS_CFLAGS 2>/dev/null)
 HOST_LFS_LDFLAGS := $(shell getconf LFS_LDFLAGS 2>/dev/null)
 HOST_LFS_LIBS := $(shell getconf LFS_LIBS 2>/dev/null)
 
-HOSTCC       = gcc
-HOSTCXX      = g++
+HOSTCC       = cc
+HOSTCXX      = c++
 KBUILD_HOSTCFLAGS   := -Wall -Wstrict-prototypes -O2 \
 		-fomit-frame-pointer -std=gnu11 $(HOST_LFS_CFLAGS) \
 		$(HOSTCFLAGS) #-Wmissing-prototypes Enable it and fix warnings
-- 
2.49.0

