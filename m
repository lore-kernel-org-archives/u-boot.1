Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E58C54F54
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 15:30:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6A0064113F;
	Fri, 31 Jul 2026 15:30:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FhYV-yB-agkU; Fri, 31 Jul 2026 15:30:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6288941124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785511838;
	bh=zyMaR01CZnD+fyeBYNldP/G5Ichz/KM6YH4bZrs1FX8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MQnRwaXI3zyY/DUVPRAFifefHVZCLwDI6pOPsIzJGmEC1OjAERChcA+Y5IOiqHbRy
	 6tozKWWhu6Jw4HOypX9FfmV7hrTdYwIKz6sbNkpA2xzMMUoibcJNaibhvB5b1lqmNe
	 4tmKiY2qNiuKb9l1noq4kRO1cecIViIsNYUNi5oIGFh97zl2jrymv8xKnUdCWXbd1N
	 4np5N1/Xlks56apVDMkyF/WD7eEqsic5OxFft1AVwfFcQ62nO86TquPxiiel7S9uLW
	 TB0+OrAw2dDaNnCPQnWa+D0PJYzG67TmHp7Cj2bg0XvbYs/kh++I314EF3/67piyfc
	 D62E/fewjc63w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6288941124;
	Fri, 31 Jul 2026 15:30:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CA5DA197
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 15:30:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B0BCF60895
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 15:30:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MqaI6KaWijkz for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 15:30:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 779D460816
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 779D460816
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 779D460816
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 15:30:35 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c169ae1cb26so384160166b.1
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 08:30:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785511833; cv=none;
 d=google.com; s=arc-20260327;
 b=lQwOLhyKBJpTg1B9FmBBFXrTnRBtxs2FAM3mZP4jmeThKnS9Vpa0op0ILrc8n+SSR3
 J3YnIu87yg6dSGdAbvw9JLiMWwbf4jKXgSTvqm0TTGhODEo3ZdN9yycryAmdJCLJNVYs
 rQFmIF+dNAtwCQLYf45dxEQTkXpDNrxmb/UV7kEHo5J9FwZRwHLr+mG93Q8Ojd8WfXuu
 ySkKHYwAm6NvTG0269gtm1YCs/YBpFHmZRFnef8+wJDjiVu7mR6FCiwf6wotRctEKir7
 iplXzWdvmQcBKPXtxYD9ZjabZ+YpYLCsg+ZIPNp6hFkumArZ4MA5XBVPOyKzirdEhUk+
 rkMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zyMaR01CZnD+fyeBYNldP/G5Ichz/KM6YH4bZrs1FX8=;
 fh=NbS+ZXbAEiMFaiNIvS3MM/1ciJNf8n4gkCR6bN4C0eo=;
 b=NFqSxneFeMvB2w9wbmf3K2jMuX4mfE3b8LO+QQoWxGDQIvYptX7MiI2q/yLR2bLYH7
 IxUORB6jUNTl7qIi9Z0L+EWnn06AvNbt+ZiUFNvBua36cNvgs7hGK4idg7yloMLi6TPr
 cSm1kYG8lTfg2RsLtDDmvqcAqEqnkcLKJeXB21Q9fStsh6mT5imqSJv1rYHVSOFhX1Mq
 15d7YHX/nSQedsZzJ6eenczJMy9BLuGj8x+mrTAOs6Jeoxn3ebNNSyC0tqmejAeE+fN3
 TFMdfdeGvTzyIWMw2W/LA4T/hRPxfoFuTEck5mL15wtEraaFNZGr5fg3bdClIn5n19EE
 8RMw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785511833; x=1786116633;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zyMaR01CZnD+fyeBYNldP/G5Ichz/KM6YH4bZrs1FX8=;
 b=MAFumFSNl2CDXUOs7GL2YhoIFDPzrxky/3+n8O9zeIlV/9U9TMHqSMiK03s3pqaXSf
 awBplWdFClaZRDsHVhw90Rk/xZhLjzBWhxarSAbhrnSFnk7Bwqmm9YvV1Xq0zDPkpZ7X
 JCXk3KlhzsXkX5LzBKDjuXqGuEEz2LjGZGcjnShDbKY316hSjyF4nJqlB0EmECYIPS2i
 KiBgoaVbtYsaMqhIQqzKaTsNcNZCJn7GcFghBq6ye4ZUYgei+XOd9ijzExxn3yDBVrJh
 9RnYDCEl4CbNJTTWk9oz2yv6a51SXpj1gjDiNFksPCfLb7Hg1XPwOrLQt8Vttni0JFf1
 dpwg==
