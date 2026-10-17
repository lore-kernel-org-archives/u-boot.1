Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 457B1CCA463
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 06:56:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 65968409E0;
	Sat, 17 Oct 2026 06:56:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uKkor-G9Kw5N; Sat, 17 Oct 2026 06:56:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 92095409CB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792220216;
	b=AVf75Lnly8lQLtG6JEM83igcia2csSxc2vDkP73g/CAeLzDuyOFMbON6L6pjiUZLrijY
	 j2T0poa1G6kB4RnDjqDuRAWepxfB9bbZ50tBP8SPcedzQO4dTw8l7wMAgc4QBkSoCA498
	 iIrTkC+76LFjdvKP9oafEAAtB2XC8gpomXDaB5YcXyd93Xok27S7d67eFbD5bc6msWI/q
	 MiuxvNv6cU0HNUEay5g0xD9/XYE7W/k+UrxQcFHqmaZwer1QBB1oP0bNnNTbSM5vxpdB9
	 t8NYlkFCDF5txc6TZdg88yK0tUQ9tzxe/ViASx5rcuSoLHn7NHprYpAIlVOySlz1V1g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792220216;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=sym44eppMfmECajV2Y3XUlR44fultWJfjOZEWmGPaD4=;
	b=Ox2TxXndyBsBWBl0Ci6aVeMg4Yq7yoEwcPnSTJzR6qSzrDeLpEHO2Ldbf55BYrGzngh0
	 3IB0sUIJIhCPpOdOMVAOGusZ+b+rYr64xTFEJtP9JkPDWyWlhHOj+Q0Pvqfqj35IysXvN
	 gBazuBqEnSIO2Q8yF65m14av03BfIplaBxbGd8g5PtPVQikKRDH2AZ1Mh5K3FLLQIzCXT
	 e19hVP474ZyYWo5HpgrURLFWOHTjXRdKacmTwB6YNA3D7o9tUWehop6Aw5HAU7E/rZSJ2
	 9xOTk+pNiGsnuHs/zw3tsmD7C0BXvc1534KwzBDDzQXJZKDkIbjSihc8s9wwaF8it9A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792220216;
	bh=sym44eppMfmECajV2Y3XUlR44fultWJfjOZEWmGPaD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eEzw833xD22RtrkLPz1Lmbo8G4wIQxR1njcukeMD2Vaafygnz1SYewvA9bNVpA4XC
	 0ANFia34vXvGtO84GOy0wp2huuJjjpBqizW0PfOKKpGMyU/TnNlMkgckFSTmqlg4IW
	 5HwbnJYzD2tT4nrGqeHXNnwtk36YxivQ3y4lX9RgCKUTWa1Ezhc5SkKmifRGP+ROJ8
	 LP+nte3pXdUQlnvqqFomQIRxxs9W5PjHltlQZsAT4Qo22BTeTKI8PS5xDJzHgNU/gE
	 IN3yAblI6Atog0IjEnPLWMTzmxmIstqH6oUKmSSZZbgZfUT7Lg9cGXBdm7i6f69y2R
	 i8R7pi3JY8UdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 92095409CB;
	Sat, 17 Oct 2026 06:56:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3AED075
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 06:56:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 38F72400C5
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 06:56:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5aHhDtHSeebF for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 06:56:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9E69F400AE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1032"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792220214;
 b=JAKgzm3pNdLzQFOVtfNQc/6efMrbp2qLkqujhY0vrkTuPs8l8926HUnBPSpHTTWfiEH5
 Yan3OxdddFi6fJhEHDIuqZ8s21u+YBFUyd05EJf07phwLqAZKlCF2M+DUP6m+rn5SyQhB
 yzO9kSdiFnqx5X5AdwSk27BkjeJNvkwfKRygtwWzdvfscmvsxDErjSFTInMpSvFotCgWp
 kkKaPmQMDu0KMNO6iqwGXTWEiIccK8Bs0bUWPZWkm7RYLhZ5T6zpaixlQ7kr0Ag+BE8J3
 hsd2wuF4wL2K7g3qBaDmUCahNq2Qy0p77aZMF4V58CuVju+40f4GQWJKGV9I4fRCE/w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792220214;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=sym44eppMfmECajV2Y3XUlR44fultWJfjOZEWmGPaD4=;
 b=Pd315ZFejiVbpixi1+AOJl4b7PXqTBbAAD9oNvO7rhMDqBwVsEh6mwjz1azcxSPrV1tY
 YsQsjmHAPgKsvTcNtEKUDemhNfz5WQ600e18/3eDBSzAaXLTLV3mouPbZp2MpEXe1KS8+
 UdtLSLE147h5Tniehxmc1NqTfxol2u3WTdwhj0OkaSRshD59swz5eS2lBAzDlKdj+v2fj
 wo0dKDzg7AVQwQSlMhxUNtE6qU4z4GCbqnY9RFAU5JKeSCqcwYpL9lh2wj162H+bjiOmZ
 CZ1hEtlP1r93lvqeJnMamGnK4SLkuw9CPKQxj4eIAxGnhNbgcWfssSJsAajad9f3gdw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=oSH+uE+M; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1032"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=oSH+uE+M
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9E69F400AE
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 06:56:53 +0000 (UTC)
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3ab868eb9cfso386514a91.0
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 23:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792220213; x=1792825013;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sym44eppMfmECajV2Y3XUlR44fultWJfjOZEWmGPaD4=;
 b=oSH+uE+Mff1GUqPrPLHqNDUf91vjlJqu0EVgE2IoVjU+piyGiaB0E8eFkK/OQaDKU1
 3cobAOKHk7m+kjGTr7i0AL9Em9ww9MTQ2H8jLo/Z9lsx15i2nMoZPyM7F9kF/l4fPFn2
 SvbMZAoTbRjoR0P9Et4A+q0gbm/FsrAhJuZF1fUfZaW5MYhrmTC/KqObIUyL2kn0SSqz
 kn1F79LH4sToE4MF9lz/PgIMEu2Bx0TlEiz0LAFagzFM1gZut8IF0xCnsxMmV1WyqI/W
 XjzuOI7xjWPRiPTFsoGlpc+kjeFUZZkm/Tm++pQPFqgUsSjI2HypDSxO3aHnZf1GnVwF
 SfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792220213; x=1792825013;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sym44eppMfmECajV2Y3XUlR44fultWJfjOZEWmGPaD4=;
 b=B0dx15xLyPYQ7Y3uF3jDPyhhM8UKT7FtLKeNCndx6lRTdiUR50pZj6gNVh3jIYEpd1
 ZDkFYHKh5NsIqHpkXHlpKeVWez1nACNH6LVxKss8bKrI1byksWpiQEMk6cBGx9ei/DeG
 trmx1JO8e92SUsaJI7mbJFcaTaoJ3VsX/o86RXzHuiVWaq71zS7+kKnvcmkuua0zgBB+
 6rEjFJ+KbUJ0i6tDeRp2cua4oi6l8ee+2H5UJ/64OpXf9pBDWY/I60NKxNowV+AlO4Tn
 1K8EOSeFWmTILA5ulOrbHerJ8/cHW0I3t0xODwKRq0qXPvTPllnzKFUbfg2EMTZjzq3O
 xGEA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwO28Nj/+uNYMZSIRUFTb9b9l4gWB6p2+GQpAEGuTug39BoBnu+cx86eT8vSpLSK/AqmPPYSiU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLOkG4xXn/OherQuP2wbSZ4cJencDh6/BXmYm8hg/tK3T5/yi+Q
 JvpqP4+YQUdIMavqzxPGHYZfZk8dWr/u2XESHmVEK6J3iZA0zLteVr+1
