Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8162D606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 08:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dmT/8sov;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=FAjJtYvN
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4BFF880DDD;
	Thu, 29 Oct 2026 08:55:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BgdO2fL8LURP; Thu, 29 Oct 2026 08:55:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7F55980DC9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793264146;
	b=KV2Xoi4mAvgqElLl+n/GonawFwxvmqrKSsT8IddipXOzmq/yrYp1diZdwS0UeFGMR914
	 6BX+UNeCnWsQdbSQKE2lY/dSLMpem1pQ/ucT4bMUCGMEUNearCvkFqCvfuaii4LYMAF4x
	 64XuxK/fkatMlDrI/yG0S20oUjO1e2NYz760PSPdOp30yGrF+nuAONP34K45UCGSmO6wn
	 7h+pKoiHbUK2EoA45QiLGWHnZB4M50Yvgg/fuO4ZK4BT+5aYX77jVmoPW4lLStyiEwxlx
	 Unx2o/ja5YUmtPUjyH8+dfbDmB2QwS0GiQKgTf+M5+WthNrHn2YezhA7rveRORSOreA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793264146;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1Pg+RcHnI8uskAJoW6AqM3VS7UKyAVmNAiVwh6lBtjw=;
	b=eknJQTl76Redh2pW0Ytw6TmffprY8BWtBLI3AF01wUnFWqKVPgYn+ibnvwue3dl+06zg
	 qBhzMvO6X4DWeM1byPRnLqLjETcWrbZHhwCuGatO4Bsy2+KuWmU+Gq7/0QDIT7TETEGjB
	 7o+OqfgLa5Eyoho5F+mDkA8d80yD9OwKM3c9F3xDhJat4BYGDo8RLgwf2X9pZYm5NXtPH
	 g37oqCx6KnIh6XX6yJaxY4vFCxVT5udujuqP7e8PeHr+bJZH0XUEg3or7z3f2kBgD3DEh
	 qQWzc5niX6jxqJepLABl91o7BksjrDCFKrC6+WM0Bre2/bOUkmvkn3Di1GdIDldlRsg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=FAjJtYvN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793264146;
	bh=1Pg+RcHnI8uskAJoW6AqM3VS7UKyAVmNAiVwh6lBtjw=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dmT/8sov/3DA/Q2PLom918fa+k9q97LK9iNhW7WSvffg9HR1f+JpqnaBVobxX/plj
	 ROG7/Rkqwb2spMAakH6kOcwtpGPTGyTpUxmxxCkqa4pAvr7HIjeuEuSNbeIeDw5mzI
	 gWyn7HFK32FTxOrD5281b70HG9Bdw1Bl+R4rlwh9fYHX3fqkB3RFeGeBn0lQhhu4PS
	 qBlGSYxiOu3zyoucGrEQAymdOq3i2Ataa1fDqGY+GNrhnn6Ap7cMBVzuwtna7yVlfA
	 5yKapAsD4TdLwQKhigVnWWkhcVxA05J8wU3wctSqEivcV+jO45SPTRsB85gZxHK+RW
	 kLi/q4xmBbOUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F55980DC9;
	Thu, 29 Oct 2026 08:55:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7243A235
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 08:55:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 58EA880DC9
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 08:55:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ye8UDxbtdHk6 for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 08:55:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7474480DC4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793264144;
 b=mKjk00lis5KwHuNGdHLPYaOYA+NqaNaJTXD7qabCgnaIRVa6kNHZ2MB8Jwr7Mc6Ia+/o
 663mz3Blt6Q+xCnMEGfTmIO4a9xgAlqTCtl1EYqLpqGG9MLE21OpvzdeyUoM2nTWkZ5aM
 ZDCBiBaevObuUA2yREF2WVC3rVOstBOW7Iov4noCRcHLYVwZUoyP+49APsqZi6FDSL4k6
 4XsyVi1KFhqcnFwNrVhmiv07nrTJjrccUXabSA7mktfzyZz9q7XIYTXgOGrVvGiLCv4Iz
 8MHNflHc65riYN+aomPOdTwy+OkqC0DgsfzCEm6OKwnY4x0yQpMM7ADKhZqAmxoakTQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793264144;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=1Pg+RcHnI8uskAJoW6AqM3VS7UKyAVmNAiVwh6lBtjw=;
 b=hE3kucTnl/1QMu2Y3JZEzObdPKWKV/qkFrr1ogRX07RdCYFW8CWwWamMzw8bYLDBxJDR
 H9i54rbbFIFmw79obgEv2Sf6ZK5mut7ByCYF2u0tI36SsjBTr++6BZDFfPAIYunozBBAO
 L30BVoLbi4ztyVMRSwbS1IrNfX+nEqQKRuEuMH/fj+x0NYx1FbQJi4vLnDWOxb4Kws+bb
 bT/MFjkFKVYKH77jPNh8gsGmTHiLkJJrnw5ADJFSRgjFeEMB454wwoLBDFETn7+ddiHXz
 DVZRPkzKacjJAhvA7VwcEjXNodtXBlwT7q8OkfCC5pWmhYlvsBAVDg6RHmzD8zp98og==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=FAjJtYvN; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=FAjJtYvN
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7474480DC4
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 08:55:44 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6b1b13e09ffso2615162a12.3
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 01:55:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793264142; cv=none;
 d=google.com; s=arc-20260327;
 b=Lu5fCicIUUTAzLKzaDqVGZ5VXPchjzA2gEhGHPx3sMwbuI++X5ZRMn7UZsT0OQ16G4
 f5XlEn3jJNe3iJpPJW9rja+STrtpxKKgpfoGI9G6Gl1AfV9r0fBSh55Cp0CcUy1Ii6o4
 MenrkOZBLlbqri12CgJaONmA2PA4Bfez3ePCSPPsoCkXNx2E+ZjStYNoRxBw1RKMhIG5
 UJh5Dq451THYRUwXtz+Mws9rgjSKSyVeWjS3jHZol2IFDCqxlu+UcYZQX+VW1r2wYgFi
 iJGN1fMjhWxdx54EcJ9NzGjKMwgOvj6YpkN9NOsvah9Xb3vz8dyV42LrZjmeuI5Wvich
 a+0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=1Pg+RcHnI8uskAJoW6AqM3VS7UKyAVmNAiVwh6lBtjw=;
 fh=H0KLKoQNYaENzDfucJ75tNsdO2lBo636EsIhMH7eCcA=;
 b=qOkMKriaxZO2SuEoYS6ncEocsYhL7FSCCGVczGjsNHywWAZeWmKcC0jRBjZMIdq4DG
 gwiGTcrO0/7bzlDWCukbDjx4mcW6HlxiwEEuT3k2sfIwUa9Xl9PX4Btr3biyA6eHZLwi
 bkWdeRxBHjxLux12LilbpdvR01QN+MKUkw/K9HeDf/NKrzpBgRYuJaMav3VdcE8QPmu9
 QkAWoUz3fR6bbTsJffxlmA7anU0T1/oNhQe1l2mlUEy2Bo9ruCTAqfpfJoJpuGwmW68A
 bElG7WF2k3c4n3FshtpG6Qj8z8iNBmJENO1dLOtsxwbTMD2ipktDM8N7Gbp467kuhAav
 kYSQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793264142; x=1793868942;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1Pg+RcHnI8uskAJoW6AqM3VS7UKyAVmNAiVwh6lBtjw=;
 b=FAjJtYvNfvrH6VjnR7ThoE8FCJDMwvl5H+9MIrQkauybXU6b6j8KIk7K2wMpEhKIV+
 CHrFTtNmRNNwwzKUkeLZn/g3HdfoAjS7kysiqspu63jkeGi7+lBLBUihuJb/AHfknco0
 Ya98BeLNk8ISU9h3awNG89K37dWyfVzKmgtH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793264142; x=1793868942;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1Pg+RcHnI8uskAJoW6AqM3VS7UKyAVmNAiVwh6lBtjw=;
 b=Sjy5rU5Y7Do3Vj4iNwRrbbFI2Mwi02FBHfrTsB7GGEtkMAkPqlCYXgVMUP7RTiG+XA
 EmkdUUtbJmpIZG+xZB7CdcsHjcaf4wH/JMDF3Pocy33h+56VoLgDFBJTMjVJrTTtLacq
 vAh/YgzIQnUmaQyhPhthCm6aP9HO69y3K2jCNMRIoJxorLCyPRT4V6vT/Z/PAQA3hAbL
 VHbHfftm7R4cHFg1vxCuEGjZ0cpczsXkA0qnkIUHetSJf65u+Jl3r/SzJEGkkW5Rw9gW
 /641bSsvpqwpV2W3o5/oXubHhczIMDKYTbHGtsrkrRqc5MnmBTuci7+HKiZ82bKOlF96
 xgMA==
