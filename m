Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18DE4E77180
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 13:57:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B9A980352;
	Wed, 11 Dec 2024 14:55:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ixaucxXl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F3D98031E; Wed, 11 Dec 2024 14:54:58 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37F0E80330
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 14:54:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3a8160382d4so18842845ab.0
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 05:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733925294; x=1734530094; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8nEQ/vQpSetEU940s0Bp/unPvaMzfsX5NxopejGxkxI=;
 b=ixaucxXlGWa0IxX/xZUIDzQ3Ovu/xJ2Vm8t5hIGBxXD+8ebArxlJPckV1x9uJCgqlP
 UuHIpX5OjILuggYi+Fb7L4lGX8Dj07ysam81FfGyddiPTZk5faiaobQc8FGX7Cqlumrl
 +R3xA+8yYGG/1SvSUAIlmKsQQBsB95aiRt8LE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733925294; x=1734530094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8nEQ/vQpSetEU940s0Bp/unPvaMzfsX5NxopejGxkxI=;
 b=XfvjVj4rAZmcemFcMyiNh0HG0891qAiqRWJiODVYT/JqLXjuw7XWsC0U6hNz2BFwYk
 OuxlcTt6bO7p8hNwNCgMUiO736aC25dKZylu8nAUDYPsJE8VEe3N4c8e5PtAWJZTThUv
 xA8O4Ce1z3tSUjGLWpq647iwdowTIjmM3U8nFTNowv2N/9maKI6axvTztskDyOrBg+zw
 9zcq4KZcFa+67kY6hD4+LleUwTUNxuliyKJSrPRxL9G1O2idTrbSUg3nNhcrojW4mBbI
 faERdU/t+xOMIbcwbMn5gZA6lvYf45h3KP3HdLY2LXn3mV/OeXeJTMojew1hHDQUctMq
 prZQ==
X-Gm-Message-State: AOJu0Yw/7f0NrZXl2q6sCkiysZ4Uwlwkt9maalpW1PU374kTrdNu821D
 wkJgh3KpUIZP8KHdENXA3DucQL4bzeq3KeYriVU8aAseMnd6d2gIswoP40kCOAhUwyogDEz6FaY
 =
X-Gm-Gg: ASbGncuDu0SN6tP5KrrzBw67c0R5tDi02Ya6vArarglxO8oii1xbvloIIiYnoM3LieR
 PEnTydW7JMHNno/YgR92ja1weB7QtkZ8XD+zUM2yVgm6fZMbeocGrhMgTwmsKZebxDCygDBslWl
 buQH8p97xHKsLaVmC1HvdOP5ziM/Er0EmPbA43Y3dxjwsUnts7SIuFrS6O32FaJOyhKZTK1fi+G
 2vkt9R+I6laBRARUCEfat955s/j/t3c7DNdbDA1iNdzkn7ub7jgwxy5BMwYFz91yCFTY4OQiE3h
 Uxjv38IxRHGuIhY=
X-Google-Smtp-Source: AGHT+IFyBDeLE4cm91DBDA8nuoBOoZkcWqQEoht2G4tglQUqtHoMfgtbYoB3u/rw/V9uZpMRskCCWA==
X-Received: by 2002:a05:6e02:12e4:b0:3a7:8720:9deb with SMTP id
 e9e14a558f8ab-3aa06dd7230mr27759785ab.11.1733925294133; 
 Wed, 11 Dec 2024 05:54:54 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2d46f66f0sm695441173.30.2024.12.11.05.54.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 05:54:53 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Janne Grunau <j@jannau.net>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 17/23] efi_loader: Show the address for pool allocations
Date: Wed, 11 Dec 2024 06:54:11 -0700
Message-Id: <20241211135418.563803-18-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211135418.563803-1-sjg@chromium.org>
References: <20241211135418.563803-1-sjg@chromium.org>
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

When logging pool allocations, show the address of the pointer, not the
pointer itself. This makes it easier to debug with sandbox

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v4)

Changes in v4:
- Add new patch to show the address for pool allocations

 lib/efi_loader/efi_boottime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index f27b3827ed2..47ed22b1d9e 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -533,7 +533,7 @@ static efi_status_t EFIAPI efi_free_pool_ext(void *buffer)
 {
 	efi_status_t r;
 
-	EFI_ENTRY("%p", buffer);
+	EFI_ENTRY("%llx", (u64)map_to_sysmem(buffer));
 	r = efi_free_pool(buffer);
 	return EFI_EXIT(r);
 }
-- 
2.34.1

