Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03FD6C5DF9D
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 08:30:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E83786077F;
	Thu, 27 Aug 2026 08:30:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cKTBosodgFR0; Thu, 27 Aug 2026 08:30:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787819434;
	bh=27r9yt3zEk1hQydzJyk7CgJqq8zceAz8k+ex1dkNNeY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0Rl7A2J5YBRIZiCa5gU5x2y67MFOjeCD2Hg0J6j2snZivUdTdfDLsdFF1muKkotTZ
	 QsdTVACxh/iY95DAp+uwZCfULtGqbGHnkabhnsO0RLavxMMkqlvHmO2Y19YYgsTCIK
	 oA5X1fdQ1GWewjBtwUCSExWrTeoOwB70o1jgqz6g2SGMH4UMoAOK1Z9VUYNj6ANdQ8
	 i7ZQjNahAdTt8uXxwsVBMVdDqBAfrsCUcso8IjFe79oISmBabjDjnQjoERZDS5Cinz
	 DATeRZV3/E5xRJIu/BtnOjPFGe/eA6gFRuMGgFzWmBPs226+8snfBiYQWCkkZkCH72
	 xjW8HrTZgxn3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E24C60761;
	Thu, 27 Aug 2026 08:30:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4081A7AA
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 08:30:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2294080D85
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 08:30:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1qd2TAZ_LEBG for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 08:30:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=jt5aTHz7
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CB1ED80CBF
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 08:30:30 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c1671ec8692so281394466b.0
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 01:30:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787819428; cv=none;
 d=google.com; s=arc-20260327;
 b=TVUooB41C3oWQtF2l0zeON2dYLITutKgxqk1sOT7l9ZiCRZOLViycn2YV9a94cRspx
 54X1SqDoSvXZjwKIT4LYQH9IZ5BEPNRqcYEctqvpzZxVX3ZtoSPTeFOul2uAWXN/JGKe
 k0Fj0cQHTwpxuQZGXT2VfvoIPwO3eV/DSVaRQeZ7+h9Guxxs0dmP9zfsCpGaF/L1GEK8
 G3PMUfEiTbKYGD8ReyRNrQ8N+u2lMgUVjKmDUfEdRP7H6++8zUemBqxeb4FxIg2sYEkr
 kkS6LnrQw3cYTcxalnBNS6X52ua1HjmLMnsov259q0shXcX1uHIOgc0DgkwM5OSjYE61
 CxXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=27r9yt3zEk1hQydzJyk7CgJqq8zceAz8k+ex1dkNNeY=;
 fh=Fw7tfzwN2zm3e0w6KwCQ6GtoE5oGgZDPkSy0XPNsZg4=;
 b=IbOgH296E0Su3tmvH1xfxMKXbrEu1b9GNBhsucmcy+YWJxYjWL0fGdwKrkO54RFtlB
 5naZ5czgM/NsZqzby+k7utPFQQB1w1zObehyIiCYlVQ9GXkXQLsxHwQQo4lvViBhOguI
 TKm2B6+cIHxUcrfIY3fZ+mGligVtxvCB5pOcO3lf1Xws9tThI+FtoVfEjLUKhMUNboXb
 5PgUUxqgiE6tmZBz2wiPnC+C/usACzBcoaPNtr5CeUX6SJca5a9TK/kUqAcgarN1Vetm
 40Q6ycIX8ZoqTZLVkGZB4pQUR62yGjZSIxzDMZEDV2PV67D1Ig8qmADFO7drZy8hqL8/
 BPZw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787819428; x=1788424228;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=27r9yt3zEk1hQydzJyk7CgJqq8zceAz8k+ex1dkNNeY=;
 b=jt5aTHz7K2a0/4Spx3U6/OXu96klvJWJXcwPRwLYv7/YYcQiY2I9bG2wFKUTzIBwqu
 66u7fro1wfamHLEwsVDrjhpvc3VvZmBe2/PLjKxXsZrN9PDaqjI40ooJi9RPz5/t0rNE
 k+/taHTn5iWmsKPYtQlXER1mWv+EhL4e5w2BeXub/21JhNlfxwTJISZ1CSIJNI66jkH1
 0Ke/IvNuEO0lmqWDvh2JolzUXRMQ7OM6CwqbvxfsHoCLbd1s6QSFyGWBxxo1utoHvWYk
 4nY6sDl+K0c+ZoxfSLm/4JnHww4MsdnDAdDudj5jzXhR/jkZP2NWO0PAzdGGXFyPpbbf
 xfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787819428; x=1788424228;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=27r9yt3zEk1hQydzJyk7CgJqq8zceAz8k+ex1dkNNeY=;
 b=AFL/kTsMT7diZU7UXMgyZUjok3WzLYaWlrKuoQcyKvwWT4tBgTUicCnCbdzwlRGEkA
 Mp8snzTvIbbOO/zwsEDtR1U58kMyCBxPk872yQXeWk1JhdyKiL+L5zQVngglZ8b+ENvV
 /oSmqguSwWtB7Lf27rplKouDLb694/mUUmdxGm0J5lKvdJ/p6HQHnC8i6ltkvy9COBSL
 TvzuqJ2CfjAm+PMWvqVl9/sTt2hGp4kqE5RI0y8gO2m6xhF746iiTWrn1rCTM62HggAG
 zW4bWBiPI/+Znh7PFu7VdJ0CdvmMr1F7ichbh3RjvIjqDwF7I70lusfwVgYGewZUx5Mb
 3h0A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrMy/xc4hVF0A3XjzVF3iTS1bHNGOGVzY6pyIgj2paNI8O9O5ZoghEOZrI0bG+Eh6gMiQyj6OI=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++knX7jwLA5Emw6B1GxnVQOxrifogZ1ptvsN3dqataIxX1076G2D
 l9Ueut1FPev9AuYlafhMA2C/xbPfWMQcFqIAm7wIVibT/mIhdVL36UoXyDAzN8AsDr/5hvdYXFX
 RD+8VUcvoBQvUk65MU3QnBElU4rysnd+ifoyn9AwpZA==
