Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C542D15D96
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 14:21:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CE9088EAE;
	Mon, 21 Oct 2024 16:20:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="oK3sZgsk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C004A88F19; Mon, 21 Oct 2024 16:20:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65BF688E91
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 16:20:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729520451; x=1761056451;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=cm0j55BFLuTFJsBTpJUGlFmpQqck2fOfPntxWJUvkzQ=;
 b=oK3sZgskrQs3POoe740uKEcqnUKU7ACncMZDTHFr3k934xr7nsFo1g9u
 eGirLpd6FPPldziTH76neK2DhOkb8VNqeZwPK2Qmme2pgPWW8QK+yseZ/
 ujZz2bFpWMVqnXk3bQE830jpRQeVoPy4Qst5x+fbKq2gqec70MVfeiMbo
 itIRRDOyjBUbR4yn7b5jveYGFdtynX67BFkfvXKAnE5jSzy9bfWT8Szlm
 liEiStlQYSm98a5j5OrepNVJ8GQElI5MuZgmvgKLEolp5dsHSnjWJwrDC
 JkSEdokywAZN9DieA1MxjGXak74q/zTzSE51j97In4F/YNJ/W/6mdD/8b A==;
X-CSE-ConnectionGUID: btHCCUBUSSybT+3ETod91Q==
X-CSE-MsgGUID: pNt/jGmmSg6ECqYM8eyKDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="29103041"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; d="scan'208";a="29103041"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2024 07:20:51 -0700
X-CSE-ConnectionGUID: MOdUUk6HTuGP8h0yjBOY8A==
X-CSE-MsgGUID: gqNmL0ynQji+Iy5poDvfhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; d="scan'208";a="110297881"
Received: from black.fi.intel.com ([10.237.72.28])
 by fmviesa001.fm.intel.com with ESMTP; 21 Oct 2024 07:20:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id 4D1541E0; Mon, 21 Oct 2024 17:20:48 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 1/1] : Mark a few functions static inline
Date: Mon, 21 Oct 2024 17:20:45 +0300
Message-ID: <20241021142045.2981425-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The function prototypes that are defined in the header most likely has
to be marked as static inline. This helps avoiding the compiler warnings:

  include/mux.h:120:14: warning: no previous prototype for ‘mux_control_states’ [-Wmissing-prototypes]
  include/mux.h:125:18: warning: no previous prototype for ‘mux_control_select’ [-Wmissing-prototypes]
  include/mux.h:133:5: warning: no previous prototype for ‘mux_control_deselect’ [-Wmissing-prototypes]
  include/mux.h:138:21: warning: no previous prototype for ‘mux_control_get’ [-Wmissing-prototypes]
  include/mux.h:143:6: warning: no previous prototype for ‘mux_control_put’ [-Wmissing-prototypes]
  include/mux.h:147:21: warning: no previous prototype for ‘devm_mux_control_get’ [-Wmissing-prototypes]
  include/mux.h:153:5: warning: no previous prototype for ‘dm_mux_init’ [-Wmissing-prototype ]

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/mux.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/mux.h b/include/mux.h
index e5deaba66f44..cbb1c331db83 100644
--- a/include/mux.h
+++ b/include/mux.h
@@ -117,40 +117,40 @@ struct mux_control *devm_mux_control_get(struct udevice *dev,
 int dm_mux_init(void);
 
 #else
-unsigned int mux_control_states(struct mux_control *mux)
+static inline unsigned int mux_control_states(struct mux_control *mux)
 {
 	return -ENOSYS;
 }
 
-int __must_check mux_control_select(struct mux_control *mux,
-				    unsigned int state)
+static inline int __must_check mux_control_select(struct mux_control *mux,
+						  unsigned int state)
 {
 	return -ENOSYS;
 }
 
 #define mux_control_try_select(mux, state) mux_control_select(mux, state)
 
-int mux_control_deselect(struct mux_control *mux)
+static inline int mux_control_deselect(struct mux_control *mux)
 {
 	return -ENOSYS;
 }
 
-struct mux_control *mux_control_get(struct udevice *dev, const char *mux_name)
+static inline struct mux_control *mux_control_get(struct udevice *dev, const char *mux_name)
 {
 	return NULL;
 }
 
-void mux_control_put(struct mux_control *mux)
+static inline void mux_control_put(struct mux_control *mux)
 {
 }
 
-struct mux_control *devm_mux_control_get(struct udevice *dev,
-					 const char *mux_name)
+static inline struct mux_control *devm_mux_control_get(struct udevice *dev,
+						       const char *mux_name)
 {
 	return NULL;
 }
 
-int dm_mux_init(void)
+static inline int dm_mux_init(void)
 {
 	return -ENOSYS;
 }
-- 
2.43.0.rc1.1336.g36b5255a03ac

