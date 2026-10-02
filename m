Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 563DACA5FC4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 14:59:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1218360668;
	Fri,  2 Oct 2026 14:59:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aI7dmb13XVTc; Fri,  2 Oct 2026 14:59:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 57F7F606F5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790953155;
	b=qeohc3/d5g2Bd4qRT+wrTDgWr5DYDARQ2NYSui2p+P8SbH7/P2jQopVUh+TYWK93XYaG
	 MvlQrDzQjAPBVC7hnFpctVS4ZPgahw0HpGAwQmZiMaei7i0HnzP2W6JbxxC1eNZQWmaOz
	 kIvYenQUTmYuc1pLdFaPWUIOVc1fEmwn6K69Ki6nllSiYMCmeATZe2HciiccXCgHkBjG6
	 EiUOH7KWwSsVt2kE+zX4Xj/WtkenzkMJZC07FfkLTkk0Ynz5wQZiMAZzCgI2xMQGAZD+N
	 +bSMIUoLqqfvtVAyeJhH8Y43jpulvIK2IULUBdHqKESddmReQumQ8F2vp/Z8jl5W8EA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790953155;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TrJXAuNS0mHV66ka+gFt/jW5epPNNg6TrN+9durFt/U=;
	b=K8Hig4OOc+A9qmAp26MNCXqraziQjzjG/7eLhOxWcOQiJ+QOyXHHTgV0Kaw6tTvct6mn
	 VIHqMMZe8bdxZMDyVv1n6mpoDsG6NfXSbXrH9Ly1HzLlRhkGeRaBot3Le2Q30vk+tseVR
	 jLj6+/RxZ6YwmVcv5LJtubdX5wtE0QNSsYpzaSfJ8TcEvdYzG2KBMeM2uXpKXX7F3fH80
	 BjzF+r4H4DLWcpW6fT+IkEcSGRomJOfaFoNmy3+myM006R+YgsGZEY5e/4/edS6TquML6
	 hoba33IhP7/f91nvmgwEDar3lL1IF61EcTYYzoV2dSxB2SgLxwRoNTFn3+9Wzb0xOdg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Thqcvg5g;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790953155;
	bh=TrJXAuNS0mHV66ka+gFt/jW5epPNNg6TrN+9durFt/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MSR13ZH4QAoyHgEA0mm1zjuZbGHHFYbQLbV1Nu6ZzlATIAVsouD7YafsR7BsCOB20
	 lo8YgO9jozEckMfA1ar1eoN3zo+c4BasofptC1/7B2EAuY1EYFxwNFdWh5qSuNOVkW
	 +X2sZZL96KvrE/a/eM0PuwBG/OLfAj/VbxzwMSrwvEdftPDA/FEmgz8Nu3Y2D4ziKL
	 KIFUH5Gk3y8rnc4qJibk4y6542Xl9AYcGDLF1Vi0aqYjB+aDzT3/XbJkO8IOyF2JAH
	 tiPJ5lqXJtoUTwpau03GBIEMTJmQ/Xd3Ln21lJZZq0QAZ6dVKWeYidt19lLoqDhC44
	 vnhS6LYkbbQhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 57F7F606F5;
	Fri,  2 Oct 2026 14:59:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 630202E0
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:59:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 54C99606F5
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:59:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OANyGGK4-AXm for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 14:59:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A268960668
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790953152;
 b=hW9JNBGyOO7/Owy55HIPg5q+qHuhxSo7/i6riW5Q8eB348RSJGDwUhQQUeK3PNPtwHBX
 8eW+aIqhXyPwUe4ahV1QrC1zof5+YKYlH85fpncUDuB3UbR2ZZuVrUTTn8HeaiE78DHI/
 fRKEYMMIQKD7Do6wOtrjn2LJK6y7HNSZ0+1EPy8xBx29BZnvefKBR02cLDym84fVnwfBv
 suIn4h31khtp6rlgWTecYH5kvetxb9opRzyg5wCAr2oR4P8k7wAkOKr78nqOZpMu4X59c
 mRHiYMAWNoeQmh8e0QAWV47m+Kb4WPMXY3E3nUIzpswgAAGjwp7Egx7rNoMEuomhr/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790953152;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=TrJXAuNS0mHV66ka+gFt/jW5epPNNg6TrN+9durFt/U=;
 b=C4zklrKbwAd2nlEHxjRpV15LckQxTNC3s1PZHsmwm7iIgkiudTrdvYEcP0TW+fRZti2X
 UBLONV7OyyfzK/yc9m77mpuLBR+ssX0VjyQjQAA7M2heTYrM71HYFqAulj1rNaOJ5ys3W
 SzfgUl7wKTpq1OKQffHKqvWSYi7bJyYOLB1U0wazMZvpeJKqryM7iLShY8vYzQXEtcExg
 WDMi1H+yTPec93HqWkGPJiUrSv0cgOYD9Aq8TrWEQCly7qXodqNg8oz/yXbh+QdeF4Cj2
 ydhX10HO0qAFkQ1f3brNyxwYVkefzTcA9DHipz2plcRfiFeqepATB4VF6T9PFdLEDUQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Thqcvg5g; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::f;
 helo=mail-oo2-x0f.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Thqcvg5g
