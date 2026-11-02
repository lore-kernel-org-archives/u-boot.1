Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F63606BA56
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 17:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lzVvSfG7;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=jxL5x83O
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 27ABB40659;
	Mon,  2 Nov 2026 17:22:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dzozc7KSUZPr; Mon,  2 Nov 2026 17:22:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6C36B406AE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793640123;
	b=Ci2dVgE/ce9e7Qv17L3opUH1Ad+NeDQdvFh8XqC/s3u+RuhPwIh2Oq6640eR1MLw7YgS
	 Nvvm5v3bouRoHo+BIiE0Iwusy9EOiUBtOvCB440pYRZ7B1YT0nvJzy+t71bxmsgvHiIP+
	 bu/wGHHpihrSCGyDDLR5jIsHwqy9vIYT0RsBxVvKgv6/jVZV5bek8aoURpy7dNvt/qaYh
	 VmkBnj7arsKOFC7kaspQA4Qk/9aMeypUYop8iD8xIhZ2YER/BfGP+W8L4UHFzzZM7UrOc
	 Y8+t64P+Ab5YpvXnW3fvs/BJdo65C8jZ9YMwP8yZMTy/hXfublH+o8SpMv8TGI3jq0Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793640123;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Y6mdorbgfik6oTm6Xpqh10JY+Sjc4DjZqENVj/GBNk0=;
	b=M06ppmHnqV+TLLbnHYEJptBvEQDnAIKpD/zLdAWuPg6pj3kD5cNGlxX53QvnOVSdDbYW
	 4gvGRaMsRHfdiaqCpLqnesl6pLmIFgfNdEqJdu6JeaFHfhsaaXBD8uS1wuehlIKM0Il6e
	 jOh8MN7Ps91bKXnqbOOXc2vpU2hgWrkhH+Qpknd+OV+JRLOA/7MuxZIj5D9A0W54R/+lK
	 ZXlvFfUVyxeayZ7hhoLGVn+FJ+brWXyvfrOuLJoRNyMpG501OCxIFlV8MPUNdBpz1AEpw
	 dItOMPqjGzTPPxyJHd5AoBzRXaROrEAI0/6hbZ3gJXOOFP658ZA5t8SHahZxNB9hDYQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=jxL5x83O;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793640123;
	bh=Y6mdorbgfik6oTm6Xpqh10JY+Sjc4DjZqENVj/GBNk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lzVvSfG7as/pYGbuYDUwbCA00qGWbqIvgaOpmqM36anCzElUEy1xwC67ePc4HRvQF
	 ZpZKoBpc5bB2ZkJfDXiATbLdWanz3FVL2f4w4xRK9Xa1dNUgfgcKD2jN6mqn/drFOp
	 +16Xe8lN6B50X+a9zdma5gnc1BC9W9xh2nNml8Z8VqyT9dIU+KRLgmfDNocci6szTk
	 7ZAUpEZ7YnX/or9kscxbqYuxgS2v3kUIrse4wYtcwXn+SLtz85DN2ertOVJbqUNBq/
	 xe5neTDivOyCYQ29wCKtdvuwiFr/GlWj2Nd8gQpXMJs+sf/otcHMILoqWZ93s9c4ae
	 YdGteLTb8eZ4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C36B406AE;
	Mon,  2 Nov 2026 17:22:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id AA7AB411
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 17:22:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9BF8540659
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 17:22:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G-00JUhNDxOn for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 17:22:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 67BB4406A5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::235"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793640120;
 b=Qe+zrONbsbATN8UQXvemTq66YmqPlFVvZxpbHkasa8vBKece+EawPwW2SDdHvsssTQ/3
 qi5gdXqnC7voiHxyn0Q0keefbMQEl2FvARQVrcgFZHulLvGr1xTeLOxHcxgWpAoPcu5s1
 gStMD8wmN9/KR5MTl39lv8AXJLXLrbVG4ZWxAEi305mOThThhsBQv7IQR9b6HkvrPkqbl
 OHkZ6XhpSmlbZuNUsqHJj+4/U0SLFbu22J6bzstPefzFh0pQt1UfV/dTOZGS70UBYGuq1
 38AmccqJJNllnf5AaE7rvoN6OCyM1XNufa6Jwz0bkiF13/SoyF/+Ry9N0vNGVEGMwaw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793640120;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=Y6mdorbgfik6oTm6Xpqh10JY+Sjc4DjZqENVj/GBNk0=;
 b=bZpaT5qCk5DTm4a9+2euvzpp7OcRDSMkTWBlMh58kujkBsFiE/WbmtA5L9wi1z4g/5fh
 i5bOfCQ2HhD+2I2btXtfLHtRN1yClVjQwBJFk0vDNTkHAuG3GVl569Sl6e8Jbqs4FWlkc
 wibd1XK+KU/qwsJbFS4xm8gZP1aYuXVj2h0e5jzlChamET2tgLXhnXUjpBO3mKvtz4vP/
 W1G3pGFE9qWXyqri1OXrh7pX4jlmifkpc3URysxXFAD3zye1/mVeGcSrhDZQf7mBeHgLm
 x2NgJxgLLFYHblcRE/g2yDsJ9obl5nXBRvH0JhiEq5a/qhuzdgx1c49FEamzxJSMGMA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=jxL5x83O; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::235"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::235; helo=mail-oi1-x235.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=jxL5x83O
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 67BB4406A5
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 17:21:59 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-53c156ba662so1828649b6e.1
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 09:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793640119; x=1794244919;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Y6mdorbgfik6oTm6Xpqh10JY+Sjc4DjZqENVj/GBNk0=;
 b=jxL5x83O0T+m7l0XXkFGMKYgM8koHVwAM8lz65NFBjD8EvY7YvY0cfN+XrBHcOedQa
 wIy3eDAEzmmXrKLncQFIxzzPgSbE/20O15K09b5Ly70qbp+4c5ZGSbQurjfwhrHSqtCf
 u3truYBYFfuwzq9ZOLmQo3M9OtL+L36J5FuKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793640119; x=1794244919;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y6mdorbgfik6oTm6Xpqh10JY+Sjc4DjZqENVj/GBNk0=;
 b=HKpL9DdtwhjrYrtLXmYoDkrRVpRmEho4aPFQgq7ON0aa4oScj2vI6ePP1QYWUQp6eh
 u+Z8w3MjUE98ARTpu34qzMoGwJCojzlQ8CdwQrsaGHq9ogN6Ty55yR5T6uSNRPzsx7fX
 nqCtFR1S5XEHyyzRCrEhgq9pey5wG7hRLyByo1XzeThCPxIMmI4xw8Ib/RWxi77gUfZW
 tovM6UNJPE7bLsl+wFGuEKoC1D48zMehiJX9acYWpDvC2K6uLF4BpMLCT3vjz77qJIb8
 jlLAMcm0VOeTU44zQ5jRt1D4pO97Jmb1BQrPlwLPcCUYDjmfqX/+dQoLvsNZZlEYh1yK
 EdDw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx+lcoXdnkw8qw+/9mMqAQV3RDtdkqOz/Xn/vVrp5BW9ZcFVWyYIyOKwEXJA3tifvZ1MGudfig=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLSZKUpSasKPv+4C3qHU6jj9wOsT9pceYAhaWYtZxQNmBJ4H8q6
 s83F8XXmi3bVeUfvZGiDLse3jgpW3I+kqhXHPju3ArDrFzl8M5u7tJzCJ5ckroJlAw04NMHpXH6
 wfDNgTOf2E+gI
