Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36C7C3DA66
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 18:48:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1813E86478;
	Wed, 23 Aug 2023 20:48:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aIkdFC7F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EF05864CB; Wed, 23 Aug 2023 20:48:08 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E8AD86427
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 20:48:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7921006459cso165467739f.2
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 11:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692816483; x=1693421283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5udvm7lPqjeLb6FSAX9VPZ6RIch5vHKq5PyZArJCA1A=;
 b=aIkdFC7FQ80FJ9sdLsCwPIdgxA0A0VmCAeQ+HyklZ6GY9AVmkTwFiy4a9xpxbWHTih
 NEYYhcYKv2/vsaw+o9HvVc6V874n/xGVfp4ik0db2OWPlkt42qwkecxVFk61LCAOtZBj
 Ha4lAzhECSF58hT8WUWRuM3PEv/2rCPmWRIWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692816483; x=1693421283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5udvm7lPqjeLb6FSAX9VPZ6RIch5vHKq5PyZArJCA1A=;
 b=ZBo061c4D7ACb50oH7XGuoaAu0IIBpjEX/RpfTQ4lBj8GUrjKyHPrPfrwhGmpKOTQh
 Si2356GLyclBw93inLhd2MX4t9Z+gmjydZLb9Z1uMVuc5Vz3qh4QiIu/pS4uaivgWduJ
 OZK88jfLAU1DvFb2gPS3yYYisEy8P4BF5h588fix1sJbhHD9kihGPEgrC/uhsjAF7HeV
 MZAjGwsST+y0O/Ec30n4oWfW8UZ6E1Re9wGfSzRg8vpHAGu4sc0ocHU6QETvvgCgZ2M3
 iZb8lT5kk1Qx45PbtmRFBKfS+hawh/p4aVbIug8fX9ESEk4W63EtBH2L10g9Zktu41z4
 5Hhw==
X-Gm-Message-State: AOJu0Ywc/olqlWCsmOpX8VfTuEQVvprRAmGMrWldiBqitYitxtlKEzrK
 +XQ+vuWrBC/vfDBcdlgIOQ9HzBCYsBJdf1VfTZQ=
X-Google-Smtp-Source: AGHT+IG/YWFC2W7VEeDNmrxciJQJjK6w8PTw3BTXf+++fAMP8tu3Dc/EFeMya2fX93aPijJr1Kx3+Q==
X-Received: by 2002:a6b:7206:0:b0:791:1951:1df0 with SMTP id
 n6-20020a6b7206000000b0079119511df0mr3738941ioc.18.1692816482996; 
 Wed, 23 Aug 2023 11:48:02 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:938f:460b:b19c:dee2])
 by smtp.gmail.com with ESMTPSA id
 u20-20020a02c054000000b004182f88c368sm4070929jam.67.2023.08.23.11.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 11:48:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH 4/8] x86: spl: Change the condition for copying U-Boot to RAM
Date: Wed, 23 Aug 2023 12:47:37 -0600
Message-ID: <20230823184746.842091-5-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230823184746.842091-1-sjg@chromium.org>
References: <20230823184746.842091-1-sjg@chromium.org>
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

Make this depend on whether the address matches the offset, rather than
a particular board build. For samus_tpl we don't need to copy, for
example.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/lib/spl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/lib/spl.c b/arch/x86/lib/spl.c
index 58fa572b71a..335dacf47fd 100644
--- a/arch/x86/lib/spl.c
+++ b/arch/x86/lib/spl.c
@@ -258,7 +258,7 @@ static int spl_board_load_image(struct spl_image_info *spl_image,
 	spl_image->os = IH_OS_U_BOOT;
 	spl_image->name = "U-Boot";
 
-	if (!IS_ENABLED(CONFIG_SYS_COREBOOT)) {
+	if (spl_image->load_addr != spl_get_image_pos()) {
 		/* Copy U-Boot from ROM */
 		memcpy((void *)spl_image->load_addr,
 		       (void *)spl_get_image_pos(), spl_get_image_size());
-- 
2.42.0.rc1.204.g551eb34607-goog

