Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 898CE10ED67F
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 14:53:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0391583C14;
	Fri, 27 Mar 2026 15:53:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DqXI2Qqe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5453783C14; Fri, 27 Mar 2026 15:53:35 +0100 (CET)
Received: from mail-dl1-x122e.google.com (mail-dl1-x122e.google.com
 [IPv6:2607:f8b0:4864:20::122e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEBBF81E18
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 15:53:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robertcnelson@gmail.com
Received: by mail-dl1-x122e.google.com with SMTP id
 a92af1059eb24-12a74039dc6so1815452c88.0
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 07:53:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774623211; cv=none;
 d=google.com; s=arc-20240605;
 b=OtBZEUURklxhOTFA46BGcYzHxoAlso/jcSLHTaJVSXos1R6MQtOtL8WAO1JsKmLptT
 uTzUXtQyi0iWiyvwc2UsyOTaWKoBxzCP4O61f1I69qfJTKZtqpWVxYKD2vNfnkwgeAEy
 jV29tKj5sB0kSJ8hlvauzI5KXOvjt62RwnjI/WK725sXXjPZiODuy5Nw1snE6GmQge6I
 3vIR/r3mIWDNPpjJvFrZiQzgyLdYf/4/Rbhvgaic+ZShwwB0tXSHUiNaUXK57enAJtDc
 e3VyAwlCKOh7Cxl+cD+dXSD0/LcrIsj8dWxe4bixZmVyI1s/DBq69ckkRTH0yvaHX+zv
 AQXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cP+NCN/tcVQdvlyBEErxMmIWdVM9EfA/+pUxcxKcDns=;
 fh=djCQdWwnIJZsWkOhuupw1HhZaFLoIl8Mx6dOVt/gIZs=;
 b=ZLSiO92sbBDL9KY0biAbLatKpj0ItwA7uu5MTxMOmB6ubbiTciGw7ZX63JLAAB/6tT
 ZHF6xpXP8sSBnM4ilzM/GqnbtSowNL25MF7jyI+YMTrS2J5UWqEiQ2n7+NZEyMRVZC7e
 dDIznQkKhXLB6KdCpvqrOw7tHDsNTkDOd0nS6den2yKMPxd2oDn15eiFFZuSBJW7UTqU
 E1hSRaBdgoTSWs+AkFl/lmWta6ouuOgn3pbf8LEiuLaENBFDs1BUFalwR1RJ84ItMzAy
 doLvftYcUuQF0EJHPLmSvlaw+LGiCHljGy/3IhseX499nFeV3rKoMmePpdqemVrgwdP6
 hnyA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774623211; x=1775228011; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cP+NCN/tcVQdvlyBEErxMmIWdVM9EfA/+pUxcxKcDns=;
 b=DqXI2QqelyJS6rBubzNnoq4+sBxp2IPlKV3BPPAVeQOEfDQ+fl2HcfNAPGdlh19MMW
 Rha/l3VOsx2rU+/E4XUwmmpV+MV1tEL8q8JPKSB0w/q6GYCrPHOJlxYKiEnGVuuBeqTv
 VnWB53LzAQxtMoimbmbxtSnkCzLgS9lm56GDgM75E1CgTURz5YvxZYhVmyiv98CGM0ra
 oAOPP3uowr8DRj5H6l7TCHHoF9b13jOfxXO8mOVBym3SvazlgajGrzg/Y4k9L/RDWNnF
 h6dzEzOzrvnflbPvKlP6BcZFafYI3eQbfPgWTUmn7IO68gBZ5GGnZJoBUVvw/FX2jEzk
 reLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774623211; x=1775228011;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cP+NCN/tcVQdvlyBEErxMmIWdVM9EfA/+pUxcxKcDns=;
 b=FIZhLr3vqQiQupxw27KuGAHJIS2FeesvWb2qaUsk66P0y2E+iHx8p8FKZk5pld+/hT
 PNY9fEsZIXsWXQ9RQhnyNzlsOWEKYshOiXxnciyg/szDFzlAt8zyJgsxCOMofDmVpdCb
 StFPHxKJzyoT+5zn53f9mFT2kdFxVvDGw0Fcue8P+FSkFDm6hoXqUv8FSyK9mpjbNTTc
 yaCEPxdIGi2vCGdzsGEkicBLamYbM2eGgCR6NE9kSrW3CCRjEFXX7uKaSZudUegXCfMX
 9l2t2DRj2VEAK75r2J+KRnqE+mw8xcdYnS51Bp1h8za8bIV66nLLFDFCA1GM2/6bZxhl
 O4FQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCULP9egdU+oKZjcq6EwuW696vxyzqjOP3QKhUUbfsjMlY4vC7sk9NLK1Qs9hlwKCr9YtbonQTM=@lists.denx.de
X-Gm-Message-State: AOJu0YzXeDRVlzhLsY1edIgAQ1/JJU+H8Yp9lDiS8q4K8NVsZ+FYb3id
 ZZyjnT9tjBLu3za8WsPVSpnTwkw8wVTdciCq+YdysRnt15TXimPsDH80dm66yQgUghPoONSqXf5
 sjTH7mUIWdiQAsfOZGDsueIoIWFOqHdU=
X-Gm-Gg: ATEYQzz40TqwcS8SSixno3CKyO5HqRwKVweBW4EYO7XE70uWhwU6GlqUHs7GwTUSj+u
 tWZXiGHRBoBX7OOKrb5T5WfeuZGeV30HTxxT6X/9FaaYemwsu4k3G2WLl0WOwVU82WiozsaoUvQ
 nV2ALmCQ3b5GH4b+7tLKZLDceaaK/RJjtB8kDQ1Ce4W0j2D3tQhXnaLN8pssOP2KnARfDJhlkzX
 A/433L2MNQlIyIorZ2MQySMzf71BBEm3mjV4CrJcnzh7n2MZ8ImnDfgObJScjljkHZKg2nvhFlz
 0QCfzHeoaTOPBZv30uqMCGnzFoNv7EkVjFoxV9uLXlwd903RO7iujIGgp6KZ4upnJJNW+j8wUW9
 7yS8YjTv3PKleZvr+RGeL4io7qp0=
X-Received: by 2002:a05:7022:4582:b0:128:df80:1852 with SMTP id
 a92af1059eb24-12ab283c2e2mr1771296c88.9.1774623211088; Fri, 27 Mar 2026
 07:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260317223800.776581-1-rs@ti.com>
 <20260317223800.776581-3-rs@ti.com>
 <DH7I5D8U3GQX.1NAV7HTPAAJ8L@ti.com>
 <CAOCHtYhr50ywU_ar6qFPYrwJeUbjE+GQC_OYO_W4Pc5A9iJ5-w@mail.gmail.com>
 <DHAEYEEVEBW7.304SKN4GDBP4B@ti.com>
 <CAOCHtYgan-p8PiuwKCPmDY=xaKvnGc+F1OZXgyDHFGg4F9NJ1Q@mail.gmail.com>
 <DHCAJ6L5XC77.9F2NK2OOEAT5@ti.com> <DHD3N5DPHPVI.159WWX3H4U3Q3@ti.com>
 <acaTPyGbaUQj7hk3@kehys.lan>
In-Reply-To: <acaTPyGbaUQj7hk3@kehys.lan>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Fri, 27 Mar 2026 09:53:03 -0500
X-Gm-Features: AQROBzCc3FlpO5a4_oYM0JtpkSMIoE4Smzs01Us6U_W96VK2awSHeWfEdpYaxdQ
Message-ID: <CAOCHtYidPpJMZeDj0KkLkuh6YYOFVAe80NMWWu5wbmV2ou+=UQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] k3-am62-pocketbeagle2: add initial board support
To: =?UTF-8?B?TWFya28gTcOka2Vsw6Q=?= <marko.makela@iki.fi>
Cc: Randolph Sapp <rs@ti.com>, Erik Welsh <Erik.Welsh@octavosystems.com>, 
 Anshul Dalal <anshuld@ti.com>, bb@ti.com, nm@ti.com, trini@konsulko.com,
 afd@ti.com, u-boot@lists.denx.de
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

On Fri, Mar 27, 2026 at 9:25=E2=80=AFAM Marko M=C3=A4kel=C3=A4 <marko.makel=
a@iki.fi> wrote:
>
> Thu, Mar 26, 2026 at 06:23:20PM -0500, Randolph Sapp wrote:
> [snip]
> >Alright, looking into the allocation helpers it seems that
> >EFI_CONVENTIONAL_MEMORY can be remapped in efi_allocate_pages so long as=
 LMB
> >agrees that it's free. This aligns with my understanding of the UEFI spe=
c as
> >well. I dumped the EFI memory map and noticed there were 2 fragmented se=
ctions
> >of EFI_CONVENTIONAL_MEMORY that it could still use.
> >
> >Wired up efi_allocate_pages to go to those regions and attempt to alloca=
te from
> >there in the even an LMB_MEM_ALLOC_MAX or LMB_MEM_ALLOC_ANY start failin=
g. Seems
> >to have worked, but now I'm seeing the following reported in the kernel:
> [snip]
>
> I can't help with that, but I hope that someone can. Because I intend to
> work on improvements related to secure boot and FIT verification, having
> this board working in the current u-boot would be really great. I'm
> looking forward to test a revised patch set.
>
> Coincidentally, I just got a PocketBeagle 2 yesterday. It took a while
> for me to find some useful u-boot source code. I came across
> https://github.com/beagleboard/u-boot/commit/64be5e474943dc5c6e6e01edc124=
ff6f53f616a4
> which is a few changes ahead of u-boot:
>
> 64be5e47494 arm: dts: k3-am62-r5-pocketbeagle2: remove chosen uart overri=
de
> e1207aad9b0 arm: dts: k3-am62-pocketbeagle2: add boot phase flag to uart6
> 23f9fc5d6da arm: mach-k3: am62: add &main_uart6 to clock and pwr tree
> 156a9bb1410 add: k3-am62-pocketbeagle2
>
> On a merge to the current u-boot master, I discarded a change to
> k3_get_a53_max_frequency(void) by 156a9bb1410 because that function has
> been replaced with am62p_map[]. In that array, the clock rates for the
> speed grades S,T,U,V would conflict with patch. I don't expect this to
> be essential, but I thought that I would mention it because there were
> no adjustments to the speed grade in this patch set.

Marko, here's my last wip, before Randolph submitted:
https://github.com/beagleboard/u-boot/tree/v2026.01-am62-pocketbeagle2

v2026.04-rc* has had more TI changes for low-memory (512MB) devices
hitting mainline so things have changed again to work around k3
stuff..

Regards,

--=20
Robert Nelson
https://rcn-ee.com/
