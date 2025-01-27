Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FFB8C02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 12:39:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96093807E4;
	Mon, 27 Jan 2025 13:39:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="vqvQNFK9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C056D80F98; Mon, 27 Jan 2025 13:39:37 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00CF88076E
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 13:39:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adriano.cordova@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5D6AA3F171
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 12:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1737981574;
 bh=Bd8wrjobY8LEMZ1eRcA3JnVjtWJS2d2XwGaKJTSWk3I=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=vqvQNFK9Tsw8AhPzw+mFXmPY8aFc9iNLRaQre0zCCfMIq2aVPL59+qUlIzNbqsH2P
 PaSBjwnliBxREvNPlFK4RHVEWt4mxFnbdr1Cjb0PyUt6QcxoGmmxCxRxRtg0/v/huH
 TidX29pfuDNzS97bm7qQF4s7zunRtpewKm06s/UGWVwqyJuv4eQ2WlpafqnJSqosZd
 xy7wa+DX3wsCa0dFyLL0UwNkRp541yMITErgsb8QtNSfa+aWfy697vQy2NEZOeQO5B
 C4qQOw2F3Gy3OnEMzta72qOYgZCncoM56QtWXXTgWGVBI+Dr/WuZuHBxKcLoiTym1K
 yydzuqA+YgnXw==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-386333ea577so1582131f8f.1
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 04:39:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737981574; x=1738586374;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bd8wrjobY8LEMZ1eRcA3JnVjtWJS2d2XwGaKJTSWk3I=;
 b=OD+XYaqBGWqhRGYAsTK10ARagBiBq4VzEStdwo1KmtIOUhENURfUiao3TCGRofE0H6
 ccUTRZDsIsFGANeGd1ppqw5QGr0v1qunF3vM3tMUP3+kb15FVNMwQZZ2mzYPWS90uHcz
 Yl0rUvq9a0rQKHrzmlC9SMZ+tnFb5J3E70Y+oJBbcdzdHzPE3/iACWOuEdwDOVBLgxEP
 KMenjXHDazusP5wUQdVm/5cI9jk9/TIvLGEJ7fNSSLn0aIlGFs3TkqRQoWYRs3Mdngg7
 nJ7dHQjux9eCKUhZ8AZ54GsNtl6OSrt5EG0XyQ+2YDvpWxsUMEc+v6/gQRMau8QBz5JF
 WHlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3f5ilfOxDyXSvGUf/viB3F2jLfoAPl1E3qqhrXQDPikfk/iLvZBmpoyys1Q7TDZt8W5q4ePY=@lists.denx.de
X-Gm-Message-State: AOJu0YxOqWEGw0UEfubUe+iT1VJbPpR/3P/Xlns/GjvqIzxEVyWK3tDb
 sOo8QdA9NL8WFFtAxoGiaPcHpI4qhIhpO0+lblQd5stH+ef2qhDhCTR1krdR3w4qod/HZHVBYIw
 JmhcKRkdQ4JsYKPpE0HEUODZ8/RhJqLlRHrQmG9kcwt9aYXnE48EsljdPxh8IGdd4SuHMYSqY+O
 GfluJYdM8dtJVOGmJ9048zxg/P5WTZTL60Zn6ebtHDpA==
X-Gm-Gg: ASbGncuZeWT9XLBxo0fiJSI8DeN7kP02wawOGBh4HJl92sqCCgaMEqQkbea9yvzF0OF
 JenoO7iTJrGH5QOfJ9BaYC7lAGulnWVMbg6WxIUNaKB2m7AYkW38jM0rHFPAj
X-Received: by 2002:a5d:5f88:0:b0:385:f5c4:b30d with SMTP id
 ffacd0b85a97d-38bf59e1d99mr45760721f8f.39.1737981573824; 
 Mon, 27 Jan 2025 04:39:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/BZmcOHKXWqP/fPLy5C5J1CuM2qFnGkvYZw67b64qSxom1l85qugSaXhhAO4pS+jfTkPmtDJbAf+wwMKQVV8=
X-Received: by 2002:a5d:5f88:0:b0:385:f5c4:b30d with SMTP id
 ffacd0b85a97d-38bf59e1d99mr45760689f8f.39.1737981573446; Mon, 27 Jan 2025
 04:39:33 -0800 (PST)
MIME-Version: 1.0
References: <20241206171835.2403418-1-adriano.cordova@canonical.com>
 <20241206171835.2403418-3-adriano.cordova@canonical.com>
 <1839b1f7-b78c-450a-aa05-78858a4f2d45@gmx.de>
 <20250126155856.GS60249@bill-the-cat>
