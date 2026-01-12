Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6FF7C9EC8B
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 13:12:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 455E283B85;
	Mon, 12 Jan 2026 14:09:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OyX0w3ei";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54E9C83D77; Mon, 12 Jan 2026 10:48:20 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A30E83CB9
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 10:48:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-64daeb28c56so10096913a12.2
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 01:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768211298; x=1768816098;
 darn=lists.denx.de; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1+3cdNS7vfJruzEN2GuaICwpMhvXW9FFyAsle4sFr00=;
 b=OyX0w3eifya9kIP4kcIckofwDV5pXXmRL7K2AkwvIPDld61wKYQkvG/Ju3R90e6h0a
 h1uAT1TLDiOLSZty7zZzjB4NWCnN+R8JQowa44slWafAn19zDODO8kNEkExlFYK2PYAG
 B5OEeVSgr50Yd/pwuBbw0Vu/A0ujul7OCrGIFsc+5Gim/LzVDMrErKLS0G9HAMhHFhcu
 ji2VnSNQmB1J8HoOJ8PMKjByf4Wgy7Tkk4CDSSFYgSyLiKHDTIORpoG4qa+V2xYHns1h
 UkeE27yeiRVSfZ7VglV4mRVfSzJfqrYFePWfczWTSOSv1Bg0C1+ftDxThHNL8rPD9Rjc
 NTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768211298; x=1768816098;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1+3cdNS7vfJruzEN2GuaICwpMhvXW9FFyAsle4sFr00=;
 b=tHaieyUtcS9b95AaXdLtpQ3TyIdPMF6J8siyO58+TdisVnx1rC7rfgEkE8D0AVptr+
 otJk5vuYeNPF2/GsyH90Pn0FILn8lmjUWJY35JqqtJEuvcHONKOqw08bX30pQNyhJA1r
 e2dyshjW8Y2YewlXDl9OXMlUlGayouz70kP3Wxprle4Et3CSNbJFPpBQZC5qdFUHgpAJ
 ctg9M3Kzg5HMO3Aay2jnNWK5hzr3tn8GGgfquFgEOiuz1yYNZFyly+1ciRQAayUrrN6Z
 nHnco0sKKqOGQ3rEwBEAYmMqh283DIrmVV2pr2RuQDB1OmLZQc++hWu4+zTumooSp0Wz
 IKCQ==
X-Gm-Message-State: AOJu0YzyjmzJp6sBCiIjAYBoWglZYImhRJjLq6RNEGUZjYXbJgHQtlCv
 nf2fTqu0bbOdcAlIc7AX6Se2yESpiakfsC3cMWhoiD6XYi9Kl0kUfuBMoAu7hQRc6ag=
X-Gm-Gg: AY/fxX7MszgZtlJX3aY7vcwDmbvPynzBlss4UnkV4ZVltjn81w9Rb6Dp7e5vtEwFgy5
 4USC7WntQkWccGTlRk9b9ZdQWg2T+BtHwwo7BXDjh8EQYtb9L7Fy6dn9zHr1C7qLNFUqb3cFWb4
 7UmulAtpvIzjHM1piLVLXzud3V45WxUUNqtbGd40/Ccrje88gZjJcXbtfGz/PCOrzCQKnZKlvg8
 6R31ROJFM8cjPSOwYMFTBgDLkwByJdySf2UQM/2X/VhOV+OcJ96CXpUiGQqxM63vOZrt3iSZZ9P
 MMdLorf7nrrsEGRZ7d4VpMWc920b18ksZ8/OS/UoCIZ6+P+aMTlHLepm9rb+EswizS4rUSTtA0f
 kbPenknfTrjEW1KuLrow8YExJOC+AGbJmXE42jKjwGPlsUklV8UI1Zc4suWzYviN0z8amf8Td50
 r3Ztc=
X-Google-Smtp-Source: AGHT+IGze8JZPZhema+2EknrsGO3Gw4pLw1R52NLTPyC5ZSqoU0FmF0ErlpLwpDe2zxkGBCNL0QjDg==
X-Received: by 2002:a17:907:3c8a:b0:b87:173f:61b with SMTP id
 a640c23a62f3a-b87173f2ad8mr313794366b.9.1768211297703; 
 Mon, 12 Jan 2026 01:48:17 -0800 (PST)
