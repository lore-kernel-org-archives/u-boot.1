Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42FF2E85389
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 19:47:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFB5884129;
	Fri,  3 Apr 2026 21:47:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jDdQbR+E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4769384105; Fri,  3 Apr 2026 21:47:16 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D2F78407E
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 21:47:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7d750eeaec3so1009299a34.0
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 12:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775245633; x=1775850433; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KAgGhgzULv81JHYsBZBz26Nr33QXRj/84Ckk8a7GRfA=;
 b=jDdQbR+ERPpoPXUK4LPMa/XzXDNDsYKZ/10ESR6sv45umnrg/8fhVEmymH67Lw/mWr
 H+xKy6yHNCiN7bQi3bUMnqeY8PoMCNmlPPyN+7mViJwkppb1JHji00jZeLo0U41TCWzq
 E7CGG2kNBxU9pFnW1NoVQ8Ojv1GeC5G8FtWps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775245633; x=1775850433;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KAgGhgzULv81JHYsBZBz26Nr33QXRj/84Ckk8a7GRfA=;
 b=GipXKFd7xHQ/W+29rj2Krod4cP1EDXWGeSwMOnvsszqG9IUVfr+0I0HIDMUv0HtsCi
 QEulaRY2s/+Kh2vNNgx2CRKh0PSyC1Ci6Q3DmHJgUQ2jDoAHCs0fUAqqDuyJKZckJh7O
 7grMgrHw9nEyLnRnYyE7FxMv1z7ONyKR6SThtcC9CWzxydpPRF+Y33+R2ccLClod4z7W
 i2di5agPLHiAiKf6rrQ+bv/Je0G7aelPq6LJ453QkQ5ti1lxh29ssHJbi5yxMoQOs7nQ
 0+8JJ6Iw7ZtY+epXdD+TCSGw47Ch1TqGM+ZZNLKTnEkdEC1NvfVvTFB2H7aeMn0GzP0o
 8NPQ==
X-Gm-Message-State: AOJu0YwIHIeqCG+04f6zB5yYOtkKgEKjB1IsVpgVdMqzn0qkUz7tyb2y
 dCW2TxlfpCYifmj6iWL5kBt3YP011vOYGFIn6+YXmj4vKtnr47nz+IaBH5VPXPdVQdU=
X-Gm-Gg: ATEYQzz1OWAQMeS2K4Unx5mR3gz72+bGlb8xvpr6cPdwet0SYbmqnLPx4UHnnDlGlzn
 yPsRkVwRTYJ3yyh8EeD04Xx1uF0csvvasdK9WAFUvn9rXXE4h2Qc8rhpjRrnbUQtuF5d6biBqBJ
 nirad8rSTxAs1pRPoaDu5azTDDREOFbiOiOHOAYNUScTTGCXZkGbPft4uLd4r806VyamTLmtMXZ
 21Td8HVatnnDCZDmjWTm21QB/OkbhksL9YayBML1Y2sqkU1ZVTzY4B/SnCdaSf8Dwgq4+BcQ2hG
 AOrII40GEdIVY9unG5fyccc6O2bFpd5dduyxrUA/2MP5OwDVOTqh69+kgSdmFLkcSADDPHdyFM+
 twCDvcv4AoG3ICpecFf0z4VObBzOiwSO1npHTLNaFJHyKn/QJj6YvRAh8lPaq60ow0+SXgdDIku
 I5hKmOVnN4yqMzELiVHFAl4h5wUe8eEoyfXC5kKq5hlZX0WiA3JHsv2ba5mkSe6+HLfuQO5r/ke
 riAIoqyO+qCt66MFauTnhrHgAoHZAhhB3cVeoPd3tt6zrQ=
X-Received: by 2002:a05:6830:7009:b0:7d7:cc53:623c with SMTP id
 46e09a7af769-7dbb6f1a978mr2555035a34.7.1775245632921; 
 Fri, 03 Apr 2026 12:47:12 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dbb5c96485sm2544954a34.22.2026.04.03.12.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 12:47:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marek.vasut@mailbox.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@dh-electronics.com
In-Reply-To: <20260320172458.3587330-1-trini@konsulko.com>
References: <20260317012452.4162719-1-trini@konsulko.com>
 <20260320172458.3587330-1-trini@konsulko.com>
Subject: Re: [PATCH v2] optee: Correct dependencies for BOOTM_OPTEE
Message-Id: <177524563206.2281750.11965474690051129672.b4-ty@konsulko.com>
Date: Fri, 03 Apr 2026 13:47:12 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 20 Mar 2026 11:24:58 -0600, Tom Rini wrote:

> As exposed by "make randconfig", we have an issue with the dependencies
> for BOOTM_OPTEE. This symbol needs to select BOOTM_LINUX and in turn
> depend on the library symbols that have to be enabled for BOOTM_LINUX to
> be valid (LIB_BOOTI, LIB_BOOTM and LIB_BOOTZ).
> 
> 

Applied to u-boot/next, thanks!

[1/1] optee: Correct dependencies for BOOTM_OPTEE
      commit: 0b1a79350212d0d166135bcfa4dd3a2cfbdc59ce
-- 
Tom


