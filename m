Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A86F8C021B6
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:08:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8F77807B1;
	Tue, 25 Feb 2025 00:07:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KC3pSOu2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E488E810F9; Tue, 25 Feb 2025 00:07:29 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75440810EA
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:07:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-855bb9fa914so141510639f.1
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438445; x=1741043245; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HwZftk/aTnNkPL5O9M5ktbrIo6H+d1lHm0/nJzAEbYo=;
 b=KC3pSOu2pqix/4RlEf8Wz6X7NTcBfQdk6w5kB9B7eZd4PsbRuB65+NoPGOQyGZy6F1
 naBn4STCC4lvjBcAT3UkDtBMT0291z57m5AQj9dPDHpF6zH/CL6jJckZBIAybJ3P8xKf
 tYtrUpr/EEHkb+NEO2L04JPBK5kQGsR0qRWBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438445; x=1741043245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HwZftk/aTnNkPL5O9M5ktbrIo6H+d1lHm0/nJzAEbYo=;
 b=tMFy0Ym8cTXzq9ZjBj0IhPkDM3UF7ACK+EkjmdJQKoOIfF9x3wuIf6jtur3rxWWeQI
 4iEI15d1f3VAGVPwiMWy0ku/3ZL460ndz2VSysJgvIeKlEL9Bl6ixLoOSYG0IzT2aiWZ
 wGJzxw18AbQQXmc5yBdyl2ejgCq0DZ8HqBE/sfHqJnu9xfnl0oi5Det2fLymdTOQWHze
 eKUrtTpgNuYwNVP4SM6MnWpOMs8yE4JjZ10d5KGvq1hkih5TW3ItaBP7h3Px7kxQsB76
 +o2JfeZDD7MDEXHGDjrdp+HklP8p8Z9M8NYXHzRye3+8cksSkNRdVKmmVjnlRLlEN03w
 NeIw==
X-Gm-Message-State: AOJu0YxrK13+nbwik5i6Xj7AdGndp/Fzu4BXKOigFFq88Fl6T/L9K/6o
 1qHpwEP1iU94T/ZBeCQtaBC8fCkDYLBMOW4If7Q494fXnM8Wit/H7CMv2jPYeYu71oOaYFtigMQ
 =
X-Gm-Gg: ASbGncu4Ymst+/ftTvhhDJIvpjBTFE8OTvfzC9ZIFZ80Q0bpEmm+EwjtwS4CDRBOERJ
 JDg6axBp3SwMJa2jYwlrTsebN0TCYlp5FaOoxOB+ZrW5uG4Rmtcc5bIITsbuNZLd6KFXYOOrs9A
 XYAyzJMXhZDMKVeoEcnTxU8Sn/UOKiAc1ngnmweCRbytI0GCQ7u7dfJYP/qeHxMnlan6O802I4O
 YLqCDVF40Vje7GkLX1/ulvc4Vh3+9n/Dz1v7kQYhuWPn2seEtinLvbfgqWFzWIHTRKmrC39UUp8
 93fytDfVqk/h3RKa1fZ+V48fG26cODCngAKTkAe5y//1BOu+OjTzD2VtPyQ7mEU=
X-Google-Smtp-Source: AGHT+IEssRe3y5o+VvcGIzGDg2w+osO3h8lE7hAkMyoy3P1TWn+M/s0iwAzudFhqvXy1B4G5434d9Q==
X-Received: by 2002:a05:6602:15c7:b0:855:bd9c:7173 with SMTP id
 ca18e2360f4ac-855dabb8685mr1536274939f.7.1740438445671; 
 Mon, 24 Feb 2025 15:07:25 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.07.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:07:25 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 13/44] x86: Include stdbool.h in interrupt header
Date: Mon, 24 Feb 2025 16:06:02 -0700
Message-ID: <20250224230640.2665206-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224230640.2665206-1-sjg@chromium.org>
References: <20250224230640.2665206-1-sjg@chromium.org>
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

This makes use of a 'bool' type, so include the required header.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/include/asm/interrupt.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/interrupt.h b/arch/x86/include/asm/interrupt.h
index e23fb2c8e72..c689fc23d08 100644
--- a/arch/x86/include/asm/interrupt.h
+++ b/arch/x86/include/asm/interrupt.h
@@ -10,6 +10,7 @@
 #ifndef __ASM_INTERRUPT_H_
 #define __ASM_INTERRUPT_H_ 1
 
+#include <stdbool.h>
 #include <asm/types.h>
 
 #define SYS_NUM_IRQS	16
-- 
2.43.0

