Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80962C47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 15:16:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C583987A28;
	Thu,  4 Jan 2024 16:13:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CmOTmuxv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35E9A879F8; Thu,  4 Jan 2024 16:12:53 +0100 (CET)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4AA187A18
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 16:12:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-35fc6eb9075so1714525ab.1
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 07:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704381135; x=1704985935; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GBavvFMPt7fAg13eX7sw/DuOPuXx74Hiuh7AEsU5uVw=;
 b=CmOTmuxvNx3XmBT0rKuSpPShEprEmFQ1B8N64QejWR3gXtPH19Aud9S5OKA9zRTX4C
 TBKcMkinCyyPL1gSoQUuJHNLpwvzkdZJhUEg6u9gKBSm4BKAZTanBuoWX0A2Z5vjmdeY
 dt/4N7hvn848dNdnp+A9oOwnUe5DtxUO91C8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704381135; x=1704985935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GBavvFMPt7fAg13eX7sw/DuOPuXx74Hiuh7AEsU5uVw=;
 b=eg4xEHnjw+PF5CxBjxmj4SgzFfkl/XwDOT1IJSPkWRx8qkA72J4eeOTg0uO3EkrXT6
 15vcMXkVrxlfdu+Ce8lJ0CedoAE1viQSxLTVhcydQvZM+BdgfHFs+5rQA7RG9n5lglWw
 0EqTW13DmdbQgKrqPXN0ABeCwTACHyqs2/Ah7F59u2/4Qws5Q/RkTQ8PU2rFPUVnrH/P
 uUamurb2/KV2X0B9G+2XA0ML9chIfOmHDaAj9+7XWQAAZwGLHph/11Pb/77vfruPE/2R
 jrUpW5sNn02PhpOpOQ01CjGm8YAqHmW0HlLXzgP7w+F9luReU9dmHRusaLPUewXyCWB/
 vy7A==
X-Gm-Message-State: AOJu0Yz4zKV/OfcHB2cxpCGLhfOwXpl3/aqLOT08diiH5Fs9WpANd5jh
 G9IW2HxwmCtSqN5GK5NVqJdS6fe70LWjYePVYc4RMGchUbCn
X-Google-Smtp-Source: AGHT+IEz0Dsq+sLsBB0qRdqc+FiQqahUMfT9m0ERcRuDFMmHj++rENGBkpiADfrE3yk18D6hZrfJlg==
X-Received: by 2002:a05:6e02:1a63:b0:35f:b61f:a8a0 with SMTP id
 w3-20020a056e021a6300b0035fb61fa8a0mr492167ilv.13.1704381135254; 
 Thu, 04 Jan 2024 07:12:15 -0800 (PST)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 cv4-20020a056e023b8400b0035fb79100cesm9260742ilb.59.2024.01.04.07.12.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 07:12:15 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v2 19/19] x86: Enable RTC command by default
Date: Thu,  4 Jan 2024 08:11:52 -0700
Message-Id: <20240104151152.697855-20-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240104151152.697855-1-sjg@chromium.org>
References: <20240104151152.697855-1-sjg@chromium.org>
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

The real-time clock is needed for most X86 systems and it is useful to
be able to read from it. Enable the rtc command by default.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Rebase to -next

 cmd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 2386f4cf3bc..8423277c542 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2193,6 +2193,7 @@ config CMD_DATE
 config CMD_RTC
 	bool "rtc"
 	depends on DM_RTC
+	default y if X86
 	help
 	  Enable the 'rtc' command for low-level access to RTC devices.
 
-- 
2.34.1

