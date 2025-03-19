Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C00C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:41:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D114981FC7;
	Wed, 19 Mar 2025 15:39:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y6yXlbqJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA23B81FBB; Wed, 19 Mar 2025 15:39:13 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E82D18193A
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:39:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso32206835e9.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742395151; x=1742999951; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0unRyrHoyHb2BDBBgdcYWjju76AsiVBVkTXXWunJv58=;
 b=Y6yXlbqJAKiobaC9BWliU/jnACG46CBw50YfF+xQEo+4BYCriu2WYGPTto+gqkWqBn
 e2V61l6YuuzKXPAbAram67hkjfTbr3E9MlbZVFbSno2HliOyDkRbtSr7vq1gZbMgu1rx
 13rbOrRblsxwUd4aA+TH9Kwgp9NDhQkaASFEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742395151; x=1742999951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0unRyrHoyHb2BDBBgdcYWjju76AsiVBVkTXXWunJv58=;
 b=FMphPjbD5/mY+he0ui+GthAmK8FaUb1NoutMEpPG5pJstZ5wvkQqH3/N5Lm1Kpnck3
 84D8HbJ9/7Z1GHRvlPU9LCRcFYU9xaXRVTm0i+xgbe4H/U27gfUasWyVnIjetU+BcNyF
 y+scuFC/Jgk+VZSE7OpUXHp6D3CkyHIirKswmU6kNvJFjTle/yWeOFjlRSB2KjuRlkQ3
 AqrOgdsRig3XLiWjh9OAgWspZD9fDt5YmpKkhbJqhSokt34HYW3gg/dkp22K3h02AjXF
 U5vQ1tFjLwFqIXy1syeItrjgXIUGNX1rbAEkpJPM3qwHZ9CIld5KWBg/plAO6tldwAAD
 2O1g==
X-Gm-Message-State: AOJu0YxvuoAzqLsSProqRiB6bzNIe9YYSY+LGNXx1U/pGZW4vM1Owym0
 X/blY6kOAqdUUnIGSJlY9cGzb2+LI8UolHMbmBinF/rTYSbMI55cWim3gUlxRYFHaSQqKn6qoSU
 =
X-Gm-Gg: ASbGncv61yyacRy0t8MjABYRMpO4Mu7uwvQ1+V4InoBelTTPOw0ZSsc0J0pXdHwG1YL
 TJyK9TMwsWo+Yat5O12wGNeCdDZBo8F7yvRTwXsPad+DeodEbb3YzU8JZK8s3/mT85vW9IdZBPb
 N8Ir8c4SxiCnvzz0aocUjgVgzx8eAeixEOY6nasrDw8isMJ2ZPw9dU8VJDJOQFngv3ALJjDVMog
 eQj3slrGqdlMolx2L0xsC7yPCLzlQObXFUM3FqneY0Rkkb/KreqdElGEqQCizykg6Vl6K8fKp+K
 qMCBjQugy58yGeSubFdGOe4qar6c0QOWaYszZD+VbA==
X-Google-Smtp-Source: AGHT+IGI2OlSjXN6BfGLaDQtHWPl2qrhLbAn6XyWtTxbunJFg7BSX2DFGTOCaHX9h+7Uts7E4tJjFQ==
X-Received: by 2002:a05:6000:1848:b0:390:fbba:e64b with SMTP id
 ffacd0b85a97d-399739c91c6mr3178042f8f.31.1742395150806; 
 Wed, 19 Mar 2025 07:39:10 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb318a80sm21534428f8f.61.2025.03.19.07.39.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:39:10 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 15/17] bootstd: Correct the comment for bootmeth_set_order()
Date: Wed, 19 Mar 2025 15:38:09 +0100
Message-ID: <20250319143820.2385092-16-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319143820.2385092-1-sjg@chromium.org>
References: <20250319143820.2385092-1-sjg@chromium.org>
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

The function is used to handle the boot_targets variable so must support
space-separated items. Update the comment to show this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/bootmeth.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/bootmeth.h b/include/bootmeth.h
index c32bbbab7e9..8f4706c555c 100644
--- a/include/bootmeth.h
+++ b/include/bootmeth.h
@@ -301,8 +301,8 @@ int bootmeth_setup_iter_order(struct bootflow_iter *iter, bool include_global);
  *
  * This selects the ordering to use for bootmeths
  *
- * @order_str: String containing the ordering. This is a comma-separate list of
- * bootmeth-device names, e.g. "extlinux,efi". If empty then a default ordering
+ * @order_str: String containing the ordering. This is a space-separate list of
+ * bootmeth-device names, e.g. "extlinux efi". If empty then a default ordering
  * is used, based on the sequence number of devices (i.e. using aliases)
  * Return: 0 if OK, -ENODEV if an unknown bootmeth is mentioned, -ENOMEM if
  * out of memory, -ENOENT if there are no bootmeth devices
-- 
2.43.0

