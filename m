Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD3ACD8CB2
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 14:38:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 523E68498B;
	Wed, 10 Jun 2026 16:38:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kzAyskmg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6012D84995; Wed, 10 Jun 2026 16:38:40 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 850ED8495B
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 16:38:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-bec85f03e14so95735466b.0
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 07:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781102318; x=1781707118; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9kaZk2Zc+2wmOzHz6nPQ71eZhDwMK2J/0uhci8yNzqA=;
 b=kzAyskmgM+CROgViwBDhrNLYjU9UeL9aeWJoMyUOCW9/885XQSA+yQCAXYNeTkYTPQ
 KZs9GlNknJ2IrXeo0Tx2SFuhdeKGD3XEgPOVu3NQe3Ws7HwhQue0Z/Oxdh68lOeLnPmh
 paiW69o+2hLGoQdWWrqqNawvK9SkmSYRh1z0FcjX73i83SQemrgXQhkT8UFuluE6hoJh
 wbi9LmfF0ILB992xinj51eCj6usWRsq3acB/l2aMFkHU0qNqx0icVq2D6D30ilwR30Z4
 NHdvSv+2Tv9mTrKWjOswGUCg5FOwH5Dxy7w51ZeAVKVb+lbvbmJqM43vtZFgh8g5ikYH
 svsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781102318; x=1781707118;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9kaZk2Zc+2wmOzHz6nPQ71eZhDwMK2J/0uhci8yNzqA=;
 b=aIZ73OFsFLz9L85rCnZkugOEgWtMX/m+X+iizh/xWawU2xh6XawURRjq893RXjZWPT
 uGFMHW0p1LjJr/pzK0U+EJEcNUe6vc1Y4677Lyh64zeWGNHNZQ8UJGUmkxi2IhowjIwI
 UItJp4n88v6WL7qT9EUZLcOPw9hTmaceMsQ0ea/zD6RAonv6pLddUTeK4NhfHlcE7lP4
 D7g8fTFsHXEY031Ns5HJKPh7brFPiKC6GLpbL9jqeme0+COUrpYtcF8JWo+CLi6AA9Jk
 UqEHNnRTmPQdPpJsXb4wrkujMXbHR0mzq7/Dt3IVdksIZvCllM+bzmsxUBYrOqohyn/T
 7kLw==
X-Gm-Message-State: AOJu0YydZfhAkJFcB6acc32ateIBojEmGZYg+kqaXLr0Hf9ghUuyDya6
 GCONYQpHIrfGCZl97VL3g0EjGe63aDMX+bsDRRGoCcpZJsaf4g0OObpG
X-Gm-Gg: Acq92OFSl3GNDiWcycXTYiW4MLVeyd2MNkk0LoWWJcZnfKt9jt55YPMdz7uDhUpt78Z
 JQepD2m/Ef+2LoZAE5M+0FbUD8DAd4OiHyxvxMFnSyP+gEid3ajGK6sY/PzFCpMoe/9fCnL7hLu
 WHiHR8wk0nwGQimYhJDRdl59LGewIo2BfkqZclHapYEzAQQriI1jKRZbhIzSWInDZU14YQu7qWB
 MrJOPyqyK1g7PFbb6GeUiFSsqOq3MVJvU9jZWaGW5cyvOv/5GnZboPoqDGw/pPHdiZPED+w1Ggl
 mbeRqlrC0NFFbhE8aRZ37ofNrcV6hyEVY1DK+WjGTILdcEIOuaOGRUpvfzvtAQzAQICV/QOt8Dp
 XCXrMw3oh+1wrbWQnyUQKiYS1WHZbjhwAWNeFo1DXx5/Jj0XTSqZqSqxf92G4F9bztdbMngunTv
 uCyGce3CQFRTWrBJhTzo1tqckfBiG0RVXnrThoCxWDQsyPuwDltW7K7+0tuHuhpdW2am8a630fV
 rrPaqmFxDo=
X-Received: by 2002:a17:906:4fd1:b0:bee:a439:87fe with SMTP id
 a640c23a62f3a-bf93ad3a942mr221488266b.7.1781102317858; 
 Wed, 10 Jun 2026 07:38:37 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf054e05199sm1171449966b.29.2026.06.10.07.38.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 07:38:37 -0700 (PDT)
Message-ID: <402c0bd4-af75-49d8-a30d-6a50e7fd5815@gmail.com>
Date: Wed, 10 Jun 2026 16:38:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 07/18] Kconfig: lib: restyle
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <ef462dea-69aa-48df-9f7c-af2e6c54e52a@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <ef462dea-69aa-48df-9f7c-af2e6c54e52a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Restyle all Kconfigs for "lib":
Menu entries   : no space left
Menu attributes: 1 TAB
Help text      : 1 TAB + 2 spaces
Replace '---help---' by 'help'

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 lib/rsa/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/rsa/Kconfig b/lib/rsa/Kconfig
index 12a71c3df6f2..deaad0bba021 100644
--- a/lib/rsa/Kconfig
+++ b/lib/rsa/Kconfig
@@ -94,14 +94,14 @@ config RSA_FREESCALE_EXP
 	bool "Enable RSA Modular Exponentiation with FSL crypto accelerator"
 	depends on DM && FSL_CAAM && !ARCH_MX7 && !ARCH_MX7ULP && !ARCH_MX6 && !ARCH_MX5
 	help
-	Enables driver for RSA modular exponentiation using Freescale cryptographic
-	accelerator - CAAM.
+	  Enables driver for RSA modular exponentiation using Freescale cryptographic
+	  accelerator - CAAM.

 config RSA_ASPEED_EXP
 	bool "Enable RSA Modular Exponentiation with ASPEED crypto accelerator"
 	depends on DM && ASPEED_ACRY
 	help
-	Enables driver for RSA modular exponentiation using ASPEED cryptographic
-	accelerator - ACRY
+	  Enables driver for RSA modular exponentiation using ASPEED cryptographic
+	  accelerator - ACRY

 endif
--
2.39.5

