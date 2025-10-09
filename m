Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34BADCCD185
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 14:20:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B65F18455E;
	Thu,  9 Oct 2025 16:19:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BuHi4X42";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFE6584531; Thu,  9 Oct 2025 16:19:00 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F455842FE
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 16:18:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-43fb0baa305so526884b6e.3
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 07:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760019537; x=1760624337; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3iKykMwk9D55XXx+6PNC3VYIsOdzbhWGytsfYHKHXFI=;
 b=BuHi4X42d3Kp40+2aoAFEB4+J52AqmPQcVtNE+GQezTx2wqwNyn/kM8xbdq5Yxs6gU
 Vjnngvtc8WQr9cwRL1ldNV6pznOULE6pcGTAjGNMw/3zYCshSGOMEuNQcene0vC5VIJw
 n91PF+8xay7asCm+mwUW+govTkV6N893c1rpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760019537; x=1760624337;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3iKykMwk9D55XXx+6PNC3VYIsOdzbhWGytsfYHKHXFI=;
 b=KIh5/zuAImjNjLsGU8ce5w+QruqgViymnOLCvOY+hTcAqMGj3LJxYDrz2z+Qj7r2mF
 HJ19v5CGwSFLVLgvbwpIC2YvNzb678HLKHZLmsDGVDgkIZRyUBvkol32B9bffWMfoxra
 ZavgAurwvynmEMX+/TrAhNcSVkyjp6m671dWWGXvzhbqgJcRQoA2qHj7oqGhalm3I7cV
 JELgWXTTp/58rQ/88T8Hco4w0tvSqgxbcjXAhi5hpbB6szLKqxwgdG53dSMCOjNOrjoe
 9hvx67ViAfCIVSLvzGAo4R5fltJfMNym0fKveawXWIxj+eNfGktBDwqwtwh6vnfrEV4v
 OCTg==
X-Gm-Message-State: AOJu0YwB7FmlKSRfCRbPhziIiNT9UG+5vYMXL9hQTgmGfYnoK+rgsPVE
 ouygb0nAtyEsi5BA1Nmlr3OopHtEqiKnzDceYKyz8A9Gqh3m7K0cwSEA0/O9dVW5wTh1xcFRgne
 GOdAPVdo=
X-Gm-Gg: ASbGncvrUqt3PdfHA0c9uhJhI2lyZf1p2GY21FPLSWfgb/s9fKwgENSqRukiqX0czlj
 velULsOXo4H6FkFfJbrHF8R+fqijrFwEGyd1UIR/evZ+1tmfxg+MarqwPctbFB+a/xWNvZq+W+J
 gJCV81fxa482mmMybQ3AS6CMYHtFMJRUmHhLQKG9YQtj6dGupT+t98ruoYgWe6qQYBinHP8wR3o
 isPYGCKbqUHiVcJ5hPWdTbCVmIr9kanwhGDC4ZNYuJWrmjF+3X4RIvXZp4Yuy58Mp1yQyYtwgLT
 0zHxxbvrbBvjK/1RiPR8z8NYYVPMwWLG4prxOSCu0TmauUi1qbcLgMB6zq3obxaOj3kL5QcH8PD
 bMpIxx5n0VvtEJG5qQI6z76gEoB9ZzTvdGy+VeA5y4g0efK/41nEXiZr3m7nkulDtS2GjUHQ3Pz
 BACHfSSlPQ
X-Google-Smtp-Source: AGHT+IFEDQreCTRVJB1ajU8K1VdsyrwsOkMQvd3L98MLJBuqbUO2SXnYRy1jNHiib6fxtrAstQQBvw==
X-Received: by 2002:a05:6808:1b89:b0:441:8f74:e8c with SMTP id
 5614622812f47-4418f741cb4mr856964b6e.54.1760019537302; 
 Thu, 09 Oct 2025 07:18:57 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c0e333b875sm1221258a34.17.2025.10.09.07.18.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 07:18:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, yegorslists@googlemail.com
In-Reply-To: <20250926082023.460847-1-yegorslists@googlemail.com>
References: <20250926082023.460847-1-yegorslists@googlemail.com>
Subject: Re: [PATCH] arm: baltos: remove obsolete
 GPMC_NAND_ECC_LP_x8_LAYOUT macro
Message-Id: <176001953635.3159859.5400651861509568790.b4-ty@konsulko.com>
Date: Thu, 09 Oct 2025 08:18:56 -0600
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

On Fri, 26 Sep 2025 10:20:23 +0200, yegorslists@googlemail.com wrote:

> This define is obsolete, and bus width is now handled via
> CONFIG_SYS_NAND_BUSWIDTH_16BIT option.
> 
> 

Applied to u-boot/master, thanks!

[1/1] arm: baltos: remove obsolete GPMC_NAND_ECC_LP_x8_LAYOUT macro
      commit: f03601e3699b016d97c51208902e8401c5950923
-- 
Tom


