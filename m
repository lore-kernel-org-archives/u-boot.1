Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BAFACCD1BF
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 17:26:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF8CE836A3;
	Fri, 24 Oct 2025 19:26:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Y8M72CKy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E30C983826; Fri, 24 Oct 2025 19:26:47 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF32A83677
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 19:26:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-65366485678so1084624eaf.2
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 10:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761326804; x=1761931604; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=F/BzcDj7Ru8EcmFwSK7LVeiGfYvT1pvrGBGRgVr99So=;
 b=Y8M72CKyH3yDs97ocJn2D+3Kfv/GTK8ucVAc5q9tri18NZKW1aBmzMztUgqP6OLhh0
 +JRp64lSz9nQPQ5Jgnqq0qEKqADFKiK0a9+MFJFzgogQXyHko2kyfWw3zueCE72oMBom
 lkBbk3GuXu1uIc1AhWshYvFPl+WOdJanwte/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761326804; x=1761931604;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F/BzcDj7Ru8EcmFwSK7LVeiGfYvT1pvrGBGRgVr99So=;
 b=Lq9Ons7FAW3BREGXOry01T+AmZQYKh8yh2B2Y4BmL6afkSTQmutYZo215/LJQXcPkb
 7pwBycrvEQTJYCgMGvL1WhwgAgucxTNHYLWBA1KAYw5c4+8z4Q0aah9K9dei1CIHZrfI
 w4pcRvM2hMvx33uEmJNqDvjxwSZ9tgfvbBKJAovNcSatj7Bq6XZu4LTvX3Wqu2/jOrO9
 /Sl6DppHsSWokw24ZYUuQhoY30F+rnK/NMVRlBlyYeWXrVN2syGhkW1rIw8QZDEEMeNj
 5eRzJeCIF80oJG4HeEkP06H7HRQzHzpZq2tPaNOSX6Ffpi/KhRiE13Ko5+2QJfWR1ssS
 hsoA==
X-Gm-Message-State: AOJu0YwXHK6utJEyrGQgcoIVAkkuSafUeEq2PvIViBGoT9+FbAobh99Z
 MqULBcWvEGqi2DcO8bI+Cl9nLXKvsDmOW+sfnV7TJeGvtMseGM6Xdvh+m/ezNhOA7c+trLx9BsH
 ZyRjR7I7yEA==
X-Gm-Gg: ASbGnctcOGvWkZiovyRU9Dj61NyPhu20LAUKr8ukPsh3lM1L6grREr678YSlbzA2flS
 Tp9JX6aplf8CZwiMeuZpN6YTVNTES2m/zV1AsUju0JC6mVTWuwInKuXwEspay+9zSHDIWduNSA2
 dWdS6c0yqCa2XaDKRUegHGK/sWQZQMkp54LFOpg1soFnvOaHQ06XZX2OelhK/Y4KBwjpHutMbtC
 EEhTEgsd/VnH8bHt2qMoh/rwSvRHlE5baq7jom/1QUL2mCd70RwNwlHRVYfrRb8FRAFWRG6UMIp
 RaRqk7BR1rrrzo5G//FDsr21Z1VVM1oG8flJH0Eau+NLTERkrjtorJyixeyRPP224JepRc/XBQb
 7uPUtTCzq0DMjfWQhvqpIA902Gp2GjV0xrSTS9UXrNnfTxLeVGafFQrGejt7kHASY9KUXZI3YUT
 pM9UZskG5mEVrDd3XRAc26ijXsNTgP+0y9yM5UtyTKpWK/2EuBAKfQ
X-Google-Smtp-Source: AGHT+IGrm518c4uBmGR7XS70qAz7YpWla7zor4JA9Adm6rA50LuZX5dv+dYhuvIHMC2rAGHiO2imkA==
X-Received: by 2002:a05:6808:1b90:b0:441:8f74:fd6 with SMTP id
 5614622812f47-443a30c7194mr14971902b6e.67.1761326804463; 
 Fri, 24 Oct 2025 10:26:44 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44bd42ee0e0sm1298683b6e.5.2025.10.24.10.26.43
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 10:26:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] test/py: multiplexed_log.py: Clean up and correct RunAndLog()
Date: Fri, 24 Oct 2025 11:26:42 -0600
Message-ID: <20251024172642.2419507-1-trini@konsulko.com>
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

The general python documentation for the subprocess class recommends
that run() be used in all cases that it can handle. What we do in
RunAndLog is simple enough that run() is easy to switch to. In fact,
looking at this exposed a problem we have today, which is that we had
combined stdout and stderr but then looked at both stdout and stderr as
if they were separate. Stop combining them.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 test/py/multiplexed_log.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/test/py/multiplexed_log.py b/test/py/multiplexed_log.py
index 63237594bb40..68dc183e4638 100644
--- a/test/py/multiplexed_log.py
+++ b/test/py/multiplexed_log.py
@@ -138,10 +138,10 @@ class RunAndLog(object):
         self.logfile.write(self, msg)
 
         try:
-            p = subprocess.Popen(cmd, cwd=cwd,
-                stdin=subprocess.PIPE if stdin else None,
-                stdout=subprocess.PIPE, stderr=subprocess.STDOUT, env=env)
-            (stdout, stderr) = p.communicate(input=stdin)
+            p = subprocess.run(cmd, cwd=cwd, capture_output=True, input=stdin,
+                               env=env)
+            stdout = p.stdout
+            stderr = p.stderr
             if stdout is not None:
                 stdout = stdout.decode('utf-8')
             if stderr is not None:
-- 
2.43.0

