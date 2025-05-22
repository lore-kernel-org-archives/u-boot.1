Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A8CC54E65
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 19:36:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0342B830EB;
	Thu, 22 May 2025 21:36:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="R6yTD8rx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CF5E8318E; Thu, 22 May 2025 21:36:35 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52C8E830EB
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 21:36:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3f6a92f234dso5495062b6e.3
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 12:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747942592; x=1748547392; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2vtbTm9XoneSiqOX7mS1kAQAP08KNSPydX3uCLDsV0I=;
 b=R6yTD8rxAPIMNL+0UfFcEMWpCKmmy7FEhqpA/usjGQCf1kPQRTi4tLznW3n05WM6O1
 CZllRGDMnClVfVp+q5OUQVnn8/2lRbd/9EjjbxVPipDFsqCvoBuJ90Ru0QQGqNPdLcfL
 RYaYQiBHc8f3GkBpZBJv8ASbE0Bu1B5D+OI90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747942592; x=1748547392;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2vtbTm9XoneSiqOX7mS1kAQAP08KNSPydX3uCLDsV0I=;
 b=u/r5Vja2qBJrPyRAhTN43T9VZZNTBtfjVbzA3+1whHDmzLubWYfbX5gxuwrC3nhz53
 nvTu6Nl97ms7NVwcY9IRdQxe2h5ILmk4qUiGTzH6HZ+5EwqMOg/EdosGOE2Nkb6eKK0Y
 IiXK1IjpBYWX6AHQanJ5LKXHiMwBY6h0tIT5rm67PyYzpAM/quBrXMOcor1APtItwwiP
 joYce5UqbPYMVH1PpvCO9Ef1In1wEm7r7/zR6qc+bVmNrgV0OoPCZBu2QCkBer1+th7N
 lydJYBQ40sIWAG+TL29RruGKWSO3WzKopWvq+OiPerM7uGFDl+5LMZFhCWrmf63y+lh6
 5QTw==
X-Gm-Message-State: AOJu0YzUY7KNrR6C8iC8lR0U3sPgF4vYk3lP3r+NWQHB7qk3PwTmNKKD
 HmmxL6ACER/C3Fj4M5BzQYm/gCuGS5bz/tmWcIDOCe7EHM0GlpvwNoyoxCLjSFPJgmE=
X-Gm-Gg: ASbGncvcVoe3rlRtR2l8iBt1AJiD5r/nt65PzFfQL+cVOWrpvAA3emhCzbNKu0PvaiX
 5TgiR54269+ZJdzrKpErOAbcDKz8KnVyIn9kkR06bDXjFwsE+8fKgZwqWlnJA47+WzJWn1/AJqh
 KMZCvyTIJbkEx5I/xhgaP5yWwOJDksceSjdeqykBvRP8/DXT26+oBZHmpSSJ/elv2S9s/hQQehZ
 e0UR5Fcjdo9OpXzqkoS4Zy7y9aztrf8SOP1tBegZJiWCyBOIzcj/FveuO8A6ptb+QlJJ6RUhtO3
 YLqS2rYRYg/rpp+8rkooPZVb0OFt+4qfI8EAvrFdeZYPvAHtpMICEf1VvW2XHI2K4gCV6Qwz4F0
 0uhxaIKliwpg=
X-Google-Smtp-Source: AGHT+IH3d/gycpGb4aYJBrmsaOHbJEqoNgDU14UhZ7D3TuinZ2jlZW97YQwLMHeGARIDFkDj3On1gQ==
X-Received: by 2002:a05:6808:2f06:b0:3fa:7909:2716 with SMTP id
 5614622812f47-404da7e64a9mr18211040b6e.39.1747942592096; 
 Thu, 22 May 2025 12:36:32 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-404d98cef4esm2587795b6e.45.2025.05.22.12.36.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 12:36:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Simon Glass <sjg@chromium.org>, Michael Walle <mwalle@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@denx.de>, 
 Benedikt Spranger <b.spranger@linutronix.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20250508115725.18929-1-cniedermaier@dh-electronics.com>
References: <20250508115725.18929-1-cniedermaier@dh-electronics.com>
Subject: Re: [PATCH V4] tiny-printf: Handle formatting of %p with an extra
 Kconfig
Message-Id: <174794259022.2192967.5906980516148855133.b4-ty@konsulko.com>
Date: Thu, 22 May 2025 13:36:30 -0600
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

On Thu, 08 May 2025 13:57:25 +0200, Christoph Niedermaier wrote:

> The formatting with %pa / %pap behaves like %x, which results in an
> incorrect value being output. To improve this, a new fine-tuning
> Kconfig SPL_USE_TINY_PRINTF_POINTER_SUPPORT for pointer formatting
> has been added. If it is enabled, the output of %pa / %pap should
> be correct, and if it is disabled, the pointer formatting is
> completely unsupported. In addition to indicate unsupported formatting,
> '?' will be output. This allows enabling pointer formatting only
> when needed. For SPL_NET it is selected by default. Then it also
> supports the formatting with %pm, %pM and %pI4.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] tiny-printf: Handle formatting of %p with an extra Kconfig
      commit: 1e24e84db41afc5beba0a0ef9dd6e0509127b1de
-- 
Tom


