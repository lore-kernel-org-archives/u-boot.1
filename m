Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FCF606A584
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 16:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dlzyhoGZ;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=JcrAGG4H
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0BBA860814;
	Mon,  2 Nov 2026 16:53:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y6JecEoZDWHy; Mon,  2 Nov 2026 16:53:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 49A28607EC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793638425;
	b=C+zYswvwoYpLTWsEBuDkVZRAGRGJNnmUdoZqT5U3VEt3ZIoHSzFlm5FerGNxUNf/HMIW
	 VVHVf3bWOEUtbaC8uTnRQrfk3feQVRbIZN2Ce1u5cyKlKETI6Xp7kuvyGnYzdnobLeR4Z
	 gWH2fYtVWJxPU7P5S/br4ZurkrBGlZJ3aFWo557MwmqMUHsQpOsTXD77xAK02WFJSWNnM
	 cRKb76XH7GF3h1iNvWPfSJbH/pRcdVeLoeV97Egd/8gVEkczfLFRxdyMuHfz1f2w6Q5uy
	 auJNIU3R0qy7BIWjJALYKgdilQhMueU5yDOLUKsTARjQcfXWtrrr24lENufpPImeFcg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793638425;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dm9ThNY7uQNMr/pn2JNqg1memf1qEiTWt3kYlzyDqlg=;
	b=U7eWmWTMqGf6I33mqSJzssXG45A08Jo/CgGmxOvAnPe7SiB46+Sx2JJEI9/hKr8bpoZx
	 mLEUxg1U2Qgt8lRxTSlm6+42WFsnmoceZkq9O4f8hjHuCaif+mTcrhgQ8RQmwIBXUjmPM
	 ArG0jP4de0qjHkoMUe9TdGLwVn1Ofa/e5sDqlJNiNqEQvbA5oC6WatYsx5SrxT+AhhUdg
	 6SvGnVzTsoKxKrN3fAOF6/BcQWHgd577KQYIZ93ix6hTwcY4ga+3NcoC7gLOCyn33+Jxs
	 8nMRdSff8593tOpqwDAskbQp8fGph5B3ui98ogkRvENgihRn7sJzbuW2TrPEh6n2R9w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793638425;
	bh=dm9ThNY7uQNMr/pn2JNqg1memf1qEiTWt3kYlzyDqlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dlzyhoGZUWgs4SL/7G7zIXq22eFXV33+fj5gS3//dxs8fsarSwBCaJ5e1e0gMIMHL
	 4LFZgoFdpuL8PBnRNpQRZRRaOOti57N6tl88yRWSjaRR5uNbQCZGOsOWmneIkFhsqF
	 +qpP4UMs6l05xUrOSLevrhzXdj2xJseSbHq4l55RBY/cURv+WKnvDlk2CzCXF58lHw
	 UCaMlzlWxcQZskgCfMfIceKQf719k6+AgYj0GWEO6hGjdGUQZYZS2qnAC8/SoFJ33z
	 BUV898Ai4nk9EvNkEOl1YqBaJ3Xxxxnixf1+bxNAqgh6uHzK8i7u8Xnffkhn0S3C0u
	 Wcobj0b/27BKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 49A28607EC;
	Mon,  2 Nov 2026 16:53:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 485B0323
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:53:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2DE2940685
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:53:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nrNBxwu_FabY for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 16:53:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5A6224064F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::6"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793638422;
 b=s/lC8FXng3ftL0DuRkDmIEFIrB0LU+UAmppiErtG/DjFK7339ArskZYI26r78zh1f7Pj
 ZrIe2VTl5FfXlf8ztnoYsTKap1p4WP87NuvMC+3eCDkRnXYcdmv0kMHzrtQ00MkAZJUmw
 gOILMO2mb2E4WJqbeA/MhS/iNS9SgIeaf53SlGUQfOp6raeaJ2Dx75hkoldGGpTj6zlNv
 rCSIwlWvzccwiQjMlEK6SIOFY6FFZu1ZT84Spso3SoOV0M7hZQuAx0fu5k8/d1y0UjIUw
 lOlrMUpVZ867x2mHcGZF0fcRd84SQ/5reODOJ/tD1TA+rQQ4/wM1FZgx98V9WXdOasA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793638422;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=dm9ThNY7uQNMr/pn2JNqg1memf1qEiTWt3kYlzyDqlg=;
 b=JjiOYvhEFUPb423a8Ul8IZ/3MuW/gx0Jvnzcd2mAuvASrI8f99UtogIlgKtbl35on49G
 SXUxYL2o8LY8Jm7oIAIdRALmjnHKYIEis2oPg0sqvTQmMegqKu0PlXBiiXXFlvY/KMEZ9
 8PTYKjDZPwI3WwEZgr1C1vdWnRDSayV6tTkBlikHA6TZEkDWncHSJ9G57vH9ZxFEBb+54
 PW3+oVDCAng3AtF6cpwpREIHKn8kMtSk8CBU1GksM7t0/ajNZEkSCcVq0HtUjD6Xr2XbM
 qb6oHGRPEyYsnJHkIoDZc5qxe44rRfa7NIT4xs5JtupaK2ifVxXXnWOZ4MYi6n8YzoA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=JcrAGG4H; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::6"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::6;
 helo=mail-oo2-x06.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=JcrAGG4H
