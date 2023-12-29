Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87083C46CD4
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 06:40:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08CD087A54;
	Fri, 29 Dec 2023 07:40:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="l9/YtVw+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0266D87A69; Fri, 29 Dec 2023 07:40:39 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7558F87A17
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 07:40:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50e70b0b869so4817139e87.2
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 22:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703832035; x=1704436835; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oAsMLGLnhmtkhUouViNAhf65RUKoJybuJO/fJRguG08=;
 b=l9/YtVw+PbQBH8cLx7rPKRtv/dIm0x/AfIeMBLfMYxodFLnqp/pQfORU0tloARbPkr
 ODfzkJ/ccq2h+cufvtUc98qiwXiJn7ro+7YWuR8XAyE8W50oRd4OOkLZIAVYOQUBHoIT
 xyWczZP4aSS1OKEo+lFXroTl4zQSi+gg+KquAIwxv+/Z0H77TOe1u9h44dLVdQGINH0K
 DQD8NSirCszigfLAm3+EuGtQ1DUf7QNYCtQiIm0MurQqvCdIGdIYYwpeU0gY2acMgQmH
 HpX9EyLt0ZFPKoFAuEky38icVbXdSypNmejLIH4frSz3/TGp+fpkYvEMYZipmwO5AnCo
 KkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703832035; x=1704436835;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oAsMLGLnhmtkhUouViNAhf65RUKoJybuJO/fJRguG08=;
 b=tB2/Z0vPy/inmoNxR8G/LHKlaPBTyAxX4vhiNykpJ4ZnKlm4rJPLYRRoeceqOU7u+S
 1acMGVYPCYdC9arGlCIMuj/z0C7DmoYFzCDIDe9B5OhaEtPeAe6m4J+q+vIf6iTN/Bq0
 ExPAMHTvSKdVO7v6rvPcs432SOo4krUCeZ951CdYx6d7VeiJOR7EQCs4iOSEAP5TuEdG
 ar/lXV42m2iQ28Ttvcpc8xI2f4xC93GiHCsPq1ukZEpjF3mYOE6eCPCFu6fGKPU199tg
 iuU32NiryceuWku5AC4L6OtHUKGIr96CSJbDPSodNgI14Hw863GHKRC/X/JzeSujRrIK
 QJmw==
X-Gm-Message-State: AOJu0Ywempg44ftRn8wSuU+RNYy+bWebyj9Ckqx40+2aBL0M0zc+Nisi
 d9L5t9DCAosiChZMqXDxcZCZyRtb94F6aBBGb0krRd16YXT1eA==
X-Google-Smtp-Source: AGHT+IFwqvy7gTk0JN6apRAhi8oxMNak/eVIuzN90BzXL8mA3ZZ4tgc263Z9lv6/LIS81vVNeXgoSp29lD0QBQpVthc=
X-Received: by 2002:a05:6512:374f:b0:50e:7410:d5b0 with SMTP id
 a15-20020a056512374f00b0050e7410d5b0mr3502757lfs.28.1703832035680; Thu, 28
 Dec 2023 22:40:35 -0800 (PST)
MIME-Version: 1.0
References: <CAFLszTicT2yzsm+KAjRyqzV3bt1_W2XYJaCExX-LHNZ6+tFUkA@mail.gmail.com>
 <CAC_iWjK2Rm_DPhk+1PwFmdARJ_7svNuKd3GTKUwzEm=+iWZS6A@mail.gmail.com>
 <CAFLszThJmxd5-KqiSwZXdkqrMiTGiTw=j0nM2NO48jMaOh+DvQ@mail.gmail.com>
In-Reply-To: <CAFLszThJmxd5-KqiSwZXdkqrMiTGiTw=j0nM2NO48jMaOh+DvQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 29 Dec 2023 08:39:59 +0200
Message-ID: <CAC_iWjLE_5-09J5Ta=u75CtB9iC26AuMoXEk94W7k5VaNv3+Yg@mail.gmail.com>
Subject: Re: Proposal: U-Boot memory management
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
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

On Fri, 29 Dec 2023 at 07:36, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Fri, Dec 22, 2023 at 12:02=E2=80=AFPM Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Simon
> >
> > I'll respond to the rest more thoroughly but I since I caught this earl=
y,
> >
> > [...]
> >
> > >
> > > 5. Avoid calling efi_allocate_pages() and efi_allocate_pool() outside
> > > boot-time services. This solves the problem 6. If memory is needed by
> > > an app, allocate it with malloc() and see 3. There are only two
> > > efi_allocate_pages() (smbios and efi_runtime). There are more calls o=
f
> > > efi_allocate_pool(), but most of these seem easy to fix up. For
> > > example, efi_init_event_log() allocates a buffer, but this can be
> > > allocated in normal malloc() space or in a bloblist.
> >
> > The TCG event log is only valid in the EFI world and is described by
> > the EFI spec extensions [0]. I prefer it to remain as is
>
> How does that relate to [1] ?

We use that today.  The tl;dr is that TF-A measures the early stages,
but doesn't have drivers to extend TPM PCRs. Instead, it creates an
EventLog which hands over to U-Boot. The TPM subsystem searches for
that and if it finds one && PCR0 =3D=3D 0 replays the EventLog in hardware
and copies it over to EFI memory.

That being said, I'd much prefer using a bloblist for that EventLog
(which also contains information on replaying), over a DT entry that's
only described in TF-A docs. But that's a future improvement.

>
> >
> > >
> > > 6. Don't worry too much about whether EFI will be used for booting.
> > > The cost is likely not that great: use bootstage to measure it as is
> > > done for driver model. Try to minmise the cost of its tables,
> > > particularly for execution time, but otherwise just rely on the
> > > ability to disable EFI_LOADER.
> > >
> > > =E2=80=93
> > >
> > > Regards,
> > > Simon
> >
> > [0] https://trustedcomputinggroup.org/wp-content/uploads/EFI-Protocol-S=
pecification-rev13-160330final.pdf
> > Thanks
> > /Ilias
>
> [1] https://trustedfirmware-a.readthedocs.io/en/latest/components/measure=
d_boot/event_log.html

Cheers
/Ilias
