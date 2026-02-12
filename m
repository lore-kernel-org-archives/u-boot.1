Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A57B6EB4917
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 12:45:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CC7183DCB;
	Thu, 12 Feb 2026 13:44:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dfD8GUuX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 234D283CF2; Thu, 12 Feb 2026 11:49:23 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B82C783A47
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 11:49:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-790884840baso75421197b3.0
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 02:49:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770893358; cv=none;
 d=google.com; s=arc-20240605;
 b=PdpAX/H/pdeXJrVwQLH82lC+td+RWbNNUXxjkiEmskUa/p2bBE5XF89D9S3VYUqrha
 0Lc/KFzAoRwNuEkdTrbAaTJMdo1ObdEjTy8WYzaH8fE8z0DNE3qKwgKEe/p7R3Q9TQGB
 IvryaGCsrlz/GZU4AF3/GIrjIeWiok7E9SzHMu5U36XgOXPu9jlZb52B05wtN1rOzoQ6
 S/Slb8SmV1N5Dip7ko/onbQyr+ZWobzk38SzEVO+PtQ2uBokmAnoaXPkOAL8oFZ9R6nL
 p4jR34Im30BolqwQYSJeXC9JfFSWEV6iDXYmShPkGDUnCDhGzJqFKwCDbCGocss8zjYE
 tilA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZXOYiqpxV7gkPUQV6azxm0HZYmrgFp02HbOtL5Ec0MY=;
 fh=Vy9V3TmvmoU33rzbFwwNAtFCRvih9hm+dD7R1fsmQRI=;
 b=RHvqFyzbCJHD9uTXXZgeRi7GXtsy1asjz+rSQFKaJUgYNCvFJp1v47wdEt0kxp+eu9
 yLIlLBgx0L2twr/G6C2RhevSZ+P6SW2/B1PvFcNvHt3zv5bedJByjpV49fyP4c/OFxu6
 NE7NKQ2yvXnVdUgECY3uYYN692dGDu872/X77dk46uzj+KntFw9XwSY+71Ej0M3iWrlJ
 KOMC0N/xDRSKYnRLhdYoHPoA6kWBVc/RDWiRq10bwA5/bqDmDfYBRE4Q63Yw6UR6jUoB
 PmWknMvsC2h/sHmRLqVmSikovXOvvudiNVydJ2bEocHn76BtsDpYCdLt7/sXQrO/oc4W
 Vbsw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770893358; x=1771498158; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZXOYiqpxV7gkPUQV6azxm0HZYmrgFp02HbOtL5Ec0MY=;
 b=dfD8GUuX8AJ1XH8PY/jz/KO4Eilt/qjNZ/pNSi0RVNWjR5naUf/dHleen2ElBQNCHy
 eXf6/SuScvBylMUSh1hZhonjfLsAM656fM1W2YKZMsNYWJq0jVeIqCto1NveHf6GaT1K
 u2sVOCA0AQPoTLCCseunjSQJrwxfSgsgRe/q8CMduVgvka9E4BfqtZmlgR89/yHjme2E
 n883oVxrFVy5NWdxhhi62WKtnTuZ45Tq823QCiWRC9EVLWRnOCbFijxAoCy24nClJjjC
 GEdu4fWgrtaWFVPpw/2RGIbmG7ezcDzdAbJgpRuNH/8aedZ5cP3F9SmpVvBadPgwvjQF
 Gy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770893358; x=1771498158;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZXOYiqpxV7gkPUQV6azxm0HZYmrgFp02HbOtL5Ec0MY=;
 b=e2lDf0yS9EToDMckLe/wGJLkvw0SIrEQrDAOitSqGv1u2QvIJgf5Jmx8HADkS3v0Lv
 h4Zn6QXwwghylLWjgAWOKdX1Z7QGitFqe9YT0DhHTupozmd3nfEFNLUZBT/zxwlfEkUi
 xIXZpiUp4LHVGD+JJ2MyvBZ6CD+sIck17cvzsJJkSxFr2k9XwJjhP9NalnvoHl43PvMf
 epE5nH1hXmlibZ2HGuRSw1vW8wZrsxM8RL7jGxnobe6xMVhdfYSjo7PahAARJzBXwuQf
 IS/5XI854JaXKCsqIauYp9yu1+ByuKlGIa3EoSAfbRH++Nn91QVtPK3jg0LMxZKiZ6eg
 /AVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwg7qnBYz/wOGjgFx6exNq54RFmk0SLviyV1SuPmuwS78jf4lTf3KHpNEgomaQSimE1mmEUwc=@lists.denx.de
X-Gm-Message-State: AOJu0YyE1dH/gBIqTUjK/M6hsjYEv2ejHZe/MQSx0y9CpL1+fJmlSots
 97FBCDnSRi9N1jFc9t12fWtDL46onjoU35VGAKTgDKoMxbtIYZAWowRqvbyMBH9U5Zi0Is36l7k
 dZHjcUvfjjTBz96U0ZTwIBLNAkXtijSZVnZusZ/QM1w==
