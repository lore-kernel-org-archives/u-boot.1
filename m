Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B64C3ABA3
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 13:19:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 770478210D;
	Thu,  1 May 2025 15:19:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QMZSIQfo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3758581F7E; Thu,  1 May 2025 15:19:28 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 116C080F03
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 15:19:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3d4436ba324so7981765ab.2
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 06:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746105564; x=1746710364; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YNqW8B2J0acepxbmZ3a9weM8IlAJ0kxYnYWGbBfDA74=;
 b=QMZSIQfoB6K1Mm/sGIUJhG4oZ8r7GPehpSnQfxXotHx/T53bgd6LLIoqGK0LpnXGyL
 kP1I9MGCBA1jm6ez804pSjaCc4Ex1EWcoGkncpOIpoqsfk76HPRcucP2NWO2o3JmDEZM
 s4EC8CfD9OMjYUBwWAoBJ7R42+YVMn7fgIuqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746105564; x=1746710364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YNqW8B2J0acepxbmZ3a9weM8IlAJ0kxYnYWGbBfDA74=;
 b=R7tln/lp2C02GenexfEaQsT5QEgoTPzaQvkssa8YKk8LIIao9ophZcL9PjeG2uL5YK
 9iu8+mBn/CSI+LAeXLpd66eM1wlYNK+Ey0M77B2FL7QUvv5z663cQ/XpIZryvw1pv7LE
 11AxX16DEXjqiCuzvKJDOXeH7GUqPd/g/UX9K1S6BoTRH7Y8e5RSEbHWyl99Y7g1vaK4
 c8SwAVdCx/HPigJqG714qYq4gT2/528Dvu+AfegLgnWC2JiMtyNoGkOS3torjDAwmzpQ
 EE6mieeypJ8MuAywLuK2dooHozBh/+FnRo56o2C574CPYwenUtW+4H4pPMQOc9anSEjZ
 1pwg==
X-Gm-Message-State: AOJu0YyH44W6fKdy4+/KMxk5uSZshX29MZij2H+Imb/bweA4MYBM62Eu
 Sz6KRc5zOChTiwLYYyxQ5pQrzG/EXU/LbH9/+VgY256vkotGn+2UdWrtHpPY7wIYxUav8UeSAL4
 =
X-Gm-Gg: ASbGnct6ZXe4rNmvvLrFw5PmOnoTUegNvQH/Z0NC62c+Zgfz+n3+8w40l3Vl5h3eVkc
 5+AuhoJBy/eH+t7eJ8DUyrmI8ucixIv2Srjz4MjjuTJAaSjDHdCdya6GyNPBpUDxNLrf8DsrXUX
 LDVO+Q2dQqojNfKP/Fjv0154k9TBFxXvhR6zW61X01Q+TNVTvkTZbokALdmrpTUYvBomyDxzi1u
 1zTa5+2F/73xXgk01kljzS+HI+ih8dkT7DniDA063xdsjrSHEP4Yr3JhkBGeW4iOMw6F9/VwniZ
 L8WGL1pN6cLBVSw+kswLDhzhsjnMPxd+CssZdNOGQXXnCIH+GJ5BQ/C+hCENHlpQQMhtIL7k7WI
 j/g==
X-Google-Smtp-Source: AGHT+IGiy6p/aKPOEHRhsCQ73xnC6y1q+dI/rNDRpnd+BF6VWII68AspRb1OXGTOx+5TT7tCPnGWzw==
X-Received: by 2002:a05:6e02:b2b:b0:3d4:3fbf:966e with SMTP id
 e9e14a558f8ab-3d967fffc58mr68052535ab.14.1746105564277; 
 Thu, 01 May 2025 06:19:24 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f882fc9c2esm160328173.93.2025.05.01.06.19.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 06:19:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 2/3] bootm: Add RISC-V support in booti_is_supported()
Date: Thu,  1 May 2025 07:18:34 -0600
Message-ID: <20250501131858.2160756-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501131858.2160756-1-sjg@chromium.org>
References: <20250501131858.2160756-1-sjg@chromium.org>
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

RISC-V uses a similar linux 'Image' format to ARM64, so add support for
it in bootm_load_os()

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 2ed78295ead..7be5ec796fc 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -666,7 +666,7 @@ static bool booti_is_supported(struct image_info *os)
 	if (!IS_ENABLED(CONFIG_CMD_BOOTI) || os->os != IH_OS_LINUX)
 		return false;
 
-	return os->arch == IH_ARCH_ARM64;
+	return os->arch == IH_ARCH_ARM64 || os->arch == IH_ARCH_RISCV;
 }
 
 static int bootm_load_os(struct bootm_headers *images, int boot_progress)
-- 
2.43.0

