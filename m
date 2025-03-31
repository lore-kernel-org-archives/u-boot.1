Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF02C3600C
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 10:27:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0DB48144A;
	Mon, 31 Mar 2025 12:27:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A1uWM4OB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 146B781703; Mon, 31 Mar 2025 12:27:17 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0587580050
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 12:27:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3912d2c89ecso3808606f8f.2
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 03:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743416834; x=1744021634; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RBQHHFJUww6JtjJ72u3Zk7FSG9dZRYyk+Q9zX3H0I3M=;
 b=A1uWM4OBIxsaoo0rgS4f6uoZyFYFwCB3xmMTpE701G0I+RvhBhPnNx0vomMjNbdRsF
 zScU6Sd6JpVnmxi5vHFMifQ5CZ4irdQvFVCM1v5UjMhtlURH5rsp5usMjlwmvowGkr5N
 6ZEIMMiXUtMM7rN41W532sqmjtjBzy+GOinOiK4oddlOcXrTv2mJvSQVTzShQvZRWFZ0
 LtCsAKMyzfgc5zZUElR8wqcTxxvv7eNhm4jB/dOFnlsdezUS7BJEGD9HEHYvyDzqhXeA
 PVsa0KxZKrHEQSIcmsTc9CKjuij2ZYyJY22RwJg+w8W/N47sHibRp6IYvpznO/Qj1rig
 Hahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743416834; x=1744021634;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RBQHHFJUww6JtjJ72u3Zk7FSG9dZRYyk+Q9zX3H0I3M=;
 b=O8pwhdZpcZc+JIavbB04ea6wYXEcaojEYmuwl5eWT++kyRDedAKjp12giXkvWX34cu
 W0jBjodQmm9u0jrOkXhJI74iPUPFo4FhGTNxiTRhoY9HAiYl+NkltCZNHgMQyE7GljDU
 Rd9ukkJvRKaU5SjxBQauC9JOwTp8fCKKUO929CaOC+TBpoxY8KkvjudgyRbrkagM3OZk
 nO11WFfpLClaNChXdAPGv//sW0YsgCcRay1YCY+xNDNwJAXqNLRAICN7ak4fa4O7qh6e
 KNjr1RC/UCDblVxqV+y4JJ20G5DcFXpQSWG87odngGaoDBm/wduxL5F9PQBPF20NdDV5
 hxNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSBiLB7Vc53VGMRAzjG8Sugw4Jn85ifBp3KUymwq6mJxp4lADHUpmfExvgZzySI5kzU04h9Sk=@lists.denx.de
X-Gm-Message-State: AOJu0Yz0MgNbYhOw3YG5FFQI6XhwtzhzZHB0vgFxsYWX0naR7jzaBZl9
 z2fy2uGvY09lY6GQnU9kU7sAAeaUlSVL/pnyRjVi8S1yeDOxPcErP0VeD36Q/R0N2WrxBubnRQn
 +Qf+RZP2gMO/Zpgdf++TeaVlKUL4=
X-Gm-Gg: ASbGnctPAv35kVmHaXsd9VOeYxH2+cjm0OypfoBRZr3efB/5cDCZsazMxTi56fBN+Lt
 xvJK49/pJBX5dhm/bjHin9cyqqSNs91vh0V+ug/4a7rgt18fFZiyqs/A4m2jMTu6Yz4sMrH8SVB
 qE/W1EVZD5tqqyqgUAtxx+2tNEDew=
X-Google-Smtp-Source: AGHT+IE63W/9iJEkeCiEe0JjJNtX8U+czgNEK21W3MBHwemu0/wf9S3+dHVHnQUDScxV13/yKHUzX/DUuOiqNUnk9Gg=
X-Received: by 2002:a5d:59a6:0:b0:391:456b:6ab7 with SMTP id
 ffacd0b85a97d-39c12117d55mr6253749f8f.34.1743416834233; Mon, 31 Mar 2025
 03:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250330092815.10350-1-clamor95@gmail.com>
 <20250330092815.10350-2-clamor95@gmail.com>
 <aac2609c-c079-44a9-92ba-8517af78350e@cherry.de>
In-Reply-To: <aac2609c-c079-44a9-92ba-8517af78350e@cherry.de>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 31 Mar 2025 13:27:03 +0300
X-Gm-Features: AQ5f1JoRWxInOLSIC7x0MVsW1kNQb7vP2wXz2bad1_lI_4-7NCy4DNaKhWICUFI
Message-ID: <CAPVz0n0jo6MjYi7Bvj2RFxCJHdemrbUUbjzJfPXcKqfD6nCQgA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] sysreset: add PHASE_ to GPIO reset and poweroff
 configs
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Kongyang Liu <seashell11234455@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Robert Marko <robert.marko@sartura.hr>, u-boot@lists.denx.de
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

=D0=BF=D0=BD, 31 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 13:16 Quen=
tin Schulz <quentin.schulz@cherry.de> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> On 3/30/25 11:28 AM, Svyatoslav Ryhel wrote:
> > GPIO reset and power-off functionality depends on device tree data, whi=
ch
> > is often absent in SPL or TPL. To address this, incorporate PHASE_ into=
 the
> > config option.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >   drivers/sysreset/Makefile | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
> > index 796fc9effa5..ded91a4d325 100644
> > --- a/drivers/sysreset/Makefile
> > +++ b/drivers/sysreset/Makefile
> > @@ -8,8 +8,8 @@ obj-$(CONFIG_ARCH_ROCKCHIP) +=3D sysreset_rockchip.o
> >   obj-$(CONFIG_ARCH_STI) +=3D sysreset_sti.o
> >   obj-$(CONFIG_SANDBOX) +=3D sysreset_sandbox.o
> >   obj-$(CONFIG_SYSRESET_CV1800B) +=3D sysreset_cv1800b.o
> > -obj-$(CONFIG_POWEROFF_GPIO) +=3D poweroff_gpio.o
> > -obj-$(CONFIG_SYSRESET_GPIO) +=3D sysreset_gpio.o
> > +obj-$(CONFIG_$(PHASE_)POWEROFF_GPIO) +=3D poweroff_gpio.o
> > +obj-$(CONFIG_$(PHASE_)SYSRESET_GPIO) +=3D sysreset_gpio.o
>
> Are you sure this is safe for all boards?
>
> Essentially, right now POWEROFF_GPIO/SYSRESET_GPIO would be built for
> devices with TPL/SPL_SYSRESET symbol enabled, but with this change it
> would be disabled, possibly breaking their setup.
>
> I'm not against this change, it's just that there may be additional
> changes made to defconfigs to transition to this new symbol...
>
> ... which you haven't added here. I don't know what's the policy, but I
> think it makes sense to add the VPL/TPL/SPL symbols here so that people

You mean config SPL_POWEROFF_GPIO and SPL_SYSRESET_GPIO? It seems a
good idea, I wonder if there is a simpler way to add this without
adding Kconfig entry for every boot stage. Maybe you know such
example?

> can simply enable the symbols whenever they need it enabled in the phase
> instead of needing to send another patch before doing that.
>
> Cheers,
> Quentin