X-Gm-Gg: AR+sD11ubvfVRlxcH6H/FCh3gujbIrzSD6ZtZ34P9utya+ED8nhicJh+ceMWLVKt63g
 5citoFNAXJa2ZpAifPfiF/cSQpyAfGN1w29CZjSo6oMqIPeRFFTNPE9giXWL5r/y7zR37Y4JC+E
 i2a03m+nUTT1C9mQG08q80B30hhvtfkghRvMiWTuCt5fdZBfFxMJAIXjL/h1kzt2REHABWqYHwR
 z8HSUHlZAjBkWQ5FFwSD/ZVciK7bNNw3/qr97yB+7x4C3PXlbbCKQ4zyYwQDKzve02myJeT5y01
 +bktUpSui27Ghw0m6nMyVQ2Iy0cL4ECkzAGt7B8aMUCKQQ1Xzwkd3I7cD9tjAHgG/PxEyfewXS9
 M
X-Received: by 2002:a17:907:cb88:b0:c21:992e:63f2 with SMTP id
 a640c23a62f3a-c250c44a08emr1354711466b.1.1787819428138; Thu, 27 Aug 2026
 01:30:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
 <20260731-gpt-4k-v1-4-a3f1f16b53ae@flipper.net>
 <33c631d3-70c4-4cfc-a351-c43e5553dba3@canonical.com>
In-Reply-To: <33c631d3-70c4-4cfc-a351-c43e5553dba3@canonical.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 27 Aug 2026 12:30:20 +0400
X-Gm-Features: AcwNN1VBQyD2SpPn7DKrLhXKMLAbhmScPiJmyZnNbN4Ldz55pdWBO8AwWj6egr4
Message-ID: <CAKTNdwGniVaK0_k1e+3PYV1xY6JDizOVRDrJai2f7U3tGuf6LA@mail.gmail.com>
Subject: Re: [PATCH 4/6] test: dm: part: Check the GPT layout for large sector
 sizes
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Anton Burticica <mouse@ya.ru>, 
 Javier Martinez Canillas <javierm@redhat.com>, Simon Glass <sjg@chromium.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Jacobe Zang <jacobe.zang@wesion.com>, Jagan Teki <jagan@edgeble.ai>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Suniel Mahesh <sunil@amarulasolutions.com>, Klaus Goger <klaus.goger@cherry.de>,
 Tim Lunn <tim@feathertop.org>, u-boot@lists.u-boot-project.org, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
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

Hello Heinrich,

On Wed, Aug 26, 2026 at 12:36=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 7/31/26 14:40, Alexey Charkov wrote:
> > Add a test that runs gpt_fill_header() and gpt_fill_pte() over a range =
of
> > block sizes and checks that the partition entry array is sized and plac=
ed
> > consistently, in particular that the backup array ends exactly where th=
e
> > backup GPT header begins.
> >
> > Neither function performs any block I/O, so the test builds a synthetic
> > struct blk_desc rather than needing a block device with a configurable
> > block size. The expected array size is taken from the GPT header fields
> > rather than from GPT_ENTRY_NUMBERS, so the test still holds for builds
> > with a non-default CONFIG_EFI_PARTITION_ENTRIES_NUMBERS, such as
> > ARCH_SUNXI with 56 entries.
> >
> > Without the preceding fixes this fails on the first block size other th=
an
> > 512:
> >
> >    test/dm/part.c:313, dm_test_part_gpt_blksz():
> >        entry_lba + pte_blks =3D=3D first_lba: Expected 0x12 (18), got 0=
x22 (34)
> >
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> Thank you for providing the new test.
>
> test/dm/part.c is never tested in the CI on big-endian systems as it is
> restricted to the sandbox.
>
> The sandbox restriction arises because test/dm/part.c relies on MMC
> drives emulated on the sandbox. We should instead create memory backed
> BLKMAP devices. Then we can run the partition table tests on QEMU and on
> real hardware.
>
> For your new test I would suggest to simply move it to a new file in
> test/lib/ as it does not rely on the presence of block devices.

Thanks for the suggestion - I moved it in v2 and it works fine.

Regarding the other point: memory backed blkmap currently supports
only 512-byte sectors. Therefore, in v2 I added a blkmap-based test in
addition to the sandbox-based one (rather than replacing it), and they
exercise different edge cases. The blkmap-based test runs on malta64
catching endianness bugs and validating host block reads, while the
sandbox-based test exercises an externally generated spec-compliant
GPT image to ensure we aren't just being tautological.

Hope this sounds good.

Best regards,
Alexey
