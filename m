Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D41C28B28
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 03:36:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 014E580756;
	Thu, 13 Mar 2025 04:36:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dvkJsxgT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D947811C1; Thu, 13 Mar 2025 04:36:13 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD5E080548
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 04:36:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6e8f7019422so5536716d6.1
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 20:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741836969; x=1742441769; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KXNvoag+6GmDA+c0vMWpfgLJbJqbp+/tvx54XhUldCs=;
 b=dvkJsxgTPxUQoSEmtx81dP07S4kD5ZrfxUEbPPg42Tkwiyotyaqv6taWemwU1vBesB
 QdNcx2udkkWBoqFNVi/LC80Wwrb8EwcMr4HKGsT7K0XVyTZLBpfqDjOrVHVKdIhgalcn
 MFMihTIV1N1f+R6nElBewJeDjiSoNmmPjcahU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741836969; x=1742441769;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KXNvoag+6GmDA+c0vMWpfgLJbJqbp+/tvx54XhUldCs=;
 b=U37qBv7Y9r03iToSwmUh85oLGUcWHlKtI9ViMhPkHjvPXr7zC9AvarI/+ZEfLU+XeW
 SBcEZEurxH6WNNEt7RdihWH4tSqFPKOkXvWgVcRATbW2Xxa09Law7IWmgyoG5N4zvncS
 oWeab5wZbWFriwOc45mW6r2QwXzxFfVjjsoCA6xY+GMnuO9v8WY4yCYqHJ28mq/nyF6Z
 wyFyxIXpGW1XYJ1yMmPQBNp5pI5dIG/wF1YfVLxbMeQn4VLEWaOeG258lWTq58wADaq2
 t591hTZMoOz0C2lrhw2HzCmfkbWtc+bgIFgwt5CPBko25pDgWFbVE/78Ex0YeTlqtcMd
 udQA==
X-Gm-Message-State: AOJu0YxjGT6x0KrOgsYPaWj0wYDwP7S6jVp7gXBzS8kUuT8Idrp53v9q
 ioXwDn4a4WKDdC/KgNUiVHJaygA9di4h+PcnbNHgFnhAnrNpeIFM3KKgB0CJo4M=
X-Gm-Gg: ASbGncvm/VYiuCWeOhGs0jUQWHU7COEkq6RUoBLUjpY9Rqrvak82lCGA4e4MKvVbcEH
 LnDQrvej8LfRFTp+FCXld3HtkZT6skCTT5wiUkW2ADQnQqP5K3uV+h+9sNVZa63daP9pOUoJLpR
 pk7Q9ymVcXya9TbrJHA9DYSWv3SIzndUbVIrmFmMkfUmGjBnzeSF06pWDz4M5OCZS3LtMgWvZca
 GM7TeIdue97cM9sR/8AagaYTgQkt+QDb5Z9PxxNsICbvaPl+vzL10V1Yr/mVvUV5b44S9ZA3R1v
 al1acnJuuTzEZ8MsExY8dwweqjDwiIfDhY/F7S9UL63f
X-Google-Smtp-Source: AGHT+IGWx9Di0YXl6PaLhneFFMGIs0FsRYGzcG3bZEghSWYBgIdM6BJ4l3177sSkldx0wVlP6MOdHw==
X-Received: by 2002:ad4:5cac:0:b0:6e8:f4e2:26ef with SMTP id
 6a1803df08f44-6e9006ad3b6mr362088196d6.31.1741836969464; 
 Wed, 12 Mar 2025 20:36:09 -0700 (PDT)
Received: from [127.0.1.1] ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eade209f70sm4155696d6.13.2025.03.12.20.36.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 20:36:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250312183941.1394738-1-festevam@gmail.com>
References: <20250312183941.1394738-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20250312
Message-Id: <174183696779.1897648.1919470272136234804.b4-ty@konsulko.com>
Date: Wed, 12 Mar 2025 21:36:07 -0600
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

On Wed, 12 Mar 2025 15:39:41 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/master, thanks.
> 
> The following changes since commit a383b9bd4d7e430fe7c254297540bae596649dba:
> 
>   Prepare v2025.04-rc4 (2025-03-10 17:31:52 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


