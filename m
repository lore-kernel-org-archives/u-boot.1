Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 627B1C4828F
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 14:35:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C9B887E70;
	Fri,  9 Feb 2024 15:35:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CmlkwG6A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF3BB87E71; Fri,  9 Feb 2024 15:35:25 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6C4B86E96
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 15:35:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-783d84ecb13so64676585a.0
 for <u-boot@lists.denx.de>; Fri, 09 Feb 2024 06:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707489322; x=1708094122; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=d9dCklKEPTrJPnHUygdhhrbd4croxlES6ShRU0j/3Ks=;
 b=CmlkwG6AtOIV0sGh5FvX3tpmef788eAS+R3ruG4M5QacJH2GLhh1OVSyduXKYM0CHl
 H5aDBdiIeVEIIKVuw7u9YHZOiwx+QB8H51nJfFFyhSq3W7Z3+/FLL7eaGd5IXk6Q2DZu
 K5+p6BjPl3jZB4NU1QyogC7G00+L1m9i1c4/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707489322; x=1708094122;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d9dCklKEPTrJPnHUygdhhrbd4croxlES6ShRU0j/3Ks=;
 b=ihj1xOxT0BhCZ1SFwUiEGV1kHF4xy3qT+rzUmCNPac1Ho0jLnYeFd2lI2XeKs2mLNM
 1Sqipn4DCSwCcK0h+bAmAgS53EIIjfnmDTg3WBhfaQeAD9YwNg6G7hne7prIZNIBCbut
 OKF2UZUojjnZLAgG4yXyWVAnbNpn06Pgvftn/cO5L7I6ditReNuAF4kvx+Ce6MX/CYyP
 +1FR0NYHdzYaem8tsfQDVJQeE6GTSq+4tvY0D0bYp13abSW8uQDtfIT3gD5QCMyQ0hrY
 IIdeThzryh+6gpOo6SOjWsEYc6+TuaNmFEaJA8uffL4uRoiOI4a+9c8vOiERD+5MYOkB
 9Nmg==
X-Gm-Message-State: AOJu0YwJgpxVxE9SHxH0xYD/7+iHL/0zK2z4a6djmly3NApu/cBPldE5
 Ki981R2Vh0kowN7C3US3AbJ8hx2rGtQl5E2h1OlseQqMfSwLbbyugE2Mr8Dhg1/MVve7aMuY58M
 9
X-Google-Smtp-Source: AGHT+IFMAjEuAfnyQX4VIBpKtWJyc37pATV9wKKiWm8MCQ70TUASSirq08Q/ZKW4weNC2FMAfBSo5g==
X-Received: by 2002:a05:620a:450c:b0:783:7775:b395 with SMTP id
 t12-20020a05620a450c00b007837775b395mr1979854qkp.74.1707489322177; 
 Fri, 09 Feb 2024 06:35:22 -0800 (PST)
Received: from bill-the-cat..
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 c6-20020ae9e206000000b0078554c8111asm763488qkc.108.2024.02.09.06.35.21
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 06:35:21 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] doc/develop/codingstyle.rst: Clarify include section
Date: Fri,  9 Feb 2024 09:35:20 -0500
Message-Id: <20240209143520.2724221-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

Rework the section about includes slightly. We should not be using
common.h anywhere, so remove that from examples and ask people to send
patches removing it when found. Doing this also means we need to reword
other parts of this section. Be clearer about using alphabetical
ordering.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 doc/develop/codingstyle.rst | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/doc/develop/codingstyle.rst b/doc/develop/codingstyle.rst
index b25bfbd271f0..cdf5aedfcbb0 100644
--- a/doc/develop/codingstyle.rst
+++ b/doc/develop/codingstyle.rst
@@ -108,30 +108,29 @@ expected size, or that particular members appear at the right offset.
 Include files
 -------------
 
-You should follow this ordering in U-Boot. The common.h header (which is going
-away at some point) should always be first, followed by other headers in order,
-then headers with directories, then local files:
+You should follow this ordering in U-Boot. In all cases, they should be listed
+in alphabetical order. First comes headers which are located directly in our
+top-level include diretory. This excludes the common.h header file which is to
+be removed. Second are headers within subdirectories, Finally directory-local
+includes should be listed. See this example:
 
 .. code-block:: C
 
-   #include <common.h>
    #include <bootstage.h>
    #include <dm.h>
    #include <others.h>
    #include <asm/...>
-   #include <arm/arch/...>
+   #include <asm/arch/...>
    #include <dm/device_compat.h>
    #include <linux/...>
    #include "local.h"
 
-Within that order, sort your includes.
-
-It is important to include common.h first since it provides basic features used
-by most files, e.g. CONFIG options.
-
 For files that need to be compiled for the host (e.g. tools), you need to use
-``#ifndef USE_HOSTCC`` to avoid including common.h since it includes a lot of
-internal U-Boot things. See common/image.c for an example.
+``#ifndef USE_HOSTCC`` to avoid including U-Boot specific include files.  See
+common/image.c for an example.
+
+If you encounter ccode which still uses <common.h> a patch to remove that and
+replace it with any required include files directly is much appreciated.
 
 If your file uses driver model, include <dm.h> in the C file. Do not include
 dm.h in a header file. Try to use forward declarations (e.g. ``struct
-- 
2.34.1

