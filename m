Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D743ACAC5B0
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 20:42:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 615C580819;
	Thu, 25 Sep 2025 22:42:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KCCqRgJw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBF9C8319C; Thu, 25 Sep 2025 22:42:33 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C134F8206E
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 22:42:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7a7b084ef77so296605a34.2
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 13:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758832950; x=1759437750; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iVEx4L+SjoVUHcA7XykW6yIKfmNvXuQVR1JiYKj0r8o=;
 b=KCCqRgJwLjNpJvXGgTdQkJDTXhHPzzxwfx4Or9b/L/ErQ8kVQq19shLZr3pJ/zSVf/
 zh2/G0pDfA0lpzhyMdlSFhejB4pZ3YyU45scKxxWG3MYpC+dmdqBLNoKHvQGbZ7Ry6Pn
 aMIUFn+EZf+TN4y09YWphXMzgQBrxJpm4e134=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758832950; x=1759437750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iVEx4L+SjoVUHcA7XykW6yIKfmNvXuQVR1JiYKj0r8o=;
 b=cWxlB505UhQ3PhaTdOEuf8ehMVgUkwhS4KWVZDXB8HdBZtAXtIednnsZWEr+aIq0hU
 qc8tOrkir3NoLj7z1qZ/doTBrLDYjTG56blvvM/+7TuDN5voPUdw5RaRd3g3KjwODxgJ
 L0fgeMKdOR2ocMaqruqJY05aAXznvGqDJNCrcE4cj1yaoWgw1UJ2l/erRk0owQs5igRB
 zQuc05RtUB9f/ZGhurHQu9wtg42da57fnSm7vIyGbsHqggxC7Z7b0t+2/DGcswiBjdxC
 9k9L0W78tybSZm31FhJNWDVNOzNUA1SO+qVnYLjUwM6JgjrdalvNEBhupygevw3ANzUF
 vg0g==
X-Gm-Message-State: AOJu0YzNNMBs+frMVtl3njtvBDniYbU/GNrDuBn4nDv3B1A2hlMwrYO2
 tUhL0Ko/vzUqBnT/hihQWICZhiw9VTWFTlumRGojTD/PL0fCEpegwyROqpnK7CV94JsigJYKXGs
 8iICy8h4=
X-Gm-Gg: ASbGncuBp+pxhwgKL5yKHWZrerDrclC8jxco3DAAFvaAO6DBSBPxV1Yu1DbuTlD/F6g
 FkJuu8xlq9FJauDyKU6vg248MvRUUWI+T94skdJhNdfgo1fylgk1nDEH3kpsQid/xVXSAY1bRdl
 6rRRodnb1Mp011u3L5/59zqEsFuLjcvmVBVahlJ5t+QcqIGDC9krdFcyDnV2BqiKRRWByqLCTMo
 XFghDOqnkP//h0XfVD2s7BduOdR04pNzdTqQ7xu08Q+pUPyetBqmcYxydFznDc2GQ2PrXr7huel
 tTlpJ1aw2YdxNKyH5EBgkEYsUb1h7BNi3twLwvnl1CTosrJNgNpfBMdSbH51zTGlsQ9vKqL1F+q
 TOiFoUTYkiXzLsVz/mQ9ilyYFRYA66PsA1hc6GGPG/nKgDuZMlR0CAhEYMZRZWH4R3EhbuA==
X-Google-Smtp-Source: AGHT+IEcYyxSrnvbunN8pvMo2nhGfg7HXbEenH0cs1jBHZW8VH0S+TnVPJ62UeJQ4D3GeYjpZrwpTQ==
X-Received: by 2002:a05:6830:25d6:b0:745:9272:4a34 with SMTP id
 46e09a7af769-7a04f35832bmr2601266a34.16.1758832950505; 
 Thu, 25 Sep 2025 13:42:30 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7a23193c8dasm599072a34.4.2025.09.25.13.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 13:42:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>
Subject: [PATCH 4/4] usb: gadget: Tighten CI_UDC dependencies
Date: Thu, 25 Sep 2025 14:42:25 -0600
Message-ID: <20250925204225.3560724-4-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925204225.3560724-1-trini@konsulko.com>
References: <20250925204225.3560724-1-trini@konsulko.com>
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

This driver cannot build when DM_USB_GADGET is enabled as both options
control building of files that use the same global namespace and
functionality. In this case make CI_UDC depend on DM_USB_GADGET being
disabled as non-DM support is the legacy choice.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Marek Vasut <marek.vasut@mailbox.org>
---
 drivers/usb/gadget/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 3a8ef45706aa..882f082c9cdb 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -148,6 +148,7 @@ config USB_GADGET_OS_DESCRIPTORS
 
 config CI_UDC
 	bool "ChipIdea device controller"
+	depends on !DM_USB_GADGET
 	select USB_GADGET_DUALSPEED
 	help
 	  Say Y here to enable device controller functionality of the
-- 
2.43.0

