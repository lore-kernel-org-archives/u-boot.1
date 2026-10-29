Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1797606A31C
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 16:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FufuEwvE;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=d+UBr2Rs
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7971D60721;
	Thu, 29 Oct 2026 16:51:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xUbTevc4DOz8; Thu, 29 Oct 2026 16:51:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 59A5E606C4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793292664;
	b=J6Am/BbAj2gtUlq0zSwyPczezwCje0+DDRvg9An2H01a9nZEdwTfqTNiIpWDqccUFOva
	 xCmOJuHv1iFLLGJMjfP+rCXW/8aoAAqKnGFaUnosLPmGHFiDxkEC2Jp+9dIYpjkdtedxQ
	 UtYO9eG8z2UwzDz6ZL6zpwHRoxJscuGsODzp0RVKTaQMEuMjq79CC5PoMXLOv/eFbILgW
	 NcQ01mQepsdXIUFKynq9in/ZmcmmWCKlFsD2DDnNDsWCz9pvHR4+8dj/UoHEGrDinwo+a
	 gj7D4s/zoj7+rl6wU7rIqlmgNNCfuMCOl7U7wRBT2ObJS7Az5aDgitxXanMi8Mfq3jg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793292664;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sD/5ENgLDtw5G6jGXwhvT9s0f7eclbnpOwC6LVEfqP4=;
	b=kITnDxorl2mLALKVyxjKXGYmQnc4ud8Yeakgs7HvzvxpMTULIq4U+ikUGAHUmpHpnkyn
	 7bqvmtmVYayqIUM6XGcOTyzbTvrUwb9xrsCVtaQa5nxF2tL+8dd4iPwr82CpnF+DYhx2o
	 yneYQV2wLAzDcfFpLGcYeUGLWkweswH+qsqeYgZs5uenwSrCDYlRaICjrYi93vvcspGfQ
	 QDadGPz8No7wH+V2EttCs7ykh3hDGY4OjVSsrEHVQSMXxAbAThpthtvZwoh2UnX9S6oWM
	 VLiM/QB9tHsbl0IQQOrthbbNshSZH6Pn9E4Q7olBI3tjZ5NFK9OXAi88lZ0bDTkalPw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793292664;
	bh=sD/5ENgLDtw5G6jGXwhvT9s0f7eclbnpOwC6LVEfqP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FufuEwvEvqv4ZtXwzhbJGEGSWLq6xZUHcPl+i16D7qXf6QU659MD3f7EY2mmKsH5O
	 wTzKe0q6AVDnfawNqfkgzTnB98cyc28yMsOMbdPDKLVohuNbWfNUf36hkL1IXH77Li
	 Lju+hwj58CLTJKHbpjx0SOrQepS0I/dCGHlkZAvErEHJlNJkvdqzWQ6/IiSG3mATYc
	 esVO/hiKqOOL2YoolEuLSg9l22FAffaf3x3kQWD0uiHkti9aaujdtVOYdTGLznGvls
	 yjiZfhLy75Uk4JWjx95xfGtF0gDphITqdeQTn3hFz6MO41qBGO6w6qot1f8DFgHllG
	 SbeETvkW5LMkg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 59A5E606C4;
	Thu, 29 Oct 2026 16:51:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F146972
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:51:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 521FE80DA7
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:51:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6-DfNPONrTFe for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 16:51:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AB7D680BF4
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793292661;
 b=jYSePXJUvZj5IrcszFFiJZp+Ql3OCredAzdkhPQzUckPzs9ffzzvFyqZuIDNYywuTEFR
 HmEZDuPEywXBP2m53DwXjiu2B9Ka4rQPMZ/WyEI0hjcFYcTt8Hz7v0f/IgVsvGAugiz4j
 bTgdvS32ymwlKOh2g9Zp53RO8J7H87z/aH7S8zYxFLbc3IoI+vkD/iQNXCZ6Ro55XgLfq
 EyoFCoJGD6Y9jPYFOR1PIQ+k5tV6V4yymYU5d7lHVElg82EtjBrMduVDvHCGYPKjTgyKz
 CRdeSrLrCU2iepM8XppJdT5im/RcsiqPRI1Nv/vf27Ilpxptcaf+q0sZMElwG+ayEvQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793292661;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=sD/5ENgLDtw5G6jGXwhvT9s0f7eclbnpOwC6LVEfqP4=;
 b=Th259/NNBHXmRdAUt7whiuunHyMCannoFx9VDnDFDrhjd6WYZMRZAeuSEsAjJwxuXLQP
 FfCM9OeEg3Z4wIMYsd8GkMmQgWM2Iq0echFSvWmBAaZAGK1B1J4ICMXyaatgsupDCUFvV
 i4nJssFL+PFXLLMHM7W1psvz5e7xOEy3Yn4jrn5ZarVaUPCv2KkIqUl2CBloj5jkNC909
 h1c+l35oIbUgMsX3rKE4nkk91qsgTad2Tl+ne3a2hQ9t+b66idR/6R5omvQ8+iPKZuUUm
 MjmzOeGhmMnNkkP4eFdW8nBH6GvcDJ52dmkFUyMFqjPsnJ2lWtQSjVC13dL5SCd1lxA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=d+UBr2Rs; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=d+UBr2Rs
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AB7D680BF4
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:51:01 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-845788309b4so1143604a34.1
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 09:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793292660; x=1793897460;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sD/5ENgLDtw5G6jGXwhvT9s0f7eclbnpOwC6LVEfqP4=;
 b=d+UBr2RssZuns+eazEELbmd8bAaAZYvDnJrlW+jSGlgknIdKpq0X08iB5laZRU4qDV
 RhlEuRDmp5jcCGXBYp8yD8ab17mKNYCMPJifLMLFLok4VmRM0BAWCOIfVKqbPu04wVoC
 ePwUrfPbEp77kETSnGuwsyxNQiWRytTIGLWkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793292660; x=1793897460;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sD/5ENgLDtw5G6jGXwhvT9s0f7eclbnpOwC6LVEfqP4=;
 b=P65Rqq/xqk8gxFtOItq1DWjvYw62jlbdoa2v5R9zxOmoyA3lw+ZBr4BwGr6BsNA59L
 1BBBB3Y6CDxLTv8gaDVG/cQq9mulH5aIpy7DNBbFh37wdPwd+BX70wDgQ4GhjuD2jMnd
 Zhe9V63dphZ2cX5ZZDHpQCOGpM0BLqagB2nb9EL26gbMtE+Xab5Wp3lxepNpCKATJgWL
 jnNHA4k2kSmdQ2g38w+tsCRQquJTgGy8XE+pkbkNb3zBD9ORWbf6RntdU/9+pGdJF/y/
 y4VuW5uFTG1ajwfvtPzR23QWi3m+AFZObgI4MWSsLBWAmOsJ8zygKafDZXEjINmQAyYe
 Cv7A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwzO82w6bw3JeYXXLfWWqvp3hgrSEsrHr48OMfNpJNZolMmKd+FIlxAbCj8pBchhcHcnAakMPs=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIB02D5dqiHlkiwDwa94ZPwD6zNGvSV8pibem+lwF1ihUzb7nWA
 dlUM6aImhhgxOsqCcBO8VKhAYDLH92VrVdAKMisHxc1e0FU8TfBV+sQ6wZ0kMBcp1vM=
