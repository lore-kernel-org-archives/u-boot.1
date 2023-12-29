Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC32C46CD4
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 05:36:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5547875A0;
	Fri, 29 Dec 2023 06:36:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="diOApOJd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72FFC87645; Fri, 29 Dec 2023 06:36:18 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE1208753D
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 06:36:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-67f962cf6c9so41454636d6.0
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 21:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703828173; x=1704432973; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sIu1VzSdmaDa8OiXfa2BM+Ky4iVCzWZ6yN4EIYr6J8Q=;
 b=diOApOJdpVhTgWFB9a0rT3m/iPsgGilGkeP7gRQAIRGBhiuNfER6BN1r4Ala8hrNUs
 nCvZ/0arYnnPsnai+DsPmY/a5u5UCb1JvpW6/c0R/zjy4iOPTsdmt/Wh50Cjzs21xX36
 uYsnroSaIhXV/JfJaVEyByEgKrVv7fKrRzZe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703828173; x=1704432973;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sIu1VzSdmaDa8OiXfa2BM+Ky4iVCzWZ6yN4EIYr6J8Q=;
 b=m0/FKFFIDXTz7JOpwg7O6twlVHbc8hIrjkjqjlo+vlWHEULsWyPPwhJ6m6S60toR1p
 +9NgQdWM2TkybOft52vs5fGrZzWQf8SX5ZPKC3qLGze+H8Y6rBfXND54pdbxPMS/KU1W
 BUw2GFQWS9KMKrCmgS3056PSEyIoNw517rX7PZfFi3183SCZoafEZc8G4rw6TEbCD0UO
 7m6bsQ+ln8hc/IrfNIxkjBzFLqP4qsUE5pvDz0ejim8yPwGt0CxvSJKwN+ip1vHo9eZv
 yJlU0BQ/mmAMike6fptXP35trOuBXU8Pm4HR4t91SgWaUnpZMuuK3Cictc0l0UNDLfJM
 5i5Q==
X-Gm-Message-State: AOJu0YxbGEGJlLebo8oIUKe/RYkwAGs8UCQXRz8alZnPtgD99kGSV9PL
 DXX7sYGw6REeh7tVMZDTL9sJroCPmCZ/CKLXQu/Ff0oOV0vN9U6x67JDhNnD4Q==
X-Google-Smtp-Source: AGHT+IHfWZA3sGG+fKdr4WXWwGRAxbku45M6bd07M+9wCjQ2v9ORSL1/yKzvh32GzVv3HGQ4A6R672H5KUjAz/rjwnc=
X-Received: by 2002:a05:6214:1bc8:b0:67f:8b8f:1d6d with SMTP id
 m8-20020a0562141bc800b0067f8b8f1d6dmr20541896qvc.17.1703828173511; Thu, 28
 Dec 2023 21:36:13 -0800 (PST)
MIME-Version: 1.0
References: <CAFLszTicT2yzsm+KAjRyqzV3bt1_W2XYJaCExX-LHNZ6+tFUkA@mail.gmail.com>
 <CAC_iWjK2Rm_DPhk+1PwFmdARJ_7svNuKd3GTKUwzEm=+iWZS6A@mail.gmail.com>
In-Reply-To: <CAC_iWjK2Rm_DPhk+1PwFmdARJ_7svNuKd3GTKUwzEm=+iWZS6A@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 29 Dec 2023 05:36:02 +0000
Message-ID: <CAFLszThJmxd5-KqiSwZXdkqrMiTGiTw=j0nM2NO48jMaOh+DvQ@mail.gmail.com>
Subject: Re: Proposal: U-Boot memory management
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Ilias,

On Fri, Dec 22, 2023 at 12:02=E2=80=AFPM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon
>
> I'll respond to the rest more thoroughly but I since I caught this early,
>
> [...]
>
> >
> > 5. Avoid calling efi_allocate_pages() and efi_allocate_pool() outside
> > boot-time services. This solves the problem 6. If memory is needed by
> > an app, allocate it with malloc() and see 3. There are only two
> > efi_allocate_pages() (smbios and efi_runtime). There are more calls of
> > efi_allocate_pool(), but most of these seem easy to fix up. For
> > example, efi_init_event_log() allocates a buffer, but this can be
> > allocated in normal malloc() space or in a bloblist.
>
> The TCG event log is only valid in the EFI world and is described by
> the EFI spec extensions [0]. I prefer it to remain as is

How does that relate to [1] ?

>
> >
> > 6. Don't worry too much about whether EFI will be used for booting.
> > The cost is likely not that great: use bootstage to measure it as is
> > done for driver model. Try to minmise the cost of its tables,
> > particularly for execution time, but otherwise just rely on the
> > ability to disable EFI_LOADER.
> >
> > =E2=80=93
> >
> > Regards,
> > Simon
>
> [0] https://trustedcomputinggroup.org/wp-content/uploads/EFI-Protocol-Spe=
cification-rev13-160330final.pdf
> Thanks
> /Ilias

[1] https://trustedfirmware-a.readthedocs.io/en/latest/components/measured_=
boot/event_log.html
