Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5034606A31E
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 14:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TVsn3sjr;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=KmkH2jh3
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F2ECD40A95;
	Sat, 31 Oct 2026 14:33:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZC0CrBdxM40q; Sat, 31 Oct 2026 14:33:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2823D40A91
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793457205;
	b=kYo2EAOAqWLR/3tK67wRf8ak+bJmg9l0WDinkN/SSsSW3dmTK3MwwmucSWpKi2/XQDVt
	 6he/cofsol38Zjkl9Mu2hcOxQiFi1j57r0ZGp0Yb76agsnOV8enouzav4dqGdmYAlocNU
	 Rt0CS4aaFsvANUMNeWWU0LOlmHQvKkjVUsYxpwQ9bt7GzmLWDFPidFOBCMfbqufxpdiYO
	 4/jyKlzjJW4CVeyQHZxltCBc0YB20TSgOssnDrSEGTRFBo04pKa78CKUP2GXd//LWfWFZ
	 fOFc+rMv89O2pidR5Zo5WWW7cpzzp1+qcw0CrVNUA8dEB6WsmclExStwMGQM/XTeZ1Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793457205;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OVPq9I2CBktoYEpa8m39AeiZZZMrI0xwANam329xdfQ=;
	b=Sorp3ukb99yJi55O8KG3mLbQGEO2KPMWodBQ+Kl71Pv3EkT/wATpHRIPLzVO2et/NxBP
	 gj6MDDutn6ut/s2KQo9kshoZB756H/IORE4Gy054gtl2HRrFRo8M8E44uC0X6thT4M+xG
	 0YAfOhl+GZtNSscDlaBDrQAUCwOiq07kLuqcJxD9IXAsaHKF5snyt92hue2KPIqflD399
	 SZmCjPNWNHUtp/Jv1/jwIMPN2xdpVxWuK49fXtOd+3dAAepQM+9VJftxUTsCCWCY4t5G0
	 cfhBEIgzJbBEtoiQdhQ5f8+ZjEkZlEzWgQA+ZUG15ztq+sPzJcF268NJ5f2LloyU+mg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793457205;
	bh=OVPq9I2CBktoYEpa8m39AeiZZZMrI0xwANam329xdfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TVsn3sjr5oDzaiVYdnxaCuHqNXAVhoD4SplfOld12tyB6KWxqLMUGNM/cd3J5UpVe
	 bsQLese+rI8VTcwnycpXQRUb1frLso/tU3pK6zoMJv2bUg68ZLIUERoHNFClDZXXSC
	 bhrYFLK2dQ9ILVeZBPLR9ZhNPHW4pBjG53tlQdbENbpqS85dwFYUprFsGILgXvgnws
	 mLQ/A2b7Qw6VLxEvw/GH50aUtCwWD2dXycm1o3LVHEUGQ6XrX1gtfGjc2rQQ7BwHFf
	 sQISWke+OelbbWJDrNj9rw1+oLJ5G9h/tVCPflGqcSeCTRQmGX7DkmJ/xBJ3RCp9Td
	 h/VXxOud9d8tg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2823D40A91;
	Sat, 31 Oct 2026 14:33:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3C53F476
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:33:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 221E880FD8
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:33:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zx45epfTlkUD for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 14:33:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3EF0580E3F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793457203;
 b=FMR0hTULZsijTX3H++FWbSC6rKN3LZji9W3ySDm7sCyGy1hfUIgG9uSsK/1AaZ95Z7OL
 imqgZD1cOBJ7eZRfWoAl3O13cG9Vjoi3rPMnjusWSZ+2ImSEDDUE22yMRl0gJi5MLPgWs
 zsk9R8hUKSxbOM0HdC/z4EVAmBpIAcRv4VEiMY57sHGUEh72yWjkwcchLxC04+KLh7IcL
 bmY+F/m/0RuUKXJS6x5LtMZP2zt8ApoIor75huMAmdZsuOtU3/weYKqkuqIuOiI4fNJTg
 u5EBDhywOgo1sD5PnLRw6mkZv+yuFxjwNXPGRy484P8jcc1RuDkw26FrFyjHhzEkyzQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793457203;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=OVPq9I2CBktoYEpa8m39AeiZZZMrI0xwANam329xdfQ=;
 b=elmaG0PNmcI/8wRbLui9BHLVueplrYAzpH1EB8rngPs6qxdoGzM4uGyU7wcCvEj4xdKr
 u5b1ej60OX6PV3ZKMGrBClN4C0EmdYrwTGziUr4pVI8by8NSdrj63h1M6jT0kL42WAdQ0
 hWjo6cAZ7ISzP7Cw6RRiCJLVDXVmUeWFSvIms7NemVAFV5NcKkxH5W4WHh1+aHLpPGslD
 brWcRXFSmzOjqERBDFHnWMIbhonyn+msCwAHWL1JuMPuU8QRaTugwLaDphBThu03DbiXr
 Un2ZDVLwy8bGIw5ssRkZ9TZdLewpIx1aDBudlrKXNs1LtKL7fu2NhjGdkk/BrjiVx3g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=KmkH2jh3; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32b; helo=mail-ot1-x32b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=KmkH2jh3
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3EF0580E3F
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:33:22 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-845f3fa7f38so706129a34.3
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 07:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793457201; x=1794062001;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OVPq9I2CBktoYEpa8m39AeiZZZMrI0xwANam329xdfQ=;
 b=KmkH2jh3pMP592rIISaP0AaFIyJWuLEL7gO2vRPBbE0CsnnVYTIWPAbDCHFVuF81FN
 PDdxNTWgiYYEgMTibBXoN2S1h5FYWB1Q4d37H2JwwLQew7H5kW4+tvsTvkySVKS0QQzT
 ADgqfB9vV0P6o321fRrxziapMx0aO4xU7P25A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793457201; x=1794062001;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OVPq9I2CBktoYEpa8m39AeiZZZMrI0xwANam329xdfQ=;
 b=iy+Dku6K2Qw8sfj5jTJbCjsGAD9/HB3bU0wFjB88JebKEAgJnp1EkFwNJgLhl4f68q
 XHOmVxQUC6vy9t54U+rN4kHXZtjb4XKFH6K6H16LKzD+L4+OWIVDyf3QPfalDuzaUpXB
 nQzfVZSw8LGPH4a9Y7T02TPQ1cX+ty5x76L0dIMTw5RxrZrtNY1iCEX4kDvOmAHd39LA
 3IO5VxY6w6LyHeJ6QVHdHPW58DmsPEBVmvNeg0Uh3xvOd6hVpR+TdR+yCh8aAwnGeV+Z
 SLEVeX3YBvjsnnX7RW9OkEz7q9Ck2y5Nz72k44AFDd/5sTJ1JCTb0hD4liHlvDbEJEBH
 GE8Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByxx6c0SIhjijSnbNSZF2jpufGc06Bmu3PgB1CYkWKhKXOjuQZfAX8gg9UB7JZbxZvBmKGtSvY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLfxfpm1Eq86QmVDKIXQOXwgTxgMHurAajaqY9PsW7buPRgHV0d
 GNmnvWbZHWvpfY/Mjs/1xtp+4wyVdojDdObkYyRNo0VfTawuRn8+9wvu0CJuhIRW4Ws=
