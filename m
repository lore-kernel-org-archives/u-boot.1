Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266E5606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 13:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GhybcY28;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=HPT442Oq
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 051AE817B5;
	Sat, 24 Oct 2026 13:03:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k-8DT0PcrAAu; Sat, 24 Oct 2026 13:03:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1A39F817BD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792847036;
	b=pTqU6jOEov6w7q4UsM9qZdeinaJdKYXZZ9mpIHY1vhfuSxFI7vhQTwOQKyF4XPzLFe1w
	 HZcKwj4ht8LbrerGGt/TUExGzF0WnDVhQ6pRgFjXUEA0iMeZarE0BxhB1sLuHBtGqlhD9
	 po5RPPPOKsQ3asSWw7pusKT+qhXavqs8eAQHWns5jzMdcYgv5D4oVLHNjgIckw0CBcD15
	 mA/LyYmb/jLXiLm249+hhNqHvc1ZK1hjODRTv+U/B/3224752StXzYVuSu61MHfvG7KTd
	 Epynyu0ztzQ5bFEjJMbfe+tDIltttRX2UFAGP91O/hyTOmXZGaarOxGxq+caMnDJWIQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792847036;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=OIwfgy3MvmhH4o62ydZLyv09wnkWKM96Beeopge11/8=;
	b=IdxUyWFTNmiS5rExuIgHWqiuVWKy/d2Hx9UkXpokG+qkB2YN3oZPEJSg7H5WizXd+4FT
	 P7yt600MHOZZvlP/Y0zNhkdPIqJO9Lgp4VKuD5b/yswlX5UbCJc9QxXlYnEx8QNoHy5WD
	 XsI+HbciuZ9MsoWhdOu2eJgalwAZ+ZcQkrs1FQyqy5wSaQqr8nnogRfYCUkUvchSayd+w
	 /tp0TxFXmacRMsdG4CTBDSo7Ph5Zlflq4Q15n1hQlOvdceYS55nRlhqABmgvdzPkTXU7N
	 txSsMxACYnXpTMl0/rCMRJEGYXXU6A1L/OjFQO9hu9g67uVpIrHkKBzS+uFPoxxWqrQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=HPT442Oq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792847036;
	bh=OIwfgy3MvmhH4o62ydZLyv09wnkWKM96Beeopge11/8=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GhybcY28oxl/KRaCHjJcV8Ym/eCGC+8Cpkt4VeDRvg4b2FYagNAcruXJ9+aa37L1A
	 0ogRYW6zmLQS31PR10K6GwDaZqR28S/hpxlq/vpayRuOVQNPrdXeneuZYZ2TKudZmj
	 Ml37v21IyOQVGKX1tJFxVXUUPNuwa8RuqSL6+IL1QfJB144pZnYK3pxjOfcJpWroTw
	 j7oxiILmdvq1T3O1DamfwmvtuKb5PPzB1iC+gQ3ouuB5aPafi27gu72A/7md2GCoVZ
	 MXmpI1LKAgF+zkloIychMZvECgGFbegNUKH00uoTgOQkL9WjHHKnCFPZn5yF3/JzMJ
	 J0iGI7XH6P9Gg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A39F817BD;
	Sat, 24 Oct 2026 13:03:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A7EC765
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:00:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 20DAD8127F
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:00:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bbs5CGD6M96F for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 07:00:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5B8528162E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::636"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792825252;
 b=G34zCBnGvVMPYpSxX++R4asAYG2/lLYNVJ74OzluP8JUIo35ntJmHdU/uUMyrMXf9KRS
 bwbOPKHtFCRyj6chqDhkWz01PqMm2DaWKdu4Q6OVzRXscWz/pTCBho/qcAMMkdjpK8x3j
 RyiWyruLRzCT93Yulrnb8TikBRW0/DU9kV90ep7Ak1HvM3uH9rgC8i1nBn6JxP17DPsZZ
 uQj0nAcFwZ0F6GBBC02jMPSZ1JSwVqUCA0Zjd3xX+7FMPZkw7jEoKTTb+b9OCVa0aQMg6
 yM5u8n3dMSl2vxP1Q6uXWno23/5TWasc5vcaFFfHFVSvhU/qpAIWACV5KJdG1uQ8YJQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792825252;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=OIwfgy3MvmhH4o62ydZLyv09wnkWKM96Beeopge11/8=;
 b=efHtZ4LdG7W2/g0/hfgoyhJOuo9u+RyCbson1/Z1PecTOBWUiiKi/oMXBe8pmaXhpi0D
 JPgK2VtgWOBKoH/oHGpr2+LY10Y6MCLrNvUED3mR3Ct4RVcKBjnaNg5VPpUkdZwPVIjfQ
 ueXvY3PalMjZz19MsMNnDEt96Q2mltjBMkqs4pAQklf1dJaDi+vE/LZ82kPvHzEL0ZO+o
 jYFbwcJF8DPYX4QMl4EfEwfk73Flrwxx80MS0A/C1tiZgFSkx9bdZ4OUQzvv2d6YwvTkL
 gKJOb6EBF1/SXKUbgKUGrJU6vNOVezWsDqnRBIZ7pA6pOmm6Th6R8LPTfesa5OfxDLA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=HPT442Oq; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::636"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=HPT442Oq
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5B8528162E
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:00:51 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c34bff61551so213516166b.2
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 00:00:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792825250; cv=none;
 d=google.com; s=arc-20260327;
 b=CUDTBLziws4DuSGW5eHgh2qECGL1kcJoK6f7+vwAZP1Er4Subs9ZX9Z+UacXCGTtnS
 dNkMbeFhOJLiOmIEJsr+fnBrYOislM8Fd4cLw+PNt8sLbtd4oeAFwl4U4Waz6d9uZf6F
 9VhCZEmKTVr57fAtcmYbkJjXQwgbl49lINtzNF8Pszi1MBBo1qOXUX3pZgkWyINtKhoY
 zXULLjDTawGs3ggVoEpXPCgFB3w4djniecHVosZPofEjptkCE/6oU3RSIoqODUDxQ7aF
 mnlflIp2QJPDadtBwBkhasrpRh/J9aSBhiWyh09lXz1I/OTTp/TRJLrjPHR25jH5eXI3
 aSRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=OIwfgy3MvmhH4o62ydZLyv09wnkWKM96Beeopge11/8=;
 fh=K3qBHk2ExO+3ijmhm2JLE5PguYt4WNVvCbTK1y2ofoc=;
 b=F2sgXtOkLnoKncKeSY05vD21sNcR83veKGp/aL3gYx0ZqqDjr3nC3vKfeox5/HGob+
 ucKU2AOwdgEJhjzrnqAaRNpkLjrCmuW+kRfkDsDW8X/D9cEheNcQaVdV02Q3l/Sz4NWW
 +2bb3O77JPqE9rGsW0HaZw9OwVUVmqf0HkHDuB64nhrcVB5l8Ve6IUFibjEw38G+UdXa
 duWy0YhfZucGIVFlxYOk/Bn0q42fOcncOKQV/WN+mGKaXvkIqAGjsCdkm0yfgDp/4ZZm
 UUtxjf6MBaK6/LqhQhgkxYxPtcu5sdSrCAh7jjdYKWkaSeh8cyYhP79Ykk2NQvrifdFR
 0HRQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792825250; x=1793430050;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OIwfgy3MvmhH4o62ydZLyv09wnkWKM96Beeopge11/8=;
 b=HPT442Oq23dkC5c2jFSOyYZQBKfu6tGKCLHSoNFMSTflDvqX4APh1s4ePO5m46Gp+t
 PtC2+VAF7KswBqCtrotnTuT4Qb9gqi6KQwgxzYlqteX6pp0c0AsxRkuZgRJk2IQwKkL6
 AXjy3sZcNbSroLOXF3JtD3umu7w5AOtVDoX+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792825250; x=1793430050;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OIwfgy3MvmhH4o62ydZLyv09wnkWKM96Beeopge11/8=;
 b=g5uW9s15ayrg1cyuenhLSWIeO4Je+ftB6Sy73+lVAg8JxX1MX4zBi/quYAJnoy9Vs7
 xLRxluMGWbEHsYVEgYPMEWliB6PswaU5oneTmUGB9Df8sfN93wnqFqVVpdEfRy7o72Uz
 Fzm9MPg57KAF1WoqzknuVY/8oy0H8YDRWrphzlwOtQ5lbnhxjLO3jF2Vdj8O2IgPSs9Y
 0tTLUIpwOKF+3LQ71FpwyD8mvy7qp69pv0BT+Zf23Jmh/y4EtzvnqqiHV0aYhbVeKqmR
 QNUsmPPJE0gI081r8jh/kfwMgP4Oe6TWzRavnzaO5AcpKUKzkMK+mMmbPVvNubevL2Aq
 vKoQ==
