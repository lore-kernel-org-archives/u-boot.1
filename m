Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907A6606A31C
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qdva8RR8;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Dec6RFk8
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6FDDA8101C;
	Thu, 29 Oct 2026 16:47:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1VSjkPANL6dn; Thu, 29 Oct 2026 16:47:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B23E48100B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793292453;
	b=csdw5UlkQ6Dpt9k5dDbYUdTc8Ms3qhY2aYxgfflMyMA1v7YNeBsbhfYaeagRZgq757O/
	 L+LPWlcuvfTy1sFcxg0ASj97ng5YRShI1BXryR+iYPtUgRx+w+5FaKw7/M9WgPATb4/Rc
	 SJGhq6ZHymc54pT//SM72uJZKl4EMU3u2o/dQgJ1mtCPlgfi07bS+bj9q7gOjJSzEOPfY
	 q0Tf6bOQacSR+j3S5Cp4iAT/tdIQ8ixb2OkHoBHPrFHFCiKO64io75i6L3PGwWh34zPZj
	 QaN5ui5MqJ+afiKcxdri+4+Xc7AFJahvVL5hcDcASwwZC6waq49EKNrlUMnwL3sjyMA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793292453;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CU5M/GXHzMqtpeX75HKciAizc0BWJ6Ecx7AMAJKQbBI=;
	b=FQjoMS/qWRBkMdkxsJECaIWsZXF/H8ibIoUpqiBsdUGY52FpDY33puwuVjy/nsiMsP1g
	 Wcde3MBiEMN7tgqmmSX8bCN1RiB0mnJFrmCltFqztXQNqtoe6JCKU4wrd1pOchLDaJjpX
	 DAEHfckZ+RWISAL0q/HKP7ChxGh9BfsPV4uZqR2aiO8Wk2zXaR7Ix7VpT/MZK7XNGMLjI
	 YKL5clqSZznI8ROMB9hZQfTeW7yTwvsWFrJfhLyzsMMtZcIVlOvace1Ro4g9N+eEjmfC+
	 gaeVQLLFzLl9dA16BNxLNmGiOdwIjXbTPTU76QmOKCx/sgyQ6zxoFL5+S/qOzha6xRA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Dec6RFk8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793292453;
	bh=CU5M/GXHzMqtpeX75HKciAizc0BWJ6Ecx7AMAJKQbBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qdva8RR8v/VSeg//LAVdpHrsxSHLwEhP6gSq1bTFqxLj1xRcWhXfDDTOvayNte5JI
	 M9hstJ1TUjW3+mSXNm39n6juIg4blma378CV9pAaEy6F4cS+dHKDyftJ99CcTJfX16
	 s1YeKVUPFYnun9o4nBLoptOlyoFAfKBTRlUtryJZnqmW3VT84pC353m4n2jJKqIXXR
	 f6VedYnfetcT1DWkoOQGOXxBR6OO55yvWrsFDKPfXVjk7C+d/0Se8pHlQkvuCAsvAi
	 rBCoUgm/8KHTzc9Y41AZLGRPenabcl1b+vzPBd6IkuAWwlasPxY1ihUR8h2OVMeY4P
	 OGM9jFqjJOpfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B23E48100B;
	Thu, 29 Oct 2026 16:47:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2BA191DE
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:47:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E84E480F71
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:47:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yQrRxg5iRkf1 for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 16:47:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 230DA8100B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::34"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793292451;
 b=Syrt23KXTiS7HGeursGXSsn/nDAK/lx5GMxrNvisjqUzVqP3AJIS1XJGjUYj1cjW9VJw
 YVNCQG/BorZtpkh34F46qLQRCN4zvsCaKAIASg2B1IKpvIQ99LyGRGRb1V3YhI2RRm0BQ
 Q/8bqONIY8k5naBGmsQrJlKW5TztjZu3XnVge4ZpsQAg3bli0SF3aMGSxW8t+xtJpvSR8
 mP1HCHCPC/q50483mlLaOWJV9gZ7ULxn9Ar0tJLfwiSXpBmQ5XP/f1AiwOxCbW/G4gpJ8
 dGFn72VEj3BXa84VSjxQ21QhhGv8ET8yRPvsEgR8JE+ED/Qr5PFfJ55+ZPpuFLXDeqw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793292451;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=CU5M/GXHzMqtpeX75HKciAizc0BWJ6Ecx7AMAJKQbBI=;
 b=XfhCwYuyhD9r5Vv/e5vwKYjZ/h/pSJKmZDZPGOsoU4poD0lJylptQbkTYCYQKkcAA314
 HqZBQar8zSvy+NJJz07C01HnXZ+/1EVob+Zft5l+Ez0Q8mZR7geOWtas4CgEFL/lf0N9Z
 uyB1APUO6yUbj9GmiA9uptt/et3vuxmTR1SU9FWm+A7g1W2nTZxHj70GfQzjr2V5qy1wU
 o1O9PgBT241/4HTpJZLx+iFJ9XtzvAEK/Zs0b3TzM565u9R6LmpJxBSLLZEWNKISgFD5n
 byeZ/34BkrW9gyk4n9w1RXhISrXWwlF1IYKCismVmtPcVISmh+LB/kuribsXit2rkuw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Dec6RFk8; 
 arc=none smtp.remote-ip="2001:4860:4864:20::34"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::34; helo=mail-oa1-x34.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Dec6RFk8
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 230DA8100B
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:47:30 +0000 (UTC)
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-4a76f63b243so859231fac.0
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 09:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793292450; x=1793897250;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CU5M/GXHzMqtpeX75HKciAizc0BWJ6Ecx7AMAJKQbBI=;
 b=Dec6RFk8pfzIpIH3Tt3lVn71rvLmKVtfzYesA4R9WJMJ0Aj1PfLmJuZQ5sPrS2yVml
 4WBTYq21vO+OUFatGd5FqNwHE5ZRzPk0H6n69bqq1Jt/J99X33cropY6rsPfYmKGgM3l
 gHXy7tvinvEWo39BVNFJZZeZ/K/3LZ0fH+WTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793292450; x=1793897250;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CU5M/GXHzMqtpeX75HKciAizc0BWJ6Ecx7AMAJKQbBI=;
 b=IftVejYy9YPG9sGfP93fc3KUH22RWCSDcvDNy3uQ8XYLloIJtl6aotV7tuVjJbCnsy
 x//EMhTxBzZVnDp0gy+XgVg0WJrDddO2+fhE9W/35nYeUDWxue2fGRrEcbGG5q6Zbmjk
 KrZLEAgA9CNRwT0h+weh3MumczKzcMONXCqyaOzCn82vKbi1osHB3E4wFpoB9069zprO
 sr8ryfp4QyTrgI3n7ATxs2230tBbhAmyZZPdFj5M84sZAwk7eu1ovsjmXXqDumJyJ6/L
 bq5PxsHsSijxtK4+NumFYzISblE2IBin8a7EijefrF0YX5RXWjJgw7/1/ANCkSe4BJPm
 3v9g==
