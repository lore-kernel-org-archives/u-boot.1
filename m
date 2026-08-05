Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9AD9C55ABF
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 21:50:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E9FE80E05;
	Wed,  5 Aug 2026 21:50:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zeUdmZVbw6vk; Wed,  5 Aug 2026 21:50:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E7D7D80DE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785966658;
	bh=iy6H4vSM+shdsZuW3p6DFUwjFH1LGAY0p3RNqqvz+MU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xVQ5D2UCnxzDIgHQm1lEXNvDKTHMS7FOYnFE/WkJ+UBXSmQFP8dsD6RGWjgdguJh1
	 7nY5Km+Qa7qSB+c8+OQ3tXYBwLt7RzPHjJ5hG7yyxFxHDPvkCFUfXCoHjRE3NvT1pX
	 0pk1Rt7BOdPESPBqBdRe/1EMPEHEywZeB1SLbm9HHu7HK693wZHGyKN7li6JQSqw4z
	 dvjbkRXzVqAERTj2+4kQqWOfH57k0kW60tt7ui988Mr+eCXjZboyZZChxZcvkDUToC
	 Bxbrh0DR0ITTFwwPid1aEQmi2N0/ogAzw/KxQ57g1eUeKf8K9YUUIkDQ5TQQ9rNAnd
	 JUoE7lecNcRGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E7D7D80DE8;
	Wed,  5 Aug 2026 21:50:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2203A2B6
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:50:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 083694024F
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:50:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QVMBnm3T0qjm for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 21:50:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0D47A40249
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0D47A40249
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0D47A40249
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:50:54 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4a18180so2217467a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 14:50:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785966653; cv=none;
 d=google.com; s=arc-20260327;
 b=TcT36nxNr3rehtIrIUgoF9vYlUNrqfeaYe69SfJVloFTYJ73OwmrPDs+dAWhSdDFPV
 ditb8w3wG1I4HEPRq5WAFLaTAC6iFkIDBoOyoS4D4xX6djLxQIMw0frz8FF2stU5dGxb
 tykDjPSJfnF/eOhCtkSu8SW4P5H3+s0f26zDOpBLf17sC//bMk0CmqpuphdmR6AEulqV
 UsU3GiN1Df484L7sA/fPRtuesYh09sOEsRszUS3LhNLaLpIq+gFXyr+PbcKuLW6rmbyu
 H5QFPXOR0U3WHVwk9AIp+kgG2HySpBzE8ixjdgjb6dQsfIqpk9+LVikGnMbOQxBM5Z3h
 P8OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=iy6H4vSM+shdsZuW3p6DFUwjFH1LGAY0p3RNqqvz+MU=;
 fh=TZ92kOw2oMh3nws5P2EBVYMFrgSgvj+F9AAwJ4owneA=;
 b=RZa9X+dHH/tHIGhKLi0MQrq/5HOp37dw2MEfnlMbgWFVdR4l1/WGRj8YQdYSISGTOt
 erNHhcyJ+iHL9pPr+8g2t8Gm6skSViTCj/9IKXEmBzF70WPTeV+jk9zrzxloj4wUO7dr
 r9L/cQ1VYRoT2beE1Y3FtkM0ML6puFa1ocRlfEXrtnqS/MpRJCqg3N2/6ffeoJbAED3M
 +l+900mz5TSO/kyL2ZthYuQbEW0FhqdEw68Eou2NEYKgp6gaGmr9n8S4nIzwEdCGPg4/
 zvwpDjL0VgG1Jt/gar7go1pqufxOMMGw9m7TExedUcjN3QktzMtV6bTPmERLV/A+hOHz
 I3VA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785966653; x=1786571453;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=iy6H4vSM+shdsZuW3p6DFUwjFH1LGAY0p3RNqqvz+MU=;
 b=kIMujjMdgTrmBhJH5h+NWBetuyLVtatoRTYeVVZdlQTF5/AlA9ETMi7jOr6NoW68DA
 DYYXSBLVX+3k3AZ8PyZscFy7MDAShYbkbnELun/R4XZhZhLQqwT5X9VdI1i1C3cxNoxc
 ggA7DQFvj9Xab8ezvh+EQ8nnsbeieFQ2QajGqfSFVGI8F9HQiy9rN1Nsf3D2aLmiLWd0
 3tg7WhnvAuDa6Yn+oQbLbAMcZ8xpx2tm3vKSTEYc8LImSZuBzhKLr/06tJ4IrT52QboP
 dXkZ3bh4PcCoT15LDvd9v7/Q4V1EJZVgM/Ck8X4WpTy1MjxV65RSaTvcXw/w6DR1kCGE
 zP3w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr3g8ldzIoEPp9N80wkS7zBQli9/t1NCkrLAeFDfSKLt/vFZ75Hq5ekRZo02c0D2W3pLSYZuQ4=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyMvgxAeacNjwJzOH37A2HQdTgg0yTR4k+/faZO6xeh9FE5UGlB
 jyQ8KLNt1agof9lBxY9Iasbr1vLgIUZsTc+hljB23F+zPZEvLADlyoRu6K22opC0ro7aXrmnzCd
 DbC8I7c61iBadGbnEtqOwlN2qOfJ5xCcuzgwvMq95
