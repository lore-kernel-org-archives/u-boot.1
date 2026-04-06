Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00DBDF46C5B
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 16:57:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C5B383C2B;
	Mon,  6 Apr 2026 18:57:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jJiWKVOG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 611A983E36; Mon,  6 Apr 2026 18:57:11 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75B2D8352B
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 18:57:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2ab232cc803so17756145ad.3
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 09:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775494627; x=1776099427; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nORY9EwTObdVhm6FvnxORDXTi9VYi7k126ggTvow9Jg=;
 b=jJiWKVOGVIQVS51Ul0b8735EIKLMc32u1xAl/vpFD+AnPOixHb1iksqJGZ0kYtsxR0
 mOpchFg6vYnCQI9WhTzhNP1cNXPIkbezUXWemA/q4wHCvw++siqcDL/wGCe+4DSh6yFO
 a52ZurYwq65Fp/YTUsRoCOod2vS6qCu5oC2CwvlzipTdzP3U31o8cUCnKpsGlSqN4XrQ
 KQA/+Znb9IejGJZDlTYKRMGs+geOg9fSjSj1PL97aQSnxyfI+aWVSII+2zsFE1PXfe2X
 wTvmfnrCrwroZggCmHF1BAH3lGTBcgUIA8C7NV97mm4RqwEqP0t9SYusTjmmV0yz5DmG
 nRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775494627; x=1776099427;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nORY9EwTObdVhm6FvnxORDXTi9VYi7k126ggTvow9Jg=;
 b=G37ajCyoEOgStE3TgfoSL18vK63gcgVobpymAf/e4vklwsfXOcHtiQkKTQZ7Bk7OOx
 5ejQ92sJknaYlXCP0o5/u8PvIu50xfGIJLoBFJB8eJa7u/Otg2Kkugu2j+Arah3nWFyF
 CHlkPV66oQSMOPR7MuGpGlUzJcZ77nCP3M/BSDOaPFMwKtpSF9soO+GNQJFWxq0pTjTH
 xrO+X5akHRPkk2CejcqIBixXl8T0Z6qZYL/26+StU/Vz3PQvk0sllBAdcPUX2+hHopxM
 C7DUYmniOG35YY7ZTq8dxomyiKfiud4hL6ARuERIun3aLXc05HGR7VSMvsyw1ErT3WdX
 UfeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYYeHpVNSgGPG4ic7jE5LBZP/+nunhg7hB8VUWQmEHze5K2GwLPGbsu9jVIlzmGJI/RPmHmAM=@lists.denx.de
X-Gm-Message-State: AOJu0YzxkLd77GO7EKx8pkNST/yFjuH9q4S2d71ZY/4Y3R1l5IXBj3Gq
 pshEwGfSnnLViUEGvDEArnUylWw8UwFSR4O94qjl3PE/9+HY5d6hsY4U
X-Gm-Gg: AeBDieup+HrO7w0r6DYIwFyXZ3Fbc3HqO3u7MaVLZS0ytv28r55rBv9/mfWZlrb9xDl
 N9fWgzJCCK6MManK9v5tfrGONb11AIFcF8emPvRHmF10YeCalE9IeiQvdI5Fl0QU9IQm4l3Nqg7
 WYDsoiM3ZA0xCOd0AFy7SlvDf9xBw7fcvET+d+N9vztaRM4RzsvEz5Y5urfZSrhdLUVgPzUj2iz
 hDqw6kN2xtI260xh7E2Mi2KAkFy7Srwksf/JF7JiYlrgeJQInQUGrR7crOhqW7rGIUfPFTzRSmV
 v1vBOOvhHpXL+3mFEkONcsZBaOVSYz7DvUVzmIhwGkqkkk8MHVWLPzn1Ke0d5r8MUojcGu6vmWk
 zN0U2wTE9PZBv+O295sDkeOzLUV2BRmDaGtq5I4xMNIIAJ9ZEQ2VIxkIGs6wvhhxLFj/Q6jZs+c
 qRlMEOf8gIZnrZBQP2/U/O7tdB3yvMhqUHU0tYMI6NLnZp5H5Qp40F4O6rmLl6m8qv
X-Received: by 2002:a17:903:1b63:b0:2b0:4ec8:fb92 with SMTP id
 d9443c01a7336-2b2818e0eaamr144661095ad.39.1775494626902; 
 Mon, 06 Apr 2026 09:57:06 -0700 (PDT)
Received: from google.com (61-230-33-2.dynamic-ip.hinet.net. [61.230.33.2])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749a3a0fsm194255805ad.59.2026.04.06.09.57.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 09:57:06 -0700 (PDT)
Date: Tue, 7 Apr 2026 00:57:03 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Daniel Palmer <daniel@thingy.jp>
Cc: angelo@kernel-space.org, bmeng.cn@gmail.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/5] sysreset: qemu virt: Use __raw_writel()
Message-ID: <adPl33dlbOFxQifT@google.com>
References: <20260406142411.2992618-1-daniel@thingy.jp>
 <20260406142411.2992618-2-daniel@thingy.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406142411.2992618-2-daniel@thingy.jp>
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

On Mon, Apr 06, 2026 at 11:24:07PM +0900, Daniel Palmer wrote:
> The virt ctrl register seems to be native endian, currently this driver
> uses writel(), which works by luck because its currently broken on m68k.
> 
> Use __raw_writel() instead to avoid breaking this driver when the
> endianness of writel() is fixed.
> 
> Signed-off-by: Daniel Palmer <daniel@thingy.jp>

Acked-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Regards,
Kuan-Wei

> ---
>  drivers/sysreset/sysreset_qemu_virt_ctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/sysreset/sysreset_qemu_virt_ctrl.c b/drivers/sysreset/sysreset_qemu_virt_ctrl.c
> index e7cacc9b6e98..5ab16001922b 100644
> --- a/drivers/sysreset/sysreset_qemu_virt_ctrl.c
> +++ b/drivers/sysreset/sysreset_qemu_virt_ctrl.c
> @@ -38,7 +38,7 @@ static int qemu_virt_ctrl_request(struct udevice *dev, enum sysreset_t type)
>  		return -EPROTONOSUPPORT;
>  	}
>  
> -	writel(val, plat->reg + VIRT_CTRL_REG_CMD);
> +	__raw_writel(val, plat->reg + VIRT_CTRL_REG_CMD);
>  
>  	return -EINPROGRESS;
>  }
> -- 
> 2.51.0
> 
