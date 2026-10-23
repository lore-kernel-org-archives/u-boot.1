Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9E4606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 14:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=w44UdSW4;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=MjKoqVxv
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 18AC060641;
	Fri, 23 Oct 2026 14:04:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dO47LtUAy4j4; Fri, 23 Oct 2026 14:04:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 72A2F60660
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792764295;
	b=DHr5E5TymGgnIshs8ETrVfj0jGdtCjRyxlAfdm6ptIlqHdp/Zg1TUD1Zo5L0kf5ENCkh
	 dUkKTNJqWrQU8ZfRG03BqMZHDAcKrt5WKVnNv7os8otPdanNHhBudiWU6ZeCdCKUxv0mC
	 0EQDj2qDC40kc01OI3R9q7KsvK6aV2/6kSLZUY2JG+ecNI2cx80v1o6jP4FQsIM8ks+50
	 sSP/YpTgPoKtzAFbFgCEEtcVHEgnGzmIpZ1n7n5D794x6ySUmZfTJEcrROgNy51tOwWDh
	 QpUVopvbry30Y9uH+7DtzNIOoTrAXNNvu+F3g/pmcHFdliaaVw4Vp0kzAocaVk7wjdw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792764295;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=w0Lm7iIQ+x091ZVWpyRpUyJsDU1qGcAP5LXFB2axwWE=;
	b=c+3lSZQ7vIoKMJFdeHobFPGaBFk58mhBr6TDC2CrDhbLEL+bD8JplSo5+PYYUCLTsdXf
	 AJcicv4owHy27RCubws/bOMHyO5O3hZZVn3TSUSnWWD8GMe6Yi70TmjMZXr5V56edLj2a
	 2T8luMZyXa7qxg/ZcPvdwM2kO/oEGUilHaqROXajhK8uxZgACu+kfWBANva3qhbshWLSe
	 RGFWAOYRnrU1+MmDeK1fOJUGKzAUrMmWqyPqYyuBZD8X/SJWs9K1aOL3v7QpapFoiK2/w
	 i46iMii/261sWlJH3O3rtKSLiydnD9TlZqlGgHIx74r4Xh2OqQQ+DZMk5QCjMcOEQog==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792764295;
	bh=w0Lm7iIQ+x091ZVWpyRpUyJsDU1qGcAP5LXFB2axwWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w44UdSW4qsU3bRyyaHvGRUvqwDvO8HbHnAYfUlicHmQZ7KkvEfoqwyUpkXrPc5B6K
	 W2yTxhNy2NFjybNwyzO89P3RCgEY2i4eEJrEXNhgO9PR1Vu8qSvJQLXB9lBHFxTsnp
	 o0soE5/6+t1OpH1g4+8A0Z+SLFScR5Qw9rrkk9p+K2S/ANrxFbLpZJTIwOlbfDmSjI
	 wzBcC78lSSEUUh8YL6/7a6aAAs6Ddrof3qM5gIWDmfmay0DT0hDC6whGqdglA2nxnq
	 om6A4JVvSH+kd5f+mkQ46RdQD5zaaloK4+/p0Bn9QAfpcOznfirfqvCJgBOhBlTsRJ
	 iJFkstHmYTVBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72A2F60660;
	Fri, 23 Oct 2026 14:04:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C3C5F12C
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 14:04:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A99E481155
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 14:04:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nlCg-thz9Ae1 for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 14:04:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 07D4D8110D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792764293;
 b=qufUIHC7TGcSPNbZ/Ic0Gen79S2BPjKbkLAoy3WcBPEB/MbtfysXUEv1+S2rG6rxBwlK
 FrObc2c5ujq3FEP3Nnw4zutyw31+psqwiOpNNZL2IkU1tT5RZjcGXlkcZjqhUpGUCDXCJ
 1X6nuLR/M52sFG9Z1bqmMaJ1C6MTdOPqFdw5WC3KGX62xI30MvecjnasIxVLBM4nDrU2L
 Ol0fFKEIQCN9bsuYYcjXZK+Q5pfTnYiBX0hyxKh5RDvW70UmsKxIbOrtHFJHGR9IrfG8v
 u3Qw4FDajDrquLEZbMZemID6sTpK7deve5n57LIqcA85ZIXglJBB4hgXn6vn67+5N5Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792764293;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=w0Lm7iIQ+x091ZVWpyRpUyJsDU1qGcAP5LXFB2axwWE=;
 b=cwodzjStGiDs0/WCEQJWJW5iCAP7rZYNNeTqB1OtLfrZjLssmmmO3DTO1VLNNvOLK2g/
 OBGls8KkS1DDetHniYsqZA/Lbn2wU7ljsyahStxp4BPIRy39lXcewuyvTwR1kvuOK8ifg
 qFKY8xJ0HMOozHXf8Whzmg1NKMUTrmoLjPI7K0lE1qPHmsg2SH2bu1tDLLiO8guosQ53Y
 AZXlnV09feW/eqm89UthM0jGCdvC32XDzyO+3nuYdnAWo1MfuRajNmlHBwqTw0CI85iM+
 dPB9AsLMfNi+17YuXa4YE5DYCZCUNc8pYDpvjsbXMC9optuuSi03WeF+LS1p8m6SzSw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=MjKoqVxv; 
 arc=none smtp.remote-ip="2001:4860:4864:20::2e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2e; helo=mail-oa1-x2e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=MjKoqVxv
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 07D4D8110D
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 14:04:52 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-4877837890fso485008fac.2
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 07:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792764291; x=1793369091;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=w0Lm7iIQ+x091ZVWpyRpUyJsDU1qGcAP5LXFB2axwWE=;
 b=MjKoqVxvl3/d+jAsxo8cp4cLuJxBA47F28UkwrcgPCQTR8WmcrY7WekKoKYsbjypUu
 eyz4hn8ceSfeL789TIHsMt+1kH+bOZCbFUUgFadDuPrzDjySPHR+5QU/s3GokDtuWEQM
 oAQG2d4Cyc2o1oiq4uA+qb6zQP0M8vmmMeIx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792764291; x=1793369091;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=w0Lm7iIQ+x091ZVWpyRpUyJsDU1qGcAP5LXFB2axwWE=;
 b=Ky7RqOLUsjy0gbf5Gei1GeyOha/NYsrI3WGJQqYQ+cGJvZGtsnNyHl/loeY6t63nhp
 CNPhLjX7R7wWU4pXF5VhODxR2frtCsj+BZ+DYfcp8UASCiDrOjPjD2MsgSbKceCHqdLc
 UO4nRfIHOMrZHPd+l9ulNDAwJ8KqBVILSXJ+WbqYfCKhge3KbO0Rqvubwfer2z7He0XW
 fHVQnX5zGL50vNEuRPhqstJaLSBeJgaGgnDgRgQq/rwUTdCkAi39ubR2ijCeTHq7hOFV
 owZFRYA+ezEhszT5o58KYMweg1p5ijtU/7Kgn7nKSU5KP6Uf/odN+64lSJ2qxJRjcKAC
 DYSg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx9r9AgJVk+SQi5x2QlzGR0Yf/oM7/jfU/e/+wSA1cFZoCpiaIg7syAbqIOUzC52d/Z7pG5ZVM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLTni4c2KIDCMfDpdoBDNZAU91Bp7JvhKeH5Idb8zPvVh9n0awP
 SFsTMeZEv3o1ogsHliMrK5HYNdh8eN4vkrj2Q/jZlnn7ArWBHMpNC9TJJTTjD2gmAxQ=
