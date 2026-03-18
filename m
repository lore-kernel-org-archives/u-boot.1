Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC843103E173
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 13:24:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B9E484221;
	Wed, 18 Mar 2026 14:24:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PZzTfaWh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 745FA8419E; Wed, 18 Mar 2026 14:24:43 +0100 (CET)
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1108A8419E
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 14:24:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x344.google.com with SMTP id
 46e09a7af769-7d7851e2cc4so597856a34.3
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 06:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773840279; x=1774445079; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lW3sMLa26U/692vMW5x57XWDXjmLDZFDPl2fsphLdj4=;
 b=PZzTfaWhE+Dxowyk3BGBds68oP6T2/Npr2e6qMim3LffPy2ePQIcOiF4jM01+bnrCF
 LZdmUtPu5dN9CgNmfkLfCiK0yKZ6qoNXrZIOO5jDnHJ99t0zLSlBNY2j0EOwl/tO+0O8
 kMihH4Ba7pe3r0bWDjh1fc+sk1KXhBT+QsBGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773840279; x=1774445079;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lW3sMLa26U/692vMW5x57XWDXjmLDZFDPl2fsphLdj4=;
 b=qp72R9fzLoTEu05oGuYGAiukrGkdkDmfny6HFx8SmpHnCuX9ewwenY1bVcXUSVay2q
 PFN06A5dXaHDyW7nXVr42thCKPx4rCVJ2jSZ2eL5eoiJJXpCXiS9dteA8iWcsCZ1lUqp
 D95QuG59fnG3j/Uc7DyZAxMLjJBAKEb86l6mQ5vsyxkGYd4kHbtdbhwrCad5z3rlDqFA
 dPvXyhyIpWskVHZQ0JWLfwSN3kinydKaFYRf/UqVyRmTHWTkWBNUOOJoX+FA0thUm8k1
 JszZ6aR7w8MUJNriTuDfxM/qgs+Gc8P6bKup8aAOZepJt44uF6U+c+Huu9Y/KQwz3TqD
 arwA==
X-Gm-Message-State: AOJu0Yw3pZ2nmSMRKAJR6poFd4Tdbm5K9JbR81cp6AVRH8Bm2Q+1pj4S
 hNbDqW6YMbo0DFb+jFJ/Mf6WfHHxOU6TYM7EjACHr2ZiOSuNLgNPOHKEgf9rjLsuAr0nmuvpoQt
 STjPxoHg9
X-Gm-Gg: ATEYQzxRMmI8Y96te5aGmqdze1Aa2MuOTqnzTJJ77eRjtSkzEXM8edaRR9hhrKG9MfL
 llvWTjCw/3lsYaHq+0u7zZRmMbr3b243SbLzr9/oNt15ICTZ/0UfP3MGuseh3Wg5RtvHl/I5K/m
 Z56ZDSbZUxWdVgROg8xKIfTZjmtuLcQFp+zeD25eAJ2/zN3IhwyXxqUM6kXGsCnfLQHTh898Gfn
 WTxAoeJcwg8oMQcvM0Y7z4Nvr+eqVRalkw0Lwp9jxADD2l9CFnqPp1rZ4OFuc3TjyCX5zs91YM+
 AX6jmAgQcJXhwnLQ1zdiyNL7hESGBxcqdYtXQnjlP9Q4eRqQod7HlO/M5A1P/TjL02wXVsA6uEX
 Cd67AEI9ux0SvNyJtQ4zmGAnYqWODL932XBKszVDgB0XWiPASgS1YLpIDDsAzuvvhBmV3GD2muF
 AOYEsru5/nlmlu3IJjRFU1+n6rFEee
X-Received: by 2002:a05:6830:6d12:b0:7d7:c763:c903 with SMTP id
 46e09a7af769-7d7ca75b2ddmr1876211a34.25.1773840279080; 
 Wed, 18 Mar 2026 06:24:39 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7c9b38fbbsm2038492a34.13.2026.03.18.06.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 06:24:38 -0700 (PDT)
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
Date: Wed, 18 Mar 2026 07:23:55 -0600
Message-ID: <20260318132400.1856600-1-sjg@chromium.org>
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
