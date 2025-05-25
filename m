Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 521F8C54E90
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 10:50:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A730836D5;
	Sun, 25 May 2025 12:48:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Zjgrm9WB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA2DD82AA7; Sun, 25 May 2025 12:48:39 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCC65836B2
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 12:48:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-442f9043f56so8364015e9.0
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 03:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748170116; x=1748774916; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nf2cwcPH9snkhzrCEYTB5s+YLMgZ/emQTlvZtOlcIh4=;
 b=Zjgrm9WBHUVfISxfjqjVSeSa9cfYO77M1g8KS+AoALbA4AH3bLN0TRSYpyFagKf4fW
 DEAH0M2QkDmZNyCNRyiMt6dW2N+YmYI6eEJg6WhPAH4hZgbM2BrDrbcL0VbNhO/b2hH0
 o0DAeK/2lpH3xxly2hHxFskUc5zLR0Q/FoE6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748170116; x=1748774916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nf2cwcPH9snkhzrCEYTB5s+YLMgZ/emQTlvZtOlcIh4=;
 b=TkQtXBFyNgrIvKLDY+FqxpeKtH8ECUAstRomW1SJ0ERzWDpEQAvw+3J3mk/33mRmDr
 thA94jqPbnGITI4QIGMu24lyyToIM4CUtI8e1pA47sfSRY0sZPnYgII3OnfRlrbJXUvo
 a8lthpocwyRQ83t6P7Ulg8/dlRrRPJddL5uPRq9iT4RlqS1C+SLj/g5wSCg09FAJYSR9
 RsPibfMCT7f1XTWdI0pBS1qRoYoDH63KL2J7bFAsm9BRwQuKoXj6Z30cKG826kmZQDbb
 pH464VAxfRpf4VbwOr8CNouAjueL/FoABmKyX1jW8HknfufoOKYSwEs26TOljcYSoMrL
 uupA==
X-Gm-Message-State: AOJu0YxKqwBuZLbiFlnA6spHXsXtMTcP+tg2u6PWlFLw/tx2bgSrqWkZ
 WbNGuEKbpLKzaNtiOVfM8fHt1jDcq7rf5b7wlxtP/TPMfHMDfLUxANlMmHJ9y2KiTam+npdg1FZ
 0JURKtwQq
X-Gm-Gg: ASbGncuhnqjNj+wl4DuVfdKVuHPIlmrBmcj53cFsfpewDtoVja/He+zt3ncUEEFAmBv
 0puyBejRtoLYU/dbINA9y4KRq4v/QuTXa5WNPBTFRLuXx2cGPQ9vf/9RidCfvYkbbNkYNtj8Dpn
 QqjDkJoaV0xHcgKR9bFonn8XDUBnIr2TgaQaLKMXrKsTcDWYw4ZC3WMxO/eT97gPfobbNrWgXib
 UjGuQLxIX544KrXrLM/cgXrhO144HcI8AUNGbTD/FqLfrKefXUrIyzi6PaI60cZ+UDkXUMKE645
 CtUM3DQV2ViThPxxTesIhgO28qsYWvjgm+N3nXU8nZyAs4fXSuF+EchtgK0rLe7lybyowjM=
X-Google-Smtp-Source: AGHT+IGIgi/Wci94DXRkukv3UafsvhAvlVaXTYxfxNKUX9rNX0E6446GBlpaCQvpTwL4V29erChjzA==
X-Received: by 2002:a05:600c:6308:b0:43d:2313:7b4a with SMTP id
 5b1f17b1804b1-44c9141ac4emr59140425e9.3.1748170116428; 
 Sun, 25 May 2025 03:48:36 -0700 (PDT)
Received: from tasman.. (host-80-43-238-15.as13285.net. [80.43.238.15])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4cb450867sm5045047f8f.57.2025.05.25.03.48.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 03:48:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heiko Stuebner <heiko@sntech.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sebastian Kropatsch <seb-dev@mail.de>, Tom Rini <trini@konsulko.com>,
 Xuhui Lin <xuhui.lin@rock-chips.com>, huang lin <hl@rock-chips.com>
Subject: [PATCH v4 18/25] rockchip: Add documentation for VBE
Date: Sun, 25 May 2025 11:47:54 +0100
Message-Id: <20250525104801.1440260-19-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250525104801.1440260-1-sjg@chromium.org>
References: <20250525104801.1440260-1-sjg@chromium.org>
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

Now that VBE is running at a basic level on rk3399, add mention of it in
the documentation.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 doc/board/rockchip/rockchip.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index b88299cbba2..cf983c91bd9 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -519,6 +519,19 @@ config-flash.ini:
         [OUTPUT]
         PATH=RK30xxLoader_uboot.bin
 
+Verified Boot for Embedded (VBE)
+--------------------------------
+
+VBE is supported on rk3399 at present, with SDRAM being set up in SPL. The full
+A/B/recovery flow is supported in U-Boot.
+
+To build this, use the rk3399-generic board, setting CONFIG_OF_LIST to the list
+of boards you want to support. All boards must use the same SDRAM type.
+
+VBE uses internal SRAM (IRAM) for the TPL, VPL and early SPL phases. The stack
+stop is near the top of this (0xff8eff00) with the 256-byte bloblist immediately
+following.
+
 TODO
 ----
 
-- 
2.34.1

