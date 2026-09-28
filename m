Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3FC1CA5FA3
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 21:25:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A307D4050A;
	Mon, 28 Sep 2026 21:25:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1QRyv2NHyFcD; Mon, 28 Sep 2026 21:25:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 04DD140518
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790630743;
	b=Gsuk/77xzMAUQ+vVe9tHdL2djM4LU812mtx0+csceBq2o+8PA60twHC6z3gyn/bCDeUz
	 s9W8Fr+1siL+Q/DWSCjkYd4rfBcBmLJKRT4CGSIBMKcdNtE8j7vibORj2dw83jXVVWMsl
	 2dnZ45RIk5cumxdZGBabjVVu3YwEvXiW0QqPUS78vfu2MXt6aMRHNUoQ0Xi/B4oomq3AX
	 baZ7rYGgGI1ss4v/QSZQuIjRMg8G/6sk9cYimdDBoqZUo+lvAzsA0iSY/0MLsHWNu2GuC
	 nxa6WqLR/yJReGvftoaE3pel/FktiFFKpdtm1ysLguE99onhQ8MgwqzITMF8FDboXOQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790630743;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2ZTG0TUysWPbaVjvpq51PIZRN4jh00vPdAy9g6h+f98=;
	b=PjSH+xY6F7Yu3Qk4HsQHqNSvYw8n+TSkt83myUMs7wSuGr12zPkDqjgI7Hnqdm+52KNo
	 cvWoFRybGe9jdI8fN/7GWPz80U8N13i+aYdDUyiFck2pBRi+yx7XQ74cBEcvCafwau7qS
	 ryEtODwtjNPGWmXBgkRyMkIyuyePfOc8z+6XQ6GKL/LlopsGg6iKl7CIadrm7StRO06H0
	 CkOU2IyTH/zz1D3PpbU+u0A2ig3cQxnGgxmMQeeIWnfyvh0lPz+zeNy04Apy7LZfO4yqJ
	 9+oN8dcULALi383rmhaJAJUj4Uzesw7Dli5Yd+oU7MzmsVWyWLlS3W+WGZilPgZ9HlA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790630743;
	bh=2ZTG0TUysWPbaVjvpq51PIZRN4jh00vPdAy9g6h+f98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kEyRcWgQxRDMZWZ1UH9txbz35kU0VCSw0sX3DyR/0qToOD9KIv8QNv+Ul57l1PLhm
	 LrMZlsW/pyTP7RKX6RKGmQd8f4ngG7A7rn3aKD1/ndx7OvTFIvqOOMk8XVUI5XmEYn
	 h96j5ZZobZkMSED7AJamd77RRlkistt9HTnb/gDozYFa+DCdJ56/x/btS/WDZ2q/Mq
	 skF4p6s8D3ejEDV1oUdDXJ8HllqdwjXszokE+7nfAZShHYcKlyN1Ck1bqZwCZ3Nmon
	 dk8kTkRVliG6V1b601qZcxKnWap3jgKZhBuA4XAxVxq6hLK29pYrUUvluyIE46C5fC
	 msvyqEVerDbGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 04DD140518;
	Mon, 28 Sep 2026 21:25:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A80DF72
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 21:25:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9998760638
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 21:25:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cSIeLJFCmU-C for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 21:25:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DD28660607
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790630741;
 b=nRgFz6PXcXl1OpYFhVPqWs3TMbIeQ2TeCPb/Fx9zfPV20JQ6J2SFDTjor5uA4l7V7RSB
 eLsJwHWVvKQtAfcj756VDNN7UjsBYK27mKAQuhP6cRFVPASl3zV3I6lwNiBbTHoWTIEif
 3KkJ7pdS8KxADfObAXEvMR6LXE5GdNuo9k1T3F2I08jIaBJlGHp+KzO77EBnWAWHm8w5x
 GH79yiKvfWqXfaZEf5/cQ2wVKLq9+AGgFFAVBqoupk0ohUZyHTedwIw0LMscfriPok8Xr
 GhljcA9dg2N/2I+SuMnLFQ5472Cpui27IA+VjZ0d9+yOOxUz5zH9E1u2F2RHdTqf67A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790630741;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=2ZTG0TUysWPbaVjvpq51PIZRN4jh00vPdAy9g6h+f98=;
 b=jOv9YHKqTmXtOsD07X0Z+h4gTKNzLHyNGNtu4xLusJUcQTY2oGoIKTOU36oFrfm6Q1mT
 gGVJFA7qSw1GevLJ9px2dhjU11yGyDoEBMq5khm/ysVNgD7pfd6S9dL9VQySxvDRSbGvL
 8Htg/Mw4i8Cu5DjpgebH7AgUf34+nTMUtNZz2ijWrkbkn90+nOqdL4jQYvLMhOiJnVIk5
 /6gwp3QqejN2iqcMQEF1UVFiXWHTLHVc36SxgNMqels7/2LfnRV9DcWIcWFiSZTM9C0s0
 LVAQ/jV5UpyWiJb/YOcNGiYU0MhiuiyqAdYwa6zTd0ABh4UDg/e5OzCGtJaTIKQxKSg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=UOmnNXxb; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::f;
 helo=mail-oa2-x0f.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=UOmnNXxb
