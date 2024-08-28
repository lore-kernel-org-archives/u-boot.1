Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7720C54746
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 01:46:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE46A88B99;
	Wed, 28 Aug 2024 03:45:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IpE9ipUF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C73588B6A; Wed, 28 Aug 2024 03:45:54 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E8A588AA8
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 03:45:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-828fb8977ecso143090139f.2
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 18:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724809551; x=1725414351; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hhwqvU3fseCCKM2hz736E2KJ/uKqBRBZ46CxpHXfjFM=;
 b=IpE9ipUFFXDpxtF06gEX0alM9+bGY4URDENjeQJirU4QoOmVG0y7tiRx2+FP76YcND
 NSMuRYyWUgr3K99PhQhbNn95mVXFERWWk/rUAKeDBeY74m9JVpt0iojUdGmHh/AVGFDM
 FkSBJ6u5ko3fAIpbSdBJws51js1YHwX1zdoUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724809551; x=1725414351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hhwqvU3fseCCKM2hz736E2KJ/uKqBRBZ46CxpHXfjFM=;
 b=HNHN4lcxDH0nq7uHAb20TX5GDLe8R/7n7awMExE2SzdksGXc2T5T5dm1OvdPw1UD+T
 kxzbqJp7kn47Jv/k83CFsbxZH4rw0aCT4xU5j4W4NxqhMxR+5JeG5hzp94ALFOlf8T28
 1TKiPNGvtVy6XoPhZCznqOBwZDxpganu+Z1vAEIjJ8oDemAEVpYWSxCi6j0m1nOuil6w
 llcEp7uAfjiCj8xZZPVg0DFE0/Zjb1AAzrDbprv7ad5M8/5nOJOY93VMte7lkH6k7xu2
 bxRJ5BokR83mAT3TuPVxeH6ATGX9m+SqML6OtoHRTjeyNQ4pyBLeYUX9/rO29pB97MV8
 HHfw==
X-Gm-Message-State: AOJu0YxihcWg2jtt5K77qHNDWvD7pDLFvkEV4ElIUeiEmysnQKvik1LB
 PeO5Lwm+aWNPV8FosnJVUWQgdJDWtoPEmKEMdOl/ayqjaKb0FwMJWQiseTqq7G9gJ6DzbUDg0ko
 =
X-Google-Smtp-Source: AGHT+IFTTNjvdM7kowf7abrBW6QxXVWpgfmFCh86u5ZvEX0X6R6MhCLlQRrbYfSxrx4rdAgym1RrIA==
X-Received: by 2002:a05:6602:2dcf:b0:824:da31:5e8d with SMTP id
 ca18e2360f4ac-8278811f52emr1758881539f.7.1724809550998; 
 Tue, 27 Aug 2024 18:45:50 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ce70f5ca7csm2898342173.63.2024.08.27.18.45.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 18:45:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/18] fdtdec: Support separate BSS for all XPL builds
Date: Tue, 27 Aug 2024 19:45:23 -0600
Message-Id: <20240828014538.3322013-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828014538.3322013-1-sjg@chromium.org>
References: <20240828014538.3322013-1-sjg@chromium.org>
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

Adjust the condition so that separate BSS can be deselected for TPL and
VPL.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/fdtdec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index 5edc8dd2f9f..106bb406365 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1232,7 +1232,7 @@ static void *fdt_find_separate(void)
 
 #ifdef CONFIG_SPL_BUILD
 	/* FDT is at end of BSS unless it is in a different memory region */
-	if (IS_ENABLED(CONFIG_SPL_SEPARATE_BSS))
+	if (CONFIG_IS_ENABLED(SEPARATE_BSS))
 		fdt_blob = (ulong *)_image_binary_end;
 	else
 		fdt_blob = (ulong *)__bss_end;
-- 
2.34.1