X-Gm-Gg: AZuq6aI5QbSrJWjBBhA1doRYGULtod180n5ihrKRdJHBWHdB0vnApzgNksnitH1F0b1
 csIAGhxXESl2J2Iv+R9UrZI/vf9uog28jH3ekI2cT40c7IiCC1ol2d+T3Pb2U6Yxdx4CTuXcNVe
 wBsJikHBdaNLiQwsNlH4gZVxLqE/z0h0oaRzSH8ZFxbIStmlvutZ3wbrRarTZdxfJj3/J3qxz+t
 g9oXl9ENIGmSrzfkgh8vo319oivLWdn640KgnZJVj40qtgbtXXN1JXV+3pKQJyS+vkPdrna7X7j
 MvWv1lu3njp4K96zzITQ03ZrFUXQwVXCJ1RHjShxpD2a54wN1afzfZA5VMmenB4GqXtUzo/lBtm
 gSqfVkZoCXy+u4UC6lmad2ppFHmssxJDjSlKM9BvuJZtWjrEunhHRtsv39Mj2I+tsZhfhNijplE
 bMCxcCbZGOug6WazwprwVVWxqxle9bXgIJK+QfznlAyS/+WzpIYGBc7EZ9gOdN9V+CDkws4bWYm
 LHZHR0TgmkiXpc1Qi6VSjFKBISHkeFS2Rmts+9vMw+R6VsRdxrQSaEBtD/COa8rjunnlhlC7zDt
 Z+BhMcSzK4YMcS+gxlgd0CU2W74B0agrNUgZmsjMCdhP
X-Received: by 2002:a05:690c:660e:b0:796:3753:5349 with SMTP id
 00721157ae682-79737612f68mr21774847b3.30.1770893358440; Thu, 12 Feb 2026
 02:49:18 -0800 (PST)
MIME-Version: 1.0
References: <20251216091632.512635-1-ilias.apalodimas@linaro.org>
 <0205a2e4-0ccb-4dd0-b901-cc6afae31189@kontron.de>
 <CAC_iWjJLm98Vm70xxLAY=aAvSzb7eq2hRhrqUdr1sLZNUZj0iA@mail.gmail.com>
 <96d856a5-7d06-48b9-bf27-9db26c7f6c9e@kontron.de>
In-Reply-To: <96d856a5-7d06-48b9-bf27-9db26c7f6c9e@kontron.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 12 Feb 2026 12:48:42 +0200
X-Gm-Features: AZwV_QgP15L7TEMvV7c7ZcmeElM17PZMcW8bsySrQFGsKNIyxYYnOdWdPILvFPw
Message-ID: <CAC_iWjKkAOz4LqaZJ_q2U-XU2=7cNW6NGrCc7hvU4MQBofM79w@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Bump the build system to 6.1
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: trini@konsulko.com, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Eugen Hristev <eugen.hristev@linaro.org>, "Andrew F. Davis" <afd@ti.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Michal Simek <michal.simek@amd.com>, 
 Chris Packham <chris.packham@alliedtelesis.co.nz>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Luka Kovacic <luka.kovacic@sartura.hr>, 
 Minkyu Kang <mk7.kang@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>, Simon Glass <sjg@chromium.org>, 
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>, 
 Varshini Rajendran <varshini.rajendran@microchip.com>, 
 Manikandan Muralidharan <manikandan.m@microchip.com>, 
 Bernhard Messerklinger <bernhard.messerklinger@at.abb.com>, 
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>,
 E Shattow <e@freeshell.de>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Sam Edwards <cfsworks@gmail.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Adriano Cordova <adrianox@gmail.com>, Philip Molloy <philip.molloy@analog.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Greg Malysa <malysagreg@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Yao Zi <me@ziyao.cc>, 
 Raymond Mao <raymondmaoca@gmail.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Shiji Yang <yangshiji66@outlook.com>, 
 Daniel Golle <daniel@makrotopia.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 12 Feb 2026 13:44:52 +0100
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

On Thu, 12 Feb 2026 at 11:08, Frieder Schrempf
<frieder.schrempf@kontron.de> wrote:
>
> Hi Ilias,
>
> On 11.02.26 16:25, Ilias Apalodimas wrote:
> > Hi Frieder
> >
> > On Wed, 11 Feb 2026 at 15:35, Frieder Schrempf
> > <frieder.schrempf@kontron.de> wrote:
> >>
> >> On 16.12.25 10:16, Ilias Apalodimas wrote:
> >>> From: Sughosh Ganu <sughosh.ganu@linaro.org>
> >>>
> >>> Our last sync with the kernel was 5.1.
> >>>
> >>> We are so out of sync now, that tracking the patches and backporting
> >>> them one by one makes little sense and it's going to take ages.
> >>>
> >>> This is an attempt to sync up Makefiles to 6.1.
> >>> Unfortunately due to sheer amount of patches this is not easy to review,
> >>> but that's what we decided during a community call for the bump to 5.1,
> >>> so we are following the same guidelines here.
> >>>
> >>> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> >>> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>a #rebased on -next
> >>
> >> To me, it looks like this is breaking "make cross_tools" in some way. Or
> >> am I missing something?
> >>
> >> With v2026.04-rc2:
> >>
> >>> make tools-only_defconfig
> >>> make cross_tools
> >>   UPD     include/generated/timestamp_autogenerated.h
> >>   PYMOD   rebuild
> >> tools/Makefile:359: *** insufficient number of arguments (1) to function
> >> 'filter'.  Stop.
> >> make: *** [Makefile:2191: tools] Error 2
> >
> > Does the below fix it ?
>
> Yes it does!

Ok, I'll have a closer look and make sure nothing else is affected and
send a patch

Cheers
/Ilias
>
> Thanks
> Frieder
>

[...]
