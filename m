Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C498B606A31E
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 17:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rgU+3fpU;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=FM57U7ss
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6AB3460770;
	Sun, 15 Nov 2026 17:10:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lJtt9hXYCAb3; Sun, 15 Nov 2026 17:10:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7FE5E6075D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794762622;
	b=E2QEqGHo/PGv44tpvQoaolcr/jXNc1OSJfFB6f4XKDJvAaisj0yUF7E+wtuah+VfYZCk
	 YTpp0AMtpjrSk/ifYomhAw5FtjMh4q0JiS1+1x9/KuJ9BECaM7q02nX1x4rH8BMFLL0RP
	 tkzsPshdy3bUxPXWhaw//6SAXuQo/78R23E2Zb3ScirFRA4UqVmHASzW56LwhV27EW72r
	 NUPvoTZbocQ6DWOphBbZR86wQnppbLHEdUevObTZCfW/qHyShmBoH4bObRBUidoxIggoB
	 HJYYm5IxliZX8Aj5lm3oCYlJFnzFiBMjdw0Wbd1YM340/4tRl42u8YOXOaEtc8v+x7w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794762622;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Gb/w/JHv6bboxnSdXIfJ8SF7N9czC0MqgHtphKqoZEM=;
	b=M53RMmwzR0BV8J2qOcug83H6R3rsp4ETcojw+6xZ/OpIUvT0u8mwfxxl6uZsHKSkErfA
	 wgcaUFKfMGbZfteGhf4myrMC34J6Pk6DbelldU5iJzq6M493HjKAgI2uPwYWDaqM42twd
	 pJdnSOk9Iib1i9KEGmnmjzRGwP5P58sK8CSlSFA0siGFUCtsHURyuW8aYeUC9JUYVBxsj
	 Q0UW+9cjO9sE2tfV/Fzj9ZrxvcU4Ee4vstIFVAOuy0MMW+9vlJaHFeBvCqx4kiVJ87eAo
	 Y5eeuIe6r24IaT4AJnAel4HI8Lg6MB6vehNoZrSJm2hLzOVM9xY44/X3yAGQwCpMHRw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794762622;
	bh=Gb/w/JHv6bboxnSdXIfJ8SF7N9czC0MqgHtphKqoZEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rgU+3fpU56qwQRe2n5vRQLvv8d0ldTaLThhQX9qum8e2eNytZw1sijxmS8Td3n31c
	 2Fzo9selQYePjj3r2ViDvJwdxdPJ21NDW5pNNd+MfcRAZNEXqOvumQHEAwqoob9/xI
	 EIVLNveUTvcI/3kjUXEQ6d5e05BMKEjqaKrheYMYC1bG9I/CLBYCHSGnnAKF92EOcY
	 jyTjNwVzlSbLhpbENkDzR/VwhTOBUY5fwQ0WNwOB9SWrbg9tJzgT5QfR0I+MiZhkvO
	 OvH5Vnp6j7e/xNBY4BxzxaOUp4WfKLanofe3e/G/Ir0IP15/sem/BdUreIVXXFymhe
	 TKBuuS6VJdsng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7FE5E6075D;
	Sun, 15 Nov 2026 17:10:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9F8B5109
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 17:10:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 87EEE80EE8
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 17:10:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pNSx84afC6mo for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 17:10:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7EAB680ED9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c35; helo=mail-oo1-xc35.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=FM57U7ss
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7EAB680ED9
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 17:10:20 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-716d052dc23so970344eaf.1
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 09:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794762619; x=1795367419;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Gb/w/JHv6bboxnSdXIfJ8SF7N9czC0MqgHtphKqoZEM=;
 b=FM57U7ssNA6Ax3A27avE+6OU8IHBKcz3ZxNdFMXwN1gaSo+dYAvNtiCQmGtDEOgXxZ
 h48/6sXNwezwKUQZr4Ixgkww5LWS+ysO2aRJCWTAQIm1fSMLogRgIjcc3jIB1Ph51t0K
 RUzRncAf67k1Ak+pExkt5Y+YkTIaX5DRpSrEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794762619; x=1795367419;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Gb/w/JHv6bboxnSdXIfJ8SF7N9czC0MqgHtphKqoZEM=;
 b=SgFW0fwTn3pp24oicivZVlmVXane4DGVX+ixFyZRsDP8ulyqBCkGibzWwDSUeSdxWY
 ppuxxz5db0bJkkuIar9xPEYdTNwuwGaycTTvlKJB1/GOWMsX4o/0SS5ugFBFwPU+HSAi
 /SbIobsdPtTxzsXLkrApCpcCd+jevYJVDFX8vhxgazb/koxPYIJ1EKLCA1u+3W1i7vpa
 rnj1lrJ6+av9czzyADI+KGBpyZX5UwVYPPvrpNtE6fiu62Si6fW1yA36xp2mYaWycnQ+
 rCz7VfvGZYb9EH01qtiawqvdkb52kSSwv47Va/OKQKKnyOYQE5q1DetYpSwrDgLmGOLQ
 g/yg==
X-Gm-Message-State: APuU4Z9Zqu3J2xP6Q7AM1wOpOA5GYmJWYO04cMXLjq+4HRO2HnCQYgs3
 CVsIuqrbbj5IdT1XVJm9PUCu1u2E6U7qv3V85jR7wdkE4DeJnQ9qfjSfq+eFJGM1IEQ=