X-Gm-Message-State: AFq9FYIbhPo/SQ6kqKqZ7wEK/I/v5Kmn63niRIfxxvXM0kTGFGHq40bI
 y3XQdkrOdYnwHp5rfrWwQPXZuVnPZ6wcrkQ99iGgBb9SDJMLArGpuzjmHFHbX+Qo1KusP8OkVof
 g6tq+4XViNgVNKN53GRmhVTnUhhUqeLvHX79lITm2
X-Gm-Gg: AYBFou08SoA6h9F/NhGgsF6oxIazeX0xNDr3pP/B3+zskpFD0aEtD5plJbZz/w6Nc43
 Noj8OBxkPF6NlP41+gAC5NlF0aEgTuVPQj/4vTm5wYZutfO0e2L8WRU4LBtpwnsJLpJAy+lEEpN
 vpCMaPU5xVQritlljaxzyOkpI78khUSWlxWUGUsf8MgLmWB4mKEg3//aef6xtJobcbFg3QoC5R9
 Hokvd1qCMD8VD1mLfeM8fVwEBMtAS6wFmt7PQ9Ka7mSG+JAf36RLAlEwmvxsbZL7e/nzYVtq603
 Hn39MjLw1/USa3Pe+dar0CTWQs3SI0yhmi1H3N3kz076adfNv10+Jx/tq6oP2cUXa0sr3t/6HvZ
 +jYXlPbbL6fKDcRl4q6JuxmdV9XfSaUWA44k=
