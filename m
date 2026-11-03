Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B265606A7B3
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 15:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ko1yDaKF;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=mPwxMv8h
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BC1E26070F;
	Tue,  3 Nov 2026 15:20:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dl9Z-uzqXCaL; Tue,  3 Nov 2026 15:20:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E67DC606D5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793719249;
	b=ZHGCZ1NV77+1cnpGVXR+R/RxLY3UesRKsA+S+ljMkky2RtIpQbIrASd2Svcsqv16nqai
	 jY2tcZFloqqGYO6b9f7Nj0rAlVxcpk3ydxQ+R4KnrP37iz7virBhc2MWo6CGn4tWN5Zpe
	 3KnrNRAajrZYTEof91hgalqUXrSA49QaWtog2eN98ItLGeGN6t+B85MSL0PWSdf4Infws
	 d6G7Dz9rLIdqEEn8MGGLt7Sn2geo4QnOFKWsStcBpl2+b5tBLWgHRgWMC2RDcffkJqF51
	 BXDjsons7PSJjryD0hBCaKbnCf1j7jPUX9ZU95hiTuwm71LXodUMfIEzbWxz+FGxHFA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793719249;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6KdpDAARJUtCHd3AVgB2XV/YY6ml0iLA1U+dwPI+MB0=;
	b=mTigmt4Bqv2UeI/4SXoo3scBsirbd8SL0JBGaaMXEZJJZ74vYuTT3VlX6x3aa7Si+92D
	 wYEBVlY5F6lHm+INYXUrT/nG/Qc0d/lnLNkVXhyWQld6EU2KXqIWZWTJf5ZQv+M02OWw+
	 SqdZXhBghXlE0hI3BdEMaP1iXET0WrmMYUfKtI+jixjZKuO1pzJbq49TQ+s+OUWVZjhXI
	 +snEDIB4zyT7I9b45gLS81035N5plwUZu9ZlcODWbiakPvgK13iukvM5uG5zpYEWP7AQw
	 tHvzHe+gOz9JzI7jpXK4mpOhzaSnlIpxFkwNFKsxZY60N7ohBnTlvDCYZvj2cjYahfg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793719249;
	bh=6KdpDAARJUtCHd3AVgB2XV/YY6ml0iLA1U+dwPI+MB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ko1yDaKF618NJgLJyBcur8I7DEpisIAllfYdVjAMyw/L0NzHvuAlmZPrxByiSRtbu
	 EtD2Q5Qh3FKiMy/EtL6+M3yNiDXbaQhimk+2B7ZtakRgxXnAujvXFFyNMw1SAuXqt/
	 19eCe/Cg0VEfvEDWRKfjs0L4P2ilIb54FWJX50tjb9oj1q892bf0Yc2hNo4ArQ+lfd
	 +ahCygZ8wlsw5FEVA7HkNURVx91WA2exo9OilsAcsvovFVNT4perqxxQ1hp2ckhtGB
	 yKSFWbzTXUOtysabQdiociQvgCXqZ4s7b/4r1BktIX27NBV6HqWNeJL6R6JCYrrIXK
	 K3aDec0DKuheg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E67DC606D5;
	Tue,  3 Nov 2026 15:20:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F4C1235
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:20:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 60D8A4062F
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:20:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BNCpcOjtye31 for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 15:20:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8C41640612
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793719246;
 b=ruYPjLXovBh+cNfXjbzXEl8tICRozaFeiSkTdSg3vQ8J3XwWMsCmxPIZVxb7RIJk0qnD
 8bX8kBEYrhUpUcdCdzeEszaYWMBpcQbGDRlSXaReU0X8HKT0m8aa5+U/jpDqH1wug6NCL
 0GyYxi0JFgfXVUZVWTf73gffZBZzCE7wxxexnX4IKqyfpyTzJtAE3QRJJa28BpproaRYZ
 6Wo047yrsF8SxTB7z/devg1Ma/zYWZvxjIUH6rMTFS93CBK+bSKmvSrBhOdMUllAQTBe5
 W1fpnhUYCl+7ZKugQ2BsCalsW9WX6VufCDyuZhPOTg57XMREuBhCrIOUvOArffY3u1w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793719246;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=6KdpDAARJUtCHd3AVgB2XV/YY6ml0iLA1U+dwPI+MB0=;
 b=j2y6/14HpLAv3cy0gZmsRR0qna1YUFRL53q7gSYLhabV3PLP8KZtzWb2V9IVvQxEWUsC
 WkI1jCQHbODes5vhtB+51bJiJZjuzgTDOFKjyEhz3Smd2UD3HUns3FromtJumHhvX2nj1
 Iz+CDVQaPMNalSos7HnEb0781Odw7N1CEwxwQf2v2c63g+76sbhX/pO53ooj4I7nblswR
 R9exmfECYlzWqyfXZYhDOrASazez8KtpH8VxkRBqHou03gncOPH9LNLDKRZst+EKZiKd/
 5ngUTB9HNItBkUz9eWVWWy7i8UZXXo0HVa3QPKr05Rt82R4d6Ph9Ar+s1APhSA+75Yw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=mPwxMv8h; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22c; helo=mail-oi1-x22c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=mPwxMv8h
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8C41640612
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:20:45 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-53ec2cc397aso2877463b6e.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 07:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793719245; x=1794324045;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6KdpDAARJUtCHd3AVgB2XV/YY6ml0iLA1U+dwPI+MB0=;
 b=mPwxMv8hqWM99Jv1wutFNF60LNZASp/ZcTbKmFVrwj0VBLVOdKOke16+DqDpXR9Z+x
 R32pewNz9Ez4b1+EbX2thVUn6PmGdhDwktoUQHNKCtqFvT+/AIgzdP6F/4Bk8RHU0UlW
 WUVS4CWBgUkukWSfhfbeZLOeUiKFkF33fObmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793719245; x=1794324045;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6KdpDAARJUtCHd3AVgB2XV/YY6ml0iLA1U+dwPI+MB0=;
 b=yA2eAoDXpb3qgMW0b6ITXV6L6K1VsJHsJVcdI7ZJ7Zffgo9AjoldUmco0WoVrC+u7l
 3+LUvEQRA0Cid1RawSy2HHIn+S79IVwFUTrjBBKdgsBBmFtZpi5rdk7mKADavll12UlL
 x4qaInxBkAukHcw5KXVuM1m1Kni/HFMeT2hdyphaPbPWwY9WDAHjC4dmswJATXs0fG7f
 eDEpHGTnVSdpwXwaNJHkKrEbAjRmwQ5HB4PFKhifm1sZcLO7NVrctI8Yxb6olrvmIumc
 3T97DRhRrGqlfSos4mnAPYahF54rLjlgJKABwk0b3V9UyXoyRIFDu1u3LgW17Y0/0BJe
 /bOA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzF9kdeS0QUBixy2XW+2QPBjT/rJVmuGlRkoCXDb5PujsJPRIhELA3GmmfKrWydTfvQ1+jsVJ4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z89Cv89KzFeoY7oR9KQRXkYRu/fqVNdRFZbYWWVp31sFtAwPX8B
 ybsj9RNqOUpHpDp6XiU+cUh5+v8B8xbJTjlS050xISiIt7YCNqhDTH/YjFcB/GWp6aI=
