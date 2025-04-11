Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A136C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 09:43:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5564983F8E;
	Fri, 11 Apr 2025 11:43:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GmMyHIFz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 898EE83F9B; Fri, 11 Apr 2025 11:43:15 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57E8D83F85
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 11:43:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-30c091b54aaso15080971fa.3
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 02:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744364592; x=1744969392; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GBLSNE5ChOXBFKb9IO560JhDcP0DDDzgBYOptmfsXR4=;
 b=GmMyHIFze4h+2qzW1lSoRtmZ0STObp7rdqpi4r7yWQ1obEQL2+EqAl34M0TCmJnAgu
 Ejnd6RtWOocWKAXSzgnpmoFEzbRXIibqcgyfxmtu/P5a08OrbE75ktzd8tMXpfqGfo1k
 nN2XRSOsCPO1Cmb4435eQJnnm1LytYcYiKjVr+EvI2s835E85xSBFIQ8Kp0mWqk+tY9X
 D+9iSGV+xL0N7tLL7puB2QpNgDlUtoBTur+aJqa5c4XJsth06R0I86N3Aw6suHrawmmt
 NxlkN4XWBMinJgB0TzTXPS1DWlL7gIqSjhVoTgsWF4hQqmPrEPgb3ZtR1P1mbOXUzX4V
 MQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744364592; x=1744969392;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GBLSNE5ChOXBFKb9IO560JhDcP0DDDzgBYOptmfsXR4=;
 b=d+yhmIrUR42Ve//4naW3mn6F/cVLcGSPSlkjZLD46tG4Le9YRctvqoZXYJkTwgKPTU
 fLZX4rQgiqGKFd/dOV4Y9Qx7fs6vsWRIdF7FeKcbrw8bTlCezMFGQAvZZRsCa8KnfIwW
 O+/a8JlTXSV0rq5iQ348SgTDcMD/PoYi10YWwOPjvvbS+hjJCyuQy9DEoQdejIWUtrud
 ocrWbxHJL5+FmENOO7vNmcaQFZ01D4chkFmlY1MBrZ+r3GCCP4z0Pn9vl4WtpmxrMeUE
 eaEXO3n+MHCtcghKN9Th6KS/drYGp2fvtWhCqtZkirktZu+SXjchPh+dq9WfagaF88FG
 qw7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGizt5Z6lv17SmipZelOu2M8Bi5yI1aio6+lyBVsYNHPyL+VuTPpRxOwnekyXv1fHcSxPIsZQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzTgnvSJvWJsRHAKJwOZ6jSeGxZMWfe0thMy7Q7mEBmYfV7GIg/
 Z3ue4LDkWyqhT7y6jljzbFA47RnFjFmurwwMFT4ilfiV9ocnJPC7WS+cgeLOUN2zqwvriMJhMaD
 plmzMPm4IV6pKprEWRoHPf9F7GN2ZHUeRZgzgpw==
X-Gm-Gg: ASbGnctvwgcduVdIAtuIoRag5hF1uRjANAwoZS/qYONd9Jr4m6wjmR4e/lEVtMFxPEm
 n+Mgssa2v/uT1AbSFnJ40EibTSCn+bQBXVN/lnk1/g46KwYUFYrzq09tvKVE6J7qm7Oh+uEuoZf
 uhu/9am7AYj4gRPXDBkj7BBiQ=
X-Google-Smtp-Source: AGHT+IHxsATq1nDvx0tESU8FI7Z9tOwK8mI93d2lo0Ql4OOD1G4oz0JfWrGnIn9eIFvI5EMYXS6uxaNsYhI5QN/XvkI=
X-Received: by 2002:a05:651c:19ac:b0:30b:d4a9:947c with SMTP id
 38308e7fff4ca-31049a25de3mr5594291fa.24.1744364592524; Fri, 11 Apr 2025
 02:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250328125819.1080935-1-ilias.apalodimas@linaro.org>
 <8ae5f2ce-06dd-45d6-9eca-dbae5c32d951@gmx.de>
In-Reply-To: <8ae5f2ce-06dd-45d6-9eca-dbae5c32d951@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 11 Apr 2025 12:42:29 +0300
X-Gm-Features: ATxdqUFuD4TqfOi3l-3Vq4E9gnJeth1VVy42sC6pPm8t9BxgLYhkq7ElTcJjaIE
Message-ID: <CAC_iWjLQ5EX=qxv-r=9oC+8ZquCpsvAv6+9b5SonVnEUkpiaog@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: Print extra information from the bootmgr
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de
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

On Fri, 11 Apr 2025 at 10:08, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 3/28/25 13:58, Ilias Apalodimas wrote:
> > Instead of just printing the label, add information for the Device
> > path as well so it's easier to see if we are booting from disk, network
> > etc
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >   lib/efi_loader/efi_bootmgr.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> > index f9534ef85edb..6b9d809ff618 100644
> > --- a/lib/efi_loader/efi_bootmgr.c
> > +++ b/lib/efi_loader/efi_bootmgr.c
> > @@ -690,7 +690,7 @@ static efi_status_t try_load_entry(u16 n, efi_handle_t *handle,
> >                       goto error;
> >       }
> >
> > -     log_info("Booting: %ls\n", lo.label);
> > +     log_info("Booting: Label: %ls Device path: %pD\n", lo.label, lo.file_path);
>
> I think we can remove "Label:" and but "Device path:" on a new line.
>
> The output is truncated according to CONFIG_SYS_PBSIZE=276:
>
> Booting: Label: nvme 0 Device path:
> /VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,6d00000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,5500000002000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,550000000300
>
> In this case the filename is not shown at all.
>
> efi_dp_shorten() might help to provide a printable output.
>
> But I don't believe that a non-developer would have a benefit from an
> output like:
>
> HD(2,GPT,54e58a03-c1db-4c6b-afda-24340c39cda5,0x109000,0x32000)\EFI\ubuntu\bootriscv64.efi)
>
> I would not know the GUIDs for my partitions by heart.
>
> Isn't log_debug() more adequate here?

I dont have a strong opinion tbh. I was mostly driver by looking into
EDK2 which prints something along the lines of
URI: http://<URL>/image.img

I can either switch to log_debug or print a human readable form I guess.

Thanks
/Ilias
>
> Best regards
>
> Heinrich
>
> >
> >       /* Ignore the optional data in auto-generated boot options */
> >       if (size >= sizeof(efi_guid_t) &&
>
