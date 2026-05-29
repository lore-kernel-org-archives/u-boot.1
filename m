Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8325CD4F54
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 20:57:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 055F0846A3;
	Fri, 29 May 2026 22:57:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gVZWr1w4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D9D9846A5; Fri, 29 May 2026 22:57:55 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E735805D7
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 22:57:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-43a2ad7bcc4so6641479fac.1
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 13:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780088272; x=1780693072; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OUxcsaj+A3JLrX9/c2nJSOYdR2ZSrmu0vt8EI6abbmw=;
 b=gVZWr1w4eFvODa+nm3VY4Ms2UiptTHmieTt3ch7ds2oGkdvD10xn0U1pyRY+38dZEx
 9vSmOq5vZUYTELQqJijl1bIvE5CYtiCPe5cjWD6FY335+JBF3vRN/qmo468+kOYCzutv
 0IqtHQi+0BDIrVu5OTNzBXVkUXjwh794FzGNASHCsqp75p9lPrvuGIkK1m4DHgkgkJii
 IGZ12e8gWeMPVTHdO/SAsY1iV2mdSJGTIJZ0mK7MyyFIgeEGNbf21hASuSDFBF1lC9A7
 hpS8S5zV8vkEWZUx9EhlW6Xy21xg9bWjZsfnfgbn85FaZucWnG5iME8ZrXqDFR04uXv/
 BCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780088272; x=1780693072;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OUxcsaj+A3JLrX9/c2nJSOYdR2ZSrmu0vt8EI6abbmw=;
 b=qPxoKtspSS3R+lspkhkx8vCvhHqyMkF0DLjujlMC92AiQQ1YeJmix/TRlAUhDsId6f
 5z4/pGzQeUoxxw7Llsswp/tQBdc3iK4Yc8FUWDhrwH7sPqwri0wLYmzA2Br0r/tAeOST
 N2HFiP++ZIgEtopjBHCwaTJLfPZhxqXGI5yim1k6ux4DIYEejiE1pLUJvp3Ikq6vK30S
 ahy6sYpDs7htNOZ29mYHdNOyx6XvFMuEbhJLYv9LoQSkphinlJWwTZyxxsdNjfo+VqQM
 XChFONwRnfOYHBMx5LBy6f4QItUkDm7zhFJgPm1TE+kM5vB8Xc5IzZ9jjrejyCshsglj
 Oi/A==
X-Forwarded-Encrypted: i=1;
 AFNElJ89kymUl24kxUvibE9An+/r9Hp8XLmX+TdHGhgBPkfFlbjV/G2zN7gHrMFyBkoMPj/rSw5qQdE=@lists.denx.de
X-Gm-Message-State: AOJu0YzI0PskYZhNb+/oc3AUv7W+kiW7z3egivsqlA3Icn9oa8/4fZ3E
 ovusKyoNjDLkREyMtGuzjXhgCaBcSrr9O7RBj9Mqv/Wu7r8EJ6+pBYKV
X-Gm-Gg: Acq92OENIIOPAiCWvcqHyCwE6odo6iHIPhGT8hqxnsGlgrudTU3BKQ8W+Hv76chqCgC
 +n7KW5MTl8ocAF4ZMkIcq0nz7LHJ/7mGX/WdGKr4AKZTgkIb/HGrUdSm36B18FlPXG60kxRUQ07
 I7fcqbLYpQALMyWQpC1+Nvf+Ap94axJhzN5V5Hf/i1glrjc9ASs2BF8P1fTzeQyozOED56anE9p
 Pbe/12l4lmwqjS/D3XsRp/RGseFtAYcoU6pW2pDYDPxqk7bZJQKBahnBIoU39Hky5n3s6R3eYUp
 1cK30jzFb5cvRz7W7PvfTXjNkFpR4YHbjiX8yxQ5N9zwuH0o9umO7wVpf8GXj/1y2bBOFaiIJed
 vhb6tDUWcE9ZLkkbs9W5Hy0S8hd1mRyqWpDVqjudPNMYfdDN8Wjd6KzNRBCqLE/TegdJne3CJ1b
 eUICY9bdZ0RjrBi8wKsWNROy/7D1p2+uUJIrRCnHEaIDEFaUmV/De4uewb5FE7cIYKfoqhgcrJG
 Qx3RhhQDzR5h2jRH044DF4F3bt4Q3aa8RI=
X-Received: by 2002:a05:6820:20f:b0:69e:84e:d651 with SMTP id
 006d021491bc7-69e105a1b6cmr507996eaf.38.1780088272053; 
 Fri, 29 May 2026 13:57:52 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43c93ef894bsm1886804fac.10.2026.05.29.13.57.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 13:57:51 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
To: Stefan Roese <stefan.roese@mailbox.org>
Cc: Tony Dinh <mibodhi@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Marek Vasut <marex@denx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: [PATCH] arm: mvebu: usb: enable Armada 375 in XHCI driver
Date: Fri, 29 May 2026 13:56:12 -0700
Message-ID: <20260529205728.17491-1-mibodhi@gmail.com>
X-Mailer: git-send-email 2.47.3
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

Add armada-375-xhci to the compatible list in XHCI MVEBU driver.
Tested with WD MyCloud Gen2 NAS.

Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---

 drivers/usb/host/xhci-mvebu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/xhci-mvebu.c b/drivers/usb/host/xhci-mvebu.c
index 12dc61aee9d..9d45d0ef8fc 100644
--- a/drivers/usb/host/xhci-mvebu.c
+++ b/drivers/usb/host/xhci-mvebu.c
@@ -82,6 +82,7 @@ static int xhci_usb_of_to_plat(struct udevice *dev)
 
 static const struct udevice_id xhci_usb_ids[] = {
 	{ .compatible = "marvell,armada3700-xhci" },
+	{ .compatible = "marvell, armada-375-xhci" },
 	{ .compatible = "marvell,armada-380-xhci" },
 	{ .compatible = "marvell,armada-8k-xhci" },
 	{ }
-- 
2.47.3

base-commit: 32f40f9c7602910466c42eb184329a54045bee6f
branch: master
