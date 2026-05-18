Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF3DCD4F4A
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 17:46:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11DA883AA9;
	Mon, 18 May 2026 19:46:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JbMdL4GS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D60884119; Mon, 18 May 2026 19:46:17 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42A0F80433
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 19:46:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3665a90bcd3so2652850a91.1
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 10:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779126374; x=1779731174; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ONkqcGlC7W1q9mTHVzWfKwkoYYxR8DYIw/ng7Df7BoQ=;
 b=JbMdL4GSKLcIhjxrJlkqFYuqN+NYwCxcfCxpig/+34OA/4nturSw7DJcp5d94efjz9
 l7oE8l1E5oXwt2l3I2AyQadMF5qMlPzrfmmyNXPZlzgYWb4kB/oFi8sqA0XZkgyetz2f
 +oHHxqYNQrtADeuZnua/LbAC/BdHB2tJgDR1pwZOCwupnWZndqnuH9EiejWraosCvzdo
 m3q777FA/vvQiTw9KnTlfnwHdXL35AUx/TLiYJ5NYx81r3i5I0X9mVaAaUab8l9rrhBY
 94pCzP8wVCp6ZGQWPGKAjGL+mmUOzi2D+wzmOQAJylcJKYHUGbhBpBwO2Fe8in5fSAUm
 6yAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779126374; x=1779731174;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ONkqcGlC7W1q9mTHVzWfKwkoYYxR8DYIw/ng7Df7BoQ=;
 b=h3nXq4bRRZlvW7ZqmEdZb96NtFuVAT81BzGxAEReLe9IJYWnPTfKUh1iUdO5Hmn3ys
 Gb4ZRpBFA41shvL0nx7m2xa9czxgTltrWcD7/pzXRXBGu0pEA5taAS6lXTP6SiNhxNhu
 JuJRioyUHlFXb9pXG9LaJny7+UgQtW8ByvYaGj/mIqLRF9lLBy27KfM+NrHRERm+GhV9
 TjE65nc3bJ/NByYZ62/G9jjDZ544j2k3C6s0jASAqRCi0w0A2ldxGOKCUHW1N5pSS8zE
 nxE7cabZIICPtqwcFBR605LApgIGMjbMCtIbU4xDdILhsyz8HAgQEcirTfAGief4H2Lo
 w/Cg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ezP7PHTf3dxBsWsHFSqAcwzgTzFeFiZLbYJsMyt6fUTnxhVIPZyr+Dl13EMqxySMhLZCAZzs=@lists.denx.de
X-Gm-Message-State: AOJu0Yyto3SuL6SicFgYbnKib3K2Iln9yw6UNGUdZtVoDvYuF4zUdBFm
 Tz15kSwtRKZOuZPHYjbX1AdifhgRz8cGMYToWkfHfuujWHv8UTjUuR3g
X-Gm-Gg: Acq92OGTy3r8WM/rupK59Fan1ddG7CEYsLAR44hAUrzJP8LWNzUgiMOnoUu1VrU6xZj
 jblBpD3PbpdwJDlby6G7LTC4zRpie+a/ujtI6Xf9fLGjCy/4sOx7HgnYVJT2qxeLMnKxMLZqEBj
 zHJpAajAWDrecEtKBDqG8mAQ5TWFILqqTjBVShlukA78otrVbkIRF669x81hIEqzgS8DNLFaVn8
 jGLuxSV+FFYHzsCWulnK1yXtU3o0T7eqL2xAarZ8R8qkNeAoHQHzpxOncUJNZQZFn9PNVA53CYv
 rJY1eVdGD99Ui66oQ5zzYtt8h11mZ11NF4dVYo+rEVpmaiDCkNwIViYsgeSLKF0axg5w6XHQiJ3
 TAN2iREu9A947Hhte7r3l9SnkfUqQQMe7od6BeSVptbuewG0herUc75sF9hq1rljsfymFrttHqw
 lyWiGCt6LaGuamqS3lSp2kU8wOOPlWhXN5ZQ==
X-Received: by 2002:a17:90b:270d:b0:35f:b7f5:9b3 with SMTP id
 98e67ed59e1d1-369518bae28mr16057744a91.3.1779126373597; 
 Mon, 18 May 2026 10:46:13 -0700 (PDT)
Received: from google.com ([118.150.148.19]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36970422515sm4243201a91.4.2026.05.18.10.46.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 10:46:13 -0700 (PDT)
Date: Tue, 19 May 2026 01:46:10 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Daniel Palmer <daniel@thingy.jp>
Cc: trini@konsulko.com, angelo@kernel-space.org, bmeng.cn@gmail.com,
 sjg@chromium.org, u-boot@lists.denx.de
Subject: Re: [PATCH v7 1/9] sysreset: qemu virt: Use map_sysmem()
Message-ID: <agtQF8Ain5X7mI_x@google.com>
References: <20260516074016.885146-1-daniel@thingy.jp>
 <20260516074016.885146-2-daniel@thingy.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260516074016.885146-2-daniel@thingy.jp>
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

On Sat, May 16, 2026 at 04:39:53PM +0900, Daniel Palmer wrote:
> In the platform data there is a phys_addr_t (an integer) for the address
> of the register and we pass that as-is into writel() which is fine in most
> places because we don't need to do any mapping and the macro for writel()
> does a cast to a pointer.
> 
> If writel() is a static inline function the address argument is a pointer
> so passing it in as an integer without casting it first causes warnings or
> build failure.
> 
> map_sysmem() handles the casting part and if phys_addr_t is 32bits when
> on a 64bit machine.
> 
> Signed-off-by: Daniel Palmer <daniel@thingy.jp>

Acked-by: Kuan-Wei Chiu <visitorckw@gmail.com>

> ---
>  drivers/sysreset/sysreset_qemu_virt_ctrl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/sysreset/sysreset_qemu_virt_ctrl.c b/drivers/sysreset/sysreset_qemu_virt_ctrl.c
> index e7cacc9b6e98..61b38d507fc5 100644
> --- a/drivers/sysreset/sysreset_qemu_virt_ctrl.c
> +++ b/drivers/sysreset/sysreset_qemu_virt_ctrl.c
> @@ -8,6 +8,7 @@
>  #include <dm.h>
>  #include <qemu_virt_ctrl.h>
>  #include <sysreset.h>
> +#include <mapmem.h>
>  #include <asm/io.h>
>  #include <linux/err.h>
>  
> @@ -24,6 +25,7 @@
>  static int qemu_virt_ctrl_request(struct udevice *dev, enum sysreset_t type)
>  {
>  	struct qemu_virt_ctrl_plat *plat = dev_get_plat(dev);
> +	void __iomem *reg = map_sysmem(plat->reg + VIRT_CTRL_REG_CMD, 0x4);
>  	u32 val;
>  
>  	switch (type) {
> @@ -38,7 +40,7 @@ static int qemu_virt_ctrl_request(struct udevice *dev, enum sysreset_t type)
>  		return -EPROTONOSUPPORT;
>  	}
>  
> -	writel(val, plat->reg + VIRT_CTRL_REG_CMD);
> +	writel(val, reg);
>  
>  	return -EINPROGRESS;
>  }
> -- 
> 2.53.0
> 
