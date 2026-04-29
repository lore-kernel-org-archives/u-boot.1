Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F81FF8875
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 23:58:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EB0A848FD;
	Thu, 30 Apr 2026 01:58:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ShhqbIhN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6F8384912; Thu, 30 Apr 2026 01:58:08 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B21083FB5
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 01:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-bb962ce4dcfso41782166b.1
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 16:58:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777507084; cv=none;
 d=google.com; s=arc-20240605;
 b=h+2So24t+7R3ooki5OYGBJxTPieFBic9K3tVAdT8TA8PE9gcf8KEaRmQJwq0+vTz0G
 m04314WdeCHd6rKAzdfFvvQIsklS9xkP/KNv58+1vdZ/+bHa7CUq9bWxUAsyEc4i+wWh
 xC4npPr39BAWKVhr81lLd2pwM++NH8Fv4Uzi9BHZmQgG/Rzb3efVepMjcliiwvC15nQ8
 gXw2gWDaobZu+IuVf8g7evOxB0KNRsovvBKO9qXK3Y4A0MvpJ8sHGq9ouD5+d38I/VWr
 IthmDhXv19L7mbXsIsHBG3J5g29kF43j+m7uYlGD36Kl+mge6WCAppOmQmQ8IxhO+f6y
 hpfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=c1H12in2obwCaMxhs2ukuBQs898YghF/QGqAjLfdEg4=;
 fh=KG08Ovd/aJI9kucTHYzGVlynOtNtt/RIqzZZpPDsNLA=;
 b=bLIIyFaLm32lOzFHVaMJUz7rzi1XfIhECVRaxAVQEEmri7RNSxLARK04b2R0is6Fat
 7EecZJgjeOUs01pyJmIc4dKsMXL+oFfQx5kKS5Yao+/2IippRnx9GeGcJdmAotL2RQvu
 5lRrjN7wyt2COstkC4EZkhGZ962ay0dO4RjC2XkQONlqShTIVlaBEUQaWIM/7ALnasdT
 NCZzyyg6srsCH5r4KojqmhFxR1sVcYBTmmjnWbVBL2iuljIXHePjIH38Vl40saI+PwjB
 yTLxP9WkrxpSh6DSfDURGRjNi2Cy2mKKerkfIlKLJYRde68g57EzS1mcuKleHNdCISRo
 oaxg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777507084; x=1778111884; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c1H12in2obwCaMxhs2ukuBQs898YghF/QGqAjLfdEg4=;
 b=ShhqbIhNbEQhc7SR+G85+ms8+5Z4HhTAzxiH4bCbnHAi+N4btoB6EgxIdG38DOWrAL
 XeCXG/LI6hP5cC2gJ3zYBmPO1718jNW9A8Xpxl8uHeGRtCU/DQAGIuaG+LBjJKM033Rc
 t3JDfRuLr2h1i2/c7R0GfFjvlvAVCHA0Q4+Ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777507084; x=1778111884;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c1H12in2obwCaMxhs2ukuBQs898YghF/QGqAjLfdEg4=;
 b=cWw/1Txnzdty/LAAhOjkVpbqMNp2ihbX8w9MS+v4aPVoa9JgPx4vbZvRqYUGisarTO
 coUdqFSqFDAVpuZDqrBn56eCN/KnjUHsp7xDg/59PUSfgRYbKw3bc3Y2FUomzc2Nb6el
 iTUcoe6MHf29JosgV0gX4O6+XULFwOFXuOspZeZbSaxd3DLD12I87Jozb9zupnUx2lH9
 GGrx6nmXsVc7atv8qqwMx4U1FHdnryZWJU2k30c6c+qm8OPUQ7JQPqxi9s2XKH/ZDGw3
 QY54wN/M9AmJrppXzhXx6dxuiP3RwZJdoNhz8jUk6aqi4mULBzMmeEnybvivhtPg7vvy
 YUZg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+p1LUlR4f3pnSmPLP4x1PGe284ezg85Mbg6o+OeXejxA9iG+rKV/xz6uno2xmHm3YkFceTas8=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6Pg5FBl5J9fz5SLa9SqOcSCmTxWnvf5Ag2GSkAVkt3HKJcK0Z
 q8/mAWtrZpx0sNh5LT65BiZ6GynPM3fxhnQ5Acnys5D709MHG2wA2w5n/v4dE6H7NoMyk48hokX
 64uRykA/3YvhhRX/P+8Sepett2yvrj63/sHHJ42VQ
