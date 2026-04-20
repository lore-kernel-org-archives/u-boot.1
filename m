Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82717F588C4
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 13:40:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D7F6843EA;
	Mon, 20 Apr 2026 15:40:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lw3hctWx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B08D843F5; Mon, 20 Apr 2026 15:40:27 +0200 (CEST)
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com
 [IPv6:2607:f8b0:4864:20::929])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2B88843D1
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 15:40:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-953ad5a55b7so1754244241.3
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 06:40:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776692424; cv=none;
 d=google.com; s=arc-20240605;
 b=LFLiDtxgB6YUL2EcjGPTsjTlx9v7IIAerf2fpy2DwKFnSPIx59hrY49MGC/AW5Y4lB
 wvR8Q/61PAepM7lVF6ycAANlcFPFFxMRTmCHKyp3FUmhgLNPk9SHdNFYG1r//1xuYJYc
 GH+/mtgZJQFV+E+rXuPmsCSOP5T9OHrtnqmqFlg2Ep+BwzY/kzQUqwzT0uf6pV9uNqRG
 PFAAOBgZGyYye32nLy7sFV45m7P5Aj8ZkaFdSTUqZbrcNAGkrpCZemIr52AH58aym3Qp
 RQGknpgcCrnKPVvILzrY4noOyqQYyGMnriZQ6jsv4gckmhAHNLliMPbk4eFE8Cb0OlsY
 /FDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CwiH4duCD7yR87JaDCIljctw3zVGb7+DsbSWGxluBqQ=;
 fh=kvQPwUxReXxOtF3XJ2DtMbp9fXzhKEwr7D49kWaYBjY=;
 b=Z+Py5RZZNRZGkMnoS1xgQ82QHHdbRW2U7BySmD9dNMk6IZJb/gJEbxgs8nEQed0cii
 Ddu1fn+4kAa+IJ+pQNNGdcXV9RQ9LJT244BQFdMiiq++IF2p776dYIDE+oCd0m8PgqC1
 uLHXPoTN5/4BUAHtB7EA+vf6H0WAGQNJT7H31q1U5IBSi0NkDO9cLlm3l4j/PWK58th8
 bH8RZxAlkt+7VpmNWZ6SZT4DuT+XI7QZMr7QqlE1OrxJ7/LOESygw4CtYFIuuE/mCzzw
 xz7fEEHjq8QWFFmD6NTotwsaX948Zql4VHxU4k+mAdhGwtiw0T6wdpM1oAhufCL/fUaS
 Ce8w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776692424; x=1777297224; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CwiH4duCD7yR87JaDCIljctw3zVGb7+DsbSWGxluBqQ=;
 b=Lw3hctWxdyzIn2QUhFpG74VxkVybV1zjdxGhV05f85OfCreoQRy4RSYkSHLxJW15zx
 7KRi+5auN/Iw4arwZy53aNxLE6zj5Q2njUAhI81OJuJ0mUrAASpnFsDRjiVOMjIeYdLh
 gEefOp56RFbZbJufYg9kVIvGNDdE6V7vTt79sXTUm2G+KJ+7P8Tp4FdRl0qt9GS10nXG
 S/LMdaPKI1G9DFv9P3dtIwYGq1jlGsLP//jBUxdy8RtUnjHq3gvYHZxZ6OhmEoOHgohr
 JFfARyzF25avYbu9R1UONr/58DE+3R0EoaZ6ReSCTvzRP/VXj09VXk8Hjs4SmXAxZ4jG
 lcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776692424; x=1777297224;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CwiH4duCD7yR87JaDCIljctw3zVGb7+DsbSWGxluBqQ=;
 b=J22YqUlTb3ed9Zf1juMk6fxnqlSrj0gtdiaPpny4ScCZ/mGIremUeAjR/YgIWa0L0Z
 ilglLPVIYyOkU7YNhZpUjKrqcjo75VLSEL59QNMx902YH2cCJF5Sw/YP3mVo0tvOaGAq
 EWbuCPoEc7EDl25FUhcKIf3SdyfJj+xiTNqUoRVnma/zY8rCAg2nBZxrEcg2XxOLVzJ7
 e5/PXV1QyajX3WE8ZMtxE9a/7gXlSuxaVltegRfXHF32y4mOEB9Fc/EdsTe+CiYC0T/0
 AQs6TIezl3pnwg9ULwcLMm5EMnZLu4mn8En/sJTqabMYpusYAvaS5XBizQRf1YIzrnir
 1JOA==
