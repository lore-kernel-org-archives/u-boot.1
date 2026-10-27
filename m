Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661A8606A31B
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 09:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eJI4mkhN;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=LeWji2bM
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6CC1E40703;
	Tue, 27 Oct 2026 09:06:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XPhOtpa7Z-vM; Tue, 27 Oct 2026 09:06:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2A0B2406FD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793091980;
	b=qFWu43vPOKggBPY7DALN1dK4Hos0VWuxnLe3r6qbCDWFAqif+yeavABB7gax3SI6L/Xp
	 yRBYdkhIelKjTZ6LzMgqjZmgnd+AbQ1sXrCflpZCfES35XRVZQDx9QNfpxyhtSBMi1oaH
	 hHmWGWm7Udg4RLr0s3l79CSoNursnobc4SIj3cCIrsfLnZLU/ratEeCmzsfr9kWiC4Bd1
	 61JCRntPRSCVH+pmOTJ1IsKUM/ckZxs2lEfRPBzFEKTKU3TRM/PAcf3d5Yqy9kKxPMid0
	 eXyYB65/RywWv6LTCJZvov/T+AqOYou3smRtIXoXdYvZW7TyUIGmo+g7J+fK5AhBZfw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793091980;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=rQRf52NOgGzhKI60PDjQDZZggK/UMjld+CEmIqeEGEQ=;
	b=pzosXfBpV2dTBUu9lbYcSbluEyvTRr/wo1t4L6/KQwn5sjrVGGprpwkwPnQFjYQ1JvqX
	 0fzA4ifYeHW9zEBmGnGDa6HuBDF+lLNSbvsFzUa1VQxtjER9ej6gZFT1Db3ozvZo6PSPK
	 cfGhWifd1rQpwlLfP1av0L7QzOPDWA6PPecqgBAM1W+zkxYChkm2BtyxKjn+Ojs47ZkqW
	 882RLDMerkOBTF+YszQCMEoAPCCRMBd9sm4f8EaZXFHL8rMqDKiSIbBxZw8SmPN2dgrTL
	 S1Ut2FytAaTLBob7gZnnNtWXdj8EprjK7tAMQ/f6uIVncAjzgQAWHEEll3WDOW9D68A==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793091980;
	bh=rQRf52NOgGzhKI60PDjQDZZggK/UMjld+CEmIqeEGEQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eJI4mkhNFfas/HjimhfS8Y3FTJjhvBJFG/lbBiXGLe4WhLxROJUdOg5eiuUnyKdrz
	 tKpZbLt2jl+i6PZYVV++rJ10gMElDK3ax57/VTU5LlawYztOwtfNRNt/bFRQlH1AD6
	 K2vlEsen5r8nYRGKOZPZPRzUxoeYiKhHuehRKQeqsNNvCPKFjX7HbtxM3qXnnI0QWU
	 opHtmqQU4F2OkkspetuPaBYdSdvPWBdi8tkyJUDtArb2nQzor1l0qTZLG3oRG0cECz
	 ZcAQusUwDNzu+NAk52u+NsIQAnKuutE/A0H0k/TDalhGZYjcGO33ZbgX0qGIGR1jsG
	 vK0rJr1RwQOIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A0B2406FD;
	Tue, 27 Oct 2026 09:06:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0C6791DE
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 09:06:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E648F605EB
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 09:06:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yWMNxVSpIoIm for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 09:06:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9E84E605E6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793091978;
 b=V5t2iWqGMF1hMHjqpi7pJKkUYvRYDkWGwDCM70IB6dbaJyz8sqyZZlWRajYMz4r/lgV/
 SzbWEuUKdHVq8nBvweLX/csw20VcM0qNQMoqzShj0kCBExJWiezhAKfuWICSRymOy1nqf
 4RSytygRP6LpKLIi0jUWLI+6itVxkCJldQaZlCGwJ0zExKSTFmXELuwI1VhxLm8MqEA2C
 lM8ABvVBajCwZcFkIFMybD2gU8yZ7r+O80lzdbkv6nv+Dwr2zPRxaNx4Pk+LjOUdlYW3c
 ZYywDeWN7s5t4Pb99tS7prvBrqwbOMtPR6rmnN7HAZyEiWxBNZjtpe9qsvKPImnJ1zw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793091978;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=rQRf52NOgGzhKI60PDjQDZZggK/UMjld+CEmIqeEGEQ=;
 b=Sz19Fp/b5rGtq6q+sr1cnEPOFIiefg1Ry30TKFvBonkMr0wLehsUWWJSsdk7OrPUZJ+o
 yno/jss4mRo929luNp6I8fmQIwsjza8dYvo3Q6NjpkoiHg2BE/0eJiuJZIQdiOX/TByH5
 /QPgRL3EwASUgmBeui6vNBM5EgBYC50Ufh24fttoLBUCo8m7/nJxVWuNDoE1yUd1LppJk
 Kp5C29udGdFf96kSbEQhVqc6FvGhjTJ2x7KUxKJ8cCmRjtUGGSIFgoJm0yB/+Co+i04v1
 Atq+LuzxYLRYxEolyEvIQ1o9u5gqs2EH6CpYrUDW97jwoip0YAInauCxZdLL65vnNkw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=LeWji2bM; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=LeWji2bM
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9E84E605E6
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 09:06:15 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6b1d8944cb0so6231701a12.3
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 02:06:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793091973; cv=none;
 d=google.com; s=arc-20260327;
 b=T6Gh/h5ZmWNdWM5q4O4vPAADRa91/v2nhbHSBA4z2qW0F+2L/EipkzKHKHfJeAsypd
 2FepfUe60MkIQLKkZlGccixKJXmqjGP10Y4Q5heUBmx7+P09x5H6HJPAZcwXpaXaKTwk
 NZEeraqVpqZADYB1Hwfyu5Rn1nbObYUOHS4TIPaFGmGPgt9pYbY7wwitq/QpWo6WlVnR
 d4Qa/xAkrBgAiBy0b+NV9Wj3Eb3djyszKFDvi4UIyP/PJ/REQQdOGw9TpArnrB+RuiLk
 8I+LqYvLQ4QUXp1LnV9kIBkaJ8SIHDMRiBqyrQh/0mSVqxFpNXQs5g9wK5/eVjxN4I/8
 EHXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rQRf52NOgGzhKI60PDjQDZZggK/UMjld+CEmIqeEGEQ=;
 fh=ls4SFlRKNwV7wgpdQmcbq/w0K6quP8xF4he2T5GRmYk=;
 b=e5Gu6sigZcIcmfiBP4n4NLeYeYUdaKqcs4oB2dmz4XcpsH8cp/l5LaUObBhBx73hQw
 v/Eteg8JgwVVPK+QQuqAtzFLyjzEUjMqo9xCaNCaZQqjvLLuIIuVMH3v3M3oRkU93e52
 +kE2hoP6ivQPH3dfFKrIhEZLNT94A3+kC0VoqvSg/4ND9PA39mN1HEJ8F5b2YmfrFc9H
 8KgFLJBDfxi6pBE1QrE+DvvHL3iC64PQwAjW1zUHc8p2rUTpMUcD4pttfobhlfLj5UVs
 30/NJl0M5q1bv/9d+NNHOoWlQH6GEdcXStJjFsrs0vrTXNpFJCJ223EiOWEqgxIn+Gfi
 +oow==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793091973; x=1793696773;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rQRf52NOgGzhKI60PDjQDZZggK/UMjld+CEmIqeEGEQ=;
 b=LeWji2bM65zzYgqyDeXtExStzAPAuVvFFWG3glRVom0ZVzE+Hayqp+J5ShCR2sXzO7
 Yi9CO6ku2Bl/Lj3Rq5t6+l3WY/29Y/H7nifarmrdGtu44INrdGKGQdJllRs8ojjFQ0OM
 uBLYf23NyoATbyuRaFV6I8p0SLKV9GOAL1rIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793091973; x=1793696773;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rQRf52NOgGzhKI60PDjQDZZggK/UMjld+CEmIqeEGEQ=;
 b=zEk65UXJCAyTiX+xZo/DXOPPu4BmXmWxxSWndbuhgLwUxjg/8lDVuWfjCWpzht2YWO
 TE1jorpAYPwQvY5opMB3eGsndqi1otNLiAExHSgQQV3RD0dkGN1kF/IF0wxrE1YZ3rFi
 UCTJV9yvk97jJRsn1J5HGsWXbG2YP+0ojtx+Vkw6ECwozOWCef+VSO00mqQqqYJZ71Ba
 e74Dx9qMMwYyxeY7r4cgT3pFpEkCiVHx+NnYY8ZXmaiiJq46yn95rgBaZySK8KITTbA4
 Er19s/MsGyCTuZm2/Tb6kFRW8yX2kCqpLGtqw5/4ecJT+hr8lA94T1fuPiNQUe3PTvoG
 5x5Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBye8blbTc0AUtQ/+bK6YAccLzdedQk1rfu/St5jcJl0VESkzW6QMZ/ScZ1qCQfP1+MeW78r0Zo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLK3z5WY99uzaelJhcrbwQcHT0pnPfe3qaoizqQ6dohQlOKFJTR
 I6iDQrykYNr+LoeV9tqbjE9DlL1xl78Yh6BtG4lxsF2Mzuv9+FvRIcSrTaTJVF0Fd4Uapp/0VoO
 hGc23XEmXATwGtct2K/NQKLcfdDxYaVWBUzf9/MSmSWXbtXEMokkQXA==
