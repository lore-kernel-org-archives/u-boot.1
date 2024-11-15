Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9587D68BDC
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 23:19:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D2F5891B1;
	Sat, 16 Nov 2024 00:19:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="luidu0Ho";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BF60891B1; Sat, 16 Nov 2024 00:19:23 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 181A189163
 for <u-boot@lists.denx.de>; Sat, 16 Nov 2024 00:19:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9a0c7abaa6so7603666b.2
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731712760; x=1732317560; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WIK8LlwtlYPRob+ZZ9iKYHJw0PYMHRXHVVHcXLn9WuY=;
 b=luidu0Hok6nRhuJC0TO1xDgOiq96rVWnt2xkKfAR29PrySSbq3zTxL9Tuz+jfByHdY
 Rf1ydkUf9MqTpEM+JSV1TpXi3vVZuDa5dF1h4AcE5UufklZfYVNAHO871eta8rhY3sFJ
 pWGwo2gzWTrfFhpvB0Zr87cmaPUCliWUEBwvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731712760; x=1732317560;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WIK8LlwtlYPRob+ZZ9iKYHJw0PYMHRXHVVHcXLn9WuY=;
 b=Mr4oO6OCiXmVMuMJw+zSSqsaJTbNJJE8RqZlJlLadmmwQGtTuns2OG2pxlpbhKCpH0
 QC/ljyszctIe+vyYxqB+kdiPLLfXRWB+nFoVD39wsTXUxtlpJ2XPHf+NfXAYCWzUu1+Q
 ei7+G1FznRwxigiQubGYJYINFPp5fMvNDpyb0hmKXgQ2YO7DCIadmDOIBEj7g80TVCDW
 Hlu1r78BdmsCWtngdfsb8LMQ8Ic73sdrh6N5Ee3GK+aahxAEN5WOXU2o44N8nH4boNmI
 8HxrfLqWdpTPaK6gP9DSbGDU4keUsu2d57VNtdlvfvXol6sl0ZN06mrso+2Kr34ToqJ2
 J1fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7kr9VB49CfEWJoNGdwrbCL/IRI3Qru19ccd3nFfXkEsT+NSqzTWqK1haOpqze5Q8vdlDsjNA=@lists.denx.de
X-Gm-Message-State: AOJu0Yzx/ikc66pqWmR5pPkcijfCoUPQrqb4Oi6rbgcs1XvCmbLu+x77
 D9Fvjcn9QTJcuSDBoCekUZ7+GPLX0m9vT2L8GOSbTuXepp8Vn2+f89+pyApDiJz8qQgadhkChCl
 VC91QvFq0qRtDp/F1ZJhziOOrtoKCwVV0Z0t9
X-Google-Smtp-Source: AGHT+IHxBwxz8IYraiD1vNVjG9JgUGSnZmWEi+mS1lJX1s6O28y1hl3YsiZJCTC0FZNtHXWsNdrMsUVPhW+VBLBY+tw=
X-Received: by 2002:a17:907:701:b0:a99:e1a1:473f with SMTP id
 a640c23a62f3a-aa483553dfcmr418842366b.57.1731712760457; Fri, 15 Nov 2024
 15:19:20 -0800 (PST)
MIME-Version: 1.0
References: <20241104175110.1048449-1-sjg@chromium.org>
 <20241104175110.1048449-12-sjg@chromium.org>
 <113aa432-79b7-4920-9b76-cb3543186efd@gmx.de>
In-Reply-To: <113aa432-79b7-4920-9b76-cb3543186efd@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 Nov 2024 16:19:08 -0700
Message-ID: <CAFLszTgQQ7nop1n1oi+w0uYOr1ZSU1XqHTL9m-AX52UrQsjumA@mail.gmail.com>
Subject: Re: [PATCH v3 11/19] bootmeth_efi: Check the filename-allocation in
 the network path
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Shantur Rathore <i@shantur.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 4 Nov 2024 at 14:42, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 11/4/24 18:51, Simon Glass wrote:
> > If the filename cannot be set we should give up. Add the missing error
> > check.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v2)
> >
> > Changes in v2:
> > - Change the tag to bootmeth_efi
> >
> >   boot/bootmeth_efi.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> > index e8109e19bcb..1ff8788ebeb 100644
> > --- a/boot/bootmeth_efi.c
> > +++ b/boot/bootmeth_efi.c
> > @@ -269,6 +269,8 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
> >       if (!bootfile_name)
> >               return log_msg_ret("bootfile_name", ret);
> >       bflow->fname = strdup(bootfile_name);
> > +     if (!bflow->fname)
> > +             return log_msg_ret("fi0", -ENOMEM);
>
> How could we hope that a user understands a cryptic message
> "fi0: returning err=-12"?
>
> Please, write a message that is user readable.
>
> log_err("Out of memory");

We cannot write to the screen here as it is in a driver. The log
message only appear if debugging is enabled and
CONFIG_LOG_ERROR_RETURN as well.

They are aimed at being enough for someone to grep the code, without
adding so much to the string space that U-Boot grows to Tianocore
dimensions.

[..]

Regards,
Simon
