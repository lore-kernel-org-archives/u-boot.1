Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFFCCD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 18:14:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 421CF847C5;
	Fri, 15 May 2026 20:14:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kpCgXVB1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33252847C8; Fri, 15 May 2026 20:14:06 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A6CA846EB
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 20:14:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-67c2b4809baso286416a12.3
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 11:14:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778868843; cv=none;
 d=google.com; s=arc-20240605;
 b=aMAPl9MoPfUApupsT29YTkZnfVFc04nO8S+qszea0+jSHoRw35C3GM5q4GsNXqkc8v
 UjhgmxlkrOWwzOYmdkap0bINhYaHbPTkUopTSm5YAmUbn0vSqT3/xgmMtiDn6bCTT3fn
 diVir/QMsQXK8416OL4fWPDpwoIj/RpEvqpY7wE47A5rtYLLYJszB+eAHTYMxySIkBlH
 3uHHEDQDf0llF0Fmed0/UMLu7ILzUlgVC/NID0GbxVuidCGSvh1RPZuoOj0Tk+LA1xrP
 ++FK5YiEQwu51OqQaU3nE2TF2GMtuKFPMBiKBSh4TXmO0plVy4dqKEx2MKpwddipdpkg
 C5ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=iYeG4p7Og0eFPNnamM/FAXHll02rF4aGE84QUdNJ60A=;
 fh=VpqWE6ZviGwzWSN3dFKCcvVG/KAuzDlngrxh7UWDT/0=;
 b=Gu92LXnElnae5lBhzz7vaONSQg1xWtYoXilK6PZqYLNinKtJk2hIisLD6i1uj55120
 d0FUxiTddzcojmUQSODeusYGo1fnzpFlbZU4vBgh5b/cQPWC7uSULn8WGcrGRSMEyxut
 VftI5vK/3/6yuRfiGK4/Us3vvm0PRMkUb40EwpHzsdC2e37yqb791myD1wSqxKmjgOOm
 D8W8C20DNibVIiWK4dipNLmg8N4s/1X959WCtWPZlnPMjNTT6MEp2z4JbXd8EdRr3NuP
 99DQQHVe/YeeyCEcfPjcPFb0FjtK8EarHpwQrjfoto45wTJz0h3Ac/J39RQ8bDzjTh9v
 Ex/Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778868843; x=1779473643; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iYeG4p7Og0eFPNnamM/FAXHll02rF4aGE84QUdNJ60A=;
 b=kpCgXVB1I0sac4ZlwWy1dAbhhzsxakaZIahNE1BYbrsL2ccnufWxwms9ULYQ8DwndK
 WwnzPVDVLnSEzlZOmhEKeAUQjla2C+Oi+ZHGNhUlZtYo3aj5vpBrLQhPaHyuFid+lsaP
 0dMzQKZ7ke9PuoVl4waIglqgbkq/1kPUAzt6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778868843; x=1779473643;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iYeG4p7Og0eFPNnamM/FAXHll02rF4aGE84QUdNJ60A=;
 b=f4+j+SS0sv9raTr/BasSZAFxE9m/zQDon9TGEiQSnylQXKeyK2FfoSxI7gfVKHHiK9
 s8cJjsMdwag3vc6ggcxNEOeFY+1GIli5SttFzs0u5w7kYM+hryyWOOAcj5PPDqIVfPvt
 Ib03g/8Ots7oLroyobCZML4Wv4G7VXOQ1Ajx/V7zF1GcsAnN07ZXUSNPOZ/Zaql5zVzZ
 XQxAaXtfpRDUb8I5TYRuWG/tupI47gnKBaZ0TFTd1+kHDGI3XmpEtEY0dx+RQwjNx1Kt
 39UxiFYdMAvFG/txb+AOltWQrevoiZs1CgtHpYi9O+WM9y99l1eT8jNd8DE7wjR6EEgp
 cGVA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+mSDjvsPfvsvvbfEcv1GdRFUpwSros5+G4an/h08MAjkiIe8KjPRs8t2Lfu81Hw/pW++VJQD4=@lists.denx.de
X-Gm-Message-State: AOJu0YycVnK09ccg5CMWAqR+oQEW/t/A09WM3fjS1NI6PELUx0nJUgEc
 zFBmwZw0yazegbuLiuPYlCCTh4v/CvlhgxASg1tVzT6GNb9U9WAu65CSiwtZ/0lDh7twicDyykj
 /a3J+Sg96AdVTcaewl/gOlWIedUZGCs9DjdIbEENm
