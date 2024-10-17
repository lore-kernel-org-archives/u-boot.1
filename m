Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C17D3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:27:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EF7F8924E;
	Fri, 18 Oct 2024 01:25:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AyF1UHie";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DD52891C6; Fri, 18 Oct 2024 01:25:02 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDB4E8921E
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:24:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-83ab52ca5a9so37332639f.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207498; x=1729812298; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WWsUq+fk4kj+3mq6Ye8nYDdw7Sc2QZix0XNwO+qqumY=;
 b=AyF1UHiepOkbFvwhT7jVRqc5L+KLFFOFBIjyCqCN/PJ4qA4k9uR7osuEu5jPSD+2JU
 MUNZMp/omB0nCF4u3gNndtGU+g+F/jrNVCa8cOxyp4wF0EAfKhSl9E7CHAV5WYxcNpOw
 LivQ3oqLJU6Ixy7Qmkq+u0cW1T5HsXdixuH9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207498; x=1729812298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WWsUq+fk4kj+3mq6Ye8nYDdw7Sc2QZix0XNwO+qqumY=;
 b=flxEFQW7P6EDa+ORvUQX/ux8tW+BjFmy/OUHdlo67fddPv7XPD4V2vwvXE/d2ep5+k
 8bBizy3C8YUvgRuJChZwKWMV5+1hk98abAU0/BZ2q3VIet4bCOs/xLpxD7efFaU1fgSH
 2oZsvCdBhF0kTy8sUz2BPcfP5Xy7fzOQv7ORmQJjfwiqXDewhAUGwW//qrEULipsPzTY
 lh/EoX/afaMn/NHZsWxSGKb4QBJMUIs/s6Jm33DYic9mhqjj6PLUlrNigE1vYgFX77qP
 pVXceYjVugOheEFXdQO3mckg8ETZMcBmfGSHrZo+ODEDL6CEK3X3delfwbfxjY/UG9xF
 CKyA==
X-Gm-Message-State: AOJu0YyNaSlu0SfAB5fVO768Canji6pMcnM0AUmCMcRy8B2djQ79C+/J
 08EdUqEkuL0ErDjNSejpGIXUNBiKgmN5j9K/Vo13BOU9akLKgsnDG8q4+V8Lw6XP3A3E3LLnMlM
 =
X-Google-Smtp-Source: AGHT+IE8GQM9GFx6g7sHFR0N3GCc38UDtBfleIGihqmvQL9CdAaEO4/PyV9YzLUG/7ifQRpMDLujvA==
X-Received: by 2002:a05:6e02:1564:b0:3a0:9238:d38 with SMTP id
 e9e14a558f8ab-3a3f405f914mr5539175ab.10.1729207498501; 
 Thu, 17 Oct 2024 16:24:58 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10ba3454sm117117173.79.2024.10.17.16.24.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 16:24:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 18/34] image: Add a new type for a command-line string
Date: Thu, 17 Oct 2024 17:23:57 -0600
Message-Id: <20241017232413.724808-19-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017232413.724808-1-sjg@chromium.org>
References: <20241017232413.724808-1-sjg@chromium.org>
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

Some bootmeths package a commandline into the bootflow. Add support for
this as a file type.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/image.c    | 1 +
 include/image.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/boot/image.c b/boot/image.c
index eaba9eb4332..f75b1e7841c 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -186,6 +186,7 @@ static const table_entry_t uimage_type[] = {
 	{	IH_TYPE_EXTLINUX_CFG, "extlinux_cfg", "Extlinux configuration" },
 	{	IH_TYPE_EFI, "efi", "EFI applicaiton" },
 	{	IH_TYPE_LOGO, "logo", "Logo image" },
+	{	IH_TYPE_CMDLINE, "cmdline", "Command-line string" },
 	{	-1,		    "",		  "",			},
 };
 
diff --git a/include/image.h b/include/image.h
index 0d1adee499b..ff23fdbe22a 100644
--- a/include/image.h
+++ b/include/image.h
@@ -235,6 +235,7 @@ enum image_type_t {
 	IH_TYPE_EXTLINUX_CFG,		/* extlinux configuration-file */
 	IH_TYPE_EFI,			/* EFI PE image */
 	IH_TYPE_LOGO,			/* Image / logo */
+	IH_TYPE_CMDLINE,		/* OS command-line string */
 
 	IH_TYPE_COUNT,			/* Number of image types */
 };
-- 
2.34.1

