Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD48C4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 11:28:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB1F68767F;
	Thu,  2 Nov 2023 12:27:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="feyvEFdJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46F50876AE; Thu,  2 Nov 2023 12:27:58 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32D2287656
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 12:27:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-507a29c7eefso941017e87.1
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 04:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1698924473; x=1699529273;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wBoEF0aiE2g2JOYYwdSi7MFNP9FFxPqCvM3pkVNOTG8=;
 b=feyvEFdJNYrEbTy1seb79qYDyQwWGKtWMuRs7+3vCINyGMTbagAu9xQAyLmqSuiHC9
 qbzlvWP6QOwcGvFBMWlJoNs7qjwjVKJXZ+KB1ZFKqoKiC8OgFaqeprfswQac8DvvnZkd
 XINRIXeYtGsHK/jhkS2QEbYvvV5P83aEPZfWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698924473; x=1699529273;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wBoEF0aiE2g2JOYYwdSi7MFNP9FFxPqCvM3pkVNOTG8=;
 b=jdBwP+N90Hszh0ljAfbs/a4itPQIhuBz85Vy6uv2VhK26M/r6hr2IB6wMBfnJGMpYJ
 pVXxwAxxAUucMi6R9U8FfFOoISmiNm5GCHUzRGp0Z/c77xAH8YJuYom9FOHVlcGNeycD
 mp0BwnPI7CFEZ5r6r1NvuclVj1fiId7y8PT99MYVxjQ/EmcXWTZqH45BP4KjSfkhukwv
 GQWkolP1q6JF7mkSi+VnN/c60g6rbAWDlz704tYddO/ZzzDHQdSE08qLfHAYShlmaE8E
 JAuj/o9nsGI5ewVQgdVCEIg1GHFHW8u9pmLupJI5G27B/lHJcwm51iHVduF8LMcGxSxH
 R4WA==
X-Gm-Message-State: AOJu0Yy9nvEQ/QoKNim797/dEOaPUEbGNRiUTOEUW7MgVw72uwT1clzu
 PdkeSWS9AK2deghhryWWiTOQ9arYB8vMNE5wuiwZkQ==
X-Google-Smtp-Source: AGHT+IGQ9v77yOopDr4JrFFlIjrt9zFlJ4/Pj9XLsVzh2f0cp++gtJ9SnLQt1+mNsQ0lHMY/WOoC9g==
X-Received: by 2002:a19:434b:0:b0:502:cc8d:f20a with SMTP id
 m11-20020a19434b000000b00502cc8df20amr11855140lfj.27.1698924473199; 
 Thu, 02 Nov 2023 04:27:53 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i..
 (net-93-150-246-117.cust.dsl.teletu.it. [93.150.246.117])
 by smtp.gmail.com with ESMTPSA id
 r10-20020a05600c158a00b0040813e14b49sm2554867wmf.30.2023.11.02.04.27.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 04:27:52 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH] mtd: nand: complete nand_register() arguments check
Date: Thu,  2 Nov 2023 12:27:33 +0100
Message-ID: <20231102112743.57420-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.42.0
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

The patch checks that the "mtd" parameter is accessible before
proceeding.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 drivers/mtd/nand/raw/nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/nand.c b/drivers/mtd/nand/raw/nand.c
index eacd99c4e275..d31bb580c46a 100644
--- a/drivers/mtd/nand/raw/nand.c
+++ b/drivers/mtd/nand/raw/nand.c
@@ -52,7 +52,7 @@ int nand_mtd_to_devnum(struct mtd_info *mtd)
 /* Register an initialized NAND mtd device with the U-Boot NAND command. */
 int nand_register(int devnum, struct mtd_info *mtd)
 {
-	if (devnum >= CONFIG_SYS_MAX_NAND_DEVICE)
+	if (!mtd || devnum >= CONFIG_SYS_MAX_NAND_DEVICE)
 		return -EINVAL;
 
 	nand_info[devnum] = mtd;
-- 
2.42.0

