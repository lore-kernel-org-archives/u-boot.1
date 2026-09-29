Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3529C9832A
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 16:25:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ACDCF407CB;
	Tue, 29 Sep 2026 16:25:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0csLMWzg_IPx; Tue, 29 Sep 2026 16:25:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org ECCEE40769
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790699156;
	b=YNWyK49H0ziYB5J74+1HfZnpQ0+NEqDAQnQxiq72044rpM8O2fxSz3/xb5y3tRQOW+LN
	 gjtouasfVhC9YrfsfFSlOzColgtyxvgxQ78ld2zbEz2F08tnvzNH897llpi0QJvfGtMQM
	 LjYrZL8DLwEemuhYsDN7WcjLYp4qYg144AJlaerJWCnnfEsE6o1/z1kvVKrgbZAGTd6mX
	 JIfqNrdnK6PqERJQVIvRLVGPjl+/ysxVsIJCafLY0Bqxug1mJzqzJDhJp5Zq/SWv2VwHW
	 nQfLiekgpAFCquTUCyZGT558mfaCTXzh0u0CUBg9TiRSUaqG2zptnRbrwkhLfR6BE1g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790699156;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4KrDGsQnlpoJMZJKSseQFNLPOlcYG2vejEXNFp8B5NA=;
	b=cZvGDyNzfpQLH7AILkrjs38tyEd/XYvqJ+L4AjfLYDXlql6GKhsvDqDJPNlVL/CLMSxw
	 8W9fbpRWr3MOGqS2etjXB8vrhybuks6NcIsK3c6oINHlceBp3mKFev4SEClhegonjDk8o
	 mB0l4p/+Cr0FvcwIc13xKFJSKF7OMeQFdxV+y9FdqZ6iY4RjF+DPvVTB4MV2mWTe9r5ym
	 9IZZq/WurAT1AliY8J7+0JVb5DUrbEdnQx6NOXSffzduu65NGHN96D/wNrB1CqJpyo1J/
	 y/Ln0OkLu1B2Ai1Nh/4SRuEwSDk7KZ0NpxFlvOOHzrA4+RnRtHYPwThOADe5Cb1RnXQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=f8UOQbLy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790699156;
	bh=4KrDGsQnlpoJMZJKSseQFNLPOlcYG2vejEXNFp8B5NA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SSL69c/BFmrM6yfz+gtXllhwP5S/3OlKdtKd+oL0n8IcDdA1ffByj0END50UKUtUx
	 NU4wMKdJHKFlyUr38o+acDxyueHU1QyrqnkWnhFWCq4Wj0m6mwzIeiQovHyhHMc8ix
	 a5zLI8Zl0U7tPNI6K75c7RanfznJkAa46Ym0h9+A0pWr+rKbbNgUGBVM4GehS86/W6
	 6z1bLdiWrpHyQ7XDIDO/4V3sL2zsTgVqcvJpD/xqFDCAIg1vXQV2foDImg0YVTwqq4
	 4wsq3GK55Dp/YwBJF/adERA3ArAE26ijAGgQnMgJPIzAoCxT6Ko0PNR6s8cxzdJpX1
	 qkIu541d491Ew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id ECCEE40769;
	Tue, 29 Sep 2026 16:25:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D9B8734E
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 16:25:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D6FF140758
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 16:25:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qGir13rjLgBb for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 16:25:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0CDE440755
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790699152;
 b=HBymZ5DuKLk+9PUSwDkKzcPPbljB20BSMB7R4bRMjyiqJ1+EwdM2DrGtksu3gUqgqqvU
 HfrQHP7MK7mgH4qp0NP3KJnOZdU0zyzVEaDNALy2nEM6vAQiNdcIUnX2/URNA4b7WNSos
 Svoap7C4gbB7qhEsWWwESr2+roWXxVIXaFmq2Yqh7+M1E64Fglns8RIL1roo687pIHETe
 LQXHbYEbL/SQc/Y1QzxzmHttquaE0Tb8hBT8Ta96hqJcsj4tzL0egXnBLmLwPG6yTseM7
 Y12nA/exUmPQj8Z5VVELKfGNYFKQfPGsNQqcFYkWJXqyn/EfH/fp49pj38ncBlItfBg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790699152;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=4KrDGsQnlpoJMZJKSseQFNLPOlcYG2vejEXNFp8B5NA=;
 b=lloX+C7KS9/4uNvzru212kNEc9afi1zWXXBaM/1/eDdLcBsEoRj2Se+bWVqVtklsi1N6
 y1F47CEA3TgwTo0UlZfoRukcCk540psbTT4g9PQZCgrjWTVdFJX9Cg4nqJbulAjWJJwHO
 yJxJvqcTceF1idtYmEFMH1CKQhuwEchEuER4CueOQwEu4CKPtJkQ6ZmokHCiZcokNLY7X
 f9Hy5UQ9MZ2/WqbJbozL9OlIqts3ZB9vrypK4QEqdqkgGoOhrq4wvmrSZNZJyS88Tifos
 SydK8dC4UQlByQ+KdtrnA46z0x36bCPfnH60/46E94u1RmkMf2c0YgGWTVsHWK5DEbA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=f8UOQbLy; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=sochnev.v.74@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=f8UOQbLy
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0CDE440755
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 16:25:51 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-48439feca17so3297571f8f.1
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 09:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790699149; x=1791303949;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4KrDGsQnlpoJMZJKSseQFNLPOlcYG2vejEXNFp8B5NA=;
 b=f8UOQbLyk75wEZVK72AnUuEqiffEqHzqGY/qrTolAdXBjQGbPuyOARWok2LI8C7lHM
 rh213lkNyr14Yl0FzUck25GwUVSemIGOujpd4NuILgzK6KbnpejuYHA2Uct854l5Lzuc
 C8os7Lcwb9gqNcY1pcu593te8QvloUHBuA7ehKJKWwLc24iWnEIqNDgr5PNuZR+FReDm
 O8BrXwMEqjqd71/wFLrgcW8KtM5R00ahoViQ4EKBE5pOORi06xWMcFikcieEaAt4u/Af
 VwnbpgTmyGx/QI0MzL4VpcwuCzv4fdztC2XC1oecn2Es6VRcqt40QzfDZgVtd1V8+AoI
 EgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699149; x=1791303949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4KrDGsQnlpoJMZJKSseQFNLPOlcYG2vejEXNFp8B5NA=;
 b=08KKdIw3xCH0NHVCWXE1EB7kJyrt9/dagWuebmSVzH4GC4SetTEdsgi4pWWwh6CQvu
 OjitVICOL515t0H2awEy/GKG9oez6c1fD7RYNecv50jzzgolai03/omrHIG53+JD1nCd
 Twyf2czJ/MOPY9vGhu27bUZ+RkOMEEenHlI4lmJqqXym4sZzUg37d2bRD42xmqLbYadV
 uQk8nnyKDojhTldDhzyBv09PNYiNvr/ZqQxQPpXa1vpoyDAQALGnFULgenkw+QtPP4fu
 d4w6DXA5cdLmZaN34lk+OBZm73Z/AeBiNNOjCWJJ1k8CkSFup5JDIirBJ768JX0tGrDs
 Taiw==
