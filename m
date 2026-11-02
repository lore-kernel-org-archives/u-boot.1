Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48620606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 09:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GlziFvEw;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=WzjYHSl1
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1506960758;
	Mon,  2 Nov 2026 09:13:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PBLOJTju0QH7; Mon,  2 Nov 2026 09:13:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C83996075A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793610837;
	b=K8926pqsqhtQ1TzedDVPwZ+v7ee7LLjAor8Bo//2hqtwr0vF6vrMA8cO5STcavnpMUcM
	 3sKApmCrCKrZOdF30Mt7gK7QnUVCAucyvRB6G1nhJZPvcSOvYKw9UVdkcasfPOT1oYh7W
	 oJSWg/7RvsfFDzxT7g18tYDGUZNBn3lGlYXwJsb4hHg95q2ZvTLP73qWybZR0c83oNbLf
	 UboffQqy/dXmN9Wdu4zoSFDiUsc8IsnxeqRZWue6wKx53kFvYt+Srsln6s8CYPI6145uO
	 9udNBuYmpDycrtGIYvLzNyyi5+H42TmcOA4UmtTsRW33T3pfPZPDTUhmmW4VtCuRdng==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793610837;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Autocrypt:Content-Type:User-Agent:MIME-Version:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=kQVRgi6CptfOUX+wdHEvDWrU/S5tyMnmurju1Hn7Er8=;
	b=ZupmMTTTH2GILui5NFjKDjjXrtVsMrFH31c3b+JJ4EVddcHliBXi74YkQ/UjIokLxS5X
	 5tm2aMaTGWLZSnNGY2B2ibXrpMEQ8oYUgatuQYrKWrvKH6LErhgWDX2GoTZh16NtZ0897
	 tvk+MAwFDb+Bu7vHJIHbSyd/kqdEZYlS/DIVEpsAHgwy/NEeJDsbJaLB7RCNuOD8uFBup
	 N0jT5ul5fi3qf1aqdHrFjL5bU+qOIwhQI4NhBv7MtY6giIYegy62SDeBrD/vuQgPnq95b
	 SmoRb2R25zWcSvo1y1s483sVpuS/Kl3hkMCcPdZy0eYOrrfoxhtFdQpjUcdqvI84X/A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793610836;
	bh=kQVRgi6CptfOUX+wdHEvDWrU/S5tyMnmurju1Hn7Er8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GlziFvEwNIBBWI6H2CI0zL6NKhU49tQ4h5ahwo4EjZLgb3vkfOdvmM32uKrscWPr+
	 1YJ005w2X0HWVMVm0JjZ87A4sq5DRan6c1Jj8VMohNNjYUMRf4Bf14TnEBjfD7sWZm
	 Ut56j977pzoJu4AXcQtjWmTmvRiI/eTDZV7jocyfEebkgdTzCya4I/tzDnLMps6MhX
	 74IVpjqSahvEhUSFokS4JnIDg0/YugXsP0OzP22JQhmcnsRbjeC3n5uAQhWYt/oPZr
	 sRwHVUdJ5SHoMLwiONgiDcBoEmeng47ejlS5E7EbDWEDpJ+GrrxLXuQ7wpRu20vr0r
	 vmJPYsmsVdX3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C83996075A;
	Mon,  2 Nov 2026 09:13:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E6ED323
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:13:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0FCEE80C1E
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:13:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vpEOWKW-kA9z for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 09:13:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 75C8080A65
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793610833;
 b=M6CA2+Glp2jS7UWcprxvqgHRXT4IhGKgJuj7ToPPntI9sNt1dOHqBWf72sQA2i9mTC9O
 maQ1UZrXPWscm6+zkCMGUVc1wUirEYm6Qp/xY7wcdhGEBQObt9Ddb8KHW8B/zqwd/F6B5
 wPGO9zU0l2dYQSQse02MF24vczZ6Y9qobTdaL1l1cT9HwXd3gE2O77Cg+8CFGXxZjM3km
 g3HSfrc1s0zJFGO0/IeC4t5YVXaU5eln8aVIGEmP3oVc5r86VadkKxVl4lPTCe2oRqtV1
 plwWZud6HsRqAhZb9fB8yHOF8ypnlnenOreQjt9XYe0k87vsCJuE21UDqSB+khR/Jog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793610833;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:Message-ID:
 Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:Content-Type:
 User-Agent:MIME-Version:X-Last-TLS-Session-Version;
 bh=kQVRgi6CptfOUX+wdHEvDWrU/S5tyMnmurju1Hn7Er8=;
 b=bvec7eyKo7F8/Fmtxk9ZV17G3YpbkCU6hM1X8gURGvXT0lVorHBVNazvZ4VyO/MCfW4e
 VpYTx64ybVFlTWpU3BkimCQfspIsLBpp6hXu/B808K70052QfdzP3opjlus+JC/aa0AqO
 LGVD1f+CGiLcYMEj3X0y5yINTsYJXdC1yt3I4ky8C9n5wjVeIaI4RRRl9BETXyA1L0Lp7
 sfSIiN9rvRAthUI39YIFdjl85uXPhIQaZkvOESJNvniOLHVzXjHgcVFIfXB0PGNcvV5ho
 8ke0d3d9gM3o1AjYCvWU6tNAeSrUcicO3giTsCeYBmttIn5DKl9bpFDU7djuRS8PfxQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=bootlin.com;
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=WzjYHSl1; 
 arc=none smtp.remote-ip=185.171.202.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=thomas.perrot@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=WzjYHSl1
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 75C8080A65
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:13:52 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id BACE2C8F446
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:14:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B26F460750;
 Mon,  2 Nov 2026 09:13:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5B3711032912A; Mon,  2 Nov 2026 10:13:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793610829; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references:autocrypt;
 bh=kQVRgi6CptfOUX+wdHEvDWrU/S5tyMnmurju1Hn7Er8=;
 b=WzjYHSl1KxR1vfBHshyDRMrIgDr87eAJaD8s8ODykyTDCynOiR0DRYoXj1NCzFs6PTr+hI
 BeznIYs76hRordLOLoSLUFV1rPgpYvl1MZBDcshOAiPI3d9q7fxfJeY1dRjSwgV9E0kmuX
 6Nj86U+TchQPS0sfauXpa4YRWnZ+m/aJ+yUnDTuwqKgz3geUumnk00B23hZRdC6Eog96u+
 gsbku96Dp+s4lFQR/TueNxYwIL6ChcWMIK/Cd0aJvKprJ1g9qz31wru9irH3Ud5UBIaB9m
 3N5J5ym14K6CqU9UMEUAIE9mlxXOYaChMJANgy/IV+9doFRPiPQTz4xcUK7lMQ==
