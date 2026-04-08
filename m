Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C9131073CA3
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 12:15:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0578583D8A;
	Wed,  8 Apr 2026 14:15:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="Va4W0UmE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EC4C8405F; Wed,  8 Apr 2026 14:15:17 +0200 (CEST)
Received: from mail.kernel-space.org (unknown
 [IPv6:2a03:4000:b:d08:14a9:1bff:fedc:75ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EDA8838BB
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 14:15:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1775650514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=prxLZKqqkiOx3B83xA+nQsATVmWUU4oDCUNE/bUAqDU=;
 b=Va4W0UmE854pVw7EUm2baptS2eCPFV9zGdad6K2YX4TYoYVFjt2B8XppgjeIH0gWGwqjR0
 /JJIcfeBM+TPfqLHq+7j4M9l9R/W6nKgAR7e+NXsDFPMphsaz2cyKujBk7cJsaoh6gQJKZ
 suZ89JGQE+zdOnLR1h17c3IG4SBxf7k=
Received: from [IPV6:2a07:7e81:7daa:0:62cf:84ff:feee:627] (<unknown>
 [2a07:7e81:7daa:0:62cf:84ff:feee:627])
 by oreshnik (OpenSMTPD) with ESMTPSA id a1aeccd8
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Wed, 8 Apr 2026 12:15:14 +0000 (UTC)
Message-ID: <99760ed8-b17a-4117-991a-b55e9775a5c1@kernel-space.org>
Date: Wed, 8 Apr 2026 14:15:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] sysreset: qemu virt: Use __raw_writel()
To: Daniel Palmer <daniel@thingy.jp>, visitorckw@gmail.com, bmeng.cn@gmail.com
Cc: u-boot@lists.denx.de
References: <20260406142411.2992618-1-daniel@thingy.jp>
 <20260406142411.2992618-2-daniel@thingy.jp>
Content-Language: en-US, it
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <20260406142411.2992618-2-daniel@thingy.jp>
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

Hi,

On 4/6/26 16:24, Daniel Palmer wrote:
> The virt ctrl register seems to be native endian, currently this driver
> uses writel(), which works by luck because its currently broken on m68k.
> 

Still not clear why writel should be currently broken, it works
fine in bigendian for m68k.

> Use __raw_writel() instead to avoid breaking this driver when the
> endianness of writel() is fixed.
> 
> Signed-off-by: Daniel Palmer <daniel@thingy.jp>
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

Regards,

-- Angelo

