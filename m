Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB55606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 17:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KGrpmTQx;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=OKllFgl8
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 58A9281467;
	Fri, 30 Oct 2026 17:22:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N4VrVINZCeZQ; Fri, 30 Oct 2026 17:22:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AD852814A1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793380963;
	b=dEJ7f6cXeaADiEnQD/EuVOFDEe9ChH268vS2R1hi80uLKwUKenZuGjRjADLdBFngHYpI
	 a3kx431PLlxZh16lIp/ulU0vLmQfsEL+FY3HRbNbGMPVdMkB+B5ZMYYDaCBbfRtoWdzUG
	 IpQDJgzON5LnkDRSssb3W2T+8OGmhqb7ZKc7nY+RdSFtOEnO42SmfNnxkK839QQeG1270
	 UH7LI9WW9AOEYpGFscJyTMRDQcqQIeCXMF6afATrKoUeZMeB7ZELs3EWwapHyZKeH6zve
	 gx/3dRDTTtSPofKjDvmmg2CFnjd/1FePu1RDBtIAc2BWRPxD+sgMm5O3hl9wYHfbLZQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793380963;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=32NP5nTZEcsFLmtsKOYoWksFkcjNvQDYF8hPqOqP6CU=;
	b=e1pIH5UKFG/aqlJrf0OvnPSp9hIQ0q1ztlFiektY1azphNk9RFVaYGswRZhtqxRzldHk
	 VUHfhLJ6QQw0kz7+T2Ntoifm8bTrb0RxYd6PeDigVwoIEG9AGfECAqy3yMWzjw65dMtfi
	 89O4I6UKBeY/6WuNLT1LV9IYURUjvqsc4BjuHGInc6zhdCYUIpejzVncWt8u2Ne+85fz8
	 5Jps1NPAZZExnTzROPQIYHJWsJEmnXIoKwswopaZDbOxH7rFIu8tKjSDj+0v+vmY/zUWN
	 NNJmXVzbXL/7EZwJBPS5H4SeGaINe8+fPmlwyv6/irmgS+wVyCxaneB4SP2WuInnQmw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793380963;
	bh=32NP5nTZEcsFLmtsKOYoWksFkcjNvQDYF8hPqOqP6CU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KGrpmTQxAr1oRBTGyvpOovpFdzK3tT/vAJUXhRm4CmZwgIrfUaszUSChBhHCfELwu
	 RKlr6xreALF6H7FFhUti81NZCvMEpojIkQbsEtQT3TMpdkKnQc7aP9nJjSnxCXhfDy
	 4bH2Epxla/ezd1wdTwn+ekTD85FKUB9Il7jhEnyUSeZEAhnjrm4p8XcXxeKWs9Z9mv
	 JBeY4ThxXXEK9Pou4NptK1COqZWcZB59oI5YqaAkbb3rPJl7TurBxCq5jSnSjNKGCA
	 nCGF/0j1Jrj8oSM7cD/i8jSP2SaOh2Qtjkor3ZPDuvvPdQax+uH1EY+mKSkWy/JsWD
	 9OE8+X1GRTZyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD852814A1;
	Fri, 30 Oct 2026 17:22:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7519B411
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:22:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 66D9D40C59
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:22:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YUySlI0wCMlm for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 17:22:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8348040C52
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::36"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793380961;
 b=rdjsJJohAG5i+OgKERd54OZFLLVloK45mD8s8Jfbh6vUyKSJMOK4qVCCmASxRk/o2Rd+
 st7L+gxvtjnAS7Rj27VWRJ0h/Uycy8H82atPVHH/nV6lnKbkDJu7Q9x+Owo+wpBz97do+
 +18qxGY4QwiPWYLXLZxuAuWqOKlrxVGCrkqyBSDd3dIpRdoDZAF1FG/kRIU6bKNGYxRBK
 ZedycMCUcWFwRypTxAKopcWMoCc2kmw+vOjnYGjjRHVkvNkje8y+EDLEXxGhE6LJVTdwj
 5PDuOlDIMmtWFIZnHLZIbeyv5A8ZGQFkEDMBe/KR7t0gV//wlTKyq7iwnA5S7gESmdg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793380961;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=32NP5nTZEcsFLmtsKOYoWksFkcjNvQDYF8hPqOqP6CU=;
 b=TGXHCQ3BacDKzEh8sjBrZqalV0GG2QwKKlFg8SkalPCST6YFYmik9+yiDpujIf2hI7YV
 yPrVyEtl4EXdp7tUNmyfO/VZZ98JOKlKlFChBlzRxKcEqEwPthyWZ6GzZyjE1NtgOJ+wz
 3LJA6USo2S3Gf9CLhzfzu8TP1iYcnr7Q2tepSWNCjX5HGyHOz4+UobCNcmwCTFQ+K9TXf
 7wb0quMNl7brzMK1PnJZ1Ij9uzt0OtItT3/G8uzuChrW47KCTmmdRwY51QfWCtrg5aWh5
 HSzRg+4H5WiXiOtO/pwKHOofYlNEiNqskZvzaHB3z5xRdyq2YOj8V222tmb05lNeJUQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=OKllFgl8; 
 arc=none smtp.remote-ip="2001:4860:4864:20::36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::36; helo=mail-oa1-x36.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=OKllFgl8
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8348040C52
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:22:41 +0000 (UTC)
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-4a76f0cce5fso499727fac.2
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 10:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793380959; x=1793985759;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=32NP5nTZEcsFLmtsKOYoWksFkcjNvQDYF8hPqOqP6CU=;
 b=OKllFgl8YyqYkNG8JYgCKmOuTCDQrDktI+Web5LDwTvXegQYUVmmob+aA04U7GQNrA
 Gew1/o+jWAb5UUNFBIT1qJpZ2UfN7S+BKz7Eh8I/G7OI+1xCE97lbGE4tLW/6yTJko+s
 YTpftPoCzBb7wYe7q7xnXWvW3z92c6AQvld8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793380959; x=1793985759;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=32NP5nTZEcsFLmtsKOYoWksFkcjNvQDYF8hPqOqP6CU=;
 b=MW9pjSSlmTXU/HBhImzXdAf+QOR4zwidYd2rdUunfQKRKKPPpAaiZY8yFk1e2UIN6k
 Z0/D92H+sCpyLmPzNLX5x411Yu49V9rsqfvVtiMy7V89gyLYc9wvRveEt/7HDP41x0OL
 qckr9yhmSAu5kUy1V1ALrlO0H3EGyV+yAAoQ81e6azzGPpJlAyEZDU4u6gTpCl4Tmmyr
 BEMvead9yPGe8ceLjmIjoBO9iejmDM1OJ8rVB9sT9sAg8Z1PJ6zwG4dOhIbxT+YXcWCN
 c9k5cGC5P6eyPfDBcwgoyWbgfus+jGOX1tW19fKo3bqH+N8XcNDMkSbVq5L4p5b73GmY
 pJmg==
