Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 394C5C5AD49
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 21:03:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 510A982BD6;
	Fri, 30 May 2025 23:03:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GvUKobSc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0C4482C38; Fri, 30 May 2025 23:03:31 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7989C82BBF
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 23:03:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-70e4043c5b7so24472127b3.1
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 14:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748639007; x=1749243807; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fR8Kap5a+EzURNbuX+zyP9+USDB+Nr32slPxkNW2SGI=;
 b=GvUKobScCAFBeKT0ndVjaqyGo9tINomHAH3s8uVIje50PdXhiTbSnijddblP7vufVi
 SVdhFIRDDHLDnAV3/Q0QgKgNdaNdD1bAY+poafwoacCeLrL+d+hX7q7voni6afRcAk+U
 VQCqzW8sAb9W9t1GMgMoqtkm43WCuYOIbkA2cBmz+JoypBVk/+X5vd5pJpe8HDyEg7YE
 6ITtOy5gDeGowyPE7NKcqWwQg2YrLaIWB65A5ugHK5lH9GSiQUw0S1iCDEkOyPrVQHx1
 AePwIJY4Rjan/ofObf9nH7GmEEd3grrWTleuPDuV+004DBprmgOFYO0a0LIF21lgVK/6
 +SWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748639007; x=1749243807;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fR8Kap5a+EzURNbuX+zyP9+USDB+Nr32slPxkNW2SGI=;
 b=TuIH6/Pa3+h+DjDxWqhY4/zQgqmnRwAmzfVPGJG+lM6u1tBt/ZNiPKPL5huCQTTjb5
 mda9iMmzUcHUVMJSEnDbK1vsa7v0bOU7cxnpvmZOJfs17oxnpzXq+0sZDJCGhAEDmgmM
 oKVwVra3PSqYPJsVA0TpbrkeqZk/Qvj1CidF0IZ116EVgG7Ya6quyteCxUUckIT8irB7
 jVytzZ9r3QOpSOW1hNBT1n5M8bkyo4/OsBNnLNxJmArkx0sHxG8t6DsCWP2MWccJ1uWb
 x7CCBTby216UUtRkOwzuFximQ7n5tDjodzBoq7Dtx98fI7iIenMafrnudKWJczKC9Bfm
 R4XQ==
X-Gm-Message-State: AOJu0YwnWmWQca4gVBFiuIDBamm1MG5kx3aq3+yvLM07ssR/lwQoXEvr
 J0UtI7JUMoyqAA8GMfk3JqcKRcbVKxz0TxVKitcES7JVVTtnYHjW3T1et1uiFQinaCLE3L+kckG
 3j+J4cQtt2aKTpGpNtbmg6E9kL6dds/hcvtUcjVJXDA==
X-Gm-Gg: ASbGncvQlwRMj7EhJMi/LFUgXRI1c9YFGNfDTKxcybw6NEbq/2vWhBAWR+/h5kwWsNT
 KxCGYmViuF8K0hyZE1d/zvAW5A1gH7dVuUd4K42Oi9+/+O90Llrqb5UYG9BogeGvNCfec0V7NRC
 5Lri87UB4Oj5X7jzKjl4ULoCrdu7uwxlAocm2MquGkE33H
X-Google-Smtp-Source: AGHT+IGS2riJ3NZA+CQYbhUiZovxT5T5dmxllRH7PazzG2fk+1v2h7WKOxIq6Dlwwe8C+cydX5NQlNHE2SLeZrZRY+s=
X-Received: by 2002:a05:690c:888:b0:70e:16a3:ce92 with SMTP id
 00721157ae682-70f97e9baadmr78282607b3.17.1748639007182; Fri, 30 May 2025
 14:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <145501C2-B034-44EC-A16D-4F1A150347FB@wolfssl.com>
 <D9RMK91R8Q2I.3BA39TM77AYZA@linaro.org>
 <AB2FA403-CBB0-44F6-AC75-4A70B3E9242B@wolfssl.com>
 <CAC_iWj+mH2jywAYA_cBOqBnk+pvH-+r4nwL7SD8HGDbdmu284g@mail.gmail.com>
 <D73260F8-6334-4F8A-A8DD-FF70B8EF313E@wolfssl.com>
 <CAC_iWjJt=Rq2=FzhLpZpiSycXFuUC1Yd-07Ru4NZUMRt+hqKbw@mail.gmail.com>
 <BE301B14-56AC-44D0-9EA4-84346EEF313F@wolfssl.com>
In-Reply-To: <BE301B14-56AC-44D0-9EA4-84346EEF313F@wolfssl.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 31 May 2025 00:02:51 +0300
X-Gm-Features: AX0GCFt7fxVBWCfQYaXxbJl_thBc4_jNhJu4UCyFkdXnmqhcHyakJe0vfehPjYY
Message-ID: <CAC_iWjJHdT4rzDt9nuXOE=Yk7aXnive7ChDCg-i6uyeLsrTCmA@mail.gmail.com>
Subject: Re: U-Boot support for wolfTPM and firmware update for SLB9672/SLB9673
To: David Garske <david@wolfssl.com>
Cc: u-boot@lists.denx.de, Todd Ouska <todd@wolfssl.com>, 
 Larry Stefonic <larry@wolfssl.com>, Wolfram Kusterer <wolfram@wolfssl.com>, 
 Aidan Garske <aidan@wolfssl.com>
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

Hi David,

