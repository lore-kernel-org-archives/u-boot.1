Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1A160A260B
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Cd0HX+q4;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=eYCVeMwn
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C5B1A80DA6;
	Mon, 26 Oct 2026 16:10:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p0r5JWkjmrsV; Mon, 26 Oct 2026 16:10:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1E26E80E02
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793031009;
	b=UHKEcahmkod/i/Zn+OlG6xXY9sfuVVYiS+RRIrfYXFuSSwq9mKYSTXn3pj8SXcV+O2T+
	 OEzgGG6oDeU2gO134yY+FtCSr5zIzRyaLHii5P+ANJlL0nXPBsnr+ykYFuaeXcT5w8XI4
	 gj6rgyDOcBP3ASDNYvJzbpqQsJo3gDKi0RlqR9fXD4yTyDu8HnCO4Zc/S+7Vwbaus9mVB
	 xkkAV+EqCqwAHdhy8GnvafwZE8YIkuc/VvjpoK1Y0yAUrAJNqgz1P/fQ9kHvW0eSdRtbS
	 zdFSqQxC9maz4/7zJzTUDsPQ8F3R4E/gGCHtgdccmRf2TJZ21IUIgOENpULu8IhGgjg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793031009;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VXcemldjOKpvD5+DyeJQ4HXZVQbMfi1iijGnixYpVxU=;
	b=gyKWbFxlzvH38ypHoMxPa38pr0wZy9gJahS71z9QxtJBEOJkZVMPEgl2lacVCKRc6DHW
	 TvlCRDq7yk9r64IEQ22IJzgQbQ63x5Ml+dpqvfl0SZgYrVpeEUSrC518byqRsGLxScwq+
	 CPrqABAzYZI/U86SVd669YK7sUpOo7nMOs+8jIMgytK0PgMmRCF+RuBz192f2bDpFpjc2
	 qU9zf4ZLBqnZ8oIi+VfqQMNNAMkABE+mN+1sSBbjMi0hIOOF1i2uXcChR2czpM81si52e
	 PIoAALEzM8aCjwyiXvsk5TQ7tvnXOeKAmOIwZCNnYdo+pI8B2z6VhiEvKgTjYTF1aaA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793031009;
	bh=VXcemldjOKpvD5+DyeJQ4HXZVQbMfi1iijGnixYpVxU=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Cd0HX+q4VVm1mAkdDEpan67MPv42vlKSf9MqbMxqI9JcwlulFt4pECMyy8e7tRVwe
	 E3zHtOl8pFdB8SC75rskxbzGCTViwJQFSvaZLV2gpX4eeNJhSKYiqszuYrHiSf1G5D
	 t74qBqg4sVns994qgAyNFD2ndAFL8uCX4H+H0GsWlRbyxfW/enbJ4+DqpczT9pFiRv
	 oMEWWdcOvhbPibwrYA7c1Dc041nEzymo2MethJXFwOyytapbnrjWM+z79R3dJrKxxH
	 77gKeyjcAquBvD+jJY1lT9MpF2obUH7mww0moXxzAVm6jOkGT0f6bpiHNbMABQLP1a
	 RuiNhL58I/unA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1E26E80E02;
	Mon, 26 Oct 2026 16:10:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C32F52F5
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:10:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C0392406C7
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:10:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I6xeX5tz3YqW for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 16:10:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CE52D406B3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::629"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793031007;
 b=Kddrmwm16nrrhOr1/r2dJdoeyVSyELQaFwZbCT7Od6x6dEkGSHIEoL+RgRblpC99sveu
 7DhypTcoXa3tcsg9Zl8xeJF/j9b77phIFhK/G8isLjYd4ig4cXnv3nP9WcAqgI1z2G3Rb
 FRs3BbRacNMib4J5VWaFVe2VmLhhocnQ6wTA8uGWQjp8f18y4HyGP/yW6qcEuIBDDoFq0
 N3+Li9WSlUzT+y1p6ub3rlmiJNIdHbjE7OWJQ7MGrZEWbAc8lBTropk9eOFAbuMvqn6Er
 68GF1V7XtMkGzJ1K+UYsZBhDYmZEhyrkHyVf/2TMF9IMKF8N+ibAtTal+xulWtNHI7w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793031007;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=VXcemldjOKpvD5+DyeJQ4HXZVQbMfi1iijGnixYpVxU=;
 b=q6oWu0dl4PtZ6V+iAM7l+xRyRHzW1yMe7J9D5TCmREEZ7zpSgyT9JoSlOos3c/VcCZZ9
 CnsD2YheIhWr9UfUfp0oAe0VhnELrg03vqUf+5jFPD0PcnUaiGilDQaoOjkOiuyGpL4Yc
 R8ahQXNWIzTT7EoRWlCBaLeUSwiWY3p6DppdZMxWMwNb9JZeA3w8+43IpvMKsmPKEFsbF
 RsNS+AP6LMZoKeTF0Uv96Ryroek292BClKeD5Bo2K6LX/kiviIAmyJNH55eQhe/tWF2IR
 hFql/CVUzxRpZVyGc2ypny6RlkUhSvqaJC1nGBaExZ0FI3/xQximmhO/Hic2tAtvsyA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=eYCVeMwn; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::629"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=eYCVeMwn
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CE52D406B3
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:10:05 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c40e02b2ebaso491744866b.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:10:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793031003; cv=none;
 d=google.com; s=arc-20260327;
 b=ZWTE0Y0jHW+1yTrShuJgdu1gJwGbdOpHb1ZjeEWxcMdref2FeBfaDYpSnkFE758ysF
 21gkRG2p7Hq/9dl3pXx02YuTw5grFnAOcTj5GU11/LsYQbHPAQzjgjxdcfPdYoc0ulBt
 DS0w/nbC1oFar9t+QpnB8AEUcWDgPa46prX9bRiqyrUSXpAejw1Bc5garyEAr4MAyv3Q
 n1UJJmSAQBrZvWlzpxp7P7LLNBEp2x7UqsdLazSXnKgcUwftK56gEQs0noiitq+D+9DB
 Ox+0Yyv/vp/3u2j+tEITHb0zLk6eXfpm+5ekHQI/zgVYpRj7FY1hgLDDsJzxdW7mLXLD
 ODkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=VXcemldjOKpvD5+DyeJQ4HXZVQbMfi1iijGnixYpVxU=;
 fh=FFvugHYPGJno2OmNliXs7Vu/zymgXzcY+BaC1fxfq3I=;
 b=aBa8vlvStRYa8BWai/0SiTjRtJYn9Ww6A2g9pKL2rBK34/RAx02SAQ8B52YyVFiqo9
 IriJNNj7PaQ2O0ZBgzlXs/XIiefarJ8Oo2BH54MMHwMhkwtwkD1tKn3ITM4280nYYjCQ
 B4KryvuDEhgc1ZHJjdCuAPkM2aSpfAdEVCP5cBD+KNHeN9j8yIaBBQpp7JU0ImYVjv3I
 oi+mo47jVoMTtkYLV2JOYbpN2R8ugKdPY2o+fQk9cscJnsJ4KyCfXbXLgYwgUHZpHpaG
 CXYv7xC8BuDjH82YFB20ITOs67It9qWne5s8xH5uPri2A8cd+Fk/87AlSig6qqyA5rNP
 2SNA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793031003; x=1793635803;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VXcemldjOKpvD5+DyeJQ4HXZVQbMfi1iijGnixYpVxU=;
 b=eYCVeMwnf1MtMjZLNawztI93t4BXNNpxwIyKkquZKMb/7dLVbEFqJunhGfUbMuWpF7
 zRp1hJScCicjDBQxeSjUOzonwOkHfQncbuOYuU9iRs5rtA+G8KQXGhyqjqKOkHX30Nkc
 zoSJvC2oWf6Qz8VsQ44rshg49DYmQ7bxKI95M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793031003; x=1793635803;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VXcemldjOKpvD5+DyeJQ4HXZVQbMfi1iijGnixYpVxU=;
 b=Vcd9LPjF4jKSRp2LBsfs2hDI9kUrtX7A9XIVd640ZUOqW2pWbUo6JRajqFQBMlmS6N
 Xfo6y82eL6DvE58FHwGg0ZqFEbVwS+ZSKecC8ysrm3yKFR1tADLOkqIkCyCrosyACo8h
 Y5axJxdmA7lHXaxlP1vaDa1nmMtZqQf9+efIGQCozKKgJCTplYgYXT1nQNOmn/dugwqZ
 DrkVqzEXubiVxtq7C33NLRaIZHSGZvApLDY2JSG/yehvx3N3aUuzcOASBwMQf4KjGfgC
 jpWxUhMwTt9tQ5TgY8o3/r9q4JMJhnx7ZMnOY9mod1NxLtnYzhjN7YxYYJPLaFY1yV6k
 IhDw==
