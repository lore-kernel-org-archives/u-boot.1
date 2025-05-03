Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB4AC369D9
	for <u-boot@archiver.kernel.org>; Sat,  3 May 2025 09:01:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC83B820F6;
	Sat,  3 May 2025 11:01:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TgHgXfHd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F12E082102; Sat,  3 May 2025 11:01:34 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A55C8810EB
 for <u-boot@lists.denx.de>; Sat,  3 May 2025 11:01:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5f6214f189bso5320351a12.2
 for <u-boot@lists.denx.de>; Sat, 03 May 2025 02:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746262892; x=1746867692; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SPWQZ2stscSxgzKVNXHriXHTLaoPXuVdWExihRNeZXU=;
 b=TgHgXfHdKctaf550kLKdX3bVo+o7admjlJMLjkw7+4gJ0IcPSmXwKqCYutziid7oE6
 AtzJRiHImX6DNyQLcjHb/+7h96vOGFx1pVNXx33dxCFIGhSJGNYffYt6ylaM7CoAe+no
 zRRa4LNhCYh5jAH8ibWohmdtuzz0AunuHxZvvoO3VA96gG5i4d5TJKaVkyW9PmsvWSD0
 vxV7v3KbGdPtN7d7mYWjc1Sx7bwi3Pe5nTh+GLPLpDV1WFYsiZp7fg866M8tcP7Lnr2q
 BxUo+vyzTkFJjySUM9eG/JCiEiRlRnGQN519sHaUPUTBNxaL5qCTZ0zf9AVmlAlsVkSe
 wIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746262892; x=1746867692;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SPWQZ2stscSxgzKVNXHriXHTLaoPXuVdWExihRNeZXU=;
 b=EMDNlF1comDgIg1r7a6oqLSGdoS/lkwak0TwSAzRzIbVkTDZYjBlolXfjw0DR2X6yg
 t2exBAwy6ihCu+Jw3Slufrj2bkgVXC2Oc0ui8fusqaavPoV1w1DbufynvGpjeOcKMfj7
 Xvrtj/SK6OuW7F6s2pGLXEqWSotCY3htkpZ4t70oH0CAiQEEdAmgrgBmMO2uEg/Zgczv
 nPABYkuC8qqXko6j6K53M4KBEz3Y52QNmNAb2Ls1AxbUakNzW6hA/XWHfL+gbVPzVKBj
 jMHpHYqLn7ZRzcXMpVXfy0K0ZqY+dMtkaOfr58tHP3zebah6cm3v9wawGUxKTQUKJu2O
 uRlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVn+5E09vfAhgoSx8l6k5ittvHPafirQVz/OZ3z4NC4/kkG36L7EQ/XvJl8apT6Ex8gddO/w8E=@lists.denx.de
X-Gm-Message-State: AOJu0YyBl1/CVK8WYBK+q+a4KoBM86nfIz0ra4NOzq3rZ+KWgXL7Fy4d
 NpnWMe2I0tfxZAstPbyWIeDWNdwZexZepX4xcUWkN4Ykinv4o+oX4tS87f4b9BmM1FdpvVpTfQB
 GmKi2K0lMLc+Zzk+C/mh3mSaxZwzjwohu
X-Gm-Gg: ASbGncszDlf2m5ICaD2VaoL/Mk+R1ARUiNpWe5NF0NfjEAzGnS7AwkcTbVgnPzTu+RC
 GyO06pB+Kh/NAHRyNfbBoQghUsu3M7SflI8JyUT1jhK0f+lRlG/r1kGxDIkwjEylDtX/leKU37E
 9guulGuT42h59BCfjTAPS5cCzBfAB/GOXzK1P2Lkq1oFDrVhLJ4/knhP0=
X-Google-Smtp-Source: AGHT+IHH0O514s1Spjl4oixhwIDkZOWdzsjAhFHHP7b49c0yj4XhOK1M4W5MMF75Q38xRbdxTP2Nvcs3RPEibNT3myA=
X-Received: by 2002:a05:6402:2111:b0:5f3:4ac5:9e58 with SMTP id
 4fb4d7f45d1cf-5fa788c08e8mr4764913a12.22.1746262891811; Sat, 03 May 2025
 02:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250418125111.2193434-1-sjg@chromium.org>
 <20250418133315.GJ5495@bill-the-cat>
 <CAFLszTg45QDjKT=5JH=Cpoy6Efv8KSPQbQ6KnA8QE6nM_bk+xw@mail.gmail.com>
 <20250418140844.GP5495@bill-the-cat>
 <CAFLszTgBpMt+XsrDHQz18nF7nOAZevHLQC1Jwv=-1a9yFzoq2Q@mail.gmail.com>
 <20250501145918.GF1261075@bill-the-cat>
 <CAFLszTj24JPD+tC6LiP9z_o01PbBOy9Yyqqzmfk3P_Bc5nnWoQ@mail.gmail.com>
