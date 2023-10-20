Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16DF4CDB474
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 06:14:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 189C587224;
	Fri, 20 Oct 2023 08:14:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697782456;
	bh=UGQHg5Sx7Ysj4OXd2rZS6iEvHuzxA+dY6oYp8RWynDE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K02eeLRGUFQP9eI3U183NAlZgqIUFkmYGOhAukvojHmxnUzvAxNMzUjonQQ/gQISJ
	 b1A7Y3TIYhEcXfIPE9mH8c4CHR8W+ZNhIJbX0v5BANJtWxWbDb+2iHQmuDDh4rYXmS
	 GmZwA5ZUI9MfwXMlhCKPSFlgqnCvwtul9fdo6Y6wpUyDGdre/TIjBaLY+YIbLBg6fu
	 mHsaAFFzVLaacKN4VZlKW7gFaJeRsGCY3yFG1C8nTfYpOsqvc8nkBpCgirHKjxMPVp
	 Kyxn6ZKFoQD47q9U7/IbGFwY8mPAbzh6RPGvQyBE2rU6geAIvGuPVdEVYkPJ3zVaRy
	 kzd3Vsv3FL9eQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id D537087253; Fri, 20 Oct 2023 08:14:13 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2D2087207
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 08:14:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4SBZ6V005xz9skv;
 Fri, 20 Oct 2023 08:14:10 +0200 (CEST)
Message-ID: <08efdf86-8617-4873-b377-7895132de107@denx.de>
Date: Fri, 20 Oct 2023 08:14:08 +0200
MIME-Version: 1.0
Subject: Re: [RESEND PATCH] arm: kirkwood: Pogo v4: Enable LTO
Content-Language: en-US
To: Tony Dinh <mibodhi@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20231016200142.21631-1-mibodhi@gmail.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20231016200142.21631-1-mibodhi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 10/16/23 22:01, Tony Dinh wrote:
> Enable building Pogo V4 u-boot image with LTO, which results in about 30K
> reduction in size.
> 
> Rebased to latest master and resend.

Nitpicking:

In such cases, please generate a v2 and put this description in the
patch history below the "---" line. No need to do this now, I'll fix
it up.

> Signed-off-by: Tony Dinh <mibodhi@gmail.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
> 
>   configs/pogo_v4_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/pogo_v4_defconfig b/configs/pogo_v4_defconfig
> index cbbade3c0c..fd62146ed3 100644
> --- a/configs/pogo_v4_defconfig
> +++ b/configs/pogo_v4_defconfig
> @@ -15,6 +15,7 @@ CONFIG_ENV_OFFSET=0xC0000
>   CONFIG_DEFAULT_DEVICE_TREE="kirkwood-pogoplug-series-4"
>   CONFIG_IDENT_STRING="\nPogoplug V4"
>   CONFIG_SYS_LOAD_ADDR=0x800000
> +CONFIG_LTO=y
>   CONFIG_PCI=y
>   CONFIG_DISTRO_DEFAULTS=y
>   CONFIG_BOOTSTAGE=y

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
