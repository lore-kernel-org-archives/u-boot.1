Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49BFBCA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 13:57:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 138EB40483;
	Mon, 12 Oct 2026 13:57:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aN0ZismgkY5M; Mon, 12 Oct 2026 13:57:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4621B404A8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813472;
	b=PYYeAqXStnvIE/y7BPOO3oyETIX6PmORHD0GSF2nmJYBBz8wlFKFYN7VC4kRXX+bbgI0
	 J9zkN6GneBKKMI6zq8Zt4jk9YTizNRw+/lg5+L+nZovLYkCuCJQBw4Jgvp1c42wYEFaZz
	 RjnKjrFbWB7+xWFVkEFVzJ6nwb5r/wLJSCjAWK9nOs2P54R46fN1f8dxaP/PuHqtQ+LP6
	 xICisiR8gnwwOUxNOGpsVlZWme8b0KhcxPnC7IR8cNkBlTD+NHvSDYkIMKsP0zsjJRBzW
	 4wEYJNkC7I5bKDh4ffKbhiuk4BEdOwI/pIuzf9f84WrJKhCr6BIfx+cNszDwy+edabA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791813472;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=drZSE7jJhOjdWTcuIW/jaKg6ggM77I/20/4SKM4Qw3U=;
	b=rY4b/BGgF5Zn/8ZeErr1Uoll3Br/L4WFryeeyay3qHrqxoonNXcW2y1Ree0aTYBGzxtM
	 v86v7JmtZAb4QPkMcWz3+37PWoUnxNYBPs2sjLKPFfDzHTNrasVL/oqHzL3rxOYdFRbwn
	 lZrisxDWFieOcEbbtW+NsmHYsJ0Hu/g+LTUdDCw2uti7mqJB/Da8CVnueOSsBB6horBAH
	 vYealpQ+behcrPvzRVfrhgYAENedJjqsP2uA46gQSvqGbJBY+1GB/zFq8RGBUcxdg34n6
	 2qOiEpVk6qEIHRlzcxn7KCvSzG20tSwJMKt7drgCdszMTM+mYH5JtZy6x8UQxHmhUpw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791813472;
	bh=drZSE7jJhOjdWTcuIW/jaKg6ggM77I/20/4SKM4Qw3U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eNJeRr+rmxQDk7Yc2KofsJgLwCArsv9engQQay8XhsiRyjH/ATFW0XNOh0nj7Dqxs
	 mHtCFv+wQCscjo+79FWF9IlzepsM2GjCohof747S9v7Zi1k8GQ12beftvyCeVxNWTj
	 jI8wGXMtyXZoDJj9i1cNtMEbDD3E/ZPoFbXEpJb7OfJbAbgS4xCaNBz4g3otRscPgA
	 XD3tYAxK1pyLqrgtzH4tj4G4PVHMnhPDwrwvf45BgavSHXHhGsQIyCoa3t/bfgyl5T
	 ItsljnMloWwSX8gRykM2eO8RpqMnMbyeFIqZFpt0bedfLvhjmShNoZVw4UbyfGAndK
	 P1HjAfH4jBDdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4621B404A8;
	Mon, 12 Oct 2026 13:57:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DDD42179
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:57:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C3E19401D5
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:57:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NKUcesVWc_MR for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 13:57:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CD2714010F
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813470;
 b=C19O0IcRpomBtsUQUNn1lR2e2lQ2evocEO52Ur27nRc1rjsixz/v5EzT0baH/gET5s/V
 9VdHrb10M2XxUyKvHoiTD/2HeV0r3RjoMCkA5LcvVLDr7oEV4XkRRA0a1Gf3o14DSVAOn
 jKi0g8oFdXpEqjnp2eI1J2TdOF/fzVze6KjhwKRNLzC+jZ5BgAm/cTGUkGjIsAPzuOclo
 9/L3cztf4CwZfMIj+fOrzUsOngksifVeW8iAsO+GFu8Ky2AhmZ1k6VqwEC6qlj4XXNOBD
 2mJAZ7st1J3qWCvqUbX+V9sn1fMuYbWuZPk3uNAxIuevCurzEE3Aa5OwoSa/qeppXFg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791813470;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=drZSE7jJhOjdWTcuIW/jaKg6ggM77I/20/4SKM4Qw3U=;
 b=ltHqWBr4m+Va6y4Uj82pC3ojnC/WXKvuoWiPQjGXoAmRHALQijChTBTnWr0uX7pYXf0m
 wRJeRvmvTHgMHbOWhGbZ9/lECYgMh+Btj/HwOf9znXm7WkmW3rPutCCCSdV6M2Nl1CF+g
 S+xY5PbeoOvQd5L+ZskrXVzZU1z2wsN9/T8ZQ+u0IIlgYuj0x6+Vai+325mDdOE9qPVlM
 /Gn8oyID3berA0M0A+njEs0fkYrzOAPzZj3ygSGUh1GVFBrb4nlvnPQhUkOuW9/6JU0nR
 O3H98bfWDxmjCJJhj/GgrwDw4cuTD0pSH6blMk5ythaG6JIwlmEjFvLvji433bhzbYA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=GedjTSmV; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=GedjTSmV
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CD2714010F
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:57:49 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa29e06bso1622743a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 06:57:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791813467; cv=none;
 d=google.com; s=arc-20260327;
 b=faM9DbqJKdwpyfOEzTM2gucv04SviY8Sm/yIk1aW0rfMxmildeb7rd1bqnZsXtvbvK
 wIEWredN8kJg4WSb7wMjhzs+/dv0mXx8u5T1TwDyhX76jURWIl4hWK2VslHYt9OnR1KE
 ZDEedp8bwigsfOOtGvWyIhBJrflH37sAnkuIiDvOuaGRY6zWMJ6U2TvfZirHghwnkIhv
 2I6dIIElexQS/Tpt3g9CWv11tVe0sQntw6Fl7zUhG1x5jxNpmux0cnaXDa9ICS2pfCX/
 34w1FPfGqoBXbPsM3ksIjGbmUcQj8s401+HpT1xbr/UAV27KflyTVSXSQHdpwqov/9TY
 wQ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=drZSE7jJhOjdWTcuIW/jaKg6ggM77I/20/4SKM4Qw3U=;
 fh=8kLy8Cchkv6HU01zDgapzB4SRbyqUfaRhLrjroAK5g4=;
 b=Iz5jlmGg369CyTQuLyPHD0PhtRZXzxuYKjxoNwpSxn7SOiUkD2RRJxApj72ZGIdKst
 ImZEUJGpoM2IX3sKr80kR1nZt6s1izPulmPvgQmIg29eJqLd8CzkM7SYw1139darhDyN
 WFO3lC6vXjzU+4BrDApycmTq3aPEKrrOwPztEedqjaEI+OYnx6Cibl8/ycJ8qDoQnAG8
 zk1iKXFaRugVd01V6rKPa1cZz4WYpDgt8caMU0CuLx342wrJhhOrw74SjiozMaO7qK9J
 hRfk1RazWlgVjhns4zOBL/O/yJCLogGhBHyaGauJVnmDKP69TGQgV+hkJcfoqWA3Ou/W
 AWuw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791813467; x=1792418267;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=drZSE7jJhOjdWTcuIW/jaKg6ggM77I/20/4SKM4Qw3U=;
 b=GedjTSmVfZqrPlEbMw3J1yAN14pe6o0yqSQeg1GatzNc0/Ckx1TiFOlw5an9k2Hmnj
 CZfjhu0y2HDXXR438Y6L+WmhQmnjiHmgjurr2n6fFk/lwr2yuCsVFar0ZBui6EZ1HEKN
 n0RisGkP2o1q1afmqG6rwwSgt9Bptb7t8etZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791813467; x=1792418267;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=drZSE7jJhOjdWTcuIW/jaKg6ggM77I/20/4SKM4Qw3U=;
 b=SRz7BrnNZwZNbpSZfiRCiLbNgsGOB+7Rx+hPSPqzLFLsdVx6/QYoU7Hpp3x9bgNmsX
 GuNIFN6dh6hevr+jhu9q2NTtFyxcySd2X9gG/9DgKeH/+Y3O2DMqjm4KcLg/laUPurYs
 +QYuv39wdsaZGCMn9pRr5msZmYRCXWCqKRBldbx2fxR21gXfGo9fwdOiKatBqi4vMiIk
 wmvzLoDS5bbNyxEW3Tq9aUGfB/kmLINmoyt0UZ9z3CofiBkZGXhJxuNR6M7tg+LsTlq6
 eNys5OGlx06pUA0tAK6O11FBdWyFrWW6ttua9dgHUda2YRevE4EydxamWUg1lOOU9eRA
 5oqA==
