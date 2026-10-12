Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF08CA9EC5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 14:02:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C06F040312;
	Mon, 12 Oct 2026 14:02:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cHv5OFsB2qjO; Mon, 12 Oct 2026 14:02:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2294D4037D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813744;
	b=czciEWqVlgTbykx2JeVq45FO3pUo2edwg6rDqEU2AKyvhlT3MUMEWujtvQiQyNpc8sk/
	 1R8gGJMaw/pWUNjMHhNm4afg9BIhH8wvkVi1rLvdhE6mdhcmhTwcFKeLmsXqjdwVkUdWO
	 ORYPrdd3o3+X9Jk0hPguACNn2X0f74tJCRwyfp7ohqAOcR0bSPSZO5Ehk7/CZNrXBy7AN
	 Q4iuu3mOyMVGCjjLyLRHgYjuqcrx+nviIe1cHgZjZne1XYC0O6BYsBuXwD0wlt4bNHP3G
	 BD+283VMxyKt4gkh2Rr2Pu1fcd7MOvM86jzuWQD+VXj6s+AB6ERi3j2jQb25oerf8VA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791813744;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cqalH17bCeTgRPME5gpxFzoLAz1hHP+a6haD/weTVXk=;
	b=iwXe6Zg6USxkKh4F86NB8lkg1wQBtQF273aidBIApSvaELnceIKATq+Q8nPf+bOhM+Q4
	 Msv0dysKAh0SUarkh/k2Bn3QxEMxhf7o/f3gu/7wt4eagKxtF1TBiOd2/6Hh5z0eWxW2k
	 z63arbn2BX9dwNwTHoxW63shHX6/TcAK6XOUoJgELVW4ieGSmtn9imBrm99ZyJwQceHJi
	 eU8NhXu4WIAiNG3+IRvXUqE4INCiVbTIkZLN2Im64bb7EV+TTpUMsJsYs//zcuAvCuCbx
	 1wRk1ltNc1vMHaxcBK72CK6CwLI/l+ISLcsLFeFhzNp+4dt95Wi9Q7eJ4TL0Dnt4BKA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791813744;
	bh=cqalH17bCeTgRPME5gpxFzoLAz1hHP+a6haD/weTVXk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VASK3V3oRCiCq62tvsssDAeitObMVg1JVpUYylmIGKydOVs32N23XzQPjgr6aWLMP
	 9UZmCgLTmbnz10i2IJrutVSMjn3yTDRQlorlZEKPP06tIdeVH4hYUlMpQ3Bwjh8DX/
	 BewMyX/J/gUUzYV7AnrA3TMnEC4Vrarl15+amyfn9GfA6BcBc2ysItyHEPahXRE4L8
	 uBIYXkQw4icRsm/Q5myRj9e+sD3MTPBp/+36n5FSRZiVNc3fvAMZXU1GYdoJg0EVBQ
	 XVUZVHjAMhR+NX0bbtqrUeEDuU613WfTv8F4LnC0rwevLgOpENYubq2J9+/ufmayNl
	 7mD9I86lsehRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2294D4037D;
	Mon, 12 Oct 2026 14:02:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D1E7156
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:02:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4331A40057
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:02:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9hR-fCPV-Ayp for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 14:02:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A168B4004D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1030"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813741;
 b=FW5KprhP9imjTqezIl0HJZ6AZtVtUQmgnEuw5EOTBz0GD5DPenBNFWeh1GTQCgvdWuIH
 mydx4YaSSsvlJIFmvtDBLLKklEijiinWD+UKBU0xjV13L5SzW/xhKaU39lwa7CzQUj7cs
 L5IoMRNijICXjtvuIQ2aeYaUlUjPXZF32WY9umtCSa+zVH+j48UA+5pe0TSQuiKpaISn/
 koLH8z7w/uY/RmA4Io12hLNuTdHIJr9rw08d9mY7gC1L2M9YvTL6X2Mfx9rrAB0jgpvAD
 I3+4JvfNluqO7HOcyCDMYjSpPcHo5KoxvzGHHxWptt2vT3rt7ONqRTm6RuaWtDfhDdw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791813741;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=cqalH17bCeTgRPME5gpxFzoLAz1hHP+a6haD/weTVXk=;
 b=WKYIfOVfdF1OIqEesimE3tT0G8a0ceoU4k1YBe8CBS1FMOKbUOtpI8GZEmS1bvPwvMxC
 rC6s+rB3pgUp6YsWylQsFXBK0419Sfy8emJm8rXwVAZRoPWZGo7XXY4sxt86ulKiUao49
 QgA/jFKoBUGi2XzktYlwAjUFu6vMiJwAg2FoeEKEw/mtK+jT2CH7vZxY/zhEI84WSO+Ks
 vGWTfSQokCHTJHTVyP4vStw9KSmmh1rOb/xcXG0y1CeIbRSl6jv+nXfL0Ye1lACF76GPh
 vwfBBFTJLv2TqItCkxgBU+VhllpBdlRuGp5aSYRPyd+7WVmtdQS62zY9k10Cp2T55Dg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=RW+ctEju; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1030"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=RW+ctEju
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A168B4004D
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:02:21 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3a7fecf8440so911313a91.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:02:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791813740; cv=none;
 d=google.com; s=arc-20260327;
 b=oB2RywiJYknfy53FvuHZMGAbcQa6/ka2Is3TdAqZaTMhgpbMLPXXu/ZziKX1b5qPJo
 ++IY3nUlsmDAeR2Gny7TFZ55gtvbAEidg8hu2bSo52Sc5xFTWKR8IUj3ZjqT+Q0TvoB9
 HOuAnRAMI1iUM2hi5gDuNY3ewWydznUDllB+xwDxHanl/oCrik3AJlPN5ZOEmj1xJK2x
 nbZnffUHmKa//LIqxuKJn65/VhkHP/G7ZNF98GaR6OyKToAU2S+G5Z6+cb/cXN+PYBgk
 H/VFzs6aZGV0F7JJrhA+z2WAKkJKTz7t+T0Z3QOyulxqNZtEB82DRFAHbVMySkAiLtYL
 Z2TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cqalH17bCeTgRPME5gpxFzoLAz1hHP+a6haD/weTVXk=;
 fh=rDOkmCQJ9cozxuZkgmyNWj5k0ThXnY0U4gnSEgE31/k=;
 b=X6YL5MqUfsrCx4wadMiljDYkNz14Jnubd0AdSLvhB582NLz9puDvrsgTS6zWF5zkzR
 9oW6GOrRJNqDJwWi9Fxzws2/o3nK3RXSXulbswj4x+Ms5yHBLvytNj+kQRMyzWverE7D
 cZBerVuFKxnCIh8slgxaWVJsdfP7oGH41YVreg9GgkrGloxp3y0QaJFiJ4PiMEy20OTw
 QdBKxaWAFIQI8YPSxUV4s0F2BmF3Bq9Jk/0iUwc0EHBBEj80pkMYSfRggJUcusFJjQX/
 0OxMTE2S+nev301BHgi2RuegXm01H6TlFl1umKJ29oaK/cd8jV5cM81sHtqktISYILKD
 s/Iw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791813740; x=1792418540;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cqalH17bCeTgRPME5gpxFzoLAz1hHP+a6haD/weTVXk=;
 b=RW+ctEjuCLHNmn3pPVSY5V4gXfVL2fzR4WcGAuFcmN3beZIrUVQvaNXDoTYVHbuwhG
 zso1T4ZBZtD2sM9esA+uqtNcznBCQjCalXrNwd0/adNB2jwDzKhoBx5aymGWXi3j5+Kc
 jU75Uzv0HNR5o9w/pfM73n7pGgtbp8lx6XZG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791813740; x=1792418540;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cqalH17bCeTgRPME5gpxFzoLAz1hHP+a6haD/weTVXk=;
 b=pL8y3CCmsET9Jfxgc0sokoCv/lNp5xA1aY4mSuWcSmIQu/u1QQYFiVl8j2P1qSrVkQ
 OjAiNAvO0vtKK51o7Z9zDtyFFT2vecxBaUFnz9y3LWYW8+45LG/nQUdEogICeafiBAB1
 5jalJoGQPpNanEengi3SkzCoYLxoUi6YPNYddhQVox2gG9kJ2ZTQ+rQYYEppPA49KiBd
 ZDnh1NQvca+XkJbX/1YiR6uMZjKi6T5EZt6Laj9JU4D838gfw59rKrkRQfNz4UXU0azw
 MDpGnY9rIu39b2OQOOTS6+2L++g8He4vQYktDAkW+PTvl3hmHWo9h8VGxgXUJNatpAHU
 B0Ew==