X-Gm-Gg: AYBFou2RS8sdB7h9QujQDhbmnd621lBoZCRnUebm5QtZGOb34pIaIJ44JD6+rCyDSXW
 IhzOQHWF5bC/aP54fACv0tTadgEA+uNgU+aYvdisdc6RVzCpfOs71xHTY9J143a9XpuPrFCfMYi
 2k4ZQiKSx1NZfzES4ACq+GQaXATpIFkuyEdKLT0V2RuvavBO74Hkl/NUF42eejT23eOLI4LlbYu
 jMeeZ9CRQSTMiqilQHLRyYa4ixLc8VhDoZG7RTGh2TQUjLic4LYceeyaZymy1R8+ovT69uOE6Jo
 U4qEbg5m+O4gJBRdE2KCnkOZ0wIXLAUkFtBQgnquArcFYZyDQB4zpQBFdMY42t7uRMUti+UVxmZ
 0ryiy6ZJvxa2BdXdA3F/Q2QdlUsAH0tgPSXs=
X-Received: by 2002:a05:6402:428c:b0:6b1:ef5a:6720 with SMTP id
 4fb4d7f45d1cf-6b442fcfc70mr9816705a12.16.1793091973042; Tue, 27 Oct 2026
 02:06:13 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260804105721.2402406-1-jonas@kwiboo.se>
 <CAFLszTjBiTtKmjgknvXGFBrphh6kpBzRg8iroWjFQ0EDvuXTyQ@mail.gmail.com>
 <c00fd65c-338a-428f-bf4e-eb28e463d914@kwiboo.se>
 <CAFLszTjKMRjF7hmEt6_bbnsRpi9Q=NHidRQC8zv4ToUEpqBarA@mail.gmail.com>
 <582f30f6-7d5f-4dd5-a8c6-60d027806786@0leil.net>
