Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4EDC5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 20:37:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BD45822D7;
	Tue,  3 Jun 2025 22:37:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OlG9xJP6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B00808283E; Tue,  3 Jun 2025 22:37:26 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC97382103
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 22:37:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a4f72cba73so203210f8f.1
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 13:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748983044; x=1749587844; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ECHD6ncEIIdupNuLA+GH05nphw0YdtvUwj+zXZz+ZHc=;
 b=OlG9xJP6IQIWqjunNB111xWvnuKO6TIiYPACGdiWHX4SQL3qyAPZo/r+LvnTlFZGti
 qhbvQhKVWFuj2KoZntc342KgdIgTSNC98IG2DJ58FkcAOXazxqImWKlj+6tREondydnU
 YL03Ofc+Zp2hIWcCx8vwDlWDZBgW01yxXDnvUXzmFgYx/hkvRV2EZmQ5G2N9zVZzXmnC
 uMzal/GhLGORUxa7QdKk77ziZhaaMIfMm/+d92zmPK2SD1KroZDzvqolXVGqFVjTAxee
 iDuFrbNQgigKLMaPmRl4kkaHgSPmumPD+vW1j+SQoba8LI8dsh9S3rf6yADYwDD0NG2O
 x64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748983044; x=1749587844;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ECHD6ncEIIdupNuLA+GH05nphw0YdtvUwj+zXZz+ZHc=;
 b=r9DLUumJRENUzbf4m/8DSwly65mzbnJHo0rBVnUee47m2eKiWupNEPJ3W1BP+sShbV
 05RZ1MVhQoVvUwkrOKRn8ijhHAVHOu9SUHimujFZzP0OhOBpXaHD1LzML1kukeRWWmhy
 xawjeokP/0BfidtggWft4QHbUqpTb4PkcC4IQzRsvwoOY6tEsGWbYMNlQ6jkYSkCLYG2
 BxrhkMS6b7dO0mWEWV6if+xbNR+gDi+mEjYmbINc/ErVbyobLcw3SVEBuPDXvCubUvGO
 uC+qvm2zgAuuoWkMirEkxL7UHw1b+T/4Qu3PsOVnPwnrRsulfkKqurGAqIPJfj18dqEa
 U5FQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEQ8IwdVCif3mHUomIfWnGDwuQauZINKJJfbHmZ7sqCAIlVCJ9/k0mzO8+4VZ8eSTms8j2eNc=@lists.denx.de
X-Gm-Message-State: AOJu0YzTVnFnAr5Y0V9MU3fHu3H2ZKfpIjIm6RsFjgLN+yEQibqY/C3N
 ioLjCsnt42gn7zDPyCaA1DHBXjJb411D3fB7idqYnEaTGKbKgx7baZ3RFOihX+tmfGQ=
X-Gm-Gg: ASbGncuSMqshBzx5uUcFq452zW88PxBV4gfQSfiVEGFFPv2eF5U3DEVtn7KU4GcFoO3
 jOECj2DyW0cZzqCvGM08+hcoJX1cDak3fLTgzgeBgpY14WtgvKQwd/nSAQz/Ohz47CGTE+Sk4eN
 qfsCLkijYrBOgVb20kL6ixSOUk95Ep0ks2WRq9HoiQakFJaF+/m3biNIRuwyB0LI1Cb6aUYE8Lg
 BaecC5ElbO3gTk3jDHpT/FvOuiQcqmyLT7PQEG1DVhdQJSBTi6XuDB/E6YUMrWEHyyk4khH+f9I
 76V/G5OTab+sTx1AS/XsuAQopMnlRaTZtEkA+cQseitzXG+UECdSpHSoJy00oYsJHPBuIgZY8nX
 Xzd/Sg7o=
X-Google-Smtp-Source: AGHT+IH/41zbA0N2HYSfvqFsvtxPUAyWQQ3eNKYZLRlCqFv+TQkoknIqk4BgHlDXzFQIOchPCIQnSg==
X-Received: by 2002:a5d:4202:0:b0:3a4:eee4:f73a with SMTP id
 ffacd0b85a97d-3a51d55c82cmr210334f8f.22.1748983043985; 
 Tue, 03 Jun 2025 13:37:23 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f00972b5sm19443557f8f.76.2025.06.03.13.37.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 13:37:23 -0700 (PDT)
Message-ID: <683f5d03.df0a0220.437bb.ca9c@mx.google.com>
X-Google-Original-Message-ID: <aD9dAnG4iXEMMTM2@Ansuel-XPS.>
Date: Tue, 3 Jun 2025 22:37:22 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] linux/bitfield.h: import FIELD_PREP_CONST macro from
 Linux Kernel
References: <20250603085132.12407-1-ansuelsmth@gmail.com>
 <d272087c-4f0d-406f-9630-57fc1c68b403@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d272087c-4f0d-406f-9630-57fc1c68b403@cherry.de>
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

On Tue, Jun 03, 2025 at 05:08:13PM +0200, Quentin Schulz wrote:
> Hi Christian,
> 
> On 6/3/25 10:51 AM, Christian Marangi wrote:
> > Import FIELD_PREP_CONST macro from Linux Kernel to permit usage of
> > FIELD_PREP with scenario where a constant value is needed.
> > 
> > Refer to commit e2192de59e45 ("bitfield: add FIELD_PREP_CONST()") in
> > Linux kernel for extensive explaination of why this is useful.
> > 
> > This is also to better align with the Linux Kernel for easier porting of
> > driver.
> > 
> 
> Do you know it it'd be possible to simply copy Linux kernel's bitfield.h
> instead of "cherry-picking" individual commit(s)?
> 

Mhhh what do you mean? You mean syncing the full header with latest
version?

Isn't that more risky??

-- 
	Ansuel
