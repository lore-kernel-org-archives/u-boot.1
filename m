Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5982EC43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 12:48:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C2C684A81;
	Mon, 29 Jun 2026 14:47:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oIk7FHKu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85669849F6; Mon, 29 Jun 2026 11:16:57 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57640849EF
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 11:16:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-8478fe07ebbso259304b3a.0
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 02:16:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782724614; cv=none;
 d=google.com; s=arc-20260327;
 b=nsba3F9SaIMEvRLhc1GaoulmLV5c5fPxi9LL9C+SWeLsWQowyY0VISEvVHDXQh9UlT
 wKv7Ab9lcBHYcqcktgRC9SeYk8os/LujOWvlASeVM5ykpcx0e6vLPXmGAgHZeKSTa8uW
 HSIEazBjZWohIoUjjtLrPVxfG8f75huRT/H4eokWsceLXGxwwRpkRl9cZDtgbKymEpoE
 4n1WDGa+1/hLNXu4DX73Q5n4Y8Gzr4IcKMCGry/g6vUleALZ5DYJuSjgS70qHNGKiQHc
 94dA8IM5/SXrl3egcITrtSwMPDJBab728uPsApBAHq4AGvONguZ5HHsY/yTk+9xzAYo0
 Sq5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7EhgFKCQJT+kp7NT6Sbx39Da2NHX8JXYf6ig7URvsAw=;
 fh=Ee5HjwU7hPjQnz2qwZ9mq7VgUWgwPRhtFKBDXoG7IAA=;
 b=WxdHHk2xYOGVrysAaOHh8DYrR+um3OeIqUXp8UfZEZa+uBsezqtN6JzidLgEH4mUdu
 EiwyRSc1UqzZjBO2EBuVQJmsHNhoUt6kMXOrWA76tJ1GOeHAPxuepZ3HuTY2zwRW2GS2
 qUW9YelkFITPvQbJEHS1GfqHUjXwWAKfzNRumIqSiiJrmOcUZbb7MlPWBQMnhDjDQV5E
 WnKDSgqC3xn/RGqv+jnb0hcou3RkU4swfdWoopy/7Ms9kQBKRz2NOn5K+wHN/sw7pLYx
 u7cund0F/AHJBd8ZuStuB9pkiNlXmfHMbhW5wooar+iDsg7cdB0C2LWQCL/AKXq7YP0O
 Oclg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782724614; x=1783329414; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7EhgFKCQJT+kp7NT6Sbx39Da2NHX8JXYf6ig7URvsAw=;
 b=oIk7FHKuaGHxmCCZuDr+QmkhWS7c3vTaCiXi+5lqWDkAUP8zKKPEq+G7nyywXG7+ig
 XxAlTqFwGB1ARTe+pZcDAPlT+t9CcmJr/2aAbR1M6AUEP2jsrh5b5m3VPPPgI/1qIZ/Q
 tIJOA2IZOABpMvXdHb2Q+8O1JBWnPTzVQ9/jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782724614; x=1783329414;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7EhgFKCQJT+kp7NT6Sbx39Da2NHX8JXYf6ig7URvsAw=;
 b=i5yExYPBIJFc9S87r4GYiDciCRF32sq01xAC2bCZ5Q6GKLQF2IVC4/0n7nS6xlqWkN
 P33yi76a1LF3vkTsyuKzU1jd4Lg18wBnukjby1RWfwkAxtAUY4IYoelJe2yNDmz1ok77
 GZWQ4eRINAOYjOxH5ADLZyvVH+Gf1fXDiiD5gQSa5gXtmvrIG4F0Ziwx/hEnq8gjCdko
 oZc1F86VMcEHAfr2xiO43StcMJkxcWNTiiPHcGz0C7RAB4zSNCK3Q8vckq+Dgka0ygpP
 X+/InvfdWDrHi/JcGIyEf5BMKoAHxLtvIRg9VF9sJxI1+bnbvGeUvmwC6TnsqPis3y9a
 EADQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpGk7xLJG3/BFtl5y+qOimKgiWA7mmYRP7zemlimUKSsaTMikHo8yISbvxX5MA1EoZ/h33/mbQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yw6R5lPHk55Tj01m2moatZXe+mGyPpZGmbM9B/2s/V97rTlhwPQ
 0UJst5tdPAYc9+I4D1RaERBXGawevRfu2bh3dCJYkxP9XIuoQdd+i1vPtzMKhfNsj+b+IN15vEm
 1hY8Mbf5djgqi2euEXmyWOruLlXFgTCv9o5IOP6wm
