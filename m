Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61983606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 08:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RJ7lONB9;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=nFYHSmMS
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3AE23805E1;
	Wed, 28 Oct 2026 08:44:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IZoZM-vk7613; Wed, 28 Oct 2026 08:44:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 85A6A805F7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793177045;
	b=odmzNBAamuA/f44ntgp9cOMp/Slq5MUGX1bZBtC1ADO7fHyyUp6HBbytiRXZTPaFNzYv
	 NAl398YKxt4kbzYrtaugZMeAUC9mJJNYvrtRGCXFOmFxrSsbxvQR8utDJ9bpyJWM+sWF+
	 0pucaLGyYM2EPPrkS82xrRf8YdgcdFiXOfM1odJejdSTKB78csFnExK/iFFaqGIbqCDiG
	 2YSTkfOW/qyYmjGyG32xmQ343uNj37vo1vnO3krogqqd3NqzUbEbg5cna1uswGFsY+dKi
	 CtheZUesXujLxK9XQAMxN7/0AizMbH9fvWFBtW4vrCZ/AfpY1B9qSYDdF4yTzgBRG7g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793177045;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UCHfp2a67z/+p6vTNFlrnGx4/tywzNyidjsF9sH5HSI=;
	b=DFKANWnn9FwKdih9bba4gI/LqEPpRwzl+zOTBeckctitZqE3uP8Swq7/fPAs/6UUncJA
	 Fdq3MgsM4/n0FjM4L2kwQt5CMlHKSsYTMFU19gon/IBxrEnYIsyftZIgEnmvdXK/zPqoI
	 lEq0WINKi+ywT7ReX7UG+sqbkATGC4SQM2oJZoI7CBEqennTwjYe8IQ4cRIx63AXU4QFq
	 xB7HExlAbmCYg+mMJz8xpvShsoKKzUkkfLaJW2FNHViwtMZe40t7P1VQyQf14w1BANVif
	 vub1JwcXyoqTRdON8C1UcnvImbtvTYZI0k4t7Cmaj8tzNA6Ps5cCAVUd9TA86japw/w==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793177045;
	bh=UCHfp2a67z/+p6vTNFlrnGx4/tywzNyidjsF9sH5HSI=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RJ7lONB9ynW1QvPXkO+lT6qltAhy/l+VWM3PK/XHwdurA3ZCa42ntVk5E7ctfb7Lt
	 D3Br+485A+zQwcGs2px4/ANYIEp17uoUrvc2mpGhqaMduZgZp4eKvO6nydmLSL+F5n
	 70qoBRPJUPQnTkCMh29ITNZrCqkBf0E8BUweL3dkomBrC5ZhFAst/oEAqaEWw8AOgS
	 FUj/ZuGFYeJ0uq3AVTwYxazPFBPuvtG0H6lAVAfd65xKAzjIkY209PK9XzzjSWWYpm
	 v8g7fKrT3FF2TTLpFilZuXC+3K+Z+rHlVxo9FCY0oFt60XUh+At5Cm0u0HMIjivKFC
	 ZlXe+DYCIxSBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 85A6A805F7;
	Wed, 28 Oct 2026 08:44:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7CC844BC
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:44:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6A5F8605F1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:44:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aWmrVl_ISG58 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 08:44:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 75ED6605D2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::536"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793177043;
 b=adID9KDio4rPIwCJF4JE+1DrRGfY8aeISTRSTexwd4Xr5AFjS4JK1Hj0QVbsnEHSWwN0
 mdaSVZJDZeKZIdYKaPzWGut9DV0pHeoVNb/kCBXXi30oYSiengfOrqIM+zze2z0tKRdbC
 SohMVm037jaJ7fIldJf1mSh05Dg0jjTcX6ScNz4ZOalOhr/Wovs/DjHc+xOyDzroY3xTQ
 wS3D6WW0hIvpaAcPLbWsS+7NDmWZc+Kh8i0ybf1JcEurlZGnHYcX3UM1j89uVNetQHs3f
 6cj/zL3NQw5PQTswyvfOVWnLLbJTRxMSfkO7Vy46K3b5Q92FA0hmEivhuI74oXFy5yA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793177043;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=UCHfp2a67z/+p6vTNFlrnGx4/tywzNyidjsF9sH5HSI=;
 b=Tv9wqiGqhQ9/43s0AAkrYqzBVcBCXn9Q+gTcqwhf8JeREaThs+v6vjyWXn53LAwbtOsD
 qc6ImwL6NKvvBm4HS+liyA7JBh9obdGlEMe1+zxZxzCfhoMHLsoeeP4PwtqDw6XBM00c+
 tXNuYipJckoOImHr44zpeyMDbxkpk0yb9ipmrQVfAUa0/Y8/DqbODsltqCAjc5gB1g1Nu
 5bGdWRMxGxVB3uK8og1KghP7XJAT5iWaV4rf8n1HhmsxC1V/9qyDiR9VFSTCUYJRmWauw
 BfUcUwHRk4O9NsvrlZrbJ8CwQjcHEdWslpXiZjCsvtLveij/RivbMtup5LqsM7V/Wcw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=nFYHSmMS; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::536"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=nFYHSmMS
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 75ED6605D2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:44:03 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa4d71e7so883123a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 01:44:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793177041; cv=none;
 d=google.com; s=arc-20260327;
 b=hFmk4esTgkDUV5XQtPFYoi0WDY9LG2UMWpS9RohVoqC+hZVVCOYKQOEvPX8Mf1jFzK
 9JvQcDFH/NAj0FE0uNryjGuKkGMXmhbD7CI90+rJN3xs2Ks6TDjX0Fs4PVpzGwazYety
 DpXLDOQYggGGVF4HftaJUPu96qtx3Sen/uyhvtDbBRsNVEEpDGB9y7Umf45e+BUK4Ty6
 r+sotW1uHFweaWBfjuUCpOYO1FbHi+vDG05LMA91k65tWTECJkASGuYP6xS31R06STh2
 jzDjbQ61YeenFlGBln85JlCq17C52nQJikk9BE48Pe9aZotvfuJQKEo5ZADn4sDUT8Tr
 xwiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=UCHfp2a67z/+p6vTNFlrnGx4/tywzNyidjsF9sH5HSI=;
 fh=/DD+xZkoNTprFhrw2DcgvRFrzcYjpf6tnw1WZgtxNVA=;
 b=XTz8MA8BigPrpdWhaP8D1IbyobAqa9CcoFXXt7JHdzc+TNMfLD21WpWA5DwLnKxN3S
 FTB4FUwenwlyaZnIrl76sizMEdj3HXXNvcLN0y6igyMZs7K0weRhT+EmxdPumoxN8ugf
 ei0F+eQzS6nAW7qdX6+8msRHtKeagxoyrTVpMtuuNtQHo4ZyIkOoUE2PoAHPF82lhbOu
 dezEUYsnhs0Ojf0lfof7+d6U7BmoSoQMAQ5NBxljWBDnRcnwXXyfS4ICzZRMXGUoZv8Q
 IjJ0yNJ5fZQslrIQOGzd699bfPjEXsL2glYNOfgufRZD+OxuK69t5KzETPHiyQ0qEtWW
 LEPw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793177041; x=1793781841;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UCHfp2a67z/+p6vTNFlrnGx4/tywzNyidjsF9sH5HSI=;
 b=nFYHSmMSyfRA55TwFjvMOVk1nof1S1MoV8vqf1Ib/zTfJk98+LTZGgh/xBARpvbmOD
 Y/iRIC58r7+ZR485Z2jzPhMs5soEcJUNgSYrT5nIOdxlRLYTigCOUHSLa91XvB5foU9B
 eix6n7BsTzVZ/1Qvp53J9dsHpsgodGbpdiT5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793177041; x=1793781841;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UCHfp2a67z/+p6vTNFlrnGx4/tywzNyidjsF9sH5HSI=;
 b=jUa8/aN5hWGxakbjBgIRHMuVEDv/XRGeGvMe2xCdWR4DCFh07HX5eyj3sit/15d5WE
 Bb9lC3Mdt6Dub1qqCM+1zb031jBPdNGp3FgE6AJKhPDiZ3Cs8hQS9QqsRw2KwCPeSb8X
 yNDmmrJ/b2yGu4GsHaOvwYBv6JR+mxPkr1rzVOagqmlIZ1WADEldtl2Vx+IHMM+yqcNG
 QLDXxcA+gVUvaWYhkY04FUTCwSIXuBV8a+6Cv3XQPggPbmdd5n7iC5IZmTc+WIayVCSs
 Bj4Eqxuax6hVIw5ezFwd3ZfcxowFfItIWgu0m7EygJH4F44u1ThDq8g9nu9FC+kvB0nJ
 OJ/A==