X-Forwarded-Encrypted: i=1;
 AKwUvByp/HSD1jsNhNsEblBTKDC5XIo9DMK2lfp+U7OxQY0MGjfMBCWvC0WOtSPlLZT/XOtlkU+qx4M=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK4Dyb51qsNtDP9PpN0O1ybSkcGqwl//Y+CaoQgVLSFSrfNkjf4
 xSXHonfT1lRMBks0gmziZLuw/wxYqS/OD8Mk/U/FtedEvY3is0+jvHHYXEDlAL15pPY=
X-Gm-Gg: AYBFou3Jqny4+WNz2vIhZjqwpb6IjpvW5REXGFS1NZprScT0sUvQKKrRrzN517kwsyi
 jXYHhvS25BzO4VsP2Dg2kBna6i2XYA06TJWPcWlxJ6l2Uk18zLrCI26H9Sfa0po4cjZWD5cpRvC
 yW6onbC6jFKjvg8mXzTl94DjZikGk/jF7Q0xbsjQjQNMJpBzQVdbfuNPH4oQ/5X7DtXmhWklPSZ
 LnNyC+G9pEQ8wWbjcA6H/mSbblaLUWFoKuk8snBLn2F0rWm5BkAUUPgxSHgVUiHuE1P6fLTBY2g
 PdSg+QKbyjcwlhWO4BR6eLcvvKhPHFNj31HdXy9DCPzcw8jF688OIGFHjkL+DaD9BcaVYAKdgjB
 XbnGzi7kguNICWQAiav4zu3OdndqbD+kz+a64ciw2s6RsM/L+FCNPn70BDsKPA5ChWsV1z5Ic2s
 OCnjKaTjlJQa7ikSQYk+VKV2Zjczt/6yKrz8DVK2WV0PBj0ox/rjhDwCbaWTdYXEhh+3g3aKgWf
 10ZLm09yRNtazqOfJrN0x4akDsGB7DVAshVH8Gu1jRXK8IY22mi2D8yRXodDwWmm2zGCRpX7fq3
 RC3/rXsl/pQjl3I3kgmCGMTRxB721q2Hj1+wjzC/5ocgN3lXgTEht5meE+jwmacbytnOo6Xyatt
 ndD5gu+YvhdJwXiYoJubYIeUdhaEu4I7Ln35ck2rPIi3DvspeOETgF1sPotpOb3ZtflUtEkumi3
 Eq+r71Ue6j6f2POaUV1SMyyFk2CWrV+2Y=
