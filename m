Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F988E77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 12:36:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97B1F801F5;
	Thu,  9 Jan 2025 13:36:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VOF0Vz2W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A46E801FD; Thu,  9 Jan 2025 13:36:18 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DC4B8005B
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 13:36:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5d3bdccba49so1259265a12.1
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 04:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736426175; x=1737030975; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4GiDwJB8TNya9avMgTChpp/5FTf1E5NAz4hh2Il91E4=;
 b=VOF0Vz2WS2fWD0qAJw5eCyJQYxV3O2Y1Klk0hFtWiztvseD0lbiz+fhHhOL3RZGDG8
 7Na6UmKEHHIjtV4kM48tCXtthPwpLVFDHpRc4XFNVZ5R1kxZgtJqzdL2BcV/2YnVoOaC
 RHwHtM/aRBxip6rpCVC8yXuMSR3nyeYYC3UIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736426175; x=1737030975;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4GiDwJB8TNya9avMgTChpp/5FTf1E5NAz4hh2Il91E4=;
 b=BgIk9IArBOaycSOplOmPatvsfbE9U0PAO9ZCCG4pU23cj5aJOkLIBjP0L0cZgx8/Jq
 ApcReGJeu1Sh0rfKQsJpyyt+Ma6YG+EVdRi5+kTFnP5YBY7AZiYd7wA+3OvX0ZREcpyO
 Y+ofztKPolaVNQwdFJT4xnR+kCYZXM8WHJdbdC1l9hVOzJ4TAQHuUwOLJjAr/WDuHcS0
 HN/Q8mYqnMICQRWfmV/W91Dcv8Gt1/ASFm1XDUs5Eq/lDtE220InbVEuW6eASRCde1mV
 7zfAm5rOQx39pOnYvuFkTyjkndoSc+TDgI2ZD9ci2tRyu3+K/4CpfJq1s47IItZdVrVW
 xgRQ==
X-Gm-Message-State: AOJu0YxYuz0X3ZDZQHob41bRwrL/t0NF4ScZCiNi4l7Mk3jd7Ng8atuy
 hb2lwd/JXPk1kAoYfxzCAHV40SMzBudYFp74ZIpdw7iF4Rwq2h79U+qjRp8RReRwcEV5GzBzW/Y
 pJXPbdHr3ihxO3dc+yi3/XldQ03UbThMouYrz
X-Gm-Gg: ASbGncsT7dbhbBlin5c0zXfFmDzvUWQW+E+5T/eIoZL+fxx1W8/AJyj/hyBBtnXtsY1
 0gjW+n0uX/gUE3hFzt9qHuwPjwLXOtuUFZS4nhHw=
X-Google-Smtp-Source: AGHT+IHwZfJEMH22BHvRBK7eQmhs5zglODlNV5MURl2vItpaALzxzFqR6VbTG1j2cfWyaJW/TKutP/Oh/fxP+mW+h3Y=
X-Received: by 2002:a05:6402:4407:b0:5d3:d733:7ad4 with SMTP id
 4fb4d7f45d1cf-5d972dfe6abmr6521870a12.3.1736426175496; Thu, 09 Jan 2025
 04:36:15 -0800 (PST)
MIME-Version: 1.0
References: <20250106143229.3023771-1-sjg@chromium.org>
 <20250106143229.3023771-18-sjg@chromium.org>
 <20250108182528.GN3476@bill-the-cat>
In-Reply-To: <20250108182528.GN3476@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 9 Jan 2025 05:36:03 -0700
X-Gm-Features: AbW1kvalYibPKAfOq9kKlYK60wf5p6lPQMTTQod97VhdF_snuvPzFwWqB8NLcvg
Message-ID: <CAFLszTh=HYTxwNSBOOmaiPpG+DO8tc52=XsQQiXAfMSpcwediA@mail.gmail.com>
Subject: Re: [PATCH v2 17/33] boot: Update fit_image_get_emb_data to use abuf
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Dahl <ada@thorsis.com>, 
 Alexander Kochetkov <al.kochet@gmail.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Devarsh Thakkar <devarsht@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hugo Cornelis <hugo.cornelis@essensium.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Janne Grunau <j@jannau.net>, 
 Julien Masson <jmasson@baylibre.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Maxim Moskalets <maximmosk4@gmail.com>, Nikhil M Jain <n-jain1@ti.com>, 
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, Raymond Mao <raymond.mao@linaro.org>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

Hi Tom,

On Wed, 8 Jan 2025 at 11:25, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Jan 06, 2025 at 07:32:13AM -0700, Simon Glass wrote:
>
> > This function uses separate arguments for data and size. Use the new
> > abuf instead, so that they are paired and in one place. In some cases it
> > also saves an argument, thus potentially reducing code size.
>
> This is one of the commits that globally increases size in both full
> U-Boot and SPL/etc.
>
> Is all of the "abuf" changes just a "tidy up" that increases the code a
> bit?

Yes, a tidy-up which I hope will help overall. I have been thinking
for a while of how to avoid having addr/size and ptr/size passed
everywhere. For now abuf seems to provide some sort of solution.

I see this:

18: boot: Update fit_image_get_emb_data to use abuf
   aarch64: (for 1/1 boards) all +4.0 bss -24.0 spl/u-boot-spl:all
+16.0 spl/u-boot-spl:text +16.0 text +28.0

so growth on firefly-rk3399 but not with rk3288. I am not sure if the
growth will tail off as there are more users, though. We might even be
able to be more clever with static inlines.

Regards,
Simon