X-Gm-Gg: AYBFou0fF5lDSDi10WcQowWVic4gKl6hZuPcOPoJDt+uiZA03mwWztzXj4551ov6Oou
 uWRC9FERlnLYUU6E6BT865PCTY2KVhIqkUsORDnB8OwrkNwWMtVABQCz377YnlCpE8UD27OpAkb
 POwhKGNYNHkHs4K2Gi9s8v67OUOZlbXY7C6fQ8uVHXHHPKz7ANh86qDxDgJ04X/zIau7+MgGs6n
 V6M3926QG57P690mb/6UERGDrKwbO4Ud59Hhv5zflgGc610xnhi0+HmR27gPVae7mlP1kEMga9e
 fSxpAbTmchndK6izxwyB81WzL8reu+vAMzPc3ENv87XXfTfCyvLe6/h6XV7nbzrfuVR5Kd8AliF
 e8Y9OTY1UTLf/VCnKKsGA3kaykQh+pmfakIPickAZYMYZ4Pw/ZHJz3aO1EgPHc81qSkznE/Q8K0
 mPaKD85IvOheDebb7ZJWQbu1vacKEnj7Jo4PxZWURk3VVRfJytgF0jU+vLq9wn/3BChCIvjKGmZ
 xYmfy3PKno5Ud2dy2pdlPcL/d4DB37svp1rdTzkM2D7IoZOBc7ORTmqVmSVVr/hFt1Qo1zfrsQa
 1sLP6eUlXj/arOZwnffYYrDhV7uvolFozC7c4rm1I7Dg9WtDi1dMKLJuTTSxQZDA7E/oyUfn0Rf
 3IQL/0DFY3JumTeQuZcuDPCm3noEWI99n5o5jmqPLWTgOuiBDmPIy45nG4euorpsfx3a7wc+9wf
 gvY8fSX6RUSVYx5N8rOvmHnA7fGFp6I3oPO2cHU29xIGXF+WM70xc=