X-Gm-Gg: AYBFou2qRZLpXfNHYBKQDkUUO+4s0d8V4V3yVa51HkqGrVKm4Jq+lZemnaxqfgzFnOm
 +U2cvHsOfCTqOrHzGCxLonypu0rXvKjt9x3tXSHvCTQrat9P7yCcpgwSGXd20PLPh0CJvnVUn4p
 XN69PvWzoW5wV44ZuhJQRDIFWqULGzP1Op2x8VR4+CPhEwhR1VeOpsywSzlmy0AxL8KJGRy3GPd
 Ho0uXNumxpzSiD3t9/N2FnIBwhmTa2DVAbLWNEP9brgxsYwd0HWir+VmpEGHOeWX/uQYxtggyIv
 Zaa2NEX5y8nnWJIGjtkNDidKEcqAr4fcZIhl8dY2exJrlRls8n4Fjl4ZODVTeUfRHRMySOXa8FU
 yqLU65qGQ3fsHEH/ZGJExAZsBia2vNrHKTrS0cPosW0+bE82AX9AW9nIkybui29sdNhWyv9RQLG
 +lJQ8wzxwjveUrERLWwsTwhFcjtov6/Pr+uCybYw2uJ/WddV+x8Nn5XbV7HUjJ349qEV+wC2Pic
 tdJ4xCfEG4wtoI3Tc1fnY4CnZalCaQVlTm8SQ7irx6AKtjqFkKalS+Yd5ix0Jt41fAQVhL2Q/iH
 EQwy1wwBTtAel3NYRA3RAoM+V0KJqJdipuYefaYRvrZOTcVjq64easSglGGfoD/sFhKGoHct+4R
 CwI+H1VhWjicYi7M6W9jKrb37lVsnThu2+LYoySdryVkcFIODTTcmPY4nM08cWwL/5siTnlki3H
 FyE+eFxwZCe1SbZ1TKkCpXmXCKa+WSIg==
