Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3F5C3ABAC
	for <u-boot@archiver.kernel.org>; Sat,  3 May 2025 02:10:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E5428210D;
	Sat,  3 May 2025 04:10:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fMKspblg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 997F58210D; Sat,  3 May 2025 04:10:29 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 975B18210D
 for <u-boot@lists.denx.de>; Sat,  3 May 2025 04:10:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5f6222c6c4cso3853729a12.1
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 19:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746238227; x=1746843027; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cXcAx0A2ih8hra5kJTQcS6R80NJ+EGzil0lySLoBm4g=;
 b=fMKspblgIoS+hkYdvyqdMoM1zG/PtZBVyG2tg1Ic6S1UxeAO7Uh6wnJ0n/TYLTjd4A
 jA9vJ76nwUlXeH69y7a26GAaSqF8eYQMtfOIsAor1TR3qlyahRXsN5iTpY1LycNSHpom
 65e5+zM7Uegr4m4CsFf/mOr+/exIJujQ3vfw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746238227; x=1746843027;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cXcAx0A2ih8hra5kJTQcS6R80NJ+EGzil0lySLoBm4g=;
 b=eDpCByIEEfPjNlBHusNqPvP7zeffyoCY1VBUsdCAHVySDqd6WAviis+7sIK42OmtRh
 ui+Tquca8qmIQMC4qLa4dIRla1GiJtDXrO8/19oYKicHZ74PeJX25vLiKPHS37SQiUPN
 18HkOSj9vZD5NYi16UZZM7vo2/58rcI0HwSypLQtRGYE4V0pNiaGnGpkj+Vwzh5W3VLJ
 8Ku/26/t+mpUR17OfoSKrzGAV/JQHGqw+IJ9k6HyS/BR7By3r+Wha5cXigi10exnIiMv
 VuzgTbKJiT60sUt4hGQRN+daGoeF+wuIr5zLHbmJeFoDnKoCxeQ6MVMy1kFk8TKsAXOb
 evZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOYHKk8kWhQDH6DWbMyye6UV0QlGLn6cbqhQ3jk9OBkbSa0IdEe2uO9LUd76ynP+UFrbc4RGE=@lists.denx.de
X-Gm-Message-State: AOJu0Yy7T9PdzYgPCAXzg0wlLcrkmRcrXTDpYJWkoyg+ikmkcKDEN+82
 oAOydzAe48eoc8ASjugA4DJX05DOHNTKUnoSfGW7HYTdjnL0rjJTXl7MnNfVO0gbEfzpAfRiKGu
 A4KeycbopEAP3dV0CFAmys35GDW745cBQjIMd
X-Gm-Gg: ASbGncvr/UrNQtQNCHL9MJ6RVTEEoTsc2bn4eJoZIoACSqPN952yxFn83jd720cJ71t
 gFxSUfvWrhPMjKojJLotQbp7ZT8uOeElSm0JK+7YuhpQeA/e1Mr5Q7FiBFfFD/qoGKP857qgjU3
 K82TKSUtYwRk639HD4pYrXl24=
X-Google-Smtp-Source: AGHT+IFEAT7JtO1Hnp0YxAmSKJHUXzkzPFOlLbz6rBaGYhjLKWGmbqYTo/5XuptyjljaBxE/1ufLPpgPJGbmfJgtyBw=
X-Received: by 2002:a05:6402:50d4:b0:5dc:c9ce:b01b with SMTP id
 4fb4d7f45d1cf-5fa78008ac0mr3938036a12.8.1746238227083; Fri, 02 May 2025
 19:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
 <20250421162555.1200687-2-heinrich.schuchardt@canonical.com>
 <CAFLszTiVuNqAzQ=hi5_Uq6Jo2EUJkDtE6_gDaU=LY8hAXiL8ww@mail.gmail.com>
 <279d1706-d140-409e-a74a-4f1d9eaef311@canonical.com>
In-Reply-To: <279d1706-d140-409e-a74a-4f1d9eaef311@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 2 May 2025 20:10:13 -0600
X-Gm-Features: ATxdqUF617n7ut7klD2aqx2iC8-7PHvq3p5cCD0ML9i_Ow1hv6dsqchF63MnXAs
Message-ID: <CAFLszTg1Z7PArfxUUiyoNDsBj1N7Q23dn_xwhAJQ3pGikR0hzw@mail.gmail.com>
Subject: Re: [RFC 1/8] boot: EFI boot manager does not depend on BootOrder
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
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

On Fri, 2 May 2025 at 10:09, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 5/2/25 16:49, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Mon, 21 Apr 2025 at 10:26, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> The EFI boot manager bootmeth does not require variable BootOrder to be
> >> preexisting. It creates this variable.
> >>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> ---
> >>   boot/bootmeth_efi_mgr.c | 21 +++------------------
> >>   1 file changed, 3 insertions(+), 18 deletions(-)
> >>
> >> diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
> >> index 42b8863815e..1669cbed5bd 100644
> >> --- a/boot/bootmeth_efi_mgr.c
> >> +++ b/boot/bootmeth_efi_mgr.c
> >> @@ -47,30 +47,15 @@ static int efi_mgr_check(struct udevice *dev, struct bootflow_iter *iter)
> >>
> >>   static int efi_mgr_read_bootflow(struct udevice *dev, struct bootflow *bflow)
> >>   {
> >> -       struct efi_mgr_priv *priv = dev_get_priv(dev);
> >> -       efi_status_t ret;
> >> -       efi_uintn_t size;
> >> -       u16 *bootorder;
> >> -
> >> -       if (priv->fake_dev) {
> >> -               bflow->state = BOOTFLOWST_READY;
> >> -               return 0;
> >> -       }
> >> +       int ret
> >>
> >>          ret = efi_init_obj_list();
> >>          if (ret)
> >>                  return log_msg_ret("init", ret);
> >>
> >> -       /* Enable this method if the "BootOrder" UEFI exists. */
> >> -       bootorder = efi_get_var(u"BootOrder", &efi_global_variable_guid,
> >> -                               &size);
> >> -       if (bootorder) {
> >> -               free(bootorder);
> >> -               bflow->state = BOOTFLOWST_READY;
> >> -               return 0;
> >> -       }
> >> +       bflow->state = BOOTFLOWST_READY;
> >>
> >> -       return -EINVAL;
> >> +       return 0;
> >>   }
> >>
> >>   static int efi_mgr_read_file(struct udevice *dev, struct bootflow *bflow,
> >> --
> >> 2.48.1
> >>
> >
> > How do we know if the board is using EFI bootmgr? My understanding was
> > that this was a way to find out?
>
> The boot manager must always run.

Are you sure that is true? It seems false to me, e.g.

- if we are booting FEL on suxi, it must not run.
- none of the boards in my lab use it
- the Ubuntu 24.04 test in my lab doesn't use it

So how can we say that it must always run?

>
> The check for the BootOrder variable introduced in commit f2bfa0cb1794
> is a bug.
>
> The boot manager handles in sequence:
>
> * Try to boot as indicated by BootNext.
> * Try to boot as indicated by BootOrder.
> * Try to boot default path for available media.
>    This will add Boot#### entries and update BootOrder.

Regards,
Simon
