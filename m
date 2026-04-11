Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FEECF3ED4F
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 14:38:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 056758418C;
	Sat, 11 Apr 2026 16:38:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Mq16fKMs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 300678418C; Sat, 11 Apr 2026 16:38:44 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DDFB84118
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 16:38:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b9c603ec2dfso401502866b.1
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 07:38:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775918322; cv=none;
 d=google.com; s=arc-20240605;
 b=cTIZ0x+ZfFt+NYhCvJto93Os08tmb1eAy6JMJuG3KFJcTvovT6E54AcQhUukLINfan
 I95lnGcyc/EN8szbsmVuXQ6Z9H4g/qSpfEfUO/yM/3nDVrOILs0vbIw8jm4VNmz1Qsaa
 t2E4aURctPcJc1BWGtNuxR8iFgHcsdDcCHqqO+C9+hxUUGfLx82ruSGLeoIjZpaiDcZz
 Prk5GC5C27uzeAikkXargNZqyVy/9LCOqX0dhWqT5AwO3pyQvAVSDWAX276IV0tmDdKN
 4onXwnQgKRfmg7F/JPbJfCW9yn1uku2xdKC6Ngh1Ue/3GzPPtqvdGyt2hM/GBLYAlhwX
 nEpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tmXmYgTL6I2yJOgGmiJDb7eeld9y1OiO1XPT9lD71u8=;
 fh=c4Qxnrfi+zjVDWxlBXX5J0aUAQLmjgnuzKwcVLmdacY=;
 b=b6xo/V+1ADwtfpmHpO5mtjnQ0vxLLpmIv94Lhj9dXueMQSFO65gzCwqd9zNErXx5IG
 Ib2dApsV1ARcuNI/XWp2U4wkgNGIA784N6wxmNpBCQpO560/1BWl0TG9K9cOOIvaMI+R
 r6jPvx4GrK58atKi7LXQnNJfhidoVLzfNlUK8C9UdLEZbo9MjUTarWbtb7KxMiCxrbCG
 2Di0YOqyfyAQhBm8RQdPZXccsq/EORS+1jbtUA05SJKyu7vXqwcsTclKkSbgVs1287FU
 sEhjmwwZgxBAjsqHJ8+T83dWZhjycupeC9m3MRIo9WQ7k8IuRES34qE94bHvhDwmqeaf
 4deQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775918322; x=1776523122; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tmXmYgTL6I2yJOgGmiJDb7eeld9y1OiO1XPT9lD71u8=;
 b=Mq16fKMsmughXKsadgM8OVEgA2KUrH4OetmUa1tcjU9ICw0/XLk5on0FucaZKoa8mK
 CTLj4GnnY2bnWi9s/5Zvm9WInWGsNdML+i7X/DbgcbE9zIJ6n2akIi0BO9PNwTgj+q3z
 lAEREKvlHo1ZYDpk5ynKzg3ApONnKd4/XUnNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775918322; x=1776523122;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tmXmYgTL6I2yJOgGmiJDb7eeld9y1OiO1XPT9lD71u8=;
 b=ImV/XBwsPu4eEc54KaPGiml33L8uLGcirwv9VPhIAJJN/LZvI/9N5uR3bMMOSflX2u
 WPedhYOGwxAifK8mhJ2iNA/QR1fBw3Lh6eX1iTffwcfBlmLN6dPzYxRH12xZ4UzoXT7r
 dvNEc0mAVXXHmlgloi37xF1nH1E5LMo+i5oO07eb3EY178pP/3yWmVaUlSci3Rv9H6Bw
 TQTkvhg06pljUTo5jJ154zcDw7uLY59p6rrAZU+Z6XZMX35MXUgiGUCRWUh1yXfRkyYJ
 aM33cpvzj/xsSFd+rmYZLJ1Af0QqXv0vHbDQHVmX5+GMH3C5swsXfVxGl/5pyAl/0Em8
 lhmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjVwWM5SgHEX19Us9aZLexTiPPrtP5rPFPzZ+JLE0ZK5BYoze/18W2Geq3BGSJNgaRI2wvUE8=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1Fk0kF60/8LVnaVR+v7enX2jtKiNwBrYd/SEN34ZCahJHftzj
 OXqLBwSfaLIZxfrBffbsviAUFjGvkjIzTLZY9XrI0WYyTgTsWcgr2350B9DrDIZFPtpWKCo3phS
 6F4HNhqOZUJNUf6yog/Cuh21ztx2dJ5ylnxaY/8gA
X-Gm-Gg: AeBDieujs+mLHCgx04av3XPRDfNhvsALL3hc3KTYS6VPeVNLntiTBY+w3UQJXFDt4q6
 3HhbJtrQ3VPDntLoqcBvx2++8CadNntyCBhL9ijOAER0wqpR75Xdnlf1GAriGlO5uTjjq0HuKaC
 acE3LbfSdop9xW+BKArqplU2UeFmxCg3iQguh8gymKVJbYTBSfDKS0XipnpM9MVyyUI44mU/DB8
 e3wUpfsWIuXFnhCRRqzScxCeWKiw6o6mIYpJ/3bUqlJTv0qHtDTNxBvHzNdLkwWnMxQRDcM0grr
 FWZELg==
X-Received: by 2002:a17:906:518a:10b0:b9b:183a:7346 with SMTP id
 a640c23a62f3a-b9d72792b8cmr292498366b.12.1775918321739; Sat, 11 Apr 2026
 07:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260405144944.41074-1-lucienzx159@gmail.com>
 <20260405144944.41074-5-lucienzx159@gmail.com>
In-Reply-To: <20260405144944.41074-5-lucienzx159@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 08:38:29 -0600
X-Gm-Features: AQROBzAb3bk0TqcyAhbAxyu_W4H7dEBMuS44ZJMzSPri61QMi716LxZeVW4ZuLM
Message-ID: <CAFLszTifgNBs+jxh1f+XxropHkKmtp27Bv7k1o3t8vDFpwehfA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] sandbox: dts: add PHY common props test nodes
To: lucienzx159@gmail.com
Cc: trini@konsulko.com, jerome.forissier@arm.com, sumit.garg@kernel.org, 
 marek.vasut+renesas@mailbox.org, vladimir.oltean@nxp.com, ericwouds@gmail.com, 
 kabel@kernel.org, frank-w@public-files.de, daniel@makrotopia.org, 
 ansuelsmth@gmail.com, mkorpershoek@kernel.org, skylake.huang@mediatek.com, 
 lucien.jheng@airoha.com, u-boot@lists.denx.de
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

Hi Lucien,

On 2026-04-05T14:49:40, Lucien.Jheng <lucienzx159@gmail.com> wrote:
> sandbox: dts: add PHY common props test nodes
>
> Add device tree test nodes to arch/sandbox/dts/test.dts for the PHY
> common properties unit tests.
>
> Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
>
> arch/sandbox/dts/test.dts | 60 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)

> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> @@ -16,6 +16,7 @@
> +#include <dt-bindings/phy/phy.h>

Are PHY_POL_NORMAL, PHY_POL_INVERT, and PHY_POL_AUTO in an upcoming
subtree merge?

Regards,
Simon
