Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54CA4CAC5B8
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 12:06:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CA5B828A2;
	Thu,  2 Oct 2025 14:06:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cUbt/6Ty";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03FB3831D3; Thu,  2 Oct 2025 14:06:42 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 179AA81D6A
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 14:06:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-62ec5f750f7so1575892a12.3
 for <u-boot@lists.denx.de>; Thu, 02 Oct 2025 05:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759406799; x=1760011599; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YERmCLWpUmtJW08Qr3IOgn50tEHivlyOlQXrw/4Hf/o=;
 b=cUbt/6TyFax/qFVmer2rYUhXDW+vGAu0uu6MTSJX0AJyR+26kEGPjBlkFWYXgPp+eN
 rPATbiAgarRecQiGvZ8tQ/qHAjndzhw8xSW6SdM1re5HDbblA9sSQ8VZl9+ON0nswyNZ
 VqCSFIK9W8jRZTI5nyLfOJbmHFU48V89+l7FogQK4vVXRMZLqhgzs0DJ/reTtgjYRMsE
 xU7VwzeHck85GPYyBw8VlE7IGaWKEZw6cJomU6fYV9OlrxC3EjzjHsa0rJX1kEebKyuZ
 jFgZaljS+RIiX3Mm8Kc88hiMloFzBcaUc5PbZEsiwHv+xuJ+bunHJobFgBnCWLJ6o5fL
 /AZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759406799; x=1760011599;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YERmCLWpUmtJW08Qr3IOgn50tEHivlyOlQXrw/4Hf/o=;
 b=pykY4hzw0DmAcFgMCiZe1HJPVdaobVqSybASKAoUiS4aSAw8BQGJVVTIR6rwxw65OK
 E+d7LlGw0RuhL9HO8wqpTD+mDxjenNTBKKkFtB47zHGIbNs45RZhX9GMMh7kL4lzxVn9
 q+uIP/nn5mHIDzlXe1yUwPOQfEuKGCRiDDCTq9yOre4+/J//jUG2Q5lytFf7grhrBpGH
 VGG0q73o4KgVI3P50WYwpQ4j8Nb/YLQzb1Nbvj90bl0DoqCt+toYThmJ+5e2WOnmrs3c
 r3bcUYmPAAP9Wvc6PjsAbbY4qpn0x8eQdUofcCFEtFUKZ8PWUUDrQdTYzWISZMm46wVT
 T0yw==
X-Gm-Message-State: AOJu0YzAt6agQxPUQ/CtSu2PFPGvgfDc5okHrgJsNiEagiqkL7a3s1i+
 4VdCFhb+FyI/EJF0nLRFpek+5LDsLw7n8h7NC6kpwCSw2E07Qj9AZSTnUBhzno1FBXwtN0EdAgy
 MEQ75AdgI3L9rCEflx13uO0Vhz0HeboxPGvOMsv8=
X-Gm-Gg: ASbGncsg1WwCuD/LFDOz+pqPGHEB1/Fej3wAp0Ygiyi9otkZtKbAZHAO2wzQVlZITKw
 tNbYd/NJ/d+jMXD8TFHQZxBxoM+3oxdgBIoLjRIC3X67kITuUH1pOi8YHKUOZk1NmowcxeCrKTh
 5DmWSJs0KUfPlNRPWw4WaeZhuO1E8m/gQ9f3gCe+HyaIPRAOxnDt9fCHqu0f+E77HWwqPCO6bsp
 0DWXy3JnArl/wqmReeWOPqH/s8zL7F2lkHFz0KdU4dYNsvoGEKjb9VRceUIKw==
X-Google-Smtp-Source: AGHT+IHvGbuL4FmYoWacOWWXKRH1075KEy6otBQhm+qs1NCkFmKnq6+twsL9/o5s5ftB9LC3GBbJjIyBPdxcPbhHc3s=
X-Received: by 2002:a05:6402:3549:b0:634:c2fc:7075 with SMTP id
 4fb4d7f45d1cf-63678bb6d4emr7882281a12.10.1759406799162; Thu, 02 Oct 2025
 05:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250825224459.682403-1-adrianocarvalho.pt@gmail.com>
 <20250825224459.682403-5-adrianocarvalho.pt@gmail.com>
 <20250825230044.GB124814@bill-the-cat>
 <CACAHuLCyX_32AQozgt-Wf18b7ia5m3nRJZ7bA=M9oM1mwh-OXA@mail.gmail.com>
 <20250827002317.GF124814@bill-the-cat>
 <CACAHuLB0uwUjnR58qgeoOcHO-PC5geYFuBKF4Mw+=UFjT9urRQ@mail.gmail.com>
 <CACAHuLDZzgF1a7wG8fwNZ1YnUruPgyd9MifY2COS1kQFsqXsTw@mail.gmail.com>
 <CACAHuLDp5COeBue8jt8U3s59UsTnzjFH33ThXVFXk7-XLCF1BQ@mail.gmail.com>
 <20250905230929.GN124814@bill-the-cat>
 <CACAHuLBgL2h+XYysfwYSOBcwyjrJRk7Z4X5Axr6PDDF_Xq17Rw@mail.gmail.com>
 <20250924005717.GG197373@bill-the-cat>
In-Reply-To: <20250924005717.GG197373@bill-the-cat>
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Date: Thu, 2 Oct 2025 13:06:27 +0100
X-Gm-Features: AS18NWC_AwyDxaA1vbm6zMuQjZOdMF2WaZweIeD1-viUxZJlJgs9paB5F2tzPNU
Message-ID: <CACAHuLBdYcpXRP0MTeiz4AGUAScQ0zf=+81Ez+wXEP+fzyhUrw@mail.gmail.com>
Subject: Re: [PATCH 4/7] doc: make pdfdocs: Ensure SVG files are converted to
 PDF before the compilation of *.tex files
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Neha Malcom Francis <n-francis@ti.com>
Content-Type: text/plain; charset="UTF-8"
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

Is it ok to replace all instances of ".. image" with ".. kernel-image"
(65 occurrences / 17 files)?

Com os melhores cumprimentos. / Best regards.
Adriano Carvalho

On Wed, 24 Sept 2025 at 01:57, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Sep 23, 2025 at 09:49:05PM +0100, Adriano Carvalho wrote:
>
> > Ping. Any update on this?
>
> Yes, a patch has been posted and is currently assigned to Heinrich. A
> follow-up with a cleaner diagram has also been posted. If you would like
> to rebase your work and in the cover list them as dependencies that
> would be good. Thanks again for looking in to this!
> [...]
