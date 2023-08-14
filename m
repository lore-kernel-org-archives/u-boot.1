Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F527C04A6A
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 22:42:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B479869E2;
	Tue, 15 Aug 2023 00:41:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S/hOlrcF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62719869A2; Tue, 15 Aug 2023 00:41:28 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42F31869D2
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 00:41:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7910620f45dso188472139f.1
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 15:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692052885; x=1692657685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o79s+jVKTG6sXZeyeeFwmxvZhMLmWqP1ok+MUE8Rf9o=;
 b=S/hOlrcFGbBPugmTrtv+HNF1nDO1f1JP7F3fsnIcaH2nWxcJQDFnVFbUPfxQvbNcwA
 EbpV6cF7IzYS1kqKxfotlE+Kx1H8EMGZX3R2hKEALc7K6M0JPzY6w2qBPmqyvpmhZs7I
 UUpLHuWIrEC325yuyKgRjuUBvn42k9hGCyrl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692052885; x=1692657685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o79s+jVKTG6sXZeyeeFwmxvZhMLmWqP1ok+MUE8Rf9o=;
 b=iwtp0HsTqHqx/rrydwGBtwNrSAF438zhHuWRA1VceatzQnkyteP7nrOGFW0ltx4CuY
 mVZvjRvi+rqzjz3XRVoCXoye6pZyxrUreBR7G4rW99nPxEq1LnAlLWjcBotvEsx0pEhr
 iToFYpJYX719wI5FULHaXyhAGmEzbl/A8e3qwku9phNmO4ZmZquVlPKlvuPraiLNu3E4
 pTM7xSvokQmVVeN0bunk8Odu0IywMrzJF0Z5GXWwugjzMpVTjo9YidWkeChdhy+QSj16
 1h+6twZ6eNaJFAuqMAWXnTg6RuGV4UdC3ogju7Bwgo0MQ7EFTWgZtwA+XoIFFTk8jThQ
 Q2cA==
X-Gm-Message-State: AOJu0YzpJNNafwf1vb0AU07AKZbmkrjRr5d082H/QlSXQFd5rnm6+oI2
 bf9rSXRizbRUQwm4oJh09JH4W3F0mb9jDUDOmJc=
X-Google-Smtp-Source: AGHT+IFyQi61s/UjpI/u4R+/r52NotwmBS0geJbyZF8H0eeGlejXsp2cTA8fyiz/6BNpDKhxJF9cAw==
X-Received: by 2002:a05:6e02:13c1:b0:349:983c:4939 with SMTP id
 v1-20020a056e0213c100b00349983c4939mr13368457ilj.16.1692052884876; 
 Mon, 14 Aug 2023 15:41:24 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 u3-20020a056e02080300b0034886587bdcsm3485091ilm.18.2023.08.14.15.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 15:41:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 11/19] doc: Expand documentation for the cedit command
Date: Mon, 14 Aug 2023 16:40:31 -0600
Message-ID: <20230814224047.535491-12-sjg@chromium.org>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
In-Reply-To: <20230814224047.535491-1-sjg@chromium.org>
References: <20230814224047.535491-1-sjg@chromium.org>
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

Add a little information about each subcommand.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/usage/cmd/cedit.rst | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/doc/usage/cmd/cedit.rst b/doc/usage/cmd/cedit.rst
index 3d815bd27af2..d34a220797ee 100644
--- a/doc/usage/cmd/cedit.rst
+++ b/doc/usage/cmd/cedit.rst
@@ -24,6 +24,21 @@ The description is in the form of a devicetree file, as documented at
 
 See :doc:`../../develop/cedit` for information about the configuration editor.
 
+cedit load
+~~~~~~~~~~
+
+Loads a configuration-editor description from a file. It creates a new cedit
+structure ready for use. Initially no settings are read, so default values are
+used for each object.
+
+cedit run
+~~~~~~~~~
+
+Runs the default configuration-editor event loop. This is very simple, just
+accepting character input and moving through the objects under user control.
+The implementation is at `cedit_run()`.
+
+
 Example
 -------
 
-- 
2.41.0.694.ge786442a9b-goog

