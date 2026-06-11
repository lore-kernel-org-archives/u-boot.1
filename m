Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B95CD98CE
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 13:53:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9718783FF5;
	Thu, 11 Jun 2026 15:53:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iVukoumL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDC1F84664; Thu, 11 Jun 2026 15:53:53 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA6A483FEC
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 15:53:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-43f5e285111so5258053fac.1
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 06:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781186030; x=1781790830; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6+aOJqsrUa95dZUiM1M/Z+D3l/pSpppb/qSybp1M7+A=;
 b=iVukoumLDB5RUIJj/wHSRjhW6TcXeJPTZ3bbwxuAFz3AWwnYDyg+LgIQxYydcMkp7H
 zC294RNluIH3a/e6YZ3ZPF3f6SChUs6Cx+HnSLfAHNyALiWvp2ddiLht7cAJDDsPkPpq
 /xH/Dk0tsP6CJkCf4KoRXckFtJ6BTgL33w5o8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781186030; x=1781790830;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6+aOJqsrUa95dZUiM1M/Z+D3l/pSpppb/qSybp1M7+A=;
 b=ZRQaYMIPJ4FucAHYOOKwgfShP8aSO2yCFTNbucG7I+ZCa595U1Za/uj/NtgeT2btI9
 MIlEJw0KWgJGsW+eFkKCsPCQUF+qA5RlwVV+/s8YiyYTynY7pOx61PJxmcdiOIDbbxMq
 IXRUQgNcYLzS/fHwN9GcOQGhlF7wgOyqFMCqzjlGyc3jHVIm07LuW0oaZdvKppnVMz5r
 sUmnbDF3dj8MNR95wKfvUc5Yh8AC3h48cPpZajcJsI8w6E33itHTKCSakXY2PS6ID3pB
 1G2OTPl2xZs1+7mcME9KHK9wqFN5ZR+uzGarsxVehtF3mgQtFLqH5Aa2lfsSgZw3lFsf
 qPRg==
X-Gm-Message-State: AOJu0Yz4jsU4xz5pJ11F6Pvqw4JtAu7lL6eQ7hfiaU6mGNxA6X7yMCbb
 mKh/ASIsIWgmRJbXXMM1cDP+SPhf2GjVDKen60B3Ce/OzXblHoT/8Jvp/OflSqmq9D4=
X-Gm-Gg: Acq92OHCepkgbvWwJ+BEYWPrGxXLEBUAqPJ5I5zYzfz9kPkdg4JPKi4duz/+HkoJk5e
 E11DJlIciFhQeY4O3resNVqEaneIwSXncy6i+cSUCU+wV8orOm1/UNd6RG/P9Tp+cIhVWR4Me+U
 1jKyhJIO8edjewvmqKz8fdoztKbWe4NgzseeSb+UhwRu5jen48QS3Cz4TvdbnV/AC9m88ggg+zb
 Y0Khz3rtECZHT8SSz0vHoCd71mRMpQlxqVJN4/KGGrpHhxjGwoeAbzBcHBehVpq6Ne8hrrVyKcw
 G7yaaYt3yqxTFpIHgNZnqYdLzjRtuvFemaa5uo4jgetdbHO8TCQeB3/x45Pt+G8TsQmcJ6rdRUy
 tJvB2GXXRpvLCMhE4x9ZXLFznjoD7EH5T7/iK+ThSrow8VJaZR9ZuHufx8nlG/Ks12P1lpvMfKs
 kieOY4bVfv4wQJXcqzxvQHAaUhnJU0EK98gGFeHUw79KVtCh9INRgR4p46FG+mSGz/xZiHAK9I9
 a+92eBrYYBfFWmZbxn85oGJpizykyQhqzCSd7Zkvmgidozdpo4sIbS9U8scpvugl+z1
X-Received: by 2002:a05:6820:16a2:b0:69d:fcff:a3b6 with SMTP id
 006d021491bc7-69ecadda532mr2006660eaf.9.1781186029959; 
 Thu, 11 Jun 2026 06:53:49 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-245.totalplay.net.
 [189.203.97.245]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-442446babc9sm1157548fac.8.2026.06.11.06.53.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 06:53:49 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Ryan Chen <ryan_chen@aspeedtech.com>
In-Reply-To: <20260521201801.44018-1-marek.vasut+renesas@mailbox.org>
References: <20260521201801.44018-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] MAINTAINERS: Replace ASpeed with N:
Message-Id: <178118602884.482984.18102000426136867603.b4-ty@konsulko.com>
Date: Thu, 11 Jun 2026 07:53:48 -0600
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

On Thu, 21 May 2026 22:17:49 +0200, Marek Vasut wrote:

> Use N: to match on all aspeed/ast2500 files, drop the large list of
> entries which represent the same set of relevant files and miss a
> few in the process.
> 
> 

Applied to u-boot/next, thanks!

[1/1] MAINTAINERS: Replace ASpeed with N:
      commit: 53305a02a76c1178ca0c08adbc50b37ca4b092cc
-- 
Tom