In-Reply-To: <20250126155856.GS60249@bill-the-cat>
From: Adriano Cordova Fedeli <adriano.cordova@canonical.com>
Date: Mon, 27 Jan 2025 09:39:21 -0300
X-Gm-Features: AWEUYZm94L0Q0-tomwHGneLZOHXBh1o2iJmhKUynEPHgpJXAzE26B0k75rNtHkE
Message-ID: <CAFQa3M+KEkk-fg9c5dO-wwfDHhu=fSSASpKOETrHzp+VYxXzMg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] efi_loader: efi_net: let efi_net_set_dp properly
 update the device path
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>, joe.hershberger@ni.com, 
 rfried.dev@gmail.com, jerome.forissier@linaro.org, 
 ilias.apalodimas@linaro.org, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Heinrich and Tom,

On Sun, 26 Jan 2025 at 12:59, Tom Rini <trini@konsulko.com> wrote:

> On Sat, Jan 04, 2025 at 12:05:24AM +0100, Heinrich Schuchardt wrote:
> > On 06.12.24 18:18, Adriano Cordova wrote:
> > > This commit fixes an use after free introduced in Commit e55a4acb54
> > > (" efi_loader: net: set EFI bootdevice device path to HTTP when loaded
> > > from wget"). The logic in efi_net_set_dp is reworked so that when the
> > > function is invoked it not only changes the value of the static
> variable
> > > net_dp (this is how the function was implemented in e55a4acb54) but
> also
> > > updates the protocol interface of the device path protocol in case efi
> > > has started.
> > >
> > > Fixes: e55a4acb54e8 ("efi_loader: net: set EFI bootdevice device path
> to HTTP when loaded from wget")
> > > Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> > > ---
> > > Changes in v2: use reinstall_protocol_interface() and new_net_dp in
> the body of efi_net_set_dp()
> > >
> > >   lib/efi_loader/efi_net.c | 61
> ++++++++++++++++++++++++++++++++++------
> > >   1 file changed, 52 insertions(+), 9 deletions(-)
> [snip]
> > > @@ -1055,18 +1058,58 @@ out_of_resources:
> > >    */
> > >   efi_status_t efi_net_set_dp(const char *dev, const char *server)
> > >   {
> > > -   efi_free_pool(net_dp);
> > > +   efi_status_t ret;
> > > +   struct efi_handler *phandler;
> > > +   struct efi_device_path *old_net_dp, *new_net_dp;
> > >
> > > -   net_dp = NULL;
> > > +   old_net_dp = net_dp;
> > > +   new_net_dp = NULL;
> > >     if (!strcmp(dev, "Net"))
> > > -           net_dp = efi_dp_from_eth();
> > > +           new_net_dp = efi_dp_from_eth();
> > >     else if (!strcmp(dev, "Http"))
> > > -           net_dp = efi_dp_from_http(server);
> > > +           new_net_dp = efi_dp_from_http(server);
> > >
> > > -   if (!net_dp)
> > > +   if (!new_net_dp) {
> > >             return EFI_OUT_OF_RESOURCES;
> > > +   }
> > > +
> > > +   // If netobj is not started yet, end here.
> > > +   if (!netobj) {
> > > +           goto exit;
> >
> > This leads to a build failure with clang as you have not initialized
> > variable ret.
> >
> > https://source.denx.de/u-boot/custodians/u-boot-efi/-/jobs/987832
> >
> > > +   }
> > > +
> > > +   phandler = NULL;
> > > +   efi_search_protocol(&netobj->header, &efi_guid_device_path,
> &phandler);
> > > +
> > > +   // If the device path protocol is not yet installed, install it
> > > +   if (!phandler)
> > > +           goto add;
> > > +
> > > +   // If it is already installed, try to update it
> > > +   ret = efi_reinstall_protocol_interface(&netobj->header,
> &efi_guid_device_path,
> > > +                                          old_net_dp, new_net_dp);
> > > +   if (ret != EFI_SUCCESS)
> > > +           goto error;
> > > +
> > > +   net_dp = new_net_dp;
> > > +   efi_free_pool(old_net_dp);
> > >
> > >     return EFI_SUCCESS;
> > > +add:
> > > +   ret = efi_add_protocol(&netobj->header, &efi_guid_device_path,
> > > +                          new_net_dp);
> > > +   if (ret != EFI_SUCCESS)
> > > +           goto error;
> > > +exit:
> > > +   net_dp = new_net_dp;
> >
> > Why should we set net_dp if there is no net_obj?


Because the net_dp can be set before EFI starts.

>
> Because prior to this patch we set net_dp = NULL at the start of the
> function and with this patch nothing is updating net_dp until much later
> in the function.
>
> > Instead of jumping to exit, we can jump to error: with
> >
> > ret = EFI_DEVICE_ERROR.
>
> I'm not entirely sure what you mean by that. But can you perhaps v3
> this? I still can't re-enable CONFIG_CMD_BOOTEFI_SELFTEST on any of my
> platforms due to this problem.


> --
> Tom
>

I sent a v3.
This piece of code will be replaced in the series implementing support for
multiple EFI network devices, sent
some days ago.

Thanks,
Adriano
