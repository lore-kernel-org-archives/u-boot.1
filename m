Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACB9CAC5B0
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 20:56:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E7AD83447;
	Thu, 25 Sep 2025 22:56:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VmNx1629";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60D188341C; Thu, 25 Sep 2025 22:56:23 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46A7983542
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 22:56:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-30cce86052cso1059211fac.1
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 13:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758833780; x=1759438580; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=//uOZFQ3IBMDNRyShvZJ/JUKMC9l/df8eIW5/5TDT/c=;
 b=VmNx1629wz6aFe7key/33mEHM1BhvU12vWqAk9rpAwEwM17KsbuV2AVnsfr5qZ/xLm
 YHIaHAdQlANf5RCKIqB0QBybMfbX5+MNbokTNWg1kt7YnNiH3U3wuCDwmLI99Piz4FQq
 rJ64qFzN/QnMsB59GBWuQnJ6al4tvMPpQml5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758833780; x=1759438580;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=//uOZFQ3IBMDNRyShvZJ/JUKMC9l/df8eIW5/5TDT/c=;
 b=ZmUAkJUpfUklrTxn9Q9pw/IXX2OQMkGCuXPsd1jIRCQFgIXUre9Gq9pkTNM0L691PN
 j5yiJcjm/Eii4jSiHfxh3orUuPApI0yqbofHTJfVqNsxpuUQ6ZK4ELxPPE08u6mhBKT+
 7R02PpkHjLCvUrcXXggo3YvAdF4j9pLjL7V/CwPPd+yfsw39yPcbJZaE98uBRsM+/fGk
 F/3qc4RjC5RuJJW+vxFSsL1G9WjUGhmIUWLycpNnTwMlrwQOPNQXtITekoO3Ek06N+/y
 HUZUUD/dXYXP6MRUk96tUEBRWwoAYxpHIe4gn2KFtpB+f/2WsTNiPLkkq2nGNvtULF9m
 I0ig==
X-Gm-Message-State: AOJu0YweCA5fGHpNA3+sXyuMRHCxgi3oGp25Zn/F9B/Nw4l+IZJFOFO7
 ua70urnV6CPFzYowVc+ciSPs82w0dQtQLKCJSpWL2U65LJPJ/Tr55XNofydn15oICljyXKlvwLJ
 wgPzM9v4=
X-Gm-Gg: ASbGncvDFT6qAjOu8jX6YQmn+G+EMvVtL/z6hMZAgA069/I2Xj3ZaRXo34TXGRnqHaj
 +L/uPE5N8el3FqlCQvb7WPC0TmH7p+2YdGd8EbgQWTm3FLqi/aphVi0A1gMlNmRMfiorCBAh21B
 50cbKUpPvLlKFZfPeE8Q8BJocv4s5IAiLF8jgaYL5anteE1MxRCtabny4ISxOYCKhaRJWQ33+R9
 AiMNN33gQNr6RB1m3gP5xCjOPnIxar6aSdSmcQTX77h4fK5nQKwTyzArpadR4clijHYlDUmTTpy
 5xU0FE41ig35xAsVfp1NB6u7S8VKUmMCNyKF00RCf0F9JMG7SgWYpE1eTUKhPoyDd4Q4TqJ6kMW
 YQMgLMErzBecTuP6Va6uqWACNk4ASIrl+aQ3lNCQ14Cs1d4rge5FSkL7G5mg=
X-Google-Smtp-Source: AGHT+IH+32lGw1NUC24Rl2Ltvb5meAzoOCD7iySUtvTg2rrRK16/aFpCpDeMdXgIyaY0ewiA+jAzwg==
X-Received: by 2002:a05:6870:d6a4:b0:353:f24:e95a with SMTP id
 586e51a60fabf-35ef0761242mr1882914fac.42.1758833780012; 
 Thu, 25 Sep 2025 13:56:20 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7a2401f018esm611107a34.33.2025.09.25.13.56.18
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 13:56:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] spmi: sandbox: Make U_BOOT_DRIVER entries unique
Date: Thu, 25 Sep 2025 14:56:18 -0600
Message-ID: <20250925205618.3562580-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

All instances of the U_BOOT_DRIVER must use a unique name or they will
lead to link time failures due to name space conflicts when both are
present. In this case the driver was reusing the msm name.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/spmi/spmi-sandbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spmi/spmi-sandbox.c b/drivers/spmi/spmi-sandbox.c
index 992b08dd6120..1a8561b3aea2 100644
--- a/drivers/spmi/spmi-sandbox.c
+++ b/drivers/spmi/spmi-sandbox.c
@@ -144,7 +144,7 @@ static const struct udevice_id sandbox_spmi_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(msm_spmi) = {
+U_BOOT_DRIVER(sandbox_spmi) = {
 	.name = "sandbox_spmi",
 	.id = UCLASS_SPMI,
 	.of_match = sandbox_spmi_ids,
-- 
2.43.0

