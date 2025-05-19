Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F928C3DA6D
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 08:53:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A9CB8277D;
	Mon, 19 May 2025 10:53:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="o1WA06DM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88D7082A0A; Mon, 19 May 2025 10:53:09 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 141C8803DF
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 10:53:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-70dd29b0d34so2667517b3.1
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 01:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747644786; x=1748249586; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Io9MqxyaSmgJ6oh1BIHF0IJKMxbokAg1yBt6xIm7Y84=;
 b=o1WA06DM2YPHr0iOkwgSCSX5vki6/SiB+ZYkcvrb2trwpop0beNcEdzdIZ377yMH5/
 yoU1JQV1wVYGiK+fS17AD+C2SMebiDMfKyZrFLEUhDFNWXbeEyg8YL09TIamzfpcwl09
 02XBEDR7CT1qw4/C28duEeUn9zwajiJSD0oRoz9KuzmQmYLGKtiKqNNpWAAlYUHlGTr1
 3WR/65/UOujPTVgVXmoWKHiURw8dhBli2edEaPIZ/FFLfsZTYU7FEeamLbAWYZgLssIr
 I2c+1ysalqzHVLBKxopOYCbVMpB3s7GsJ8vROCNzRqC4jz2Mh/0ImkRP1VHJDtLUYMyi
 r90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747644786; x=1748249586;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Io9MqxyaSmgJ6oh1BIHF0IJKMxbokAg1yBt6xIm7Y84=;
 b=Kc2/brKv6ujOHklWHcTmOE5a90zfAblfWNCDaApDulqJY4r+6Dj6Xc14hdD/Xjcd7N
 sxvcOOssJwqICXBWuxalxMQSOCLhj7RCjiB3NfOQOPsTV+1YT8kRNQreHoPBp6/mwdas
 rvl31e53Xwm3reFUjyM1eKAfr10jgBkho4aqbUnHKPA3TDUW60hQHHjNxAaofxZIP9GF
 uixGgmLEA63BesFFyMXFeFlXDZkVeJ3Q/dOueM6HfTBlEUN5POuJTJyZhvf3Lak+tdIy
 qPNRcZFRySiE+7pU4OiT6P52IGFN+S76DpBcAokHSYSibhOJu+N296nfCEEQZSr+HeK/
 m6Cw==
X-Gm-Message-State: AOJu0YxvgU5B0XM7U/i6Qu1sV8JL98jQt+fH0Mc8tdsq5fal8gIbZh9K
 tgfVz7anzv0Wc4ICI28Q9WO8UJUgFH6whqKMFGM3+7Kq7BP4qLz7l75ZjpmsgqwEnLIUsjMAOpO
 gZzxhzE5M7FDjgCrzf0JjUfw4Db1OavvxuvUA7kikcw==
X-Gm-Gg: ASbGncsyE5FE0XvtVpuaR37jORjV4qXOF6xbXDJafF6ZzDLJ+fbnY6Mh/h8BuKKbfL/
 4PolZqB0NElAl5VDJE+FHIWWRWjWzo8tlvVo3KDwBH3AdM+qLYhew7yP7KdkjirwJ47YXl63W8e
 WXTKzFRNJrsTKMYg2G7u5fQleeCaNk2YgzsEAkD/eTk/PO
X-Google-Smtp-Source: AGHT+IFzJmGJSr3iJMiIWDtrhlpX6WOd5DjjLJgtlXbra7Ob4TKNGM542g4o4t2qheeql1sZDhWa2FXTwecBkD44gxQ=
X-Received: by 2002:a05:690c:a96:b0:70b:3e8b:a1d0 with SMTP id
 00721157ae682-70c8fd19ca8mr210449647b3.5.1747644785863; Mon, 19 May 2025
 01:53:05 -0700 (PDT)
MIME-Version: 1.0
References: <145501C2-B034-44EC-A16D-4F1A150347FB@wolfssl.com>
 <D9RMK91R8Q2I.3BA39TM77AYZA@linaro.org>
 <AB2FA403-CBB0-44F6-AC75-4A70B3E9242B@wolfssl.com>
In-Reply-To: <AB2FA403-CBB0-44F6-AC75-4A70B3E9242B@wolfssl.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 19 May 2025 11:52:29 +0300
X-Gm-Features: AX0GCFtweLkimETYnz-vHQB0PekuT3Tca9sz3iuCsvsAXpT5U1wUGcfk8sSBkP8
Message-ID: <CAC_iWj+mH2jywAYA_cBOqBnk+pvH-+r4nwL7SD8HGDbdmu284g@mail.gmail.com>
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

On Fri, 9 May 2025 at 18:43, David Garske <david@wolfssl.com> wrote:
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

it's in MAINTAINERS. I am responsible for TPM

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

Thanks
/Ilias
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
