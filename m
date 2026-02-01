Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B49E7C6F9
	for <u-boot@archiver.kernel.org>; Sun,  1 Feb 2026 00:46:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2FE483C29;
	Sun,  1 Feb 2026 01:45:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NcHNNqcz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D5F183C02; Sun,  1 Feb 2026 01:45:27 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F282C83AEE
 for <u-boot@lists.denx.de>; Sun,  1 Feb 2026 01:45:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-790884840baso30257207b3.0
 for <u-boot@lists.denx.de>; Sat, 31 Jan 2026 16:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769906716; x=1770511516; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MQ26QxmxKABaOHUXmT6Lw+D/DHvjYkJPWsDiBkGYqCc=;
 b=NcHNNqczhoI0QfdQERbLg5XiOb+LrAyoCRk2Re/cPe3Avn6zwjTRzD4BII0YR52dae
 gHHQJQTT0wHJU3n3Bl1OxiSTrQQgXWamfbBhWqFeLPxWU+mq6nY/LMfotjftWgBCTMHS
 D3W7D2LYPaoUjLIjn/2Cbw7+AIuBPKZaz4sUq6mf/NqQT4NSytfhBYdSIoRDO+AwUI5u
 QaKCz04IH9VGN45zpxYeALCZqNnux0mRgQGN2SEtwni99kN8DozbmhszUNbGhkYHcN0k
 JEaJYoSafwECaBHHbnLQwM6bUmQHHHsjHonmq6ASCx4doquTY5VuCyJs3E6g8QNgZ7En
 DonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769906716; x=1770511516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MQ26QxmxKABaOHUXmT6Lw+D/DHvjYkJPWsDiBkGYqCc=;
 b=GGIVeFbYN6wa4KnJw89ubKzpBwJQ2BoioNXDSvk0oZ7V45Sk4o+o0OkZs5kcmQC7qf
 9ATd9h+LJ4OEJw8DUGrjDub8G/Ud3HtvXkBm1wC/1TftZ58Jmp6FgB9KDUF8X5FCJKzQ
 jKN2TpsWRPX2PtmguI4vJhhqQ8TNIcEdnH8db8wY5oQdAuuNGpk28FPKA6o3UQlvnCFh
 /jpyDsc6Y+Sh91VkyfK5zFA7nkzP6bkr2jZoqvaEdYkYF9WUb/f9iT1GikTfiBwI4RSi
 VWbB+XhucfTyWveOZfqOYiO1b9gSXS68euJdRudRHf7akkdtJnHMQMgVeqMVHQU5W7IU
 3S1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWU50Xz5m+8IvWChCgHIY6+2W3dZySPVr6zXau7dqXYjioHAmY9beIPCVFBReQvDuqIJuQXo0U=@lists.denx.de
X-Gm-Message-State: AOJu0Yzy0K8PiGN6BDph6Xn2zBUgQ/eSWlOhzs0QyOfJbs0doCb/vnEW
 KKqsxT9Hw+N1zyMlB9E3eA1+ie3ytB6x3V+0X6deK4UhURbF15ziWmE+
X-Gm-Gg: AZuq6aLFWKlgs7eGvUqNKVEVBW0uQsGOQkcVO4xpjgYMZLd7JykP3aUXHrakItSn2Oe
 VwrqGYCvQIMQeffUxYyOJrJ06Q+KAezhbcaceGp2DqyPhWGqFyiRILru1/jyDtp6jyMVHDFXqsY
 iwyfEWQMOQmzBcJD8GEMtBXjEnADCGT1FPfqvjDYkFj8c4RqvCsHKym0NdathW8aJASuMTjx56d
 UITH70IldBRi/u7POlHuZBKkE9btMqq38NLIuvHtOCx8jO5ME5jeuM94pXQs7ihtDbaFrfrUFlQ
 lJXIEufhu/Z0Bl6OiFWqthQhgeZTaaaCOZAXOhTUO6CXNXd49cp1p7x/Pnx5zi3zBZaHMhfzxdZ
 Zuq58EPs9h0ITWYHE7L2eCHaM5ozIIANRN3mkHpGn1Aw/sYDRKkNVe25W59D0wIUC/C3ma/xJJo
 szdNQj3ngjSA5L5efXH88Kez5h
X-Received: by 2002:a05:690c:e586:b0:794:19c4:c47d with SMTP id
 00721157ae682-7949dfbb73bmr40291297b3.41.1769906715765; 
 Sat, 31 Jan 2026 16:45:15 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:419e:8d46:1302:65da])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-794828ad9cfsm52105097b3.29.2026.01.31.16.45.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Jan 2026 16:45:15 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: kever.yang@rock-chips.com
Cc: trini@konsulko.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH 3/7] tools: rkcommon: Add rv1103 support
Date: Sat, 31 Jan 2026 21:44:52 -0300
Message-Id: <20260201004456.763107-4-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260201004456.763107-1-festevam@gmail.com>
References: <20260201004456.763107-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@nabladev.com>

Allow rkcommon to generate an image for the RV1103.

Based on Rockchip U-Boot 2017.09 next-dev branch.

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
 tools/rkcommon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/rkcommon.c b/tools/rkcommon.c
index e7e78ef7e5b7..c680c0144fef 100644
--- a/tools/rkcommon.c
+++ b/tools/rkcommon.c
@@ -148,6 +148,7 @@ static struct spl_info spl_infos[] = {
 	{ "rk3328", "RK32", 0x8000 - 0x800, false, RK_HEADER_V1 },
 	{ "rk3368", "RK33", 0x8000 - 0x1000, false, RK_HEADER_V1 },
 	{ "rk3399", "RK33", 0x30000 - 0x2000, false, RK_HEADER_V1 },
+	{ "rv1103", "RV11", 0x40000 - 0x1000, false, RK_HEADER_V2 },
 	{ "rv1108", "RK11", 0x1800, false, RK_HEADER_V1 },
 	{ "rv1126", "110B", 0x10000 - 0x1000, false, RK_HEADER_V1 },
 	{ "rk3528", "RK35", 0x10000 - 0x1000, false, RK_HEADER_V2 },
-- 
2.34.1

