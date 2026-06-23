Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D40CDB46F
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 12:27:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC7B5849CE;
	Tue, 23 Jun 2026 14:27:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="IpEULZ7V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA1E4848DC; Tue, 23 Jun 2026 09:01:18 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D7AB849BD
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 09:01:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0AD823F60F
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 07:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782198076;
 bh=JTje4g2OQz5cIp8XJe/GynwQymS1aG8qNZqEC4hH944=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=IpEULZ7VeVjERs3N3ALu+Yy3H0uqMWSdH53stZcLmRTFGu39xCwfxeP7G6CU2alom
 oRl4+QNlSk+Hg7T4Wn76Lfft8NS0h6f00UV3RQObuaCMQa95iUn5nSFGufJYrwTklH
 4rN2EmOHmiTQItVk9b9ZzS7OgFrZCW3LeOTXXzlx4suMg0LzEv2zaOkvGo2uZw+IMc
 kw+XTEhSMYbGGd0jhknXuX6zc8aXFblodBJ/YNos3GFS2ef40o5o5Z9+2ygqjWAOg2
 i6gk+3PMvNin99n1/tq4zvBEoHcLVswgWYwaKDBxFMqwdDhRwBPkt743Y4bLOeJbbx
 brv8Tp/T9GXSTSOlQsc6/3ex8vQa5CxVkY8qb6YS4Akjrk5HjRDZEuwEdssbacBn+C
 zuf0joKciWuG1oogoC/DXfskzUfPkzoGg7IFUJPr5kDESh0r1Zw58x/kuHTjj7UJKk
 8oIGggYe86TTTZWqiVse8D8CNo/9e1xR4yHOMQi8C85ijAbKEM+nZpFGsNm6Jm2h36
 MCCtf6QLCsWV4H8W5qniAX48hw+K+b4RJwYOmYJvG4StDzfcIuObJtcEqkvGD0YKJr
 DG5TkIe+R2/uwkLwU8Z2vlFQdbi2BtLVT1eYfX0h17fegDSp+L8EfvFmxCyW2Nh0ie
 PlL2tcatC4wXrMWhpK7ZFL8Q=
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-69790cf5e04so3157321a12.1
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 00:01:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782198075; cv=none;
 d=google.com; s=arc-20240605;
 b=KifebtO48Z4OtqstSKUJKDa8ahv95OnoUB8by4L/dyqJ7PYdcufQ/rtwg0q240udt0
 5vEi3M4nEtzkLqKZ2gkZ1ZRdGmRYtJsvovbh3IOAfbqv49LnPCRUTaCVm70ik/PNvxNk
 ZanvxhD71HzLXTaoxenlMVIK7eiou+rDgK9XBgIDWe9jZ2RSPEfgasW2cJOcTVb7VRuX
 4wSYzm7I0M6lI/gxGugGO0e7jh57Dd51cHfFZtcGjiKTOXrLgM7lZEUucROqGQrJB+BF
 cqfphjtitN2WrWj66+BNaq6Hj6FDVU3Su0Plg7Brq+dhbVDG83b+F8UXAdieZktRqVfN
 TOGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=JTje4g2OQz5cIp8XJe/GynwQymS1aG8qNZqEC4hH944=;
 fh=mdsmup2s7wAygcRFHGz8isaaR011FtOQbhO9vcN+g80=;
 b=EOViKOAhzV7fiqpJX0j6C9VjPpL19fxcdJdct3+JSbtHDEud77xoFxMLgLDLlocKgr
 EzAK3udV16RJKwe9Eicu4U+lQY/IkMouc4xs41atSIut0v13XcWp7z9x04amuJdFOEds
 F/NJvT2fFJvf1XLmqTCjshalBu0w8buhRV8YW4ztxLFYVVRsSbmU2CmyzUE8W6xCUlWb
 L/S0hemZUMYWhUVJIoBEZG/HjkcNmgygrgh2sk7fhN8+nu7FtwhZsu3wkJawn/HTdT8+
 dguAi2HKhlVZi0tZM3gOXG1y8nSTjh0wmTTAVJ8yn1InMRpbgi9Ow1Wh8pqnI8tXKqZt
 xHoQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782198075; x=1782802875;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JTje4g2OQz5cIp8XJe/GynwQymS1aG8qNZqEC4hH944=;
 b=XqXidvu5qN02eLQ+IkNaLvzgny4akK20MJk62PFB2jOdTR3S68kMUPAxWz39umAfDt
 frmxFZ2c7gI+89X+NedgVeFHK1WK96W16MfmYosiSR6OQEA+8ukRpqc6PQKMIP4qaDWe
 7mhHBDVNPewP9pEZvp0qWug5SlU2tMeTW0aUT4ZvlY2vF+Wp+C8CFguQmvjkFfvDHZ+s
 rXlP3FpXYInY4H2fDlpW5wj/G2CHmMdWYtcDEyE8dsnOVMzZTSmhfLg5EWG8Pa6Vy9cA
 MfhaCV8xLEc4524MoRSgpqnMmvVamb2xeGmgZzYLZH82g1IVAfofec6KsJFD+64/yhJn
 vvAQ==
