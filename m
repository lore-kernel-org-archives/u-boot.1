Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D4EC71135
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 20:25:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3619082B20;
	Wed, 11 Jun 2025 22:24:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ceol7QU1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24A8682B63; Wed, 11 Jun 2025 22:24:57 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AEE5828A2
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 22:24:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a4f379662cso243853f8f.0
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 13:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749673494; x=1750278294; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UQCQOJdrm2IjtCLOS2RNP2XVRNuj8BJr0JJ3p5y+7PU=;
 b=ceol7QU16aogIp3ERlcqmGCer8fsnvCEbNLhM05LBYcGA1eifVf5NnwhGwUODyiwf5
 x+Tp+IZqZn7DVkBryURFtWMNidX9ZdkyOp5mL5q5wjum31/4zX9HwCBBK1VJR8guu4Ac
 8ue1lkyUcivHBKvGf8b7aV4bKq8GflkH6sx+m5SbQHK+z/jBtnjMGPz9mpuV7bVCpCZ5
 x9jI53qqYxps3r91o7eOOYYLeuYuBKP9NvfAGDN8k3eB2rLL0sFwEXxdlkw+nwUQgVlL
 2kzraWMINIImcl0bICRnrSA9pvtK2A7P+Hql4SYYd8JDATmhdOmYp+WoWO5qZ9mqVBha
 ydlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749673494; x=1750278294;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UQCQOJdrm2IjtCLOS2RNP2XVRNuj8BJr0JJ3p5y+7PU=;
 b=vRu49mH2K/BAp4WWlwlwuZoWF/Plyu5ja7L6kK68gD8lCAYivq/RHCD3ilCK7CAJ5Y
 rZ24d8joQUYTaqoJkvCcklWHAYHS5cn/5WSdA135u2pny8L8pcl/IWOndjtyZdCtYmer
 khAYCVJ+srb+YxRUUJkPJFm8wbZpBbqXpx9EVUk8CDw7KBVCyyu48+5AJzKgXiMgt/4O
 HRtjjbZMRiTQR3e8IRfqC1KpYiyK1Z0cDgNfTyroJjKJS6UDA8IX9sj4mDHyrGGlYhwp
 rYLiXyMwNFhOVTy05ygjb3N08C0W6do/wtsaVkemNb3ne9GIJbcHj0IMf5zs+evxVXas
 r2GQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaopsl4hkTLTmuGuSvWia+eEA3maBLzZhBrBqxzfF22lNfjyOvq13gWDqS9MAqzBT2yTNNltU=@lists.denx.de
X-Gm-Message-State: AOJu0Yxxhvr0Wvjdy9hxTaxziC/r8fh3GONeHygqZn3wpSy0RfZQRG+j
 +avVPit1iXhwV4N8g7rdYxhPxdhgsm+VnbjLNj3r0DAuEHUd8ghwTyf9bpt/AIdKo04=
X-Gm-Gg: ASbGnctMoEmD+I+IkL3653snxkJ2aoPbiFkQXHfP4T7NjXGhPOdiKGR2V40HG64uNIq
 k9f+65pxiBDLNobeQtnbONLZfvYMMiPhxPJWxyYIBK977TC7AIthxObAXXl7ijFg7LtRuJrwMGF
 1U6+g58ulOG8YUJsJNzuFJUP8x2IY4gga+jPcWCJ9GejcvhADeir9pae7J/UKpYHDxJuadT+1fK
 Tq51SxW9Vs1/wF2N2P+3/1CqF84g7kxfPLVv05YF5h2XmZMHoAoej2hQKEzFGgP2PNpUXemgmj9
 LEIA75Hh1mom/oig9N8egfSIT3uZ0lZTDyxp+LqPjxwGnXBjrIOFw6JJKt34/Kqtbj0iMRICaJW
 vgV1QBFcUmrUQCi8hX1hKhOs3+2Kh2Pe0i+uugdZp
X-Google-Smtp-Source: AGHT+IFgW20AuBS+/yp7eay95OrRpO2nDTO18iMbVkeamNZcV4K1ossevNtLLNfAyfWadiSIlxJV/A==
X-Received: by 2002:a05:6000:4025:b0:3a5:27ba:479c with SMTP id
 ffacd0b85a97d-3a5614c2081mr222356f8f.43.1749673493583; 
 Wed, 11 Jun 2025 13:24:53 -0700 (PDT)
Received: from localhost.localdomain (ppp089210105145.access.hol.gr.
 [89.210.105.145]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a561a3c538sm12071f8f.50.2025.06.11.13.24.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 13:24:52 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <ziyao@disroot.org>,
 u-boot@lists.denx.de
Subject: [PATCH v2 00/13] Update the kbuild system to 5.1
Date: Wed, 11 Jun 2025 23:24:27 +0300
Message-ID: <20250611202449.2317279-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
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

Hi all,

Another series backporting and merging patches from Linux 5.1 kbuild.
There is still a gap that I plan to update after this series gets
merged [0]

[0] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/commit/5da099cef04fb5c02dcafab8d1bab8ddc2855765

Changes since v1:
- Rebase on top of next

Ilias Apalodimas (13):
  kbuild: add -fno-PIE flag unconditionally
  kbuild: add -Werror=implicit-int flag unconditionally
  kbuild: use assignment instead of define ... endef for filechk_* rules
  kbuild: clang: choose GCC_TOOLCHAIN_DIR not on LD
  kbuild: use -Werror=implicit-... instead of -Werror-implicit-...
  kbuild: gitignore output directory
  kbuild: remove meaningless prepare2 target
  gcc-9: silence 'address-of-packed-member' warning
  kbuild: do not overwrite .gitignore in output directory
  kbuild: skip parsing pre sub-make code for recursion
  kbuild: mark prepare0 as PHONY to fix external module build
  kbuild: make 'archprepare' depend on 'scripts'
  kbuild: fix single target build for external module

 Makefile                 | 64 ++++++++++++++++++++--------------------
 scripts/Kbuild.include   |  7 ++---
 scripts/kconfig/Makefile |  4 +--
 3 files changed, 36 insertions(+), 39 deletions(-)

--
2.49.0

