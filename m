Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 626F1CA0FFF
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 14:39:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF8CF83855;
	Sat, 30 Aug 2025 16:39:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="NKXxowM0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 163B78384C; Sat, 30 Aug 2025 16:39:26 +0200 (CEST)
Received: from mail-m1973177.qiye.163.com (mail-m1973177.qiye.163.com
 [220.197.31.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B42958384E
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 16:39:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 21239866f
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 22:39:20 +0800 (GMT+08:00)
Message-ID: <719db069-7bc5-4f0f-afc8-1d1bcb18ed7f@rock-chips.com>
Date: Sat, 30 Aug 2025 22:39:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] rockchip: puma-rk3399: enable "env erase" command
To: u-boot@lists.denx.de
References: <20250627-tsd-eraseenv-v1-0-46b69659f879@cherry.de>
 <20250627-tsd-eraseenv-v1-4-46b69659f879@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250627-tsd-eraseenv-v1-4-46b69659f879@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a98fb6b272203afkunme14dda66408338
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSElJVktJTB8ZGE5IS08eGVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=NKXxowM0q7BavcWuISfIFJDPMea9rlGyhWvPVpADAuGo2ckn9vKLpPVZx5Ig4w065YO3J6WfHdjIubH0yEKQNgasUyyd6ubCZnT6ZSOoH1ACnQzerBVBFajkYCjJzlBd3VEljE/23xk9dUgCBoFsG4q1qRBD7Xo9acUfzf1g1yA=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=XqmJYxwLfR6SRICVWmg7qiBU2etyH0exPMJgRFuHgl8=;
 h=date:mime-version:subject:message-id:from;
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


On 2025/6/27 21:30, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> Erasing the environment to start from scratch is actually very useful
> and "env erase" is the proper way to do it instead of using "env
> default -a && env save", so let's enable support for it.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   configs/puma-rk3399_defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/configs/puma-rk3399_defconfig b/configs/puma-rk3399_defconfig
> index 4e8cee06775aa020a14c656ce2f810f38354613b..8c0bd3d83daf3d263196e25a5452b943d974be3f 100644
> --- a/configs/puma-rk3399_defconfig
> +++ b/configs/puma-rk3399_defconfig
> @@ -36,6 +36,7 @@ CONFIG_TPL_GPIO=y
>   # CONFIG_BOOTM_RTEMS is not set
>   # CONFIG_CMD_VBE is not set
>   # CONFIG_BOOTM_VXWORKS is not set
> +CONFIG_CMD_ERASEENV=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
>   CONFIG_CMD_I2C=y
>
