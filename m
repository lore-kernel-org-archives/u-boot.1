Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA62606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SJVkkCQu;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=pF461hda
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 329CD40880;
	Fri,  6 Nov 2026 17:34:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cbMyiAL3DNIP; Fri,  6 Nov 2026 17:34:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 70634408FC
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793986486;
	b=sgosgxOhxLrBsdX2gzZhH3rd8/dmJkroqimGRTwEg3W7jO2vtpzoNjdobiLjyTYJDOF1
	 IFB9mUNpoMpa4KlmHJsFxcZo8pARJk7KL39Lqn1aqg3in3WJE7ZxDgDn6ucsigpiiK273
	 1KFmqCNs1QhXYgndwXwcHyTNGNPZ5GqFu+uSIXShbfIZtwzotMUzJCg1g+btC/EI73/1v
	 9cFfdbkqTAwn3IFhRswHCUjlDOdqRdqs722rYVydIgsi2o+x055Dq5yv4HkOoqHEo8n4N
	 6vn6N3+fWRQ0rKAMFZ2w5FqIZYbZ7Pd5Rcw2J1AwpPhuzDoZeWxkxUyou2Y7Q+hno1Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793986486;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=jgacsaE/TdslSnNDjeuwvwPUnirmBHCGCuCtSUlMPos=;
	b=HE+Qh5EeJ1BFor0TWuwX4HejmKfIAVxE/rLC/PTIvraA+GuUCVln/Oiyp4KiJgUA2zEM
	 r/jntTNPuiUieSHEPBoGRskKbbe4KvQmJ+SOkVplU1JjkYhFsPOzu+J1octeqrYgK8HOe
	 KR99L9D/F88/VXA682krpwvFVYOmeGXCVwJU8rZyMIdF5EkCgfoS3QT3TOTtax3CluEJp
	 MAGhQs5YjeczXXCbP5fr+s1o7mEzTD7wkWpSpGq6JrL9GkBuc3epeSR76lQJSVZAkNCji
	 y7Kb72S4aryKyaJ2E1Qnr7x7Sf3MNzx+vWvZVc2HtqoQFM9dmxgxAMGYzIVjpdt2hSg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793986486;
	bh=jgacsaE/TdslSnNDjeuwvwPUnirmBHCGCuCtSUlMPos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SJVkkCQuUYkjB2aSMzC95OVSISzXYjH/1LdXEVnFFxAP1UCq+YoAqa5hWzC8U5U1J
	 UmREKbRVJyX6ASXjdNwu7Fr5spJRyMqHZ648WL2BxDmFy0r630pvAt+lq8Zp8DjbYb
	 h61sWoUT6uG7etV2y8lG697HaJyYuMmPDVVRLkVhYRbNEl4G7oQ1gXTxSWjEnBsZpE
	 ILcgZOth+MaeGTWDcdLFmhbNLtx8niFMevxj4KFBUfX97cGq9FPdkbgP3Zgcu/cFGF
	 xQ+VhGZ6737XiEjT73VRKN2zWBLvMjZ1aJvUKVe5wxvLSfYWLne2DBWEZ9doQkacCY
	 jj2Dig+Fo8qRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 70634408FC;
	Fri,  6 Nov 2026 17:34:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 783EE362
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 17:34:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 69ABD403D5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 17:34:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mC2zNHZsOOah for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 17:34:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 90C00401EC
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::34"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::34; helo=mail-oa1-x34.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=pF461hda
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 90C00401EC
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 17:34:44 +0000 (UTC)
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-451a49abd8aso645710fac.3
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 09:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793986483; x=1794591283;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jgacsaE/TdslSnNDjeuwvwPUnirmBHCGCuCtSUlMPos=;
 b=pF461hdaKLHfKmzJy4givOOvRR413QUIdw1kOwG8OXzlBYV01/33iSdL+hFOTMEBIm
 J0ihwFUPl5aSbolrrZQX8eSonCXfKvgWE9qe0jqrlxaUAVh/p7mnQDADV7zvS0kliFBI
 XyBrlmG4r/BSJCzJBFkyt3AzLmBbcEOw64ZUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793986483; x=1794591283;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jgacsaE/TdslSnNDjeuwvwPUnirmBHCGCuCtSUlMPos=;
 b=UATLEi2PndAq0hAlQ6IYQRbo3DgkEIo8FMYeBqGTMLWbaTKF8hgQXX8AJMW4x+W7ng
 ROlz8yM7P6y6Etj2Jg2RE9WkSnd3fHsnratv1KeqP78iuHsVHqV4+2gOMsQ3lwMxCv+l
 iQrQyoveuoOoxVaAzHA4tnVsIQcrrxkNcPEZqJ7fUr23Ig/MNb0rTDxhUgBeYWIEO74p
 jLCMqyRHbHfN/bxzNcLjWqPu37zju1MwIWklesISgsLW6x1uLPNM6JHgb9YlvE7UoNKv
 9E1GIwAR0ozHEZLQUmI7t1nJTIuJonq5WBfJi6/6Sr937dqYGCZhr1TBplQVMvVf8Fu5
 eZyQ==
X-Gm-Message-State: APuU4Z9ScYQLMrkIivWjSTVWasxUHx2rpz6GzktFeGDJ9viJmSiBERCb
 PM52I1ceURdjINtrwCnq7ptuGeAJ9EBL9Ngz/1hfuroj4TYTMv9nWuasvhOEr26f/Bc=
