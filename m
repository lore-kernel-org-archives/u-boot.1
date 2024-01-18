Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910A0C47422
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 13:58:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB8808798D;
	Thu, 18 Jan 2024 14:58:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53CB087B92; Thu, 18 Jan 2024 14:58:11 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 5D67386F67
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 14:58:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A98221042;
 Thu, 18 Jan 2024 05:58:53 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCFE73F73F;
 Thu, 18 Jan 2024 05:58:06 -0800 (PST)
Date: Thu, 18 Jan 2024 13:58:04 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Cc: <j@jannau.net>, Anatolij Gustschin <agust@denx.de>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon
 Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH RFC 1/6] lib: charset: Fix utf8_to_utf32_stream() return
 value doc string
Message-ID: <20240118135804.3c3abd3b@donnerap.manchester.arm.com>
In-Reply-To: <20240117-vidconsole-utf8-uefi-v1-1-539f7ce74fb9@jannau.net>
References: <20240117-vidconsole-utf8-uefi-v1-0-539f7ce74fb9@jannau.net>
 <20240117-vidconsole-utf8-uefi-v1-1-539f7ce74fb9@jannau.net>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Wed, 17 Jan 2024 23:24:27 +0100
Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org> wrote:

> From: Janne Grunau <j@jannau.net>
> 
> The comment appears to be copied from utf8_to_cp437_stream() but was not
> updated.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  include/charset.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/charset.h b/include/charset.h
> index 44034c71d3..714382e1c1 100644
> --- a/include/charset.h
> +++ b/include/charset.h
> @@ -328,7 +328,7 @@ int utf8_to_cp437_stream(u8 c, char *buffer);
>   *
>   * @c:		next UTF-8 character to convert
>   * @buffer:	buffer, at least 5 characters
> - * Return:	next codepage 437 character or 0
> + * Return:	next Unicode code point or 0
>   */
>  int utf8_to_utf32_stream(u8 c, char *buffer);
>  
> 

