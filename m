Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B424606A33A
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 21:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WFVIcHX/;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RPlFgfI6
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7782E60D68;
	Fri,  6 Nov 2026 21:57:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m2vkJHj9jco6; Fri,  6 Nov 2026 21:57:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C78BE60A8D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794002269;
	b=q3gvS3TyPBQ/A+S6uMXYs2KDs08/jXebqyRNYUnQmP5wPuX1ka9vjj5rFULHrTZJ9iwM
	 50dye3zn4BTfX0nVzp81/3Qy1FVUy/dfpkAFi5JjMVg6fXS5Malf8xb0XjC6KzfqAF4ON
	 CIaxTnMOuOdRzZX1ELgIRpKvTc9yVOFUqc3YHl6zmGhyMSG2KVJDHGx2v1L3F4KnDbH+C
	 hDZuJT55QDOgmnqEhzuHyM02FJCv69/KhQguUEb+Db8Cbd6bR7B/v+TapoNdEn0Fp2bsY
	 DXoved2nBx2G5HCwvJAcOver8qieIxegY+CEQNs0z2lFaKfW6pO9HmMrQCLm6GbtcSg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794002269;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:In-Reply-To:References:MIME-Version:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OTRmYCSZew7M60W3+HKBhxbZ5cEGQfyrxk0ZfkJ5dzs=;
	b=AugzpAb2BA7rUAEibY8QOamyZorKFeVPMOr3ozQYTOIHG27N2f7+3N32NeHiesS8oBRF
	 ohwTbvQYDthpzLItZlczSR1oAZpfFTuX0ZVbAl0Uh2zch0EU7uooIPkO0SP7qF0gSKuJq
	 5Uwl11bAo+G3hcRcNUqQeoY7c8VxPBC5OU2Dk6vK19lEjvpC75bXQJpvhUbf3D1zlA82N
	 L8EYkOKYf/X6QVCbfxCR6hFgadMrhTSCmP0Y4NMPaYKuOfIZcibMKlX69k4fCdxpVvleJ
	 GocEu4Lrp/kDm6/jEmwgI12I/O15IvKK6e3NRPbdwPyDoVIcRn2g9MSVCkw2HFGnSEQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794002268;
	bh=OTRmYCSZew7M60W3+HKBhxbZ5cEGQfyrxk0ZfkJ5dzs=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WFVIcHX/zMeg1XFaijlJiU5otAby9O3okh2Gv42+UI8OjjIhRThQe4XWvrFMh7/bS
	 /E7kGoMiNRuOse144724rPi8gfS4/O+roIK1DADTLm8mk2C+xoW1CKMS7aopOltzzy
	 HAzrOEUQM4YBrBR7T1nw2Se8mrJ5v1AbJH+WOi2dUweGpYDfMWKwNLYrQJXz6MmYs6
	 Aic88wz+ZGuxgVwJP7DOYRqEZx2EsywDm1yTFd8DfJUGNIU6LnHFfd+uGP2748BAJH
	 z6Pac+jL2aZUKzjbFMSkSSY7gQWN3qDOI6x01QWMx7M49/OSlbo+IKkZH/H6uEQY3Z
	 0uDfRo5J+SkUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C78BE60A8D;
	Fri,  6 Nov 2026 21:57:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 40C9334D
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:57:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 327E781134
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:57:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rT5X-lA53UVI for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 21:57:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 77D838111D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::22d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22d; helo=mail-oi1-x22d.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=RPlFgfI6
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 77D838111D
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:57:46 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-5326cdde017so375500b6e.2
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 13:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794002265; x=1794607065;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OTRmYCSZew7M60W3+HKBhxbZ5cEGQfyrxk0ZfkJ5dzs=;
 b=RPlFgfI6Bd1qQQ+u2DU2NpnC7O03+d5xEyzPOCj36gQ2WI7i/saZoPJeh7okbRB0ST
 EI1/Od18C1wiMvKir4AdIeP6GOXGA1IHnM0XmhkuroSaoZjRFcdHHx29255MXGJCUgTu
 zSHs7smgGS94tCsduQT9xAqY7JWujcNEU0XP8YwFJRmbkf/y5eyVMW1BpPfhOZ8oCnCc
 BTysAGjboLHH/4syDuoy10jwooWzBfMTiqkyO3fu6Cf4B3e7ki96SuxAOdyfFuY+A/1g
 iipMYEJNQ2Q4flxfjC0+M9Xm3DSiv0sPgA4nYtY2JbGHx0doWS40sqMu3oGMZv51vyCq
 7BgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794002265; x=1794607065;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OTRmYCSZew7M60W3+HKBhxbZ5cEGQfyrxk0ZfkJ5dzs=;
 b=S6os0AiJEFrIaVuyvojxccKNfjrA9kpviFWWcmyVLXQFukFb1lSMvIv3BAQxn5Fvxm
 f/3CgHXN8x+E3IEoSXI+qQ2SREzd9AQ7WRzd5v//2eggyI2lYqwTstFv/7Zdtu4elcrm
 Hz2JemLq0xXQE4siveFx8IXKEtDnef1NoFqzeccyKaOqnp26i0XXvMlCTzT+OWreiIxa
 aqzjqHHb+7fU0qJhFA7/fvfYs3S3oiR3kLBRkvVb1sXUc4FJ8OxqNdlMthmZV1RUPTVE
 Qdv6M7+wvaBlyM802HvoY2NLK2UXDM5DQ/r/SWDdLQ4r1amKRQ6Qc7xRWcfZfeuGf0Lu
 OcJQ==
