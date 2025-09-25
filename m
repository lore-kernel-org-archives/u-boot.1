Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3946BCAC5B0
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 20:56:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B10748309D;
	Thu, 25 Sep 2025 22:56:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CDQiq21o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FF1F832AD; Thu, 25 Sep 2025 22:56:17 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A58A80819
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 22:56:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-74542b1b2bcso1193961a34.3
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 13:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758833774; x=1759438574; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=UF4GJ9vpVg1jNC0eoQtm+nJKv8V34twrp138NR3KvRY=;
 b=CDQiq21oZqW0kqNPDygyu6AhRVLL1BSdMqGzS15MhJI5Wour50B/blwG6PBq0CrhZv
 /mAutGZgvmQjPe4RBFtB76uNRAOV0jff+a46Y3SrY5gK3XcIvxZ6gUbTBZK9KM/yu0O1
 gCQJFp3673AK5gzjfTt4PsUszcfgj0alqTvaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758833774; x=1759438574;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UF4GJ9vpVg1jNC0eoQtm+nJKv8V34twrp138NR3KvRY=;
 b=o2A6Zb2pzPNjP2UhJc1/BZJDimF+lIz8d8xQDt7nmUHKLR9v9xFILe8GJxVRJyUzFf
 hTj5BHJdis0OoCzBmkvdXNdmc+1lTsFJ4kt+rxqaz/H3Q4Y/DajBZ2AcxMlj3RqIwuVp
 3iIDz1RicYfASWoMYCGVATsuWPFZgTUO03LV4oBaksqRR8IB0sj2QHGzJ+UklwDs75BX
 e6blsX7n63lFApnzPHdN7PIhkuO0mrAjc8+gtprrcetoUTla8PY+cK8m4+UcRDAkcuYJ
 wackUxGhBJ4YpGRNPfhZLLcC583VKxdgsIvrkE1kviINvdo10deJuSUkLdtgrF3xor4c
 VhDA==
X-Gm-Message-State: AOJu0YyODaH/t/JbNIvw5HB4ZnYizqeT8REM923n1gGVQfYBXg/worgg
 OJ9znabvNQkGMqBnzI3+WIbnMr4V3sDrM8hzzLmRPWa7maf2rwEvIm3btbrMuwHxFyGmgjsaucb
 QzWBhDl0=
X-Gm-Gg: ASbGncu4Vifso+uh59yFXi1zQRPKvKOYxoxF84GjngXRfuEHrIeWlNMaz5akr+59zQe
 SdHOIHipy/UypUZOjq5L3fM1Ss3SBARBO/1FV/LnGHDPO0daRqQufDeO6T8xuTNPm+krUzGmaC+
 EaGeL/Z6BOTisVwjq0m+R6KqW70lgZMqk4APw+G6n0IorPHUmQr143BskCcwyanH5+qTTgZUXKW
 U4Zxr2xWS9DE3UPXOEXBX7nJJo09hIIsCcxulihwoCtkiXIJNLVJKWGQOQxQVJZzxHvAtyD2w84
 pWo5DLMeEz8MwcdtYtHc7bvtXjA0ULq8HGa31TpMRuGdJg4xPLvqaqsl3faYJXguvzNOuZ7GUzz
 oXf0Nf2cEZoIy4uV6tbg2eSNYmtjSnmHrgLJSkLPzHXbL5n6Bc61nejp03ww=
X-Google-Smtp-Source: AGHT+IEVGOw5/kC2MXpZW5f0cSGaGb3TyoT7LDBtAk1kzUyy0Zqj0JYiUtPysrZ87fUfS0y+jTLfoA==
X-Received: by 2002:a05:6830:82dc:b0:744:f0db:a1af with SMTP id
 46e09a7af769-7a048ee1f1bmr2612615a34.31.1758833774320; 
 Thu, 25 Sep 2025 13:56:14 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7a2405c455esm608892a34.35.2025.09.25.13.56.13
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 13:56:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] gpio: aspeed: Make U_BOOT_DRIVER entries unique
Date: Thu, 25 Sep 2025 14:56:12 -0600
Message-ID: <20250925205612.3562525-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

All instances of the U_BOOT_DRIVER must use a unique name or they will
lead to link time failures due to name space conflicts when both are
present. In this case gpio-aspeed-g7 was using the same name as
gpio-aspeed.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/gpio/gpio-aspeed-g7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-aspeed-g7.c b/drivers/gpio/gpio-aspeed-g7.c
index 4c6ab86203c2..4607468ca05f 100644
--- a/drivers/gpio/gpio-aspeed-g7.c
+++ b/drivers/gpio/gpio-aspeed-g7.c
@@ -141,7 +141,7 @@ static const struct udevice_id aspeed_gpio_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(gpio_aspeed) = {
+U_BOOT_DRIVER(gpio_aspeed_g7) = {
 	.name   = "gpio-aspeed",
 	.id     = UCLASS_GPIO,
 	.of_match = aspeed_gpio_ids,
-- 
2.43.0