X-Gm-Gg: AeBDievFgFjch8aTIVeald5B/Rao2ihKm9rShSqDdG7iSOWXcbiKkJ7Nw8OYaZJXoN7
 0Jw7nK2QVyw0uKvvk3dxxB2n1a7i84CmN8RxY3U07cEzwOdCU+D1OFtD6zri/y/JlmArFvaoXiN
 jsBBZuq4bkUnQuGCj8vFaL0pbmE9mW2cLqBkZjuJfNBvSBIfsyG1ZDGm90zi/ZdDuW+in2ZlMI9
 Hi0GLjFr2VlI5kFNVwEvUtsxJSg8Z+jfbJUtMH5qwCDEvfhVjzIaIVI35MPk/v+rGlyGEPeR3M6
 0pSRriXXFoKxwfZm
X-Received: by 2002:a17:907:980d:b0:bab:f5f6:d700 with SMTP id
 a640c23a62f3a-bbac7c92172mr39729566b.38.1777507084554; Wed, 29 Apr 2026
 16:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260425033742.1519298-1-b-padhi@ti.com>
 <20260425033742.1519298-10-b-padhi@ti.com>
In-Reply-To: <20260425033742.1519298-10-b-padhi@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Apr 2026 17:57:52 -0600
X-Gm-Features: AVHnY4J1bX1Gr0F_VJggFZ0oVEX1C69S4fQ3f0ft0mUZwft0yHvo9I3CAAkzmIA
Message-ID: <CAFLszTgxJnLFQiUW7zsOP2iqVOCF1i5=LLw1e66xHjHU_fRjpQ@mail.gmail.com>
Subject: Re: [PATCH v4 09/11] arm: dts: k3-{j721s2/j722s/j784s4}-r5.dtsi:
 Enable HSM core
To: b-padhi@ti.com
Cc: trini@konsulko.com, u-boot@lists.denx.de
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

Hi Beleswar,

On 2026-04-25T03:37:39, Padhi, Beleswar <b-padhi@ti.com> wrote:
> arm: dts: k3-{j721s2/j722s/j784s4}-r5.dtsi: Enable HSM core
>
> The HSM M4F node is disabled by default in the device tree. Enable the
> node here as we have to load and boot the core in R5 SPL stage. Assign
> the alias of 'remoteproc2' to the hsm node. This assigns the sequence
> number '2' to HSM core which can be used during rproc_load() and
> rproc_start() calls.
>
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>
> arch/arm/dts/k3-j721s2-r5.dtsi | 5 +++++
>  arch/arm/dts/k3-j722s-r5.dtsi  | 5 +++++
>  arch/arm/dts/k3-j784s4-r5.dtsi | 4 ++++
>  3 files changed, 14 insertions(+)

> diff --git a/arch/arm/dts/k3-j721s2-r5.dtsi b/arch/arm/dts/k3-j721s2-r5.dtsi
> @@ -102,3 +103,7 @@
> +&hsm {
> +     status = 'okay';
> +};

Does this have or need bootph-pre-ram here so that the node is present in SPL?

> diff --git a/arch/arm/dts/k3-j721s2-r5.dtsi b/arch/arm/dts/k3-j721s2-r5.dtsi
> @@ -11,6 +11,7 @@
>       aliases {
>               remoteproc0 = &sysctrler;
>               remoteproc1 = &a72_0;
> +             remoteproc2 = &hsm;
>       };

Hard-coding sequence 2 in the alias and then using a literal '2' in
jump_to_image() (patch 11) is not great - anyone adding a remoteproc
later, or building without HSM enabled on a board that adds another
rproc, will quietly shift the index. Can you look it up by compatible
or phandle in the caller, or at least add a comment in both this file
and arch/arm/mach-k3/r5/common.c explaining this connection.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
