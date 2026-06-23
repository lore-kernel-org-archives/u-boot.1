Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8CBCD4F26
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 08:39:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FBEE849BB;
	Tue, 23 Jun 2026 10:39:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hjz5Teu+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB590849BF; Tue, 23 Jun 2026 10:39:25 +0200 (CEST)
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com
 [IPv6:2607:f8b0:4864:20::b132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76D8B847C8
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 10:39:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-662ebb1329aso2537135d50.2
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 01:39:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782203962; cv=none;
 d=google.com; s=arc-20240605;
 b=IZr4e6zsxy6Sh/txrKuTi7jHUSjrx953XctYVh4e8C+QVxNWL33M0gWiibviQN27LU
 Lhjiyw+lMdKvQuLgwfyQmEHNw0pnP6t9FrnV28JwePaMvsLvFVtUrepDfwFN3tgFplAK
 92zo6jjZtIhtcisfW7Za3dxfMqeUt8fD4KzdEHO94ChUjpCQInm7QTkQrXOcdeFfJEQA
 gId6GdtULxErPBR6dmTyXvE5kiKWT4ePQdy8lxaC7uyoWI1jUL+1ea6HgiWk1Rem815+
 0lPI4uOqtzZwjPQSFVh7afRHwF8ROxgmL7+zQaxsFJT3pS6yi/qybOhkH4Fl5ddizwRj
 LoIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=djM8O+LOLdz/bvXhnFP484e0wHqhyhqmib0WAzeSvD0=;
 fh=F1g9JCAMPZIsmmAfp/vapo88p6hpnQuU8mOv+m+nz5E=;
 b=E1h2OztjtStX0EfzJRoEFZoR4IWjBwx2ytI9ZqhjG1GTQtlSvFakuCMw2g96hMOdQt
 1lQ1On+spyoBpiw6zjEUnLUJPoy5cP/0zVY6W+3nmJOpLYPUlIv+Nu0OxCBnrToVYU0+
 ApRBLJhcTtrSplOvDr8mJ7CGtbQ+xtmEl/0KKqf8+/zHEbS6DIdh+OefnsjWVnH6GuSy
 N7ztXkp+EAq58rt2O5aPKvYGGLXcwQ4d/kkvmEeV4y/8hpDe5eXIQ1+uzE8/uJpYVtek
 mbHsxjgBy+QQLz6d+apymETWLMUi12H1Y5Ehcm4/MozCM98pQP266a5tNwNlzNdB/YhG
 ycyA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782203962; x=1782808762; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=djM8O+LOLdz/bvXhnFP484e0wHqhyhqmib0WAzeSvD0=;
 b=hjz5Teu+qYccK40XYXHhPcyYwg5qysNPPv58R3OjLd+4T257LyDbDTYtBcd963w3UV
 17OOCl2vgvA/ZHBn/YGKLbDyxZrbDKe5/gijoNmJm0U/rY2/xnixhKUZN1/LXEZdfnhh
 H+/ZQTRswoV6HmG1AwJPfu0SalylU3G5WQdq9GgwNjMS9gLer0SoNZlBXN3te3PigA2v
 Afar0A/O71SMWPG6y2QwaFGzvo9iXxdE2RfTbg8M0nTtFM3AgKIChOKKdA/U7aTtl9wq
 g0zz9GfiCXzQUgaYSlsrIhkeq1ej6de85qimzfr/FiBqFn3BZZvizzLsIiR+7gz4wlPD
 PCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782203962; x=1782808762;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=djM8O+LOLdz/bvXhnFP484e0wHqhyhqmib0WAzeSvD0=;
 b=EyuRM2TH3uh9ttVzk6c70I2HNOj3F7AN4ahG0BLZFWESUrenMPqIufUWUsvGaTzNDg
 CLgzeoQsJ+ZxqpPjUvPQrhSSWPMlOeGOQTWuT5WcxtsT8H3I76SHTjM1DeuABvsijA4p
 ynR40fq1uX6TLnww2TO4BhnDZblDOkJWOGaEHdJi2CmBbzxBHx/in3SEfEAfwoDNTRoa
 GvCrX2niM2A7MhYxmCy4IFmsDQq8vPl9C0eERjl+6ovi9H1IGvKN7ZsxA9eyluL0fU5q
 ntk8Xmvxzx5PJ6K+AXp4STZ/CtgAhJ9+WkW+goqepku5K5iDauIAAImTnxLNK15f+kqt
 ixhQ==
X-Gm-Message-State: AOJu0Yx8Tv26gE1WbhTLmiWVq4R00W9EhYcUNiM5Vk9Z3tLHWKl+pWxv
 pr3N5MxX+UOfSqYSU1E5GcCznYSHLFSgsMDCOAgdPickiZkYSjiUqWxp5ikk/5IzwMjIDRTobQm
 aJeixwYnSxh+0bHfji4W0/rtQDiswgZPWBer/JdnctA==
X-Gm-Gg: AfdE7cljifmSa2n1nj3mutMKpIMC8gsrwt1FqEHv70LGLsCGzKJM19Ylvt1k7It0QpT
 eLlVDHwiyrKzyjQA8+8i7iIcwYNcw8RKPRn2Y7kpVBtN990s1ihG/BH5tS4hKnM77TXZGseMG2E
 oUVSdM/VjdLqAgTHoR+UONzZn13/Pkks34d28aosIEHmO6v6X+2Ki+wTAb+iFpnGAuM4zFo7hmT
 ybvMlqAReeVhlhBdA8ZHN9HvlUjEBogiuYCzO4Dcf/4CiQSaLhwa/kyiScBmdchgr9Blsjo7Dc0
 SFTA24TyP0w0zek8xysgMYA5B+S1eB0KbZB7g5pCpgC53NFQW7HJebTSGH/G8LjkyAqlSfI2s4E
 /AEOdElN8P9gN7Kc4ulTEQfeKQk4pVqcF37vTEwbUvMmaSOJfkbzBnhxVcWe4B+yrQqVUoxcVwV
 A7mQ8Da6mfsvC4Q3cb8d4vMKg+sZw6u0Czz19FIkfCbta7lxhuR9LgqESJC7rD46aD4C5hN5URt
 sgShcYNkMkGjV6f4lL/XOXvlYtUzgpH/j5YT2GPUuxECd8QIEPbo3iZh0BEI4l+FDgGhZMeQfjL
 96y6MAQg+OlJAY73YjLoZ1KNdGbUgVXgf76ceOXP9XULcz6XbyE53mBChIHlszInIKnFPM0=
X-Received: by 2002:a05:690e:134d:b0:663:1161:cf5c with SMTP id
 956f58d0204a3-663116207e4mr13378343d50.20.1782203961956; Tue, 23 Jun 2026
 01:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260610105243.193355-1-ludwig.nussel@siemens.com>
 <20260610125204.v2.3.db7fbeb8b6e8499f4d031c04cb5cd8175873b643@changeid>
 <CAC_iWjKN4URBGikcEeTHp7dQPf7QasESmPOmys9piEnsVt-fWw@mail.gmail.com>
 <c3cbd9b8-56b1-4884-bb8a-8a98498a6c09@siemens.com>
 <CAC_iWjJPY9VK89fB5+isWb0v5+uBZnr05kQoGGOYu_X=7G8Wtw@mail.gmail.com>
 <7a8ab625-448f-4a63-ac2b-7b071a9a9f1e@siemens.com>
 <CAC_iWjL0z2+=94CfjZx1BV6bCSSN2PyVwPSgCJNhs6r3Z4F3BA@mail.gmail.com>
 <CAC_iWjJP3aK5a+QNVuZrLo_jc_zC1mkHJr4JsgRSaD7=wQ5cmA@mail.gmail.com>
 <7aaef892-d1bf-4117-bb9a-ac8163b517da@siemens.com>
 <CAC_iWjL2f6oHSfGYtiDy2rPUzpDKRdwR7RvEJUQaNqxO0rc70Q@mail.gmail.com>
 <35833068-3d06-4661-b98a-1633a6afbbb7@siemens.com>
 <CAC_iWjJ-dMsT3W5fSZ8KUFZeUz8djPw4gs2WHZsfhOjZ6jktGw@mail.gmail.com>
 <6e83756f-5ed4-4f89-85b2-1a65419e9ac4@siemens.com>
In-Reply-To: <6e83756f-5ed4-4f89-85b2-1a65419e9ac4@siemens.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 23 Jun 2026 11:38:46 +0300
X-Gm-Features: AVVi8CfsB-03_LJFANbZ-mziCveyu-LFIIUL4PINgGi5nAMYYEizep0FHdQQZFI
Message-ID: <CAC_iWjL9yrSycty6=+JGqpE1ed7oNb34txDmKsE9sMp4zZCOeg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] tpm: allocate tpm event log if missing
To: Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>, 
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
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

Hi Ludwig,

On Thu, 18 Jun 2026 at 12:16, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
>
> On 6/16/26 13:46, Ilias Apalodimas wrote:
> >> [...]
> >> Anyway, do you want me to submit your two patches as part of the series
> >> or you want to follow up yourself?
> >
> > Carry them over imho, they were rotting in my branches for 1+ years,
> > but I never had the chance to send them. Your patches were a good
> > reason to rebase and revive them and they fit right in as can only
> > rely on tcg2_measurement_init now.  I'll test/check the v4. I haven't
> > gone through your changes in depth but they seemed reasonable, so I
> > think this is fairly close on getting in
>
> With the patches on top the testsuite weirdly fails in platforms
> xilinx_versal_virt:
> https://github.com/u-boot/u-boot/pull/987
>
> Works without:
> https://github.com/u-boot/u-boot/pull/989
>
> I can't figure out why though. While investigating I noticed that I need
> to re-introduce the elog parameter to the measurement functions so the
> integration actually has a chance for now, short of using dev->priv->log
> always.

Ok i'll have a look and see if I can figure out why

Thanks
/Ilias
>
> cu
> Ludwig
>
> --
> Ludwig Nussel
> Siemens AG
> www.siemens.com
