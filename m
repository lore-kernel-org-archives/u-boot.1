Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552F3C5AE59
	for <u-boot@archiver.kernel.org>; Sat, 31 May 2025 08:46:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A8D482AC4;
	Sat, 31 May 2025 10:45:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nFOF01Zk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 544D782CCF; Sat, 31 May 2025 10:45:14 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69F3782AC4
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 10:45:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a36748920cso3043726f8f.2
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 01:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748681112; x=1749285912; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oINDw+nSoqtNR6yqKIAIjQ2bb5e0uptR4EDEECqTAL4=;
 b=nFOF01ZkKjwDXqHkDeR5jUsFUmrLLK1FGZr/Zqb/Nee0FYYVJfYTkq65hqHrUmN0YG
 JuZCwMblBGdkHCESb5ewSNKhwZqm0BcKnW0CYYj8RS1ObaEjciL0y3djry/MZ1UbdoWL
 1HRKBgdR/MtJhpe6f+fJLbvWHWVes0QSw6pDDs1POlaVgugZJg8ry97Z7/LglAdZ8UnY
 9q/7nnoFMJm15LkkGbaGBPAit2nD9iPoKpPYj65wyGXcRWn79degS0TC/uplq2mPLfcr
 kcP3sz1M88kccD8SWqhx9CzAo8O2Ho7ToXpEtyn6QliTx/ZwrlBEcTaU+nsTRGPW+Ran
 eqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748681112; x=1749285912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oINDw+nSoqtNR6yqKIAIjQ2bb5e0uptR4EDEECqTAL4=;
 b=eN0inaaq+Gm2/v1mkBh2We9crtP93ZkBXOTiAJ8nMzTiRLlnmsEjXAGgo5osM2ps1t
 QYSPbvIQKCNKPJ2HHZlRdIIHRtlElKQ5tVJ51NIl0ZboZmZ0rOBcCiHF8vE3bVdfeJXs
 lbO5mfrA8XXgqW/yzvkphyW7moVQRTYFHXlHrC4DI/usihXdbycJ+JeGHXI+8T0aXxUd
 u+1GhxJmhDjxg3fElIcUGNz3itfZOO6ma+xwdMQ8Wp9WxjbzLU/P0vgCcarz+M5Jj3w6
 alNTcPbhIuaIkaX3bXecQzEwKY9pXuQ0VQvzHeOy3wBv5EIO7SsKz6qtX/qikOEHE8KL
 KvRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwSGeYF5uhNpb5aAsr6yZ3eisROhBobCzA5iAO/8CSl8ucUDqVwkt0CHTB65SsuCK9NkDQIQ8=@lists.denx.de
X-Gm-Message-State: AOJu0YwONAh5DAMeIqnvhivmSE5D1F4tyF6YjoaaH/vCqytQny/x6K/3
 DPBIhsMP2l9p1IqsgDXIjXImIYZ40ZTt7D69X+qpG53pRasTwXMj4Y2QvuI9ncglB1o=
X-Gm-Gg: ASbGnctCEDrIaPx0/4/9t/SC8h7jiBfYOzrLuD0ribEyrYX1YTKziod+45TC3aSW0pW
 scyRuX7Pumycsf96oVmCGiHmjdoOV7lWIDpH1mKObWGjK03e6phrm11YmblGmHqNX7AFkEHV/MA
 ohAyyjL0lGT4K0LL5DUvS9TqXGhCv5F6et1iff4pdDQw/ipoprq/GP5iiT51rQiMCUPHf+vNzkI
 loEyoWjKGY6vtTxrgpgazBsfNZRCXpSyXYBvbX8V8Hf8tEx/Rc8jk4lLP7cKkh/vYdt32oSZptz
 9ycihgvtmaAVsvlesN2dho+ZORvJ0+Ld8sMos27tMxHs/0zvgZpAMz02JZCfefKRNqJ/5gOaIBg
 v390Mw50QRcF/yayYJwNaYXE51rfjOA==
X-Google-Smtp-Source: AGHT+IETD/RC6nkHZMuoNCf7z7q2xxzSAZgYr6VFDoH7z0iNQDrhiHMSCxS2BGeMlnMThs9FEcDgJw==
X-Received: by 2002:a05:6000:2407:b0:3a4:d924:e65e with SMTP id
 ffacd0b85a97d-3a4f89df89bmr4389197f8f.59.1748681111890; 
 Sat, 31 May 2025 01:45:11 -0700 (PDT)
Received: from localhost.localdomain (ppp089210105145.access.hol.gr.
 [89.210.105.145]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe73f3csm7153986f8f.42.2025.05.31.01.45.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 May 2025 01:45:11 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Yao Zi <ziyao@disroot.org>,
 u-boot@lists.denx.de
Subject: [PATCH 09/13] kbuild: do not overwrite .gitignore in output directory
Date: Sat, 31 May 2025 11:44:37 +0300
Message-ID: <20250531084449.4125187-9-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250531084449.4125187-1-ilias.apalodimas@linaro.org>
References: <20250531084449.4125187-1-ilias.apalodimas@linaro.org>
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

Backported from kernel
commit 156e7cbb3ef5 ("kbuild: do not overwrite .gitignore in output directory")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 055898935372..19fa77953d2f 100644
--- a/Makefile
+++ b/Makefile
@@ -519,7 +519,8 @@ outputmakefile:
 ifneq ($(KBUILD_SRC),)
 	$(Q)ln -fsn $(srctree) source
 	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/mkmakefile $(srctree)
-	$(Q){ echo "# this is build directory, ignore it"; echo "*"; } > .gitignore
+	$(Q)test -e .gitignore || \
+       	{ echo "# this is build directory, ignore it"; echo "*"; } > .gitignore
 endif
 
 # To make sure we do not include .config for any of the *config targets
-- 
2.49.0

