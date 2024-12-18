Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E74FE77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 07:04:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FF438021A;
	Wed, 18 Dec 2024 08:03:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lvVyOe2w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1CE38021A; Wed, 18 Dec 2024 08:03:30 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F257D80243
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 08:03:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso43998275e9.2
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 23:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734505408; x=1735110208; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VHjfhKSufUxe6H0UxS/zV+U31aw3+THDEM8QQrvPjqk=;
 b=lvVyOe2w0L/z2lG9FSQ9dcjebFuoPPFaLCfMWcphLAtFMfmYMnZwp5k+eNxlG4T56R
 eGRiVYntn66xEWmKqKZT+b4/hFakiPuhhX6O0kiX0cTizlkE1+WoIF1V9fi+gmaVOhUz
 ccB8BCaxUbrHj/Zt6zOV4tVnOiybdMj3KfNOXxQ7cgyH4C+ubY3CjTqyeXWhA+Eutt1X
 sYUCwJhv9f+29azziW5haMJC4xJWrGGeXus457f41qQpZoIyEzjFOLAi/D5WaARZF70A
 mhF7/qdfnXEF69c6SKLtXzoA7v7Fu18cbBtYE/2wuWCvCtXgtpH/ZugN8Xw9PYelnV56
 jqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734505408; x=1735110208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VHjfhKSufUxe6H0UxS/zV+U31aw3+THDEM8QQrvPjqk=;
 b=tQwBEQN6grY58GDjaFyBQ9yIRASfGvCWGn44lL1qfs52BWaMR27OuCL+gB7UTGArhL
 Kmr3cFYZhO3W9DNUtdbQNIGE+tO7BMYfOZ/OPgjUtSRXwOy1OAMBTHSWpo6udZAbx/iH
 5I2m86XnYoTm4QuVz9uxUPBnvLjD44IFOvOYLBT5TTmERIMIC9aaI8EStgWFJpvTMlnl
 pz3y3jAeDWM9GmPEKKOcEm8ZkX/O3ZZxOSwT0KqsYMRTqmtnJeLC0tBlcuhUt2+Sc/w4
 b71tttfxOgPLMX/vkaDTEDcCK7tQJeNCqsQyQT8HHjVLAEge9QdCfRRaYSLbmXVgltQT
 PXZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyo9SgEmRcpr2f6Q52cymsSNI901/bCsjAHQWwEZMpvzxibO2R8qzjLF1qEXBFqtyyHTHnvU4=@lists.denx.de
X-Gm-Message-State: AOJu0YyBU8Yxrua0Q0BOYdpC7MutTLIINbFq7FLq+JHDj6GqS46cusFY
 dZKg7u3cOT/epRIEQPTcQq1Y5tgJOvtulqW/4QRzT73Ct9c7/oYeYNpQRJIZKXY=
X-Gm-Gg: ASbGncsd3n0FSjHN4Xy3f5/IoUVDHHkbF6hQreyx2jSY9bX4iL/V5gw1XAUmTZ8YhlN
 UtRTFT5XG13sParM/ubx5JhRqxIXoxFA3cI546zwyyVNcAvM06N2Ne1kKdPHwQ1B8rmB1tu1bba
 G6w6FE1ZvKRHe1+dpzolw0H8r6bkq8/CGJHwO3ZKs3/B8WUdjJb4BIZ0BCkPdUFpFgxhVQ354qd
 7NAicEWo1VoNjPmcjyKbLos1RwL+X/AL4PCHDLh5iBu+paDw6ZkGf+hNkPJNm+hkv0mO3NYKBW/
 JN+ciMhi+uWnBD6WphQNUKxH7ZKPgGgc0w==
X-Google-Smtp-Source: AGHT+IHbJmmJa61ujOjgIBb5c9nH7ax4FxTjFKcxTOzHZ1+G00icRZjUVfJ0WM7bOMwGZdxKwMzzDQ==
X-Received: by 2002:a5d:6c63:0:b0:385:d7f9:f166 with SMTP id
 ffacd0b85a97d-388e4d424a7mr1428060f8f.17.1734505408269; 
 Tue, 17 Dec 2024 23:03:28 -0800 (PST)
Received: from localhost.localdomain (ppp176092181030.access.hol.gr.
 [176.92.181.30]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8060592sm12971612f8f.98.2024.12.17.23.03.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 23:03:27 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Walle <mwalle@kernel.org>, Peter Korsgaard <peter@korsgaard.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Nam Cao <namcao@linutronix.de>,
 Janne Grunau <j@jannau.net>, Prasad Kummari <prasad.kummari@amd.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v2 8/8] lmb: Rename _lmb_alloc_addr() to lmb_alloc_addr_flags()
Date: Wed, 18 Dec 2024 09:02:37 +0200
Message-ID: <20241218070251.686383-9-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241218070251.686383-1-ilias.apalodimas@linaro.org>
References: <20241218070251.686383-1-ilias.apalodimas@linaro.org>
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

lmb_alloc_addr_flags() is a wrapper for _lmb_alloc_addr() and it's the
only function using it. Rename _lmb_alloc_addr() to lmb_alloc_addr_flags()
and remove the wrapper.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Tested-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 include/lmb.h | 2 +-
 lib/lmb.c     | 7 +------
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/lmb.h b/include/lmb.h
index a0e666a1f7c3..d9d7435a431e 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -125,7 +125,7 @@ phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr,
  *
  * Return: Base address on success, 0 on error.
  */
-phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size, uint flags);
+phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size, u32 flags);
 
 /**
  * lmb_is_reserved_flags() - Test if address is in reserved region with flag
diff --git a/lib/lmb.c b/lib/lmb.c
index bdaaa634abd1..7ca44591e1d7 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -748,7 +748,7 @@ phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr,
 	return alloc;
 }
 
-static phys_addr_t _lmb_alloc_addr(phys_addr_t base, phys_size_t size, u32 flags)
+phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size, u32 flags)
 {
 	long rgn;
 	struct lmb_region *lmb_memory = lmb.available_mem.data;
@@ -772,11 +772,6 @@ static phys_addr_t _lmb_alloc_addr(phys_addr_t base, phys_size_t size, u32 flags
 	return 0;
 }
 
-phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size, uint flags)
-{
-	return _lmb_alloc_addr(base, size, flags);
-}
-
 /* Return number of bytes from a given address that are free */
 phys_size_t lmb_get_free_size(phys_addr_t addr)
 {
-- 
2.45.2

