Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C479C531DC
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 19:15:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A169988ACB;
	Fri, 23 Aug 2024 21:15:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HEaO34z8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B7ED88ACB; Fri, 23 Aug 2024 21:15:26 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AB2288ADC
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 21:15:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5334a8a1b07so3041284e87.1
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 12:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724440523; x=1725045323; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9rhxPZm/fwtv6AMpHbovVzclu4BiVirOSwGzeOB+128=;
 b=HEaO34z8wOKNBT44IjWoUn32aTxdEsiHsJ3omm838K34DTid7nnbWutXI25HdCT/z9
 oz9cEtpbJSuf4Ron0A4de2CQ5bBomhj98Y7UIHWdePMoxOh2wwQCkoZUg9yLGcbOuf85
 YHcflDhSjNQTsm+y0E/r68tWMIHVZym80kVi9J8OkhRMitar9wJ8ZSct6Az4w0KWBN1m
 OyOTsjDEyUIem2LRppjtNA4roQj2sVhkzWqdrX3ciS5dQZK9bHwijw2iut5ZBkMYEFLt
 8JjPeEE0bPWBgcEahBYRJSwBC0Frv9k3ibwaCAlHqksOl+CKtKaz9xjA1M645WBjVi5O
 UA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724440523; x=1725045323;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9rhxPZm/fwtv6AMpHbovVzclu4BiVirOSwGzeOB+128=;
 b=vcHX6Wz7qVjU4Hhr6kGvMHY92SWgquKlsHWAaFSvpjy4GLlNxYVRTqL14NpT641mGP
 DdiQxMZGbCpqdfUr1xbrd7kG2aTKJAVQoE2lBHCGDzG/NHK3ctPC+DJkLeAtVEzEtoG2
 FKd8SCdqdSBsbyw2dRyFaaTSp2u4ozrVi86MnaKqao9llw9pv3pvf2L4HJu6lLG5wicu
 ApIFaIN65nUvwMCQU6iY080XIXtkJMtQY6Lfx2xG3hOSamPecibtRIgo2aLyVtN2LaN9
 gPuPXk0aIwDYof9QntFq4wifZOJ1IPZvgWNF9WK8inYExKtQbq4hB6oYD57Y4md6YUxU
 7K9w==
X-Gm-Message-State: AOJu0YzgsM6gMD5jCX8vBWUBz71FdqlHj9Y0pB2mFs4gpnPeVKYrAosS
 poI7Oad+hzXyZkNXNARaM8//sJC27N+iYALmDRhQpSCqd1hSnSncGmjDqA1UYZgZDCiF/4RPLU7
 cm0w+ryHc88FOlHtS3tiWl2+kh9PvSg==
X-Google-Smtp-Source: AGHT+IHK+8wA5pxPyV6MGKFf2Q4zZ4HnYKOstL8uG1GFBL6nIJjisUV1xieP02kxttz/X2UAsgx7hPaTVr9nGnpRdi8=
X-Received: by 2002:a05:6512:3e0d:b0:533:4638:df40 with SMTP id
 2adb3069b0e04-5343883b116mr1889320e87.27.1724440523066; Fri, 23 Aug 2024
 12:15:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240821210144.268622-1-marex@denx.de>
In-Reply-To: <20240821210144.268622-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 23 Aug 2024 16:15:11 -0300
Message-ID: <CAOMZO5BO85FC46wVqDSwUfJs=LrtASD_TUTuGHriDq0OdhWxmQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: Use USB SDPS as fallback option on Data Modul
 i.MX8M Plus eDM SBC
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Aug 21, 2024 at 6:02=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> The Data Modul i.MX8M Plus eDM SBC does have USB gadget capable port
> accessible via USB A-A cable plugged into the bottom USB 3.0 port.
> Use USB SDPS as the fallback boot device, so USB SDPS loading can
> be performed using e.g. uuu tool.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied, thanks.
