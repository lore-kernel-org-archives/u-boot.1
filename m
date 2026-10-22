Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9E4606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 16:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Grn9XYha;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=tGn0v2I9
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 94B49403EA;
	Thu, 22 Oct 2026 16:23:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pixLs3uv-s5F; Thu, 22 Oct 2026 16:23:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D185C403F0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792686230;
	b=R2uSpbRMhPMisIYFaagOmfpRzrg5xzOF/KGshdSrazoQBYmUtrIvXIZUYz+x0tBIXOT7
	 AUk5BIq6sJGkxzy6ZHZk+q/fLBxSUNjLmZe5CZTgG2K+vCLnsBmwJWNQ41UyGhj2v9CF8
	 qoKyW9m+50XAF65btmPe2QkwQlHK7OLGFLU9Ua0wt6SCH/JEVh450R52bZefRDG9EKJfY
	 kHbs7/Y1IF8J3EmwQxR6Zb/Mo1EVcd4Sn/MgPyc8tdVjlnAkd/B0Tr24EZisKh2wqd9vD
	 bIgvrEESaY6I7hqCNxLkmWF7UMb6C1ng3VJc4Vs+1NE9SFCcyi6tmQZPynphxyKMK+A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792686230;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xRD7FKH1wZpbgWhJW6JxH7/gPVqxFpeO2Tk2QixSpDo=;
	b=YVKcHHJfM3nLmaMm+oYxlPtinH2CR3DpqqiUnQTzRMUeFbDwm9ifLz99qu9SbtjZrGvP
	 zzSldKPXdKovA5j7NWuSyIJCScMFqlPwydm9Q39IZmfhv06u5qske3ms3AJvYd0F8h/v3
	 gOlwBVVznt2xdu43dvzODESed/V8lzBaOnNH6yk/XAowoQHm821OSbHmDT/MZXAfS5IKr
	 jqnIcwxOiDsELfV28v5SD0IOjBVQRDW/+Dcr0CsPaYe+X/T+HlOphiw91Mr2bUkRrE9Oi
	 3Fz8uiwpNrZcbffb7f8lXdQyji7J16jG9gzhCsSth9Z7zQqzAWRwttZ9uS7mAdhIL2Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792686230;
	bh=xRD7FKH1wZpbgWhJW6JxH7/gPVqxFpeO2Tk2QixSpDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Grn9XYhavn0Hu9wU7c/MPLnC/s9hPdT4SSJfJpUrLHohncLwnv6el/ZiwJpnMZKgc
	 89E+SxiXwWfIvND6LCBX1beg8e246Yp+vbvZVE43zjqPwvrAHVElBVJN1JLYGbVRyZ
	 t2xRq+DurZiCRjUEyavyKLt+tFG830e43etKA0hLtYulKcSdgBc+Bbe77w+q3lQUoz
	 +RTjAqqoXsdWzP1b+ApKeTv8Gy2DtWxc5f3sgDHkzZBYSH5lXxJO9uIyzef/cpXprk
	 EpCzthIV6t1ZSspzj+jhLFh/ug3G7xLmgPnGY1GFIp7RXn+FBG/MZKr3xvrjF31HZN
	 GgZyoYPh8canw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D185C403F0;
	Thu, 22 Oct 2026 16:23:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D006769
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:23:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3F4A44016D
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:23:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3MAefM-vUUiV for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 16:23:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7A3F140122
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::34"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792686227;
 b=e87qiL29wJsqc6EB03I7oWH1mEqUdwHTq6WYjCRtb7+rnqlKYAUEl4WlnS9sMT712Ctz
 MyRr1Dp0KSBCfe5+0mqMtNR/DlAbZPXtg3b5hyF7A+izuHzbvf/bFDDmlv59QiB5QBKZ5
 ooCaz23HzOL4RZBWItiWr7COriB7kZQV8Ib7LbtMaIL6B7ETZ/aMDsMicPnETzSsn4LAp
 25h80+twBNKdxz4xYRP0SJ/0RVOoif0S5BkRyU1LDbyNyYLJUN28CEz+Ssee6zgdo21k/
 bJyz4ea9IWUn4z8mIfuyaB6rTydx7qZ3l4Kdae6vWmxqLfHnB0aH/cWOeJB82Pzlx6g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792686227;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=xRD7FKH1wZpbgWhJW6JxH7/gPVqxFpeO2Tk2QixSpDo=;
 b=agYHKLJImgCUNqJsgTot1vPeFiFucB224ovJuIO54up6feLelko+TN/tuidOWJQjI3xp
 DZ+tf8NFPI6JvNK2FOK1CpxNcZRiXHgEzSqsYQLZ/45tIK32S/4YTFI/6fdwGMOY65wT1
 wGxbCFBbOwreMlxCaBjNK0mV2rGJggEM7JePIxp5tXBBu4QqgnuADpJ9Q5LpZmrtQc8zj
 eyjD6bIzI2E5MFammm5vGf6zI4S2god6ob62B+gReb9kpvuT7gWpKK58XGf74ljO9ubsm
 PDwVf4hxNEKxewYQTkX/VrUKCkUxG4GkK6uZsB2DsNLNz4Mbsq7yvMy9qDxhyltbJow==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=tGn0v2I9; 
 arc=none smtp.remote-ip="2001:4860:4864:20::34"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::34; helo=mail-oa1-x34.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=tGn0v2I9
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7A3F140122
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:23:47 +0000 (UTC)
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-483c607ccb4so17130fac.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 09:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792686226; x=1793291026;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xRD7FKH1wZpbgWhJW6JxH7/gPVqxFpeO2Tk2QixSpDo=;
 b=tGn0v2I9PWWmKDHZ69DM+YPGCm8Us7hVKqh2Q9l+V3hegxTF5smVJDllxZya5ZkG2R
 +thLYNx5N0l773mT1Y/dNgE9GvOhz7yOIBaIs/BxI4bIwL2gAzIaCbK5f1uHdPz9uPNM
 aODj2yVYtJJC2cREjpm30MRBN52XY0TF5liw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792686226; x=1793291026;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xRD7FKH1wZpbgWhJW6JxH7/gPVqxFpeO2Tk2QixSpDo=;
 b=n1YD+KStu6bX/6CW06ZBwL2ds7uQzgRkxgvYHzOpvPzF0GwgzOKKmOfkBJwANZp7DZ
 7t/6YG7c/opUfYP3wcRMsxB0dK84dLCcJ+XOU8ecrB3vTGxkd7FDLbVgulxCDz556aNt
 oIufs8HU2g1SG2pv6HwkQ+aZBRvL40s79eE7/4pCiQwbLTEQJuTWlOU+xHps+0AgJ4FX
 r/RzJE0R5iJN4e/28hl5sbcKX/64ZQmpfBXJRprpp10exjbcK54buMPaRQ9Z5B22I7h2
 4t1I0uf7jnPIHrWB39RnLf59C2mWSwoVMg9Jw/VBz7FYEuI5O1Ku/E929LEVD4dg+Pn8
 03jA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxBno+G8LWqM9ireLfK2j6IhXiNqXH7QHdagXHudPuPhPV/h9k0XiKB4OpN78S6U9KOKEiYEY8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLXL3Eb8bEB66HvO6h0pXZQf8oBJVRVp8JZKp25ilB8TlUPETe9
 dyEKrEM76FiZpzZeCbJbqjc/eNd/SSVVAViVHBxtF/JOFqWXsSLWRmPvXTJqRpRTozA=
