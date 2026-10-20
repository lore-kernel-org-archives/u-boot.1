Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE21606A334
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 17:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ilRbEMgZ;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=V8Ha3CUu
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 736BD40722;
	Tue, 20 Oct 2026 17:04:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KVh7-EAc8OcR; Tue, 20 Oct 2026 17:04:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CD5F040721
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792515890;
	b=ogu6slWl76SrsycbbRLEYA/pHKYV0bJUgS+74lvQkyJxWAtG7vC/qz7vfFJ82ok5pJXd
	 kcGHEIX5rTNQYjHqyxKYJ8IQDCGb6MvGJtaoouNemlQN3GypTpCNvXNl9B17m9H98ntac
	 kAw0e1S4BzIZ5WhsUPDMke1WBw6Ids40cWFWSWTx7xK35KQ/fKLXDt9oszGihkeJooqbr
	 T24KMIofnZxoApE8W2S17B9QAKUjHdEJrAxgOKdAginsXXyHp2ezAnlMLPYnnYbm8TID4
	 H71jNJ3413s3tCt/i67fYnxApk7c0iQLnfrxmwzzEpqtG7rOzdXs3+x0k9Q5XmDZvZw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792515890;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=i700DZZstfBX7eNRywg7/Vxi+sX0lnqFx4Kl5XpIkhE=;
	b=lYp8axtpaI/Bm3FVjafFJDDD6RXpafSI+QMndSBzwe+Ce87ZD4JPO1c9O5H7VCdv3uAi
	 9xCP66/POFx/wksK5MlZWgyXbOvQYD87JKEEYd1dBYz8n80O09MRpLgDqukAzLCa2e9jc
	 EazM/ZDuIUtUqAwk4ePXDICM6gL9WnhGr47PT5gh+P/hWx5PlS4tKARuD25wSObtvuiwA
	 Zmq4eZwAQZ1y6vzjkMTgqY+cYPWKWKBn5Kuw6eOKzixCpAgbwPJvFEdAYimO8BtseqT75
	 WpV5oqp7rCecp8gw3TbknUebOn+tyLQ3jeSOZh2LYG9sKRzUmvQmNmuJKE+V7kIxjPQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=V8Ha3CUu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792515889;
	bh=i700DZZstfBX7eNRywg7/Vxi+sX0lnqFx4Kl5XpIkhE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ilRbEMgZutc5C7t5ZuGnt1lZUbnOBl0weVDtOHzkyiaJJqqfAXCsJAdIzhzWP7PkL
	 8LPQgCEhFDjpn0g1YjzBTpC4SzGTHZrEXlHg3/+pW5NTY1doGa9uRoAWMQKFLxMx36
	 Vw5rDUzpIreqF6MZwEhFFV8yVlCb02YWXNoxI1XBtFx6EOx32n1ueD2NcAO0+gA8gU
	 3XXcLaxbaUftQlPWaXKBBLySXkNNnuGvLfl0HUjx30j+qcok4VmqhB13wCmi6DUf+R
	 lxMPhgBl9xNAN8ygsmNmx3lNHlYDh9pZelm5v3PO8byVsfTACXHTpZnfa8td2LkFk/
	 OwYhspK1zqzjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD5F040721;
	Tue, 20 Oct 2026 17:04:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2FE33769
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:04:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 21AE640683
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:04:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vSyQBiwYmcGO for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 17:04:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 33F9940669
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::62f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792515888;
 b=cw2EgmzFkR4UT79QZfy0nhvtmI1FoKIeMiJVRLWp4xDvmSrHBfkhKnQuyHApK/uzXHnp
 zZS7ymvlYkMPAuhDPQNVOZmAAskLOzmquTZoS6Z8qAwKIUJ9mfYRsM8oqVESzcZcv5K90
 c2OpAPeYmKsLGqpP4J2LDgoFmN0mZxop155XQrA/SJn5+TdTwctr/0NH7M78h4xhTOctF
 ajK8TZzwy+y+X2zeJztlfbZPfRZ3pyDAG29K8LyM5LhgtBz3qwJXPrRbF4U35HHwTymhJ
 8/2lgmeW4LUmncN/UxNrhF4i/3xMfPLcvxflwmTxL5y9/uzdzNyh6kXlP94AXBC0UrA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792515888;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=i700DZZstfBX7eNRywg7/Vxi+sX0lnqFx4Kl5XpIkhE=;
 b=iiM4RyQbBztOfBfHqW6/CulTVfxVcanGV79LfE4H6MH9RMpjrIF8T2SEnTV4gIgLU95G
 /yhgGEtQX84u521ue8McG4fi+iVKjifY4jSjGEOUAVFPZUhCz3Wjl13ZDiopc5nMBftOb
 2ZcsUhUczo0AC3crMf1jhRxEoGrJSCchStpwSW/OLBIv0p+XeqVhcw4JndDkI1rljdURr
 cX6TIVGdjRG4vIj7pb8PJ4m8siYPhi9R/fulqMb0UU1jloccNV77zY8Yp8aKTfJD2c6R7
 xbf/ZEzhrb3En1cuFsiCw5ONfHemIRkrKnGOxBidTNmAUQKyxC/LrxOJgVBLQKhOE0g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=V8Ha3CUu; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::62f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com;
 envelope-from=massimo.pegorer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=V8Ha3CUu
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 33F9940669
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:04:46 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c2acc1e170cso514918866b.1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:04:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792515885; cv=none;
 d=google.com; s=arc-20260327;
 b=JOjm+2cUDF89k4xMUN8VAOMKX3JRg9PXjJrAulXKwdyCjzj70LG0BwbWn4rZ2WJBkI
 LISwUvaW+xVrq6hsqqBzfZaCcq1T/qVS65/8z+P0XAo0T928o6OwhqNOaPzELfRHsJZX
 0p+rQ9oiTC9M/7I2NSzr3v80hNDLfmb5PQFeoonLVNNzOLSzDf/5CEwc5t/UEe0VYp9G
 4NHVa0QXuYGiqZPB3NspkyUFLCboD2K+cxxbHqpN6XC+6+LvBMpdVGzxDSkVPR2h/nMP
 UBUi/qUoSrzx8Oms5Gci+CRGUXEuKqZJwfEypx+ks93q8oyZjpNwW4yFRpVuw2rjVLpr
 e7Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=i700DZZstfBX7eNRywg7/Vxi+sX0lnqFx4Kl5XpIkhE=;
 fh=o2nk8JYZYHdbKOasAOwRL7N4eQ39U7dzArPu+GUBT40=;
 b=iEse+3Z8jEQK5oLrMhoj3cIPAPExHaJCrHsfk6SMVgTpI3p+cO1ssHSHtOosRXeOzp
 DVX4kU9y4xKnoxzs2ijv7ojRyUUN8bdftqio17P4LawNfEP+Hqk4smO4QiGsv9R14c4p
 ehISyCrd86hMpV1pjNN9qUmwOAF6jkz2MD6ONQbvW/vltpFb2FyxyUWzRCH6YTkz9eg3
 K2K8RAkkPHt5Wj/CnNo7rV5Pb80s6+BQz66ulV7b3YfavRsW5Ir8KIFC4L4wMNIoI2mK
 pohMo7Qvyh2X+NyL/b5Oj5lLK+Kezn0LimjzWX6Cjbonite7lP9K68wq8RHHcQS+UHTA
 LGOA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792515885; x=1793120685;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=i700DZZstfBX7eNRywg7/Vxi+sX0lnqFx4Kl5XpIkhE=;
 b=V8Ha3CUu9zWA7ZwhKIoHbsO/qzTgNWQNxq2WSbkGkZTgC5sAWJCtNO+ufKt4cb2O/R
 w6ZZ/DGdfsqOb0Uw1BYmV6SA1bwAgQdUHIz2uyUHzVn4OH6nij1h3II+qA20B4ClooJY
 AnXlHmZd3eA+DbGzMzd+IzmvFxuufEG5zoTv04I2b5uepKaVz8XtbwzXKCQnqIoZzACS
 5zct6640KiiPTHpcDbdnj1JQMU+IbnLM7BLFkFvLB3usNytElsNKcEXdEdTqgahRvVKp
 FSqvPq+BBPm+ecW99Pur7UbvZL7PGcGEIiT44C4FC2e4tKi3w1u2QNL6ecaYV3WuKjEh
 bHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792515885; x=1793120685;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=i700DZZstfBX7eNRywg7/Vxi+sX0lnqFx4Kl5XpIkhE=;
 b=RIS6/Hd1ro2UqBHxHtNbqrFBkqZGCSyoAiow4ZsmwO1J7WWRRl/nGAGmxypnSgN5az
 7oFT0w8+hDHYWtFB3MJZ0tQX69aiFixLhBrz+pHhHNLuj5V5BKNHcDFGy9d+BSElTL6b
 qR6I4KD9YkEv5ZuuMhqJdJXJ+bNLUbqIZiIAg+/uWXsprqfdNtvCwd2lAxUmZT0VOXjs
 qfOYZN2Y8F9RHQ2lqe2oAcRCVPO7RWmTgt/bE1/QtA0/+u4Jk2Drez96JdtHV4fXFzca
 Z30PsD69XPMgfhpG3DJhC1mLvPerNwusCj5fx9yKLr1rbq7A2vMcYhTvcAoKrBAO4MXg
 nprA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxsBrHLTYRyuKO6DibLIwARSO/NZ5ZdPmTQy+LONWgR2Dm+fI06iTC+CryPxObj6Nq4kv3GVGQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKIv2rViAvGmmUGxyJyxCmy5In9AdrYorPS77KgNjBTIfCaXCFW
 AYN0jKqXtoU5qn8iUfmvUer+Kv8xm+FO6t0ti8PojHBYMuf6R/k9HeC6KC3Yh6PytHv80N1sB6p
 7vynbmq09mJwsv5v0DUS/VBgU3GbSnbo=
