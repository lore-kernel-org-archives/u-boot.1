Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 803ABC83F2C
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 16:50:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 904F686932;
	Mon,  4 Sep 2023 18:49:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PxzwsbKg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C736286886; Mon,  4 Sep 2023 18:49:52 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89F838694A
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 18:49:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-500cefc3644so2754457e87.3
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 09:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693846185; x=1694450985; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dQZDNocKKaaBtAruQtgzDe3OAtegxRfGFSdsfDCpzAs=;
 b=PxzwsbKgOFS1t4mpcyFMlPYHxA6MpqdXhiIM1en1WqX35kTZlQgLL4Ho9O7f9k7k9o
 ybURY3OWgdxZult/DYDbxyidI5kA30T+YcetL8UxDxJCOjF2lZYYee3sFloifwSitvpL
 SP1OiuCMBDsuaxTwqgQIARvVnrcdrh/DB0vo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693846185; x=1694450985;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dQZDNocKKaaBtAruQtgzDe3OAtegxRfGFSdsfDCpzAs=;
 b=gbxZg2Tg7UiQYQ8mggSHQKUIW6sbFVvn7/4q88334VlIyFuexDnKHoVBSxeDheYbf2
 FbpSykbeI7tVP1HuzO9aNWJ0dG+dg2cD4lt+RxS7ZZJcjizWgy+6p9DcT8XElnf4h2HR
 ZrS82kz4prmwCG8BsiA1qM2zuTbFbRHNk0hqOlRaaO8JQGCXTm+C8eYLrNY+pNgwJBB4
 EBFM8wmkxWjADycJKRShe63FleCvINwDsbhOnQEhjlsVpOUlm1aSCA7t60shUv05M3II
 O/IUaiE45WV8E9vabfFbmfxOYuGhO7bfnoGRsjhwTJQrxHa5uvtzjd5uhJkbxJvfGwX9
 8Chg==
X-Gm-Message-State: AOJu0YzoLjkIZryckAnIyYxSvKG4m2rHg44Py1sybSmVqBgOYZ82f5s7
 xuiYII18+ydeIMYwI29dzSxe2ZpkJ/UgRNu92CCQnQ==
X-Google-Smtp-Source: AGHT+IEH92ryRRgvWhPWsos9FUNmY7eODafvQdFvtcV0pPDsa2vCLcTfCWGbDRUadY4LOUwQ5V8PGL3tfO85Lz8k5hk=
X-Received: by 2002:a05:6512:20cb:b0:500:8c19:d8c6 with SMTP id
 u11-20020a05651220cb00b005008c19d8c6mr6303151lfr.58.1693846184553; Mon, 04
 Sep 2023 09:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAC928HYMtd=RZnZYW9CNc5wPjzGk11X0+RpcuwHMFEuUpv0C4w@mail.gmail.com>
In-Reply-To: <CAC928HYMtd=RZnZYW9CNc5wPjzGk11X0+RpcuwHMFEuUpv0C4w@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 Sep 2023 10:48:46 -0600
Message-ID: <CAPnjgZ1U1an8+2-VgEXkqZtf3yWTggtEmjn-RFjm+ESgS+Qu3g@mail.gmail.com>
Subject: Re: Binman how to build using Rockchip BL32 binary as OP-TEE
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: u-boot@lists.denx.de, Kever Yang <kever.yang@rock-chips.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Massimo,

On Mon, 4 Sept 2023 at 09:05, Massimo Pegorer
<massimo.pegorer+oss@gmail.com> wrote:
>
> Hi,
>
> Is there any way for binman to package FIT with U-Boot TF-A and
> OP-TEE, using bl32 binary provided by Rockchip as TEE?
>
> I've tried with TEE=/path/to/rkbin/bin/rk33/xxx_bl32_vX.YZ.bin, but
> binman failed.
>
> In my poor understanding of Python code, it seems binman accepts only
> ELF format or a binary format starting with optee_v1_header, but
> binaries provided by Rockchip in rkbin repository do not have this
> header.

Yes that is correct. How would U-Boot know the load address of the TEE
fille? Hmm it seems to be a fixed address. Perhaps you could change
the rockchip-u-boot.dtsi file to make the 'tee-os' node a 'blobext'
node instead, then add a filename property in there with the name of
your file?

>
> Thanks in advance for any hints!

Regards,
Simon