X-Gm-Message-State: AFq9FYKwtMMpCY3LsLcfmhHbJcRoxrzHffHlrkCCpwVMBCKmxDrfGqGa
 H/5QGJdUPesf1oVP+wfiPbDKzHONCwKU/uk5/4M4b8fxjmOYgsOoWyqmpCM7IcmGleLopVJQ1uJ
 N4vdsZLNPvjky993Ayf7FS33/S+zS8UWm8Hw9AkIr
X-Gm-Gg: AYBFou3In9G0goLQvoL4STF0YaUNZMv/+weGIwjFxYpUL29qHxowEQRs8VzRonOj/Ea
 euw+0YXSsPE+uqCgOXzerq1DkMEZDcNO362wZedwWfutMZVs+M1YhGMY1Csi3l4AKovNXxOPrcp
 gDuPfqRSQk1XC4r/FciPdIsIwrZfeSX4ZtJIXGwl4THvYieLhaOD1fqfRB+87gbXJNObBujd+YV
 deC1ULpbr0t90n0F4ADAjG5KnPmpsl75CgK7eHoFWILNqpXNygX03vUEeEcOa0p8H68uCOENSRr
 UFFmoew9O+qtdL8vUQ3wgHpx4P1t2PXuRhzhiXMJfPWzIVb6OkxTii637ptGweTYkBLAyKQhCui
 w/edqr0fquQ5kRULp/du2bxjWfgLxM9frddA=
