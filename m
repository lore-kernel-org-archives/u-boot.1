Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D355AC3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  1 Jan 2024 00:37:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34E2C8773C;
	Mon,  1 Jan 2024 01:37:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L70ucrcz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC8AB87786; Mon,  1 Jan 2024 01:37:49 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99AEA87561
 for <u-boot@lists.denx.de>; Mon,  1 Jan 2024 01:37:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-67fb9df3699so58056396d6.2
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 16:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704069466; x=1704674266; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pMPd0Vm+33jO3chn+l3gJbnULO3dKw/NMOKCSLqHtKw=;
 b=L70ucrczkYRu12xmu3eWzRVGj2QyAmiR+4S9+CuWAwxdn4SG6QhxFpQGU5S2KYdl9+
 fQoBmzIS/CAXs/QT3iJt5eIAfOdca3zs7NotQ2gXI1Qu2DDJgExHL1+zW8VK+rjJUgEn
 YtRME1CUCenWcJkm00x3yD2co9Z3btf24L5Kc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704069466; x=1704674266;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pMPd0Vm+33jO3chn+l3gJbnULO3dKw/NMOKCSLqHtKw=;
 b=PivfEraMc8ABhSDqVw9Sd1I/xige7POGXTU+HTTulWTZo7jN8EZsSJjmhhFGF0YSNO
 FFkof0pDyiNuOUpoZ2kpgDfZin0wlBjmEPXZeCwOvYZyiXl4nuOZnUjR4YhHd3KavzWf
 PBOC+v74+gqdmgv9qJrP2z75qOHLT0ZvalnT2M3tUvvkd2ZEJlpKTQtcuLejAnusBx4U
 ZOuKKtfyRvG9J52I9tBIJ4ZaKA4kJnmMp8NJEEEInYUWE6sPS8hixCANoNfVw5R1NpT6
 Ba00mYxx1O70JTp42BiAs6Yf3saNj3yWQt8jlSzhrTYn7s1W4qlcOg9DjxKW4PnF4aqf
 2suA==
X-Gm-Message-State: AOJu0YwUlsKGElA3i7bMN7MF3oT54Yh87sYQZCgG0Uljpm1r8NuG2Rfm
 ZRLYnTAgyVEQpr9CRG/rC6k4+/4x3pTrtVFaCjBFox9pR6AS
X-Google-Smtp-Source: AGHT+IHO51euO9wNNsDIdjgVmfgN1v/Efn9EWay7zUNY0/zqUPfCWsWcaacOJZB72qulNfyhANpoexcTMO25m72CDtI=
X-Received: by 2002:a05:6214:27c1:b0:680:b6ec:ea05 with SMTP id
 ge1-20020a05621427c100b00680b6ecea05mr450732qvb.62.1704069466376; Sun, 31 Dec
 2023 16:37:46 -0800 (PST)
MIME-Version: 1.0
References: <20231231152555.464874-1-sjg@chromium.org>
 <20231231152555.464874-13-sjg@chromium.org>
 <da23504c-e4c4-461f-a6f6-5d52bc79a549@gmx.de>
In-Reply-To: <da23504c-e4c4-461f-a6f6-5d52bc79a549@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 31 Dec 2023 17:37:35 -0700
Message-ID: <CAFLszTjcmRxoG6C_nw2wX1gfK9y076YF7aPtME=jr=4MH4zTZQ@mail.gmail.com>
Subject: Re: [PATCH v5 12/12] efi: Correct smbios-table installation
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Sun, Dec 31, 2023 at 9:27=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
> On 12/31/23 16:25, Simon Glass wrote:
> > At present this code allocates memory when writing the tables and
> > then unnecessarily adds another memory map when installing it.
> >
> > Adjust the code to allocate the tables using the normal U-Boot
> > mechanism. This avoids doing an EFI memory allocation early in
> > U-Boot, which may use memory that would be overwritten by a
> > 'load' command, for example.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> In patch 11/12 you changed the address fields in ACPI tables from
> sandbox virtual addresses to pointers. Do you plan to do the same for
> SMBIOS?

I haven't looked at it, but could if it would help. Are you planning
to add an EFI test app for sandbox?

Regards,
Simon
