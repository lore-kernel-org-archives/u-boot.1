Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3DEBC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 11:36:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB6CC8490A;
	Tue,  7 Jul 2026 13:36:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JgND74Sg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0372E8494B; Tue,  7 Jul 2026 13:36:06 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1B1C8490A
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 13:36:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-44c9f8c9c4aso1155735fac.3
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 04:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783424162; x=1784028962; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CE/x8xajmk4aS76nFz66CBtty7I/ubVO23qOSAT7vJM=;
 b=JgND74SgVqbw9Y+GmOBplKF2wnIDCma6jM3/jqt18xe5ORFaCLbdG4eK//3jR5EVSg
 bLiMecgRf+4SJ0Mnxm17mL0Z8VMBwOO5dkgPBLopsonxgBqlfJlS0GouNTIfIn4rNSpG
 2VUpvQYUf4qS5IFX5Zt6JTa5XZvrbBWtx8mkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783424162; x=1784028962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CE/x8xajmk4aS76nFz66CBtty7I/ubVO23qOSAT7vJM=;
 b=Ky7/2b/OlIVvuljP+OZxMvifJB39ulFBI2FiaFE78mdobF/jcu462aDOQWTPCsocX4
 jl8uh1dD2oZ+3y+3WrvXdKNlqZi/+9x+weU0tvgSnDy7eLCG7n2V7fXaAPg2gTeTlN4c
 ps5sE8dt1uDgX2ayCy0y3PixoxeigTu3UMkWTw9xYuuqNippUvMV97k+ctaNY0T32C8j
 pOaohAW8eQehzKu0lTcDpshM+OrcDSvLi4YhK/A45jACAmxZ5ED4yfcYyeDtUP/SjqvQ
 6espXQQQj7GCDihsBxb71QGN3qjNy0WAgXSVqkuqlrTBi+GhD1cYXxz7Op1CBdVZCHo0
 uUYw==
X-Gm-Message-State: AOJu0Yznu/F2S0Pw8WO+vA+Y23Z0FlfA9+NQ56kPjS+0ezL7i1DFOgCz
 vqSgU+hij7FEpwXTFE/RPvHCh3ZqjRXYgr7CA/Vp0vYtrymbMuR/fpgrYlVeVxBOZtvhIXB8qpw
 2nU9UIg==
X-Gm-Gg: AfdE7ckzlam4WkPbM0vvzDIo0KNh9fZfXGo3EjittpGO0+qzz5JX9BqqDctaRg6NU58
 IRJr2ViNtSHevOwAwhHI7XWKhk66nSb+YPEO10dQ5WXciOta1ScAXUR3Modn0UilEjJfTRs+axV
 pobbXkbVSBKoHY/Dkz/0NJniFuIyW5XGsCdAYHk9HO12FaFExnV/N9/3SBomx7VBOpfUa+l0hXu
 IbaVmlbPFs5hdw3cJZqG63cDUS7HALZQful2LAb9huI4904+rlmd9RHVFOrgGre0wGIHAF2Ebru
 NE/5UksNCzmEv2aMBtqlvcQ6mwuikj++PPD1VLL/4iWxAw/ubmByGfgHxD/nnFqaSEu/gtEpntY
 UCXdnMD3T+N9+dtGfM/my/eSaCALmQ0e/QX+eIZiCDhkVWX9IUoVqq70/hkoD5dED+DTsDsGQ8z
 yE2PnLFxw=
X-Received: by 2002:a05:6870:82a5:b0:441:419:1fea with SMTP id
 586e51a60fabf-45105e891bemr3160217fac.11.1783424162546; 
 Tue, 07 Jul 2026 04:36:02 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb6691d1sm13440825fac.17.2026.07.07.04.36.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 04:36:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/13] buildman: Fix kconfiglib string-value escaping
Date: Tue,  7 Jul 2026 05:35:02 -0600
Message-ID: <20260707113538.3382145-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707113538.3382145-1-sjg@chromium.org>
References: <20260707113538.3382145-1-sjg@chromium.org>
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

The C Kconfig implementation (scripts/kconfig/confdata.c) stores string
values from .config files verbatim -- no unescaping on read, no
escaping on write. But kconfiglib's unescape() strips backslashes
before ANY character (\n -> n, \x -> x), and escape() only re-adds
them for \ and ". This means \n in a .config string silently becomes n
after a round-trip.

Fix unescape() to only handle \" (the only escape that matters for
.config parsing), and escape() to only handle " -> \". This makes
string values pass through unchanged, matching the C behaviour.

Also fix _expand_str() (the Kconfig file string parser) to only
consume \\, \", \', and \$ (meaningful Kconfig escapes), leaving \n
and similar sequences as-is.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/buildman/kconfiglib.py | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/tools/buildman/kconfiglib.py b/tools/buildman/kconfiglib.py
index 27abbf9a7a1..1bf96e35249 100644
--- a/tools/buildman/kconfiglib.py
+++ b/tools/buildman/kconfiglib.py
@@ -2727,10 +2727,14 @@ class Kconfig(object):
                 return (s, match.end())
 
             elif match.group() == "\\":
-                # Replace '\x' with 'x'. 'i' ends up pointing to the character
-                # after 'x', which allows macros to be canceled with '\$(foo)'.
+                # Replace '\x' with 'x' for characters that are meaningful
+                # escapes in Kconfig string literals: \\, \", \', and \$
+                # (to cancel macro expansion). Other \<char> sequences
+                # like \n are left as-is, so that the stored value
+                # round-trips correctly through escape().
                 i = match.end()
-                s = s[:match.start()] + s[i:]
+                if i < len(s) and s[i] in "\\\"'$":
+                    s = s[:match.start()] + s[i:]
 
             elif match.group() == "$(":
                 # A macro call within the string
@@ -6176,23 +6180,25 @@ def split_expr(expr, op):
 
 def escape(s):
     r"""
-    Escapes the string 's' in the same fashion as is done for display in
-    Kconfig format and when writing strings to a .config file. " and \ are
-    replaced by \" and \\, respectively.
+    Escapes the string 's' for writing to a .config file. Only " is escaped
+    (to \"), matching the symmetric unescape() behaviour. Backslash sequences
+    like \\ and \n are left as-is, since unescape() preserves them and the C
+    Kconfig implementation does not process them.
     """
-    # \ must be escaped before " to avoid double escaping
-    return s.replace("\\", r"\\").replace('"', r'\"')
+    return s.replace('"', r'\"')
 
 
 def unescape(s):
     r"""
-    Unescapes the string 's'. \ followed by any character is replaced with just
-    that character. Used internally when reading .config files.
+    Unescapes the string 's'. \" is replaced with ". Other \<char> sequences,
+    including \\, are left as-is so that escape() can round-trip them
+    correctly. This matches the C Kconfig implementation which does not
+    unescape string values read from .config files.
     """
     return _unescape_sub(r"\1", s)
 
-# unescape() helper
-_unescape_sub = re.compile(r"\\(.)").sub
+# unescape() helper - only unescape \"
+_unescape_sub = re.compile(r'\\(")').sub
 
 
 def standard_kconfig(description=None):
-- 
2.43.0

