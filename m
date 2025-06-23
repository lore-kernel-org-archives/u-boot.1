Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C39AC77B7C
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 20:10:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4AE081FEE;
	Mon, 23 Jun 2025 22:10:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DZUhQKyU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8DD28210D; Mon, 23 Jun 2025 22:10:39 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCBC781E13
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 22:10:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-408d14c7e92so3595765b6e.3
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 13:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750709436; x=1751314236; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V7MSH5S8i+D6/NQmy5VTW4fboXoid4Bx9g+vKN1j3X8=;
 b=DZUhQKyU95MAWIy6O2cR1fk9A39U6KxCvIdL8jhCe2mg+XaBkdPigA062FnI9xDkEQ
 L4tZYNfof2d7lreqZiE1C9xPiCIWzoIF/7eFpZLwtAa0el8TmJ9bmPr7klw3qZ86qmLj
 k6TO7aUCpAsJKf/ogUdjvNvv30EsDeA9tf6oI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750709436; x=1751314236;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V7MSH5S8i+D6/NQmy5VTW4fboXoid4Bx9g+vKN1j3X8=;
 b=AkVJQ5u60Etsv+Kr7hIinwUuPZVeBo3TTIrhPCp6icAHxfqbRCE8oeuFYV2uDVGSny
 CEXuhiFyX9PG59ImdVcwmi5Zvo7FQFCdj1QJ1f3NhP6mZZXAYWjMHMfO5tuJlhVKLjW5
 pnIdBEdF7kH71gkHCZaYnBbd/6RL0/I60XSSUEIlcKPXJle3v+wloFNunlw2fu8IFY35
 ir4qgnlFo+UIwC/zXCuWtw9+ZHck0v5JXa+7EnxzaxRJJkbpaU4uDiEmok9ppEGzGtdJ
 mPlhbe82Jh9HPEyr2sU4V+J0rW/B2+jpb2gfPmyl2CQxbsm5+DIRaI5YL8d6j45qNiVt
 dB5g==
X-Gm-Message-State: AOJu0YyeJxwi/TzOmbsR+IBCJk0ol7RSz7c9mMs+imXMp53/ckkgPgNw
 baA9a+Lj51yjFVIieAtp0tjrgPgg60hfz4gP8w5UZGTK0vO90omx7HuPCVmn8zCJY1s=
X-Gm-Gg: ASbGncvxYIM7Z9o1pQtCTlZ2Zpu0Pw39m6jQs0ozH6TM5maOimPAcBpSOUhxBRZ+VDa
 fbtcQ52//aRIBaiqVTnm3OrIiHXBJdaMv2fXN5IoKZf+AacRyLcl+IQxiibWvAxNjIxWYBdpMuJ
 jQzGtLtZrobCOt9pqB2zC/QfrM7ZG9CXjoxwYL6lxZQhJLdlWMOFHlkH3ea8lBNYVtS0FcFMa6E
 quPA1qExI3TT66gk4JeNHYoZTgyM8OlXosD6JMoRGMb4sbikdCN9eTrcrOs3EPJF9XNzkZNIq/t
 OPHfEFRvfAplXYIh/w9bQp6NPeCQj9mdWUkODxncYtgD8Jgfl2ItDVgJxaVQwhqr94hn4SHsVKt
 CiuGaXV1tYU2tg57sBBIO/Q==
X-Google-Smtp-Source: AGHT+IEiwA2qcUGdUnZ3z6JYYGlfAXtZHrd8ADO+2KX+F2VCSQyHYm3rHrJwY5Q8lEVSVLmFOl+YYA==
X-Received: by 2002:a05:6808:e8b:b0:3fa:f848:8dfa with SMTP id
 5614622812f47-40ac70d94ddmr9965107b6e.30.1750709436546; 
 Mon, 23 Jun 2025 13:10:36 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6115b68ebe3sm1151168eaf.8.2025.06.23.13.10.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 13:10:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, 
 Tony Dinh <mibodhi@gmail.com>
In-Reply-To: <20250623191011.4036434-1-trini@konsulko.com>
References: <20250623191011.4036434-1-trini@konsulko.com>
Subject: Re: [PATCH v2] arm: kirkwood: fix freeze on boot
Message-Id: <175070943565.1014388.14815397537513201857.b4-ty@konsulko.com>
Date: Mon, 23 Jun 2025 14:10:35 -0600
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

On Mon, 23 Jun 2025 13:10:11 -0600, Tom Rini wrote:

> Commit 6fe50e395080 ("arm: asm/system.h: mrc and mcr need .arm if
> __thumb2__ is not set") is not a proper fix for the LTO link error
> mentioned in its description. It causes 32-bit arm instructions to be
> mixed with thumb instructions, which the Kirkwood SoCs do not support.
> For example, board_init_r() is mostly generated in Thumb-1 mode as
> expected since the build flags contain -mthumb -mthumb-interwork. The
> MCR instruction corresponding to writefr_extra_feature_reg() is also
> correcly emitted as a 32-bit ARM instruction (it cannot be encoded in
> Thumb-1 anyways). The problem is, the compiler inlines the MCR without
> generating the BX or BLX instruction which are needed to transition
> between the ARM and the Thumb-1 states. From the objdump output:
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] arm: kirkwood: fix freeze on boot
      commit: 410d59095a9f2319585bd66152b31f72389dcdaf
-- 
Tom


