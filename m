Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D76DCD4F54
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 17:13:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 131DD848A2;
	Thu, 28 May 2026 19:11:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CK8/99vJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F8ED84878; Thu, 28 May 2026 19:11:31 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E54B84886
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 19:11:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7e61e25199bso2264638a34.1
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 10:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779988288; x=1780593088; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g5nOlb3GtNXG0pnhM2j5EQMoH37D7jRJetCH5oMqdvg=;
 b=CK8/99vJc0j9zJ2yv4sz4fMtfDzPU0hZIPVsr2tZ81YW7NsqK4atJ6qVYw9Dny2zA8
 TievZyqxtZgvVgx4beSTLRbkvu2f6oMDYriJjMENCZgz3PRbWPCcUIq9O30cDx/sGG2N
 a6HYSIjK+f2PVKuJhBTSea8m7BX8Ch2iAQfiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779988288; x=1780593088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g5nOlb3GtNXG0pnhM2j5EQMoH37D7jRJetCH5oMqdvg=;
 b=P/8Y6k70NRW4P+dwZ4H2WrF99pfIPnWpB1+W9NjiAmdIPNTAgxvYDbPW52BvEKX2b4
 RPhMjnHFJcCNzwloHj/EPJuxDKuyvw13eAtCvOIgudjZ3diX0y596+G91Td2OozUUp42
 a2hfwNLKJxfahfW57zxHb48jTEAqu/kj8CuPPsA2yxzNQKahunQ2p+lKIa2gzVIGLAiH
 bWh0eUIXX9FQ91scmiydQitLnTRBEeBTAFLjqYIFAzGNwFgmAAvhUCr3lFwq4bTYBMKr
 xArtMNZLL8ZmAY6GImmA1UiLAB4DWEUxEriRl3IWnbyOD2N3V5WKKZNareHIb/uFREPu
 zWvQ==
X-Gm-Message-State: AOJu0YwMlznJHQ9AQP5MiOYPcL5IyAEiN7o3PO76vFP/BjmcyYXUHdu/
 8hx9zU3PKwCbR/iEk+eflV5EogpLIZQ1uhk34NNQ+24YkPpRoaUaArNuRR98Mi/XbjbBEEYHIw/
 XVEKF9RznIos=
X-Gm-Gg: Acq92OH2DEn9N8qav8B0LYGg6CsFgYPSMCggcyxgsyxTtbZnJ08uGWeuR28I4cFIduo
 OmW8+9Rav6M3GVnfjxIJlLQdINBMlJCvftirTSC/KWBWMrJE7IiJWIbQQLRam23sy8p68qvd72d
 VXoGKg2oVZdRCG4OqdLZcyF9OTtxeO76Tsg77OtT1n9Gt/LlJKcozLHY2MPPeEoxaxOWCcm9+oF
 aT+YlE7dL6mUw+bt21QgAbST69KQCUxklLtBRDB1khgpzGDecfGSWAG7ivd3wCyMR7552hAc9/f
 N22dIz0mJibpuB130ZPZIy/Aky4jBbBvEWacZ3vRfpUE5dQdZbsbCvQDq5OqsdbZtYlIjF7WXq3
 sXIhA8X017bCtecCIPHuwoTXyYlu5pHlJt0u/e2ZIwCkDSj+LT/dzKAx6aUg9HmmAiNkWlZBurD
 PhZOfvaTjs5YRXnJk9VofNpYcYisg8
X-Received: by 2002:a05:6830:82e2:b0:7dc:c620:aa12 with SMTP id
 46e09a7af769-7e5fee9b2dbmr18081616a34.20.1779988287762; 
 Thu, 28 May 2026 10:11:27 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e606459dadsm14461068a34.4.2026.05.28.10.11.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 10:11:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v7 14/22] rockchip: Add symbols for spl_reloc
Date: Thu, 28 May 2026 11:10:21 -0600
Message-ID: <20260528171043.910264-15-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528171043.910264-1-sjg@chromium.org>
References: <20260528171043.910264-1-sjg@chromium.org>
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

Add various symbols so that this feature works as intended. This allows
xPL to copy the relocating-jump code up to the top of memory, then use
it to decompress and start the next phase.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v5)

Changes in v5:
- Drop duplicate __image_copy_start and __image_copy_end
- Drop unwanted comment in script

 arch/arm/mach-rockchip/u-boot-tpl-v8.lds | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds b/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
index 2c0f5c3e5f3..94f0fc61719 100644
--- a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
+++ b/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
@@ -26,9 +26,18 @@ SECTIONS
 	.text : {
 		. = ALIGN(8);
 		CPUDIR/start.o (.text*)
+
+		/* put relocation code all together */
+		_rcode_start = .;
+		*(.text.rcode)
+		*(.text.rdata)
+		_rcode_end = .;
+
 		*(.text*)
 	}
 
+	_rcode_size = _rcode_end - _rcode_start;
+
 	.rodata : {
 		. = ALIGN(8);
 		*(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*)))
@@ -55,6 +64,7 @@ SECTIONS
 		. = ALIGN(8);
 		__bss_end = .;
 	}
+	__bss_size = __bss_end - __bss_start;
 
 	/DISCARD/ : { *(.dynsym) }
 	/DISCARD/ : { *(.dynstr*) }
-- 
2.43.0

