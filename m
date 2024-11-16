Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A66DAD68BE4
	for <u-boot@archiver.kernel.org>; Sat, 16 Nov 2024 07:40:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA005891B1;
	Sat, 16 Nov 2024 08:40:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MklQvXnc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54A4B892AB; Sat, 16 Nov 2024 08:40:01 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EB9C891AD
 for <u-boot@lists.denx.de>; Sat, 16 Nov 2024 08:39:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a9a850270e2so56572266b.0
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 23:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731742798; x=1732347598; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CjoRjtbFGyZQAvDw16ML1Sc1+c51eRfE9CpJtZGWNNk=;
 b=MklQvXnc5fR/4zSLJMg5dGS3CQbB686KaV0foTw4zh6KXX9A0GomRbr7hjUnDS/ydf
 +LbEOcRVVNBvZ9zy4RwSKl2t+Lx+xgvE3hKpaai1PJjPuWvYDOfXVqogID8BxxAtjw4J
 djUoHSn1ApBVZ5JnwmFF1XT01zMhL5v4Ko+yJb24+JN0ZB3Kg4BJWtKlTYGxEI7fMYo2
 dP7MqZZpdCXZPQbs3e2M9OJsL8rWChCkCZqItXiG7OOPO7zq4TIj6+KXhyKml1Q/tbQv
 oQXV3v6n5MchuqL0ZFTmubqLV0Qhu5AndmqXkVVvq2kESqUj6Qhn7JUQfnO/ZHaaIZzQ
 rqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731742798; x=1732347598;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CjoRjtbFGyZQAvDw16ML1Sc1+c51eRfE9CpJtZGWNNk=;
 b=OZEDX0Nx8ZzFctGLpmNhxT6/Rw73jJ9Bas0Nir3iQIVehw8KNGN86b7VK3jgXdCOfN
 h2FqoEGuBEJ+4S5eu6xFHMmR1AO0dMWAe1jOYNF4UBpTVCv1YmmZkROoexGOUIHOAzfk
 1oYJv24j7wEhryFmvgLewEvqMHFo3toSw0rcby/kq2nn/hioSHvt0S6VB1M99CpmgplL
 g/TEP1aK/dMmaV/fFIJZpyqQ038Xg0X/nWfH4BbVTdWfiWBTlyVy9fOKFGlDuQ6iO8yj
 gIw4Ks1iO/8utWmPPe51ErUcxIqp7khu1iepyMjZAsj8/9YqqW2Xl92MtI8m+6mwLB8Z
 YDLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPT8oDFCDGFlgYPQA7pbvwGWsqcX4vt+yQZw4bDCdkTdi+xgsor9EMTxULWFt6DrfFyKWQZj8=@lists.denx.de
X-Gm-Message-State: AOJu0YwhBMcs1e9/A3qDxwo1/4mZb+/HdC9J8Aiol6NYdG7ebII+8UJz
 SlC0C7QHvnOXNtDykBRjBlzbAh1um3gQJl1xig6gAbHhtOC2TItneFyBOCHdsbvRgDVTjplqVtS
 oiLLMLkbM+muwozqIz/M/a2VagM7x9g==
X-Google-Smtp-Source: AGHT+IFT2yTpSCIaZQJRckA2fF2Xj/hEJrifVX2Xud8PQJC9kNgE5z0xb5iKVbmkNtVRAau1CjEUW66obxvsl91GA8o=
X-Received: by 2002:a17:907:9308:b0:a99:46ff:f4e6 with SMTP id
 a640c23a62f3a-aa48357f73bmr455306266b.61.1731742798227; Fri, 15 Nov 2024
 23:39:58 -0800 (PST)
MIME-Version: 1.0
References: <CAJaLiFwvFVOKYpAQLSNUqAfVHCsPcxo6g74JGunw8HSQTMCFLA@mail.gmail.com>
 <20241115141748.GS3600562@bill-the-cat>
 <CAJaLiFx35Q8L-kR02GrA1PTd2nY699KMc2fy5fT381Khg5hgxg@mail.gmail.com>
 <CAJaLiFy2oo2fp-08qJni8srUn6RErgGgZs_A3GGPJuD0+=YsOw@mail.gmail.com>
 <CAEfUkUJOd03fc5VERRPY18LWMomEbYFRnkHSJcFLcdnPq4=8jA@mail.gmail.com>
 <CAJaLiFw134mzZk7TkJMgAppx11Xv3qZsbU-Y78XimX8jNbJtMA@mail.gmail.com>
 <CAEfUkUKp9wWhgBW2XFubhoccSGeU-CW3Y+FY+iJhfw7eVLZv_g@mail.gmail.com>
