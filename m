Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE855D5C0EF
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 15:24:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56FFA8921A;
	Fri,  8 Nov 2024 16:24:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fJIuhXEo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B41E88DF1; Fri,  8 Nov 2024 16:24:07 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA55289234
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 16:24:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-83abf71f244so78517639f.1
 for <u-boot@lists.denx.de>; Fri, 08 Nov 2024 07:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731079443; x=1731684243; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=baJgkOjM7jWVmh7ZPs6haPQCR7dBr99teF0s1K667VI=;
 b=fJIuhXEoeUDOwFrp3IwpvjmTZFsr3ISdFrup693xYL+YnijjAbhQQzC2U3piNFuw+L
 k1DSEZa2uckH42759XgpbYQC+3QFue/Au+M8gL7KHYx+FoWJWNnmqfT53r/HeLi9RBQV
 LP3CKS9sRU1P1hm094N+zUwPb1OpGz2dYsVbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731079443; x=1731684243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=baJgkOjM7jWVmh7ZPs6haPQCR7dBr99teF0s1K667VI=;
 b=qDp7Lh/QqkTH0lCx4oP5GwR5IhjyN4YjImw6+X6iy1XjFn56o6TQL8Te26n0RljQrs
 WCymhfEXoKl+337vxENascxzHmngVXKP1vjTh/HkhKab0iI1x1rmsbRLNmwnlsTlVA/8
 DKyjYpLkXX3T71HwNnb+O5gwprR9HsuBCxeEetFMKGfLgQYiWtoRhQvmragCSUInQjaR
 xOapNRX4Zn/uYbZUS/32Du3D1ZkZvUfGnk0dfHQ3TKM/06WYbm9spdqAffJAkVGqjWsm
 iFbRBF7geFiH05VWV1frfnsnkGxPmnzk1O1D/tn7eKvWXbWwpUbhOyVDENDdS9UfgcBO
 YSfw==
X-Gm-Message-State: AOJu0YxWu+xucSmjLATKXg4wFbGjBb9y/udpk2n+388I1CqJSni/VCFv
 0yeQ5wDaILISI+ah0zco4xg/3mhU3ZI5N2Fqdp0eWE+avyyfQddND7OzIUEaWHZliSRBQVOrVT4
 =
X-Google-Smtp-Source: AGHT+IENMIjdgmxkBfKPsQOIlT8kKsc3XLhRmd+qI6pJ4PMSVtUjjd6Awci/BtfH92Qtr4MOgpnmNA==
X-Received: by 2002:a05:6602:1481:b0:83b:470d:bcdf with SMTP id
 ca18e2360f4ac-83e03362140mr420112239f.13.1731079442884; 
 Fri, 08 Nov 2024 07:24:02 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de5f7e3283sm864420173.6.2024.11.08.07.24.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 07:24:01 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 5/9] buildman: Document the toolchain-prefix section
Date: Fri,  8 Nov 2024 08:23:46 -0700
Message-Id: <20241108152350.3686274-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108152350.3686274-1-sjg@chromium.org>
References: <20241108152350.3686274-1-sjg@chromium.org>
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

This is mentioned in examples but should have its own mention in the
'settings' documentation. Add it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/buildman/buildman.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
index 5eda01fd5e1..73a13134a4d 100644
--- a/tools/buildman/buildman.rst
+++ b/tools/buildman/buildman.rst
@@ -933,6 +933,12 @@ a set of (tag, value) pairs.
     For example powerpc-linux-gcc will be noted as a toolchain for 'powerpc'
     and CROSS_COMPILE will be set to powerpc-linux- when using it.
 
+'[toolchain-prefix]' section
+    This can be used to provide the full toolchain-prefix for one or more
+    architectures. The full CROSS_COMPILE prefix must be provided. These
+    typically have a higher priority than matches in the '[toolchain]', due to
+    this prefix.
+
 '[toolchain-alias]' section
     This converts toolchain architecture names to U-Boot names. For example,
     if an x86 toolchains is called i386-linux-gcc it will not normally be
-- 
2.34.1

