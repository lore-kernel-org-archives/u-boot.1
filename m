Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142A9606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 10:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fzmk1sJE;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V1SglFXN
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD7E1605FF;
	Wed, 18 Nov 2026 10:44:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jVd6K3ggpvyO; Wed, 18 Nov 2026 10:44:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 717CB608B8
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794998668;
	b=VImGqQuelAMA+VJb4UavZOxxbPzeNfMoB4pQOwN2TWqof+nyqAuyCL78h4XVwNyJwtz9
	 zji6MKjk5NUiUcntEzVHu9i+JxPEZJGSbLk/AFN9Qqr1E1R55tys0Olr+c7XSalO9qGo4
	 WBBI170vHjVcsROBBKgdnObKTBBfsVc2QgkxE7EaNmcys1X4UKfe8PL9V8AmCBpj+fiET
	 Ab2UDWCAyojD68iFSdF5fK4g6NOfot4cwt/hqwCgBt1l2DHVqNpSE9IqEojJ4ALwUPE/j
	 rSEnR257Jd0Y9kgbbtWhiyUmVweXBxYQ6NOmwLIZ1Sa7DrMOP+m+Cu/7vZoQ9OrAeRw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794998668;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:X-Virus-Scanned:X-Virus-Status:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Ohuc6PVwrLnlNr9uJkNx0ivjHcsP68OmMvrUHQII5aQ=;
	b=CINQ6H46MLZE4e+YmNjnm1uafTvCpOhpFnp5BhRWMGbcUCQoTwZ7rePDjiTw+7gmocGR
	 E3hh/3R61HCJkf6YSg7wh9qKmmb8hiJf0zozeEfY0uFt9VLk7QH26DUA328MkVp5xHVG/
	 YVrn3sj72FJ0jwVy/Lh4UcZi0C5YtvHf9VTixWL2y0m9QbqE8dQdnHE1y71XbmJzA51BY
	 FpJDpI4laS3XxiUnM2N0z7ADpXZt+u8KKr+Az+yJGze9y1N9a5eEsPPv17gzXwd6vw1zA
	 GmtMcK18AA8JvLRu38Z5GshqS7ykZq4whsG+xjMNDhTUnSudaPfcPk88Mbg7oDKKwXw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794998668;
	bh=Ohuc6PVwrLnlNr9uJkNx0ivjHcsP68OmMvrUHQII5aQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fzmk1sJES33Egs2R7w5ODs2c7sWmB6VjNny/uUOQh5hwekoYDMqratThUbzUGuBG1
	 3zh/O8A2lDmX14SYob01Wa5UBOf3Grg0I/1C+S6HZBmzxH5eHkJPPQ86wUs7jK7DhM
	 mwUUnJoY8qXWeb2XH4jdMGQT5+QorOamdLcmY6f6y+wZvPFj74EYVaQgjZVwsMhVcw
	 N4zgrWPGZBmSD3spbEL7ensEl8E8ReKKfrKB1rzu8AeIiX5uZHxw45+6CXIlm3wRPj
	 CSwzNxk763DORwrFkURYXw3uROB3cL35voQKVEJjcxID4kqceM5tk4DlX9gPdCBHtz
	 dtLMjINViO8Ww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 717CB608B8;
	Wed, 18 Nov 2026 10:44:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CE9A3A0E
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 10:44:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B490380D87
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 10:44:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3faasYMq8Huz for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 10:44:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8AD7D80D85
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=clamor95@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; spf=fail smtp.mailfrom=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=V1SglFXN
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8AD7D80D85
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 10:44:25 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 592D684819; Wed, 18 Nov 2026 11:44:24 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74983847EB
 for <u-boot@lists.denx.de>; Wed, 18 Nov 2026 11:44:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c40f29667e6so115544966b.0
 for <u-boot@lists.denx.de>; Wed, 18 Nov 2026 02:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794998657; x=1795603457; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Ohuc6PVwrLnlNr9uJkNx0ivjHcsP68OmMvrUHQII5aQ=;
 b=V1SglFXNswawI4oliU0VmmxFuh/VNYfmm6DSYCXwdVbULSeHnbfU5iOLcYV6vxIgNs
 rBedCzYjqnf3gNauAD53tRVoBBqtG8AxVB7AxIrNkhWbPBHhppDepqfXp902uoo3sdvU
 hGzCsnuJiIOUuOH5ADX8cOxkt4OeeiO9yvaquY+oW7v0r1pNksXjVWqn30YNd4zErIu5
 VILWFhCWn3NxHGWKqCUQefAJfF3XwTgVByKMP7goAWfvxe8nuis2wLGJ0EuH0IpV6k2Y
 L+st4fOcITKAJa0nfes9bOBP1G1QzPtKl+aIxBBf+ZdqTyOyL0gYjv6stDSZiUuB3KQx
 jTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794998657; x=1795603457;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Ohuc6PVwrLnlNr9uJkNx0ivjHcsP68OmMvrUHQII5aQ=;
 b=P/96nGiMd4tt6nOCS4Umt+Niid1Zedi8GkKVnJoJbXbfCYJN3wJAk03Im+TAu2nDt2
 a4tY4GEA+IeOWqBRr7yqfVseEXYYolGfnCq21m3PnpqwvimuheqM7nZDIpvj99zM4Zdr
 BC5Vyy8x0vZti9KQOP2l2jLuraw+LOlK47z3f2iUsCOIPrcxxKaxpHsCublLMYRXcRJb
 7WKtyf3T6XhmBuLqdJQZX5l+3Sds6tq8ni05k1PukoaR4Vaob1fHm7Yn4SwQLNtGethA
 ktIKBikdDUbxbWiMppoCMEGexHdwKCUNn64HrIoUfO/CmSRZddOGR/1lLUFO3DqrZ3d7
 jp1Q==
