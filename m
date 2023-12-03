Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 921CFC46CA3
	for <u-boot@archiver.kernel.org>; Sun,  3 Dec 2023 08:50:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5ABD87554;
	Sun,  3 Dec 2023 09:50:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="OpT2d1JB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1C058757C; Sun,  3 Dec 2023 09:50:07 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFCA187158
 for <u-boot@lists.denx.de>; Sun,  3 Dec 2023 09:50:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=da6c=HO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1701593394;
 bh=UMpgaUSmMQsMsOr54t2JnDMlFj2h9X4UmJjiSK3QmJI=;
 b=OpT2d1JBp10B1DG076gJvSYsZ/Q3a2k+jy6q9LUoFYp004bXyC+0xE7K5pUderTAhbNjA4aCU
 5O7r8scTro5D9locHOAEID3vRfxjFFH/gzKdgeKWQhQzX3Mo2V6HEDk7jz0JfGMcVyCzgGQvnGB
 Un5+Le++ybsBxsDMZ+gNIpO1+siMUhk0YHXp9xT7ak/vOVBEcOi89r3Saa115riuhMp8XxnTQUA
 495IJNzbVjVJ/FU8vlGGEs6nUNibySTaLmh5gp57+AZIAZai1h4A9InJHZc3BCFdF6grFlqhcCX
 fBy7hsdgTvaXytOm5x3VFut+ujIcIlM9y0LtR/yowHCA==
Message-ID: <966886ca-3e37-4c31-bffd-64d7ccbba7e5@kwiboo.se>
Date: Sun, 3 Dec 2023 09:49:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [u-boot-gitdm PATCH 2/2] Add some more employers
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, "U-Boot Mailing List" <u-boot@lists.denx.de>
References: <20231203044719.667116-1-sjg@chromium.org>
 <20231203044719.667116-2-sjg@chromium.org>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20231203044719.667116-2-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 656c41317b241f5deffc3c2d
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

Hi Simon,

On 2023-12-03 05:46, Simon Glass wrote:
> This looks at the top unknowns:
> 
>    git log --pretty=%ae v2023.01.. |sed 's/.*@//' |sort |uniq -c |
>       sort -nr |
>    (while read count email; do
>        if ! grep -q $email u-boot-config/domain-map; then
>           echo "$count $email";
>        fi; done )
> 
> It reduces the (Unknown) count from a third to a fifth.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>  u-boot-config/domain-map | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/u-boot-config/domain-map b/u-boot-config/domain-map
> index 63cb60f..27f1a7e 100644
> --- a/u-boot-config/domain-map
> +++ b/u-boot-config/domain-map

[...]

> @@ -164,10 +175,13 @@ jmicron.com		jmicron.com
>  jp.fujitsu.com		Fujitsu
>  juniper.net		Juniper Networks
>  katalix.com		Katalix Systems
> +kernel-space.org	kernelspace
>  keymile.com		Keymile
>  keyspan.com		InnoSys
> +kwiboo.se		Kwiboo

kwiboo.se is my personal domain and I have no affiliation with kwiboo ltd.

My kwiboo nickname and the kwiboo ltd company have no affiliation, the
name conflict is purely accidental. I started using kwiboo as a nickname
from around 2005, someone unrelated registered kwiboo ltd in 2007.

All my U-Boot contributions should be affiliated with me personally and
should and cannot be affiliated with an employer.

Regards,
Jonas

>  kiethp.com		Intel
>  konsulko.com		Konsulko Group
> +kontron.de		Kontron
>  labxtechnologies.com	Lab X Technologies
>  laptop.org		OLPC
>  laurelnetworks.com	ECI Telecom

[...]
