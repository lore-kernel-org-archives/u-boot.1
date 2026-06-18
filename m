Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7389DCD98F6
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 15:27:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF9FD847C3;
	Thu, 18 Jun 2026 17:27:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AAX3QVk6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FA4D84874; Thu, 18 Jun 2026 17:27:16 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1E6B8460E
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 17:27:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-69574a26071so2012426a12.0
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 08:27:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781796433; cv=none;
 d=google.com; s=arc-20240605;
 b=N1x1KLsWF8h1wsE00RS/O90nq5jtQF73LMPh2vj4VRxbKtO4oN1i5k6MDGrO6+no6y
 MjkQpYu0dP26tN96vvXvTKy8M1VeVeHWiKQg5G2JXiHeifQNHbsSQmxEY278TXgrdk7B
 UARqfDJoThvYUN9GAvXqJUQPw7+B6i5m8ElhUma3Td0PScrtd1j7fRv18PyK59fitbKT
 R9vjK5vsc9IFYiD3Qe7Hamx/nrVxND2HU0MsK9rt6+oF2rMLb5luf+nRWA2wFC7XnN8c
 tPpv8OIQ2rGb9hW2/gmX2rgjda0cUh9Z9JrgoBpFDHvCdcn6943IBNrD9CGeVIrLQk4E
 PnVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=l9d5+t8zw7Hmz1UoAtLbCuYA6wg/AvCrsAGYLs083QI=;
 fh=Y5KvgFNxYgrM+6prIVlz3vAEF4p10qoFwq05ecnn+kA=;
 b=BDd6qwlAkFKnuUbHjsvFfUfQIeouxpbfbCI36lNSuPrCbmsJy+jPqSgG9OOvKOlSbj
 zG9Od/7xV4NY7QufzxGnE9113M5vTiV448yDKyIArkuJwxPs2tqhN6VAzSMASjz+Bdcm
 OEo0215FDJy7lvDpYPLm5E17hpCEMbNrZUONyRudqHiSXCjeMTZRFv6FiqGG/koVbzE2
 bCOAsIzKpvMVkxC6b2l2xtLiJogJyufA+l+fcNM60VUCuntoBwqGM7TmCZlISr6S+wP8
 kaN4l67k+2t+SolpST40l89U7cHf/8r8Ok43P7V/afq5OKmeyKtfF1ZdY60OyELe23xw
 KDkQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781796433; x=1782401233; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l9d5+t8zw7Hmz1UoAtLbCuYA6wg/AvCrsAGYLs083QI=;
 b=AAX3QVk6o8x9bZH8PR/mbGNJwG8c3GNQpSGc6VkLqgqnd+YMgsRVgkgc/GMkAngaNd
 abvQbGA5u2N7AKXZ6idWk9jZ1exCKMDi/WbBfx7Vudrkk55SlN/6pBMVPXXZMU8GMI29
 x47TocDf78vH3jdTVdtIz3boR5mcaKRbT8zyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781796433; x=1782401233;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l9d5+t8zw7Hmz1UoAtLbCuYA6wg/AvCrsAGYLs083QI=;
 b=ImiTpsj34cS6Y9wQxi0T7L+cO+LPlPXpu/UgXP9dTxH61PAW1PZxNewJhK87S1btLs
 RL6S7v5M8vpQ/K/prY2+1wV3sobJE9ZKvUlgJ+SkrIn7ObwrpuUKdSpAHypa8RJ/4mAu
 C2fLvhfcsObogk9i0I+vvJvpQfXaprYlp4O26Fuh8DcN6YI9TqUhz9ig+UDDCX3xFohz
 oL5o9ds9zynNtFfia4Vs1vBJbsRRzgOtOFKF1ro1Xaa1ykHF/1FNOGfh5WfKULO6vBN6
 VXXzPQll2c247C2JGwJ/MzEJ00wJvh+82BSqRePRayepUVDYypUi0OL7Il9nJQwUZ7oD
 C5Jw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+F8i3O2AzK9c3spqOMxaTLvhl+icd9e+srKKosOqqDbi0eZ70LUaOmjCGwpXPjyOsD3eWFPl0=@lists.denx.de
