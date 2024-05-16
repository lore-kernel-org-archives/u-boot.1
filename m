Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27DCC25B79
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 09:09:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA0DD88027;
	Thu, 16 May 2024 11:09:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="Bilpqsyg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AD2C8824A; Thu, 16 May 2024 11:09:16 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EA7C87FED
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 11:09:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge@foundries.io
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42011507a54so30691555e9.0
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 02:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1715850553; x=1716455353; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sRZuoe5Cd0pNFy/cV6gjaVmq1Ete09uq2W43CXmbMYI=;
 b=BilpqsygUSHZpkbyZjbsGlJwt2brVwXzBS6XkbeT7gsQIwu60jQMihwUIxxfwWr9R+
 LxmD2i0C6hL5KqsS984dv92aA3GjX79YxE8xuWUeq0XqP2r+s5UglgrlTRrdY1DQng5d
 1l8AXeMF3MGuIYhkPLA3n4QfK2j9PlSeASBmcU/2rg+n2wAadAaeWaPuWtoudwH3Vbzx
 WeRqVKj0jQ4+uo95vj29Mss9RummxSvcWD1TGbMhIxIYsRnu2X6vA0oQeeNc7zKGmZT6
 qf2SCfuSe8XNMRP0CJusobaxnmd7Tk4cXLuhjm9F8pU4CgQRH9+G97ZIc1+GXfVMH0m7
 MU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715850553; x=1716455353;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sRZuoe5Cd0pNFy/cV6gjaVmq1Ete09uq2W43CXmbMYI=;
 b=Snu3m8NSwXnDfKpRBFFX9iMUF4fxDL2SRbaNhj/zUilE5EJ06eFC249ybPFW9fVQpD
 QevYND7LZmMlMc7IzmSFEL0vISZKwfVRC33+C711SdCzPSRRuGWSy/IlCzeHOwm5SWpd
 VduuBsRuSWuidvRiNy6P4HF5smjTBXei4hrfvHB/GymOwjGxglKd7IYV7nTsIIL95PpP
 dVe4Q/9EVba5xqGouWM/XP1XDxf+d067AFTghrH1m0wh3tvJT3biChX80dujrbTj5fAU
 g6GZGM/vIIDgZo5cuThjC6tYzYRUcuFGmhF6GqR7nLTzJsXkZzgLnx9YcibNWZ9VbG4t
 F/TA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW00f20N2oOlkspRuKQ9T7j1ZjvZouEM6muGPsMLohPGK1z3t6wQVZPCyEXLOu0lGDsUjBknc54HWuINmTe65tkQYK26Q==
X-Gm-Message-State: AOJu0Yz3mRdQYuHZmI0e6KmVHW0gl7yXmEzqAvOBocOkWykRrTLKDmS/
 6fnqdmHSAtYDm3QEr/X/PdDgnMVxUqEXEKuaBiicATZHCqMM3akB8UZlCLXp79I=
X-Google-Smtp-Source: AGHT+IFqAvj0ODyzIMs7rMso3H+MEzD4B9MGEvKIGc8KtPy9X8J+8ygvxBaYzJ3IrVXpwyCiQZ2b4Q==
X-Received: by 2002:a05:600c:3c8e:b0:41f:9edf:de50 with SMTP id
 5b1f17b1804b1-41fbcea32ddmr206091725e9.15.1715850552903; 
 Thu, 16 May 2024 02:09:12 -0700 (PDT)
Received: from trex (113.red-79-144-189.dynamicip.rima-tde.net.
 [79.144.189.113]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41f881110f9sm298204165e9.37.2024.05.16.02.09.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 02:09:12 -0700 (PDT)
From: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date: Thu, 16 May 2024 11:09:11 +0200
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jorge Ramirez-Ortiz <jorge@foundries.io>, Adam Ford <aford173@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH v3] tpm: display warning if using gpio reset with TPM
Message-ID: <ZkXNN4I/gFgjD3oP@trex>
References: <20240515232138.3065987-1-tharvey@gateworks.com>
 <20240516090950.373d304c@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240516090950.373d304c@xps-13>
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

On 16/05/24 09:09:50, Miquel Raynal wrote:
> Hi Tim,
> 
> tharvey@gateworks.com wrote on Wed, 15 May 2024 16:21:38 -0700:
> 
> > Instead of displaying what looks like an error message if a
> > gpio-reset dt prop is missing for a TPM display a warning that
> > having a gpio reset on a TPM should not be used for a secure production
> > device.
> > 
> > TCG TIS spec [1] says:
> > "The TPM_Init (LRESET#/SPI_RST#) signal MUST be connected to the
> > platform CPU Reset signal such that it complies with the requirements
> > specified in section 1.2.7 HOST Platform Reset in the PC Client
> > Implementation Specification for Conventional BIOS."
> > 
> > The reasoning is that you should not be able to toggle a GPIO and reset
> > the TPM without resetting the CPU as well because if an attacker can
> > break into your OS via an OS level security flaw they can then reset the
> > TPM via GPIO and replay the measurements required to unseal keys
> > that you have otherwise protected.
> > 
> > Additionally restructure the code for improved readability allowing for
> > removal of the init label.
> > 
> > Before:
> >  - board with no reset gpio
> > u-boot=> tpm init && tpm info
> > tpm_tis_spi_probe: missing reset GPIO
> > tpm@1 v2.0: VendorID 0x1114, DeviceID 0x3205, RevisionID 0x01 [open]
> >  - board with a reset gpio
> > u-boot=> tpm init && tpm info
> > tpm@1 v2.0: VendorID 0x1114, DeviceID 0x3205, RevisionID 0x01 [open]
> > 
> > After:
> >  - board with no reset gpio
> > u-boot=> tpm init && tpm info
> > tpm@1 v2.0: VendorID 0x1114, DeviceID 0x3205, RevisionID 0x01 [open]
> >  - board with a reset gpio
> > u-boot=> tpm init && tpm info
> > tpm@1: TPM gpio reset should not be used on secure production devices
> > tpm@1 v2.0: VendorID 0x1114, DeviceID 0x3205, RevisionID 0x01 [open]
> > 
> > [1] https://trustedcomputinggroup.org/wp-content/uploads/TCG_PCClientTPMInterfaceSpecification_TIS__1-3_27_03212013.pdf
> > 
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> 
> Looks way cleaner, thanks.
> 
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> Miquèl

nice. if needed

Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
