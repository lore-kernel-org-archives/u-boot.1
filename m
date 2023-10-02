Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5A4E7490C
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 19:26:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C36D786EFF;
	Mon,  2 Oct 2023 21:26:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SnM+JUtv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFECC8718A; Mon,  2 Oct 2023 21:26:07 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01DA586DD3
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 21:26:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-532c81b9adbso82337a12.1
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 12:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696274765; x=1696879565; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nd3hlDEUkq+L7PACzLuv6fwfMQY5sb9fI/ufXSK8Qqw=;
 b=SnM+JUtv3yIQWGCaE95H1ZQbF7RAY9+hzEH6kN3xqzUYnzl3bR5wzEi7p27BtMYmNX
 jFv5K4zcAYIVk3elCI+pLeiwGrpCZNPHYFPH4JnXuTX8XX+ykHR/+7g5SvupScuIk0Y5
 G5EjwKGiO1aBJhKgEJqg2aXwh2eoXNdTnIyhtCeNjIOE1FPbNwwhqYUetcRIBEX8CUzs
 XabM9KSKBjNpW074+CnN0Zv0wEI/wQbe4waobh0QsOdl3Ak8RCIgAfTNRfcMMcWTmSRK
 TkGaob2IcltArSfOL2uo+HXGC3zCrFbCG6tAXHnTAcTaF7eNmxPb5OSyeSOG2FiAzL5R
 C/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696274765; x=1696879565;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nd3hlDEUkq+L7PACzLuv6fwfMQY5sb9fI/ufXSK8Qqw=;
 b=P7jskH1eFXQA7wKkIqsBbiVBwsrS0Qruj8yMXIA+j5GuUXtTdlGYrldXO/H8RuofXj
 J2ijEBKo96Po5w+pC7XOz/bvlCfPv9TL1SoUPfS6LwtihPxRztQv81bbOpXTSD7C7WKM
 nblrgszHAluu2CUKs2v4QhYbm+7D6pYIwY8MHQTt86rx6gb9p5IUtdlJn4to9sV5WGm/
 DvTVsNX8J02nGZIqiABfjX2cx0bfkinhRp0Gi2MP6qSy96qpqaUp/f5VqKoPhChaTSHc
 USCfclRCtJwb9x5eRIqIohQ4s5SAU7u2/0jmZvQ6Hsi1cRBPT4eaE8Dd4CLYI0i8F5ZI
 VjQw==
X-Gm-Message-State: AOJu0YznQzaYFUazOIHOJGFVStEwUhFujCUmV4dqR8oYhgV+rN2Aqhcv
 ziw+7KTIFfan0V8dLz1yWMS+xWfMqXNb57MU+xSWXmp5
X-Google-Smtp-Source: AGHT+IH5K21gIE1TzypsaK7waa4EM9VmIb/P3AbbstFwkw4aU95H5iTMYfzf8+/e79YoYKbhDb7gJEgGtNoLEWef8Mk=
X-Received: by 2002:aa7:d3da:0:b0:532:cae2:8dfc with SMTP id
 o26-20020aa7d3da000000b00532cae28dfcmr10947272edr.5.1696274765286; Mon, 02
 Oct 2023 12:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAJaLiFw67ztCo5TY=TPQneYgE5q6RHnj_XbnukQD=qhec3oRdg@mail.gmail.com>
 <CAPnjgZ3T8TOQbQKuy3wwfgb2K3sG5RDQdZ2zOxYT62XgGmVezg@mail.gmail.com>
 <CAJaLiFwx0j6Knthtgdy-wGDxaHYDuYEUws2LAkt05stc3f3ZBw@mail.gmail.com>
 <CAPnjgZ1FAEDs-f01Q-RCAV=sMWq40cD5UDo9O6SbqTRazS9gQA@mail.gmail.com>
In-Reply-To: <CAPnjgZ1FAEDs-f01Q-RCAV=sMWq40cD5UDo9O6SbqTRazS9gQA@mail.gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Mon, 2 Oct 2023 12:25:53 -0700
Message-ID: <CAJaLiFzsJP5u5ziHW7U5_0uqeGdr4uxHRG7kso2K-jahqLKBsg@mail.gmail.com>
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

On Sun, Oct 1, 2023 at 6:22=E2=80=AFPM Simon Glass <sjg@chromium.org> wrote=
:
>
> Hi Tony,
>
> On Tue, 26 Sept 2023 at 13:40, Tony Dinh <mibodhi@gmail.com> wrote:
> >
> > Hi Simon,
> >
> > On Tue, Sep 26, 2023 at 4:37=E2=80=AFAM Simon Glass <sjg@chromium.org> =
wrote:
> > >
> > > Hi Tony,
> > >
> > > On Mon, 25 Sept 2023 at 14:02, Tony Dinh <mibodhi@gmail.com> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > Here is an observation during testing the bootflow command.
> > > >
> > > > If there is a SCSI bootflow, scanning for USB bootflow will remove =
that existing
> > > > SCSI bootflow. To bring it back, I scanned for SCSI bootflow again,=
 and it was
> > > > back to normal. Perhaps there is some kind of indexing problem?
> > >
> > > Yes that's right. The 'botflow scan' command is not additive. The
> > > first thing it does is removing existing bootflows.
> >
> > Thanks for clarifying that. I assumed it is additive, because the
> > existing USB bootflow was not removed when I did a "bootflow scan
> > scsi" immediately after (see the end of the log).
>
> Yes, but I'm not sure what is going on there. Perhaps it is a bug?
> When you scan SCSI it should not also scan USB.

Yes, it looks like a bug. I think I can see the problem and am working
on a patch.

All the best,
Tony


>
> Regards,
> SImon
