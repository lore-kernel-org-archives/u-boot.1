Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED801606A31D
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 17:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZFFiUdSj;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Nevh3z4y
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C41D860728;
	Mon, 19 Oct 2026 17:04:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eSaepdq-LtD1; Mon, 19 Oct 2026 17:04:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0F5A060643
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792429455;
	b=qrMVaJMhfHQmKW6h37P8UJmISmO1N9zhY/r28/pg+21Q2/DvubRP7XpGAq2rvs0s9W9j
	 shoF5wZWhpy2czWwQJz34cCOV+UHJX2pN02LVUivIVe6BPYgC8Vy2+TvvpTy5t8ldAna9
	 tQBttMaDyDUiTE6wj+wJZtrEFeD1nYVYDvHGf2EuhHB1XCPO+wiEX82xlw/2NNgT04IZQ
	 FIjpRtHy/Ghw3+S07nmXL/V5mE3BTj53C4wZFbesDW6No1znPr4ANPpMfLzQy6YIalCN3
	 Cs+rBGGWA7ObZTDb7oNzHhTMhsc46O+ca/Q7X4ZCivRLKGwQZguob2BYGujOUxg1RhQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792429455;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=8jKyEf0EwnYWuGXcUtasMwuvgnToPsLtQOvgbBX85Yc=;
	b=JqS2w5qbCUV5QiIk/5CI/6tB1gzDuDMk/7Ol9nSLvIMQNW0EZn0h56hRugbucC7C68gz
	 G1QI+RWoS6JKvJ17HPzhvDFFKbMbBB6Y+sSvOEArv/k+m1Ynv2smVc3/H0EzxjOIkAHhq
	 ZQqnkxZvQPka6cSb0JhNeXP2kgUZiwDPf5JSF5GVJYJe0RQU6S4e6+RwxrHku1ZbwKttd
	 FVHtEDM/unUUH15zFujSDisGyomfxy/R8pFdr9p0TZ7WOGCxq6ax7jWECJxqE5an2fEh1
	 NoYbyU7eICuJdAsIdOJYA2e5bxEzs17ZT266SXGppIAw1/cr9fPhzughGdMxKaq0u/A==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792429455;
	bh=8jKyEf0EwnYWuGXcUtasMwuvgnToPsLtQOvgbBX85Yc=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZFFiUdSjXVab+6Utt61GAEOhOWxmSb9FZeYAj0lvRVTeAm1cWrTPc2ShkKr2+dWDM
	 yh/rcVTfZiod9qEpE2p8uxaetLQ6ViTyuaQyYhiEBvnUehyC5vIOFKfWHFfrlTLLNR
	 H/rwC0GMmzl9xm4kin3oomrYpFylfYsGbQ5BiR3zTyLHoEzI99kQoC0TltBkBy0ugR
	 zme9nnPIuEc9VlxOCM2XmSmCCldEIBQJarn/MuBkiQiPcYA8t9yExe2jTqwzYdqjp9
	 qTCLAarDd9Y6+Z1RIZs4OnStcHkqyuRAacXZqPA+Wt1R5BWqpQvVyyNoV5dv6sU5m6
	 lLHZpzkUqoJHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0F5A060643;
	Mon, 19 Oct 2026 17:04:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C170C23F
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 17:04:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A75444066A
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 17:04:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J3_ZByFvNjrK for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 17:04:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B022E40669
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::529"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792429452;
 b=MR09W0qrJuo+pBtDaiEHJ45YPpeVlnMQ6SYcEhO+iS8o5D1XorKsHgLGD5fB7RoNoH/R
 aa+1qIf/iCQ9y15hdMzH+/Ma4V3NCsGvyFk4llSbVbIc46ADr/774h4evcb4FR1E97237
 +Hatuk8AjADCh/UMetfKRnOaH9H7jClVjB1jWmfd8ORe90c7nUv2Fg/vMFq8Zegm2rMmb
 vVwGu/GHt5J8JWQapqxRKhowXNP229bED9hre4stO3pU4jh8ptJolpqbmHV2jujbINUbU
 v8exV/dsNDmJNR8Sb2zOY+B2r485sE57JBNZ74cN63DKg260dSoYHPQqO0ZVicYEzTA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792429452;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=8jKyEf0EwnYWuGXcUtasMwuvgnToPsLtQOvgbBX85Yc=;
 b=sYn16DDe1XS/1y1y8/siv+mq3ciin7tAjNzoE1xXtMFSFgP9jr1536+sEKvjDz6DhlP0
 aCNcc2al2yfy18CNwpJ8p4h3AisihbxPIaMcjpRdzQsaiuoqLm+SnYTUCrsVjd6SqWHe2
 Qhrgirm+tZpt81IYL9+CBR0OkZArgPRJMB006VLhVVWfgCPfBhAIXDOwjhwmiD/fT4/Qj
 MZL4VE70J+jiaO8Q+S+ORXhD/a7dPEiqdPDPw/ZlMvIHpRWBG38djIWmxoJf8WmMovsQ/
 2pHeSdyfd0wne30rbdyiYAFzZDeAC6kaOaAkK3XZvLaaK9EXIkbQs8eb25slX8M/UyQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Nevh3z4y; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=Nevh3z4y
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B022E40669
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 17:04:11 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6a642495d81so3080047a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:04:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792429449; cv=none;
 d=google.com; s=arc-20260327;
 b=AtPst6PhIR3OM2oFZqJbbKLW7Doh25uAK674F2jbCxFoe4JpJQVsHDR7PNMXBcdDCn
 lu0v5LENSnuwdmzUqWqEwZaCpzNnm0CGDSf63lc55YKfCB4SK6Q6PKoOqVUyGhpCtPIA
 iW1xvV3JFFG8JZ2++UVBT6ne4n8E5AoTdIrDxGNdLF8pvMPxkOVyYzY1GOqh9PEkstjK
 U0UiPDgblonf5xVAsxu8IDvpny2X0PE2+Kyuk7Faem2nZd2PRYky08rshOIkUOgoCk1L
 IAYu8nbANF3cwg5gbB9fSAuTvSz1pnCFF9uj+pRqBomeAmA/erOb0NHiTyFVGoc71Sr8
 IrXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=8jKyEf0EwnYWuGXcUtasMwuvgnToPsLtQOvgbBX85Yc=;
 fh=iEo4TztB22c5nMGkHSSFbDPpiirMs3VY1vk4H0RV2PA=;
 b=Hdazg7oXuroyFL7b8yQTQ853emibifE+vwVCNYULDiL+Fh+Ou2o3NVqSfwYllHgOUP
 NixYh3PcMogqxCbR3Tamkx1vuuO2Q0ntAutxtcLN6QPSM/KdJIA61WPJqlrjNl2tQWnb
 vfRDjHNej9i+JlBR+/yE+Eqy8BeAnFxJ5fpjNdGf0TaojH/POlX/VLFkeU9XMVlABVZg
 gRH2NqJKMYXbiRULJf9hhZvBMSw9iDNnj7ShQrDxSOtoGm4wfycsWing87mqnCX4OBzj
 NvHNvTJW9DNgHjzTSaXi28GpgQQBxELCUzsvsrmquoCGImR9WbZpFtwFj9cvPDPI5QNO
 O4Kg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792429449; x=1793034249;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8jKyEf0EwnYWuGXcUtasMwuvgnToPsLtQOvgbBX85Yc=;
 b=Nevh3z4yxzSgQFrXCeHtrD94UM+VKN2iBqHpfKmJoXrgqS1jhnNcDPAqeLNBc7BM1l
 ccp4RdmT3ou2rP5+aX1Na6D0M8kY72+LK2p23yZu0ZLiL17BerWKjjSPdXPuTl0gxt6f
 jtN0OG6WXRXa+WHC/XFsYmCR7ZNCfqnECUMMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792429449; x=1793034249;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8jKyEf0EwnYWuGXcUtasMwuvgnToPsLtQOvgbBX85Yc=;
 b=b4FaLcglI2FXKFbuWRq01aGPNN5p8cdlJYrdmoIJ1N7o00FyzW5vFY5YQO0/EN/YZQ
 IpQRt4Zrbq+UDvV06qDiKt6gqqT3+0iDewpCRJ2lkglOjDRPUmadvfhv6IEQbTWaeJ9B
 59hQMhd3eXLddBfoa6sQwiAQIGCde9MgWpLflwSJNZO8JQvEVUIHV+J1TK7z86UL2x8X
 cWRws4AstG7hqNO8Skp2tPetrFqTBdM2fDNzCzf8+77QNIP5ac7jTwzNFwzIKU8H5QN0
 ZGn4jJ2rOMN36dgHDCLuNl6aIBMd0YPA2/8QBDOTQz+Osv1QZ98DCY4ve7NcXLPr8kAc
 CUPw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxZb3yflVHDRBeXDicTm/4/XwYl7s1KqGG7wJM7VM7G320GTqSpTwTQ+t8AYCTcIscXNRPGL3w=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK/JszD+8TyxvjdJEaTR6mV+vYispHl+yPFJjsZWacumZK8vRns
 I7Wm/BKxiDOwTUCcI6TMeaykI+p5L7fx5l4HB562+C7k0fTKTn5OMkxhw7kk5OzCaoG3lYO1zCO
 CQZfbQFWLRlc/1zK25kCuw7R3Z1upDT3l6BAVQ8Oa
