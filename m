Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D0AC3ABC9
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 13:08:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC01F82B54;
	Sat, 10 May 2025 15:07:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ktlamVYe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43CED82A8C; Sat, 10 May 2025 15:07:16 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E733182B48
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 15:07:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ac3eb3fdd2eso543612166b.0
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 06:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746882433; x=1747487233; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ahs9arQjfCO3YOMuljC7nne/FGZb31KBGcCfJRSvbn4=;
 b=ktlamVYe4Usn8z70kslDhuzAYSSvm3suGYyXDITBm9GSr97Kv2kzg8molmogIF2ati
 XXrFKajgr/Czs36UL31HvV/bwwLv8B98UbwBbIYtsk2sJoJX+t2k7h56WVKQkL6fndzn
 /8w3eIFH/RFXkf1RTeEu87B++Hlg8XWMPWpB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746882433; x=1747487233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ahs9arQjfCO3YOMuljC7nne/FGZb31KBGcCfJRSvbn4=;
 b=T1dGKnRtyQihYFiAulmUCH/Mkx+CqD1oy6Iw7ThsGwVL61mR6NWdr8cBJQpoeMfAPs
 1ogf7g5xPzJn/yfmNE0eXdeG1fc7dLVVXYvwcJY76az8mWYPuX1Ob3bnm9fAelef5zwA
 qDZbpiTEy9AavM7pRk4hcXsGuIRk1V9szhaHtFYdey1IxVaDmm9JyyjLUFGtGlowZHmB
 kQ/1l9IvPol2RFbcVKOLle5tYMvDJbSGHj5kaUPMWhps8xT5gZN377KdSoNVEQSCsneY
 PK7KInxKDIgBnoIilzX47rvPeQVrJLBlbOMcIAidHrvXVLwcK+SDum/pGzOceJL9wmOg
 UL6g==
X-Gm-Message-State: AOJu0YxnQ1aHQ7sB7gYgryoxOPl4WTfx8p6rYLBG7Eqo3GU4x0kYaEf4
 O+AZyG7Z+pCO3YeS9/K5szxk1xuUIv4VVpNLbWYTXFu9H0luG+fFIr5L0bpkB+S5sQz+KELwand
 L99uOE5A2zg==
X-Gm-Gg: ASbGncs6H3BNQmF6Dnptr0KShoiT01NAS0WCuQcwwBFSwz2gt/gmXdUY67WPQZHcFoV
 EoFZ03JPVS+6PMrZRIJ+eONtGI++OYfGa6IYbVTUCxWa9XkDS4KWRoH+6e+LeRDHULtPwgPQI8h
 p72Yr3C2dLFVT0dnU8i05WCrJ4B12ttStklP/akCIUUqj0vJ9u8njUKGwPYYXUA4zWUPHzsYWkG
 zBEt/0yNzyLuMuJk0NZkZrfhENK96JdAJA47suHy+uVYTTAdZmgSNnmvAeDk5tHZYm9++RpcFis
 EZXKRWisFvg19v9w0ORnKzth+zHeARqk/8VaCkmSVhVX9FA=
X-Google-Smtp-Source: AGHT+IEAesuwz52pUmbQK3eUccNOmpRPS7/prpX/Ty8HccHyzhvY+kQyhZXlYde1KQsmDNH32TCODw==
X-Received: by 2002:a17:907:97d6:b0:ad1:8fc3:ad9c with SMTP id
 a640c23a62f3a-ad219171038mr683014166b.47.1746882432657; 
 Sat, 10 May 2025 06:07:12 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad24085b44fsm52272966b.149.2025.05.10.06.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 06:07:11 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Richard Weinberger <richard@nod.at>, Tom Rini <trini@konsulko.com>,
 Uma Shankar <uma.shankar@samsung.com>,
 =?UTF-8?q?=C5=81ukasz=20Majewski?= <l.majewski@samsung.com>
Subject: [PATCH v3 09/10] ext4: Make sure there is at least one sector per
 block
Date: Sat, 10 May 2025 15:06:15 +0200
Message-ID: <20250510130642.1575114-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510130642.1575114-1-sjg@chromium.org>
References: <20250510130642.1575114-1-sjg@chromium.org>
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

The implementation assumes that a sector can fit in a block, so add a
check for this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 fs/ext4/ext4_write.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
index 9b1e26e86a7..a48d1fd26be 100644
--- a/fs/ext4/ext4_write.c
+++ b/fs/ext4/ext4_write.c
@@ -615,6 +615,8 @@ int ext4fs_init(void)
 	/* populate fs */
 	fs->blksz = EXT2_BLOCK_SIZE(ext4fs_root);
 	fs->sect_perblk = fs->blksz >> fs->dev_desc->log2blksz;
+	if (!fs->sect_perblk)
+		goto fail;
 
 	/* get the superblock */
 	fs->sb = zalloc(SUPERBLOCK_SIZE);
-- 
2.43.0

