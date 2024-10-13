Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3BDCF258D
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 21:10:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8342289095;
	Sun, 13 Oct 2024 23:10:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728853843;
	bh=0PQ5CbhjZv/b/V6bX69GjPmSGdKVZhsI1RcigPDZyiU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gyOWkd66z5UpSIlLNksQArc3HcXz4CXOlBnpzI6fabLV0HMKc4c8wm+kR6O06ez3L
	 AGnkmQa2HW2VqVY4hOOdoSjs8b0XwMgIDCkyTjbyHpz1NtHNBZpbFfv/qnJL38whx+
	 LjkSh6vBDtP/9hBSMOdXTvf2eEAGJdj7H6tfmxVtXWrIMX7PrjpqPUTsPVvOaZwZTr
	 /9A5LnUwiWs+z3Iv6llgl2GOln3BtVpotioZHZ3u7tQhTzqoVMJRVQplUONHvg4Lld
	 Xl341f2qtAfQQ5Q2JRX+BfIPmvKHh/Q6qRdV1KO9vxmu18gzahUwNfkewOpR8OMRu/
	 7Mb9/MPUqB9vw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 07EE589069;
 Sun, 13 Oct 2024 23:10:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728853842;
 bh=0PQ5CbhjZv/b/V6bX69GjPmSGdKVZhsI1RcigPDZyiU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=rSolQbKBiaOT+f78e2RMkUgiS02/QyxhlvsbU00vVA/qaxMq2mkE2YLKMN6zhnDT1
 9NDkMjS1canwu1kO0MLvTP71k4P8Ayzh2t107OmyNaG7w8MpJBMeGbfCq3nr+oUgQ8
 xxRcFeSCCOoV7IIt7IKarf83Ms4svWCpoElIhrf2E5rzkZbhX49VU5x4eW+1FCVFqx
 wlTK5Z+/1HC/MJj/5lkACJb651rpc/genBeNEX0NcdBCiVCyvXCYbxDFukt7Ldqpyz
 CCiCOWJK3Dmf36FJBqYwaJR7OrtBW6v2fW44+JCAtEK0+Jcxg6aAZI5zb12ZllugZi
 NUkYlJyzQ3Lyg==
Message-ID: <31e0be9e-ba50-4bc6-b07f-d20426b650be@denx.de>
Date: Sun, 13 Oct 2024 22:35:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: board: Increase rng-seed size to make it
 sufficient for modern Linux
To: Alex Shumsky <alexthreed@gmail.com>, u-boot@lists.denx.de
Cc: Ben Wolsieffer <benwolsieffer@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>, Dragan Simic <dsimic@manjaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20241013093244.817790-1-alexthreed@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241013093244.817790-1-alexthreed@gmail.com>
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

On 10/13/24 11:32 AM, Alex Shumsky wrote:
> Modern Linux requires 32 byte seed to initialize random pool, but u-boot
> currently provides only 8 bytes. Increase rng-seed size to make Linux happy and
> initialize rng pool instantly.
> 
> Boot with 8 byte rng-seed:
>      # dmesg | grep crng
>      [   12.089286] random: crng init done
> Boot with 32 byte rng-seed:
>      # dmesg | grep crng
>      [    0.000000] random: crng init done
> 
> https://github.com/torvalds/linux/blob/7234e2ea0edd00bfb6bb2159e55878c19885ce68/drivers/char/random.c#L632
> 
> Signed-off-by: Alex Shumsky <alexthreed@gmail.com>
> Fixes: d2048ba ("rockchip: board: Add board_rng_seed() for all Rockchip devices")

Fixes uses 12-character commit SHA.

> ---
> 
>   arch/arm/mach-rockchip/board.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
> index 3fadf7e412..eee75f7bcb 100644
> --- a/arch/arm/mach-rockchip/board.c
> +++ b/arch/arm/mach-rockchip/board.c
> @@ -472,7 +472,7 @@ __weak int misc_init_r(void)
>   __weak int board_rng_seed(struct abuf *buf)
>   {
>   	struct udevice *dev;
> -	size_t len = 0x8;
> +	size_t len = 32;
Let's make this override-able via environment variable, because this 
might be growing in the future again. Does this work ?

size_t len = env_get_ulong("kaslrseed_size", 10, 32);
