Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AB4606A336
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 16:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BePU2wyi;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=raSJfpgK
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E1F0240761;
	Thu, 22 Oct 2026 16:51:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DBxtjTPXMf3H; Thu, 22 Oct 2026 16:51:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 47DD64072E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792687900;
	b=sbsf8LiLrtB99MYfOQd4qEoKa6EZL+TDsCl/aBFYhKGwiRcYpmRt6J6RwuNdmf6ekgfa
	 u+4eTOEEFs48Hk4OcyxghfixjJ0xdnf6jD+knOTfiNSd1cmbPXB38y49as3jZNUfPsZSJ
	 SDL0DreDsM2anRaPO5dJzJJVOVkgiNj55U1IdF3kJZQChgoqMpDSdEOg+qyTwnt0n1tHw
	 tXu4yxSh2/Ui/TwHmjq7dE6g0RQqrVpjIJ9f8kpi3Vmp2RlFXr9p2EzOUDI5+UydNNMar
	 7UG83UVzpv1IzgGcyp4W+T9myQgcv7x9pFmmEfysAqyirnz2crksB9rL9V5mFOm9tMw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792687900;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jyjvKU4oq8NcVTOB/xZq6R41/ymQze8pxF6xnxB9PeY=;
	b=o7sqyOFZwse5vVHujhFeRv791i+TQT+94+F2tYLmFkZvjB167UvW1daGcOkAVFSg8aUi
	 qnANWwNXYkod3Wwkw+oWi20wAajUA4xpB4ARzrDcFB0gzRsKsxyZfh6wVRIlht+pdc/7s
	 gw+lOhiWC+/YvnHhJcWoCcrqgpfRALmOVvkSmqzQIqdV4QJuULFnAekWuLNWtIaDaMh7c
	 Av4SqH3IPlAba6M1M6vZp5ZS50jmI/HvMSfBiRJtazXy2dgSTqspQrYRY1unClNS90yQ/
	 SutdGGv09HlQvQ8ELkNh5cI8Ye0haOIXcObh6IKl/WR9wbn7m4jvrBemgGHge5UmXMg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792687900;
	bh=jyjvKU4oq8NcVTOB/xZq6R41/ymQze8pxF6xnxB9PeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BePU2wyiSrFORORV41gB/Z5M0Bh1OEQdSw+MZzAT/zbEozKyKQWncSc2ciCIPTKQ8
	 Jrx0YPrmINgq3rWB6xMYhb6upUOJ/LqEJ7lm5c/qqRMC2aoOGWLcB2uIAho0M9xVY8
	 YFxbeI+8JI9FdbNY9Rb8C9lkQ5Lyk/gbjtqoMKhpAvi22qUaVsihzC1WhLllh8ZFSY
	 tOUP/J3cRgZQro+SrYiGKa0FiP4ivTuLSnju2mvkt8RAkwqnuZ/yIO8kJLBs8q8HVl
	 Yv0H5bCj2cWueOdbEfobP67swmk23mVN43+li5OCHsORttH/4eloKrhxCaT027vpCb
	 w/XhxbV71cniA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 47DD64072E;
	Thu, 22 Oct 2026 16:51:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 271683AF
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:51:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0D5174016D
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:51:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dp97uBeQVbro for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 16:51:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5677F40122
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792687898;
 b=I8LXSg5Z6yJTx8mhO6gwqDHO/I0W5FxEHMMd6dU73pjeJqFIqV5ACEnYOAVMSzdwX4G5
 bNhKmrJ+dKGMPlilFEGgLognwurzfgxni1nBCHogOKArag8JPmkVHMvmyyP77f0EbJ6uN
 13Z+voVOd/ek0Oc8i5bmY61rjBorGa2CJoMD9AUVrXTrCkVtxr0s/jYg9JiIV/lZ3Sq0h
 I3l5Sr55LMhvpM2iQIdOw/rYBfJFiJx0o5dUD0EYLHP+XBpCUqbPa/HBFz93UNKSdxt/9
 ggiSiOJ6SYEgvLR2qIXyeXGt8gvXL8y+jdBzIwsvtWo1WAvE+1ouQVGdF0xZL/1vuAg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792687898;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=jyjvKU4oq8NcVTOB/xZq6R41/ymQze8pxF6xnxB9PeY=;
 b=aVPsdv2mXrD9RzGucnvttsCGqeLEfNJhq5VR5h1eaAMi15LT1/uF6ZJ52EvjAwyFG56n
 6Sy1DeHLuadlGh51fjMJsqtIdmaGi4GpYwtWfAYANWSV/R+VH+o4Npv+U19ZYj8x5lARw
 pQjCWa4XJQhg9Syjw0TKD+oafVS2LiTrOu3RJlkuzwnt3n4XzceFFXy+tUhjKsnTyL5wd
 ghg42H2UL+pY7Nh8gOgK4ah7GvxGhUjvXKq2mzyKZwUBmKrger98sVnPl36nAVS7n+Hon
 0+m9gC+CqjDx7Q+F2rR73Xy/P8qOMuC9JFuxOzXyYOT12vFDQ3Yx9dUuGHZYHMRJIEA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=raSJfpgK; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2f; helo=mail-oo1-xc2f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=raSJfpgK
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5677F40122
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:51:37 +0000 (UTC)
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-6dd7070699eso3317eaf.3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 09:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792687897; x=1793292697;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jyjvKU4oq8NcVTOB/xZq6R41/ymQze8pxF6xnxB9PeY=;
 b=raSJfpgKdsNHUXKbKUP/Rawq/GjuprHoh4wYpJkIZOxV0/2iTH9JhIrmXMfzCq8cia
 XoKNZC+8qILvFNVQn0YK6oG4agVtAGT+g8ue4tprDkaD6lQzVJYcn06XOdSWA8gKgDvo
 uiohXoAYZMW0ZqFcpEPac4H4GQsx4OdMg6jnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792687897; x=1793292697;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jyjvKU4oq8NcVTOB/xZq6R41/ymQze8pxF6xnxB9PeY=;
 b=Pxi4DzeHXcBcLEamWbwQCQ32YlPECRMUl104hx3rTdgpf8purVyJnkAdL4ecqrZM4f
 RdUFYEM0WcKblxx6x5TDXQW9bdbiYoJs0xVVBawExFFFtjOp4FzhjfrDiIfJYNqkDBUC
 P6ozM07wTYwNcS3LxL36tpBQG2MVuAhcywXBgRNqfF2Z6ma3DYQRVkK5LhL8gAnAgyx3
 PiFtDeDjO+l/2bLo/arJFeaKSZfWn4ntlj28epEdXbATA9iA1lwABsSpDwR6TksFIilb
 1FKQ5y4aI4H2LqxM8NNrrLnccoFyPjrfVeT8Oqj4aCxsBrrT9X64W8ZL2W83hPKor1d2
 W9HA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzb12SgN/QuF5ME1i1K5muWWXWFATXbeYZcqaKOa+0VSHB2w546cVHlND3LymUFdvowhWKwxJQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLt6AhY4CyajdrcFnsMd4wbfJl0T9z4++8thPpSJrLq8CQxs8Dg
 MS6Lu1J3zQHZf4rcUTMY+fPozWzV3EYp2AWppNqpUtX0PrjdR2IaMxmXOH4w7APbQ8o=
