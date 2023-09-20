Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FBA4CE79A8
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 02:59:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7422086BC4;
	Wed, 20 Sep 2023 04:59:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bVI8jUT9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5569B86BD2; Wed, 20 Sep 2023 04:59:42 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 564E286AD0
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 04:59:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-59c26aa19b7so42674917b3.2
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 19:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695178779; x=1695783579; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zdN72ApiezjaJ336sCKO9FXF1D7eJXxBPYNx/QGmNbs=;
 b=bVI8jUT9MefBngI+JdT94sl8/AAQTWeJDiR6y6jeAeWAYHUDOxEZtb34Eobrlw1epv
 xwd5qeo96PXgG0UaJh9nbp8BsuOirW8jCkg0caZ81yGFPQ39YnGqLoJ9FtGpGFul1Y/0
 w/EMsNjh7k7rjVsTbWSRJhScr+rJK08mrahR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695178779; x=1695783579;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zdN72ApiezjaJ336sCKO9FXF1D7eJXxBPYNx/QGmNbs=;
 b=Vk8HrGp4zOS9W2OVcr8E4pX+mkAm5oyHX412DJR43K9+MS2hLfSDrhl+cCIwsO46kB
 Ge80iKRCyZ32RmvhIwMc9iqHHU5+cUE1H9iZQJgOJo4aaPsJGoEuaXpWzi+qdjOOCUGK
 S63Kjq/2y1LSMgI4aIm/oYQ3CcsgND2EvSKHA0o636sMVBI6qeru18IAVE6bAdCZzk3L
 Q6KO71oSe7eAMCn5iQ5ZsMLY9QfSrzbNIUhKzo6V3nY+y794+3cHr7K0mMclbtPkKWBF
 ADoAgyUTZtUUPSZcKteLI8F7hKWEs45UXq4pw238xiBuZAyHC+vIqftiljIV9sHxXtKE
 eKvQ==
X-Gm-Message-State: AOJu0YxncWMvMNt9RmtBnYLAY+S8GNdERiCO8ZsJd8nGjiyLYbwFkcND
 XQH5MqFDIXA5qOke9RR3B4ZUJqhlAwxlAfnL517Hrw==
X-Google-Smtp-Source: AGHT+IHr3VvYf7ny2PYDHvKozCEKMPkX/Ojuc0HTzC01bctW/AWqsTWNOB6UtBBywCwAeQ/H8W0g5k2mKS4MLG27gcA=
X-Received: by 2002:a81:494b:0:b0:59b:c805:de66 with SMTP id
 w72-20020a81494b000000b0059bc805de66mr1251034ywa.11.1695178778896; Tue, 19
 Sep 2023 19:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230823211059.1235147-1-sjg@chromium.org>
 <20230823211059.1235147-17-sjg@chromium.org>
 <CAEUhbmWrq9DAKoeUA2AcvM3BpLGx3YZj20BjosdHRJmqRsE5UQ@mail.gmail.com>
In-Reply-To: <CAEUhbmWrq9DAKoeUA2AcvM3BpLGx3YZj20BjosdHRJmqRsE5UQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 Sep 2023 20:59:00 -0600
Message-ID: <CAPnjgZ302OTBRaO2FtzVq60VLe4+fZe6=FDvJhamaJsPP4=o7A@mail.gmail.com>
Subject: Re: [PATCH v4 16/20] x86: coreboot: Record the position of the SMBIOS
 tables
To: Bin Meng <bmeng.cn@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Bin,

On Tue, 19 Sept 2023 at 01:20, Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Thu, Aug 24, 2023 at 5:11=E2=80=AFAM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Make a note of where coreboot installed the SMBIOS tables so that we ca=
n
> > pass this on to EFI.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v2)
> >
> > Changes in v2:
> > - Add new patch
> >
> >  arch/x86/lib/coreboot/cb_sysinfo.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/x86/lib/coreboot/cb_sysinfo.c b/arch/x86/lib/coreboot=
/cb_sysinfo.c
> > index dfbc80c430e..f7fd9ea5bcb 100644
> > --- a/arch/x86/lib/coreboot/cb_sysinfo.c
> > +++ b/arch/x86/lib/coreboot/cb_sysinfo.c
> > @@ -471,6 +471,7 @@ int get_coreboot_info(struct sysinfo_t *info)
> >                 return -ENOENT;
> >         gd->arch.coreboot_table =3D addr;
> >         gd_set_acpi_start(map_to_sysmem(info->rsdp));
> > +       gd_set_smbios_start(info->smbios_start);
>
> use map_to_sysmem() too?

Actually that field is a u64, so already an address.


>
> >         gd->flags |=3D GD_FLG_SKIP_LL_INIT;
> >
> >         return 0;
> > --
>
> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Regards,
Simon
