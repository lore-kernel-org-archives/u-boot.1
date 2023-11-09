Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC19BC4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 03:33:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 590AF87193;
	Thu,  9 Nov 2023 04:33:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="XYtnmMCe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C617186EA3; Thu,  9 Nov 2023 04:33:52 +0100 (CET)
Received: from mail-m25479.xmail.ntesmail.com (mail-m25479.xmail.ntesmail.com
 [103.129.254.79])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3FB08714F
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 04:33:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=XYtnmMCerEXlXMTNQOoLTJqwljW9Q6DlU6N9McR7gnl6gsmiLM8foWU0FBhQlzuvsXqj4Q66+4IHylmxtemes8WlI4/bPV24dKSLA+nYkhjOcWqa9tnIwMAJphr/xjdcS1zNwgQ+KByM9N72EeCaR8ui7sGso8mDBXnGAQKMTmI=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=QUvqqGMp8No+WAgyZ6GP7UWq8G1oThOhAGDGxUODkiE=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id BD9014002E3;
 Thu,  9 Nov 2023 11:33:39 +0800 (CST)
Message-ID: <ded05265-79fa-4c05-a6a1-2b99870603ee@rock-chips.com>
Date: Thu, 9 Nov 2023 11:33:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] env: migrate env_get_default to call
 env_get_default_into
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: u-boot@lists.denx.de, Heiko Stuebner <heiko@sntech.de>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
References: <20231108-env_default_theobroma-v1-0-cb493bfdeffd@theobroma-systems.com>
 <20231108-env_default_theobroma-v1-2-cb493bfdeffd@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20231108-env_default_theobroma-v1-2-cb493bfdeffd@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0pPSFZOHh9IHkgZTBlITE5VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8bb22486d52eb3kusnbd9014002e3
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nio6MAw6FTw6EwgiNUssLBEQ
 OBwaCk9VSlVKTUJCTktLQ0lLTEpKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJQkxKNwY+
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
> Since both functions share a similar goal and env_get_default_into can
> do what env_get_default wants to do with specific arguments, let's make
> env_get_default call env_get_default_into so as to avoid code
> duplication.
>
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   env/common.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/env/common.c b/env/common.c
> index 307003099dd..930bdef2f58 100644
> --- a/env/common.c
> +++ b/env/common.c
> @@ -246,9 +246,11 @@ bool env_get_autostart(void)
>    */
>   char *env_get_default(const char *name)
>   {
> -	if (env_get_from_linear(default_environment, name,
> -				(char *)(gd->env_buf),
> -				sizeof(gd->env_buf)) >= 0)
> +	int ret;
> +
> +	ret = env_get_default_into(name, (char *)(gd->env_buf),
> +				   sizeof(gd->env_buf));
> +	if (ret >= 0)
>   		return (char *)(gd->env_buf);
>   
>   	return NULL;
>
