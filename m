Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D231D606A918
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 17:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OZ6dRyL4;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=NBDrttVu
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6506881125;
	Mon,  2 Nov 2026 17:11:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uRIm1sV8jQoH; Mon,  2 Nov 2026 17:11:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7C2FA810D1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793639471;
	b=mFcHkAnf6bOf+2vxKQsGrAo2EwOuOR76/1AwgzRY/G+pY0z5F0AljLnVYJkYuTTqZreL
	 1UTcBJcrIMQBusjXP8dBqynMyRx5mrUhDET2MnMWAJlv0itMpyQJqeNE5q0XAC1D367hy
	 NOjS3faMTRqjwkO3QV7Mn/JibhSjMMXrUf+zGt0pFVq+XX+hDS1Soa/m8+/LjIKlEFdD4
	 k/MfvxeozI1+FdHrzhdC2qY+8bp2IXzWEYPUzpsmYmFUeiM5Y9dMajZOsGj2X8/FafLA8
	 2uNax+wlKtOqUUDmcoFAaVRAABiW0DAPyXTiQcLi7YQmcQ/aZjdaOhvJNbHFfTxRgrw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793639471;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gzPmk0m2KvCDgQWBOu+R+S6CYXjGcQZn4laURpHqccY=;
	b=ngPjNhYls7WPh3wwC6DxNHxaraTrDc1hAXOaZGtRbc9YXFdfKG7FeqfhlZOBeenOqgK/
	 hx9B+ukPvqnvxyrHKXB7T+NPeZXawMDZjuusjRaheq9kjfTX5QA63NhgaXEQ4/kyYDARG
	 GWBqnS0nIPJIfcZcb1z9S4oDmbCjQha5eIneFKRhDKHp4bgQm/Jzjk3DJhvoYOYAEOGLP
	 BLIHv6dv/Y/HR/9c13ATENdaweciphIyznLUxU6XNkF0VLgdd9R7DMs2/fztJh8jxICye
	 dG3w+HiHw8QZ/RtI7dkTdIOFJUFLBlm75whjBn6WlGCLBHX55HqNW1/zwFHCdx8VpMQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=NBDrttVu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793639471;
	bh=gzPmk0m2KvCDgQWBOu+R+S6CYXjGcQZn4laURpHqccY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OZ6dRyL4/KDiDdA9cFzFj+2RcpGxNTRHbRcbe3NOHIYZAZJpsZYE+WhRY8iEa1ceX
	 4EYxk93np45G1qYO+aaInjYphPbB0kKeAKGiQ+nCwCvrLApFKlK1O4ZbODNZIk5Xa4
	 5SFF05C81Ddoul5JCRsLbFmApCbHesr/aNJ//5ueS2AqU8jaeKz0JonBxnsYvqzkgU
	 uphlVdFrxS56TEfPlN8Q/doU3oDEBV7qOymb9Uj/hlILGafaGEWyUiKz/1QD8vHjbw
	 7zbBT3UyoBlBI7jK4hkI/XPgKr8JFQRqHsSwyX1EMtBe7ZOfjTMQeKRLoMp5rDmrKS
	 UPGcvlKRbKfzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7C2FA810D1;
	Mon,  2 Nov 2026 17:11:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 60AA0120
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 17:11:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 46422810D1
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 17:11:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qz_dpZioZdC9 for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 17:11:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7671080D7B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793639468;
 b=imSVl4VQGKNE2F7yv0F2tiqsDrbrUpYQTofbbDP1qwvQOtb7YQFmQDhLVch5/Cg+OJdE
 C/2X930R3cezd4ogrDkVd5X44nF/GRpFE11ltpSmk4P/tTRRHvBJDwqFKqdfL0jS/77S4
 A2guebbG4fVRYYmo/GsughFmEgdQmRBE2ZhaDfMhTeZ+J5yAZpXbq9fiBX2xEPpC8bmol
 Gr9nUmVAL49IOY6M0nDxDaotNPk+FPPXHbhg2CAeS5TGtw4cjTMKTHQ3CHJeO5JqDSRi5
 qPegBW4lrKMxcCemmJQNaMna1jihMKk89FW1dUQ5MzCIPmnMYI7tpM/rhRWxtwo2sBw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793639468;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=gzPmk0m2KvCDgQWBOu+R+S6CYXjGcQZn4laURpHqccY=;
 b=NrwwYg1tzzJ97+NgwzvAju36fDYIorTKyF6xJ6MJJoE+MXgCmRsqmCGQ1K1ZRICO/Ymw
 RNpNW8PJcVZsX7525GkvYravQQqIvVF568LW1+bIgABsYxsdgIarr5dMclon0mxGlJUbo
 B12uWhqTnazB+u5+3gCy/puoz+6yJ6yc5zrjx86bUn5eWtzQfq7mxwehrthFcA1IhUmL8
 LyqOYFaTdjdo6U2+IK5hg1xnmTgHEnQ9g2F84NB5RhD00LEqTjQZh4RlPZl7rV9sBxabJ
 /FMML1sposOy9PXi+N7jSaCxKt9YJYxIzpOeTJthUyjg65Yajj3TF1ObVxYNCToaP3g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=NBDrttVu; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=NBDrttVu
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7671080D7B
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 17:11:07 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-84e513877a3so2959125a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 09:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793639467; x=1794244267;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gzPmk0m2KvCDgQWBOu+R+S6CYXjGcQZn4laURpHqccY=;
 b=NBDrttVuya6asXcBC+Rq0uiEhPu7si9VAup+4PYjs9ORMvFmFI066H16UllicvCvrO
 nra4P+wKty58+KAw6t3jITVRTw6+7Z+kEQ+EBtlX8QxbfWrWleFFCz2yuK/oNdOEn0x5
 PZr2dZjst1A8h44GbRrvMmQ2IBOqinfrdS9os=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793639467; x=1794244267;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gzPmk0m2KvCDgQWBOu+R+S6CYXjGcQZn4laURpHqccY=;
 b=iyTerQbeOZ3VI3YFmT6Mxc2k4gFmbutqsdBAZtKWkCPKTVuBiueI6E78bDqTPQlp/G
 PS/qYTMaCT7wIuWIAP42NtuTg/nS5vgCpH2lMYkXuAJN73mvEFvIuH87ttovRsj228wu
 6IoxciySql0i09PPaaVc5HOL7Z9iSdYwzxE8uRcSQ4H6mKIEiSffO1bgRxNrZuCayB41
 ATGTbGM4BUWa1btLdNlopUJuJj28MGYP3f4YdRr/R5gURGyumg5sy+K2orawdQiM63mY
 wP98auUoDKYyqeovZuyM16GpjsuyzUvNqz90Mb4Qq8/vaBGcJ2r6D2AF7kp4ntscnesL
 o8nw==
