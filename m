Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99196D68BD4
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 20:32:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DAEE89356;
	Fri, 15 Nov 2024 21:32:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KfMMRHhg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0EED8933F; Fri, 15 Nov 2024 21:32:18 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFEA38938D
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 21:32:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5ced377447bso2991725a12.1
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 12:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731702736; x=1732307536; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rvSkyJ+N/bCiSDm3JfQP5FHoAj3pndGVkHvIv1E8uHw=;
 b=KfMMRHhgVeMIyiv89zPHDg2HSltjsyCWwRjNPWGTtiVcio3JcWyR56Q+gRwepJQzbw
 fQlAeHChH6Xj1erkI8iZZlWV7b+hpqVjYilasaLF2mkrOkl/ZA6w47BoicUs+aJgLfdi
 qQrQdu6LsC+r7aJi0oBCsd4bk1WplbZ8qZvoCE+MvQyGmeToaovvqSLQ6amRLyn06gce
 fC86k4YHJC94vvWm2892fQca7npSSoC3r4vkNSgP+LEFcH0tOUoRS3FL6REKdXzffmsj
 SSJJLL3uaN2/M0eAOqbTkuWhp3uNlcZyABwsbiZVi6vPVKzXxRDkrN2nZfedX7GFnUxS
 9rrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731702736; x=1732307536;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rvSkyJ+N/bCiSDm3JfQP5FHoAj3pndGVkHvIv1E8uHw=;
 b=KCd3w3fQ4s8icmlqykVZS7vl/yxrBGG7pd7BUdMW7LeEJ7bwyhFjIvr7PLzzTdhkl5
 hJbQLSRUZ7W50o0v45rqEsa4CGuhhIcDs83xhrCw1nZQAp4SmmTp7T8OJjujY3Eyr4uH
 HS1JqgH/czt7E5xJ9cfPjTVMgu5hplfcSmQVesQcDKriX8rikVKzOifjGpbyhGmPeH1b
 KdzYJcukC/KsLyUhUoBT94tED9OBx0PdsGaNZR5VJPniSFj2D5WgBVG/RMBe57zxI23D
 JUSh3SWgl9ahqioBS6qiZ0fEIVvZOb+cqJqjQd+/caipAU2jQTecZ42F6ohUEeYnKRIq
 4RMQ==
X-Gm-Message-State: AOJu0YyURf3aewVJ0joNzaTbzlPN/sOfl0CNBOOP9NYp2//C7tCE/Lj5
 h9+d5Qt/70PMrnoRDYrLboHgMfEwCWNRoJqyLFMKo6AD/kLlA4M5gR+MRkOV/0/suwQ4qqJokk2
 /YtD2Uf7boU0ONgiNulSoo0K+l6M=
X-Google-Smtp-Source: AGHT+IEi4LmkV2x901tbBpCbeDXzZdi2EGKE4bSaHFesVTxK/a7MRBF6mKSIRzvFWei54XAuBJkwE4gb7/hjYPVZA/8=
X-Received: by 2002:a05:6402:1ed0:b0:5cf:8b6a:1b6d with SMTP id
 4fb4d7f45d1cf-5cf8f94bb0dmr3323329a12.0.1731702735885; Fri, 15 Nov 2024
 12:32:15 -0800 (PST)
MIME-Version: 1.0
References: <CAJaLiFwvFVOKYpAQLSNUqAfVHCsPcxo6g74JGunw8HSQTMCFLA@mail.gmail.com>
 <20241115141748.GS3600562@bill-the-cat>
 <CAJaLiFx35Q8L-kR02GrA1PTd2nY699KMc2fy5fT381Khg5hgxg@mail.gmail.com>
In-Reply-To: <CAJaLiFx35Q8L-kR02GrA1PTd2nY699KMc2fy5fT381Khg5hgxg@mail.gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Fri, 15 Nov 2024 12:32:03 -0800
Message-ID: <CAJaLiFy2oo2fp-08qJni8srUn6RErgGgZs_A3GGPJuD0+=YsOw@mail.gmail.com>
Subject: Re: Git commit failed with mbedtls/framework
To: Tom Rini <trini@konsulko.com>
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

Hi Tom,

On Fri, Nov 15, 2024 at 11:27=E2=80=AFAM Tony Dinh <mibodhi@gmail.com> wrot=
e:
>
> Hi Tom,
>
> On Fri, Nov 15, 2024 at 6:17=E2=80=AFAM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Thu, Nov 14, 2024 at 08:26:33PM -0800, Tony Dinh wrote:
> > > Hi Tom,
> > >
> > > I am on 2025.01-rc2, and I am trying to commit some files. The error
> > > seems to indicate this framework directory might need some
> > > modification. Did I miss something?
> > >
> > > error: 'lib/mbedtls/external/mbedtls/framework' does not have a commi=
t
> > > checked out
> > > fatal: updating files failed
> >
> > That's odd. You didn't happen to try out some of the previous lwIP
> > iterations on that tree did you?
>
> No, I did not. The tree is clean with "make mrproper" and on the
> master branch. I just did a git pull and worked on it.
>
> I went and looked at https://github.com/Mbed-TLS/mbedtls.git. The
> framework directory is pointing to a specific commit.
> framework @ 3867faa
>
> I'll stash and repeat it on another clean tree.

I have the same commit error on a brand new tree.

Thanks,
Tony
