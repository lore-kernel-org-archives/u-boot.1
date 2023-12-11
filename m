Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD5C4C4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 04:24:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B52FD87718;
	Mon, 11 Dec 2023 05:24:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VElDCtwc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99F1187719; Mon, 11 Dec 2023 05:24:26 +0100 (CET)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 603E787712
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 05:24:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2ca00dffc23so49539381fa.2
 for <u-boot@lists.denx.de>; Sun, 10 Dec 2023 20:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702268663; x=1702873463; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=d9DlkPilUIqLbxnrhlQbHdkrJTOIjVByUSaEJxW6p74=;
 b=VElDCtwc+a8AZo7PlgqenHnuyhDPpJ6H11UVX2IIpcBXZpV63VUqxChffoA6AmZseC
 1QfdedFBXfJXkhE116sm4dS6sWILuCb+fyRC3+/Uyb0b8T1kVWlzzGx0mrAhzQyuiZgB
 10Fu62An/gzhSZ7rFDXVa38blUdG+lL2fVrItNuH5PDdwxxv6ZXjjooUXPCSmOIlxb2C
 FwBHQdiQ/BJUJndlQMxshRfG41m5Svr+Dpqz+eXhBQUR0yT4qDUCteJ6UCtDVpfvWsbV
 DupgweFCEZZg+/A4EUPyIE7jOGP/Dk7IzNcJY2x214v80qqoqduJGz/J0d0FLQRT+DQn
 LIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702268663; x=1702873463;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d9DlkPilUIqLbxnrhlQbHdkrJTOIjVByUSaEJxW6p74=;
 b=rGUo1XkuHKp1EsZiytYGnaSU6KDtvjE7XXNt3Je7eCW7d1byPRrEiKYQX9+z9YwNhI
 +7KVjh52+CrUAzzNzPHp3YzbluhdUP4h673/NgVM6KLh0/awCleOdNooeYrCVF1buwZJ
 /51vpKbnXT7qG5ALtaFETFEXPGqPTGMfialnJlRfkQOMVLhrUKKjBQsdrztneWUxZxNc
 FfVs54OSPcr2D1sowvr9WDaOF4Hw+GXjqI46AGx1O3p71qQMvl+ZJcUaCtDuIT5DS9Vp
 8NbNCIu3tPzFRfnjgWo+wWuZp8Ro9+UZQybF1B/4ufXzvQa/JI0my7TOra/MI8wZKHFV
 vuoA==
X-Gm-Message-State: AOJu0Yxsw447j8iyIKBUGgx3dwvXwm0kUoU/FFHOcaavNBWpOMXyLBvD
 7tRvXrK4fmAxm8IGorCU5noXNkM7xY/rdRYDTZCXrg==
X-Google-Smtp-Source: AGHT+IETwAWEQdlHnkcFwVpcsRCsP2HUw5Rwtv77GqKhKjgoA/mZZ05Gm3volP5RNaqGzZVAxMoVbFoidqt2de4HLRc=
X-Received: by 2002:a05:651c:2d9:b0:2cc:1f06:9ad4 with SMTP id
 f25-20020a05651c02d900b002cc1f069ad4mr489977ljo.34.1702268662998; Sun, 10 Dec
 2023 20:24:22 -0800 (PST)
MIME-Version: 1.0
References: <20231114092508.3955838-1-masahisa.kojima@linaro.org>
 <20231114092508.3955838-2-masahisa.kojima@linaro.org>
 <f97c5b43-7e71-41d4-a22e-a347e3c91ca4@gmx.de>
In-Reply-To: <f97c5b43-7e71-41d4-a22e-a347e3c91ca4@gmx.de>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Mon, 11 Dec 2023 13:24:11 +0900
Message-ID: <CADQ0-X_JY70Ay_xbTeDznOQwTk4jX=B6S2QFm=PkznwW=u-jLw@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi_loader: use original image_index for FMP
 versioning
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Jassi Brar <jaswinder.singh@linaro.org>, u-boot@lists.denx.de
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

Hi Heinrich,

On Sat, 9 Dec 2023 at 23:51, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 11/14/23 10:25, Masahisa Kojima wrote:
> > FMP versioning uses the image_index argument of
> > EFI_FIRMWARE_MANAGEMENT_PROTOCOL.SetImage() service.
> > When CONFIG_FWU_MULTI_BANK_UPDATE is enabled, image_index
> > is updated by fwu_get_image_index() function. This commit
> > saves the original image_index argument and use it for
> > FMP versioning.
>
> Why should we call fwu_get_image_index() here if we don't use the new
> value? Maybe the call should be placed somewhere else?
>
> Should the call really be needed here, please add a new local variable
> inside the if block and add a comment describing why the call is needed.

fwu_get_image_index() aims to convert image_index in FMP.SetImage() to
dfu_alt_num passed to dfu_write_by_alt() function.
I think fwu_get_image_index() should be renamed and does not update original
image_index. I will send the next version.

Thanks,
Masahisa Kojima


>
> Best regards
>
> Heinrich
>
> >
> > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > ---
> >   lib/efi_loader/efi_firmware.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
> > index 9abb29f1df..9c1a273926 100644
> > --- a/lib/efi_loader/efi_firmware.c
> > +++ b/lib/efi_loader/efi_firmware.c
> > @@ -612,6 +612,8 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
> >   {
> >       int ret;
> >       efi_status_t status;
> > +     u8 original_image_index = image_index;
> > +
> >       struct fmp_state state = { 0 };
> >
> >       EFI_ENTRY("%p %d %p %zu %p %p %p\n", this, image_index, image,
> > @@ -641,7 +643,7 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
> >                            NULL, NULL))
> >               return EFI_EXIT(EFI_DEVICE_ERROR);
> >
> > -     efi_firmware_set_fmp_state_var(&state, image_index);
> > +     efi_firmware_set_fmp_state_var(&state, original_image_index);
> >
> >       return EFI_EXIT(EFI_SUCCESS);
> >   }
>
