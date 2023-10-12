Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05693CDB465
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 02:10:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 618CB86D85;
	Thu, 12 Oct 2023 03:57:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ni757Otj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A82A286CE8; Thu, 12 Oct 2023 03:56:58 +0200 (CEST)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6480A86DD6
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 03:56:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-41959feaae2so3076091cf.0
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 18:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697075793; x=1697680593; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A97MTcBKZXcYrBBFTME0+V9M9hq8+zEzRrrjccgQoyQ=;
 b=ni757OtjgZJUE55yW6O6xJ7iahd7CwmEiXuHwHVRxmgcvDjafwnqhJANqmiXFAbNHf
 P7VdMmlmqRJmtS/L6wuJ5+a32Ju9BccF7l/bCvRF06ag3feCDfUGGmSzw7/cbf6bFxly
 vLeH/KzLlKifsYZhNiLtdlNmPCeuSO29UfQBEGwd8aX2+meoApleFPx1ke0QtnJAWOx4
 0SUNSX1q8JU20W/OytYQ0h4OlKGVozoVJnMTskzr3rTLxrb9jcS01vzen56aVxPKoI4I
 Q3D+IFzp4bf7peiQ7SbuJ15r6pKPBjmvepO8O7AnjM6p+SnzTVVu2OtG0wTznzeot09B
 93Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697075793; x=1697680593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A97MTcBKZXcYrBBFTME0+V9M9hq8+zEzRrrjccgQoyQ=;
 b=D9Ty2rJzIUS99Cu34QEr/FjONgx1x+4B6+ncIPDylaVn+qg4CI4LBaix3B27IImotl
 1Fs5gZ7RV1phGHHUKUJFhfYd0CcJX3F49pTCqfXJW1qaDrD4HWSiWh2VCdeORAUlGyWl
 ULKtXbyMGCnduG6Vm0608caoZaJ/0p5DmM7W4HMeTodE4mD/pWy7VU8/hP4sj0zsBhV4
 GrOgLkn9rv9vwcchPfB5qGYMQ3C8PBLH0nmsZRkgrzDSwdHCWiOx3tuLbhI8IMB0L6T3
 ibxsWG/GY1ZAqlY/8hyfjyxTcBMLKdBwqpJkFfHapMjdnNUnrNskFcD1HMRP9DvU0kgN
 OQjg==
X-Gm-Message-State: AOJu0YwDyB7Qfw2fwMiujg0Lei0Ggsp8JcrxuXfz6VcLLzHEbtjHrmgB
 IDqbf9nGuMWIE1Pb9EGF1Sz3Z7JPkhakiQ==
X-Google-Smtp-Source: AGHT+IFE3Bz90XndlvwGSCyIduCe8/vPcHJMqm+rG3LAYHuQ7rWRAnPo0FzUcoOH48BQ++3Qz/iX4g==
X-Received: by 2002:ac8:4e55:0:b0:419:9975:8096 with SMTP id
 e21-20020ac84e55000000b0041999758096mr29012382qtw.49.1697075793400; 
 Wed, 11 Oct 2023 18:56:33 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 m13-20020ac866cd000000b003f6ac526568sm5827585qtp.39.2023.10.11.18.56.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 18:56:33 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 uboot-imx@nxp.com, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Stefano Babic <sbabic@denx.de>
Subject: [PATCH 04/26] arm: imx: Fix i.MX8 container load address
Date: Wed, 11 Oct 2023 21:56:04 -0400
Message-Id: <20231012015626.3487451-5-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231012015626.3487451-1-seanga2@gmail.com>
References: <20231012015626.3487451-1-seanga2@gmail.com>
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

We should load images to their destination, not their entry point.

Fixes: 7b86cd4274e ("imx8: support parsing i.MX8 Container file")
Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 arch/arm/mach-imx/parse-container.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/parse-container.c b/arch/arm/mach-imx/parse-container.c
index e2a9e2b2732..d7275a58c17 100644
--- a/arch/arm/mach-imx/parse-container.c
+++ b/arch/arm/mach-imx/parse-container.c
@@ -45,7 +45,7 @@ static struct boot_img_t *read_auth_image(struct spl_image_info *spl_image,
 	debug("%s: container: %p sector: %lu sectors: %u\n", __func__,
 	      container, sector, sectors);
 	if (info->read(info, sector, sectors,
-		       (void *)images[image_index].entry) != sectors) {
+		       (void *)images[image_index].dst) != sectors) {
 		printf("%s wrong\n", __func__);
 		return NULL;
 	}
-- 
2.37.1

