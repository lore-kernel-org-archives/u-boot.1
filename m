Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 529F8C4706F
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 08:51:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4AEA87516;
	Thu, 28 Dec 2023 09:51:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="x+N8Cvur";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9E9887250; Thu, 28 Dec 2023 09:51:19 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6530087516
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 09:51:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-50e7f58c5fbso2625189e87.1
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 00:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703753475; x=1704358275; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rwEpRFJLohgqsLSQvNRCy5hwo/Bl4FnKv3OeGS6Xe84=;
 b=x+N8CvurIBU0PlUkj0yZnAKrxUeCnp0vL//cNfXYZJg+AkTJdRjekG03+iDO10NNOV
 UH+qIugbPMZ98fFTv86ivBFzkeYZi1VjjsbKV09A86VUu0/LcTwS2X5hUhS5H1/dygx6
 AZ0pu+y+agI72igPL7yc6glMJoms7hjd2BZR8JDx5Q1hoV9o9W9FMCnL474sxHGez6nQ
 my68knYmL8JMjRjEPjx+/9+hF27AviLheePFBZSWYn19r/S6qwXQcO9JD0rzyFJO/5Ex
 Gg4E3Ec9O80utddCwJ2f1sA4wBOZ4oc3DC8gREN85+bXJm135hcmpTChehOjxGE/86O9
 Eb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703753475; x=1704358275;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rwEpRFJLohgqsLSQvNRCy5hwo/Bl4FnKv3OeGS6Xe84=;
 b=bfrgwr2eFg/OQCuFxS2hzr0euO5o6P3OhMqs6kOMepl6t11imsYkhGpLNJEVwHsjr2
 bRb4dwlnwTAF/rEexMRqx+0pG0PgTTmYEJuu4+HdbTEgxJvtn91TQJiQ5dUDpSQcudA5
 EyiBb4sRD4KUA5dx3vrdw5l6srCQsacUnTO3VhXepMKknpt9+JKtwaAfDnlHrTmBSrSh
 3V79r2FLfR86BlIK4Ao++KmEOYcKe5grjAzEnCulJzrCNFgmFoRZWLK/fi1Qn14J3OkC
 b2Hx+5Dvzy5ViNNrFUeIJCG/afv/eVvKVWWdTXmoR3VXRvBfWGg7Nqw7EFhkaljanOsp
 1ppA==
X-Gm-Message-State: AOJu0YxIzK5BTJxf1mbp+/Tx4kQ/SlonAiXj+IZeZ2AR4FxGF11FZh4N
 VhUGt7A5Jnqun05R9Z4jaq3cZtpUTvDZAHWHKROIhhhr41/D1g==
X-Google-Smtp-Source: AGHT+IEod8aWF0zb8FHvCcLQlXeuE6ZEDiTR2MMV0KQ7A+lZnUax3EUS6vZOvUuzRBHComDBDgY1M+Kceoi4ecE3WhE=
X-Received: by 2002:a05:6512:348c:b0:50e:7c73:f4ba with SMTP id
 v12-20020a056512348c00b0050e7c73f4bamr2101830lfr.91.1703753475597; Thu, 28
 Dec 2023 00:51:15 -0800 (PST)
MIME-Version: 1.0
References: <20231222213110.660402-1-raymond.mao@linaro.org>
 <20231222213110.660402-10-raymond.mao@linaro.org>
 <CAFLszTjGejJm4XdCachiy5C-2i2L2XyWUschx+bNy+1YpYoOcQ@mail.gmail.com>
 <CAC_iWjJdtqT8dUszq6G=Ak_W4n5U9m1dkq2FryidBYg0unKAPA@mail.gmail.com>
 <CAEfUkUJStL=GH4hnOG8NJfAUK1Eom2uT2W9tFt6ak28LXracFA@mail.gmail.com>
In-Reply-To: <CAEfUkUJStL=GH4hnOG8NJfAUK1Eom2uT2W9tFt6ak28LXracFA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 28 Dec 2023 10:50:39 +0200
Message-ID: <CAC_iWj+6RdcBBpRxOE_-YUFAqfs=f31fxU1pXixrXYDD+t5pCA@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] qemu-arm: get FDT from bloblist
To: Raymond Mao <raymond.mao@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, jwerner@chromium.org,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Baruch Siach <baruch@tkos.co.il>, Michal Simek <michal.simek@amd.com>,
 Stefan Roese <sr@denx.de>, Sean Anderson <sean.anderson@seco.com>
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

On Wed, 27 Dec 2023 at 17:43, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Ilias and Simon,
>
> On Wed, 27 Dec 2023 at 04:32, Ilias Apalodimas <ilias.apalodimas@linaro.o=
rg> wrote:
>>
>> On Tue, 26 Dec 2023 at 11:48, Simon Glass <sjg@chromium.org> wrote:
>> >
>> > Hi,
>> >
>> > On Fri, Dec 22, 2023 at 9:32=E2=80=AFPM Raymond Mao <raymond.mao@linar=
o.org> wrote:
>> > >
>> > > Get devicetree from a bloblist if it exists.
>> > > If not, fallback to get FDT from the specified memory address.
>> > >
>> > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
>> > > ---
>> > > Changes in v2
>> > > - Refactor of board_fdt_blob_setup().
>> > >
>> > >  board/emulation/qemu-arm/qemu-arm.c | 12 ++++++++++--
>> > >  1 file changed, 10 insertions(+), 2 deletions(-)
>> > >
>> >
>> > I believe this patch will not be needed, since we have fdtdec_setup()
>> > to do this.
>>
>> Yep, it's not. The board-specific portion should be limited to what
>> happens if the bloblist is *not* detected by fdtdec_setup() (assuming
>> the user wants to allow a fallback)
>>
> But I think whether we allow a fallback or not is really something that s=
hould be
> considered by a board vendor other than a common logic in fdtdec_setup().

It's not. The bloblist is coming from the standard register calling
convention. Doesn't it make more sense to have the code
- Scan for a bloblist if BLOBLIST is enabled
- Fallback to board-specific methods if that register does not contain
a bloblist, or contains one without a DT entry

> And a board vendor can also decide whether to allow a FDT that comes from=
 bloblist
> by this custom function.

I am not sure I understand this one. That decision should be in u-boot
proper, the vendor should only be allowed to provide his special DT if
we dont find it in a transfer list


Thanks
/Ilias
>
> [...]
>
> Regards,
> Raymond
