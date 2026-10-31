Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6C4606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Pr09CnfE;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=kw7QKCj6
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8742F60667;
	Sat, 31 Oct 2026 09:33:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bbQ80cGhCB04; Sat, 31 Oct 2026 09:33:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CC58C607A0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439218;
	b=PGBHFtQaLHQEPx/3J6UssN3ukYOZ3f13P4a6/Vg9+0728VWCZSDoT6eRqEcsYpRLkKzG
	 LF1IyJzSZs0JYW1bHQLv45jgFGt/cUbzisd2+DlvLg2cZo1boIhITaSClEUZE6HH3yhWt
	 093F1oIkxm1wlhi4M8lCcsgKQVU4oNN6ra+XTyiJ/JBGT4WZfs4aKJ0SUPvNIAINceYv8
	 aktKyx5reZ/g2MA0+zpX5/SN01hL/IuCfdM7pwiVITZqy2PJUB0/JnBiGbRAZFO55DIqt
	 c5MZmq6GYV6nPYGqkCLoIPWb8tP2t+atdo1qMzQRoCO3rAGacxqnkCpWXbdNU+C61qw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439218;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=utcffXiqlm1RFCzhQDLQAdf2Cbi+D4FDHBw9o77pOzk=;
	b=EC025IiO2LbARJELYhnOmqBoE3afjsvtzEaWQMmTeKuZbCCaiGzDvm9z8c8qHndJYCa4
	 PrAswG4+rD5n1BpW7vnyAyzpzO0v2jHBTlLEm9A/trgtJ/gs+EIFw/1VHtmBRwZIi46PA
	 aot9Ypa91Ya+vHAkmY41k0WHfmFsmPapc+HlYiJg7mFj/+QGBqlEoqejJPclO4SUrmdNC
	 3MCCbIQfkXnaEqzWVUCXkIOxpBYA39aCpTZ/KSNhSEfwubwWexdCqF+vaOfhPOWatj05g
	 KdacX58zbY/L0bKlE6JtyMWdAane+k5pz6Ji91//2aNr6s/YICbOAcpg7IU9QfEZGfw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=kw7QKCj6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439217;
	bh=utcffXiqlm1RFCzhQDLQAdf2Cbi+D4FDHBw9o77pOzk=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Pr09CnfENMRCgYpGohS226HnasQGRQfPzznR4+ocXmOTRgdcQbdgCihUtRaBJ/5jh
	 QZCW5jeBKNElJBIrBCfjKIb0q8tpW54x9dOKrulOtQjfwzsZx66zIzRhYLjsVmB4Q1
	 /RgLNIe7Yz5Jv+Ovdy0wTOw2OFDRqDUby8COWJPq8KGMN6K4uqCtAa+ElLvLuLbvY6
	 HEm1p3IccID+Fzo7YNwHUcjSbAcvRGJ+OIW/xdPBvFjZURJAgO4WB/QSyzpgRCmsTl
	 HHu/tg4iOXniefY9Qq+8v1iRHAZKXdSQZ9UlQpnQ3LPraNy7kp3mzHdNwNVUYoLVV0
	 OSByoC3JX8ykw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC58C607A0;
	Sat, 31 Oct 2026 09:33:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 18B8A2C7
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:33:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0ACE7607A0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:33:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OxeiCvNvZ9-a for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:33:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5E6BF60667
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::52b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439214;
 b=l401I3ikMlwGYIzHfVOpwMWirPCZVGM6oVYgN3K8nXRnIDWWb7S3kb5jAu9d0VvJyIBC
 fiIFgdjbh5gWQ2ZNJqiLMsze94uMhMPQOCGOIJEDLGSXzW0TufiU4AGWJ0Br9FM45icGz
 CvxenEUSAwjgX2bZaB9/oD4XqJRBwxJyx027h944sGcljzSAiE4MIWsEjkSAx6Ic6swqT
 3ktMIw3YrSxz+OKldQnrurtijZ12Nrqk9MxvtSE7QqJV/tdAAN17R4rU5zZpYGQt9ekTO
 B3QF4Trz5HAz5a+/SF//6Dck86E+bNeHtqW0R1N4sd/jZidsZ8xgyNWsMb+eAbaZpOA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439214;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=utcffXiqlm1RFCzhQDLQAdf2Cbi+D4FDHBw9o77pOzk=;
 b=gZsnBp14BlieB75OTV39W3RxHizfs1Jgeb+4xifZiK5NXNOtTTqrbZ6wTTdbQUfrtDPr
 0kJbAamZ4lic6p6qSs7hNuIACUrLwlOf8n+dRx+0yktemDeQg16U9ipCZ6bQdCzg+6BDC
 wlT2w8ScLlH9jXR34tghRtVd5zq1Rb5ifXh+FxrijxkfQlfM7Hb+LV0TSX1XxjCHsfehf
 wp0o3202e02MCcCPd7EFkBgfTVN3dkf5BQ7py2/rd02uvx5AuoM1n1HZE/6IFlD4lxoeK
 ampH32aH+zPhkuKGbAisvoaagAxKGjHGdYBhVI71RZMdZ2UzXwz+DDHl2IvUCVyHDnA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=kw7QKCj6; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::52b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=kw7QKCj6
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5E6BF60667
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:33:34 +0000 (UTC)
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-cc751eddf25so926032a12.3
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:33:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439213; cv=none;
 d=google.com; s=arc-20260327;
 b=TRDgAfmnkaDKvAfmvG/dtz2eTaNUBT+cVaHFJJQQQ3G7Z/IVUMKCO/9DkOw4Aobbrg
 cq4Z4l/CB8sQcX1A5Di60IAwfBhPjtG0etfLNzPcZBgkR+YVZ1x2yjGtZ5iHsFCgUxG6
 nh4B0W79ShRWJRSItnXeSwCMoaGRuOG4x9quemUsx/r85tbWLFxbTgXL2y452umD0c3o
 CNqKgbmp9DdiuuPadwABGqLAWPEknFVmovhrLEcQ45agfwq96K2AfGqDz/iuHcTQupyv
 T9rmY7SJKmMrkida0A3V+KyrgJy7cpgE9aCra1ZryhwSzIrsKkzASDsIw8uUrB9JB92v
 P4iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=utcffXiqlm1RFCzhQDLQAdf2Cbi+D4FDHBw9o77pOzk=;
 fh=/uLDtOh5n6yORj/DxAbi3WKq/8g22mpiyddXpu18AJQ=;
 b=mIyO6d+sb1ia+8ZpRkIIN9Nkhyg8CvCLkpQqp7wktH/zoYU4f6ismJJDbViHsFUlCm
 Kn3VQ5egFl1sUYA2dR7wT8NELhlyfKWL68qdjYkMppIeyR7xFi5YWNgNwM2jtfK3nkhj
 unUCV0B8gYRgMzlv9ShFc5h85VmfrGsgTNqE5bYp/C6kIhQeoRoZgK4kFa4xTeIPoDHm
 KIMmBkBJ39AAtUOiHSkBLNt5DkPKgkN4KkUI2wQRjhJDyofRVYyipv19o1XjWMaFRHO6
 VFP0wPoeG2AK6yO+zxrZNU2C93x3nasfhsZZ1tyHkXZ3gPTpawO5MrmGu8LbqAAaMEhe
 GiBw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793439213; x=1794044013;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=utcffXiqlm1RFCzhQDLQAdf2Cbi+D4FDHBw9o77pOzk=;
 b=kw7QKCj64w/tVLzrrUtagkKhlVFYl7FGAIq7Z48/yLhX3S/cdpDqbDUJd4KTm20wBJ
 VcpMQHOoihy9qvLIGlX+qUrVRZGKcqEDgqz74Znvrst0/5s1LlKvSZIi55ezc4kHW1+Z
 VZEBy9Z5/1VDiaPYR2mRJIDUhuJfcXA6j1loc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439213; x=1794044013;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=utcffXiqlm1RFCzhQDLQAdf2Cbi+D4FDHBw9o77pOzk=;
 b=FO4iKUiqTSjXEoK+VRfPgL4wZAckmxu0/IDgxPWwu2cCqUGozq1jbTKRaimZymc+sR
 0VT2QGMHSrUMRXNas9h2plUMPz8q0OJJCqZc8Z8qKJ/U7Z9KVMhwPPOmrNX1OYgMQfFb
 L+DZcA2t/B1+XK2itdR1nr20gT2sEIgrL5rpGBKK658ojkR/KQjo7E3ZaesdA/n8IbHb
 q3h+LdMGXfeKHVAU6PuVggku3FJ3/iKGb0Izh77c2i8Q/yZg+X+sB2AMa2BkF4qKFqvZ
 AfpsdIapE25K6dW5PNK17I7/AQaB4ZwNpH2kdwXTju92aHwuffxAt/My8CowAHYVegCq
 NhIg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxmKeUK5R/vgRMfCvHWzatiyExicmL1rXizocuATFxWuv5pOSy18Yx0fp41AK+O1O2b5CYUIgI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJn+935n4EFDU+Pz0GBi/GvxMiCxkWTYkabQQGHXiW4A/BMFOhE
 lOwpqVbl8fjX6hbl9x5EjuF5n0gUS60Yd25PmBn9zSeaNbOUGd9XjnLikPFVNjjQHBzL+d8+xSn
 1LxZFm4lc3DliAMZR+XygVOe53ExLLJIs69gUGtx9