X-Gm-Message-State: AFq9FYJvWyCG0M4/H9KnNmvKzu3jlg6BFQR9OB6SzT183GVPKutXCT0K
 t6uC73Zb0UxTAOxdPhHIBvvdK1rqvizrFLnG42SeYZCUeMdy/tw21L980ICbgK8P3ACC63iJrS2
 bK+hAFEw+ayk0b3ae/8O/RUpMNAFf6F7ZXoeHoiTqSoniI7FR/F0WLeU6
X-Gm-Gg: AYBFou1EnHLkrC9ONS9xUu9Zk6a1i0NTmhIIt5xPWSxBIuVDrgC41BtQ4zQRKORMr3U
 PyonTMqvkHQfi628hqV/1FD33EMee01e3a7fmDAmty7sCrYaRVj7BamHAw4c0CwQveZcw/0W6HW
 I7jc6dvAQhrj6kMfo+SOjcxIaOCB9eAkjnzfCThGOIFKfVAj2+OxARx47xWNa7YGBz1oioVn17U
 1q72yC5AixGn0pV41DieLVDTlYVcs5WQZWxR0aiKNz1Em0j8qYwbh2kaI7yWV/cv2fnTHj+TnZ+
 iOexzYabWhJpP98N9AwRd/PvOPvA4EpX0p1GOsGX1vL2wkrsgRmZ4jk=
