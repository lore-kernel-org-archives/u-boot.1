Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1C1C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 10:44:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9721881DED;
	Fri, 28 Mar 2025 11:44:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g1w9BM6m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C54C81DDF; Fri, 28 Mar 2025 11:44:47 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E467F805C8
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 11:44:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ac3eb3fdd2eso398032166b.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 03:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743158684; x=1743763484; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yg97Y7a1huV4MYgGozVfIlYJAh5PQv1FFkx0Fs4vafM=;
 b=g1w9BM6mK0zRtSXIQO/FrYUVSTH/UXM2RolkwXQF72W2uCSdzQP0iTPCh6XmYOBtf2
 YyQDL0TJhBDIH5vwVZL6Ko9BbK6GJDWiVTHzI9P9dGikI0I+8dZItk+rOXY28m1bN490
 wKTXDxtfxvrZXsFB+joLN3VFkNvGdWQR8hayc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743158684; x=1743763484;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yg97Y7a1huV4MYgGozVfIlYJAh5PQv1FFkx0Fs4vafM=;
 b=aPedfGbXjGqvFCDA45NMmBGQGvaJfWPaxk0TCatmd5ITuM1ivAU1Ftx+9H4hI/NiaI
 G9QeTTbpAEUM7TEFMGyUYEr+aywPUTz2ym99TxRd1fjAKvSIwdVcLnKhCD5WnlbxF0Ss
 FXV/u+5gcJaA27M1U51BTjpEJA2kc9kZ4oE4RibEsAFG/8okFrZAvj6+AHOiAVJlFkAS
 s2WAQuXYbCOHbCFVEeD1bBwpjYZckCPFicvCRbPz7u1NNNzVi6atjCm1z8x4AbraqumI
 rRy5ZzZvayXzDsw+Y0/fXoFOei2r+O+eVJGu7L7OkQzxkCEFIHDKv77pOL9a28tD9yqQ
 udVw==
X-Gm-Message-State: AOJu0YysV0JWP1KpA9+zzxoxjYNjIEcJMJYC9GUbd4kmKU1Cc91qLItc
 Mm2FnstWvUUK5rfCPo5hCJMflT65w8RQDCwY6cXp9avlKCiFea9Uoqa9xEzssqPwXdGO3E0dGtc
 PatnQqhkI1Nxyy7GiCfDqd8DJKMTIJuEYXmx7
X-Gm-Gg: ASbGncvlmL6K6bX+KcvjokCqtD81XKuFrpkZtvFOhOBbRSTFc4lRJQ2nrnRseeeTOEI
 B4APpYWe1igOSObAyGzsfeMHI6vSLKY7CemzMBuGrP3rG+kI5aIbH3AYgDH/VVWmy7LmLfxmPDe
 sJ5+AoK1XRS+jNiNTWfJIh9cRBVl0=
X-Google-Smtp-Source: AGHT+IG5hjwBncc1VhxQ0GItwWpeuiPBOiGgi/Ntl+wiSE1+SBZpbJT/EFXjEMmUfaYNd4DYGiJPBNPpwzot8axjyCg=
X-Received: by 2002:a17:907:9490:b0:ac1:f002:d85d with SMTP id
 a640c23a62f3a-ac6fae6c9e2mr665734166b.6.1743158684234; Fri, 28 Mar 2025
 03:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <3097333.a1USZiQ7eK@anvil>
 <df93a047-2a97-4028-90b3-510b9c75493c@koansoftware.com>
 <2017235.OF7RDaNIJX@anvil>
In-Reply-To: <2017235.OF7RDaNIJX@anvil>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 28 Mar 2025 04:44:32 -0600
X-Gm-Features: AQ5f1JqvE2QV2FNirdIcCBC7e63XATd09w7XtX29vTv1PpczWGy9NvKmIsWy96I
Message-ID: <CAFLszTiMKXMzP8+b4iTWFiiHSmCSZiLctYZLMp-TfuW-AFHPcw@mail.gmail.com>
Subject: Re: Unexpected RPi5 Behavior with Saved U-Boot Environment
To: Richard Weinberger <richard@sigma-star.at>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Mauro Salvini <m.salvini@koansoftware.com>, 
 upstream+uboot@sigma-star.at, Simon Graber <simon.graber@sigma-star.at>, 
 mbrugger@suse.com, pbrobinson@gmail.com
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

Hi,

On Thu, 27 Mar 2025 at 10:32, Richard Weinberger <richard@sigma-star.at> wr=
ote:
>
> On Donnerstag, 27. M=C3=A4rz 2025 17:24 Mauro Salvini wrote:
> > could be related tho this [1]?
> >
> > I sent this patch some years ago but was never accepted in u-boot tree.
> > But meta-rpi uses it in u-boot recipe [2].
>
> Uh, good point!
> In our initial experiments we have used meta-raspberrypi but now we don't=
.
> This would explain it.
>
> IMHO this patch needs to be reconsidered.

It seems i hit the same problem when I sent this series:

https://lore.kernel.org/u-boot/20241220003447.2913443-1-sjg@chromium.org/

>
> Thanks,
> //richard
>
> --
> sigma star gmbh | Eduard-Bodem-Gasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
> ATU 66964118 | FN: 374287y
>
>

Regards,
Simon
