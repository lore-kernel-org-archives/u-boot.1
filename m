Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91BCED49776
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 15:50:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD0D48941D;
	Sun,  1 Dec 2024 16:25:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QomBm9aP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D663489434; Sun,  1 Dec 2024 16:25:23 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C2AF893FC
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 16:25:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-8419f5baedcso104784139f.2
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 07:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733066719; x=1733671519; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+8t7rDuc9gb5RhLIZgId+GIHZokYY3IHQ6Ynd9gwP5Q=;
 b=QomBm9aPH6nSY1aim97vWoqh5hpaubrlUEK39sh5KtL1vrrYLnvhyR+IqqSoyvheW/
 sstvkqdoXbG+VlggBeHTuW856PHvGrMk3sRUA+NSt5uHwMt/tfKr8uYFUTa84CzDShJR
 eM4E8BGFAXsXqRKuHRA6m+eq4gDaeAFxxkDFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733066719; x=1733671519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+8t7rDuc9gb5RhLIZgId+GIHZokYY3IHQ6Ynd9gwP5Q=;
 b=aodxk/yDYyJN9pnpBJ0oIyGrG8Ru1mtk6M5qHSW7rnYene3pWq7s9QIMx3aFRuN6iW
 SVdUa+jkasSLvkCt+/s96h8TucPCqklOPwyFOa7OjZSQK/QyXkggGuCrY969m4RvUqr8
 bimt7xUesn45uiZTIfv6kM1LzLLnr0+5DajDaHyit1EFxh6VZ6lN/j5F/P/GkhYLZ3j4
 hYnDfbC71XiRsEmNts/8bMABzzTp+SAhkrhrGZzxDUiaRg1034HGSucjB/OG5trmfM80
 ic7XnkeebLJ3GZePSAedz6MpAF+WamnQWlUU5liiLkRG/kBCvsAA5yH1euLhzzt6tq8o
 4Gfg==
X-Gm-Message-State: AOJu0YxrIFM27Pd9yTR0nEORAoiPJWop0UBu9c4qmy6Ncq3+gPH5ylp5
 2gop8WlVLpltAswkoFzovHP1j6/5tJQwgaa7RYnjNwRvZT/p1/wkvD+dFD8TBUwTy/SdNMsUack
 =
X-Gm-Gg: ASbGncvlf4IpXaZAaCHcZLWh/+Ei7fBlX1sDeSe4V5AzVtrFUMiGEhE2ram/7kMP8Pu
 /FL0SpSBjNwAOqDKtH+z9nL8z2Qn2JboI7bgKa0fshzNpY4q+rQiajJwFVpi6eJneopGuvCkVPs
 ig80AeaxtXn6+Wb1fGFVAy2oY089d4ydvGavIgiKsZkRjAHGldTmDAdWvMH0eySAoMek6Q/R51b
 7/EbzbRSAPnRnrEfSd9ovzjeTCJwI0L1cjOH0IalF6y
X-Google-Smtp-Source: AGHT+IGbiXyy2N6lTENdDIfdyC8Zad6nXQ0bjsfDeBWkmrJ6J9du9qxC+WuRM3KXmWWvrfjM8X0mcQ==
X-Received: by 2002:a05:6602:6d16:b0:83b:47:8d5 with SMTP id
 ca18e2360f4ac-843ecf9dc5fmr1964759739f.3.1733066719421; 
 Sun, 01 Dec 2024 07:25:19 -0800 (PST)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405ec8d88sm159755239f.19.2024.12.01.07.25.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:25:17 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v4 02/25] efi_loader: Fix typos in enum efi_allocate_type
Date: Sun,  1 Dec 2024 08:24:21 -0700
Message-ID: <20241201152505.1666789-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201152505.1666789-1-sjg@chromium.org>
References: <20241201152505.1666789-1-sjg@chromium.org>
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

Fix 'indicatged' and 'adress' typos.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---

(no changes since v1)

 include/efi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/efi.h b/include/efi.h
index 348ff9efd16..76feefe6c50 100644
--- a/include/efi.h
+++ b/include/efi.h
@@ -175,7 +175,7 @@ enum efi_allocate_type {
 	EFI_ALLOCATE_MAX_ADDRESS,
 	/**
 	 * @EFI_ALLOCATE_ADDRESS:
-	 * Allocate a memory block starting at the indicatged adress.
+	 * Allocate a memory block starting at the indicated address.
 	 */
 	EFI_ALLOCATE_ADDRESS,
 	/**
-- 
2.43.0

