Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA9C606A31B
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 21:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lYYdHMiB;
	dkim=pass (2048-bit key, unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=Ua3fd6eq
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 57892814C8;
	Wed, 21 Oct 2026 21:15:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xsO6C8cvt8c5; Wed, 21 Oct 2026 21:15:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3ADB281467
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792617304;
	b=bOG+lWDCLkl7pizF6aDRBDRHFvKh+963syiR+Ly0725r4RNuANiw9nUJXwp5ytGunsoh
	 kspFuGCD7Zyb3PuR5bIDUETdv6Oq+ESPyuPdU6vTKwEXroKU4BAH03D/PmmE87Vl9HsJQ
	 t0Ovw68yKWXdpFQeKM7xz7HCCRCoRt/GrtsDxOUvB5iWmxk+h2jmgQajcJG341xoFCq4y
	 v5AUWSPbuYeQI/9CiR+D9EIo+8B1cCKUzUTCuuwUNKB17yI5byBZQGc+JW8bLHHxrlini
	 +7x1iBsInut829AcNSl5Nvh/E6xUPnmKOXKfflwJC4cyiIAGL6MtW+JlleVRwcL1l6w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792617304;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1yGWNp9JM/bccqnicjuz1lu80E0Lc27QbVjdvAFSA5I=;
	b=BmjbIc30JnxZqaPGjCjEFRgcAjLodtAKFANM3MqheRQVqmNEtlU17DWGSWcbVYfXaxwG
	 6j/cYDNpwPVAxrIjNfVIak1B7hlARfpWiFN/FTregcdz1i4qwp74/45OCMdlBD0LjeokZ
	 y+cYaXXERO0XSMJbaAtF9GSi5588mcg526Uw7EH0/SfgDAbF4Iw2pRocVpLhPZzJlh964
	 rrSC3ur2QzWOK26a0PtTP1FlzMNG256pYdorpA6pif/hJnOjsnVJY4kaEj+1dB1v9Cy2U
	 R+hmWgLtzSOJAybKU6HUAA4KjR/JjB26SNn5j44In7r9L4Wow2VyGVf9KxxlLXSLSgA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792617304;
	bh=1yGWNp9JM/bccqnicjuz1lu80E0Lc27QbVjdvAFSA5I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lYYdHMiBKFdrRDNoOInMbFGDkH2KtaH9a2NJAz5HHZOmO5xDjVKTN77QdcDJDlBE8
	 U7EsTReQ/cL/n+8lGQehhWIfcCRXhCyTfKMkL1cqdqbcvBPixaqmkhJ6e3QUbKcs1x
	 Oc4R2LRpFH7rsU1x9/8mv5F9zbyApBB7Loh/yKamWE1Obmg7CYSwoCL02v7BYdqP1u
	 j7gbKIEsg/PAe7s0XIvWF5KpriIp3isRern7HPbqBUBVR7Xg8spVFhygKNBYm+30zc
	 Rk3eZfcGUcNiMYoKbQPQWenyKwmRV5UyobhitxF9rHWW524XFEj5QinNIp8di3GLOm
	 lCR4XZlC0/rcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3ADB281467;
	Wed, 21 Oct 2026 21:15:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 238A01184
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 21:14:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 09C2E4016D
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 21:14:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GHl8zhcYmP-f for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 21:14:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C15E540042
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::12a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792617298;
 b=r7Gzp+LLUvwCYSSEMJ795VetHcD79ELcYtN/Acv8Ng3uqTSIjbXFWtiAJlAl3ZBIlyo+
 46rx+yFqnb+OTsfcNZgHF3ru05C/uqLKYycYGuPPi8pQTFMWUXNahUkCzv0t5IsXpwG3W
 Oi9U+qqLoaE6e9+4BQ2m57NkluE50uk6Gr94sppwxWB/tjagv+oP8ou7PK+rs7GFoNkkY
 xy8vdM2vgy0ZmDqNBWEGvUpMcX4xU2rq8gHBZfdzXGmidXdJMyRWeLxaHuNliBZzuVgd5
 z/RqVslp2RoiaqL7NLbfE2alZzySrPGYUO9o/AO5MINH57SuIYxw4yfz/V4iHg2yrzA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792617298;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=1yGWNp9JM/bccqnicjuz1lu80E0Lc27QbVjdvAFSA5I=;
 b=ZjKudz5RZBJxrA/8vypiXbTleh2aGS9u/Ii/P0HFxCe9cV3WfsOo9A5Otraz7TplkQoq
 WesvTpq+GwcJHuI4XJ3ABwt+uKVhVXV+JMx791yltTxyRYIKSVFTtF+QhDhxSeVk0sFzM
 9LCbrLX3mL41IlBZTPM21yosJUgYSBWW5BJqxiZ9oVmtapMAZls2QOXtXmcoMp8diFKZb
 uREQ2NAopP2Ms9qtn39BCC8qHaVPdKhDsF79stL4EZyEssyj0yeh45AV7bquiB1MfHTMm
 XXxtzL4HV5eDowoF2ezPdo5T7VfGy+pX8bonjphAFa0WdGbi/Y6ZQxo9BM4wuBxIrow==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.tenstorrent.com;
 dkim=pass header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=Ua3fd6eq; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::12a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::12a; helo=mail-lf1-x12a.google.com;
 envelope-from=asrinivasan@tenstorrent.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=Ua3fd6eq
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C15E540042
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 21:14:57 +0000 (UTC)
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5bcb0f245e0so860141e87.3
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:14:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792617295; cv=none;
 d=google.com; s=arc-20260327;
 b=N8VCb0CBx0qFtzKL1AqIhrLuSXqbqBa3JJRNnu8sNvRtOK4ccGXXBWjtReqVzYXcS2
 vd858Ps3I1Z8CTTssGQMp6fk9wS4siSshHuutsk4P9dQgfY0Kxjn5VLk+SLGU2abUEAr
 45Pt5FOoydU57+Y3R9Z8uCF4r5UIhx2HR4+SQi52vdG1zZQyv7A17jsfxF1hEc8s8aGZ
 Jo5l4sOUqvvHbaGfNCyKSI+YejNEgq5MQ3TbTxJuEvLO+m/J2sCS0tffp2nGRNKb1VM9
 bkLPQaom1a+jmXEkTiIhLpmsnLZ4Tu5iW4umKHkZKvacTLcyfpOXPcmjfsTuG6ZzdYZI
 I/0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1yGWNp9JM/bccqnicjuz1lu80E0Lc27QbVjdvAFSA5I=;
 fh=9nKUlhGe85zM7ZxXwpTkybNubzrC9QGPktgkmCMYHQA=;
 b=II4Q1eTktRPXY6jhYsUklwwiXNfpWAywv5EauFiZp9eq/T+XvvtilRpQNbR0ztsc+S
 oLt8okqwyCrsgM/fFPZPRwoW9vlf9bJZhtd11J5crJeLkDUn87C311jQceDsossEbA/u
 Hvq9dA8UVJOUmCiEIdO7o/jEifz35ky6uV8hqQx4ET7nkZCm//2D99TE9sF7iu/7gszz
 Ym45l1QaGFri+VA7w+A4kNRVPUSwcrFAh784NkWYCGyJM7EMLaHqraaEnQrPyCaArS8j
 YKYbhRKYxp4rz44QIebk7Di4q/TL7NHTKPg25SCmtqMqUgkrtIeJFTP0+ZnWQhhyE1wQ
 chjw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1792617295; x=1793222095;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1yGWNp9JM/bccqnicjuz1lu80E0Lc27QbVjdvAFSA5I=;
 b=Ua3fd6eqTCMMEEBpRUQJrzMtLBDv83v0OHSyApTYMX7UEu8KJLiS5EXHCPP+yuT/p5
 X7Xmw0WReOHJN0rIfMsQtjCq1s6wzMqlLzHF17NKKJEyRmIZbihcNHdP1TpjfwODm1UM
 08FcYiAEfvCXCAKmcuKGq5OAqkVDazweqnVqE1BugmE+SP2ZPeengMRdRnvDmp0/3Hz4
 KNSrjM7ZSdzv5pkOlUdvC8DcPY2pDbCNcucbhhm9Jrz7XJHxJeu332I2OOhDCody7ROF
 9cbB7dxYffhUZMIKYyGOUMXODUgSALWbDOmJ126DqKuulqD8dDkVe8vbMXYvOM02XGin
 0TLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792617295; x=1793222095;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1yGWNp9JM/bccqnicjuz1lu80E0Lc27QbVjdvAFSA5I=;
 b=o2izLsyl+YHcjITkHVlQbk7ubad+wl9s7Sl4IuKtrdSs4oWpuQHjMLUkXmJKLqee0m
 qHUFxjyGXubMkeHtPvErncdf+5SdG2kBypVQAcEchEq+1SohfA2jTEJ+8+uC3VAOHwSw
 8Xk6+hbsov9qegdxp6GxlCcCdtl3HcjOnrdffF3ooqhuxAg+0ynK0i5a4uGT5bxVFcz2
 kH9gFAZBGOKirLcUQ8dHCw0W8IGSmUTQb0R/KVTCN5VAo+PKKZ7hXv1G6MxrKy4yoH60
 lzCntfWPvQ6pQG8NLQRy6zTlzAcaf6x7U03BxbCU1ZfdhB7Nw8xOcZnXtgWLx4Mh/BJV
 rfxw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzOXU5fSwlUyv05x0bqWpP4Hzz9v2o9q/9gNM0sbK1LojLDwKcGi2jtegNyv4v/rGbZYDTiZlo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIu5lplD/PGsJTBb5KSbRrqMEXkUqI9ojY4cJz/jR/UKSB1GRf8
 h23B/zadf/ouPlfkSHzvXfULnuNGv1vYSc6DDA5/uex9ek+3akT7eJz3pQ+ZCAQ25gElK7Uojvg
 oUyrQOpLgCb8SZDixnfl8E8iyjvNLEVaxzrKEF6h56g==
X-Gm-Gg: AYBFou2CjYMUkxxPcl3LIut2MRbaPHRCRJvbNWgiOpLq7Au0+gMxkBRvxqUkXv9273R
 nVXSynf8gdXog3x82Jo9ZLRVYml8U6GawCgflULQBi9H4HfZfP02KK/kj3mWL6J3TIgBKcYSGI3
 aK1YnqmpDI2Jfn5bPCOBgnDFtgDKWPADPPJ9APzEk9Gy6kEIN8q4yqWZXmuJwHsm/o2T0dMImFx
 wSNWSu10yv6xlZs/ER9LRk/Um8wXKpq39lD+9wFFLXz5+yjgOh+30hY8oWcQ9QURPog02/93Owj
 qsS0vv5RGSrLAOBuYFwSSBLlax/fRQ2hWbRaBO248oCoLCPhvVdlcbLrZlP6bD9X76L2zcHIdAo
 qDgAz9FJuszz2IjcMARiaTAFyX4y4E89sNANukxg8V/SeuSctbgJEhWCucinbJT7yosIfJuwlF1
 w+oCorhfYBzNkrDXuPBzA1cGMSpA==
X-Received: by 2002:a05:6512:110c:b0:5bc:a9f9:b641 with SMTP id
 2adb3069b0e04-5bfa1c5740emr1273874e87.67.1792617295279; Wed, 21 Oct 2026
 14:14:55 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260803-spi_fixes-v1-0-33f36e764104@oss.tenstorrent.com>
 <20260803-spi_fixes-v1-2-33f36e764104@oss.tenstorrent.com>
 <20261021205719.GA3366009@bill-the-cat>
In-Reply-To: <20261021205719.GA3366009@bill-the-cat>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Wed, 21 Oct 2026 16:14:42 -0500
X-Gm-Features: AclHuK9BYjFjdv8LmsIpW5q7_yKBrnBpRX5utNzc_3saaM3snvZzOuorM_AglQo
Message-ID: <CAEev2e-afN=ryWtttsRL7UYWqawRggTPA3jrn87Ux6h2YycTfQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: dw: Add supports_op function to reject
 unsupported transfer modes
To: Tom Rini <trini@konsulko.com>
Cc: Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 u-boot@lists.u-boot-project.org, 
 Vignesh R <vigneshr@ti.com>, Ssunk <ssunkkan@gmail.com>,
 Jeffrey Yu <jeyu@issi.com>, 
 Shiji Yang <yangshiji66@outlook.com>, Boon Khai Ng <boon.khai.ng@altera.com>, 
 Flaviu Nistor <flaviu.nistor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Tom,

On Wed, Oct 21, 2026 at 3:57=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Mon, Aug 03, 2026 at 02:00:35PM -0500, Anirudh Srinivasan via U-Boot w=
rote:
>
> > The designware spi driver doesn't support dual/quad/octal modes, but
> > the driver still tries using these modes when it sees a capable flash
> > chip in the devicetree. Add a supports_op function to this driver to
> > prevent this from happening and force single lane operation.
> >
> > Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
>
> This introduces a failure to build:
> +(socfpga_secu1) arm-linux-gnueabi-ld: drivers/spi/designware_spi.o: in f=
unction `dw_spi_supports_op':
> +(socfpga_secu1) drivers/spi/designware_spi.c:707:(.text.dw_spi_supports_=
op+0x18): undefined reference to `spi_mem_default_supports_op'
> +(socfpga_secu1) make[1]: *** [Makefile:2131: u-boot] Error 1
> +(socfpga_secu1) make: *** [Makefile:189: __sub-make] Error 2

Thanks for catching this. I think the solution would be for
DESIGNWARE_SPI to select SPI_MEM. Other spi drivers that call this
function also do this (nxp_xspi, spi-aspeed-smc, cadence_qspi....).

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index cfbedd64c4c..a5623a2cec6 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -222,6 +222,7 @@ config DAVINCI_SPI

 config DESIGNWARE_SPI
        bool "Designware SPI driver"
+       select SPI_MEM
        help
          Enable the Designware SPI driver. This driver can be used to
          access the SPI NOR flash on platforms embedding this Designware


I will send a v2 with this fixed.

>
> --
> Tom