X-Received: by 2002:a05:6808:5387:b0:4e9:69e9:59c3 with SMTP id
 5614622812f47-5640de51253mr8945801b6e.67.1793719245015; 
 Tue, 03 Nov 2026 07:20:45 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-5640fdce8f5sm11039992b6e.7.2026.11.03.07.20.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 07:20:44 -0800 (PST)
Date: Tue, 3 Nov 2026 09:20:41 -0600
From: Tom Rini <trini@konsulko.com>
To: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
Cc: ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 aswin.murugan@oss.qualcomm.com, sjg@chromium.org,
 Michael.Srba@seznam.cz, u-boot@lists.u-boot-project.org,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, abhilash.v@oss.qualcomm.com,
 u-boot-qcom@groups.io
Subject: Re: [PATCH v3 1/1] DDR training: enabled DDR training for Shikra SPL
Message-ID: <20261103152041.GO3309461@bill-the-cat>
References: <20261103074315.2868454-1-kr.sowmiya@oss.qualcomm.com>
 <20261103074315.2868454-2-kr.sowmiya@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="c5WxP0x/SwY7kIt0"
Content-Disposition: inline
In-Reply-To: <20261103074315.2868454-2-kr.sowmiya@oss.qualcomm.com>
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


--c5WxP0x/SwY7kIt0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2026 at 01:13:15PM +0530, KR Sowmiya wrote:

> Add support for:
>=20
> Reading DDR training data from eMMC during Shikra boot flow and
> sending it to QcLIB via interface table.
>=20
> Saving DDR training data in eMMC when QcLIB performs DDR training
> and sends the data via interface table.
>=20
> Signed-off-by: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
> ---
>  arch/arm/mach-snapdragon/Kconfig              |  67 +++++++++

This part looks good now, thanks.

>  arch/arm/mach-snapdragon/board_spl.c          | 128 ++++++++++++++++++

It feels like every patch series is touching board_spl.c and adding to
it, and it's going to end up over 1000 lines. Can someone that has a
good handle on how this will look once all the current SoCs are
supported step in and suggest how to split things up into multiple
files, and then we rework these series?

[snip]
> diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdra=
gon/board_spl.c
> index 31a06b1e002..62db86fe628 100644
> --- a/arch/arm/mach-snapdragon/board_spl.c
> +++ b/arch/arm/mach-snapdragon/board_spl.c
> @@ -77,6 +77,134 @@ int qcom_spl_get_boot_blk_desc(struct blk_desc **desc=
p)
>  	return 0;
>  }
> =20
> +#if (IS_ENABLED(CONFIG_QCOM_DDR_TRAINING_SUPPORTED))

Extra parens aren't needed. In fact...

[snip]
> @@ -383,7 +384,11 @@ int qcom_spl_soc_pre_qclib_routine(void)
>  {
>  	qcom_spl_soc_shrm_reset();
> =20
> +	if (IS_ENABLED(CONFIG_QCOM_DDR_TRAINING_SUPPORTED))
> +		return qcom_spl_ddr_training_restore();
> +
>  	return 0;
> +
>  }
> =20
>  void qcom_spl_soc_rpm_reset(void)
> @@ -417,6 +422,22 @@ int qcom_spl_soc_post_qclib_routine(struct interface=
_table *table)
>  		return ret;
> =20
>  	qclib_set_ddr_sr_exit_address(entry.address);
> +
> +	if (IS_ENABLED(CONFIG_QCOM_DDR_TRAINING_SUPPORTED)) {
> +		ret =3D qcom_spl_get_iftbl_entry_by_name(table, SHIKRA_DDR_TRAINING_DA=
TA,
> +						       &entry);
> +		if (ret)
> +			return ret;
> +
> +		if (entry.attributes & QCLIB_ATTR_SAVE_TO_STORAGE) {
> +			ret =3D qcom_spl_ddr_training_save(entry.address, entry.size);
> +			if (ret) {
> +				pr_err("DDR training: save failed (%d)\n", ret);
> +				return ret;
> +			}
> +		}
> +	}
> +
>  	return 0;
>  }

We're using 'if (IS_ENABLED(...))' so that the C compiler / linker and
not the preprocessor discard the code for us, so they shouldn't be
needed at all.

--=20
Tom

--c5WxP0x/SwY7kIt0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaun7yQAKCRAr4qD1Cr/k
CliJAQCzyuloPTgoFgx374Kfsco+LeNYS7j808meatHftnvbngEAqUc/LFZn9bfE
LbE43cD+UjXzK7Bj69f8QgqtHdUmMAo=
=vKXo
-----END PGP SIGNATURE-----

--c5WxP0x/SwY7kIt0--
