Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60488CDB47E
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 01:42:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C60F864AA;
	Mon, 16 Oct 2023 03:42:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eP/jiwQI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0BA08656E; Mon, 16 Oct 2023 03:42:33 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCA0E86380
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 03:42:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-99bdcade7fbso601605466b.1
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 18:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697420540; x=1698025340; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PDIoV2s44MCzjQ2lzRCimtojFMLoL8Wtz1W//3/IP4A=;
 b=eP/jiwQI0eUGmOYMjSnkkOokNUnWB4SpCispb/Osxf2PmNGZRYqan9JHfiR+IWPNMl
 gfV7+5HZ2PKE7srj8SwPXqG8bIwlckDG/3uFqTFnoVVlOnQspOHP+Ig53DmhnzoTHj9V
 3t61y1gIOSHp0twlUb58m8SHrnzIITYS9PIn3kO7TA2XjlHtKmiJG/9WY+7i47MTN/zb
 sUDAfAUc8Hx5mChJKUaPOS0DN4YZQ6HuBiDagc1nyiV6tGNZypQy/aZQSPKcKSb6h5gd
 EccMI+CjzrIRcKzuFes1vtg+0JsOWsZRh1v+HcWedwdUT0aShBWo7BC62PPW2fnl8JSb
 00Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697420540; x=1698025340;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PDIoV2s44MCzjQ2lzRCimtojFMLoL8Wtz1W//3/IP4A=;
 b=ExKrj559rNjW4wB4mVQfsv5Ze9yRKU0EdGiHJJj86BW+Jj1G7FOrj7zESg38bLz6DK
 XROAkLRd2vPaBIhT00uSmbbYwLdpukGMRnGoqpiWtr7T1Tz/52UHk9gXu6OSGEDU6K67
 p5HP9bWg9rkMURK99Pw1JNhNgtdKuBhJRAhwUGxpdPAv7vgqVoHNprfE+1araYBWOL9n
 HTcrv0FWxi7BPlOiF4eHupingRKCNYK506om5VVj/IK0G1zgRgxA3yON0kZ0ElMuIS1/
 cm8HMnDJn3QXhHsXDSy/Fhb0kOxJkupRVN6IDdMlsb0dU8WiYcOVgx5VVhy7+wi9Obs5
 OQlg==
X-Gm-Message-State: AOJu0YzhDyAM+7d64xTnJGYU8ZP0pakaO3S6sddYjTB+iiyPWsDu1ged
 eajUDffA+O6b5PgHPS09j1nj8W3u+0PdSWm/sg8=
X-Google-Smtp-Source: AGHT+IHYI3nlYkdCMdxJYMtIh7gAive7Aww4Ed3AwDmO1UjiF02nWVDouHbtLq5KDF7FSc+onchsBmA+VdA9NNJ09to=
X-Received: by 2002:a17:907:a088:b0:9c3:f1e3:3b4b with SMTP id
 hu8-20020a170907a08800b009c3f1e33b4bmr1659127ejc.49.1697420540017; Sun, 15
 Oct 2023 18:42:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230317162253.1049446-1-paul.liu@linaro.org>
 <20230317162253.1049446-2-paul.liu@linaro.org>
 <CAFOYHZC_Dveax85n0fLr5BFyZcLqsvUssn=J0oHyvN75bTaCUw@mail.gmail.com>
 <fac6ef1747ec318787f90a6d0c81163b@kernel.org>
 <CAFOYHZAmWj6cgXib+m3Dy+mABcwEmPWAHLUgxeBe=2JVLsgaYQ@mail.gmail.com>
In-Reply-To: <CAFOYHZAmWj6cgXib+m3Dy+mABcwEmPWAHLUgxeBe=2JVLsgaYQ@mail.gmail.com>
From: Chris Packham <judge.packham@gmail.com>
Date: Mon, 16 Oct 2023 14:42:08 +1300
Message-ID: <CAFOYHZCNKJBv+J7dkoOjmPrfjr2TXB_vLqzKB2X4u0iwRpOCgA@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: Use FEAT_HAFDBS to track dirty pages when
 available
To: Marc Zyngier <maz@kernel.org>
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 u-boot <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
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

On Sun, Oct 15, 2023 at 10:29=E2=80=AFAM Chris Packham <judge.packham@gmail=
.com> wrote:
>
>
>
> On Sat, 14 Oct 2023, 11:04 am Marc Zyngier, <maz@kernel.org> wrote:
>>
>> On 2023-10-13 03:40, Chris Packham wrote:
>> > Hi Marc, Paul,
>> >
>> > On Sat, Mar 18, 2023 at 5:23=E2=80=AFAM Ying-Chun Liu (PaulLiu)
>> > <paul.liu@linaro.org> wrote:
>> >>
>> >> From: Marc Zyngier <maz@kernel.org>
>> >>
>> >> Some recent arm64 cores have a facility that allows the page
>> >> table walker to track the dirty state of a page. This makes it
>> >> really efficient to perform CMOs by VA as we only need to look
>> >> at dirty pages.
>> >>
>> >> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> >> [ Paul: pick from the Android tree. Rebase to the upstream ]
>> >> Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
>> >> Cc: Tom Rini <trini@konsulko.com>
>> >> Link:
>> >> https://android.googlesource.com/platform/external/u-boot/+/3c433724e=
6f830a6b2edd5ec3d4a504794887263
>> >
>> > I think this may have caused a regression for the Marvell AC5X
>> > board(s). I found that v2023.07 locked up at boot but v2023.01 was
>> > fine. The lockup seemed to be in the 'Net:' init probably just as the
>> > mvneta driver was being initialised.
>> >
>> > A git bisect led me to this change although for this specific change
>> > instead of the lockup I get a crash so maybe I'm actually hitting a
>> > different issue.
>> >
>> > Any thoughts as to why this may have caused problems?
>>
>> Not really. What CPUs does this platform have? What is the offending
>> driver doing to trigger the issue? Can you provide some level of
>> tracing?
>
>
> The Marvell AC5X is a network switch ASIC with an integrated ARMv8 CPU (8=
.1 specifically I think).
>
> I think there is something that the mvneta driver is doing triggering the=
 issue. I have another AC5X based board without an Ethernet port that boots=
 just fine (this is also why I didn't notice earlier).
>
> I'll try and get some more debug out when I'm back in the office
>

The thing the mvneta driver does that upsets things appears to be

    mmu_set_region_dcache_behaviour((phys_addr_t)bd_space, BD_SPACE,
                                                          DCACHE_OFF);

I can comment that line out and everything works.
