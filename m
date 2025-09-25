Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8935CCAC5B5
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 20:42:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80A97809A5;
	Thu, 25 Sep 2025 22:42:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MBu8upW7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89675809A5; Thu, 25 Sep 2025 22:42:30 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E6E88003E
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 22:42:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7a7c1ecd433so308660a34.3
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 13:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758832947; x=1759437747; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GZ/m73j9WPnsKFQugDnTzX2lY9/TRtFu8/mtndqbrto=;
 b=MBu8upW72sbsUbl1ACCmMiNYSO3qeW6MgkJHD46zkZLZy4kDtus2qxS2ksZOvAHpnP
 7o6Dbz7OKGS9BLODroQqP6q3ftSHjdfu7BujVqnqJy5mhiDEKvyIIv6EyW31z0Ga998b
 58DVrO0Up2UpkZQoKOE7R2Z6EduFIqG7uVeZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758832947; x=1759437747;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GZ/m73j9WPnsKFQugDnTzX2lY9/TRtFu8/mtndqbrto=;
 b=vJwFtvnyHBcuTaTXUy0CrG0557Bkwuie9SgnwglqdGVgUlqbYzeuHGs1psOqtGAEVO
 8ZMo7T2XO6ylyRZoR9DywljVvQFCXSy5oLTLnsn97PY3Wq/X8gBcS2/t+G1h4yOZjz75
 ueKR6AHHtJV/aqwG8vxHD9ChXJS2MGwInccDI9ptdsQxB1mrm6JN6+OWgWMtDIhxo+gk
 M/JrtCRvJiQgGxM1DARtXJulVL4NRbT8X7Me0OXitOQ2jTUgZ/k42b61zro4klWXEYbY
 a1mAqJBFmQeZ7qtH6alt2wG1kgvIukgyWY5Vh5ONzgzhJJzXyhuzCyB9wTex/O7+kcso
 STDg==
X-Gm-Message-State: AOJu0YxwoIlsJcMZwDh3680eEyPPBvZXLmD45PmKuyZ6pZCgPMJs1+fm
 cQJGV/nOYbaNmFsRJA8tD+YUtKuuABY3cBEhGf19wtqc9rV5fMZTptokKcPZjgociFSGepMSK13
 Ok3YnsSQ=
X-Gm-Gg: ASbGnctZ2uNLx3wf54yY3xla5OpOfXhA/L5pNYTUb7RI+VxmX7/gbcWkoXDyQo0v25X
 YAltoW4OtF8dBKmXNgk9ngMmymkvtcNwo8qEddUBWPP/opHRkfhHCyDk0juTc2meeWn+bXpCSjg
 rXBwLXEmhOdFWGNM2i7fBGtECySptLrVooaePU0NLryhC6ll9z4+ghQQquVubdo0dJiQn6aLPJI
 2sBsxAvGRybFh+vWSr960CiX9nSl9MLjs8dHKq6ArmoP/3Uc1Dh5fKVdagdvnsD2WsPhI2fSJHB
 Aoyw1yRQKW/Al4Wd6tQiLLmf9496DyQlXUC1eccFXA61pEcCqwu3X199V1rJYFb5zZjy/U8fh6e
 JNHZ7kuL+kPOU9Q7JUjQBqL83FWKBxMzlL58EufUoHKhzYBKZei3g414Clfl2GbN/dojnhg==
X-Google-Smtp-Source: AGHT+IFGkuVwEQ4dDqkeCLC0Hh+ZYFrY444XI1xJ9PouPaCaClmLlteI8dUMWIAlHcIZxpNgIhsiiA==
X-Received: by 2002:a05:6830:3810:b0:757:5bc5:3f2f with SMTP id
 46e09a7af769-7a04fed3af6mr2396685a34.36.1758832947032; 
 Thu, 25 Sep 2025 13:42:27 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7a23193c8dasm599072a34.4.2025.09.25.13.42.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 13:42:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Marek Vasut <marek.vasut@mailbox.org>
Subject: [PATCH 1/4] usb: musb: Remove reference to drivers/usb/musb
Date: Thu, 25 Sep 2025 14:42:22 -0600
Message-ID: <20250925204225.3560724-1-trini@konsulko.com>
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

With this directory removed, remove the reference to it in the list of
directories to traverse.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>

Marek, can you perhaps please fold this in to Peter's 3/3 on musb
removals? Thanks.
---
 Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Makefile b/Makefile
index 0dc7da6ddac7..1697e95c0a06 100644
--- a/Makefile
+++ b/Makefile
@@ -1040,7 +1040,6 @@ libs-$(CONFIG_USB_GADGET) += drivers/usb/gadget/
 libs-$(CONFIG_USB_GADGET) += drivers/usb/gadget/udc/
 libs-y += drivers/usb/host/
 libs-y += drivers/usb/mtu3/
-libs-y += drivers/usb/musb/
 libs-y += drivers/usb/musb-new/
 libs-y += drivers/usb/isp1760/
 libs-y += drivers/usb/phy/
-- 
2.43.0

