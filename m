Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01592C25B6B
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 18:32:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFF9487640;
	Thu, 26 Oct 2023 20:31:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jn1G/N0N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A2588762E; Thu, 26 Oct 2023 20:31:48 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A7B6875B8
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 20:31:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-586beb5e6a7so87443eaf.1
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 11:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698345103; x=1698949903; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MjA5r6OateBSE2unsZ/rZ6JI0fN4mt9QeKnejMnUv7U=;
 b=jn1G/N0N3P33asTVpNyJzmmFXwHykUcyCN7I/td7xE3jjzVVDyDWpRs4nEWWtUQPXd
 Y+WW9vo2cguxOrxY2uETqjlq7uOmQ5KzCXa/fDGkktNKrTj96L1PFSEEfotj62SIZxLr
 nPDepwEfx8sIoPv6+h9Ms/L5+96dIpOYKs1Ec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698345103; x=1698949903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MjA5r6OateBSE2unsZ/rZ6JI0fN4mt9QeKnejMnUv7U=;
 b=ljerJeU0Pi7tQHMmTcZHzyK+jfy1mYPiWhfnvYRm9GoRer/28RgebojdWtmkVYN2sU
 POPz4rxIC4ST7l6R7h59FZhqHs+GWfk5tUiYWAWUXOsMCEgv714Ht43Myxu2v9nCw57z
 zlJwld2r4JIi+YM7mP89ABL15jqRzs7wFruWDOBTxl1xHS/gLIgoVHRZ1/cEOBp2QHX9
 RpZul8ThNrV+HnnXozNvtU+6ttSpTPxDYlvPy7Rnk2QdU4iQMgh8iK0B6IomFBzmDEuP
 vTgMAx99+218wC5QwNWL+SXb4C3hUHja34orccIM1JYsmXkUGOqzvFNR60vC7ny6QrqG
 2NwA==
X-Gm-Message-State: AOJu0Yzqjy9PD1JapzC7Cqfaue8iW0Mf1NKR9xms6+nEKWD1DrTJCoEN
 KbHVKxKJww+6qQhFB7mhg2twEvspC4ugmyjqpykb/A==
X-Google-Smtp-Source: AGHT+IFqzH1ODQ/1C4EJvg9bJjo/NpHd2JhxaamkiDUYhlags0C7z4IPfmJcl/N6RrbYMULEzQgCoA==
X-Received: by 2002:a05:6358:51d8:b0:168:e156:c9b9 with SMTP id
 24-20020a05635851d800b00168e156c9b9mr403681rwl.15.1698345102845; 
 Thu, 26 Oct 2023 11:31:42 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-6a0e-a72f-3fdd-31b7.res6.spectrum.com.
 [2603:6081:7b00:6400:6a0e:a72f:3fdd:31b7])
 by smtp.gmail.com with ESMTPSA id
 az39-20020a05620a172700b00777611164c5sm5175623qkb.106.2023.10.26.11.31.42
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 11:31:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [v5 04/30] dfu: Make DFU_TFTP depend on NETDEVICES
Date: Thu, 26 Oct 2023 14:31:12 -0400
Message-Id: <20231026183138.636948-4-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026183138.636948-1-trini@konsulko.com>
References: <20231026183138.636948-1-trini@konsulko.com>
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

In order to do a DFU update over TFTP we need to have some network
device available, so make this depend on NETDEVICES

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/dfu/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dfu/Kconfig b/drivers/dfu/Kconfig
index 4e80e85d10d7..8771678ca5a0 100644
--- a/drivers/dfu/Kconfig
+++ b/drivers/dfu/Kconfig
@@ -19,6 +19,7 @@ config DFU_WRITE_ALT
 
 config DFU_TFTP
 	bool "DFU via TFTP"
+	depends on NETDEVICES
 	select UPDATE_COMMON
 	select DFU_OVER_TFTP
 	help
-- 
2.34.1