X-Gm-Message-State: AOJu0Yz7dIV+wZMLh2hw4uZa0305XgMn38vt5QSarIbTzhVF3Rpsqkyv
 WV6w1CLnDoF7wLWQMLNtMsiyZCwMoqnby2SsMB5nbfUEeU7hJNFmBxcgnDCb57FjEeH5nfxoHMr
 t31kgpWgOkkaoPuKBoAePDLe/MHt4MYZSNAd7nNjUeof+maddi2zMNSo=
X-Gm-Gg: AR+sD10DQZU5e/FHHiOa7mNKBtkJrdmB8rN7jXMEez6AZXyVxIpwT6j89MDGMpBlhHu
 oFDcWkU47C2eSXNZqtpyB/IYCOehxACqT4xLWpNjBoxUEJowuKiqz1981ReEfBHuXvmmFe6YeoM
 7boAnEsOHsLF5ET0l5WkJSKOX1BQyceDme1K1jD2Wm5L09h7IVqiWmjckkVZACcMtkP/og6m8q8
 duP/5uD4UAgC8ECGzpUx30qZb7mvAORJqVxAasVMSQ+s2f+CDPGdFoyz2SMlQWNQZw7mdjSCZuS
 Lr0sN3sDlrXXukUF57e/9Q0/3BDoeFK+Yx3l64bO4nOusXeQPWOw8XG0H9HSb18KouG/1gyivYi
 m
X-Received: by 2002:a17:906:9c96:b0:c19:7908:c67e with SMTP id
 a640c23a62f3a-c1fd316d26bmr157112166b.4.1785511833129; Fri, 31 Jul 2026
 08:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
