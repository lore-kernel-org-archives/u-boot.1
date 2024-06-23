Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097C7C27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 17:54:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 723C78855C;
	Sun, 23 Jun 2024 19:53:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZmrUFZO8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 950F488405; Sun, 23 Jun 2024 19:53:29 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B556788433
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 19:53:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7ec07f4170bso144539539f.0
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 10:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719165205; x=1719770005; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tElDSyoJfFQYZphlkBNYSPslFhtNW18S3Qmcc0PftvU=;
 b=ZmrUFZO8UnAaem9SbJW1WxMmq2s9jhHXqM4vviAzgNALHTG94sEOd+D4JOFWYlKM4g
 WPqXd1+FSs3w1UHfQxU+izCt6iDrZXMeta1DvNh8PEi4pxk+tcCn03XkuMHxRb8KY5Bu
 FWrColG1PLEG9oATnNZ//iqeUd8X2PPHa5lAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719165205; x=1719770005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tElDSyoJfFQYZphlkBNYSPslFhtNW18S3Qmcc0PftvU=;
 b=eHKbdBqLXiMJgk4s2O62oB/nTf1NfVRzZXCBGeo6392RT8sKBa6UhDKx0KTefXvubc
 I6RtOqPQiHxGcd0CNLH8QsziwxywixK3rmpb/ICKBYEFPxuBejGuVxgR76d3HyzAbnpI
 PxX8Lri98GzueNvsa9BwJ7FBmjiEufYiy31zkeb+VQpw6uYH7LyJg1ysdaXvwCmnBWGg
 uXyuhXdA9jJ24LzLXT/g74ctT+N1e1uVtDoI415lnE2UT85TudHY2qHdvtpel3/kAwjP
 4qURZmBnWquLsTBF+in2MREmhqoPoENveZAYg8hC1qQ2SPS2B9cdsDfcqpczU0/diCmq
 fZHA==
X-Gm-Message-State: AOJu0YzDxiSCk84KobK4haJFq62GJurQ/I2AEv7CEpFlCgomW3oC8s7M
 sPBk5uRkZQ5UFXKSuhCS1uTU34b6L9efrqF0IKE27XaW5dfh5H3QYJfZopZdqILVWaFv/tLV2+h
 PAQ==
X-Google-Smtp-Source: AGHT+IGsdcDLh6kEAXHUsMJih8hsxHwpL9ZCPsHUV0JGSimGNeoSwD3T1hXrur4qzUKmOZSVdL0zRw==
X-Received: by 2002:a05:6602:6015:b0:7eb:9697:95e1 with SMTP id
 ca18e2360f4ac-7f3a4d48277mr354413039f.0.1719165205445; 
 Sun, 23 Jun 2024 10:53:25 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d113ff85sm1636834173.81.2024.06.23.10.53.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 10:53:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v4 08/16] x86: Set a board-size limit for chromebook_link
Date: Sun, 23 Jun 2024 11:52:54 -0600
Message-Id: <20240623175302.1463973-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623175302.1463973-1-sjg@chromium.org>
References: <20240623175302.1463973-1-sjg@chromium.org>
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

Set a size limit for this board so that we get a build error if it grows
too much.

Note that the limit is approximately, since it does not include the FDT,
microcode and fdtmap, which can change in size. However this board is
fairly stable, so overflowing this limit will likely result in the image
not fitting in the ROM space available for U-Boot.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Add new patch to set a board-size limit for chromebook_link

 configs/chromebook_link_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/chromebook_link_defconfig b/configs/chromebook_link_defconfig
index a9f91dd9b26..1a72fd178a8 100644
--- a/configs/chromebook_link_defconfig
+++ b/configs/chromebook_link_defconfig
@@ -15,6 +15,8 @@ CONFIG_DEBUG_UART=y
 CONFIG_HAVE_MRC=y
 CONFIG_SMP=y
 CONFIG_HAVE_VGA_BIOS=y
+CONFIG_HAS_BOARD_SIZE_LIMIT=y
+CONFIG_BOARD_SIZE_LIMIT=630000
 CONFIG_FIT=y
 CONFIG_BOOTSTAGE=y
 CONFIG_BOOTSTAGE_REPORT=y
-- 
2.34.1

