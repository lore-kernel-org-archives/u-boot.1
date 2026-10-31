Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F209606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eIuDezbG;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=bfV874FG
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3AC9F81182;
	Sat, 31 Oct 2026 09:36:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZQJf70wXO312; Sat, 31 Oct 2026 09:36:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 94708811E9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439384;
	b=GNbOXy1DgOupuwSv9UryqnR1b3sdWDvbTF3byW731XEMCfG+6g1hKIs9SBQkObFoWh2c
	 JI9hxsmmb4WCMMiXGJxXxYDieMZsRXWL723vfKD+45G8w+p0li+YH/8+wAkXNdcu+pvG/
	 e35foyrxMlVmOZlPgNsfNJiPHUHi6nvV5iMl/yU7anAXut7sVk7L0Y02fLZiJjmnILHyh
	 QoFTvbJuqqNEGj1DX+8G690z5BCid7KoFuKBYXNsNcJ2cZZSnwiwwjHPzYHWxIInHNQAb
	 /VLd2vP5jkLmd60wHYqi+MP88mPKnt5EAxr0I0LuRjLl3CKtRQFJ8DsBagAx3KWqZwA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439384;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=UxMw+BIo7gnmYl62z4V10B/0vWNXFjo+UaLSsdwezXw=;
	b=oFRK0bkeC+af+mYwV5VCDb4w+/ttceXTu+e/ZUextZ+a8NSjeK+sH45fTq4y1L+4w9lu
	 ZsqVc40cchOJ4Cq4ujAlODnQz1byXFRljMpbl5fRRSrKSMYEAGrDgizys/ofRhpzxlRcl
	 ks5Gf78AcE/Kp0jBuQl+OykrIPoLEu6+Lf0hMJWeK+M/RcmwEnTNtHrJxY9QmsDSRzcl3
	 w65ez7Fj7FyGZErUM/lzkReCtSgRq7cTOmXv3oo6KCP/wyGMLZu2QcXic+CFblKx/GF5O
	 bqBl1dxDaaP0gB++rXqXZFVyoWyBF0nGFD825ZJqcfoOvk/9p9aad/huCQg/zWOs21A==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=bfV874FG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439384;
	bh=UxMw+BIo7gnmYl62z4V10B/0vWNXFjo+UaLSsdwezXw=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eIuDezbGoqYy8UypDhAvjnRm6bY+HKrqeYzc0rdHQNGPi5aSQ70XE6Jcqky6AH/Xb
	 q1D//fiTLdv5beb53LFc1j9gHtuQPYM+l/KiWnDo37wBH7t3f47NkED2IE8nf6ccct
	 XVofIQgp5lb6zy9zdcFlQB/eooa5/4GvXLYcX6T+kEzv5mkYsSQiZROOBZfZnLPpsX
	 UADJ7PfeQ+65B1QXoOwDW1yq4GR7HlTnUjYaBqgoK9uy27754Jj0FMvNLula9Y6K36
	 uQpf/NgzC4rA57pn5zHSQTO//riFDbg4Yk3QNjWMGQW+3eQHrFpV8bKNWgTFLeKKzS
	 FLT4U0BA13HCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 94708811E9;
	Sat, 31 Oct 2026 09:36:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EB1FE2C7
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:36:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D9CAE811A4
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:36:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZZN6UCdiKZxx for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:36:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 06D4D81166
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439371;
 b=fw4k6pghZOQT7hKbuEiET/KMBkxdzxSDod5uAqRySbIhDA7EtPWmK4vfVQM7kaCnziRp
 bAsMeKAsimHT7iVEXa42pVaiBtdMSItiJfYa3pbrNAi5b8F/Rd9GOdYyIzNMcFHo/4Y0F
 9fCKGB+aUjbRerkat5QGgJ5jjJ3qq6t1A4e3P6xhb3gus8Zor1up/yfltYDyI9OBrVNc/
 vf9/x2qyNgeu45qmOVk5/RyZ1Yyu9yD8uVsAAzabWEz33GReAKBXhSajof7IWXnhWSpWJ
 MQhKpbxXWknHGQHdwmEHm8aJvXHQckHw5upoTjPTRn4yXOe05OSLz06WGTahC4cn3Kg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439371;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=UxMw+BIo7gnmYl62z4V10B/0vWNXFjo+UaLSsdwezXw=;
 b=YTRaDVmI2KWEN4BrqBhbsId+2kaisKXccPCNI6P0b21v/SjllYdSGQrdgbdZVquO7cQB
 7pfrc0xf5RF4u5P28QLwwzWMgSJpykM7kLDWD6pGHkWHomN6QNVXIhC37Z+9zyeHL4kAs
 UFI5psJ18OCW8Wix4BmCT+D0QXs86zuPxKMyihwP/QkDGrdGRyKx1hBf2KMWp1zYzC6X2
 T/6WUAuN6rJhxez9VB9pAXWFedJo0pt6Ee+xzDPuL/yF1rNLqz1J7tP2CdJAwjbfVgNo4
 X3XEL4iP7snyHsZVQt+WPzslYhyGC6ISCc2yX33ILtMBN1/LA8GJIzZ/YzyAY1/6vTw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=bfV874FG; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=bfV874FG
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 06D4D81166
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:36:10 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6b1a86c0316so1911498a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:36:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439369; cv=none;
 d=google.com; s=arc-20260327;
 b=k1Hu3+riJEOLeVLd03FZhQV+CJ76Mf4PdACwFwOELeebqtSVi2FpR/x9ZqLpa0JPqA
 oxPQfaMI+Y6ub/QcgcS1um9+GbFnNABdilpWLhwvyMkCxP0i/Fmkak8wjs8epqehQTxk
 oa/56RXvsU5MJbl4wYRRJg+8rGN03MeSBB/txVpYro0HQ4SJETuoDeoWvOorGN9JRtvQ
 9Lklr4hT4s42ZLMhHy761J4kBsoUEBhJlrfE9MnYJfsIE4VZk7toKDHNE+ifMg1CqaWv
 VpZlkRuq9bIEZ2iapo+MUGAbs9GaiX51wNDKDvOxnAb/WOdv4gmTjBO8SQi1Ea3uaH8B
 0juQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=UxMw+BIo7gnmYl62z4V10B/0vWNXFjo+UaLSsdwezXw=;
 fh=dslghAwV3nK4loEpKFYun4dqehPNrbOsmvVQo1PfImQ=;
 b=cZQEU6qjUt5jKL5Mk1vivqejFGsUNNZ+C5+I6ajSoy94QEFw49AroWflTZs0OnxVXe
 XMrVhOK7a6XRgYoMUvLJpRqSvXH+Zg4gzJMPTiPRiGilzEXq2WjR3S5PrYbXcU/5TDDA
 vbvD4EHXr0oXDX3ORaaKSCrQQejChfxPV8XOCJMnc+Fqg7SAxXD8GL1k1DnyCxg5tFaC
 8D4jERQcGUEAoEoDJ7+hIW4llVjVjYwWeSCdB0VNCaZXAVr668OJsqfDkVnrWS/sPUsY
 UM8x7z05VNXBtMP6vjgGrxv+upbdH9x+OZY85zGyj07ryoo0DZQXcE97maGKlhUg3FtX
 AY2w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793439369; x=1794044169;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UxMw+BIo7gnmYl62z4V10B/0vWNXFjo+UaLSsdwezXw=;
 b=bfV874FGjC8LnBvXvP5npcP0FjWEG7KYwoNtl2AocoYp3KfvOAG37k+CB23qeifR9y
 7bQEkDyD54R15TxNrd7v1j59As5fC+xErba2zFyOR3DUycV67yJioa7Dtfefu7w0BKLq
 AZH/cjlhxs6rP2r7tGHKVDLYDmxUHQRS7jN5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439369; x=1794044169;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UxMw+BIo7gnmYl62z4V10B/0vWNXFjo+UaLSsdwezXw=;
 b=bUnltHXK6tMpiIgfJyTYaT0jCEPoaiEdpUikqA8XwV02XXbzdf9GE0KkPCRrZ9RK1l
 t9P5jgq8eUR7cU7x0HwfStkE8B5fiz81kjxL7NwREfeGrFxf5PCuy8DHVboiiIoBL5Vf
 ZRTAZvUi29lQ6fnezrLmpwWML75isoJHu1zKoga+LApUactimR9x2bIPdROTJmBy1+5G
 qDdqDhhrblzqcq7dtPa5Bqfna0WC3A2+KNLsGy0HLLl9owcY20EPcuRH/CpfD4hs0r4g
 UdH61E6IHvotIv+5+5kJH9Z96ryPny0DAkBM/PpAoeVzpznUfexVdZR7vjzk7psg8rNn
 9UEg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw5po4/4+sWw6lMaFAzZgudfkv1druOw2fvUYgjt2Dm+gy07xxhYG/hkUemysyXvbgId6Y/MOc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJWG4rCQUkMI90vznPJ/NI8Om57EgmF4GrDEy//RVDw+9aVUp0o
 gn9YbavisPY1nZGkSBAZM/VjcyIXQB+ZtVv3uVD0mJctkQGvGPacQiHP7+djfI7d2ciGSFwPC4K
 tOOKMRlKHLR6gDJYk+fWg5JlJajqw2hlbHImBlWZa
