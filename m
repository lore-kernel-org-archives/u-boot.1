Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F6AC4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 03:34:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C2B887045;
	Thu,  9 Nov 2023 04:34:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="gAfxRuqQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D70098724E; Thu,  9 Nov 2023 04:34:25 +0100 (CET)
Received: from mail-m17241.xmail.ntesmail.com (mail-m17241.xmail.ntesmail.com
 [45.195.17.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF862871A2
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 04:34:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=gAfxRuqQTtleUw4tTSmHRNSA/cjlkLwQ7jovhGEqvIqz6BysfAoEaYWB+/UqOEKd4edph21TJdkVDbLE5uf7D4l0WqpDxO2ykWvqT005Nbqvfk/j43ncnhvJw2vDc0H8JYCLyHbdbdl2VuImZu3mKytfQnhufox8HE+OvCgom+A=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=jwBX8qDAjzU6Yvm+4bpKiqrmDFIWCdvzw2J1WcbpIWs=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 05BBF400341;
 Thu,  9 Nov 2023 11:34:09 +0800 (CST)
Message-ID: <61fddeee-d9c6-45ce-9843-0c4020baef3d@rock-chips.com>
Date: Thu, 9 Nov 2023 11:34:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] rockchip: ringneck-px30: fix modified boot_targets
 detection
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: u-boot@lists.denx.de, Heiko Stuebner <heiko@sntech.de>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
References: <20231108-env_default_theobroma-v1-0-cb493bfdeffd@theobroma-systems.com>
 <20231108-env_default_theobroma-v1-6-cb493bfdeffd@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20231108-env_default_theobroma-v1-6-cb493bfdeffd@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUxPSlZPSB8ZQxlNHkpLTEhVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8bb224fc632eb3kusn05bbf400341
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Oi46NDo5KzwwSAg4H0g6TC85
 IlEaCx5VSlVKTUJCTktLQ05LQ09CVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPSUtLNwY+
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


On 2023/11/8 22:20, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> U-Boot proper automatically modifies boot_targets to swap the order in
> which MMC storage media are used for standard boot based on which MMC
> storage medium was used to load U-Boot proper. This is however only done
> if the user has not changed it manually, therefore a check between the
> default and current value is done.
>
> This used to work fine until the migration to standard boot where
> boot_targets value size in the default environment went above the 32
> characters that env_get_default function can return, thus resulting in a
> truncated variable.
>
> Therefore the check between default and current value would always fail.
>
> By using the newly added env_get_default_into function, a buffer of
> the appropriate size can be allocated on the stack to get the whole
> value of boot_targets in the default environment and thus fixing the
> check.
>
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   board/theobroma-systems/ringneck_px30/ringneck-px30.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/board/theobroma-systems/ringneck_px30/ringneck-px30.c b/board/theobroma-systems/ringneck_px30/ringneck-px30.c
> index dd711cd05de..2bce8147eeb 100644
> --- a/board/theobroma-systems/ringneck_px30/ringneck-px30.c
> +++ b/board/theobroma-systems/ringneck_px30/ringneck-px30.c
> @@ -39,7 +39,9 @@ static int setup_boottargets(void)
>   {
>   	const char *boot_device =
>   		ofnode_read_chosen_string("u-boot,spl-boot-device");
> -	char *env_default, *env;
> +	char env_default[sizeof(BOOT_TARGETS)];
> +	char *env;
> +	int ret;
>   
>   	if (!boot_device) {
>   		debug("%s: /chosen/u-boot,spl-boot-device not set\n",
> @@ -48,7 +50,10 @@ static int setup_boottargets(void)
>   	}
>   	debug("%s: booted from %s\n", __func__, boot_device);
>   
> -	env_default = env_get_default("boot_targets");
> +	ret = env_get_default_into("boot_targets", env_default,
> +				   sizeof(env_default));
> +	if (ret < 0)
> +		env_default[0] = '\0';
>   	env = env_get("boot_targets");
>   	if (!env) {
>   		debug("%s: boot_targets does not exist\n", __func__);
>