X-Gm-Message-State: AFq9FYKPotQDIHUzTGF07BMbW6KzrjNHma3rlZR9addhJNy1JcaqhdER
 SHPkRuC8l9AQO/51pIbjWWdvPYopUb/Hn7J4ECuwfqvCbiOr2hir0Ic=
X-Gm-Gg: AYBFou3j1Epa6Y2BIsezjM37dnNRskzi4RMc6lN4Hd1ryLVeDzbxFfBcI0FsWoIq5v4
 FMjFTmelX9qyd01Mp3+I9CPLW1audm0TBLeRMH4zRei9MNW2C+ko3Mqc+hdvsxyK3R4AL6aRaww
 MfGXNNePlOCVu6NrG+O3MSqdiTc7xmfM5oiZME4qTtzjFBySpVLjV1pq0AlTQGD3tbMm9lv/sxe
 /mHYjhNIG9KEwE0ukhtYJxz2DITv6ptzdJUTvE3vxTm2Gx1jhvH4O+XjLHClGzqjHNHBhNfGc7w
 pcRqBkdgJ0txGjJZ//AEL/KTCq/2BeX8WWPwWUqHFFmzbq9mZGoWUHi9lJ2gN64ar3jR4gsmTOP
 BWxJfI2s8y7YKk5BB/0/fYbDldmRWDjlKayi7p6m381UWYVda6kZFpEzHptoy4KBTiL0aF9WP9S
 PGji4BKm+SV5ahuzcFMyY7nCTh/KvY84lh+pbJQDd4hlcGAzOievzq12e/pFnHb+Q9tTw7bvs=
X-Received: by 2002:a05:6000:40dc:b0:487:ff2:12f4 with SMTP id
 ffacd0b85a97d-488717781c4mr30394179f8f.40.1790699149291; 
 Tue, 29 Sep 2026 09:25:49 -0700 (PDT)
Received: from fedora ([46.8.219.5]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af5056a16sm4933366f8f.18.2026.09.29.09.25.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:25:48 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org,
 Jerome Forissier <jerome.forissier@arm.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: Re: [RFC PATCH 3/4] doc: usage: cmd: add httpd
Date: Tue, 29 Sep 2026 19:25:35 +0300
Message-ID: <20260929162535.56966-2-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928225913.GX858934@bill-the-cat>
References: <20260928223532.482192-1-sochnev.v.74@gmail.com>
 <20260928223532.482192-4-sochnev.v.74@gmail.com>
 <20260928225913.GX858934@bill-the-cat>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On Mon, Sep 28, 2026 at 04:59:13PM -0600, Tom Rini wrote:
> I would prefer this folded with the patch that adds the command.

OK, I will fold it into 2/4 in v2.
