Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39587C54E58
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 18:46:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65A2387F65;
	Fri, 15 Mar 2024 19:46:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="O1Ud4YOV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3C9C87F65; Fri, 15 Mar 2024 19:46:13 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9549387F3E
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 19:46:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sheng.tan@9elements.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a466f89560eso305369266b.3
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 11:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1710528368; x=1711133168; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Do2UbJhclMzuNDMOm7fHQfWTtXbyR+3bW/yn7Z3gtKE=;
 b=O1Ud4YOVqEWaYnzXY3rHyqpNl1m/Y5Je12NS2Z4Lv9KTA3uSAmQrPPmvMlFM3zAY6p
 xkOI4WG2sV4HTC3rWLYivC51i1sR80CgEe/8Q4lh5UgaAHD36F3qlysHgQ8HpwUYAciK
 +2YzHgTRzugQ/EW4U9kUh5J0m2CumuPqtR+fFpY62+EfCg4GEvt7ffD/kdw7juAogtqG
 l4M9BoB9qQROW7jIINvTbWdFJU4kBIoF8vUogE47MbXX3inAPiE/iUlk98XkupNojEIA
 AbObBDu1Y2VddUBhYd8SVS4d/80wparZ0ClhlnJ8YsMG8V+GqwRCEnseYnUgoMYA79/J
 I4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710528368; x=1711133168;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Do2UbJhclMzuNDMOm7fHQfWTtXbyR+3bW/yn7Z3gtKE=;
 b=GpjLbTxn5KeNoZ4nwj+uH4H7uDA0ocUn1KnaVR+gCzlrdvfv23lJUB81DEJ/hRkqZf
 AkA5Jeo6hYjAiMUmCvv7iWBrTGzAoddrjhWJaU32CpKOyq+lRlIa1LEWu8ZpYC+s7u1B
 9MeLizB4d6cQNxiQI7eFIqvjvXTqoareO7BqCvrpiuCqnolZHZOJk7KCsLW1m71y7KfL
 CbI5/Sd2zJsY++Ue17gplLrC8crCJTZ9NS2NThtHS1HgOw/fH7va4oWEaIym+qhHL5jo
 jusOrxjLBfRvn8FtdUc4vH7hGJAzCKFu0ZjrM+oBFxj83tySqytF1Pzxhjc5M+hgS3ye
 T+2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2IxUTgxxkLDxKlrNhg4SoQxz0SE5Z7BaJcc9XHdMFJzmzY4EaWanz/2pzrWRTy/QpWUQSON0nx2D26zrywKvk1yoqzQ==
X-Gm-Message-State: AOJu0YyQXNLYxN7+f7grPCC8Olq73+bNJ5jVOnxaDDDeX3EqNPATgxKG
 usy7h51Y0QcIZNTY9kgR/i+d/IXyppe9MetsD9CCgtwVdLvAkNvAGbleAqw2Gl9+Sz4QI7IX0uQ
 /IO92fvC2uaK+/OBLzPedBRtmOprg08vGiYgrdQ==
X-Google-Smtp-Source: AGHT+IGIm3FBw2srfaWNylqFl/rnY9LV6CyheyQf/Us0YDwWqhUCrvDfJ1igCPf1GX7C3TfrTZQTH6y53MKVW8WlE4M=
X-Received: by 2002:a17:907:9618:b0:a45:f74d:343a with SMTP id
 gb24-20020a170907961800b00a45f74d343amr4918902ejc.22.1710528367611; Fri, 15
 Mar 2024 11:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240227201857.25814-1-cmax@mailbox.org>
 <CAMWxwJ03vRW3Cqis7i5Lyd3n0WGHPe1tNNHOpWJt7bKPh0pAVw@mail.gmail.com>
In-Reply-To: <CAMWxwJ03vRW3Cqis7i5Lyd3n0WGHPe1tNNHOpWJt7bKPh0pAVw@mail.gmail.com>
From: Lean Sheng Tan <sheng.tan@9elements.com>
Date: Fri, 15 Mar 2024 19:45:56 +0100
Message-ID: <CAMWxwJ2meJcahTqRApjL8ZQ24bY3cZ6-D07tdO_Ys6YC-o-8TQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: arm_pl180: Limit data transfer to U16_MAX
To: cmax@mailbox.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

+ @Simon

Best Regards,
*Lean Sheng Tan*



