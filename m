Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A606C0218F
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 04:58:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF67E800CF;
	Tue,  4 Feb 2025 05:58:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="j3x//6tO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C69080104; Tue,  4 Feb 2025 05:58:18 +0100 (CET)
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::af])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C808800C1
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 05:58:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexeymin@postmarketos.org
Message-ID: <28e7f700-3656-45e7-8357-516117171a2c@postmarketos.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1738645088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0btw/UWlJ1cogA4ePACH6kPxnk6/LwY7i3k4MnqNKmI=;
 b=j3x//6tOiOrKUgcCpBNu3Z1Ba+Vj5AlqvdF+zMKL5T6na2vwA2xTJ/zRkzAnxjxIkC+3Vw
 dVTqfi85LqOedvr0ht2n31S2I0k0jTs5tQKAo+ILEhovUxfvYhVKjHqzjm6W/3ifW2Zx+A
 svx/0cM25IsnUzmVqJGCoe4v0xu0YW9++YAEAmZp7wav1HdTGK66Ell1CxK5psTiYgPAXp
 PO6J5JpI9X/oaBoIt+WLqGC7qwpdlAkAtdTkIYBdajcBS3zW8IsB4G6T4h5d1Dhk5XajOE
 PoK49mlT91xZMYED5UM0QEhgCAzjGjW0hUDhZvsq81VZJW8Kn+909lGLCmTE6w==
Date: Tue, 4 Feb 2025 07:58:02 +0300
MIME-Version: 1.0
Subject: Re: [PATCH] cmd: ufetch: use 3-bit colour ANSI codes
To: Sam Day <me@samcday.com>, Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20250203-ufetch-vidconsole-colours-v1-1-a9e543ef4cde@samcday.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Alexey Minnekhanov <alexeymin@postmarketos.org>
In-Reply-To: <20250203-ufetch-vidconsole-colours-v1-1-a9e543ef4cde@samcday.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
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

On 2/3/25 7:42 PM, Sam Day wrote:
> Currently, the 8-bit escapes are being used, which aren't supported by
> vidconsole_escape_char. Since the current usage maps directly to the
> 3-bit equivalents anyway, let's use those instead.
> 
> With this change, the fetch output looks as fetching in the vidconsole
> as it does over serial!
> 
> Signed-off-by: Sam Day <me@samcday.com>
> ---
>   cmd/ufetch.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/cmd/ufetch.c b/cmd/ufetch.c
> index ed5a856c7abbe08949b81e0b2f634edd8b390be5..46bd16824e613104a0c7f5b53ef274ffb8209c17 100644
> --- a/cmd/ufetch.c
> +++ b/cmd/ufetch.c
> @@ -24,8 +24,8 @@
>   DECLARE_GLOBAL_DATA_PTR;
>   
>   #define LINE_WIDTH 40
> -#define BLUE "\033[38;5;4m"
> -#define YELLOW "\033[38;5;11m"
> +#define BLUE "\033[34m"
> +#define YELLOW "\033[33m"
>   #define BOLD "\033[1m"
>   #define RESET "\033[0m"
>   static const char * const logo_lines[] = {
> 
> ---
> base-commit: 2b1c8d3b2da46ce0f7108f279f04bc66f1d8d09a
> change-id: 20250203-ufetch-vidconsole-colours-0e6a9ebe2475
> 
> Best regards,

I can see colors on my framebuffer now, thanks!

Tested-by: Alexey Minnekhanov <alexeymin@postmarketos.org>