X-Gm-Message-State: AFq9FYLzhrzQhFCQDEYoluNSfu5PS+YYOwC1kcQvy8yd7gZ180DoyqE9
 v5BvEZxC4nK+HCFvI3RCTJV8Su3pnMnOK31/5RR7rSzKnIjNb67PWbEQDT8u/C+YoF4=
X-Gm-Gg: AYBFou0W60ZGOZ28UWfj3qmyDSgM10R0kUMG89sidqIBayF6Zc5LoJIisF9mfMhQshh
 vwALwUd/m6SPG4049jDK02IV5gnkMIPNjZDYkFxwOe/fTLJdKfmXdMpZLP3E7J3B168EHLAVSqo
 c+3MHPgKsMm1lPquXavjqODK8lS3mvgBSsOUk3Q57Ah2ByL8C8Cm+8FldnUOSZrurc4SziqAcId
 wT8VQ1E7DMb1GPgIfTDqw4GSxnKcGyiUm7eupJTxTBYEKnGdnDUu9/XGJwwgsllq656Jh4U1FhG
 MTuLetCcIWH6hcGGvumiYOqaxbTUMB905ibLI3/f+r5f3FvZkfrpYQaH3ea2FjKCdkpZVSCmGnf
 RaaT6sfoNHkMw1kOUvO9X8KreCNIbmrk443vi//aJZiSCes45ERxzZf/02oMVa/Aa5b1PcbcuF/
 ZWo23FD8+TFKEL1CVDSTMZottzaBRy8Xro1smZ+m2+avxvmDTAroHEY0J9lpjsawVIVYl1yg0Ke
 5cf8CZC4mRLKulLvQI0swS/ju0gzX5SuHQEQDbZ1uhfhW2TxDZ8dn+vbpwMOAFlfFv/6rptIi6A
 ELbQa/mNhg7D52YsmgzbhxSf2rLWGNuiH1vVNWKbiH4YunLMEao6ld8WZzwYjeyW0WgBOMUduoZ
 9X61D/1vXKe89tZnEy04SVb5etw1RZmMdkOW5ge4RDP78AT1JiFq6af5eA0JGj3JeynwDMn6D+F
 ry+E+HaHGog3N4ujj7u6Xgw6r1hcXye6xQHPL+meAJzKba/JDDhrNY
