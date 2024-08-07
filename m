Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F908C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 14:18:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4534886E5;
	Wed,  7 Aug 2024 16:18:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="CidThazW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C6D18883D; Wed,  7 Aug 2024 16:18:56 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [IPv6:2003:a:e28:26e4::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCB0587A6D
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 16:18:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C6982148740D; Wed,  7 Aug 2024 16:18:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1723040332; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=zLHQcTDQS7PPEEXNtwFjV3pV7Qd48EgZ+j4VGYTsE5c=;
 b=CidThazWkrj24jqvDLMMQ2fn2mezWxYCNPWpe0h9Y162QIkPWyis/ZYYnWgmkAYkVmDtt/
 Y1C68s3YRURBN8DX7imdwfXJqnzgfP/sJ1Xt2UgMoJG3pMb4WEBVb8PfMlMO1d5RMncgvx
 bObmq9Y2TuBtkL0+2L3b0KqIQ7jqz+XKOd3Ohfapd9LSuS7MwrDL+mtsh4zi/OFENcmnqB
 2umGc/ii90JZqmkvePyGM1kXRhr1JmWUuV3oPU1NUNmbZeI+ROhyD0jVKEQoMKqsQO/ZE7
 iIbU3Dgu4GORWyCNekmLtNayZl0J/CzF9LWt5NfC1UmaYGEELVc7f5s8+i2qMg==
Date: Wed, 7 Aug 2024 16:18:46 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Simon Glass <sjg@chromium.org>
Cc: eden.hamilton@bt.com, u-boot@lists.denx.de
Subject: Re: Fw: ECDSA for FIT Files in U-Boot
Message-ID: <20240807-churn-riptide-7e996b2affc1@thorsis.com>
Mail-Followup-To: Simon Glass <sjg@chromium.org>, eden.hamilton@bt.com,
 u-boot@lists.denx.de
References: <LO0P123MB3929703FEE3D03E962D7E6E193BF2@LO0P123MB3929.GBRP123.PROD.OUTLOOK.COM>
 <CAFLszTimGrXLOMOheanvJaJFZZd6QujZCf7fKmG7zcEKBV3nGg@mail.gmail.com>
 <LO0P123MB3929FC2417E806A1B8F1867193B82@LO0P123MB3929.GBRP123.PROD.OUTLOOK.COM>
 <CAFLszThQ5HL7iDYoeVBBZd5aCuFGUDH3zs7+o370gBHcY2RNLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszThQ5HL7iDYoeVBBZd5aCuFGUDH3zs7+o370gBHcY2RNLQ@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3
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

Hei Eden,

Am Wed, Aug 07, 2024 at 07:59:39AM -0600 schrieb Simon Glass:
> Hi Eden,
> 
> I don't see it on the mailing list yet[1].

FWIW in case you did not notice, there's a patch series for
barebox currently worked on implementing ecdsa support for fit image
verification.  Maybe that can be helpful for this task?

https://lore.barebox.org/barebox/ZrG9pjqsnWBvfkE2@pengutronix.de/T/#t

Greets
Alex

> 
> Regards,
> Simon
> 
> [1] https://lists.denx.de/listinfo/u-boot
> 
> On Wed, 7 Aug 2024 at 02:21, <eden.hamilton@bt.com> wrote:
> >
> > Hi Simon,
> >
> > I have forwarded these emails as requested.
> >
> > Cheers,
> > Eden
> >
> > ________________________________
> > From: Simon Glass <sjg@chromium.org>
> > Sent: 06 August 2024 22:47
> > To: Eden Hamilton VRC7 C <eden.hamilton@bt.com>
> > Subject: Re: ECDSA for FIT Files in U-Boot
> >
> > Hi Eden,
> >
> > Would you mind sending this to the U-Boot mailing list and cc me?
> > There are quite a few people involved in the security side.
> >
> > Regards,
> > Simon
> >
> > On Tue, 6 Aug 2024 at 08:24, <eden.hamilton@bt.com> wrote:
> > >
> > > Hi there Simon!
> > >
> > > I am Eden, currently at BT trying to get ECDSA verified boot for FIT files working on U-Boot.
> > >
> > > I have observed that you have reviewed many patches/updates surrounding ECDSA in U-Boot.
> > >
> > > I have been trying to get this working, but it is appearing difficult due to no examples online.
> > >
> > > I was wondering, if you have any examples where you have managed to get this working? Perhaps examples of FIT files, DTBs etc - that you would not mind sharing with me.
> > >
> > > If you do not, then no worries.
> > >
> > > Kind regards,
> > > Eden
> > >
