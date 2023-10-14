Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E0ACDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:10:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A461386F2E;
	Sun, 15 Oct 2023 08:33:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fqrY20Wq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24B8C86538; Sun, 15 Oct 2023 08:32:08 +0200 (CEST)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80BFF86F29
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:30:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-584a761b301so2566425a12.3
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 23:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697351396; x=1697956196; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8R/Aa0szxJk5yptxRZEYbCWg3SEylN0jHEF6JhwG+AA=;
 b=fqrY20WqzkRoTgf42LC2D8jsIeu7rcpcdwUFTDtKxd0twny7pj5k7hkq6sZleXuyk4
 4b16n6hbFjeLq7txAhoCIlhdbF2gP2CK02N03gvrHUdrXRKk+bYt3aUngmoqltVWEMTG
 CKVdaP+UNfb7YKHhFntg8KqZL4HT+2qoeYrAWXP1E9qdW6S1A/9zR2T746ilmhuwieMF
 35xcHUMjRCAtc4QAAmfqekElSQIkj9WU/LkMhtRqSM5RazZHVHoL0XOgdV9g+49fe8pC
 1S4zuUwwDpgdcX0TZLb4cPLrNTbKFTQxXfh0V6/s0f2FKrwJ92nrEq7k861tl0xpaFbu
 goDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697351396; x=1697956196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8R/Aa0szxJk5yptxRZEYbCWg3SEylN0jHEF6JhwG+AA=;
 b=TvJD2gulcCzpwIMBM9k/aq/yJHj5YaguoKpG4YXSVfDyTPpniez0G27zgZZMV7JX+X
 uGuW0fh0awYvJl8xbrpOK33nUui8AteU3rx4c48GHsVcpye6BrQhxBYPdMAYq96pvxsv
 vX1n6dIA9QRiwWwebEAyt0b8DnPtA6mPTMLarPqpuryINtBV2JKs/6WUailprzncKwIl
 o001OOOmTZiG1jSr09PPXyo0e92Ts3KeJfRP+tN3vgWsBVkgvj6uVZFispUSkhMMvZQe
 N2XsVntKmL3hM/ZOvbF8F/AXqHXusutA7KwWEL6SgHFg/K/4tiwKmZARfh5l4enkcbbA
 xR7w==
X-Gm-Message-State: AOJu0YyEuyZ0MmgPsS1bHUBLC+uK80UODIXme1T/5T5s9AJp5VInaEh/
 y3Ldwqrq5CLV2iDvHxsWupdxfb7L1JZGIg==
X-Google-Smtp-Source: AGHT+IGbtfrcZ2sBAn6EnwkN/d8jTEHoF2UMZ/KRWGf1BdmVS75ydbeErhvQgzpcPRw99rVKmOpopQ==
X-Received: by 2002:a05:6808:4d0:b0:3ae:cb4:ff0b with SMTP id
 a16-20020a05680804d000b003ae0cb4ff0bmr30766935oie.28.1697316493751; 
 Sat, 14 Oct 2023 13:48:13 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 p9-20020a05620a132900b0077434d0f06esm1698986qkj.52.2023.10.14.13.48.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Oct 2023 13:48:13 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <seanga2@gmail.com>, uboot-imx@nxp.com,
 Fabio Estevam <festevam@gmail.com>, Nitin Garg <nitin.garg@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Stefano Babic <sbabic@denx.de>,
 Ye Li <ye.li@nxp.com>
Subject: [PATCH v2 05/29] arm: imx: Add newlines after error messages
Date: Sat, 14 Oct 2023 16:47:41 -0400
Message-Id: <20231014204805.439009-6-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231014204805.439009-1-seanga2@gmail.com>
References: <20231014204805.439009-1-seanga2@gmail.com>
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

These error messages are missing newlines. Add them.

Fixes: 6e81ca220e0 ("imx: parse-container: Use malloc for container processing")
Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

(no changes since v1)

 arch/arm/mach-imx/parse-container.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/parse-container.c b/arch/arm/mach-imx/parse-container.c
index d7275a58c17..c5df78d1c58 100644
--- a/arch/arm/mach-imx/parse-container.c
+++ b/arch/arm/mach-imx/parse-container.c
@@ -85,13 +85,13 @@ static int read_auth_container(struct spl_image_info *spl_image,
 	}
 
 	if (container->tag != 0x87 && container->version != 0x0) {
-		printf("Wrong container header");
+		printf("Wrong container header\n");
 		ret = -ENOENT;
 		goto end;
 	}
 
 	if (!container->num_images) {
-		printf("Wrong container, no image found");
+		printf("Wrong container, no image found\n");
 		ret = -ENOENT;
 		goto end;
 	}
-- 
2.37.1

