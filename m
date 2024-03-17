Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE5EC54E60
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 11:27:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 320DF87D7C;
	Sun, 17 Mar 2024 12:27:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E75687D7C; Sun, 17 Mar 2024 12:27:01 +0100 (CET)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B742587E0D
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 12:26:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ngompa13@gmail.com
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-56829f41f81so4753273a12.2
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 04:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710674817; x=1711279617;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L28hVGQTYDARzxNixZqeHURJbVFOB8qR0xfLOKnTTLQ=;
 b=WzZckmgnHv1Lt9pSr9Db7+kv2tKG+jbpm0VtdTB5qt+sb5QUPibVmsFlyP87ylPGsF
 WXTAKVW775B8fIKGqbTliGOQ4xRQwBcSrXIwBwe4RUMSjkHYhxeTq3XDeJl+ULAYvfEZ
 vmZMrBkI9dHSU6M9DXVv/R/PA/IplwPz3CaaxVu1fqsK0ml49P86EqAoN+dVmUoeHWHR
 RHnwaEylBa/iApw5HUkjktu1S0x/MA3a4SBfCfW1D1Qj1eGJ0YevgV48VUn3TLwCEbir
 RSk/j//teiAjfCPQVlNaAkQpgdM8CkCoNHMVl/8PBt0JAtsNF6AJuo8cc56qSDGv+2BW
 MD0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXq3CPXqBQBI7XZeo3ZYpFhHBhQMYTIB2CtTs0Mis2UDy7CJjwnonpTVGYaSb0NN7Au/6/gR1JrC81Zeh5F7Jd06q9RAg==
X-Gm-Message-State: AOJu0YxYhf/Ir6WBgD3T5t4vngiKRfFx1seidoe5l2wlBSQKJtIGV74I
 oY5P2WORRQ+hDajM3gzzY9CB49zI853QIFoQoGGJMkTHiB+4dhuBV5Wvrt1Z87U=
X-Google-Smtp-Source: AGHT+IE8UzMSXoO3FowoUy/VsXIywGSCkPSpu+qdMbWDkC8U20sjU6Hnbo8NdRNgX/A1gJtfECH3HQ==
X-Received: by 2002:a05:6402:2b93:b0:568:b418:6999 with SMTP id
 fj19-20020a0564022b9300b00568b4186999mr3760060edb.16.1710674816727; 
 Sun, 17 Mar 2024 04:26:56 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com.
 [209.85.218.52]) by smtp.gmail.com with ESMTPSA id
 ev19-20020a056402541300b005689c2c6508sm3521379edb.70.2024.03.17.04.26.56
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 Mar 2024 04:26:56 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-a4644bde1d4so452231466b.3
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 04:26:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCXCeiPI7WCEdcXPjSATStvibNXJqUCgvRv3vGqkcUdEMUDjMbxOSQ2MuJ1RleWFhh9hCwKWS7muuXFr6ZX691SZobHcKg==
X-Received: by 2002:a17:906:338d:b0:a46:bc50:b087 with SMTP id
 v13-20020a170906338d00b00a46bc50b087mr308681eja.9.1710674816071; Sun, 17 Mar
 2024 04:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240317-asahi-keyboards-v2-0-d3f4b8384f68@jannau.net>
In-Reply-To: <20240317-asahi-keyboards-v2-0-d3f4b8384f68@jannau.net>
From: Neal Gompa <neal@gompa.dev>
Date: Sun, 17 Mar 2024 04:26:19 -0700
X-Gmail-Original-Message-ID: <CAEg-Je9KSs-Ve-p66U1p3K+gSzGa0hqLiXx3EoFYzb+0xBXJpw@mail.gmail.com>
Message-ID: <CAEg-Je9KSs-Ve-p66U1p3K+gSzGa0hqLiXx3EoFYzb+0xBXJpw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] USB keyboard improvements for asahi / desktop
 systems
To: j@jannau.net
Cc: Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>,
 u-boot@lists.denx.de, asahi@lists.linux.dev
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

On Sun, Mar 17, 2024 at 4:07=E2=80=AFAM Janne Grunau via B4 Relay
<devnull+j.jannau.net@kernel.org> wrote:
>
> Apple USB Keyboards from 2021 need quirks to be useable. The boot HID
> keyboard protocol is unfortunately not described in the first interface
> descriptor but the second. This needs several changes. The USB keyboard
> driver has to look at all (2) interface descriptors during probing.
> Since I didn't want to rebuild the USB driver probe code the Apple
> keyboards are bound to the keyboard driver via USB vendor and product
> IDs.
> To make the keyboards useable on Apple silicon devices the xhci driver
> needs to initializes rings for the endpoints of the first two interface
> descriptors. If this is causes concerns regarding regressions or memory
> use the USB_MAX_ACTIVE_INTERFACES define could be turned into a CONFIG
> option.
> Even after this changes the keyboards still do not probe successfully
> since they apparently do not behave HID standard compliant. They only
> generate reports on key events. This leads the final check whether the
> keyboard is operational to fail unless the user presses keys during the
> probe. Skip this check for known keyboards.
> Keychron seems to emulate Apple keyboards (some models even "re-use"
> Apple's USB vendor ID) so apply this quirk as well.
>
> Some devices like Yubikeys emulate a keyboard. since u-boot only binds a
> single keyboard block this kind of devices from the USB keyboard driver.
>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
> Changes in v2:
> - rewritten commit message for "[PATCH 2/6] usb: xhci: Set up endpoints f=
or the first 2 interfaces"
> - Replaced the usb keyboard Yubikey block with an env based USB device bl=
ocklist
> - Use "-EINVAL" as return value in "[PATCH 3/6] usb: xhci: Abort transfer=
s with unallocated rings"
> - added "Reviewed-by:" tags
> - Link to v1: https://lore.kernel.org/r/20240221-asahi-keyboards-v1-0-814=
b2e741790@jannau.net
>
> ---
> Janne Grunau (6):
>       usb: xhci: refactor xhci_set_configuration
>       usb: xhci: Set up endpoints for the first 2 interfaces
>       usb: xhci: Abort transfers with unallocated rings
>       usb: Add environment based device blocklist
>       usb: kbd: support Apple Magic Keyboards (2021)
>       usb: kbd: Add probe quirk for Apple and Keychron keyboards
>
>  common/usb.c                 |  56 +++++++++++++++++++
>  common/usb_kbd.c             |  61 +++++++++++++++++++--
>  doc/usage/environment.rst    |  12 +++++
>  drivers/usb/host/xhci-ring.c |   5 ++
>  drivers/usb/host/xhci.c      | 126 +++++++++++++++++++++++++++----------=
------
>  include/env_default.h        |  11 ++++
>  include/usb.h                |   6 +++
>  7 files changed, 227 insertions(+), 50 deletions(-)
> ---
> base-commit: 37345abb97ef0dd9c50a03b2a72617612dcae585
> change-id: 20240218-asahi-keyboards-f2ddaf0022b2
>

Series LGTM. Thanks for this! :)

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
