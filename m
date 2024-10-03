Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0827CF34B6
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 15:48:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01DA388EFA;
	Thu,  3 Oct 2024 17:47:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UwzqyZo9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD9F288F3F; Thu,  3 Oct 2024 17:47:27 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C082E88E7A
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 17:47:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42cbbb1727eso11371115e9.2
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 08:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727970444; x=1728575244; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+9X+r8Q8NFzSd6Hb1M2hwnGKuGR3j9GDjlrMCZXXI9M=;
 b=UwzqyZo9QK9uNy4LByyAkqPlBR/kWclCEn73FXk9NluRwCqUyP8TwlHDdXWxrgzUor
 wGPXVmSlrCtbwrasy8JUmS/YFamzmMZrgUq8t+R41UGrrhbgXZ56raLiqmFJCvUMuwEY
 vTPNVvF1HBuM+wHXY7x20hUBkv2t38ruXFO9FIkW8oBoJTwAET/wvtQe3/2zaECOy+3Y
 nfG5aD8xDZs2qyt7RvJwhTOf8Hs+XD8+LGpHK7PBSy8UKIwv6zITyZF67sr0g6Ova5A6
 0lN1Knq7xzTIwtUGNuUuISNwuRBhqxYAv0mulLK5t9HisBq3BXpLr+tJFA3z1qhh7voV
 vERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727970444; x=1728575244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+9X+r8Q8NFzSd6Hb1M2hwnGKuGR3j9GDjlrMCZXXI9M=;
 b=lV9AY8eC58SBVPUcoqRzXkTqSk60wOnWhtzIFKyuYl1cIgtqP9GwYxOaez9J59PNZW
 4EOMgmdKTGqvlZ9n8YuQAlMRp/BiDl6FMgwkPIJgBbnGqIhdtxDcOTYJr6VCbxMMyQ26
 xReHhIySTQpe+/K/eTY6LFsiHzQ3sV9WBLZOEqpOlLsPtgRr6YQMqegL3ySefYnP5ec5
 EMK4ltqohBj02JJw0fsxbJTfwm1vVmS6rYQfq1T+4x4ant1q5uMGo1kWYp3oCWPydC5u
 itKdix0MMoeLlUFj6uMnMHlfCOsbYRV0RZTvHnp1mQKH34MU/hqd0LElHfynkTmvul5O
 /Aug==
X-Gm-Message-State: AOJu0YwlpVNvM5n62crtaJHIyJsh9u+Njsj0KMY+YvHCaOFQ0ySnkj8b
 dpP7WDhwfqDVmVSunBMTBK4YmYpuuF+Wdg6A+MMZPczoctiTI7AR55Q9PCFDQ6DPCf7B2zk2zjD
 0EQcaT0A4
X-Google-Smtp-Source: AGHT+IHQLmz1bB6ZBEm82dQZwpL28EaYYq5NqRzMqE2y+qOAaHGhcwK5TXSY/Km7m5kAUC5pdEoxdg==
X-Received: by 2002:adf:f8c3:0:b0:374:b35e:ea6c with SMTP id
 ffacd0b85a97d-37cfba0786fmr4075603f8f.40.1727970444574; 
 Thu, 03 Oct 2024 08:47:24 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d888:7a58:deed:47d6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d08245059sm1541748f8f.55.2024.10.03.08.47.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 08:47:23 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v11 21/29] cmd: bdinfo: enable -e when CONFIG_CMD_NET_LWIP=y
Date: Thu,  3 Oct 2024 17:46:25 +0200
Message-Id: <6e2f569d54ee386294a0ed918f71c2e177e9fa2f.1727968902.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1727968902.git.jerome.forissier@linaro.org>
References: <cover.1727968902.git.jerome.forissier@linaro.org>
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

Support "bdinfo -e" when lwIP is selected.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
 cmd/bdinfo.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/cmd/bdinfo.c b/cmd/bdinfo.c
index f6e534dd5bb..4c0e2adabc3 100644
--- a/cmd/bdinfo.c
+++ b/cmd/bdinfo.c
@@ -151,7 +151,7 @@ static int bdinfo_print_all(struct bd_info *bd)
 	bdinfo_print_num_l("relocaddr", gd->relocaddr);
 	bdinfo_print_num_l("reloc off", gd->reloc_off);
 	printf("%-12s= %u-bit\n", "Build", (uint)sizeof(void *) * 8);
-	if (IS_ENABLED(CONFIG_CMD_NET))
+	if (IS_ENABLED(CONFIG_CMD_NET) || IS_ENABLED(CONFIG_CMD_NET_LWIP))
 		print_eth();
 	bdinfo_print_num_l("fdt_blob", (ulong)map_to_sysmem(gd->fdt_blob));
 	if (IS_ENABLED(CONFIG_VIDEO))
@@ -192,7 +192,8 @@ int do_bdinfo(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		case 'a':
 			return bdinfo_print_all(bd);
 		case 'e':
-			if (!IS_ENABLED(CONFIG_CMD_NET))
+			if (!IS_ENABLED(CONFIG_CMD_NET) &&
+			    !IS_ENABLED(CONFIG_CMD_NET_LWIP))
 				return CMD_RET_USAGE;
 			print_eth();
 			return CMD_RET_SUCCESS;
-- 
2.40.1