In-Reply-To: <CAEfUkUKp9wWhgBW2XFubhoccSGeU-CW3Y+FY+iJhfw7eVLZv_g@mail.gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Fri, 15 Nov 2024 23:39:46 -0800
Message-ID: <CAJaLiFzTjHWCw+ioPZv660yQ0XLM6+SMJh3NV=NYivbtE1Uf_Q@mail.gmail.com>
Subject: Re: Git commit failed with mbedtls/framework
To: Raymond Mao <raymond.mao@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Raymond,

On Fri, Nov 15, 2024 at 1:55=E2=80=AFPM Raymond Mao <raymond.mao@linaro.org=
> wrote:
>
> Hi Tony and Tom,
>
> On Fri, 15 Nov 2024 at 16:35, Tony Dinh <mibodhi@gmail.com> wrote:
>>
>> Hi Tom,
>> Hi Raymond,
>>
>> On Fri, Nov 15, 2024 at 1:09=E2=80=AFPM Raymond Mao <raymond.mao@linaro.=
org> wrote:
>> >
>> > Hi Tony
>> >
>> > On Fri, 15 Nov 2024 at 15:32, Tony Dinh <mibodhi@gmail.com> wrote:
>> >>
>> >> Hi Tom,
>> >>
>> >> On Fri, Nov 15, 2024 at 11:27=E2=80=AFAM Tony Dinh <mibodhi@gmail.com=
> wrote:
>> >> >
>> >> > Hi Tom,
>> >> >
>> >> > On Fri, Nov 15, 2024 at 6:17=E2=80=AFAM Tom Rini <trini@konsulko.co=
m> wrote:
>> >> > >
>> >> > > On Thu, Nov 14, 2024 at 08:26:33PM -0800, Tony Dinh wrote:
>> >> > > > Hi Tom,
>> >> > > >
>> >> > > > I am on 2025.01-rc2, and I am trying to commit some files. The =
error
>> >> > > > seems to indicate this framework directory might need some
>> >> > > > modification. Did I miss something?
>> >> > > >
>> >> > > > error: 'lib/mbedtls/external/mbedtls/framework' does not have a=
 commit
>> >> > > > checked out
>> >> > > > fatal: updating files failed
>> >> > >
>> >> > > That's odd. You didn't happen to try out some of the previous lwI=
P
>> >> > > iterations on that tree did you?
>> >> >
>> >> > No, I did not. The tree is clean with "make mrproper" and on the
>> >> > master branch. I just did a git pull and worked on it.
>> >> >
>> >> > I went and looked at https://github.com/Mbed-TLS/mbedtls.git. The
>> >> > framework directory is pointing to a specific commit.
>> >> > framework @ 3867faa
>> >> >
>> >> > I'll stash and repeat it on another clean tree.
>> >>
>> >> I have the same commit error on a brand new tree.
>> >>
>> > I think you are talking about the test framework of MbedTLS's original=
 testsuite,
>> > am I right?
>> > MbedTLS was ported into U-Boot as a git subtree and that framework is =
a git
>> > submodule of original MbedTLS repo which was not included in the porti=
ng
>> > of U-Boot since U-Boot has its own testsuite.
>>
>> Here is what I found.
>>
>> git clone https://github.com/u-boot/u-boot.git u-boot-master-test
>> cd /usr/src/u-boot-master-test/
>> patch -p1 < ../builds-u-boot-marvell/sheevaplug/sheevaplug_bootstd.patch
>> git add .
>> git commit . -m "arm: kirkwood: Enable bootstd and remove jffs2 for
>> Sheevaplug board" -e
>>
>> The git commit above gave out this error:
>>
>> error: 'lib/mbedtls/external/mbedtls/framework' does not have a commit
>> checked out
>> fatal: updating files failed
>>
>> So I tried to commit only the specific files, and it works OK.
>>
>> git commit configs/sheevaplug_defconfig include/configs/sheevaplug.h
>> -m "arm: kirkwood: Enable bootstd and remove jffs2 for Sheevaplug
>> board" -e
>> [master 47de8cff2d] arm: kirkwood: Enable bootstd and remove jffs2 for
>> Sheevaplug board
>>  2 files changed, 17 insertions(+), 19 deletions(-)
>>
>> I think it must be what Raymond said above. So perhaps during Tom's PR
>> pull, the framework directory was created. But "git commit ." does not
>> like the empty lib/mbedtls/external/mbedtls/framework directory.
>>
> Under the native MbedTLS git repo, by default it has a "framework" pointi=
ng to
> its git submodule.
> Maybe we should mark it in the gitignore.

I've tried .gitignore but could not make it work (my Gitfu is pretty
lousy). Can you suggest how that should be done?

Thanks,
Tony
