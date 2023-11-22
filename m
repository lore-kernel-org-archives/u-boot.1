Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFEEC072A2
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 05:31:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFD728749C;
	Wed, 22 Nov 2023 06:31:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jxUkwYdg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B02D5874C7; Wed, 22 Nov 2023 06:31:03 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E30E87156
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 06:31:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahiroy@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id ABA2661BD9
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 05:30:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57DA5C433C7
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 05:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1700631059;
 bh=LxgqrVsExp18X41sj9jZd0qVqv8p2H0pjBZVzDy55KE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=jxUkwYdg3kdZ5KXh4SvcysIoWYZYZJLWSjXFQj4xu5Kiu/SAIXuW5QvGasMaC3ME0
 w1nefyg+krajFl9lPlTJCVjVSIxuIMGt4hIHEUeqhtFJyG61lvzBAEPwXg/ep5Uf1w
 FVXJVrhUlyLRoTP9KoTiIUrnFO/F/pTkq/m1I5XplwuTwzQwWHe8XNgaEpJCqFyUnx
 WSLJToOep18aMJi4WVDUVgIeHuWLwGA1wO96rrpgyeFmmSCcfnYS4Zk9UKXoFFZQ7e
 e0nJrHa51p0go92sCMWIJG8YGfxvNiDzqSzaCdP2iA1AsdBu1EPnGYwQXgBcL8/Eu+
 j2rdQAvpKZllw==
Received: by mail-ot1-f42.google.com with SMTP id
 46e09a7af769-6d7e51638e7so788300a34.1
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 21:30:59 -0800 (PST)
X-Gm-Message-State: AOJu0YzPH+RX8P98X+ctB8MUdJSl1Nc7HbljJJY/QsbCeQc/TYpquNzH
 tlJN9DX+bgPU6uYTAu5IPzj9QjBia5cJrXKVcbY=
X-Google-Smtp-Source: AGHT+IHWrSTNFAHs6ffKq7KsequdWmSrsTRwhnDAtkAsnz08m90bcY6ZGzSd6zqLwWU4eDcbsP0u4twzBdviXy0n29Y=
X-Received: by 2002:a05:6870:3d86:b0:1f9:5ef5:44df with SMTP id
 lm6-20020a0568703d8600b001f95ef544dfmr1889861oab.14.1700631058773; Tue, 21
 Nov 2023 21:30:58 -0800 (PST)
MIME-Version: 1.0
References: <20231119150229.634424-1-sjg@chromium.org>
 <20231119150229.634424-2-sjg@chromium.org>
In-Reply-To: <20231119150229.634424-2-sjg@chromium.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 22 Nov 2023 14:30:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR-4LbTWQ+V4Kq1FOevxxw=wfJ1OxHpqLyc1d+e54qjMw@mail.gmail.com>
Message-ID: <CAK7LNAR-4LbTWQ+V4Kq1FOevxxw=wfJ1OxHpqLyc1d+e54qjMw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] kbuild: arm64: Add BOOT_TARGETS variable
To: Simon Glass <sjg@chromium.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org
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

On Mon, Nov 20, 2023 at 12:02=E2=80=AFAM Simon Glass <sjg@chromium.org> wro=
te:
>
> Add a new variable containing a list of possible targets. Mark them as
> phony. This matches the approach taken for arch/arm
>
> Signed-off-by: Simon Glass <sjg@chromium.org>



I encounter difficulty in understanding your subject prefix policy.


You used the "arm:" prefix for a patch irrelevant to arm:
https://lore.kernel.org/linux-kbuild/CAK7LNAQN_qGYztWGDmQyfg+eZ5P7RkM47mpgp=
0dQn_iuhvTSWg@mail.gmail.com/




And, the one for this patch.

"kbuild: arm64: Add BOOT_TARGETS variable"

Please do not add "kbuild:" for a patch
that modifies arch/arm64, and that was not even
submitted to kbuild ML.




> ---
>
> Changes in v6:
> - Drop the unwanted .gz suffix
>
>  arch/arm64/Makefile | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 4bd85cc0d32b..ae0c5ee8c78b 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -150,6 +150,10 @@ libs-$(CONFIG_EFI_STUB) +=3D $(objtree)/drivers/firm=
ware/efi/libstub/lib.a
>  # Default target when executing plain make
>  boot           :=3D arch/arm64/boot
>
> +BOOT_TARGETS   :=3D Image vmlinuz.efi
> +
> +PHONY +=3D $(BOOT_TARGETS)
> +
>  ifeq ($(CONFIG_EFI_ZBOOT),)
>  KBUILD_IMAGE   :=3D $(boot)/Image.gz
>  else
> @@ -159,7 +163,7 @@ endif
>  all:   $(notdir $(KBUILD_IMAGE))
>
>
> -Image vmlinuz.efi: vmlinux
> +$(BOOT_TARGETS): vmlinux
>         $(Q)$(MAKE) $(build)=3D$(boot) $(boot)/$@
>
>  Image.%: Image
> --
> 2.43.0.rc0.421.g78406f8d94-goog
>


--
Best Regards
Masahiro Yamada