X-Gm-Gg: AYBFou3mNTQU7AE7qvsubReOZIHD7I7Xl/uSkQc2uz17Q+oxOGqyW2F7XhWHK1fLmG6
 UnUId1z2n5OnjKv0di1mvcP3BDHJM/SiJ7OEET4/nP5QlZXKc4vLdGkbdiTZmRd95RXTzurOpZs
 j/i86nb576G7/12x7WSh8bUvtAfLA6Owwpc+tvr9tir4WqkCV6zmzrOJPoYuNLdxboASQinbiPg
 rlY+9M3WjbxeSvoMC3CxrGjbH9Gh2gkCHOLACIE2DfhfqXMYukcfijHaXLPcrcgO8f5WEAaIeEs
 /95/54JuzIKG33edNOsK7UKT/4/W1MccT50d8IgG43hPudLnzYVq/vQmvZPX1tYguTifEDcDxsp
 a6tEm6B/uAO0euh7LZk9BIHqO5ehk8MW8qQ34ZA==
X-Received: by 2002:a17:907:6d26:b0:c41:731c:534 with SMTP id
 a640c23a62f3a-c419e43f9c6mr851984266b.24.1792515884590; Tue, 20 Oct 2026
 10:04:44 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261020092137.242656-1-fiona.klute@gmx.de>
 <kmHpEJEOTD24XAfa7fSobw@sigma-star.at>
 <a7a3ddfd-e7de-4cd7-8231-be5391c88c4c@nabladev.com>
 <maJhRK5WQ1CTiNrAorY2gw@sigma-star.at>
