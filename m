Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FA0CCF2DB
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 08:58:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EA51380FBC;
	Mon, 19 Oct 2026 08:58:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jgkicLkX5YZX; Mon, 19 Oct 2026 08:58:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1B87480F90
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792400280;
	b=LoF1YLkdRigjoYlT1WCm/FDhphtxwMFNfkN+QzkgE5gx0I9gr+Zi3qsUeiqIvHL2vYmS
	 HfFeNZEzjzZF51P+QWlwdvwdKBpLIsDpUFvCn8BRTTIohWPOKWnv1Di+TL2Fwmkw1jJoJ
	 A+4kkaaxRGa6g6t7kAXYFL9mt/yyziac8QKOUfFu0jUNU+2JMxVxpANJcdVF864Iqemqf
	 745pxL/qeGMLuQojvNgkLTGWPy7f7E5l3KYMeR+cIIM9lPnY2rGgKmxXX+aypADN7BGvu
	 eWx83llsxsGyq4QBEGTpxTp4n1wVR1CV9KeN8X5Hay5GJlCPQVlvZVb6RidtL5hALOQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792400280;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=WElnr0YeVHw/R18X9htQjlEKCCR4VNgJwbV07OgfvkA=;
	b=eAnZC+ZlsqApRIDbWEJ+W1Swjm+De5e8hBIXiUHx4jMCY2Rh1uB23v9MjOFSKKK7Dy42
	 EypViNVsYd/VuNsfQ1fnea0bdDr2j0gHl4FW0rj1rNIm7vvZ+ox1FcZCxhw35OoLkCsM3
	 NW8ymrBDLxi2MHMtUmczUi++o/3ImG2xoSZhORK+OIVqCSGE6ta3Be5888UfOPfViHhZ8
	 6e0GpdU4NmPZqwiqwePNNlSkIkQ8u5bOAN5gUhwiK98thEENwz4y1GUnz5Qj2GTJ85TyA
	 bUiVi4SgUNHFaW8GMom+jMFLxGpqYTvxqLsy0d07/E5LYu925RU4srP9pxrk02PCPjw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792400280;
	bh=WElnr0YeVHw/R18X9htQjlEKCCR4VNgJwbV07OgfvkA=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yM0OAPD1dfhFgaPfSEtTeJQhbdOyZHO6ydwsXeUPdcXMYCBXNiqdW4zsrXAy8waZI
	 TzFbb32iTAQL3vmzOtnoHujPuFNgJ+fieIdBgAiqJNoGLwpspAwKq2TPhEar454lxm
	 6+T5AWF+i5FPVBPbUv7psUwEY/YKIJgHrMPIOG9HDk0l/d1B8YJftj0Mj2nUlf83rk
	 jougP1xb8w8RWIsTbL2STPdKrotkDGGBU9NP+pZkG/FkNsBPqhv7JX+q1hysqXqaKT
	 4XEWeMSS0ovS89lmDs2GXeL4483WZrrZyhgUDmWdHIOk832XSO7zJtGmTYChoBzOtE
	 C92Otmd+a1EFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B87480F90;
	Mon, 19 Oct 2026 08:58:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C3F2E2A8
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:57:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B36C340768
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:57:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vblRTp4OA8JC for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 08:57:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 23B0C40737
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::632"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792400267;
 b=HCoJNzA7IQYSZzJJQUSdyJp4LNf2Je+kttphQ95b+aZ6jKXw89qoJIbbvy11mOuYG5Eg
 7nxK2+B7Q1vN0vvu7pVVpt0QpRdvZfN+M9L4slP9d0X1mMRNX8vor/3UXzBnAXXJ0i5Y+
 W1Wbg6Fbfb8IH+Tbmf6Jx9LUgxS6vL2unz+8PoUOgqcYIA/w1AS7GnYG3ggRkM8XoUMx8
 b4J34Zrvax2jLdHKoS/MYh1mmQGeDvv7leLqqFGfgpKEPrP63d3AljlXQjuxB9qjYEkUX
 upuvMl9rfpQLeDJjpvYdyMb6d2yX2/Se+zhTmR6asxGquQeQVC26wzgb/4ljg5kylCQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792400267;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=WElnr0YeVHw/R18X9htQjlEKCCR4VNgJwbV07OgfvkA=;
 b=a4gJKo8pxyKCRVo03V46gh0tpJJzO0m0lCHdTK/2ea82SCMuRpMvKSXhy/YlscV5a9Tb
 vQVevaCQKmvvRpla8Im7bE7+B0s/V1/HFGRVZ++digen8/67Z1A/L6TCrCW/N0GMhecaD
 izKO0toAMY8+rCJf0SscNbTBgukwx6HRWezw6pZGAsXpA6S/3Eoq5jD4zoF8elec4EBh6
 lBxuUDFlXVNuyjrfZ+1Nk0GeWMnSU4jiZqrlpuA/YRDdommA71SPsC+l3IX1f+MS/jAiJ
 /2K+BWamAyaOWN8dkBccWQsxy0spshv1fOqflge74eT3b1gz3aS4I3lOCAdALfMS1Qg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=CdkHS4hP; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::632"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=CdkHS4hP
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 23B0C40737
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:57:46 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c4550d8ab15so13010166b.2
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 01:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792400264; x=1793005064;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WElnr0YeVHw/R18X9htQjlEKCCR4VNgJwbV07OgfvkA=;
 b=CdkHS4hPfKWHyfGmjIK0TyRmsjI1FN121VBuQJ1YeEuesXcQkJqKe9Mumu6YCJMzJ6
 j7ha2msuhKSLou/HkVU/iXqwweGryiLjtlRAhJOjmgUSXfAAJ7fsE0eiCcnugFDTv25T
 wUiIyfCeVkOz8rZoREwB+BFT7F91E4EdA3HztzZPdW47Nn+MnUBHOKqxXtk416nbXV0u
 GXgi1vOPsgdyTsDhxVR+jwoshDO0J2eHxrjARObw+ZARY82sPqoYTCHB/2utOLDvb9ms
 w2tz++0t8y1hZQX99BMISDWyrMBuHegad03nQqaIarVjq4bO4UjezKHuZFy2ByO9djse
 ir5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792400264; x=1793005064;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WElnr0YeVHw/R18X9htQjlEKCCR4VNgJwbV07OgfvkA=;
 b=z3DEcyZqk6QbLxA5psSW7s+123Qew7YZxDQ9s7t6sphcEeijCwurMsB5nretNkNYTy
 Pj4NUeXeRW0ysAV4CAudmbmA7mVR4SIrE8YOcl+lIBb8oxToPkeCRzqKZY1i2Q+g3IJC
 u8X1p2QqNb1SybEKq9auYsWSnlv+Y80Zyxb+d84Q/8/xRThAnalqGvzR6niJPcyjZ8FI
 lhUYO/vmbWfaQ8ZOuzkWFm77Ivb3c8a5c/XHVKDTHjzhKHWzUiLVMqr15riKSg8ECxVG
 Ele1dWzZ6TK5ZMvoOK+6fLC8dCSzndRHMsV/JjHNSKbFtmTFdKY11QkXrbiIJh7CtSsr
 f/Lw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy9WynHSJrtqCI8t6ymDqZwCJ15MWegDe/lVO3ufcYlS+Z6EI9wyBlZTWWWQVhekXR6KpunFuw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLh59OMRIXVkqveAClgGOGUX8nhH632CYmDmKgFqLh1GKe2TMck
 dfRHuY8qUnNf+U03KShLZdgInBb2vQszs2vARQkP69k0CIN6c+tgEIquJ++n/9eJ67s=
