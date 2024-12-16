Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C70EEE7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 18:07:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1BCF801BF;
	Mon, 16 Dec 2024 19:07:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hDOru2gt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E13EF80104; Mon, 16 Dec 2024 19:07:54 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9E47800D2
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 19:07:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso31908785e9.2
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 10:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734372472; x=1734977272; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ove7bZW/WZrAXCVjkM+eSwvXos23SRXJ8Rhchqsz7UA=;
 b=hDOru2gtedZhBgFUqGVtVDVIRuV1Wv46L9qtV27DCeNpBSLJNaGUzkX+6adK/PJqeC
 mtkgUfFqLc9Ju3PcUCU/yCQp5k2/V5nCjR5/+mqhGCI1BXqEa6RfIPZD5vmdOstafhxd
 Gn9ZhLMGxVQOYuHh6FmVTuF0AyZBZG5jDS2BuXCWLAOeJyCFwnKjXQ12kdG7Apffdk60
 sG1ubMMn8dbMmMfJmyErhs5ZI/+pwr6gF2LO4Tdk8WLKoYXPd73FmEoT9aHpw8WH/hEB
 2T0lzoW9mvqAWMYwpgmazzxXujKpQFM2o4izUzVG5+v2ejVl2ufx5IsSMrzFONUpbDdY
 9cRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734372472; x=1734977272;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ove7bZW/WZrAXCVjkM+eSwvXos23SRXJ8Rhchqsz7UA=;
 b=o7L83I3AfN8Q6PJTwx2LMWGeG6a70NDx0U4eQr8ZZkFOkYhQLoGhBqr1tyTwLRqahm
 JqxJx/LdZY3L6ycdlFski6wbuLRWsjOi3jA6DnWrGyOG0ZZvokyoRYl0NqkvH0nXqrCe
 tDdMnLLUR8MwgKMT62bwb1XPq30PtgmLAvApmrsMxjn9dlQTjypxf5Z4GvUvFwXp2Bjh
 ukQ6GVyh0xB+t36sRznu51mGYXW/ckVqKcfc2B80CnzuxDD3A77rlOBDv8V08rykzdGU
 eJYbqfne1EY5exNHc7URXiVtvrbtd97f8SAeSUdUJrTF6vzB3qkD61d/oy/Li5YqWr+r
 XWuQ==
X-Gm-Message-State: AOJu0YwQdqhcGXFIDsuTX5dyE9uyRuxGVVUEYZbtHsR12x4FzIeWVaei
 KAex7cLroEpGkCZKnssWla2oLkiic55RkYaNi0wyO8kNXWVCA/z8WEWjOYqDHjxOzxk89z0y21e
 XAQo=
X-Gm-Gg: ASbGncs6zgokg2VkNg8DJwnN8JAihTQbJkC6keoZWst4ypqPQNn74vDIG180bOgI1/u
 MtI39+jYcJqMsk5vx4TjLTdOstE+bjuwQ0wRSMKVmkGEIGNH1EBSijFQZs4XXaL2wM/L45UUhjB
 pncJYA3x3ulRSiHrCAQ7HxKb2ufje5sGhk4p54QyvYqzo0NvkRcYH3w1D4pXMWIdqeiohKFEjWw
 lRi5TmFBLtcn7XEKqyEmsbj+8O5lGPSkGfZrxSxzCrXD37X5ig6G9wKlenM8u3HiyD8mwcl6k7l
X-Google-Smtp-Source: AGHT+IFaxvPej8IWs0DaeMJ+knxzjrGdJGSViBw9JC+WIr6k7petEhe3s82pa21ICwYPGZMC7C5TOQ==
X-Received: by 2002:a05:6000:1a88:b0:385:e0ea:d4e7 with SMTP id
 ffacd0b85a97d-388da5b5d92mr445387f8f.55.1734372472124; 
 Mon, 16 Dec 2024 10:07:52 -0800 (PST)
Received: from artemis2.broadband ([2a0a:ef40:ee3:c001:477a:6a2a:86f6:a454])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436360154absm91501605e9.2.2024.12.16.10.07.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 10:07:51 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
To: u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Ben Dooks <ben.dooks@codethink.co.uk>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Kongyang Liu <seashell11234455@gmail.com>, Leo <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Raymond Mao <raymond.mao@linaro.org>, Rick Chen <rick@andestech.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH v5 0/4] Select CONFIG_64BIT for sandbox64 and x86_64
Date: Mon, 16 Dec 2024 18:07:32 +0000
Message-Id: <20241216180736.1933807-1-andrew.goodbody@linaro.org>
X-Mailer: git-send-email 2.39.5
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

Picking up a series from Dan Carpenter and applying requested
changes for v2.

I had previously set CONFIG_64BIT for arm64.  This patchset does the
same thing for sandbox and x86_64.  (Mips and riscv were already
doing it).  This CONFIG option is used in the Makefile to determine
if it's a 32 or 64 bit system for the CHECKER.

Makefile
  1052  # the checker needs the correct machine size
  1053  CHECKFLAGS += $(if $(CONFIG_64BIT),-m64,-m32)

Changes in v5:
 - Previous version mistakenly simplified the change to
   bloblist.c, so reinstate the full change in order to
   fix those platforms that broke.

Changes in v4:
 - Add help text to describe new symbol CONFIG_SPL_64BIT
 - Split the statement in bloblist.c to be more readable

Changes in v3:
Added a new patch 1/4 to make fixes to the source needed
by the sandbox patch 2/4.
Updated 3/4 to account for x86 being built with a 64 bit
U-Boot proper but a 32 bit SPL.
Added another patch 4/4 to fix an incorrect use of
CONFIG_PHYS_64BIT which should be CONFIG_64BIT at the request
of Tom Rini.

Changes in v2:
Resubmitted by Andrew Goodbody with changes requested by reviewer

Andrew Goodbody (4):
  sandbox: Correct guard around readq/writeq
  sandbox: select CONFIG_64BIT for sandbox
  x86: select CONFIG_64BIT for X86_64
  test: lib: Use CONFIG_64BIT to detect 64 bit compile

 arch/Kconfig                  |  8 ++++++++
 arch/arm/Kconfig              |  1 +
 arch/mips/Kconfig             |  4 ++++
 arch/riscv/Kconfig            |  1 +
 arch/sandbox/Kconfig          |  2 ++
 arch/sandbox/include/asm/io.h |  4 ++--
 arch/x86/Kconfig              |  1 +
 common/bloblist.c             | 13 ++++++++-----
 include/limits.h              |  3 ++-
 test/lib/str.c                |  8 ++++----
 10 files changed, 33 insertions(+), 12 deletions(-)

-- 
2.39.5

