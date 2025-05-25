Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E29C54E90
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 10:50:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE6F38369D;
	Sun, 25 May 2025 12:48:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JCi6uo5Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB94582CCE; Sun, 25 May 2025 12:48:34 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A0F7836BE
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 12:48:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a35919fa8bso431495f8f.0
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 03:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748170111; x=1748774911; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2y9yBTk/zUuYxbsGTKShF3SU3q7cB+8Yyo6WOvn7br4=;
 b=JCi6uo5Qouhg9Uiuxkdxe3l8bbqdkD45/T6hnwW5tG/elMeNFjxIebn5JeJ/k854T1
 R21D4nBUVRiCX5BJN6Yg0aDlDYPFTZvWMJAE9+K3s1Rpc5DIwnhMFlJGxeMVnB7Fsf+0
 a0TEK8fszXoKfZEH23747rjZnMI3OfQQrytlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748170111; x=1748774911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2y9yBTk/zUuYxbsGTKShF3SU3q7cB+8Yyo6WOvn7br4=;
 b=LMGtCgIujEQ/vna23/DrYv6/zCK44XUqzWrgw00KFNEHxWhpRJYkkJjOdHGpXgklGh
 J4n9fPBSr32jbqez0gBYnMV0OglzjivZJ9W0DOtEmgAxYxW5y3MiBxoIa/6u8IltgWAn
 bfgWnABK00GW0yoUsa7MhbW50XnGH6QA8qxmB5Sr1ymre6+6lhvYdsGrfwtilMImS9Gi
 3bF23aW/+wNKQqa6BgbHHU/dd15WOeBhAWdg3D7yCK71tQ7XdTVBoscTpqRKprL3aidR
 mcsnFVfyEbKMw25yydzsxl6AqUt4WXMC87TkVGJ6We8TmSeUG73M0YrHpb4SLskddpfv
 LHVQ==
X-Gm-Message-State: AOJu0YzCzvzyDqAsSbPA/OquJJ+KOvnYZIa7Oq/KV8kQ6QDZjxXspo2s
 LBKATJSWgNpR+3T9W5cc8NK0PsIsFsHhfEQgBG1V5NHXCsOS+2g2ceA/qfSd67+8OzlSnoozQGH
 cJ3O95Q2m
X-Gm-Gg: ASbGncumU4Ws/FMJbW0x7H31dF/Ho5n6YgW+9adOcURdmtwMxeh5sQFvCNKXnSWpwaC
 mFtPykgXdlWB+CX5PgFTvieMUW2Bmzzla3i2GvOQLv9ne0Rnj4QX+hj7994YSkam2mrW18u/HEe
 Y7mgNnn2/NqnX96jRUYCg1p6kLDXss67eBeVWAI/2vAXG4oatTsIUC5UkKq64m2YFRydRZE2u/1
 FrHpA+u6zEVf98M1b8kiJPd2fa6V0MXgkvK6A5o3Ik3WBZodxrWrRpUQc+vsqy+ELrsXv/f5M58
 0BPq+4TTMi2loaTLdtJuVpMpKV63GKUG2So0u1blPYcBVMqKoeX99S3tDHoIPNKwXygSGdYM/Mt
 4kPVoGw==
X-Google-Smtp-Source: AGHT+IHRrzNqVvSGPCaIbW5Qc/v2wAgozCaYid2LTCtSiI4pQdTEMLtqLLdUDxbJftRSN9ArN9pUrw==
X-Received: by 2002:a05:6000:2288:b0:3a3:71c2:f753 with SMTP id
 ffacd0b85a97d-3a4cb44630fmr4959146f8f.34.1748170111604; 
 Sun, 25 May 2025 03:48:31 -0700 (PDT)
Received: from tasman.. (host-80-43-238-15.as13285.net. [80.43.238.15])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4cb450867sm5045047f8f.57.2025.05.25.03.48.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 03:48:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v4 15/25] rockchip: rk3399: Adjust initial TPL-stack to match
 SPL
Date: Sun, 25 May 2025 11:47:51 +0100
Message-Id: <20250525104801.1440260-16-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250525104801.1440260-1-sjg@chromium.org>
References: <20250525104801.1440260-1-sjg@chromium.org>
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

There doesn't seem to be a good reason to use a different value for TPL
than SPL. Change the TPL value, since it allows a 256-byte bloblist to
be safely located above the stack in all phases.

Note that for most boards, SDRAM init happens in TPL so the SPL stack
ends up in DRAM, at address CONFIG_SPL_STACK_R_ADDR.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Reword commit to mention comments from Jonas

 arch/arm/mach-rockchip/rk3399/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/rk3399/Kconfig b/arch/arm/mach-rockchip/rk3399/Kconfig
index 7b2d47fcb49..cbe718a428a 100644
--- a/arch/arm/mach-rockchip/rk3399/Kconfig
+++ b/arch/arm/mach-rockchip/rk3399/Kconfig
@@ -145,7 +145,7 @@ config TPL_LDSCRIPT
 	default "arch/arm/mach-rockchip/u-boot-tpl-v8.lds"
 
 config TPL_STACK
-        default 0xff8effff
+        default 0xff8eff00
 
 config TPL_TEXT_BASE
         default 0xff8c2000
-- 
2.34.1