X-Gm-Gg: AYBFou2cUeqlap9IkDnnL+YTqkpxLjozuLoL5CidytBIeWpgnXmUQmyA6NjzNhTkZMA
 uF306yS7bpocwgMQOOESTN9OcyV5zPIsso8UP0cbp88vsnFHpZJQr066yo7V9ipxkcc2PWT9Bo2
 HfkqhAbNmMBqGSrUj7l+s2ek80gR8ueO4B+WKWUfxID4X4YkB81iET9D7ngm+ZNYtDQjW46eoi9
 VL7FGl3+48+JGF1t0eirNDlD7EW3/emDWDcCkUpIQBUCn1RzVG13yiK9np9IFkp7jd48pqEsv2V
 G9Bp6e7f/+BAT5XYJYMU1VvsxD9qSgnX9JriKl8mRfruOu2F+STFOw==
X-Received: by 2002:a05:6402:4026:b0:6b1:e87d:5b60 with SMTP id
 4fb4d7f45d1cf-6b3a8153e5fmr5650961a12.15.1792429449155; Mon, 19 Oct 2026
 10:04:09 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 10:04:05 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 08:20:17 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261016072526.2277530-3-mehmet.fide@gmail.com>
References: <20261016072526.2277530-1-mehmet.fide@gmail.com>
 <20261016072526.2277530-3-mehmet.fide@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 10:04:05 -0700
