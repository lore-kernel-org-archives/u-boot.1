Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D9BEE49A4
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 00:13:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46FBD86C85;
	Mon, 11 Sep 2023 02:13:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UoZTDWX2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFE3F86C8C; Mon, 11 Sep 2023 02:13:52 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B121286C5E
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 02:13:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-7950fac19f2so149627539f.3
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 17:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694391228; x=1694996028; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8eNwy7w4gnL6nRkGwafJ/eE7f9NSqfxMqGdrT1wW77Q=;
 b=UoZTDWX2R2ONWDVBt47Z5NESWmoPLxHU637sxbWYowekzrVlvMgjYnTm46D67qdG3I
 SOf6Mt6upUjXn2YR9naua3gKIMFe5myRfFOsgXuuuh6XdCODzvGAs7+AsKN9B/VUZaMr
 y5TRUylLIpaYN8kO+RYaPdTd+xEuKi7/Duf6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694391228; x=1694996028;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8eNwy7w4gnL6nRkGwafJ/eE7f9NSqfxMqGdrT1wW77Q=;
 b=iC+iElQN8bgXxn1JrHNmC0DiPd2/iwDNFpVGmQej7Tb4OdFh54AXU5O/ltf/q9EQ3t
 aNJfOrx4FviFmjF5QUQHG5kFaY+woXrg2QvS5Y0+K3MnxXmRG8UqNPhe5LdccLTC14ZD
 1Ijd2Cn8ClboH+3dvU3ChBEFS3IJMqAD7ppuk+VfoT2LXQeMNrftxwNADH7EaVNqPZpt
 xEK8uQwNvpnL2/WvdDb0GyAcKOXrrEdhRYpJHpFRxNntkLKUidLr2pLy+Yj8eHNXzI3n
 ajXWqAGIgaqW/gv25fRShHJbYbPCSPPUJOVRiggBS22PdDXAX8t4qgPK3LFMObgqo6va
 V1rg==
X-Gm-Message-State: AOJu0Yyjzv7AFhr9Jbo4yBHKNn951HGbOAJlXC/bR+CbiPC6T7RL0Xau
 mGt6OEq4hHwPJ5pcDQ42nS7YCwAG5ZP5TvmMyls=
X-Google-Smtp-Source: AGHT+IHBT5V+xwloSVAOBviWteLwjvRPYisvUTX1jVrZ3036LL8oiaJp0kbUsUG55z5mDgbjRD5rBA==
X-Received: by 2002:a05:6602:1b0d:b0:795:8805:1383 with SMTP id
 dk13-20020a0566021b0d00b0079588051383mr9600185iob.5.1694391228267; 
 Sun, 10 Sep 2023 17:13:48 -0700 (PDT)
Received: from sjg1.lan (c-73-243-118-188.hsd1.co.comcast.net.
 [73.243.118.188]) by smtp.gmail.com with ESMTPSA id
 d18-20020a6b6e12000000b0078714764ca0sm1968522ioh.40.2023.09.10.17.13.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 17:13:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH] buildman: Disable CONFIG_CMD_CONFIG for reproduceable build
Date: Sun, 10 Sep 2023 18:13:35 -0600
Message-ID: <20230911001337.374147-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
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

When the ordering of CONFIG options changes, the gzipped CONFIG list can
change in size and contents. This makes it hard to compare commits which
only different in CONFIG ordering.

Disable this when -r is given, to make this easier. Update the
documentation as well.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/buildman/buildman.rst | 3 ++-
 tools/buildman/control.py   | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
index aae2477b5c3d..4cca97dbda8c 100644
--- a/tools/buildman/buildman.rst
+++ b/tools/buildman/buildman.rst
@@ -1021,7 +1021,8 @@ various files to be rebuilt even if no source changes are made, which in turn
 requires that the final U-Boot binary be re-linked. This unnecessary work can
 be avoided by turning off the timestamp feature. This can be achieved using
 the `-r` flag, which enables reproducible builds by setting
-`SOURCE_DATE_EPOCH=0` when building.
+`SOURCE_DATE_EPOCH=0` when building, as well as disabling `LOCALVERSION_AUTO`
+and `CONFIG_CMD_CONFIG`.
 
 Combining all of these options together yields the command-line shown below.
 This will provide the quickest possible feedback regarding the current content
diff --git a/tools/buildman/control.py b/tools/buildman/control.py
index f2ffb7f5b4aa..0ce4f2e2f3b5 100644
--- a/tools/buildman/control.py
+++ b/tools/buildman/control.py
@@ -575,6 +575,10 @@ def calc_adjust_cfg(adjust_cfg, reproducible_builds):
             print('Not dropping LOCALVERSION_AUTO for reproducible build')
         else:
             adjust_cfg['LOCALVERSION_AUTO'] = '~'
+        if 'CMD_CONFIG' in adjust_cfg:
+            print('Not dropping CMD_CONFIG for reproducible build')
+        else:
+            adjust_cfg['CMD_CONFIG'] = '~'
     return adjust_cfg
 
 
-- 
2.42.0.283.g2d96d420d3-goog

