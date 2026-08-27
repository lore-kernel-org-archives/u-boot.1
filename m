Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 370EBC61DC6
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 14:43:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E2A064075C;
	Thu, 27 Aug 2026 14:43:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vCkGWU4mr_Qs; Thu, 27 Aug 2026 14:43:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787841801;
	bh=2oIrNGabwPUejuPXnRlo7ZUCDQqfi3WKGjP20qxclEo=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AtkWTGT9RvpSpTtWv5vYUW0U1I1OHROBJC9lJkiPz6ML6vtbH9/ZGaf7fzJepwJ+U
	 loD/sZ4laZneuWdqjhwsZDGkCHz3zS++GMRSvRRHAj1wX3gyWrM626nFjTJbDGmbOj
	 h4bT+2z0um0b9qKHnFUbFpELPOwsxqKbdG5zzoXRaD/TIGptYE/yB4ota4AyjHOylP
	 utG7/qIiaQ+gWxVdw6Ne6Rfmf+RbC+C6zuUnQ5MeNkVl4pNlTl1BBjLe2xPaE/C0YB
	 lpDGMpe6A3WqzE+il/ES7jnTBgvzAhNzqa+8zJGlMQzcsWhvOKzPfHW7pvyz25NIpM
	 cshR0ZDw3Fe/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 175CA40755;
	Thu, 27 Aug 2026 14:43:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A2D4139E
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 14:43:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9546A40317
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 14:43:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RfdDIZaF_N5I for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 14:43:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=QY6HB5BU
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0D4A740304
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 14:43:17 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-49554ebb87dso21354385e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787841795; x=1788446595;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-type:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2oIrNGabwPUejuPXnRlo7ZUCDQqfi3WKGjP20qxclEo=;
 b=QY6HB5BUUhcsOFD+V+co5LdQTa2V2g8viXcxd8jYAPrz5YjD6wutOVf2cqzQkVhkjc
 sBu2OolANg9hlTXxvo9vAFGrTZTVu7FRO8WaLu+o5RoOfb/YJAKEgGoZzyRBl5xBcXJ8
 3N3yUZXJALkWuCHxDLDfjPD5OcLoXyjMt2I1n0EFGhJc3E2bhINMSQZ3XjCUGACdXMPB
 aLRkrjscWAeuuTltIkl3ggTNnQVAIzn3I3aunNs0gwzdabvC1OK4yc5UG9g4pSJxBAbT
 XnOjPrCsuRNW5kGLMLTdGnuViGVZ5mF7vKYMKiJDavmTahf3BGD3Y8Usy42vP96OGv21
 JVCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787841795; x=1788446595;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2oIrNGabwPUejuPXnRlo7ZUCDQqfi3WKGjP20qxclEo=;
 b=A9d9YnHLa6xs6FiVlj7iT4fLlpDwkIeHC8ZRmt/dzs8j7Hkp1yEttHNyZ8TNf3y28o
 N6DbNMKRR0OIR/7j59AZeL1gF6zdDYicjFyNcdpiTNU0dybPLRER76HBw6gItjyO5wSG
 dvVvRQ8c4ZKWMvUAhM1NdvUCEFyG5IABxlyMWDYb5tWaSp7JXeAZKbNEhWjo6y9o0Oks
 Zar3bXQHK0uJL/L6I6bDWbPdxmcUyj9h1VulwBw/1uwxIYE53IO32xNdzRxCPmM9EbBG
 4Cyh+FBlXiqcd/jN6qEonMeKYYHkL6vbEK5vDlJhRI4Qsh5qBBiiCaQDq7HN00whB8k4
 /EUQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqaYipxCbFJS2Br6UEfUBNSOhMy24/8GWcoI+OJn2MG21XRKLvBz5NvSqUDG2G6n3XKRZxJkmc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nilzS4CrTNk64TiyFEE5B5g63mIjzeUAIMTqQEUmZiwS9iRhiJ
 9OPIc32rWLPuNODTZ3C/uCEVwMB0Iozl0VNGRmZ27lFupzw1LoN7dM3c1bZxQI1sJgI=
X-Gm-Gg: AR+sD1198nnAG2KLYygxqjSbPczn68oxgx/SDtUyihcfnHt/hq17iUjdeSh+k//63d8
 +gvbxonHGyUU2iRkFhf4FOtqjTQ/hB1lr+T9I2IPmgmTEkQuidgH1eBGAX+TCLu03BefbRnKVdA
 UmD4r75DXDQJFn4u4tbddPO2LMwlRyuqa2OsYZQtYnoMrqhQEs1TsVNkDgoSsuWg51Fz1cou9ZJ
 YyitqqrR+ljNZSZoc5VvbI8oXuZXceZZyWP8UBKs47F2cUAfUHToDQKVIxsB9Vq5zpaJPar9spR
 mioF1i6wCOTP7WLHOwrUgVK257L8KhSAW/GsH2YKjCiu12d9niLHtTwD0Lii9x3OM8U4Edc5Jwx
 TWvJJBFgVTjwl3ci5DHjYK2gksMZ76kYdAhenbHRc53T6i24vB164Upog5lire9NpApcXGDJh3n
 3GOuhfJgbOW7ZgkRBoHZ9nrP9AGTl0eDX5DAzdaJ6ROMBYh9LVfBd/88zJ
