Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA9CC4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 09:01:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0434488BE9;
	Fri,  3 May 2024 11:01:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="NLqsuUXn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9106F88BF8; Fri,  3 May 2024 11:01:01 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7204F88BE9
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 11:00:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CDF2D424B5
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 09:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1714726855;
 bh=qF3hhLFm1Fq+99d+fF5aAs3VR86wC6eY70quLb34GyE=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=NLqsuUXn6ls/EU4KR2DlHuA/jTv/JTNqpe85ALkM//VPMpOVjNICERdS2HqQuG0i/
 XoBvTYGSLR6ZkH8s7is3Xuq+otq7pLnP5YlypWbXcPwhVm23hgf6fKbP9Bw5/fIHVj
 HfVoivz8DdKIBTWUTXImYEOHbkSVzoJJpyu5Le5dDAlaSgkcBOML9Kzfpcx5w5o0hW
 LCaVFRW4kKk8WmOfnJhuL2sma4QiylsWshwPqnpWgCu5mEyq3nEh67Qt/z/DjZyjeX
 C7R/+eEhgPQtZtpm8iosxrm1WXrO7gxZiPwTzBVzzJZvA85NjfDcLqS2kD0tgCG8A+
 7A2OsM4+E/Ouw==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-34a49f5a6baso7227348f8f.3
 for <u-boot@lists.denx.de>; Fri, 03 May 2024 02:00:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714726850; x=1715331650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qF3hhLFm1Fq+99d+fF5aAs3VR86wC6eY70quLb34GyE=;
 b=pJwQoppiNWpAJ6TVqMnfVzV8Uy/BOvpByU140KLsc3M0pWVuYGtlnBIwfrEgCE+yAp
 s8H5jJiZg6/akEFonUMZPwE6Rjve3jCBg36+mu9Jzp0gFtzX41pueiq9z1oK2TwCQQh8
 WzoDibehX3lWfF92hxkbQ/ZYPAssX07i1kWfFKUbreoVszVdcV16sbaKT9+X/gDq5/OX
 TdrphSUm+8NknGjcoxyIjfLcTahv4OgtZrmtBN+/AkN/2vHzKf66PSaGDFWS2HMmo6ku
 0/hCCO0IValz6vzu5sIQG7FFxRPQA9Cj/G578riYWFn7MyFiBXvFnKnzYLrFKVbZa45q
 MYNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZ+BzJG1reD3zuVckZmWmbg4jOAnFi7xU+YV8kJRZwxGxAYKT0OMZQcZqdXPMgAns5Vek6aYp7C5uu0QeTnGLvtv5WRA==
X-Gm-Message-State: AOJu0YzEoM4vY+ThnOvjsa9SzQoNp95eqpkji5R9yTbE5RztA47smm2q
 xqDzM0rwdD+A58UNcPXevQhvKNP3qVH4TTxhYawS55UHXpWCSeKuSctGv2oqGLDOtWlu6xb0Ph1
 epZdrkAqKzf+EuSPlyY6Pz9L2mye6Iac1yl4zZe5PsY0+bIFlYsIw6C6CSKlRPhOF6rc=
X-Received: by 2002:a5d:4b4c:0:b0:34c:54c8:3f2d with SMTP id
 w12-20020a5d4b4c000000b0034c54c83f2dmr1507052wrs.69.1714726849276; 
 Fri, 03 May 2024 02:00:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE489BAPgHaQnzR8oU6nBfCRijZwW3ejCdnQEA3wXwbNHrkABGYG/BLPAxbxpYOybvjhmZ3HQ==
X-Received: by 2002:a5d:4b4c:0:b0:34c:54c8:3f2d with SMTP id
 w12-20020a5d4b4c000000b0034c54c83f2dmr1507026wrs.69.1714726848986; 
 Fri, 03 May 2024 02:00:48 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 bf9-20020a0560001cc900b00341b451a31asm3247313wrb.36.2024.05.03.02.00.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 02:00:48 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Shiji Yang <yangshiji66@outlook.com>, Shengyu Qu <wiagn233@outlook.com>,
 Michal Simek <michal.simek@amd.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Mason Huo <mason.huo@starfivetech.com>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 4/4] configs: visionfive2: enable SPL_YMODEM_SUPPORT
Date: Fri,  3 May 2024 11:00:03 +0200
Message-ID: <20240503090011.37849-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240503090011.37849-1-heinrich.schuchardt@canonical.com>
References: <20240503090011.37849-1-heinrich.schuchardt@canonical.com>
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

We can use U-Boot for recovering JH7110 based boards via UART
if CONFIG_SPL_YMODEM_SUPPORT=y.

* Send u-boot-spl.normal.out via XMODEM.
* Send u-boot.itb via YMODEM.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	no change
---
 configs/starfive_visionfive2_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index 3bbd1dbd67c..174ac24dc74 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -62,6 +62,7 @@ CONFIG_SPL_I2C=y
 CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_SPI_LOAD=y
+CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_SYS_PROMPT="StarFive # "
 CONFIG_CMD_EEPROM=y
 CONFIG_SYS_EEPROM_SIZE=512
-- 
2.43.0

