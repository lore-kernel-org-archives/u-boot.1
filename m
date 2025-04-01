Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75EE9C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 17:57:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 064D681703;
	Tue,  1 Apr 2025 19:57:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KPYSUmWy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B2AB80194; Tue,  1 Apr 2025 19:57:31 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAB6781F59
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 19:57:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ac29fd22163so977314966b.3
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 10:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743530248; x=1744135048; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=63yFxUWPRuGoJrLPdZ+BGpftDaFJmGvKxjKkfh6Jp8E=;
 b=KPYSUmWywvZvbIIDx5UMqfwrX/6QT1ZfJfZ0oXHuqAI4zd+4WgvpPpNlF+Zec1R65G
 TUDpJDFn5H7SlVKve89vUwEuMoVm75ea0ecS3r925TI/rOg091fHvTufZnpPlKsvZRxw
 S+3nxZFfOXinjESjrE+ggsZDnfMvkfPZ70D+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743530248; x=1744135048;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=63yFxUWPRuGoJrLPdZ+BGpftDaFJmGvKxjKkfh6Jp8E=;
 b=IzeKYJ+MWYX04le49ZZfPrgyGtjQIFKA/8U2JlRkFkRxzw8KFg80OOUMSRSsPn8OoN
 XkeV5ls4UjAg0gGT7FnWqEKy31vhU/9q4pyB8j+nyMoSR7kBpwSHoxMtgliiCPQSyPkT
 rUT6giHj3UVhaOl4FPVJctKnZ8vcJtiYr8EdncIA8UAj8SE4J9mn6VQXp1Q+5qy+Oryd
 g5DuND9HO9fyaKgBv1ea63on7Ui2uDqh8/S5KBquDy2DvtOTUqnKyFHdIKUVBgP6Zns4
 Oegxo1nyu14bW6gx1fAPdJWitpxisoqV9Mtpa3ksElb8NgXU2qabtioUg8ARYsV2zoXQ
 uX/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtK1PJuhYBb3HYWP35elQwJRJzSpmAnOuFBPRDkpVZIQR8U1sG45X4ptB67XfdoliBPWhVT0U=@lists.denx.de
X-Gm-Message-State: AOJu0Yy6Rn+dP84siXPfrxM17HlwtPSS0J+bZUuIBt3WgQjEXH4LbOAa
 Zl+fp35ew2QWCaJTT493FJsLebEBzkQKbjaUbBWdUP36+f1YpfujeBUOjbD0VbUjVDR8viaMS3L
 q0NeD4NNgIDYhSnbJ75klRR8djmJpQsJ74hIr
X-Gm-Gg: ASbGncsTxllGZ+/tbxWQyAMaHcW/h4ISLuRtkdpq2OowfBGdwK3MN/9UaLqZnMuC2g8
 rmeZhYVFLKS9Y0lR3fkDrJUk6+Yj9GaCxZHT3XO0/PFaVacU7oqUmHYEkG/mT4SbysGbaEcJfBu
 51kcmwUanEZ+yHakC7jQk6tyueoFaT
X-Google-Smtp-Source: AGHT+IHSFAtGrnDB7L6BwEtUw9zVCEwX9/8DuZfjZe8ZO0/+E3Tmq8XutmW+F3lSx1UiiUjT3b1GU5WuNUmeigLJ4X4=
X-Received: by 2002:a17:907:6095:b0:ac2:a50a:51ad with SMTP id
 a640c23a62f3a-ac738a3fb66mr1462052366b.14.1743530247777; Tue, 01 Apr 2025
 10:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250401083830.2320479-1-heiko@sntech.de>
 <CAFLszTihxUb8+fsFPztzx0cShG96uXb32pAQ3hyEEFE0Z+JzeA@mail.gmail.com>
 <74ce355b-4e2b-4d5d-b6fc-2ad421be7f3d@gmx.de>
In-Reply-To: <74ce355b-4e2b-4d5d-b6fc-2ad421be7f3d@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 2 Apr 2025 06:57:15 +1300
X-Gm-Features: AQ5f1Jp0dH5vdChsvH2iLHQ2E35hKozf9SxMlCLCMAMLPDEhBEzTpSyR25BmAPQ
Message-ID: <CAFLszTgrx-UrZHN7DO5HrbMxTcQOxxY=s2SvhLKogLYZ6QhKNg@mail.gmail.com>
Subject: Re: [PATCH] Revert "net: eth_bootdev_hunt() should not run DHCP"
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Heiko Stuebner <heiko@sntech.de>, trini@konsulko.com,
 joe.hershberger@ni.com, 
 rfried.dev@gmail.com, u-boot@lists.denx.de, quentin.schulz@cherry.de
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

Hi,

On Wed, 2 Apr 2025 at 05:13, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 01.04.25 17:51, Simon Glass wrote:
> > On Tue, 1 Apr 2025 at 21:38, Heiko Stuebner <heiko@sntech.de> wrote:
> >>
> >> This reverts commit 1f68057e03206e6597ca8b2be8bb1c49d4bd47d0.
> >>
> >> Commit 1f68057e0320 ("net: eth_bootdev_hunt() should not run DHCP")
> >> aims to reduce EFI boot times by disabling the dhcp_run when
> >> checking ethernet bootdevices, by preventing it from running double,
> >> with the reasoning
> >>
> >>      We need to call eth_bootdev_hunt() when setting up the EFI sub-system to
> >>      supply the simple network protocol. We don't need an IP address set up.
> >>
> >> That might by true for EFI, but not for everything else, because when
> >> running distro-boot and for example the PXE method in it, nothing will
> >> set up an IP address now.
>
> The removed call was dhcp_run(addr, NULL, true);
>
> We have:
>
> distro_efi_read_bootflow_net():
> boot/bootmeth_efi.c:205:        ret = dhcp_run(addr, NULL, true);
>
> script_read_bootflow_net():
> boot/bootmeth_script.c:132:     ret = dhcp_run(addr, fname, true);
>
> extlinux_pxe_read_bootflow() seems to be lacking the call.
>
> So instead of reverting
> 1f68057e0320 ("net: eth_bootdev_hunt() should not run DHCP")
> we should add the missing call in extlinux_pxe_read_bootflow().
>

The original design was to run DHCP once, in the hunter. That seems to
have changed, due to it causing problems with EFI?

I'd like to go back to doing it in the hunter. It really doesn't make
sense for each bootmeth to do its own DHCP again, does it?

Regards,
Simon
