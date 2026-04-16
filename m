Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6733FF8A146
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 09:09:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED24C8407E;
	Thu, 16 Apr 2026 11:09:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="09bUUcJl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E40D84201; Thu, 16 Apr 2026 11:09:45 +0200 (CEST)
Received: from mail.kernel-space.org (unknown
 [IPv6:2a03:4000:b:d08:14a9:1bff:fedc:75ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 547BE83FC0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 11:09:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1776330582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aeRDyx6IvjMfdqOJOLuc1IcNRMb9lcmG3ZLQBVrrr3g=;
 b=09bUUcJl75iccu6ViOaPiNBW0QLBoYPFiA9ulJizghw28ccWQOBvAR9VaO6dWQPsPp05xT
 z97cFbnh57PqMXxnRkAqqwGnwY/6j4DmTYKw05N+w21Q0nYMVhfJ+rh/HLcNoDm7A6cyaP
 Rf8RZhcC2fEVC6LPlVe3t/ZkJq05CpA=
Received: from [IPV6:2a07:7e81:7daa:0:62cf:84ff:feee:627] (<unknown>
 [2a07:7e81:7daa:0:62cf:84ff:feee:627])
 by oreshnik (OpenSMTPD) with ESMTPSA id f5ee2fda
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 16 Apr 2026 09:09:42 +0000 (UTC)
Message-ID: <fa883334-5443-40c3-ad81-8f6d02ec64b0@kernel-space.org>
Date: Thu, 16 Apr 2026 11:09:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] virtio: cmd: Depend on VIRTIO_BLK
To: Daniel Palmer <daniel@thingy.jp>, visitorckw@gmail.com, bmeng.cn@gmail.com
Cc: sjg@chromium.org, u-boot@lists.denx.de
References: <20260413092240.3719260-1-daniel@thingy.jp>
 <20260413092240.3719260-5-daniel@thingy.jp>
Content-Language: en-US, it
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <20260413092240.3719260-5-daniel@thingy.jp>
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

On 4/13/26 11:22, Daniel Palmer wrote:
> The virtio command is calling virtio blk functions but currently
> depends on CONFIG_VIRTIO only. This means disabling CONFIG_VIRTIO_BLK
> causes the final link to fail.
> 
> Since CONFIG_VIRTIO_BLK depends on CONFIG_VIRTIO switch to depending
> on just CONFIG_VIRTIO_BLK
> 
> Signed-off-by: Daniel Palmer <daniel@thingy.jp>
> ---
>  cmd/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 7bbeaad04ff4..7c86164ddb20 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1863,8 +1863,8 @@ config CMD_PVBLOCK
>  
>  config CMD_VIRTIO
>  	bool "virtio"
> -	depends on VIRTIO
> -	default y if VIRTIO
> +	depends on VIRTIO_BLK
> +	default y if VIRTIO_BLK
>  	help
>  	  VirtIO block device support
>  

-- Angelo