Message-ID: <51613549c1510b0d301524ff342cc88da10e9233.camel@bootlin.com>
Subject: Re: [PATCH] pwm: stm32: Fix division by zero for 32-bit timers
From: Thomas Perrot <thomas.perrot@bootlin.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, uboot-stm32@st-md-mailman.stormreply.com, 
 u-boot@lists.u-boot-project.org
Cc: thomas.perrot@bootlin.com, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>, Cheick
 Traore	 <cheick.traore@foss.st.com>
Date: Mon, 02 Nov 2026 10:13:45 +0100
In-Reply-To: <083a1ab1-54c5-4a0e-b40a-6a5d12392d3e@foss.st.com>
References: <20261030-tprrt-pwm-stm32-32bit-timer-div-v1-1-f6f93d7923e4@bootlin.com>
 <083a1ab1-54c5-4a0e-b40a-6a5d12392d3e@foss.st.com>
Autocrypt: addr=thomas.perrot@bootlin.com; prefer-encrypt=mutual;
 keydata=mQGNBF+/ZOUBDAC2DghCjZvmgYcve02OG7dGZ7Iy58uEwne3LB7w7nRwdAxKw7ZaiVqwY
 O+yNGVi+GVx7oA6Wn4pv46z+QDRLQiq6OseuXhkSGCg7U/yBCUq12B/GRGO1Qt2Qi1mJJT1s+1qZ5
 Gxv6Nypz9qKVn94GM2bR1hXBga0t87vBpebThOHmX5d/0dqIcVxRCM7onNb0dDyRoVgLS5rBhQzrL
 CMrJaCy39xZUy0J1SOlH4Mgk6EhJIPYY4wlzikGX6urg+Tc9EjGd78ry0e0p5U5qgjFR5QGJDy1Gn
 U3CfwbT9sowdCASDbQDUoltlv2iWJCLa0xl97KVchCa0pr7HKbFA3J5SLKqFYUBCkFL+5WudYlz2n
 XxiUgyviMQxyK+ij66kEi6/2zFDAecd43pHV7790ptqZBC3Jc67Emj7Vo3ShX6RXPPxxbeCTOF2uk
 I45aJ9XcVFH/MFE96NjXj8uahnIsiTPyuCUoJu8tj7TSQyue874qJqVQvqlFyt2aZYJZ8ruq8AEQE
 AAbQpVGhvbWFzIFBlcnJvdCA8dGhvbWFzLnBlcnJvdEBib290bGluLmNvbT6JAc4EEwEIADgCGwMF
 CwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQSHQHfGpqMKIwOoEiGfwAsFcf4K7QUCX79mdwAKCRCfw
 AsFcf4K7fhbC/wP0kSl6id2E/K3+UdXk6CLMVRbCFLCREzQs5WFpQ6l/I0WGOamhrOgegdszheiVF
 orlUP8d37XSpFAqydhKGaN78V5Dps0Wmwm4lIlS4MtQXJtSLUHXDJLIZLW0pw8tiPLKsd1o/yDkXE
 dnpsjJTRG6SdDSHnyOB2/gh4p+yTaLytFdARk/r4/P26+L+FiH0fFl+RnBt19LPklfKgeDc7GwIif
 ja+nIWpp3W23DAUuI6xduEut25Q89yu7Ci8CliLfAiLy9bIGjBQWU2Y+1/j/7KuPj6VbBsZWLTZY0
 hUmpJSTnWAqc9SMsNxo7NSQuddgviz5e2tqucaRqxP02FGzNa8U4NAKdWaXrlHG5Dglj9XH0DK+SH
 +c96qqFewYD8VPQ6XAGxQcXbrtJmiMor1R2DfziispLRvJcfYs8xqabbCtoS3ouXB9XRi8hn7A2kh
 ME1ryS+Oh63JshXHnw6bmjCpVd/p+fGLIGU6A47pJOpviKR4jEO84pl2ejtDZ3Tc=
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-WBH61M0mJb6t/SuqPbBO"
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--=-WBH61M0mJb6t/SuqPbBO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fabrice,