X-Gm-Gg: AYBFou16DURakwgSly14tIcQ2xq7RqEq/sZUiBvFB6HtuAiIWF21msiY5i7RGrlP3l4
 EJKls/kVIHVaz5gGy4gJNIHswihBjo3K+pfmfc5ULt/OEfowDsDjXAMeuuHRY3JKZ6vUQgClnQ/
 3pRKqb4iypDMnFD4iOmYttPx5FlidBHFMM1dIc4wNhf72/4cBrlqfCgSlG2c4XinyoHc8QQ0aln
 qscc3dmdyog5OEdETUJhyqhoRrN/J6eonVPvmMrRlmslYvzyOeb8uGKk1bHOxNL7d+oViuMRwSV
 QuKfGF/FG3vZq2Er1PrmDQqCgcihxh/en5OuNBpXvbLQ4nMT1WNqL2+Itq32V6eAmdQWBz2Mra2
 TTKv79g6la29WEO/AY0kQQDXoa7Y/k9MKIK8f/3NmPFCM81gzfmses11hJBn1yOHVrDpGkN99Dy
 adgNN7hppU0q35Tq9fDNMrEI3r+21E05BmiAaoPFqTB6qo99LMdVMGsCpECmYcy8YMlrfOBnUuv
 09m1YbJrhwzOvcKUntslrogSorcuHG5b0ramF3ncR9oZaIFjoMTJvBAk371BvWXsyrIsGVr8M+S
 Dk3PmPjNtSDsHt0Qve7Dc+tKkL7zqjY/Ry7HPRtd5r+PMIeN+w6g/vh1K14D8suUzhQoEa426rb
 w