X-Gm-Message-State: AOJu0YxEmGYsUYBa1nidlqNJgF0J8FhBf6cKzdC5KcK35dMN9GVNU5T7
 9N/vHJ7wdk5c81jFKtD+jAddqUZ25xvC+RRAKKkjc25HVZJJytVJNAvJgPHkc0W7yK0P045956T
 wipYyzWgSo/1oq45szq+69dGSEubdxZBF0L6pIBeFDnlt1zgDFm1w0miEi7jnu81y/ABuJ1yxaD
 Um9LzVvrNJWh7WxJoSrp9AO2eB84UIH7LG1QctwR3aLhDXDQ==
X-Gm-Gg: AfdE7cnWfpeXjAlJVHVFk4LYDKxeq0luMM94Yj2fMJkqxuUuy3GVNXAvDn2GQYYAOPB
 dq8cXzvXbLVXbjUi/8Eq/65qQ5WiSQd3GTu62hWRyHbS4/iS8nSTiXG2MBsjzVNmpzeq50oIFXh
 NxBbq9rXQQdI6Z1ynJJJRuCwtOW4TkXqc4BTWL2VLLmVpE1Ns048BN6S+6xs6KY3Iy5leX
X-Received: by 2002:a05:6402:254c:b0:697:de64:ae9a with SMTP id
 4fb4d7f45d1cf-697de64b4b7mr300481a12.6.1782198074270; 
 Tue, 23 Jun 2026 00:01:14 -0700 (PDT)
X-Received: by 2002:a05:6402:254c:b0:697:de64:ae9a with SMTP id
 4fb4d7f45d1cf-697de64b4b7mr300193a12.6.1782198072220; Tue, 23 Jun 2026
 00:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260528132746.719699-1-aristo.chen@canonical.com>
 <20260528132746.719699-2-aristo.chen@canonical.com>
 <178219548553.1317404.18395162615291306038.b4-review@b4>
In-Reply-To: <178219548553.1317404.18395162615291306038.b4-review@b4>
From: Aristo Chen <aristo.chen@canonical.com>
Date: Tue, 23 Jun 2026 15:01:00 +0800
X-Gm-Features: AVVi8Cfgl4u2l7gk8_dMsdh9xXMW1WheZJn_bXFC7D23C7AC1KWACitRnThxqPk
Message-ID: <CAA=k7=k2Xunx4pGujZTfK9kQmtFkDdJG0o29BkNxHdSbA=uguw@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] arm: k3: select tifsstub via
 board_fit_config_name_match
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Sparsh Kumar <sparsh-kumar@ti.com>, Suhaas Joshi <s-joshi@ti.com>,
 Andrew Davis <afd@ti.com>, 
 Paresh Bhagat <p-bhagat@ti.com>, Dhruva Gole <d-gole@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Beleswar Padhi <b-padhi@ti.com>,
 Moteen Shah <m-shah@ti.com>, Chintan Vankar <c-vankar@ti.com>,
 Aniket Limaye <a-limaye@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Wadim Egorov <w.egorov@phytec.de>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Vishal Mahaveer <vishalm@ti.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Andreas Dannenberg <dannenberg@ti.com>, 
 "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 23 Jun 2026 14:27:36 +0200
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

