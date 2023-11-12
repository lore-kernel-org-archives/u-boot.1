Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E53C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:05:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28829871D7;
	Sun, 12 Nov 2023 21:03:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PbSo0GZW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32C24870DE; Sun, 12 Nov 2023 21:03:16 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06AB187225
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 21:03:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-35941ccaa85so16214385ab.1
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 12:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699819389; x=1700424189; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O1O9wY/L1tM2pT+VG6t2L6oH+kZTXT6CR8cbT+/8wlg=;
 b=PbSo0GZWfISs6Xi8bIZtDd9FbaenNd9kZv0Ay/aaucX8Kb2cOws43GbbcVKNnJgtzS
 g4ASXQ35zKq82bMx5vrwyzkiIUpa5tBIl8U0om+pvZTmeCn+9S508LkpU+YGENwJxUDD
 lhxD3+2fs9h5P7p25o/B7mJAhRiGoI/l76Ng8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699819389; x=1700424189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O1O9wY/L1tM2pT+VG6t2L6oH+kZTXT6CR8cbT+/8wlg=;
 b=Rshf/1NgxqACrtrfrPlwo0idV8jc5K7DrXC4HO32UcJuZ5RZS+0+ryl4yCnV4Lf/2X
 d7UVY7kxsbXMQ7e/1R+XeJwt9Nd9u80YasFXYzDt8NMjiDckmj3yWaeHMzr1PTqn251w
 d1Sk5BKNFUvNhVpxkC9wnxfwUsRQlm3PIgdNxdcVJHLRMG8hcV+T1LCnyPSGmWdx7rn4
 c4PktImkFYP9BFwZmuXuSgBRCU6cGYD6bq0ID1zdGXR7u5/JRoM7uqcGO03MchMX2/mT
 Dfm0N1tTLsIe4fDi0eVU3w2sEhA/8qrFQmZXRFRb8D0e5hlykv7SOtbqFCF/LaAxs9MG
 KyUg==
X-Gm-Message-State: AOJu0Yy1/sDmn+c9l227hknojf3c3l4AB4povuWb4wcx3cWz/icQxNjm
 LYbct+pf20XgdQVAQyamht5eDYjstCcCzMsmMDVbcA==
X-Google-Smtp-Source: AGHT+IFjnyW9sYAFik0K7KyKm4CYZLjdCbumea/3MZcPj1uiCjDHQ8C7Kqs9tIIHldsdJwizNNWrVQ==
X-Received: by 2002:a05:6e02:1c8f:b0:359:cc98:7508 with SMTP id
 w15-20020a056e021c8f00b00359cc987508mr6612891ill.31.1699819389586; 
 Sun, 12 Nov 2023 12:03:09 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 z4-20020a923204000000b0035761b749casm1208256ile.46.2023.11.12.12.03.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 12:03:09 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v4 12/12] x86: qemu: Enable truetype fonts
Date: Sun, 12 Nov 2023 13:02:49 -0700
Message-ID: <20231112200255.172351-8-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112200255.172351-1-sjg@chromium.org>
References: <20231112200255.172351-1-sjg@chromium.org>
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

Enable this feature to provide a larger font choice and more attractive
menus. Expand the ROM for x86_64 to 2MB to make space for the font.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add new patch to enable truetype fonts in qemu-x86 and qemu-x86_64

 configs/qemu-x86_64_defconfig | 1 +
 configs/qemu-x86_defconfig    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index a71111697e38..99855df64442 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -82,6 +82,7 @@ CONFIG_SPL_DM_RTC=y
 CONFIG_SYS_NS16550_PORT_MAPPED=y
 CONFIG_SPI=y
 CONFIG_USB_KEYBOARD=y
+CONFIG_CONSOLE_TRUETYPE=y
 CONFIG_FRAMEBUFFER_SET_VESA_MODE=y
 CONFIG_FRAMEBUFFER_VESA_MODE_USER=y
 CONFIG_FRAMEBUFFER_VESA_MODE=0x144
diff --git a/configs/qemu-x86_defconfig b/configs/qemu-x86_defconfig
index 246ac6b6b8ad..65bb5f9bd83d 100644
--- a/configs/qemu-x86_defconfig
+++ b/configs/qemu-x86_defconfig
@@ -59,6 +59,7 @@ CONFIG_NVME_PCI=y
 CONFIG_SYS_NS16550_PORT_MAPPED=y
 CONFIG_SPI=y
 CONFIG_USB_KEYBOARD=y
+CONFIG_CONSOLE_TRUETYPE=y
 CONFIG_FRAMEBUFFER_SET_VESA_MODE=y
 CONFIG_FRAMEBUFFER_VESA_MODE_USER=y
 CONFIG_FRAMEBUFFER_VESA_MODE=0x144
-- 
2.42.0.869.gea05f2083d-goog

