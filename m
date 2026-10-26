Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCCD606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 08:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fcwa0pxo;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=aeb1Zfvr
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF7BE80D1C;
	Mon, 26 Oct 2026 08:43:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SMXTgCSUlM2o; Mon, 26 Oct 2026 08:43:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D96C080D1E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793004211;
	b=dNXr2fTL6g3e6gcaF5yrJALW5YftkwfEx+wxsnA008yd5b0qiGbQ45w2NFx0ndWoggYK
	 ur2VTVHJmj4PPhXTwq3TX/1rOclND9p3uEZd5uZfWLVeSj4WLkVa6Cb5MGhxkT1JSJ15m
	 lZFJwMPanflJCiW1mAdiY4CzUVMyQGaZyplspqIPZebBtVQVA2ggnl2za9H/UZtZRc4f0
	 cJlBGaEH5mgIZBW9Lq2bpFpxNFq9oqUlQFfu6K99cRQTs655hVJ7tzLkJgV/dmWeZ1EvT
	 qKVR10FKghJapCqIqzNKJeJGadVtFQcaxJ9WgFY2yIZ5sk3xJ5DSeE+/xRQn2k8W/tQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793004211;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dhNeZYCPO4zqZ7HTsJ7A3DCJ7y4eW7VffnhgemjdW68=;
	b=rBKmhiCLq1GXToOBMgiL9yu25142CQx7hRGzepmC6dvIwMMdYKb/GNGUrpwUSXGtH+it
	 K1UC1TrNdYOoq9WyaJKdC6MmfpNHLqsaPLpDBMHLqvl1t4gypRR6pMXFATwT0U0iIaiBu
	 r19xSfkXsGWuGnuNbqM2nGYYcsvoAuhHnUdUDIFabDsDm3hFwSLrvYrGNy0W0Vn56D3xU
	 6y0eZlsdPPCHkzSh5/hKIXiZZKTd6d1NAzSwgZUjBuCG1VXnfwWp6RuXSWt+FEBhUDGbM
	 SQstkX02H14jwTFq6xkYNKyUoar21OaZ0VvjifKu4DPY30P+ogJ6jHlczydfBRjnM2w==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793004211;
	bh=dhNeZYCPO4zqZ7HTsJ7A3DCJ7y4eW7VffnhgemjdW68=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fcwa0pxownVV547h8A6kMquVwwhxyu19VL6D6wdYh+uaijlBYlGHjPXULGBWy5u0n
	 hqjPsQwhmqfvJf/ZAeVpZfD1lqz33lUy5Wey4F/0tZ5ENK1XNYyeeoTVp/QhS9q9oO
	 /Zh6GdBerlRgBhVw946NmDMKuDE8wwrD8WVxhqE2Pzwg47ihiFKVJMdSHsF+///CQP
	 g404fjjwDVk4kIjTVnL6srSEPdexuqyuYqtGiZ2qPIQDEgYYIlWGACSBABYVigl3WV
	 C+lxuAt56j4mRyS+/i5fmpCT9G4/pp6+QbvHLY4b/B4DGDhgE8SMrAhA24VolZK/7n
	 JP22E2YoZvUnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D96C080D1E;
	Mon, 26 Oct 2026 08:43:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3496C3D9
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:43:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 26AFA405F3
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:43:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6dQvpCyBbDlz for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 08:43:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F379D405EE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793004208;
 b=TN6K5E/aID0K/lhbvkbx+ZDNOHZVLK+6YkuJFXuPd2auiBcqf5dto3gUTj2ADk8u0G2z
 ylmE0b28VklWXWZjvS/k48ZUD2llDluciey959ACNS3RVACw6XTB6aJUtFQmU1hz6zCVx
 IN0z8LkSVfbhAyzWqVbB/W4YBlrM/8sbnvRgTuaWtEZVrnmV4YrjnJp92P8SI6OkgCAhF
 7t/mC0rclrvxDlczO1iqVUAHpwWrgI/qb9nyKFdK8lUrbKZ9scJn19/FwMNdQyYpgw+0M
 +ZlCy6S3KRusmaEZ7jViI4CCqXT0AbK6HRukEmkpUx2twO+uk6p1OCbZIcYRx1nXwLQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793004208;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=dhNeZYCPO4zqZ7HTsJ7A3DCJ7y4eW7VffnhgemjdW68=;
 b=aX7ops5YYn/gBF8o1jzc0+ojh68uI5YoLzJe7JvM8iFc1olNz4ArBjHdl0W1dD8tyZCT
 9KdRCAFwUbNcnUbdAlmN4nRiJ9qZrgSEC6huPEbffuiCkJ3cXizywTjTFYl7FIR+gzCSh
 mdB4/WFT3X50+aG+UqWfM1YTPEdPh26PJjNOiLEgLfwkrIlUSbXxJNHpXpa2qXjfqXYEM
 K1HrxgSEeGCapFpRE8WgUg/j4FTQn8URBp3aIsgAQtGYvyuDns6xOKQk91P4qgykvOFxk
 rDXEet7ruogBo5OAQkc+RAxhNj9Clx5cwhKnIkkW23AfmTRleOCR8FDLSiQUvcxAPHg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=aeb1Zfvr; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=aeb1Zfvr
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F379D405EE
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:43:27 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6aa8d04fcddso5264712a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 01:43:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793004206; cv=none;
 d=google.com; s=arc-20260327;
 b=Xl2iwJS0DbF4FKV6bmEUiBpm/WCCK+h8zeRXXrPxtx57mIqMcJDEHDpuwwWctlS3ZY
 wFu1CxMnBl2ZtVfF4CjnmyWMBJFjCnyqXqwsBOSkaKVPF0ynKCije3ZG9+QS+Do6Srho
 +Gv+C4MPKIi2p24XIH0uKZH4Y+Ax9KDcT7bl5w/b/s/I3imSuXIgk19fu67Qd9/PC/rk
 1BrAKtICDwwVkIozOsoWzPI0Q+Qa0EsAKnoTs25AwVozeMBrOa/sZ1PGt/YMhu8SX07N
 s7zlErHSouuhdQTVDYDzqbQ77KH0jkxZxoJhp36vtS2v2eYjrL+uOZmDfgTd3tY1LLTU
 ciPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dhNeZYCPO4zqZ7HTsJ7A3DCJ7y4eW7VffnhgemjdW68=;
 fh=MxjaMYOxdebjpR0J8A8gTf68M2sVZEW7Yjq7rBap2fM=;
 b=YAolGB09QBkMeilOsly7Ky9ws328WBQGRCa9OhSiJiBjIoP52ioz8qG5e8wsCZM2d8
 9HxjcKEEq5fXjdIQPnDPFUTEm6FVyLXTNn7YvsHdd3Et558N8mB+tyAIoU71Ek/gkXEe
 Nlq2zsFxCp6XBKZXhbuYdoh9jTatuv22rta/Av/M5KbfKELY59QdUu7VuU/m98tF6Foa
 3n2R1U9CmujedO5e+DCz9FOPN2oY+/KksLeiOR/2RAocNJlrbuwdV6LZfURo6VQrQg6g
 C1oOmH4CsvcAVneeveGgqEU1xLSbyCuvuY7gJ2LL/SaXLpTRKahLi8I+V6dJoF96o3T3
 UwqA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793004205; x=1793609005;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dhNeZYCPO4zqZ7HTsJ7A3DCJ7y4eW7VffnhgemjdW68=;
 b=aeb1Zfvrz9x0FkRsNLbAZqlB0eT1cPEkhl5Ior3r39mROxQB7yjQbRCFDHxLdti63w
 EljBUg/BUi9xhZFgbI28aLyKvLcaEfv/gRWSavBUvKqgoOmIqqH+j1RIrENNzI3aPz76
 joUDB6NHqlel1hASELe3LnWivCpN4L9F9NCcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793004205; x=1793609005;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dhNeZYCPO4zqZ7HTsJ7A3DCJ7y4eW7VffnhgemjdW68=;
 b=bd8RBuReuIVz7ERTs6MQGL4rK6ZlxRIYr0XhwmTosGx+qBcfDPUdG5cfYevzF5YnUY
 NBmOVibBeccurrw/QVtTroWcwncQzaQv3Wh/xnbzvDYGeRuYpsJbgclZ7E2iTWPfVO+z
 Tl11Kw9m6vGxifh+s25GDlz3QHHDL/hNWOEfeVmdaqh8iGcWkS5Dm/5rGMiFxz0bRbdr
 idKZCs/h8BQNlp0qgkqWSq8tnEMCkpI7gtBzrbq91D39TqZAIbzLUdmt9IycCDETAFC9
 Q8SgR1551l2X7YHeyWg3GqfFmzdUJQ2gAq+V9qFhrpImL60zE8Wac5x4WQbl0lpv62EY
 Q54g==