X-Received: by 2002:a05:6808:c12d:b0:4b8:4703:db8b with SMTP id
 5614622812f47-563ef9c9aabmr1729874b6e.20.1793292449694; 
 Thu, 29 Oct 2026 09:47:29 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-563c5a50ae3sm4355001b6e.9.2026.10.29.09.47.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 09:47:29 -0700 (PDT)
Date: Thu, 29 Oct 2026 10:47:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Abhilash V <abhilash.v@oss.qualcomm.com>
Cc: ilias.apalodimas@linaro.org, aswin.murugan@oss.qualcomm.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@nabladev.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 sjg@chromium.org, Michael.Srba@seznam.cz,
 varadarajan.narayanan@oss.qualcomm.com, nikroks@mainlining.org,
 balaji.selvanathan@oss.qualcomm.com, nathbappai@gmail.com,
 jbx6244@gmail.com, u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: Re: [PATCH v5 01/13] arm: qcom: add common QCLIB SPL extension helpers
Message-ID: <20261029164726.GC2976463@bill-the-cat>
References: <20261029105746.3487456-1-abhilash.v@oss.qualcomm.com>
 <20261029105746.3487456-2-abhilash.v@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uQjz/uHKX47VBMPq"
Content-Disposition: inline
In-Reply-To: <20261029105746.3487456-2-abhilash.v@oss.qualcomm.com>
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


--uQjz/uHKX47VBMPq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 03:57:34AM -0700, Abhilash V wrote:

> Add helpers for adding QCLIB interface-table entries and FIT
> blobs, expose the DDR self-refresh exit address, preserve
> U-Boot global data across the QCLIB call, and provide weak
> reset hooks for SoC-specific SPL code.
>=20
> Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>

Why are we doing this:
[snip]
> +void __weak qcom_spl_soc_shrm_reset(void)
> +{
> +}
[snip]
> @@ -43,6 +91,8 @@ bool __weak qcom_spl_soc_check_dload_mode(void)
> =20
>  int __weak qcom_spl_soc_pre_qclib_routine(void)
>  {
> +	qcom_spl_soc_shrm_reset();
> +
>  	return 0;
>  }

Where presumably qcom_spl_soc_pre_qclib_routine was added in one of the
listed pre-requisite series. Is there some future point where a chip
provides a non-weak version (I hope so)? How many different chips do
this (I hope more than one, to justify using weak rather than just a
conditional check or some other abstraction)?

--=20
Tom

--uQjz/uHKX47VBMPq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauN4mgAKCRAr4qD1Cr/k
CgD3AQD4cKuyz/B5UVYMskXhzbTBJa7qGiJq6OD6xALGb7qyfAD9ElwPg7IiUFrK
DLwJysGJhC8RAohoysKXoFwZ7dII5wY=
=jugA
-----END PGP SIGNATURE-----

--uQjz/uHKX47VBMPq--
