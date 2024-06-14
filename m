Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF0CC27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 09:07:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3BE78899D;
	Fri, 14 Jun 2024 11:07:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Nxofyj19";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 428288899D; Fri, 14 Jun 2024 11:07:13 +0200 (CEST)
Received: from mail-m32105.qiye.163.com (mail-m32105.qiye.163.com
 [220.197.32.105])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D583D8899F
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 11:07:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Nxofyj19oiDWK+xDSx9ZQ3IA8m3Exx3OMuRqGbLmHgF2Ev/jxo/lF/4FAoLgFyX7XaE20vKTLcmHG4bSzkuRsqYjQ+z/et3ovDYQE2XZC+/kVgQkV/6jkYOa/eeNNqnFYRis7y43CdBMMI/aPhLfnajlgQJaxtwggr00ITllOyA=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=e2H2/kSG1YYCvR0e8c+BaWXYCvMXbH5IIN+LD3E2Dqs=;
 h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 816B39006BD;
 Fri, 14 Jun 2024 17:06:59 +0800 (CST)
Message-ID: <29adabea-9b21-4f80-9171-c21a46bb05b3@rock-chips.com>
Date: Fri, 14 Jun 2024 17:06:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: mkimage: fix mkimage -l for header v1
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20240606-rkcommon-dumpimage-mkimage-v1-1-018515731e86@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240606-rkcommon-dumpimage-mkimage-v1-1-018515731e86@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaHU5LVk1OSB4eTUtDGBlPGFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a9016000d2c03a9kunm816b39006bd
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OC46TDo6QjNOFhQoMBcXLA5O
 SFEKFDRVSlVKTEpDSE5NS0lKSkNJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUlDTU03Bg++
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


On 2024/6/6 19:44, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> There are two paths to reach this function, either through mkimage -l or
> through dumpimage -l. The latter passes a NULL imagename while the
> former passes an empty string. Therefore, let's make both tools behave
> the same by handling the empty string the same way as for NULL.
>
> Without this, the only way to get some information out of mkimage -l is
> to provide "-n rk3399" for example, which isn't documented in the usage
> of the tool.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   tools/rkcommon.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/rkcommon.c b/tools/rkcommon.c
> index 12c27b34eaa..3e52236b15a 100644
> --- a/tools/rkcommon.c
> +++ b/tools/rkcommon.c
> @@ -470,7 +470,7 @@ int rkcommon_verify_header(unsigned char *buf, int size,
>   	 * If no 'imagename' is specified via the commandline (e.g. if this is
>   	 * 'dumpimage -l' w/o any further constraints), we accept any spl_info.
>   	 */
> -	if (params->imagename == NULL)
> +	if (params->imagename == NULL || !strlen(params->imagename))
>   		return 0;
>   
>   	/* Match the 'imagename' against the 'spl_hdr' found */
>
> ---
> base-commit: 4b992573b34b1586e323e27b177680a6efec1c76
> change-id: 20240606-rkcommon-dumpimage-mkimage-58610cf07340
>
> Best regards,