In-Reply-To: <maJhRK5WQ1CTiNrAorY2gw@sigma-star.at>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Tue, 20 Oct 2026 19:04:32 +0200
X-Gm-Features: AclHuK8tvjh6HT4Nns2Po-j8OVAL2MuiC4wqkV3hQss5w53HnUaZQrTMr0ZmAl0
Message-ID: <CAC928Haem8N=Ab68A80Dy6Re3obLFfgCO04667GONkKF=Pv0-g@mail.gmail.com>
Subject: Re: [PATCH] doc: fix description of CONFIG_ENV_WRITEABLE_LIST
To: Richard Weinberger <richard@sigma-star.at>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org, 
 Marek Vasut <marex@nabladev.com>, Fiona Klute <fiona.klute@gmx.de>,
 upstream+uboot@sigma-star.at
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Richard,

Il giorno mar 20 ott 2026 alle ore 14:30 Richard Weinberger ha scritto:
>
> Well, I have a different use case in mind.
>
> What if you have something like this in your bootcmd: "env import -t ${loadaddr} ${filesize}"
> to import variables form a file like /boot/extraEnv.txt?
> I like this a lot because it allows applications to set various u-boot variables.
> And to make sure to allow only a trusted set of variables, CONFIG_ENV_WRITEABLE_LIST
> is configured to that set.

How would the detail clarified by the documentation fix break your use case?

Thanks. Regards,
Massimo
