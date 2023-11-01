Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 769B4C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 16:31:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB586876E7;
	Wed,  1 Nov 2023 17:28:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aNIkogTq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADFC787D5A; Wed,  1 Nov 2023 17:28:49 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D376387D2A
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 17:28:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-66d0c777bf0so22736d6.3
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 09:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698856117; x=1699460917; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1oOjcRp5QQ9lgRvM+elQq4xWWUGK+D49PYebB/BnLDg=;
 b=aNIkogTqWQhs4mZSk6HPkVSpDuyasBjlipJY1A91N+RmIpxLwlM8JqiIfdG5to6Bsi
 Azy8xNDKlKFy9JgjHhTA2O73OQ5oeKTarXcPHNR2PRpuxEfFqR5eYtofVEv1QflY5zRX
 EAa2iCCoqJpIjkyvUf2jJ/smKsCXDUrpguWL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698856117; x=1699460917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1oOjcRp5QQ9lgRvM+elQq4xWWUGK+D49PYebB/BnLDg=;
 b=JXd/iMK6r50Ki+1ecjt3UaBUF1G/Uv9IlVxjD2TqOdHOjZTP4cfDJYRfWPNOLHvdz9
 LE2kHajZGRaMUARphP+MeBLB17yCnHIljWWvQIzWtNqB8nNnCLlvb3NirOFJLNV0dxSK
 TmiXkNrWrW6gwSujvLhTHyfAcfLklaJVaiPBS8HLyRYgiVFECiuhUEoMG4Acj3LxshFS
 7lXpAigOlJgjazpni/DixMCIAFv98oepj/pC+NbEUeZJRu9+35KYw9qYerPKZ4vBsiPd
 5tDjtBxN+G9ZP3YSpVg+W1rBG0Zf5RjaRktje5zDTQ/LzOC3pVvTtXsNB2QxXXS/Y+IW
 D0/Q==
X-Gm-Message-State: AOJu0YygYtmmIOVU5Z1DBq9rzqzt4XIk0PsNOwFpsvyjwE/PHz/i/51W
 kip3MO4MgDi6aMX48dfP1EkLuMiq8nyACjutk73WAQ==
X-Google-Smtp-Source: AGHT+IEtNPQMFloipr1JrCa4PphwsdQx4FKElbVd3zCreMuyG0jzK0LLQ+MkOzIFptoL9M0lDQhQEw==
X-Received: by 2002:a05:6214:4107:b0:65d:6e3:20d5 with SMTP id
 kc7-20020a056214410700b0065d06e320d5mr17276725qvb.15.1698856117511; 
 Wed, 01 Nov 2023 09:28:37 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 o3-20020a0cecc3000000b0065b21f1b687sm1610238qvq.80.2023.11.01.09.28.36
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 09:28:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 14/20] fsl-mc: Add prototype for bd_info
Date: Wed,  1 Nov 2023 12:28:18 -0400
Message-Id: <20231101162824.3755579-14-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101162824.3755579-1-trini@konsulko.com>
References: <20231101162824.3755579-1-trini@konsulko.com>
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

As the functions fsl_mc_ldpaa_init/fsl_mc_ldpaa_exit take a bd_info as
an argument, add a struct bd_info to this header file rather than add
<asm/u-boot.h> to the overall chain.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 include/fsl-mc/fsl_mc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/fsl-mc/fsl_mc.h b/include/fsl-mc/fsl_mc.h
index 258738dfc8c2..de2bba93ecf4 100644
--- a/include/fsl-mc/fsl_mc.h
+++ b/include/fsl-mc/fsl_mc.h
@@ -10,6 +10,8 @@
 #include <common.h>
 #include <linux/bitops.h>
 
+struct bd_info;
+
 #define MC_CCSR_BASE_ADDR \
 	((struct mc_ccsr_registers __iomem *)0x8340000)
 
-- 
2.34.1