X-Gm-Message-State: APuU4Z/kB1Kdv8/8iGb9BNQSGWEKusT2pTgOdTxj4jgLINggiO86FqOs
 UC9lt7d/2bDVpymwINjTuaEPxUTG7OV6c/CqfFjy7WBWA0+ibSI7nDYq68ekWQ+Y+CYXgKoe8Eu
 xacZdDNu2jxiLZf4nElZG68SpSaynLys=
X-Gm-Gg: AYBFou1ZrDBZBgf+B1J1qGcIvwtiOrSRrHY40+rzQu1kQnGJ7tmhT4dUij1a33qYkqg
 iTR+tv8TAhewzEMs3Qyp77jKLaZUCOWlLgStGd7laROK5DGK9ZndToORuWshkmlXYgKzPxkxBi/
 3xl8mruyKIDM5SF+jyXOly0SZ/vSTaQkrve8mwh0nxcikROX4zPXIDl9frFURgabMeCrvxVnHI8
 o02QMdfkmA/FyHfhYgsyCMOntWd+Tj/Fx2ddtt3aY6tbKxDaLUemk+yweb5hheapX3HRGvYSFpo
 skrbhvRQUOnQRT3gLf9QGX6V8xXZ/5Q9FCHn6aFcQaBsypjJEx9Cc9V7OrHhntpNJ+W1GGAZyIA
 dK/4FO24pYabfOirfrRUrYwuhFvU+tsX+e36dbXt7PJXHG1zJBvcCd+umD+I=
X-Received: by 2002:a05:6808:150c:b0:4f6:2ccb:c2a with SMTP id
 5614622812f47-567e14d012emr2824887b6e.68.1794002265079; Fri, 06 Nov 2026
 13:57:45 -0800 (PST)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 6 Nov 2026 13:57:44 -0800
From: Ana Bobillo <anabobillo3@gmail.com>
In-Reply-To: <CAC_iWj+zKC7O2U_okFwSanZYoafvsr+2_3MHsWvwu90bt9HQjQ@mail.gmail.com>
References: <ad3fd084-d61c-44e2-980f-c978ca1e1dbf@gmail.com>
 <ef52b7da-2f83-4663-8633-9f97929fe9f4@gmail.com>
 <CAC_iWj+zKC7O2U_okFwSanZYoafvsr+2_3MHsWvwu90bt9HQjQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Fri, 6 Nov 2026 13:57:44 -0800
X-Gm-Features: AclHuK_mzSWnFjdts8F4ajdu6zgz77LsXJeSkxBHcNAm_kBCn8mr5cwiddDZpqY
Message-ID: <CAJnxHsj1Bc5TcP8H1N9ZcLnH_HnrObY38HOnTm7+O78JDO9Gzg@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] efi_loader: do not start an image that cannot be
 measured
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ilias,

On Fri, 6 Nov 2026 at 13:49, Ilias Apalodimas wrote:
> Applying this seems to fail. Can you rebase and respin the series?

Sorry about that: v2 09 was written on top of Heinrich's "efi_loader:
handling of missing TPM in efi_load_pe()", which is not in main yet.
I've sent v3, rebased on main. Its patch 9 no longer needs Heinrich's:
the series applies to main with or without it, and his applies on top
of the series.

Thanks,
Ana