X-Gm-Gg: AYBFou1Y4Z7yMwvJzOL8z6Sj1F0bJRQ0JJx8urGhnffpt0HpqsD0JxbpaSQUWKD4i5j
 ztt4N5J2o65NUdguj3wrHreJM56gXVBLhRHAb7zwHQ1rO+/suXJfarFQO5A4lkqX0oHJ2iwkihw
 P9wGh1aaUHdgC3HIrJX/sdaji51w5uy9wTtUySgnxbxTQDV9s+YMuqgCtfTIg8PfeCAcarWUVuK
 6MLrW9din4NGM8wriI4tz6n/qJMGAJ0EMr1HkkvkrojKTS/7d2KzaXMQDK35+2DnUMhsBaNm9Am
 WOMemSzXmxpoY3scG3mX236Mdn8/U7tyLnM2e9elQysuY2o8fK8Pa0XThw7EKBIlP0g4yGU/RFX
 oh5g7xYS+K482mjMxk6Aubvq1Dt/0G/svNe2nT3xIQqc4Iem3Dk0+Uu7xmzmHP8Vv8rtk8RgCJR
 gE/U67P3wVLRzP3QHJ8HyVZV2ItWTxzmBQZ+UjD8FBbCgZSnoNRPybI6diJzALwpr3fLZihpyXS
 PtazzptZU8YOv90WVEIYxjX7DEqsFdZSwvDQXKIpMhKIYHICsJWkvcWGB0zX1dfOe90WAmdSRvO
 CMF+pKZqKFf30WiXUUPV+KdAlcuPY/DtSVcUCRl+valY27P3oxVI17uHj+AsI7Nt3n5XyaNiPoH
 uyhZALjhuVqC/naCPFwtuK4ceS0yss+86TkDJFCPP5yaJ68rtDkWudSPCif1hYF3olw+ItuIUoh
 kJtDoQmk5CDdfAni3GtFDYmweGEspvgOc=
X-Received: by 2002:a05:6820:3503:20b0:71a:f0dc:eca with SMTP id
 006d021491bc7-71af0dc119amr390696eaf.40.1794762619201; 
 Sun, 15 Nov 2026 09:10:19 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71af0a8a18csm801314eaf.4.2026.11.15.09.10.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 09:10:18 -0800 (PST)
Date: Sun, 15 Nov 2026 11:10:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Zhouqi Jiang <luojia@rustsbi.com>
Cc: u-boot@lists.u-boot-project.org, tim609@andestech.com,
 leo.liang@sifive.com, me@ziyao.cc, sjg@chromium.org,
 alpernebiyasak@gmail.com
Subject: Re: [PATCH] riscv: Add RustSBI firmware support
Message-ID: <20261115171015.GT554944@bill-the-cat>
References: <2744044E69DD25E5+20261115143808.1812787-1-luojia@rustsbi.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TZf4KQVlWYqDnrMh"
Content-Disposition: inline
In-Reply-To: <2744044E69DD25E5+20261115143808.1812787-1-luojia@rustsbi.com>
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--TZf4KQVlWYqDnrMh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 10:38:08PM +0800, Zhouqi Jiang wrote:

> RustSBI is a security-focused, open-source RISC-V SBI implementation
> written in Rust. It is listed in the SBI specification with
> implementation ID 4.
>=20
> Add RustSBI support to U-Boot:
> - Add SPL firmware selection and dynamic handoff.
> - Add the RustSBI FIT image type and RUSTSBI binman input.
> - Update RISC-V FIT templates, documentation and tests.
>=20
> Ref: https://docs.riscv.org/reference/sbi/_attachments/riscv-sbi.pdf
> Signed-off-by: Zhouqi Jiang <luojia@rustsbi.com>
[snip]
> +config SPL_RUSTSBI
> +	bool "Support RISC-V RustSBI firmware"
> +	help
> +	  RustSBI is a security-focused RISC-V Supervisor Binary Interface (SBI)
> +	  implementation written in Rust. U-Boot supports RustSBI Prototyper
> +	  dynamic firmware, which is loaded and started by U-Boot SPL.
> +
> +	  More details are available at https://github.com/rustsbi/rustsbi and
> +	  https://github.com/riscv/riscv-sbi-doc
> +
> +endchoice
> +
>  config SPL_OPENSBI_LOAD_ADDR
> -	hex "OpenSBI load address"
> -	depends on SPL_OPENSBI
> +	hex "SBI firmware load address"
> +	depends on SPL_OPENSBI || SPL_RUSTSBI
>  	help
> -	  Load address of the OpenSBI binary.
> +	  Load address of the SBI firmware binary.
> =20
>  config SPL_OPENSBI_SCRATCH_OPTIONS
> -	hex "Scratch options passed to OpenSBI"
> -	default 0x1
> -	depends on SPL_OPENSBI
> +	hex "Scratch options passed to OpenSBI" if SPL_OPENSBI
> +	default 0x1 if SPL_OPENSBI
> +	# RustSBI shares the dynamic handoff but does not use OpenSBI options.
> +	default 0x0 if SPL_RUSTSBI
> +	depends on SPL_OPENSBI || SPL_RUSTSBI
>  	help
>  	  This bitmap of options is passed from U-Boot SPL to OpenSBI.
>  	  As of OpenSBI 1.3 the following bits are defined:

To be clear, I think all of the changes to make things more clearly
generic here are good. At first read, it looks like aside from display
strings and a different scratch options value, RustSBI and OpenSBI are
interchangeable as far as U-Boot is concerned? If so, I'd like to
explore continuing down that path more.

--=20
Tom

--TZf4KQVlWYqDnrMh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavnndAAKCRAr4qD1Cr/k
Cl/NAQCHkJqWk9HxWVHxv4X5ye8ySQAnvEAmDV1wB3aYc9w3iwEA5NXU1x8O4p8S
o3y6Gkpo6DotVma1GPEb0kBt0a94iA0=
=4Ut9
-----END PGP SIGNATURE-----

--TZf4KQVlWYqDnrMh--
