Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17485C4828F
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 16:17:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D9F987E7C;
	Fri,  9 Feb 2024 17:17:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nl4kk4QK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9F9887E7D; Fri,  9 Feb 2024 17:17:24 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 700CA87E71
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 17:17:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-33ad9ec3ec2so101753f8f.1
 for <u-boot@lists.denx.de>; Fri, 09 Feb 2024 08:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707495442; x=1708100242; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ihomAP7ISJ+yF1YUpNCo15SwRWPNJVNHDw2KzP/Pmoo=;
 b=nl4kk4QKP2dQt+NsV0TOoTnPLsDERUtZgTRTTMNxtBsj/5x9u7ci38YG1+wjqOVIPB
 v/hm9OkuierdcKbj+4JAtaDK0uDBdtCsdbfItjcfqsD2EAWzmxB/PE8qX+I21Tjdo7ka
 rSiVABZDGJBxBa3m6LeOTtyVr2UW8zb+O5d78yMMhBWKhix7b8XJtcJKvHE8jejqL1Av
 E0izDyMRtA3s+scKJoHC5rtkIjIr/EkB7Ir6/nxCI0OHBsc9tavrnUA8cAh+jJ6TXpL+
 6oTn9CIFFGfMRw+EATczoi/NbyFfIl0JIcBLjsqnWxLq2GuMFkzWDXnfqbAOBFLaNRCO
 BdWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707495442; x=1708100242;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ihomAP7ISJ+yF1YUpNCo15SwRWPNJVNHDw2KzP/Pmoo=;
 b=bxsiLTo8P4rQoml4XNkgosXuge+EzLBrfe8+MUlyMUsTa7PJ/Ji1ouVAKVICItA5Ho
 eNlVLUFItPZUbQTJZ8YMznWtkE5aWTAE3C5D33GH2nXxcgbRlZ5Xf7gDNhRzi5IPTPHB
 8ewW3uq1E72zDPJUnAYg8PVZM5LRewSVqG9XjC/2sdh4eLe8o4a1VopglCSP4vOZ1AAb
 G5gl3YBGdpYz5HJCCwn3y3rsERWJfAQARBvfhXOH6889yo7GG+mr1S6lb2KS5phU5Idw
 PFakONFAaUNs6W1p5E0yBKTGERKz8XRKwbpV/qnJuQOIZfiQ/dNljNKcE6IeUMVeSU8z
 VDBg==
X-Gm-Message-State: AOJu0YzLFLXWtxVPuxe194VHumKzdao1wg3GqxIGmhmqjQj/RI2xy2AS
 l35PYJMyl7vmW6fIq7jKYfeOqy4/JY4JaGej6cRbZICbNwdIztmZ+ZEUvaqrenYHxDxFjLemY66
 Vmdx5dIg1E8nUl9ixsRKLkQZasbw=
X-Google-Smtp-Source: AGHT+IEp+ole8UcqxSKsG0zZyBfNS2997u4UYPJ5E63gZgEXNLr2HfcFYwnNXHgYDmV5nruvFAPr0JYbfvrtjwmO5kE=
X-Received: by 2002:a05:6000:16ca:b0:33b:278a:15f5 with SMTP id
 h10-20020a05600016ca00b0033b278a15f5mr1618762wrf.6.1707495441459; Fri, 09 Feb
 2024 08:17:21 -0800 (PST)
MIME-Version: 1.0
References: <CAByghJb633bMqVhQ+zFzU-tR_hM88EFFhr7mXhj6nWDUhHhHYw@mail.gmail.com>
 <87wmre2amu.fsf@baylibre.com>
In-Reply-To: <87wmre2amu.fsf@baylibre.com>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Fri, 9 Feb 2024 17:17:09 +0100
Message-ID: <CAByghJbZrwA3SZUkacS-vGBCey8497e7v783FQyAKeLBmGSWnA@mail.gmail.com>
Subject: Re: [AVB/AB] Overhaul plans
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hello Mattijs,

On Fri, Feb 9, 2024 at 11:30=E2=80=AFAM Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> Hi Igor,
>
> On ven., f=C3=A9vr. 09, 2024 at 11:14, Igor Opaniuk <igor.opaniuk@gmail.c=
om> wrote:
>
> > Hi everyone,
> >
> > I'm currently planning a big overhaul of the current implementation of
> > AVB/AB in U-Boot during the 2024 year, which I have barely touched sinc=
e
> > 2019. I used to believe that it was stillborn, but looks like it's
> > being actively used
> > now by some SoC vendors and Google folks [1][2].
>
> This is great news! I am not aware of any development related to the
> above but I'm looking forward to this.
>
> I can't speak for all vendors but I know that TI uses both the AVB and
> AB implementation on their AM62x Android solution.
Amlogic also uses it.

