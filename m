Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20466E7717F
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 05:38:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46B7289416;
	Tue, 10 Dec 2024 06:38:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M9tAfGNw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FD1389450; Tue, 10 Dec 2024 06:38:25 +0100 (CET)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBCD889403
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 06:38:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pericycle.cc@gmail.com
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-2164b1f05caso17787025ad.3
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 21:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733809101; x=1734413901; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/g7sz0Qx3SKnYf0r33xPh9cBqz3NUE0V8zki/ErKCDw=;
 b=M9tAfGNwe3eQ0IxnHP7i4QnXgR1kMF+45eurV/LMU8YDJSMfnytSze9OqcNNKuzpwG
 DqW3oRZZMj4qx1UFAxZSPcyo18eOSyvFuViAge6VUSAsxCPtnwrUzxQ5yRMeGbaMVmWa
 ZumpHAo/eiLctGirDKmYlSonI+GBlNL6j7JxWQkv3L0/pUqctj1G0L7ObtkD8jxrTu5i
 8/Sx6DM/IXgTWBV6PpHJAeX9Pf7TFYfGOCJfaRra9QevKbRWZpjK/qax7WmNZv2lvGYR
 15pdgc5c0Gq6VIU42fZfa8RbO9ad3c3VyeFyXRgkgs4KZhmCaOGeW14CaTMaSFcWKlLh
 ZQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733809101; x=1734413901;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/g7sz0Qx3SKnYf0r33xPh9cBqz3NUE0V8zki/ErKCDw=;
 b=dwLuzhhuvN1tyBWewlUZnzx/C2f6J8OetslWyyPNSE5YnuT0+ImRbuBfJczcgU3BDm
 1T/XCOcjhGt/N4GrhxcvnZuxqXipqi6FgjASHXcfEq1KW5UK83biyDWdMtG+R3q48/Mr
 62+CLcnJdO8XZ8eq7FbvU+Phe6Z9qrQmuUWUQcOFXmHvqo0ciE+8Fv7a6a4nHijdzTbm
 yR4s2oh0mPMlJ9tKYRX03hq+OtRpBwkBgPS9m7Kfh89QO2rTlss6ZSY3R9PqFszz77xc
 YPcCOHlq2wAU7wIPJ4fofybgc9KHuGEJEAPPzG1H0q3jD8bVa0ki0SY8iy6MSoPlf13E
 U/JQ==
X-Gm-Message-State: AOJu0YylOQC2NDFCI+WdOasA5mx+xQDY+0iIAW0bt6HOWn44BsWkWNzV
 BxCE+iV4c18DFUrP5IOOhjTdIHZTIqx91leams2VsyWF1XNvkW+Q
X-Gm-Gg: ASbGncti78BFzzxGwlL8p9W1m8S5ItPavDj1wY0oiSuM6bSZNAhXd3Q5Scm6v/iOEku
 h6rh120/7EWdmee6iQcobZLdwGnMOraRfltGji+1YETSkUpOdXaK3scS8iPqx9W1IoTgJi0rmsT
 +YBNFkU8/50/g/PQJT1J98Uxpxrb54XnaxusK1c8P5g45jkEi6yY6e018c58X8gen3o5UvfejL4
 JsYkYaD+IiDyerDSkN32u6F01bw+rvfqirAr6sucUynTZwXPfebvabah9j53/TNdGYKOrWyKXCu
 QKh46ZasAvI55Ucp6JpiQQo=
X-Google-Smtp-Source: AGHT+IH/DrfDmy28NIcnZ18bZMFODBywKyH1Dz2yknJShs9ugiZ0g0OVz1hPI9P4TSQLVHdIqjWKFQ==
X-Received: by 2002:a17:902:d58f:b0:216:46f4:7e30 with SMTP id
 d9443c01a7336-21646f480e4mr118393185ad.43.1733809100990; 
 Mon, 09 Dec 2024 21:38:20 -0800 (PST)
Received: from per1cycle.per1cycle (n220246100016.netvigator.com.
 [220.246.100.16]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21641f46e3csm34093395ad.181.2024.12.09.21.38.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 21:38:20 -0800 (PST)
Date: Tue, 10 Dec 2024 13:38:12 +0800
From: Huan Zhou <pericycle.cc@gmail.com>
To: Yixun Lan <dlan@gentoo.org>
Cc: u-boot@lists.denx.de, Ben Dooks <ben.dooks@codethink.co.uk>,
 Marcel Ziswiler <marcel@ziswiler.com>, Bin Meng <bmeng@tinylab.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jonas =?utf-8?B?U2Nod8O2YmVs?= <jonasschwoebel@yahoo.de>,
 Kever Yang <kever.yang@rock-chips.com>, Leo <ycliang@andestech.com>,
 Michal Simek <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>,
 Padmarao Begari <padmarao.begari@microchip.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>,
 Samuel Holland <samuel@sholland.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Kongyang Liu <seashell11234455@gmail.com>
Subject: Re: [PATCH v5 1/2] riscv: spacemit: bananapi_f3: initial support added
Message-ID: <20241210053812.4rleguzgmeduptwk@per1cycle.per1cycle>
References: <20241209-pickup-bpif3-v5-0-92f801b7c6c1@gmail.com>
 <20241209-pickup-bpif3-v5-1-92f801b7c6c1@gmail.com>
 <20241210021525-GYA1905152@gentoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210021525-GYA1905152@gentoo>
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

Hi,
First of all, Sorry for the previous private message.

On Tue, Dec 10, 2024 at 10:15:25AM +0800, Yixun Lan wrote:
> Hi Huan:
> 
> Please rebase this patch on top of most recent master branch
> as it fail to apply due to changes of arch/riscv/dts/Makefile
> 
> On 10:00 Mon 09 Dec     , Huan Zhou wrote:
> > From: Kongyang Liu <seashell11234455@gmail.com>
> > 
> > Add basic support for SpacemiT's Banana Pi F3 board.
> > Update the k1.dtsi align with mainline.
> > Note that the device tree files follow the mainline Linux source[1].
> > 
> > [1]. https://patches.linaro.org/project/linux-serial/patch/20240730-k1-01-basic-dt-v5-8-98263aae83be@gentoo.org/
> suggest style: Link: https://.. [1]
got it.
> > 
> > Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> > Signed-off-by: Huan Zhou <pericycle.cc@gmail.com>
> > ---
> ..
> > diff --git a/include/configs/bananapi-f3.h b/include/configs/bananapi-f3.h
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..aecf69cd4cf8ddaea7dee57bf1a8ce8dc5db513d
> > --- /dev/null
> > +++ b/include/configs/bananapi-f3.h
> > @@ -0,0 +1,13 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > + * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
> > + *
> > + */
> > +
> > +#ifndef __CONFIG_H
> > +#define __CONFIG_H
> > +
> > +#define CFG_SYS_SDRAM_BASE         0x0
> > +#define CFG_SYS_NS16550_IER        0x40
> I'd suggest to keep the comment..
ok, should i send next version of patch btw?
> #define CFG_SYS_NS16550_IER        0x40 /* UART Unit Enable */
> > +
> > +#endif /* __CONFIG_H */
> > 
> > -- 
> > 2.39.5
> > 
> 
> -- 
> Yixun Lan (dlan)
> Gentoo Linux Developer
> GPG Key ID AABEFD55
