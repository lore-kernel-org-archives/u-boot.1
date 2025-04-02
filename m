Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B94CC36018
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 22:05:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD69B81E6C;
	Thu,  3 Apr 2025 00:05:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aWg/fK92";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DD1381F0B; Thu,  3 Apr 2025 00:05:17 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6687D8035B
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 00:05:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-abbb12bea54so61696066b.0
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 15:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743631515; x=1744236315; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KcKlPmucKC0JWHP8G30mUKRqJT0Ykn4KROLjiQxPgdQ=;
 b=aWg/fK92zFoeYqXZ1oEcsNT/H9gIWl6AFHmYNYY0TBj00yCO53FLU8lM/nOfLnRHdf
 NUhJouy18kGqnA3egZuC5PuX2PN4ghxCLN3/3fYXsDuu41A07gNKraG1GDDQd0tKrwAQ
 ptPU7He+YokSFftwLoEugxzyfKRunrSeKuNkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743631515; x=1744236315;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KcKlPmucKC0JWHP8G30mUKRqJT0Ykn4KROLjiQxPgdQ=;
 b=CyhZXG0ko/F6lEqCSAlyCRjE9UjYCH7E0HSsdbvNAh1n9Dr45A2pcuWjwRpgDEvwG1
 UeyZ5eH4dWsTQwXtpUR6UZqxgjzLf/YJk4BBjroe2cRb9F1cnIWFprfNSjH61cb94dW0
 dmGzppLvPGTeD/f4MZoLMcpHNMwMJdFWmK1bgBLPGB9oonmhvf0kwaiyMeIH0oChenaC
 57A5bUfbGhnPgboaT1ArIipq5lPaVNugITw/llmWhbh7Js8OwojPsNbQeypaDBI+oohb
 N+Yv6hSIiq3GiGWrdW38T4UaJXYbUpts/orwCo9hcAlC3gWqu1WQuuvs0iBoHGcwSQ4E
 +zQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1oh2KSzyp7+k6qeEy4J5wEpuje2h7I40WTfwJEY3JqnM9tHwG/1bQYReIs74M87m88TWENho=@lists.denx.de
X-Gm-Message-State: AOJu0Yz6PcoRbGkAo5gFPaljbdtlas/u0dj5BVeq/tj497WAtNfqaa/5
 tazvj/ApYvaq57DSXxR6Iak8t5jdi9MeKE2ZKk3uF85WqClDOjhVVZbPYrEEiukwa/QCbfVOGvH
 uK5q2DqN9/9e7KkRIxIPmY6fElgI16S2L7zaG
X-Gm-Gg: ASbGncsuvUPKPV/MClcn3ULjgrj3OI2G6D8JHwGMkScbNKYzDA1j8ju4hNR8zHMvKhD
 hYBqKugk6iSiiifzx58k6nZAlSZTQ6zoAzFmc2DmCIBcBgaDK7Pr8hFmQVjwIzb8nL91e+kMcVD
 jJeOc8kprqEsb8mhTHnYxhANWoP5On
X-Google-Smtp-Source: AGHT+IEBkjM7RbbXKFb6qSkwGLvtLJIOV2DFKiNaxtjRUZTQNwzLLvDt5cjTTcqZAcelyW5tzuAv1Srl8TEhYaDsR7Q=
X-Received: by 2002:a17:906:f587:b0:ac6:fe8c:e7bb with SMTP id
 a640c23a62f3a-ac7bc29bf07mr38204266b.55.1743631514445; Wed, 02 Apr 2025
 15:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250401083830.2320479-1-heiko@sntech.de>
 <CAFLszTihxUb8+fsFPztzx0cShG96uXb32pAQ3hyEEFE0Z+JzeA@mail.gmail.com>
 <74ce355b-4e2b-4d5d-b6fc-2ad421be7f3d@gmx.de> <1824254.VLH7GnMWUR@diego>