X-Gm-Gg: AYBFou0J49yVT5muk59arxWaG+Wc7Bk8A8dPoBF6RdPTi6FPIertCnvMTFFYc3dp2hW
 myBZMrL9hGu2EFCApTjpIthpUrzxCAdNP38FSh1x+QQVjX032Q5ov3oxz2iyQKXW7fKzI8HrVQ+
 uJ34ncpqkizulTD0hQ2YG6pGoNACzmVrOSc2gLclJa4HEzGBxDuqkx7TG8P0szWc1N6Etzldw+9
 J+SG/ZYNNnIsbicEREQ1y5nB4iGjTCTqtROY3OhVRDmvQR6mH5VgY7oDR14I9xZIYhpXqKP5AaC
 xVL8IFLyhHpp5Cd1qcgkKWBCu5ZT0M3MSnz3b5nYQGGh7t4WSeS8XsRJ60SovbH/MkEI891J6nI
 /MunDaIuDnH3cP1k5Fl+C5nJHHtgHr3Zw2P0DcdoLn5wkPqnYvZrpenAyV5zCvhHBeICIuso61O
 U//kccGIGSNNtH3xLWR5zX4ulxpYJnk+EkdrYrUrlZHQdIoIm3acRa9pH1fhTky5z38y962TGjo
 fy7nuOrvmBs1xl9hNShCRY23gWmhLsbJ80Lg5opj8XWQnZdQXeNg5LcjM2Cl6YHgT5zE8D9q+UW
 Evg1K13vAHXojyLiJoS12HpWwHbDNlBb2hLJct/ZXDq4VkCI+igJAACrNqqL4RV8YYo3IaU/44/
 N2yqXSj5wPJD4a7oYBsPuUQ1idkaI/AxpKtVR0xKKisXysgk6uteCVRx5EkFZxlreDtJQF21Kbu
 0oVLs4x0IWotwuj1ii1pTe/BGlz5SF8DKndraafwnICON7WlcEF5+E
