Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 241E2CF9C59
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 16:03:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CD1D88D70;
	Fri, 20 Sep 2024 18:02:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DakWqDhX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C04B188C41; Fri, 20 Sep 2024 18:01:58 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DE8F88C7B
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 18:01:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7197970e2aeso1632024b3a.2
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726848115; x=1727452915; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+eEdF7oyAmOwM60uNYfMIHAW7uoXWRlvesHSkG+XoHk=;
 b=DakWqDhXcRr89JVpN2gBNpgJzlGCwktv4a3v5Gmkql3i05DtG682TjcX0J/lveJGAC
 jIOS1wRPuC6AgqSU/Aj66wMRPx0ji1Fp8TcpX+Jr1aoW7DATfV/Ys2ZMp2f6ZsfCh/G8
 /lG8qmmwU1gCS5QtaP0SKBmn7FE57raiSWHos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726848115; x=1727452915;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+eEdF7oyAmOwM60uNYfMIHAW7uoXWRlvesHSkG+XoHk=;
 b=jcEnqafRVQfZ3XypnbLOAHJVqE06c8cNZNgWi/6VaE35TN7YOSjOjO3q75+DdeYkoz
 jQKac9sCsOiNLUiBzUOScQM/ze/4c80XdfkvD4RyA/puwlTgcx2aZJalornvt9oSSnZx
 OpacoyGHqQP6ySGTn4uYXmJ1PeNBqAKQGauZbzTQilJ/abxXTbNlYwc3uhWAptNKDGCv
 Jxh8skro9AyYqW2wBEbzClZlypUI344y4B/CQQHYeqXobWCfiXMJWMiqgJuZNS/Wr9p0
 cNNDNEgSDZ+tgmXi7R3UIUR6tBG0KB8JuuOyKIsUtHJAPWn5ZREq5o5R81KN6xn3emqI
 uafw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQKhy3rSOnEGuAoNk+EyeCCzTtZG7uMcp37pF02RkwOrXH6Bx0P78Z7dLHxvXEi1DcnTotbiY=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7vZi8kgGbakxgbZtITm68TSyV9Y8f55bPBhW3w66AMHonV3C7
 EbfK5npHh9E17OphgVFg7PbbcH7cVLLRswqyE+1XvRsVjFxEfRAJ9Z8aaXVlg8bi3SBTwkMwAHu
 fzIRRLQBHw/oZWDFTaVR8ZcsDmwlZKAOQbci9
X-Google-Smtp-Source: AGHT+IET8b0Yp0rwS/YxZdb+71t+yT2pZnNUprjA7HfAQtZI8CBSgjb/R53y3Ks/GYFq/HIkoiGEVY8K1DRQ74UNC3c=
X-Received: by 2002:aa7:8218:0:b0:717:8eb7:6c57 with SMTP id
 d2e1a72fcca58-7199ca7fd48mr4162756b3a.19.1726848114708; Fri, 20 Sep 2024
 09:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240902053326.3273410-1-chiawei_wang@aspeedtech.com>
 <20240902053326.3273410-4-chiawei_wang@aspeedtech.com>
In-Reply-To: <20240902053326.3273410-4-chiawei_wang@aspeedtech.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Sep 2024 18:01:42 +0200
Message-ID: <CAFLszTg8ZLs+BgNySmzhHBOgJUVTxq+FEg=oaCQBNWe+CbR_QQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] image-fit-sig: Remove padding check
To: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc: trini@konsulko.com, bob.wolff68@gmail.com, u-boot@lists.denx.de
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

Hi,

On Mon, 2 Sept 2024 at 07:33, Chia-Wei Wang <chiawei_wang@aspeedtech.com> wrote:
>
> The padding algorithm is not mandatory for all signing algorithm.
>
> For example, ECDSA does not require a padding method. The RSA case
> which needs PKCS padding, the belonging info->crypto() also has the
> check on the validity of info->padding().

Is that in rsa_verify_key() ?

>
> Thus, remove the info->padding check from the upper, general layer.
>
> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> ---
>  boot/image-fit-sig.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

>
> diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
> index fe328df4a85..d06e6cc8ed6 100644
> --- a/boot/image-fit-sig.c
> +++ b/boot/image-fit-sig.c
> @@ -95,7 +95,7 @@ static int fit_image_setup_verify(struct image_sign_info *info,
>         info->required_keynode = required_keynode;
>         printf("%s:%s", algo_name, info->keyname);
>
> -       if (!info->checksum || !info->crypto || !info->padding) {
> +       if (!info->checksum || !info->crypto) {
>                 *err_msgp = "Unknown signature algorithm";
>                 return -1;
>         }
> --
> 2.25.1
>

Regards,
Simon