X-Gm-Message-State: AOJu0Yxku9i2ZNBpJrt5ZMmfw6vhqKkoOniDDRC0XRp+M1Pq6qSMRxs8
 1gE05ihTpf5jI0VLRndWYzWv2frJ4Aa+sJ5/wFbZPzNrtgpfOKvdqDQbvE1ZFdJH65BmcxrtXEN
 uacepuFiVWDhvkwYB+CCexspAUTJ+eDJ4/9Op6MmMlv6Gk4ay+N/hMHw8
X-Gm-Gg: AfdE7ckN9783exEKcqA/tiYEu6957XpDPt8c6Hv1dBYhFD/qu/HqpK8807XjTGYnp1D
 5MY4ua95azqTECDcQu1+VrSj9gZQMZjctOjZTIRdpldPvQWZ+Yo5fnFbs06BKH4NIBJE4rET5wg
 HQX32jhPnfiXK8vq+QUKfs4mRlLZO8DPboQnsE7xhMhFhiA+SfBdI0J11yedfbSG/eREQVwprky
 aYS+lFzYOp27ZOkyAmP+b94tAD7XaNUMljWupQHVimlE3zlGy4pZE9hqvY9VBfqZcHBu+FR+Q==
X-Received: by 2002:a05:6402:360a:b0:696:c770:cd14 with SMTP id
 4fb4d7f45d1cf-696c770cfbcmr123604a12.27.1781796433079; Thu, 18 Jun 2026
 08:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260618150913.314507-1-vincent.stehle@arm.com>
 <CAFLszTh1p01CC8-1Or7AQhziLkNqzN4NKADJ+hKYSEVjM15t3A@mail.gmail.com>
 <CAC_iWj+5u3P3r2jfeXXT=n13uAnStE+vAPxPWS0F2SwjSZP7rw@mail.gmail.com>
In-Reply-To: <CAC_iWj+5u3P3r2jfeXXT=n13uAnStE+vAPxPWS0F2SwjSZP7rw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 18 Jun 2026 16:27:00 +0100
X-Gm-Features: AVVi8Cf5VEBFfDKb8MzFlc-PZeufYS1e1Pz8PmbOM626aXJQoXlmmOrdN4tortI
Message-ID: <CAFLszTjXd441uA4-aF4AvUCFvdOvYdVCcEw8AZ12MrEaEyRuvQ@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: add missing EFI_EXIT in
 efi_disconnect_controller
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 u-boot@lists.denx.de, Ahmad Fatoum <a.fatoum@pengutronix.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
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

On Thu, 18 Jun 2026 at 16:21, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Vincent,
>
>
> On Thu, 18 Jun 2026 at 18:19, Simon Glass <sjg@chromium.org> wrote:
>>
>> Hi Vincent,
>>
>> On Thu, 18 Jun 2026 at 16:09, Vincent Stehl=C3=A9 <vincent.stehle@arm.co=
m> wrote:
>> >
>> > Make sure to call EFI_EXIT() in efi_disconnect_controller(), when retu=
rning
>> > after having called EFI_ENTRY().
>> >
>> > This is inspired by a barebox fix. [1]
>>
>> Hmm, does Barebox support EFI_LOADER now? I wish we could bring these
>> projects back together :-)
>>
>> >
>> > Link: https://git.pengutronix.de/cgit/barebox/commit/?id=3D080db65e39a=
877b000baaf843c997a69821dfe69 [1]
>> > Fixes: 314bed6c854e ("efi_loader: fix DisconnectController() for sole =
child")
>> > Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
>> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> > Cc: Tom Rini <trini@konsulko.com>
>> > ---
>> >  lib/efi_loader/efi_boottime.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_bootti=
me.c
>> > index de57823bd44..b6966652d97 100644
>> > --- a/lib/efi_loader/efi_boottime.c
>> > +++ b/lib/efi_loader/efi_boottime.c
>> > @@ -3895,7 +3895,7 @@ efi_status_t EFIAPI efi_disconnect_controller(
>> >                                       &number_of_children,
>> >                                       &child_handle_buffer);
>> >         if (r !=3D EFI_SUCCESS)
>> > -               return r;
>> > +               return EFI_EXIT(r);
>
>
> Any reason we can just goto out;

+1...every other error path uses 'goto out' so the single EFI_EXIT()
at the bottom handles things - child_handle_buffer is initialised to
NULL so the free() at out is safe.

>
> Thanks
> /Ilias
>>
>> >         sole_child =3D (number_of_children =3D=3D 1);
>> >
>> >         if (child_handle) {
>> > --
>> > 2.53.0

Regards,
Simon
