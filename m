Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92959E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:39:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A00187153;
	Mon,  2 Oct 2023 03:22:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hdbQBSPr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4D1887286; Mon,  2 Oct 2023 03:22:27 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C64B8721E
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:22:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9b2f73e3af3so185648566b.3
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209735; x=1696814535; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fJrLfocU/SDsSPYs+WMFOhE/MQDnFGjFZOLy+cgpdZw=;
 b=hdbQBSPrlPdn4/9AFeUYxFuEuQJZl24rT+ZK3vVGnCAZfWx/BaCgclK/V32QMc0js/
 SfeTQx+e/wDYaIuAxExr4SfNek/z7P5LNBqB2jksPEimdZMp/alj+pgMe8o16iaXz/++
 QISwuxt2EvceoXReW8Zexl96AFzrmtjRsROd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209735; x=1696814535;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fJrLfocU/SDsSPYs+WMFOhE/MQDnFGjFZOLy+cgpdZw=;
 b=oDu9jX+3luBBRt967lU9PRERAcy0ZUVFUSosNsHOqJ2SkCFSW40Cxrt9jNV4ZBNACF
 wQrFRuRqqMwM+Oa0KEKiyz17Uc+O7MddGRwXSmK4+WHTpewqtqqSoUhp+Bj/6K0U44F0
 Sg4rcBcysgD7bmTSYtjQSfddp4wunFX0Hhoi+nPZPeVZSIRGpbonM05d4b2elPmcQg/H
 C06IJZjtt2BtK6ZUjqKeQYURYGWkDnqJOQAmMn7IdboMUPanAYF+AI2CH2Fxi8IQzhhQ
 bd+qVr+iJ2SKLMzCiHKSoMIUvmXbAzfV5WP143ItvSj7FufAVsOKRqYD+O38L1gB4+Kx
 M3iA==
X-Gm-Message-State: AOJu0Yw2OW8bxOhXlmuiBrgZSooix0EgkkyQLuvq6Ew0Cr+n58vX1OKZ
 JPggZMg7YsffM9eTOgY+M6YrK6bE3hwXEmQ3TbnmgQ==
X-Google-Smtp-Source: AGHT+IExWgXo/f18S2glZPssxlbjkuN/iv4ce6kqNxOZ+r2eT211Hkno2kUSB5w3tCcEha2Xh56rVeRCrJLDlaMRRN4=
X-Received: by 2002:a17:906:3098:b0:9a2:ecd:d963 with SMTP id
 24-20020a170906309800b009a20ecdd963mr10015250ejv.44.1696209734829; Sun, 01
 Oct 2023 18:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAJaLiFw67ztCo5TY=TPQneYgE5q6RHnj_XbnukQD=qhec3oRdg@mail.gmail.com>
 <CAPnjgZ3T8TOQbQKuy3wwfgb2K3sG5RDQdZ2zOxYT62XgGmVezg@mail.gmail.com>
 <CAJaLiFwx0j6Knthtgdy-wGDxaHYDuYEUws2LAkt05stc3f3ZBw@mail.gmail.com>
In-Reply-To: <CAJaLiFwx0j6Knthtgdy-wGDxaHYDuYEUws2LAkt05stc3f3ZBw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Oct 2023 19:17:33 -0600
Message-ID: <CAPnjgZ1FAEDs-f01Q-RCAV=sMWq40cD5UDo9O6SbqTRazS9gQA@mail.gmail.com>
Subject: Re: bootstd: Scanning for USB bootflow will remove existing SCSI
 bootflow
To: Tony Dinh <mibodhi@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
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

Hi Tony,

On Tue, 26 Sept 2023 at 13:40, Tony Dinh <mibodhi@gmail.com> wrote:
>
> Hi Simon,
>
> On Tue, Sep 26, 2023 at 4:37=E2=80=AFAM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Tony,
> >
> > On Mon, 25 Sept 2023 at 14:02, Tony Dinh <mibodhi@gmail.com> wrote:
> > >
> > > Hi Simon,
> > >
> > > Here is an observation during testing the bootflow command.
> > >
> > > If there is a SCSI bootflow, scanning for USB bootflow will remove th=
at existing
> > > SCSI bootflow. To bring it back, I scanned for SCSI bootflow again, a=
nd it was
> > > back to normal. Perhaps there is some kind of indexing problem?
> >
> > Yes that's right. The 'botflow scan' command is not additive. The
> > first thing it does is removing existing bootflows.
>
> Thanks for clarifying that. I assumed it is additive, because the
> existing USB bootflow was not removed when I did a "bootflow scan
> scsi" immediately after (see the end of the log).

Yes, but I'm not sure what is going on there. Perhaps it is a bug?
When you scan SCSI it should not also scan USB.

Regards,
SImon
