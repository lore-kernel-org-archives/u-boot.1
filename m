Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 949FCFF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 14:09:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0851884887;
	Wed, 29 Apr 2026 16:09:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d/7+j7dI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B66F18488A; Wed, 29 Apr 2026 16:09:47 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF8FC84875
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 16:09:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-65c0891f4e9so20851981a12.1
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 07:09:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777471785; cv=none;
 d=google.com; s=arc-20240605;
 b=OLHEVR6hG4wF9PROUKeDwr8GvZW/v4yuxKtdA2H2TQbxIgNi1Iz4FhsT/wyYM6AnAI
 u/ISGeuONJxfVtppHCgVcRCPof4l/b1btaqkxrJN+k/EqglqAYHJxncNP4xQtKP2Amui
 wLcYSMQ+84CnvPezS/0SJyNt0/I9QXfhooypE6Ss9i3Me7wl2s9JIAH5LU2IaSI5HKan
 sZXl4EcXbaK0cSrfVAjh3AcKyyStRJ0WF3jD7RobupRmGWl1GFtX9tJolHkOBOYeEsSV
 7lb4eQeysFYxwJW+H9ZZSoRQeadaf8pHDcvXGd9samLFYaWd63PLGZ3j5HZglX6TPnQH
 qHLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3WI1WPPE6Z8XGKwSmxHypebGXMablySb8cVppOm7DEo=;
 fh=OF00omt3W5XkTWoy8yz+VALjHs5aNJpNm30/GdQrL1I=;
 b=VXTybEZ4cC8z3ho0/chMGMf9Boh2mdu9TZoKxPWPuEdit0GeUUAhVDwWYB9pnyX6Nq
 2sJFCIBzyMFcxO8wZDqfwwWQT4nxL0Tio9hasAP6zAmc/Cg0cEXrKwZHN3948PjNonKj
 DhslKXAqggHa3+b2tovX7NVJYpyuB2ACeRLN203zhpkGzel7XKf4L5tJGXQwSd4OGTPp
 DFADTAtEKEFK1TCVUqy69o0isEnA6WE8xprdD5irEROqqDzhl6WM74Fmq8YIkGAlr7Je
 0Ygn2XcCPabufiBXCfLbziBkeDR23DHX4PimFUQvFXO3Wwl3tiu4tQ+MC8zLreIbL8Ov
 8ifg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777471785; x=1778076585; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3WI1WPPE6Z8XGKwSmxHypebGXMablySb8cVppOm7DEo=;
 b=d/7+j7dIEfyl4GaUIV8RaHht5hFVOE7Jw7IYL/BePhrkaCPwD0mqrYX4Uid4GUKvd+
 mH2AwNDsbRuxmbsaMyKtK22+67805sRwgUzwo8aWSm1OlPDpMvNTX37IrSIyEvMG7bqy
 mQw59vQHFjR1VoHN2GgwJQ44B9TfrrdzA/Akk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777471785; x=1778076585;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3WI1WPPE6Z8XGKwSmxHypebGXMablySb8cVppOm7DEo=;
 b=OSwNK74GLegU1RzRBhZTOso6MuZFh2sjq5Eg+ZTcZdg0bA+qJ1UCV0tLakdOSiJNZM
 iY5OQGmkl3TjYHN+LflKRrg7pGWVFut4gCiLUZw3Na3DdmjYehYJIjG9QRc/w0g1x581
 I8VkLI3M8LUvyMdjYj6WrI2n5FHU5VIoVyj/gry5irOz+NRJUBzzR3ubEobTvxsaqGku
 Ldif2mJcr2/gjWksGd7XFpsMfmdmrmE3QLin3YkGI6i/HJWaXfyv5hd8k1MrNY2Wn0Cg
 mryAS1tea8eoUHwQbvzUCeLDvPVtg71UVpe8znci413G/OvLMUGfEu2+aoRvrGhKbkvE
 5X+g==
X-Gm-Message-State: AOJu0YzqAIsiUJ0616E/DH9Vm5duiSvaQyIpPOySgO9sYKRRL65p4JPb
 WsE3KqwYoHWpSui9g9PyX6RQ5Wg9u1rsk/Imgo509LGRr0hA9eAiXohJhLfEZoEhxnderR2Z1s9
 3OFg8YnUZmmgwJphXROdUeWemUA0bxDFfFsopWtUl