X-Gm-Message-State: AFq9FYLZxx1WqxU0vtIuMzwQpsJGXvObZucyuig038zAguEYyvBaCBaP
 z01qntJ04tAgEUmfCdkueD3ia9n1d/7C4OXa2YS5Rf8eIIpNaB8luxRuy0zqqeHmOo17ry/jnEj
 hkzDG7TFs2ESOzgCAyvDZpGwz/1p64iARj13za0kmyloDFOf7/VqlSg==
X-Gm-Gg: AYBFou1AMhE1hBgI1lNp4fwkLnKuBj++0a03YcdXuP9RbXzfFH1l5wxOJXjBcke8Rln
 trxWFEJlYMjBNWdOwieCni37zFfSKnNCAZzAqLfnksdahyv9hO73jfRW95h5/skX6k9MgOvPlCt
 5CGjzJVJaahU218XQ2V/dSw+W1gCm2Mz8sPVQgpBhrFbQUebKL2IakhhAeBJTTgI1cBi3hXv6tf
 ZMlg9MnlekTiNA0d+BlWpvWlWBTX9BiUTUmIdd2sIhxiIZJEAiIadu/2ZEt0u17QeIKa+6Oi7K+
 homgKGpOx0yJh9lumy6iLj3IY1yQLVBoyek3Hm7WnUOsxQjGiWaQvzzpyIDuA4nZ2+ak47eshO7
 rXxskWulYl71zJyF33ZuCxcn7NlDK3wLJVWY=