X-Gm-Message-State: AFq9FYKUXEKRa4JaQQeLJe8SVOYxQHDAQxVSBnPdyH2mvurBgI69TbJS
 IQtpmfkW7HVCAlLF/jj7JullXmS/SIYO0PhTPmkiLSUColTBKPQfeSYCpcUizAzfv00Kw1muMq1
 ricZtHEv+84B5tTGX28vle7gPr182vfWmNZjxIPdO
X-Gm-Gg: AYBFou2y6Drobn3WMJWGFRXn5BDbrPfCLKC4IpnffRLyJx6SnzKhsd3BUPhPZlwIk04
 d5POTJF3m0NeknzoouuinBEoHJgbiuT8+lxit7SfP4fqosTDEUcVrn9TFjgkx7EhmSMFq3ofGoY
 QOHuh6p5KOdUdTJUn52RmRomdVrXTkucgokmQAdesHq08v8nQc+B9Z5ZVbdz/0akLOicx1NfEsR
 EmTsd4ZrtlHfRkAWG79NkMJyy1fRBOJswO3iKye04OOQv+sdFr+utoH9YcEv7X/lcAuzSBRXZRv
 HFmZgx0U+haHsDvbQPPYqAkAaLcoQm9eZ+ATaVb25RMxLliO1uCTjI+gRw8T79qCI/1cHJy06Xf
 G/qRSJ3eJPW2ElU6GuabtD27hhZ084K3lvsI=