X-Gm-Message-State: AFq9FYJy7AtHLVi5doqZh0XaJuSBOQ0Hb/hT9A8XtQ2SpP1tFABAcYZY
 4AeZYREMDRwdFryFaE6s1mUswqcpjfTGE++QV0jqKpORKWEkjak9W97moeNGuz4DrnZxqJJoGkK
 099ffhjkTuCzhtxxme6ZUKYATkbBYiD4ZQEzwVZly
X-Gm-Gg: AYBFou2lheNKLwkutSutr2uwV93qQE/nDyan47ZEpobljtmoz/NAUw+QZM1ZLb58qNp
 8ezPHuNYueoOUZHg1h6hW6y9CUmPoliRK9XHAPwXjYsM2VIj5cTEPXjxBaTPbWYIYGZs2GCUms1
 K63GnwFqVyXiltGVNQSItsbP+8hZEnaM1zufl2VZpXjBcJhI+kEb0Fk2DFAWPSmBivsQfYU8zd8
 ocUqcDpFzdYhjd2eFLR6po7687cFXxdQhwph5ZENXpbnUypt3nteg+I2NooFC6V3eGuycriIvtP
 WH+JpItlr9jeAW2mOBc3OdQ2XvV4mI8zT/Dy6qFJ+4Dyndo7rhnc+Rw=
