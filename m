Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3BE3C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 11:36:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDF7584A12;
	Tue,  7 Jul 2026 13:36:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZkI9Nzld";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9932684A0B; Tue,  7 Jul 2026 13:36:15 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8687F84994
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 13:36:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-6a1160a2c42so2675606eaf.0
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 04:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783424172; x=1784028972; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GszyVrioQ73doBlwbVtnqsHDsIq4/RFawucofRN06eU=;
 b=ZkI9NzldbG74Ugo8WE5lmXLIaWeprU4xrA1Cxhqhw3qZo77DuXYjDhNL3zAglXHmo+
 S8czxZZsdj93J3gqRsy45z6yQ568pMDrgzJwQJe1kGOngUeREQtsF26aoXWfYTiZbo5P
 cOpy11WrpQ/qvV0BYOxg6MZPRcumzY30eSjew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783424172; x=1784028972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GszyVrioQ73doBlwbVtnqsHDsIq4/RFawucofRN06eU=;
 b=RWyPa1Y36xIWmWCiIpINFyLq1EEwkBVwCme3cAjM8i0bMcFiNcJGjkBm899IcO0Yuv
 srKLWXuN5feu2HQafMKb0JbgV7mf6oRwMdv6yJV1hnq6CcBEBRhX9TlENsTVMbYDqtgt
 oESl2ucrcMItdS00tNPzM+uvzDDWxG9HZ/aUIQIHovDqNQkb/t6jAndtf4lhLI1qAmo6
 6GvJXppIqlh/QDpIUplCIuwdQL+IW5mWdX3/xU5lMNyYtxc1MyV9vQk+YraRcB8lKqZg
 jV598EPuAIGIUxg2nvlGzT4NlqhsAOm/t/bOmfjC0t77KzwLY5LkgViz89fGCy2H/q0h
 AKzQ==
X-Gm-Message-State: AOJu0YzE//dlQXJ82ZMbICFRpwsGgELsEDs7341AI4haBobmq++LCgps
 xlJz0wp4C6WGc3IZMnp3RzNUNSXf1OewxohLJk9TCZzC0x7IcKA5wfPivPgf5km1jkgQ4S1qg7v
 Qk/LaDQ==
X-Gm-Gg: AfdE7cluoErxCgJIT97akstuYl7JJcsXkwStUM6UbLZTWlxYw2F2Jq1VYROZNsJyLMG
 aIP8Hlm/fGNugRd0ebPcwO6PFuLdfmMPNB7Jyvj++k77NtzDurLT8C0b779XOzQhpg6mWcI+93q
 oQgg3+kZkjw9v3mJAT97YcK3u4o43LI2Ot9ULk2jtmqdWsq9LVpMyiv5K6p82VhcBgRKxvE0s/n
 d5TgjBDJuEwUlragTmKXGRHfnVwF9gAp2SGiNuI+3aMb/VvigvOU2t+KgyA4S83whQ7G6l9XZWL
 ob5RqOP0ZApr7KzQ2TXIFLQBs7DXs52p9p0yalqaKmcCV99U/Vxyp0G7QTFEJL3Lz+eRSqXNawC
 iWB06Y74TqCkW5bs6yD08Oio5UKZsQNdaKetSG197mubyKG29w4n90G4j3/ZLnJpzdRqiRs5aJl
 M+Fc617Dc=
X-Received: by 2002:a05:6820:813:b0:6a3:24d9:88a4 with SMTP id
 006d021491bc7-6a3553d9a46mr3212957eaf.59.1783424172267; 
 Tue, 07 Jul 2026 04:36:12 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb6691d1sm13440825fac.17.2026.07.07.04.36.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 04:36:11 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/13] qconfig: Rename do_build_db()
Date: Tue,  7 Jul 2026 05:35:06 -0600
Message-ID: <20260707113538.3382145-6-sjg@chromium.org>
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

This function does not actually build the database; it just adds a board
to the database. Rename it to do_add_to_db() to reflect that.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/qconfig.py b/tools/qconfig.py
index efdb0a0f472..c60cf5c4d1f 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -471,7 +471,7 @@ class Slot:
                 self.current_src_dir = None
                 self.do_defconfig()
             elif self.args.build_db:
-                self.do_build_db()
+                self.do_add_to_db()
             else:
                 self.do_savedefconfig()
         elif self.state == STATE_SAVEDEFCONFIG:
@@ -525,7 +525,7 @@ class Slot:
                                      cwd=self.current_src_dir)
         self.state = STATE_AUTOCONF
 
-    def do_build_db(self):
+    def do_add_to_db(self):
         """Add the board to the database"""
         configs = {}
         for line in read_file(os.path.join(self.build_dir, AUTO_CONF_PATH)):
-- 
2.43.0

