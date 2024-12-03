Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37777E6C5E4
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 00:23:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C060F89562;
	Tue,  3 Dec 2024 01:23:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cXiX8c84";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93EB4895D7; Tue,  3 Dec 2024 01:23:21 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98768895B1
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 01:23:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5d0cfb9fecaso3783598a12.2
 for <u-boot@lists.denx.de>; Mon, 02 Dec 2024 16:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733185399; x=1733790199; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WZ0O7/kJaOI0fUiS2+Jtxgenj0UH2PBZrDJ0m7IBCa8=;
 b=cXiX8c84MAqoa+y+KK4Os4VuAumxokyU6WtyM6nlZYMjeJpMslsmCnWMT8TyF66Hpv
 QMZRrNo2OF2UZmYiXdT01CoaYKd27FoleAPuiNmjEtwK0yb8fbMu+jCFdXzL/iZp96VJ
 Y3y35mmgRS8Fs0JNWh0sE5Dyhrm3johZsd2Z8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733185399; x=1733790199;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WZ0O7/kJaOI0fUiS2+Jtxgenj0UH2PBZrDJ0m7IBCa8=;
 b=G6qE17NC4itEIcXaEKR+uNeGSi0qMv4or3WLP3lHpAURge79J6a3x5/pAkDrzYNT+9
 Vo3TpuE9PsJzZFzd3bt//oz2qf+KT83+LjsVdjVMElndFjhZ84WXaZYj0U79h2Q8RaBx
 znzHB2BqYZlDt6FFc5YigdN8VD+44dVCRzbRlX8ubSSHKJ5jSQghdT4hBVnW8EweyThW
 e+JSZEI8ZFIMmckpgj53g/N5TxqtZsSdmUATg4n2ppF9ZkEKiFOFnAzGo445bwexREfh
 kwKmCmLGiHIZOmp+ax5UJfBq+AQUp8u0wCpEMzDzxvlDTdW0mJqBHsJ5TfFqO5LyG7Aj
 7bEw==
X-Gm-Message-State: AOJu0YyuoUyEmh/CQggu7tHj3ijS/Sq53Rt3IsZlhlRgBXkWth1VaiNe
 a1gTKkOrJR1RSRDqUqTDHHdTlL2OmgbFcszYRZxSRqwCaEDlUo6yB6fhegcJbtJcF/wd22dYTfF
 970aZWqwIHY4ifegFV0nCoE3PLA9FtzlPbTi5
X-Gm-Gg: ASbGnct07JGzvBuvy9zvM583JYYs4vkD3jPn1Tb9oukTeTQINIpJGVRoLQeFxSkHhTu
 5g/1Lj5JT88k6EL72W1KC/yN9fSep/rYi
X-Google-Smtp-Source: AGHT+IHY6/diMdMtWvNNsWUuzm2BFJdwAdbvIO2nsCH0QwOPAUQJQSNdHy6Q6M0sTRRuJG+Mro/lMzcL5zjc4ojhbQw=
X-Received: by 2002:a17:906:2932:b0:aa5:1ef5:261e with SMTP id
 a640c23a62f3a-aa5f7d4ed45mr17589166b.17.1733185399142; Mon, 02 Dec 2024
 16:23:19 -0800 (PST)
MIME-Version: 1.0
References: <20241201152815.1668093-1-sjg@chromium.org>
 <20241201152815.1668093-6-sjg@chromium.org>
 <20241202220058.GJ2457179@bill-the-cat>
In-Reply-To: <20241202220058.GJ2457179@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 2 Dec 2024 17:23:07 -0700
Message-ID: <CAFLszTj0avcstecn0Q25U3URXucX-ZPsKHbLmm=5=_iHJ4bjSw@mail.gmail.com>
Subject: Re: [PATCH v5 5/9] efi: Drop the memset() from efi_alloc()
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

Hi Tom,

On Mon, 2 Dec 2024 at 15:01, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Dec 01, 2024 at 08:28:07AM -0700, Simon Glass wrote:
>
> > From my inspection none of the users need the memory to be zeroed. It
> > is somewhat unexpected that it does so, since the name gives no clue to
> > this.
> >
> > Drop the memset() so that it effectively becomes a wrapper around the
> > normal EFI-pool allocator.
> >
> > Another option would be to drop this function and call
> > efi_allocate_pool() directly, but that increase code size a little.
> >
> > Move the function comment to the header file like most other exported
> > functions in U-Boot.
> >
> > Comments were made in v3 that another project uses memset() when
> > allocating memory, but that is not required by the spec. In any case, as
> > above, from inspection, none of the users need the memory to be zeroed,
> > as they fill the entire region with their own data.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> I thought you agreed to drop this because Heinrich or Ilias was saying
> they'd get the spec clarified to say it should be zeroed?

The other option is to put a 'z' on the end. Heinrich mentioned that
Tianocore zeros memory in an equivalent call, but that doesn't make
any sense to me, sorry. At present I suspect we are masking bugs, but
it's hard to be sure. I'll figure it out eventually, I suspect....

Regards,
Simon
