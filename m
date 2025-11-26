Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C853D10F43
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 13:03:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B30318423C;
	Wed, 26 Nov 2025 14:02:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fNQDt+C7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F901841D2; Wed, 26 Nov 2025 12:34:59 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 089A183C53
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 12:34:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ernestvanhoecke@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6417313bddaso10204520a12.3
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 03:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764156896; x=1764761696; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tIXTtaNKhtKltoB0clhLED095kwRf7nqC0JwWzeS0RM=;
 b=fNQDt+C7Gg7J0mKJzokGLVO15vhih/SPAYLJa/pJE6cZAuWRmcBWtijhwZOBovDrKr
 Ns7+ElRguKXJoX4IHbQ8j2u5qJmG6hMSzhUpsgwlO7hqPYW9FZ5uOYNqedxbGQT73ll3
 VUDvSsvWH/h8cUjxiYMzJBOUfUiS2ssxm1VZL5UDArBSf0IyvqLZvNaJQNalVpO33fdq
 Dii/+pZSR/wUZatVOveFcIuDsoqC/hSkJoE3SgKyNXNYhao31mmT/lXJ9gujLPMId7fn
 mFOPNC1qr6l8AHWbGeTkEg6y+C6nriagZaE6SI4czX6cfwty62yVJYdqGdjchRntvsl+
 o19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764156896; x=1764761696;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tIXTtaNKhtKltoB0clhLED095kwRf7nqC0JwWzeS0RM=;
 b=G308KB5QNwx+pwwg2okn8Q2g/4gUWPy7Qvg17IAXQPcAoiPnxAen6CfOm9lCaUV/nB
 9bviL/7Tc80tEDNdVD8k7hhUEZ3IeZcQyauLxHmDvFR1KDpew9Vwtf8HMtdkpbeITI3E
 5oEVk4DcLtWObS6JOBZTKFOShKDGfWCs0QYEEY1U9WxnAS8Ax8xDrz33VniEYcI/G83h
 fLYw34eRiYJlkI8MBhqqrE8Jaxvag1KSOC6PW7Pf+JCQE+dL51IqpEAtNlQEOhM+qWFP
 5EujbWl43JeHsmPL/cisdf4xNRUSqZdB4zDwt3kQUrTq8EEfH19z4t26r8DHBKBw9xdS
 y8lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqbEJPhlZRRDjrzJ/+kTWeGYOJlyPvLH/0MsCjJuim658ZTvBaxhWLgrRWh2nD17EXMtP/XMI=@lists.denx.de
X-Gm-Message-State: AOJu0Yz0lpoik52IJ8G5m+Vx7UHowlkrHDjzq8MQlY2AqRUZT7wFg6re
 aATIFPGNCfz8QeejeDQ7ehOtD03SG7uf0Ilgv2qlRWl+jumMgU8ZEIrS
X-Gm-Gg: ASbGnctjLoyvlVIwKmiN8Q6H1hTi668H4jxU9obCUifVerq4Z7N/HV83RgfebMDfKGD
 UXXoEYUhZGvfwinEjH/tGGicwGnZMlTk1VYdkn7ZdGyaxtP4aIpDuDFtgwtOPefx49WMkY1i3/a
 SxEgBOZxHtb2fo9pUyGmT4jHuS4iUHEDTHEZbsM8n2IOkitKZi7pI3lZW87aFdNjaCkF8SfIbzd
 Sw6NQa/aK3d+spOxAuwAWuabd4fqeNqPiHJx6Ry5b3ftQC2F2RQdzp6q0A3bccs8At14QLlQQmA
 GKB92gFuUN8Dzn1Ql2NbEbWmhSqf9vXloJZLHq9X8aiSZtsByRP74bziJAr4BOV1xyMO5VjHkTe
 BEUsIXhOJasL3rofZbSsLRaA0Lcjq4GSsUVxt6+L3e6BUKiabNKE4Hdhx1gUxqPxFIlod3sbNiz
 LtazRWHmgoRVM82xsu1QO+leY3h5KWEsrVe9oWmhm0LuZ79L4+CRQO32PstklLoHDtHTs/berhS
 ADX/1Doe+rasvl0pKEiCPWd
X-Google-Smtp-Source: AGHT+IGko4NRCDEthJDz61SByLTAw8iDqRPtCF2FfO8ZZdI8zAEM7J/jRty91T7rieoQpZyNDyx5oQ==
X-Received: by 2002:a05:6402:2803:b0:634:ce70:7c5 with SMTP id
 4fb4d7f45d1cf-645eb2b8003mr6479141a12.17.1764156896154; 
 Wed, 26 Nov 2025 03:34:56 -0800 (PST)
Received: from ernest.hoecke-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-645363b62cesm17444518a12.13.2025.11.26.03.34.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 03:34:55 -0800 (PST)
Date: Wed, 26 Nov 2025 12:34:55 +0100
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
To: Prasanth Mantena <p-mantena@ti.com>
Cc: Tom Rini <trini@konsulko.com>, sjg@chromium.org, 
 alpernebiyasak@gmail.com, u-boot@lists.denx.de, vigneshr@ti.com,
 u-kumar1@ti.com, n-francis@ti.com, vaishnav.a@ti.com
Subject: Re: [PATCH] common: spl: Enable Instruction cache after relocation
 in board_init_r
Message-ID: <n57czo3z2lzyarh22y7oien3b6vgyum5lt5z7xe2p3rrcktxpp@qmdmk65aagng>
References: <20250317064507.1702120-1-p-mantena@ti.com>
 <20250317151318.GR2640854@bill-the-cat>
 <20250325053420.4wuenxmlnqsojuyt@prasanth-server>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325053420.4wuenxmlnqsojuyt@prasanth-server>
X-Mailman-Approved-At: Wed, 26 Nov 2025 14:01:59 +0100
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Tue, Mar 25, 2025 at 11:04:20AM +0530, Prasanth Mantena wrote:
> On 09:13, Tom Rini wrote:
> > On Mon, Mar 17, 2025 at 12:15:07PM +0530, Prasanth Babu Mantena wrote:
> > 
> > > ICACHE is enabled in board_init_f which executes only before relocation.
> > > Instruction cache invalidation is needed after relocation as well in the
> > > common spl, which is taken care in the u-boot init_sequence, but missing
> > > for the spl. So, enable it at the start of board_init_r for spl, which
> > > invalidates icache needed after instruction relocation.
> > > 
> > > Fixes: 52a86e69e20 ("arm: k3: Enable instruction cache for main domain SPL")
> > > Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
> > > ---
> > >  arch/arm/mach-k3/common.c | 1 +
> > >  common/spl/spl.c          | 1 +
> > >  2 files changed, 2 insertions(+)
> > 
> > What's missing from spl_enable_cache() in K3 already? And looking more
> > at this, since Rockchip does this slightly differently I wonder if we
> > need to think harder about making some of these hook points generic.
> 
> spl_enable_cache is getting called in the board_init_f and the
> enable_cache here is getting called in the board_init_r, which is
> basically doing the cache invalidate after the relocation. If this is
> the case, I doubt, if we have to enable this directly in board_init_r
> only, instead doing it in board_init_f.

Hi all,

We have seen intermittent boot failures on the AM69, fixed by applying
this patch. How can we fix this up to get it upstream? Thanks for your
efforts here.

Kind regards,
Ernest

