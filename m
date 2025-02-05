Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2953DC02193
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 01:57:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA30F807E2;
	Wed,  5 Feb 2025 02:56:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gHn48mw2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51B2C807B3; Wed,  5 Feb 2025 02:56:39 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA3C1805D7
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 02:56:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-726819aa651so787012a34.1
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 17:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738720594; x=1739325394; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DbNwJBBGneRBpatJzZ/6Rdj8jqPJ+8sG4ehfSth65oM=;
 b=gHn48mw2nz3r8vC3gwVOqcyt9QBF9ak5e4dJ+AGPe6zja5kFYxlryVaMP26TKFxdIT
 8qyB390Q9/I77loBifbuaxRS27vwhz84EajfOU6ficA2VBPCJzzIuYqveFKH7bcamnc+
 glenk1PkP03U1YNGAP+C3zKS33HSrDl3JUKqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738720594; x=1739325394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DbNwJBBGneRBpatJzZ/6Rdj8jqPJ+8sG4ehfSth65oM=;
 b=S0o5YBnY0XzsJBJ689R7D5NcPHI/ek3xAJoPtKsrzgsSpzPZ9Yzbi7rk3bf8E0NBd+
 gDDKD6y9YqqxFnWVeDjeKuNGUCByPtGKBtODYZWupWzJehKrBRQAz6yAupad/oLgajAN
 qGSZFveAaq4hG1dtFXoB0+6z0Tx0g7JhPtWHgvc7jN/awb6tHKA+LaBm4LKUmqe5DuAo
 tuBOcje9ijodPMyj9MYiedoXDHwZCJjQlWqs1BbD0UcuqyVQLCpfnULabK8zMDqjKRi4
 kHJxbJ1qKj9ZA31zB66rma8RfhoI6ewxvwYPeg/ZIyun1bOeafPDKU3AR7hl9X7kaVYU
 cNqA==
X-Gm-Message-State: AOJu0Yy0uw1XTlpJUom9hvKcXCMDAzivOU4J6umbkawSQjIbS7E1HuDh
 9WYXTEjkL+qVgXSTAGsOcwjiJaaYmGr6MHpZI3Abw/ts98MJpmXYIsMdiUh8sjdlCzaLrS5GEWA
 =
X-Gm-Gg: ASbGnctjNPj8WcKxVCJMeGW+G5lln63FLooQR5OSFElGIM31EneIYhsXFPfqKVH9BDo
 IsiGLinTy0CPZF2mdGDJWaLc45bRgz0+ATFz3XPuHfCnbWNqQOO37rvvb3eeNq7e3ea5zyMytaa
 QVTU+48hfgv8lvTTwyFG7AXCrT4TFbcSByXf2FqINdcdPkwubCdzbg9WzX+ubh9oiROKP/Ebcl3
 8jLknM8zkD8noQ50YN9abuwWtdPvTgaCEQHOVFltkBYck5ldBX06rrzmUulH+HeP+BIOzGuhU2f
 uPhP9Li2eYqOqC8Ide/g+kwgLlviTrzgDeJGDiuPFdY1veBXfqUT
X-Google-Smtp-Source: AGHT+IEHt82n0yML3oHTB5UL48aXSBb+BU1XnsrC7Kdf2vU5fmmhtqzNO+QtvPJXUWk5iJcuCYdeOg==
X-Received: by 2002:a05:6830:6201:b0:71d:4b0b:62c2 with SMTP id
 46e09a7af769-726a4267774mr830801a34.17.1738720593978; 
 Tue, 04 Feb 2025 17:56:33 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fc104c2e7asm3543676eaf.12.2025.02.04.17.56.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 17:56:33 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH 05/29] rockchip: Allow RAM init to happen in SPL on rk3399
Date: Tue,  4 Feb 2025 18:54:55 -0700
Message-ID: <20250205015606.2686149-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205015606.2686149-1-sjg@chromium.org>
References: <20250205015606.2686149-1-sjg@chromium.org>
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

TPL runs before VPL. The earliest updatable phase with VBE is SPL. We
want to be able to update the RAM-init code in the field.

So when VPL is being used, init the RAM later, in SPL.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/ram/rockchip/sdram_rk3399.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
index 6fa8f268770..9ac16dfdc71 100644
--- a/drivers/ram/rockchip/sdram_rk3399.c
+++ b/drivers/ram/rockchip/sdram_rk3399.c
@@ -194,6 +194,7 @@ struct io_setting {
 static bool phase_sdram_init(void)
 {
 	return xpl_phase() == PHASE_TPL ||
+		(IS_ENABLED(CONFIG_VPL) && xpl_phase() == PHASE_SPL) ||
 		(!IS_ENABLED(CONFIG_TPL) &&
 		 !IS_ENABLED(CONFIG_ROCKCHIP_EXTERNAL_TPL) &&
 		 !not_xpl());
@@ -3195,8 +3196,9 @@ U_BOOT_DRIVER(dmc_rk3399) = {
 	.of_to_plat = rk3399_dmc_of_to_plat,
 	.probe = rk3399_dmc_probe,
 	.priv_auto	= sizeof(struct dram_info),
-#if defined(CONFIG_TPL_BUILD) || \
-	(!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
+#if defined(CONFIG_VPL) && defined(CONFIG_SPL_BUILD) || \
+	!defined(CONFIG_VPL) && defined(CONFIG_TPL_BUILD) || \
+	!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD)
 	.plat_auto	= sizeof(struct rockchip_dmc_plat),
 #endif
 };
-- 
2.43.0