X-Gm-Gg: AYBFou0rPaJ5Y3q2EUMX3xy0M/KOhxzdsAyooWi3Z59O7RpM4ZihWqE0Hd3e4J7XXbV
 TiH9qY5Nf716DidPkhlndLZW1oDkQSsF7b0XgAL6f1lKDd18D8HZT7xptHL/P2GknM/xk8uBjop
 tEIVBzBv3VKeJWVsNQI0049DW7giy/OduHKnIiJYT1yvSMNh3mnLuxPO/ztmLhJrRMuTfcQzhy+
 5pHd3V6I0Q34qxGcAUuCRKgMLxMARLIMoslLngZ2AEpi/ox0BQGPWrxPpZI6Q9VB0bK5Skm3UcT
 +3XrzSuDBlvjjW8zTZM2+x4RcKZ3bZQYnoZSHePJiXc7d0bbtK64bynhmCcsYN7UTD/XmWFOE0D
 WHCTKv78MQzCt1slyv64yZlM7+3wtW0PQosqz2J3qBu+9EiW7worWm+YRbZh7DD9sBS61rJMf1N
 Y149ZEq0RFZjItd40s8w434NXlwDtWb8lmAdDcWHTCmuHyZajbr9a9LfrSvmbR4VKX16jKMvez5
 xPKcK4vu2/Isia99MItsvT2YraBElbBYVjShZXNffT5P79qFa0GjYCWnAAwRItmI9SFm6QEsbjA
 QI3H+r+nkckHzcLF2e1Di0TMHQ0zFhYg2b8j3YX8Wr7khvNZ2N1/7k0o0WNuZyu3A0vqcfmRMfX
 ehRVoCFtX/FvbwFeg+bHPaxheK8ub0ZHhjkE37p5/3LPs7WV8d8CljFVPx4NpMSViN2QAFPpNG2
 IlE5+xqTxe8/Kxi5AFeH9XswjPUt5xtCs=