X-Gm-Message-State: AFq9FYJMSQGBHXu9TS+IFN9in+bSvTtADzgS5OlWyE5ZZMNqz/tA/ztW
 Ns0sb4O7pui9pcMkCj5FlJcw+/bp4CyIL/wZGM8DCMXLOO/fg10N3qnMwX7FoKZ3VhMmREz3Dp5
 uz+DFbmjEyGFAugSQg5gKD+CUaSSQ4WYr//9WN+wU
X-Gm-Gg: AYBFou0H5P1VBhmNWzdr8o2Pfz286e279/C13nqjn8ARBB/N7gxrL4mNMcvIWQzQmuI
 JjNlfOSl/MSttAEy/N5RZtCG7wxaht5f3Wz+4Mf5dyvSyDeBrE6RhOdAC2oFqaZEWuIeALCck1L
 lJvJIwJD9QiHvzG71do+OKvoAzqWyT5sq5TGWCTENtvhrtJhUzgdQ8Tmr6+tN2fhrm1AsTMl/Pi
 OGR2l7VTQZo3K7gymu5VzBGT+oyxN7GKQX95xE4cUfTtrSqNc12ODxsYWpsjsEphGyHIPorQF/A
 Sm+8RQ+23zDrGYETsMmd7isJxHGoilpKoYr+mTvr6xTjS38MaTpyIABGQZjUek+GkMbJi66FiAX
 nHpDhY57UU3zo53r0jmZQGu0h78nydQLdemA=
