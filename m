Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733F0C2BBCA
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 23:07:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48ACC88555;
	Fri, 21 Jun 2024 01:06:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iAid8nqb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B9FC8834D; Fri, 21 Jun 2024 01:06:44 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 677EC88568
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 01:06:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7ec0385de1fso48787239f.3
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 16:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718924800; x=1719529600; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=asc59Z1ZDtMFES+Na6cEttWuA//ajEC8Am+1ZXIXMXY=;
 b=iAid8nqbQ9iKKnnkkJLFEI506m7zyVs7bIC3w2stC8llwi0bdU9emNKXAzJ4H/UadJ
 ZYgHUDvYikKurrX9BAGCwzfjXtnIGmGPLWMWILZEZX+0WLRUn0m9c08jbL9WfeMrbSZ8
 vg11kEZ6g4CKCo8vn4wDFeferXkNNv15/Te44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718924800; x=1719529600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=asc59Z1ZDtMFES+Na6cEttWuA//ajEC8Am+1ZXIXMXY=;
 b=tsx79QgI9KRZUwQHQAucdvBPI5hg62421oJ8nwgvCNAsDYhZf+8Xs1TP1YQpqdovRg
 WsqRQm8A+InFVNgH2wi+eA4TO6PTEf0SIthA83tLVCjJR14ZqpNr2ZlJziCkDWbLAww5
 rAHy4pn/Ki5dm0snHEbJsyO2+BsjclPrhdaalVUgjkcRAg1B2uMLlbrJ2vSuKy4hjCz8
 618xRMfNk4yp1u74fWcsMIU0HOyq/TQzNTWtYXUBa4zKfkspWrN0s+PyfoyV1kgglNTI
 hYFDwfSgKB7V9UIZYhvQAMUnNpOlq0hIYLKjsQfHbrBvk4dTGXoTPSD572W0d3bR6Z0o
 vtSg==
X-Gm-Message-State: AOJu0Yw/wx0Xw0TUqlCWp4Tsc6qUSWxaoMOgng71xj8MtTmRI1M3Oo3I
 WaOP7GjL2ldigGmHZ7/LS764f1k9maOGCb1clvZnyUxFIg8eEgqz0kn+qazP4WFNDNlMlFxkRz4
 FKg==
X-Google-Smtp-Source: AGHT+IFQjFTX1P4UvEfXcTyIC1fFAT+6XcBnIsus8YiY9rnssLtgYtzPl0XfbWI5tfw7AXqxp9jfig==
X-Received: by 2002:a05:6602:2cd3:b0:7ea:da27:e59e with SMTP id
 ca18e2360f4ac-7f13ee664f9mr814369539f.12.1718924800034; 
 Thu, 20 Jun 2024 16:06:40 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d110f566sm53269173.44.2024.06.20.16.06.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 16:06:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH v3 02/18] binman: Make Intel ME default to position 0x1000
Date: Thu, 20 Jun 2024 17:06:09 -0600
Message-Id: <20240620230625.1797397-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620230625.1797397-1-sjg@chromium.org>
References: <20240620230625.1797397-1-sjg@chromium.org>
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

This cannot ever go at offset 0 since the descriptor is there. Use a
better offset for the ME, as used by link and coral, for example.

This matters when we start using assumed sizes for missing blobs.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/binman/etype/intel_descriptor.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/binman/etype/intel_descriptor.py b/tools/binman/etype/intel_descriptor.py
index 7fe88a9ec1a..3ce967fe81a 100644
--- a/tools/binman/etype/intel_descriptor.py
+++ b/tools/binman/etype/intel_descriptor.py
@@ -59,7 +59,7 @@ class Entry_intel_descriptor(Entry_blob_ext):
         if self.missing:
             # Return zero offsets so that these entries get placed somewhere
             if self.HasSibling('intel-me'):
-                info['intel-me'] = [0, None]
+                info['intel-me'] = [0x1000, None]
             return info
         offset = self.data.find(FD_SIGNATURE)
         if offset == -1:
-- 
2.34.1