In-Reply-To: <CAFLszTj24JPD+tC6LiP9z_o01PbBOy9Yyqqzmfk3P_Bc5nnWoQ@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sat, 3 May 2025 10:01:20 +0100
X-Gm-Features: ATxdqUFxeQcdbHUWnms6URJY3a9rXL-P_jhTBrnzkwcBOVgcCMvyA9C7GEdBs-I
Message-ID: <CALeDE9M_QOKfYmkwxwiMJ+AtkBVmPD9es+RLX6WBxqNuN2iXfg@mail.gmail.com>
Subject: Re: [PATCH 0/3] booti: Remove the SYS_BOOTM_LEN limit for booti
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Jonas Karlman <jonas@kwiboo.se>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 1 May 2025 at 16:03, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Tom,
>
> On Thu, 1 May 2025 at 08:59, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, May 01, 2025 at 07:06:03AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 18 Apr 2025 at 08:08, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Apr 18, 2025 at 07:46:59AM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Fri, 18 Apr 2025 at 07:33, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Fri, Apr 18, 2025 at 06:50:59AM -0600, Simon Glass wrote:
> > > > > >
> > > > > > > This series restores the original behaviour of extlinux booting linux
> > > > > > > 'Image' files, which is to ignore CONFIG_SYS_BOOTM_LEN and instead uses
> > > > > > > a limit of 10x the compressed size.
> > > > > > >
> > > > > > > It also adds RISC-V support, since it uses a similar format to ARM64.
> > > > > > >
> > > > > > > Future work should integrate the code in 'booti' into main 'bootm'
> > > > > > > logic.
> > > > > > >
> > > > > > >
> > > > > > > Simon Glass (3):
> > > > > > >   boot: Add a function to check if a linux Image is supported
> > > > > > >   bootm: Add RISC-V support in booti_is_supported()
> > > > > > >   booti: Allow ignoring SYS_BOOTM_LEN with the booti command
> > > > > > >
> > > > > > >  boot/bootm.c    | 31 +++++++++++++++++++++++++------
> > > > > > >  cmd/booti.c     |  1 +
> > > > > > >  include/bootm.h |  3 +++
> > > > > > >  3 files changed, 29 insertions(+), 6 deletions(-)
> > > > > >
> > > > > > This is like pulling teeth. We aren't ignoring SYS_BOOTM_LEN so much as
> > > > > > it was never relevant here to start with. The documentation
> > > > > > (doc/usage/cmd/booti.rst) has explained that we use 10 x
> > > > > > kernel_comp_size for the limit. The "bootm" namespace has largely been
> > > > > > about uImage (and then FIT images when not using it's own namespace)
> > > > > > images and not applied elsewhere, which is why bootz/booti handled
> > > > > > things outside that namespace. And then, still, this series doesn't
> > > > > > unify cmd/booti.c with your changes, it just introduces duplicated
> > > > > > functionality, which is generally understood to be a bad thing.
> > > > > >
> > > > > > So again, please do similar to what you did for cmd/bootz.c and that
> > > > > > report and move the existing functionality over. We can then look at
> > > > > > cleaning it up (which should look like / abstract what we do for
> > > > > > compressed FIT images) as a follow up, in order to make bisecting any
> > > > > > regressions here easier down the line. Thanks.
> > > > >
> > > > > Well, I still don't understand what you are getting at here.
> > > > >
> > > > > The existing functionality for booti is already there. Marek added it
> > > > > a few years back. Can you please be more specific as to what
> > > > > functionality you think is missing?
> > > >
> > > > With:
> > > > https://patchwork.ozlabs.org/project/uboot/patch/20250409155723.431102-1-sjg@chromium.org/
> > > > You moved the functionality from cmd/bootz.c and over to boot/bootm.c
> > > >
> > > > You need to do the same thing here.
> > >
> > > That code is already there. Here is the code you are talking about, in
> > > cmd/booti.c (which is a hack, BTW)
> >
> > Hey, thanks for insulting my code, BTW. Best way to make sure I really want
> > to take your way of refactoring the code, rather than the way I asked
> > you to.
> >
> > I'll look at this again tomorrow.
>
> Oops, I didn't know it was your code, sorry.

Simon, does it matter who's code it is? You shouldn't be insulting
anyone's code!
