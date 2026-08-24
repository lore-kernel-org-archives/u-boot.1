Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72175C5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 10:21:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1574E6061A;
	Mon, 24 Aug 2026 10:21:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DxT-RSNItc2P; Mon, 24 Aug 2026 10:21:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787566884;
	bh=Ton+sVQ8A+7lPZepgK7FQ8e6zyyyfLLeY2ys9ZickvA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qrUZhZsbA3Izv5ksthC2FxqYW/glRsHYyTEcxwk4LRG0/wEXe5fDBCIOnKpiABvud
	 uHXetU+ePxTta+PLL8WvBP3qNS9XToYdoxRpWIlUu8Zc3S8NeAK/qMqGgO1n6uYM/N
	 OYAiPObWwuSwOEwZ3eQDoj77Q/vcWKRpeuwOEGADqzCqVumyrLgwtP+kImGMPbLlai
	 GHhcljom+eK6e4WL9xwcEQX8xf4bSOBbdSlGJ9zc+wrxJAGOnkEvHzuqWGu3pA+FMd
	 iwDo26xUO0tgoOv5M6XHpDj7J9QVHGeLhCbiKIDBoWXdbc+gZPznPbSTG3TOE9tutg
	 v/0uFc2Fwl94Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BBBAA60622;
	Mon, 24 Aug 2026 10:21:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 46AA6279
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 10:21:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2CAED40604
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 10:21:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tzd_4y80jZyv for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 10:21:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=NC7vqtdq
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E7DF84056E
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 10:21:21 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c1c52d920b8so465480766b.2
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 03:21:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787566880; cv=none;
 d=google.com; s=arc-20260327;
 b=CsmRVyvMM/x6vqSPTArLbgedCvAH/MPACs52o6WFYrKQ+o0cMx7ZVHxM/KMHjVlCp1
 nSzgAhwJSmdt1yMcHb5JK7HoLBtctoixp6zvHrycuwpiIWZWJa8zRmW8nL7pSU3mygoO
 3O52Tu1p2+X8qGzfL89YTmyjfthZPx3eaxlLoYIhVclHfM3yynGqmFOQ/k141Kc+N3xT
 a0KZo/ifjTM2HdStmdXMXOvA7y7Hmt50J+CKkWs+m/IXyoytRqQ5H1RuGKc/R1il2SmD
 2p4Pc3jwxTm+PxjM7xVnx+4r4bWPywjgbU5PEo4zaIDR/j82s03lHRZ3iN4ZAE/sgn9L
 JLxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ton+sVQ8A+7lPZepgK7FQ8e6zyyyfLLeY2ys9ZickvA=;
 fh=ejFsIcZJsooTsZJOIgzjOgwn08KaKxYw9+Wf+kU3bXQ=;
 b=gph6KcFev8Xrfzs4MylEonTZ0/s9YQbk27G9+FRny06taPops3EPJeJL4PXlmB8HA0
 Yzvhjl8MmNP0bEjV88fbM+J+YihWqI7pIhPN52yMFLFp2GzWRYObE2TxV20CxpE4Bkd+
 zOANd4jh8wOeMpJ0VVvTKA2Nq0vOjOL+l3YTNEps4uaQmodV1/jP9LbrJEynL1pnQWxd
 O3u3IOtZLf7UVTG0QOmXBWPiOTtKDt8NEly+Mqp/S04Tw+ZL29065HKMSez4/8XgWfa/
 OGZU90j7zZVd4OUnemg7HwPJ8ePIsYzIAYXRoPO78nTDBKfsoYFTqqvyNYY3Cof3ur1y
 VujA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787566880; x=1788171680;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ton+sVQ8A+7lPZepgK7FQ8e6zyyyfLLeY2ys9ZickvA=;
 b=NC7vqtdq8ByCvS5xJX5oaSL+wVRoL+SkPLlUO7U5BC7OOAngbl8NL8vVuPS+MJ+Iq5
 KPdpG/BJWQQ5M97RKgRX3YFYmA79AH2ihN4ZJ2vzvU8DzcQhxxFpTHUiR5X71uXN6FFl
 +QAPZl7nBXtyDcbZNEOJrqB48osO/3QONKQbHeWCOk/ytcuxRExJbb+FZYHz88LoGsQH
 fWAWkeuTDDHLUn+R3VpE3Uucx9hGV8hoNToWnNgNwWI4a/+4TsU9I19+1NBPhnlyBfyS
 YdbaYXhe2H3Sc4GG/vAd2rla+ELyPJ6f5gvdF28AnmvWQPXRantWXPPP8095QEHCXgbB
 a7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787566880; x=1788171680;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ton+sVQ8A+7lPZepgK7FQ8e6zyyyfLLeY2ys9ZickvA=;
 b=oyyxpTRDU74usPhBOIJl/A+tFNp4PF8eT8omqPI+C1dhmwUQryDrGvZIuws5yIsype
 7An7oUtWt7If6DoiQHs1YcOuLD/qcQruR2aBM4mkGt0fBu9XbtspLs6I3GJq/IATQlLD
 Zn9VR720cY9ARRQ4QDzdFpAooc3x3KJOTQXO8i6bNm0Si3IATnak5FLjL8hpEvx1Ai1U
 f+gZ82YKHA2qNMQV13fzjUGqjxhqueJw3q2vSKLC7UrxBMtd4bVG8FELWqzWej5PF+vG
 8ypuyLD8FduMNa6khNuqDaxtF5k7h4tQiIk13DLa7iHNU6G8vUUF5GXITxiNhiQUs5/h
 H9KA==
