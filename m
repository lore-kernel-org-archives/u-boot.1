Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1081CD5BA4
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 17:43:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19777846BD;
	Wed, 20 May 2026 19:43:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S4p0cpmd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39C7D846DD; Wed, 20 May 2026 19:43:16 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14FD68464D
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 19:43:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-67f7caa33easo11097280a12.1
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 10:43:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779298993; cv=none;
 d=google.com; s=arc-20240605;
 b=XEvKs4YyWWTe8jxomrHod5qiF7FRdkJkvAzelBjprBmsmsvb2ottpPP5zI/f1vTwG6
 r94zOQJkTrykKnS69hEWmiWlI3b2pblEkQy0HJYLqo4vnnX2/G7higgw+tW3tu3diXvW
 xECZ75OfhDOiTagEkHHRPDl4nTceLvUccyZTuxu3aelqUVPUVFybsRFh0QhTtPyxlEfY
 ZTNQLsz2Xew+bGuLYTbXm/BRTqo0MjF3qGjaxJC4ILvvX2jrLgVOdJ/Lm+1x6nAIJZvM
 GUspVGNMGBI2hDjskf57pJdD6RcBC66n+GbMvvomAwbwEUY5ZX35qZZwNjA/73saEyUR
 vahA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sNhSWG44CKP+EBy90pd189ym2C16a0TUsxArvdgjcOY=;
 fh=fUJJcS2lckh5hMkBKM3eRkZjDVxeGY1zf6gQL7o8Bjo=;
 b=fd61qciqeXJB1+Q33bEXxY23VXTJa+wywPKEa6SgEU5Jf/CTF15jDmSbyiVdl0OPCe
 HHP58FlN5mNG9nbc9mdYEdzMtbMdEl0sIxs17RwREeM+myLZi5db+gD3DrHHCAUrlxGO
 tLIdyCBDtkH9yOsbaEkY6tDkd7RmUZ0N9X/dl+iUn5e7PmQKVhIoxDytwTNT57peKiUo
 NttSOk1OIIx8sy87ZeNcxnqkHwLoM8Zgjjl800ppwVUj8OWo93Nee2wGS5ygMJQyb5Wt
 kjemPo0Uy0X/VhRkgxAidpb68aJ51DLnWj4a7MwsckCQv9kzQ2WJ8SG3l3Mgy9QTzaSs
 7kKw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779298993; x=1779903793; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sNhSWG44CKP+EBy90pd189ym2C16a0TUsxArvdgjcOY=;
 b=S4p0cpmdE5/VHxVNJAh1TXV7YSe8FqOgtNPKDLED4+giKdf2P+oXNKzfLxNDor5yE0
 Us0fWWdSj9Lp8KfjrcA8+W/S35PW9DojrdqfMZLrJla8O0G0+yrJ0OmUhTfysftYjdjN
 uKr8OscftjxUymh6qteXA2TPrT0sRegu89gVH8fKe2WKTlA72cZ6jDMkZr/c+ThAIz19
 fgeCetnBgouK1sqTD+oBAJQHDkJ/kFVjsPS30ej+muLy5usLenbKGugMsqgFKagweNqS
 SB6rSyVwiS1hFt4tM+mA7v95TecBKwlzO16rpClgusCoTQWUC/ED9tsEvLpMrHXxU/t+
 EiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779298993; x=1779903793;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sNhSWG44CKP+EBy90pd189ym2C16a0TUsxArvdgjcOY=;
 b=AbJBdh7nAbBvEIyuEsrvb/GdWEfpomQ0fpPY3AYDt9TmOHvYTP17rkTZt+/jlOOcjK
 ZvdcYYaqYfWS7srmfVV1JC8hwQOcpVWclP9alOI6DVYpVmecoSqdF8xeh+9cY3CrXLXW
 xvfm5+Puv6w5o12U0yafP2QQkQodNpG/zNTPoXXqHKd3kFXspfBqxp0wuD78A1f9qmoO
 JoG4QPnV4X69YEt78w54D8vDbZd4gAS5O1MoldABM1fiesgxAiBWHqtURsHoKe+RIa9j
 C54ZCDj6wcC+z6p0vLsYX5qHtxoQojhxJZ2nEYzp9K0sFXx9URdCbKAqb+/LQ7RZh7Ul
 HApA==
X-Gm-Message-State: AOJu0YzfVuW6XMO+3gp+F/mu2R+YiqtamTaKak97Lk/OLUe9KyzxWWl1
 flXE456biTsjei9jvjjm6y0coJxgvlYX2zwgVxE/hIwiC8sSywUdH+VXCkc2lywCKloaxD0ofju
 eyUc6pOQ2F4l3cwilzmhTfakuxTd7ZsM=
