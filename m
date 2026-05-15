Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5D3CD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 12:57:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FD798465D;
	Fri, 15 May 2026 14:57:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YMF5Ptgd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D03784687; Fri, 15 May 2026 14:57:07 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89EE68464D
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 14:57:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-67e2498f3a7so15505669a12.2
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 05:57:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778849823; cv=none;
 d=google.com; s=arc-20240605;
 b=O3MLWz9nZOqmGqLojQ6kVXhaFWSZQvsX5iQuJvn/jp463ZqpjvYtp8gOsQBvYvXbd8
 HrRRb3NBrQ568rXpaQ1ekncgPjIxImTRhV9LgQfEKtY7fj7a4FxzLHRazlSuH2SH+4s8
 lke4tTU4GbRcDaBqUmBvghxDxIW+v+xMASsXYLtMlBWZe+944fbE8GbVc/+lQociy22H
 xwWy8MjAAufpvnNSn4V1DqB4Lxou/TloEMZycvgxdPcA5eerJoUJ4dLy13o9Q9k2w58Q
 KM8b18TPuPHNRt3tkd1jzO5veZiRudyDx46KOHkL8RwV801pebE77nh1DYbQSgUHYwc/
 xJFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=23fHjP9Hj9fLwA5pOUOduSFPYpHzOwaj3qezLt0pXhs=;
 fh=fJAGB8LvxCJalDRE+ziaXIW21+gD5jSCb0B1QEwHsvE=;
 b=apJirAHM2Agk/PjSMlEFa/JUbUUY03cm6UpOQe5JhMElPN9dWozUUSow+2vaj5Dswz
 MgmubMwqezzICMoS9Pf7/YWfmLPQ41k4h33P7dqwdZRxENqZgfBnQYVHhAHG9sj53rmZ
 IR0Km3hareUcPhT2cEKdrN0w+8l7/Ns4sgd1pGMcg4NGHDzRhlcYXHehxkuNT1oDWI1n
 BlaDTiPIIxwL3Uicw8Lxv1BJqhymtCqZUliGPRx6iB/wZQv4Z303X5KDu0d96/BSkGQa
 JGam9fgW6dxbnhfmkvImzRwSsL5HqDMK94NjeqZQBmQaR/ZbYq9BVixMQB2mut6+IG95
 65ug==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778849823; x=1779454623; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=23fHjP9Hj9fLwA5pOUOduSFPYpHzOwaj3qezLt0pXhs=;
 b=YMF5PtgdRyR0EKuupoTbYAkykbvLb3ZOKrHgV6LmZstDg5Ytgk4FLOaQKJazxh+WOe
 R/myzuwPeRYr6zJzgqfRkMM2i9MNCoUuCvMabf1YdW7EhEzwCVan9E1UDtZojsOlh7h1
 BxaDbwFoOWkiikfOHYWfYWbCmphlMPv1zhmcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778849823; x=1779454623;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=23fHjP9Hj9fLwA5pOUOduSFPYpHzOwaj3qezLt0pXhs=;
 b=pNb6JkQdDg6BYwzSSCXsMXjgUxdIknqnJVwi3m5Pwzk4ynd0nmDlPP7qxD6PhFfqzb
 t2+B1NK3Ul1F3xhqKxCW+Rt+6UhsE6uFFpDFJdHoArQrX9K2zNX4HNJ/aIc+OirOwURp
 MOI22ncfZ8NkwhwSSYUAyeknz9Lj0DEwJcIpsSTLozApzdOB1fOF5XQhoWON0IEGadV8
 EG8+e9OCQN5UCgxK4vxUaCE95PNXjvWNekhsy97uTnnIL+PUw1VHQCL2b8qAynOH1VHe
 rwU/1YC5lG4yRWipY+DNv4B/uen0Gp7QW0PZTPHTpP62faLLiyRLXSLFOJGDE0Ekwn1r
 DrJQ==
X-Gm-Message-State: AOJu0YwzHOUOjZDnf6YzjWGwnDg9mfRrsP/uHBlDNosNUd4Y5+R9Y+aj
 XNQJqHyGAhmeoAcnLJoVeiQjIgNBybbCtonJAmEuqIPOvOz97R5HYpoGudz2OuHOstql9xmTx1e
 kRBSHvsLpSeEDMEg0Kh4Kl/TO7iOMaISx4tojvnrzpKxFCSRaaSKDXQ==
X-Gm-Gg: Acq92OFPFkofINfEB8UMyZIQ3yyTHDhxho8zCS0dQZAzXpxz3kqLb1xD2jnOoI40ib6
 TKn/Z+ruhKt3k3aEcB4O2qyWNDHKC1xJEFYaGhkkLwuVzvg1RlM9U6LBxPjBq1hFJ/RZlUaZI+E
 kU9yQa4EtkUGjC606QW2IyZAijdiYZdE5IY8SVRt3lFvLA0TwJwbS4hJ319Tdqwrx6caDYZc9G8
 yfEtIaYZFzwWh9fWLBYOmRIWcM/1VNNppGzAC09N+knI2rDENzyPSoRldJ21lQzYDt0I7euKZk4
 EJ2kCA==
X-Received: by 2002:a17:907:706:b0:bcc:c8ea:3b01 with SMTP id
 a640c23a62f3a-bd51781379dmr196666966b.12.1778849822982; Fri, 15 May 2026
 05:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1778657347.git.weijie.gao@mediatek.com>
 <1b513aa72b3f4db27d752c8f9f734d4e2cf8d71d.1778657347.git.weijie.gao@mediatek.com>
In-Reply-To: <1b513aa72b3f4db27d752c8f9f734d4e2cf8d71d.1778657347.git.weijie.gao@mediatek.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 06:56:50 -0600
X-Gm-Features: AVHnY4Ji95HlQV0jU7r_x8fb3Gr8EyZ9cRBzC-EeRrKF6TV62DyAZOavqNAddW4
Message-ID: <CAFLszTiRoyxB2H=HC0Uug3jsw3ve_sHX02Udnw0BiC8HXxQKPA@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] cmd: ubi: reorganize command messages
To: weijie.gao@mediatek.com
Cc: u-boot@lists.denx.de
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

On 2026-05-13T08:02:45, Weijie Gao <weijie.gao@mediatek.com> wrote:
> cmd: ubi: reorganize command messages
>
> This patch moves normal subcommand messages into the main command function.
> This will allow current and potential api functions being called with clean
> output on success.
>
> A new function ubi_require_volume() is added for finding and printing error
> message if volume not found. The original ubi_find_volume() will be silent
> for being an api function.
>
> To avoid ubi_require_volume() being called twice for volume read/remove,
> some changes are required:
> - The parameter of ubi_remove_vol() is changed to accept
> 'struct ubi_volume *' directly.
> - The original ubi_volume_read() is renamed to __ubi_volume_read, with its
>   first parameter changed to accept also 'struct ubi_volume *' directly.
> - A new ubi_volume_read() is added to wraps __ubi_volume_read() to accept
>   volume name as its first parameter.
>
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
>
> cmd/ubi.c | 118 ++++++++++++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 80 insertions(+), 38 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
