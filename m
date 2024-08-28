Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D48C636EE
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 18:27:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A27488A25;
	Wed, 28 Aug 2024 20:26:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nvPswPr4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38B0B889D1; Wed, 28 Aug 2024 20:26:56 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D8C788744
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 20:26:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6bf8b41b34dso36364946d6.0
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 11:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724869613; x=1725474413; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B4BIhAEd5GufnkLAG0F+cJG9lRfrqgjv8SnUGVwnTaE=;
 b=nvPswPr4DVz1daNELq6BHHxEGICYET02061M1DwHRFSkRC8h9CRjz5AyH2p+X99NXj
 H40XZDbULvjTO5eKbgDpU2MiPnpqaInc8CiZPR4l/6/c72B+OBhZ6PIZy6Z5QH+xOK5U
 MnWvax3Pxy6rGwtLo57PTbyxtV/jKKN391bqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724869613; x=1725474413;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B4BIhAEd5GufnkLAG0F+cJG9lRfrqgjv8SnUGVwnTaE=;
 b=IxnVu5YVMYIhvbBovjAsW6gqBaIsQu9qBs0iOcNKAHB8wGpiQW8y7GIANwWJwxvkiU
 QvhCeka+KV8SoTnV/tN5wVzdlqfc37SWftqZDc8Qwd9sKh6ixkIOVG/91yO9uDv39ZU4
 8ao4G1el0u3U8CA8cbXaM++uRgh+pGFiptB9S7pJcT9z7j4Kf2GoUFG1i30lt07luhRx
 R3isb9nrn6uQBO/dC3l065LOl6lG3j7rLuaJxTBtKwwSIdjzd8OofPXDgM/mgA3pcLRa
 Rwz8WpX+bhW6xAITFSU6fyd5D7FtXMrIpNqWPgHiIsu3HPRYUKjujXlry6tupxPS429W
 y0Tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgXd23XVEiRyz8CFABeForT85tBdnBSHF7Tsst7XnZrHrOrk4qFBPJ2Lf4psJnXwrTM+kRJ1w=@lists.denx.de
X-Gm-Message-State: AOJu0YxqyYemB/Kh+J7qoWLz43S/l4FaP12KHX54RdMagti1mWEGkzNo
 Lr5xZUoOP1C268Shz4o245MGlD2dvz8jB9ZC+nuXwXE3V7lQbRVcjnmT5tVFsePUHwNPwypHm42
 f9ZztJw==
X-Google-Smtp-Source: AGHT+IFudjbwPBsZ1FYicAwbUuxYDRKsp6xrhzYHYma0nPsleRAgAy4+FbpDULoAUTwCg8ioJmn+NA==
X-Received: by 2002:a05:6214:418a:b0:6bf:6b15:a6da with SMTP id
 6a1803df08f44-6c33e62780bmr3207786d6.25.1724869612804; 
 Wed, 28 Aug 2024 11:26:52 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162dcddadsm67835536d6.121.2024.08.28.11.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 11:26:52 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: "Gaskell, Oliver" <Oliver.Gaskell@analog.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de, Linux Factory <adsp-linux@analog.com>
In-Reply-To: <BY1PR03MB72863313CCC8B4927892BFB2E18C2@BY1PR03MB7286.namprd03.prod.outlook.com>
References: <BY1PR03MB72863313CCC8B4927892BFB2E18C2@BY1PR03MB7286.namprd03.prod.outlook.com>
Subject: Re: [PATCH v1] dm: core: Make SPL_DM_SEQ_ALIAS select SPL_STRTO
Message-Id: <172486961134.3064792.7955928071194466716.b4-ty@konsulko.com>
Date: Wed, 28 Aug 2024 12:26:51 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Mon, 19 Aug 2024 09:43:52 +0000, Gaskell, Oliver wrote:

> Enabling CONFIG_DM_SEQ_ALIAS enables code which relies on
> `trailing_strtol()` - which is only linked in SPL when CONFIG_SPL_STRTO
> is enabled.
> 
> CONFIG_SPL_STRTO is not enabled by default - to ensure this function is
> available in SPL, CONFIG_SPL_DM_SEQ_ALIAS should select
> CONFIG_SPL_STRTO.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