X-Gm-Gg: AYBFou1tNA+DRpVpPsmE1JhTKpWhKmauTS4U+tqPCG8yD8kTF2WQHs+vDZYiyraBKZj
 gjMN7bzTogbQfopHTBonzSz+enV4HLRcwSnfqL/ukOyAgUQ9G7+2Iajt1Xp0tZ1uoLXYTvKJqPY
 wyASBrw0PsBSZMvedxPJ6G1/jGrRaq5NFrFfY3p5KJOPQZ+ZcZw1x3hffUTwPRKTM6ORw0xdZcM
 sH6JbvQNsZdI8MrKkvwP5Uxlm8ZoFeUq5ROIXWzwLwPZ76qwbJDTWrxhDCSzJ2bTpX7tf5bHXrH
 G9wz4ji6w/j6gv4Fr8Ibvn4suwgQBgrp9kgYxQasiCL9VajQPF4plq4kDJbqpFOZL/r6GYrxjXX
 z0ntzKW3+dsI1klqznR5HghLHvSiKx1CZS9Z0El5erooG02XnLel6aO9AbYXn4axL3EJUSkaZfo
 S613EVWsTDx6V3+vAZ0heuoLvsqB42yZMShbVu1XPRCgIiDIKpbNK7EFAr7uY+uX3iuIKUNCOZZ
 JIErDXLwOZURsjwZSZRGPofvrid3mMSpkpxpKb3HngE8eGbfxHccqBKKXxGMTJtZ3t3Mfzp2Uc5
 dMfnEOhjDBK67SPZSSSQJeeVSwdlRYUILOtTPF40dHEUNyPU264EZkHBZRPXvcxbnn1Q1yFZy7K
 X