On Fri, 2026-10-30 at 15:58 +0100, Fabrice Gasnier wrote:
> On 10/30/26 11:31, Thomas Perrot wrote:
> > stm32_pwm_set_config() derives the prescaler with
> > do_div(div, priv->max_arr + 1). max_arr is a u32, so on a 32-bit
> > timer
> > (max_arr =3D 0xFFFFFFFF, e.g. TIM5 on STM32MP15) the sum wraps to 0
> > and
> > do_div() divides by zero. Configuring a PWM on such a timer, for
> > instance for a backlight, resets the board.
>=20
> Hi Thomas,
>=20
> Ouch :-(
>=20
> Thanks for spotting !

Thanks for the review and the tags.

>=20
> >=20
> > do_div() takes a 32-bit divisor, so widening the operand is not
> > enough.
> > Use div64_u64() with a 64-bit divisor. The prescaler then comes out
> > as
> > 0, which is right since the period fits in ARR without prescaling.
> >=20
> > Fixes: be5523d38296 ("pwm: stm32: add driver to support pwm with
> > timer")
> > Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
> > ---
> > On a 32-bit timer such as TIM5 on STM32MP15, stm32_pwm_set_config()
> > divides by max_arr + 1, which wraps to 0 in a u32. Seen when a
> > backlight on TIM5 is configured from U-Boot.
> >=20
> > The fix is ported from a change carried in ST's U-Boot v2023.10-
> > stm32mp
> > tree.
>=20
> Do you mean this is applicable to ST's downstream too ?
> (I don't find such fix there)

I wrote this fix on top of ST's v2023.10-stm32mp tree and I believe it
applies there too.

>=20
> > ---
> > =C2=A0drivers/pwm/pwm-stm32.c | 3 ++-
> > =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> > index a691f75e4a71..3f2b593477b1 100644
> > --- a/drivers/pwm/pwm-stm32.c
> > +++ b/drivers/pwm/pwm-stm32.c
> > @@ -13,6 +13,7 @@
> > =C2=A0#include <asm/arch/timers.h>
> > =C2=A0#include <dm/device_compat.h>
> > =C2=A0#include <linux/bitfield.h>
> > +#include <linux/math64.h>
> > =C2=A0#include <linux/time.h>
> > =C2=A0
> > =C2=A0#define CCMR_CHANNEL_SHIFT	8
> > @@ -64,7 +65,7 @@ static int stm32_pwm_set_config(struct udevice
> > *dev, uint channel,
> > =C2=A0	do_div(div, NSEC_PER_SEC);
> > =C2=A0	prd =3D div;
> > =C2=A0
> > -	do_div(div, priv->max_arr + 1);
> > +	div =3D div64_u64(div, (u64)priv->max_arr + 1);
>=20
> I'm fine with the patch. Just suggesting here: div isn't recycled
> later.
> So could directly set:
> 	prescaler =3D div64_u64(prd, (u64)priv->max_arr + 1)
>=20
> > =C2=A0	prescaler =3D div;
>=20
> By doing this, the div variable may be dropped completely to end-up
> with simply:
> 	prd =3D (unsigned long long)priv->rate * period_ns;
> 	do_div(prd, NSEC_PER_SEC);
>=20
> 	prescaler =3D div64_u64(prd, (u64)priv->max_arr + 1);
>=20
> Up to you to update...

I=E2=80=99ll send a v2 to remove the div.

Kind regards,
Thomas

>=20
> Both case you can add my:
> Tested-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>=20
> Best Regards,
> Fabrice
>=20
> > =C2=A0	if (prescaler > MAX_TIM_PSC)
> > =C2=A0		return -EINVAL;
> >=20
> > ---
> > base-commit: 03e45557e1f38a39a0c80fe30483130ff376cf92
> > change-id: 20261029-tprrt-pwm-stm32-32bit-timer-div-eeb070ead061
> >=20
> > Best regards,

--=-WBH61M0mJb6t/SuqPbBO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCAAdFiEEh0B3xqajCiMDqBIhn8ALBXH+Cu0FAmroVEoACgkQn8ALBXH+
Cu0PBwv+LI08DITMNxujOIJ07iXkOqrffxRYKwx/RXvJ28VAvSbquRBqlGb3D8uj
ir4PWHZOdvv2hOe4g1wF/2Q6hwMv1OoPrwqB7zbvXkbl4cPEg3uptvG9fK1+PQmv
T79q0hvhsK0nZG58uNptjjnmkNDZ1zHytPUu5r44L3HFFnTPPUADN721UsTaF97p
eScVlFXxPzUXvZKbTTLL2c6gHtm/7B6cYCqzZK4WwNhfnbV++s6H3M/uVlBM8Z8/
d1sPN3iqUGh/YnpDcZa2XsHDxwmqOp7hsGt0Wzf6E4QYqF34UmgyhxsoTx8P2SSy
xkMW1HWo+jKl3igkqoz5yjJ2ncjF1UyzFJ1T16mdIag2ftAYzrp/+hA4KzyT4b0i
ij4Ra/14zRMA7oma3T/wHAeUaUU1G41JcX1+LjcJnfyPhC0wvDfJUi9j0EmEKWHL
iB1cfQNNsRGxLa0UJxDkCtRrEEROJiNWuKpGyZ1siC4bCrav+W6EKGnVHVuIB7dG
KYLj5Lr/
=0a9u
-----END PGP SIGNATURE-----

--=-WBH61M0mJb6t/SuqPbBO--