Received: from mail-oo2-x06.google.com (mail-oo2-x06.google.com
 [IPv6:2607:f8b0:4864:31::6])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5A6224064F
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:53:41 +0000 (UTC)
Received: by mail-oo2-x06.google.com with SMTP id
 46e09a7af769-8217177c5daso696236a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 08:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793638421; x=1794243221;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dm9ThNY7uQNMr/pn2JNqg1memf1qEiTWt3kYlzyDqlg=;
 b=JcrAGG4H7BkDDR6QVTtyu96yFGQSVMbwcKFKcj2tMGh0JEBm144l2+b4KNAZlOyUOx
 NTTmv5h18MrI9XemTHxv8HurYza4ZwDP/ZK4wVOERdDiFivpH9FDKRZW4Mf3ICCW+vCl
 0/BJk/r9xaF2AUtTs2vVtZNmtoLEJFuPYAu6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793638421; x=1794243221;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dm9ThNY7uQNMr/pn2JNqg1memf1qEiTWt3kYlzyDqlg=;
 b=iMjN6uZ5UKGojkLqQUcIqv0JLEQIW0t0f4swFSipUjbIOc91HQ4PhUfR9ACJzUb38W
 93GUFOIFNtmOSet8bxHcUBrzD0jRAG8d57oFXQwC0UkbX3DKyREqqb0jnJlQKw3I7KTA
 cmrg16pPBLP/fGHBRszfW2rGSNpd45ZLJPaqAE/AFIYVrb1fl4uTIZIDzqYfLcKwN0Me
 dMrX9pyRW2PU5MLmxwRAqE4IuLLx25Ttnbj5JztQ01bIyCDKdscafAhtiPxSbY4Qh9uw
 NZz1Xq0GFRwYyDccgWmx0dw4NJmVXmYUNpCe8qtgwO4qzlup6zA7+W0IKB7TXihYjtJI
 k28w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPwNJnTPtFezk56RC0w9I43epF+c0JAJTL2IRNl2++3MwG4HlstLtI2/KkMbSqYlTMMpvTQcE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLSh1kkwWYcpW8d4PrkeihTjzfs/f7tdkvQSeO4Q9zy9LOB0Q4r
 TOI+qEb9chK/lKNywcOUUCa8ziysskcTUKafrnl15kh8UWl2t1UQSDkFa0np5wclz/A=
X-Gm-Gg: AYBFou3pUdtkRKCke0AhBJSITnEc0np8S3IBT8R7Ldf4x8gPfjUcLRk8BYyBqlbsmhp
 KG2pEhhY8tmO9vUiLlqgrZerEsHuNGSNoxofKPB01FWNz7FOiiQHfbFnnRRP0XMlvdbgEPZHC9L
 8LgWtWIRTcHUDBY790Xp1QsK8LbeMR+eLybKCbU/LHwF8l97VbKdbBYZW5SlpoXj8BoLrNxBOJE
 5tk4tFIqLEmpbAhOJWvanOqQjfsvqD3rEu7qwlBsrgtRiW7nnbrqrySzdm21/WNysR280YXWyiP
 liLP1Hf/17mmLk3b6S5O/EW+g9EGsD2Ar1XPX9oi0TjAvqUhjKTHI1jlko4znuwxkb8HKJNogMQ
 T8qY10R8RJDVUZ+MrJ6gFEKHlBskfa4tAuvau6+DrRypmoL9+tPE3qX8ohuLpK9NP6hwOK1sWqw
 2Ent8xYeUmOP9WpWuGPWtaFh2lwB5CfJlHNvMHbj53wU1uFeoK81sn0cFacYQgV/TNvuCypiaDE
 2W89cmloRrUvZT6WpPpfp4LfjFIh/WFzpczOf7po9KuWVkle3nG8Nk2aCSdXTX2jShENS9p2qNo
 HvSyisYGDZZKG4VNuMKSLUtqBOPYZDR13lqUUXqhVNDCCmDQmXM3nGEFS3h8lZ9inDgRkn+m4Rb
 0LUHgfPhuBHJIkze5GgOy2QVPZQc9Um7yL6/U8pCR/AW0nWVV7INi8VVMf3E6cb4ld+eoij/LvK
 /ljbz/xHQnmFZ4pfTQbFw04KKx9nx5lA==