X-Gm-Gg: Acq92OE86vsdpLcFFs/Rtk4TwJogx3NzezHrSuUtDeS2RnzGbqbtGhYwPJiMJ+M+No5
 9IRoI1Xtey1rvYKWfLGAATAnl05mNYUgkacVWVv0WB2z8U7ZThLkl+p+uM+sX4XfJ8UZIsTzuD7
 aujcs61GF8Tzyo0F45+KYB24oBXr2Ituk0y0vz/43SZwmaT3b7fptI6oLajzGXWGD0ZzZOkeRmu
 Jnihe14pC2jyP137fp1Oi9rm+Rd9vO2+ZIQ3hBglBL7p+8gmxq1uXDBLMIEXAs5Yg6ZmrFmBfby
 mezTXQ==
X-Received: by 2002:a17:907:3e9d:b0:bce:6d1e:501 with SMTP id
 a640c23a62f3a-bd51777b3e7mr296727866b.6.1778868843470; Fri, 15 May 2026
 11:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260515054327.1033466-1-w.egorov@phytec.de>
 <20260515145400.GB1858239@bill-the-cat>
 <CAFLszTid-e+NWrFxoorfrUT23_mztUZP8FRbmT9FJ55M8A+FXA@mail.gmail.com>
 <20260515160256.GF1858239@bill-the-cat>
In-Reply-To: <20260515160256.GF1858239@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 12:13:50 -0600
X-Gm-Features: AVHnY4KCoq3bHLZlZIhbgefU9Uz_WBsaTTtWxVbEYzsomadGzNB4YSQ6IW0DfAY
Message-ID: <CAFLszThfUMe=67xwzbv6TvugH3iCOO=-EoYk6oUshKru-wpDQw@mail.gmail.com>
Subject: Re: [PATCH] Makefile: binman: Search board directory before srctree
To: Tom Rini <trini@konsulko.com>
Cc: nm@ti.com, Wadim Egorov <w.egorov@phytec.de>, ilias.apalodimas@linaro.org, 
 marek.vasut+renesas@mailbox.org, sughosh.ganu@arm.com, u-boot@lists.denx.de,
 upstream@lists.phytec.de
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

Hi Tom,

On Fri, 15 May 2026 at 10:03, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, May 15, 2026 at 09:35:10AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 15 May 2026 at 08:54, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, May 15, 2026 at 07:43:27AM +0200, Wadim Egorov wrote:
> > >
> > > > A file like rm-cfg.yaml accidentally left in the source tree root
> > > > shadows the board-specific copy. binman builds the wrong YAML, the
> > > > resulting rm-cfg.bin may match a different SoC, and we end up with
> > > > the following error:
> > > >
> > > >   k3_system_controller sysctrler: k3_sysctrler_start:
> > > >       Boot Notification response failed. ret = -110
> > > >
> > > > Move the board directory ahead of the srctree root so that the
> > > > most-specific match wins.
> > > >
> > > > Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> > > > ---
> > > >  Makefile | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/Makefile b/Makefile
> > > > index 552328f9f2c..1ec29dfe0be 100644
> > > > --- a/Makefile
> > > > +++ b/Makefile
> > > > @@ -1682,7 +1682,7 @@ cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
> > > >               build -u -d $(binman_dtb) -O . -m \
> > > >               --allow-missing --fake-ext-blobs \
> > > >               $(if $(BINMAN_ALLOW_MISSING),--ignore-missing) \
> > > > -             -I . -I $(srctree) -I $(srctree)/board/$(BOARDDIR) \
> > > > +             -I . -I $(srctree)/board/$(BOARDDIR) -I $(srctree) \
> > > >               $(foreach f,$(of_list_dirs),-I $(f)) -a of-list=$(of_list) \
> > > >               $(foreach f,$(BINMAN_INDIRS),-I $(f)) \
> > > >               -a atf-bl1-path=${BL1} \
> > >
> > > Why do we need to look in $(srctree) itself?
> >
> > See for example:
> >
> > arch/arm/dts/k3-j721e-binman.dtsi:308:  private-key =
> > "arch/arm/mach-k3/keys/custMpk.pem";
>
> That's not great, I'm sorry I missed it at the time. I wonder how easy
> replacing that key is with a non-dummy key. Hopefully it's done in a way
> that doesn't encourage checking private keys in to repositories..

Typically we would use an environment var passed in from the Makefile,
as we do with BL31, TEE, TI_DM, etc.

>
> > Also, people sometimes put files in the source tree, e.g. BL31 images,
> > in the hope that they will be found.
>
> That's also a bad practice and what BINMAN_INDIRS is for.

Yes, but that came quite a bit later with the bintool stuff (2021).

Anyway, with a bit of work I believe we could drop the source dir.
Would you like to look at it, or should I?

Regards,
Simon
