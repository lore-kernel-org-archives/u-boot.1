Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4DE5D778B1
	for <u-boot@archiver.kernel.org>; Sat, 24 Jan 2026 00:13:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FDBD83AEE;
	Sat, 24 Jan 2026 01:13:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iT6Kue3t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 717C783B03; Sat, 24 Jan 2026 01:13:41 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76ACD839DF
 for <u-boot@lists.denx.de>; Sat, 24 Jan 2026 01:13:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-383122fbc9bso20689091fa.1
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 16:13:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769213619; cv=none;
 d=google.com; s=arc-20240605;
 b=OI/pPW8tsWk9mh1KAZWNfRpCflSzzwRFYiw/lMZBy2S9xkS2oz5/HORRmmtaSKB3aB
 6NP0NpDyu/yIr0qu5FyjJAikq8s2ZQgWmYxBfTxqymfs6hdUVxWNKNP/P0nAk4gWbrOF
 M1gsALhuskC3P8o+L9dYDXWJ5Oo5AexAGjAAshNVut7YxArLPodxf5fke/0OjlWzpSDc
 AOG+n7f9N0dXFNWLBw7DgRHMiPnd9ghn2cHZceb1+14dRncUhfvOmQUg7+6Fg6NoYVOL
 u5sUwvY/o2BS8R/WofMn92mCsKSeFWm959N56g9c5rVMlXkxeQXH6If/jynsr/e3q3dO
 CH9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WvGns2M38eUMOxnBw+AKVlEnOm9nSudSU3clN6oCBdc=;
 fh=i9kap9ZwZr4yVKZ2aHRk/U8QCM1eWKG+SZj9RqkaYJU=;
 b=NOmFMgYDO2iLzSAIEBcmiySv0MVBA4HLtS8l0i4h+kEbR6l3XW0mD1UW/P/hv7XGt0
 ATONeKfxTfdOr/pFhjOiPdLWi/qUfL+22t0fW2Z0Cimk2aG4J1A9MOTx2O8QIedXSpbi
 sZFKrYquTvkdG4lRh/pE6E7SUJ1bMyjW5nHwYMWH/u+Ze2D9G/2ajGdHG8XVbCjbKXA4
 vqlZm5MIWT2DbSL9gTxdKzcql+fFPSPWDhMMf7cPEbBPfAcVRlHcs4MhSkmQalQrxXgA
 qgxp0Sji4amv5NqCTQJJEiSaynGRECUI0Ar4EjFY0eyOp5uRdYDvLUFF9w4lz37UfXIa
 WPkQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769213619; x=1769818419; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WvGns2M38eUMOxnBw+AKVlEnOm9nSudSU3clN6oCBdc=;
 b=iT6Kue3tYtQSmbk9sFqERLmLmYkKkIRwQx+KnpvdyaAOCtVNjJk+jO/t6IQmpkk9XU
 XFJslW1fqig8cZ/+0RJqocDWh1SjHdc5D3mjMe+GBCuujFZNCApdehgkKneHvVlK7PJh
 uTTn3wJYLjEaP1Wa55+ucG/8jUcGSzzZYxgNdikizfBBMM7I/YNkD5JlXiEZ30hT8I2W
 AAS+cDjr+E9DpmyM7TZ1L0cPl+B+Ku7T5l+zxLraIIEiMrriX62Ly9mS1yL4feK3/IcJ
 NbXo1Zk/vb8eCKIROBctDgyU/IdxbCPao/8k9DRhWDkn4ghrKsnARu8/nxuEZ16Isyng
 Do0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769213619; x=1769818419;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WvGns2M38eUMOxnBw+AKVlEnOm9nSudSU3clN6oCBdc=;
 b=VyDojtVCHsctETImd+k5I+xFz+CGtH2JV+7K9erdTCKrmdwnxvTLAhfdHuKYPHvQ8z
 U4KZVTlNxI/t3CvJidIlSPm1wazUzlN8Lc/ilpECXbWDLgugZ7Qx4XpxgYmQPCBnc7iW
 yC4kr1+7MVYLvtAVVy0fZ6FbuPEB1i8JWbht5kf1e68Ah8xtWYRLeUlXDABOTJ9ubz36
 /4IV055/gMte3cqlp+tqvR8DMfZe8CQ1fxUc1AJ4nU+ac8x1cy47yOOOc8mzqQeSLVAy
 hqwnfst58rUQ7tO3QBHVuBcu8CdPzqan3vaH2QVZO89NxKC5Iq8gBJQzSnlqXnBvD4+E
 cb1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrNh+JLwDXg6X6tAEdMpvwhjkYo9XF8Joq3Emt7yDY1/2S7fDb/wj9sSQkd/QroRMfdregw1w=@lists.denx.de
