Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9337C3DA4B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 13:35:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9AD588924;
	Mon, 15 Jul 2024 15:31:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="STKWIgYa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C16A88927; Mon, 15 Jul 2024 15:31:56 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FAD188827
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 15:31:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5ce74defe42so834087eaf.0
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 06:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721050312; x=1721655112; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lxSLh3QDR0CGFSCMnVXFLeeRX5IO+NVVCfPkliJMSzk=;
 b=STKWIgYab7dRFr72uqBBbGB9epPjQWUI9YoWkIUi+yRUlkuoH2hQM46Zoc8ZSIqmej
 438bvxj2TCJMiFKDyppoYa5JHJi6k9PiI0L335mpZVil8IOaF8vClgAYZvDBxxSYycAv
 1LATwpcGiFC6ChekEu2qHH8AzQyFEhL4/0bCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721050312; x=1721655112;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lxSLh3QDR0CGFSCMnVXFLeeRX5IO+NVVCfPkliJMSzk=;
 b=RmyBda/OoLosyLgKCQFHtgVc4TtIa9MojbWzbTJbKhrGY0v8TmSvke0eMMRu0HsP/d
 /bU8Bw4ZpYlDfLwhmkWmisKgmHHjEcOb1Bl3+h1pd9Im8gmevYIoQxh6pGyQAE+ji//F
 vzk+qiHyzRSP2NQvMAl7yTkA9pgbvJZxdLh+EK+EHqwl9nSTPkXUSYofOBD/pwvLtSEF
 kF6X2GaV+5HWcjK9+vIwwBZsgkuxDgVLzCzox3RTv0/dC4wwizKx81rAWUb7eK+q7gLF
 OllsFu86qvW0VUt3E9Ist0wX1bp4ZKzyzcsGb5wut3/OnF3Au7JWrczKT2N0MN1Nyg3j
 rl0g==
X-Gm-Message-State: AOJu0YzA2I+ZrNyiBcTtQ3U1ii1nIk7wqc6LiOE+OwzvPy0ADvt3G8TG
 dUMAyXeXNB0wATuudJB84gb6Bn3qwpXqkseIoZjJ0oCsqC5E75N8hD0KXoaH+NEahOT2zfoQTxG
 W+r2gGOsxCTiw6Cb2ghwvqhZ8mT62HX4gcz81
X-Google-Smtp-Source: AGHT+IEbx/f2RCmB6GfsuBYlxKWtvgZYY4w8J/tVIMR7lYxTUH50et83+WeAc6ZCjq4Cgl5Q3sXo6zQ2haLVn6Gmvys=
X-Received: by 2002:a05:6820:1e04:b0:5c2:2033:db1a with SMTP id
 006d021491bc7-5cce6d5453dmr9255791eaf.4.1721050312202; Mon, 15 Jul 2024
 06:31:52 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jul 2024 06:31:51 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <BN0P110MB167322053D93D4F977CF9061EBF9A@BN0P110MB1673.NAMP110.PROD.OUTLOOK.COM>
References: <BN0P110MB167322053D93D4F977CF9061EBF9A@BN0P110MB1673.NAMP110.PROD.OUTLOOK.COM>
 <20240604161607.1133032-1-brandon.maier@collins.com>
 <20240604161607.1133032-2-brandon.maier@collins.com>
 <CAFLszTi1G44DPY8rMH_+sPkmSOfotxGSEJM=ec64VQzCr2==Bg@mail.gmail.com>
Date: Mon, 15 Jul 2024 06:31:51 -0700
X-Google-Sender-Auth: tIh--nWphEmJ1V9NEkHuAQRLvYI
Message-ID: <CAFLszThs1wvaqWcDq3WMmJKcbW=_NKYtpJ=y+5cLw4fQwiLWwQ@mail.gmail.com>
Subject: Re: RE: [External] Re: [PATCH 2/3] tools: binman: fix deprecated
 Python ConfigParser methods
To: "Maier, Brandon L Collins" <Brandon.Maier@collins.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Simon Glass <sjg@chromium.org>
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

Hi Simon,

> -----Original Message-----
> From: Simon Glass <sjg@chromium.org>
> Sent: Tuesday, June 4, 2024 9:14 PM
> To: Maier, Brandon L Collins <Brandon.Maier@collins.com>
> Cc: u-boot@lists.denx.de
> Subject: [External] Re: [PATCH 2/3] tools: binman: fix deprecated Python
> ConfigParser methods
>
> Hi Brandon,
>
> On Tue, 4 Jun 2024 at 10:16, Brandon Maier <brandon.maier@collins.com>
> wrote:
> >
> > The method `ConfigParser.readfp()` is marked deprecated[1].
> >
> > In Python 3.12 this method have been removed, so replace it with
> > `ConfigParser.read_file()`.
> >
> > [1]
> https://docs.python.org/3.11/library/configparser.html#configparser.ConfigParser.read_file
> > Signed-off-by: Brandon Maier <brandon.maier@collins.com>
> > CC: Simon Glass <sjg@chromium.org>
> > ---
> >  tools/buildman/bsettings.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> Does this still work in earlier Pythons?

The Python docs say ConfigParser.read_file() was added in Python 3.2.
The tools/buildman/pyproject.toml says `requires-python = ">=3.7"` so
I assume this is fine.

>
> Regards,
> Simon

Applied to u-boot-dm, thanks!