X-Gm-Message-State: AFuF++kYZmToaMiHWim8lgVIyjOFej6P+k0mPHLVzTJkVnQxwT/QIgSw
 RnoI4yBT4b91eE1Sq4TzGk5dzMQweFomR9xjylEBx9dhS6uBu0nVMt0ZXzApFkfBZxfBupQSvp9
 FXepABRgtb0rQSKAKHo7SkVF7w4J+sPUS5eSfdDdQhKVlgUc8fnpuyX4=
X-Gm-Gg: AR+sD13PhLXiXy+Gs1PrMAWLjOBuNVbsTApwtn9Oi+cZJW85e8FOJM5lYeWkG/+H0XR
 GbutLFgMTDz5PgCQDoZYsn2yYAXrulq1GQqK9Hs379W/+d9HMjeqIpy2OTfh5J9aXdRa/YcPMTV
 aMn1FAcAeI+UdT8bzXn7i2+THIHgxy67B1/X4OwwygYJx5IKGsxkmgq5qeqkd2KR5n/OjEZrFun
 /Ch7KH0HS37BzzIC3u7gX0Dic35vsz78RlGADqnZ1QYGOskokNQs2cqytu4E5M4y858/XFwDG4/
 UHqBwq/e7ORMGPAn4eBEImk/v9Zt0tmNGsBIb+YlWFIfYJWsU9sk6ZeuGm2j8Yh3bR+UB8XMqaM
 o
X-Received: by 2002:a17:907:c243:b0:c24:47b8:ae5b with SMTP id
 a640c23a62f3a-c246a68418emr3102689266b.22.1787566879538; Mon, 24 Aug 2026
 03:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
 <CAKTNdwGG1w9qe82UBWjBx3kWK15b2v4vcdKK8NG7vcEuHJocLg@mail.gmail.com>
In-Reply-To: <CAKTNdwGG1w9qe82UBWjBx3kWK15b2v4vcdKK8NG7vcEuHJocLg@mail.gmail.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 24 Aug 2026 14:21:11 +0400
X-Gm-Features: AcwNN1VcGX9r-DgTCcYkN_oIxTkeqOAqxCEaJiWaneXqPnTxoR6U7Rnkze2iXCU
Message-ID: <CAKTNdwFM+HegQjasf4jP8iie1_8NA51ypg3WLxBdbVsmYeVdWw@mail.gmail.com>
Subject: Re: [PATCH 0/6] disk: Fix the GPT layout on media with large logical
 blocks
To: u-boot@lists.u-boot-project.org, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>, Anton Burticica <mouse@ya.ru>, 
 Javier Martinez Canillas <javierm@redhat.com>, Simon Glass <sjg@chromium.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Jagan Teki <jagan@edgeble.ai>, Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Jonas Karlman <jonas@kwiboo.se>, Klaus Goger <klaus.goger@cherry.de>,
 Tim Lunn <tim@feathertop.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Fri, Jul 31, 2026 at 7:30=E2=80=AFPM Alexey Charkov <alchark@flipper.net=
