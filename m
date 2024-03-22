Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7577C47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 07:13:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A60187D9C;
	Fri, 22 Mar 2024 08:13:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="IMwmBVLw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E12808816D; Fri, 22 Mar 2024 08:13:37 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56A3887D08
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 08:13:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-dc74435c428so1780929276.2
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 00:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1711091614; x=1711696414;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CQLg1hHCJgE51MVpbR8H3xo6x6btlliJjzZZkbywji8=;
 b=IMwmBVLw/+WaWH4+vurHMq/2rJKTq/of1V0GrjERYvuxh9SLwMG+1l64EXk3M8pJWJ
 shKeWw4PUcjzR1W4W9RuEUExaplsYDZGqJ3OouvJ4xb+JaiXsiK/WxaydHALMzXZMPF/
 rUDX2ES2ngafZ9qI0aAMReXWis0cD8jHKsE9br98IwKSwDhrtWYcj5C6/ft/vjI4OxkL
 9OsC3YYIc/eYlgQlgumuPcVRJYqwO/4tQhKdnYllu/t/zZ66cclkbtYA44j1Syo9FbRq
 9zVz42pjpHZze/VTh19uompMPzKh7tJHvG0g5n4IKP5jaFTEYju4hqyUoH6wwNE+eFbA
 XqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711091614; x=1711696414;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CQLg1hHCJgE51MVpbR8H3xo6x6btlliJjzZZkbywji8=;
 b=eJnfxHh3kIyp+dD0bAbmuM4iddmLeqYOuWP4khdUpyu89/BOkgmO+t3TewqWoKsLqH
 5ZjUmujySlFdbqA13Lz0tm5Zr3K+e2WVbK9jG/7DsGwG12w2MUYX57ow6jz7WAP6CAwi
 RnZnB5kpauoqrIczflPy0GWcLqddgaOfvAmWamuogYbsalIQkh33KmMfQnFSIPC/BPNz
 btwL/+KDTA1jDh8AA5/9btrcxOBxkU/RxbeiCqy1lWbRgFef1qBsZTktS9xStlrcHVDq
 lCdPJ7rFd60Z/5izACvwgmPa6zs/3ZnMnSF6+9C2sqf+lFqIpJtGCeaTued0psbVZ6SM
 GcWA==
X-Gm-Message-State: AOJu0YxIrpf5UV3Ru20FvdQF4CORxhoYv5MwjdwcuOu/4cKE0B/oWrzC
 j97NQrhoO0IJdJSrC/T/rg3vKwMuW6Y7KpydiB6StfCAu91J9gq390VRNl2/mLmJXNueqC/PBoy
 VlPoNxSmTLeaHqUtw7OIxyVPtrg1XQvVCo2KT
X-Google-Smtp-Source: AGHT+IH/LKzCTKLfxxH+hPVQtkcVu9Yr9FmC9OfLLFQ7P/RNKmCPUT4dm/7LXrjIZltW4zNlyLxQvEYDpoF4V7uZUdY=
X-Received: by 2002:a25:aa26:0:b0:dcd:5e5d:4584 with SMTP id
 s35-20020a25aa26000000b00dcd5e5d4584mr1376465ybi.34.1711091614064; Fri, 22
 Mar 2024 00:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240319165131.1651802-1-trini@konsulko.com>
In-Reply-To: <20240319165131.1651802-1-trini@konsulko.com>
From: Michal Simek <monstr@monstr.eu>
Date: Fri, 22 Mar 2024 08:13:22 +0100
Message-ID: <CAHTX3dKSZ4zwVQhzfNdtWbVbWD4giMizb+_dVF=m4TbWQumFTg@mail.gmail.com>
Subject: Re: [PATCH] scripts/Makefile.spl: Use 'sort' in SHRUNK_ARCH_DTB rule
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

=C3=BAt 19. 3. 2024 v 17:51 odes=C3=ADlatel Tom Rini <trini@konsulko.com> n=
apsal:

> With configs such as "am64x_evm_a53" or "imx8mp_venice" which list
> multiple device trees to build we get a warning such as:
> scripts/Makefile.spl:578: target 'spl/dts/freescale/' given more than onc=
e
> in the same rule
>
> If we sort this list first the warning goes away.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  scripts/Makefile.spl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.spl b/scripts/Makefile.spl
> index d074ba235006..60db38d5bddd 100644
> --- a/scripts/Makefile.spl
> +++ b/scripts/Makefile.spl
> @@ -575,7 +575,7 @@ endif
>
>  SPL_OF_LIST_TARGETS =3D $(patsubst %,dts/%.dtb,$(subst
> ",,$(CONFIG_SPL_OF_LIST)))
>  SHRUNK_ARCH_DTB =3D $(addprefix $(obj)/,$(SPL_OF_LIST_TARGETS))
> -$(dir $(SHRUNK_ARCH_DTB)):
> +$(sort $(dir $(SHRUNK_ARCH_DTB))):
>         $(shell [ -d $@ ] || mkdir -p $@)
>
>  .SECONDEXPANSION:
> --
> 2.34.1
>
>
The same issue also for zynqmp.
Tested-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
