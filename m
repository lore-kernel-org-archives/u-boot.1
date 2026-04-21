Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D6BF8FA78
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 14:28:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82E9F83E36;
	Tue, 21 Apr 2026 16:28:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="U5PhZQEZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C69FC8412A; Tue, 21 Apr 2026 16:28:21 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDB2C83BC4
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 16:28:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso22275535e9.2
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 07:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1776781699; x=1777386499; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6o6s8AA6mTVHTv3k376gQhJVNyvXqilqi5GMsmwQelE=;
 b=U5PhZQEZ1cKGx+43qxVPynhhVyGDCh3QbecPF5XQ66A2MpE+KfaRPI8nSNgsEmtf3z
 1O+K++oulZRNa2fMAbo8RDReqipKnRoZsx/4yajT+I3tIfFJAXrf6c9+x58JLnxJia+L
 52I2NibkG7yjgePiixTCHOrvFVfFf64mgSYJWYlRO7HdFPRweE4v4mIQ0TjdAe3NO0ua
 K9ktDOhsZUXNu+lnqQwZPXVMYGHB83zHnO+PU4KQDSLJ4J+XjtZi8hirjrVapcRLV92f
 TgcLdhc9PeFQDmOMlLfPMA1KipeYO3OvRtuacOtNIiFXMuUNvtqJNDT9z/JzfAV+NfkM
 6UXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776781699; x=1777386499;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6o6s8AA6mTVHTv3k376gQhJVNyvXqilqi5GMsmwQelE=;
 b=lDdn6TZZhspemgF7GBUK3TwyFRhDy1XyImIrwi33utf1Pmcd88dRbx4rrmOO8sedb8
 j+ay0kOLLILRZTZtY2YewfCeec/8lTM6XTSjWE8zZw1urJ6BPBARnclg+IH8sbhqq2gi
 KkWFgEGtDOg+ztOGoX3+Q7g/hmG2vc7CszbsED0f4wDocjvj2ZPBasNDoUaHy4sWNgbL
 FQOLPuiWZ6dsax5ddNZAD7FQbNsrOXNvO9L8BmrhRDlI/zw9jeafSXXCGkGZZ1VunXAq
 k7GubHNXjOFouXNO+Bdf/03B67vDtwiomKna3Msl1SrLLrJrYxfx9ewbvqUPbd85VyRF
 28dw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+dAXq/WXABrfXsPQ8JchdoENQ//xZ8PC5TzehBcumfpWMqpF5CLYS/EFOoDxI16Kv+wdwNmlM=@lists.denx.de
X-Gm-Message-State: AOJu0YxWSZNKUODSJ9+EJzGePDpkq1367+0xtx+gpKiUdSjcrzQv3PpO
 +/Ni8WuZyodf302aNcI+3ezG7gFOUBdD62vHykoTqq0JnjHk+1ntxvursCklXjrH0QU=
X-Gm-Gg: AeBDietDEyBeKNOfX9z67j25Z3XjmxkeVFnDQjNe4oFJzhWf8vfkREw6HWAiRyg1bGn
 K4zHBuJlP0ckMWaIF/eifD29uGFQs2Ib7HVJW2LgVX3eVglICBzuQhRo0pv7T+E2sLB6iDC8Uep
 0ahrsjmsnllEU9vHk4Bx39C7QtLfG8QXjgXovNcuT+E8SDnghKbyvKH0aXsWPj8d0JZkSU7359X
 ZXswMhPiLaglT+QRkwnEG0gjWREx9S4lAd8+28LFauex2gC4/UBuYKXJTBVwLTy6/OVK/380szq
 yDikvGScHvwfMdiwZ1I8ScY00nTxh8ryzIHwnhNweIyi/KeUEwiMzTbZD4JSRXB6xtQ9YcaSBo/
 SUUyliIOznfW/QVbsXg8YWuhTSkYG4u3xMEnFzLfOc8FlGr/npcdfxPR+660XI8/kjVTXjCLDHe
 In/ZTPwFmMcQDei8PL1oHifnPIB8LtpFseklY81wqsF8PPIeCS6bZjpJMaIJhlwqOdMv0RKiHzL
 0BR+J2U95hIhiwIGuaWy7Yy
X-Received: by 2002:a05:600c:3b14:b0:48a:52d9:54ab with SMTP id
 5b1f17b1804b1-48a52d95604mr89476725e9.30.1776781699202; 
 Tue, 21 Apr 2026 07:28:19 -0700 (PDT)
Received: from [192.168.1.134] (59.85-85-174.dynamic.clientes.euskaltel.es.
 [85.85.174.59]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a4b329542sm184970095e9.3.2026.04.21.07.28.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 07:28:18 -0700 (PDT)
Message-ID: <2d3b2f53-4e6e-4799-863c-fcf4c25b74a7@suse.com>
Date: Tue, 21 Apr 2026 16:28:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video: arm: rpi: Add brcm,bcm2712-hdmi0 compatible
Content-Language: en-GB
To: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
References: <20260421085207.273703-1-pbrobinson@gmail.com>
From: Matthias Brugger <mbrugger@suse.com>
In-Reply-To: <20260421085207.273703-1-pbrobinson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 21/04/2026 10:51, Peter Robinson wrote:
> The 'brcm,bcm2712-hdmi0' compatible string is used on RPi5.
> There appears to be no change that impacts early boot output
> on the display controller so add the RPi5 compatible string.
> 
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
>   drivers/video/bcm2835.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/video/bcm2835.c b/drivers/video/bcm2835.c
> index 0c81e606622..0e0cc1979eb 100644
> --- a/drivers/video/bcm2835.c
> +++ b/drivers/video/bcm2835.c
> @@ -66,6 +66,7 @@ static int bcm2835_video_probe(struct udevice *dev)
>   static const struct udevice_id bcm2835_video_ids[] = {
>   	{ .compatible = "brcm,bcm2835-hdmi" },
>   	{ .compatible = "brcm,bcm2711-hdmi0" },
> +	{ .compatible = "brcm,bcm2712-hdmi0" },
>   	{ .compatible = "brcm,bcm2708-fb" },
>   #if !IS_ENABLED(CONFIG_VIDEO_DT_SIMPLEFB)
>   	{ .compatible = "simple-framebuffer" },