X-Gm-Gg: Acq92OEGfl7za4FPCSL2a87hizTGWoa1dixILMdJsxOC6uAwuMiBdWoXIXISPuu/xTn
 pS+JYQBfszoB1z4mqJwmPA3uGuwkQ4vyrlhXXwUr6V8NgiOhKn3qhtM0qO08IPRqvCCI3EujiUi
 P/9gHDPTop3ywEvGeKm50RQ2wKCdFoxv5lqTCdJxOdpGQOrXLqioq9eQmcCHIYqzxAQqdawyfNN
 6p4ctJqCBWVPdNLJbapgFr1m3HeZ7FAev0296S/NSKASMQcssBmbr0s5fq3gYqNfH27NDqOGkHg
 2m5jnNSRxsM15BCAUs91HomoSRglNiTtfqBJBR9sjqV7nxUVk70gfYeqSRxBwniqfC61T0lCHn3
 By65JXoN5SFE4GcGJvhCBFLtsKhaWiyhZjWAoR4tBKTEH7xQqHT7tOVRQ9904rTUckA7oBV7sHY
 Qr
X-Received: by 2002:a05:6402:3887:b0:683:dd5c:191d with SMTP id
 4fb4d7f45d1cf-683dd5c1c6bmr13443702a12.24.1779298993407; Wed, 20 May 2026
 10:43:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260516113940.647CE68BEB@verein.lst.de>
 <431cb228-c0f2-49e9-a3cf-9869fc954d1c@linaro.org>
In-Reply-To: <431cb228-c0f2-49e9-a3cf-9869fc954d1c@linaro.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 20 May 2026 18:43:01 +0100
X-Gm-Features: AVHnY4LyE7jiAaXH1_PbODG8ZHwiEBOCoszFleKWYXw7qsW22dD-QPSa1TMcSQQ
Message-ID: <CALeDE9P-LdHqbL=6bYWiB4LNAB8H2Z3WnNPKuNVsbCkLhj_VKQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] ARM: RPi5: Enable PCIe
To: Neil Armstrong <neil.armstrong@linaro.org>, Torsten Duwe <duwe@lst.de>
Cc: u-boot@lists.denx.de
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

Hi Torsten,

I've set this version to Changes Requested to take into account Neil's
review from v2.

Cheers,
Peter

On Mon, 18 May 2026 at 09:08, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> On 5/16/26 13:39, Torsten Duwe wrote:
> > Basic PCIe support for the RPi5. This is the prerequisite for PCIe
> > slot adapters / HATs and NVMe storage. Those might require their own
> > supporting drivers or changes.
> >
> > Changes from v2:
> >    - fix wrong subject prefixes
> >    - make reset drivers only found on the RPi5 depend on ARCH_BCM283X
> >    - some patches Reviewed-by Peter Robinson
>
> It seems you completely ignored by comments and review on v2:
> https://lore.kernel.org/all/bcad697e-56f8-4256-8d24-41c5ef644ff8@linaro.org/
> https://lore.kernel.org/all/f46be233-e35e-4a42-8663-342e9913e784@linaro.org/#t
> https://lore.kernel.org/all/5ba58555-78cd-454f-9fcc-5aaec5fd4205@linaro.org/
> https://lore.kernel.org/all/0d1c9e66-62c5-491f-9fba-97f262a1153d@linaro.org/
> https://lore.kernel.org/all/fc11057b-edd2-428b-a67d-1cc22bd79492@linaro.org/
>
> Thanks,
> Neil
> >
> > Changes from v1:
> >    - fixed inbound window rewrite, which broke RPi4
> >    - series Tested-by Pedro Falcato
> >
> > Andrea della Porta (1):
> >    pci: brcmstb: Fix PCIe bus numbers
> >
> > Torsten Duwe (8):
> >    ARM: bcm283x: Add bcm2712 PCIe memory window
> >    pci: brcmstb: Support different variants using a cfg struct
> >    reset: Add RPi5 brcmstb reset facilities
> >    reset: Add RPi5 rescal reset facilities
> >    pci: brcmstb: Get and use bridge and rescal reset properties
> >    pci: brcmstb: Fix iBAR size calculation
> >    pci: brcmstb: rework iBAR handling
> >    pci: brcmstb: Adapt to AXI bridge
> >
> >   .../mach-bcm283x/include/mach/acpi/bcm2711.h  |   7 +-
> >   arch/arm/mach-bcm283x/init.c                  |  10 +-
> >   configs/rpi_arm64_defconfig                   |   2 +
> >   drivers/pci/pcie_brcmstb.c                    | 391 ++++++++++++++++--
> >   drivers/reset/Kconfig                         |  16 +
> >   drivers/reset/Makefile                        |   2 +
> >   drivers/reset/reset-brcmstb-rescal.c          | 103 +++++
> >   drivers/reset/reset-brcmstb.c                 |  97 +++++
> >   8 files changed, 590 insertions(+), 38 deletions(-)
> >   create mode 100644 drivers/reset/reset-brcmstb-rescal.c
> >   create mode 100644 drivers/reset/reset-brcmstb.c
> >
>