In-Reply-To: <1824254.VLH7GnMWUR@diego>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 3 Apr 2025 11:05:02 +1300
X-Gm-Features: AQ5f1JqXFJf8TTM4SAU9v23FCUMTq9FIKfwPHPA1JFTiqkwMlQ_AeG3NToYgQSs
Message-ID: <CAFLszTjLRnS1AqCHLY+HZ+bDG1H1oRKgSAPb+V_x7p+7RZroxA@mail.gmail.com>
Subject: Re: [PATCH] Revert "net: eth_bootdev_hunt() should not run DHCP"
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, trini@konsulko.com,
 joe.hershberger@ni.com, 
 rfried.dev@gmail.com, u-boot@lists.denx.de, quentin.schulz@cherry.de
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

Hi Heiko,

On Thu, 3 Apr 2025 at 10:36, Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Am Dienstag, 1. April 2025, 18:13:35 MESZ schrieb Heinrich Schuchardt:
> > On 01.04.25 17:51, Simon Glass wrote:
> > > On Tue, 1 Apr 2025 at 21:38, Heiko Stuebner <heiko@sntech.de> wrote:
> > >>
> > >> This reverts commit 1f68057e03206e6597ca8b2be8bb1c49d4bd47d0.
> > >>
> > >> Commit 1f68057e0320 ("net: eth_bootdev_hunt() should not run DHCP")
> > >> aims to reduce EFI boot times by disabling the dhcp_run when
> > >> checking ethernet bootdevices, by preventing it from running double,
> > >> with the reasoning
> > >>
> > >>      We need to call eth_bootdev_hunt() when setting up the EFI sub-=
system to
> > >>      supply the simple network protocol. We don't need an IP address=
 set up.
> > >>
> > >> That might by true for EFI, but not for everything else, because whe=
n
> > >> running distro-boot and for example the PXE method in it, nothing wi=
ll
> > >> set up an IP address now.
> >
> > The removed call was dhcp_run(addr, NULL, true);
> >
> > We have:
> >
> > distro_efi_read_bootflow_net():
> > boot/bootmeth_efi.c:205:        ret =3D dhcp_run(addr, NULL, true);
> >
> > script_read_bootflow_net():
> > boot/bootmeth_script.c:132:     ret =3D dhcp_run(addr, fname, true);
> >
> > extlinux_pxe_read_bootflow() seems to be lacking the call.
> >
> > So instead of reverting
> > 1f68057e0320 ("net: eth_bootdev_hunt() should not run DHCP")
> > we should add the missing call in extlinux_pxe_read_bootflow().
>
> doing
>
> ----- 8< -----
> diff --git a/boot/bootmeth_pxe.c b/boot/bootmeth_pxe.c
> index b91e61bcbc4..6e5e0f99ea4 100644
> --- a/boot/bootmeth_pxe.c
> +++ b/boot/bootmeth_pxe.c
> @@ -73,6 +73,10 @@ static int extlinux_pxe_read_bootflow(struct udevice *=
dev,
>                 return log_msg_ret("pxeb", -EPERM);
>         addr =3D simple_strtoul(addr_str, NULL, 16);
>
> +       ret =3D dhcp_run(addr, NULL, false);
> +       if (ret)
> +               return log_msg_ret("dhc", ret);
> +
>         log_debug("calling pxe_get()\n");
>         ret =3D pxe_get(addr, &bootdir, &size, false);
>         log_debug("pxe_get() returned %d\n", ret);
> ----- 8< -----
>
> does seem to work in _my_ usecase and gets me loading stuff over pxe
> again.
>
> I guess this whole thing now becomes a strategy decision ;-) :
>
> - it's very late in the release, do we revert to the known working state
>   or hope the above fixes all issues
> - Simon's wish of not sprinkling dhcp_run calls in multiple places
>
> I guess I'm fine with both way, as either fixes my use-case ;-)

For the reasons you patch seems fine to me. As you say, it is very
late in the cycle.

I already gave this feedback to Heinrich, so once the revert is in he
may have time to take a look.

Regards,
Simon
