Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA4DD711B4
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 15:36:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6266588DA3;
	Wed, 20 Nov 2024 16:36:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="efr7ToSH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 523D688C0F; Wed, 20 Nov 2024 16:36:17 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F5A788FAA
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 16:36:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-83b2a41b81cso157534439f.0
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 07:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732116971; x=1732721771; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AohfFloXytCd3x6NZ07u4rFeOO50YPYPqcLjz5+SScQ=;
 b=efr7ToSHeVPzubINAWm0a9QVna+iFXqqd+iSMXd4ePW1D2mcJVCqCoxScVAVMr4pBY
 j+lAeaJbqgyxmx2vnsfaEjS2xx5eHlHcPYVYDTd812rtzWCQTy3c+I709uEMqT2fvcOu
 8LnryZ1ovalhu4yqTnvUhlfEHVIs+QlIiX1lE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732116971; x=1732721771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AohfFloXytCd3x6NZ07u4rFeOO50YPYPqcLjz5+SScQ=;
 b=Lth93nR9CZ3b5WFnUMaBHRAloxirkg14sFLnALbM8RvEZIl4XXIZH49E5MEq/R0teS
 HT5bAMbUcUId8MTrR2icupC9E9Cv1lyPdSyqKZeRBcAVuRPhp4JU601ck2n4+k2g8ny+
 KtI+XPdK57RVyqz8NHVrf/RkDHyUZSgydhwDpoYdb2K9Uw7OhE0nA/iZoNZGTvwrw9+l
 f3WJ14Inoqo9XSlCTsRiFR0bXFhSgoj3yeMi74LC5ZPQT2LZ4A2eawkQpE9ICGoMA4qE
 adJ7yIssexcmWoAsJeT9M388Cjb5u9wz20ZGQUB1VbDuP9RHUOuBJZ96F/Iy2l1BL2O0
 qaUQ==
X-Gm-Message-State: AOJu0Yw5DcFzjYGJV2M8Gu0V8s1Z+dbUeKXt3E2T/Ub3qeVttBk+M7/6
 QW24qxEeJ56ixEXafm35g9cZZvwvJw++EosrjRKyxcnAn9zHZkwFMunMuLxd2HQHnO0iSAQc4ao
 =
X-Google-Smtp-Source: AGHT+IH95/1qOOc9Ia/2cEI0vqa7bl7SqPVLefnl/Ip99E+CgxiQ/cQpnb6lnowm4uaZZigL5Va7dQ==
X-Received: by 2002:a05:6602:1486:b0:83e:6232:11a with SMTP id
 ca18e2360f4ac-83eb5fce440mr426156639f.7.1732116971375; 
 Wed, 20 Nov 2024 07:36:11 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83e6dffd678sm274395139f.23.2024.11.20.07.36.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 07:36:09 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 3/3] x86: coreboot: Make use of disabled console
Date: Wed, 20 Nov 2024 08:35:54 -0700
Message-Id: <20241120153554.860710-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241120153554.860710-1-sjg@chromium.org>
References: <20241120153554.860710-1-sjg@chromium.org>
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

U-Boot normally requires a UART. When booting from coreboot it is
sometimes just not available, e.g. when no sysinfo or DBG2 information
is provided.

In this case we need to continue running, since the display can be used.
Use the 'disable' flag for this case.

This allows U-Boot to start up and operation from the display, instead
of hanging on start-up.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Put the feature behind a Kconfig
- Move the feature to the serial uclass, so any serial driver can use it

Changes in v2:
- Drop RFC tag since there were no comments

 arch/x86/cpu/coreboot/Kconfig    | 1 +
 drivers/serial/serial_coreboot.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/x86/cpu/coreboot/Kconfig b/arch/x86/cpu/coreboot/Kconfig
index 085302c0482..d850be9dc73 100644
--- a/arch/x86/cpu/coreboot/Kconfig
+++ b/arch/x86/cpu/coreboot/Kconfig
@@ -29,5 +29,6 @@ config SYS_COREBOOT
 	select BINMAN if X86_64
 	select SYSINFO
 	imply SYSINFO_EXTRA
+	select SERIAL_CAN_DISABLE
 
 endif
diff --git a/drivers/serial/serial_coreboot.c b/drivers/serial/serial_coreboot.c
index b1f69f6998c..a53c37a8756 100644
--- a/drivers/serial/serial_coreboot.c
+++ b/drivers/serial/serial_coreboot.c
@@ -95,6 +95,7 @@ static int read_dbg2(struct ns16550_plat *plat)
 
 static int coreboot_of_to_plat(struct udevice *dev)
 {
+	struct serial_dev_plat *uplat = dev_get_uclass_plat(dev);
 	struct ns16550_plat *plat = dev_get_plat(dev);
 	struct cb_serial *cb_info = lib_sysinfo.serial;
 	int ret = -ENOENT;
@@ -119,6 +120,7 @@ static int coreboot_of_to_plat(struct udevice *dev)
 		 * there is no UART, which may panic. So stay silent and
 		 * pray that the video console will work.
 		 */
+		uplat->disable = true;
 		log_debug("Cannot detect UART\n");
 	}
 
-- 
2.34.1

