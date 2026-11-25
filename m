Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399D5606A329
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 11:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yrgJVwEf;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=n7mvieDQ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0B31280CB8;
	Wed, 25 Nov 2026 11:39:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZOYkYHGx49zk; Wed, 25 Nov 2026 11:39:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D011780C9C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795606765;
	b=V2YFX4kW0/GUevGetSpdEsdT8RwPAx/XWt9F28wa/LvrJ+13w0ZlgmyqyB1AQG4aXjj9
	 usbSjOAYHmcbImarsqWcoK3CoA19Ei9BImmMP0u+ubyfcJO+XEiN1ItfK7B+Uf0/86rQP
	 F3mJe/9Yc5VDS3EaauGA52FY2eplPHIJF/igTIO6taskB+F4DAZ7xvkEGYnq8S4l5QdgO
	 FNHDN3IPaUpPLnfZdlFZMXYzbHhVDXAZYpHwPM+QDRUHEGJ1379N3d3qwIZeIhgCtjsq8
	 yv3Zktke3kKJFWFZbqaa5wqP2Mh5fdzYRTAUX31uM6xo/GzoAWKqcMrMP9EFklFhrkQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795606765;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qoHQnk7qiDgtFufBScujeDHKb7DCgmaOfhXaaQWWbvU=;
	b=Asb1IH78rnir3UCSmI+0BZ+2GuXNhGmeJn8tMS7sQvprVRfGxH7LYkpnJapKuTW9LjHu
	 kNXxAD93lXVHlM2PRKWN85Smq/Tx5L8QvbLUw9251ZTfSF97p05u3phRX/YhDjzQCOnfM
	 8eeRSbk9SFiChr11nXf6U26USMfsslcEwbwXOoQgmBV27Nc/h+I9kilI7T7q9cP7wdFUt
	 CNiPbWtEBBQlyzWHGc20GIvcTaPUUEh0Mzsv/4mgK6eenYn11YY08AlNwoSeVeuZmjvbQ
	 qbvUEcFjRjxI8303I1R8Pdyj87C3b5N6iMwlgK4l/JzanRD/4XpwZEhRi/2ZPPA5M3g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795606765;
	bh=qoHQnk7qiDgtFufBScujeDHKb7DCgmaOfhXaaQWWbvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yrgJVwEfk4/nXxlBjaDYY9W9/1BmHZ7hlOO1vnp1SS/S6SMFjuThXyHnlmMp2PHVA
	 4GORQ+BOkulwAvnTQx6E8f/YJXt6DwJ7a6xEZG2Ltt9+j7w/aSi7SvvCsvn3h0EIJE
	 /pGIGQ7+EdW6JFuZRxR9lB+R8e6dEOom8h6C6Qun/NlO4BVWc1fjt9oPzvfk8IlZPw
	 oo5iC4E4D/aLSAo7GLCsoBsWo6/U3cePHVoItb3zrS03GFIrjawIqID1CS8wKvtHq9
	 WqIBPEHZVAH1w8PYOuk9pUHGKg8/a+jDudWc64AF1Fbq5mEGGpVmAuaR4sVIWHwi01
	 oeNIzJ9KlizXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D011780C9C;
	Wed, 25 Nov 2026 11:39:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 62C9F2DF
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 11:39:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5154B4047E
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 11:39:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E69J-OfPzEOE for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 11:39:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0160540471
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=n7mvieDQ
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0160540471
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 11:39:21 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so52446155e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 03:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795606760; x=1796211560;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qoHQnk7qiDgtFufBScujeDHKb7DCgmaOfhXaaQWWbvU=;
 b=n7mvieDQCDydo03L10/5p+TKA+83DPU9ZY/aH8g6wWG+4+WvKeGDibtyz8R0zsYxAb
 Ak5SMmnXMfD4IRYWm7WhPths5y3spbENcEgF22pb0/czrvuL27O1UOmfJhu4THZs4u6d
 0XJ0NDbyEPqH7zMEaZpGgwCqwPNks9zlSGi7o8WYDTPNVNi8boiG+DcZ9b2nCYgRVNbf
 Ss9/cib4OIuGTG6A+y0Plw3RFuhHcOzFdEt2vGgXMXDvLjljCo24jaBZC1HMS22nvMad
 TggtObSmdKKx534PvtCW+EMvbYjEA0+WLTAzgcWqwLK3TdgBDQyzC6P9up9NggGxFp2R
 EiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795606760; x=1796211560;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qoHQnk7qiDgtFufBScujeDHKb7DCgmaOfhXaaQWWbvU=;
 b=P8b2P7Fm4nHO3+xw80nJdfoR6miIFx+5dK2a6i0j+3PXyRYl1wQ2KZR+6EZq+Zz1Or
 3f7/+hx7c1tiGtM/nHmG6ulOwneiIHfnVRLM1xTV/cd/gF59zhgOdp5DajHvh4RQMbex
 MrSQtn+DCTeaBwGazhh2/4+bNZyPGStKsSUs6qM/THQ94vdoSi/ym3yn88CaGr5JzAlm
 rk91RMBEWnFAqq2QkOco54Q2+IxN4Oi5Y9W6sdlv9RBfbN3lteemmCPGGpkRDXQeX+m1
 GURRnKitf7DweFnZA650tooElF3gIIFcZZWqnDoHfBwA7H3ygZVTbnu7JDJNXGJnKBJN
 XDeA==
