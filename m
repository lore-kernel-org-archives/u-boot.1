Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7A7606A31B
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 07:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rYxwwPSZ;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=KmHZu9mP
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4DF5D607FA;
	Tue, 20 Oct 2026 07:56:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lYmFQTMV1gcZ; Tue, 20 Oct 2026 07:56:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9035860865
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792482964;
	b=V26mnWkYICIWv4mgCuna4SDRcvWKdhfavuLXOP5iivDD7Pt0ErGDrrrtywcFbrUx/Tj/
	 UMHLYf+HNFTF34kbClo9QSolROslgyciuwSiAEtH5DBHtunW1+Hw4tdGdT8gSkN5Cf4MT
	 kf2r+4gPTbVuPhHUdBUtHSo1udAUSab8izn95+hFPJ0t3d2ebFtyOsbeOPO0iUuD0lmWX
	 L+zt1njT7xiIxmulzeD2ClDGzc/ru+F84lO49Bs1c6yOkXCJBBoU3TfvPhkyFO2zbws/p
	 i77kkCIYYFXk4j41eUJNB+Nsy+WVyGnSeI//O1K2NtJh/Yw/yYau11Icv32MS6tTq9w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792482964;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=tUzljgu5Otv25mU3BOMRUfQLXO664Eqo4QBNtil3LuY=;
	b=sYRuF0qL/JpGeoBGLHZ6rScqrplOvSIcyeIPLfJco+TfbHRXfo/c6XT+hVNe3acMVRqT
	 v5KeSZ52mzi6KXqHs9l8Y38MolyECxC4/KTh3KcKmQURi8ZHbVXnfInex6cuXa8Uqw2WG
	 GY8Ju5ijjwOVHNBz+futI4grwn5V0Ce4C/nY8yEEqZXlSA+OBoWHaxoW+cMEQamHNn75q
	 jQacE7tI6UIYC9Q23YdGPcdNi0l9LiAdczijhjJSPXzUEwOo19kn9msYKox9IREAdAbsn
	 7EqbM+k1cz3W+K5VHCIP3/W+iukjFb7PGucwzxULFI49Jqe/svAnhX5ILtV3Dc/NJQQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792482964;
	bh=tUzljgu5Otv25mU3BOMRUfQLXO664Eqo4QBNtil3LuY=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rYxwwPSZ/pGEODmkPGjehwmfATKQpb/GCFCIUA2SxPb/bLYlyVmtDmq23FG1qUVuk
	 6qMy3IvSB5ZLGX0lXXh3JmuvkJCNF5UQ1ts8UqQlwX8AKVfbVotrDEbG3ZEEBs/M29
	 HC4oMKB5/LYZcGTNunsOtEknyaM2rOH7TRZE13ZNfchdieS5i/6jL1+mPTx5z1J3Bw
	 SlaMHUpMnMDPxPmxKeNKJAodaHQ+ABRFrUhgOjzZKn8/adkM4EAz1SmH7sfJS8Vk0/
	 YXpsOpKOBMFJ+8rKr8XuO2puKMKdGCG91XzG32qqDDNhhXSEwL+cyRe10/pGaLqdGH
	 3fJx5FSr4DC0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9035860865;
	Tue, 20 Oct 2026 07:56:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 51ABA279
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:56:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4067A81006
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:56:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TDN2OVfpWSEa for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 07:56:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 48E9180FE8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792482962;
 b=j97juGTtVxtHlASkJwlM3SmcWWfeQbiHVTz29nkQXzqRej0EuU+DHfEPNpNwvTMCYHbW
 Lml/V5dwhmNR9DOc9EgUtsm4MQJBnsbdOPslNu4YtehJZkQRBtX98ES6I9IcQFqeIagUP
 Js/NUs9Si4z+1M8qjej3bgl5TVNEdEvRNk4dx5nVEU3vffepQY3NMTieieA12g/Nw0DCF
 /9NWD2S0uqp+4WBI05C9sXTHpsxXYADqyT7vkBBsPlZczhhXW0EATAg+fWrhpl+NIoy63
 uA4m69lkwKMh6n98KE1+BvzA7IxSJzpwlk2qCUx5qjDcBdID3JgZkj1UfGzOEcNe2yg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792482962;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=tUzljgu5Otv25mU3BOMRUfQLXO664Eqo4QBNtil3LuY=;
 b=mXvf3TDI7p7NuQ5ZG4jJ2+91MCY5Ijus0VU3hAK8JDiZF9aNMSGth59eVtA2/qrOXbgQ
 cxCliPLtujPJlZ8sHegzzoo1hymk5MvqknWrThWcpgZA2wjaRTmK6xY6B1LBhkX/+Yf/R
 KiICtv0U61+RQ2Cx1YowZAQXrIvShWpSuUQzrf1rF7XDUY2QFNrSZRTt5VN831vK81byQ
 Vq5nmgB6TGpSyS8VBgqfYCpWO8fbnXKEsfDiwuACOceecs2Ag4OCkS3NzA6b4qYBIOFXF
 TF2YwVEjU/veu1OwYq36cInp0uUtz00UfWFUyeGSFMBq+EJozSj9zWYYSFdzSdCZb/g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=KmHZu9mP; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=KmHZu9mP
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 48E9180FE8
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:56:01 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6b170129413so4612688a12.1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 00:56:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792482960; cv=none;
 d=google.com; s=arc-20260327;
 b=BKA8IuW99cl7mUeT/1rvDe47VWqugGRGE0WFPpq0rt75y1rqmyjaiPsGpzWYw7kSmU
 JEXoE203ga+dxzlMyXZ/kBG525MhVWoGCEtip0ehpWt1BgjyR4CowtECWtdKDD/1Ygy5
 JuOF1LZazu9MjuobCqQxpvXEIN0RjDnXi627rqTLOl1Hp2KVtakDIYyw/7s7wnnmPZYy
 PKjBNFMpIXW56lQOvM8K5DRvKTV5G73Rf3JZujZO3fGfiSE7BbLrgfJ2myr4zmFNkbc7
 B7PJwzojAo+hEabYUc5wnRlP1yWKpFFY8xPGRRJ0sK+sIRAM1X6b3nvxRVW4Lt7IEC+4
 kaEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=tUzljgu5Otv25mU3BOMRUfQLXO664Eqo4QBNtil3LuY=;
 fh=A2eOlruEJ4+/A75Q76CJLqKaUkSbDUxcu0zJvxQ3lBw=;
 b=JrmMGVsxPZvlzUVcP8tSPCGf3/lPIsKo3q6iKYhXLwVhpH3AYBCvdqsxzxrcRwwbhn
 aDvJIaepO4VjUd9r4XhfBhFF0GJr+r2Y/hOY1u7eBf6iexQEDXYNJRt65ykKqjvKBKlR
 6jqGuQNRc9xuBPyRUu95Sf+pViyBsgl9DQMZA4p6UKchJ/HMjYNDXGSUXYZHqbVUABWw
 vdvO6bPbNUCpocvh6YeoPg6tOwler5h92fI83O5oWnqWGs31NQDHXeFfZsTjuZHDSIIk
 BtfTz567wqkEF9vS5YreiW/gMMVklH2Hb0IMAfKKEECEs39PrOvJlqaxI63W5oeU2uJ5
 smvA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792482960; x=1793087760;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tUzljgu5Otv25mU3BOMRUfQLXO664Eqo4QBNtil3LuY=;
 b=KmHZu9mPoOzLjbr+Fo4u6QeA0FsHkWvyrqrLxcrZmSxbP8d4IgwmwP23s7I5vaF7xt
 tWBIuE8QOi54bBW/h+lmo9QghpJbh9y8M2812H7bP4Qh9FoSBgv7DEszlnpjEwvn/TAk
 65ocItxECtByrbWwCqlmb31+0wSOPkJlxc/xY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792482960; x=1793087760;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tUzljgu5Otv25mU3BOMRUfQLXO664Eqo4QBNtil3LuY=;
 b=DEkmVbd0PVkDbavwHOlCRMn74xLLQD7NEoei2EvxoFeI4H+4+4EyveMgFmG3T9kdA/
 atSAzJ6Ddkdy4oI1uDfOR6Cg/U6opdKU1CHDj7UVqcfluu3DI0LxPdFzHYc7bwTcSj6y
 MRYvx3mkHtxn4AcyhNwBHAvfeUFJY5SYDbskd56Mb92fzyrMFR1j32hUo+9s+rnQpuCR
 ojcvXkuOKgPrBNfqZFnOqp8BmCNu8uatu0NKndGffrZYaBa/SrNO4WnxDucO+CNCYylM
 M2m28+KXJEKWNfeLMQqNgeqtyt3Ui5ZP2+F6CDcGB7ujDkmw6HHCt1okGGyLW7aWcN8L
 xsaA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwIC3SBh8w7yhAbqvigZf9+FqWVYpwvdP9/HL498RosmycM7s/td+J7/c5SGUvlMfik1whiOcQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLEmDN49dQVpmL7q6iVIKGkEXu7EGQaO9cr1khhlDsq+1ZhRnVZ
 L8EGCAEeaol6vVnoQ9ie/nw9l9W4UJeVCIdHGGok3+MBwfWRn2Ho0q06tyrq9/b0SA/fGXjD/Um
 57eIVspPpnChiZ4GfPvHci1od1Sa91MEc8LJYZFfg
