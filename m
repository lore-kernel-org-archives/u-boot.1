Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AD0606A31C
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 17:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=J5LfYuzz;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=O9J/z/aY
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 11C7280FA6;
	Thu, 29 Oct 2026 17:21:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eL_33travdQe; Thu, 29 Oct 2026 17:21:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0F01A80F88
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793294472;
	b=HjjqjNqMnsormwC5147/7lZ4fbNmvGo/KLTleqk5FAFK6NWV78ORH3vfqzhc458d6xhT
	 z+pfw9NpVtAkfyxG2wKdz9jmlHkcdwH2SDHbs+VscUK3hwYFXpSCpg7tUWk7iiZ/4Uo0T
	 HXuwg1v+EPR2aVgQO3DAT2iCnp4ov1WlnxiHY1l4xDm5AFgBPGZRa4Kr9UzRp/pwa2F2C
	 KR9DANqWnKM0gamGNarsqB//tkSJvrnUZ1P5U1mBUJft5s2vHPqJ4EKe7X1Ym3xgaKM/a
	 GGBp+xK8reeSz0MikQhKtTb+eU+Zx7RZKa+Wfxb7r8DHj1eRHL0Mifb7cdtS8BSPa1w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793294472;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vsHf//O8RQccaEe18l/eIWF7jqdp/knoDt5cWMVCVik=;
	b=RcI5yYvtpMUtslaufaJUrTikpFEcFlzzcHrjbMEI38bbvq9NXxs6BWDnXftqz4Oavfh4
	 hB49mEYXe8L7/o8Cee+pUX19xxvlSYmEsL007pDHCqTowgFtX//1tsOAS/9RRR17kALHh
	 b6Xv3DNB6ba5NAYJ1in2SzeF9t3E2E4DCIAKIWAFH+91eYwo35lugaprdFL08Y3WD7KSv
	 G9V66xqMwduP7eRC5sYJGQ1M0DVcihAgUIj9l1y+qJwnPs4ChgkswzedyIpcZwUjpwwIr
	 tPhBLtUCDyQBIznAxVHT7uARdmX5Xt/R8FOUPU80doqrZKUqIooiuDnYW/ymcDtIAxg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b="O9J/z/aY";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793294472;
	bh=vsHf//O8RQccaEe18l/eIWF7jqdp/knoDt5cWMVCVik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J5LfYuzzNepoFjTQkfsGnQzsgZQb/x1X6MKgMAIsue/z7BFP9lIHH9KydNs1e9yXe
	 Odo5KkjEXO5ZQ+LSYUQrlPemWYWyPKKrsXkfBNMgTt06rNidsK0RHouBd8Ao5D9UPB
	 Mq7VhKBayPQgEeNaxN0K3gc7iSdyEets/6Oj7k7yiWsalhmCw73KXHcOLkjlGlLiya
	 Mg7Dt+8IbAsjRMyH2+x8EHt6LIniHwZYVrZvEo12WN8MSeRwKw6aJJr+7TgSGO95p8
	 sPDiQVFGH5JDYtowwDBRV+d04DO1X7YmSCaXObLduMaGVAeuC7TXjdu8BvELNwRUdH
	 f+kKDtZ5NdMMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F01A80F88;
	Thu, 29 Oct 2026 17:21:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 48B182FE
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:21:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3A73B80F7B
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:21:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5gsZAxk60nEB for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 17:21:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6429F80F6E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793294470;
 b=nL8aqAfK0y8mWpN78WRpPrFsow/BMxe4FSD/yTgu6hfuEvEBmSGGzHvqOEq2RMrDaF6l
 S6msMablSUAuLFMvUu2m9KUFDj8Ie8ey+kjL6ALd5AJvwZU0xmviTT6fGzqoisEGPLsyY
 HA10E/HBuBCE/ILqKD5I70Av/lBsKcxU52KL0UVs2QW8RqtwOV40aiA7ly+5c2M9mv7lv
 kx0dRTDZ/sRolbQgB9wxjcqIS7lRskw6Qhuxsa17km4kQFPGPTrXSVI11jEjMkWNQFKHg
 x7afk9EDSI+6PqwfuiuCpMhsowZL2iQfOTkgD75xdff3DRM1N2bSEToliLjHmQwTUhQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793294470;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=vsHf//O8RQccaEe18l/eIWF7jqdp/knoDt5cWMVCVik=;
 b=oxTGi1SZ1xofdRIW3IcqmsdENZeJxr7FNMDqOsWz50uY5H7xaE33ODFQ4Z44NRWrVNgi
 RaHUoTvqDT7FCjPrejhkbuqMTrlVJeh4RZJajZrW2JlKdbQmfAvXzjn6pedcBpYXrHIgX
 ZWovRFGuJ3wNSQbQuMHGRmQHXzlGY0jRpEZas2Fm9P+BXd/9x3AAzqlxnNq94WhY+gb0Q
 4JmeDYNmqAIM0ew+Dmj9DgfbI3JRBTWCl47CMvhRTdKDgyopspTwHUxXiEbuRCauaXnYK
 YW/Vzzn9DJiWTWMFcVFPVjxzF4Uth2VN3fkzOd/zLDqNza/ZwL01grJioIZOxhjBd6w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="O9J/z/aY"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22c; helo=mail-oi1-x22c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=O9J/z/aY
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6429F80F6E
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:21:09 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-5326cdde017so766978b6e.2
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793294469; x=1793899269;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vsHf//O8RQccaEe18l/eIWF7jqdp/knoDt5cWMVCVik=;
 b=O9J/z/aYLEFM4G5Ym7TJtUPV2eFqB28tbopJwhrLhCkThDMXZfGVHd7NR6MeNRbh/9
 cgJlJBQE5nQcuho54EYpipJ5657ToE4p4LhkEEZZHG9JxaJwxKuD+n5UNVldfNWRscXl
 D3gXeni4ByWE4u8KCcjp2Puf7jW8Tv5SAoeqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294469; x=1793899269;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vsHf//O8RQccaEe18l/eIWF7jqdp/knoDt5cWMVCVik=;
 b=tgi3Z2ikcqDuonRAODB1UVkSnvgoGBu4nmWD6wWoWSMC+k7SQ8b5RB8J3zeQnhgdIC
 IzNAS9eM3VkMnkdUGcex5fBD/VT/oN/QJi/3TrYKzGT0pffQ82dqgL6GjkDKIhYqzEkK
 YHKF+IqkLi/rI6x7cnWw2DwHSBn6X75OBsfvUK+XLX5zi6OnytEeH7v0Ks74GiiTCOl2
 V6VIUU6j1xZw+u/w+M6TBqocKDZWENEOpRAAlPx0Pi4tu2956RgCUthKtRbXqVik50CY
 zGxPU+9syiBsSZWSSjvAs3QuSwXAMm6QsgiQ95kw+cJv28KbLbtAo3CnzBpyZNFXQIII
 9yVg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxliwgwksLYLalA+GzyRYVX6/decHk3u8gdK3WVmiESX/SJj8QzcN1dHi6R8oxeXxBm8JdxeUc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJT0jpcqbS70TSkYXCubNtBRZXqZU3hRzMstWuOPR4atxOimdh9
 hA3FbToALvUFepXOA/1IJ6JRqfu168Z1YWoOwPPjpko/CMAjLhRIWzIGCKWE4yNLuZE=
