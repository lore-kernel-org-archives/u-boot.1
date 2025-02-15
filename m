Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F6CC02198
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 03:25:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C78AE80F6F;
	Sat, 15 Feb 2025 04:23:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XZn0WiSy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3CC580F91; Sat, 15 Feb 2025 04:23:47 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E3F680756
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 04:23:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3d284b9734fso1735305ab.2
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 19:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739589824; x=1740194624; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l7XsTF+3EtdAKNdldfOWrJWn2LaEeC9a2vwztV1OvF4=;
 b=XZn0WiSyTj2geRgBxUMMik6bdcr0rqWKuGaikBi7gJdgWh9hbXa57qK1BpluujGSKg
 iIO+bIRsWUofys1iUI+g1cSDQ+gzNJpdWAXshJidOZm7r079EVDTkRexIsEYwVuEi2Fn
 YuZce6lDTcHZzx+DToPpywxn/b0kEEX0mMcxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739589824; x=1740194624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l7XsTF+3EtdAKNdldfOWrJWn2LaEeC9a2vwztV1OvF4=;
 b=clSmvDcmzceUsyXySZpnwBunC6rsbsSZLNI5flFloo10rnybU954SRtcWFbMc+bloV
 If0w+YIkakgaHoLXShFlncSutjAEh24v9A1oDIjw8+uQY/T/Uv9qGqC1YMYSOIc/3MEh
 jlALKmk3Lx8Nzze2r/bqQE7j2odkvuBqp7cbuOg5vl+GOQcAl1UH4GujfqqvoFr3Mxdq
 ObqEesk/o/ki81BjR10ocgNrdvC5hogCK8KDzUz//d2pVuBN82gPxCjhN/8SqK89ApY/
 PelEWIVl+062QFuLAm/o4CRMcHZN7K+8IiI5BkRw7/9DyAYtcQ/m19D4LrSOJYFPenf3
 G+0g==
X-Gm-Message-State: AOJu0Yz8KGMEQP5sgLvrbPBHmypFOC4+wY5cM45EmJ4txlfIRNduzX4Y
 LdaxWkrW12kMAw4uA4N2lIDi1uizjSJj1qk8IAogj60waqBQl1FKf7lkNzRIZjRhXQ3hQgQsfW8
 =
X-Gm-Gg: ASbGncsgpRL1GCEQz9iJHI5K4uC7YbeYE0wpT8L2c1XK/MV11wAk5rk9RKuqgzYwD+x
 yZBsNct6iYW/MxRlcA+PCE8CdRCjJndV76cPis5q7mvFqKdfeZ3+9Jck6uY1XmSILkrzi4OuZzM
 8PgsjlzXlzfrdDyaNtJSMKbAE4ztQdAgXXIXl5jKqeZJLmlwPl8bdH+U7dU0QrDjhnA/i0nEvwR
 L+PguUzy9KZZ6V8ziX+A81iR7Usw6SVxXKpMUkIcVm5NbEBXscskU2OFHIlRgrzS2jFPFOo+wD2
 cnYbboVm53JboWjcFwulFAp+qGUh6SNChnQgX+Xd6y6Tosn9Qj4R
X-Google-Smtp-Source: AGHT+IGZXgXdHz6ynsWQumu11ZJNZyBAcO4xQkCWstuUipa9xk14FeksD1zL0Z7REDkWWanMLnmrZg==
X-Received: by 2002:a05:6e02:1a4d:b0:3d0:4bce:cfa8 with SMTP id
 e9e14a558f8ab-3d2807ab183mr17642545ab.3.1739589823778; 
 Fri, 14 Feb 2025 19:23:43 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed2819d0f5sm1087697173.67.2025.02.14.19.23.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 19:23:42 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Janne Grunau <j@jannau.net>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v4 13/29] efi: lmb: Avoid access to _start
Date: Fri, 14 Feb 2025 20:22:34 -0700
Message-ID: <20250215032254.4121030-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215032254.4121030-1-sjg@chromium.org>
References: <20250215032254.4121030-1-sjg@chromium.org>
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

The app does not have this symbol. Also the memory where the app is
loaded is not under U-Boot's control.

There is no sense in relocating from one alloced region to another.
U-Boot is not able to relocate to the top of memory, nor decide what
other parts of memory are used for.

For these reasons, the EFI app skips relocation. It is not running at
the address pointed to by the _start symbol.

So disable this reservation for the EFI app.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v2)

Changes in v2:
- Expand commit message to explains that EFI_APP skips relocation

 lib/lmb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 588787d2a90..420eae4d0b8 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -560,7 +560,8 @@ static void lmb_reserve_uboot_region(void)
 		lmb_reserve_flags(rsv_start, bank_end - rsv_start + 1,
 				  LMB_NOOVERWRITE);
 
-		if (gd->flags & GD_FLG_SKIP_RELOC)
+		if (!IS_ENABLED(CONFIG_EFI_APP) &&
+		    (gd->flags & GD_FLG_SKIP_RELOC))
 			lmb_reserve_flags((phys_addr_t)(uintptr_t)_start,
 					  gd->mon_len, LMB_NOOVERWRITE);
 
-- 
2.43.0

