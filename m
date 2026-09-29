Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E53CA5FAC
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 17:41:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 08BA240752;
	Tue, 29 Sep 2026 17:41:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 46i-qUc_lOza; Tue, 29 Sep 2026 17:41:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6492D40758
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790703680;
	b=onN4QxwkNTeelFspOcUFIB5SKSraBFIRbs5hbnIBOsFfAkLePEvon4tBDcnBH/wCFaAI
	 4Pzi2GCTIJa9dr5poKAz0/3bZ/1KqhOVZJGq+W/U0Q75OJGZmqk9kIuBM7ZugqNVJ7SIV
	 lPB3OAhkptNx7LWcC/OuUUZQqGt81hurWzyyKkqcij+/f/7kBxZBDRPoFchKVG+NL8ZrR
	 UfCqTHLPTNm9L70st7UZca+StQew7s5hHHe0YPwRZRzl82LF+J63tyUQT0gF+Zq3L+6r0
	 IpgKdW643DnusLAiVfZtUJ+jXivgyaxPe2lGcSteKpdhN5r20dkwg4SPJZRe5F8C69w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790703680;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=lIZPU28LktjAEqJkfHc9EGMw9QhHd4xz6cd3M3BZwWY=;
	b=dnkoWTbR8lQtJ0dmw9cJr7+81QKWcMmD8W/uhxoX2nIOOlFSm7/w1acYOxZAJ2OBpPQp
	 muwXy/bD+iDHGA1FmYSWHBSt8trRfVhJvyEIX0PMLd4/F1i7q9QTukGXDMJK/9M7GP9Fc
	 ZQ1V4unegnO3VHApShmKabl3D31t1YQBuI0HIjztBsIt2VTyjKHSz9hysSsjiM0xpaGh0
	 MFowYRwPdSneJ0STP3i4C8BuMAJw2rBOWNk8LwdgTa5oqfGpb1Rz8S4Go6IPaxR/VieAc
	 9tUcA7qkplONNDn9DJ5H2tLaK8xmDoWqL5m5cNU7lt4F6JuZ20MNqJFK2zOinmeeS7A==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790703680;
	bh=lIZPU28LktjAEqJkfHc9EGMw9QhHd4xz6cd3M3BZwWY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rT24F2qlp4YPgep8j8+PFGJODrLqIvVbdWfzV6LsHN/aHiouOLJWvK13MWpDKHxLv
	 7qqEgnaFJ45KIZXm4EXEK680wKUH6C0z5/XQ93+QTObpMJ+tPIGuZL+C1pLAw+g6/M
	 hvuuLOBmI94Bj4qiD9B5aowxLjBjE2MgbZWBI++sfJcaSsmMlI7cRR9pmnlA9dyZkG
	 hUdlKvdTBIrPxUAXPHzHJ2DXROaTMHrbHK09J1M2oRiKoeoJL3ERCA6hY2Mxx5x11u
	 cq7W8TiXmfoZhzRCbMUzq8PaRoexpnI4rTP9w+dUrLKXwhZOjLBPZLY+Ah93dn6YAb
	 9QKz3BwKkw9EQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6492D40758;
	Tue, 29 Sep 2026 17:41:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4A41E32A
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 17:41:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 303E5607A0
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 17:41:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XyKyh7ok8L_H for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 17:41:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0C938605D9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:38::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790703677;
 b=rCbCAJO17MFoIeuGC3ncOnG2w63inS7pdhsJzsSoaY37bL8Fkb1mu4nLnLn8E1uYLkEP
 AUY85ScBy3AdOa9KaoEibwonqyLQDEjtGaFbgRG89U9Cr3MMshybmzCRQ05iIXSdi1tE6
 OFQe3d19D9YztMlf4KV9H9gZmWdm18urkPq0NnX7NMItr8l25Das/0jtlt8RDBb5pHLfB
 6oAxyz7AV14PkOBsOwkU3SSuPQa6VO+P76ZMXSH/WNpRUVrMryA5040DyplxTfAPVis1b
 c4krIgvo3UsKwT/I+zPsw0z8xHYDbY0NP4uf+q+5zoef5q9nuRUR4BM9WWs5zdHosfg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790703677;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=lIZPU28LktjAEqJkfHc9EGMw9QhHd4xz6cd3M3BZwWY=;
 b=TwHbZ5ST1KL37oVeYe377VflnCqDzYJ5Z8dKcW6uGcTEMOCiZSpm9Do5Y5FlXKpwUFiU
 jykqQ6mMy6ERPqLeqZRNN9iIAFc25XLgqZDqtHLy9D3jma6W2Fq8+QrdkMttZ+zg2xodP
 Kqc+T/+4Anw2a8jliJqEKnGTkb1eq3TQjiU8jMTJCaovUv5bz8+MM94AHop1iTZy2Gzpr
 KfmCWVhGZ3AAsNrF+LdIWjEHWFfCahJQcqI4GqbccnqyWPzERirET6sdT/a1UYrOO5H7n
 G+DJzJlE2qxjMKtR2qZBDNaV0FBDfTjhDtgorFL0sGAibpGePS4VQNFMotTmzC8B1Zg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=FuB+5eyD; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:38::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:38::f;
 helo=mail-lr2-x0f.google.com; envelope-from=festevam@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=FuB+5eyD
