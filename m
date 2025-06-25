Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1061C77B7F
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 02:18:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BE8D82E05;
	Wed, 25 Jun 2025 04:18:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0106082E05; Wed, 25 Jun 2025 04:18:44 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9E3382977
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 04:18:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [98.97.61.206])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 0EB9AB4D0142;
 Wed, 25 Jun 2025 04:18:36 +0200 (CEST)
Message-ID: <a8aee479-3379-4947-b388-b6fdadef8a04@freeshell.de>
Date: Tue, 24 Jun 2025 19:18:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] common/spl: guard against buffer overflow in
 spl_fit_get_image_name()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Sam Edwards <cfsworks@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 u-boot@lists.denx.de
References: <20250624153431.46986-1-heinrich.schuchardt@canonical.com>
 <20250624153431.46986-3-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250624153431.46986-3-heinrich.schuchardt@canonical.com>
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
> A malformed FIT image could have an image name property that is not NUL
> terminated. Reject such images.
> 
> Reported-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  common/spl/spl_fit.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> index e250c11ebbd..25f3c822a49 100644
> --- a/common/spl/spl_fit.c
> +++ b/common/spl/spl_fit.c
> @@ -73,7 +73,7 @@ static int spl_fit_get_image_name(const struct spl_fit_info *ctx,
>  				  const char **outname)
>  {
>  	struct udevice *sysinfo;
> -	const char *name, *str;
> +	const char *name, *str, *end;
>  	__maybe_unused int node;
>  	int len, i;
>  	bool found = true;
> @@ -83,11 +83,17 @@ static int spl_fit_get_image_name(const struct spl_fit_info *ctx,
>  		debug("cannot find property '%s': %d\n", type, len);
>  		return -EINVAL;
>  	}
> +	/* A string property should be NUL terminated */
> +	end = name + len - 1;
> +	if (!len || *end) {
> +		debug("malformed property '%s'\n", type);
> +		return -EINVAL;
> +	}
>  
>  	str = name;
>  	for (i = 0; i < index; i++) {
>  		str = strchr(str, '\0') + 1;
> -		if (!str || (str - name >= len)) {
> +		if (str > end) {
>  			found = false;
>  			break;
>  		}

Tested-by: E Shattow <e@freeshell.de>

