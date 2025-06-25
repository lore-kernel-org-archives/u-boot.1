Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED182C77B7C
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 02:18:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E37A82B18;
	Wed, 25 Jun 2025 04:18:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB0AD82C84; Wed, 25 Jun 2025 04:18:26 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 730D782977
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 04:18:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [98.97.61.206])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 81A62B4D0131;
 Wed, 25 Jun 2025 04:18:22 +0200 (CEST)
Message-ID: <824349e2-ada2-4859-a8cf-9f997d0fffd7@freeshell.de>
Date: Tue, 24 Jun 2025 19:18:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] common/spl: Revert fix potential out of buffer access
 in spl_fit_get_image_name function
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Sam Edwards <cfsworks@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 u-boot@lists.denx.de
References: <20250624153431.46986-1-heinrich.schuchardt@canonical.com>
 <20250624153431.46986-2-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250624153431.46986-2-heinrich.schuchardt@canonical.com>
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



On 6/24/25 08:34, Heinrich Schuchardt wrote:
> The change in commit 3704b888a4ca ("common/spl: fix potential out of buffer
> access in spl_fit_get_image_name function") led to function
> spl_fit_get_image_name() no longer detecting if a property does not exist
> at a non-zero buffer.
> 
> Link: https://lore.kernel.org/u-boot/38f5d078-3328-4bdb-9c95-4fb5fe89ddc2@gmx.de/T/#m59f3a23e675daa992c28d12236de71cae2ca2bb9
> Fixes: 3704b888a4ca ("common/spl: fix potential out of buffer access in spl_fit_get_image_name function")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  common/spl/spl_fit.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> index b3824af475f..e250c11ebbd 100644
> --- a/common/spl/spl_fit.c
> +++ b/common/spl/spl_fit.c
> @@ -86,12 +86,11 @@ static int spl_fit_get_image_name(const struct spl_fit_info *ctx,
>  
>  	str = name;
>  	for (i = 0; i < index; i++) {
> -		str = memchr(str, '\0', name + len - str);
> -		if (!str) {
> +		str = strchr(str, '\0') + 1;
> +		if (!str || (str - name >= len)) {
>  			found = false;
>  			break;
>  		}
> -		str++;
>  	}
>  
>  	if (!found && CONFIG_IS_ENABLED(SYSINFO) && !sysinfo_get(&sysinfo)) {

Tested-by: E Shattow <e@freeshell.de>