X-Received: by 2002:a05:6808:178d:b0:53a:ad3c:17a2 with SMTP id
 5614622812f47-5535d9b5a5fmr3843618b6e.40.1792686226023; 
 Thu, 22 Oct 2026 09:23:46 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-552b7176907sm4923077b6e.12.2026.10.22.09.23.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 09:23:45 -0700 (PDT)
Date: Thu, 22 Oct 2026 10:23:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/2] qcom: qcs615: disable SCSI and use MMC for fastboot
Message-ID: <20261022162342.GA3613884@bill-the-cat>
References: <20261009-talos_mmc-v2-0-5d01c3428bee@oss.qualcomm.com>
 <20261009-talos_mmc-v2-1-5d01c3428bee@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+SKUnuKRVa0NkcNn"
Content-Disposition: inline
In-Reply-To: <20261009-talos_mmc-v2-1-5d01c3428bee@oss.qualcomm.com>
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


--+SKUnuKRVa0NkcNn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 09, 2026 at 07:02:23AM +0530, Balaji Selvanathan wrote:

> QCS615 platforms are equipped with eMMC storage only and do not
> support UFS or other SCSI-backed devices.
>=20
> Disable SCSI support and set fastboot settings to use the MMC
> block interface with device 0.
>=20
> Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  configs/qcom_qcs615_defconfig | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/configs/qcom_qcs615_defconfig b/configs/qcom_qcs615_defconfig
> index ccc3bf24ab1..a0aa019316c 100644
> --- a/configs/qcom_qcs615_defconfig
> +++ b/configs/qcom_qcs615_defconfig
> @@ -24,3 +24,9 @@ CONFIG_TEXT_BASE=3D0x9fc00000
>  CONFIG_FASTBOOT_BUF_ADDR=3D0xa1600000
> =20
>  CONFIG_WATCHDOG_AUTOSTART=3Dy
> +
> +# CONFIG_SCSI is not set
> +
> +# QCS615 has eMMC only, not UFS/SCSI - override qcom_defconfig settings
> +CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME=3D"mmc"
> +CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID=3D0

So I looked at this and asked myself, why are we adding comments? And I
see it's because we're starting with the intended to run anywhere
qcom_defconfig. Still, documentation of what / why belongs in the docs
files, and not the defconfig. It doesn't get lost here because they
don't get re-synced automatically but it still encourages other people
to do this on boards that do get resynced.

--=20
Tom

--+SKUnuKRVa0NkcNn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCato4iwAKCRAr4qD1Cr/k
CiotAQC9iEDC728HqzrAmEgTUDSydzM5w9CLC0UIcrc+VD8gAQD/cC0jQGOjpHu0
iLzo0qvds+LF4NWRmEcRIZGdglm8yQI=
=k2Yg
-----END PGP SIGNATURE-----

--+SKUnuKRVa0NkcNn--