In-Reply-To: <582f30f6-7d5f-4dd5-a8c6-60d027806786@0leil.net>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 27 Oct 2026 09:06:00 +0000
X-Gm-Features: AclHuK9cwtCj4TvnsO9H6nkYTgd1orPrdsM3i5RHAnDGtWkIm3kWw0W7235if4Y
Message-ID: <CAFLszTj=yHHYYojiX7TGAiFZun7qWsu7zO6awfLdWwYF8HkQmg@mail.gmail.com>
Subject: Re: [PATCH 0/9] rockchip: Remove unneeded syscon driver for RK35xx
To: Quentin Schulz <u-boot@0leil.net>
Cc: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org
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
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Quentin,

On Thu, 8 Oct 2026 at 23:53, Quentin Schulz <u-boot@0leil.net> wrote:
>
> Hi Simon,
>
> On 8/7/26 9:46 PM, Simon Glass wrote:
> > Hi Jonas,
> >
> > On Tue, 4 Aug 2026 at 13:57, Jonas Karlman <jonas@kwiboo.se> wrote:
> >>
> >> Hi Simon,
> >>
> >> On 8/4/2026 9:19 PM, Simon Glass wrote:
> >>> Hi Jonas,
> >>>
> >>> On Tue, 4 Aug 2026 at 04:57, Jonas Karlman <jonas@kwiboo.se> wrote:
> >>>>
> >>>> This series takes the initial steps required to try and remove use of
> >>>> syscon_get_first_range() or syscon_get_regmap_by_driver_data() to get
> >>>> GRF base addresses at runtime for the Rockchip platform.
> >>>>
> >>>> The GRF base addresses are fixed and known at compile time, yet drivers
> >>>> keep trying to resolve them at runtime delaying some operations by
> >>>> several ms.
> >>>
> >>> I suppose all addresses are known at compile-time, if you have a
> >>> single device tree. I have always hoped that we might end up with a
> >>> generic U-Boot for rockchip.
> >>
> >> I do not understand how removing these unneeded syscon drivers and
> >> helpers would stop such goals or make that any harder. From my point of
> >> view, they are currently making such things harder and only adds extra
> >> code, runtime and energy waste. E.g. around 227 ms was wasted resolving
> >> fixed known base addresses for RK3399 last time I measured it, see [1].
> >>
> >> Most drivers or any SoC specific code is already identified using a
> >> compatible that is SoC specific, i.e. the RAM or CLK drivers are matched
> >> using a SoC specific compatible and seeing how all GRF variants are
> >> unique there will always need to be SoC specific code to handle the GRFs
> >> base address and reg offsets.
> >>
> >> And for drivers that are more dynamic in nature the DT typically have a
> >> phandle to the GRF syscon node anyway, so getting it from the phandle
> >> will be a better option and closer matches how Linux handles similar
> >> references.
> >>
> >> The biggest current blocker for a more generic U-Boot proper on Rockchip
> >> platform is rockchip_get_cru() and how it currently makes it impossible
> >> to support multiple SoCs in one build due to how it is used in the
> >> sysreset driver. Fortunately, I have a pending series that also cleans
> >> up the unneeded rockchip_get_cru/clk() related helpers.
> >>
> >>>
> >>> I wonder if there is another way to do this, perhaps reading the
> >>> address once and caching it?
> >>
> >> I really do not see the need for that; it would only make things more
> >> complex than it really needs to be. We should use constants where
> >> appropriate, e.g. soc specific drivers/code and use generic phandle
> >> lookups elsewhere.
> >>
> >> At least that is my end goal with this and pending follow-up series.
> >
> > Long delay while I took some time to look at this area in detail.
> >
> > Pre-relocation is an area which I sort-of glossed over with the driver
> > model implementation. There was talk about keeping the pre-relocation
> > devices around rather than recreating them. We also looked at
> > providing post-relocation devices access to the pre-relocation info.
> > Over the years we have had discussions about having 'simple' versions
> > of drivers (that don't go through driver model and perhaps don't use
> > device tree) but no one has made the effort to implement this.
> >
> > Anyway, after a few days of hacking I've come up with some
> > improvements to the existing code, at the cost of about 500 bytes of
> > size increase. It works by using slightly better algorithms for four
> > key functions - fdt_parent_offset(), __of_translate_address(),
> > ofnode_pre_reloc() and lists_bind_fdt(). The result is saving on
> > firefly-rk3399 of 230ms, about what you are getting. Note that I have
> > made no attempt to enable the relevant options in TPL/SPL (it only
> > saves another 13ms), so your work is mostly complimentary.
> >
> > The key difference is that this should help all boards, not just
> > Rockchip, plus it still uses DT for everything. Tom doesn't want me to
> > send patches at present but I did write up a post about it as a way of
> > providing the comparison. [2]
> >
>
> Please refrain from pointing contributors to patches that are
> written/assisted by AI/LLMs as those aren't currently welcome in the
> project.

Do you have any update on the VBE series I sent? [3] It was written
before the AI era. I believe it was originally sent 18 months ago. It
is the final thing to get VBE running on a real board in mainline.

Regards,
Simon

[3] https://patchwork.ozlabs.org/project/uboot/list/?series=506457&state=*
