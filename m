Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF5B606A326
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MfrQXyHf;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=c3pXz1Bx
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 463E7606E6;
	Tue,  3 Nov 2026 15:36:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FjVF8VxDrjHQ; Tue,  3 Nov 2026 15:36:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 70CFA606D5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793720205;
	b=OhZj58KEkxtevFMN4181fWIePEnVac8RDU+9HXx3ZBuIPsE7lnf2qMSv3iRD6kwqQx9J
	 IytN84Z3yArm9CEHlZqxrUVCvQu/V4NLPoVVuFCMucDVcMQZ02FfDXot8myiGmwNqErFb
	 WrD470LQePHaBZ1JHNvkEVCUnPPe4A5+ikkQUnaiDk1kE3r4awR7qTRo6nOifnNvgrQdt
	 RaZ8Ah5vXf7zK6CuJ2FoXS6D+cIMxRD9hesQ4k5krsoF29RWWLpIofNmuqzM6uTduvlcQ
	 yML+dxPIordBHBjTnUDN4TS6OU6s6HKL+L0Zfe8WiMv7GGloJWHbA0b0oE0de19lWSQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793720205;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=L2QNDI86kJyqD6/FOJRvEwrA+HkUY2MF1pRAk/E7xLU=;
	b=r3XB+8MM2wFONZYrBIkEyNusqdV0j75PqfgMg+VTSfmqEb1J4Bpd72ySAYESEslNn/S4
	 XWv2Vfwd575nuJlrf/0WDrdw98D6XEfJMx8y1aaZTs0qAhAOSSFM9GinGALQSjgnHLlpg
	 0OXf8ZVUGmS3Cq2mFZDtqpBxjw4g120pgFN39fUjpIlgsT8ODVr+WQwFsvOS8MwZ2WQ/J
	 iI0xfWKJjwgHU48+qeYv3htEKYxG0wcaDuyNf0fxUflwujDZdsGGcGnG4JfgEwkABmMlj
	 mu/ZM1xNnfu/DMxQ9y2UZsx6YnmuaAQmx4KoUr5CxHIeSM7L3zi4OViLpY4QtG9X4uQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793720205;
	bh=L2QNDI86kJyqD6/FOJRvEwrA+HkUY2MF1pRAk/E7xLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MfrQXyHft4jH1wB24Zd8QAHTK9+b03fbyVQhBEh6dEgkSwl6iQptatOThaRDL+yeH
	 GRSfBv3EJGven1E7WPa6ZWvaSTC5tqQ8w9YqzYpQvvlTajoaB8i/RtUAz74nrsaWVG
	 sEDSMKccFav86xnbPRnPr9n5dpoqSD3Pq26FYRrM+UB5hnnpu5JiRDZiY94yqnswCL
	 Xa/fJjFMoZ8vW5fNo0TlwjUnSXKHQsXqYFjDI31vwCGGKlS7d8Vjn6E9VqhKbjUxX/
	 3l1t36H8IsOD4SRCgOLXvr/O++V3wQ+cNGraiCjb7dONrKQjA85sef+umXiz1Atw/E
	 UNYg7/c+T4Xqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 70CFA606D5;
	Tue,  3 Nov 2026 15:36:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C332A10
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:36:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 317DE81053
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:36:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ncTW3VCessPZ for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 15:36:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4684380FE8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::29"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793720203;
 b=fsNUQIufiQdlOQBNonyMTF1/eRU+66hNcYagVyA3Gd/Rzk/yOBZLLkUGik6kMnpg16wc
 2ybyMiL7r1WyZt9VG6Q9NGVRU1KRiGZcLocx9xy7X/RLXqY35bngQBev/2307N4W/xHTx
 z9S1cIcJFk5kFo3Fd9gv4aXWdOaF/HBkF6BkHyok207Q0lJIjtLU2zhw9EqfmX5av2/nw
 HeUNCrnuLnT2EjJjpRBQNZ8HolVfvM5FjMEnNbBpVMBRnf+u1OpJ0z9iyXkukHi/6zm7J
 SmNlMsupgc0Qy2yx4vorDtLRDLcnIf0LtIwYVJeTlXwuvWrekI1yyNIDW7crjRhfdHQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793720203;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=L2QNDI86kJyqD6/FOJRvEwrA+HkUY2MF1pRAk/E7xLU=;
 b=b2+5b0cXF4KX74ocMae/OSGMZc+A+262uxjkexU+klmdFZv211nMEmWQpn5lrFhXr6++
 4//RCuPkOQKs4i3ffFsx98Ce+eX11wxRJ5jmj7+3/AuRDjdAGzsqptHPQ+JBpRX42jaYA
 mjYHnrLmyrwkOlNcguANSRbpdVqR4fqr1Wyt3LL4rsxHgFBmADdftoHnjA7B+QyNcA8jC
 xjtzcRmEkDwAwvy+nMEj3J/3IXXv/NcV3j8Nu1vi/2TwbR0y9PZoRvpQJNtgia8cGyKJT
 +GGwg4ijO6WfC3WXp+C/e/AeWuDQALw/OkwOv+VoEzLRREdFmoYfzS4qSXp9wtP1bqA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=c3pXz1Bx; 
 arc=none smtp.remote-ip="2001:4860:4864:20::29"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::29; helo=mail-oa1-x29.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=c3pXz1Bx
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4684380FE8
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:36:42 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-4932b13c4ccso2735124fac.3
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 07:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793720202; x=1794325002;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=L2QNDI86kJyqD6/FOJRvEwrA+HkUY2MF1pRAk/E7xLU=;
 b=c3pXz1BxbeWzmA5k3Op0z+Bv4JPew/93/0cQetlL5i/YpqZHSPxdn9Deq22Qk5bNgD
 xwydp8Y4EaiHRGbNpbPOXbEzqvn5j9QEprSNK+bQdpZQnyQdB2uFfgclLQU8tu58NR6M
 JmxxW+f34PBfMbaDxssyyZlmalpnW9+BbreAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793720202; x=1794325002;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L2QNDI86kJyqD6/FOJRvEwrA+HkUY2MF1pRAk/E7xLU=;
 b=ztn0EenFyIcBeQAN3ZRlF7GJgQAo4Rlpbgj2CTWt++fkSLc3w67hmPOZPWt5PS5Y4z
 8CPt2Av7r3iB7yNfdSqJeg/h9wuFtzoZPiZmu9LslAR+8zNFAAhqL7qwnuYPMHrerfjM
 +jH3dhwGy1PO6JAUHtUNk+DRswZAgTPb8K63YVrYzbRqZt/rsi0DVdu+y0ADwhiEdR+d
 PwEMYy7FAn/zxm4/rSddcyB9UywN/sfLGv/dkHeTUABdGLhTb7q3PCINrsbzMzgAkjYP
 sewm9xIzK+GPr+bRhnr4emtT3YATZRkKwzAuEglHcrSgw2aBGY4Eq7xtdioLSxlZSvg/
 D5bQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzNxiusWEuzeyJ0j4eo5hNiuvGeZJczqKiraV/rqNSnwSPQw/WJvSPxYUngKoeQmeX1VQeVmuA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+V+lY6jsftC6aj8Xktx2+KWiQFzTpwQx8LtfKXeKe0Qphq4eRF
 QnAzF0Vt2UAT6tJKa3r8R94LhsWNcauAX8bZI8Ykqx/1fBllWv768ynmzTyPqzFvEY0=
