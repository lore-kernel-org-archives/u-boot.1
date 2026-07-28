Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4852FC53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 11:33:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A89BA409AA;
	Tue, 28 Jul 2026 11:33:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rw5wNFBsEyht; Tue, 28 Jul 2026 11:32:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A79044098B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785238378;
	bh=D6upgCPVwI9WQXMZCjjjCV+RTX6WtwMExnRrOB1uOvI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qilz3qXFxD8vD8N47PKu+0g7yzDs56eRSEsucOhcgN0fqTOSzqM0PRPer4Mgspw8f
	 CPazGPe58fxUIFEQp4sWzcpWv1mVNoHfFcNmSmR5JlP38I6pdSzF3SRol8pLbA10xc
	 UuyrHzGrQOheWmRZmAjmgxfm4yvSp48gQ2aE4g+H+ss6c6XACQ67jyHSE37R4/NP8y
	 xLml6QsrMW5Z7gHmt6n+itMv867BTe3kNslUlYwkqjxS0GWQFYnwZEwEcTLVQuxvMK
	 xSY82tjHn4rZPeblB10gfn+8j0Os5mlR16VSsFCN03nQNrP42thuIaOOnnI3d9PtUi
	 1fBYpe7uuU0Yg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A79044098B;
	Tue, 28 Jul 2026 11:32:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AED702E5
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:32:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 94DB0607D0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:32:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MszQrfozp8c3 for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:32:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6E6E46077A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6E6E46077A
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6E6E46077A
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:32:55 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id D745F8494B; Tue, 28 Jul 2026 13:32:53 +0200 (CEST)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A08C82991
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 13:32:51 +0200 (CEST)
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c99eaa1f020so3280955a12.2
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 04:32:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785238370; cv=none;
 d=google.com; s=arc-20260327;
 b=HGQLW/Ur0rVS8guoEMj9X4MeusAb2LjHt5zfb0m3kXr3aaucEAqr645GSAAHg57byP
 /kZ0aZCWI9atPvl3JgpbqIALA73gGI8/UNKvyhARUHFGVbnIiTgXV4WefupwZDxRXVgD
 Wt/yZPACyFlDXUsuJvOi0fq0yNkxPbIsFNJCcmvgiGOhWg9SNKQF6mNc3gqsAo1XJmS8
 9k42HzbHBYPbR0XcHnm7UVrED8+KIUD9i5IWfiLq9iVNHe4npUIk55Pb9jhNgnUXYGmn
 eaEZXoWuszBXjc0n44emBD1KCK2aHNCCLTf/QbQ+SGbvO6ARyCFNW9QEkxnAIkGYBqre
 kgcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=D6upgCPVwI9WQXMZCjjjCV+RTX6WtwMExnRrOB1uOvI=;
 fh=OviDFb34N0L9bg6OWj5VLvQEdydUGxInOGg/S5H8OMY=;
 b=DrxxXahvRtKr5n0qCif3upOPICGt/Qn9Ae9lt/sejGofDJqqxjGglWuNzwRLkFARjs
 ccQqGMySMjRCngT7h4td2gvbqwH5ml0OWwJ8tkFxX++WF2IyGhJFG/7alYWtT4uQpKTU
 vLTCUwBlmcUym3+zyVhR9iiBC0Xdj6K7oUHMW+bLL8EP2RbOYc26R/tSmp4qK/uubUeC
 XxpLFGVRLVle/knqcWc7Sn2RgK+UZqEfItXQwXosk0wPy6s2c5NyMuC5w60IXlY8tuqZ
 ptCwUE2E20sljR5FQyA5LCW1Vc1UmA15uQs6qnyCydceVGvklohajkptQt42qvHlK6oX
 E8vQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785238370; x=1785843170;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=D6upgCPVwI9WQXMZCjjjCV+RTX6WtwMExnRrOB1uOvI=;
 b=Iyb6fDKMukknnUXF8PLxkdk1wUGmvK6ZvB7Hoo8NO7KGKMYerEBc7213I8RlTqER1g
 8dI2GkYoxoI9nxA0KKM9KV7RW0yyrlo3iCV2k9X9sRRtaLwLP/uDUi2SUNBXjoJCEqaG
 p79hC4rlNJtveoSo5oSAwkslg6dVvq67LKRVQMxIF6XYGWHzq3jbenRQEBpsfbWAyjnY
 X+ROHLjzLRa4GaVgB5L9TVHwRJnnwcKONSqMPFj5RKAPmh0lcq5uerX9weSAOW2aUpSm
 2Z7v25mjpvWitqqu0sUitbyBfqX/LEWwv6FCuG5f1jM8rLhHTKhhOjdYQnAF/pX1vKHU
 7pUA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrQTp3pnBAOhKh6Jqf6XqgNTSASBAWE8ELNFL8AIHmrX/Q6J1JdsfhciKbybfGcw2Wo1rlevmo=@lists.denx.de