X-Received: by 2002:a05:6402:c4c9:20b0:6b3:f094:8ced with SMTP id
 4fb4d7f45d1cf-6b49cbeba4cmr2691786a12.21.1793264142134; Thu, 29 Oct 2026
 01:55:42 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 29 Oct 2026 01:55:40 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 23:31:55 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261028-b4-rbrue-suez-upstreaming-misc-stubs-v1-1-9a88ac233299@gmail.com>
References: <20261028-b4-rbrue-suez-upstreaming-misc-stubs-v1-1-9a88ac233299@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 29 Oct 2026 01:55:40 -0700
X-Gm-Features: AclHuK9F0cIAfrarLsqt3NT81pTAnT9UtYjnrxbbiPqLNlOKqwzJ_c0vkfePMv8
Message-ID: <CAFLszTi8wXcbDu+GQLbRZoOcY35M8=O9hqGLyFo+VdnDhQgN_A@mail.gmail.com>
Subject: Re: [PATCH RESEND] misc: Provide stubs when MISC is disabled
To: ryanbrue.dev@gmail.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>
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
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-28T21:01:55, Ryan Brue <ryanbrue.dev@gmail.com> wrote:
> misc: Provide stubs when MISC is disabled
>
> nvmem.c reads and writes cells on UCLASS_MISC devices with misc_read() and
> misc_write(), so a build with NVMEM but without MISC fails to link, even
> when every cell it uses is on an RTC or an I2C EEPROM. The headers of
> those two providers have stubs for this case; give misc.h the same.
>
> Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
>
>  include/misc.h | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