Received: from mail-lr2-x0f.google.com (mail-lr2-x0f.google.com
 [IPv6:2a00:1450:4864:38::f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0C938605D9
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 17:41:15 +0000 (UTC)
Received: by mail-lr2-x0f.google.com with SMTP id
 38308e7fff4ca-3a60ed65bc8so39706521fa.1
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 10:41:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790703673; cv=none;
 d=google.com; s=arc-20260327;
 b=a9uCLs8dy19RzAgAV/YisXvdfKuQbiHPeA3GYhqCYcJflLnlmE5VGoAHqExk6sutcY
 hW3EsD3PnPpoKlQcNtEo1yZQV/TALYFaUqnStk5TATI74DqV1w/lhVnUcUZThR4YfeKy
 jJ4g1l3tBrxHgcqV5QO4yEjPIuehuLnR3QOXdFfyiMTW3Q0r29mIo1gwOAg0l2PQOY04
 k3AlQ9pMqtO2zxOhc1SgRdXtgGBxLLU4jtJj/9CwaXiXEt2wIxESHwuz7QSiyV1izzRv
 22gvbTsIS/JVLDMQGtBkZATpEyWxy24x7hUHjGIc/ZR/as9FumbITFtZSPzpXLaZGorL
 wcMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lIZPU28LktjAEqJkfHc9EGMw9QhHd4xz6cd3M3BZwWY=;
 fh=BZvLSU6Tji45/xa2MGiOljqwUkwCwTfwUxyI4DXnaYk=;
 b=Bz15RZAf9EvcR57+CzEbHzNflNaQpR2hhf0nG6iogEbdhSJ1AG72T8BbMu4IbYkZK/
 RSDTyXWXbIDZu+6S5kT5fr9ucHYl/5yhHk18FyjSdGm0JMAJZ6ReWr+IcbtG0q7w3Tun
 Tor/Bya7r3Vm51hQmuGKwMu6veYeMsbyE1n14xL+iguhVqbbi9EzKQOadGN4mq8SNyUB
 9+xiRwa62lKV7woW0jf+9mPKEewFsBgCQbg96TVwgQGB0bsx+xwj2Gd52zvK7SCjcgWi
 +6Ev2XASs47gpVE5Gj9pahBermluTkNHd4P7515rVoKU3hgR1BePQBeSRE+U34pnpQuW
 JPJA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790703673; x=1791308473;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lIZPU28LktjAEqJkfHc9EGMw9QhHd4xz6cd3M3BZwWY=;
 b=FuB+5eyDJdmG3u891iDZrdwZO6Pf/V0e0ZvUvDuSDpNZEslcLm6Fwa1p0JW/hmMMFY
 3V9E3DYm9eWKWhK1lrCylxLzdHaWfVm8N7jP4U+W2ybauLGOW8AvRzy3Cvz/mtnTr4gF
 E4+LlLWO6GxbiIteObvPrXPmvwUwIEdyWEXWUXmzFeDPoRRcQVL6Bfh4SSwSub6/Tu7X
 KJn+DzjGOIganPtZ+3TAIrVPFfna8RdOt7VI0xZjpSWKuY8euSxZX+51w/wMFy2BIY/1
 pGf/MVjgzcZlzYdEvwD+okSucm6U5716OZ96oOWVSIIEQjYtrQKLVgw4NkGTtDj9orfn
 N8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790703673; x=1791308473;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lIZPU28LktjAEqJkfHc9EGMw9QhHd4xz6cd3M3BZwWY=;
 b=2o8/NJGivJ2w/ttrRUwmqy7yEO3Qyw/xoxbUzQKKVh9kfBvLeeFHlDvSfG4pfQoLT6
 Znx7N28lSJOHmVswwPUk26US0vEYOdxV/SQy22m2YqigYm4/dGNGixwuXLpbrTPYatFy
 pnCfbIQpgfW+CWB7QzL89cxUlXfskLV5uRi0Uqz1E/uonh+cm6SfkCU7nkNsm+xedddl
 aw0Jw5Sjl1+xzXhqNoE12kdFJ9HgEm+GHpZ2LUaQmADrKYiDnakseuyiMlR07fTPFP8x
 NfLNvlbqwYC9frLXWDpZnJCRIZx5Me6zMFr+JAhdpWd/Jb+NwuzgjHBNqFlStSC0Pk8w
 IYZA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxuDJ+4+RcjeadfBuH09x2GJ33CFQTXSNgtJJi5TDVBxwMJ3adXB4KOhkPfvNI+NSgyw+0j/Hw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYITUnUBYOPFpYakZ60Pmzq5X230Xyt7hVfdXughSlb5OAGjrtNn
 r2u/Ww81+XkvrBjw+SOQ4q9YTdEptVKIHs46Jjx16eZ87S1KqI3kXo8g/2NMejdCRb7DF8OxMgt
 KyQtNv8aQ8sfgOCvKtWUeTDbUXclisW4=
X-Gm-Gg: AYBFou3TT7uAQeGFhqXlkbsmpybufXt42o9EHEMk0N7TBdt5L7YyRLFp0YkFWPns+Sz
 KYfBZ2mPY5o5+d/8CIFTvQq9o3wLC7J3pw2VJtRdohYrwhkrXFw1z+ChXRvbAtDFFbP8DWyLbXn
 qrQP2CErXMyfsuwnc2fikEkd34xaMwAcmORl4UFZojPcPQiuC4BzjZXVFB4Zurlx0DaiqLt+eBS
 Et9lxqrAoDZ8v1zixmJisn2gsvBUNFMCOH86vSVdqshKT9AGVNsx/TtqoLLSaDh/PliP3lDp4Lw
 TNSb811wF1WUdowKZT/CdbCZGhB8QHxsy9yDixI765Jkln3SexjNe3RCX8PPqZ+EHnC4kYZQIYg
 tewJcwc9FlQKZGe5IqGuJOxcVuA2u4Udricyf13JIMuB+
X-Received: by 2002:a05:651c:31c2:b0:3a6:78f:bbbf with SMTP id
 38308e7fff4ca-3a7717db9ccmr629051fa.16.1790703672941; Tue, 29 Sep 2026
 10:41:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260928-lec-imx95-v1-v1-0-9e0c9b94ccbe@adlinktech.com>
 <20260928-lec-imx95-v1-v1-2-9e0c9b94ccbe@adlinktech.com>
In-Reply-To: <20260928-lec-imx95-v1-v1-2-9e0c9b94ccbe@adlinktech.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 29 Sep 2026 14:41:00 -0300
X-Gm-Features: AclHuK9nxsqCFadQxhNz5zWimCQI9BnHgTMbg69dDDBpw1GdqMRxEeXtf1sdb6g
Message-ID: <CAOMZO5DXTiN0t1imDLA5zWb=q2XN0X5C9rJHTrUvHjuWrA5Wgw@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm: dts: imx95: Add ADLINK LEC-iMX95 device tree
To: dinesh.v@adlinktech.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Alice Guo <alice.guo@nxp.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, Johan Jonker <jbx6244@gmail.com>, 
 Simona Toaca <simona.toaca@nxp.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Dinesh,

On Mon, Sep 28, 2026 at 4:39=E2=80=AFAM Dinesh kumar v via B4 Relay
<devnull+dinesh.v.adlinktech.com@kernel.org> wrote:
>
> From: Dinesh kumar v <dinesh.v@adlinktech.com>
>
> Add the device tree description for the ADLINK LEC-iMX95
> SMARC module and its U-Boot-specific configuration.
>
> Signed-off-by: Dinesh kumar v <dinesh.v@adlinktech.com>
> ---
>  arch/arm/dts/lec-imx95-u-boot.dtsi |  73 ++++++
>  arch/arm/dts/lec-imx95.dts         | 216 +++++++++++++++
>  arch/arm/dts/lec-imx95.dtsi        | 524 +++++++++++++++++++++++++++++++=
++++++

First, you need to submit the board devicetree to Linux upstream so
that it can be reviewed there.

> +#include "imx95-u-boot.dtsi"
> +
> +&lpuart1 {
> +       bootph-pre-ram;

These 'bootph' properties should also be part of the upstream Linux devicet=
ree.