X-Received: by 2002:a05:6830:6815:b0:845:156f:58bd with SMTP id
 46e09a7af769-85d3651b439mr9203049a34.14.1793638420779; 
 Mon, 02 Nov 2026 08:53:40 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d3545b847sm9315438a34.7.2026.11.02.08.53.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 08:53:39 -0800 (PST)
Date: Mon, 2 Nov 2026 10:53:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Andrew Davis <afd@ti.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Alice Guo <alice.guo@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Lukasz Majewski <lukma@denx.de>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jens Reidel <adrian@mainlining.org>, Erikas Bitovtas <xerikasxx@gmail.com>
Subject: Re: [PATCH RESEND v10 06/15] mach-snapdragon: Kconfig: Add rules to
 create SPL images
Message-ID: <20261102165336.GA3309461@bill-the-cat>
References: <20261102-spl-v10-0-224d421c6201@oss.qualcomm.com>
 <20261102-spl-v10-6-224d421c6201@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="W75QF6GXP8NK58hR"
Content-Disposition: inline
In-Reply-To: <20261102-spl-v10-6-224d421c6201@oss.qualcomm.com>
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


--W75QF6GXP8NK58hR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2026 at 11:18:38AM +0530, Varadarajan Narayanan wrote:
> The boot rom expects the secondary boot loader in MBN format followed by
> the TME executable. Add rules to board/qualcomm/config.mk to create
> u-boot-spl.mbn and u-boot-spl.melf.
>=20
> u-boot-spl.melf is the combined multi-elf file that has u-boot-spl.mbn
> followed by the TME executable.
>=20
> Additionally, this patch adds a config option to specify the path
> of the TME executable to be used to create u-boot-spl.melf.
>=20
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.=
com>
> ---
>  arch/arm/mach-snapdragon/Kconfig |  7 +++++++
>  board/qualcomm/config.mk         | 25 ++++++++++++++++++++++++-
>  2 files changed, 31 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/=
Kconfig
> index ddded0029ef..5718b66cde1 100644
> --- a/arch/arm/mach-snapdragon/Kconfig
> +++ b/arch/arm/mach-snapdragon/Kconfig
> @@ -59,6 +59,13 @@ config QCOM_GENERATE_MBN
>  	  New platforms can be added to tools/qcom/mkmbn/mkmbn.py if they aren'=
t already
>  	  supported.
> =20
> +config QCOM_TMEL_ELF
> +	string "TME Elf to concatenate with U-Boot SPL MBN image"
> +	depends on SPL && QCOM_GENERATE_MBN
> +	help
> +	  Path of the TME Elf file to be concatenated to u-boot.mbn to create
> +	  boot rom expected multi-elf image

You can't not have a default here. If this is optional, it needs a bool
guard on it, and then still have a default, and the help text should a
little more what's being specified. And I don't get why a TME Elf (which
should be TME ELF I expect) would be QCOM_TMEL_ELF

--=20
Tom

--W75QF6GXP8NK58hR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaujAEAAKCRAr4qD1Cr/k
ClUFAQCa/iqQUXA8ha2yZByveNbB2KCy/NjFdZauerD2oy2rMAEAiqRo2TCJ4MzP
qNoh7CFknXoAUW/gCUW9taC7w4yPngE=
=FV1E
-----END PGP SIGNATURE-----

--W75QF6GXP8NK58hR--