X-Received: by 2002:a05:6808:2e44:b0:4f7:d324:bc36 with SMTP id
 5614622812f47-5640decbf43mr6667972b6e.43.1793640118876; 
 Mon, 02 Nov 2026 09:21:58 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-5640fe423fasm8923587b6e.16.2026.11.02.09.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 09:21:58 -0800 (PST)
Date: Mon, 2 Nov 2026 11:21:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH RESEND v3 2/4] configs: add qcom_sm8550_defconfig and
 debug fragment
Message-ID: <20261102172155.GE3309461@bill-the-cat>
References: <20261102-ipq5210-v3-0-aacf3930848b@oss.qualcomm.com>
 <20261102-ipq5210-v3-2-aacf3930848b@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Kz+6rduILtO9kXv8"
Content-Disposition: inline
In-Reply-To: <20261102-ipq5210-v3-2-aacf3930848b@oss.qualcomm.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--Kz+6rduILtO9kXv8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2026 at 11:22:27AM +0530, Varadarajan Narayanan wrote:

> Add a defconfig for running on sm8550 as the first stage bootloader and
> associated debug config fragment.
>=20
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.=
com>
> ---
>  configs/qcom_sm8550_defconfig | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/configs/qcom_sm8550_defconfig b/configs/qcom_sm8550_defconfig
> new file mode 100644
> index 00000000000..40f7c857007
> --- /dev/null
> +++ b/configs/qcom_sm8550_defconfig
> @@ -0,0 +1,16 @@
> +# Configuration for building U-Boot to be flashed
> +# to the uefi partition of QCM6490 dev boards with
> +# the "Linux Embedded" partition layout (which have
> +# a dedicated "uefi" partition for edk2/U-Boot)
> +
> +#include "qcom_defconfig"
> +
> +# Otherwise buildman thinks this isn't an ARM platform
> +CONFIG_ARM=3Dy
> +
> +# Address where U-Boot will be loaded
> +CONFIG_TEXT_BASE=3D0xa7000000
> +CONFIG_REMAKE_ELF=3Dy
> +
> +CONFIG_DEFAULT_DEVICE_TREE=3D"qcom/sm8550-hdk"
> +CONFIG_QCOM_GENERATE_MBN=3Dy

Commit message doesn't match the contents, and maybe this should be done
similar to some of the tegra platforms where it's just and only a
fooboard.config and documentation update rather than a full defconfig.

--=20
Tom

--Kz+6rduILtO9kXv8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaujGswAKCRAr4qD1Cr/k
CpHNAQCXmgL5nXQ9ATN2vtzBTEgOehoxfrdv0f3W8aAkJ7BGTQEAkJMAyZvoXY/2
/G4eNEzzmY5odH/cxUizNwLYuya+8Ak=
=oA7c
-----END PGP SIGNATURE-----

--Kz+6rduILtO9kXv8--