X-Received: by 2002:a17:907:6c17:b0:c44:16ad:c31d with SMTP id
 a640c23a62f3a-c46bdacc39emr815064066b.4.1793031003602; Mon, 26 Oct 2026
 09:10:03 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 16:10:01 +0000
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 09:08:53 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261026-rfc_i2c_nak_suppress-v1-0-bc01e8393b9a@ti.com>
References: <20261026-rfc_i2c_nak_suppress-v1-0-bc01e8393b9a@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Oct 2026 16:10:01 +0000
X-Gm-Features: AclHuK8StyT1T5MKlKpw16SmWcX9YdtzRLs3LNSlWzFcJa7h3UKy3oHY-XenJVE
Message-ID: <CAFLszTg_ob1mTz9=Nh0BHM-yZDDoyYTu4STzHgk5tWALyZ5yZw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/2] Add i2c ignore NAK support
To: s-jain1@ti.com
Cc: u-boot@lists.u-boot-project.org
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
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Swamil,

On 2026-10-26T07:16:33, Swamil Jain <s-jain1@ti.com> wrote:

> Some i2c peripherals do not require or wait for i2c ACK, so the series
> adds a flag(DM_I2C_CHIP_IGNORE_NAK) to ignore negative acknowledgment
> (NAK).

>
> Our usecase is SII9022A[1] hdmi-bridge, while reading the EDID block
> the bridge doesn't send ACK (mentioned in programmer's guide[2], pg 22).

Thanks for looking at this. Are you plannning to send a SII9022A driver?

I've commented on the design on patch 1. It would also be worth
checking how Linux handles this for sii902x, since that driver reads
EDID through the bridge too.

If the generic flag does stay, please can you add a sandbox test in
test/dm/i2c.c, like the existing tests for the DM_I2C_CHIP_RD_ADDRESS
and DM_I2C_CHIP_WR_ADDRESS flags.

Regards,
Simon
