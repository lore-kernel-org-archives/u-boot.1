Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A78C4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 10:36:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 205E7876BF;
	Tue, 28 Nov 2023 11:35:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=conclusive.pl header.i=@conclusive.pl header.b="jpFKPQj9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3E6F87652; Tue, 28 Nov 2023 11:35:53 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C303786F4F
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 11:35:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=conclusive.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=artur@conclusive.pl
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5488bf9e193so7213665a12.2
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 02:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=conclusive.pl; s=google; t=1701167751; x=1701772551; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gTgXspvtHrY9wMvp2zonRdToCyTkcUXYYIP919AlYss=;
 b=jpFKPQj9TUGqZ+e58+XsV/AAFoU5VUgqWblIs2K4fHs1slfdC1I08mMPkFXvuvqsbn
 AHKWFWQnxTVN6QPp7Mm/vPH+Qb/cRJlHyey4li961rntPc2kmeb/N+5/wcPLHKpq1QmM
 oJ+5GBBTYnMIuY64ULfCk4irkUyKiV5MvEeqzqknavsO5a4WHUan5lrvGP8wFYySzd6a
 omc1Qg5EHVLwqV9+jtRoJfp4YxOhV3CNIXYvy0C1oEQNMyhnTq5wBB/imehwMNFGt7/3
 Qzw1LJmg0IlYAgw8ncYBIMn4ldF0aHzUjnY5kU+FUg1r3r2mwypzy80vlp+r+471fPHY
 YxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701167751; x=1701772551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gTgXspvtHrY9wMvp2zonRdToCyTkcUXYYIP919AlYss=;
 b=skkF66BjWgBtuiH/xyVmSZL19dZTqzjSPBaVnWELsmrl2rLU/4JWZqoj21Vlgh6V3Z
 UYBMfN0mNWHZc1s4atwHJ5aESKiWlXxpgn9zB9NnGEtu6NlUiMIcgn4QSusm0AaUwabV
 PFx6eRb790+JTG/3xIFehEIi4NUdQCLtclfY+O0xBIxiRDIeAyn4MmWdljwEqLHtovWI
 bORI1R0979SYe5vDkyxtjrD+VVrBHmlUgPNxiPz12tZSMWxjhS6fyyU3kBGhFUO51rQX
 BXDtfH/ndwbJrjZBeTww6hrGX1Tg7aZfQAfjNbE9zim21WbHKFR8CLU3nuFIdYflykwV
 ygSQ==
X-Gm-Message-State: AOJu0YxQ0cPzJAkO77bSG/OgilGeGM6u68hT1OGdEWqMPdDm7Mu/NH59
 f9L+0ISjzCwlaWn73Aj7BcSGew==
X-Google-Smtp-Source: AGHT+IFA2cAO95PmTTrJWbaZ5JoaRbOtiNFBg6uLDvuPDa3DjHaYJloQi4V9cht74rL/XlNYzmVHLw==
X-Received: by 2002:a17:906:ca55:b0:a04:e6d8:dbc with SMTP id
 jx21-20020a170906ca5500b00a04e6d80dbcmr9763460ejb.42.1701167751223; 
 Tue, 28 Nov 2023 02:35:51 -0800 (PST)
Received: from localhost.localdomain (host-93.179.209.131.static.3s.pl.
 [93.179.209.131]) by smtp.gmail.com with ESMTPSA id
 cw16-20020a170907161000b00a169550fccesm77558ejd.111.2023.11.28.02.35.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Nov 2023 02:35:50 -0800 (PST)
From: Artur Rojek <artur@conclusive.pl>
To: Peng Fan <peng.fan@nxp.com>, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>, Jakub Klama <jakub@conclusive.pl>,
 Tom Rini <trini@konsulko.com>
Cc: Wojciech Kloska <wojciech@conclusive.pl>,
 =?UTF-8?q?Rados=C5=82aw=20Adamczyk?= <radoslaw.adamczyk@conclusive.pl>,
 u-boot@lists.denx.de, Artur Rojek <artur@conclusive.pl>
Subject: [PATCH v3 1/3] armv8: layerscape: Enable ext4 environment storage
Date: Tue, 28 Nov 2023 11:34:55 +0100
Message-ID: <20231128103457.45802-2-artur@conclusive.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231128103457.45802-1-artur@conclusive.pl>
References: <20231128103457.45802-1-artur@conclusive.pl>
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

From: Jakub Klama <jakub@conclusive.pl>

Some boards keep their environment on MMC storage within an ext4
partition.

Signed-off-by: Jakub Klama <jakub@conclusive.pl>
Signed-off-by: Artur Rojek <artur@conclusive.pl>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

v2-v3: no change

 arch/arm/cpu/armv8/fsl-layerscape/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
index 12d31184ad91..3775cb493732 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
@@ -857,6 +857,11 @@ enum env_location arch_env_get_location(enum env_operation op, int prio)
 		break;
 	}
 
+#ifdef CONFIG_ENV_IS_IN_EXT4
+	if (env_loc == ENVL_MMC)
+		return ENVL_EXT4;
+#endif
+
 	return env_loc;
 }
 #endif	/* CONFIG_TFABOOT */
-- 
2.43.0

