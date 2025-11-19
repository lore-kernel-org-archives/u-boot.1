Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60280CF394B
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 16:33:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74E5683936;
	Wed, 19 Nov 2025 17:33:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kkQxAfpO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C995D83F42; Wed, 19 Nov 2025 17:33:29 +0100 (CET)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6543E838CE
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 17:33:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-3e3dac349easo4147193fac.2
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 08:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763570006; x=1764174806; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YBLonfYrSY6BxPpn1HPkbA29OTme+i11ptA6uS7kuLM=;
 b=kkQxAfpOmxky+Sr0XFxUAr5Jkj6lCoDp3fkq57sZBV9ocZrAKt9uWbKGQHnDfBXQba
 PynUETbb9NovGRrxptHjFSHMjdl/ocCmg9T7K/36gMZMs6+/bXtXr+bBwoSk7W7xdavN
 TzeERxOpfRIDp3rFG1S8yJfr8tsp7JTR5Od/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763570006; x=1764174806;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YBLonfYrSY6BxPpn1HPkbA29OTme+i11ptA6uS7kuLM=;
 b=pEht79EIRzuZhJAvJLkEnNWWQZwCfyRgYHjYUyS/8v11UlneHmnW68KrJjXSLD8UsF
 b2/WmT8SbrBDaeNmj9hXGAcKKnE+QUFKj6o711zIr/0qiUZShsqWeFBCB8SAt9I1JTjK
 rmDuXyZwkOYtCpKV7g1z0Qn84gLjJEkxBtVCGFpV5q63cEm2peEmbfA9dJ5vM0FzLtMK
 Y62M9lY1oZtj2jkfMkkKIAzVN/qOrUM0QQpOPm5bKFNrcUbICskNazNR39qJ4TPqTXiR
 jm/AQ847eWpsuqjAUAOK9uarvN0IymDOTfyF3mJRNAC0EhFh5Su41bnZUpwozWyx3+uc
 WZAw==
X-Gm-Message-State: AOJu0YxFUXs5eTcQE0WeSZgu8QRipkZm/j3+hAEjStVzbkVdt3usYGCc
 RSaSbESCBJRUiOJI2q193T1Oxhh1tRHyox0yn2IWmKSkWIOQw2ztI3ON6cA9WoHPCSKl2W47l51
 bMB+CPHQ=
X-Gm-Gg: ASbGnct/MRBwaqJSjg6NIMsdmFtyvyQUJNd8ZfTYEUo5F2tixP4W/t20HxE5dz7LRCu
 zdZTLznBvKV6BXYAsqoVhFI9WWk7Tz/Gv9G96VnJ5NfpfJsdHDSxAA9WJnB1ZAdec8O3jWuI/Va
 NjdAXZeAlV7kuMy7StV2OROKArhTtV0EuxSx55OwcDnwEbTReDpD5SbZDbI7/WpW7bV98VES+rD
 tKlyZn0fPsWPxV3h90Cjei0RiLMrD5sbNc0DoL//68Tu9Fokcn2Z9359lph1pDMyveKaq1HGeJ2
 kZfERMS9nlEdTZWrgBQ8nEhGR6rY8NYmDehluCegdjRgqa7nnTz+mkuLcOpJemJcTr6zeUtrkhM
 XRDWxEk0l9AamIwjE5VTvF/tdVChVJ6aitjsbE4iHwDi0K4E6GcIL2NF79Rlgxt6oWK2JBDy6Aq
 4NJ7Q52fIc2wxnwVSNFAlexUX+OG35rHCum/RJRHCvg2WB2gAPFSMI69IzbCSNAqYpnH7O3Q==
X-Google-Smtp-Source: AGHT+IF/G5jdgzxHO9XSh7IyKGJQGOaLeg5NrXEU9ONmmKQLhgV21rMUqpoUOE/ToZQTZxifo7koKQ==
X-Received: by 2002:a05:6870:9112:b0:315:6935:9f68 with SMTP id
 586e51a60fabf-3ec99ff72e0mr8384fac.0.1763570006135; 
 Wed, 19 Nov 2025 08:33:26 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ec5962e508sm2781557fac.4.2025.11.19.08.33.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 08:33:25 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot-Denx <u-boot@lists.denx.de>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>
In-Reply-To: <CAOf5uwmFp_o1QFJ4A7MoBxNSF7Pwr1G8PLR+Lyx6PSrZ3ustpQ@mail.gmail.com>
References: <CAOf5uwmFp_o1QFJ4A7MoBxNSF7Pwr1G8PLR+Lyx6PSrZ3ustpQ@mail.gmail.com>
Subject: Re: Pull request for uboot-nand-20250918
Message-Id: <176357000535.862654.11575316907121136155.b4-ty@konsulko.com>
Date: Wed, 19 Nov 2025 10:33:25 -0600
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

On Wed, 19 Nov 2025 11:32:49 +0100, Michael Nazzareno Trimarchi wrote:

> The following changes since commit 91861e5a30d217d8e70130c9124c1646f4afef29:
> 
>   Merge tag 'u-boot-stm32-20251117' of
> https://source.denx.de/u-boot/custodians/u-boot-stm (2025-11-17
> 10:45:11 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