X-Gm-Message-State: AOJu0YyESzOmkqrrFpXdORGIeQkC+KoQ/5xXzzZJtjMDvum4keHoJRw3
 P8GDfH+3ZOQxrKG0ZBM9ffgx9nlKsYCTCgPd8kyRgvuoSfm9g7UCw3P1uuG99yiKLSQ+ovPSWaW
 iDMOYUOMvEzhBuChONO4/KLLQDHoGdnM=
X-Gm-Gg: AeBDietjp+UwfcOptw9zeMAkHuziCA2FcGUMsmRoD1v9IRGvCyuo/Wj9ux78vkIS6PP
 G2sZHH/RSdeHxbQP1+RHfmcDhZXWnprCgN5jxhP0+5DLsEo6sRr4dfriHi+/SZ+0SrN9giI5sTX
 XvEH8DBeLpAbS0v9aJMAgpJ8hNuWT4hI7zL1UE3pdYnsPipKz4wPqyc7r5zpHyUOVDHLVTJFJkb
 7xi6xRDq9115VU+5+2hGvBELwybn/UG3i8yRYc/7pJPZv7H2LE/7wEJfTmW+WLiZxW9yKpQIKtP
 IgVGaWAeAyfV1dp9Gjs=
X-Received: by 2002:a05:6102:1621:b0:605:2df4:c5dd with SMTP id
 ada2fe7eead31-616f7624fd7mr5286088137.26.1776692423706; Mon, 20 Apr 2026
 06:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250718141621.3147633-1-raymond.mao@linaro.org>
 <696b7f4d-e192-44e4-8652-e8db7f980507@gmail.com>
 <1a1f881c-bd6d-4677-af87-1c73bcac3dca@amd.com>
In-Reply-To: <1a1f881c-bd6d-4677-af87-1c73bcac3dca@amd.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Mon, 20 Apr 2026 09:40:10 -0400
X-Gm-Features: AQROBzAQitk4H65qBgvH8k9b1aX5x3-4FnRJLtS5TAKr1uXB2Yy4ohJzgaHy8P0
Message-ID: <CAMDkj5z7xKkuSpnn45Uvcb0j68wqXt92eQu4FPCC2FARcQu4pw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Add support for DT overlays handoff
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, venkatesh.abbarapu@amd.com, 
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Liviu Dudau <liviu.dudau@foss.arm.com>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Harrison Mutai <harrison.mutai@arm.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Matthias Brugger <mbrugger@suse.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Michal,

On Mon, Apr 20, 2026 at 3:06=E2=80=AFAM Michal Simek <michal.simek@amd.com>=
 wrote:
>
> Hi,
>
> On 4/17/26 22:39, Raymond Mao wrote:
> > Hi,
> >
> > The Firmware Handoff spec changes required for this series is already a=
ccepted
> > and merged at [1].
> >
> > Please review and merge this series.
> >
> > [1] Add Transfer Entry for Devicetree Overlay
> > https://github.com/FirmwareHandoff/firmware_handoff/pull/74
> >
>
> Yes. We are using this series. Once retested we will provide our tags.
>
> Raymond: If there is a need for any change are you going to send another
> version? Just asking to double check it.
>

No plan for another version unless I get more comments. I have rebased
and tested this on upstream/next and looks all good.

Regards,
Raymond

> Thanks,
> Michal
