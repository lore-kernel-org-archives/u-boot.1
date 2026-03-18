Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4167A103E173
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 13:23:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A84378419E;
	Wed, 18 Mar 2026 14:23:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N2uUF4oQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABA5F841F7; Wed, 18 Mar 2026 14:23:03 +0100 (CET)
Received: from mail-oa1-x41.google.com (mail-oa1-x41.google.com
 [IPv6:2001:4860:4864:20::41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADBF783F8A
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 14:23:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x41.google.com with SMTP id
 586e51a60fabf-41576c5c01cso4272395fac.3
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 06:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773840178; x=1774444978; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lW3sMLa26U/692vMW5x57XWDXjmLDZFDPl2fsphLdj4=;
 b=N2uUF4oQqgk566PuvquC8t/JlC9XWRhNDwoZvf2o0ZOTnpjaXKlj4May+rwWpG1n+z
 uWsfX3Wjknwd8yTudEFttSyi0iU3w6RPAFYReFW0NhbscTBlWml3eNVpDopSOECIMSkx
 aexhqJb7nQV7KCPyvVH2BMoQlTrZQ/pAr2l+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773840178; x=1774444978;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lW3sMLa26U/692vMW5x57XWDXjmLDZFDPl2fsphLdj4=;
 b=Go3Pq91AHGvelt6ryrPbMR2cGZvS40ciHInM0m6X3sMtn94e1xu5/5rOkxL6auhDbX
 ZUdfOp1h1G8jA3EHRy4dulh2KPoh7GA62ZUeE+qP32uyLwO4yviMZCpSmnd3Ci6L+1nE
 zisIolDIaqGkC0PNqvD9J/JdN8enKqm8SDpIzMmmqwF8vgFppLN7FD1GlaILC4HGg0B9
 fbEkvuVBPFXkV1QpEICg5Gwy3NodwVv07yd6ecJbdkhiLyHTsyvPcvyylnCAizkUGB2m
 h9qQPCmYYL4TIJmEa5FswNIgt9u3Xn2RluhPhq9A2R9fIj3IiOKA2UFjfipYkHn5472e
 dNhQ==
X-Gm-Message-State: AOJu0YyArm1bjVnzNblKX7RptS/f4uwHf6ldfd4USpeKpMFflr8O1k2i
 ki/NUTD/Gxofe6OUnEDaSzRaWk1/CVHU8ibfiKeC4jhO3G4nfkyQKo1AnGeDmGS4j8QNOTBe9Kl
 UeFnQlX2K
X-Gm-Gg: ATEYQzy3B3aY/ky9dr1L8SVT+1zXCX34o5WzSEQMp3izRZJViDFEF16a3SJzlQnXPa0
 EgWRAaY7D+/CrXPxTcBVdxNAxxtOrOfwm/iuPezbCyXWVMlva+106k/DQl1l8oTUy0svRLSLOqX
 AO5nUKxHCj/yKlX/GcFzc2rkxW/OD0fov3EDzwtyCNcFkv8QZa4OT3Cx8219Sc8yErnbjFb89Wr
 A14GeBZ4VKkEvw+Q/+rKeaVUdiTttFoI1MvI4Z9dG0Eq1zk2twGe5+/i9AGYIRGF3WOHd+Q+sO6
 G2uxdE+Mp5kfagglJrNiDgtVw+9kvXyQd4kCfzwBMAFq+2kSONGRWeVNmLy/XiyXx9vzZZfTvhL
 OiHU36OXXPf0uuj6A2k6Uhb8lY7KeJFjZ4LTb0OF6LBbpRfMfob9dJYrNboAR2KT546Ym1uBOwc
 7UOTxeqD6lKg0gJvyPdg==
X-Received: by 2002:a05:6870:fb92:b0:409:5c31:b6be with SMTP id
 586e51a60fabf-41bd3f53d8fmr2008972fac.19.1773840178165; 
 Wed, 18 Mar 2026 06:22:58 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41bd2c30b0fsm2565004fac.10.2026.03.18.06.22.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 06:22:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Alice Guo <alice.guo@nxp.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Yannic Moog <y.moog@phytec.de>
Subject: [PATCH 0/2] Auto-generate binman entry and bintool documentation
Date: Wed, 18 Mar 2026 07:22:40 -0600
Message-ID: <20260318132246.1855445-1-sjg@chromium.org>
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

The entries.rst and bintools.rst files are currently generated manually
by running 'binman entry-docs' and 'binman bintool-docs', then committed
to the repo. This means the docs drift out of date when docstrings are
updated but the RST files are not regenerated.

This series provides a Sphinx extension to generate the file. This
approach keeps the docs in sync with the source. It also avoids
importing binman modules so as to remain compatible with readthedocs.io


Simon Glass (2):
  binman: Add Sphinx extension to auto-generate entry and bintool docs
  binman: Remove pre-generated entries.rst and bintools.rst

 doc/.gitignore                   |    2 +
 doc/conf.py                      |    3 +-
 doc/develop/package/bintools.rst |    1 -
 doc/develop/package/entries.rst  |    1 -
 doc/sphinx/binman_docs.py        |  207 ++
 tools/binman/binman.rst          |   12 +-
 tools/binman/bintools.rst        |  249 ---
 tools/binman/entries.rst         | 3129 ------------------------------
 8 files changed, 215 insertions(+), 3389 deletions(-)
 delete mode 120000 doc/develop/package/bintools.rst
 delete mode 120000 doc/develop/package/entries.rst
 create mode 100644 doc/sphinx/binman_docs.py
 delete mode 100644 tools/binman/bintools.rst
 delete mode 100644 tools/binman/entries.rst

-- 
2.43.0

base-commit: eefb822fb574e28d49fc9f358328854e17fc8406
branch: binman-sphinx-us