X-Gm-Gg: AYBFou0YuSZSyDN+XFZdDozoJxoR4NlPa2m7hVcy2Io9fQyhwBR0bZiDeG7AG82ytYL
 aYnepvwTqUnQKpWqT5SEZNa/M3DF1XzxXe3x9yrMJGi82P6Jxrxdx9Q5k5LFLKi4I04rhYye+HY
 3U4OsCil/0Rnr8aBmVCGtKbuQTCzSLo3UBmHhqVdsL9qfZCnYmrsLzhXa/C57Vrossli/8bWFa+
 DbxQjZKnGJ6K7DhnUGxKnik3AUMvmrocyXcZptmAyAdL17GAdQVRSwK2OaJ19SWMJD8pi1JsSnH
 FgntH2jvAx4FuWZoLzjKSM7B+FKGHSm6qN/48mAxtw+GrB6FnrXjT749RUvnY+K05pdWhPUbAuW
 0FUTpJrFj19sXdNNoCerFfA300ABotfxZrJJnTGOMIApP+/xfHQF0pLppzft1zK9K4SFJKwOX6l
 NZcNMQz4mFUv+5BieuNWCN393LoWFi5RsZ5d82YWuu+Q596uarGMkuMSH/m4p5tcNksm+rEMKpa
 frJxk0RcX5u0COXBbybpNmOuw7782WZRVzALpMI9cibeoA7c+9NAHe6s4rP+Z7S5xzMRSZ/VqU9
 KpUyuYIeIyZACMk=
X-Received: by 2002:a17:90b:28d0:b0:3ab:189b:6981 with SMTP id
 98e67ed59e1d1-3acef51e8e7mr1710561a91.48.1792220212635; 
 Fri, 16 Oct 2026 23:56:52 -0700 (PDT)
Received: from google.com (61-230-12-185.dynamic-ip.hinet.net. [61.230.12.185])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc46ebe40sm7221361a91.6.2026.10.16.23.56.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 23:56:52 -0700 (PDT)
Date: Sat, 17 Oct 2026 14:56:48 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: ilias.apalodimas@linaro.org, marscheng@google.com, eleanor15x@gmail.com,
 jserv@ccns.ncku.edu.tw, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 2/4] board: google: Add Google Tensor G5 board support
Message-ID: <atMcMAg-LS1zfHhr@google.com>
References: <20261016040216.3636305-1-visitorckw@gmail.com>
 <20261016040216.3636305-3-visitorckw@gmail.com>
 <20261016192128.GL259661@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016192128.GL259661@bill-the-cat>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Fri, Oct 16, 2026 at 01:21:28PM -0600, Tom Rini wrote:
> On Fri, Oct 16, 2026 at 04:02:14AM +0000, Kuan-Wei Chiu wrote:
> > Add initial board support for Google Tensor G5 SoC boards. U-Boot
> > runs as BL33 loaded at 0xbe000000. Configure the MMU map, DRAM
> > bounds, and disable the APC watchdog left running by earlier
> > bootloader stages.
> > 
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> [snip]
> > diff --git a/include/configs/lga.h b/include/configs/lga.h
> > new file mode 100644
> > index 00000000000..c770c5837f4
> > --- /dev/null
> > +++ b/include/configs/lga.h
> > @@ -0,0 +1,9 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > + * Copyright 2026 Google LLC
> > + */
> > +
> > +#ifndef __CONFIG_LGA_H
> > +#define __CONFIG_LGA_H
> > +
> > +#endif /* __CONFIG_LGA_H */
> 
> Does this get populated later? I *thought* we had done the required
> changes so that a board can avoid having an empty config.h file.

Ah, yes.
I'll drop SYS_CONFIG_NAME and remove lga.h in v2.
Thanks.

Regards,
Kuan-Wei