X-Forwarded-Encrypted: i=1;
 AL+hErGrLs2Sy+fZUECgFuNpSRimhM8rY5zAD5S+ndocnYasSS8XnmnUyZSXtEBlRNY+tKth1pV+2uo=@lists.denx.de
X-Gm-Message-State: APuU4Z8uE1jr2zMAnH0u2d7pWRm5/iMPhUC4P1tN7MWF6n2QNxQZOQ9/
 IBeuoac/nytQcizLy3Q6jnqzh5EPL0PCapK//sQGGiaMpm3gcNqBA4EjQr3slspa97+rOIog64q
 eIlJEzkKAoTi0PmHyJIde2QEmajVccNw=
X-Gm-Gg: AYBFou09+/H3sTphgjY/vBGjuRvJ0URdbXu/ZCkXYK0HGfGh3CaTW/Wzq/1aLDvGTAR
 D9SfbdfuBxd9u2/HkhcSyaYmZ0m6VmTTBp2dT38yuGHHg3uqN8KdDu2+iqHmDj6DBh0nmce/7Yq
 AfeV7zhrD4dACXY9P4L2wpOOmHLZDx3kj9liVuG1FHyNqUQkryN+UBAnsJl63GKI8H82VSK8sLN
 kswFeGNFaRJm1q/aKcakwkHxI9uYUWp+9hAG6gnXmb4089LCwJJpHr5hQhALi0MolgMNZYs/eaN
 6e4dnJ8rIN1ElMkTFfGpNH0QhyE/8TRPcGEYMI6WTOa0KeYZb9lAxszLztazGK9qQuC9fC9kx5A
 G0KqLVbvnl0zumA6dkwgTZyxLnnu3+Mmek1jECsFviYmetvjazHLeEULtk8Ft3jhbdspsh5WbTc
 38PTcxOyFQgBmggG3bQHkpZZ2fNKAt4w==
X-Received: by 2002:a17:906:eec3:b0:c4c:f85f:aa12 with SMTP id
 a640c23a62f3a-c510e3c9fefmr194586166b.31.1794998656662; Wed, 18 Nov 2026
 02:44:16 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260930075527.92697-1-clamor95@gmail.com>
 <20260930075527.92697-2-clamor95@gmail.com>
 <xhkdbfqy567t3.fsf@mkorpers-koolstof.csb>
 <xhkdbcxt65btd.fsf@mkorpers-koolstof.csb>
 <CAPVz0n3HUqT+TqyRrkyc83r-sDXMcMEXpqPPYxhinvp1rs8pDQ@mail.gmail.com>
 <xhkdbse0ypi3o.fsf@mkorpers-koolstof.csb>
In-Reply-To: <xhkdbse0ypi3o.fsf@mkorpers-koolstof.csb>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 18 Nov 2026 12:44:03 +0200
X-Gm-Features: AclHuK_wKq2ktSgCvKV5Uy4k7DpDETTcQskENOcvxDNuMgdcmsTfDetWJPwUtWQ
Message-ID: <CAPVz0n3NSBJo+n7=Km5+GmyuQ7QQ=FhKydXP=dqBnJC7w4K=4w@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] fastboot: Add
 board_fastboot_flash/erase/get_part_info hooks
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Ion Agorria <ion@agorria.com>, Peter Geis <pgwipeout@gmail.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_FAIL,SPF_HELO_NONE autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> > You are mixing up. This patch does not add any vendor commands. It
> > allows using native commands with vendor quirks seamlessly.
>
> I know it's not exactly the same thing. I'm just worried these extra
> hooks will make stuff less maintainable in the long run.
>
> >
> > For example. Tegra devices require bootloader and bct to be encrypted
> > and bct to be updated every time bootloader is flashed.
> >
> > $ fastboot stage bootloader.img
> > $ fastboot oem board:write_bootloader
> >
> > Used has to stage bootloader, then write is with some custom vendor
> > bootloader flashing command which we have to make, document etc etc.
> >
> > This series allows intercept native fastboot commands of flashing some
> > partitions and apply vendor specific adjustments directly. So I can
> > flash bootloader, boot and system with native command `fastboot flash`
> > but bootloader flashing will be performed with encryption and does not
> > require from user any additional movements.
>
> I understand, that it might be easier from a user experience point of
> view (just fastboot flash <whatever partition>)
>
> But adding extra vendor hooks also means having a specification of what vendors
> should do in these hooks: adding docstrings, adding documentation in the
> fastboot.rst page and such.
>
> I'm not NACKING this series, I just wish to discuss in more detail why
> 'oem board' is a wrong idea.
>
> For example, do you have a closed-source userspace that forces you to
> use 'fastboot flash' on tegra devices?
>

On production tegra20 and tegra30 devices bootloader must be encrypted
with aes engine before flashing, and bct must be decrypted, updated
and re-encrypted before flashing. We decided to use hardware boot
partitions to store bct and bootloader, so we do not have traditional
boot partition. Hence we are using fastboot flash to intercept
"bootloader" or "ebt" and "bct" commands to flash partition and use
our own implementations for them (for emmc and spi). All other
partitions can be flashed by default and need no special handling.
