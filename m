Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B562C52D7B
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 12:17:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CB91889CD;
	Tue, 13 Aug 2024 14:17:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WobsFg8P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F84E889DA; Tue, 13 Aug 2024 14:17:23 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7535B8871A
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 14:17:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6b7a3e468a9so36694976d6.1
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 05:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723551440; x=1724156240; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b1YepHpJx2ebl7AoLPxyj75vYJ7M28gCoYvHefClf9o=;
 b=WobsFg8Pf1Jspn9J3LJVgg4dYSkDNqG22gvGQJ05MmqlwG6Pygz2By6x0IZ8sQRo2m
 d6RKDkxANBSN6q2uLk9v801blYe5wpGO78toHKQtD552Ek271+/uskMdf7+Dj/yBJPWf
 5uWs4g34njjL1Vd/ceq92+cY3wOIIhdk0OHXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723551440; x=1724156240;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b1YepHpJx2ebl7AoLPxyj75vYJ7M28gCoYvHefClf9o=;
 b=lxGUi89Plp0U4+0C8n7W2sxlbtevlUXznGRxGfSsbVBERLcLUr7w4XpsqBvPA+aYJ5
 4VixqVgovSPHsJb/XSyJLOHXZ6ljt+PyHDoYy6rDV9FwkYL8DEegGxJ8tKZT5tnS2LxM
 0QfU/i4DX5SMtnODS9UqNeq9+yw/1uDZG/IOFBcAbczLUndEVd1PaBOlrWzMkuZULnij
 XAjMYsO9QPK4G2xjeZhVMBSLJr+dFPr5525bhjO+Wp0+Aapqtf7JxPwf3tX06U1fQneX
 QF0p4urU1jfjIDb9LIYNTJ3yBc/dSwBlYEXRHIEWQ1jo+ofDszSCEURD4n3gWQ2r6C23
 X8QA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYI9nEUHNsWHIfkU+i956iTsVETU8MZfdxI7YxUvYGhfOQtrOBftuzV0U/WKQefcvz/I58VXfbeUioa3syRoGMFbIK2g==
X-Gm-Message-State: AOJu0YzAjmjVGgnU4R02MoIoWpvfjgm9ksFXnwAulNO55/FVTHXopzJm
 Lofxty9GnqLa/B6PiHcx7axM1atcWlQ2bxRvzlAdSVxR4Ve1C4nNqqHFE/l4S7cCkwudvnSfsSP
 tzCKlzJrU125I4GCArgs2WmfCyR34evAk2XSN
X-Google-Smtp-Source: AGHT+IFaaVB3xnl2OptXzjrOzSXLIh5qfB9VuzeXQMaPvlRWVdV0YIlVSyMz26bN50f1lnZhkZBRo/epZF+Ts5WMW/U=
X-Received: by 2002:a05:6214:3b89:b0:6b5:e665:7f7 with SMTP id
 6a1803df08f44-6bf4f64778dmr35020866d6.9.1723551440328; Tue, 13 Aug 2024
 05:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240811145209.4191404-1-sjg@chromium.org>
 <20240811145209.4191404-32-sjg@chromium.org>
 <CAC_iWj+DtHbghAqJWiwm8ZVCXf3mCOOm13YpLSQGGBPcpgnWiQ@mail.gmail.com>
 <4D176BE3-6F0E-4A7B-A550-18C8954CC844@gmx.de>
In-Reply-To: <4D176BE3-6F0E-4A7B-A550-18C8954CC844@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 13 Aug 2024 06:17:09 -0600
Message-ID: <CAFLszTjse7RWeorPx8xy5Kof1WxY8q3U+PGsR9vC5Qohhc5eKw@mail.gmail.com>
Subject: Re: [PATCH v3 31/40] efi: Show the vendor in helloworld
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
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

On Mon, 12 Aug 2024 at 04:35, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Am 12. August 2024 09:58:28 MESZ schrieb Ilias Apalodimas <ilias.apalodimas@linaro.org>:
> >On Sun, 11 Aug 2024 at 17:52, Simon Glass <sjg@chromium.org> wrote:
> >>
> >> Show the vendor name so it is clear which firmware is being used, e.g.
> >> whether U-Boot is providing the boot services.
>
> I never had any doubt about which firmware I am using.
>
> Originally you expected "U-Boot" to be printed on any device as indication of the copyright.
>
> Why is this patch needed? Are you checking the output anywhere?

Not at present. It is just nice to see U-Boot printed out when the test runs.

>
>
> >>
> >> Signed-off-by: Simon Glass <sjg@chromium.org>
> >> ---
> >>
> >> (no changes since v2)
> >>
> >> Changes in v2:
> >> - Reword commit message
> >> - Use 'Firmware vendor' instead of just 'Vendor'
> >>
> >>  lib/efi_loader/helloworld.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/lib/efi_loader/helloworld.c b/lib/efi_loader/helloworld.c
> >> index 586177de0c8..c4d2afcb40a 100644
> >> --- a/lib/efi_loader/helloworld.c
> >> +++ b/lib/efi_loader/helloworld.c
> >> @@ -237,6 +237,9 @@ efi_status_t EFIAPI efi_main(efi_handle_t handle,
> >>                         (con_out, u"Missing device path for device handle\r\n");
> >>                 goto out;
> >>         }
> >> +       con_out->output_string(con_out, u"Firmware vendor: ");
> >> +       con_out->output_string(con_out, systab->fw_vendor);
> >> +       con_out->output_string(con_out, u"\n");
>
> How about FirmwareRevision"?

How about we start by getting this series in and then we can enhance it.

>
> Best regards
>
> Heinrich
>
> >>         con_out->output_string(con_out, u"Boot device: ");
> >>         ret = print_device_path(device_path, device_path_to_text);
> >>         if (ret != EFI_SUCCESS)
> >> --
> >> 2.34.1
> >>
> >Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Regards,
Simon
