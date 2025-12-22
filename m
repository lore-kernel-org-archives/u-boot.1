Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD9CE674B5
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 16:18:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32F9A83B99;
	Mon, 22 Dec 2025 17:18:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YiKm/4wj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C032E83C28; Mon, 22 Dec 2025 17:18:03 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50CDA83B95
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 17:18:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7c750b10e14so1673254a34.2
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 08:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766420280; x=1767025080; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/RoQ9VXPa3k23B+SZzFCwOncG/32NTJJfRFa8ISxYY0=;
 b=YiKm/4wjuwD6IqdBiTQ0cZWCfywa2IrjFtSI1qB1hR31BIUmrvawArK4CZy3fAFnZu
 COq9fMUouAREH6jLMILc7SYjxqm4pmkI4TApcs7ZKHDssm/N9/HPk41alf8x6Ri1/Q/g
 B0koY6Og+X/JVoOm45YXPrvLAVWoL1s+K+fdIGSk9yxstG6WTG/yAFk4MIuWbuqGKjHP
 GbGpDNcoBo+J4q4RaGxeoCAEL4vxtGu0dMrSK77z/riqiJdAOzXjPDpWB1LE98wZP79F
 6R2IPXu2WMNweEORzf98+jvfklpMOEGCDdup/rTONXMX8k5N0pFbOrDshghiSRRpqWqx
 acPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766420280; x=1767025080;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/RoQ9VXPa3k23B+SZzFCwOncG/32NTJJfRFa8ISxYY0=;
 b=lLi+L4Orof6w+Mc0Sp5wDK6NQMg1J+ZjXAMxI0q959B1/3LbzOR1qidMMxImsLVV2N
 POgwCzV7faQidp/5mz6S65TttGzw2tjWMd9KKp5py16h+ONYPSiTeGW4d+15JFeoqgMe
 /yCeiYDRGx0goS0RfZqZoR99knKQG995mgvlv1UMO+87k/tCQyvw71zoDQjhTIF396n+
 u0bRGRPy64FFFrVPLfA1oqC2YehxorZoUP8e75OvvpPnO3U0/wQD0ppLquNEH2YUSsIY
 bqocdVTtz5pCPk4ISFw2RN1rJK1bGRN8YuaRlYBgmjy+FQjdgbvlTA8q8NXCDw2eT6SX
 RVgA==
X-Gm-Message-State: AOJu0YwtdIUF7hYOpK9rGjSt+EIjUCtZpt0HtPci5gDoE649WvlE/EfR
 zvq0VmjvJhek2B/z8SoTjAOLhHCnSeC/X4kqgwv1lRCQRfewu5HOBgH+EKvY9sIRwLVL5bhmCe3
 99pFvneaZ08l/RdbzvfB8zNjr1H9s0mY=
X-Gm-Gg: AY/fxX7ym9c3W96o67/hGZpui0zApupw+MgnWcT2klpRCz1gVc3gzf+vymHhzb9aHbn
 T8EiKhvj7hD0pNyH8nwur5KxrCbZDdptDJ58PX5GK9ayY6UJxsYSEqxbSwCJY9bYxK+/7fekqEB
 hbW5jg77obJhTeM1e40545TwWTjtXoLQOAnWeRbT/JykTK5VUUYYoNZHWrnKgd9My9E34UAcn4e
 T79lToR/IdQy4nRYDoZQWXv3nC8faP0lA8xYSOc0fJChKltfM/OzzP5DGzIHL7KbhRUSlI=
X-Google-Smtp-Source: AGHT+IHVrXTISnqsn3gaKll4n0ys93uVhqEaE5YMdmOhxarryIYoEALgeZIuq7v9VgBvVDyLQ3PIHq4WAdxwQ3MHfSs=
X-Received: by 2002:a05:6830:6d4b:b0:7c9:57ff:4cdf with SMTP id
 46e09a7af769-7cc66a8291bmr5341601a34.25.1766420279901; Mon, 22 Dec 2025
 08:17:59 -0800 (PST)
MIME-Version: 1.0
References: <20251222142744.74707-1-briansune@gmail.com>
 <20251222145627.GW303283@bill-the-cat>
 <CAN7C2SCOMVjujtDk6kwpQWkWNxM6fkM8TbS60+fF=LSkwSjORA@mail.gmail.com>
 <20251222160830.GX303283@bill-the-cat>
In-Reply-To: <20251222160830.GX303283@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 23 Dec 2025 00:17:48 +0800
X-Gm-Features: AQt7F2ojy5MIUr9gOOaRxUwH1TibSvnSbCAA9dpRd8stuDK9UGkK45c1tY63y9o
Message-ID: <CAN7C2SB0wqJiLVA9y3x54di5X1tey1WLwM_VsZGaLq5ZUKxJKw@mail.gmail.com>
Subject: Re: [PATCH v1] fix PL330 CMD supported target
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Tien Fong Chee <tien.fong.chee@altera.com>
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

Hi Tom,

On Tue, Dec 23, 2025 at 12:08=E2=80=AFAM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Mon, Dec 22, 2025 at 11:10:32PM +0800, Sune Brian wrote:
> > Hi Tom,
> >
> > On Mon, Dec 22, 2025 at 10:56=E2=80=AFPM Tom Rini <trini@konsulko.com> =
wrote:
> > >
> > > On Mon, Dec 22, 2025 at 10:27:44PM +0800, Brian Sune wrote:
> > >
> > > > The config is wrongly written, result
> > > > in only support socdk board.
> > > >
> > > > Fixes: 92dcb3ad5d98 ("cmd/dma: implement dmareset command")
> > > > Signed-off-by: Brian Sune <briansune@gmail.com>
> > > > ---
> > > >  cmd/Kconfig | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > > > index 5b9c13d85e7..5c611fb3016 100644
> > > > --- a/cmd/Kconfig
> > > > +++ b/cmd/Kconfig
> > > > @@ -1849,7 +1849,7 @@ menu "Shell scripting commands"
> > > >
> > > >  config CMD_C5_PL330_DMA
> > > >       bool "Release Reset DMA Channels for PL330 Handshake"
> > > > -     depends on TARGET_SOCFPGA_CYCLONE5_SOCDK
> > > > +     depends on TARGET_SOCFPGA_CYCLONE5
> > > >       help
> > > >         Provides access to Reset Manager Per2ModRst. Enables DMA
> > > >         channels for ARM PrimeCell PL330 via reset release.
> > >
> > > Now that I see how mach-socfpga is abusing the TARGET namespace, I ge=
t
> > > why this patch is needed, so:
> > >
> > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > >
> > > But really TARGET_SOCFPGA_CYCLONE5 should be "SOCFPGA_CYCLONE5" or
> > > something as it's not a board to build for.
> >
> > How to properly improve or fix these TARGET things?
>
> Well, the TARGET namespace is for machines / boards / what-have-you that
> we're building U-Boot for. Symbols that designate architecture or SoC
> generally just say their name, hence my thinking "SOCFPGA_CYCLONE5" for
> what to me looks like the architecture family of Cyclone V and the
> things common to all platforms. And TARGET_SOCFPGA_GEN5 should become

That is completely correct; it should be grouped as GEN5 - Cyclone V + Arri=
a 5.
But I had no power to fully turn those from this situation.

> SOCFPGA_GEN5, or maybe omitted entirely (and it all goes under
> SOCFPGA_CYCLONE5), I don't know the parts well enough to say what makes
> sense there.
>
> --
> Tom

Brian