X-Gm-Gg: AR+sD11rcSKbEATIuR74aWu5CAcrfXJj8xU/PJSP8BE4UDEPZQwbKuDhsOIcuW1MWQ3
 4+3ynxE2/NhvmjLef6J7PRbprtF0i+fGG+pFalLdsEpk5iADn8mq9HUo8q9VxQ+whGBSB7sqx6N
 lTdN4UhYJWcZhbPpfzRiGKjpw+9MODTq5c4ep2pmojGuYDbhehUa+lJ1aeIwH6TTXv5RI+lFj+8
 lpAc3ScpUiC57LL1QzHKkw5Sd2AW7diAgOMgYFWJfp5qxtvCdpADr+YOTVhjakSyaZikq8pur8X
 2YAFr0J1Oh9GDYq/vYyMPrCGyOTHKDbryqV2Ia1Ebxs=
X-Received: by 2002:a05:6402:210f:b0:698:9e5e:5df8 with SMTP id
 4fb4d7f45d1cf-6a14f104406mr6056332a12.7.1785966653142; Wed, 05 Aug 2026
 14:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260730-math64-resync-v1-0-8792d9119d49@flipper.net>
 <20260730-math64-resync-v1-1-8792d9119d49@flipper.net>
In-Reply-To: <20260730-math64-resync-v1-1-8792d9119d49@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 5 Aug 2026 15:50:40 -0600
X-Gm-Features: AUfX_myxnv8Z4tPSpM6EKF6Idjd3RZdU4ku8v-coz-U6Lmr0DXJexFMMN_bswIE
Message-ID: <CAFLszTiNHH-Toq9qHhjB3o2dVE1xG8_q5AtpR-yjZcOF6VTwTQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] lib: div64: fix off-by-one shift in div64_u64() and
 div64_u64_rem()
To: alchark@flipper.net
Cc: Peng Fan <peng.fan@nxp.com>, u-boot@lists.u-boot-project.org, 
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785966653; x=1786571453;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iy6H4vSM+shdsZuW3p6DFUwjFH1LGAY0p3RNqqvz+MU=;
 b=CqhpQQrtFLiIZvKH60c1UB8XzAUeI1w60ZxgHhNd2jAlvNs35Z55w082J2GhBTYm9U
 ufefH3DPPNMtbQrwz6Wp9+vilMsqcALZaIKKgOCCPNv/0324tsWGDwbsdlVps1PYXBri
 F0Qu1ZbXVcO1VyfwtCAcmZxzKPcd4o2PHeRMg=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=CqhpQQrt
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

On 2026-07-30T18:40:37, Alexey Charkov <alchark@flipper.net> wrote:
> lib: div64: fix off-by-one shift in div64_u64() and div64_u64_rem()
>
> fls() counts bits starting from 1, so shifting the operands right by
> 1 + fls(high) discards one more bit of the divisor than intended. Both
> functions estimate the quotient from the shifted operands and then fix
> it up with a single decrement/increment, so an estimate that is off by
> more than one cannot be repaired and the result comes out wrong.
>
> This only affects BITS_PER_LONG == 32, where these are the out-of-line
> implementations; on 64-bit the header provides plain C division.
>
> The error is only reachable when the quotient is large, which needs a
> divisor just above 2^32. For example:
>
>   dividend = 15559272575191414037
>   divisor  = 4333540799
>   expected = 3590429465
>   actual   = 3590429468            (off by 3)
>
> A sweep over 6.4M random operand pairs, stratified by the width of the
> divisor's high word, mismatches a __int128 reference 8260 times before
> this change and never after it. All failures have a divisor with one or
> two significant bits above bit 32; uniformly random 64-bit divisors are
> closer to 2^63 and yield quotients of ~1, which hides the problem.
>
> Port of Linux commit cdc94a374931 ("lib/div64.c: off by one in shift"),
> which fixed the same code and cites [1].
>
> In-tree users of div64_u64() that are built for 32-bit targets include
> the Aspeed, Meson and Cadence TTC PWM drivers, the Versaclock and
> wrpll-cln28hpc clock drivers, and the DWC3 USB core.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=202391 [1]
> Fixes: 0342e335ba88 ("lib: div64: sync with Linux")
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> lib/div64.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