X-Gm-Gg: AYBFou3hAPKpsTKKk7HLVGMayMXZPG8x6UXg13L6Hw7ZBJUC5s4wiCi8Aj7i/94OlBO
 q3p9eQ5oRuXugFTzdluNH/0JdX8VNnUu9yrG8yAMinwH5VxXW4orY83GST2kMgpgLKJxydfnVOy
 ENyRb0qF8nu1bA7RSXFockpLGG9/aBszVFeMRfNUrALbPxE8IzWNrt4o8nnkp5sMRwOOnuli9/w
 GXxshvzFijpGD1rwU8cGrI9JyyGuZPP/Pw50tGFQD4W+TCyO26W0F8ayKXhLxpub/Kkwyr6SDFr
 3/pTKVyLKvqH833Vp/ue/MSGgjIJbDnmT3eWEvKCMx0O2v7FhuHx5g==
X-Received: by 2002:a05:6402:46d9:b0:6b3:d0a0:3313 with SMTP id
 4fb4d7f45d1cf-6b3d0af8c29mr2926741a12.6.1792482960115; Tue, 20 Oct 2026
 00:56:00 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 00:55:57 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 12:31:48 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c2916f5e54965c333e3906081d4128c77ad5d111.1791966831.git.daniel@makrotopia.org>
References: <cover.1791966831.git.daniel@makrotopia.org>
 <c2916f5e54965c333e3906081d4128c77ad5d111.1791966831.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 20 Oct 2026 00:55:57 -0700
X-Gm-Features: AclHuK-tgmtakHnTz9JprMXABM9M0r8BIj9_9IrO6eM8eelbaW4v0UhK7hfar60
Message-ID: <CAFLszTiAzc=Nj4SGS7isj8RMA0W8tqta4gbs6ue_X7gjMCP=Uw@mail.gmail.com>
Subject: Re: [PATCH 01/11] test: cmd_ut: keep the suite list alphabetical
To: daniel@makrotopia.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Vincent Jardin <vjardin@free.fr>, 
 Anton Ivanov <anton@binarly.io>, Randolph Sapp <rs@ti.com>,
 Anders Roxell <anders.roxell@linaro.org>, 
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-14T08:38:38, Daniel Golle <daniel@makrotopia.org> wrote:
> test: cmd_ut: keep the suite list alphabetical
>
> The imagemap suite was appended after setexpr in both the declaration
> and the registration list, which are otherwise alphabetical.
>
> Move it next to image_fdt.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
>  test/cmd_ut.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