X-Gm-Gg: AYBFou1DEe45EZTJy1FxBWsaiT9YQMnvy0zQWYkzkT6bOW0OINwxhR8l+y1LIh2sKgC
 HIZevQWcAjvHvkGojpB9lgGdi1VDkldTZpA9D1m3PICF9kZkzN9awiSefvQ8I0UsjpLS7JrWlnZ
 /3SuU40hzfzBovLNU9YRWTJpFPVJIb4xxUoCegDOL5LgAyQr82sy1lqA+A4U32l1SLKsrWJrbFQ
 /0XhZpOkVPGwsvO92XThifB8Ip3hbva0WNKc0MFawOLU/FgjnhpGbdOpFA+9/9iLvo9f2135Mba
 g5SgVuBP/fl9pz3cFtmN2bSbRsChR5rSjAETrdt3TwiazP0R6b58xj3lmdOj4V0Nyn1e9hOqYvZ
 fjUysiA709KZzjXQW2eO3jf3p8UisrecHAmfHySdahri1FcbyElBMyIOy73Iq0SYveZzXy0l5Kh
 cHRm8pYKGahKNIac/bWohhmCboPj7nuFiJy26I2EAQod1qZ7ZGFX3zYXHDvBE99+XdM+6JgppyF
 yLghKSmDeS0tIuodCQIh7KjuEPSGNKWCeQ6wjlgAPskvx92VwalupVWMTedvBdqeunmvqgjG7pL
 l/0IXmM9ICdt1cnKCxUHKjrDmx7L2y4lUnlIa5EU+IcgrYcaGsZEUmVnXbWvD7JanR8lrd/Y1ET
 VByn82r7R3hv0ONXcromdrI7VGrcw48vVt9kbaXsB69jC3QVYLOP719JBDlxwxGDFNyOSarUv9d
 P71j2UBXdBVg7Wjf8kUn6NsafmLSLOTg==
X-Received: by 2002:a05:6808:3a0d:b0:4f4:4eef:52cc with SMTP id
 5614622812f47-567e16701c8mr2224042b6e.43.1793986482953; 
 Fri, 06 Nov 2026 09:34:42 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-567e7e5f6e2sm1933893b6e.11.2026.11.06.09.34.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 09:34:42 -0800 (PST)
Date: Fri, 6 Nov 2026 11:34:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Urvashi Sharma <urvashi.sharma@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, E Shattow <e@freeshell.de>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Subject: Re: [PATCH v2] riscv: spl: Add BOOT_DEVICE_UFS
Message-ID: <20261106173439.GB3669968@bill-the-cat>
References: <20261009215008.2796804-1-urvashi.sharma@oss.qualcomm.com>
 <20261106172806.2642494-1-urvashi.sharma@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Aom92kSsMu7QFbcF"
Content-Disposition: inline
In-Reply-To: <20261106172806.2642494-1-urvashi.sharma@oss.qualcomm.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--Aom92kSsMu7QFbcF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 06, 2026 at 09:28:06AM -0800, Urvashi Sharma wrote:

> common/spl/spl_ufs.c uses BOOT_DEVICE_UFS, which RISC-V does not
> define, so enabling CONFIG_SPL_UFS_SUPPORT fails to build:
>=20
>    common/spl/spl_ufs.c:49:33: error: 'BOOT_DEVICE_UFS' undeclared here
>    (not in a function); did you mean 'BOOT_DEVICE_DFU'?
>=20
> Add it before BOOT_DEVICE_NONE, which must stay last as the list
> terminator, and note this in a comment.
>=20
> The BOOT_DEVICE_* values are SPL-internal and not passed to the next
> stage, so this is not an ABI change.
>=20
> Signed-off-by: Urvashi Sharma <urvashi.sharma@oss.qualcomm.com>
> Cc: Rick Chen <rick@andestech.com>
> Cc: Leo <ycliang@andestech.com>
> Cc: Tom Rini <trini@konsulko.com>
> ---
> Changes for v2:
> - Add a comment documenting that BOOT_DEVICE_NONE must stay last
> - Update the commit message
>=20
> Tested: qemu-riscv64_spl_defconfig with SPL_UFS_SUPPORT=3Dy builds
>=20
>  arch/riscv/include/asm/spl.h | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/riscv/include/asm/spl.h b/arch/riscv/include/asm/spl.h
> index 9c0bf9755c9..b3a7ee47bf7 100644
> --- a/arch/riscv/include/asm/spl.h
> +++ b/arch/riscv/include/asm/spl.h
> @@ -8,6 +8,10 @@
>  #ifndef _ASM_RISCV_SPL_H_
>  #define _ASM_RISCV_SPL_H_
> =20
> +/*
> + * SPL boot device IDs.
> + * Add new entries before BOOT_DEVICE_NONE, which must stay last
> + */
>  enum {
>  	BOOT_DEVICE_RAM,
>  	BOOT_DEVICE_MMC1,
> @@ -27,6 +31,7 @@ enum {
>  	BOOT_DEVICE_XIP,
>  	BOOT_DEVICE_BOOTROM,
>  	BOOT_DEVICE_SMH,
> +	BOOT_DEVICE_UFS,
>  	BOOT_DEVICE_NONE
>  };

Is it too late to ask you to pick up and make include/asm-generic/spl.h
instead, and use that for at least RISC-V ? The history here is that we
have a few cases, such as arch/arm/include/asm/arch-omap3/spl.h where
the values matter as the values match up with some ROM. We also have
lots of cases, and it sounds like RISC-V is entirely one, where U-Boot
itself figures out it booted from $dev and so return BOOT_DEVICE_$dev.

--=20
Tom

--Aom92kSsMu7QFbcF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCau4PrAAKCRAr4qD1Cr/k
CmuwAQDEl86mAyC6f0Oyrrp8kqtQsZAsmC8q87ORXPyjz+9CXAD+NMZ+QmNwFdtv
gGuDPNK6mnn2qw+yByl4IE4C8y18+g0=
=bpLt
-----END PGP SIGNATURE-----

--Aom92kSsMu7QFbcF--
