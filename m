Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A669AC19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 14:27:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19C6D81280;
	Wed,  5 Mar 2025 15:27:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Q1/lA3Y+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C6BF811C1; Wed,  5 Mar 2025 15:27:16 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35D6B808B6
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 15:27:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-390fdaf2897so3991626f8f.0
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 06:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741184833; x=1741789633; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uTZuNaTK+mvgzVaEWxdEblzN7YSYIb+54sho3OLonmI=;
 b=Q1/lA3Y+ASANgIq7naLlJ0rnNwUmsWVvuqkPL3210EZ+g4hgc5lUznnH5CshXu6HZl
 x4awlz1RFa5IvgsT1vHYA6rOx24BdRlm039gtxBpv0hDMtP9hcweTCBZfXE41NkgLYTg
 GYHrQ/ywdKN96dyU5Ah+uaj2cQrtmhk6DqnPJGBDbJk6hekTIi/a/56AeXNnhAkSUfWD
 Mr/CfViuX2jxfJiJ2wQnOqC1DQtW/g/oT9RxpJjqO0RTHD0r8svwT6A0qWw1OhK3Pxc9
 QQU5tlt91nN+1x1D4sLwVosM/pveoGGV2L47oEdsH3iuJa43nZYO3tpsK0mmmuA1z/Hn
 qSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741184833; x=1741789633;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uTZuNaTK+mvgzVaEWxdEblzN7YSYIb+54sho3OLonmI=;
 b=rCvAuZSG9UpkQNUs+2qACfyYaCSUW14OBbPSfYESXIt+0n+tmeV/nvclDx/34YxZH8
 8U9DwiEP+S2MC7Vqp6HE/WUcUQ8DFPlMNXlgRZrrzP/GjEtaUz0GXlQFeFmhohXeGGGj
 bYrEsIHB3ZE/ghq3QTM2cc4CZlnoitudjSc19bIwZMmNJkYLhOCXaBJ1j+YhaO7v2fUU
 RAEh9EMda2uRpKGA+cydyy8c0lkvGb38RMIWJrcVow5stdMemTgcwO+ys3ldn5QdUR79
 RbOXvjDA5Ru7bIFmURHsqeb/v26WPcUDkiWc6ImmQJBMYQDi+twi93Yh0M49epg3p/7G
 0kNw==
X-Gm-Message-State: AOJu0Yw8yN45UdSED9yNKOH1DG8dvDw4H8PsAIhhA2yjnVvTofSYqvg2
 WhVoBKtH5C2nzpr2FO1kKz4souv8NEUeZ/ySVr/e44gFA4pvGCvEFwyKUDAk1dKplk9EFK7zqoZ
 U
X-Gm-Gg: ASbGncurD9VggEMPcIPxtCXvkeRLThwJn8iC5zVkRNRih0L4E8h5V0c6M+/pbN9rThb
 uco8CXz8y+tpO5pT8inOXFm+aB9Z8Lvi/GNZe06iEcOlP6efv1r1sGUYFOgMgEcuCGxBqCgxPn0
 It8F7p7Sc5w9PVQYmutxG+E5Sqi1fLYiEXYgXbReab0r2VVWd0ISbZGp1ZpNIE5r14h5kgOqe8Z
 4Sf0LlaN+fxuG+BfY/eHs4cswdx2Gtgpyt+gqewjU0sYe77W7WSCwsYs+/pbHQyjhPhBrX/xfXS
 c8AWmUOgOgQPtlvtwk/GkZkcQX9HX/kn7x6Gv4TXYSRHz6DUOiGH4w==
X-Google-Smtp-Source: AGHT+IHDufQ2azqn94c0jgJE1ZJm4c/vs3LmNq+fnzs970L8gwSCT+V4wnKDvnvhJ3wbIl/IUXVKVw==
X-Received: by 2002:a5d:6d8f:0:b0:390:fbcf:56d5 with SMTP id
 ffacd0b85a97d-3911f58f3a1mr3394838f8f.0.1741184833454; 
 Wed, 05 Mar 2025 06:27:13 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:369c:9bd8:7c87:9a39])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-391188029e0sm5442456f8f.52.2025.03.05.06.27.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 06:27:13 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH v2 0/6] net: lwip: root certificates
Date: Wed,  5 Mar 2025 15:26:41 +0100
Message-ID: <20250305142650.2966738-1-jerome.forissier@linaro.org>
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

This series adds support for HTTP server authentication using root (CA)
certificates.

As a first step, the wget command is extended to support a sub-command:
cacert <addr> <size>. The memory region shall contain the CA
certificates. With this, it is possible to load the certificates from
storage or get them from the network for example, which is convenient
for testing at least. The Kconfig symbol for this feature is
WGET_CACERT=y.

Then new Kconfig symbols are added to support providing the certificates
at build time as a DER encoded X509 collection: WGET_BUILTIN_CACERT=y
and WGET_BUILTIN_CACERT_PATH=<some path>.

An example of how to use this feature is given in patch "doc: cmd: wget:
document cacert subcommand".

Changes in v2:
- Drop PEM support. It is unnecessary since conversion from PEM to DER
is easy, and PEM takes more space in memory. Another reason is the ugly
hack requiring to allocate one more byte for the null terminator in
case the file is PEM (therefore, text).
- Add 'wget cacert none|optional|required'
- Replace '#if defined CONFIG_X' with '#if CONFIG_IS_ENABLED(X)' in
net/lwip/wget.c Do NOT replace '#if defined(CONFIG_X)' in net/net-lwip.c
for consistency with how other symbols are treated in that file.
- Make builtin_cacert const
- Make cacert_size static
- BUILTIN_CACERT selects BUILD_BIN2C
- Add documentation in doc/cmd/wget.rst
- Apply review tags

Jerome Forissier (6):
  net: lwip: extend wget to support CA (root) certificates
  lwip: tls: enforce checking of server certificates based on CA
    availability
  lwip: tls: warn when no CA exists amd log certificate validation
    errors
  net: lwip: add support for built-in root certificates
  doc: cmd: wget: document cacert subcommand
  configs: qemu_arm64_lwip_defconfig: enable WGET_CACERT

 cmd/Kconfig                                   |  22 +++
 cmd/net-lwip.c                                |  21 ++-
 configs/qemu_arm64_lwip_defconfig             |   1 +
 doc/usage/cmd/wget.rst                        |  82 +++++++++-
 .../src/apps/altcp_tls/altcp_tls_mbedtls.c    |   9 +-
 .../lwip/apps/altcp_tls_mbedtls_opts.h        |   6 -
 net/lwip/Makefile                             |   6 +
 net/lwip/wget.c                               | 141 +++++++++++++++++-
 8 files changed, 273 insertions(+), 15 deletions(-)

-- 
2.43.0

