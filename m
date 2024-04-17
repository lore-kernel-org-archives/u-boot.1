Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68409C04FFE
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 08:06:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80C0A88461;
	Wed, 17 Apr 2024 10:06:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="nAKle/BD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E80198844B; Wed, 17 Apr 2024 10:06:33 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EABA8844F
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 10:06:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A4D9F3F8D9
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 08:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1713341184;
 bh=Ew7KFfhecesBiOSAseZmIDdzYiZGL5pxjoqPt6UjNXE=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=nAKle/BDrG/f8J7wOurP7XmYcHxhjeHKJad/G+OxTam7ecjjNu5thvFY4CKjOtOC+
 HeXOT68f2I9IQkNUZdZGihfZ6vcbsqpkob+TXxOOC/DL2Qf3yL6BYh0q2iQEbozzvt
 VmdTrk7k2f8Xox40BV9qJAkFlEgOPSjVXWtADAkDFttNDy42UHV1/1t9B7wJ4Pmr5Q
 EFT2M3FpqY//YcapMxQQL5aqaUs8xiYqwjzln2M230z54P1SmLkjvg3FCV1TkUFhZ+
 hh5GaLiKQz5gpbN94F2Ov/Q9t2TdGcxWEHZgp8p3QqXqliZmsSeSXBIablikMkiysD
 LKiBHSQ2Ve/UQ==
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2dad70b6e03so12744231fa.1
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 01:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713341184; x=1713945984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ew7KFfhecesBiOSAseZmIDdzYiZGL5pxjoqPt6UjNXE=;
 b=BAGo7R3iZvSZ00jMNm0ewMgV1N7EyBsPR08Yfly9Bgcb92mJj7/92iMLlTKQWF0ESQ
 qqr2sn76RFG/rc9igX65LsYoe94BhQEkDXDFrdHt5MRFeiH+7ZZZnN3LiXxrxxxEHoEH
 f4bFxGS2hXLnIGKBk/WwSAjBRAX9gg4rwkfErMXHHWz5tvgyv38Aq3E62NW7xwBnby5S
 E2fWTvVMsdY4kC5jtMJAgvTfMkfXo5mwqMybFh6TunY6iVlS/6no3SgVkBUpmlIaILS6
 tbCdMSZQkEVDjrsOMjhxL40LvzoAyYiZHtyKsxKinb7nkjt3UqHwdSLRwTh4PYo8FNCl
 7u5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhL1vIx5GvFjoCXDm0PUJV6BC6wHLytWO/o8i0Pi+W8XevxFJnJrfeXkDQqfxdCM40LUhwhLyO4qcO3Wi9s9wWJQ8ZJQ==
X-Gm-Message-State: AOJu0YxWucquZGEoWk3pT5MKloRW19iDqlQGMzMmRqeZI/qvP7JwGaEC
 OD9AMiK0rQIWo5O1ijJsufzWUs7eIKKbxqxzv2KhVb+lsJ5s1XtH54vRyT8wGyf9WGUPKhNHC86
 2RsrlZ6oWCPBhbqQKanS9VFXd++UyX8yQjXh5iFkI+XklCTczt8D50tSiE+rhVeExR4M=
X-Received: by 2002:a2e:681a:0:b0:2d8:57a4:968d with SMTP id
 c26-20020a2e681a000000b002d857a4968dmr11037242lja.12.1713341183682; 
 Wed, 17 Apr 2024 01:06:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUA3KD9zDJjQGm8gn0Rx2VT+FcG0aAPpASFacqSNjpt1Ai8iarcRaPhyVHHsTuvXzuwTi/Kg==
X-Received: by 2002:a2e:681a:0:b0:2d8:57a4:968d with SMTP id
 c26-20020a2e681a000000b002d857a4968dmr11037206lja.12.1713341183245; 
 Wed, 17 Apr 2024 01:06:23 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 c8-20020a05600c0a4800b004182a36b185sm1759098wmq.2.2024.04.17.01.06.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Apr 2024 01:06:22 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/2] doc: sort env sub-commands alphabetically
Date: Wed, 17 Apr 2024 10:06:12 +0200
Message-ID: <20240417080613.24718-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240417080613.24718-1-heinrich.schuchardt@canonical.com>
References: <20240417080613.24718-1-heinrich.schuchardt@canonical.com>
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

The 'env' man-page is currently only partially sorted.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/usage/cmd/env.rst | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/doc/usage/cmd/env.rst b/doc/usage/cmd/env.rst
index a7e21693a67..60a294328e8 100644
--- a/doc/usage/cmd/env.rst
+++ b/doc/usage/cmd/env.rst
@@ -16,18 +16,18 @@ Synopsis
 	env default [-f] (-a | var [...])
 	env delete [-f] var [...]
 	env edit name
+	env erase
 	env exists name
 	env export [-t | -b | -c] [-s size] addr [var ...]
 	env flags
 	env grep [-e] [-n | -v | -b] string [...]
 	env import [-d] [-t [-r] | -b | -c] addr [size] [var ...]
 	env info [-d] [-p] [-q]
+	env load
 	env print [-a | name ...]
 	env print -e [-guid guid] [-n] [name ...]
 	env run var [...]
 	env save
-	env erase
-	env load
 	env select [target]
 	env set [-f] name [value]
 	env set -e [-nv][-bs][-rt][-at][-a][-i addr:size][-v] name [value]
@@ -40,11 +40,11 @@ the UEFI variables.
 
 The next commands are kept as alias and for compatibility:
 
++ *askenv* = *env ask*
 + *editenv* = *env edit*
 + *grepenv* = *env grep*
-+ *setenv* = *env set*
-+ *askenv* = *env ask*
 + *run* = *env run*
++ *setenv* = *env set*
 
 Ask
 ~~~
@@ -103,6 +103,11 @@ The *env edit* command edits an environment variable.
     name
         name of the variable.
 
+Erase
+~~~~~
+
+The *env erase* command erases the U-Boot environment.
+
 Exists
 ~~~~~~
 
@@ -204,6 +209,11 @@ environment information.
         quiet output,  use only for command result, by example with
         'test' command.
 
+Load
+~~~~
+
+The *env load* command loads the U-Boot environment from persistent storage.
+
 Print
 ~~~~~
 
@@ -235,16 +245,6 @@ Save
 
 The *env save* command saves the U-Boot environment in persistent storage.
 
-Erase
-~~~~~
-
-The *env erase* command erases the U-Boot environment.
-
-Load
-~~~~
-
-The *env load* command loads the U-Boot environment from persistent storage.
-
 Select
 ~~~~~~
 
@@ -350,15 +350,15 @@ edit
 exists
     CONFIG_CMD_ENV_EXISTS
 
-flags
-    CONFIG_CMD_ENV_FLAGS
-
 erase
     CONFIG_CMD_ERASEENV
 
 export
     CONFIG_CMD_EXPORTENV
 
+flags
+    CONFIG_CMD_ENV_FLAGS
+
 grep
     CONFIG_CMD_GREPENV, CONFIG_REGEX for '-e' option
 
-- 
2.43.0