> wrote:
>
> On Fri, Jul 31, 2026 at 4:40=E2=80=AFPM Alexey Charkov <alchark@flipper.n=
et> wrote:
> >
> > The GPT partition entry array is sized in bytes by the spec, so the
> > number of blocks it takes up depends on the block size of the device.
> > U-Boot got that wrong in gpt_fill_header(), which reserved a fixed 34
> > blocks at each end of the disk. On a device with 4096-byte native
> > sectors, such as UFS flash, the backup entry array ended up 28 blocks
> > short of the backup GPT header instead of immediately before it, and
> > roughly 114 KiB was wasted at each end of the disk.
> >
> > Patch 1 calculates the count from the block size and makes the four
> > places that need it share one helper, since they disagreed with each
> > other in different ways. Note that it also changes the 512-byte layout
> > for boards that do not use the default entry count:
> > CONFIG_EFI_PARTITION_ENTRIES_NUMBERS is "default 56 if ARCH_SUNXI" and
> > is set to 64 by a number of Rockchip defconfigs, and on those
> > first_usable_lba moves from 34 to 16 and 18 respectively. Existing
> > tables stay readable, since the entry array is always located from the
> > on-disk partition_entry_lba, and only newly written tables are
> > affected. Partitions given without an explicit start=3D will be placed
> > lower, though, and on sunxi first_usable_lba lands exactly on the 8 KiB
> > SPL offset, so sunxi and Rockchip folks may want to look at patch 1
> > specifically (none of the devices I have override the default).
> >
> > Patch 2 is an unrelated big-endian correctness fix in the same file,
> > noticed while auditing it: a few header fields are read without
> > converting from little-endian, and one already-converted value is
> > swapped a second time.
> >
> > Patch 3 is another unrelated bug that has to be fixed before any of thi=
s
> > can be tested: part_test_mac() reads one block into a 512-byte on-stack
> > buffer, so it corrupts the stack on any device with larger blocks. Sinc=
e
> > it runs during partition probing on every device, sandbox crashes on an=
y
> > access at all to a device bound with a 4096-byte block size.
> >
> > Patches 4 and 6 add the tests. The C test sweeps block sizes from 512 t=
o
> > 32768 against gpt_fill_header()/gpt_fill_pte() with a synthetic
> > descriptor, and the Python test writes a real GPT to a host device with
> > 4096-byte blocks and checks the resulting on-disk headers. Both fail
> > without patch 1.
> >
> > Patch 5 is a prerequisite for patch 6: test_gpt_write_part_type() never
> > binds its own disk image and has only worked because an earlier test
> > left host 0 bound, so it breaks as soon as a test binding a different
> > image is added above it.
> >
> > One known gap: test_gpt_write and test_gpt_write_part_type hardcode the
> > 128-entry 512-byte layout, so they fail if sandbox is configured with a
> > different CONFIG_EFI_PARTITION_ENTRIES_NUMBERS. The new tests derive
> > their expectations instead, and pass at 56 and 64 entries. No sandbox
> > defconfig upstream uses anything but 128, so I have left the old tests
> > alone.
> >
> > Tested by building sandbox (default, flattree, sandbox64, gcc and
> > clang), generic-rk3576 (gcc and clang), sonoff-ihost-rv1126 and
> > A20-OLinuXino_MICRO-eMMC on armv7, and boston32r2 and boston64r2 for
> > MIPS32/MIPS64 big-endian, which is what patch 2 is there for.
> >
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > ---
> > Alexey Charkov (6):
> >       disk: part_efi: Size the partition entry array from the block siz=
e
> >       disk: part_efi: Add missing endianness conversions
> >       disk: part_mac: Fix stack corruption on devices with large blocks
> >       test: dm: part: Check the GPT layout for large sector sizes
> >       test: py: gpt: Bind the disk image in test_gpt_write_part_type()
> >       test: py: gpt: Test the GPT layout on a device with 4096-byte blo=
cks
> >
> >  disk/part_efi.c           |  55 +++++++++++++++-------
> >  disk/part_mac.c           |  12 ++---
> >  test/dm/part.c            | 100 ++++++++++++++++++++++++++++++++++++++=
+
> >  test/py/tests/test_gpt.py | 116 ++++++++++++++++++++++++++++++++++++++=
++++++++
> >  4 files changed, 261 insertions(+), 22 deletions(-)
>
> NB: the CI passes all green:
> https://git.u-boot-project.org/u-boot/contributors/alchark/u-boot/-/pipel=
ines/841

Gentle ping regarding this series. All patches got R-b, can this
please be applied?

get_maintainer.pl says these fall under "THE REST" - Tom, can you
please pick it up?

Thanks a lot!

Best regards,
Alexey