X-Received: by 2002:a05:6402:518e:b0:6ac:7d58:dbed with SMTP id
 4fb4d7f45d1cf-6b443a23f7emr7641927a12.3.1793004205626; Mon, 26 Oct 2026
 01:43:25 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022155806.115031-1-dimorinny@google.com>
In-Reply-To: <20261022155806.115031-1-dimorinny@google.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Oct 2026 08:43:12 +0000
X-Gm-Features: AclHuK8prqu-e1QMpO0cYKozpE6GGE487vcDXuo6biPvcMHEfeNEqceh0y3rDrc
Message-ID: <CAFLszThxN7FHqCuo0fdj+zKAWvD4M0qRp6WzFdcSBNq8F6XtMg@mail.gmail.com>
Subject: Re: [PATCH] x86: tsc: Read the base frequency from CPUID leaf 0x16
To: dimorinny@google.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Bin Meng <bin.meng@processmission.com>
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

On 2026-10-22T15:58:06, Dmitrii Merkurev <dimorinny@google.com> wrote:
> x86: tsc: Read the base frequency from CPUID leaf 0x16
>
> cpu_mhz_from_cpuid() should return the base frequency in MHz from CPUID
> leaf 0x16 EAX. Commit ecf31113f178 ("x86: Sync up tsc_timer with
> Linux") changed it to read leaf 0x15 instead, while still checking that
> leaf 0x16 exists. Leaf 0x15 EAX is the denominator of the TSC / crystal
> clock ratio, typically 2.
>
> The function is used when native_calibrate_tsc() fails on an Intel CPU
> that reports this ratio but not the crystal frequency:
>
> - in 32-bit U-Boot, for models missing from its table, e.g. Skylake-X,
>   Ice Lake-SP or Comet Lake
> - in 64-bit U-Boot proper, always, because gd->arch.x86_model is never
>   set there
>
> U-Boot then assumes a 2 MHz TSC, so delays and timeouts are about 1000
> times too short. For example, a Core i9-10900K reports 2 in leaf 0x15
> EAX and 3700 in leaf 0x16 EAX.
>
> Read leaf 0x16 again, as cpu_khz_from_cpuid() does in Linux.
>
> Fixes: ecf31113f178 ("x86: Sync up tsc_timer with Linux")
> Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
>
>  drivers/timer/tsc_timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