X-Forwarded-Encrypted: i=1;
 AL+hErEFZikYPse0PNCGs5eIpU2kwsKxImrb5pK9DLZFuj2ZSgfDRZ1dd2Vmg3Ms3onnR9r1XqkBNKI=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/Z5L47yOGekfv9fGpZ7mTzmczoDB2TYAqxeASGAmG+001lD5Rt
 1p1Yl6aXkMlVIKrYzJ6wVbu2l+nLk5v2Lob4QCFqVTNZKecv8Dm0RBb/c+Gqlw706hA=
X-Gm-Gg: AZFdTZcyRuaRQZvSzgJFQmZ6Bb+aD6IUPdXjkElcd0W3b+rGHRtuPWn+Zt2EcqeCUPO
 y5EFr8+4LetBoG26Qm/Ml7JZyfNLPwKRplqv4l+IzCCz9W03LezifwPdlBdNOYIjlxSxzDYqDo4
 FfMiRxpaBZbnhhuWsBq7Z92S8oLFFH19+oCtS5+sBmbLKcOYIZXIlUOsybElMf8/2i87ZWM5VGf
 iv7fbrgmCHRnwEAVGPtKxl7LN02js1aIbdpW5X2Hf+2oHmUwgOVzWQajM11IAvcP9RCsXTQ6v2E
 VZUjorB3Uof0r9vOXwFLEYSWVBIiu11u0pyP5j9VFbcsSKwp8YqJ9s8NIcw5Ea6NxtKjJ1h2jSF
 3WgEzMiMeA7A00MGPZmM5jocAQB/VEs5UZb4+pMChMuaQVO9ukpmEIVf3Ob6hnBJe3yvEDIebAf
 tb7r+mbCyMqMgmd/9WqH1Y92n1Wfc8c93O2M4wYepTBkCAUnoceCOBXrkzZgefFhRnBijShaf8L
 3jBt1CD3xAlf6PpkHX2F5/udOYd2/UowtLHczKV7uASfjZ2NYcvj/554GOFIhiM8OmIsh84sSzV
 n0onIxQqdndm5/aSgLvXBNpp//W4h7TrrThvJgsot7H2FOzDaPCMXcSk7VC+Ppo+400e8TDxE2j
 9xAmU0wKO3qAt
X-Received: by 2002:a05:600c:a15:b0:4b6:267a:dd6e with SMTP id
 5b1f17b1804b1-4bb88938a62mr356883065e9.28.1795606759683; 
 Wed, 25 Nov 2026 03:39:19 -0800 (PST)
Received: from macbook (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8533579csm447967845e9.2.2026.11.25.03.39.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 03:39:19 -0800 (PST)
Date: Wed, 25 Nov 2026 12:39:18 +0100
From: Carlo Caione <ccaione@baylibre.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, 
 u-boot@lists.u-boot-project.org,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Johan Jonker <jbx6244@gmail.com>
Subject: Re: [PATCH] spl: mmc: restore partition lookup in dynamic mode
Message-ID: <awbIYkEwg3PvrJv-@macbook>
References: <20261123-ccaione-upstream-spl-mmc-dynamic-get-info-v1-1-ed7cba0804c7@baylibre.com>
 <20261125074952.28083-1-peng.fan@oss.nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261125074952.28083-1-peng.fan@oss.nxp.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 15:49:51 +0100, Peng Fan (OSS) wrote:
> On Mon, 23 Nov 2026 12:09:40 +0100 Carlo Caione <ccaione@baylibre.com> wrote:
> 
> > The introduction of SPL_PARTITION_GET_INFO left dynamic MMC mode without
> > partition lookup support. The partition drivers' get_info callbacks are
> > NULL, so lookups fail with -ENOSYS and prevent booting, including the
> > Genio 700 firmware A/B flow.
> > 
> > Fixes: 8b5070034da4 ("part: introduce SPL_PARTITION_GET_INFO and select it from consumers")
> 
> Not find this commit in Tom's tree (:

Well, my mistake. That commit is currently in David’s mediatek-staging
branch. I found the regression while testing that branch and I thought
it was upstream already.

Sorry for the noise, I'll comment directly on the Balaji’s patch.

Cheers,

--
Carlo Caione