X-Gm-Gg: AYBFou0rXtLEnVLSpX6dlgYiu/KHmRb8Am3ZPjpoFqDUfgV7hxQ3fQ7rm87/qr9SNrl
 GNNtkyOizzvjd9haErYX3fkxfDm5vr6KUsyIvJ4jOmiOPDZiQHTSeao6m/mD15vxluuwpY2Nl/c
 yL6klrORTTkFr30ehMtJiL4Rc4apZ7cCP2uNZpYpKEMgwY4Wbp7CjXsysTp5IdWohbDJCXRS+hI
 jorzRo/YZ7lonLAnZ4IGJUjuJ7MfvmiXrP+jokjfTAZlB1+U/P82JxfhH5wg7NBw3ZjIRbiuslx
 65ZDxxzGssmSwoeI96Wtpp1hydYzq7hQ5mfJ+ymDHUeRftYsjyLWTF+JnpTmJ+vmrh/g6i4u1X3
 sdlHPqJj8W0tAPPHAeEY6DK2tLptNbaVVg+rZXRn2CX+E9/SXxuigiTsNlzsnV6ZH1a1xGM9zri
 UT9BlQjI5j0PvtyrrQvRjCLQORnB8+7AknPacf902BBB5qSSNdMnkWFyXCBPDdP+Z2wWKl726VP
 7QTZQLuok0K1exMVAt9i/e1QEkCkIdNWO9FZC+k8CiBZf77bxeagOpo1i+j/HcPKxWeoAxe5/lQ
 e5kM/joqbzQ3XOqYgVTDFcZtHc3REcfcyL1RUQ4cgTBWnDXrQOs1bs45sq8f4bfIQ3R6e4yWNMk
 /oS82f8e6OcZCAnXs0bRm2bdx60mG4PxzyLRY9Idl4y0A0Ue+zqdcaxtPxLkAbuqDX/2gdYP2iB
 tpX5h0Vm8sRR/6uCmO2+mOVDxLINZ801w=
X-Received: by 2002:a05:6808:1489:b0:540:5827:6d96 with SMTP id
 5614622812f47-5638267e67fmr4672254b6e.31.1793294468944; 
 Thu, 29 Oct 2026 10:21:08 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a9049b27b7sm12478fac.13.2026.10.29.10.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 10:21:08 -0700 (PDT)
