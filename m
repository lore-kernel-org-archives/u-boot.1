Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02CBC4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 03:33:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E033187045;
	Thu,  9 Nov 2023 04:33:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="LDNW+HHz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 421A98714D; Thu,  9 Nov 2023 04:33:46 +0100 (CET)
Received: from mail-m17234.xmail.ntesmail.com (mail-m17234.xmail.ntesmail.com
 [45.195.17.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7C8586EA3
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 04:33:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=LDNW+HHzfAPH2fvfI9DqMqdQXjAyfhGWib0GRcYm5EuGh98WPM4a/+C+mMQ9MXmYc2czRZTtkEVWwRoBuzoCgU9K5qfxWKuSq2yocf1Jqizt6dOuFpapLXQLshHYHaxTIG6z/Ut3WofsZaoQCDcBk1uHKSEJFBVcyXcV+JjEZ6U=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=/hYLp5u4eZT6qDeMv1yWAr/KKaKgPzZ4dfvj5dbi+3Q=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id BC649400254;
 Thu,  9 Nov 2023 11:33:30 +0800 (CST)
Message-ID: <ff2d9fe1-e0aa-405e-864d-43134493a597@rock-chips.com>
Date: Thu, 9 Nov 2023 11:33:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] env: allow to copy value from default environment
 into a buffer
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: u-boot@lists.denx.de, Heiko Stuebner <heiko@sntech.de>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
References: <20231108-env_default_theobroma-v1-0-cb493bfdeffd@theobroma-systems.com>
 <20231108-env_default_theobroma-v1-1-cb493bfdeffd@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20231108-env_default_theobroma-v1-1-cb493bfdeffd@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ01PQ1ZDHktLHUlMGUpCTBlVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8bb224635d2eb3kusnbc649400254
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kxw6Egw6DjwwPQgwD0tOLBgw
 Sw0wCUhVSlVKTUJCTktLQ0pKQ0hJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIQk5PNwY+
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
> env_get_default suffers from a particular issue int that it can only
> return a value truncated to gd->env_buf (32) characters. This may be
> enough for most variables but it isn't for others, so let's allow users
> to provide a preallocated buffer to copy the value into instead,
> allowing for more control, though it'll still be truncated if the value
> size is bigger than the preallocated buffer.
>
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   env/common.c  |  8 ++++++++
>   include/env.h | 10 ++++++++++
>   2 files changed, 18 insertions(+)
>
> diff --git a/env/common.c b/env/common.c
> index eb1a9137953..307003099dd 100644
> --- a/env/common.c
> +++ b/env/common.c
> @@ -254,6 +254,14 @@ char *env_get_default(const char *name)
>   	return NULL;
>   }
>   
> +/*
> + * Look up the variable from the default environment and store its value in buf
> + */
> +int env_get_default_into(const char *name, char *buf, unsigned int len)
> +{
> +	return env_get_from_linear(default_environment, name, buf, len);
> +}
> +
>   void env_set_default(const char *s, int flags)
>   {
>   	if (s) {
> diff --git a/include/env.h b/include/env.h
> index 430c4fa94a4..9a406de3781 100644
> --- a/include/env.h
> +++ b/include/env.h
> @@ -348,6 +348,16 @@ int env_import_redund(const char *buf1, int buf1_read_fail,
>    */
>   char *env_get_default(const char *name);
>   
> +/**
> + * env_get_default_into() - Look up a variable from the default environment and
> + * copy its value in buf.
> + *
> + * @name: Variable to look up
> + * Return: actual length of the variable value excluding the terminating
> + *	NULL-byte, or -1 if the variable is not found
> + */
> +int env_get_default_into(const char *name, char *buf, unsigned int len);
> +
>   /* [re]set to the default environment */
>   void env_set_default(const char *s, int flags);
>   
>