X-Received: by 2002:a05:6870:9f13:b0:442:e14d:7999 with SMTP id
 586e51a60fabf-4a90761c95fmr2187041fac.16.1793380959507; 
 Fri, 30 Oct 2026 10:22:39 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a921997d50sm489909fac.10.2026.10.30.10.22.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 10:22:39 -0700 (PDT)
Date: Fri, 30 Oct 2026 11:22:37 -0600
From: Tom Rini <trini@konsulko.com>
To: =?utf-8?B?WWFsw6fEsW4=?= Can <ylcncn@gmail.com>
Cc: u-boot@lists.u-boot-project.org,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH] mtd: rawnand: nand_ids: add Hynix H27UCG8T2BTR-BC
Message-ID: <20261030172237.GF3309461@bill-the-cat>
References: <20261030073721.164747-1-ylcncn@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JPum3Xc0BhWA/Im3"
Content-Disposition: inline
In-Reply-To: <20261030073721.164747-1-ylcncn@gmail.com>
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


--JPum3Xc0BhWA/Im3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 10:37:21AM +0300, Yal=C3=A7=C4=B1n Can wrote:

> 64 Gbit MLC, 16 KiB pages, 4 MiB blocks, 1280 bytes OOB, 40 bit/1 KiB ECC,
> ID ad de 94 eb 74 44. Found on the MK808B HDMI stick (RK3066).
>=20
> Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>
> Signed-off-by: Yal=C3=A7=C4=B1n Can <ylcncn@gmail.com>
> ---
>  drivers/mtd/nand/raw/nand_ids.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/mtd/nand/raw/nand_ids.c b/drivers/mtd/nand/raw/nand_=
ids.c
> index 4f46378f..6a6a73c8 100644
> --- a/drivers/mtd/nand/raw/nand_ids.c
> +++ b/drivers/mtd/nand/raw/nand_ids.c
> @@ -61,6 +61,10 @@ struct nand_flash_dev nand_flash_ids[] =3D {
>  		{ .id =3D {0xad, 0xde, 0x94, 0xda, 0x74, 0xc4} },
>  		  SZ_8K, SZ_8K, SZ_2M, NAND_NEED_SCRAMBLING, 6, 640,
>  		  NAND_ECC_INFO(40, SZ_1K), 4 },
> +	{"H27UCG8T2BTR-BC 64G 3.3V 8-bit",
> +		{ .id =3D {0xad, 0xde, 0x94, 0xeb, 0x74, 0x44} },
> +		  SZ_16K, SZ_8K, SZ_4M, NAND_NEED_SCRAMBLING, 6, 1280,
> +		  NAND_ECC_INFO(40, SZ_1K), 4 },
>  	{"H27QCG8T2E5R-BCF 64G 3.3V 8-bit",
>  		{ .id =3D {0xad, 0xde, 0x14, 0xa7, 0x42, 0x4a} },
>  		  SZ_16K, SZ_8K, SZ_4M, NAND_NEED_SCRAMBLING, 6, 1664,

What I want to point out here is that a link to the datasheet is what's
needed and not just an observation of a device.

--=20
Tom

--JPum3Xc0BhWA/Im3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauTSXAAKCRAr4qD1Cr/k
CtR5AP0eLDC7T+Ehi15xZx8Y+b+UfMqjRsAY+Y0rzKAre+0fPwEAy8GLcG6QZniZ
4cZSwdIt+sRwjy2LzLtqYUvlUZdSXws=
=H9t/
-----END PGP SIGNATURE-----

--JPum3Xc0BhWA/Im3--