X-Gm-Message-State: AOJu0YxpSx8zmI7SQIDpDsBJkWqBcNQn6bc0sLMPuyH0vipLb0CfZw14
 XVTr6KgHOqXFEZK2P4tdIQVri+BEFaPIJFJ1H/dNlZGEXv7w9wal8QlowMlJyVtc6oyxNG005r4
 cq03I2fl+RMdeIE37zpl0kHDZQjW9LqM=
X-Gm-Gg: AZuq6aJKxng5kT7QBPFiIjjaKNdNzy25dOp7Lpu/lKtXZ8ChJjSWoKe8lbgi5E0f+Yg
 GDf6CiUoO04/DvlyVJ16vGyXT39+OVHG+S1bSYjiaPWq/FQKXGDICE3XsgDaUz8h4RYRIxQw6NX
 FCialrMcMwmU9nCA/eLh3n7YJZGxqzfL0vugQW/7jwfSi5g9qqVy3b02JgkCxLbcdZueSWG5jNw
 JrrbksibLfUa4BzkeDWYgesrOE7zkKbt+EvoQ5Ldc1WEkqPbDBP/h79le573wpnAplKep9Sdfu7
 MLaK+yMg8bajaLiq0WTlyz95OBUy7HHVfRq8
X-Received: by 2002:a05:651c:1504:b0:37b:a640:765e with SMTP id
 38308e7fff4ca-385d9f0fd0bmr15964451fa.11.1769213618400; Fri, 23 Jan 2026
 16:13:38 -0800 (PST)
MIME-Version: 1.0
References: <20260123161907.392211-1-festevam@gmail.com>
 <20260123201202.GO3416603@bill-the-cat>
In-Reply-To: <20260123201202.GO3416603@bill-the-cat>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 23 Jan 2026 21:13:27 -0300
X-Gm-Features: AZwV_Qjvu2ypNaTay5ZXoi5iKsh6SydxefY8--TlBlhAaFxCMdlRw9PGd_aap04
Message-ID: <CAOMZO5DVFO=A6g1CWOrRbqy4VNgL+VcUw0Q5pgELXm30puGz4w@mail.gmail.com>
Subject: Re: [PATCH] arm: spl: Fix DTB offset after binman symbol table
To: Tom Rini <trini@konsulko.com>
Cc: marek.vasut@mailbox.org, u-boot@lists.denx.de, sjg@chromium.org, 
 ilias.apalodimas@linaro.org, Fabio Estevam <festevam@nabladev.com>
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

Hi Tom,

On Fri, Jan 23, 2026 at 5:12=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:

> I've been talking with Ilias for the last few hours. This still isn't
> right, it just happens to work in some cases, but not others. What's
> going on is that while we always have u-boot-nodtb.bin 8-byte aligned
> because while the BSS itself may end 8 byte aligned, we actually care
> about the size of the BSS being 8 byte aligned. Can you please try:
>
> diff --git a/arch/arm/cpu/u-boot-spl.lds b/arch/arm/cpu/u-boot-spl.lds
> index d780a5060774..dae8a1ec665b 100644
> --- a/arch/arm/cpu/u-boot-spl.lds
> +++ b/arch/arm/cpu/u-boot-spl.lds
> @@ -58,6 +58,7 @@ SECTIONS
>         _end =3D .;
>
>         .bss __rel_dyn_start (OVERLAY) : {
> +               . =3D ALIGN(8);
>                 __bss_start =3D .;
>                 *(.bss*)
>                  . =3D ALIGN(8);
>
> And see if it works at run time? hexdump'ing looks good. If so, I'll do
> something more broad to catch the SPL_SEPARATE_BSS=3Dn case, and add the
> ASSERTS that are missing.

This fixes the boot on RV1103, thanks!

When you send a formal patch, feel free to add:

Reported-by: Fabio Estevam <festevam@gmail.com>
Tested-by: Fabio Estevam <festevam@gmail.com>

Thanks