X-Gm-Gg: AeBDievRKQD/yI0H+obkd8LjsTHMk+QVigB+FASxNqyE8OvpBZNXEv7AQsXzEO+SUlF
 QiNR7yvdC1v3udGTK6mRcuFDEWVxvjZhEo1h6WuB4oBomueB9csu3B65ZRMqas5zlMkuW20N29J
 WMxKy4zqa7U7LTUaCy5JzD0d/jV078JAPZhxlRgTk62IQO0DOfiSzWkV40Z6lUS16KT7S7fJja4
 KoNCQuXlQldZXNCOXhON6QhiQY+g5CbYL8mdnsIiALDnAHRTWz8cgJIsWNWRvob0yHZT7e9LD1R
 GA283aQ44+dUjI5rMyuzzo9ejOo=
X-Received: by 2002:a17:907:7210:b0:ba9:bb46:3449 with SMTP id
 a640c23a62f3a-bb8018db5bcmr478641066b.8.1777471785215; Wed, 29 Apr 2026
 07:09:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776954004.git.jcethrid@gmail.com>
 <bcf7a2612fb0be0814444ca70ed060052042e034.1776954004.git.jcethrid@gmail.com>
In-Reply-To: <bcf7a2612fb0be0814444ca70ed060052042e034.1776954004.git.jcethrid@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Apr 2026 08:09:30 -0600
X-Gm-Features: AVHnY4J70SGf33TVsOZI74DwNKlMAK4HujkAOKF7Ip_jKJVC6bGs0xIrahAvymQ
Message-ID: <CAFLszTiZRVXXtg_e1FimCOGvB4xNUxCAg3nd8Jq+QBk=TkmwYg@mail.gmail.com>
Subject: Re: [PATCH v5 05/15] mach-sc5xx: Add USB boot command
To: jcethrid@gmail.com
Cc: u-boot@lists.denx.de, malysagreg@gmail.com, trini@konsulko.com, 
 linux@analog.com, philip@philipmolloy.com, sjg@chromium.org, 
 Caleb Ethridge <caleb.ethridge@analog.com>
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

Hi Caleb,

On 2026-04-23T14:24:50, Caleb Ethridge <jcethrid@gmail.com> wrote:
> mach-sc5xx: Add USB boot command
>
> Add the USB boot command to the environments
> of the boards that support it.
>
> Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
>
> board/adi/sc573-ezkit/sc573-ezkit.env           | 1 +
>  board/adi/sc584-ezkit/sc584-ezkit.env           | 1 +
>  board/adi/sc589-ezkit/sc589-ezkit.env           | 1 +
>  board/adi/sc589-mini/sc589-mini.env             | 1 +
>  board/adi/sc594-som-ezkit/sc594-som-ezkit.env   | 1 +
>  board/adi/sc594-som-ezlite/sc594-som-ezlite.env | 1 +
>  board/adi/sc598-som-ezkit/sc598-som-ezkit.env   | 1 +
>  include/env/adi/adi_boot.env                    | 7 +++++++
>  8 files changed, 14 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/include/env/adi/adi_boot.env b/include/env/adi/adi_boot.env
> @@ -68,3 +68,10 @@ ramboot= wget ${loadaddr} ${serverip}:/fitImage;
> +#if defined(USE_USB)
> +usbargs=setenv bootargs root=/dev/sda2 rw rootfstype=ext4 rootwait ${adi_bootargs}
> +usbboot=usb start;
> +     ext4load usb 0:1 ${loadaddr} /fitImage; run usbargs;
> +     bootm ${loadaddr}
> +#endif

Please split ext4load and run usbargs onto separate lines, to match
the style of mmcboot/spiboot/ospiboot above.

Just to check...should the partition for the fitImage match the rootfs
convention used by mmcboot (load from p1, root on p2)? You have 'usb
0:1' for the load and sda2 for root, which mirrors the mmc case, so I
think this is intentional - but worth confirming a freshly-imaged USB
stick is partitioned that way by the build.

Regards,
Simon
