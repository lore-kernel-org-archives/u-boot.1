Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF92C3ABC3
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 13:08:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFD4682A33;
	Mon, 12 May 2025 15:08:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iad86BtS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87C9C82A1C; Mon, 12 May 2025 15:08:31 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A28A782162
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 15:08:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5fbf0324faaso9234623a12.1
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 06:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1747055309; x=1747660109; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r6bemLQMyoppUGFmMqQ2jZZ+GXVK8YNEHDsbGq+hd4g=;
 b=iad86BtSP31qvJiROwx00Lk1Yb0fqn5m+dDI57/uenobCoX9mk+wWNLhNeprmcudAD
 WchI9wgojCItJPVWnjxhODi1lVavnCM3MGf961MlP67jdu6BwHmG5iTndMhOvW/Kh+60
 O64fmHdCwveZbh7WaA0PBlY48IQfW26OtHfHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747055309; x=1747660109;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r6bemLQMyoppUGFmMqQ2jZZ+GXVK8YNEHDsbGq+hd4g=;
 b=Tv9/3eALAIkVPRUrhuyOUmzX0ZPZfMdk5eWAtRg0WXNkdiUdJx9h0cn3CNpsib9kLf
 rWCJBG/Rrl39SG7ThCg/m1Ivt6fudtxela6NTXb/yuGZba+AegjQrFGZ7T3XIQdAKtZq
 VJWbHxzUBYO9p/GWKTpyTYlkIia+4Uc/9GyBdfrOQHa4u+XnCXii3Upvfcc72LmXJPsH
 SfKGU7IRBBuqLiwc5veVAxBkYkqiiTH1EMuYpNFN5CRZjV5YbSybzpgvs/v9nPjTIxyM
 fkoS4zGHq4Ik/xJxRsj9b9Xx3g+vl27NMt4jAvnrnUMkdSIYfhCkB0dIJNrl1Gcu5HEA
 bGOw==
X-Gm-Message-State: AOJu0Yxdon8ExeSDR7Q3f5CxSXxmYV351stCGaUCsjsTSOUuZiUQQr+m
 DctWb8wbCtvP90FpxXYobGK7uLdOC2g21Vnsi2i9cpcVrdRyBJtFmFhh7fPcEfUbh5oRf2IyQ6g
 97ilXMIHlcxjETweQyzeglVKKFkzB4ex7t5N6RphJoF6KAc5FqJQq6er3og==
X-Gm-Gg: ASbGncsVegun2o3vgLd6FXkqnEaygRLGKrFNZH5NDx60RyaILBDwxt/V0GtkgQjmX8b
 pmDw//Yz9471KZ6DAL0ow9y//jNFcyBHASDoqVfaUgBm99OS31xNooNu/u1olFKNsf8rkFomGqg
 6yEn7be5rIgXInsrGHMc1rNMy4MnV4TeTLyA==
X-Google-Smtp-Source: AGHT+IE+l3D/9ktqvIvBCvwOESGHEDoXBM5DfT6Gv34YPa/0VB4a8xKlL3gfLGH9V+5j2QYfwM2zXQGXHKBGMaMwPEo=
X-Received: by 2002:a05:6402:1ecc:b0:5f7:f55a:e5c8 with SMTP id
 4fb4d7f45d1cf-5fca07ed72cmr9592819a12.21.1747055308969; Mon, 12 May 2025
 06:08:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250512115028.1783305-1-m-shah@ti.com>
 <20250512115028.1783305-2-m-shah@ti.com>
In-Reply-To: <20250512115028.1783305-2-m-shah@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 12 May 2025 15:08:16 +0200
X-Gm-Features: AX0GCFveeDlbwBDp3urNyvP3ty9URjN6RTcOIgeJTQhlGmLcn9t5OULomBvvQq8
Message-ID: <CAFLszThHJVnKXBRhpa-3yfrtRF+HWFCaKHbEENo5Sb-R5W1AKA@mail.gmail.com>
Subject: Re: [PATCH 1/2] tools: binman: control.py: Propagate bootph-*
 properties to supernodes
To: Moteen Shah <m-shah@ti.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, alpernebiyasak@gmail.com, 
 quentin.schulz@cherry.de, m-chawdhry@ti.com, n-francis@ti.com, 
 vigneshr@ti.com, u-kumar1@ti.com
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

On Mon, 12 May 2025 at 13:50, Moteen Shah <m-shah@ti.com> wrote:
>
> Add a function to scan through all the nodes in the device-tree
> for bootph-* property. If found, propagate it to all of its parent
> nodes up the hierarchy.
>
> Signed-off-by: Moteen Shah <m-shah@ti.com>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>  tools/binman/control.py | 51 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