X-Gm-Gg: AYBFou01bX09GLP+xLwtnGkEUtYznf02BvA7VxLz/H1jlAAnB15gP9n7WQhNNuwn4zQ
 3kMUlkThZ7F1jymCJINC+RdmonCq0Oh0R7h28zvJrkQRz3O2aK885M4rjpuQfkNs7g7PClsTmR9
 7E+w/O0koA7w7/IPGsKUCW8oUIzAIXBvoeWmzlryJ4BIzT+Nr9WkwnfLzzoRh7lKU0aCgQ+Q/8W
 +ctQ2zy6np4Ze/NXo8aRJK6NntpxX6HoLJ7TWGTwiEyb4loukgHpbhxEDG9nhcvWcGNTK/lUz/i
 2GoDbZHEVYGLLGFmTNjnGR3xoldCx8wfVlv097ueQdNk0GFFINEiaEf7PQwMtJraMCPzWRtG4Sz
 arf6/P9qrL6b32lmKBFZAZbkFb87Kk0dILuQOPG2RaDL1zCdZwwv9lPJJmT9QqPJtc6vp7gQ=
X-Received: by 2002:aa7:c24c:0:b0:6b4:5a0c:a7fc with SMTP id
 4fb4d7f45d1cf-6b4d4d738ffmr2492872a12.26.1793439368903; Sat, 31 Oct 2026
 02:36:08 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:36:07 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:09:27 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261011222930.1085075-31-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-31-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 02:36:07 -0700
X-Gm-Features: AclHuK-luplTkZDRmLJRAq44hnowkC65IcoyUXbJBVgg0mscTBRIJP0cJQmtDEU
Message-ID: <CAFLszTj21T7HqGFEykpy2LgUyE=q+64-14RuCdYTb4--ycA1cg@mail.gmail.com>
Subject: Re: [PATCH v2 30/37] clk: rockchip: rk3576: Align BPLL entry in PLL
 table
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.u-boot-project.org
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-11T22:28:36, Jonas Karlman <jonas@kwiboo.se> wrote:
> clk: rockchip: rk3576: Align BPLL entry in PLL table
>
> Keep the BPLL entry formatted in a similar way matching the other PLL
> entries for consistency.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>
>  drivers/clk/rockchip/clk_rk3576.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
