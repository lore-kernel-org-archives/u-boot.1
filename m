Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A73CA0EED
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 12:24:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB38D831B4;
	Thu, 28 Aug 2025 14:24:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gHWi6IE6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3719832C8; Thu, 28 Aug 2025 14:24:23 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F41B83192
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 14:24:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-71d5fb5e34cso8293197b3.0
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 05:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383858; x=1756988658; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rnjlzXg/cOqtLl6Gubn35QZ8acatGKrPpzwavlussz8=;
 b=gHWi6IE6B8umwJJEVRGSOd/1un8rdp6mlVQgL3Ml1TIj38VoYx3t3ckTtVCocRqpVI
 EPZZcFGXElJW0qWM36DoG7AD8FxxbGC4J8P4K7ntUjYTVJZZnuts3xAFVCfwakqvrq6p
 ua5QjhP4slnOFVsCGeCARDL9RFfK42SF7QnLWw2e1Yp/lb0aANH3UQWmgeKXFqIPdQQQ
 Tgl8rmgCc0r9lMIraA4jXOkK0FrlElK+TPY0+//l7pMu9ha+a6v2lu1+u0s5c+Nsj6ar
 WOmzJnq6ZOafYPkpYK6GfwymvOB3TBAeFqeNruboMIiVuPhtBFV7IVqQ/jaS2hn6SrvJ
 rS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383858; x=1756988658;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rnjlzXg/cOqtLl6Gubn35QZ8acatGKrPpzwavlussz8=;
 b=cZ1i6/42KGhNv81Duyyt/YB3tDf7Ytt8nvgl0khI5UZmE47IRunY5PRLCKPfEPucnt
 RqBz3BpO+ZlRXZM0sA7Q44QKpo1XJor9GEDkOnpLkzFr7eK2oP1cVzoXchnC78Ua0OUK
 JS7kn5TwLdcxpP6mCqqR17RUj7shBjJnjeTQh0E9RB68n3/ps2i68D5hsaaPnBFGracL
 GCGJCGPgeE2Z35lSwYhm0TWm71XCqyBRFeav/537iWfzx7B3P/LzIMuZj3HlrSza33Sg
 ep52Knb4bbmi4ANp6c5T5epakpMtSAsOLO5JssKbiIrqVnXJUMyoS9d1TaOmNw2bx61I
 pTaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqzhHqMoN1g8LK9ZIeBBHeOnp0u08YLM5fPYGQxSOTC3hG7iQMz8alxQJuZ3G8bvXh27Mq+NI=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2X7zGMpcamtkIwzrcmx9efXZl1J2G20BVQPOAx/CoEJgHmqvA
 bBX8I1EgjrR+jt5wAnhD37mQcRIHiwafAgoOEmiFiPs8TUqXllrYd/kalh8gRwHC6YFrU4hQl34
 zPrLxv4etCHLmNbLbfKI98+1RuL/+mOIecBVFlR+eWw==
X-Gm-Gg: ASbGnctB+nVFP5cGndCZM12xcgDb4b0UvE2rKYS0GpsPvr6Z0e4ihVrr0mfGAfvT9ct
 aMqSJcD5aU+nPOPlVr+SUFci7ugMn3FxZGjrGjRiqMeOEgU1d/uzPo0alZJYAi6TTAFDZ/khHG2
 YNbux4DCO6FtChy190THBTiII0rxb6B4aLYi/dGr23CMKgUQC6aSB+RIzP7dYXcjHGeoJPvgb2u
 cCrouxBJ6DSiDumMZIXfuA/66nBR7PdYsfi8MJptBa5Xc/cj4Npt5wj/eADqI0MLTg40064pO7K
 IGWZ3csf+CVMWRgLecC1XVNP7O7NjRdnmBB1ThrSZO8z8ufyXZmMe46z2FlCtt+WXFvUB/w=
X-Google-Smtp-Source: AGHT+IFqKgyzMApCU9dXDoJ2jY7z8bWtMsK95nNDYV4cMaxn4MiepahRKYT9zRHZsMUcF72Ei9mlV3mnp7k2wmf9tEc=
X-Received: by 2002:a05:690c:2606:b0:721:2c21:3614 with SMTP id
 00721157ae682-72132cd7378mr109524677b3.22.1756383858215; Thu, 28 Aug 2025
 05:24:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250724090009.569341-1-balaji.selvanathan@oss.qualcomm.com>
 <20250724090009.569341-2-balaji.selvanathan@oss.qualcomm.com>
 <CAC_iWjK5d7z-J=rbXa-_+2zjejWOuTJco87-yqJVXtuXmVjdNw@mail.gmail.com>
 <8730e084-5541-4df5-b067-c97e540b5f37@oss.qualcomm.com>
In-Reply-To: <8730e084-5541-4df5-b067-c97e540b5f37@oss.qualcomm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 28 Aug 2025 15:23:41 +0300
X-Gm-Features: Ac12FXwIKs7Vhg8rVpGW_ESX791zrMEkuTkNTvtXVh6oaLA05PCouH8wpodOMko
Message-ID: <CAC_iWjKTeNTwyQE0KoAApF_qbd1c6ftTnU8jx85sVNBTnYJoRg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] efi_loader: improve device path matching for
 partition lookup
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, xypron.glpk@gmx.de, adrianox@gmail.com, 
 moritzf@google.com, sjg@chromium.org, maks.mishinfz@gmail.com, 
 javierm@redhat.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
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

On Tue, 26 Aug 2025 at 12:07, Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
>
> Hi Ilias,
>
>    Sorry for the late reply.
>    If i point to esp, then it should work.
>    But in the boot option generation, they are skipping if its a partition:
>              i.e., in:
> efi_bootmgr_enumerate_boot_options(), in this code (line 838):
>                  if (blkio->media->logical_partition)
>                          continue;
>    It seems that, by default, the boot option generation logic is not
> designed to include partition as a boot option; Not sure if this is
> intentional. If its not, then should we correct this logic?

Yes it was. In fact the original patches were adding the file instead
of the disk [1], but we had concerns on scanning all partitions wrt to
boot time. I don't remember if anyone tested the boot time though.

[1] https://lore.kernel.org/u-boot/A2082A91-A1CC-43E8-B151-968D7746B906@gmx.de/

Thanks
/Ilias
>  Your inputs
> are appreciated.
>
> On 8/5/2025 1:17 PM, Ilias Apalodimas wrote:
> > I am not sure this is a bug. The EFI spec says that in order to
> > trigger a capsule update you need to have an active boot option
> > pointing to the same ESP the capsule is installed.
> > Is your boot0000 automatically generated? If so it doesnt point to the
> > ESP and the capsule update doesn't trigger correctly. Does it work if
> > you manually add a boot option pointing to the ESP?
