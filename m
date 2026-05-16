Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92B9CD4F25
	for <u-boot@archiver.kernel.org>; Sat, 16 May 2026 07:40:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F99E84676;
	Sat, 16 May 2026 09:40:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="U4pu/tbZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8164D84674; Sat, 16 May 2026 09:40:41 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59CD38407D
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 09:40:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-367cbac9cb1so550872a91.3
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 00:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1778917238; x=1779522038; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HmODbzpIgNWftmjumOttYR+kcGbyKksY7RoAcXsw1Nw=;
 b=U4pu/tbZqBdikPlaES0DNH9tQpTsFRKxW+kn/mTjvve1ArvGdU9lDGvXDJjFj1CK5Z
 7dT0IOCRx/QjFzQO8ar2eyavSuXPKRlnHkuCscBKu4UdaXhIyqiYXvQpCxNgO9W6ldyO
 iEDfbASxM7YW89YK5zLGESYag3DHLHT/wmfA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778917238; x=1779522038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HmODbzpIgNWftmjumOttYR+kcGbyKksY7RoAcXsw1Nw=;
 b=HrgZQ/EMLtOGU/0r2GV/NXPUAJjA/e/YQhFfoHadhB7zIXqF7rK5fUrp/g2LpqBF2S
 L95ODumKHuiF//ZhYPuMUrwgF32CAu9itD2Jl5r89/I7AT/D66t1IIiHkbDjVuQyUcXe
 teAlhRPymehuApiZknL7+vbieCOOaRI6x2mSHxDkL3JUgvwqP25Fqrt/xD/wKE8TyoGz
 Hpnq4tcAtlCYFQGFUn2xbeGWmxd4XwnZVuKL7vhjPMexAYppJqZGbavWwmhx8kJyTiP/
 VSdSBPU5vlbhm8dtxMUS3cOuosWmb8kw0m2TTnWQ9ZDtoYBMBbWp/AghaEbdlVCndTde
 KxQg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/82VVXLm3mEknlUBVlTbG3MgPcrXbLHZL9kok/aPlmmerQd/3vg7ZAqq6pjwi8FLUrDhRvkHU=@lists.denx.de
X-Gm-Message-State: AOJu0Yx+KaIdaJcLcAjy2EVY4kR1cukxMUHrMj2EvWDiVb0oXyKEWiNx
 I5X2Be/n6A3YcY2SzZSWO1Kr+85jdb68M0DLQswvCVtjIPdKI4+nfGwu3FySUAGg/RI=
X-Gm-Gg: Acq92OEEqmGKDDKv2Q1geWekLWj8S3wqCPlkcZRXZai7TjRzRJN0xfbC4mhFRMxqYvL
 d0R/sO6zccs161Yz0aJ1Odx445fXYLPVkD67Jgyf1ThdlHD+hXdYZEzH0qw86xb8KSMocThr8UM
 q/MjEY7RCESe5+hYLe4HA88eTmkYZ5JgnADESV0LH8aDv4bOBpml21G+5l6h4ZK3oC0AtVWRJS0
 MvD0tXmJYIWKbeDpei7Aysnp+ZE3LsGKQRBWFRGgeYrX11gFQcmdw99RaZbBwlXf83us01FxXe3
 ArqKhR/iMzK7xxVA/E9yJIESxnVes43icJFjBqTR0THasFmsgo0l2FsP4aRfxp9tUxI2aD3/jXM
 BvrDYPTmiPZ0WW0HtywnYtmPGmorw83BXY2r/uap6KJROFOix5CRgANqo2T5QVb61SKP3WaFrBX
 Vh+J5b/zJyvNetR4aI9XO9+0Ldz+LUH8lumNAboGsu9vRwgpTz2HQBljQLR2E1tkqwvO4Dt2VhO
 +hOVacyuzOmSQ==
X-Received: by 2002:a17:90b:5290:b0:368:f0d0:1ce8 with SMTP id
 98e67ed59e1d1-36951a11701mr7365961a91.9.1778917237841; 
 Sat, 16 May 2026 00:40:37 -0700 (PDT)
Received: from kinako.work.home.arpa
 (p1620034-ipxg00d01sizuokaden.shizuoka.ocn.ne.jp. [122.29.136.34])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-369514361b6sm4702672a91.12.2026.05.16.00.40.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 00:40:37 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: 
Cc: Daniel Palmer <daniel@thingy.jp>, trini@konsulko.com, visitorckw@gmail.com,
 angelo@kernel-space.org, bmeng.cn@gmail.com, sjg@chromium.org,
 u-boot@lists.denx.de
Subject: [PATCH v7 2/9] sysreset: qemu virt: Use __raw_writel()
Date: Sat, 16 May 2026 16:39:54 +0900
Message-ID: <20260516074016.885146-3-daniel@thingy.jp>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260516074016.885146-1-daniel@thingy.jp>
References: <20260516074016.885146-1-daniel@thingy.jp>
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

The virt ctrl register seems to be native endian, currently this driver
uses writel(), which works by luck because its currently broken on m68k.

Use __raw_writel() instead to avoid breaking this driver when the
endianness of writel() is fixed.

Acked-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Reviewed-by: Angelo Dureghello <angelo@kernel-space.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Daniel Palmer <daniel@thingy.jp>
---
 drivers/sysreset/sysreset_qemu_virt_ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/sysreset/sysreset_qemu_virt_ctrl.c b/drivers/sysreset/sysreset_qemu_virt_ctrl.c
index 61b38d507fc5..ce15e776f8fa 100644
--- a/drivers/sysreset/sysreset_qemu_virt_ctrl.c
+++ b/drivers/sysreset/sysreset_qemu_virt_ctrl.c
@@ -40,7 +40,7 @@ static int qemu_virt_ctrl_request(struct udevice *dev, enum sysreset_t type)
 		return -EPROTONOSUPPORT;
 	}
 
-	writel(val, reg);
+	__raw_writel(val, reg);
 
 	return -EINPROGRESS;
 }
-- 
2.53.0