X-Gm-Gg: AYBFou04ViW+Clnu3wKNGDBxV9sqIluz/UbhuRDvCjW2maqdbgjqrnF0t6FQNBkNnZi
 SSZc71UDnxIUYErK2V0wyHM98HLpsZUk4QPfp6nj5XDpAS5QuK9svsYd3dfx22RSvlSmzddWQO/
 l9guK0S/Pz3snwWCNCea6+tbSQNNhSa38HVfetym+fwhMEHbQomc3vIQkuCyRnlhZINSYcMxdIi
 UPEtK2DTWudSQaJev3aG+2nLIxkUyzqw/j9z82giCtpoCCP0gJPuIgFABiyX6I46W9JOv0sIkpy
 ZBr4lvm1irmU8fjWw8qpgoAanL6q0SaobW5bg+UAtCf2Fntcdzb8+hw3b4sUpxl2Nfb7mEwTD/Z
 9wq7rdO7DVAA/L/CwfxQI7axhy5UXtUI1bHe+w5sN3OCNFetAIzFkDpgkyn6k0hnFv5aAhRg=
X-Received: by 2002:a17:90a:e70c:b0:3ab:2737:3393 with SMTP id
 98e67ed59e1d1-3ae89835d94mr3901667a91.40.1793439213550; Sat, 31 Oct 2026
 02:33:33 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:33:29 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:09:00 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261011222930.1085075-4-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-4-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 02:33:29 -0700
X-Gm-Features: AclHuK9aaw7dZmKBocTMoalDCkh-EPB15aPbrvzUCqR1YxuQho3q3XmJtc9dDXs
Message-ID: <CAFLszTiy8N4ZJ3X0WN5KiLhGwCxWtigGQXSFQjODTELJmCn-Tg@mail.gmail.com>
Subject: Re: [PATCH v2 03/37] clk: rockchip: pll: Always write the dsmpd flag
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Elaine Zhang <zhangqing@rock-chips.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>
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
> clk: rockchip: pll: Always write the dsmpd flag
>
> The dsmpd flag controls whether an rk3036-style PLL uses fractional
> mode. When changing from a fractional rate to an integer rate, the
> dsmpd field is left cleared, keeping fractional mode active.
>
> Always write dsmpd to the register so integer rates disable fractional
> mode. This also matches how Linux configures these PLLs.
>
> Fixes: bbda2ed5840c ("rockchip: clk: pll: add common pll setting funcs")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>
>  drivers/clk/rockchip/clk_pll.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
