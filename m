Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD61FC5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 21:04:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 107C08786A;
	Mon, 11 Mar 2024 22:04:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RA1qamxL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0C84878E2; Mon, 11 Mar 2024 22:03:58 +0100 (CET)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31B8E876F3
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 22:03:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dianders@chromium.org
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5a142375987so1778147eaf.3
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 14:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1710191034; x=1710795834; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iGTuoZMUxQXaoGUqU9XGgKb16HqLt2AMZkYZrtWH6B0=;
 b=RA1qamxL94HfHa5GPT7T/mUrfzT5XRPJ1y5YETN04llL2S67txiKHPhoVn9vLXcGhX
 Lni/zRf72J8M0uV+l92gDNp3/5kVfj4YObNcQlH1bvr1xwdvc/y7goz443MnEmv3/Jek
 0vsDn3LXEouiaf8MoTMgcxuIOG7P+w/NlEzNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710191034; x=1710795834;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iGTuoZMUxQXaoGUqU9XGgKb16HqLt2AMZkYZrtWH6B0=;
 b=MY1nZS03da9KZ9tXp854kzeO5q68KG6JoMv7QmGcmstT3OjbD9B4u6bEPZPbSxHURN
 tBRrgm+Svep5Dg8N4dAUXKfyaRzQ0P/AdHRiqwHRFMI0QevZZh2cSgYrCRQhyz6nncnk
 VYY/+ao/ZO8bfNQ1KjRsLhM/iHrcypFPlE/QXBQ76UBgIIEHYw/gLOKprA72Skt5ANZp
 9rG+HbylkhRhho1skgIoD+i96eadBGjFxqU+8Ln2+OK33cQqouy3mPRZPGqkGBvrUoQD
 A9BO0/vjSeqn/pAp2Nt37pDh2nBQ/GfWDRjxJvH+oq98r3JuyNu5wdKj7hOHfbx+Kvzq
 yKIg==
X-Gm-Message-State: AOJu0YyPKwhfKhS2SEHP66qsZmSPYPP6sncwfze9Qeyff529oB5wftWc
 2KffzUst6b14xKV7umqX2Tz23rvFmUZaDORmPx1O0Qh85yNXkrXVqLnWar3aKX7NcbDrJi+jgVk
 =
X-Google-Smtp-Source: AGHT+IElSpHiGvvpXpHNP6oQ6cxN8TOoZixc3I+K/+w+YocfAuX0QpEKuxgFpfZqlarQiwVNSdzK6g==
X-Received: by 2002:a4a:3050:0:b0:5a1:2209:8e04 with SMTP id
 z16-20020a4a3050000000b005a122098e04mr109795ooz.7.1710191034372; 
 Mon, 11 Mar 2024 14:03:54 -0700 (PDT)
Received: from dianders.sjc.corp.google.com
 ([2620:15c:9d:2:7e32:7d9e:48da:81ab])
 by smtp.gmail.com with ESMTPSA id
 r12-20020a62e40c000000b006e64bf2261asm4813770pfh.104.2024.03.11.14.03.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 14:03:53 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: u-boot@lists.denx.de
Cc: Douglas Anderson <dianders@chromium.org>,
 Grzegorz Szymaszek <gszymaszek@short.pl>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Cournoyer <maxim.cournoyer@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] patman: Properly document the patchwork_url setting
Date: Mon, 11 Mar 2024 14:02:45 -0700
Message-ID: <20240311140244.1.I0bf8a3184dc6c7343fccd59e00f2a65435dc6b96@changeid>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
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

The "Series-patchwork-url:" tag description says that it overrides the
settings file but doesn't specify the name of the setting. Elsewhere
in the documentation about the "useful" settings we see a setting that
sounds promising called "patchwork_server" that's actually not a valid
setting. It should be "patchwork_url".

Fix these problems so the doc is right and more useful.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 tools/patman/patman.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/patman/patman.rst b/tools/patman/patman.rst
index e01355824c59..f4588c00fc11 100644
--- a/tools/patman/patman.rst
+++ b/tools/patman/patman.rst
@@ -144,7 +144,7 @@ patman.py.  For reference, the useful ones (at the moment) shown below
     process_tags: False
     verbose: True
     smtp_server: /path/to/sendmail
-    patchwork_server: https://patchwork.ozlabs.org
+    patchwork_url: https://patchwork.ozlabs.org
 
 If you want to adjust settings (or aliases) that affect just a single
 project you can add a section that looks like [project_settings] or
@@ -248,9 +248,9 @@ Series-links: [id | version:id]...
 
 Series-patchwork-url: url
     This allows specifying the Patchwork URL for a branch. This overrides
-    both the setting files and the command-line argument. The URL should
-    include the protocol and web site, with no trailing slash, for example
-    'https://patchwork.ozlabs.org/project'
+    both the setting files ("patchwork_url") and the command-line argument.
+    The URL should include the protocol and web site, with no trailing slash,
+    for example 'https://patchwork.ozlabs.org/project'
 
 Cover-letter:
     Sets the cover letter contents for the series. The first line
-- 
2.44.0.278.ge034bb2e1d-goog