X-Received: by 2002:a17:907:d18:b0:c3f:c856:fb7a with SMTP id
 a640c23a62f3a-c46bdaf85d7mr125221566b.3.1792825249893; Sat, 24 Oct 2026
 00:00:49 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 Oct 2026 00:00:46 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 12:16:38 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261020-spl-fit-compression-v3-18-6647aa23ade5@flipper.net>
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
 <20261020-spl-fit-compression-v3-18-6647aa23ade5@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 24 Oct 2026 00:00:46 -0700
X-Gm-Features: AclHuK_qDrxnqKIJr0oz1h7-M4hIkZyinFItcY0dpAKSk8KcWrkffFByxT1TKf4
Message-ID: <CAFLszTgz=v0PJY9XDPVonQV=g71m08hvfbMaPyxYhSFsSskJ-w@mail.gmail.com>
Subject: Re: [PATCH v3 18/23] binman: Allow choosing the compression level
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, 
 Cole Munz <Munzzyy1@proton.me>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>, 
 Max Merchel <max.merchel@ew.tq-group.com>, u-boot@ew.tq-group.com, 
 Petr Hodina <petr.hodina@protonmail.com>, Bruno Banelli <bbanelli@gmail.com>, 
 Carlo Caione <ccaione@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marex@nabladev.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 24 Oct 2026 13:03:24 +0000
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

Hi Alexey,

On 2026-10-20T16:40:47, Alexey Charkov <alchark@flipper.net> wrote:
> binman: Allow choosing the compression level
>
> Every compression algorithm binman drives has a level, and the best one
> to use depends on what the image is for: a payload sent over USB wants

This says every algorithm has a level, but the next paragraph says
lzma does not. Please can you change it to 'Most compression
algorithms...' or similar?

> the smallest it can get, one read from fast storage would rather not
> wait for it. Today only the tool's own default is reachable.
>
> Add a 'compress-level' property, passed through as -<level>, which is how
> all compressors want it except lzma: the LZMA SDK tool has no such option,
> and is controlled by the -lc/-lp/-pb values binman already passes.
>
> Have each tool declare the levels it takes, and reject anything outside
> them with the node's path, whether or not the tool is installed. The tools
> do not reliably refuse a bad level themselves: gzip, bzip2, xz and lzop
> read -12 as -1 -2 and quietly compress at level 2, and a typo or a
> leftover level after switching algorithms would otherwise just produce a
> larger image with nothing to say why.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
>  tools/binman/binman.rst                            | 21 ++++++
>  tools/binman/bintool.py                            | 20 +++++-
>  tools/binman/btool/btool_gzip.py                   |  2 +-
>  tools/binman/btool/bzip2.py                        |  3 +-
>  tools/binman/btool/lz4.py                          |  9 ++-
>  tools/binman/btool/lzma_alone.py                   |  5 +-
>  tools/binman/btool/lzop.py                         |  2 +-
>  tools/binman/btool/xz.py                           |  3 +-
>  tools/binman/btool/zstd.py                         |  3 +-
>  tools/binman/entry.py                              | 18 ++++-
>  tools/binman/etype/blob.py                         |  5 ++
>  tools/binman/ftest.py                              | 81 ++++++++++++++++++++++
>  tools/binman/test/entry/compress_level.dts         | 12 ++++
>  tools/binman/test/entry/compress_level_gzip.dts    | 12 ++++
>  tools/binman/test/entry/compress_level_lzma.dts    | 12 ++++
>  .../test/entry/compress_level_no_compress.dts      | 11 +++
>  tools/binman/test/entry/compress_level_range.dts   | 12 ++++
>  tools/binman/test/entry/compress_level_zero.dts    | 12 ++++
>  18 files changed, 230 insertions(+), 13 deletions(-)

> diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
> @@ -1182,6 +1187,22 @@ The entry will then contain the compressed data, using the 'lz4' compression
> +Where an algorithm offers a choice of how hard to try, 'compress-level' passes
> +one through::

The existing paragraph just above still says lz4 is 'the only one that
is supported'. That was already out of date, and now it contradicts
your list of gzip, bzip2, lzo, xz and zstd a few lines down. Please
can you fix that sentence while you are here?

> diff --git a/tools/binman/etype/blob.py b/tools/binman/etype/blob.py
> @@ -22,6 +22,11 @@ class Entry_blob(Entry):
> +        - compress-level: How hard to compress, as the level number the
> +            compression tool itself uses (e.g. 1 to 9 for gzip). Requires
> +            'compress' and an algorithm which has levels, so not 'lzma'.

BTW the 'files' entry type copies its own 'files-compress' property
into each generated blob subnode, but has no way to set a level. A
'files-compress-level' would be good, perhaps as a follow-up.

Regards,
Simon
