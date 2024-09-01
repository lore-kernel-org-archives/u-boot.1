Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D46C54FC6
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 20:13:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A41D88C72;
	Sun,  1 Sep 2024 22:10:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="W1gC2CbH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47A9D88C3E; Sun,  1 Sep 2024 22:10:23 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 765DF88BF9
 for <u-boot@lists.denx.de>; Sun,  1 Sep 2024 22:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-201fbd0d7c2so28400825ad.0
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 13:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725221418; x=1725826218; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eNHyOioD7Gs7NZIKQjJO59ffNsMUbHXKkma3szJXEuI=;
 b=W1gC2CbHcVpqB5QSOXIjY1dHBkvTR+Fn5hEEY9heEm7kwjQvL86egPRtutZdtdvCMH
 ujK1ov1IFwF2grBprF1oWOZRH9cRZ9sVBvDBzyQyC8WC7a+VPT/xEFZUv2W4wDQWrOzQ
 kd7XOaMtVqyK+fFeUFkCPCSgympPqD57slsI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725221418; x=1725826218;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eNHyOioD7Gs7NZIKQjJO59ffNsMUbHXKkma3szJXEuI=;
 b=Mq13s7OcecTrn2e0n2dJgP9bwKjzaNq/tk4wyxesCHTxV3526Nmy6b9Dy+97OU4yoe
 6zIsmlqhsD5AkWaD4lptKQpFXmN8Pl2qJdl640/v3bjm4F/Jx9DEdARh4EIFOS4DEQSE
 joS9mN/dyJugw2ar5PAO4Pb/8EP1F4bvzcPei9/uUJYSwZ22L3mDWvoLkkvuTAtKFinT
 D3UWBKKpRApBahyVL/PFKy7yMTuoA6CcNBauvabrchk+B+NXe0DMInlTvQn5mSrqumVl
 fEYxl4+f9bW0crHuGXorpXUfR3eMDUnnMTkLLX4NXQa3RRi9aBKyzrzapkGSBEtOlfcX
 9GMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4wtsqLmIiYBWYrQGgfjCl0p7NN7reD8ARbxrX93BhXwGN+XCkKy20knMPB8hXtgL9vHLOf/Y=@lists.denx.de
X-Gm-Message-State: AOJu0Yxg/BgQP6OKB2TVMihOZ4p89A71QK8W6oUcKeYDmGSix5G8hlsa
 zd2qoua+rxKiJF6vk2D0obMfhXnC5faYNDYu0A7XWB17DBZ3OK8ujjWLkhamXefrTcVw3XMS7h/
 3M24XIqPd3kp5MgT+V4Olo+yzfAqruVnt0PV5
X-Google-Smtp-Source: AGHT+IFKThBerkxLHJw8XOUbQOLdaxcoszHRxuIXFpPwM+42dBxZkQRugWxyGcEkLA4kWDqsHV8EnW6pejniRtclaj0=
X-Received: by 2002:a17:902:e550:b0:202:4712:e838 with SMTP id
 d9443c01a7336-205444f0fe2mr62896485ad.14.1725221418054; Sun, 01 Sep 2024
 13:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240812205638.1732159-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20240812205638.1732159-1-ilias.apalodimas@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Sep 2024 14:10:01 -0600
Message-ID: <CAFLszTgEa+CbEr4uQJLMgVy-SGjNvhXkYggvkNebrE6ELBYMjA@mail.gmail.com>
Subject: Re: [PATCH 1/3] efi_loader: shorten
 efi_bootmgr_release_uridp_resource()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, kojima.masahisa@socionext.com, u-boot@lists.denx.de, 
 akashi.tkhro@gmail.com
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

On Mon, 12 Aug 2024 at 14:56, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> We use this function to clean up leftover resources when booting an
> EFI HTTP boot image, but the name is unnecessary long.
>
> Shorten it to efi_bootmgr_release_uridp()
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  lib/efi_loader/efi_bootmgr.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

horray!

Reviewed-by: Simon Glass <sjg@chromium.org>
