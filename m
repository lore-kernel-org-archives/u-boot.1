Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D72C982D7
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 20:44:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A911C8130C;
	Fri, 18 Sep 2026 20:44:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T97qoQTJ1Kz7; Fri, 18 Sep 2026 20:44:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E21C4812F2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789764293;
	b=hBnzGrWCQPm0dKRN+UKO2kiCfPtLGrZp73+G7yFz7Hv3N8pB8M0fHlU1dLHJ2eWIs41J
	 uKp5biZZ1tMTgs6frgFyZzT11uYOvJu/1P1lPKS9uQDXJMtX3A1Q+EwZDhRo9/x8y/WWb
	 0zxvkFzRG7N6G3nYyuYROBOUVRbg5t9akXElGjt8rX6YtaKcOw3uVqqKdzDfeg2UGcAY8
	 3cUlciIsq9bzfyO3UCReTAt58HTEzkbuPAfbV9Xr16rt7AvvgqUHfpidTaKwm1MZ5YIsk
	 ZnOkCTTlEb9G6F30dexXtO14bu5BsJTR1DRLMaXVEof3CnqH9Gd+bdM0dTOprGs2mxg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789764293;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0cGe3pf+McfuGPZed6mkb3UfA4e/PhbmXas+w6UjlWc=;
	b=tczBrj1CF9tgd77dGKyFvx48x6f/G7YZL/I1Vxu3gxcCXDuO5jQ0nzZIDKYDr+XXiR9B
	 nK+ekgR+ip08aswFT2Ed5eShkMTZLW1PgdS0apnCZLVoVnbSV/75w1kESV5XRZ7yWsGL+
	 uLgUEzJJJQgsBNxdNkrsIZz6nbWHCaQfupWsRCebR/+Mg4qrrkutG/6Z6/qzim1BzD33T
	 juousJLrIaQjHt75ItjEdVXXhw2burbsUaAzcy/0eL1DFlfMjiLkTtm5e8vLgeBp03hxu
	 IDGWRKe+CyB4uI29twOWB+wMWQG/+LuHSq6FTloinsDfwCIyKJYN6eXQ1+JaEE8fGKQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789764293;
	bh=0cGe3pf+McfuGPZed6mkb3UfA4e/PhbmXas+w6UjlWc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g1zH70qUBXnah8vzJRX+BBYMU+UDLOW/q9a58ADiajyoZZvWkSffglCr0wQfj4M1t
	 IDJs5Q5q5QFdNPULozNKoqHZBFinp8mWsXGPWN75gakRWVY182kPvmRIcmkqWz2M4S
	 UWYU+gvvWO1IVqqWrOUxstz8znloiQujUjJgGY1aPW2Sz5sygne4asMgJbfEgEwugK
	 gJA1m5V3TVv9ZlCarz7ZURGgtnYXFOy+QpwRaKFDnPlGLgkKiXSRNneq2dvsjADMH3
	 iFlm9n1TLiNkqCCExrWUXOQIJdh5wtrKO4aQM5VBbcRasTmmssriFDmGjSwpY/aFuO
	 J0BWwGzpczqpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E21C4812F2;
	Fri, 18 Sep 2026 20:44:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B2C953B9
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:44:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A4E1760D6A
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:44:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7mH1ywqznpkl for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 20:44:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 86AA760C31
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789764290;
 b=PF7h+biB+9vf/y1Buf/ajlam3Mopr/z2cMWPO4jrSyhhwBgbdv6GLctszL51uL5l1uDm
 CJJyRnOXU12K7bps35HvmO77qWjqIJEIAgBX31KGLdBIS81ctq79T4+atMwguG4QR/rAF
 96o3lN0hCooQ9mIlGe4+xQzRro3Q5tarHhlP6gbXoD/EP1kyrmIpyV+FCtswq5bGbKatn
 eaH044c8k+3igEaFW+kuNNBQ+kT7S1xiTZl2BWPqDXS8T/6DOM31A6QwASFwWP1sAvfhG
 DUwo5mQpFIOFwfn/q23rKVcYNUIIY+FRFERLwpgBcJQ+qsIwaz/JdhRKZCI5eqpDKgw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789764290;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=0cGe3pf+McfuGPZed6mkb3UfA4e/PhbmXas+w6UjlWc=;
 b=KjNbcwqTf/hmXCcE+LqGCVVN521LsQjgffecC1vzuDowJ9/oIZrx3S0UtcngSVqXgt5N
 YKhWNCMFk8KPV6ONAbHEzcFMbMuXa2ZHGUfAd8rn7Ahad4Cib77R5F11HaN36kEhLIeY1
 D1c9kOgJsBTzeJfkVn9VLi5myZDtB+LoWSqBwPrhwRB+C79DNno3RphgufXL7WW4b3G5T
 KoHi9bmDAA8u+izk99dgjbOIU3iyDBwikvQL5IL4M4J3VCAfYklL2piKnvw29/7AaWrds
 1EKGpm5zcdQPavLBuCBBz1G3Ozw2SrYhUkbXWd6jtH+POUyWUeyAef++nJYmYSnwwiQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=YhUJBHpb; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=YhUJBHpb
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com
 [IPv6:2a00:1450:4864:33::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 86AA760C31
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:44:50 +0000 (UTC)
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a6056c2064so1495378a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 13:44:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789764288; cv=none;
 d=google.com; s=arc-20260327;
 b=cZbYCOWO8b6Mtqv1/JJZuog4l9/ZZgbisr4KgKeCX/AWtCzrUjgSeK8aObOOjDrdBy
 gkeltH4Vl91uYiP8P+GAeZ35UR7z7IRbZotNRmZIsfxnuIWCb/1KgeJAE3il+4utvnLH
 cxp0w8O3YbRVs8Kfe5grQxwDRlkcTFNYUYZMLz3VV+d+aXink2qDkXPEkEjGDd5qzk0K
 4IBMet6ZJFonkHc7guesq9goAjZrYFikyXAaN0AbV7e/MSdSEuafMKIZcbe3bVoQKDGE
 Xylvto/oDGsgqYTQTvRCQ/KeiM8gGgNOl9f/qajbb4hlodkDNXlg4wOuHDV0d+XkiPE+
 Rv9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0cGe3pf+McfuGPZed6mkb3UfA4e/PhbmXas+w6UjlWc=;
 fh=PijMMigzg6lqgX8gnr59GS8viHousaoER8Lg/oDDlYk=;
 b=g/i2oiX7d8a9dqO0Do9YWllDSOW4vkhngXgK4AVVMxXRPirMzs/ZrsU9bU96iE3vQ4
 B5wvCTPkFGBbYXsBRFzzx8ZOPo8dhozU4eSyO5BO6E/fS/NtHm0gFzwYg7YpakpMXWwR
 HecVYaECwSaYuWY14CeljcUseH6vQRfdWijVLjH8HVwxeLwMkfVj+zy/dYeZUUBc+S79
 re/dTEJ4xpyEBpKsimLWc+84GnUge67utNspV98Ks61Hgrf9cXAgsHKF4LZX47VaDNj3
 RlXwvngapXLElLfBkhJP5aU6Q+XBOgFcjuaXH8L/03nfuRxpVq4eOXja2cxUhopg2KKD
 Q3qg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1789764288; x=1790369088;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0cGe3pf+McfuGPZed6mkb3UfA4e/PhbmXas+w6UjlWc=;
 b=YhUJBHpbTRlvA5UcjpaEh37Z53z9SVToh5fXH4+vpJpDyflraIhu3IszuuXfqwA+aQ
 nIxFsFJdTm4KUGggJsz2dmVK2KayhdplzWP2611RHMlE+tbBCqxlpIj1ug3JKAYgn+M6
 03xRTLA28dqvbyBymFvwtXjGdnsvGzEqZSpUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789764288; x=1790369088;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0cGe3pf+McfuGPZed6mkb3UfA4e/PhbmXas+w6UjlWc=;
 b=E3ZtmGvQ8xlSlWen2alj/3LKzbrvPwfPAtuujLGGwmUXMe/5M1zpOJLIh/xJe48+yY
 yBRyMoK7AzOcHWShVg7RLqaNyLwOPByNeHLYyXSh/qVBgUIX05Ys/i0TxwNLNyGYxcwS
 36YL7+xvL0Er6ZVKE2CtIneLt15pjy1NXYKV1VZJ5nQC7xLBlMNLbbobk7lLKD9rtAD9
 c/sZr0VgOX2riIyRa2iMMm0HERjo0GzxtH5tN1jl5oeDL2LWuxMcmwOgoHgzdGk2DPKb
 BbH4Z5dsO7G4qwMlMEzoum4qCTrKB4JOEjQKMwFQ6gBYQGGQamtP9ulWnddr1BIQKDMc
 hgZA==
X-Gm-Message-State: AFuF++lamswIh7nJ+myvrJnK3eAVfR4vG+vnwIIzUpqAZ3/KnXDrxJaY
 iYMdM+tjqOwffWfcPM0MmJ+xbVf0jVpptRVgqrdtMvbC2XeFBXhp6Yuh7EzVJh8RWTALF7gOOv7
 Yl7BuEZxR+05uv0XBnQvepP+zuG640481Vbjw3pFfTDmMV5pee0Wt/BhwsNs=
X-Gm-Gg: AYBFou20rjCJcpVx+RWlUceJctSwDxQVqI0OLWFFo/rC2lltD2/h93NF6uKD356P919
 sHoiEM5OH7Dem9GqjWzrA3t/1rjFE501bYD2aaJZbkYK8ry1g4Jg5ETYuA7L/AJ6rDM0QXPYKb5
 CeQ3nGrv5jBRQL23tlFsR3jCZ9j5OXHrCHaoaNU3LEf5/02VksbRjhdtz0QhAA/JVdXg5FO1mWa
 qPHE0djk3QyR26xovHSWdFj1QzHEm7Ld2zpNXESVVr1zp9+XWrKeEQbamk5/BCmu5zw4mEaXK5t
 kyyomO/O2yNZyULNhTps67/3dGIgT+Kr9hEx1egNHU1XbEUoDLQ3m0ZVxkWUiAq6j50=
X-Received: by 2002:a05:6402:274c:b0:6a9:cc6d:ea50 with SMTP id
 4fb4d7f45d1cf-6aa562eda2amr2418289a12.18.1789764288232; Fri, 18 Sep 2026
 13:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260831142800.25966-1-aristo.chen@canonical.com>
 <20260831142800.25966-2-aristo.chen@canonical.com>
In-Reply-To: <20260831142800.25966-2-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Sep 2026 15:44:34 -0500
X-Gm-Features: AcwNN1XoxkrOZcIR0wtqik3bxYUHmxx_Dk6uA1j1kAhoGzYLLJ9ICKzbcvoaBxk
Message-ID: <CAFLszTi7Akoavf3uzrwhnygG0PSO2fdFpo7wCcDSTARsXkqcFA@mail.gmail.com>
Subject: Re: [PATCH 1/2] bootstd: rauc: Reject slot names that do not fit the
 env-var name buffer
To: aristo.chen@canonical.com
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Martin Schwan <m.schwan@phytec.de>,
 Denis Mukhin <dmukhin@ford.com>
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

On 2026-08-31T14:25:38, Aristo Chen <aristo.chen@canonical.com> wrote:
> bootstd: rauc: Reject slot names that do not fit the env-var name buffer
>
> The names of the "BOOT_<slot>_LEFT" environment variables are built with
> sprintf() into fixed 42-byte stack buffers, and the "rauc.slot=<slot>"
> kernel argument into a 64-byte one. The slot names come from the
> BOOT_ORDER environment variable in find_active_slot() and
> distro_rauc_boot(), and from CONFIG_BOOTMETH_RAUC_BOOT_ORDER in
> distro_rauc_read_bootflow() and the reset-all-tries path. Nothing limits
> their length, so a slot name longer than 32 characters writes past the
> end of the buffer, and even a 32-character one overflows it by the NUL
> terminator.
>
> The BOOT_ORDER entries are checked against the configured slots when the
> bootflow is scanned, but the variable is read again when the bootflow is
> booted, so changing it in between (e.g. from the command line) reaches
> the unchecked sprintf() calls.
>
> Build the variable names through a small helper that uses snprintf() and
> rejects slot names which do not fit, size the buffer for a 32-character
> slot name plus NUL, and use snprintf() for the kernel argument as well.
> Its slot name has passed the same check by then, so it always fits.
>
> Fixes: 7e5c2c782fb9 ("bootstd: Add implementation for bootmeth rauc")
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> boot/bootmeth_rauc.c | 42 +++++++++++++++++++++++++++++++++++-------
>  1 file changed, 35 insertions(+), 7 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