X-Forwarded-Encrypted: i=1;
 AKwUvBySzbZGln8yd35Hy+515pWgBOv5yhKwj8QIKzUj5FlDDh+JwtAwVxHAYWpMg70TBHe8mFpFU/o=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKmWWGAZapnloGVDb0u1EPgd1fCVkI+XMvd6nr6HbIxSR1hMeOK
 0gQ6oX+up49jV47vts3+/4PO4QF4OEnqSbCpIW9CBGfCj4M8C58PvRYupr5vNf/Yv/c=
X-Gm-Gg: AYBFou2rcRfq16D351jOJqaEa5Ne4Er98ATYxihvXzuCkOyCIw1FLKJoCzJikjc7YZC
 tae/92iXzMBZV6LznQQxDzHjNR1Rxocb1eL0Iru4ZGYvBpyKoK8AbjYrtzyt8WTCcZ0Cg4ciSXz
 zcgt4Lop0GUXsPyX7x+gJcPX4rW1vizML0569dy0SQT13fmIaTM5ZO3udB59qchoyjkksNDAVBH
 F6WlsDb0nKi2+lV0VHs72XtC499Ba28wqeH5rFGnDBFdR4xyQKU5fMBuxm381jm4dRmZa4HKUeF
 cO10anXCTK8oNW6nEM0oe7G3Vx4TfG/Ums7PX6ywRMheZwSfMgp9zC+lkTRdYbYKnvcdPorkAIM
 bKX4lT9eLcIkW5RtAEktN65ojYiFlKhW+DReS4yzPSPjM0NvTHzM5EOgCGHoNnKkeUI1dYizwRt
 VaimQgIQtGW2Z0PWDglVX1w5QsZC52MOwcfI/jdLDVphtW4CYA+Hpd5W+Zaj1vZiUrEJ/RaB9GB
 QNA8/7f4evLAEt4nv0s86GqdaQafhaJyQgAM3qqVOUS1qAnAEuTgQfRmnFIQdOh0RuzdHAgQJeZ
 NinycVoUbm979n6GMzwjbRt7f/El4ZDpHnKHztFpqHa1pSKdnKEjnVpRE468VgAh21yRMbicLAv
 7x98eaGU9oDmNmAaEuWHZNuWRPn7AzEyXjfhJA7XXbwLLcplZXv2zTSQvDf3POjMpFTsmw6fMSb
 p2MzTgp3JQ3F/DctoHWRwKE+GqTkSaZNSS7fSF61gkPzrZmOvC780=
