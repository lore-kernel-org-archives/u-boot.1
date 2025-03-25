Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99FDCC35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 14:20:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD2B2808B6;
	Tue, 25 Mar 2025 15:20:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EtBPNuFJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA0E880EEF; Tue, 25 Mar 2025 15:20:30 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 795ED808AF
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 15:20:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2ff6e91cff5so9893717a91.2
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 07:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742912427; x=1743517227; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BFG2EoZ/voU3JtoCKG6bXPSkkWThLY45VhkzPBMORfU=;
 b=EtBPNuFJlnTWsGjcL9mZDrA2Dn1Wjr4eJ4Y4pds61qXAjWrdgd0Y1+CGAwkfKkabuI
 PDUnOnJqAwqH6ypwHrwcsdUVQfBVYl4hr2nAGrR4k8Zyfgx87/7YFewGxx249Q5s1Uy7
 oHNAe6xCn0jCXDqeTD+lHVx992UFx9sU3wlEwEctAoW/BSE4fbJtGU7u/GQMgwGO1skk
 yaNET/6gZ9jLnEEvw2eYl4oal/qBaZA48ln8B7K1JIGySyfTKEefKN+PhaQjqUn94aIT
 08MwQNDfu6iX7P+5WIWHMnIxHsUw4LUPo70gWTX1mbndKMwEsJXnNrxnvfmd0QuM2RG8
 QV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742912427; x=1743517227;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BFG2EoZ/voU3JtoCKG6bXPSkkWThLY45VhkzPBMORfU=;
 b=FqWihCLVHhW5SUBr+Xa5h+PDiRO58u8O/6PZZAAKsJAYM6eQZGDvLOUgahRuKBVHYc
 eq5R7mzDij3zmokKmwa1u8ZF8uH+IliUtKxdFLcQfrqwkfXOyiSumULtZVMX2FdvsS6B
 8H0Vpnu4/CkxU/+YJ+TM4kU+osHaUsXGHg1rm+pmNMGqXM6nCftSf+kazR1mHAqNmhLL
 G3OgnBX+tnnT/O6z/TpHCSlV0YJomfql2J84UAWBjeYAi/F2pSYMZoBhtqiHaHeVX0On
 xHnRuyykJJQpma3zYXusnViBNjb4si9gVQhjEeLTUnyrS60GVDVVBTwsCJNvQ/Qwj01I
 l6Qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXL4r1BZsG9O8J7tn8hJ3MExLiy9DCH5s4Irl8wRlAAZg0TkjDynMlENjEs4FGfFgRnEgXcM9A=@lists.denx.de
X-Gm-Message-State: AOJu0YwKtTlrvoT2zbtpkw2MtT24IEtfKyPyYL7P/u3NsEfRLzzi7be2
 X1OxzwwV2C+qfqEX1n/WuK6U6qlsYr5W2t3A8ZeKNgskyLAKm0dDZeKJwzfkYIjiEf3fNTBrrF3
 5G4fkXTfyFp3gmmQc/U8XpfXZ9NU=
X-Gm-Gg: ASbGncvA7aEXFWqqwO4JNs+2Pxz6H3qWjhdSwVycByC7EQgElB6N4q7JPrfadYOrmHM
 35zWwqDRp3RURhGVYdkyuJjHSidLBGW5gJAknIkCsmE7OT3Qk4i8v9+DGpAwacKE7uYZmH8kiiB
 jned144rRbkFrjXy7R/OMzpHRXGA==
X-Google-Smtp-Source: AGHT+IGJsQHvAROE+Ahkibrdf+ZcxXguGMZ1gLk4uOlSfyK4YlkQjkcN5EiM2eJ/9RtUGZMm/5RgwLHcKOU9dutDxTc=
X-Received: by 2002:a17:90b:4a4a:b0:2ef:31a9:95c6 with SMTP id
 98e67ed59e1d1-3030fe95a80mr26710894a91.14.1742912426719; Tue, 25 Mar 2025
 07:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250325025452.950303-1-aford173@gmail.com>
 <20250325025452.950303-5-aford173@gmail.com>
 <6f58a557-d5b4-4bc7-87b0-6ed626ec534a@mailbox.org>
 <CAOMZO5CT0uevQaPWPAHM0qVULy+f6rsbwE72Kkph48ghpOSKkQ@mail.gmail.com>
 <CAHCN7xJoJYmZCG7e+zv3cJc8B460kqWpz8v-KibsVsHJzbpjUA@mail.gmail.com>
 <fd77d34f-835a-4186-893f-b3d8071ce662@mailbox.org>
In-Reply-To: <fd77d34f-835a-4186-893f-b3d8071ce662@mailbox.org>
From: Adam Ford <aford173@gmail.com>
Date: Tue, 25 Mar 2025 09:20:14 -0500
X-Gm-Features: AQ5f1JqNqVS2CQATfvB-HmxeAEy1OndwEBc15KXoGvjSRA3gEv0LXaJEEyKHMog
Message-ID: <CAHCN7x+Qxd0mRQ1mUyKbcWUVVb6br4cQsL9ia5zP1a3ckyO93Q@mail.gmail.com>
Subject: Re: [PATCH V4 4/7] cpu: imx8_cpu: Print Speed grade if IMX_TMU.
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Fabio Estevam <festevam@gmail.com>, u-boot@lists.denx.de,
 aford@beaconembedded.com, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@denx.de>, 
 Enrico Leto <enrico.leto@siemens.com>, Peng Fan <peng.fan@nxp.com>, 
 Yannic Moog <y.moog@phytec.de>, Gilles Talis <gilles.talis@gmail.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Ye Li <ye.li@nxp.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
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

On Tue, Mar 25, 2025 at 9:14=E2=80=AFAM Marek Vasut <marek.vasut@mailbox.or=
g> wrote:
>
> On 3/25/25 1:37 PM, Adam Ford wrote:
> > On Tue, Mar 25, 2025 at 6:36=E2=80=AFAM Fabio Estevam <festevam@gmail.c=
om> wrote:
> >>
> >> On Tue, Mar 25, 2025 at 12:37=E2=80=AFAM Marek Vasut <marek.vasut@mail=
box.org> wrote:
> >>
> >>> Please drop the fullstop at the end of Subject and then add
> >>>
> >>> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >>>
> >>> To the whole series.
> >>
> >> Adam, no need to resend. I will take care of it, thanks.
> >
> > Sorry about that...again.  Thanks.
> >
> > Once this is complete, I'll have a smaller patch series which shrinks
> > my 8MP SPL code by around 4k by #ifdef'ing out dead code.  Hopefully
> > it's not too cluttered, but that smaller series depends on both the
> > UART clock and the CPU_IMX updates.
> Nice, thanks !

Don't thank me yet.  It's going to increase the ifdef-ery, and it gets
a bit ugly.  I'm tempted to throw in some To-Do's, because I can see
some more improvement possibilities as I dig into some of this code,
but I am not prepared to touch them yet.

adam