X-Received: by 2002:a17:907:72ca:b0:c29:462b:f908 with SMTP id
 a640c23a62f3a-c31a9fec198mr1203662666b.10.1791813467526; Mon, 12 Oct 2026
 06:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <20261010-b4-binman-fit-fdt-compression-v1-0-4465558758cc@protonmail.com>
 <20261010-b4-binman-fit-fdt-compression-v1-4-4465558758cc@protonmail.com>
In-Reply-To: <20261010-b4-binman-fit-fdt-compression-v1-4-4465558758cc@protonmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 12 Oct 2026 14:57:25 +0100
X-Gm-Features: AclHuK_i5JFyfo_Vbpz92e9oto_PhVeI81j6Ip5R1Lt51cV2dIMzGM50w3ZLAxA
Message-ID: <CAFLszTitc8Aw2dCZOojegvnEZR483_Tyx9NJHUoPRfOUze2dcg@mail.gmail.com>
Subject: Re: [PATCH 4/4] rockchip: LZMA-compress the FDT image in the FIT
 based on FIT_FDT_COMP
To: petr.hodina@protonmail.com
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Petr Pavlata <petr@acrux.cz>,
 David Heidelberg <david@ixit.cz>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Petr,

On 2026-10-10T14:24:46, Petr Hodina via B4 Relay
<devnull+petr.hodina.protonmail.com@kernel.org> wrote:
> rockchip: LZMA-compress the FDT image in the FIT based on FIT_FDT_COMP
>
> Adds FIT_FDT_COMP alongside the existing FIT_UBOOT_COMP gated on
> CONFIG_SPL_LZMA only. Applies it to the @fdt-SEQ template's compression
> property.

Please start with a paragraph giving the motivation (and imperative
mood while you are there): which board needs this, and how much space
does it save in the FIT? Compressing the FDT also adds decompression
time in SPL, so before/after numbers for size and boot time would
help. Please mention the target board in the cover letter too.

Please also explain why only LZMA is used. I assume it is because
patch 1 only implements 'lzma' in binman. If so, say so, since a
reader will compare this with FIT_UBOOT_COMP just above, which prefers
gzip.

>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
>
> arch/arm/dts/rockchip-u-boot.dtsi | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> @@ -19,6 +19,12 @@
> +#if defined(CONFIG_SPL_LZMA)
> +#define FIT_FDT_COMP         "lzma"
> +#else
> +#define FIT_FDT_COMP         "none"
> +#endif

Just to check: as far as I can tell, no in-tree Rockchip defconfig
enables CONFIG_SPL_LZMA, so this has no effect on any current board.
That is fine, but please mention it in the commit message so people
know it is opt-in.

This also ties FDT compression to CONFIG_SPL_LZMA. Someone who enables
LZMA in SPL for another reason, e.g. a compressed kernel in Falcon
mode, will find their FDT compressed without asking for it. If both
CONFIG_SPL_GZIP and CONFIG_SPL_LZMA are enabled, U-Boot is
gzip-compressed and the FDT is LZMA-compressed. That works, but it may
not be what people expect. I wonder if a separate option would be
clearer, or just a comment here saying that FDT compression follows
CONFIG_SPL_LZMA and why. What do you think?

BTW I checked spl_load_fit_image(): the hash is verified on the
compressed data before decompression, and mkimage hashes what binman
stores, so signed and hashed FITs should be fine. Did you boot-test
this with CONFIG_SPL_FIT_SIGNATURE enabled? It would be worth
mentioning in the commit message.

Regards,
Simon
