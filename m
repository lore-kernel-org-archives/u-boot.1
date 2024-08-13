Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0538C52D7C
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 07:39:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D42A8896C;
	Tue, 13 Aug 2024 09:39:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="i3XGZa6d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9CF088971; Tue, 13 Aug 2024 09:39:28 +0200 (CEST)
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk
 [188.40.203.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1828488969
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 09:39:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=codethink.co.uk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ben.dooks@codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JtfvmVz+uEPCLDKV7zFHrIy9hHAV+n5NQGUZ1FJ65H8=; b=i3XGZa6dYQ9bEpm+9yqHJ/MYMX
 skokmEmAEfGOFs/JbfjdnxlrXTB+uvWEWloITiptw63uGpxhDB0xlv7gv/lGVveYkSVbjSOPO4l+m
 un2UpAuLEs2PI8U7U6oocx/VFC7/olNC0/6l9bXH0ALB/MfIB0l6Du8xjbAY1aYmnp1Xh5VVSQFHL
 6H3uKT1fytw1YOscMNNNYMmkjoEPDIMMnptHUdS5YQ2MMAeiQ9gsafwLFtn1MEiJbAfUPNjt3dQhd
 6GHXjh1WvYt8wmPii1K3XyRbxZej+O7Z5+dYguXDqeqWWI6KjMgKqSl0820lzXHZKDqtQahoHUPqK
 kAl4aicg==;
Received: from [63.135.74.212] (helo=[192.168.1.184])
 by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1sdm7j-00Ajwe-Q1; Tue, 13 Aug 2024 08:39:21 +0100
Message-ID: <14c1d54f-fdd6-431e-8ff9-17dfdcc35d55@codethink.co.uk>
Date: Tue, 13 Aug 2024 08:39:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] riscv: CONFIG_SPL_FRAMEPOINTER must depend on
 CONFIG_SPL
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Cc: u-boot@lists.denx.de
References: <20240811095109.59526-1-heinrich.schuchardt@canonical.com>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <20240811095109.59526-1-heinrich.schuchardt@canonical.com>
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

On 11/08/2024 10:51, Heinrich Schuchardt wrote:
> The CONFIG_SPL_FRAMEPOINTER symbol is only relevant in SPL.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Thanks for spotting

Reviewed-by: Ben Dooks <ben.dooks@codethink.co.uk>

> ---
>   arch/riscv/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index fa3b016c527..4e228a659f2 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -133,6 +133,7 @@ config FRAMEPOINTER
>   
>   config SPL_FRAMEPOINTER
>   	bool "Build SPL with frame pointer for stack unwinding"
> +	depends on SPL
>   	help
>   	  Choose this option to use the frame pointer so the stack can be
>   	  unwound if needed. This is useful for tracing where faults came

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