X-Gm-Gg: AYBFou1cZQuct+T5ax0/1bZBVfjNu9nUZ6R5ibb1D7TIrSKp0cJZWLaTPTIM6HCX6Ja
 2oGu3s/PkgC28mRh96JAI+ibNRKRD8Fd2jU4HJ9RcTQiI4CEvWb+iD2A1sTlcJyrv+cH7YLx6Uu
 tCrdNhqlXYWgxlHk/Xsv2kqQxKhV/CMACylukrj4GcpJvpIkW/3/CEXhuvyX78gLphX0SE++XTI
 TVLPrLIoco+sOjmpy+UxLjhb399QjFJq12YYGt6WJjpbQI52XODwjB8yZNDKutB4ACH6e7uuVsy
 WlPkjJBvRSVissmLR3QrgzLUqE+5A+dKAcR9/QOkGy51UK3JtTovFhfQt/79R2cKwtsqhae6nSE
 qf/HnDzQwcMBuXHvl+qQFr4Zs76oIFP3zgmOXwh1ejIvzPzshq8LNl03/FU6zuSW5EMkcOJSQ8r
 V6xQTdYRXEN1oe0zFbDPTwQgMZtybuwJGAwqyWBKgKjDxXw9IJU2UmQ+ywmclBHH1NlJ3oFmTRi
 S0doO0HVrb1tTWhbRDSsthjp/bJtkedsmhwawrjRZdpr6YxcLV5RD5/oCVagiCLXZssPCBC7M28
 TO3lCmp+bHdm+SPWBxRWA83veNKCrJ+14cN+gFnaRBzT6JbYYcCqe9BbLXsjKSs9XU/OqhQemMT
 X3TVOH3od1zgkBq9wJgzhmluFxcUYQkeZaj6o5ZHL5HmRU6ZIwz0RHFT5eb4lwE3wm200+9m8ab
 5kSqJz3yqu+sOn2QJK5e9ynFWdf1dhTw==
X-Received: by 2002:a05:6870:2898:b0:499:f197:d79 with SMTP id
 586e51a60fabf-4a90760008bmr7932514fac.17.1793720201574; 
 Tue, 03 Nov 2026 07:36:41 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a9219148cbsm8629664fac.3.2026.11.03.07.36.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 07:36:40 -0800 (PST)