X-Gm-Gg: AYBFou1akJOCKLf9H95dWCf3Ly0j7/A6u9VftwLn5dbQ3tTtWWi2O4d7AidUQ3CyP90
 39ecxonDM30RE0GRJHsxrE62w6GkTAEVxROnNOdAHrezgfpWhKLfs+dwY2KK3MM64N1wPy5KwGj
 vomrdOs/Vr7VQ3uRsskqJHAhAsyrv0WpXaHgSpXExdl9QQ/cPUhfMJUKf2Tg2eeq3T+nShc4lAo
 Y6nyYvnyo7jNPAQZbUZ9S2gS22mvxOHMfVqwVPaU3/LbKs+hpYgL/GwrybOlhmsx6nfFW0hvXSn
 d1di3fWsH2Nk/Sko5yxUfae6NAQPCVjMf+zezlF6x0XNr56MKt78UkHzFmp4B3tGa3zWps1JLnq
 RWIYsQT5v10m4ClxOqfeZfcKjPkJQcnomhbLNAYfdtoLngksiRhSemc9FwjGrItyfojcsMRDGcw
 HRUQ1UPGgF3IntV4nHq73twz/ojvRouGeTGeRrQU7mDrCMJUVN/Nd2oBo3TMZ+x33lUjcaU/NTx
 eGbSVy8YXpC0sFFyzy6Zh51cP7JDeK6NEE9y8u6/Ny/vguUx6n+/zK/SVkf5sGNZKO7n8wC7gfS
 /FlDi50c0j4GxSvxx17tqxZ8X6j6y46j1yyifjvs0AvfdWrnmWEr6XfwQ0wX7DfxbyDpvVitHrm
 K9s7KEtMWsc08N95tOtHpJw==
X-Received: by 2002:a05:6808:d53:b0:4f5:6c14:7978 with SMTP id
 5614622812f47-55be85fed91mr1504441b6e.24.1792764291156; 
 Fri, 23 Oct 2026 07:04:51 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-55be98206f2sm1525247b6e.8.2026.10.23.07.04.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 07:04:50 -0700 (PDT)
Date: Fri, 23 Oct 2026 08:04:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Abhilash V <abhilash.v@oss.qualcomm.com>
Cc: ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 aswin.murugan@oss.qualcomm.com, sjg@chromium.org,
 Michael.Srba@seznam.cz, kr.sowmiya@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 1/2] cdt: enable CDT for Shikra SPL
Message-ID: <20261023140447.GG3596691@bill-the-cat>
References: <20261023084019.3722376-1-abhilash.v@oss.qualcomm.com>
 <20261023084019.3722376-2-abhilash.v@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2FM1I48o9vE/SNSC"
Content-Disposition: inline
In-Reply-To: <20261023084019.3722376-2-abhilash.v@oss.qualcomm.com>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--2FM1I48o9vE/SNSC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 01:40:18AM -0700, Abhilash V wrote:
> From: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
>=20
> Add support for loading the Config/Chip Data Table (CDT) from eMMC
> during the Shikra SPL boot flow and registering it with QCLIB via
> the interface table.
>=20
> Signed-off-by: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
> Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
[snip]
> +int qcom_spl_cdt_load(void)
> +{
> +	return -ENOSYS;
> +}

This is only called when CONFIG_QCOM_SPL_CDT_SUPPORTED so we don't need
a dummy.

--=20
Tom

--2FM1I48o9vE/SNSC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCattpfwAKCRAr4qD1Cr/k
CiPqAP96NS2l/lHM+8U14YgULWofzz3aRxC4XhjIVbTKWomL+QD+JoR0N9xnGJ37
+KaOSppYOhCYvmrz3hVq1Bulms2sXgM=
=SjUP
-----END PGP SIGNATURE-----

--2FM1I48o9vE/SNSC--