X-Received: by 2002:a05:6830:4411:b0:829:2af1:a07d with SMTP id
 46e09a7af769-85abf966b72mr5344894a34.5.1793292660211; 
 Thu, 29 Oct 2026 09:51:00 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d33f57675sm359226a34.8.2026.10.29.09.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 09:50:59 -0700 (PDT)
Date: Thu, 29 Oct 2026 10:50:57 -0600
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
Subject: Re: [PATCH v5 03/13] board: qualcomm: shikra: add SPL board support
Message-ID: <20261029165057.GD2976463@bill-the-cat>
References: <20261029105746.3487456-1-abhilash.v@oss.qualcomm.com>
 <20261029105746.3487456-4-abhilash.v@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JPMvY+d2o3jRKMAy"
Content-Disposition: inline
In-Reply-To: <20261029105746.3487456-4-abhilash.v@oss.qualcomm.com>
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


--JPMvY+d2o3jRKMAy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 03:57:36AM -0700, Abhilash V wrote:

> Add Shikra SPL board implementation, build rules, and linker
> wrapper, board configuration header, and QCLIB handoff data.
> Configure early reset handling and MMC boot selection.
>=20
> Decode the Shikra boot configuration and map eMMC and SD
> sources to SPL MMC devices for boot-device and FIT partition
> selection.
>=20
> Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
[snip]
> diff --git a/include/configs/shikra.h b/include/configs/shikra.h
> new file mode 100644
> index 00000000000..7d88dc0e670
> --- /dev/null
> +++ b/include/configs/shikra.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#ifndef __CONFIGS_SHIKRA_H
> +#define __CONFIGS_SHIKRA_H
> +
> +#include <linux/sizes.h>
> +
> +#endif

It's possible to not have an include/configs/board.h header file now. If
you need this file later and are also including some "#define FOO SZ_1K"
or whatever, that's OK but needs to be re-ordered for when you need it.
But just having this and using <linux/sizes.h> is not.

--=20
Tom

--JPMvY+d2o3jRKMAy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauN5cAAKCRAr4qD1Cr/k
CjYQAPwOe3P0hTAhUlik+wgkPaSwKm0aHlSCuFM7WTsqGeLQBgD+KGD2bYhEbx34
ayl/0nAc0QeO5alSJV8jYKhmm0gqZwQ=
=RUT8
-----END PGP SIGNATURE-----

--JPMvY+d2o3jRKMAy--