Hi Anshul,

On Tue, Jun 23, 2026 at 2:18=E2=80=AFPM Anshul Dalal <anshuld@ti.com> wrote=
:
>
> On Thu, 28 May 2026 13:27:10 +0000, Aristo Chen <aristo.chen@canonical.co=
m> wrote:
> > diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> > index 19a6e24f38b..f4c6c4f098e 100644
> > --- a/arch/arm/mach-k3/common.c
> > +++ b/arch/arm/mach-k3/common.c
> > @@ -191,6 +191,33 @@ enum k3_device_type get_device_type(void)
> > [ ... skip 22 lines ... ]
> > +     name_len =3D strlen(name);
> > +     suffix_len =3D strlen(suffix);
> > +     if (name_len < suffix_len)
> > +             return -EINVAL;
> > +
> > +     return strcmp(name + name_len - suffix_len, suffix) ? -EINVAL : 0=
;
>
> Since we already know suffix_len, a strncmp might be better here. Also th=
e
> ternary is redundant since -EINVAL would still mean the 'invalid' configu=
ration
> is selected.

Will fix it in V2.

>
> >
> > diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
> > index 466ad22f895..37ff98d8992 100644
> > --- a/arch/arm/mach-k3/common.h
> > +++ b/arch/arm/mach-k3/common.h
> > @@ -55,7 +46,6 @@ const struct k3_speed_grade_map *k3_get_speed_grade_m=
ap(void);
> >  void k3_fix_rproc_clock(const char *path);
> >  void mmr_unlock(uintptr_t base, u32 partition);
> >  bool is_rom_loaded_sysfw(struct rom_extended_boot_data *data);
> > -enum k3_device_type get_device_type(void);
>
> Why the move of this function from common.h to hardware.h? This header sh=
ould be
> accessible to all of K3 anyways.

If I understand correctly, arch/arm/mach-k3/common.h is currently
mach-k3-internal. It is not in the include search path for board
files; it is pulled in by .c files inside mach-k3/ via relative
includes (#include "common.h" or #include "../common.h").

Board files like board/ti/am62x/evm.c include the K3 SoC header via
<asm/arch/hardware.h>, which maps to
arch/arm/mach-k3/include/mach/hardware.h. They have no direct path to
arch/arm/mach-k3/common.h today.

For the board_fit_config_name_match() wrappers in this patch to call
get_device_type(), the declaration needs to live somewhere boards can
reach. The two options I considered were:

  1. Move enum k3_device_type and get_device_type() to hardware.h
(what this patch does). Touches two files.

  2. Relocate common.h into arch/arm/mach-k3/include/mach/ to make it
public, then update every relative include inside mach-k3/. Touches
every mach-k3/ source file.

I went with (1) as the smaller change. Happy to revisit if you would
prefer (2), but it felt out of scope for this series.

>
> >
> > diff --git a/board/ti/am62x/evm.c b/board/ti/am62x/evm.c
> > index 49e58ad6d6c..59201f8d2ca 100644
> > --- a/board/ti/am62x/evm.c
> > +++ b/board/ti/am62x/evm.c
> > @@ -135,6 +136,13 @@ int board_late_init(void)
> >  }
> >  #endif
> >
> > +#if defined(CONFIG_SPL_LOAD_FIT)
>
> There's no need for the #if guard here, SPL_LOAD_FIT is enabled for all A=
RCH_K3
> and if disabled LTO will optimize out the function anyways at build time.

Will remove it in V2

>
> --
> Anshul Dalal <anshuld@ti.com>

Best regards,
Aristo