Received: from localhost ([195.52.31.202]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b86f88f90a4sm613122866b.37.2026.01.12.01.48.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 01:48:17 -0800 (PST)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=7b9d336b1a6363b1b4dec1c42678508d957a6fe3cfa9bfe0bc92baa5d945;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 12 Jan 2026 10:48:11 +0100
Message-Id: <DFMIL9EHIYOP.V8NWH55NYJTA@baylibre.com>
Cc: <u-boot@lists.denx.de>, "Mattijs Korpershoek" <mkorpershoek@kernel.org>,
 "Tom Rini" <trini@konsulko.com>, "Marek Vasut" <marex@denx.de>, "Andrew
 Goodbody" <andrew.goodbody@linaro.org>, "Kory Maincent"
 <kory.maincent@bootlin.com>, "Svyatoslav Ryhel" <clamor95@gmail.com>,
 "Christian Marangi" <ansuelsmth@gmail.com>, "Dinesh Maniyam"
 <dinesh.maniyam@altera.com>, "Heiko Schocher" <hs@nabladev.com>
Subject: Re: [PATCH v2 4/6] test: dm: Add compatible multimatch test
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Simon Glass" <sjg@chromium.org>, "Markus Schneider-Pargmann (TI.com)"
 <msp@baylibre.com>
X-Mailer: aerc 0.21.0
References: <20260108-topic-musb-probing-v2026-01-v2-0-2a47c6e0e73a@baylibre.com>
 <20260108-topic-musb-probing-v2026-01-v2-4-2a47c6e0e73a@baylibre.com>
 <CAFLszTjav_oJwQom-J7m_hoJ4HU-U0DDodpSF08R+Fwfi9Bchg@mail.gmail.com>
In-Reply-To: <CAFLszTjav_oJwQom-J7m_hoJ4HU-U0DDodpSF08R+Fwfi9Bchg@mail.gmail.com>
X-Mailman-Approved-At: Mon, 12 Jan 2026 14:09:41 +0100
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

--7b9d336b1a6363b1b4dec1c42678508d957a6fe3cfa9bfe0bc92baa5d945
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Jan 9, 2026 at 12:32 PM CET, Simon Glass wrote:
> Hi Markus,
>
> On Thu, 8 Jan 2026 at 04:17, Markus Schneider-Pargmann (TI.com)
> <msp@baylibre.com> wrote:
>>
>> Add a test for binding of multiple drivers with the same compatible. If
>> one of the drivers returns -ENODEV the other one needs to be bound.
>>
>> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
>> ---
>>  arch/sandbox/dts/test.dts |  4 ++++
>>  test/dm/core.c            | 15 +++++++++++++++
>>  test/dm/test-driver.c     | 25 +++++++++++++++++++++++++
>>  3 files changed, 44 insertions(+)
>>
>
> Reviewed-by: Simon Glass <simon.glass@canonical.com>
>
> nit below

Done, and thanks for your reviews!

Best
Markus

>
>> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
>> index a2c739a2044c728a96b5f4acbf439a42d7e12fb5..9cc854ffe80e994e34010e29=
9029a7f1756697e0 100644
>> --- a/arch/sandbox/dts/test.dts
>> +++ b/arch/sandbox/dts/test.dts
>> @@ -457,6 +457,10 @@
>>                 mux-control-names =3D "mux0";
>>         };
>>
>> +       multimatch-test {
>> +               compatible =3D "sandbox,multimatch-test";
>> +       };
>> +
>>         phy_provider0: gen_phy@0 {
>>                 compatible =3D "sandbox,phy";
>>                 #phy-cells =3D <1>;
>> diff --git a/test/dm/core.c b/test/dm/core.c
>> index 53693f4f7ed7c7265218e4154ebf81a044a3a431..78ee14af228ab20a6639bb07=
6260296adaea2c92 100644
>> --- a/test/dm/core.c
>> +++ b/test/dm/core.c
>> @@ -1410,3 +1410,18 @@ static int dm_test_try_first_device(struct unit_t=
est_state *uts)
>>         return 0;
>>  }
>>  DM_TEST(dm_test_try_first_device, 0);
>> +
>> +/* Test that all drivers are iterated when bind returns -ENODEV */
>> +static int dm_test_multimatch(struct unit_test_state *uts)
>> +{
>> +       struct udevice *dev;
>> +
>> +       ut_assertok(uclass_find_device_by_name(UCLASS_TEST, "multimatch-=
test",
>> +                                              &dev));
>> +       ut_assertnonnull(dev);
>> +       ut_asserteq_str("test_multimatch_second", dev->driver->name);
>> +       ut_asserteq(2, dm_testdrv_op_count[DM_TEST_OP_BIND]);
>> +
>> +       return 0;
>> +}
>> +DM_TEST(dm_test_multimatch, UTF_SCAN_FDT);
>> diff --git a/test/dm/test-driver.c b/test/dm/test-driver.c
>> index 759de3a5f77f4b64ea577a293586a737e4623f60..bf953d7814df6a0e6efd6c2a=
3960a925a3fbe5a7 100644
>> --- a/test/dm/test-driver.c
>> +++ b/test/dm/test-driver.c
>> @@ -197,3 +197,28 @@ U_BOOT_DRIVER(test_act_dma_vital_clk_drv) =3D {
>>         .unbind =3D test_manual_unbind,
>>         .flags  =3D DM_FLAG_VITAL | DM_FLAG_ACTIVE_DMA,
>>  };
>> +
>> +static int test_multimatch_first_bind(struct udevice *dev)
>> +{
>> +       dm_testdrv_op_count[DM_TEST_OP_BIND]++;
>
> <blank line here>
>
>> +       return -ENODEV;
>> +}
>> +
>> +static const struct udevice_id test_multimatch_ids[] =3D {
>> +       { .compatible =3D "sandbox,multimatch-test" },
>> +       { }
>> +};
>> +
>> +U_BOOT_DRIVER(test_multimatch_first) =3D {
>> +       .name   =3D "test_multimatch_first",
>> +       .id     =3D UCLASS_TEST,
>> +       .of_match =3D test_multimatch_ids,
>> +       .bind   =3D test_multimatch_first_bind,
>> +};
>> +
>> +U_BOOT_DRIVER(test_multimatch_second) =3D {
>> +       .name   =3D "test_multimatch_second",
>> +       .id     =3D UCLASS_TEST,
>> +       .of_match =3D test_multimatch_ids,
>> +       .bind   =3D test_manual_bind,
>> +};
>>
>> --
>> 2.51.0
>>
>
> Regards,
> Simon


--7b9d336b1a6363b1b4dec1c42678508d957a6fe3cfa9bfe0bc92baa5d945
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaWTDWxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlPk
4AEA2t8LMu0R7DACk4VkpKEl7PBJ0rUJ++J8ZddhRd4CZowBAIcUocD8Cx90jX56
ohDbYfK10eMqBO91lC+1SXij6KcG
=e/Q1
-----END PGP SIGNATURE-----

--7b9d336b1a6363b1b4dec1c42678508d957a6fe3cfa9bfe0bc92baa5d945--
