Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA2FC5472E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 19:12:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22DDD88A3A;
	Mon, 26 Aug 2024 21:12:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Bh5plhgC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8123D8842C; Mon, 26 Aug 2024 21:12:00 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1A0B88B05
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 21:11:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-829e3fbcae0so43433639f.0
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 12:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724699516; x=1725304316; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qsi48lpse2fbMvWlkqcPNO0z/zMoT4aUCmqMKWYhnjI=;
 b=Bh5plhgCWqK7sy6ECsGlSpf53tI7gfl0qk6YnkyEoMLN/v21mmjC8uBLDXt1teSJ+y
 4CdNW0OP/6Owg9MqPXfA7xhbRaeknrJOdrpaVvdASqjUNe3AE+Hy7DrnAhzNE1zdOTEd
 TODpr9qyKf2OCKmerrfdVjn8LfM1kPudSa0Qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724699516; x=1725304316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qsi48lpse2fbMvWlkqcPNO0z/zMoT4aUCmqMKWYhnjI=;
 b=fYFnym5GayDW5otMlPOdl33lwmqe7j3FuewKiae56Y7ybKerlxWqk1C6Cn3mk+OwV6
 qtWzyk3oH3kckSg97FiqhwCf3A2jSrtxYqWl50gelwJCwptvoFhT05PFuO0tis8Exh4s
 5Ix9UPtv7MZqL91aOm7lEoH4Eluwg5/iT2LbENUjoRDBX7TEfFLDO3CuECrsYhXd4k0O
 gHWa0A720rJQYREIEY8rjKc6j/ojHJ+gu7+JnHLKFj6OM+MPrasQWJk8fnxrGfs+66s0
 LvkmLimEdsehrU8ozXqItnhEL2vLrdOVYNdY5IVvHIFVZG1dkZeccoRwgQNQYTmeNNk2
 Qbyw==
X-Gm-Message-State: AOJu0YynqhXN5byQi43hx10e0w2RZyAK/fl49UUC7MMezt0zrDunlU84
 LvjdjQBXSOeSwFXvVOugibbQMBLzm6oCbByNKj81Wza8SNYdFotLpsSUxf9/6W9rpWLlenU372c
 =
X-Google-Smtp-Source: AGHT+IFhrVLaR8HTLvLB3kqpMESLpyJ43s8nUnvj6Py1SKB9/HgwXKNyz6wy3GK9yQM8kevm6txQKw==
X-Received: by 2002:a05:6e02:20ca:b0:39a:eb4d:4335 with SMTP id
 e9e14a558f8ab-39e63dd8cdbmr8856515ab.4.1724699516155; 
 Mon, 26 Aug 2024 12:11:56 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e7c102sm34412575ab.37.2024.08.26.12.11.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 12:11:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/15] binman: Tidy up comments for Entry.GetEntryArgsOrProps()
Date: Mon, 26 Aug 2024 13:11:31 -0600
Message-Id: <20240826191143.426387-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826191143.426387-1-sjg@chromium.org>
References: <20240826191143.426387-1-sjg@chromium.org>
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

Improve the comments for this function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/entry.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/binman/entry.py b/tools/binman/entry.py
index 6d2f3789940..7d4d4692776 100644
--- a/tools/binman/entry.py
+++ b/tools/binman/entry.py
@@ -576,8 +576,16 @@ class Entry(object):
     def GetEntryArgsOrProps(self, props, required=False):
         """Return the values of a set of properties
 
+        Looks up the named entryargs and returns the value for each. If any
+        required ones are missing, the error is reported to the user.
+
         Args:
-            props: List of EntryArg objects
+            props (list of EntryArg): List of entry arguments to look up
+            required (bool): True if these entry arguments are required
+
+        Returns:
+            list of values: one for each item in props, the type is determined
+                by the EntryArg's 'datatype' property (str or int)
 
         Raises:
             ValueError if a property is not found
-- 
2.34.1

