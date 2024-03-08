Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162DBC5475B
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 17:38:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80F0287F0D;
	Fri,  8 Mar 2024 18:37:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="P78l+F1q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3137587E96; Fri,  8 Mar 2024 18:14:18 +0100 (CET)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8FD487AEC
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 18:14:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=barnas@google.com
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5cddc5455aeso824611a12.1
 for <u-boot@lists.denx.de>; Fri, 08 Mar 2024 09:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1709918051; x=1710522851; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tmp3gxVH8V2jvau3ZVcO0GHzHqLTjDsp6R+YnbiGIks=;
 b=P78l+F1qaBcwe8F3P5pB1KAkDSY7xCUVZxD0lxaAuQOUGe8dpb0C9Y3AMKAneHv5Q3
 U4XwJUuKMbDUgwtzQcFGnZ19ry5bqMgWRT5GOoGPXbqAn22JMT3wqnesJu4nB0ohwn+t
 PuEF1vfD8aD/F/GIYQ5Yr/mcbRa0Neb7D/nAjE1xYX5lLS3YL8XZktCm/vGMGviatZWV
 7MGe58ym841WzCPW4V5E7bNz08p/tXy+KcSm0tPOHUtylMFdSjUM/PlIctMvwH4fJwqz
 zIPUtN7hXWTNuU/eCRuBiHUPLlYnqHWUept+B0aeV/vfjGw9vA1rF0mybFqBQn7E6FU0
 4yVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709918051; x=1710522851;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tmp3gxVH8V2jvau3ZVcO0GHzHqLTjDsp6R+YnbiGIks=;
 b=N9JKCDf09FR6yWXVCs2/fQ+fu5S7VfnkYCjVEE47/+sTsNufNDE9SBN05kIdC3LhzK
 CGu3sE6AdVW3LcgA8nOX3VTwzB3pPza+VuN/FQ2/uJ6IF42XCBtmTrxSVBnIZM2uaL6i
 /JRe4IZ9EKBmt2usgV/PCHN9X1noj+5Ca+VwWzBBcUIvwG8TP0fSR5kk5be+MMB1z0lT
 /Q/R/QS7epdCIFm2nGoOG3r4fJdTiAkkdDXhTH0B2RmGlu5waXVGUSzoADb+msPMvd1S
 JQXtpnH8+XgCa93SP2hSkIbRW6KWdFOZdVxAN77TVEtGiLQyfb5z7X+sTKIuPWU6dvej
 VdlQ==
X-Gm-Message-State: AOJu0YxrfSWAXkQeHIczq6XfE3RUPsIbb0mzMjZwUiSNPN8mUIq0iwRU
 1LvByCCeKAINhNIZHZraOWBF6E5Ni1Zi/BHKzsdMBWCQRK62ZOfq4hXc8AhuEMltbwYEMcjajKE
 TmmWmbspOIC2RxDWMe7oohM66M4BSD7vWvqdEyHH77k1mKzX8AA==
X-Google-Smtp-Source: AGHT+IFChG1CrqUdrJy4XuFLK+wF8De5lbIFLJPKwn5wmtUo2mH1LcBR+v1PwI5tWcqjazaxFpY4kv6CZIFzKZBuIjQ=
X-Received: by 2002:a17:90a:6d22:b0:29b:c172:d31c with SMTP id
 z31-20020a17090a6d2200b0029bc172d31cmr580799pjj.43.1709918050694; Fri, 08 Mar
 2024 09:14:10 -0800 (PST)
MIME-Version: 1.0
References: <20240219163213.855667-1-barnas@google.com>
 <170964466455.2716579.1226354579442657631.b4-ty@konsulko.com>
In-Reply-To: <170964466455.2716579.1226354579442657631.b4-ty@konsulko.com>
From: =?UTF-8?B?TWljaGHFgiBCYXJuYcWb?= <barnas@google.com>
Date: Fri, 8 Mar 2024 18:13:59 +0100
Message-ID: <CAO4U=yvhMk5KgCuyP8vR1_WG0v-F+fY_eYzO_A0emUfF4AKKuw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fix driver for misc/atsha204a
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 08 Mar 2024 18:37:36 +0100
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

Thank you very much!

On Tue, Mar 5, 2024 at 2:17=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, 19 Feb 2024 16:32:01 +0000, Micha=C5=82 Barna=C5=9B wrote:
>
> > Fix the driver to behave like the chip datasheet requires.
> > Improve wake up function to send low signal on SDA line for at least
> > 60us as chip requires to wake up. Fix sleep function to move the chip
> > into sleep mode, not into idle mode. Remove unnecessary for loop,
> > which would never run for more than one iteration.
> >
> >
> > [...]
>
> Applied to u-boot/next, thanks!
>
> --
> Tom
>
>