X-Received: by 2002:a05:6830:3497:b0:84c:58b:417f with SMTP id
 46e09a7af769-85d3641ec8emr5166800a34.5.1793639466664; 
 Mon, 02 Nov 2026 09:11:06 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d3545b847sm9351671a34.7.2026.11.02.09.11.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 09:11:06 -0800 (PST)
Date: Mon, 2 Nov 2026 11:11:02 -0600
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
Subject: Re: [PATCH RESEND v10 13/15] mach-snapdragon: spl: ipq5210: Add SPL
 support
Message-ID: <20261102171102.GC3309461@bill-the-cat>
References: <20261102-spl-v10-0-224d421c6201@oss.qualcomm.com>
 <20261102-spl-v10-13-224d421c6201@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BQIbHnxV1YMbz89x"
Content-Disposition: inline
In-Reply-To: <20261102-spl-v10-13-224d421c6201@oss.qualcomm.com>
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


--BQIbHnxV1YMbz89x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2026 at 11:18:45AM +0530, Varadarajan Narayanan wrote:
> This patch adds the basic board init routines that invoke the common and
> mach-snapdragon specific SPL frameworks to proceed with the hand over from
> boot rom to the next stage i.e. U-Boot proper. This also provides the
> linker script to generate the SPL image in the format expected by the boot
> rom.
>=20
> Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.=
com>
> ---
>  arch/arm/mach-snapdragon/board_spl.c            |  2 +
>  arch/arm/mach-snapdragon/include/mach/spl.h     | 13 ++++
>  board/qualcomm/ipq5210/Makefile                 |  3 +
>  board/qualcomm/ipq5210/ipq5210-spl-wrap-elf.lds | 18 +++++
>  board/qualcomm/ipq5210/spl-ipq5210.c            | 99 +++++++++++++++++++=
++++++
>  include/configs/ipq5210.h                       | 11 +++
>  6 files changed, 146 insertions(+)
>=20
> diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdra=
gon/board_spl.c
> index 2655803b31e..3293eab8f81 100644
> --- a/arch/arm/mach-snapdragon/board_spl.c
> +++ b/arch/arm/mach-snapdragon/board_spl.c
> @@ -12,6 +12,8 @@
>  #include <spl.h>
>  #include <soc/qcom/smem.h>
> =20
> +DECLARE_GLOBAL_DATA_PTR;
> +
>  /* in SPL, we always use internal DT */
>  int __weak board_fdt_blob_setup(void **fdtp)
>  {

You don't add this, and nothing else. If we're using gd already, it
should already be added, and a standalone fix to add if missing.

[snip]
> +#define QCCONFIG			"qc_config"
> +
> +/**
> + * qcom_spl_soc_qclib_override() - Populate ipq5210-specific interface t=
able
> + *				    entries.
> + * @table:	Pointer to the QCLIB interface table being built.
> + * @fit:	Pointer to the FIT image blob.
> + * @images_node: FIT "images" node offset.
> + *
> + * Appends the "qc_config" entry and a placeholder "qcsdi" entry, filled=
 in by QCLIB itself.
> + *
> + * Return: 0 on success, or a negative error code on failure.
> + */
> +int qcom_spl_soc_qclib_override(struct interface_table *table,
> +				const void *fit, int images_node)

So I guess here is where you start overriding some of the weak
functions you add earlier? Since Qualcomm has a better idea internally
on how this QCLIB stuff differs from chip to chip, please work on the
abstractions a bit more in the U-Boot interface. You have a better idea
on what is common and what is different between chip families, and
what's being done so far doesn't read very clean.

[snip]
> diff --git a/include/configs/ipq5210.h b/include/configs/ipq5210.h
> new file mode 100644
> index 00000000000..5cbf838af82
> --- /dev/null
> +++ b/include/configs/ipq5210.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#ifndef __CONFIGS_IPQ5210_H
> +#define __CONFIGS_IPQ5210_H
> +
> +#include <linux/sizes.h>
> +
> +#endif

I NAK'd this type of change last week on some other qcom platform.

--=20
Tom

--BQIbHnxV1YMbz89x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaujEJgAKCRAr4qD1Cr/k
Cie/AQDr073Dqbw8MyAsRf4g/C0KiG9flMEbkLDGkTgJzgxBdgEAzcnhLErB+Lam
aAfIkSEmDIfOA4+PnmKfF2cOfkEY+gE=
=4CaQ
-----END PGP SIGNATURE-----

--BQIbHnxV1YMbz89x--
