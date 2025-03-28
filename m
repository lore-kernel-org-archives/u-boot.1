Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56270C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 15:38:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B27628205A;
	Fri, 28 Mar 2025 16:36:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Dsx25tjI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 261BE809A5; Fri, 28 Mar 2025 16:36:27 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5E3B82047
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:36:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3cfc8772469so7902855ab.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 08:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743176182; x=1743780982; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VhmvIN4WWJOa7cUwk1WZwXHB67IhYJS6uPBPTobBPAw=;
 b=Dsx25tjI7fBGc6xdPnkGfkmV0NxT/TbSOxNVC2l054FbBdF8E80rhsTvbiVCe7eXnb
 gAJQQP9drYFiAjyQBZ2CN8mQv/eNoYhE7EkDIaFTJ7d0TuPOLsU9SKhBGLI0IQP+gKSA
 akUnIbEKK46dJFAv8j0ft2FnAmSDILWSyv6O4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743176182; x=1743780982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VhmvIN4WWJOa7cUwk1WZwXHB67IhYJS6uPBPTobBPAw=;
 b=GbU+xjlCw9LHzhSswcIAslgaTVtu7OPyv1iYaz4E6ClJY/q0fmrXJk6ZBWa9wpPzJU
 iilmeoAfcUolHBNyubJF2lA0+oGnmMQPHimbsejbC96MS051ss25DyTaqd8OrFRysYbH
 gWch4VAYhrhJWZbW0srfyb0kLO8NtMm6kIgFNYvb0GRQf/k5TzjOcO1rN/bB2Eeuu0+1
 mwHhZfMuq/N6fR+TMNB/eWtICaIp2J56Stt4SQLntWyjOhE6gNiU4ARlDKaolB6RRX4A
 CMsrM+yKZ7gyHbraRQEFGULr6aWJercNoiST8yG28x43Sk/bsUJHx1Eahlsmc7AbWdNw
 wp9g==
X-Gm-Message-State: AOJu0Yxd42XOQc89ogjIuNIa0l8lAHnNHG7KSsYiTiRCAuT7mvBRbBUA
 +ypAeBoxy9zFByOMKB7jWypFq2UNCzgGIGQQ5K94Finw/TD3T06VCEEhUtWOKRtmI1yvHwJiMWY
 =
X-Gm-Gg: ASbGncvnuln1/OXEPTXhCP4gPG/oHHgsMyrlvF/j8NFnOZGZ/SpwRszt8OR7Kvpjuhg
 jZZxdj0fBMdnlK5+rfIZlEEifihxuLLwEkf6MgxY6hClPZiotBLLF4CGLFUYXdrSzt5hVxpgU/5
 ZS9QvJR+EVLpcABO3zaDtehnbDGmJ0bcyx03S3VxULLPKCZ/QT82rw0KSvfyeC6MAII5Cq/U+qa
 1+H0426umxP0ngGV0T8z9OeVZfJ73mtAShxkoHQwhBi5Lo34VfB6yEjL8Qo8EQUX5fkwgEWfqJl
 JqvfY/thJi+7nYnydJGOl1kPCMsX1rvFCaosWy19TpziLZoXah/2QVPdFU3Kk9RiQMy82ifmOAx
 BH++z6A==
X-Google-Smtp-Source: AGHT+IFAbN1uTJ1cVnxVjgHduNgrxkSeto4Otz1XaYnkD0WoNgmJ1rlH5noiBZbHl7S6mqNeTYaQzA==
X-Received: by 2002:a05:6e02:1526:b0:3d1:97dc:2f93 with SMTP id
 e9e14a558f8ab-3d5cce2477bmr89062645ab.20.1743176181823; 
 Fri, 28 Mar 2025 08:36:21 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f4648714b4sm484922173.87.2025.03.28.08.36.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 08:36:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v3 21/31] rockchip: rk3399: Adjust initial TPL-stack to match
 SPL
Date: Fri, 28 Mar 2025 09:35:01 -0600
Message-ID: <20250328153522.3555472-22-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328153522.3555472-1-sjg@chromium.org>
References: <20250328153522.3555472-1-sjg@chromium.org>
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
index fc55b498111..8064b6286fc 100644
--- a/arch/arm/mach-rockchip/rk3399/Kconfig
+++ b/arch/arm/mach-rockchip/rk3399/Kconfig
@@ -159,7 +159,7 @@ config TPL_LDSCRIPT
 	default "arch/arm/mach-rockchip/u-boot-tpl-v8.lds"
 
 config TPL_STACK
-        default 0xff8effff
+        default 0xff8eff00
 
 config TPL_TEXT_BASE
         default 0xff8c2000
-- 
2.43.0

