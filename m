Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD4DE936ED
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 03:23:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91B18863C9;
	Thu,  5 Oct 2023 05:23:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fOms1ykx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34FF486741; Thu,  5 Oct 2023 05:23:31 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 559F486177
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 05:23:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3247cefa13aso516743f8f.1
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 20:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696476209; x=1697081009; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S3Nyl0d6rbxeO53xRkoKMUQfNrUQ4RO94vtEergJ7Ag=;
 b=fOms1ykxepFxPFDKRai6O/2ysV5kLcxrauANsVt0o667fS030LdwqM/7a9P8YVAlFN
 +lceZeis9lefu0vGCeaVtpZmHIRH83V434hLwyskucE4yaeZgyzpQQaAfV3sT3wMYyyq
 /wTy8f/Y6eUmKLFfwA/FJICb/IC7+m2GK3ATQVW3dn0kjgZjjvjb5pmhlpP7JBkq0/o1
 RlCewTJrMOMMHLkz7PXcWqZseOI0MphiQcoW0X9HEy1vLLHPw7/HbtvuLs3f7S4RRz5I
 ROxHVnNgdYNKIT1uuQ32llOjFXfgMi5Z+S2QOe3m5UEqQWI9wuE7Q1UlpM5A5YN3sPTB
 cqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696476209; x=1697081009;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S3Nyl0d6rbxeO53xRkoKMUQfNrUQ4RO94vtEergJ7Ag=;
 b=vmolZcCt3EkGwIF2z/T93LnxExRIXzdB8CWY/Ds1OOQPWAjIkRdhCAWekv5VXImCOZ
 Ih7VmWzhbZ6bosvucmgo1eGizt318K0iM6ZZpPpvsQFvdTwa9VypUkAvL78rjzLaGmN/
 miXpI/+UeokHQ6nCyXKYcTWqtdvCaiHpcr09vk9GCES8UFl5wftgIRIE2fQr6Mxh2U1n
 W535GhYAZKGzLEcAG265cSyOHWXd79wHXgwhbegraAcmWtfRUuncB7u1kjPJ+3BJpt/f
 zwBIZSHdKQMf7O7eGFXfdq4t3pACOv9LxzboXSS9pAu/0PfiJiknk0rs+vrrIu41gNbd
 g1qQ==
X-Gm-Message-State: AOJu0Yy2YV0u63zFznixKbK72Ft/HISnTPrpoZ2/9RvPdaZ0wlpTTeSM
 Kl16PoybMDHo8UFAkT+zGUswMxx9TCIGggQ0HTc=
X-Google-Smtp-Source: AGHT+IHwwU//5hQ6DAQCpdUFHxwaKGWba755HcYO+eAy1FGzre2wnt3LpqmgYiRqopVPZrMdZQ0yBIpVcZkXOE8ABQ4=
X-Received: by 2002:a5d:6852:0:b0:309:1532:8287 with SMTP id
 o18-20020a5d6852000000b0030915328287mr3480669wrw.19.1696476208606; Wed, 04
 Oct 2023 20:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAJaLiFw67ztCo5TY=TPQneYgE5q6RHnj_XbnukQD=qhec3oRdg@mail.gmail.com>
 <CAPnjgZ3T8TOQbQKuy3wwfgb2K3sG5RDQdZ2zOxYT62XgGmVezg@mail.gmail.com>
 <CAJaLiFwx0j6Knthtgdy-wGDxaHYDuYEUws2LAkt05stc3f3ZBw@mail.gmail.com>
 <CAPnjgZ1FAEDs-f01Q-RCAV=sMWq40cD5UDo9O6SbqTRazS9gQA@mail.gmail.com>
 <CAJaLiFzsJP5u5ziHW7U5_0uqeGdr4uxHRG7kso2K-jahqLKBsg@mail.gmail.com>
In-Reply-To: <CAJaLiFzsJP5u5ziHW7U5_0uqeGdr4uxHRG7kso2K-jahqLKBsg@mail.gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Wed, 4 Oct 2023 20:23:16 -0700
Message-ID: <CAJaLiFyqr88c8L1Lg+99XnP4geebwqrdKhSV4_h9uf1Mjr94Qw@mail.gmail.com>
Subject: Re: bootstd: Scanning for USB bootflow will remove existing SCSI
 bootflow
To: Simon Glass <sjg@chromium.org>
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

Hi Simon,

On Mon, Oct 2, 2023 at 12:25=E2=80=AFPM Tony Dinh <mibodhi@gmail.com> wrote=
:
>
> Hi Simon,
>
> On Sun, Oct 1, 2023 at 6:22=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
> >
> > Hi Tony,
> >
> > On Tue, 26 Sept 2023 at 13:40, Tony Dinh <mibodhi@gmail.com> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Tue, Sep 26, 2023 at 4:37=E2=80=AFAM Simon Glass <sjg@chromium.org=
> wrote:
> > > >
> > > > Hi Tony,
> > > >
> > > > On Mon, 25 Sept 2023 at 14:02, Tony Dinh <mibodhi@gmail.com> wrote:
> > > > >
> > > > > Hi Simon,
> > > > >
> > > > > Here is an observation during testing the bootflow command.
> > > > >
> > > > > If there is a SCSI bootflow, scanning for USB bootflow will remov=
e that existing
> > > > > SCSI bootflow. To bring it back, I scanned for SCSI bootflow agai=
n, and it was
> > > > > back to normal. Perhaps there is some kind of indexing problem?
> > > >
> > > > Yes that's right. The 'botflow scan' command is not additive. The
> > > > first thing it does is removing existing bootflows.
> > >
> > > Thanks for clarifying that. I assumed it is additive, because the
> > > existing USB bootflow was not removed when I did a "bootflow scan
> > > scsi" immediately after (see the end of the log).
> >
> > Yes, but I'm not sure what is going on there. Perhaps it is a bug?
> > When you scan SCSI it should not also scan USB.
>
> Yes, it looks like a bug. I think I can see the problem and am working
> on a patch.

Just to let you know, I'm out of time to work on this topic. I will
revisit it some other time, if you have not already tracked it down.

All the best,
Tony

>
> All the best,
> Tony
>
>
> >
> > Regards,
> > SImon
