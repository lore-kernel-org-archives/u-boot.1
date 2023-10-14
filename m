Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF9ACDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:10:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26FB886F28;
	Sun, 15 Oct 2023 08:33:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qfieUsp5";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="WhGLz4Kq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B270186EB9; Sun, 15 Oct 2023 08:31:39 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8214D86ED1
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:30:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4S7DXf1c7yz9sRx;
 Sat, 14 Oct 2023 21:51:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697313106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MqB3nXf9QzKCpzc36FF+HrU2enPmeRxni322NezH98c=;
 b=qfieUsp5nBWKK3lPSokJOBwodzlD1D4I8ms2Co4tN/2udonV4/fONsW/1KxLhA8Z1zqZw5
 FEU2YnjNRvGzvYvDv+HPVrMyi2nTuIq3lIQk/Rr2c0H+dol6WswMv9N2ruGFNTE7YjFZdV
 NedP9RIk29ZKWs4myreMvb+a+EZ9hIBj3PppyqBvwyhRWAVLJ8G1dYOj97FA5bo9OCBGW2
 YTH3B86TK5qJLrvcJm197WD0QNs9F9oV/cKd94KjIhdWSWf2V50+xFHQm9JP2nvhPTR1zY
 Ag6wg8Fw/r3O39ZfJiFM928aQGLMX6NiD0WoYzsX8S5zetKiBD/ea9gkg7wMzA==
Message-ID: <163b17c9-2a90-43e7-b792-50d28f47a8af@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697313104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MqB3nXf9QzKCpzc36FF+HrU2enPmeRxni322NezH98c=;
 b=WhGLz4KqZDkDDuvombgguJzbICI5nw+Mga9NteNATdNbBpmZWOJgPKeY57zTKwqTAkyG8y
 9q7qBZWg3eYgv/6Y+vTdmFD9Mg98zFE71Dg96K/Jm3d7dasGwQq59FzsD7KwqAdBDX98x0
 6TkEYxydTcxtb2lzP9/kbWUD4lddMqEQCCoUqcJaX8bzpwCpUmAzVQSzQj1Wuc/sZnC7Eq
 +mRqy+Zz/Q2T5gS3gnWtJ1kYHaCaeRrmpFAkPYIkBgfmNJpu5pYCJrGv0M7RKaX7jUB3YI
 0NgXPgBw//SeRvguIT4nAd8B8Pf8rlrBUuyWLRnTKy94jLd9qIZd8UKvVo+cfg==
Date: Sat, 14 Oct 2023 21:51:41 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 09/19] cmd: gpio: Skip output on -ENOENT
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham
 <hai.pham.ud@renesas.com>, Simon Glass <sjg@chromium.org>
References: <20231009164645.164464-1-paul.barker.ct@bp.renesas.com>
 <20231009164645.164464-10-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20231009164645.164464-10-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 67b2128a804a896bda4
X-MBO-RS-META: ufh7jfpymdud44cf7ut6krrb64j81ran
X-Rspamd-Queue-Id: 4S7DXf1c7yz9sRx
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

On 10/9/23 18:46, Paul Barker wrote:
> On the Renesas RZ/G2L SoC family, valid GPIO numbers are not contiguous.
> This is determined by the device tree, where a fixed number of bits are
> used for the 'pin' number within a 'port', even though not all ports
> have the same number of pins. The device tree can't be changed here
> without breaking backwards compatibility in Linux, which we don't want
> to do.
> 
> To avoid printing a status for each of these invalid GPIO numbers when
> a user executes `gpio status -a`, we allow gpio_get_function() to return
> -ENOENT when the given offset does not refer to a valid GPIO pin and we
> skip printing anything if this occurs.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---
> v1->v2:
>    * New patch to simplify `gpio status -a` output.
> 
>   cmd/gpio.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/cmd/gpio.c b/cmd/gpio.c
> index f4565982ecd9..a55d5970765b 100644
> --- a/cmd/gpio.c
> +++ b/cmd/gpio.c
> @@ -17,6 +17,7 @@
>   #endif
>   #include <asm/gpio.h>
>   #include <linux/err.h>
> +#include <dm/device_compat.h>
>   
>   __weak int name_to_gpio(const char *name)
>   {
> @@ -69,6 +70,8 @@ static void gpio_get_description(struct udevice *dev, const char *bank_name,
>   	printf("%s\n", buf);
>   	return;
>   err:
> +	if (ret == -ENOENT)
> +		return;
>   	printf("Error %d\n", ret);

You could do:

if (ret != -ENOENT)
   printf("Error %d\n", ret);

With that fixed:

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
