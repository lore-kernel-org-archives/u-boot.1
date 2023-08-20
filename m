Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0646DEE49A4
	for <u-boot@archiver.kernel.org>; Sun, 20 Aug 2023 21:57:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FB2286EFF;
	Sun, 20 Aug 2023 23:57:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K5UNHffO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8B3286EE9; Sun, 20 Aug 2023 23:57:35 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6866E86B7E
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 23:57:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-31977ace1c8so2489368f8f.1
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 14:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692568652; x=1693173452;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jb9ZrHV/mwrIrzcRuP+7U8m3N+YrBbFCOQRUDEQmW2g=;
 b=K5UNHffOofzZcW0JUhOXZVymQ+Is5vJ7mEYKlYLgZ7urXkGGoI2iw8aezxHbvSh3g8
 eK7LJlUgkWFomBgn4/u7Ga9hRb7q98hv3zfhHJ1gru8l1xymukKo5+/8pZyc80noFUuy
 OJlaAw3p93r76VQpzgRAI9IEBYqEMa/v4GWB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692568652; x=1693173452;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jb9ZrHV/mwrIrzcRuP+7U8m3N+YrBbFCOQRUDEQmW2g=;
 b=E58Jlqg94s/iuuhXvj/yz7jrWdbwN4PdUp4KotV//aL4CLZZLgTfQM/1o1znXW7udD
 29nOiij8MknxbwsgmBgpjUFu09dD6EpWqZlD/At5QayqKNEBupoqfKpSzmnlrVBSZxYS
 MljeALxzi8ohKQrhKg79YAY5SZW8B3FPPfEuJt2c5llwDLuDiu1urrxYgQLHciRN8+qG
 VNmk0G67ADAuVL9LQRqFNfW9heQvNGWD3sw8tVGAsd8t7eujxuwIR1p4DOcW+2lHE/dd
 mCsomYUtfLbfD+8BDJzNSqdjvb3oK8pbsSahrqjMYhbYyGGuyuhTihkpfzb++VqoO3pW
 SeTA==
X-Gm-Message-State: AOJu0Yzqw48C0yFqbyTQrAOYJ85YdfA0x8AfcFW/sjM73cKqrrSp4PZy
 jN651EQNi9UHcCf56Sxp+flB0wRG6NBrLKQxlFhGog==
X-Google-Smtp-Source: AGHT+IGgDfcVLbXcb1MhYYPmyK1N5AcyZCnBVEf4rCRPnyzIqRSWiMkjhH8f2X1YI6mtzFgs6yNSiT9wruvz21OKaKc=
X-Received: by 2002:a5d:5263:0:b0:319:6e71:d1dd with SMTP id
 l3-20020a5d5263000000b003196e71d1ddmr3010372wrc.12.1692568651780; Sun, 20 Aug
 2023 14:57:31 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 20 Aug 2023 14:57:30 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ0vTW9mPfkv4X=gPHQRkmB=TayZdbpA1TjdzJUq3UW5Sw@mail.gmail.com>
References: <CAPnjgZ0vTW9mPfkv4X=gPHQRkmB=TayZdbpA1TjdzJUq3UW5Sw@mail.gmail.com>
 <20230813195029.159409-1-marek.vasut+renesas@mailbox.org>
Date: Sun, 20 Aug 2023 14:57:30 -0700
X-Google-Sender-Auth: LnvxDZ_z04iHOfrURp_ucwkMHDQ
Message-ID: <CAPnjgZ3D_CQt8SomCYtaqhHTtSQ9Cn3EZGdrJtCSutxFc9YsRA@mail.gmail.com>
Subject: Re: [PATCH] configs: sandbox64: Enable clock CCF driver
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
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

On Sun, 13 Aug 2023 at 13:50, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Align the sandbox64 defconfig with sandbox defconfig. Enable missing
> CCF and Sandbox CCF drivers. This fixes ut_dm_dm_test_clk_ccf test .
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  configs/sandbox64_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot-dm, thanks!