Received: from mail-oa2-x0f.google.com (mail-oa2-x0f.google.com
 [IPv6:2607:f8b0:4864:30::f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DD28660607
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 21:25:40 +0000 (UTC)
Received: by mail-oa2-x0f.google.com with SMTP id
 586e51a60fabf-493cf6d8e60so1385292fac.3
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790630739; x=1791235539;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2ZTG0TUysWPbaVjvpq51PIZRN4jh00vPdAy9g6h+f98=;
 b=UOmnNXxbOR4GIsBVXet4tB7bzr90Ht3A+kVmuMIfuaM/59GKGQMpwPFD2vfs+2ciP2
 p53q/B3+S2OUIfrb7yPywEcMF7ye/yVPzzDHSxjxfP7zdfksg08y+BAdK2ysR/qCb+RV
 BQ+LQWkzeR7ouKa6t0f36mF2mJw6qHUF7qjrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790630739; x=1791235539;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2ZTG0TUysWPbaVjvpq51PIZRN4jh00vPdAy9g6h+f98=;
 b=YYahdntt2fOOvNJ+FjNiWras+F9lnMgXib09BPwBIQiTeX0YdvVwhIt+VhHweOTFQM
 IlluNRULJgFIyo+zN8oCWXW08US04xgucLzqFwe+mbgi0M1GwDDo4x7OL72h5J7G9rLf
 AwvRUK5wlQ6QeipFj27zxMcWZxmVwKOiTV27840OCVvCCUPqF6E9eir4exP4+uDVp2z+
 L8ajm7otQ+zX0izuc7UW1eVFGaR2kFFV7wdrq3lz+m5A2+0vKd4UH1akjIqQc6nZLgxq
 ZF06kccCB2ZZCMWTRWHNvSBK3w6aGN5ijfdtZfPhT2pImv7s+Q37SSjUPEdEdyNbKbTH
 ikkw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzlEPrNPkaUGJ76wU8tn+EpB+xWd4SuNu60aBpcwGQekUVtP6UT7Ij+0ULf+cYIQIlFpPZJ7C0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJkbJl8tL1uf+15R/0k0EXzCn0DgVZfyiSXOsCIH3jYHQJ1ohjU
 DtBfVlozU68DLf14H9crUOJnaCS3QURVfASKws3aFcFdMoSfv2QdM4wRuR0FzvXjbMM=
X-Gm-Gg: AYBFou1s00iLEWSdFIr6OEAoZdkTe74cgpm28ZCTK9z01rwyjNE5Dqr5X/TwA+ss8zS
 C+ZTOknaYAAOmhNeX1ZRYTvjNF/W/osSWf8N40ymgA3u5gNunnBq3dP1c2vILtNu3uK02D4DTCm
 wYuUYtUrUojcEmbeJQmcja2fuPpnNEdVqxLoesapxnNOVgnPg3jpCkCd6ZFNvCbOoV7L7vkJMcL
 A/HaC7MHRrWbK4ZwQGUHFU70kTCB73Nplx2lnZ0hWKVAuvbX1GGvrPnDxrfVJGrpZov0FHRfH/L
 IOGydLFUtgT7/YGlKPjZs9vu4EUeqUHikW7c7F9R53asfU/2dyo3Dysq3EEPooSJOj9HZ6cZTCA
 OWeBluShaaLl7Jzsc0IUY8YcGAWmsBHJE+ZEFyJr1k95OFMhvXUOq6J2xK0gZOXeq/Z4Z+E2e4U
 mQh/33SrF87HslCkLE0m1HQFZbm6NSENQ+UtEKTSXWgLP23th/EU8yN8turf+AFUHNmwQLBVE2N
 N63GwSTpIRmrnmQjjgiZS4HgdbpuBCKz0FeLa3+xmdpIE51DHL4MFLVZSqxHXrOwogJ8A9zdYtN
 pGXbDcJV2xyquUV64bkC2R22kZo9Tw==
X-Received: by 2002:a05:6871:a0c1:b0:48f:e0f6:c45b with SMTP id
 586e51a60fabf-4935820decemr9288647fac.41.1790630739218; 
 Mon, 28 Sep 2026 14:25:39 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-49347da3079sm10326042fac.14.2026.09.28.14.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 14:25:38 -0700 (PDT)
Date: Mon, 28 Sep 2026 15:25:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, mkorpershoek@kernel.org, lukma@denx.de,
 marex@denx.de, balaji.selvanathan@oss.qualcomm.com,
 jbx6244@gmail.com, vandhiadevan.karunamoorthy@oss.qualcomm.com,
 dario.binacchi@amarulasolutions.com, sjg@chromium.org,
 pbrobinson@gmail.com, quentin.schulz@cherry.de,
 varadarajan.narayanan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: Re: [PATCH v1 4/8] cmd: gpt: support setting full 64-bit GPT
 partition attributes
Message-ID: <20260928212535.GT858934@bill-the-cat>
References: <20260928064041.1432227-1-sumit.dhami@oss.qualcomm.com>
 <20260928064041.1432227-5-sumit.dhami@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lUwuxefiDSBpfjlZ"
Content-Disposition: inline
In-Reply-To: <20260928064041.1432227-5-sumit.dhami@oss.qualcomm.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--lUwuxefiDSBpfjlZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 12:10:37PM +0530, Sumit Singh Dhami wrote:
> The 'gpt write' partition list syntax only allows setting the legacy
> BIOS-bootable bit via the 'bootable' key.
>=20
> Parse an optional 'attrs=3D<value>' key when CONFIG_PARTITION_ATTR is
> enabled and store it via disk_partition_set_gpt_attr(),
> so that gpt_fill_pte() writes the requested 64-bit attributes value
> into the partition's GPT entry.
>=20
> Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
> ---
>  cmd/gpt.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/cmd/gpt.c b/cmd/gpt.c
> index 205f696c807..f610c7aa6b5 100644
> --- a/cmd/gpt.c
> +++ b/cmd/gpt.c
> @@ -592,6 +592,17 @@ static int set_gpt_info(struct blk_desc *dev_desc,
> =20
>  		offset +=3D parts[i].size + parts[i].start;
> =20
> +		if (CONFIG_IS_ENABLED(PARTITION_ATTR)) {
> +			/* attrs */
> +			val =3D extract_val(tok, "attrs");
> +			if (val) {	/* 'attrs' is optional */
> +				if (extract_env(val, &p))
> +					p =3D val;
> +				disk_partition_set_gpt_attr(&parts[i], simple_strtoull(p, NULL, 0));

I'm pointing it out here and assuming you'll check the rest of the
series, checkpatch should have complained about this line being too
long, please fix globally, thanks.

--=20
Tom

--lUwuxefiDSBpfjlZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCarrbTwAKCRAr4qD1Cr/k
Cri6AQC+yguOQ3SF9mreyTh0luudHiE7z7Bk7cUiX+geYzdtZAEA+4RYDbeEQIHH
vpFt+LRac5Vq8hXqovaG/uG4a+jX8AM=
=LeIM
-----END PGP SIGNATURE-----

--lUwuxefiDSBpfjlZ--
