Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56080C87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 01:29:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0DD783420;
	Tue,  5 Aug 2025 03:29:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RPBFLVnf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CF428396E; Tue,  5 Aug 2025 03:29:32 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AD618340A
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 03:29:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3e4063e731eso16392665ab.3
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 18:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754357369; x=1754962169; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=66UbS+0C3xBFVhzAbfbMA6Mzz/K91vbh7ifjxdS9IBE=;
 b=RPBFLVnfKwZ/ZOnlwUeCx5i/oXtCkDkFUfNd0BsioDDePJ6KA7kil2tLrYLq3yQw9f
 lVR5JQnyg3jNILsXfZhIGucdGPpJCCQzJFaYhahxO9HP5K7fzBoSLjt25CCNFnzokc//
 q6XEuuw1qAHFLsjmJZn03YYKSW6PfRHb3ZNtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754357369; x=1754962169;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=66UbS+0C3xBFVhzAbfbMA6Mzz/K91vbh7ifjxdS9IBE=;
 b=Ay6YcRLKNlrSFigyFWbfdbht+5YsY0S8J8lQ6e26uw6R/Bi7drdCS8ste+Olp5W6ME
 cUFF47D5/lcJVKifwbfKaHkKPu1LaeG3w0bqvhe2MBwub/UCpDtClwzOLyP+r8IQDX60
 HKxzmD4BztvorWIlWzn4ywEZFzOkV+M8YoJTQViDDhtPocpFxHys3rzVT8OmD6ATT27P
 qN/EZP+a3h82LuOEfxVO1wso7AEF3byA4RwK8lutXuWKtYRmVBhWf1U+qFm4wTyTuOFm
 qpliq4QUgOiQT2iXop5KqauQrqpOSKXJsmj+wJUSzDe2+rn4uv+gC7um/k+BBD3kBklD
 cvbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXavRP6LzCV0PEJ4JnY9GzIfR0FkK32V+i8BkSNBq4a0aI8btTIwRLjDSwHI5T/t8y5m5tHc8w=@lists.denx.de
X-Gm-Message-State: AOJu0YzUJkaYcPhC9BmOcXKSL+E9NfnBbS8nW1PChv+JsoQH5csn3/xy
 Re+Ej6a8jbp0m+8kp8Z/YYbpkLotUbw2ccHpC6PSMQsC6bETEt1QovB+5306mJ3v3kU=
X-Gm-Gg: ASbGncu3+Mu6w0EBQSBFniEYTChfsdcTvgZC9G2gPnoDPwwKU9nfPHjkN421xTJ+G+U
 VOc9w5VOU7Xad6WGIDDyx7Z+0+3Q2UrDHVgh5GXM9AAK+Bjh0Oqmxr/lampYnVtFWb4nVnMGpUW
 mj+/YTiQN9p/FTyc5P3TV/JNMwQwkxMZ9ubR2A32wQpyCP52c8vtxEagJtP5RHXCyOopLNXecbM
 k+nIBgxiK3HmaPnYMx5788Iw9pYtgBXP+NpokAPvEZVPhnuG2g8cBXBYQ6rb93A7V3MeSJAFGVr
 2clmumYaLXkEQSWgh/gjhJOj2Ei23maO7tzITJYywEb9S025E/ohIgWKxVZEsOz7RhbGq41ZHe5
 YppL7W3FLvRwW7OIF32MIAKz6QXFe3vVYajArka/6iRuWR8M+CsZe8K17TRSVfN7wrA==
X-Google-Smtp-Source: AGHT+IGWdd+YqOuKvgaYn/gdoe4vts1LSOMmqK5XFDzRrcVP3bzJADyAAhyUSkd1MbmcZ+rVLQzfcw==
X-Received: by 2002:a05:6e02:1fe8:b0:3e4:b9a:8ae7 with SMTP id
 e9e14a558f8ab-3e4161081afmr203541855ab.7.1754357369034; 
 Mon, 04 Aug 2025 18:29:29 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50aae78b8cbsm539506173.21.2025.08.04.18.29.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 18:29:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Paul Kocialkowski <contact@paulk.fr>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Greg Malysa <malysagreg@gmail.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Trevor Woerner <twoerner@gmail.com>, Marek Vasut <marex@denx.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de
In-Reply-To: <20250730125427.587976-1-heinrich.schuchardt@canonical.com>
References: <20250730125427.587976-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] Kconfig: typo restict
Message-Id: <175435736712.1435425.16928940271715797751.b4-ty@konsulko.com>
Date: Mon, 04 Aug 2025 19:29:27 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Wed, 30 Jul 2025 14:54:27 +0200, Heinrich Schuchardt wrote:

> %s/restict/restrict/
> 
> SPL and TPL have separate options (plural).
> 
> 

Applied to u-boot/master, thanks!

[1/1] Kconfig: typo restict
      commit: c03d7a48018c8caefefc9b2cbd46f393798eece3
-- 
Tom