X-Gm-Message-State: AOJu0Yz6mCOTq8VZUseC1JMWlVW9Cmj3UDhEJ5fIOwIxAiwKxO+LWwl7
 sevL1gtZeYLHk8ZY0iUfghubQHUGPMmbKIjTvDPeJ35Y/vAWqyLgUzSE19zqDCMJ4B+lqSRK8c5
 GtW0/t4qeUFbnyaK6CRpWYcKE4Ktw/pqkhSTDGeis
X-Gm-Gg: AR+sD13LPiAZE7/MswisKuKvea5jc6ydoKo019v218WuH4Bt6llqeHGEdol02A1YsFX
 q73iB0jbVbAKv2S6yHf6TELa+YDSjfHx+NQN8eOQo3ITB1i7ja7Zo0Ozc6gEIwtWnTpQ2qOzmdI
 /AZUzQVz8rNV10RpKAyLHNzbfPJniEIot3RqlMs4FIC5Q8NlGp0IkTPWcArJPpaEh9tpUWFciah
 Mi9VFvBh1dku9HLfGTOvi8oHZY2ROW7AjtlBo41mAFOaNgnF32nY/3iuEGJ
X-Received: by 2002:a17:902:d483:b0:2ca:2073:3119 with SMTP id
 d9443c01a7336-2d015f31cbcmr22965125ad.32.1785238369848; Tue, 28 Jul 2026
 04:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260713-downgrade-v1-1-183a2300741b@nxp.com>
In-Reply-To: <20260713-downgrade-v1-1-183a2300741b@nxp.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 05:32:29 -0600
X-Gm-Features: AUfX_mzJj9_v8_OvVHAZwchne1ZbbHovavNrgxt94dKrOTwRnOplX-lHNFdYGjs
Message-ID: <CAFLszTiQ-P_BV+9_-f-_pc8fa+k4C5KQS87agVLHoZ7sF9E-Eg@mail.gmail.com>
Subject: Re: [PATCH] boot: image-fdt: downgrade -EINVAL reservation failure to
 debug
To: qijian.guo@nxp.com
Cc: Simon Glass <sjg@chromium.org>, Randolph Sapp <rs@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 "Joseph Guo (OSS)" <qijian.guo@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785238370; x=1785843170; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D6upgCPVwI9WQXMZCjjjCV+RTX6WtwMExnRrOB1uOvI=;
 b=TGKuGK3cvUQYsksZTUN+FyNflu1FXKEyN18xcdYEFoEjS1j6rrnPi2GIwFAqYTk0yF
 rV9FHEBJqDfEJ1/ChMcZJRDnA8tUDau3MmXI1Xyk8t09BvnhobqgSnN0d8Nc+OuPs0eT
 X1J8+PjUW36aubhY+A8cmHajMUtK6bli2HFOk=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=TGKuGK3c
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sjg@chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="TGKuGK3c";
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Joseph,

On 2026-07-13T08:45:48, Joseph Guo <qijian.guo@nxp.com> wrote:
> boot: image-fdt: downgrade -EINVAL reservation failure to debug
>
> When boot_fdt_handle_region() attempts to reserve a DTS reserved-memory
> region via lmb_alloc_mem(), it may receive -EINVAL if the region's
> physical address falls outside the LMB-managed memory range (i.e.
> below PHYS_SDRAM on platforms where U-Boot does not manage the lower
> DRAM window).
>
> A typical example is platforms like i.MX95 where PHYS_SDRAM starts at
> 0x90000000, but remoteproc/rpmsg carveouts (vdev vrings, vdev buffer,
> resource table) are placed at 0x88xxxxxx by hardware convention. Those
> addresses are unreachable by U-Boot's allocator anyway, so failing to
> mark them reserved has no practical consequence -- U-Boot will never
> accidentally place the initrd or FDT blob there.
>
> Printing ERROR for a condition that is harmless and expected on many
> platforms is misleading. Downgrade the -EINVAL case to debug() to
> suppress the spurious output while preserving full visibility under
> DEBUG/log builds.
>
> [...]
>
> boot/image-fdt.c | 3 +++
>  1 file changed, 3 insertions(+)

> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> @@ -95,6 +95,9 @@ static void boot_fdt_handle_region(u64 addr, u64 size, u32 flags, bool free)
> +     } else if (ret == -EINVAL) {
> +             debug("   skipping fdt memory region outside LMB range (addr=%llx size=%llx flags=%x)\n",
> +                   (unsigned long long)addr, (unsigned long long)size, flags);

Just to note, -EINVAL from _lmb_alloc_addr() is also returned when the
region only partially overlaps available memory, e.g. a reserved-memory
node that straddles the start of PHYS_SDRAM or spans a hole between
banks. Part of such a region is reachable by U-Boot's allocator, so
silently skipping it means the initrd or FDT could still be placed
there - exactly what the commit message says cannot happen.

I see this patch is being dropped in favour of Jonas's version, but the
same applies there: perhaps only downgrade the message when the region
has no overlap at all with LMB memory, or clamp the reservation to the
overlapping portion.

Regards,
Simon
