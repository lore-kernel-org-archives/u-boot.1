Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95208E77180
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 00:45:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5910E80209;
	Wed, 11 Dec 2024 01:45:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eXzM0vGv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEE4A80241; Wed, 11 Dec 2024 01:45:21 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FA0E80235
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 01:45:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3a814831760so16133935ab.1
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 16:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733877917; x=1734482717; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MIE6gSSVyMRu2MY5YVRc4TcCageC3T/XYDIbDcVWJS4=;
 b=eXzM0vGvzfj+0JduK94UjXjlaCBv6kU8y2nXMxCRCnezOze1YZXamH00C1Bvj6/Ce3
 IaZAM4Rv9iwOEY/XeQZRVxznM4WZ3blJHzRgOU2xYSENrtXEDJTMWbaWBm6bIgnDfQal
 tgVaBa4oKoloutWfT3QCTYBUr0bCrAX3CL+y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733877917; x=1734482717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MIE6gSSVyMRu2MY5YVRc4TcCageC3T/XYDIbDcVWJS4=;
 b=X6DsZaDsb8NMSIY8JZlnX4NgVwUnhSQMmb8swqdYqmNLHaHvcYisyXbnm5cVy6uo/u
 9ygDhRCBcMFvuR2yXaqpJAlBAB5u9Q+OrLNEEwxjGNBc6X9tgxjdvS7Jo89feAgJpZOM
 O836OfPObKLtEALYWS9jueOlgLeuKIY135M6ANOd0YJRHVA5nk/ic685cwUSImvt7/dR
 uiLswNRIdOI81D/fWh3RXir4ljTgLXZ730HRpPxI1hhkNg43Sp3NvKqxgxSuP1ZZtVHS
 hjE0dsQDKRHlE7Mo8A/Sspyqjo6AFvvvaOV3IhnXjGHehuTxluM25gr+wZHIy/3CsXu3
 LexA==
X-Gm-Message-State: AOJu0Yz35zxDccKjfEPL82CaEPTKJiQS6RD9kRHxGQd1y6tgC6iW2Zrv
 EU9avGnBaSc4Zpi/yjr725En8r0cDti0Y6KiUXwcPuEKo3wsUKRgZT/Oe/qF2F+VBsGbH2ActyM
 =
X-Gm-Gg: ASbGnctQ7VN6elX2peGmMAMF2OqgIL+jh41uQiJTMWL+1J4RN8Fs7sWpOLc+neCm+83
 1yaVfRXNtD7B1NMqDK7vOpntkP7yoFzU+toH276RXGYu4dpNGTnDcliU9NenSU38SjCIiPLoXSj
 HKbikt8wANDyhXzorkqAOQ2vkGoHhVwVUc3+mf9htT+5LwEK6WepeMIAil/hi9jthS0PaGvPXge
 cSrxhO/QxggCENTOaybVNJIeaFtmjpL2QFxj63L4OiCNTn0sFHGeuNtommWQXEzRAP+NgEOdAEz
 4AzH7Rtdf2FhgdY=
X-Google-Smtp-Source: AGHT+IHVO4A1yOn6OI8OWWhFin69mtO+iv/Ym5M7k4Tuy/W1HrD4mkgWva85TJ4G+Zb2+EEupek9fg==
X-Received: by 2002:a05:6e02:2145:b0:3a7:c5ff:e60b with SMTP id
 e9e14a558f8ab-3aa058b6858mr11202895ab.6.1733877917364; 
 Tue, 10 Dec 2024 16:45:17 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a9ced6dfafsm17251305ab.54.2024.12.10.16.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 16:45:16 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bryan Brattlof <bb@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 "Leon M. Busch-George" <leon@georgemail.eu>, Marek Vasut <marex@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] efi: Switch over to OF_SEPARATE for the app
Date: Tue, 10 Dec 2024 17:45:03 -0700
Message-Id: <20241211004503.3775922-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211004503.3775922-1-sjg@chromium.org>
References: <20241211004503.3775922-1-sjg@chromium.org>
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

Now that we can support a separate devicetree, enable this for the
EFI-app builds.

Drop the Makefile-warning exception since we don't need it anymore.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 Makefile                        | 2 +-
 configs/efi-x86_app32_defconfig | 1 -
 configs/efi-x86_app64_defconfig | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index cbc0feff279..43966004d5f 100644
--- a/Makefile
+++ b/Makefile
@@ -1145,7 +1145,7 @@ all: .binman_stamp
 ifeq ($(CONFIG_DEPRECATED),y)
 	$(warning "You have deprecated configuration options enabled in your .config! Please check your configuration.")
 endif
-ifeq ($(CONFIG_OF_EMBED)$(CONFIG_EFI_APP),y)
+ifeq ($(CONFIG_OF_EMBED),y)
 	@echo >&2 "===================== WARNING ======================"
 	@echo >&2 "CONFIG_OF_EMBED is enabled. This option should only"
 	@echo >&2 "be used for debugging purposes. Please use"
diff --git a/configs/efi-x86_app32_defconfig b/configs/efi-x86_app32_defconfig
index c730945f4f9..b20c85f1cff 100644
--- a/configs/efi-x86_app32_defconfig
+++ b/configs/efi-x86_app32_defconfig
@@ -31,7 +31,6 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
 CONFIG_EFI_PARTITION=y
-CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
diff --git a/configs/efi-x86_app64_defconfig b/configs/efi-x86_app64_defconfig
index 1831fb2d5a7..0988ad45205 100644
--- a/configs/efi-x86_app64_defconfig
+++ b/configs/efi-x86_app64_defconfig
@@ -35,7 +35,6 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ISO_PARTITION=y
 CONFIG_EFI_PARTITION=y
-CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
-- 
2.34.1