Date: Tue, 3 Nov 2026 09:36:37 -0600
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
Subject: Re: [PATCH RESEND v10 02/15] mach-snapdragon: Kconfig: Auto select
 options based on configs
Message-ID: <20261103153637.GQ3309461@bill-the-cat>
References: <20261102-spl-v10-0-224d421c6201@oss.qualcomm.com>
 <20261102-spl-v10-2-224d421c6201@oss.qualcomm.com>
 <20261102145415.GT3309461@bill-the-cat>
 <aumqvpOI3ACR8pbt@hu-varada-blr.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MKKUAooWYm2rqO6J"
Content-Disposition: inline
In-Reply-To: <aumqvpOI3ACR8pbt@hu-varada-blr.qualcomm.com>
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


--MKKUAooWYm2rqO6J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2026 at 03:04:54PM +0530, Varadarajan Narayanan wrote:
> On Mon, Nov 02, 2026 at 08:54:15AM -0600, Tom Rini wrote:
> > On Mon, Nov 02, 2026 at 11:18:34AM +0530, Varadarajan Narayanan wrote:
> >
> > > The commit d38787bb5dafa ("mach-snapdragon: Kconfig: changes / additi=
ons to
> > > support SPL") auto selects options that may not be applicable to all
> > > platforms. This results in warning messages during make xxx_defconfig
> > > and/or waiting for user input for on/off or values for certain config=
s.
> > > So auto select options based on the enabled configs in xxx_defconfig.
> > >
> > > Fixes: d38787bb5dafa ("mach-snapdragon: Kconfig: changes / additions =
to support SPL")
> > >
> > > Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualc=
omm.com>
> > > ---
> > >  arch/arm/Kconfig | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > > index f307340e3aa..51d60ef65fe 100644
> > > --- a/arch/arm/Kconfig
> > > +++ b/arch/arm/Kconfig
> > > @@ -1147,8 +1147,8 @@ config ARCH_SNAPDRAGON
> > >  	select SPMI
> > >  	select BOARD_LATE_INIT
> > >  	select OF_BOARD
> > > -	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK
> > > -	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
> > > +	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK && !SPL
> > > +	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK && !=
SPL
> >
> > What's the error these two trip up?
>=20
> Will remove these. Earlier, without these got some error. Not getting any
> error on recent tree.

OK.

> > >  	select SYSRESET
> > >  	select SYSRESET_PSCI if !SPL
> > >  	select ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
> > > @@ -1161,12 +1161,12 @@ config ARCH_SNAPDRAGON
> > >  	select ENABLE_ARM_SOC_BOOT0_HOOK if SPL
> > >  	select SPL_DM if SPL
> > >  	select SPL_DM_GPIO if SPL
> > > -	select SPL_DM_PMIC if SPL
> > > -	select SPL_DM_USB_GADGET if SPL
> > > +	select SPL_DM_PMIC if SPL && DM_PMIC
> > > +	select SPL_DM_USB_GADGET if SPL && USB
> >
> > You're allowed to have SPL_X && !X. Presumably some drivers are missing
> > SPL_X options, I know I've seen other series go by adding them.
>=20
> Ok.

Thanks.

> > >  	select SPL_ENV_SUPPORT if SPL
> > >  	select SPL_EVENT if SPL
> > >  	select SPL_GPIO if SPL
> > > -	select SPL_HAS_BSS_LINKER_SECTION if SPL
> > > +	select SPL_HAS_BSS_LINKER_SECTION if SPL && SPL_SEPARATE_BSS
> >
> > How are you tripping this one?
>=20
>   GEN     Makefile
> scripts/kconfig/conf  --syncconfig Kconfig
> .config:219:warning: symbol value '' invalid for SPL_BSS_START_ADDR

OK, so yes, here we get in to a question to solve. Using
tools/qconfig.py there's exactly two ARM64 platforms that use SPL and
*don't* declare using SPL_HAS_BSS_LINKER_SECTION, but it's also true
that they either add a default to common/spl/Kconfig (or
mach-.../Kconfig, for rockchip) or *do not* select it, and then enable
and provide the address in the defconfig. A separate patch to either
start populating default values for qcom to common/spl/Kconfig or to
drop the select and enable it along with putting a value for
SPL_BSS_START_ADDR are how to solve this.

--=20
Tom

--MKKUAooWYm2rqO6J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaun/gQAKCRAr4qD1Cr/k
Ck8UAQCLGkbul0Tq92tJLE9RL1/3bWg4sPnp47mGpyLna56TkQD/QyTeMxoevSRG
VIoMvGDc8tBCdfftYxfEB0OITm/oOAI=
=HwIH
-----END PGP SIGNATURE-----

--MKKUAooWYm2rqO6J--