X-Received: by 2002:a05:6830:82f5:b0:81c:292f:97a3 with SMTP id
 46e09a7af769-85d365207a8mr3403865a34.5.1793457201493; 
 Sat, 31 Oct 2026 07:33:21 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d3545b847sm4467018a34.7.2026.10.31.07.33.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 07:33:20 -0700 (PDT)
Date: Sat, 31 Oct 2026 08:33:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: frieder@fris.de, Martin Schwan <m.schwan@phytec.de>,
 u-boot@lists.u-boot-project.org, Aristo Chen <aristo.chen@canonical.com>,
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>,
 Johan Jonker <jbx6244@gmail.com>, Francesco Valla <francesco@valla.it>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: Re: [PATCH 03/10] bootstd: rauc: Fix overflow of the BOOT_x_LEFT
 name buffer
Message-ID: <20261031143318.GP3309461@bill-the-cat>
References: <20261029-main-v1-0-b5a878627107@kontron.de>
 <20261029-main-v1-3-b5a878627107@kontron.de>
 <CAFLszTgDO26qJUY+3cw1J+mPaofueYyEGUe=BVWmDH30RgA5ow@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="o0Bn19F0nZ2IJoo2"
Content-Disposition: inline
In-Reply-To: <CAFLszTgDO26qJUY+3cw1J+mPaofueYyEGUe=BVWmDH30RgA5ow@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--o0Bn19F0nZ2IJoo2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 07:05:55AM -0700, Simon Glass wrote:
> Hi Frieder,
>=20
> On 2026-10-29T16:23:07+11:00, Frieder Schrempf <frieder@fris.de> wrote:
> > bootstd: rauc: Fix overflow of the BOOT_x_LEFT name buffer
> >
> > The name of the BOOT_x_LEFT variable of a slot is written into a stack
> > buffer of BOOT_LEFT_LEN bytes with sprintf(). BOOT_LEFT_LEN leaves room
> > for a slot name of 32 characters, but not for the terminating NUL, and
> > longer names are not limited at all.
> >
> > When booting, the slot names come from BOOT_ORDER in the environment,
> > which is only checked against the configured slots when the bootflow is
> > read. Setting BOOT_ORDER to a long name between 'bootflow scan' and
> > 'bootflow boot' therefore overflows the buffer in find_active_slot().
> >
> > Make room for the NUL, and write the name with snprintf() in a helper
> > that fails with -E2BIG if it does not fit.
> >
> > Fixes: 7e5c2c782fb9 ("bootstd: Add implementation for bootmeth rauc")
> > Assisted-by: LLM
> > Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> >
> >  boot/bootmeth_rauc.c | 34 +++++++++++++++++++++++++++-------
> >  1 file changed, 27 insertions(+), 7 deletions(-)
>=20
> > diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
> > @@ -167,7 +176,10 @@ static int distro_rauc_read_bootflow(struct udevic=
e *dev, struct bootflow *bflow
> > -		sprintf(boot_left, "BOOT_%s_LEFT", default_boot_order_list[i]);
> > +		if (boot_left_name(boot_left, default_boot_order_list[i])) {
> > +			str_free_list(default_boot_order_list);
> > +			return log_msg_ret("env", -E2BIG);
> > +		}
>=20
> This is a build-time configuration error: a slot name longer than 32
> characters in CONFIG_BOOTMETH_RAUC_BOOT_ORDER now quietly produces no
> bootflow, and the log_msg_ret() output only appears with
> CONFIG_LOG_ERROR_RETURN enabled. Please can you add a log_err() here,
> as you do for the missing partition names in patch 6, and mention the
> 32-character limit in the BOOTMETH_RAUC_BOOT_ORDER help? Also, the
> other callers pass on the helper's return value, so it would be worth
> returning 'ret' rather than repeating -E2BIG here.
>=20
> Reviewed-by: Simon Glass <sjg@chromium.org>

I've asked you before to not give both substantive changes and a
reviewed-by tag.

--=20
Tom

--o0Bn19F0nZ2IJoo2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauX8KgAKCRAr4qD1Cr/k
CuLUAQCz0nio/vebzZuH0mjjHXG9K7GsS7WfolS0JTQw5BSJyAEAwsNCqCcaLyIJ
j/1jU+bdyHLfANNTHAkqADVEVKPtzgw=
=fFnH
-----END PGP SIGNATURE-----

--o0Bn19F0nZ2IJoo2--
