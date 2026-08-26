Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F34C61DC2
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 09:55:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 83E9580BF0;
	Wed, 26 Aug 2026 09:55:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nTbeV2bwDdVl; Wed, 26 Aug 2026 09:55:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787738101;
	bh=LaaoAIu/SU5EEs6x0Fa2UeXLRfWbJfx7C31VmP3/V6U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ETQ3Clgvbd321H+M8KnqeDQyac1q3yw+uPSix3YwupRixb6SQh6PIGlrePFWL88Gt
	 9mEKlAAiR6ZN9lIUeQTBS0jboGuv3DRQ25t0JUGY1/hZG5Jzfrm9ksaCmYkVUj9VzC
	 EAZdiI0/A2BTOVb34N1Zcoqe88DPNYK94f+DO7s5T3FrnBOgRwv9jWDzN2yw2vLfap
	 wHmQl1bvPladIvAzzhUCTTuLWSdpICCEjnPTGQHMtChRhnwbqS05lrPMDpj2q1jln1
	 LiwYOZAByBec1o5/i17scblDC4Yr+P6gVA1OfvhiQsTQYoece+TklcGI5r6NhkcG7C
	 rN8u1IhTPEYGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 772DF80BD7;
	Wed, 26 Aug 2026 09:55:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id ED8FF3AD
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 09:55:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DF7C56070D
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 09:55:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cb0ZZ5K1L2AX for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 09:55:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f33; helo=mail-qv1-xf33.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=DQj76lpJ
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 248346067F
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 09:54:58 +0000 (UTC)
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-90ccbed6edcso3950846d6.0
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 02:54:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787738097; cv=none;
 d=google.com; s=arc-20260327;
 b=sA+2MhGKe15teg4h4U2JthKSgxpvmutgnhh0XDat6b56SF58+k7NdmNf6E6W+UJxKW
 RDI0wd3cNWEUHECeKZ8iflfclLvM0jV0k0Go4fvpNo9yIXV64QjUXLfFK2YYl3vdsmwB
 Wfx344g3myMW98aawyXhHBl4wXkqebT160+Ys3czocTAqP0fgtMZ3fK0snqOryk0d6/o
 1MaTwc/e4Rx1Cqu18DWwnSEwFwAW1wxihQWO7R0zpUGBIorLE3ZVtUyL9OFcOsjCf+bJ
 nJc/sW0doFFvzrgbEum6XBGpNF4oj1YzGQ9LqzScBuuRkBSF4/tadBZGCqnDPTghHp5G
 jv+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LaaoAIu/SU5EEs6x0Fa2UeXLRfWbJfx7C31VmP3/V6U=;
 fh=JZg4BCDmw6qbNOeNsdxmIQUB3gPIipd9eGitC22fhHc=;
 b=BNlrH3m6/cG2sgI/lAA1JQNHdAoxEIm+9sfx2nhPR0VJRkvOdFjfmwoh/2cvyFW278
 ZvxK0+G3H/hgeELrudwcCnvojEXXQbCbsc3YZws5K99k+vDj2HvUlHe46ywjFXjU6+ad
 UkQlKRJCb4FIyGGJL8nS8LdAxhgn8fPapyZ+FylcLDeCKul3h8ZDMWV2nALleCDHTUzC
 YIklSj0e55LQ0JwjshWPBmgon12LTBs8Co6GIjib5jbdZEXCPfO9mT9Pd1jCv77Lczoz
 pXit8X3cXe0/+1emEQaNnK6a0wa8hOhooJm1Sv1C+xaqjQSO9PWxKPMtu4fm7Lk4Ttrq
 ZnQw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787738097; x=1788342897;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LaaoAIu/SU5EEs6x0Fa2UeXLRfWbJfx7C31VmP3/V6U=;
 b=DQj76lpJ7lK+4LY8SrQUnS/fRKjsReHIr6vAeNQMdgPpPayrrKXikIa4Bal1yIV9ur
 dqfDvCpbVg2Y/Gbl3KBhaCvhxjwv2iydHiVy8OhwbdnXI6EQjdawXz4xntSNwkw8NMUP
 QXkg5U0D+0N3MzPLfkKAmeVHbod6EbK56bApQt43dcj/I1shfaxoiKzRMeZiJvbotRkb
 lMjPaFYreai0A8dVi0HKTp85iBkfOUr8q/oFTwB//gJKlHmk+bXyKaeMmNORRdgRF8zj
 3dsxRv0uQU2LiIokIA7gCBl4x6C78nReYf/cJvHVKE6ZXo7QZqU1PMFuI1uGiV8JxbEr
 Kxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787738097; x=1788342897;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LaaoAIu/SU5EEs6x0Fa2UeXLRfWbJfx7C31VmP3/V6U=;
 b=IA0Pz13HxM+a0bTTqaUG9qx59aiP6cAFqaHCMaw8ZWu342KCh8UxJNtwrWPUB5xKQx
 KtbX32nzzTLdn8l3PZBcuS6WzBhRF3/fQqjM+7i5/2THbhOa/5lxwtMtl/Q89TOOAMz8
 TFxCgmt77/zztG6LOcjzE8p9F0QLFSrJJTkOCmbCKsFSD6dsT/HJQaDKTE53AR6uNCB8
 NkXaMc2+88jgMaZUpf9ofugTSoHpZUx18hEizawYqR7hNznMg3zDHkkRyqfQykBLka7x
 TS8c3hiK+l7tq3cDfCUF7X1NdcpAiYEiNDwrFl7UfvnVARw4tBJu+/Y89A4E29dUBLWw
 iR/w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpn3858V04K3BAwLweFG3q+z45aXlZsDqn3B7kNqTOcFbW/oSDVWwcWMNAVcL0pJMxJsAuLLVI=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nQsKHRB61rfaxQb4ZIUtcClbNvHUE0HnsaRtO7NG/yh5zZFPuH
 Wgfkv+SZ3O41IX6OqM9yf4boSKGoYqhnYbNTaLURfa42PqAbFkwVQwDLMlnigRdrIfED+2ADeat
 kdEmJO1PpyZQ7rYgoMV2ReofHc7Yf2Qo=