Date: Thu, 29 Oct 2026 11:21:04 -0600
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
Subject: Re: [PATCH v5 13/13] clk: qcom: build only selected clock drivers in
 SPL
Message-ID: <20261029172104.GB3011578@bill-the-cat>
References: <20261029105746.3487456-1-abhilash.v@oss.qualcomm.com>
 <20261029105746.3487456-14-abhilash.v@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="z0mku3Y8KzcuX15/"
Content-Disposition: inline
In-Reply-To: <20261029105746.3487456-14-abhilash.v@oss.qualcomm.com>
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


--z0mku3Y8KzcuX15/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 03:57:46AM -0700, Abhilash V wrote:
> From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>=20
> Make Qualcomm clock-driver selection phase-aware so SPL builds only the
> drivers it needs, reducing the SPL image size.
>=20
> Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/Kconfig  | 208 ++++++++++++++++++++++++++++++++++++++
>  drivers/clk/qcom/Makefile |  48 ++++-----
>  2 files changed, 232 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index aff3f5418a0..899f44cb8dc 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -5,6 +5,11 @@ config CLK_QCOM
>  	depends on CLK && DM_RESET && POWER_DOMAIN
>  	def_bool n
> =20
> +config SPL_CLK_QCOM
> +	bool
> +	depends on SPL_CLK && SPL_DM_RESET && SPL_POWER_DOMAIN
> +	def_bool n

Are you sure you need the def_bool n? I see you're copying CLK_QCOM but
I don't think that's needed either.

> +
>  menu "Qualcomm clock drivers"
> =20
>  config CLK_QCOM_APQ8016
> @@ -15,6 +20,14 @@ config CLK_QCOM_APQ8016
>  	  on the Snapdragon APQ8016 SoC. This driver supports the clocks
>  	  and resets exposed by the GCC hardware block.
> =20
> +config SPL_CLK_QCOM_APQ8016
> +	bool "Qualcomm APQ8016 GCC in SPL"
> +	depends on SPL_CLK
> +	select SPL_CLK_QCOM
> +	help
> +	  SPL variant of CLK_QCOM_APQ8016.
> +	  See the help of CLK_QCOM_APQ8016 for details.
> +
>  config CLK_QCOM_APQ8096
>  	bool "Qualcomm APQ8096 GCC"
>  	select CLK_QCOM
> @@ -23,6 +36,14 @@ config CLK_QCOM_APQ8096
>  	  on the Snapdragon APQ8096 SoC. This driver supports the clocks
>  	  and resets exposed by the GCC hardware block.
> =20
> +config SPL_CLK_QCOM_APQ8096
> +	bool "Qualcomm APQ8096 GCC in SPL"
> +	depends on SPL_CLK
> +	select SPL_CLK_QCOM
> +	help
> +	  SPL variant of CLK_QCOM_APQ8096.
> +	  See the help of CLK_QCOM_APQ8096 for details.
> +
>  config CLK_QCOM_IPQ4019
>  	bool "Qualcomm IPQ4019 GCC"
>  	select CLK_QCOM
> @@ -206,6 +227,193 @@ config CLK_QCOM_X1E80100
>  	  on the Snapdragon X1E80100 SoC. This driver supports the clocks
>  	  and resets exposed by the GCC hardware block.
> =20
> +config SPL_CLK_QCOM_IPQ4019
> +	bool "Qualcomm IPQ4019 GCC in SPL"
> +	depends on SPL_CLK
> +	select SPL_CLK_QCOM
> +	help
> +	  Enable the Qualcomm IPQ4019 Global Clock Controller in SPL.
> +	  This includes only the clock driver needed during early boot.
> +
> +config SPL_CLK_QCOM_IPQ5210
> +	bool "Qualcomm IPQ5210 GCC in SPL"
> +	depends on SPL_CLK
> +	select SPL_CLK_QCOM
> +	help
> +	  Enable the Qualcomm IPQ5210 Global Clock Controller in SPL.
> +	  This includes only the clock driver needed during early boot.

For readability you should keep these interspersed with the non-SPL
variant. And since there's such a backlog, the right thing to have done
would be to update what we have in drivers/clk/qcom/{Makefile,Kconfig}
to have SPL variants, and then add each as you go. So lets step back and
do that.

--=20
Tom

--z0mku3Y8KzcuX15/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauOAgAAKCRAr4qD1Cr/k
CnbjAQC0UGde+hyNOaXRh5V8zPZ4zbnbCpIs8yyeBPUKso+YEAD/U71RBJlgqT7k
VDzrM7mKHTXv69HcTyTXgwneWAFCNwk=
=xY4I
-----END PGP SIGNATURE-----

--z0mku3Y8KzcuX15/--
