Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE5D4C5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 10:18:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3356837E1;
	Mon, 26 May 2025 12:16:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SpEBUeXV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D306B8373D; Mon, 26 May 2025 12:16:30 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A14F68376C
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 12:16:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3da73e9cf17so20285905ab.2
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 03:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748254587; x=1748859387; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uWDKUwwERcgtDGqYKz13PohoB+jr/xREnRg3TEniJVk=;
 b=SpEBUeXVW64zHpCIQQJUpOXDXPW7ZagpFM7AP32M8n1BzXhUfM4XRDkJPheK4cWZOb
 WCuBQUBu8TN2dpHmjTzDVwUlMFwZNnPpyZelpiy6A7EuSTCn7xesYREE5astGOPIFlue
 fwoXgWxI//1EktQX71Q5KICdZyqr3IwcXvpB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748254587; x=1748859387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uWDKUwwERcgtDGqYKz13PohoB+jr/xREnRg3TEniJVk=;
 b=kaDrGUvGfapfFt29MPbpRR10AE+z7Nq8D32uYOrp87pUr+fUHdwWSh34DriLyQXC9h
 SALnVrXJ4gR0kvfPObxeQ3mH1lHH0fBd/ZWYQmD6hGCARJL5qK8T3KfGVQbjHFQzcy4v
 gCh7VIW7/EqhrAnk6+27m3gfMs8DLwXosvjjUJmRc4RYqVdJfSz8ZbGZRdd/Pa+ywBW7
 2gYhHDLc0VDNjZBobhsNLci7287ogKepjp7Pd+S+hMPoIeLPBi8BwgA3HiBE9CqXKZYt
 niXvgjIt5LlQnHtFQdpZWcMuK/JmwX2f9Pnq/EKna5beK960uZXI0gDpkFOChAolwG8R
 T33Q==
X-Gm-Message-State: AOJu0YwvkqRHLGicXmmxWOFn+aq7UCIMWpqbfujO4ndTgPVQe3FebS9i
 +8dcF8zXxpCmBpj13d/CIUAWlxjcP78LBe+8n2SOQLa2Wb73wW8UIygN1aPUnMSJgnXieokqWPO
 AMJIOM/Yb
X-Gm-Gg: ASbGncszJkhVHIvy67Dsx/wP52XjyWyhZdtvPwx/r3t16iakQxi22koI6DQ37wbhXQ9
 YICd6bjpmrhEEpyfUaTeBoxkjd7mr2LKMRqcs/Z/LnUL+jyLHWJ2YCv31Es/1wHZnl2PoEaw23F
 eQlCs0EnXQWJHIxXaVx+VarPQMaqC3QzjGe2aYlRv5nYNsA1snU1DPHKFQlu0T/8yp3CLHo4Ozg
 7OUml0W25FEmYVOij0YVB3K3GXSklX8V9jIye5r1oT+fe5Yq7gFNLsgTvgqySomwJmkfr80LV1p
 5F8EcziKbIev7Q+bD+MBD5bwr8W5DnkeH2aK7yZ4Ve0km4MzrB5MZjXmwaoOvvTSxn2EFALVj3O
 hahh+BljZmAqe
X-Google-Smtp-Source: AGHT+IFBCN0M7q4QGbsAqEGhipiZmL0Hpd8O2shHWWdM4R0Eoy45JNXzSWDkHVSSSfCJNmNYmlPWkQ==
X-Received: by 2002:a05:6e02:4413:20b0:3dd:74f3:a059 with SMTP id
 e9e14a558f8ab-3dd74f3a1d7mr27127525ab.16.1748254586849; 
 Mon, 26 May 2025 03:16:26 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fbcc3b19aasm4679249173.52.2025.05.26.03.16.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 03:16:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v5 14/25] rockchip: Add symbols for spl_reloc
Date: Mon, 26 May 2025 04:15:00 -0600
Message-ID: <20250526101541.3254628-15-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250526101541.3254628-1-sjg@chromium.org>
References: <20250526101541.3254628-1-sjg@chromium.org>
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

Changes in v5:
- Drop duplicate __image_copy_start and __image_copy_end
- Drop unwanted comment in script

 arch/arm/mach-rockchip/u-boot-tpl-v8.lds | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds b/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
index 958a1b70aef..637daf1376c 100644
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

