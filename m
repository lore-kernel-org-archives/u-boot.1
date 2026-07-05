Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CABC43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 19:33:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87E3084942;
	Sun,  5 Jul 2026 21:33:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SCYw4+V+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D327684105; Sun,  5 Jul 2026 21:33:19 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5392F8484C
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 21:33:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6a149bfb2a8so939160eaf.2
 for <u-boot@lists.denx.de>; Sun, 05 Jul 2026 12:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783279996; x=1783884796; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5v6zPOjJxxfbCGL6eBwcz49b2tpEa+iOlL9wxg+dY7A=;
 b=SCYw4+V+MU3Zf5ZW/9aZQq8SxJdySwZZxkBgQJp7il4mMbF2gS8hvPigByaaqUPJVg
 dcWNxLvqkeEoIoCda+aUDU3zlg95evctBxNNQdorCPRbqD+eQZEPaDhhPbg0jzlojL9U
 lRO+vjBdLFeHbawuWpD5nLXSSbHqfrB2AqPs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783279996; x=1783884796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5v6zPOjJxxfbCGL6eBwcz49b2tpEa+iOlL9wxg+dY7A=;
 b=Q72qyTm+Pwrpuke7HbTEVwk2g7KbUtHfxzeCyk4ubw/xGVTIXPwWgaD8AmaQrWh+Tm
 j8pW64ge7//3y0eyztsGrLaObjTXyjx/sutAhub6gbDo1pozyeOGWzehOQ8PIcWMufDY
 B7JV287/Azz15ykehr1lPzdxa7n8wBDBpYfaNkezpvOWnCfSsdqOhlBHP6zaveKbHvfY
 ASfeMO/GOzljt0zlY3jsB7DUTqXOtUlsmF3jwsG6Astc1e/kD5Yt7i/iAgu5QD5FcohO
 /NbI1uHR1JWI/7JQIKCOFq9DiKR/vZgLe8J+75Fk3op9I/VckLE0Rg6j29ZSl57YrxHS
 ONSQ==
X-Gm-Message-State: AOJu0YxPbrYOpfmY1OjayoDxv6wDv0Q2Qddu0D7EFDSDNmBVBb8163VH
 skGANnPnqcanHROI+P2YdK8JW30b1DTvk+6saBGjNgW6hU8rldTe4AYpeQqNsuSma7t8BHxUw07
 I62HxbQ==
X-Gm-Gg: AfdE7cn/kLXrqHYJxdbcaYSSoYg/i2vHsFCi3WD3hMCeACCoVJNic+zpxePeO01G4mC
 RYpm/HOdtcD3Uc2qhH0PRlyHu4sM+xqQVnMfw3Om9mtCn9wBe7DFvGwjR1fdj/jPeLivKEeoVAT
 Kd90ns2LsB0c4ECEqcZ619Wm9ckZaQFx/kAGO1r7eoBIVxpMfVsJk759fNIPnAgoo6U3m9Pn3By
 Dv93f0siV8srKXrU3o8qyE4hMjSYcxijxq5MjbGHcf7wvUDErWZbrgZ+08m0Nyb/Tzkbw3oyH0B
 ZtPZP6TynMvU/KntXqyelDu9YH4SFEWtHma+EgBLve5LSDUKU0k4W8dsBf8+01AhG2S+eyKMfsZ
 mGiwb8VTzA2qKmcrEzWj3veQfkwR4EhBz1xjz8qkNdAOr3ny8RJBaAayN8x2rhwgku8fUk9KnWT
 5mhaw=
X-Received: by 2002:a05:6820:6ad0:b0:6a1:55b2:83df with SMTP id
 006d021491bc7-6a32f46cac2mr4080367eaf.8.1783279995981; 
 Sun, 05 Jul 2026 12:33:15 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a3103e064esm7513448eaf.14.2026.07.05.12.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 12:33:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 03/11] patman: Add a .patman-defaults file for U-Boot
Date: Sun,  5 Jul 2026 13:32:14 -0600
Message-ID: <20260705193251.2190705-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260705193251.2190705-1-sjg@chromium.org>
References: <20260705193251.2190705-1-sjg@chromium.org>
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

patman is now installed from the separate patch-manager package. It reads
a .patman-defaults file from the tree root as its lowest-priority config,
so a project can ship defaults that developers still override from their
own ~/.patman, a local .patman or the command line. This behaviour is new
in patman version 0.0.20

Add one for U-Boot, alongside .b4-config, pinning the patchwork server and
the get_maintainer.pl invocation so the tool works out of the box without
depending on patman's built-in defaults. A few other settings are listed,
commented out, as a starting point.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- New patch: add a .patman-defaults file for the external patman tool

 .patman-defaults | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 .patman-defaults

diff --git a/.patman-defaults b/.patman-defaults
new file mode 100644
index 00000000000..6b6063b05f4
--- /dev/null
+++ b/.patman-defaults
@@ -0,0 +1,32 @@
+# Default patman settings for the U-Boot tree
+#
+# patman is maintained separately; install it with:
+#     pip install patch-manager
+#
+# See https://deinde.dev/patman
+#
+# patman reads this file at the lowest priority, so anything set here is a
+# default that you can override in your own ~/.patman, in a local .patman or
+# on the command line. patman autodetects the U-Boot project and locates
+# scripts/get_maintainer.pl on its own; the patchwork server and get-maintainer
+# script are pinned here so U-Boot does not depend on patman's built-in
+# defaults in case those change.
+
+[settings]
+patchwork_url: https://patchwork.ozlabs.org
+get_maintainer_script: scripts/get_maintainer.pl --norolestats
+
+# Other settings you might set here as project defaults:
+# process_tags: True
+# add_signoff: True
+# check_patch: True
+# verbose: False
+# smtp_server: /path/to/sendmail
+
+# Aliases are recursive and are usually kept per-user in ~/.patman:
+# [alias]
+# me: Your Name <you@example.com>
+
+# Addresses known to bounce can be dropped from the recipient list:
+# [bounces]
+# someone: A Name <someone@example.com>
-- 
2.43.0