X-Gm-Gg: AYBFou2HeaOhDi+za7cr1k1pVnqfdLsCyc06vdzIT3WGwNAGRwtxfuM6bVDfUMdj34x
 kepR83O4WwOkIQJ6D+HDAvT/0XriaJsUEsLp3CfltQPiBuoe686rgYL6s7AVidJkADiFG/EYUA3
 Ztrs1vOVM/B3cwiVW7+DDNYnZdf/HC6r3adFi+807EfEBnKBbsr74k1wBJp3mKQKi7Q5Zbs1O2e
 922lm6rusK6MFytOTJeb9rQ2ASKM0qW4Gqm91hHW5z6Jp8J5tlhxvTK7ja7DctDiz9e5mLedAgs
 sQJscs46bfRwKpdY0EIV+M1F+XQR8lYpz9tUnsCbfPe5VyJrKsxPXAJtzhPNkrnuUHqDXX+b9/w
 M4l3Ej3jWc3GJUPSfE8E8WgY1YehbzjYDQkBPWPoxMn5rmjLazHTbPhWAvu3aRNP2GdKLZq7o61
 EqdtxtQPXpr446k30D0bgJffGaWIAzm5dr9QsPQ6DttucAFoxqbMSBT/wvqEBabRH7cuK7Aze6Q
 bYL50E1gajOem3cP0QF
X-Received: by 2002:a17:907:60ca:b0:c2e:2944:d6cb with SMTP id
 a640c23a62f3a-c419d34fd30mr495152966b.13.1792400264084; 
 Mon, 19 Oct 2026 01:57:44 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c408e328527sm338958366b.1.2026.10.19.01.57.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 01:57:43 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 07/10] test/py: avb: Use format specifiers instead of
 str() for mmc_dev
From: Guillaume La Roque <glaroque@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org, 
 Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <20261015-test-avb-fixes-v1-7-9e5b82644359@kernel.org>
References: <20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org>
 <20261015-test-avb-fixes-v1-7-9e5b82644359@kernel.org>
Date: Mon, 19 Oct 2026 10:57:27 +0200
Message-Id: <179240024784.806974.146942162813059550.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792400257; l=665;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=sP9F//0Fu7/1D8iT1N92zrLKC2R8+JUv2h6Soj62P6Q=;
 b=ULadUme2sMY4WdZkgFZXAEwAshZmdRu6JCXCtLSlv5r0NVytJiFPfqdy6YNhJBit0wVNyFRJn
 9E/Z82ZIIUQDqLdoT226nqsIKt5hfpwMwRfZQZkL7Zaf6EHYXSLVFie
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
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

On Thu, 15 Oct 2026 15:54:57 +0200, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
> The tests format mmc_dev using str() conversion, which produces a
> decimal string. This works when mmc_dev is 1, since "1" is valid in
> both decimal and hex, but breaks for other device numbers like 12
> (0xc): str(12) produces "12", which avb init would interpret as 0x12.
> 
> Use %x for commands that parse hex (avb init) and %d for commands that
> parse decimal (mmc dev) to format device numbers correctly regardless
> of their value.
> 
> [...]

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