X-Gm-Gg: AR+sD139Y0W0JsIZSqs1Erpl8z7AK82bCJXg/tm8/J4xWNl2wWup9JGR29BTWRVuxFA
 QcS25hqYVsoK3VDsOi4Cei49/d52NoQ+/jAO+VLsOS8FTzb2vJeRG+LbfFDtmPxQqdz1uQP7ALb
 QND5vQw9iNPm1ox2a/Yzu/f54306W7wDIitxUF1BmSBc41ab6zryma62HEmPczsQio06JKSh7CR
 Zf4V76Hohi/AoSu5e0GBSKd9+2rO2OZv8HdkPIXuTuj5kRpwrC86TQjK3veJwkPMDcaoLup5GPM
 KAc+S74WxGieOxu/WexZY51Pbzo19GEjVHSMhwIQ54s2c/KRJi41pi1joHpR4J1esyQfv6HAphF
 QXhlq3ZFou6ZT5NGFoONqC3xDUsCG2B/VllBw4irDNrdoAeX/LzNADtAVeq9xFs8sy1fhpJBd6v
 XLl83EcYqUbrQxLNoWjkHM2Ei8zu5Oy2IROs9dsiRYxgLIwYzg7Q==
X-Received: by 2002:a05:6214:b6c:b0:907:5c68:54d1 with SMTP id
 6a1803df08f44-90cc79cd228mr57166806d6.18.1787738097370; Wed, 26 Aug 2026
 02:54:57 -0700 (PDT)
MIME-Version: 1.0
References: <08f68cd8c514140071090a846839632f8cae071c.1787560364.git.michal.simek@amd.com>
 <1b9532296bffb1918b90cfe61fb7692ea355d02f.1787560364.git.michal.simek@amd.com>
 <20260824163956.GH523975@bill-the-cat>
 <c012177e-274e-4c88-bc32-1ec647fad643@amd.com>
 <20260825135036.GS523975@bill-the-cat>
In-Reply-To: <20260825135036.GS523975@bill-the-cat>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 26 Aug 2026 10:54:42 +0100
X-Gm-Features: AcwNN1UCza-DpbjqSSPV2YH7HxADHAFhkR10RCODY_aUgkHvcl49WQ2wW0n2HQI
Message-ID: <CALeDE9N57vehC9F8XTnW3h-CHf=bj=8oxwS745An5iDGzBLCAw@mail.gmail.com>
Subject: Re: [PATCH 2/2] Clean up emails from non-existing domains
To: Tom Rini <trini@konsulko.com>
Cc: Michal Simek <michal.simek@amd.com>, u-boot@lists.u-boot-project.org,
 git@amd.com, Andre Przywara <andre.przywara@arm.com>,
 Angelo Dureghello <angelo@kernel-space.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Daniel Golle <daniel@makrotopia.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Simon Glass <sjg@chromium.org>, 
 "moderated list:ARM STM STM32MP" <uboot-stm32@st-md-mailman.stormreply.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Tue, 25 Aug 2026 at 14:50, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Aug 25, 2026 at 07:17:36AM +0200, Michal Simek wrote:
> >
> >
> > On 8/24/26 18:39, Tom Rini wrote:
> > > On Mon, Aug 24, 2026 at 10:32:52AM +0200, Michal Simek wrote:
> > >
> > > > There are 5 domains which no longer exist. Remove all email addresses that
> > > > reference them. Where such an address was the board's only maintainer, mark
> > > > the board as Orphan.
> > > >
> > > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > >
> > > This is generally good idea, however:
> > > > diff --git a/arch/arm/dts/sun9i-a80-cx-a99.dts b/arch/arm/dts/sun9i-a80-cx-a99.dts
> > > > index cf126bbd2c57..0642161ec969 100644
> > > > --- a/arch/arm/dts/sun9i-a80-cx-a99.dts
> > > > +++ b/arch/arm/dts/sun9i-a80-cx-a99.dts
> > > > @@ -1,7 +1,7 @@
> > > >   /*
> > > >    * sun9i-a80-cx-a99.dts - Device Tree file for the Sunchip CX-A99 board.
> > > >    *
> > > > - * Copyright (C) 2017 Rask Ingemann Lambertsen <rask@formelder.dk>
> > > > + * Copyright (C) 2017 Rask Ingemann Lambertsen
> > > >    *
> > > >    * This file is dual-licensed: you can use it either under the terms
> > > >    * of the GPL or the X11 license, at your option. Note that this dual
> > >
> > > I don't think we should be taking email addresses out of headers. This
> > > kind of information is useful in looking in to history and trying to
> > > track people down.
> >
> > That's why I kept there name. Emails are saved in history anyway.
> > I don't think having emails in headers will help with anything. They don't
> > work and they are not going to work.
> > It means if people ping that author and get nothing back it is IMHO just
> > driving them in wrong direction with unreasonable delay and hope.
>
> Having the old email at least used to make it easier to search up for a
> new one, but I see that's not so much the case anymore. So yeah, OK.

Assuming it wasn't just copied from a Linux driver where that person
doesn't have any context, the email in the git commit likely provides
better information I think.