X-Gm-Gg: AfdE7cnfdBctfDTH8eEQ+asGIw2CC2UDL7/yj7iIuwKMhndMZ7JwTwkIq9js/5EHgXg
 flW2i82j9nXCldESZd6oPp62yNa6KUp16kBSLbpZMVvDVbs6a6u3iDSCOCjKH9RZ11JXq2BU0AA
 mVVOc9q8ATeBgTvWgKOyH09nxIHttXQf37SAsEDi0NBOAUKIgGZg0rVRqm3TQuXJISoGUoTBUPB
 1J6WSAHGugLa0hslLL1DuqXjSfGgQnoI67U9gE4ctKSSgx6DxIXXCsDwVQa6QxAlB8jShKHAw==
X-Received: by 2002:a05:6a00:1a88:b0:845:3033:6cbb with SMTP id
 d2e1a72fcca58-84591b7150cmr21790601b3a.11.1782724613764; Mon, 29 Jun 2026
 02:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260623064804.3988799-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260623064804.3988799-12-varadarajan.narayanan@oss.qualcomm.com>
In-Reply-To: <20260623064804.3988799-12-varadarajan.narayanan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 29 Jun 2026 10:16:24 +0100
X-Gm-Features: AVVi8CcHmiVSHsC42td65SsMFlAORMpxTsNE81w87U1qKhlmdKyMuw7MeuBAuLc
Message-ID: <CAFLszTi+TayLxOGq0K3G57VPcV3b_-Gc6-rrwODgOPfHDq70fA@mail.gmail.com>
Subject: Re: [PATCH v6 11/11] doc: board/qualcomm: Update RDP build
 instructions
To: varadarajan.narayanan@oss.qualcomm.com
Cc: rayagonda.kokatanur@broadcom.com, trini@konsulko.com, 
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 peng.fan@nxp.com, jh80.chung@samsung.com, lukma@denx.de, 
 tien.fong.chee@altera.com, anshuld@ti.com, alif.zakuan.yuslaimi@altera.com, 
 tingting.meng@altera.com, alice.guo@nxp.com, marek.vasut+renesas@mailbox.org, 
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org, sjg@chromium.org, 
 andre.przywara@arm.com, afd@ti.com, h-salunke@ti.com, alchark@gmail.com, 
 mkorpershoek@kernel.org, dinesh.maniyam@altera.com, luca.weiss@fairphone.com, 
 balaji.selvanathan@oss.qualcomm.com, danila@jiaxyga.com, 
 aswin.murugan@oss.qualcomm.com, ycliang@andestech.com, n-francis@ti.com, 
 mateuslima.ti@gmail.com, jamie.gibbons@microchip.com, 
 david.wronek@mainlining.org, james.hilliard1@gmail.com, 
 philip.molloy@analog.com, ravi@prevas.dk, sughosh.ganu@arm.com, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 29 Jun 2026 14:47:37 +0200
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

Hi Varadarajan,

On 2026-06-23T06:47:53, Varadarajan Narayanan
<varadarajan.narayanan@oss.qualcomm.com> wrote:
> doc: board/qualcomm: Update RDP build instructions
>
> Add details about the SPL & U-Boot proper build steps, converting to
> flashable images, source URLs for the needed binaries and scripts.
>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
>
> doc/board/qualcomm/rdp.rst | 98 +++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 93 insertions(+), 5 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/doc/board/qualcomm/rdp.rst b/doc/board/qualcomm/rdp.rst
> @@ -42,17 +46,101 @@ on your device with::
> -     EDL.  A tool like bkerler's edl_ can be used for flashing with the
> +     EDL.  A tool like bkerler's edl can be used for flashing with the

I just wondered why you drop the _ ?

Regards,
Simon