X-Received: by 2002:a05:600c:8a09:20b0:49b:12c2:104f with SMTP id
 5b1f17b1804b1-49b12c21164mr84496075e9.1.1787841795186; 
 Thu, 27 Aug 2026 07:43:15 -0700 (PDT)
Received: from localhost ([2001:4090:a244:80d4:489b:7642:1b32:84d6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b4942298fsm59654565e9.1.2026.08.27.07.43.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 07:43:14 -0700 (PDT)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=e37bc370b29b2a3d5559411a9bc5b04170c252a07a6f0b6b5720295084c9;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 27 Aug 2026 16:43:06 +0200
Message-Id: <DKZT0Q2WT6PI.3FVNAODF3C3MM@baylibre.com>
To: "Heinrich Schuchardt" <xypron.glpk@gmx.de>, "Markus Schneider-Pargmann
 (TI)" <msp@baylibre.com>
Cc: "Lukasz Majewski" <lukma@denx.de>, "Tom Rini" <trini@konsulko.com>,
 <u-boot@lists.u-boot-project.org>
Subject: Re: [PATCH] clk: clk-uclass: Ignore -ENOSYS in clk_set_default_rates()
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
X-Mailer: aerc 0.21.0-146-gb5c16ebe1835
References: <20260827-v2026-10-next-topic-am45-ofupstream-clk-default-rates-enosys-v1-1-ce3b87667c09@baylibre.com>
 <e3cdb9ae-9505-4d77-abdb-b08b1dce452a@gmx.de>
In-Reply-To: <e3cdb9ae-9505-4d77-abdb-b08b1dce452a@gmx.de>
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

--e37bc370b29b2a3d5559411a9bc5b04170c252a07a6f0b6b5720295084c9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Heinrich,

On Thu Aug 27, 2026 at 2:49 PM CEST, Heinrich Schuchardt wrote:
> On 8/27/26 14:36, Markus Schneider-Pargmann (TI) wrote:
>> clk_set_default_parents() already ignores -ENOSYS from clk_set_parent().
>> Do the same for clk_set_default_rates() and rely on the earlier setup
>> clock rates.
>>=20
>> On am437x the cpsw switch has assigned-clock-rates for the RGMII clock.
>> The divider delegates to a multiplier of the DPLL that has no set_rate
>> and no delegation, so it returns -ENOSYS.
>>=20
>> Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
>> ---
>>   drivers/clk/clk-uclass.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>=20
>> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
>> index c33f415917e9..0069ce9a8875 100644
>> --- a/drivers/clk/clk-uclass.c
>> +++ b/drivers/clk/clk-uclass.c
>> @@ -359,6 +359,15 @@ static int clk_set_default_rates(struct udevice *de=
v,
>>  =20
>>   		ret =3D clk_set_rate(c, rates[index]);
>>  =20
>> +		/*
>> +		 * Not all drivers/clocks support setting the rate (as of now).
>> +		 * Ignore that and keep the rate set by an earlier boot stage.
>> +		 */
>> +		if (ret =3D=3D -ENOSYS) {
>
> In include struct clk_ops is incompletely documented.
>
> It is undefined which error code might indicate what.
> This might be handled differently in different drivers.

Thanks for your feedback! This patch is more about handling what
clk_set_rate() returns than what the clk drivers return in set_rate().
clk_set_rate() itself has a check if CLK_SET_RATE_PARENT is unset and
returns -ENOSYS otherwise if it couldn't find a suitable set_rate:

	/* Try to find parents which can set rate */
	while (!ops->set_rate) {
		...
		if (!(clkp->flags & CLK_SET_RATE_PARENT))
			return -ENOSYS;
		...
	}

>
> E.g. zynq_clk_set_rate() returns ENXIO if there is no set rate=20
> functionality.
>
> Please, complete the description of struct clk_ops, check what all clock=
=20
> drivers do, and harmonize the return codes before adding this change.
>
> The struct clk_ops documentation should explicitly mention how error=20
> codes are handled by the uclass.

set_rate is also already documented in clk-uclass.h:

  /**
   * set_rate() - Set current clock rate.
   * @clk:	The clock to manipulate.
   * @rate:	New clock rate in Hz.
   ...
   * Return:
   * * The new rate on success
   * * -%ENOSYS if this function is not implemented for @clk
   * * -%ENOENT if @clk->id is invalid. Prefer using an assert instead, and=
 doing
   *   this check in request().
   * * -%EINVAL if @rate is not valid for @clk.
   * * Another negative error value (such as %EIO or %ECOMM) if the rate co=
uld
   *   not be set due to a bus error.
   */
  ulong set_rate(struct clk *clk, ulong rate);

Best
Markus

--e37bc370b29b2a3d5559411a9bc5b04170c252a07a6f0b6b5720295084c9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCapBM+hsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlO3
aAEA8CqSR/83mApJc+fmwwLBnDGl2RG1xbS1qqqhGdgGgRcBANOjvxR6yXbifONC
FnHkX0e0x4QsARofM+RVLt9ObLcK
=lUZ+
-----END PGP SIGNATURE-----

--e37bc370b29b2a3d5559411a9bc5b04170c252a07a6f0b6b5720295084c9--
