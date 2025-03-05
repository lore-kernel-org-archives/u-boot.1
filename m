Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8936CC19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 14:28:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AE6D81276;
	Wed,  5 Mar 2025 15:27:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YLdS+4Bj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 512B881276; Wed,  5 Mar 2025 15:27:23 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CDD381420
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 15:27:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43bc4b16135so20858905e9.1
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 06:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741184840; x=1741789640; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SUsynbjk3mnS2CZGpd4zam4j3kNmvGMUxHDIT15oNDs=;
 b=YLdS+4BjsYC3GbNzrh6Ev8ZEhrINHDC7ZKnJXgxOJ/OXBhPXq4VgZeIiOnRaZ85fcV
 XVJq+XVTSLdbzIsP5t99fvxqLoIkbdTNlx0PFZmjuKdhyK5MYy7AXAECJZD4tkuYQl7a
 uxfDOxAebnaFVVW9G9TLSZX6vIIn2RwLs7IKjFWzFN3SB8OBIyK0h9SeioN+EEDj4mWt
 BQUWVcCMEGsQT8UbaI0WPtd02ifUayRc3wg9GZ0Ba5fUalE/MInYsQs4yaRXJuC96GDg
 lgXuIgRqPo33twJtFfxoM6DhkTHR99c4LDlWdNgOQwyBXAwlNWESw/0HhE0QpmAT3dme
 JH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741184840; x=1741789640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SUsynbjk3mnS2CZGpd4zam4j3kNmvGMUxHDIT15oNDs=;
 b=X1yd6XBwgfXQ0TBbM4ZQtKTlPoyWq0w7obrwCEWzLQHnajoIpzG80rTERPIr7JT1tU
 lsxWYVx/mGdjFvwD/iy0Q2rRlH4PYozo9BHdWyPLFkOz+MIvF+m3lv1FGrOoW5k4ai4W
 Z0oIXshDswi/hAmxmTi7TuvZ/dT1Lx3M0GXtExSfnjOzH5ztby4SOzrj7ziBf2M4f/FZ
 vAE7yowWFsV8I0QXvg+6DhZIsC9X/npZwdeJUONPGq1cd6ak3tchFA2l5vR0Hvh3uD0x
 9iaK0wo4na5vC6RBZiu7Q3J6CAb671xi3bynCSV1dQcKar2a1O/1PzJNv24T4wf/rmdX
 77Kw==
X-Gm-Message-State: AOJu0YyILjC+NO8mvnDp8bg8w2K4J3X+ou9hMcAcB4FUbX79DyebUAyB
 DdWxSwGDnLbk1jlfgkhjhlP5liZTcnokMXKCZJWtlcCwsbTaRkZlVXJkr7KQHhm3zclCO7FbvDc
 M
X-Gm-Gg: ASbGncshatlSLfRf9OVj201zvqQYmp/TyVL6hLoaSs0Gw7rru7wFOSviyBvIxWtLm7E
 TvCagsHUvdqrBnQFjN1Ly6K3Ino6+aV3mnzVg+0+KlfLgMQ5TZAidulD7C8mNALU6EQuXODY/9N
 sifbcc/9pa7Kz8Ko0A61VIqtrK1k67DufZlJ7xwE33vL7XuS+0E6ALev/K+AbkWWoTS1838l3A2
 87ltFrNQT2Yin15uTbdfHc2mCcaDkt+AjziTnMGCzIFVbTXZmaDg+b+on/LEV4KCwpQtaded1po
 jYUWlBBQ5r0RYCTH/5jbNt34RrTwe6PMpaZnPPbwk/En0L9aNoi88g==
X-Google-Smtp-Source: AGHT+IGOmZX15oNHr3Q2rNhTLjhoLZVybJrxKfOdli/Ew7U3Or0WmVN1W5FcZB5jKgaBmy42JI7kZg==
X-Received: by 2002:a5d:64cb:0:b0:390:df75:ddc4 with SMTP id
 ffacd0b85a97d-3911f7cba2amr3267715f8f.44.1741184840507; 
 Wed, 05 Mar 2025 06:27:20 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:369c:9bd8:7c87:9a39])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-391188029e0sm5442456f8f.52.2025.03.05.06.27.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 06:27:20 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 6/6] configs: qemu_arm64_lwip_defconfig: enable WGET_CACERT
Date: Wed,  5 Mar 2025 15:26:47 +0100
Message-ID: <20250305142650.2966738-7-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250305142650.2966738-1-jerome.forissier@linaro.org>
References: <20250305142650.2966738-1-jerome.forissier@linaro.org>
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

Enable the "wget cacert" command.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 configs/qemu_arm64_lwip_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lwip_defconfig
index 754c770c33f..814e98729a3 100644
--- a/configs/qemu_arm64_lwip_defconfig
+++ b/configs/qemu_arm64_lwip_defconfig
@@ -8,3 +8,4 @@ CONFIG_CMD_DNS=y
 CONFIG_CMD_WGET=y
 CONFIG_EFI_HTTP_BOOT=y
 CONFIG_WGET_HTTPS=y
+CONFIG_WGET_CACERT=y
-- 
2.43.0

