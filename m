Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B53EBD10C11
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 12:49:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31917890CE;
	Mon, 28 Oct 2024 13:48:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nNTXi1Vt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17CBA89160; Mon, 28 Oct 2024 13:48:35 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6A918912C
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 13:48:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5cb6ca2a776so5723711a12.0
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 05:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730119712; x=1730724512; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Mu9KL92/J8HC4URmKG9wBkcOfrMzpYD196l34evT+M=;
 b=nNTXi1VtuRfvtsMdjCkP6gX9UFjU/4Qg4JX0ecPsrwF7R7Z1JU9+LKUG1wC3Y8AFg2
 K5oMA+7SDmp44zyimoJKWg8q8Uq8Y4Zk23Wy3f++h/rcBnsCNN+qdInPpEuZ97FU8ygP
 nEM+8rOi7yTkvtGYWW+RjfNYGwIWkAq6q5FkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730119712; x=1730724512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Mu9KL92/J8HC4URmKG9wBkcOfrMzpYD196l34evT+M=;
 b=l6Ee1Zn0vo3/ncaq8fMKpZ6sWml2Zb6tmK48vgluKto9EXxu2i/EG2rf4+j2joto1P
 S7yDM5kOPRMaXyHhT2bixj+Whm6T9za7ZrnYkRIo1sOi24bdNYecqpQpaqtMKw9jqyWQ
 g/smEl0sA6pIpqiIkuK3xTc70HwIhk6ehT8lhioPWB+oh9Uw5F8OY3+LA7pBNYg9Pn9u
 D6i2Tj8oXY7YnLxnoOFpc/a84MyCnpi3TztXz1z3+ilUzVAwzic+aLOSibkV2XBUmiS/
 NqWQhuekzgEzXh5GsufPpkA0pLusd1wmT2VHkoERXtJ9ADXCBz6JlwMb57kQ+b9R7a+V
 AdhA==
X-Gm-Message-State: AOJu0Yy86OKGwvs4gdtrwc8O6hi5ObMGVUCPPrifLjFAP8EDkCtrY/XN
 skpmPYns7z+vFyh++eZyQ9wr+27RdpVa4It6eZ+lUjNrF79d60u9GNFHJqYIe10cD3Mwz9UOhXz
 yjQ==
X-Google-Smtp-Source: AGHT+IFhfv77XLK9gTG5dn6X//knMUYWqz6Il8ErXk6O4j1dRw8MpiwUjKlI5OElNALZt4E06eSaQg==
X-Received: by 2002:a17:906:6a1d:b0:a9a:1b32:5aa8 with SMTP id
 a640c23a62f3a-a9de5c9a710mr708055866b.4.1730119711688; 
 Mon, 28 Oct 2024 05:48:31 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b30d6fdc5sm375593366b.163.2024.10.28.05.48.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 05:48:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCH 05/15] doc: sandbox: Add docs for the sb command
Date: Mon, 28 Oct 2024 13:47:56 +0100
Message-ID: <20241028124815.47262-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028124815.47262-1-sjg@chromium.org>
References: <20241028124815.47262-1-sjg@chromium.org>
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

This command has a few small features, so document it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/usage/cmd/sb.rst | 54 ++++++++++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst  |  1 +
 2 files changed, 55 insertions(+)
 create mode 100644 doc/usage/cmd/sb.rst

diff --git a/doc/usage/cmd/sb.rst b/doc/usage/cmd/sb.rst
new file mode 100644
index 00000000000..6f54f9d9eb7
--- /dev/null
+++ b/doc/usage/cmd/sb.rst
@@ -0,0 +1,54 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+.. index::
+   single: sbi (command)
+
+sbi command
+===========
+
+Synopsis
+--------
+
+::
+
+    sb handoff
+    sb state
+
+Description
+-----------
+
+The *sb* command is used to display information about sandbox's internal
+operation. See :doc:`/arch/sandbox/index` for more information.
+
+sb handoff
+~~~~~~~~~~
+
+This shows information about any handoff information received from SPL. If
+U-Boot is started from an SPL build, it shows a valid magic number.
+
+sb state
+~~~~~~~~
+
+This shows basic information about the sandbox state, currently just the
+command-line with which sandbox was started.
+
+Example
+-------
+
+This shows checking for the presence of SPL-handoff information. For this to
+work, ``u-boot-spl`` must be run, with build that enables ``CONFIG_SPL``, such
+as ``sandbox_spl``::
+
+    => sb handoff
+    SPL handoff magic 14f93c7b
+
+This shows output from the *sb state* subcommand::
+
+    => sb state
+    Arguments:
+    /tmp/b/sandbox/u-boot -D
+
+Configuration
+-------------
+
+The *sb handoff* command is only supported if CONFIG_HANDOFF is enabled.
diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index db71711c393..24b2d2637b1 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -103,6 +103,7 @@ Shell commands
    cmd/reset
    cmd/rng
    cmd/saves
+   cmd/sb
    cmd/sbi
    cmd/scmi
    cmd/scp03
-- 
2.43.0