On Fri, 30 May 2025 at 22:46, David Garske <david@wolfssl.com> wrote:
>
> Hi Ilias,
>
> Thank you for the reply. I totally understand about being busy! There is =
nothing specific to discuss at this point. I=E2=80=99ll reach out again soo=
n with the proposed u-boot wolfTPM patches.

Thanks, the best advice I can give is look at the mbedTLS, lwIP & the
external DT integration and how that was done. We've done enough
reviews on it, so it will you you a good idea of how things should
look like

Cheers
/Ilias
>
> Thanks,
> David Garske
> Software Engineer, wolfSSL
> +1 (530) 409-2990
> https://www.wolfssl.com
> https://github.com/wolfssl
>
> On May 30, 2025, at 12:32=E2=80=AFAM, Ilias Apalodimas <ilias.apalodimas@=
linaro.org> wrote:
>
> Hi David,
>
> On Wed, 21 May 2025 at 20:12, David Garske <david@wolfssl.com> wrote:
>
>
> Hi Ilias,
>
> Thank you! It=E2=80=99s a pleasure to meet you! I=E2=80=99m the author an=
d maintainer or wolfTPM.
>
> Perhaps it would be useful to meet and chat for a bit? Are you free next =
week May 28th at 7:30 AM PT?
>
> I loved the feedback from Simon Glass and we will be implementing those a=
nd suggesting a new patch soon.
>
>
> I am a bit overloaded. Is there anything specific you would like to discu=
ss?
>
> Thanks
> /Ilias
>
>
> Thanks,
> David Garske
> Software Engineer, wolfSSL
> +1 (530) 409-2990
> https://www.wolfssl.com
> https://github.com/wolfssl
>
> On May 19, 2025, at 1:52=E2=80=AFAM, Ilias Apalodimas <ilias.apalodimas@l=
inaro.org> wrote:
>
> On Fri, 9 May 2025 at 18:43, David Garske <david@wolfssl.com> wrote:
>
>
> Hi Ilias,
>
> Thank you for the quick reply. I am happy that you will consider wolfTPM =
as a submodule. We have 100=E2=80=99s of commercial customers and it is ver=
y actively maintained. In fact we will continue to provide direct maintenan=
ce for any u-boot issues that come up using wolfTPM. Also we=E2=80=99ve don=
e safety critical DO-178 certification on wolfTPM.
>
> 1) U-Boot subsystem maintainers. Can you point me to that list of maintai=
ners?
>
>
> it's in MAINTAINERS. I am responsible for TPM
>
> 2) Size: I haven=E2=80=99t run any size comparisons but I expect to be in=
line with existing code. I will make sure we run some comparisons.
> 3) Releases: Yes we have stable releases done each quarter. I am about to=
 do a release v3.9.0 next week that includes the U-boot support, so I will =
update the submodule to use the tagged release when it=E2=80=99s ready.
> 4) CVE: Yes we track and create CVE=E2=80=99s if we find issues or any ar=
e reported. We typically have a fix posted within 36 hours of a report. Vul=
nerabilities are published in the release notes and for our premium support=
 customers they get early notification.
> 5) Patch Size: I will work on reducing the changes and splitting them int=
o logical commits.
>
> Enjoy your time away. I=E2=80=99ll have updates to share soon.
>
>
> Thanks
> /Ilias
>
>
> Thanks,
> David Garske
> Software Engineer, wolfSSL
> +1 (530) 409-2990
> https://www.wolfssl.com
> https://github.com/wolfssl
>
> On May 9, 2025, at 5:22=E2=80=AFAM, Ilias Apalodimas <ilias.apalodimas@li=
naro.org> wrote:
>
> Hi David
>
> Hi Denx,
>
> We at wolfSSL have developed a port for wolfTPM in U-Boot. The patch allo=
ws using the current built-in TPM 2.0 support or switching to wolfTPM via C=
ONFIG_TPM_WOLF=3Dy. It also supports TPM 2.0 firmware update for the Infine=
on SLB9672 and SLB9673.
>
> I think there is probably some more cleanup and testing needed, but I wan=
ted to submit this to start the discussion and see your thoughts.
>
>
> It's easier if you CC the appropriate maintainers for each subsystem next
> time!
>
>
> The wolfTPM library is GPLv2 and added as a submodule. If the license or =
submodule is an issue let=E2=80=99s discuss! I=E2=80=99m positive we can re=
solve anything.
>
>
> We recently added a few external libraries. mbedTLS and lwIP. Both of the=
se
> are pulled as subtrees, so I'd like to stick to that.
>
> I briefly went through the patch and I don't disagree in pulling an
> external library as long as it's reasonably stable and will continue
> to be maintained. A few questions since I am not familiar with wolfTPM
>
> - Have you made any size comparisons wrt to the final binary size?
> - Does wolfTPM have stable releases that we can use?
> - Is there a CVE policy ?
>
> The current patch is quite big and I honestly don't have time to go
> through all of it in detail. I'll be away next week, but I can give some
> general feedback in ~10days. The easiest thing to do is try to split it
> a reasonable amount of patches -- and only include the bare minimum of wh=
at's
> required to work.
>
> Thanks
> /Ilias
>
>
> Attached is the patch based on latest master 3b6760ddeb4 to review.
>
> =EF=BF=BC
>
> Thanks,
> David Garske
> Software Engineer, wolfSSL
> +1 (530) 409-2990
> https://www.wolfssl.com <https://www.wolfssl.com/>
> https://github.com/wolfssl
>
>
>
>
>