Received: from mail-oo2-x0f.google.com (mail-oo2-x0f.google.com
 [IPv6:2607:f8b0:4864:31::f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A268960668
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:59:10 +0000 (UTC)
Received: by mail-oo2-x0f.google.com with SMTP id
 006d021491bc7-6deaf09ecaeso830726eaf.1
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 07:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790953149; x=1791557949;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TrJXAuNS0mHV66ka+gFt/jW5epPNNg6TrN+9durFt/U=;
 b=Thqcvg5gEDt5tfZFFucTmtzWzy2tC/hCqMUFC7BiSBrJNKkUR8L4t+6CqYLaC2nxLA
 cEd1tN5wfSYJDrJ1WFyD/bior/WjCIRB6nOujje4VCYfEPu05lONknuE0uVspEaRd/f3
 Ha2aTc98U3WL7wvEm1TmxbpsRF/nu2Z9AD1ow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790953149; x=1791557949;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TrJXAuNS0mHV66ka+gFt/jW5epPNNg6TrN+9durFt/U=;
 b=qRSL3ceDn1GMwKEuCQM/H4OtWDT5GDUqOMDNuTeOc3YuQduDe8j9TT12iAII5ou6wI
 gTCUMM6+RR8Lyihwpc/x5+1ASAufiGHOZmy4usQcK1GafhgEA3BMLqZfh7ABIheBfgPG
 GQzDrG1uz22k8CntdUCRDZnyhyBu/M9iWHkv3tprzxDVXYFSbfs8L7fh9Esl6l9RwZoN
 E59GTO/bMzDiSLggieLX6s9HLT7qZ6vJ3q6YNSZGzHuePJK88yHX0oXvF5IeZXCMYQc2
 pVSDqDUr2AjZ82OEYH2rnc2TZ416prIdVDfNLJcpT2x2WlzRkxWTGWqfrwuidmnR6asK
 JGWA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz0qrK2zPXy0fgcLJOyxAc6mxr3x7vMOemZ334WJhozrugv1wfZrv5q//mhFUtsP1O6lkEk3xc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lUmLSj0nZF7o5F9Z1BgMjgonL7JpS5pSVyTl5qnhclJzwa8ugx
 ZVdVXJDbSLx6UH/Fa5C2n3DXLitO/EgWgeR8MX/2nUHaMLhjGVmmG+D6w/oaCLgRMTc=
X-Gm-Gg: AYBFou3xr0o/xc73l7RiwtC0U0dEKhtl1Pa6ztZjm3y0y/shYv4exT4Ot/4tphWoTUQ
 r7NEY0lcgR7kNhwgBHMNd/D/T1bN1wdPmKBOA/GiYRpdrIyEH9nPTCZOT3fFDx+eqkQY4eaT7G6
 61rwSugq4tg+a/pMUHSJt6CN8956lpo2PBscsWTe+MSNt2edhyMVzsaFRhUScbDB/cCYLB0n632
 wXAZ8Pd5h5f/RGtTC7FcZUn88nCcf/YCEKHbBo0x7NWsBdZvt4LxeZ/USWT9cGOpJ8tMbJWgTXt
 SdxDdlsrtDr5X3FXlp3tE+afq5mtsjHxDbalifcM9IpbtEDDPWaUo+0Z4m42ARznQUegkVVyG5a
 ONP/KK1jFQTCXC6v5coii23qy35Fhhhka7/aD2Hpv+4/GW9RIXmz7XaODLD9ZNi7DXiBzuj0ct8
 Rs+BR9hJflU5U99PlsWi7oTD9g1R24jjYV1Q4ghE9JIhirk4166tQfKW5JAJT/hoVJo1lO4S0KX
 gWbHuiUGz1gT2W7/uWGkVxkXtXSKkqUiW5hu88SQhNEM1p5s++/r8eE3cwrVFtjsCXrlZdpQmSc
 rQqi09NR/ESzcXzeB/g=
X-Received: by 2002:a05:6820:4dc4:b0:6e0:6c72:772 with SMTP id
 006d021491bc7-6e06c815da6mr64139eaf.13.1790953149686; 
 Fri, 02 Oct 2026 07:59:09 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8227a66650bsm2749936a34.22.2026.10.02.07.59.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 07:59:09 -0700 (PDT)
Date: Fri, 2 Oct 2026 08:59:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Qing Li <lqing2013@gmail.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 7/9] soc: qcom: smem: expose SoC identification in the
 environment
Message-ID: <20261002145907.GR858934@bill-the-cat>
References: <cover.1790887323.git.lqing2013@gmail.com>
 <cf7f290393c41e0c0afc0be2af9e1fd51876f3e0.1790887323.git.lqing2013@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2tBLzB4+ooNdiVAG"
Content-Disposition: inline
In-Reply-To: <cf7f290393c41e0c0afc0be2af9e1fd51876f3e0.1790887323.git.lqing2013@gmail.com>
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


--2tBLzB4+ooNdiVAG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 02, 2026 at 04:44:50AM +0800, Qing Li wrote:

> qcom_socinfo_init() already exports the serial number. Also export the
> socinfo id, version, raw id/version and the chip name so board scripts
> can distinguish SoC revisions and select the matching device tree
> without decoding SMEM themselves.
>=20
> Signed-off-by: Qing Li <lqing2013@gmail.com>
> ---
>  drivers/soc/qcom/smem.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> index e20523e2cec..cf433957bc2 100644
> --- a/drivers/soc/qcom/smem.c
> +++ b/drivers/soc/qcom/smem.c
> @@ -1014,6 +1014,16 @@ int qcom_socinfo_init(void)
>  		return -ENOENT;
>  	}
> =20
> +	/* Expose the SoC identification for board scripts and diagnostics */
> +	env_set_ulong("socinfo_id", le32_to_cpu(info->id));
> +	env_set_ulong("socinfo_ver", le32_to_cpu(info->ver));
> +	if (offsetof(struct socinfo, raw_id) + sizeof(info->raw_id) <=3D item_s=
ize) {
> +		env_set_ulong("socinfo_raw_id", le32_to_cpu(info->raw_id));
> +		env_set_ulong("socinfo_raw_ver", le32_to_cpu(info->raw_ver));
> +	}
> +	if (offsetof(struct socinfo, chip_id) + SMEM_SOCINFO_CHIP_ID_LENGTH <=
=3D item_size)
> +		env_set("socinfo_chip", info->chip_id);

These variables should be documented under doc/ somewhere in rST, and
done in this same patch.

--=20
Tom

--2tBLzB4+ooNdiVAG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCar/GuwAKCRAr4qD1Cr/k
CgD4AP42prCaO/SfjjXqFO6VL56kA3zVCrQKfvkLS4sNX0k53AEAngBoCpwn2u4U
y5zJh2JLKPXFM3+whHa/8htZ/9M7ogo=
=IhrQ
-----END PGP SIGNATURE-----

--2tBLzB4+ooNdiVAG--