X-Received: by 2002:a17:90b:5444:b0:39e:6a7e:ee18 with SMTP id
 98e67ed59e1d1-3ab3ad26901mr6745979a91.36.1791813740515; Mon, 12 Oct 2026
 07:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <20261010-b4-button-live-monitor-v2-0-004f47a4a7b1@protonmail.com>
In-Reply-To: <20261010-b4-button-live-monitor-v2-0-004f47a4a7b1@protonmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 12 Oct 2026 15:01:50 +0100
X-Gm-Features: AclHuK9LVaw7X6RyrMuoaAYgastyXZ5TOTJMrq84y6_qCm1fGdrqY0mX-reaTkk
Message-ID: <CAFLszTijTg9D69gSub+oPByEx9v9bjJgoS4HgMFE6Ase_PE2Qg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] cmd: button: add live monitor subcommand
To: petr.hodina@protonmail.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 David Heidelberg <david@ixit.cz>, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
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

Hi Petr,

On 2026-10-10T12:27:54, Petr Hodina via B4 Relay
<devnull+petr.hodina.protonmail.com@kernel.org> wrote:

> - Share state printing with "button list" (on/off/<inactive>/Error N)
>   and probe all buttons once before the loop

Patch 1 does two things: it moves the state printing out of
list_buttons() into a shared helper, and it adds the new subcommand.
Please can you put the refactor in its own patch first? Then that
patch leaves the 'button list' output unchanged and the next one only
adds the feature. Both are easier to review and bisect that way.

Regards,
Simon
