Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2B0E77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 15:29:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02B7F895C8;
	Sun,  8 Dec 2024 16:29:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Dz3gPM53";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FE64895C8; Sun,  8 Dec 2024 16:29:20 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A45489305
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 16:29:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aa67ac42819so70522266b.0
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 07:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733671758; x=1734276558; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=g54HaKHlwdKyuMhkj2vPU39NmSp+zxvhgsF/GRpyVjY=;
 b=Dz3gPM53ThGhfMhXQ7feWMXOnTEawLzWZO51YR7OBImTNvzr0EETO1JOv9fcqISY31
 BRae+Wb68MPDkxK/WJ/RO9ghhPDOlCwt76MP0B3Puf3ap+vZuKGEYLyscudC/InC1c0m
 2SlfCxFmEvCtVJfyK5D/XvXuYKuLVjK8juJFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733671758; x=1734276558;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g54HaKHlwdKyuMhkj2vPU39NmSp+zxvhgsF/GRpyVjY=;
 b=YlMEFBiI6rKk1/JoKust4tLWg6YJ6+Nj6RKPiitxH+A6sNEoCClUyBafdVLqz6uyns
 CeFLAYpl5UycDkWGgK5RMSvWdRhZKmSpde1Elkz14XQDyy1b9Dofwh3ph07Er6JZAeFY
 jcSksn4Bqyao8J74xKUksq3ZHyHL0FOUrym3gGKgelW42npd9rq0wMhxJqodvxGZgrFZ
 mZ2x1RZx5qqoUdAo5VHGHGKbT1+cvkZvZ6ojCjS8VcWPBKhOls+82dh5ywkAaZRyGpjz
 cysk7chbyayQ4GZ5q9ZL1SpVxFEex3gyKFzQt3BUGbSBiWR/xDVYLRiOHYPfTpK/xB3F
 KF3A==
X-Gm-Message-State: AOJu0YwVDyMeColn/nU4SOS4SFuyF9tdgZvy7zjoFN8DZYPQkiUws93A
 vTv8yIfwVBxgKtWTvZJBDS0C7kCrsoVq/cuBe9rnULx5gG9budWeS7rq/7Qj89SZ0zvCR2MI+q7
 rWD/kDjaoHnUf14Y42rlr9EZXAC6U8La80WLQ
X-Gm-Gg: ASbGncvIjDmkK8pIHgYCNQLSpSkKQLa2TLNjDcgf6ff3VwxjtSAVe49ov1/bML4AYZm
 Sx5cloDboP69Sr39o8Fk92FG3RqBlygxL
X-Google-Smtp-Source: AGHT+IHlek0gV8BW/2hvwWnjTYfiR2i3Rx3SOHWqj8BrlTvGftH8f5EwhMFnv28+/PY97blaegaRmCyuW68ou/tzgDc=
X-Received: by 2002:a17:906:314d:b0:aa5:3999:4ac9 with SMTP id
 a640c23a62f3a-aa639fb1585mr765851766b.2.1733671757791; Sun, 08 Dec 2024
 07:29:17 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 8 Dec 2024 15:29:16 +0000
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszTjbB6jmERfTFa6NKuNTHaEs_gchAv616wOWOYZFWPfmhA@mail.gmail.com>
References: <CAFLszTjbB6jmERfTFa6NKuNTHaEs_gchAv616wOWOYZFWPfmhA@mail.gmail.com>
 <20241123195616.305687-1-mjg59@srcf.ucam.org>
 <20241123195616.305687-9-mjg59@srcf.ucam.org>
Date: Sun, 8 Dec 2024 15:29:16 +0000
X-Google-Sender-Auth: _Jv_k7fDrPvPNNZb0lscnEtF-hw
Message-ID: <CAFLszTjPkJA=vMOW154xQwcbCxaz79WqLBfLRtH+QnP6YYekiw@mail.gmail.com>
Subject: Re: [PATCH 08/10] Use the correct ramdisk address
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Matthew Garrett <mgarrett@aurora.tech>, 
 Bin Meng <bmeng.cn@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Matthew Garrett <mjg59@srcf.ucam.org>
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

On Sat, 23 Nov 2024 at 12:57, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> From: Matthew Garrett <mgarrett@aurora.tech>
>
> CONFIG_SYS_BOOT_RAMDISK_HIGH copies the initrd out of the FIT and into
> correctly aligned RAM, but the addresses used for this are then discarded
> by the x86 bootm code. Fix that.
>
> Signed-off-by: Matthew Garrett <mgarrett@aurora.tech>
> ---
>
>  arch/x86/lib/bootm.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
Applied to ci/master, thanks!