>
> >
> > This is what I have in my todo list:
> > * Backport latest libavb from AOSP upstream and add support for
> >    Verified Boot 1.3.0 version
> > * Sync include/android_bootloader_message.h with AOSP upstream
> > * Check and backport fixes for AVB in AOSP U-Boot fork if needed [1]
> > * Get acquainted with a current state of A/B support in AOSP and
> >    backport all needed changes
> > * Re-factor libavb, switch to U-Boot existing implementation of
> >    rsa/sha256/sha512
> > * Add SHA512 implementation that leverage ARMv8 CE
> >    (pull it from Linux)
> > * Enable hw acceleration of SHA256/SHA512 that supports ARMv8
> >    Crypto Extensions to speed up verification process on ARMv8-based bo=
ards.
> > * AVB support for NAND storage
>
> I know that this has been send but I don't think Alistair has send any
> follow-up on this:
> https://patchwork.ozlabs.org/project/uboot/patch/20220926220211.868968-1-=
adelva@google.com/
>
> >
> > If someone is already working on anything from the above list -
> > please feel free to reach out to me, so we can avoid duplication of eff=
ort.
> >
> > Any comments/suggestions are welcome! Thanks!
>
> From my understanding, the AOSP version of U-Boot has quite a different
> bootflow since it relies on the (out-of-tree) boot_android command [3]

Correct, but it turned out that they are using some parts of the existing a=
vb
implementation in that out-of-tree "boot_android" cmd +
the made some adjustments on top of it, that we might be interested in :

$ git log --grep=3DANDROID --oneline | grep avb
ea8f0bb45e ANDROID: Add avb_verify unit tests
c9f88bf213 ANDROID: Adding function comments to avb_verify
c5599e4a9f Merge "ANDROID: avb_verify: Handle failed malloc in get_partitio=
n()"
3aeeae4426 ANDROID: avb_verify: Handle failed malloc in get_partition()
2910c1042c Merge "ANDROID: avb_pubkey: Use bin2c instead of ld"
30fbf100b6 Merge "ANDROID: avb: Extract avb_pubkey_is_trusted()"
296361e80c ANDROID: avb_pubkey: Use bin2c instead of ld
5af2c6d968 ANDROID: avb: Extract avb_pubkey_is_trusted()
f74b3f5815 ANDROID: avb_verify: Don't Return ERROR_IO for mismatch in
pubkey sizes
d6615cd233 Merge "ANDROID: Qualify avb_find_main_pubkey() parameters as con=
st"
9c8470ed6b ANDROID: Qualify avb_find_main_pubkey() parameters as const
af808f4b04 ANDROID: avb_find_main_pubkey returns CMD_RET_*
2070f02c75 ANDROID: remove erraneous avb logs

Btw, my initial intention (back in 2018) was to make avb
implementation boot-command
agnostic, as at the time of implementing it different board/SoC
vendors used different
approaches for booting AOSP; moreover, iirc AOSP-specific cmd
(boota/boot_android
or whatever it's called now) didn't manage to land to the U-Boot
mainline despite
multiple attempts by different contributors.

>
> [3] https://android.googlesource.com/platform/external/u-boot/+/refs/head=
s/main/cmd/boot_android.c
>
> Please keep me in the loop with your progress. If you want, you can
> reach me on IRC as well (libera: #u-boot, nick: mkorpershoek)
Sure, will keep you posted!

>
> >
> > [1] https://android.googlesource.com/platform/external/u-boot
> > [2] https://source.android.com/docs/devices/cuttlefish/bootloader-dev
> > [3] https://android.googlesource.com/platform/bootable/recovery/+/main/=
bootloader_message/include/bootloader_message/bootloader_message.h
> >
> > --
> > Best regards - Atentamente - Meilleures salutations
> >
> > Igor Opaniuk
> >
> > mailto: igor.opaniuk@gmail.com
> > skype: igor.opanyuk
> > http://ua.linkedin.com/in/iopaniuk

Regards,
Igor

--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
http://ua.linkedin.com/in/iopaniuk