X-Gm-Features: AclHuK-vQ16ZUhe8uAnsQTlKv2w5NbNFJjZD3_HTt3j7tLF-s0yFHVm2zrHupxk
Message-ID: <CAFLszTjgh+xJq5Q6bT-A3yfN0EckSuPtQ7BsO75o3e9FjcMwxQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/8] usb: ehci-vf: take the controller index from the
 device tree
To: mehmet.fide@gmail.com
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 Stefan Agner <stefan@agner.ch>, 
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.denx.de,
 mehmet.fide@screeningeagle.com, u-boot@lists.u-boot-project.org
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

On 2026-10-16T07:25:19, Mehmet Fide <mehmet.fide@gmail.com> wrote:
> usb: ehci-vf: take the controller index from the device tree
>
> "usb start" on a Colibri VF50 or VF61 ends in a data abort and a
> watchdog reset.
>
> vf_usb_of_to_plat() takes the controller index from dev_seq(), but the
> usbphy0 and usbphy1 aliases count as "usb" aliases when the uclass
> numbers its devices, so the two controllers get 2 and 3 and index past
> the two entries of phy_bases[] and nc_reg_bases[]. usb_oc_config() then
> writes through an address read from beyond the table.
>
> Follow the fsl,usbphy phandle, as ehci-mx6 does, and map the PHY node to
> the index of the table instead of trusting the sequence number.
>
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
> Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
>
>  drivers/usb/host/ehci-vf.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
