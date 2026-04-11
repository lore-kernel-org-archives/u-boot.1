Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5747F3ED5C
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 19:40:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF69884154;
	Sat, 11 Apr 2026 21:40:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="RW0PfUhz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BFCD8416F; Sat, 11 Apr 2026 21:40:20 +0200 (CEST)
Received: from mail.kernel-space.org (unknown
 [IPv6:2a03:4000:b:d08:14a9:1bff:fedc:75ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ABB984118
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 21:40:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1775936416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yVu3b7dmLO/HBV7udXHQtd9SF/qs0o67vID4jFM7SpQ=;
 b=RW0PfUhzOTW7ZGLIct7cNN7bdDYboGCXcPsjbqpvbdAlnLDmCoJY9Vpfzqfjy1oguFV1X+
 o0Al0Z85mxZ1Iurv9LJOjuXgQ4nkkmcL+XyM51R2CJpnPZa2cJHOvt0F4+KlN5r54pn192
 O95sQDr9uw1HPKh3wxlMYOW5+ix+cl4=
Received: from [IPV6:2a07:7e81:7daa:0:62cf:84ff:feee:627] (<unknown>
 [2a07:7e81:7daa:0:62cf:84ff:feee:627])
 by oreshnik (OpenSMTPD) with ESMTPSA id 5339ce76
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Sat, 11 Apr 2026 19:40:16 +0000 (UTC)
Message-ID: <9889b0a1-d9db-45db-b51c-48fdd16f1784@kernel-space.org>
Date: Sat, 11 Apr 2026 21:40:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] sysreset: qemu virt: Use __raw_writel()
To: Daniel Palmer <daniel@thingy.jp>, visitorckw@gmail.com, bmeng.cn@gmail.com
Cc: u-boot@lists.denx.de
References: <20260408220928.3328551-1-daniel@thingy.jp>
 <20260408220928.3328551-2-daniel@thingy.jp>
Content-Language: en-US, it
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <20260408220928.3328551-2-daniel@thingy.jp>
Content-Type: text/plain; charset=UTF-8
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

Reviewed-by: Angelo Dureghello <angelo@kernel-space.org>

On 4/9/26 00:09, Daniel Palmer wrote:
> The virt ctrl register seems to be native endian, currently this driver
> uses writel(), which works by luck because its currently broken on m68k.
> 
> Use __raw_writel() instead to avoid breaking this driver when the
> endianness of writel() is fixed.
> 
> Signed-off-by: Daniel Palmer <daniel@thingy.jp>
> Acked-by: Kuan-Wei Chiu <visitorckw@gmail.com>
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

-- Angelo