In-Reply-To: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 31 Jul 2026 19:30:22 +0400
X-Gm-Features: AUfX_mxOiNyxGEdEmtOTk2GPpPF4L2_BdNQSYiy27qqny1VW_74Vyu0vydDpsXY
Message-ID: <CAKTNdwGG1w9qe82UBWjBx3kWK15b2v4vcdKK8NG7vcEuHJocLg@mail.gmail.com>
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
 Tim Lunn <tim@feathertop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785511833; x=1786116633;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zyMaR01CZnD+fyeBYNldP/G5Ichz/KM6YH4bZrs1FX8=;
 b=QTlZrrGjbGNOz72Uvc58zY2e2EEcqKQCm52aWw4Hb3+O1voreNKd/YNCiFyRKCKtGM
 kt/zhv53U0MNrnkGExowOURR+2etQOJlKNmP4yF2gHSYSwQ5MULvAqSyIY98rifz1i3d
 CpTcrIxVb1A8RMpppPmqUTgQ28n5+QKapQxaM4uq6zO68tSMdEcQsucwC513y31gOCWT
 4j8xcurhCANka1RYPx6gEm89jM3gPyZiEeWEemXq1ujpwxGkk/utSPV0TF/GnW7/1GDK
 X8fO5biQLpEKTogRCA/5SyzqdwzdwahkeZTig+gTuY9YnyMljKGjNky2YDavZ7orFbGc
 xg3A==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=QTlZrrGj
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Fri, Jul 31, 2026 at 4:40=E2=80=AFPM Alexey Charkov <alchark@flipper.net=
> wrote:
>
> The GPT partition entry array is sized in bytes by the spec, so the
> number of blocks it takes up depends on the block size of the device.
> U-Boot got that wrong in gpt_fill_header(), which reserved a fixed 34
> blocks at each end of the disk. On a device with 4096-byte native
> sectors, such as UFS flash, the backup entry array ended up 28 blocks
> short of the backup GPT header instead of immediately before it, and
> roughly 114 KiB was wasted at each end of the disk.
>
> Patch 1 calculates the count from the block size and makes the four
> places that need it share one helper, since they disagreed with each
> other in different ways. Note that it also changes the 512-byte layout
> for boards that do not use the default entry count:
> CONFIG_EFI_PARTITION_ENTRIES_NUMBERS is "default 56 if ARCH_SUNXI" and
> is set to 64 by a number of Rockchip defconfigs, and on those
> first_usable_lba moves from 34 to 16 and 18 respectively. Existing
> tables stay readable, since the entry array is always located from the
> on-disk partition_entry_lba, and only newly written tables are
> affected. Partitions given without an explicit start=3D will be placed
> lower, though, and on sunxi first_usable_lba lands exactly on the 8 KiB
> SPL offset, so sunxi and Rockchip folks may want to look at patch 1
> specifically (none of the devices I have override the default).
>
> Patch 2 is an unrelated big-endian correctness fix in the same file,
> noticed while auditing it: a few header fields are read without
> converting from little-endian, and one already-converted value is
> swapped a second time.
>
> Patch 3 is another unrelated bug that has to be fixed before any of this
> can be tested: part_test_mac() reads one block into a 512-byte on-stack
> buffer, so it corrupts the stack on any device with larger blocks. Since
> it runs during partition probing on every device, sandbox crashes on any
> access at all to a device bound with a 4096-byte block size.
>
> Patches 4 and 6 add the tests. The C test sweeps block sizes from 512 to
> 32768 against gpt_fill_header()/gpt_fill_pte() with a synthetic
> descriptor, and the Python test writes a real GPT to a host device with
> 4096-byte blocks and checks the resulting on-disk headers. Both fail
> without patch 1.
>
> Patch 5 is a prerequisite for patch 6: test_gpt_write_part_type() never
> binds its own disk image and has only worked because an earlier test
> left host 0 bound, so it breaks as soon as a test binding a different
> image is added above it.
>
> One known gap: test_gpt_write and test_gpt_write_part_type hardcode the
> 128-entry 512-byte layout, so they fail if sandbox is configured with a
> different CONFIG_EFI_PARTITION_ENTRIES_NUMBERS. The new tests derive
> their expectations instead, and pass at 56 and 64 entries. No sandbox
> defconfig upstream uses anything but 128, so I have left the old tests
> alone.
>
> Tested by building sandbox (default, flattree, sandbox64, gcc and
> clang), generic-rk3576 (gcc and clang), sonoff-ihost-rv1126 and
> A20-OLinuXino_MICRO-eMMC on armv7, and boston32r2 and boston64r2 for
> MIPS32/MIPS64 big-endian, which is what patch 2 is there for.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
> Alexey Charkov (6):
>       disk: part_efi: Size the partition entry array from the block size
>       disk: part_efi: Add missing endianness conversions
>       disk: part_mac: Fix stack corruption on devices with large blocks
>       test: dm: part: Check the GPT layout for large sector sizes
>       test: py: gpt: Bind the disk image in test_gpt_write_part_type()
>       test: py: gpt: Test the GPT layout on a device with 4096-byte block=
s
>
>  disk/part_efi.c           |  55 +++++++++++++++-------
>  disk/part_mac.c           |  12 ++---
>  test/dm/part.c            | 100 +++++++++++++++++++++++++++++++++++++++
>  test/py/tests/test_gpt.py | 116 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 261 insertions(+), 22 deletions(-)

NB: the CI passes all green:
https://git.u-boot-project.org/u-boot/contributors/alchark/u-boot/-/pipelin=
es/841

Best regards,
Alexey