9elements GmbH, Kortumstra=C3=9Fe 19-21, 44787 Bochum, Germany
Email: sheng.tan@9elements.com
Phone: *+49 234 68 94 188 <+492346894188>*
Mobile: *+49 176 76 113842 <+4917676113842>*

Registered office: Bochum
Commercial register: Amtsgericht Bochum, HRB 17519
Management: Sebastian German, Eray Bazaar

Data protection information according to Art. 13 GDPR
<https://9elements.com/privacy>


On Mon 4. Mar 2024 at 16:39, Lean Sheng Tan <sheng.tan@9elements.com> wrote=
:

> Quick reminder:
> Can anyone help to review this?
> Thanks!
>
> Best Regards,
> *Lean Sheng Tan*
>
>
>
> 9elements GmbH, Kortumstra=C3=9Fe 19-21, 44787 Bochum, Germany
> Email: sheng.tan@9elements.com
> Phone: *+49 234 68 94 188 <+492346894188>*
> Mobile: *+49 176 76 113842 <+4917676113842>*
>
> Registered office: Bochum
> Commercial register: Amtsgericht Bochum, HRB 17519
> Management: Sebastian German, Eray Bazaar
>
> Data protection information according to Art. 13 GDPR
> <https://9elements.com/privacy>
>
>
> On Tue, 27 Feb 2024 at 22:02, <cmax@mailbox.org> wrote:
>
>> From: max <cmax@mailbox.org>
>>
>> Currently fetching files bigger that cause a data transfer greater than
>> U16_MAX fails.
>>
>> The reason is that the specification defines the datalength register
>> as a 16 bit wide register, but in u-boot it is used as if it is an
>> 32 bit register. Therefore values greater than U16_MAX cause an
>> infinite loop inside u-boot. U-boot expects to get more data from
>> interface/hardware then it will ever get and therefore inifintely waits
>> for more data that will never come.
>>
>> Signed-off-by: max <cmax@mailbox.org>
>> Cc: Peng Fan <peng.fan@nxp.com>
>> Cc: Jaehoon Chung <jh80.chung@samsung.com>
>> ---
>>  drivers/mmc/arm_pl180_mmci.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/mmc/arm_pl180_mmci.c b/drivers/mmc/arm_pl180_mmci.c
>> index 5cf5502ed5..af2f9a5a84 100644
>> --- a/drivers/mmc/arm_pl180_mmci.c
>> +++ b/drivers/mmc/arm_pl180_mmci.c
>> @@ -231,6 +231,7 @@ static int do_data_transfer(struct mmc *dev,
>>         u32 blksz =3D 0;
>>         u32 data_ctrl =3D 0;
>>         u32 data_len =3D (u32) (data->blocks * data->blocksize);
>> +       assert(data_len < U16_MAX); // should be ensured by
>> arm_pl180_get_b_max
>>
>>         if (!host->version2) {
>>                 blksz =3D (ffs(data->blocksize) - 1);
>> @@ -358,6 +359,14 @@ static int  host_set_ios(struct mmc *dev)
>>         return 0;
>>  }
>>
>> +static int arm_pl180_get_b_max(struct udevice *dev, void *dst, lbaint_t
>> blkcnt)
>> +{
>> +       struct mmc_uclass_priv *upriv =3D dev_get_uclass_priv(dev);
>> +       struct mmc *mmc =3D upriv->mmc;
>> +
>> +       return U16_MAX / mmc->read_bl_len;
>> +}
>> +
>>  #ifndef CONFIG_DM_MMC
>>  /* MMC uses open drain drivers in the enumeration phase */
>>  static int mmc_host_reset(struct mmc *dev)
>> @@ -373,6 +382,7 @@ static const struct mmc_ops arm_pl180_mmci_ops =3D {
>>         .send_cmd =3D host_request,
>>         .set_ios =3D host_set_ios,
>>         .init =3D mmc_host_reset,
>> +       .get_b_max =3D arm_pl180_get_b_max,
>>  };
>>
>>  /*
>> @@ -531,6 +541,7 @@ static const struct dm_mmc_ops arm_pl180_dm_mmc_ops =
=3D
>> {
>>         .send_cmd =3D dm_host_request,
>>         .set_ios =3D dm_host_set_ios,
>>         .get_cd =3D dm_mmc_getcd,
>> +       .get_b_max =3D arm_pl180_get_b_max,
>>  };
>>
>>  static int arm_pl180_mmc_of_to_plat(struct udevice *dev)
>> --
>> 2.43.0
>>
>>
