Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C05C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 14:06:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22AF587595;
	Mon, 27 Nov 2023 15:06:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tncmK6bq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B10E875DF; Mon, 27 Nov 2023 15:06:41 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E249887530
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 15:06:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a02d12a2444so622348366b.3
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 06:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701093995; x=1701698795; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9cVpgXV03qn3ZbRKyd7TAFwHL4wDQt11B3zewIvxYZ0=;
 b=tncmK6bqfyOx75yYB2su5FCsnKbV29R4VSLsImsMjJhIgwLV3HSBgCd093T121r0fz
 xD0on4e6LrAFg3jSTTCHG0VP2Xhh7K39HFXUIWL9FdRgGtsDLFqZcKvtWCRGEYyqBgtI
 xEJDpFqECIGrlIRRQEfDTV6hrNxSBjqtCPMRLYLLtrDn9/LKz+xkztMC0npI+yPzSSRJ
 v93P25zP0tUkaehphyKF8WK2rzMAO/+jD42zwWGLl3ZQfq7Ip18ypmTOOkR5GBer8ZvN
 z41o0cNPmv/koMCsqQ41AY13O7l/cPl0I2FYgim3CUiwnhJidXDQAqwZDiJfWAjk8G7q
 CsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701093995; x=1701698795;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9cVpgXV03qn3ZbRKyd7TAFwHL4wDQt11B3zewIvxYZ0=;
 b=Wbq27V4QruuyFUcTJ6cmVrufhZLDehYQSnPMUGZOfsR7pKL1GzHJVN2cO5QmFau8aG
 lyLCtzmLKOoxzSvcK8CevvXRuJ5mMSfFQ/NwIlrQ6SUsekbIl66VYjoShfJz4V80/V1g
 AKm2bynSIQFxIYfNHwBv0ohynaJQ2cA9/OBodnZY8NusMO02juPC2zI7XiZSZ+rsAvHT
 s/9dvKOClkf1ujh0loRvcvpDsZLeboS7f5VKjOuUXyKvFXW9szk0Zqzh0Wx25pBRlqaj
 JJt2Ja7lcqVxcilOoRhINZOdBSGNGVsj9loptmtgLAG32Jh6DzVB6oWn0pjHMcy7ZZxj
 7AHA==
X-Gm-Message-State: AOJu0Yz06JiVB8/YscD/qV/Jh9XAWO/iT57ipmkHuKazV/p5qVNO7C/+
 cMidsxcYucl+GKCIRGBfi/s+7sSfrCu1QvdGt6L+hg==
X-Google-Smtp-Source: AGHT+IFU0CpOjryj0scl1iszAECYeWorQSMegequln/iOQDYa2Ux1K9i10wDR9FfxQIZOFcIs6zkJBgkj6I7w0REaYg=
X-Received: by 2002:a17:906:756:b0:a01:f628:a07d with SMTP id
 z22-20020a170906075600b00a01f628a07dmr9110630ejb.65.1701093995188; Mon, 27
 Nov 2023 06:06:35 -0800 (PST)
MIME-Version: 1.0
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-34-maxim.uvarov@linaro.org>
 <20231127130828.GC2513409@bill-the-cat>
In-Reply-To: <20231127130828.GC2513409@bill-the-cat>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Mon, 27 Nov 2023 20:06:23 +0600
Message-ID: <CAD8XO3buruEtFvVv32J-LW+Jj=+vFJk2Q+TgBKL130sL2qY0DQ@mail.gmail.com>
Subject: Re: [PATHv11 33/43] configs/am335x_evm_defconfig: inc SPL size
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org, 
 goldsimon@gmx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Mon, 27 Nov 2023 at 19:08, Tom Rini <trini@konsulko.com> wrote:

> On Mon, Nov 27, 2023 at 06:57:16PM +0600, Maxim Uvarov wrote:
>
> > Increase allowed binary size to fit lwip code.
> >
> > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> > ---
> >  configs/am335x_evm_defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/configs/am335x_evm_defconfig b/configs/am335x_evm_defconfig
> > index f048e60f7f..9fd608bd76 100644
> > --- a/configs/am335x_evm_defconfig
> > +++ b/configs/am335x_evm_defconfig
> > @@ -124,3 +124,4 @@ CONFIG_WDT=y
> >  CONFIG_DYNAMIC_CRC_TABLE=y
> >  CONFIG_RSA=y
> >  CONFIG_LZO=y
> > +CONFIG_SPL_MAX_SIZE=0x29000
>
> As probably a problem for other platforms you made this change on too,
> you can't do this. The link limit is here because that's the limit the
> hardware (and ROM) imposes.
>
> You might need to either:
> - Figure out how to make lwip even tinier for the SPL case
> - Limit the old network stack to just for SPL, and a later task is to
>   reduce what's in the old stack to just what's also needed within SPL.
>
>
Thanks Tom. All these size changes need to be reviewed.  Some of them are
ok, I think like for x86 or qemu virt, but some of them might not work.

Question - Do we need networking inside SPL rather than in the main binary?
Is it a real use case?

BR,
Maxim.


> --
> Tom
>
