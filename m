Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB6F2CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 16:00:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F9FF86ED0;
	Thu, 12 Oct 2023 17:37:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="00hrUYMU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CAF986EA8; Thu, 12 Oct 2023 17:31:32 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E546B86E95
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 17:29:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-53d8320f0easo1914468a12.3
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 08:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1697124553; x=1697729353; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eWnSC/eX3bogfxQmjZ4FvoD7yMY/+AouaUlCgLGM7Eg=;
 b=00hrUYMUKMU3Or+l0aS7Ty0bPjfZU9EA9Vp4ydq7H3/JTErLIWqAF4fehV6A2yPjkW
 brCeRGavM4RjNHIBBrkoC8pqzqzvwtzHxCqEk8gaEYW1iGunQcI6ewzL2TX6tgs9yBi7
 UDjiVYfBtw1zP+1hg/aMZ+MpBB78BcGp616s1xC45L25Ba3FPHq6U79MD0HryH6oBMID
 PT7Dza75x6uoYJkN7pPQKNcZCyxYC4x1CSZoIEAQjLLmDQUJhDzOXNUABrPAqJQ13JIc
 EThKlnTNsLVr5krOq4IJtTtmuuRHTFhasrUpXRCMr/j97D9C8jTL8pj/gysIoEKJE99K
 /+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697124553; x=1697729353;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eWnSC/eX3bogfxQmjZ4FvoD7yMY/+AouaUlCgLGM7Eg=;
 b=jpyOHHeEht9Fkgggi+6VtKP3aRRERwt6RL+rAyNH3oZcxyocVISJq71w6VkUD+pwji
 W7FZqcvE+X7jYKCDhJqyhPVWOV+puFOGTihOabG1kNyTPG9+UhsgrVRtMVx3tbkItoLL
 j24hCLJUfaH5pSjJCN0Ws+cDr3vaXM1kOso/UYqw4HmhkIAioc2odzQrJpPE9soQ9pg3
 4+BcMdkeJjmCNj/nT08VeVjFxu+KiFqM8r2L5jjYgkIsuVCBY8OR0uD3lKcQ24MvbRO1
 hDPKXKYPldU9oE7y3Ap0gxjAQ1OrN/UUs5yi/3MqIXOHV7L60CHDzN0vpwfOVxpjFjFc
 knaw==
X-Gm-Message-State: AOJu0YwBsZclKDEGb86qCgabPlDpid84AsFC/zrf/I2ms2i+4Nzb3aC1
 zoHdBkdMNIn7A6A17AmjMuEKeoHodf9Ds50M9WD8Iw==
X-Google-Smtp-Source: AGHT+IEXuw68fmIbB1PGXktc7B21I+575vTZpaqvjFAVvqMBcID1JuOXLBuSVMHxw0/9tY4xs/u+xivyg3Mf3ZE3lLU=
X-Received: by 2002:a17:906:31c9:b0:9b6:499a:172d with SMTP id
 f9-20020a17090631c900b009b6499a172dmr22446742ejf.52.1697124553313; Thu, 12
 Oct 2023 08:29:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231012063509.2963258-1-randolph@andestech.com>
 <20231012063509.2963258-4-randolph@andestech.com>
In-Reply-To: <20231012063509.2963258-4-randolph@andestech.com>
From: Simon Glass <sjg@google.com>
Date: Thu, 12 Oct 2023 08:28:57 -0700
Message-ID: <CAPnjgZ0-oH69DpDr334ifkVuNLbfZTatt=azdd83brbRtmX3kg@mail.gmail.com>
Subject: Re: [PATCH V2 3/7] riscv: dts: binman: add condition for opensbi os
 boot
To: Randolph <randolph@andestech.com>
Cc: u-boot@lists.denx.de, randolph.sklin@gmail.com, dylan@andestech.com, 
 tim609@andestech.com, peterlin@andestech.com
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

On Wed, 11 Oct 2023 at 23:43, Randolph <randolph@andestech.com> wrote:
>
> Add condition for OpenSBI OS boot mode, by default it is not enabled.
> By default, binman creates the output file u-boot.itb.
> If SPL_OPENSBI_OS_BOOT is enabled, linux.itb will be created
> after compilation instead of the default u-boot.itb.
>
> Signed-off-by: Randolph <randolph@andestech.com>
> ---
>  arch/riscv/dts/binman.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

You do have the option of creating two images, so you can support both
boot approaches. Then you would need to do the check at runtime,
somehow.
