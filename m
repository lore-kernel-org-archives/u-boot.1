Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE112C021BF
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:07:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D55580FB6;
	Tue, 25 Feb 2025 00:07:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mx+UFTN5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 246C780FB1; Tue, 25 Feb 2025 00:07:10 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F36AE80977
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:07:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-855a8c1ffe9so147559239f.1
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438425; x=1741043225; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kkUisr++RVCj0iT98bJ+JIPBV1uE2F7bmbEsJn6hXDg=;
 b=mx+UFTN5pKLSW5IYw0BdIlEijd0eksALVA1ywU1AfVyeK5NrA3eOiioYLG/Hh6R3AV
 zXEZ62pmTppKdlmxMH0g2DVlUpAiqIc2FEk9RaqJWnMj61HQHCcDlVSn/Sp2mEa8/5qq
 Qvn9mSzgJ1dxd9IvozTBIHVLqStgXHx7vbAHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438425; x=1741043225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kkUisr++RVCj0iT98bJ+JIPBV1uE2F7bmbEsJn6hXDg=;
 b=re8Ltxz/zSnnTGi0RHUMgEiOvGtvhVOOIOJX9ylubGWrxQ73k65Cf8rpP4Zp0K5wnY
 NcIzf7UcgnZWEf/JsVip1usBdtnLggynWT0V3foYSPNDONfGLC3gZnRb25L1SefXPGrH
 7w0CnRhn56wOwoUJhv3NmbuDn9gwYQXNK0MDLxiMnLIbW/oS2y0v5snm4oDmcwuEYRlC
 VHOUnVQW5kzQfhcjpWOzdpfild/PByPlfz/Zr9HWGljSc+jd6KP+qulXEMT31PzqKZ2e
 Df6qmBoQDZoRVx/7QpS7CRo0zjaqowAnhT97S8E3EFsQ+Y2uCPmmrx2KmEiIxlbX3Dif
 3Nhg==
X-Gm-Message-State: AOJu0YzULFgbFjCxF5bXl3vi9ZvER9lrw294sdtZZ++elK3b42ioa/VV
 67r/TSX/2SVEuaM4lPTlp5mAAzcTVPgL/poFK0k/YSfS22BnLTezLgcfvuasESYLeRqFQheVj0I
 =
X-Gm-Gg: ASbGncu1hU3Nx8QQAl80Y1G8av4ARjOXNMq6k1k4kYUCiRL0NsHp0Ds3BmyRmZ2sHz0
 EmBIBJZdMQi6pbsX9FoBA8ZGO5DUInMgEJN9AkGuHfrhWy5cz+qdHrTsX+j9kGJIkdObBEr3KEQ
 q5TK52iOl3E8d3mW/4hR7tS6tz3/aryRZKwlt3ydzDS9uqFhqhmri7ysmZ5QcqnK/422PejTWqe
 XIcnj0Fpl5pLiPkMvFGPGwhEeMiEXv8I6JMYoUCuRjEUTrYMEQvqVjx4CF7QRgWCM5KbzGuyzDK
 3mzORSpbbqGJv0KOvDZyJwJAkMwi4idfgNvduPLAN1I/6IZi3HyM1b/b3uJ5YYw=
X-Google-Smtp-Source: AGHT+IG8PQQeNhFMzNKisnJL8SG+/t/861GrPiXLxHZ+7l5lCjRCfJ0S+0urVkGfORCC4vBK9hbLww==
X-Received: by 2002:a05:6e02:378c:b0:3d0:bd5:b863 with SMTP id
 e9e14a558f8ab-3d30488e755mr13673545ab.20.1740438425661; 
 Mon, 24 Feb 2025 15:07:05 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.07.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:07:05 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Angelo Dureghello <angelo@kernel-space.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 05/44] x86: Drop mpspec from the SPL build
Date: Mon, 24 Feb 2025 16:05:54 -0700
Message-ID: <20250224230640.2665206-6-sjg@chromium.org>
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

This is not needed in SPL, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/lib/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 43e6a1de77d..a908356e8a6 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -26,7 +26,9 @@ obj-y	+= e820.o
 obj-y	+= init_helpers.o
 obj-y	+= interrupts.o
 obj-y	+= lpc-uclass.o
+ifndef CONFIG_XPL_BUILD
 obj-y	+= mpspec.o
+endif
 obj-$(CONFIG_$(PHASE_)ACPIGEN) += acpi_nhlt.o
 obj-y	+= northbridge-uclass.o
 obj-$(CONFIG_I8259_PIC) += i8259.o
-- 
2.43.0