X-Received: by 2002:a05:6402:a6d1:10b0:6ac:62aa:e3dc with SMTP id
 4fb4d7f45d1cf-6b49cc01b3bmr620974a12.26.1793177041162; Wed, 28 Oct 2026
 01:44:01 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 01:43:58 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 01:43:53 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261028030714.1608977-1-alan.tseng.cs@gmail.com>
References: <20261028030714.1608977-1-alan.tseng.cs@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 Oct 2026 01:43:58 -0700
X-Gm-Features: AclHuK-44odUmgOSCpLUp2NOhNPChfkQZ_X_KpG77ZeyxAAhyUPDVIPANB7dArs
Message-ID: <CAFLszTgfq0uw2pPqW4Q9N_DFnMnUYONngFqO=0phfLaM7_z5Rw@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] virtio: Add a virtio RTC driver
To: alan.tseng.cs@gmail.com
Cc: u-boot@lists.u-boot-project.org, bmeng.cn@gmail.com, trini@konsulko.com, 
 visitorckw@gmail.com, sjg@chromium.org, xypron.glpk@gmx.de
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Hung-Chun,

On 2026-10-28T03:07:09, Hung-Chun Tseng <alan.tseng.cs@gmail.com> wrote:

> one, so that "date" and anything else using dm_rtc_get() work on any
> virtio-capable QEMU target.

Just to check, is this right in practice? The 'date' command uses RTC
sequence 0. The ARM and RISC-V 'virt' machines always provide a PL031
or Goldfish RTC, and those boards imply DM_RTC with RTC_PL031 or
RTC_GOLDFISH. So with the default configs the virtio RTC is the second
RTC and 'date' never reads it, which I suspect is why you disabled
RTC_GOLDFISH when testing. On qemu-x86, DM_RTC is not enabled in
U-Boot proper, so the driver is not built at all.

It might be worth a follow-up adding a sentence to the virtio
documentation on how to reach the virtio RTC when a platform RTC is
present, e.g. with 'rtc dev', or with an alias if that suits your use
case.

Regards,
Simon