X-Received: by 2002:a05:6820:c0d9:10b0:6e7:9606:6c07 with SMTP id
 006d021491bc7-70941629c46mr2698511eaf.74.1792687896935; 
 Thu, 22 Oct 2026 09:51:36 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-70a543c313fsm2505048eaf.12.2026.10.22.09.51.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 09:51:36 -0700 (PDT)
Date: Thu, 22 Oct 2026 10:51:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, Michael.Srba@seznam.cz,
 william.bright@imd-tec.com, luca.weiss@fairphone.com,
 nikroks@mainlining.org, nathbappai@gmail.com,
 macpaul.lin@mediatek.com, jbx6244@gmail.com, dlechner@baylibre.com,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v4 06/12] configs: qcom: enable PHY_QCOM_QMP_USB3_LEGACY
Message-ID: <20261022165133.GB3621697@bill-the-cat>
References: <20261021160916.3894471-1-aswin.murugan@oss.qualcomm.com>
 <20261021160916.3894471-7-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BpUcCUdYxcffBosm"
Content-Disposition: inline
In-Reply-To: <20261021160916.3894471-7-aswin.murugan@oss.qualcomm.com>
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


--BpUcCUdYxcffBosm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 09:39:10PM +0530, Aswin Murugan wrote:

> Enable the QMP USB3 PHY driver in the Qualcomm common defconfig.
>=20
> This allows USB3 PHY initialization support when the corresponding
> platform DT is enabled.
>=20
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>  configs/qcom_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index cc66bf96f51..2655eaece1d 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -115,6 +115,7 @@ CONFIG_PHY_MICREL_KSZ90X1=3Dy
>  CONFIG_PHY=3Dy
>  CONFIG_PHY_QCOM_QMP_UFS=3Dy
>  CONFIG_PHY_QCOM_QUSB2=3Dy
> +CONFIG_PHY_QCOM_QMP_USB3_LEGACY=3Dy
>  CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=3Dy
>  CONFIG_PHY_QCOM_SNPS_EUSB2=3Dy
>  CONFIG_PINCTRL=3Dy

Setting aside the resolution to Neil's question, we should just have one
patch that enables what the board needs, not several. Logical groupings
while keeping the overall series small is the goal.

--=20
Tom

--BpUcCUdYxcffBosm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCato/FQAKCRAr4qD1Cr/k
CvF6AP974c0r19A5rJIlA9fZREA2bJmFUCSZiR8jdC33objFGwEA+K/iJ3RgfgYl
4A7zHg18p+yGMvniBg9sqzT4Yb5EaQg=
=ur2e
-----END PGP SIGNATURE-----

--BpUcCUdYxcffBosm--
