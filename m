Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F059C83F1A
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 18:43:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B7948277D;
	Fri, 11 Jul 2025 20:43:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="De2xHRGI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBE5B82B07; Fri, 11 Jul 2025 20:43:41 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2ABB826AA
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 20:43:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-735ae68cc78so1403696a34.1
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 11:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752259418; x=1752864218; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=k+JU45rHsvRp2LjZaA7ILzaTbddJ4dDHf62+UESzeU0=;
 b=De2xHRGIEygmFDqgeYEHNrkZTQU17pF4p44O/G92N7DeHbqo7bRasKzeUfzGqoxasP
 dFmiW0Nac6E5So5iTuWFjXA3wh/LKv37yExvwb7FuCXrQjZLxRiQlogWwd+Wu+Ud6T0E
 XPEZZrJCaFmdvxdKaAwJ1nMpN9uywqURZ0lq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752259418; x=1752864218;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k+JU45rHsvRp2LjZaA7ILzaTbddJ4dDHf62+UESzeU0=;
 b=jZAtnJ0jkgQivvUDpGGguw3SU2dq8HRxPdpnlcM4BCvYprhQdFo4WraMTkQsAiy0WK
 C0qIGEg0qn/45bVTmFkfXV+9swKtuycenMH3NVj3Hs41k9adC11H80vLNaxa80cktx4C
 uXGUOHaQ9puZVQC9sRDJV9VHqYHF3sxUAxP3ntObEuVxmfpmGJGow8LSVB21BKi6LMQA
 X9rt6kKUd8Qta73WJYw6X3PpcBiECeFoXetZmYP0O8R9qkMz030EwmKUTJKIoUOLn6F7
 RLlQfZ/onrRpgXbG01Tr2/hUtVOqysv+VlnuXvkHys/rJzw70RRoGoVHoHw9fB/EC4O4
 8Eiw==
X-Gm-Message-State: AOJu0YyCdcHLlGUEWLvUUh62+5rx+GZlzTiMwzGQ+TRqRmmj9FWYLMKl
 8vrUoZef6AVIE3Z6yQ+RkSlHjaIj/YnCUwI2M2SFpHOG9+AK8tkIthOQzY5dpDUPmU58yabx3G0
 5n2BMT4U=
X-Gm-Gg: ASbGnct6V4qKiOX1OIeihcz/bJfEaO3BoCrCdKs9T/AVuAm2Im+0oqrWJVFOOv43wMO
 yfCci+lfker1mL59vEjmunQP6dZzZ11KYsNt8Ga/9krdUFqmlvH5B9eIEwKDuxdFox8fGhikzAv
 zwFSKcr58Ss3YxPTlAM0NPEAXhwqhdAgPM6ZYfn3+VaoTUkPiR8fgRCBa7m8HXwpByskj7vM6l+
 2cJzyAf52i0anx1Npd//IsCu+mS8SaPDiTVD1w0tzfXKT6myfTG5CCc3q5WrE8eIdInJtXyru8f
 ZlGYcQi897N4JQP+1Fi47CB8gzL++gkn/gvffZGhUlKrmsFtFbMVXQTBXNMWRadTpSny0M81F4h
 0EdZ8zlVu3lN9kYntxmz0DSxSPeeP6xA0WZYwRrnZ+NZOLq4k0bb1GSvrQDg=
X-Google-Smtp-Source: AGHT+IEbXCt48bg0pSNJH06TVZ3b7R94lwlwZbLA9BoxZOAFc3F07JR5aPiYE22kFDkVNVK+sMSTAw==
X-Received: by 2002:a05:6830:f97:b0:73a:8705:e9e6 with SMTP id
 46e09a7af769-73cfc2b4fe6mr2398905a34.4.1752259418350; 
 Fri, 11 Jul 2025 11:43:38 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf0f147e7sm645772a34.0.2025.07.11.11.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 11:43:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH] python: requirements.txt: Update a few modules for security
 issues
Date: Fri, 11 Jul 2025 12:43:36 -0600
Message-ID: <20250711184336.2248130-1-trini@konsulko.com>
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

The GitHub dependabot tool has reported a number of issues recently with
some modules that we use. While unlikely to be exploitable in the way we
use them, update various libraries to the latest.

Reported-by: GitHub dependabot
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 doc/sphinx/requirements.txt   | 4 ++--
 tools/patman/requirements.txt | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/doc/sphinx/requirements.txt b/doc/sphinx/requirements.txt
index 12c5772684dc..8572c15ef68f 100644
--- a/doc/sphinx/requirements.txt
+++ b/doc/sphinx/requirements.txt
@@ -10,7 +10,7 @@ MarkupSafe==3.0.2
 packaging==24.1
 pip==24.2
 Pygments==2.18.0
-requests==2.32.3
+requests==2.32.4
 six==1.16.0
 snowballstemmer==2.2.0
 Sphinx==8.1.3
@@ -24,4 +24,4 @@ sphinxcontrib-jquery==4.1
 sphinxcontrib-jsmath==1.0.1
 sphinxcontrib-qthelp==2.0.0
 sphinxcontrib-serializinghtml==2.0.0
-urllib3==2.2.3
+urllib3==2.5.0
diff --git a/tools/patman/requirements.txt b/tools/patman/requirements.txt
index ce9a38545275..d4fcb1061c2f 100644
--- a/tools/patman/requirements.txt
+++ b/tools/patman/requirements.txt
@@ -1,6 +1,6 @@
-aiohttp==3.9.1
+aiohttp==3.10.11
 ConfigParser==7.1.0
 importlib_resources==6.5.2
 pygit2==1.14.1
-Requests==2.32.3
-setuptools==75.8.0
+requests==2.32.4
+setuptools==78.1.1
-- 
2.43.0

